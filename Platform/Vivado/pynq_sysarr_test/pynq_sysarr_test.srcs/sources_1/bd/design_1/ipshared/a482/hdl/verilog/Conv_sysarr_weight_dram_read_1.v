// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Conv_sysarr_weight_dram_read_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        m_axi_dma_control_AWVALID,
        m_axi_dma_control_AWREADY,
        m_axi_dma_control_AWADDR,
        m_axi_dma_control_AWID,
        m_axi_dma_control_AWLEN,
        m_axi_dma_control_AWSIZE,
        m_axi_dma_control_AWBURST,
        m_axi_dma_control_AWLOCK,
        m_axi_dma_control_AWCACHE,
        m_axi_dma_control_AWPROT,
        m_axi_dma_control_AWQOS,
        m_axi_dma_control_AWREGION,
        m_axi_dma_control_AWUSER,
        m_axi_dma_control_WVALID,
        m_axi_dma_control_WREADY,
        m_axi_dma_control_WDATA,
        m_axi_dma_control_WSTRB,
        m_axi_dma_control_WLAST,
        m_axi_dma_control_WID,
        m_axi_dma_control_WUSER,
        m_axi_dma_control_ARVALID,
        m_axi_dma_control_ARREADY,
        m_axi_dma_control_ARADDR,
        m_axi_dma_control_ARID,
        m_axi_dma_control_ARLEN,
        m_axi_dma_control_ARSIZE,
        m_axi_dma_control_ARBURST,
        m_axi_dma_control_ARLOCK,
        m_axi_dma_control_ARCACHE,
        m_axi_dma_control_ARPROT,
        m_axi_dma_control_ARQOS,
        m_axi_dma_control_ARREGION,
        m_axi_dma_control_ARUSER,
        m_axi_dma_control_RVALID,
        m_axi_dma_control_RREADY,
        m_axi_dma_control_RDATA,
        m_axi_dma_control_RLAST,
        m_axi_dma_control_RID,
        m_axi_dma_control_RUSER,
        m_axi_dma_control_RRESP,
        m_axi_dma_control_BVALID,
        m_axi_dma_control_BREADY,
        m_axi_dma_control_BRESP,
        m_axi_dma_control_BID,
        m_axi_dma_control_BUSER,
        weight_addr,
        in_data_TDATA,
        in_data_TVALID,
        in_data_TREADY,
        in_data_TKEEP,
        in_data_TSTRB,
        in_data_TLAST,
        kmo,
        cmo,
        rmo,
        smo,
        K_L2,
        C_L2,
        R_L2,
        S_L2,
        L2_TILENUM_C,
        L2_TILENUM_R,
        L2_TILENUM_S,
        weight_l2_0_address0,
        weight_l2_0_ce0,
        weight_l2_0_we0,
        weight_l2_0_d0,
        weight_l2_1_address0,
        weight_l2_1_ce0,
        weight_l2_1_we0,
        weight_l2_1_d0,
        weight_l2_2_address0,
        weight_l2_2_ce0,
        weight_l2_2_we0,
        weight_l2_2_d0,
        weight_l2_3_address0,
        weight_l2_3_ce0,
        weight_l2_3_we0,
        weight_l2_3_d0
);

