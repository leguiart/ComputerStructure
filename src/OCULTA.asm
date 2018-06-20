.MODEL SMALL
.STACK
.DATA
NOMARCH DB 'genera.txt'
.CODE
INICIO:
    MOV AX, @DATA
    MOV DS, AX
    MOV AL, 1
    MOV CX, 2
    LEA DX, NOMARCH
    MOV AH, 43H
    INT 21H
    FIN:
        MOV AH, 4CH
        INT 21H
END INICIO