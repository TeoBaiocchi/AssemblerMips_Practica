.data
dato1: .byte 2
dato2: .byte 10
dato3: .byte 50
dato4: .byte 70
dato5: .byte 34
res: .word 0
.text
.globl main
main:
    lb $t1, dato1
    lb $t2, dato5
    sge $t0, $t2, $t1 # si 34 es mas grande que 2
    lb $t1, dato2
    sle $t3, $t2, $t1 # si 34 es mas chico que 10

    and $s1, $t0, $t3 # si ambas condiciones se cumplen, guardo 1 en t0

    lb $t1, dato3
    sge $t0, $t2, $t1 
    lb $t1, dato4
    sle $t3, $t2, $t1 

    and $s1, $t0, $t3

    or $s0, $s1, $s2 
    sw $s0, res

    li $v0, 10
    syscall
.end