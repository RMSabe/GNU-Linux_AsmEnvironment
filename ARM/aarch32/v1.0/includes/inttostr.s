@GNU-Linux ASM environment for aarch32
@Author: Rafael Sabe
@Email: rafaelmsabe@gmail.com

.section .text

@FUNCTION: loads unsigned 32bit integer into text buffer
@args (push order): input value, output text buffer addr, return addr
_loadstr_dec_u32:
	ldr r0, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	add r0, r0, r2
	pop {r3}
	str r3, [r0]
	add r2, r2, #4
	str r2, [r1]

	pop {r4}

	pop {r0}

	ldr r3, =1000000000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =100000000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =10000000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =1000000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =100000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =10000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =1000
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =100
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	ldr r3, =10
	udiv r1, r0, r3
	mul r2, r1, r3
	sub r0, r0, r2
	and r1, r1, #0xff
	add r1, r1, #0x30
	strb r1, [r4]
	add r4, r4, #1

	and r0, r0, #0xff
	add r0, r0, #0x30
	strb r0, [r4]
	add r4, r4, #1

	ldr r0, =0x0
	strb r0, [r4]

	_loadstr_dec_u32_return:
	ldr r0, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	sub r2, r2, #4
	add r0, r0, r2
	ldr r3, [r0]
	str r2, [r1]

	add r3, r3, #RETURN_MARGIN_CALLEE
	bx r3

@FUNCTION: loads signed 32bit integer into text buffer
@args (push order): input value, output text buffer addr, return addr
_loadstr_dec_s32:
	ldr r0, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	add r0, r0, r2
	pop {r3}
	str r3, [r0]
	add r2, r2, #4
	str r2, [r1]

	pop {r4}

	pop {r0}

	ldr r1, =0x80000000
	tst r0, r1
	beq _loadstr_dec_s32_pos

	_loadstr_dec_s32_neg:
	ldr r2, =0x2d
	strb r2, [r4]
	add r4, r4, #1

	mvn r0, r0
	add r0, r0, #1

	_loadstr_dec_s32_pos:
	push {r0}
	push {r4}
	push {pc}
	b _loadstr_dec_u32
	.fill RETURN_MARGIN_CALLER, NOP_SIZE, NOP_VALUE

	_loadstr_dec_s32_return:
	ldr r0, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	sub r2, r2, #4
	add r0, r0, r2
	ldr r3, [r0]
	str r2, [r1]

	add r3, r3, #RETURN_MARGIN_CALLEE
	bx r3

