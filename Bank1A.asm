; ==============================================================================

; Bank 1A
org $1A8000 ; $0D0000-$0D7FFF

; ==============================================================================

incsrc "sprite_waterfall.asm"

; ==============================================================================

incsrc "sprite_retreat_bat.asm"

; ==============================================================================


; $0D785C-$0D788B DATA
pool DrinkingGuy_Draw:
{
    .oam_groups
    dw 8,  2 : db $AE, $00, $00, $00
    dw 0, -9 : db $22, $08, $00, $02
    dw 0,  0 : db $06, $00, $00, $02
    
    dw 7,  0 : db $AF, $00, $00, $00
    dw 0, -9 : db $22, $08, $00, $02
    dw 0,  0 : db $06, $00, $00, $02        
}


; ==============================================================================

; $0D788C-$0D78AB LONG JUMP LOCATION
DrinkingGuy_Draw:
{
    PHB : PHK : PLB
    
    LDA $0DC0, X : ASL A : ADC $0DC0, X : ASL #3
    
    ADC.b #(.oam_groups)              : STA $08
    LDA.b #(.oam_groups) : ADC.b #$00 : STA $09
    
    LDA.b #$03 : STA $06
                 STZ $07
    
    JMP $F94A ; $0D794A IN ROM
}

; ==============================================================================

