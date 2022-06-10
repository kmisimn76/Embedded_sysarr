// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module Conv_sysarr_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 10,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    output wire [31:0]                   K,
    output wire [31:0]                   C,
    output wire [31:0]                   WH,
    output wire [31:0]                   WH_in,
    output wire [31:0]                   RS,
    output wire [31:0]                   L2_TILENUM_K,
    output wire [31:0]                   L2_TILENUM_C,
    output wire [31:0]                   L2_TILENUM_W,
    output wire [31:0]                   L2_TILENUM_H,
    output wire [31:0]                   L2_TILENUM_R,
    output wire [31:0]                   L2_TILENUM_S,
    output wire [31:0]                   K_L2,
    output wire [31:0]                   C_L2,
    output wire [31:0]                   W_L2,
    output wire [31:0]                   H_L2,
    output wire [31:0]                   W_in_L2,
    output wire [31:0]                   H_in_L2,
    output wire [31:0]                   R_L2,
    output wire [31:0]                   S_L2,
    output wire [31:0]                   L1_TILENUM_K,
    output wire [31:0]                   L1_TILENUM_C,
    output wire [31:0]                   L1_TILENUM_W,
    output wire [31:0]                   L1_TILENUM_H,
    output wire [31:0]                   L1_TILENUM_R,
    output wire [31:0]                   L1_TILENUM_S,
    output wire [31:0]                   K_L1,
    output wire [31:0]                   C_L1,
    output wire [31:0]                   W_L1,
    output wire [31:0]                   H_L1,
    output wire [31:0]                   W_in_L1,
    output wire [31:0]                   H_in_L1,
    output wire [31:0]                   R_L1,
    output wire [31:0]                   S_L1,
    output wire [31:0]                   TILESIZE_W,
    output wire [31:0]                   TILESIZE_H,
    output wire [31:0]                   TILESIZE_R,
    output wire [31:0]                   TILESIZE_S,
    output wire [31:0]                   bias_addr,
    output wire [31:0]                   weight_addr,
    output wire [31:0]                   data_addr,
    output wire [31:0]                   output_addr,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// 0x000 : Control signals
