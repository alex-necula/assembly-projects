%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power

compare:
    test eax, 1; checking for power of 2
    jz increment

print:
    PRINTF32 `%u\n\x0`, ebx

increment:
    shr eax, 1
    shl ebx, 1
    test eax, eax ; testing if number is zero
    jnz compare

exit:
    leave
    ret
