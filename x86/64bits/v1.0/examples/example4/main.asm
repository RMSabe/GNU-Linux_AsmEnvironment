;Example 4: print 64bit signed integer values

NUM64_START equ -100
NUM64_STOP equ 100
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

_num64: dq 0

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
	mov rdi, qword _num64
	mov rcx, qword NUM64_START
	mov [rdi], qword rcx

	_mainloop:
	mov rsi, qword _num64
	mov rcx, qword [rsi]
	cmp rcx, qword NUM64_STOP
	jge _end

	push qword rcx
	push qword _textbuf
	push qword $
	jmp _loadstr_dec_s64
	times RETURN_MARGIN_CALLER nop

	push qword _textbuf
	push qword $
	jmp _printtextln
	times RETURN_MARGIN_CALLER nop

	push qword DELAYTIME
	push qword $
	jmp _delay32
	times RETURN_MARGIN_CALLER nop

	mov rsi, qword _num64
	mov rcx, qword [rsi]
	inc rcx
	mov [rsi], qword rcx

	jmp _mainloop

%include "includes/time.asm"
%include "includes/userio.asm"
%include "includes/inttostr.asm"

