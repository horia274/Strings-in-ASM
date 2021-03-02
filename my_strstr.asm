%include "io.mac"

section .data
    haystack_len dd 0           ; pastrez in variabile lungimea string-ului
    needle_len dd 0             ; si a substring-ului

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr
    mov     [haystack_len], ecx     ; imi pun in variabile lungimea string-urilor
    mov     [needle_len], edx
    xor     eax, eax                ; eax - indice pentru haystack

check:
    cmp     eax, [haystack_len]     ; compar cu lungimea lui
    jb      new_try                 ; daca este sub, verific daca se potriveste cu needle
    jmp     not_found               ; daca nu, inseamna ca nu am gasit

new_try:
    push    eax                     ; pun in stiva noul indice care ar putea fi rezultatul
    xor     ecx, ecx                ; tin indice pentru needle
    mov     edx, eax
    add     edx, ecx                ; merg la pozitia corespunzatoare din plaintext

compare:
    cmp     ecx, [needle_len]       ; cat timp sunt in subsir
    je      found                   ; daca indicele este egal cu dimensiunea, am gasit
    cmp     edx, [haystack_len]     ; daca nu, procesez caractere din string
    je      not_found               ; daca indicele este prea mare, inseamna ca nu am gasit
    mov     al, byte [esi + edx]    ; daca nu, compar cele 2 caractere
    cmp     al, byte [ebx + ecx]
    jne     continue_index          ; daca nu sunt egale, continui in string
    inc     ecx                     ; daca nu, cresc cei doi indici si continui
    inc     edx                     ; sa compar valorile din cele 2 string-uri
    jmp     compare

continue_index:
    pop     eax                     ; scot indicele si incrementez, mutandu-ma la
    inc     eax                     ; urmatorul caracter
    jmp     check

found:
    pop     eax                     ; scot din stiva indicele bagat, care va fi rezultatul
    mov     [edi], eax              ; il pun unde trebuie
    jmp     exit                    ; si ies

not_found:
    mov     edx, [haystack_len]     ; daca nu se gaseste, pun lungimea lui haystack + 1
    inc     edx
    mov     [edi], edx
    jmp     exit

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY