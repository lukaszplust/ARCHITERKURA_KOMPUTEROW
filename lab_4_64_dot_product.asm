public dot_product

.code
dot_product PROC
	push rbp
	mov rbp, rsp
	push rsi
	push rdi
	push rbx

	xor rbx, rbx		; do RBX wpisujemy wynik iloczynu skalarnego
	mov rsi, rcx		; wskaznik na tablice 1
	mov rdi, rdx		; wskaznik na tablice 2
	mov rcx, r8			; iterator programu
	cmp rcx, 0			; jezeli tablice sa puste
	je koniec
	mov r8, 0			; iterator tablic

petla:
	mov rax, [rsi+r8*8]				; element z tablicy 1
	imul qword ptr [rdi+r8*8]		; element z tablicy 2
	inc r8
	add rbx, rax
	loop petla

koniec:
	mov rax, rbx
	pop rbx
	pop rdi
	pop rsi
	pop rbp
	ret
dot_product ENDP
END
