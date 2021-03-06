# Makefile for building NautilOS kernel.

OS ?= nautilos
OS_KERNEL = $(OS).kernel
TARGET ?= i686-elf

DEFAULT_HOST = i686-elf
HOST ?= $(DEFAULT_HOST)
DEFAULT_ARCH = i386
HOSTARCH ?= $(DEFAULT_ARCH)

CFLAGS ?= -O2 -g
CPPFLAGS ?=
LDFLAGS ?=
LIBS ?=

DESTDIR ?=
PREFIX ?= /usr
EXEC_PREFIX ?= $(PREFIX)
BOOTDIR ?= $(EXEC_PREFIX)/boot
INCLUDEDIR ?= $(PREFIX)/include

CFLAGS := $(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS := $(CPPFLAGS) -D__is_kernel -Iinclude
LDFLAGS := $(LDFLAGS)
LIBS := $(LIBS) -nostdlib -lk -lgcc

ARCHDIR = arch/$(HOSTARCH)

include $(ARCHDIR)/make.config

CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)

KERNEL_OBJS =\
$(KERNEL_ARCH_OBJS) \
kernel/kernel.o \

OBJS=\
$(ARCHDIR)/crti.o \
$(ARCHDIR)/crtbegin.o \
$(KERNEL_OBJS) \
$(ARCHDIR)/crtend.o \
$(ARCHDIR)/crtn.o \

LINK_LIST=\
$(LDFLAGS) \
$(ARCHDIR)/crti.o \
$(ARCHDIR)/crtbegin.o \
$(KERNEL_OBJS) \
$(LIBS) \
$(ARCHDIR)/crtend.o \
$(ARCHDIR)/crtn.o \

all: $(OS_KERNEL)

$(OS_KERNEL): $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(LINK_LIST) 

$(ARCHDIR)/crtbegin.o $(ARCHDIR)/crtend.o:
	OBJ=`$(CC) $(CFLAGS) $(LDFLAGS) -print-file-name=$(@F)` && cp "$$OBJ" $@

%.o: %.c
	$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS) $(CPPFLAGS)

%.o: %.s
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)

clean:
	rm -f $(OS_KERNEL)
	rm -f $(OBJS) *.o */*.o */*/*.o
	rm -f $(OBJS:.o=.d) *.d */*.d */*/*.d

install: install-headers install-kernel

install-headers:
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	cp -R --preserve=timestamps include/. $(DESTDIR)/$(INCLUDEDIR)/.

install-kernel: $(OS_KERNEL)
	mkdir -p $(DESTDIR)$(BOOTDIR)
	cp $< $(DESTDIR)$(BOOTDIR)

-include $(OBJS.o=.d)
