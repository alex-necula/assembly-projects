%include "io.mac"

section .data
    hex_table db '0123456789ABCDEF'

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    mov ebx, hex_table ; for the xlat instruction
    mov edi, ecx ; use edi as index for bin_sequence
    mov ch, 0 ; use ch to count nibbles

iterate_bin:
    mov cl, 0 ; counter for each bit in nibble
    xor eax, eax ; clear eax (we store nibble in al)
copy_nibble:
    mov ah, [esi + edi - 1] ; get character from bin_sequence (starting from end)
    sub ah, 0x30 ; convert to 0 or 1
    shl ah, cl
    or al, ah ; add to nibble
    xor ah, ah ; clear ah
    dec edi
    test edi, edi ; check if we reached end of bin_sequence
    je convert
    inc cl ; move to next character in nibble
    cmp cl, 4
    jne copy_nibble
convert:
    xlat
    push eax ; we will have hex characters in reverse order
    inc ch ; increase nibble count
    test edi, edi ; check if we reached end of bin_sequence
    jne iterate_bin

    xor ebx, ebx ; clear ebx
    mov bl, ch ; we can now use ebx for storing nibble count
    xor ecx, ecx ; clear ecx, use it for indexing nibble
add_to_hexa:
    pop eax
    mov BYTE [edx + ecx], al
    inc ecx ; move to next nibble
    cmp ecx, ebx
    jne add_to_hexa

    mov BYTE [edx + ebx], 10 ; add newline for checker

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY