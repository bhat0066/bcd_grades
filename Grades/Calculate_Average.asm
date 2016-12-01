; Calculate_Average.asm
;
; Purpose:              The purpose of the Calculat_Average_Subroutine is to
;                       calculate the average of ANY number of values by
;                       dividing sum of the values by 5, which represents a
;                       normalized average of marks out of 50

; Precondition:         Y points to first value
;                       B contains # values to average
;
; Postcondition:        Y gets destroyed
;                       B gets destroyed

DIVISOR			equ     $05		  ; constant to normalize result
ZERO_B			equ     $00		  ; constant for loop comparison

Result          	db      $00		  ; storage for processed values

Calculate_Average	staa	Result		  ; load zeroized value in acc. A
                	cmpb    #ZERO_B		  ; check if finished
                	beq     End_Calc          ; branch to end process
                	ldaa    1,y+              ; load acc. A with 1st val & inc pointer
                	adda    Result            ; Add Result to value in acc. A
                	staa    Result            ; store new value from acc. A in Result
                	decb                      ; decrement counter
                	bra     Calculate_Average ; branch back to main loop
End_Calc
                	ldx     #DIVISOR          ; load reg. X with DIVISOR value
                	idiv                      ; divides Result value by DIVISOR value
                	exg     d,x               ; move remainder back to acc. D
                	rts
