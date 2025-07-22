; ==============================================================================

; $0410DC-$0410FB DATA
Pool_Ancilla_Boomerang:
{
    ; $0410DC
    .y_offsets
    dw -16,   6,   0,   0,  -8,   8,  -8,   8
    
    ; $0410E4
    .x_offsets
    dw   0,   0,  -8,   8,   8,   8,  -8,  -8
}

; $0410FC-$04123A JUMP LOCATION
Ancilla_Boomerang:
{
    LDY.b #$04
    
    .next_object_slot
    
        ; See if any "received item sprite" objects are active.
        LDA.w $0C4A, Y : CMP.b #$22 : BEQ .just_draw  
    DEY : BPL .next_object_slot
    
    ; See if we're not in a normal submodule.
    LDA.b $11 : BNE .just_draw
        ; Every 8 frames play the whirling sound effect of the boomerang.
        LDA.b $1A : AND.b #$07 : BNE .no_whirling_sound
            LDA.b #$09
            JSR.w Ancilla_DoSfx2
        
        .no_whirling_sound
        
        LDA.w $03B1, X : BNE .position_already_set
            LDA.b $3C : CMP.b #$09 : BCS .init_position
                LDA.w $0300 : BNE .init_position
                    ; Terminate the boomerang if Link turned into a rabbit.
                    LDA.w $02E0 : BNE .bunny_link
                        ; Terminate the boomerang if Link is in another special
                        ; state...?
                        LDA.b $4D : BEQ .just_draw

                    .bunny_link
                        
                    BRL Boomerang_SelfTerminate
        
    .just_draw
    
    BRL .draw
    
    .init_position
    
    LDA.w $03CF, X : TAY
    
    REP #$20
    
    LDA.b $20 : CLC : ADC.w #$0008 : CLC : ADC Pool_Ancilla_Boomerang_y_offsets, Y
    STA.b $00
    
    LDA.b $22 : CLC : ADC Pool_Ancilla_Boomerang_y_offsets, Y : STA.b $02
    
    SEP #$20
    
    LDA.b $00 : STA.w $0BFA, X
    LDA.b $01 : STA.w $0C0E, X
    
    LDA.b $02 : STA.w $0C04, X
    LDA.b $03 : STA.w $0C18, X
    
    INC.w $03B1, X
    
    .position_already_set
    
    ; 0 - Normal, 1 - Magic boomerang
    LDA.w $0394, X : BEQ .no_sparkle
        ; Generate a sparkle every other frame.
        LDA.b $1A : AND.b #$01 : BNE .no_sparkle
            PHX
            
            JSL.l AddSwordChargeSpark
            
            PLX
        
    .no_sparkle
    
    ; 0 - Moving away from Link, 1 - Moving towards Link
    LDA.w $0C5E, X : BEQ .move_away_from_link
        LDA.w $0380, X : BEQ .not_recovering_from_deceleration
            INC : STA.w $0380, X
        
        .not_recovering_from_deceleration
        
        REP #$20
        
        ; BUG: While probably mostly harmless... this writes a 16-bit value
        ; to an 8-bit location. Not a great thing to do!
        ; Cache the player's Y coordinate in a temporary variable.
        LDA.b $20 : STA.w $038A, X
        CLC : ADC.w #$0008 : STA.b $20
        
        SEP #$20
        
        LDA.w $03C5, X
        JSR.w Ancilla_ProjectSpeedTowardsPlayer
        
        JSL.l Boomerang_CheatWhenNoOnesLooking
        
        LDA.b $00 : STA.w $0C22, X
        LDA.b $01 : STA.w $0C2C, X
        
        REP #$20
        
        ; Restore the player's Y coordinate.
        LDA.w $038A, X : STA.b $20
        
        SEP #$20
    
    .move_away_from_link
    
    ; At rest in y axis.
    LDA.w $0C22, X : BEQ .y_speed_at_rest
        CLC : ADC.w $0380, X : STA.w $0C22, X
    
    .y_speed_at_rest
    
    JSR.w Ancilla_MoveVert
    
    ; At rest in x axis.
    LDA.w $0C2C, X : BEQ .x_speed_at_rest
        CLC : ADC.w $0380, X : STA.w $0C2C, X
    
    .x_speed_at_rest
    
    JSR.w Ancilla_MoveHoriz
    
    JSR.w Ancilla_CheckSpriteCollision
    
    LDY.b #$00 : BCC .no_sprite_collision
        ; Used to signify that there was a sprite collision in the code
        ; below.
        INY
        
    .no_sprite_collision
    
    LDA.w $0C5E, X : BNE .cant_reverse_seek_polarity_twice
        CPY.b #$01 : BEQ .reverse_seek_polarity
            JSR.w Ancilla_CheckTileCollision : BCC .no_tile_collision
                PHX
                
                JSL.l AddBoomerangWallHit
                
                PLX
                
                LDY.b #$06
                
                ; WTF: So only makes a different noise for the first key door?
                ; What happens when there are 2+ key doors in a room?
                LDA.w $03E4, X : CMP.b #$F0 : BEQ .not_key_door
                    LDY.b #$05
                    
                .not_key_door
                
                TYA
                JSR.w Ancilla_DoSfx2
                
                BRA .reverse_seek_polarity
                
            .no_tile_collision
            
            ; If the boomerang hits the edge of the screen it will also
            ; flip polarity and go back to the player.
            JSR.w Boomerang_CheckForScreenEdgeReversal : BCS .reverse_seek_polarity
                DEC.w $0C54, X
                LDA.w $0C54, X : BEQ .reverse_seek_polarity
                    CMP.b #$05 : BCS .draw
                        ; WTF: Is this an incomplete feature? Why is it
                        ; necessary to speed up on certain frames, and the
                        ; variable that controls this is not bounds checked in
                        ; any way.
                        DEC.w $0380, X
                        
                        BRA .draw
            
        .reverse_seek_polarity
        
        LDA.w $0C5E, X : EOR.b #$01 : STA.w $0C5E, X
        
        BRA .draw
    
    .cant_reverse_seek_polarity_twice
    
    LDA.w $0280, X : PHA
    LDA.w $0C7C, X : PHA
    
    STZ.w $0C7C, X
    
    JSR.w Ancilla_CheckTileCollision
    
    PLA : STA.w $0C7C, X
    PLA : STA.w $0280, X
    
    JSR.w Boomerang_SelfTerminateIfOffscreen
    
    .draw
    
    BRL Boomerang_Draw
}

