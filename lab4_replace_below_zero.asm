.686
.model flat

public _replace_below_zero

.data
wynik dw 16 dup(?)

.code
_replace_below_zero PROC
	push ebp
	mov ebp, esp
	sub esp, 8					; zarezerwowanie miejsca na wskazniki na tablice
	push esi
	push edi
	push ebx

	mov ebx, [ebp+8]			; zawartosc TAB1 do ebx
	mov [ebp-4], ebx			; TAB1 w ebp-4
	mov edx,[ebp+16]			;value w ebx -> ebp-8
	mov [ebp-8], edx
	mov ecx, [ebp+12]			; int n do ecx(licznik)
	cmp ecx, 32					; sprawdzenie czy nie ma za duzo elementow
	jge blad
	cmp ecx, 0					; sprawdzenie czy sa w ogole elementy
	je koniec

	xor esi, esi				; iterator tablicy wejsciowej
	xor edi, edi				; iterator tablicy wyjsciowej

petla:
	mov ebx, [ebp-4];w ebx wartosci z tablicy
	mov eax, [ebx+4*esi]; wrzucenie tych wartosci do eax
	cmp eax,0
	jl zmien
	jge zostaw
zmien:
	mov eax,[ebp+16]
	mov dword ptr wynik[4*edi], eax
	inc edi
	inc esi
	loop petla
	jmp koniec
zostaw:
	mov dword ptr wynik[4*edi], eax
	inc edi
	inc esi
	loop petla
	jmp koniec

blad:
	xor eax, eax
	jmp return
koniec:
	mov eax, OFFSET wynik
return:
	pop ebx
	pop edi
	pop esi
	add esp, 8
	pop ebp
	ret
_replace_below_zero ENDP
END
