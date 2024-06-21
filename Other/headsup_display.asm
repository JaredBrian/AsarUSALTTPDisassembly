
    namespace "HUD"

; ==============================================================================

; $06DB40-$06DB74 DATA
{
    .bcd_for_display_bombs_maybe_arrows
    db $10, $15, $20, $25, $30, $35, $40, $50
    
    db $0A, $0F, $14, $19, $1E, $23, $28, $32
}


; ==============================================================================
    
; $06DB75-$06DB7E LONG JUMP LOCATION
RefillLogicLong:
{
    PHB : PHK : PLB

    LDA.w $0200

    BEQ RefillLogic

    PLB

    RTL
}
    
; =============================================

; $06DB7F-$06DB91 LONG JUMP LOCATION
RefreshIconLong:
{
    ; Similar to RebuildLong but it checks to see if
    ; our equipped item has changed state first.
    
    PHB : PHK : PLB

    JSR SearchForEquippedItem
    JSR Equipment_UpdateHUD
    JSR Rebuild

    SEP #$30

    STZ.w $0200

    PLB

    RTL
}

; =============================================

; $06DB92-$06DD29 BRANCH LOCATION
    RefillLogic:    
{
    ; check the refill magic indicator
    LDA.l $7EF373

    BEQ .doneWithMagicRefill

    ; Check the current magic power level we have.
    ; Is it full?
    LDA.l $7EF36E : CMP.b #$80

    BCC .magicNotFull
    
    ; If it is full, freeze it at 128 magic pts.
    ; And stop this refilling nonsense.
    LDA.b #$80 : STA.l $7EF36E
    LDA.b #$00 : STA.l $7EF373
    
    BRA .doneWithMagicRefill
    
    .magicNotFull
    
    LDA.l $7EF373 : DEC A : STA.l $7EF373
    LDA.l $7EF36E : INC A : STA.l $7EF36E
    
    ; if((frame_counter % 4) != 0) don't refill this frame
    LDA.b $1A : AND.b #$03 : BNE .doneWithMagicRefill
    
    ; Is this sound channel in use?
    LDA.w $012E : BNE .doneWithMagicRefill
    
    ; Play the magic refill sound effect
    LDA.b #$2D : STA.w $012E
    
    .doneWithMagicRefill
    
    REP #$30
    
    ; Check current rupees (362) against goal rupees (360)
    ; goal refers to how many we really have and current refers to the
    ; number currently being displayed. When you buy something,
    ; goal rupees are decreased by, say, 100, but it takes a while for the 
    ; current rupees indicator to catch up. When you get a gift of 300
    ; rupees, the goal increases, and current has to catch up in the other direction.
    LDA.l $7EF362
    
    CMP.l $7EF360 : BEQ .doneWithRupeesRefill
                  BMI .addRupees
    DEC A       : BPL .subtractRupees
    
    LDA.w #$0000 : STA.l $7EF360
    
    BRA .subtractRupees
    
    .addRupees
    
    ; If current rupees <= 1000 (decimal)
    INC A : CMP.w #1000 : BCC .subtractRupees
    
    ; Otherwise just store 999 to the rupee amount
    LDA.w #999 : STA.l $7EF360
    
    .subtractRupees
    
    STA.l $7EF362
    
    SEP #$30
    
    LDA.w $012E : BNE .doneWithRupeesRefill
    
    ; looks like a delay counter of some sort between
    ; invocations of the rupee fill sound effect
    LDA.w $0CFD : INC.w $0CFD : AND.b #$07 : BNE .skipRupeeSound
    
    LDA.b #$29 : STA.w $012E
    
    BRA .skipRupeeSound
    
    .doneWithRupeesRefill
    
    SEP #$30
    
    STZ.w $0CFD
    
    .skipRupeeSound
    
    LDA.l $7EF375

    BEQ .doneRefillingBombs

    ; decrease the bomb refill counter
    LDA.l $7EF375 : DEC A : STA.l $7EF375

    ; use the bomb upgrade index to know what max number of bombs Link can carry is
    LDA.l $7EF370 : TAY

    ; if it matches the max, you can't have no more bombs, son. It's the law.
    LDA.l $7EF343 : CMP.w $DB48, Y : BEQ .doneRefillingBombs
    
    ; You like bombs? I got lotsa bombs!
    INC A : STA.l $7EF343

    .doneRefillingBombs

    ; check arrow refill counter
    LDA.l $7EF376
    
    BEQ .doneRefillingArrows
    
    LDA.l $7EF376 : DEC A : STA.l $7EF376
    
    ; check arrow upgrade index to see how our max limit on arrows, just like bombs.
    LDA.l $7EF371 : TAY 
    
    LDA.l $7EF377 : CMP.w $DB58, Y
    
    ; I reckon you get no more arrows, pardner.
    BEQ .arrowsAtMax
    
    INC A : STA.l $7EF377

    .arrowsAtMax

    ; see if we even have the bow.
    LDA.l $7EF340
    
    BEQ .doneRefillingArrows
    
    AND.b #$01 : CMP.b #$01
    
    BNE .doneRefillingArrows
    
    ; changes the icon from a bow without arrows to a bow with arrows.
    LDA.l $7EF340 : INC A : STA.l $7EF340
    
    JSL RefreshIconLong

    .doneRefillingArrows

    ; a frozen Link is an impervious Link, so don't beep.
    LDA.w $02E4
    
    BNE .doneWithWarningBeep
    
    ; if heart refill is in process, we don't beep
    LDA.l $7EF372
    
    BNE .doneWithWarningBeep
    
    LDA.l $7EF36C : LSR #3 : TAX
    
    ; checking current health against capacity health to see
    ; if we need to put on that annoying beeping noise.
    LDA.l $7EF36D : CMP.w $DB60, X
    
    BCS .doneWithWarningBeep
    
    LDA.w $04CA
    
    BNE .decrementBeepTimer
    
    ; beep incessantly when life is low
    LDA.w $012E
    
    BNE .doneWithWarningBeep
    
    LDA.b #$20 : STA.w $04CA
    LDA.b #$2B : STA.w $012E
    
    .decrementBeepTimer
    
    ; Timer for the low life beep sound
    DEC.w $04CA

    .doneWithWarningBeep

    ; if nonzero, indicates that a heart is being "flipped" over
    ; as in, filling up, currently
    LDA.w $020A
    
    BNE .waitForHeartFillAnimation
    
    ; If no hearts need to be filled, branch
    LDA.l $7EF372
    
    BEQ .doneRefillingHearts
    
    ; check if actual health matches capacity health
    LDA.l $7EF36D : CMP.l $7EF36C
    
    BCC .notAtFullHealth
    
    ; just set health to full in the event it overflowed past 0xA0 (20 hearts)
    LDA.l $7EF36C : STA.l $7EF36D
    
    ; done refilling health so deactivate the health refill variable
    LDA.b #$00 : STA.l $7EF372
    
    BRA .doneRefillingHearts

    .notAtFullHealth

    ; refill health by one heart
    LDA.l $7EF36D : CLC : ADC.b #$08 : STA.l $7EF36D
    
    LDA.w $012F
    
    BNE .soundChannelInUse
    
    ; play heart refill sound effect
    LDA.b #$0D : STA.w $012F

    .soundChannelInUse

    ; repeat the same logic from earlier, checking if health's at max and setting it to max
    ; if it overflowed
    LDA.l $7EF36D : CMP.l $7EF36C
    
    BCC .healthDidntOverflow
    
    LDA.l $7EF36C : STA.l $7EF36D

    .healthDidntOverflow

    ; subtract a heart from the refill variable
    LDA.l $7EF372 : SEC : SBC.b #$08 : STA.l $7EF372
    
    ; activate heart refill animation
    ; (which will cause a small delay for the next heart if we still need to fill some up.)
    INC.w $020A
    
    LDA.b #$07 : STA.w $0208

    .waitForHeartFillAnimation
    
    REP #$30
    
    LDA.w #$FFFF : STA.b $0E
    
    JSR Update_ignoreHealth
    JSR AnimateHeartRefill
    
    SEP #$30
    
    INC.b $16
    
    PLB
    
    RTL

    .doneRefillingHearts

    REP #$30
    
    LDA.w #$FFFF : STA.b $0E
    
    JSR Update_ignoreItemBox
    
    SEP #$30
    
    INC.b $16
    
    PLB
    
    RTL
} 

