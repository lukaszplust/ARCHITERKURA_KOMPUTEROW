.686

.model flat
extern _ExitProcess@4 : PROC
public _main


.data
    number_96 DD 6,0,0
    number_32 DD 2

.code 

_main:
    clc
    mov ecx, 3
    lea esi, number_96
    lea edi, number_32

    ;esi -> 96 bitowa
    ;edi -> 32 bitowa

    ; dzielenie jednego przez drugie
    xor edx,edx
    petla:
        mov eax, [esi]
        div DWORD PTR [edi] ; EDX:EAX -> wynik: EAX, reszta: EDX
        mov [esi], eax
        add esi, 4
        dec ecx
        jnz petla

    lea esi, number_96
    mov eax, [esi]
    sub eax, [edi]
    mov [esi], eax
    mov edi,2
    imul edi 
    nop

END
