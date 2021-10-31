.data 0x10000000

vectorA: .space 80
vectorB: .space 80

# NOTA: No añado el .text con el main correspondiente que cierra el programa porque en esta unidad no es 
# necesaria la ejecución, y es suficiente con esto para leer la reserva en el qtspim