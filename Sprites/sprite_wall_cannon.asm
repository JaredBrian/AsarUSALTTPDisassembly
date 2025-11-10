; ==============================================================================

; $028084-$02808F DATA
Pool_Sprite_WallCannon:
{
    ; $028084
    .x_speeds
    db $00, $00
    
    ; $028086
    .y_speeds
    db $F0, $10
    
    ; $028088
    .animation_states
    db 0, 0, 2, 2
    
    ; $02808C
    .vh_flip
    db $40, $00, $00, $80
}

; Moving cannon ball shooters
; $028090-$028175 JUMP LOCATION
Sprite_WallCannon:
{
    LDY.w $0DE0, X
    
    LDA.w $0E10, X : CMP.b #$01
    
    LDA.w Pool_Sprite_WallCannon_animation_states, Y : ADC.b #$00 : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF
    ORA.w Pool_Sprite_WallCannon_vh_flip, Y : STA.w $0F50, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0DF0, X : BNE .direction_change_delay
        LDA.b #$80 : STA.w $0DF0, X
        
        LDA.w $0D90, X : EOR.b #$01 : STA.w $0D90, X
    
    .direction_change_delay
    
    LDY.w $0D90, X
    LDA.w Pool_Sprite_WallCannon_x_speeds, Y : STA.w $0D50, X
    LDA.w Pool_Sprite_WallCannon_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    TXA : ASL : ASL : CLC : ADC.b $1A : AND.b #$1F : BNE .dont_reset_firing_delay
        LDA.b #$10 : STA.w $0E10, X
    
    .dont_reset_firing_delay
    
    LDA.w $0E10, X : CMP.b #$01 : BEQ .possible_to_fire
        RTS
    
    .possible_to_fire
    
    LDA.w $0F00, X : BNE .inactive_sprite
        ; Spawn cannon ball.
        LDA.b #$6B
        LDY.b #$0D
        JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
            LDA.b #$07
            JSL.l Sound_SetSFX3PanLong
            
            LDA.b #$01 : STA.w $0DB0, Y
                         STA.w $0DC0, Y
            
            LDA.w $0DE0, X : PHX
                             TAX    
            LDA.b $00 : CLC : ADC.w .x_offsets_low, X  : STA.w $0D10, Y
            LDA.b $01       : ADC.w .x_offsets_high, X : STA.w $0D30, Y
            
            LDA.b $02 : CLC : ADC.w .y_offsets_low, X  : STA.w $0D00, Y
            LDA.b $03       : ADC.w .y_offsets_high, X : STA.w $0D20, Y
            
            LDA.w .cannonball_x_speeds, X : STA.w $0D50, Y
            LDA.w .cannonball_y_speeds, X : STA.w $0D40, Y
            
            LDA.w $0E40, Y : AND.b #$F0 : ORA.b #$01 : STA.w $0E40, Y
            
            LDA.w $0E60, Y : ORA.b #$47 : STA.w $0E60, Y
            LDA.w $0CAA, Y : ORA.b #$44 : STA.w $0CAA, Y
            
            LDA.b #$20 : STA.w $0DF0, Y
            
            PLX
        
        .spawn_failed
    .inactive_sprite
    
    RTS
    
    ; $02815D
    .x_offsets_low
    db 8, -8,  0,  0
    
    ; $028161
    .x_offsets_high
    db 0, -1,  0,  0
    
    ; $028165
    .y_offsets_low
    db 0,  0,  8, -8
    
    ; $028169
    .y_offsets_high
    db 0,  0,  0, -1
    
    ; $02816D
    .cannonball_x_speeds
    db 24, -24,   0,   0
    
    ; $028171
    .cannonball_y_speeds
    db  0,   0,  24, -24
}

; ==============================================================================
