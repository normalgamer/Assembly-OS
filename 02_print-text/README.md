# Printing text
Our bootsector is amazing, but it would be better if we could print some text in the screen. We will use a BIOS interrupt for that.

BIOS interrupts are routines that interrupt our code and jump to the BIOS to do stuff like reading more sectors, printing text... We will use the print interrupt `` int 0x10`` to print text.

The ``int 0x10`` interrupt needs two arguments: the printing mode and the character to print. To set those we will use CPU registers.

## CPU registers
"But what is a CPU register?" you may ask. CPU registers are small pieces of memory integrated in a CPU, to operate data. In 16 bit architecture, we have multiple registers: general purpose registers (AX, BX, CX and DX), which can be split in two 8-bit registers (so AX becomes AH (high 8 bit) and AL (low 8 bit)), the Stack Pointer, offset registers (SI and DI), and more. We will be using AX split into AH and AL.

## Int 0x10 "arguments"
Int 0x10 needs two values set in AH and AL. We have to set ``ah`` to ``0x0E`` which tells the BIOS to write the contents of ``al`` int teletype mode. Then we set in ``al`` the character we want to print.
Let's see how we can do it:

```
mov ah, 0x0E           ; Set print mode to teletype
mov al, 'X'            ; Store the character we want to prrint in al
int 0x10               ; Call BIOS interrupt 0x10, to print the 'X' character in teletype mode

jmp $                  ; Infinite loop

times 510-($-$$) db 0  ; Fill the rest of the bootsector with 0s
dw 0xAA55              ; Boot signature
```

Congratulations! You have learned to print characters into the screen, as well as moving data! The ``mov`` instruction 'moves' or copies data from one place to another.
Syntax: ``mov destination, origin``
You can write a 'hex value', a register, or an \[address] in the destination or origin.

You can compile it and run it, and you'll see an X printed in the screen. Are you excited? Sure I do!
