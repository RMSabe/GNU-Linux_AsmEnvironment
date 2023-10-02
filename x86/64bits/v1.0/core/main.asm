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
//Insert main routine here

	jmp _end

%include "includes/time.asm"
%include "includes/userio.asm"
%include "includes/inttostr.asm"

