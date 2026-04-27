PRODUCT_PACKAGES += \
    EInkFrameworkOverlay \
    vendor.vbbot.eink-service

PRODUCT_PRIVATE_SEPOLICY_DIRS += vendor/eink/sepolicy

PRODUCT_COPY_FILES += \
    vendor/extra/product/mp_keyboard/aw9523b-key.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/aw9523b-key.idc \
    vendor/extra/product/mp_keyboard/aw9523b-key.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/aw9523b-key.kl \
    vendor/extra/product/mp_keyboard/aw9523b-key.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/aw9523b-key.kcm \
    vendor/extra/product/mp_keyboard/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl
