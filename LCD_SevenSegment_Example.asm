org 100h 
#start=Emulation_Kit.exe#

mov di,0 
Main:
inc di   
cmp di,20  ;di-20
jg BiggerThanTwenty
mov ax,di    
mov bl,0Ah   
div bl 
mov divisionResult[0],al   
mov divisionResult[1],ah   
mov ax,0
call Write  ;print tries number
mov bx,0   
mov ah, 00h  ; interrupts to get system time        
int 1AH   
mov  ax, dx
xor  dx, dx     
mov  cx, 10    
div  cx      ; here dx contains the remainder of the division - from 0 to 9
mov random,dl ;we stored R value in array
;we will get key and key1 value respectively in the following part
mov bl,random
and bl,5
mov mainkey,bl ;we stored our key value in array
mov al ,random
mul bl    ;result of multiplication is in ax register
add ax,5 
mov bl,5
div bl ;the result of div is in ah register
mov keys[0],ah   ;key1 value
cmp keys[0],0
je Key1Zero   
jmp Main

Key1Zero:
mov msg1[4],'1' 
call Message    ;lcd message
mov bl,mainkey
or bl,random
mov keys[1],bl 
cmp keys[1],0    ;key2 value    
jne Key2NotZero
jmp Main

Key2NotZero:
mov msg1[4],'2'
call Message     ;lcd message
mov bl,mainkey
add bl,random
sar bl,2  
mov keys[2],bl
cmp keys[2],0              ;key 3 value
jne Key3NotZero
jmp Main

Key3NotZero:
mov msg1[4],'3'
call Message    ;lcd message
mov bl,mainkey
xor bl,random
mov keys[3],bl  ;key 4 value
cmp keys[3],0
jne Key4NotZero  
jmp Main

Key4NotZero:
mov msg1[4],'4'
call Message     ;lcd message
mov ax,0
mov al,mainkey
mov bl,random
mul bl ;result of mul is in ax register    
mov keys[4],al
cmp ax,0
je Key5Zero
jmp Main

Key5Zero:
call outMessage     ;lcd message 
jmp Exit

BiggerThanTwenty:
call messageNegative

Exit:

ret
NUMBERS	DB 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b
 
random db 0
mainkey db 0   
keys db 5 dup (?) 
divisionResult db 2 dup(?) 

msg  db "Locks are not open"   
msg1 db "Lockn is open"   
msg2 db "Lock5 is open and I am out" 
msg3 db "Locks are not open"   

messageNegative proc 
    mov cx,0  
    MOV DX, 2040h	; first Seven Segment Display
	MOV SI, 0
	MOV CX, 18 
	NEXT1:
	MOV AL, msg3[SI]
	out DX,AL
	INC SI
	INC DX    
	LOOP NEXT1
    ret
    messageNegative endp
       
Message proc
    mov cx,0  
    MOV DX, 2040h	; first Seven Segment Display
	MOV SI, 0
	MOV CX, 13
	
NEXT:
	MOV AL, msg1[SI]
	out DX,AL
	INC SI
	INC DX    
	LOOP NEXT
    RET      
    Message   ENDP  

outMessage proc
    mov cx,0  
    MOV DX, 2040h	; first segment display for lcd
	MOV SI, 0
	MOV CX, 26
	NEXT5:
	MOV AL, msg2[SI]
	out DX,AL
	INC SI
	INC DX    
	LOOP NEXT5
    RET      
   outMessage   ENDP

Write proc    ;for showing tries number to seven segment
    mov bx,0
    mov bl,divisionResult[0]
	MOV DX, 2030h
	MOV AL,NUMBERS[bx]
	out dx,al                 
	inc DX                 
    mov bl,divisionResult[1]
	MOV al,NUMBERS[bx]
	out dx,al          	
    ret
Write  endp