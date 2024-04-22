bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

    a dd 125 ;declare double word = 32 biti (4 bytes) 7D 00 00 00
    b db 2 ;declare byte = 8 biti (1 byte)
    c dw 15 ;declare word = 16 biti (2 bytes)
    d db 200 
    e dq 80 ;declare quad word = 64biti (8 bytes) : 00 00 00 00 00 00 00 50
    
;a+b/c-d*2-3   
segment code use32 class=code
start:
    
    mov al, [b] ; AL=b
    mov ah, 0  ; conversie fara semn al -> AX
    mov dx, 0 ; conversie fara semn AX -> DX:AX
    
    div word [c] ; impartire fara semn 
    
    mov bx, ax ; BX=b/c
    mov al, 2 ; AL=2
    mul byte [d] ; AX = d*2
    
    sub bx, ax ; BX = b/c - d*2
    
    mov cx, 0 ; se pregateste CX:BX=b/c-d*2
    
    mov ax, word [a] ; AX = 007D
    mov dx, word [a+2] ; DX:AX = a, DX = 0000
    add ax, bx 
    adc dx, cx ; DX:AX = a + b/c - d*2
    
    push dx
    push ax
    pop eax ; eax = a + b/c - d*2
    
    mov edx, 0
    sub eax, dword [e]
    sbb edx, dword [e+4]