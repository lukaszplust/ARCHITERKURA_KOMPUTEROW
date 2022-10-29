.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)
public _main
.data
tekst_pocz db 10, 'Proszę napisać jakiś tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn_inputu db 80 dup (?)
magazyn_outputu db 80 dup (?)
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
; kody ASCII napisanego tekstu zostały wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczbę
; wprowadzonych znaków
mov liczba_znakow, eax
; rejestr ECX pełni rolę licznika obiegów pętli
mov ecx, eax
mov esi,0; indeks inputu
mov edi,0; indeks outputu
mov ebx,0
ptl:
	mov dl, magazyn_inputu[esi]
	inc esi
	cmp dl,'p'
	je sprawdz_czy_i
	jne output

sprawdz_czy_i:
	mov dl, magazyn_inputu[esi]
	inc esi
	cmp dl,'i'
	je sprawdz_czy_e
	jne ptl

sprawdz_czy_e:
	mov dl, magazyn_inputu[esi]
	inc esi
	cmp dl,'e'
	je sprawdz_czy_s

sprawdz_czy_s:
	mov dl, magazyn_inputu[esi]
	inc esi
	cmp dl,'e'
	je sprawdz_czy_spacja

sprawdz_czy_spacja:
	mov dl, magazyn_inputu[esi]
	inc esi
	cmp dl,32
	je licznik
	cmp dl,46
	je kropka
	jne dodajSlowo
licznik:
	inc ebx
	jmp ptl
	
kropka:
	inc ebx
	mov magazyn_outputu[edi],46
	inc edi
	jmp ptl
dodajSlowo:
	mov magazyn_outputu[edi],'p'
	inc edi
	mov magazyn_outputu[edi],'i'
	inc edi
	mov magazyn_outputu[edi],'e'
	inc edi
	mov magazyn_outputu[edi],'s'
	inc edi
	mov magazyn_outputu[edi],dl
	inc edi
	jmp ptl

output:
	mov magazyn_outputu[edi],dl
	inc edi
	dec ecx
	jne ptl
	cmp ebx,2
	je licznik_wypisz
	jmp koniec



licznik_wypisz:
	mov magazyn_outputu[edi],50
	inc edi
	jmp koniec


koniec:
	push edi
	push OFFSET magazyn_outputu
	push 1
	call __write ; wyświetlenie przekształconego tekstu
	add esp, 12 ; usuniecie parametrów ze stosu
	push 0
	call _ExitProcess@4 ; zakończenie programu
_main ENDP
END
