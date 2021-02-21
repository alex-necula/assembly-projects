#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int my_strlen(const char *str)
{
	int length = 0;
	while (*str) {
		str++;
		length++;
	}
	return length;
}

void equality_check(const char *str)
{	
	int i = 0;
	int power = 1;
	int length = my_strlen(str);
	while (*str) {
		if (!((*str) ^ *(str - i + ((i + power) % length)))) {
			printf("Address of %c is %p\n", *str, str);
		}
	
		power = 2<<i;
		i++;
		str++;
	}
}

int main(void)
{
	char test1[10] = "aac";
	printf("Length of string %s is %d\n", test1, my_strlen(test1));
	equality_check(test1);

	char test2[30] = "ababababacccbacbacbacbacbabc";
	printf("Length of string %s is %d\n", test2, my_strlen(test2));
	equality_check(test2);

	return 0;
}

