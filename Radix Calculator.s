		.data
name:	.asciiz "CSE3666: Lab Assignment 4: Dash Winterson\n\n\n"
		.align 2
msg1:	.asciiz "3210987654 in base "
		.align 2
msg2:	.asciiz " is "
		.align 2
msg3:	.asciiz "\n\n"
		.align 2
result: .space	32 			#we allocate 32 bytes since that is the longest string (ie. a large 32 bit number will be 32 characters max)
		.align 	2
separate:.asciiz " "
		.align 	2

		.text
		.globl main


main:	la  	$a0,name
		li 		$v0,4
		syscall
		li 		$a2,2 			#arg3 radix
outer:	li		$a0,3210987654 	#arg1 the number
		la		$a1,result 		#arg2 result pointer
		addi   	$a1,32
		move 	$t0,$a0 		#move arg to temp for computation (as not to repeat div step at end of loop, is faster computationally and spacially)
		
loop:	divu 	$t0,$a2 		#divide unsigned the current prev result with the radix
		mflo	$t0				#move result to temp0
		mfhi	$t1				#move remainder to temp1
		bgt		$t1,9,ascchar	#if greater than 10, branch to increment for A-F else continue to add 48 for 0-9

ascnum:	addi	$t1,48			#generate 0-9 ascii for 0-9
		j		cont

ascchar:addiu	$t1,55			#generate A-F ascii for 10-15

cont:	addi	$a1,-1			#increment pointer in string one byte over
		sb		$t1,($a1)		#store ascii byte into our string pointer allocation
		bgtz	$t0,loop		#if more left to divide, then loop else continue to print and exit

		la 		$a0,msg1		#print "the number in base"
		li 		$v0,4
		syscall

		move 	$a0,$a2
		li 		$v0,1
		syscall

		la 		$a0,msg2		#print ": "
		li 		$v0,4
		syscall

		move	$a0,$a1			#print answer
		li 		$v0,4
		syscall

		la 		$a0,msg3		#print "\n\n"
		li 		$v0,4
		syscall

		addi 	$a2,1
		ble		$a2,16,outer 	#if we have more radixes to calulcate, go back to start

exit:	li 		$v0,10
		syscall