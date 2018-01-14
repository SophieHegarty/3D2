	AREA	VAL_HEX, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	
			LDR R0, =0xA1000400
    		STR R1, [R0]
    		LDR R10 , =8
    		LDR R9, =0xf
    		LDR R8, =0x0
    		LDR R4, =0x0
			LDR r6, =0
			LDR r7, =0x28
			;LDR r8, =0
			LDR r11, =0
    		

    		;while R10 ! 0{
			;MOV r1, r1, LSR #28
			MOV r5, r1
			
    		MOVS R10, R10
			ROR R1, R1, #28
while
    		BEQ endwh
			;ROR R5, R1, #28
			;MOV R5, r1, LSR #28
			;ROR 
			;ROR r1, r1, r7
    		MOV R2, R1, LSL R8
			 
			;MOV R2, R2, LSR #28
    		AND R2, R2, R9
    		;MOV R2, R2, LSR R8 
			
			;MOV r2, r2, LSR #4
    	
    		CMP r2, #9
    		BLS else2
    		ADD R3, R2, #0x37
    		B gotostack
else2

    		ADD R3, R2, #0x30
    		B gotostack
else1
    	
gotostack
    		STR R3, [R0]
    		ADD R0, R0, #1
			ADD R4, R4, R3
    		SUBS R10, R10, #1
    		;MOV R9, R9, LSR #1
    		;ADD R8, R8, #1
			SUB r7, r7, #4
    		ROR R1, R1, #28
    		B while
    		
endwh
	
stop B stop
	END