; =============================================
    
    namespace off
    
; =============================================
    
incsrc "equipment.asm"
    
; =============================================

    namespace "HUD"

; =============================================

; $06F0F7-$06F127 LOCAL JUMP LOCATION
HexToDecimal:
{
    ; This apparently is a hex to decimal converter for use with displaying numbers
    ; It's obviously slower with larger numbers... should find a way to speed it up. (already done)
    
    REP #$30
    
    STZ.w $0003
    
    ; The objects mentioned could be rupees, arrows, bombs, or keys.
    LDX.w #$0000
    LDY.w #$0002
    
    .nextDigit
    
    ; If number of objects left < 100, 10
    CMP.w $F9F9, Y : BCC .nextLowest10sPlace
    
    ; Otherwise take off another 100 objects from the total and increment $03
    ; $6F9F9, Y THAT IS, 100, 10
    SEC : SBC.w $F9F9, Y
    INC.b $03, X
    
    BRA .nextDigit
    
    .nextLowest10sPlace
    
    INX : DEY #2
    
    ; Move on to next digit (to the right)
    BPL .nextDigit
    
    ; Whatever is left is obviously less than 10, so store the digit at $05.
    STA.b $05
    
    SEP #$30
    
    ; Go through at most three digits.
    LDX.b #$02
    
    ; Repeat for all three digits.
    .setNextDigitTile
    
    ; Load each digit's computed value
    LDA.b $03, X : CMP.b #$7F
    
    BEQ .blankDigit
    
    ; #$0-9 -> #$90-#$99
    ORA.b #$90
    
    .blankDigit
    
    ; A blank digit.
    STA.b $03, X
    
    DEX : BPL .setNextDigitTile
    
    RTS
}

