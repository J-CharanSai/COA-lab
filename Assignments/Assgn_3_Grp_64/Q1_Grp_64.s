#########################################################################################################
# Assignment 	: 4 (3rd MIPS assignment)
# Problem No. 	: 1
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
# 
# finding determinent of a matrix by recursive method
# used stack to dynamycally allocate the space for matrix as well as for submatrces
# for return value is returned as it will be loaded in to the stack at the the previous frame pointer
#
##########################################################################################################

########### data ###########
.data

	prompt1:	.asciiz "Enter three positive integers(n. a, r and m) : "
	final: 		.asciiz "\nFinal determinant of the matrix A is "
	elem: 		.asciiz "\nElements of A: \n"
	Sp: 		.asciiz " "
	newline: 	.asciiz "\n"

########### text ###########
.text 
.globl main


main:
	sw 		$ra, -16($sp)
	jal 	initStack

	li 		$v0, 4 				# issue prompt1
	la 		$a0, prompt1 
	syscall

	li 		$v0, 5 				# input from user -> n
	syscall 
	move 	$a0, $v0 			# To push into the stack
	jal 	CheckPositive
	jal 	pushToStack

	li 		$v0, 5 				# input from user -> a
	syscall 
	move 	$a0, $v0 			# To push into the stack
	jal 	CheckPositive
	jal 	pushToStack

	li 		$v0, 5 				# input from user -> r
	syscall 
	move 	$a0, $v0 			# To push into the stack
	jal 	CheckPositive
	jal 	pushToStack

	li 		$v0, 5 				# input from user -> m
	syscall 
	move 	$a0, $v0 			# To push into the stack
	jal 	CheckPositive
	jal 	pushToStack

	lw 		$a0, 12($sp) 		# load n

	jal 	malloc  			# malloc for matrix

	move	$t0, $sp 			# loading the address of the 2d array
	lw 		$t1, -20($fp) 		# n size for row 
	move 	$t2, $t1 			# n size for column
	lw 		$t3, -24($fp) 		# a in $t3
	lw 		$t4, -28($fp) 		# r in $t4
	lw 		$t5, -32($fp) 		# m

	move 	$s0, $zero 			# row index for loop(i)
	forA1:
		move 	$s1, $zero  		# column index for loop(j)
		add 	$s2, $zero, $s0 	# $s2 = rowindex
		mul 	$s2, $s2, $t2 		# $s2 *= column size
		mul 	$s2, $s2, 4 		# $s2 *= size of int
		add 	$s2, $s2, $t0 		# ith row start address

		forA2:
			move 	$t6, $t3  			# $t5 = ar^i
			mul 	$t3, $t3, $t4 		# ar^i * r
			div 	$t6, $t5 			# ar^i / m
			mfhi 	$t6 				# $t6 = ar^i mod m from HI
			sw 		$t6, 0($s2) 		# store in 2d array
			addi 	$s2, $s2, 4 		# point to next index 
			addi 	$s1, $s1, 1 		# j++
			bne 	$s1, $t2, forA2 	# if j != size of column

		addi 	$s0, $s0, 1 		# i++
		bne 	$s0, $t1, forA1 	# if i != size of row


	
	li 		$v0, 4 				# issue elem 
	la 		$a0, elem 
	syscall 

	move 	$a0, $t1 			# size of array in $a0 

	jal 	printMatrix 		# finction call to print matrix

	move 	$a0, $t1 			# size of matrix
	jal 	pushToStack 		# push size into the stack

	#li 		$v0, 5
	#syscall

	jal 	recursive_Det 		# function call to find |A|

	li 		$v0, 4
	la 		$a0, final 			# print final
	syscall

	li 		$v0, 1
	lw 		$a0, 0($fp) 		# load retuned value by recursive_Det
	syscall

	j 		Exit

CheckPositive:
	move 	$s0, $zero
	sgt 	$s0, $a0, $zero
	beq 	$s0, $zero, Exit
	jr 		$ra

