
; ==============================================================================

; $044A85-$044A8B DATA
Pool_Ancilla_MilestoneItem:
    parallel Pool_Ancilla_ReceiveItem:
{
    .ether_medallion
    db $10
    
    .pendants
    db $37, $39, $38
    
    .heart_container
    db $26
    
    .bombos_medallion
    db $0F
    
    .crystal
    db $20
}

; ==============================================================================

; $044A8C-$044BE3 JUMP LOCATION
Ancilla_MilestoneItem:
{
    ; Routines for pendants waiting to be picked up in a room.
    
    ; Is it the Ether medallion?
    LDA.w $0C5E, X : CMP .ether_medallion  : BEQ .medallion
               CMP .bombos_medallion : BEQ .medallion
    ; Has the item in this room (usually pendant or crystal) already been obtained?
    ; Yes it has been obtained. Kill this pendant process.
    LDA.w $0403 : AND.b #$40 : BNE .terminate_item
        ; Has the boss been beaten and a heart piece collected?
        LDA.w $0403 : AND.b #$80 : BEQ .waitForEvent
            ; Delay timer?
            LDA.w $04C2  : BEQ .countDownDone
                CMP.b #$01 : BNE .countDownAndWait
                    ; Is it a crystal?
                    LDY.b #$23
                    
                    LDA.w $0C5E, X : CMP .crystal : BNE .not_crystal
                        LDA.b #$0F : STA.w $012D
                        
                        LDY.b #$28
                
                    .not_crystal
                    
                    TYA : STA $72
                        
                    PHX
                        
                    JSL.l GetAnimatedSpriteTile_variable
                        
                    PLX
                    
                .countDownAndWait
                    
                DEC.w $04C2
        
        .waitForEvent
        
        RTS
    
    .terminate_item
    
        STZ.w $0C4A, X
        
        RTS
    
    .medallion
    
    LDA.w $0394, X : BEQ .no_misc_palette_load
    DEC.w $0394, X
        
    RTS
    
    ; This code is executed when the item is just on the ground, laying there.
    .countDownDone
    
    LDA.w $039F, X : BNE .no_misc_palette_load
        LDA.w $0C5E, X : CMP .crystal : BNE .no_misc_palette_load
        
        ; yes it's a crystal
        LDA.b #$01 : STA.w $039F, X
        
        PHX
        
        LDA.b #$04 : STA.w $0AB1
        LDA.b #$02 : STA.w $0AA9
        
        JSL.l Palette_MiscSpr_justSP6
        
        INC $15
        
        PLX
    
    .no_misc_palette_load
    
    LDA.w $0C5E, X : CMP .crystal : BNE .dont_sparkle
    JSR.w Ancilla_AddSwordChargeSpark
    
    .dont_sparkle
    
    LDA $11 : BNE .draw
    ; If altitude >= 0x18 you can't grab it.
    LDA.w $029E, X : CMP.b #$18 : BCS .no_player_collision
        LDY.b #$02
        
        JSR.w Ancilla_CheckPlayerCollision : BCC .no_player_collision
            LDA.w $037E : BNE .no_player_collision
                LDA $4D : BNE .no_player_collision
                    STZ.w $0C4A, X
                    
                    ; Success, we've grabbed the item!
                    LDA $5D
                    
                    CMP.b #$19 : BEQ .receiving_medallion_player_mode
                        CMP.b #$1A : BNE .not_receiving_medallion
                            .receiving_medallion_player_mode
                
                            STZ.w $0112
                            STZ.w $03EF
                            
                            LDA.b #$00 : STA $5D
                
                    .not_receiving_medallion
                
                    ; Indicate that the item is from an object
                    LDA.b #$03 : STA.w $02E9
                    
                    PHX
                    
                    ; This will be the item to grant to Link.; 
                    ; Will get stored to $02D8 in the following routine.
                    TAY
                    
                    LDA.w $0C5E, X
                    
                    JSL.l Link_ReceiveItem
                    
                    PLX
                    
                    RTS
    
    .no_player_collision
    
    LDA.w $0C54, X : BEQ .hasnt_touched_ground
    CMP #$02 : BEQ .draw
    
    ; Simulate gravity.
    LDA.w $0294, X : SEC : SBC.b #$01 : STA.w $0294, X
    
    .hasnt_touched_ground
    
    JSR.w Ancilla_MoveAltitude
    
    LDA.w $029E, X : CMP.b #$F8 : BCC .draw
    ; It hit the ground, so make the object bounce upward a bit.
    INC.w $0C54, X
    
    LDA.b #$18 : STA.w $0294, X
    
    STZ.w $029E, X
    
    .draw
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : STA $72
    
    LDA $00 : STA $06 : SEC : SBC $72 : STA $00
    
    SEP #$20
    
    JSR.w Ancilla_ReceiveItem_draw
    
    PHX
    
    DEC.w $03B1, X : BPL .ripple_delay
    LDA.b #$09 : STA.w $03B1, X
    
    INC.w $0385, X : LDA.w $0385, X : CMP.b #$03 : BNE .not_ripple_reset
        STZ.w $0385, X
    
    .ripple_delay
    .not_ripple_reset
    
    LDA.w $0385, X : STA $72
    
    LDA.w $029E, X : CMP.b #$00 : BNE .above_ground
    LDX.b #$00
    
    LDA $A0 : CMP.b #$06 : BNE .not_water_room
        LDA $A1 : CMP.b #$00 : BNE .not_water_room
            LDA $72 : CLC : ADC.b #$04 : TAX
    
            BRA .draw_underside_sprite
    
    .above_ground
    
    LDX.b #$01
    
    CMP.b #$20 : BCC .draw_underside_sprite
    ; Use a small shadow if the object is higher than 32 pixels off the
    ; ground.
    INX
    
    .not_water_room
    .draw_underside_sprite
    
    REP #$20
    
    LDA $06 : CLC : ADC.w #$000C : STA $00
    
    SEP #$20
    
    LDA.b #$20 : STA $04
    
    JSR.w Ancilla_DrawShadow
    
    PLX
    
    RTS

}

; ==============================================================================
