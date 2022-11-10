.686
.model flat
public _liczba_przeciwna
.code
_liczba_przeciwna PROC
push ebp
mov ebp, esp
push ebx
mov ebx, [ebp+8]
neg dword PTR [ebx]
pop ebx
pop ebp
ret
_liczba_przeciwna ENDP
END
