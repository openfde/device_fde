

function syncFdeApk {
	#configPath=${ANDROID_BUILD_TOP}/device/openfde/fde/fde_vnc/FdeVncClient 
	#compareAndDownload  ${configPath}  ${configPath}.apk 

	configPath=${ANDROID_BUILD_TOP}/vendor/prebuilts/bdapps/bin/BoringdroidSystemUI
	compareAndDownload  ${configPath}  ${configPath}.apk 

	configPath=${ANDROID_BUILD_TOP}/device/openfde/fde/fde_gallery/FdeGallery
	compareAndDownload  ${configPath}  ${configPath}.apk 
 
 	configPath=${ANDROID_BUILD_TOP}/device/openfde/fde/fde_provision/Provision
	compareAndDownload  ${configPath}  ${configPath}.apk
}

function applyPatch {
	#$1 = path of repo 
	echo -e "\e[34m cd $1 to apply arm64only.patch . \e[0m"
	cd $1
	git reset --hard
	patch -p 1 < arm64only.patch
	cd - 1>/dev/null
}

function resetPatch {
	echo -e "\e[34m cd $1 to reset arm64only patch . \e[0m"
	cd $1
	git reset --hard
	cd - 1>/dev/null
}
list="system/bt hardware/interfaces frameworks/av"

function Fde64onlyRestore {
	for i in $list
	do
		resetPatch $i
	done
	echo -e "\e[34m cd platform_testing to reset . \e[0m"
	cd platform_testing
	git reset --hard
	cd -  1>/dev/null 2>&1
}



function Fde64only {
	cd platform_testing
	sed -i "/resolv_gold_test.*$/d" build/tasks/tests/native_test_list.mk
	cd -  1>/dev/null 2>&1
	for i in $list
	do
		applyPatch $i
	done
}

function compareAndDownload  {
	download_url=`cat ${1} |awk  '{print $1}'`
	md5=`cat ${1} |awk '{print $2}'`
	noNeedDownload=0
	if [  -n "$md5" ];then
		if [ -e ${2} ];then
			currentMd5=`md5sum ${2} |awk  '{print $1}'`
				if [ "$currentMd5" = "$md5" ];then
					noNeedDownload=1
				fi	
		fi
	fi
	if [ $noNeedDownload -eq 0 ];then
		wget ${download_url} -O ${2}
	fi
}	
