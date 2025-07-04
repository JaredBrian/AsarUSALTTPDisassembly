; ==============================================================================

!bari_substate = $0DB0

; ==============================================================================

; $032213-$032234 DATA
Pool_Sprite_RedBari:
{
    ; $032213
    .rotation_speeds
    db 1, -1
    
    ; NOTE: These two arrays roughly correspond to positions on a circle of
    ; radius 16.
    ; $032215
    .drift_x_speeds
    db   0,   8,  11,  14,  16,  14,  11,   8
    db   0,  -8, -11, -14, -16, -14, -11,  -8
    
    ; $032225
    .drift_y_speeds
    db -16, -14, -11,  -8,   0,   8,  11,  14
    db  16,  14,  11,   8,   0,  -9, -11, -14
}
    
; ==============================================================================

; $032235-$032238 DATA
Pool_RedBari_Split:
{
    ; $032235
    .x_offsets
    db   0,   8
    
    ; $032237
    .x_speeds
    db -32,  32
}

; $032239-$03223C DATA
Pool_Sprite_RedBari:
{
    ; $032239
    .wiggle_x_speeds
    db 8, -8
    
    ; $03223B
    .animation_state_bases
    db 0,  3
}

; $03223D-$03234D JUMP LOCATION
Sprite_RedBari:
Sprite_BlueBari:
{
    LDA !bari_substate, X : BEQ .not_confined
        BPL Sprite_Biri
            LDA.w $0EB0, X : CMP.b #$10 : BNE .delay_collision_logic
                ; WTF: $0E30, X  seems to affect collision by.... not moving the
                ; sprite's coordinates around...
                LDA.b #-1 : STA.w $0D50, X
                            STA.w $0E30, X
                
                JSR.w Sprite_CheckTileCollision
                
                STZ.w $0E30, X
                
                LDA.w $0FA5 : BNE .collided
                    STZ !bari_substate, X
                    
                    STZ.w $0BA0, X
                    
                    JMP .set_new_electrication_delay
                
                .collided
                
                STA.w $0BA0, X
                
                RTS     
            
            .delay_collision_logic
            
            INC.w $0EB0, X
            
            RTS
        
        ; $03226F
        Sprite_Biri:
        
        JSR.w Sprite_PrepAndDrawSingleSmall
        
        BRA .drawing_logic_complete
    
    .not_confined
    
    LDA.w $0DC0, X : CMP.b #$02 : BCC .not_electric_animation_state
        JSR.w Sprite_PrepAndDrawSingleLarge
        
        BRA .drawing_logic_complete
        
    .not_electric_animation_state
    
    JSR.w RedBari_Draw
    
    .drawing_logic_complete
    
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    
    ; This only impacts Biri as the other related sprites here don't set this
    ; variable.
    LDA.w $0E10, X : BNE .recoiling_from_split_process
        LDA.w $0D80, X : CMP.b #$02 : BNE .not_splitting
            STA.w $0BA0, X
            
            LDA.b $1A : LSR : AND.b #$01 : TAY
            
            LDA Pool_Sprite_RedBari_wiggle_x_speeds, Y : STA.w $0D50, X
            
            JSR.w Sprite_MoveHoriz
            
            LDA.w $0DF0, X : BNE .delay_splitting
                JSR.w RedBari_Split
                
                STZ.w $0DD0, X
            
            .delay_splitting
            
            RTS
        
        .not_splitting
        
        JSR.w Sprite_CheckDamage
        
        TXA : EOR.b $1A : AND.b #$0F : BNE .rotation_increment_delay
            LDA.w $0DA0, X : AND.b #$01 : TAY
            
            LDA.w $0D90, X : CLC : ADC Pool_Sprite_RedBari_rotation_speeds, Y
            STA.w $0D90, X
            
            JSL.l GetRandomInt : AND.b #$03 : BNE .dont_toggle_rotation_polarity
                INC.w $0DA0, X
            
            .dont_toggle_rotation_polarity
        .rotation_increment_delay
        
        LDA.w $0D90, X : AND.b #$0F : TAY
        
        LDA Pool_Sprite_RedBari_drift_x_speeds, Y : STA.w $0D50, X
        
        LDA Pool_Sprite_RedBari_drift_y_speeds, Y : STA.w $0D40, X
        
        TXA : EOR.b $1A : AND.b #$03 : ORA.w $0DF0, X
        
        BNE .electrification_prevents_movement
    
    .recoiling_from_split_process
    
    LDA.w $0E70, X : BNE .no_tile_collision
        JSR.w Sprite_Move
    
    .no_tile_collision
    
    JSR.w Sprite_CheckTileCollision
    
    .electrification_prevents_movement
    
    LDY !bari_substate, X
    
    LDA.b $1A : LSR #3 : AND.b #$01
    
    CLC : ADC Pool_Sprite_RedBari_animation_state_bases, Y : STA.w $0DC0, X
    
    LDA.w $0D80, X : BEQ .not_electrified
        LDA.w $0DF0, X : BNE .delay_nonelectrified_transition
            STZ.w $0D80, X
            
            BRA .set_new_electrification_delay
            
        .delay_nonelectrified_transition
        
        LDA.b $1A : LSR : AND.b #$02
        
        CLC : ADC Pool_Sprite_RedBari_animation_state_bases, Y : STA.w $0DC0, X
        
        RTS
        
    .not_electrified
    
    LDA.w $0E00, X : BNE .delay_electrification_selection
        JSL.l GetRandomInt : AND.b #$01 : BNE .set_new_electrication_delay
            LDA.b #$80 : STA.w $0DF0, X
            
            ; Enter the electrified state.
            INC.w $0D80, X
            
            RTS
        
        ; $032342 ALTERNATE ENTRY POINT
        .set_new_electrication_delay
        
        JSL.l GetRandomInt : AND.b #$3F : ADC.b #$80 : STA.w $0E00, X
    
    .delay_electrification_selection
    
    RTS
}

; ==============================================================================

; $03234E-$03239B LOCAL JUMP LOCATION
RedBari_Split:
{
    LDA.b #$01 : STA.w $0FB5
    
    .spawn_next
        
        LDA.b #$23 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b #$33 : STA.w $0E60, Y
            
            LDA.b #$03 : STA.w $0F50, Y
            
            LDA.b #$01 : STA.w $0F60, Y
                         STA !bari_substate, Y
            
            PHX
            
            LDX.w $0FB5
            
            LDA.b $00 : CLC : ADC Pool_RedBari_Split_x_offsets, X
            STA.w $0D10, Y

            LDA.b $01 : ADC.b #$00
            STA.w $0D30, Y
            
            LDA Pool_RedBari_Split_x_speeds, X : STA.w $0D50, Y
            
            LDA.b #$08 : STA.w $0E10, Y
            
            LDA.b #$40 : STA.w $0E00, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .spawn_next
    
    RTS
}

; ==============================================================================

; $03239C-$0323DB DATA
RedBari_Draw_OAM_groups:
{
    dw 0, 0 : db $22, $00, $00, $00
    dw 8, 0 : db $22, $40, $00, $00
    dw 0, 8 : db $32, $00, $00, $00
    dw 8, 8 : db $32, $40, $00, $00
    
    dw 0, 0 : db $23, $00, $00, $00
    dw 8, 0 : db $23, $40, $00, $00
    dw 0, 8 : db $33, $00, $00, $00
    dw 8, 8 : db $33, $40, $00, $00
}

; $0323DC-$0323F8 LOCAL JUMP LOCATION
RedBari_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JSL.l Sprite_DrawMultiple
    
    JMP Sprite_DrawShadow
}

; ==============================================================================
