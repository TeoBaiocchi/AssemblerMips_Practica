.data
	vectorBooleano: .byte 0,1,1,1,0
	.align 2
	res: .space 3
.text
.globl main

main:
	
	lb $t0, vectorBooleano($0)
	lb $t1, vectorBooleano+4($0) 
	seq $t2, $t1, $t0 #Si t1 y t2 son iguales, 1. Efectivamente un and
	sb $t2, res
	
	lb $t0, vectorBooleano+1($0)
	lb $t1, vectorBooleano+3($0)
	bnez $t0, noEsCeroA
	bnez $t1, noEsCeroA
volver:
	lb $t0, vectorBooleano($0)
	lb $t1, vectorBooleano+1($0)
	bnez $t0, noEsCeroB
	bnez $t1, noEsCeroB
volver2:
	j fin	
	
	
noEsCeroA:
	li $t1, 1
	sb $t1, res+1($0)
	j volver
	
noEsCeroB:
	li $t1, 1
	lb $t2, vectorBooleano+2($0)
	seq $t0, $t1, $t2
	sb $t0, res+2($0)
	j volver2
	
fin:
    li $v0, 10
    syscall
.end
			
#Diseña un programa en ensamblador que defina un vector de booleanos, V.
#Este se implementa a partir de un vector de bytes donde cada byte sólo puede
#tomar dos valores, 0 ó 1, para el valor cierto o falso, respectivamente. V se
#inicializará con los siguientes valores V=[0,1,1,1,0]. El programa obtendrá otro
#vector de booleanos, res, de tres elementos tal que
#res[1]= (V[1] and V[5]),
#res[2]=(V[2] or V[4]) ,
#res[3]=((V[1] or V[2]) and V[3]).	
