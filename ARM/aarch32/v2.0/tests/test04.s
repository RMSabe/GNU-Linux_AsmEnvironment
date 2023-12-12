@Test 4: test _strcompare

.equ TESTSTR1, _teststr2
.equ TESTSTR2, _teststr1

.section .text

_teststart:
	ldr r4, =TESTSTR1
	push {r4}
	bl _printtext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	ldrh r0, =0x20
	strh r0, [r4]

	push {r4}
	bl _printtext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =TESTSTR2
	push {r4}
	bl _printtext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf
	ldrh r0, =0x20
	strh r0, [r4]

	push {r4}
	bl _printtext

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =TESTSTR1
	ldr r5, =TESTSTR2
	push {r4}
	push {r5}
	bl _strcompare

	ldr r4, =_stackbp
	ldr sp, [r4]

	ldr r4, =_textbuf

	ldr r2, =0xffffffff
	tst r0, r2
	beq _test_returnedfalse

	_test_returnedtrue:
	ldrh r1, =0x31
	b _test_proceed

	_test_returnedfalse:
	ldrh r1, =0x30

	_test_proceed:
	strh r1, [r4]

	push {r4}
	bl _printtextln

	ldr r4, =_stackbp
	ldr sp, [r4]

_testend:
	b _end

.section .data

_teststr1: .asciz "sum"
_teststr2: .asciz "sub"
_teststr3: .asciz "mult"
_teststr4: .asciz "sum"

