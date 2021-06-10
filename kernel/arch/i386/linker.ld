/*  start execution at the symbol designated as entry point */
ENTRY(_start)

/* show where each section of the object files are to be placed */
SECTIONS {
    . = 1M;
    /* place multiboot header */
    .text BLOCK(4K) : ALIGN(4K) {
        *(.multiboot)
        *(.text)
    }

    .rodata BLOCK(4K) : ALIGN(4K) {
        *(.rodata)
    }

    .data BLOCK(4K) : ALIGN(4K) {
        *(.data)
    }

    .bss BLOCK(4K) : ALIGN(4K) {
        *(COMMON)
        *(.bss)
    }

    /* add other stuff as needed */
}
