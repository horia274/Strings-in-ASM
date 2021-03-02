%include "io.mac"

section .data
    key_len dd 0                ; pastrez intr-o variabila lungimea cheii
    plaintext_len dd 0          ; si in alta lungimea lui plaintext

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
    mov     [key_len], ebx
    mov     [plaintext_len], ecx
    xor     ebx, ebx                    ; resetez registrii
    xor     ecx, ecx                    ; ebx - indice plaintext, ecx - indice key

check:
    cmp     ebx, [plaintext_len]        ; compar indicele cu dimensiuea
    jb      continue                    ; daca mai am caractere le procesez
    jmp     exit

continue:
    inc     ebx                         ; fac aceleasi verificari ca la caesar
    mov     al, byte [esi + ebx - 1]    ; sa vad ce caractere sunt litere
    cmp     al, 'z'
    ja      not_letter
    cmp     al, 'A'
    jb      not_letter
    cmp     al, 'Z'
    jbe     check_capital_letter
    cmp     al, 'a'
    jae     check_lowercase_letter
    jmp     not_letter

not_letter:
    mov     byte [edx + ebx - 1], al
    jmp     check

check_capital_letter:
    cmp     ecx, [key_len]              ; compar indicele cheii cu dimensiunea
    jb      capital_letter              ; daca este mai mic, voi aduna cele 2 caractere
    xor     ecx, ecx                    ; daca nu, resetez indicele si o iau de la capat
    jmp     capital_letter

capital_letter:
    add     eax, [edi + ecx]            ; acum pot sa adun cele 2 valori
    sub     eax, 'A'                    ; obtin pozitia literei din key in alfabet
    inc     ecx                         ; continui in key
    cmp     al, 'Z'                     ; verific sa nu trec de litera 'Z'
    ja      substract_from_capital      ; daca da, scad 'Z' - 'A' pana devine litera
    mov     byte [edx + ebx - 1], al    ; la final pun in ciphertext
    jmp     check

substract_from_capital:
    sub     al, 26                      ; in rest, procedez ca la caesar
    cmp     al, 'Z'
    ja      substract_from_capital
    mov     byte [edx + ebx - 1], al
    jmp     check

check_lowercase_letter:
    cmp     ecx, [key_len]
    jb      lowercase_letter
    xor     ecx, ecx
    jmp     lowercase_letter

lowercase_letter:
    add     eax, [edi + ecx]
    sub     eax, 'A'
    inc     ecx
    cmp     al, 'z'
    ja      substract_from_lowercase
    mov     byte [edx + ebx - 1], al
    jmp     check

substract_from_lowercase:
    sub     al, 26
    cmp     al, 'z'
    ja      substract_from_lowercase
    mov     byte [edx + ebx - 1], al
    jmp     check

exit:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY