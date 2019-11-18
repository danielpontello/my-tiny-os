
#include <cpu/isr.h>
#include <drivers/screen.h>
#include <libc/string.h>

#include "kernel.h"

void main() {
    isr_install();
    irq_install();

    kprint("Welcome to the OS!\n"
        "Type END to halt the CPU\n> ");
}

void user_input(char *input) {
    if (strcmp(input, "END") == 0) {
        kprint("Stopping the CPU. Bye!\n");
        asm volatile("hlt");
    }
    kprint("You said: ");
    kprint(input);
    kprint("\n> ");
}