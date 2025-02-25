; ==============================================================================

; Bank 1A
; $0D0000-$0D7FFF
org $1A8000

; SPC engine
; Music data
; Misc sprite draw

; ==============================================================================

; The later half of the SPC engine is right here and spills over from bank 19.
; TODO: Figure out how to represent that code.

; ==============================================================================

; $0D7424-$0D742F
GARBAGE_1AF424:
{
    db $34, $00, $00, $00, $00, $01, $FF, $00, $00, $00, $00, $00
}

; $0D7430-$0D74FF NULL
NULL_1AF430:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $0D7500-$0D758F DATA
SpriteDraw_BatCrash_oam_group:
{
    ; $0D7500
    .00
    dw   0,   0 : db $4B, $04, $00, $00

    ; $0D7508
    .01
    dw   5,  -4 : db $5B, $04, $00, $00

    ; $0D7510
    .02
    dw  -2,  -4 : db $64, $04, $00, $02

    ; $0D7518
    .03
    dw  -2,  -4 : db $49, $04, $00, $02

    ; $0D7520
    .04
    dw  -8,  -9 : db $6C, $04, $00, $02
    dw   8,  -9 : db $6C, $44, $00, $02

    ; $0D7530
    .05
    dw  -8,  -7 : db $4C, $04, $00, $02
    dw   8,  -7 : db $4C, $44, $00, $02

    ; $0D7540
    .06
    dw  -8,  -9 : db $44, $04, $00, $02
    dw   8,  -9 : db $44, $44, $00, $02

    ; $0D7550
    .07
    dw  -8,  -8 : db $62, $04, $00, $02
    dw   8,  -8 : db $62, $44, $00, $02

    ; $0D7560
    .08
    dw  -8,  -7 : db $60, $04, $00, $02
    dw   8,  -7 : db $60, $44, $00, $02

    ; $0D7570
    .09
    dw   0,   0 : db $4E, $04, $00, $02
    dw  16,   0 : db $4E, $44, $00, $02
    dw   0,  16 : db $6E, $04, $00, $02
    dw  16,  16 : db $6E, $44, $00, $02
}

; $0D7590-$0D75A4 DATA
Pool_BatCrash_Approach:
{
    ; $0D7590
    .position_x
    dw $07DC, $07F0, $0820, $0818

    ; $0D7598
    .position_y
    dw $062E, $0636, $0630, $05E0

    ; $0D75A0
    .anim_timer
    db 4, 3, 4, 6, 0
}

; ==============================================================================

; $0D75A5-$0D75D4
incsrc "sprite_waterfall.asm"

; $0D75D5-$0D785B
incsrc "sprite_retreat_bat.asm"

; ==============================================================================

; $0D785C-$0D788B DATA
Pool_DrinkingGuy_Draw:
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
    
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : ASL #3
    
    ADC.b #(.oam_groups)              : STA.b $08
    LDA.b #(.oam_groups) : ADC.b #$00 : STA.b $09
    
    LDA.b #$03 : STA.b $06
                 STZ.b $07
    
    JMP Lady_Draw_DrinkingGuy_continue
}

; ==============================================================================

; Generally speaking, this draws a lady sprite... can be young or old,
; but the same graphics either way.
; $0D792C-$0D7953 LONG JUMP LOCATION
Lady_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL A : ADC.w $0DC0, X : ASL #4
    
    ; $0D78AC
    ADC.b #$AC              : STA.b $08
    LDA.b #$F8 : ADC.b #$00 : STA.b $09
    
    ; $0D794A ALTERNATE ENTRY POINT
    .DrinkingGuy_continue
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7954-$0D7970 LOCAL JUMP LOCATION
Sprite6_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
    LDA.w $0FC1 : BNE .inactive
    LDA.b $11 : BNE .inactive
        LDA.w $0CAA, X : BMI .active  
        LDA.w $0F00, X : BEQ .active
    
    .inactive
    
    PLA : PLA
    
    .active
    
    RTS
}

; ==============================================================================

; $0D7971-$0D7980 DATA
Pool_Lanmola_SpawnShrapnel:
{
    ; $0D7971
    .speed_y
    db  28, -28,  28, -28,   0,  36,   0, -36

    ; $0D7979
    .speed_x
    db -28, -28,  28,  28, -36,   0,  36,   0
}
    
