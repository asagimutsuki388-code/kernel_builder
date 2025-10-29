#!/bin/bash
#
# hdjsjfjjwufbeizihfjejzf

export maindir="$(pwd)"
export outside="${maindir}/.."
source "${outside}/$1env"

KSU_git_ver=$(cd KernelSU && git rev-list --count HEAD)
KSU_ver=$(($KSU_git_ver + 10000 + 200))

suspatchesdir="$outside/ksu/sus_patches/$(echo $kernel_ver | cut -d. -f1,2)"


if [[ -d "$suspatchesdir" ]]; then
  for patch_file in "$suspatchesdir"/*.patch ; do
    git am "$patch_file"
  done
else
  echo "patching ksu susfs failed, the kernel version you want to patch doesnt have patches here yet"
  exit 1
fi

sed -i "s/\(CONFIG_LOCALVERSION=\)\(.*\)/\1\"-${kernel_name}-sus\"/" "${defconfig_file}"

echo "$(grep 'CONFIG_LOCALVERSION=' ${defconfig_file})"

echo -e " \nincludes SuSFS v1.5.9" >> banner_append

