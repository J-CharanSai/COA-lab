#########################################################################################################
# Assignment 	: 3
# Problem No. 	: 2
# Semester No. 	: 5
# Group No.	 	: 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
# 
# Taking the 10 inputs one by one from user and storing in a array(MyArray) and value k > 0 and < 10
# sorting the array by calling sort_array finction
# printing the sorted array 
# then printing the kth largest integer form the array
##########################################################################################################

########### data ###########
.data

	prompt1:	.asciiz "Enter 10 integers one at a time \n"
	prompt2:	.asciiz "Enter the value k: "
	Eror:		.asciiz "Invalid input \n"
	sortedarr:	.asciiz "sorted array: "
	result:		.asciiz "kth largest number is: "
	newline: 	.asciiz "\n"
	Sp: 		.asciiz " "
	MyArray:	
		.align 2
		.space 40

########### text ###########
	.text 
	.globl main

# main program
# program variables
# k : 	$t1

main:
	li 		$v0, 4					#issue prompt1
	la 		$a0, prompt1
	syscall

	addi 	$t0, $zero, 0 			# initializing index for MyArray to 0

	while1: 						# 10 loops for 10 user inputs 
		beq 	$t0, 40, continue 	# check if while1 completed 10th loop, if so branch to continue
		li 		$v0, 5				# storing input value in v0
		syscall
		move 	$s0, $v0			# storing integer value in $s0
		sw 		$s0, MyArray($t0) 	# stroing $s0 in MyArray
		addi 	$t0, $t0, 4 		# incrementing $t0 by 4
		j 		while1 				# jump to while1 

	continue: 						# after inputs are taken from user

	li 		$v0, 4 					# issue prompt2 
	la 		$a0, prompt2 
	syscall 

	li 		$v0, 5 					# value of k in $v0 
	syscall 

	move 	$t1, $v0 				# $v0 <-- $t1
	move 	$a0, $t1 				# $a0 <-- $t1 argument for the following function
	jal 	Check 					# check if k >0 and < n(10)


	jal 	sort_array 				# fuction call sort_array

	returnhere:
	li 		$v0, 4 					# issue sortedarr
	la 		$a0, sortedarr
	syscall 					
	addi 	$t2, $zero, 0 			# $t2 = 0 (for loop)
	la 		$s7, MyArray 			# load address of MyAarray in $s7

	while:
		beq 	$t2, 10, prntk 		# branch if it loops 10 times ($t2 = 10)
		li 		$v0, 4 				# issue Sp 
		la 		$a0, Sp
		syscall 
		li 		$v0, 1 				# to print an integer
		lw 		$a0, 0($s7) 		# print Elements the array
		syscall 
		addi 	$t2, $t2, 1 		# incrementing $t2 by 1
		addi 	$s7, $s7, 4 		# incrementing $s7 address of MyArray by 4 to next integer in the array
		j 		while 				# jump to while

	prntk:
		li 		$v0, 4 				# issue newline
		la 		$a0, newline
		syscall
		li 		$v0, 4 				# issue result
		la 		$a0, result
		syscall
		addi 	$t2, $zero, 40 		# $t2 = 40 
		mul 	$t3, $t1, 4 		# $t3 = k*4 
		sub 	$t2, $t2, $t3 		# $t2 = 40 - $t3(k*4) , kth index form last
		la 		$s7, MyArray 		# load address of MyArray in $s7 
		add 	$s7, $s7, $t2 		# $s7 = $s7 + $t2 , index  of kth largest interger 
		li 		$v0, 1 				# to print
		lw 		$a0, 0($s7) 		# print kth largest integer of the array
		syscall
		j 		Exit  				# jump to Exit 

		

	j 		Exit

sort_array:
	addi 	$t2, $zero, 1    			# start of loop j = 1
	addi 	$s1, $zero, 10 				# $s1(n) = 10
	for:
		bge		$t2, $s1, returnhere 	# if j>=n return 
		mul 	$s2, $t2, 4 			# $s2(index) = $t2*4
		la 		$s7, MyArray
		add 	$s7, $s7, $s2
		lw	 	$t3, 0($s7)		 		# %t3(temp) = A[j]
		addi 	$t4, $t2, -1 			# $t4(i) = $t2(j) - 1
		start:
		move 	$s3, $zero 				# $s3 = 0
		sle 	$s3, $zero, $t4 		# $s3 = 1 if 0<= i($t4)
		beq 	$s3, $zero, nowhile 	# if i < 0 then goto nowhile
		mul 	$s2, $t4, 4 			# $s2(index) = $t4(i)*4
		lw 		$t5, -4($s7)			# $t5 = A[i]
		slt 	$s3, $t3, $t5 			# $s3 = 1 if temp($t3) < A[i]($t5)
		beq 	$s3, 1, while2 			# if temp<A[i] && i >= 0 enter while
		nowhile: 		
		mul 	$a0, $t4, 4 			# $a0(index) = i
		addi 	$a0, $a0, 4 			# $a0 = i+1
		sw 		$t3, MyArray($a0) 		# A[i+1] = temp
		addi 	$t2, $t2, 1 			# increment j
		j 		for 					#goto for loop
	jr 		$ra


while2:
	mul 	$a0, $t4, 4 				# $a0(index) <-- $t4(i)*4
	addi 	$a0, $a0, 4 				# $a0(i+1) = $a0 + 4
	sw 		$t5, MyArray($a0) 			# storeword in MyArray, A[i+1] = $t5(A[i])
	addi 	$t4, $t4, -1 				# i = i - 1
	addi 	$s7, $s7, -4 				# $s7 = $s7 - 4, decresing address of the array
	j 	 	start 						# jump to start


Check:
	addi 	$s1, $zero, 10 				# $s1 = 10
	bge		$a0, $s1, Exit1 			# if $a0(k) >= 10, branch to Exit1
	ble 	$a0, $zero, Exit1			# if $a0(k) <= 0 , branch to Exit1
	jr 		$ra 						# jump return
		

Exit1:								
	li 		$v0, 4 						# issue Eror
	la 		$a0, Eror 					# error if invalid input is given
	syscall 
	j 		Exit 						# jump to exit

		
Exit: 									# exit function
	li 		$v0, 10 
	syscall	 							# End program