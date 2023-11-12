.686
.model flat
public _main

extern _MessageBoxA@16 : proc
extern _MessageBoxW@16 : proc
extern _ExitProcess@4 : proc

.data
tekst	db 41H,6cH,61H,0
		db 'A','l','a',0
		db 'Ala',0
tytul  db 'Tytul',0
tytulW  dw 'T','y','t','u','l',0
tekstW  db 0,41H,0,6cH,0,61H,0,0

bufor       db    50H, 6FH, 0C5H, 82H, 0C4H, 85H, 63H, 7AH, 65H, 6EH, 69H, 61H, 20H
            db    0F0H, 9FH, 9AH, 82H   ; parowóz
            db    20H, 20H, 6BH, 6FH, 6CH, 65H, 6AH, 6FH, 77H, 6FH, 20H
            db    0E2H, 80H, 93H ; półpauza
            db    20H, 61H, 75H, 74H, 6FH, 62H, 75H, 73H, 6FH, 77H, 65H, 20H, 20H
            db    0F0H,  9FH,  9AH,  8CH ; autobus
wynik       dw    48 dup (0),0 

.code
_main PROC

	 mov ecx,offset wynik - offset bufor ; liczba bajtów do interpretacji
	 mov esi,0   ; ustawienie indeksów odczytu i zapisu na 0
	 mov edi,0

ptl: 
	 mov al,bufor[esi]
	 add esi,1		; wskaznik odczytu na nastepny znak
	 cmp al,7fh			 
		 
	;0-7Fh - znak utf8 jednobajtowy
	;80 - BFh - kolejny bajt w znaku 2,3,4 bajtowym
	;C0 - DFh - znak utf8 dwubajtowy
	;E0 - EFh - znak utf8 trzybajtowy
	;F0 - F7h - znak utf8 czterobajtowy

	 ja znak_utf8_wielobajtowy
	 mov ah,0			 ; ustawiamy starszą część 16 bitowego słowa na 0
	 mov wynik[edi],ax   ; wpisujemy znak utf-16 do bufora wynikowego
	 add edi,2			 ; wskaznik zapisu na następy znak utf-16
	 jmp koniec

znak_utf8_wielobajtowy:
	  cmp al,0E0h
	  jb dwubajtowy
	  cmp al,0f0h
	  jb trzybajtowy
	  jmp czterobajtowy

dwubajtowy:
	; 110x xxxx  10xx xxxx   - al, ah
	mov ah,bufor[esi]	;kolejny znak idzie na ah, wczesniejszy - al
	add esi,1   ;przesunięcie indeksu odczytu
	xchg al,ah  ; ax = 110x xxxx  10xx xxxx -> musimy miec poprawną kolejność najpierw wczesniejszy potem pozniejszy
	shl al,2	; ax = 110x xxxx  xxxx xx00 -> przeswam tego al zeby pozbyc się 10
	shl ax,3	; ax = xxxx  xxxx xxx0 0000 -> przesuwam całego ax zeby pozbyc się 110 z ah
	shr ax,5	; ax = 0000 0xxx xxxx xxxx - znak w utf16 -> przesuwam w prawo zeby pozbyć się tych zer i miec 11 cyfr ktore nas interesują w ax
	mov wynik[edi], ax	; zapis znaku do bufora wyjściowego
	add edi,2	;zwiększenie indeksu zapisu
	sub  ecx,1  ; zmniejszenie liczby bajtów do przetwarzania
	jmp koniec

trzybajtowy:
	;     al = (1110 xxxx) 
	; 1110 xxxx 10xx xxxx 10xx xxxx -> tak jest dla 3 bajtowego
	;  (16-23)      ah        al  ----> bity muszą być ustawione w taki sposób
	

	movzx eax,al	; zeruje całego eax i w miejsce al idzie to (1110 xxxx)
	shl eax,16	    ; skoro w al mam najstarsza czesc ktora musi trafic na bity 16-23 to przesuwam to o 16
	mov ah,bufor[esi]   ; do ah wrzucam kolejny bajt
	mov al,bufor[esi+1] ; dp al wrzucam jeszcze kolejny

	add esi,2; zwiekszam iterator bufora bo pobrałem 2 bajty

	; ---------------------------------------------------------------------
	; mozna tez to zrobić tak jak nizej
	;mov ax,word ptr bufor[esi] ; --> wrzucam 2 bajty z bufora do ax
	;ror ax,8 ; ---> przesuwam al w miejsce ah bo mam na odwrot w pamięci
	;xchg al,ah; ---> albo moge zrobić cos takiego to samo co ror ax,8
	; ---------------------------------------------------------------------

	;teraz mam już wszystko w swoich miejsach natomiast mam te prefixy
	;nizej prezentuje się to jak to wyglada

	; 0000 0000 1110 xxxx  10xx xxxx 10xx xxxx 

	shl al,2	; 0000 0000 1110 xxxx  10xx xxxx xxxx xx00
	shl ax,2	; 0000 0000 1110 xxxx  xxxx xxxx xxxx 0000
	shr eax,4	; 0000 0000 0000 1110  xxxx xxxx xxxx xxxx
	;obecnie wszystko juz mam na swoim miejscu w eax

	mov wynik[edi],ax
	add edi,2 ; zwiekszam iterator wyniku
	sub  ecx,2  ; zmniejszenie liczby bajtów do przetwarzania
	jmp koniec