; $0D792C-$0D7953 LONG JUMP LOCATION
Lady_Draw:
{
    ; Generally speaking, this draws a lady sprite... can be young or old,
    ; but the same graphics either way.
    
    PHB : PHK : PLB
    
    LDA.b #$02 : STA $06
                 STZ $07
    
    LDA $0DE0, X : ASL A : ADC $0DC0, X : ASL #4
    
    ; $D78AC
    ADC.b #$AC              : STA $08
    LDA.b #$F8 : ADC.b #$00 : STA $09
    
    ; $0D794A ALTERNATE ENTRY POINT
    
    JSL Sprite_DrawMultiple.player_deferred
    JSL Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7954-$0D7970 LOCAL JUMP LOCATION
Sprite6_CheckIfActive:
{
    LDA $0DD0, X : CMP.b #$09 : BNE .inactive
    
    LDA $0FC1 : BNE .inactive
    
    LDA $11 : BNE .inactive
    
    LDA $0CAA, X : BMI .active
    
    LDA $0F00, X : BEQ .active
    
    .inactive
    
    PLA : PLA
    
    .inactive
    
    RTS
}

; ==============================================================================

; $0D7971-$0D7980 DATA
pool Lanmola_SpawnShrapnel:
{
}
    
; $0D7981-$0D79E5 LONG JUMP LOCATION
Lanmola_SpawnShrapnel:
{
    ; Spawns Lanmolas' rocks when they pop out of the ground.
    LDY.b #$03
    
    LDA $0DD0 : CLC : ADC $0DD1 : ADC $0DD2 : CMP.b #$0A : BCS .BRANCH_ALPHA
    
    LDY.b #$07
    
    .BRANCH_ALPHA
    
    STY $0FB5
    
    .BRANCH_GAMMA
    
    LDA.b #$C2
    
    JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA $00 : ADC.b #$04 : STA $0D10, Y
    LDA $02 : ADC.b #$04 : STA $0D00, Y
    
    LDA.b #$01 : STA $0BA0, Y : STA $0CD2, Y : STA $0F60, Y
    
    DEC A : STA $0F70, Y
    
    LDA.b #$20 : STA $0E40, Y
    
    PHX
    
    LDX $0FB5
    
    LDA $1AF979, X : STA $0D50, Y
    LDA $1AF971, X : STA $0D40, Y
    
    JSL GetRandomInt : AND.b #$01 : STA $0DC0, Y
    
    PLX
    
    .spawn_failed
    
    DEC $0FB5 : BPL .BRANCH_GAMMA
    
    RTL
}

; ==============================================================================

incsrc "sprite_cukeman.asm"

; ==============================================================================

; $0D7B2C-$0D7B7A LONG JUMP LOCATION
RunningMan_SpawnDashDustGarnish:
{
    INC $0CBA, X : LDA $0CBA, X : AND.b #$0F : BNE .delay
    
    PHX : TXY
    
    LDX.b #$1D
    
    .find_empty_slot
    
    LDA $7FF800, X : BEQ .empty_slot
    
    DEX : BPL .find_empty_slot
    
    INX
    
    .empty_slot
    
    LDA.b #$14 : STA $7FF800, X : STA $0FB4
    
    LDA $0D10, Y : CLC : ADC.b #$04 : STA $7FF83C, X
    LDA $0D30, Y : ADC.b #$00 : STA $7FF878, X
    
    LDA $0D00, Y : CLC : ADC.b #$1C : STA $7FF81E, X
    LDA $0D20, Y : ADC.b #$00 : STA $7FF85A, X
    
    LDA.b #$0A : STA $7FF90E, X
    
    PLX
    
    .delay
    
    RTL ; original dissasembly had this as an RTS
}

; ==============================================================================

; $0D7B7B-$0D7BDA DATA
pool Overworld_SubstituteAlternateSecret:
{
    .AreaIndex
    db $00, $00, $00, $00, $00, $00, $00, $04
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $04, $04, $06, $04, $04, $06, $00, $00
    db $0F, $0F, $04, $05, $05, $04, $06, $06
    db $0F, $0F, $04, $05, $05, $07, $06, $06
    db $1F, $1F, $04, $07, $07, $04, $06, $06
    db $06, $07, $02, $00, $00, $00, $00, $00
    db $06, $06, $02, $00, $00, $00, $00, $00

    .ItemPool ; $D7BBB
    db $01, $01, $01, $01, $0F, $01, $01, $12, $10, $01, $01, $01, $11, $01, $01, $03

    .AreaMask ; $D7BCB
    db $00, $00, $00, $00, $02, $00, $00, $08, $10, $00, $00, $00, $01, $00, $00, $00
}

; ==============================================================================

; $0D7BDB-$0D7C30 LONG JUMP LOCATION
Overworld_SubstituteAlternateSecret:
{
    PHB : PHK : PLB
    
    !num_live_sprites = $0D
    
    JSL GetRandomInt : AND.b #$01 : BNE .return
    
    STZ !num_live_sprites
    
    LDY.b #$0F
    
   .next_sprite
    
    LDA $0DD0, Y : BEQ .dead_sprite
    
    LDA $0E20, Y : CMP.b #$6C : BEQ .is_warp_vortex
    
    INC !num_live_sprites
    
    .dead_sprite
    .is_warp_vortex
    
    DEY : BPL .next_sprite
    
    LDA !num_live_sprites : CMP.b #$04 : BCS .return
    
    LDA $7EF3C5 : CMP.b #$02 : BCC .return
    
    LDA $0CF7 : INC $0CF7 : AND.b #$07
    
    LDY $0FFF : BEQ .in_light_world
    
    ORA.b #$08
    
    .in_light_world
    
    TAY
    
    PHX
    
    LDA $040A : AND.b #$3F : TAX
    
    LDA .AreaIndex, X : AND .AreaMask, Y : BNE .BRANCH_EPSILON ; $FB7B $FBBB
    
    LDA .ItemPool, Y : STA $0B9C ; $FBCB
    
    .BRANCH_EPSILON
    
    PLX
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

incsrc "sprite_movable_mantle.asm"

; ==============================================================================

; $0D7CED-$0D7DAC DATA
pool Mothula_Draw:
{
    ; \task Fill in data.
}

; ==============================================================================

; $0D7DAD-$0D7DB4 LONG JUMP LOCATION
Mothula_DrawLong:
{
    ; Something related to drawing Mothula (Gamoth?) or his beams?
    PHB : PHK : PLB
    
    JSR Mothula_Draw
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7DB5-$0D7E7D LOCAL JUMP LOCATION
Mothula_Draw:
{
    LDA.b #$00 : XBA
    
    LDA $0DC0, X : REP #$20 : ASL #6 : ADC.w #$FCED : STA $08
    
    LDA.w #$0920 : STA $90
    
    LDA.w #$0A68 : STA $92
    
    SEP #$20
    
    LDA.b #$08 : JSL Sprite_DrawMultiple
    
    LDA $0F00, X : BNE .skip
    
    PHX
    
    LDA $0DC0, X : ASL #3 : ADC $0DC0, X : STA $06
    
    LDA $02 : CLC : ADC $0F70, X : STA $02
    LDA $03 : ADC.b #$00   : STA $03
    
    LDY.b #$28
    LDX.b #$08

    .next_oam_entry

    PHX
    
    TXA : CLC : ADC $06 : ASL A : TAX
    
    REP #$20
    
    LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA $0E
    
    INY
    
    LDA $02 : CLC : ADC.w #$0010 : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y

    .on_screen_y

    INY
    
    LDA.b #$6C : STA ($90), Y
    
    INY
    
    LDA.b #$24 : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    .skip
    
    RTS
    
    .x_offsets
    dw   0,   3,   6,   9,  12,  -3,  -6,  -9
    dw -12,   0,   2,   4,   6,   8,  -2,  -4
    dw  -6,  -8,   0,   1,   2,   3,   4,  -1
    dw  -2,  -3,  -4
}

; ==============================================================================

; $0D7E7E-$0D7E87 DATA
pool BottleVendor_PayForGoodBee:
{
    .x_speeds
    db -6, -3,  0,  4,  7
    
    .y_speeds
    db 11, 14, 16, 14, 11
}

; ==============================================================================

; $0D7E88-$0D7ECE LONG JUMP LOCATION
BottleVendor_PayForGoodBee:
{
    PHB : PHK : PLB
    
    LDA.b #$13 : JSL Sound_SetSfx3PanLong
    
    LDA.b #$04 : STA $0FB5
    
    .next_red_rupee
    
    LDA.b #$DB : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA $00 : CLC : ADC.b #$04 : STA $0D10, Y
    
    LDA.b #$FF : STA $0B58, Y
    
    PHX
    
    LDX $0FB5
    
    LDA .x_speeds, X : STA $0D50, Y
    
    LDA .y_speeds, X : STA $0D40, Y
    
    LDA.b #$20 : STA $0F80, Y
                 STA $0F10, Y
    
    PLX
    
    .spawn_failed
    
    DEC $0FB5 : BPL .next_red_rupee
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7ECF-$0D7ED2 LONG JUMP LOCATION
Sprite_ChickenLadyLong:
{
    JSR Sprite_ChickenLady        
    
    RTL
}

; ==============================================================================

; $0D7ED3-$0D7EFF LOCAL JUMP LOCATION
Sprite_ChickenLady:
{
    LDA.b #$01 : STA $0DE0, X
    
    JSL Lady_Draw
    JSR Sprite6_CheckIfActive
    
    LDA $0DF0, X : CMP.b #$01 : BNE .anoshow_message
    
    ; "Cluck cluck...  What?! (...) I can even speak! ..."
    LDA.b #$7D : STA $1CF0
    LDA.b #$01 : STA $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    .anoshow_message
    
    LDA $1A : LSR #4 : AND.b #$01 : STA $0DC0, X
    
    RTS
}

; ==============================================================================

; $0D7F00-$0D7F2A LONG JUMP LOCATION
SpritePrep_DiggingGameGuy:
{
    LDA $0D00, X : STA $00
    LDA $0D20, X : STA $01
    
    REP #$20
    
    LDA $20 : CMP $00 : SEP #$30 : BCS .player_below_proprietor
    
    ; This is in case you warp into the digging game field from the light
    ; world (as a result of the mirror warp vortex taking you back to the
    ; dark world).
    LDA.b #$05 : STA $0D80, X
    
    LDA $0D10, X : SEC : SBC.b #$09 : STA $0D10, X
    
    LDA.b #$01 : STA $0DC0, X
    
    .player_below_proprietor
    
    INC $0BA0, X
    
    RTL
}

; ==============================================================================

; $0D7F2B-$0D7F3B DATA
pool Player_SpawnSmallWaterSplashFromHammer:
{
    .x_offsets
    dw 0, 12, -8, 24
    
    .y_offsets
    dw 8, 32, 24, 24
    
    .easy_out
    RTL
}

; ==============================================================================

; $0D7F3C-$0D7FFD LONG JUMP LOCATION
Player_SpawnSmallWaterSplashFromHammer:
{
    LDA $11 : ORA $02E4 : ORA $0FC1 : BNE .easy_out
    
    PHX : PHY
    
    LDY $2F
    
    REP #$20
    
    LDA $22 : CLC : ADC.l .x_offsets, X : STA $00
    LDA $20 : CLC : ADC.l .y_offsets, X : STA $02
    
    SEP #$20
    
    LDA $EE : CMP.b #$01 : REP #$30 : STZ $05 : BCC .on_bg2
    
    LDA.w #$1000 : STA $05
    
    .on_bg2
    
    SEP #$20
    
    LDA $1B : REP #$20 : BEQ .outdoors
    
    LDA $00 : AND.w #$01FF : LSR #3 : STA $04
    LDA $02 : AND.w #$01F8 : ASL #3 : CLC : ADC $04 : CLC : ADC $05 : TAX
    
    LDA $7F2000, X
    
    BRA .check_tile_type
    
    .outdoors
    
    LDA $02          : PHA
    LDA $00 : LSR #3 : STA $02
    PLA              : STA $00
    
    SEP #$30
    
    JSL Overworld_ReadTileAttr
    
    REP #$10
    
    .check_tile_type
    
    SEP #$30
    
    CMP.b #$08 : BEQ .water_tile
    CMP.b #$09 : BNE .not_water_tile
    
    .water_tile
    
    JSL Sprite_SpawnSmallWaterSplash : BMI .spawn_failed
    
    LDY $2F
    
    LDA $20 : CLC : ADC.l .y_offsets, X : PHP : SEC : SBC.b #$10              : STA $0D00, Y
    LDA $21 : SBC.b #$00          : PLP : ADC.l .y_offsets + 1, X : STA $0D20, Y
    
    LDA $22 : CLC : ADC.l .x_offsets, X : PHP : SEC : SBC.b #$08              : STA $0D10, Y
    LDA $23 : SBC.b #$00          : PLP : ADC.l .x_offsets + 1, X : STA $0D30, Y
    
    LDA $EE : STA $0F20, Y
    
    LDA.b #$00 : STA $0F70, Y
    
    PLX : PLY
    
    .spawn_failed
    .water_tile
    
    RTL
}

; ==============================================================================

; $0D7FFE-$0D7FFF NULL
{
}

; ==============================================================================
