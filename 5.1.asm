.686
.model flat

public _srednia_harm

.code
_srednia_harm PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	finit					; wyzerowanie koprocesora

	mov esi, [ebp+8]		; wskaznik na tablice
	mov ecx, [ebp+12]		; ilosc elementow w tablicy
	xor edi, edi			; iterator tablicy
	fldz

suma:
	fld dword ptr [esi+4*edi]
	inc edi
	fld1
	fdiv st(0), st(1)
	fadd st(2), st(0)
	fstp st(0);usuniecie 0 z wierzcholka stosu
	fstp st(0); usuniecie 0 z wierzcholka stosu
	loop suma

	fild dword ptr [ebp+12]	; ilosc elementow
	fdiv st(0), st(1)
	fstp st(1);usuniecie niepotrzebnej wartosci

	pop edi
	pop esi
	pop ebp
	ret
_srednia_harm ENDP
END
