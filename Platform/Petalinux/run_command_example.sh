## Petalinux create
petalinux-create --type project --template zynq --name axidma_test

## Petalinux build
petalinux-config --get-hw-description ../../Vivado/axidma_test/axidma_test_wrapper.xsa
petalinux-build
petalinux-build --sdk #(optional)
petalinux-package --sysroot #(optional)
petalinux-package --force --boot --u-boot --fpga ../../Vivado/axidma_test/axidma_test.bit #packaging target bitstream

## Devel user application & build
petalinux-create -t apps --template c --name dmatest --enable
# add the line: RM_WORK_EXCLUDE += "dmatest" to the <project_path>/project-spec/meta-user/conf/petalinuxbsp.conf file
vim project-spec/meta-user/recipes-apps/dmatest/files/dmatest.c
petalinux-build -c dmatest

## Make root file system with User App
petalinux-build -c rootfs
