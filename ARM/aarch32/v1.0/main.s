@GNU-Linux ASM environment for aarch32
@Author: Rafael Sabe
@Email: rafaelmsabe@gmail.com

.equ RETURN_MARGIN_CALLER, 0x10
.equ RETURN_MARGIN_CALLEE, 0xc
.equ STACKLIST_SIZE, 8
.equ TEXTBUF_SIZE, 32

.equ NOP_VALUE, 0xe1a00000
.equ NOP_SIZE, 4

.global _start

.section .text
_start:
	ldr r0, =_stackbp
	str sp, [r0]

	ldr r0, =_startstr
	push {r0}
	push {pc}
	b _printtext
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
	ldr r4, =_stackbp
	ldr sp, [r4]

	b _main

_end:
	ldr r0, =_endstr
	push {r0}
	push {pc}
	b _printtext
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r0, =0
	ldr r7, =1
	swi 0

_main:
@Add main routine here

	b _end

.section .data

.align 4
_stackbp:
.long 0x0

_stacklist_index:
.long 0x0

_stacklist:
.fill STACKLIST_SIZE, 4, 0x0

_textbuf:
.fill TEXTBUF_SIZE, 1, 0x0

.include "includes/time.s"
.include "includes/userio.s"
.include "includes/inttostr.s"

_startstr: .asciz "Started\n"
_endstr: .asciz "Terminated\n"


