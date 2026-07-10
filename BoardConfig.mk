# config.mk
#
# Product-specific compile-time definitions.
#

# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true



BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true


DEVICE_MANIFEST_FILE += device/openfde/fde/manifest.xml

BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_SYSTEM_PROP += device/openfde/fde/system.prop

ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_MESON_ARGS := -Dallow-kcmp=enabled -Dmesa-clc=system -Dprecomp-compiler=system -Dandroid-strict=false -Dvideo-codecs=all
BOARD_MESA3D_BUILD_LIBGBM := true
BOARD_MESA3D_GALLIUM_DRIVERS := r300 r600 radeonsi nouveau virgl svga v3d vc4 freedreno \
                                    etnaviv tegra lima panfrost llvmpipe softpipe zink asahi rocket
BOARD_MESA3D_VULKAN_DRIVERS := amd swrast panfrost broadcom freedreno virtio asahi
#BOARD_MESA3D_GALLIUM_VA := true
endif

# PDK does not use ext4 image, but it is added here to prevent build break.
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2097152000