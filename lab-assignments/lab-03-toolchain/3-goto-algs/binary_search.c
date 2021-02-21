#include <stdio.h>

void main(void)
{
	int v[] =  {1, 2, 15, 51, 53, 66, 202, 7000};
	int dest = v[2]; /* 15 */
	int start = 0;
	int end = sizeof(v) / sizeof(int) - 1;
	int middle;

split:
	middle = (start + end) / 2;
	if (dest == v[middle]) {
		goto found;
	}
	if ((middle == end) || (middle == start)) {
		goto not_found;
	}
	if (dest > v[middle]) {
		goto right;
	}
	if (dest < v[middle]) {
		goto left;
	}

left:
	end = middle;
	goto split;

right:
	start = middle;
	goto split;

found:
	printf("The number was found on position %d\n", middle);
	return;

not_found:
	printf("The number was not found\n");
}