//         bit 0  - ap_start (Read/Write/COH)
//         bit 1  - ap_done (Read/COR)
//         bit 2  - ap_idle (Read)
//         bit 3  - ap_ready (Read)
//         bit 7  - auto_restart (Read/Write)
//         others - reserved
// 0x004 : Global Interrupt Enable Register
//         bit 0  - Global Interrupt Enable (Read/Write)
//         others - reserved
// 0x008 : IP Interrupt Enable Register (Read/Write)
//         bit 0  - enable ap_done interrupt (Read/Write)
//         bit 1  - enable ap_ready interrupt (Read/Write)
//         others - reserved
// 0x00c : IP Interrupt Status Register (Read/TOW)
//         bit 0  - ap_done (COR/TOW)
//         bit 1  - ap_ready (COR/TOW)
//         others - reserved
// 0x024 : Data signal of K
//         bit 31~0 - K[31:0] (Read/Write)
// 0x028 : reserved
// 0x02c : Data signal of C
//         bit 31~0 - C[31:0] (Read/Write)
// 0x030 : reserved
// 0x034 : Data signal of WH
//         bit 31~0 - WH[31:0] (Read/Write)
// 0x038 : reserved
// 0x03c : Data signal of WH_in
//         bit 31~0 - WH_in[31:0] (Read/Write)
// 0x040 : reserved
// 0x044 : Data signal of RS
//         bit 31~0 - RS[31:0] (Read/Write)
// 0x048 : reserved
// 0x04c : Data signal of L2_TILENUM_K
//         bit 31~0 - L2_TILENUM_K[31:0] (Read/Write)
// 0x050 : reserved
// 0x054 : Data signal of L2_TILENUM_C
//         bit 31~0 - L2_TILENUM_C[31:0] (Read/Write)
// 0x058 : reserved
// 0x05c : Data signal of L2_TILENUM_W
//         bit 31~0 - L2_TILENUM_W[31:0] (Read/Write)
// 0x060 : reserved
// 0x064 : Data signal of L2_TILENUM_H
//         bit 31~0 - L2_TILENUM_H[31:0] (Read/Write)
// 0x068 : reserved
// 0x06c : Data signal of L2_TILENUM_R
//         bit 31~0 - L2_TILENUM_R[31:0] (Read/Write)
// 0x070 : reserved
// 0x074 : Data signal of L2_TILENUM_S
//         bit 31~0 - L2_TILENUM_S[31:0] (Read/Write)
// 0x078 : reserved
// 0x07c : Data signal of K_L2
//         bit 31~0 - K_L2[31:0] (Read/Write)
// 0x080 : reserved
// 0x084 : Data signal of C_L2
//         bit 31~0 - C_L2[31:0] (Read/Write)
// 0x088 : reserved
// 0x08c : Data signal of W_L2
//         bit 31~0 - W_L2[31:0] (Read/Write)
// 0x090 : reserved
// 0x094 : Data signal of H_L2
//         bit 31~0 - H_L2[31:0] (Read/Write)
// 0x098 : reserved
// 0x09c : Data signal of W_in_L2
//         bit 31~0 - W_in_L2[31:0] (Read/Write)
// 0x0a0 : reserved
// 0x104 : Data signal of H_in_L2
//         bit 31~0 - H_in_L2[31:0] (Read/Write)
// 0x108 : reserved
// 0x10c : Data signal of R_L2
//         bit 31~0 - R_L2[31:0] (Read/Write)
// 0x110 : reserved
// 0x114 : Data signal of S_L2
//         bit 31~0 - S_L2[31:0] (Read/Write)
// 0x118 : reserved
// 0x11c : Data signal of L1_TILENUM_K
//         bit 31~0 - L1_TILENUM_K[31:0] (Read/Write)
// 0x120 : reserved
// 0x124 : Data signal of L1_TILENUM_C
//         bit 31~0 - L1_TILENUM_C[31:0] (Read/Write)
// 0x128 : reserved
// 0x12c : Data signal of L1_TILENUM_W
//         bit 31~0 - L1_TILENUM_W[31:0] (Read/Write)
// 0x130 : reserved
// 0x134 : Data signal of L1_TILENUM_H
//         bit 31~0 - L1_TILENUM_H[31:0] (Read/Write)
// 0x138 : reserved
// 0x13c : Data signal of L1_TILENUM_R
//         bit 31~0 - L1_TILENUM_R[31:0] (Read/Write)
// 0x140 : reserved
// 0x144 : Data signal of L1_TILENUM_S
//         bit 31~0 - L1_TILENUM_S[31:0] (Read/Write)
// 0x148 : reserved
// 0x14c : Data signal of K_L1
//         bit 31~0 - K_L1[31:0] (Read/Write)
// 0x150 : reserved
// 0x154 : Data signal of C_L1
//         bit 31~0 - C_L1[31:0] (Read/Write)
// 0x158 : reserved
// 0x15c : Data signal of W_L1
//         bit 31~0 - W_L1[31:0] (Read/Write)
// 0x160 : reserved
// 0x164 : Data signal of H_L1
//         bit 31~0 - H_L1[31:0] (Read/Write)
// 0x168 : reserved
// 0x16c : Data signal of W_in_L1
//         bit 31~0 - W_in_L1[31:0] (Read/Write)
// 0x170 : reserved
// 0x174 : Data signal of H_in_L1
//         bit 31~0 - H_in_L1[31:0] (Read/Write)
// 0x178 : reserved
// 0x17c : Data signal of R_L1
//         bit 31~0 - R_L1[31:0] (Read/Write)
// 0x180 : reserved
// 0x184 : Data signal of S_L1
//         bit 31~0 - S_L1[31:0] (Read/Write)
// 0x188 : reserved
// 0x18c : Data signal of TILESIZE_W
//         bit 31~0 - TILESIZE_W[31:0] (Read/Write)
// 0x190 : reserved
// 0x194 : Data signal of TILESIZE_H
//         bit 31~0 - TILESIZE_H[31:0] (Read/Write)
// 0x198 : reserved
// 0x19c : Data signal of TILESIZE_R
//         bit 31~0 - TILESIZE_R[31:0] (Read/Write)
// 0x1a0 : reserved
// 0x204 : Data signal of TILESIZE_S
//         bit 31~0 - TILESIZE_S[31:0] (Read/Write)
// 0x208 : reserved
// 0x20c : Data signal of bias_addr
//         bit 31~0 - bias_addr[31:0] (Read/Write)
// 0x210 : reserved
// 0x214 : Data signal of weight_addr
//         bit 31~0 - weight_addr[31:0] (Read/Write)
// 0x218 : reserved
// 0x21c : Data signal of data_addr
//         bit 31~0 - data_addr[31:0] (Read/Write)
// 0x220 : reserved
// 0x224 : Data signal of output_addr
//         bit 31~0 - output_addr[31:0] (Read/Write)
// 0x228 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL             = 10'h000,
    ADDR_GIE                 = 10'h004,
    ADDR_IER                 = 10'h008,
    ADDR_ISR                 = 10'h00c,
    ADDR_K_DATA_0            = 10'h024,
    ADDR_K_CTRL              = 10'h028,
    ADDR_C_DATA_0            = 10'h02c,
    ADDR_C_CTRL              = 10'h030,
    ADDR_WH_DATA_0           = 10'h034,
    ADDR_WH_CTRL             = 10'h038,
    ADDR_WH_IN_DATA_0        = 10'h03c,
    ADDR_WH_IN_CTRL          = 10'h040,
    ADDR_RS_DATA_0           = 10'h044,
    ADDR_RS_CTRL             = 10'h048,
    ADDR_L2_TILENUM_K_DATA_0 = 10'h04c,
    ADDR_L2_TILENUM_K_CTRL   = 10'h050,
    ADDR_L2_TILENUM_C_DATA_0 = 10'h054,
    ADDR_L2_TILENUM_C_CTRL   = 10'h058,
    ADDR_L2_TILENUM_W_DATA_0 = 10'h05c,
    ADDR_L2_TILENUM_W_CTRL   = 10'h060,
    ADDR_L2_TILENUM_H_DATA_0 = 10'h064,
    ADDR_L2_TILENUM_H_CTRL   = 10'h068,
    ADDR_L2_TILENUM_R_DATA_0 = 10'h06c,
    ADDR_L2_TILENUM_R_CTRL   = 10'h070,
    ADDR_L2_TILENUM_S_DATA_0 = 10'h074,
    ADDR_L2_TILENUM_S_CTRL   = 10'h078,
    ADDR_K_L2_DATA_0         = 10'h07c,
    ADDR_K_L2_CTRL           = 10'h080,
    ADDR_C_L2_DATA_0         = 10'h084,
    ADDR_C_L2_CTRL           = 10'h088,
    ADDR_W_L2_DATA_0         = 10'h08c,
    ADDR_W_L2_CTRL           = 10'h090,
    ADDR_H_L2_DATA_0         = 10'h094,
    ADDR_H_L2_CTRL           = 10'h098,
    ADDR_W_IN_L2_DATA_0      = 10'h09c,
    ADDR_W_IN_L2_CTRL        = 10'h0a0,
    ADDR_H_IN_L2_DATA_0      = 10'h104,
    ADDR_H_IN_L2_CTRL        = 10'h108,
    ADDR_R_L2_DATA_0         = 10'h10c,
    ADDR_R_L2_CTRL           = 10'h110,
    ADDR_S_L2_DATA_0         = 10'h114,
    ADDR_S_L2_CTRL           = 10'h118,
    ADDR_L1_TILENUM_K_DATA_0 = 10'h11c,
    ADDR_L1_TILENUM_K_CTRL   = 10'h120,
    ADDR_L1_TILENUM_C_DATA_0 = 10'h124,
    ADDR_L1_TILENUM_C_CTRL   = 10'h128,
    ADDR_L1_TILENUM_W_DATA_0 = 10'h12c,
    ADDR_L1_TILENUM_W_CTRL   = 10'h130,
    ADDR_L1_TILENUM_H_DATA_0 = 10'h134,
    ADDR_L1_TILENUM_H_CTRL   = 10'h138,
    ADDR_L1_TILENUM_R_DATA_0 = 10'h13c,
    ADDR_L1_TILENUM_R_CTRL   = 10'h140,
    ADDR_L1_TILENUM_S_DATA_0 = 10'h144,
    ADDR_L1_TILENUM_S_CTRL   = 10'h148,
    ADDR_K_L1_DATA_0         = 10'h14c,
    ADDR_K_L1_CTRL           = 10'h150,
    ADDR_C_L1_DATA_0         = 10'h154,
    ADDR_C_L1_CTRL           = 10'h158,
    ADDR_W_L1_DATA_0         = 10'h15c,
    ADDR_W_L1_CTRL           = 10'h160,
    ADDR_H_L1_DATA_0         = 10'h164,
    ADDR_H_L1_CTRL           = 10'h168,
    ADDR_W_IN_L1_DATA_0      = 10'h16c,
    ADDR_W_IN_L1_CTRL        = 10'h170,
    ADDR_H_IN_L1_DATA_0      = 10'h174,
    ADDR_H_IN_L1_CTRL        = 10'h178,
    ADDR_R_L1_DATA_0         = 10'h17c,
    ADDR_R_L1_CTRL           = 10'h180,
    ADDR_S_L1_DATA_0         = 10'h184,
    ADDR_S_L1_CTRL           = 10'h188,
    ADDR_TILESIZE_W_DATA_0   = 10'h18c,
    ADDR_TILESIZE_W_CTRL     = 10'h190,
    ADDR_TILESIZE_H_DATA_0   = 10'h194,
    ADDR_TILESIZE_H_CTRL     = 10'h198,
    ADDR_TILESIZE_R_DATA_0   = 10'h19c,
    ADDR_TILESIZE_R_CTRL     = 10'h1a0,
    ADDR_TILESIZE_S_DATA_0   = 10'h204,
    ADDR_TILESIZE_S_CTRL     = 10'h208,
    ADDR_BIAS_ADDR_DATA_0    = 10'h20c,
    ADDR_BIAS_ADDR_CTRL      = 10'h210,
    ADDR_WEIGHT_ADDR_DATA_0  = 10'h214,
    ADDR_WEIGHT_ADDR_CTRL    = 10'h218,
    ADDR_DATA_ADDR_DATA_0    = 10'h21c,
    ADDR_DATA_ADDR_CTRL      = 10'h220,
    ADDR_OUTPUT_ADDR_DATA_0  = 10'h224,
    ADDR_OUTPUT_ADDR_CTRL    = 10'h228,
    WRIDLE                   = 2'd0,
    WRDATA                   = 2'd1,
    WRRESP                   = 2'd2,
    WRRESET                  = 2'd3,
    RDIDLE                   = 2'd0,
    RDDATA                   = 2'd1,
    RDRESET                  = 2'd2,
    ADDR_BITS                = 10;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle;
    reg                           int_ap_ready;
    reg                           int_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    reg  [31:0]                   int_K = 'b0;
    reg  [31:0]                   int_C = 'b0;
    reg  [31:0]                   int_WH = 'b0;
    reg  [31:0]                   int_WH_in = 'b0;
    reg  [31:0]                   int_RS = 'b0;
    reg  [31:0]                   int_L2_TILENUM_K = 'b0;
    reg  [31:0]                   int_L2_TILENUM_C = 'b0;
    reg  [31:0]                   int_L2_TILENUM_W = 'b0;
    reg  [31:0]                   int_L2_TILENUM_H = 'b0;
    reg  [31:0]                   int_L2_TILENUM_R = 'b0;
    reg  [31:0]                   int_L2_TILENUM_S = 'b0;
    reg  [31:0]                   int_K_L2 = 'b0;
    reg  [31:0]                   int_C_L2 = 'b0;
    reg  [31:0]                   int_W_L2 = 'b0;
    reg  [31:0]                   int_H_L2 = 'b0;
    reg  [31:0]                   int_W_in_L2 = 'b0;
    reg  [31:0]                   int_H_in_L2 = 'b0;
    reg  [31:0]                   int_R_L2 = 'b0;
    reg  [31:0]                   int_S_L2 = 'b0;
    reg  [31:0]                   int_L1_TILENUM_K = 'b0;
    reg  [31:0]                   int_L1_TILENUM_C = 'b0;
    reg  [31:0]                   int_L1_TILENUM_W = 'b0;
    reg  [31:0]                   int_L1_TILENUM_H = 'b0;
    reg  [31:0]                   int_L1_TILENUM_R = 'b0;
    reg  [31:0]                   int_L1_TILENUM_S = 'b0;
    reg  [31:0]                   int_K_L1 = 'b0;
    reg  [31:0]                   int_C_L1 = 'b0;
    reg  [31:0]                   int_W_L1 = 'b0;
    reg  [31:0]                   int_H_L1 = 'b0;
    reg  [31:0]                   int_W_in_L1 = 'b0;
    reg  [31:0]                   int_H_in_L1 = 'b0;
    reg  [31:0]                   int_R_L1 = 'b0;
    reg  [31:0]                   int_S_L1 = 'b0;
    reg  [31:0]                   int_TILESIZE_W = 'b0;
    reg  [31:0]                   int_TILESIZE_H = 'b0;
    reg  [31:0]                   int_TILESIZE_R = 'b0;
    reg  [31:0]                   int_TILESIZE_S = 'b0;
    reg  [31:0]                   int_bias_addr = 'b0;
    reg  [31:0]                   int_weight_addr = 'b0;
    reg  [31:0]                   int_data_addr = 'b0;
    reg  [31:0]                   int_output_addr = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_K_DATA_0: begin
                    rdata <= int_K[31:0];
                end
                ADDR_C_DATA_0: begin
                    rdata <= int_C[31:0];
                end
                ADDR_WH_DATA_0: begin
                    rdata <= int_WH[31:0];
                end
                ADDR_WH_IN_DATA_0: begin
                    rdata <= int_WH_in[31:0];
                end
                ADDR_RS_DATA_0: begin
                    rdata <= int_RS[31:0];
                end
                ADDR_L2_TILENUM_K_DATA_0: begin
                    rdata <= int_L2_TILENUM_K[31:0];
                end
                ADDR_L2_TILENUM_C_DATA_0: begin
                    rdata <= int_L2_TILENUM_C[31:0];
                end
                ADDR_L2_TILENUM_W_DATA_0: begin
                    rdata <= int_L2_TILENUM_W[31:0];
                end
                ADDR_L2_TILENUM_H_DATA_0: begin
                    rdata <= int_L2_TILENUM_H[31:0];
                end
                ADDR_L2_TILENUM_R_DATA_0: begin
                    rdata <= int_L2_TILENUM_R[31:0];
                end
                ADDR_L2_TILENUM_S_DATA_0: begin
                    rdata <= int_L2_TILENUM_S[31:0];
                end
                ADDR_K_L2_DATA_0: begin
                    rdata <= int_K_L2[31:0];
                end
                ADDR_C_L2_DATA_0: begin
                    rdata <= int_C_L2[31:0];
                end
                ADDR_W_L2_DATA_0: begin
                    rdata <= int_W_L2[31:0];
                end
                ADDR_H_L2_DATA_0: begin
                    rdata <= int_H_L2[31:0];
                end
                ADDR_W_IN_L2_DATA_0: begin
                    rdata <= int_W_in_L2[31:0];
                end
                ADDR_H_IN_L2_DATA_0: begin
                    rdata <= int_H_in_L2[31:0];
                end
                ADDR_R_L2_DATA_0: begin
                    rdata <= int_R_L2[31:0];
                end
                ADDR_S_L2_DATA_0: begin
                    rdata <= int_S_L2[31:0];
                end
                ADDR_L1_TILENUM_K_DATA_0: begin
                    rdata <= int_L1_TILENUM_K[31:0];
                end
                ADDR_L1_TILENUM_C_DATA_0: begin
                    rdata <= int_L1_TILENUM_C[31:0];
                end
                ADDR_L1_TILENUM_W_DATA_0: begin
                    rdata <= int_L1_TILENUM_W[31:0];
                end
                ADDR_L1_TILENUM_H_DATA_0: begin
                    rdata <= int_L1_TILENUM_H[31:0];
                end
                ADDR_L1_TILENUM_R_DATA_0: begin
                    rdata <= int_L1_TILENUM_R[31:0];
                end
                ADDR_L1_TILENUM_S_DATA_0: begin
                    rdata <= int_L1_TILENUM_S[31:0];
                end
                ADDR_K_L1_DATA_0: begin
                    rdata <= int_K_L1[31:0];
                end
                ADDR_C_L1_DATA_0: begin
                    rdata <= int_C_L1[31:0];
                end
                ADDR_W_L1_DATA_0: begin
                    rdata <= int_W_L1[31:0];
                end
                ADDR_H_L1_DATA_0: begin
                    rdata <= int_H_L1[31:0];
                end
                ADDR_W_IN_L1_DATA_0: begin
                    rdata <= int_W_in_L1[31:0];
                end
                ADDR_H_IN_L1_DATA_0: begin
                    rdata <= int_H_in_L1[31:0];
                end
                ADDR_R_L1_DATA_0: begin
                    rdata <= int_R_L1[31:0];
                end
                ADDR_S_L1_DATA_0: begin
                    rdata <= int_S_L1[31:0];
                end
                ADDR_TILESIZE_W_DATA_0: begin
                    rdata <= int_TILESIZE_W[31:0];
                end
                ADDR_TILESIZE_H_DATA_0: begin
                    rdata <= int_TILESIZE_H[31:0];
                end
                ADDR_TILESIZE_R_DATA_0: begin
                    rdata <= int_TILESIZE_R[31:0];
                end
                ADDR_TILESIZE_S_DATA_0: begin
                    rdata <= int_TILESIZE_S[31:0];
                end
                ADDR_BIAS_ADDR_DATA_0: begin
                    rdata <= int_bias_addr[31:0];
                end
                ADDR_WEIGHT_ADDR_DATA_0: begin
                    rdata <= int_weight_addr[31:0];
                end
                ADDR_DATA_ADDR_DATA_0: begin
                    rdata <= int_data_addr[31:0];
                end
                ADDR_OUTPUT_ADDR_DATA_0: begin
                    rdata <= int_output_addr[31:0];
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign interrupt    = int_gie & (|int_isr);
assign ap_start     = int_ap_start;
assign K            = int_K;
assign C            = int_C;
assign WH           = int_WH;
assign WH_in        = int_WH_in;
assign RS           = int_RS;
assign L2_TILENUM_K = int_L2_TILENUM_K;
assign L2_TILENUM_C = int_L2_TILENUM_C;
assign L2_TILENUM_W = int_L2_TILENUM_W;
assign L2_TILENUM_H = int_L2_TILENUM_H;
assign L2_TILENUM_R = int_L2_TILENUM_R;
assign L2_TILENUM_S = int_L2_TILENUM_S;
assign K_L2         = int_K_L2;
assign C_L2         = int_C_L2;
assign W_L2         = int_W_L2;
assign H_L2         = int_H_L2;
assign W_in_L2      = int_W_in_L2;
assign H_in_L2      = int_H_in_L2;
assign R_L2         = int_R_L2;
assign S_L2         = int_S_L2;
assign L1_TILENUM_K = int_L1_TILENUM_K;
assign L1_TILENUM_C = int_L1_TILENUM_C;
assign L1_TILENUM_W = int_L1_TILENUM_W;
assign L1_TILENUM_H = int_L1_TILENUM_H;
assign L1_TILENUM_R = int_L1_TILENUM_R;
assign L1_TILENUM_S = int_L1_TILENUM_S;
assign K_L1         = int_K_L1;
assign C_L1         = int_C_L1;
assign W_L1         = int_W_L1;
assign H_L1         = int_H_L1;
assign W_in_L1      = int_W_in_L1;
assign H_in_L1      = int_H_in_L1;
assign R_L1         = int_R_L1;
assign S_L1         = int_S_L1;
assign TILESIZE_W   = int_TILESIZE_W;
assign TILESIZE_H   = int_TILESIZE_H;
assign TILESIZE_R   = int_TILESIZE_R;
assign TILESIZE_S   = int_TILESIZE_S;
assign bias_addr    = int_bias_addr;
assign weight_addr  = int_weight_addr;
assign data_addr    = int_data_addr;
assign output_addr  = int_output_addr;
// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (ap_done)
            int_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_ready <= ap_ready;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <=  WDATA[7];
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end

