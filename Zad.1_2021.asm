.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data
znaki db 12 dup (?) ; deklaracja do przechowywania
; tworzonych cyfr
.code
wyswietl_EAX PROC
pusha
mov esi, 10 ; indeks w tablicy 'znaki'
mov ebx, 10 ; dzielnik równy 10
mov edi,eax
;neg edi -> dla liczby ujemnej
;and edi, 0F0000000h
bt edi,31
jc minus
jnc plus

; konwersja na kod ASCII
konwersja:
mov edx, 0 ; zerowanie starszej czesci dzielnej
div ebx ; dzielenie przez 10, reszta w EDX
; iloraz w EAX

add dl, 30h ; zamiana reszty z dzielenia na kod ASCII
mov znaki[esi], dl ; zapisanie cyfry w kodzie ASCII
dec esi ; zmniejszenie indeks
cmp eax, 0 ; sprawdzenie czy iloraz = 0
jne konwersja
; wypelnienie pozostalych bajtow spacjami
wypeln:
or esi, esi
jz wyswietl ; gdy indeks = 0
mov byte PTR znaki[esi], 20h ; kod spacji
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
wyswietl_EAX ENDP
_main PROC
xor eax, eax
mov eax, 2678
call wyswietl_EAX
push 0
call _ExitProcess@4
_main ENDP
END
