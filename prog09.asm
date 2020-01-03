.MODEL small
.STACK 100h
.DATA
Message1 DB 'Entre com um numero:',13,10,'$'
Numero DB 0,13,10,'$'
Resultado DW 0,0,0,0,13,10,'$'
Message2 DB 'O fatorial do numero eh',13,10,'$'
PulaLinha DB 13,10,'$'
Vetor DB 0,0,0,0,0,13,10,'$'
Tam DB 5
.CODE
mov ax,@DATA
mov ds,ax
mov ah,9
mov dx, OFFSET Message1
int 21h
mov ah,1
int 21h
mov [Numero],al
mov ah,9
mov dx, OFFSET PulaLinha
int 21h
xor ah,ah
mov al, [Numero]
sub al,30h
mov [Resultado],ax
FATORIAL:
     dec ax
    cmp ax,0000
    je ACABOU
   push ax
   mov bx,[Resultado]
   mul bx
    mov [Resultado],ax
    pop ax
    jmp FATORIAL
ACABOU:
     mov ah, 9
     mov dx, OFFSET Message2
     int 21h
    xor ah,ah
     mov ax,[Resultado]
     call int2ascii
     mov ah,9
     mov dx, OFFSET Vetor
     int 21h
     mov ah,4ch
     int 21h



int2ascii proc near
               mov bx, 0aH ; coloca 10 em bx
INICIO_CONVERSAO:
                 div bl ; divide ax por bl --> quociente em al, resto em ah
                 call converte_e_armazena
                 cmp al,0
                 je FIM_CONVERSAO
                xor ah,ah
               jmp INICIO_CONVERSAO
FIM_CONVERSAO:
            ret
endp


converte_e_armazena proc near
        push bx
        xor ch,ch
        mov cl, [Tam]
        mov si, cx
        mov bx, OFFSET Vetor
        add ah, 30h
        mov [bx][si],ah
       dec cx
       mov [Tam],cl
       pop bx
       ret
ENDP

END
