export CROSS_COMPILE=${PWD}/armv7m--uclibc--stable-2024.05-1/bin/arm-linux-
export CROSS_COMPILE=${PWD}/armv7-eabihf--glibc--stable-2024.05-1/bin/arm-linux-
export ARCH=arm

sudo apt install cpio

wget -qO- https://busybox.net/downloads/busybox-1.36.1.tar.bz2 \
    | tar xvj
make defconfig menuconfig
#STATIC =y
#NOMMU
#DESKTOP
mkdir ../initrd
cd ../initrd/
mkdir -p bin sbin etc proc sys usr/bin usr/sbin
cp -a ../busybox-1.36.1/_install/* .

vi init
chmod +x init 
find . -print0 | cpio --null -ov --format=newc   | gzip -9 > ../initramfs.cpio.gz


wget -qO- https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.9.tar.xz \
    | tar xJv

BLK_DEV_INITRD
INITRAMFS_SOURCE [=/workspaces/simics_stm32f4/initramfs.cpio.gz]
RD_GZIP

ARCH_STM32
MACH_STM32F429
ARM_SINGLE_ARMV7M
ARM_DMA_MEM_BUFFERABLE
SET_MEM_PARAM
DRAM_BASE [=0x90000000
DRAM_SIZE [=0x00800000

ATAGS
DEPRECATED_PARAM_STRUCT
ARM_APPENDED_DTB
ARM_ATAG_DTB_COMPAT
XIP_KERNEL
XIP_PHYS_ADDR [=0x08020040
XIP_DEFLATED_DATA 

BINFMT_ELF_FDPIC
BINFMT_SCRIPT
BINFMT_FLAT
BINFMT_FLAT_OLD
BINFMT_ZFLAT
BINFMT_MISC

SERIAL_STM32
SERIAL_STM32_CONSOLE

INITRAMFS_SOURCE [=/workspaces/simics_stm32f4/initramfs.cpio.gz]

OPT="BLK_DEV_INITRD
RD_GZIP
ARCH_STM32
MACH_STM32F429
ARM_SINGLE_ARMV7M
ARM_DMA_MEM_BUFFERABLE
SET_MEM_PARAM
XIP_KERNEL
CONFIG_TTY
SERIAL_STM32
SERIAL_STM32_CONSOLE
PROC_FS
SYSFS
EXPERT
PRINTK"
for i in $OPT; do ./scripts/config -e $i; done
./scripts/config --set-str INITRAMFS_SOURCE "/workspaces/simics_stm32f4/initramfs.cpio.gz"
./scripts/config --set-str CMDLINE "console=ttySTM0,115200 earlyprintk consoleblank=0 ignore_loglevel"
./scripts/config --set-val DRAM_BASE 0x90000000
./scripts/config --set-val DRAM_SIZE 0x00800000
./scripts/config --set-val XIP_PHYS_ADDR 0x08020040

make mod2noconfig

stm32_defconfig