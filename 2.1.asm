.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main
.data
tekst	db 10, 'Nazywam si',0A9h,' ',09Dh,'u','k','a','s','z', 10
		db 'M',0A2h,'j pierwszy 32-bitowy program '
		db 'asemblerowy dzia',88h,'a ju',0BEh,' ','poprawnie!', 10
.code
_main PROC
mov ecx, 84
push ecx
push dword PTR OFFSET tekst
push dword PTR 1
call __write
add esp, 12
push dword PTR 0
call _ExitProcess@4
_main ENDP
END
