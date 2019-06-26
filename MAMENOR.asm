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
	vMess1  db "Ingrese los valores:",13,10,0
	vMess2  db "La Matriz Ingresada es:",13,10,0
	vMess3  db "El menor valor es:$" 	
	CRLF    db 13,10,0
	vCol    dw 0
	vMin    db 0
	vBuffer db 65
	vCount  db 0
	vMatriz db 65 dup(?) 

.code
_start:
	invoke ClearScreen
	invoke locate,0,0
	invoke StdOut,ADDR vMess1
	invoke StdOut,ADDR CRLF
	invoke StdIn,ADDR vBuffer,LENGTHOF vBuffer
	mov ebx,0
	mov ecx,vCount
	mov byte ptr vMatriz[ebx],0
	mov vCol,00
	lea esi,vMatriz
	invoke StdOut,ADDR CRLF
	invoke StdOut,ADDR CRLF
	invoke StdOut,ADDR vMess2
	invoke StdOut,ADDR CRLF
_print:
	mov edx,[esi]
	invoke StdOut,ADDR [esi+1]
	inc esi
	inc vCol
	cmp vCol,0008
	je  _row1
	cmp vCol,0016
	je  _row1
	cmp vCol,0024
	je  _row1
	cmp vCol,0032
	je  _row1
	cmp vCol,0040
	je  _row1
	cmp vCol,0048
	je  _row1
	cmp vCol,0056
	je  _row1
	cmp edi,0
	je  _process
	jmp _print
_row1:
	invoke StdOut,ADDR CRLF
	jmp _print
_process:
	lea esi,vMatriz
	mov ebx,00
	mov ecx,vCount
	mov eax,[esi]
	mov vMin,eax
_compare:
	mov edx,[esi]
	inc esi
	cmp ecx,00
	je  _exit
	dec ecx
	cmp vMin,edx
	jg  _assign
	cmp edx,0
	je _exit
	jmp _compare
_assign:
	mov vMin,edx
	jmp _compare
_exit:
	invoke StdOut,ADDR CRLF
	invoke StdOut,ADDR CRLF
	invoke StdOut,ADDR vMess3
	invoke StdOut,ADDR CRLF
	invoke StdOut,ADDR vMin
	invoke ExitProcess,0
end _start
