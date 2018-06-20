.model small
.data
row db 12 ;posicion inicial de cursor
col db 40;
color db 2;inicia en verde
skip db 1 ;inicia con salto verdadero(no dibuja)
help db 'D:Dibuja ,S:Salta, Move:Arrows keys,'
     db 'R/G/B:Config Color, Q:Salir,'
     db 'E:Borrar todo, A:Borrar partes$'
.CODE
inicio:
   mov ax,@data
   mov ds,ax
   mov ah,0	;configura el modo de video
   mov al,3	;80x25 color
   int 10h
   mov ah,2     ;configura la posición del cursor
   mov bh,0     ;despliega el numero de pagina
   mov dh,24    ;renglon superior
   mov dl,7     ;numero de columna
   int 10h	; EN QUE COORDENADAS SE MANDA EL MENSAJE
   lea dx,help
   mov ah,9
   int 21h
   mov ah,2	;posiciona el cursor
   mov bh,0     ;despliega el numero de pagina
   mov dh,row	;numero de renglon
   mov dl,col	;numero de columna
   int 10h
readkey: 
   mov ah,0 	;lee el teclado
   int 16h      ;llama a la interrupcion del BIOS, para leer del teclado
   cmp al,0     ;verifica el codigo?, ya que son teclas especiales, si lo encuentra en 0 reliza lo siguiente 
   jz csc
   cmp al,'a'	;verifica que sea minus
   jc nolc
   
   cmp al,'z'+1 
   jnc nolc
   and al,0dfh  ;convierte a mayusc
nolc:
   cmp al,'Q'   ;salir
   jnz x1
   jmp fin
x1:
   cmp al,'R'   ;cambia a rojo?
   jz setred   
   cmp al,'G'   ;cambia a verde?
   jz setgreen
   cmp al,'B'   ;cambia a azul?
   jz setblue   
   cmp al,'S'   ;salta?
   jz setskip
   cmp al,'D'	;dibuja?
   jz setdraw
   cmp al, 'E'
   JZ setborra
   cmp al, 'A'
   je setborra2
   jmp readkey
setred:
   mov color,4
   jmp readkey
setgreen:
   mov color,2
   jmp readkey
setblue:
   mov color,1
   jmp readkey
setskip:
   mov skip,1 	;salto es verdadero
   jmp readkey
setdraw:
   mov skip,0   ;es falso
   jmp readkey
setborra:
    MOV AH, 6H
    MOV AL, 0
    MOV CX, 0
    MOV DH, 22D
    MOV DL, 79D
    INT 10H
    jmp readkey
 setborra2:
    mov color, 0
    jmp readkey
csc:
   cmp ah,48h	;flecha superior?
   jz goup
   cmp ah,50h	;flecha inferior
   jz godown
   cmp ah,4bh   ;flecha izquierda
   jz goleft
   cmp ah,4dh   ;flecha derecha
   jz goright
   jmp readkey
goup:
   cmp row,0 	;ignora si es el primer renglon
   jnz goup2
   jmp readkey
goup2:
   sub row,1 
   jmp setcur   ;reposiciona el cursor
godown:
   cmp row,23   ;ignora si es el ultimo renglon
   jnz godown2
   jmp readkey
godown2:
   add row,1
   jmp setcur
goleft:
   cmp col,0
   jnz goleft2
   jmp readkey
goleft2:
   sub col,1
   jmp setcur
goright:
   cmp col,79
   jnz goright2
   jmp readkey
goright2:
   add col,1
setcur:
   mov ah,2 	;configura la pos del cursor
   mov bh,0	;despliega el numero de pagina
   mov dh,row   ;numero de renglon
   mov dl,col   ;numero de columna
   int 10h
   cmp skip,1   ;salta si es verdadero
   jz noc
   mov al,'-'   ;escribe * de color
   mov bl,color
   mov cx,1
   mov ah,9
   int 10h
noc:
   jmp readkey
      


fin: mov ah,4ch
      Int 21h


      
.stack
end inicio