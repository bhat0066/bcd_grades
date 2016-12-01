; Calculate_Average.asm
;
; Author:
; Student Number:
; Date:
;

; Purpose:      The purpose of the Calculat_Average_Subroutine is to
;               calculate the average of ANY number of values by dividing
;               sum of the values by 5, which represents a normalized average
;               of marks out of 50

; Precondition: Y points to first value
;               B contains # values to average
;
; Postcondition:

DIVISOR                 equ     $05
Result                	db      $00

Calculate_Average      	staa    Result
			cmpb    #$00
                        beq     End_Calculate_Average
   			ldaa    1,y+
                        adda    Result
                        staa    Result
                        decb
                        bra     Calculate_Average
End_Calculate_Average
                        ldx     #DIVISOR
                        idiv
                        exg     d,x
                        rts