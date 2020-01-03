.MODEL small
.STACK 100h
.DATA
      Message1  DB 'Entre com um numero',13,10,'$'
      Message2  DB 'O produto dos dois numeros eh',13,10,'$'
      Numero1 DB 0,13,10,'$'
      Numero2 DB 0,13,10,'$'
      Resultado DB 0,0,0,0,13,10,'$'
      PulaLinha DB 13,10,'$'
      Vetor DB 0,0,0,0,0,13,10,'$'
      Tam    DB 5
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

      ;ax eh um parametro para int2ascii
      call int2ascii

         
      mov dx, OFFSET Vetor
      mov ah,9
      int 21h
     mov ah,4ch
      int 21h


int2ascii PROC NEAR                 ; parametro eh passado em ax
                   push dx
                   xor dx,dx ; zera o registrador dx.
                   mov bx,0Ah       ; que eh o numero hexa que quero converter para caracteres
inicio_conversao:  div bx      ;divide dx:ax por bx --> quociente em ax e resto em dx.
                   call converte_e_armazena ; somar 30h em dl e armazenar dl em um vetor
                   cmp ax,0
                   je  fim_conversao
                   xor dx,dx ; senão, zera dx.
                   jmp inicio_conversao
                   
fim_conversao:     pop dx
                   ret

ENDP


converte_e_armazena PROC NEAR
       push bx
       mov cl,[Tam]  ; Tam é o tamanho do vetor
       xor ch,ch     ; cx = *Tam 
       mov si,cx     ; não poderia ser mov cx,[Tam], pois Tam
                     ; indexa um byte.
       add dx,30h   ; 30h é o código ascii do caracter 0
       mov bx, OFFSET Vetor
       mov [bx][si],dl      ; mov [bx+si],dl
       dec cx
       mov [Tam],cl  ; (*Tam) --
       pop bx
       ret
ENDP


END
       
           
