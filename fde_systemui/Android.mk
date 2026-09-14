LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# 预编译备用模块，不随 ROM 安装。PRODUCT_PACKAGES 里的 FdeSystemUI 现在由
# systemuiplugin 仓库的 Android.bp 源码编译生成；如需切回预编译 APK，把
# device.mk 中的 FdeSystemUI 换成 FdeSystemUIPrebuilt 即可。
LOCAL_MODULE := FdeSystemUIPrebuilt
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