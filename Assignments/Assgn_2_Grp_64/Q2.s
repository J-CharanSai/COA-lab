# Assignment 	: 2
# Problem No. 	: 2
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
#
# Taking 2 inputs from user and finding the GCD of two numbers 
# Finding GCD : subtracting bigger number by smaller until one of then becomes 0
#

########## data ##########
.data
	
	prompt1:	.asciiz "Enter the first positive integer: "
	prompt2:	.asciiz "Enter the second positive integer: "
	Eror:		.asciiz "Invalid Input"
	message:	.asciiz "GCD of the two integers is: "
	newline: 	.asciiz "\n"


########## text ##########
	.text 
	.globl main

# main program
# program variables
# a:	$s0
# b:	$s1

main:
		li 		$v0, 4			#issue prompt1 
		la 		$a0, prompt1
		syscall

		li 		$v0, 5			#Taking 1st positive integer(a) input form user
		syscall
		move 	$s0, $v0		#storing a(1st positive integer) in $s0 register
		move 	$a1, $s0		#storing a in $a1 register to pass to CheckPositive function
		jal		CheckPositive	#jump an link CheckPositive (function call)(Check if a is positive or not)

		li 		$v0, 4			#issue prompt2 
		la 		$a0, prompt2
		syscall

		li 		$v0, 5 			#Taking 2nd positive integer(b) from user 
		syscall 
		move 	$s1, $v0 		#storing b in $s1, $s1 <-- $v0(b)
		move 	$a1, $s1 		#storing b in $a1 as an argument in Check positive function, $a1 <-- $s1(b)
		jal		CheckPositive 	#jjump an link CheckPositive (function call)(Check if b is positive or not)

		move 	$a3, $s1      			# $a3 <-- $s1(b), defining GCD as b (initially)
		beq 	$s0, $zero, prntGCD 	# if(a == 0) then goto PrntGCD
		move 	$a3, $s0 				# $a3 <-- $s0(a), defining GCD as a 
		while:							# while loop starts 
			beq 	$s1, $zero, prntGCD # Check whlie loop condition b==0, if(b==0) then goto prntGCD
			move 	$s2, $zero 			# initialize $s2 to 0
			slt		$s2, $s1, $s0 		# $s2 = 1 if b < a
			beq 	$s2, 1, a_dec 		# if(b < a) goto a_dec
			bne		$s2, 1, b_dec 		# else goto b_dec 
			move 	$a3, $s0 			# $a3 <-- a , argument for prntGCD
			j 		while 				# jump to while

		j 		Exit 					# jump to Exit

CheckPositive:
		move 	$s2,$zero           #initialize with zero
		slt 	$s2, $a1, 1 		#sets $s2 to 1 if $a1 less than 1 (not positiv)
		beq 	$s2, 1, error_print # print error message for negative number 

		jr 		$ra 				#returns to the address where function is called

error_print:
		li 		$v0,4  				
		la 		$a0,Eror 			# Load the error message
		syscall
		j 		Exit				#goto exit

a_dec:
		sub 	$s0, $s0, $s1 		#decreasing a by b, a = a - b
		jr 		$ra 				#reutrn 

b_dec:
		sub 	$s1, $s1, $s0 		#decreasing b by a, b = b - a
		jr		$ra 				#return 

prntGCD:
		li 		$v0, 4 				
		la 		$a0,message 		#load the message message
		syscall 

		li 		$v0, 1 				
		move	$a0, $a3 			#print the GCD of two numbers which is stored in $a3
		syscall
		j 		Exit 				#goto Exit 


Exit: 
		li 		$v0, 10 			#exit program
		syscall				

