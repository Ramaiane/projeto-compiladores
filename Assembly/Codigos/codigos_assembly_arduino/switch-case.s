	.file	"switch-case.c"
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
	ldd r24,Y+1
	ldd r25,Y+2
	std Y+4,r25
	std Y+3,r24
	ldd r24,Y+3
	ldd r25,Y+4
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L4
	ldd r24,Y+3
	ldd r25,Y+4
	cpi r24,3
	cpc r25,__zero_reg__
	breq .L5
	ldd r24,Y+3
	ldd r25,Y+4
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L8
.L3:
	ldi r24,lo8(10)
	ldi r25,hi8(10)
	std Y+2,r25
	std Y+1,r24
	rjmp .L6
.L4:
	ldi r24,lo8(20)
	ldi r25,hi8(20)
	std Y+2,r25
	std Y+1,r24
	rjmp .L6
.L5:
	ldi r24,lo8(30)
	ldi r25,hi8(30)
	std Y+2,r25
	std Y+1,r24
	rjmp .L6
.L8:
	ldi r24,lo8(200)
	ldi r25,hi8(200)
	std Y+2,r25
	std Y+1,r24
.L6:
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
