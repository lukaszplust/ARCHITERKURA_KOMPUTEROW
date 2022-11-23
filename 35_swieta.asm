.686
.model flat
public _main
extern __write : PROC
extern __read : PROC
extern _MessageBoxA@16 : PROC
extern _ExitProcess@4 : PROC
.data
znaki db 12 dup (?)
;znaki1 db 0EFh,0A2h,0C2h,0FEh,0
swieta dd 1h,2h,3h,4h,5h,6h,7h,8h,9h,10h,11h,12h
.code
;dynamic_fun PROC
;mov esi,[esp]
;xor ebx,ebx
;mov bl,[esi]
;mov ebx,[esi+4*ebx]
;call ebx
;ret
;dynamic_fun ENDP
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

dodaj PROC
mov esi,[esp]
mov eax,[esi]
add eax,[esi+4]
add dword ptr [esp],8
ret


dodaj ENDP
swieta1 PROC
pusha
dec cl
movzx ecx,cl
mov edx,[ebx + ecx*4]
mov esi,1
ptl:
	bt edx,esi
	jnc dalej
	mov eax,esi
	call wyswietl_EAX
	
dalej:
	inc esi
	cmp esi,32
	jb ptl

popa
ret
swieta1 ENDP
_main PROC
xor eax,eax
mov cl,12
mov ebx,offset swieta
call swieta1
;call dodaj
;dd 5
;dd 7


;ptl:
;	mov dl, byte ptr [eax][esi]
;	cmp dl,0
;	je koniec
;	nop
;koniec:
;nop
;call dynamic_fun
;db 2
;dd 500
;dd 710
;dd 320

 call _ExitProcess@4
_main ENDP
END
