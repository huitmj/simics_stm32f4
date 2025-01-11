export CROSS_COMPILE=${PWD}/armv7m--uclibc--stable-2024.05-1/bin/arm-linux-
export ARCH=arm

sudo apt install cpio

wget -qO- https://busybox.net/downloads/busybox-1.36.1.tar.bz2 \
    | tar xvj
make defconfig menuconfig
#STATIC =y
#NOMMU

wget -qO- https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.9.tar.xz \
    | tar xJv

