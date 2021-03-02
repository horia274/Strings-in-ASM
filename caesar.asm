%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    xor     ebx, ebx                    ; tin un indice in ebx sa parcurg plaintext

check:
    cmp     ebx, ecx                    ; compar cu lungimea lui plaintext
    jb      continue                    ; daca mai am caracter, le procesez
    jmp     exit                        ; daca nu, inseamna ca am terminat

continue:
    inc     ebx                         ; gasesc un nou caracter in sir
    mov     al, byte [esi + ebx - 1]    ; in pun in al si verific daca am litera
    cmp     al, 'z'                     ; compar cu 'z'
    ja      not_letter                  ; daca este mai mare, nu este litera
    cmp     al, 'A'
    jb      not_letter                  ; la fel daca este mai mic decat 'A'
    cmp     al, 'Z'                     ; daca ajunge aici, inseamna ca este litera
    jbe     capital_letter              ; si daca este sub 'Z' atunci va fi litera mare
    cmp     al, 'a'
    jae     lowercase_letter            ; daca nu, compar cu 'a' sa vad daca este mica
    jmp     not_letter                  ; daca este intre 'Z' si 'a' nu va fi litera

not_letter:
    mov     byte [edx + ebx - 1], al    ; pun direct caracterul in ciphertext
    jmp     check                       ; continui cu urmatorul caracter

capital_letter:
    add     eax, edi                    ; adun la caracter cheia key
    cmp     al, 'Z'
    ja      substract_from_capital      ; daca sare de 'Z', o fac din nou litera
    mov     byte [edx + ebx - 1], al
    jmp     check

substract_from_capital:
    sub     al, 26                      ; 26 = 'Z' - 'A' si compar din nou cu 'Z'
    cmp     al, 'Z'
    ja      substract_from_capital      ; daca tot este mai mare, mai scad 26
    mov     byte [edx + ebx - 1], al    ; repet asta pana devine din nou litera
    jmp     check                       ; si o pun in ciphertext, apoi continui

lowercase_letter:
    add     eax, edi                    ; daca este litera mica, procedez la fel
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