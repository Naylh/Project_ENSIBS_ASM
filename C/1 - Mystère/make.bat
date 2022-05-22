@echo off
c:\masm32\bin\ml /c /Zd /coff myst.asm
c:\\masm32\bin\Link /SUBSYSTEM:CONSOLE myst.obj
pause