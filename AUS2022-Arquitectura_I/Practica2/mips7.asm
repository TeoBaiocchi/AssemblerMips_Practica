.data
	palabra: .asciiz "espiripitiflautico"
	.align 2
	caracter: .ascii "i"
	.align 2
	cantidad: .byte 0
	
.text
.globl main
main:
	
	li $s0, 0
	li $t0, 0
	lb $t2, caracter($0)
	
	loop:
	lb $t1, palabra($t0) #t1 tiene el caracter para analizar
	beqz $t1, finLoop #termino la cadena (caracter nulo = 0)
	beq  $t1, $t2, encontroUno #Si el caracter a analizar (t1) es el caracter dado (t2)
	seguir:
	addi $t0, $t0, 1
	j loop
	finLoop:
	j fin
	
encontroUno:
	addi $s0, $s0, 1
	j seguir
	
fin:	
    sb $s0, cantidad($0)
    li $v0, 10
    syscall
.end


#Diseña un programa en ensamblador que dado un vector de caracteres,
#contabilice cuántas veces se repite un determinado carácter en el mismo. El
#programa deberá inicializar la cadena en memoria, y ésta deberá finalizar
#con el carácter nulo. También deberá reservar espacio para la variable
#resultado.