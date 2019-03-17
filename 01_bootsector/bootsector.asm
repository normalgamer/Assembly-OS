jmp $            ; Jump to current address, creating an infinite loop

times 510-($-$$) ; Fill 510 bytes of the bootsector with 00 bytes minus the previous code
dw 0xAA55        ; Boot signature
