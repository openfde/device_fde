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
ifeq ($(TARGET_PRODUCT),$(filter $(TARGET_PRODUCT),openfde_fde_arm64))
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

LOCAL_PATH := $(call my-dir)

PRODUCT_SOONG_NAMESPACES += \
    device/generic/goldfish-opengl

# DISABLE_RILD_OEM_HOOK := true


# Device modules
PRODUCT_PACKAGES += \
    vulkan.ranchu \
    gralloc.goldfish \
    gralloc.goldfish.default \
    gralloc.ranchu \
    libOpenglCodecCommon \
    libOpenglSystemCommon 

PRODUCT_PACKAGES += \
    libGLESv1_CM_emulation \
    lib_renderControl_enc \
    libEGL_emulation \
    libGLESv2_enc \
    libvulkan_enc \
    libGLESv2_emulation \
    libGLESv1_enc

endif
