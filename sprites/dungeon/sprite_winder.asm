
; ==============================================================================

; $0F51CD-$0F51D0 DATA
Pool_Sprite_Winder:
{
    .vh_flip
    db $00, $40, $80, $C0    
}

; ==============================================================================

    ; \note Appearance is that of a wandering fireball chain
; $0F51D1-$0F51FD JUMP LOCATION
Sprite_Winder:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckIfRecoiling
    
    LDA.b $1A : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $0F50, X : AND.b #$3F : ORA .vh_flip, Y : STA.w $0F50, X
    
    LDA.w $0D90, X : BEQ Winder_DefaultState
    
    ; \tcrf (unverified)
    ; The existence of this bit of code seems to suggest that there might
    ; have been a way to defeat Winders at one point, or that they died
    ; spontaneously...
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
    
    STZ.w $0DD0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F51FE-$0F5205 DATA
Pool_Winder_DefaultState:
{
    .x_speeds
    db $18, $E8, $00, $00
    
    .y_speeds
    db $00, $00, $18, $E8
}

; ==============================================================================

; $0F5206-$0F5238 LOCAL JUMP LOCATION
Winder_DefaultState:
{
    JSR Sprite3_CheckDamage
    JSR Winder_SpawnFireballGarnish
    
    LDA.w $0E70, X : BNE .tile_collision_prev_frame
    
    JSR Sprite3_Move
    
    .tile_collision_prev_frame
    
    JSR Sprite3_CheckTileCollision : BEQ .no_tile_collision_this_frame
    
    ; Pick a new direction at random
    JSL GetRandomInt : LSR A : LDA.w $0DE0, X : ROL A : TAY
    
    LDA.w $9254, Y : STA.w $0DE0, X
    
    .no_tile_collision_this_frame
    
    LDY.w $0DE0, X
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    LDA .y_speeds, Y : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0F5239-$0F528C LOCAL JUMP LOCATION
Winder_SpawnFireballGarnish:
{
    TXA : EOR.b $1A : AND.b #$07 : BNE .delay
    
    PHX : TXY
    
    LDX.b #$1D
    
    .next_slot
    
    LDA.l $7FF800, X : BEQ .empty_slot
    
    DEX : BPL .next_slot
    
    PLX
    
    RTS
    
    .empty_slot
    
    LDA.b #$01 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0D20, Y : ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.b #$20 : STA.l $7FF90E, X
    
    TYA : STA.l $7FF92C, X
    
    LDA.w $0F20, Y : STA.l $7FF968, X
    
    PLX
    
    .delay
    
    RTS
}

; ==============================================================================
