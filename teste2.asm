.MODEL small
.STACK 100h
.DATA
oi db "oi",'$'
.CODE
     mov ax,10
     mov bx,10
     div bl
     
     ;mov cl,al
     mov ch,ah
     mov ah,2h
     mov dx,cx
     add dx,48
     int 21h
          mov ah,4ch
     int 21h

END
