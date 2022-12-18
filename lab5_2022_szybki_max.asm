.686
.XMM
.model flat

public _szybki_max
.code
_szybki_max PROC
	push ebp
	mov ebp, esp
	push ebx
	mov esi, [ebp+8]		; tablica 1
	mov ebx, [ebp+12]		; tablica 2
	mov ecx,1

	movups xmm0, [esi];przesylam 1 tablice
	movups xmm1, [ebx];przesylam 2 tablice
	pmaxsb xmm0, xmm1;max packed signed integers pmaxsb po wyborze smiga no clue why XDD
	movups [esi], xmm0;przesylam zmienna do esi

	pop ebx
	pop ebp
	ret
_szybki_max ENDP
END
