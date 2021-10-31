.data 0x10000000

entero: .word 18, -1215

.data 0x10010000

cociente: .word 0, 0

.text
main:
    lw $s0, entero
    lw $s1, entero+4

    li $t0, 5

    div $s0, $t0
    mflo $t1
    sw $t1, cociente

    div $s1, $t0
    mflo $t1
    sw $t1, cociente+4
    li $v0, 10
    syscall
.end