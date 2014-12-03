;============================================================================
; Project Prolog
; Author: Kevin S. O'Day
; Course: CS 2810-001
; Project: Proj_01
; Purpose: Employee class exercise
; Date: October 2014
; Date: 10/17/14 9:59 AM
;============================================================================
; I declare that the following source code was written by me, or provided
; by the instructor for this project. I understand that copying
; source code from any other source constitutes cheating, and that I will
; receive a zero grade on this project if I am found in violation of
; this policy.
;----------------------------------------------------------------------
	.ORIG x3000
	LEA r0, class	;point to the class string, LEA loads the address
	TRAP x22		;print out the string,TRAP x22 == PUTS
	ld	r0, newLine	;get a newLine character
	TRAP x21		;print out the character
	LEA r0, name	;point to the name string
	TRAP x22		;print out the string
	ld	r0, newLine	;get a newLine character
	TRAP x21		;print out the character	
	LEA r0, project	;point to the project string
	TRAP x22		;print out the string
	ld	r0, newLine	;get a newLine character
	TRAP x21		;print out the character
	LEA r0, termMsg	;point to the termination message string
	TRAP x22		;print out the string
	ld	r0, newLine	;get a newLine character
	TRAP x21		;print out the character
	HALT
newLine	.fill 		x0A              ;ASCII code for newline
class	.STRINGZ	"CS2810-001"
name	.STRINGZ	"Kevin O'Day"
project	.STRINGZ	"Project #1"
termMsg	.STRINGZ	"Program execution terminated!"
		.END
