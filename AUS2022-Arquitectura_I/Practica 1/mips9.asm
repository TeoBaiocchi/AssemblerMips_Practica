.data 

    original: .word 0x10203040
    .align 2
    inversion: .space 4
    .align 2

.text
.globl main

main:

    lb $t0, original($0) 
    sb $t0, inversion+3($0)

    lb $t0, original+1($0)
    sb $t0, inversion+2($0)

    lb $t0, original+2($0)
    sb $t0, inversion+1($0)

    lb $t0, original+3($0)
    sb $t0, inversion($0)