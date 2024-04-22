;Beispiel:
;Aufgabe. Es wird ein String von ganzzahligen numerischen Werten angegeben, die auf
;Quadwörtern dargestellt werden.
;Ermitteln Sie die Summe der Ziffern der Vielfachen von 8 in den unteren String
;von Bytes der oberen Wörter der oberen doppelwörter in den Elementen des Strings
;von Quadwörtern.
;Lösung: Wenn wir den String von Quadwörtern durchgehen, erhalten wir zuerst die
;Anzahl der Vielfachen von 8 aus
;Der String der unteren Bytes der oberen Wörter der oberen doppelworter in den
;Elementen des Strings.
;Dann erhalten wir die Zahlen dieser Zahl, indem wir sie nacheinander durch 10
;dividieren und ihre Summe berechnen.
bits 32
global start
extern
import exit msvcrt.dll
segment data use32 class=data
    şir dq 123110110abcb0h,1116adcb5a051ad2h,4120ca11d730cbb0h
    len equ ($-şir)/8;die Länge des Strings(in doppelworter)
    opt db 8;Variable zum Testen der Teilbarkeit durch 8
    zece dw 10;Variable, die verwendet wird, um die Zahlen einer Zahl durch aufeinanderfolgende Unterteilungen bei 10 zu bestimmen
    suma dd 0;die Variable, in der wir die Summe der Zahlen behalten

segment code use32 class=code
start:
    mov esi, şir
    cld;wir laufen durch den String von links nach rechts durch (DF = 0).
    mov ecx, len;Wir werden die String Elemente in einer Schleifen(loop) mit len Iterationen durchlaufen.
    mov ebx, 0;im ebx register behalten wir die anzahl der vielfachen von 8 bei.
    repeta:
        lodsd;In eax haben wir das niedrigstwertige Doppelwort des aktuellen Quadworts in den String
        lodsd;In eax haben wir das höchstwertige Doppelwort des aktuellen Quadworts in den String
        shr eax, 16
        mov ah, 0;wir interessieren uns nur für das niederwertigste Byte in diesem Wort (AL)
        div byte[opt];mal sehen ob al durch 8 teilbar ist
        cmp ah, 0;Wenn der Rest nicht 0 ist, wiederholen Sie den Zyklus erneut.
;Andernfalls erhöhen wir die Anzahl der Vielfachen von 8 aus dem ebx-Register.
        jnz nonmultiplu
        inc ebx
    nonmultiplu:
    loop repeta;Wenn noch Pfadelemente (ecx> 0) vorhanden sind, setzen Sie den Zyklus fort.
;ferner erhalten wir die Ziffern der ebx-Zahl in der Basis 10, indem wir
;nacheinander durch 10 dividieren und die Summe dieser Ziffern berechnen.
    mov eax, ebx
    mov edx, 0
    transf:
        div dword[zece];Wir teilen die Zahl im Register durch 10, um die letzte Ziffer zu finden. Diese Ziffer ist in EDX
        add dword[suma], edx;Wir addieren die Ziffer zur Summe.
        cmp eax, 0
        jz sfarsit;Wenn der Quotient 0 ist, bedeutet dies, dass wir alle Zahlen erhalten haben und die transf -Schleife verlassen können
;Ansonsten bereiten wir es auf eine neue Iterationvor
        mov edx, 0
    jmp transf;Wir haben die Schleife wieder aufgenommen, um eine neue Zifferzu erhalten.
sfarsit:;Wir beenden das Programm.
push dword 0; Schieben Sie den Parameter für exit auf den Stack
call [exit]; Rufen Sie exit auf, um das Programm zu beenden