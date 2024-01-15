

function syncFdeApk {
	configPath=${ANDROID_BUILD_TOP}/device/openfde/fde/fde_vnc/FdeVncClient 
	compareAndDownload  ${configPath}  ${configPath}.apk 

	configPath=${ANDROID_BUILD_TOP}/vendor/prebuilts/bdapps/bin/BoringdroidSystemUI
	compareAndDownload  ${configPath}  ${configPath}.apk 

	configPath=${ANDROID_BUILD_TOP}/device/openfde/fde/fde_gallery/FdeGallery
	compareAndDownload  ${configPath}  ${configPath}.apk 
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