; ==============================================================================

; $04123B-$041242 LONG JUMP LOCATION
Ancilla_CheckTileCollisionLong:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckTileCollision
    
    PLB
    
    RTL
}

; ==============================================================================

; $041243-$04124A LONG JUMP LOCATION
Ancilla_CheckTileCollision_Class2_Long:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckTileCollision_Class2
    
    PLB
    
    RTL
}

; ==============================================================================

; $04124B-$0412AA LOCAL JUMP LOCATION
Boomerang_CheckForScreenEdgeReversal:
{
    LDA.w $0BFA, X : STA.b $00
    LDA.w $0C0E, X : STA.b $01
    
    LDA.w $0C04, X : STA.b $02
    LDA.w $0C18, X : STA.b $03
    
    REP #$30
    
    LDY.w #$0000
    
    LDA.w $039D : AND.w #$0003 : BEQ .no_horizontal_component
        AND.w #$0001 : BEQ .leftward_throw
            LDY.w #$0010
        
        .leftward_throw
        
        TYA : CLC : ADC.b $02 : SEC : SBC.b $E2 : STA.b $02
        CMP.w #$0100 : BCS .reverse_direction
    
    .no_horizontal_component
    
    LDY.w #$0000
    
    LDA.w $039D : AND.w #$000C : BEQ .dont_reverse
        AND.w #$0004 : BEQ .upward_throw
            LDY.w #$0010
        
        .upward_throw
        
        TYA : CLC : ADC.b $00 : SEC : SBC.b $E8 : STA.b $00
        CMP.w #$00E2 : BCC .dont_reverse
            .reverse_direction
            
            SEP #$30
            
            SEC
            
            RTS
            
    .dont_reverse
    
    SEP #$30
    
    CLC
    
    RTS
}

; ==============================================================================

; $0412AB-$0412F4 LOCAL JUMP LOCATION
Boomerang_SelfTerminateIfOffscreen:
{
    LDA.w $0BFA, X : STA.b $04
    LDA.w $0C0E, X : STA.b $05
    
    LDA.w $0C04, X : STA.b $06
    LDA.w $0C18, X : STA.b $07
    
    REP #$20
    
    LDA.b $20 : CLC : ADC.w #$0018 : STA.b $00
    LDA.b $22 : CLC : ADC.w #$0010 : STA.b $02
    
    LDA.b $04 : CLC : ADC.w #$0008 : STA.b $04
    LDA.b $06 : CLC : ADC.w #$0008 : STA.b $06
    
    ; Self terminate if the boomerang is close enough to the player.
    LDA.b $04 : CMP.b $20 : BCC Boomerang_SelfTerminate_dont_self_terminate
                CMP.b $00 : BCS Boomerang_SelfTerminate_dont_self_terminate
        LDA.b $06 : CMP.b $22 : BCC Boomerang_SelfTerminate_dont_self_terminate
                    CMP.b $02 : BCS Boomerang_SelfTerminate_dont_self_terminate
            ; Bleeds into the next function.
}

