@echo off
set /p filename=Nombre del archivo ASM: 
del %filename%.exe /Q
del %filename%.lst /Q
del %filename%.map /Q
del %filename%.obj /Q
ml /c /coff /Fl %filename%.asm
link /map /subsystem:console %filename%
%filename%.exe
pause