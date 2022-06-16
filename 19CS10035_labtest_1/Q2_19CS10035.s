#########################################################################################################
# lab test - 1
# question - 2
##########################################################################################################

########### data ###########
.data

	prompt1:	.asciiz "Enter 10 integers(one by one) : "
	Sp: 		.asciiz " "
	newline: 	.asciiz "\n"
	out : 		.asciiz "\nMax Heap: "
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


	addi 	$a0, $zero, 10			# to push size of array into the stack
	jal 	pushToStack


	jal 	Create_Max_Heap 		# fucntion call Create_Max_Heap

	li 		$v0, 4
	la 		$a0, out 			# issue sorted 
	syscall
	addi 		$a0, $zero , 10 		# size of the array in $a0
	la 		$a1, array  			# address of the array in $a1
	jal 	printArray 				# function call to print array 

	j 	Exit


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

Create_Max_Heap:
	sw 		$ra, -12($sp) 		# store returm address
	jal 		initStack

	lw 		$t2, 4($fp) 		# size
	addi 		$s0, $zero, 2
	div 		$t3, $t2, $s0 		# n/2
	addi 		$t3, $t3, -1		# start index 
	
	move 		$t4, $t3 		# i = startindex

	forC:
		 blt 		$t4, $zero, Ext
		 move 		$a0, $t2
		 jal 		pushToStack
		 move 		$a0, $t4
		 jal 		pushToStack
		 sw 		$t4, 0($fp)
		 jal 		Heapify
		 lw  		$t4, 0($fp)
		 addi  		$t4, $t4, -1
		 lw 		$t2, 4($fp) 		# size
		 j 	forC

	Ext:
		lw 		$ra, -8($fp) 		# restore return address
		addi 		$sp, $fp, 4 		# retore stack pointer to prevoius position
		lw 		$fp, -12($fp) 		# resotre prevoius frame pointer
		jr 		$ra 	 		# return 
		


Heapify:
	sw 		$ra, -12($sp) 		# store returm address
	jal 	initStack

	lw 		$t2, 8($fp) 		# size
	lw 		$t1, 4($fp) 		# index(i) 
#li $v0,1
#move $a0, $t1
#syscall
#li $v0, 4
#la $a0, newline
#syscall

	move 		$t3, $t1 		# largest
	addi 		$s0, $zero, 2 		# 2
	mul 		$t4, $s0, $t1 		# 2*i
	addi 		$t4, $t4, 1 		# l 
	addi 		$t5, $t4, 1 		# r
	
	bge 		$t4, $t2, IF1
	mul 		$t6, $t4, 4
	lw 		$s0, array($t6) 	# A[l]
	mul 		$t6, $t3, 4
	lw 		$s1, array($t6)  	# A[lar] 
	ble 		$s0, $s1, IF1
	move 		$t3, $t4 		# lar = l
	
	IF1:
	bge 		$t5, $t2, IF2
	mul 		$t6, $t5, 4
	lw 		$s0, array($t6) 	# A[r]
	mul 		$t6, $t3, 4
	lw 		$s1, array($t6)  	# A[lar] 
	ble 		$s0, $s1, IF2
	move 		$t3, $t5 		# lar = r
	
	IF2:
	beq 		$t3, $t1 , returnH		# lar != i
	la 		$a0, array  			# array add
	mul 		$t6, $t1, 4 			# i*4
	add 		$a1, $a0, $t6 			# addr of A[i]
	mul 		$t6, $t3, 4 			# lar*4
	add 		$a0, $a0, $t6, 			# addr of A[lar]
	jal 		SWAP
	move 		$a0, $t2
	jal 		pushToStack
	move 		$a0, $t3
	jal 		pushToStack
	jal 		Heapify
	
	returnH:
		lw 		$ra, -8($fp) 		# restore return address
		addi 		$sp, $fp, 4 		# retore stack pointer to prevoius position
		lw 		$fp, -12($fp) 		# resotre prevoius frame pointer
		jr 		$ra 				# return






Exit: 		 						# exit program
	lw 		$ra, -8($fp) 			# load return address before the start of the program
	jr 		$ra 					# return 

	li 		$v0, 10 
	syscall	 					# End program




