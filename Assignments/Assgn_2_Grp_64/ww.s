.data

	prompt:		.asciiz "Enter the positive integer: "
.text 
	.globl main

main:
		li 		$v0, 4				
		la 		$a0, prompt
		syscall
		
		addi 		$t0, $0, 36
		addi 		$t1, $0, 45
		addi 		$t2, $0, 84
loop: 		beq $t1, $0, Exit
		div $t1, $t1
		move $t0, $t1
		mfhi $t1
		j loop
Exit:
		li 		$v0, 10 
		syscall	 					

