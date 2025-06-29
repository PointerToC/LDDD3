#!/bin/bash
export TOOLCHAIN_PATH="${PATH}/Downloads/gcc-linaro-5.1-2015.08-x86_64_arm-linux-gnueabi/bin"
export PATH="${TOOLCHAIN_PATH}:${PATH}"
export ARCH=arm
export EXTRADIR=${PWD}/extra
export CROSS_COMPILE=arm-linux-gnueabi-
if [ ! -f ".config" ]; then
	make LDDD3_vexpress_defconfig
fi
make zImage -j23
make modules -j23
make dtbs
cp arch/arm/boot/zImage extra/
cp arch/arm/boot/dts/*ca9.dtb	extra/
cp .config extra/
