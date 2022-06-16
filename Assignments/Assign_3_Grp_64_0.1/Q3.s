#########################################################################################################
# Assignment 	: 3
# Problem No. 	: 3
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
# 
# Using stack and frame pointers for this problem
# After initializing the stack and frame pointers, takes 4 inputs from user m,n,a,r and pushed into the stack
# malloc function is called for allocating space for array A 
# array A is filled by GP(a,r) in row-major fashion 
# malloc function is called for allocating space for array B
# transposematrix is called to transepose the matrix A and store it in B
# both the arrays are printed finally
# finally stack and frame pointers are return as before the start of this programe.
#
##########################################################################################################

########### data ###########
.data

	prompt1:	.asciiz "Enter four positive integers m, n, a and r: "
	Eror:		.asciiz "Error - Invalid Input"
	Sp:			.asciiz " "
	newline: 	.asciiz "\n"
	printA: 	.asciiz "\n matrix A: \n"
	printB: 	.asciiz "\n matrix B: \n"

########### text ###########
	.text 
	.globl main

# main program
# program variables
# for no confusion following registers are used to loadword(in the code) from stack
# $t0 -> m
# $t1 -> n
# $t2 -> a
# $t3 -> r
# $t5 -> address of A
# $t6 -> address of B
#

main: 
	initStack: 					# initialize stack and frame pointers
		subu 	$sp, $sp, 16 	
		sw 		$ra, 4($sp) 	# storing return address
		sw 		$fp, 0($sp) 	# storing frame pointer in stack
		addiu 	$fp, $sp, 12 	# initializing frame pointer

	li 		$v0, 4				#issue prompt1
	la 		$a0, prompt1
	syscall

	li 		$v0, 5				# storing input value in v0
	syscall
	move 	$a0, $v0			# saving a in argument register($a0) for CheckPositive function
	jal		CheckPositive		# jump and link CheckPositive 
	jal 	pushToStack			# pushing m to stack

	li 		$v0, 5				# storing input value in v0
	syscall
	move 	$a0, $v0			# saving a in argument register($a0) for CheckPositive function
	jal		CheckPositive		# jump and link CheckPositive 
	jal		pushToStack			# pushing n to stack

	li 		$v0, 5				# storing input value in v0
	syscall
	move 	$a0, $v0			# saving a in argument register($a0) for CheckPositive function
	jal		CheckPositive		# jump and link CheckPositive
	jal		pushToStack			# pushing a to stack 

	li 		$v0, 5				# storing input value in v0
	syscall
	move 	$a0, $v0			# saving a in argument register($a0) for CheckPositive function
	jal		CheckPositive		# jump and link CheckPositive 
	jal		pushToStack			# pushing r to stack

	lw 		$t0, 12($sp) 		# loading m in $t0 form stack
	lw 		$t1, 8($sp) 		# loading n in $t1 from stack
	move 	$a0, $zero
	jal 	pushToStack	 		# pushing value 0 to stack
	mul 	$a0, $t0, $t1  		# size($a0) = m*n, argument for malloc function
	jal 	pushToStack 		# pushing m*n value in stack
	jal		malloc 				# malloc function call for A matrix
	addu 	$sp, $sp, 8 		# poping stack by 8 bytes (m*n and 0)
	move 	$t5, $v0 			# storing return address of A in $t5
	move 	$a0, $t5 
	jal 	pushToStack			# pushing address of A in stack


	lw 		$t0, 16($sp) 		# load m in $t0
	lw 		$t1, 12($sp) 		# load n in $t1
	lw 		$t2, 8($sp)			# load value a in $t2
	lw 		$t3, 4($sp) 		# load value r in $t3
	addi 	$s0, $zero, 0 		# $s0(i) = 0 (for the loop for1)
	for1:
		addi	$s1, $zero, 0 	# $s1(j) = 0 (for the loop for2)
		add 	$s2, $zero, $s0 # $s2(index) = $s0 
		mul 	$s2, $s2, $t1 	# $s2(index) *= $t1(column size)
		mul 	$s2, $s2, 4 	# $s2(index) *= size(4)
		add 	$s2, $s2, $t5	# $s2 = $s2 + address of A ($s2 -> start address of ith row)

		for2:
			sw 		$t2, 0($s2) 	# storing value in Array A in GP 
			mul 	$t2, $t2, $t3 	# $t2 = $t2 * $t3 (a = a*r)

			addi 	$s2, $s2, 4 	# increasing address of A matrix to next index [i][j+1]

			addi 	$s1, $s1, 1 	# j = j+1 
			bne 	$s1, $t1, for2 	# is j != n goto for2

		addi 	$s0, $s0, 1 	# i = i+1
		bne 	$s0, $t0, for1 	# if i != m goto for1

	li 		$v0, 4 			# issue printA
	la 		$a0, printA
	syscall 
	jal 	printMatrix 	# fuction call to print matrix A


	lw 		$t0, 16($sp) 	# load m in $t0 
	lw 		$t1, 12($sp) 	# load n in $t1
	addi 	$a0, $zero, 1
	jal 	pushToStack 	# pushing value 1 to stack	
	mul 	$a0, $t1, $t0  		# size($a0) = n*m, argument for malloc function
	jal 	pushToStack 	# pushing n*m value to stack
	lw 		$s5, 0($t5)
	jal		malloc 			# function call malloc for matrix B 
	sw 		$s5, 0($t5)
	addu 	$sp, $sp, 8 	# poping values n*m and 1 out of stack
	move 	$t6, $v0 			# storing return address of B in $t6
	move 	$a0, $t6
	jal 	pushToStack 	# push address of B to stack
	jal 	transposeMatrix 	# function call of to store transpose of A in B


	lw 		$t6, 0($sp) 		# load address of B in $t6
	addi 	$sp, $sp, 4 		# poping address B in stack
	sw 		$t6, 0($sp) 		# storing address of B in place of A
	lw 		$t0, 16($sp) 		# loading m in $t0
	lw 		$t1, 12($sp) 		# loading n in $t1
	sw 		$t0, 12($sp) 		# storing m in place of n in stack
	sw 		$t1, 16($sp) 		# storing n in place of m in stack

	li 		$v0, 4
	la 		$a0, printB 		# issue printB
	syscall 
	jal 	printMatrix 		# function call to print matrix 

	addi 	$sp, $sp, 20 		# poping all the values stored in stack

	lw 		$ra, 4($sp) 		# loading return address (which is initially stored in stack by initstack)
	lw 		$fp, 0($sp) 		# loading return address (which is initially sotred stack by initstack)
	addi 	$sp, $sp, 16 		# poping all elements from stack (including $ra and $fp)
	jr 		$ra 				# jump return