czterobajtowy:

	; 1111 0xxx  10xx xxxx 10xx xxxx  10xx xxxx
	
	; w al znajduje się bajt = 1111 0xxx (pierwszy)
	; do ah wrzucam bajt =  10xx xxxx (drugi)
	mov ah,bufor[esi]
	add esi,1

	xchg ah,al

	; w al znajduje się bajt =  10xx xxxx (drugi)
	; w ah znajduje się bajt = 1111 0xxx (pierwszy)
	; ax = 1111 0xxx 10xx xxxx

	;teraz muszę się pozbyć 10 z al
	shl al,2 ; 1111 0xxx  xxxx xx00
	
	;teraz pozbywam się 11110 z tego ah
	shl ax,5

	;wszystko musi wrocic na swoje miejsce
	shr ax,7 ; 0000 000x xxxx xxxx

	;przesuwamy wyznaczone bity na pozycję 24-16
	shl eax,16 ; 0000 000x xxxx xxxx 0000 0000 0000 0000

	;wrzucam kolejne bajty w dobrej kolejnosci
	mov ah,bufor[esi]
	mov al,bufor[esi+1]

	add esi,2 ;

	;eax = 0000 000x xxxx xxxx 10xx xxxx  10xx xxxx
	
	shl al,2	; 0000 000x xxxx xxxx 10xx xxxx  xxxx xx00
	shl ax,2	; 0000 000x xxxx xxxx xxxx  xxxx xxxx 0000

	; przesuwam zeby pozbyć się zer z najmłodszej czesci
	shr eax,4	; 0000 0000 000x xxxx xxxx xxxx  xxxx xxxx
	
	;eax = 0000 0000 000x xxxx xxxx xxxx  xxxx xxxx
	;21 bitów (x) To jest przypadek, który nie miesci sie na 2 bajtach. Jest to punkt kodowy

	;-----------------------------------------------------------
	;konwersja U+ na dwuznakowy kod UTF-16
	;-----------------------------------------------------------

	;Po odjęci 1000h muszę rozbić te 20 x-ów (powstały z 21 przez odjecie 1000h) na 2 grupy wraz z prefiksami
	;110 110 xxxxx xxxxx  110 111 xxxxx xxxxx 

	push ecx; pushuje ecx na stos bo będę go używał a chce zapamiętać moje obiegi

	sub eax,10000H   ; to odejmowanie wynika ze schematu konwersji!!!

	
	mov ebx,eax ;ebx = 0000 0000 0000 xxxx xxxx xxxx  xxxx xxxx

	shr eax,10		; ax = 0000 00xx xxxx xxxx

	;ustawiam prefix młodszej czesci w cx

	mov cx,110110b
	shl cx,10; dopisuje pozostałe 0 w cx (można też było zapisać mov cx,1101 1000 0000 0000b) na jedno by wyszło :)

	;110 110 xxxxx xxxxx  110 111 xxxxx xxxxx 
	add ax,cx; dodaje ten prefiks z cx do ax (mozna też or zastosować)

	;ax = 0000 00xx xxxx xxxx
	;cx = 1101 1000 0000 0000
	; dlatego też można tu zrobić or (dzięki add ax,cx dopisze się ten prefix)

	mov wynik[edi],ax
	add edi,2

	;starszą część mamy już załatwioną, teraz pora na młodszą (korzystam z kopii z ebx)

	;ebx = 0000 0000 0000 xxxx xxxx xxxx  xxxx xxxx

	; drugi znak utf16

	;bx = xxxx xxxx  xxxx xxxx

	shl bx,6 ;bx = xxxx xxxx xx00 0000
	

	shr bx,6; bx= 0000 00xx xxxx xxxx

	;Mam już interesujące mnie bity, wiec musze dodac prefix
	
	;dodaje prefix (lub mogę zrobić to z maską)

	add bx,1101110000000000b; bx = 1101 1100 0000 0000

	mov wynik[edi],bx
	add edi,2

	pop ecx; przywracam

	sub  ecx,3  ; pobrałem 3 bajty to muszę o tyle zmniejszyć

koniec:
	 sub ecx,1	; pętla rozkazowa loop ma za mały zasięg
	 ;jnz ptl
	 ; albo moge zrobić jnz ptl
	 cmp ecx,0	; wymieniona na rozkaz skoku warunkowego
	 jne ptl
	 ;loop ptl ;---> cała ta petla w kodzie maszynowym generuje wiecej niz 128 bajtow

	;o co tu chodzi XD
	push 1  ; przyciski 
	push OFFSET tytulW
	push OFFSET wynik
	push 0  ; hwnd
	call _MessageBoxW@16

	push 0
	call _ExitProcess@4

_main ENDP
END
