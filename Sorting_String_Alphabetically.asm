org 100h
call sort 
call copy 
call print
 
ret 

sort proc   
lea si,array
mov al,0 
mov cx,lenght
dec cx   ;loop will return lenght-1 times
mov bx,lenght
dec bx    

outer_loop: 
push cx  ;record   
mov cx,bx  
sub bx,1
      
inner_loop: 
mov al,[si] 
mov dl,[si+1] 
cmp al,dl 
jg swap
jmp exit
swap:  
xchg al,dl
mov [si],al
mov [si+1],dl 

exit:
inc si

loop inner_loop   
pop cx ;remove and use
lea si,array
loop outer_loop 
ret    
sort endp   

copy proc     ;this method moves the array DI:[2000] 
lea si,array    
mov di,offset 2000h  
mov cx,lenght
rep movsb    
ret
copy endp 

print proc  
lea si,array     
mov cx,lenght 
mov ah, 0Eh
display: 
lodsb          ;load byte at ds:[si] into al.
int 10h                       
loop display  
ret
print endp    
array db 'M','I','C','R','O','C','O','M','P','U','T','E','R','S'
lenght dw 14
