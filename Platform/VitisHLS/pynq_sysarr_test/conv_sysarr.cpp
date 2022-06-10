
#include "hw_param.h"

//#define INPUT_SPARSE

// using macro in PRAGMA
#define PRAGMA_SUB(x) _Pragma (#x)
#define DO_PRAGMA(x) PRAGMA_SUB(x)

//#define   BIAS_DRAM_DEPTH 1280
//#define WEIGHT_DRAM_DEPTH 23040
//#define   DATA_DRAM_DEPTH 20480
//#define OUTPUT_DRAM_DEPTH 15680
#define   DATA_L2_SIZE 2048
#define WEIGHT_L2_SIZE 2304
#define OUTPUT_L2_SIZE 1568
//#define   DATA_L2_SIZE 817216
//#define WEIGHT_L2_SIZE 589824
//#define OUTPUT_L2_SIZE 802816
#define   BIAS_L2_SIZE 128
#define   DATA_L1_SIZE 200 //49
#define WEIGHT_L1_SIZE -1
#define OUTPUT_L1_SIZE 200 //49
#define STREAM_BUFFER_SIZE 32 // <= L2 WH(WH_in) size


typedef ap_axis <8, 0, 0, 0> AXIS_DATA;
#define mm2s_ctrl_reg 0x00
#define mm2s_status_reg 0x04
#define mm2s_source_addr_reg 0x18
#define mm2s_length_reg 0x28

#define s2mm_ctrl_reg 0x30
#define s2mm_status_reg 0x34
#define s2mm_dest_addr_reg 0x48
#define s2mm_length_reg 0x58

