%include "../utils/printf32.asm"

section .data
    N dd 9 ; compute the sum of the first N fibonacci numbers
    print_format_1 db "Sum first %d", 10, 0
    print_format_2 db "fibo is %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    push dword [N]
    push print_format_1
    call printf
    add esp, 8

    xor eax, eax     ;store the sum in eax

    mov ecx, [N]
    mov ebx, 0
    mov edx, 1

calc:
    add edx, ebx
    xchg edx, ebx
    add eax, edx
    loop calc

    push eax
    push print_format_2
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret