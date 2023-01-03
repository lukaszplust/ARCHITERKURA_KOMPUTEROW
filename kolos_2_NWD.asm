.686
.model flat
public _NWD

.code
_NWD PROC
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+8]		; a
    mov edx, [ebp+12]		; b

    cmp eax, edx;16:12
    je koniec
    ja elif
    push eax
    sub edx, eax
    push edx
    call _NWD
    jmp powrot
elif:
    sub eax, edx
    push edx
    push eax
    call _NWD
powrot:
    add esp, 8

koniec:
    pop ebp
    ret
_NWD ENDP
END
