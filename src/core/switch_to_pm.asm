[bits 16]

; Switches to Protected mode
switch_to_pm:
    cli                     ; clear interrupt table

    lgdt [gdt_descriptor]   ; loads the GDT

    mov eax, cr0            ; set protected mode bit
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; make far jump to finish pipeline

[bits 32]
; initialize stack and registers in protected mode
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM