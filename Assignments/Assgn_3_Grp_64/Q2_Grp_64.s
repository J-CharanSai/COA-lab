#########################################################################################################
# Assignment 	: 4 (3rd MIPS assignment)
# Problem No. 	: 2
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
# 
# sorts the array by recursive function and prints the sorted array in console
# 
##########################################################################################################

########### data ###########
.data

	prompt1:	.asciiz "Enter 10 integers(one by one) : "
	sorted: 	.asciiz "\nSorted array :\n"
	Sp: 		.asciiz " "
	newline: 	.asciiz "\n"
	array:	
		.align 2
		.space 40

########### text ###########
.text 
.globl main


main:
	sw 		$ra, -12($sp)  		# storing return address into the stack
	jal 	initStack 			# initializing the stack

	addi 	$t0, $zero, 10 		# size of the array
	la 		$s0, array 			# load address of array to $s0

	li 		$v0, 4
	la 		$a0, prompt1 		# issue prompt1
	syscall

	forI:
		li 		$v0, 5 				# user input 
		syscall
		sw 		$v0, 0($s0) 		# store number inn array 
		addi 	$s0, $s0, 4 		# incrementing to next elements address
		addi 	$t0, $t0, -1  		# decrementing $t0 by 1
		bgt 	$t0, $zero, forI 	# loop if $t0 > 0

	la 		$a0, array  		# to push address of the array into the stack
	jal 	pushToStack
	move 	$a0, $zero 			# to push left index of array into the stack
	jal 	pushToStack  
	addi 	$a0, $zero, 9		# to push right index of array into the stack
	jal 	pushToStack


	jal 	recursive_sort  	# fucntion call to sort the array

	li 		$v0, 4
	la 		$a0, sorted 		# issue sorted 
	syscall
	addi 	$a0, $zero , 10 	# size of the array in $a0
	la 		$a1, array  		# address of the array in $a1
	jal 	printArray 			# function call to print array 
	j 		Exit



initStack:
	subu 	$sp, $sp, 16 		# stack frame is 32 bytes long
	sw 		$fp, 0($sp) 		# save old pointer
	addiu 	$fp, $sp, 12 		# set up frame pointers
	jr 		$ra

pushToStack:
	subu 	$sp, $sp, 4 		# space to push into the stack 
	sw 		$a0, 0($sp) 		# pushing $a0 into the stack
	jr 		$ra

SWAP:
	lw 		$s4, 0($a0) 		# $a0 -> address of a element 
	lw 		$s5, 0($a1) 		# $a1 -> address of another element
	sw 		$s4, 0($a1) 		# storing $a0 element in $a1
	sw 		$s5, 0($a0) 		# storing previous $a1 element in $a0
	jr 		$ra

printArray:
	move 	$s4, $a0 			# size of the array
	move 	$s5, $a1 			# address of array 
	forP:
		li 		$v0, 1
		lw 		$a0, 0($s5) 		# print element in console
		syscall
		li 		$v0, 4
		la 		$a0, Sp 			# print space
		syscall 
		addi 	$s5, $s5, 4 		# increment size of the array to next element
		addi 	$s4, $s4, -1 		# decrement size by -1
		bgt 	$s4, $zero, forP 	# if $s4 > 0 loop and print
	li 		$v0, 4
	la 		$a0, newline 		# print newline
	syscall  
	jr 		$ra 				# return 


