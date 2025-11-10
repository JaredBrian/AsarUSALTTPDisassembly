; ==============================================================================

; $0EC8CC-$0EC8D7 DATA
Pool_Thief:
{
    ; $0EC8CC
    .standing_animation_states
    db $0B, $08, $02, $05
    
    ; $0EC8D0
    .watching_animation_states
    db $09, $06, $00, $03, $0A, $07, $01, $04
}

; ==============================================================================

; $0EC8D8-$0EC90D JUMP LOCATION
Sprite_Thief:
{
    JSL.l Thief_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckIfRecoiling
    JSL.l Sprite_CheckDamageFromPlayerLong
    
    LDA.w $0D80, X : CMP.b #$03 : BEQ .dont_reface_player
        JSR.w Sprite4_DirectionToFacePlayer : TYA : STA.w $0EB0, X
        EOR.w $0DE0, X : CMP.b #$01 : BNE .dont_reface_player
            TYA : STA.w $0DE0, X
        
    .dont_reface_player
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Thief_Loitering   ; 0x00 - $C90E
    dw Thief_WatchPlayer ; 0x01 - $C94C
    dw Thief_ChasePlayer ; 0x02 - $C985
    dw Thief_StealStuff  ; 0x03 - $C9DF
}

; ==============================================================================

