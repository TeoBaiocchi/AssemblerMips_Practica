.data
PrinThing: .asciiz "Hola\n"
t_in: .word 0
t_out: .word 0
buffer: .space 256
FinBuffer: .word 0
.text
main: 
	la $s1, t_out # dirección de t_out
    la $s2, t_in  # dirección de t_in
	la $t2, FinBuffer # puntero al final del buffer
    la $t3, buffer # puntero al principio del buffer
	sw $t3, ($s2) # t_in apunta al principio del buffer
	sw $t3, ($s1) # t_out apunta al principio del buffer
	lw $t4, ($s2) # contenido de t_in
	lw $t5, ($s1) # contenido de t_out
	li $t1, 5

	addi $sp, $sp, -4
	sw $ra, ($sp)
for:
    beq $t1, $0, final
    la $a0, PrinThing

    jal PrintStr

    addi $t1, $t1, -1
    j for
final:

	li $sp, 4
	lw $ra, ($sp)
	jr $ra


PrintStr:

	lb $t0, ($a0)
	addi $a0, $a0, 1
	sb $t0, ($t4) # meter el caracter en buffer
	addi $t4, $t4, 1 #  mover el t_in en un byte
	beq $t4, $t2, resetIn # si t_in es igual al final del buffer resetear el t_in al principio del buffer
continuar:
	sw $t4, t_in

	# habilitar excepciones
	mfc0 $s3, $12
    ori $s3, $s3, 0x201
    mtc0 $s3, $12

	li $t6, 0xffff0008
	lw $t7, 0($t6)
	ori $t7, $t7, 0x2
	sw $t7, 0($t6)
	# imprimir caracter

	addi $t5, $t5, 1 # mover t_out en un byte
	beq $t5, $t2, resetOut
proceder:
	sw $t5, t_out
	addi $a0, $a0, 1
	beqz $a0, FinPrint
	j PrintStr
resetIn:
	move $t4, $t3
	j continuar
resetOut:
	move $t5, $t3
	j proceder
FinPrint:
	jr $ra