; =============================================

; $06F128-$06F14E LONG JUMP LOCATION
RefillHealth:
{
    ; Check goal health versus actual health.
    ; if(actual < goal) then branch.
    LDA.l $7EF36D : CMP.l $7EF36C : BCC .refillAllHealth
    
    LDA.l $7EF36C : STA.l $7EF36D
    
    LDA.b #$00 : STA.l $7EF372
    
    ; ??? not sure what purpose this branch serves.
    LDA.w $020A : BNE .beta
    
    SEC
    
    RTL
    
    .refillAllHealth
    
    ; Fill up ze health.
    LDA.b #$A0 : STA.l $7EF372
    
    .beta
    
    CLC
    
    RTL
}

; =============================================

; $06F14F-$06F1B2 LOCAL JUMP LOCATION
AnimateHeartRefill:
{
    SEP #$30
    
    ; $00[3] = $7EC768 (wram address of first row of hearts in tilemap buffer)
    LDA.b #$68 : STA.b $00
    LDA.b #$C7 : STA.b $01
    LDA.b #$7E : STA.b $02
    
    DEC.w $0208 : BNE .return
    
    REP #$30
    
    ; Y = ( ( ( (current_health & 0x00F8) - 1) / 8 ) * 2)
    LDA.l $7EF36D : AND.w #$00F8 : DEC A : LSR #3 : ASL A : TAY : CMP.w #$0014
    
    BCC .halfHealthOrLess
    
    SBC.w #$0014 : TAY
    
    ; $00[3] = $7EC7A8 (wram address of second row of hearts)
    LDA.b $00 : CLC : ADC.w #$0040 : STA.b $00

    .halfHealthOrless

    SEP #$30
    
    LDX.w $0209 : LDA.l $0DFA11, X : STA.w $0208
    
    TXA : ASL A : TAX
    
    LDA.l $0DFA09, X : STA [$00], Y
    
    INY : LDA.l $0DFA0A, X : STA [$00], Y
    
    LDA.w $0209 : INC A : AND.b #$03 : STA.w $0209
    
    BNE .return
    
    SEP #$30
    
    JSR Rebuild
    
    STZ.w $020A

    .return

    CLC
    
    RTS
} 

; =============================================

; $06F1B3-$06F1C8 LONG JUMP LOCATION
RefillMagicPower:
{
    SEP #$30
    
    ; Check if Link's magic meter is full
    LDA.l $7EF36E : CMP.b #$80
    
    BCS .itsFull
    
    ; Tell the magic meter to fill up until it's full.
    LDA.b #$80 : STA.l $7EF373
    
    SEP #$30
    
    RTL
    
    .itsFull
    
    ; Set the carry, signifying we're done filling it.
    SEP #$31
    
    RTL
}

; ==============================================================================

    namespace off

; ==============================================================================

