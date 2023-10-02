;Integer number functions

;FUNCTION: convert an unsigned 64bit integer into text
;args (push order): input value, output text buffer addr, return addr
_loadstr_dec_u64:
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

	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10000000000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 1000000000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 100000000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10000000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 1000000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 100000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 1000000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 100000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 1000000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 100000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 1000000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 100000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 1000
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 100
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rbx, rdx
	xor rdx, rdx
	mov rax, rbx
	mov rcx, qword 10
	div qword rcx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov rax, rdx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov [rdi], byte 0

	_loadstr_dec_u64_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: convert a signed 64bit integer into text
;args (push order): input value, output text buffer addr, return addr
_loadstr_dec_s64:
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
	mov rcx, qword 0x8000000000000000

	test rbx, rcx
	jz _loadstr_dec_s64_pos

	_loadstr_dec_s64_neg:
	mov [rdi], byte 0x2d
	inc rdi
	not rbx
	inc rbx

	_loadstr_dec_s64_pos:
	push qword rbx
	push qword rdi
	push qword $
	jmp _loadstr_dec_u64
	times RETURN_MARGIN_CALLER nop

	_loadstr_dec_s64_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: convert an unsigned 32bit integer into text
;args (push order): input value, output text buffer addr, return addr
_loadstr_dec_u32:
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
	and rbx, qword 0xffffffff

	xor rax, rax
	xor rcx, rcx
	xor rdx, rdx

	mov eax, ebx
	mov ecx, dword 1000000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 100000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 10000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 1000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 100000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 10000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 1000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 100
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 10
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov eax, edx
	mov ah, byte 0
	add al, byte 0x30
	mov [rdi], byte al
	inc rdi

	mov [rdi], byte 0

	_loadstr_dec_u32_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

;FUNCTION: convert a signed 32bit integer into text
;args (push order): input value, output text buffer addr, return addr
_loadstr_dec_s32:
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
	and rbx, qword 0xffffffff

	test ebx, dword 0x80000000
	jz _loadstr_dec_s32_pos

	_loadstr_dec_s32_neg:
	mov [rdi], byte 0x2d
	inc rdi
	not ebx
	inc ebx

	_loadstr_dec_s32_pos:
	push qword rbx
	push qword rdi
	push qword $
	jmp _loadstr_dec_u32
	times RETURN_MARGIN_CALLER nop

	_loadstr_dec_s32_return:
	mov rsi, qword _stacklist_index
	mov rdi, qword _stacklist
	mov rcx, qword [rsi]
	sub rcx, qword 8
	add rdi, rcx
	mov rbx, qword [rdi]
	mov [rsi], qword rcx

	add rbx, qword RETURN_MARGIN_CALLEE
	jmp rbx

