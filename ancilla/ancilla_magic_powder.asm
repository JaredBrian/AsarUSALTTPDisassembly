; ==============================================================================

; $0438F4-$043AAF DATA
Pool_Ancilla_MagicPowder:
{
    ; $0438F4
    .animation_groups
    db 13, 14, 15,  0,  1,  2,  3,  4,  5,  6
    db 10, 11, 12,  0,  1,  2,  3,  4,  5,  6
    db 16, 17, 18,  0,  1,  2,  3,  4,  5,  6
    db  7,  8,  9,  0,  1,  2,  3,  4,  5,  6
    
    ; $04391C
    .animation_group_offsets
    db 0, 10, 20, 30
    
    ; $043920
    .y_offsets
    dw -20, -15, -13,  -7
    dw -18, -13, -13, -13
    dw -20, -13, -13,  -8
    dw -20, -13, -13,  -8
    dw -19, -12, -12,  -7
    dw -18, -11, -11,  -6
    dw -17, -10, -10,  -5
    dw -16, -14, -12,  -9
    dw -17, -14, -12,  -8
    dw -18, -14, -13,  -6
    dw -33, -31, -29, -26
    dw -28, -25, -23, -19
    dw -22, -18, -17, -10
    dw  -2,   0,   2,   5
    dw  -9,  -6,  -4,   0
    dw -16, -12, -11,  -4
    dw -16, -14, -12,  -9
    dw -17, -14, -12,  -8
    dw -18, -14, -13,  -6
    
    ; $0439B8
    .x_offsets
    dw  -5, -12,   2,  -9
    dw  -7, -10,  -6,  -2
    dw  -6, -12,   1,  -6
    dw  -6, -12,   1,  -6
    dw  -6, -12,   1,  -6
    dw  -6, -12,   1,  -6
    dw  -6, -12,   1,  -6
    dw -17, -23, -14, -19
    dw -11, -18,  -9, -13
    dw  -4, -13,  -1,  -8
    dw  -3,  -9,   0,  -5
    dw  -3, -10,  -1,  -5
    dw  -4, -13,  -1,  -8
    dw  -3,  -9,   0,  -5
    dw  -3, -10,  -1,  -5
    dw  -3, -13,  -1,  -8
    dw   9,  15,   6,  11
    dw   3,  10,   1,   5
    dw  -4,   5,  -7,   0
    
    ; $043A50
    .chr
    db $09, $0A, $0A, $09
    db $09, $09, $09, $09
    db $09, $09, $09, $09
    db $09, $09, $09, $09
    db $09, $09, $09, $09
    
    ; $043A64
    .properties
    db $68, $24, $A2, $28
    db $68, $E2, $28, $A4
    db $68, $E2, $A4, $28
    db $22, $A4, $E8, $62
    db $24, $A8, $E2, $64
    db $28, $A2, $E4, $68
    db $22, $A4, $E8, $62
    db $E2, $A4, $E8, $64
    db $E8, $A8, $E4, $62
    db $E4, $A8, $E2, $68
    db $E2, $A4, $E8, $64
    db $E8, $A8, $E4, $62
    db $E4, $A8, $E2, $68
    db $E2, $A4, $E8, $64
    db $E8, $A8, $E4, $62
    db $E4, $A8, $E2, $68
    db $E2, $A4, $E8, $64
    db $E8, $A8, $E4, $62
    db $E4, $A8, $E2, $68
}

; $043AB0-$043AEA JUMP LOCATION
Ancilla_MagicPowder:
{
    LDA $11 : BNE .just_draw
        JSR.w MagicPowder_ApplySpriteDamage
        
        DEC.w $03B1, X : BPL .just_draw
            LDA.b #$01 : STA.w $03B1, X
            
            LDY.w $0C72, X
            LDA.w Pool_Ancilla_MagicPowder_animation_group_offsets, Y : STA $00
            
            LDA.w $0C5E, X : INC : CMP.b #$0A : BNE .dont_self_terminate
                STZ.w $0C4A, X
                
                STZ.w $0333
                
                RTS
            
            .dont_self_terminate
            
            STA.w $0C5E, X
            
            CLC : ADC $00 : TAY
            LDA.w Pool_Ancilla_MagicPowder_animation_groups, Y : STA.w $03C2, X
    
    .just_draw
    
    LDA.w $0C90, X
    JSR.w Ancilla_AllocateOam_B_or_E
    
    ; Bleeds into the next function.
}

