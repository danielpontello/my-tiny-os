;
; A simple boot sector that prints a message to the screen
;

mov ah, 0x0e ; int 10/ah = 0E -> scrolling teleype

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10

jmp $

; 
; Padding and magic BIOS number
;
times 510-($-$$) db 0

dw 0xAA55