
.PHONY: $(SRCDIR)/$(OS_BIN) clean
ISODIR = isodir
SRCDIR = kernel
OS = nautilos
OS_ISO = $(OS).iso
OS_BIN = $(OS).bin
all: $(OS_ISO)

$(OS_ISO): $(SRCDIR)/$(OS_BIN) grub.cfg
	cp $(SRCDIR)/$(OS_BIN) $(ISODIR)/boot
	cp grub.cfg $(ISODIR)/boot/grub
	grub-mkrescue -o $(OS_ISO) $(ISODIR)

$(SRCDIR)/$(OS_BIN):
	$(MAKE) -C kernel

clean:
	rm -f $(OS_ISO)
	$(MAKE) -C kernel clean

run:
	qemu-system-i386 -cdrom $(OS_ISO)

test:
	./check_multiboot.sh $(SRCDIR)/$(OS_BIN)
