.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)

.data

tekst_pocz db 10, 'Proszę napisać jakiś tekst '
db 'i nacisnac Enter', 10
koniec_t db ?

tytul dw 'z','a','d',' ','l','a','b',0
magazyn db 80 dup (?)
magazyn_inputu dw 80 dup (?)
magazyn_outputu dw 80 dup (?)
magazyn_tymczasowy db 80 dup (?)
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
	 mov ecx,eax
	 mov esi,0; indeks wyrazu
	 mov edx,0;indeks inputu
	 mov edi,0;indeks outputu
	 mov ebx,0;indeks wejscia

glowna:
	 mov dl,magazyn[ebx]
	 inc ebx
	 mov magazyn_inputu[esi],dx
	 add esi,2
	 loop glowna
mov ecx,eax
;wyzerowanie indeksow znowu
mov eax,0; licznik nowych wyrazow
mov esi,0; indeks wyrazu
mov edi,0;indeks inputu
mov edx,0;tego uzywam do porownan
mov ebx,0;licznik polskich znakow

ptl:
	mov dx,magazyn_inputu[edi]
	add edi,2

	cmp dx,0A5h
	je a
	cmp dx,86h
	je c_kreska
	cmp dx,0A9h
	je e
	cmp dx,88h
	je l
	cmp dx,0E4h
	je n
	cmp dx,0A2h
	je o
	cmp dx,98h
	je s
	cmp dx,0ABh
	je z_kreska
	cmp dx,0BEh
	je z_kropka

	cmp dx,20h
	je spacja
	loop ptl
dalej:
	jmp dalejproc
spacja:
	push ebx
	push eax
	inc eax
	mov ebx,0
	loop ptl
a:
	inc ebx
	loop ptl
c_kreska:
	inc ebx
	loop ptl
e:	
	inc ebx
	loop ptl
l:
	inc ebx
	loop ptl
n:
	inc ebx
	loop ptl
o:
	inc ebx
	loop ptl
s:
	inc ebx
	loop ptl
z_kreska:
	inc ebx
	loop ptl
z_kropka:
	inc ebx
	loop ptl



nizej:
	mov edx,0
	mov edx,[esp+12]
	cmp edx,[esp+20]
	ja wyzej2
	jb nizej2
	loop nizej
wypisz_1:
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],31h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
wypisz_0:
mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],30h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
nizej2:
	mov edx,0
	mov edx,[esp+20]
	cmp edx,[esp+28]
	ja wypisz_1
	jb wypisz_0
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],30h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc


wypisz_2:
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],32h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
	
wyzej2:
	cmp edx,[esp+28]
	ja wypisz_2
	;jb nizej4
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],31h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
wyzej:
	cmp edx,[esp+20]
	ja wyzej1
	jb nizej1
	loop wyzej

wyzej3:
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],33h;git dla 4
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
nizej3:
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],30h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
wyzej1:
cmp edx,[esp+28]
ja wyzej3
jb nizej3

nizej1:
	mov edi,0
	mov magazyn_outputu[edi],3Eh
	add edi,2
	mov magazyn_outputu[edi],30h
	add edi,2
	mov magazyn_outputu[edi],0D83Dh
	add edi,2
	mov magazyn_outputu[edi],0DC38h
	add edi,2
	jmp koniecproc
dalejproc:
	mov edx,0
	push ebx
	push eax
	
	mov edx,[esp+4]
	cmp edx,[esp+12]
	ja wyzej
	jb nizej

	jmp koniecproc

koniecproc:
	push 0
	push offset tytul
	push offset magazyn_outputu
	push 0
	call _MessageBoxW@16
_main ENDP

END
