.686
.model flat
public _ASCII_na_UTF16
extern _malloc : proc

.code
_ASCII_na_UTF16 PROC
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx

    mov esi, [ebp+8]	; source tablica
    mov eax, [ebp+12]
    add eax, 1			; miejsce na 16-bitowe zero
    mov ebx, 2h;musze pomnozyc x2
    mul ebx
    push eax
    call _malloc
    add esp, 4
    mov edi, eax;adres przydzielonego miejsca w edi
    mov ecx, [ebp+12]	; licznik
    xor ebx, ebx		; iterator

petla:
    xor ax, ax
    mov al, [esi][ebx]
    mov [edi+2*ebx], ax
    inc ebx
    loop petla

    mov [edi+2*ebx], word ptr 0h
    mov eax, edi;do eax wynik
    pop ebx
    pop edi
    pop esi
    pop ebp
    ret
_ASCII_na_UTF16 ENDP
END
