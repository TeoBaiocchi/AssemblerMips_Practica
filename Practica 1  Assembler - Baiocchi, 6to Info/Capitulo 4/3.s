.data 0x10000010

entero: .word 0xABCD12BD # 1010 1011 1100 1101 0001 0010 1011 1101

.text
main:
    la $s0, entero
    lw $s5, ($s0)
    li $t0, 0x144 # 1 en 3, 7, 9

    not $s1, $t0 # invierto los bits del 144
    and $s2, $s5, $s1 # and a menos que ambos sean 1 da 0. Entonces, teniendo el hexadecimal

    li $v0, 10
    syscall
.end