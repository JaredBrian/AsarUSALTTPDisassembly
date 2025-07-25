; ==============================================================================

; $034309-$034318 DATA
Pool_Sprite_WishPond:
{
    ; $034309
    .x_offsets
    db 0,  4,  8, 12, 16, 20, 24, 00
    
    ; $034311
    .y_offsets
    db 0,  8, 16, 24, 32, 40,  4, 36
}

; Pond of Wishing AI
; $034319-$0343AA JUMP LOCATION
Sprite_WishPond:
{
    LDA.w $0D90, X : BNE .BRANCH_ALPHA
        LDA.w $0DA0, X : BNE .BRANCH_BETA
            JSR.w Sprite_PrepOamCoordSafeWrapper
            JMP.w FairyPondTriggerMain
        
        .BRANCH_BETA
        
        JSR.w FairyQueen_Draw
        
        LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
        
        LDA.b $1A : AND.b #$0F : BNE .BRANCH_GAMMA
            LDA.b #$72
            JSL.l Sprite_SpawnDynamically : BMI .BRANCH_GAMMA
                PHX
                
                JSL.l GetRandomInt : AND.b #$07 : TAX
                LDA.b $00
                CLC : ADC Pool_Sprite_WishPond_x_offsets, X : STA.w $0D10, Y
                LDA.b $01 : ADC.b #$00                      : STA.w $0D30, Y
                
                JSL.l GetRandomInt : AND.b #$07 : TAX
                LDA.b $02
                CLC : ADC Pool_Sprite_WishPond_y_offsets, X : STA.w $0D00, Y
                LDA.b $03 : ADC.b #$00                      : STA.w $0D20, Y
                
                LDA.b #$1F : STA.w $0DB0, Y
                             STA.w $0D90, Y
                
                JSR.w Sprite_ZeroOamAllocation
                
                LDA.b #$48 : STA.w $0E60, Y
                
                AND.b #$0F : STA.w $0F50, Y
                
                LDA.b #$01 : STA.w $0DA0, Y
                
                PLX
        
        .BRANCH_GAMMA
        
        RTS
        
    .BRANCH_ALPHA
    
    DEC.w $0DB0, X : BNE .BRANCH_DELTA
        STZ.w $0DD0, X
    
    .BRANCH_DELTA
    
    LDA.w $0DB0, X : LSR #3 : STA.w $0DC0, X
    
    LDA.b #$04
    JSL.l OAM_AllocateFromRegionC
    
    JSR.w Sprite_PrepAndDrawSingleSmall
    
    RTS
}

; ==============================================================================

; $0343AB-$03441C DATA
FairyPond_TossGFXID:
{
    ; Gets stored into $0DC0
    ; $0343AB
    .Items
    .bow
    db $3A ; Regular bow with and without arrows
    db $3A ; Regular bow with and without arrows
    db $3B ; Silver arrows Bow with and without arrows
    db $3B ; Silver arrows Bow with and without arrows

    ; $0343AF
    .boomerang
    db $0C ; Blue
    db $2A ; Red

    ; $0343B1
    .hookshot
    db $0A

    ; $0343B2
    .bombs
    db $27

    ; $0343B3
    .mushroom
    db $29 ; Mushroom
    db $0D ; Magic powder

    ; $0343B5
    .fire_rod
    db $07

    ; $0343B6
    .ice_rod
    db $08

    ; $0343B7
    .bombos
    db $0F

    ; $0343B8
    .ether
    db $10

    ; $0343B9
    .quake
    db $11

    ; $0343BA
    .lamp
    db $12

    ; $0343BB
    .hammer
    db $09

    ; $0343BC
    .flute
    db $13 ; Shovel
    db $14 ; Inactive flute
    db $4A ; Active flute

    ; $0343BF
    .net
    db $21

    ; $0343C0
    .book
    db $1D

    ; $0343C1
    .somaria
    db $15

    ; $0343C2
    .byrna
    db $18

    ; $0343C3
    .cape
    db $19

    ; $0343C4
    .mirror
    db $31 ; Map
    db $1A ; Mirror
    db $1A ; Mirror (triforce)

    ; $0343C7
    .gloves
    db $1B ; Power glove
    db $1C ; Titan's mitt

    ; $0343C9
    .boots
    db $4B

    ; $0343CA
    .flippers
    db $1E

    ; $0343CB
    .pearl
    db $1F

    ; $0343CC
    .sword
    db $49 ; Sword 1
    db $01 ; Master Sword
    db $02 ; Sword 3
    db $03 ; Sword 4

    ; $0343D0
    .shield
    db $04 ; Shield 1
    db $05 ; Shield 2
    db $06 ; Mirror Shield

    ; $0343D3
    .armor
    db $22 ; Blue Mail
    db $23 ; Red Mail

    ; $0343D5
    .bottles
    db $29 ; Unused Bottle Mushroom
    db $16 ; Empty Bottle
    db $2B ; Red Potion
    db $2C ; Green Potion
    db $2D ; Blue Potion
    db $3D ; Fairy in Bottle
    db $3C ; Bee in Bottle
    db $48 ; Golden Bee in Bottle
    
    ; $0343DD
    .ItemPointer
    dw .bow-1
    dw .boomerang-1
    dw .hookshot-1
    dw .bombs-1
    dw .mushroom-1
    dw .fire_rod-1
    dw .ice_rod-1
    dw .bombos-1
    dw .ether-1
    dw .quake-1
    dw .lamp-1
    dw .hammer-1
    dw .flute-1
    dw .net-1
    dw .book-1
    dw .somaria-1
    dw .somaria-1
    dw .byrna-1
    dw .cape-1
    dw .mirror-1
    dw .gloves-1
    dw .boots-1
    dw .flippers-1
    dw .pearl-1
    dw .sword-1
    dw .sword-1
    dw .shield-1
    dw .armor-1
    dw .bottles-1
    dw .bottles-1
    dw .bottles-1
    dw .bottles-1   
}

