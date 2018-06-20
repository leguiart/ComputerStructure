.MODEL SMALL
.STACK
.DATA
;Declaracion de las variables a utilizar
NOMARCH DB 'ejem.txt',0   
HANDLE   DW ?
FBUFF	 DB 80 DUP(?)                      ;ARCHIVO DE DATOS DEL BUFFER
   
.CODE

INICIO:

MOV AX,@DATA
MOV DS,AX
    CALL CREARCH
    ;JC FIN
    
    call escribe
    CALL CIEARCH
 FIN:
    MOV AH,4CH
    INT 21H
   
CREARCH PROC
    MOV AH,3ch;
    LEA DX,NOMARCH
    mov cx,0
    INT 21H
    MOV HANDLE,AX
      
   RET
CREARCH ENDP


ESCRIBE PROC

 ciclo: mov ah,1
        int 21h
         
        MOV     AH, 40h         ;  escribir
        LEA     DX, fbuff      ; Buffer de donde se toma la informaci?n
        mov     fbuff,al
        MOV     BX, HANDLE     ; Handle
        MOV     CX, 1           ; Voy a escribir 1 caracter a la vez
        push    ax
        INT     21h
        JC      fin
        pop ax
        cmp     al,1ah
        je  sale
        jmp ciclo
        
sale: mov handle,ax 
      ret
ESCRIBE ENDP
	 
  	
CIEARCH PROC
	MOV AH,3EH
	MOV BX,HANDLE
	INT 21H
	JC fin
	RET

CIEARCH ENDP	
END INICIO
