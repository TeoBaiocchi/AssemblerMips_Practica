.data
	dato1: .byte 2
	dato2: .byte 10
	dato3: .byte 50
	dato4: .byte 70
	dato5: .byte 34
	#dato5: .byte 55
	.align 2
	res: .word 0
.text
.globl main
main:
	lb $s0, dato5($0)
	
	lb $t0, dato1($0)
	lb $t1, dato2($0)
	loop:
	beq $t0, $t1, finLoop1 #si contador (parte de dato1) llega a ser como t2 es fin de intervalo
	seq $s1, $t1, $s0 #Si "i" = dato5... $s1 tiene el resultado 
	addi $t0, $t0, 1 #contador
	j loop
	finLoop1: 
	
	lb $t0, dato3($0)
	lb $t1, dato4($0)
	loop2:
	beq $t0, $t1, finLoop2
	seq $s2, $t1, $s0  
	addi $t0, $t0, 1 
	j loop2
	finLoop2:
	
	
	
	li $t0, 1
	beq $s1, $t0, positivo #Si alguno de los dos resultados en s son 1, guardar 1 en res
	beq $s2, $t0, positivo
	j fin
	
positivo:
	li $t0, 1
	sb $t0, res($0)
	j fin  
	
fin:	
    li $v0, 10
    syscall
.end

#Diseña un programa en ensamblador que almacene en memoria los 5
#enteros siguientes (dato1=2, dato2=10, dato3=50, dato4=70, dato5=34) y
#que reserve 1 palabra para almacenar el resultado, (variable res).
#Implementa en ensamblador del R2000 un programa que almacene en la
#variable res un 1 si dato5 está en alguno de los intervalos formados por
#dato1 y dato2 o dato3 y dato4. Se almacenará un cero en caso contrario.