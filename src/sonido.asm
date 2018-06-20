;PROGRAMA QUE PROVOCA UN SONIDO EN BOCINA

.MODEL SMALL
.STACK  
.DATA

.CODE
     MENS DB "CADENA",10D,13D,'$'
INICIO:
     MOV AX,@DATA
     MOV DS,AX
     in al,61H
     or al,3
out 61h,al
mov cx,1000h
l1:
    loop l1
    in al,61h
    and al,0fch
    out 61h,al


     MOV AH,4CH
     INT 21H    
     
END INICIO