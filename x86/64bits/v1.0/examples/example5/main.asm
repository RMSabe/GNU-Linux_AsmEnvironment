;Example 5: Wait user input, copy user input

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

_entertextstr: db 'Enter text: ', 0x0 
_youenteredstr: db 'You entered: ', 0x0

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
	push qword _entertextstr
	push qword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	push qword _textbuf
	push qword TEXTBUF_SIZE
	push qword $
	jmp _scantext
	times RETURN_MARGIN_CALLER nop

	push qword _youenteredstr
	push qword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	push qword _textbuf
	push qword $
	jmp _printtextln
	times RETURN_MARGIN_CALLER nop

	jmp _end

%include "includes/time.asm"
%include "includes/userio.asm"
%include "includes/inttostr.asm"

