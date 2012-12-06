		.data
nl: 	.asciiz "\n"
		.align 2
name:	.asciiz "CSE3666: Lab Assignment 1: Dash Winterson\n\n\n"
		.align 2
msg1:	.asciiz "Fibonacci Series Element "
		.align 2
msg2:	.asciiz " is "
		.align 2
arr:	.space 20


		.text
		.globl 	main

main: 	la 		$a0,name
		li 		$v0,4
		syscall
		li 		$t2,0
		li 		$t1,1
		li 		$t4,0
		li		$t5,41
		li 		$t6,36
		la 		$t8,arr

loop:	sub		$t7,$t4,$t6
		bltz	$t7,incrmnt

print:  la 		$a0,msg1
		li 		$v0,4
		syscall
		move 	$a0,$t4
		li		$v0,1
		syscall
		la 		$a0,msg2
		li 		$v0,4
		syscall
		move 	$a0,$t0
		li 		$v0,1
		syscall
		la 		$a0,nl
		li 		$v0,4
		syscall
		sw		$t0,($t8)
		move 	$a0,$t8
		li 		$v0,1
		syscall
		addi	$t8,4

incrmnt:addi 	$t4,1
		move 	$t2,$t1
		move 	$t1,$t0
		add 	$t0,$t1,$t2
		beq 	$t5,$t4,Exit
		j 		loop

Exit: 	li 		$v0,10
		syscall