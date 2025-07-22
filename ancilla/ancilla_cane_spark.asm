; ==============================================================================

; $045A84-$045B23 DATA
Pool_Ancilla_InitialCaneSpark:
{
    ; $045A84
    .chr
    db $92, $FF, $FF, $FF
    db $8C, $8C, $8C, $8C
    db $D6, $D6, $D6, $D6
    db $93, $93, $93, $93
    
    ; $045A94
    .properties
    db $22, $FF, $FF, $FF
    db $22, $62, $A2, $E2
    db $24, $64, $A4, $E4
    db $22, $62, $A2, $E2
    
    ; $045AA4
    .y_offsets
    dw -4,  0,  0,  0
    dw -8, -8,  0,  0
    dw -8, -8,  0,  0
    dw -8, -8,  0,  0
    
    ; $045AC4
    .x_offsets
    dw -4,  0,  0,  0
    dw -8,  0, -8,  0
    dw -8,  0, -8,  0
    dw -8,  0, -8,  0
    
    ; $045AE4
    .player_relative_y_offsets
    dw  5,  0, -3, -6
    dw -8, -3, 12, 28
    dw  5,  0,  8, 16
    dw  5,  0,  8, 16
    
    ; $045B04
    .player_relative_x_offsets
    dw  3,   1,   0,   0
    dw 13,  16,  12,  12
    dw 24,   7,  -4, -10
    dw -8,   9,  22,  26
}

; $045B24-$045C0D JUMP LOCATION
Ancilla_InitialCaneSpark:
{
    LDA.b $11 : BNE .transmute_delay
        DEC.w $03B1, X : BPL .transmute_delay
            LDA.b #$01 : STA.w $03B1, X
            
            LDA.w $0C5E, X : INC : STA.w $0C5E, X
            CMP.b #$11 : BNE .transmute_delay
                BRL CaneSpark_TransmuteInitialToNormal
        
    .transmute_delay
    
    ; Apparently, do nothing for the first state.
    LDA.w $0C5E, X : BNE .active
        BRL .return
        
    .active
    
    LDA.b $2F : ASL : ASL : STA.b $00
    
    LDA.w $0300 : CMP.b #$02 : BNE .not_final_cast_pose
        TAY
        
        LDA.w $039F, X : DEC : BPL .not_final_chr_group
            ; Reset the delay for using the final player relative position.
            ; Thus, all frames after this should use this position if $0300 stays
            ; at state 0x02.
            LDA.b #$00
            LDY.b #$03
        
        .not_final_chr_group
        
        STA.w $039F, X
        
        TYA
    
    .not_final_cast_pose
    
    ASL : CLC : ADC.b $00 : TAY
    
    REP #$20
    
    LDA.w Pool_Ancilla_InitialCaneSpark_player_relative_y_offsets, Y
    CLC : ADC.b $20 : STA.b $00

    LDA.w Pool_Ancilla_InitialCaneSpark_player_relative_x_offsets, Y
    CLC : ADC.b $22 : STA.b $02
    
    SEP #$20
    
    LDA.b $00 : STA.w $0BFA, X
    LDA.b $01 : STA.w $0C0E, X
    
    LDA.b $02 : STA.w $0C04, X
    LDA.b $03 : STA.w $0C18, X
    
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $06
    LDA.b $02 : STA.b $08
    
    SEP #$20
    
    PHX
    
    STZ.b $0A
    
    ; If we branch here, chr group is 0x00.
    LDA.w $0C5E, X : DEC : AND.b #$0F : BEQ .use_first_chr_group
        CMP.b #$0F : BEQ .use_last_chr_group
            ; Chr group here is 0x01 or 0x02.
            AND.b #$01 : INC : STA.b $0A
            
            BRA .start_OAM_commit_loop
            
        .use_last_chr_group
        
        ; Chr group here is 0x03.
        LDA.b #$03 : STA.b $0A
    
        .start_OAM_commit_loop
    .use_first_chr_group
    
    LDA.b $0A : ASL : ASL : TAX
    
    LDY.b #$00 : STY.b $04
    
    .next_OAM_entry
    
        LDA.w Pool_Ancilla_InitialCaneSpark_chr, X : CMP.b #$FF : BEQ .skip_OAM_entry
            REP #$20
            
            PHX
            
            TXA : ASL : TAX
            LDA.b $06
            CLC : ADC Pool_Ancilla_InitialCaneSpark_y_offsets, X : STA.b $00

            LDA.b $08
            CLC : ADC Pool_Ancilla_InitialCaneSpark_x_offsets, X : STA.b $02
            
            PLX
            
            SEP #$20
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_Ancilla_InitialCaneSpark_chr, X : STA.b ($90), Y

            INY
            LDA.w Pool_Ancilla_InitialCaneSpark_properties, X
            AND.b #$CF : ORA.b $65 : STA.b ($90), Y

            INY : PHY
            TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
            
            ; All OAM entries are small for this guy.
            LDA.b #$00 : STA.b ($92), Y
            
            PLY
            
        .skip_OAM_entry
        
        INX
    INC.b $04
    LDA.b $04 : AND.b #$03 : BNE .next_OAM_entry
    
    PLX
    
    .return
    
    RTS
}

