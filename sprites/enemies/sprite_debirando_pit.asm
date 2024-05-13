
; ==============================================================================

; $02852D-$028530 DATA
Pool_Sprite_DebirandoPit:
{
    .unknown_1
    db -1, 1
    
    .unknown_2
    db -1, 0
}

; ==============================================================================

; $028531-$0285DD JUMP LOCATION
Sprite_DebirandoPit:
{
    ; Sand lion pit code
    
    JSR Sprite2_DirectionToFacePlayer
    
    LDA $0E : CLC : ADC.b #$20 : CMP.b #$40 : BCS .ignore_player
    
    LDA $0F : CLC : ADC.b #$20 : CMP.b #$40 : BCS .ignore_player
    
    LDA.b #$10 : JSL OAM_AllocateFromRegionB
    
    .ignore_player
    
    JSR DebirandoPit_Draw
    JSR Sprite2_CheckIfActive
    
    LDY $0EB0, X
    
    LDA $0DD0, Y : CMP.b #$06 : BNE .cosprite_not_dying
    
    STA $0DD0, X
    
    LDA $0DF0, Y : STA $0DF0, X
    
    LDA $0E40, X : CLC : ADC.b #$04 : STA $0E40, X
    
    RTS
    
    .cosprite_not_dying
    
    LDA $0DC0, X : CMP.b #$03 : BCS .not_open
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_contact
    
    JSL Player_HaltDashAttackLong
    
    ; \tcrf (verified)
    ; Cheat code is a tentative name, though probably a well qualified one
    ; as well. This stanza would seem to indicate that tapping the R button
    ; can help you escape from the pits.
    LDA $F6 : AND.b #$10 : BNE .cheat_code
    
    ; Without tapping that, you're stuck. 
    LDA.b #$01 : STA $0B7B
    
    .cheat_code
    
    LDA.b #$10
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    LDY.b #$00
    
    LDA $00 : BPL .epsilon
    
    EOR.b #$FF : INC A
    
    INY
    
    .epsilon
    
    CLC : ADC $0D90, X : STA $0D90, X : BCC .zeta
    
    LDA.w $852D, Y : STA $0B7E
    LDA.w $852F, Y : STA $0B7F
    
    .zeta
    
    LDY.b #$00
    
    LDA $01 : BPL .theta
    
    EOR.b #$FF : INC A
    
    INY
    
    .theta
    
    CLC : ADC $0DA0, X : STA $0DA0, X : BCC .gamma
    
    LDA.w $852D, Y : STA $0B7C
    LDA.w $852F, Y : STA $0B7D
    
    .gamma
    .no_player_contact
    .not_open
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw DebirandoPit_Closed
    dw DebirandoPit_Opening
    dw DebirandoPit_Open
    dw DebirandoPit_Closing
}

; ==============================================================================

; $0285DE-$0285F0 JUMP LOCATION
DebirandoPit_Closed:
{
    LDA.b #$06 : STA $0DC0, X
    
    LDA $0DF0, X : BNE .delay
    
    INC $0D80, X
    
    LDA.b #$3F : STA $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0285F1-$0285F4 DATA
Pool_DebirandoPit_Opening:
{
    .animation_states
    db 5, 4, 3, 3
}

; ==============================================================================

; $0285F5-$02860E JUMP LOCATION
DebirandoPit_Opening:
{
    LDA $0DF0, X : BNE .delay_ai_state_transition
    
    INC $0D80, X
    
    LDA.b #$FF : STA $0DF0, X
    
    RTS
    
    .delay_ai_state_transition
    
    LSR #4 : TAY
    
    LDA .animation_states, Y : STA $0DC0, X
    
    RTS
}

; ==============================================================================

; $02860F-$02862F JUMP LOCATION
DebirandoPit_Open:
{
    LDA $1A : AND.b #$0F : BNE .skip_frame
    
    INC $0DC0, X : LDA $0DC0, X : CMP.b #$03 : BCC .no_modulus
    
    STZ $0DC0, X
    
    .no_modulus
    .skip_frame
    
    LDA $0DF0, X : BNE .delay
    
    LDA.b #$3F : STA $0DF0, X
    
    INC $0D80, X
    
    .delay
    
    RTS
} 

; ==============================================================================

; $028630-$028633 DATA
Pool_DebirandoPit_Closing:
{
    .animation_states
    db 3, 3, 4, 5
}

; ==============================================================================

; $028634-$02864D JUMP LOCATION
DebirandoPit_Closing:
{
    LDA $0DF0, X : BNE .delay
    
    STZ $0D80, X
    
    LDA.b #$20 : STA $0DF0, X
    
    RTS
    
    .delay
    
    LSR #4 : TAY
    
    LDA .animation_states, Y : STA $0DC0, X
    
    RTS
}

; ==============================================================================

; $02864E-$0286E3 DATA
Pool_DebirandoPit_Draw:
{
    .x_offsets
    dw -8,  8, -8,  8, -8,  8, -8,  8
    dw -8,  8, -8,  8,  0,  8,  0,  8
    dw  0,  8,  0,  8, -8,  8, -8,  8
    
    .y_offsets
    dw -8, -8,  8,  8, -8, -8,  8,  8
    dw -8, -8,  8,  8,  0,  0,  8,  8
    dw  0,  0,  8,  8, -8, -8,  8,  8
    
    .chr
    db $04, $04, $04, $04, $22, $22, $22, $22
    db $02, $02, $02, $02, $29, $29, $29, $29
    db $39, $39, $39, $39, $2A, $2A, $2A, $2A
    
    .vh_flip
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    db $00, $40, $80, $C0, $00, $40, $80, $C0
    
    .oam_sizes
    db $02, $02, $02, $00, $00, $02
}

; ==============================================================================

; $0286E4-$02874C LOCAL JUMP LOCATION
DebirandoPit_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    ; The pit is not at all open right now, so don't draw it.
    LDA $0DC0, X : CMP.b #$06 : BEQ .return
    
    PHX
    
    TAX
    
    LDA .oam_sizes, X : STA $0D
    
    TXA : ASL #2 : STA $06
    
    LDX.b #$03
    
    .next_subsprite
    
    PHX
    
    TXA : CLC : ADC $06 : PHA
    
    ASL A : TAX
    
    REP #$20
    
    LDA $00 : CLC : ADC .x_offsets, X : STA ($90), Y
    
    AND.w #$0100 : STA $0E
    
    LDA $02 : CLC : ADC .y_offsets, X : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    
    LDA.b #$F0 : STA ($90), Y
    
    .on_screen_y
    
    PLX
    
    LDA .chr, X               : INY : STA ($90), Y
    LDA .vh_flip, X : ORA $05 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA $0D : ORA $0F : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    .return
    
    RTS
}
    
; ==============================================================================
