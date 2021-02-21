#include <stdio.h>

void rotate_left(unsigned int *number, int bits)
{
	printf("%d\n", ((*number) << bits) | (*number) >> (32 - bits));
}

void rotate_right(unsigned int *number, int bits)
{
	printf("%d\n", ((*number) >> bits | (*number) << (32 - bits)));
}

int main()
{
	unsigned int number = 0x80000000;
	int bits = 1;
	rotate_left(&number, bits);

	number = 0x00000001;
	bits = 16;
	rotate_right(&number, bits);

	return 0;
}

