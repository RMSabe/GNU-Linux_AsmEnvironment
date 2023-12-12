@GNU-Linux ASM environment for aarch32
@Author: Rafael Sabe
@Email: rafaelmsabe@gmail.com

.section .text

@FUNCTION: print new line to the standard output
@args (push order): none
_printnewline:
	ldr r1, =_userio_bytebuf
	ldr r0, =0xa
	strb r0, [r1]

	ldr r0, =1
	ldr r2, =1
	ldr r7, =4
	swi 0

	_printnewline_return:
	bx lr

@FUNCTION: print a text string to the standard output
@args (push order): input text buffer addr
_printtext:
	pop {r1}
	mov r3, r1

	eor r2, r2, r2

	_printtext_getlen:
	ldrb r0, [r3]
	cmp r0, #0
	beq _printtext_gotlen
	add r2, r2, #1
	add r3, r3, #1
	b _printtext_getlen
	_printtext_gotlen:

	ldr r0, =1
	ldr r7, =4
	swi 0

	_printtext_return:
	bx lr

@FUNCTION: print text, add new line to the standard output
@args (push order): input text buffer addr
_printtextln:
	ldr r4, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	add r4, r4, r2
	str lr, [r4]
	add r2, r2, #4
	str r2, [r1]

	bl _printtext

	bl _printnewline

	_printtextln_return:
	ldr r4, =_stacklist
	ldr r1, =_stacklist_index
	ldr r2, [r1]
	sub r2, r2, #4
	add r4, r4, r2
	ldr r3, [r4]
	str r2, [r1]

	bx r3

@FUNCTION: wait user input, load user input into text buffer
@args (push order): output text buffer addr, output text buffer size
_scantext:
	pop {r2}
	pop {r1}

	ldr r0, =0
	ldr r7, =3
	swi 0

	_scantext_return:
	bx lr

@FUNCTION: compare two text strings
@args (push order): input text1 buffer addr, input text2 buffer addr
@return value: r0 (1 == equal | 0 == not equal)
_strcompare:
	pop {r1}
	pop {r0}

	eor r2, r2, r2
	eor r3, r3, r3

	_strcompare_getlen1:
	ldrb r4, [r0]
	cmp r4, #0
	beq _strcompare_gotlen1
	add r2, r2, #1
	add r0, r0, #1
	b _strcompare_getlen1
	_strcompare_gotlen1:
	sub r0, r0, r2

	_strcompare_getlen2:
	ldrb r4, [r1]
	cmp r4, #0
	beq _strcompare_gotlen2
	add r3, r3, #1
	add r1, r1, #1
	b _strcompare_getlen2
	_strcompare_gotlen2:
	sub r1, r1, r3

	cmp r2, r3
	bne _strcompare_returnfalse

	eor r2, r2, r2

	_strcompare_loop:
	cmp r2, r3
	bhs _strcompare_endloop
	ldrb r4, [r0]
	ldrb r5, [r1]
	cmp r4, r5
	bne _strcompare_returnfalse
	add r2, r2, #1
	add r0, r0, #1
	add r1, r1, #1
	b _strcompare_loop
	_strcompare_endloop:

	_strcompare_returntrue:
	ldr r0, =1
	b _strcompare_return

	_strcompare_returnfalse:
	eor r0, r0, r0

	_strcompare_return:
	bx lr

.section .data

.align 4
_userio_bytebuf:
.long 0

