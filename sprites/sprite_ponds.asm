
; ==============================================================================

    ; $34309-$34318 DATA
    pool Sprite_WishPond:
    {
    
    .x_offsets
        db 0,  4,  8, 12, 16, 20, 24, 00
    
    .y_offsets
        db 0,  8, 16, 24, 32, 40,  4, 36
    }

; ==============================================================================

    ; *$34319-$343AA JUMP LOCATION
    Sprite_WishPond:
    {
        ; Pond of Wishing AI
        
        LDA $0D90, X : BNE BRANCH_ALPHA
        
        LDA $0DA0, X : BNE BRANCH_BETA
        
        JSR Sprite_PrepOamCoordSafeWrapper
        JMP $C41D ; $3441D IN ROM
    
    BRANCH_BETA:
    
        JSR FairyQueen_Draw
        
        LDA $1A : LSR #4 : AND.b #$01 : STA $0DC0, X
        
        LDA $1A : AND.b #$0F : BNE BRANCH_GAMMA
        
        LDA.b #$72 : JSL Sprite_SpawnDynamically : BMI BRANCH_GAMMA
        
        PHX
        
        JSL GetRandomInt : AND.b #$07 : TAX
        
        LDA $00 : CLC : ADC .x_offsets, X : STA $0D10, Y
        LDA $01 : ADC.b #$00        : STA $0D30, Y
        
        JSL GetRandomInt : AND.b #$07 : TAX
        
        LDA $02 : CLC : ADC .y_offsets, X : STA $0D00, Y
        LDA $03 : ADC.b #$00        : STA $0D20, Y
        
        LDA.b #$1F : STA $0DB0, Y
                     STA $0D90, Y
        
        JSR Sprite_ZeroOamAllocation
        
        LDA.b #$48 : STA $0E60, Y
        
        AND.b #$0F : STA $0F50, Y
        
        LDA.b #$01 : STA $0DA0, Y
        
        PLX
    
    BRANCH_GAMMA:
    
        RTS
    
    BRANCH_ALPHA:
    
        DEC $0DB0, X : BNE BRANCH_DELTA
        
        STZ $0DD0, X
    
    BRANCH_DELTA:
    
        LDA $0DB0, X : LSR #3 : STA $0DC0, X
        
        LDA.b #$04 : JSL OAM_AllocateFromRegionC
        
        JSR Sprite_PrepAndDrawSingleSmall
        
        RTS
    }

; ==============================================================================

; $343AB-$3441D DATA
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

; *$3441D-$3444B LOCAL
FairyPondTriggerMain:
{
    JSR $C4B5 ; $344B5 IN ROM
    JSR Sprite_CheckIfActive
        
    LDA $A0 : CMP.b #$15 : BEQ Sprite_HappinessPond
        LDA $0D80, X
        
        JSL UseImplicitRegIndexedLocalJumpTable
        
        dw WaitingForPlayerContact ; 0x00 $C7A1 ; = $347A1*
        dw DecideToThrowItemOrNot  ; 0x01 $C7C6 ; = $347C6*
        dw SpawnThrownItem         ; 0x02 $C7ED ; = $347ED*
        dw WaitToSpawnGreatFairy   ; 0x03 $C83C ; = $3483C*
        dw FairyFadeIn             ; 0x04 $C88B ; = $3488B*
        dw DecideToDrop            ; 0x05 $C8B7 ; = $348B7*
        dw YesIThrewIt             ; 0x06 $C8C6 ; = $348C6*
        dw SetupFadeOut            ; 0x07 $C952 ; = $34952*
        dw FairyFadeOut            ; 0x08 $C97A ; = $3497A*
        dw GiveItemBack            ; 0x09 $C9A1 ; = $349A1*
        dw ShowNewItemMessage      ; 0x0A $C9C8 ; = $349C8*
        dw NopeNotMine             ; 0x0B $C9E5 ; = $349E5*
        dw OkayYeahItIsMine        ; 0x0C $C9F1 ; = $349F1*
        dw StillNotMine            ; 0x0D $CA00 ; = $34A00*
}

; ==============================================================================

    ; \note The happiness pond, 
    ; *$3444C-$34470 BRANCH LOCATION
    Sprite_HappinessPond:
    {
        LDA $0D80, X
        
        JSL UseImplicitRegIndexedLocalJumpTable
        
        dw $C4FD ; = $344FD*
        dw $C52B ; = $3452B*
        dw $C570 ; = $34570*
        dw $C59F ; = $3459F*
        dw $C603 ; = $34603*
        dw $C616 ; = $34616*
        dw $C665 ; = $34665*
        dw $C691 ; = $34691*
        dw $C6A0 ; = $346A0*
        dw $C6D2 ; = $346D2*
        dw $C6E7 ; = $346E7*
        dw $C70E ; = $3470E*
        dw $C721 ; = $34721*
        dw $C763 ; = $34763*
        dw HappinessPond_GrantLuckStatus
    }

; ==============================================================================

    ; $34471-$344B4 DATA
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

    ; *$344B5-$344FC LOCAL
    {
        ; No items returned at happiness pond.
        LDA $A0 : CMP.b #$15 : BEQ .return
        
        LDA $0D80, X
        
        CMP.b #$05 : BEQ .show_returned_item
        CMP.b #$06 : BEQ .show_returned_item
        CMP.b #$0B : BEQ .show_returned_item
        CMP.b #$0C : BEQ .show_returned_item
        
        BRA .return
    
    .show_returned_item
    
        PHX : TXY
        
        LDA $0DC0, Y : TAX
        
        LDA AddReceiveItem.properties, X
        
        CMP.b #$FF : BNE .valid_upper_properties
        
        ; \hardcoded
        ; Force to use palette 5. This only applies to the master sword
        ; anyways.
        LDA.b #$05
    
    .valid_upper_properties
    
        AND.b #$07 : ASL A : STA $0F50, Y
        
        LDA AddReceiveItem.wide_item_flag, X : TAY
        
        LDA $C4B1, Y : STA $08
        LDA $C4B2, Y : STA $09
        
        LDA.b #$04
        
        PLX
        
        JSL Sprite_DrawMultiple
    
    .return
    
        RTS
    }

; ==============================================================================

    ; *$344FD-$34522 JUMP LOCATION
    {
        STZ $02E4
        
        LDA $0DF0, X : BNE BRANCH_ALPHA
        
        JSL Sprite_CheckIfPlayerPreoccupied : BCS BRANCH_ALPHA
        
        LDA.b #$89
        LDY.b #$00
        
        JSL Sprite_ShowMessageFromPlayerContact : BCC BRANCH_ALPHA
        
        INC $0D80, X
        
        JSL Player_ResetState
        JSL Ancilla_TerminateSparkleObjects
        
        STZ $2F

    BRANCH_ALPHA:

        RTS
    }

; ==============================================================================

    ; $34523-$3452A DATA
    {
    
    .prices
        db 5, 20, 25, 50
    
    ; (binary coded decimal used for display in dialogue system).
    .bcd_prices
        db $05, $20, $25, $50
    }

; ==============================================================================

    ; *$3452B-$3455C JUMP LOCATION
    {
        LDA $1CE8 : BNE BRANCH_3455F
        
        LDA $7EF370 : ORA $7EF371 : BEQ .no_bomb_or_arrow_upgrades_yet
        
        LDA.b #$02
    
    .no_bomb_or_arrow_upgrades_yet
    
        STA $0DC0, X : TAY
        
        LDA $C527, Y : STA $1CF2
        LDA $C528, Y : STA $1CF3
        
        LDA.b #$4E
        LDY.b #$01
        
        JSL Sprite_ShowMessageUnconditional
        
        INC $0D80, X
        
        LDA.b #$01 : STA $02E4
        
        RTS
    }

