; ==============================================================================

; Bank 0F
org $0E8000 ; $078000-$07FFFF

; ==============================================================================

; TODO: Find missing data here.

; ==============================================================================

; $07F540-$07F576 LONG JUMP LOCATION
Sprite_NullifyHookshotDrag:
{
    PHB : PHK : PLB
    
    PHX
    
    LDX.b #$04
    
    .next_objext
    
        ; Check if the hookshot is being used
        LDA.w $0C4A, X : CMP.b #$1F : BNE .not_hookshot
            ; Is the hookshot dragging Link somewhere?
            LDA.w $037E : BEQ .hookshot_not_dragging_player
                ; If the hookshot will drag Link through this sprite, stop him
                STZ.w $037E : BRA .moving_on
            
            .hookshot_not_dragging_player
        .not_hookshot
    DEX : BPL .next_object
    
    .moving_on
    
    ; Buffer Link's coordinates
    
    LDA.b $23 : STA.b $41
    LDA.b $21 : STA.b $40
    
    REP #$20
    
    LDA.w $0FC2 : STA.b $22
    LDA.w $0FC4 : STA.b $20
    
    SEP #$20
    
    ; This is what stops Link dead in his tracks when he collides with a
    ; sprite :/
    JSL $07F42F ; $03F42F IN ROM; Does some stuff only relevant to indoors
    
    PLX
    
    PLB
    
    RTL
}

; ==============================================================================
    
; $07F577-$07F5C2 LONG JUMP LOCATION
Ancilla_CheckForAvailableSlot:
{
    ; sees if the effect in question is already in play
    ; and if not, gives the okay to add it to the field.
    
    STY.b $0F : INY : STY.b $0E
    
    LDY.b #$00
    LDX.b #$04
    
    .nextSlot
    
        ; Compare the effect with the first 5 effects.
        CMP.w $0C4A, X : BNE .noMatch
            ; Y is the number of times that (A == $0C4A, X) is true
            INY
        
        .noMatch
    DEX : BPL .nextSlot
    
    CPY.b $0E : BEQ .alreadyFull
        LDY.b #$01 
        
        ; check if it's a bomb
        CMP.b #$07 : BEQ .onlyTwoSlots
            ; check if it's the rock fall from a bomb blowing open a door
            CMP.b #$08 : BEQ .onlyTwoSlots
                ; Otherwise, search 5 slots for an open one
                LDY.b #$04
            
        .onlyTwoSlots

        .findOpenSlot
        
            ; If any entry is zero, up to Y, end the routine (RTL)
            LDA.w $0C4A, Y : BEQ .openSlot
        DEY : BPL .findOpenSlot
        
        ; Here, none of the entries were 0, up until Y.
        .nextSlot2
        
            ; We go until this value is 0.
            ; As long as $03C4 is positive, skip this next part.
            DEC.w $03C4 : BPL .anoreset_slot_search_index
                ; The original Y parameter passed long ago.
                LDA.b $0F : STA.w $03C4
            
            .anoreset_slot_search_index
            
            LDY.w $03C4
            
            ; certain kinds of effects can be overridden, apparently
            LDA.w $0C4A, Y
            
            CMP.b #$3C : BEQ .openSlot
            CMP.b #$13 : BEQ .openSlot
            CMP.b #$0A : BEQ .openSlot
        ; Here none of the values matched. If we exhaust Y ( = $03C4), end the routine 
        DEY : BPL .nextSlot2
        
        .openSlot
        
        RTL
    
    .alreadyFull
    
    ; occurs when there are already too many of the same kind of effect in play
    TXY
    
    RTL
}

; ==============================================================================

; $07F5C3-$07F5E2 DATA
pool Death_PlayerSwoon:
{
    .player_oam_states
    db 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 5
    
    .timers
    db 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 3, 98
    
    .properties
    db $20, $10
}

; ==============================================================================

