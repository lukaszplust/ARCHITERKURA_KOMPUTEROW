.686
.model flat
public _pamiec
extern _GetPhysicallyInstalledSystemMemory@4 : proc
.data
bufor db 10 dup (?)

.code
_pamiec PROC
push ebp
mov ebp,esp
push offset bufor
call _GetPhysicallyInstalledSystemMemory@4
mov eax,dword ptr[bufor]

pop ebp
ret

_pamiec ENDP
END