; $0EC90E-$0EC94B JUMP LOCATION
Thief_Loitering:
{
    JSR.w Thief_CheckPlayerCollision
    
    LDA.w $0DF0, X : BNE .delay
        REP #$20
        
        LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0050 : CMP.w #$00A0 : BCS .player_not_close
            LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0050 : CMP.w #$00A0 : BCS .player_not_close
                SEP #$20
                
                INC.w $0D80, X
                
                LDA.b #$10 : STA.w $0DF0, X

        .player_not_close
    .delay
    
    SEP #$20
    
    LDY.w $0DE0, X
    LDA.w Thief_standing_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EC94C-$0EC965 JUMP LOCATION
Thief_WatchPlayer:
{
    JSR.w Thief_CheckPlayerCollision
    
    JSR.w Sprite4_DirectionToFacePlayer : TYA : STA.w $0EB0, X
                                                STA.w $0DE0, X
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
    
    .delay

    ; Bleeds into the next function.
}

; $0EC966-$0EC971 JUMP LOCATION
Thief_BodyTracksHead:
{
    LDA.b $1A : AND.b #$1F : BNE .dont_adjust_body
        LDA.w $0EB0, X : STA.w $0DE0, X
    
    .dont_adjust_body

    ; Bleeds into the next function.
}
    
; $0EC972-$0EC984 JUMP LOCATION
Thief_Animate:
{
    INC.w $0E80, X
    LDA.w $0E80, X : AND.b #$04 : ORA.w $0DE0, X : TAY
    LDA.w Thief_watching_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EC985-$0EC9DE JUMP LOCATION
Thief_ChasePlayer:
{
    LDA.b #$12
    JSL.l Sprite_ApplySpeedTowardsPlayerLong
    
    LDA.w $0E70, X : BNE .hit_tile
        JSR.w Sprite4_Move
    
    .hit_tile
    
    JSR.w Sprite4_CheckTileCollision
    
    LDA.w $0DF0, X : BNE .delay
        REP #$20
        
        LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0050
        CMP.w #$00A0 : BCS .player_not_close
            LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0050
            CMP.w #$00A0 : BCC .player_still_close
        
        .player_not_close
        
        SEP #$20
        
        STZ.w $0D80, X
        
        LDA.b #$80 : STA.w $0DF0, X
        
        .player_still_close
    .delay
    
    SEP #$20
    
    JSL.l Sprite_CheckDamageToPlayerLong : BCC .didnt_touch_player
        INC.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        JSR.w Thief_DislodgePlayerItems
        JSR.w Thief_MakeStealingStuffNoise
    
    .didnt_touch_player
    
    JSR.w Thief_BodyTracksHead
    
    RTS
}

; ==============================================================================

; $0EC9DF-$0ECA23 JUMP LOCATION
Thief_StealStuff:
{
    JSR.w Thief_CheckPlayerCollision
    JSR.w Thief_ScanForBooty
    
    PHY
    
    LDA.w $0DF0, X : BNE .delay_pursuit_of_booty
        JSR.w Thief_Animate
        
        LDA.w $0E70, X : BNE .tile_collision
            JSR.w Sprite4_Move
        
        .tile_collision
        
        JSR.w Sprite4_CheckTileCollision
        
        LDA.w $0EB0, X : STA.w $0DE0, X
    
    .delay_pursuit_of_booty
    
    PLY
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .delay_facing_towards_booty
        LDA.w $0D10, Y : STA.b $04
        LDA.w $0D30, Y : STA.b $05
        
        LDA.w $0D00, Y : STA.b $06
        LDA.w $0D20, Y : STA.b $07
        
        JSL.l Sprite_DirectionToFaceEntity
        
        TYA : STA.w $0EB0, X
    
    .delay_facing_towards_booty
    
    RTS
}

; ==============================================================================

; $0ECA24-$0ECA4B LOCAL JUMP LOCATION
Thief_ScanForBooty:
{
    LDY.b #$0F
    
    .next_sprite_slot
    
        LDA.w $0DD0, Y : BEQ .inactive_sprite_slot
            LDA.w $0E20, Y : CMP.b #$DC : BEQ .savory_booty
            CMP.b #$E1 : BEQ .savory_booty
            CMP.b #$D9 : BNE .unsavory_booty
                .savory_booty
                        
                PHY
                        
                JSR.w Thief_TrackDownBooty
                        
                PLY
                
                    RTS
                
            .unsavory_booty
        .inactive_sprite_slot
    
    DEY : BPL .next_sprite_slot
    
    ; Nothing to steal, go back to skulking.
    STZ.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $0ECA4C-$0ECA9D LOCAL JUMP LOCATION
Thief_TrackDownBooty:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .speed_adjustment_delay
        LDA.w $0D10, Y : STA.b $04
        LDA.w $0D30, Y : STA.b $05
        
        LDA.w $0D00, Y : STA.b $06
        LDA.w $0D20, Y : STA.b $07
        
        LDA.b #$13
        JSL.l Sprite_ProjectSpeedTowardsEntityLong
        
        LDA.b $00 : STA.w $0D40, X
        LDA.b $01 : STA.w $0D50, X
    
    .speed_adjustment_delay
    
    LDY.b #$0F
    
    .next_sprite_slot
    
        TYA : EOR.b $1A : AND.b #$03 : ORA.w $0F10, Y : BNE .delay_grab_attempt
            LDA.w $0DD0, Y : BEQ .inactive_sprite_slot
                LDA.w $0E20, Y : CMP.b #$DC : BEQ .savory_booty
                                 CMP.b #$E1 : BEQ .savory_booty
                                 CMP.b #$D9 : BNE .unsavory_booty
                    .savory_booty
                    
                    JSR.w Thief_AttemptBootyGrab
                    
                .unsavory_booty
            .inactive_sprite_slot
        .delay_grab_attempt
    DEY : BPL .next_sprite_slot
    
    RTS
}

; ==============================================================================

; $0ECA9E-$0ECAF1 LOCAL JUMP LOCATION
Thief_AttemptBootyGrab:
{
    LDA.w $0D10, Y : STA.b $04
    LDA.w $0D30, Y : STA.b $05
    
    LDA.w $0D00, Y : STA.b $06
    LDA.w $0D20, Y : STA.b $07
    
    REP #$20
    
    LDA.b $04 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0008 : CMP.w #$0010 : BCS .out_of_reach
        LDA.b $06 : SEC : SBC.w $0FDA : CLC : ADC.w #$000C : CMP.w #$0018 : BCS .out_of_reach
            SEP #$20
            
            LDA.b #$00 : STA.w $0DD0, Y
            
            PHX
            
            LDA.w $0E20, Y : SEC : SBC.b #$D8 : TAX
            LDA.l Sprite_HandleAbsorptionByPlayer_SFX, X
            JSL.l Sound_SetSFX3PanLong
            
            PLX
            
            LDA.b #$0E : STA.w $0DF0, X
        
    .out_of_reach
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0ECAF2-$0ECB1F LOCAL JUMP LOCATION
Thief_CheckPlayerCollision:
{
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong
    BCC Thief_MakeStealingStuffNoise_return
        ; Bumped player
        LDA.b #$20
        JSL.l Sprite_ProjectSpeedTowardsPlayerLong
        
        LDA.b $00  : STA.b $27
        EOR.b #$FF : STA.w $0F30, X
        
        LDA.b $01  : STA.b $28
        EOR.b #$FF : STA.w $0F40, X
        
        ; TODO: Figure out if this has any bearing on the player using a cape
        ; when being bumped into.
        LDA.b #$04 : STA.b $46
        
        LDA.b #$0C : STA.w $0EA0, X

        ; Bleeds into the next function.
}

; $0ECB19 ALTERNATE ENTRY POINT
Thief_MakeStealingStuffNoise:
{    
    LDA.b #$0B
    JSL.l Sound_SetSFX2PanLong
    
    .return
    
    RTS
}

; ==============================================================================

; $0ECB20-$0ECB2F DATA
Pool_Thief_DislodgePlayerItems:
{
    ; $0ECB20
    .x_speeds
    db   0,  24,  24,   0, -24, -24
    
    ; $0ECB26
    .y_speeds
    db -32, -16,  16,  32,  16, -16
    
    ; $0ECB2C
    .item_to_spawn
    db $D9, $E1, $DC, $D9        
}

; $0ECB30-$0ECBD5 LOCAL JUMP LOCATION
Thief_DislodgePlayerItems:
{
    LDA.b #$05 : STA.w $0FB5
    
    .dislodge_next_item
    
        JSL.l GetRandomInt : AND.b #$03 : STA.w $0FB6
        DEC : BEQ .target_arrows
            DEC : BEQ .target_bombs
                
                ; Otherwise target rupees.
                REP #$20
                
                LDA.l $7EF360
                
                SEP #$20
                
                BRA .test_quantity
            
        .target_arrows
        
        LDA.l $7EF377
        
        BRA .test_quantity
        
        .target_bombs
        
        LDA.l $7EF343
        
        .test_quantity
        
        BEQ .return
            LDY.w $0FB6
            LDA.w Pool_Thief_DislodgePlayerItems_item_to_spawn, Y
            
            LDY #$07
            JSL.l Sprite_SpawnDynamically_arbitrary : BMI .return
                LDA.w $0FB6 : DEC : BEQ .extract_arrow
                    DEC : BEQ .extract_bomb
                        REP #$20
                        
                        LDA.l $7EF360 : DEC : STA.l $7EF360
                        
                        SEP #$20
                        
                        BRA .spawn_extracted_item
                
                .extract_arrow
                
                LDA.l $7EF377 : DEC : STA.l $7EF377
                
                BRA .spawn_extracted_item
                
                .extract_bomb
                
                LDA.l $7EF343 : DEC : STA.l $7EF343
                
                .spawn_extracted_item
                
                LDA.b $22 : STA.w $0D10, Y
                LDA.b $23 : STA.w $0D30, Y
                
                LDA.b $20 : STA.w $0D00, Y
                LDA.b $21 : STA.w $0D20, Y
                
                LDA.b #$18 : STA.w $0F80, Y
                
                PHX
                
                LDX.w $0FB5
                LDA.w Pool_Thief_DislodgePlayerItems_x_speeds, X : STA.w $0D50, Y
                LDA.w Pool_Thief_DislodgePlayerItems_y_speeds, X : STA.w $0D40, Y
                
                PLX
                
                LDA.b #$20 : STA.w $0F10, Y
                LDA.b #$01 : STA.w $0EB0, Y
                LDA.b #$FF : STA.w $0B58, Y
                
                DEC.w $0FB5 : BMI .return
    JMP .dislodge_next_item
    
    .return
    
    RTS
}

; ==============================================================================

; $0ECBD6-$0ECC9D DATA
Pool_Thief_Draw:
{
    ; $0ECBD6
    .OAM_groups
    dw 0, -6 : db $00, $00, $00, $02
    dw 0,  0 : db $06, $00, $00, $02
    dw 0, -6 : db $00, $00, $00, $02
    dw 0,  0 : db $06, $40, $00, $02
    dw 0, -6 : db $00, $00, $00, $02
    dw 0,  0 : db $20, $00, $00, $02
    dw 0, -7 : db $04, $00, $00, $02
    dw 0,  0 : db $22, $00, $00, $02
    dw 0, -7 : db $04, $00, $00, $02
    dw 0,  0 : db $22, $40, $00, $02
    dw 0, -7 : db $04, $00, $00, $02
    dw 0,  0 : db $24, $00, $00, $02
    dw 0, -8 : db $02, $00, $00, $02
    dw 0,  0 : db $0A, $00, $00, $02
    dw 0, -7 : db $02, $00, $00, $02
    dw 0,  0 : db $0E, $00, $00, $02
    dw 0, -7 : db $02, $00, $00, $02
    dw 0,  0 : db $0A, $00, $00, $02
    dw 0, -8 : db $02, $40, $00, $02
    dw 0,  0 : db $0A, $40, $00, $02
    dw 0, -7 : db $02, $40, $00, $02
    dw 0,  0 : db $0E, $40, $00, $02
    dw 0, -7 : db $02, $40, $00, $02
    dw 0,  0 : db $0A, $40, $00, $02    
    
    ; $0ECC96
    .chr
    db $02, $02, $00, $00
    
    ; $0ECC9A
    .h_flip
    db $40, $00, $00, $00
}

; $0ECC9E-$0ECCDA LONG JUMP LOCATION
Thief_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$00 : XBA
    LDA.w $0DC0, X

    REP #$20
    ASL #4 : ADC.w #Pool_Thief_Draw_OAM_groups : STA.b $08
    SEP #$20
    
    LDA.b #$02
    JSR.w Sprite4_DrawMultiple
    
    ; TODO: Figure out if the label name accurately reflects the mechanism
    ; (blinking).
    LDA.w $0F00, X : BNE .dont_blink
        PHX
        
        LDA.w $0EB0, X : TAX
        LDA.w Pool_Thief_Draw_chr, X : LDY.b #$02 : STA.b ($90), Y
        
        INY
        LDA.b ($90), Y : AND.b #$BF : ORA.w Pool_Thief_Draw_h_flip, X : STA.b ($90), Y
        
        PLX
        
        JSL.l Sprite_DrawShadowLong
    
    .dont_blink
    
    PLB
    
    RTL
}

; ==============================================================================
