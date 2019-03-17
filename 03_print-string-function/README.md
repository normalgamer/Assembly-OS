# Improving our print string

We know how to print text in the screen, but it's a bit tedious to constantly load into al the char we want to print, so we are going to create a function for it.
## Strings

To define a string, we use db (define byte) to store our string in bytes, and then we add a zero to know where our string ends:

``my_string db 'Hello World', 0``

## Calling functions

To call a function, we write call and the name of our function. ``call print_string``
## Comparations

To compare data stored in registers, we use cmp, and then we use another instruction to jump to a point in memory depending on the result.
```
mov ax, 0       ; We store 0 in ax
cmp ax, 4       ; Comparing ax with 4

start:          ; We define a label to return here at some point
je done         ; Jump if Equal. If ax == 4 then jump to done
jne ax_plus_one ; Jump if Not Equal, If ax != 4 then jump to ax_plus_one

ax_plus_one:    
  inc ax        ; ax = ax + 1
  jmp start     ; Return to start
  
done:
  jmp $         ; Infinite loop
```
# Writing our print_string function

We will use new instructions here, lodsb and ret, plus a new register, si
```
[org 0x7C00]
start:
  mov si, hello_world
  call print_string
  
print_string:
  mov ah, 0x0E
  .loop:
    lodsb
    cmp al, 0
    je done
    int 0x10
    jmp loop
  .done:
    ret
    
hello_world db 'Hello World', 0
times 510-($-$$) db 0
dw 0xAA55
```

Let's explain this monstruosity. ``[org 0x7C00]`` is used to tell the assembler where are we loaded in RAM. When the computer starts, the BIOS will tell load us in RAM address 0x7C00, so we need to tell the assembler to organize our code to start from that address. If you skip it, your print string will read from a different location the string.

``mov si, hello_world`` is probably the most difficult part to understand. The si register is the source index register, and is used to point to a memory location, in this case to the memory loaction our string is defined.

``call print_string`` just calls our printing function.

``lodsb`` loads the first byte of the address si is pointing to (our string) into al.

After that our code compares if the character in al equals zero (end of the string). If it does, it will jump to done, and from there it will RETurn to where the function was called.

If the character in al doesn't equal zero (there are still bytes to be printed), we will call in 0x10 to print the character, and then we will jump to loop, to repeat the process. This time, ``lodsb`` will load the next byte of the string.

If you want, you can save the print_string function on a separate file, and in your main bootsector file write ``%include "print_string.asm"`` before ``times 510-($-$$) db 0``. The compiler will compile it with the bootsector.
