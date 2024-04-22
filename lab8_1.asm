;Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor. Rezultatul inmultirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date). 


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll         ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll  ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll   ; similar pentru scanf
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    rez dq 0
    a dd 0 ;in aceasta variabila se va stoca valoarea citita de la tastatura
    b dd 0
    format db '%d', 0  ;%d=se afiseaza dword intreg decimal cu semn
    ma db 'a=', 0
    mb db 'b=', 0
    rezultat db "a*b = %d", 0

; our code starts here
segment code use32 class=code
    start:
        ;vom apela printf(ma) => se va afisa "a="
        push dword ma ;punem parametrii pe stiva
        call [printf] ;apelam functia printf pentru afisare
		add esp, 4 * 1 ;eliberam parametrii de pe stiva ;4 = dimensiunea unui dword ;1 = nr de parametri
        
        ;vom apela scanf(format, a) => se va citi un numar in variabila a
        ;punem parametrii pe stiva de la dreapta la stanga
        push dword a ;punem pe stiva adresa lui a
        push dword format
        call [scanf] ;apelam functia scanf pentru citire
        add esp, 4*2 ;eliberam parametrii de pe stiva ;4 = dimensiunea unui dword ;2 = nr de parametri
        
        ;vom apela printf(mb) => se va afisa "b="
        push dword mb ;punem parametrii pe stiva
        call [printf] ;apelam functia printf pentru afisare
        add esp, 4*1 ;eliberam parametrii de pe stiva ;4 = dimensiunea unui dword ;1 = nr de parametri
        
        ;analog la scanf(format, a)
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        mov dword eax, [a] ;mutam variabilele in registrii
        mov dword ebx, [b]
        mul ebx ;facem a*b
        mov dword [rez], eax 
        mov dword [rez+4], edx
        
        ;printf(rezultat) => va afisa "a*b ="
        push dword [rez] ;punem pe stiva adresa rezultatului
        push dword rezultat
        call [printf] ;apelam functia printf pentru afisare
        add esp, 4*2 ;eliberam parametrii de pe stiva ;4 = dimensiunea unui dword ;2 = nr de parametri
        
      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
