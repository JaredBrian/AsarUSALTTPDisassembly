; ==============================================================================

; $048000-$048023 DATA
Pool_AddHitStars:
{
    ; $048000
    .xy_offsets
    dw 21, -11
    dw 21,  11
    dw  3,  -6
    dw 21,   5
    dw 16, -14
    dw 16,  14
    
    ; $048018
    .unknown_offsets
    dw -3, 19
    dw  2, 13
    dw -6, 22
}

; ==============================================================================

; Special effect 0x16 initializer.
; $048024-$048090 LONG JUMP LOCATION
AddHitStars:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .spawn_failed
        STZ.w $0C5E, X
        
        LDA.b #$02 : STA.w $03B1, X
        LDA.b #$01 : STA.w $039F, X
        
        STZ.w $0C22, X
        STZ.w $0C2C, X
        
        LDA.w $0301 : BEQ .nothing_in_hand
            LDA.b $2F : LSR : CLC : ADC.b #$02 : TAY
            
            BRA .continue
        
        .nothing_in_hand
        
        LDA.w $037A : BEQ .no_special_position
            LDY.b #$00
            
            LDA.b $2F : CMP.b #$04 : BEQ .facing_left
                LDY.b #$01

            .facing_left
        .no_special_position
        
        .continue
        
        TYA : STA.w $0C54, X : ASL #2 : TAY
        
        REP #$20
        
        LDA.w Pool_AddHitStars_xy_offsets+0, Y : CLC : ADC.b $20 : STA.b $00
        LDA.w Pool_AddHitStars_xy_offsets+2, Y : CLC : ADC.b $22 : STA.b $02
        
        TYA : LSR : TAY
        
        LDA.b $22 : CLC : ADC Pool_AddHitStars_unknown_offsets, Y : STA.b $04
        
        SEP #$20
        
        LDA.b $04 : STA.w $038A, X
        LDA.b $05 : STA.w $038F, X
        
        BRL Shortcut_just_coords
        
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; Special effect 0x20 initializer
; $048091-$0480C7 LONG JUMP LOCATION
AddLinksBedSpread:
{
    PHB : PHK : PLB
    
    LDX.b #$00 
    
    STA.w $0C4A, X
    
    PHX : TAX
    
    LDA.l AncillaObjectAllocation, X : STA.b $0E
    
    PLX
    
    LDA.b $0E : STA.w $0C90, X
    LDA.b $EE : STA.w $0C7C, X
    
    LDA.w $0476 : STA.w $03CA, X
    
    STZ.w $0280, X
    
    REP #$20
    
    ; Use fixed coordinates for Link's bed spread sprite.
    LDA.w #$2162 : STA.b $00
    LDA.w #$0938 : STA.b $02

    ; Bleeds into the next function.
}
    
; $0480C1 ALTERNATE ENTRY POINT
Shortcut:
{   
    .set_8Bit
    
    SEP #$20
    
    ; $0480C3 ALTERNATE ENTRY POINT
    .just_coords
    
    JSR.w Ancilla_SetCoords
    
    PLB
    
    RTL
}

; ==============================================================================

; Special effect 0x21 initializer
; $0480C8-$0480FE LONG JUMP LOCATION
AddLinksSleepZs:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .no_open_slots
        STZ.w $0C5E, X
        
        LDA.b #$F8 : STA.w $0C22, X
        
        LDA.b #$07 : STA.w $03B1, X : INC : STA.w $0C2C, X
        
        LDA.b #$FF : STA.w $0C54, X
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #$0004 : STA.b $00
        LDA.b $22 : CLC : ADC.w #$0010 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    ; $0480FD ALTERNATE ENTRY POINT
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $0480FF-$04811E DATA
Pool_AddBlueBomb:
{
    ; $0480FF
    .closer_y_offsets
    dw 4, 28, 12, 12
    
    ; $048107
    .closer_x_offsets
    dw 8, 8, -6, 22
    
    ; $04810F
    .y_offsets
    dw 0, 24, 12, 12
    
    ; $048117
    .x_offsets
    dw 8, 8, 0, 16
}

; NOTE: Special Effect 0x07 (Link's blue bombs) Initializer
; $04811F-$0481B2 LONG JUMP LOCATION
AddBlueBomb:
{
    PHB : PHK : PLB	
    
    ; A = 0x07
    ; No room? Don't lay the bomb.
    JSR.w AddAncilla : BCS AddLinkSleepZs_no_open_slots
        ; Check our bomb stock.
        LDA.l $7EF343 : BNE .player_has_bombs
            STZ.w $0C4A, X ; Otherwise forget it.
            
            BRA .out_of_bombs
        
        .player_has_bombs
        
        ; Subtract from our bomb stock by one.
        DEC STA.l $7EF343 : BNE .bombs_left_over
            PHX ; If we run out of bombs select a new item.
            
            JSL.l HUD.RefreshIconLong
        
        .bombs_left_over
        
        PLX
        
        ; Not used?
        STZ.w $03EA, X : STZ.w $0C54, X
        
        STZ.w $0C5E, X : STZ.w $03C2, X : STZ.w $0385, X
        
        ; Load the timer value for the bomb (this value is the first entry into
        ; that table).
        LDA.l Pool_Ancilla_Bomb_interstate_intervals : STA.w $039F, X
        
        ; Seems like this memory is specific to bombs.
        LDA.b #$07 : STA.w $03C0, X
        
        ; Elevation of the sprite.
        STZ.w $029E, X
        
        LDA.b #$08 : STA.w $0C68, X
        
        ; See which direction Link is facing. The bomb keeps track of this I
        ; guess.
        LDA.b $2F : LSR : STA.w $0C72, X
        
        STZ.w $03D5, X
        STZ.w $03D2, X
        STZ.w $03E1, X
        
        JSL.l Ancilla_CheckInitialTileCollision_Class2 : BCS .use_closer_offsets
            LDY.b $2F
            
            REP #$20
            
            LDA.b $20 : CLC : ADC Pool_AddBlueBomb_y_offsets, Y : STA.b $00
            LDA.b $22 : CLC : ADC Pool_AddBlueBomb_x_offsets, Y : STA.b $02
            
            SEP #$20
            
            BRA .finalize_coordinates
            
        .use_closer_offsets
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $20 : CLC : ADC Pool_AddBlueBomb_closer_y_offsets, Y : STA.b $00
        LDA.b $22 : CLC : ADC Pool_AddBlueBomb_closer_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        .finalize_coordinates
        
        JSL.l Sound_SetSfxPanWithPlayerCoords
        
        ; Play the bomb laying sound.
        ORA.b #$0B : STA.w $012E
        
        BRL Shortcut_just_coords
        
    .out_of_bombs
        
    PLB
        
    RTL
}

; ==============================================================================

; $0481B3-$04820E DATA
Pool_AddBoomerang:
{
    ; $0481B3
    .speeds
    db $20, $18
    db $30, $28
    
    ; $0481B7
    .throw_distance
    db 32, 96
    
    ; $0481B9
    .rotation_speed
    db  3,  2
    
    ; $0481BB
    .directional_components
    db $08, $04, $02, $01
    
    ; $0481BF
    .valid_direction_combinations
    db $08, $04, $02, $01, $09, $05, $0A, $06
    
    ; $0481C7
    .initial_rotation_state
    db 2, 3, 3, 2, 2, 3, 3, 3
    
    ; $0481CF
    .typical_y_offsets
    dw -10,  -8,  -9,  -9, -10,  -8,  -9,  -9
    
    ; $0481DF
    .typical_x_offsets
    dw  -9,  11,   8,  -8, -10,  11,   8,  -8
    
    ; $0481EF
    .sword_held_y_offsets
    dw -16,   6,   0,   0,  -8,   8,  -8,   8
    
    ; $0481FF
    .sword_held_x_offsets
    dw   0,   0,  -8,   8,   8,   8,  -8,  -8
}

; ==============================================================================
    
; Special effect 0x5 (boomerang) initializer.
; $04820F-$04836B LONG JUMP LOCATION
AddBoomerang:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCC .open_slot
        BRL .no_open_slots
    
    .open_slot
    
    STZ.w $03B1, X
    STZ.w $0C5E, X
    STZ.w $0380, X
    STZ.w $029E, X
    
    STA.w $0385, X
    
    LDA.b #$01 : STA.w $035F
    
    ; $0394, X = Which type of boomerang it is - normal or magic.
    LDA.l $7EF341 : DEC : STA.w $0394, X : TAY
    
    LDA.w Pool_AddBoomerang_throw_distance, Y : STA.w $0C54, X
    
    LDA.w Pool_AddBoomerang_rotation_speed, Y : STA.w $039F, X
    
    LDY.b #$00
    
    ; Check if player is attempting to throw the boomerang diagonally.
    LDA.b $F0 : AND.b #$0C : BEQ .not_diagonal
        LDA.b $F0 : AND.b #$03 : BEQ .not_diagonal
            INY
        
    .not_diagonal
    
    STY.b $00
    
    ; Add additional offset to the index if it's the magic boomerang.
    LDA.w $0394, X : ASL CLC : ADC.b $00 : TAY
    
    LDA.w Pool_AddBoomerang_speeds, Y : STA.b $00 : STA.w $03C5, X
    
    STY.b $72
    
    ; Check if the player is attempting to throw the boomerang in a specific
    ; direction (by holding down a directional button).
    LDA.b $F0 : AND.b #$0F : BNE .directional_throw
        LDA.b $2F : LSR : TAY
        
        ; If no directional buttons are being pressed, just use the direction
        ; Link is facing to set the directional component of the throw.
        LDA.w .directional_components, Y
        
    .directional_throw
    
    STA.b $01
    
    STZ.w $039D
    
    LDY.b $00
    
    LDA.b $01
    
    AND.b #$0C : BEQ .nonvertical_throw
        AND.b #$08 : BEQ .down_throw
            ; Reverse the direction (velocity?) of the throw.
            TYA : EOR.b #$FF : INC : TAY
        
        .down_throw
        
        ; Store vertical velocity.
        TYA : STA.w $0C22, X
        
        LDY.b #$00
        
        LDA.w $0C22, X : BMI .up_throw
            INY
        
        .up_throw
        
        ; $0C72, X = 1 if it's a down throw, 0 if it's an up throw.
        TYA : STA.w $0C72, X
        
        LDA.w Pool_AddBoomerang_directional_components, Y : STA.w $039D
    
    .nonvertical_throw
    
    STZ.w $03A9, X
    
    LDY.b $00
    
    LDA.b $01
    
    AND.b #$03 : BEQ .nonhoriz_throw
        AND.b #$02 : BEQ .right_throw
            ; Reverse the polarity of the velocity so that the boomerang travels
            ; left which is the negative X direction.
            TYA : EOR.b #$FF : INC : TAY
            
            BRA .set_horiz_velocity
            
        .right_throw
        
        ; Apparently $03A9, X = 0xFF for a right throw, and 0x00 for a left
        ; throw...
        DEC.w $03A9, X
        
        .set_horiz_velocity
        
        TYA : STA.w $0C2C, X
        
        LDY.b #$02
        
        LDA.w $0C2C, X : BMI .left_throw
            LDY.b #$03
        
        .left_throw
        
        TYA : STA.w $0C72, X
        
        ; $039D is the list of directional components for the throw.
        LDA.w Pool_AddBoomerang_directional_components, Y
        ORA.w $039D : STA.w $039D
    
    .nonhoriz_throw
    
    LDY.b #$07
    
    .find_valid_combo_loop
    
        LDA.w Pool_AddBoomerang_valid_direction_combinations, Y : CMP.b $01 : BEQ .is_valid_combo
    DEY : BPL .find_valid_combo_loop
    
    INY
    
    .is_valid_combo
    
    LDA.w Pool_AddBoomerang_initial_rotation_state, Y : STA.w $03A4, X
    
    TYA : ASL : TAY : STA.w $03CF, X
    
    LDA.b $3C : CMP.b #$09 : BCC .spin_attack_not_charged
        INC.w $03B1, X
        
        BRA .directional_throw_2
    
    .spin_attack_not_charged
    
    ; WTF: this seems like a lapse of logic.... lumping in the magic boomerang
    ; with diagonal throwing.
    LDA.b $72 : BNE .diagonal_or_magic_throw
        LDA.b $F0 : AND.b #$0F : BNE .directional_throw_2
    
    .diagonal_or_magic_throw
    
    LDY.b $2F
    
    .directional_throw_2
    
    JSL.l Ancilla_CheckInitialTileCollision_Class_1 : BCS .terminate_object
        LDA.w $03B1, X : BEQ .not_thrown_while_spin_attack_charged
            ; NOTE: This section calculates the starting position of the
            ; boomerang differently since the player has a charged spin attack,
            ; and the throwing animation will not be done.
            REP #$20
            
            LDA.b $20 : CLC : ADC.w #$0008
            CLC : ADC Pool_AddBoomerang_sword_held_y_offsets, Y : STA.b $00

            LDA.b $22
            CLC : ADC Pool_AddBoomerang_sword_held_x_offsets, Y : STA.b $02
            
            SEP #$20
            
            BRL .finished_so_finalize_coordinates
        
        .not_thrown_while_spin_attack_charged
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #$0008
        CLC : ADC Pool_AddBoomerang_typical_y_offsets, Y : STA.b $00

        LDA.b $22
        CLC : ADC Pool_AddBoomerang_typical_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        .finished_so_finalize_coordinates
        
        BRL Shortcut_just_coords
    
    .no_open_slots
        
    PLB
        
    RTL
        
    .terminate_object
    
    STZ.w $0C4A, X : STZ.w $035F
    
    LDA.w $03E4, X : CMP.b #$F0 : BEQ .hit_key_door
        JSL.l Sound_SfxPanObjectCoords : ORA.b #$05 : STA.w $012E
        
        BRA .spawn_wall_hit_object
    
    .hit_key_door
    
    ; Play pinging sound from hitting key door.
    JSL.l Sound_SfxPanObjectCoords : ORA.b #$06 : STA.w $012E
    
    .spawn_wall_hit_object
    
    JSL.l AddBoomerangWallHit
    
    PLB
    
    RTL
}

; ==============================================================================

