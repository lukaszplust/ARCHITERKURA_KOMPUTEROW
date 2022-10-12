.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)

public _main
.data
tekst_pocz db 10, 'napisz imie i nazwisko',10
koniec_t db ?

magazyn_imie db 80 dup (?)
magazyn_nazwisko db 80 dup (?)
magazyn_inputu db 80 dup (?)
magazyn_output db 80 dup (?)


liczba_znakow dd ?

.code
_main PROC
; wyświetlenie tekstu informacyjnego

; liczba znaków tekstu
mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
push ecx
push OFFSET tekst_pocz ; adres tekstu
push 1 ; nr urządzenia (tu: ekran - nr 1)
call __write ; wyświetlenie tekstu początkowego
add esp, 12 ; usuniecie parametrów ze stosu

; czytanie wiersza z klawiatury
push 80 ; maksymalna liczba znaków
push OFFSET magazyn_inputu
push 0 ; nr urządzenia (tu: klawiatura - nr 0)
call __read ; czytanie znaków z klawiatury
add esp, 12 ; usuniecie parametrów ze stosu



mov liczba_znakow, eax
mov ecx, eax;	ecx -> licznik petli
mov eax,0;		eax -> indeks imienia
mov edi,0;		edi -> indeks nazwiska
mov ebx,0;		ebx -> indeks inputu
mov esi,0;		esi -> indeks outputu

;dodawanie liter z imienia
ptl:
	mov dl, magazyn_inputu[ebx]
	inc ebx
	cmp dl,' '
	je addNazwisko
	mov magazyn_imie[eax], dl
	inc eax
	loop ptl

;dodawanie liter z nazwiska
addNazwisko:
	mov dl, magazyn_inputu[ebx]
	inc ebx
	mov magazyn_nazwisko[edi],dl
	inc edi
	loop addNazwisko

;przeniesienie indeksów nazwiska do licznika ecx i odjecie spacji i entera od licznika
mov ecx, edi
mov edi,0
sub ecx,2

doOutputuImie:
	mov dl, magazyn_nazwisko[edi]
	inc edi
	mov magazyn_output[esi], dl
	inc esi
	loop doOutputuImie

mov magazyn_output[esi], ' '
inc esi

mov ecx,eax
mov eax,0

doOutputuNazwisko:
	mov dl,magazyn_imie[eax]
	inc eax
	mov magazyn_output[esi],dl
	inc esi
	loop doOutputuNazwisko





push liczba_znakow
push OFFSET magazyn_output
push 1
call __write ; wyświetlenie przekształconego tekstu
add esp, 12 ; usuniecie parametrów ze stosu
push 0
call _ExitProcess@4 ; zakończenie programu
_main ENDP
END
