#
# Copyright (C) 2023 Project Kaleidoscope
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PREBUILT_PATH := device/motorola/hiphi-prebuilt

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enable Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/motorola/hiphi/hiphi-vendor.mk)

# AAPT
# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# API
BOARD_API_LEVEL := 31
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31
PRODUCT_EXTRA_VNDK_VERSIONS := 31

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/$(PRODUCT_TARGET_VNDK_VERSION)/etc/audio/sku_taro/audio_policy_configuration.xml

# Bluetooth Audio (System-side HAL, sysbta)
PRODUCT_PACKAGES += \
    audio.sysbta.default \
    android.hardware.bluetooth.audio-service-system

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bluetooth/audio/config/sysbta_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration.xml \
    $(LOCAL_PATH)/bluetooth/audio/config/sysbta_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration_7_0.xml

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti.recovery \
    bootctrl.hiphi.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Common init scripts
PRODUCT_PACKAGES += \
    init.recovery.qcom.rc \
    init.recovery.usb.rc \
    init.hiphi.rc

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Kernel
PRODUCT_COPY_FILES += \
    $(DEVICE_PREBUILT_PATH)/kernel/dtb.img:dtb.img

# RRO Overlays
PRODUCT_PACKAGES += \
    FrameworkResOverlayHiphi \
    WifiResOverlayHiphi \
    DialerOverlayHiphi \
    SettingsOverlayHiphi \
    CarrierConfigOverlayHiphi \
    TelephonyOverlayHiphi \
    SystemUIOverlayHiphi \
    SettingsProviderOverlayHiphi

# Moto hardware
PRODUCT_PACKAGES += \
    MotoActions \
    MotoCommonOverlay

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Properties
include $(LOCAL_PATH)/properties/default.mk

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    qti-telephony-utils-prd \
    qti_telephony_utils_prd.xml \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/telephony_system-ext_privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/telephony_system-ext_privapp-permissions-qti.xml

# Update engine
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Vendor boot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom
