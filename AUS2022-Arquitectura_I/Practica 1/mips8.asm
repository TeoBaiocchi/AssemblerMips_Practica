.data 0x10000000
    vector: .word 10, 20, 25, 500, 3
    copiarA: .word 0x10010000
    
.text
.globl main
main:

    lw $s0, vector($0)
    lw $s1, vector+4($0)
    lw $s2, vector+8($0)
    lw $s3, vector+12($0)
    lw $s4, vector+16($0)
    
    sw $s0, copiarA($0) 
    sw $s1, copiarA+4($0)
    sw $s2, copiarA+8($0)
    sw $s3, copiarA+12($0)
    sw $s4, copiarA+16($0)
    
