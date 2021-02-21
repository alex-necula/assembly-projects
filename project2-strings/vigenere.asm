%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    mov ah, 0 ; index of character from key
    mov bh, 0 ; index of character from plain_text

iterate:
    push ecx
    mov cl, bh ; we cannot use bh for indexing
    mov al, [esi + ecx] ; get character from plaintext
    pop ecx

    cmp al, 65 ; compare character with A
    jl add_to_cipher
    cmp al, 90 ; compare character with Z
    jle get_key_char ; we have uppercase letter

    cmp al, 97 ; compare character with a
    jl add_to_cipher
    cmp al, 122 ; compare character with z
    jg add_to_cipher ; if less or equal, we have lowercase letter

get_key_char:
    push ecx
    mov cl, ah ; we cannot use ah for indexing
    mov cl, [edi + ecx] ; get character from key

    sub ecx, 65 ; A is 65 in ASCII
    inc ah ; move to next character in key
    cmp ah, bl ; check if all characters of the key have been iterated
    jl check_key_letter_A

move_to_first:
    mov ah, 0 ; move index to first character of key

check_key_letter_A:
    test ecx, ecx ; check if letter of key is A (nothing to change)
    je restore_outer_loop_counter

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

restore_outer_loop_counter:
    pop ecx

add_to_cipher:
    push ecx
    mov cl, bh ; we cannot use bh for indexing
    mov BYTE [edx + ecx], al
    pop ecx
    inc bh ; move to next character
    cmp bh, cl
    jl iterate

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY