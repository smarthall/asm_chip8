%{

#include <stdio.h>
#include <stdlib.h>

#include "chip8_asm.tab.h"

void yyerror(char*);
int yyparse(void);

%}

/* Character types */
digit    [0-9]
hex      [0-9a-fA-F]
hexchar  [a-f]
uhexchar [A-F]
alnum    [a-zA-Z0-9]
white    [ \t\n]

%%

 /* Seperators */
";"         { return SEMICOLON; }
","         { return COMMA; }

 /* Mnemonics */
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
"sub"       { return SUB_MNEMONIC; }
"rsb"       { return RSB_MNEMONIC; }
"ldi"       { return LDI_MNEMONIC; }
"jmi"       { return JMI_MNEMONIC; }
"rand"      { return RAND_MNEMONIC; }
"draw"      { return DRAW_MNEMONIC; }
"skk"       { return SKK_MNEMONIC; }
"snk"       { return SNK_MNEMONIC; }
"sdelay"    { return SDELAY_MNEMONIC; }
"ssound"    { return SSOUND_MNEMONIC; }
"adi"       { return ADI_MNEMONIC; }
"font"      { return FONT_MNEMONIC; }
"bcd"       { return BCD_MNEMONIC; }
"str"       { return STR_MNEMONIC; }
"ldr"       { return LDR_MNEMONIC; }
"key"       { return KEY_MNEMONIC; }

 /* Base 10 numbers */
{digit}+    { yylval.int_token = strtol(yytext, NULL, 10); return NUMBER; }

 /* Hex numbers */
0x{hex}+    { yylval.int_token = strtol(yytext + 2, NULL, 16); return NUMBER; }

 /* Labels */
{alnum}+\:   { yylval.char_token = yytext; return LABEL; }

 /* Register names */
{digit}[Xx] { yylval.int_token = *yytext - '0'; return REGISTER; }
{hexchar}x  { yylval.int_token = *yytext - 'a' + 10; return REGISTER; }
{uhexchar}X { yylval.int_token = *yytext - 'A' + 10; return REGISTER; }

 /* Comments */
#[^\n]+     ;

 /* Whitespace */
{white}+    ; // Ignore whitespace

%%

int yywrap(void) { }
int main(void) {
    yyparse();
}

