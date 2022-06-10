
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/mman.h>

// about DMA data
#define bias_address 0x01200000 //Vivado address: 0x0000_0000 ~ 0x1FFF_FFFF
#define weight_address 0x01210000 //Vivado address: 0x0000_0000 ~ 0x1FFF_FFFF
#define data_address 0x01220000 //Vivado address: 0x0000_0000 ~ 0x1FFF_FFFF
#define output_address 0x00700000 //Vivado address: 0x0000_0000 ~ 0x1FFF_FFFF

// AXI IP address
#define ip_control_reg 0x00
#define ip_reg_base 0x24
#define axi_ip_address 0x40000000 //Vivado address: 0x4000_0000 ~ 0x4000_FFFF

//Convolution size
#define K 16
#define C 32
#define WH 16
#define WH_in 18
#define RS 3

#define ARRAY_C 4
#define ARRAY_K 4
#define TS_W (8)
#define TS_H (8)
#define TS_R (1)
#define TS_S (1)
#define K_L1  (ARRAY_K)
#define C_L1  (ARRAY_C)
#define W_L1  (TS_W)
#define H_L1  (TS_H)
#define W_in_L1  (TS_W+TS_S-1)
#define H_in_L1  (TS_H+TS_R-1)
#define R_L1  (TS_R)
#define S_L1  (TS_S)
#define L1_NUM_K (2)
#define L1_NUM_C (2)
#define L1_NUM_W (1)
#define L1_NUM_H (1)
#define L1_NUM_R (3)
#define L1_NUM_S (3)
#define K_L2  (K_L1*L1_NUM_K) //#4*2=8
#define C_L2  (C_L1*L1_NUM_C) //#''
#define W_L2  (W_L1*L1_NUM_W) //#8x1=8
#define H_L2  (H_L1*L1_NUM_H) //#''
#define W_in_L2  (W_L2+(TS_S*L1_NUM_S)-1)
#define H_in_L2  (H_L2+(TS_R*L1_NUM_R)-1)
#define R_L2  (R_L1*L1_NUM_R) //#3
#define S_L2  (S_L1*L1_NUM_S) //#3
#define L2_NUM_K  (2)
#define L2_NUM_C  (4)
#define L2_NUM_W  (2)
#define L2_NUM_H  (2)
#define L2_NUM_R  (1)
#define L2_NUM_S  (1)

void conv_gold(
            uint K_,
            uint C_,
            uint WH_,
            uint WH_in_,
            uint RS_,
                char *bias,
                char *weight,
                char *data,
                int *gold)
{
        for(int k=0;k<K_;k++){
                for(int h=0;h<WH_;h++){
                        for(int w=0;w<WH_;w++){
				int output_ptr = k*WH_*WH_ + h*WH_ + w;
                                gold[output_ptr] = bias[k];
                                for(int c=0;c<C_;c++){
                                        for(int r=0;r<RS_;r++){
                                                for(int s=0;s<RS_;s++){
							int data_ptr = c*WH_in_*WH_in_ + (h+r)*WH_in_ + (w+s);
                                                        int weight_ptr = k*C_*RS_*RS_ + c*RS_*RS_ + r*RS_ + s;
                                                        gold[output_ptr] += data[data_ptr] * weight[weight_ptr];
                                                }
                                        }
                                }
                        }
                }
        }
}

void start_ip(volatile unsigned int* ip_reg_addr);
int check_ip_done(volatile unsigned int* ip_reg_addr);
int check_ip_ready(volatile unsigned int* ip_reg_addr);
int check_ip_idle(volatile unsigned int* ip_reg_addr);
int wait_ip_idle(volatile unsigned int* ip_reg_addr) ;
void ip_write(volatile unsigned int* axi_reg_addr, unsigned int addr, unsigned int value);

void read_data(volatile unsigned char* device_, void* host_, int byte_length);
void write_data(volatile unsigned char* device_, void* source_, int byte_length);



