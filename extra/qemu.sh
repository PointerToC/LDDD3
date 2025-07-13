qemu-system-arm \
        -M vexpress-a9 \
        -m 1024M \
        -kernel zImage \
        -dtb vexpress-v2p-ca9.dtb \
        -nographic \
        -append "root=/dev/mmcblk0 rootfstype=ext3 rw rootwait init=/linuxrc console=ttyAMA0" \
        -sd rootfs.img
