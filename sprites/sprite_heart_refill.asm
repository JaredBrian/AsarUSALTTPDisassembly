; ==============================================================================
; $034EC0-$034F09 JUMP LOCATION
Sprite_HeartRefill:
{
    JSR.w Sprite_DrawTransientAbsorbable
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckAbsorptionByPlayer
    JSR.w Sprite_HandleDraggingByAncilla
    JSR.w Sprite_Move
    JSR.w Sprite_MoveAltitude
    
    LDA.w $0F70, X : BPL .no_ground_collision
        STZ.w $0F70, X
        
        INC.w $0D80, X
        
        STZ.w $0DC0, X
        
    .no_ground_collision
    
    LDA.w $0F50, X : AND.b #$BF : STA.w $0F50, X
    
    LDA.w $0D50, X : BMI .moving_left
        LDA.w $0F50, X : EOR.b #$40 : STA.w $0F50, X
        
    .moving_left
    
    LDA.w $0D80, X : CMP.b #$03 : BCC .ai_state_not_maxed
        ; NOTE: This ensures that we never run an AI handler that is beyond the
        ; given jump table. This is kind of good to do, but most components
        ; of this game do no such bound checking.
        LDA.b #$03
        
    .ai_state_not_maxed
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw HeartRefill_InitializeAscent ; 0x00 - $CF0A
    dw HeartRefill_BeginDescending  ; 0x01 - $CF20
    dw HeartRefill_GlideGroundward  ; 0x02 - $CF37
    dw HeartRefill_Grounded         ; 0x03 - $CF5A
}

; ==============================================================================

; $034F0A-$034F1F JUMP LOCATION
HeartRefill_InitializeAscent:
{
    INC.w $0D80, X
    
    LDA.b #$12 : STA.w $0DF0, X
    
    LDA.b #$14 : STA.w $0F80, X
    
    LDA.b #$01 : STA.w $0DC0, X
    
    STZ.w $0DE0, X
    
    RTS
}

; ==============================================================================

; $034F20-$034F34 JUMP LOCATION
HeartRefill_BeginDescending:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$FD : STA.w $0F80, X
        
        STZ.w $0D50, X
        
        RTS
        
    .delay
    
    DEC.w $0F80, X
    
    RTS
}

; ==============================================================================

; $034F35-$034F36 DATA
HeartRefill_GlideGroundward_speed:
{
    db 10, -10
}

; $034F37-$034F59 JUMP LOCATION
HeartRefill_GlideGroundward:
{
    LDA.w $0DF0, X : BNE .delay
        LDA.w $0DE0, X : AND.b #$01 : TAY
        
        LDA.w $0D50, X
        CLC : ADC.w Pool_Sprite_RedBari_rotation_speeds, Y : STA.w $0D50, X
            
        CMP.w .speed, Y : BNE .anoswitch_direction
            INC.w $0DE0, X
            
            LDA.b #$08 : STA.w $0DF0, X
            
        .anoswitch_direction
    .delay
    
    RTS
}

; ==============================================================================

; $034F5A-$034F5C JUMP LOCATION
HeartRefill_Grounded:
Sprite_Zero_XYZ_Velocity:
{
    STZ.w $0F80, X

    ; Bleeds into the next function.
}

; $034F5D-$034F63 JUMP LOCATION
Sprite_Zero_XY_Velocity:
{
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    RTS
}

; ==============================================================================
