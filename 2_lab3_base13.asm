.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main
.data
obszar db 14 dup (?) ; deklaracja do przechowywania wprowadzonych cyfr
jedenascie dd 13 ; tu zmieniam w zalezności od base tu jest 11 dla 11:D
mnoznik_A dd 10
mnoznik_B dd 11
mnoznik_C dd 12
mnoznik_D dd 13
mnoznik_E dd 14
wynik dd ?
znaki db 12 dup (?) ; deklaracja do przechowywania tworzonych cyfr
czy_minus dd ?
.code

wczytaj_EAX_U2_b13 PROC
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
xor edx,edx;licznik sumy
mov edi,eax
dec edi;przez to tworze sobie potege -2 poniewaz zaczynam od 0 czyli -1
;i enter czyli -2 simple:DD
cmp edi,1
je jeden_znak
dec edi;ciag dalszy do tego wyzej heh

xor eax, eax
mov ebx, OFFSET obszar ; adres obszaru ze znakami
pobieraj_znaki:
mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII
inc ebx ; zwiększenie indeksu
cmp cl,2Bh
je plus
cmp cl,2Dh
je neguj
cmp cl,41h
je A
cmp cl,42h
je B
cmp cl,43h
je znak_C
cmp cl,44h
je D
cmp cl,45h
je E
cmp cl,2Bh
je wroc
cmp cl, 10 ; sprawdzenie czy naciśnięto Enter
je byl_enter ; skok, gdy naciśnięto Enter
sub cl, 30H ; zamiana kodu ASCII na wartość cyfry
movzx ecx, cl ; przechowanie wartości cyfry w ECX
xor eax,eax
add eax, ecx ; dodanie ostatnio odczytanej cyfry
mov esi,edi
normalnie:
mul dword PTR jedenascie
dec esi
cmp esi,0
jne normalnie
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
dec edi
;add eax, ecx ; dodanie ostatnio odczytanej cyfry
jmp pobieraj_znaki ; skok na początek pętli

jedenA:
mov eax,10
jmp koniec
jedenB:
mov eax,11
jmp koniec
jedenC:
mov eax,12
jmp koniec
jedenD:
mov eax,13
jmp koniec
jedenE:
mov eax,14
jmp koniec
;dla jednego znaku
jeden_znak:
mov ebx, OFFSET obszar ; adres obszaru ze znakami
mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII
inc ebx ; zwiększenie indeksu
cmp cl,41h
je jedenA
cmp cl,42h
je jedenB
cmp cl,43h
je jedenC
cmp cl,44h
je jedenD
cmp cl,45h
je jedenE

sub cl, 30H ; zamiana kodu ASCII na wartość cyfry
movzx ecx, cl ; przechowanie wartości cyfry w ECX
;mul dword PTR jedenascie
xor eax,eax
add eax, ecx ; dodanie ostatnio odczytanej cyfry
jmp koniec


plus:
dec edi
jmp pobieraj_znaki
minus:
dec edi
mov czy_minus,1
jmp pobieraj_znaki
E:
cmp edi,1
je mnoz_1_E
cmp edi,0
je mnoz_0_E
;mov edx,eax
;dec edi; musze odjac do potegi
mov esi,edi
;esi -> licznik petli potrzebna do potegowania
;mov eax,10
mov eax,[jedenascie]
dec esi
ptl_E:
mul dword  ptr jedenascie
dec esi
cmp esi,0
jne ptl_E
mul dword ptr mnoznik_E
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
A:
cmp edi,1
je mnoz_1_A
cmp edi,0
je mnoz_0_A
;mov edx,eax
;dec edi; musze odjac do potegi
mov esi,edi
;esi -> licznik petli potrzebna do potegowania
;mov eax,10
mov eax,[jedenascie]
dec esi
ptl_A:
mul dword  ptr jedenascie
dec esi
cmp esi,0
jne ptl_A
mul dword ptr mnoznik_A
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki

znak_C:
cmp edi,1
je mnoz_1_C
cmp edi,0
je mnoz_0_C

;dec edi; musze odjac do potegi
mov esi,edi
mov eax,[jedenascie]
dec esi
ptl_C:
mul dword  ptr jedenascie
dec esi
cmp esi,0
jne ptl_C
mul dword ptr mnoznik_C
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
D:
cmp edi,1
je mnoz_1_D
cmp edi,0
je mnoz_0_D
;mov edx,eax
;dec edi; musze odjac do potegi
mov esi,edi
;esi -> licznik petli potrzebna do potegowania
;mov eax,10
mov eax,[jedenascie]
dec esi
ptl_D:
mul dword  ptr jedenascie
dec esi
cmp esi,0
jne ptl_D
mul dword ptr mnoznik_D
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki

mnoz_1_E:
mov eax,[jedenascie]
mul dword ptr mnoznik_E
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
mnoz_1_D:
mov eax,[jedenascie]
mul dword ptr mnoznik_D
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
;DLA POTEGI LICZBA_base ^1 dla A
mnoz_1_A:
mov eax,[jedenascie]
mul dword ptr mnoznik_A
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki

