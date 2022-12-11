.686
.model flat
extern __read : PROC
extern __write : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC
public _main
.data
;Jaźń(znak smoczka) =(U+1C6A) smoczek -> 3 bajty(0e1h, 0b1h,0aah)
;w petli sprawdzam kazdy ten znak J,a,ź,ń kazdy z nich to 1 bajt czyli 4*1 + 4(ich ilosc) -> 8
;4a->J(2 bajty) a->61(2 bajy) c5 + ba -> ź(2 bajty), c5 + 84 ->ń (2 bajty)
; 0100 1010 -> J, 0110 0001 ->a,{<- to była 1 tabelka}  1100 0101 -> c5, 1011 1010 ->ba, 1100 0101 -> c5{<- to była 2 tabelka}, 1110 0001 ->e1, 1011 0001 ->b1, 1010 1010 ->aa(2 bajty){<- to była 3 tabelka}
znaki db 'Ja',0c5h,0bah,0c5h,84h,0e1h, 0b1h,0aah,0
.code
_main PROC

mov eax,offset znaki
xor ecx,ecx
xor esi,esi

ptl:
	mov dl,byte ptr[eax+esi]
	cmp dl,0
	je koniec
	rol dl,1
	jc jedynka
	inc ecx
	inc esi
	jmp ptl

jedynka:
rol dl,2
jc dwa
inc ecx
add esi,2
jmp ptl

dwa:
inc ecx
add esi,3
jmp ptl

koniec:
add ecx,ecx

call _ExitProcess@4
_main ENDP
END
