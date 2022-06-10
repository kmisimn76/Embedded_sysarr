## Petalinux create
#petalinux-create --type project --template zynq --name pynq_dma

TARGET=pynq_dma
## Petalinux build
petalinux-config --get-hw-description ../../Vivado/${TARGET}/
petalinux-build
#petalinux-build --sdk #(optional)
#petalinux-package --sysroot #(optional)
petalinux-package --force --boot --u-boot --fpga ../../Vivado/${TARGET}/${TARGET}.bit #packaging target bitstream

## Devel user application & build
#petalinux-create -t apps --template c --name dmatest --enable
# add the line: RM_WORK_EXCLUDE += "dmatest" to the <project_path>/project-spec/meta-user/conf/petalinuxbsp.conf file
#vim project-spec/meta-user/recipes-apps/dmatest/files/dmatest.c
petalinux-build -c dmatest

## Make root file system with User App
petalinux-build -c rootfs


## Copy to SDCard
BOOT_PATH=/media/sumin/6D21-54E9
SYSROOT_PATH=/media/sumin/0dbc4d1f-050f-4644-af35-978337996bb0

sudo rm -rf ${BOOT_PATH}/*
sudo rm -rf ${SYSROOT_PATH}/*

sudo cp ./images/linux/BOOT.BIN ${BOOT_PATH}/
sudo cp ./images/linux/boot.scr ${BOOT_PATH}/
sudo cp ./images/linux/image.ub ${BOOT_PATH}/
sudo cp ./images/linux/rootfs.tar.gz ${SYSROOT_PATH}/

sudo tar -xvf ${SYSROOT_PATH}/rootfs.tar.gz -C ${SYSROOT_PATH}/

#ILA info
mkdir /home/sumin/Downloads/${TARGET}
sudo cp ../../Vivado/${TARGET}/${TARGET}.runs/impl_1/*.ltx /home/sumin/Downloads/${TARGET}
