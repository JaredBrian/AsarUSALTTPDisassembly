; ==============================================================================

; $0F6EEF-$0F6F11 JUMP LOCATION
Sprite_ShopKeeper:
{
    LDA.w $0E80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Shopkeeper_StandardClerk ; 0x00 - $EF12
    dw ChestGameGuy             ; 0x01 - $EF90
    dw NiceThiefWithGift        ; 0x02 - $F038
    dw MiniChestGameGuy         ; 0x03 - $F078
    dw LostWoodsChestGameGuy    ; 0x04 - $F0F3
    dw NiceThiefUnderRock       ; 0x05 - $F14F Thief talkin about Ice Cave near Lake Hylia.
    dw NiceThiefUnderRock       ; 0x06 - $F14F Thief talkin about defeating enemies for rupees.
    dw ShopItem_RedPotion150    ; 0x07 - $F16E
    dw ShopItem_FighterShield   ; 0x08 - $F1F2
    dw ShopItem_FireShield      ; 0x09 - $F230
    dw ShopItem_Heart           ; 0x0A - $F27D
    dw ShopItem_Arrows          ; 0x0B - $F2AF
    dw ShopItem_Bombs           ; 0x0C - $F2F0
    dw ShopItem_Bee             ; 0x0D - $F322
}

; $0F6F12-$0F6F6C JUMP LOCATION
Shopkeeper_StandardClerk:
{
    LDA.w $0FFF : BEQ .in_light_world
        JSL.l Sprite_OAM_AllocateDeferToPlayerLong
        JSL.l Sprite_PrepAndDrawSingleLargeLong
        JSR.w Sprite3_CheckIfActive
        
        LDA.w $0F50, X : AND.b #$3F : STA.b $00
        
        LDA.b $1A : ASL #3 : AND.b #$40 : ORA.b $00 : STA.w $0F50, X
        
        .BRANCH_BETA
        
        JSL.l Sprite_PlayerCantPassThrough
        
        LDY.w $0FFF
        
        LDA.w .messages_low, Y         : XBA
        LDA.w .messsages_high, Y : TAY : XBA
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        LDA.w $0D80, X : BEQ Shopkeeper_StandardClerk_not_welcomed_yet
            BRA Shopkeeper_StandardClerk_not_welcomed_yet_return
    
    .in_light_world
    
    LDA.b #$07 : STA.w $0F50, X
    
    JSL.l Shopkeeper_Draw
    JSR.w Sprite3_CheckIfActive
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    BRA .BRANCH_BETA

    ; $0F6F69
    .messages_low
    ; "May I help you? Select the thing you like (...). Prices as marked!"
    ; "In such a dangerous world you may need many things..."
    db $65, $5F
    
    ; $0F6F6B
    .messsages_high
    db $01, $01
}

; $0F6F6D-$0F6F8F LOCAL JUMP LOCATION
Shopkeeper_StandardClerk_not_welcomed_yet:
{
    REP #$20
    
    LDA.w $0FDA : CLC : ADC.w #$0060 : CMP $20 : SEP #$30 : BCC .return
        LDY.w $0FFF
        
        LDA.w Shopkeeper_StandardClerk_messages_low, Y         : XBA
        LDA.w Shopkeeper_StandardClerk_messsages_high, Y : TAY : XBA
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
    
    ; $0F6F6D ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; $0F6F90-$0F6FBE JUMP LOCATION
ChestGameGuy:
{
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0F50, X : AND.b #$3F : STA.b $00
    
    LDA.b $1A : ASL #3 : AND.b #$40 : ORA.b $00 : STA.w $0F50, X
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw ChestGameGuy_OfferGame     ; 0x00 - $EFBF
    dw ChestGameGuy_HandlePayment ; 0x01 - $EFD5
    dw ChestGameGuy_ProctorGame   ; 0x02 - $F000
}

; $0F6FBF-$0F6FD4 JUMP LOCATION
ChestGameGuy_OfferGame:
{
    LDA.w $04C4 : DEC : CMP.b #$02 : BCC .BRANCH_ALPHA
        LDA.b #$60
        LDY.b #$01
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
            INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F6FD5-$0F6FFF JUMP LOCATION
ChestGameGuy_HandlePayment:
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
        LDA.b #$1E
        LDY.b #$00
        JSR.w ShopKeeper_TryToGetPaid : BCC .BRANCH_ALPHA
            LDA.b #$02 : STA.w $04C4
            
            LDA.b #$64
            LDY.b #$01
            JSL.l Sprite_ShowMessageUnconditional
            
            INC.w $0D80, X
            
            RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$61
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $0F7000-$0F7016 JUMP LOCATION
ChestGameGuy_ProctorGame:
{
    LDA.w $04C4 : BNE .BRANCH_ALPHA
        LDA.b #$63
        LDY.b #$01
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
        
        RTS
        
    .BRANCH_ALPHA
    
    LDA.b #$7F
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; $0F7017-$0F7037 LOCAL JUMP LOCATION
NiceThief_Animate:
{
    LDA.b $1A : AND.b #$03 : BNE .BRANCH_ALPHA
        LDA.b #$02 : STA.w $0DC0, X
        
        JSR.w Sprite3_DirectionToFacePlayer
        
        CPY.b #$03 : BNE .BRANCH_BETA
            LDY.b #$02
        
        .BRANCH_BETA
        
        TYA : STA.w $0EB0, X
    
    .BRANCH_ALPHA
    
    JSL.l Sprite_OAM_AllocateDeferToPlayerLong
    JSL.l Thief_Draw
    
    RTS
}

; $0F7038-$0F704E JUMP LOCATION
NiceThiefWithGift:
{
    JSR.w NiceThief_Animate
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw NiceThiefWithGift_WaitForInteraction ; 0x00 - $F04F
    dw NiceThiefWithGift_GiveRupees         ; 0x01 - $F05D
    dw NiceThiefWithGift_ResetAI            ; 0x02 - $F074
}

; $0F704F-$0F705C JUMP LOCATION
NiceThiefWithGift_WaitForInteraction:
{
    LDA.b #$76
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .BRANCH_ALPHA
        INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F705D-$0F7073 JUMP LOCATION
NiceThiefWithGift_GiveRupees:
{
    LDA.w $0403 : AND.b #$40 : BNE .BRANCH_ALPHA
        LDA.w $0403 : ORA.b #$40 : STA.w $0403
        
        INC.w $0D80, X
        
        LDY.b #$46 : JMP.w ShopItem_HandleReceipt

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $0F7074-$0F7077 JUMP LOCATION
NiceThiefWithGift_ResetAI:
{
    STZ.w $0D80, X
    
    RTS
}

; $0F7078-$0F709B JUMP LOCATION
MiniChestGameGuy:
{
    JSR.w Sprite3_DirectionToFacePlayer
    
    TYA : EOR.b #$03 : STA.w $0DE0, X
    
    STZ.w $0DC0, X
    
    JSL.l MazeGameGuy_Draw
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw MiniChestGameGuy_OfferGame        ; 0x00 - $F09C
    dw MiniChestGameGuy_VerifyPurchase   ; 0x01 - $F0B2
    dw LesserChestGameGuy_AfterGameStart ; 0x02 - $F0E1
}

; $0F709C-$0F70B1 JUMP LOCATION
MiniChestGameGuy_OfferGame:
{
    LDA.w $04C4 : DEC : CMP.b #$02 : BCC .return
        ; "Pay me 20 Rupees and I'll let you open one chest. ...
        LDA.b #$7E
        LDY.b #$01
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .return
            INC.w $0D80, X

    ; $0F70B1 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; $0F70B2-$0F70DC JUMP LOCATION
MiniChestGameGuy_VerifyPurchase:
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
        LDA.b #$14
        LDY.b #$00
        JSR.w ShopKeeper_TryToGetPaid : BCC .BRANCH_ALPHA
            LDA.b #$01 : STA.w $04C4
            
            LDA.b #$7F
            LDY.b #$01  
            JSL.l Sprite_ShowMessageUnconditional
            
            INC.w $0D80, X
            
            RTS
        
    .BRANCH_ALPHA
    
    LDA.b #$80
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $0F70DD-$0F70E0 DATA
Pool_LesserChestGameGuy_AfterGameStart:
{
    ; $0F70DD
    .messages_low
    ; "You can't open any more chests. The game is over."
    ; "Oh, I see...  Too bad. Drop by again after collecting Rupees."
    db $63, $7F
    
    ; $0F70DF
    .messages_high
    db $01, $01
}

; $0F70E1-$0F70F2 JUMP LOCATION
LesserChestGameGuy_AfterGameStart:
{
    LDA.w $04C4 : TAY
    
    ; BUG: Maybe? Don't see how the second message could ever occur so far.
    LDA.w Pool_LesserChestGameGuy_AfterGameStart_messages_low, Y        : XBA
    LDA.w Pool_LesserChestGameGuy_AfterGameStart_messages_high, Y : TAY : XBA
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}

; $0F70F3-$0F7109 JUMP LOCATION
LostWoodsChestGameGuy:
{
    JSR.w NiceThief_Animate
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw LostWoodsChestGameGuy_OfferGame      ; 0x00 - $F10A
    dw LostWoodsChestGameGuy_VerifyPurchase ; 0x01 - $F120
    dw LesserChestGameGuy_AfterGameStar     ; 0x02 - $F0E1
}

; $0F710A-$0F711F JUMP LOCATION
LostWoodsChestGameGuy_OfferGame:
{
    ; BUG: Maybe? More like unnecessary given the structure of the minigame?
    LDA.w $04C4 : DEC : CMP.b #$02 : BCC MiniChestGameGuy_OfferGame_return
        ; "For 100 Rupees, I'll let you open one chest and keep the treasure..."
        LDA.b #$81
        LDY.b #$01
        JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing : BCC .didnt_speak
            INC.w $0D80, X
        
        .didnt_speak
        
        RTS
}

; $0F7120-$0F714A JUMP LOCATION
LostWoodsChestGameGuy_VerifyPurchase:
{
    LDA.w $1CE8 : BNE .player_declined
        LDA.b #$64
        LDY.b #$00
        
        JSR.w ShopKeeper_TryToGetPaid : BCC .cant_afford
            LDA.b #$01 : STA.w $04C4
            
            ; "All right! Open the chest you like!"
            LDA.b #$7F
            LDY.b #$01
            JSL.l Sprite_ShowMessageUnconditional
            
            INC.w $0D80, X
            
            RTS
        
        .cant_afford
    .player_declined
    
    ; "Oh, I see... Too bad. Drop by again after collecting Rupees."
    LDA.b #$80
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    RTS
}

; $0F714B-$0F714E JUMP LOCATION
Pool_NiceThiefUnderRock:
{
    ; $0F714B
    .messages_low
    ; "Check out the cave east of Lake Hylia. Strange and wonderful..."
    ; "You can earn a lot of Rupees by defeating enemies. It's the ..."
    db $77, $78
    
    ; $0F714D
    .messages_high
    db $01, $01
}

; $0F714F-$0F716D JUMP LOCATION
NiceThiefUnderRock:
{
    JSR.w NiceThief_Animate
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    LDA.w $0E80, X : SEC : SBC.b #$05 : TAY
    
    LDA.w Pool_NiceThiefUnderRock_messages_low, Y        : XBA
    LDA.w Pool_NiceThiefUnderRock_messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
}


; $0F716E-$0F71AC JUMP LOCATION
ShopItem_RedPotion150:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        JSL.l Sprite_GetEmptyBottleIndex : BMI .BRANCH_BETA
            LDA.b #$96
            LDY.b #$00
            
            JSR.w ShopKeeper_TryToGetPaid : BCC .player_cant_afford
                STZ.w $0DD0, X
                
                LDY.b #$2E : JSR.w ShopItem_HandleReceipt
            
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$6D
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional

    JSR.w ShopItem_PlayBeep
    
    RTS
    
    ; $0F71A1 ALTERNATE ENTRY POINT
    .player_cant_afford
    
    LDA.b #$7C
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional

    JSR.w ShopItem_PlayBeep
    
    RTS
}

; ==============================================================================

; $0F71AD-$0F71B2 DATA
ShopKeeper_SpawnInventoryItem_x_offsets:
{
    dw -44, 8, 60
}

; $0F71B3-$0F71F1 LONG JUMP LOCATION
ShopKeeper_SpawnInventoryItem:
{
    PHA : PHY
    
    LDA.b #$BB
    LDY.b #$0C
    JSL.l Sprite_SpawnDynamically_arbitrary
    
    PLA : STA.w $0E80, Y : STA.w $0BA0, Y
    
    PLA : PHX : ASL : TAX
    
    ; OPTIMIZE: Why ADC.l?
    LDA.b $00 : CLC : ADC.l .x_offsets+0, X : STA.w $0D10, Y
    LDA.b $01       : ADC.l .x_offsets+1, X : STA.w $0D30, Y
    
    LDA.b $02 : CLC : ADC.b #$27 : STA.w $0D00, Y
    LDA.b $03                    : STA.w $0D20, Y
    
    LDA.w $0E40, Y : ORA.b #$04 : STA.w $0E40, Y
    
    PLX
    
    RTL
}

; ==============================================================================

; $0F71F2-$0F7220 JUMP LOCATION
ShopItem_FighterShield:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSR.w ShopItem_MakeShieldsDeflect
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        LDA.l $7EF35A : BNE RejectShieldPurchase
            LDA.b #$32
            LDY.b #$00
            JSR.w ShopKeeper_TryToGetPaid : BCC TooPoorForAShield
                STZ.w $0DD0, X
                
                LDY.b #$04 : JSR.w ShopItem_HandleReceipt
        
    .BRANCH_ALPHA
    
    LDA.b #$1C : STA.w $0F60, X
    
    RTS
}

; $0F7221-$0F722C JUMP LOCATION
RejectShieldPurchase:
{ 
    LDA.b #$66
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional

    JSR.w ShopItem_PlayBeep
    
    RTS
}
    
; $0F722D-$0F722F JUMP LOCATION
TooPoorForAShield:
{ 
    JMP.w ShopItem_RedPotion150_player_cant_afford
}

; $0F7230-$0F7260 JUMP LOCATION
ShopItem_FireShield:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSR.w ShopItem_MakeShieldsDeflect
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        LDA.l $7EF35A : CMP.b #$02 : BCS RejectShieldPurchase
            LDA.b #$F4
            LDY.b #$01
            
            JSR.w ShopKeeper_TryToGetPaid : BCC TooPoorForAShield
                STZ.w $0DD0, X
                
                LDY.b #$05 : JSR.w ShopItem_HandleReceipt
    
    .BRANCH_ALPHA
    
    LDA.b #$1C : STA.w $0F60, X
    
    RTS
}

; ==============================================================================

; $0F7261-$0F727C LOCAL JUMP LOCATION
ShopItem_MakeShieldsDeflect:
{
    STZ.w $0BA0, X
    
    LDA.b #$08 : STA.w $0B6B, X
    
    LDA.b #$04 : STA.w $0CAA, X
    
    LDA.b #$1C : STA.w $0F60, X
    
    JSL.l Sprite_CheckDamageFromPlayerLong
    
    LDA.b #$0A : STA.w $0F60, X
    
    RTS
}

; ==============================================================================
    
; $0F727D-$0F72AE JUMP LOCATION
ShopItem_Heart:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        LDA.l $7EF36C : CMP.l $7EF36D : BEQ .BRANCH_BETA
            LDA.b #$0A
            LDY.b #$00
            
            JSR.w ShopKeeper_TryToGetPaid : BCC .BRANCH_GAMMA
                STZ.w $0DD0, X
                
                LDY.b #$42 : JSR.w ShopItem_HandleReceipt
    
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    JSR.w ShopItem_PlayBeep
    
    RTS
    
    .BRANCH_GAMMA
    
    JMP.w ShopItem_RedPotion150_player_cant_afford
}

; $0F72AF-$0F72EF JUMP LOCATION
ShopItem_Arrows:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        LDA.l $7EF371
        
        PHX
        
        TAX
        
        LDA.l HUD_CapacityUpgrades_arrows_hex, X : PLX : CMP.l $7EF377 : BEQ TooMuchAmmo
            LDA.b #$1E
            LDY.b #$00
            
            JSR.w ShopKeeper_TryToGetPaid : BCC RejectMunitionsPurchase
                STZ.w $0DD0, X
                
                LDY.b #$44 : JSR.w ShopItem_HandleReceipt
    
    .BRANCH_ALPHA
    
    RTS
}
    
; $0F72E1-$0F72EC JUMP LOCATION
TooMuchAmmo:
{
    LDA.b #$6E
    LDY.b #$01
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing

    JSR.w ShopItem_PlayBeep
    
    RTS
}

; $0F72ED-$0F72EF JUMP LOCATION
RejectMunitionsPurchase:
{
    JMP.w ShopItem_RedPotion150_player_cant_afford
}

; $0F72F0-$0F7321 JUMP LOCATION
ShopItem_Bombs:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        LDA.l $7EF370 : PHX
        
        TAX
        
        LDA.l HUD_CapacityUpgrades_bombs_hex, X
        
        PLX
        
        CMP.l $7EF343 : BEQ TooMuchAmmo
            LDA.b #$32
            LDY.b #$00
            
            JSR.w ShopKeeper_TryToGetPaid : BCC RejectMunitionsPurchase
                STZ.w $0DD0, X
                
                LDY.b #$31 : JSR.w ShopItem_HandleReceipt
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F7322-$0F7357 JUMP LOCATION
ShopItem_Bee:
{
    JSR.w ShopKeeper_DrawItemWithPrice
    JSR.w Sprite3_CheckIfActive
    JSL.l Sprite_PlayerCantPassThrough
    
    JSR.w ShopKeeper_CheckPlayerSolicitedDamage : BCC .BRANCH_ALPHA
        JSL.l Sprite_GetEmptyBottleIndex : BMI .BRANCH_BETA
            LDA.b #$0A
            LDY.b #$00
            
            JSR.w ShopKeeper_TryToGetPaid : BCC .BRANCH_GAMMA
                STZ.w $0DD0, X
                
                LDY.b #$0E : JSR.w ShopItem_HandleReceipt
        
    .BRANCH_ALPHA
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$6D
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional

    JSR.w ShopItem_PlayBeep
    
    RTS
    
    .BRANCH_GAMMA
    
    JMP.w ShopItem_RedPotion150_player_cant_afford
}

; ==============================================================================

; $0F7358-$0F7365 DATA
Pool_ShopItem_HandleReceipt:
{
    ; $0F7358
    .message_ids_low
    db $68, $67, $67, $6C, $69, $6A, $6B
    
    ; $0F735F
    .message_ids_high
    db $01, $01, $01, $01, $01, $01, $01
}

; Subroutine grants the player an item parameterized by the A register.
; $0F7366-$0F7389 LOCAL JUMP LOCATION
ShopItem_HandleReceipt:
{
    STZ.w $02E9
    
    PHX
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    LDA.w $0E80, X : SEC : SBC.b #$07 : BMI .BRANCH_ALPHA
        TAY
        
        LDA.w Pool_ShopItem_HandleReceipt_message_ids_low, Y  :       XBA
        LDA.w Pool_ShopItem_HandleReceipt_message_ids_high, Y : TAY : XBA
        JSL.l Sprite_ShowMessageUnconditional

        JSL.l ShopKeeper_RapidTerminateReceiveItem
    
    .BRANCH_ALPHA
    
    RTS
}

; $0F738A-$0F7390 LOCAL JUMP LOCATION
ShopItem_PlayBeep:
{
    LDA.b #$3C : JSL.l Sound_SetSfx2PanLong
    
    RTS
}

; ==============================================================================

; $0F7391-$0F739D LOCAL JUMP LOCATION
ShopKeeper_CheckPlayerSolicitedDamage:
{
    LDA.b $F6 : BPL .the_a_button_not_pressed
        ; TODO: The BCC branch seems kind of .... useless. Maybe there was
        ; some other code dummied out?
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_contact
            RTS
        
        .no_player_contact
    .the_a_button_not_pressed
    
    CLC
    
    RTS
}

; ==============================================================================

; $0F739E-$0F73B5 LOCAL JUMP LOCATION
ShopKeeper_TryToGetPaid:
{
    STA.b $00
    STY.b $01
    
    REP #$20
    
    LDA.l $7EF360 : CMP $00 : BCC .player_cant_afford
        SBC.b $00 : STA.l $7EF360
        
        SEC
    
    .player_cant_afford
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0F73B6-$0F74CD DATA
ShopKeeper_DrawItemWithPrice_OAM_groups:
{
    dw -4, 16 : db $31, $02, $00, $00
    dw  4, 16 : db $13, $02, $00, $00
    dw 12, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $C0, $02, $00, $02
    dw  0, 11 : db $6C, $03, $00, $02
    
    dw  0, 16 : db $13, $02, $00, $00
    dw  0, 16 : db $13, $02, $00, $00
    dw  8, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $CE, $04, $00, $02
    dw  4, 12 : db $38, $03, $00, $00
    
    dw -4, 16 : db $13, $02, $00, $00
    dw  4, 16 : db $30, $02, $00, $00
    dw 12, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $CC, $08, $00, $02
    dw  4, 12 : db $38, $03, $00, $00
    
    dw  0, 16 : db $31, $02, $00, $00
    dw  0, 16 : db $31, $02, $00, $00
    dw  8, 16 : db $30, $02, $00, $00
    dw  4,  8 : db $29, $03, $00, $00
    dw  4, 11 : db $38, $03, $00, $00
    
    dw -4, 16 : db $03, $02, $00, $00
    dw -4, 16 : db $03, $02, $00, $00
    dw  4, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $C4, $04, $00, $02
    dw  0, 11 : db $38, $03, $00, $00
    
    dw  0, 16 : db $13, $02, $00, $00
    dw  0, 16 : db $13, $02, $00, $00
    dw  8, 16 : db $30, $02, $00, $00
    dw  0,  0 : db $E8, $04, $00, $02
    dw  0, 11 : db $6C, $03, $00, $02
    
    db  0, 16 : db $31, $02, $00, $00
    db  0, 16 : db $31, $02, $00, $00
    db  8, 16 : db $30, $02, $00, $00
    db  4,  8 : db $F4, $0F, $00, $00
    db  4, 11 : db $38, $03, $00, $00
}

; $0F74CE-$0F74F2 LOCAL JUMP LOCATION
ShopKeeper_DrawItemWithPrice:
{
    LDA.w $0E80, X : SEC : SBC.b #$07
    REP #$20
    AND.w #$00FF : STA.b $00

    ASL #2 : ADC.b $00 : ASL #3
    ADC.w #.OAM_groups : STA.b $08
    
    LDA.w #$0005 : STA.b $06
    
    SEP #$30
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================
