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
buffer 			db 127 dup(" "),0
txt_title 		db "-----------EJEMPLO DE Bin2Byte_Ex-----------",0
txt_description db "Es una conversion de alta velocidad de un valor de notacion BINARIA a un valor de BYTE",0
message 		db "Digitar un valor en BINARIO: ",0
result 			db "Resultado en BYTE: ",0

.code
start:
	invoke ClearScreen
	invoke locate,10,0
	invoke StdOut,ADDR txt_title
	invoke locate,0,1
	invoke StdOut,ADDR txt_description
	invoke locate,0,6
	invoke StdOut,ADDR message
	invoke StdIn,ADDR buffer,LENGTHOF buffer
	invoke bin2byte_ex,ADDR buffer
	PrintDec eax, "Valor en Decimal" ; Si eax = -1, entonces no se pudo realizar la conversión
	invoke locate,0,7
	invoke StdOut,ADDR result
	invoke StdOut,ADDR buffer
	invoke locate,0,10
	invoke ExitProcess,0
	end start