; ==============================================================================

; $03441D-$03444B LOCAL JUMP LOCATION
FairyPondTriggerMain:
{
    JSR.w SpriteDraw_FairyPondItem
    JSR.w Sprite_CheckIfActive
    
    LDA.b $A0 : CMP.b #$15 : BEQ Sprite_HappinessPond
        LDA.w $0D80, X
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw WaitingForPlayerContact ; 0x00 - $C7A1
        dw DecideToThrowItemOrNot  ; 0x01 - $C7C6
        dw SpawnThrownItem         ; 0x02 - $C7ED
        dw WaitToSpawnGreatFairy   ; 0x03 - $C83C
        dw FairyFadeIn             ; 0x04 - $C88B
        dw DecideToDrop            ; 0x05 - $C8B7
        dw YesIThrewIt             ; 0x06 - $C8C6
        dw SetupFadeOut            ; 0x07 - $C952
        dw FairyFadeOut            ; 0x08 - $C97A
        dw GiveItemBack            ; 0x09 - $C9A1
        dw ShowNewItemMessage      ; 0x0A - $C9C8
        dw NopeNotMine             ; 0x0B - $C9E5
        dw OkayYeahItIsMine        ; 0x0C - $C9F1
        dw StillNotMine            ; 0x0D - $CA00
}

; ==============================================================================

; The happiness pond.
; $03444C-$034470 BRANCH LOCATION
Sprite_HappinessPond:
{
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FairyPond_WaitForLink             ; 0x00 - $C4FD
    dw LakeHyliaFairy_WaitForLink        ; 0x01 - $C52B
    dw LakeHyliaFairy_BegForDonation     ; 0x02 - $C570
    dw LakeHyliaFairy_AcceptDonation     ; 0x03 - $C59F
    dw LakeHyliaFairy_WaitForDonation    ; 0x04 - $C603
    dw LakeHyliaFairy_SpawnFairy         ; 0x05 - $C616
    dw LakeHyliaFairy_Greetings          ; 0x06 - $C665
    dw LakeHyliaFairy_OfferUpgrade       ; 0x07 - $C691
    dw LakeHyliaFairy_UpgradeBombs       ; 0x08 - $C6A0
    dw LakeHyliaFairy_RevertTranslucency ; 0x09 - $C6D2
    dw LakeHyliaFairy_DeleteFairy        ; 0x0A - $C6E7
    dw LakeHyliaFairy_RestoreAndReset    ; 0x0B - $C70E
    dw LakeHyliaFairy_UpgradeArrows      ; 0x0C - $C721
    dw LakeHyliaFairy_GiveDonationStatus ; 0x0D - $C763
    dw HappinessPond_GrantLuckStatus     ; 0x0E - $C77B
}

; ==============================================================================

; $034471-$0344B4 DATA
Pool_SpriteDraw_FairyPondItem:
{
    ; $034471
    dw 32, -64 : db $24, $00, $00, $00
    dw 32, -56 : db $34, $00, $00, $00
    dw 32, -64 : db $24, $00, $00, $00
    dw 32, -56 : db $34, $00, $00, $00
    
    ; $034491
    dw 32, -64 : db $24, $00, $00, $02
    dw 32, -64 : db $24, $00, $00, $02
    dw 32, -64 : db $24, $00, $00, $02
    dw 32, -64 : db $24, $00, $00, $02
    
    ; $0344B1
    .OAM_group_pointers
    dw $C471, $C491
}

