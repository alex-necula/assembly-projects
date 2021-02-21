%include "../io.mac"

section .text
    global main
    extern printf

main:
    mov eax, 7       ; vrem sa aflam al N-lea numar; N = 7
    mov ebx, 0
    mov edx, 1

calc:
    add edx, ebx
    xchg edx, ebx
    sub eax, 1
    test eax, eax
    je print
    jg calc

print:
    PRINTF32 `%d\n\x0`, edx
    ret
