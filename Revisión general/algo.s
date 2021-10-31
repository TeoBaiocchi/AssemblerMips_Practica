.data
Vector: .byte 5, 1, 2, 5, 4, 5, 6, 7, 8, 9, 10, 5
Dimension: .byte 12 # Cantidad de bytes, no posición
Buscar: .byte 5 # por el culo te la hinco
Resultado: .word 0
.text
.globl main
main:
    la $a0, Vector # No lleva parentesis acá, lleva cuando a la derecha
    lb $a2, Dimension 
    lb $a1, Buscar
    jal funcion
    sw $v0, Resultado 
    li $v0, 10
    syscall
.end


# Nota sobre la iteración, uso el $a0 para moverme dentro del vector por default,
# entonces, cargo (dentro del loop) el contenido de $a0 con 
funcion:
    li $t0, 0
    li $t2, 0 
loop:
    beq $t0, $a2, end1        # comparo, si el contador es igual a la dimensión me salgo.
    lb $t1, ($a0)
    bne $a1, $t1, saltearSuma # si NO es igual a lo que buscamos NO sumes
    addi $t2, $t2, 1
saltearSuma: 
    addi $t0, $t0, 1 # añado al contador
    addi $a0, $a0, 1 # añado a la direccion de memoria / me muevo sobre el vector
    j loop           # La logica del loop es que se hace con etiquetas.  Este j loop hace que se repita, hasta que llame a end1 para salirse
end1:
    move $v0, $t2    # copia el contenido de $t0 hacia $v0
    jr $ra           # esto vuelve al jump and link
.end

# lx a, b   carga B en A, puede ser inmediate, address, byte, word o half word
