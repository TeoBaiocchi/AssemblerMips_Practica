.data
Vector: .byte 1, 2, 3, 4, 5, 10, 15, 20
Cant: .byte 8
Buscar: .byte 5
Resultado: .word 0
.text
.globl main
main:
    la $a0, Vector
    lb $a1, Cant
    lb $a2, Buscar
    jal funcion
   
    li $v0, 10
    syscall
.end

funcion:
    sge $t0, $a2, $0
    slt $t1, $a2, $a1
    and $t2, $t1, $t0
    beq $t2, $0, end1
    add $a0, $a0, $a2
    lb $v0, ($a0)
    sw $v0, Resultado
end1:
    jr $ra
.end