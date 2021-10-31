.data
Never: .asciiz "GONNA GIVE YOU UP" # Never gonna let you down, never gonna go around and desert you
Buscar: .ascii "O"
Total: .word 0
.text
.globl main
main:
    la $t0, Never
    lb $s0, Buscar
loop1:
    lb $t1, ($t0)
    beq $t1, $0, end1
    bne $t1, $s0, saltearSuma 
    addi $s1, $s1, 1
saltearSuma:
    addi $t0, $t0, 1
    j loop1
end1:
    sw $s1, Total
    li $v0, 10
    syscall
.end 