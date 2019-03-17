# Printing text
Our bootsector is amazing, but it would be great if we could print some text in the screen. We will use a BIOS interrupt for that.

BIOS interrupts are routines that interrupt our code and jump to the BIOS to do stuff like reading more sectors, printing text... We will use the print interrupt `` int 0x10`` to print text.

When we call ``int 0x10``, the BIOS will check in ah to specify the printing function and then it will print the contents of al

Quick lesson: ``ah`` and ``al`` are two 8-bit registers, which are the High byte and the Low byte of ``ax`` (a 16 bit CPU register).

First we will set ``ax`` to ``0x0E`` to tell the BIOS "write contents of ``al`` in teletype mode". Then we will store a character in ``al`` with ``mov`` and call ``int 0x10``.

Let's take a look at the code:
```
mov ah, 0x0E          ; Teletype mode
mov al, 'X'           ; Store 'X' character in al to print it
int 0x10              ; Call 0x10 interrupt to print the contents of al

jmp $                 ; Jump to current address/infinite loop

times 510-($-$$) db 0 ; Fill the rest of the sector with zeroes minus the last two bytes
dw 0xAA55             ; Boot signature
```
