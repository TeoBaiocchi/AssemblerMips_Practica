.data
TextoIngreso: .asciiz "Ingrese un decimal (o 0 para salir del programa):  \n"
              .align 2

TextoIngreso0: .asciiz "\nSe ingresó un 0. Cerrando..."
              .align 2

TextoOutput1: .asciiz "\nEl numero ingresado en binario es: "
              .align 2

TextoOutput2: .asciiz "\nEl numero ingresado en hexadecimal es: "
              .align 2

TextoOutput3: .asciiz "\nSigno: Positivo"
              .align 2

TextoOutput4: .asciiz "\nSigno: Negativo"
              .align 2

TextoOutput5: .asciiz "\nExponente: "
              .align 2

TextoOutput6: .asciiz "\nMantisa: "
              .align 2

Separador: .asciiz "\n \n \n"
              .align 2

NumeroIngresadoBinario: .space 33 # 32 + terminador (0)
                        .align 2

NumeroIngresadoHexadecimal: .ascii "0x"
                            .space 9 # 8 del hexadecimal despues del 0x, y 1 para el terminador que tengo que agregar a mano porque use ascii
                            .align 2
.text
.globl main
main:           # Resumen de la idea de mi código: Obtener el float por ingreso, y mediante una subrutina (ObtenerBinario) guardar el numero en memoria, en formato ascii (para poder leerlo, y trabajarlo bit a bit con más facilidad). 
                # Para guardarlo en memoria la primera vez, necesito desplazamientos sobre el numero base para moverme bit a bit, formatearlo, y guardarlo. Una vez lo tenga, para obtener el hexadecimal, el signo, y el exponente, voy a trabajar directamente con...
                # ...este número en memoria, reconvirtiendoló a binario cada vez ya que así va a ser más sencillo leerlo bit a bit. Excepto en la mantisa, donde es más sencillo usar el número original que guardé en $s0, y formatearlo con and y or
                # Voy a volver a explicar de nuevo y con más detalle cada procedimiento a medida que pasan, esto es la idea global
    li $v0, 4 
    la $a0, TextoIngreso  
    syscall                           # llamo el primer texto

    li $v0, 6 
    syscall                           # llamada para ingresar el float

    mfc1 $s0, $f0                     # guardo el float en $s0
    mfc1 $a0, $f0                     # guardo el float en $a0 también.
                                      # Guardo el numero en dos registros diferentes, porque $a0 va a ser un parametro para la subrutina que va a obtener el binario. En $s0 voy a guardar el numero para más adelante, porque es más sencillo para calcular la mantisa sin reconvertir el ascii.
    beq $a0, $0, cierroPorqueIngreso0 # comparo el float ingresado con el registro 0 para determinar si cierro o no el programa
    la $a1, NumeroIngresadoBinario    # a1 contiene la dirección de memoria del espacio donde voy a guardar el numero
   
    jal ObtenerBinario

    li $v0, 4
    la $a0, TextoOutput1
    syscall

    li $v0, 4
    la $a0, NumeroIngresadoBinario
    syscall

    la $a0, NumeroIngresadoBinario     # La dirección de memoria de lo que voy a tomar
    la $a1, NumeroIngresadoHexadecimal # La dir. de lo que voy a escribir
    jal ObtenerHexadecimal

    li $v0, 4
    la $a0, TextoOutput2
    syscall

    li $v0, 4
    la $a0, NumeroIngresadoHexadecimal
    syscall

    la $a1, NumeroIngresadoBinario
    move $a2, $s0                  # De nuevo, para calcular la mantisa. Para Los otros dos, creo que sigue siendo más sencillo reconvertir el ascii y usar eso
    jal SignoExponenteMantisa

    j main 

Salir:                           # Esto está aca para salir de las subrutinas y volver al main.
    jr $ra

ObtenerBinario:                 # Necesito pasar el numero binario guardado a una cadena ascii que pueda imprimir. 
            
    addi $a1, $a1, 31           # no arranco desde 32 porque cuento la posición 0
    li $t0, 31                  # Contador desde el inicio del numero hasta 0

Loop1:
    andi $t1, $a0, 1            #  comparo bit a bit del numero ingresado para ver si es 0 ó 1
    addi $t1, $t1, 48           # Esto es para guardar el caracter de 0 ó 1 en lugar del número en sí mismo: Si es 0, toma 48 y si es 1, 49
    sb $t1, ($a1)               # guardo en la posición de memoria asignada
    srl $a0, $a0, 1             # Muevo el digito a comparar en mi numero original

    beq $t0, 0, Salir
    addi $t0, $t0, -1           # resto al contador
    addi $a1, $a1, -1           # "Corro" la dirección para seguir guardando el numero
    j Loop1                     # se repite 31 veces

ObtenerHexadecimal:             # La idea acá es en principio reconvertir el numero de ascii -> binario con un loop, mientras anido un segundo loop que va a tomar grupos en binario de 4 digitos y convertirlos a hexadecimal.
    li $t0, 8                   # contador
    addi $a0, $a0, 31           # Idem al binario
    addi $a1, $a1, 9            # Me desplazo hasta el principio del hexadecimal para escribir en orden el número 
