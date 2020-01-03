; Turbo Assembler    Copyright (c) 1988, 1991 By Borland International, Inc.

; HELLO.ASM - Display the message "Hello World"

; From the Turbo Assembler Users Guide - Getting started

   .MODEL small
   .STACK 100h
   .DATA
       newline DB 13,10,'$'
       prompt1 DB 'Entre com o primeiro numero:',13,10,'$'
       var1 DB 1
       prompt2 DB  'Entre com o segundo numero:',13,10,'$' 
       var2 DB 1
       prompt3 DB 'O resultado da soma eh:',13,10,'$' 
       var3 DB ' ',13,10,'$'
       prompt4 DB 'Caracter nao eh digito!',13,10,'$' 

   .CODE
   mov  ax,@data
   mov  ds,ax                  ;set DS to point to the data segment

FAZ_DE_NOVO1:
   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt1      ;point to "Entre com o primeiro numero"
   int  21h                    ;display "Hello, world"

   mov ah,1   ; funcao 1 da int 21 h, pega caracter com eco.
   int 21h ; caracter que eu peguei, vai em al
   sub al,30h 

   ; verificar se o primeiro caracter pego é um digito
   ; tenho que verificar se o caracter em al, está entre 0 e 9.     
   jb NOT_DIGIT
   cmp al,9
   ja  NOT_DIGIT
   ; senão é digito               
 
  mov [var1],al; salvo caracter que eu peguei em al.
   
   jmp FINALIZA1 
NOT_DIGIT: 

   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt4      ;
   int  21h                    ;display "Hello, world"
   jmp  FAZ_DE_NOVO1
   

FINALIZA1:




   mov ah,9 ; vou pular uma linha
   mov dx,OFFSET newline
   int 21h

FAZ_DE_NOVO2:
                                                               
   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt2      ;Entre com o segundo numero
   int  21h                    ;display "Hello, world"

   mov ah,1   ; funcao 1 da int 21 h, pega caracter com eco.
   int 21h ; caracter que eu peguei, vai em al
   sub al,30h 
   
   ; tenho que verificar se o caracter em al, está entre 0 e 9.     
   jb NOT_DIGIT2
   cmp al,9
   ja  NOT_DIGIT2
                  
   mov [var2],al; caracter é um digito   

   
   jmp FINALIZA2 
NOT_DIGIT2: 

   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt4      ;
   int  21h                    ;display "Hello, world"
   jmp FAZ_DE_NOVO2 
   

FINALIZA2:

   mov ah,9               ; vou pular linha
   mov dx,OFFSET newline
   int 21h


   mov al,[var2]
   mov bl,[var1]
   add al,bl
   add al,30h
   mov [var3],al
   
   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt3      ;point to "o resultado é"
   int  21h                    ;
       


   mov ah,9
   mov dx, OFFSET var3
   int 21h

   mov ah,9               ; vou pular linha
   mov dx,OFFSET newline
   int 21h
   mov  ah,4ch                 ;DOS terminate program function
   int  21h                    ;terminate the program
   END
