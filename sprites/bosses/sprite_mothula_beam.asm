
; ==============================================================================

; $0F3B42-$0F3BB8 JUMP LOCATION
Sprite_MothulaBeam:
{
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite3_CheckIfActive
    JSR Sprite3_CheckDamageToPlayer
    
    LDA $1A : AND.b #$01 : BNE .dont_toggle_vflip
    
    LDA.w $0F50, X : EOR.b #$80 : STA.w $0F50, X
    
    .dont_toggle_vflip
    
    JSR Sprite3_Move
    
    LDA.w $0DF0, X : BNE .no_tile_collision
    
    JSR Sprite3_CheckTileCollision : BEQ .no_tile_collision
    
    STZ.w $0DD0, X
    
    .no_tile_collision
    
    TXA : EOR $1A : AND.b #$03 : BNE .stagger_delay
    
    PHX : TXY
    
    LDX.b #$0E
    
    .next_slot
    
    LDA.l $7FF800, X : BEQ .empty_slot
    
    DEX : BPL .next_slot
    
    PLX
    
    .stagger_delay
    
    RTS
    
    .empty_slot
    
    ; \note Generate the mothula beam... garnish. Not sure what that looks
    ; like though.
    LDA.b #$02 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : STA.l $7FF81E, X
    LDA.w $0D20, Y : STA.l $7FF85A, X
    
    LDA.b #$10 : STA.l $7FF90E, X
    
    TYA : STA.l $7FF92C, X
    
    LDA.w $0F20, Y : STA.l $7FF968, X
    
    PLX
    
    RTS
}

; ==============================================================================
