;===========================================================
; Robin MARCHAND
; Lucas CHAPRON
; Date : 17/05/2022
; Description : 5ème Programme du Module Assembleur
; Path : myst.asm
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
        nNombre dword 0                      ; Entier 32bits .

        strFormat  db "%d", 0                ; Permet de spécifier que l'entrée utilisateur est un entier.

        strMsg  db  "Entrez un nombre : ", 0 ; Message d'entrée utilisateur.

        strMsgSortie db  "factorielle du nombre choisi : %d", 10, 13, 0 ; 13 = CR LF (Carriage Return + Line Feed) 

        strCommand db "Pause", 13, 10, 0     ; Commande pour afficher la commande pause

; ----------------
; Variables non-initialisees (bss)
; ----------------
.DATA?


; ----------------
; Section du code
; ----------------
.CODE

; Routine Facto 
Facto proc ; Routine Facto
        push ebp                         ; Sauvegarde de la pile
        mov ebp,esp                      ; Initialisation de la pile
        mov eax,[ebp+8]                  ; Récupère n

        cmp eax,1                        ; n > 0?
        ja continuer                     ; True : on continue.
        jmp retour_recur                 ; False : retour récursif.

        continuer:                      ; On continue
                dec eax                 ; n--
                push eax                ; Empile EAX.
                call Facto              ; Appel récursif de Facto(EAX).

                                        ; Executé après tous les retours récursifs de Facto.
        mov ebx,[ebp+8]                 ; Récupère n.
        mul ebx                         ; EAX = EAX * EBX.

        retour_recur:                 	; Retour de la fonction.
                pop ebp                 ; Retourne EAX.

        ret 4                           ; Nettoyage de la pile.

Facto endp                             	; Fin de la routine Facto.


start:                                 	; Routine de départ.
        push offset strMsg              ; Empile le message de début.
        call crt_printf                 ; Affiche "Entrez un nombre : ".

        push offset nNombre             ; Premier paramètre de scanf.
        push offset strFormat           ; Deuxième paramètre de scanf. 
        call crt_scanf                  ; scanf ("%d",&nNombre).
        
        mov eax, nNombre                ; On met le nombre saisi dans EAX.

        push eax                        ; Empile EAX.
        call Facto                      ; Facto(EAX).

        push eax                        ; Récupère la factorielle calculé .
        push offset strMsgSortie        ; Empile le message de sortie.
        call crt_printf                 ; Affiche "factorielle du nombre choisi : ".

        invoke crt_system, offset strCommand 	; Affiche la commande pause.
        invoke ExitProcess, NULL       		; Fin du programme.

end start
