.data
	dato: .byte 3 # inicializo una posición de memoria a 3
.text
.globl main # debe ser global

main:
	lw $t0, dato($0)


# En este ejemplo:
# Las etiquetas son "dato:" y "main:"
# las directivas son ".data", ".text" y ".globl"
# Los comentarios son "# inicializo una posición de memoria a 3" y "# debe ser global" 