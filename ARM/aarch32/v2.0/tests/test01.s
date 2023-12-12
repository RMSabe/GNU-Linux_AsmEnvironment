@Test 1: print unsigned 32bit integers

.equ NUM32_START, 0
.equ NUM32_STOP, 200
.equ DELAYTIME, 0x04000000

.section .text

_teststart:
	ldr r0, =_num32
	ldr r1, =NUM32_START
	str r1, [r0]

_testloop:
	ldr r0, =_num32
	ldr r1, [r0]
	cmp r1, #NUM32_STOP
	bhs _testend

	push {r1}
	ldr r4, =_textbuf
	push {r4}
	bl _loadstr_dec_u32

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	push {r4}
	bl _printtextln

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r0, =DELAYTIME
	push {r0}
	bl _delay32

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r0, =_num32
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]

	b _testloop

_testend:
	b _end

.section .data

.align 4
_num32:
.long 0

