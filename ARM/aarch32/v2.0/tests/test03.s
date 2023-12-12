@Test 3: test _scantext

.section .text

_teststart:
	ldr r4, =_teststr_entertext
	push {r4}
	bl _printtext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	ldr r2, =TEXTBUF_SIZE
	push {r4}
	push {r2}
	bl _scantext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_teststr_youentered
	push {r4}
	bl _printtext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	push {r4}
	bl _printtextln

	ldr r4, =_stackbp
	ldr sp, [r4]

_testend:
	b _end

.section .data

_teststr_entertext: .asciz "Enter text: "
_teststr_youentered: .asciz "You entered: "

