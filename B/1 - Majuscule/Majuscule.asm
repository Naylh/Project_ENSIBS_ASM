;===========================================================
; Robin MARCHAND
; Lucas CHAPRON
; Date : 17/05/2022
; Description : 3ème Programme du Module Assembleur
; Path : Majuscule.asm
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

	Chaine db "Chaine de test ~# ", 13, 10, 0 ; 13 = CR, 10 = LF, 0 = fin de chaine
	strCommand db "Pause", 13, 10, 0 ; 13 = CR, 10 = LF, 0 = fin de chaine

; ----------------
; Variables non-initialisees (bss)
; ----------------
.DATA?


; ----------------
; Section du code
; ----------------
.CODE

; Routine toMaj 
toMaj proc
	 	        	; AL == le caractère à modifier. ; AH == le caractère à remplacer
        cmp   AL,'a'		; Compare le caractère avec 'a' (97 en ASCII). ; si c'est le cas, on passe à la suite
        jb    sortie		; Si le caractère est plus petit, (donc un caractère en dessous du code ASCII) retourne le caractère. ; sinon, on passe à la suite
        cmp   AL,'z'		; Compare le caractère courant avec 'z' (122 en ASCII). ; si c'est le cas, on passe à la suite
        ja    sortie		; Si le caractère est plus grand, (donc un caractère au dessus du code ASCII) retourne le caractère. ; sinon, on passe à la suite
        sub   AL,32		; Si le caractère est donc une minuscule, on va soustraire 32 au code ASCII pour recuperer une masjucule. ; sinon, on passe à la suite

					; ASCII majuscule vont de 65 à 90 donc pour avoir un caractère minuscule en majuscule on soustrait 32. 
					; au caractère minucule.
	sortie:     
			ret   		; Retourne le caractère modifié
toMaj endp 				; Fin de la routine

start:
	push offset Chaine		 	; Charge la chaine de caractère dans la pile
	call crt_printf				; Affiche le message de base. 

	mov ebx, offset Chaine 		  	; ebx = adresse de la chaine de caractère

	begin_loop: ; Boucle infinie
		mov AL, [ebx]			; On récupère le premier caractère.
		cmp AL, 0                 	; Si le caractère est 0, on sort de la boucle.
		jz end_loop		 	; Si on est en fin de phrase, on quitte la boucle.
		call toMaj			; Appel à la routine pour mettre en majuscule la lettre ou non.
		mov [ebx], AL			; On remplace le caractère original pour le nouveau (on majuscule ou non).
		inc ebx				; On itère sur la chaine.
		jmp begin_loop			; Retour au début de la boucle.

	end_loop: ; Fin de la boucle
		push offset Chaine		; Charge la chaine de caractère dans la pile
		call crt_printf			; Affiche le message en majuscule.

		invoke crt_system, offset strCommand 	; Appel à la fonction systeme pour faire la pause.
		invoke	ExitProcess,NULL 		; Quitte le programme.

end start 						; Fin de la routine	