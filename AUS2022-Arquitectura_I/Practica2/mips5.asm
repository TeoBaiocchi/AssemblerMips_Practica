.data
	datos: .byte 1, 0, 2, 0, 3, 0, 4, 0, 5, 0
	.align 2
	cantidad: .byte 10
	.align 2
	res: .byte 0

.text
.globl main
main:
	
	lb $t1, cantidad($0)
	li $t0, 0
	li $s0, 0 #res
	
	loop:
	beq $t0, $t1, finLoop
	lb $t2, datos($t0)
	beqz $t2, encontrarCero
	seguir:
	addi $t0, $t0, 1
	j loop
	finLoop:
	
	sb $s0, res($0)
	j fin
	
encontrarCero:
	addi $s0, $s0, 1
	j seguir
			
fin:	
    li $v0, 10
    syscall
.end

#Diseña un programa en ensamblador que dado un vector de enteros,
#obtenga como resultado cuántos elementos son iguales a cero. Este
#resultado se debe almacenar sobre la variable “total”. El programa deberá
#inicializar los elementos del vector en memoria, así como una variable que
#almacenará el número de elementos que tiene el vector y reservará espacio
#para la variable resultado.
