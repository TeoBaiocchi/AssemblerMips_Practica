.data 0x10000000

vector: .word 10, 20, 25, 500, 3

.data 0x10010000
vectorCopia: .word 0, 0, 0, 0, 0

.text
main:
    lw $s0, vector
    lw $s1, vector+4
    lw $s2, vector+8
    lw $s3, vector+12
    lw $s4, vector+16

    sw $s0, vectorCopia
    sw $s1, vectorCopia+4
    sw $s2, vectorCopia+8
    sw $s3, vectorCopia+12
    sw $s4, vectorCopia+16

    li $v0, 10
    syscall
.end