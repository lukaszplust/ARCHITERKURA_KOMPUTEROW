.686
.model flat

public _dzielenie

.code
_dzielenie PROC
	push ebp
	mov ebp, esp
	push ebx
	xor edx,edx
	mov eax, [ebp+8]	; int **dzielna
	mov eax, [eax]		; int *dzielna
	mov eax, [eax]		; int dzielna
	mov ebx, [ebp+12]	; int *dzielnik
	mov ebx, [ebx]		; int dzielnik
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
	idiv ebx

	pop ebx
	pop ebp
	ret
_dzielenie ENDP
END
