; ==============================================================================

; $0F4F47-$0F4F99 JUMP LOCATION
Sprite_SpikeTrap:
{
    JSR.w SpikeTrap_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckDamage
        
    LDA.w $0D80, X : BNE SpikeTrap_InMotion
        
        JSR.w Sprite3_DirectionToFacePlayer
        
        TYA : STA.w $0DE0, X
        
        LDA.b $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_enough
            BRA .move_towards_player
        
        .not_close_enough
        
        LDA.b $0E : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_enough
            .move_towards_player
            
            LDA.w .timers, Y : STA.w $0DF0, X
            
            INC.w $0D80, X
            
            LDA.w .x_speeds, Y : STA.w $0D50, X
            
            LDA.w .y_speeds, Y : STA.w $0D40, X
        
        .not_close_enough
        
        RTS
    
    ; $0F4F86
    .x_speeds
    db  32, -32,   0,   0
    
    ; $0F4F8A
    .retract_x_speeds
    db -16,  16,   0,   0
    
    ; $0F4F8E
    .y_speeds
    db   0,   0,  32, -32
    
    ; $0F4F92
    .retract_y_speeds
    db   0,   0, -16,  16
    
    ; $0F4F96
    .timers
    db $40, $40, $38, $38
}
    
; ==============================================================================

; $0F4F9A-$0F4FDE BRANCH LOCATION
SpikeTrap_InMotion:
{
    CMP.b #$01 : BNE .retracting
        JSR.w Sprite3_CheckTileCollision : BNE .collided_with_tile
            LDA.w $0DF0, X : BNE .moving_on
        
        .collided_with_tile
        
        INC.w $0D80, X
        
        LDA.b #$60 : STA.w $0DF0, X
        
        .moving_on
        
        JSR.w Sprite3_Move
        
        RTS
        
    .retracting
    
    LDA.w $0DF0, X : BNE .delay
        LDY.w $0DE0, X
        
        LDA.w Sprite_SpikeTrap_retract_x_speeds, Y : STA.w $0D50, X
        
        LDA.w Sprite_SpikeTrap_retract_y_speeds, Y : STA.w $0D40, X
        
        JSR.w Sprite3_Move
        
        LDA.w $0D10, X : CMP.w $0D90, X : BNE .delay
        
        LDA.w $0D00, X : CMP.w $0DB0, X : BNE .delay
        
        STZ.w $0D80, X
        
    .delay
    
    RTS
}

; ==============================================================================

; $0F4FDF-$0F4FFE DATA
SpikeTrap_Draw_OAM_groups:
{
    dw -8, -8 : db $C4, $00, $00, $02
    dw  8, -8 : db $C4, $40, $00, $02
    dw -8,  8 : db $C4, $80, $00, $02
    dw  8,  8 : db $C4, $C0, $00, $02
}

; $0F4FFF-$0F5011 LOCAL JUMP LOCATION
SpikeTrap_Draw:
{
    REP #$20
    
    LDA.w #(.OAM_groups) : STA.b $08
    
    LDA.w #$0004 : STA.b $06
    
    SEP #$30
    
    JSL.l Sprite_DrawMultiple_quantity_preset
    
    RTS
}

; ==============================================================================
