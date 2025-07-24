; ==============================================================================

; $0E8235-$0E826B JUMP LOCATION
Sprite_Fish:
{
    ; Check if if the right graphics are loaded to be able to draw.
    LDA.w $0FC6 : CMP.b #$03 : BCS .improper_GFX_pack_loaded
        JSR.w Fish_Draw
    
    .improper_GFX_pack_loaded
    
    LDA.w $0DD0, X : CMP.b #$0A : BNE .not_held_by_player
        ; Can only wriggle while being held.
        LDA.b #$04 : STA.w $0D80, X
        
        LDA.b $1A : LSR #3 : AND.b #$02 : LSR : ADC.b #$03 : STA.w $0DC0, X
        
    .not_held_by_player
    
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Fish_PreliminaryDeepWaterCheck ; 0x00 - $830F
    dw Fish_FlopAround                ; 0x01 - $8336
    dw Fish_PauseBeforeLeap           ; 0x02 - $827E
    dw Fish_Leaping                   ; 0x03 - $82A1
    dw Fish_Wriggle                   ; 0x04 - $826C
}

; ==============================================================================

; $0E826C-$0E827D JUMP LOCATION
Fish_Wriggle:
{
    LDA.w $0F70, X : BNE .aloft
        ; Go back to flopping when you hit the ground.
        LDA.b #$01 : STA.w $0D80, X
        
    .aloft
    
    JSR.w Sprite4_Move
    
    ; NOTE: It's what allows the fish to become grateful, as this is 
    ; the only way the player can become thanked. If the fish just flops
    ; itself into deep water, it won't thank you at all. And naturally you
    ; didn't really do as much as you could in that scenario anyway, now
    ; did you?
    JSL.l ThrownSprite_TileAndPeerInteractionLong
    
    RTS
}

; ==============================================================================

; $0E827E-$0E828A JUMP LOCATION
Fish_PauseBeforeLeap:
{
    LDA.w $0DF0, X : BNE Fish_SpawnSmallWaterSplash_delay
        ; Transition to leaping state.
        INC.w $0D80, X
        
        ; Determine the Z speed of the leap.
        LDA.b #$30 : STA.w $0F80, X

        ; Bleeds into the next function.
}

; $0E828B-$0E828F JUMP LOCATION
Fish_SpawnSmallWaterSplash:
{
    JSL.l Sprite_SpawnSmallWaterSplash
    
    ; $0E828F ALTERNATE ENTRY POINT
    .delay
    
    RTS
}

; ==============================================================================

; $0E8290-$0E82A0 DATA
Fish_Leaping_animation_states:
{
    db 5, 5, 6, 6, 5, 5, 4, 4
    db 3, 7, 7, 8, 8, 7, 7, 8
    db 8
}

