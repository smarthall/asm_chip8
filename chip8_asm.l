%{

#include <stdio.h>
#include "chip8_asm.tab.h"
void yyerror(char*);
int yyparse(void);

%}

digit   [0-9]
hex     [0-9a-fA-F]
alnum   [a-zA-Z0-9]
white   [ \t\n]

%%

";"         { return SEMICOLON; }
","         { return COMMA; }
"mov"       { return MOV_MNEMONIC; }
{hex}       { yylval.char_token = yytext; return HEX_CHAR; }
{digit}+    { yylval.int_token = atoi(yytext); return NUMBER; }
{alnum}\:   { yylval.char_token = yytext; return LABEL; }
{white}+    ; // Ignore whitespace

%%

void yyerror(char * str) { printf("ERROR: Could not parse!\n"); }
int yywrap(void) { }
int main(void) {
    yyparse();
}

