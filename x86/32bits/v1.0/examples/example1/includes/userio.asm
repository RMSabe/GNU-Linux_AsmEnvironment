;User I/O functions

;FUNCTION: print line break at standard output
;args (push order): return addr
_printnewline:
	mov edi, dword _textbuf
	mov [edi], byte 0xa

	mov edx, dword 1
	mov ecx, dword _textbuf
	mov ebx, dword 1
	mov eax, dword 4
	int 0x80

	pop dword ebx
	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

;FUNCTION: print text at standard output
;args (push order): input text buffer addr, return addr
_printtext:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	add edi, ecx
	pop dword ebx
	mov [edi], dword ebx
	add ecx, dword 4
	mov [esi], dword ecx

	pop dword ecx
	mov edi, ecx
	xor edx, edx

	_printtext_getlen:
	mov al, byte [edi]
	cmp al, byte 0
	je _printtext_gotlen
	inc edi
	inc edx
	jmp _printtext_getlen
	_printtext_gotlen:

	mov ebx, dword 1
	mov eax, dword 4
	int 0x80

	_printtext_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx

	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

;FUNCTION: print text, add line break at standard output
;args (push order): input text buffer addr, return addr
_printtextln:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	add edi, ecx
	pop dword ebx
	mov [edi], dword ebx
	add ecx, dword 4
	mov [esi], dword ecx

	push dword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	push dword $
	jmp _printnewline
	times RETURN_MARGIN_CALLER nop

	_printtextln_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx

	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

;FUNCTION: wait user input, load user input into text buffer
;args (push order): output buffer addr, output buffer length, return addr
_scantext:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	add edi, ecx
	pop dword ebx
	mov [edi], dword ebx
	add ecx, dword 4
	mov [esi], dword ecx

	pop dword edx
	pop dword ecx

	mov ebx, dword 0
	mov eax, dword 3
	int 0x80

	_scantext_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx

	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

;FUNCTION: compare two strings
;args (push order): input string1 addr, input string2 addr, return addr
;return value: eax (strings are equal == 1 | else == 0)
_strcompare:
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
	mov esi, ebx

	xor ecx, ecx
	xor edx, edx

	_strcompare_getlen1:
	mov al, byte [esi]
	cmp al, byte 0
	je _strcompare_gotlen1
	inc esi
	inc ecx
	jmp _strcompare_getlen1
	_strcompare_gotlen1:
	sub esi, ecx

	_strcompare_getlen2:
	mov al, byte [edi]
	cmp al, byte 0
	je _strcompare_gotlen2
	inc edi
	inc edx
	jmp _strcompare_getlen2
	_strcompare_gotlen2:
	sub edi, edx

	cmp ecx, edx
	jne _strcompare_returnfalse

	xor ecx, ecx
	_strcompare_loop:
	cmp ecx, edx
	jae _strcompare_endloop
	mov al, byte [esi]
	mov bl, byte [edi]
	cmp al, bl
	jne _strcompare_returnfalse
	inc ecx
	inc esi
	inc edi
	jmp _strcompare_loop
	_strcompare_endloop:

	_strcompare_returntrue:
	mov eax, dword 1
	jmp _strcompare_return

	_strcompare_returnfalse:
	xor eax, eax

	_strcompare_return:
	mov esi, dword _stacklist_index
	mov edi, dword _stacklist
	mov ecx, dword [esi]
	sub ecx, dword 4
	add edi, ecx
	mov ebx, dword [edi]
	mov [esi], dword ecx

	add ebx, dword RETURN_MARGIN_CALLEE
	jmp ebx

