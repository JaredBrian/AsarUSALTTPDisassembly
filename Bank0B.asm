; ==============================================================================

; Bank 0B
org $0B8000 ; $058000-$05FFFF

; ==============================================================================

; TODO: Fill in the missing data here.

; ==============================================================================

; $05FE70-$05FFA7 LONG JUMP LOCATION
; ZS replaces the latter half of this function.
Overworld_SetFixedColorAndScroll:
{
    ; Turn the subscreen off for the moment.
    STZ.b $1D
        
    REP #$30
        
    LDX.w #$19C6
        LDA.b $8A : CMP.w #$0080 : BNE .notMasterSwordArea
        
        LDA.b $A0 : CMP.w #$0181 : BNE .setBgColor
            INC.b $1D
        
            BRA .useDefaultGreen
    
        .notMasterSwordArea
    
        ; If area == 0x81 branch
        CMP.w #$0081 : BEQ .setBgColor
            LDX.w #$0000
            
            CMP.w #$005B                : BEQ .setBgColor
            AND.w #$00BF : CMP.w #$0003 : BEQ .setBgColor
            CMP.w #$0005                : BEQ .setBgColor
            CMP.w #$0007                : BEQ .setBgColor
    
        .useDefaultGreen
    
        LDX.w #$2669
        
        LDA.b $8A : AND.w #$0040 : BEQ .setBgColor
        
        ; Default tan color for the dark world.
        LDX.w #$2A32
    
    .setBgColor
    
    TXA
    STA.l $7EC500 : STA.l $7EC300 ; Old ZS function call written here.
    STA.l $7EC540 : STA.l $7EC340
    
    ; ZS starts replacing from here.
    ; $05FEC6 - ZS Custom Overworld
    ; Set fixed color to neutral.
    LDA.w #$4020 : STA.b $9C
    LDA.w #$8040 : STA.b $9D
        
    LDA.b $8A : BEQ .noCustomFixedColor
        CMP.w #$0070 : BNE .notSwampOfEvil
            JMP .subscreenOnAndReturn
        
        .notSwampOfEvil
        
        CMP.w #$0040 : BEQ .noCustomFixedColor
        CMP.w #$005B : BEQ .noCustomFixedColor
            LDX.w #$4C26
            LDY.w #$8C4C
            
            CMP.w #$0003 : BEQ .setCustomFixedColor
            CMP.w #$0005 : BEQ .setCustomFixedColor
            CMP.w #$0007 : BEQ .setCustomFixedColor
            
            LDX.w #$4A26
            LDY.w #$874A
            
            CMP.w #$0043 : BEQ .setCustomFixedColor
            CMP.w #$0045 : BEQ .setCustomFixedColor
            
            SEP #$30
            
            ; Update CGRAM this frame.
            INC.b $15
            
            RTL
        
        .setCustomFixedColor
        
        STX.b $9C
        STY.b $9D ; Set the fixed color addition color values.
    
    .noCustomFixedColor
    
    LDA.b $11 : AND.w #$00FF : CMP.w #$0004 : BEQ .BRANCH_11
        ; Make sure BG2 and BG1 Y scroll values are synchronized.
        ; Same for X scroll.
        LDA.b $E8 : STA.b $E6
        LDA.b $E2 : STA.b $E0
            
        LDA.b $8A : AND.w #$003F
            
        ; Are we at Hyrule Castle or Pyramid of Power?
        CMP.w #$001B : BNE .subscreenOnAndReturn
            LDA.b $E2 : SEC : SBC.w #$0778 : LSR A : TAY : AND.w #$4000 : BEQ .BRANCH_7
                TYA : ORA.w #$8000 : TAY
            
            .BRANCH_7
            
            STY.b $00
                
            LDA.b $E2 : SEC : SBC.b $00 : STA.b $E0
                
            LDA.b $E6 : CMP.w #$06C0 : BCC .BRANCH_9
                SEC : SBC.w #$0600 : AND.w #$03FF : CMP.w #$0180 : BCS .BRANCH_8
                    LSR A : ORA.w #$0600
                
                    BRA .BRANCH_10
            
                .BRANCH_8
            
                LDA.w #$06C0
                
                BRA .BRANCH_10
            
            .BRANCH_9

            LDA.b $E6 : AND.w #$00FF : LSR A : ORA.w #$0600
            
            .BRANCH_10
            
            ; Set BG1 vertical scroll.
            STA.b $E6
                
            BRA .subscreenOnAndReturn
    
    .BRANCH_11
    
    LDA.b $8A : AND.w #$003F : CMP.w #$001B : BNE .subscreenOnAndReturn
        ; Synchronize Y scrolls on BG0 and BG1. Same for X scrolls.
        LDA.b $E8 : STA.b $E6
        LDA.b $E2 : STA.b $E0
            
        LDA.w $0410 : AND.w #$00FF : CMP.w #$0008 : BEQ .BRANCH_12
            ; Handles scroll for special areas maybe?
            LDA.w #$0838 : STA.b $E0
        
        .BRANCH_12
        
        LDA.w #$06C0 : STA.b $E6
    
    .subscreenOnAndReturn
    
    SEP #$20
        
    ; Put BG0 on the subscreen.
    LDA.b #$01 : STA.b $1D
        
    SEP #$30
        
    ; Update palette.
    INC.b $15
        
    RTL
}

; ==============================================================================

; $05FFA8-$05FFF5 LONG JUMP LOCATION
WallMaster_SendPlayerToLastEntrance:
{
    JSL Dungeon_SaveRoomData.justKeys
    JSL Dungeon_SaveRoomQuadrantData
    JSL Sprite_ResetAll
    
    ; Don't use a starting point entrance.
    STZ.w $04AA
    
    ; Falling into an overworld hole mode.
    LDA.b #$11 : STA.b $10
    
    STZ.b $11
    STZ.b $14

    ; $05FFBF ALTERNATE ENTRY POINT
    ; TODO: Make a label for the entry point.
    STZ.w $0345
    
    ; TODO: \wtf 0x11? Written here? I thought these were all even.
    STA.w $005E
    
    STZ.w $03F3
    STZ.w $0322
    STZ.w $02E4
    STZ.w $0ABD
    STZ.w $036B
    STZ.w $0373
    
    STZ.b $27
    STZ.b $28
    
    STZ.b $29
    
    STZ.b $24
    
    STZ.w $0351
    STZ.w $0316
    STZ.w $031F
    
    LDA.b #$00 : STA.b $5D
    
    STZ.b $4B

    ; $05FFEE ALTERNATE ENTRY POINT

    JSL Ancilla_TerminateSelectInteractives
    JML Player_ResetState
}

; ==============================================================================
