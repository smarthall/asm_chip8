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
%token RCALL_MNEMONIC SE_MNEMONIC SNE_MNEMONIC

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
           | sne;

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

sne: SNE_MNEMONIC REGISTER COMMA NUMBER
   { printf("Skip if not equal instruction.\n"); };

