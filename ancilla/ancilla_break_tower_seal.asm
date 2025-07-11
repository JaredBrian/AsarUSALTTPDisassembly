; ==============================================================================

; $044CA0-$044EA9 JUMP LOCATION
Ancilla_BreakTowerSeal:
{
    LDA.w $0C54, X : BNE .not_first_state
        ; The first state is just a single crystal and no fancypants stuff.
        LDA.w $0C22, X : CLC : ADC.b #$FF : CMP.b #$F0 : BCS .crystal_not_full_speed
            LDA.b #$F0
        
        .crystal_not_full_speed
        
        STA.w $0C22, X
        
        JSR.w Ancilla_MoveVert
        
        LDA.w $0BFA, X : STA $00
        LDA.w $0C0E, X : STA $01
        
        LDA.w $0C04, X : STA $02
        LDA.w $0C18, X : STA $03
        
        REP #$20
        
        LDA $00 : SEC : SBC.w $0122 : CMP.w #$0038 : BCS .crystal_not_at_rendezvous
            ; If the crystal somehow ends up higher than we wanted it to, snap
            ; it at Y coordinate 0x38 (that's what this code is for).
            LDA #$0038 : CLC : ADC.w $0122 : STA $00
            
                      CLC : ADC.w #$0008 : STA.l $7F5810
            LDA $02 : CLC : ADC.w #$0008 : STA.l $7F580E
            
            SEP #$20
            
            LDA $00 : STA.w $0BFA, X
            LDA $01 : STA.w $0C0E, X
            
            ; Move to the next state.
            INC.w $0C54, X
            
            ; Turn off ambient SFX.
            LDA.b #$05 : STA.w $012D
            
            ; Fade out music.
            LDA.b #$F1 : STA.w $012C
            
            REP #$20
            
            ; Show the text message of the crystal maidens being all gung-ho.
            LDA.w #$013B : STA.w $1CF0
            
            SEP #$20
            
            JSL.l Main_ShowTextMessage
            
            BRA .draw_single_crystal_prep
        
        .crystal_not_at_rendezvous
        
        SEP #$20
    
    .not_first_state
    
    LDA.w $0C54, X : CMP.b #$01 : BNE .not_first_expansion
        LDA $11 : BNE .expansion_delay
            LDA.b #$10 : STA.w $0C2C, X
            
            LDA.w $0C04, X : STA $72
            LDA.w $0C18, X : STA $73
            
            LDA.l $7F5808 : STA.w $0C04, X
                            STZ.w $0C18, X
            
            JSR.w Ancilla_MoveHoriz
            
            LDA.w $0C04, X : STA.l $7F5808
            
            LDA $72 : STA.w $0C04, X
            LDA $73 : STA.w $0C18, X
            
            LDA.l $7F5808 : CMP.b #$30 : BCC .expansion_delay
                LDA.b #$30 : STA.l $7F5808
                
                INC.w $0C54, X
            
        .expansion_delay
    .not_first_expansion
    
    LDA $11 : BNE .move_and_draw_crystals
        LDA.w $0C54, X : BNE .draw_multiple_crystals
            .draw_single_crystal_prep
            
            LDY.b #$00
            
            BRL .draw_single_crystal
        
        .draw_multiple_crystals
        
        CMP.b #$01 : BEQ .move_and_draw_crystals
            CMP.b #$03 : BEQ .in_final_rotational_expansion
                LDA.l $7F5812 : DEC : STA.l $7F5812
                BNE .move_and_draw_crystals
                    ; Initiate the tile and palette manipulation portion of the
                    ; tower opening sequence. This is handled by another part of
                    ; the game code, though that will begin to run in parallel
                    ; with this object's code.
                    LDA.b #$05 : STA.w $04C6
                    
                    STZ $B0
                    STZ $C8
                    
                    INC.w $0C54, X
                    
                    BRA .move_and_draw_crystals
            
            .in_final_rotational_expansion
            
            LDA.b #$30 : STA.w $0C2C, X
            
            LDA.w $0C04, X : STA $72
            LDA.w $0C18, X : STA $73
            
            LDA.l $7F5808 : STA.w $0C04, X
                            STZ.w $0C18, X
            
            JSR.w Ancilla_MoveHoriz
            
            LDA.w $0C04, X : STA.l $7F5808
            
            LDA $72 : STA.w $0C04, X
            LDA $73 : STA.w $0C18, X
            
            ; Project the cyrstals out while rotating them until they are
            ; 0xF0 units out, then it's time to shut down this object completely.
            ; The sequence to open the Tower will continue on after this object
            ; terminates, though.
            LDA.l $7F5808 : CMP.b #$F0 : BCC .move_and_draw_crystals
                PHX
                
                LDA.b #$00 : STA.w $0AB1
                LDA.b #$02 : STA.w $0AA9
                
                JSL.l Palette_MiscSpr_justSP6
                
                INC $15
                
                PLX
                
                STZ.w $0C4A, X
                
                RTS
            
    .move_and_draw_crystals
    
    LDY.b #$00
    
    LDA.w $0C54, X : STA $72 : BEQ .no_sparkles_yet
        JSR.w BreakTowerSeal_ExecuteSparkles
    
    .no_sparkles_yet
    
    LDX.b #$06
    
    .handle_next_crystal
        
        LDA $11 : BNE .dont_increment_angle
            ; When initially expanding the first 6 crystals out from the center
            ; one, don't rotate them.
            LDA $72 : CMP.b #$01 : BEQ .dont_increment_angle
                LDA $1A : AND.b #$01 : BNE .dont_increment_angle
                    LDA.l $7F5800, X : INC : AND.b #$3F : STA.l $7F5800, X
        
        .dont_increment_angle
        
        LDA.l $7F5808 : STA $08
        
        LDA.l $7F5800, X
        
        JSR.w Ancilla_GetRadialProjection
        
        REP #$20
        
        PHY
        
        LDA $00
        
        LDY $02 : BEQ .positive_y_projection
            EOR.b #$FFFF : INC
        
        .positive_y_projection
        
        CLC : ADC.l $7F5810 : CLC : ADC.w #$FFF8 : SEC : SBC.w $0122 : STA $00
        
        LDA $04
        
        LDY $06 : BEQ .positive_x_projection
            EOR.w #$FFFF : INC
        
        .positive_x_projection
        
        CLC : ADC.l $7F580E : CLC : ADC.w #$FFF8 : SEC : SBC.w $011E : STA $02
        
        PLY
        
        SEP #$20
        
        LDA $00 : STA.l $7F5817, X
        LDA $01 : STA.l $7F581F, X
        
        LDA $02 : STA.l $7F5827, X
        LDA $03 : STA.l $7F582F, X
        
        PHX
        
        JSR.w BreakTowerSeal_DrawCrystal
    PLX : DEX : BPL .handle_next_crystal
    
    .draw_single_crystal
    
    LDX.w $0FA0
    
    PHY
    
    JSR.w Ancilla_PrepAdjustedOamCoord
    
    PLY
    
    LDA $00 : STA.l $7F581E
    LDA $01 : STA.l $7F5826
    
    LDA $02 : STA.l $7F582E
    LDA $03 : STA.l $7F5836
    
    JSR.w BreakTowerSeal_DrawCrystal
    
    LDX.w $0FA0
    
    LDA.w $0C54, X : BNE .stop_spawning_sparkles
        JSR.w Ancilla_AddSwordChargeSpark
        
        BRA .return
        
    .stop_spawning_sparkles
    
    LDA $11 : BNE .return
        JSR.w BreakTowerSeal_ActivateSingleSparkle
        
        LDX.w $0FA0
    
    .return
    
    RTS
}

; ==============================================================================

; $044EAA-$044EC6 LOCAL JUMP LOCATION
BreakTowerSeal_DrawCrystal:
{
    JSR.w Ancilla_SetSafeOam_XY
    
    LDA.b #$24 : STA ($90), Y : INY
    LDA.b #$3C : STA ($90), Y
    
    INY : PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$02 : ORA $75 : STA ($92), Y
    
    PLY
    
    RTS
}

; ==============================================================================

; $044EC7-$044F34 LOCAL JUMP LOCATION
BreakTowerSeal_ActivateSingleSparkle:
{
    LDX.b #$17
    
    .check_next_sparkle
    
        LDA.l $7F5837, X : CMP.b #$FF : BEQ .activate_sparkle
    DEX : BPL .check_next_sparkle
        
    BRA .return
        
    .activate_sparkle
    
    PHX
    
    ; Initialize animation state.
    LDA.b #$00 : STA.l $7F5837, X
    
    ; Initialize animation delay countdown timer.
    LDA.b #$04 : STA.l $7F58AF, X
    
    ; Generate a random X and Y offset relative to a crystal location.
    ; This logic restricts the offsets in both dimensions to being
    ; 0 to 15.
    JSL.l GetRandomInt : STA $08
    LSR #4             : STA $09
    
    LDA $08 : AND.b #$0F : STA $08
    
    ; The crystal that it is relative to is, of course, restricted
    ; to one of the 7 crystals we have in play - one being stationary
    ; and the other 6 swirling. Why this takes the coordinate modulo 8
    ; seems more like sloppy deadline heavy coding. Either that or I missed
    ; something else that prevents X from being 7 here (which would be
    ; the 8th crystal counting from zero, which doesn't exist).
    ; BUG: Is the aforementioned a bug? Could be fun to test in debugger.
    TXA : AND.b #$07 : TAX
    
    LDA.l $7F5817, X : CLC : ADC $08    : STA $00
    LDA.l $7F581F, X       : ADC.b #$00 : STA $01
    
    LDA.l $7F5827, X : CLC : ADC $09    : STA $02
    LDA.l $7F582F, X       : ADC.b #$00 : STA $03
    
    PLX
    
    ; Set Y coordinate.
    LDA $00 : STA.l $7F584F, X
    LDA $01 : STA.l $7F5867, X
    
    ; Set X coordinate.
    LDA $02 : STA.l $7F587F, X
    LDA $03 : STA.l $7F5897, X

    .return

    RTS
}

; ==============================================================================

; $044F35-$044FA5 LOCAL JUMP LOCATION
BreakTowerSeal_ExecuteSparkles:
{
    LDX.b #$17
    
    .check_next_sparkle
    
        LDA.l $7F5837, X : CMP.b #$FF : BEQ .inactive_sparkle
            LDA.l $7F58AF, X : DEC : STA.l $7F58AF, X : BPL .still_active
                LDA.b #$04 : STA.l $7F58AF, X
                
                LDA.l $7F5837, X : INC : STA.l $7F5837, X : CMP.b #$03 : BNE .still_active
                    ; Aw, poor sparkle. You're getting deactivated. Or reset.
                    ; Whatever.
                    LDA.b #$FF : STA.l $7F5837, X
                    
                    BRA .inactive_sparkle
            
            .still_active
            
            PHX
            
            ; Form 16-bit Y coordinate.
            LDA.l $7F584F, X : STA $00
            LDA.l $7F5867, X : STA $01
            
            ; Form 16-bit X coordinate.
            LDA.l $7F587F, X : STA $02
            LDA.l $7F5897, X : STA $03
            
            ; This line could actually be moved after the following subroutine
            ; call, as it has no useful effect on the outcome of calling the
            ; subroutine.
            LDA.l $7F5837, X : TAX
            
            JSR.w Ancilla_SetOam_XY
            
            ; Uses the same chr and properties as the master sword swing sparkle?
            LDA.w Pool_Ancilla_SwordChargeSpark_chr, X : STA ($90), Y
            INY

            LDA.w Pool_Ancilla_SwordChargeSpark_properties, X
            ORA.b #$30 : STA ($90), Y
            INY
            
            PHY : TYA : SEC : SBC.b #$04 : LSR #2 : TAY
            
            LDA.b #$00 : STA ($92), Y
            
            PLY : PLX
            
        .inactive_sparkle
    DEX : BPL .check_next_sparkle
    
    RTS
}

; ==============================================================================
