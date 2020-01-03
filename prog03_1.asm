.model small
.stack
.code
    mov dl,'A' ; imprime caracter a
 
    mov cx,26
imprime:   
    call print_char 
    inc  dl
    loop imprime
    
    mov dl,10
    call print_char

    mov dl,13
    call print_char

    mov ah, 4ch ; chama a função 4ch da int 21 h, que devolve o
    int 21h     ; controle para o Power Shell


;dl é um parametro para procedimento.

print_char proc 
   mov ah,2 ; função 2 da int 21h imprime o caracter q está em dl.
    int 21h  ;
    ret;
print_char endp





END