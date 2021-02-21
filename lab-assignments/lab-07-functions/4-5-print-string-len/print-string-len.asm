%include "../utils/printf32.asm"

section .data
    mystring db "This is my string", 0
    format_string db "String length is %u", 10, 0
    format_string_reverse db "Reversed string is: %s", 10, 0
    store_string times 64 db 0

section .text

extern puts
extern printf
global main

reverse_string:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8]
    mov ecx, dword [ebp+12]
    add eax, ecx
    dec eax
    mov edx, dword [ebp+16]

copy_one_byte:
    mov bl, byte [eax]
    mov byte [edx], bl
    dec eax
    inc edx
    loopnz copy_one_byte

    inc edx
    mov byte [edx], 0

    leave
    ret

main:
    push ebp
    mov ebp, esp

    mov eax, mystring
    xor ecx, ecx
test_one_byte:
    mov bl, byte [eax]
    test bl, bl
    je out
    inc eax
    inc ecx
    jmp test_one_byte

out:
    PRINTF32 `[PRINTF32]: %d\n[printf]: \x0`, ecx
    push ecx ; save for later
    push ecx
    push format_string
    call printf
    add esp, 8

    pop ecx
    push store_string
    push ecx
    push mystring
    call reverse_string
    add esp, 12

    push store_string
    push format_string_reverse
    call printf
    add esp, 8

    leave
    ret