; $043AEB-$043B57 JUMP LOCATION
MagicPowder_Draw:
{
    JSR.w Ancilla_PrepOamCoord
    
    PHX
    
    LDA $00 : STA $06
    LDA $01 : STA $07
    
    LDA $02 : STA $08
    LDA $03 : STA $09
    
    LDA.w $03C2, X : STA $0C
    
    ASL #2 : STA $0A
    
    ASL : STA $04
    
    ; Committing 4 sprite entries.
    ; OPTIMIZE: use direct page instead.
    LDA.b #$03 : STA.w $0072
    
    LDY.b #$00
    
    .next_OAM_entry
    
        LDX $04
        
        REP #$20
        
        LDA $06 : CLC : ADC Pool_Ancilla_MagicPowder_y_offsets, X : STA $00
        LDA $08 : CLC : ADC Pool_Ancilla_MagicPowder_x_offsets, X : STA $02
        
        SEP #$20
        
        JSR.w Ancilla_SetOam_XY
        
        LDX $0C
        
        LDA.w Pool_Ancilla_MagicPowder_chr, X : STA ($90), Y
        INY
        
        LDX $0A
        
        ; TODO: Confirm this.
        ; BUG:(maybe) Is it possible that the game will read past the end of
        ; this array into the proceeding code?
        LDA.w Pool_Ancilla_MagicPowder_properties, X
        AND.b #$CF : ORA $65 : STA ($90), Y
        INY
        
        PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        PLY
        
        INC $04 : INC $04
        
        INC $0A
    DEC $72 : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================

; $043B58-$043BBB LOCAL JUMP LOCATION
MagicPowder_ApplySpriteDamage:
{
    LDY.b #$0F
    
    .next_sprite
    
        TYA : EOR $1A : AND.b #$03 : BNE .no_collision
            LDA.w $0DD0, Y : CMP.b #$09 : BNE .no_collision
                LDA.w $0CD2, Y : AND.b #$20 : BNE .no_collision
                    JSR.w Ancilla_SetupBasicHitBox
                    
                    PHY : PHX
                    
                    TYX
                    
                    JSL.l Sprite_SetupHitBoxLong
                    
                    PLX : PLY
                    
                    JSL.l Utility_CheckIfHitBoxesOverlapLong : BCC .no_collision
                        LDA.w $0E20, Y : CMP.b #$0B : BNE .not_transformable_chicken
                            LDA $1B : BEQ .not_transformable_chicken
                                LDA.w $048E : DEC : BNE .not_transformable_chicken
                                    BRA .transformable_sprite
                        
                        .not_transformable_chicken
                        
                        CMP.b #$0D : BNE .not_buzzblob
                            LDA.w $0EB0, Y : BNE .no_collision
                                .transformable_sprite
                                
                                LDA.b #$01 : STA.w $0EB0, Y
                                
                                PHX : PHY
                                
                                TYX
                                
                                JSL.l Sprite_SpawnPoofGarnish
                                
                                PLY : PLX
                                
                                BRA .no_collision
                                
                        .not_buzzblob
                        
                        PHX : PHY
                        
                        TYX
                        
                        ; Check damage from magic powder to general sprites (not
                        ; specifically transformable like chickens or buzzblobs).
                        LDA.b #$0A : JSL.l Ancilla_CheckSpriteDamage_preset_class
                        
                        PLY : PLX
        
        .no_collision
    DEY : BPL .next_sprite
    
    RTS
}

; ==============================================================================
