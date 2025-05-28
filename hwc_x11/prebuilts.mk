ifeq ($(TARGET_PRODUCT),$(filter $(TARGET_PRODUCT),openfde_fde_arm64 openfde_fde_arm64_only openfde_x100_arm64))


HWCX11_PRODUCT_PACKAGES := \
    libX11

PRODUCT_PACKAGES += \
        $(HWCX11_PRODUCT_PACKAGES)

endif