
; ==============================================================================

; $0EF063-$0EF06A LONG JUMP LOCATION
Sprite_EvilBarrierLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_EvilBarrier
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF06B-$0EF0E0 LOCAL JUMP LOCATION
Sprite_EvilBarrier:
{
    JSR EvilBarrier_Draw
    
    LDA $0DC0, X : CMP.b #$04 : BEQ .zap_attempt_inhibit
    
    LDA $1A : LSR A : AND.b #$03 : STA $0DC0, X
    
    JSR Sprite4_CheckIfActive
    
    JSL Sprite_CheckDamageFromPlayerLong : BCC .anozap_from_player_attack
    
    ; got master sword?
    LDA $7EF359 : CMP.b #$02 : BCS .anozap_from_player_attack
    
    ; no? yo' ass be gettin electrocuted, son
    STZ $0EF0, X
    
    JSL Sprite_AttemptDamageToPlayerPlusRecoilLong
    
    LDA $031F : BNE .anozap_from_player_attack
    
    LDA.b #$40 : STA $0360
    
    .anozap_from_player_attack
    
    REP #$20
    
    LDA $20 : SEC : SBC $0FDA : CLC : ADC.w #$0008
    
    CMP.w #$0018 : BCS .anozap_from_player_contact
    
    LDA $22 : SEC : SBC $0FD8 : CLC : ADC.w #$0020
    
    CMP.w #$0040 : BCS .anozap_from_player_contact
    
    SEP #$20
    
    LDA $27 : DEC A : BPL .anozap_from_player_contact
    
    LDA.b #$40 : STA $0360
    
    LDA.b #$0C : STA $46
    
    LDA.b #$01 : STA $4D
    
    LDA.b #$02 : STA $0373
    
    STZ $28
    
    LDA.b #$30 : STA $27
    
    .anozap_from_player_contact
    .zap_attempt_inhibit
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EF0E1-$0EF248 DATA
pool EvilBarrier_Draw:
{
    .oam_groups
    dw   0,  0 : db $E8, $00, $00, $02
    dw -29,  3 : db $CA, $00, $00, $00
    dw -29, 11 : db $DA, $00, $00, $00
    dw  37,  3 : db $CA, $40, $00, $00
    dw  37, 11 : db $DA, $40, $00, $00
    dw -24, -2 : db $E6, $00, $00, $02
    dw  -8, -2 : db $E6, $00, $00, $02
    dw   8, -2 : db $E6, $40, $00, $02
    dw  24, -2 : db $E6, $40, $00, $02
    
    dw   0,  0 : db $CC, $00, $00, $02
    dw -29,  3 : db $CB, $00, $00, $00
    dw -29, 11 : db $DB, $00, $00, $00
    dw  37,  3 : db $CB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw   0,  0 : db $CC, $00, $00, $02
    dw   0,  0 : db $CC, $00, $00, $02
    dw   0,  0 : db $CC, $00, $00, $02
    dw   0,  0 : db $CC, $00, $00, $02
    
    dw   0,  0 : db $CC, $00, $00, $02
    dw -29,  3 : db $CB, $00, $00, $00
    dw -29, 11 : db $DB, $00, $00, $00
    dw  37,  3 : db $CB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw -24, -2 : db $E6, $80, $00, $02
    dw  -8, -2 : db $E6, $80, $00, $02
    dw   8, -2 : db $E6, $C0, $00, $02
    dw  24, -2 : db $E6, $C0, $00, $02
    
    dw   0,  0 : db $E8, $00, $00, $02
    dw -29,  3 : db $CA, $00, $00, $00
    dw -29, 11 : db $DA, $00, $00, $00
    dw  37,  3 : db $CA, $40, $00, $00
    dw  37, 11 : db $DA, $40, $00, $00
    dw   0,  0 : db $E8, $00, $00, $02
    dw   0,  0 : db $E8, $00, $00, $02
    dw   0,  0 : db $E8, $00, $00, $02
    dw   0,  0 : db $E8, $00, $00, $02
    
    dw -29,  3 : db $CB, $00, $00, $00
    dw -29, 11 : db $DB, $00, $00, $00
    dw  37,  3 : db $CB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00
    dw  37, 11 : db $DB, $40, $00, $00     
}

; ==============================================================================

; $0EF249-$0EF276 LOCAL JUMP LOCATION
EvilBarrier_Draw:
{
    LDA.b #$00   : XBA
    LDA $0DC0, X : REP #$20 : ASL #3 : STA $00
    
    ASL #3 : CLC : ADC $00 : ADC.w #.oam_groups : STA $08
    
    LDA $0FDA : CLC : ADC.w #$0008 : STA $0FDA
    
    SEP #$20
    
    LDA.b #$09 : JSR Sprite4_DrawMultiple
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    RTS
}

; ==============================================================================
