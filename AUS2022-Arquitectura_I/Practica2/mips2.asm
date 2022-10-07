.data
	.align 2
	vector: .byte 2, -4, -6
	.align 2
	res: .space 3
.text
.globl main
main:
	lb $t0, vector($0)
	lb $t1, vector+1($0)
	lb $t2, vector+2($0)
	
	sge $s0, $t0, $0
	sge $s1, $t1, $0
	sge $s2, $t2, $0
	
	sb $s0, res($0)
	sb $s1, res+1($0)
	sb $s2, res+2($0)

    li $v0, 10
    syscall
.end

#Diseña un programa en ensamblador que defina un vector de enteros, V,
#inicializado según los siguientes valores (V=[2, -4, -6]). Y obtenga un vector
#de booleanos, tal que cada elemento será 1 si el correspondiente elemento en el
#vector de enteros es mayor o igual que cero y 0 en caso contrario.