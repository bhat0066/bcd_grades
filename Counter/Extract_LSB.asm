; Extract_LSB.asm
;
; Purpose:              This program extracts the lower nibble of accumulator
;                       from 8 bit accumulator
;
; Preconditions:        Value to be converted is in Accumulator A
;
;
; Postcondition:        A is destroyed
;
;
;
Extract_LSB
                anda    #%00001111      ; masks value to have only lower nibble
                rts
;- ------------------------------------
;     End Extract_LSB.asm             -
;--------------------------------------
