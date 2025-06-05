; ==============================================================================

; $06C50B-$06C512 LONG JUMP LOCATION
Sprite_LumberjacksLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_Lumberjacks
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C513-$06C51A DATA
Pool_Sprite_Lumberjacks:
{
    ; $06C513
    .messages_low
    db $2C, $2D, $2E, $2D
    
    ; $06C517
    .messages_high
    db $01, $01, $01, $01
}

; $06C51B-$06C57E LOCAL JUMP LOCATION
Sprite_Lumberjacks:
{
    JSR.w LumberJacks_Draw
    JSR.w Sprite5_CheckIfActive
    
    ; Check inner hit detection box.
    LDY.b #$00
    
    JSR.w Lumberjacks_CheckProximity : BCS .check_outer_region
        PHX
        
        JSL.l Sprite_NullifyHookshotDrag
        
        STZ.b $5E
        
        JSL.l Player_HaltDashAttackLong
        
        PLX
    
    .check_outer_region
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .dont_speak
        ; Check outer hit detection box.
        LDY.b #$02
        
        JSR.w Lumberjacks_CheckProximity : BCS .dont_speak
            LDA.b $F6 : AND.b #$80 : BEQ .dont_speak
                LDA.b $22 : CMP.w $0D10, X : ROL : AND.b #$01 : STA.b $00
                STZ.b $01
                
                LDA.l $7EF359 : CMP.b #$02 : BCC .player_doesnt_have_master_sword
                    LDA.b #$02 : STA.b $01
                
                .player_doesnt_have_master_sword
                
                LDA.b $01 : CLC : ADC.b $00 : TAY
                
                LDA.w Pool_Sprite_Lumberjacks_messages_low, Y        : XBA
                LDA.w Pool_Sprite_Lumberjacks_messages_high, Y : TAY : XBA
                JSL.l Sprite_ShowMessageUnconditional
    
    .dont_speak
    
    LDA.b $1A : LSR #5 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $06C57F-$06C58E DATA
Pool_Lumberjacks_CheckProximity:
{
    ; $06C57F
    .x_lower_ranges
    dw 48, 52
    
    ; $06C581
    .y_lower_ranges
    dw 19, 20
    
    ; $06C583
    .x_upper_ranges
    dw 98, 106
    
    ; $06C585
    .y_upper_ranges
    dw 37, 40
}

; $06C58F-$06C5B1 LOCAL JUMP LOCATION
Lumberjacks_CheckProximity:
{
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $22
    
    CLC : ADC Pool_Lumberjacks_CheckProximity_x_lower_ranges, Y
    CMP Pool_Lumberjacks_CheckProximity_x_upper_ranges, Y : BCS .not_close_enough
        LDA.w $0FDA : SEC : SBC.b $20
        
        CLC : ADC Pool_Lumberjacks_CheckProximity_y_lower_ranges, Y
        CMP Pool_Lumberjacks_CheckProximity_y_upper_ranges, Y : BCS .not_close_enough
        
    .not_close_enough
    
    ; NOTE: one of the above is a zero length branch precisely because the 
    ; comparison operation wholly determines the "return value" of this
    ; routine, which is the status of the carry flag.
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06C5B2-$06C6B9 DATA
Lumberjacks_Draw_OAM_groups:
{
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

; $06C6BA-$06C6DD LOCAL JUMP LOCATION
Lumberjacks_Draw:
{
    LDA.b #$0B : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #2 : ADC.w $0DC0, X : ASL : ADC.w $0DC0, X : ASL #3
    
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_quantity_preset
    
    RTS
}

; ==============================================================================
