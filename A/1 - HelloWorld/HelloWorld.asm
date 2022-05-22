;===========================================================
; Robin MARCHAND
; Lucas CHAPRON
; Date : 17/05/2022
; Description : 1er Programme du module Assembleur
; Path : HelloWord.asm
;===========================================================


.386 
.model flat,stdcall ; 
option casemap:none

;===========================================================
; Liste des includes et includelib
include c:\masm32\include\windows.inc ; 
include c:\masm32\include\gdi32.inc
include c:\masm32\include\gdiplus.inc
include c:\masm32\include\user32.inc
include c:\masm32\include\kernel32.inc
include c:\masm32\include\msvcrt.inc

includelib c:\masm32\lib\gdi32.lib
includelib c:\masm32\lib\kernel32.lib
includelib c:\masm32\lib\user32.lib
includelib c:\masm32\lib\msvcrt.lib
;===========================================================

.DATA
; variables initialisees
Phrase     db    "Hello World : %d",10,0 ; 10 caracteres
strCommand db "Pause",13,10,0  ; 13 = CR ; 10 = LF ; 0 = fin de chaine

.DATA?
; variables non-initialisees (bss)

.CODE ; 
start:
		; on place le premier argument de la fonction appelée sur la pile
		push 42 ; on place 42 sur la pile
		; On place le second argument de la fonction appelée sur la pile
        push offset Phrase ; on place l'adresse de la chaine de caracteres Phrase sur la pile
        ; call printf 
        call crt_printf ; on appelle la fonction crt_printf
		
		
		invoke crt_system, offset strCommand ; on appelle la fonction crt_system
		mov eax, 0 ; on place 0 sur la pile
	    invoke	ExitProcess,eax ;

end start ; Fin du programme

