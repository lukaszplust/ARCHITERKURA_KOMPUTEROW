.686
.model flat
extern __read : PROC
extern __write : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data
rejestr1024 db 128 dup(80h);deklaracja tablicy 128 bajtow 
.code

_main PROC

mov ecx,128
mov edx,0
clc ; CF = 0
												;al
;   1023 ... itp... 16 | 15 14 13 12 11 10 9 8 | 7 6 5 4 3 2 1 0
;						 1 1 1 1 1 1 1 0		 1 1 1 1 1 1 1 0   <-to jakis randomowy przykład
;rcl al,1 -> cf = 1  (1 1 1 1 1 1 0 0) -> al 

ptl:
	mov al,byte ptr rejestr1024[edx]; przed przesunieciem
	rcl al,1
	mov byte ptr rejestr1024[edx],al; po przesunieciu
	inc edx
	loop ptl
	jnc dalej
	inc byte ptr rejestr1024
	dalej:
call _ExitProcess@4
_main ENDP
END
