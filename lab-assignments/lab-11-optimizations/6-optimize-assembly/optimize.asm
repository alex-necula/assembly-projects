global runAssemblyCode

section .text
runAssemblyCode:
    push ebp
    mov ebp, esp

    ; N
    mov ecx, [ebp+12] ; number of elements
    xor eax, eax ; store sum

    ; int* a
    mov edx, [ebp+8] ; pointer to first element
iterate:
    add eax, [edx + 4*(ecx - 1)]
    dec ecx
    test ecx, ecx
    jg iterate

    leave
    ret
