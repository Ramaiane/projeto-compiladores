	.file	"printf.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.data
.LC0:
	.string	"Hello"
	.text
.global	main
	.type	main, @function
main:
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
	rcall .
	in r30,__SP_L__
	in r31,__SP_H__
	adiw r30,1
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	std Z+1,r25
	st Z,r24
	rcall printf
	pop __tmp_reg__
	pop __tmp_reg__
	ldi r24,lo8(0)
	ldi r25,hi8(0)
/* epilogue start */
	pop r28
	pop r29
	ret
	.size	main, .-main
