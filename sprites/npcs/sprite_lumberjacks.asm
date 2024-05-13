
; ==============================================================================

; $06C50B-$06C512 LONG JUMP LOCATION
Sprite_LumberjacksLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_Lumberjacks
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C513-$06C51A DATA
Pool_Sprite_Lumberjacks:
{
    .messages_low
    db $2C, $2D, $2E, $2D
    
    .messages_high
    db $01, $01, $01, $01
}

; ==============================================================================

; $06C51B-$06C57E LOCAL JUMP LOCATION
Sprite_Lumberjacks:
{
    JSR LumberJacks_Draw
    JSR Sprite5_CheckIfActive
    
    ; check inner hit detection box
    LDY.b #$00
    
    JSR Lumberjacks_CheckProximity : BCS .check_outer_region
    
    PHX
    
    JSL Sprite_NullifyHookshotDrag
    
    STZ $5E
    
    JSL Player_HaltDashAttackLong
    
    PLX
    
    .check_outer_region
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .dont_speak
    
    ; Check outer hit detection box
    LDY.b #$02
    
    JSR Lumberjacks_CheckProximity : BCS .dont_speak
    
    LDA $F6 : AND.b #$80 : BEQ .dont_speak
    
    LDA $22 : CMP $0D10, X : ROL A : AND.b #$01 : STA $00 : STZ $01
    
    LDA $7EF359 : CMP.b #$02 : BCC .player_doesnt_have_master_sword
    
    LDA.b #$02 : STA $01
    
    .player_doesnt_have_master_sword
    
    LDA $01 : CLC : ADC $00 : TAY
    
    LDA .messages_low, Y        : XBA
    LDA .messages_high, Y : TAY : XBA
    
    JSL Sprite_ShowMessageUnconditional
    
    .dont_speak
    
    LDA $1A : LSR #5 : AND.b #$01 : STA $0DC0, X
    
    RTS
}

; ==============================================================================

; $06C57F-$06C58E DATA
Pool_Lumberjacks_CheckProximity:
{
    .x_lower_ranges
    dw 48, 52
    
    .y_lower_ranges
    dw 19, 20
    
    .x_upper_ranges
    dw 98, 106
    
    .y_upper_ranges
    dw 37, 40
}

; ==============================================================================

; $06C58F-$06C5B1 LOCAL JUMP LOCATION
Lumberjacks_CheckProximity:
{
    REP #$20
    
    LDA $0FD8 : SEC : SBC $22
    
    CLC : ADC .x_lower_ranges, Y : CMP .x_upper_ranges, Y : BCS .not_close_enough
    
    LDA $0FDA : SEC : SBC $20
    
    CLC : ADC .y_lower_ranges, Y : CMP .y_upper_ranges, Y : BCS .not_close_enough
    
    .not_close_enough
    
    ; \note one of the above is a zero length branch precisely because the 
    ; comparison operation wholly determines the "return value" of this
    ; routine, which is the status of the carry flag.
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06C5B2-$06C6B9 DATA
Pool_Lumberjacks_Draw:
{
    .oam_groups
    dw -23,  5 : db $BE, $02, $00, $00
    dw -15,  5 : db $BF, $02, $00, $00
    dw  -7,  5 : db $BF, $02, $00, $00
    dw   1,  5 : db $BF, $02, $00, $00
    dw   9,  5 : db $BF, $02, $00, $00
    dw  17,  5 : db $BF, $02, $00, $00
    dw  25,  5 : db $BE, $42, $00, $00
    dw -32, -8 : db $A8, $40, $00, $02
    dw -32,  4 : db $A6, $40, $00, $02
    dw  30, -8 : db $A8, $00, $00, $02
    dw  31,  4 : db $A4, $00, $00, $02
    
    dw -19,  5 : db $BE, $02, $00, $00
    dw -11,  5 : db $BF, $02, $00, $00
    dw  -3,  5 : db $BF, $02, $00, $00
    dw   5,  5 : db $BF, $02, $00, $00
    dw  13,  5 : db $BF, $02, $00, $00
    dw  21,  5 : db $BF, $02, $00, $00
    dw  29,  5 : db $BE, $42, $00, $00
    dw -31, -8 : db $A8, $40, $00, $02
    dw -32,  4 : db $A4, $40, $00, $02
    dw  31, -8 : db $A8, $00, $00, $02
    dw  31,  4 : db $A6, $00, $00, $02
    
    dw -19,  5 : db $BE, $02, $00, $00
    dw -11,  5 : db $BF, $02, $00, $00
    dw  -3,  5 : db $BF, $02, $00, $00
    dw   5,  5 : db $BF, $02, $00, $00
    dw  13,  5 : db $BF, $02, $00, $00
    dw  21,  5 : db $BF, $02, $00, $00
    dw  29,  5 : db $BE, $42, $00, $00
    dw -32, -8 : db $0E, $40, $00, $02
    dw -32,  4 : db $A4, $40, $00, $02
    dw  32, -8 : db $0E, $00, $00, $02
    dw  31,  4 : db $A6, $00, $00, $02
}

; ==============================================================================

; $06C6BA-$06C6DD LOCAL JUMP LOCATION
Lumberjacks_Draw:
{
    LDA.b #$0B : STA $06
                 STZ $07
    
    LDA $0DC0, X : ASL #2 : ADC $0DC0, X : ASL A : ADC $0DC0, X : ASL #3
    
    ADC.b #(.oam_groups >> 0)              : STA $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA $09
    
    JSL Sprite_DrawMultiple.quantity_preset
    
    RTS
}
