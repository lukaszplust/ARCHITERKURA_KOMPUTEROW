.686
.XMM		; zezwolenie na asemblacje rozkazow z grupy SSE
.model flat

public _dodaj_SSE, _pierwiastek_SSE, _odwrotnosc_SSE

.code
_dodaj_SSE PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]		; adres pierwszej tablicy
	mov edi, [ebp+12]		; adres drugiej tablicy
	mov ebx, [ebp+16]		; adres tablicy wynikowej

	movups xmm5, [esi]		; przeniesienie do xmm5 czterech liczb zmiennoprzecinkowych
	movups xmm6, [edi]		; to samo ale dla drugiej tablicy
	addps xmm5, xmm6		; zsumowanie ich i wynik w xmm5
	movups [ebx], xmm5		; przeniesienie wnyiku do tablicy wynikowej

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_dodaj_SSE ENDP

_pierwiastek_SSE PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov esi, [ebp+8]		; adres pierwszej tablicy
	mov ebx, [ebp+12]		; adres tablicy wynikowej

	movups xmm6, [esi]		; przeniesienie 4 liczb zmiennoprzecinkowych
	sqrtps xmm5, xmm6		; pierwiastek z 4 liczb zmiennoprzecinkowych
	movups [ebx], xmm5		; zapisanie wyniku w tablicy w pamieci

	pop esi
	pop ebx
	pop ebp
	ret
_pierwiastek_SSE ENDP

_odwrotnosc_SSE PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi

	mov esi, [ebp+8]		; adres pierwszej tablicy
	mov ebx, [ebp+12]		; adres tablicy wynikowej

	movups xmm6, [esi]
	rcpps xmm5, xmm6		; obliczanie odwrotnosci czterech liczb float znajdujacych sie w xmm6
	movups [ebx], xmm5

	pop esi
	pop ebx
	pop ebp
	ret
_odwrotnosc_SSE ENDP
END
