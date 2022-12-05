public sum_of_squares

.code
sum_of_squares PROC
	push rbp
	mov rbp, rsp
	push rsi
	push rbx
	push rdi

	xor rdi, rdi
	xor rbx, rbx		; suma kwadratow
	mov rsi, rcx		; wskaznik na tablice
	mov rcx, rdx		; licznik iteracji
	cmp rcx, 0
	je koniec

petla:
	mov rax, [rsi+rdi*8]
	inc rdi
	imul rax			; kwadrat tego co jest w RAX
	add rbx, rax
	loop petla

koniec:
	mov rax, rbx		; zwrocenie sumy
	pop rdi
	pop rbx
	pop rsi
	pop rbp
	ret
sum_of_squares ENDP
END