; ==============================================================================

    ; *$3455D-$3456F BRANCH LOCATION
    {
        SEP #$30
    
    ; *$3455F ALTERNATE ENTRY POINT
    
        LDA.b #$4C
        LDY.b #$01
        
        JSL Sprite_ShowMessageUnconditional
        
        STZ $0D80, X
        
        LDA.b #$FF : STA $0DF0, X
        
        RTS
    }

    ; *$34570-$3459E JUMP LOCATION
    {
        LDA $1CE8 : CLC : ADC $0DC0, X : TAY
        
        LDA $C527, Y : STA $1CF3
        
        REP #$20
        
        LDA $C523, Y : AND.w #$00FF : STA $00
        
        LDA $7EF360 : CMP $00 : BCC BRANCH_$3455D
        
        SEP #$30
        
        LDA $00 : STA $0DE0, X
        
        TYA : STA $0EB0, X
        
        INC $0D80, X
        
        RTS
    }

    ; *$3459F-$34602 JUMP LOCATION
    {
        LDA.b #$50 : STA $0DF0, X
        
        LDA $0DE0, X : STA $00 : STZ $01
        
        REP #$20
        
        LDA $7EF360 : SUB $00 : STA $7EF360
        
        SEP #$30
        
        LDA $7EF36A : CLC : ADC $00 : STA $7EF36A
        
        PHX
        
        LDA $0EB0, X
        
        JSL AddHappinessPondRupees
        
        PLX
        
        LDA $7EF36A : CMP.b #$64 : BCC BRANCH_ALPHA
        
        SBC.b #$64 : STA $7EF36A
        
        LDA.b #$05 : STA $0D80, X
        
        RTS
    
    BRANCH_ALPHA:
    
        LDA $7EF36A
        
        STZ $02
    
    BRANCH_GAMMA:
    
        CMP.b #$0A : BCC BRANCH_BETA
        
        SBC.b #$0A
        
        INC $02
        
        BRA BRANCH_GAMMA
    
    BRANCH_BETA:
    
        ASL $02 : ASL $02 : ASL $02 : ASL $02
        
        ORA $02 : STA $1CF2 : INC $0D80, X
        
        RTS
    }

    ; *$34603-$34615 JUMP LOCATION
    {
        LDA $0DF0, X : BNE BRANCH_ALPHA
        
        LDA.b #$94
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
        
        LDA.b #$0D : STA $0D80, X
    
    BRANCH_ALPHA:
    
        RTS
    }

    ; *$34616-$34664 JUMP LOCATION
    {
        LDA $0DF0, X : BNE .delay
        
        LDA.b #$72
        
        JSL Sprite_SpawnDynamically
        
        LDA.b #$1B : STA $012C
        
        STZ $0133
        
        LDA $00 : SUB $C83A  : STA $0D10, Y
        LDA $01 : SBC.b #$00 : STA $0D30, Y
        
        LDA $02 : SUB $C83B  : STA $0D00, Y
        LDA $03 : SBC.b #$00 : STA $0D20, Y
        
        LDA.b #$01 : STA $0DA0, Y
        
        INC $0D80, X
        
        LDA.b #$FF : STA $0DF0, X
        
        PHX
        
        JSL Palette_AssertTranslucencySwap
        JSL PaletteFilter_WishPonds
        
        PLX
        
        TYA : STA $0E90, X
    
    .delay
    
        RTS
    }

    ; *$34665-$34690 JUMP LOCATION
    {
        LDA $1A : AND.b #$07 : BNE BRANCH_ALPHA
        
        PHX
        
        JSL Palette_Filter_SP5F
        
        PLX
        
        LDA $7EC007 : BNE BRANCH_ALPHA
        
        INC $0D80, X
        
        LDA.b #$95
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
        
        PHX
        
        JSL Palette_RevertTranslucencySwap
        
        STZ $1D
        
        LDA,b #$20 : STA $9A
        
        INC $15
        
        PLX
    
    BRANCH_ALPHA:
    
        RTS
    }

    ; *$34691-$3469F JUMP LOCATION
    {
        LDA $1CE8 : BNE BRANCH_ALPHA
        
        INC $0D80, X
        
        RTS
    
    BRANCH_ALPHA:
    
        LDA.b #$0C : STA $0D80, X
        
        RTS
    }

    ; *$346A0-$346D1 JUMP LOCATION
    {
        INC $0D80, X
        
        LDA $7EF370 : CMP.b #$07 : BEQ BRANCH_ALPHA
        
        INC A : STA $7EF370
        
        PHX
        
        TAX
        
        LDA $0DDB40, X : STA $1CF2 : STA $7EF375
        
        PLX
        
        LDA.b #$96
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
        
        RTS
    
    BRANCH_ALPHA:
    
        LDA.b #$98
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
        JMP $C752   ; $34752 IN ROM
    }

    ; *$346D2-$346E6 JUMP LOCATION
    {
        INC $0D80, X
        
        PHX
        
        JSL Palette_AssertTranslucencySwap
        
        LDA.b #$02 : STA $1D
        
        LDA.b #$30 : STA $9A
        
        INC $0015
        
        PLX
        
        RTS
    }

    ; *$346E7-$3470D JUMP LOCATION
    {
        LDA $1A : AND.b #$07 : BNE BRANCH_ALPHA
        
        PHX
        
        JSL Palette_Filter_SP5F
        
        PLX
        
        LDA $7EC007 : CMP.b #$1E : BNE BRANCH_BETA
        
        LDA $0E90, X : TAY
        
        LDA.b #$00 : STA $0DD0, Y
        
        BRA BRANCH_ALPHA
    
    BRANCH_BETA:
    
        CMP.b #$00 : BNE BRANCH_ALPHA
        
        INC $0D80, X
    
    BRANCH_ALPHA:
    
        RTS
    }

    ; *$3470E-$34720 JUMP LOCATION
    {
        PHX
        
        JSL Palette_Restore_SP5F
        JSL Palette_RevertTranslucencySwap
        
        PLX
        
        STZ $0D80, X
        
        LDA.b #$FF : STA $0DF0, X
        
        RTS
    }

    ; *$34721-$34762 JUMP LOCATION
    {
        LDA.b #$09 : STA $0D80, X
        
        LDA $7EF371 : CMP.b #$07 : BEQ BRANCH_ALPHA
        
        INC A : STA $7EF371
        
        PHX
        
        TAX
        
        LDA $0DDB50, X : STA $1CF2 : STA $7EF376
        
        PLX
        
        LDA.b #$97
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
        
        RTS
    
    BRANCH_ALPHA:
    
        LDA.b #$98
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
    
    ; *$34752 ALTERNATE ENTRY POINT
    
        REP #$20
        
        LDA $7EF360 : CLC : ADC.w #$0064 : STA $7EF360
        
        SEP #$30
        
        RTS
    }

