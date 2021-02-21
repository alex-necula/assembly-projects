%include "../utils/printf32.asm"

%define ARRAY_SIZE 13
%define DECIMAL_PLACES 5

section .data

    num_array dw 76, 12, 65, 19, 781, 671, 431, 761, 782, 12, 91, 25, 9
    decimal_point db ".",0


section .text

extern printf
global main
main:
    xor eax, eax
    mov ecx, ARRAY_SIZE

    ; compute the sum of the vector numbers - store it in eax

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dx; zero entire edx.

add_num_array_element:
    mov dx, word [num_array + 2 * (ecx - 1)]
    add eax, edx
    loop add_num_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `Sum of numbers: %d\n\x0`, eax

    ; compute the quotient of the mean
    xor edx, edx
    mov ebx, ARRAY_SIZE
    div ebx

    PRINTF32 `Mean of numbers: %d\x0`, eax
    PRINTF32 `.\x0`

    mov ecx, DECIMAL_PLACES
compute_decimal_place:

    ; compute the current decimal place - store it in ax
    ; multiply remainder by 10
    ; divide it again by array size

    mov eax, edx ; move remainder to eax
    mov ebx, 10
    mul ebx

    mov ebx, ARRAY_SIZE
    div ebx

    PRINTF32 `%d\x0`, eax
    loop compute_decimal_place

    PRINTF32 `\n\x0`
    xor eax, eax
    ret
