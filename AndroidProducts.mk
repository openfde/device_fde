#
# Copyright (C) 2021 The Openfde Project
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

PRODUCT_MAKEFILES := \
    fde_arm64:$(LOCAL_DIR)/fde_arm64/fde_arm64.mk \
    fde_arm64_only:$(LOCAL_DIR)/fde_arm64_only/openfde_fde_arm64.mk \
    fde_x86_64:$(LOCAL_DIR)/fde_x86_64/openfde_fde_x86_64.mk \
    fde_x100_arm64:$(LOCAL_DIR)/x100/fde_x100_arm64.mk

COMMON_LUNCH_CHOICES := \
    fde_arm64-user \
    fde_arm64-userdebug \
    fde_arm64-eng \
    fde_arm64_only-user \
    fde_arm64_only-userdebug \
    fde_x100_arm64-user \
    fde_x100_arm64-userdebug \
    fde_x100_arm64-eng \
    fde_x86_64-user \
    fde_x86_64-userdebug \
    fde_x86_64-eng
