# Tema 1 IOCLA - printf

## 322CD - Necula Alexandru

For implementing my own printf I used the `va_list` data type to handle
functions with variable arguments.

I iterated over the `format` string, character by character, checking for `%`.

I used a switch statement to differentiate between specifiers. Because the
default function `itoa` doesn't exist in the `stdlib.h` library on Linux, I made
my own implementation. It handles the `%d` `%u` and `%x` specifiers.

### Homework feedback

Easy, straight-forward problem, clear explanations.