pushToStack:					# Takes a parameter element($a0) and push in to stack and updates the stack pointer
	addi 	$sp, $sp, -4
	sw 		$a0, 0($sp)
	j 		$ra 

malloc:							# size = m*n  
 								# size*4 is allocated to each matrix
 	lw 		$t1, 4($sp) 		# laod value from stack $t1 = 1 (or) $t1 = 0
	lw 		$a0, 0($sp) 		# load size in $a0 
	move	$a1, $sp	 		# move stack pointer address to $a1

 	subu 	$sp, $sp, 128 		# allocates space 128 in stack for saftey
 	mul 	$t1, $a0, $t1 		# $t1 = $a0*$t1 (if $t1 = 1 then $t1 = size)
 	mul 	$t1, $t1, 4 		# $t1 = 4*size
 	addu 	$t1, $t1, 16 		# $t1 = $t1+16 (+16 is for saftey)
 	sub 	$sp, $sp, $t1 		# subtracting stack pointer by $t1 (to allocate space for matrix B, to go beyond matrix A(which is also stored in stack) iam subtracing $t1 from stack)
	sw 		$ra, 4($sp) 		# storing return address in stack
	sw 		$fp, 0($sp) 		# storing frame pointer in stack
	addiu 	$fp, $sp, 12 		# initialize frame pointer for this fuction


	move 	$t4, $sp 			# moving stack pointer address to $t4


 	move 	$t7,$a0 			# move size($a0)  to $t7

 	for:
 		sub 	$t4, $t4, 4 	# allocting space form $t4 by loop of size m*n
 		addi 	$t7, $t7, -1
 		bne 	$t7, $zero, for
 
 	move 	$v0, $t4 			# move allocated address to $v0(for return)

 	lw 		$ra, 4($sp) 		# load return address from stack
	lw 		$fp, 0($sp) 		# load frame pointer from stack
	#add 	$sp, $sp, $t1 		
	#addi 	$sp, $sp, 120
	move 	$sp, $a1 			# move stack address which is previously stored in $a1
	jr 		$ra 				# jump return 

