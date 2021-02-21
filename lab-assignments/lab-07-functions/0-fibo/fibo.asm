%include "../utils/printf32.asm"

%define NUM_FIBO 10

section .text

extern printf
global main
main:
    mov ebp, esp

    push 0
    push 1

    mov ecx, NUM_FIBO
    sub ecx, 2 ; first elements are 0 and 1
calc:
    mov ebx, [esp] ; get first element
    mov edx, [esp + 4] ; get second element
    add edx, ebx
    push edx
    loop calc

    mov ecx, NUM_FIBO
print:
    mov eax, dword [esp + (ecx - 1) * 4]
    PRINTF32 `%d \x0`, eax
    loop print

    PRINTF32 `\n\x0`
    mov esp, ebp
    xor eax, eax
    ret
