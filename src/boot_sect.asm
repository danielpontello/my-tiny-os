;
; Prints a string using a function
;
[org 0x7c00]

    mov bx, HELLO_MSG
    call print_string

    mov bx, GOODBYE_MSG
    call print_string

    jmp $

%include "print_string.asm"

; Data
HELLO_MSG:
    db 'Hello, World!', 0 ; <-- Null-terminating!

GOODBYE_MSG:
    db 'Goodbye!', 0

; 
; Padding and magic BIOS number
;
times 510-($-$$) db 0
dw 0xAA55