; $0E82A1-$0E830E JUMP LOCATION
Fish_Leaping:
{
    JSR.w Sprite4_MoveAltitude
    
    DEC.w $0F80, X : DEC.w $0F80, X : BNE .still_ascending
        ; Recall that leaping fish are only grateful if they were on land
        ; and helped into water by a helpful little elf man or woman throwing
        ; them back in.
        LDY.w $0D90, X : BEQ .ungrateful
            LDA.b #$76 : STA.w $1CF0

            LDA.b #$01
            JSR.w Sprite4_ShowMessageMinimal
            
        .ungrateful
    .still_ascending
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        
        JSR.w Fish_SpawnSmallWaterSplash
        
        LDA.w $0D90, X : BEQ .no_rupees_for_you
            LDA.b #$DB
            JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
                JSL.l Sprite_SetSpawnedCoords
                
                LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
                LDA.b $01       : ADC.b #$00 : STA.w $0D30, Y
                
                LDA.b #$FF : STA.w $0B58, Y
                
                LDA.b #$30 : STA.w $0F80, Y
                             STA.w $0EE0, Y
                
                PHX
                
                TYX
                
                LDA.b #$10
                JSL.l Sprite_ApplySpeedTowardsPlayerLong
                
                PLX
                
            .spawn_failed
        .no_rupees_for_you
        
        STZ.w $0DD0, X
    
    .aloft
    
    INC.w $0E80, X
    LDA.w $0E80, X : LSR : LSR : TAY
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E830F-$0E8320 JUMP LOCATION
Fish_PreliminaryDeepWaterCheck:
{
    JSR.w Sprite4_CheckTileCollision
    
    LDA.w $0FA5 : CMP.b #$08 : BNE .not_deep_water
        ; Fell into deep water, time to skidaddle.
        STZ.w $0DD0, X
        
        RTS
        
    .not_deep_water
    
    ; Move on, otherwise.
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0E8321-$0E8335 DATA
Fish_FlopAround:
{
    ; $0E8321
    .x_speeds
    db   0,  12,  16,  12,   0, -12, -16, -12
    
    ; $0E8329
    .y_speeds
    db -16, -12,   0,  12,  16,  12,   0, -12
    
    ; $0E8331
    .boundary_limits
    db 2, 0
    
    ; $0E8333
    .animation_state_bases
    db 5, 1, 3
}

; $0E8336-$0E83B5 JUMP LOCATION
Fish_FlopAround:
{
    JSL.l Sprite_CheckIfLiftedPermissiveLong
    JSR.w Sprite4_BounceFromTileCollision
    JSR.w Sprite4_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        
        LDA.w $0FA5 : CMP.b #$09 : BEQ .touched_shallow_water
            CMP.b #$08 : BNE .didnt_touch_deep_water
                ; Time to swim with the fishes. (I.e. your brothers).
                STZ.w $0DD0, X
            
        .touched_shallow_water
        
        JSR.w Fish_SpawnSmallWaterSplash
        
        .didnt_touch_deep_water
        
        JSL.l GetRandomInt : AND.b #$0F : ADC.b #$10 : STA.w $0F80, X
        
        JSL.l GetRandomInt : AND.b #$07 : TAY
        LDA.w Fish_FlopAround_x_speeds, Y : STA.w $0D50, X
        LDA.w Fish_FlopAround_y_speeds, Y : STA.w $0D40, X
        
        INC.w $0DE0, X
        
        LDA.b #$03 : STA.w $0E80, X
    
    .aloft
    
    INC.w $0E80, X
    
    ; Note: The way they simulate a flopping fish is quite impressive.
    ; Just kind of... awed by it. It could be more detailed but it's
    ; pretty good the way it is.
    LDA.w $0E80, X : AND.b #$07 : BNE .delay_animation_base_adjustment
        ; Note: The index for the animation fluctates between 0 and 2 inclusive.
        LDA.w $0DE0, X : AND.b #$01 : TAY
        LDA.w $0D90, X : CMP Fish_FlopAround_boundary_limits, Y : BEQ .at_boundary_already
            CLC : ADC Sprite_ApplyConveyorAdjustment_x_shake_values, Y
            STA.w $0D90, X
            
        .at_boundary_already
    .delay_animation_base_adjustment
    
    LDA.b $1A : LSR #3 : AND.b #$01
    LDY.w $0D90, X
    CLC : ADC Fish_FlopAround_animation_state_bases, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E83B6-$0E847D POOL
Pool_Fish_Draw:
{
    ; $0E83B6
    .OAM_groups
    dw -4,  8 : db $5E, $04, $00, $00
    dw  4,  8 : db $5F, $04, $00, $00
    
    dw -4,  8 : db $5E, $84, $00, $00
    dw  4,  8 : db $5F, $84, $00, $00
    
    dw -4,  8 : db $5F, $44, $00, $00
    dw  4,  8 : db $5E, $44, $00, $00
    
    dw -4,  8 : db $5F, $C4, $00, $00
    dw  4,  8 : db $5E, $C4, $00, $00
    
    dw  0,  0 : db $61, $04, $00, $00
    dw  0,  8 : db $71, $04, $00, $00
    
    dw  0,  0 : db $61, $44, $00, $00
    dw  0,  8 : db $71, $44, $00, $00
    
    dw  0,  0 : db $71, $84, $00, $00
    dw  0,  8 : db $61, $84, $00, $00
    
    dw  0,  0 : db $71, $C4, $00, $00
    dw  0,  8 : db $61, $C4, $00, $00
    
    ; $0E8436
    .shadow_OAM_groups
    dw -2, 11 : db $38, $04, $00, $00
    dw  0, 11 : db $38, $04, $00, $00
    dw  2, 11 : db $38, $04, $00, $00
    
    dw -1, 11 : db $38, $04, $00, $00
    dw  0, 11 : db $38, $04, $00, $00
    dw  1, 11 : db $38, $04, $00, $00
    
    dw  0, 11 : db $38, $04, $00, $00
    dw  0, 11 : db $38, $04, $00, $00
    dw  0, 11 : db $38, $04, $00, $00
}

; $0E847E-$0E8482 LOCAL JUMP LOCATION
DontDrawFloppingFish:
{
    JSL.l Sprite_PrepOamCoordLong
    
    RTS
}

; $0E8483-$0E84F0 LOCAL JUMP LOCATION
Fish_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : BEQ DontDrawFloppingFish
        DEC
        
        REP #$20
        
        ASL #4 : ADC.w #(Pool_Fish_Draw_OAM_groups) : STA.b $08
        
        LDA.w $0FD8 : CLC : ADC.w #$0004 : STA.w $0FD8
        
        SEP #$20
        
        LDA.b #$02
        JSL.l Sprite_DrawMultiple
        
        LDA.w $0FDA : CLC : ADC.w $0F70, X : STA.w $0FDA
        LDA.w $0FDB       : ADC.b #$00     : STA.w $0FDB
        
        LDA.b #$00 : XBA
        LDA.w $0F70, X : LSR : LSR : CMP.b #$02 : BCC .shadow_OAM_groups
            ; Use the smallest shadow OAM group if the sprite is way up.
            LDA.b #$02
        
        .shadow_OAM_groups
        
        REP #$20
        
        ASL #3 : STA.b $00 : ASL : ADC.b $00
        ADC.w #Pool_Fish_Draw_shadow_OAM_groups : STA.b $08
        
        LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
        
        INC.b $92 : INC.b $92
        
        SEP #$20
        
        LDA.b #$03
        JSL.l Sprite_DrawMultiple
        
        JSL.l Sprite_Get_16_bit_CoordsLong
        
        RTS
}

; ==============================================================================
