; Pass_Fail_Calc.asm

#include c:\68hcs12\registers.inc

; Author(s) and Student Number(s):
; Date:
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
<<<<<<< HEAD
DELAY_VALUE     equ     255
DIGIT3_PP0      equ     %00000111        ; MSB of the displayed BCD digits (left-most dislay)
=======
DELAY_VALUE	equ     250
Len_Array       equ     End_Course_Data-Start_Course_Data
>>>>>>> origin/master

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

Student_Array        ds        12
End_Student_Array
Result                db        $00

; code section
                org     $2000           ; RAM address for Code
<<<<<<< HEAD

                lds     #$2000          ; Stack
                ldx     #Student_Array
                ldy     #Start_Course_Data
                
Loop            cpy    #End_Course_Data
                beq     EndLoop

                ldaa    0,y
                ldab    #$05
                pshx
                ldaa    #$00
                staa    Result
                jsr     Calculate_Average
                jsr     Pass_Fail
                pulx
                staa    1,x+

                ldab    #$03
                pshx
                ldaa    #$00
                staa    Result
                jsr     Calculate_Average
                jsr     Pass_Fail
                pulx
                staa    1,x+

                bra     Loop
EndLoop
                jsr     Config_Hex_Displays

                ldx     #Student_Array
                ldaa    #00
Loops           cmpa    #06
                beq     Done
                psha
                ldaa    0,x
                ldab    1,x
                ;ldaa    1,x+
                ;ldab    1,x+
                cmpa    #$01
                bne     F
                cba
                bne     F
                bra     P
                ;cba
                ;beq     P
                ;bne     F
                ;bra     Loops
                
P               pshx
                ldaa    #$01
                bra     Display

F               pshx
                ldaa    #$00
                bra     Display

Cont            pulx
                pula
                inx
                inx
                inca
                bra      Loops

Blank           ldaa    #$02
                ldab    #DIGIT3_PP0
                jsr     PF_HEX_Display
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                bra     Cont

                
Display         ldab    #DIGIT3_PP0
                jsr     PF_HEX_Display
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                ldaa    #DELAY_VALUE
                jsr     Delay_ms
                bra     Blank
                
Done            bra     Done                ; infinite loop keeps last value on 7-seg display
=======
                lds     #$2000          ; Stack
                ldy     #Start_Course_Data

Loop            cpy     #End_Course_Data
                beq     EndLoop
                ldaa    5,y+
                ldab    #$05
                jsr     Calculate_Average
                jsr     Pass_Fail
                ldaa    3,y+
                ldab    #$03
                jsr     Calculate_Average
                jsr     Pass_Fail
                bra     Loop
EndLoop
                jsr     Config_Hex_Displays
                
; start loop2
                jsr     PF_HEX_Display
                ;check for remaining students
                ;loop ends

Done		bra     Done                ; infinite loop keeps last value on 7-seg display
>>>>>>> origin/master

; ***** DO NOT CHANGE ANY CODE BELOW HERE *****;
#include Calculate_Average.asm
#include Pass_Fail.asm
#include C:\68HCS12\Lib\Config_Hex_Displays.asm
#include C:\68HCS12\Lib\PF_HEX_Display.asm
#include C:\68HCS12\Lib\Delay_ms.asm
<<<<<<< HEAD
                end
=======
                end
>>>>>>> origin/master