; ==============================================================================

    ; *$34763-$3476E JUMP LOCATION
    {
        LDA.b #$54
        LDY.b #$01
        
        JSL Sprite_ShowMessageUnconditional
        
        INC $0D80, X
        
        RTS
    }

; ==============================================================================

    ; $3476F-$3477A DATA
    pool HappinessPond_GrantLuckStatus:
    {
    
    .message_ids_lower
        db $50, $51, $52, $53
    
    .message_ids_upper
        db $01, $01, $01, $01
    
    .luck_statuses
        db 1, 0, 0, 2
    }

; ==============================================================================

    ; *$3477B-$347A0 JUMP LOCATION
    HappinessPond_GrantLuckStatus:
    {
        JSL GetRandomInt : AND.b #$03 : TAY
        
        LDA .luck_statuses, Y : STA $0CF9
                                STZ $0CFA
        
        LDA .message_ids_lower, Y       : XBA
        LDA .message_ids_upper, Y : TAY : XBA
        
        JSL Sprite_ShowMessageUnconditional
        
        STZ $0D80, X
        
        LDA.b #$FF : STA $0DF0, X
        
        RTS
    }

; ==============================================================================

; *$347A1-$347C5 JUMP LOCATION
WaitingForPlayerContact:
{
    STZ $02E4
        
    LDA $0DF0, X : BNE BRANCH_ALPHA
        
    JSL Sprite_CheckIfPlayerPreoccupied : BCS BRANCH_ALPHA
        ; -Mysterious Pond- Won't you throw something in?
        LDA.b #$4A
        LDY.b #$01
        
        JSL Sprite_ShowMessageFromPlayerContact : BCC BRANCH_ALPHA
            INC $0D80, X
            
            JSL Player_ResetState
            
            STZ $2F
            STZ $0EB0, X
    
    BRANCH_ALPHA:
    
    RTS
}

