.data 0x10010002

espacio: .space 4
bytes: .byte 0x10, 0x20, 0x30, 0x40

.data 1001010
palabra: .space 4

.text
main:
    

    li $v0, 10
    syscall
.end