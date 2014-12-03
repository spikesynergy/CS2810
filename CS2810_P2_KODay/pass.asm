;============================================================================
; Name:		pass.asm
; Author:	Kevin S. O'Day
; Version:	1.0
; Project:	Proj_02
; Purpose:	read in a character from the keyboard and print out the character.
; Date:		November 2014
; Date:		11/18/14 9:59 AM
;===========================================================================;
; I declare that the following source code was written by me, or provided
; by the instructor for this project. I understand that copying
; source code from any other source constitutes cheating, and that I will
; receive a zero grade on this project if I am found in violation of
; this policy.
;----------------------------------------------------------------------
			.ORIG x3000
			;Print the template
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
			LD	R0, newLine		;get a newLine character
			OUT					;print out the character
	
			;Write out a message to input a character from the keyboard
		 	LEA R0, getCharMsg	;point to the prompt
			PUTS		;print out the prompt string
			GETC	;get char from keyboard, store in R0
			OUT 	;print character from R0 to console (echo)
			ADD R1, R0, #0 		;move character from R0 to R1
			LD	R0, newLine		;get a newLine character
			OUT					;print out the character, OUT == TRAP x21
	
			;Write out a message that you have received the character
			LEA R0, prntCharMsg	;point to the prompt
			PUTS				;print out the string
			ADD R0, R1, #0 		;move character from R1 back to R0
			OUT 				;print out the character
			LD	R0, newLine		;get a newLine character
			OUT					;print out the character

			;Write out exit message
			LD	R0, newLine	;get a newLine character
			OUT		;print out the character
			LEA R0, termMsg	;point to the termination message string
			PUTS		;print out the string
			HALT

newLine		.FILL  		x0A             ;ASCII code for newLine 	x3020
class		.STRINGZ	"CS2810-001"	;init locations   			x3021-x302B
name		.STRINGZ	"Kevin O'Day"	; final location is x0000	x302C-x3037
project		.STRINGZ	"Project #2"	; .FILLs each location		x3038-x3042
getCharMsg 	.STRINGZ	"Please input a character: "
prntCharMsg	.STRINGZ	"You input the character: "
termMsg		.STRINGZ	"Program execution terminated!"

KBSRPtr		.FILL		xFE00			;stores KB status register pointer
KBDRPtr		.FILL		xFE02			;Keyboard data register pointer
DSRPtr		.FILL		xFE04			;Data status register pointer
DDRPtr		.FILL		xFE06			;Display data register pointer
			.END