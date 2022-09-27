.data

    original: .word 0x10203040
    copiado: .space 4

.text
.globl main

main:
    lh $t0, original($0)
    sh $t0, copiado+2($0)

    lh $t0, original+2($0)
    sh $t0, copiado($0)