// int_K[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_K[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_K_DATA_0)
            int_K[31:0] <= (WDATA[31:0] & wmask) | (int_K[31:0] & ~wmask);
    end
end

// int_C[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_C[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_C_DATA_0)
            int_C[31:0] <= (WDATA[31:0] & wmask) | (int_C[31:0] & ~wmask);
    end
end

// int_WH[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_WH[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_WH_DATA_0)
            int_WH[31:0] <= (WDATA[31:0] & wmask) | (int_WH[31:0] & ~wmask);
    end
end

// int_WH_in[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_WH_in[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_WH_IN_DATA_0)
            int_WH_in[31:0] <= (WDATA[31:0] & wmask) | (int_WH_in[31:0] & ~wmask);
    end
end

// int_RS[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_RS[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_RS_DATA_0)
            int_RS[31:0] <= (WDATA[31:0] & wmask) | (int_RS[31:0] & ~wmask);
    end
end

// int_L2_TILENUM_K[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L2_TILENUM_K[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L2_TILENUM_K_DATA_0)
            int_L2_TILENUM_K[31:0] <= (WDATA[31:0] & wmask) | (int_L2_TILENUM_K[31:0] & ~wmask);
    end
end

// int_L2_TILENUM_C[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L2_TILENUM_C[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L2_TILENUM_C_DATA_0)
            int_L2_TILENUM_C[31:0] <= (WDATA[31:0] & wmask) | (int_L2_TILENUM_C[31:0] & ~wmask);
    end
