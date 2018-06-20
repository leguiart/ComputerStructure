.MODEL SMALL
.STACK
.DATA
cad db ?
.CODE
INICIO:
    MOV AX, @DATA
    MOV DS, AX
    PIDE:
        MOV AH, 7H
        INT 21H
        MOV cad[si], al
        inc si
        cmp al, 13D
        jne PIDE
        
        dec si
        
        mov cad[si], '$'
        lea dx, cad
        mov ah, 9H
        int 21H
    MOV AH, 4CH
    INT 21H
 END INICIO
