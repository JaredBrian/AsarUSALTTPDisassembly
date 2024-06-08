
; ==============================================================================

; $02966A-$02967A DATA
Pool_Sprite_ZoraAndFireball:
{
    .shield_x_offsets_low
    db $04, $04, $FC, $10
    
    ; note: data segment overlaps with the next one (length = 4)
    ; other segments also overlap, but using the length keyword we've conjured
    ; up, this will indicate to a parser the actual length in bytes of
    ; the array.
    .shield_to_the_side_indices length 4
    db $03, $02
    
    .shield_x_offests_high length 4
    db $00, $00, $FF
    
    .shield_y_offsets_low length 4
    db $00, $10
    
    .shield_hit_box_size_x length 4
    db $08, $08
    
    .shield_hit_box_size_y
    db $04, $04, $08, $08
}

; ==============================================================================

; $02967B-$029724 JUMP LOCATION
Sprite_ZoraAndFireball:
{
    ; Fireball sprite (from Zora or similar)
    
    LDA.w $0E90, X : BNE Sprite_Fireball
    
    JMP Sprite_Zora
    
    ; \note Only here for informational purposes.
    shared Sprite_Fireball:
    
    STA.w $0BA0, X
    
    LDA.w $0DF0, X : BEQ .dont_allocate_oam
    
    LDA.b #$04 : JSL OAM_AllocateFromRegionC
    
    .dont_allocate_oam
    
    JSL Sprite_PrepAndDrawSingleSmallLong
    JSR Sprite2_CheckIfActive
    JSL ZoraFireball_SpawnTailGarnish
    
    JSL Sprite_CheckDamageToPlayerLong : BCC .no_player_contact
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    RTS
    
    .no_player_contact
    
    JSR Sprite2_Move
    
    LDA.b $1B : BEQ .ignore_tile_collision
    
    LDA.w $0E00, X : BNE .ignore_tile_collision
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .ignore_tile_collision
    
    JSR Sprite2_CheckTileCollision : BNE .self_terminate
    
    .ignore_tile_collision
    
    ; What we really mean is to ignore *further* player collision detection.
    ; We already checked earlier if there was a collision for this. So
    ; in effect we are explicitly checking for shield collision here.
    LDA.w $02E0 : ORA.w $037B : BNE .ignore_shield_collision
    
    LDA.w $0308 : BMI .ignore_shield_collision
    
    ; Does Link have a level two shield or higher?
    ; Nope... so make him suffer
    LDA.l $7EF35A : CMP.b #$02 : BCC .ignore_shield_collision
    
    ; Otherwise, the fireball might get blocked by the shield
    ; Are Link and the sprite on the same level?
    ; No... so don�t hurt him.
    LDA.b $EE : CMP.w $0F20, X : BNE .ignore_shield_collision
    
    JSL Sprite_SetupHitBoxLong
    
    ; Okay, so normally (bread crumb) you might think a general collision
    ; function would handle this, and indeed there is code for some
    ; sprites that generically handle collisions with shields. However,
    ; this sprite has an unconventional direction variable setup ($0DE0)
    ; and thus it must be duplicated here in a slightly altered fashion.
    
    ; Which direction is Link facing?
    LDA.b $2F : LSR A : TAY
    
    LDA.b $3C : BEQ .shield_not_to_the_side
    
    LDA .shield_to_the_side_indices, Y : TAY
    
    .shield_not_to_the_side
    
    LDA.b $22 : CLC : ADC .shield_x_offsets_low, Y  : STA.b $00
    LDA.b $23 : CLC : ADC .shield_x_offsets_high, Y : STA.b $08
    
    LDA .shield_hit_box_size_x, Y : STA.b $02
    
    LDA.b $20 : CLC : ADC .shield_y_offsets_low, Y : STA.b $01
    LDA.b $21 : ADC.b #$00    : STA.b $09
    
    LDA .shield_hit_box_size_y, Y : STA.b $03
    
    JSL Utility_CheckIfHitBoxesOverlapLong : BCC .no_shield_collision
    
    JSL Sprite_PlaceRupulseSpark.coerce
    
    ; Kill off the sprite.
    STZ.w $0DD0, X
    
    LDA.b #$06 : JSL Sound_SetSfx2PanLong
    
    .no_shield_collision
    .ignore_shield_collision
    
    RTS
}

; ==============================================================================

; $029725-$029749 BRANCH LOCATION
Sprite_Zora:
{
    LDA.w $0D80, X : BNE .draw_sprite
    
    JSL Sprite_PrepOamCoordLong
    
    BRA .moving_on
    
    .draw_sprite
    
    JSR Zora_Draw
    
    .moving_on
    
    JSR Sprite2_CheckIfActive
    
    LDA.w $0D80, X : BEQ Zora_ChooseSurfacingLocation
    DEC A        : BEQ .surfacing
    DEC A        : BEQ .attack
    
    JMP Zora_Submerging
    
    .attack
    
    JMP Zora_Attack
    
    .surfacing
    
    JMP Zora_Surfacing
}

