%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
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
    mov al, [esi + ecx - 1] ; get character from plaintext

    push ecx ; save iterate loop's counter

    test edi, edi ; checking if key is zero
    je add_to_cipher

    mov ecx, edi ; save value of key

    cmp al, 65 ; compare character with A
    jl add_to_cipher
    cmp al, 90 ; compare character with Z
    jle encrypt ; we have uppercase letter

    cmp al, 97 ; compare character with a
    jl add_to_cipher
    cmp al, 122 ; compare character with z
    jg add_to_cipher ; if less or equal, we have lowercase letter

encrypt:
    cmp al, 90 ; compare character with Z
    je letter_is_Z
    cmp al, 122 ; compare character with z
    je letter_is_z
    jne general_case

letter_is_Z:
    mov al, 65 ; change to A
    jmp corner_case

letter_is_z:
    mov al, 97 ; change to a
    jmp corner_case

general_case:
    inc al
corner_case:
    loop encrypt

add_to_cipher:
    pop ecx ; restore iterate loop's counter
    mov BYTE [edx + ecx - 1], al
    loop iterate

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY