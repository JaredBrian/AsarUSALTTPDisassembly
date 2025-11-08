; ==============================================================================

; Sprite preparation for magic shop dude and items...
; $02F521-$02F528 LONG JUMP LOCATION
SpritePrep_PotionShopLong:
{
    PHB : PHK : PLB
    
    JSR.w SpritePrep_PotionShop
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F529-$02F538 LOCAL JUMP LOCATION
SpritePrep_PotionShop:
{
    JSR.w PotionShop_SpawnMagicPowder
    JSR.w PotionShop_SpawnGreenPotion
    JSR.w PotionShop_SpawnBluePotion
    JSR.w PotionShop_SpawnRedPotion
    
    INC.w $0BA0, X
    
    RTS
}

; ==============================================================================

; $02F539-$02F58D LOCAL JUMP LOCATION
PotionShop_SpawnMagicPowder:
{
    LDA.w $0ABF : BEQ .must_leave_area_and_come_back
        LDA.l $7EF344 : CMP.b #$02 : BEQ .has_magic_powder
            PHX
            
            STZ.b $00
            
            REP #$10
            
            ; Hardcoded check for the potion shop room's flags (room 0x109).
            LDX.w #$0212
            LDA.l $7EF000, X : AND.b #$80 : STA.b $00
            
            SEP #$30
            
            PLX
            
            LDA.b $00 : BEQ .already_obtained
                LDA.b #$E9
                JSL.l Sprite_SpawnDynamically
                
                LDA.b #$01 : STA.w $0E80, Y
                
                LDA.w $0D00, X : SEC : SBC.b #$00 : STA.w $0D00, Y
                LDA.w $0D20, X       : SBC.b #$00 : STA.w $0D20, Y
                
                LDA.w $0D10, X : SEC : SBC.b #$10 : STA.w $0D10, Y
                LDA.w $0D30, X       : SBC.b #$00 : STA.w $0D30, Y
                
                JMP PotionShop_SetPlayerInteractivity
                
            .already_obtained
        .has_magic_powder
    .must_leave_area_and_come_back
    
    RTS
}

; ==============================================================================

; $02F58E-$02F5BE LOCAL JUMP LOCATION
PotionShop_SpawnGreenPotion:
{
    LDA.b #$E9
    JSL.l Sprite_SpawnDynamically
    
    LDA.b #$02 : STA.w $0E80, Y
    
    LDA.w $0D00, X : SEC : SBC.b #$48 : STA.w $0D00, Y
    LDA.w $0D20, X       : SBC.b #$00 : STA.w $0D20, Y
    
    LDA.w $0D10, X : SEC : SBC.b #$28 : STA.w $0D10, Y
    LDA.w $0D30, X       : SBC.b #$00 : STA.w $0D30, Y
    
    JMP PotionShop_SetPlayerInteractivity
    
    RTS
} 

; ==============================================================================

; $02F5BF-$02F5EF LOCAL JUMP LOCATION
PotionShop_SpawnBluePotion:
{
    LDA.b #$E9
    JSL.l Sprite_SpawnDynamically
    
    LDA.b #$03 : STA.w $0E80, Y
    
    LDA.w $0D00, X : SEC : SBC.b #$48 : STA.w $0D00, Y
    LDA.w $0D20, X       : SBC.b #$00 : STA.w $0D20, Y
    
    LDA.w $0D10, X : CLC : ADC.b #$08 : STA.w $0D10, Y
    LDA.w $0D30, X       : ADC.b #$00 : STA.w $0D30, Y
    
    JMP PotionShop_SetPlayerInteractivity
    
    RTS
}

; ==============================================================================

; $02F5F0-$02F61C LOCAL JUMP LOCATION
PotionShop_SpawnRedPotion:
{
    LDA.b #$E9
    JSL.l Sprite_SpawnDynamically
    
    LDA.b #$04 : STA.w $0E80, Y
    
    LDA.w $0D00, X : SEC : SBC.b #$48 : STA.w $0D00, Y
    LDA.w $0D20, X       : SBC.b #$00 : STA.w $0D20, Y
    
    LDA.w $0D10, X : SEC : SBC.b #$58 : STA.w $0D10, Y
    LDA.w $0D30, X       : SBC.b #$00 : STA.w $0D30, Y

    ; Bleeds into the next function.
}

; $02F61D-$02F62A LOCAL JUMP LOCATION
PotionShop_SetPlayerInteractivity:
{
    LDA.b #$03 : STA.w $0F60, Y
    
    LDA.w $0CAA, Y : ORA.b #$20 : STA.w $0CAA, Y
    
    RTS
}

; ==============================================================================

; Magic shop dude and his items
; $02F62B-$02F632 LONG JUMP LOCATION
Sprite_PotionShopLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_PotionShop
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F633-$02F643 LOCAL JUMP LOCATION
Sprite_PotionShop:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Sprite_WitchAssistant  ; 0x00 - $F893
    dw Sprite_MagicPowderItem ; 0x01 - $F644
    dw Sprite_GreenPotionItem ; 0x02 - $F68E
    dw Sprite_BluePotionItem  ; 0x03 - $F72B
    dw Sprite_RedPotionItem   ; 0x04 - $F7D0
}

