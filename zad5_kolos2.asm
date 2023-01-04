.686
.model flat

public _szyfruj

.code
_szyfruj PROC
    push ebp
    mov ebp, esp
    push esi
    push ebx
    push edi

    mov edx, 52525252h		; liczba losowa
    mov esi, [ebp+8]		; wskaznik na source tekst
    xor ecx, ecx			; dlugosc tekstu
    xor ebx, ebx			; iterator tekstu

dlugosc:
    mov al, [esi][ecx]
    cmp al, 0
    je dalej
    inc ecx
    jmp dlugosc
    ;w ecx jest dlugosc slowa

dalej:;gdy dotarlismy do konca zdania
    mov al, [esi]
    xor al, dl
    mov [esi], al; tu mamy 1 zaszyforwanie
    inc ebx
    dec ecx
    cmp ecx, 0
    je koniec

petla:
    ; szyfrowanie
    mov eax, 80000000h	; maska na 31 bit
    and eax, edx		; w eax jest 31 bit- > maska z liczba losowa
    mov edi, 40000000h	; maska na 30 bit
    and edi, edx		; w edi jest 30 bit -> maska z liczba losowa
    rol edi, 1          ; przesuniecie o 1 w lewo
    xor eax, edi        ;suma modulo 2
    bt eax, 31          ;ustawienie na bit 0 sumy modulo 2
    rcl edx, 1

    mov al, [esi][ebx]; szyfrowanie kolejnej liczby
    xor al, dl
    mov [esi][ebx], al
    inc ebx
    loop petla

koniec:
    pop edi
    pop ebx
    pop esi
    pop ebp
    ret
_szyfruj ENDP
END
