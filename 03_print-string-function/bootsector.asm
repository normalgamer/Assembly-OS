[org 0x7C00]          ; Tell the assembler where will we be loaded

start:
  mov si, hello_world ; Point si to our string location
  call print_string
  
; Functions 
; Alternatively you can store the print_string function in a new file called print_string.asm and include it before the 'times 510-($-$$) db 0' instruction

print_string:         ; Beginning of our function
  mov ah, 0x0E        ; tty
  .loop:              ; label inside function
    lodsb             ; load a byte of hello_world
    cmp al, 0         ; if al==0 end of string
    je .done          ; jump to done
    int 0x10          ; else write char
    jmp .loop         ; and repeat process untiil al=0
  .done               
    ret               ; return from function
    
hello_world db 'Hello World', 0

; Alternatively include files here with '%include "your_file.asm"'

times 510-($-$$) db 0
dw 0xAA55
