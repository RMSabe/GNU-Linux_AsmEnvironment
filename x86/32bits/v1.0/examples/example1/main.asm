;Example 1: Print 32bit unsigned integer values

NUM32_START equ 0
NUM32_STOP equ 200
DELAYTIME equ 0x08000000

RETURN_MARGIN_CALLER equ 0x10
RETURN_MARGIN_CALLEE equ 0xc
STACKLIST_SIZE equ 16
TEXTBUF_SIZE equ 128

global _start

section .data

_stacklist_index:
dd 0

_stacklist:
times STACKLIST_SIZE dd 0

_textbuf:
times TEXTBUF_SIZE db 0

_startstr: db 'Started', 0xa, 0x0
_endstr: db 'Terminated', 0xa, 0x0

_num32: dd 0

section .text
bits 32

_start:
	push dword _startstr
	push dword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	jmp _main

_end:
	push dword _endstr
	push dword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	mov ebx, dword 0
	mov eax, dword 1
	int 0x80

_main:
	mov edi, dword _num32
	mov [edi], dword NUM32_START

	_mainloop:
	mov esi, dword _num32
	mov ecx, dword [esi]
	cmp ecx, dword NUM32_STOP
	jae _end

	push dword ecx
	push dword _textbuf
	push dword $
	jmp _loadstr_dec_u32
	times RETURN_MARGIN_CALLER nop

	push dword _textbuf
	push dword $
	jmp _printtextln
	times RETURN_MARGIN_CALLER nop

	push dword DELAYTIME
	push dword $
	jmp _delay32
	times RETURN_MARGIN_CALLER nop

	mov esi, dword _num32
	mov ecx, dword [esi]
	inc ecx
	mov [esi], dword ecx

	jmp _mainloop

%include "includes/time.asm"
%include "includes/userio.asm"
%include "includes/inttostr.asm"

