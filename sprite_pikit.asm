; ==============================================================================

; $0F0BBF-$0F0BD7 JUMP LOCATION
Sprite_Pikit:
{
    JSR.w Pikit_PrepThenDraw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Pikit_SetNextVelocity      ; 0x00 - $8BDE
    dw Pikit_FinishJumpThenAttack ; 0x01 - $8C25
    dw Pikit_AttemptItemGrab      ; 0x02 - $8CE2
}

; ==============================================================================

; $0F0BD8-$0F0BDD DATA
Pool_Pikit_Data:
Pool_Sprite3_Shake:
{
    ; $0F0BD8
    .x_speeds ; Bleeds into the next block. Length 4.
    db $10, $F0
    
    ; $0F0BDA
    .y_speeds
    db $00, $00, $10, $F0
}

; $0F0BDE-$0F0C24 LOCAL JUMP LOCATION
Pikit_SetNextVelocity:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        INC.w $0DB0, X : LDA.w $0DB0, X : CMP.b #$04 : BNE .pick_random_direction
            STZ.w $0DB0, X
            
            JSR.w Sprite3_DirectionToFacePlayer
            
            BRA .set_speed
        
        .pick_random_direction
        
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        .set_speed
        
        LDA.w Pool_Pikit_Data_x_speeds, Y : STA.w $0D50, X
        
        LDA.w Pool_Pikit_Data_y_speeds, Y : STA.w $0D40, X
        
        JSL.l GetRandomInt : AND.b #$07 : ADC.b #$13 : STA.w $0F80, X
    
    .delay
    
    ; $0F0C16 ALTERNATE ENTRY POINT
    shared Pikit_Animate:
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F0C25-$0F0C71 JUMP LOCATION
Pikit_FinishJumpThenAttack:
{
    JSR.w Sprite3_MoveXyz
    JSR.w Sprite3_CheckTileCollision
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .in_air
        STZ.w $0F70, X
        
        STZ.w $0F80, X
        
        JSR.w Sprite3_DirectionToFacePlayer
        
        LDA.b $0E : CLC : ADC.b #$30 : CMP.b #$60 : BCS .dont_activate_tongue
            LDA.b $0F : CLC : ADC.b #$30 : CMP.b #$60 : BCS .dont_activate_tongue
                INC.w $0D80, X
                
                LDA.b #$1F
                
                JSL.l Sprite_ProjectSpeedTowardsPlayerLong
                
                JSL.l Sprite_ConvertVelocityToAngle : LSR : STA.w $0DE0, X
                
                LDA.b #$5F : STA.w $0DF0, X
                
                RTS
            
        .dont_activate_tongue
        
        STZ.w $0D80, X
        
        LDA.b #$10 : STA.w $0DF0, X
    
    .in_air
    
    BRA Pikit_Animate
}

; ==============================================================================

; $0F0C72-$0F0CE1 DATA
Pool_Pikit_AttemptItemGrab:
{
    ; $0F0C72
    .animation_states
    db $02, $02, $02, $02, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $02, $02, $02, $02
    
    ; $0F0C8A
    .pos
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $0C, $10, $18, $20, $20, $18, $10, $0C
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $F4, $F0, $E8, $E0, $E0, $E8, $F0, $F4
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    ; $0F0CD2
    .index_offset_x
    db $18, $18, $00, $30, $30, $30, $00, $18

    ; $0F0CDA
    .index_offset_y
    db $00, $18, $18, $18, $00, $30, $30, $30
}

; $0F0CE2-$0F0DC9 JUMP LOCATION
Pikit_AttemptItemGrab:
{
    LDA.w $0DF0, X : BNE .tongue_still_out
        STZ.w $0D80, X
        
        LDA.b #$10 : STA.w $0DF0, X
        
        STZ.w $0D90, X
        STZ.w $0DA0, X
        STZ.w $0ED0, X
        
        RTS
        
    .tongue_still_out
    
    LSR #2 : PHA : TAY
    
    LDA.w Pool_Pikit_AttemptItemGrab_animation_states, Y : STA.w $0DC0, X
    
    TYA
    
    LDY.w $0DE0, X : PHY
    
    CLC : ADC.w Pool_Pikit_AttemptItemGrab_index_offset_x, Y : TAY
    
    LDA.w Pool_Pikit_AttemptItemGrab_pos, Y : STA.w $0D90, X : STA.b $04
                                      STZ.b $05
    
    BPL .sign_extend_x_offset
    
    DEC.b $05
    
    .sign_extend_x_offset
    
    PLY
    
    PLA : CLC : ADC.w Pool_Pikit_AttemptItemGrab_index_offset_y, Y : TAY
    
    LDA.w Pool_Pikit_AttemptItemGrab_pos, Y : STA.w $0DA0, X : STA.b $06

    ; Two STZs in a row?
    STZ.b $07 : STZ.b $07
    
    BPL .sign_extend_y_offset
        DEC.b $07
    
    .sign_extend_y_offset
    
    LDA.w $0ED0, X : BNE .return
        REP #$20
        
        LDA.w $0FD8 : CLC : ADC.b $04 : SEC : SBC.b $22 : CLC : ADC.w #$000C
        CMP.w #$0018 : BCS .return
            LDA.w $0FDA : CLC : ADC.b $06 : SEC : SBC.b $20 : CLC : ADC.w #$000C
            CMP.w #$0020 : BCS .return
                SEP #$20
                
                LDA.w $0DF0, X : CMP.b #$2E : BCS .return
                    JSL.l Sound_SetSfxPanWithPlayerCoords
                    
                    ORA.b #$26 : STA.w $012E
                    
                    JSL.l GetRandomInt : AND.b #$03 : INC : STA.w $0ED0, X
                                                              STA.w $0E90, X
                    
                    CMP.b #$01 : BNE .not_hungry_for_bombs
                        LDA.l $7EF343 : BEQ .player_has_none
                            DEC : STA.l $7EF343
                            
                            RTS
                            
                        .player_has_none
                        .cant_take_that_item
                        
                        SEP #$20
                        
                        STZ.w $0ED0, X
                        
                        RTS
                    
                    .not_hungry_for_bombs
                    
                    CMP.b #$02 : BNE .not_wanting_arrows
                        LDA.l $7EF377 : BEQ .player_has_none
                            DEC : STA.l $7EF377
                            
                            RTS
                        
                    .not_wanting_arrows
                    
                    CMP.b #$03 : BNE .not_wanting_rupees
                    
                    REP #$20
                    
                    ; Pikit steals a rupee, if any are available.
                    LDA.l $7EF360 : BEQ .player_has_none
                        DEC : STA.l $7EF360
    
    .return
    
    SEP #$20
    
    RTS
    
    .not_wanting_rupees
    
    ; Can't take a shield Link doesn't have.
    LDA.l $7EF35A : STA.w $0E30, X : BEQ .player_has_none
        ; Can't take the Mirror Shield, thank Jebus.
        CMP.b #$03 : BEQ .cant_take_that_item
            ; Yo shield got took, asswipe.
            LDA.b #$00 : STA.l $7EF35A
            
            RTS
}

; ==============================================================================

; $0F0DCA-$0F0DD1 LOCAL JUMP LOCATION
Pikit_PrepThenDraw:
{
    JSR.w Sprite3_PrepOamCoord
    JSL.l Pikit_Draw
    
    RTS
}

; ==============================================================================
