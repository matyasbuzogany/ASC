bits 32
global start
extern exit,printf, scanf, fopen, fread ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll


segment data use32 class=data
    n dw 0
    format db "%x",0 ;cu x se citesc numere hexazecimale
    format2 db "%s",0 ;cu x se citesc stringurile
    access db "r", 0 ;modul read
    sem5_fis db "data.in", 0
    descriptor dd -1

segment code use32 class=code
start:
    push dword n
    push dword format
    call [scanf]
    add esp, 4 * 2
    
    ;afisam nr citit
    push dword [n]
    push dword format2
    call [printf]
    add esp, 4 * 2

push dword 0 ; push the parameter for exit onto the stack
call [exit] ; call exit to terminate the program