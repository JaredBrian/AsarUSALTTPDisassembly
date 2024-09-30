; ==============================================================================

; $0EF063-$0EF06A LONG JUMP LOCATION
Sprite_EvilBarrierLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_EvilBarrier
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EF06B-$0EF0E0 LOCAL JUMP LOCATION
Sprite_EvilBarrier:
{
    JSR.w EvilBarrier_Draw
    
    LDA.w $0DC0, X : CMP.b #$04 : BEQ .zap_attempt_inhibit
        LDA.b $1A : LSR A : AND.b #$03 : STA.w $0DC0, X
        
        JSR.w Sprite4_CheckIfActive
        
        JSL.l Sprite_CheckDamageFromPlayerLong : BCC .anozap_from_player_attack
            ; Got master sword?
            LDA.l $7EF359 : CMP.b #$02 : BCS .anozap_from_player_attack
                ; No? You're gettin electrocuted.
                STZ.w $0EF0, X
                
                JSL.l Sprite_AttemptDamageToPlayerPlusRecoilLong
                
                LDA.w $031F : BNE .anozap_from_player_attack
                    LDA.b #$40 : STA.w $0360
            
        .anozap_from_player_attack
        
        REP #$20
        
        LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0008
        CMP.w #$0018 : BCS .anozap_from_player_contact
        
            LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0020
            CMP.w #$0040 : BCS .anozap_from_player_contact
                SEP #$20
                
                LDA.b $27 : DEC A : BPL .anozap_from_player_contact
                    LDA.b #$40 : STA.w $0360
                    
                    LDA.b #$0C : STA.b $46
                    
                    LDA.b #$01 : STA.b $4D
                    
                    LDA.b #$02 : STA.w $0373
                    
                    STZ.b $28
                    
                    LDA.b #$30 : STA.b $27
        
        .anozap_from_player_contact
    .zap_attempt_inhibit
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EF0E1-$0EF248 DATA
Pool_EvilBarrier_Draw_oam_groups:
{
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

; $0EF249-$0EF276 LOCAL JUMP LOCATION
EvilBarrier_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00
    
    ASL #3 : CLC : ADC.b $00 : ADC.w #.oam_groups : STA.b $08
    
    LDA.w $0FDA : CLC : ADC.w #$0008 : STA.w $0FDA
    
    SEP #$20
    
    LDA.b #$09 : JSR.w Sprite4_DrawMultiple
    
    JSL.l Sprite_Get_16_bit_CoordsLong
    
    RTS
}

; ==============================================================================
