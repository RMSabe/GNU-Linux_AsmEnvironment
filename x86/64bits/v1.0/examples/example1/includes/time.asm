;Time related functions

;FUNCTION: delay the runtime for a number of cycles
;args (push order): delay time (number of cycles), return addr
_delay32:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	add rdi, rcx
	pop qword rbx
	mov [rdi], qword rbx
	add rcx, qword 8
	mov [rsi], qword rcx

	pop qword rbx
	and rbx, qword 0xffffffff
	xor rcx, rcx

	_delay32_loop:
	cmp ecx, ebx
	jae _delay32_endloop
	inc ecx
	jmp _delay32_loop
	_delay32_endloop:

	_delay32_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

