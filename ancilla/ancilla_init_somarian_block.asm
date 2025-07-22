; ==============================================================================

; $046068-$046077 DATA
Pool_AddSomarianBlock:
{
    ; $046068
    .initial_collision_y_offsets
    dw -8, 31, 17, 17
    
    ; $046070
    .initial_collision_x_offsets
    dw  8,  8, -8, 23
}

; $046078-$046160 LONG JUMP LOCATION
AddSomarianBlock:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_Spawn : BCC .spawn_success
        BRL .spawn_failed
    
    .spawn_success
    
    PHX : STX.b $00
    
    LDX.b #$04
    
    .find_somarian_block_loop
    
        CPX.b $00 : BEQ .ignore_slot
            LDA.w $0C4A, X : CMP.b #$2C : BNE .not_somarian_block
                STX.b $02
                
                LDA.w $02EC : DEC : CMP.b $02 : BNE .not_closest_carryable_ancilla
                    ; Zero that index anyways so the player can't pick it up
                    ; (it's being terminated anyways).
                    STZ.w $02EC
                
                .not_closest_carryable_ancilla
                
                JSL.l AddSomarianBlockDivide
                
                PLX
                
                STZ.w $0C4A, X
                STZ.w $0646
                
                LDA.b $5E : CMP.b #$12 : BNE .dont_reset_player_speed
                    STZ.b $48
                    STZ.b $5E
                    
                .dont_reset_player_speed
                
                BRL .return
            
            .not_somarian_block
        .ignore_slot
    DEX : BPL .find_somarian_block_loop
    
    PLX
    
    LDA.b #$2A : JSR.w Ancilla_DoSfx3_NearPlayer
    
    STZ.w $0C54, X
    STZ.w $0C22, X
    STZ.w $0C2C, X
    STZ.w $0C5E, X
    STZ.w $03B1, X
    STZ.w $039F, X
    STZ.w $03A4, X
    STZ.w $03C5, X
    
    LDA.b #$0C : STA.w $0394, X
    LDA.b #$12 : STA.w $0C68, X
    
    STZ.w $0385, X
    STZ.w $029E, X
    STZ.w $0380, X
    STZ.w $03EA, X
    STZ.w $0BF0, X
    
    LDA.b #$09 : STA.w $03A9, X
    
    STZ.w $03D5, X
    
    LDA.b $2F : LSR : STA.w $0C72, X
    
    JSL.l Ancilla_CheckInitialTileCollision_Class2 : BCC .enough_space
        ; Basically, if the player is so close to a collision surface that
        ; the block could get embedded in a wall, just place it where the
        ; player actually is to be safe.
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #$0010 : STA.b $00
        LDA.b $22 : CLC : ADC.w #$0008 : STA.b $02
        
        SEP #$20
        
        LDA.b $00 : STA.w $0BFA, X
        LDA.b $01 : STA.w $0C0E, X
        
        LDA.b $02 : STA.w $0C04, X
        LDA.b $03 : STA.w $0C18, X
        
        BRA .return
    
    .enough_space
    
    LDY.b $2F
    
    LDA.b $20 : CLC : ADC Pool_AddSomarianBlock_initial_collision_y_offsets+0, Y
    STA.w $0BFA, X

    LDA.b $21 : ADC Pool_AddSomarianBlock_initial_collision_y_offsets+1, Y
    STA.w $0C0E, X
    
    LDA.b $22 : CLC : ADC Pool_AddSomarianBlock_initial_collision_x_offsets+0, Y
    STA.w $0C04, X

    LDA.b $23 : ADC Pool_AddSomarianBlock_initial_collision_y_offsets+1, Y
    STA.w $0C18, X
    
    JSR.w SomarianBlock_CheckForTransitLine
    
    BRA .return
    
    .spawn_failed
    
    LDX.b #$04 : JSL.l LinkItem_ReturnUnusedMagic
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $046161-$046190 DATA
Pool_SomarianBlock_CheckForTransitLine:
{
    ; $046161
    .y_offsets
    dw -16, -16, -16,  16,  16,  16
    dw  -8,   0,   8,  -8,   0,   8
    
    ; $046179
    .x_offsets
    dw  -8,   0,   8,  -8,   0,   8
    dw -16, -16, -16,  16,  16,  16
}

; $046191-$0461F8 LOCAL JUMP LOCATION
SomarianBlock_CheckForTransitLine:
{
    ; If there are no transit lines, we need not even worry about this.
    LDA.w $03F4 : BEQ .return
        LDY.b #$16
        
        .next_offset
            
            LDA.w $0BFA, X
            CLC : ADC Pool_SomarianBlock_CheckForTransitLine_y_offsets+0, Y
            STA.b $00 : STA.b $72

            LDA.w $0C0E, X
            ADC Pool_SomarianBlock_CheckForTransitLine_y_offsets+1, Y
            STA.b $01 : STA.b $73
            
            LDA.w $0C04, X
            CLC : ADC Pool_SomarianBlock_CheckForTransitLine_x_offsets+0, Y
            STA.b $02 : STA.b $74

            LDA.w $0C18, X
            ADC Pool_SomarianBlock_CheckForTransitLine_x_offsets+1, Y
            STA.b $03 : STA.b $75
            
            PHY
            
            LDA.w $0280, X : PHA
            
            JSR.w Ancilla_CheckTargetedTileCollision
            
            PLA : STA.w $0280, X
            
            PLY
            
            LDA.w $03E4, X : CMP.b #$B6 : BEQ .transit_node
                             CMP.b #$BC : BEQ .transit_node
        DEY : DEY : BPL .next_offset
        
        BRA .return
        
        .transit_node
        
        LDA.b $72 : STA.w $0BFA, X
        LDA.b $73 : STA.w $0C0E, X
        
        LDA.b $74 : STA.w $0C04, X
        LDA.b $75 : STA.w $0C18, X
        
        JSL.l AddSomarianPlatformPoof
    
    .return
    
    RTS
}

; ==============================================================================
