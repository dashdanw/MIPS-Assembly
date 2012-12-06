		.data
nl: 	.asciiz "\n"
		.align 2
name:	.asciiz "CSE3666: Lab Assignment 3: Dash Winterson\n\n\n"
		.align 2
msg1:	.asciiz "! is equal to "
		.align 2
hireg:	.asciiz "HI: "
		.align 2
loreg:	.asciiz " LO: "
		.align 2
space:	.asciiz	"   "
		.align 2

		.text
		.globl 	main

main: 	li			$a3,5 		#stores the actual value for the parameter and a copy in temp
		move		$t5,$a3
		jal			store

		move		$t2,$v1
		move		$t1,$v0
		
		move	$a0,$t5			#storing all function arguments for print system calls in a registers, and all system call parameters in v0
		li		$v0,1
		syscall
		
		la		$a0,msg1
		li		$v0,4
		syscall

		la		$a0,hireg
		li		$v0,4
		syscall
		
		move	$a0,$t2
		li		$v0,1
		syscall
		
		la		$a0,loreg
		li		$v0,4
		syscall
		
		move	$a0,$t1
		li		$v0,1
		syscall	

		li		$v0,10
		syscall

loop:	li		$t1,1
		move	$t2,$a3
		ble		$t2,1,return1
		mult 	$t1,$t2
		sub		$t2,$t2,1
multi:	ble 	$t2,1,return2   #stores temporary values in $t registers since they will likely be reused
		mflo	$v0
		mfhi	$v1				#storing lo-hi in $v repositories since they are return values
		mult 	$t2,$v1
		mflo	$v1
		mult 	$t2,$v0
		mflo	$v0
		mfhi	$t5
		addu	$v1,$v1,$t5
		sub		$t2,$t2,1
		j 		multi


return1:move	$v0,$t2 		#system calls using the parameters and returns
		li		$v1,0
		jr		$ra 

return2:mflo	$v0
		mfhi	$v1
		jr		$ra

store:	addiu 	$sp,-8
		sw		$ra,($sp)
		sw		$s1,4($sp)
		ble		$a3,1,basecas
		move	$s1,$a3		#move input parameters over to save across functions
		addi	$a3,-1  	#keep in function arguments when decrementing
		jal		loop
		mult	$v1,$s1
		mflo	$v1
		mult	$v0,$s1
		mflo	$v0
		mfhi	$t3
		addu 	$v1,$v1,$t3
		j 		exit

basecas:li 		$v0,1  		#return 1 if input parameters are less than 1 (returns 1 for zero as instructed)
		li		$v1,0		#use v registers for arguments
exit:	lw		$s1,4($sp)
		lw		$ra,($sp)
		addiu	$sp,8
		jr		$ra