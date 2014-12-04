;===========================================================================
; Name:		p4.asm
; Author:	Kevin S. O'Day
; Version:	1.0
; Project:	Proj_04
; Purpose:	Count Alphanumeric characters into 4 categories.
; Date:		December 2014
; Date:		12/03/14 9:59 AM
;===========================================================================
; I declare that the following source code was written by me, or provided
; by the instructor for this project. I understand that copying
; source code from any other source constitutes cheating, and that I will
; receive a zero grade on this project if I am found in violation of
; this policy.
;----------------------------------------------------------------------

				.ORIG x3000
Main			AND 	R3, R3, #0 		; initialize variables
				ST 		R3, spaceCount
				ST 		R3, numCount
				ST 		R3, lowerCount
				ST 		R3, upperCount

				LEA 	R0, classHeader	;point to class string 
				PUTS 					;print string out 

				LEA 	R0, getMessage	;point to main message 
				PUTS 					;print string out 

LOOP 			GETC 					; get input character 

				;Check for newline character 
				LD 		R1, negNewLine	; load negative of newline character 
				ADD 	R2, R0, R1		; compare the newline character 
				BRz 	DisplayResults 

				;Check for space 
				LD 		R1, negSpace	; load negative of newline character
				ADD 	R2, R0, R1		; compare the newline character 
				BRn 	LOOP 			; jump if not printable (ignore)

				BRp 	NumberTest 		; if result is positive, jump

				OUT 					; the character is space 
				LD 		R3, spaceCount
				ADD 	R3, R3, #1 		; increment count
				ST 		R3, spaceCount	; save R3 register into spaceCount
				BR 		LOOP 			; go back to the start of the loop

				; test if it's between 0 and 9 inclusive, 
NumberTest 		LD 		R1, negNine		; load negative of ASCII <9> into R1 
				ADD		R2, R0, R1		; subtract -x39 from character, into R2
				BRp 	TestUpper		; character is higher than ASCII <9>

				LD 		R1, negZero		; load negative of ASCII <0> into R1 
				ADD		R2, R0, R1		; subtract -x30 from character, into R2
				BRn 	LOOP 			; the character is lower than ASCII <0>

				OUT 					; the character is a number, print it
				LD 		R3, numCount
				ADD 	R3, R3, #1 		; increment count
				ST 		R3, numCount	; save R3 register into numCount
				BR 		LOOP 			; go back to the start of the loop

				; test if it's between A and Z inclusive
TestUpper    	LD 		R1, negUpperZ	; load negative of ASCII <Z> into R1 
				ADD		R2, R0, R1		; subtract -x5A from character, into R2
				BRp 	TestLower		; character is higher than ASCII <Z>

				LD 		R1, negUpperA	; load negative of ASCII <A> into R1 
				ADD		R2, R0, R1		; subtract -x41 from character, into R2
				BRn 	LOOP 			; the character is lower than ASCII <A>

				OUT 					; the character is an upper, print it
				LD 		R3, upperCount
				ADD 	R3, R3, #1 		; increment count
				ST 		R3, upperCount	; save R3 register into upperCount
				BR 		LOOP 			; go back to the start of the loop	

				; test if it's between a and z inclusive
TestLower  		LD 		R1, negLowerZ	; load negative of ASCII <z> into R1 
				ADD		R2, R0, R1		; subtract -x5A from character, into R2
				BRp 	LOOP 			; character is higher than ASCII <z>

				LD 		R1, negLowerA	; load negative of ASCII <a> into R1 
				ADD		R2, R0, R1		; subtract -x61 from character, into R2
				BRn 	LOOP 			; the character is lower than ASCII <a>

				OUT 					; the character is an lower, print it
				LD 		R3, lowerCount
				ADD 	R3, R3, #1 		; increment count
				ST 		R3, lowerCount	; save R3 register into lowerCount
				BR 		LOOP 			; go back to the start of the loop

				;Display the results 
				;test to see if the count is higher than nine (maximum)
