org 100h
call mult
call addition  
call print 

ret

mult proc
mov cx,2 
mov bp,0                ; low multiplication
m1:
mov ax,number1[si]
mov bx,number2[di] 
mul bx 
mov productsLow[bp],ax 
add bp,2
mov productsLow[bp],dx 
add di,2
add bp,2
loop m1 
;the following part for that to sum crossing part
mov ax,productsLow[si+2] 
add ax,productsLow[si+4]
mov productsLow[si+2],ax
mov ax, productsLow[si+6]  
mov ax,productsLow[si+6]  
mov productsLow[si+6],0
adc ax, 0
mov productsLow[si+4], ax
mov di,0
mov bp,0
mov cx,2  

m2:                 ;high multiplication
mov ax,number1[si+2]
mov bx,number2[di] 
mul bx 
mov productsHigh[bp],ax
add bp,2
mov productsHigh[bp],dx
add bp,2
add di,2

loop m2 
;the following part for that to sum crossing part
mov ax,productsHigh[si+4] 
add ax,productsHigh[si+2]
mov productsHigh[si+4],ax
mov ax,productsHigh[si]  
mov productsHigh[si],0
adc ax, 0
mov productsHigh[si+2], ax

ret
mult endp
 
addition proc 
mov cx,4   
mov si,0
m3: 
mov ax,productsLow[si]
adc ax,productsHigh[si]  
mov result[si],ax
inc si
inc si
loop m3

ret
addition endp

print proc  
mov si,7 
mov cx,8
m4:
;separate the hex to nibble 

mov bx,result[si] 
mov dh,0
mov dl,bl
and bl,0fh   ;low nibble
and dl,0f0h  ;high nibble
push cx
mov cl,4
ror dl,cl
sub si,1
pop cx

;convert to the ascii hex   
cmp bl,9h
jg addForBL
 

return1:
cmp dl,9h
jg addForDL
 
return2:
add bl, 30h 
add dl, 30h 
jmp print1 
addforBL:
add bl, 7h
jmp return1

addforDL:
add dl, 7h
jmp return2             

;print
print1:
MOV AH,2             
INT 21H          
             
mov dl,bl
INT 21H 

loop m4
       
ret
print endp    

number1 dw 3344h,1122h
number2 dw 7788h,5566h 
productsLow dw 4 dup(?) 
productsHigh dw  4 dup(?) 
result dw 4 dup(?)