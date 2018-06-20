.model small
.code
.data
nodvr db "no mouse instalado$"
nomse db "mouse no responde$"
mexit db "presiona el boton izq para salir$"
posx db "X: ",'$'
posy db "Y: ",'$'
col db ?
row db ?
spos equ 12*160
.code
inicio:
     mov ax,@data
     mov ds,ax
     call conf
     call clr 
     mov row,20
     call cursor
     lea dx,mexit
     mov ah,9
     int 21h
   
     mov ax,1  ;muestra el puntero del mouse 
     int 33h   ;
     call dacoord

fin: 
     mov ah,4ch
     int 21h
 
conf proc
     mov ax,00	   ;inicializa el mouse
    
     int 33h       
     cmp ax,0      ;mouse instalado?
     je term
     mov ax,01h    ;muestra el cursor del mouse
     int 33h 
term: ret
conf endp

dacoord proc
      mov ax,0b800h  ; carga una direccion de video RAM segment
      mov ds,ax
      mov si,spos    ;configura la posicion en pantalla
      mov byte ptr [si+54], 'X'
      mov byte ptr [si+56],':'
      mov byte ptr [si+94],'Y'
      mov byte ptr [si+96],':'
coord:
      mov ax,3		;obtiene el status y posicion del mouse
      int 33h
      mov ax,cx         ;lee la posicion de x
      mov di,spos+60    ;configura la pos de x 
      call desp       
      mov ax,dx         ;lee la posicion de y
      mov di,spos+100   ;configura la pos de y
      call desp
      cmp bl,1          ;fue presionado el boton izquierdo
      jnz coord         ;						
      mov ax,2          ;oculta el puntero del mouse
      int 33h
      ret
dacoord endp

desp proc 
      push cx
      mov cx,4
otro:
      rol ax,1
      rol ax,1
      rol ax,1
      rol ax,1
      push ax
      and al,0fh
      add al,30h
      cmp al,3ah
      jc no7
      add al,7
      no7: mov [di],al
      pop ax
      add di,2
      
      loop otro
      pop cx
      ret

desp endp

clr proc
    mov ax,0600h
    mov bh,71h
    mov cx,0000
    mov dh,24
    mov dl,79
    int 10h
    ret
clr endp

cursor proc
    mov ah,02
    mov bh,00
    mov dh,row
    mov dl,col
    int 10h
    ret
cursor endp

.stack
end inicio