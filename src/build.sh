#!/bin/bash
echo "Building bootloader..."
nasm boot_sect.asm -f bin -o boot_sect.bin

echo "Building kernel entry..."
nasm kernel_entry.asm -f elf -o kernel_entry.o

echo "Building kernel..."
gcc -m32 -ffreestanding -fno-pie -c kernel.c -o kernel.o
ld -m elf_i386 -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

echo "Creating Kernel image..."
cat boot_sect.bin kernel.bin > os-image
