; ==============================================================================

; NOTE: This file makes use of three sort of 'pseduo'-ancilla objects,
; in that they make use of the Ancilla API, but don't really fit into
; the normal framework of Ancillae. One of these is a fairy object,
; the second is an invisible object that controls the player's altitude
; during revival, creating a sort of rising effect that later changes
; to a floating effect.
; The third object (index 2) is the fairy dust object, which makes use
; of the existing magic powder ancillary object's drawing routine, though
; it uses a different sound effect.

; ==============================================================================

; $04727C-$047282 DATA
Pool_Ancilla_RevivalFairy:
{
    ; NOTE: The first one probably isn't even used as it's the start state.
    ; $04727C
    .timers
    db $00, $90
    
    ; $04727E
    .chr
    db $4B, $4D, $49, $47
}

; NOTE: Looks like this animated the fairies during death mode.
; $047283-$0473CE LONG JUMP LOCATION
Ancilla_RevivalFairy:
{
    PHB : PHK : PLB
    
    LDX.b #$00
    LDA.w $0C54, X : BEQ .fairy_emerging
        CMP.b #$03 : BNE .already_emerged
            BRL .return
        
    .fairy_emerging
    
    DEC.w $039F, X
    LDA.w $039F, X : BNE .fairy_rising
        INC.w $0C54, X
        LDY.w $0C54, X
        LDA.w Pool_Ancilla_RevivalFairy_timers, Y : STA.w $039F, X
        
        STZ.w $0380, X
        STZ.w $0294, X
        
        BRL .draw
    
    .fairy_rising
    
    JSR.w Ancilla_MoveAltitude
    
    BRL .draw
    
    .already_emerged
    
    CMP.b #$01 : BNE .fairy_flying_away
        DEC.w $039F, X : LDA.w $039F, X : BNE .sprinkling_sequence_running
            INC.w $0C54, X
            
            STZ.w $0294, X
            STZ.w $0C2C, X
            
            BRL .draw
            
        .sprinkling_sequence_running
        
        CMP.b #$4F : BEQ .initiate_sprinkle
        CMP.b #$8F : BNE .dont_initiate_sprinkle
            .initiate_sprinkle
            
            INC.w $0385, X
            
            ; Sprinkling fairy dust sound.
            LDA.b #$31
            JSR.w Ancilla_DoSfx2
            
        .dont_initiate_sprinkle
        
        LDA.w $0385, X : BEQ .no_sprinkle_animation
            DEC.w $0394, X : BPL .sprinkle_animation_delay
                LDA.b #$05 : STA.w $0394, X
                
                INC.w $0C5E, X
                LDA.w $0C5E, X : CMP.b #$03 : BNE .sprinkle_animation_incomplete
                    STZ.w $0C5E, X
                    STZ.w $0385, X
            
                .sprinkle_animation_incomplete
            .sprinkle_animation_delay
        .no_sprinkle_animation
        
        LDY.b #$FF
        
        LDA.w $0380, X : BEQ .float_descending
            ; And conversely, ascending.
            LDY.b #$01
        
        .float_descending
        
        STY.b $00
        
        LDA.w $0294, X : CLC : ADC.b $00 : STA.w $0294, X
        BPL .positive_z_velocity
            ; Basically, don't allow the velocity to become negative?
            ; WTF: Does this logic actually work properly in the game?
            EOR.b #$FF : INC
        
        .positive_z_velocity
        
        CMP.b #$08 : BNE .dont_toggle_float_direction
            LDA.w $0380, X : EOR.b #$01 : STA.w $0380, X
        
        .dont_toggle_float_direction
        
        JSR.w Ancilla_MoveAltitude
        
        BRA .draw
    
    .fairy_flying_away
    
    CMP.b #$02 : BNE .draw
        LDA.w $0294, X : CMP.b #$18 : BCS .z_velocity_maxed
            CLC : ADC.b #$01 : STA.w $0294, X
        
        .z_velocity_maxed
        
        LDA.w $0C2C, X : CMP.b #$10 : BCS .x_velocity_maxed
            CLC : ADC.b #$01 : STA.w $0C2C, X
        
        .x_velocity_maxed
        
        JSR.w Ancilla_MoveHoriz
        JSR.w Ancilla_MoveAltitude
    
    .draw
    
    LDA.b #$0C
    JSL.l OAM_AllocateFromRegionC
    
    JSR.w Ancilla_PrepOamCoord
    
    PHX
    
    STZ.b $0A
    
    LDA.w $0C54, X : CMP.b #$01 : BNE .not_sprinkling_dust
        LDA.w $0385, X : BEQ .not_sprinkling_dust
            LDA.w $0C5E, X : INC : STA.b $0A
    
    .not_sprinkling_dust
    
    LDY.b #$00
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .positive_altitude
        ORA.w #$FF00
    
    .positive_altitude
    
    EOR.w #$FFFF : INC : CLC : ADC.b $00 : STA.b $00
    
    SEP #$20
    
    JSR.w Ancilla_SetOam_XY
    
    LDA.b $0A : BEQ .commit_fairy_chr
        DEC : CLC : ADC.b #$02 : TAX
        
        BRA .commit_fairy_chr
        
    .fairy_not_sprinkling_dust
        
    ; Just alternate the fairy's chr every 4 frames.
    LDA.b $1A : AND.b #$04 : LSR : LSR : TAX
    
    .commit_fairy_chr
    
    LDA.w Pool_Ancilla_RevivalFairy_chr, X : STA.b ($90), Y
    
    INY
    LDA.b #$74                             : STA.b ($90), Y
    
    TYA : SEC : SBC.b #$03 : LSR : LSR : TAY
    LDA.b #$02 : STA.b ($92), Y
    
    PLX
    
    LDY.b #$01
    LDA.b ($90), Y : CMP.b #$F0 : BNE .fairy_not_off_screen
        LDA.b #$03 : STA.w $0C54, X
        
        INC.b $11
        
        LDA.l $7EC211 : STA.b $1C
        
    .fairy_not_off_screen

    .return
    
    JSR.w RevivalFairy_Dust
    JSR.w RevivalFairy_MonitorPlayerRecovery
    
    PLB
    
    RTL
}

