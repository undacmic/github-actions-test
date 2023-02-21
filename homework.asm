ORG 100h

section .data
  ; program data
 
  msg  db 'Hello world'
  crlf db 0x0d, 0x0a
  endstr db '$'

section .text 
    global _start

_start:
  ; program code
  mov  dx, msg;  '$'-terminated string
  mov  ah, 09h; write string to standard output from DS:DX
  int  0x21   ; call dos services
 
  int 20h
