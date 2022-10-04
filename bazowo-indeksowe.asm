.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public _main
.data
znaki dw 1,2,3,4,5,6,0
.code
_main proc
;BARDZO WAŻNE dla db -> mnożnik 1 ->przesyłamy do rejestru np.al
;             dla dw -> mnożnik 2 ->przesyłamy do rejestru
;             dla dd -> mnożnik 4 ->przesyłamy do rejestru
;             dla dq -> mnożnik 8 ->przesyłamy do rejestru
mov ebx, OFFSET znaki; ebx =1
mov eax,0; poczatkowa suma wartosci
mov esi,0;indeks elementu tablicy
mov ecx,5;licznik elementow

sumuj:
add ax,[ebx + 2*esi]; do aktualnej zawartosci ax dodajemy OFFSET ebx(adres efektywny talicy(dla nas to 1)) mnożnik, czyli 2 oznacza rozmiar elementu(16 bitowy)
;dodajemy tablica[i] - >esi = i
add esi,1
loop sumuj

_main endp
end
