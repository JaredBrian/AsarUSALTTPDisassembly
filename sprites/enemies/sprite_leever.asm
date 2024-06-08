
; ==============================================================================

; $034BA2-$034BD7 JUMP LOCATION
Sprite_Leever:
{
    LDA.w $0D80, X : BEQ .dont_draw
    
    JSR Leever_Draw
    
    BRA .respawn_logic
    
    .dont_draw
    
    JSR Sprite_PrepOamCoordSafeWrapper
    
    .respawn_logic
    
    LDA.w $0F00, X : BEQ .dont_respawn
    
    ; \task Find out if this ever executes. Would be interesting to know.
    LDA.b #$08 : STA.w $0DD0, X
    
    .dont_respawn
    
    JSR Sprite_CheckIfActive
    JSR Sprite_CheckIfRecoiling
    
    LDA.w $0D80, X : REP #$30 : AND.w #$00FF : ASL A : TAY
    
    LDA .handlers, Y : PHA
    
    SEP #$30
    
    RTS
    
    ; \task Note that these are all the pointers minus one. Make sure
    ; to note that by adding "-1" to these. Maybe come up with a macro that
    ; expresses this? Probably would need to add more functionality to xkas for
    ; that.
    .handlers
    dw Leever_UnderSand-1
    dw Leever_Emerge-1
    dw Leever_AttackPlayer-1
    dw Leever_Submerge-1
}

; ==============================================================================

; $034BD8-$034BF4 JUMP LOCATION
Leever_UnderSand:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    LDA.b #$10 : JSR Sprite_ApplySpeedTowardsPlayer
    
    JSR Sprite_Move
    JSR Sprite_CheckTileCollision
    
    RTS
}

; ==============================================================================

    ; \unused Almost certainly unused. Probably was for an earlier design
    ; where the Leever didn't go towards the player while it was submerged.
    ; I say this due to the large simlarity with the previous routine
    ; (Leever_UnderSand).
; $034BF5-$034C02 LOCAL JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    .delay
    
    RTS
}    

; ==============================================================================

; $034C03-$034C12 DATA
Pool_Leever_Emerge:
{
    .animation_states
    db 10,  9,  8,  7,  6,  5,  4,  3
    db  2,  1,  2,  1,  2,  1,  0,  0
}

; ==============================================================================

; $034C13-$034C36 JUMP LOCATION
Leever_Emerge:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
    
    INC.w $0D80, X
    
    JSL GetRandomInt : AND.b #$3F : ADC.b #$A0 : STA.w $0DF0, X
    
    JMP Sprite_Zero_XY_Velocity
    
    .delay
    
    LSR #3 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}    

; ==============================================================================

; $034C37-$034C3B DATA
Pool_Leever_AttackPlayer:
{
    .animation_states length 4
    db 9, 10, 11
    
    .speeds
    db 12, 8
}

; ==============================================================================

; $034C3C-$034C79 JUMP LOCATION
Leever_AttackPlayer:
{
    JSR Sprite_CheckDamage
    
    LDA.w $0DF0, X : BNE .submersion_delay
    
    .tile_collision
    
    INC.w $0D80, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    RTS
    
    .submersion_delay
    
    LDA.w $0E80, X : AND.b #$07 : BNE .tracking_delay
    
    LDY.w $0D90, X
    
    LDA .speeds, Y : JSR Sprite_ApplySpeedTowardsPlayer
    
    .tracking_delay
    
    JSR Sprite_Move
    JSR Sprite_CheckTileCollision
    
    LDA.w $0E70, X : BNE .tile_collision
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #2 : AND.b #$03 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $034C7A-$034C89 DATA
Pool_Leever_Submerge:
{
    .animation_states
    db 10,  9,  8,  7,  6,  5,  4,  3
    db  2,  1,  2,  1,  2,  1,  0,  0
}

; ==============================================================================

; $034C8A-$034CAE JUMP LOCATION
Leever_Submerge:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
    
    STZ.w $0D80, X
    
    JSL GetRandomInt : AND.b #$1F : ADC.b #$40 : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    LSR #3 : EOR.b #$0F : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
    
    .unused
    
    RTS
}

; ==============================================================================