parameter    ap_ST_fsm_state1 = 63'd1;
parameter    ap_ST_fsm_state2 = 63'd2;
parameter    ap_ST_fsm_state3 = 63'd4;
parameter    ap_ST_fsm_state4 = 63'd8;
parameter    ap_ST_fsm_state5 = 63'd16;
parameter    ap_ST_fsm_state6 = 63'd32;
parameter    ap_ST_fsm_state7 = 63'd64;
parameter    ap_ST_fsm_state8 = 63'd128;
parameter    ap_ST_fsm_state9 = 63'd256;
parameter    ap_ST_fsm_state10 = 63'd512;
parameter    ap_ST_fsm_state11 = 63'd1024;
parameter    ap_ST_fsm_state12 = 63'd2048;
parameter    ap_ST_fsm_state13 = 63'd4096;
parameter    ap_ST_fsm_state14 = 63'd8192;
parameter    ap_ST_fsm_state15 = 63'd16384;
parameter    ap_ST_fsm_state16 = 63'd32768;
parameter    ap_ST_fsm_state17 = 63'd65536;
parameter    ap_ST_fsm_state18 = 63'd131072;
parameter    ap_ST_fsm_state19 = 63'd262144;
parameter    ap_ST_fsm_state20 = 63'd524288;
parameter    ap_ST_fsm_state21 = 63'd1048576;
parameter    ap_ST_fsm_state22 = 63'd2097152;
parameter    ap_ST_fsm_state23 = 63'd4194304;
parameter    ap_ST_fsm_state24 = 63'd8388608;
parameter    ap_ST_fsm_state25 = 63'd16777216;
parameter    ap_ST_fsm_state26 = 63'd33554432;
parameter    ap_ST_fsm_state27 = 63'd67108864;
parameter    ap_ST_fsm_state28 = 63'd134217728;
parameter    ap_ST_fsm_state29 = 63'd268435456;
parameter    ap_ST_fsm_state30 = 63'd536870912;
parameter    ap_ST_fsm_state31 = 63'd1073741824;
parameter    ap_ST_fsm_state32 = 63'd2147483648;
parameter    ap_ST_fsm_state33 = 63'd4294967296;
parameter    ap_ST_fsm_state34 = 63'd8589934592;
parameter    ap_ST_fsm_state35 = 63'd17179869184;
parameter    ap_ST_fsm_state36 = 63'd34359738368;
parameter    ap_ST_fsm_state37 = 63'd68719476736;
parameter    ap_ST_fsm_state38 = 63'd137438953472;
parameter    ap_ST_fsm_state39 = 63'd274877906944;
parameter    ap_ST_fsm_state40 = 63'd549755813888;
parameter    ap_ST_fsm_state41 = 63'd1099511627776;
parameter    ap_ST_fsm_state42 = 63'd2199023255552;
parameter    ap_ST_fsm_state43 = 63'd4398046511104;
parameter    ap_ST_fsm_state44 = 63'd8796093022208;
parameter    ap_ST_fsm_state45 = 63'd17592186044416;
parameter    ap_ST_fsm_state46 = 63'd35184372088832;
parameter    ap_ST_fsm_state47 = 63'd70368744177664;
parameter    ap_ST_fsm_state48 = 63'd140737488355328;
parameter    ap_ST_fsm_state49 = 63'd281474976710656;
parameter    ap_ST_fsm_state50 = 63'd562949953421312;
parameter    ap_ST_fsm_state51 = 63'd1125899906842624;
parameter    ap_ST_fsm_state52 = 63'd2251799813685248;
parameter    ap_ST_fsm_state53 = 63'd4503599627370496;
parameter    ap_ST_fsm_state54 = 63'd9007199254740992;
parameter    ap_ST_fsm_state55 = 63'd18014398509481984;
parameter    ap_ST_fsm_state56 = 63'd36028797018963968;
parameter    ap_ST_fsm_state57 = 63'd72057594037927936;
parameter    ap_ST_fsm_state58 = 63'd144115188075855872;
parameter    ap_ST_fsm_state59 = 63'd288230376151711744;
parameter    ap_ST_fsm_state60 = 63'd576460752303423488;
parameter    ap_ST_fsm_state61 = 63'd1152921504606846976;
parameter    ap_ST_fsm_state62 = 63'd2305843009213693952;
parameter    ap_ST_fsm_state63 = 63'd4611686018427387904;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output   m_axi_dma_control_AWVALID;
input   m_axi_dma_control_AWREADY;
output  [31:0] m_axi_dma_control_AWADDR;
output  [0:0] m_axi_dma_control_AWID;
output  [31:0] m_axi_dma_control_AWLEN;
output  [2:0] m_axi_dma_control_AWSIZE;
output  [1:0] m_axi_dma_control_AWBURST;
output  [1:0] m_axi_dma_control_AWLOCK;
output  [3:0] m_axi_dma_control_AWCACHE;
output  [2:0] m_axi_dma_control_AWPROT;
output  [3:0] m_axi_dma_control_AWQOS;
output  [3:0] m_axi_dma_control_AWREGION;
output  [0:0] m_axi_dma_control_AWUSER;
output   m_axi_dma_control_WVALID;
input   m_axi_dma_control_WREADY;
output  [31:0] m_axi_dma_control_WDATA;
output  [3:0] m_axi_dma_control_WSTRB;
output   m_axi_dma_control_WLAST;
output  [0:0] m_axi_dma_control_WID;
output  [0:0] m_axi_dma_control_WUSER;
output   m_axi_dma_control_ARVALID;
input   m_axi_dma_control_ARREADY;
output  [31:0] m_axi_dma_control_ARADDR;
output  [0:0] m_axi_dma_control_ARID;
output  [31:0] m_axi_dma_control_ARLEN;
output  [2:0] m_axi_dma_control_ARSIZE;
output  [1:0] m_axi_dma_control_ARBURST;
output  [1:0] m_axi_dma_control_ARLOCK;
output  [3:0] m_axi_dma_control_ARCACHE;
output  [2:0] m_axi_dma_control_ARPROT;
output  [3:0] m_axi_dma_control_ARQOS;
output  [3:0] m_axi_dma_control_ARREGION;
output  [0:0] m_axi_dma_control_ARUSER;
input   m_axi_dma_control_RVALID;
output   m_axi_dma_control_RREADY;
input  [31:0] m_axi_dma_control_RDATA;
input   m_axi_dma_control_RLAST;
input  [0:0] m_axi_dma_control_RID;
input  [0:0] m_axi_dma_control_RUSER;
input  [1:0] m_axi_dma_control_RRESP;
input   m_axi_dma_control_BVALID;
output   m_axi_dma_control_BREADY;
input  [1:0] m_axi_dma_control_BRESP;
input  [0:0] m_axi_dma_control_BID;
input  [0:0] m_axi_dma_control_BUSER;
input  [31:0] weight_addr;
input  [7:0] in_data_TDATA;
input   in_data_TVALID;
output   in_data_TREADY;
input  [0:0] in_data_TKEEP;
input  [0:0] in_data_TSTRB;
input  [0:0] in_data_TLAST;
input  [13:0] kmo;
input  [13:0] cmo;
input  [13:0] rmo;
input  [13:0] smo;
input  [31:0] K_L2;
input  [31:0] C_L2;
input  [31:0] R_L2;
input  [31:0] S_L2;
input  [13:0] L2_TILENUM_C;
input  [13:0] L2_TILENUM_R;
input  [13:0] L2_TILENUM_S;
output  [11:0] weight_l2_0_address0;
output   weight_l2_0_ce0;
output   weight_l2_0_we0;
output  [7:0] weight_l2_0_d0;
output  [11:0] weight_l2_1_address0;
output   weight_l2_1_ce0;
output   weight_l2_1_we0;
output  [7:0] weight_l2_1_d0;
output  [11:0] weight_l2_2_address0;
output   weight_l2_2_ce0;
output   weight_l2_2_we0;
output  [7:0] weight_l2_2_d0;
output  [11:0] weight_l2_3_address0;
output   weight_l2_3_ce0;
output   weight_l2_3_we0;
output  [7:0] weight_l2_3_d0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg m_axi_dma_control_AWVALID;
reg[31:0] m_axi_dma_control_AWADDR;
reg m_axi_dma_control_WVALID;
reg[31:0] m_axi_dma_control_WDATA;
reg m_axi_dma_control_BREADY;
reg in_data_TREADY;
reg weight_l2_0_ce0;
reg weight_l2_0_we0;
reg weight_l2_1_ce0;
reg weight_l2_1_we0;
reg weight_l2_2_ce0;
reg weight_l2_2_we0;
reg weight_l2_3_ce0;
reg weight_l2_3_we0;

