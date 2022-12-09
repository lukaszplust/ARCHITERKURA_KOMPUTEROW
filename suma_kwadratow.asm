public suma_kwadratow

.code
suma_kwadratow PROC
	push rbp
	mov rbp, rsp
	push rsi
	push rbx
	push rdi

	xor rbx, rbx		; suma kwadratow
	mov rsi, rcx		; rsi -> a
	mov rcx, rdx		; rcx -> b
	cmp rcx, 0
	je koniec

; a^2
	mov rax, rsi
	imul rax			; kwadrat tego co jest w RAX
	add rbx, rax
; b^2
	xor rax,rax
	mov rax,rcx
	imul rax
	add rbx,rax
	
koniec:
	mov rax, rbx		; zwrocenie sumy
	pop rdi
	pop rbx
	pop rsi
	pop rbp
	ret
suma_kwadratow ENDP
END
