#include <stdio.h>
#include <stdlib.h>

void init();
void run();
void step();
void monitor();
void showram();
#define RAM_MAX 32

#define HLT 	0x0
#define SKZ	0x20
#define ADD	0x40
#define AND	0x60
#define XOR	0x80
#define LDA	0xa0
#define STO	0xc0
#define JMP	0xe0


unsigned char pc_reg;
unsigned char acc_reg;
char zero_bit;
unsigned char data_reg;
unsigned char instr_reg;
unsigned char ram[RAM_MAX];
int n;
FILE *fp;

void main(int argc,char *argv[]){
	if((fp = fopen("binary","r")) == NULL)
		printf("error: can't open file binary");
	if((n = fread(ram,1,32,fp)) != 32)
		printf("error: can't read 32 Bytes");
	fclose(fp);
	showram();
	init();
	run();	
}

void init(){
	pc_reg = 0;
	acc_reg = 0;
	zero_bit = 0;
	data_reg = 0x0;
	instr_reg = 0;
}

void run(){
	while(1) {step();monitor();}
}
void step(){
	unsigned char opcode;
	unsigned char operand;
	instr_reg = ram[pc_reg++];
	opcode = instr_reg & 0xe0;
	operand = instr_reg & 0x1f;
	switch(opcode){
	case HLT : 	printf("program stop at 0x%x\n",pc_reg-1);exit(0);
	case SKZ :	 if(zero_bit == 1)	++pc_reg;	break;
	case ADD : 	data_reg = ram[operand];
			acc_reg += data_reg;			break;
	case AND : 	acc_reg &= ram[operand];		break;
	case XOR : 	acc_reg ^= ram[operand];		break;
	case LDA : 	acc_reg = ram[operand];			break;
	case STO : 	ram[operand] = acc_reg;			break;
	case JMP : 	pc_reg = operand;			break;
	}
	if(acc_reg == 0)
		zero_bit = 1;
	else 
		zero_bit =0;	
}

void monitor(){
	printf("pc_reg = %x\t\tacc_reg = %x\t\t\nzero_bit = %d\t\tdata = %x\t\t\ninstr = %x\t\t\n\n",\
		pc_reg,acc_reg,zero_bit,data_reg,instr_reg);	
}

void showram(){
	int i,j ;
	for(i = 0;i < 32;++i)	printf("0x%x\n",ram[i]);
}
