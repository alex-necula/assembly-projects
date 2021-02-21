#include <stdio.h>

void main(void)
{
	int v[] = {4, 1, 2, -17, 15, 22, 6, 2};
	int max = v[0];
	int size = sizeof(v) / sizeof(int) - 1;
	int i = 1;

search:
	if (i > size) {
		goto print;
	}
	if (v[i] > max) {
		max = v[i];
	}
	i++;
	goto search;

print:
	printf("Maximul din vector este %d\n", max);
}
