LOCAL_PATH := $(call my-dir)

# FDE: packages/apps/FdeGallery defines the module "FdeGallery" as well, and kati rejects the
# duplicate definition:
#   error: device/openfde/fde/fde_gallery: MODULE.TARGET.APPS.FdeGallery already defined by
#          packages/apps/FdeGallery.
# The source app is the one that is used, so this prebuilt is disabled by default and nothing is
# defined here. PRODUCT_PACKAGES still lists FdeGallery (see device.mk); that name now resolves to
# the source app, which is what gets installed.
#
# If packages/apps/FdeGallery is ever removed from the tree and the prebuilt is wanted instead,
# build with:  FDE_PREBUILT_GALLERY=true make -j$(nproc)
ifeq ($(FDE_PREBUILT_GALLERY),true)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := FdeGalleryPrebuilt
LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := FdeGallery.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
include $(BUILD_PREBUILT)
endif
