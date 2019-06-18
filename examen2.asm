.386
.model flat, stdcall
option casemap :none ; case sensitive
.nolist
include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
.list
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\masm32.lib

.data
	MSJ1 DB "TECLEE UN CARACTER: ",0
	MSJ2 DB "TECLEE UN OTRO CARACTER: ",0
	MSJ3 DB "REALIZAR OTRA COMPARACION??(S/N): ",0
	CAR0 DB 2 DUP(" "),0
	CAR1 DB 2 DUP(" "),0
	CAR2 DB 2 DUP(" "),0
	RES1 DB "BIT 3 SON IGUALES",0
	RES2 DB "SON: 0",0
	RES3 DB "SON: 1",0
	RES4 DB "BIT 3 SON DISTIINTOS",0

.code
COMIENZO:

ENTRAR:
	MOV ESI,0H
	MOV EDI,0H
	LEA ESI,CAR1
	LEA EDI,CAR2

	invoke ClearScreen

	;PRIMER CARACTER
	invoke locate,0,0
	invoke StdOut,ADDR MSJ1
	invoke StdIn,ADDR CAR1,LENGTHOF CAR1
	;MOV [ESI],CAR1
	;INC ESI
	;MOV [ESI],WORD PTR

	;SEGUNDO CARACTER
	invoke locate,0,1
	invoke StdOut,ADDR MSJ2
	invoke StdIn,ADDR CAR2,LENGTHOF CAR2
	;MOV [EDI],CAR2
	;INC EDI
	;MOV [EDI],WORD PTR
	
	;COMPARACION
	;MOV EAX,[ESI-1]
	;MOV EAX,[ESI-1]
	;CMP EAX,[EDI-1]
	CMP ESI,EDI
	
	;SON IGUALES
	JE IGUALES
	
	;SON DISTINTOS
	invoke locate,0,2
	invoke StdOut,ADDR RES4
	JMP FINAL
	
IGUALES:
	invoke locate,0,2
	invoke StdOut,ADDR RES1
	JMP VALOR

SALTO:
	JMP ENTRAR
	;0 o 1?

VALOR:
	MOV EAX,[ESI-1]
	AND EAX,00001000B
	CMP EAX,00001000B
	
	;SON UNO
	JE SON_UNO
	
	;SON CERO
	invoke locate,0,3
	invoke StdOut,ADDR RES2
	JMP FINAL
	
SON_UNO:
	invoke locate,0,3
	invoke StdOut,ADDR RES3

FINAL:
	;SALIR?
	invoke locate,0,4
	invoke StdOut,ADDR MSJ3
	invoke StdIn,ADDR CAR0,LENGTHOF CAR0
	CMP CAR0,"N"
	JE SALIR
	CMP CAR0,"n"
	JE SALIR
	JNE SALTO

SALIR:
	invoke ExitProcess,0
END COMIENZO