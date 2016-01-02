#ifndef AST_H
#define AST_H

// Types of argument
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
} ast_argument;

// Arguments
ast_argument* ast_create_label(char *label);
ast_argument* ast_create_number(int number);
ast_argument* ast_create_register(int reg);

#endif /* AST_H */
