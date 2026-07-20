LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := FdeSystemUI
LOCAL_SRC_FILES := BoringdroidSystemUI.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional

# 推荐加上后缀
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

# 指定安装到 system_ext 分区
LOCAL_SYSTEM_EXT_MODULE := true
# 指定安装到 priv-app 目录
LOCAL_PRIVILEGED_MODULE := true

# 重新使用平台密钥签名（如果你确定要系统重签，保持 platform；如果已签好，用 PRESIGNED）
LOCAL_CERTIFICATE := platform

include $(BUILD_PREBUILT)