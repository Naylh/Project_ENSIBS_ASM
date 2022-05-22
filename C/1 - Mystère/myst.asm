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

.DATA
Phrase     db"Le resultat de Fibonacci pour %d est : %d",10,0 ; On affiche le resultat de Fibonacci
chaine 	   db"TP Marchand/Chapron",0 ; On affiche le nom du programme
PhraseCount db"La chaine de caracteres '%s' contient %d 'a', %d 'b', %d 'c'",10,0 ; On affiche le nombre de lettres
strCommand db "Pause",13,10,0 ; On affiche la commande Pause

.CODE
myst :
	push ebp		; Sauvegarde de l'adresse de base du pointeur
	mov ebp,esp		; Chargement de l'adresse du stack dans le registre de base du pointeur
	sub esp, 16		; Sauvegarde de 16 octetcs pour les variables locales (4 octets chacun)
	mov eax, 3		; Initialisation de la variable locale i
	mov [ebp-4], eax 	; Sauvegarde de la valeur de i dans la zone mémoire
	mov eax, 1		; Initialisation de la variable locale j
	mov [ebp-8], eax 	; Sauvegarde de la valeur de j dans la zone mémoire
	mov eax, 1		; Initialisation de la variable locale k
	mov [ebp-12], eax 	; Sauvegarde de la valeur de k dans la zone mémoire
	xor eax, eax		; Initialisation de la variable locale l
	mov [ebp-16], eax 	; Sauvegarde de la valeur de l dans la zone mémoire
	mov ebx, [ebp+8]	; Récupération de la valeur n
	for_1: 			; Boucle for
	  cmp [ebp-4], ebx	; Vérification de i<=n
	  jg end_for_1 		; Si i>n, on sort de la boucle
	  mov eax,[ebp-8]	; Récupération de la valeur j
	  add eax,[ebp-12] 	; j = j + k
	  mov [ebp-16],eax 	; l = j
	  mov eax,[ebp-12]	; Récupération de la valeur k
	  mov [ebp-8],eax 	; j = k
	  mov eax,[ebp-16]	; Récupération de la valeur l
	  mov [ebp-12],eax 	; k = l
	  mov eax,[ebp-4]	; Récupération de la valeur i
	  inc eax 		; i++
	  mov [ebp-4], eax 	; Sauvegarde de la valeur de i dans la zone mémoire
	  jmp for_1 		; On recommence la boucle
	end_for_1: 		; Fin de la boucle for
	  mov eax, [ebp-12]	; Déplacement de k dans le registre de retour
	  mov esp, ebp		; Nettoyage des variables locales
	  pop ebp		; Restauration de l'adresse de base du pointeur
	  ret 			; Retour de la fonction

count:
	push ebp			; Sauvegarde de l'adresse de base du pointeur
	mov ebp,esp			; Chargement de l'adresse du stack dans le registre de base du pointeur
	sub esp, 12			; Sauvegarde de 12 octets pour les variables locales (4 octets chacun)
	xor eax, eax 			; Initialisation de la variable locale i
	mov [ebp-4], eax		; Initialisation de la variable locale a
	mov [ebp-8], eax		; Initialisation de la variable locale b
	mov [ebp-12], eax		; Initialisation de la variable locale c
	mov eax, [ebp+8]		; Récupération de l'argument n
	mov ecx, 1 			; Initialisation de la variable locale i
	for_2: 				; Boucle for
	  mov bl, [eax] 		; On récupère le caractère de la chaine
	  is_A: 			; Boucle if
	    cmp bl, 97			; i = 'a'
	    jne is_B 			; Si i!='a', on passe à la suite
      	    add [ebp-4], ecx 		; a = a + i
            jmp end_for_2 		; On sort de la boucle for
	  is_B: 			; Boucle if
	    cmp bl, 98			; i = 'b'
	    jne is_C 			; Si i!='b', on passe à la suite
      	    add [ebp-8], ecx 		; b = b + i
            jmp end_for_2  		; On sort de la boucle for
	  is_C: 			; Boucle if
	    cmp bl, 99			; i = 'c'
	    jne end_for_2 		; Si i!='c', on sort de la boucle
      	    add [ebp-12], ecx 		; c = c + i
            jmp end_for_2 		; On sort de la boucle
	end_for_2:			; Fin de la boucle for
	  inc eax 			; i++
	  cmp bl,0 			; On vérifie si i<=n
	  jne for_2 			; Si i<=n, on recommence la boucle
	mov eax, [ebp-4]		; Déplacement de a dans le registre de retour eax
 	mov ebx, [ebp-8]		; Déplacement de b dans le registre de retour ebx
  	mov ecx, [ebp-12]		; Déplacement de c dans le registre de retour ecx
	mov esp, ebp			; Nettoyage des variables locales
	pop ebp				; Restauration de l'adresse de base du pointeur
	ret
	
start:
	push 12 			; On pousse 12 octets dans le stack
	call myst 			; On appelle la fonction myst

	push eax 			; On pousse la valeur de eax dans le stack
	push 12 			; On pousse 12 octets dans le stack
        push offset Phrase 		; On pousse l'adresse de la chaine dans le stack
        call crt_printf 		; On appelle la fonction crt_printf
	
	push offset chaine 		; On pousse l'adresse de la chaine dans le stack
    	call count 			; On appelle la fonction count

	push ecx 			; On pousse la valeur de ecx dans le stack
    	push ebx 			; On pousse les valeurs de ebx et ecx dans le stack
   	push eax 			; On pousse la valeur de eax dans le stack
    	push offset chaine 		; On pousse l'adresse de la chaine dans le stack
    	push offset PhraseCount 	; On pousse l'adresse de la chaine dans le stack
    	call crt_printf 		; On appelle la fonction crt_printf

	
	invoke crt_system, offset strCommand 	; On appelle la fonction crt_system
	mov eax, 0 				; On initialise eax à 0
	invoke	ExitProcess,eax 
end start 					; Fin de la fonction start




	

