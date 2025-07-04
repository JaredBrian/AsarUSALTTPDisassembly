; ==============================================================================

; $031E1F-$031E43 JUMP LOCATION
Sprite_Ropa:
{
    JSR.w Ropa_Draw
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_CheckDamage
    
    INC.w $0E80, X
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : STA.w $0DC0, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Ropa_Stationary ; 0x00 - $9E44
    dw Ropa_Pounce     ; 0x01 - $9E5D
}

; ==============================================================================

; $031E44-$031E5C JUMP LOCATION
Ropa_Stationary:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$10
    
    JSR.w Sprite_ApplySpeedTowardsPlayer
    
    JSL.l GetRandomInt : AND.b #$0F : ADC.b #$14 : STA.w $0F80, X
    
    INC.w $0D80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $031E5D-$031E84 JUMP LOCATION
Ropa_Pounce:
{
    JSR.w Sprite_Move
    JSR.w Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BEQ .no_tile_collision
        JSR.w Sprite_Zero_XY_Velocity
    
    .no_tile_collision
    
    JSR.w Sprite_MoveAltitude
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .not_grounded
        STZ.w $0F70, X
        
        LDA.b #$30 : STA.w $0DF0, X
        
        STZ.w $0D80, X
    
    .not_grounded
    
    RTS
}

; ==============================================================================

; $031E85-$031EE4 DATA
Ropa_Draw_OAM_groups:
{
    dw 0, -8 : db $26, $00, $00, $00
    dw 8, -8 : db $27, $00, $00, $00
    dw 0,  0 : db $08, $00, $00, $02
    
    dw 0, -8 : db $36, $00, $00, $00
    dw 8, -8 : db $37, $00, $00, $00
    dw 0,  0 : db $0A, $00, $00, $02
    
    dw 0, -8 : db $27, $40, $00, $00
    dw 8, -8 : db $26, $40, $00, $00
    dw 0,  0 : db $08, $40, $00, $02
    
    dw 0, -8 : db $37, $40, $00, $00
    dw 8, -8 : db $36, $40, $00, $00
    dw 0,  0 : db $08, $40, $00, $02    
}

; $031EE5-$031F04 JUMP LOCATION
Ropa_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X
    
    REP #$20
    
    ASL #3 : STA.b $00 : ASL : ADC.b $00 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSL.l Sprite_DrawMultiple
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