end

// int_L2_TILENUM_W[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L2_TILENUM_W[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L2_TILENUM_W_DATA_0)
            int_L2_TILENUM_W[31:0] <= (WDATA[31:0] & wmask) | (int_L2_TILENUM_W[31:0] & ~wmask);
    end
end

// int_L2_TILENUM_H[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L2_TILENUM_H[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L2_TILENUM_H_DATA_0)
            int_L2_TILENUM_H[31:0] <= (WDATA[31:0] & wmask) | (int_L2_TILENUM_H[31:0] & ~wmask);
    end
end

// int_L2_TILENUM_R[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L2_TILENUM_R[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L2_TILENUM_R_DATA_0)
            int_L2_TILENUM_R[31:0] <= (WDATA[31:0] & wmask) | (int_L2_TILENUM_R[31:0] & ~wmask);
    end
end

// int_L2_TILENUM_S[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L2_TILENUM_S[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L2_TILENUM_S_DATA_0)
            int_L2_TILENUM_S[31:0] <= (WDATA[31:0] & wmask) | (int_L2_TILENUM_S[31:0] & ~wmask);
    end
end

// int_K_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_K_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_K_L2_DATA_0)
            int_K_L2[31:0] <= (WDATA[31:0] & wmask) | (int_K_L2[31:0] & ~wmask);
    end
