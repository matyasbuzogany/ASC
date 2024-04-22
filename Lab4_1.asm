;1. Geben Sie die Wörter A und B an. Das Doppelwort C wird erhalten:
; Die Bits 0 bis 4 von C fallen mit den Bits 11 bis 15 von A zusammen
; Die Bits 5-11 von C haben den Wert 1
; Die Bits 12-15 von C fallen mit den Bits 8-11 von B zusammen
; Die Bits 16-31 von C fallen mit den Bits von A zusammen

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 0001010100010101b
    b dw 0001100101010110b
    c dd 0

segment code use32 class=code
    start:
        MOV EBX, 0 ; EBX ergebnis
        MOV EAX, [a]
        AND EAX, 00000000000000001111100000000000b
        MOV CL, 11
        ROR EAX, CL
        OR EBX, EAX ; Die Bits 0 bis 4 von C fallen mit den Bits 11 bis 15 von A zusammen (in EBX haben wir die bits 0-4 fertig
        
        OR EBX, 00000000000000000000111111100000b ; Die Bits 5-11 von C haben den Wert 1 (in EBX haben wirt 0-11 bits fertig)
        
        MOV EAX, [b]
        AND EAX, 00000000000000000000111100000000b
        MOV CL, 4
        ROL EAX, CL
        OR EBX, EAX ; Die Bits 12-15 von C fallen mit den Bits 8-11 von B zusammen (in EBX haben wir die vits (0-15 fertig)
        
        MOV EAX, [a]
        AND EAX, 00000000000000001111111111111111b
        MOV CL, 16
        ROL EAX, CL ; EAX = 11111111111111110000000000000000b
        OR EBX, EAX ; Die Bits 16-31 von C fallen mit den Bits von A zusammen
        MOV [c], EBX
        PUSH Dword 0
        call [exit]
        