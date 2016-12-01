; Counter_00_99_BCD_HEX_Display.asm

#include C:\68hcs12\registers.inc

; Purpose: This program is a BCD counter that counts from 00 to 99 continuously

; Program Constants
STACK           equ     $2000
MAX_VALUE       equ     $99		; maximum value for the counter
ADD_ONE         equ     $01             ; increment count by 1

; Port P (PPT) Display Selection Values
DIGIT3_PP0      equ	%00001110	; MSB of the displayed BCD digits
					; (left-most dislay)
DIGIT2_PP1      equ	%00001101	; LSB of the displayed BCD digits
					; (2nd display from left)

; Delay Subroutine Values
DELAY_VALUE     equ     250		; Delay value (base 10) 0 - 255 ms
                                        ; 125 = 1/8 second, 250 = 1/4 second
                org     $2000           ; program code
Start           lds     #STACK          ; STACK location

; Configure the Ports
                jsr     Config_HEX_Displays

; Continually Count $00 - $99...$00 - $99 BCD,
; displaying the values on the Hex Displays
Clear_A         clra                    ; clear acc. A to reset counter
Loop            psha                    ; push value in acc. A to stack
                jsr     Extract_MSB     ; find MSB
                ldab    #DIGIT3_PP0     ; load acc. B with HEX display value
                jsr     Hex_Display     ; shows display value
                ldaa    #DELAY_VALUE    ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms        ; delays Dragon12+ board
                pula                    ; pull value from stack to acc. A
                psha                    ; push value in acc. A to stack
                jsr     Extract_LSB     ; find LSB
                ldab    #DIGIT2_PP1     ; load acc. B with HEX display value
                jsr     Hex_Display     ; shows display value
                ldaa    #DELAY_VALUE    ; load acc. A with DISPLAY_VALUE
                jsr     Delay_ms        ; delays Dragon12+ board
                pula                    ; pull value from stack to acc. A
                adda    #ADD_ONE        ; adds to count
                daa                     ; adjust sum for BCD
                cmpa    #MAX_VALUE      ; checks if count equal to MAX_VALUE
                bra     Loop            ; branch always to top if not equal
                bls     Clear_A         ; branch if count lower or same
        
; Subroutines used by program (DO NOT CHANGE ANY OF THE FOLLOWING LINES OF CODE)
#include C:\68HCS12\Lib\Config_HEX_Displays.asm
#include C:\68HCS12\Lib\Delay_ms.asm
#include Extract_MSB.asm
#include Extract_LSB.asm
#include Hex_Display.asm

                end

