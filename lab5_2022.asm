.686
.XMM
.model flat
public _mul_at_once
.data
.code
_mul_at_once PROC
    push ebp 
    mov ebp, esp 

    PMULLD xmm0,xmm1

    pop ebp
    ret
_mul_at_once ENDP

END
