%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

iterate:
    mov al, [esi + ecx - 1] ; character from plaintext
    mov bl, [edi + ecx - 1] ; character from key
    xor al, bl ; encrypt
    mov BYTE [edx + ecx - 1], al ; move to ciphertext
    loop iterate

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY