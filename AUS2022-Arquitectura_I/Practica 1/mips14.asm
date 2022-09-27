.data 0x10000000

	entero: .word 0xabcd12bd
	mask: .word 0xfffffebb
	res: .space 4

.text
.globl main

main:
	lw $t0, entero($0)
	lw $t1, mask($0)

	and $t0, $t0, $t1
	sw $t0, res($0)