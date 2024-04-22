bits 32

extern fopen, fprintf, fclose
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

segment data use32 public data
    format_deschidere db "w", 0
    format_afisare db "%x", 10, 0
    file_descriptor dd -1
    file_address dd -1

segment code use32 public code
	global afisare_cifre
    afisare_cifre:
        ; deschidem fisierul
        mov eax, [esp + 12]
        push format_deschidere
        push eax
        call [fopen]
        add esp, 4 * 2
        cmp eax, 0
        je final_afisare_cifre
        mov [file_descriptor], eax
        mov ecx, [esp + 4]
        mov esi, [esp + 8]
        cld
        mov edx, 0
        ; afisam pe rand (de la coada spre inceput)
        ; fiecare cifra pe o linie diferita
        for:
            push ecx
            mov dl, [esi]
            push edx
            push format_afisare
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4 * 3
            dec esi
            pop ecx
        loop for
        push dword [file_descriptor]
        call [close]
        add esp, 4
        final_afisare_cifre:
        ret 4 * 3
        