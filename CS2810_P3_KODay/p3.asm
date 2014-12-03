;===========================================================================
; Name:		p3.asm
; Author:	Kevin S. O'Day
; Version:	1.0
; Project:	Proj_03
; Purpose:	convert a decimal number into its word form.
; Date:		December 2014
; Date:		12/02/14 9:59 AM
;===========================================================================
; I declare that the following source code was written by me, or provided
; by the instructor for this project. I understand that copying
; source code from any other source constitutes cheating, and that I will
; receive a zero grade on this project if I am found in violation of
; this policy.
;----------------------------------------------------------------------

				.ORIG x3000
		;Print the class template
				LEA R0, class		;point to the class string 				x3001
				PUTS				;print out the string,PUTS == TRAP x22	
				LD	R0, newLine		;get a newLine character
				OUT					;print out the character, OUT == TRAP x21
				LEA R0, name		;point to the name string
				PUTS				;print out the string
				LD	R0, newLine		;get a newLine character
				OUT					;print out the character	
				LEA R0, project		;point to the project string
				PUTS				;print out the string
				LD	R0, newLine		;get a newLine character
				OUT					;print out the character

				
				;Write out a message to input a character from the keyboard
LOOP			LD	R0, newLine			;get a newLine character
				OUT						;print out the newLine character
				LEA 	R0, getNumMsg	;point to the prompt
				PUTS				;print out the prompt string
				GETC				;get char from keyboard, store in R0

			;Test the character to in R0 to see if it's printable	
				LD 		R5, lowPrintable		;lowest printable 
				ADD		R4, R0, R5		; subtract lowest, result R4
				BRn 	NOTPRINTABLE	; if the number is negative
				LD 		R5, highPrintable		;highest printable 
				ADD		R4, R0, R5		; subtract highest, result R4
				BRp 	NOTPRINTABLE	; if the number is positive

			;must be printable!, print it.
				OUT 				;print character from R0 to console (echo)

			;Test the character to see if it matches exclamation
				;compare the character to exclamation
				;if its <!> (ASCII code #33, Hex x21) print doneMsg,finish up
				LD 		R5, negExcl 	; R5 = -x21 negates <!>
				ADD		R4, R0, R5		; subtract <!> from character,result R4
				BRz  	FINISH    		; if the difference was zero, FINISH

			;check if it's above nine
				LD 		R5, negNine		;
				ADD		R4, R0, R5		;subtract -x39 from character, into R4
				BRp 	NOTANUMBER		;lower than zero 

				LEA 	R3, numbers		;point to the first number string
				LD 		R5, negZero		;
				LD 		R6, numStringSize ; number of addresses per string 

			;increment through the rest of the numbers
TESTNUM			ADD		R4, R0, R5		;subtract -x30 from character, into R4
				BRn 	NOTANUMBER		;lower than zero 
				BRz  	PRINTNUMSTR    	;if the difference was zero, print zero
				ADD 	R3, R3, R6 		;increment the pointer to next
				ADD 	R5, R5, #-1 	;subtract one from the test number 
				BRnzp 	TESTNUM			;repeat

PRINTNUMSTR		ADD		R0, R3, #0		;load the address of the string from R3
				PUTS					;print out the number string 
				BRnzp	LOOP			;LOOP again

NOTANUMBER		LEA R0, errorNumMsg		;point to the errorNumMsg string
				PUTS					;print out the message
				BRnzp	LOOP			;LOOP again

NOTPRINTABLE	LEA R0, noPrintMsg		;point to the errorNumMsg string
				PUTS					;print out the message
				BRnzp	LOOP			;LOOP again

			;Write out exit message
FINISH			LEA R0, doneMsg		;point to the doneMsg string
				PUTS				;print out the message
				LD	R0, newLine	;get a newLine character
				OUT		;print out the newLine character
				LD	R0, newLine	;get a newLine character
				OUT		;print out the newLine character
				LEA R0, termMsg	;point to the termination message string
				PUTS		;print out the string
			;HALT the program
				HALT


;------------------------------------------------------------------------------
newLine		.FILL  		x0A             ;ASCII code for newLine
exclamation	.FILL  		x21             ; ASCII code for exclamation point
negExcl     .FILL      	xFFDF  			;negates ASCII code for <!> character
space 		.FILL 		x20 			;ASCII code for space character
negZero     .FILL      	xFFD0  			; -x30
negNine     .FILL      	xFFC7  			; -x39

; printable characters x20 to x7E
lowPrintable	.FILL 	#-32			;the lowest printable character
highPrintable	.FILL 	#-126			;the highest printable character

class			.STRINGZ	"CS2810-001"	;init locations 
name			.STRINGZ	"Kevin O'Day"	;
project			.STRINGZ	"Project #2"	;
	
getNumMsg 		.STRINGZ	" Please input a number 0-9: "
errorNumMsg 	.STRINGZ	" Error! You did not input a number."
noPrintMsg 		.STRINGZ	" That character isn't printable."
doneMsg     	.STRINGZ	" Done!"
termMsg			.STRINGZ	"Program execution terminated!"

numStringSize	.FILL  		#7			;length of each number string
numbers 		.STRINGZ	" zero "
				.STRINGZ	" one  "
				.STRINGZ	" two  "
				.STRINGZ	" three"
				.STRINGZ	" four "
				.STRINGZ	" five "
				.STRINGZ	" six  "
				.STRINGZ	" seven"
				.STRINGZ	" eight"
				.STRINGZ	" nine "

KBSRPtr		.FILL		xFE00			;stores KB status register pointer
KBDRPtr		.FILL		xFE02			;Keyboard data register pointer
DSRPtr		.FILL		xFE04			;Data status register pointer
DDRPtr		.FILL		xFE06			;Display data register pointer
;------------------------------------------------------------------------------
			.END