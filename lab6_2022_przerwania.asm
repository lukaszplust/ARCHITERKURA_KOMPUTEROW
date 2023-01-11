.386
rozkazy SEGMENT use16
		ASSUME CS:rozkazy

	clear_screen PROC
		push ax
		push bx
		push cx

		mov ax, 0A000h ;adres pamięci ekranu
		mov es, ax
		mov bx, 0
		ptl2:
			mov byte PTR es:[bx], 0
			add bx, 1;kolor
			cmp bx, 320*200
			jb ptl2
		pop cx
		pop bx
		pop ax
		ret
	clear_screen ENDP

	obsluga_zegara PROC
		cmp cs:czas, 18		;1000ms
		jb koniec_zegar
		mov cs:czas, 0
		cmp cs:kolor, 0;sprawdzam czy czerwony
		je CZERWONY1
		cmp cs:kolor, 1;sprawdzam czy zielony
		je ZIELONY1
		cmp cs:kolor, 2;sprawdzam czy niebieski
		je NIEBIESKI1

	CZERWONY1:
		inc cs:kolor
		call maluj
		jmp koniec_zegar
	ZIELONY1:
		inc cs:kolor
		call maluj
		jmp koniec_zegar
	NIEBIESKI1:
		mov cs:kolor, 0;czerwony
		call maluj
		jmp koniec_zegar

	koniec_zegar:
		inc cs:czas

		jmp dword PTR cs:wektor8
	licznik dw 0	; domyslnie lewo_gora
	kolor db 0		; 0 - zielony, 1-niebieski, 2-czerwony
	wektor8 dd ?
	klawisz db 2	;0 lewo_gora, 1- prawo_gora, 2-prawo_dol, 3-lewo_dol
	czas dw 0
	ilosc_pomalowanych dw 0
	obsluga_zegara ENDP

	maluj PROC
		push ax
		push bx
		push cx

		mov ax, 0A000h
		mov es, ax
		mov bx, cs:licznik

	ptl:
		cmp cs:kolor, 0
		je ZIELONY;zielony
		cmp cs:kolor, 1
		je NIEBIESKI;niebieski
		cmp cs:kolor, 2
		je CZERWONY;czerwony

	ZIELONY:
		mov byte PTR es:[bx], 00000010B;zielony
		jmp dalsza_czesc
	CZERWONY:
		mov byte PTR es:[bx], 00000100B;czerwony
		jmp dalsza_czesc
	NIEBIESKI:
		mov byte PTR es:[bx], 00000001B;niebieski
		jmp dalsza_czesc

	dalsza_czesc:
		mov al, cs:klawisz
		cmp al, 0
		je LEWO_GORA
		cmp al, 1
		je PRAWO_GORA
		cmp al, 2
		je PRAWO_DOL
		cmp al, 3
		je LEWO_DOL
		jmp DALEJ_RYSUJ

	LEWO_GORA:
		inc bx
		mov dx, 0
		mov ax, bx
		mov cx, 320
		div cx
		cmp dx, 160;sprawdzam czy jest polowa szerokosci
		jne DALEJ_RYSUJ
		add bx, 160;jesli jest to nowa linijka
		JMP DALEJ_RYSUJ
	PRAWO_GORA:
		inc bx
		mov dx, 0
		mov ax, bx
		mov cx, 160
		div cx
		cmp dx, 0	
		jne DALEJ_RYSUJ
		add bx, 160;nowa linijka od polowy
		jmp DALEJ_RYSUJ
	PRAWO_DOL:
		inc bx
		mov dx, 0
		mov ax, bx
		mov cx, 160
		div cx
		cmp dx, 0	
		jne DALEJ_RYSUJ
		add bx, 160;nowa linijka od polowy
		jmp DALEJ_RYSUJ
	LEWO_DOL:
		inc bx
		mov dx, 0
		mov ax, bx
		mov cx, 320
		div cx
		cmp dx, 160;sprawdzam czy jest polowa szerokosci
		jne DALEJ_RYSUJ
		add bx, 160;jesli jest to nowa linijka
		JMP DALEJ_RYSUJ

	DALEJ_RYSUJ:
		inc cs:ilosc_pomalowanych
		cmp cs:ilosc_pomalowanych, 16000
		jb ptl

	koniec:
		mov cs:ilosc_pomalowanych, 0			; przygotowanie do kolejnego rysowania
		pop cx
		pop bx
		pop ax
		ret
	maluj ENDP

zacznij:
	mov ah, 0
	mov al, 13h
	int 10h

	mov bx, 0
	mov es, bx
	mov eax, es:[32]
	mov cs:wektor8, eax

	mov ax, seg obsluga_zegara
	mov bx, offset obsluga_zegara

	cli
	mov es:[32], bx;16*0+32
	mov es:[34], ax
	sti
	call clear_screen
	call maluj

aktywne_oczekiwanie:
	mov ah,1
	int 16H
	jz aktywne_oczekiwanie
	mov ah, 0
	int 16H
	in al, 60h;sprawdzam co kliknieto
	cmp al, 75
	je USTAW_LEWO_GORA
	cmp al, 72
	je USTAW_PRAWO_DOL
	cmp al, 80
	je USTAW_LEWO_DOL
	cmp al, 77
	je USTAW_PRAWO_GORA
	jmp DALEJ

USTAW_LEWO_GORA:
	mov cs:klawisz, byte ptr 0
	mov cs:licznik, byte ptr 0;0:0
	call clear_screen
	call maluj
	jmp DALEJ
USTAW_PRAWO_GORA:
	mov cs:klawisz, byte ptr 1
	mov cs:licznik, byte ptr 160;polowa szerokosci
	call clear_screen
	call maluj
	jmp DALEJ
USTAW_PRAWO_DOL:
	mov cs:klawisz, byte ptr 2
	mov cs:licznik, byte ptr 320*100+160;polowa szerokosci i polowa dlugosci
	call clear_screen
	call maluj
	jmp DALEJ
USTAW_LEWO_DOL:
	mov cs:klawisz, byte ptr 3
	mov cs:licznik, byte ptr 320*100;polowa dlugosci
	call clear_screen
	call maluj
	jmp DALEJ

DALEJ:
	cmp ah, 1;esc
	jne aktywne_oczekiwanie

	mov ah, 0
	mov al, 3h
	int 10h

	mov eax, cs:wektor8
	mov es:[32], eax
	mov ax, 4C00h
	int 21H
rozkazy ENDS

nasz_stos SEGMENT stack
	db 256 dup (?)
nasz_stos ENDS

END zacznij
