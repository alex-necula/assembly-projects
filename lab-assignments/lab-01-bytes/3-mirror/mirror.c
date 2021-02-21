#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void mirror(char *s)
{
	int length = strlen(s);
	char* reverse = calloc(sizeof(char), length);
	s = s + length - 1; // Move to last character
	for (int i = 0; i < length; i++) {
		*reverse = *s;
		reverse++;
		s--;
	}
	reverse = reverse - length; // Move to first character
	printf("%s\n", reverse);
	free(reverse);
}

int main()
{
	char test1[20] = "AnaAreMere";
	mirror(test1);

	char test2[20] = "qwerty";
	mirror(test2);

	return 0;
}

