.MODEL small
.STACK 100h
.DATA
      Message1  DB 'Entre com um numero',13,10,'$'
      Message2  DB 'O produto dos dois numeros eh',13,10,'$'
      Numero1 DB 0,13,10,'$'
      Numero2 DB 0,13,10,'$'
      Resultado DB 0,0,0,0,13,10,'$'
      PulaLinha DB 13,10,'$'
.CODE
      mov ax,@DATA
      mov ds,ax
      mov ah,9
      mov dx, OFFSET Message1
      int 21h
      mov ah,1
      int 21h
      sub al,30h
      mov [Numero1],al
      mov ah,9
      mov dx, OFFSET PulaLinha
      int 21h
      mov ah,9
      mov dx, OFFSET Message1
      int 21h
       mov ah,1
      int 21h
      sub al,30h
      mov [Numero2],al
      ; multiplicar os dois números

      mov ah,9
      mov dx, OFFSET PulaLinha
      int 21h

      mov ah,9
      mov dx, OFFSET Message2
      int 21h



      mov bl,[Numero1]
      mov al,[Numero2]
      mul bl ; ax <-- al*bl 

      add ax,30h

       mov [Resultado],al  
      mov dx, OFFSET Resultado
      mov ah,9
      int 21h
     mov ah,4ch
      int 21h
END
       
           
