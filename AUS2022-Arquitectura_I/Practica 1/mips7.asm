.data 0x10000000

    vector: .word 10, 20, 25, 500, 3

.text
.globl main

main:

    lw $s0, vector($0)
    lw $s1, vector+4($0)
    lw $s2, vector+8($0)
    lw $s3, vector+12($0)
    lw $s4, vector+16($0)