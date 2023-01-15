#
# Copyright (C) 2023 Project Kaleidoscope
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),hiphi)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
