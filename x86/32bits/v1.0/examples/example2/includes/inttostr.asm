;Integer value to text functions

;FUNCTION: convert 32bit unsigned integer into text
;args (push order): input value, output text buffer addr, return addr
_loadstr_dec_u32:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	add edi, ecx
	pop dword ebx
	mov [edi], dword ebx
	add ecx, dword 4
	mov [esi], dword ecx

	pop dword ebx
	mov edi, ebx

	pop dword ebx

	xor edx, edx
	mov eax, ebx
	mov ecx, dword 1000000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 100000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 10000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 1000000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 100000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 10000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 1000
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 100
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov ebx, edx
	xor edx, edx
	mov eax, ebx
	mov ecx, dword 10
	div dword ecx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov eax, edx
	mov ah, byte 0
	add al, byte 0x30
	mov [edi], byte al
	inc edi

	mov [edi], byte 0

	_loadstr_dec_u32_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx

	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

;FUNCTION: convert 32bit signed integer into text
;args (push order): input value, output text buffer addr, return addr
_loadstr_dec_s32:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	add edi, ecx
	pop dword ebx
	mov [edi], dword ebx
	add ecx, dword 4
	mov [esi], dword ecx

	pop dword ebx
	mov edi, ebx

	pop dword ebx

	test ebx, dword 0x80000000
	jz _loadstr_dec_s32_pos
	
	_loadstr_dec_s32_neg:
	mov [edi], byte 0x2d
	inc edi
	not ebx
	inc ebx

	_loadstr_dec_s32_pos:
	push dword ebx
	push dword edi
	push dword $
	jmp _loadstr_dec_u32
	times RETURN_MARGIN_CALLER nop

	_loadstr_dec_s32_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx

	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