end

// int_C_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_C_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_C_L2_DATA_0)
            int_C_L2[31:0] <= (WDATA[31:0] & wmask) | (int_C_L2[31:0] & ~wmask);
    end
end

// int_W_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_W_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_W_L2_DATA_0)
            int_W_L2[31:0] <= (WDATA[31:0] & wmask) | (int_W_L2[31:0] & ~wmask);
    end
end

// int_H_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_H_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_H_L2_DATA_0)
            int_H_L2[31:0] <= (WDATA[31:0] & wmask) | (int_H_L2[31:0] & ~wmask);
    end
end

// int_W_in_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_W_in_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_W_IN_L2_DATA_0)
            int_W_in_L2[31:0] <= (WDATA[31:0] & wmask) | (int_W_in_L2[31:0] & ~wmask);
    end
end

// int_H_in_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_H_in_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_H_IN_L2_DATA_0)
            int_H_in_L2[31:0] <= (WDATA[31:0] & wmask) | (int_H_in_L2[31:0] & ~wmask);
    end
end

// int_R_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_R_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_R_L2_DATA_0)
            int_R_L2[31:0] <= (WDATA[31:0] & wmask) | (int_R_L2[31:0] & ~wmask);
    end
end

// int_S_L2[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_S_L2[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_S_L2_DATA_0)
            int_S_L2[31:0] <= (WDATA[31:0] & wmask) | (int_S_L2[31:0] & ~wmask);
    end
