.MODEL small
.STACK 100h
.DATA
array db 0,0,0,0,0,13,10,'$'
tam db 5
.CODE
     mov ax,@data
     mov ds,ax
     xor ch,ch
     mov cl,[tam]     
     mov si,cx
     mov bx, OFFSET array
     mov ah,5
     add ah,30h
     mov [bx][si],ah
     dec cx
     mov si,cx
     mov ah,3
     add ah,30h
     mov [bx][si],ah
     dec cx
     mov [tam],cl
     mov ah,9
     mov dx, OFFSET array
     int 21h
     mov si,
     mov ah,4ch
     int 21h



END
