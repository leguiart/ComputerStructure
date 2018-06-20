.MODEL SMALL
.STACK
.DATA

NomDir DB 'C:\CREADIR', 0
.CODE

INICIO:
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DS, NomDir
    MOV AH, 39H
    INT 21H
    MOV AH, 38H
    INT 21H
    MOV AH, 4CH
    INT 21H
END INICIO