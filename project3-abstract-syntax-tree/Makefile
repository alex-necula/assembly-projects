CC=gcc
CFLAGS=-m32 -g
ASM=nasm
ASMFLAGS=-f elf32 -g -F dwarf



build: ast.o ast_utils.o
	$(CC) $(CFLAGS) -o ast $^
ast.o: ast.asm
	$(ASM) $(ASMFLAGS) $< -o $@
clean: 
	rm ast ast.o
