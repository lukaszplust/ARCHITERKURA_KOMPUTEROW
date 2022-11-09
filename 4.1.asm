.model flat
public _szukaj4_max
.code
_szukaj4_max PROC
push ebp
mov ebp, esp

mov eax, [ebp+8]
cmp eax, [ebp+12]
jge p_wieksza

mov eax, [ebp+12]
cmp eax, [ebp+16]
jge x_wieksza

mov eax, [ebp+16]
cmp eax, [ebp+20]
jge zakoncz
jmp wpisz_z
wpisz_z:
mov eax, [ebp+20]
zakoncz:
pop ebp
ret
p_wieksza:
cmp eax, [ebp+16]
jge sprawdz_z
mov eax, [ebp+16]
cmp eax, [ebp+20]
jge zakoncz
jmp wpisz_z
x_wieksza:
cmp eax, [ebp+20]
jge zakoncz
jmp wpisz_z
sprawdz_z:
cmp eax, [ebp+20]
jge zakoncz
jmp wpisz_z
_szukaj4_max ENDP
END
