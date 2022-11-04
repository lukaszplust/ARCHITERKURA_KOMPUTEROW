.686
.model flat
public _main
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
.data
znaki db 12 dup (?)
obszar db 12 dup (?) ; deklaracja do przechowywania wprowadzonych cyfr
dziesiec dd 10 ; mnożnik
.code


wyswietl_EAX PROC
pusha

mov esi,10;indeks znaki
mov ebx,10; dzielnik = 10

konwersja:
	mov edx,0; zerowanie starszej czesci dzielnej
	div ebx; dziele eax przez ebx(10) -> reszta edx iloraz eax

	add dl,30h; zamieniam reszte z edx np. EDX = (0000 0001) + 30h = (0000 0031) -> jest to 1 w hex
	mov znaki[esi],dl ; przesyłam moj wynik do zarezerwowanego miejsca przez znaki w znaki[esi] dla esi=10,esi=9 itp w dol
	dec esi
	cmp eax,0; jesli iloraz 0 to koniec
	jne konwersja

;wypelniam zerami miejsca w ktorych nie mam tych reszt z dzielenia przez mov znaki[esi],dl 
wypelnij:
	or esi,esi
	jz koniec; jesli esi=0
	mov byte ptr znaki[esi],20h; przesyłam w niezapelnione miejsca przez reszte z dzielenia spacje
	dec esi
	jmp wypelnij

koniec:
	mov byte ptr znaki[0],0Ah; znak nowego wiersza dla tablicy[0], zeby pod soba było widac kolejne liczby ciagu
	mov byte ptr znaki[11],0Ah; dla ostatniego miejsca w tablicy rowniez zeby było widac przejscie do nowej lini dla nowego znaku
	;znaki[12] to chyba miejsce dla ENTERA MUSIAŁBYM SIE UPEWNIC ALE W TAKI SPOSOB SMIGA TO CHYBA TAK:DD
	push dword ptr 12; liczba wyswietlanych znakow
	push dword ptr offset znaki; pchniecie obszaru do wyswietlenia
	push dword ptr 1; to dla ekranu
	call __write
	add esp,12; usuniecie parametrow ze stosu

popa
ret
wyswietl_EAX ENDP

wczytaj_do_EAX PROC
push ebx
push esi
push edi
push ebp
push dword PTR 12 ; max ilosc znakow wczytywanej liczby
push dword PTR OFFSET obszar ; adres obszaru pamięci
push dword PTR 0 ; numer urządzenia (0 dla klawiatury)
call __read ; odczytywanie znaków z klawiatury
add esp, 12 ; usunięcie parametrów ze stosu
; biezaca wartość przekształcanej liczby przechowywana jest
; w rejestrze EAX; przyjmujemy 0 jako wartość początkową
xor eax, eax
mov ebx, OFFSET obszar ; adres obszaru ze znakami
pobieraj_znaki:
mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII
inc ebx ; zwiększenie indeksu
cmp cl, 10 ; sprawdzenie czy naciśnięto Enter
je byl_enter ; skok, gdy naciśnięto Enter
sub cl, 30H ; zamiana kodu ASCII na wartość cyfry
movzx ecx, cl ; przechowanie wartości cyfry w ECX
; mnożenie wcześniej obliczonej wartości razy 10
mul dword PTR dziesiec
add eax, ecx ; dodanie ostatnio odczytanej cyfry
jmp pobieraj_znaki ; skok na początek pętli
byl_enter: ; wartość binarna w EAX
pop ebp
pop edi
pop esi
pop ebx
ret
wczytaj_do_EAX ENDP

_main PROC
call wczytaj_do_EAX
mul eax
call wyswietl_EAX
push 0
call _ExitProcess@4
_main ENDP
END
