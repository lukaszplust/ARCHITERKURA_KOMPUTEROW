.686
.model flat
extern __write : PROC
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data
obszar db 12 dup (?)
dziesiec dd 10
znaki db 12 dup (?) ; deklaracja do przechowywania
; tworzonych cyfr
.code
wczytaj_EAX_U2_b14 PROC
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
wczytaj_EAX_U2_b14 ENDP
wyswietl_EAX_U2_b14 PROC
pusha
mov esi, 10 ; indeks w tablicy 'znaki'
mov ebx, 14 ; dzielnik równy 10
mov edi,eax
;neg edi -> dla liczby ujemnej
;and edi, 0F0000000h
bt edi,31
jc minus
jnc plus

A:
mov byte PTR znaki[esi], 41h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
B:
mov byte PTR znaki[esi], 42h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja

znakC:
mov byte PTR znaki[esi], 43h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
D:
mov byte PTR znaki[esi], 44h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
E:
mov byte PTR znaki[esi], 45h
dec esi
cmp eax, 0 ; sprawdzenie czy iloraz = 0
je wyswietl
jne konwersja
F:
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
je A
cmp dl,0Bh
je B
cmp dl,0Ch
je znakC
cmp dl,0Dh
je D
cmp dl,0Eh
je E
cmp dl,0Fh
je F

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
wyswietl_EAX_U2_b14 ENDP
_main PROC
xor eax, eax
call wczytaj_EAX_U2_b14
sub eax,10
call wyswietl_EAX_U2_b14
push 0
call _ExitProcess@4
_main ENDP
END
