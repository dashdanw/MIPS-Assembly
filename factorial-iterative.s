		.data
nl: 	.asciiz "\n"
		.align 2
name:	.asciiz "CSE3666: Lab Assignment 1: Dash Winterson\n\n\n"
		.align 2
msg1:	.asciiz "! is equal to HI:"
		.align 2
lomsg:	.asciiz " LO:"
		.align 2
space:	.asciiz	"   "
		.align 2


		.text
		.globl 	main

main: 	li		$a3,15			#stores 15 as function parameter
		li 		$t0,1
		la 		$a0,name		#system calls use a0 for argument, and v0 for return value to pass to system
		li 		$v0,4
		syscall
		move	$a0,$a3
		li		$v0,1
		syscall
		la 		$a0,msg1
		li		$v0,4
		syscall
		ble		$a3,1,print


loop: 	mult	$t0,$a3 		#uses temp dirs as not to overlap the lo multiplication with the high multiplication
		mflo	$t0				#preserves the return values of old multiplication to calculate overflow
		mfhi	$t2

		mult	$t1,$a3
		mflo	$t3
		add		$t1,$t2,$t3		#add into temps

		addiu	$a3,-1 			#decrement function argument for iterative call

		bge		$a3,2,loop
		

print:  move 	$a0,$t1
		li		$v0,1
		syscall
		la 		$a0,lomsg
		li 		$v0,4
		syscall
		move 	$a0,$t0
		li 		$v0,1
		syscall

Exit: 	li 		$v0,10
		syscall