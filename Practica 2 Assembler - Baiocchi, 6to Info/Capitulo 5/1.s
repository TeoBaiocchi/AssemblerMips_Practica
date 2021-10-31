# nota: las notas son para futura referencia personal
.data
V: .byte 0, 1, 1, 1, 0
res: .space 3
.text
.globl main
main:
    lb $t1, V
    lb $t2, V+4
    and $t0, $t1, $t2 # guardas el resultado de t1 and t2 en t0
    sb $t0, res # guardas t0 en Res, recordatorio que es alrevés que digamos And   

    lb $t1, V+1
    lb $t2, V+3
    or $t0, $t1, $t2
    sb $t0, res+1

    lb $t1, V
    lb $t2, V+1
    lb $t3, V+2
    or $t0, $t1, $t2 
    and $t0, $t0, $t3
    sb $t0, res+2 
.end