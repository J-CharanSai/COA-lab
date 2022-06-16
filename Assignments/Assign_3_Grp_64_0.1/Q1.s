#########################################################################################################
# Assignment 	: 3
# Problem No. 	: 1
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
# 
# 
##########################################################################################################

########### data ###########
.data

	prompt1:	.asciiz "Enter first number: "
	prompt2:	.asciiz "Enter second number: "
	Eror:		.asciiz "Error - Input value out of range"
	result:		.asciiz "Product of two numbers are: "
	newline: 	.asciiz "\n"
	Sp: 		.asciiz " "

########### text ###########
	.text 
	.globl main

# main program
# program variables
# 1st number(M'):	$t0
# 2nd number(Q):	$t1
# AQ : 	$t2
# Q- : 	$t3
# M  :  $t4

main:
		li 		$v0, 4				#issue prompt1
		la 		$a0, prompt1
		syscall

		li 		$v0, 5				# storing input value in v0
		syscall
		move 	$t0, $v0			# $t0 <-- $v0(1st number) ,$t0 => 1st number
		move 	$a1, $t0			# saving a in argument register($a1) for CheckInRange function
		jal		CheckInRange		# jump and link CheckInRange (checking if number is in range)

		li 		$v0, 4				#issue prompt2
		la 		$a0, prompt2
		syscall

		li 		$v0, 5				# storing input value in v0
		syscall
		move 	$t1, $v0			# $t0 <-- $v0(2nd number) ,$t0 => 2nd number
		move 	$a1, $t1			# saving a in argument register($a1) for CheckInRange function
		jal		CheckInRange		# jump and link CheckInRange (checking if number is in range)

		move 	$s0, $zero 			# $s0 = 0
		slt 	$s0, $t1, $zero 	# $s0 = 1 if $t1(Q) < 0
		move 	$t2, $zero 			# AQ($t2) <-- 0
		beq 	$s0, $zero, AQpe  	# if Q >= 0 then goto AQpe
		j 		AQne			  	# else goto AQne
		afterAQ: 					# returns here after making AQ($t2)
		add 	$t4, $zero, $t0 	# $t4 <-- $t0
		sll  	$t4, $t4, 16 		# left shifting $t4 so that we can add/sub to A part of AQ

		j  		Booth 				# jump to booth algorithm

		exitloop:  						# starts after booth algorithm ends
			li 		$v0, 4 				# issue result
			la 		$a0, result
			syscall 
			li 		$v0, 1
			move	$a0, $t2			# print product of two numbers which is in $t2)
			syscall 
			j 		Exit 				# exit program

Booth:
		move 	$t3, $zero 				# initializing $t3 = 0
		addi 	$s7, $zero, 16 			# $s7(n) = 16 number of times is loops

		loop: 							# algo loop starts
			beq 	$s7, $zero, exitloop # if n = 0 then exit booth
			addi 	$s0, $zero, 1 		# $s0 <-- 1
			addi 	$s1, $zero, 1 		# $s1 <-- 1
			and 	$s1, $s1, $t2 		# $s1 = $s1 & $t2(AQ), $s1 stores the LSB of AQ
			and 	$s0, $s0, $t3 		# $s0 = $s0 & $t3(Q-), $s0 stores what $t3 bit is.

			beq 	$s1, $zero,c0 		# in Q0Q- if ($s1)Q0 = 0 then goto c0
			j 		c1 					# else jump to C1

		returnhere: 					# after right shifting it returns here 
			addi 	$s7, $s7, -1 		# decrementing n by 1 n = n-1
			j 		loop 				# jump to loop 
shift:
		move 	$s4, $zero 				# $s4 = 0
		slt 	$s4, $t2, $zero 		# $s4 = 1 if $t2(AQ) < 0

		addi 	$t3, $zero, 1 			# $t3(Q-) = 1
		and 	$t3, $t3, $t2 			# $t3 = LSB of AQ($t2)
		srl 	$t2, $t2, 1 			# $t2 = $t2 >> 1
		sll 	$s4, $s4 31 			# $s4 = $s4<<31 (if $t2 is negative then $s4 = 100...0 else $s4 = 0..0)
		add 	$t2, $t2, $s4 			# $t2 = $t2 + $s4 ($t2 makes sign bit 1 if it is negative before shift)

		j 		returnhere 			# jumpt to returnhere 



c0:
		beq 	$s0, $zero, shift 	# in Q0Q- Q0 = 0, if ($s0)Q- = 0 then goto shift
		j 		plus 				# else goto minus for A = A-M
c1:
		beq 	$s0, 1, shift 		# in Q0Q- Q0 = 1, if Q- = 1 then goto shift
		j 		minus 				# else foto plus for A = A+M 
minus:
		sub 	$t2, $t2, $t4 		# $t2(AQ) = $t2(AQ) - $t4(M) (it only subtracts to B part)
		j 		shift 				# jump to shift

plus:
		add 	$t2, $t2, $t4 		# $t2(AQ) = $t6(AQ) + $t4(M) (it only adds to A part)
		j 		shift 				# jump to shift

AQne:
	sll 	$t1, $t1, 16 			# left shift $t1 by 16 bits 
	addi 	$s0, $zero, 30 			# $s0(i) = 30, for loop
	for1:  							# except the MSB (sign bit) all bits are copied to $t2(AQ) from $t1(Q)
		addi 	$s1, $zero, 1 		# $s1 = 1
		sll 	$s1, $s1, $s0 		# $s1 = $s1<<$s0(i)
		and 	$s1, $s1, $t1 		# $s1 = $s1 & $t1 ($s1 = 1 if $t1's ith bit = 1)
		add 	$t2, $t2, $s1 		# $t2 = $t2 + $s1 (in A(AQ) part of AQ Q bits are stored)

		addi 	$s0, $s0, -1 		# decrementing $s0 by 1
		bge 	$s0, $zero, for1 	# if $s0 > 0 goto continue to for1
	srl 	$t2, $t2, 16 			# $t2 = $t2 >> 16 (shifting Q part to Q(AQ) in AQ)
	addi 	$s1, $zero, 1 			# $s1 = 1
	sll 	$s1, $s1, 15 			# $s1 = $s1 << 15
	add 	$t2, $t2, $s1 			# $t2 = $t2 + $s1 (fliping 16th LSB of AQ, because Q is negative)
	j 		afterAQ					# jump to afterAQ


AQpe:
	#sll 	$t1, $t1, 16 		
	add 	$t2, $t2, $t1 			# $t2 = $t2 + $t1 
	j 		afterAQ  				# jump to afterAQ

CheckInRange: 						# checks if input integer is in range 
		move 	$s0, $zero  		
		slti 	$s0, $a1, -32767
		beq		$s0, 1, Exit1

		addi 	$s1, $zero, 32767
		slt 	$s0, $s1, $a1
		beq 	$s0, 1, Exit1
		jr 		$ra

Exit1: 								# prints error and exits program if input integer is out of range 
		li 		$v0, 4
		la 		$a0, Eror
		syscall 
		j 		Exit
		
Exit: 		 						# exit program
		li 		$v0, 10 
		syscall	 					# End program

