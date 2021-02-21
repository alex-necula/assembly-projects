#include <unistd.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>

#define MAX_LENGTH 20

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

/*
 * Converts an integer to a string
 *
 * val: the input number
 * str: pointer to the beginning of the result string (already allocated)
 * base: specifies the desired base (in our case, 10 or 16)
 * is_signed: 1 for negative int, 0 for all other cases
 */
void int_to_string(int val, char *str, int base, int is_signed)
{
	int i = 0; // length of string
	int negative_decimal = 0;
	unsigned int num = val; // using 2's complement for negative numbers
	char buffer[MAX_LENGTH];

	// Special case for 0
	if (val == 0) {
		str[i++] = '0';
		str[i] = '\0';
		return;
	}

	if (val < 0 && is_signed == 1) {
		num = -val;
		negative_decimal = 1;
	}

	while (num != 0) {
		int digit = num % base;
		buffer[i++] = (digit > 9) ? (digit - 10 + 'a') : (digit + '0');
		num /= base;
	}

	if (negative_decimal) {
		buffer[i++] = '-';
	}

	buffer[i] = '\0';
	for (int j = 0; j < i; j++) {
		str[j] = buffer[i-j-1];
	}
}

/*
 *	Calls int_to_string and write_stdout functions to print a number from argument list
 *	Updates the chars_written variable
 */
void print_number(va_list args, int *chars_written, int base, int is_signed)
{
	char *string = (char *)calloc(MAX_LENGTH, 1);
	int_to_string(va_arg(args, int), string, base, is_signed);
	int length = strlen(string);
	write_stdout(string, length);
	*chars_written += length;
	free(string);
}

/*
 *	Calls write_stdout function to print a char from argument list
 *	Updates the chars_written variable
 */
void print_char(va_list args, int *chars_written)
{
	int parameter = va_arg(args, int);
	write_stdout((char *)&parameter, 1);
	(*chars_written)++;
}

/*
 *	Calls write_stdout function to print a string from argument list
 *	Updates the chars_written variable
 */
void print_string(va_list args, int *chars_written)
{
	char *s = va_arg(args, char*);
	int length = strlen(s);
	write_stdout(s, length);
	*chars_written += length;
}

/*
 *	Calls write_stdout function to print current character in format string
 *	Updates the chars_written variable
 */
void print_current(const char *format, int i, int *chars_written)
{
	write_stdout(format + i, 1);
	(*chars_written)++;
}

int iocla_printf(const char *format, ...)
{
	va_list args;
	int i = 0;
	int chars_written = 0;

	va_start(args, format);

	while (format[i] != '\0') {
		if (format[i] != '%') {
			print_current(format, i, &chars_written);
		} else {
			switch (format[++i]) {
			case 'd':
				print_number(args, &chars_written, 10, 1);
				break;
			case 'u':
				print_number(args, &chars_written, 10, 0);
				break;
			case 'x':
				print_number(args, &chars_written, 16, 0);
				break;
			case 'c':
				print_char(args, &chars_written);
				break;
			case 's':
				print_string(args, &chars_written);
				break;
			default:
				print_current(format, i, &chars_written);
			}
		}
		i++;
	}

	va_end(args);
	return chars_written;
}

