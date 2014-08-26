%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
"HLT"					{printf("HLT\n");return HLT;}
"SKZ"					{printf("SKZ\n");return SKZ;}
"ADD"					{printf("ADD\n");return ADD;}
"AND"					{printf("AND\n");return AND;}
"XOR"					{printf("XOR\n");return XOR;}
"LDA"					{printf("LDA\n");return LDA;}
"STO"					{printf("STO\n");return STO;}
"JMP"					{printf("JMP\n");return JMP;}
[A-Z][A-Z0-9_]*				{
						printf("LABLE:%s\n",yytext);
						int len = strlen(yytext) + 1;
						yylval.name = (__typeof__(yylval.name))malloc((len * sizeof(yylval.name)));
						memcpy(yylval.name,yytext,len);
						return LABEL;
					}
[0-9]+					{
						printf("%s\n",yytext);
						yylval.integer = (char)atoi(yytext);
						return INTEGER;
					}
:					{printf(":\n");return *yytext;}
[\n]					{printf("next line\n");return *yytext;}
[ \t]					;						
.					{yyerror("invalid character");}
%%
int yywrap(void){
	return 1;
}
