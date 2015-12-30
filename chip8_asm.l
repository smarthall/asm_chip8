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
"rcall"     { return RCALL_MNEMONIC; }
"call"      { return CALL_MNEMONIC; }
"cls"       { return CLS_MNEMONIC; }
"rtn"       { return RTN_MNEMONIC; }
"jmp"       { return JMP_MNEMONIC; }
"se"        { return SE_MNEMONIC; }
"sne"       { return SNE_MNEMONIC; }
"add"       { return ADD_MNEMONIC; }
"or"        { return OR_MNEMONIC; }
"and"       { return AND_MNEMONIC; }
"xor"       { return XOR_MNEMONIC; }
"shl"       { return SHL_MNEMONIC; }
"shr"       { return SHR_MNEMONIC; }

{hex}[Xx]      { yylval.char_token = yytext; return REGISTER; }
{digit}+    { yylval.int_token = atoi(yytext); return NUMBER; }
{alnum}\:   { yylval.char_token = yytext; return LABEL; }
0x{hex}+    { yylval.char_token = yytext; return ADDRESS; }

{white}+    ; // Ignore whitespace

%%

void yyerror(char * str) { printf("ERROR: Could not parse!\n"); }
int yywrap(void) { }
int main(void) {
    yyparse();
}

