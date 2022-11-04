.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data
znaki db 12 dup (?) 

.code

;podprogram liczby oblicza elementy ciągu
liczby PROC

pusha
xor eax,eax; wyzerowanie eax
mov eax,1; pierwszy wyraz ciagu
mov ecx,0; licznik petli

ptl:
	call wyswietl_EAX
	inc ecx
	add eax,ecx; zwiekszamy eax o ecx czyli 1+1(ecx)=2 -> 2+2(ecx)=4 -> 4+3(ecx) -> 7
	cmp ecx,50;50 element ciągu
	jne ptl

popa
ret
liczby ENDP

;podprogram wyswietl_EAX wyswietla liczby heh:DD
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
	;znaki[12] to chyba miejsce dla ENTERA MUSIAŁBYM SIE UPEWNIC ALE W TAKI SPOSOB SMIGA TO CHYBA TAK:DDD
	push dword ptr 12; liczba wyswietlanych znakow
	push dword ptr offset znaki; pchniecie obszaru do wyswietlenia
	push dword ptr 1; to dla ekranu
	call __write
	add esp,12; usuniecie parametrow ze stosu

popa
ret
wyswietl_EAX ENDP


_main PROC
call liczby
push 0
call _ExitProcess@4
_main ENDP
END
