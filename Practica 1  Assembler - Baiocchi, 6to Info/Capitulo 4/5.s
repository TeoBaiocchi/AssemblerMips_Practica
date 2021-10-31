.data 0x10000000
numero: .word 0x1237

.text

main:
    lw $s1, numero
    sll $s2, $s1, 5 # mover los bits 5 lugares a la izquierda equivale a multiplicarlos 2 a la 5 veces
    li $v0, 10
    syscall
.end