; ==============================================================================

; $02974A-$029759 DATA
Pool_Zora_ChooseSurfacingLocation:
{
    .offsets_low
    db $E0, $E8, $F0, $F8, $08, $10, $18, $20
    
    .offsets_high
    db $FF, $FF, $FF, $FF, $00, $00, $00, $00
}

; ==============================================================================

; $02975A-$0297B4 BRANCH LOCATION
Zora_ChooseSurfacingLocation:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
    
    ; Attempt to find a location for the Zora to spawn at, but it has
    ; to be in deep water. Note that Zora will not follow you, as this
    ; logic indicates that it surfacing point is bounded by its starting
    ; coordinates.
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $0D90, X : CLC : ADC .offsets_low, Y  : STA.w $0D10, X
    LDA.w $0DA0, X : ADC .offsets_high, Y : STA.w $0D30, X
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA.w $0DB0, X : CLC : ADC .offsets_low, Y  : STA.w $0D00, X
    LDA.w $0EB0, X : ADC .offsets_high, Y : STA.w $0D20, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    JSR Sprite2_CheckTileCollision
    
    LDA.w $0FA5 : CMP.b #$08 : BNE .not_in_deep_water
    
    LDA.b #$7F : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    .not_in_deep_water
    .delay
    
    RTS
}

; ==============================================================================

; $0297B5-$0297C4 DATA
Pool_Zora_Surfacing:
{
    .animation_states
    db $04, $03, $02, $01, $02, $01, $02, $01
    db $02, $01, $02, $01, $02, $01, $00, $00
}

; ==============================================================================

; $0297C5-$0297E8 LOCAL JUMP LOCATION
Zora_Surfacing:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    ; Sprite is no longer impervious.
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    RTS
    
    .delay
    
    LSR #3 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0297E9-$0297F0 DATA
Pool_Zora_Attack:
{
    .animation_states
    db $05, $05, $06, $0A, $06, $05, $05, $05
}

; ==============================================================================

; $0297F1-$029817 LOCAL JUMP LOCATION
Zora_Attack:
{
    JSR Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$17 : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    CMP.b #$30 : BNE .dont_spawn_fireball
    
    PHA
    
    JSL Sprite_SpawnFireball
    
    PLA
    
    .dont_spawn_fireball
    
    LSR #4 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $029818-$029823 DATA
Pool_Zora_Submerging:
{
    .animation_states
    db $0C, $0B, $09, $08, $07, $00, $00, $00
    db $00, $00, $00, $00
}

; ==============================================================================

; $029824-$02983E LOCAL JUMP LOCATION
Zora_Submerging:
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$80 : STA.w $0DF0, X
    
    STZ.w $0DC0, X
    STZ.w $0D80, X
    
    RTS
    
    .delay
    
    LSR #2 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02983F-$0298F4 DATA
Pool_Zora_Draw:
{
    .x_offsets
    dw   4,   4,   0,   0,   0,   0,   0,   0
    dw   0,   0,   0,   0,   0,   0,   0,   0
    dw   0,   0,  -4,  11,   0,   4,  -8,  18
    dw  -8,  18
    
    .y_offsets
    dw   4,   4,   0,   0,   0,   0,   0,  -3
    dw   0,  -3,  -3,  -3,  -3,  -3,  -3,  -3
    dw  -6,  -6,  -8,  -9,  -3,   5, -10, -11
    dw -10, -11
    
    .chr
    db $A8, $A8, $88, $88, $88, $88, $88, $A4
    db $88, $A4, $A4, $A4, $A6, $A6, $A4, $C0
    db $8A, $8A, $AE, $AF, $A6, $8D, $CF, $CF
    db $DF, $DF
    
    .properties
    db $25, $25, $25, $25, $E5, $E5, $25, $20
    db $E5, $20, $20, $20, $20, $20, $20, $24
    db $25, $25, $24, $64, $20, $26, $24, $64
    db $24, $64
    
    .size_bit
    db $00, $00, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $00, $00, $02, $00, $00, $00
    db $00, $00
}

; ==============================================================================

; $0298F5-$02995A LOCAL JUMP LOCATION
Zora_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL A : STA.b $06
    
    PHX
    
    LDX.b #$01
    
    .next_subsprite
    
    PHX
    
    TXA : CLC : ADC.b $06 : PHA
    
    ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X       : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX
    
    LDA .chr, X : INY : STA ($90), Y
    
    LDA.b #$0F : STA.b $0D
    
    LDA .properties, X : BIT.b $0D : BNE .override_intended_palette
    
    ORA.b $05
    
    .override_intended_palette
    
    INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA .size_bit, X : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================