; $0D7981-$0D79E5 LONG JUMP LOCATION
Lanmola_SpawnShrapnel:
{
    ; Spawns Lanmolas' rocks when they pop out of the ground.
    LDY.b #$03
    
    LDA.w $0DD0 : CLC : ADC.w $0DD1 : ADC.w $0DD2 : CMP.b #$0A : BCS .BRANCH_ALPHA
        LDY.b #$07
    
    .BRANCH_ALPHA
    
    STY.w $0FB5
    
    .BRANCH_GAMMA
    
    LDA.b #$C2
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $00 : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $02 : ADC.b #$04 : STA.w $0D00, Y
        
        LDA.b #$01 : STA.w $0BA0, Y : STA.w $0CD2, Y : STA.w $0F60, Y
        
        DEC A : STA.w $0F70, Y
        
        LDA.b #$20 : STA.w $0E40, Y
        
        PHX
        
        LDX.w $0FB5
        
        LDA.l Pool_Lanmola_SpawnShrapnel_speed_x, X : STA.w $0D50, Y
        LDA.l Pool_Lanmola_SpawnShrapnel_speed_y, X : STA.w $0D40, Y
        
        JSL.l GetRandomInt : AND.b #$01 : STA.w $0DC0, Y
        
        PLX
    
    .spawn_failed
    
    DEC.w $0FB5 : BPL .BRANCH_GAMMA
    
    RTL
}

; ==============================================================================

; $0D79E6-$0D7B2B
incsrc "sprite_cukeman.asm"

; ==============================================================================

; $0D7B2C-$0D7B7A LONG JUMP LOCATION
RunningMan_SpawnDashDustGarnish:
{
    INC.w $0CBA, X : LDA.w $0CBA, X : AND.b #$0F : BNE .delay
        PHX : TXY
        
        LDX.b #$1D
        
        .find_empty_slot
        
            LDA.l $7FF800, X : BEQ .empty_slot
        DEX : BPL .find_empty_slot
        
        INX
        
        .empty_slot
        
        LDA.b #$14 : STA.l $7FF800, X : STA.w $0FB4
        
        LDA.w $0D10, Y : CLC : ADC.b #$04 : STA.l $7FF83C, X
        LDA.w $0D30, Y       : ADC.b #$00 : STA.l $7FF878, X
        
        LDA.w $0D00, Y : CLC : ADC.b #$1C : STA.l $7FF81E, X
        LDA.w $0D20, Y       : ADC.b #$00 : STA.l $7FF85A, X
        
        LDA.b #$0A : STA.l $7FF90E, X
        
        PLX
    
    .delay
    
    RTL ; Original dissasembly had this as an RTS.
}

; ==============================================================================

; $0D7B7B-$0D7BDA DATA
Pool_Overworld_SubstituteAlternateSecret:
{
    ; $0D7B7B
    .AreaIndex
    db $00, $00, $00, $00, $00, $00, $00, $04
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $04, $04, $06, $04, $04, $06, $00, $00
    db $0F, $0F, $04, $05, $05, $04, $06, $06
    db $0F, $0F, $04, $05, $05, $07, $06, $06
    db $1F, $1F, $04, $07, $07, $04, $06, $06
    db $06, $07, $02, $00, $00, $00, $00, $00
    db $06, $06, $02, $00, $00, $00, $00, $00

    ; $D7BBB
    .ItemPool
    db $01, $01, $01, $01, $0F, $01, $01, $12
    db $10, $01, $01, $01, $11, $01, $01, $03

    ; $D7BCB
    .AreaMask
    db $00, $00, $00, $00, $02, $00, $00, $08
    db $10, $00, $00, $00, $01, $00, $00, $00
}

; ==============================================================================

