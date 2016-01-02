%{

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <endian.h>

#include "generator.h"
#include "ast.h"

#define YYERROR_VERBOSE
void yyerror(const char *msg){printf("ERROR(PARSER): %s\n", msg);}

extern int yylex();

void write_opcode(uint16_t opcode) {
    opcode = htobe16(opcode);

    fwrite(&opcode, sizeof(opcode), 1, stdout);
}

%}

/* Types we use */
%union {
    int         int_token;
    char        *char_token;
    uint16_t    opcode_token;
    ast_argument *ast_argument;
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

/* Things coming from the lexer */
%token <int_token> NUMBER REGISTER
%token <char_token> LABEL

/* Types for our instruction grammars */
%type <opcode_token> mov call cls rtn jmp rcall se sne add and or xor shl shr
%type <opcode_token> sub rsb ldi jmi rand draw skk snk sdelay ssound adi font
%type <opcode_token> bcd str ldr key
%type <opcode_token> instruction

/* AST Types */
%type <ast_argument> register labelnum

%start program

%%

program: statement_list;

statement_list: statement statement_list
              | statement;

statement: instruction SEMICOLON
         { write_opcode($1); }
         | LABEL instruction SEMICOLON
         { write_opcode($2); };

labelnum: NUMBER
        { $$ = ast_create_number($1); }
        | LABEL
        { $$ = ast_create_label($1); };

register: REGISTER
        { $$ = ast_create_register($1); };

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

mov: MOV_MNEMONIC register COMMA register
   { $$ = generate_mov_register_register($2, $4); }

   | MOV_MNEMONIC labelnum COMMA register
   { $$ = generate_mov_labelnum_register($2, $4); };

rcall: RCALL_MNEMONIC labelnum
   { $$ = generate_rcall($2); };

call: CALL_MNEMONIC labelnum
   { $$ = generate_call($2); };

cls: CLS_MNEMONIC
   { $$ = generate_cls(); };

rtn: RTN_MNEMONIC
   { $$ = generate_rtn(); };

jmp: JMP_MNEMONIC labelnum
   { $$ = generate_jmp($2); };

se: SE_MNEMONIC register COMMA register
  { $$ = generate_se_register_register($2, $4); }
  | SE_MNEMONIC register COMMA labelnum
  { $$ = generate_se_register_labelnum($2, $4); };

sne: SNE_MNEMONIC register COMMA register
   { $$ = generate_sne_register_register($2, $4); }
   | SNE_MNEMONIC register COMMA labelnum
   { $$ = generate_sne_register_labelnum($2, $4); };

add: ADD_MNEMONIC register COMMA register
   { $$ = generate_add_register_register($2, $4); }
   | ADD_MNEMONIC labelnum COMMA register
   { $$ = generate_add_register_labelnum($2, $4); };

or: OR_MNEMONIC register COMMA register
   { $$ = generate_or($2, $4); };

and: AND_MNEMONIC register COMMA register
   { $$ = generate_and($2, $4); };

xor: XOR_MNEMONIC register COMMA register
   { $$ = generate_xor($2, $4); };

shl: SHL_MNEMONIC register
   { $$ = generate_shl($2); };

shr: SHR_MNEMONIC register
   { $$ = generate_shr($2); };

sub: SUB_MNEMONIC register COMMA register
   { $$ = generate_sub($2, $4); };

rsb: RSB_MNEMONIC register COMMA register
   { $$ = generate_rsb($2, $4); };

ldi: LDI_MNEMONIC labelnum
   { $$ = generate_ldi($2); };

jmi: JMI_MNEMONIC labelnum
   { $$ = generate_jmi($2); };

rand: RAND_MNEMONIC register COMMA labelnum
    { $$ = generate_rand($2, $4); };

draw: DRAW_MNEMONIC register COMMA register COMMA labelnum
    { $$ = generate_draw($2, $4, $6); };

skk: SKK_MNEMONIC register
   { $$ = generate_skk($2); };

snk: SNK_MNEMONIC register
   { $$ = generate_snk($2); };

sdelay: SDELAY_MNEMONIC register
      { $$ = generate_sdelay($2); };

ssound: SSOUND_MNEMONIC register
      { $$ = generate_ssound($2); };

adi: ADI_MNEMONIC register
   { $$ = generate_adi($2); };

font: FONT_MNEMONIC register
    { $$ = generate_font($2); };

bcd: BCD_MNEMONIC register
   { $$ = generate_bcd($2); };

str: STR_MNEMONIC register
   { $$ = generate_str($2); };

ldr: LDR_MNEMONIC register
   { $$ = generate_ldr($2); };

key: KEY_MNEMONIC register
   { $$ = generate_key($2); };
