    .MODEL SMALL
    .DATA
    .CODE
    PUBLIC READLINE
    READLINE PROC

    PUSH BP
    MOV BP,SP
    ;
    MOV AH, 3FH
    MOV BX, [BP+6]
    MOV CX, 80
    MOV DX, [BP+4]
    INT 21H
    ;
    POP BP
    RET
    ;
    ENDP
    END