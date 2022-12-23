.686
.model flat

public _pole_kola
.data
wynik dd ?
.code
_pole_kola PROC
push ebp
mov ebp,esp

finit
mov esi,[ebp+8]
push [esi]
fld dword ptr [esp]
fld dword ptr [esp]
add esp,4
fmul
fldpi
fmul

fstp wynik;zapis wyniku do wynik
mov eax,wynik
mov [esi],eax

pop ebp
ret
_pole_kola ENDP

END
