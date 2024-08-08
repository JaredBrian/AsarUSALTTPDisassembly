; ==============================================================================

!animation_step_polarity = $0DE0

; ==============================================================================

; $0ECFC3-$0ECFCA DATA
Pool_Boulder_Main:
{
    ; NOTE: The second number in the pairs on each line correspond to the
    ; value used if the boulder hit a solid tile on the previous frame.
    ; $0ECFC3
    .z_speeds
    db  32,  48
    
    ; $0ECFC5
    .y_speeds
    db   8,  32
    
    ; $0ECFC7
    .x_speeds
    db  24,  16
    db -24, -16
}

; ==============================================================================

; $0ECFCB-$0ED029 JUMP LOCATION
Sprite_Boulder:
Sprite_Shrapnel:
{
    ; This sprite manifests as a boulder outdoors, and as shrapnel indoors.
    LDA.b $1B : BEQ Boulder_Main
        ; Check if we can draw.
        LDA.w $0FC6 : CMP.b #$03 : BCS .invalid_gfx_loaded
            JSL.l Sprite_PrepAndDrawSingleSmallLong
        
        .invalid_gfx_loaded
        
        JSR.w Sprite4_CheckIfActive
        
        LDA.b $1A : ASL #2 : AND.b #$C0 : ORA.b #$00 : STA.w $0F50, X
        
        JSR.w Sprite4_MoveXyz
        
        TXA : EOR.b $1A : AND.b #$03 : BNE .delay
            REP #$20
            
            LDA.w $0FD8 : SEC : SBC.b $22 : CLC : ADC.w #$0004
            CMP.w #$0010 : BCS .player_not_close
                LDA.w $0FDA : SEC : SBC.b $20 : CLC : ADC.w #$FFFC
                CMP.w #$000C : BCS .player_not_close
                    SEP #$20
                    
                    JSL.l Sprite_AttemptDamageToPlayerPlusRecoilLong
                
            .player_not_close
            
            SEP #$20
            
            TXA : EOR.b $1A : AND.b #$03 : BNE .delay
            
            JSR.w Sprite4_CheckTileCollision : BEQ .no_tile_collision
                STZ.w $0DD0, X
            
            .no_tile_collision
        .delay
        
        RTS
}
    
; ==============================================================================

