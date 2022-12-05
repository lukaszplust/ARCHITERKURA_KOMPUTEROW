.686
.model flat

public _reduction

.code
_reduction PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	xor edi, edi			; iterator tablicy
	mov esi, [ebp+8]		; tablica
	mov ecx, [ebp+12]		; licznik petli
	cmp ecx, 0
	je koniec
	mov ebx, [ebp+16]		; reductionType
	cmp ebx, 0
	je przedSuma
	jmp minMaks

minMaks:
	mov eax, [esi+4*edi]	; pierwszy element tablicy
	inc edi
	dec ecx					; porownan o 1 mniej
	cmp ebx, -1
	je minimum
	jmp maksimum

minimum:
	cmp eax, [esi+4*edi]
	jge przesunMin
	inc edi
	loop minimum
	jmp koniec
przesunMin:
	mov eax, [esi+4*edi]
	inc edi
	loop minimum

maksimum:
	cmp eax, [esi+4*edi]
	jle przesunMax
	inc edi
	loop maksimum
	jmp koniec
przesunMax:
	mov eax, [esi+4*edi]
	inc edi
	loop maksimum

przedSuma:
	dec ecx
	mov eax, [esi+4*edi]
	inc edi
suma:
	add eax, [esi+4*edi]
	inc edi
	loop suma

koniec:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_reduction ENDP
END
