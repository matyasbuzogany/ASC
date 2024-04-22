;Es werden zwei Strings S1 und S2 angegeben. Bilden Sie den String D, indem Sie die
;Elemente aus den geraden Positionen von S2 mit den Elementen aus den ungeraden Positionen
;von S1 verketten

;S1: 'a', 'b', 'c', 'd', 'e', 'f'
;S2: '1', '2', '3', '4', '5'
;D: '2', '4', 'a', 'c', 'e'


bits 32
global  start 

extern  exit
import  exit msvcrt.dll

segment data use32 class=data
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    len1 EQU $-s1
    
    s2 db '1', '2', '3', '4', '5'
    len2 EQU $-s2
    
    dest times len1 db 0
    

segment code use32 class=code
start:
    MOV EBX, 2
    MOV ESI, s2 ; pregatim sursa s2, ne trebuie par
    MOV EDI, dest ; destinatia
    MOV ECX, len2 ; len2 pentru ca mergem pe s2 prima data
    CLD
    
    JECXZ final
    
    secondStringLoop:
        INC ESI ; inc esi ca sa ia de la index 2, merge cate 2
        LODSB ; MOV AL, [s1 + ESI]
        STOSB ; Mov [edi + s2], AL
        ADD EBX, 2 ; Incrementez EBX pentru conditia de iesire
        CMP EBX, len2
        JBE secondStringLoop ; daca EBX e mai mic sau egal cu lungime, intra in loop
    
    
    MOV ESI, s1 ; pregatim srursa s1, ne trebuie impar
    MOV ECX, len1
    
    JECXZ final
    
    MOV EBX, 1
    
    firstStringLoop:
        LODSB ; MOV AL, [s1 + esi]
        STOSB ; MOV [EDI + s2], AL
        INC ESI
        ADD EBX, 2 ; Incrementez EBX
        CMP EBX, len1
        JBE firstStringLoop ; daca EBX e mai mic sau egal cu lungime, intra in loop

final:
    push dword 0
    call[exit]
