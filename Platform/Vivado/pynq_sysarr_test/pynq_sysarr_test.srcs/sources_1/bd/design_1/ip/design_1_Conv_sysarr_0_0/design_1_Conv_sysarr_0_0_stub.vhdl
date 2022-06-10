-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
-- Date        : Wed May 18 06:44:12 2022
-- Host        : sumin-desktop running 64-bit Ubuntu 20.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top design_1_Conv_sysarr_0_0 -prefix
--               design_1_Conv_sysarr_0_0_ design_1_Conv_sysarr_0_0_stub.vhdl
-- Design      : design_1_Conv_sysarr_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_Conv_sysarr_0_0 is
  Port ( 
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_AWREADY : out STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 9 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARREADY : out STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    in_data_TVALID : in STD_LOGIC;
    in_data_TREADY : out STD_LOGIC;
    in_data_TDATA : in STD_LOGIC_VECTOR ( 7 downto 0 );
    in_data_TLAST : in STD_LOGIC_VECTOR ( 0 to 0 );
    in_data_TKEEP : in STD_LOGIC_VECTOR ( 0 to 0 );
    in_data_TSTRB : in STD_LOGIC_VECTOR ( 0 to 0 );
    out_data_TVALID : out STD_LOGIC;
    out_data_TREADY : in STD_LOGIC;
    out_data_TDATA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    out_data_TLAST : out STD_LOGIC_VECTOR ( 0 to 0 );
    out_data_TKEEP : out STD_LOGIC_VECTOR ( 0 to 0 );
    out_data_TSTRB : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_dma_control_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dma_control_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_dma_control_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dma_control_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dma_control_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dma_control_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dma_control_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_AWVALID : out STD_LOGIC;
    m_axi_dma_control_AWREADY : in STD_LOGIC;
    m_axi_dma_control_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dma_control_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_WLAST : out STD_LOGIC;
    m_axi_dma_control_WVALID : out STD_LOGIC;
    m_axi_dma_control_WREADY : in STD_LOGIC;
    m_axi_dma_control_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dma_control_BVALID : in STD_LOGIC;
    m_axi_dma_control_BREADY : out STD_LOGIC;
    m_axi_dma_control_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dma_control_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_dma_control_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dma_control_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dma_control_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dma_control_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dma_control_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dma_control_ARVALID : out STD_LOGIC;
    m_axi_dma_control_ARREADY : in STD_LOGIC;
    m_axi_dma_control_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dma_control_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dma_control_RLAST : in STD_LOGIC;
    m_axi_dma_control_RVALID : in STD_LOGIC;
    m_axi_dma_control_RREADY : out STD_LOGIC;
    out_responsed : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end design_1_Conv_sysarr_0_0;

architecture stub of design_1_Conv_sysarr_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_control_AWADDR[9:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[9:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,interrupt,in_data_TVALID,in_data_TREADY,in_data_TDATA[7:0],in_data_TLAST[0:0],in_data_TKEEP[0:0],in_data_TSTRB[0:0],out_data_TVALID,out_data_TREADY,out_data_TDATA[7:0],out_data_TLAST[0:0],out_data_TKEEP[0:0],out_data_TSTRB[0:0],m_axi_dma_control_AWADDR[31:0],m_axi_dma_control_AWLEN[7:0],m_axi_dma_control_AWSIZE[2:0],m_axi_dma_control_AWBURST[1:0],m_axi_dma_control_AWLOCK[1:0],m_axi_dma_control_AWREGION[3:0],m_axi_dma_control_AWCACHE[3:0],m_axi_dma_control_AWPROT[2:0],m_axi_dma_control_AWQOS[3:0],m_axi_dma_control_AWVALID,m_axi_dma_control_AWREADY,m_axi_dma_control_WDATA[31:0],m_axi_dma_control_WSTRB[3:0],m_axi_dma_control_WLAST,m_axi_dma_control_WVALID,m_axi_dma_control_WREADY,m_axi_dma_control_BRESP[1:0],m_axi_dma_control_BVALID,m_axi_dma_control_BREADY,m_axi_dma_control_ARADDR[31:0],m_axi_dma_control_ARLEN[7:0],m_axi_dma_control_ARSIZE[2:0],m_axi_dma_control_ARBURST[1:0],m_axi_dma_control_ARLOCK[1:0],m_axi_dma_control_ARREGION[3:0],m_axi_dma_control_ARCACHE[3:0],m_axi_dma_control_ARPROT[2:0],m_axi_dma_control_ARQOS[3:0],m_axi_dma_control_ARVALID,m_axi_dma_control_ARREADY,m_axi_dma_control_RDATA[31:0],m_axi_dma_control_RRESP[1:0],m_axi_dma_control_RLAST,m_axi_dma_control_RVALID,m_axi_dma_control_RREADY,out_responsed[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "Conv_sysarr,Vivado 2020.1";
begin
end;
