.data 0x10000000

	numero1: .word 18 
	numero2: .word -1215
        dir_cociente: .word 0x10010000

.text 
.globl main

main:

    lw $t0, numero1($0)
    lw $t1, numeros2($0)
    li $t2, 5 #divisor
    
    div $t0, $t2
    mflo $t0
    
    div $t1, $t2
    mflo $t1

    lw $t2, dir_cociente($0)
    sw $t0, ($t2)
    sw $t1, 4($t2)