#########################################################################################################
# lab Test - 1
# Q1
##########################################################################################################

########### data ###########
.data

	
input: .space 100
text: .asciiz "text : "
S: .asciiz "\nShift: "
ED: .asciiz "\nE/D : "
newline: .asciiz "\n"

########### text ###########
.text 
.globl main

main:
    li $v0, 4
    la $a0, text
    syscall
    li $v0, 8
    li $a1, 100
    la $a0, input
    syscall

    #li $v0, 4
    li $t0, 0

loop:
    lb $t1, input($t0)
    addi $s0, $zero, 10
    beq $t1, $s0, He
    H:
    beq $t1, 0, exitL
    blt $t1, 'a', case
    bgt $t1, 'z', case
    sub $t1, $t1, 32
    sb $t1, input($t0)
case: 
    addi $t0, $t0, 1
    j loop
He:
	sb $zero, input($t0)
	j 	H

exitL:
    li $v0, 4
    la $a0, S
    syscall
    li $v0, 5
    syscall 
    move $t3, $v0 
    li $v0, 4
    la $a0, ED
    syscall
    li $v0, 12 
    syscall
    move $t4, $v0
    li $t0, 0
    beq $t4, 'D' , Decrypt
    beq $t4, 'E' , Encrypt
    j 	exite

Decrypt:
    lb $t1, input($t0)
    beq $t1, 0, exit
    add $t5, $t1, $zero
    sub $t5, $t5, 'A'
    sub $t5, $t5, $t3
    blt $t5, $zero, LL
    C:
    li $a0, 26
    div $t5, $a0
    mfhi $t5
    add $t5, $t5, 'A'
    sb $t5, input($t0)
    addi $t0, $t0, 1
    j Decrypt
Encrypt:
    lb $t1, input($t0)
    beq $t1, 0, exit
    add $t5, $t1, $zero
    sub $t5, $t5, 'A'
    add $t5, $t5, $t3
    li $a0, 26
    div $t5, $a0
    mfhi $t5
    add $t5, $t5, 'A'
    sb $t5, input($t0)
    addi $t0, $t0, 1
    j Encrypt
LL: 
	bge 	$t5, $zero, C
	addi 	$t5, $t5, 26
	j LL
	

exit:
    li $v0, 4
    la $a0, newline 
    syscall
    li $v0, 4
    la $a0, input
    syscall

    li $v0, 10
    syscall

exite:
	li $v0, 10
	syscall
