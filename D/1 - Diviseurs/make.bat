@echo off
c:\masm32\bin\ml /c /Zd /coff Diviseurs.asm
c:\\masm32\bin\Link /SUBSYSTEM:CONSOLE Diviseurs.obj
pause