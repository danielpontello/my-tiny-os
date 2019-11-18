disk_load:
    push dx         ; save DX to stack

    mov ah, 0x02    ; read sector function
    mov al, dh      ; read DH sectors
    mov ch, 0x00    ; cylinder 0
    mov dh, 0x00    ; head 0
    mov cl, 0x02    ; sector 2 (after boot sector)

    int 0x13        ; interrupt

    jc disk_error   ; jump if error (carry flag)

    pop dx          ; restore dx
    cmp dh, al      ; if sectors read != sectors expected
    jne disk_error  ; show error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; Variables
DISK_ERROR_MSG  db "Disk read error!",0