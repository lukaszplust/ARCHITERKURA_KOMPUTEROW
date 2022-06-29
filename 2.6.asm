.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC
extern __read : PROC
public _main
.data
tekst_pocz	db 10, 'Prosze napisac jakis tekst'
			db 'i nacisnac Enter', 10		
koniec_t	db ?
magazyn		db 80 dup (?)
nowa_linia		db 10
liczba_znakow	dd ?
tytul	db 'Message Box', 0
		

.code
_main PROC
	mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
	push ecx
	push OFFSET tekst_pocz
	push 1
	call __write
	add esp,12

	;czytanie

	push 80
	push OFFSET magazyn
	push 0
	call __read
	add esp,12

	mov liczba_znakow, eax
	mov ecx,eax
	mov ebx,0

ptl:	mov dl, magazyn[ebx]
		cmp dl, 'a'
		jb dalej
		cmp dl, 'z'
		ja dalej
		sub dl, 20H

		mov magazyn[ebx], dl
dalej:	inc ebx
		loop ptl

		push 0
		push OFFSET tytul
		push OFFSET magazyn
		
		
		push 0
		call _MessageBoxA@16
		push 0
		call _ExitProcess@4


_main ENDP
END
