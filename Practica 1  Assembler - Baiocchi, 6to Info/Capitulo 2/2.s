.data 0x10001000

reservaPalabra: .word 0x10
reservaByte: .byte 0x20
    .align 2  # Explicito el align, pero realmente no es necesario porque aparentemente .word reserva a partir de una direccion multiplo de 4 (Implicita un align)
reservaPalabraDos: .word 0x30