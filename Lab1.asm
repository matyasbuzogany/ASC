bits 32 ;Assemblierung und Zusammenstellung für 32-Bit-Architektur
        ; Wir definieren den Einstiegspunkt im Hauptprogramm
        
global start
        ; Wir deklarieren die für unser Programm notwendigen externen Funktionen

extern exit ; wir zeigen der Assembly an, dass exit existiert, obwohl wir es
            ; nicht definieren werden
            
import exit msvcrt.dll ; exit ist eine Funktion, die den Vorgang abschließt
            ;und in msvcrt.dll definiert ist
            ; msvcrt.dll enthält exit, printf und alle anderen wichtigen
            ; C-Laufzeitfunktionen
            ; das Datensegment, in dem die Variablen definiert werden
            

;((a+b-c)*2 + d-5)*d
            

segment data use32 class=data
; ...
a db 10
b db 5
d db 7
c db 3

; Codesegment
segment code use32 class=code

start:
; ...
; exit(0)

MOV AL, [a]
MOV BL, [b]
MOV CL, [c]

ADD AL, BL
SUB AL, CL

;kell novelni valamit
MUL AL, 2

ADD AL, d
SUB AL, 5

MUL AL, d





push dword 0 ; Der Parameter der Exit-Funktion wird auf den Stack gelegt
call [exit] ; den Funktionsaufruf exit, um die Programmausführung zu beenden
