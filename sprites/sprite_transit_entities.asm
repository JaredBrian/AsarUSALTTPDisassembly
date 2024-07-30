
; ==============================================================================

; $0F7632-$0F76A0 JUMP LOCATION
Pipe_LocateTransitTile:
{
    ; Not really certain whether this is necessary <___<.
    LDA.b #$FF : STA.w $1DE0
    
    LDA.w $0E20, X : SEC : SBC.b #$AE : STA.w $0DE0, X
    
    ; $0F7640 ALTERNATE ENTRY POINT
    shared SomariaPlatform_LocateTransitTile:
    
    .try_another_tile
    
    ; $0F77C2 IN ROM ; Get the tile type the sprite interacted with.
    JSR.w $F7C2 : STA.w $0E90, X
    
    SEC : SBC.b #$B0 : BCS .is_upper_tile
    
    .not_pipe_tile
    
    LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, X
    LDA.w $0D30, X : ADC.b #$00 : STA.w $0D30, X
    
    LDA.w $0D00, X : CLC : ADC.b #$08 : STA.w $0D00, X
    LDA.w $0D20, X : ADC.b #$00 : STA.w $0D20, X
    
    ; BUG: This seems to have the potential to crash the game if the pipe
    ; sprite is used in a room it should be used in.
    BRA .try_another_tile
    
    .is_upper_tile
    
    CMP.b #$0F : BCS .not_pipe_tile
    
    ; Reaching this address means that we were able to find a special tile
    ; (0xB0 to 0xBE) to bind to, somewhere in the map.
    LDA.w $0D10, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.w $0D10, X
    
    LDA.w $0D00, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.w $0D00, X
    
    LDA.w $0DE0, X : STA.w $0EB0, X
    
    JSR.w $F7AF ; $0F77AF IN ROM
    
    INC.w $0BA0, X
    
    STZ.w $02F5
    
    LDA.b #$0E : STA.w $0F10, X
    
    INC.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F76A1-$0F76A8 LONG JUMP LOCATION
Sprite_SomariaPlatformLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_SomariaPlatform
    
    PLB
    
    RTL
}

; ==============================================================================

; $0F76A9-$0F76D3 DATA
{
    .x_speeds
    db $00, $00, $F0, $10
    
    ; $F76AD
    .unused_1
    db $F0, $10, $10
    
    ; $F76B0
    .y_speeds
    db $F0, $10, $00, $00
    
    ; $F76B4
    .unused_2
    db $F0, $10, $F0, $10
    
    ; $F76B8
    db $00, $00, $FF, $00
    
    ; $F76BC
    .unused_3
    db $FF
    
    ; $F76BD
    db $00, $00, $FF, $01
    
    db $FF, $01, $01, $FF, $01, $00, $00, $FF
    db $01, $FF, $01, $FF, $00, $00, $00, $FF
    db $00, $FF, $00
}

; ==============================================================================

; $0F76D4-$0F76DE LOCAL JUMP LOCATION
Sprite_SomariaPlatform:
{
    ; sprite types 0xED, 0xEF, $F0, and $F1 (cane of somaria platform)
    
    LDA.w $0DC0, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $F6DF ; = $F76DF*
    dw $F709 ; = $F7709*
}

; ==============================================================================

; $0F76DF-$0F7708 JUMP LOCATION
{
    JSR SomariaPlatform_LocateTransitTile
    JSL Sprite_SpawnSuperficialBombBlast
    
    ; x coordinate -= 0x08
    LDA.w $0D10, Y : SEC : SBC.b #$08 : STA.w $0D10, Y
    LDA.w $0D30, Y : SBC.b #$00 : STA.w $0D30, Y
    
    ; y coordinate -= 0x08
    LDA.w $0D00, Y : SEC : SBC.b #$08 : STA.w $0D00, Y
    LDA.w $0D20, Y : SBC.b #$00 : STA.w $0D20, Y
    
    RTS
}

; ==============================================================================

