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
	HLT				{code[++codeaddr] = 0x00;}
	|SKZ				{code[++codeaddr] = 0x20;}
	|ADD LABEL			{code[++codeaddr] = 0x40;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;}
	|XOR LABEL			{code[++codeaddr] = 0x80;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;}
	|LDA LABEL			{code[++codeaddr] = 0xa0;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;}
	|STO LABEL			{code[++codeaddr] = 0xc0;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;} 
	|JMP LABEL			{code[++codeaddr] = 0xe0;oprdtab[oprdnum].string = $2;oprdtab[oprdnum].address = codeaddr;++oprdnum;}
	|INTEGER			{code[++codeaddr] = $1;}
	|LABEL':'expr			{lbltab[lblnum].string = $1;lbltab[lblnum].address = codeaddr;++lblnum;}
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

void freemem(){
	int i;
	for (i = 0;i < lblnum;++i)
		free(lbltab[i].string);
}
int main(){
	FILE *fp;
	if((fp = fopen("test.bin","w")) == NULL) {printf("open file error");exit(1);}
	yyparse();
	relocate();
	int i = 0;
	for(;i <= codeaddr;++i){
		printf("%2x : %2x\n",i, code[i]);
	}
	freemem();
	fwrite(code,1,RAM_MAX,fp);
	fclose(fp);
	return 0;
}

