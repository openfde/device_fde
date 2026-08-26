# Copyright (C) 2013 The Android Open Source Project
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


PRODUCT_SOONG_NAMESPACES += device/openfde/fde/ipconfigstore


PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

TARGET_USERIMAGES_USE_EXT4 := true
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
PRODUCT_BUILD_SYSTEM_IMAGE := true
BOARD_USES_METADATA_PARTITION := true
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2668996864
BOARD_VENDORIMAGE_PARTITION_SIZE := 537483648


PRODUCT_SHIPPING_API_LEVEL := 37


# add all configurations
PRODUCT_AAPT_CONFIG := normal ldpi mdpi hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)



PRODUCT_PACKAGES += \
    Bluetooth \
    FusedLocation \
    Home \
    InputDevices \
    Keyguard \
    LatinIME \
    Phone \
    PrintSpooler \
    Provision \
    Settings \
    SystemUI \
    DocumentsUI \
    Camera2 \
    Calendar \
    DeskClock \
    Launcher3QuickStep \
    TelephonyProvider \
    TeleService \
    UserDictionaryProvider \
    WAPPushManager \
    audio \
    audio.primary.default \
    cameraserver \
    hostapd \
    wificond \
    librs_jni \
    libvideoeditor_core \
    libvideoeditor_jni \
    libvideoeditor_osal \
    libvideoeditorplayer \
    libvideoeditor_videofilters \
    local_time.default \
    network \
    pand \
    power.default \
    sdptool \
    vibrator.default


PRODUCT_PACKAGES += \
    FdeSystemUI \
    ExternalStorageProvider \
    FdeGallery \


PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fde_systemui/privapp-permissions-fde-systemui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-fde-systemui.xml

PRODUCT_PACKAGES += framework-audio_effects.xml

# Allowlist for system packages included in common.mk
PRODUCT_PACKAGES += preinstalled-packages-common.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    $(LOCAL_PATH)/configs/pc_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/pc_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    $(LOCAL_PATH)/init.fde.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.fde.rc \
    $(LOCAL_PATH)/openfde.prop:$(TARGET_COPY_OUT_VENDOR)/openfde.prop \


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += log.tag=V


PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=unknown \
    ro.config.alarm_alert=Alarm_Classic.ogg \
    ro.config.ringtone=Ring_Synth_04.ogg \
    ro.config.notification_sound=pixiedust.ogg \



ifneq ($(TARGET_USE_MESA),false)
#PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2-service-ffmpeg

#PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.hwaccel=1 \
    debug.ffmpeg-codec2.rank=0 \
    debug.ffmpeg-codec2.hwaccel.drm=1 \
    debug.ffmpeg-codec2.pixel_format=RGBX_8888

PRODUCT_PACKAGES += \
    gralloc.minigbm_gbm_mesa \
    gralloc.gbm \
    libgallium_drv_video \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    dri_gbm \
    libgbm_mesa_wrapper \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hidl.allocator@1.0-service \
    android.hardware.graphics.mapper@2.0-impl-2.1


PRODUCT_PACKAGES += \
    vulkan.radeon \
    vulkan.freedreno \
    vulkan.broadcom \
    vulkan.panfrost \
    vulkan.virtio \
    vulkan.lvp

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=gbm \
    ro.hardware.egl=mesa \
    ro.hardware.hwcomposer=openfde


endif

PRODUCT_PACKAGES += \
    vndservicemanager \
    hwservicemanager \
    screenrecord \
    ipconfigstore \
    hwcomposer.openfde \
    org.openfde.platform \



PRODUCT_PACKAGES += \
    android.hardware.thermal-service.example \
    com.android.hardware.gatekeeper.nonsecure \
    android.hardware.keymaster@4.1-service \
    android.hardware.power-service.example \
    android.hardware.health-service.example


#PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service
#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml


# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio.parameter_parser.example_service \
    com.android.hardware.audio

PRODUCT_COPY_FILES += \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/surround_sound_configuration_5_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_configuration_5_0.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml \
    $(LOCAL_PATH)/configs/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    hardware/interfaces/audio/aidl/default/audio_effects_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects_config.xml

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


# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.c2inputsurface=-1 \


PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/mediaswcodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy \

#gps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gps=openfde
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-service \
    android.hardware.gnss@1.0-impl \
    gps.openfde


$(call inherit-product, build/target/product/core_minimal.mk)
PRODUCT_SYSTEM_SERVER_JARS += org.openfde.platform
$(call inherit-product-if-exists, frameworks/webview/chromium/chromium.mk)
$(call inherit-product-if-exists, frameworks/base/data/keyboards/keyboards.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage5.mk)
$(call inherit-product-if-exists, frameworks/base/data/fonts/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/dancing-script/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/carrois-gothic-sc/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/coming-soon/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/cutive-mono/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/source-sans-pro/fonts.mk)
$(call inherit-product-if-exists, external/noto-fonts/fonts.mk)
$(call inherit-product-if-exists, external/roboto-fonts/fonts.mk)
$(call inherit-product-if-exists, external/roboto-flex-fonts/fonts.mk)
$(call inherit-product-if-exists, external/roboto-mono/fonts.mk)
$(call inherit-product, frameworks/native/build/tablet-7in-xhdpi-2048-dalvik-heap.mk)
