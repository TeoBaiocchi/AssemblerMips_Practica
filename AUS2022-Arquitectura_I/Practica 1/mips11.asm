.data 0x10010002

	bite1: .byte 0x10
	bite2: .byte 0x20
	bite3: .byte 0x30
	bite4: .byte 0x40
    	
.data 0x1001010
	palabra: .space 4

.text
.globl main

main:
	lb $t0, bite1
	sb $t0, palabra
	
	lb $t0, bite2
	sb $t0, palabra+1
	 
	lb $t0, bite3
	sb $t0, palabra+2
	 
	lb $t0, bite4
	sb $t0, palabra+3  
