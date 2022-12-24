.686
.model flat

public _kopia_tablicy
extern _malloc : proc

.code
_kopia_tablicy PROC
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx

    mov esi, [ebp+8]	; adres pierwszej tablicy
    xor ebx, ebx		; iterator na obie tablice
    mov edi, [ebp+12]	; ilosc elementow
    imul edi, 4			; int jest na 4 bajtach
    push edi
    call _malloc		; EAX wskazuje na miejsce w pamieci z nowa tablica
    add esp, 4
    cmp eax, 0
    je koniec

    mov ecx, [ebp+12]
petla:
    mov edx, [esi+4*ebx]
    bt edx, 0
    jc nieparzysta
    mov [eax+4*ebx], edx
    inc ebx
    loop petla
    jmp koniec
nieparzysta:
    mov edx, 0
    mov [eax+4*ebx], edx
    inc ebx
    loop petla

koniec:
    pop ebx
    pop edi
    pop esi
    pop ebp
    ret
_kopia_tablicy ENDP
END
