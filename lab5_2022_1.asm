.686
.model flat
public _find_max_range
.data
alfa dd 1
v dd 1
g dd 9.81 
stopnie dd 180
.code
_find_max_range PROC

    push ebp ; zapisanie zawartości EBP na stosie
    mov ebp, esp ; kopiowanie zawartości ESP do EBP

    finit ;inicializacja

    mov eax,dword PTR[ebp +12];alpa 

    mov ebx, 2
    imul ebx;eax*2

    mov dword PTR alfa,eax;alfa =2alfa


    fld dword PTR[ebp+8];v
    fmul dword PTR[ebp+8];v^2
    fdiv dword PTR g;dziele przez g


    fild alfa;1
    fldpi ;wpisuje na wierzcholek stosu pi
    fmul st(0), st(1)


    fild dword PTR stopnie;laduje 180

    fdiv st(1), st(0)
    fstp st (0)
    fsin 
    fmul st(0), st(2)

    pop ebp
    ret
_find_max_range ENDP
END
