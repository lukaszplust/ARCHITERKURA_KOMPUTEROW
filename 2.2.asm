.686
.model flat
public _main
extern _ExitProcess@4 : proc
.data

.code
_main PROC
	push 0
	call _ExitProcess@4
_main ENDP
END