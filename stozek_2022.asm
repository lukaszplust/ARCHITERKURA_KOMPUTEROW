.686
.XMM
.model flat

public _objetosc_stozka

.data
three dd 3.0

.code
_objetosc_stozka PROC
	push ebp
	mov ebp, esp
	finit

	fild dword ptr [ebp+8]
	fild dword ptr [ebp+8]
	fmul							; R^2

	fld dword ptr [ebp+12]
	fild dword ptr [ebp+8]
	fmul
	fadd							; R^2 + Rr

	fld dword ptr [ebp+12]
	fld dword ptr [ebp+12]
	fmul
	fadd							; R^2 + Rr + r^2

	fld dword ptr [ebp+16]
	fmul
	fldpi
	fmul
	fld dword ptr three
	fdiv

	pop ebp
	ret
_objetosc_stozka ENDP
END
