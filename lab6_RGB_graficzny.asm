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
			add bx, 1
			cmp bx, 320*200;max piksele 200 wierszy 
			jb ptl2

		pop cx
		pop bx
		pop ax
		ret
	clear_screen ENDP

	obsluga_zegara PROC
		cmp cs:czas, 18		; 18 = 1000ms
		jb koniec_zegar
		mov cs:czas, 0
		cmp cs:kolor, 0
		je CZERWONY1
		cmp cs:kolor, 1
		je ZIELONY1
		cmp cs:kolor, 2
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
		mov cs:kolor, 0
		call maluj
		jmp koniec_zegar

	koniec_zegar:
		inc cs:czas

		jmp dword PTR cs:wektor8
	licznik dw 0	; Domyslnie idziemy od gory
	kolor db 0		; 0 - czerwien, 1-zielony, 2-niebieski
	wektor8 dd ?
	klawisz db 2	;	0 - lewo, 1- prawo, 2-gora, 3-dol
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
		je CZERWONY
		cmp cs:kolor, 1
		je ZIELONY
		cmp cs:kolor, 2
		je NIEBIESKI

	CZERWONY:
		mov byte PTR es:[bx], 00000100B
		jmp dalsza_czesc
	ZIELONY:
		mov byte PTR es:[bx], 00000010B
		jmp dalsza_czesc
	NIEBIESKI:
		mov byte PTR es:[bx], 00000001B
		jmp dalsza_czesc
		;sprawdzam klawisz
	dalsza_czesc:
		mov al, cs:klawisz
		cmp al, 0
		je LEWO
		cmp al, 1
		je PRAWO
		cmp al, 2
		je GORA
		cmp al, 3
		je DOL
		jmp DALEJ_RYSUJ

	LEWO:
		inc bx
		mov dx, 0
		mov ax, bx
		mov cx, 320
		div cx
		cmp dx, 160;jezeli reszta 160 to skok do kolejnej lini
		jne DALEJ_RYSUJ
		add bx, 160
		JMP DALEJ_RYSUJ
	PRAWO:
		inc bx
		mov dx, 0
		mov ax, bx
		mov cx, 320
		div cx
		cmp dx, 0	; jezeli reszta to 0 to skaczemy do kolejnej linii
		jne DALEJ_RYSUJ
		add bx, 160
		jmp DALEJ_RYSUJ
	GORA:
		inc bx
		cmp bx, 32000
		jmp DALEJ_RYSUJ
	DOL:
		inc bx
		cmp bx, 64000
		jmp DALEJ_RYSUJ

	DALEJ_RYSUJ:
		inc cs:ilosc_pomalowanych
		cmp cs:ilosc_pomalowanych, 32000
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
	mov es:[32], bx
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
	in al, 60h
	; sprawdzam wcisniety klawisz jest w al
	cmp al, 75
	je USTAW_LEWO
	cmp al, 72
	je USTAW_GORA
	cmp al, 80
	je USTAW_DOL
	cmp al, 77
	je USTAW_PRAWO
	jmp DALEJ

USTAW_LEWO:
	mov cs:klawisz, byte ptr 0
	mov cs:licznik, byte ptr 0
	call clear_screen
	call maluj
	jmp DALEJ
USTAW_PRAWO:
	mov cs:klawisz, byte ptr 1
	mov cs:licznik, byte ptr 160
	call clear_screen
	call maluj
	jmp DALEJ
USTAW_GORA:
	mov cs:klawisz, byte ptr 2
	mov cs:licznik, byte ptr 0
	call clear_screen
	call maluj
	jmp DALEJ
USTAW_DOL:
	mov cs:klawisz, byte ptr 3
	mov cs:licznik, byte ptr 320*100;100 wierszy
	call clear_screen
	call maluj
	jmp DALEJ

DALEJ:
	cmp ah, 1	; ESC
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
