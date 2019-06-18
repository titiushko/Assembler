.386
.model flat, stdcall
option casemap :none
.nolist
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\debug.inc
include \masm32\include\user32.inc
.list
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\debug.lib
includelib \masm32\lib\user32.lib

.data
buffer1			db 127 dup(" "),0
buffer2			db 2 dup(" "),0
txt_title 		db "-----------EJEMPLO DE Bin2Byte_Ex-----------",0
txt_description db "Es una conversion de alta velocidad de un valor de notacion BINARIA a un valor de BYTE",0
message1 		db "Digitar un valor en BINARIO (ejemplo: 00000010): ",0
message2 		db "Hacer otra prueba? (S/N): ",0
result_p1 		db "Resultado: ",0
result_p2 		db " se pudo realizar la conversion a BYTE",0
result_si 		db "si",0
result_no 		db "no",0

.code
start:
	MOV EBX,-1
	invoke ClearScreen
	invoke locate,10,0
	invoke StdOut,ADDR txt_title
	invoke locate,0,1
	invoke StdOut,ADDR txt_description
	invoke locate,0,4
	invoke StdOut,ADDR message1
	invoke StdIn,ADDR buffer1,LENGTHOF buffer1
	invoke locate,0,5
	invoke StdOut,ADDR result_p1
	invoke bin2byte_ex,ADDR buffer1
	;PrintDec EAX, "Valor en Decimal" ; Si EAX = -1, entonces no se pudo realizar la conversión
	CMP EAX,EBX
	JE INCORRECTO
CORRECTO:
	invoke StdOut,ADDR result_si
	JMP FIN
INCORRECTO:
	invoke StdOut,ADDR result_no
	JMP FIN
FIN:
	invoke StdOut,ADDR result_p2
	;SALIR?
	invoke locate,0,7
	invoke StdOut,ADDR message2
	invoke StdIn,ADDR buffer2,LENGTHOF buffer2
	CMP buffer2,"N"
	JE finish
	CMP buffer2,"n"
	JE finish
	JNE start
finish:
	invoke locate,0,10
	invoke ExitProcess,0
	end start