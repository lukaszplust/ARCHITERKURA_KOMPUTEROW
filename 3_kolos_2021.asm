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
mov dl,[esi+0]
mov bl,[esi+3]
xchg dl,bl
mov [esi+0],dl
mov [esi+3],bl

mov dl,[esi+1]
mov bl,[esi+2]
xchg dl,bl
mov [esi+1],dl
mov [esi+2],bl



push 0
push offset tytul
push offset znak
push 0
call _MessageBoxW@16
push 0
_main ENDP
   

END
