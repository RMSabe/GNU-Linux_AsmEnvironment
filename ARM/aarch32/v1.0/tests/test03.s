@Test 3: test _scantext

.section .text

_teststart:
	ldr r4, =_teststr_entertext
	push {r4}
	push {pc}
	b _printtext
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	ldr r2, =TEXTBUF_SIZE
	push {r4}
	push {r2}
	push {pc}
	b _scantext
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_teststr_youentered
	push {r4}
	push {pc}
	b _printtext
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	push {r4}
	push {pc}
	b _printtextln
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
	ldr r4, =_stackbp
	ldr sp, [r4]

_testend:
	b _end

.section .data

_teststr_entertext: .asciz "Enter text: "
_teststr_youentered: .asciz "You entered: "

