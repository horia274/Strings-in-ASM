%include "io.mac"

section .data
    len_hexa db 0               ; lungimea numarului in hexa
    first_part db 0             ; numarul bitilor care formeaza prima cufra hexa din rezultat

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex
    xor     ebx, ebx
    mov     eax, ecx
    mov     bl, 4
    div     bl                          ; impart lungimea numarului binar la 4
    cmp     ah, 0                       ; compar restul cu 0, sa vad cati biti
    ja      inc_len_hexa                ; va avea primul caracter in reprezantarea
    jmp     put_len_hexa                ; in hexa

inc_len_hexa:
    inc     al                          ; daca am rest, maresc catul cu 1
                                        ; sa obtin lungimea corecta
put_len_hexa:
    mov     byte [first_part], ah       ; pun restul in variabila
    mov     byte [len_hexa], al         ; si dimensiunea sirului returnat
    mov     bl, al
    mov     byte [edx + ebx], 0AH       ; pun enter-ul la sfarsitul reprezentarii hexa
    xor     eax, eax                    ; 

continue:
    cmp     cl, byte [first_part]       ; pornesc de la sfarsitul numarului
    ja      get_char                    ; daca am ajuns la prima grupa de biti ce
    xor     eax, eax                    ; formeaza prima cifra din reprezentarea hexa
    xor     ebx, ebx
    cmp     byte [first_part], 0        ; daca am cativa biti care imi formeaza prima
    ja      first_char                  ; cifra hexa, o creez
    jmp     exit

get_char:
    xor     al, al                      ; daca mai am grupe de 4 biti
    mov     bl, byte [esi + ecx - 4]    ; formez cifra din hexa corespunzatoare
    add     al, bl                      ; adun bitul de la stanga din gruparea de 4
    sub     al, '0'                     ; si scad '0' sa obtin valoarea corecta
    shl     al, 1                       ; apoi dublez rezultatul si merg mai departe
    mov     bl, byte [esi + ecx - 3]    ; fac la fel cu toti cei 4 biti
    add     al, bl
    sub     al, '0'
    shl     al, 1
    mov     bl, byte [esi + ecx - 2]
    add     al, bl
    sub     al, '0'
    shl     al, 1
    mov     bl, byte [esi + ecx - 1]
    add     al, bl
    sub     al, '0'
    sub     ecx, 4
                                        ; dupa ce termin de format numarul
    cmp     al, 10                      ; compar cu 10
    jae     construct_char              ; daca este mai mare sau egal, formez litera
    add     al, '0'

    mov     bl, byte [len_hexa]
    mov     byte [edx + ebx - 1], al
    dec     bl
    mov     byte [len_hexa], bl
    jmp     continue

construct_char:
    sub     al, 10                      ; scot 10 si adun 'A' pentru a obtine
    add     al, 'A'                     ; cifra din hexa
    mov     bl, byte [len_hexa]
    mov     byte [edx + ebx - 1], al    ; o pun pe pozitia corespunzatoare
    dec     bl                          ; decrementez lungimea in hexa
    mov     byte [len_hexa], bl
    jmp     continue                    ; continui cu urmatoarea grupa

first_char:
    shl     al, 1                       ; formez prima cifra hexa
    add     al, byte [esi + ebx]        ; cu bitii obtinuti
    sub     al, '0'
    inc     bl
    cmp     byte [first_part], bl
    ja      first_char                  ; daca mai am biti, continui cu formarea
    cmp     al, 10                      ; daca nu, vad daca este mai mare decat 10
    jae     first_letter                ; daca da, creez litera
    add     al, '0'                     ; daca nu, formez numarul
    mov     byte [edx], al              ; si il pun
    jmp     exit

first_letter:
    sub     al, 10
    add     al, 'A'
    mov     byte [edx], al

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY