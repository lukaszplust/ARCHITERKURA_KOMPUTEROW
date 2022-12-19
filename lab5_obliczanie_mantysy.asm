.686
.model flat
extern __write : PROC
extern _ExitProcess@4 : PROC
.data
liczba db 127
znaki db 12 dup (?) 
.code
wysw_zm PROC
push ebx
push esi
push edi
push ebp

xor ebx,ebx
mov edi,30;numer bitu zaczynam od 30 bo 31 to bit znaku a wiemy ze dodatni
mov ecx,8;obieg petli
ptl:
	bt eax,edi
	jc wliczaj
	dec edi
	loop ptl
	jmp odejmij_127
wliczaj:
	;2^7
	cmp ecx,8
	je dodaj8
	;2^6
	cmp ecx,7
	je dodaj7
	;2^5
	cmp ecx,6
	je dodaj6
	;2^4
	cmp ecx,5
	je dodaj5
	;2^3
	cmp ecx,4
	je dodaj4
	;2^2
	cmp ecx,3
	je dodaj3
	;2^1
	cmp ecx,2
	je dodaj2
	;2^0
	cmp ecx,1
	je dodaj1
	jmp ptl
;dodawanie
dodaj8:
add ebx,128
dec ecx
dec edi
jmp ptl
dodaj7:
add ebx,64
dec ecx
dec edi
jmp ptl
dodaj6:
add ebx,32
dec ecx
dec edi
jmp ptl
dodaj5:
add ebx,16
dec ecx
dec edi
jmp ptl
dodaj4:
add ebx,8
dec ecx
dec edi
jmp ptl
dodaj3:
add ebx,4
dec ecx
dec edi
jmp ptl
dodaj2:
add ebx,2
dec ecx
dec edi
jmp ptl
dodaj1:
add ebx,1
dec ecx
dec edi
jmp ptl
;dla mantysy
dodaj8m:
add ebx,128
dec ecx
inc edi
jmp ptl_mantysy
dodaj7m:
add ebx,64
dec ecx
inc edi
jmp ptl_mantysy
dodaj6m:
add ebx,32
dec ecx
inc edi
jmp ptl_mantysy
dodaj5m:
add ebx,16
dec ecx
inc edi
jmp ptl_mantysy
dodaj4m:
add ebx,8
dec ecx
inc edi
jmp ptl_mantysy
dodaj3m:
add ebx,4
dec ecx
inc edi
jmp ptl_mantysy
dodaj2m:
add ebx,2
dec ecx
inc edi
jmp ptl_mantysy
dodaj1m:
add ebx,1
dec ecx
inc edi
jmp ptl_mantysy

odejmij_127:
mov edx,dword ptr [liczba]
sub ebx,edx
jmp mantysa

mantysa:
	bts eax,23;niejawna jedynka czy jak sie to tam nazywa:D
	sub edi,ebx
	inc edi
mov ecx,ebx
xor ebx,ebx
inc ecx
ptl_mantysy:
	cmp ecx,0
	je dodaj_do_eax
	bt eax,edi
	jc sumuj
	inc edi
	loop ptl_mantysy

sumuj:	
	cmp ecx,8
	je dodaj1m
	cmp ecx,7
	je dodaj2m
	cmp ecx,6
	je dodaj3m
	cmp ecx,5
	je dodaj4m
	cmp ecx,4
	je dodaj5m
	cmp ecx,3
	je dodaj6m
	cmp ecx,2
	je dodaj7m
	cmp ecx,1
	je dodaj8m
	
dodaj_do_eax:
	mov eax,ebx
pop ebp
pop edi
pop esi
pop ebx
ret
wysw_zm ENDP

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
	;mov byte ptr znaki[esi],20h; przesyłam w niezapelnione miejsca przez reszte z dzielenia spacje
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
_main PROC
mov eax,43670000h
call wysw_zm
call wyswietl_EAX
_main ENDP
END
