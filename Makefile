
all: asm_chip8

clean:
	-rm -f lex.yy.c chip8_asm.tab.c chip8_asm.tab.h asm_chip8 *.o

asm_chip8: lex.yy.c chip8_asm.tab.c generator.o
	gcc -o asm_chip8 lex.yy.c chip8_asm.tab.c generator.o

lex.yy.c: chip8_asm.l
	flex chip8_asm.l

chip8_asm.tab.c: chip8_asm.y generator.h
	bison -d chip8_asm.y

generator.o: generator.c generator.h
	gcc -c -o generator.o generator.c

