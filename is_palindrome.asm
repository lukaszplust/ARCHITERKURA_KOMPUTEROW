.686
.model flat
public _isPalindrom
.data
.code
_isPalindrom PROC
push ebp 
mov ebp,esp 
push ebx
push esi

mov edi,[ebp+8];edi -> k, edi + 1 ->a, edi + 2 -> j, edi + 3 -> a, edi + 4 ->k
mov esi, [ebp+12]; liczba znakow
cmp esi,0
je koniec_1
cmp esi,1
je koniec_1

mov ecx,esi
;edi -> 1 znak, edi+esi -> ostatni
mov ebx,0
mov bl,[edi+esi-1]
;mov ebx,[edi+esi-1]; ostatni znak
mov edx,0
mov dl,[edi]
;edi ->pierwszy, ebx -> ostatni
cmp edx,ebx;1 wyraz z ostatnim
jne koniec_0

;
sub esi,2
add edi,1
push esi
push edi
call _isPalindrom
;edi + 1,liczba znakow-2
pop edi
pop esi
jmp goEnd

koniec_0:
mov eax,0
jmp goEnd

koniec_1:
mov eax,1
jmp goEnd

goEnd:
pop esi
pop ebx
pop ebp
ret 
_isPalindrom ENDP
 END