initStack:
	subu 	$sp, $sp, 20 		# stack frame is 16 bytes long
	sw 		$fp, 0($sp) 		# save old pointer
	addiu 	$fp, $sp, 16 		# set up frame pointers
	jr 		$ra 				# return 

pushToStack:
	subu 	$sp, $sp, 4 		# space to push eleinto the stack
	sw 		$a0, 0($sp) 		# push element into the stack
	jr 		$ra 				# return

popFromStack:
	lw 		$v0, 0($sp) 		# loading 1st ele of stack
	addiu 	$sp, $sp, 4 		# increasing stack pointer
	jr 		$ra 				# return

printMatrix:
	move 	$t1, $a0	 		# size(n) of a matrix
	move	$t2, $t1 	 		# column size in $t2
	move 	$t3, $sp 		# load address of array in $t3
	addi 	$t0, $zero, 0 		# $t0(i) = 0 rowindex

	forR:
		addi	$t4, $zero, 0 		# $t4(j) = 0 columnindex 
		add 	$t5, $zero, $t0 	# $t5(index) = $t0(rowindex)
		mul 	$t5, $t5, $t2 		# $t5(index) *= $t2(column size)
		mul 	$t5, $t5, 4 		# $t5 *= 4
		add 	$t5, $t5, $t3 		# $t5 is now start address of ith row
		forC:
			li 		$v0, 1 			# print matrix[i][j]
			lw 		$a0, 0($t5)
			syscall 

			li 		$v0, 4 			# issue Sp 
			la 		$a0, Sp
			syscall

			addi 	$t5, $t5, 4 	# increment address of matrix by 4 for next index
			addi 	$t4, $t4, 1 	# incrementing j by 1
			bne 	$t4, $t2, forC 	# if j != columnsize goto for4

		li 		$v0, 4 				#issue newline
		la 		$a0, newline
		syscall

		addi 	$t0, $t0, 1 		# incrementing i by 1
		bne 	$t0, $t1, forR		# if i != rowsize goto for4

	jr 		$ra

malloc:
 	sw 		$ra, -16($sp)  		# storing return address into the stack
	jal 	initStack 			# initializing the stack

	move	$a1, $a0 			# size of matrix
	mul 	$a1, $a1, $a1 		# size = n * n

	forM: 
		move 	$a0, $zero 		 	# $a0 = 0 
		jal 	pushToStack 		# increase stack pointer
		addi 	$a1, $a1, -1 		# size - 1
		bgt 	$a1, $zero, forM 	# loop until allocated size = n*n

	lw 		$ra, -12($fp) 		# restore return address
	lw 		$fp, -16($fp) 		# resotre prevoius frame pointer
	jr 		$ra 				# return