; $034CAF-$034E44 DATA
Pool_Leever_Draw:
{
    ; \task fill in later.
    db  2,  0,  6,  0,  6,  0,  6,  0
    db  0,  0,  8,  0,  8,  0,  8,  0
    db  0,  0,  8,  0,  8,  0,  8,  0
    db  0,  0,  8,  0,  0,  0,  8,  0
    db  0,  0,  8,  0,  0,  0,  8,  0
    db  0,  0,  0,  0,  0,  0,  8,  0
    db  0,  0,  0,  0,  0,  0,  8,  0
    db  0,  0,  0,  0,  0,  0,  8,  0
    db  0,  0,  0,  0,  0,  0,  8,  0
    db  0,  0,  0,  0,  0,  0,  0,  0
    db  0,  0,  0,  0,  0,  0,  0,  0
    db  0,  0,  0,  0,  0,  0,  0,  0
    db  0,  0,  0,  0,  0,  0,  0,  0
    db  0,  0,  0,  0,  0,  0,  0,  0
    
    db  8,  0,  8,  0,  8,  0,  8,  0
    db  8,  0,  8,  0,  8,  0,  8,  0
    db  8,  0,  8,  0,  8,  0,  8,  0
    db  5,  0,  5,  0,  8,  0,  8,  0
    db  5,  0,  5,  0,  8,  0,  8,  0
    db  2,  0,  2,  0,  8,  0,  8,  0
    db  1,  0,  1,  0,  8,  0,  8,  0
    db  0,  0,  0,  0,  8,  0,  8,  0
    db -1, -1, -1, -1,  8,  0,  8,  0
    db  8,  0, -2, -1, -2, -1,  0,  0
    db  8,  0, -2, -1, -2, -1,  0,  0
    db  8,  0, -2, -1, -2, -1,  0,  0
    db  8,  0, -2, -1, -2, -1,  0,  0
    db  8,  0, -2, -1, -2, -1,  0,  0
    
    .chr
    db $28, $28, $28, $28, $28, $28, $28, $28
    db $38, $38, $38, $38, $08, $09, $28, $28
    db $08, $09, $D9, $D9, $08, $08, $D8, $D8
    db $08, $08, $DA, $DA, $06, $06, $D9, $D9
    db $26, $26, $D8, $D8, $6C, $06, $06, $00
    db $6C, $26, $26, $00, $6C, $06, $06, $00
    db $6C, $26, $26, $00, $6C, $08, $08, $00
    
    .properties
    db $01, $41, $41, $41, $01, $41, $41, $41
    db $01, $41, $41, $41, $01, $01, $01, $41
    db $01, $01, $00, $40, $01, $01, $00, $40
    db $01, $01, $00, $40, $01, $01, $00, $40
    db $00, $01, $00, $40, $06, $41, $41, $00
    db $06, $41, $41, $00, $06, $01, $01, $00
    db $06, $01, $01, $00, $06, $01, $01, $00
    
    .oam_sizes
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $02, $02, $00, $00
    db $02, $02, $00, $00, $02, $02, $00, $00
    db $02, $02, $00, $00, $02, $02, $02, $00
    db $02, $02, $02, $00, $02, $02, $02, $00
    db $02, $02, $02, $00, $02, $02, $02, $00
    
    .num_oam_entries
    db 1, 1, 1, 3, 3, 3, 3, 3
    db 3, 1, 1, 1, 1, 1
}

; ==============================================================================

; $034E45-$034EBF LOCAL JUMP LOCATION
Leever_Draw:
{
    JSR Sprite_PrepOamCoord
    
    LDA.w $0DC0, X : TAY : ASL #2 : STA.b $06
    
    PHX
    
    LDX .num_oam_entries, Y
    
    LDY.b #$00
    
    .next_oam_entry
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA
    
    ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX
    
    LDA.b $05 : PHA
    
    LDA .chr, X : INY : STA ($90), Y
    
    CMP.b #$60 : BCS .mask_off_palette_and_nametable_bits
    CMP.b #$28 : BEQ .mask_off_palette_and_nametable_bits
    CMP.b #$38 : BNE .dont_do_that
    
    .mask_off_palette_and_nametable_bit
    
    ; \task (and \wtf) What purpose does this serve exactly?
    LDA.b $05 : AND.b #$F0 : STA.b $05
    
    .dont_do_that
    
    LDA .properties, X : ORA.b $05 : INY : STA ($90), Y
    
    PLA : STA.b $05
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA .oam_sizes, X : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    RTS
}

; ==============================================================================
