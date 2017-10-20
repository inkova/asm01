section .data
    format: db "z = %d", 10, 0  ; data bytes z = %d\n\0
section .text
    global main  ; Export main for linker
    extern printf  ; Request linking with printf in linker
sum:
    ; Preable
    push ebp
    mov ebp, esp

    ; Body
    
    mov eax, dword [ebp + 12]; eax=b
    mul eax                  ; eax=b^2
    mov ecx, eax             ; ecx=eax=b^2
    mov eax, dword [ebp + 8] ; eax = a
    mov edx, dword [ebp + 16]; edx=c
    mul edx                  ; eax= eax*edx=a*c 
    mov edx, 4
    mul edx                  ; eax= eax*4=a*c*4 
    sub ecx, eax             ; ecx= ecx-eax=b^2-4*a*c
    mov eax, ecx

    ; Epilogue
    pop ebp
    ret
main:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    push dword 1  ; c 
    push dword 1  ; a
    push dword 4  ; b
    call sum
    add esp, 12

    push eax  ; result of sum
    push format
    call printf
    add esp, 8

    pop edi
    pop esi
    pop ebx

    pop ebp
    ret


