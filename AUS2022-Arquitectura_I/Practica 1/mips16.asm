.data 0x10000000

    numero: .word 0x1237
    resultado: .space 4
    
.text
.globl main

main:

    lw $t0, numero($0)
    sll $t1, $t0, 5
    sw $t1, resultado($0)