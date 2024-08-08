
; ==============================================================================

; $034309-$034318 DATA
Pool_Sprite_WishPond:
{
    .x_offsets
    db 0,  4,  8, 12, 16, 20, 24, 00
    
    .y_offsets
    db 0,  8, 16, 24, 32, 40,  4, 36
}

; ==============================================================================

; $034319-$0343AA JUMP LOCATION
Sprite_WishPond:
{
    ; Pond of Wishing AI
    
    LDA.w $0D90, X : BNE .BRANCH_ALPHA
    
    LDA.w $0DA0, X : BNE .BRANCH_BETA
    
    JSR.w Sprite_PrepOamCoordSafeWrapper
    JMP.w $C41D ; $03441D IN ROM
    
    .BRANCH_BETA
    
    JSR.w FairyQueen_Draw
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.b $1A : AND.b #$0F : BNE .BRANCH_GAMMA
    
    LDA.b #$72 : JSL.l Sprite_SpawnDynamically : BMI .BRANCH_GAMMA
    
    PHX
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA.b $00 : CLC : ADC .x_offsets, X : STA.w $0D10, Y
    LDA.b $01 : ADC.b #$00        : STA.w $0D30, Y
    
    JSL.l GetRandomInt : AND.b #$07 : TAX
    
    LDA.b $02 : CLC : ADC .y_offsets, X : STA.w $0D00, Y
    LDA.b $03 : ADC.b #$00        : STA.w $0D20, Y
    
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
    
    LDA.b #$04 : JSL.l OAM_AllocateFromRegionC
    
    JSR.w Sprite_PrepAndDrawSingleSmall
    
    RTS
}

; ==============================================================================

; $0343AB-$03441D DATA
{
    ; Gets stored into $0DC0
    .Items
    db $3A, $3A, $3B, $3B, $0C, $2A, $0A, $27
    db $29, $0D, $07, $08, $0F, $10, $11, $12
    db $09, $13, $14, $4A, $21, $1D, $15, $18
    db $19, $31, $1A, $1A, $1B, $1C, $4B, $1E
    db $1F, $49, $01, $02, $03, $04, $05, $06
    db $22, $23, $29, $16, $2B, $2C, $2D, $3D
    db $3C, $48

    ; 0x3A - Regular bow with and without arrows
    ; 0x3B - Silver arrows Bow with and without arrows
    ; 0x0C - Blue boomerang
    ; 0x2A - Red boomerang
    ; 0x0A - Hookshot
    ; 0x27 - Bomb
    ; 0x29 - Mushroom
    ; 0x0D - Magic powder
    ; 0x07 - Fire rod
    ; 0x08 - Ice rod
    ; 0x0F - Bombos
    ; 0x10 - Ether
    ; 0x11 - Quake
    ; 0x12 - Lamp
    ; 0x09 - Hammer
    ; 0x13 - Shovel
    ; 0x14 - Flute not activated
    ; 0x4A - Flute
    ; 0x21 - Net
    ; 0x1D - Book of Madora
    ; 0x15 - Cane of Somaria
    ; 0x18 - Cane of Byrna
    ; 0x19 - Magic Cape
    ; 0x31 - Unused mirror map item
    ; 0x1A - Mirror
    ; 0x1B - Glove 1
    ; 0x1C - Glove 2
    ; 0x4B - Boots
    ; 0x1E - Flippers
    ; 0x1F - Moon Pearl
    ; 0x49 - Sword 1
    ; 0x01 - Master Sword
    ; 0x02 - Sword 3
    ; 0x03 - Sword 4
    ; 0x04 - Shield 1
    ; 0x05 - Shield 2
    ; 0x06 - Mirror Shield
    ; 0x22 - Blue Mail
    ; 0x23 - Red Mail
    ; 0x29 - Unused Bottle Mushroom
    ; 0x16 - Empty Bottle
    ; 0x2B - Red Potion
    ; 0x2C - Green Potion
    ; 0x2D - Blue Potion
    ; 0x3D - Fairy in Bottle
    ; 0x3C - Bee in Bottle
    ; 0x48 - Golden Bee in Bottle
    
    ; $343DD
    .ItemPointer
    dw $C3AA, $C3AE, $C3B0, $C3B1, $C3B2, $C3B4, $C3B5, $C3B6
    dw $C3B7, $C3B8, $C3B9, $C3BA, $C3BB, $C3BE, $C3BF, $C3C0
    dw $C3C0, $C3C1, $C3C2, $C3C3, $C3C6, $C3C8, $C3C9, $C3CA
    dw $C3CB, $C3CB, $C3CF, $C3D2, $C3D4, $C3D4, $C3D4, $C3D4        
}

