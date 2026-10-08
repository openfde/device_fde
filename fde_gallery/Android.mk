LOCAL_PATH := $(call my-dir)

# FDE: the gallery is also provided as a source app in packages/apps/FdeGallery (module
# "FdeGallery"). Defining both makes kati fail with
#   "MODULE.TARGET.APPS.FdeGallery already defined by packages/apps/FdeGallery"
# so prefer the source app when it is part of the tree and only fall back to this prebuilt
# otherwise.
ifneq ($(wildcard $(TOPDIR)/packages/apps/FdeGallery),)
$(warning Skipping the prebuilt FdeGallery: packages/apps/FdeGallery provides it from source.)
else
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := FdeGallery
LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := FdeGallery.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
include $(BUILD_PREBUILT)
endif
