
; ==============================================================================

; $0F4AF4-$0F4B0B DATA
Pool_SpritePrep_BubbleGroup:
{
    ; $0F4AF4
    .x_offets_low
    db $0A, $14, $0A
    
    ; $0F4AF7
    .x_offsets_high
    db $00, $00, $00
    
    ; $0F4AFA
    .y_offets_low
    db $F6, $00, $0A
    
    ; $0F4AFD
    .y_offets_high
    db $FF, $00, $00
    
    ; $0F4B00
    .x_speeds
    db $12, $00, $EE
    
    ; $0F4B03
    .x_polarities
    db $01, $01, $00
    
    ; $0F4B06
    .y_speeds
    db $00, $12, $00
    
    ; $0F4B09
    .y_polarities
    db $00, $01, $01
}

; $0F4B0C-$0F4B8A LONG JUMP LOCATION
SpritePrep_BubbleGroup:
{
    LDA.w $0D10, X : SEC : SBC.b #$0A : STA.w $0D10, X
    LDA.w $0D30, X :       SBC.b #$00 : STA.w $0D30, X
    
    LDA.b #$EE : STA.w $0D40, X
    
    LDA.b #$00 : STA.w $0D50, X
    
    LDA.b #$00 : STA.w $0D90, X
    
    LDA.b #$00 : STA.w $0DA0, X
    
    LDA.b #$02 : STA.w $0FB5
    
    .attempt_next_spawn
    
        LDA.b #$82
        
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            PHX
            
            LDX.w $0FB5
            
            LDA.b $00 : CLC : ADC.l Pool_SpritePrep_BubbleGroup_x_offsets_low, X
            STA.w $0D10, Y

            LDA.b $01 :       ADC.l Pool_SpritePrep_BubbleGroup_x_offsets_high, X
            STA.w $0D30, Y
            
            LDA.b $02 : CLC : ADC.l Pool_SpritePrep_BubbleGroup_y_offsets_low, X
            STA.w $0D00, Y

            LDA.b $03 :       ADC.l Pool_SpritePrep_BubbleGroup_y_offsets_high, X
            STA.w $0D20, Y
            
            LDA.l Pool_SpritePrep_BubbleGroup_x_speeds, X : STA.w $0D50, Y
            
            LDA.l Pool_SpritePrep_BubbleGroup_y_speeds, X : STA.w $0D40, Y
            
            LDA.l Pool_SpritePrep_BubbleGroup_x_polarities, X : STA.w $0D90, Y
            
            LDA.l Pool_SpritePrep_BubbleGroup_y_polarities, X : STA.w $0DA0, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .attempt_next_spawn
    
    RTL
}

; ==============================================================================

; $0F4B8B-$0F4B96 DATA
Pool_Sprite_BubbleGroup:
{
    ; Not really sure what this would be fore. perhaps earlier draft
    ; data that was never removed for the direction control?
    ; $0F4B8B
    .unused
    db $00, $01, $00, $01
    
    ; Possibly hflip data?
    .unused2
    db $00, $00, $40, $40

    ; $0F4B93
    .speed_step
    db $01, $FF
    
    ; $0F4B95
    .speed_limit
    db $12, $EF
}

; $0F4B97-$0F4C01 JUMP LOCATION
Sprite_BubbleGroup:
{
    JSL.l Sprite_DrawFourAroundOne
    JSR.w Sprite3_CheckIfActive
    
    ; Seems to handle the... acceleration in x and y directions... curious.
    ; In other words, this is the logic that effects the circular motion
    ; the bubble group's members.
    LDA.w $0D90, X : AND.b #$01 : TAY
    
    LDA.w $0D50, X : CLC : ADC Pool_Sprite_BubbleGroup_speed_step, Y
    STA.w $0D50, X
    
    CMP Pool_Sprite_BubbleGroup_speed_limit, Y : BNE .dont_flip _x_speed_polarity
        INC.w $0D90, X
    
    .dont_flip_x_speed_polarity
    
    LDA.w $0DA0, X : AND.b #$01 : TAY
    
    LDA.w $0D40, X : CLC : ADC Pool_Sprite_BubbleGroup_speed_step, Y
    STA.w $0D40, X
    
    CMP .speed_step, Y : BNE .dont_flip_y_speed_polarity
        INC.w $0DA0, X
    
    .dont_flip_y_speed_polarity
    
    JSR.w Sprite3_Move
    
    LDA.w $0D50, X : BEQ .dont_disperse_yet
        LDA.w $0D40, X : BEQ .dont_disperse_yet
            JSL.l Sprite_CheckIfAllDefeated : BCC .dont_disperse_yet
                ; Change type to a normal bubble.
                LDA.b #$15 : STA.w $0E20, X
                
                ; Set their speeds as normal bubbles would be set.
                LDA.b #$10
                
                LDY.w $0D50, X : BPL .positive_x_speed
                    LDA.b #$F0
                
                .positive_x_speed
                
                STA.w $0D50, X
                
                LDA.b #$10
                
                LDY.w $0D40, X : BPL .positive_y_speed
                    LDA.b #$F0
                
                .positive_y_speed
                
                STA.w $0D40, X
            
    .dont_disperse_yet
    
    ; NOTE: This explains why the bubbles in this state can't be harmed.
    JSR.w Sprite3_CheckDamageToPlayer
    
    RTS
}

; ==============================================================================
