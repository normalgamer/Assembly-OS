mov ah, 0x0E          ; Teletype mode
mov al, 'X'           ; Store in al the char we want to print
int 0x10              ; BIOS video interrupt

jmp $                 ; Infinite loop

times 510-($-$$) db 0 ; Fill the rest of the sector with zeroes
dw 0xAA55             ; Boot signature
