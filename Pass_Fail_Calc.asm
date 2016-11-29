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
DELAY_VALUE     equ     250
Len_Array       equ     End_Course_Data-Start_Course_Data

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

; code section
        	org     $2000           ; RAM address for Code
       		lds     #$2000          ; Stack
                ldy     #Start_Course_Data
                
Loop            cmpa     #End_Course_Data
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
        
; start loop
        	jsr    PF_HEX_Display
; check for end cond



Done    	bra     Done                ; infinite loop keeps last value on 7-seg display

; ***** DO NOT CHANGE ANY CODE BELOW HERE *****;
#include Calculate_Average.asm
#include Pass_Fail.asm
#include C:\68HCS12\Lib\Config_Hex_Displays.asm
#include C:\68HCS12\Lib\PF_HEX_Display.asm
#include C:\68HCS12\Lib\Delay_ms.asm
        	end