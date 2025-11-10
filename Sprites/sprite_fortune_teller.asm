; ==============================================================================

; Fortune teller / Dwarf Swordsmith.
; $06C75A-$06C761 LONG JUMP LOCATION
Sprite_FortuneTellerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_FortuneTeller
    
    PLB
    
    RTL
}

; ==============================================================================

; $06C762-$06C76C LOCAL JUMP LOCATION
Sprite_FortuneTeller:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FortuneTeller_Main   ; 0x00 - $C783
    dw Sprite_DwarfSolidity ; 0x01 - $C76D
}

; ==============================================================================

; NOTE: The sole purpose of this sprite is to add solidity to the Dwarf
; sprite (0x1A). Strange but true, as they could have just added this
; logic to the dwarf sprite logic and be done with it. Very peculiar...
; $06C76D-$06C782 JUMP LOCATION
Sprite_DwarfSolidity:
{
    JSR.w Sprite5_CheckIfActive
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_didnt_touch
        PHX
        
        JSL.l Sprite_NullifyHookshotDrag
        
        STZ.b $5E
        
        JSL.l Player_HaltDashAttackLong
        
        PLX
        
    .player_didnt_touch
    
    RTS
}

; ==============================================================================

; $06C783-$06C799 JUMP LOCATION
FortuneTeller_Main:
{
    JSR.w FortuneTeller_Draw
    JSR.w Sprite5_CheckIfActive
    
    LDA.l $7EF3CA : ASL : ROL : ROL : AND.b #$01
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FortuneTeller_LightWorld ; 0x00 - $C79A
    dw FortuneTeller_DarkWorld  ; 0x01 - $C996
}

; ==============================================================================

; $06C79A-$06C7B0 JUMP LOCATION
FortuneTeller_LightWorld:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw LW_FortuneTeller_WaitForInquiry          ; 0x00 - $C7B9
    dw LW_FortuneTeller_NotEnoughRupees         ; 0x01 - $C7DE
    dw LW_FortuneTeller_AskIfPlayerWantsReading ; 0x02 - $C7E7
    dw LW_FortuneTeller_ReactToPlayerResponse   ; 0x03 - $C7FF
    dw FortuneTeller_GiveReading                ; 0x04 - $C849
    dw LW_FortuneTeller_ShowCostMessage         ; 0x05 - $C960
    dw LW_FortuneTeller_DeductPayment           ; 0x06 - $C976
    dw LW_FortuneTeller_DoNothing               ; 0x07 - $C995
}

; ==============================================================================

; $06C7B1-$06C7B8 DATA
FortuneTeller_Prices:
{
    dw 10, 15, 20, 30
}

