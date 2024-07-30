
; ==============================================================================

; $02FACA-$02FAD1 LONG JUMP LOCATION
Sprite_MadBatterLong:
{
    ; Magic powder bat / lightning bolt he throws AI
    
    PHB : PHK : PLB
    
    JSR Sprite_MadBatter
    
    PLB
    
    RTL
}

; ==============================================================================

; $02FAD2-$02FAFE LOCAL JUMP LOCATION
Sprite_MadBatter:
{
    LDA.w $0EB0, X : BEQ .not_thunderbolt
    JSL Sprite_MadBatterBoltLong
    
    RTS
    
    .not_thunderbolt
    
    LDA.w $0D80, X : BEQ .dont_draw
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    .dont_draw
    
    JSR Sprite2_CheckIfActive
    JSR Sprite2_Move
    JSR Sprite2_MoveAltitude
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw MadBatter_WaitForSummoning
    dw MadBatter_RisingUp
    dw MadBatter_PseudoAttackPlayer
    dw MadBatter_DoublePlayerMagicPower
    dw MadBatter_LaterComplains
}

; ==============================================================================

; $02FAFF-$02FB39 JUMP LOCATION
MadBatter_WaitForSummoning:
{
    LDA.l $7EF37B : CMP.b #$01 : BCS .magic_already_doubled
    ; The sprite doesn't actually damage the player, this is just to detect
    ; contact.
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .not_close_to_player
        ; Needs to be summoned via Magic Powder
        LDY.b #$04
    
        .next_object
            LDA.w $0C4A, Y : CMP.b #$1A : BEQ .magic_powder
        
        DEY : BPL .next_object
        
        RTS
    
        .magic_powder
    
        JSL Sprite_SpawnSuperficialBombBlast
        
        LDA.b #$0D : JSL Sound_SetSfx1PanLong
        
        INC.w $0D80, X
        
        LDA.b #$14 : STA.w $0D90, X
        
        LDA.b #$01 : STA.w $02E4
        
        LDA.w $0F50, X : ORA.b #$20 : STA.w $0F50, X
    
    .not_close_to_player
    .magic_already_doubled
    
    RTS
}

; ==============================================================================

; $02FB3A-$02FB3B DATA
Pool_MadBatter_RisingUp:
{
    .x_speeds
    db -8,  7
}

; ==============================================================================

; $02FB3C-$02FB85 JUMP LOCATION
MadBatter_RisingUp:
{
    LDA.w $0DF0, X : BNE .delay
    DEC.w $0D90, X : LDA.w $0D90, X : STA.w $0DF0, X : CMP.b #$01 : BEQ .ready
        LSR #2 : STA.w $0F80, X
        
        LDA.w $0D90, X : AND.b #$01 : TAY
        
        LDA .x_speeds, Y : CLC : ADC.w $0D50, X : STA.w $0D50, X
        
        LDA.w $0DC0, X : EOR.b #$01 : STA.w $0DC0, X
    
    .delay
    
    RTS
    
    .ready
    
    ; Hey! Blast you for waking me from my deep, dark sleep! ...I mean..."
    LDA.b #$10
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    STZ.w $0DC0, X
    
    STZ.w $0F80, X
    
    STZ.w $0D50, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $02FB86-$02FB8D DATA
Pool_MadBatter_PseudoAttackPlayer:
{
    .palettes
    db $0A, $04, $02, $04, $02, $0A, $04, $02
}

; ==============================================================================

; $02FB8E-$02FBB8 JUMP LOCATION
MadBatter_PseudoAttackPlayer:
{
    LDA.w $0DF0, X : BNE .delay
    INC.w $0D80, X
    
    LDA.b #$40 : STA.w $0E00, X
    
    LDA.w $0DF0, X
    
    .delay
    
    LSR A : AND.b #$07 : TAY
    
    LDA.w $0F50, X : AND.b #$F1 : ORA .palettes, Y : STA.w $0F50, X
    
    LDA.w $0DF0, X : CMP.b #$F0 : BNE .delay_2
    JSL Sprite_SpawnMadBatterBolts
    
    .delay_2
    
    RTS
}

; ==============================================================================

; $02FBB9-$02FBE3 JUMP LOCATION
MadBatter_DoublePlayerMagicPower:
{
    LDA.w $0E00, X : BNE .delay
    ; "...I laugh at your misfortune! Now your magic power will drop..."
    LDA.b #$11
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    PHX
    
    JSL Palette_Restore_BG_And_HUD
    
    ; NOTE: Redundant to do this, the subroutine does this.
    INC.b $15
    
    PLX
    
    INC.w $0D80, X
    
    ; Reduce the magic power consumption by 1/2.
    LDA.b #$01 : STA.l $7EF37B
    
    JSL HUD.RefreshIconLong
    
    RTS
    
    .delay
    
    CMP.b #$10 : BNE .dont_flash_screen
    STA.w $0FF9
    
    .dont_flash_screen
    
    RTS
}

; ==============================================================================

; $02FBE4-$02FBEE JUMP LOCATION
MadBatter_LaterComplains:
{
    JSL Sprite_SpawnDummyDeathAnimation
    
    STZ.w $0DD0, X
    
    STZ.w $02E4
    
    RTS
}

; ==============================================================================
