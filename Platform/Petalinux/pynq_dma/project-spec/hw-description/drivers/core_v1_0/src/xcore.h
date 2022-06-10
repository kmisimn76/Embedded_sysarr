// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XCORE_H
#define XCORE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xcore_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XCore_Config;
#endif

typedef struct {
    u32 Control_BaseAddress;
    u32 IsReady;
} XCore;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XCore_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XCore_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XCore_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XCore_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XCore_Initialize(XCore *InstancePtr, u16 DeviceId);
XCore_Config* XCore_LookupConfig(u16 DeviceId);
int XCore_CfgInitialize(XCore *InstancePtr, XCore_Config *ConfigPtr);
#else
int XCore_Initialize(XCore *InstancePtr, const char* InstanceName);
int XCore_Release(XCore *InstancePtr);
#endif

void XCore_Start(XCore *InstancePtr);
u32 XCore_IsDone(XCore *InstancePtr);
u32 XCore_IsIdle(XCore *InstancePtr);
u32 XCore_IsReady(XCore *InstancePtr);
void XCore_EnableAutoRestart(XCore *InstancePtr);
void XCore_DisableAutoRestart(XCore *InstancePtr);

void XCore_Set_n(XCore *InstancePtr, u32 Data);
u32 XCore_Get_n(XCore *InstancePtr);
void XCore_Set_transfn(XCore *InstancePtr, u32 Data);
u32 XCore_Get_transfn(XCore *InstancePtr);
void XCore_Set_intervn(XCore *InstancePtr, u32 Data);
u32 XCore_Get_intervn(XCore *InstancePtr);
void XCore_Set_source_addr(XCore *InstancePtr, u32 Data);
u32 XCore_Get_source_addr(XCore *InstancePtr);
void XCore_Set_dest_addr(XCore *InstancePtr, u32 Data);
u32 XCore_Get_dest_addr(XCore *InstancePtr);

void XCore_InterruptGlobalEnable(XCore *InstancePtr);
void XCore_InterruptGlobalDisable(XCore *InstancePtr);
void XCore_InterruptEnable(XCore *InstancePtr, u32 Mask);
void XCore_InterruptDisable(XCore *InstancePtr, u32 Mask);
void XCore_InterruptClear(XCore *InstancePtr, u32 Mask);
u32 XCore_InterruptGetEnabled(XCore *InstancePtr);
u32 XCore_InterruptGetStatus(XCore *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
