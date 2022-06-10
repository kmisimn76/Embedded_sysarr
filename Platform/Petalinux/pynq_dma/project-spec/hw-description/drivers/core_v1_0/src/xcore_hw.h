// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
// 0x24 : Data signal of n
//        bit 31~0 - n[31:0] (Read/Write)
// 0x28 : reserved
// 0x2c : Data signal of transfn
//        bit 31~0 - transfn[31:0] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of intervn
//        bit 31~0 - intervn[31:0] (Read/Write)
// 0x38 : reserved
// 0x3c : Data signal of source_addr
//        bit 31~0 - source_addr[31:0] (Read/Write)
// 0x40 : reserved
// 0x44 : Data signal of dest_addr
//        bit 31~0 - dest_addr[31:0] (Read/Write)
// 0x48 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XCORE_CONTROL_ADDR_AP_CTRL          0x00
#define XCORE_CONTROL_ADDR_GIE              0x04
#define XCORE_CONTROL_ADDR_IER              0x08
#define XCORE_CONTROL_ADDR_ISR              0x0c
#define XCORE_CONTROL_ADDR_N_DATA           0x24
#define XCORE_CONTROL_BITS_N_DATA           32
#define XCORE_CONTROL_ADDR_TRANSFN_DATA     0x2c
#define XCORE_CONTROL_BITS_TRANSFN_DATA     32
#define XCORE_CONTROL_ADDR_INTERVN_DATA     0x34
#define XCORE_CONTROL_BITS_INTERVN_DATA     32
#define XCORE_CONTROL_ADDR_SOURCE_ADDR_DATA 0x3c
#define XCORE_CONTROL_BITS_SOURCE_ADDR_DATA 32
#define XCORE_CONTROL_ADDR_DEST_ADDR_DATA   0x44
#define XCORE_CONTROL_BITS_DEST_ADDR_DATA   32

