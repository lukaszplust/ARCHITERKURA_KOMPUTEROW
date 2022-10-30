.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)

public _main
.data
znak dw 0D83Ch,0DF11h, 0
tekst_pocz db 10, 'Proszę napisać jakiś tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
tytul dw 'z','a','d',' ','l','a','b',0
magazyn db 80 dup (?)
magazyn_inputu dw 80 dup (?)
magazyn_outputu dw 80 dup (?)
nowa_linia db 10
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
	 push OFFSET magazyn
	 push 0 ; nr urządzenia (tu: klawiatura - nr 0)
	 call __read ; czytanie znaków z klawiatury
	 add esp, 12 ; usuniecie parametrów ze stosu
	 mov liczba_znakow, eax ; kody ASCII napisanego tekstu zostały wprowadzone do obszaru 'magazyn' funkcja read 
							; wpisuje do rejestru EAX liczbę wprowadzonych znaków

; rejestr ECX pełni rolę licznika obiegów pętli

	 mov ecx, eax; licznik petli
	 mov ebx, 0 ; zajete - >indeks początkowy
	 mov esi, 0 ; zajete - >indeks dla utfa
	 mov edx,0
	 
;eax -> licznik programu
;edi -> wolny



;ecx -> licznik wejscia
;ebx -> indeks do pobierania
;esi -> magazyn_inputu

ptl: 
	 mov dl,magazyn[ebx] ; pobranie kolejnego znaku
	 inc ebx
	 mov magazyn_inputu[esi], dx; w dx znajduje się liczba w hex
	 add esi, 2
	 loop ptl

	mov ebx, 0 ; nowy indeks
	mov esi, 0 ;indeks literek
	mov edi,0
	mov edx,0

ptl_glowna:
	mov dx, magazyn_inputu[2*eax-2]
	cmp dx,20h
	je zeStosu
	jne naStos

naStos:
	push dx
	inc esi
	cmp eax,1
	;cmp eax albo edi i ksiezyc albo to drugie na zmiane
	je zeStosu
	jne petla

zeStosu:
	pop bx
	mov magazyn_outputu[2*edi],bx
	inc edi
	dec esi

	cmp edi,7
	je gwiazdka
	cmp edi,11
	je ksiezyc
	cmp edi,17
	je gwiazdka
	cmp edi,22
	je ksiezyc
	cmp esi,1
	je spacja
	jne zeStosu

spacja:
	mov magazyn_outputu[2*edi],20h
	inc edi
	jmp petla

ksiezyc:
	mov magazyn_outputu[2*edi],2600h
	inc edi
	jmp petla
gwiazdka:
	mov magazyn_outputu[2*edi],0D83Ch
	inc edi
	mov magazyn_outputu[2*edi],0DF11h
	inc edi
	jmp petla

petla:
dec eax
jne ptl_glowna

mov magazyn_outputu[2*edi-1], 0; dodajemy 0 na koniec stringa(klasycznie np. napis db 1,2,3,0)
; wyświetlenie przekształconego tekstu

	 push 0
	 push OFFSET tytul
	 push OFFSET magazyn_outputu
	 push 0
	 call _MessageBoxW@16

	 add esp, 12 ; usuniecie parametrów ze stosu
	 push 0
	 call _ExitProcess@4 ; zakończenie programu

_main ENDP
END
