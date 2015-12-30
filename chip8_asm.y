%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern void yyerror(char*);

%}

%union {
	int		int_token;
    char    *char_token;
}

%token SEMICOLON COMMA
%token MOV_MNEMONIC CALL_MNEMONIC CLS_MNEMONIC RTN_MNEMONIC JMP_MNEMONIC
%token RCALL_MNEMONIC SE_MNEMONIC SNE_MNEMONIC ADD_MNEMONIC OR_MNEMONIC
%token AND_MNEMONIC XOR_MNEMONIC SHL_MNEMONIC SHR_MNEMONIC SUB_MNEMONIC
%token RSB_MNEMONIC LDI_MNEMONIC JMI_MNEMONIC RAND_MNEMONIC

%token <int_token> NUMBER
%token <char_token> REGISTER LABEL ADDRESS

%start program

%%

program: statement_list;

statement_list: statement statement_list
              | statement;

statement: instruction SEMICOLON
         | LABEL instruction SEMICOLON;

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
           | rand;

mov_source: REGISTER
          | NUMBER;

mov_target: REGISTER;

mov: MOV_MNEMONIC mov_source COMMA mov_target
   { printf("Move instruction.\n"); };

rcall: RCALL_MNEMONIC ADDRESS
   { printf("RCA1802 call instruction.\n"); };

call: CALL_MNEMONIC ADDRESS
   { printf("Call instruction.\n"); };

cls: CLS_MNEMONIC
   { printf("Clear screen instruction.\n"); };

rtn: RTN_MNEMONIC
   { printf("Return instruction.\n"); };

jmp: JMP_MNEMONIC ADDRESS
   { printf("Jump instruction.\n"); };

se_target: REGISTER
         | NUMBER;

se: SE_MNEMONIC REGISTER COMMA se_target
  { printf("Skip if equal instruction.\n"); };

sne: SNE_MNEMONIC REGISTER COMMA se_target
   { printf("Skip if not equal instruction.\n"); };

add_target: NUMBER
          | REGISTER;

add: ADD_MNEMONIC REGISTER COMMA add_target
   { printf("Add instruction.\n"); };

or: OR_MNEMONIC REGISTER COMMA REGISTER
   { printf("Or instruction.\n"); };

and: AND_MNEMONIC REGISTER COMMA REGISTER
   { printf("And instruction.\n"); };

xor: XOR_MNEMONIC REGISTER COMMA REGISTER
   { printf("Xor instruction.\n"); };

shl: SHL_MNEMONIC REGISTER
   { printf("Shift left instruction.\n"); };

shr: SHR_MNEMONIC REGISTER
   { printf("Shift right instruction.\n"); };

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

