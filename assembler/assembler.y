%{
#include <stdio.h>
#include <stdlib.h>
#define RAM_MAX 32
#define LABEL_MAX_LENGTH 8

unsigned char code[RAM_MAX];
char codeaddr = -1;
int lblnum, oprdnum;

#define OPERAND_MAX_NUM 20
#define LABEL_MAX_NUM 20

typedef struct {
	char *string ;
	char address;
}label;
typedef struct {
	char *string ;
	char address;
}operand;

label lbltab[LABEL_MAX_NUM];
operand oprdtab[OPERAND_MAX_NUM];

int yylex(void);
void yyerror(char *msg);
%}
%union{
	char *name;
	char integer;
	int expression;
}
%start program
%token HLT SKZ ADD AND XOR LDA STO JMP
%token <name> LABEL	
%token <integer> INTEGER

%type <expression> expr 
%%
program :
	function							
	;
function :
	function expr '\n'		
	|
	;
expr :
	HLT				{printf("do HLT\n");code[++codeaddr] = 0x00;$$ = 1;}
	|SKZ				{printf("do SKZ\n");code[++codeaddr] = 0x20;$$ = 1;}
	|ADD LABEL			{printf("do ADD\n");code[++codeaddr] = 0x40;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;$$ = 1;}
	|XOR LABEL			{printf("do XOR\n");code[++codeaddr] = 0x80;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;$$ = 1;}
	|LDA LABEL			{printf("do LDA\n");code[++codeaddr] = 0xa0;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;$$ = 1;}
	|STO LABEL			{printf("do STO\n");code[++codeaddr] = 0xc0;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;$$ = 1;} 
	|JMP LABEL			{printf("do JMP\n");code[++codeaddr] = 0xe0;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;$$ = 1;}
	|INTEGER			{printf("simple value\n");code[++codeaddr] = $1;$$ = 1;}
	|LABEL':'expr			{printf("record LABEL\n");lbltab[lblnum].string = $1;lbltab[lblnum].address = codeaddr;++lblnum;$$ = 1;}
	;
%%

void relocate(){
	int i,k;
	for(i = 0;i < oprdnum;++i)
		for(k =0;k < lblnum;++k){
			if(!strcmp(oprdtab[i].string,lbltab[k].string))
				code[oprdtab[i].address] |=(lbltab[k].address & 0x1f);
		}
}

void yyerror(char *msg){
	fprintf(stderr,"%s\n",msg);
}
int main(){
	FILE *fp;
	if((fp = fopen("binary","w")) == NULL) {printf("open file error");exit(1);}
	yyparse();
	relocate();
	int i = 0;
	for(;i <= codeaddr;++i){
	printf("%2x : %2x\n",i, code[i]);
	}
	fwrite(code,1,RAM_MAX,fp);
	fclose(fp);
	return 0;
}

