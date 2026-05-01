PRODUCT_PACKAGES += \
    EInkFrameworkOverlay \
    EInkSystemUIOverlay \
    EInkLineageSettingsOverlay \
    vendor.vbbot.eink-service

# inkOS launcher (default home) and Pastiera physical-keyboard IME (default IME).
# Installed as non-privileged prebuilt system apps under /product/app/. inkOS is
# selected as default home via RoleManager defaultHolders=config_defaultHome
# (see EInkFrameworkOverlay overlays.xml + the framework_base/Permission patches);
# Launcher3QuickStep stays installed because it owns config_recentsComponentName.
# Pastiera overrides LatinIME so it is the only IME present and the framework
# auto-enables it as the default InputMethodService on first boot.
PRODUCT_PACKAGES += \
    inkOSLauncher \
    Pastiera

PRODUCT_PRIVATE_SEPOLICY_DIRS += vendor/eink/sepolicy

# E-ink: SystemUI's EinkAutoBrightnessController owns auto-brightness with custom
# inverted curves; AOSP's auto-brightness is silenced in DisplayPowerController
# when this read-only property is set.
PRODUCT_PRODUCT_PROPERTIES += \
    ro.eink.auto_owns_brightness=true

PRODUCT_COPY_FILES += \
    vendor/extra/product/mp_keyboard/aw9523b-key.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/aw9523b-key.idc \
    vendor/extra/product/mp_keyboard/aw9523b-key.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/aw9523b-key.kl \
    vendor/extra/product/mp_keyboard/aw9523b-key.kcm:$(TARGET_COPY_OUT_SYSTEM)/usr/keychars/aw9523b-key.kcm \
    vendor/extra/product/mp_keyboard/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl
