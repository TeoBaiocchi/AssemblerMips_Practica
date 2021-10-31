.data
rango1: .byte 10
rango2: .byte 50
Vector: .byte 1, 2, 3, 11, 20, 30, 40, 45, 60
cant: .byte 9
total: .word 0
.text
.globl main
main:
    lb $s0, rango1
    lb $s1, rango2
    li $s2, 1 # Guardo en s1 y s0 los valores de los rangos y en s2 1
    la $t0, Vector # Esto lo voy a ir iterando para avanzar en la lista, pero tengo que cargarlo dentro del loop
    lb $t2, cant # guardo la cantidad para el verificador
    li $t1, 0
loop1:
    lb $s4, ($t0)
    beq $s4, $t2, end1 # cuando el contador llegue al final de la lista, corta
    # esta parte verifica que este en el rango
    sge $t3, $s4, $s0
    sle $t4, $s4, $s1
    and $t5, $t4, $t3
    bne $t5, $s2, saltearVerificacion
    addi $s3, $s3, 1
saltearVerificacion:
    addi $t0, $t0, 1 # lista++
    addi $t1, $t1, 1 # contador++
    j loop1
end1:
    sw $s3, total
    li $v0, 10
    syscall
.end