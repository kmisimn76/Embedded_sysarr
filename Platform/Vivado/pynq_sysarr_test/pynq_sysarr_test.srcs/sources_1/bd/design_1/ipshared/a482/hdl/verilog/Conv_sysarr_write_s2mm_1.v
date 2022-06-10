// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Conv_sysarr_write_s2mm_1 (
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
        signal_r
);

parameter    ap_ST_fsm_state1 = 7'd1;
parameter    ap_ST_fsm_state2 = 7'd2;
parameter    ap_ST_fsm_state3 = 7'd4;
parameter    ap_ST_fsm_state4 = 7'd8;
parameter    ap_ST_fsm_state5 = 7'd16;
parameter    ap_ST_fsm_state6 = 7'd32;
parameter    ap_ST_fsm_state7 = 7'd64;

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
input  [12:0] signal_r;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg m_axi_dma_control_AWVALID;
reg m_axi_dma_control_WVALID;
reg m_axi_dma_control_BREADY;

(* fsm_encoding = "none" *) reg   [6:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    dma_control_blk_n_AW;
reg    dma_control_blk_n_W;
wire    ap_CS_fsm_state2;
reg    dma_control_blk_n_B;
wire    ap_CS_fsm_state7;
wire  signed [14:0] signal_cast_cast_cast_fu_57_p1;
reg   [6:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 7'd1;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)) | ((m_axi_dma_control_BVALID == 1'b1) & (1'b1 == ap_CS_fsm_state7)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((m_axi_dma_control_BVALID == 1'b1) & (1'b1 == ap_CS_fsm_state7))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        dma_control_blk_n_AW = m_axi_dma_control_AWREADY;
    end else begin
        dma_control_blk_n_AW = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        dma_control_blk_n_B = m_axi_dma_control_BVALID;
    end else begin
        dma_control_blk_n_B = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        dma_control_blk_n_W = m_axi_dma_control_WREADY;
    end else begin
        dma_control_blk_n_W = 1'b1;
    end
end

always @ (*) begin
    if ((~((m_axi_dma_control_AWREADY == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        m_axi_dma_control_AWVALID = 1'b1;
    end else begin
        m_axi_dma_control_AWVALID = 1'b0;
    end
end

always @ (*) begin
    if (((m_axi_dma_control_BVALID == 1'b1) & (1'b1 == ap_CS_fsm_state7))) begin
        m_axi_dma_control_BREADY = 1'b1;
    end else begin
        m_axi_dma_control_BREADY = 1'b0;
    end
end

always @ (*) begin
    if (((m_axi_dma_control_WREADY == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        m_axi_dma_control_WVALID = 1'b1;
    end else begin
        m_axi_dma_control_WVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((m_axi_dma_control_AWREADY == 1'b0) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((m_axi_dma_control_WREADY == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
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
            if (((m_axi_dma_control_BVALID == 1'b1) & (1'b1 == ap_CS_fsm_state7))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

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

assign m_axi_dma_control_AWADDR = 64'd12;

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

assign m_axi_dma_control_WDATA = $unsigned(signal_cast_cast_cast_fu_57_p1);

assign m_axi_dma_control_WID = 1'd0;

assign m_axi_dma_control_WLAST = 1'b0;

assign m_axi_dma_control_WSTRB = 4'd15;

assign m_axi_dma_control_WUSER = 1'd0;

assign signal_cast_cast_cast_fu_57_p1 = $signed(signal_r);

endmodule //Conv_sysarr_write_s2mm_1
