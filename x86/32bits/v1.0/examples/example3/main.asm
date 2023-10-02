;Example 3: Wait user input, copy user input

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

_entertextstr: db 'Enter text: ', 0x0
_youenteredstr: db 'You entered: ', 0x0

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
	push dword _entertextstr
	push dword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	push dword _textbuf
	push dword TEXTBUF_SIZE
	push dword $
	jmp _scantext
	times RETURN_MARGIN_CALLER nop

	push dword _youenteredstr
	push dword $
	jmp _printtext
	times RETURN_MARGIN_CALLER nop

	push dword _textbuf
	push dword $
	jmp _printtextln
	times RETURN_MARGIN_CALLER nop

	jmp _end

%include "includes/time.asm"
%include "includes/userio.asm"
%include "includes/inttostr.asm"

