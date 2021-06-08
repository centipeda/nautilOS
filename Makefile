
.PHONY: $(SRCDIR)/$(OS_BIN) clean
ISODIR = isodir
SRCDIR = kernel
export OS = nautilos
export OS_ISO = $(OS).iso
export OS_BIN = $(OS).bin

export TARGET = i686-elf
export PREFIX = "$HOME/opt/cross"
all: $(OS_ISO)

$(OS_ISO): $(SRCDIR)/$(OS_BIN) grub.cfg
	mkdir -p $(ISODIR)/boot/grub
	cp $(SRCDIR)/$(OS_BIN) $(ISODIR)/boot
	cp grub.cfg $(ISODIR)/boot/grub
	grub-mkrescue -o $(OS_ISO) $(ISODIR)

$(SRCDIR)/$(OS_BIN):
	$(MAKE) -C kernel

clean:
	rm -f $(OS_ISO)
	rm -rf $(ISODIR)
	$(MAKE) -C kernel clean

run:
	qemu-system-i386 -cdrom $(OS_ISO)

test:
	./check_multiboot.sh $(SRCDIR)/$(OS_BIN)
