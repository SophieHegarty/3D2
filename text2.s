	
	LDR r0, =0xA10000400
	LDR r2, =0x3
	LDR r3, =0x37
	LDR r4, =00
	LDR r5, =0
	LDR r6, =0
	LDR r7, =9
	LDR r8, = 0xA
	LDR r9, =0
	LDR r10, =0
	
	SUBS r7, r7, #1

while 
	BEQ endwh
	MOV r4, r1, LSL r5
	MOV r6, r4, LSR #28
	ADD r5, r5, #4
	
	CMP r8, r6
	BCC number1
	ADD r6, r6, r2
number1
	BCS letter1
	ADD r6, r6, r3
letter1
	
	STRB r6, [r0]
	LDR r10, [r0]
	ADD r0, r0, #0x1
	SUBS r7, r7, #1
	B while
endwh