; ==============================================================================

; $0473CF-$04742F LOCAL JUMP LOCATION
RevivalFairy_Dust:
{
    LDA.w $0C54, X : BNE .possible_fairy_dust
        ; If the fairy object is not at least in state 0x01, do nothing.
        RTS
        
    .possible_fairy_dust
    
    LDX.b #$02
    LDA.w $0C54, X : CMP.b #$02 : BEQ .return
        DEC.w $039F, X : BPL .return
            STZ.w $039F, X
            
            LDA.b #$10
            
            LDY.w $0FB3 : BNE .sort_sprites
                JSL.l OAM_AllocateFromRegionA
                
                BRA .OAM_allocated
            
            .sort_sprites
            
            JSL.l OAM_AllocateFromRegionD
            
            .OAM_allocated
            
            DEC.w $03B1, X : BPL .animation_delay
                LDA.b #$03 : STA.w $03B1, X
                
                ; Probably chr or a grouping state?
                LDY.b #$03
                LDA.w Ancilla_MagicPowder_animation_group_offsets, Y : STA.b $00
                
                LDA.w $0C5E, X : INC : CMP.b #$0A : BNE .powder_not_fully_dispersed
                    LDA.b #$20 : STA.w $039F, X
                    
                    INC.w $0C54, X
                    
                    LDA.b #$02 : STA.w $0C5E, X
                    
                    BRA .return
                
                .powder_not_fully_dispersed
                
                                  STA.w $0C5E, X
                CLC : ADC.b $00 : TAY
                
                LDA.w Pool_Ancilla_MagicPowder_animation_groups, Y : STA.w $03C2, X
            
            .animation_delay
            
            JSR.w MagicPowder_Draw
        
    .return
    
    RTS
} 

; ==============================================================================

; $047430-$0474C9 LOCAL JUMP LOCATION
RevivalFairy_MonitorPlayerRecovery:
{
    LDA.l $7EF36C : STA.b $00
    LDA.l $7EF36D : CMP.b $00 : BEQ .health_at_capacity
        CMP.b #$38 : BNE .below_seven_hearts
    
    .health_at_capacity
    
    LDA.w $020A : BNE .health_refill_animation_active
        LDY.b #$00
        
        LDA.w $0345 : BEQ .not_swimming
            LDY.b #$04
            
            LDA.b #$04 : STA.w $0340
            
            BRA .set_player_state
        
        .not_swimming
        
        LDA.b $56 : BEQ .not_bunny
            LDY.b #$17
            
            LDA.b #$01 : STA.w $02E0
            
        .not_bunny

        .set_player_state
        
        STY.b $5D
        
        STZ.b $4D
        STZ.w $036B
        STZ.w $030D
        STZ.w $030A
        STZ.b $24
        STZ.b $46
        STZ.w $0C4A
        STZ.w $0C4B
        STZ.w $0C4C
        STZ.w $0C4D
        STZ.w $0C4E
        
        RTS
        
    .health_refill_animation_active

    .below_seven_hearts
    
    LDX.b #$01
    
    LDA.w $0C54, X : BNE .player_floating
        DEC.w $039F, X : LDA.w $039F, X : BNE .delay_altitude_increase
            INC.w $039F, X
            
            LDA.b #$04 : STA.w $0294, X
            
            JSR.w Ancilla_MoveAltitude
            
            LDA.w $029E, X : CMP.b #$10 : BCC .altitude_not_at_target
                INC.w $0C54, X
                
                LDA.b #$02 : STA.w $0294, X

            .altitude_not_at_target
        .delay_altitude_increase
        
        BRA .set_player_altitude
    
    .player_floating
    
    DEC.w $0380, X : BPL .delay_float_direction_toggle 
        LDA.b #$20 : STA.w $0380, X
        
        LDA.w $0294, X : EOR.b #$FF : INC : STA.w $0294, X
        
    .delay_float_direction_toggle
    
    JSR.w Ancilla_MoveAltitude
    
    .set_player_altitude
    
    LDA.w $029E, X : STA.b $24
    
    RTS
}

; ==============================================================================
