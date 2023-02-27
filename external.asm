BITS 16

section .text
    global f

f:
    MOV AH, 02h
    MOV DL, 'O'
    INT 021h
    MOV DL, 'K'
    INT 021h
    MOV DL, '!'
    INT 021h
    RET
