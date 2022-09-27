.data 0x10000000
	v: .word 10, 20

.text 
.globl main

main:
	lw $t0, v($0)
	lw $t1, v+4($0)
	add $t1, $t1, $t0
	sw $t1, v+8($0)