int main() {
    int dh = open("/dev/mem", O_RDWR | O_SYNC); 
    if(dh < 0) {
        printf("Error open mem\n");
        close(dh);
        return -1;
    }
    volatile unsigned int* ip_reg_addr = mmap(NULL, 0xffff, PROT_READ | PROT_WRITE, MAP_SHARED, dh, axi_ip_address); // AXI Lite address
    volatile unsigned char* bias_addr  = mmap(NULL, 0xffff, PROT_READ | PROT_WRITE, MAP_SHARED, dh, bias_address);
    volatile unsigned char* weight_addr = mmap(NULL, 0xffff, PROT_READ | PROT_WRITE, MAP_SHARED, dh, weight_address);
    volatile unsigned char* data_addr = mmap(NULL, 0xffff, PROT_READ | PROT_WRITE, MAP_SHARED, dh, data_address);
    volatile unsigned char* output_addr = mmap(NULL, 0xffff, PROT_READ | PROT_WRITE, MAP_SHARED, dh, output_address);

    printf("running AXI DMA...\r\n");
    printf("weight address : 0x%x  \t\t",(int)(weight_address));
    printf("data address : 0x%x  \t\t",(int)(data_address));
    printf("output address: 0x%x\r\n",(int)(output_address));
    fflush(stdout);

    //CPU Data write to DRAM
    int len_bias = K;
    int len_input = C*WH_in*WH_in;
    int len_weight = K*C*RS*RS;
    int len_output = K*WH*WH;
    char *bias = (char*)malloc(sizeof(char)*len_bias);
    char *input = (char*)malloc(sizeof(char)*len_input);
    char *weight = (char*)malloc(sizeof(char)*len_weight);
    int *output = (int*)malloc(sizeof(int)*len_output);
    int *gold = (int*)malloc(sizeof(int)*len_output);

    printf("input malloc\n");

    printf("bias\n");
    for(int i=0;i<len_bias;i++) {
        bias[i] = rand()%256-128;
	printf("%x ", bias[i]);
	if(i%8==7) printf("\n");
    }
    printf("weight\n");
    for(int i=0;i<len_weight;i++) {
        weight[i] = rand()%256-128;
	printf("%x ", weight[i]);
	if(i%8==7) printf("\n");
    }
    printf("input\n");
    for(int i=0;i<len_input;i++) {
        input[i] = rand()%256-128;
	printf("%x ", input[i]);
	if(i%8==7) printf("\n");
    }

    printf("input set\n");

    write_data(bias_addr, (void*)bias, len_bias);
    write_data(weight_addr, (void*)weight, len_weight);
    write_data(data_addr, (void*)input, len_input);

    printf("input transfer to dram\n");

    ip_write(ip_reg_addr, 0x0024, K);
    ip_write(ip_reg_addr, 0x002C, C);
    ip_write(ip_reg_addr, 0x0034, WH);
    ip_write(ip_reg_addr, 0x003C, WH_in);
    ip_write(ip_reg_addr, 0x0044, RS);
    ip_write(ip_reg_addr, 0x004C, L2_NUM_K);
    ip_write(ip_reg_addr, 0x0054, L2_NUM_C);
    ip_write(ip_reg_addr, 0x005C, L2_NUM_W);
    ip_write(ip_reg_addr, 0x0064, L2_NUM_H);
    ip_write(ip_reg_addr, 0x006C, L2_NUM_R);
    ip_write(ip_reg_addr, 0x0074, L2_NUM_S);
    ip_write(ip_reg_addr, 0x007C, K_L2);
    ip_write(ip_reg_addr, 0x0084, C_L2);
    ip_write(ip_reg_addr, 0x008C, W_L2);
    ip_write(ip_reg_addr, 0x0094, H_L2);
    ip_write(ip_reg_addr, 0x009C, W_in_L2);
    ip_write(ip_reg_addr, 0x0104, H_in_L2);
    ip_write(ip_reg_addr, 0x010C, R_L2);
    ip_write(ip_reg_addr, 0x0114, S_L2);
    ip_write(ip_reg_addr, 0x011C, L1_NUM_K);
    ip_write(ip_reg_addr, 0x0124, L1_NUM_C);
    ip_write(ip_reg_addr, 0x012C, L1_NUM_W);
    ip_write(ip_reg_addr, 0x0134, L1_NUM_H);
    ip_write(ip_reg_addr, 0x013C, L1_NUM_R);
    ip_write(ip_reg_addr, 0x0144, L1_NUM_S);
    ip_write(ip_reg_addr, 0x014C, K_L1);
    ip_write(ip_reg_addr, 0x0154, C_L1);
    ip_write(ip_reg_addr, 0x015C, W_L1);
    ip_write(ip_reg_addr, 0x0164, H_L1);
    ip_write(ip_reg_addr, 0x016C, W_in_L1);
    ip_write(ip_reg_addr, 0x0174, H_in_L1);
    ip_write(ip_reg_addr, 0x017C, R_L1);
    ip_write(ip_reg_addr, 0x0184, S_L1);
    ip_write(ip_reg_addr, 0x018C, TS_W);
    ip_write(ip_reg_addr, 0x0194, TS_H);
    ip_write(ip_reg_addr, 0x019C, TS_R);
    ip_write(ip_reg_addr, 0x0204, TS_S);
    ip_write(ip_reg_addr, 0x020C, bias_address);
    ip_write(ip_reg_addr, 0x0214, weight_address);
    ip_write(ip_reg_addr, 0x021C, data_address);
    ip_write(ip_reg_addr, 0x0224, output_address);

    printf("set argument\n");

    start_ip(ip_reg_addr);

    printf("started & wait IP\n");

    wait_ip_idle(ip_reg_addr);

    printf("IP process end\n");
    fflush(stdout);

    printf("data at destination address 0x%x: \n",output_addr); 
    //CPU Data read from DRAM
    read_data(output_addr, (void*)output, len_output*4);

    conv_gold(K, C, WH, WH_in, RS,
              bias, weight, input, gold);

    printf(" conv output is\n");
    for(int i=0;i<len_output;i++)
        printf("%d (gold %d)\n", output[i], gold[i]);
	printf("\r\n\r\n");

    free(bias);
    free(weight);
    free(input);
    free(output);
}

