.data  
.text
.globl main
main:

    li $v0, 5
    syscall
    add $t0, $t0, $v0

    li $v0, 5
    syscall
    add $t0, $t0, $v0

    move $t0, $a0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
.end 