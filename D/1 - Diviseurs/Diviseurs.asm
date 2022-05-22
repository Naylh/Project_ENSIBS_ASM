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
        nNombre dword 0                     	; Entier 32bits .

        strFormat  db "%d", 0                	; Permet de spécifier que l'entrée utilisateur est un entier.

        strMsg  db  "Entrez un nombre : ", 0 	; Message d'entrée utilisateur.

        strMsgSortie db  "Diviseur du nombre choisi : ", 0 ; Message de sortie.

        strSortie db "%d ", 0               	; Permet de spécifier que l'entrée utilisateur est un entier.
        
        strCommand db "Pause", 13, 10, 0    	; Commande pour afficher le message de sortie.

; ----------------
; Variables non-initialisees (bss)
; ----------------
.DATA?


; ----------------
; Section du code
; ----------------
.CODE
start:
        push offset strMsg              ; Empile le message de début.
        call crt_printf                 ; Affiche "Entrez un nombre : ".

        push offset nNombre             ; Premier paramètre de scanf.
        push offset strFormat           ; Deuxième paramètre de scanf. 
        call crt_scanf                  ; scanf ("%d",&nNombre).

        push offset strMsgSortie        ; Empile le message de sortie.
        call crt_printf                 ; Affiche "Diviseur du nombre choisi : ".
        
        mov eax, 1                     	; Initialise le compteur.
        mov [ebp-4], eax                ; Initialisation de i à 1.

	for_loop:                       ; Boucle for.
                mov ebx, nNombre        ; On stocke le nombre dans ebx.
                
                cmp [ebp-4], ebx                ; Si i est plus petit ou égal à n on quitte la boucle.
                jg end_for                      ; Sinon on passe à la suite.
                
                xor edx, edx                    ; Initialise le registre EDX avec la valeur 0.  
                mov eax, nNombre                ; Ajoute le nombre entré dans le registre EAX.
                mov ecx, [ebp-4]                ; Ajoute i dans le registre ECX.
                div ecx                         ; Fait le calcul nNombre mod i et ajoute le résultat dans EDX.

                cmp edx, 0                     ; Si le résultat est égal à 0 on passe à la suite.
                je afficher_sortie              ; Si le résultat vaut 0, alors i est un diviseur de nNombre.
       

        increment_i:                          ; On incrémente i.
                mov eax,[ebp-4]                 ; On récupère i et on le met dans le registre EAX.
                inc eax                         ; Incrémente EAX.
                mov [ebp-4], eax                ; On remet la valeur de EAX dans i.
                jmp for_loop                    ; Retour dans la boucle pour.


        afficher_sortie:                     ; Affiche le résultat.
                push [ebp-4]                    ; Empile i.
                push offset strSortie           ; Empile le message de sortie.
                call crt_printf                 ; Affiche un des diviseurs du nombre entré.
                jmp increment_i                 ; Retour dans la boucle for.


        end_for:
                invoke crt_system, offset strCommand ; Affiche le message de sortie.
                invoke ExitProcess, NULL       ; Quitte le programme.

end start