; *$347C6-$347EC JUMP LOCATION
DecideToThrowItemOrNot:
{
    ; If the player selected
    LDA $1CE8 : BNE .dontDoIt
        ; Select an item using the Control Pad and throw it using the [Y] Button.
        LDA.b #$8A
        LDY.b #$00
        
        JSL Sprite_ShowMessageUnconditional
        
        INC $0D80, X
        
        LDA.b #$01 : STA $02E4
        
        RTS
    
    .dontDoIt
    
    ; Don't do it!
    LDA.b #$4B
    LDY.b #$01
        
    JSL Sprite_ShowMessageUnconditional
        
    ; Go back to waiting for contact.
    STZ $0D80, X
        
    LDA.b #$FF : STA $0DF0, X
        
    RTS
}

; *$347ED-$34839 JUMP LOCATION
SpawnThrownItem:
{
    INC $0D80, X : PHX
        
    ; Get the item selected.
    LDA $1CE8 : STA $0DB0, X : TAX
    ASL A : TAY
    
    LDA .ItemPointer, Y   : STA $00 ; $C3DD
    LDA .ItemPointer+1, Y : STA $01 ; $C3DE
    
    ; Save the state of the selected item.
    LDA $7EF340, X : PHA
    
    CPX.b #$20 : BEQ BRANCH_ALPHA
        CPX.b #$03 : BNE BRANCH_BETA
            BRANCH_ALPHA:
    
            LDA.b #$01
    
    BRANCH_BETA:
    
    TAY
    
    LDA.b #$00 : STA $7EF340, X
    
    ; Get the item from the pointer.
    LDA ($00), Y : PHA : TAX
    
    LDY.b #$04
    LDA.b #$28
    
    JSL AddWishPondItem
    JSL HUD.RefreshIconLong
    
    PLA : PLY : PLX
    
    ; Save the item.
    STA $0DC0, X
        
    TYA : STA $0DE0, X
        
    LDA.b #$FF : STA $0DF0, X
        
    RTS
}

; ==============================================================================

    ; $3483A-$3483B DATA
    {
    
    ; \task Name the routines that use these locations.
    ; \wtf Why not just use immediates for this instead of a data pool? It's
    ; not indexed.
    .x_offset
        db 0
    
    .y_offset
        db 80
    }

; ==============================================================================

; *$3483C-$3488A JUMP LOCATION
WaitToSpawnGreatFairy:
{
    LDA $0DF0, X : BNE .delay
        LDA.b #$72 : JSL Sprite_SpawnDynamically
        
        LDA.b #$1B : STA $012C
        
        STZ $0133
        
        LDA $00 : SUB $C83A  : STA $0D10, Y
        LDA $01 : SBC.b #$00 : STA $0D30, Y
        
        LDA $02 : SUB $C83B  : STA $0D00, Y
        LDA $03 : SBC.b #$00 : STA $0D20, Y
        
        LDA.b #$01 : STA $0DA0, Y
        
        INC $0D80, X
        
        LDA.b #$FF : STA $0DF0, X
        
        PHX
        
        JSL Palette_AssertTranslucencySwap
        JSL PaletteFilter_WishPonds
        
        PLX
        
        TYA : STA $0E90, X
    
    .delay
    
    RTS
}

; *$3488B-$348B6 JUMP LOCATION
FairyFadeIn:
{
    ; Every 8th frame fade in.
    LDA $1A : AND.b #$07 : BNE BRANCH_ALPHA
        PHX
        
        JSL Palette_Filter_SP5F
        
        PLX
        
        ; If completely faded in:
        LDA $7EC007 : BNE BRANCH_ALPHA
            INC $0D80, X
            
            ; Hello there.  Did you drop this?
            LDA.b #$8B
            LDY.b #$00
            
            JSL Sprite_ShowMessageUnconditional
            
            PHX
            
            JSL Palette_RevertTranslucencySwap
            
            STZ $1D
            
            LDA.b #$20 : STA $9A
            
            INC $15
        
        PLX
    
    BRANCH_ALPHA:
    
    RTS
}

; *$348B7-$348C5 JUMP LOCATION
DecideToDrop:
{
    ; If player selected "Yes"
    LDA $1CE8 : BNE .wasntMe
        INC $0D80, X
        
        RTS
    
    .wasntMe
    
    LDA #$0B : STA $0D80, X
        
    RTS
}

