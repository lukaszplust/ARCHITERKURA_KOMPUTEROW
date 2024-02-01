.686 
.model flat 
extern __write : PROC ; (dwa znaki podkreślenia) public _wyswietl32
.code
_wyswietl32 PROC 

push ebp 
mov ebp, esp
sub esp, 12 
; rezerwacja 12 bajtów na stosie (dane lokalne) 
; na stosie będą dostępne komórki 
; o adresach [ebp-12], [ebp-11],..., [ebp-1]


push esi 
push ebx
mov byte PTR [ebp-1], 10 ; znak nowej linii po liczbie 
mov byte PTR [ebp-12], 10 ; znak nowej linii przed liczbą
mov esi, 10 ; indeks 
mov ebx, 10 ; dzielnik równy 10 
mov eax, [ebp+8]; wyświetlana liczba


od_nowa: 
mov edx, 0 ; zerowanie starszej części dzielnej 
div ebx ; dzielenie przez 10, 
; reszta w EDX, iloraz w EAX

add dl, 30H ; zamiana reszty z dzielenia na kod ASCII 
mov [ebp+esi-12], dl ; zapisanie cyfry w kodzie ASCII 
dec esi ; zmniejszenie indeksu 
jz zakoncz ; skok, gdy wygenerowano 10 cyfr 

cmp eax, 0 ; sprawdzenie czy iloraz = 0 
jne od_nowa ; skok, gdy iloraz niezerowy


; wypełnienie pozostałych bajtów spacjami 
wypeln: 
mov byte PTR [ebp+esi-12], 20H ; kod spacji 
dec esi ; zmniejszenie indeksu 
jnz wypeln

zakoncz: ; wyświetlenie cyfr na ekranie 
push dword PTR 12 ; liczba wyświetlanych znaków

lea eax, [ebp-12] ; 

; inna wersja !!!
;mov eax, ebp 
;sub eax, 12 

push eax ; adres wyświetlanego obszaru 
push dword PTR 1 ; numer urządzenia (ekran ma numer 1) 
call __write ; wyświetlenie liczby na ekranie 
add esp, 12 ; usunięcie parametrów ze stosu
pop ebx ; odtworzenie zawartości rejestrów EBX i ESI 
pop esi
add esp, 12 ; zwolnienie obszaru danych lokalnych 
pop ebp 
ret 
_wyswietl32 ENDP
END
