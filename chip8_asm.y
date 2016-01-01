%{

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#include "generator.h"

extern int yylex();
extern void yyerror(char*);

%}

/* Types we use */
%union {
    int         int_token;
    char        *char_token;
    uint16_t    opcode_token;
}

/* Seperators */
%token SEMICOLON COMMA

/* Mnemonics */
%token MOV_MNEMONIC CALL_MNEMONIC CLS_MNEMONIC RTN_MNEMONIC JMP_MNEMONIC
%token RCALL_MNEMONIC SE_MNEMONIC SNE_MNEMONIC ADD_MNEMONIC OR_MNEMONIC
%token AND_MNEMONIC XOR_MNEMONIC SHL_MNEMONIC SHR_MNEMONIC SUB_MNEMONIC
%token RSB_MNEMONIC LDI_MNEMONIC JMI_MNEMONIC RAND_MNEMONIC DRAW_MNEMONIC
%token SKK_MNEMONIC SNK_MNEMONIC SDELAY_MNEMONIC SSOUND_MNEMONIC
%token ADI_MNEMONIC FONT_MNEMONIC BCD_MNEMONIC STR_MNEMONIC LDR_MNEMONIC
%token KEY_MNEMONIC

/* things coming from the lexer */
%token <int_token> NUMBER ADDRESS REGISTER
%token <char_token> LABEL

/* Types for our instruction grammars */
%type <opcode_token> mov call cls rtn jmp rcall se sne add and or xor shl shr
%type <opcode_token> sub rsb ldi jmi rand draw skk snk sdelay ssound adi font
%type <opcode_token> bcd str ldr key
%type <opcode_token> instruction

%start program

%%

program: statement_list;

statement_list: statement statement_list
              | statement;

statement: instruction SEMICOLON
         { fwrite(&$1, sizeof($1), 1, stdout); }
         | LABEL instruction SEMICOLON
         { fwrite(&$2, sizeof($2), 1, stdout); };

instruction: mov
           | call
           | cls
           | rtn
           | jmp
           | rcall
           | se
           | sne
           | add
           | and
           | or
           | xor
           | shl
           | shr
           | sub
           | rsb
           | ldi
           | jmi
           | rand
           | draw
           | skk
           | snk
           | sdelay
           | ssound
           | adi
           | font
           | bcd
           | str
           | ldr
           | key;

mov: MOV_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_mov_register_register($2, $4); }

   | MOV_MNEMONIC NUMBER COMMA REGISTER
   { $$ = generate_mov_number_register($2, $4); };

rcall: RCALL_MNEMONIC ADDRESS
   { $$ = generate_rcall($2); };

call: CALL_MNEMONIC ADDRESS
   { $$ = generate_call($2); };

cls: CLS_MNEMONIC
   { $$ = generate_cls(); };

rtn: RTN_MNEMONIC
   { $$ = generate_rtn(); };

jmp: JMP_MNEMONIC ADDRESS
   { $$ = generate_jmp($2); };

se: SE_MNEMONIC REGISTER COMMA REGISTER
  { $$ = generate_se_register_register($2, $4); }
  | SE_MNEMONIC REGISTER COMMA NUMBER
  { $$ = generate_se_register_number($2, $4); };

sne: SNE_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_sne_register_register($2, $4); }
   | SNE_MNEMONIC REGISTER COMMA NUMBER
   { $$ = generate_sne_register_number($2, $4); };

add: ADD_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_add_register_register($2, $4); }
   | ADD_MNEMONIC NUMBER COMMA REGISTER
   { $$ = generate_add_register_number($2, $4); };

or: OR_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_or($2, $4); };

and: AND_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_and($2, $4); };

xor: XOR_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_xor($2, $4); };

shl: SHL_MNEMONIC REGISTER
   { $$ = generate_shl($2); };

shr: SHR_MNEMONIC REGISTER
   { $$ = generate_shr($2); };

sub: SUB_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_sub($2, $4); };

rsb: RSB_MNEMONIC REGISTER COMMA REGISTER
   { $$ = generate_rsb($2, $4); };

ldi: LDI_MNEMONIC ADDRESS
   { $$ = generate_ldi($2); };

jmi: JMI_MNEMONIC ADDRESS
   { $$ = generate_jmi($2); };

rand: RAND_MNEMONIC REGISTER COMMA NUMBER
    { $$ = generate_rand($2, $4); };

draw: DRAW_MNEMONIC REGISTER COMMA REGISTER COMMA NUMBER
    { $$ = generate_draw($2, $4, $6); };

skk: SKK_MNEMONIC REGISTER
   { $$ = generate_skk($2); };

snk: SNK_MNEMONIC REGISTER
   { $$ = generate_snk($2); };

sdelay: SDELAY_MNEMONIC REGISTER
      { $$ = generate_sdelay($2); };

ssound: SSOUND_MNEMONIC REGISTER
      { $$ = generate_ssound($2); };

adi: ADI_MNEMONIC REGISTER
   { $$ = generate_adi($2); };

font: FONT_MNEMONIC REGISTER
    { $$ = generate_font($2); };

bcd: BCD_MNEMONIC REGISTER
   { $$ = generate_bcd($2); };

str: STR_MNEMONIC REGISTER
   { $$ = generate_str($2); };

ldr: LDR_MNEMONIC REGISTER
   { $$ = generate_ldr($2); };

key: KEY_MNEMONIC REGISTER
   { $$ = generate_key($2); };
