.686
.model flat

public _avg_wd

.code
_avg_wd PROC
    push ebp
    mov ebp, esp
    finit
    push esi
    push ebx

    mov ecx, [ebp+8]	; licznik tablic
    mov esi, [ebp+12]	; tablica liczb
    mov edi, [ebp+16]	; tablica wag
    xor ebx, ebx		; iterator tablic
    
    fldz
petlaLiczb:
    push [esi+4*ebx]
    fld dword ptr [esp]
    push [edi+4*ebx]
    fld dword ptr [esp]
    add esp, 8
    inc ebx
    fmul
    fadd
    loop petlaLiczb

    fldz
    xor ebx, ebx
    mov ecx, [ebp+8]
petlaWag:
    push [edi+4*ebx]
    fld dword ptr [esp]
    add esp, 4
    inc ebx
    fadd
    loop petlaWag

    fdiv

    pop ebx
    pop esi
    pop ebp
    ret
_avg_wd ENDP
END
