.data
V: .byte 1, (-4), (-5), 2
res: .space 1
.text
.globl main
main:
    lb $t1, V
    lb $t2, V+1
    slt $t1, $t1, $0
    slt $t2, $t2, $0
    and $t0, $t1, $t2
    lb $t1, V+2
    slt $t1, $t1, $0
    and $t0, $t0, $t1
    lb $t1, V+3
    slt $t1, $t1, $0
    and $t0, $t0, $t1
    sb $t0, res
    li $v0, 10
    syscall
.end