DisplayResults 	LD 		R0, newLine
				OUT 					; print newline twice
				OUT
				LEA		R0, outMsg 		; category message 
				PUTS 
				LD	R0, newLine			;get a newLine character
				OUT						;print out the newLine character

				

				; go through each of the 4 categories

				LEA		R0, outMsgNum 
				PUTS 
				LD 		R0, numCount	
				JSR 	GreaterOrEqual

				LEA		R0, outMsgUpper 
				PUTS 
				LD 		R0, upperCount	
				JSR 	GreaterOrEqual

				LEA		R0, outMsgLower 
				PUTS 
				LD 		R0, lowerCount	
				JSR 	GreaterOrEqual

				LEA		R0, outMsgSpace 
				PUTS 
				LD 		R0, spaceCount	
				JSR 	GreaterOrEqual

				BR 		FINISH			; Done, now finish.

GreaterOrEqual  ST 		R7, SaveR7 		; save R7 
				LD 		R1, negNumNine	; load #-9 into R1 
				ADD		R2, R0, R1		; subtract #9 from number, into R2
				BRnz	NumToASCII 		;
				LEA 	R0, greaterThan
				PUTS
				LD		R0, newLine		;get a newLine character
				OUT						;print out the newLine character
				LD 		R7, SaveR7			
				RET 

NumToASCII		LD 		R1, asciiZero	;load ASCII zero x30 into R1 
				ADD 	R2, R0, R1		;turn number into character into R2
				ST 		R2, replaceMe	;store the number to be printed
				LEA		R0, equalTo		;load the equalTo message
				PUTS 
				LD	R0, newLine			;get a newLine character
				OUT						;print out the newLine character
				LD 	R7, SaveR7			
				RET 					;return			


			;Write out exit message
FINISH			LD	R0, newLine	;get a newLine character
				OUT		;print out the newLine character
				OUT		;print out the newLine character
				LEA R0, termMsg	;point to the termination message string
				PUTS		;print out the string
				HALT		;HALT the program


;------------------------------------------------------------------------------

classHeader		.STRINGZ	"CS2810-001\nKevin O'Day\nProject #4\n\n"
getMessage 		.STRINGZ 	"Input a message to be analyzed: "

spaceCount			.BLKW 	1 				;address for storing count buffer
numCount			.BLKW 	1 				;
upperCount			.BLKW 	1 				;	
lowerCount			.BLKW 	1 				;	

SaveR7 				.FILL 	0

true		.FILL		#1
fales		.FILL 		#0

asciiZero	.FILL 		x30 
newLine		.FILL  		x0A             ;ASCII code for newLine
negNewLine	.FILL 		xFFF3 			;negates ASCII code for <\n> character 
negSpace 	.FILL 		xFFE0 			;negates ASCII code for space character
negZero     .FILL      	xFFD0  			;negates ASCII code for <0> -x30
negNine     .FILL      	xFFC7  			;negates ASCII code for <9> -x39
negNumNine	.FILL 		#-9				;
negUpperA   .FILL 		xFFBF			;negates ASCII code for <A> -x41
negUpperZ   .FILL 		xFFA6			;negates ASCII code for <Z> -x5A
negLowerA   .FILL 		xFF9F			;negates ASCII code for <a> -x61
negLowerZ   .FILL 		xFF86			;negates ASCII code for <z> -x7A 

greaterThan 	.STRINGZ 	"> 9" 

equalTo			.FILL 	x003D			; equals
				.FILL 	x0020			; space
replaceMe		.FILL	x0000			; to be replaced by number character
				.FILL 	x0000 			; end of string	

outMsg   		.STRINGZ 	"Group          Count"	;	
outMsgNum 		.STRINGZ	"Numbers:       "		;
outMsgUpper 	.STRINGZ	"Uppercase:     "		;
outMsgLower 	.STRINGZ	"Lowercase:     "		;
outMsgSpace 	.STRINGZ	"Spaces:        "		;

termMsg				.STRINGZ	"Program execution terminated!"
;------------------------------------------------------------------------------
			.END