bits 32
global  start 

extern  exit
import  exit msvcrt.dll

;8. (a+b-d)+(a-b-d) 
segment  data use32 class=data
	a db 35 ; 8bit
	b dw 2 ; 16bit
	c dd 15 ; 32bit
	d dq 200 ; 64bit

segment  code use32 class=code ; segmentul de cod
start: 
    MOV AL, [a]
    MOV AH, 0
    MOV BX, [b] 
    ADD AX, BX ;AX = a+b
    MOV DX:AX, 0 ; DX:AX = a+b
    MOV EDX:EAX, 0 ; EDX:EAX = a+b
    MOV ECX:EBX [d] ; ECX:EBX = d
    SUB EDX:EAX, ECX:EBX[d] ; EDX:EAX = a+b-d 
    MOV ECX:EBX, EDX:EAX ; ECX:EBX = a+b-d
    PUSH ECX:EBX ; punem in stiva
    
    MOV AL, [a] ; AL = a
    MOV AH, 0 ; AX = a
    MOV BX, [b] ; BX = b
    SUB AX, BX ; AX = a-b
    MOV DX:AX, 0 ; DX:AX = a-b
    MOV EDX:EAX, 0 ; EDX:EAX = a-b
    MOV ECX:EBX, [d]
    SBB EDX:EAX, ECX:EBX ; EDX:EAX = a-b-d
    
    MOV ECX:EBX, 0
    POP ECX:EBX ; ECX:EBX = a+b-d
    ADD ECX:EBX, EDX:EAX ; ECX:EBX = a+b-d  +  a-b-d
    
    push dword 0
	
call [exit]