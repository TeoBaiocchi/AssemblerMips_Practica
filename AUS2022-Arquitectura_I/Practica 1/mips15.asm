.data 0x10000000

	entero: .word 0xff0f1235
	mascara: .word 0xfffffebb
	resultado: .space 4

.text
.globl main

main:
	lw $t0, entero($0)
	lw $t1, mascara($0)
	and $t0, $t1, $t0
	
        sw $t0, resultado($0)