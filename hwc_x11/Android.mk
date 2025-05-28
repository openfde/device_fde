LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE    := libX11
LOCAL_SRC_FILES := x11/libX11.so
include $(PREBUILT_SHARED_LIBRARY)