; $0344B5-$0344FC LOCAL JUMP LOCATION
SpriteDraw_FairyPondItem:
{
    ; No items returned at happiness pond.
    LDA.b $A0 : CMP.b #$15 : BEQ .return
        LDA.w $0D80, X : CMP.b #$05 : BEQ .show_returned_item
                         CMP.b #$06 : BEQ .show_returned_item
                         CMP.b #$0B : BEQ .show_returned_item
                         CMP.b #$0C : BEQ .show_returned_item
            BRA .return
    
        .show_returned_item
        
        PHX : TXY
        
        LDA.w $0DC0, Y : TAX
        LDA.w AddReceiveItem_properties, X : CMP.b #$FF : BNE .valid_upper_properties
            ; HARDCODED
            ; Force to use palette 5. This only applies to the master sword
            ; anyways.
            LDA.b #$05
            
        .valid_upper_properties
        
        AND.b #$07 : ASL : STA.w $0F50, Y
        
        LDA.w AddReceiveItem_wide_item_flag, X : TAY
        LDA.w Pool_SpriteDraw_FairyPondItem_OAM_group_pointers+0, Y : STA.b $08
        LDA.w Pool_SpriteDraw_FairyPondItem_OAM_group_pointers+1, Y : STA.b $09
        
        LDA.b #$04
        
        PLX
        
        JSL.l Sprite_DrawMultiple
    
    .return
    
    RTS
}

; ==============================================================================

