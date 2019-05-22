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
Buffer db 127 dup(" "),0
Msg1 db "Introduzca cualquier texto (127 maximo)> ",0
Msg2 db "Usted Digito: ",0
.code
start:
invoke ClearScreen
invoke locate,10,10
invoke StdOut,ADDR Msg1
invoke StdIn,ADDR Buffer,LENGTHOF Buffer
invoke locate,10,12
invoke StdOut,ADDR Msg2
invoke locate,10,13
invoke StdOut,ADDR Buffer
invoke ExitProcess,0
end start 