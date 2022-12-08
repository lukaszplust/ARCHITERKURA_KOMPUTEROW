.686
.model flat

public _mase_lost
.data
wynik dw 16 dup (?)
.code
_mase_lost PROC	
	push ebp
	mov ebp,esp
	push esi
	push edi
	push ebx

	mov esi,[ebp+8];wskaznik na 1 tablice
	mov edi,[ebp+12]; wskaznik na 2 tablice
	mov ecx,[ebp+16];iterator
	cmp ecx,0 ;sprawdzenie zawartosci tablicy
	je koniec
	xor ebx,ebx

petla:
	mov eax, [esi+4*ebx]				; element z tablicy 1
	sub eax, dword ptr [edi+4*ebx]		; element z tablicy 2
	imul eax
	inc ebx
	add dword ptr[wynik], eax
	loop petla

koniec:
	mov eax, dword ptr[wynik]
	mov ebx,4; to co jest w n
	mov edx,0
	div ebx
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_mase_lost ENDP
END
