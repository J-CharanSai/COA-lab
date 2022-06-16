# Assignment 	: 2
# Problem No. 	: 4
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
#
# finding if a positive number(a) is perfect or not
# FOR looping form 1 to a-1
# if a number is a proper divisior of a then add them to sum(variable)
# finally at the end of the loop Check if sum is equal to a, if so then it's a perfect number, other wise its notperfect.
#

########### data ###########
.data

	prompt:		.asciiz "Enter the positive integer: "
	Eror:		.asciiz "Invalid Input"
	perfect:	.asciiz "Entered number is a perfect number"
	notperfect:	.asciiz "Entered number is not a perfect number"
	newline: 	.asciiz "\n"

########### text ###########
	.text 
	.globl main

# main program
# program variables
# a:	$t0
# i: 	$s0
# sum: 	$t2

main:
		li 		$v0, 4				#issue prompt
		la 		$a0, prompt
		syscall

		li 		$v0, 5				# storing input value in v0
		syscall
		move 	$t0, $v0			# $t0 <-- $v0(a) ,$t0 => a
		move 	$a1, $t0			# saving a in argument register($a1) for CheckPositive function
		jal		CheckPositive		# jump and link CheckPositive (checking if number is positive or not)

		move 	$s3, $zero
		seq 	$s3, $t0, 1 			# check if a == 1
		beq		$s3, 1, Exit2			# if a == 1 then goto Exit2

		move 	$s0, $zero 				# int i for FOR loop initiaized to 0
		addi 	$s0, $s0, 1 			# 
		move 	$t2, $zero				# sum register to store the sum of proper divisors

		for:								# for loop.
			move 	$s1, $zero				# making register $s1 = 0
			slt 	$s1, $s0, $t0			# condition check for FOR loop (i<a)
			beq		$s1, $zero, CheckNum	# if loop finished then Check if sum == a or not 
			addi 	$s2, $zero, 1 			# initializing register $s2 to 1 for condition check 
			rem 	$s2, $t0, $s0 			# storing remainder in $s2 ($s2 => n % i)
			move 	$s3, $zero 				# $s3 <-- 0
			seq		$s3, $s2, 0 			# $s3 = 1 if remainder($s2 == 0), $s3 remains 0 other wise.
			mul		$t3, $s3, $s0 			# $t3 = $s3 * $s0 , $t3 = i if(remainder is 0), $t3 = 0 other wise
			add 	$t2, $t2, $t3 			# sum = sum + $t3 (as $t3 = i only if i is a proper divisor of number(a))
			addi 	$s0, $s0, 1 			# increament i by 1
			j 	for 						# jump to for

		j 		Exit 						# jump to Exit (exit program )

CheckNum: 								# Function is called to check if sum == a
		move 	$s3, $zero 				# $s3 <-- 0
		seq		$s3, $t2, $t0 			# $s3 = 1 if(sum == a)
		beq		$s3, 1, Exit1 			# if $s3 = 1 , then a is perfect number then jump to Exit1
		beq		$s3, 0, Exit2  			# if $s3 = 0 , then a is not a perfect number then jump to Exit2

CheckPositive:
		move 	$s3, $zero           	# initialize with zero
		slt 	$s3, $a1, 1 			# $s2 =1 if(a < 1)
		beq 	$s3, 1, error_print  	# print error message for negative number 

		jr 		$ra 					# reutrn to address where this fucntion is called.

error_print:
		li 		$v0,4  
		la 		$a0,Eror 			# Load the error message
		syscall
		j 		Exit 				# jump to Exit 


Exit1: 								# fucntion is called if number is perfect 			
		li 		$v0, 4
		la 		$a0, perfect 		# prints if number is perfect
		syscall
		j 		Exit 	   			# jump to Exit

Exit2:								# fucntion is called if number is not perfect 
		li 		$v0, 4
		la 		$a0, notperfect 	# prints if number is not perfect
		syscall
		j 		Exit				# jump to Exit
Exit:
		li 		$v0, 10 
		syscall	 					# End program

