
; ==============================================================================

; $0EEDD6-$0EEDDD LONG JUMP LOCATION
Sprite_HelmasaurFireballLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_HelmasaurFireball
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EEDDE-$0EEDE2 DATA
Pool_Sprite_HelmasaurFireball:
{
    .chr
    db $CC, $CC, $CA
    
    .properties
    db $33, $73
}

; ==============================================================================

; $0EEDE3-$0EEE9B LOCAL JUMP LOCATION
Sprite_HelmasaurFireball:
{
    INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #2 : AND.b #$01 : TAY
    
    LDA.w .properties, Y : STA.b $05
    
    LDY.b #$00
    
    LDA.w $0D10, X : SEC : SBC.b $E2 : STA ($90), Y
    
    ; NOTE: These two branches check if the fireball is with in 32 pixels
    ; of the edge of the screen horizontally, and 16 pixels of the top of
    ; the screen. Because the screen is only 224 pixels tall in Zelda 3
    ; (though the snes can be configured for 240 called overscan mode), this
    ; has no impact on fireballs traveling towards the bottom edge of the
    ; screen.
    CLC : ADC.b #$20 : CMP.b #$40 : BCC .too_close_to_screen_edge
    
    LDA.w $0D00, X : SEC : SBC.b $E8 : INY : STA ($90), Y
    
    CLC : ADC.b #$10 : CMP.b #$20 : BCS .in_range
    
    .too_close_to_screen_edge
    
    STZ.w $0DD0, X
    
    RTS
    
    .in_range
    
    PHX
    
    LDA.w $0DC0, X : TAX
    
    LDA.w .chr, X
    
    PLX
              INY : STA ($90), Y
    LDA.b $05 : INY : STA ($90), Y
    
    LDA.b #$02 : STA ($92)
    
    JSR.w Sprite4_CheckIfActive
    
    TXA : EOR.b $1A : AND.b #$03 : BNE .anodamage_player
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8
              CLC : ADC.w #$0008 : CMP.w #$0010 : BCS .anodamage_player
    
    LDA.b $20 : SEC : SBC.w $0FDA
              CLC : ADC.w #$0010 : CMP.w #$0010 : BCS .anodamage_player
    
    SEP #$20
    
    JSL.l Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    .anodamage_player
    
    SEP #$20
    
    LDA.w $0D80, X
    
    ; OPTIMIZE: Zero distance jump instruction. is a dumb. Just remove it.
    ; In fact, this whole section might be faster overall as a jump table.
    ; NOTE: The ordering of this decision tree is as follows: 4, 1, 2, 3, 0
    ; These are the values of $0D80 that are being checked successively.
    ; Note that if the value were goreater than 4 it would resolve down to
    ; the final jump. This odd ordering in and of itself is blech.
    CMP.b #$04 : BEQ HelamsaurFireball_Move
    DEC A      : BEQ HelmasaurFireball_MigrateDown
    DEC A      : BEQ HelmasaurFireball_DelayThenTriSplit
    DEC A      : BEQ HelmasaurFireball_DelayThenQuadSplit
    
    JMP HelmasaurFireball_PreMigrateDown
}
    
; ==============================================================================

; $0EEE72-$0EEE84 JUMP LOCATION
HelmasaurFireball_PreMigrateDown:
{
    LDA !timer_0, X : BNE .delay_ai_state_transition
    
    LDA.b #$12 : STA !timer_0, X
    
    INC.w $0D80, X
    
    LDA.b #$24 : STA.w $0D40, X
    
    .delay_ai_state_transition
    
    RTS
}
    
; ==============================================================================

; $0EEE85-$0EEE9B BRANCH LOCATION
HelmasaurFireball_MigrateDown:
{
    LDA !timer_0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$1F : STA !timer_0, X
    
    .delay
    
    ; Slow down a bit each frame.
    DEC.w $0D40, X : DEC.w $0D40, X
    
    JSR.w Sprite4_MoveVert
    
    RTS
}

