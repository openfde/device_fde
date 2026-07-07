
LOCAL_PATH := $(call my-dir)

# $(1): module name; required
# $(2): module stem name if non-empty
# $(3): source file name 
# $(4): relative install dir
# $(5): create symbolic links
# $(6): depend modules
define define-redroid-prebuilt-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
ifneq ($2,)
LOCAL_INSTALLED_MODULE_STEM := $2
endif

ifneq ($3,)
src := $3
else
src := $1
endif
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES_$$(TARGET_ARCH) := prebuilts/$$(TARGET_ARCH)/lib/$$(src)
ifneq ($$(TARGET_2ND_ARCH),)
LOCAL_SRC_FILES_$$(TARGET_2ND_ARCH) := prebuilts/$$(TARGET_2ND_ARCH)/lib/$$(src)
endif
#LOCAL_STRIP_MODULE := false
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := $4
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_SYMLINKS := $5
LOCAL_CHECK_ELF_FILES := false
LOCAL_REQUIRED_MODULES := $6
include $$(BUILD_PREBUILT)
endef

# NDK libs
ndk_libs_cxx := libc++_shared
libs := $(ndk_libs_cxx)
$(foreach lib,$(libs),\
    $(eval $(call define-redroid-prebuilt-lib,$(lib)_p,$(lib).so,$(lib).so)))



# redroid hwcomposer
$(eval $(call define-redroid-prebuilt-lib,hwcomposer.redroid,,hw/hwcomposer.redroid.so,hw))
