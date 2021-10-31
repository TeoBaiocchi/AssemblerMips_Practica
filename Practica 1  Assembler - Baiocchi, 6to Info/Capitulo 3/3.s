.data
palabra: .byte 0x40, 0x30, 0x20, 0x10 # nota: No estoy completamente seguro de si esto cumple el enunciado o si se
# esperaba que declaremos una palabra como tal (con .word), pero si era así no tenía idea de como acceder a cada byte de ella
# o si siquiera era posible
invertida: .byte 0x0, 0x0, 0x0, 0x0

.text
main:
    lb $s0, palabra
    lb $s1, palabra+1
    lb $s2, palabra+2
    lb $s3, palabra+3

    sb $s3, invertida
    sb $s2, invertida+1
    sb $s1, invertida+2
    sb $s0, invertida+3

    li $v0, 10
    syscall
.end