;===========================================================
; Robin MARCHAND
; Lucas CHAPRON
; Date : 17/05/2022
; Description : 4ème Programme du Module Assembleur
; Path : Compteur.asm
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
	strMsgEntre db "TP Marchand/Chapron", 13, 10, 0 ; 13 caracteres + 1 caractere de fin de chaine + 1 caractere de fin de ligne
	strMsgSortie db "Nombre de caractere : %d", 13, 10, 0 ; 13 caracteres + 1 caractere de fin de chaine + 1 caractere de fin de ligne
	strCommand db "Pause", 13, 10, 0 ; 13 caracteres + 1 caractere de fin de chaine + 1 caractere de fin de ligne


; ----------------
; Variables non-initialisees (bss)
; ----------------
.DATA? 


; ----------------
; Section du code
; ----------------
.CODE

; Routine cptCarac
cptCarac proc
	mov eax,[ebp-4]				; Récupère depuis la pile l'état du compteur et le met dans le registre EAX.
	inc eax					; Incrémente EAX.
	mov [ebp-4], eax			; Replace le compteur sur la pile.
	ret
cptCarac endp ; Fin de la routine cptCarac

start: ; Début de la routine start
	push offset strMsgEntre		 	; Push de la chaine de caractere dans la pile.
	call crt_printf				; Affiche la chaine de caractère. 

	mov eax, -2				; Initialisation du compteur à -2 pour ne pas compter les caractères CRLF. 
	mov [ebp-4], eax           		; Le compteur est placé sur la pile.

	mov ebx, offset strMsgEntre 		; Met la chaine d'entrée dans le registre ebx.

	begin_loop: ; Début de la boucle
		mov AL, [ebx]			; Récupère le premier caractère.
		cmp AL, 0               	; Si on est en fin de phrase, on quitte la boucle.
		jz end_loop		   	; Sinon, on passe à la suite. 		
		
		call cptCarac			; Appel à la routine pour itérer le compteur.
		inc ebx				; Itère sur la chaine.
		jmp begin_loop			; Retour au début de la boucle.

	end_loop: ; Fin de la boucle
		push [ebp-4] 		  	; Push du compteur dans la pile.
		push offset strMsgSortie 	; Push de la chaine de caractere dans la pile.	
		call crt_printf			; Affiche le message en majuscule.

		invoke crt_system, offset strCommand 	; Invoke de la commande system.
		invoke	ExitProcess,NULL 		; Invoke de la commande ExitProcess.

end start ; Fin de la routine start

