# IOCLA 2020
# USO remembers

CC=gcc
ASM=nasm
ASMFLAGS=-f elf64 -F dwarf -g

mainmax: main.o max.o
	$(CC) -o $@ $^
main.o: main.c

max.o: max.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm *.o mainmax