; *$348C6-$34951 JUMP LOCATION
YesIThrewIt:
{
    INC $0D80, X
        
    ; Are we in the dark world?
    LDA $7EF3CA : BNE .InDarkWorld
    
    ; Figure out which item it is:
    ; Is it the blue boomerang?
    LDA $0DC0, X : CMP.b #$0C : BNE .NotBlueBoomerang
        ; Give back the red boomerang.
        LDA.b #$2A : STA $0DC0, X
        
        ; Store the value for the new item message.
        LDA.b #$01 : STA $0EB0, X
        
        BRA .GiveNewItem
    
    .NotBlueBoomerang
    
    ; Is it shield 1?
    CMP.b #$04 : BNE .NotShield1
        ; Give shield 2
        LDA.b #$05 : STA $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$02 : STA $0EB0, X
        
        BRA .GiveNewItem
    
    .NotShield1
    
    ; Is it an empty bottle?
    CMP #$16 : BNE .NotEmptyBottle1
        ; Give green potion
        LDA.b #$2C : STA $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$03 : STA $0EB0, X
        
        BRA .GiveNewItem
    
    .NotEmptyBottle1
    
    BRA .GiveItemBack
    
    .InDarkWorld
    
    ; Is it the bow?
    LDA $0DC0, X : CMP.b #$3A : BNE .NotBow
        ; Give silver arrows
        LDA.b #$3B : STA $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$04 : STA $0EB0, X
        
        ;You are an honest person. I like you. I will give you something important... These are the Silver Arrows. To give Ganon his last moment, you definitely need them!  I know I don't quite have the figure of a faerie. Ganon's cruel power is to blame! You must defeat Ganon!
        LDA.b #$4F
        LDY.b #$01
        
        JSL Sprite_ShowMessageUnconditional
        
        RTS
    
    .NotBow
    
    ; Is it the tempered sword?
    CMP.b #$02 : BNE .NotSword3
        ; Give sword 4
        LDA.b #$03 : STA $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$05 : STA $0EB0, X
        
        BRA .GiveNewItem
    
    .NotSword3
    
    ; Is it an empty bottle?
    CMP #$16 : BNE .NotEmptyBottle2
        ; Give green potion
        LDA.b #$2C : STA $0DC0, X

        ; Store the value for the new item message.
        LDA.b #$03 : STA $0EB0, X
        
        BRA .GiveNewItem
    
    .NotEmptyBottle2
    
    BRA .GiveItemBack

    .GiveNewItem
    
    ; I like an honest person. I will give you something better in return.
    LDA.b #$8C
    LDY.b #$00
        
    JSL Sprite_ShowMessageUnconditional
        
    RTS
    
    .GiveItemBack
    
    ; I will give this back to you then.  Don't drop it again.
    LDA.b #$4D
    LDY.b #$01
        
    JSL Sprite_ShowMessageUnconditional
        
    RTS
}

; *$34952-$34979 JUMP LOCATION
SetupFadeOut:
{
    LDA $0DE0, X : TAY
        
    LDA $0DB0, X
        
    PHX
        
    TAX
        
    TYA
    
    ; If its bombs don't give it back?
    ; Probably because we wouldn't want to replace the amount you have?
    CPX.b #$03 : BNE BRANCH_ALPHA
        STA $7EF340, X
    
    BRANCH_ALPHA:
    
    PLX
        
    INC $0D80, X
        
    PHX
        
    JSL Palette_AssertTranslucencySwap
        
    LDA.b #$02 : STA $1D
        
    LDA.b #$30 : STA $9A
        
    INC $0015
        
    PLX
        
    RTS
}

    ; *$3497A-$349A0 JUMP LOCATION
FairyFadeOut:
{
    LDA $1A : AND.b #$07 : BNE BRANCH_ALPHA
        PHX
        
        JSL Palette_Filter_SP5F
        
        PLX
        
        LDA $7EC007 : CMP.b #$1E : BNE BRANCH_BETA
            LDA $0E90, X : TAY
        
            LDA.b #$00 : STA $0DD0, Y
        
            BRA BRANCH_ALPHA
    
    BRANCH_BETA:
    
    CMP.b #$00 : BNE BRANCH_ALPHA
        
        INC $0D80, X
    
    BRANCH_ALPHA:
    
    RTS
}

