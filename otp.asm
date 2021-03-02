%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

continue:
    mov     al, byte [esi + ecx - 1]    ; iau fiecare caracter din plaintex
    xor     al, byte [edi + ecx - 1]    ; fac xor intre acesta si key
    mov     byte [edx + ecx - 1], al    ; pun rezultatul in ciphertext
    loop    continue

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY