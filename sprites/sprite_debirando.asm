
; ==============================================================================

; $02874D-$028761 JUMP LOCATION
Sprite_Debirando:
{
    JSR Debirando_Draw
    JSR Sprite2_CheckIfActive
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Debirando_UnderSand
    dw Debirando_Emerge
    dw Debirando_ShootFireball
    dw Debirando_Submerge
}

; ==============================================================================

; $028762-$028772 JUMP LOCATION
Debirando_UnderSand:
{
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .wait
    
    INC.w $0D80, X
    
    LDA.b #$1F : STA.w $0DF0, X
    
    .wait
    
    RTS
}

; ==============================================================================

; $028773-$028774 DATA
Pool_Debirando_Emerge:
{
    .animation_states
    db $01, $00
}

; ==============================================================================

; $028775-$028791 JUMP LOCATION
Debirando_Emerge:
{
    JSR Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$80 : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    LSR #4 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $028792-$0287C7 JUMP LOCATION
Debirando_ShootFireball:
{
    JSR Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$1F : STA.w $0DF0, X
    
    INC.w $0D80, X
    
    RTS
    
    .delay
    
    ; Blue debirando have $0ED0 set nonzero, so they can't shoot fireballs.
    AND.b #$1F
    ORA.w $0ED0, X
    ORA.b $11
    ORA.w $0F00, X
    ORA.w $0FC1
    
    BNE .dont_shoot_fireball
    
    JSL Sprite_SpawnFireball
    
    .dont_shoot_fireball
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : LSR #3 : AND.b #$01 : CLC : ADC.b #$02 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0287C8-$0287C9 DATA
Pool_Debirando_Submerge:
{
    .animation_states
    db $00, $01
}

; ==============================================================================

; $0287CA-$0287E6 JUMP LOCATION
Debirando_Submerge:
{
    JSR Sprite2_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    STZ.w $0D80, X
    
    LDA.b #$DF : STA.w $0DF0, X
    
    RTS
    
    .delay
    
    LSR #4 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0287E7-$028856 DATA
Pool_Debirando_Draw:
{
    .x_offsets
    dw $0000, $0008, $0000, $0008, $0000, $0000, $0000, $0008
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    
    .y_offsets
    dw $0002, $0002, $0006, $0006, $FFFE, $FFFE, $0006, $0006
    dw $FFFC, $FFFC, $FFFC, $FFFC, $FFFC, $FFFC, $FFFC, $FFFC
    
    .chr
    db $00, $00, $D8, $D8, $00, $00, $D9, $D9
    db $00, $00, $00, $00, $20, $20, $20, $20
    
    .properties
    db $01, $41, $00, $40, $01, $01, $00, $40
    db $01, $01, $01, $01, $01, $01, $01, $01
    
    .size
    db $00, $00, $00, $00, $02, $02, $00, $00
    db $02, $02, $02, $02, $02, $02, $02, $02
}

; ==============================================================================

; $028857-$0288C4 LOCAL JUMP LOCATION
Debirando_Draw:
{
    ; Don't draw if the sprite's hidden.
    LDA.w $0D80, X : BEQ .return
    
    JSR Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL #2 : STA.b $06
    
    PHX
    
    LDX.b #$03
    
    .next_subsprite
    
    PHX : TXA : CLC : ADC.b $06 : PHA : ASL A : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC .x_offsets, X  : STA ($90), Y : AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX
    
    LDA .chr, X : INY : STA ($90), Y
    
    LDA .properties, X : PHA : AND.b #$0F : CMP.b #$01
                         PLA : EOR.b $05    : BCS .dont_override_palette
    
    AND.b #$F0
    
    .dont_override_palette
    
    INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.w $8847, X : ORA.b $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    .return
    
    RTS
}

; ==============================================================================