; *$349A1-$349BD JUMP LOCATION
GiveItemBack:
{
    INC $0D80, X
        
    PHX
        
    JSL Palette_Restore_SP5F
    JSL Palette_RevertTranslucencySwap
        
    PLX
    PHX
        
    LDA.b #$02 : STA $02E9
        
    LDA $0DC0, X : TAY
        
    JSL Link_ReceiveItem
        
    PLX
        
    RTS
}

; ==============================================================================

; $349BE-$349C7 DATA
pool ShowNewItemMessage:
{
    ; \task Name the routines that use these locations.
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

; *$349C8-$349E4 JUMP LOCATION
ShowNewItemMessage:
{
    ; Check if we need to show a new item message:
    LDA $0EB0, X : BEQ .NotNewItem
        DEC A : TAY
        
        LDA .message_ids_low, Y        : XBA
        LDA .message_ids_high, Y : TAY : XBA
        
        JSL Sprite_ShowMessageUnconditional
    
    .NotNewItem
    
    ; Reset AI Stage.
    STZ $0D80, X
        
    LDA.b #$FF : STA $0DF0, X
        
    RTS
}

; ==============================================================================

; *$349E5-$349F0 JUMP LOCATION
NopeNotMine:
{
    INC $0D80, X
    
    ; Are you sure this is not yours? > Really, it isn't To tell the truth, it is
    LDA.b #$8D
    LDY.b #$00
        
    JSL Sprite_ShowMessageUnconditional
        
    RTS
}

; ==============================================================================

; *$349F1-$349FF JUMP LOCATION
OkayYeahItIsMine:
{
    LDA $1CE8 : BNE .StillNotMine
        INC $0D80, X
        
        RTS
    
    .StillNotMine
    
    ; Go to YesIThrewIt
    LDA.b #$06 : STA $0D80, X
        
    RTS
}

; *$34A00-$34A0D JUMP LOCATION
StillNotMine:
{
    ; Now,  now, don't tell me a lie. Please take it back.
    LDA.b #$8E
    LDY.b #$00
        
    JSL Sprite_ShowMessageUnconditional
        
    LDA.b #$07 : STA $0D80, X
        
    RTS
}

; ==============================================================================

    ; $34A0E-$34B25 DATA
    pool FairyQueen_Draw:
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

    ; *$34B26-$34BA1 LOCAL
    FairyQueen_Draw:
    {
        LDA $7EF3CA : BNE .in_dark_world
        
        JSR Sprite_PrepOamCoord
        
        LDA $0DC0, X : ASL #2 : STA $0D
        
        LDA $0DC0, X : ASL #3 : ADC $0D : STA $06
        
        PHX
        
        LDX.b #$0B
    
    .next_oam_entry
    
        PHX
        
        TXA : CLC : ADC $06 : TAX
        
        LDA $00 : CLC : ADC $CA0E, X       : STA ($90), Y
        LDA $02 : CLC : ADC $CA26, X : INY : STA ($90), Y
        
        LDA $CA3E, X            : INY : STA ($90), Y
        LDA $CA56, X : ORA $05  : INY : STA ($90), Y
        
        PHY
        
        TYA : LSR #2 : TAY
        
        LDA $CA6E, X : STA ($92), Y
        
        PLY : INY
        
        PLX : DEX : BPL .next_oam_entry
        
        PLX
        
        LDY.b #$FF
        LDA.b #$0B
        
        JSR Sprite_CorrectOamEntries
        
        RTS
    
    .in_dark_world
    
        LDA.b #$0A : STA $06
                     STZ $07
        
        LDA $0DC0, X : ASL #2 : ADC $0DC0, X : ASL #4
        
        ; references $34A86
        ADC.b #.oam_groups                 : STA $08
        LDA.b #.oam_groups>>8 : ADC.b #$00 : STA $09
        
        JSL Sprite_DrawMultiple.quantity_preset
        
        RTS
    }

; ==============================================================================
