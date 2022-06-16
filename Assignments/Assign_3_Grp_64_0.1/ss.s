## Matthew Stanton
## Finds the value of sin(x)
## Register Use:
## $t0 value of n
## $f0 (Series*x^2)/(n(n-1))
## $f1 absolute value of (x^2)/(n(n-1))
## $f2 holds x^2
## $f3 holds remainders +or-(x^2)/(n(n-1))
## $f4 accuracey
## $f12 Holds sin(x)

.text
.globl main

main:
li $t0,3 # Initilize N
li.s $f4,1.0e-6 # Set Accuracey
li $v0,4 # syscall for Print String
la $a0, prompt1 # load address of prompt
syscall # print the prompt
li $v0,6 # Reads user number
syscall
mul.s $f2,$f0,$f0 # x^2
mov.s $f12,$f0 # Answer
for:
abs.s $f1,$f0 # compares to the non-negative value of the series
c.lt.s $f1,$f4 # is number < 1.0e-6?
bc1t endfor
subu $t1,$t0,1 # (n-1)
mul $t1,$t1,$t0 # n(n-1)
mtc1 $t1, $f3 # move n(n-1) to a floating register
cvt.s.w $f3, $f3 # converts n(n-1) to a float
div.s $f3,$f2,$f3 # (x^2)/(n(n-1))
neg.s $f3,$f3 # -(x^2)/(n(n-1))
mul.s $f0,$f0,$f3 # (Series*x^2)/(n(n-1))

add.s $f12,$f12,$f0 # Puts answer into $f12

addu $t0,$t0,2 # Increment n
b for # Goes to the beggining of the loop
endfor:
li $v0,2 # Prints answer in $f12
syscall
li $v0,10 # code 10 == exit
syscall # Halt the program.




.data
prompt1: .asciiz "Program will calculate sin(x). Please input a value for x!"