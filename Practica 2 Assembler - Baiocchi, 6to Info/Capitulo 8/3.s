.data
Vector: .byte 1, 10, 11, 2, 12, 13, 3, 14, 15, 4, 16, 17, 5, 18, 19
Dimension1: .byte 5 # n
Dimension2: .byte 3 # m
Buscar1: .byte 3 # i
Buscar2: .byte 1 # j
Resultado: .word 0
# en teoria, tiene que traer 16
# Reminder, i x m + j, es decir, Buscar1 * Dimension2 + 1 + Buscar2 
.text
.globl main
main:
    lb $a0, Dimension1
    lb $a1, Dimension2
    lb $a2, Buscar1
    lb $a3, Buscar2
    la $t0, Vector
    addi $sp, $sp, -4
    sw $t0, ($sp)
    li $v0, 0
    jal funcion
    sw $v0, Resultado
    li $v0, 10
    syscall
.end

funcion:
    lw $s0, ($sp)
    addi $sp, $sp, 4
    sge $t0, $a2, $0 
    slt $t1, $a2, $a0
    and $t2, $t1, $t0
    beq $t2, $0, end1

    sge $t0, $a3, $0
    slt $t1, $a3, $a1
    and $t2, $t1, $t0
    beq $t2, $0, end1

    mul $t0, $a2, $a1
    add $t0, $t0, $a3
    add $s0, $s0, $t0
    lb $v0, ($s0)
end1:
    jr $ra
.end