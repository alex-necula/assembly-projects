%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    mov dh, 0 ; index of character from haystack

iterate_haystack:
    push ecx
    mov cl, dh ; we cannot use dh for indexing
    mov al, [esi + ecx] ; get character from haystack
    pop ecx
    mov ch, 0 ; index of character from needle
    push edx ; save haystack counter

iterate_needle:
    push ecx
    mov cl, ch ; we cannot use ch for indexing
    mov ch, 0
    mov ah, [ebx + ecx] ; get character from needle
    pop ecx
    cmp al, ah
    jne continue

    inc ch ; move to next character of needle
    inc dh ; move to next character of haystack
    push ecx
    mov cl, dh ; we cannot use dh for indexing
    mov ch, 0
    mov al, [esi + ecx] ; get character from haystack
    pop ecx
    cmp ch, dl
    jl iterate_needle

found:
    pop edx ; restore haystack counter
    mov BYTE [edi], dh ; was found
    jmp exit

continue:
    pop edx ; restore haystack counter
    inc dh ; move to next character of haystack
    mov al, dh ; use eax to compare with ecx
    ; for values of haystack_len above 128, we cannot compare with cl
    mov ah, 0
    cmp eax, ecx
    jl iterate_haystack

not_found:
    inc cl
    mov BYTE [edi], cl ; haystack_len + 1

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
