.data 0x10000000

	alterar: .word 0xabcd12bd
	.align 2
	mascara: .word 0xfffffebb
	.align 2
	resultado: .space 4

.text
.globl main

main:
	lw $t0, alterar($0)
	lw $t1, mascara($0)

	and $t0, $t0, $t1
	sw $t0, resultado($0)
	
