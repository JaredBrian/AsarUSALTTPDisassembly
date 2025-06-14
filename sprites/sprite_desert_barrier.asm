; ==============================================================================

; $02956D-$0295FB JUMP LOCATION
Sprite_DesertBarrier:
{
    JSR.w DesertBarrier_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : PHP : BCC .no_collision
        JSL.l Sprite_NullifyHookshotDrag
        JSL.l Sprite_RepelDashAttackLong
        
    .no_collision
    
    PLP
    
    LDA.w $0DF0, X : BNE .delay
        LDA.w $0D80, X : BMI .deactivated
            BNE .moving
                LDA.w $02F0 : BNE .activate

        .deactivated 
    .delay
    
    RTS
    
    .activate
    
    STA.w $0D80, X
    
    ; Initiate a delay for the next frame.
    LDA.b #$80 : STA.w $0DF0, X
    
    LDA.b #$07 : STA.w $012D
    
    .moving
    
    BCC .no_collision_2
        LDA.b $46 : BNE .no_collision_2
            LDA.b #$10 : STA.b $46
            
            LDA.b #$20
            
            JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
            LDA.b $01 : STA.b $28
            
            LDA.b $00 : STA.b $27
        
    .no_collision_2
    
    LDY.w $0DE0, X
    
    LDA.w Pool_Sprite_DesertBarrier_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Sprite_DesertBarrier_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    JSR.w Sprite2_CheckTileCollision : BEQ .no_collision
        LDY.w $0DE0, X
        
        ; Effects a counterclockwise adhesion to walls.
        LDA.w .next_direction, Y : STA.w $0DE0, X
        
    .no_collision
    
    LDA.b #$01 : STA.w $02E4
    
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$01 : BNE .skip_frame
        INC.w $0ED0, X : LDA.w $0ED0, X : CMP.b #$82 : BNE .dont_deactivate
            ; The barrier (and its cousins) have moved enough, time to deactivate.
            ; Love the hard codedness? I don't!
            LDA.b #$80 : STA.w $0D80, X
            
            STZ.w $02E4
        
        .dont_deactivate
    .skip_frame
    
    RTS
}

; ==============================================================================

; $0295FC-$029605 DATA
Pool_Sprite_DesertBarrier:
Pool_Sprite_ArmosKnight:
Pool_Sprite_Lanmolas:
{
    ; $0295FC
    .x_speeds ; Bleeds into the next block. Length 4.
    db $10, $F0
     
    ; $0295FE
    .y_speeds
    db $00, $00, $10, $F0
    
    ; $029602
    .next_direction
    db  3,  2,  0,  1
}

; $029606-$029625 DATA
DesertBarrier_Draw_subsprites:
{
    dw -8, -8 : db $8E, $00, $00, $02
    dw  8, -8 : db $8E, $40, $00, $02
    dw -8,  8 : db $AE, $00, $00, $02
    dw  8,  8 : db $AE, $40, $00, $02
}

; ==============================================================================

; $029626-$029669 LOCAL JUMP LOCATION
DesertBarrier_Draw:
{
    LDA.w $0DF0, X : CMP.b #$01 : BNE .no_sound_effect
        ; Play puzzle solved sound.
        LDY.b #$1B : STY.w $012F
        
        LDY.b #$05 : STY.w $012D
        
    .no_sound_effect
    
    LSR : AND.b #$01 : CLC : ADC.w $0FD8 : STA.w $0FD8
    
    JSR.w Sprite2_DirectionToFacePlayer
    
    LDA.b $0F : CLC : ADC.b #$20 : CMP.b #$40 : BCS .beta
        LDA.b $0E : CLC : ADC.b #$20 : CMP.b #$40 : BCS .beta
            LDA.b #$10 : JSL.l OAM_AllocateFromRegionB
        
    .beta
    
    REP #$20
    
    LDA.w #.subsprites : STA.b $08
    
    SEP #$20
    
    LDA.b #$04
    
    JMP Sprite_DrawMultipleRedundantCall
}

; ==============================================================================
