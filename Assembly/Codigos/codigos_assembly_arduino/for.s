	.file	"for.c"
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
	.string	"%d"
	.text
.global	main
	.type	main, @function
main:
	push r29
	push r28
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 4 */
	ldi r24,lo8(2)
	ldi r25,hi8(2)
	std Y+4,r25
	std Y+3,r24
	rjmp .L2
.L3:
	rcall .
	rcall .
	in r30,__SP_L__
	in r31,__SP_H__
	adiw r30,1
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	std Z+1,r25
	st Z,r24
	ldd r24,Y+3
	ldd r25,Y+4
	std Z+3,r25
	std Z+2,r24
	rcall printf
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	ldd r24,Y+3
	ldd r25,Y+4
	adiw r24,1
	std Y+4,r25
	std Y+3,r24
.L2:
	ldd r24,Y+3
	ldd r25,Y+4
	cpi r24,5
	cpc r25,__zero_reg__
	brlt .L3
	ldi r24,lo8(0)
	ldi r25,hi8(0)
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r28
	pop r29
	ret
	.size	main, .-main
