;  x-(a*100+b)/(b+c-1)
;  a-word; b-byte; c-word; x-qword

bits 32
global  start 
extern  exit
import  exit msvcrt.dll

segment data use32 class=data
    a dw 5
    b db 12
    c dw 5
    x dq 230

segment code use32 class=code
start:
    MOV AX, [a] ; AX = a
    MOV BL, 100
    MUL BL ; AX = a * 100 (AX * 100)
    MOV BL, [b] ; BL = b
    MOV BH, 0 ; BX = b
    ADD AX, BX ; AX = (a*100+b)
    MOV BX, AX ; BX = (a*100+b)
    MOV AL, [b] ; AL = b
    MOV CX, [c] ; CX = c
    MOV AH, 0 ; AX = b
    ADD AX, CX ; AX = b+c
    SUB AX, 1 ; AX = b+c-1
    MOV CX, AX ; CX = b+c-1
    MOV AX, BX ; AX a*100+b
    MOV DX, 0
    DIV CX ;  AX = DX:AX / CX, DX ← DX:AX % CX
    MOV CX, DX
    MOV BX, AX
    MOV AX, 0
    MOV DX, 0
    MOV EAX, x
    SUB EAX, EBX

    push dword 0
	
call [exit]