recursive_Det:
	sw 		$ra, -16($sp) 		# store returm address
	jal 	initStack

	lw 		$t0, 4($fp) 		# size of the matrix
	addi	$t1, $fp, 8			# address of the matrix

	addi 	$s0, $zero, 2 		# $s0 -> 2
	bne 	$s0, $t0, not_2 	# if size if not equal to 2

						 		# if 2x2 mat is of form a b
								#						c d
	lw  	$t2, 0($t1) 		# a
	lw	 	$t3, 4($t1) 		# b
	lw 		$t4, 8($t1) 		# c
	lw 		$t5, 12($t1) 		# d

	mul 	$t2, $t2, $t5 		# ad
	mul 	$t3, $t3, $t4 		# bc
	sub 	$s0, $t2, $t3 		# ad-bc
	j 		returnFD 			# reutrn det


	not_2: 	 
		addi 	$a0, $t0, -1 		# $a0 = n-1
		jal 	malloc 				# allocate space to n-1*n-1 matrix
		move 	$t2, $sp 			# address of n-1 sized matrix
		addi 	$a0, $t0, -1 		# n-1
		jal 	pushToStack 		# push n-1 to stack

		move 	$s0, $zero 			# $s0 = 0
		sw 		$s0, -4($fp) 		# this stack address is using to store det
		sw 		$s0, -8($fp) 		# this for i (column) for loop

		lw 		$s1, -8($fp) 		# load value !i -> ith index which is not included

	forn_2:
		addi 	$t2, $sp, 4			# n-1 sized matrix address
		lw 		$t0, 4($fp) 		# size of the matrix
		addi	$t1, $fp, 8			# address of the matrix

		bge 	$s1, $t0, returnD


		addi 	$s3, $zero, 1		# $s3 => 1 	(i)

		for_1:
			move  	$s4, $zero 			# j
			add 	$s5, $zero, $s3 	# $s5 -> rowindex
			mul 	$s5, $s5, $t0 		# $s5 *= columnsize
			mul 	$s5, $s5, 4 		# *size of int 
			add 	$s5, $s5, $t1 		# address of ith column on n sized matrix(A_n)

			for_2:
				beq 	$s4, $s1, not_i 	# dont include i
				lw 		$t7, 0($s5) 		# load value of A[i][j]
				sw 		$t7, 0($t2) 		# store value in A_n-1
				addi 	$t2, $t2, 4 		# increment to next index
				not_i:
					addi 	$s5, $s5, 4 		# incerment to next index of A_n
				addi 	$s4, $s4, 1 		# j++
				bne 	$s4, $t0, for_2 	# loop if j != n
			addi 	$s3, $s3, 1
			bne 	$s3, $t0, for_1			

		addi 	$s1, $s1, 1 		# increment(!i)
		sw 		$s1, -8($fp) 		# store !i in stack

		jal 	recursive_Det 		# function call for |A_n-1|

		lw 		$s1, -8($fp) 		# load i

		addi 	$s6, $zero, 2
		div 	$s1, $s6  			# check if i is even or not
		mfhi 	$s6 				# i % 2
		addi 	$s7, $zero, -1 		# $s7 = -1
		sne 	$s7, $s6, $zero 	# $s7 = 1 if i is odd
		bne 	$s7, $zero, T
		addi 	$s7, $zero, -1 

		T:
		add 	$a1, $zero, $s1 	# i
		addi 	$a1, $a1, -1 		# i-1
		mul 	$a1, $a1, 4 		# *4
		addi	$t1, $fp, 8			# address of the matrix
		add  	$a1, $a1, $t1 		# address of A[0][i-1]
		lw 		$a1, 0($a1) 		# A[0][i-1]
		lw 		$a0, 0($fp) 		# laod M_ij
		mul 	$a0, $a0, $s7 		# -1^(i+j) * M_ij
		mul 	$a0, $a0, $a1 		# *A[i][j]
		lw 		$a1, -4($fp) 		# load existing value 
		add 	$a0, $a0, $a1 		# adding $a0 to previous value
		sw 		$a0, -4($fp) 		# store in stack
		j 		forn_2 				# jump to forn_2


	returnD:
		lw 		$ra, -12($fp) 		# restore return address
		addi 	$sp, $fp, 4 		# retore stack pointer to prevoius position
		lw 		$s0, -4($fp) 		# load det
		lw 		$fp, -16($fp) 		# resotre prevoius frame pointer
		sw 		$s0 , 0($fp)	 	# store det value in prevoius frame
		jr 		$ra 				# return

	returnFD:
		lw 		$ra, -12($fp) 		# restore return address
		addi 	$sp, $fp, 4 		# retore stack pointer to prevoius position
		lw 		$fp, -16($fp) 		# resotre prevoius frame pointer
		sw 		$s0 , 0($fp)	 	# store det value in prevoius frame
		jr 		$ra 				# return

Exit: 		 						# exit program
	#lw 		$ra, -12($fp)
	#j 		$ra
	li 		$v0, 10 
	syscall	 					# End program

