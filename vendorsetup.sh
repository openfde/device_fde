
device_fde="device/openfde/fde/fde_vnc"
function syncFdeApk {
 vnc_download_url=`cat ${ANDROID_BUILD_TOP}/${device_fde}/FdeVncClient`
 wget ${vnc_download_url} -O ${ANDROID_BUILD_TOP}/${device_fde}/FdeVncClient.apk
 systemui_download_url=`cat ${ANDROID_BUILD_TOP}/vendor/prebuilts/bdapps/bin/BoringdroidSystemUI`
 wget ${systemui_download_url} -O ${ANDROID_BUILD_TOP}/vendor/prebuilts/bdapps/bin/BoringdroidSystemUI.apk
}