(* fsm_encoding = "none" *) reg   [62:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    dma_control_blk_n_AW;
wire    ap_CS_fsm_state53;
reg    dma_control_blk_n_W;
wire    ap_CS_fsm_state54;
reg    dma_control_blk_n_B;
wire    ap_CS_fsm_state59;
wire    ap_CS_fsm_state55;
wire    ap_CS_fsm_state60;
reg    in_data_TDATA_blk_n;
wire    ap_CS_fsm_state63;
wire   [31:0] grp_fu_318_p2;
reg  signed [31:0] reg_366;
wire    ap_CS_fsm_state13;
wire    ap_CS_fsm_state21;
reg  signed [31:0] reg_371;
wire    ap_CS_fsm_state14;
wire    ap_CS_fsm_state23;
wire   [27:0] kmo_cast5_fu_376_p1;
wire   [27:0] L2_TILENUM_C_cast4_fu_381_p1;
wire    ap_CS_fsm_state7;
wire   [13:0] empty_82_fu_386_p1;
reg   [13:0] empty_82_reg_593;
wire   [13:0] empty_83_fu_390_p1;
reg   [13:0] empty_83_reg_598;
wire   [13:0] trunc_ln271_fu_394_p1;
reg   [13:0] trunc_ln271_reg_603;
wire    ap_CS_fsm_state8;
wire   [13:0] empty_fu_398_p1;
reg   [13:0] empty_reg_613;
wire  signed [13:0] add_ln271_fu_402_p2;
reg  signed [13:0] add_ln271_reg_618;
wire   [31:0] zext_ln272_1_fu_417_p1;
reg   [13:0] trunc_ln272_1_reg_628;
wire    ap_CS_fsm_state9;
reg   [13:0] mul_ln271_1_reg_638;
wire    ap_CS_fsm_state15;
wire  signed [13:0] add_ln271_1_fu_432_p2;
reg  signed [13:0] add_ln271_1_reg_643;
wire    ap_CS_fsm_state16;
wire    ap_CS_fsm_state17;
wire   [13:0] add_ln271_2_fu_437_p2;
reg   [13:0] add_ln271_2_reg_653;
wire    ap_CS_fsm_state24;
wire   [27:0] zext_ln272_fu_443_p1;
wire    ap_CS_fsm_state25;
wire   [27:0] zext_ln272_2_fu_447_p1;
wire   [13:0] trunc_ln272_fu_451_p1;
reg   [13:0] trunc_ln272_reg_668;
wire    ap_CS_fsm_state31;
wire   [27:0] C_L2_cast_cast27_fu_455_p1;
wire    ap_CS_fsm_state32;
wire   [27:0] zext_ln272_3_fu_459_p1;
wire   [13:0] trunc_ln272_2_fu_463_p1;
reg   [13:0] trunc_ln272_2_reg_683;
wire    ap_CS_fsm_state38;
wire   [27:0] R_L2_cast_cast28_fu_467_p1;
wire    ap_CS_fsm_state39;
wire   [27:0] zext_ln272_4_fu_471_p1;
wire   [13:0] trunc_ln272_3_fu_475_p1;
reg   [13:0] trunc_ln272_3_reg_698;
wire    ap_CS_fsm_state45;
wire   [27:0] S_L2_cast_cast29_fu_479_p1;
wire    ap_CS_fsm_state46;
wire   [27:0] zext_ln272_5_fu_483_p1;
wire   [13:0] trunc_ln271_1_fu_487_p1;
reg   [13:0] trunc_ln271_1_reg_713;
wire    ap_CS_fsm_state52;
wire   [31:0] add_ln273_fu_502_p2;
reg   [31:0] add_ln273_reg_718;
reg    ap_block_state54_io;
wire   [31:0] add_ln275_fu_543_p2;
reg   [31:0] add_ln275_reg_738;
wire    ap_CS_fsm_state61;
reg   [11:0] weight_l2_0_addr_reg_743;
wire   [0:0] icmp_ln275_fu_537_p2;
reg   [11:0] weight_l2_1_addr_reg_748;
reg   [11:0] weight_l2_2_addr_reg_753;
reg   [11:0] weight_l2_3_addr_reg_758;
wire   [2:0] add_ln278_fu_555_p2;
reg   [2:0] add_ln278_reg_766;
wire    ap_CS_fsm_state62;
wire   [1:0] trunc_ln283_fu_561_p1;
reg   [1:0] trunc_ln283_reg_771;
wire   [0:0] icmp_ln278_fu_549_p2;
reg   [31:0] ko_reg_296;
reg   [2:0] ki_reg_307;
wire   [63:0] zext_ln275_fu_529_p1;
wire   [31:0] shl_ln274_fu_522_p2;
reg  signed [31:0] grp_fu_318_p0;
reg  signed [31:0] grp_fu_318_p1;
wire  signed [31:0] empty_82_fu_386_p0;
wire  signed [31:0] empty_83_fu_390_p0;
wire   [27:0] trunc_ln271_fu_394_p0;
wire  signed [31:0] empty_fu_398_p0;
wire   [29:0] lshr_ln_fu_407_p4;
wire   [13:0] add_ln271_2_fu_437_p0;
wire   [27:0] trunc_ln272_fu_451_p0;
wire   [27:0] trunc_ln272_2_fu_463_p0;
wire   [27:0] trunc_ln272_3_fu_475_p0;
wire   [27:0] trunc_ln271_1_fu_487_p0;
wire   [15:0] addr_fu_491_p3;
wire  signed [31:0] add_ln273_fu_502_p0;
wire   [31:0] shl_ln274_fu_522_p0;
wire   [31:0] icmp_ln275_fu_537_p1;
reg   [62:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 63'd1;
end

Conv_sysarr_mul_32s_32s_32_7_1 #(
    .ID( 1 ),
    .NUM_STAGE( 7 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
mul_32s_32s_32_7_1_U5(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_318_p0),
    .din1(grp_fu_318_p1),
    .ce(1'b1),
    .dout(grp_fu_318_p2)
);

Conv_sysarr_add_14ns_14ns_14_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 14 ),
    .din1_WIDTH( 14 ),
    .dout_WIDTH( 14 ))
add_14ns_14ns_14_1_1_U6(
    .din0(trunc_ln271_reg_603),
    .din1(cmo),
    .dout(add_ln271_fu_402_p2)
);

Conv_sysarr_add_14ns_14ns_14_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 14 ),
    .din1_WIDTH( 14 ),
    .dout_WIDTH( 14 ))
