%include "../utils/printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    string_format db "%s", 10, 0
    int_format db "%d", 10, 0
    char_format db "%c", 10, 0

    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

section .text
extern printf
extern strlen
global main

get_int:
    ; int get_int(struct my_struct *obj)
    push ebp
    mov ebp, esp

    xor eax, eax
    mov edx, [ebp + 8] ; get obj from stack
    mov eax, [edx + int_x]

    leave
    ret

get_char:
    ; char get_char(struct my_struct *obj)
    push ebp
    mov ebp, esp

    xor eax, eax
    mov edx, [ebp + 8] ; get obj from stack
    mov al, [edx + char_y]

    leave
    ret

get_string:
    ; char* get_string(struct my_struct *obj)
    push ebp
    mov ebp, esp

    xor eax, eax
    mov edx, [ebp + 8] ; get obj from stack
    lea eax, [edx + string_s]

    leave
    ret

set_int:
    ; void set_int(struct my_struct *obj, int x)
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; get obj
    mov edx, [ebp + 12] ; get int

    mov dword [eax + int_x], edx

    leave
    ret

set_char:
    ; void set_char(struct my_struct *obj, char y)
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8] ; get obj
    mov dl, byte [ebp + 12] ; get char

    mov byte [eax + char_y], dl

    leave
    ret

set_string:
    ; void set_string(struct my_struct *obj, char* s)
    push ebp
    mov ebp, esp
    push ebx

    mov eax, [ebp + 8] ; get obj
    mov edx, [ebp + 12] ; get string

    xor ebx, ebx
    xor ecx, ecx ; counter for char

change_char:
    mov byte bl, [edx + ecx] ; get char from string
    mov byte [eax + string_s + ecx], bl ; set char
    inc ecx
    test bl, bl ; check null terminator
    jnz change_char

    pop ebx
    leave
    ret

main:
    push ebp
    mov ebp, esp

    mov edx, [new_int]
    push edx
    push sample_obj
    call set_int
    add esp, 8

    push sample_obj
    call get_int
    add esp, 4

    ;uncomment when get_int is ready
    push eax
    push int_format
    call printf
    add esp, 8

    movzx edx, byte [new_char]
    ; movzx is the same as
    ; xor edx, edx
    ; mov dl, byte [new_char]
    push edx
    push sample_obj
    call set_char
    add esp, 8

    push sample_obj
    call get_char
    add esp, 4

    ;uncomment when get_char is ready
    push eax
    push char_format
    call printf
    add esp, 8

    mov edx, new_string
    push edx
    push sample_obj
    call set_string
    add esp, 8

    push sample_obj
    call get_string
    add esp, 4

    ;uncomment when get_string is ready
    push eax
    push string_format
    call printf
    add esp, 8

    xor eax, eax
    leave
    ret
