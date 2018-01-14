	AREA	FirstProgram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

 LDR R1, =2_01110001000111101100111000111111
 LDR R0, =0
 LDR R2, =32
 LDR R3, =0
 LDR R4, =0
 
 AND R5, R0, #1 ; load r5 with first bit to compare
 
 MOVS R2, R2
while BEQ endwh
 AND R0, R1, R4 ;hold single value starting at bit 0
 MOV R0, R0, LSL R4 ;shift single bite to position 1 for comparison with r5(previous val)
 CMP R0, R5 ;compare r0 to r5 if yes go below else go to else1
 BNE else1
 
   ADDS R4, R4, #1 ;update count for r4
 B endif1
else1 ;if current bit doesn’t equal previous bit
 ;ADDS R3, R3, #1
 
 CMP R0, #0  ;if bit = 1 update count of patterns
 BLS endif2  
 
  ADDS R3, R3, #1 ;update count of patterns
endif2
 
 ADDS R4, R4, #1
 EOR R5, #1 ;flip comparison bit 
endif1
 SUBS R2, R2, #1
 B while
endwh
	
	
stop	B	stop

	END	