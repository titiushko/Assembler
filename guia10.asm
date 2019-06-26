.386
.model flat, stdcall
option casemap :none
.Nolist
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
.List
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
.DATA
TAMMAX = 20
codsal db 0
nDatos db 20
datos dw -2, 12,23,43,134,-56,-35,76,58,-34,56,-65
      dw 54,76,79,-37,-73,-689,65,90
posit dw TAMMAX dup(?)
negat dw TAMMAX dup(?)
NPOS DW 0
NNEG DW 0
MSJ1 DB 13,10,"VALORES POSITIVOS: ",13,10,0
MSJ2 DB 13,10,"VALORES NEGATIVOS: ",13,10,0
IMP DB 8 DUP(" ")
CRLF DB 13,10,0
FLAG DB 0
.CODE
inicio:
mov ebx, offset datos
mov esi, offset posit
mov edi, offset negat
xor ecx,ecx
mov cl, [nDatos]
call POSNEG
invoke StdOut, addr MSJ1
invoke StdOut, addr CRLF
xor ecx,ecx
MOV CX,[NPOS]
MOV ESI, OFFSET posit
LAZO1:
	PUSH ECX
	MOV AX, [ESI]
	PUSH ESI
	LEA ESI,IMP+7
	CALL WRITE
	invoke StdOut, addr IMP
	LEA ESI,IMP
	MOV ECX,8
	LA1:
	MOV [ESI], BYTE PTR " "
	INC ESI
	LOOP LA1
	POP ESI
	POP ECX
	INC ESI
	INC ESI
	LOOP LAZO1
invoke StdOut, addr MSJ2
invoke StdOut, addr CRLF
xor ecx,ecx
MOV CX,[NNEG]
MOV ESI, OFFSET negat
LAZO2:
PUSH ECX
MOV AX, [ESI]
PUSH ESI
LEA ESI,IMP+7
CALL WRITE
invoke StdOut, addr IMP
LEA ESI,IMP
MOV ECX,8
LA2:
MOV [ESI], BYTE PTR " "
INC ESI
LOOP LA2
POP ESI
POP ECX
INC ESI
INC ESI
LOOP LAZO2
salir:
invoke ExitProcess, 0

WRITE PROC
PUSH EAX
PUSH EBX
PUSH ECX
PUSH EDX
MOV ECX,10
CMP AX,0
JGE C20
NEG AX
C20:
CMP AX,CX
JB C30
XOR DX,DX
DIV CX
OR DL,30H
MOV [ESI],DL
DEC ESI
JMP C20
C30:
OR AL,30H
MOV [ESI],AL
POP EDX
POP ECX
POP EBX
POP EAX
CMP AX,0
JGE SALI
MOV [ESI-1], BYTE PTR "-"
SALI:
RET
WRITE ENDP

POSNEG proc
	push eax
	jcxz enddo
do:
	mov ax, [ebx]
	cmp ax, 0
	jge posits
	mov [edi], ax
	inc edi
	inc edi
	inc [NNEG]
	jmp sigue
posits:
	mov [esi], ax
	inc esi
	inc esi
	inc [NPOS]
sigue:
	inc ebx
	inc ebx
	loop do
enddo:
	pop eax
	ret
POSNEG endp
END inicio