@GNU-Linux ASM environment for aarch32
@Author: Rafael Sabe
@Email: rafaelmsabe@gmail.com

.section .text

@FUNCTION: delay runtime for a given number of cycles
@args (push order): delay time
_delay32:
	eor r0, r0, r0
	pop {r1}

	_delay32_loop:
	cmp r0, r1
	bhs _delay32_endloop
	add r0, r0, #1
	b _delay32_loop
	_delay32_endloop:

	_delay32_return:
	bx lr

