	AREA	HextoVal, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
				LDR r0, =0
				LDR r3, =0x30 ;conversion from ascii to num
				LDR r4, =0x57 ;conversion from lower case to num
				LDR r5, =0x37 ;conversion from upper case to num
				LDR r6, =0x0
				LDR r7,=0x0
				LDR r8, =0x0
				LDR r9, =0x4
				LDR r1, =TestStr
				MOV r2, r1
    		
    		B while ;creates counter to move each val to correct position ie in increments of #4, move up 1 position each time
wh0 ADD r8, r8, r9
while LDRSB r2, [r1], #1
			;LDRSB r2, [r1, #1]
    		;ADD r2, R2, #1
    		CMP r2, #0 
    		BNE wh0 
    	
    		LDR r1, =TestStr
    		MOV r2, r1
    		
    		B while1 ;while r2 doesn't = 0, ie no hex values left
wh1 CMP r2, r3
    		BLO ifnum ;if a number -30
    		RSB r6, r3, r2
ifnum
    		CMP r2, #'a' ;if a lower case -57
    		BLO iflower 
    		CMP r2, #'f' 
    		BHI iflower
    		RSB r6, r4, r2
iflower
			CMP r2, #'F' 
    		BHI ifupper
    		CMP r2, #'A' ;if upper case -37
    		BLO ifupper 
    		RSB r6, r5, r2
ifupper
    	
while1 LDRSB r2, [r1], #1;move to next val
			;LDRSB r2, [r1, #1]
    		MOV r7, r6, LSL r8 ;move val to correct position, by r8
    		ORR r0, r0, r7 ;add to total in r0
    		RSB r8, r9, r8 ;move to next position in value
  		CMP r2, #0 ;while not 0 keep in loop
    		BNE wh1 


stop B stop
	AREA	HexToVal, DATA, READWRITE
TestStr	DCB	"1f3",0
	END
			
stop B stop
	END