; ==============================================================================

; $03441D-$03444B LOCAL JUMP LOCATION
FairyPondTriggerMain:
{
    JSR.w $C4B5 ; $0344B5 IN ROM
    JSR.w Sprite_CheckIfActive
    
    LDA.b $A0 : CMP.b #$15 : BEQ Sprite_HappinessPond
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw WaitingForPlayerContact ; 0x00 $C7A1 ; = $0347A1
    dw DecideToThrowItemOrNot  ; 0x01 $C7C6 ; = $0347C6
    dw SpawnThrownItem         ; 0x02 $C7ED ; = $0347ED
    dw WaitToSpawnGreatFairy   ; 0x03 $C83C ; = $03483C
    dw FairyFadeIn             ; 0x04 $C88B ; = $03488B
    dw DecideToDrop            ; 0x05 $C8B7 ; = $0348B7
    dw YesIThrewIt             ; 0x06 $C8C6 ; = $0348C6
    dw SetupFadeOut            ; 0x07 $C952 ; = $034952
    dw FairyFadeOut            ; 0x08 $C97A ; = $03497A
    dw GiveItemBack            ; 0x09 $C9A1 ; = $0349A1
    dw ShowNewItemMessage      ; 0x0A $C9C8 ; = $0349C8
    dw NopeNotMine             ; 0x0B $C9E5 ; = $0349E5
    dw OkayYeahItIsMine        ; 0x0C $C9F1 ; = $0349F1
    dw StillNotMine            ; 0x0D $CA00 ; = $034A00
}

; ==============================================================================

    ; NOTE: The happiness pond, 
; $03444C-$034470 BRANCH LOCATION
Sprite_HappinessPond:
{
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $C4FD ; = $0344FD
    dw $C52B ; = $03452B
    dw $C570 ; = $034570
    dw $C59F ; = $03459F
    dw $C603 ; = $034603
    dw $C616 ; = $034616
    dw $C665 ; = $034665
    dw $C691 ; = $034691
    dw $C6A0 ; = $0346A0
    dw $C6D2 ; = $0346D2
    dw $C6E7 ; = $0346E7
    dw $C70E ; = $03470E
    dw $C721 ; = $034721
    dw $C763 ; = $034763
    dw HappinessPond_GrantLuckStatus
}

; ==============================================================================

; $034471-$0344B4 DATA
{
    ; $C471
    dw 32, -64 : db $24, $00, $00, $00
    dw 32, -56 : db $34, $00, $00, $00
    dw 32, -64 : db $24, $00, $00, $00
    dw 32, -56 : db $34, $00, $00, $00
    
    ; $C491
    dw 32, -64 : db $24, $00, $00, $02
    dw 32, -64 : db $24, $00, $00, $02
    dw 32, -64 : db $24, $00, $00, $02
    dw 32, -64 : db $24, $00, $00, $02
    
    ; $C4B1
    dw $C471, $C491
}

; ==============================================================================

; $0344B5-$0344FC LOCAL JUMP LOCATION
{
    ; No items returned at happiness pond.
    LDA.b $A0 : CMP.b #$15 : BEQ .return
    
    LDA.w $0D80, X
    
    CMP.b #$05 : BEQ .show_returned_item
    CMP.b #$06 : BEQ .show_returned_item
    CMP.b #$0B : BEQ .show_returned_item
    CMP.b #$0C : BEQ .show_returned_item
    
    BRA .return
    
    .show_returned_item
    
    PHX : TXY
    
    LDA.w $0DC0, Y : TAX
    
    LDA AddReceiveItem_properties, X
    
    CMP.b #$FF : BNE .valid_upper_properties
    
    ; HARDCODED
    ; Force to use palette 5. This only applies to the master sword
    ; anyways.
    LDA.b #$05
    
    .valid_upper_properties
    
    AND.b #$07 : ASL A : STA.w $0F50, Y
    
    LDA AddReceiveItem_wide_item_flag, X : TAY
    
    LDA.w $C4B1, Y : STA.b $08
    LDA.w $C4B2, Y : STA.b $09
    
    LDA.b #$04
    
    PLX
    
    JSL.l Sprite_DrawMultiple
    
    .return
    
    RTS
}

; ==============================================================================

