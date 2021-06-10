# nautilOS
a toy operating system

### Instructions for Use

1. set up cross-compilation toolchain (gcc 10.2 and binutils 2.35) targeting the generic `i686-elf` 
1. install QEMU for elf-1386
1. run `make`

### TODO
- keyboard input
    1. set up GDT
    1. set up IDT
    1. set up ISRs
- activate graphics mode
- turn on paging
- set up memory allocation
- set up multiprocesssing and scheduling