; $04836C-$0485E7 DATA
Pool_AddReceiveItem:
{
    ; $04836C
    .y_offsets
    db -5, -5, -5, -5, -5, -4, -4, -5
    db -5, -4, -4, -4, -2, -4, -4, -4
    
    db -4, -4, -4, -4, -4, -4, -4, -4
    db -4, -4, -4, -4, -4, -4, -4, -4
    
    db -4, -4, -4, -5, -4, -4, -4, -4
    db -4, -4, -2, -4, -4, -4, -4, -4
    
    db -4, -4, -4, -4, -2, -2, -2, -4
    db -4, -4, -4, -4, -4, -4, -4, -4
    
    db -4, -4, -2, -2, -4, -2, -4, -4
    db -4, -5, -4, -4
    
    ; $0483B8
    .x_offsets
    db  4,  4,  4,  4,  4,  0,  0,  4
    db  4,  4,  4,  4,  5,  0,  0,  0
    
    db  0,  0,  0,  4,  0,  4,  0,  0
    db  4,  0,  0,  0,  0,  0,  0,  0
    
    db  0,  0,  0,  0,  4,  0,  0,  0
    db  0,  0,  5,  0,  0,  0,  0,  0
    
    db  0,  0,  0,  0,  4,  4,  4,  0
    db  0,  0,  0,  0,  0,  0,  0,  0
    
    db  0,  0,  4,  4,  0,  4,  0,  0
    db  0,  4,  0,  0
    
    ; $048404
    .item_graphics_indices
    db $06 ; 0x00 - FIGHTER SWORD
    db $18 ; 0x01 - MASTER SWORD
    db $18 ; 0x02 - TEMPERED SWORD
    db $18 ; 0x03 - BUTTER SWORD
    db $2D ; 0x04 - FIGHTER SHIELD
    db $20 ; 0x05 - FIRE SHIELD
    db $2E ; 0x06 - MIRROR SHIELD
    db $09 ; 0x07 - FIRE ROD
    db $09 ; 0x08 - ICE ROD
    db $0A ; 0x09 - HAMMER
    db $08 ; 0x0A - HOOKSHOT
    db $05 ; 0x0B - BOW
    db $10 ; 0x0C - BOOMERANG
    db $0B ; 0x0D - POWDER
    db $2C ; 0x0E - BOTTLE REFILL (BEE)
    db $1B ; 0x0F - BOMBOS
    db $1A ; 0x10 - ETHER
    db $1C ; 0x11 - QUAKE
    db $14 ; 0x12 - LAMP
    db $19 ; 0x13 - SHOVEL
    db $0C ; 0x14 - FLUTE
    db $07 ; 0x15 - SOMARIA
    db $1D ; 0x16 - BOTTLE
    db $2F ; 0x17 - HEART PIECE
    db $07 ; 0x18 - BYRNA
    db $15 ; 0x19 - CAPE
    db $12 ; 0x1A - MIRROR
    db $0D ; 0x1B - GLOVE
    db $0D ; 0x1C - MITTS
    db $0E ; 0x1D - BOOK
    db $11 ; 0x1E - FLIPPERS
    db $17 ; 0x1F - PEARL
    db $28 ; 0x20 - CRYSTAL
    db $27 ; 0x21 - NET
    db $04 ; 0x22 - BLUE MAIL
    db $04 ; 0x23 - RED MAIL
    db $0F ; 0x24 - SMALL KEY
    db $16 ; 0x25 - COMPASS
    db $03 ; 0x26 - HEART CONTAINER FROM 4/4
    db $13 ; 0x27 - BOMB
    db $01 ; 0x28 - 3 BOMBS
    db $1E ; 0x29 - MUSHROOM
    db $10 ; 0x2A - RED BOOMERANG
    db $00 ; 0x2B - FULL BOTTLE (RED)
    db $00 ; 0x2C - FULL BOTTLE (GREEN)
    db $00 ; 0x2D - FULL BOTTLE (BLUE)
    db $00 ; 0x2E - POTION REFILL (RED)
    db $00 ; 0x2F - POTION REFILL (GREEN)
    db $00 ; 0x30 - POTION REFILL (BLUE)
    db $30 ; 0x31 - 10 BOMBS
    db $22 ; 0x32 - BIG KEY
    db $21 ; 0x33 - MAP
    db $24 ; 0x34 - 1 RUPEE
    db $24 ; 0x35 - 5 RUPEES
    db $24 ; 0x36 - 20 RUPEES
    db $23 ; 0x37 - GREEN PENDANT
    db $23 ; 0x38 - BLUE PENDANT
    db $23 ; 0x39 - RED PENDANT
    db $29 ; 0x3A - TOSSED BOW
    db $2A ; 0x3B - SILVERS
    db $2C ; 0x3C - FULL BOTTLE (BEE)
    db $2B ; 0x3D - FULL BOTTLE (FAIRY)
    db $03 ; 0x3E - BOSS HC
    db $03 ; 0x3F - SANC HC
    db $34 ; 0x41 - 100 RUPEES
    db $35 ; 0x42 - 50 RUPEES
    db $31 ; 0x43 - HEART
    db $33 ; 0x44 - ARROW
    db $02 ; 0x45 - 10 ARROWS
    db $32 ; 0x46 - SMALL MAGIC
    db $36 ; 0x47 - 300 RUPEES
    db $37 ; 0x48 - 20 RUPEES GREEN
    db $2C ; 0x49 - FULL BOTTLE (GOOD BEE)
    db $06 ; 0x4A - TOSSED FIGHTER SWORD
    db $0C ; 0x4B - FLUTE (ACTIVATED)
    db $38 ; 0x4C - BOOTS
    
    ; $048450
    .wide_item_flag
    db $00, $00, $00, $00, $00, $02, $02, $00 
    db $00, $00, $00, $00, $00, $02, $02, $02 
    
    db $02, $02, $02, $00, $02, $00, $02, $02 
    db $00, $02, $02, $02, $02, $02, $02, $02 
    
    db $02, $02, $02, $02, $00, $02, $02, $02 
    db $02, $02, $00, $02, $02, $02, $02, $02 
    
    db $02, $02, $02, $02, $00, $00, $00, $02 
    db $02, $02, $02, $02, $02, $02, $02, $02 
    
    db $02, $02, $00, $00, $02, $00, $02, $02
    db $02, $00, $02, $02    
    
    ; $04849C
    .properties
    db  5, -1,  5,  5,  5,  5,  5,  1
    db  2,  1,  1,  1,  2,  2,  2,  4
    db  4,  4,  1,  1,  2,  1,  1,  1
    db  2,  1,  2,  1,  4,  4,  2,  1
    db  6,  1,  2,  1,  2,  2,  1,  2
    db  2,  4,  1,  1,  4,  2,  1,  4
    db  2,  2,  4,  4,  4,  2,  1,  4
    db  1,  2,  2,  1,  2,  2,  1,  1
    db  4,  4,  1,  2,  2,  4,  4,  4
    db  2,  5,  2,  1        
    
    ; Item Target SRAM addresses for items you receive
    ; $0484E8
    .item_target_addr
    dw $F359, $F359, $F359, $F359, $F35A, $F35A, $F35A, $F345
    dw $F346, $F34B, $F342, $F340, $F341, $F344, $F35C, $F347

    dw $F348, $F349, $F34A, $F34C, $F34C, $F350, $F35C, $F36B
    dw $F351, $F352, $F353, $F354, $F354, $F34E, $F356, $F357

    dw $F37A, $F34D, $F35B, $F35B, $F36F, $F364, $F36C, $F375
    dw $F375, $F344, $F341, $F35C, $F35C, $F35C, $F36D, $F36E

    dw $F36E, $F375, $F366, $F368, $F360, $F360, $F360, $F374
    dw $F374, $F374, $F340, $F340, $F35C, $F35C, $F36C, $F36C

    dw $F360, $F360, $F372, $F376, $F376, $F373, $F360, $F360
    dw $F35C, $F359, $F34C, $F355

    ; Values to write to the above SRAM locations.
    ; $048580
    .item_values
    db $01, $02, $03, $04, $01, $02, $03, $01
    db $01, $01, $01, $01, $01, $02, $FF, $01

    db $01, $01, $01, $01, $02, $01, $FF, $FF
    db $01, $01, $02, $01, $02, $01, $01, $01

    db $FF, $01, $FF, $02, $FF, $FF, $FF, $FF
    db $FF, $FF, $02, $FF, $FF, $FF, $FF, $FF
    
    db $FF, $FF, $FF, $FF, $FF, $FB, $EC, $FF
    db $FF, $FF, $01, $03, $FF, $FF, $FF, $FF
    
    db $9C, $CE, $FF, $01, $0A, $FF, $FF, $FF
    db $FF, $01, $03, $01
    
    ; $0485CC
    .item_masks
    dw $8000, $4000, $2000, $1000, $0800, $0400, $0200, $0100
    dw $0080, $0040, $0020, $0010, $0008, $0004
}

