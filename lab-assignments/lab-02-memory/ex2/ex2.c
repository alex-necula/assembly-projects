#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* delete_first(char *s, char *pattern) {
	char* new_string = strdup(s);
	char* p = strstr(new_string, pattern);
	int len = strlen(pattern);
	if (p != NULL) {
		memmove(p, p + len, strlen(p + len) + 1);
	}
	return new_string;
}

int main(){
	char *s = "Ana are mere";
	char *pattern = "re";

	char* new_string = delete_first(s, pattern);
	printf("%s\n", new_string);
	free(new_string);

	return 0;
}
