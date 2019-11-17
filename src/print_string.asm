print_string:
    pusha
    mov ah, 0x0e

    rpt:
        mov al, [bx]
        cmp al, 0
        je done
        int 0x10
        inc bx
        jmp rpt
    
    done:
        popa
        ret