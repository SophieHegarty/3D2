	AREA	HAMMING2, CODE, READONLY
	IMPORT	main
	EXPORT	start
	
start
	LDR r0, =0xb6b
	
 

	AND R3, R0, #0XFFFFFF74;Clear bits c0, c1, c3, c7

	; Generate check bit c0
	EOR	R2, R3, R3, ASR #2	; Generate c0, parity tree
	EOR	R2, R2, R2, ASR #4	
	EOR	R2, R2, R2, ASR #8	

	AND	R2, R2, #0x1		; Clear everything but c0
	ADD	R3, R3, R2		    ; Add bit with value

	; calculate c1
	EOR	R2, R3, R3, ASR #1	
	EOR	R2, R2, R2, ASR #4	
	EOR	R2, R2, R2, ASR #8	

	AND	R2, R2, #0x2		
	ADD	R3, R3, R2		

	; calculate c3
	EOR	R2, R3, R3, ASR #1	
	EOR	R2, R2, R2, ASR #2	
	EOR	R2, R2, R2, ASR #8	

	AND	R2, R2, #0x8		
	ADD	R3, R3, R2			

	; calculate c7
	EOR	R2, R3, R3, ASR #1	
	EOR	R2, R2, R2, ASR #2	
	EOR	R2, R2, R2, ASR #4	

	AND	R2, R2, #0x80		
	ADD	R3, R3, R2		

	EOR R1, R0, R3 ;r0 original, r3 recalculated - compare

	;Clear bits except c7,3,1,0
	LDR R8, =0x8
	BIC R4, R1, R8
	MOV R4, R4, ASR #4

	LDR R5, =0X4
	AND R5, R5, R1
	MOV R5, R5, ASR #1
	ORR R4, R5, R4
	;LDR R5, =0x0
	;MOV R5, R5, LSR #1

	LDR R5, =0x3
	AND R5, R5, R1
	;BIC R6, R1, R10
	ORR R4, R4, R5

	;Subtract 1 from R1 to get error position, correct by moving single bit to the R4 position, then eor to flip to correct bit
	LDR R5, =0x1
	RSB R4, R5, R4
	MOV R5, R5, LSL R4
	EOR R0, R0, R5


stop	B	stop

	END	