; ==============================================================================

; $0F6B33-$0F6B3F JUMP LOCATION
Sprite_BullyAndBallGuy:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sprite_BallGuy             ; 0x00 - $EB40
    dw BallGuy_DrawDistressMarker ; 0x01 - $EC74 UNUSED: Just this entry.
    dw Sprite_Bully               ; 0x02 - $EC7C
}

; ==============================================================================

; $0F6B40-$0F6C30 JUMP LOCATION
Sprite_BallGuy:
{
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckIfActive
    JSR.w BallGuy_Dialogue
    
    LDA.w $0F50, X : AND.b #$7F : ORA.w $0EB0, X : STA.w $0F50, X
    
    JSR.w Sprite3_MoveXyz
    
    JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
        AND.b #$03 : BNE .horiz_tile_collision
            LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
            
            LDA.w $0E90, X : BEQ .not_kicked
                JSR.w BallGuy_PlayBounceNoise
                
                BRA .moving_on
                
            .not_kicked
        .horiz_tile_collision
        
        LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
        
        LDA.w $0E90, X : BEQ .not_kicked_2
            JSR.w BallGuy_PlayBounceNoise
        
        .not_kicked_2
    .no_tile_collision

    .moving_on
    
    DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .not_z_bouncing
        STZ.w $0F70, X
        
        LDA.w $0F80, X : EOR.b #$FF : INC : LSR : LSR : STA.w $0F80, X
        AND.b #$FC : BEQ .dont_play_SFX
            JSR.w BallGuy_PlayBounceNoise
        
        .dont_play_SFX
        
        JSR.w BallGuy_Friction
    
    .not_z_bouncing
    
    LDA.w $0E90, X : BNE .kicked_by_bully
        LDA.w $0EB0, X : BEQ .right_side_up
            JMP BallGuy_UpsideDown
        
        .right_side_up
        
        JSR.w BallGuy_DrawDistressMarker
        
        TXA    : EOR.b $1A  : PHA
        LSR #3 : AND.b #$01 : STA.w $0DC0, X
        
        PLA : AND.b #$3F : BNE .dont_pick_new_direction
            ; Put Ball Guy's new position somewhere in the vicinity of the
            ; player. That said, the low bytes are totally random, so it may not
            ; appear that way.
            JSL.l GetRandomInt : STA.b $04
            LDA.b $23          : STA.b $05
            
            JSL.l GetRandomInt : STA.b $06
            LDA.b $21          : STA.b $07
            
            LDA.b #$08
            JSL.l Sprite_ProjectSpeedTowardsEntityLong
            
            LDA.b $01 : STA.w $0DA0, X
            
            LDA.b $00 : STA.w $0D90, X
            BEQ .target_location_vertical
                LDA.w $0F50, X : ORA.b #$40 : STA.w $0F50, X
                
                LDA.w $0D50, X : LSR : AND.b #$40 : EOR.w $0F50, X : STA.w $0F50, X
                
            .target_location_vertical
        .dont_pick_new_direction
        
        LDA.w $0DA0, X : STA.w $0D50, X
        LDA.w $0D90, X : STA.w $0D40, X
        
        RTS
        
    .kicked_by_bully
    
    LDA.w $0D50, X : ORA.w $0D40, X : BNE .not_at_full_stop_yet
        STZ.w $0E90, X
        
        RTS
    
    .not_at_full_stop_yet
    
    TXA        : EOR.b $1A : PHA
    LSR : LSR : AND.b #$01 : STA.w $0DC0, X
    
    PLA : ASL : ASL : AND.b #$80 : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0F6C31-$0F6C4A ALTERNATE ENTRY POINT
BallGuy_UpsideDown:
{
    JSR.w BallGuy_DrawDistressMarker
    
    TXA : EOR.b $1A : BEQ .turn_right_side_up
        LSR : LSR : AND.b #$01 : STA.w $0DC0, X
        
        STZ.w $0D50, X
        STZ.w $0D40, X
        
        RTS
        
    .turn_right_side_up
    
    STZ.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0F6C4B-$0F6C4C DATA
BallGuy_Friction_rates:
{
    db $FE, $02
}

; $0F6C4D-$0F6C73 LOCAL JUMP LOCATION
BallGuy_Friction:
{
    LDA.w $0D50, X : BEQ .zero_x_velocity   
        PHA
        ASL : ROL : AND.b #$01 : TAY
        PLA : CLC : ADC.w .rates, Y : STA.w $0D50, X
    
    .zero_x_velocity
    
    LDA.w $0D40, X : BEQ .zero_y_velocity    
        PHA
        ASL : ROL : AND.b #$01 : TAY
        PLA : CLC : ADC.w .rates, Y : STA.w $0D40, X
    
    .zero_y_velocity
    
    RTS
}

; ==============================================================================

; $0F6C74-$0F6C7B JUMP LOCATION
BallGuy_DrawDistressMarker:
{
    JSR.w Sprite3_PrepOamCoord
    JSL.l Sprite_DrawDistressMarker
    
    RTS
}

; ==============================================================================

; $0F6C7C-$0F6CB1 JUMP LOCATION
Sprite_Bully:
{
    JSR.w Bully_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Bully_Dialogue
    JSR.w Sprite3_MoveXyz
    
    JSR.w Sprite3_CheckTileCollision : BEQ .no_tile_collision
        AND.b #$03 : BNE .horiz_tile_collision
            LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
            
            BRA .moving_on
            
        .horiz_tile_collision
        
        LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
        
    .no_tile_collision

    .moving_on
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Bully_ChaseBallGuy ; 0x00 - $ECB2
    dw Bully_KickBallGuy  ; 0x01 - $ED23
    dw Bully_Waiting      ; 0x02 - $ED55
}

; ==============================================================================

; Bully State 0
; $0F6CB2-$0F6D22 JUMP LOCATION
Bully_ChaseBallGuy:
{
    TXA : EOR.b $1A : PHA : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    PLA : AND.b #$1F : BNE .delay
        LDA.w $0EB0, X : TAY
        LDA.w $0D10, Y : STA.b $04
        LDA.w $0D30, Y : STA.b $05
        
        LDA.w $0D00, Y : STA.b $06
        LDA.w $0D20, Y : STA.b $07
        
        ; Makes the Bully go towards the Ball Guy.
        LDA.b #$0E
        JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, X
        
        LDA.b $01 : STA.w $0D50, X
        BEQ .dont_change_orientation
            LDA.w $0D50, X : ASL : ROL : AND.b #$01 : STA.w $0DE0, X
        
        .dont_change_orientation
    .delay
    
    LDA.w $0EB0, X : TAY
    LDA.w $0F70, Y : BNE .cant_kick
        LDA.w $0D10, X : SEC : SBC.w $0D10, Y : CLC : ADC.b #$08 : CMP.b #$10 : BCS .cant_kick
            LDA.w $0D00, X : SEC : SBC.w $0D00, Y : CLC : ADC.b #$08 : CMP.b #$10 : BCS .cant_kick
                INC.w $0D80, X
                
                JSR.w BallGuy_PlayBounceNoise
        
    .cant_kick
    
    RTS
}

; ==============================================================================

; $0F6D23-$0F6D54 JUMP LOCATION
Bully_KickBallGuy:
{
    INC.w $0D80, X
    
    LDA.w $0EB0, X : TAY
    
    ; Specifies Ball Guy's new velocity as being double that of the bully's
    ; when he kicks him. However, this isn't arithmetically safe I guess.
    LDA.w $0D50, X : ASL : STA.w $0D50, Y
    LDA.w $0D40, X : ASL : STA.w $0D40, Y
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    JSL.l GetRandomInt : AND.b #$1F : STA.w $0F80, Y
    
    LDA.b #$60 : STA.w $0DF0, X
    
    LDA.b #$01 : STA.w $0DC0, X
                 STA.w $0E90, Y
    
    RTS
}

; ==============================================================================

; $0F6D55-$0F6D5D JUMP LOCATION
Bully_Waiting:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F6D5E-$0F6D9D DATA
Pool_Bully_Draw_OAM_groups:
{
    dw 0, -7 : db $E0, $46, $00, $02
    dw 0,  0 : db $E2, $46, $00, $02
    
    dw 0, -7 : db $E0, $46, $00, $02
    dw 0,  0 : db $C4, $46, $00, $02
    
    dw 0, -7 : db $E0, $06, $00, $02
    dw 0,  0 : db $E2, $06, $00, $02
    
    dw 0, -7 : db $E0, $06, $00, $02
    dw 0,  0 : db $C4, $06, $00, $02
}

; $0F6D9E-$0F6DC1 LOCAL JUMP LOCATION
Bully_Draw:
{
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL : ADC.w $0DC0, X : ASL #4
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

; $0F6DC2-$0F6DC8 LOCAL JUMP LOCATION
BallGuy_PlayBounceNoise:
{
    LDA.b #$32
    JSL.l Sound_SetSfx3PanLong
    
    RTS
}

; ==============================================================================

; $0F6DC9-$0F6DE3 LONG JUMP LOCATION
BullyAndBallGuy_SpawnBully:
{
    LDA.b #$B9
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$02 : STA.w $0E80, Y
        
        ; Tells the Bully the index of the Ball Guy so he can harass him.
        TXA : STA.w $0EB0, Y
        
        LDA.b #$01 : STA.w $0BA0, Y
    
    .spawn_failed
    
    RTL
}

; ==============================================================================

; $0F6DE4-$0F6DE7 DATA
Pool_BallGuy_Dialogue:
{
    ; $0F6DE4
    .messages_low
    db $5B, $5C
    
    ; $0F6DE6
    .messages_high
    db $01, $01
}

; ==============================================================================

; $0F6DE8-$0F6E20 JUMP LOCATION
BallGuy_Dialogue:
{
    LDA.w $0F10, X : BNE .delay
        LDA.l $7EF357 : AND.b #$01 : TAY
        LDA.w .messages_low, Y        : XBA
        LDA.w .messages_high, Y : TAY : XBA
        JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
            ; BUG: um... usually you increment after doing this. Assuming for now
            ; that it's a bug unless some point to this is found.
            LDA.w $0D50, X : EOR.b #$FF : STA.w $0D50, X
            LDA.w $0D40, X : EOR.b #$FF : STA.w $0D40, X
            
            LDA.w $0E90, X : BEQ .dont_play_SFX
                JSR.w BallGuy_PlayBounceNoise
            
            .dont_play_SFX
            
            LDA.b #$40 : STA.w $0F10, X
            
        .didnt_speak
    .delay
    
    RTS
}

; ==============================================================================

; $0F6E21-$0F6E24 DATA
Pool_Bully_Dialogue:
{
    ; $0F6E21
    .messages_low
    db $5D, $5E
    
    ; $0F6E23
    .messages_high
    db $01, $01
}

; $0F6E25-$0F6E55 LOCAL JUMP LOCATION
Bully_Dialogue:
{
    LDA.w $0F10, X : BNE .delay
        LDA.l $7EF357 : AND.b #$01 : TAY
        LDA.w Pool_Bully_Dialogue_messages_low, Y        : XBA
        LDA.w Pool_Bully_Dialogue_messages_high, Y : TAY : XBA
        
        JSL.l Sprite_ShowMessageFromPlayerContact : BCC .didnt_speak
            LDA.w $0D50, X : EOR.b #$FF : STA.w $0D50, X
            LDA.w $0D40, X : EOR.b #$FF : STA.w $0D40, X
            
            LDA.b #$40 : STA.w $0F10, X
        
        .didnt_speak
    .delay
    
    RTS
}

; ==============================================================================
