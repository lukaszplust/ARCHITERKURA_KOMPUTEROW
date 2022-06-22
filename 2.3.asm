.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

public _main
.data
tytul_Unicode	dw 'Z','n','a','k','i',' ', 0
tekst_Unicode	dw 'T','o',' ','j','e','s','t',' ','p','i','e','s',' '
		dw 0D83Dh,0DC15h,' ','i',' ','k','o','t',' ',0D83Dh, 0DC31h, 0
				
.code
_main PROC

push 0
push OFFSET tytul_Unicode
push OFFSET tekst_Unicode
push 0
call _MessageBoxW@16
push 0
call _ExitProcess@4

_main ENDP

END
