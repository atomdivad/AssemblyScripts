.MODEL small
.STACK 100h
.DATA
    Message1 DB 'Digite uma sequencia de caracteres:',13,10,'$'
    Message4 DB 'Digite outra sequencia de caracteres:',13,10,'$'
    Message2 DB 'Este nao e um caracter valido:',13,10,'$'
    Message3 DB 'Tamanho do vetor foi excedido',13,10,'$'
    Message5 DB 'Os vetores sao iguais',13,10,'$'
    Message6 DB 'Os vetores sao diferentes',13,10,'$'
    Vetor1 DB  0,0,0,0,0,0,0,0,0,0,13,10,'$'
    Vetor2 DB  0,0,0,0,0,0,0,0,0,0,13,10,'$'
    newline DB 13,10,'$'
    POS db 0                    ;posicao no vetor
    Tam DB 10                   ;constante serve para referencia da posicao
.CODE
    mov  cx,@data               
    mov  ds,cx                  ;set DS to point to the data segment
    xor cx,cx                   ;limpa cx
    mov  ah,9                   ;funcao mostrar na tela
    mov  dx,OFFSET Message1     ;funcao mostrar na tela
    int  21h                    ;funcao mostrar na tela
Pega_caracter_Verifica:
    mov ah,1                    ;funcao 1 da int 21 h, pega caracter 
    int 21h                     ;caracter que eu peguei, vai em al
    cmp cx,0                    ;cx e uma flag em 0 continua operando com o vetor1 | cx=1 opera com vetor2
    je primeiro_vetor           ;se for 0 vetor1
    ja segundo_vetor            ;se for 1 vetor2
primeiro_vetor:    
    cmp al,13                   ;compara bl com 13(enter)
    je PROXIMO_VETOR            ;se for enterentao passa pro proximo vetor
    cmp al,32                   ;compara bl com 32 valor em inteiro de space
    jb NOT_DIGIT                ;verificar se o caracter é valido
    cmp al,127                  ;tenho que verificar se e um caracter q esta em al entre 32 e 126.
    ja  NOT_DIGIT               ;senão é digito
    mov bx, OFFSET Vetor1       ;move vetor1 para bx para usar na funcao de armazenar
    CALL GUARDA_NO_VETOR        ;chamada de funcao pra armazenar no vetor
    jmp Pega_caracter_Verifica  ;retorna para a o inicio
segundo_vetor:
    cmp al,13                   ;compara bl com 13(enter)
    je FINALIZA1                ;se for enterentao passa pro proximo vetor
    cmp al,32                   ;compara bl com 32 valor em inteiro de space
    jb NOT_DIGIT                ;verificar se o caracter é valido
    cmp al,126                  ;tenho que verificar se e um caracter q esta em al entre 32 e 126.
    ja  NOT_DIGIT               ;senão é digito
    mov bx, OFFSET Vetor2       ;move vetor2 para bx
    CALL GUARDA_NO_VETOR        ;chamada de funcao pra armazenar no vetor
    jmp Pega_caracter_Verifica  ;retorna para a o inicio
NOT_DIGIT:
    xor ax,ax                   ;limpa ax
    mov  ah,9                   ;funcao para imprimir cadeia de caracteres
    mov  dx,OFFSET Message2     ;move vetor Message3 em dx
    int  21h                    ;interrupção do sistema e imprime message3
    jmp  Pega_caracter_Verifica ;voltar para o inicio

PROXIMO_VETOR:
    mov cx,1
    mov [POS],0                 ;reseta posicao para trabalhar com o novo vetor
    mov [Tam],10                ;
    mov ah,9                    ;move 9 para ah
    mov dx,OFFSET newline       ;pula linha
    int 21h  
    mov  ah,9                   ;funcao mostrar na tela
    mov  dx,OFFSET Message4     ;funcao mostrar na tela
    int  21h                
    jmp Pega_caracter_Verifica
