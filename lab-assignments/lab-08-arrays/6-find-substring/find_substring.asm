%include "../utils/printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

print_format: db "Substring found at index: ", 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    xor eax, eax ; keep character from source
    xor edx, edx ; keep character from substring
    xor esi, esi ; counter for source
    xor edi, edi ; counter for substring

iterate_source:
not_found:
    xor edi, edi
found:
    mov ecx, esi ; keep starting index
    mov al, [source_text + esi]
    mov dl, [substring + edi]
    test dl, dl ; check for null terminator
    ; TODO: Print the start indices for all occurrences of the substring in source_text
    cmp al, dl
    jne not_found
    inc esi
    inc edi
    
    leave
    ret
