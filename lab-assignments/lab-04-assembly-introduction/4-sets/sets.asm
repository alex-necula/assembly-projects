%include "../io.mac"

section .text
    global main
    extern printf

main:
    ;cele doua multimi se gasesc in eax si ebx
    mov eax, 17
    mov ebx, 9
    PRINTF32 `%u\n\x0`, eax ; afiseaza prima multime
    PRINTF32 `%u\n\x0`, ebx ; afiseaza cea de-a doua multime

    ; TODO1: reuniunea a doua multimi
    or eax, ebx 
    PRINTF32 `Reuniunea este \x0`
    PRINTF32 `%u\n\x0`, eax

    ; TODO2: adaugarea unui element in multime
    or eax, 2;
    PRINTF32 `Noua multime dupa adaugarea lui 2 este \x0`
    PRINTF32 `%u\n\x0`, eax

    ; TODO3: intersectia a doua multimi
    and eax, ebx
    PRINTF32 `Intersectia celor doua multimi este \x0`
    PRINTF32 `%u\n\x0`, eax

    ; TODO4: complementul unei multimi
    mov edx, eax
    not edx
    PRINTF32 `Complementul multimii este \x0`
    PRINTF32 `%u\n\x0`, edx

    ; TODO5: eliminarea unui element
    mov edx, 1
    not edx
    and eax, edx
    PRINTF32 `Multimea dupa eliminarea lui 1 este \x0`
    PRINTF32 `%u\n\x0`, eax

    ; TODO6: diferenta de multimi EAX-EBX
    not ebx
    and eax, ebx
    PRINTF32 `Diferenta multimilor este \x0`
    PRINTF32 `%u\n\x0`, eax

    xor eax, eax
    ret
