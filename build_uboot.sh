wget -qO- https://github.com/u-boot/u-boot/archive/refs/tags/v2024.10.tar.gz | tar zx
wget -qO- https://toolchains.bootlin.com/downloads/releases/toolchains/armv7m/tarballs/armv7m--uclibc--stable-2024.05-1.tar.xz | tar Jx
wget -qO- https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--glibc--stable-2024.05-1.tar.xz | tar Jx
wget -qO- https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--musl--stable-2024.05-1.tar.xz  | tar Jx


sudo apt update
sudo apt install -y flex

export CROSS_COMPILE=${PWD}/armv7m--uclibc--stable-2024.05-1/bin/arm-linux-
export CROSS_COMPILE=${PWD}/armv7-eabihf--glibc--stable-2024.05-1/bin/arm-linux-
export CROSS_COMPILE=${PWD}/armv7-eabihf--musl--stable-2024.05-1/bin/arm-linux-

cd u-boot-2024.10
make stm32f429-discovery_defconfig
make -j 2