add_14ns_14ns_14_1_1_U7(
    .din0(mul_ln271_1_reg_638),
    .din1(rmo),
    .dout(add_ln271_1_fu_432_p2)
);

Conv_sysarr_add_14ns_14ns_14_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 14 ),
    .din1_WIDTH( 14 ),
    .dout_WIDTH( 14 ))
add_14ns_14ns_14_1_1_U8(
    .din0(add_ln271_2_fu_437_p0),
    .din1(smo),
    .dout(add_ln271_2_fu_437_p2)
);

Conv_sysarr_add_32s_32ns_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
add_32s_32ns_32_1_1_U9(
    .din0(add_ln273_fu_502_p0),
    .din1(weight_addr),
    .dout(add_ln273_fu_502_p2)
);

Conv_sysarr_add_32ns_32ns_32_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
add_32ns_32ns_32_1_1_U10(
    .din0(ko_reg_296),
    .din1(32'd1),
    .dout(add_ln275_fu_543_p2)
);

Conv_sysarr_add_3ns_3ns_3_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 3 ),
    .din1_WIDTH( 3 ),
    .dout_WIDTH( 3 ))
add_3ns_3ns_3_1_1_U11(
    .din0(ki_reg_307),
    .din1(3'd1),
    .dout(add_ln278_fu_555_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln275_fu_537_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state61))) begin
        ki_reg_307 <= 3'd0;
    end else if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        ki_reg_307 <= add_ln278_reg_766;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state60) & (m_axi_dma_control_BVALID == 1'b1))) begin
        ko_reg_296 <= 32'd0;
    end else if (((icmp_ln278_fu_549_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state62))) begin
        ko_reg_296 <= add_ln275_reg_738;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state16)) begin
        add_ln271_1_reg_643 <= add_ln271_1_fu_432_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state24)) begin
        add_ln271_2_reg_653 <= add_ln271_2_fu_437_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state8)) begin
        add_ln271_reg_618 <= add_ln271_fu_402_p2;
        empty_reg_613 <= empty_fu_398_p1;
        trunc_ln272_1_reg_628 <= {{K_L2[15:2]}};
    end
end