; $0F7709-$0F77C1 JUMP LOCATION
{
    JSR.w $F860 ; $0F7860 IN ROM
    JSR Sprite3_CheckIfActive
    
    LDA.w $0B7C : ORA.w $0B7D : ORA.w $0B7E : ORA.w $0B7F : BEQ .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    JMP.w $F7A3 ; $0F77A3 IN ROM
    
    .BRANCH_ALPHA
    
    LDA.b $5B : DEC #2 : BPL .BRANCH_BETA
    
    JSL Sprite_CheckDamageToPlayerIgnoreLayerLong : BCC .BRANCH_GAMMA
    
    LDA.b #$01 : STA.w $0DB0, X
    
    JSL Player_HaltDashAttackLong
    
    LDA.b $5D
    
    CMP.b #$13 : BEQ .BRANCH_GAMMA
    CMP.b #$03 : BEQ .BRANCH_GAMMA
    
    LDA.w $0D80, X : BNE .BRANCH_DELTA
    
    INC.w $0D90, X
    
    LDA.b #$02 : STA.w $02F5
    
    LDA.w $0D90, X : AND.b #$07 : BNE .BRANCH_EPSILON
    
    JSR.w $F7C2 ; $0F77C2 IN ROM
    
    CMP.w $0E90, X : BEQ .BRANCH_EPSILON
    
    STA.w $0E90, X
    
    LDA.w $0DE0, X : STA.w $0EB0, X
    
    JSR.w $F7AF ; $0F77AF IN ROM
    JSR.w $F901 ; $0F7901 IN ROM
    
    .BRANCH_EPSILON
    
    LDA.b $A0 : CMP.b #$24 : BEQ .BRANCH_ZETA
    
    LDY.w $0DE0, X
    
    LDA.w $F6BD, Y : CLC : ADC.w $0B7C : STA.w $0B7C
    LDA.w $F6B8, Y : ADC.w $0B7D : STA.w $0B7D
    
    LDA.w $F6C4, Y : CLC : ADC.w $0B7E : STA.w $0B7E
    LDA.w $F6CC, Y : ADC.w $0B7F : STA.w $0B7F
    
    JSR Sprite3_Move
    JSR.w $FB49 ; $0F7B49 IN ROM
    
    RTS
    
    .BRANCH_ZETA
    
    JMP.w $FB34 ; $0F7B34 IN ROM
    
    ; $0F77A3 ALTERNATE ENTRY POINT
    .BRANCH_GAMMA
    
    LDA.w $0DB0, X : BEQ .BRANCH_THETA
    
    STZ.w $02F5
    STZ.w $0DB0, X
    
    .BRANCH_THETA
    
    RTS
    
    ; $0F77AF ALTERNATE ENTRY POINT
    .BRANCH_DELTA
    
    JSR.w $F87D ; $0F787D IN ROM
    
    LDY.w $0DE0, X
    
    LDA.w $F6A9, Y : STA.w $0D50, X
    
    LDA.w $F6B0, Y : STA.w $0D40, X
    
    RTS
}

; $0F77C2-$0F77DF LOCAL JUMP LOCATION
{
    LDA.w $0D00, X : STA.b $00
    LDA.w $0D20, X : STA.b $01
    
    LDA.w $0D10, X : STA.b $02
    LDA.w $0D30, X : STA.b $03
    
    ; Forced to check on bg2 (the main bg).
    LDA.b #$00 : JSL Entity_GetTileAttr
    
    LDA.w $0FA5
    
    RTS
}

; ==============================================================================

; $0F77E0-$0F785F DATA
{
    ; TODO: Name this Pool_/ routine.
    .oam_groups
    dw -16, -16 : db $AC, $00, $00, $02
    dw   0, -16 : db $AC, $40, $00, $02
    dw -16,   0 : db $AC, $80, $00, $02
    dw   0,   0 : db $AC, $C0, $00, $02
    
    dw -13, -13 : db $AC, $00, $00, $02
    dw  -3, -13 : db $AC, $40, $00, $02
    dw -13,  -3 : db $AC, $80, $00, $02
    dw  -3,  -3 : db $AC, $C0, $00, $02
    
    dw -10, -10 : db $AC, $00, $00, $02
    dw  -6, -10 : db $AC, $40, $00, $02
    dw -10,  -6 : db $AC, $80, $00, $02
    dw  -6,  -6 : db $AC, $C0, $00, $02
    
    dw  -8,  -8 : db $AC, $00, $00, $02
    dw  -8,  -8 : db $AC, $40, $00, $02
    dw  -8,  -8 : db $AC, $80, $00, $02
    dw  -8,  -8 : db $AC, $C0, $00, $02
}

