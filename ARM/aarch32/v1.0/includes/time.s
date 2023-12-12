@GNU-Linux ASM environment for aarch32
@Author: Rafael Sabe
@Email: rafaelmsabe@gmail.com

.section .text

@FUNCTION: delay runtime for a given number of cycles
@args (push order): delay time, return addr
_delay32:
	ldr r0, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	add r0, r0, r2
	pop {r3}
	str r3, [r0]
	add r2, r2, #4
	str r2, [r1]

	eor r0, r0, r0
	pop {r1}

	_delay32_loop:
	cmp r0, r1
	bhs _delay32_endloop
	add r0, r0, #1
	b _delay32_loop
	_delay32_endloop:

	_delay32_return:
	ldr r0, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	sub r2, r2, #4
	add r0, r0, r2
	ldr r3, [r0]
	str r2, [r1]

	add r3, r3, #RETURN_MARGIN_CALLEE
	bx r3