; ==============================================================================

; $0EEE9C-$0EEE9F DATA
HelmasaurFireball_DelayThenTriSplit:
{
    .animation_states
    db 2, 2, 1, 0
}

; ==============================================================================

; $0EEEA0-$0EEEB2 BRANCH LOCATION
HelmasaurFireball_DelayThenTriSplit:
{
    LDA !timer_0, X : BNE .delay
    
    JMP HelmasaurFireball_TriSplit
    
    .delay
    
    LSR #3 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EEEB3-$0EEEC8 BRANCH LOCATION
HelmasaurFireball_DelayThenQuadSplit:
{
    LDA !timer_0, X : BNE .delay
    
    JMP HelmasaurFireball_QuadSplit
    
    .delay
    
    LDA.w $0EB0, X : CMP.b #$14 : BCS .delay_movement
    
    INC.w $0EB0, X
    
    JSR.w Sprite4_Move
    
    .delay_movement
    
    RTS
}

; ==============================================================================

; $0EEEC9-$0EEECC BRANCH LOCATION
HelamsaurFireball_Move:
{
    ; Just moves until it hits the edge of the screen. (See notes at the
    ; root procedure).
    JSR.w Sprite4_Move
    
    RTS
}

; ==============================================================================

; $0EEECD-$0EEED2 DATA
Pool_HelmasaurFireball_TriSplit:
{
    .x_speeds
    db   0,  28, -28
    
    .y_speeds
    db -32,  24,  24
}

; ==============================================================================

; $0EEED3-$0EEF34 LOCAL JUMP LOCATION
HelmasaurFireball_TriSplit:
{
    LDA.b #$36 : JSL.l Sound_SetSfx3PanLong
    
    STZ.w $0DD0, X
    
    LDA.b #$02       : STA.w $0FB5
    JSL.l GetRandomInt : STA.w $0FB6
    
    .spawn_next
    
    LDA.b #$70
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    PHX
    
    LDX.w $0FB5
    
    LDA.w .x_speeds, X : STA.w $0D50, Y
    
    LDA.w .y_speeds, X : STA.w $0D40, Y
    
    LDA.b #$03 : STA.w $0D80, Y
                 STA.w $0BA0, Y
    
    LDA.w $0FB6 : AND.b #$03 : CLC : ADC.w $0FB5 : TAX
    
    LDA.w .timers, X : STA !timer_0, Y
    
    LDA.b #$00 : STA.w $0EB0, Y
    
    LDA.b #$01 : STA.w $0DC0, Y
    
    PLX
    
    .spawn_failed
    
    DEC.w $0FB5 : BPL .spawn_next
    
    RTS
    
    .timers
    db  32,  80, 128,  32,  80, 128,  32,  80
}

; ==============================================================================

; $0EEF35-$0EEF3C DATA
HelmasaurFireball_QuadSplit:
{
    .x_speeds
    db  32,  32, -32, -32
    
    .y_speeds
    db -32,  32, -32,  32
}

; ==============================================================================

; $0EEF3D-$0EEF75 LOCAL JUMP LOCATION
HelmasaurFireball_QuadSplit:
{
    LDA.b #$36 : JSL.l Sound_SetSfx3PanLong
    
    STZ.w $0DD0, X
    
    LDA.b #$03 : STA.w $0FB5
    
    .spawn_next
    
    LDA.b #$70
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL.l Sprite_SetSpawnedCoords
    
    PHX
    
    LDX.w $0FB5
    
    LDA.w .x_speeds, X : STA.w $0D50, Y
    
    LDA.w .y_speeds, X : STA.w $0D40, Y
    
    PLX
    
    LDA.b #$04 : STA.w $0D80, Y
                 STA.w $0BA0, Y
    
    .spawn_failed
    
    DEC.w $0FB5 : BPL .spawn_next
    
    RTS
}

; ==============================================================================
