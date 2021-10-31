.data 0x10000010

entero: .word 0xff0f1235

.text

main:
    lw $s0, entero
    li $t0, 0x144 # 1 en 3, 7, 9

    xor $s1, $s0, $t0 # invierto los bits modificados en t0

    li $v0, 10
    syscall
.end