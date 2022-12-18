.686
.XMM
.model flat

public _int2float

.code
_int2float PROC
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov esi, [ebp+8]		; wskaznik na tablice calkowitych
	mov edi, [ebp+12]		; wskaznik na tablice zmiennych

	cvtpi2ps xmm5, qword ptr [esi]
	movsd qword ptr [edi], xmm5

	pop edi
	pop esi
	pop ebp
	ret
_int2float ENDP
END
