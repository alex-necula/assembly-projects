section .data
    delim db " ", 10, 0

section .bss
    root resd 1

section .text

extern strtok
extern strdup
extern malloc

global create_tree
global iocla_atoi

iocla_atoi:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx

    mov esi, [ebp + 8] ; token
    xor eax, eax ; store result
    xor ebx, ebx ; store individual char
    xor ecx, ecx ; counter for chars
    xor edi, edi ; 0 if positive, 1 if negative

    mov bl, byte [esi] ; check if negative
    cmp bl, 45
    jne iterate
    inc ecx
    mov edi, 1

iterate:
    mov bl, byte [esi + ecx] ; get char
    test ebx, ebx ; check for null terminator
    je check_negative

    sub ebx, 48 ; convert to number
    mov edx, 10 ; for multiplication
    mul edx
    add eax, ebx

    inc ecx
    jmp iterate

check_negative:
    test edi, edi
    je exit_atoi
    not eax ; using 2's complement
    inc eax

exit_atoi:
    pop ebx
    pop esi
    pop edi
    leave
    ret

create_node:
    push ebp
    mov ebp, esp
    push ebx

    push 12
    call malloc
    add esp, 4

    mov ebx, eax ; save malloc pointer

    push dword [ebp + 8]
    call strdup
    add esp, 4

    mov dword [ebx], eax ; set data
    mov dword [ebx + 4], 0 ; set left to null
    mov dword [ebx + 8], 0 ; set right to null

    mov eax, ebx ; return node pointer
    pop ebx
    leave
    ret

create_tree:
    push ebp
    mov ebp, esp
    push esi
    push ebx

create_root:
    push delim
    push dword [ebp + 8]; token
    call strtok
    add esp, 8

    push eax
    call create_node
    add esp, 4

    mov [root], eax ; save root
    push eax ; push first operator node to stack

next_node:
    push delim
    push 0
    call strtok
    add esp, 8

    test eax, eax ; check if token is null
    je exit_tree

    mov ebx, eax ; save token
    pop esi ; pop operator node

    push ebx
    call create_node
    add esp, 4

add_left:
    cmp dword [esi + 4], 0 ; check if left child is null
    jne add_right

    mov [esi + 4], eax ; set left child
    push esi ; push parent operator node
    jmp push_operator

add_right:
    mov [esi + 8], eax ; set right child

push_operator:
    ; check if current token is operator
    mov dl, byte [ebx]
    cmp dl, 48
    jge next_node
    mov dl, byte [ebx + 1] ; for negative numbers
    test dl, dl
    jne next_node

    push eax ; push child operator node
    jmp next_node

exit_tree:
    mov eax, [root]
    pop ebx
    pop esi
    leave
    ret
