// (c) Copyright 1995-2022 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:core:1.0
// IP Revision: 2105042310

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_core_0_0 (
  s_axi_control_AWADDR,
  s_axi_control_AWVALID,
  s_axi_control_AWREADY,
  s_axi_control_WDATA,
  s_axi_control_WSTRB,
  s_axi_control_WVALID,
  s_axi_control_WREADY,
  s_axi_control_BRESP,
  s_axi_control_BVALID,
  s_axi_control_BREADY,
  s_axi_control_ARADDR,
  s_axi_control_ARVALID,
  s_axi_control_ARREADY,
  s_axi_control_RDATA,
  s_axi_control_RRESP,
  s_axi_control_RVALID,
  s_axi_control_RREADY,
  ap_clk,
  ap_rst_n,
  interrupt,
  in_data_TVALID,
  in_data_TREADY,
  in_data_TDATA,
  in_data_TLAST,
  in_data_TKEEP,
  in_data_TSTRB,
  out_data_TVALID,
  out_data_TREADY,
  out_data_TDATA,
  out_data_TLAST,
  out_data_TKEEP,
  out_data_TSTRB,
  m_axi_dma_control_AWADDR,
  m_axi_dma_control_AWLEN,
  m_axi_dma_control_AWSIZE,
  m_axi_dma_control_AWBURST,
  m_axi_dma_control_AWLOCK,
  m_axi_dma_control_AWREGION,
  m_axi_dma_control_AWCACHE,
  m_axi_dma_control_AWPROT,
  m_axi_dma_control_AWQOS,
  m_axi_dma_control_AWVALID,
  m_axi_dma_control_AWREADY,
  m_axi_dma_control_WDATA,
  m_axi_dma_control_WSTRB,
  m_axi_dma_control_WLAST,
  m_axi_dma_control_WVALID,
  m_axi_dma_control_WREADY,
  m_axi_dma_control_BRESP,
  m_axi_dma_control_BVALID,
  m_axi_dma_control_BREADY,
  m_axi_dma_control_ARADDR,
  m_axi_dma_control_ARLEN,
  m_axi_dma_control_ARSIZE,
  m_axi_dma_control_ARBURST,
  m_axi_dma_control_ARLOCK,
  m_axi_dma_control_ARREGION,
  m_axi_dma_control_ARCACHE,
  m_axi_dma_control_ARPROT,
  m_axi_dma_control_ARQOS,
  m_axi_dma_control_ARVALID,
  m_axi_dma_control_ARREADY,
  m_axi_dma_control_RDATA,
  m_axi_dma_control_RRESP,
  m_axi_dma_control_RLAST,
  m_axi_dma_control_RVALID,
  m_axi_dma_control_RREADY
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR" *)
input wire [6 : 0] s_axi_control_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID" *)
input wire s_axi_control_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY" *)
output wire s_axi_control_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WDATA" *)
input wire [31 : 0] s_axi_control_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB" *)
input wire [3 : 0] s_axi_control_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WVALID" *)
input wire s_axi_control_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WREADY" *)
output wire s_axi_control_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BRESP" *)
output wire [1 : 0] s_axi_control_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BVALID" *)
output wire s_axi_control_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BREADY" *)
input wire s_axi_control_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR" *)
input wire [6 : 0] s_axi_control_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID" *)
input wire s_axi_control_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY" *)
output wire s_axi_control_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RDATA" *)
output wire [31 : 0] s_axi_control_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RRESP" *)
output wire [1 : 0] s_axi_control_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RVALID" *)
output wire s_axi_control_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 7, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ\
_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RREADY" *)
input wire s_axi_control_RREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:in_data:out_data:m_axi_dma_control, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
output wire interrupt;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TVALID" *)
input wire in_data_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TREADY" *)
output wire in_data_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TDATA" *)
input wire [31 : 0] in_data_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TLAST" *)
input wire [0 : 0] in_data_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TKEEP" *)
input wire [3 : 0] in_data_TKEEP;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in_data, TDATA_NUM_BYTES 4, TUSER_WIDTH 0, LAYERED_METADATA undef, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in_data TSTRB" *)
input wire [3 : 0] in_data_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TVALID" *)
output wire out_data_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TREADY" *)
input wire out_data_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TDATA" *)
output wire [31 : 0] out_data_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TLAST" *)
output wire [0 : 0] out_data_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TKEEP" *)
output wire [3 : 0] out_data_TKEEP;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_data, TDATA_NUM_BYTES 4, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_data TSTRB" *)
output wire [3 : 0] out_data_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWADDR" *)
output wire [31 : 0] m_axi_dma_control_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWLEN" *)
output wire [7 : 0] m_axi_dma_control_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWSIZE" *)
output wire [2 : 0] m_axi_dma_control_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWBURST" *)
output wire [1 : 0] m_axi_dma_control_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWLOCK" *)
output wire [1 : 0] m_axi_dma_control_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWREGION" *)
output wire [3 : 0] m_axi_dma_control_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWCACHE" *)
output wire [3 : 0] m_axi_dma_control_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWPROT" *)
output wire [2 : 0] m_axi_dma_control_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWQOS" *)
output wire [3 : 0] m_axi_dma_control_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWVALID" *)
output wire m_axi_dma_control_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control AWREADY" *)
input wire m_axi_dma_control_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control WDATA" *)
output wire [31 : 0] m_axi_dma_control_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control WSTRB" *)
output wire [3 : 0] m_axi_dma_control_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control WLAST" *)
output wire m_axi_dma_control_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control WVALID" *)
output wire m_axi_dma_control_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control WREADY" *)
input wire m_axi_dma_control_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control BRESP" *)
input wire [1 : 0] m_axi_dma_control_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control BVALID" *)
input wire m_axi_dma_control_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control BREADY" *)
output wire m_axi_dma_control_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARADDR" *)
output wire [31 : 0] m_axi_dma_control_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARLEN" *)
output wire [7 : 0] m_axi_dma_control_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARSIZE" *)
output wire [2 : 0] m_axi_dma_control_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARBURST" *)
output wire [1 : 0] m_axi_dma_control_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARLOCK" *)
output wire [1 : 0] m_axi_dma_control_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARREGION" *)
output wire [3 : 0] m_axi_dma_control_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARCACHE" *)
output wire [3 : 0] m_axi_dma_control_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARPROT" *)
output wire [2 : 0] m_axi_dma_control_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARQOS" *)
output wire [3 : 0] m_axi_dma_control_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARVALID" *)
output wire m_axi_dma_control_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control ARREADY" *)
input wire m_axi_dma_control_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control RDATA" *)
input wire [31 : 0] m_axi_dma_control_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control RRESP" *)
input wire [1 : 0] m_axi_dma_control_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control RLAST" *)
input wire m_axi_dma_control_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control RVALID" *)
input wire m_axi_dma_control_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_dma_control, ADDR_WIDTH 32, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_\
DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dma_control RREADY" *)
output wire m_axi_dma_control_RREADY;

(* SDX_KERNEL = "true" *)
(* SDX_KERNEL_TYPE = "hls" *)
(* SDX_KERNEL_SIM_INST = "" *)
  core #(
    .C_S_AXI_CONTROL_ADDR_WIDTH(7),
    .C_S_AXI_CONTROL_DATA_WIDTH(32),
    .C_M_AXI_DMA_CONTROL_ID_WIDTH(1),
    .C_M_AXI_DMA_CONTROL_ADDR_WIDTH(32),
    .C_M_AXI_DMA_CONTROL_DATA_WIDTH(32),
    .C_M_AXI_DMA_CONTROL_AWUSER_WIDTH(1),
    .C_M_AXI_DMA_CONTROL_ARUSER_WIDTH(1),
    .C_M_AXI_DMA_CONTROL_WUSER_WIDTH(1),
    .C_M_AXI_DMA_CONTROL_RUSER_WIDTH(1),
    .C_M_AXI_DMA_CONTROL_BUSER_WIDTH(1),
    .C_M_AXI_DMA_CONTROL_USER_VALUE('H00000000),
    .C_M_AXI_DMA_CONTROL_PROT_VALUE('B000),
    .C_M_AXI_DMA_CONTROL_CACHE_VALUE('B0011)
  ) inst (
    .s_axi_control_AWADDR(s_axi_control_AWADDR),
    .s_axi_control_AWVALID(s_axi_control_AWVALID),
    .s_axi_control_AWREADY(s_axi_control_AWREADY),
    .s_axi_control_WDATA(s_axi_control_WDATA),
    .s_axi_control_WSTRB(s_axi_control_WSTRB),
    .s_axi_control_WVALID(s_axi_control_WVALID),
    .s_axi_control_WREADY(s_axi_control_WREADY),
    .s_axi_control_BRESP(s_axi_control_BRESP),
    .s_axi_control_BVALID(s_axi_control_BVALID),
    .s_axi_control_BREADY(s_axi_control_BREADY),
    .s_axi_control_ARADDR(s_axi_control_ARADDR),
    .s_axi_control_ARVALID(s_axi_control_ARVALID),
    .s_axi_control_ARREADY(s_axi_control_ARREADY),
    .s_axi_control_RDATA(s_axi_control_RDATA),
    .s_axi_control_RRESP(s_axi_control_RRESP),
    .s_axi_control_RVALID(s_axi_control_RVALID),
    .s_axi_control_RREADY(s_axi_control_RREADY),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .interrupt(interrupt),
    .in_data_TVALID(in_data_TVALID),
    .in_data_TREADY(in_data_TREADY),
    .in_data_TDATA(in_data_TDATA),
    .in_data_TLAST(in_data_TLAST),
    .in_data_TKEEP(in_data_TKEEP),
    .in_data_TSTRB(in_data_TSTRB),
    .out_data_TVALID(out_data_TVALID),
    .out_data_TREADY(out_data_TREADY),
    .out_data_TDATA(out_data_TDATA),
    .out_data_TLAST(out_data_TLAST),
    .out_data_TKEEP(out_data_TKEEP),
    .out_data_TSTRB(out_data_TSTRB),
    .m_axi_dma_control_AWID(),
    .m_axi_dma_control_AWADDR(m_axi_dma_control_AWADDR),
    .m_axi_dma_control_AWLEN(m_axi_dma_control_AWLEN),
    .m_axi_dma_control_AWSIZE(m_axi_dma_control_AWSIZE),
    .m_axi_dma_control_AWBURST(m_axi_dma_control_AWBURST),
    .m_axi_dma_control_AWLOCK(m_axi_dma_control_AWLOCK),
    .m_axi_dma_control_AWREGION(m_axi_dma_control_AWREGION),
    .m_axi_dma_control_AWCACHE(m_axi_dma_control_AWCACHE),
    .m_axi_dma_control_AWPROT(m_axi_dma_control_AWPROT),
    .m_axi_dma_control_AWQOS(m_axi_dma_control_AWQOS),
    .m_axi_dma_control_AWUSER(),
    .m_axi_dma_control_AWVALID(m_axi_dma_control_AWVALID),
    .m_axi_dma_control_AWREADY(m_axi_dma_control_AWREADY),
    .m_axi_dma_control_WID(),
    .m_axi_dma_control_WDATA(m_axi_dma_control_WDATA),
    .m_axi_dma_control_WSTRB(m_axi_dma_control_WSTRB),
    .m_axi_dma_control_WLAST(m_axi_dma_control_WLAST),
    .m_axi_dma_control_WUSER(),
    .m_axi_dma_control_WVALID(m_axi_dma_control_WVALID),
    .m_axi_dma_control_WREADY(m_axi_dma_control_WREADY),
    .m_axi_dma_control_BID(1'B0),
    .m_axi_dma_control_BRESP(m_axi_dma_control_BRESP),
    .m_axi_dma_control_BUSER(1'B0),
    .m_axi_dma_control_BVALID(m_axi_dma_control_BVALID),
    .m_axi_dma_control_BREADY(m_axi_dma_control_BREADY),
    .m_axi_dma_control_ARID(),
    .m_axi_dma_control_ARADDR(m_axi_dma_control_ARADDR),
    .m_axi_dma_control_ARLEN(m_axi_dma_control_ARLEN),
    .m_axi_dma_control_ARSIZE(m_axi_dma_control_ARSIZE),
    .m_axi_dma_control_ARBURST(m_axi_dma_control_ARBURST),
    .m_axi_dma_control_ARLOCK(m_axi_dma_control_ARLOCK),
    .m_axi_dma_control_ARREGION(m_axi_dma_control_ARREGION),
    .m_axi_dma_control_ARCACHE(m_axi_dma_control_ARCACHE),
    .m_axi_dma_control_ARPROT(m_axi_dma_control_ARPROT),
    .m_axi_dma_control_ARQOS(m_axi_dma_control_ARQOS),
    .m_axi_dma_control_ARUSER(),
    .m_axi_dma_control_ARVALID(m_axi_dma_control_ARVALID),
    .m_axi_dma_control_ARREADY(m_axi_dma_control_ARREADY),
    .m_axi_dma_control_RID(1'B0),
    .m_axi_dma_control_RDATA(m_axi_dma_control_RDATA),
    .m_axi_dma_control_RRESP(m_axi_dma_control_RRESP),
    .m_axi_dma_control_RLAST(m_axi_dma_control_RLAST),
    .m_axi_dma_control_RUSER(1'B0),
    .m_axi_dma_control_RVALID(m_axi_dma_control_RVALID),
    .m_axi_dma_control_RREADY(m_axi_dma_control_RREADY)
  );
endmodule
