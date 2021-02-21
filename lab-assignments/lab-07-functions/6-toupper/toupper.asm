section .data
    before_format db "before %s", 13, 10, 0
    after_format db "after %s", 13, 10, 0
    mystring db "aBC{D}efghij", 0

section .text

extern printf
global main

toupper:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8] ; the string

copy_one_byte:
    mov bl, byte [eax]
    test bl, bl ; check for null terminator
    je out

    cmp bl, 97 ; compare character with a
    jl do_not_change
    cmp bl, 122 ; compare character with z
    jg do_not_change ; otherwise we have lower case letter

    sub bl, 0x20 ; change to uppercase
do_not_change:
    mov byte [eax], bl
    inc eax
    jmp copy_one_byte

out:
    leave
    ret

main:
    push ebp
    mov ebp, esp

    push mystring
    push before_format
    call printf
    add esp, 8

    push mystring
    call toupper
    add esp, 4

    push mystring
    push after_format
    call printf
    add esp, 8

    leave
    ret