; ==============================================================================

; $02F644-$02F66A JUMP LOCATION
Sprite_MagicPowderItem:
{
    JSR.w MagicPowderItem_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_give_item
        LDA.b $F6 : BPL .dont_give_item
            PHX
            
            JSL.l Player_HaltDashAttackLong
            
            LDY.b #$0D
            
            STZ.w $02E9
            
            JSL.l Link_ReceiveItem
            
            PLX
            
            STZ.w $0DD0, X
        
    .dont_give_item
    
    RTS
}

; ==============================================================================

; $02F66B-$02F67A DATA
MagicPowderItem_Draw_OAM_groups:
{
    dw 0, 0 : db $E6, $04, $00, $02
    dw 0, 0 : db $E6, $04, $00, $02
}

; $02F67B-$02F68D LOCAL JUMP LOCATION
MagicPowderItem_Draw:
{
    ; Interesting thing to note: This will end up drawing the same sprite
    ; twice (in the same location), for whatever reason.
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.b #(.OAM_groups >> 0) : STA.b $08
    LDA.b #(.OAM_groups >> 8) : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================

; $02F68E-$02F6FF LOCAL JUMP LOCATION
Sprite_GreenPotionItem:
{
    JSR.w GreenPotionItem_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0DF0, X : BNE .alpha
        JSR.w WitchAssistant_CheckIfHaveAnyBottles : BCS .beta
            LDA.b #$4F
            LDY.b #$00
            JSL.l Sprite_ShowMessageFromPlayerContact : BCC .messsage_didnt_show
                JSR.w PotionItem_ErrorSFX
            
            .messsage_didnt_show
    .alpha
    
    RTS
    
    .beta
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .gamma
        LDA.b $F6 : BPL .gamma
            REP #$20
            
            ; Does the player have 60 rupees?
            LDA.l $7EF360 : CMP.w #$003C : SEP #$30 : BCC .delta
                JSL.l Sprite_GetEmptyBottleIndex : BMI .player_has_no_empty_bottle
                
                LDA.b #$1D
                JSL.l Sound_SetSFX3PanLong
                
                LDA.b #$40 : STA.w $0DF0, X
                
                REP #$20
                
                LDA.l $7EF360 : SEC : SBC.w #$003C : STA.l $7EF360
                
                SEP #$30
                
                LDY.b #$2F
                
                STZ.w $02E9
                
                JSL.l Link_ReceiveItem
    
    .gamma
    
    RTS
    
    .player_has_no_empty_bottle
    
    LDA.b #$50
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    JMP PotionItem_ErrorSFX
    
    .delta
    
    JMP.w PotionCauldron_PovertyDisclaimer
}

; ==============================================================================

; $02F700-$02F717 DATA
GreenPotionItem_Draw_OAM_groups:
{
    dw  0,  0 : db $C0, $08, $00, $02
    dw  8, 18 : db $30, $0A, $00, $00
    dw -1, 18 : db $22, $0A, $00, $00
}

; $02F718-$02F72A LOCAL JUMP LOCATION
GreenPotionItem_Draw:
{
    LDA.b #$03 : STA.b $06
                 STZ.b $07
    
    LDA.b #(.OAM_groups >> 0) : STA.b $08
    LDA.b #(.OAM_groups >> 8) : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================

; $02F72B-$02F79C JUMP LOCATION
Sprite_BluePotionItem:
{
    JSR.w BluePotionItem_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0DF0, X : BNE .alpha
        JSR.w WitchAssistant_CheckIfHaveAnyBottles : BCS .beta
            LDA.b #$4F
            LDY.b #$00
            JSL.l Sprite_ShowMessageFromPlayerContact : BCC .alpha
                JSR.w PotionItem_ErrorSFX
        
    .alpha
    
    RTS
    
    .beta
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .gamma
        LDA.b $F6 : BPL .gamma
            REP #$20
            
            ; Check if the player has 160 rupees:
            LDA.l $7EF360 : CMP.w #$00A0 : SEP #$30 : BCC .delta
                JSL.l Sprite_GetEmptyBottleIndex : BMI .player_has_no_empty_bottle
                    LDA.b #$1D
                    JSL.l Sound_SetSFX3PanLong
                    
                    LDA.b #$40 : STA.w $0DF0, X
                    
                    REP #$20
                    
                    LDA.l $7EF360 : SEC : SBC.w #$00A0 : STA.l $7EF360
                    
                    SEP #$30
                    
                    LDY.b #$30
                    STZ.w $02E9
                    JSL.l Link_ReceiveItem
            
    .gamma
    
    RTS
    
    .player_has_no_empty_bottle
    
    LDA.b #$50
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional

    JMP PotionItem_ErrorSFX
    
    .delta
    
    JMP.w PotionCauldron_PovertyDisclaimer
}

; ==============================================================================

; $02F79D-$02F7BC DATA
BluePotionItem_Draw_OAM_groups:
{
    dw  0,  0 : db $C0, $04, $00, $02
    dw 13, 18 : db $30, $0A, $00, $00
    dw  5, 18 : db $22, $0A, $00, $00
    dw -3, 18 : db $31, $0A, $00, $00
}

; $02F7BD-$02F7CF LOCAL JUMP LOCATION
BluePotionItem_Draw:
{
    LDA.b #$04 : STA.b $06
                 STZ.b $07
    
    LDA.b #(.OAM_groups >> 0) : STA.b $08
    LDA.b #(.OAM_groups >> 8) : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================

; $02F7D0-$02F83D JUMP LOCATION
Sprite_RedPotionItem:
{
    JSR.w RedPotionItem_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0DF0, X : BNE .alpha
        JSR.w WitchAssistant_CheckIfHaveAnyBottles : BCS .beta
            LDA.b #$4F
            LDY.b #$00
            JSL.l Sprite_ShowMessageFromPlayerContact : BCC .alpha
                JSR.w PotionItem_ErrorSFX
    
    .alpha
    
    RTS
    
    .beta
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .gamma
        LDA.b $F6 : BPL .gamma
            REP #$20
            
            ; Check if player has 120 rupees:
            LDA.l $7EF360 : CMP.w #$0078 : SEP #$30 : BCC PotionCauldron_PovertyDisclaimer
                JSL.l Sprite_GetEmptyBottleIndex : BMI .player_has_no_empty_bottle
                    LDA.b #$1D
                    JSL.l Sound_SetSFX3PanLong
                    
                    LDA.b #$40 : STA.w $0DF0, X
                    
                    REP #$20
                    
                    LDA.l $7EF360 : SEC : SBC.w #$0078 : STA.l $7EF360
                    
                    SEP #$30
                    
                    LDY.b #$2E
                    STZ.w $02E9
                    JSL.l Link_ReceiveItem
    
    .gamma
    
    RTS
    
    .player_has_no_empty_bottle
    
    ; "No, no, no...  I can't put anything into a full bottle. He he he!"
    LDA.b #$50
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    BRA PotionItem_ErrorSFX
}

; $02F83E-$02F845 JUMP LOCATION
PotionCauldron_PovertyDisclaimer:
{
    ; "I'm sorry, but you don't seem to have enough Rupees..."
    LDA.b #$7C
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    ; Bleeds into the next function.
}
    
; $02F846-$02F84C JUMP LOCATION
PotionItem_ErrorSFX:
{
    LDA.b #$3C
    JSL.l Sound_SetSFX2PanLong
    
    RTS
}

; ==============================================================================

; $02F84D-$02F86C DATA
RedPotionItem_Draw_OAM_groups:
{
    dw  0,  0 : db $C0, $02, $00, $02
    dw 13, 18 : db $30, $0A, $00, $00
    dw  5, 18 : db $02, $0A, $00, $00
    dw -3, 18 : db $31, $0A, $00, $00
}

; $02F86D-$02F87F LOCAL JUMP LOCATION
RedPotionItem_Draw:
{
    LDA.b #$04 : STA.b $06
                 STZ.b $07
    
    LDA.b #(.OAM_groups >> 0) : STA.b $08
    LDA.b #(.OAM_groups >> 8) : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================

; $02F880-$02F892 LOCAL JUMP LOCATION
WitchAssistant_CheckIfHaveAnyBottles:
{
    LDA.l $7EF35C : ORA.l $7EF35D : ORA.l $7EF35E : ORA.l $7EF35F
    
    ; Determines whether we have a bottle or not.
    CMP.b #$02
    
    RTS
}

; ==============================================================================

; $02F893-$02F8FA JUMP LOCATION
Sprite_WitchAssistant:
{
    JSL.l Shopkeeper_Draw
    JSR.w Sprite2_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .alpha
        LDA.w $0D80, X : BEQ .beta
            LDA.b #$A0 : STA.l $7EF372
            
            STZ.w $0D80, X
        
        .beta
        
        LDA.b $1A : LSR #5 : AND.b #$01 : STA.w $0DC0, X
        
        LDA.l $7EF35C : CMP.b #$02 : BCS .gamma
            LDA.l $7EF35D : CMP.b #$02 : BCS .gamma
                LDA.l $7EF35E : CMP.b #$02 : BCS .gamma
                    LDA.l $7EF35F : CMP.b #$02 : BCS .gamma
                        LDA.w $0ABF : BEQ .gamma
                            ; You should buy a bottle to put the potion in, hehehe."
                            LDA.b #$4D
                            LDY.b #$00
                            JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
                            
                            .delta
                            
                            BCC .alpha
                                INC.w $0D80, X
    
    .alpha
    
    RTS
    
    .gamma
    
    ; TODO: Confrim what message this is.
    LDA.b #$4E
    LDY.b #$00
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    BRA .delta
}

; ==============================================================================

; $02F8FB-$02F91A DATA
Shopkeeper_Draw_OAM_groups:
{
    dw 0, -8 : db $00, $0C, $00, $02
    dw 0,  0 : db $10, $0C, $00, $02
    
    dw 0, -8 : db $00, $0C, $00, $02
    dw 0,  0 : db $10, $4C, $00, $02
}

; $02F91B-$02F93E LONG JUMP LOCATION
Shopkeeper_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #4
    ADC.b #(.OAM_groups >> 0)              : STA.b $08
    LDA.b #(.OAM_groups >> 8) : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================