; $0344FD-$034522 JUMP LOCATION
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
{
    .prices
    db 5, 20, 25, 50
    
    ; (binary coded decimal used for display in dialogue system).
    .bcd_prices
    db $05, $20, $25, $50
}

; ==============================================================================

; $03452B-$03455C JUMP LOCATION
{
    LDA.w $1CE8 : BNE .BRANCH_3455F
    
    LDA.l $7EF370 : ORA.l $7EF371 : BEQ .no_bomb_or_arrow_upgrades_yet
    
    LDA.b #$02
    
    .no_bomb_or_arrow_upgrades_yet
    
    STA.w $0DC0, X : TAY
    
    LDA.w $C527, Y : STA.w $1CF2
    LDA.w $C528, Y : STA.w $1CF3
    
    LDA.b #$4E
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D8080, X
    
    LDA.b #$01 : STA.w $02E4E4E4
    
    RTS
}

; ==============================================================================

; $03455D-$03456F BRANCH LOCATION
{
    SEP #$30
    
    ; $03455F ALTERNATE ENTRY POINT
    
    LDA.b #$4C
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    STZ.w $0D8080, X
    
    LDA.b #$FF : STA.w $0DF0F0, X
    
    RTS
}

; $034570-$03459E JUMP LOCATION
{
    LDA.w $1CE8E8 : CLC : ADC.w $0DC0C0, X : TAY
    
    LDA.w $C527, Y : STA.w $1CF3
    
    REP #$20
    
    LDA.w $C523, Y : AND.w #$00FF : STA.b $00
    
    LDA.l $7EF360 : CMP $00 : BCC .BRANCH_$3455D
    
    SEP #$30
    
    LDA.b $00 : STA.w $0DE0, X
    
    TYA : STA.w $0EB0, X
    
    INC.w $0D80, X
    
    RTS
}

; $03459F-$034602 JUMP LOCATION
{
    LDA.b #$50 : STA.w $0DF0, X
    
    LDA.w $0DE0, X : STA.b $00 : STZ.b $01
    
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
    
    ASL.b $02 : ASL.b $02 : ASL.b $02 : ASL.b $02
    
    ORA.b $02 : STA.w $1CF2 : INC.w $0D80, X
    
    RTS
}

; $034603-$034615 JUMP LOCATION
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
{
    LDA.w $0DF0, X : BNE .delay
    
    LDA.b #$72
    
    JSL.l Sprite_SpawnDynamically
    
    LDA.b #$1B : STA.w $012C
    
    STZ.w $0133
    
    LDA.b $00 : SEC : SBC.w $C83A  : STA.w $0D10, Y
    LDA.b $01 : SBC.b #$00 : STA.w $0D30, Y
    
    LDA.b $02 : SEC : SBC.w $C83B  : STA.w $0D00, Y
    LDA.b $03 : SBC.b #$00 : STA.w $0D20, Y
    
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
    
    LDA,b #$20 : STA.b $9A
    
    INC.b $15
    
    PLX
    
    .BRANCH_ALPHA
    
    RTS
}

; $034691-$03469F JUMP LOCATION
{
    LDA.w $1CE8 : BNE .BRANCH_ALPHA
    
    INC.w $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$0C : STA.w $0D80, X
    
    RTS
}

; $0346A0-$0346D1 JUMP LOCATION
{
    INC.w $0D80, X
    
    LDA.l $7EF370 : CMP.b #$07 : BEQ .BRANCH_ALPHA
    
    INC A : STA.l $7EF370
    
    PHX
    
    TAX
    
    LDA.l $0DDB40, X : STA.w $1CF2F2 : STA.l $7EF375
    
    PLX
    
    LDA.b #$96
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$98
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    JMP.w $C752   ; $034752 IN ROM
}

