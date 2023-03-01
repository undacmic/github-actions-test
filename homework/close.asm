    .MODEL SMALL
    .DATA
    .CODE
    PUBLIC CLOSE
    CLOSE PROC
    ;
    PUSH BP
    MOV BP, SP
    ;
    MOV AH, 3EH
    MOV BX, [BP+4]
    INT 21H
    ;
    POP BP
    RET
    ;
    ENDP
    END