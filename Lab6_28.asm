;28. Beseitigen Sie bei einer gegebenen String von Bytes und einer Substring davon alle
;Vorkommen der Substring in den ersten String

; Dandu-se un sir de octeti si un subsir al sau, sa se elimine din primul sir toate aparitiile subsirului.


bits 32
global start
extern
import exit msvcrt.dll
segment data use32 class=data
    sir db "anaaremere"
    lensir equ $-sir
    subsir db "e"
    lensubsir equ $-subsir
    dest times lensir db 0
    
segment code use32 class=code
start:
    
    MOV ESI, sir ;pregatim sirul
    MOV EDI, dest ; dest = destinatie in registrul EDI
    CLD ;setam destination flag 0 (mergem de la stanga la dreapta)
    MOV ECX, len ; pregatim ecx pentru bucla
    
    JECXZ final
    
    myLoop:
        LODSB ; mutam in AL continutul [ESI+sir]
        CMP AL, subsir ; comparam Al (octetul curent) cu subsirul
        JNE notEqual ; octetul curent nu este egal cu subsir -> stocam in destinatie, daca este egal, nu facem nimic
        
    notEqual:
        STOSB ; daca nu sunt egale (octetul curent nu este egal cu subsir), punem in EDI MOV [EDI+dest], AL
        
    final:
        push dword 0
        call[exit]