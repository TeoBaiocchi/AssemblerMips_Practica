.data
	datos: .byte 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
	.align 2
	cantidad: .byte 10
	.align 2
	rango: .byte 25, 75
	.align 2
	res: .byte 0

.text
.globl main
main:
	

	lb $t0, rango($0) #contador arranca desde el principio del rango
	lb $t1, rango+1($0)
	li $s0, 0 #Resultado
	
	
	lb $t4, cantidad($0) #rango max segundo for
	
	loop:
	beq $t0, $t1, finLoop #si contador = fin del rango, fin del loop
	#lb $t2, 0($t0)  #t2 tiene el numero actual del loop, para comparar con cada elemento del segundo loop
	
	li $t3, 0	#contador del segundo for
		loop2:  
		beq $t4, $t3, finLoop2
		lb $t5, datos($t3)
		beq $t0, $t5, encontroUno
		seguir:
		addi $t3, $t3, 1 #Sube t3 hasta "cantidad"
		j loop2
		finLoop2:
	
	addi $t0, $t0, 1
	j loop
	finLoop:
	j fin
	
encontroUno:
	addi $s0, $s0, 1
	j seguir
fin:	
    sb $s0, res($0)
    li $v0, 10
    syscall
.end


#Diseña un programa en ensamblador que dado un vector de enteros “V”
#obtenga cuántos elementos de este vector están dentro del rango
#determinado por dos variables “rango1” y “rango2”. El programa deberá
#inicializar los elementos del vector en memoria, una variable que
#almacenará el número de elementos que tiene ese vector y dos variables
#donde se almacenarán los rangos. También deberá reservar espacio para la
#variable resultante.