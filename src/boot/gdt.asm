; Global Descriptor Table
gdt_start:

; there must be an invalid entry on the GDT to catch errors
gdt_null:
    dd 0x0      ; dd -> 'double word' (4 bytes)
    dd 0x0

; code segment of the GDT
; base=0x0, limit=0xfffff
; 1st flags: present (1), privilege (00), descriptor type(1) -> 1001b
; type flags: code (1), conforming (0), readable (1), acessed (0) -> 1010b
; 2nd flags: granularity (1), 32-bit (1), 64-bit (0), AVL (0) -> 1100b
gdt_code:
    dw 0xffff       ; Limit
    dw 0x0          ; Base
    db 0x0          ; Base
    db 10011010b    ; 1st flags, type
    db 11001111b    ; 2nd flags, Limit
    db 0x0          ; Base

; data segment
; same as code, but with the following type flags:
; code (0), expand down (0), writable (1), acessed (1) -> 0010b
gdt_data:
    dw 0xffff       ; Limit
    dw 0x0          ; Base
    db 0x0          ; Base
    db 10010010b    ; 1st flags, type
    db 11001111b    ; 2nd flags, Limit
    db 0x0          ; Base

gdt_end:

; GDT Descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start