; $0412F5-$041319 LOCAL JUMP LOCATION
Boomerang_SelfTerminate:
{
    SEP #$20
            
    STZ.w $0C4A, X
            
    STZ.w $035F
            
    LDA.w $0301 : AND.b #$80 : BEQ .not_in_throw_pose
        STZ.w $0301
            
        ; Cancel any further Y button input this frame.
        LDA.b $3A : AND.b #$BF : STA.b $3A
        AND.b #$80 : BNE .b_button_held
            ; Allow Link to change direction again.
            LDA.b $50 : AND.b #$FE : STA.b $50

        .b_button_held
    .not_in_throw_pose

    ; $041316 ALTERNATE ENTRY POINT
    .dont_self_terminate
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $04131A-$041337 DATA
Pool_Boomerang_Draw:
{
    ; $04131A
    .properties
    db $A4, $E4, $64, $24, $A2, $E2, $62, $22
    
    ; $041322
    .xy_offsets
    dw  2, -2
    dw  2,  2
    dw -2,  2
    dw -2, -2
    
    ; $041332
    .OAM_base
    dw $0180, $00D0
    
    ; $041336
    .rotation_speed
    db $03, $02
}

; $041338-$0413E7 LONG BRANCH LOCATION
Boomerang_Draw:
{
    JSR.w Ancilla_PrepOamCoord
    
    LDA.w $0C5E, X : BEQ .moving_away
        LDA.b $EE : STA.w $0C7C, X
                    TAY
        LDA.w Ancilla_PrepOamCoord_priority, Y : STA.b $65
        
    .moving_away
    
    LDA.w $0280, X : BEQ .normal_priority
        LDA.b #$30 : STA.b $65
        
    .normal_priority
    
    LDA.b $11 : BNE .leave_rotation_state_alone
        LDA.w $03B1, X : BEQ .leave_rotation_state_alone
            DEC.w $039F, X : BPL .leave_rotation_state_alone
                LDY.w $0394, X
                LDA.w Pool_Boomerang_Draw_rotation_speed, Y : STA.w $039F, X
                
                LDY.w $03A4, X
                
                ; The boomerang 'spins' in opposing directions depending on
                ; whether it was thrown to the left or to the right.
                LDA.w $03A9, X : BEQ .left_throw
                    DEY
                    
                    BRA .set_rotation_state
                    
                .left_throw
                
                INY
                
                .set_rotation_state
                
                ; Rotation state of the boomerang.
                TYA : AND.b #$03 : STA.w $03A4, X
    
    .leave_rotation_state_alone
    
    PHX
    
    LDA.w $0394, X : ASL : ASL : STA.b $72
    
    LDA.w $03A4, X : ASL : ASL : TAY
    
    REP #$20
    
    STZ.b $74
    
    ; The first entry in each interleaved pair is the y offset, the second
    ; being the x offset.
    LDA.w Pool_Boomerang_Draw_xy_offsets+0, Y : CLC : ADC.b $00 : STA.b $00
    LDA.w Pool_Boomerang_Draw_xy_offsets+2, Y : CLC : ADC.b $02 : STA.b $02
                                                                  STA.b $04
    
    LDA.w $03B1, X : AND.w #$00FF : BNE .use_general_OAM_base
        LDA.w $0FB3 : AND.w #$00FF : ASL : TAX
        LDA.w Pool_Boomerang_Draw_OAM_base, X : PHA
        LSR : LSR : CLC : ADC.w #$0A20 : STA.b $92
        
        PLA : CLC : ADC.w #$0800 : STA.b $90
    
    .use_general_OAM_base
    
    SEP #$20
    
    TYA : LSR : LSR : CLC : ADC.b $72 : TAX
    
    LDY.b #$00
    
    JSR.w Ancilla_SetSafeOam_XY
    
    LDA.b #$26 : STA.b ($90), Y
    
    INY
    LDA.w Pool_Boomerang_Draw_properties, X : AND.b #$CF : ORA.b $65 : STA.b ($90), Y
    
    LDA.b #$02 : ORA.b $75 : STA.b ($92)
    
    PLX
    
    RTS
}

; ==============================================================================
