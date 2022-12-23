.686
.model flat
public _szukaj_elem_min

.data
.code
_szukaj_elem_min PROC
push ebp
mov ebp,esp; prolog
push esi
push edi

mov esi,[ebp+8];adres tablicy
mov eax,esi
mov ecx,[ebp+12];ilosc elementow dam to jako ilosc obiegow do sprawdzenia
mov edx,[esi]
ptl:
add esi,4
cmp ecx,1
je koniec
cmp edx,[esi];cmp esi, esi+4
jl wyzej
mov edx,[esi]
mov eax,esi;wrzucenie tej wartosci do eax -> zwracam esi tak naprawde
loop ptl
wyzej:
add ebx,4
loop ptl

koniec:
pop edi
pop esi
pop ebp
ret
_szukaj_elem_min ENDP
END