FINALIZA1:
    mov ah,9                    
    mov dx,OFFSET newline       ;pula linha
    int 21h  
    mov ah,9                   
    mov dx,OFFSET newline       ;pula linha
    int 21h  

    xor ax,ax                   ;resetar ax
    mov  ah,9                   ;DOS print string function
    mov  dx,OFFSET Vetor1       ;mov vetor1 pra dx para imprimir
    int  21h                    
    mov ah,9                   
    mov dx,OFFSET newline       ;pula linha
    int 21h  
    mov  ah,9                   ;DOS print string function
    mov  dx,OFFSET Vetor2       ;mov vetor2 para dx para imprimir seu conteudo
    int  21h  
    CALL COMPARA_VETORES
    cmp cx,0                    
    je diferentes               ;sao diferentes apresenta a msg e termina o programa
    ja iguais                   ;sao iguais
iguais:
    mov ah,9
    mov dx,OFFSET Message5      ;msg de iguais
    int 21h
    mov  ah,4ch                 ;DOS terminate program function
    int  21h                    ;terminate the program    
diferentes:
    mov ah,9
    mov dx,OFFSET Message6      ;msg de diferentes
    int 21h
    mov  ah,4ch                 ;DOS terminate program function
    int  21h                    ;terminate the program    

GUARDA_NO_VETOR proc near
        push cx                 ;empilha cx pois preciso usar o valor dele como flag no inicio do programa
        xor ch,ch               ;limpa ch
        mov cl, [POS]           ;move pos para cl
        cmp cl,[Tam]            ;compara cl com tam para ver se excedeu o tamanho
        jae limite_do_vetor     ;se pos for igual ou maior q 10 excedeu e vai para o flag limite_do_vetor
        mov si, cx              ;move cx para si
        mov [bx][si],al         ;move ah para vetor
        inc cx                  ;decrementa cx
        mov [POS],cl            ;move cl para tam
        pop cx                  ;desempilha cx para voltaro valor da flag ,
        ret                     ; assim podendo utilizar no inicio do programa
limite_do_vetor:                ;significa q o excedeu o tamanho do vetor e n vai armazenar mais
        mov ah,9
        mov dx,OFFSET Message3
        int 21h
        pop cx                  ;desempilha cx para voltaro valor da flag ,
        ret                     ; assim podendo utilizar no inicio do programa
ENDP

COMPARA_VETORES proc near
        xor cx,cx
        mov cl,0
        lea si,Vetor1           ;LEA destino,fonte O operador fonte deve estar localizado na memória, e 
        lea di,Vetor2           ;seu deslocamento é colocado no registrador de índice ou ponteiro especificado no destino. 
inicio:
        cmp cl,[Tam]            ;compara cl com 10 se cl estiver em 10 vai para o fim do procedimento
        je fim_igual            ;label para o fim
        mov ah,[si]             ;move a posicao referenciada do vetor1 para ah
        mov al,[si+1]           ;move a posicao à frente da referenciada do vetor1 para al
        mov bh,[di]             ;move a posicao referenciada do vetor2 para ah
        mov bl,[di+1]           ;move a posicao à frente da referenciada do vetor2 para al   
        cmp ah,bh               ;compara os caracteres referenciados ex em c: if(ah[cont] == bh[cont])
        je segundo              ;se for igual pula para o segundo caracter
        jmp fim_desigual        ;se não for pula para o fim_desigual e move 0 para cx que e o valor de retorno
segundo:
        cmp al,bl               ;compara al,bl se for igual pula para mod_si_di
        je mod_si_di            ;label de modificao dos operandos
        jmp fim_desigual        ;se não for igual pula para fim_desigual
mod_si_di:
        add cl,2                ;adiciona 2 em cl por que ja foram verificador duas posicoes de cada vetor
        add si,2                ;adiciona 2 em si para trabalhar com as proximas 2 posicoes dos vetor1
        add di,2                ;adiciona 2 em di para trabalhar com as proximas 2 posicoes dos vetor2
        jmp inicio              ;volta para o inicio
fim_desigual:
    mov cx,0                    ;move 0 para cx, essa flag quando retornada indica que as strings sao desiguais
    ret                         ;retorna o procedimento
fim_igual:
    mov cx,1                    ;move 1 para cx, essa flag determina que as strings sao iguais
    ret                         ;retorna o procedimento
ENDP
END                             ;fim                                    