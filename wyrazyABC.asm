.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC

extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)
public _main
.data
tytul dw 'Z','A','D',' ','2',0
magazyn_input dw 0077h,0079h,0072h,0061h,007Ah,005Fh,0041h,' ',0077h,0079h,0072h,0061h,007Ah,005Fh,0042h,' ',0077h,0079h,0072h,0061h,007Ah,005Fh,0043h
koniec dw ?
magazyn_output dw 15 dup (?)

.code
_main PROC

mov ecx, (OFFSET koniec) - (OFFSET magazyn_input)
mov esi,0; indeks inputu
mov edi,0; indeks outputu


;glowna petla
ptl:
	mov dx, magazyn_input[esi]
	inc esi
	cmp dx,0041h
	je dodajA
	cmp dx,0042h
	je dodajB
	cmp dx,0043h
	je dodajC
	jne output


;wrzucam do tablicy A
dodajA:
	mov magazyn_output[edi],0043h
	inc edi
	loop ptl

;wrzucam do tablicy B
dodajB:
	mov magazyn_output[edi],0042h
	inc edi
	loop ptl

	;wrzucam do tablicy C
dodajC:
	mov magazyn_output[edi],0041h
	inc edi
	loop ptl

output:
	mov magazyn_output[edi],dx
	inc edi
	loop ptl
	jmp wypisz



;;Message box
wypisz:	push 0
		push OFFSET tytul
		push OFFSET magazyn_output
		push 0
		call _MessageBoxW@16
		push 0
		call _ExitProcess@4 ; zakończenie programu
_main ENDP
END
