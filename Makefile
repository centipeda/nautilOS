# Primary Makefile for building NautilOS.

export HOST ?= i686-elf

export AR=$(HOST)-ar
export AS=$(HOST)-as
export CC=$(HOST)-gcc

ISODIR = isodir
KERNELDIR = kernel
LIBCDIR = libc
export OS = nautilos
export OS_ISO = $(OS).iso
export OS_KERNEL = $(SRCDIR)/$(OS).kernel

export DESTDIR = $(SYSROOT)
export TARGET = i686-elf
export PREFIX = /usr
export EXEC_PREFIX = $(PREFIX)
export BOOTDIR = /boot
export LIBDIR = $(EXEC_PREFIX)/lib
export INCLUDEDIR = $(PREFIX)/include

export CFLAGS= -O2 -g
export CPPFLAGS=

export SYSROOT = $(shell pwd)/sysroot
export CC += --sysroot=$(SYSROOT)
export CC += -isystem=$(INCLUDEDIR)
export CC += -v

.PHONY: $(OS_KERNEL) clean libc

all: libc $(OS_ISO)

$(OS_ISO): $(OS_KERNEL) grub.cfg
	mkdir -p $(ISODIR)/boot/grub
	cp $(KERNELDIR)/$(OS_KERNEL) $(ISODIR)/boot
	cp grub.cfg $(ISODIR)/boot/grub
	grub-mkrescue -o $(OS_ISO) $(ISODIR)

$(OS_KERNEL):
	echo "Building kernel..."
	$(MAKE) -C kernel install
	echo "Finished attempting to build kernel."

libc:
	echo "Building libc..."
	$(MAKE) -C libc install
	echo "Finished attempting to build libc."

clean:
	rm -f $(OS_ISO)
	rm -rf $(ISODIR)
	$(MAKE) -C kernel clean
	$(MAKE) -C libc clean

run:
	qemu-system-i386 -cdrom $(OS_ISO)

test:
	./check_multiboot.sh $(OS_KERNEL)
