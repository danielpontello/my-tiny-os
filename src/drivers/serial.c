#include <libc/string.h>
#include <libc/function.h>
#include <kernel/kernel.h>
#include <cpu/ports.h>
#include <cpu/isr.h>

#include "serial.h"

void init_serial()
{
    port_byte_out(SERIAL_ADDRESS + 1, 0x00);    // disable interrupts

    port_byte_out(SERIAL_ADDRESS + 3, 0x80);    // dlab

    port_byte_out(SERIAL_ADDRESS + 0, 0x03);    // baud rate
    port_byte_out(SERIAL_ADDRESS + 1, 0x00);    

    port_byte_out(SERIAL_ADDRESS + 3, 0x03);    // parity
    port_byte_out(SERIAL_ADDRESS + 2, 0xC7);    // fifo

    port_byte_out(SERIAL_ADDRESS + 4, 0x0B);    // enable irq
}

int serial_received() 
{
    return port_byte_in(SERIAL_ADDRESS + 5) & 1;
}
 
char read_serial() 
{
    while (serial_received() == 0);
 
    return port_byte_in(SERIAL_ADDRESS);
}

int is_transmit_empty() 
{
    return port_byte_in(SERIAL_ADDRESS + 5) & 0x20;
}
 
void write_serial(char a) 
{
    while (is_transmit_empty() == 0);
 
    port_byte_out(SERIAL_ADDRESS, a);
}

void print_serial(char *s) 
{
    int i = 0;
    while (s[i] != '\0')
    {
        write_serial(s[i]);
        i++;
    }
}