always @ (posedge ap_clk) begin
    if (((m_axi_dma_control_AWREADY == 1'b1) & (1'b1 == ap_CS_fsm_state53))) begin
        add_ln273_reg_718 <= add_ln273_fu_502_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state61)) begin
        add_ln275_reg_738 <= add_ln275_fu_543_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state62)) begin
        add_ln278_reg_766 <= add_ln278_fu_555_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        empty_82_reg_593 <= empty_82_fu_386_p1;
        empty_83_reg_598 <= empty_83_fu_390_p1;
        trunc_ln271_reg_603 <= trunc_ln271_fu_394_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state15)) begin
        mul_ln271_1_reg_638 <= grp_fu_318_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state13))) begin
        reg_366 <= grp_fu_318_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state23) | (1'b1 == ap_CS_fsm_state14))) begin
        reg_371 <= grp_fu_318_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state52)) begin
        trunc_ln271_1_reg_713 <= trunc_ln271_1_fu_487_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state38)) begin
        trunc_ln272_2_reg_683 <= trunc_ln272_2_fu_463_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state45)) begin
        trunc_ln272_3_reg_698 <= trunc_ln272_3_fu_475_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state31)) begin
        trunc_ln272_reg_668 <= trunc_ln272_fu_451_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln278_fu_549_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state62))) begin
        trunc_ln283_reg_771 <= trunc_ln283_fu_561_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln275_fu_537_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state61))) begin
        weight_l2_0_addr_reg_743 <= zext_ln275_fu_529_p1;
        weight_l2_1_addr_reg_748 <= zext_ln275_fu_529_p1;
        weight_l2_2_addr_reg_753 <= zext_ln275_fu_529_p1;
        weight_l2_3_addr_reg_758 <= zext_ln275_fu_529_p1;
    end
end

