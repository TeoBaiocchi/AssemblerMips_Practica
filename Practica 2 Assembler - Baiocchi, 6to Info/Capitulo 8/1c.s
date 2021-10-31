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
    addi $sp, $sp, -6 # 4, la direccion del vector, y 2 bytes 
    sw $a0, 2($sp) 
    sb $a1, 1($sp) # fijate como me voy moviendo en bytes para guardar cosas en la pila
    sb $a2, ($sp) # Esto sería "lo primero", creo, y después me voy moviendo
    jal funcion

    lb $v1, ($sp)
    addi $sp, $sp, 1
    sw $v1, Total

    li $v0, 10
    syscall
.end
funcion:
    li $v0, 0 # ahora voy a tomar todo lo que necesito de la pila
    lw $s0, 2($sp) # direccion del vector
    lb $s1, 1($sp) # comparar
    lb $s2, ($sp) # cantidad
    addi $sp, $sp, 6 # La libero porque hay que hacerlo
loop1:
    beq $t0, $s2, end1 
    lb $t1, ($s0)
    bne $t1, $s1, saltarSuma
    addi $v0, $v0, 1 
saltarSuma:
    addi $t0, $t0, 1 
    addi $s0, $s0, 1 
    j loop1
end1:
    addi $sp, $sp, -1
    sb $v0, ($sp)
    jr $ra
.end
