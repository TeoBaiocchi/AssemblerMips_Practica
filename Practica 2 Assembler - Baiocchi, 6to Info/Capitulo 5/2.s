.data
V: .byte 2, (-4), (-6)
res: .space 3
.text
.globl main
main:
    lb $t1, V
    sge $t0, $t1, $0
    sb $t0, res

    lb $t1, V+1
    sge $t0, $t1, $0
    sb $t0, res+1

    lb $t1, V+2
    sge $t0, $t1, $0
    sb $t0, res+2 # nota: la direccion de memoria siempre a la derecha

    li $v0, 10
    syscall    
.end