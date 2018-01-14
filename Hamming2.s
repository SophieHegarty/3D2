	AREA	HAMMING2, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR r0, =0x852
	
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
	;AND R1, R1, #0x80
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
	
	
	;LDR r0, =0x0
	MOV R6, R0
	;AND R6, R6, #0x8b
	;AND R6, R6, #0XFFFFFF74;Clear bits c0, c1, c3, c7
	;AND R0, R6, #0x0000000
	MOV r0, r6, LSR #0x8 ;most 4 significant bits
	MOV R0, R0, LSL #4
	
	LDR r7, =0x4
	AND R8, R6, R7
	MOV R8, R8, LSR #2
	ADD R0, R0, R8
	
	LDR r7, =0x10
	LDR r9, =0x0
	AND R9, R6, R7
	MOV R9, R9, LSR #3
	ADD R0, R0, R9
	
	LDR r7, =0x20
	LDR r12, =0x0
	AND R12, R6, R7
	MOV R12, R12, LSR #3
	
	ADD R0, R0, R12
	
	LDR r7, =0x40
	LDR r11, =0x0
	AND R11, R6, R7
	MOV R11, R11, LSR #3
	
	ADD R0, R0, R11
	
	
	
	LDR r7, =0x4
	AND R11, R0, r7
	MOV R11, R11, LSL #5
	
	LDR r7, =0x7f
	AND R0, R0, r7
	ADD R0, R0, R11

stop	B	stop

	END	


stop	B	stop

	END	