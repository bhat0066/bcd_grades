; Counter_00_99_BCD_HEX_Display.asm

#include C:\68hcs12\registers.inc

; Author:
; Course:
; S/N:
; Date:
;
; Purpose
;
; Program Constants
STACK   equ     $2000

; Port P (PPT) Display Selection Values
DIGIT3_PP0      equ        %00001110        ; MSB of the displayed BCD digits (left-most dislay)
DIGIT2_PP1      equ        %00001101       ; LSB of the displayed BCD digits (2nd display from left)

; Delay Subroutine Values
DELAY_VALUE     equ        250  ; Delay value (base 10) 0 - 255 ms
                                ; 125 = 1/8 second, 250 = 1/4 second
        org     $2000           ; program code
Start   lds     #STACK          ; stack location

; Configure the Ports
        jsr     Config_HEX_Displays

; Continually Count $00 - $99...$00 - $99 BCD, displaying the values on the Hex Displays
A       clra
LOOP    psha
        jsr     Extract_MSB
        ldab    #DIGIT3_PP0
        jsr     Hex_Display
        ldaa    #DELAY_VALUE
        jsr     Delay_ms
        pula
        psha
        jsr     Extract_LSB
        ldab    #DIGIT2_PP1
        jsr     Hex_Display
        ldaa    #DELAY_VALUE
        jsr     Delay_ms
        pula
        adda    #$01
        daa
        cmpa    #$99
        bra     LOOP
        bls     A
        
; Subroutines used by program (DO NOT CHANGE ANY OF THE FOLLOWING LINES OF CODE)
#include C:\68HCS12\Lib\Config_HEX_Displays.asm
#include C:\68HCS12\Lib\Delay_ms.asm
#include Extract_MSB.asm
#include Extract_LSB.asm
#include Hex_Display.asm

        end