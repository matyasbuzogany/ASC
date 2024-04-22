bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 07757h
    b dw 09bbeh
    c dw 0

segment code use32 class=code
    start:
        ;ne propunem sa punem rezultatul in BX
        MOV BX, 0
        MOV AX, [a]
        AND AX, 00000001111100000b
        MOV CL, 5
        ROR AX, CL
        OR BX, AX ;am pus bitii 0-4 in rezultat
        
        MOV AX, [b]
        AND AX, 0000000000011110b
        MOV CL, 4
        ROL AX, CL
        OR BX, AX ;am pus bitii 5-9 in rezultat
        
        OR BX, 0000001100000000b ; am setat bitii 9-10 la valoarea 1
        
        AND BX, 1111001111111111b ; nu e terminat
        push dword 0
        call [exit]