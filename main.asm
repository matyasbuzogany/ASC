bits 32

global start

extern exit, afisare_cifre
import exit msvcrt.dll

;     se da numele unui fisier si un numar scris in memorie
; sa se scrie cifrele hexazecimale ale acestui numar ca 
; text in fisier, fiecare cifra pe o linie separata

segment data use32 class=data
	; ...
    fisier db "cifre.txt", 0
    numar dd 11223344h
    cifreHexa resb 15
    _16 dd 16

segment code use32 class=code
	start:
    	; ...
        ; salvam fiecare cifra in sirul cifreHexa
        mov esi, cifreHexa
        mov edx, 0
        mov ecx, 0
        mov eax, [numar]
        while: ; numar != 0
            ; ultima cifra in baza 16 = nr % 16
            inc ecx
            div dword [_16]
            mov [esi], dl
            inc esi
            mov edx, 0
            cmp eax, 0
            jne while
        dec esi
        push fisier
        push esi
        push ecx
        call afisare_cifre
        ; exit(0)
        push dword 0
        call [exit]