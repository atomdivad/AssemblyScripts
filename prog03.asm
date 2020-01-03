;nome do programa: tree.asm
.model small
.stack
.code
PRINT_A_J   PROC  ; proc indica que o procedimento print_a_j começa aqui
  mov DL,'A'      ;move o character A para o registrador DL
  mov CX,10       ;move o valor decimal 10 para o registrador CX
                  ;este valor é usado para fazer laço com 10 interações
PRINT_LOOP:
  call WRITE_CHAR ;imprime o caracter em DL
  inc DL          ;incrementa o valor do registrador DL
  loop PRINT_LOOP ;laço para imprimir 10 caracteres
  mov AH,4Ch      ;função 4Ch, devolve o controle para o Power Shell
  int 21h         ;interrupção 21h
PRINT_A_J   ENDP  ; endp indica que o procedimento print_a_j termina aqui.

WRITE_CHAR  PROC
  mov AH,2h       ;função 2h, imprime caracter
  int 21h         ;imprime o caracter que está em DL
  ret             ;retorna o controle ao procedimento que chamou
WRITE_CHAR  ENDP  ;finaliza o procedimento
END   PRINT_A_J   ;finaliza o programa


