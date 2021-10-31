.data  
nombre: .space 11
DNI: .space 16
mensaje: .asciiz "\nA continuación imprimo los datos: \n"
.text
.globl main
main:
    la $a0, nombre
    li $a1, 11
    li $v0, 8
    syscall
    la $a0, DNI
    li $a1, 16
    li $v0, 8
    syscall
    la $a0, mensaje
    li $v0, 4
    syscall
    la $a0, nombre
    li $v0, 4
    syscall
    la $a0, DNI
    li $v0, 4
    syscall
    li $v0, 10
    syscall
.end 