#ifndef XILINX
extern "C" {
#endif
void runWeight2Reg(DPTYPE weight_regfile[ARRAY_K][ARRAY_C], DPTYPE weight_l2[ARRAY_C][WEIGHT_L2_SIZE], const uint C,
		const uint R, const uint S, const uint ko, const uint co, const uint r, const uint s) {
#pragma HLS ALLOCATION instances=mul limit=1 operation
	for (int ci = 0; ci < ARRAY_C; ci++) {
		#pragma HLS pipeline
			for (int ki = 0; ki < ARRAY_K; ki++) {
			#pragma HLS unroll
			int k = (ko * ARRAY_K + ki);
			int c = (co * ARRAY_C + ci);
			weight_regfile[ki][ci] = weight_l2[ki][ko * C * R
					* S + c * R * S + r * S + s];
		}
	}
}

void runDataL2toL1(DPTYPE (*data_l1)[ARRAY_C], DPTYPE (*data_l2)[ARRAY_C], uint TILESIZE_H,
		uint TILESIZE_W, uint co, uint ho, uint wo, uint r, uint s, uint W_in, uint H_in) {
#pragma HLS ALLOCATION instances=mul limit=1 operation
	LOOP_L2_H_IN: for (int hi = 0; hi < TILESIZE_H; hi++) {
		#pragma HLS loop_tripcount min=14 max=14
		LOOP_L2_W_IN: for (int wi = 0; wi < TILESIZE_W; wi++) {
			#pragma HLS loop_tripcount min=14 max=14
			for (int ci = 0; ci < ARRAY_C; ci++) { // place unroll to inner-most
				#pragma HLS unroll
				int c = (co * ARRAY_C + ci);
				int h = (ho * TILESIZE_H + hi) + r;
				int w = (wo * TILESIZE_W + wi) + s;
				data_l1[hi * TILESIZE_W + wi][ci] =
						data_l2[co * H_in * W_in + h * W_in + w][ci];
			}
		}
	}
}

void runOutputL1toL2(MACTYPE (*output_l1)[ARRAY_K], MACTYPE (*output_l2)[ARRAY_K], MACTYPE (*output_l2_reduction)[ARRAY_K],
		uint TILESIZE_H, uint TILESIZE_W, uint ko, uint ho, uint wo, uint W, uint H, bool isFirst) {
#pragma HLS ALLOCATION instances=mul limit=1 operation
#pragma HLS dependence variable=output_l2
#pragma HLS dependence variable=output_l2_reduction
	LOOP_L2_H: for (int hi = 0; hi < TILESIZE_H; hi++) {
		#pragma HLS loop_tripcount min=14 max=14
		LOOP_L2_W: for (int wi = 0; wi < TILESIZE_W; wi++) {
			#pragma HLS loop_tripcount min=14 max=14
			for (int ki = 0; ki < ARRAY_K; ki++) { // place unroll to inner-most
				#pragma HLS unroll
				int k = (ko * ARRAY_K + ki);
				int h = (ho * TILESIZE_H + hi);
				int w = (wo * TILESIZE_W + wi);
				if(isFirst)
					output_l2_reduction[ko * H * W + h * W + w][ki]
						= output_l1[hi * TILESIZE_W + wi][ki];
				else
					output_l2_reduction[ko * H * W + h * W + w][ki]
						+= output_l1[hi * TILESIZE_W + wi][ki];
				output_l2[ko * H * W + h * W + w][ki]
						= output_l2_reduction[ko * H * W + h * W + w][ki];
			}
		}
	}
}

void doSysArrPE(const DPTYPE weight_regfile[ARRAY_K][ARRAY_C], const DPTYPE (*data_l1)[ARRAY_C],
		DPTYPE data_reg[ARRAY_K][ARRAY_C], MACTYPE output_reg[ARRAY_K][ARRAY_C],
		MACTYPE (*output_l1_local)[ARRAY_K], MACTYPE (*output_l1)[ARRAY_K],
		uint hi, uint wi, uint TILESIZE_H, uint TILESIZE_W, uint TILESIZE_R, uint TILESIZE_S, bool isFirst) {
#pragma HLS inline //for pipelining
	// Push Input
	int i = hi*TILESIZE_W + wi;
	DPTYPE input_data[ARRAY_C];
	#pragma HLS array_partition variable=input_data complete
	for (int ci = 0; ci < ARRAY_C; ci++) {
		#pragma HLS unroll
		if (i - ci >= 0)
			input_data[ci] = data_l1[i - ci][ci];
		else
			input_data[ci] = 0; //Bubble
	}

	// SysArr
	for (int ki = ARRAY_K - 1; ki >= 0; ki--) { // SysArr DIM : K
		#pragma HLS unroll
		for (int ci = ARRAY_C - 1; ci >= 0; ci--) { // SysArr DIM : C
			#pragma HLS unroll
			data_reg[ki][ci] =
					(ki == 0) ? (input_data[ci]) : (data_reg[(ki - 1)][ci]);
			MACTYPE psum =
					(ci == 0) ?
							(0) : (output_reg[ki][(ci - 1)]);
			output_reg[ki][ci] = psum
					+ (data_reg[ki][ci]	* weight_regfile[ki][ci]);
		}
	}

	// Pull Output
	for (int ki = ARRAY_K - 1; ki >= 0; ki--) {
		#pragma HLS unroll
		if ((i - ARRAY_C + 1) - ki >= 0 && (i - ARRAY_C + 1) - ki < TILESIZE_W * TILESIZE_H) { //is needed?
			output_l1[((i - ARRAY_C + 1) - ki)][ki] = output_reg[ki][(ARRAY_C - 1)];
		}
	}
}
void runSysArr(const DPTYPE weight_regfile[ARRAY_K][ARRAY_C], const DPTYPE (*data_l1)[ARRAY_C],
		MACTYPE (*output_l1_local)[ARRAY_K], MACTYPE (*output_l1)[ARRAY_K],
		int input_rows,
		int bubble_h, int bubble_w,
		uint TILESIZE_H, uint TILESIZE_W, uint TILESIZE_R, uint TILESIZE_S,
		bool isFirst) {

	DPTYPE data_reg[ARRAY_K][ARRAY_C];
	#pragma HLS dependence variable=data_reg
	MACTYPE output_reg[ARRAY_K][ARRAY_C];
	#pragma HLS ARRAY_PARTITION variable=data_reg dim=0 complete // Register
	#pragma HLS ARRAY_PARTITION variable=output_reg dim=0 complete  // Register
	LOOP_R_INNER: for (int ri = 0; ri < TILESIZE_R; ri++) {
		#pragma HLS LOOP_TRIPCOUNT max=1 min=1
		LOOP_S_INNER: for (int si = 0; si < TILESIZE_S; si++) {
			#pragma HLS LOOP_TRIPCOUNT max=1 min=1
			#pragma HLS loop_flatten
			LOOP_INPUT_ROW: for (int i = 0; i < input_rows; i++) {
			#pragma HLS LOOP_TRIPCOUNT max=196 min=196
				{
					#pragma HLS DEPENDENCE variable=output_l1
					#pragma HLS DEPENDENCE variable=output_l1_local
					#pragma HLS pipeline rewind
					#pragma HLS latency min=1 max=1 // systolic array implementation -> frequency down
					int hi = (i) / TILESIZE_W;
					int wi = (i) % TILESIZE_W;
					doSysArrPE(weight_regfile, data_l1,
							data_reg, output_reg,
							output_l1_local, output_l1,
							hi, wi, TILESIZE_H, TILESIZE_W, TILESIZE_R, TILESIZE_S, isFirst);
				}
			}
		}
	}
}

void runSIMD(const DPTYPE weight_regfile[ARRAY_K][ARRAY_C], const DPTYPE (*data_l1)[ARRAY_C],
		MACTYPE (*output_l1_local)[ARRAY_K], MACTYPE (*output_l1)[ARRAY_K],
		int input_rows,
		int bubble_h, int bubble_w,
		uint TILESIZE_H, uint TILESIZE_W, uint TILESIZE_R, uint TILESIZE_S,
		bool isFirst) {

	DPTYPE data_reg[ARRAY_K][ARRAY_C];
	#pragma HLS dependence variable=data_reg
	MACTYPE output_reg[ARRAY_K][ARRAY_C];
	#pragma HLS ARRAY_PARTITION variable=data_reg dim=0 complete // Register
	#pragma HLS ARRAY_PARTITION variable=output_reg dim=0 complete  // Register
	LOOP_R_INNER: for (int ri = 0; ri < TILESIZE_R; ri++) {
		#pragma HLS LOOP_TRIPCOUNT max=1 min=1
		LOOP_S_INNER: for (int si = 0; si < TILESIZE_S; si++) {
			#pragma HLS LOOP_TRIPCOUNT max=1 min=1
			//#pragma HLS loop_flatten
			LOOP_H_INNER: for (int hi = 0; hi < TILESIZE_H; hi++) {
				#pragma HLS LOOP_TRIPCOUNT max=14 min=14
				LOOP_W_INNER: for (int wi = 0; wi < TILESIZE_W; wi++) {
					#pragma HLS LOOP_TRIPCOUNT max=14 min=14
					#pragma HLS DEPENDENCE variable=output_l1
					#pragma HLS DEPENDENCE variable=output_l1_local
					#pragma HLS pipeline rewind
					LOOP_K_INNER: for (int ki = 0; ki < ARRAY_K; ki++) {
						#pragma HLS unroll
						LOOP_C_INNER: for (int ci = 0; ci < ARRAY_C; ci++) {
							#pragma HLS unroll
							data_reg[ki][ci] = data_l1[hi * TILESIZE_W + wi][ci];
							output_reg[ki][ci] = data_reg[ki][ci] * weight_regfile[ki][ci];
						}
					}

					// reduction
					LOOP_REDUCTION_K: for (int ki = 0; ki < ARRAY_K; ki++) {
						#pragma HLS unroll
						MACTYPE sum = 0;
						LOOP_REDUCTION_C: for (int ci = 0; ci < ARRAY_C; ci++) {
							#pragma HLS unroll
							sum += output_reg[ki][ci];
						}
						output_l1[hi * TILESIZE_W + wi][ki] = sum;
					}
				}
			}
		}
	}
}

DPTYPE bias_l2[ARRAY_K][BIAS_L2_SIZE];
DPTYPE weight_l2[ARRAY_K][WEIGHT_L2_SIZE];
DPTYPE data_l2[DATA_L2_SIZE][ARRAY_C];
MACTYPE output_l2[OUTPUT_L2_SIZE][ARRAY_K];
MACTYPE output_l2_reduction[OUTPUT_L2_SIZE][ARRAY_K];

void write_mm2s(volatile unsigned int* dma_control,uint signal)
{
#pragma HLS INLINE off
	dma_control[mm2s_ctrl_reg>>2] = signal;
	volatile uint status = dma_control[mm2s_status_reg>>2];
	/*while(!(status!=0)) {
		status = dma_control[mm2s_status_reg>>2];
	}*/
}
void write_s2mm(volatile unsigned int* dma_control,uint signal)
{
#pragma HLS INLINE off
	dma_control[s2mm_ctrl_reg>>2] = signal;
	volatile uint status = dma_control[s2mm_status_reg>>2];
	/*while(!(status!=0)) {
		status = dma_control[s2mm_status_reg>>2];
	}*/
}



void weight_dram_read(DPTYPE weight_l2[ARRAY_K][WEIGHT_L2_SIZE], //hls::stream<DP_AXIS_DATA> &weight_in,
		unsigned int bias_addr,
		unsigned int weight_addr,
		unsigned int data_addr,
		unsigned int output_addr,
		hls::stream<AXIS_DATA> &in_data,
		hls::stream<AXIS_DATA> &out_data,
		volatile unsigned int* dma_control,
						uint kmo, uint cmo, uint rmo, uint smo,
						uint K_L2, uint C_L2, uint R_L2, uint S_L2,
						uint L2_TILENUM_K, uint L2_TILENUM_C, uint L2_TILENUM_R, uint L2_TILENUM_S)
{
#pragma HLS ALLOCATION instances=mul limit=1 operation
		WEIGHT_DRAM_READ:
		//set dma addr&length : weight
		short addr;
		#pragma HLS BIND_OP variable=addr op=mul impl=fabric
		addr = ((kmo*(L2_TILENUM_C)*(L2_TILENUM_R)*(L2_TILENUM_S)+cmo*(L2_TILENUM_R)*(L2_TILENUM_S)+rmo*(L2_TILENUM_S)+smo)
				*(K_L2/VEC_SIZE)*C_L2*R_L2*S_L2 )*VEC_SIZE;
		dma_control[mm2s_source_addr_reg>>2] = weight_addr + addr;
		dma_control[mm2s_length_reg>>2] = (K_L2 / VEC_SIZE)*C_L2*R_L2*S_L2*VEC_SIZE; //1bytes * len(weight), 8*8*3*3/4
		for (unsigned int ko = 0; ko < (K_L2 / VEC_SIZE)*C_L2*R_L2*S_L2; ko++) { //burst read
		#pragma HLS loop_tripcount min=36 max=36
			#pragma HLS pipeline off
			for (unsigned int ki = 0; ki < VEC_SIZE; ki++) { // TODO: split VECSIZE -> (VECSIZE/ARRAY_K) / ARRAY_K
				//#pragma HLS unroll
				unsigned int kcrs = ko
				AXIS_DATA temp;
				in_data.read(temp);
				weight_l2[ki][kcrs] = temp.data;
			}
		}
}
void input_dram_read(DPTYPE data_l2[DATA_L2_SIZE][ARRAY_C], //hls::stream<DP_AXIS_DATA> &data_in,
		unsigned int bias_addr,
		unsigned int weight_addr,
		unsigned int data_addr,
		unsigned int output_addr,
		hls::stream<AXIS_DATA> &in_data,
		hls::stream<AXIS_DATA> &out_data,
		volatile unsigned int* dma_control,
						uint cmo, uint hmo, uint wmo,
						uint C_L2, uint H_L2, uint W_L2, uint H_in_L2, uint W_in_L2, uint WH_in)
{
#pragma HLS ALLOCATION instances=mul limit=1 operation
		INPUT_DRAM_READ:
		for (unsigned int co = 0; co < C_L2/VEC_SIZE; co++) {
			#pragma HLS loop_tripcount min=1 max=1
			for(unsigned int h = 0; h < H_in_L2; h++) {
				#pragma HLS loop_tripcount min=9 max=9
				#pragma HLS pipeline off
				for(unsigned int w = 0; w < W_in_L2; w++) {
					#pragma HLS loop_tripcount min=9 max=9
					#pragma HLS pipeline off
					//set dma addr&length : data
					short addr;
					#pragma HLS BIND_OP variable=addr op=mul impl=fabric
					addr = ((cmo*(C_L2/VEC_SIZE)+co)*WH_in*WH_in + (hmo*H_L2+h)*WH_in + (wmo*W_L2+w))*VEC_SIZE;
					dma_control[mm2s_source_addr_reg>>2] = data_addr + addr;
					dma_control[mm2s_length_reg>>2] = VEC_SIZE; //4bytes * len(conv_out)
					for(unsigned int ci = 0; ci < VEC_SIZE; ci++) { // TODO: split VECSIZE -> (VECSIZE/ARRAY_C) / ARRAY_C
						//#pragma HLS unroll
						unsigned int chw = co*H_in_L2*W_in_L2 + h*W_in_L2 + w;
						AXIS_DATA temp;
						in_data.read(temp);
						data_l2[chw][ci] = temp.data;
					}
				}
			}
		}
}

void output_dram_write(MACTYPE output_l2[OUTPUT_L2_SIZE][ARRAY_K], //hls::stream<MAC_AXIS_DATA> &conv_out,
		unsigned int bias_addr,
		unsigned int weight_addr,
		unsigned int data_addr,
		unsigned int output_addr,
		hls::stream<AXIS_DATA> &in_data,
		hls::stream<AXIS_DATA> &out_data,
		volatile unsigned int* dma_control, ap_uint<1> out_responsed,
						uint kmo, uint hmo, uint wmo,
						uint K_L2, uint H_L2, uint W_L2, uint WH)
{
#pragma HLS ALLOCATION instances=mul limit=1 operation
#pragma HLS BIND_OP variable=dma_control op=mul impl=fabric
		MACTYPE stream_buffer[STREAM_BUFFER_SIZE][VEC_SIZE];
		OUTPUT_DRAM_WRITE:
		for (unsigned int ko = 0; ko < (K_L2 / VEC_SIZE); ko++) {
			#pragma HLS loop_tripcount min=1 max=1
			for (unsigned int h = 0; h < H_L2; h++) {
				#pragma HLS loop_tripcount min=7 max=7
				//set dma addr&length : conv out read
				short addr;
				#pragma HLS BIND_OP variable=addr op=mul impl=fabric
				addr = (wmo*W_L2*VEC_SIZE)*4;
				//dma_control[mm2s_source_addr_reg>>2] = output_addr + (((kmo*(K_L2/VEC_SIZE)+ko)*WH*WH + (hmo*H_L2+h)*WH + (wmo*W_L2))*VEC_SIZE)*4; // critical path
				dma_control[mm2s_source_addr_reg>>2] = output_addr + addr; // critical path
				dma_control[mm2s_length_reg>>2] = (W_L2*VEC_SIZE)*4; //4bytes * len(conv_out)
				//set dma addr&length : conv out write
				//dma_control[s2mm_dest_addr_reg>>2] = output_addr + (((kmo*(K_L2/VEC_SIZE)+ko)*WH*WH + (hmo*H_L2+h)*WH + (wmo*W_L2))*VEC_SIZE)*4;
				dma_control[s2mm_dest_addr_reg>>2] = output_addr + addr; // critical path
				dma_control[s2mm_length_reg>>2] = (W_L2*VEC_SIZE)*4; //4bytes * len(conv_out)
				OUTPUT_DRAM_STREA_IN: for (unsigned int w = 0; w < W_L2; w++) {
					#pragma HLS loop_tripcount min=7 max=7
					#pragma HLS pipeline off
					for (unsigned int ki = 0; ki < VEC_SIZE; ki++) { // TODO: split VECSIZE -> (VECSIZE/ARRAY_K) / ARRAY_K
						//#pragma HLS unroll
						unsigned int khw = ko*H_L2*W_L2 + h*W_L2 + w;
						int read_data;
						AXIS_DATA temp;
						in_data.read(temp); read_data = temp.data;
						in_data.read(temp); read_data += temp.data<<8;
						in_data.read(temp); read_data += temp.data<<16;
						in_data.read(temp); read_data += temp.data<<24;
						stream_buffer[w][ki] = read_data;
					}
				}
				OUTPUT_DRAM_STREA_OUT: for (unsigned int w = 0; w < W_L2; w++) {
					#pragma HLS loop_tripcount min=7 max=7
					#pragma HLS pipeline off
					for (unsigned int ki = 0; ki < VEC_SIZE; ki++) { // TODO: split VECSIZE -> (VECSIZE/ARRAY_K) / ARRAY_K
						//#pragma HLS unroll
						unsigned int khw = ko*H_L2*W_L2 + h*W_L2 + w;
						int write_data = stream_buffer[w][ki] + output_l2[khw][ki];
						AXIS_DATA temp;
						temp.last = 0; temp.data = (write_data & 0x000000FF); out_data.write(temp); //little endian
						temp.last = 0; temp.data = (write_data & 0x0000FF00)>>8; out_data.write(temp);
						temp.last = 0; temp.data = (write_data & 0x00FF0000)>>16; out_data.write(temp);
						temp.last = (/*ki%4==3*//*max burst*/ /*||*/ ki==VEC_SIZE-1/*(w*VEC_SIZE+ki) == (W_L2*VEC_SIZE)-1*/); temp.data = (write_data & 0xFF000000)>>24; out_data.write(temp);
					}
				}
				ap_uint<1> resp = out_responsed;
				while(!resp) {
					resp = out_responsed;
				}
				write_s2mm(dma_control, 0x0001);
				write_s2mm(dma_control, 0x7001);
			}
		}
}

void Conv_sysarr(
		//NPU_PARAM param,
	    uint K,
	    uint C,
	    uint WH,
	    uint WH_in,
	    uint RS,
		uint L2_TILENUM_K,///
		uint L2_TILENUM_C,
	    uint L2_TILENUM_W, // W Size of a tile
	    uint L2_TILENUM_H,
	    uint L2_TILENUM_R,
	    uint L2_TILENUM_S,
	    uint K_L2,
	    uint C_L2,
	    uint W_L2,
	    uint H_L2,
	    uint W_in_L2,
	    uint H_in_L2,
	    uint R_L2,
	    uint S_L2,
		uint L1_TILENUM_K,///
		uint L1_TILENUM_C,
	    uint L1_TILENUM_W, // W Size of a tile
	    uint L1_TILENUM_H,
	    uint L1_TILENUM_R,
	    uint L1_TILENUM_S,
	    uint K_L1,
	    uint C_L1,
	    uint W_L1,
	    uint H_L1,
	    uint W_in_L1,
	    uint H_in_L1,
	    uint R_L1,
	    uint S_L1,
	    uint TILESIZE_W, // W Size of a tile
	    uint TILESIZE_H,
	    uint TILESIZE_R, //must be 1
	    uint TILESIZE_S, //must be 1
		/*hls::stream<MAC_AXIS_DATA> &bias_in,
		hls::stream<DP_AXIS_DATA> &weight_in,
		hls::stream<DP_AXIS_DATA> &data_in,
		hls::stream<MAC_AXIS_DATA> &conv_out,*/
		unsigned int bias_addr,
		unsigned int weight_addr,
		unsigned int data_addr,
		unsigned int output_addr,
		hls::stream<AXIS_DATA> &in_data,
		hls::stream<AXIS_DATA> &out_data,
		volatile unsigned int* dma_control,
		ap_uint<1> out_responsed
		) {
    #pragma HLS INTERFACE s_axilite port=K offset=0x00000024
    #pragma HLS INTERFACE s_axilite port=C offset=0x0000002C
    #pragma HLS INTERFACE s_axilite port=WH offset=0x00000034
    #pragma HLS INTERFACE s_axilite port=WH_in offset=0x0000003C
    #pragma HLS INTERFACE s_axilite port=RS offset=0x00000044
	#pragma HLS INTERFACE s_axilite port=L2_TILENUM_K offset=0x0000004C
	#pragma HLS INTERFACE s_axilite port=L2_TILENUM_C offset=0x00000054
    #pragma HLS INTERFACE s_axilite port=L2_TILENUM_W offset=0x0000005C
    #pragma HLS INTERFACE s_axilite port=L2_TILENUM_H offset=0x00000064
    #pragma HLS INTERFACE s_axilite port=L2_TILENUM_R offset=0x0000006C
    #pragma HLS INTERFACE s_axilite port=L2_TILENUM_S offset=0x00000074
    #pragma HLS INTERFACE s_axilite port=K_L2 offset=0x0000007C
    #pragma HLS INTERFACE s_axilite port=C_L2 offset=0x00000084
    #pragma HLS INTERFACE s_axilite port=W_L2 offset=0x0000008C
    #pragma HLS INTERFACE s_axilite port=H_L2 offset=0x00000094
    #pragma HLS INTERFACE s_axilite port=W_in_L2 offset=0x0000009C
    #pragma HLS INTERFACE s_axilite port=H_in_L2 offset=0x00000104
    #pragma HLS INTERFACE s_axilite port=R_L2 offset=0x0000010C
    #pragma HLS INTERFACE s_axilite port=S_L2 offset=0x00000114
	#pragma HLS INTERFACE s_axilite port=L1_TILENUM_K offset=0x0000011C
	#pragma HLS INTERFACE s_axilite port=L1_TILENUM_C offset=0x00000124
    #pragma HLS INTERFACE s_axilite port=L1_TILENUM_W offset=0x0000012C
    #pragma HLS INTERFACE s_axilite port=L1_TILENUM_H offset=0x00000134
    #pragma HLS INTERFACE s_axilite port=L1_TILENUM_R offset=0x0000013C
    #pragma HLS INTERFACE s_axilite port=L1_TILENUM_S offset=0x00000144
    #pragma HLS INTERFACE s_axilite port=K_L1 offset=0x0000014C
    #pragma HLS INTERFACE s_axilite port=C_L1 offset=0x00000154
    #pragma HLS INTERFACE s_axilite port=W_L1 offset=0x0000015C
    #pragma HLS INTERFACE s_axilite port=H_L1 offset=0x00000164
    #pragma HLS INTERFACE s_axilite port=W_in_L1 offset=0x0000016C
    #pragma HLS INTERFACE s_axilite port=H_in_L1 offset=0x00000174
    #pragma HLS INTERFACE s_axilite port=R_L1 offset=0x0000017C
    #pragma HLS INTERFACE s_axilite port=S_L1 offset=0x00000184
    #pragma HLS INTERFACE s_axilite port=TILESIZE_W offset=0x0000018C
    #pragma HLS INTERFACE s_axilite port=TILESIZE_H offset=0x00000194
    #pragma HLS INTERFACE s_axilite port=TILESIZE_R offset=0x0000019C
    #pragma HLS INTERFACE s_axilite port=TILESIZE_S offset=0x00000204

	#pragma HLS INTERFACE s_axilite port=bias_addr offset=0x0000020C
	#pragma HLS INTERFACE s_axilite port=weight_addr offset=0x00000214
	#pragma HLS INTERFACE s_axilite port=data_addr offset=0x0000021C
	#pragma HLS INTERFACE s_axilite port=output_addr offset=0x00000224
	#pragma HLS INTERFACE axis port=in_data
	#pragma HLS INTERFACE axis port=out_data
	#pragma HLS INTERFACE m_axi port=dma_control offset=off
	#pragma HLS INTERFACE ap_none port=out_responsed
	#pragma HLS INTERFACE s_axilite port=return register offset=0x00000000
	#pragma HLS expression_balance

#pragma HLS ALLOCATION instances=mul limit=16 operation

	DO_PRAGMA(HLS ARRAY_PARTITION variable=bias_l2 dim=1 complete)
	DO_PRAGMA(HLS ARRAY_PARTITION variable=weight_l2 dim=1 complete)
	DO_PRAGMA(HLS ARRAY_PARTITION variable=data_l2 dim=2 complete)
	DO_PRAGMA(HLS ARRAY_PARTITION variable=output_l2 dim=2 complete)
	DO_PRAGMA(HLS ARRAY_PARTITION variable=output_l2_reduction dim=2 complete)

	const uint input_rows = TILESIZE_H * TILESIZE_W + (ARRAY_K - 1) + (ARRAY_C - 1); // inner loop with sysarr bubble
	const uint bubble = (ARRAY_K - 1) + (ARRAY_C - 1);
	const uint bubble_h = 0; //bubble / TILESIZE_W; //not be used
	const uint bubble_w = 0; //bubble % TILESIZE_W; //not be used


	//reset
	volatile uint signal = 0x04; //reset
	write_s2mm(dma_control, signal);
	write_mm2s(dma_control, signal);
	volatile uint signal2 = 0x00; //halt
	write_s2mm(dma_control, signal2);
	write_mm2s(dma_control, signal2);
	volatile uint signal3 = 0x7001;
	dma_control[s2mm_ctrl_reg>>2] = signal3; //s2mm channel running
	dma_control[mm2s_ctrl_reg>>2] = signal3; //mm2s channel running



	BIAS_DRAM_READ: for (unsigned int ko = 0; ko < K/VEC_SIZE; ko++) {
		#pragma HLS loop_tripcount min=1 max=1
		#pragma HLS pipeline off
		short addr;
		#pragma HLS BIND_OP variable=addr op=mul impl=fabric
		addr = ko*VEC_SIZE;
		dma_control[mm2s_source_addr_reg>>2] = bias_addr + addr;
		dma_control[mm2s_length_reg>>2] = VEC_SIZE;
		for (unsigned int ki = 0; ki < VEC_SIZE; ki++) { // TODO: split VECSIZE -> (VECSIZE/ARRAY_K) / ARRAY_K
			//#pragma HLS unroll
			AXIS_DATA temp;
			in_data.read(temp);
			bias_l2[ki][ko] = temp.data;
		}
	}
	BIAS_DRAM_WRITE_K: for (unsigned int ko = 0; ko < K/VEC_SIZE; ko++) {
		#pragma HLS loop_tripcount min=1 max=1
		#pragma HLS pipeline off
		BIAS_DRAM_WRITE_H: for (int wh = 0; wh < WH*WH; wh++) {
			#pragma HLS loop_tripcount min=49 max=49
			#pragma HLS pipeline off

			short addr;
			#pragma HLS BIND_OP variable=addr op=mul impl=fabric
			addr = ((ko*(WH*WH)+wh)*VEC_SIZE)*4;
			dma_control[s2mm_dest_addr_reg>>2] = output_addr + addr;
			dma_control[s2mm_length_reg>>2] = VEC_SIZE*4;
			for (unsigned int ki = 0; ki < VEC_SIZE; ki++) { // TODO: split VECSIZE -> (VECSIZE/ARRAY_K) / ARRAY_K
				unsigned int global_k = (ko)*VEC_SIZE + ki;
				MACTYPE write_data = bias_l2[ki][ko];
				AXIS_DATA temp;
				temp.keep = 0x1;//0xf;
				temp.strb = 0x1;//0xf;
				temp.last = 0; temp.data = (write_data & 0x000000FF);
				out_data.write(temp);
				temp.last = 0; temp.data = (write_data & 0x0000FF00)>>8;
				out_data.write(temp);
				temp.last = 0; temp.data = (write_data & 0x00FF0000)>>16;
				out_data.write(temp);
				temp.last = (ki%VEC_SIZE==VEC_SIZE-1); temp.data = (write_data & 0xFF000000)>>24;
				out_data.write(temp);
			}
			ap_uint<1> resp = out_responsed;
			while(!resp) {
				resp = out_responsed;
			}
			write_s2mm(dma_control, 0x0001);
			write_s2mm(dma_control, 0x7001);
		}
	}

	LOOP_K_MOST_OUTER: for (int kmo = 0; kmo < L2_TILENUM_K; kmo++) { // Inner channel
	#pragma HLS loop_tripcount min=4 max=4
	LOOP_C_MOST_OUTER: for (int cmo = 0; cmo < L2_TILENUM_C; cmo++) { // Inner channel
	#pragma HLS loop_tripcount min=1 max=1
	LOOP_H_MOST_OUTER: for (int hmo = 0; hmo < L2_TILENUM_H; hmo++) {
	#pragma HLS loop_tripcount min=1 max=1
	LOOP_W_MOST_OUTER: for (int wmo = 0; wmo < L2_TILENUM_W; wmo++) {
	#pragma HLS loop_tripcount min=1 max=1
	LOOP_R_MOST_OUTER: for (int rmo = 0; rmo < L2_TILENUM_R; rmo++) {
	#pragma HLS loop_tripcount min=1 max=1
	LOOP_S_MOST_OUTER: for (int smo = 0; smo < L2_TILENUM_S; smo++) {
	#pragma HLS loop_tripcount min=1 max=1
		//#pragma HLS dataflow

		// Read Input from DRAM
		input_dram_read(data_l2, //data_in,
				bias_addr,
				weight_addr,
				data_addr,
				output_addr,
				in_data,
				out_data,
				dma_control,
						cmo, hmo, wmo,
						C_L2, H_L2, W_L2, H_in_L2, W_in_L2, WH_in);
		weight_dram_read(weight_l2,// weight_in,
				bias_addr,
				weight_addr,
				data_addr,
				output_addr,
				in_data,
				out_data,
				dma_control,
						kmo, cmo, rmo, smo,
						K_L2, C_L2, R_L2, S_L2,
						L2_TILENUM_K, L2_TILENUM_C, L2_TILENUM_R, L2_TILENUM_S);

		LOOP_K_OUTER: for (int ko = 0; ko < L1_TILENUM_K; ko++) {
		#pragma HLS loop_tripcount min=1 max=1
		LOOP_C_OUTER: for (int co = 0; co < L1_TILENUM_C; co++) {
		#pragma HLS loop_tripcount min=1 max=1
		LOOP_H_OUTER: for (int ho = 0; ho < L1_TILENUM_H; ho++) { // TODO: Tiling
		#pragma HLS loop_tripcount min=1 max=1
		LOOP_W_OUTER: for (int wo = 0; wo < L1_TILENUM_W; wo++) { // TODO: Tiling
		#pragma HLS loop_tripcount min=1 max=1
		LOOP_R_OUTER: for (int ro = 0; ro < L1_TILENUM_R; ro++) { // TODO: Tiling
		#pragma HLS loop_tripcount min=3 max=3
		LOOP_S_OUTER: for (int so = 0; so < L1_TILENUM_S; so++) { // TODO: Tiling
		#pragma HLS loop_tripcount min=3 max=3
			// L2->L1
			#pragma HLS stable variable=output_l2
			#pragma HLS stable variable=output_l2_reduction
			#pragma HLS stable variable=data_l2
			#pragma HLS stable variable=weight_l2
			//#pragma HLS dataflow

			bool isFirst;
			if(co==0 && ro==0 && so==0) isFirst = true; // first iteration of a output
			else isFirst = false;

			DPTYPE weight_regfile[ARRAY_K][ARRAY_C];
			DPTYPE data_l1[DATA_L1_SIZE][ARRAY_C];
			MACTYPE output_l1[OUTPUT_L1_SIZE][ARRAY_K];
			static MACTYPE output_l1_local[OUTPUT_L1_SIZE][ARRAY_K];
			#pragma HLS ARRAY_PARTITION variable=weight_regfile dim=0 complete //register
			#pragma HLS ARRAY_PARTITION variable=data_l1 dim=2 complete
			#pragma HLS ARRAY_PARTITION variable=output_l1 dim=2 complete
			#pragma HLS ARRAY_PARTITION variable=output_l1_local dim=2 complete

			//Systolic Array
			runWeight2Reg(weight_regfile, weight_l2, C_L2, R_L2, S_L2, ko, co, ro, so);
			runDataL2toL1(data_l1, data_l2, TILESIZE_H, TILESIZE_W, co, ho, wo, ro, so, W_in_L2, H_in_L2);
			#define SIMD
			#ifndef SIMD
			runSysArr(weight_regfile, data_l1, output_l1_local, output_l1,
						input_rows,
						bubble_h, bubble_w,
						TILESIZE_H, TILESIZE_W, TILESIZE_R, TILESIZE_S, isFirst);
			#else
			runSIMD(weight_regfile, data_l1, output_l1_local, output_l1,
						input_rows,
						bubble_h, bubble_w,
						TILESIZE_H, TILESIZE_W, TILESIZE_R, TILESIZE_S, isFirst);
			#endif
			runOutputL1toL2(output_l1, output_l2, output_l2_reduction, TILESIZE_H, TILESIZE_W, ko, ho, wo, W_L2, H_L2, isFirst);
		} // Loop S
		} // Loop R
		}
		}
		}
		}

		output_dram_write(output_l2, //conv_out,
				bias_addr,
				weight_addr,
				data_addr,
				output_addr,
				in_data,
				out_data,
				dma_control, out_responsed,
						kmo, hmo, wmo,
						K_L2, H_L2, W_L2, WH);
	}
	}
	}
	}
	}
	}
}
#ifndef XILINX
}
#endif
