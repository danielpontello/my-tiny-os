;
; Prints a string using a function
;
[org 0x7c00]

    mov [BOOT_DRIVE], dl    ; saves boot drive into al

    mov bp, 0x8000          ; set stack base and top
    mov sp, bp

    mov bx, 0x9000          ; load 5 sectors to ES:BX
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000]        ; print the loaded word
    call print_hex

    mov dx, [0x9000 + 512]  ; print loaded word from 2nd sector
    call print_hex

    jmp $

%include "print/print_string.asm"
%include "print/print_hex.asm"
%include "io/disk_load.asm"

; Global variables
BOOT_DRIVE: db 0

; 
; Padding and magic BIOS number
;
times 510-($-$$) db 0
dw 0xAA55

; write random data to adjacent sectors
times 256 dw 0xdada
times 256 dw 0xface