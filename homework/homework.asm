    DOSSEG
    .MODEL SMALL
    .STACK 32
    .DATA
buffer      DB 80 DUP(0),'$'
fileHandler DW ?
    .CODE
    EXTRN OPEN:PROC
    EXTRN CLOSE:PROC
    EXTRN READLINE:PROC
    EXTRN TASK:PROC
    EXTRN WRITE:PROC
START:
    MOV AX, @DATA
    MOV DS, AX
    ;
    CALL OPEN
	MOV fileHandler, AX
    ;
    MOV BX, fileHandler
    PUSH BX
    MOV DX, OFFSET buffer
    PUSH DX
    CALL READLINE
    POP DX
    POP BX
    ;
    MOV BX, fileHandler
    PUSH BX
    CALL CLOSE
    POP BX
    ;
    ; Illegal instruction
    ;MOV AL, BX
    ;
    ;
    ;
    ;mov ax, [0xffff]
    ;
    ;
    PUSH DX
    CALL TASK
    POP DX
    ;
    PUSH DX
    CALL WRITE
    POP DX
    ;
    MOV AH, 4CH
    INT 21H
    ;
    END START