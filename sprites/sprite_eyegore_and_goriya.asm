; ==============================================================================

; $0F4700-$0F4720 LONG JUMP LOCATION
SpritePrep_Eyegore:
{
    LDA.w $048E
    
    CMP.b #$0C : BEQ .is_goriya
    CMP.b #$1B : BEQ .is_goriya
    CMP.b #$4B : BEQ .is_goriya
        CMP.b #$6B : BNE .not_goriya
    
    .is_goriya:
    
    INC.w $0DA0, X
    
    LDA.w $0E20, X : CMP.b #$83 : BNE .not_red_goriya
        ; Disable some of the invulnerability properties.
        STZ.w $0CAA, X
    
    .not_red_goriya
    .not_goriya
    
    RTL
}

; ==============================================================================

; $0F4721-$0F4790 DATA
Pool_Goriya:
{
    ; $0F4721
    .speed_x
    db   0,  16, -16,   0,   0,  13, -13,   0
    db   0,  13, -13,   0,   0,   0,   0,   0
    db   0, -24,  24,   0,   0, -16,  16,   0
    db   0, -16,  16,   0,   0,   0,   0,   0

    ; $0F4741
    .speed_y
    db   0,   0,   0,   0, -16,  -5,  -5,   0
    db  16,  13,  13,   0,   0,   0,   0,   0
    db   0,   0,   0,   0, -24, -16, -16,   0
    db  24,  16,  16,   0,   0,   0,   0,   0

    ; $0F4761
    .direction
    db $00, $00, $01, $00, $03, $03, $03, $00
    db $02, $02, $02, $00, $00, $00, $00, $00
    db $00, $01, $00, $00, $03, $03, $03, $00
    db $02, $02, $02, $00, $00, $00, $00, $00

    ; $0F4781
    .anim_step
    db $08, $06, $00, $03, $09, $07, $01, $04
    db $08, $06, $00, $03, $09, $07, $02, $05
}

; ==============================================================================

; $0F4791-$0F479A BRANCH LOCATION
Goriya_StayStill:
{
    STZ.w $0D90, X
    
    JSR.w Sprite3_CheckDamage
    JSR.w Sprite3_CheckTileCollision
    
    RTS
}

; ==============================================================================

; $0F479B-$0F48A2 JUMP LOCATION
Sprite_Eyegore:
{
    LDA.w $0DA0, X : BNE Sprite_Goriya
        JMP Eyegore_Main
}

; $0F47A3-$0F4838 JUMP LOCATION
Sprite_Goriya:
{
    JSL.l Goriya_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.w $0E00, X : BEQ .phlegm_inhibit
        CMP.b #$08 : BNE .phlegm_delay
            JSL.l Sprite_SpawnFirePhlegm
        
        .phlegm_delay
    .phlegm_inhibit
    
    ; Ignore the player just pressing against a wall.
    LDA.w $0048 : CMP.b #$00 : BNE Goriya_StayStill
        LDY.w $0E20, X
        
        LDA.b $F0 : AND.b #$0F : BEQ Goriya_StayStill
            CPY.b #$84 : BNE .not_faster_goriya
                ORA.b #$10
            
            .not_faster_goriya
            
            TAY
            
            LDA.w Pool_Goriya_direction, Y : STA.w $0DE0, X
            
            LDA.w Pool_Goriya_speed_x, Y : STA.w $0D50, X
            
            LDA.w Pool_Goriya_speed_y, Y : STA.w $0D40, X
            
            LDA.w $0E70, X : BNE .tile_collision
                JSR.w Sprite3_Move
            
            .tile_collision
            
            JSR.w Sprite3_CheckDamage
            JSR.w Sprite3_CheckTileCollision
            
            INC.w $0E80, X : LDA.w $0E80, X : AND.b #$0C : ORA.w $0DE0, X : TAY
            
            LDA.w Pool_Goriya_anim_step, Y : STA.w $0DC0, X
            
            LDA.w $0E20, X : CMP.b #$84 : BNE .no_fire_phlegm_logic
                JSR.w Sprite3_DirectionToFacePlayer
                
                LDA.b $0F : CLC : ADC.b #$08 : CMP.b #$10 : BCC .in_firing_line
                    LDA.b $0E : CLC : ADC.b #$08 : CMP.b #$10 : BCS .not_in_firing_line
                
                .in_firing_line
                
                TYA : CMP.w $0DE0, X : BNE .not_facing_player
                    LDA.w $0D90, X : AND.b #$1F : BNE .phlegm_charge_counter_not_maxed
                        LDA.b #$10 : STA.w $0E00, X
                    
                    .phlegm_charge_counter_not_maxed
                    
                    INC.w $0D90, X
                    
                    RTS
                    
                .not_facing_player
                .not_in_firing_line
            .no_fire_phlegm_logic
            
            STZ.w $0D90, X
            
            RTS
}
    
