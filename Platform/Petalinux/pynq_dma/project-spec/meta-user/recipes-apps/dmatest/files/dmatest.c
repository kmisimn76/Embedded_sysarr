
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/mman.h>

// about DMA data
#define source_address 0x01200000 //Vivado address: 0x0000_0000 ~ 0x1FFF_FFFF
#define destination_address 0x00700000 //Vivado address: 0x0000_0000 ~ 0x1FFF_FFFF
#define repeat 6
#define transfer_length 4
#define interval_length 2

// AXI IP address
#define ip_control_reg 0x00
#define ip_n_reg 0x24
#define ip_transfn_reg 0x2C
#define ip_intervn_reg 0x34
#define ip_srcaddr_reg 0x3C
#define ip_dstaddr_reg 0x44
#define axi_ip_address 0x40000000 //Vivado address: 0x4000_0000 ~ 0x4000_FFFF

void start_ip(volatile unsigned int* ip_reg_addr);
int check_ip_done(volatile unsigned int* ip_reg_addr);
int check_ip_ready(volatile unsigned int* ip_reg_addr);
int check_ip_idle(volatile unsigned int* ip_reg_addr);
void ip_write(volatile unsigned int* axi_reg_addr, unsigned int addr, unsigned int value);
void n_write(volatile unsigned int* axi_reg_addr, unsigned int value);
void transfn_write(volatile unsigned int* axi_reg_addr, unsigned int value);
void intervn_write(volatile unsigned int* axi_reg_addr, unsigned int value);
void srcaddr_write(volatile unsigned int* axi_reg_addr, unsigned int value);
void dstaddr_write(volatile unsigned int* axi_reg_addr, unsigned int value);

void read_data(volatile unsigned int* adress, int byte_length);
void load_data(volatile unsigned int* adress, int byte_length);
int main() {
    int dh = open("/dev/mem", O_RDWR | O_SYNC); 
    if(dh < 0) {
        printf("Error open mem\n");
        close(dh);
        return -1;
    }
    volatile unsigned int* ip_reg_addr = mmap(NULL, 65535, PROT_READ | PROT_WRITE, MAP_SHARED, dh, axi_ip_address); // AXI Lite address
    printf("ip reg addr ready\n");
    fflush(stdout);
    volatile unsigned int* dma_source_addr  = mmap(NULL, 65535, PROT_READ | PROT_WRITE, MAP_SHARED, dh, source_address); // MM2S SOURCE address
    printf("dma source ready\n");
    fflush(stdout);
    volatile unsigned int* dma_distination_addr = mmap(NULL, 65535, PROT_READ | PROT_WRITE, MAP_SHARED, dh, destination_address); // S2MM DESTINATION address
    printf("dma dest ready\n");
    fflush(stdout);

	printf("running AXI DMA...\r\n");
	printf("Source address : 0x%x  \t\t",(int)(source_address));
	printf("Destination address: 0x%x\r\n",(int)(destination_address));
    fflush(stdout);

    //CPU Data write to DRAM
	load_data(dma_source_addr,(transfer_length*2+interval_length)*repeat);

    n_write(ip_reg_addr, repeat);
    transfn_write(ip_reg_addr, transfer_length);
    intervn_write(ip_reg_addr, interval_length);
    srcaddr_write(ip_reg_addr, source_address);
    dstaddr_write(ip_reg_addr, destination_address);
    start_ip(ip_reg_addr);

    wait_ip_idle(ip_reg_addr);

    printf("IP process end\n");
    fflush(stdout);

    printf("data at destination address 0x%x: \n",dma_distination_addr); 
    //CPU Data read from DRAM
	read_data(dma_distination_addr, (transfer_length+interval_length)*repeat);
	
	printf("\r\n\r\n");
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
void n_write(volatile unsigned int* axi_reg_addr, unsigned int value) 
{
    ip_write(axi_reg_addr, ip_n_reg, value);
}
void transfn_write(volatile unsigned int* axi_reg_addr, unsigned int value)
{
    ip_write(axi_reg_addr, ip_transfn_reg, value);
}
void intervn_write(volatile unsigned int* axi_reg_addr, unsigned int value)
{
    ip_write(axi_reg_addr, ip_intervn_reg, value);
}
void srcaddr_write(volatile unsigned int* axi_reg_addr, unsigned int value)
{
    ip_write(axi_reg_addr, ip_srcaddr_reg, value);
}
void dstaddr_write(volatile unsigned int* axi_reg_addr, unsigned int value)
{
    ip_write(axi_reg_addr, ip_dstaddr_reg, value);
}

void read_data(volatile unsigned int* adress, int byte_length) 
{
    int *addr = adress;
    int reg_offset;
    for (reg_offset = 0; reg_offset < byte_length; reg_offset++) {
        printf("%x\t", addr[reg_offset]);
    }
    printf("\n");
}
void load_data(volatile unsigned int* adress, int byte_length) 
{
    int *addr = adress;
    int reg_offset;
    for (reg_offset = 0; reg_offset < byte_length; reg_offset++) {
		addr[reg_offset]=0x12345678+reg_offset;
        printf("%x\t", addr[reg_offset]); 
    }
    printf("\n");

    fflush(stdout);
    /*int a;
    printf("ready to input: ");
    scanf("%d", &a);
    printf("input is %d\n",a);*/

}
