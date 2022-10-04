.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public _main
.data
tytul dw 'T','y','t','u','l', 0

magazyn_input dw 'a','1',' ','b','2',' ','c','3'

magazyn_output dw 21 dup (?)
.code
_main proc
	mov ecx, 10 ; licznik glownej petli, ilosc znakow w magazyn_inputu
	mov edi, 0 ; indeks tekstu output
	mov esi, 0 ; ilosc elementow w wyrazie
	mov edx, 0 ; wyzerowanie edx dla naszego inputu


; idziemy od ostatniego wyrazu do przodu i wrzucamy na stos
	glownaPetla: mov dx, magazyn_input[2*ecx-2]
	cmp dx, 32 ; 32 to spacja w DEC
	je zeStosu
	jne naStos


; wrzucamy na stos dana literke
	naStos: push dx ;dajemy na stos dx
	inc esi; zwiekszam ilosc literek
	cmp ecx, 1; porownuje czy ecx jest rowny 1 
	je zeStosu; jesli ecx jest równy 1 to zdejmuje słowo ze stosu
	jne petla;jesli nie to lecimy po nową literke:D


; zdejmujemy ze stosu cale slowo
	zeStosu: pop bx; zdjemujemy literki w odwrotnej kolejnosci
	mov magazyn_output[2*edi], bx; przesyłamy nowy wynik do magazynu
	inc edi; zwiekszamy indeks literek outputu
	dec esi;zmniejszamy ilosc elemenow w wyrazie
	jz dodajSpacje;jesli ilosc elementow w wyrazie jest 0 to dodajemy spacje
	jnz zeStosu


; dodajemy spacje miedzy slowami
dodajSpacje: mov magazyn_output[2*edi], 32; dodanie spacji
inc edi; inkrementuje indeks outputu bo dodałem spacje
jmp petla; zapetlam bezwarunkowo


; zapetlamy wszystko (ecx-=1 jmp glownaPetla)
petla: loop glownaPetla


; dodanie 0 na koniec stringa
mov magazyn_output[2*edi-1], 0; dodajemy 0 na koniec stringa(klasycznie np. napis db 1,2,3,0)


; wyswietlanie sie outputu
push 0
push OFFSET tytul
push OFFSET magazyn_output
push 0
call _MessageBoxW@16

; zakonczenie programu
push 0
call _ExitProcess@4
_main endp
end
