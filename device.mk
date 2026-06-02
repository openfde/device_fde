#
# Copyright (C) 2021 The Openfde Project
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

MOCK_PRODUCT_BRAND := google
MOCK_TARGET_PRODUCT := tangorpro
MOCK_TARGET_DEVICE := tangorpro
MOCK_PRODUCT_SYSTEM_BRAND := google
MOCK_PRODUCT_SYSTEM_DEVICE := tangorpro
MOCK_PRODUCT_SYSTEM_MANUFACTURER := Android
MOCK_PRODUCT_SYSTEM_MODEL := "Pixel Tablet"
MOCK_PRODUCT_SYSTEM_NAME := tangorpro
MOCK_PRODUCT_MANUFACTURER := Google
MOCK_PRODUCT_MODEL := "Pixel Tablet"
MOCK_TARGET_BOARD_PLATFORM := gs201
MOCK_TARGET_BOOTLOADER_BOARD_NAME := tangorpro

# Inherit from aosp products.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
PRODUCT_SHIPPING_API_LEVEL := 34
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_PRODUCT_IMAGE  := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
PRODUCT_BUILD_RAMDISK_IMAGE := false
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_USERDATA_IMAGE := false
PRODUCT_BUILD_VBMETA_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := true
ifeq ($(BUILD_VENDOR_ONLY), true)
PRODUCT_BUILD_SYSTEM_IMAGE := false
else
PRODUCT_BUILD_SYSTEM_IMAGE := true
endif



# Inherit some common ROM stuff
$(call inherit-product-if-exists, vendor/lineage/config/common_full_tablet_wifionly.mk)
$(call inherit-product-if-exists, vendor/bliss/config/common_full_tablet_wifionly.mk)

# Audio HAL
PRODUCT_PACKAGES += \
    libasound_module_pcm_pulse \
    libasound_module_ctl_pulse \
    libasound_module_conf_pulse \
    android.hardware.audio.parameter_parser.example_service \
    com.android.hardware.audio

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/surround_sound_configuration_5_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_configuration_5_0.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml \
    $(LOCAL_PATH)/configs/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    hardware/interfaces/audio/aidl/default/audio_effects_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects_config.xml

# Camera
USE_CAMERA_V4L2_HAL := false

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service \
    android.hardware.camera.provider-V1-external-service

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/configs/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    vendor.openfde.task@1.0-service \
    hwcomposer.openfde \
    hwcomposer.x11 \
    android.hardware.health-service.example
    

ifneq ($(TARGET_USE_MESA),false)
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2-service-ffmpeg

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.hwaccel=1 \
    debug.ffmpeg-codec2.rank=0 \
    debug.ffmpeg-codec2.hwaccel.drm=1 \
    debug.ffmpeg-codec2.pixel_format=RGBX_8888

PRODUCT_PACKAGES += \
    gralloc.minigbm_gbm_mesa \
    libgallium_drv_video \
    gralloc.gbm \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi \
    libgbm_mesa_wrapper

PRODUCT_PACKAGES += \
    vulkan.radeon \
    vulkan.freedreno \
    vulkan.broadcom \
    vulkan.panfrost \
    vulkan.virtio \
    vulkan.lvp

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml
endif

PRODUCT_PACKAGES += \
    vulkan.pastel 
#angle added by RELEASE_ANGLE_ON_SYSTEM in build/release/build_config/ap2a.scl

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service-lazy.clearkey

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software \
    android.hardware.keymaster@4.1-service \
    android.hardware.power-service.example \
    android.hardware.thermal@2.0-service.mock



# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

    #frameworks/av/media/libstagefright/data/media_codecs_google_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2.xml
    #frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml 
    #frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml

# NFC
PRODUCT_PACKAGES += \
    NfcNci

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay_common $(PRODUCT_PACKAGE_OVERLAYS)


# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/pc_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/pc_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml

# alsa-lib
PRODUCT_COPY_FILES += \
    external/alsa-lib/src/conf/alsa.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/alsa.conf \
    external/alsa-lib/src/conf/pcm/dsnoop.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/dsnoop.conf \
    external/alsa-lib/src/conf/pcm/modem.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/modem.conf \
    external/alsa-lib/src/conf/pcm/dpl.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/dpl.conf \
    external/alsa-lib/src/conf/pcm/default.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/default.conf \
    external/alsa-lib/src/conf/pcm/surround51.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/surround51.conf \
    external/alsa-lib/src/conf/pcm/surround41.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/surround41.conf \
    external/alsa-lib/src/conf/pcm/surround50.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/surround50.conf \
    external/alsa-lib/src/conf/pcm/dmix.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/dmix.conf \
    external/alsa-lib/src/conf/pcm/center_lfe.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/center_lfe.conf \
    external/alsa-lib/src/conf/pcm/surround40.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/alsa.conf \
    external/alsa-lib/src/conf/pcm/side.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/pcm/side.conf \
    external/alsa-lib/src/conf/pcm/iec958.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/iec958.conf \
    external/alsa-lib/src/conf/pcm/rear.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/rear.conf \
    external/alsa-lib/src/conf/pcm/surround71.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/surround71.conf \
    external/alsa-lib/src/conf/pcm/front.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/pcm/front.conf \
    external/alsa-lib/src/conf/cards/aliases.conf:$(TARGET_COPY_OUT_VENDOR)/usr/share/alsa/cards/aliases.conf

# magic window
PRODUCT_COPY_FILES += \
    device/openfde/fde/configs/magic_config.xml:system/magicwindow_config/magic_config.xml


# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Binder IPC
PRODUCT_PACKAGES += \
    vndservicemanager \
    libutilscallstack.vendor \
    libion.vendor \
    ipconfigstore

# BoringdroidSystemUI
PRODUCT_PACKAGES += \
    FdeSystemUI \
    FDECuratedApps \
    FDELinuxAppLauncher
	
PRODUCT_PACKAGES += \
    FdeGallery		

PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/init.fde.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.fde.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gps=openfde

PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.c2inputsurface=-1 \
    ro.apex.updatable=false

#gps
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-service \
    android.hardware.gnss@1.0-impl \
    gps.openfde

#sensors
PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal \
    android.hardware.sensors-service.multihal \
    sensors.usf
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

PRODUCT_PACKAGES += \
    TaskManager

OVERRIDE_ENABLE_UFFD_GC = false
OVERRIDE_PRODUCT_COMPRESSED_APEX=false

ifneq (,$(filter user,$(TARGET_BUILD_VARIANT)))
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += log.tag=W
endif

PRODUCT_CHARACTERISTICS := tablet
$(call inherit-product, $(LOCAL_PATH)/x100_prebuilts/prebuilts.mk)
$(call inherit-product, $(LOCAL_PATH)/../ftg340/prebuilts.mk)
