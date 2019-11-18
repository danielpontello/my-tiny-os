#include <cpu/isr.h>
#include <drivers/screen.h>
#include <libc/string.h>
#include <libc/mem.h>

#include "kernel.h"

void kernel_main() {
    isr_install();
    irq_install();

    clear_screen();
    kprint("Welcome to the OS!\n"
        "Type HELP for help\n> ");
}

void user_input(char *input) {
    if (strcmp(input, "CLEAR") == 0) {
        clear_screen();
    }
    else if (strcmp(input, "HELLO") == 0) 
    {
        kprint("Hello World!");
    } 
    else if (strcmp(input, "HELP") == 0) 
    {
        kprint("\nSystem Help\n");
        kprint("\n");
        kprint("CLEAR  Clears the screen\n");
        kprint("HELLO  Hello World!\n");
        kprint("HELP   This message\n");
        kprint("EXIT   Quit the system\n");
    } 
    else if(strcmp(input, "PAGE") == 0) 
    {
        uint32_t phys_addr;
        uint32_t page = kmalloc(1000, 1, &phys_addr);

        char page_str[16] = "";
        hex_to_ascii(page, page_str);

        char phys_str[16] = "";
        hex_to_ascii(phys_addr, phys_str);

        kprint("Page: ");
        kprint(page_str);
        kprint(", physical address: ");
        kprint(phys_str);
        kprint("\n");
    }
    else if (strcmp(input, "END") == 0 || strcmp(input, "EXIT") == 0) 
    {
        kprint("Stopping the CPU. Bye!\n");
        asm volatile("hlt");
    } 
    else 
    {
        kprint("Command not found: ");
        kprint(input);
    }
    kprint("\n> ");
}