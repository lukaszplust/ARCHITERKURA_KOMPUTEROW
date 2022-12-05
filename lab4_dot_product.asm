.686
.model flat

public _dot_product
.data
wynik dw 16 dup (?)
.code
_dot_product PROC	
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
	imul word ptr [edi+4*ebx]		; element z tablicy 2
	inc ebx
	add dword ptr[wynik], eax
	loop petla

koniec:
	mov eax, dword ptr[wynik]
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_dot_product ENDP
END
