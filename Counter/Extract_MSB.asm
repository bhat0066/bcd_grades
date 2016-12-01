; Extract_MSB.asm
;
; Purpose:              This program extracts the upper nibble of accumulator
;                       from 8 bit accumulator
;
; Preconditions:        Value to be converted is in Accumulator A
;
;
; Postcondition:        A is destroyed
;
;
;
Extract_MSB
        lsra           ; pushes zero in from left
        lsra           ; pushes zero in from left
        lsra           ; pushes zero in from left
        lsra           ; pushes zero in from left
        rts
;- ------------------------------------
;     End Extract_MSB.asm             -
;--------------------------------------
