.686
.model flat

public _odejmowanie

.code
_odejmowanie PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp+8]	; int **odjemna
	mov eax, [eax]		; int *odjemna
	mov eax, [eax]		; int odjemna
	mov ebx, [ebp+12]	; int *odjemnik
	mov ebx, [ebx]		; int odjemnik
	sub eax, ebx

	pop ebx
	pop ebp
	ret
_odejmowanie ENDP
END
