##################################################
#This program computes the radix of a number	#
#specified in a0, with a char pointer in a1,	#
#and converts it to the radix specified in a2 	#
#AUTHOR: Dash Winterson 2012
#################################################
		.data
		.space	32 	#we allocate 32 bytes since that is the longest string (ie. a large 32 bit number will be 32, 8 bit characters max)
result: .align 	2   #we point to directly after the 32 byte

		.text
		.globl main

main:	li		$a0,4294967295 	#arg1 the number
		la		$a1,result 		#arg2 result pointer
		li 		$a2,16 			#arg3 radix
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

		move	$a0,$a1			#print and exit
		li 		$v0,4
		syscall

exit:	li 		$v0,10
		syscall