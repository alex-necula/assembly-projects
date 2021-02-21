CC=gcc
CFLAGS=-Wall -Wextra -m32

build: rotations

rotations: rotations.o
	$(CC) $(CFLAGS) $^ -o $@

rotations.o: rotations.c
	$(CC) $(CFLAGS) -c $^ -o $@

run:
	./rotations

clean:
	rm *.o rotations
