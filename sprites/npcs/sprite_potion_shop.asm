
; ==============================================================================

; $02F521-$02F528 LONG
SpritePrep_PotionShopLong:
{
    ; Sprite preparation for magic shop dude and items...
    
    PHB : PHK : PLB
    
    JSR SpritePrep_PotionShop
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F529-$02F538 LOCAL
SpritePrep_PotionShop:
{
    JSR PotionShop_SpawnMagicPowder
    JSR PotionShop_SpawnGreenPotion
    JSR PotionShop_SpawnBluePotion
    JSR PotionShop_SpawnRedPotion
    
    INC $0BA0, X
    
    RTS
}

; ==============================================================================

; $02F539-$02F58D LOCAL
PotionShop_SpawnMagicPowder:
{
    LDA $0ABF : BEQ .must_leave_area_and_come_back
    
    LDA $7EF344 : CMP.b #$02 : BEQ .has_magic_powder
    
    PHX
    
    STZ $00
    
    REP #$10
    
    ; Hardcoded check for the potion shop room's flags (room 0x109)
    LDX.w #$0212
    
    LDA $7EF000, X : AND.b #$80 : STA $00
    
    SEP #$30
    
    PLX
    
    LDA $00 : BEQ .already_obtained
    
    LDA.b #$E9 : JSL Sprite_SpawnDynamically
    
    LDA.b #$01 : STA $0E80, Y
    
    LDA $0D00, X : SEC : SBC.b #$00 : STA $0D00, Y
    LDA $0D20, X : SBC.b #$00 : STA $0D20, Y
    
    LDA $0D10, X : SEC : SBC.b #$10 : STA $0D10, Y
    LDA $0D30, X : SBC.b #$00 : STA $0D30, Y
    
    JMP PotionShop_SetPlayerInteractivity
    
    .already_obtained
    .has_magic_powder
    .must_leave_area_and_come_back
    
    RTS
}

; ==============================================================================

; $02F58E-$02F5BE LOCAL
PotionShop_SpawnGreenPotion:
{
    LDA.b #$E9 : JSL Sprite_SpawnDynamically
    
    LDA.b #$02 : STA $0E80, Y
    
    LDA $0D00, X : SEC : SBC.b #$48 : STA $0D00, Y
    LDA $0D20, X : SBC.b #$00 : STA $0D20, Y
    
    LDA $0D10, X : SEC : SBC.b #$28 : STA $0D10, Y
    LDA $0D30, X : SBC.b #$00 : STA $0D30, Y
    
    JMP PotionShop_SetPlayerInteractivity
    
    .unused_label
    
    RTS
} 

; ==============================================================================

; $02F5BF-$02F5EF LOCAL
PotionShop_SpawnBluePotion:
{
    LDA.b #$E9 : JSL Sprite_SpawnDynamically
    
    LDA.b #$03 : STA $0E80, Y
    
    LDA $0D00, X : SEC : SBC.b #$48 : STA $0D00, Y
    LDA $0D20, X : SBC.b #$00 : STA $0D20, Y
    
    LDA $0D10, X : CLC : ADC.b #$08 : STA $0D10, Y
    LDA $0D30, X : ADC.b #$00 : STA $0D30, Y
    
    JMP PotionShop_SetPlayerInteractivity
    
    .unused_label
    
    RTS
}

; ==============================================================================

; $02F5F0-$02F62A LOCAL
PotionShop_SpawnRedPotion:
{
    LDA.b #$E9
    
    JSL Sprite_SpawnDynamically
    
    LDA.b #$04 : STA $0E80, Y
    
    LDA $0D00, X : SEC : SBC.b #$48 : STA $0D00, Y
    LDA $0D20, X : SBC.b #$00 : STA $0D20, Y
    
    LDA $0D10, X : SEC : SBC.b #$58 : STA $0D10, Y
    LDA $0D30, X : SBC.b #$00 : STA $0D30, Y
    
    ; $02F61D ALTERNATE ENTRY POINT
    shared PotionShop_SetPlayerInteractivity:
    
    LDA.b #$03 : STA $0F60, Y
    
    LDA $0CAA, Y : ORA.b #$20 : STA $0CAA, Y
    
    RTS
}

; ==============================================================================

; $02F62B-$02F632 LONG
Sprite_PotionShopLong:
{
    ; Magic shop dude and his items
    
    PHB : PHK : PLB
    
    JSR Sprite_PotionShop
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F633-$02F643 LOCAL
Sprite_PotionShop:
{
    LDA $0E80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Sprite_WitchAssistant
    dw Sprite_MagicPowderItem
    dw Sprite_GreenPotionItem
    dw Sprite_BluePotionItem
    dw Sprite_RedPotionItem
}

; ==============================================================================

; $02F644-$02F66A JUMP LOCATION
Sprite_MagicPowderItem:
{
    JSR MagicPowderItem_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_give_item
    
    LDA $F6 : BPL .dont_give_item
    
    PHX
    
    JSL Player_HaltDashAttackLong
    
    LDY.b #$0D
    
    STZ $02E9
    
    JSL Link_ReceiveItem
    
    PLX
    
    STZ $0DD0, X
    
    .dont_give_item
    
    RTS
}

; ==============================================================================

; $02F66B-$02F67A DATA
pool MagicPowderItem_Draw:
{
    .oam_groups
    dw 0, 0 : db $E6, $04, $00, $02
    dw 0, 0 : db $E6, $04, $00, $02
}

; ==============================================================================

; $02F67B-$02F68D LOCAL
MagicPowderItem_Draw:
{
    ; Interesting thing to note: This will end up drawing the same sprite
    ; twice (in the same location), for whatever reason.
    LDA.b #$02 : STA $06
                 STZ $07
    
    LDA.b #(.oam_groups >> 0) : STA $08
    LDA.b #(.oam_groups >> 8) : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    RTS
}

; ==============================================================================

; $02F68E-$02F6FF LOCAL
Sprite_GreenPotionItem:
{
    JSR GreenPotionItem_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0DF0, X : BNE .alpha
    
    JSR WitchAssistant_CheckIfHaveAnyBottles : BCS .beta
    
    LDA.b #$4F
    LDY.b #$00
    
    JSL Sprite_ShowMessageFromPlayerContact : BCC .messsage_didnt_show
    
    JSR PotionItem_ErrorSfx
    
    .messsage_didnt_show
    .alpha
    
    RTS
    
    .beta
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .gamma
    
    LDA $F6 : BPL .gamma
    
    REP #$20
    
    ; does the player have 60 rupees?
    LDA $7EF360 : CMP.w #$003C : SEP #$30 : BCC .delta
    
    JSL Sprite_GetEmptyBottleIndex : BMI .player_has_no_empty_bottle
    
    LDA.b #$1D : JSL Sound_SetSfx3PanLong
    
    LDA.b #$40 : STA $0DF0, X
    
    REP #$20
    
    LDA $7EF360 : SEC : SBC.w #$003C : STA $7EF360
    
    SEP #$30
    
    LDY.b #$2F
    
    STZ $02E9
    
    JSL Link_ReceiveItem
    
    .gamma
    
    RTS
    
    .player_has_no_empty_bottle
    
    LDA.b #$50
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    JMP PotionItem_ErrorSfx
    
    .delta
    
    JMP $F83E   ; $02F83E IN ROM
}

; ==============================================================================

; $02F700-$02F717 DATA
pool GreenPotionItem_Draw:
{
    .oam_groups
    dw  0,  0 : db $C0, $08, $00, $02
    dw  8, 18 : db $30, $0A, $00, $00
    dw -1, 18 : db $22, $0A, $00, $00
}

; ==============================================================================

; $02F718-$02F72A LOCAL
GreenPotionItem_Draw:
{
    LDA.b #$03 : STA $06
                 STZ $07
    
    LDA.b #(.oam_groups >> 0) : STA $08
    LDA.b #(.oam_groups >> 8) : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    RTS
}

; ==============================================================================

; $02F72B-$02F79C JUMP LOCATION
Sprite_BluePotionItem:
{
    JSR BluePotionItem_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0DF0, X : BNE .alpha
    
    JSR WitchAssistant_CheckIfHaveAnyBottles : BCS .beta
    
    LDA.b #$4F
    LDY.b #$00
    
    JSL Sprite_ShowMessageFromPlayerContact : BCC .alpha
    
    JSR PotionItem_ErrorSfx
    
    .alpha
    
    RTS
    
    .beta
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .gamma
    
    LDA $F6 : BPL .gamma
    
    REP #$20
    
    ; check if the player has 160 rupees
    LDA $7EF360 : CMP.w #$00A0 : SEP #$30 : BCC .delta
    
    JSL Sprite_GetEmptyBottleIndex : BMI .player_has_no_empty_bottle
    
    LDA.b #$1D : JSL Sound_SetSfx3PanLong
    
    LDA.b #$40 : STA $0DF0, X
    
    REP #$20
    
    LDA $7EF360 : SEC : SBC.w #$00A0 : STA $7EF360
    
    SEP #$30
    
    LDY.b #$30
    
    STZ $02E9
    
    JSL Link_ReceiveItem
    
    .gamma
    
    RTS
    
    .player_has_no_empty_bottle
    
    LDA.b #$50
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    JMP PotionItem_ErrorSfx
    
    .delta
    
    JMP $F83E   ; $02F83E IN ROM
}

; ==============================================================================

; $02F79D-$02F7BC DATA
pool BluePotionItem_Draw:
{
    .oam_groups
    dw  0,  0 : db $C0, $04, $00, $02
    dw 13, 18 : db $30, $0A, $00, $00
    dw  5, 18 : db $22, $0A, $00, $00
    dw -3, 18 : db $31, $0A, $00, $00
}

; ==============================================================================

; $02F7BD-$02F7CF LOCAL
BluePotionItem_Draw:
{
    LDA.b #$04 : STA $06
                 STZ $07
    
    LDA.b #(.oam_groups >> 0) : STA $08
    LDA.b #(.oam_groups >> 8) : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    RTS
}

; ==============================================================================

; $02F7D0-$02F84C JUMP LOCATION
Sprite_RedPotionItem:
{
    JSR RedPotionItem_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    LDA $0DF0, X : BNE .alpha
    
    JSR WitchAssistant_CheckIfHaveAnyBottles : BCS .beta
    
    LDA.b #$4F
    LDY.b #$00
    
    JSL Sprite_ShowMessageFromPlayerContact : BCC .alpha
    
    JSR PotionItem_ErrorSfx
    
    .alpha
    
    RTS
    
    .beta
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .gamma
    
    LDA $F6 : BPL .gamma
    
    REP #$20
    
    ; check if player has 120 rupees
    LDA $7EF360 : CMP.w #$0078 : SEP #$30 : BCC .delta
    
    JSL Sprite_GetEmptyBottleIndex : BMI .player_has_no_empty_bottle
    
    LDA.b #$1D : JSL Sound_SetSfx3PanLong
    
    LDA.b #$40 : STA $0DF0, X
    
    REP #$20
    
    LDA $7EF360 : SEC : SBC.w #$0078 : STA $7EF360
    
    SEP #$30
    
    LDY.b #$2E
    
    STZ $02E9
    
    JSL Link_ReceiveItem
    
    .gamma
    
    RTS
    
    .player_has_no_empty_bottle
    
    ; "No, no, no...  I can't put anything into a full bottle. He he he!"
    LDA.b #$50
    LDY.b #$00
    
    JSL Sprite_ShowMessageUnconditional
    
    BRA .zeta
    
    ; $02F83E ALTERNATE ENTRY POINT
    .delta
    
    ; "I'm sorry, but you don't seem to have enough Rupees..."
    LDA.b #$7C
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    .zeta
    
    ; $02F846 ALTERNATE ENTRY POINT
    shared PotionItem_ErrorSfx:
    
    LDA.b #$3C : JSL Sound_SetSfx2PanLong
    
    RTS
}

; ==============================================================================

; $02F84D-$02F86C DATA
pool RedPotionItem_Draw:
{
    .oam_groups
    dw  0,  0 : db $C0, $02, $00, $02
    dw 13, 18 : db $30, $0A, $00, $00
    dw  5, 18 : db $02, $0A, $00, $00
    dw -3, 18 : db $31, $0A, $00, $00
}

; ==============================================================================

; $02F86D-$02F87F LOCAL
RedPotionItem_Draw:
{
    LDA.b #$04 : STA $06
                 STZ $07
    
    LDA.b #(.oam_groups >> 0) : STA $08
    LDA.b #(.oam_groups >> 8) : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    
    RTS
}

; ==============================================================================

; $02F880-$02F892 LOCAL
WitchAssistant_CheckIfHaveAnyBottles:
{
    LDA $7EF35C : ORA $7EF35D : ORA $7EF35E : ORA $7EF35F
    
    ; Determines whether we have a bottle or not.
    CMP.b #$02
    
    RTS
}

; ==============================================================================

; $02F893-$02F8FA JUMP LOCATION
Sprite_WitchAssistant:
{
    JSL Shopkeeper_Draw
    JSR Sprite2_CheckIfActive
    JSL Sprite_PlayerCantPassThrough
    
    JSL Sprite_CheckIfPlayerPreoccupied : BCS .alpha
    
    LDA $0D80, X : BEQ .beta
    
    LDA.b #$A0 : STA $7EF372
    
    STZ $0D80, X
    
    .beta
    
    LDA $1A : LSR #5 : AND.b #$01 : STA $0DC0, X
    
    LDA $7EF35C : CMP.b #$02 : BCS .gamma
    
    LDA $7EF35D : CMP.b #$02 : BCS .gamma
    
    LDA $7EF35E : CMP.b #$02 : BCS .gamma
    
    LDA $7EF35F : CMP.b #$02 : BCS .gamma
    
    LDA $0ABF : BEQ .gamma
    
    ; You should buy a bottle to put the potion in, hehehe."
    LDA.b #$4D
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    .delta
    
    BCC .alpha
    
    INC $0D80, X
    
    .alpha
    
    RTS
    
    .gamma
    
    LDA.b #$4E
    LDY.b #$00
    
    JSL Sprite_ShowSolicitedMessageIfPlayerFacing
    
    BRA .delta
}

; ==============================================================================

; $02F8FB-$02F91A DATA
pool Shopkeeper_Draw:
{
    .oam_groups
    dw 0, -8 : db $00, $0C, $00, $02
    dw 0,  0 : db $10, $0C, $00, $02
    
    dw 0, -8 : db $00, $0C, $00, $02
    dw 0,  0 : db $10, $4C, $00, $02
}

; ==============================================================================

; $02F91B-$02F93E LONG
Shopkeeper_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA $06
                 STZ $07
    
    LDA $0DC0, X : ASL #4
    
    ADC.b #(.oam_groups >> 0)              : STA $08
    LDA.b #(.oam_groups >> 8) : ADC.b #$00 : STA $09
    
    JSL Sprite_DrawMultiple.player_deferred
    JSL Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