; $0344FD-$034522 JUMP LOCATION
FairyPond_WaitForLink:
{
    STZ.w $02E4
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .BRANCH_ALPHA
            LDA.b #$89
            LDY.b #$00           
            JSL.l Sprite_ShowMessageFromPlayerContact : BCC .BRANCH_ALPHA
                INC.w $0D80, X
                
                JSL.l Player_ResetState
                JSL.l Ancilla_TerminateSparkleObjects
                
                STZ.b $2F

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $034523-$03452A DATA
FairyPond:
{
    ; $034523
    .prices
    db 5, 20, 25, 50
    
    ; (binary coded decimal used for display in dialogue system).
    ; $034527
    .bcd_prices
    db $05, $20, $25, $50
}

; $03452B-$03455C JUMP LOCATION
LakeHyliaFairy_WaitForLink:
{
    LDA.w $1CE8 : BNE FairyPond_ResetAI_negatory
        LDA.l $7EF370 : ORA.l $7EF371 : BEQ .no_bomb_or_arrow_upgrades_yet
            LDA.b #$02
        
        .no_bomb_or_arrow_upgrades_yet
        
        STA.w $0DC0, X
        TAY
        LDA.w FairyPond_bcd_prices+0, Y : STA.w $1CF2
        LDA.w FairyPond_bcd_prices+1, Y : STA.w $1CF3
        
        LDA.b #$4E
        LDY.b #$01
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
        
        LDA.b #$01 : STA.w $02E4
        
        RTS
}

; ==============================================================================

; $03455D-$03456F LOCAL JUMP LOCATION
FairyPond_ResetAI:
{
    SEP #$30
    
    ; $03455F ALTERNATE ENTRY POINT
    .negatory
    
    LDA.b #$4C
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; $034570-$03459E JUMP LOCATION
LakeHyliaFairy_BegForDonation:
{
    LDA.w $1CE8 : CLC : ADC.w $0DC0, X : TAY
    LDA.w FairyPond_bcd_prices, Y : STA.w $1CF3
    
    REP #$20
    
    LDA.w FairyPond_prices, Y : AND.w #$00FF : STA.b $00
    
    LDA.l $7EF360 : CMP.b $00 : BCC FairyPond_ResetAI
        SEP #$30
        
        LDA.b $00 : STA.w $0DE0, X
        
        TYA : STA.w $0EB0, X
        
        INC.w $0D80, X
        
        RTS
}

; $03459F-$034602 JUMP LOCATION
LakeHyliaFairy_AcceptDonation:
{
    LDA.b #$50 : STA.w $0DF0, X
    
    LDA.w $0DE0, X : STA.b $00
                     STZ.b $01
    
    REP #$20
    
    LDA.l $7EF360 : SEC : SBC.b $00 : STA.l $7EF360
    
    SEP #$30
    
    LDA.l $7EF36A : CLC : ADC.b $00 : STA.l $7EF36A
    
    PHX
    
    LDA.w $0EB0, X
    JSL.l AddHappinessPondRupees
    
    PLX
    
    LDA.l $7EF36A : CMP.b #$64 : BCC .BRANCH_ALPHA
        SBC.b #$64 : STA.l $7EF36A
        
        LDA.b #$05 : STA.w $0D80, X
        
        RTS
        
    .BRANCH_ALPHA
    
    LDA.l $7EF36A
    
    STZ.b $02
    
    .BRANCH_GAMMA
    
        CMP.b #$0A : BCC .BRANCH_BETA
            SBC.b #$0A
            
            INC.b $02
    BRA .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    ASL.b $02 : ASL.b $02 : ASL.b $02 : ASL.b $02 : ORA.b $02 : STA.w $1CF2
    
    INC.w $0D80, X
    
    RTS
}

; $034603-$034615 JUMP LOCATION
LakeHyliaFairy_WaitForDonation:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.b #$94
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        LDA.b #$0D : STA.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $034616-$034664 JUMP LOCATION
LakeHyliaFairy_SpawnFairy:
{
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$72
        JSL.l Sprite_SpawnDynamically
        
        LDA.b #$1B : STA.w $012C
        
        STZ.w $0133
        
        LDA.b $00 : SEC : SBC.w FairyPondFairy_x_offset : STA.w $0D10, Y
        LDA.b $01       : SBC.b #$00                    : STA.w $0D30, Y
        
        LDA.b $02 : SEC : SBC.w FairyPondFairy_y_offset : STA.w $0D00, Y
        LDA.b $03       : SBC.b #$00                    : STA.w $0D20, Y
        
        LDA.b #$01 : STA.w $0DA0, Y
        
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        PHX
        
        JSL.l Palette_AssertTranslucencySwap
        JSL.l PaletteFilter_WishPonds
        
        PLX
        
        TYA : STA.w $0E90, X
    
    .delay
    
    RTS
}

; $034665-$034690 JUMP LOCATION
LakeHyliaFairy_Greetings:
{
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_ALPHA
        PHX
        
        JSL.l Palette_Filter_SP5F
        
        PLX
        
        LDA.l $7EC007 : BNE .BRANCH_ALPHA
            INC.w $0D80, X
            
            LDA.b #$95
            LDY.b #$00
            JSL.l Sprite_ShowMessageUnconditional
            
            PHX
            
            JSL.l Palette_RevertTranslucencySwap
            
            STZ.b $1D
            
            LDA.b #$20 : STA.b $9A
            
            INC.b $15
            
            PLX
    
    .BRANCH_ALPHA
    
    RTS
}

; $034691-$03469F JUMP LOCATION
LakeHyliaFairy_OfferUpgrade:
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
        INC.w $0D80, X
        
        RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$0C : STA.w $0D80, X
    
    RTS
}

; $0346A0-$0346D1 JUMP LOCATION
LakeHyliaFairy_UpgradeBombs:
{
    INC.w $0D80, X
    
    LDA.l $7EF370 : CMP.b #$07 : BEQ .BRANCH_ALPHA
        INC : STA.l $7EF370
        
        PHX
        
        TAX
        LDA.l HUD_CapacityUpgrades_bombs_bcd, X : STA.w $1CF2
                                                  STA.l $7EF375
        
        PLX
        
        LDA.b #$96
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$98
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional

    JMP.w LakeHyliaFairy_RefundRupees
}

; $0346D2-$0346E6 JUMP LOCATION
LakeHyliaFairy_RevertTranslucency:
{
    INC.w $0D80, X
    
    PHX
    
    JSL.l Palette_AssertTranslucencySwap
    
    LDA.b #$02 : STA.b $1D
    LDA.b #$30 : STA.b $9A
    
    INC.w $0015
    
    PLX
    
    RTS
}

; $0346E7-$03470D JUMP LOCATION
LakeHyliaFairy_DeleteFairy:
{
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_ALPHA
        PHX
        
        JSL.l Palette_Filter_SP5F
        
        PLX
        
        LDA.l $7EC007 : CMP.b #$1E : BNE .BRANCH_BETA
            LDA.w $0E90, X : TAY
            LDA.b #$00 : STA.w $0DD0, Y
            
            BRA .BRANCH_ALPHA
        
        .BRANCH_BETA
        
        CMP.b #$00 : BNE .BRANCH_ALPHA
            INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $03470E-$034720 JUMP LOCATION
LakeHyliaFairy_RestoreAndReset:
{
    PHX
    
    JSL.l Palette_Restore_SP5F
    JSL.l Palette_RevertTranslucencySwap
    
    PLX
    
    STZ.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; $034721-$034751 JUMP LOCATION
LakeHyliaFairy_UpgradeArrows:
{
    LDA.b #$09 : STA.w $0D80, X
    
    LDA.l $7EF371 : CMP.b #$07 : BEQ .BRANCH_ALPHA
        INC : STA.l $7EF371
        
        PHX
        
        TAX
        
        LDA.l HUD_CapacityUpgrades_arrows_bcd, X : STA.w $1CF2
                                                   STA.l $7EF376
        
        PLX
        
        LDA.b #$97
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$98
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional

    ; Bleeds into the next function.
}

; $034752-$034762 LOCAL JUMP LOCATION
LakeHyliaFairy_RefundRupees:
{
    REP #$20
    
    LDA.l $7EF360 : CLC : ADC.w #$0064 : STA.l $7EF360
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $034763-$03476E JUMP LOCATION
LakeHyliaFairy_GiveDonationStatus:
{
    LDA.b #$54
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $03476F-$03477A DATA
Pool_HappinessPond_GrantLuckStatus:
{
    ; $03476F
    .message_ids_lower
    db $50, $51, $52, $53
    
    ; $034773
    .message_ids_upper
    db $01, $01, $01, $01
    
    ; $034777
    .luck_statuses
    db 1, 0, 0, 2
}

; $03477B-$0347A0 JUMP LOCATION
HappinessPond_GrantLuckStatus:
{
    JSL.l GetRandomInt : AND.b #$03 : TAY
    LDA.w Pool_HappinessPond_GrantLuckStatus_luck_statuses, Y : STA.w $0CF9
                                                                STZ.w $0CFA
    
    LDA.w Pool_HappinessPond_GrantLuckStatus_message_ids_lower, Y       : XBA
    LDA.w Pool_HappinessPond_GrantLuckStatus_message_ids_upper, Y : TAY : XBA
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $0347A1-$0347C5 JUMP LOCATION
WaitingForPlayerContact:
{
    STZ.w $02E4
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .BRANCH_ALPHA
            ; -Mysterious Pond- Won't you throw something in?
            LDA.b #$4A
            LDY.b #$01
            JSL.l Sprite_ShowMessageFromPlayerContact : BCC .BRANCH_ALPHA
                INC.w $0D80, X
                
                JSL.l Player_ResetState
                
                STZ.b $2F
                STZ.w $0EB0, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0347C6-$0347EC JUMP LOCATION
DecideToThrowItemOrNot:
{
    ; If the player selected
    LDA.w $1CE8 : BNE .dontDoIt
        ; Do it.
        ; "Select an item using the Control Pad and throw it using the [Y]
        ; Button."
        LDA.b #$8A
        LDY.b #$00
        JSL.l Sprite_ShowMessageUnconditional
        
        INC.w $0D80, X
        
        LDA.b #$01 : STA.w $02E4
        
        RTS
    
    .dontDoIt
    
    ; "Don't do it!"
    LDA.b #$4B
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    ; Go back to waiting for contact.
    STZ.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; $0347ED-$034839 JUMP LOCATION
SpawnThrownItem:
{
    INC.w $0D80, X : PHX
    
    ; Get the item selected.
    LDA.w $1CE8 : STA.w $0DB0, X
                  TAX
    ASL         : TAY
    LDA.w FairyPond_TossGFXID_ItemPointer+0, Y : STA.b $00
    LDA.w FairyPond_TossGFXID_ItemPointer+1, Y : STA.b $01
    
    ; Save the state of the selected item.
    LDA.l $7EF340, X : PHA
    
    CPX.b #$20 : BEQ .BRANCH_ALPHA
        CPX.b #$03 : BNE .BRANCH_BETA

    .BRANCH_ALPHA
    
    LDA.b #$01
    
    .BRANCH_BETA
    
    TAY
    
    LDA.b #$00 : STA.l $7EF340, X
    
    ; Get the item from the pointer.
    LDA.b ($00), Y : PHA
                     TAX
    
    LDY.b #$04
    LDA.b #$28
    JSL.l AddWishPondItem

    JSL.l HUD_RefreshIconLong
    
    PLA : PLY : PLX
    
    ; Save the item.
    STA.w $0DC0, X
    
    TYA : STA.w $0DE0, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $03483A-$03483B DATA
FairyPondFairy:
{
    ; WTF: Why not just use immediates for this instead of a data pool? It's
    ; not indexed.
    ; $03483A
    .x_offset
    db $00
    
    ; $03483B
    .y_offset
    db $50
}

; ==============================================================================

; $03483C-$03488A JUMP LOCATION
WaitToSpawnGreatFairy:
{
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$72
        JSL.l Sprite_SpawnDynamically
        
        LDA.b #$1B : STA.w $012C
        
        STZ.w $0133
        
        LDA.b $00 : SEC : SBC.w FairyPondFairy_x_offset : STA.w $0D10, Y
        LDA.b $01       : SBC.b #$00                    : STA.w $0D30, Y
        
        LDA.b $02 : SEC : SBC.w FairyPondFairy_y_offset : STA.w $0D00, Y
        LDA.b $03       : SBC.b #$00                    : STA.w $0D20, Y
        
        LDA.b #$01 : STA.w $0DA0, Y
        
        INC.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        PHX
        
        JSL.l Palette_AssertTranslucencySwap
        JSL.l PaletteFilter_WishPonds
        
        PLX
        
        TYA : STA.w $0E90, X
        
    .delay
    
    RTS
}

; $03488B-$0348B6 JUMP LOCATION
FairyFadeIn:
{
    ; Every 8th frame fade in.
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_ALPHA
        PHX
        
        JSL.l Palette_Filter_SP5F
        
        PLX
        
        ; If completely faded in:
        LDA.l $7EC007 : BNE .BRANCH_ALPHA
            INC.w $0D80, X
            
            ; "Hello there.  Did you drop this?"
            LDA.b #$8B
            LDY.b #$00
            JSL.l Sprite_ShowMessageUnconditional
            
            PHX
            
            JSL.l Palette_RevertTranslucencySwap
            
            STZ.b $1D
            
            LDA.b #$20 : STA.b $9A
            
            INC.b $15
        
            PLX
        
    .BRANCH_ALPHA
    
    RTS
}

; $0348B7-$0348C5 JUMP LOCATION
DecideToDrop:
{
    ; If player selected "Yes"
    LDA.w $1CE8 : BNE .wasntMe
        INC.w $0D80, X
        
        RTS
    
    .wasntMe
    
    LDA #$0B : STA.w $0D80, X
    
    RTS
}

; $0348C6-$034951 JUMP LOCATION
YesIThrewIt:
{
    INC.w $0D80, X
    
    ; Are we in the dark world?
    LDA.l $7EF3CA : BNE .InDarkWorld
        ; Figure out which item it is:
        ; Is it the blue boomerang?
        LDA.w $0DC0, X : CMP.b #$0C : BNE .NotBlueBoomerang
            ; Give back the red boomerang.
            LDA.b #$2A : STA.w $0DC0, X
            
            ; Store the value for the new item message.
            LDA.b #$01 : STA.w $0EB0, X
            
            BRA .GiveNewItem
            
        .NotBlueBoomerang
        
        ; Is it shield 1?
        CMP.b #$04 : BNE .NotShield1
            ; Give shield 2.
            LDA.b #$05 : STA.w $0DC0, X

            ; Store the value for the new item message.
            LDA.b #$02 : STA.w $0EB0, X
            
            BRA .GiveNewItem
        
        .NotShield1
        
        ; Is it an empty bottle?
        CMP #$16 : BNE .NotEmptyBottle1
            ; Give green potion.
            LDA.b #$2C : STA.w $0DC0, X

            ; Store the value for the new item message.
            LDA.b #$03 : STA.w $0EB0, X
            
            BRA .GiveNewItem
        
        .NotEmptyBottle1
        
        BRA .GiveItemBack
        
    .InDarkWorld
    
    ; Is it the bow?
    LDA.w $0DC0, X : CMP.b #$3A : BNE .NotBow
        ; Give silver arrows.
        LDA.b #$3B : STA.w $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$04 : STA.w $0EB0, X
        
        ; "You are an honest person. I like you. I will give you something
        ; important... These are the Silver Arrows. To give Ganon his last
        ; moment, you definitely need them!  I know I don't quite have the
        ; figure of a fairy. Ganon's cruel power is to blame! You must defeat
        ; Ganon!"
        LDA.b #$4F
        LDY.b #$01
        JSL.l Sprite_ShowMessageUnconditional
        
        RTS
    
    .NotBow
    
    ; Is it the tempered sword?
    CMP.b #$02 : BNE .NotSword3
        ; Give sword 4.
        LDA.b #$03 : STA.w $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$05 : STA.w $0EB0, X
        
        BRA .GiveNewItem
    
    .NotSword3
    
    ; Is it an empty bottle?
    CMP #$16 : BNE .NotEmptyBottle2
        ; Give green potion.
        LDA.b #$2C : STA.w $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$03 : STA.w $0EB0, X
        
        BRA .GiveNewItem
    
    .NotEmptyBottle2
    
    BRA .GiveItemBack

    .GiveNewItem
    
    ; I like an honest person. I will give you something better in return.
    LDA.b #$8C
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
    
    .GiveItemBack
    
    ; I will give this back to you then.  Don't drop it again.
    LDA.b #$4D
    LDY.b #$01
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
}

; $034952-$034979 JUMP LOCATION
SetupFadeOut:
{
    LDA.w $0DE0, X : TAY
    
    LDA.w $0DB0, X
    
    PHX
    
    TAX
    
    TYA
    
    ; If its bombs don't give it back?
    ; Probably because we wouldn't want to replace the amount you have?
    CPX.b #$03 : BNE .BRANCH_ALPHA
        STA.l $7EF340, X
    
    .BRANCH_ALPHA
    
    PLX
    
    INC.w $0D80, X
    
    PHX
    
    JSL.l Palette_AssertTranslucencySwap
    
    LDA.b #$02 : STA.b $1D
    
    LDA.b #$30 : STA.b $9A
    
    INC.w $0015
    
    PLX
    
    RTS
}

; $03497A-$0349A0 JUMP LOCATION
FairyFadeOut:
{
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_ALPHA
        PHX
        
        JSL.l Palette_Filter_SP5F
        
        PLX
        
        LDA.l $7EC007 : CMP.b #$1E : BNE .BRANCH_BETA
            LDA.w $0E90, X : TAY
        
            LDA.b #$00 : STA.w $0DD0, Y
        
            BRA .BRANCH_ALPHA
        
        .BRANCH_BETA
        
        CMP.b #$00 : BNE .BRANCH_ALPHA
            INC.w $0D80, X
    
    .BRANCH_ALPHA
    
    RTS
}

; $0349A1-$0349BD JUMP LOCATION
GiveItemBack:
{
    INC.w $0D80, X
    
    PHX
    
    JSL.l Palette_Restore_SP5F
    JSL.l Palette_RevertTranslucencySwap
    
    PLX
    PHX
    
    LDA.b #$02 : STA.w $02E9
    
    LDA.w $0DC0, X : TAY
    JSL.l Link_ReceiveItem
    
    PLX
    
    RTS
}

; ==============================================================================

; $0349BE-$0349C7 DATA
Pool_ShowNewItemMessage:
{
    ; $0349BE
    .message_ids_low
    db $8F, $90, $92, $91, $93
    
    ; $0349C3
    .message_ids_high
    db $00, $00, $00, $00, $00

    ; 0x008F - You got the Magical Boomerang! You can throw this faster and
    ;          farther than your old one!
    ; 0x0090 - Your shield is improved! Now you can defend yourself against
    ;          fireballs!
    ; 0x0091 - These are the Silver Arrows you need to defeat Ganon!
    ; 0x0092 - She filled your bottle with the Medicine Of Magic.  To get such
    ;          a potion free is quite a bargain!
    ; 0x0093 - Your sword is stronger! You can feel its power throbbing in your
    ;          hand!
}

; $0349C8-$0349E4 JUMP LOCATION
ShowNewItemMessage:
{
    ; Check if we need to show a new item message:
    LDA.w $0EB0, X : BEQ .NotNewItem
        DEC : TAY
        LDA.w Pool_ShowNewItemMessage_message_ids_low, Y        : XBA
        LDA.w Pool_ShowNewItemMessage_message_ids_high, Y : TAY : XBA
        JSL.l Sprite_ShowMessageUnconditional
    
    .NotNewItem
    
    ; Reset AI Stage.
    STZ.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $0349E5-$0349F0 JUMP LOCATION
NopeNotMine:
{
    INC.w $0D80, X
    
    ; "Are you sure this is not yours? > Really, it isn't To tell the truth, it
    ; is"
    LDA.b #$8D
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
}

; ==============================================================================

; $0349F1-$0349FF JUMP LOCATION
OkayYeahItIsMine:
{
    LDA.w $1CE8 : BNE .StillNotMine
        INC.w $0D80, X
        
        RTS
    
    .StillNotMine
    
    ; Go to YesIThrewIt.
    LDA.b #$06 : STA.w $0D80, X
    
    RTS
}

; $034A00-$034A0D JUMP LOCATION
StillNotMine:
{
    ; "Now,  now, don't tell me a lie. Please take it back."
    LDA.b #$8E
    LDY.b #$00
    JSL.l Sprite_ShowMessageUnconditional
    
    LDA.b #$07 : STA.w $0D80, X
    
    RTS
}

; ==============================================================================

; $034A0E-$034B25 DATA
Pool_FairyQueen_Draw:
{
    ; $034A0E
    .x_offsets
    db  0, 16,  0,  8, 16, 24,  0,  8
    db 16, 24,  0, 16,  0, 16,  0,  8
    db 16, 24,  0,  8, 16, 24,  0, 16
    
    ; $034A26
    .y_offsets
    db  0,  0, 16, 16, 16, 16, 24, 24
    db 24, 24, 32, 32,  0,  0, 16, 16
    db 16, 16, 24, 24, 24, 24, 32, 32
    
    ; $034A3E
    .chr
    db $C7, $C7, $CF, $CA, $CA, $CF, $DF, $DA
    db $DA, $DF, $CB, $CB, $CD, $CD, $C9, $CA
    db $CA, $C9, $D9, $DA, $DA, $D9, $CB, $CB
    
    ; $034A56
    .properties
    db $00, $40, $00, $00, $40, $40, $00, $00
    db $40, $40, $00, $40, $00, $40, $00, $00
    db $40, $40, $00, $00, $40, $40, $00, $40
    
    ; $034A6E
    .OAM_sizes
    db $02, $02, $00, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $00, $00
    db $00, $00, $00, $00, $00, $00, $02, $02
    
    ; $034A86
    .OAM_groups
    dw  0,  0 : db $E9, $00, $00, $02
    dw 16,  0 : db $E9, $40, $00, $02
    dw  0,  0 : db $E9, $00, $00, $02
    dw 16,  0 : db $E9, $40, $00, $02
    dw  0,  0 : db $E9, $00, $00, $02
    dw 16,  0 : db $E9, $40, $00, $02
    dw  0, 16 : db $EB, $00, $00, $02
    dw 16, 16 : db $EB, $40, $00, $02
    dw  0, 32 : db $ED, $00, $00, $02
    dw 16, 32 : db $ED, $40, $00, $02
    
    dw  0,  0 : db $EF, $00, $00, $00
    dw 24,  0 : db $EF, $40, $00, $00
    dw  0,  8 : db $FF, $00, $00, $00
    dw 24,  8 : db $FF, $40, $00, $00
    dw  0,  0 : db $E9, $00, $00, $02
    dw 16,  0 : db $E9, $40, $00, $02
    dw  0, 16 : db $EB, $00, $00, $02
    dw 16, 16 : db $EB, $40, $00, $02
    dw  0, 32 : db $ED, $00, $00, $02
    dw 16, 32 : db $ED, $40, $00, $02
}

; $034B26-$034BA1 LOCAL JUMP LOCATION
FairyQueen_Draw:
{
    LDA.l $7EF3CA : BNE .in_dark_world
        JSR.w Sprite_PrepOamCoord
        
        LDA.w $0DC0, X : ASL : ASL : STA.b $0D
        
        LDA.w $0DC0, X : ASL #3 : ADC.b $0D : STA.b $06
        
        PHX
        
        LDX.b #$0B
    
        .next_OAM_entry
        
            PHX
            
            TXA : CLC : ADC.b $06 : TAX
            LDA.b $00
            CLC : ADC.w Pool_FairyQueen_Draw_x_offsets, X       : STA.b ($90), Y

            LDA.b $02
            CLC : ADC.w Pool_FairyQueen_Draw_y_offsets, X : INY : STA.b ($90), Y
            
            LDA.w Pool_FairyQueen_Draw_chr, X             : INY : STA.b ($90), Y
            LDA.w Pool_FairyQueen_Draw_properties, X
            ORA.b $05                                     : INY : STA.b ($90), Y
            
            PHY
            
            TYA : LSR : LSR : TAY
            LDA.w Pool_FairyQueen_Draw_OAM_sizes, X : STA.b ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_OAM_entry
        
        PLX
        
        LDY.b #$FF
        LDA.b #$0B
        
        JSR.w Sprite_CorrectOamEntries
        
        RTS
    
    .in_dark_world
    
    LDA.b #$0A : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL : ASL : ADC.w $0DC0, X : ASL #4
    ADC.b #Pool_FairyQueen_Draw_OAM_groups                 : STA.b $08
    LDA.b #Pool_FairyQueen_Draw_OAM_groups>>8 : ADC.b #$00 : STA.b $09
    JSL.l Sprite_DrawMultiple_quantity_preset
    
    RTS
}

; ==============================================================================