; $06F1C9 DATA
{
    ; ??? how long? ; The values for the HUD y box item are here, but there may be more stuff as well idk.

    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $256B, $256C, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2570, $2571, $2572, $2573, $2574, $2575, $2576, $2577
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2557, $255E, $255E, $255A, $2562, $2557, $255E, $2563
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2551, $255E, $255C, $2551, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2555, $2558, $2561, $2554, $2561, $255E, $2553, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2558, $2552, $2554, $2561, $255E, $2553, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2551, $255E, $255C, $2551, $255E, $2562, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2554, $2563, $2557, $2554, $2561, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2560, $2564, $2550, $255A, $2554, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $255B, $2550, $255C, $255F, $24F5, $24F5, $24F5, $24F5
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $2557, $2550, $255C, $255C, $2554, $2561
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2562, $2557, $255E, $2565, $2554, $255B, $24F5, $24F5
    dw $2400, $2401, $2402, $2403, $2404, $2405, $2406, $2407
    dw $2408, $2409, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2551, $255E, $255E, $255A, $24F5, $255E, $2555, $24F5
    dw $255C, $2564, $2553, $255E, $2561, $2550, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5
    dw $24F5, $2562, $255E, $255C, $2550, $2561, $2558, $2550
    dw $2552, $2550, $255D, $2554, $24F5, $255E, $2555, $24F5
    dw $24F5, $24F5, $24F5, $2551, $2568, $2561, $255D, $2550
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $2552, $2550, $255F, $2554, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $255C, $2564, $2562, $2557, $2561, $255E, $255E, $255C
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2551, $255E, $2563, $2563, $255B, $2554, $24F5, $24F5
    dw $255B, $2558, $2555, $2554, $24F5, $24F5, $24F5, $24F5
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554
    dw $2552, $2564, $2561, $2554, $256A, $2550, $255B, $255B
    dw $255C, $2554, $2553, $2558, $2552, $2558, $255D, $2554
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2555, $2550, $2554, $2561, $2558, $2554, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2551, $2554, $2554, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2556, $255E, $255E, $2553, $24F5, $2551, $2554, $2554
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5
    dw $24F5, $255F, $255E, $2566, $2553, $2554, $2561, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2555, $255B, $2564, $2563, $2554, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $2555, $255B, $2564, $2563, $2554, $24F5, $24F5, $24F5
    dw $255C, $2550, $2556, $2558, $2552, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $255C, $2558, $2561, $2561, $255E, $2561
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $256B, $256C, $256E, $256F, $257C, $257D, $257E, $257F
    dw $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $256B, $256C, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5
    dw $256B, $256C, $24F5, $256E, $256F, $24F5, $24F5, $24F5
    dw $2578, $2579, $257A, $257B, $257C, $257D, $257E, $257F
    dw $20F5, $20F5, $20F5, $20F5, $28BA, $28E9, $28E8, $28CB
    dw $28BA, $284A, $2849, $28CB, $28BA, $28E9, $28E8, $28CB
    dw $28BA, $28BB, $24CA, $28CB, $20F5, $20F5, $20F5, $20F5
    dw $2CB8, $2CB9, $2CF5, $2CC9, $24B8, $24B9, $24F5, $24C9
    dw $20F5, $20F5, $20F5, $20F5, $24F5, $24F6, $24C0, $24F5
    dw $20F5, $20F5, $20F5, $20F5, $2CB2, $2CB3, $2CC2, $6CC2
    dw $20F5, $20F5, $20F5, $20F5, $2444, $2445, $2446, $2447
    dw $203B, $203C, $203D, $203E, $20F5, $20F5, $20F5, $20F5
    dw $24B0, $24B1, $24C0, $24C1, $20F5, $20F5, $20F5, $20F5
    dw $2CB0, $2CBE, $2CC0, $2CC1, $20F5, $20F5, $20F5, $20F5
    dw $287D, $287E, $E87E, $E87D, $20F5, $20F5, $20F5, $20F5
    dw $2876, $2877, $E877, $E876, $20F5, $20F5, $20F5, $20F5
    dw $2866, $2867, $E867, $E866, $20F5, $20F5, $20F5, $20F5
    dw $24BC, $24BD, $24CC, $24CD, $20F5, $20F5, $20F5, $20F5
    dw $20B6, $20B7, $20C6, $20C7, $20F5, $20F5, $20F5, $20F5
    dw $20D0, $20D1, $20E0, $20E1, $2CD4, $2CD5, $2CE4, $2CE5
    dw $2CD4, $2CD5, $2CE4, $2CE5, $20F5, $20F5, $20F5, $20F5
    dw $3C40, $3C41, $2842, $3C43, $20F5, $20F5, $20F5, $20F5
    dw $3CA5, $3CA6, $3CD8, $3CD9, $20F5, $20F5, $20F5, $20F5
    dw $2044, $2045, $2046, $2047, $2837, $2838, $2CC3, $2CD3
    dw $24D2, $64D2, $24E2, $24E3, $3CD2, $7CD2, $3CE2, $3CE3
    dw $2CD2, $6CD2, $2CE2, $2CE3, $2855, $6855, $2C57, $2C5A
    dw $2837, $2838, $2839, $283A, $2837, $2838, $2839, $283A
    dw $20F5, $20F5, $20F5, $20F5, $24DC, $24DD, $24EC, $24ED
    dw $20F5, $20F5, $20F5, $20F5, $2CDC, $2CDD, $2CEC, $2CED
    dw $20F5, $20F5, $20F5, $20F5, $24B4, $24B5, $24C4, $24C5
    dw $20F5, $20F5, $20F5, $20F5, $28DE, $28DF, $28EE, $28EF
    dw $2C62, $2C63, $2C72, $2C73, $2886, $2887, $2888, $2889
    dw $20F5, $20F5, $20F5, $20F5, $2130, $2131, $2140, $2141
    dw $28DA, $28DB, $28EA, $28EB, $20F5, $20F5, $20F5, $20F5
    dw $3429, $342A, $342B, $342C, $20F5, $20F5, $20F5, $20F5
    dw $2C9A, $2C9B, $2C9D, $2C9E, $20F5, $20F5, $20F5, $20F5
    dw $2433, $2434, $2435, $2436, $20F5, $20F5, $20F5, $20F5
    dw $20F5, $20F5, $20F5, $20F5, $2C64, $2CCE, $2C75, $3D25
    dw $2C8A, $2C65, $2474, $3D26, $248A, $2465, $3C74, $2D48
    dw $288A, $2865, $2C74, $2D39, $24F5, $24F5, $24F5, $24F5
    dw $2CFD, $6CFD, $2CFE, $6CFE, $34FF, $74FF, $349F, $749F
    dw $2880, $2881, $288D, $288E, $3C68, $7C68, $3C78, $7C78
    dw $2C68, $6C68, $2C78, $6C78, $2468, $6468, $2478, $6478
    dw $20F5, $20F5, $20F5, $20F5, $24BF, $64BF, $2CCF, $6CCF
    dw $20F5, $20F5, $20F5, $20F5, $28D6, $68D6, $28E6, $28E7
    dw $354B, $354C, $354D, $354E, $20F5, $20F5, $20F5, $20F5
    dw $28DE, $28DF, $28EE, $28EF, $313B, $313C, $313D, $313E
    dw $252B, $252C, $252D, $252E, $313B, $313C, $313D, $313E
    dw $2D2B, $2D2C, $2D2D, $2D2E, $313B, $313C, $313D, $313E
    dw $3D2B, $3D2C, $3D2D, $3D2E, $20F5, $20F5, $20F5, $20F5
    dw $3D30, $3D31, $3D40, $3D41, $2484, $6484, $2485, $6485
    dw $24AD, $6484, $2485, $6485, $24AD, $6484, $24AE, $6485
    dw $24AD, $64AD, $24AE, $6485, $2CF5, $2CF5, $2CF5, $2CF5
    dw $2CF5, $2D5B, $2D58, $2D55, $2D63, $2D28, $2CF5, $2CF5
    dw $2CF5, $2CF5, $2CF5, $2D5B, $2D58, $2D55, $2D63, $2D29
    dw $2CF5, $2CF5, $2CF5, $2CF5, $2CF5, $2D5B, $2D58, $2D55
    dw $2D63, $2D27, $2CF5, $2CF5, $2CF5, $2CF5, $2CF5, $2CF5
    dw $2D61, $2D54, $2D50, $2D53, $2CF5, $2CF5, $2CF5, $2CF5
    dw $2CF5, $2CF5, $2D63, $2D50, $2D5B, $2D5A, $207F, $207F
    dw $207F, $207F, $207F, $207F, $207F, $207F, $207F, $207F
    dw $2CF5, $2CF5, $2C2E, $2CF5, $2CF5, $2D5F, $2D64, $2D5B
    dw $2D5B, $2CF5, $2CF5, $2CF5, $2CF5, $2CF5, $2CF5, $2CF5
    dw $2D61, $2D64, $2D5D, $2CF5, $2CF5, $2CF5, $2CF5, $2CF5
    dw $2CF5, $2CF5, $2D62, $2D66, $2D58, $2D5C, $2CF5, $2CF5
    dw $2CF5, $207F, $207F, $2C01, $2C18, $2C28, $207F, $207F
    dw $000A, $0064, $24A2, $24A2, $24A2, $24A2, $24A1, $24A0
    dw $24A3, $24A4, $24A3, $24A0, $0101, $0101
}

