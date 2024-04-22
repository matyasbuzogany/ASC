;Die Wörter A und B sind gegeben. Das Wort C wird wie folgt gebildet:
; - Die Bits 0-2 von C stimmen mit den Bits 10-12 von B überein
; - Die Bits 3-6 von C haben den Wert 1
; - Die Bits 7-10 von C stimmen mit den Bits 1-4 von A überein
; - Die Bits 11-12 haben den Wert 0
; - Die Bits 13-15 von C stimmen mit der Umkehrung der Bits 9-11 von B überein

bits 32 
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
a dw 0111011101010111b
b dw 1001101110111110b
c dw 0
segment code use32 class=code
start:
mov bx, 0 ; Im bx-Register berechnen wir das Ergebnis
mov ax, [b] ; Wir haben die Bits 10-12 von b isoliert
and ax, 0001110000000000b
mov cl, 10
ror ax, cl ; Wir drehen 10 Positionen nach rechts
or bx, ax ; Wir setzen Bits in das Ergebnis
or bx, 0000000001111000b ; Wir setzen die Bits 3-6 des Ergebnisses auf
den Wert 1
mov ax, [a] ; isoliere die Bits 1-4 von a
and ax, 0000000000011110b
mov cl, 6
rol ax, cl ; Wir drehen 6 Positionen nach links
or bx, ax ; Wir setzen Bits in das Ergebnis
and bx, 1110011111111111b ; facem biţi 11-12 din rezultat sa aiba
valoarea 0
mov ax, [b]
not ax ; Wir kehren den Wert von b um
and ax, 0000111000000000b ; Isolieren der Bits 9-11 von b
mov cl, 4
rol ax, cl ; Wir haben die Bits um 4 Positionen nach links verschoben
or bx, ax ; Wir setzen Bits in das Ergebnis
mov [c], bx ; Wir setzen den Wert im Register in die Ergebnisvariable
push dword 0 ;Der Rückkehrcode der Exit-Funktion wird auf den Stack gelegt
call [exit]