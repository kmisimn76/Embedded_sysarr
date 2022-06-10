// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Wed May  4 21:33:08 2022
// Host        : sumin-desktop running 64-bit Ubuntu 20.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_core_0_0_stub.v
// Design      : design_1_core_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "core,Vivado 2020.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_control_AWADDR, 
  s_axi_control_AWVALID, s_axi_control_AWREADY, s_axi_control_WDATA, s_axi_control_WSTRB, 
  s_axi_control_WVALID, s_axi_control_WREADY, s_axi_control_BRESP, s_axi_control_BVALID, 
  s_axi_control_BREADY, s_axi_control_ARADDR, s_axi_control_ARVALID, 
  s_axi_control_ARREADY, s_axi_control_RDATA, s_axi_control_RRESP, s_axi_control_RVALID, 
  s_axi_control_RREADY, ap_clk, ap_rst_n, interrupt, in_data_TVALID, in_data_TREADY, 
  in_data_TDATA, in_data_TLAST, in_data_TKEEP, in_data_TSTRB, out_data_TVALID, 
  out_data_TREADY, out_data_TDATA, out_data_TLAST, out_data_TKEEP, out_data_TSTRB, 
  m_axi_dma_control_AWADDR, m_axi_dma_control_AWLEN, m_axi_dma_control_AWSIZE, 
  m_axi_dma_control_AWBURST, m_axi_dma_control_AWLOCK, m_axi_dma_control_AWREGION, 
  m_axi_dma_control_AWCACHE, m_axi_dma_control_AWPROT, m_axi_dma_control_AWQOS, 
  m_axi_dma_control_AWVALID, m_axi_dma_control_AWREADY, m_axi_dma_control_WDATA, 
  m_axi_dma_control_WSTRB, m_axi_dma_control_WLAST, m_axi_dma_control_WVALID, 
  m_axi_dma_control_WREADY, m_axi_dma_control_BRESP, m_axi_dma_control_BVALID, 
  m_axi_dma_control_BREADY, m_axi_dma_control_ARADDR, m_axi_dma_control_ARLEN, 
  m_axi_dma_control_ARSIZE, m_axi_dma_control_ARBURST, m_axi_dma_control_ARLOCK, 
  m_axi_dma_control_ARREGION, m_axi_dma_control_ARCACHE, m_axi_dma_control_ARPROT, 
  m_axi_dma_control_ARQOS, m_axi_dma_control_ARVALID, m_axi_dma_control_ARREADY, 
  m_axi_dma_control_RDATA, m_axi_dma_control_RRESP, m_axi_dma_control_RLAST, 
  m_axi_dma_control_RVALID, m_axi_dma_control_RREADY)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_AWADDR[6:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[6:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,interrupt,in_data_TVALID,in_data_TREADY,in_data_TDATA[31:0],in_data_TLAST[0:0],in_data_TKEEP[3:0],in_data_TSTRB[3:0],out_data_TVALID,out_data_TREADY,out_data_TDATA[31:0],out_data_TLAST[0:0],out_data_TKEEP[3:0],out_data_TSTRB[3:0],m_axi_dma_control_AWADDR[31:0],m_axi_dma_control_AWLEN[7:0],m_axi_dma_control_AWSIZE[2:0],m_axi_dma_control_AWBURST[1:0],m_axi_dma_control_AWLOCK[1:0],m_axi_dma_control_AWREGION[3:0],m_axi_dma_control_AWCACHE[3:0],m_axi_dma_control_AWPROT[2:0],m_axi_dma_control_AWQOS[3:0],m_axi_dma_control_AWVALID,m_axi_dma_control_AWREADY,m_axi_dma_control_WDATA[31:0],m_axi_dma_control_WSTRB[3:0],m_axi_dma_control_WLAST,m_axi_dma_control_WVALID,m_axi_dma_control_WREADY,m_axi_dma_control_BRESP[1:0],m_axi_dma_control_BVALID,m_axi_dma_control_BREADY,m_axi_dma_control_ARADDR[31:0],m_axi_dma_control_ARLEN[7:0],m_axi_dma_control_ARSIZE[2:0],m_axi_dma_control_ARBURST[1:0],m_axi_dma_control_ARLOCK[1:0],m_axi_dma_control_ARREGION[3:0],m_axi_dma_control_ARCACHE[3:0],m_axi_dma_control_ARPROT[2:0],m_axi_dma_control_ARQOS[3:0],m_axi_dma_control_ARVALID,m_axi_dma_control_ARREADY,m_axi_dma_control_RDATA[31:0],m_axi_dma_control_RRESP[1:0],m_axi_dma_control_RLAST,m_axi_dma_control_RVALID,m_axi_dma_control_RREADY" */;
  input [6:0]s_axi_control_AWADDR;
  input s_axi_control_AWVALID;
  output s_axi_control_AWREADY;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;
  input s_axi_control_WVALID;
  output s_axi_control_WREADY;
  output [1:0]s_axi_control_BRESP;
  output s_axi_control_BVALID;
  input s_axi_control_BREADY;
  input [6:0]s_axi_control_ARADDR;
  input s_axi_control_ARVALID;
  output s_axi_control_ARREADY;
  output [31:0]s_axi_control_RDATA;
  output [1:0]s_axi_control_RRESP;
  output s_axi_control_RVALID;
  input s_axi_control_RREADY;
  input ap_clk;
  input ap_rst_n;
  output interrupt;
  input in_data_TVALID;
  output in_data_TREADY;
  input [31:0]in_data_TDATA;
  input [0:0]in_data_TLAST;
  input [3:0]in_data_TKEEP;
  input [3:0]in_data_TSTRB;
  output out_data_TVALID;
  input out_data_TREADY;
  output [31:0]out_data_TDATA;
  output [0:0]out_data_TLAST;
  output [3:0]out_data_TKEEP;
  output [3:0]out_data_TSTRB;
  output [31:0]m_axi_dma_control_AWADDR;
  output [7:0]m_axi_dma_control_AWLEN;
  output [2:0]m_axi_dma_control_AWSIZE;
  output [1:0]m_axi_dma_control_AWBURST;
  output [1:0]m_axi_dma_control_AWLOCK;
  output [3:0]m_axi_dma_control_AWREGION;
  output [3:0]m_axi_dma_control_AWCACHE;
  output [2:0]m_axi_dma_control_AWPROT;
  output [3:0]m_axi_dma_control_AWQOS;
  output m_axi_dma_control_AWVALID;
  input m_axi_dma_control_AWREADY;
  output [31:0]m_axi_dma_control_WDATA;
  output [3:0]m_axi_dma_control_WSTRB;
  output m_axi_dma_control_WLAST;
  output m_axi_dma_control_WVALID;
  input m_axi_dma_control_WREADY;
  input [1:0]m_axi_dma_control_BRESP;
  input m_axi_dma_control_BVALID;
  output m_axi_dma_control_BREADY;
  output [31:0]m_axi_dma_control_ARADDR;
  output [7:0]m_axi_dma_control_ARLEN;
  output [2:0]m_axi_dma_control_ARSIZE;
  output [1:0]m_axi_dma_control_ARBURST;
  output [1:0]m_axi_dma_control_ARLOCK;
  output [3:0]m_axi_dma_control_ARREGION;
  output [3:0]m_axi_dma_control_ARCACHE;
  output [2:0]m_axi_dma_control_ARPROT;
  output [3:0]m_axi_dma_control_ARQOS;
  output m_axi_dma_control_ARVALID;
  input m_axi_dma_control_ARREADY;
  input [31:0]m_axi_dma_control_RDATA;
  input [1:0]m_axi_dma_control_RRESP;
  input m_axi_dma_control_RLAST;
  input m_axi_dma_control_RVALID;
  output m_axi_dma_control_RREADY;
endmodule
