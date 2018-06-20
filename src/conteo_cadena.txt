.MODEL SMALL
.STACK
.DATA
    CADENA DB 'PROGRAMADORES', 13D
.CODE
INICIO:
    MOV AX, @DATA
    MOV DS, AX
    MOV SI, 0
    MOV CX, 0
    CHECAR:
        MOV AL, CADENA[SI]
        CMP AL, 'R'
        JE CUENTA
        INC SI
        CMP AL, 13D
        JE EXHIBE
        JMP CHECAR
    CUENTA:
        INC CL
        INC SI
        JMP CHECAR
    EXHIBE:
        MOV AL, CL
        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2H
        INT 21H
    FIN:
        MOV AH, 4CH
 END INICIO
