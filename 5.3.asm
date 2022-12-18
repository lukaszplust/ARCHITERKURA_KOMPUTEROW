.686
.XMM
.model flat

public _dodaj_tablice

.code
_dodaj_tablice PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp+8]
	mov ebx, [ebp+12]
	mov edi, [ebp+16]

	movdqu xmm0, xmmword ptr [esi]
	movdqu xmm1, xmmword ptr [ebx]
	paddsb xmm0, xmm1
	movdqu [edi], xmm0

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_dodaj_tablice ENDP
END
