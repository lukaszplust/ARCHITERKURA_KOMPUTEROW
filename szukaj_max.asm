.686
.model flat

public _szukaj_elem_max

.code
_szukaj_elem_max PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp+8]		; wskaznik na tablice
	mov ecx, [ebp+12]		; licznik petli
	xor edx, edx			; iterator
	xor eax, eax			; do porownania
	mov edi, ebx			; wskaznik na najwiekszy element (default 1 element)

petla:
	cmp [ebx], eax
	jge dodaj
	add ebx, 4
	loop petla
	jmp koniec

dodaj:
	mov eax, [ebx]
	mov edi, ebx
	add ebx, 4
	loop petla

koniec:
	mov eax, edi
	pop ebx
	pop ebp
	ret
_szukaj_elem_max ENDP
END
