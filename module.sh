export TOOLCHAIN_PATH="${HOME}/Downloads/gcc-linaro-5.1-2015.08-x86_64_arm-linux-gnueabi/bin"
export PATH="${TOOLCHAIN_PATH}:${PATH}"

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- modules
if [ ! -d "extra/img" ]; then
	mkdir extra/img
fi
sudo mount -o loop,offset=$((2048*512)) extra/vexpress.img extra/img
sudo make ARCH=arm modules_install INSTALL_MOD_PATH=extra/img
sudo umount extra/img
