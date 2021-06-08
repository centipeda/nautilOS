OS ?= nautilos
OS_BIN ?= $(OS).bin
TARGET ?= i686-elf
:q

CC = i686-elf-gcc
AS = i686-elf-as

all: $(OS_BIN)

$(OS_BIN): linker.ld boot.o kernel.o
	$(CC) -T linker.ld -o $(OS_BIN) -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

boot.o: boot.s
	$(AS)  boot.s -o boot.o

kernel.o: kernel.c
	$(CC)  -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

clean:
	rm -f *.o $(OS_BIN)
