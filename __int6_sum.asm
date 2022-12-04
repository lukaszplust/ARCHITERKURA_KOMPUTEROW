public sum

.code
sum PROC
	push rbp
	mov rbp, rsp
	push rbx
	push rsi
	
	xor rax, rax		; suma z tablicy
	xor rbx, rbx
	; jezeli nie ma argumentow
	cmp rcx, 0
	je koniec
	add rax, rdx
	cmp rcx, 1
	je koniec
	add rax, r8
	cmp rcx, 2
	je koniec
	add rax, r9
	cmp rcx, 3
	je koniec
	sub rcx, 3
	; 16 bajtow - 2 parametry przekazywane
	; 32 bajty - shadow space
	; 48 bajt - piąty argument
	add rax, [rbp+48]
	add rax, [rbp+56]

koniec:
	pop rsi
	pop rbx
	pop rbp
	ret
sum ENDP
END
