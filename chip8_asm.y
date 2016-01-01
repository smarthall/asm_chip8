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

/* things coming from the lexer */
%token <int_token> NUMBER ADDRESS REGISTER
%token <char_token> LABEL

/* Types for our instruction grammars */
%type <opcode_token> mov call cls rtn jmp rcall se sne add and or xor shl shr
%type <opcode_token> sub rsb ldi jmi rand draw skk snk sdelay ssound adi font
%type <opcode_token> bcd str ldr
%type <opcode_token> instruction

%start program

%%

program: statement_list;

statement_list: statement statement_list
              | statement;

statement: instruction SEMICOLON
         { printf("Opcode: 0x%04x\n", $1); }
         | LABEL instruction SEMICOLON
         { printf("Opcode: 0x%04x\n", $2); };

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
           | ldr;

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
   { printf("Subtract instruction.\n"); };

rsb: RSB_MNEMONIC REGISTER COMMA REGISTER
   { printf("Right subtract instruction.\n"); };

ldi: LDI_MNEMONIC ADDRESS
   { printf("Load I instruction.\n"); };

jmi: JMI_MNEMONIC ADDRESS
   { printf("Indexed jump instruction.\n"); };

rand: RAND_MNEMONIC REGISTER COMMA NUMBER
    { printf("Random number instruction.\n"); };

draw: DRAW_MNEMONIC REGISTER COMMA REGISTER COMMA NUMBER
    { printf("Draw instruction.\n"); };

skk: SKK_MNEMONIC REGISTER
   { printf("Skip if key pressed instruction.\n"); };

snk: SNK_MNEMONIC REGISTER
   { printf("Skip if key not pressed instruction.\n"); };

sdelay: SDELAY_MNEMONIC REGISTER
      { printf("Set delay instruction.\n"); };

ssound: SSOUND_MNEMONIC REGISTER
      { printf("Play sound instruction.\n"); };

adi: ADI_MNEMONIC REGISTER
   { printf("Add to index instruction.\n"); };

font: FONT_MNEMONIC REGISTER
    { printf("Font lookup instruction.\n"); };

bcd: BCD_MNEMONIC REGISTER
   { printf("Binary coded decimal instruction.\n"); };

str: STR_MNEMONIC REGISTER
   { printf("Store registers instruction.\n"); };

ldr: LDR_MNEMONIC REGISTER
   { printf("Load registers instruction.\n"); };

