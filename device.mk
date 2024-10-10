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

#
# 1.set log level to warnings when buid user version.
#

# Inherit from aosp products.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Inherit some common ROM stuff
$(call inherit-product-if-exists, vendor/lineage/config/common_full_tablet_wifionly.mk)
$(call inherit-product-if-exists, vendor/bliss/config/common_full_tablet_wifionly.mk)

# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@4.0-impl \
    android.hardware.audio.effect@4.0-impl \
    audio.primary.waydroid \
    audio.r_submix.default \
    audio.usb.default \
    audio.a2dp.default \
    libasound_module_pcm_pulse \
    libasound_module_ctl_pulse \
    libasound_module_conf_pulse

PRODUCT_COPY_FILES += \
    hardware/waydroid/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Camera
USE_CAMERA_V4L2_HAL := false

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service \
    android.hardware.camera.provider@2.4-external-service

PRODUCT_COPY_FILES += \
    device/openfde/fde/configs/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    vendor.waydroid.task@1.0-service \
    hwcomposer.waydroid

PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader

ifneq ($(TARGET_USE_MESA),false)
PRODUCT_PACKAGES += \
    gralloc.minigbm_gbm_mesa \
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

ifneq ($(filter %_openfde_fde_x86 %_openfde_fde_x86_64,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    vulkan.intel \
    vulkan.intel_hasvk
endif


# Media - Stagefright FFMPEG plugin
ifneq ($(filter %_openfde_fde_x86 %_openfde_fde_x86_64,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.hwaccel=1
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml
endif

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.3-service.clearkey

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \
    gatekeeper.waydroid

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service.waydroid

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.waydroid

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/media_profiles_V1_0.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    memtrack.waydroid

# NFC
PRODUCT_PACKAGES += \
    NfcNci

# Overlays
PRODUCT_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay $(PRODUCT_PACKAGE_OVERLAYS)

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
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
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/base/data/etc/com.android.oobe.xml:system/system_ext/etc/permissions/com.android.oobe.xml


# magic window
PRODUCT_COPY_FILES += \
    device/openfde/fde/configs/magic_config.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/magicwindow_config/magic_config.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-service.waydroid

# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.mock

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-service.waydroid

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# VNDK
PRODUCT_PACKAGES += \
    ld.config.vndk_lite.txt

# Binder IPC
PRODUCT_PACKAGES += \
    vndservicemanager

# Updater
PRODUCT_PACKAGES += \
    WaydroidUpdater

PRODUCT_PACKAGES += \
    FdeVncClient \
    OOBE \

PRODUCT_PACKAGES += \
    FdeGallery	

#FDE
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.fde.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.fde.rc
    
PRODUCT_PROPERTY_OVERRIDES += \
 	ro.hardware.gatekeeper=waydroid \
 	ro.hardware.memtrack=waydroid \
 	ro.hardware.hwcomposer=waydroid \
        ro.hardware.audio.primary=waydroid


PRODUCT_PACKAGES += \
    ipconfigstore

PRODUCT_PACKAGES += \
    wpa_supplicant.conf \
    wpa_supplicant \
    00-mesa-defaults.conf
   

#gps
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-service \
    android.hardware.gnss@1.0-impl \
    gps.open_fde

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gps=open_fde


ifneq (,$(filter user,$(TARGET_BUILD_VARIANT)))
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += log.tag=W
endif

PRODUCT_CHARACTERISTICS := tablet
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, $(LOCAL_PATH)/x100_prebuilts/prebuilts.mk)
