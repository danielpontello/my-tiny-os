[bits 32]

; Constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY       ; set edx to video mem start

print_string_pm_loop:
    mov al, [ebx]               ; stores char in AL
    mov ah, WHITE_ON_BLACK      ; stores attribs in AH

    cmp al, 0                   ; if char == 0, end of string
    je done

    mov [edx], ax               ; writes to video mem

    add ebx, 1                  ; go to next char 
    add edx, 2                  ; step vga cell

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret