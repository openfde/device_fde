ifeq ($(TARGET_PRODUCT),$(filter $(TARGET_PRODUCT),openfde_x100_arm64))

PRODUCT_PACKAGES += \
    libPVRScopeServices \
    libPVROCL \
    libGLESv1_CM_powervr \
    libEGL_powervr \
    libGLESv2_powervr \
    libsutu_display \
    libpvrANDROID_WSEGL \
    libIMGegl \
    libcreatesurface \
    libufwriter \
    libsrv_um \
    libusc \
    gralloc.ft2004 \
    android.hardware.graphics.mapper@4.0-impl \
    hwcomposer.ft2004 \
    sensors.ft2004 \
    thermal.ft2004 \
    vulkan.powervr \
    memtrack.ft2004 \
    dma_transfer_test \
    ocl_extended_test32 \
    hwperfbin2jsont \
    rgx_blit_test32 \
    pvrdebug \
    pvrtld \
    ocl_unit_test32 \
    rgx_compute_test \
    pvrlogsplit \
    ocl_extended_test \
    pvr_mutex_perf_test_mx32 \
    testwrap \
    eglconfigs \
    rgx_triangle_test \
    rgx_kicksync_test \
    pvr_memory_test \
    testwrap32 \
    rgx_blit_test \
    pvrhtb2txt \
    pvr_mutex_perf_test_mx \
    pvrsrvctl \
    ocl_unit_test \
    pvrhtbd \
    rgx_kicksync_test32 \
    pvrlogdump \
    pvr_memory_test32 \
    eglconfigs32 \
    pvrhwperf \
    android.hardware.graphics.allocator@4.0-service \
    rgx_twiddling_test

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/firmware/rgx.fw.30.3.816.20:$(TARGET_COPY_OUT_VENDOR)/firmware/rgx.fw.30.3.816.20 \
	$(LOCAL_PATH)/firmware/rgx.sh.30.3.816.20:$(TARGET_COPY_OUT_VENDOR)/firmware/rgx.sh.30.3.816.20 \
	$(LOCAL_PATH)/etc/init/android.hardware.graphics.allocator@4.0-service.img.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.graphics.allocator@4.0-service.img.rc
endif
