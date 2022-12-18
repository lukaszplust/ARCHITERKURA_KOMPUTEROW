.686
.XMM
.model flat

public _pm_jeden

.data
odnosnik dd 1.0, 1.0, 1.0, 1.0

.code
_pm_jeden PROC
	push ebp
	mov ebp, esp
	push esi

	mov esi, [ebp+8]				; wskaznik na tablice
	movups xmm0, [esi]				; pobranie 4 liczb (mozna to w petli zrobic)
	movups xmm1, odnosnik			; pobranie liczb ktore dodajemy/odejmujemy
	addsubps xmm0, xmm1
	movups [esi], xmm0

	pop esi
	pop ebp
	ret
_pm_jeden ENDP
END
