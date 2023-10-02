;Time related functions

;FUNCTION: delay runtime by a given number of cycles
;args (push order): delay value, return addr
_delay32:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	add edi, ecx
	pop dword ebx
	mov [edi], dword ebx
	add ecx, dword 4
	mov [esi], dword ecx

	pop dword ebx
	xor ecx, ecx

	_delay32_loop:
	cmp ecx, ebx
	jae _delay32_endloop
	inc ecx
	jmp _delay32_loop
	_delay32_endloop:

	_delay32_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx
	
	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

