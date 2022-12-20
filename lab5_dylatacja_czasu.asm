.686
.XMM
.model flat

public _dylatacja_czasu
.data
swiatlo dd 3.00
jeden dd 1
dziesiec dd 10
.code
_dylatacja_czasu PROC
push ebp
mov ebp,esp

finit
mov ecx,8

fild dziesiec
fld  swiatlo
ptl:
fmul st(0),st(1)
loop ptl
fmul st(0),st(0);c^2


;fild -> dla snsigned inta?
fld dword ptr [ebp+12]
fmul st(0),st(0);v^2


fdiv st(0),st(1)
fild jeden;laduje 1
fsub st(0),st(1);odejmuje od 1
fsqrt;mianownik skonczony
fild dword ptr [ebp+8];licznik
fdiv st(0),st(1);licznik przez mianownik
pop ebp
ret
_dylatacja_czasu ENDP
END
