	.file	"switch-case.c"
	.text
.globl main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	movq	%rsp, %rbp
	.cfi_offset 6, -16
	.cfi_def_cfa_register 6
	movl	-4(%rbp), %eax
	cmpl	$2, %eax
	je	.L4
	cmpl	$3, %eax
	je	.L5
	cmpl	$1, %eax
	jne	.L8
.L3:
	movl	$10, -4(%rbp)
	jmp	.L6
.L4:
	movl	$20, -4(%rbp)
	jmp	.L6
.L5:
	movl	$30, -4(%rbp)
	jmp	.L6
.L8:
	movl	$200, -4(%rbp)
.L6:
	movl	$0, %eax
	leave
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3"
	.section	.note.GNU-stack,"",@progbits