printMatrix:					# takes rowsize, column size and address of matrix
								# print in row major form
	lw 		$a1, 16($sp) 		# load rowsize in $a1
	lw 		$a2, 12($sp) 		# load column size in $a2
	lw	 	$s3, 0($sp) 		# load address of array in $s3
	addi 	$s0, $zero, 0 		# $s0(i) = 0 rowindex

	for3:
		addi	$s1, $zero, 0 		# $s1(j) = 0 columnindex 
		add 	$s2, $zero, $s0 	# $s2(index) = $s0(rowindex)
		mul 	$s2, $s2, $a2 		# $s2(index) *= $a2(column size)
		mul 	$s2, $s2, 4 		# $s2 *= 4
		add 	$s2, $s2, $s3 		# $s2 is now start address of ith row
		for4:
			li 		$v0, 1 			# print matrix[i][j]
			lw 		$a0, 0($s2)
			syscall 

			li 		$v0, 4 			# issue Sp 
			la 		$a0, Sp
			syscall

			addi 	$s2, $s2, 4 	# increment address of matrix by 4 for next index
			addi 	$s1, $s1, 1 	# incrementing j by 1
			bne 	$s1, $a2, for4 	# if j != columnsize goto for4

		li 		$v0, 4 			#issue newline
		la 		$a0, newline
		syscall

		addi 	$s0, $s0, 1 		# incrementing i by 1
		bne 	$s0, $a1, for3		# if i != rowsize goto for4

	jr 		$ra



transposeMatrix:					# takes m, n, addr(A) and addr(B) 
									# compute the B, B = Transepose(A)
	lw 		$t0, 20($sp) 			# load m in $t0
	lw 		$t1, 16($sp) 			# load n in $t1
	lw 		$t3, 4($sp) 			# load address of matrix A in $t3
	lw 		$t4, 0($sp) 			# load address of matrix B in $t4

	move 	$s1, $zero 				# $s1 is rowindex(i)

	fort1:
		move 	$s0, $zero 				# $s0 is columnindex(j)
		add 	$s2, $zero, $s1 		# $s2(index) = $s1(i)
		mul 	$s2, $s2, $t0 			# $s2(index) *= columnsize
		mul 	$s2, $s2, 4 			# $s2 *= 4
		add 	$s2, $s2, $t4 			# $s2 is the address of B[i][j]


		fort2: 
			add 	$s3, $zero, $s0  	# $s3(index for A) = $s0(i)
			mul 	$s3, $s3, $t1 		# $s3 *= rowsize(j) (for matrix A)
			add 	$s3, $s3, $s1 		# $s3 += columnsize(i)
			mul 	$s3, $s3, 4 		# $s3 *= 4
			add 	$s3, $s3, $t3	 	# $s3 is the address of A[j][i]

			lw 		$t7, 0($s3) 		# load A[j][i] in $t7
			sw 		$t7, 0($s2) 		# store value of A[j][i] in B[i][j]

			add 	$s2, $s2,4 			# increment address of matrix B by 4 for next index
			addi 	$s0, $s0, 1 		# incermtent j by 1
			bne 	$s0, $t0, fort2 	# if j != m then goto fort2

		addi 	$s1, $s1, 1 				# increment i by 1
		bne 	$s1, $t1, fort1 			# if i != n then goto fort1
	j 	$ra 					# return 


CheckPositive:
	addi 	$s1, $zero, 0
	sle 	$s1,$a0, $zero		# checking if number is non positive
	beq 	$s1, 1, Exit1 		# if so then exit program
	jr 		$ra

Exit1:
	li 		$v0, 4 			# prints error if input values are not positive
	la 		$a0, Eror
	syscall 
	j 		Exit

		
Exit:
	li 		$v0, 10
	syscall	 				# End program

