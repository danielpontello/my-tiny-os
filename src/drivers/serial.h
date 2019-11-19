#ifndef SERIAL_H
#define SERIAL_H

#define SERIAL_ADDRESS 0x3f8

void init_serial();
char read_serial();
void write_serial(char a);
void print_serial(char *s);

#endif