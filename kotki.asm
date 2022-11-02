.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)
public _main
.data
tekst_pocz db 10, 'Proszę napisać jakiś tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
magazyn_message dw 80 dup (?)
magazyn_inputu dw 80 dup (?)
magazyn_outputu dw 80 dup (?)
liczba_znakow dd ?
tytul dw 'z','a','d',0
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
; kody ASCII napisanego tekstu zostały wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczbę
; wprowadzonych znaków
mov liczba_znakow, eax
; rejestr ECX pełni rolę licznika obiegów pętli
	mov ecx, eax
	 mov ebx, 0 
	 mov esi, 0 
glowna: 
	 mov dl,magazyn[ebx] ; pobranie kolejnego znaku
	 inc ebx
	 mov magazyn_inputu[esi], dx; w dx znajduje się liczba w hex
	 add esi, 2
	 loop glowna
;nowe
mov edi,0
mov ebx, 0 
mov esi, 0 
mov edx,0
mov eax,0

ptl:
	mov dx,magazyn_inputu[edi]
	add edi,2
	cmp dx,107
	je szukajO
	loop ptl

szukajO:
	mov dx,magazyn_inputu[edi]
	add edi,2
	cmp dx,111
	je szukajt
	jne powrot1
szukajt:
	mov dx,magazyn_inputu[edi]
	add edi,2
	cmp dx,116
	je licznik
	jne powrot1

powrot1:
	sub edi,2
	jmp ptl
powrot2:
	sub edi,3
	jmp ptl

licznik:
	inc ebx
	cmp ebx,2
	je kotki
	jne ptl


kotki:
	mov magazyn_outputu[eax],0D83Dh
	add eax,2
	mov magazyn_outputu[eax],0DE3Ah
	add eax,2
	mov magazyn_outputu[eax],0D83Dh
	add eax,2
	mov magazyn_outputu[eax],0DE3Ah
	add eax,2
	jmp koniec
koniec:
	push 0 
	push offset tytul
	push offset magazyn_outputu
	push 0 
	call _MessageBoxW@16
	push 0 
	call _ExitProcess@4 ; zakończenie programu
_main ENDP
END
