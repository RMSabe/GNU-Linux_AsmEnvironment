@Test 2: print signed 32bit integers

.equ NUM32_START, -100
.equ NUM32_STOP, 100
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
	bge _testend

	push {r1}
	ldr r4, =_textbuf
	push {r4}
	push {pc}
	b _loadstr_dec_s32
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

	ldr r0, =DELAYTIME
	push {r0}
	push {pc}
	b _delay32
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE
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

