.686
.model flat

extern _ExitProcess@4  : PROC
extern __write         : PROC 
extern __read          : PROC 

public  _main

.data
tekst     db  10, 'Proszę napisać jakiś tekst i nacisnac Enter:', 10
magazyn   db  80 dup (?), 10
koniec db ?
liczba_znakow dd ?

.code
_main:
	mov  ecx, (OFFSET koniec) - (OFFSET tekst)
	push ecx      
	push OFFSET tekst ; adres tekstu
	push 1            ; ekran
	call __write      ; wyswietlenie
	add  esp, 12

	push 80             ; maksymalna ilosc znakow
	push OFFSET magazyn ; adres magazynu
	push 0              ; klawiatura
	call __read         ; wpisanie
	add  esp, 12

	; Kody ASCII napisanego tekstu zostały wprowadzone
	; do obszaru 'magazyn'. __read() wpisuje do EAX
	; ilość wprowadzonych znaków.

	mov liczba_znakow, eax
	mov ecx, eax ; ecx - licznik obiegów pętli
	mov ebx, 0   ; indeks początkowy

ptl:
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku

	; porównujemy polskie litery(if equal to skaczemy do funkcji)
	cmp dl, 0A5H ; ą
	je zmianaA
	cmp dl, 86H  ; ć
	je zmianaC
	cmp dl, 0A9H ; ę
	je zmianaE
	cmp dl, 88H  ; ł
	je zmianaL
	cmp dl, 0E4H ; ń
	je zmianaN
	cmp dl, 0A2H ; ó
	je zmianaO
	cmp dl, 98H  ; ś
	je zmianaS
	cmp dl, 0ABH ; Ź
	je zmianaZi
	cmp dl, 0BEH ; Ż
	je zmianaZe

	cmp dl, 'a'
	jb  dalej   ; skok, gdy znak nie wymaga zamiany
	cmp dl, 'z'
	ja  dalej   ; skok, gdy znak nie wymaga zamiany

	sub dl, 20H ; zamiana na wielkie litery
	mov magazyn[ebx], dl ; odesłanie znaku do pamięci
	jmp dalej

zmianaA:
	sub dl, 1
	jmp dalej

zmianaC:
	add dl, 9
	jmp dalej

zmianaE:
	sub dl, 1
	jmp dalej

zmianaL:
	add dl, 21
	jmp dalej

zmianaN:
	sub dl, 1
	jmp dalej

zmianaO:
	add dl, 62
	jmp dalej

zmianaS:
	sub dl, 1
	jmp dalej

zmianaZi:
	sub dl, 30
	jmp dalej

zmianaZe:
	sub dl, 1
	jmp dalej


dalej:
	mov magazyn[ebx], dl ; zapis do magazynu
	inc ebx ; inkrementacja ebx
	dec ecx ; odjęcie od licznika pętli
	jnz ptl ; jump if not 0 


	; wyświetlenie przekształconego tekstu
	push liczba_znakow
	push OFFSET magazyn
	push 1
	call __write
	add  esp, 12

	push 0
	call _ExitProcess@4

end
