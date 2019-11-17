;
; Prints a string using a function
;
[org 0x7c00]

    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm

    jmp $

%include "print/print_string.asm"
%include "print/print_string_pm.asm"
%include "core/gdt.asm"
%include "core/switch_to_pm.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

; Global variables
MSG_REAL_MODE: db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: db "Switched to 32-Bit Protected Mode", 0

; 
; Padding and magic BIOS number
;
times 510-($-$$) db 0
dw 0xAA55