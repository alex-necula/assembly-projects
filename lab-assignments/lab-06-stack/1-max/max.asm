%include "../utils/printf32.asm"

section .text

extern printf
global main
main:
    ; numbers are placed in these two registers
    mov eax, 1
    mov ebx, 4

    cmp eax, ebx
    jg print

change:
    push ebx
    pop eax

print:
    PRINTF32 `Max value is: %d\n\x0`, eax ; print maximum value
    ret