; ==============================================================================

; $0F7860-$0F787C LOCAL JUMP LOCATION
{
    LDA.b #$10 : JSL OAM_AllocateFromRegionB
    
    LDA.w $0F10, X : AND.b #$0C : ASL #3
    
    ADC.b #.oam_groups                 : STA.b $08
    LDA.b #.oam_groups>>8 : ADC.b #$00 : STA.b $09
    
    LDA.b #$04 : JMP Sprite3_DrawMultiple
}

; ==============================================================================

; $0F787D-$0F78AC LOCAL JUMP LOCATION
{
    LDA.w $0E90, X : SEC : SBC.b #$B0 : BCS .is_upper_tile
    
    RTS
    
    .is_upper_tile
    
    CMP.b #$0F : BCC .is_transit_tile
    
    RTS
    
    .is_transit_tile
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $F908 ; = $F7908  ; 0xB0 - (RTS)
    dw $F908 ; = $F7908  ; 0xB1 - (RTS)
    dw $F909 ; = $F7909* ; 0xB2 - Zig zag rising slope
    dw $F912 ; = $F7912* ; 0xB3 - Zig zag falling slope
    dw $F912 ; = $F7912* ; 0xB4 - Zig zag falling slope
    dw $F909 ; = $F7909* ; 0xB5 - Zig zag rising slope
    dw $F91F ; = $F791F* ; 0xB6 - Transit tile allowing direction inversion?
    dw $F946 ; = $F7946* ; 0xB7 - T junction transit tile (can't go up)
    dw $F9A3 ; = $F79A3* ; 0xB8 - T junction transit tile (can't go down)
    dw $FA02 ; = $F7A02* ; 0xB9 - T junction transit tile (can't go left)
    dw $FA61 ; = $F7A61* ; 0xBA - T junction transit tile (can't go right)
    dw $FAC0 ; = $F7AC0* ; 0xBB - Transit tile junction that allows movement in all directions except for the one you came from.
    dw $FAFF ; = $F7AFF* ; 0xBC - Straight transit line junction? Question mark looking. Only allows travel in two colinear directions.
    dw $F908 ; = $F7908* ; 0xBD - (RTS)
    dw $FB3A ; = $F7B3A* ; 0xBE - Endpoint node transit tile
}

; $0F78AD-$0F78D6 LOCAL JUMP LOCATION
{
    LDA.w $0DE0, X : EOR.w $0EB0, X : AND.b #$02 : BEQ .BRANCH_ALPHA
    
    LDA.w $0D10, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.b $00
    
    SEC : SBC.w $0D10, X : BEQ .BRANCH_ALPHA
    
    STA.w $0B7C : BPL .BRANCH_BETA
    
    LDA.b #$FF : STA.w $0B7D
    
    .BRANCH_BETA
    
    LDA.b $00 : STA.w $0D10, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F78D7-$0F7900 LOCAL JUMP LOCATION
{
    LDA.w $0DE0, X : EOR.w $0EB0, X : AND.b #$02 : BEQ .BRANCH_ALPHA
    
    LDA.w $0D00, X : AND.b #$F8 : CLC : ADC.b #$04 : STA.b $00
    
    SEC : SBC.w $0D00, X : BEQ .BRANCH_ALPHA
    
    STA.w $0B7E : BPL .BRANCH_BETA
    
    LDA.b #$FF : STA.w $0B7F
    
    .BRANCH_BETA
    
    LDA.b $00 : STA.w $0D00, X
    
    .BRANCH_ALPHA
    
    RTS
} 

; $0F7901-$0F7907 LOCAL JUMP LOCATION
{
    JSR.w $F8AD ; $0F78AD IN ROM
    JSR.w $F8D7 ; $0F78D7 IN ROM
    
    RTS
}

; $0F7908-$0F7908 JUMP LOCATION
{
    RTS
}

; $0F7909-$0F7911 JUMP LOCATION
{
    ; zig zag along y = x line. Zig zag rising slope?
    LDA.w $0DE0, X : EOR.b #$03 : STA.w $0DE0, X
    
    RTS
}

; $0F7912-$0F791A JUMP LOCATION
{
    ; zig zag along y = -x line. zig zag falling slope?
    LDA.w $0DE0, X : EOR.b #$02 : STA.w $0DE0, X
    
    RTS
}

; $0F791B-$0F791E DATA
{
    db $04, $08, $01, $02
}

; $0F791F-$0F7941 JUMP LOCATION
{
    ; Transit tile that allows you to invert your direction?
    
    LDA.b #$01 : STA.w $0D80, X
    
    LDA.b $4D : BNE .BRANCH_ALPHA
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $F91B, Y : BEQ .BRANCH_ALPHA
    
    STZ.w $0D80, X
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    .BRANCH_ALPHA
    
    STZ.b $4B
    
    JMP.w $FB34 ; $0F7B34 IN ROM
}

; ==============================================================================

; $0F7942-$0F7945 DATA
{
    db $03, $07, $06, $05    
}

; ==============================================================================

; $0F7946-$0F799E JUMP LOCATION
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $F942, Y : STA.b $00 : AND.b #$08 : BEQ .always
    
    LDA.b #$00 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .always
    
    LDA.b $00 : AND.b #$04 : BEQ .no_pressing_down
    
    LDA.b #$01 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_down
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
    
    LDA.b #$02 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_left
    
    LDA.b $00 : AND.b #$01 : BEQ .not_pressing_right
    
    LDA.b #$03 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    .not_pressing_right
    
    LDA.w $0DE0, X : BNE .not_going_up
    
    ; If we are going up, automatically head left once we hit the T
    ; intersection.
    LDA.b #$02 : STA.w $0DE0, X
    
    .not_going_up
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F799F-$0F79A2 DATA
{
    db $0B, $03, $0A, $09
}

; ==============================================================================

; $0F79A3-$0F79FD JUMP LOCATION
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $F99F, Y : STA.b $00 : AND.b #$08 : BEQ .not_pressing_up
    
    LDA.b #$00 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$04 : BEQ .always
    
    LDA.b #$01 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .always
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
    
    LDA.b #$02 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_left
    
    LDA.b $00 : AND.b #$01 : BEQ .not_pressing_right
    
    LDA.b #$03 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    .not_pressing_right
    
    LDA.w $0DE0, X : CMP.b #$01 : BNE .not_going_down
    
    ; Automatically choose left as the next direction
    LDA.b #$02 : STA.w $0DE0, X
    
    .not_going_down
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F79FE-$0F7A01 DATA
{
    db $09, $05, $0C, $0D
}

; ==============================================================================

; $0F7A02-$0F7A5C JUMP LOCATION
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $F9FE, Y : STA.b $00 : AND.b #$08 : BEQ .not_pressing_up
    
    LDA.b #$00 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$04 : BEQ .not_pressing_up
    
    LDA.b #$01 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$02 : BEQ .always
    
    LDA.b #$02 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .always
    
    LDA.b $00 : AND.b #$01 : BEQ .not_pressing_right
    
    LDA.b #$03 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    .not_pressing_right
    
    LDA.w $0DE0, X : CMP.b #$02 : BNE .not_heading_left
    
    ; Force heading to going up.
    LDA.b #$00 : STA.w $0DE0, X
    
    .not_going_left
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F7A5D-$0F7A60 DATA
{
    db $0A, $06, $0E, $0C
}

; ==============================================================================

; $0F7A61-$0F7ABB JUMP LOCATION
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $FA5D, Y : STA.b $00 : AND.b #$08 : BEQ .not_pressing_up
    
    LDA.b #$00 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_up:
    
    LDA.b $00 : AND.b #$04 : BEQ .not_pressing_down
    
    LDA.b #$01 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_down
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
    
    LDA.b #$02 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    BRA .return
    
    .not_pressing_left
    
    LDA.b $00 : AND.b #$01 : BEQ .always
    
    LDA.b #$03 : STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    .always
    
    LDA.w $0DE0, X : CMP.b #$03 : BNE .not_going_right
    
    ; Default heading in reaction to this tile is going up.
    LDA.b #$00 : STA.w $0DE0, X
    
    .not_going_right
    
    STZ.w $0D80, X
    
    .return
    
    RTS
}

; ==============================================================================

; $0F7ABC-$0F7ABF DATA
{
    db $0B, $07, $0E, $0D
}

; ==============================================================================

; $0F7AC0-$0F7AFA JUMP LOCATION
{
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $FABC, Y : STA.b $00 : AND.b #$08 : BEQ .BRANCH_ALPHA
    
    LDA.b #$00 : STA.w $0DE0, X
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b $00 : AND.b #$04 : BEQ .BRANCH_GAMMA
    
    LDA.b #$01 : STA.w $0DE0, X
    
    BRA .BRANCH_BETA
    
    .BRANCH_GAMMA
    
    LDA.b $00 : AND.b #$02 : BEQ .BRANCH_DELTA
    
    LDA.b #$02 : STA.w $0DE0, X
    
    BRA .BRANCH_BETA
    
    .BRANCH_DELTA
    
    LDA.b $00 : AND.b #$01 : BEQ .BRANCH_BETA
    
    LDA.b #$03 : STA.w $0DE0, X
    
    .BRANCH_BETA
    
    RTS
}

; ==============================================================================

; $0F7AFB-$0F7AFE DATA
{
    db $0C, $0C, $03, $03
}

; ==============================================================================

; $0F7AFF-$0F7B39 JUMP LOCATION
{
    LDA.b #$01 : STA.w $0D80, X
    
    LDY.w $0DE0, X
    
    LDA.b $F0 : AND.w $FAFB, Y : BEQ .not_pressing_any_directions
    
    STA.b $00 : AND.b #$08 : BEQ .not_pressing_up
    
    LDA.b #$00 : BRA .set_direction
    
    .not_pressing_up
    
    LDA.b $00 : AND.b #$04 : BEQ .not_pressing_down
    
    LDA.b #$01 : BRA .set_direction
    
    .not_pressing_down
    
    LDA.b $00 : AND.b #$02 : BEQ .not_pressing_left
    
    LDA.b #$02 : BRA .set_direction
    
    .not_pressing_left
    
    LDA.b #$03
    
    .set_direction
    
    STA.w $0DE0, X
    
    STZ.w $0D80, X
    
    .not_pressing_any_directions
    
    ; $0F7B34 ALTERNATE ENTRY POINT
    
    LDA.b #$01 : STA.w $02F5
    
    RTS
}

; $0F7B3A-$0F7B48 JUMP LOCATION
{
    STZ.w $0D80, X
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    STZ.b $4B
    
    BRA .BRANCH_$F7B34
}

; $0F7B49-$0F7B77 LOCAL JUMP LOCATION
{
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.w #$0008 : CMP $22 : BEQ .BRANCH_ALPHA
                                         BPL .BRANCH_BETA
    
    DEC.w $0B7C
    
    BRA .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    INC.w $0B7C
    
    .BRANCH_ALPHA
    
    LDA.w $0FDA : SEC : SBC.w #$0010 : CMP $20 : BEQ .BRANCH_GAMMA
                                         BPL .BRANCH_DELTA
    
    DEC.w $0B7E
    
    BRA .BRANCH_GAMMA
    
    .BRANCH_DELTA
    
    INC.w $0B7E
    
    .BRANCH_GAMMA
    
    SEP #$30
    
    RTS
}

; ==============================================================================

    ; UNUSED:
; $0F7B78-$0F7B7D DATA
Pool_Unused:
{
    ; NOTE: Perhaps these wwere speeds to be used for the player moving
    ; through the pipes?
    db $00, $00, $01, $FF, $00, $00
}

; ==============================================================================

    ; NOTE: The Pipe sprite doesn't use $0D80, X

; $0F7B7E-$0F7B93 JUMP LOCATION
Sprite_Pipe:
{
    JSR Sprite3_CheckIfActive
    
    LDA.w $0DC0, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Pipe_LocateTransitTile
    dw Pipe_LocateTransitEndpoint
    dw Pipe_WaitForPlayer
    dw Pipe_DrawPlayerInward
    dw Pipe_DragPlayerAlong
    dw $FCD3 ; = $F7CD3*
}

; ==============================================================================

; $0F7B94-$0F7BBD JUMP LOCATION
Pipe_LocateTransitEndpoint:
{
    ; $0F77C2 IN ROM ; Get tile attribute at sprite's current location.
    ; I'm thinking this is the starting tile for the pipe? Or perhaps
    ; represents an endpoint...
    JSR.w $F7C2 : CMP.b #$BE : BNE .not_the_tile_youre_looking_for
    
    STA.w $0E90, X
    
    INC.w $0DC0, X
    
    ; switch direction polarity... I guess so the player can go through it?
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0DE0, X
    
    .not_the_tile_youre_looking_for
    
    CMP.w $0E90, X : BEQ .beta
    
    STA.w $0E90, X
    
    .beta
    
    LDA.w $0DE0, X : STA.w $0EB0, X
    
    JSR.w $F7AF ; $0F77AF IN ROM
    JSR Sprite3_Move
    
    RTS
}

; ==============================================================================

; $0F7BBE-$0F7BEF JUMP LOCATION
Pipe_WaitForPlayer:
{
    ; NOTE: The sprite travels along with you (or ahead of you?).
    ; Entering the same pipe twice without taking the return trip results
    ; in a nonfunctional pipe that just behaves as normal empty space.
    ; This was confirmed directly by modifying the player's coordinates in
    ; a memory editor. Clearly this design limitation dictated the layout
    ; of the rooms the pipes appear in.
    LDA.w $1DE0 : CMP.b #$FF : BNE .cant_enter
    
    JSL Sprite_CheckDamageToPlayerIgnoreLayerLong : BCC .cant_enter
    
    PHX
    
    JSL Player_IsPipeEnterable
    
    PLX
    
    BCS .cant_pass_through
    
    INC.w $0DC0, X
    
    LDA.b #$04 : STA.w $0E00, X
    
    JSL Player_ResetState
    
    LDA.b #$01 : STA.w $02E4 : STA.w $037B
    
    TXA : STA.w $1DE0
    
    .cant_enter
    
    RTS
    
    .cant_pass_through
    
    JSR.w $F508 ; $0F7508 IN ROM
    
    RTS
}

; ==============================================================================

; $0F7BF0-$0F7BF3 DATA
Pool_Pipe:
{
    .player_direction
    db $08, $04, $02, $01
}

; ==============================================================================

; $0F7BF4-$0F7C12 JUMP LOCATION
Pipe_DrawPlayerInward:
{
    LDA.w $0E00, X : BNE .delay
    
    INC.w $0DC0, X
    
    ; Makes the player invisible.
    LDA.b #$0C : STA.b $4B
    
    RTS
    
    .delay
    
    ; Halt the player, but also take care of some of their functions?
    LDA.b #$01 : STA.w $02E4 : STA.w $037B
    
    LDY.w $0DE0, X
    
    LDA Pipe.player_direction, Y
    
    JSR.w $FCFF ; $0F7CFF IN ROM
    
    RTS
}

; ==============================================================================

; $0F7C13-$0F7CD2 JUMP LOCATION
Pipe_DragPlayerAlong:
{
    LDA.b #$03 : STA.w $0E80, X
    
    LDA.b $22 : STA.b $3F
    LDA.b $23 : STA.b $41
    
    LDA.b $20 : STA.b $3E
    LDA.b $21 : STA.b $40
    
    .lambda
    
    INC.w $0D90, X
    
    LDA.w $0D90, X : AND.b #$07 : BNE .BRANCH_ALPHA
    
    JSR.w $F7C2 ; $0F77C2 IN ROM
    
    PHA : CMP.b #$B2 : BCC .BRANCH_BETA
          CMP.b #$B6 : BCS .BRANCH_BETA
    
    LDA.b #$0B : JSL Sound_SetSfx2PanLong
    
    .BRANCH_BETA
    
    PLA : CMP.w $0E90, X : BEQ .BRANCH_ALPHA
    
    STA.w $0E90, X : CMP.b #$BE : BNE .not_endpoint_node
    
    INC.w $0DC0, X
    
    LDA.b #$18 : STA.w $0E00, X
    
    .not_endpoint_node
    
    LDA.w $0DE0, X : STA.w $0EB0, X
    
    JSR.w $F7AF ; $0F77AF IN ROM
    JSR.w $F901 ; $0F7901 IN ROM
    
    .BRANCH_ALPHA
    
    JSR Sprite3_Move
    
    LDA.w $0D10, X : SEC : SBC.b #$08 : STA.b $00
    LDA.w $0D30, X : SBC.b #$00 : STA.b $01
    
    LDA.w $0D00, X : SEC : SBC.b #$0E : STA.b $02
    LDA.w $0D20, X : SBC.b #$00 : STA.b $03
    
    REP #$20
    
    LDA.b $00 : CMP $22 : BEQ .BRANCH_DELTA  BCS .BRANCH_EPSILON
    
    DEC.b $22
    
    BRA .BRANCH_DELTA
    
    .BRANCH_EPSILON
    
    INC.b $22
    
    .BRANCH_DELTA
    
    LDA.b $02 : CMP $20 : BEQ .BRANCH_ZETA  BCS .BRANCH_THETA
    
    DEC.b $20
    
    BRA .BRANCH_ZETA
    
    .BRANCH_THETA
    
    INC.b $20
    
    .BRANCH_ZETA
    
    SEP #$30
    
    DEC.w $0E80, X : BEQ .BRANCH_IOTA
    
    JMP .lambda
    
    .BRANCH_IOTA
    
    LDA.b $22 : SEC : SBC.b $3F : STA.b $31
    LDA.b $20 : SEC : SBC.b $3E : STA.b $30

    LDY.w $0DE0, X
    
    LDA Pipe.player_direction, Y : STA.b $26
    
    PHX
    
    JSL.l $07E6A6 ; $03E6A6 IN ROM
    JSL.l $07F42F ; $03F42F IN ROM
    JSL Player_HaltDashAttackLong
    
    PLX
    
    RTS
}

; $0F7CD3-$0F7CFE JUMP LOCATION
{
    LDA.w $0E00, X : BNE .delay
    
    STZ.w $02E4
    STZ.w $02F5
    STZ.w $037B
    STZ.b $4B
    STZ.b $31
    STZ.b $30
    
    LDA.b #$FF : STA.w $1DE0
    
    LDA.b #$02 : STA.w $0DC0, X
    
    RTS
    
    .delay
    
    LDA.w $0DE0, X : EOR.b #$01 : TAY
    
    LDA Pipe.player_direction, Y
    
    JSR.w $FCFF ; $0F7CFF IN ROM
    
    RTS
}

; $0F7CFF-$0F7D11 LOCAL JUMP LOCATION
{
    ; Induces player movement, I do believe (in spite of the fact that
    ; we made the player invisible and 'froze' them. So... this sprite
    ; is acting as a surrogate of the player sprite, so to speak.
    PHX
    
    STA.b $67 : STA.b $26
    
    JSL.l $07E245 ; $03E245 IN ROM
    JSL.l $07E6A6 ; $03E6A6 IN ROM
    JSL.l $07F42F ; $03F42F IN ROM
    
    PLX
    
    RTS
}

; ==============================================================================