always @ (*) begin
    if ((((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)) | ((icmp_ln275_fu_537_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state61)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln275_fu_537_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state61))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state54) | (1'b1 == ap_CS_fsm_state53))) begin
        dma_control_blk_n_AW = m_axi_dma_control_AWREADY;
    end else begin
        dma_control_blk_n_AW = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state60) | (1'b1 == ap_CS_fsm_state59))) begin
        dma_control_blk_n_B = m_axi_dma_control_BVALID;
    end else begin
        dma_control_blk_n_B = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state55) | (1'b1 == ap_CS_fsm_state54))) begin
        dma_control_blk_n_W = m_axi_dma_control_WREADY;
    end else begin
        dma_control_blk_n_W = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state46)) begin
        grp_fu_318_p0 = zext_ln272_5_fu_483_p1;
    end else if ((1'b1 == ap_CS_fsm_state39)) begin
        grp_fu_318_p0 = zext_ln272_4_fu_471_p1;
    end else if ((1'b1 == ap_CS_fsm_state32)) begin
        grp_fu_318_p0 = zext_ln272_3_fu_459_p1;
    end else if ((1'b1 == ap_CS_fsm_state25)) begin
        grp_fu_318_p0 = zext_ln272_fu_443_p1;
    end else if ((1'b1 == ap_CS_fsm_state17)) begin
        grp_fu_318_p0 = add_ln271_1_reg_643;
    end else if ((1'b1 == ap_CS_fsm_state15)) begin
        grp_fu_318_p0 = reg_366;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        grp_fu_318_p0 = add_ln271_reg_618;
    end else if ((1'b1 == ap_CS_fsm_state8)) begin
        grp_fu_318_p0 = zext_ln272_1_fu_417_p1;
    end else if ((1'b1 == ap_CS_fsm_state7)) begin
        grp_fu_318_p0 = R_L2;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        grp_fu_318_p0 = L2_TILENUM_C_cast4_fu_381_p1;
    end else begin
        grp_fu_318_p0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state46)) begin
        grp_fu_318_p1 = S_L2_cast_cast29_fu_479_p1;
    end else if ((1'b1 == ap_CS_fsm_state39)) begin
        grp_fu_318_p1 = R_L2_cast_cast28_fu_467_p1;
    end else if ((1'b1 == ap_CS_fsm_state32)) begin
        grp_fu_318_p1 = C_L2_cast_cast27_fu_455_p1;
    end else if ((1'b1 == ap_CS_fsm_state25)) begin
        grp_fu_318_p1 = zext_ln272_2_fu_447_p1;
    end else if ((1'b1 == ap_CS_fsm_state17)) begin
        grp_fu_318_p1 = L2_TILENUM_S;
    end else if ((1'b1 == ap_CS_fsm_state15)) begin
        grp_fu_318_p1 = reg_371;
    end else if ((1'b1 == ap_CS_fsm_state9)) begin
        grp_fu_318_p1 = L2_TILENUM_R;
    end else if ((1'b1 == ap_CS_fsm_state8)) begin
        grp_fu_318_p1 = S_L2;
    end else if ((1'b1 == ap_CS_fsm_state7)) begin
        grp_fu_318_p1 = C_L2;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        grp_fu_318_p1 = kmo_cast5_fu_376_p1;
    end else begin
        grp_fu_318_p1 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state63)) begin
        in_data_TDATA_blk_n = in_data_TVALID;
    end else begin
        in_data_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        in_data_TREADY = 1'b1;
    end else begin
        in_data_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state54_io) & (1'b1 == ap_CS_fsm_state54))) begin
        m_axi_dma_control_AWADDR = 64'd10;
    end else if (((m_axi_dma_control_AWREADY == 1'b1) & (1'b1 == ap_CS_fsm_state53))) begin
        m_axi_dma_control_AWADDR = 64'd6;
    end else begin
        m_axi_dma_control_AWADDR = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_state54_io) & (1'b1 == ap_CS_fsm_state54)) | ((m_axi_dma_control_AWREADY == 1'b1) & (1'b1 == ap_CS_fsm_state53)))) begin
        m_axi_dma_control_AWVALID = 1'b1;
    end else begin
        m_axi_dma_control_AWVALID = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state60) & (m_axi_dma_control_BVALID == 1'b1)) | ((1'b1 == ap_CS_fsm_state59) & (m_axi_dma_control_BVALID == 1'b1)))) begin
        m_axi_dma_control_BREADY = 1'b1;
    end else begin
        m_axi_dma_control_BREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state55)) begin
        m_axi_dma_control_WDATA = shl_ln274_fu_522_p2;
    end else if ((1'b1 == ap_CS_fsm_state54)) begin
        m_axi_dma_control_WDATA = add_ln273_reg_718;
    end else begin
        m_axi_dma_control_WDATA = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_state54_io) & (1'b1 == ap_CS_fsm_state54)) | ((1'b1 == ap_CS_fsm_state55) & (m_axi_dma_control_WREADY == 1'b1)))) begin
        m_axi_dma_control_WVALID = 1'b1;
    end else begin
        m_axi_dma_control_WVALID = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_0_ce0 = 1'b1;
    end else begin
        weight_l2_0_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((trunc_ln283_reg_771 == 2'd0) & (1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_0_we0 = 1'b1;
    end else begin
        weight_l2_0_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_1_ce0 = 1'b1;
    end else begin
        weight_l2_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((trunc_ln283_reg_771 == 2'd1) & (1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_1_we0 = 1'b1;
    end else begin
        weight_l2_1_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_2_ce0 = 1'b1;
    end else begin
        weight_l2_2_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((trunc_ln283_reg_771 == 2'd2) & (1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_2_we0 = 1'b1;
    end else begin
        weight_l2_2_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_3_ce0 = 1'b1;
    end else begin
        weight_l2_3_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((trunc_ln283_reg_771 == 2'd3) & (1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
        weight_l2_3_we0 = 1'b1;
    end else begin
        weight_l2_3_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state11;
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_state12 : begin
            ap_NS_fsm = ap_ST_fsm_state13;
        end
        ap_ST_fsm_state13 : begin
            ap_NS_fsm = ap_ST_fsm_state14;
        end
        ap_ST_fsm_state14 : begin
            ap_NS_fsm = ap_ST_fsm_state15;
        end
        ap_ST_fsm_state15 : begin
            ap_NS_fsm = ap_ST_fsm_state16;
        end
        ap_ST_fsm_state16 : begin
            ap_NS_fsm = ap_ST_fsm_state17;
        end
        ap_ST_fsm_state17 : begin
            ap_NS_fsm = ap_ST_fsm_state18;
        end
        ap_ST_fsm_state18 : begin
            ap_NS_fsm = ap_ST_fsm_state19;
        end
        ap_ST_fsm_state19 : begin
            ap_NS_fsm = ap_ST_fsm_state20;
        end
        ap_ST_fsm_state20 : begin
            ap_NS_fsm = ap_ST_fsm_state21;
        end
        ap_ST_fsm_state21 : begin
            ap_NS_fsm = ap_ST_fsm_state22;
        end
        ap_ST_fsm_state22 : begin
            ap_NS_fsm = ap_ST_fsm_state23;
        end
        ap_ST_fsm_state23 : begin
            ap_NS_fsm = ap_ST_fsm_state24;
        end
        ap_ST_fsm_state24 : begin
            ap_NS_fsm = ap_ST_fsm_state25;
        end
        ap_ST_fsm_state25 : begin
            ap_NS_fsm = ap_ST_fsm_state26;
        end
        ap_ST_fsm_state26 : begin
            ap_NS_fsm = ap_ST_fsm_state27;
        end
        ap_ST_fsm_state27 : begin
            ap_NS_fsm = ap_ST_fsm_state28;
        end
        ap_ST_fsm_state28 : begin
            ap_NS_fsm = ap_ST_fsm_state29;
        end
        ap_ST_fsm_state29 : begin
            ap_NS_fsm = ap_ST_fsm_state30;
        end
        ap_ST_fsm_state30 : begin
            ap_NS_fsm = ap_ST_fsm_state31;
        end
        ap_ST_fsm_state31 : begin
            ap_NS_fsm = ap_ST_fsm_state32;
        end
        ap_ST_fsm_state32 : begin
            ap_NS_fsm = ap_ST_fsm_state33;
        end
        ap_ST_fsm_state33 : begin
            ap_NS_fsm = ap_ST_fsm_state34;
        end
        ap_ST_fsm_state34 : begin
            ap_NS_fsm = ap_ST_fsm_state35;
        end
        ap_ST_fsm_state35 : begin
            ap_NS_fsm = ap_ST_fsm_state36;
        end
        ap_ST_fsm_state36 : begin
            ap_NS_fsm = ap_ST_fsm_state37;
        end
        ap_ST_fsm_state37 : begin
            ap_NS_fsm = ap_ST_fsm_state38;
        end
        ap_ST_fsm_state38 : begin
            ap_NS_fsm = ap_ST_fsm_state39;
        end
        ap_ST_fsm_state39 : begin
            ap_NS_fsm = ap_ST_fsm_state40;
        end
        ap_ST_fsm_state40 : begin
            ap_NS_fsm = ap_ST_fsm_state41;
        end
        ap_ST_fsm_state41 : begin
            ap_NS_fsm = ap_ST_fsm_state42;
        end
        ap_ST_fsm_state42 : begin
            ap_NS_fsm = ap_ST_fsm_state43;
        end
        ap_ST_fsm_state43 : begin
            ap_NS_fsm = ap_ST_fsm_state44;
        end
        ap_ST_fsm_state44 : begin
            ap_NS_fsm = ap_ST_fsm_state45;
        end
        ap_ST_fsm_state45 : begin
            ap_NS_fsm = ap_ST_fsm_state46;
        end
        ap_ST_fsm_state46 : begin
            ap_NS_fsm = ap_ST_fsm_state47;
        end
        ap_ST_fsm_state47 : begin
            ap_NS_fsm = ap_ST_fsm_state48;
        end
        ap_ST_fsm_state48 : begin
            ap_NS_fsm = ap_ST_fsm_state49;
        end
        ap_ST_fsm_state49 : begin
            ap_NS_fsm = ap_ST_fsm_state50;
        end
        ap_ST_fsm_state50 : begin
            ap_NS_fsm = ap_ST_fsm_state51;
        end
        ap_ST_fsm_state51 : begin
            ap_NS_fsm = ap_ST_fsm_state52;
        end
        ap_ST_fsm_state52 : begin
            ap_NS_fsm = ap_ST_fsm_state53;
        end
        ap_ST_fsm_state53 : begin
            if (((m_axi_dma_control_AWREADY == 1'b1) & (1'b1 == ap_CS_fsm_state53))) begin
                ap_NS_fsm = ap_ST_fsm_state54;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state53;
            end
        end
        ap_ST_fsm_state54 : begin
            if (((1'b0 == ap_block_state54_io) & (1'b1 == ap_CS_fsm_state54))) begin
                ap_NS_fsm = ap_ST_fsm_state55;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state54;
            end
        end
        ap_ST_fsm_state55 : begin
            if (((1'b1 == ap_CS_fsm_state55) & (m_axi_dma_control_WREADY == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state56;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state55;
            end
        end
        ap_ST_fsm_state56 : begin
            ap_NS_fsm = ap_ST_fsm_state57;
        end
        ap_ST_fsm_state57 : begin
            ap_NS_fsm = ap_ST_fsm_state58;
        end
        ap_ST_fsm_state58 : begin
            ap_NS_fsm = ap_ST_fsm_state59;
        end
        ap_ST_fsm_state59 : begin
            if (((1'b1 == ap_CS_fsm_state59) & (m_axi_dma_control_BVALID == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state60;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state59;
            end
        end
        ap_ST_fsm_state60 : begin
            if (((1'b1 == ap_CS_fsm_state60) & (m_axi_dma_control_BVALID == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state61;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state60;
            end
        end
        ap_ST_fsm_state61 : begin
            if (((icmp_ln275_fu_537_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state61))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state62;
            end
        end
        ap_ST_fsm_state62 : begin
            if (((icmp_ln278_fu_549_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state62))) begin
                ap_NS_fsm = ap_ST_fsm_state61;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state63;
            end
        end
        ap_ST_fsm_state63 : begin
            if (((1'b1 == ap_CS_fsm_state63) & (in_data_TVALID == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state62;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state63;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign C_L2_cast_cast27_fu_455_p1 = empty_83_reg_598;

assign L2_TILENUM_C_cast4_fu_381_p1 = L2_TILENUM_C;

assign R_L2_cast_cast28_fu_467_p1 = empty_82_reg_593;

assign S_L2_cast_cast29_fu_479_p1 = empty_reg_613;

assign add_ln271_2_fu_437_p0 = reg_371;

assign add_ln273_fu_502_p0 = $signed(addr_fu_491_p3);

assign addr_fu_491_p3 = {{trunc_ln271_1_reg_713}, {2'd0}};

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state13 = ap_CS_fsm[32'd12];

assign ap_CS_fsm_state14 = ap_CS_fsm[32'd13];

assign ap_CS_fsm_state15 = ap_CS_fsm[32'd14];

assign ap_CS_fsm_state16 = ap_CS_fsm[32'd15];

assign ap_CS_fsm_state17 = ap_CS_fsm[32'd16];

assign ap_CS_fsm_state21 = ap_CS_fsm[32'd20];

assign ap_CS_fsm_state23 = ap_CS_fsm[32'd22];

assign ap_CS_fsm_state24 = ap_CS_fsm[32'd23];

assign ap_CS_fsm_state25 = ap_CS_fsm[32'd24];

assign ap_CS_fsm_state31 = ap_CS_fsm[32'd30];

assign ap_CS_fsm_state32 = ap_CS_fsm[32'd31];

assign ap_CS_fsm_state38 = ap_CS_fsm[32'd37];

assign ap_CS_fsm_state39 = ap_CS_fsm[32'd38];

assign ap_CS_fsm_state45 = ap_CS_fsm[32'd44];

assign ap_CS_fsm_state46 = ap_CS_fsm[32'd45];

assign ap_CS_fsm_state52 = ap_CS_fsm[32'd51];

assign ap_CS_fsm_state53 = ap_CS_fsm[32'd52];

assign ap_CS_fsm_state54 = ap_CS_fsm[32'd53];

assign ap_CS_fsm_state55 = ap_CS_fsm[32'd54];

assign ap_CS_fsm_state59 = ap_CS_fsm[32'd58];

assign ap_CS_fsm_state60 = ap_CS_fsm[32'd59];

assign ap_CS_fsm_state61 = ap_CS_fsm[32'd60];

assign ap_CS_fsm_state62 = ap_CS_fsm[32'd61];

assign ap_CS_fsm_state63 = ap_CS_fsm[32'd62];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];

assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];

always @ (*) begin
    ap_block_state54_io = ((m_axi_dma_control_AWREADY == 1'b0) | (m_axi_dma_control_WREADY == 1'b0));
end

assign empty_82_fu_386_p0 = R_L2;

assign empty_82_fu_386_p1 = empty_82_fu_386_p0[13:0];

assign empty_83_fu_390_p0 = C_L2;

assign empty_83_fu_390_p1 = empty_83_fu_390_p0[13:0];

assign empty_fu_398_p0 = S_L2;

assign empty_fu_398_p1 = empty_fu_398_p0[13:0];

assign icmp_ln275_fu_537_p1 = reg_366;

assign icmp_ln275_fu_537_p2 = ((ko_reg_296 == icmp_ln275_fu_537_p1) ? 1'b1 : 1'b0);

assign icmp_ln278_fu_549_p2 = ((ki_reg_307 == 3'd4) ? 1'b1 : 1'b0);

assign kmo_cast5_fu_376_p1 = kmo;

assign lshr_ln_fu_407_p4 = {{K_L2[31:2]}};

assign m_axi_dma_control_ARADDR = 32'd0;

assign m_axi_dma_control_ARBURST = 2'd0;

assign m_axi_dma_control_ARCACHE = 4'd0;

assign m_axi_dma_control_ARID = 1'd0;

assign m_axi_dma_control_ARLEN = 32'd0;

assign m_axi_dma_control_ARLOCK = 2'd0;

assign m_axi_dma_control_ARPROT = 3'd0;

assign m_axi_dma_control_ARQOS = 4'd0;

assign m_axi_dma_control_ARREGION = 4'd0;

assign m_axi_dma_control_ARSIZE = 3'd0;

assign m_axi_dma_control_ARUSER = 1'd0;

assign m_axi_dma_control_ARVALID = 1'b0;

assign m_axi_dma_control_AWBURST = 2'd0;

assign m_axi_dma_control_AWCACHE = 4'd0;

assign m_axi_dma_control_AWID = 1'd0;

assign m_axi_dma_control_AWLEN = 32'd1;

assign m_axi_dma_control_AWLOCK = 2'd0;

assign m_axi_dma_control_AWPROT = 3'd0;

assign m_axi_dma_control_AWQOS = 4'd0;

assign m_axi_dma_control_AWREGION = 4'd0;

assign m_axi_dma_control_AWSIZE = 3'd0;

assign m_axi_dma_control_AWUSER = 1'd0;

assign m_axi_dma_control_RREADY = 1'b0;

assign m_axi_dma_control_WID = 1'd0;

assign m_axi_dma_control_WLAST = 1'b0;

assign m_axi_dma_control_WSTRB = 4'd15;

assign m_axi_dma_control_WUSER = 1'd0;

assign shl_ln274_fu_522_p0 = reg_366;

assign shl_ln274_fu_522_p2 = shl_ln274_fu_522_p0 << 32'd2;

assign trunc_ln271_1_fu_487_p0 = grp_fu_318_p2;

assign trunc_ln271_1_fu_487_p1 = trunc_ln271_1_fu_487_p0[13:0];

assign trunc_ln271_fu_394_p0 = grp_fu_318_p2;

assign trunc_ln271_fu_394_p1 = trunc_ln271_fu_394_p0[13:0];

assign trunc_ln272_2_fu_463_p0 = grp_fu_318_p2;

assign trunc_ln272_2_fu_463_p1 = trunc_ln272_2_fu_463_p0[13:0];

assign trunc_ln272_3_fu_475_p0 = grp_fu_318_p2;

assign trunc_ln272_3_fu_475_p1 = trunc_ln272_3_fu_475_p0[13:0];

assign trunc_ln272_fu_451_p0 = grp_fu_318_p2;

assign trunc_ln272_fu_451_p1 = trunc_ln272_fu_451_p0[13:0];

assign trunc_ln283_fu_561_p1 = ki_reg_307[1:0];

assign weight_l2_0_address0 = weight_l2_0_addr_reg_743;

assign weight_l2_0_d0 = in_data_TDATA;

assign weight_l2_1_address0 = weight_l2_1_addr_reg_748;

assign weight_l2_1_d0 = in_data_TDATA;

assign weight_l2_2_address0 = weight_l2_2_addr_reg_753;

assign weight_l2_2_d0 = in_data_TDATA;

assign weight_l2_3_address0 = weight_l2_3_addr_reg_758;

assign weight_l2_3_d0 = in_data_TDATA;

assign zext_ln272_1_fu_417_p1 = lshr_ln_fu_407_p4;

assign zext_ln272_2_fu_447_p1 = trunc_ln272_1_reg_628;

assign zext_ln272_3_fu_459_p1 = trunc_ln272_reg_668;

assign zext_ln272_4_fu_471_p1 = trunc_ln272_2_reg_683;

assign zext_ln272_5_fu_483_p1 = trunc_ln272_3_reg_698;

assign zext_ln272_fu_443_p1 = add_ln271_2_reg_653;

assign zext_ln275_fu_529_p1 = ko_reg_296;

endmodule //Conv_sysarr_weight_dram_read_1