; $06C7B9-$06C7DD JUMP LOCATION
LW_FortuneTeller_WaitForInquiry:
{
    STZ.w $0DC0, X
    
    JSL.l GetRandomInt : AND.b #$03 : ASL : STA.w $0D90, X
                                            TAY
    
    REP #$20
    
    LDA.l $7EF360 : CMP FortuneTeller_Prices, Y : SEP #$30 : BCS .has_enough
        INC.w $0D80, X
        
        RTS
        
    .has_enough
    
    LDA.b #$02 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $06C7DE-$06C7E6 JUMP LOCATION
LW_FortuneTeller_NotEnoughRupees:
{
    ; "... my condition isn't very good today. But I want you to come back..."
    LDA.b #$F2
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $06C7E7-$06C7FE JUMP LOCATION
LW_FortuneTeller_AskIfPlayerWantsReading:
{
    ; "...you might have an interesting destiny... May I tell your fortune?"
    LDA.b #$F3
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        LDA.b #$01 : STA.w $02E4
    
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06C7FF-$06C828 JUMP LOCATION
LW_FortuneTeller_ReactToPlayerResponse:
{
    LDA.w $1CE8 : BNE .player_said_no
        LDA.w $0DF0, X : BNE .delay_and_animate
            INC.w $0D80, X
        
        .delay_and_animate
        
        LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
        
        RTS
        
    .player_said_no
    
    ; "It is indeed a poor man who is not interested in his future..."
    LDA.b #$F5
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    LDA.b #$02 : STA.w $0D80, X
    
    STZ.w $02E4
    
    RTS
}

; ==============================================================================

; $06C829-$06C848 DATA
Pool_FortuneTeller_GiveReading:
{
    ; $06C829
    .messages_low
    db $EA, $EB, $EC, $ED, $EE, $EF, $F0, $F1
    db $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD
    
    ; $06C839
    .messages_high
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
}

; $06C849-$06C952 JUMP LOCATION
FortuneTeller_GiveReading:
{
    STZ.w $0DC0, X
    
    INC.w $0D80, X
    
    STZ.b $03
    
    LDA.l $7EF3C7 : CMP.b #$03 : BCS .three_pendant_map_icons_or_better
        STZ.b $00
        STZ.b $01
        
        JMP .show_message
    
    .three_pendant_map_icons_or_better
    
    LDA.l $7EF34E : BNE .has_book_of_mudora
        LDA.b #$02
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCC .also_load_next_1
            JMP .show_message
        
        .also_load_next_1
    .has_book_of_mudora
    
    LDA.l $7EF374 : AND.b #$02 : BNE .has_pendant_of_wisdom
        LDA.b #$01
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCC .also_load_next_2
            JMP .show_message
        
        .also_load_next_2
    .has_pendant_of_wisdom
    
    LDA.l $7EF344 : CMP.b #$02 : BCS .has_magic_powder
        LDA.b #$03
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCC .also_load_next_3
            JMP .show_message
        
        .also_load_next_3
    .has_magic_powder
    
    LDA.l $7EF356 : BNE .has_flippers
        LDA.b #$04
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCC .also_load_next_4
            JMP .show_message
        
        .also_load_next_4
    .has_flippers
    
    LDA.l $7EF357 : BNE .has_moon_pearl
        LDA.b #$05
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .has_moon_pearl
    
    LDA.l $7EF3C5 : CMP.b #$03 : BCS .beaten_agahnim
        LDA.b #$06
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .beaten_agahnim
    
    LDA.l $7EF37B : BNE .has_halved_magic_usage
        LDA.b #$07
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .has_halved_magic_usage
    
    LDA.l $7EF347 : BNE .has_bombos_medallion
        LDA.b #$08
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .has_bombos_medallion
    
    LDA.l $7EF3C9 : AND.b #$10 : BNE .opened_thieves_chest
        LDA.b #$09
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .opened_thieves_chest
    
    LDA.l $7EF3C9 : AND.b #$20 : BNE .saved_smithy_frog
        LDA.b #$0A
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .saved_smithy_frog
    
    LDA.l $7EF352 : BNE .has_magic_cape
        LDA.b #$0B
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .has_magic_cape
    
    LDA.l $7EF2DB : AND.b #$02 : BNE .bombed_open_pyramid
        LDA.b #$0C
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .bombed_open_pyramid
    
    LDA.l $7EF359 : CMP.b #$04 : BCS .has_golden_sword
        LDA.b #$0D
        JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        
    .has_golden_sword
    
    LDA.b #$0E
    
    JSR.w FortuneTeller_PopulateNextMessageSlot : BCS .show_message
        LDA.b #$0F
        JSR.w FortuneTeller_PopulateNextMessageSlot
        
    .show_message
    
    ; Allows the fortune teller to alternate between two different messages
    ; within one group.
    LDA.l $7EF3C6 : EOR.b #$40 : STA.l $7EF3C6
    AND.b #$40 : ROL #3 : AND.b #$01 : TAY
    LDA.w $0000, Y : TAY
    
    LDA.w Pool_FortuneTeller_GiveReading_messages_low, Y        : XBA
    LDA.w Pool_FortuneTeller_GiveReading_messages_high, Y : TAY : XBA
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
}

; ==============================================================================

; $06C953-$06C95F LOCAL JUMP LOCATION
FortuneTeller_PopulateNextMessageSlot:
{
    LDY.b $03
    
    ; Note that with subsequent calls we can always overwrite the second
    ; slot, but never the first. However, the above logic pretty much
    ; guarantees that this subroutine is always called exactly twice per
    ; reading.
    STA.w $0000, Y
    
    INY : CPY.b #$02 : BCS .both_slots_filled
        STY.b $03
    
    .both_slots_filled
    
    RTS
}

; ==============================================================================

; $06C960-$06C975 LOCAL JUMP LOCATION
LW_FortuneTeller_ShowCostMessage:
{
    STZ.w $0DC0, X
    
    REP #$20
    
    STZ.b $00
    STZ.b $02
    STZ.b $04
    STZ.b $06
    
    LDY.w $0D90, X
    LDA FortuneTeller_Prices, Y
    
    JMP DW_FortuneTeller_ShowCostMessage_known_amount
}

; ==============================================================================

; $06C976-$06C994 LOCAL JUMP LOCATION
LW_FortuneTeller_DeductPayment:
{
    LDY.w $0D90, X
    
    REP #$20
    
    LDA.l $7EF360 : SEC : SBC FortuneTeller_Prices, Y : STA.l $7EF360
    
    SEP #$30
    
    INC.w $0D80, X
    
    LDA.b #$A0 : STA.l $7EF372
    
    STZ.w $02E4

    ; Bleeds into the next function.
}
    
; $06C995-$06C995 LOCAL JUMP LOCATION
LW_FortuneTeller_DoNothing:
{
    RTS
}

; ==============================================================================

; $06C996-$06C9AC JUMP LOCATION
FortuneTeller_DarkWorld:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw DW_FortuneTeller_WaitForInquiry          ; 0x00 - $C9AD
    dw DW_FortuneTeller_NotEnoughRupees         ; 0x01 - $C9D2
    dw DW_FortuneTeller_AskIfPlayerWantsReading ; 0x02 - $C9DB
    dw DW_FortuneTeller_ReactToPlayerResponse   ; 0x03 - $C9F3
    dw FortuneTeller_GiveReading                ; 0x04 - $C849
    dw DW_FortuneTeller_ShowCostMessage         ; 0x05 - $CA1D
    dw DW_FortuneTeller_DeductPayment           ; 0x06 - $CA81
    dw DW_FortuneTeller_DoNothing               ; 0x07 - $CAA0
}

; ==============================================================================

; $06C9AD-$06C9D1 JUMP LOCATION
DW_FortuneTeller_WaitForInquiry:
{
    STZ.w $0DC0, X
    
    JSL.l GetRandomInt : AND.b #$03 : ASL : STA.w $0D90, X
                                            TAY
    
    REP #$20
    
    LDA.l $7EF360 : CMP.w FortuneTeller_Prices, Y : SEP #$30 : BCS .has_enough
        INC.w $0D80, X
        
        RTS
        
    .has_enough
    
    LDA.b #$02 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $06C9D2-$06C9DA JUMP LOCATION
DW_FortuneTeller_NotEnoughRupees:
{
    ; "... my condition isn't very good today. But I want you to come back..."
    LDA.b #$F2
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; ==============================================================================

; $06C9DB-$06C9F2 JUMP LOCATION
DW_FortuneTeller_AskIfPlayerWantsReading:
{
    ; "...you might have an interesting destiny... May I tell your fortune?"
    LDA.b #$F3
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        LDA.b #$01 : STA.w $02E4
        
    .didnt_speak
    
    RTS
}

; ==============================================================================

; $06C9F3-$06CA1C JUMP LOCATION
DW_FortuneTeller_ReactToPlayerResponse:
{
    LDA.w $1CE8 : BNE .player_said_no
        LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
        
        LDA.w $0DF0, X : BNE .delay
            INC.w $0D80, X
        
        .delay
        
        RTS
        
    .player_said_no
    
    LDA.b #$F5
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    LDA.b #$02 : STA.w $0D80, X
    
    STZ.w $02E4
    
    RTS
}


; ==============================================================================

; $06CA1D-$06CA80 JUMP LOCATION
DW_FortuneTeller_ShowCostMessage:
{
    REP #$20
    
    STZ.b $00
    STZ.b $02
    STZ.b $04
    STZ.b $06
    
    LDY.w $0D90, X
    LDA.w FortuneTeller_Prices, Y
    
    ; $06CA2D ALTERNATE ENTRY POINT
    .known_amount
    
    .modulus_10000
    
        CMP.w #10000 : BCC .below_10000
            SBC.w #10000
    BRA .modulus_10000
        
    .below_10000

    .modulus_1000
    
        CMP.w #1000 : BCC .below_1000
            ; BUG: Fortune teller costs never exceed 30
            ; rupees anyways, but this value looks ... it just looks wrong.
            ; Either way, it should get the job done equivalently, it'll just
            ; take longer.
            SBC.w #100
            
            INC.b $06
    
    BRA .modulus_1000
    
    .below_1000
    
    .modulus_100
    
        CMP.w #100 : BCC .below_100
            SBC.w #100
            INC.b $04  
    BRA .modulus_100
    
    .below_100

    .modulus_10
        
        CMP.w #10 : BCC .below_10
            SBC.w #10
            
            INC.b $02
    BRA .modulus_10
    
    .below_10
    
    STA.b $00
    
    SEP #$30
    
    LDA.b $00 : ASL #4 : ORA.b $02 : STA.w $1CF2
    LDA.b $06 : ASL #4 : ORA.b $04 : STA.w $1CF3
    
    ; "Now I will take (amount) Rupees. (...) Yeehah ha hah!"
    LDA.b #$F4
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $06CA81-$06CA9F JUMP LOCATION
DW_FortuneTeller_DeductPayment:
{
    LDY.w $0D90, X
    
    REP #$20
    
    LDA.l $7EF360 : SEC : SBC FortuneTeller_Prices, Y : STA.l $7EF360
    
    SEP #$30
    
    INC.w $0D80, X
    
    LDA.b #$A0 : STA.l $7EF372
    
    STZ.w $02E4

    ; Bleeds into the next function.
}
    
; $06CAA0-$06CAA0 LOCAL JUMP LOCATION
DW_FortuneTeller_DoNothing:
{
    RTS
}

; ==============================================================================

; $06CAA1-$06CB00 DATA
FortuneTeller_Draw_OAM_groups:
{
    dw  0, -48 : db $0C, $00, $00, $02
    dw  0, -32 : db $2C, $00, $00, $00
    dw  8, -32 : db $2C, $40, $00, $00
    
    dw  0, -48 : db $0A, $00, $00, $02
    dw  0, -32 : db $2A, $00, $00, $00
    dw  8, -32 : db $2A, $40, $00, $00
    
    dw -4, -40 : db $66, $00, $00, $02
    dw  4, -40 : db $66, $40, $00, $02
    dw -4, -40 : db $66, $00, $00, $02
    
    dw -4, -40 : db $68, $00, $00, $02
    dw  4, -40 : db $68, $40, $00, $02
    dw -4, -40 : db $68, $00, $00, $02        
}

; $06CB01-$06CB29 LOCAL JUMP LOCATION
FortuneTeller_Draw:
{
    LDA.l $7EF3CA : ASL : ROL : ROL : AND.b #$01 : STA.b $00
    ASL : ADC.b $00 : ADC.w $0DC0, X : ASL : ADC.w $0DC0, X : ASL #3
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    LDA.b #$03
    JSL.l Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

; $06CB2A-$06CB53 LONG JUMP LOCATION
Dwarf_SpawnDwarfSolidity:
{
    LDA.b #$31
    JSL.l Sprite_SpawnDynamically
    
    LDA.b $00 : STA.w $0D10, Y
    LDA.b $01 : STA.w $0D30, Y
    
    LDA.b $02 : STA.w $0D00, Y
    LDA.b $03 : STA.w $0D20, Y
    
    LDA.b #$01 : STA.w $0E80, Y
    
    LDA.b #$00 : STA.w $0F60, Y
    
    LDA.b #$01 : STA.w $0BA0, Y
    
    RTL
}

; ==============================================================================
