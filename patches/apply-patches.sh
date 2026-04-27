#!/bin/bash

set -e

patch_dir="$(cd "$(dirname "$0")" && pwd)"

apply_patch_dir() {
    local dir=$1
    local name=$2

    printf "\n ### APPLYING %s PATCHES ###\n" "$name"

    if [ ! -d "$dir" ]; then
        printf "Directory %s not found, skipping...\n" "$dir"
        return 0
    fi

    for path in $(cd "$dir"; echo */); do
        path="${path%/}"
        [ "$path" = "*" ] && continue
        # skip non-patch directories
        [ "$path" = "." ] && continue

        tree="$(tr _ / <<<"$path" | sed -e 's;platform/;;g')"
        printf "\n| %s ###\n" "$path"

        [ "$tree" == build ] && tree=build/make
        [ "$tree" == testing ] && tree=platform_testing
        [ "$tree" == vendor/hardware/overlay ] && tree=vendor/hardware_overlay
        [ "$tree" == treble/app ] && tree=treble_app
        [ "$tree" == vendor/partner/gms ] && tree=vendor/partner_gms

        pushd "$tree" > /dev/null

        for patch in "$dir"/"$path"/*.patch; do
            [ -f "$patch" ] || continue

            if patch -f -p1 --dry-run -R < "$patch" > /dev/null 2>&1; then
                printf "### ALREADY APPLIED: %s \n" "$patch"
                continue
            fi

            if git apply --check "$patch" 2>/dev/null; then
                git am "$patch"
            elif patch -f -p1 --dry-run < "$patch" > /dev/null 2>&1; then
                git am "$patch" || true
                patch -f -p1 < "$patch"
                git add -u
                git am --continue
            else
                printf "### FAILED APPLYING: %s \n" "$patch"
            fi
        done

        popd > /dev/null
    done
}

# Must be run from the root of the LineageOS tree
apply_patch_dir "$patch_dir" "EINK"
