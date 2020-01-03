;nome do programa: three.asm
.model small
.STACK
.code

TEST_WRITE_HEX    PROC
   mov DL,4Ch         ;move o valor 3Fh para o registrador DL
   call WRITE_HEX     ;chama a sub-rotina
   mov AH,4CH         ;função 4Ch
   int 21h            ;retorna o controle ao DOS
TEST_WRITE_HEX ENDP   ;finaliza o procedimento


PUBLIC WRITE_HEX
;........................................................;
;Este procedimento converte para hexadecimal o byte      ;
;armazenado no registrador DL e mostra o dígito          ;
;Use:WRITE_HEX_DIGIT                                     ;
;........................................................;

WRITE_HEX    PROC
   push CX           ;coloca na pilha o valor do registrador CX
   push DX           ;coloca na pilha o valor do registrador DX
   mov  DH,DL        ;move o valor de DL para o registrador DH
   mov  CX,4         ;move o valor 4 para o registrador CX
   shr  DL,CL    
call WRITE_HEX_DIGIT ;mostra na tela o primeiro número hexadecimal
   mov  DL,DH        ;move o valor de DH para o registrador DL
   and  DL,0Fh     
call WRITE_HEX_DIGIT ;mostra na tela o segundo número hexadecimal
   pop  DX           ;retira da pilha o valor do registrador DX
   pop  CX           ;retira da pilha o valor do registrador CX
   ret               ;retorna o controle ao procedimento que chamou
WRITE_HEX  ENDP

PUBLIC WRITE_HEX_DIGIT
;......................................................................;
;Este procedimento converte os 4 bits mais baixos do registrador DL    ;
;para um número hexadecimal e o mostra na tela do computador           ;
;Use: WRITE_CHAR                                                       ;
;......................................................................;

WRITE_HEX_DIGIT    PROC
   push DX                ;coloca na pilha o valor de DX
   cmp  DL,10             ;compara se o valor em DL é menor que 10
   jae  HEX_LETTER        ;se for maior ou igual salta para HEX_LETER
   add  DL,"0"            ;se sim, 
                          ;converte para número para o ascii correspondente
   jmp  Short WRITE_DIGIT ;escreve o caracter
HEX_LETTER:
   add  DL,"A"-10         ;converte um caracter para hexadecimal
WRITE_DIGIT:
   call WRITE_CHAR        ;imprime o caracter na tela
   pop  DX                ;Retorna o valor inicial do registrador DX 
                          ;para o registrador DL
   ret                    ;Retorna o controle ao procedimento que chamou
WRITE_HEX_DIGIT   ENDP


PUBLIC WRITE_CHAR
;......................................................................;
;Este procedimento imprime um caracter na tela usando o D.O.S.         ;
;......................................................................;

WRITE_CHAR   PROC
   push  AX        ;coloca na pilha o valor do registarador AX
   mov   AH,2      ;função 2h da interrupção 21h
   int   21h       ; imprime o caracter que está em DL
   pop   AX        ;extrai da pilha o valor de AX
   ret             ;retorna o controle ao procedimento que chamou
WRITE_CHAR   ENDP

END TEST_WRITE_HEX ;Finaliza o programa