; ==============================================================================

; $0F4839-$0F4863 ALTERNATE ENTRY POINT
Eyegore_Main:
{
    JSR.w Eyegore_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    LDA.w $0CAA, X : ORA.b #$04 : STA.w $0CAA, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Eyegore_WaitUntilPlayerNearby ; 0x00 - $C868
    dw Eyegore_OpeningEye            ; 0x01 - $C893
    dw Eyegore_ChasePlayer           ; 0x02 - $C8CB
    dw Eyegore_ClosingEye            ; 0x03 - $C936
}

; ==============================================================================

; $0F4864-$0F4867 DATA
Eyegore_timers:
{
    db $60, $80, $A0, $80
}

; ==============================================================================

; $0F4868-$0F488A JUMP LOCATION
Eyegore_WaitUntilPlayerNearby:
{
    LDA.w $0DF0, X : BNE .delay
        JSR.w Sprite3_DirectionToFacePlayer
        
        LDA.b $0E : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_not_close
            LDA.b $0F : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_not_close
                INC.w $0D80, X
                
                LDA.b #$3F : STA.w $0DF0, X
        
        .player_not_close
    .delay
    
    RTS
}

; ==============================================================================

; $0F488B-$0F4892 DATA
Eyegore_OpeningEye_animation_states:
{
    db $02, $02, $02, $02, $01, $01, $00, $00
}