; $0346D2-$0346E6 JUMP LOCATION
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
{
    PHX
    
    JSL.l Palette_Restore_SP5F
    JSL.l Palette_RevertTranslucencySwap
    
    PLX
    
    STZ.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; $034721-$034762 JUMP LOCATION
{
    LDA.b #$09 : STA.w $0D80, X
    
    LDA.l $7EF371 : CMP.b #$07 : BEQ .BRANCH_ALPHA
    
    INC A : STA.l $7EF371
    
    PHX
    
    TAX
    
    LDA.l $0DDB50, X : STA.w $1CF2 : STA.l $7EF376
    
    PLX
    
    LDA.b #$97
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$98
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    ; $034752 ALTERNATE ENTRY POINT
    
    REP #$20
    
    LDA.l $7EF360 : CLC : ADC.w #$0064 : STA.l $7EF360
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $034763-$03476E JUMP LOCATION
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
    .message_ids_lower
    db $50, $51, $52, $53
    
    .message_ids_upper
    db $01, $01, $01, $01
    
    .luck_statuses
    db 1, 0, 0, 2
}

; ==============================================================================

; $03477B-$0347A0 JUMP LOCATION
HappinessPond_GrantLuckStatus:
{
    JSL.l GetRandomInt : AND.b #$03 : TAY
    
    LDA.w .luck_statuses, Y : STA.w $0CF9
                            STZ.w $0CFA
    
    LDA.w .message_ids_lower, Y       : XBA
    LDA.w .message_ids_upper, Y : TAY : XBA
    
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
    ; Select an item using the Control Pad and throw it using the [Y] Button.
    LDA.b #$8A
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    LDA.b #$01 : STA.w $02E4
    
    RTS
    
    .dontDoIt
    
    ; Don't do it!
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
    LDA.w $1CE8 : STA.w $0DB0, X : TAX
    ASL A : TAY
    
    LDA.w .ItemPointer, Y   : STA.b $00 ; $C3DD
    LDA.w .ItemPointer+1, Y : STA.b $01 ; $C3DE
    
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
    LDA ($00), Y : PHA : TAX
    
    LDY.b #$04
    LDA.b #$28
    
    JSL.l AddWishPondItem
    JSL.l HUD.RefreshIconLong
    
    PLA : PLY : PLX
    
    ; Save the item.
    STA.w $0DC0, X
    
    TYA : STA.w $0DE0, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    RTS
}

; ==============================================================================

; $03483A-$03483B DATA
{
    ; TODO: Name the routines that use these locations.
    ; WTF: Why not just use immediates for this instead of a data pool? It's
    ; not indexed.
    .x_offset
    db 0
    
    .y_offset
    db 80
}

; ==============================================================================

; $03483C-$03488A JUMP LOCATION
WaitToSpawnGreatFairy:
{
    LDA.w $0DF0, X : BNE .delay
    LDA.b #$72 : JSL.l Sprite_SpawnDynamically
    
    LDA.b #$1B : STA.w $012C
    
    STZ.w $0133
    
    LDA.b $00 : SEC : SBC.w $C83A  : STA.w $0D10, Y
    LDA.b $01 : SBC.b #$00 : STA.w $0D30, Y
    
    LDA.b $02 : SEC : SBC.w $C83B  : STA.w $0D00, Y
    LDA.b $03 : SBC.b #$00 : STA.w $0D20, Y
    
    LDA.b #$01 : STA.w $0DA0A0, Y
    
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
        
        ; Hello there.  Did you drop this?
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
    INC.w $0D8080, X
    
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
    ; Give shield 2
    LDA.b #$05 : STA.w $0DC0, X

    ; Store the value for the new item message.
    LDA.b #$02 : STA.w $0EB0, X
    
    BRA .GiveNewItem
    
    .NotShield1
    
    ; Is it an empty bottle?
    CMP #$16 : BNE .NotEmptyBottle1
    ; Give green potion
    LDA.b #$2C : STA.w $0DC0, X

    ; Store the value for the new item message.
    LDA.b #$03 : STA.w $0EB0, X
    
    BRA .GiveNewItem
    
    .NotEmptyBottle1
    
    BRA .GiveItemBack
    
    .InDarkWorld
    
    ; Is it the bow?
    LDA.w $0DC0, X : CMP.b #$3A : BNE .NotBow
    ; Give silver arrows
    LDA.b #$3B : STA.w $0DC0, X

    ; Store the value for the new item message.
    LDA.b #$04 : STA.w $0EB0, X
    
    ; You are an honest person. I like you. I will give you something important... These are the Silver Arrows. To give Ganon his last moment, you definitely need them!  I know I don't quite have the figure of a fairy. Ganon's cruel power is to blame! You must defeat Ganon!
    LDA.b #$4F
    LDY.b #$01
    
    JSL.l Sprite_ShowMessageUnconditional
    
    RTS
    
    .NotBow
    
    ; Is it the tempered sword?
    CMP.b #$02 : BNE .NotSword3
    ; Give sword 4
    LDA.b #$03 : STA.w $0DC0, X

    ; Store the value for the new item message.
    LDA.b #$05 : STA.w $0EB0, X
    
    BRA .GiveNewItem
    
    .NotSword3
    
    ; Is it an empty bottle?
    CMP #$16 : BNE .NotEmptyBottle2
    ; Give green potion
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
    ; TODO: Name the routines that use these locations.
    .message_ids_low
    db $8F, $90, $92, $91, $93
    
    .message_ids_high
    db $00, $00, $00, $00, $00

    ; 0x008F - You got the Magical Boomerang! You can throw this faster and farther than your old one!
    ; 0x0090 - Your shield is improved! Now you can defend yourself against fireballs!
    ; 0x0091 - These are the Silver Arrows you need to defeat Ganon!
    ; 0x0092 - She filled your bottle with the Medicine Of Magic.  To get such a potion free is quite a bargain!
    ; 0x0093 - Your sword is stronger! You can feel its power throbbing in your hand!
}

; ==============================================================================

; $0349C8-$0349E4 JUMP LOCATION
ShowNewItemMessage:
{
    ; Check if we need to show a new item message:
    LDA.w $0EB0, X : BEQ .NotNewItem
    DEC A : TAY
    
    LDA.w .message_ids_low, Y        : XBA
    LDA.w .message_ids_high, Y : TAY : XBA
    
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
    
    ; Are you sure this is not yours? > Really, it isn't To tell the truth, it is
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
    
    ; Go to YesIThrewIt
    LDA.b #$06 : STA.w $0D80, X
    
    RTS
}

; $034A00-$034A0D JUMP LOCATION
StillNotMine:
{
    ; Now,  now, don't tell me a lie. Please take it back.
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
    .x_offsets
    db  0, 16,  0,  8, 16, 24,  0,  8
    db 16, 24,  0, 16,  0, 16,  0,  8
    db 16, 24,  0,  8, 16, 24,  0, 16
    
    .y_offsets
    db  0,  0, 16, 16, 16, 16, 24, 24
    db 24, 24, 32, 32,  0,  0, 16, 16
    db 16, 16, 24, 24, 24, 24, 32, 32
    
    .chr
    db $C7, $C7, $CF, $CA, $CA, $CF, $DF, $DA
    db $DA, $DF, $CB, $CB, $CD, $CD, $C9, $CA
    db $CA, $C9, $D9, $DA, $DA, $D9, $CB, $CB
    
    .properties
    db $00, $40, $00, $00, $40, $40, $00, $00
    db $40, $40, $00, $40, $00, $40, $00, $00
    db $40, $40, $00, $00, $40, $40, $00, $40
    
    .oam_sizes
    db $02, $02, $00, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $00, $00
    db $00, $00, $00, $00, $00, $00, $02, $02
    
    .oam_groups
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

; ==============================================================================

; $034B26-$034BA1 LOCAL JUMP LOCATION
FairyQueen_Draw:
{
    LDA.l $7EF3CA : BNE .in_dark_world
    
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0DC0, X : ASL #2 : STA.b $0D
    
    LDA.w $0DC0, X : ASL #3 : ADC.b $0D : STA.b $06
    
    PHX
    
    LDX.b #$0B
    
    .next_oam_entry
    
    PHX
    
    TXA : CLC : ADC.b $06 : TAX
    
    LDA.b $00 : CLC : ADC.w $CA0E, X       : STA ($90), Y
    LDA.b $02 : CLC : ADC.w $CA26, X : INY : STA ($90), Y
    
    LDA.w $CA3E, X            : INY : STA ($90), Y
    LDA.w $CA56, X : ORA.b $05  : INY : STA ($90), Y
    
    PHY
    
    TYA : LSR #2 : TAY
    
    LDA.w $CA6E, X : STA ($92), Y
    
    PLY : INY
    
    PLX : DEX : BPL .next_oam_entry
    
    PLX
    
    LDY.b #$FF
    LDA.b #$0B
    
    JSR.w Sprite_CorrectOamEntries
    
    RTS
    
    .in_dark_world
    
    LDA.b #$0A : STA.b $06
                 STZ.b $07
    
    LDA.w $0DC0, X : ASL #2 : ADC.w $0DC0, X : ASL #4
    
    ; references $34A86
    ADC.b #.oam_groups                 : STA.b $08
    LDA.b #.oam_groups>>8 : ADC.b #$00 : STA.b $09
    
    JSL.l Sprite_DrawMultiple_quantity_preset
    
    RTS
}

; ==============================================================================