; $0D7BDB-$0D7C30 LONG JUMP LOCATION
Overworld_SubstituteAlternateSecret:
{
    PHB : PHK : PLB
    
    !num_live_sprites = $0D
    
    JSL.l GetRandomInt : AND.b #$01 : BNE .return
        STZ !num_live_sprites
        
        LDY.b #$0F
        
        .next_sprite
            
            LDA.w $0DD0, Y : BEQ .dead_sprite
                LDA.w $0E20, Y : CMP.b #$6C : BEQ .is_warp_vortex
                    INC !num_live_sprites
                
                .is_warp_vortex
            .dead_sprite
        
        DEY : BPL .next_sprite
        
        LDA !num_live_sprites : CMP.b #$04 : BCS .return
            LDA.l $7EF3C5 : CMP.b #$02 : BCC .return
                LDA.w $0CF7 : INC.w $0CF7 : AND.b #$07
                
                LDY.w $0FFF : BEQ .in_light_world
                    ORA.b #$08
                
                .in_light_world
                
                TAY
                
                PHX
                
                LDA.w $040A : AND.b #$3F : TAX
                
                LDA Pool_Overworld_SubstituteAlternateSecret_AreaIndex, X
                AND .AreaMask, Y : BNE .BRANCH_EPSILON
                    LDA Pool_Overworld_SubstituteAlternateSecret_ItemPool, Y : STA.w $0B9C
                
                .BRANCH_EPSILON
                
                PLX
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7C31-$0D7CEC
incsrc "sprite_movable_mantle.asm"

; ==============================================================================

; $0D7CED-$0D7DAC DATA
Pool_Mothula_Draw:
{
    .oam_groups
    dw -24,  -8 : db $80, $00, $00, $02
    dw  -8,  -8 : db $82, $00, $00, $02
    dw   8,  -8 : db $82, $40, $00, $02
    dw  24,  -8 : db $80, $40, $00, $02
    dw -24,   8 : db $A0, $00, $00, $02
    dw  -8,   8 : db $A2, $00, $00, $02
    dw   8,   8 : db $A2, $40, $00, $02
    dw  24,   8 : db $A0, $40, $00, $02

    dw -24,  -8 : db $84, $00, $00, $02
    dw  -8,  -8 : db $86, $00, $00, $02
    dw   8,  -8 : db $86, $40, $00, $02
    dw  24,  -8 : db $84, $40, $00, $02
    dw -24,   8 : db $A4, $00, $00, $02
    dw  -8,   8 : db $A6, $00, $00, $02
    dw   8,   8 : db $A6, $40, $00, $02
    dw  24,   8 : db $A4, $40, $00, $02

    dw  -8,  -8 : db $88, $00, $00, $02
    dw  -8,  -8 : db $88, $00, $00, $02
    dw   8,  -8 : db $88, $40, $00, $02
    dw   8,  -8 : db $88, $40, $00, $02
    dw  -8,   8 : db $A8, $00, $00, $02
    dw  -8,   8 : db $A8, $00, $00, $02
    dw   8,   8 : db $A8, $40, $00, $02
    dw   8,   8 : db $A8, $40, $00, $02
}

; ==============================================================================

; $0D7DAD-$0D7DB4 LONG JUMP LOCATION
Mothula_DrawLong:
{
    ; Something related to drawing Mothula (Gamoth?) or his beams?
    PHB : PHK : PLB
    
    JSR.w Mothula_Draw
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7DB5-$0D7E7D LOCAL JUMP LOCATION
Mothula_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #6 : ADC.w #$FCED : STA.b $08
    
    LDA.w #$0920 : STA.b $90
    
    LDA.w #$0A68 : STA.b $92
    
    SEP #$20
    
    LDA.b #$08 : JSL.l Sprite_DrawMultiple
    
    LDA.w $0F00, X : BNE .skip
        PHX
        
        LDA.w $0DC0, X : ASL #3 : ADC.w $0DC0, X : STA.b $06
        
        LDA.b $02 : CLC : ADC.w $0F70, X : STA.b $02
        LDA.b $03 : ADC.b #$00   : STA.b $03
        
        LDY.b #$28
        LDX.b #$08

        .next_oam_entry

            PHX
            
            TXA : CLC : ADC.b $06 : ASL A : TAX
            
            REP #$20
            
            LDA.b $00 : CLC : ADC .x_offsets, X : STA ($90), Y
            
            AND.w #$0100 : STA.b $0E
            
            INY
            
            LDA.b $02 : CLC : ADC.w #$0010 : STA ($90), Y
            
            CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
                LDA.b #$F0 : STA ($90), Y

            .on_screen_y

            INY
            
            LDA.b #$6C : STA ($90), Y
            
            INY
            
            LDA.b #$24 : STA ($90), Y
            
            PHY
            
            TYA : LSR #2 : TAY
            
            LDA.b #$02 : ORA.b $0F : STA ($92), Y
            
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
Pool_BottleVendor_PayForGoodBee:
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
    
    LDA.b #$13 : JSL.l Sound_SetSfx3PanLong
    
    LDA.b #$04 : STA.w $0FB5
    
    .next_red_rupee
    
        LDA.b #$DB : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
            
            LDA.b #$FF : STA.w $0B58, Y
            
            PHX
            
            LDX.w $0FB5
            
            LDA.w .x_speeds, X : STA.w $0D50, Y
            
            LDA.w .y_speeds, X : STA.w $0D40, Y
            
            LDA.b #$20 : STA.w $0F80, Y
                         STA.w $0F10, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .next_red_rupee
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7ECF-$0D7ED2 LONG JUMP LOCATION
Sprite_ChickenLadyLong:
{
    JSR.w Sprite_ChickenLady        
    
    RTL
}

; ==============================================================================

; $0D7ED3-$0D7EFF LOCAL JUMP LOCATION
Sprite_ChickenLady:
{
    LDA.b #$01 : STA.w $0DE0, X
    
    JSL.l Lady_Draw
    JSR.w Sprite6_CheckIfActive
    
    LDA.w $0DF0, X : CMP.b #$01 : BNE .anoshow_message
        ; "Cluck cluck...  What?! (...) I can even speak! ...".
        LDA.b #$7D : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        
        JSL.l Sprite_ShowMessageMinimal
    
    .anoshow_message
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0D7F00-$0D7F2A LONG JUMP LOCATION
SpritePrep_DiggingGameGuy:
{
    LDA.w $0D00, X : STA.b $00
    LDA.w $0D20, X : STA.b $01
    
    REP #$20
    
    LDA.b $20 : CMP.b $00 : SEP #$30 : BCS .player_below_proprietor
        ; This is in case you warp into the digging game field from the light
        ; world (as a result of the mirror warp vortex taking you back to the
        ; dark world).
        LDA.b #$05 : STA.w $0D80, X
        
        LDA.w $0D10, X : SEC : SBC.b #$09 : STA.w $0D10, X
        
        LDA.b #$01 : STA.w $0DC0, X
    
    .player_below_proprietor
    
    INC.w $0BA0, X
    
    RTL
}

; ==============================================================================

; $0D7F2B-$0D7F3B DATA
Pool_Player_SpawnSmallWaterSplashFromHammer:
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
    LDA.b $11 : ORA.w $02E4 : ORA.w $0FC1 : BNE Pool_Player_SpawnSmallWaterSplashFromHammer_easy_out
    
        PHX : PHY
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $22 : CLC : ADC.l .x_offsets, X : STA.b $00
        LDA.b $20 : CLC : ADC.l .y_offsets, X : STA.b $02
        
        SEP #$20
        
        LDA.b $EE : CMP.b #$01 : REP #$30 : STZ.b $05 : BCC .on_bg2
            LDA.w #$1000 : STA.b $05
        
        .on_bg2
        
        SEP #$20
        
        LDA.b $1B : REP #$20 : BEQ .outdoors
            LDA.b $00 : AND.w #$01FF : LSR #3 : STA.b $04
            LDA.b $02 : AND.w #$01F8 : ASL #3 : CLC : ADC.b $04 : CLC : ADC.b $05 : TAX
            
            LDA.l $7F2000, X
            
            BRA .check_tile_type
        
        .outdoors
        
        LDA.b $02          : PHA
        LDA.b $00 : LSR #3 : STA.b $02
        PLA              : STA.b $00
        
        SEP #$30
        
        JSL.l Overworld_ReadTileAttr
        
        REP #$10
        
        .check_tile_type
        
        SEP #$30
        
        CMP.b #$08 : BEQ .water_tile
            CMP.b #$09 : BNE .not_water_tile
                .water_tile
                
                JSL.l Sprite_SpawnSmallWaterSplash : BMI .spawn_failed
                    LDY.b $2F
                    
                    LDA.b $20 : CLC : ADC.l .y_offsets, X : PHP : SEC : SBC.b #$10              : STA.w $0D00, Y
                    LDA.b $21 : SBC.b #$00          : PLP : ADC.l .y_offsets + 1, X : STA.w $0D20, Y
                    
                    LDA.b $22 : CLC : ADC.l .x_offsets, X : PHP : SEC : SBC.b #$08              : STA.w $0D10, Y
                    LDA.b $23 : SBC.b #$00          : PLP : ADC.l .x_offsets + 1, X : STA.w $0D30, Y
                    
                    LDA.b $EE : STA.w $0F20, Y
                    
                    LDA.b #$00 : STA.w $0F70, Y
                    
                    PLX : PLY
                
                .spawn_failed
        .not_water_tile
        
        RTL
}

; ==============================================================================

; $0D7FFE-$0D7FFF NULL
NULL_1AFFFE:
{
    db $FF, $FF
}

; ==============================================================================

warnpc $1B8000
