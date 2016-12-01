; Pass_Fail.asm
; Pass_Fail Subroutine
; Is it a Pass or Fail ?
;
; Purpose:      The purpose of the Pass_Fail_Subroutine is to
;               determine if the supplied integer is a Pass or a Fail, given that
;               - a Pass is a mark between 50% and 100%, which is a normalized >= 5
;               - a Fail is a mark between 0% and 49%, which is a normalized mark < 5

; Precondition: Accumulator A loaded with number value of mark
;
; Postcondition: A gets destroyed
VALUE_ZERO     	equ     $00             ; Fail value
VALUE_ONE       equ     $01             ; Pass value
VALUE_TWO       equ     $05             ; Mark threshold value

Pass_Fail       cmpa    #VALUE_TWO	; checks if value in acc. A is a fail grade
                blo     Fail            ; branch if value lower than threshold
                ldaa    #VALUE_ONE      ; load acc. A with Pass value
                bra     EndIf           ; branch to end of subroutine
Fail            ldaa    #VALUE_ZERO     ; load acc. A with Fail value
EndIf           rts
