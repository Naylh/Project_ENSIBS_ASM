;===========================================================
; Robin MARCHAND
; Lucas CHAPRON
; Date : 17/05/2022
; Description : 2ème Programme du Module Assembleur
; Path : MessageBox.asm
;===========================================================


.386
.model flat,stdcall
option casemap:none

;===========================================================
; Liste des includes et includelib
include c:\masm32\include\windows.inc
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


; ----------------
; Variables initialisees
; ----------------
.DATA
MsgBoxTitre  db  "TP1 MARCHAND / CHAPRON",0 ; Titre de la fenetre
MsgBoxTexte  db  "MessageBox => OK pour quitter.",0 ; Message a afficher


; ----------------
; Variables non-initialisees (bss)
; ----------------
.DATA? 


; ----------------
; Section du code
; ----------------
.CODE
start:
	push MB_OK			; On place le 4e argument sur la pile (bouton OK) 			; On peut aussi mettre MB_OKCANCEL
	push offset MsgBoxTitre		; On place le 3e argument sur la pile (titre de la MessageBox) 		; On peut aussi mettre NULL
	push offset MsgBoxTexte		; On place le 2de argument sur la pile (texte de la MessageBox) 	; On peut aussi mettre NULL
	push NULL			; On place le 1re arguement sur la pile (le parent de la MessageBox, ici null car elle n'a pas de parent) ; On peut aussi mettre NULL
	call MessageBox			; Appel a la MessageBox(HWND hWnd, LPCTSTR lpText, LPCTSTR lpCaption, UINT uType) ; On peut aussi mettre MessageBoxA

	; On aurait pu utiliser ceci pour ne pas pousser sur la pile les arguments : 
	; "invoke MessageBox, NULL, addr MsgBoxTexte, addr MsgBoxTitre, MB_OK"

	invoke	ExitProcess,NULL 	; On quitte le programme
					; push NULL 
					; call ExitProcess

end start

