#include <stdio.h>
#include <stdlib.h>

void print_binary(int number)
{
	printf("0b");
	for (unsigned int i = 1 << 7; i > 0; i = i/2) {
		(number & i) ? printf("1") : printf("0"); 
	}
	printf("\n");
}

void check_parity(int *numbers, int n)
{
	for (int i = 0; i < n; i++) {
		int number = *(numbers + i);
		if (number & 1) {
			printf("0x%08x\n", number);
		} 
		else {
			print_binary(number);
		}
	}
}

int main()
{
	int test[5] = {214, 71, 84, 134, 86};
	check_parity(test, 5);

	return 0;
}