; $0ED02A-$0ED087 BRANCH LOCATION
Boulder_Main:
{
    ; Uses super priority for oam.
    LDA.b #$30 : STA.w $0B89, X
    
    JSR.w Boulder_Draw
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0E80, X : SEC : SBC !animation_step_polarity, X : STA.w $0E80, X
    
    JSR.w Sprite4_CheckDamage
    JSR.w Sprite4_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
        ; Once the boulder hits the ground, we have to select new xyz speeds
        ; for it (in other words, it bounces or tumbles periodically).
        STZ.w $0F70, X
        
        JSR.w Sprite4_CheckTileCollision
        
        LDY.b #$00
        
        LDA.w $0E70, X : BEQ .no_tile_collision
            INY
        
        .no_tile_collision
        
        LDA Pool_Boulder_Main_z_speeds, Y : STA.w $0F80, X
        
        LDA Pool_Boulder_Main_y_speeds, Y : STA.w $0D40, X
        
        JSL.l GetRandomInt : AND.b #$01 : BEQ .bounce_right
            ; bounce left.
            INY #2
        
        .bounce_right
        
        LDA Pool_Boulder_Main_x_speeds, Y : STA.w $0D50, X
        
        ; Choose the next polarity for the animation counter to step (Could
        ; end up the same as previous. It's random.)
        TYA : AND.b #$02 : DEC A : STA !animation_step_polarity, X
        
        LDA.b #$0B : JSL.l Sound_SetSfx2PanLong
    
    .aloft
    
    RTS
}

; ==============================================================================

; $0ED088-$0ED107 DATA
Boulder_Draw_oam_groups:
{
    dw -8, -8 : db $CC, $01, $00, $02
    dw  8, -8 : db $CE, $01, $00, $02
    dw -8,  8 : db $EC, $01, $00, $02
    dw  8,  8 : db $EE, $01, $00, $02
    
    dw -8, -8 : db $CE, $41, $00, $02
    dw  8, -8 : db $CC, $41, $00, $02
    dw -8,  8 : db $EE, $41, $00, $02
    dw  8,  8 : db $EC, $41, $00, $02
    
    dw -8, -8 : db $EE, $C1, $00, $02
    dw  8, -8 : db $EC, $C1, $00, $02
    dw -8,  8 : db $CE, $C1, $00, $02
    dw  8,  8 : db $CC, $C1, $00, $02
    
    dw -8, -8 : db $EC, $81, $00, $02
    dw  8, -8 : db $EE, $81, $00, $02
    dw -8,  8 : db $CC, $81, $00, $02
    dw  8,  8 : db $CE, $81, $00, $02
}
    
; $0ED108-$0ED184 DATA
Pool_Sprite_DrawLargeShadow:
{
    ; $0ED108
    .oam_groups
    .group00
    dw -6, 19 : db $6C, $08, $00, $02
    dw  0, 19 : db $6C, $08, $00, $02
    dw  6, 19 : db $6C, $08, $00, $02
    
    ; $0ED120
    .group01
    dw -5, 19 : db $6C, $08, $00, $02
    dw  0, 19 : db $6C, $08, $00, $02
    dw  5, 19 : db $6C, $08, $00, $02
    
    ; $0ED138
    .group02
    dw -4, 19 : db $6C, $08, $00, $02
    dw  0, 19 : db $6C, $08, $00, $02
    dw  4, 19 : db $6C, $08, $00, $02
    
    ; $0ED150
    .group03
    dw -3, 19 : db $6C, $08, $00, $02
    dw  0, 19 : db $6C, $08, $00, $02
    dw  3, 19 : db $6C, $08, $00, $02
    
    ; $0ED168
    .group04
    dw -2, 19 : db $6C, $08, $00, $02
    dw  0, 19 : db $6C, $08, $00, $02
    dw  2, 19 : db $6C, $08, $00, $02

    ; $0ED180
    .data_offset
    db .group00-.group00 ; $00
    db .group01-.group00 ; $18
    db .group02-.group00 ; $30
    db .group03-.group00 ; $48
    db .group04-.group00 ; $60
}

; $0ED185-$0ED1A7 LOCAL JUMP LOCATION
Boulder_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0E80, X : LSR #3 : AND.b #$03 : REP #$20 : ASL #5
    
    ADC.w #(.oam_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$04
    
    JSR.w Sprite4_DrawMultiple
    JSL.l Sprite_DrawVariableSizedShadow
    
    RTS
}

; $0ED1A8-$0ED1AE LONG JUMP LOCATION
Sprite_DrawLargeShadow:
{
    PHB : PHK : PLB
    
    LDY.b #$00
    BRA Sprite_DrawVariableSizedShadow_dont_use_smallest
}
    
; $0ED1AF-$0ED1FC LONG JUMP LOCATION
Sprite_DrawVariableSizedShadow:
{
    PHB : PHK : PLB
    
    LDA.w $0F70, X : LSR #3 : TAY
    
    CPY.b #$04 : BCC .dont_use_smallest
        LDY.b #$04
    
    ; $0ED1BF ALTERNATE ENTRY POINT
    .dont_use_smallest
    
    LDA.w $0F70, X : STA.b $0E
                     STZ.b $0F
    
    LDA.w .data_offset, Y : STA.b $00
                          STZ.b $01
    
    REP #$20
    
    LDA.w $0FDA : CLC : ADC.b $0E : STA.w $0FDA
    
    LDA.b $90 : CLC : ADC.w #$0010 : STA.b $90
    
    LDA.b $92 : CLC : ADC.w #$0004 : STA.b $92
    
    LDA.w #(Pool_Sprite_DrawLargeShadow_oam_groups) : CLC : ADC.w $00 : STA.b $08
    
    SEP #$20
    
    LDA.b #$03 : JSR.w Sprite4_DrawMultiple
    
    ; Since we modified the coordinates of the sprite in order to
    ; draw the shadow, restore them to what they ought to be.
    JSL.l Sprite_Get_16_bit_CoordsLong
    
    PLB
    
    RTL
}

; ==============================================================================
