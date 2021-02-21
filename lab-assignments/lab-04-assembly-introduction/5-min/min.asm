%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua numere se gasesc in eax si ebx
    mov eax, 2
    mov ebx, 1
    cmp eax, ebx

change:
    jl print
    xchg eax, ebx

print:
    PRINTF32 `%d\n\x0`, eax ; afiseaza minimul
    ret
