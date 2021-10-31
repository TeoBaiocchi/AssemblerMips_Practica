.data
V: .byte 0, 2, 3, 4, 0, 5, 0
cant: .byte 7 
total: .word 0
.text
.globl main
main:
    la $t2, V  
    li $t0, 0 # el contador
loop:
    lb $t1, cant
    beq $t0, $t1, end1 # cuando el contador llegue al final de la lista, corta saltando derecho a la etiqueta end1
    lb $t4, ($t2)
    beq $t4, $0, sumaTotal
    addi $t2, $t2, 1
    addi $t0, $t0, 1
    j loop
end1:
    sw $t3, total
    li $v0, 10
    syscall
.end


sumaTotal:
    addi $t3, $t3, 1
    addi $t2, $t2, 1
    addi $t0, $t0, 1
    j loop
.end