; Special effect 0x22 initializer (falling prize objects from boss fights).
; $0485E8-$048931 LONG JUMP LOCATION
AddReceivedItem:
{
    PHB : PHK : PLB
    
    ; Carry indicates success for this routine.
    JSR.w AddAncilla : BCC .openSlot
        BRL .noOpenSlots
    
    .openSlot
    
    ; Did the item come from a chest?
    LDA.w $02E9 : CMP.b #$01 : BNE .notOpeningChest
        LDA.b $72 : PHA
        LDA.b $73 : PHA
    
    .notOpeningChest
    
    LDY.b #$01
    
    ; Is the item a crystal?
    LDA.w $02D8 : CMP.b #$20 : BNE .notCrystal
        LDY.b #$02
    
    .notCrystal
    
    TYA : STA.w $02E4
    
    PHX
    
    ; Load the item index again.
    ; If it's not a sword+lvl_1 shield.
    LDY.w $02D8 : BNE .not_uncles_gear
        LDX.b #$08
        
        ; Gives the address to write this value to.
        LDA.w .item_target_addr+0, X : STA.b $00
        LDA.w .item_target_addr+1, X : STA.b $01
        LDA.b #$7E                   : STA.b $02
        
        LDA.w .item_values, Y : STA [$00]
    
    .not_uncles_gear
    
    TYA : ASL : TAX
    
    ; Tells what inventory location to write to.
    LDA.w .item_target_addr+0, X : STA.b $00
    LDA.w .item_target_addr+1, X : STA.b $01
    LDA.b #$7E                   : STA.b $02
    
    ; Tells what value to write to that location.
    ; If it's a negative value, don't write it.
    LDA.w .item_values, Y : BMI .dontWrite
        STA [$00]
    
    .dontWrite
    
    ; Is it a moon pearl?
    ; Not a moon pearl.
    CPY.b #$1F : BNE .notMoonPearl
        ; Reset Link's graphic status to normal (so he's not a bunny anymore).
        STZ.b $56
    
    .notMoonPearl
    
    ; Grant the running ability (if boots are involved).
    LDA.b #$04
    
    ; Are they the Pegasus boots?
    CPY.b #$4B : BEQ .arePegasusBoots
    CPY.b #$1E : BNE .notFlippers
        ; Grant the swimming ability.
        LDA.b #$02
    
        .arePegasusBoots
    
        ; Add an ability to Ability flags location.
        ORA.l $7EF379 : STA.l $7EF379
    
    .notFlippers
    
    ; Are they gloves? (power glove or titan's mitt).
    CPY.b #$1B : BEQ .areGloves
    CPY.b #$1C : BNE .notGloves
        .areGloves
    
        JSL.l Palette_ChangeGloveColor
    
    .doneWithValue
    
    BRL .GFXHandling
        .notGloves
    
        LDX.b #$04
        
        ; These are the three pendants (codes #$37, #$38, #$39).
        CPY.b #$37 : BEQ .isPendant
            LDX.b #$01
            
            CPY.b #$38 : BEQ .isPendant
                LDX.b #$02
                
                CPY.b #$39 : BNE .notPendant
                    .isPendant
                
                    ; Seen in use for doling out pendant values. Other usages?
                    TXA : ORA [$00] : STA [$00]
                    
                    INC.w $0200
                    
                    ; Are all the pendants filled in yet?
                    AND.b #$07 : CMP.b #$07 : BNE .dontHaveAllPendants
                        ; #$04 means we have all the pendants apparently, and
                        ; can go get us some Master Sword action.
                        LDA.b #$04 : STA.l $7EF3C7
                
                    .dontHaveAllPendants
        .notPendant
    
        ; Is it armor?
        CPY.b #$22 : BNE .notArmor
            ; This prevents the blue mail from overwriting the red mail.
            LDA [$00] : BNE .alreadyHaveUpgradedArmor
                ; Otherwise, give us the blue mail.
                LDA.b #$01 : STA [$00]
    
            .alreadyHaveUpgradeArmor
    
            BRA .doneWithValue
    
        .notArmor
    
        ; Is it a dungeon compass?
        CPY.b #$25 : BEQ .isPalaceItem
        ; Is it a big key?
        CPY.b #$32 : BEQ .isPalaceItem
            ; Is it a a dungeon map?
            CPY.b #$33 : BNE .notPalaceItem
                ; Palaces have compasses, big keys, and maps.
                .isPalaceItem
        
                ; Tell me what dungeon I'm in.
                LDX.w $040C
                
                REP #$20
                
                ; Give Link the item.
                LDA.w .item_masks, X : ORA [$00] : STA [$00]
                
                SEP #$20
                
                ; Don't have a good name for this but it basically means move
                ; on, we're done here.
                BRL .GFXHandling
        
        .notPalaceItem
    
        ; Is it a heart container?
        CPY.b #$3E : BNE .notHeartContainer
            BIT.w $0308 : BPL .notCarryingAnything
                LDA.b #$02 : STA.w $0309
            
            .notHeartContainer
        .notCarryingAnything
    
        ; Is it a crystal?
        CPY.b #$20 : BNE .notCrystal2
            ; TODO: Wtf is this comment?
            ; Paul's concern.
            INC.w $0200
            
            PHX
            
            LDX.b #$04
            
            .nextObject
            
                LDA.w $0C4A, X : CMP.b #$07 : BEQ .notBombObject
                            CMP.b #$2C : BNE .notBombOrSomariaBlock
                    .notBombObject
                
                    STZ.w $0C4A, X
                    
                    STZ.w $0308
                    STZ.w $0309
            
                .notBombOrSomariaBlock
            DEX : BPL .nextObject
            
            PLX
            
            ; Is Link in "cape" mode?
            LDA.b $55 : BEQ .notInCapeMode
                ; If so, transform him out of it.
                LDA.b #$20 : STA.w $02E2
                
                STZ.w $037B
                STZ.b $55
                
                PHY : PHX
                
                LDY.b #$04
                LDA.b #$23
                
                JSL.l AddTransformationCloud
                JSL.l Sound_SetSfxPanWithPlayerCoords
                
                ; Play sound effect.
                ORA.b #$15 : STA.w $012E
                
                PLX : PLY
                
                BRL .GFXHandling
            .notInCapeMode
        .notCrystal2
        
        ; Is it a mushroom / magic powder?
        CPY.b #$29 : BNE .notMagicPowder
            ; Check if we have magic powder:
            LDA.l $7EF344 : CMP.b #$02 : BEQ .notMagicPowder
                ; If not, give the guy a mushroom instead.
                LDA.b #$01 : STA [$00]
                
                ; TODO: Probably should split off a differnt name for this
                ; invocation of the branch.
                BRA .noKeyOverflow
        
        .notMagicPowder
        
        LDX.b #$01
        
        ; But not the Big Key, just to be clear.
        CPY.b #$24 : BEQ .addToStock
            LDA.w $02E9 : CMP.b #$02 : BEQ .receivingFromSprite
                ; Give the guy 1 bomb.
                CPY.b #$27 : BEQ .addToStock
                    ; Give the guy 3 bombs.
                    LDX.b #$03
                    
                    CPY.b #$28 : BEQ .addToStock
                        ; Bombs again, this time you get 10 bombs.
                        ; branch if not those things.
                        CPY.b #$31 : BNE .notFillerItem
                            ; Give the guy 10 bombs.
                            LDX.b #$0A
        
        .addToStock
        
        TXA : CLC : ADC [$00] : STA [$00]
        
        CMP.b #99 : BCC .noKeyOverflow
            LDA.b #99 : STA [$00]
        
        .noKeyOverflow
        
        JSL.l HUD.RebuildLong
    
        BRA .GFXHandling
        
        .notFillerItem
        .receivingFromSprite
        
        ; Is it a piece of heart?
        CPY.b #$17 : BNE .notPieceOfHeart
            LDA [$00] : INC : AND.b #$03 : STA [$00]
            
            JSL.l Sound_SetSfxPanWithPlayerCoords
            
            ORA.b #$2D : STA.w $012F
            
            BRA .GFXHandling
        
        .notPieceOfHeart
        
        ; Is it the Master sword?
        CPY.b #$01 : BNE .notMasterSword
            PHY : PHX
            
            JSL.l Overworld_SetSongList
            
            PLX : PLY
        
        .notMasterSword
        
        JSR.w GiveBottledItem
    
    .GFXHandling
    
    LDY.w $02D8
    
    LDA.w .item_graphics_indices, Y : STA.b $72
    
    CMP.b #$FF : BEQ .nullEntry
    CMP.b #$20 : BEQ .isShield
    CMP.b #$2D : BEQ .isShield
        CMP.b #$2E : BNE .extractGraphic
            .isShield
    
            ; Decompresses graphics to show off the new item.
            JSL.l DecompShieldGfx
            JSL.l Palette_Shield
            
            LDA.b $72
            
            BRA .extractGraphic
    
    .nullEntry
    
    LDA.b #$00
    
    .extractGraphic
    
    JSL.l GetAnimatedSpriteTile_variable ; Passes through here 0987A0.
    
    LDA.b $72
    
    CMP.b #$06 : BEQ .isSword
    CMP.b #$18 : BNE .notSword
        .isSword
    
        LDA.w $02D8 : BEQ .notSword
            JSL.l DecompSwordGfx
            JSL.l Palette_Sword
    
    .notSword
    
    PLX
    
    ; Stores the item index to give Link in an array for the special object
    ; code to handle.
    LDA.w $02D8 : STA.w $0C5E, X : TAY
    
    STZ.w $03A4, X
    
    LDA.b #$09 : CPY.b #$01 : BNE .notMasterSword2
        STA.w $039F, X
        
        ; Not sure if this is accurate.
        LDA.w $02E9 : CMP.b #$02 : BEQ .masterSwordFromSprite
            LDA.b #$A0 : STA.w $0C68, X
            
            LDA.b #$2B : STA.b $11
            
            LDA.b #$00 : STA.l $7EC007
            
            PHX : PHY
            
            LDY.b #$04
            LDA.b #$35
            
            JSL.l AddSwordCeremony
            
            PLY : PLX
            
            LDA.b #$02
    
    .notMasterSword2
    
    STA.w $039F, X
    
    .masterSwordFromSprite
    
    LDA.b #$05 : STA.w $0BF0, X
    
    PHY
    
    LDY.b #$60
    
    LDA.w $02E9 : STA.w $0C54, X : BEQ .fromText
        LDY.b #$38
    
    .fromText
    
    ; Is it a crystal?
    LDA.w $0C5E, X
    
    CMP.b #$20 : BEQ .isCrystalOrPendant
    CMP.b #$37 : BEQ .isCrystalOrPendant
    CMP.b #$38 : BEQ .isCrystalOrPendant
    CMP.b #$39 : BEQ .isCrystalOrPendant
        CMP.b #$26 : BNE .heartPiece
            LDY.b #$02
        
        BRA .heartPiece
    
    .isCrystalOrPendant
    
    LDY.b #$68
    
    .heartPiece
    
    ; Delay timer that can affect how high the item gets off the air.
    TYA : STA.w $03B1, X
    
    PLY
    
    LDA.w $02E9 : CMP.b #$01 : BNE .notFromChest
        PLA : STA.b $73
        PLA : STA.b $72
        
        REP #$20
        
        LDA.b $72 : AND.w #$1F80 : LSR #4 : STA.b $00
        LDA.b $72 : AND.w #$007E : ASL #2 : STA.b $02
        
        SEP #$20
        
        ; Since we're indoors (chests only occur indoors), add the base
        ; coordinates for the room we're in.
        LDA.b $01 : CLC : ADC.w $062F : STA.b $01
        LDA.b $03 : CLC : ADC.w $062D : STA.b $03
        
        REP #$20
        
        LDA.w Pool_AddReceiveItem_y_offsets, Y
        AND.w #$00FF : ORA.w #$FF00 : CLC : ADC.b $00 : STA.b $00
        
        LDA.w .x_offsets, X : AND.w #$00FF : CLC : ADC.b $02
        
        BRL .finishedWithCoords
    
    .notFromChest
    
    PHY
    
    ; Check method.
    LDA.w $0C54, X : BNE .notFromText
        ; Check item.
        LDA.w $0C5E, X : CMP.b #$01 : BNE .notMasterSword4
            JSL.l Sound_SetSfxPanWithPlayerCoords
        
            ; Play sound of sword being brandished (since we're getting the
            ; master sword).
            ORA.b #$2C : STA.w $012E
        
            BRA .doneWithSoundEffects

        .notMasterSword4

    .notFromText
    
    LDA.w $0C5E, X : CMP.b #$3E : BEQ .doneWithSoundEffects
                     CMP.b #$17 : BEQ .doneWithSoundEffects
        ; Is it a crystal?
        CMP.b #$20 : BEQ .bossVictoryMusic
            
        ; These are the three pendants, 0x37, 0x38, and 0x39.
        CMP.b #$37 : BEQ .bossVictoryMusic
        CMP.b #$38 : BEQ .bossVictoryMusic
        CMP.b #$39 : BNE .generalSoundEffect
            .bossVictoryMusic
        
            JSL.l Sound_SetSfxPanWithPlayerCoords
            
            ORA.b #$13 : STA.w $012C ; Play the boss victory song.
            
            BRA .doneWithSoundEffects
        
        .generalSoundEffect
        
        JSL.l Sound_SetSfxPanWithPlayerCoords
            
        ; Play general "you got something sound effect"
        ORA.b #$0F : STA.w $012F
    
    .doneWithSoundEffects
    
    ; X coord = 0x000A
    LDA.b #$0A : STA.b $02

    STZ.b $03
    
    ; Check a flag to see whether we should use an alternate default coordinate.
    LDY.w $0C5E, X
    
    LDA.w .wide_item_flag, Y : BEQ .setCoordinates
        ; Is it a crystal?
        CPY.b #$20 : BNE .notCrystal5
            ; If it is a crystal, don't shift over the item's X position to be
            ; directly over link, and instead making it right over his left hand
            ; so he can raise it up.
            STZ.b $02
            
            BRA .setCoordinates
        
        .notCrystal5
        
        LDA.b #$06 : STA.b $02
    
    .setCoordinates
    
    ; Did we get this item off a special object?
    LDY.w $02E9 : CPY.b #$03 : BNE .notFromAncilla
        ; Treat special object given items just like text, when it comes to
        ; coordinates.
        LDY.b #$00
    
    .notFromAncilla
    
    ; Set altitude to zero by default.
    STZ.b $08
    STZ.b $09
    
    CPY.b #$02 : BNE .noAltitudeAdjustForNonSprite
        ; $08 = 0xFFF8 (-8).
        LDA.b #$F8 : STA.b $08
                     DEC.b $09
    
    .noAltitudeAdjustForNonSprite

    ; $04 is the method?
    STY.b $04
    STZ.b $05
    
    PLY
    
    REP #$20
    
    ; $00 = 0xFFF2 (-14).
    LDA #$FFF2 : STA.b $00
    
    LDA.b $04 : BEQ .noYAdjustForText
        ; Sign extend the byte to a 2-byte negative offset for the Y coordinate.
        LDA.w Pool_AddReceiveItem_y_offsets, Y
        AND.w #$00FF : ORA.w #$FF00 : STA.b $00
    
    .noYAdjustForText
    
    ; Add to Link's coordinate and adjust altitude with $08.
    LDA.b $00 : CLC : ADC.b $20 : CLC : ADC.b $08 : STA.b $00
    
    LDA.b $04 : BEQ .noXAdjustForText
        ; Sign extend the byte to a 2-byte position offset for the X coordinate.
        LDA.w .x_offsets, Y : AND.w #$00FF : STA.b $02
    
    .noXAdjustForText
    
    ; Add to Link's X coordinate.
    LDA.b $02 : CLC : ADC.b $22
    
    .finishedWithCoords
    
    STA.b $02
    
    SEP #$20
    
    BRL Shortcut_just_coords
    
    .noOpenSlots
    
    PLB
    
    RTL
}

; ==============================================================================
    
; $048932-$048938 DATA
BottleList:
{
    db $16, $2B, $2C, $2D, $3D, $3C, $48
}
    
; $048939-$04893D DATA
PotionList:
{
    db $2E, $2F, $30, $FF, $0E
}
    
; ==============================================================================

; $04893E-$048999 LOCAL JUMP LOCATION
GiveBottledItem:
{
    ; Cache the value of the item to give.
    STY.b $0C
    
    LDX.b #$06
    
    .searchLoop
    
        LDA BottleList, X : CMP.b $0C : BEQ .foundBottle
    DEX : BPL .searchLoop

    ; It's not a bottle, so what is it...?
    BRA .notBottle

    .foundBottle
    
    TXA : CLC : ADC.b #$02 : STA.b $0C
    
    LDX.b #$00
    
    .bottleLoop
    
        ; This loop searches to see if Link has an inventory slot that has no
        ; bottle (an empty bottle counts!) If so, Link acquires the item stored
        ; in variable $0C (along with a bottle).
        LDA.l $7EF35C, X : CMP.b #$02 : BCS .checkNextBottleSlot
            ; Give Link the bottle or bottled item.
            LDA.b $0C : STA.l $7EF35C, X
            
            ; And.... we're done in this routine.
            BRL .finished
        
        .checkNextBottleSlot
    INX : CPX.b #$04 : BNE .bottleLoop
    
    .notBottle
    
    STY.b $0C
    
    LDX.b #$04
    
    .potionSearch
    
        LDA PotionList, X : CMP.b $0C : BEQ .potionMatch
    DEX : BPL .potionSearch
    
    BRA .finished

    .potionMatch
    
    TXA : CLC : ADC.b #$03 : STA.b $0C
    
    LDX.b #$00
    
    .findSlotForPotion
    
        LDA.l $7EF35C, X : CMP.b #$02 : BNE .nonEmptyBottle
            LDA.b $0C : STA.l $7EF35C, X
            
            BRA .finished
    
        .nonEmptyBottle
    INX : CPX.b #$04 : BNE .findSlotForPotion
    
    .finished
    
    RTS
}

; ==============================================================================

; $04899A-$048A31 DATA
Pool_AddWishPondItem:
{
    ; $04899A
    .y_offsets
    db -13, -13, -13, -13, -13, -12, -12, -13
    db -13, -12, -12, -12, -10, -12, -12, -12
    db -12, -12, -12, -12, -12, -12, -12, -12
    db -12, -12, -12, -12, -12, -12, -12, -12
    db -12, -12, -12, -13, -12, -12, -12, -12
    db -12, -12, -10, -12, -12, -12, -12, -12
    db -12, -12, -12, -12, -12, -12, -12, -12
    db -12, -12, -12, -12, -12, -12, -12, -12
    db -12, -12, -12, -12, -12, -12, -12, -12
    db -12, -13, -12, -12
    
    ; $0489E6
    .x_offsets
    db   4,   4,   4,   4,   4,   0,   0,   4
    db   4,   4,   4,   4,   5,   0,   0,   0
    db   0,   0,   0,   4,   0,   4,   0,   0
    db   4,   0,   0,   0,   0,   0,   0,   0
    db   0,   0,   0,   0,  11,   0,   0,   0
    db   2,   0,   5,   0,   0,   0,   0,   0
    db   0,   0,   0,   0,   4,   4,   4,   0
    db   0,   0,   0,   0,   0,   0,   0,   0
    db   0,   0,   4,   4,   0,   4,   0,   0
    db   0,   4,   0,   0
}

; Special effect 0x28 initializer
; $048A32-$048AB9 LONG JUMP LOCATION
AddWishPondItem:
{
    PHB : PHK : PLB
    
    STX.w $02D8
    
    JSR.w AddAncilla : BCS .spawn_failed
        JSL.l Sound_SetSfxPanWithPlayerCoords
        
        ; Play throwing sound effect.
        ORA.b #$13 : STA.w $012F
        
        PHX
        
        ; No item that I've seen in the rom takes on this value here...
        ; but who knows, anything is possible, right?
        LDY.w $02D8
        
        LDA AddReceiveItem_item_graphics_indices, Y : STA.b $72
        
        CMP.b #$FF : BEQ .invalidItem
            ; Check for the hero's shield (the red shield).
            CMP.b #$20 : BNE .getItemTiles
                JSL.l DecompShieldGfx
                
                LDA.b $72
                
                BRA .getItemTiles
        
        .invalidItem
        
        LDA.b #$00
        
        .getItemTiles
        
        JSL.l GetAnimatedSpriteTile_variable
        
        ; Checking for the fighter sword.
        LDA.b $72 : CMP.b #$06 : BNE .notFighterSword
            JSL.l DecompSwordGfx
        
        .notFighterSword
        
        PLX
        
        ; Put Link's hands up like he's going to throw the item (which he will).
        LDA.b #$80 : STA.w $0308
        
        ; Set Link facing forward and his animation index to 0. Also force his
        ; picking stuff up index to 0.
        STZ.w $0309 : STZ.b $2F : STZ.b $2E
        
        LDA.b #$14 : STA.w $0294, X
        LDA.b #$D8 : STA.w $0C22, X
        
        STZ.w $0C2C, X : STZ.w $029E, X
        
        ; ????
        LDA.b #$10 : STA.w $0C68, X
        
        ; Store the item type in this variable.
        LDA.w $02D8 : STA.w $0C5E, X : TAY
        
        REP #$20
        
        ; Set up initial coordinates for the item sprite.
        LDA.w Pool_AddWishPondItem_y_offsets, Y
        AND.w #$00FF : ORA.w #$FF00 : CLC : ADC.b $20 : STA.b $00
        
        LDA.w Pool_AddWishPondItem_x_offsets, Y
        AND.w #$00FF                : CLC : ADC.b $22 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $048ABA-$048ADF DATA
Pool_AddHappinessPondRupees:
{
    ; $048ABA
    .z_speeds
    db  20,  20,  20,  20,  20,  16,  16,  16,  16,  16
    
    ; $048AC4
    .y_speeds
    db -40, -40, -40, -40, -40, -32, -32, -32, -32, -32
    
    ; $048ACE
    .x_speeds
    db   0, -12,  -6,   6,  12,  -9,  -5,   0,   5,   9
    
    ; $048AD8
    .start_rupee_index
    db  0,  4,  4,  9
    
    ; $048ADC
    .end_rupee_index
    db -1,  0, -1, -1
}

; $048AE0-$048B8F LONG JUMP LOCATION
AddHappinessPondRupees:
{
    PHB : PHK : PLB
    
    PHX : PHA
    
    LDY.b #$09
    LDA.b #$42
    
    JSR.w AddAncilla : BCC .open_slot
        PLA : PLX
        
        BRA AddWuishPondItem_spawn_failed
    
    .open_slot
    
    JSL.l Sound_SetSfxPanWithPlayerCoords
    
    ; Play throwing sound effect.
    ORA.b #$13 : STA.w $012F
    
    ; Item we're using is rupees.
    LDY.b #$35
    
    LDA AddReceiveItem_item_graphics_indices, Y : STA.b $72
    
    JSL.l GetAnimatedSpriteTile_variable
    
    ; Put Link's hands up.
    LDA.b #$80 : STA.w $0308
    
    ; Initialize his picking up stuff index, make him face up, and reset his
    ; animation index to zero.
    STZ.w $0309
    
    STZ.b $2F
    
    STZ.b $2E
    
    LDX.b #$09
    LDA.b #$00
    
    .init_rupee_slots
    
    STA.l $7F586C, X : DEX : BPL .init_rupee_slots
    
    ; An input to this function was an index to the number of rupees to throw
    ; which gets translated to a number of rupees to display on screen.
    PLA : TAX
    
    LDA.w Pool_AddHappinessPondRupees_end_rupee_index, X   : STA.b $0F
    LDA.w Pool_AddHappinessPondRupees_start_rupee_index, X : TAY
    
    LDX.b #$09
    
    .next_rupee_slot
    
        LDA.b #$01 : STA.l $7F586C, X
        
        LDA.w Pool_AddHappinessPondRupees_z_speeds, Y : STA.l $7F5818, X
        LDA.w Pool_AddHappinessPondRupees_y_speeds, Y : STA.l $7F5800, X
        LDA.w Pool_AddHappinessPondRupees_x_speeds, Y : STA.l $7F580C, X
        
        LDA.b #$00 : STA.l $7F5854, X
                     STA.l $7F58AA, X
        
        LDA.b #$10 : STA.l $7F5860, X
        
        LDA.b #$35 : STA.l $7F587A, X
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #-12 : STA.b $00
        
        LDA.b $22 : CLC : ADC.w #4 : STA.b $02
        
        SEP #$20
        
        LDA.b $00 : STA.l $7F5824, X
        LDA.b $01 : STA.l $7F5830, X
        
        LDA.b $02 : STA.l $7F583C, X
        LDA.b $03 : STA.l $7F5848, X
        
        DEX
    DEY : CPY.b $0F : BNE .next_rupee_slot
    
    PLX
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $048B90-$048BC0 DATA
Pool_AddPendantOrCrystal:
{
    ; $048B90
    .item_values

    ; $048B90
    .ether_medallion
    db $10
    
    ; $048B91
    .pendants
    db $37, $39, $38
    
    ; $048B94
    .heart_container
    db $26
    
    ; $048B95
    .bombos_medallion
    db $0F
    
    ; $048B96
    .crystal
    db $20
    
    ; $048B97
    .fall_height
    db $60, $80, $80, $80, $80, $80, $80
    
    ; $048B9E
    .y_offsets
    dw $0048, $0078, $0078, $0078, $0078, $0068, $0078
    
    ; $048BAC
    .x_offsets
    dw $0078, $0078, $0078, $0078, $0078, $0080, $0078
    
    ; $048BBA
    .delay_timers
    db $40, $00, $00, $00, $00, $FF, $00
}

; A = 0x29 (pendants/crystals, etc)
; $048BC1-$048C72 LONG JUMP LOCATION
AddPendantOrCrystal:
{  
    PHB : PHK : PLB
    
    STX.w $02D8 ; X contains the value of the item we're going to receive.
    
    JSR.w AddAncilla : BCS AddHappinessPondRupees_spawn_failed
        PHX
        
        ; What is the item?
        LDY.w $02D8
        LDA.w Pool_AddPendantOrCrystal_item_values, Y : STA.w $0C5E, X
        
        CMP Pool_AddPendantOrCrystal_ether_medallion  : BEQ .medallion
        CMP Pool_AddPendantOrCrystal_bombos_medallion : BNE .notMedallion
            .medallion
            
            TAY
            
            LDA AddReceiveItem_item_graphics_indices, Y : STA.b $72
            
            JSL.l GetAnimatedSpriteTile_variable
            
        .notMedallion
        
        PLX
        
        LDA.b #$D0 : STA.w $0294, X
        
        STZ.w $0C22, X
        
        STZ.w $0C2C, X
        
        STZ.w $0C54, X
        
        ; Length or height for the timed fall.
        LDY.w $02D8
        LDA.w Pool_AddPendantOrCrystal_fall_height, Y : STA.w $029E, X
        
        LDA.b #$09 : STA.w $03B1, X
        
        STZ.w $039F, X
        
        STZ.w $0385, X
        
        LDA.w Pool_AddPendantOrCrystal_delay_timers, Y : STA.w $0394, X
        
        ; Load up with the real item value (not an index).
        LDA.w $0C5E, X : STA.w $02D8
        
        CPY.b #$00 : BEQ .medallion2
        CPY.b #$05 : BEQ .medallion2
            ; Make an exception for the Tower of Hera so that the pendant isn't
            ; hard to retrieve or doesn't fall on a hole area.
            LDA.w $040C : CMP.b #$14 : BNE .notTowerOfHera
                LDA.b $21 : AND.b #$FE : INC : STA.b $01
                                               STZ.b $00
                
                LDA.b $23 : AND.b #$FE : INC : STA.b $03
                                               STZ.b $02
                
                BRL Shortcut_just_coords
                
            .notTowerOfHera
            
            ; Handle normal falling items (non medallions).
            TYA : ASL : TAY
            
            REP #$20
            
            LDA.w Pool_AddPendantOrCrystal_y_offsets, Y : CLC : ADC.b $E8 : STA.b $00
            LDA.w Pool_AddPendantOrCrystal_x_offsets, Y : CLC : ADC.b $E2 : STA.b $02
            
            SEP #$20
            
            BRL Shortcut_just_coords
        
        .medallion2
        
        ; Again separate out Medallions.
        TYA : ASL : TAY
        
        REP #$20
        
        LDA.w Pool_AddPendantOrCrystal_y_offsets, Y : CLC : ADC.b $E8 : STA.b $00
        
        LDA.b $22 : CLC : ADC.w #$0000 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
        
        PLB
        
        RTL
}

; ==============================================================================

; $048C73-$048CB0 LONG JUMP LOCATION
AddRecoveredFlute:
{
    PHB : PHK : PLB
    
    ; A = $36
    
    JSR.w AddAncilla : BCS .failure
        STZ.w $0C54, X : STZ.w $029E, X
        
        LDA.l Ancilla_Flute_bounce_z_speeds : STA.w $0294, X
        
        LDY.b #$08
        
        LDA.b $2F : CMP.b #$04 : BNE .notFacingLeft
            LDY.b #$F8
        
        .notFacingLeft
        
        TYA : STA.w $0C2C, X
        
        PHX
        
        LDA.b #$0C
        
        JSL.l GetAnimatedSpriteTile_variable
        
        PLX
        
        REP #$20
        
        LDA.w #$0A8A : STA.b $00
        LDA.w #$0490 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .failure
    
    PLB
    
    RTL
}

; ==============================================================================

; $048CB1-$048CD4 LONG JUMP LOCATION
AddChargedSpinAttackSparkle:
{
    PHB : PHK : PLB

    ; Start at index 0x09 of the active special objects list.
    LDX.b #$09
    
    .checkNextSlot
        LDA.w $0C4A, X : BEQ .emptySlot
            ; If there's a sword sparkle in the way, kill it and put .
            CMP.b #$3C : BEQ .emptySlot
    
    DEX : BPL .checkNextSlot
    
    BRA .cantMakeSparkle
    
    .emptySlot
    
    LDA.b #$0D : STA.w $0C4A, X
    
    LDA.b $EE : STA.w $0C7C, X
    
    LDA.b #$06 : STA.w $0C68, X
    
    .cantMakeSparkle
    
    PLB
    
    RTL
}

; ==============================================================================

; $048CD5-$048D10 DATA
Pool_AddWeathervaneExplosion:
{
    ; $048CD5
    .x_speeds
    db   8,  10,   9,   4,  11,  12, -10,  -8,   4,  -6, -10,  -4
    
    ; $048CE1
    .z_speeds
    db  20,  22,  20,  20,  22,  20,  20,  22,  20,  22,  20,  20
    
    ; $048CED
    .y_coords
    db $B0, $A3, $A0, $A2, $A0, $A8, $A0, $A0, $A8, $A1, $B0, $A0
    
    ; $048CF9
    .x_coords
    db $30, $12, $20, $14, $16, $18, $20, $14, $18, $16, $14, $20
    
    ; $048D05
    .z_coords
    db $00, $02, $04, $06, $03, $08, $0E, $08, $0C, $07, $0A, $08
}

; A = 0x37
; $048D11-$048D8F LONG JUMP LOCATION
AddWeathervaneExplosion:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .spawn_failed
        ; Sets up another timer. This effect has a lot of timers >_<.
        LDA.b #$0A : STA.w $03B1, X
        
        ; Start the timer for the weathervane explosion.
        ; (It won't start counting down immediately, The extended flute sound
        ; effect has to finish first.)
        LDA.b #$80 : STA.w $0394, X
        
        ; Put the special effect in the first stage.
        STZ.w $0C54, X
        STZ.w $039F, X
        
        STZ.w $012E
        
        ; SET TO HALF VOLUME.
        LDA.b #$F2 : STA.w $012C
        
        ; The flute boy's song to activate the weather vane explosion.
        LDA.b #$17 : STA.w $012D
        
        ; Um...?
        LDA.b #$00 : STA.l $7F58B8
        
        REP #$20
        
        ; Set up a timer at this location for the.
        ; weathervane to explode.
        LDA.w #$0280 : STA.l $7F58B6
        
        SEP #$20
        
        LDX.b #$0B
        
        .init_wood_chunks
            
            LDA.b #$00 : STA.l $7F5800, X
            
            LDA.w Pool_AddWeathervaneExplosion_x_speeds, X : STA.l $7F580C, X
            LDA.w Pool_AddWeathervaneExplosion_z_speeds, X : STA.l $7F5818, X
            
            ; Y scroll data for the sprite.
            LDA.w Pool_AddWeathervaneExplosion_y_coords, X : STA.l $7F5824, X
            LDA.b #$07                                     : STA.l $7F5830, X
            
            ; X scroll data for the sprite.
            LDA.w Pool_AddWeathervaneExplosion_x_coords, X : STA.l $7F583C, X
            LDA.b #$02                                     : STA.l $7F5848, X
            LDA.w Pool_AddWeathervaneExplosion_z_coords, X : STA.l $7F5854, X
            
            LDA.b #$01 : STA.l $7F5860, X
            
            TXA : AND.b #$01 : STA.l $7F586C, X
        
        DEX : BPL .init_wood_chunks
    
    .spawn_failed
    
    PLB

    RTL
}

; ==============================================================================

; Sets up some initial values for the bird to use.
; A = $38
; $048D90-$048DD1 LONG JUMP LOCATION
AddTravelBirdIntro:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckIfAlreadyExists : BCS .spawn_failed
        JSR.w AddAncilla : BCS .spawn_failed
            LDA.b #$02 : STA.w $0C72, X
            INC      : STA.w $039F, X
            
            STZ.w $0C54, X
            
            LDA.b #$20 : STA.w $03B1, X
            LDA.b #$74 : STA.w $0C5E, X
            
            STZ.w $0294, X
            STZ.w $0385, X
            STZ.w $029E, X
            STZ.w $03A9, X
            
            REP #$20
            
            ; Coordinates
            LDA.w #$0788 : STA.b $00
            LDA.w #$0200 : STA.b $02
            
            SEP #$20
            
            BRL Shortcut_just_coords
        
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; Special effect 0x39 initializer
; $048DD2-$048DF8 LONG JUMP LOCATION
AddSomarianPlatformPoof:
{
    LDA.b #$39
    
    .next_slot
        
        STA.w $0C4A, X
        
        LDA.b #$07 : STA.w $03B1, X
        
        PHX : PHY
        
        LDY.b #$0F
        
        LDA.w $0E20, Y : CMP.b #$ED : BNE .not_somarian_platform
            LDA.b #$00 : STA.w $0DD0, Y : STA.w $02F5
        
        .not_somaria_platform
    
    DEY : BPL .next_slot
    
    JSL.l Player_TileDetectNearbyLong
    
    PLY : PLX
    
    RTL
}

; ==============================================================================

; Special effect 0x3A initializer
; $048DF9-$048E4D LONG JUMP LOCATION
AddSuperBombExplosion:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCC .open_slot
        BRL .spawn_failed
    
    .open_slot
    
    STZ.w $03EA, X : STZ.w $0C54, X
    STZ.w $03C2, X : STZ.w $0385, X
    
    LDA.l Pool_Ancilla_Bomb_interstate_intervals+1 : STA.w $039F, X
    
    LDA.b #$01 : STA.w $0C5E, X
    
    PHX
    
    LDX.w $02CF
    
    LDA.w $1A00, X : STA.b $00
    LDA.w $1A14, X : STA.b $01
    LDA.w $1A28, X : STA.b $02
    LDA.w $1A3C, X : STA.b $03
    
    PLX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.w #$0010 : STA.b $00
    LDA.b $02 : CLC : ADC.w #$0008 : STA.b $02
    
    SEP #$20
     
    BRL Shortcut_just_coords
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $048E4E-$048EDF LONG JUMP LOCATION
Ancilla_ConfigureRevivalObjects:
{
	PHB : PHK : PLB

	LDA.b #$50 : STA.w $0109
    
    ; Working with ancilla slot 0...
	LDX.b #$00
    
    LDA.b #$40 : STA.w $039F, X

	STZ.w $0C54, X

	LDA.b #$08 : STA.w $0294, X

	STZ.w $0385, X

	LDA.b #$05 : STA.w $0394, X

	STZ.w $0C5E, X : STZ.w $0380, X

	REP #$20

	LDA.b $20 : STA.b $00
	LDA.b $22 : STA.b $02

	SEP #$20
    
    JSR.w Ancilla_SetCoords
    
	STZ.w $029E, X
    
    ; Working with ancilla slot 1...
    INX
    
    STZ.w $029E, X

	LDA.b #$F0 : STA.w $039F, X

	STZ.w $0C54, X : STZ.w $0380, X
    
    ; Working with ancilla slot 2...
	INX

	LDA.b #$02 : STA.w $0C5E, X : STA.b $00 : INC : STA.w $03B1, X

	LDA.b #$08 : STA.w $039F, X

	STZ.w $0C54, X

	PHX

	LDA.b #$03 : STA.w $0C72, X : TAX

	LDA.l Ancilla_MagicPowder_animation_group_offsets, X : CLC : ADC.b $00 : TAX

	LDA.l Pool_Ancilla_MagicPowder_animation_groups, X
    
    PLX
    
    STA.w $03C2, X

	LDY.b #$06

	REP #$20
    
    ; Position of fairy?
	LDA.b $20 : CLC : ADC.w Pool_AddMagicPowder_y_offsets, Y
    CLC : ADC.w #$FFEC : STA.b $00

	LDA.b $22 : CLC : ADC.w #$FFF8
    CLC : ADC.w Pool_AddMagicPowder_x_offsets, Y : STA.b $02

	SEP #$20

	BRL Shortcut_just_coords
}

; ==============================================================================

; A = 0x30
; $048EE0-$048F0B LONG JUMP LOCATION
AddCaneOfByrnaStart:
{ 
    PHB : PHK : PLB
    
    PHA
    
    LDX.b #$04
    
    .checkNextSlot
    
        ; Basically seeing if the cane of byrna spinning sparkle has already
        ; activated.
        LDA.w $0C4A, X : CMP.b #$31 : BNE .notByrnaSparkle
            STZ.w $0C4A, X
        
        .notByrnaSparkle
    
    DEX : BPL .checkNextSlot
    
    ; A = 0x30
    PLA
    
    JSR.w AddAncilla : BCS .noOpenSlots
        STZ.w $0C5E, X
        
        ; TODO: ??? what's this...
        LDA.b #$09 : STA.w $03B1, X
        
        ; Make Link invincible.
        LDA.b #$01 : STA.w $037B
        
        INC : STA.w $039F, X
    
    .noOpenSlots
    
    PLB
    
    RTL
}

; ==============================================================================

; $048F0C-$048F1B DATA
Pool_AddLampFlame:
{
    ; $048F0C
    .y_offsets
    dw -16, 24,   4,  4
    
    ; $048F14
    .x_offsets
    dw   0,  0, -20, 18
}

; $048F1C-$048F5A LONG JUMP LOCATION
AddLampFlame:
{ 
    ; A = $2F
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .noOpenSlots
        STZ.w $0C5E, X : STZ.w $03B1, X
        
        LDA #$17 : STA.w $0C68, X
        
        LDA.b $2F : LSR : STA.w $0C72, X
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $20 : CLC : ADC Pool_AddLampFlame_y_offsets, Y : STA.b $00
        
        LDA.b $22 : CLC : ADC Pool_AddLampFlame_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        JSR.w Ancilla_SetCoords
        
        JSL.l Sound_SfxPanObjectCoords : ORA.b #$2A : STA.w $012E
        
        PLB
        
        RTL

    .noOpenSlots

    ; OPTIMIZE: Just use the other PLB and RTL.
    PLB
    
    RTL
}

; ==============================================================================

; $048F5B-$048F7B LONG JUMP LOCATION
AddShovelDirt:
{
    PHB : PHK : PLB
    
    ; NOTE: A = 0x17;
    JSR.w AddAncilla : BCS .no_open_slots
        STZ.w $0C5E, X
        
        LDA.b #$14 : STA.w $0C68, X
        
        REP #$20
        
        LDA.b $20 : STA.b $00
        LDA.b $22 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
        
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================
    
; The graphical suckfest that is the granting of the master sword.
; $048F7C-$048FA9 LONG JUMP LOCATION
AddSwordCeremony:
{
    PHB : PHK : PLB
    
    ; A = 0x35
    JSR.w AddAncilla : BCS .no_open_slots
        STZ.w $0C5E, X
        
        LDA.b #$02 : STA.w $03B1, X
        
        LDA.b #$40 : STA.w $0C68, X
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #$FFF8 : STA.b $00
        LDA.b $22 : CLC : ADC.w #$0008 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
        
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $048FAA-$048FB9 DATA
Pool_AddDashingDust:
{
    ; $048FAA
    .y_offsets
    dw 20, 4, 16, 16
    
    ; $048FB2
    .x_offsets
    dw  4, 4,  6,  0
}

; $048FBA-$049010 LONG JUMP LOCATION
AddDashingDust:
{
    ; A = #$1E
    PHB : PHK : PLB
    
    LDX.b #$01
    
    BRA .instantiate
    
    ; $048FC1 ALTERNATE ENTRY POINT
    .notYetMoving
    
    ; A = #$1E
    PHB : PHK : PLB
    
    LDX.b #$00
    
    .instantiate
    
    STX.b $72
    
    JSR.w AddAncilla : BCS .noOpenSlots
        LDA.b $72 : STA.w $0C54, X
        
        STZ.w $0C5E, X
        
        LDA.b #$03 : STA.w $0C68, X
        
        LDY.b $2F : TYA : LSR : STA.w $0C72, X
        
        LDA.b $72 : BNE .inMotion
            REP #$20
            
            ; Set Y and X coordinates relative to Link's position.
            LDA.b $20 : CLC : ADC.w #$0014 : STA.b $00
            LDA.b $22 : STA.b $02
            
            SEP #$20
            
            JMP Shortcut_just_coords
        
        .inMotion
        
        REP #$20
        
        ; Set Y and X coordinates relative to Link's direction (because he's
        ; moving).
        LDA.b $20 : CLC : ADC Pool_AddDashingDust_y_offsets, Y : STA.b $00
        
        LDA.b $22 : CLC : ADC Pool_AddDashingDust_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        JMP Shortcut_just_coords
    
    .noOpenSlots
    
    PLB
    
    RTL
}

; ==============================================================================

; $049011-$049030 DATA
AddBlastWallFireball_xy_speeds:
{
    db -64,  0
    db -22, 42
    db -38, 38
    db -42, 22
    db   0, 64
    db  22, 42
    db  38, 38
    db  42, 22
}

; $049031-$049087 LONG JUMP LOCATION
AddBlastWallFireball:
{
    PHB : PHK : PLB
    
    LDX.b #$0A
    
    .check_next_slot
    
        LDA.w $0C4A, X : BEQ .empty_slot
    
    DEX : CPX.b #$04 : BNE .check_next_slot
    
    LDX.b #$FF
    
    BRL .no_open_slots
    
    .empty_slot
    
    ; Place special object 0x32 (whatever it is) into the special object list.
    LDA.b #$32 : STA.w $0C4A, X
    
    ; Store layer information for the object.
    LDA.b $EE : STA.w $0C7C, X
    
    LDA.b #$10 : STA.l $7F0040, X
    
    LDA.b $1A : AND.b #$0F : ASL : TAY
    
    LDA.w .xy_speeds+0, Y : STA.w $0C22, X
    LDA.w .xy_speeds+1, Y : STA.w $0C2C, X
    
    REP #$20
    
    PHX
    
    LDX.b $04
    
    LDA.l $7F0020, X : CLC : ADC.w #$0008 : STA.b $00
    LDA.l $7F0030, X : CLC : ADC.w #$0010 : STA.b $02
    
    PLX
    
    SEP #$20
    
    BRL Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}
    
; ==============================================================================

; $049088-$0490A3 DATA
Pool_AddArrow:
{
    ; $049088
    .y_speeds
    db -30,  30,   0,   0
    
    ; $04908C
    .x_speeds
    db   0,   0, -30,  30
    
    ; $049090 UNUSED: Afaik.
    .unknown_0 
    db 8, 4, 2, 1
    
    ; $049094
    .y_offsets
    dw -4,  3,  4,  4
    
    ; $049098
    .x_offsets
    dw  4,  4,  0,  4
}

; $0490A4-$049101 LONG JUMP LOCATION
AddArrow:
{
    PHB : PHK : PLB
    
    STX.b $76
    
    ; Only one arrow at a time, sorry.
    JSR.w Ancilla_CheckIfAlreadyExists : BCC .not_already_there
        BRL .failure
    
    .not_already_there
    
    ; Try to find an open slot, and get rid of any arrows in the wall if we
    ; have to.
    JSR.w Ancilla_GetRidOfArrowInWall : BCC .openSlot
        BRL .failure
    
    .openSlot
    
    JSL.l Sound_SetSfxPanWithPlayerCoords
    
    ORA.b #$07 : STA.w $012E
    
    STZ.w $03C5, X
    
    LDA.b #$08 : STA.w $0C5E, X
    
    LDA.b $76 : LSR : TAY
    
    ORA.b #$04 : STA.w $0C72, X
    
    LDA.w Pool_AddArrow_x_speeds, Y : STA.w $0C22, X
    LDA.w Pool_AddArrow_y_speeds, Y : STA.w $0C2C, X
    
    LDY.b $76
    
    REP #$20
    
    LDA.b $72 : CLC : ADC.w #$0008 : CLC : ADC Pool_AddArrow_y_offsets, Y : STA.b $00
    LDA.b $74                      : CLC : ADC Pool_AddArrow_x_offsets, Y : STA.b $02
    
    SEP #$20
    
    JSR.w Ancilla_SetCoords
    
    SEC
    
    PLB
    
    RTL
    
    .failure
    
    CLC
    
    PLB
    
    RTL
}
    
; ==============================================================================

; This cloud triggers only when warping between worlds (and you don't have a
; moon pearl).
; $049102-$04912B LONG JUMP LOCATION
AddWarpTransformationCloud:
{ 
    ; A = #$23
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS AddTransformationCloud_noOpenSlots
        ; Make Link invisible (hint hint, cape).
        LDA.b #$0C : STA.b $4B
        
        STZ.w $0C54, X
        
        ; Check on Link's graphic set.
        LDA.w $02E0 : BNE .bunnyLink
            JSL.l Sound_SetSfxPanWithPlayerCoords
            
            ORA.b #$14 : STA.w $012E
            
            BRA .setup
            
        .bunnyLink
        
        JSL.l Sound_SetSfxPanWithPlayerCoords
        
        ORA.b #$15 : STA.w $012E
        
        .setup
        
        BRA AddTransformationCloud_setup
}

; ==============================================================================

; The transformation cloud is the poof that occurs when Link transitions between
; using the cape and not using it. Also used during transitions between being a
; bunny and not.
; $04912C-$04915E LONG JUMP LOCATION
AddTransformationCloud:
{
    PHB : PHK : PLB
    
    ; A = $23
    JSR.w AddAncilla :  BCS .noOpenSlots
        LDA.b #$01 : STA.w $0C54, X : STA.w $02E1
        TSB.b $05
        
        STZ.b $67 : STZ.b $26
        
        ; $049142 ALTERNATE ENTRY POINT
        .setup
        
        STZ.w $0C5E, X
        
        LDA.b #$07 : STA.w $03B1
        
        REP #$20
        
        ; Setup coordinates for the poof.
        LDA.b $20 : CLC : ADC.w #$0004 : STA.b $00
        LDA.b $22                      : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
        
    .noOpenSlots
    
    PLB
    
    ; $04915D ALTERNATE ENTRY POINT
    .return
    
    RTL
}

; ==============================================================================

; $04915F-$0491C2 LONG JUMP LOCATION
AddDwarfTransformationCloud:
{
    PHB : PHK : PLB 
    
    ; A = #$40
    JSR.w AddAncilla : BCS .noOpenSlots
        LDA.l $7EF3CC : CMP.b #$08 : BNE .notLightWorldDwarf
            JSL.l Sound_SetSfxPanWithPlayerCoords
            
            ORA.b #$14 : STA.w $012E
            
            BRA .finishInit
            
        .notLightWorldDwarf
        
        JSL.l Sound_SetSfxPanWithPlayerCoords : ORA.b #$15 : STA.w $012E
        
        .finishInit
        
        STZ.w $0C5E, X : STZ.w $0C54, X
        
        LDA.b #$07 : STA.w $03B1, X
        LDA.b #$01 : STA.w $02F9
        
        LDY.w $02CF
        
        LDA.w $1A00, Y : STA.b $00
        LDA.w $1A14, Y : STA.b $01
        LDA.w $1A28, Y : STA.b $02
        LDA.w $1A3C, Y : STA.b $03
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w #$0004 : STA.b $00
        LDA.b $02 : CLC : ADC.w #$0000 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .noOpenSlots
    
    PLB
    
    RTL
}

; ==============================================================================

; This occurs when Link puts Magic Powder on a bush,
; causing it to disintegrate with a poof.
; $0491C3-$0491FB LONG JUMP LOCATION
AddDisintegratingBushPoof:
{
    PHB : PHK : PLB
    
    LDA.w $0301 : AND.b #$40 : BEQ .notUsingMagicPowder
        LDY.b #$04
        LDA.b #$3F
        
        JSR.w AddAncilla : BCS .noOpenSlots
            STZ.w $0C5E, X
            
            LDA.b #$07 : STA.w $0C68, X
            
            JSL.l Sound_SetSfxPanWithPlayerCoords : ORA.b #$15 : STA.w $012E
            
            REP #$20
            
            LDA.b $74 : CLC : ADC.w #$FFFE : STA.b $00
            
            LDA.b $72 : STA.b $02
            
            SEP #$20
            
            JMP Shortcut_just_coords
    
        .noOpenSlots
    .notUsingMagicPowder
    
    PLB
    
    RTL
}

; ==============================================================================
    
; Triggers the Ether effect
; $0491FC-$0492AB LONG JUMP LOCATION
AddEtherSpell:
{
    PHB : PHK : PLB 
    
    ; A = 0x18
    JSR.w AddAncilla : BCC .slot_available
        BRL .no_open_slots
    
    .slot_available
    
    STZ.w $0C5E, X
    STZ.w $03C2, X
    STZ.w $0C54, X
    
    LDA.b #$01 : STA.w $0112
    INC : STA.w $03B1, X
    INC : STA.w $039F, X
    
    LDA.b #$7F : STA.w $0C22, X
    
    LDA.b #$28 : STA.l $7F5808
    
    LDA.b #$09 : STA.w $0AAA
    
    LDA.b #$40 : STA.l $7F5812
    
    JSL.l Sound_SetSfxPanWithPlayerCoords : ORA.b #$26 : STA.w $012F
    
    LDA.b #$00 : STA.l $7F5800
    LDA.b #$08 : STA.l $7F5801
    LDA.b #$10 : STA.l $7F5802
    LDA.b #$18 : STA.l $7F5803
    LDA.b #$20 : STA.l $7F5804
    LDA.b #$28 : STA.l $7F5805
    LDA.b #$30 : STA.l $7F5806
    LDA.b #$38 : STA.l $7F5807
    
    REP #$20
    
    LDA.b $20 : STA.l $7F5813
    
    LDA.w #$FFF0 : CLC : ADC.b $E8 : STA.b $00 : AND.w #$00F0 : STA.l $7F580C
    
    LDA.b $22 : STA.b $02 : STA.l $7F5815
    CLC : ADC.w #$0008 : STA.l $7F580E
    
    LDA.b $20 : SEC : SBC.w #$0010 : STA.l $7F580A
              CLC : ADC.w #$0024 : STA.l $7F5810
    
    SEP #$20
    
    BRL Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $0492AC-$0492CF LONG JUMP LOCATION
AddVictorySpinEffect:
{
    PHB : PHK : PLB
    
    ; Check if we have a sword.
    LDA.l $7EF359 : INC : AND.b #$FE : BEQ .dontHaveSword
        LDY.b #$00
        LDA.b #$3B
        
        JSR.w AddAncilla : BCS .failure
        
        STZ.w $0C5E, X
        
        LDA.b #$01 : STA.w $039F, X
        LDA.b #$22 : STA.w $03B1, X
        
    .dontHaveSword
    
    PLB
    
    RTL
}

; ==============================================================================

; $0492D0-$0492EF DATA
Pool_AddMagicPowder:
{
    ; $0492D0
    .y_offsets
    dw   1 ; Up
    dw  40 ; Down
    dw  22 ; Left
    dw  22 ; Right
    
    ; $0492D8
    .x_offsets
    dw  10 ; Up
    dw  10 ; Down
    dw  -8 ; Left
    dw  28 ; Right
    
    ; $0492E0
    .tile_check_offset_y
    dw   0 ; Up
    dw  20 ; Down
    dw  16 ; Left
    dw  16 ; Right

    ; $0492E8
    .tile_check_offset_x
    dw  -2 ; Up
    dw  -2 ; Down
    dw -12 ; Left
    dw  12 ; Right
}

; $0492F0-$049384 LONG JUMP LOCATION
AddMagicPowder:
{
    ; A = 0x1A
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCC .open_slot
        BRL .no_open_slots
    
    .open_slot
    
    STZ.w $0C5E, X : STZ.w $029E, X
    
    LDA.b #$01 : STA.w $03B1, X
    LDA.b #$50 : STA.w $0109
    
    PHX
    
    LDY.b $2F : TYA : LSR : STA.w $0C72, X : TAX
    
    LDA.l Ancilla_MagicPowder_animation_group_offsets, X : TAX
    
    LDA.l Pool_Ancilla_MagicPowder_animation_groups, X : PHX : STA.w $03C2, X
    
    LDY.b $2F
    
    REP #$20
    
    LDA.b $20 : CLC : ADC.w Pool_AddMagicPowder_tile_check_offset_y, Y : STA.b $04
    LDA.b $22 : CLC : ADC.w Pool_AddMagicPowder_tile_check_offset_x, Y : STA.b $06
    
    SEP #$20
    
    LDA.b $04 : STA.w $0BFA, X
    LDA.b $05 : STA.w $0C0E, X
    LDA.b $06 : STA.w $0C04, X
    LDA.b $07 : STA.w $0C18, X
    
    JSL.l Ancilla_CheckTileCollisionLong
    
    LDA.w $03E4, X : STA.w $0333
    
    ; \tcrf. Um.... am I seeing this correctly? This is the only thing
    ; stopping the torch from having the same effect as the magic powder?
    ; update: yes, that is correct.
    LDA.w $0304 : CMP.b #$09 : BNE .torch_not_equipped
        STZ.w $0C4A, X
        
        BRA .no_open_slots
        
    .torch_not_equipped
    
    LDY.b $2F
    
    REP #$20
    
    LDA.b $20 : CLC : ADC Pool_AddMagicPowder_y_offsets, Y : STA.b $00
    
    LDA.b $22 : CLC : ADC Pool_AddMagicPowder_x_offsets, Y : STA.b $02
    
    SEP #$20
    
    JSL.l Sound_SetSfxPanWithPlayerCoords
    
    ORA.b #$0D : STA.w $012E
    
    JMP Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $049385-$049394 DATA
Pool_AddWallTapSpark:
{
    ; $049385
    .y_offsets
    dw -4,  32,  17,  17
    
    ; $04938D
    .x_offsets
    dw 11,  10, -12,  29
}

; $049395-$0493C1 LONG JUMP LOCATION
AddWallTapSpark:
{
    PHB : PHK : PLB
    
    ; A = #$1B
    JSR.w AddAncilla : BCS .no_open_slots
        LDA.b #$05 : STA.w $0C5E, X
        
        LDA.b #$01 : STA.w $03B1, X
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $20 : CLC : ADC Pool_AddWallTapSpark_y_offsets, Y : STA.b $00
        
        LDA.b $22 : CLC : ADC Pool_AddWallTapSpark_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $0493C2-$0493E8 LONG JUMP LOCATION
AddSwordSwingSparkles:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .no_open_slots
        STZ.w $0C5E, X
        
        LDA.b #$01 : STA.w $03B1, X
        
        LDA.b $2F : LSR : STA.w $0C72, X
        
        REP #$20
        
        LDA.b $20 : STA.b $00
        LDA.b $22 : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $0493E9-$0493F2 DATA
Pool_AddDashTremor:
{
    ; $0493E9
    .axis
    db $02, $02, $00, $00
    
    ; $0493ED
    .offsets
    dw 3, -3
    
    ; $0493F1
    .xy_thresholds
    db $80, $78
}

; $0493F3-$049447 LONG JUMP LOCATION
AddDashTremor:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckIfAlreadyExists : BCS .spawn_failed
        JSR.w AddAncilla : BCS .spawn_failed
            LDA.b #$10 : STA.w $0C5E, X
            
            STZ.w $0385, X
            
            LDA.b $2F : LSR : TAY
            
            LDA.w Pool_AddDashTremor_axis, Y : STA.w $0C72, X : TAY
            
            REP #$20
            
            LDA.b $20 : SEC : SBC.b $E8 : STA.b $02
            LDA.b $22 : SEC : SBC.b $E2 : STA.b $00
            
            SEP #$20
            
            PHX
            
            TYA : LSR : TAX
            
            ; As the screen is wider than it is tall, there are different
            ; thresholds for determining the polarity of the tremor.
            LDA.w Pool_AddDashTremor_xy_thresholds, X : STA.b $06
            
            TYX
            
            LDY.b #$00
            
            ; 'to left or above' means that for the respective axis the tremor
            ; is set to affect, this is testing for one of those conditions, but
            ; not both simultaneously. Again, The tremor only affects one axis
            ; per instantiation.
            LDA.b $00, X : CMP.b $06 : BCC .to_left_or_above
                LDY.b #$02
            
            .to_left_or_above
            
            PLX
            
            LDA.w Pool_AddDashTremor_offsets+0, Y : STA.w $0BFA, X
            LDA.w Pool_AddDashTremor_offsets+1, Y : STA.w $0C0E, X
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $049448-$049477 DATA
Pool_AddBoomerangWallHit:
{
    ; $049448
    .y_offsets
    dw 0,  8,  8,  8,  4,  8, 12,  8
    
    ; $049458
    .x_offsets
    dw 8,  8,  0, 10, 12,  8,  4,  0
    
    ; $049468
    .offset_indices
    db 0,  6,  4,  0,  2, 10, 12,  0
    db 0,  8, 14,  0,  0,  0,  0,  0
}

; $049478-$0494C5 LONG JUMP LOCATION
AddBoomerangWallHit:
{
    ; A = 0x06
    PHB : PHK : PLB
    
    LDA.w $0BFA, X : STA.w $0399
    LDA.w $0C0E, X : STA.w $039A
    
    LDA.w $0C04, X : STA.w $039B
    LDA.w $0C18, X : STA.w $039C
    
    LDY.b #$01
    LDA.b #$06
    
    JSR.w AddAncilla : BCS .no_open_slots
        STZ.w $0C5E, X
        
        LDA.b #$01 : STA.w $039F
        
        ; Based on the directional components of the boomerang, supply an
        ; index into a list of offsets that indicate where to place the wall
        ; hit object.
        ; Also BUG: Do the boomerang and hookshot interfere with one another?
        ; Since they use this same global variable I'd be inclined to say yes,
        ; but it should be investigated. Perhaps one is deactivated if the
        ; other becomes active.
        LDY.w $039D 
        LDA.w Pool_AddBoomerangWallHit_offset_indices, Y : TAY
        
        REP #$20
        
        LDA.w $0399 : CLC : ADC Pool_AddBoomerangWallHit_y_offsets, Y : STA.b $00
        LDA.w $039B : CLC : ADC Pool_AddBoomerangWallHit_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================
    
; $0494C6-$0494FD LONG JUMP LOCATION
AddHookshotWallHit:
{
    ; A = 0x06
    PHB : PHK : PLB
    
    STX.b $74
    
    JSR.w AddAncilla : BCS AddBoomerangWallHit_no_open_slots
        STZ.w $0C5E, X
        
        LDA.b #$01 : STA.w $039F, X
        
        PHX
        
        LDX.b $74
        
        JSR.w Ancilla_GetCoords
        
        LDA.w $0C72, X : ASL : TAY
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w Pool_AddBoomerangWallHit_y_offsets, Y : STA.b $00
        LDA.b $02 : CLC : ADC.w Pool_AddBoomerangWallHit_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        PLX
        
        BRL Shortcut_just_coords
    
    ; $0494FB ALTERNATE ENTRY POINT
    .return
    
    BRL AddTravelBird_return
}
    
; ==============================================================================

; $0494FE-$04951C LONG JUMP LOCATION
AddTravelBird_pick_up:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckIfAlreadyExists : BCS AddHookshotWallHit_return
        JSR.w AddAncilla : BCS AddHookshotWallHit_return
            LDA.b #$78 : STA.w $0C68, X
            
            STZ.w $0385, X
            STZ.w $0294, X
            STZ.w $029E, X
            
            LDY.b #$00
            
            BRA AddTravelBird_drop_off_init_invariants
}

; $04951D-$049588 LONG JUMP LOCATION
AddTravelBird_drop_off:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckIfAlreadyExists : BCS .return
        JSR.w AddAncilla : BCS .spawn_failed
            LDA.b #$00 : STA.b $5D
                        STZ.b $5E
            
            LDA.b $3A : AND.b #$7E : STA.b $3A
            
            STZ.b $3C
            STZ.b $3D
            
            LDA.b $50 : AND.b #$FE : STA.b $50
            
            LDA.b #$01 : STA.w $0385, X
            LDA.b #$28 : STA.w $0294, X
            LDA.b #$CD : STA.w $029E, X
            
            LDY.b #$02
            
            ; Meaning, the things that are the same regardless of drop off or
            ; pick up.
            ; $049551 ALTERNATE ENTRY POINT
            .init_invariants
            
            TYA : STA.w $0C54, X
            
            STZ.w $0C22, X
            STZ.w $0C5E, X
            
            LDA.b #$01 : STA.w $03B1, X
            LDA.b #$38 : STA.w $0C2C, X
            
            LDA #$03 : STA.w $039F, X
            
            STZ.w $0380, X
            STZ.w $0394, X
            
            REP #$20
            
            LDA.b $20 : SEC : SBC.w #8 : STA.b $00
            
            LDA.w #-16 : CLC : ADC.b $E2 : STA.b $02
            
            SEP #$20
            
            BRL Shortcut_just_coords
            
        ; $049587 ALTERNATE ENTRY POINT
        .spawn_failed
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $049589-$0495FA LONG JUMP LOCATION
AddQuakeSpell:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCC .open_slot
        BRL .spawn_failed
    
    .open_slot
    
    STZ.w $0C54, X : STZ.w $0C5E, X
    
    LDA.b #$0D : STA.w $0AAA
    
    LDA.b #$35 : STA.w $012E
    
    LDA.b #$00 : STA.l $7F5805
                 STA.l $7F5806
                 STA.l $7F5807
                 STA.l $7F5808
                 STA.l $7F5809
                 STA.l $7F580A
    
    INC : STA.l $7F5800
            STA.l $7F5801
            STA.l $7F5802
            STA.l $7F5803
            STA.l $7F5804 
            STA.w $0112
    
    INC : STA.w $0C68, X
    
    REP #$20
    
    LDA.b $20 : CLC : ADC.w #$001A : STA.l $7F580B
    LDA.b $22 : CLC : ADC.w #$0008 : STA.l $7F580D
    
    LDA.w #$0003 : STA.l $7F581E
    
    SEP #$20
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $0495FB-$04960A DATA
Pool_AddSpinAttackStartSparkle:
{
    ; $0495FB
    .y_offsets
    dw 32,  -8,  10,  20
    
    ; ; $049603
    .x_offsets
    dw 10,   7,  28, -10
}

; A = 0x2A
; $04960B-$049659 LONG JUMP LOCATION
AddSpinAttackStartSparkle:
{
    PHB : PHK : PLB
    
    STX.b $72
    
    JSR.w AddAncilla : BCS .spawn_failed
        STX.b $00
        
        LDX.b #$04
        
        .next_slot
            LDA.w $0C4A, X : CMP.b #$31 : BNE .not_cane_spark
                STZ.w $0C4A, X
            
            .not_cane_spark
        
        DEX : BPL .next_slot
        
        LDX.b $00 : STZ.w $0C5E, X
        
        LDY.b #$04
        
        LDA.b $72 : STA.w $0C54, X : BEQ .never
            ; WTF: (confirmed) No difference in the logic here. What's the point?
            LDY.b #$04
            
        .never
        
        TYA : STA.w $0C68, X
        
        LDA.b #$03 : STA.w $03B1, X
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w Pool_AddSpinAttackStartSparkle_y_offsets, Y : STA.b $00
        
        LDA.b $22 : CLC : ADC.w Pool_AddSpinAttackStartSparkle_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        BRL Shortcut_just_coords
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $04965A-$049689 DATA
Pool_AddBlastWall:
{
    ; $04965A
    .xy_offsets
    dw  -8,   0 ; Up
    dw  -8,  16 ; Down
    dw  16,   0 ; Left
    dw  16,  16 ; Right

    dw   0,  -8 ; Up
    dw  16,  -8 ; Down
    dw   0,  16 ; Left
    dw  16,  16 ; Right

    ; $04967A
    .base_offset_y
    dw -16 ; Up
    dw  16 ; Down
    dw   0 ; Left
    dw   0 ; Right

    ; $049682
    .base_offset_x
    dw   0 ; Up
    dw   0 ; Down
    dw -16 ; Left
    dw  16 ; Right
}

; $04968A-$049691 DATA
AncillaPanValues:
{
    db $80, $80, $80 ; Left
    db $00, $00      ; Middle
    db $40, $40, $40 ; Right
}

; $049692-$049756 LONG JUMP LOCATION
AddBlastWall:
{
    PHB : PHK : PLB
    
    ; Put it into two different slots... interesting.
    LDA.b #$33 : STA.w $0C4A
                 STA.w $0C4B 
    
    STZ.w $0C4C
    STZ.w $0C4D
    STZ.w $0C4E
    STZ.w $0C4F
    STZ.w $0C5E
    
    STZ.w $02EC
    
    STZ.w $0308
    
    STZ.b $50
    
    STZ.w $0380
    
    LDA.b $EE : STA.w $0C7C
              STA.w $0C7D
    
    LDA.w $0476 : STA.w $03CA
    
    LDA.b #$00 : STA.l $7F0010
                 STA.l $7F0009
                 STA.l $7F0001
                 STA.l $7F0011
    
    INC : STA.l $7F0000
            STA.w $0112
    
    LDA.b #$03 : STA.l $7F0008
    
    LDA.l $7F001C : TAY
    
    REP #$20
    
    LDA.w Pool_AddBlastWall_base_offset_y, Y
    CLC : ADC.l $7F0018 : STA.l $7F0018

    LDA.w Pool_AddBlastWall_base_offset_x, Y
    CLC : ADC.l $7F001A : STA.l $7F001A
    
    SEP #$20
    
    LDY.b #$00
    
    ; TODO: Figure out what's going on here.
    LDA.l $7F001C : CMP.b #$04 : BCS .unknown
        LDY.b #$10
    
    .unknown
    
    LDX.b #$06
    
    .init_component_loop
        
        REP #$20
        
        LDA.w Pool_AddBlastWall_xy_offsets+0, Y
        CLC : ADC.l $7F0018 : STA.l $7F0020, X

        LDA.w Pool_AddBlastWall_xy_offsets+2, Y
        CLC : ADC.l $7F001A : STA.l $7F0030, X
        
        SEC : SBC.b $E2 : STA.b $00
        
        SEP #$20
        
        LDA.b $01 : BNE .off_screen_so_no_SFX
            PHY : PHX
            
            LDA.b $00 : LSR #5 : TAX
            
            LDA.w AncillaPanValues, X : ORA.b #$0C : STA.w $012E
            
            PLX : PLY
        
        .off_screen_so_no_SFX
        
        INY #4
    DEX #2 : BPL .init_component_loop
    
    PLB
    
    RTL
}

; ==============================================================================

; $049757-$0497CD LONG JUMP LOCATION
AddSwordChargeSpark:
{
    PHB : PHK : PLB
    
    STX.b $72
    
    LDX.b #$09
    
    .next_slot
    
        LDA.w $0C4A, X : BEQ .open_slot
    DEX : BPL .next_slot
    
    BRL .noOpenSlots
    
    .open_slot
    
    ; Put the sparkly effects into memory, if possible.
    LDA.b #$3C : STA.w $0C4A, X
    
    ; Whatever floor Link is on, make sure the sparklies have that status as
    ; well.
    LDA.b $EE : STA.w $0C7C, X
    
    STZ.w $0C5E, X
    
    ; Appears to be the stage the effect is in.
    LDA.b #$04 : STA.w $0C68, X
    
    JSL.l GetRandomInt : STA.b $08
    
    PHX
    
    LDX.b $72
    
    JSR.w Ancilla_GetCoords
    
    STZ.b $0B
    
    LDA.w $029E, X : CMP.b #$F8 : BCC .delta
        LDA.b #$00
    
    .delta
    
    STA.b $0A
    
    PLX
    
    LDA.b $08 : AND.b #$0F : STA.b $04
                             STZ.b $05
    
    LDA.b $08 : LSR #5 : STA.b $06
                         STZ.b $07
    
    REP #$20
    
    LDA.b $0A : EOR.w #$FFFF : INC A
                             CLC : ADC.b $00
                             CLC : ADC.w #-2
                             CLC : ADC.b $04 : STA.b $00
    
    LDA.b $02 : CLC : ADC.b $06
              CLC : ADC.w #2 : STA.b $02
    
    SEP #$20
    
    BRL Shortcut_just_coords
    
    .noOpenSlots
    
    PLB
    
    RTL
}

; ==============================================================================

; $0497CE-$0497DD DATA
Pool_AddSilverArrowSparkle:
{
    ; $0497CE
    .y_offsets
    dw  0,  2, -4, -4
    
    ; $0497D2
    .x_offsets
    dw -4, -4,  0,  2
}

; $0497DE-$04984A LONG JUMP LOCATION
AddSilverArrowSparkle:
{
    PHB : PHK : PLB
    
    STX.b $72
    
    LDX.b #$09
    
    .next_slot
    
        LDA.w $0C4A, X : BEQ .empty_slot
    DEX : BPL .next_slot
    
    BRL .no_open_slots
    
    .empty_slot
    
    ; Add sparkle... the motivation for this routine in particular escapes
    ; me though.
    LDA.b #$3C : STA.w $0C4A, X
    
    STZ.w $0C5E, X
    
    LDA.b #$04 : STA.w $0C68, X
    
    LDA.b $EE : STA.w $0C7C, X
    
    JSL.l GetRandomInt : STA.b $08
    
    PHX
    
    LDX.b $72
    
    JSR.w Ancilla_GetCoords
    
    STZ.b $0B
    
    LDA.b $08 : AND.b #$07 : STA.b $04
    STZ.b $05
    
    LDA.b $08 : AND.b #$70 : LSR #4 : STA.b $06
    STZ.b $07
    
    LDA.w $0C72, X : AND.b #$03 : ASL : TAY
    
    PLX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC Pool_AddSilverArrowSparkle_y_offsets, Y
    CLC : ADC.b $04 : STA.b $00
    
    LDA.b $02 : CLC : ADC Pool_AddSilverArrowSparkle_x_offsets, Y
    CLC : ADC.b $06 : STA.b $02
    
    SEP #$20
    
    BRL Shortcut_just_coords
    
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; $04984B-$049862 DATA
Pool_AddIceRodShot:
{
    ; $04984B
    .y_offsets
    dw -16, 24,   8,   8
    
    ; $049853
    .x_offsets
    dw   0,  0, -20,  20
    
    ; $04985B
    .y_speeds
    db -48,  48,   0,   0
    
    ; $04985F
    .x_speeds
    db   0,   0, -48,  48
}

; $049863-$0498FB LONG JUMP LOCATION
AddIceRodShot:
{
    ; A = 0x0B
    PHB : PHK  : PLB
    
    JSR.w AddAncilla : BCC .open_slot
        LDX.b #$00 : JSL.l LinkItem_ReturnUnusedMagic
        
        BRA AddSilverArrowSparkle_noOpenSlots
    
    .open_slot
    
    JSL.l Sound_SetSfxPanWithPlayerCoords
    
    ORA.b #$0F : STA.w $012E
    
    STZ.w $0C54, X : STZ.w $03C2, X
    
    LDA.b #$FF : STA.w $0C5E, X
    
    LDA.b #$01 : STA.w $0385
    
    LDA.b #$03 : STA.w $03B1, X
    LDA.b #$06 : STA.w $039F, X
    
    LDA.b $2F : LSR : STA.w $0C72, X : TAY
    
    LDA.w Pool_AddIceRodShot_y_speeds, Y : STA.w $0C22, X
    
    LDA.w Pool_AddIceRodShot_x_speeds, Y : STA.w $0C2C, X
    
    PHY : PHX
    
    JSL.l Ancilla_CheckInitialTileCollision_Class_1
    
    PLX : PLY
    
    BCS .asplode_ice_rod_shot
        LDY.b $2F
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w Pool_AddIceRodShot_y_offsets, Y : STA.b $00
        
        SEC : SBC.b $E8 : STA.b $04
        
        LDA.b $22 : CLC : ADC.w Pool_AddIceRodShot_x_offsets, Y : STA.b $02
        
        SEC : SBC.b $E2 : STA.b $06
        
        SEP #$20
        
        LDA.b $05 : ORA.b $07 : BEQ .on_screen
            ; Terminate the object because it's going to initialize off screen.
            STZ.w $0C4A, X
            
            BRA .return
            
        .on_screen
        
        BRL Shortcut_just_coords
        
        .return
        
        PLB
        
        RTL
    
    .asplode_ice_rod_shot
    
    PHX
    
    ; Make an ice rod shot explode on a wall.
    LDA.b #$11 : STA.w $0C4A, X : TAX
    
    LDA.l AncillaObjectAllocation, X
    
    PLX 
    
    STA.w $0C90, X
    
    STZ.w $0C5E, X
    
    LDA.b #$04 : STA.w $03B1, X
    
    PLB
    
    RTL
}

; ==============================================================================

; A = 0x15
; $0498FC-$049939 LONG JUMP LOCATION
AddTransitionSplash:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .noOpenSlots
        JSL.l Sound_SetSfxPanWithPlayerCoords
        
        ORA.b #$24 : STA.w $012E
        
        STZ.w $0C5E, X
        
        LDA.b #$02 : STA.w $03B1, X
        
        LDA.b $1B : BEQ .dontChangeFloors
            LDA.w $0345 : BNE .dontChangeFloors
                ; Changing floors to get in and out of water only applies
                ; indoors.
                STZ.b $EE
            
        .dontChangeFloors
        
        REP #$20
        
        LDA.b $20 : CLC : ADC.w #$0008 : STA.b $00
        LDA.b $22 : CLC : ADC.w #$FFF5 : STA.b $02
        
        SEP #$20
        
        JSR.w Ancilla_SetCoords
        
        CLC
    
    .noOpenSlots
    
    PLB
    
    RTL
}

; ==============================================================================

; $04993A-$0499E8 DATA
Pool_AddGravestone:
{
    ; $04993A
    .y_coordinates
    dw $0550, $0540, $0530, $0520, $0500, $04E0, $04C0, $04B0
    
    ; $04994A
    .x_coordinates
    
    ; These numbers are just guidelines that correspond to the data in
    ; the label we need to name below ($0499E0).
    ; 0x00
    dw $08B0
    
    ; 0x02
    dw $08F0, $0910, $0950
    
    ; 0x08
    dw $0970, $09A0
    
    ; 0x0c
    dw $0850, $0870
    
    ; 0x10
    dw $08B0, $08F0, $0920, $0950
    
    ; 0x18
    dw $0880
    
    ; 0x1a
    dw $0990
    
    ; 0x1c
    dw $0840
    
    ; TODO: I'm punting on this. Fill in the rest of the data later.
    ; $049968
    .yPosition
    dw $0540, $0350, $0530, $0530, $0520, $0520, $0510, $0510
    dw $04F0, $04F0, $04F0, $04F0, $04D0, $04B0, $04A0

    ; $049986
    .xPosition
    dw $08B0, $08F0, $0910, $0950, $0970, $09A0, $0850, $0870
    dw $08B0, $08F0, $0920, $0950, $0880, $0990, $0840

    ; $0499A4
    .tilemapPosition
    dw $0A16, $099E, $09A2, $09AA, $092E, $0934, $088A, $088E
    dw $0796, $079E, $07A4, $07AA, $0690, $05B2, $0508
    
    ; $0499C2
    .GFX
    dw $0030, $0030, $0030, $0030, $0030, $0030, $0030, $0030
    dw $0030, $0030, $0030, $0030, $0030, $0038, $0058

    ; $0499E0
    .offset_data_x
    db $00, $02, $08, $0C, $10, $18, $1A, $1C, $1E
}

; A = 0x24
; $0499E9-$049AF7 LONG JUMP LOCATION
AddGravestone:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCC .open_slot
        BRL .no_open_slots
    
    .open_slot
    
    REP #$30
    
    LDY.b $20
    
    TYA : AND.w #$000F : CMP.w #$0007 : BCS .round_to_next_tile
        TYA
        
        BRA .clipTo16Pixels
    
    .round_to_next_tile
    
    TYA : CLC : ADC.w #$0010
    
    .clipTo16Pixels
    
    AND.w #$FFF0 : STA.b $00
    
    LDY.w #$000E
    
    .y_coord_next
    
        LDA.b $00 : CMP .y_coordinates, Y : BEQ .y_coord_match
    DEY #2 : BPL .y_coord_next
    
    BRA .terminate_object
    
    .y_coord_match
    
    TYA : LSR : TAY
    
    LDA.w Pool_AddGravestone_offset_data_x+1, Y : AND.w #$00FF : STA.b $00
    
    ; Get index of corresponding X coordinate
    LDA.w Pool_AddGravestone_offset_data_x+0, Y : AND.w #$00FF : TAY
    
    .xCoordNext
    
        LDA.w Pool_AddGravestone_x_coordinates, Y : CMP.b $22 : BCS .xCoordNonMatch
            CLC : ADC.w #$000F : CMP.b $22 : BCC .xCoordNonMatch
                ; X coord was a match, but only one of the graves is dashable in
                ; the game (this is hardcoded here).
                CPY.w #$001A : BNE .nondashable_grave
                    ; The dashable gravestone is only able to be opened with
                    ; dashing, not by pushing seems silly.
                    LDA.w $0372 : AND.w #$00FF : BEQ .terminate_object
                        BRA .success
                    
                .nondashable_grave
                
                ; Self terminate if we tried to dash a nondashable grave stone.
                LDA.w $0372 : AND.w #$00FF : BNE .terminate_object
                    BRA .success
            
        .xCoordNonMatch
    INY #2 : CPY.b $00 : BNE .xCoordNext
    
    .terminate_object
    
    SEP #$30
    
    STZ.w $0C4A, X
    
    BRL .no_open_slots
    
    .success
    
    LDA.w Pool_AddGravestone_tilemapPosition, Y : STA.w $0698
    
    SEC : SBC.w #$0080 : STA.b $72
    
    LDA.w Pool_AddGravestone_GFX, Y : STA.w $0692
    CMP.w #$0058 : BEQ .holeUnderGrave
        CMP.w #$0038 : BNE .notStairsUnderGrave
            SEP #$30
            
            PHX
            
            ; Save a flag in SRAM so that the path to the cape chest will be
            ; revealed next time this map loads.
            LDX.b $8A : LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
            
            PLX

    .holeUnderGrave

    SEP #$30
    
    ; Play sound effect.
    JSL.l Sound_SetSfxPanWithPlayerCoords

    ORA.b #$1B : STA.w $012F

    .notStairsUnderGrave

    SEP #$30
    
    LDA.b $72 : STA.w $03BA, X
    LDA.b $73 : STA.w $03B6, X
    
    PHY : PHX
    
    ; Perform the first half (lower half) of the map16 modifications that
    ; result from moving the grave. The second half will be accomplished
    ; later when the gravestone has moved up a bit.
    JSL.l Overworld_DoMapUpdate32x32_Long
    
    PLX : PLY
    
    REP #$30
    
    TYA : AND.w #$00FF : TAY
    
    ; Load the tilemap locations of the graves.
    LDA.w Pool_AddGravestone_yPosition, Y : CLC : ADC.w #$FFFE : STA.b $00
    
    CLC : ADC.w #$FFF0 : STA.b $04
    
    LDA.w Pool_AddGravestone_xPosition, Y : STA.b $02
    
    SEP #$30
    
    LDA.w $012F : AND.b #$3F : CMP.b #$1B : BEQ .puzzleSoundPlaying
        JSL.l Sound_SetSfxPanWithPlayerCoords
        
        ; If there's no mystery solved sound, just play the sound
        ; that happens when something's dragging on the floor.
        ORA.b #$22 : STA.w $012E
        
    .puzzleSoundPlaying
    
    LDA.b #$04 : STA.b $48
    
    LDA.b #$01 : STA.w $03E9
    
    LDA.b $04 : STA.w $038A, X
    LDA.b $05 : STA.w $038F, X
    
    BRL Shortcut_set_8Bit

    .no_open_slots

    PLB
    
    RTL
}

; ==============================================================================

; $049AF8-$049B0F
Pool_AddHookshot:
{
    ; $049AF8
    .y_speeds
    db -64, 64,   0,  0
    
    ; $049AFC
    .x_speeds
    db   0,  0, -64, 64
    
    ; $049B00
    .y_offsets
    dw 4, 20,  8,  8
    
    ; $049B08
    .x_offsets
    dw 0,  0, -4, 11
}

; $049B10-$049B67 LONG JUMP LOCATION
AddHookshot:
{
    PHB : PHK : PLB
    
    JSR.w AddAncilla : BCS .no_open_slots
        LDA.b #$03 : STA.w $03B1, X
        
        STZ.w $0C5E, X
        STZ.w $0C54, X
        STZ.w $0385, X
        STZ.w $037E
        
        STX.w $039D
        
        STZ.w $0380, X
        
        LDA.b #$FF : STA.w $0394, X
        
        STZ.w $03A4, X
        STZ.w $0C68, X
        
        LDA.b $2F : LSR : STA.w $0C72, X : TAY
        
        LDA.w Pool_AddHookshot_y_speeds, Y : STA.w $0C22, X
        LDA.w Pool_AddHookshot_x_speeds, Y : STA.w $0C2C, X
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $20 : CLC : ADC Pool_AddHookshot_y_offsets, Y : STA.b $00
        LDA.b $22 : CLC : ADC Pool_AddHookshot_x_offsets, Y : STA.b $02
        
        SEP #$20
        
        JMP Shortcut_just_coords
        
    .no_open_slots
    
    PLB
    
    RTL
}

; ==============================================================================

; Splash of water over Link's head that occurs
; outside of the entrance to the waterfall of wishing.
; $049B68-$049B82 LONG JUMP LOCATION
AddWaterfallSplash:
{
	PHB : PHK : PLB
    
	LDY.b #$04
	LDA.b #$41
    
	JSR.w Ancilla_CheckIfAlreadyExists : BCS .already_present
        JSR.w AddAncilla : BCS .no_open_slots
            LDA.b #$02 : STA.w $0C68, X
            
            STZ.w $0C5E, X

        .no_open_slots

    ; $049B81 ALTERNATE ENTRY POINT
    .already_present
    
	PLB
    
	RTL
}

; ==============================================================================

; Waterfall sprite sees if you can open Ganon's tower.
; $049B83-$049C35 LONG JUMP LOCATION
AddBreakTowerSeal:
{
    PHB : PHK : PLB
    
    LDA.w $0308 : AND.b #$80 : ORA.b $4D : BNE AddWaterfallSplash_no_open_slots
        ; Don't have enough crystals?
        LDA.l $7EF37A : AND.b #$7F : CMP.b #$7F : BNE AddWaterfallSplash_no_open_slots
            ; Ganon's tower already opened.
            LDA.l $7EF2C3 : AND.b #$20 : BNE AddWaterfallSplash_no_open_slots
                JSL.l Ancilla_TerminateSparkleObjects
                
                LDY.b #$04
                LDA.b #$43
                
                JSR.w Ancilla_CheckIfAlreadyExists : BCS AddWaterfallSplash_no_open_slots
                    JSR.w AddAncilla : BCS AddWaterfallSplash_no_open_slots
                        PHX
                        
                        LDX.b #$0F
                        
                        .check_next_sprite
                        
                            LDA.w $0E20, X : CMP.b #$37 : BNE .not_waterfall
                                ; Kill the waterfall sprite after it starts the
                                ; sequence.
                                STZ.w $0DD0, X 
                            
                            .not_waterfall
                        DEX : BPL .check_next_sprite
                        
                        ; Initialize all the sparkles to be inactive.
                        LDX.b #$17
                        LDA.b #$FF
                        
                        .next_sparkle
                        
                            STA.l $7F5837, X
                        DEX : BPL .next_sparkle
                        
                        LDA.b #$28 : STA.b $72
                        
                        JSL.l GetAnimatedSpriteTile_variable
                        
                        LDA.b #$04 : STA.w $0AB1
                        LDA.b #$02 : STA.w $0AA9
                        
                        JSL.l Palette_MiscSpr_justSP6
                        
                        ; Update CGRAM on next NMI.
                        INC.b $15
                        
                        PLX
                        
                        ; Make Link unable to move.
                        LDA.b #$01 : STA.w $02E4
                        
                        STZ.w $0C36, X
                        STZ.w $0C40, X
                        STZ.w $0C54, X
                        
                        ; Timer?
                        LDA.b #$F0 : STA.l $7F5812 
                        
                        ; These set the initial angles for the 6 rotating
                        ; cyrstals. The last one is stationary and isn't
                        ; rotated at all about a point.
                        LDA.b #$00 : STA.l $7F5800 : STA.l $7F5808
                        LDA.b #$0A : STA.l $7F5801
                        LDA.b #$16 : STA.l $7F5802
                        LDA.b #$20 : STA.l $7F5803
                        LDA.b #$2A : STA.l $7F5804
                        LDA.b #$36 : STA.l $7F5805
                        
                        REP #$20
                        
                        LDA.b $20 : CLC : ADC.w #$FFF0 : STA.b $00
                        
                        LDA.b $22 : STA.b $02
                        
                        SEP #$20
                        
                        BRL Shortcut_just_coords
}

; ==============================================================================

; $049C36-$049C37 LONG JUMP LOCATION
UNUSED_099C36:
{
    PLB
    
    RTL
}

; ==============================================================================

; A = 0x08
; $049C38-$049C4E LONG JUMP LOCATION
AddDoorDebris:
{
    PHB : PHK : PLB
    
    LDY.b #$01
    LDA.b #$08
    
    JSR.w AddAncilla : BCS .spawn_failed
        STZ.w $03C2, X
        
        LDA.b #$07 : STA.w $03C0, X
        
        ; Callers of this function need to know the result of whether it could
        ; be added or not.
        CLC
    
    ; $049C4D ALTERNATE ENTRY POINT
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $049C4F-$049CE1 LONG JUMP LOCATION
ConsumingFire_TransmuteToSkullWoodsFire:
{
    PHB : PHK : PLB
    
    LDA.b $1B : BNE AddDoorDebris_spawn_failed
        LDA.b $8A : AND.b #$40 : BEQ AddDoorDebris_spawn_failed
            PHX
            
            ; Configure a special object that probably does the flame up portion
            ; of the opening sequence (because the tile animation doesn't do it
            ; in its entirely).
            LDY.b #$34 : STY.w $0C4A
            
            ; Eliminate most other special objects in play.
            STZ.w $0C4B
            STZ.w $0C4C
            STZ.w $0C4D
            STZ.w $0C4E
            STZ.w $0C4F
            
            STZ.w $035F
            
            ; Set OAM allocation requirement.
            TYX : LDA.l AncillaObjectAllocation, X : STA.w $0C90
            
            PLX
            
            LDA.b #$FD : STA.l $7F0000
            INC        : STA.l $7F0001
            INC        : STA.l $7F0002
            
            LDA.b #$00 : STA.l $7F0003
                         STA.l $7F0010
            
            LDA.b #$05 : STA.l $7F0008
                         STA.l $7F0009
                         STA.l $7F000A
                         STA.l $7F000B
                         STA.w $03B1
            
            REP #$20
            
            LDA.w #$0100 : STA.l $7F0018
                           STA.l $7F0026
            
            LDA.w #$0098 : STA.l $7F001A
                           STA.l $7F0036
            
            SEP #$20
            
            ; Initiates the actual tile animation sequence that is the skull
            ; woods opening.
            LDA.b #$02 : STA.w $04C6
            
            STZ.b $B0
            STZ.b $C8
            
            ; Further configure the state of the skull woods flame object that
            ; is about to become active next frame.
            LDA.b $EE : STA.w $0C7C
            
            LDA.w $0476 : STA.w $03CA
            
            STZ.w $0C5E
            STZ.w $0C54
            
            PLB
            
            RTL
}

; ==============================================================================

; Special effect activator
; $049CE2-$049D17 LOCAL JUMP LOCATION
AddAncilla:
{
    ; Save the effect index.
    PHA
    
    JSR.w Ancilla_CheckForAvailableSlot
    
    ; Retrieve it.
    PLA
    
    TYX : BMI .no_slots_open
        ; Otherwise load the effect in.
        STA.w $0C4A, X : TAY
        
        ; Put the effect on the same plane as Link.
        LDA.b $EE : STA.w $0C7C, X
        
        ; ???
        LDA.w $0476 : STA.w $03CA, X
        
        ; Initialize the effect.
        STZ.w $0C22, X
        
        STZ.w $0C2C, X
        
        STZ.w $0280, X
        
        STZ.w $028A, X
        
        ; Save our spot in the effects array.
        PHX
        
        TYX
        
        ; Load some extra information about the effect into $0E.
        LDA.l AncillaObjectAllocation, X : STA.b $0E
        
        ; Retrieve our spot in the effects array.
        PLX
        
        ; Store the extra information at $0C90, X.
        LDA.b $0E : STA.w $0C90, X
        
        ; Indicates success.
        CLC
        
        RTS
    
    .no_slots_open
    
    ; Indicates failure.
    SEC
    
    RTS
}

; ==============================================================================

; $049D18-$049D1F LONG JUMP LOCATION
AddAncillaLong:
{
    PHB : PHK : PLB

    JSR.w AddAncilla

    PLB

    RTL
}

; ==============================================================================

; This routine accepts A as an input and returns true (SEC)
; if a special object value in indices 0 - 5 matches the value of A.
; $049D20-$049D2D LOCAL JUMP LOCATION
Ancilla_CheckIfAlreadyExists:
{
    LDX.b #$05
    
    .checkNextSlot
    
        CMP.w $0C4A, X : BEQ .alreadyExists
    DEX : BPL .checkNextSlot
    
    CLC
    
    RTS
    
    .alreadyExists
    
    SEC
    
    RTS
}

; ==============================================================================

; UNUSED:
; $049D2E-$049D35 DATA
Ancilla_CheckIfAlreadyExistsLong:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_CheckIfAlreadyExists
    
    PLB
    
    RTS
}

; ==============================================================================
    
; $049D36-$049DA2 LOCAL JUMP LOCATION
Ancilla_GetRidOfArrowInWall:
{
    PHA
    
    INY : STY.b $0E
    
    ; Starting index is 0x00.
    LDY.b #$00
    LDX.b #$04
    
    .arrowInWallSearch
        ; See if the object in the list is an arrow sticking out of the wall.
        LDA.b #$0A : CMP.w $0C4A, X : BNE .notArrowInWall
            ; Count the number of arrows that are in the wall.
            INY
        
        .notArrowInWall
    
    DEX : BPL .arrowInWallSearch
    
    CPY.b $0E : BEQ .tooManyArrowsInWall
        LDY.b #$04
        
        .emptySlotSearch
        
            LDA.w $0C4A, Y : BEQ .replaceArrowInWall
        DEY : BPL .emptySlotSearch
        
        BRA .replaceArrowInWall
    
    .tooManyArrowsInWall
    
        DEC.w $03C4 : BPL .noUnderflow
            .arrowInWallSearch2
            
            LDA.b #$04 : STA.w $03C4
            
        .noUnderflow
        
        ; Look for an arrow in a wall in one of 5 slots.
        LDY.w $03C4
        
        LDA.w $0C4A, Y : CMP.b #$0A : BEQ .replaceArrowInWall
    DEY : BPL .tooManyArrowsInWall
    
    BRA .arrowInWallSearch2
    
    .replaceArrowInWall
    
    PLA
    
    TYX : BMI .cantReplaceAny
        STA.w $0C4A, X : TAY
        
        ; Set floor information for the object.
        LDA.b $EE : STA.w $0C7C, X
        
        ; Store level information for the object (similar to $EE).
        LDA.w $0476 : STA.w $03CA, X
        
        STZ.w $0C22, X : STZ.w $0C2C, X STZ.w $0280, STZ.w $028A, X
        
        PHX : TYX
        
        LDA.l AncillaObjectAllocation, X : STA.b $0E
        
        PLX : LDA.b $0E : STA.w $0C90, X
        
        CLC
        
        RTS
        
    .cantReplaceAny
    
    SEC
    
    RTS
}

; ==============================================================================

; $049DA3-$049DD2 DATA
Pool_Ancilla_CheckInitialTileCollision_Class_1:
{
    ; $049DA3
    .y_offsets
    dw   8,   0
    dw  -8,   8
    dw  16,  24
    dw   8,   8
    dw   8,   8
    dw   8,   8
    
    ; $049DBB
    .x_offsets
    dw   0,   0
    dw   0,   0
    dw   0,   0
    dw   0,  -8
    dw -16,   0
    dw   8,  16
}

; TODO: Rename this, maybe.
    
; NOTE: Class 1 and Class 2 indicates that we have two very similar routines
; for checking this kind of situation, but that the ... eh explain it later.
; Basically there's one for boomerangs and junk and one for bombs and
; blocks. We'd need to come up with nammes for the two classes.
; $049DD3-$049E23 LONG JUMP LOCATION
Ancilla_CheckInitialTileCollision_Class_1:
{
    PHB : PHK : PLB
    
    PHY
    
    LDA.b #$02 : STA.b $72
    
    ; Y = directional value of object * 6.
    LDA.w $0C72, X : ASL : STA.b $02
                     ASL : CLC : ADC.b $02 : TAY
    
    .next_entry
    
        REP #$20
        
        LDA.w Pool_Ancilla_CheckInitialTileCollision_Class_1_y_offsets, Y
        CLC : ADC.b $20 : STA.b $02
        
        LDA.w Pool_Ancilla_CheckInitialTileCollision_Class_1_x_offsets, Y
        CLC : ADC.b $22 : STA.b $04
        
        SEP #$20
        
        LDA.b $02 : STA.w $0BFA, X
        LDA.b $03 : STA.w $0C0E, X
        
        LDA.b $04 : STA.w $0C04, X
        LDA.b $05 : STA.w $0C18, X
        
        PHY
        
        JSL.l Ancilla_CheckTileCollisionLong
        
        PLY
        
        BCS .alpha
            INY #2
    DEC.b $72 : BPL .next_entry
    
    PLY
    
    CLC
    
    PLB
    
    RTL
    
    .alpha
    
    PLY
    
    SEC
    
    PLB
    
    RTL
}

; ==============================================================================

; $049E24-$049E43 DATA
Pool_Ancilla_CheckInitialTileCollision_Class2:
{
    ; $049E24
    .y_offsets
    dw 15, 16
    dw 28, 24
    dw 12, 12
    dw 12, 12
    
    ; $049E34
    .x_offsets
    dw  8,  8
    dw  8,  8
    dw -1,  0
    dw 17, 16
}

; TODO: Maybe rename this later on.
; $049E44-$049E8F LONG JUMP LOCATION
Ancilla_CheckInitialTileCollision_Class2:
{
    PHB : PHK : PLB
    
    PHY
    
    ; BUG: Potential for this to cause buffer overflows of the pooled
    ; arrays above?
    LDA.b #$02 : STA.b $72
    
    LDA.w $0C72, X : ASL #2 : TAY
    
    .next_entry
    
        REP #$20
        
        LDA.w Pool_Ancilla_CheckInitialTileCollision_Class2_y_offsets, Y
        CLC : ADC.b $20 : STA .b$02

        LDA.w Pool_Ancilla_CheckInitialTileCollision_Class2_x_offsets, Y
        CLC : ADC.b $22 : STA.b $04
        
        SEP #$20
        
        LDA.b $02 : STA.w $0BFA, X
        LDA.b $03 : STA.w $0C0E, X
        
        LDA.b $04 : STA.w $0C04, X
        LDA.b $05 : STA.w $0C18, X
        
        PHY
        
        JSL.l Ancilla_CheckTileCollision_Class2_Long
        
        PLY
        
        BCS .alpha
            INY #2
    DEC.b $72 : BPL .next_entry
    
    PLY
    
    CLC
    
    PLB
    
    RTL
    
    .alpha
    
    PLY
    
    SEC
    
    PLB
    
    RTL
}

; ==============================================================================
