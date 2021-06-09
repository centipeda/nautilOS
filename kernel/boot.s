/* declare contents for multiboot header */
.set ALIGN,    1<<0
.set MEMINFO,  1<<1
.set FLAGS,    ALIGN | MEMINFO
.set MAGIC,    0x1BADB002
.set CHECKSUM, -(MAGIC+FLAGS)

/* declare multiboot header */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* define our stack */
.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

/* set this position as entry point to the kernel */
.section .text
.global _start
.type _start, @function
_start:
    mov $stack_top, %esp

    call kernel_main

    cli
    1: hlt
    jmp 1b

.size _start, . - _start
