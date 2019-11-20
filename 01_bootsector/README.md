# The bootsector
When the computer boots, the BIOS looks for any bootable device to run it. To find a bootable device, the BIOS reads the last 2 bytes of the first sector of the first head of the first cylinder of a disk. If the 511 and 512 bytes are ``0xAA55``, the BIOS will boot from that disk.
Let's take a look to a bootable disk's first 512 bytes:
```
e9 fd ff 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 29 more lines filled with 16 zero-bytes each ]
00 00 00 00 00 00 00 00 00 00 00 00 00 00 aa 55
```

Let's take a look at it. The first three bytes perform an infinite jump, and the rest of the sector is filled with zeroes except for the two last bytes, ``0xAA55``. These last two bytes are also called the boot signature.

## Barebones bootsector

You could write all those bytes in binary, but assembly language was created to solve this:
```
jmp $
times 510-($-$$) db 0
dw 0xAA55
```

Let's take a look at it. The first instruction is the same as this:
```
loop:
  jmp loop
```
The ``jmp $`` instruction means "jump to the current address", creating an infinite loop as the example above.

The next instruction is used to tell the assembler to fill the rest of the bootsector with zeroes, minus the last two bytes (it's a bit more complicated, you can google it to find more about it).
And the last instruction is "define word", which writes a double byte, our boot signature.

If you're anxious to try it, run the following two commands to compile and run the bootsector.
```
nasm -f bin bootsector.asm -o bootsector.bin
qemu-system-x86_64 bootsector.bin
```

You will see a window which says "Booting from hard disk...". Have you ever been so excited to see an infinite loop?
