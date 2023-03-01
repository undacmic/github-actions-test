    .MODEL SMALL
    .DATA
fileName    DB 'out/out1.txt', 0
fileHandler DW ?
    .CODE
    PUBLIC WRITE
    WRITE PROC

    PUSH BP
    MOV BP, SP
    ;
    MOV AH, 3CH
    MOV AL, 01H
    MOV CX, 0
    MOV DX, OFFSET fileName
    int 21H
    MOV fileHandler, AX
    ;
    MOV SI, [BP+4]
CHAR:
    MOV AL, [SI]
    CMP AL, 0
    JE DONE
    CMP AL, 20H
    JL NEXT
    CMP AL, 7FH
    JG NEXT
    ;
    MOV AH, 40H
    MOV CX, 1
    MOV DX, SI
    INT 21H
NEXT:
    INC SI
    JMP CHAR
DONE:
    MOV AH, 3EH
    MOV BX, fileHandler
    INT 21H
    ;
    POP BP
    RET
    ;
    ENDP
    END