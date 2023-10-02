;Example 2: print 32bit signed integer values

NUM32_START equ -100
NUM32_STOP equ 100
DELAYTIME equ 0x10000000

RETURN_MARGIN_CALLER equ 0x10
RETURN_MARGIN_CALLEE equ 0xc
STACKLIST_SIZE equ 16
TEXTBUF_SIZE equ 128

global _start

section .data

_stacklist_index:
dq 0

_stacklist:
times STACKLIST_SIZE dq 0

_textbuf:
times TEXTBUF_SIZE db 0

_startstr: db 'Started', 0xa, 0x0
_endstr: db 'Terminated', 0xa, 0x0

_num32: dd 0

section .text

_start:
	push qword _startstr
	push qword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	jmp _main

_end:
	push qword _endstr
	push qword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	mov rdi, qword 0
	mov rax, qword 60
	syscall

_main:
	mov rdi, qword _num32
	mov [rdi], dword NUM32_START

	_mainloop:
	xor rcx, rcx
	mov rsi, qword _num32
	mov ecx, dword [rsi]
	cmp ecx, dword NUM32_STOP
	jge _end

	push qword rcx
	push qword _textbuf
	push qword $
	jmp _loadstr_dec_s32
	times RETURN_MARGIN_CALLER nop

	push qword _textbuf
	push qword $
	jmp _printtextln
	times RETURN_MARGIN_CALLER nop

	push qword DELAYTIME
	push qword $
	jmp _delay32
	times RETURN_MARGIN_CALLER nop

	xor rcx, rcx
	mov rsi, qword _num32
	mov ecx, dword [rsi]
	inc ecx
	mov [rsi], dword ecx

	jmp _mainloop

%include "includes/time.asm"
%include "includes/userio.asm"
%include "includes/inttostr.asm"

