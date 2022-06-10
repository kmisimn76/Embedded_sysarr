#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"

#define mm2s_ctrl_reg 0x00
#define mm2s_status_reg 0x04
#define mm2s_source_addr_reg 0x18
#define mm2s_length_reg 0x28

#define s2mm_ctrl_reg 0x30
#define s2mm_status_reg 0x34
#define s2mm_dest_addr_reg 0x48
#define s2mm_length_reg 0x58

typedef ap_axis <32, 0, 0, 0> AXIS_DATA;
typedef ap_uint <1> SIGNAL;

extern "C" {

void core(
		//**
		// Data format example (n=3, transfn=4, intervn=2): (1234)--(5678)--(9ABC)--
		//**
		unsigned int n, //repeat number
		unsigned int transfn, // length(4byte) of a packet
		unsigned int intervn,  // interval(4byte) between packets
		unsigned int source_addr,
		unsigned int dest_addr,
		hls::stream<AXIS_DATA> &in_data,
		hls::stream<AXIS_DATA> &out_data,
		volatile unsigned int* dma_control
		//,volatile SIGNAL s2mm_bvaild
		)
{
	#pragma HLS INTERFACE s_axilite port=n offset=0x00000024
	#pragma HLS INTERFACE s_axilite port=transfn offset=0x0000002C
	#pragma HLS INTERFACE s_axilite port=intervn offset=0x00000034
	#pragma HLS INTERFACE s_axilite port=source_addr offset=0x0000003C
	#pragma HLS INTERFACE s_axilite port=dest_addr offset=0x00000044
	#pragma HLS INTERFACE axis port=in_data
	#pragma HLS INTERFACE axis port=out_data
	#pragma HLS INTERFACE m_axi port=dma_control offset=off
	#pragma HLS INTERFACE s_axilite port = return register offset=0x00000000
	//#pragma HLS INTERFACE ap_none port=s2mm_bvaild

	unsigned int input_addr = source_addr;
	unsigned int output_addr = dest_addr;

	volatile unsigned int signal;

	//reset channel
	signal = 0x04;
	dma_control[s2mm_ctrl_reg>>2] = signal;
	dma_control[mm2s_ctrl_reg>>2] = signal;
	//halt channel
	signal = 0x00;
	dma_control[s2mm_ctrl_reg>>2] = signal;
	dma_control[mm2s_ctrl_reg>>2] = signal;
	//== DMA is ready

    //set run channel & mask interrupts
	signal = 0xf001;
	dma_control[s2mm_ctrl_reg>>2] = signal; //s2mm channel running
	dma_control[mm2s_ctrl_reg>>2] = signal; //mm2s channel running
/*	//set dma addr
	dma_control[mm2s_source_addr_reg>>2] = input_addr;
	dma_control[s2mm_dest_addr_reg>>2] = output_addr;
	//set write dma length
	dma_control[s2mm_length_reg>>2] = transfer_len;
	//set read dma length
	dma_control[mm2s_length_reg>>2] = transfer_len;
*/

	for(unsigned int r = 0; r < n; r++) {
		//set dma addr
		dma_control[mm2s_source_addr_reg>>2] = input_addr + (((transfn*2) + intervn)*r)*4;
		dma_control[s2mm_dest_addr_reg>>2] = output_addr + ((transfn + intervn)*r)*4;
		//set dma length
		dma_control[s2mm_length_reg>>2] = transfn<<2; //4bytes
		dma_control[mm2s_length_reg>>2] = (transfn*2)<<2; //4bytes
		AXIS_DATA buffer[128];
	#pragma HLS ARRAY_PARTITION variable=buffer dim=0 complete
		for(int i = 0; i < transfn*2; i++) {
			#pragma HLS pipeline
			AXIS_DATA temp;
			in_data.read(temp);
			buffer[i] = temp;
		}
		for(int i = 0; i < transfn; i++) {
			#pragma HLS pipeline
			AXIS_DATA temp, temp2;
			temp = buffer[i*2];
			temp2 = buffer[i*2+1];
			temp.data = temp.data +temp2.data + 0x10022;
			temp.last = (i==transfn-1);
			out_data.write(temp);
		}
		//volatile int dma_write_status = dma_control[s2mm_status_reg>>2];
		/*SIGNAL status = s2mm_bvaild;
		while(status==0) {
			status = s2mm_bvaild;
			//dma_write_status = dma_control[s2mm_status_reg>>2];
		}*/
	}

}
}
