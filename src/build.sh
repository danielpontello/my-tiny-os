#!/bin/bash
echo "Building bootloader..."
nasm boot_sect.asm -f bin -o boot_sect.bin

echo "Building kernel..."
gcc -ffreestanding -c kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

echo "Creating Kernel image..."
cat boot_sect.bin kernel.bin > os-image