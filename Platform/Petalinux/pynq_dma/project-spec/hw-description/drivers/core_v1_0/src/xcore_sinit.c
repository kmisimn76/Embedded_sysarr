// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xcore.h"

extern XCore_Config XCore_ConfigTable[];

XCore_Config *XCore_LookupConfig(u16 DeviceId) {
	XCore_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XCORE_NUM_INSTANCES; Index++) {
		if (XCore_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XCore_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XCore_Initialize(XCore *InstancePtr, u16 DeviceId) {
	XCore_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XCore_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XCore_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

