# Declare constants for the multiboot header.
.set ALIGN,  1<<0         # align loaded modules on page boundaries
.set MEMINFO, 1<<1        # provide memory map
.set FLAGS, ALIGN|MEMINFO # this is the Multiboot 'flag' field
.set MAGIC, 0x1BADB002    # 'magic number' lets bootloader find the header
.set CHECHSUM, -(MAGIC + FLAGS) # checksum of above, to prove we are multiboot

# Declare a multiboot header that marks the program as a kernel.
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECSUM

.section .bss
.align 16
stack_bottom:
.skip 16384 # 16KiB
stack_top:

# The linker script specifies _start as the entry point to the kernel and the
# bootloader will jump  to this position once the kernel has been loaded.
.section .text
.global _start
.type _start, @function
_start:
	# To set up a stack, we set the esp register to point to the top of our
	# stack (as it grows downwards on x86 systems.)
	mov $stack_top, %esp

	# Enter the high-level kernel.
	call kernel_main

	cli
1:  hlt
	jmp 1b

# Set the size of the _start symbol to the current location '.' minus its start.
.size _start, .-_start
