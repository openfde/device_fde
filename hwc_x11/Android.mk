LOCAL_PATH := $(call my-dir)

# 宏定义：用于为每个 .so 文件创建一个 prebuilt 模块
# $(1): module name; required
# $(2): source file name (optional, default is $(module).so)
# $(3): relative install dir (optional)

define define-x11-prebuilt-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := $(1)
ifneq ($(2),)
src := $(2)
else
src := $(1).so
endif
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := x11/$$(src)
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := $(3)
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $$(BUILD_PREBUILT)
endef

# 获取当前架构下的所有 .so 文件名（去掉前缀 ./ 和后缀 .so）
libs_x11 := $(shell cd $(LOCAL_PATH)/x11 && find -maxdepth 1 -name '*.so' -type f)
libs_x11 := $(subst .so,,$(subst ./,,$(libs_x11)))

# 为每个 .so 创建一个模块
$(foreach lib,$(libs_x11),$(eval $(call define-x11-prebuilt-lib,$(lib), $(lib).so)))