recursive_sort:
	sw 		$ra, -12($sp) 		# store returm address
	jal 	initStack

	lw 		$t0, 12($fp)  		# address of the array 
	lw 		$t1, 8($fp)	 		# left index value
	lw 		$t2, 4($fp) 		# right index value 

	move 	$t3, $t1 			# making a copy of $t1(left index)
	move 	$t4, $t2 			# making a copy of $t2(right index)

	while:
		move 	$s0, $zero  		# $s0 -> 0 
		slt 	$s0, $t3, $t4 		# $s0 = 1 if l < r 
		beq 	$s0, $zero, return 	# is while loop condition is incorrect then goto return

		while_1:
			add 	$t6, $zero, $t1 		# left index(p)
			mul 	$t6, $t6, 4 			# $t6 * size of int
			add 	$t6, $t6, $t0 			# A[p] address

			add 	$t7, $zero, $t3 		# left index(l)
			mul 	$t7, $t7, 4 			# $t7 * size of int
			add 	$t7, $t7, $t0 			# address of A[l]
			lw 		$s0, 0($t7) 			# A[l]
			lw 		$s1, 0($t6) 			# A[p]
			bgt 	$s0, $s1, while_2 		# if A[l] > A[p] goto while_2
			bge 	$t3, $t2, while_2 		# if l >= right goto while_2 
			addi 	$t3, $t3, 1 			# l++
			j 		while_1
		while_2:
			add 	$t6, $zero, $t1 		# left index(p)
			mul 	$t6, $t6, 4 			# $t6 * size of int
			add 	$t6, $t6, $t0 			# A[p] address

			add 	$t7, $zero, $t4 		# right index(r)
			mul 	$t7, $t7, 4 			# $t7 * size of int
			add 	$t7, $t7, $t0 			# address of A[r]
			lw 		$s0, 0($t7) 			# A[r]
			lw 		$s1, 0($t6) 			# A[p]			

			blt 	$s0, $s1, IF 			# A[r] < A[p] goto IF
			ble 	$t4, $t1, IF 			# if r <= left goto IF 
			addi 	$t4, $t4, -1 			# r--
			j 		while_2
		IF:
		 	blt 	$t3, $t4, HERE 			# if l < r goto HERE
		 	add 	$t6, $zero, $t1 		# left index(p)
			mul 	$t6, $t6, 4 			# $t6 * size of int
			add 	$t6, $t6, $t0 			# A[p] address
		 	move 	$a0, $t6 				# address of A[p]
		 	add 	$t7, $zero, $t4 		# right index(r)
			mul 	$t7, $t7, 4 			# $t7 * size of int
			add 	$t7, $t7, $t0 			# address of A[r]
			move 	$a1, $t7 				# argument to swap
		 	jal 	SWAP  					# swap A[p] & A[r]

		 	sw 		$t4, 0($fp) 			# store r in stack


		 	la 		$a0, array  			# to push address of the array into the stack
			jal 	pushToStack
			move 	$a0, $t1 				# to push left index(left) of array into the stack
			jal 	pushToStack  
			sub 	$a0, $t4, 1				# to push right index(r-1) of array into the stack
			jal 	pushToStack

			jal 	recursive_sort

			lw 		$t2, 4($fp)	 			# right index value from stack 	
			lw 		$t4, 0($fp) 			# loading stored r value form stack 

			la 		$a0, array  			# to push address of the array into the stack
			jal 	pushToStack 
			addi 	$a0, $t4, 1				# to push left index(r+1) of array into the stack
			jal 	pushToStack
			move 	$a0, $t2 				# to push right index(right) of array into the stack
			jal 	pushToStack 

			jal  	recursive_sort

		 	j 		return 


		HERE:
		add 	$a0, $zero, $t3 		# right index(l)
		mul 	$a0, $a0, 4 			# $a0 * size of int
		add 	$a0, $a0, $t0 			# address of A[r]
		add 	$a1, $zero, $t4 		# right index(r)
		mul 	$a1, $a1, 4 			# $a1 * size of int
		add 	$a1, $a1, $t0 			# address of A[r]
		jal 	SWAP
		j 		while 
	return:
		lw 		$ra, -8($fp) 		# restore return address
		addi 	$sp, $fp, 4 		# retore stack pointer to prevoius position
		lw 		$fp, -12($fp) 		# resotre prevoius frame pointer
		jr 		$ra 				# return





Exit: 		 						# exit program
	#lw 		$ra, -8($fp) 			# load return address before the start of the program
	#jr 		$ra 					# return 

	li 		$v0, 10 
	syscall	 					# End program

