; ==============================================================================

; Note: It's well known among glitchers that beating a boss from one
; dungeon when having entered a different dungeon can cause the ether
; medallion to fall instead of the proper item for that boss. This is
; due to the fact that the same object is used for granting the Bombos
; and Ether medallions (from the sky in that case.) The game just gets
; confused.

; $044A85-$044A8B DATA
Pool_Ancilla_ReceiveItem:
Pool_Ancilla_MilestoneItem:
{
    ; $044A85
    .ether_medallion
    db $10
    
    ; $044A86
    .pendants
    db $37, $39, $38
    
    ; $044A89
    .heart_container
    db $26
    
    ; $044A8A
    .bombos_medallion
    db $0F
    
    ; $044A8B
    .crystal
    db $20
}

; Routines for pendants waiting to be picked up in a room.
; $044A8C-$044BE3 JUMP LOCATION
Ancilla_MilestoneItem:
{
    ; Is it the Ether medallion?
    LDA.w $0C5E, X : CMP .ether_medallion  : BEQ .medallion
                     CMP .bombos_medallion : BEQ .medallion
        ; Has the item in this room (usually pendant or crystal) already been
        ; obtained?
        LDA.w $0403 : AND.b #$40 : BNE .terminate_item
            ; Has the boss been beaten and a heart piece collected?
            LDA.w $0403 : AND.b #$80 : BEQ .waitForEvent
                ; Delay timer?
                LDA.w $04C2 : BEQ .countDownDone
                    CMP.b #$01 : BNE .countDownAndWait
                        ; Is it a crystal?
                        LDY.b #$23
                        
                        LDA.w $0C5E, X : CMP .crystal : BNE .not_crystal
                            LDA.b #$0F : STA.w $012D
                            
                            LDY.b #$28
                    
                        .not_crystal
                        
                        TYA : STA.b $72
                            
                        PHX
                            
                        JSL.l GetAnimatedSpriteTile_variable
                            
                        PLX
                        
                    .countDownAndWait
                        
                    DEC.w $04C2
            
            .waitForEvent
            
            RTS
        
        .terminate_item

        ; Yes it has been obtained. Kill this pendant process.
        
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
            ; Yes it's a crystal.
            LDA.b #$01 : STA.w $039F, X
            
            PHX
            
            LDA.b #$04 : STA.w $0AB1
            LDA.b #$02 : STA.w $0AA9
            
            JSL.l Palette_MiscSpr_justSP6
            
            INC.b $15
            
            PLX
    
    .no_misc_palette_load
    
    LDA.w $0C5E, X : CMP .crystal : BNE .dont_sparkle
        JSR.w Ancilla_AddSwordChargeSpark
    
    .dont_sparkle
    
    LDA.b $11 : BNE .draw
        ; If altitude >= 0x18 you can't grab it.
        LDA.w $029E, X : CMP.b #$18 : BCS .no_player_collision
            LDY.b #$02
            
            JSR.w Ancilla_CheckPlayerCollision : BCC .no_player_collision
                LDA.w $037E : BNE .no_player_collision
                    LDA.b $4D : BNE .no_player_collision
                        STZ.w $0C4A, X
                        
                        ; Success, we've grabbed the item!
                        LDA.b $5D
                        
                        CMP.b #$19 : BEQ .receiving_medallion_player_mode
                            CMP.b #$1A : BNE .not_receiving_medallion
                                .receiving_medallion_player_mode
                    
                                STZ.w $0112
                                STZ.w $03EF
                                
                                LDA.b #$00 : STA.b $5D
                    
                        .not_receiving_medallion
                    
                        ; Indicate that the item is from an object.
                        LDA.b #$03 : STA.w $02E9
                        
                        PHX
                        
                        ; This will be the item to grant to Link.
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
    
    LDA.w $029E, X : AND.w #$00FF : STA.b $72
    
    LDA.b $00 : STA.b $06 : SEC : SBC.b $72 : STA.b $00
    
    SEP #$20
    
    JSR.w Ancilla_ReceiveItem_draw
    
    PHX
    
    DEC.w $03B1, X : BPL .ripple_delay
        LDA.b #$09 : STA.w $03B1, X
        
        INC.w $0385, X : LDA.w $0385, X : CMP.b #$03 : BNE .not_ripple_reset
            STZ.w $0385, X

        .not_ripple_reset
    .ripple_delay
    
    LDA.w $0385, X : STA.b $72
    
    LDA.w $029E, X : CMP.b #$00 : BNE .above_ground
        LDX.b #$00
        
        LDA.b $A0 : CMP.b #$06 : BNE .not_water_room
            LDA.b $A1 : CMP.b #$00 : BNE .not_water_room
                LDA.b $72 : CLC : ADC.b #$04 : TAX
        
                BRA .draw_underside_sprite
    
    .above_ground
    
    LDX.b #$01
    
    CMP.b #$20 : BCC .draw_underside_sprite
        ; Use a small shadow if the object is higher than 32 pixels off the
        ; ground.
        INX
        
    .draw_underside_sprite

    .not_water_room
    
    REP #$20
    
    LDA.b $06 : CLC : ADC.w #$000C : STA.b $00
    
    SEP #$20
    
    LDA.b #$20 : STA.b $04
    
    JSR.w Ancilla_DrawShadow
    
    PLX
    
    RTS

}

; ==============================================================================
