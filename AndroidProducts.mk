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
# 1.Add compile options for x100 GPU
# 2.Add x100 related files(bin,so,xml...)
# 3.x100 add user version
#

VENDOR_NAME := aosp
ifneq ("$(wildcard vendor/lineage/*)","")
    VENDOR_NAME := openfde
endif

PRODUCT_MAKEFILES := \
    $(VENDOR_NAME)_fde_arm64:$(LOCAL_DIR)/fde_arm64/$(VENDOR_NAME)_fde_arm64.mk \
    $(VENDOR_NAME)_x100_arm64:$(LOCAL_DIR)/x100/$(VENDOR_NAME)_x100_arm64.mk \
    $(VENDOR_NAME)_fde_arm64_only:$(LOCAL_DIR)/fde_arm64_only/$(VENDOR_NAME)_fde_arm64_only.mk 

COMMON_LUNCH_CHOICES := \
    $(VENDOR_NAME)_fde_arm64-user \
    $(VENDOR_NAME)_fde_arm64_only-user \
    $(VENDOR_NAME)_fde_arm64-userdebug \
    $(VENDOR_NAME)_fde_arm64_only-userdebug \
    $(VENDOR_NAME)_fde_arm64-eng \
    $(VENDOR_NAME)_x100_arm64-user 
