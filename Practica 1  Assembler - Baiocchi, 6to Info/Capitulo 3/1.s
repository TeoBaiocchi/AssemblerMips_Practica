.data 0x10000000

vector: .word 10, 20, 25, 500, 3

.text
main:
    lw $s0, vector
    lw $s1, vector+4
    lw $s2, vector+8
    lw $s3, vector+12
    lw $s4, vector+16

    li $v0, 10
    syscall
.end