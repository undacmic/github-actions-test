BITS 16
EXTERN f

section .text
    global _start

_start:
	CALL f
    MOV AH, 4Ch
    INT 21h
