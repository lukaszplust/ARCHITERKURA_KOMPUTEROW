.686
.model flat

public _roznica
.data
.code
_roznica PROC
push ebp
mov ebp,esp

mov edx,[ebp+8]
mov eax,[edx]; tu jest *
mov ebx,[ebp+12];przesyłam do ebx adres odjemnika
mov ecx,[ebx];adres do ecx
mov ecx,[ecx];i z adresu ecx do ecx bo to jest **
sub eax,ecx
pop ebp
ret
_roznica ENDP
END
