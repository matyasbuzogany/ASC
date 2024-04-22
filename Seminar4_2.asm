bits 32
global  start 

extern  exit
import  exit msvcrt.dll

segment data use32 class=data
    msg1 dd 12345678h, 1A2B3C4Dh, 0FE98DC76h
    len EQU ($-msg1)/4 ; lungime in double word
    
    msg2 times len db 0
    
    zehn db 10

segment code use32 class=code
    start:
    MOV ESI, msg1 ; pregatim sursa
    MOV EDI, msg2 ; pregatim destinatia
    MOV ECX, len1 ; pregatim lungimiea
    
    


push dword 0
call[exit]