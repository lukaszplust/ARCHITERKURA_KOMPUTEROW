.686
.model flat

public _odejmij_jeden

.code
_odejmij_jeden PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]
	mov ebx, [ebx]
	dec dword PTR [ebx]

	pop ebx
	pop ebp
	ret
_odejmij_jeden ENDP
END
