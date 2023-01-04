.686
.model flat

public _kwadrat

.code
_kwadrat PROC
    push ebp
    mov ebp, esp
    push esi
    push edi

    mov esi, [ebp+8]	; argument a
    cmp esi, 0
    je koniec
    cmp esi, 1
    je koniec
    
    ; wywolanie rekurencyjne
    mov eax, esi
    add eax, eax		; 2*eax
    add eax, eax		; 4*eax
    mov edi, eax		; w EDI wynik mnozenia

    sub esi, 2
    push esi
    call _kwadrat
    add esp, 4
    mov esi, eax		; w ESI wynik rekunrecji

    add esi, edi
    sub esi, 4

koniec:
    mov eax, esi
    pop edi
    pop esi
    pop ebp
    ret
_kwadrat ENDP
END
