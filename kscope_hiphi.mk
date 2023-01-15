#
# Copyright (C) 2023 Project Kaleidoscope
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit common products
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configurations
$(call inherit-product, device/motorola/hiphi/device.mk)

# Inherit common configurations
$(call inherit-product, vendor/kscope/target/product/mobile.mk)
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_CHARACTERISTICS := nosdcard

PRODUCT_BRAND := motorola
PRODUCT_DEVICE := hiphi
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := XT2201-2
PRODUCT_NAME := kscope_hiphi

PRODUCT_GMS_CLIENTID_BASE := android-motorola
