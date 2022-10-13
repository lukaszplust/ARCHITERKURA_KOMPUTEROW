.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)

public _main
.data
tekst_pocz db 10, 'Proszę napisać jakiś tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
utf16 dw 80 dup (?)
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
	 mov ecx, eax
	 mov ebx, 0 ; indeks początkowy
	 mov esi, 0 ; indeks dla utfa
ptl: 
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku
	 cmp dl, 165 ;ą
	 je a_z_ogonkiem
	 cmp dl, 134 ;ć
	 je c_z_kreska
	 cmp dl, 169 ;ę
	 je e_z_ogonkiem
	 cmp dl, 136 ;ł
	 je l_z_kreska
	 cmp dl, 228 ;ń
	 je n_z_kreska
	 cmp dl, 162 ;ó
	 je o_z_kreska
	 cmp dl, 152 ;ś
	 je s_z_kreska
	 cmp dl, 171 ;ź
	 je z_z_kreska
	 cmp dl, 190 ;ż
	 je z_z_kropka
	 cmp dl, 'a'
	 jb normalnie ; skok, gdy znak nie wymaga zamiany
	 cmp dl, 'z'
	 ja normalnie ; skok, gdy znak nie wymaga zamiany
	 sub dl, 20H ; zamiana na wielkie litery	; odesłanie znaku do pamięci
normalnie:
	 mov magazyn[ebx], dl
	 mov dh, 0
	 mov utf16[esi], dx
	 add esi, 2
	 jmp dalej

a_z_ogonkiem:
	mov magazyn[ebx], 165
	mov utf16[esi], 0104H
	add esi, 2
	jmp dalej

c_z_kreska:
	mov magazyn[ebx], 198
	mov utf16[esi], 0106H
	add esi, 2
	jmp dalej

e_z_ogonkiem:
	mov magazyn[ebx], 202
	mov utf16[esi], 0118H
	add esi, 2
	jmp dalej

l_z_kreska:
	mov magazyn[ebx], 163
	mov utf16[esi], 0141H
	add esi, 2
	jmp dalej

o_z_kreska:
	mov magazyn[ebx], 211
	mov utf16[esi], 0d3H
	add esi, 2
	jmp dalej

z_z_kreska:
	mov magazyn[ebx], 143
	mov utf16[esi], 0179H
	add esi, 2
	jmp dalej

n_z_kreska:
	mov magazyn[ebx], 209
	mov utf16[esi], 0143H
	add esi, 2
	jmp dalej

z_z_kropka:
	mov magazyn[ebx], 175
	mov utf16[esi], 017bH
	add esi, 2
	jmp dalej

s_z_kreska:
	mov magazyn[ebx], 140
	mov utf16[esi], 015AH
	add esi, 2

dalej: 
	inc ebx ; inkrementacja indeksu
	dec ecx
	jnz ptl

; wyświetlenie przekształconego tekstu
wypisanie:
	 mov utf16[esi], 0
	 push 0
	 push OFFSET magazyn
	 push OFFSET magazyn
	 push 0
	 call _MessageBoxA@16

	 push 0
	 push OFFSET utf16
	 push OFFSET utf16
	 push 0
	 call _MessageBoxW@16

	 add esp, 12 ; usuniecie parametrów ze stosu
	 push 0
	 call _ExitProcess@4 ; zakończenie programu

_main ENDP
END