end

// int_L1_TILENUM_K[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L1_TILENUM_K[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L1_TILENUM_K_DATA_0)
            int_L1_TILENUM_K[31:0] <= (WDATA[31:0] & wmask) | (int_L1_TILENUM_K[31:0] & ~wmask);
    end
end

// int_L1_TILENUM_C[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L1_TILENUM_C[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L1_TILENUM_C_DATA_0)
            int_L1_TILENUM_C[31:0] <= (WDATA[31:0] & wmask) | (int_L1_TILENUM_C[31:0] & ~wmask);
    end
end

// int_L1_TILENUM_W[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L1_TILENUM_W[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L1_TILENUM_W_DATA_0)
            int_L1_TILENUM_W[31:0] <= (WDATA[31:0] & wmask) | (int_L1_TILENUM_W[31:0] & ~wmask);
    end
end

// int_L1_TILENUM_H[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L1_TILENUM_H[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L1_TILENUM_H_DATA_0)
            int_L1_TILENUM_H[31:0] <= (WDATA[31:0] & wmask) | (int_L1_TILENUM_H[31:0] & ~wmask);
    end
end

// int_L1_TILENUM_R[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L1_TILENUM_R[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L1_TILENUM_R_DATA_0)
            int_L1_TILENUM_R[31:0] <= (WDATA[31:0] & wmask) | (int_L1_TILENUM_R[31:0] & ~wmask);
    end
