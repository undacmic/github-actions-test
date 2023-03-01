    .MODEL SMALL
    .DATA
    .CODE
    PUBLIC TASK
    TASK PROC

    PUSH BP
    MOV BP,SP
    ;
    MOV SI, [BP+4]
    ;
UPPER:
    MOV AL, [SI]
    CMP AL, 0
    JE END
    ;
    CMP AL, 'a'
    JL NEXT
    CMP AL, 'z'
    JG NEXT
    ;
    SUB AL, 32
    MOV [SI], AL
NEXT:
    ADD SI, 2
    JMP UPPER
    ;
END:    
    POP BP
    RET
    ;
    ENDP
    END