; $07F5E3-$07F64E LONG JUMP LOCATION
Death_PlayerSwoon:
{
    PHB : PHK : PLB
    
    DEC.w $030B : BPL .delay
        ; \wtf Um, if this actually ends up as 0x0F, how do we advance in
        ; death mode?
        LDX.w $030D : INX : CPX.b #$0F : BEQ .return
            CPX.b #$0E : BNE .swoon_in_progress
                INC.b $11
            
            .swoon_in_progress
            
            STX.w $030D
            
            LDA .player_oam_states, X : STA.w $030A
            
            LDA .timers, X : STA.w $030B
        
    .delay
    
    LDA.w $030D : CMP.b #$0D : BNE .return
        LDA.b $4B : CMP.b #$0C : BEQ .player_not_visible
            REP #$20
            
            LDA.b $20 : CLC : ADC.w #$0010 : SEC : SBC.b $E8 : STA.b $00
            LDA.b $22 : CLC : ADC.w #$0007 : SEC : SBC.b $E2 : STA.b $02
            
            SEP #$20
            
            LDY.b $EE
            
            LDA.b $02                         : STA.w $09D0
            LDA.b $00                         : STA.w $09D1
            LDA.b #$AA                      : STA.w $09D2
            LDA .properties, Y : ORA.b #$02 : STA.w $09D3
            
            LDA.b #$02 : STA.w $0A94
        
        .player_not_visible
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $07F64F-$07F67A DATA
pool AddSwordBeam:
{
    .initial_angles
    db $21, $1D, $19, $15
    db $03, $3E, $3A, $36
    db $12, $0E, $0A, $06
    db $31, $2D, $29, $25
    
    .y_speeds
    db $C0, $40, $00, $00
    
    .x_speeds
    db $00, $00, $C0, $40
    
    .rotation_speeds
    db $F8, $F8, $F8, $08
    
    .y_offsets_low
    db $E8, $08, $FA, $FA
    
    .y_offsets_high
    db $FF, $00, $FF, $FF
    
    .x_offsets_low
    db $F8, $F6, $EA, $04
    
    .x_offsets_high
    db $FF, $FF, $FF, $00
}

; ==============================================================================

; $07F67B-$07F74C LONG JUMP LOCATION
AddSwordBeam:
{
    ; \note SHOOT TEH BEAMZ
    
    PHB : PHK : PLB
    
    ; Master sword's bolts of lightning
    LDA.b #$0C : JSL AddAncillaLong : BCS Death_PlayerSwoon_return
        LDA.b $2F : ASL A : TAY
        
        LDA .initial_angles+0, Y : STA.l $7F5800
        LDA .initial_angles+1, Y : STA.l $7F5801
        LDA .initial_angles+2, Y : STA.l $7F5802
        LDA .initial_angles+3, Y : STA.l $7F5803 : STA.l $7F5804
        
        LDA.b #$02 : STA.w $03B1, X
        LDA.b #$4C : STA.w $0C5E, X
        LDA.b #$08 : STA.w $039F, X
        
        STZ.w $0C54, X : STZ.w $0385, X : STZ.w $0394, X
        
        LDA.b #$00 : STA.w $03A4, X
        
        LDA.b #$0E : STA.l $7F5808
        
        LDA.b $2F : LSR A : STA.w $0C72, X : TAY
        
        LDA .y_speeds, Y        : STA.w $0C22, X
        LDA .x_speeds, Y        : STA.w $0C2C, X
        LDA .rotation_speeds, Y : STA.w $03A9, X
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #$000C : STA.l $7F5810
        LDA.b $22 : CLC : ADC.w #$0008 : STA.l $7F580E
        
        SEP #$20
        
        JSL Ancilla_CheckInitialTileCollision_Class_1 : BCS .start_as_beam_hit
            PLB
            
            RTL
        
        .start_as_beam_hit
        
        LDY.w $0C72, X
        
        LDA.l $7F5810 : CLC : ADC .y_offsets_low,  Y : STA.w $0BFA, X
        LDA.l $7F5811 : ADC .y_offsets_high, Y : STA.w $0C0E, X
        
        LDA.l $7F580E : CLC : ADC .x_offsets_low,  Y : STA.w $0C04, X
        LDA.l $7F580F : ADC .x_offsets_high, Y : STA.w $0C18, X
        
        JSL Sound_SfxPanObjectCoords : ORA.b #$01 : STA.w $012F
        
        LDA.b #$04 : STA.w $0C4A, X
        LDA.b #$07 : STA.w $0C68, X
        
        LDA.b #$10 : STA.w $0C90, X
        
        PLB
        
        RTL
}

; ==============================================================================

; $07F74D-$07F763 DATA
pool SwordBeam:
{
    .chr
    db $D7, $B7, $80, $83
    
    .extra_spark_chr
    db $B7, $80, $83
    
    .y_offsets_low
    db  0,  0, -6, -6
    
    .y_offsets_high
    db  0,  0, -1, -1
    
    .x_offsets_low
    db -8, -10, 0,  0
    
    .x_offsets_high
    db -1, -1,  0,  0
}

; ==============================================================================

; $07F764-$07F8EA LONG JUMP LOCATION
SwordBeam:
{
    PHB : PHK : PLB
    
    PHX
    
    LDA.b #$02 : STA.b $73
    
    LDA.b $11 : BEQ .execute
        BRL .draw_logic
    
    .execute
    
    LDA.l $7F5810 : STA.w $0BFA, X
    LDA.l $7F5811 : STA.w $0C0E, X
    
    LDA.l $7F580E : STA.w $0C04, X
    LDA.l $7F580F : STA.w $0C18, X
    
    JSR SwordBeam_MoveVert
    JSR SwordBeam_MoveHoriz
    
    LDA.w $0BFA, X : STA.l $7F5810
    LDA.w $0C0E, X : STA.l $7F5811
    
    LDA.w $0C04, X : STA.l $7F580E
    LDA.w $0C18, X : STA.l $7F580F
    
    LDA.w $0394, X : AND.b #$0F : BNE .sfx_delay
        JSL Sound_SfxPanObjectCoords : ORA.b #$01 : STA.w $012F
    
    .sfx_delay
    
    INC.w $0394, X
    
    JSL Ancilla_CheckSpriteCollisionLong : BCS .hit_sprite
        JSL Ancilla_CheckTileCollisionLong : BCC .anohit_sprite_or_tile
    
    .hit_sprite
    
    LDY.w $0C72, X
    
    LDA.w $0BFA, X : CLC : ADC .y_offsets_low,  Y : STA.w $0BFA, X
    LDA.w $0C0E, X : ADC .y_offsets_high, Y : STA.w $0C0E, X
    
    LDA.w $0C04, X : CLC : ADC .x_offsets_low,  Y : STA.w $0C04, X
    LDA.w $0C18, X : ADC .x_offsets_high, Y : STA.w $0C18, X
    
    ; Transmute into a beam hit object.
    LDA.b #$04 : STA.w $0C4A, X
    
    ; Set timer and oam allocation for this tranmuted little guy.
    LDA.b #$07 : STA.w $0C68, X
    LDA.b #$10 : STA.w $0C90, X
    
    BRL .return
    
    .anohit_sprite_or_tile
    
    DEC.w $03B1, X : BPL .draw_logic
        LDA.b #$04 : STA.b $73
        
        LDA.b #$02 : STA.w $03B1, X
    
    .draw_logic
    
    LDA.w $03A9, X : STA.b $76
    
    LDY.b #$00
    LDX.b #$03
    
    .next_oam_entry
    
    STX.b $72
    
    LDA.b $11 : BNE .dont_rotate_component
        LDA.l $7F5800, X : CLC : ADC.b $76 : AND.b #$3F : STA.l $7F5800, X
    
    .dont_rotate_component
    
    PHX
    PHY
    
    LDA.l $7F5808 : STA.b $08
    
    LDA.l $7F5800, X
    
    JSL Ancilla_GetRadialProjectionLong
    JSL Sparkle_PrepOamCoordsFromRadialProjection
    
    PLY
    
    JSL Ancilla_SetOam_XY_Long
    
    LDX.b $72
    
    LDA .chr, X       : STA ($90), Y : INY
    LDA.b $73 : ORA.b $65 : STA ($90), Y : INY
    
    PHY
    
    TYA : SEC : SBC.b #$04 : LSR #2 : TAY
    
    LDA.b #$00 : STA ($92), Y
    
    PLY
    
    PLX : DEX : BPL .next_oam_entry
    
    PLX : PHX
    
    LDA.b $11 : BNE .dont_rotate_extra_spark
        DEC.w $039F, X : BPL .skip_extra_spark_draw_logic
        
        LDA.b #$00 : STA.w $039F, X
        
        LDA.w $03A4, X : INC A : AND.b #$03 : STA.w $03A4, X
        CMP.b #$03 : BNE .dont_rotate_extra_spark
            LDA.l $7F5804 : CLC : ADC.b $76 : AND.b #$3F : STA.l $7F5804
    
    .dont_rotate_extra_spark
    
    LDA.w $03A4, X : STA.b $72 : CMP.b #$03 : BEQ .skip_extra_spark_draw_logic
        PHY
        
        LDA.l $7F5808 : STA.b $08
        
        LDA.l $7F5804
        
        JSL Ancilla_GetRadialProjectionLong
        JSL Sparkle_PrepOamCoordsFromRadialProjection
        
        PLY
        
        JSL Ancilla_SetOam_XY_Long
        
        LDX.b $72
        
        LDA .extra_spark_chr, X : STA ($90), Y : INY
        LDA.b #$04 : ORA.b $65    : STA ($90), Y : INY
        
        TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
    
    .skip_extra_spark_draw_logic
    
    PLX
    PHX
    
    LDY.b #$01
    
    .find_active_component
    
    LDA ($90), Y : CMP.b #$F0 : BNE .at_least_one_component_active
        INY #4 : CPY.b #$11 : BNE .find_active_component
        
        STZ.w $0C4A, X
    
    .at_least_one_component_active
    .return
    
    PLX
    
    PLB
    
    RTL
}

; ==============================================================================

; $07F8EB-$07F8FE
pool SwordFullChargeSpark:
{
    .y_offsets_low
    db -8,  27,  12,  12
    
    .y_offsets_high
    db -1,   0,   0,   0
    
    .x_offsets_low
    db  4,   4, -13, 20
    
    .x_offsets_high
    db  0,   0,  -1,  0
    
    .properties
    db $20, $10, $30, $20
}

; ==============================================================================

; $07F8FF-$07F960 LONG JUMP LOCATION
SwordFullChargeSpark:
{
    PHB : PHK : PLB
    
    LDA.w $0C68, X : BNE .delay_termination
        STZ.w $0C4A, X
        
        BRA .return
    
    .delay_termination
    
    LDA.b $2F : LSR A : TAY
    
    LDA.b $20 : CLC : ADC .y_offsets_low,  Y : STA.b $00
    LDA.b $21 : ADC .y_offsets_high, Y : STA.b $01
    
    LDA.b $22 : CLC : ADC .x_offsets_low,  Y : STA.b $02
    LDA.b $23 : ADC .x_offsets_high, Y : STA.b $03
    
    REP #$20
    
    LDA.b $00 : SEC : SBC.b $E8 : STA.b $00
    LDA.b $02 : SEC : SBC.b $E2 : STA.b $02
    
    SEP #$20
    
    LDY.w $0C7C, X
    
    LDA .properties, Y : STA.b $65
                         STZ.b $64
    
    LDY.b #$00
    
    JSL Ancilla_SetOam_XY_Long
    
    LDA.b #$D7           : STA ($90), Y : INY
    LDA.b #$02 : ORA.b $65 : STA ($90), Y
    
    LDA.b #$00 : STA ($92)
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $07F961-$07F978 DATA
pool AncillaSpawn_SwordChargeSparkle:
{
    .y_offsets
    dw  5, 12,  8,  8
    
    .x_offsets
    dw  0,  3,  4,  5
    
    .y_position_masks
    db $00, $00, $07, $07
    
    .x_position_masks
    db $70, $70, $00, $00
}

; ==============================================================================

; $07F979-$07FA36 LONG JUMP LOCATION
AncillaSpawn_SwordChargeSparkle:
{
    PHB : PHK : PLB
    
    LDX.b #$09
    
    .next_slot
    
        LDA.w $0C4A, X : BEQ .empty_ancillary_slot
    DEX : BPL .next_slot
    
    BRL .return
        .empty_ancillary_slot
        
        ; Spawn a sword charge sparkle.
        LDA.b #$3C : STA.w $0C4A, X
        
        STZ.w $0C5E, X
        
        LDA.b #$04 : STA.w $0C68, X
        
        LDA.b $EE : STA.w $0C7C, X
        
        STZ.b $74
        STZ.b $75
        
        LDA.b $2F : LSR A : TAY
        
        LDA .y_position_masks, Y : BNE .off_axis_y
            LDA.w $0079 : LSR #2
            
            CPY.b #$00 : BNE .sign_correct_for_y_direction
                EOR.b #$FF : INC A
            
            .sign_correct_for_y_direction
            
            STA.b $74
            
            LDA.b #$00
        
        .off_axis_y
        
        STA.b $72
        
        LDA .x_position_masks, Y : BNE .off_axis_x
            LDA.w $0079 : LSR #2
            
            CPY.b #$02 : BNE .sign_correct_for_x_direction
                EOR.b #$FF : INC A
            
            .sign_correct_for_x_direction
            
            STA.b $75
            
            LDA.b #$00
        
        .off_axis_x
        
        STA.b $73
        
        JSL GetRandomInt : STA.b $08 : AND.b $72 : STA.b $04
                                            STZ.b $05
        
        LDA.b $08 : AND.b $73 : LSR #4 : STA.b $06
                                    STZ.b $07
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $74 : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_y_offset
            ORA.w #$FF00
        
        .sign_ext_y_offset
        
        CLC : ADC.b $20 : CLC : ADC .y_offsets, Y : CLC : ADC.b $04 : STA.b $00
        
        LDA.b $75 : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_x_offset
            ORA.w #$FF00
        
        .sign_ext_x_offset
        
        CLC : ADC.b $22 : CLC : ADC .x_offsets, Y : CLC : ADC.b $06 : STA.b $02
        
        SEP #$20
        
        LDA.b $00 : STA.w $0BFA, X
        LDA.b $01 : STA.w $0C0E, X
        
        LDA.b $02 : STA.w $0C04, X
        LDA.b $03 : STA.w $0C18, X
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $07FA37-$07FA42 LOCAL JUMP LOCATION
SwordBeam_MoveHoriz:
{
	TXA : CLC : ADC.b #$0A : TAX

	JSR SwordBeam_MoveVert

	LDX.w $0FA0
	
    RTS
}

; ==============================================================================

; $07FA43-$07FA6E LOCAL JUMP LOCATION
SwordBeam_MoveVert:
{
    LDA.w $0C22, X : ASL #4 : CLC : ADC.w $0C36, X : STA.w $0C36, X
    
    LDY.b #$00
    
    ; upper 4 bits are pixels per frame. lower 4 bits are 1/16ths of a pixel per frame.
    ; store the carry result of adding to $0C36, X
    ; check if the y pixel change per frame is negative
    LDA.w $0C22, X : PHP : LSR #4 : PLP : BPL .moving_down
        ; sign extend from 4-bits to 8-bits
        ORA.b #$F0
        
        DEY
    
    .moving_down
    
    ; modifies the y coordinates of the special object
          ADC.w $0BFA, X : STA.w $0BFA, X
    TYA : ADC.w $0C0E, X : STA.w $0C0E, X
    
    RTS
}

; ==============================================================================

; $07FA6F-$07FAE9 LONG JUMP LOCATION
Death_PrepFaint:
{
    ; Something related to death mode and the spot light closing in...
    
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $2F
    
    LDA.b #$01 : STA.w $036B
    
    STZ.w $030D : STZ.w $030A
    
    LDA.b #$05 : STA.w $030B
    
    ; Leave no chance of regeneration and zero out health.
    LDA.b #$00 : STA.l $7EF372
                 STA.l $7EF36D
    
    JSL $07F1FA ; $03F1FA IN ROM
    
    STZ.w $02F5 : STZ.w $0351 : STZ.w $02E0 : STZ.b $48
    STZ.w $02EC : STZ.b $4D   : STZ.b $46   : STZ.w $0373
    STZ.w $02E1 : STZ.b $5E   : STZ.w $03F7
    
    ; \item
    LDA.l $7EF357 : BEQ .no_moon_pearl
        STZ.b $56
    
    .no_moon_pearl
    
    STZ.w $03F5 : STZ.w $03F6
    
    ; Play passing out noise.
    JSL Sound_SetSfxPanWithPlayerCoords : ORA.b #$27 : STA.w $012E
    
    ; \item
    LDA.b #$06 : CMP.l $7EF35C : BEQ .bottledFairy
                 CMP.l $7EF35D : BEQ .bottledFairy
                 CMP.l $7EF35E : BEQ .bottledFairy
                 CMP.l $7EF35F : BEQ .bottledFairy
    
    STZ.w $05FC : STZ.w $05FD ; This is hit if we do not have any bottled fairies
    
    .bottledFairy
    
    PLB
    
    RTL
}

; ==============================================================================

; $07FAEA-$07FAFD LONG JUMP LOCATION
ShopKeeper_RapidTerminateReceiveItem:
{
    ; Causes receive item ancilla to hurry up and finish executing.
    
    PHX
    
    LDX.b #$04
    
    .next_slot
    
        LDA.w $0C4A, X : CMP.b #$22 : BNE .not_receive_item
            LDA.b #$01 : STA.w $03B1, X
        
        .not_receive_item
    DEX : BPL .next_slot
    
    PLX
    
    RTL
}

; ==============================================================================

; $07FAFE-$07FB79 LONG JUMP LOCATION
DashTremor_TwiddleOffset:
{
	LDY.w $0C72, X

	LDA.w $0BFA, X : STA.b $00
	LDA.w $0C0E, X : STA.b $01

	REP #$20

    ; $00 *= -1
	LDA.b $00 : EOR.w #$FFFF : INC A : STA.b $00

	SEP #$20

	LDA.b $00 : STA.w $0BFA, X
	LDA.b $01 : STA.w $0C0E, X
    
	LDA.b $1B : BNE .indoors
        CPY.b #$02 : BNE .horizontal_shake
            REP #$20
            
            ; \note It appears that these are screen boundaries of some sort.
            LDA.w $0600 : CLC : ADC.w #$0001 : STA.b $02
            LDA.w $0602 : CLC : ADC.w #$FFFF : STA.b $04
            
            LDA.b $00 : CLC : ADC.b $E8 : CMP.b $02 : BEQ .zero_shake_vert
                                                BCC .zero_shake_vert
                                    CMP.b $04 : BEQ .zero_shake_vert
                                                    BCC .return
            
                .zero_shake_vert
                
                BRA .zero_shake_offset_this_frame
        
        .horizontal_shake
        
        REP #$20
        
        ; \note It appears that these are screen boundaries of some sort.
        LDA.w $0604 : CLC : ADC.w #$0001 : STA.b $02
        LDA.w $0606 : CLC : ADC.w #$FFFF : STA.b $04
        
        LDA.b $00 : CLC : ADC.b $E2 : CMP.b $02 : BEQ .zero_shake_horiz
                                            BCC .zero_shake_horiz
                                CMP.b $04 : BEQ .zero_shake_horiz
                                                BCC .return
        
        .zero_shake_horiz
        .zero_shake_offset_this_frame
        
        STZ.b $00
    
    .indoors
    .return
    
	SEP #$20
    
	RTL
}

; ==============================================================================

; $07FB7A-$07FBC1 DATA
pool BombosSpell_ExecuteBlasts:
{
    .y_offsets length 64
    db $B6, $5D, $A1
    
    .x_offsets length 64
    db $30, $69, $B5, $A3, $24
    db $96, $AC, $73, $5F, $92, $48, $52, $81
    db $39, $95, $7F, $20, $88, $5D, $34, $98
    db $BC, $D2, $51, $77, $A2, $47, $94, $B2
    db $34, $DA, $30, $62, $9F, $76, $51, $46
    db $98, $5C, $9B, $61, $58, $95, $4C, $BA
    db $7E, $CB, $12, $D0, $70, $A6, $46, $BF
    db $40, $50, $7E, $8C, $2D, $61, $AC, $88
    
    ; \wtf Is this used for anything?
    .unknown
    db $20, $6A, $72, $5F, $D2, $28, $52, $80        
}

; ==============================================================================

; $07FBC2-$07FCC1 DATA
pool Ancilla_GetRadialProjection:
{
    ; 0x100 bytes worth of data used to project a distance circularly or
    ; some shit. (Hey, I'm tired, will document later)
    
    ; These first two arrays are simplified sin() and cos() tables, but
    ; it's hard for me to tell yet which is which? It also requires further
    ; exploration to figure out whether the angle argument starts at 0
    ; degrees or radians or whatever, or whether it starts at a different
    ; on the unit circle. \task Figure this out.
    ; To quote a contemporary:
    ; "Trigonometry in assembler is a fucking bitch." -Kejardon
    
    db $00, $19, $31, $4A, $61, $78, $8E, $A2
    db $B5, $C5, $D4, $E1, $EC, $F4, $FB, $FE
    db $FF, $FE, $FB, $F4, $EC, $E1, $D4, $C5
    db $B5, $A2, $8E, $78, $61, $4A, $31, $19
    db $00, $19, $31, $4A, $61, $78, $8E, $A2
    db $B5, $C5, $D4, $E1, $EC, $F4, $FB, $FE
    db $FF, $FE, $FB, $F4, $EC, $E1, $D4, $C5
    db $B5, $A2, $8E, $78, $61, $4A, $31, $19
    
    
    db $FF, $FE, $FB, $F4, $EC, $E1, $D4, $C5
    db $B5, $A2, $8E, $78, $61, $4A, $31, $19
    db $00, $19, $31, $4A, $61, $78, $8E, $A2
    db $B5, $C5, $D4, $E1, $EC, $F4, $FB, $FE
    db $FF, $FE, $FB, $F4, $EC, $E1, $D4, $C5
    db $B5, $A2, $8E, $78, $61, $4A, $31, $19
    db $00, $19, $31, $4A, $61, $78, $8E, $A2
    db $B5, $C5, $D4, $E1, $EC, $F4, $FB, $FE
    
    
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01        
}

; ==============================================================================

; $07FCC2-$07FD21 DATA
pool Ancilla_SomarianBlockDivide:
{
    .y_offsets
    dw -10, -10,   2,   2,  -8,   0,  -8,   0
    dw -12, -12,   4,   4,  -8,   0,  -8,   0
    
    .x_offsets
    dw  -8,   0,  -8,   0, -10, -10,   2,   2
    dw  -8,   0,  -8,   0, -12, -12,   4,   4
    
    .chr
    db $C6, $C6, $C6, $C6, $C4, $C4, $C4, $C4
    db $D2, $D2, $D2, $D2, $C5, $C5, $C5, $C5
    
    .properties
    db $C6, $86, $46, $06, $46, $C6, $06, $86
    db $C6, $86, $46, $06, $46, $C6, $06, $86
}

; ==============================================================================

; $07FD22-$07FD3B LONG JUMP LOCATION
Link_CheckBunnyStatus:
{
    LDA.b $5D : CMP.b #$02 : BNE .linkNotRecoiling
        LDY.b #$00
        
        LDA.w $02E0 : BEQ .linkNotBunny
            LDY.b #$17 
            
            LDA.l $7EF357 : BEQ .noMoonPearl
                LDY.b #$1C
            
            .noMoonPearl
            
            STY.b $5D
        
        .linkNotBunny
    .linkNotRecoiling
    
    RTL
}

; ==============================================================================

; $07FD3C-$07FD51 LONG JUMP LOCATION
Ancilla_TerminateWaterfallSplashes:
{
    ; \hardcoded
    LDA.b $8A : CMP.b #$0F : BNE .not_area_below_zora_falls
        LDX.b #$04
        
        .next_slot
        
            LDA.w $0C4A, X : CMP.b #$41 : BNE .not_waterfall_splash
                ; Terminate the ancilla if it's a waterfall splash.
                STZ.w $0C4A, X
            
            .not_waterfall_splash
        DEX : BPL .next_slot
    
    .not_area_below_zora_falls
    
    RTL
}

; ==============================================================================

    ; \note I think this routine is redundant, there are probably routines
    ; in bank 0x08 that can already handle this.
; $07FD52-$07FD85 LONG JUMP LOCATION
Ancilla_TerminateIfOffscreen:
{
    LDA.w $0BFA, Y : STA.b $0C
    LDA.w $0C0E, Y : STA.b $0D
    
    LDA.w $0C04, Y : STA.b $0E
    LDA.w $0C18, Y : STA.b $0F
    
    REP #$20
    
    LDA.b $0C : SEC : SBC.b $E8 : CMP.w #$00F0 : BCS .self_terminate
        LDA.b $0E : SEC : SBC.b $E2 : CMP.w #$00F4 : BCC .on_screen
    
    .self_terminate
    
    SEP #$20
    
    LDA.b #$00 : STA.w $0C4A, Y
    
    .on_screen
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $07FD86-$07FDA9 LONG JUMP LOCATION
Sprite_InitializeSecondaryItemMinigame:
{
    PHX
    
    ; Signal that a Y button override is in effect (Shovel and Bow are the
    ; two known instances of this).
    STA.w $03FC
    
    JSL $07F1FA ; $03F1FA IN ROM
    
    LDX.b #$04
    
    .next_object
    
        LDA.w $0C4A, X
        
        CMP.b #$30 : BEQ .terminate_object
        CMP.b #$31 : BEQ .terminate_object
            CMP.b #$05 : BNE .no_match
                STZ.w $035F
                
                .terminate_object
                
                STZ.w $0C4A, X
            
            .no_match
    DEX : BPL .next_object
    
    PLX
    
    RTL
}

; ==============================================================================

    ; Uses $1CF0 as the index for which message it shows.
; $07FDAA-$07FDC3 LONG JUMP LOCATION
Main_ShowTextMessage:
{
    ; Are we in text mode? If so then end the routine.
	LDA.b $10 : CMP.b #$0E : BEQ .already_in_text_mode
        STZ.w $0223   ; Otherwise set it so we are in text mode.
        STZ.w $1CD8   ; Initialize the step in the submodule
        
        ; Go to text display mode (as opposed to maps, etc)
        LDA.b #$02 : STA.b $11
        
        ; Store the current module in the temporary location.
        LDA.b $10 : STA.w $010C
        
        ; Switch the main module ($10) to text mode.
        LDA.b #$0E : STA.b $10
	
    .already_in_text_mode

	RTL
}

; ==============================================================================

; $07FDC4-$07FDCE LONG JUMP LOCATION
Sprite_SpawnSparkleAncilla:
{
	PHB : PHK : PLB

	PHX

	JSL AddSwordChargeSpark

	PLX

	PLB

	RTL
}

; ==============================================================================

    ; \note Determines whether to use a shadow, a water ripple, or grass
    ; sprite under the bomb. It also detects situations where none of these
    ; are necessary or appropriate, and returns a carry flag state of clear
    ; to indicate that no 'underside' sprite should be drawn.
    
; $07FDCF-$07FE71 LONG JUMP LOCATION
Bomb_CheckUndersideSpriteStatus:
{
    ; this routine is a bomb exclusive
    
    LDA.w $0C5E, X : BEQ .not_exploding
                   BRL .no_underside_sprite
    
    .not_exploding
    
    STZ.b $0A ; Set it to a large shadow by default
    
    ; This checks for a water tile type
    ; (water tile type of course)
    LDA.w $03E4, X : CMP.b #$09 : BNE .not_shallow_water
        DEC.w $03E1, X : BPL .ripple_animation_delay
            LDA.b #$03 : STA.w $03E1, X
            
            INC.w $03D2, X
            
            LDA.w $03D2, X : CMP.b #$03 : BNE .anoreset_ripple_animation_index
                LDA.b #$00 : STA.w $03D2, X

            .anoreset_ripple_animation_index
        .ripple_animation_delay
        
        ; Puts a water ripple around the bomb
        LDA.w $03D2, X : CLC : ADC.b #$04 : STA.b $0A
        
        LDA.w $012E : AND.b #$3F
        
        CMP.b #$0B : BEQ .sfx_can_be_overriden
            CMP.b #$21 : BNE .shadow_size_logic
        
        .sfx_can_be_overriden
        
        STZ.w $012E
        
        JSL Sound_SfxPanObjectCoords : ORA.b #$28 : STA.w $012E
        
        BRA .shadow_size_logic
    
    .not_shallow_water
    
    ; grass tile type
    CMP.b #$40 : BNE .shadow_size_logic
        ; Put grass around the bomb
        LDA.b #$03 : STA.b $0A
    
    .shadow_size_logic
    
    ; Check the bomb's height off the ground
    ; If less than two, shadow stays large
    LDA.w $029E, X : CMP.b #$02 : BCC .use_large_shadow
        ; If >= 252, shadow stays large
        CMP.b #$FC : BCS .use_large_shadow
            ; if(height >= 2 && height < 252) draw a small shadow
            LDA.b #$02 : STA.b $0A
    
    .use_large_shadow
    
    ; Branch if Link is touching the bomb
    TXA : INC A : CMP.w $02EC : BNE .not_nearest_to_player
        ; Branch if Link is holding the bomb (or something else?)
        LDA.w $0308 : AND.b #$80 : BNE .no_underside_sprite
    
    .not_nearest_to_player
    
    ; \wtf What's the point of this?
    CPY.b #$04 : BEQ .oam_slot_is_four_yeah_ok_whatever
        LDY.b #$00
    
    .oam_slot_is_four_yeah_ok_whatever
    
    REP #$20
    
    LDA.w $029E, X : AND.w #$00FF : CMP.w #$0080 : BCC .sign_ext_z_coord
        ; sign extends to 16-bits
        ORA.w #$FF00
    
    .sign_ext_z_coord
    
    CLC : ADC.b $0C : CLC : ADC.w #$0002 : STA.b $00
    
    LDA.b $0E : CLC : ADC.w #$FFF8 : STA.b $02
    
    SEP #$20
    
    LDA.b $65 : STA.b $04
    
    CLC
    
    RTL
    
    .no_underside_sprite
    
    SEC
    
    RTL
}

; ==============================================================================