; ===================================================================

    ; $6FA15
{
    db $00
    
    db $03, $02, $0E, $01, $0A
    db $05, $06, $0F, $10, $11
    db $09, $04, $08, $07, $0C
    db $0B, $12, $0D, $13, $14
    
    ; not sure what these are used for, if anything... 
                    ; Used to determine what item to have link use, based on the position of the selected item in the Item Menu see $0303
    ; $6FA2A
    
    db $00, $01, $06, $02, $07
    db $03, $05, $04, $08
}


; ==============================================================================

; $06FA33-$06FA57 LONG JUMP LOCATION
RestoreTorchBackground:
{
    ; See if we have the torch...
    LDA.l $7EF34A : BEQ .doNothing
    
    ; See if this room has the 'lights out' property.
    LDA.l $7EC005 : BEQ .doNothing
    
    ; The rest of these variables, I'm not too sure about. Probably indicate
    ; that a torch bg object was place in the dungeon room.
    LDA.w $0458 : BNE .doNothing
    
    LDA.w $045A : BNE .doNothing
    
    INC.w $0458
    
    LDA.w $0414 : CMP.b #$02 : BEQ .doNothing
    
    LDA.b #$01 : STA.b $1D
    
    .doNothing
    
    RTL
}
    
; ==============================================================================

    namespace "HUD"

