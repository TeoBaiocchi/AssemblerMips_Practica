.data 0x10000000
numero: .word 2147483647
.text
main:
    lw $t0, numero
    lw $t1, numero
    add $t2, $t0, $t1
    li $v0, 10
    syscall
.end
