# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
ifeq ($(TARGET_PRODUCT),$(filter $(TARGET_PRODUCT),openfde_x100_arm64))

LOCAL_PATH := $(call my-dir)

# $(1): module name; required
# $(2): source file name 
# $(3): relative install dir

define define-openfde-prebuilt-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
ifneq ($2,)
src := $2
else
src := $1
endif
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES_$$(TARGET_ARCH) := $$(TARGET_ARCH)/lib/$$(src)
ifneq ($$(TARGET_2ND_ARCH),)
LOCAL_SRC_FILES_$$(TARGET_2ND_ARCH) := $$(TARGET_2ND_ARCH)/lib/$$(src)
endif
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := $3
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $$(BUILD_PREBUILT)
endef

libs_lib := $(shell cd $(LOCAL_PATH)/$(TARGET_ARCH)/lib && find -maxdepth 1 -name '*.so' -type f)
libs_lib := $(subst .so,,$(subst ./,,$(libs_lib)))
$(foreach lib,$(libs_lib),$(eval $(call define-openfde-prebuilt-lib,$(lib),$(lib).so)))

libs_lib_egl := $(shell cd $(LOCAL_PATH)/$(TARGET_ARCH)/lib/egl && find -maxdepth 1 -name '*.so' -type f)
libs_lib_egl := $(subst .so,,$(subst ./,,$(libs_lib_egl)))
$(foreach lib,$(libs_lib_egl),\
    $(eval $(call define-openfde-prebuilt-lib,$(lib),egl/$(lib).so,egl)))

libs_lib_hw := $(shell cd $(LOCAL_PATH)/$(TARGET_ARCH)/lib/hw && find -maxdepth 1 -name '*.so' -type f)
libs_lib_hw := $(subst .so,,$(subst ./,,$(libs_lib_hw)))
$(foreach lib,$(libs_lib_hw),\
    $(eval $(call define-openfde-prebuilt-lib,$(lib),hw/$(lib).so,hw)))

# $(1): module name (and file name)
# $(2): source file name
# $(3): relative install dir

define define-openfde-prebuilt-bin
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_SRC_FILES_$$(TARGET_ARCH) := bin/$2
LOCAL_MULTILIB := first
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := $3
LOCAL_CHECK_ELF_FILES := false
include $$(BUILD_PREBUILT)
endef

bins_bin := $(shell cd $(LOCAL_PATH)/bin && find -maxdepth 1 -type f)
bins_bin := $(subst ./,,$(bins_bin))
$(foreach bin,$(bins_bin),\
    $(eval $(call define-openfde-prebuilt-bin,$(bin),$(bin))))

$(eval $(call define-openfde-prebuilt-bin,android.hardware.graphics.allocator@4.0-service,hw/android.hardware.graphics.allocator@4.0-service,hw))
$(shell cp $(LOCAL_PATH)/etc/init/android.hardware.sensors@1.0-service.rc $(PRODUCT_OUT)/vendor/etc/init)
$(shell cp $(LOCAL_PATH)/etc/powervr.ini $(PRODUCT_OUT)/vendor/etc/powervr.ini)
$(shell cp $(LOCAL_PATH)/etc/vintf/manifest/android.hardware.graphics.allocator@4.0.img.xml $(PRODUCT_OUT)/vendor/etc/vintf/manifest)
$(shell cp $(LOCAL_PATH)/etc/vintf/manifest/android.hardware.graphics.mapper@4.0-passthrough.img.xml $(PRODUCT_OUT)/vendor/etc/vintf/manifest)
endif
