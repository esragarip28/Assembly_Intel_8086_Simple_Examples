org 100h
mov ax,3000h 
mov ds,ax ;change data segment
mov ax,0
mov bx,2000h 
mov dx,01h
mov cx,10 

loop1: 
mov [bx], dx
add ax,dx
inc bx
inc dx
loop loop1
mov [bx],ax ;sum of our values in 200Ah mov[200Ah],ax


ret



