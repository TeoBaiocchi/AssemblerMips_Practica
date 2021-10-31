.data
Vector: .byte 3, 1, 2, 3, 4, 5, 3
Comparar: .byte 3
Cant: .byte 7
Total: .word 0
.text
.globl main
main:
    la $a0, Vector
    lb $a1, Comparar
    lb $a2, Cant
    jal funcion
    sw $v0, Total

    li $v0, 10
    syscall
.end

funcion:
    li $v0, 0
loop1:
    beq $t0, $a2, end1 # t0 es el contador
    lb $t1, ($a0)
    bne $t1, $a1, saltarSuma
    addi $v0, $v0, 1 # solo añado al resultado si son iguales el contenido de t1 con el numero a comparar
    saltarSuma:
    addi $t0, $t0, 1 # añado al contador
    addi $a0, $a0, 1
    j loop1
end1:
    jr $ra
.end