void start_ip(volatile unsigned int* ip_reg_addr) {
    unsigned int control_signal = ip_reg_addr[ip_control_reg>>2];
    control_signal |= 0x00000001; // setup start signal
    ip_reg_addr[ip_control_reg>>2] = control_signal;
}
int check_ip_done(volatile unsigned int* ip_reg_addr) {
    unsigned int control_signal = ip_reg_addr[ip_control_reg>>2];
    if((control_signal & 0x02))
        return 1; // ip is done
    else
        return 0;
}
int check_ip_idle(volatile unsigned int* ip_reg_addr) {
    unsigned int control_signal = ip_reg_addr[ip_control_reg>>2];
    if((control_signal & 0x04))
        return 1; // ip is idle
    else
        return 0;
}
int check_ip_ready(volatile unsigned int* ip_reg_addr) {
    unsigned int control_signal = ip_reg_addr[ip_control_reg>>2];
    if((control_signal & 0x08))
        return 1; // ip is ready
    else
        return 0;
}
int wait_ip_idle(volatile unsigned int* ip_reg_addr) 
{
    unsigned int status = check_ip_idle(ip_reg_addr);
    while(!(status) )
	{
        status = check_ip_idle(ip_reg_addr);
    }
    return 0;
}
void ip_write(volatile unsigned int* axi_reg_addr, unsigned int addr, unsigned int value) 
{
    axi_reg_addr[addr>>2] = value;
}

void read_data(volatile unsigned char* device_, void* host_, int byte_length)
{
    //unsigned char *addr = device_;
    unsigned char *dt = host_;
    int reg_offset;
    for (reg_offset = 0; reg_offset < byte_length; reg_offset++) {
        dt[reg_offset] = device_[reg_offset];
    }
    //printf("\n");
}
void write_data(volatile unsigned char* device_, void* source_, int byte_length)
{
    //unsigned char *device = device_;
    unsigned char *source = source_;
    int reg_offset;
    for (reg_offset = 0; reg_offset < byte_length; reg_offset++) {
		device_[reg_offset]=source[reg_offset];
    }
}
