.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main
.data
obszar db 14 dup (?) ; deklaracja do przechowywania wprowadzonych cyfr
jedenascie dd 11 ; tu zmieniam w zalezności od base tu jest 11 dla 11:D
znaki db 12 dup (?) ; deklaracja do przechowywania tworzonych cyfr
.code

wczytaj_EAX_U2_b11 PROC
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
cmp cl,41h
je A
cmp cl,2Dh
je neguj
cmp cl,2Bh
je wroc
cmp cl, 10 ; sprawdzenie czy naciśnięto Enter
je byl_enter ; skok, gdy naciśnięto Enter
sub cl, 30H ; zamiana kodu ASCII na wartość cyfry
movzx ecx, cl ; przechowanie wartości cyfry w ECX
mul dword PTR jedenascie
add eax, ecx ; dodanie ostatnio odczytanej cyfry
jmp pobieraj_znaki ; skok na początek pętli

A:
add eax,120
jmp pobieraj_znaki
wroc:
jmp pobieraj_znaki
neguj:
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
jmp neguj ; skok na początek pętli
byl_enter: ; wartość binarna w EAX
pop ebp
pop edi
pop esi
pop ebx
ret
wczytaj_EAX_U2_b11 ENDP

wyswietl_EAX_U2_b11 PROC
pusha
mov esi, 10 ; indeks w tablicy 'znaki'
mov ebx, 11 ; dzielnik równy 11
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
wyswietl_EAX_U2_b11 ENDP

_main PROC
call wczytaj_EAX_U2_b11
sub eax,10

call wyswietl_EAX_U2_b11
call _ExitProcess@4
_main ENDP
END
