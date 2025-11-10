; ==============================================================================

; $0F7515-$0F7534 JUMP LOCATION
Sprite_DashApple:
{
    ; This is the apple sprite embedded in trees. Afaik, it starts off
    ; invisible, but will split into a random number of other apples when the 
    ; player bashes into a tree containing one of these.
    LDA.w $0D80, X : BNE Sprite_Apple
        ; NOTE:: The code that would set this variable low is not part of
        ; the sprite logic itself. Rather, it is done by the player code when
        ; the player actually hits something and bounces back.
        LDA.w $0E90, X : BNE .not_dashed_into_yet
            STZ.w $0DD0, X
            
            ; Spawn 2 to 5 apples.
            JSL.l GetRandomInt : AND.b #$03 : CLC : ADC.b #$02 : TAY
            
            .next_spawn_attempt
                
                PHY
                
                JSR.w Apple_SpawnTangibleApple
            PLY : DEY : BPL .next_spawn_attempt
            
        .not_dashed_into_yet
        
        RTS
}

; ==============================================================================

; $0F7535-$0F7579 LOCAL JUMP LOCATION
Apple_SpawnTangibleApple:
{
    LDA.b #$AC
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$01 : STA.w $0D80, Y
        
        LDA.b #$FF : STA.w $0D90, Y
        
        LDA.b #$08 : STA.w $0F70, Y
        
        LDA.b #$16 : STA.w $0F80, Y
        
        JSL.l GetRandomInt : STA.b $04
        LDA.b $01          : STA.b $05
        
        JSL.l GetRandomInt : STA.b $06
        LDA.b $03          : STA.b $07
        
        LDA.b #$0A
        JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, Y
        LDA.b $01 : STA.w $0D50, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F757A-$0F757B DATA
Sprite_Apple_speeds:
{
    db $FF, $01
}

; $0F757C-$0F7602 BRANCH LOCATION
Sprite_Apple:
{
    LDA.w $0D90, X : CMP.b #$10 : BCS .dont_blink
        LDA.b $1A : AND.b #$02 : BEQ .blink
    
    .dont_blink
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    .blink
    
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D90, X : BEQ .expired_so_self_terminate
        JSR.w Sprite3_MoveXyz
        
        JSR.w Sprite3_CheckDamageToPlayer : BCC .no_player_collision
            LDA.b #$0B
            JSL.l Sound_SetSFX3PanLong
            
            ; Fill in the player's life meter by 8 points (1 heart).
            LDA.l $7EF372 : CLC : ADC.b #$08 : STA.l $7EF372
            
    .expired_so_self_terminate
    
    STZ.w $0DD0, X
    
    RTS
    
    .no_player_collision
    
    LDA.b $1A : AND.b #$01 : BNE .delay_expiration_timer_tick
        DEC.w $0D90, X
    
    .delay_expiration_timer_tick
    
    LDA.w $0F70, X : DEC : BPL .aloft
        STZ.w $0F70, X
        
        LDA.w $0F80, X : BMI .hit_ground_this_frame
            LDA.b #$00
            
        .hit_ground_this_frame
        
        EOR.b #$FF : INC : LSR : STA.w $0F80, X
        
        LDA.w $0D50, X : BEQ .x_speed_at_rest
            PHA

            ; TODO: Wut?
            ASL
            
            LDA.b #$00 : ROL : TAY
            PLA : CLC : ADC.w .speeds, Y : STA.w $0D50, X
            
        .x_speed_at_rest
        
        LDA.w $0D40, X : BEQ .y_speed_at_rest
            PHA
            
            ; TODO: Wut?
            ASL
            
            LDA.b #$00 : ROL : TAY
            PLA : CLC : ADC.w .speeds, Y : STA.w $0D40, X
            
        .y_speed_at_rest
        
        RTS
    
    .aloft
    
    LDA.w $0F80, X : SEC : SBC.b #$01 : STA.w $0F80, X
    
    RTS
}

; ==============================================================================
