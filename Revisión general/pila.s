.data
Vector: .byte 1, 10, 11, 2, 12, 13, 3, 14, 15, 4, 16, 17, 5, 18, 19
Dimension1: .byte 5 # n
Dimension2: .byte 3 # m
Buscar1: .byte 0 # i
Buscar2: .byte 2 # j
Resultado: .word 1
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
    addi $sp, $sp, -4 # guardo lugar para una palabra (4 bytes que ocupa la dimension de memoria) en la pila
    sw $t0, ($sp) # Guardo t0... en el sp aparentemente
    jal funcion
    sw $v0, Resultado
    li $v0, 10
    syscall
.end

funcion:
    lw $s0, ($sp)     # tomo lo que estaba guardado en la pila 
    addi $sp, $sp, 4  # y libero el espacio usado, una palabra
                      # ahora a0-a3 y s0 tienen mis cosas

    sge $t0, $a2, $0  # si $a2, buscar1, mayor o igual a 0, guarda 1 en t0
    slt $t1, $a2, $a0 # si $a2, buscar1, menor que la dimensión1 guarda 1 en t0 
    and $t2, $t1, $t0 # si ambas cosas son 1,  guarda 1 en $t2
    beq $t2, $0, end1
    # si NO se cumplen ambas condiciones, (si t2 y 0 son iguales) se termina el programa
    sge $t0, $a3, $0
    slt $t1, $a3, $a1
    and $t2, $t1, $t0
    beq $t2, $0, end1
                      # idem, y una vez completa la comprobación 
                      # hago el algoritmo de i * m + j
    mul $t0, $a2, $a1 # guardo en t0 la multiplicación de $a2 y $a1...
    add $t0, $t0, $a3 # la suma... en t0 tengo mi resultado de posicion
    add $s0, $s0, $t0 # tengo que sumarle ahora esa posición a la direccion de memoria
                    # que tengo guardada en s0, ahora eso es mi resultado
                    # tengo que traer eso, restaurar s0 por convención, y guardar el contenido 
                    # de v0 en la funcion principal
end1:
    lb $v0, ($s0)  # <- recordemos que l guarda en a, b <- y save al reves
    li $s0, 0
    jr $ra           # esto vuelve al jump and link
.end

