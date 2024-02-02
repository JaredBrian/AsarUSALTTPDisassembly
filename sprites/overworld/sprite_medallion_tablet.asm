
; ==============================================================================

; $02F25A-$02F261 LONG
SpritePrep_MedallionTabletLong:
{
    ; Sprite prep for medallion tablet.
    
    PHB : PHK : PLB
    
    JSR SpritePrep_MedallionTablet
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F262-$02F295 LOCAL JUMP LOCATION
SpritePrep_MedallionTablet:
{
    INC $0BA0, X
    
    LDA $8A : CMP.b #$03 : BEQ .ether_location
    
    LDA $0D10, X : CLC : ADC.b #$08 : STA $0D10, X
    
    LDA $7EF347 : BEQ .dont_have_item
    
    LDA.b #$04 : STA $0DC0, X
    LDA.b #$03 : STA $0D80, X
    
    RTS
    
    .ether_location
    
    LDA $7EF348 : BEQ .dont_have_item
    
    LDA.b #$04 : STA $0DC0, X 
    LDA.b #$03 : STA $0D80, X
    
    .dont_have_item
    
    RTS
}

; ==============================================================================

; $02F296-$02F29D LONG
Sprite_MedallionTabletLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_MedallionTablet
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F29E-$02F2A8 LOCAL JUMP LOCATION
Sprite_MedallionTablet:
{
    LDA $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw MedallionTablet_Main
    dw Sprite_DustCloud
}

; ==============================================================================

; $02F2A9-$02F2B1 DATA
pool Sprite_DustCloud:
{
    .animation_states
    db $00, $01, $02, $03, $04, $05, $01, $00
    db $FF
}

; ==============================================================================

; $02F2B2-$02F2D5 JUMP LOCATION
Sprite_DustCloud:
{
    JSL DustCloud_Draw
    JSR Sprite2_CheckIfActive
    
    LDA $0DF0, X : BNE .delay
    
    LDA.b #$05 : STA $0DF0, X
    
    LDY $0D90, X
    
    LDA .animation_states, Y : BPL .valid_animation_state
    
    STZ $0DD0, X
    
    RTS
    
    .valid_animation_state
    
    STA $0DC0, X
    
    INC $0D90, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02F2D6-$02F30B LOCAL JUMP LOCATION
MedallionTablet_SpawnDustCloud:
{
    LDA.b #$F2 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL GetRandomInt : STA $0F
    
    JSL GetRandomInt : REP #$20 : AND.w #$000F
    
    SEC : SBC.w #$0008 : CLC : ADC $00 : STA $00
    
    LDA $0F : AND.w #$000F : CLC : ADC $02 : STA $02
    
    SEP #$30
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$01 : STA $0E80, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $02F30C-$02F346 JUMP LOCATION
MedallionTablet_Main:
{
    JSL MedallionTablet_Draw
    JSR Sprite2_CheckIfActive
    
    ; Turn off a certain pose for the player?
    LDA $037A : AND.b #$DF : STA $037A
    
    STZ $0D90, X
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
    
    JSL Sprite_NullifyHookshotDrag
    
    STZ $5E
    
    JSL Sprite_RepelDashAttackLong
    
    INC $0D90, X
    
    .no_player_collision
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCC .nope
    
    RTS
    
    .nope
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw MedallionTablet_WaitForMudoraReader
    dw MedallionTablet_ExtendedDelay
    dw MedallionTablet_Crumbling
    dw MedallionTablet_FinalAnimationState
}

; ==============================================================================

; $02F34F-$02F3C3 JUMP LOCATION
MedallionTablet_WaitForMudoraReader:
{
    LDA $8A : CMP.b #$03 : BEQ MedallionTablet_WaitForEther
    
    LDA $2F : BNE .beta
    
    JSR Sprite2_DirectionToFacePlayer : CPY.b #$02 : BNE .beta
    
    REP #$20
    
    LDA $0FDA : CLC : ADC.w #$0010 : CMP $20 : SEP #$30 : BCC .beta
    
    LDA $F4 : BPL .gamma
    
    ; \tcrf (verified)
    ; My, what a corner case bit of logic this is. So if the
    ; sword and the book of Mudora and the Master Sword are used at the 
    ; same time, the Master Sword wins, but the Tempered and Golden swords
    ; never hit this case? Does this suggest that this code was written
    ; before the Tempered and Master Swords were even conceived of? Even so,
    ; what is the real intention of this logic? By the way, this has been
    ; verified to prevent one from getting the medallion with the Master
    ; Sword and to not prevent with the Golden Sword. It's difficult to test
    ; because the button presses have to come in on exactly the same frame,
    ; though.
    LDA $7EF359 : CMP.b #$02 : BNE .gamma
    
    RTS
    
    .gamma
    
    LDA $0202 : CMP.b #$0F : BNE .delta
    
    LDY.b #$01
    
    LDA $F4 : AND.b #$40 : BNE .epsilon
    
    .delta
    
    LDA $F6 : BPL .beta
    
    LDY.b #$00
    
    .epsilon
    
    CPY.b #$00 : BEQ .zeta
    
    STZ $0300
    
    LDA.b #$20 : STA $037A
    
    STZ $012E
    
    LDA $7EF359 : BMI .zeta
    CMP.b #$02  : BCC .zeta
    
    INC $0D80, X
    
    JSL Player_InitiateFirstBombosSpell
    
    LDA.b #$40 : STA $0DF0, X
    
    .zeta
    
    LDA.w $F34B, Y       : XBA
    LDA.w $F34D, Y : TAY : XBA
    
    JSL Sprite_ShowMessageUnconditional
    
    .beta
    
    RTS
}
    
; ==============================================================================

; $02F3C4-$02F42D BRANCH LOCATION
MedallionTablet_WaitForEther:
{
    LDA $2F : BNE .return
    
    JSR Sprite2_DirectionToFacePlayer : CPY.b #$02 : BNE .return
    
    LDA $0D00, X : CLC : ADC.b #$10 : CMP $20 : BCC .return
    
    LDA $F4 : BPL .b_button_not_pressed
    
    LDA $7EF359 : CMP.b #$02 : BNE .not_exactly_master_sword
    
    RTS
    
    .not_exactly_master_sword
    .b_button_not_pressed
    
    LDA $0202 : CMP.b #$0F : BNE .book_of_mudora_not_equipped
    
    LDY.b #$01
    
    LDA $F4 : AND.b #$40 : BNE .y_button_pressed
    
    .book_of_mudora_not_equipped
    
    LDA $F6 : BPL .return
    
    LDY.b #$00
    
    .y_button_pressed
    
    CPY.b #$00 : BEQ .show_hylian_script
    
    STZ $0300
    
    LDA.b #$20 : STA $037A
    
    STZ $012E
    
    LDA $7EF359 : BMI .show_hylian_script
    CMP.b #$02  : BCC .show_hylian_script
    
    INC $0D80, X
    
    JSL Player_InitiateFirstEtherSpell
    
    LDA.b #$40 : STA $0DF0, X
    
    .show_hylian_script
    
    LDA.w $F347, Y       : XBA
    LDA.w $F349, Y : TAY : XBA
    
    JSL Sprite_ShowMessageUnconditional
    
    .return
    
    RTS
}

; ==============================================================================

; $02F42E-$02F43B JUMP LOCATION
MedallionTablet_ExtendedDelay:
{
    LDA $0DF0, X : BNE .delay
    
    INC $0D80, X
    
    LDA.b #$80 : STA $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02F43C-$02F462 JUMP LOCATION
MedallionTablet_Crumbling:
{
    LDA $0DF0, X : BNE .delay
    
    INC $0D80, X
    
    LDA.b #$F0 : STA $0DF0, X
    
    RTS
    
    .delay
    
    CMP.b #$60 : BEQ .increment_animation_state
    CMP.b #$40 : BEQ .increment_animation_state
    CMP.b #$20 : BNE .do_not
    
    .increment_animation_state
    
    INC $0DC0, X
    
    .do_not
    
    LDA $1A : AND.b #$07 : BNE .dont_spawn_dust_cloud
    
    JSR MedallionTablet_SpawnDustCloud
    
    .dont_spawn_dust_cloud
    
    RTS
}

; ==============================================================================

; $02F463-$02F468 JUMP LOCATION
MedallionTablet_FinalAnimationState:
{
    LDA.b #$04 : STA $0DC0, X
    
    RTS
}

; ==============================================================================

