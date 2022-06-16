#########################################################################################################
# Assignment    : 3
# Semester No.  : 5
# Group No.     : 64
# Names of group Members : 1. Jatoth Charan Sai , 2. Tirupathi Suguna Bhaskar
# 
# As sin(x) = x-(x^3/3!)+(x^5/5!)-(x^7/7!)+......
# adding term by term to the answer until it reaches its precision 10^-e (error bound)
#
##########################################################################################################

########## data ###########
.data
    prompt1:    .asciiz "\nEnter the value of x: "
    prompt2:    .asciiz "\nEnter the value of e: "
    result:     .asciiz "\nValue of sin(x): "


########## text ############
.text
.globl main

main:
    li          $v0,4               # issue prompt1
    la          $a0, prompt1
    syscall

    li          $v0,6               # input form user (x)
    syscall

    mov.s      $f6, $f0             # $f6 <-- x


    li.s        $f5,100.00           # loading 100.00 in $f5
    mul.s       $f6,$f6,$f5         # multiplying (x)$f6 by 100
    cvt.w.s     $f6,$f6             # converting $f6 to word

    cvt.s.w     $f6,$f6             # converting $f6 to float

    div.s       $f6,$f6,$f5         # dividing $f6 by 100.00 (now x is rounded upto 2 decimal points)


    mov.s       $f12,$f6            # $f12 <-- $f6(x)
    mul.s       $f4,$f6,$f6         # $f4 = x*x

    li          $v0, 4              # issue prompt2
    la          $a0, prompt2
    syscall

    li          $v0, 5              # input from user(e)
    syscall

    li.s        $f10, 1.0           # $f10 = 1.0 ,($f10 is for error bound)
    li.s        $f5, 10.0           # $f5 = 10.0

    addi        $t0, $zero, 3       # n for denominator for the series

    for1: 

        div.s       $f10, $f10, $f5       # $f10 = $f10/10 (for e times)

        addi        $v0, $v0, -1        # e = e-1
        bne         $v0, $zero, for1    # if e != 0 goto for1

    for:
        subu        $t1,$t0,1        # $t1 = (n-1)
        mul         $t1,$t1,$t0      # $t1 = n(n-1)
        mtc1        $t1, $f8         # move to float register
        cvt.s.w     $f8, $f8         # make n(n-1) a float
        div.s       $f8,$f4,$f8      # (x^2)/(n(n-1))
        neg.s       $f8,$f8          # -(x^2)/(n(n-1))
        mul.s       $f6,$f6,$f8      # ans *(x^2)/(n(n-1))

        add.s       $f12,$f12,$f6    # answer($f12) = $f12 + $f6

        addu        $t0,$t0,2        # Increment n by 2 
        abs.s       $f2,$f6          # compares to the non-negative value of the series
        c.le.s      $f2,$f10         # is number > 1.0e-6?
        bc1f        for              # if not then loop

    li          $v0, 4           # issue result
    la          $a0, result
    syscall
    li          $v0,2            # Prints answer in $f12
    syscall
    li          $v0,10           # code 10 == exit
    syscall                      # Exit program.
