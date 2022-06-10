// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xcore.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XCore_CfgInitialize(XCore *InstancePtr, XCore_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XCore_Start(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL) & 0x80;
    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XCore_IsDone(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XCore_IsIdle(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XCore_IsReady(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XCore_EnableAutoRestart(XCore *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XCore_DisableAutoRestart(XCore *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_AP_CTRL, 0);
}

void XCore_Set_n(XCore *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_N_DATA, Data);
}

u32 XCore_Get_n(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_N_DATA);
    return Data;
}

void XCore_Set_transfn(XCore *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_TRANSFN_DATA, Data);
}

u32 XCore_Get_transfn(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_TRANSFN_DATA);
    return Data;
}

void XCore_Set_intervn(XCore *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_INTERVN_DATA, Data);
}

u32 XCore_Get_intervn(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_INTERVN_DATA);
    return Data;
}

void XCore_Set_source_addr(XCore *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_SOURCE_ADDR_DATA, Data);
}

u32 XCore_Get_source_addr(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_SOURCE_ADDR_DATA);
    return Data;
}

void XCore_Set_dest_addr(XCore *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_DEST_ADDR_DATA, Data);
}

u32 XCore_Get_dest_addr(XCore *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_DEST_ADDR_DATA);
    return Data;
}

void XCore_InterruptGlobalEnable(XCore *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_GIE, 1);
}

void XCore_InterruptGlobalDisable(XCore *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_GIE, 0);
}

void XCore_InterruptEnable(XCore *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_IER);
    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_IER, Register | Mask);
}

void XCore_InterruptDisable(XCore *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_IER);
    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_IER, Register & (~Mask));
}

void XCore_InterruptClear(XCore *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCore_WriteReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_ISR, Mask);
}

u32 XCore_InterruptGetEnabled(XCore *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_IER);
}

u32 XCore_InterruptGetStatus(XCore *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCore_ReadReg(InstancePtr->Control_BaseAddress, XCORE_CONTROL_ADDR_ISR);
}

