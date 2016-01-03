
CC = gcc
CFLAGS = -g
LDFLAGS =

all: asm_chip8

clean:
	-rm -f lex.yy.c chip8_asm.tab.c chip8_asm.tab.h asm_chip8 *.o

asm_chip8: lex.yy.o chip8_asm.tab.o generator.o ast.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o asm_chip8 lex.yy.o chip8_asm.tab.o generator.o ast.o

lex.yy.c: chip8_asm.l
	flex chip8_asm.l

lex.yy.o: lex.yy.c chip8_asm.tab.c
	$(CC) $(CFLAGS) -c -o lex.yy.o lex.yy.c

chip8_asm.tab.c: chip8_asm.y generator.h
	bison -d chip8_asm.y

chip8_asm.tab.o: chip8_asm.tab.c
	 $(CC) $(CFLAGS) -c -o chip8_asm.tab.o chip8_asm.tab.c

generator.o: generator.c generator.h
	$(CC) $(CFLAGS) -c -o generator.o generator.c

ast.o: ast.c ast.h chip8_asm.tab.c
	$(CC) $(CFLAGS) -c -o ast.o ast.c

