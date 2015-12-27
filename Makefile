
all: asm_chip8

clean:
	-rm -f lex.yy.c chip8_asm.tab.c chip8_asm.tab.h asm_chip8

asm_chip8: lex.yy.c chip8_asm.tab.c
	gcc -o asm_chip8 lex.yy.c chip8_asm.tab.c

lex.yy.c: chip8_asm.l
	flex chip8_asm.l

chip8_asm.tab.c: chip8_asm.y
	bison -d chip8_asm.y

