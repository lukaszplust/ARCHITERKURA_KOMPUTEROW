.386
rozkazy SEGMENT use16
ASSUME CS:rozkazy
obsluga_zegara PROC
; przechowanie używanych rejestrów
push ax
push bx
push es
push dx;na potrzebe zegara

; wpisanie adresu pamięci ekranu do rejestru ES - pamięć
; ekranu dla trybu tekstowego zaczyna się od adresu B8000H,
; jednak do rejestru ES wpisujemy wartość B800H,
; bo w trakcie obliczenia adresu procesor każdorazowo mnoży
; zawartość rejestru ES przez 16
mov ax, 0B800h ;adres pamięci ekranu
mov es, ax


mov dx, cs:zegar
cmp dx,18
je dalej
inc dx
mov cs:zegar,dx
jmp skip


dalej:
	mov dx,0
	mov cs:zegar,dx
	mov bx, cs:licznik; zmienna 'licznik' zawiera adres bieżący w pamięci ekranu
	mov byte PTR es:[bx], '*' ; kod ASCII
	mov byte PTR es:[bx+1], 00010110B ; kolor
	add bx,2; zwiększenie o 2 adresu bieżącego w pamięci ekranu
	cmp bx,4000; sprawdzenie czy adres bieżący osiągnął koniec pamięci ekranu
	jb wysw_dalej ; skok gdy nie koniec ekranu
	mov bx, 0; wyzerowanie adresu bieżącego, gdy cały ekran zapisany

;zapisanie adresu bieżącego do zmiennej 'licznik'
wysw_dalej:
	mov cs:licznik,bx

; odtworzenie rejestrów
skip:
pop dx
pop es
pop bx
pop ax
jmp dword PTR cs:wektor8; skok do oryginalnej procedury obsługi przerwania zegarowego


; dane programu ze względu na specyfikę obsługi przerwań
; umieszczone są w segmencie kodu
zegar dw 18
licznik dw 320 ; wyświetlanie począwszy od 2. wiersza
wektor8 dd ?
obsluga_zegara ENDP



;============================================================
; program główny - instalacja i deinstalacja procedury
; obsługi przerwań
; ustalenie strony nr 0 dla trybu tekstowego
zacznij:
mov al, 0
mov ah, 5
int 10
mov ax, 0
mov ds,ax ; zerowanie rejestru DS

; odczytanie zawartości wektora nr 8 i zapisanie go
; w zmiennej 'wektor8' (wektor nr 8 zajmuje w pamięci 4 bajty
; począwszy od adresu fizycznego 8 * 4 = 32)

mov eax,ds:[32] ; adres fizyczny 0*16 + 32 = 32
mov cs:wektor8, eax;eax -> wartosc wektora nr.8

; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_zegara ; część segmentowa adresu
mov bx, OFFSET obsluga_zegara ; offset adresu
cli ; zablokowanie przerwań

; zapisanie adresu procedury do wektora nr 8
mov ds:[32], bx ; OFFSET
mov ds:[34], ax ; cz. segmentowa
sti ;odblokowanie przerwań



;SPRAWDZENIE Z X
; oczekiwanie na naciśnięcie klawisza 'x'
aktywne_oczekiwanie:
mov ah,1
int 16H
; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 jeśli
; naciśnięto jakiś klawisz
jz aktywne_oczekiwanie
; odczytanie kodu ASCII naciśniętego klawisza (INT 16H, AH=0)
; do rejestru AL
mov ah, 0
int 16H
cmp al, 'x' ; porównanie z kodem litery 'x'
jne aktywne_oczekiwanie ; skok, gdy inny znak
; deinstalacja procedury obsługi przerwania zegarowego
; odtworzenie oryginalnej zawartości wektora nr 8
mov eax, cs:wektor8
cli
mov ds:[32], eax ; przesłanie wartości oryginalnej
; do wektora 8 w tablicy wektorów
; przerwań
sti
; zakończenie programu
mov al, 0
mov ah, 4CH
int 21H
rozkazy ENDS
nasz_stos SEGMENT stack
db 128 dup (?)
nasz_stos ENDS
END zacznij
