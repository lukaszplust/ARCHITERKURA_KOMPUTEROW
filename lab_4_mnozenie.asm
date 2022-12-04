.686
.model flat

public _mnozenie

.code
_mnozenie PROC
	push ebp
	mov ebp, esp
	push ebx
	xor edx,edx
	mov eax, [ebp+8]	; int **mnozna
	mov eax, [eax]		; int *mnozna
	mov eax, [eax]		; int mnozna
	mov ebx, [ebp+12]	; int *mnoznik
	mov ebx, [ebx]		; int mnoznik
	cmp eax,0
	jl znak
	jg dziel
znak:
neg eax
neg ebx
jmp dziel
	;eax -> dzielna
	;ebx -> dzielnik
dziel:
	imul ebx

	pop ebx
	pop ebp
	ret
_mnozenie ENDP
END
