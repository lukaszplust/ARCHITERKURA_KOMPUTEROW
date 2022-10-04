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
;             dla dw -> mnożnik 2 ->przesyłamy do rejestru ax
;             dla dd -> mnożnik 4 ->przesyłamy do rejestru eax
;             dla dq -> mnożnik 8 ->przesyłamy do rejestru rax
mov ebx, OFFSET znaki; ebx =1
mov eax,0; poczatkowa suma wartosci
mov esi,0;indeks elementu tablicy
mov ecx,5;licznik elementow

sumuj:
add ax,[ebx + 2*esi]; do aktualnej zawartosci ax dodajemy OFFSET ebx(adres efektywny talicy(dla nas to 1)) mnożnik, czyli 2 oznacza rozmiar elementu(16 bitowy)

;dodajemy tablica[i] - >esi = i
;ewnetualne przesunięcie np.[ebx + 2*esi +2] ->oznacza,że zaczynamy sumować od 2, +4 -> sumujemy od 3, +6 ->sumujemy od 4 itp...

add esi,1
loop sumuj

_main endp
end
