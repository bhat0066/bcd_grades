; Pass_Fail_Calc.asm

#include c:\68hcs12\registers.inc
;
; Purpose:      Calculate if a student has passed both the Practical and Theory
;               portions of the course. Display a 'P' if both portions passed;
;               otherwise, display an 'F' Display the values for 1 second each
;               (e.g. 4 delay cycles of 250 ms each) Then, blank the display for
;               the same amount of time and continue on with the values. At the
;               end, blank the display
;
;               Note that there is only ONE 'P' or 'F' displayed per student
;
;
; Program Constants
DELAY_VALUE     equ     250             ; Delay value (base 10) 0 - 255 ms
PRACTICAL       equ     $05             ; Number of practical marks to assess
THEORY          equ     $03             ; Number of theory marks to assess
FAIL_VAL        equ     $00             ; Representation of failed mark
PASS_VAL        equ     $01             ; Representation of passed mark
BLANK_VAL       equ     $02             ; Value for calling blank function
I_ZERO          equ     00              ; Start marker for iteration
I_MAX           equ     06              ; Max of iterations - half size of student array
DIGIT3_PP0      equ     %00000111       ; MSB of the displayed BCD digits (left-most dislay)

; data section
                org     $1000

; Read in Data File
Start_Course_Data
; remove the comment symbol (;) to unmask your lab section's include statement
; #include "Demo.txt"                   ; P F P P F P -> Results in Video
#include "Tue_5-7_Marks.txt"
; #include "Thu_8-10_Marks.txt"
; #include "Thu_10-12_Marks.txt"
; #include "Thu_5-7_Marks.txt"
; #include "Fri_1-3_Marks.txt"
End_Course_Data

Student_Array	ds        12			; holds student pass/fail values

; code section
                org     $2000			; RAM address for Code

                lds     #$2000			; Stack location
                ldx     #Student_Array          ; load pointer X for start of Student_Array
                ldy     #Start_Course_Data      ; load pointer Y for start of Start_Course_Data
                
Calc_Loop       cpy     #End_Course_Data        ; compare register Y to end of course data
                beq     Config_Display          ; if equal branch to Config_Display
                ldaa    0,y                     ; load zeroith index of reg. Y
                ldab    #PRACTICAL              ; load acc. B with number of practical marks
                pshx                            ; Sends value in reg. X to stack
                clra                            ; clear junk data from acc. A
                jsr     Calculate_Average       ; calculates average of marks per student
                jsr     Pass_Fail               ; assigns a pass of fail to practical per student
                pulx                            ; Retrieve reg. X value from stack
                staa    1,x+                    ; store practical pass/fail in student array
                ldab    #THEORY                 ; load acc. B with number of theory marks
                pshx                            ; Sends value in reg. X to stack
                clra                            ; clear junk data from acc. A
                jsr     Calculate_Average       ; calculates average of marks per student
                jsr     Pass_Fail               ; assigns a pass of fail to theory per student
                pulx                            ; Retrieve reg. X value from stack
                staa    1,x+                    ; store theory pass/fail in student array
                bra     Calc_Loop               ; Branch to calculations loop
                
Config_Display	jsr     Config_Hex_Displays     ; Configures the display

                ldx     #Student_Array          ; Loads reg. X with start of Student_Array
                ldaa    #I_ZERO			; Sets initial iteration value to zero
Output_Loop     cmpa    #I_MAX                  ; Max number of iterations
                beq     Done                    ; Branch to end of program if equal
                psha                            ; Sends value in acc. A to stack
                ldaa    0,x                     ; load zeroith index of reg. X
                ldab    1,x                     ; load first index of reg. X
                pshx                            ; Sends value in reg. X to stack
                cmpa    #PASS_VAL               ; compares student pratical to PASS_VAL
                bne     Failed                  ; Branch if not a pass
                cba                             ; Compare student practical to theory
                bne     Failed                  ; Branch if both are not a pass
                bra     Passed                  ; Branch to Passed if both are pass marks
                
Passed          ldaa    #PASS_VAL               ; Load acc. A with value to use in display
                bra     Display                 ; Branch to Display

Failed          ldaa    #FAIL_VAL               ; Load acc. A with value to use in display
                bra     Display                 ; Branch to Display

Continue        pulx                            ; Retrieve reg. X value from stack
                pula                            ; Retrieve acc. A value from stack
                inx                             ; Increment reg. X
                inx                             ; Increment reg. X a second time
                inca                            ; Increment acc. A
                bra     Output_Loop             ; Branch to Output_Loop

Blank           ldaa    #BLANK_VAL              ; Load acc. A with value to use in display
                ldab    #DIGIT3_PP0             ; Load acc. B with HEX display value
                jsr     PF_HEX_Display          ; shows display value
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                bra     Continue                ; Branch to Continue
                
Display         ldab    #DIGIT3_PP0             ; load acc. B with HEX display value
                jsr     PF_HEX_Display          ; shows display value
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                ldaa    #DELAY_VALUE            ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms                ; delays Dragon12+ board
                bra     Blank                   ; Branch to Blank display
                
Done            bra     Done			; infinite loop keeps last value on 7-seg display

; ***** DO NOT CHANGE ANY CODE BELOW HERE *****;
#include Calculate_Average.asm
#include Pass_Fail.asm
#include C:\68HCS12\Lib\Config_Hex_Displays.asm
#include C:\68HCS12\Lib\PF_HEX_Display.asm
#include C:\68HCS12\Lib\Delay_ms.asm
                end
