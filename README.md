# Bare Bones
This is osdev wiki tutorial [Bare Bones](http://wiki.osdev.org/Bare_Bones).

# Build
## assemble boot.s
```
$ i686-elf-as boot.s -o boot.o
```

## compile kernel.c
```
$ i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
```

## linking the kernel
```
$ i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
```

## building a bootable cdrom image
```
$ cp myos.bin isodir/boot/myos.bin
$ grub-mkrescue -o myos.iso isodir
```

## testing on QEMU
```
$ qemu-system-i386 -cdrom myos.iso
```
if you want run it over ssh
```
$ qemu-system-i386 -cdrom myos.iso -curses
```
