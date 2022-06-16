# Assignment 	: 2
# Problem No. 	: 3
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
#
# Finding a number(>=10) is prime or Composite.
# FOR looping the given number from 2 to n/2, and finding if n is divisible by any number or not 
# if n is not divisble by any integer form 1 to n/2 then its a prime number
#

########## data ############
.data
	
	prompt:		.asciiz "Enter the positive integer greater than equals to 10 : "
	Eror:		.asciiz "Invalid Input"
	prime:		.asciiz "Entered number is a PRIME number"
	composite:	.asciiz "Entered number is a COMPOSITE number"
	newline: 	.asciiz "\n"

########## text ############
	.text 
	.globl main

#
# main program
# program variables
# a:	$t1
# i: 	$s0
# x: 	$t0 -> x = a/2
# 

main:
		li 		$v0, 4				# issue prompt
		la 		$a0, prompt
		syscall

		li 		$v0, 5 				# input form user stored in $v0
		syscall
		move 	$t1, $v0 			# given number is stored to $t1 , $t1 <-- $v0
		move 	$a1, $t1 			# $a1 <-- $t1
		jal		Checkmorethan10 	# jump and link to Checkmorethan10 (fucntion which checks if given number is more than 10 or not)

		addi 	$s0, $zero, 2 		# $s0 <-- 0+2 (initializing i = 2, for FOR loop)
		div		$t0, $t1, $s0 		# $t0 <-- $t1/$s0 ($t0 <-- a/2)
		move 	$s1, $zero 			# $s1 <-- 0 ($s1 initialized to 0)

		for: 
			slt 	$s1, $s0, $t0 		# $s1 = 1 if (i < a/2) condition check for FOR loop  
			beq 	$s1, $zero, Exit1 	# if($s1 = 0)(looping finished) then given integer is prime 
			move 	$s2, $zero 			# $s2 <-- 0
			rem 	$s2, $t1, $s0 		# $s2 = a % i ($s2 stores remainer)
			beq		$s2, $zero, Exit2 	# jump to Exit2, if($s2 == 0, then a is divisible by i, means a is Composite number )
			addi 	$s0, $s0, 1 		# increamenting i <-- i+1

			j 	for 					# jump to for 

		


		j 		Exit 					# jump to Exit 

Checkmorethan10:
		move 	$s3,$zero           # initialize with zero
		slt 	$s3, $a1, 10 		# $s3 = 1 if(a < 10)
		beq 	$s3, 1, error_print # print error message for negative number, goto error_print.

		jr 		$ra 				# return the address where this function is called

error_print:
		li 		$v0,4  
		la 		$a0,Eror 			# Load the error message
		syscall
		j 		Exit 				# jump to Exit


Exit1: 
		li 		$v0, 4
		la 		$a0, prime 			# load prime message
		syscall
		j 		Exit				# jump to Exit
Exit2:
		li 		$v0, 4
		la 		$a0, composite 		# load Composite message
		syscall
		j 		Exit		 		# jump to Exit

Exit:
		li 		$v0, 10
		syscall 			 	# exit program