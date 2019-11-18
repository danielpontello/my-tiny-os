;
; Prints a string using a function
;
[org 0x7c00]
KERNEL_OFFSET equ 0x1000
    mov [BOOT_DRIVE], dl    ; store boot drive in dl

    mov bp, 0x9000          ; setup stack
    mov sp, bp

    mov bx, MSG_REAL_MODE   ; print boot message
    call print_string

    call load_kernel        ; load kernel into memory

    call switch_to_pm       ; switch to protected mode

    jmp $

; include useful routines
%include "print/print_string.asm"
%include "print/print_string_pm.asm"
%include "core/gdt.asm"
%include "core/switch_to_pm.asm"
%include "io/disk_load.asm"

[bits 16]

load_kernel:
    mov bx, MSG_LOAD_KERNEL ; print 'loading kernel' message
    call print_string

    mov bx, KERNEL_OFFSET   ; configure disk_load routine
    mov dh, 15              ; to load kernel sectors
    mov dl, [BOOT_DRIVE]    ; to address KERNEL_OFFSET
    call disk_load

    ret

[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE  ; use 32-bit print routine
    call print_string_pm    ; to print information

    call KERNEL_OFFSET      ; execute the kernel C code!

    jmp $

; Global variables
BOOT_DRIVE      db 0
MSG_REAL_MODE   db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE   db "Switched to 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory...", 0
; 
; Padding and magic BIOS number
;
times 510-($-$$) db 0
dw 0xaa55