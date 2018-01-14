	LDR	R1, =rpnexp  
    		LDR R3, =0xa	   ;convert to decimal
    		LDR R4, =0		; boolean value true/false if over 9 - therefore can adjust number
    		;LDR R5, 
    		BL subroutine		
    	
    	;		CAN USE POP AND PUSH AS ONLY USING LOW REGISTERS/////doesnt work on codemark???
    	
subroutine
    		LDR R12, =0xA1000400
    		;LDR R0, =0xA1001000
    		;STR R1, [R0]
    		;LDR sp, [R11]
    		STMIA R12!, {lr, R3-R11}		  ; Store registers and link
    		
    		;STMIA R0, {R3-R12}
wh1
    		LDRSB R0, [R1]			
    		CMP R0,#0x0					  ; if not 0
    		BEQ endwh 			      
    		CMP R4, #0x1					
    		BEQ	else_1				   
    		LDR R4, =0					  ; 
    		CMP R0, #0x2				  ;	char ! space						  	   
    		BEQ endif					  ;	
    		CMP R0, #'0'				  ; chara>= 0
    		BCC else1					  ;	
    		CMP R0, #'9'				  ;	char <= 9
    		BCS else1					  
    		LDR R4, =0x1					  
    		SUB R2, R0, #0x30			  
    		STR R2, [R12, #-4]!
    		;PUSH{R2}			  
    	 	B endif 					  ;	Get next character 
    	
else_1	
    		CMP R0, #0x20   			; if space character
    		BNE doubledigit					  ; 
    		LDR R4, =0					  ;	
    		B endif					  	  ;		
    			
    			
doubledigit
    	;if bigger than 9, multiply by 10, convert to decimal and add to value
    		LDR R2, [R12], #4			  	
    		;POP{R2}
    		MUL R2, R3, R2				  	
    	SUB R0, R0, #0x30			  	
    		ADD R2, R2, R0				  
    		STR R2, [R12, #-4]!
    		;PUSH{R2}			  	
    		B endif						  	
else1	
    		CMP R0, #'+'				   
    	BNE else2					    
    		LDR R5, [R12], #4			   	
    		LDR R6, [R12], #4			   
    		;POP{R5}
    	ADD R2, R5, R6				   
    	STR R2, [R12, #-4]!			    
    		;PUSH{R2}
    		B endif						    
else2
    		CMP R0, #'-'				    		
    		BNE else3					   
    		LDR R5, [R12], #4			     
    		;POP{R5}
    		LDR R6, [R12], #4			   
    		;POP{R6}
   
		SUB R2, R5, R6				   
   		STR R2, [R12, #-4]!			    
   		;PUSH{R2}
   		B endif						   
else3
   		CMP R0, #'*'				  
   		BNE else4				  	    
   		LDR R5, [R12], #4			   
   		;POP{R5}
   		LDR R6, [R12], #4			    
   		;POP{R6}
   		MUL R2, R5, R6				   
   		STR R2, [R12, #-4]!			    
   		;PUSH{R2}	
		B endif						    
else4
   		CMP R0, #'/'				    
   		BNE else5				
   		LDR R6, [R12], #4			   
   		;POP{R6}
   		LDR R5, [R12], #4			    
   		;POP{R6}
   		LDR R7, =0					    
   	
wh2
   		CMP R5, R6		;  
   		BCC endwh2		; { divide r6 by r5 while it is still smaller than it
   		ADD R7, R7, #1	; 
   		SUB R5, R5, R6	;
   		B wh2			;}
endwh2
   		STR R7, [R12, #-4]!	 
   		;PUSH{R7}
   		B endif				 	
else5
   		CMP R0, #'n'				  
   		BNE else6					   
   		LDR R0, [R12], #4			   
   		MVN R2, R0					   ; Invert bits
   	ADD R2, R2, #1				   
   		STR R2, [R12, #-4]!
   		B endif		
else6
   		CMP R0, #'!'				  
   		BNE else7				
   		LDR R5, [R12], #4			   
   		SUB R6, R5, #1				   
   		MUL R0, R5, R6				    
wh4
   			CMP R6, #1				   ; While (temp value > 1)
   			BLE endwh1				   ;multiply by n-1 each time until n=1 
   			SUB R6, R6, #1			   
   			MUL R0, R6, R0 			   
   			B wh4					   
else7
   		CMP R0, #'^'				  
   		BNE endif					    
   		LDR R5, [R12], #4			    
   		LDR R6, [R12], #4			   
   		MOV R8, R5					    
   		MOV R9, R6					   
wh3
   		CMP R8, #1					   
   		BLE endwh3			    
   	 	MUL R2, R9, R6				    
   		SUB R8, R8, #1				          
   		MOV R9, R2					    
   		B wh3						   
endwh3
   		STR R2, [R12, #-4]!			  
   		B endif						  
endwh1
   		STR R0, [R12, #-4]!			    
   		;PUSH{R0}
endif 	
   		ADD R1, R1, #1
			STR R0, [R12, #-4]!
   		B wh1						    
endif2
   		LDR R4, =0					    
   		ADD R1, R1, #1				    
   		B wh1						   			
endwh
   		LDR R0, [R12], #4			   ; Pop value off stack
   		;POP{R0}
   		;STR R8, [R0]
   		LDMFD R12!, {R3-R11, PC}	       ; Restore registers
