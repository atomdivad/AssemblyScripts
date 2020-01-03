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

   .CODE
   mov  ax,@data
   mov  ds,ax                  ;set DS to point to the data segment

   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt1      ;point to "Entre com o primeiro numero"
   int  21h                    ; exibe a primeira mensagem

   mov ah,1   ; funcao 1 da int 21 h, pega caracter com eco.
   int 21h ; caracter que eu peguei, vai em al
   sub al,30h ;subtrai 30h que é o código ascii do caracter 0. 

   mov [var1],al; salvo caracter que eu peguei em al.
   
   mov ah,9 ; pulo uma linha
   mov dx,OFFSET newline
   int 21h

                                                              
   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt2      ;Entre com o segundo numero
   int  21h                    ;

   mov ah,1   ; funcao 1 da int 21 h, pega caracter com eco.
   int 21h ; caracter que eu peguei, vai em al
   sub al,30h 
                     
   mov [var2],al; estou supondo sem 
                ;verificar que o caracter é um dígito


   mov ah,9               ; vou pular linha
   mov dx,OFFSET newline
   int 21h

   mov al,[var2]    ;recupera em al o valor armazenado em var2
   mov bl,[var1]    ;recupera em bl o valor armazenado em var1
   add al,bl        ; soma al com bl, o resultado fica em al
   add al,30h       ; soma 30h com al, pois 30h é o código ASCII
   mov [var3],al    ; do caracter 0.  Note que isso dá problema
                    ; se a soma passar de 10!
   
   mov  ah,9                   ;DOS print string function
   mov  dx,OFFSET prompt3      ;point to "o resultado é"
   int  21h                    ;

   mov ah,9
   mov dx, OFFSET var3 ; exibe o resultado
   int 21h

   mov ah,9               ; vou pular linha
   mov dx,OFFSET newline
   int 21h

   mov  ah,4ch                 ;DOS terminate program function
   int  21h                    ;terminate the program
   END