; ==============================================================================

; $045C0E-$045C20 DATA
Pool_CaneSpark_TransmuteInitialToNormal:
{
    ; $045C0E
    .initial_rotation_states
    db $34, $33, $32, $31
    db $16, $15, $14, $13
    db $2A, $29, $28, $27
    db $10, $0F, $0E, $0D
    
    ; $045C1E
    .mp_costs
    db 4, 2, 1
}

; $045C21-$045C6F LONG BRANCH LOCATION
CaneSpark_TransmuteInitialToNormal:
{
    LDA.b #$31 : STA.w $0C4A, X
    
    LDA.b $2F : ASL : TAY
    LDA.w Pool_CaneSpark_TransmuteInitialToNormal_initial_rotation_states+0, Y
    STA.l $7F5800

    LDA.w Pool_CaneSpark_TransmuteInitialToNormal_initial_rotation_states+1, Y
    STA.l $7F5801

    LDA.w Pool_CaneSpark_TransmuteInitialToNormal_initial_rotation_states+2, Y
    STA.l $7F5802

    LDA.w Pool_CaneSpark_TransmuteInitialToNormal_initial_rotation_states+3, Y
    STA.l $7F5803
    
    LDA.b #$17 : STA.w $03B1, X
    
    STZ.w $0394, X
    STZ.w $0C5E, X
    
    LDA.b #$08 : STA.w $039F, X
    
    STZ.w $0C54, X
    STZ.w $0385, X
    
    LDA.b #$02 : STA.w $03A4, X
    
    LDA.b #$15 : STA.w $0C68, X
    DEC        : STA.l $7F5808
    
    LDA.b #$30
    JSR.w Ancilla_DoSfx3_NearPlayer

    ; Bleeds into the next function.
}
    
