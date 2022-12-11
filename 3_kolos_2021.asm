.686

.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
public _main


.data
   tytul dw 'z',0
   znak dw 0D83Dh,0DC15h,0
   s db 'y'

.code 

_main PROC
xor eax,eax
xor ebx,ebx
lea esi,znak
mov dl,[esi+2]
mov cl,dl
mov bl,[esi+3]
mov dl,bl
xchg cl,dl
mov [esi+2],cl
mov [esi+3],dl

mov dl,[esi+0]
mov cl,dl
mov bl,[esi+1]
mov dl,bl

xchg cl,dl
mov [esi+0],cl
mov [esi+1],dl



push 0
push offset tytul
push offset znak
push 0
call _MessageBoxW@16
push 0
_main ENDP
   

END
