.686
.model flat

public _merge_reversed

.data
tablica3 dw 16 dup(?)

.code
_merge_reversed PROC
	push ebp
	mov ebp, esp
	sub esp, 8					; zarezerwowanie miejsca na wskazniki na tablice
	push esi
	push edi
	push ebx

	mov ebx, [ebp+8]
	mov [ebp-4], ebx			; pierwsza tablica
	mov ebx, [ebp+12]
	mov [ebp-8], ebx			; druga tablica
	mov ecx, [ebp+16]			; ilosc elementow w tablicy
	cmp ecx, 32					; sprawdzenie czy nie ma za duzo elementow
	jge blad
	cmp ecx, 0					; sprawdzenie czy sa w ogole elementy
	je koniec
	mov esi,7
	mov edi,0
	xor edx,edx
zamiana:
	mov ebx,[ebp-8]
	mov eax, [ebx+4*esi]
	mov edx, [ebx+4*edi]
	mov [ebx+4*edi],eax
	mov [ebx+4*esi],edx
	inc edi
	dec esi
	cmp esi,3
	jne zamiana

	xor esi, esi				; iterator tablicy wejsciowej
	xor edi, edi				; iterator tablicy wyjsciowej




petla:
	mov ebx, [ebp-4]
	mov eax, [ebx+4*esi]
	mov dword ptr tablica3[4*edi], eax
	inc edi

	mov ebx, [ebp-8]
	mov eax, [ebx+4*esi];ebx , ebx+4, ebx+8, ebx+12, ebx+16, ebx+20, ebx+24, ebx+28
	mov dword ptr tablica3[4*edi], eax

	inc edi
	inc esi
	loop petla
	jmp koniec

blad:
	xor eax, eax
	jmp return
koniec:
	mov eax, OFFSET tablica3
return:
	pop ebx
	pop edi
	pop esi
	add esp, 8
	pop ebp
	ret
_merge_reversed ENDP
END