; ==============================================================================

; $06FA58-$06FA5F LONG JUMP LOCATION
RebuildLong:
{
    PHB : PHK : PLB

    JSR Rebuild

    PLB

    RTL
}

; ==============================================================================

; $06FA60-$06FA6F LONG JUMP LOCATION
RebuildIndoor:
{
    LDA.b #$00 : STA.l $7EC017
    
    LDA.b #$FF
    
    ; $06FA68 ALTERNATE ENTRY POINT
    .palace
    
    ; When the dungeon loads, tells us how many keys we have.
    STA.l $7EF36F
    
    shared RebuildLong2:
    
    JSR Rebuild
    
    RTL
}

; ==============================================================================

; $06FA70-$06FA92 LOCAL JUMP LOCATION
Rebuild:
{
    ; When the screen finishes transitioning from the menu to the main game screen
    ; this is called to refresh the HUD by drawing a template (some tiles are dynamic though)
    REP #$30
    
    PHB
    
    ; Preparing for the MVN transfer
    LDA.w #$0149
    LDX.w #.hud_tilemap
    LDY.w #$C700
    
    MVN.b $0D, $7E ; $Transfer 0x014A bytes from $6FE77 -> $7EC700
    
    PLB ; The above sets up a template for the status bar.
    
    PHB : PHK : PLB
    
    BRA .alpha
    
    ; $06FA85 ALTERNATE ENTRY POINT
    .updateOnly
    
    REP #$30
    
    PHB : PHK : PLB
    
    .alpha
    
    JSR Update
    
    PLB
    
    SEP #$30
    
    INC.b $16 ; Indicate this needs drawing.
    
    RTS
}

; ==============================================================================

; $06FA93-$06FAFC DATA
{
    ; Item box draw?
    dw $F629, $F651, $F669, $F679, $F689, $F6A1, $F6B1, $F6C1
    dw $F6D1, $F6E1, $F6F1, $F701, $F711, $F731, $F741, $F751
    dw $F799, $F7A9, $F7B9, $F7C9, $F7E9, $F801, $F811, $F821
    dw $F831, $F839, $F861, $F881, $F751, $F751, $F751, $F751
    dw $F901
    
    ; $6FAD5
    dw $11C8, $11CE, $11D4, $11DA, $11E0, $1288, $128E, $1294
    dw $129A, $12A0, $1348, $134E, $1354, $135A, $1360, $1408
    dw $140E, $1414, $141A, $1420    
}

; ==============================================================================

