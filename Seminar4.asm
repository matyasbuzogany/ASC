;se ia un string, returneaza cu litere mari

bits 32
global  start 

extern  exit
import  exit msvcrt.dll

segment data use32 class=data
    msg1 db "seminar"
    len1 EQU $-msg1 ; $ - pozitia curenta in data segment
    
    ;msg2 times len db 0 - se poate si asa
    msg2 db 0, 0, 0, 0, 0, 0, 0, 0
    len2 EQU $-msg2
    
    ;msg3 times 7 db 0 - se poate si asa

segment code use32 class=code
start:
    MOV ESI, msg1 ; pregatim sursa
    MOV EDI, msg2 ; pregatim destinatia
    MOV ECX, len1 ; pregatim lungimiea
    CLD ; face DF = 0 => mergem crescator
    
    JECXZ final ; jump if Extended CX = 0 => daca sirul e de lungime 0, sare la final
    
    myLoop:
        LODSB ; mov in AL continutul [ESI+msg1]
        MOV BL, 'a'-'A' ; Bl = 32
        SUB AL, BL
        STOSB ; MOV [EDI + msg2], AL
    LOOP myLoop
    
final:
    push dword 0
    call[exit]