; Cane of Byrna's spinning light.
; $045C70-$045DC4 LONG BRANCH LOCATION
Ancilla_CaneSpark:
{
    PHX
    
    ; Set palette property compoment.
    LDA.b #$02 : STA.b $73
    
    ; Make sure we're in the basic submodule.
    LDA.b $11 : BEQ .execute
        ; Just draw, don't execute any state changes.
        BRL .draw
        
    .execute
    
    LDA.w $0303 : CMP.b #$0D : BNE .self_terminate
        ; Make player invincible.
        LDA.b #$01 : STA.w $037B
        
        ; Delay counter. (waits 0x18 frames to deplete magic).
        DEC.w $03B1, X : LDA.w $03B1, X : BNE .maintain_invulnerability
            ; If this... timer has counted down. Reset it to one.
            LDA.b #$01 : STA.w $03B1, X
            
            ; Does player have normal, 1/2, or 1/4 consumption?
            LDA.l $7EF37B : TAY
            
            ; Table of magic depletion values for the cane effects.
            ; Depletions are every 0x18 frames.
            LDA.w .mp_costs, Y : STA.b $00
            
            ; Reduce magic by this amount.
            LDA.l $7EF36E : BEQ .self_terminate
                ; Would consuming that much magic would leave us in the red?
                SEC : SBC.b $00 : CMP.b #$80 : BCS .self_terminate
                    STA.b $00
                    DEC.w $0394, X : BPL .magic_depletion_delay
                        LDA.b #$17 : STA.w $0394, X
                        
                        LDA.b $00 : STA.l $7EF36E
                    
                    .magic_depletion_delay
                    
                    ; Check if Y button was pressed this frame.
                    ; Branch if it wasn't.
                    BIT.b $F4 : BVC .maintain_invulnerability
    
    .self_terminate
    
    PLX
    
    ; Make player vulnerable again.
    STZ.w $037B
    
    ; Self terminate this object.
    STZ.w $0C4A, X
    
    STZ.w $0373 ; Make it so Link takes no damage I guess.
    
    RTS
    
    .maintain_invulnerability
    
    LDA.w $0C54, X : CMP.b #$03 : BEQ .all_sparkles_visible
        LDY.b #$00
        
        INC.w $0C5E, X
        LDA.w $0C5E, X : CMP.b #$04 : BCC .not_all_visible
            LDY.b #$03
            
            BRA .set_new_visible_quantity
            
        .not_all_visible
        
        CMP.b #$02 : BNE .not_two_visible
            LDY.b #$01
            
        .not_two_visible
        
        CMP.b #$03 : BNE .not_three_visible
            LDY.b #$02
            
        .not_three_visible
        .set_new_visible_quantity
        
        TYA : STA.w $0C54, X
        
    .all_sparkles_visible
    
    DEC.w $03A4, X : BPL .draw
        LDA.b #$02 : STA.w $03A4, X
        
        ; Override to a different palette in this situation (blue?)
        LDA.b #$04 : STA.b $73
    
    .draw
    
    REP #$20
    
    LDA.b $24 : AND.w #$00FF : CMP.w #$0080 : BCC .no_player_altitude_sign_extend
        ORA.w #$FF00
    
    .no_player_altitude_sign_extend
    
    CMP.w #$FFFF : BNE .player_not_hitting_ground
        LDA.w #$0000
    
    .player_not_hitting_ground
    
    EOR.w #$FFFF : INC
    CLC : ADC.b $20 : CLC : ADC.w #$000C : STA.l $7F5810
    LDA.b $22       : CLC : ADC.w #$0008 : STA.l $7F580E
    
    SEP #$20
    
    LDA.w $0C68, X : BNE .SFX_delay
        LDA.b #$15 : STA.w $0C68, X
        
        LDA.b #$30
        JSR.w Ancilla_DoSfx3_NearPlayer
        
    .SFX_delay
    
    STX.b $74
    
    LDY.b #$00
    
    LDA.w $0C54, X : TAX
    
    .next_OAM_entry
    
        STX.b $72
        
        LDA.b $11 : BNE .dont_increment_sparkle_rotation
            LDA.l $7F5800, X : CLC : ADC.b #$03 : AND.b #$3F : STA.l $7F5800, X
        
        .dont_increment_sparkle_rotation
        
        PHX : PHY
        
        LDA.l $7F5808 : STA.b $08
        
        LDA.l $7F5800, X
        JSR.w Ancilla_GetRadialProjection

        JSL.l Sparkle_PrepOamCoordsFromRadialProjection
        
        PLY
        
        JSR.w Ancilla_SetOam_XY
        
        LDX.b $72
        LDA.w Pool_Ancilla_SpinSpark_spark_chr, X : STA.b ($90), Y

        INY
        LDA.b $73 : ORA.b $65 : STA.b ($90), Y

        INY : PHY
        TYA : SEC : SBC.b #$04 : LSR : LSR : TAY
        LDA.b #$00 : STA.b ($92), Y
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.b $E8 : STA.b $04
        LDA.b $02 : CLC : ADC.b $E2 : STA.b $06
        
        SEP #$20
        
        LDX.b $74
        LDA.b $04 : STA.w $0BFA, X
        LDA.b $05 : STA.w $0C0E, X
        
        LDA.b $06 : STA.w $0C04, X
        LDA.b $07 : STA.w $0C18, X
        
        STZ.w $0C72, X
        
        JSR.w Ancilla_CheckSpriteCollision
        
        PLY
    PLX : DEX : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
