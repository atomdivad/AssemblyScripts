.MODEL small
.STACK 100h
.DATA
array db 0,0,0,0,0,13,10,'$'
tam db 5
.CODE
     mov ax,@data
     mov ds,ax
     mov ax,6
     call FIB 
     mov ah,4ch
     int 21h

FIB PROC  ; proc indica que o procedimento print_a_j começa aqui
  push ax
  mov bp,0
  mov si,1
  mov bx,0
  mov CX,ax ;se não funcionar mude o CX para cx 
PRINT_LOOP:
  mov bx,0
  add bx,bp
  add bx,si
  mov si,bp
  mov ah,10
  mov bp,bx
  mov dx,bx
  add dx,48
  call WRITE_CHAR
  loop PRINT_LOOP ;laço para imprimir 7 caracteres
ret
FIB   ENDP  ; endp indica que o procedimento print_a_j termina aqui.


WRITE_CHAR  PROC
  mov AH,2h       ;função 2h, imprime caracter
  int 21h         ;imprime o caracter que está em DL
  ret             ;retorna o controle ao procedimento que chamou
WRITE_CHAR  ENDP  ;finaliza o procedimento

END
