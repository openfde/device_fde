ifneq ($(TARGET_HAVE_LEOPARD),false)
LEOPARD_PRODUCT_PACKAGES := \
    gralloc.LEOPARD \
    libdrm_leopard \
    libEGL_LEOPARD \
    libGLESv1_CM_LEOPARD \
    libGLESv2_LEOPARD \
    libGAL \
    libGLSLC \
    libVSC \
    libvulkan_LEOPARD \
    vulkan.LEOPARD \
    libSPIRV_LEOPARD \
    libdrm_android

PRODUCT_PACKAGES += \
        $(LEOPARD_PRODUCT_PACKAGES)
endif
