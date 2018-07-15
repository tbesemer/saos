#!/bin/bash

CUR_BRANCH=`git rev-parse --abbrev-ref HEAD`

if [ ! -d $OS_CONTAINER_ROOT/config ]
then
    echo "do_fetch_trees.sh: OS_CONTAINER_ROOT [$OS_CONTAINER_ROOT] not pointing to ~/config (indicating root)"
    exit 1
fi

echo "Fetching Branch [$CUR_BRANCH]"

if [ ! -d saos_kernel ]
then
    git clone -b $CUR_BRANCH https://github.com/tbesemer/saos_kernel.git
else
    echo "[saos_kernel]: Exists, not cloning"
fi

if [ ! -d saos_yocto ]
then
    git clone -b $CUR_BRANCH https://github.com/tbesemer/saos_yocto.git
else
    echo "[saos_yocto]: Exists, not cloning"
fi

if [ ! -d saos_yboot ]
then
    git clone -b $CUR_BRANCH https://github.com/tbesemer/saos_uboot.git
else
    echo "[saos_yocto]: Exists, not cloning"
fi

exit 0