; $06FAFD-$06FB90 LOCAL JUMP LOCATION
UpdateItemBox:
{
    SEP #$30
    
    ; Dost thou haveth the the bow?
    LDA.l $7EF340 : BEQ .havethNoBow
    
    ; Dost thou haveth the silver arrows?
    ; (okay I'll stop soon)
    CMP.b #$03 : BCC .havethNoSilverArrows 
    
    ; Draw the arrow guage icon as silver rather than normal wood arrows.
    LDA.b #$86 : STA.l $7EC71E
    LDA.b #$24 : STA.l $7EC71F
    LDA.b #$87 : STA.l $7EC720
    LDA.b #$24 : STA.l $7EC721
    
    LDX.b #$04
    
    ; check how many arrows the player has
    LDA.l $7EF377 : BNE .drawBowItemIcon
    
    LDX.b #$03
    
    BRA .drawBowItemIcon
    
    .havethNoSilverArrows
    
    LDX.b #$02
    
    LDA.l $7EF377 : BNE .drawBowItemIcon
    
    LDX.b #$01
    
    .drawBowItemIcon
    
    ; values of X correspond to how the icon will end up drawn:
    ; 0x01 - normal bow with no arrows
    ; 0x02 - normal bow with arrows
    ; 0x03 - silver bow with no silver arrows
    ; 0x04 - silver bow with silver arrows
    TXA : STA.l $7EF340
    
    .havethNoBow
    
    REP #$30
    
    LDX.w $0202 : BEQ .noEquippedItem
    
    LDA.l $7EF33F, X : AND.w #$00FF
    
    CPX.w #$0004 : BNE .bombsNotEquipped
    
    LDA.w #$0001
    
    .bombsNotEquipped
    
    CPX.w #$0010 : BNE .bottleNotEquipped
    
    TXY : TAX : LDA.l $7EF35B, X : AND.w #$00FF : TYX
    
    .bottleNotEquipped
    
    STA.b $02
                ; insert jump here check for 0x15 in X then branch off, interject gfx, and return to .noEquippedItem,
                ; otherwise insert the next line again and return to LDA.w $FA93
    TXA : DEC A : ASL A : TAX ; (x-1)*2
    
    LDA.w $FA93, X : STA.b $04 ; for fire rod (05), loads F6A1
    
    LDA.b $02 : ASL #3 : TAY ; loads 08
    
    ; These addresses form the item box graphics. ; fire rod loads: 24B0, 24B1, 24C0, 24C1 ; ice rod loads: 2CB0, 2CBE, 2CC0, 2CC1 
    LDA ($04), Y : STA.l $7EC74A : INY #2
    LDA ($04), Y : STA.l $7EC74C : INY #2
    LDA ($04), Y : STA.l $7EC78A : INY #2
    LDA ($04), Y : STA.l $7EC78C : INY #2
    
    .noEquippedItem
    
    RTS
}

; =============================================

; $06FB91-$06FCF9 LOCAL JUMP LOCATION
Update:
{
    JSR UpdateItemBox
    
    ; $06FB94 ALTERNATE ENTRY POINT
    .ignoreItemBox
    
    SEP #$30
    
    ; the hook for optimization was placed here...
    ; need to draw partial heart still though. update: optimization complete with great results
    LDA.b #$FD : STA.b $0A
    LDA.b #$F9 : STA.b $0B
    LDA.b #$0D : STA.b $0C
    
    LDA.b #$68 : STA.b $07
    LDA.b #$C7 : STA.b $08
    LDA.b #$7E : STA.b $09
    
    REP #$30
    
    ; Load Capacity health.
    LDA.l $7EF36C : AND.w #$00FF : STA.b $00 : STA.b $02 : STA.b $04
    
    ; First, just draw all the empty hearts (capacity health)
    JSR UpdateHearts
    
    SEP #$30
    
    LDA.b #$03 : STA.b $0A
    LDA.b #$FA : STA.b $0B
    LDA.b #$0D : STA.b $0C
    
    LDA.b #$68 : STA.b $07
    LDA.b #$C7 : STA.b $08
    LDA.b #$7E : STA.b $09
    
    ; Branch if at full health
    LDA.l $7EF36C : CMP.l $7EF36D : BEQ .healthUpdated
    
    ; Seems absurd to have a branch of zero bytes, right?
    SEC : SBC.b #$04 : CMP.l $7EF36D : BCS .healthUpdated
    
    .healthUpdated
    
    ; A = actual health + 0x03;
    LDA.l $7EF36D : CLC : ADC.b #$03
    
    REP #$30
    
    AND.w #$00FC : STA.b $00 : STA.b $04
    
    LDA.l $7EF36C : AND.w #$00FF : STA.b $02
    
    ; this time we're filling in the full and partially filled hearts (actual health)
    JSR UpdateHearts
    
    ; $06FC09 ALTERNATE ENTRY POINT ; reentry hook
    .ignoreHealth
    
    REP #$30
    
    ; Magic amount indicator (normal, 1/2, or 1/4)
    LDA.l $7EF37B : AND.w #$00FF : CMP.w #$0001 : BCC .normalMagicMeter
    
    ; draws a 1/2 magic meter (note, we could add in the 1/4 magic meter here if 
    ; we really cared about that >_>
    LDA.w #$28F7 : STA.l $7EC704
    LDA.w #$2851 : STA.l $7EC706
    LDA.w #$28FA : STA.l $7EC708
    
    .normalMagicMeter
    
    ; check how much magic power the player has at the moment (ranges from 0 to 0x7F)
    ; X = ((MP & 0xFF)) + 7) & 0xFFF8)
    LDA.l $7EF36E : AND.w #$00FF : CLC : ADC.w #$0007 : AND.w #$FFF8 : TAX
    
    ; these four writes draw the magic power bar based on how much MP you have    
    LDA .mp_tilemap+0, X : STA.l $7EC746
    LDA .mp_tilemap+2, X : STA.l $7EC786
    LDA .mp_tilemap+4, X : STA.l $7EC7C6
    LDA .mp_tilemap+6, X : STA.l $7EC806
    
    ; Load how many rupees the player has
    LDA.l $7EF362
    
    JSR HexToDecimal
    
    REP #$30
    
    ; The tile index for the first rupee digit
    LDA.b $03 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC750
    
    ; The tile index for the second rupee digit
    LDA.b $04 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC752
    
    ; The tile index for the third rupee digit
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC754
    
    ; Number of bombs Link has.
    LDA.l $7EF343 : AND.w #$00FF
    
    JSR HexToDecimal
    
    REP #$30
    
    ; The tile index for the first bomb digit
    LDA.b $04 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC758
    
    ; The tile index for the second bomb digit
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC75A
    
    ; Number of Arrows Link has.
    LDA.l $7EF377 : AND.w #$00FF
    
    ; converts hex to up to 3 decimal digits
    JSR HexToDecimal
    
    REP #$30
    
    ; The tile index for the first arrow digit    
    LDA.b $04 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC75E
    
    ; The tile index for the second arrow digit   
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC760
    
    LDA.w #$007F : STA.b $05
    
    ; Load number of Keys Link has
    LDA.l $7EF36F : AND.w #$00FF : CMP.w #$00FF : BEQ .noKeys
    
    JSR HexToDecimal
    
    .noKeys
    
    REP #$30
    
    ; The key digit, which is optionally drawn.
    ; Also check to see if the key spot is blank
    LDA.b $05 : AND.w #$00FF : ORA.w #$2400 : STA.l $7EC764
    
    CMP.w #$247F : BNE .dontBlankKeyIcon
    
    ; If the key digit is blank, also blank out the key icon.
    STA.l $7EC724
    
    .dontBlankKeyIcon
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06FDAB-$06FDEE LOCAL JUMP LOCATION
UpdateHearts:
{
    ; Draws hearts in a painfully slow loop
    ; I used DMA to speed it up in my custom code
    ; (but still needs fixing to work on 1/1/1 hardware)
    
    LDX.w #$0000
    
    .nextHeart
    
    LDA.b $00 : CMP.w #$0008 : BCC .lessThanOneHeart
    
    ; Notice no SEC was needed since carry is assumedly set.
    SBC.w #$0008 : STA.b $00
    
    LDY.w #$0004
    
    JSR .drawHeart
    
    INX #2
    
    BRA .nextHeart
    
    .lessThanOneHeart
    
    CMP.w #$0005 : BCC .halfHeartOrLess
    
    LDY.w #$0004
    
    BRA .drawHeart
    
    .halfHeartOrLess
    
    CMP.w #$0001 : BCC .emptyHeart
    
    LDY.w #$0002
    
    BRA .drawHeart
    
    .emptyHeart
    
    RTS
    
    .drawHeart
    
    ; Compare number of hearts so far on current line to 10
    CPX.w #$0014 : BCC .noLineChange
    
    ; if not, we have to move down one tile in the tilemap
    LDX.w #$0000
    
    LDA.b $07 : CLC : ADC.w #$0040 : STA.b $07
    
    .noLineChange
    
    LDA [$0A], Y : TXY : STA [$07], Y
    
    RTS
}

; ==============================================================================

; $06FDEF-$06FE76 DATA
Pool_Update:
{
    .mp_tilemap
    dw $3CF5, $3CF5, $3CF5, $3CF5
    dw $3CF5, $3CF5, $3CF5, $3C5F
    dw $3CF5, $3CF5, $3CF5, $3C4C
    dw $3CF5, $3CF5, $3CF5, $3C4D
    dw $3CF5, $3CF5, $3CF5, $3C4E
    dw $3CF5, $3CF5, $3C5F, $3C5E
    dw $3CF5, $3CF5, $3C4C, $3C5E
    dw $3CF5, $3CF5, $3C4D, $3C5E
    dw $3CF5, $3CF5, $3C4E, $3C5E
    dw $3CF5, $3C5F, $3C5E, $3C5E
    dw $3CF5, $3C4C, $3C5E, $3C5E
    dw $3CF5, $3C4D, $3C5E, $3C5E
    dw $3CF5, $3C4E, $3C5E, $3C5E
    dw $3C5F, $3C5E, $3C5E, $3C5E
    dw $3C4C, $3C5E, $3C5E, $3C5E
    dw $3C4D, $3C5E, $3C5E, $3C5E
    dw $3C4E, $3C5E, $3C5E, $3C5E    
}

; ==============================================================================

; $06FE77-$06FFC0
Pool_Rebuild:
{
    .hud_tilemap
    dw $207F, $207F, $2850, $A856
    dw $2852, $285B, $285B, $285C
    dw $207F, $3CA8, $207F, $207F
    dw $2C88, $2C89, $207F, $20A7
    dw $20A9, $207F, $2871, $207F
    dw $207F, $207F, $288B, $288F
    dw $24AB, $24AC, $688F, $688B
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $2871
    dw $2858, $207F, $207F, $285D
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $304E
    dw $2858, $207F, $207F, $285D
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $305E
    dw $2859, $A85B, $A85B, $A85C
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $2854, $305E
    dw $6854, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $207F, $207F
    dw $207F, $207F, $A850, $2856
    dw $E850
}

; ==============================================================================

; $06FFC1-$06FFFF NULL
{
    padbyte $FF
    
    pad $0E8000
    
}

; ==============================================================================

    namespace off
