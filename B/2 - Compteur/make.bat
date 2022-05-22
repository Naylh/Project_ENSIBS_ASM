@echo off
c:\masm32\bin\ml /c /Zd /coff Compteur.asm
c:\\masm32\bin\Link /SUBSYSTEM:CONSOLE Compteur.obj
pause