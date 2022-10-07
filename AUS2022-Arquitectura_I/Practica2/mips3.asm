.data
	.align 2
#	vector: .byte -1, -4, -5, -2
	vector: .byte 1, -4, -5, 2
#Cambiar de vector para cambiar de resultado
	.align 2
	res: .byte 0
.text
.globl main
main:
		
	lb $t0, vector($0)
	lb $t1, vector+1($0)
	lb $t2, vector+2($0)
	lb $t3, vector+3($0)
	
	bgez $t0, fin
	bgez $t1, fin
	bgez $t2, fin
	bgez $t3, fin
	#Si algun valor es mayor o igual a 0, entonces saltar al final (nunca se asigna 1 a res)
	li $s0, 1
	sb $s0, res
	
fin:
	
    li $v0, 10
    syscall
.end
#Diseña un programa en ensamblador que defina un vector de enteros, V,
#inicializado a los siguientes valores V=[1, -4, -5, 2] y obtenga como resultado
#una variable booleana que será 1 si todos los elementos de este vector son
#menores que cero.