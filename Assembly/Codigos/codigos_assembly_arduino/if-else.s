	.file	"if-else.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
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
	ldi r24,lo8(20)
	ldi r25,hi8(20)
	std Y+4,r25
	std Y+3,r24
	ldi r24,lo8(30)
	ldi r25,hi8(30)
	std Y+2,r25
	std Y+1,r24
	ldd r18,Y+3
	ldd r19,Y+4
	ldd r24,Y+1
	ldd r25,Y+2
	cp r18,r24
	cpc r19,r25
	brne .L2
	ldi r24,lo8(40)
	ldi r25,hi8(40)
	std Y+4,r25
	std Y+3,r24
	rjmp .L3
.L2:
	ldi r24,lo8(60)
	ldi r25,hi8(60)
	std Y+2,r25
	std Y+1,r24
.L3:
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
