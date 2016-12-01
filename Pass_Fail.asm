; Pass_Fail.asm
; Pass_Fail Subroutine
; Is it a Pass or Fail ?

; Author:
; Student Number:
; Date:
;

; Purpose:      The purpose of the Pass_Fail_Subroutine is to
;               determine if the supplied integer is a Pass or a Fail, given that
;               - a Pass is a mark between 50% and 100%, which is a normalized >= 5
;               - a Fail is a mark between 0% and 49%, which is a normalized mark < 5

; Precondition:
;
;
;
;
; Postcondition:

Pass_Fail       cmpa    #$05
                blo     Fail
                ldaa    #$01
                bra     EndIf
Fail            ldaa    #$00
EndIf           rts