; $0F4893-$0F48BA JUMP LOCATION
Eyegore_OpeningEye:
{
    LDA.w $0DF0, X : BNE .delay
        JSR.w Sprite3_DirectionToFacePlayer : TYA : STA.w $0DE0, X
        
        INC.w $0D80, X
        
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        LDA.w Eyegore_timers, Y : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LSR #3 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F48BB-$0F48CA DATA
Eyegore_ChasePlayer_animation_states:
{
    db $07, $05, $02, $09, $08, $06, $03, $0A
    db $07, $05, $02, $09, $08, $06, $04, $0B
}

; $0F48CB-$0F492D JUMP LOCATION
Eyegore_ChasePlayer:
{
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    LDA.w $0E20, X : CMP.b #$84 : BEQ .is_red_eyegore
        LDA.w $0CAA, X : AND.b #$FB : STA.w $0CAA, X
    
    .is_red_eyegore
    
    LDA.w $0DF0, X : BNE .close_eye_delay
        LDA.b #$3F : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        STZ.w $0DC0, X
        
        RTS
        
    .close_eye_delay
    
    TXA : EOR.b $1A : AND.b #$1F : BNE .face_player_delay
        JSR.w Sprite3_DirectionToFacePlayer
        
        TYA : STA.w $0DE0, X
    
    .face_player_delay
    
    LDY.w $0DE0, X
    
    LDA Sprite3_Shake_x_speeds, Y : STA.w $0D50, X
    
    LDA Sprite3_Shake_y_speeds, Y : STA.w $0D40, X
    
    LDA.w $0E70, X : BNE .collided_with_tile
        JSR.w Sprite3_Move
    
    .collided_with_tile
    
    JSR.w Sprite3_CheckTileCollision
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$0C : ORA.w $0DE0, X : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F492E-$0F4935 DATA
Eyegore_ClosingEye_animation_states:
{
    db $00, $00, $01, $01, $02, $02, $02, $02
}

; $0F4936-$0F494E JUMP LOCATION
Eyegore_ClosingEye:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
        
        LDA.b #$60 : STA.w $0DF0, X
        
        RTS
    
    .delay
    
    LSR #3 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F494F-$0F4ACE DATA
Eyegore_Draw_oam_groups:
{
    dw -4, -4 : db $A2, $00, $00, $02
    dw  4, -4 : db $A2, $40, $00, $02
    dw -4,  4 : db $9C, $00, $00, $02
    dw  4,  4 : db $9C, $40, $00, $02
    
    dw -4, -4 : db $A4, $00, $00, $02
    dw  4, -4 : db $A4, $40, $00, $02
    dw -4,  4 : db $9C, $00, $00, $02
    dw  4,  4 : db $9C, $40, $00, $02
    
    dw -4, -4 : db $8C, $00, $00, $02
    dw  4, -4 : db $8C, $40, $00, $02
    dw -4,  4 : db $9C, $00, $00, $02
    dw  4,  4 : db $9C, $40, $00, $02
    
    dw -4, -3 : db $8C, $00, $00, $02
    dw 12, -3 : db $8C, $40, $00, $00
    dw -4, 13 : db $BC, $00, $00, $00
    dw  4,  5 : db $8A, $40, $00, $02
    
    dw -4, -3 : db $8C, $00, $00, $00
    dw  4, -3 : db $8C, $40, $00, $02
    dw -4,  5 : db $8A, $00, $00, $02
    dw 12, 13 : db $BC, $40, $00, $00
    
    dw  0, -4 : db $AA, $00, $00, $02
    dw  0,  4 : db $A6, $00, $00, $02
    dw  0, -4 : db $AA, $00, $00, $02
    dw  0,  4 : db $A6, $00, $00, $02
    
    dw  0, -3 : db $AA, $00, $00, $02
    dw  0,  4 : db $A8, $00, $00, $02
    dw  0, -3 : db $AA, $00, $00, $02
    dw  0,  4 : db $A8, $00, $00, $02
    
    dw  0, -4 : db $AA, $40, $00, $02
    dw  0,  4 : db $A6, $40, $00, $02
    dw  0, -4 : db $AA, $40, $00, $02
    dw  0,  4 : db $A6, $40, $00, $02
    
    dw  0, -3 : db $AA, $40, $00, $02
    dw  0,  4 : db $A8, $40, $00, $02
    dw  0, -3 : db $AA, $40, $00, $02
    dw  0,  4 : db $A8, $40, $00, $02
    
    dw -4, -4 : db $8E, $00, $00, $02
    dw  4, -4 : db $8E, $40, $00, $02
    dw -4,  4 : db $9E, $00, $00, $02
    dw  4,  4 : db $9E, $40, $00, $02
    
    dw -4, -3 : db $8E, $00, $00, $02
    dw 12, -3 : db $8E, $40, $00, $00
    dw -4, 13 : db $BD, $00, $00, $00
    dw  4,  5 : db $A0, $40, $00, $02
    
    dw -4, -3 : db $8E, $00, $00, $00
    dw  4, -3 : db $8E, $40, $00, $02
    dw -4,  5 : db $A0, $00, $00, $02
    dw 12, 13 : db $BD, $40, $00, $00  
}

; $0F4ACF-$0F4AF3 LOCAL JUMP LOCATION
Eyegore_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JSR.w Sprite3_DrawMultiple
    
    ; NOTE: I don't get this. Most other sprites don't have this check,
    ; do they?
    LDA.w $0F00, X : BNE .dont_draw_shadow
        LDA.b #$0E : JSL.l Sprite_DrawShadowLong_variable
    
    .dont_draw_shadow
    
    RTS
}

; ==============================================================================

