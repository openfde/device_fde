
device_fde="device/openfde/fde/fde_vnc"
function syncFdeApk {
 download_url=`cat ${ANDROID_BUILD_TOP}/${device_fde}/FdeVncClient`
 wget ${download_url} -O ${ANDROID_BUILD_TOP}/${device_fde}/FdeVncClient.apk
}