LoopGrande:
    li $t1, 0                   # Contador de 1 a 4
    li $t3, 0                   # Donde voy a guardar los grupos de 4
LoopChico:
    lb $t2, ($a0)
    addi $t2, $t2, -48          # Para reconvertir el numero a su valor binario
    sllv $t2, $t2, $t1          # Shift logico t1 digitos, el contador pequeño de 0 a 4. La idea de esto es usar el contador para determinar la "posición" de cada digito en el grupo de 4, cuando los sume en la proxima linea
    add $t3, $t3, $t2           # Voy rearmando mi binario agrupado en 4
    addi $t1, $t1, 1
    addi $a0, $a0, -1
    beq $t1, 4, SalirLoopChico  # 4 vueltas y salimos
    j LoopChico
SalirLoopChico:                 # Ahora hay que convertir el agrupado binario en un hexadecimal
    
    blt $t3, 10, Sumar48        # de ser menor a 10 se trata de un numero y le suma 48...
    addi $t3, $t3, 55           # ...para llegar al ascii. Si no, se trata de una letra...
    j SaltarSuma                # ...por lo que sumo 55 y me salteo el paso con una etiqueta para no hacer ambos
Sumar48:
    addi $t3, $t3, 48
SaltarSuma:                     # Lo que prosigue ahora es guardar el numero que tengo en $t3 en memoria. Para esto tendría que guardar la posición en un registro a, sumarle los espacios para 

    sb $t3, ($a1)               # Guardo efectivamente el digito, ya en hexadecimal, en memoria
    li $t3, 0                   # Reseteo. Necesito guardar un numero fresco la proxima vuelta
    addi $a1, $a1, -1           # "Corro", de nuevo, la posición en memoria para guardar el digito en el espacio adyacente la proxima vuelta
    addi $t0, $t0, -1
    beq $t0, $0, Salir 

    j LoopGrande

SignoExponenteMantisa:       # Notas: a1 = NumeroIngresadoBinario, a2 = Numero puro en binario para la mantisa. A0 está limpio para los outputs de texto

    lb $t1, ($a1)
    beq $t1, 49, Negativo    # Si detecta un 1 es negativo, de lo contrario, positivo

    li $v0, 4
    la $a0, TextoOutput3
    syscall

    j SaltarNegativo

Negativo:

    li $v0, 4
    la $a0, TextoOutput4
    syscall

SaltarNegativo:
    li $t2, 0
    li $t0, 0               # Ahora, hacia el exponente
    addi $a1, $a1, 8        # Arranco desde la 9na posición, donde comienzan los digitos de interés
Loop2:                      # Procedimiento similar al utilizado en hexadecimal, pero esta vez para obtener los 8 digitos consecuentes al signo, que representan el exponente
    lb $t1, ($a1)           
    addi $a1, $a1, -1       # Me "muevo" al bit siguiente
    addi $t1, $t1, -48      # Conversión
     
    sllv $t1, $t1, $t0      
    add $t2, $t2, $t1       # Recuerdo el procedimiento acá: Obtengo en $t1 el numero del ascii convertido a binario, utilizando sllv y el contador, posiciono al numero en la posición que le corresponde, para volverlo el numero compuesto en la suma de la proxima linea
    
    addi $t0, $t0, 1
    beq $t0, 8, SalirLoop2
    j Loop2

SalirLoop2:                 # Ahora, en $t2 tengo el numero que al restarle 127 obtengo el exponente
    li $v0, 4               # Para mostrarlo, muestro la primera parte del texto, entonces guardo el valor correcto en $a0 y lo imprimo con otra llamada
    la $a0, TextoOutput5
    syscall

    addi $a0, $t2, -127
    li $v0, 1
    syscall                 # Ahora, para mostrar la mantisa, hago uso de and y or para anular el exponente (convertirlo a 127) y así poder mostrarlo con la llamada al sistema, como se sugiere en el enunciado
                            # Ahora sí voy a utilizar $a2, donde tengo guardado lo que moví desde $s0 antes de llamar a esta subrutina
    li $t0, 0x3FFFFFFF      # Equivale a 00111111111111111111111111111111
    and $t1, $a2, $t0       # El signo va a quedar positivo, y altero solo el primer digito del exponente (And va a dejar el resto del número como estaba) 

    li $t0, 0x3F800000      # Equivale a 00111111100000000000000000000000
    or $t1, $t1, $t0        # La idea de "anular" el exponente es setearlo en 01111111, 127. Ya alteramos el primer digito en el and, con el or, seteamos los otros 7 como 1 sin alterar el resto del número 
                            # Ahora puedo mostrarla con el mismo procedimiento de antes
    li $v0, 4
    la $a0, TextoOutput6
    syscall

    li $v0, 2
    mtc1 $t1, $f12
    syscall

    li $v0, 4
    la $a0, Separador
    syscall
    j Salir

cierroPorqueIngreso0:           # Bastante autoexplicativo, si detecta un cero salta a esta etiqueta y cierra el programa
    li $v0, 4 
    la $a0, TextoIngreso0 
    syscall
    li $v0, 10 
    syscall
.end