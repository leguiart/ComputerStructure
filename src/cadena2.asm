.MODEL SMALL
.STACK
.DATA
cad db ?
.CODE
INICIO:
    MOV AX, @DATA
    MOV DS, AX
    MOV si, 0
    PIDE:
        MOV AH, 1H
        INT 21H
        MOV cad[si], al
        INC si
        CMP al, 13D
        JNE PIDE    
    dec si
       
    CICLO:
        DEC SI
        MOV DL, cad[si]
        MOV AH, 2H
        INT 21H
        CMP si, 0
        JNZ ciclo

    mov ah, 9H
    int 21H   
    
    MOV AH, 4CH
    INT 21H
 END INICIO
