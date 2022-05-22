@echo off
c:\masm32\bin\ml /c /Zd /coff Factorielle.asm
c:\\masm32\bin\Link /SUBSYSTEM:CONSOLE Factorielle.obj
pause