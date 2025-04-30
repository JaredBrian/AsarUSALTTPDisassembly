; ==============================================================================

; $031C20-$031C23 DATA
Pool_Sprite_SnapDragon_animation_state_bases:
{
    db 4, 0, 6, 2
}

; $031C24-$031C4A JUMP LOCATION
Sprite_SnapDragon:
{
    LDY.w $0DE0, X
    
    LDA.w $0DA0, X : CLC : ADC .animation_state_bases, Y : STA.w $0DC0, X
    
    JSR.w SnapDragon_Draw
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_CheckDamage
    
    STZ.w $0DA0, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw SnapDragon_Resting ; 0x00 - $9C5F
    dw SnapDragon_Attack  ; 0x01 - $9CA9
}

; ==============================================================================

; $031C4B-$031C5A DATA
Pool_SnapDragon_Attack:
{
    ; $031C4B
    .x_speeds
    db  8,  -8,   8,  -8
    db 16, -16,  16, -16
    
    ; $031C53
    .y_speeds
    db  8,   8,  -8,  -8
    db 16,  16, -16, -16
}
    
; ==============================================================================

; $031C5B-$031C5E DATA
SnapDragon_Resting_timers:
{
    db $20, $30, $40, $50
}

; ==============================================================================

; $031C5F-$031CA8 JUMP LOCATION
SnapDragon_Resting:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$0C : LSR #2 : TAY
        
        LDA.w .timers, Y : STA.w $0DF0, X
        
        DEC.w $0D90, X : BPL .pick_random_direction
            LDA.b #$03 : STA.w $0D90, X
            
            LDA.b #$60 : STA.w $0DF0, X
            
            INC.w $0DB0, X
            
            JSR.w Sprite_IsBelowPlayer
            
            TYA : ASL A : STA.b $00
            
            JSR.w Sprite_IsToRightOfPlayer
            
            TYA : ORA.b $00
            
            BRA .set_direction
        
        .pick_random_direction
        
        JSL.l GetRandomInt : AND.b #$03
        
        .set_direction
        
        STA.w $0DE0, X
        
        RTS
    
    .delay
    
    AND.b #$18 : BEQ .dont_use_alternate_animation_state
        INC.w $0DA0, X
    
    .dont_use_alternate_animation_state
    
    RTS
}

; ==============================================================================

; $031CA9-$031D01 JUMP LOCATION
SnapDragon_Attack:
{
    ; Always has mouth open while in this state?
    INC.w $0DA0, X
    
    JSR.w Sprite_Move
    JSR.w Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BEQ .no_tile_collision
        LDA.w $0DE0, X : EOR.b #$03 : STA.w $0DE0, X
    
    .no_tile_collision
    
    LDY.w $0DE0, X
    
    LDA.w $0DB0, X : BEQ .use_slower_speeds
        INY #4
    
    .use_slower_speeds
    
    LDA.w Pool_SnapDragon_Attack_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_SnapDragon_Attack_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0F80, X : SEC : SBC.b #$04 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .not_grounded
        STZ.w $0F70, X
        
        LDA.w $0DF0, X : BNE .keep_bouncin_dude
            ; When timer expires, it's time to go back to resting.
            STZ.w $0D80, X
            
            STZ.w $0DB0, X
            
            LDA.b #$3F : STA.w $0DF0, X
            
            RTS
            
        .keep_bouncin_dude
        
        LDA.b #$14 : STA.w $0F80, X
    
    .not_grounded
    
    RTS
}

; ==============================================================================

; $031D02-$031E01 DATA
SnapDragon_Draw_OAM_groups:
{
    dw  4, -8 : db $8F, $00, $00, $00
    dw 12, -8 : db $9F, $00, $00, $00
    dw -4,  0 : db $8C, $00, $00, $02
    dw  4,  0 : db $8D, $00, $00, $02
    
    dw  4, -8 : db $2B, $00, $00, $00
    dw 12, -8 : db $3B, $00, $00, $00
    dw -4,  0 : db $28, $00, $00, $02
    dw  4,  0 : db $29, $00, $00, $02
    
    dw -4, -8 : db $3C, $00, $00, $00
    dw  4, -8 : db $3D, $00, $00, $00
    dw -4,  0 : db $AA, $00, $00, $02
    dw  4,  0 : db $AB, $00, $00, $02
    
    dw -4, -8 : db $3E, $00, $00, $00
    dw  4, -8 : db $3F, $00, $00, $00
    dw -4,  0 : db $AD, $00, $00, $02
    dw  4,  0 : db $AE, $00, $00, $02
    
    dw -4, -8 : db $9F, $40, $00, $00
    dw  4, -8 : db $8F, $40, $00, $00
    dw -4,  0 : db $8D, $40, $00, $02
    dw  4,  0 : db $8C, $40, $00, $02
    
    dw -4, -8 : db $3B, $40, $00, $00
    dw  4, -8 : db $2B, $40, $00, $00
    dw -4,  0 : db $29, $40, $00, $02
    dw  4,  0 : db $28, $40, $00, $02
    
    dw  4, -8 : db $3D, $40, $00, $00
    dw 12, -8 : db $3C, $40, $00, $00
    dw -4,  0 : db $AB, $40, $00, $02
    dw  4,  0 : db $AA, $40, $00, $02
    
    dw  4, -8 : db $3F, $40, $00, $00
    dw 12, -8 : db $3E, $40, $00, $00
    dw -4,  0 : db $AE, $40, $00, $02
    dw  4,  0 : db $AD, $40, $00, $02
}

; $031E02-$031E1E LOCAL JUMP LOCATION
SnapDragon_Draw:
{
    LDA #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JSL.l Sprite_DrawMultiple
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