mnoz_0_D:
mov eax,1
mul dword ptr mnoznik_D
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
;DLA POTEGI LICZBA_base ^0 dla A
mnoz_0_E:
mov eax,1
mul dword ptr mnoznik_E
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
mnoz_0_A:
mov eax,1
mul dword ptr mnoznik_A
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki

;DLA POTEGI LICZBA_base ^1 dla B
mnoz_1:
mov eax,[jedenascie]
mul dword ptr mnoznik_B
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki



mnoz_1_B:
mov eax,[jedenascie]
mul dword ptr mnoznik_B
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki

mnoz_0_B:
mov eax,1
mul dword ptr mnoznik_B
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki

mnoz_1_C:
mov eax,[jedenascie]
mul dword ptr mnoznik_C
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
mnoz_0_C:
mov eax,1
mul dword ptr mnoznik_C
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki
;DLA POTEGI LICZBA_base ^0 dla B
mnoz_0:
mov eax,1
mul dword ptr mnoznik_B
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki


B:
cmp edi,1
je mnoz_1_B
cmp edi,0
je mnoz_0_B
;mov edx,eax
;dec edi; musze odjac do potegi
mov esi,edi
;esi -> licznik petli potrzebna do potegowania
;mov eax,10
mov eax,[jedenascie]
dec esi
ptl_B:
mul dword  ptr jedenascie
dec esi
cmp esi,0
jne ptl_B
mul dword ptr mnoznik_B
dec edi
mov esi,wynik
add esi,eax
mov wynik,esi
xor esi,esi
jmp pobieraj_znaki


wroc:
jmp pobieraj_znaki
neguj:
dec edi
mov czy_minus,1
mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII
inc ebx ; zwiększenie indeksu
cmp cl, 10 ; sprawdzenie czy naciśnięto Enter
je byl_enter ; skok, gdy naciśnięto Enter
cmp cl,41h
je A
sub cl, 30H ; zamiana kodu ASCII na wartość cyfry
movzx ecx, cl ; przechowanie wartości cyfry w ECX
add eax, ecx ; dodanie ostatnio odczytanej cyfry
neg eax
jmp koniec ; skok na początek pętli

neguj_wynik:
neg eax
jmp koniec

byl_enter: ; wartość binarna w EAX
mov eax,wynik
xor esi,esi
mov esi,czy_minus
cmp esi,1
je neguj_wynik

koniec:
pop ebp
pop edi
pop esi
pop ebx
ret
wczytaj_EAX_U2_b13 ENDP

wyswietl_EAX_U2_b13 PROC
pusha
mov esi, 10 ; indeks w tablicy 'znaki'
mov ebx, 13 ; dzielnik równy 11
mov edi,eax

bt edi,31
jc minus
jnc plus

zostawA:
mov byte PTR znaki[esi], 41h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
zostawB:
mov byte PTR znaki[esi], 42h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
zostawC:
mov byte PTR znaki[esi], 43h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
zostawD:
mov byte PTR znaki[esi], 44h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
zostawE:
mov byte PTR znaki[esi], 45h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
zostawF:
mov byte PTR znaki[esi], 46h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja

; konwersja na kod ASCII
konwersja:
mov edx, 0 ; zerowanie starszej czesci dzielnej
div ebx ; dzielenie przez 10, reszta w EDX
; iloraz w EAX
cmp dl,0Ah
je zostawA
cmp dl,0Bh
je zostawB
cmp dl,0Ch
je zostawC
cmp dl,0Dh
je zostawD
cmp dl,0Eh
je zostawE
cmp dl,0Fh
je zostawF

add dl, 30h ; zamiana reszty z dzielenia na kod ASCII
mov znaki[esi], dl ; zapisanie cyfry w kodzie ASCII
dec esi ; zmniejszenie indeks
cmp eax, 0 ; sprawdzenie czy iloraz = 0
jne konwersja
; wypelnienie pozostalych bajtow spacjami
wypeln:
or esi, esi
jz wyswietl ; gdy indeks = 0 
;mov byte PTR znaki[esi], 20h ; kod spacji JAK CHCE BEZ SPACJI TO TAK XDD
dec esi
jmp wypeln

minus:
neg edi
mov eax,edi
mov byte PTR znaki[0], 02Dh
jmp konwersja

plus:
mov eax,edi
mov byte PTR znaki[0], 02Bh
jmp konwersja

wyswietl:
 ; kod nowego wiersza
mov byte PTR znaki[11], 0Ah
push dword PTR 12
push dword PTR OFFSET znaki
push dword PTR 1
call __write
add esp, 12
popa
ret
wyswietl_EAX_U2_b13 ENDP

_main PROC
call wczytaj_EAX_U2_b13
sub eax,10
call wyswietl_EAX_U2_b13
call _ExitProcess@4
_main ENDP
END
