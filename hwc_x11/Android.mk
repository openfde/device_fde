LOCAL_PATH := $(call my-dir)

# 清除变量
include $(CLEAR_VARS)

# 模块名（不带 .so 后缀）
LOCAL_MODULE := libX11

# 模块类型：动态库
LOCAL_MODULE_CLASS := SHARED_LIBRARIES

# 可选模块（非必需）
LOCAL_MODULE_TAGS := optional

# 源文件路径（相对于 LOCAL_PATH）
LOCAL_SRC_FILES := x11/libX11.so

# 模块后缀
LOCAL_MODULE_SUFFIX := .so

# 安装路径（可选，如无则默认在 system/lib 或 system/lib64）
# LOCAL_MODULE_RELATIVE_PATH := x11


# 专有模块（如厂商闭源库）
LOCAL_PROPRIETARY_MODULE := true

# 跳过 ELF 文件检查（适用于预编译库）
LOCAL_CHECK_ELF_FILES := false

# 构建预编译库
include $(BUILD_SHARED_LIBRARY)