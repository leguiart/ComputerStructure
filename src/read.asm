.MODEL SMALL
.STACK
.DATA

NOMARCH DB 'genera.txt',0   
HANDLE   DW ?
FBUFF	 DB ?                      ;ARCHIVO DE DATOS DEL BUFFER
OEMSG    DB 'No se puede abrir buff.asm $'
RFMSG    DB 'No se puede leer buff.asm $'
CFMSG    DB 'No se puede cerrar buff.asm $'
                            
.CODE

INICIO:
MOV AX,@DATA
MOV DS,AX

       CALL ABREARCH		          ;ABRE ARCHIVO BUFF.ASM
       JC FIN			    ;SALTA SI HUBO ERROR	
       CALL LEEARCH		    ;LEE BUFF.ASM
       CALL CIEARCH		    ;CIERRA BUFF.ASM
FIN:
       MOV AH,4CH                  ;OPCION 4CH DE LA INTERRUPCION 21H PARA SU TERMINACION
       INT 21H
       
ABREARCH PROC
       MOV AH,3DH		   ;ABRE ARCHIVO CON OPCION DE MANIPULARLO
       LEA DX,NOMARCH             
       MOV AL,0			   ;LEE ACCESO
       INT 21H
       JC ERRORAB		   ;SALTA SI HAY ERROR
       MOV HANDLE,AX		   ;SALVA EL ARCHIVO
       RET 
ERRORAB: LEA DX,OEMSG		   
	MOV AH,9
	INT 21H
	
	RET			
ABREARCH ENDP

LEEARCH PROC 
	MOV AH,3FH
	MOV BX,HANDLE
	LEA DX,FBUFF
        MOV CX,1
        INT 21H
	JC ERRORLEE
	CMP AX,0
	JZ EOFF
        MOV DL,FBUFF
        CMP DL,1AH
	JZ EOFF
	MOV AH,2
	INT 21H
	JMP leearch
ERRORLEE:LEA DX,RFMSG
	MOV AH,9
	INT 21H
       
EOFF:   RET
LEEARCH ENDP

CIEARCH PROC
	MOV AH,3EH
	MOV BX,HANDLE
	INT 21H
	JC ERRORCIE
	RET
ERRORCIE:LEA DX,CFMSG
	MOV AH,9
	INT 21H
	
	RET
CIEARCH ENDP

END INICIO