end

// int_L1_TILENUM_S[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_L1_TILENUM_S[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_L1_TILENUM_S_DATA_0)
            int_L1_TILENUM_S[31:0] <= (WDATA[31:0] & wmask) | (int_L1_TILENUM_S[31:0] & ~wmask);
    end
end

// int_K_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_K_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_K_L1_DATA_0)
            int_K_L1[31:0] <= (WDATA[31:0] & wmask) | (int_K_L1[31:0] & ~wmask);
    end
end

// int_C_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_C_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_C_L1_DATA_0)
            int_C_L1[31:0] <= (WDATA[31:0] & wmask) | (int_C_L1[31:0] & ~wmask);
    end
end

// int_W_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_W_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_W_L1_DATA_0)
            int_W_L1[31:0] <= (WDATA[31:0] & wmask) | (int_W_L1[31:0] & ~wmask);
    end
end

// int_H_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_H_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_H_L1_DATA_0)
            int_H_L1[31:0] <= (WDATA[31:0] & wmask) | (int_H_L1[31:0] & ~wmask);
    end
end

// int_W_in_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_W_in_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_W_IN_L1_DATA_0)
            int_W_in_L1[31:0] <= (WDATA[31:0] & wmask) | (int_W_in_L1[31:0] & ~wmask);
    end
