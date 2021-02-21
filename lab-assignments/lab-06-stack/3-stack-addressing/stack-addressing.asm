%include "../utils/printf32.asm"

%define NUM 5

section .text

extern printf
global main
main:
    mov ebp, esp
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    sub esp, 4
    mov [esp], dword 0
    sub esp, 4
    mov [esp], dword "mere"
    sub esp, 4
    mov [esp], dword "are "
    sub esp, 4
    mov [esp], dword "Ana "

    lea esi, [esp]
    ;PRINTF32 `%s\n\x0`, esi

task2:
    mov ecx, ebp
    sub ecx, esp
    mov esi, esp ; save stack pointer
print_byte:
    PRINTF32 `%p: %hhu\n\x0`, esi, [esi]
    inc esi
    loop print_byte

task3:
    mov esi, esp
    mov ecx, 12 ; only 3 dword
print_string:
    PRINTF32 `%hhc\x0`, [esi]
    inc esi
    loop print_string
    PRINTF32 `\n\x0`

task4:
    mov esi, esp
    add esi, 16 ; skip string
    mov ecx, 5
print_array:
    PRINTF32 `%hhu \x0`, [esi]
    add esi, 4
    loop print_array
    PRINTF32 `\n\x0`

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret