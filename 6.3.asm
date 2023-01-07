.386
rozkazy SEGMENT use16
        ASSUME CS:rozkazy

    obsluga_zegara PROC
        ; przechowanie uzywanych rejestrow
        push ax
        push bx
        push es

        ; wpisanie adresu pamieci ekranu do rejestru ES
        ; pamiec ekranu dla trybu tekstowego zaczyna sie od adresu B8000H
        ; jednak do rejestru ES wpisujemy wartosc B800H bo w trakcie obliczenia adresu procesor
        ; kazdorazowo mnozy zawartosc rejestru ES przez 16
        mov ax, 0B800h
        mov es, ax

        ; zmienna licznik zawiera adres biezacy w pamieci ekranu
        mov bx, cs:licznik
        mov byte ptr es:[bx], '*'
        mov byte ptr es:[bx+1], 00010110B   ; kolor


        add bx, 160; w bx znajduje sie wskaznik na odpowiednia kolumne i wiersz
        mov ax, cs:licznik_wierszy;w pierwszym przejsciu ax = 1,licznik wierszy=2+n itp
        cmp ax, 25;licznik tych wierszy w dol
        jb dalej;jezeli mniej niz 25 to wpisuj w dol


        ; zwiększenie o 2 adresu bieżącego w pamięci ekranu
        add cs:plus, word ptr 2
        mov bx, cs:plus;bx=2,bx=4
        mov cs:licznik_wierszy, word ptr 1;licznik wierszy 1
        jmp sprawdz

    ;wpisuj w dol
    dalej:
        inc ax;zwiekszam ax 
        mov cs:licznik_wierszy, ax;zwiekszam licznik wierszy
    sprawdz:
        cmp bx, 4000
        jb wysw_dalej
        mov bx, 0                           ; wyzerowanie adresu biezacego gdy caly ekran zapisany

    wysw_dalej:
        mov cs:licznik, bx                  ; adres biezacy w liczniku

        pop es
        pop bx
        pop ax

        jmp dword ptr cs:wektor8
        ; wyswietlanie poczawszy od 0 wiersza
        licznik dw 0
        wektor8 dd ?
        plus dw 0
        licznik_wierszy dw 1
    obsluga_zegara ENDP
    ; program glowny - instalacja i deinstalacja procedury obslugi przerwan

    ; ustalenie strony nr 0 dla trybu tekstowego
    zacznij:
        mov al, 0
        mov ah, 5
        int 10

        mov ax, 0
        mov ds, ax              ; zerowanie rejestru DS
        ; odczytanie zawartosci wektora nr 8 i zapisanie go w zmiennej wektor8
        mov eax, ds:[32]        ; adres fizyczny 0*16+32 = 32
        mov cs:wektor8, eax
        ; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
        mov ax, SEG obsluga_zegara
        mov bx, offset obsluga_zegara

        cli                     ; zablokowanie przerwan
        mov ds:[32], bx
        mov ds:[34], ax         ; odblokowanie przerwan
        sti

    ; oczekiwanie na nacisniecie klawisza 'x'
    aktywne_oczekiwanie:
        mov ah, 1
        ; funkcja INT 16H BIOSu ustawia ZF=1 jesli nacisnieto jakis klawisz
        int 16h
        jz aktywne_oczekiwanie

        mov ah, 0
        int 16h
        cmp al, 'x'
        jne aktywne_oczekiwanie
        ; deinstalacja procedury obslugi przerwania zegarowego
        mov eax, cs:wektor8
        cli
        mov ds:[32], eax
        sti
        ; zakonczenie programu
        mov al, 0
        mov ah, 4Ch
        int 21h
rozkazy ENDS

nasz_stos SEGMENT stack
    db 128 dup (?)
nasz_stos ENDS

END zacznij
