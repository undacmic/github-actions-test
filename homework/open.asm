    .MODEL SMALL
    .DATA
fileName DB 'in/in1.txt', 0
    .CODE
    PUBLIC OPEN
    OPEN PROC
    ;
    PUSH BP
	MOV BP,SP
    ;
    MOV AH, 3DH
    MOV AL, 0
    MOV DX, OFFSET fileName
    INT 21H
    ;
    POP BP
    RET
    ;
    ENDP
    END
