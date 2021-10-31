.data 0x10000000
V: .word 10, 20
resultado: .word 0

.text
main:

    lw $s0, V
    lw $s1, V+4

    add $s2, $s0, $s1

    sw $s2, resultado

    li $v0, 10
    syscall
.end