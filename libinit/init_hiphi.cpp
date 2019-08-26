#include <android-base/properties.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "vendor_init.h"
#include "property_service.h"

void property_override(char const prop[], char const value[]) {
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);

    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void load_global() {
    property_override("ro.build.fingerprint", "motorola/hiphi_g/hiphi:12/S3SH32.12-41-4/51104-0fc314:user/release-keys");
    property_override("ro.product.brand", "motorola");
    property_override("ro.product.device", "hiphi");
    property_override("ro.product.model", "motorola edge 30 pro");
}

void load_cn() {
    property_override("ro.build.fingerprint", "motorola/hiphic_cn/hiphic:12/S3SC32.7-42-8/c02b71-86451:user/release-keys");
    property_override("ro.product.brand", "motorola");
    property_override("ro.product.device", "hiphic");
    property_override("ro.product.model", "XT2201-2");
}


void vendor_load_properties() {
    std::string region = android::base::GetProperty("ro.boot.hardware.sku", "");

    if (region.find("XT2201-2") != std::string::npos)
        load_cn();
    else
        load_global();
}
