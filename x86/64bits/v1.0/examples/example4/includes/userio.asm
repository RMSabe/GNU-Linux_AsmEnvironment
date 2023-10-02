;User I/O related functions

;FUNCTION: add line break at standard output
;args (push order): return addr
_printnewline:
	mov rsi, qword _textbuf
	mov [rsi], byte 0xa

	mov rdx, qword 1
	mov rdi, qword 1
	mov rax, qword 1
	syscall

	pop qword rbx
	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: print a string at standard output
;args (push order): input string addr, return addr
_printtext:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	add rdi, rcx
	pop qword rbx
	mov [rdi], qword rbx
	add rcx, qword 8
	mov [rsi], qword rcx

	pop qword rbx
	mov rsi, rbx
	mov rdi, rsi
	xor rdx, rdx

	_printtext_getlen:
	mov al, byte [rdi]
	cmp al, byte 0
	je _printtext_gotlen
	inc rdi
	inc rdx
	jmp _printtext_getlen
	_printtext_gotlen:

	mov rdi, qword 1
	mov rax, qword 1
	syscall

	_printtext_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: print a string at standard output with a line break at the end
;args (push order): input string addr, return addr
_printtextln:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	add rdi, rcx
	pop qword rbx
	mov [rdi], qword rbx
	add rcx, qword 8
	mov [rsi], qword rcx

	push qword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	push qword $
	jmp _printnewline
	times RETURN_MARGIN_CALLER nop

	_printtextln_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, qword rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: wait user input, load input text into buffer
;args (push order): output buffer addr, output buffer length, return addr
_scantext:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	add rdi, rcx
	pop qword rbx
	mov [rdi], qword rbx
	add rcx, qword 8
	mov [rsi], qword rcx

	pop qword rdx

	pop qword rbx
	mov rsi, rbx

	mov rdi, qword 0
	mov rax, qword 0
	syscall

	_scantext_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: compare two strings
;args (push order): input string1 addr, input string2 addr, return addr
;return value: rax (if strings are equal == 1 | else == 0)
_strcompare:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	add rdi, rcx
	pop qword rbx
	mov [rdi], qword rbx
	add rcx, qword 8
	mov [rsi], qword rcx

	pop qword rbx
	mov rdi, rbx

	pop qword rbx
	mov rsi, rbx

	xor rdx, rdx
	xor rcx, rcx

	_strcompare_getlen1:
	mov al, byte [rsi]
	cmp al, byte 0
	je _strcompare_gotlen1
	inc rsi
	inc rcx
	jmp _strcompare_getlen1

	_strcompare_gotlen1:
	sub rsi, rcx

	_strcompare_getlen2:
	mov al, byte [rdi]
	cmp al, byte 0
	je _strcompare_gotlen2
	inc rdi
	inc rdx
	jmp _strcompare_getlen2
	_strcompare_gotlen2:
	sub rdi, rdx

	cmp rcx, rdx
	jne _strcompare_returnfalse

	xor rcx, rcx

	_strcompare_loop:
	cmp rcx, rdx
	jae _strcompare_endloop
	mov al, byte [rsi]
	mov bl, byte [rdi]
	cmp al, bl
	jne _strcompare_returnfalse
	inc rsi
	inc rdi
	inc rcx
	jmp _strcompare_loop
	_strcompare_endloop:

	_strcompare_returntrue:
	mov rax, qword 1
	jmp _strcompare_return

	_strcompare_returnfalse:
	mov rax, qword 0

	_strcompare_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

