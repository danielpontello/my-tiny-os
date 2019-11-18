C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h)

OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o} 

CC = gcc
CFLAGS = -g -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs \
		 -I'./'

all: os-image

# runs the system in an emulator
run: all
	qemu-system-i386 -fda os-image -boot a

# combines the boot sector with the kernel
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

# build kernel binary
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

# build kernel object file
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -fno-pie -c $< -o $@

# build kernel_entry
%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -i'boot/' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image *.map
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o cpu/*.o libc/*.o