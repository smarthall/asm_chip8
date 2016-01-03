#ifndef AST_H
#define AST_H

#include <inttypes.h>

// Arguments
typedef enum {
    AST_REGISTER,
    AST_LABEL,
    AST_NUMBER,
} ast_arg_type;

typedef union {
    int number;
    char *label;
} ast_arg_val;

typedef struct argument {
    ast_arg_type type;
    ast_arg_val value;

    struct argument *next;
} ast_argument;

ast_argument* ast_create_label(char *label);
ast_argument* ast_create_number(int number);
ast_argument* ast_create_register(int reg);

// Instructions
typedef struct instruction {
    uint16_t (*generator)(struct instruction*);

    struct instruction *next;

    ast_argument *arg_head;
    ast_argument *arg_tail;
} ast_instruction;

typedef uint16_t (*ast_opcode_generator)(struct instruction*);

ast_instruction* ast_create_instruction(ast_opcode_generator generator);
void ast_add_argument(ast_instruction *instruction, ast_argument *argument);

#define GENERATE_OPCODE(instruction) (instruction)->generator(instruction)

#endif /* AST_H */
