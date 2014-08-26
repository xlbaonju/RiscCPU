%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
"HLT"					{return HLT;}
"SKZ"					{return SKZ;}
"ADD"					{return ADD;}
"AND"					{return AND;}
"XOR"					{return XOR;}
"LDA"					{return LDA;}
"STO"					{return STO;}
"JMP"					{return JMP;}
[A-Z][A-Z0-9_]*				{
						int len = strlen(yytext) + 1;
						yylval.name = (__typeof__(yylval.name))malloc((len * sizeof(yylval.name)));
						memcpy(yylval.name,yytext,len);
						return LABEL;
					}
[0-9]+					{
						yylval.integer = (char)atoi(yytext);
						return INTEGER;
					}
:					{return *yytext;}
[\n]					{return *yytext;}
[ \t]					;						
.					{yyerror("invalid character");}
%%
int yywrap(void){
	return 1;
}