end

// int_H_in_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_H_in_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_H_IN_L1_DATA_0)
            int_H_in_L1[31:0] <= (WDATA[31:0] & wmask) | (int_H_in_L1[31:0] & ~wmask);
    end
end

// int_R_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_R_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_R_L1_DATA_0)
            int_R_L1[31:0] <= (WDATA[31:0] & wmask) | (int_R_L1[31:0] & ~wmask);
    end
end

// int_S_L1[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_S_L1[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_S_L1_DATA_0)
            int_S_L1[31:0] <= (WDATA[31:0] & wmask) | (int_S_L1[31:0] & ~wmask);
    end
end

// int_TILESIZE_W[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_TILESIZE_W[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_TILESIZE_W_DATA_0)
            int_TILESIZE_W[31:0] <= (WDATA[31:0] & wmask) | (int_TILESIZE_W[31:0] & ~wmask);
    end
end

// int_TILESIZE_H[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_TILESIZE_H[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_TILESIZE_H_DATA_0)
            int_TILESIZE_H[31:0] <= (WDATA[31:0] & wmask) | (int_TILESIZE_H[31:0] & ~wmask);
    end
end

// int_TILESIZE_R[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_TILESIZE_R[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_TILESIZE_R_DATA_0)
            int_TILESIZE_R[31:0] <= (WDATA[31:0] & wmask) | (int_TILESIZE_R[31:0] & ~wmask);
    end
end

// int_TILESIZE_S[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_TILESIZE_S[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_TILESIZE_S_DATA_0)
            int_TILESIZE_S[31:0] <= (WDATA[31:0] & wmask) | (int_TILESIZE_S[31:0] & ~wmask);
    end
end

// int_bias_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_bias_addr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_BIAS_ADDR_DATA_0)
            int_bias_addr[31:0] <= (WDATA[31:0] & wmask) | (int_bias_addr[31:0] & ~wmask);
    end
end

// int_weight_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_weight_addr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_WEIGHT_ADDR_DATA_0)
            int_weight_addr[31:0] <= (WDATA[31:0] & wmask) | (int_weight_addr[31:0] & ~wmask);
    end
end

// int_data_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_data_addr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DATA_ADDR_DATA_0)
            int_data_addr[31:0] <= (WDATA[31:0] & wmask) | (int_data_addr[31:0] & ~wmask);
    end
end

// int_output_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_output_addr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_OUTPUT_ADDR_DATA_0)
            int_output_addr[31:0] <= (WDATA[31:0] & wmask) | (int_output_addr[31:0] & ~wmask);
    end
end


//------------------------Memory logic-------------------

endmodule
