
all: asm_chip8

asm_chip8: lex.yy.c asm_chip8.tab.c
	gcc -o asm_chip8 lex.yy.c chip8_asm.tab.c

lex.yy.c: chip8_asm.l
	flex chip8_asm.l

asm_chip8.tab.c: chip8_asm.y
	bison -d chip8_asm.y

