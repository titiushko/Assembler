.386
.model flat, stdcall
option casemap :none
.nolist
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
.list
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
buffer1			db 127 dup(" "),0
buffer2			db 2 dup(" "),0
txt_title 		db "-----------EJEMPLO DE HexFlip32-----------",0
txt_description db "Convertir un valor HEX normal a un HEX de orden de memoria. Se acepta notacion hexadecimal de formato de ensamblador con la h al final y opcionalmente un 0 inicial. La longitud total de la cadena no debe exceder los 10 bytes, incluyendo h y 0.",0
message1 		db "Digitar un valor en HEX (ejemplo: 01199AAFFh): ",0
message2 		db "Hacer otra prueba? (S/N): ",0
result 			db "Resultado en HEX de orden de memoria: ",0

.code
start:
	invoke ClearScreen
	invoke locate,10,0
	invoke StdOut,ADDR txt_title
	invoke locate,0,1
	invoke StdOut,ADDR txt_description
	invoke locate,0,6
	invoke StdOut,ADDR message1
	invoke StdIn,ADDR buffer1,LENGTHOF buffer1
	invoke hexflip32,ADDR buffer1
	invoke locate,0,7
	invoke StdOut,ADDR result
	invoke StdOut,ADDR buffer1
	;SALIR?
	invoke locate,0,9
	invoke StdOut,ADDR message2
	invoke StdIn,ADDR buffer2,LENGTHOF buffer2
	CMP buffer2,"N"
	JE finish
	CMP buffer2,"n"
	JE finish
	JNE start
finish:
	invoke locate,0,12
	invoke ExitProcess,0
	end start