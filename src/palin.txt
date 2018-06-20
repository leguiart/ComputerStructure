.MODEL SMALL
.STACK
.DATA
    MS1 DB 'Es un palindromo$', 13D
    MS2 DB 'No es un palindromo$', 13D
    AUX DB ?
    NOS DB ?
    PAL DB ?
.CODE

INICIO:
        MOV AX, @DATA
        MOV DS, AX
        MOV SI, 0
        MOV DI, 0
        PIDE:
            MOV AH, 1H
            INT 21H
            MOV PAL[SI], AL
            INC SI
            CMP AL, 13D
            JNE PIDE
        
        DEC SI
        MOV CX, SI
        MOV SI, 0
        MOV DI, 0      
        ETI:
            MOV AL, PAL[SI]
            INC SI
            CMP AL, 32D
            JNE ETI2
            JMP ETI
        ETI2:
            MOV NOS[DI], AL
            CMP SI, CX
            JE ETI3
            INC DI
            JMP ETI
        ETI3:
            MOV SI, 0
            MOV DI, 0
        COPIA:
            MOV AL, NOS[SI]
            MOV AUX[SI],AL
            INC SI
            CMP SI, CX
            JNE COPIA
        COMPARA:
            MOV AL, NOS[SI]
            MOV BL, AUX[DI]
            CMP AL, BL
            JNE EXHIBE
            DEC SI
            INC DI
            CMP SI, 0
            JNZ COMPARA
        LEA DX, MS1
        MOV AH, 9H
        INT 21H
        JMP INFO
        EXHIBE:
            LEA DX, MS2
            MOV AH, 9H
            INT 21H
        INFO:
            MOV SI, CX
            MOV NOS[SI], '$'
            MOV AL, 32D
            MOV DL, AL
            MOV AH, 2H
            INT 21H
            LEA DX, NOS
            MOV AH, 9H
            INT 21H
            MOV AL, 32D
            MOV DL, AL
            MOV AH, 2H
            INT 21H
            MOV AUX[SI], '$'
            LEA DX, AUX
            MOV AH, 9H
            INT 21H                   
        FIN:
            MOV AH, 4CH
            INT 21H 
END INICIO
