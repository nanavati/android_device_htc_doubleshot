#
# Copyright (C) 2011 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## The gps config appropriate for this device
PRODUCT_COPY_FILES += device/common/gps/gps.conf_EU:system/etc/gps.conf

## recovery and custom charging
PRODUCT_COPY_FILES += \
    device/htc/pyramid/recovery/sbin/choice_fn:recovery/root/sbin/choice_fn \
    device/htc/pyramid/recovery/sbin/power_test:recovery/root/sbin/power_test \
    device/htc/pyramid/recovery/sbin/offmode_charging:recovery/root/sbin/offmode_charging \
    device/htc/pyramid/recovery/sbin/detect_key:recovery/root/sbin/detect_key \
    device/htc/pyramid/recovery/sbin/htcbatt:recovery/root/sbin/htcbatt

## ramdisk stuffs
PRODUCT_COPY_FILES += \
    device/htc/pyramid/prebuilt/init:root/init \
    device/htc/pyramid/init.pyramid.rc:root/init.pyramid.rc \
    device/htc/pyramid/ueventd.pyramid.rc:root/ueventd.pyramid.rc

## (2) Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/htc/pyramid/pyramid-vendor.mk)

## misc
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    ro.com.google.locationfeatures=1 \
    dalvik.vm.dexopt-flags=m=y

## overlays
DEVICE_PACKAGE_OVERLAYS += device/htc/pyramid/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# GPS and Light
PRODUCT_PACKAGES += \
    gps.pyramid \
    lights.pyramid

# keylayouts
PRODUCT_COPY_FILES += \
    device/htc/pyramid/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl\
    device/htc/pyramid/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/htc/pyramid/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl\
    device/htc/pyramid/keylayout/cy8c-touchscreen.kl:system/usr/keylayout/cy8c-touchscreen.kl \
    device/htc/pyramid/keylayout/pyramid-keypad.kl:system/usr/keylayout/pyramid-keypad.kl

# Keychars
PRODUCT_COPY_FILES += \
    device/htc/pyramid/keychars/pyramid-keypad.kcm:system/usr/keychars/pyramid-keypad.kcm

# idc
PRODUCT_COPY_FILES += \
    device/htc/pyramid/idc/cy8c-touchscreen.idc:system/usr/idc/cy8c-touchscreen.idc \
    device/htc/pyramid/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc
    
## Firmware
PRODUCT_COPY_FILES += \
    device/htc/pyramid/firmware/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    device/htc/pyramid/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/htc/pyramid/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin \
    device/htc/pyramid/firmware/leia_pfp_470.fw:system/etc/firmware/leia_pfp_470.fw \
    device/htc/pyramid/firmware/leia_pm4_470.fw:system/etc/firmware/leia_pm4_470.fw \
    device/htc/pyramid/firmware/vidc_1080p.fw:system/etc/firmware/vidc_1080p.fw

# HTC BT Audio tune
PRODUCT_COPY_FILES += device/htc/pyramid/configs/AudioBTID.csv:system/etc/AudioBTID.csv

# QC thermald config
PRODUCT_COPY_FILES += device/htc/pyramid/configs/thermald.conf:system/etc/thermald.conf

# misc
PRODUCT_COPY_FILES += \
    device/htc/pyramid/vold.fstab:system/etc/vold.fstab

# Kernel and modules
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/htc/pyramid/prebuilt/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \
    device/htc/pyramid/prebuilt/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/pyramid/prebuilt/kineto_gan.ko:system/lib/modules/kineto_gan.ko

# common msm8660 configs
$(call inherit-product, device/htc/msm8660-common/msm8660.mk)

## htc audio settings
$(call inherit-product, device/htc/pyramid/media_htcaudio.mk)

$(call inherit-product, frameworks/base/build/phone-hdpi-512-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/htc/pyramid/pyramid-vendor.mk)
