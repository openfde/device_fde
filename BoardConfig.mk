#
# Copyright (C) 2021 The Waydroid Project
#
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

BOARD_VENDOR := openfde

DEVICE_PATH := device/openfde/fde

# Binder
TARGET_USES_64_BIT_BINDER := true

# APEX
TARGET_FLATTEN_APEX := true

# Platform
TARGET_BOARD_PLATFORM := openfde

# Kernel
TARGET_NO_KERNEL := true

# Audio
USE_XML_AUDIO_POLICY_CONF := 1

# Bootloader
TARGET_NO_BOOTLOADER := true

# Display
TARGET_USES_HWC2 := true
ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_MESON_ARGS := -Dallow-kcmp=enabled -Dintel-xe-kmd=enabled
BOARD_MESA3D_BUILD_LIBGBM := true
BOARD_MESA3D_GALLIUM_DRIVERS := kmsro r300 r600 nouveau freedreno swrast v3d vc4 etnaviv tegra svga virgl panfrost lima radeonsi
BOARD_MESA3D_VULKAN_DRIVERS := broadcom freedreno panfrost swrast virtio amd
endif

# Filesystem
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Partitions
TARGET_COPY_OUT_VENDOR := vendor
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3547483648
BOARD_VENDORIMAGE_PARTITION_SIZE := 1547483648
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Disable scudo
MALLOC_SVELTE := true

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true


# Don't build emulator
ifeq ($(filter openfde_fde_x86 openfde_fde_x86_64,$(TARGET_PRODUCT)),)
$(warning openfde is going to compile emulator )
BUILD_EMULATOR := false
BUILD_STANDALONE_EMULATOR := false
BUILD_EMULATOR_QEMUD := false
BUILD_EMULATOR_OPENGL_DRIVER := true
GOLDFISH_OPENGL_BUILD_FOR_HOST := false
BUILD_EMULATOR_OPENGL := true
BUILD_EMULATOR_QEMU_PROPS := false
BUILD_EMULATOR_CAMERA_HAL ?= false
BUILD_EMULATOR_GPS_MODULE ?= false
BUILD_EMULATOR_LIGHTS_MODULE ?= false
BUILD_EMULATOR_SENSORS_MODULE ?= false
endif
