.686
.model flat

public _komunikat
extern _malloc : proc

.code
_komunikat PROC
    push ebp
    mov ebp, esp
    push esi
    push edi
    push ebx

    mov esi,[ebp+8]
    xor ebx,ebx;iterator docelowego z iteracja na eax
    xor edi,edi;iterator wejsciowej
    mov ecx,5;iterator blad.

    push ecx;rezerwacja tylu miejsca
    call _malloc; wartosc w eax
    pop ecx
ptl:
    mov dl,[esi+edi]
    inc edi
    cmp dl,0
    je dodaj_blad
    mov [eax][ebx],dl
    inc ebx
    jmp ptl

dodaj_blad:
    mov [eax][ebx], byte ptr 'B'
    inc ebx
    mov [eax][ebx], byte ptr 'l'
    inc ebx
    mov [eax][ebx], byte ptr 'a'
    inc ebx
    mov [eax][ebx], byte ptr 'd'
    inc ebx
    mov [eax][ebx], byte ptr '.'
    inc ebx

    pop ebx
    pop edi
    pop esi
    pop ebp
    ret
_komunikat ENDP
END
