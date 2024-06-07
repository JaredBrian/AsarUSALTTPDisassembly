

; ==============================================================================

; $06DD2A-$06DD31 JUMP LOCATION
Messaging_Equipment:
{
    ; Module E submodule 1 (Item submenu)
    
    PHB : PHK : PLB
    
    JSR Equipment_Local
    
    PLB
    
    RTL
}

    ; start of namespace
    namespace "Equipment_"

; ==============================================================================

; $06DD32-$06DD35 LONG JUMP LOCATION
UpdateEquippedItemLong:
{
    JSR UpdateHUD_updateEquippedItem
    
    RTL
}

; ==============================================================================
    
; $06DD36-$06DD59 LOCAL JUMP LOCATION
Local:
{
    ; Appears to be a simple debug frame counter (8-bit) for this submodule
    ; Of course, it loops back every 256 frames
    INC.w $0206
    
    LDA.w $0200
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw ClearTilemap       ; $DD5A = $6DD5A* 0
    dw Init               ; $DDAB = $6DDAB* 1 
    dw BringMenuDown      ; $DE59 = $6DE59* 2 
    dw ChooseNextMode     ; $DE6E = $6DE6E* 3
    dw NormalMenu         ; $DF15 = $6DF15* 4
    dw UpdateHUD          ; $DFA9 = $6DFA9* 5
    dw CloseMenu          ; $DFBA = $6DFBA* 6
    dw GotoBottleMenu     ; $DFFB = $6DFFB* 7
    dw InitBottleMenu     ; $E002 = $6E002* 8
    dw ExpandBottleMenu   ; $E08C = $6E08C* 9
    dw BottleMenu         ; $E0DF = $6E0DF* A
    dw EraseBottleMenu    ; $E2FD = $6E2FD* B
    dw RestoreNormalMenu  ; $E346 = $6E346* C
}

; ==============================================================================

; $06DD5A-$06DDAA JUMP LOCATION
ClearTilemap:
{
    ; This routine sets up a DMA transfer from
    ; $7E1000 to $6800 (word address) in VRAM
    ; Basically clears out
    ; Also plays the menu coming down sound, then moves to the next step
    
    REP #$20
    
    LDX.b #$00
    
    ; value of a transparent tile
    LDA.b #$207F
    
    .clearVramBuffer
    
    STA.w $1000, X : STA.w $1080, X
    STA.w $1100, X : STA.w $1180, X
    STA.w $1200, X : STA.w $1280, X
    STA.w $1300, X : STA.w $1380, X
    STA.w $1400, X : STA.w $1480, X
    STA.w $1500, X : STA.w $1580, X
    STA.w $1600, X : STA.w $1680, X
    STA.w $1700, X : STA.w $1780, X
    
    INX #2 : CPX.b #$80
    
    BNE .clearVramBuffer
    
    SEP #$20
    
    ; play sound effect for opening item menu
    LDA.b #$11 : STA.w $012F
    
    ; tell NMI to update tilemap
    LDA.b #$01 : STA $17
    
    ; the region of tilemap to update is word address $6800 (this value 0x22 indexes into a table in NMI)
    LDA.b #$22 : STA.w $0116
    
    ; move to next step of the submodule
    INC.w $0200
    
    RTS
}

; ==============================================================================
    
; $06DDAB-$06DE58 JUMP LOCATION
Init:
{
    ; Module 0x0E.0x01.0x01
    
    JSR CheckEquippedItem ; $06E399 IN ROM; Handles which item to equip (if none is equipped)
    
    LDA.b #$01
    
    JSR GetPaletteMask ; $00[2] = 0xFFFF
    JSR DrawYButtonItems
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawSelectedItemBox ; $06E647 IN ROM; Construct a portion of the menu.
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawAbilityText 
    JSR DrawAbilityIcons 
    JSR DrawProgressIcons
    JSR DrawMoonPearl
    JSR UnfinishedRoutine
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawEquipment
    JSR DrawShield
    JSR DrawArmor
    JSR DrawMapAndBigKey
    JSR DrawCompass
    
    LDX.b #$12
    
    LDA.l $7EF340
    
    ; check if we have any equippable items available
    .itemCheck
    
    ORA.l $7EF341, X : DEX
    
    BPL .itemCheck
    
    CMP.b #$00
    
    BEQ .noEquipableItems
    
    LDA.l $7EF35C : ORA.l $7EF35D : ORA.l $7EF35E : ORA.l $7EF35F
    
    BNE .haveBottleItems
    
    BRA .haveNoBottles
    
    .haveBottleItems
    
    LDA.l $7EF34F
    
    ; There is a difference between having bottled items and having 
    ; at least one bottle to put them in. $7EF34F acts as a flag for that.
    BNE .hasBottleFlag
    
    TAY
    
    INY
    LDA.l $7EF35C
    
    BNE .selectThisBottle
    
    INY
    LDA.l $7EF35D
    
    BNE .selectThisBottle
    
    INY
    LDA.l $7EF35E
    
    BNE .selectThisBottle
    
    INY
    
    .selectThisBottle
    
    TYA
    
    .haveNoBottles
    
    STA.l $7EF34F
    
    .hasBottleFlag
    
    JSR DoWeHaveThisItem
    
    BCS .weHaveIt
    
    JSR TryEquipNextItem
    
    .weHaveIt
    
    JSR DrawSelectedYButtonItem
    
    ; Does the player have a bottle equipped currently?
    LDA.w $0202 : CMP.b #$10                 ; initial draw
    
    BNE .equippedItemIsntBottle
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawBottleMenu
    
    .equippedItemIsntBottle
    .noEquipableItems
    
    ; Start a timer
    LDA.b #$10 : STA.w $0207
    
    ; Make NMI update BG3 tilemap
    LDA.b #$01 : STA $17
    
    ; update vram address $6800 (word)
    LDA.b #$22 : STA.w $0116
    
    ; move on to next step of the submodule
    INC.w $0200
    
    RTS
}

; ==============================================================================

; $06DE59-$06DE6D JUMP LOCATION
BringMenuDown:
{
    REP #$20
    
    LDA $EA : SEC : SBC.w #$0008 : STA $EA : CMP.w #$FF18
    
    SEP #$20
    
    BNE .notDoneScrolling 
    
    INC.w $0200
    
    .notDoneScrolling
    
    RTS
}
    
; ==============================================================================

; $06DE6E-$06DEAF JUMP LOCATION
ChooseNextMode:
{
    ; Makes a determination whether to go to the normal menu handling mode
    ; or the bottle submenu handling mode.
    ; there's also mode 0x05... which appears to be hidden at this point.
    
    LDX.b #$12
    
    LDA.l $7EF340
    
    .haveAnyEquippable
    
    ORA.l $7EF341, X : DEX : BPL .haveAnyEquippable
    
    CMP.b #$00 : BEQ .haveNone
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    JSR DoWeHaveThisItem : BCS .weHaveIt
    
    JSR TryEquipNextItem
    
    .weHaveIt
    
    JSR DrawSelectedYButtonItem
    
    ; Move to the next step of the submodule
    LDA.b #$04 : STA.w $0200
    
    LDA.w $0202 : CMP.b #$10 : BNE .notOnBottleMenu
    
    ; switch to the step of this submodule that handles when the
    ; bottle submenu is up
    LDA.b #$0A : STA.w $0200
    
    .notOnBottleMenu
    
    RTS
    
    .haveNone
    
    ; BYSTudlr
    LDA $F4 : BEQ .noButtonPress
    
    LDA.b #$05 : STA.w $0200
    
    RTS
    
    .noButtonPress
    
    RTS
}

; ==============================================================================

; $06DEB0-$06DEBC LOCAL JUMP LOCATION
DoWeHaveThisItem:
{
    LDX.w $0202
    
    ; Check to see if we have this item...
    LDA.l $7EF33F, X : BNE .haveThisItem
        CLC
        
        RTS
    
    .haveThisItem
    
    SEC
    
    RTS
}

; ==============================================================================
    
; $06DEBD-$06DECA LOCAL JUMP LOCATION
GoToPrevItem:
{
    LDA.w $0202 : DEC A : CMP.b #$01 : BCS .dontReset
        LDA.b #$14
    
    .dontReset
    
    STA.w $0202
    
    RTS
} 

; ==============================================================================
    
; $06DECB-$06DED8 LOCAL JUMP LOCATION
GotoNextItem:
{
    ; Load our currently equipped item, and move to the next one
    ; If we reach our limit (21), set it back to the bow and arrow slot.
    LDA.w $0202 : INC A : CMP.b #$15 : BCC .dontReset
        LDA.b #$01
    
    .dontReset
    
    ; Otherwise try to equip the item in the next slot
    STA.w $0202
    
    RTS
}

; ==============================================================================
    
; $06DED9-$06DEE1 LOCAL JUMP LOCATION
TryEquipPrevItem:
{
    .keepLooking
    
        JSR GoToPrevItem
    JSR DoWeHaveThisItem : BCC .keepLooking
    
    RTS
} 

; ==============================================================================
    
; $06DEE2-$06DEEA JUMP LOCATION
TryEquipNextItem:
{
    .keepLooking
    
        JSR GoToNextItem
    JSR DoWeHaveThisItem : BCC .keepLooking
    
    RTS
}

; ==============================================================================
    
; $06DEEB-$06DEFF LOCAL JUMP LOCATION
TryEquipItemAbove:
{
    .keepLooking
    
        JSR GoToPrevItem
        JSR GoToPrevItem
        JSR GoToPrevItem
        JSR GoToPrevItem
        JSR GoToPrevItem
    JSR DoWeHaveThisItem : BCC .keepLooking
    
    RTS
} 

; ==============================================================================

; $06DF00-$06DF14 LOCAL JUMP LOCATION
TryEquipItemBelow:
{
    .keepLooking
    
        JSR GoToNextItem
        JSR GoToNextItem
        JSR GoToNextItem
        JSR GoToNextItem
        JSR GoToNextItem
    JSR DoWeHaveThisItem : BCC .keepLooking
    
    RTS
}

; ==============================================================================

; $06DF15-$06DFA8 JUMP LOCATION
NormalMenu:
{
    INC.w $0207
    
    ; BYSTudlr
    LDA $F0 : BNE .inputReceived
    
    ; Reset the ability to select a new item
    STZ $BD
    
    .inputReceived
    
    ; check if the start button was pressed this frame
    LDA $F4 : AND.b #$10 : BEQ .dontLeaveMenu
    
    ; bring the menu back up and play the vvvvoooop sound as it comes up.
    LDA.b #$05 : STA.w $0200
    LDA.b #$12 : STA.w $012F
    
    RTS
    
    .dontLeaveMenu
    
    ; After selecting a new item, you have to release all of the BYSTudlr inputs
    ; before you can select a new item. Notice how $BD gets set back low if you
    ; aren't holding any of those buttons.
    LDA $BD : BNE .didntChange
    
    LDA.w $0202 : STA $00
    
    ; Joypad 2.... interesting. It's checking the R button.
    LDA $F7 : AND.b #$10 : BEQ .dontBeAJackass
    
    ; Apparently pressing R on Joypad 2 (if it's enabled) deletes your currently selected item.
    ; Imagine playing the game with your friend constantly trying to delete your items
    ; Lots of punching would ensue.
    LDX.w $0202 
    
    LDA.b #$00 : STA.l $7EF33F, X
    
    ; unlike .movingOut, Anthony's Song.
    BRA .movingOn
    
    .dontBeAJackass
    
    ; BYSTudlr says that we're checking if the up direction is pressed!!!!!! RAWWWWWWWRRRHHGHGH!!!!!
    ; BYSTudrl sounds like a name, like Baiyst Yudler, a German superbrute that hacks roms by breaking them in two!!!!
    ; And then he breaks them into many other numbers bigger than two!!!!!
    LDA $F4 : AND.b #$08 : BEQ .notPressingUp
    
    JSR TryEquipItemAbove
    
    BRA .movingOn
    
    .notPressingUp
    
    ; Don't piss off BYSTudlr - he likes playing Mr. Potato Head.
    ; The problem is he skips the potato part and goes straight for the head.
    ; (In spite of this, I find most of his work quite artistic and tasteful.)
    LDA $F4 : AND.b #$04 : BEQ .notPressingDown
    
    JSR TryEquipItemBelow
    
    BRA .movingOut
    
    .notPressingDown
    
    ; BYSTudlr is not going to pump you up, girly man. His sensibilities are far more refined than that.
    LDA $F4 : AND.b #$02 : BEQ .notPressingLeft
    
    JSR TryEquipPrevItem
    
    BRA .movingOn
    
    .notPressingLeft
    
    ; When BYSTudlr gets really hungry he makes chicken soup.
    ; Recipe (translated from German): Fill bathtub with chicken broth. Put chickens in tub. Eat.
    LDA $F4 : AND.b #$01 : BEQ .notPressingRight
    
    JSR TryEquipNextItem
    
    .notPressingRight
    
    LDA $F4 : STA $BD
    
    ; check if the currently equipped item changed
    LDA.w $0202 : CMP.b $00 : BEQ .didntChange
    
    ; Reset a timer and play a sound effect
    LDA.b #$10 : STA.w $0207
    LDA.b #$20 : STA.w $012F
    
    .didntChange
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawYButtonItems
    JSR DrawSelectedYButtonItem
    
    ; check if we ended up selecting a bottle this frame
    LDA.w $0202 : CMP.b #$10 : BNE .didntSelectBottle
    
    ; switch to the bottle submenu handler
    LDA.b #$07 : STA.w $0200
    
    .didntSelectBottle
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06DFA9-$06DFB9 LOCAL JUMP LOCATION
UpdateHUD:
{
    ; Move on to next step.
    INC.w $0200
    
    JSR HUD.Rebuild.updateOnly
    
    ; $06DFAF ALTERNATE ENTRY POINT
    .updateEquippedItem
    
    ; Using the item selected in the item menu,
    ; set a value that tells us what item to use during actual
    ; gameplay. (Y button items, btw)
    LDX.w $0202 
    
    LDA.l $0DFA15, X : STA.w $0303
    
    RTS
}

; ==============================================================================

; $06DFBA-$06DFFA JUMP LOCATION
CloseMenu:
{
    .scroll_up_additional_8_pixels
    
    REP #$20
    
    ; Scroll the menu back up so it's off screen (8 pixels at a time)
    LDA $EA : CLC : ADC.w #$0008 : STA $EA : SEP #$20 : BNE .notDoneScrolling
    
    JSR HUD.Rebuild
    
    ; reset submodule and subsubmodule indices
    STZ.w $0200
    STZ $11
    
    ; Go back to the module we came from
    LDA.w $010C : STA $10
    
    ; Why this is checked, I dunno. notice the huge whopping STZ $11 up above? Yeah, I thought so.
    LDA $11 : BEQ .noSpecialSubmode
    
    ; This seems random and out of place. There's not even a check to make sure we're indoors.
    ; Unless that LDA $11 up above was meant to be LDA $1B
    
    JSL RestoreTorchBackground
    
    .noSpecialSubmode
    
    LDA.w $0303
    
    CMP.b #$05 : BEQ .fireRod
    CMP.b #$06 : BEQ .iceRod
    
    LDA.b #$02 : STA.w $034B
    
    STZ.w $020B
    
    BRA .return

    .fireRod
    .iceRod

    ; Okay, so contrary to what I thought this did previously in the
    ; abstract, it actually positions the HUD up by 8 pixels higher than
    ; it would normally be if you select one of the rods and this variable
    ; $020B is also set. That's it.
    LDA.w $020B : BNE .scroll_up_additional_8_pixels
    
    STZ.w $034B
    
    .notDoneScrolling
    .return
    
    RTS
}

; ==============================================================================

; $06DFFB-$06E001 JUMP LOCATION
GotoBottleMenu:
{
    STZ.w $0205
    INC.w $0200
    
    RTS
} 

; ==============================================================================

; $06E002-$06E04F JUMP LOCATION
InitBottleMenu:
{
    REP #$30
    
    LDA.w $0205 : AND.w #$00FF : ASL #6 : TAX
    
    LDA.w #$207F 
    STA.w $12EA, X : STA.w $12EC, X : STA.w $12EE, X : STA.w $12F0, X
    STA.w $12F2, X : STA.w $12F4, X : STA.w $12F6, X : STA.w $12F8, X
    STA.w $12FA, X : STA.w $12FC, X
    
    SEP #$30
    
    INC.w $0205
    
    LDA.w $0205 : CMP.b #$13 : BNE .notDoneErasing
    
    INC.w $0200
    
    LDA.b #$11 : STA.w $0205
    
    .notDoneErasing
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E050-$06E08B DATA
{
    ; $06E050
    dw $28FB, $28F9, $28F9, $28F9, $28F9
    dw $28F9, $28F9, $28F9, $28F9, $68FB
    
    ; $06E064
    dw $28FC, $24F5, $24F5, $24F5, $24F5
    dw $24F5, $24F5, $24F5, $24F5, $68FC
    
    ; $06E078
    dw $A8FB, $A8F9, $A8F9, $A8F9, $A8F9
    dw $A8F9, $A8F9, $A8F9, $A8F9, $E8FB
}

; ==============================================================================

; $06E08C-$06E0DE JUMP LOCATION
ExpandBottleMenu:
{
    ; each frame of this causes the bottle menu frame
    ; to expand upward by by one tile
    
    REP #$30
    
    LDA.w $0205 : AND.w #$00FF : ASL #6 : TAX : PHX
    
    LDY.w #$0012
    
    .drawBottleMenuTop
    
    LDA.w $E050, Y : STA.w $12FC, X
    
    DEX #2 : DEY #2 : BPL .drawBottleMenuTop
    
    PLX 
    
    LDY.w #$0012
    
    ; each subsequent frame, this will overwrite the top of the menu
    ; from the previous frame until fully expanded
    .eraseOldTop
    
    LDA.w $E064, Y : STA.w $133C, X
    
    DEX #2
    
    DEY #2 : BPL .eraseOldTop
    
    LDX.w #$0012

    ; probably only really needs to be done during the first frame of this
    ; step of the submodule
    .drawBottleMenuBottom
    
    LDA.w $E078, X : STA.w $176A, X
    
    DEX #2 : BPL .drawBottleMenuBottom
    
    SEP #$30
    
    DEC.w $0205 : LDA.w $0205 : BPL .notDoneDrawing
    
    INC.w $0200
    
    .notDoneDrawing
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E0DF-$06E176 JUMP LOCATION
BottleMenu:
{
    INC.w $0207
    
    ; Check if the start button was pressed this frame
    LDA $F4 : AND.b #$10 : BEQ .dontCloseMenu
    
    ; close the item menu and play the vvvoooop sound as it goes up
    LDA.b #$12 : STA.w $012F
    LDA.b #$05 : STA.w $0200
    
    BRA .lookAtUpDownInput
    
    .dontCloseMenu
    
    LDA $F4 : AND.b #$03 : BEQ .noLeftRightInput
    
    LDA $F4 : AND.b #$02 : BEQ .noLeftInput
    
    JSR TryEquipPrevItem
    
    BRA .movingOn
    
    .noLeftInput
    
    LDA $F4 : AND.b #$01 : BEQ .noRightInput
    
    JSR TryEquipNextItem
    
    .noRightInput
    .movingOn
    
    ; play sound effect and start a timer to keep
    ; us from switching items for 16 frames.
    LDA.b #$10 : STA.w $0207
    LDA.b #$20 : STA.w $012F
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawYButtonItems
    JSR DrawSelectedYButtonItem
    
    ; Since left or right was pressed, we're exiting the bottle menu
    ; and going back to the normal menu.
    INC.w $0200
    
    STZ.w $0205
    
    RTS
    
    .noLeftRightInput
    .lookAtUpDownInput
    
    JSR UpdateBottleMenu
    
    LDA $F4 : AND.b #$0C : BNE .haveUpDownInput 
    
    ; there's no input, so nothing happens.
    RTS
    
    .haveUpDownInput
    
    LDA.l $7EF34F : DEC A : STA $00 : STA $02
    
    LDA $F4 : AND.b #$08 : BEQ .haveUpInput
    
    .selectPrevBottle
    
    LDA $00 : DEC A : AND.b #$03 : STA $00 : TAX
    
    LDA.l $7EF35C, X : BEQ .selectPrevBottle
    
    BRA .bottleIsSelected
    
    .haveUpInput
    .selectNextBottle
    
    LDA $00 : INC A : AND.b #$03 : STA $00 : TAX
    
    LDA.l $7EF35C, X : BEQ .selectNextBottle
    
    .bottleIsSelected
    
    LDA $00 : CMP $02 : BEQ .sameBottleWhoCares
    
    ; record which bottle was just selected
    INC A : STA.l $7EF34F
    
    ; If it's not the same bottle we play the 
    ; obligatory item switch sound effect
    LDA.b #$10 : STA.w $0207
    LDA.b #$20 : STA.w $012F
    
    .sameBottleWhoCares
    
    RTS
}

; ==============================================================================

; $06E177-$06E17E DATA
    dw $0088, $0188, $0288, $0388 

; ==============================================================================

; $06E17F-$06E2FC LOCAL JUMP LOCATION
UpdateBottleMenu:
{
    REP #$30
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .erase
    
    STA.w $132C, X : A.w $136C6C, X
    STA.w $13AC, X : A.w $13ECEC, X
    STA.w $142C, X : A.w $146C6C, X
    STA.w $14AC, X : A.w $14ECEC, X
    STA.w $152C, X : A.w $156C6C, X
    STA.w $15AC, X : A.w $15ECEC, X
    STA.w $162C, X : A.w $166C6C, X
    STA.w $16AC, X : A.w $16ECEC, X
    STA.w $172C, X 
    
    INX #2
    
    DEY : BPL .erase
    
    ; Draw the 4 bottle icons (if we don't have that bottle it just draws blanks)
    LDA.w #$1372 : STA $00
    LDA.l $7EF35C : AND.w #$00FF : STA $02
    LDA.w #$F751 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1472 : STA $00
    LDA.l $7EF35D : AND.w #$00FF : STA $02
    LDA.w #$F751 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1572 : STA $00
    LDA.l $7EF35E : AND.w #$00FF : STA $02
    LDA.w #$F751 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1672 : STA $00
    LDA.l $7EF35F : AND.w #$00FF : STA $02
    LDA.w #$F751 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1408 : STA $00
    
    LDA.l $7EF34F : AND.w #$00FF : TAX : BNE .haveBottleEquipped
    
    LDA.w #$0000
    
    BRA .drawEquippedBottle
    
    .haveBottleEquipped
    
    LDA.l $7EF35B, X : AND.w #$00FF
    
    .drawEquippedBottle
    
    STA $02
    
    LDA.w #$F751 : STA $04
    
    JSR DrawItem
    
    LDA.w $0202 : AND.w #$00FF : DEC A : ASL A : TAX
    
    LDY.w $FAD5, X
    
    LDA.w $0000, Y : A.w $11B2B2
    LDA.w $0002, Y : A.w $11B4B4
    LDA.w $0040, Y : A.w $11F2F2
    LDA.w $0042, Y : A.w $11F4F4
    
    LDA.l $7EF34F : DEC A : AND.w #$00FF : ASL A : TAY
    
    LDA.w $E177, Y : TAY
    
    LDA.w $0207 : AND.w #$0010 : BEQ .return
    
    LDA.w #$3C61 : STA.w $12AA, Y
    ORA.w #$4000 : STA.w $12AC, Y
    
    LDA.w #$3C70 : STA.w $12E8, Y
    ORA.w #$4000 : STA.w $12EE, Y
    
    LDA.w #$BC70 : STA.w $1328, Y
    ORA.w #$4000 : STA.w $132E, Y
    
    LDA.w #$BC61 : STA.w $136A, Y
    ORA.w #$4000 : STA.w $136C, Y
    
    LDA.w #$3C60 : STA.w $12A8, Y
    ORA.w #$4000 : STA.w $12AE, Y
    ORA.w #$8000 : STA.w $136E, Y
    EOR.w #$4000 : STA.w $1368, Y
    
    LDA.l $7EF34F : AND.w #$00FF : BEQ .noSelectedBottle
    
    TAX
    
    LDA.l $7EF35B, X : AND.w #$00FF : DEC A : ASL #5 : TAX
    
    LDY.w #$0000
    
    .writeBottleDescription
    
    LDA.w $F449, X : STA.w $122C, Y
    LDA.w $F459, X : STA.w $126C, Y
    
    INX #2
    INY #2 : CPY.w #$0010
    
    BCC .writeBottleDescription
    
    .return
    .noSelectedBottle
    
    SEP #$30
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    RTS
} 

; ==============================================================================

; $06E2FD-$06E345 JUMP LOCATION
EraseBottleMenu:
{
    REP #$30
    
    ; erase the bottle menu
    LDA.w $0205 : AND.w #$00FF : ASL #6 : TAX
    
    LDA.w #$207F
    STA.w $12EA, X : A.w $12ECEC, X A.w $12EE12EE, A.w $12F0 $12F0, X
    STA.w $12F2, X : A.w $12F4F4, X A.w $12F612F6, A.w $12F8 $12F8, X
    STA.w $12FA, X : A.w $12FCFC, X
    
    SEP #$30
    
    INC.w $0205
    
    LDA.w $0205 : CMP.b #$13 : BNE .notDoneErasing
    
    ; move on to the next step of the submodule
    INC.w $0200
    
    .notDoneErasing
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E346-$06E371 JUMP LOCATION
RestoreNormalMenu:
{
    ; Updates just the portions of the screen that the bottle menu
    ; screws with.
    
    JSR DrawProgressIcons
    JSR DrawMoonPearl
    JSR UnfinishedRoutine
    
    LDA.b #$01
    
    JSR GetPaletteMask
    JSR DrawEquipment
    JSR DrawShield
    JSR DrawArmor
    JSR DrawMapAndBigKey
    JSR DrawCompass
    
    ; Switch to the normal menu submode.
    LDA.b #$04 : STA.w $0200
    
    ; Tell NMI to update BG3 tilemap next from by writing to address $6800 (word) in vram
    LDA.b #$01 : STA $17
    LDA.b #$22 : STA.w $0116
    
    RTS
}

; ==============================================================================

; $06E372-$06E394 LOCAL JUMP LOCATION
DrawItem:
{
    LDA $02 : ASL #3 : TAY
    
    LDX $00
    
             LDA ($04), Y : STA.w $0000, X
    INY #2 : LDA ($04), Y : STA.w $0002, X 
    INY #2 : LDA ($04), Y : STA.w $0040, X 
    INY #2 : LDA ($04), Y : STA.w $0042, X
    
    RTS
} 

; ==============================================================================

; $06E395-$06E398 LONG JUMP LOCATION
; TODO: Unused? Investigate.
SearchForEquippedItemLong:
{
    JSR SearchForEquippedItem
    
    RTL
}

; ==============================================================================

; $06E399-$06E3C7 LOCAL JUMP LOCATION
SearchForEquippedItem:
{
    SEP #$30
    
    LDX.b #$12
    
    LDA.l $7EF340
    
    ; Go through all our equipable items, hoping to find at least one available
    .itemCheck
        ; Loop.
    ORA.l $7EF341, X : DEX : BPL .itemCheck                     
    
    CMP.b #$00 : BNE .equippableItemAvailable
        ; In this case we have no equippable items
        STZ.w $0202 : Z.w $020303 Z.w $02040204
        
        .weHaveThatItem
        
        RTS
    
    .equippableItemAvailable
    
    ; Is there an item currently equipped (in the HUD slot)?
    LDA.w $0202 : BNE .alreadyEquipped
        ; If not, set the equipped item to the Bow and Arrow (even if we don't actually have it)
        LDA.b #$01 : STA.w $0202
    
    .alreadyEquipped
    
    ; Checks to see if we actually have that item
    ; We're done if we have that item
    JSR DoWeHaveThisItem : BCS .weHaveThatItem
    
    JMP TryEquipNextItem
}

; ==============================================================================

; $06E3C8-$06E3D8 LOCAL JUMP LOCATION
GetPaletteMask:
{
    ; basically if(A == 0) $00 = 0xE3FF; else $00 = 0xFFFF;
    ; if A was zero, this would be used to force a tilemap entry's palette to the 0th palette.
    
    SEP #$30
    
    LDX.b #$E3
    
    CMP.b #$00 : BEQ .alpha
        LDX.b #$FF
    
    .alpha
    
    STX $01
    
    LDA.b #$FF : STA $00
    
    RTS
}

; ==============================================================================

    ; $06E3D9-$06E646 LOCAL JUMP LOCATION
DrawYButtonItems:
{
    REP #$30
    
    ; draw 4 corners of a box (for the equippable item section)
    LDA.w #$3CFB : AND $00 : STA.w $1142
    ORA.w #$8000 : STA.w $14C2
    ORA.w #$4000 : STA.w $14E6
    EOR.w #$8000 : STA.w $1166
    
    LDX.w #$0000
    LDY.w #$000C
    
    .drawVerticalEdges
    
        LDA.w #$3CFC : AND $00 : STA.w $1182, X
        ORA.w #$4000 : STA.w $11A6, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0010
    
    .drawHorizontalEdges
    
        LDA.w #$3CF9 : AND $00 : STA.w $1144, X
        ORA.w #$8000 : STA.w $14C4, X
        
        INX #2
    DEY : BPL .drawHorizontalEdges
    
    LDX.w #$0000
    LDY.w #$0010
    LDA.w #$24F5
    
    .drawBoxInterior
    
        STA.w $1184, X : A.w $11C4C4, X A.w $12041204, A.w $1244 $1244, X
        STA.w $1284, X : A.w $12C4C4, X A.w $13041304, A.w $1344 $1344, X
        STA.w $1384, X : A.w $13C4C4, X A.w $14041404, A.w $1444 $1444, X
        STA.w $1484, X
        
        INX #2
    DEY : BPL .drawBoxInterior
    
    ; Draw 'Y' button Icon
    LDA.w #$3CF0 : STA.w $1184
    LDA.w #$3CF1 : STA.w $11C4

    ; The "ITEM" at the top
    LDA.w #$246E : STA.w $1146
    LDA.w #$246F : STA.w $1148
    
    ; Draw Bow and Arrow
    LDA.w #$11C8 : STA $00
    LDA.l $7EF340 : AND.w #$00FF : STA $02
    LDA.w #$F629 : STA $04
    
    JSR DrawItem
    
    ; Draw Boomerang
    LDA.w #$11CE : STA $00
    LDA.l $7EF341 : AND.w #$00FF : STA $02
    LDA.w #$F651 : STA $04
    
    JSR DrawItem
    
    ; Draw Hookshot
    LDA.w #$11D4 : STA $00
    LDA.l $7EF342 : AND.w #$00FF : STA $02
    LDA.w #$F669 : STA $04
    
    JSR DrawItem
    
    ; Draw Bombs
    LDA.w #$11DA : STA $00
    
    LDA.l $7EF343 : AND.w #$00FF : BEQ .gotNoBombs
        LDA.w #$0001
    
    .gotNoBombs
    
    STA $02
    
    LDA.w #$F679 : STA $04
    
    JSR DrawItem
    
    ; Draw mushroom or magic powder
    LDA.w #$11E0 : STA $00
    LDA.l $7EF344 : AND.w #$00FF : STA $02
    LDA.w #$F689 : STA $04
    
    JSR DrawItem
    
    ; Draw Fire Rod
    LDA.w #$1288 : STA $00
    LDA.l $7EF345 : AND.w #$00FF : STA $02
    LDA.w #$F6A1 : STA $04
    
    JSR DrawItem
    
    ; Draw Ice Rod
    LDA.w #$128E : STA $00
    LDA.l $7EF346 : AND.w #$00FF : STA $02
    LDA.w #$F6B1 : STA $04
    
    JSR DrawItem
    
    ; Draw Bombos Medallion
    LDA.w #$1294 : STA $00
    LDA.l $7EF347 : AND.w #$00FF : STA $02
    LDA.w #$F6C1 : STA $04
    
    JSR DrawItem
    
    ; Draw Ether Medallion
    LDA.w #$129A : STA $00
    LDA.l $7EF348 : AND.w #$00FF : STA $02
    LDA.w #$F6D1 : STA $04
    
    JSR DrawItem
    
    ; Draw Quake Medallion
    LDA.w #$12A0 : STA $00
    LDA.l $7EF349 : AND.w #$00FF : STA $02
    LDA.w #$F6E1 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1348 : STA $00
    LDA.l $7EF34A : AND.w #$00FF : STA $02
    LDA.w #$F6F1 : STA $04
    
    JSR DrawItem
    
    LDA.w #$134E : STA $00
    LDA.l $7EF34B : AND.w #$00FF : STA $02
    LDA.w #$F701 : STA $04
    
    JSR DrawItem
    
    ; Flute
    LDA.w #$1354 : STA $00
    LDA.l $7EF34C : AND.w #$00FF : STA $02
    LDA.w #$F711 : STA $04
    
    JSR DrawItem
    
    ; Bug Catching Net
    LDA.w #$135A : STA $00
    LDA.l $7EF34D : AND.w #$00FF : STA $02
    LDA.w #$F731 : STA $04
    
    JSR DrawItem
    
    ; Draw Book Of Mudora
    LDA.w #$1360 : STA $00
    LDA.l $7EF34E : AND.w #$00FF : STA $02
    LDA.w #$F741 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1408 : STA $00
    
    ; there is an active bottle
    LDA.l $7EF34F : AND.w #$00FF : TAX : BNE .haveSelectedBottle
        LDA.w #$0000
        
        BRA .noSelectedBottle
    
    .haveSelectedBottle
    
    LDA.l $7EF35B, X : AND.w #$00FF
    
    .noSelectedBottle
    
    STA $02
    
    LDA.w #$F751 : STA $04
    JSR DrawItem
    
    ; Draw Cane of Somaria
    LDA.w #$140E : STA $00
    LDA.l $7EF350 : AND.w #$00FF : STA $02
    LDA.w #$F799 : STA $04
    JSR DrawItem
    
    ; Draw Cane of Byrna
    LDA.w #$1414 : STA $00
    LDA.l $7EF351 : AND.w #$00FF : STA $02
    LDA.w #$F7A9 : STA $04
    JSR DrawItem
    
    ; Draw Magic Cape
    LDA.w #$141A : STA $00
    LDA.l $7EF352 : AND.w #$00FF : STA $02
    LDA.w #$F7B9 : STA $04
    JSR DrawItem
    
    ; Draw Magic Mirror
    LDA.w #$1420 : STA $00
    LDA.l $7EF353 : AND.w #$00FF : STA $02
    LDA.w #$F7C9 : STA $04
    JSR DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06E647-$06E6B5 LOCAL JUMP LOCATION
DrawSelectedItemBox:
{
    REP #$30
    
    ; draw 4 corners of a box
    LDA.w #$3CFB : AND $00 : STA.w $116A
    ORA.w #$8000 : STA.w $12AA
    ORA.w #$4000 : STA.w $12BC
    EOR.w #$8000 : STA.w $117C
    
    LDX.w #$0000 
    LDY.w #$0003
    
    ; the lines these tiles make are vertical
    .drawBoxVerticalSides
    
        LDA.w #$3CFC : AND $00 : STA.w $11AA, X
        ORA.w #$4000 : STA.w $11BC, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    DEY : BPL .drawBoxVerticalSides
    
    LDX.w #$0000
    LDY.w #$0007
    
    ; I say horizontal b/c the lines the sides make are horizontal
    .drawBoxHorizontalSides
    
        LDA.w #$3CF9 : AND $00 : STA.w $116C, X
        ORA.w #$8000 : STA.w $12AC, X
        
        INX #2
    DEY : BPL .drawBoxHorizontalSides
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .drawBoxInterior
    
        STA.w $11AC, X : A.w $11ECEC, X A.w $122C122C, A.w $126C.w $126C, X ; init description draw
        
        INX #2
    DEY : BPL .drawBoxInterior
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06E6B6-$06E7B6 LOCAL JUMP LOCATION
DrawAbilityText:
{
    REP #$30
    
    LDX.w #$0000
    LDY.w #$0010
    LDA.w #$24F5
    
    .drawBoxInterior
    
        STA.w $1584, X : A.w $15C4C4, X
        STA.w $1604, X : A.w $164444, X
        STA.w $1684, X : A.w $16C4C4, X
        
        STA.w $1704, X : INX #2
    DEY : BPL .drawBoxInterior
    
    ; get data from ability variable (set of flags for each ability)
    LDA.l $7EF378 : AND.w #$FF00 : STA $02
    
    LDA.w #$0003 : STA $04
    
    LDY.w #$0000 : TYX
    
    .nextLine
    
        LDA.w #$0004 : STA $06
        
        .nextAbility
        
            ASL $02 : BCC .lacksAbility
                ; Draws the ability strings if Link has the ability
                ; (2 x 5 tile rectangle for each ability)
                LDA.w $F959, X : STA.w $1588, Y
                LDA.w $F95B, X : STA.w $158A, Y
                LDA.w $F95D, X : STA.w $158C, Y
                LDA.w $F95F, X : STA.w $158E, Y
                LDA.w $F961, X : STA.w $1590, Y
                LDA.w $F963, X : STA.w $15C8, Y
                LDA.w $F965, X : STA.w $15CA, Y
                LDA.w $F967, X : STA.w $15CC, Y
                LDA.w $F969, X : STA.w $15CE, Y
                LDA.w $F96B, X : STA.w $15D0, Y
            
            .lacksAbility
            
            TXA : CLC : ADC.w #$0014 : TAX
            TYA : CLC : ADC.w #$000A : TAY
        DEC $06 : BNE .nextAbility
        
        TYA : CLC : ADC.w #$0058 : TAY
    DEC $04 : BNE .nextLine
    
    ; draw the 4 corners of the box containing the ability tiles
    LDA.w #$24FB : AND $00 : STA.w $1542
    ORA.w #$8000 : STA.w $1742
    ORA.w #$4000 : STA.w $1766
    EOR.w #$8000 : STA.w $1566
    
    LDX.w #$0000
    LDY.w #$0006
    
    .drawVerticalEdges
    
        LDA.w #$24FC : AND $00 : STA.w $1582, X
        ORA.w #$4000 : STA.w $15A6, X
        
        TXA : CLC : ADC.w #$0040 : TAX
    
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0010
    
    .drawHorizontalEdges
    
        LDA.w #$24F9 : AND $00 : STA.w $1544, X
        ORA.w #$8000 : STA.w $1744, X
        
        INX #2
    DEY : BPL .drawHorizontalEdges
    
    ; Draw 'A' button icon
    LDA.w #$A4F0 : STA.w $1584
    LDA.w #$24F2 : STA.w $15C4
    LDA.w #$2482 : STA.w $1546
    LDA.w #$2483 : STA.w $1548
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06E7B7-$06E819 LOCAL JUMP LOCATION
DrawAbilityIcons:
{
    REP #$30
    
    LDA.w #$16D0 : STA $00
    LDA.l $7EF354 : AND.w #$00FF : STA $02
    LDA.w #$F7E9 : STA $04
    
    JSR DrawItem
    
    LDA.w #$16C8 : STA $00
    LDA.l $7EF355 : AND.w #$00FF : STA $02
    LDA.w #$F801 : STA $04
    
    JSR DrawItem
    
    LDA.w #$16D8 : STA $00
    LDA.l $7EF356 : AND.w #$00FF : STA $02
    LDA.w #$F811 : STA $04
    
    JSR DrawItem
    
    ; modify the lift ability text if you have
    ; a glove item
    LDA.l $7EF354
    
    AND.w #$00FF : BEQ .finished
        CMP.w #$0001 : BNE .titansMitt
            LDA.w #$0000
            
            JSR DrawGloveAbility
            
            BRA .finished
        
        .titansMitt
        
        LDA.w #$0001
        
        JSR DrawGloveAbility
    
    .finished
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06E81A-$06E85F LOCAL JUMP LOCATION
DrawGloveAbility:
{
    STA $00 
    ASL #2 : ADC $00 : ASL #2 : TAX
    
    LDA.w $F931, X : STA.w $1588
    LDA.w $F933, X : STA.w $158A
    LDA.w $F935, X : STA.w $158C
    LDA.w $F937, X : STA.w $158E
    LDA.w $F939, X : STA.w $1590
    LDA.w $F93B, X : STA.w $15C8
    LDA.w $F93D, X : STA.w $15CA
    LDA.w $F93F, X : STA.w $15CC
    LDA.w $F941, X : STA.w $15CE
    LDA.w $F943, X : STA.w $15D0
    
    RTS
}

; ==============================================================================
    
; $06E860-$06E9C7 DATA
    ; Progress box data

    ; Pendants
    ; $6E860
    db $28FB, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $68FB
    ; $6E874
    db $28FC, $2521, $2522, $2523, $2524, $253F, $24F5, $24F5, $24F5, $68FC
    ; $6E888
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC
    ; $6E89C
    db $28FC, $24F5, $24F5, $24F5, $213B, $213C, $24F5, $24F5, $24F5, $68FC
    ; $6E8B0
    db $28FC, $24F5, $24F5, $24F5, $213D, $213E, $24F5, $24F5, $24F5, $68FC
    ; $6E8C4
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC
    ; $6E8D8
    db $28FC, $24F5, $213B, $213C, $24F5, $24F5, $213B, $213C, $24F5, $68FC
    ; $6E8EC
    db $28FC, $24F5, $213D, $213E, $24F5, $24F5, $213D, $213E, $24F5, $68FC
    ; $06E900
    db $A8FB, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $E8FB

    ; Crystals
    ; $06E914
    db $28FB, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $28F9, $68FB
    ; $06E928
    db $28FC, $252F, $2534, $2535, $2536, $2537, $24F5, $24F5, $24F5, $68FC
    ; $06E93C
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC
    ; $06E950
    db $28FC, $24F5, $24F5, $3146, $3147, $3146, $3147, $24F5, $24F5, $68FC
    ; $06E964
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC
    ; $06E978
    db $28FC, $24F5, $3146, $3147, $3146, $3147, $3146, $3147, $24F5, $68FC
    ; $06E98C
    db $28FC, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $24F5, $68FC
    ; $06E9A0
    db $28FC, $24F5, $24F5, $3146, $3147, $3146, $3147, $24F5, $24F5, $68FC
    ; $06E9B4
    db $A8FB, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $A8F9, $E8FB

; ==============================================================================

; $06E9C8-$06EB39 LOCAL JUMP LOCATION
DrawProgressIcons:
{
    LDA.l $7EF3C5 : CMP.b #$03 : BCC .beforeAgahnim
        JMP .drawCrystals
    
    .beforeAgahnim
    
    REP #$30
    
    LDX.w #$0000
    
    .initPendantDiagram
    
        LDA.w $E860, X : STA.w $12EA, X
        LDA.w $E874, X : STA.w $132A, X
        LDA.w $E888, X : STA.w $136A, X
        LDA.w $E89C, X : STA.w $13AA, X
        LDA.w $E8B0, X : STA.w $13EA, X
        LDA.w $E8C4, X : STA.w $142A, X
        LDA.w $E8D8, X : STA.w $146A, X
        LDA.w $E8EC, X : STA.w $14AA, X
        LDA.w $E900, X : STA.w $14EA, X
    INX #2 : CPX.w #$0014 : BCC .initPendantDiagram
    
    LDA.w #$13B2               : STA $00
    LDA.l $7EF374 : AND.w #$0001 : STA $02
    LDA.w #$F8D1               : STA $04
    
    JSR DrawItem
    
    LDA.w #$146E : STA $00
    STZ $02
    
    LDA.l $7EF374 : AND.w #$0002 : BEQ .needWisdomPendant
        INC $02
    
    .needWisdomPendant
    
    LDA.w #$F8E1 : STA $04
    
    JSR DrawItem
    
    LDA.w #$1476 : STA $00
    STZ $02
    
    LDA.l $7EF374 : AND.w #$0004 : BEQ .needPowerPendant
        INC $02
    
    .needPowerPendant
    
    LDA.w #$F8F1 : STA $04
    
    JSR DrawItem
    
    SEP #$30
    
    RTS
    
    ; $06EA62 ALTERNATE ENTRY POINT
    .drawCrystals
    
    REP #$30
    
    LDX.w #$0000
    
    .initCrystalDiagram
    
        LDA.w $E914, X : STA.w $12EA, X
        LDA.w $E928, X : STA.w $132A, X
        LDA.w $E93C, X : STA.w $136A, X
        LDA.w $E950, X : STA.w $13AA, X
        LDA.w $E964, X : STA.w $13EA, X
        LDA.w $E978, X : STA.w $142A, X
        LDA.w $E98C, X : STA.w $146A, X
        LDA.w $E9A0, X : STA.w $14AA, X
        LDA.w $E9B4, X : STA.w $14EA, X
    INX #2 : CPX.w #$0014 : BCC .initCrystalDiagram
    
    LDA.l $7EF37A : AND.w #$0001 : BEQ .miseryMireNotDone
        LDA.w #$2D44 : STA.w $13B0
        LDA.w #$2D45 : STA.w $13B2
    
    .miseryMireNotDone
    
    LDA.l $7EF37A : AND.w #$0002 : BEQ .darkPalaceNotDone
        LDA.w #$2D44 : STA.w $13B4
        LDA.w #$2D45 : STA.w $13B6
    
    .darkPalaceNotDone
    
    LDA.l $7EF37A : AND.w #$0004 : BEQ .icePalaceNotDone
        LDA.w #$2D44 : STA.w $142E
        LDA.w #$2D45 : STA.w $1430
    
    .icePalaceNotDone
    
    LDA.l $7EF37A : AND.w #$0008 : BEQ .turtleRockNotDone
        LDA.w #$2D44 : STA.w $1432
        LDA.w #$2D45 : STA.w $1434
    
    .turtleRockNotDone
    
    LDA.l $7EF37A : AND.w #$0010 : BEQ .swampPalaceNotDone
        LDA.w #$2D44 : STA.w $1436
        LDA.w #$2D45 : STA.w $1438
    
    .swampPalaceNotDone
    
    LDA.l $7EF37A : AND.w #$0020 : BEQ .blindHideoutNotDone
        LDA.w #$2D44 : STA.w $14B0
        LDA.w #$2D45 : STA.w $14B2
    
    .blindHideoutNotDone
    
    LDA.l $7EF37A : AND.w #$0040 : BEQ .skullWoodsNotDone
        LDA.w #$2D44 : STA.w $14B4
        LDA.w #$2D45 : STA.w $14B6
    
    .skullWoodsNotDone
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06EB3A-$06ECE8 LOCAL JUMP LOCATION
DrawSelectedYButtonItem:
{
    REP #$30
    
    LDA.w $0202 : AND.w #$00FF : DEC A : ASL A : TAX
    
    LDY.w $FAD5, X
    LDA.w $0000, Y : A.w $11B2B2
    LDA.w $0002, Y : A.w $11B4B4
    LDA.w $0040, Y : A.w $11F2F2
    LDA.w $0042, Y : A.w $11F4F4
    
    LDA.w $0207 : AND.w #$0010 : BEQ .dontUpdate
        LDA.w #$3C61 : STA.w $FFC0, Y
        ORA.w #$4000 : STA.w $FFC2, Y
        
        LDA.w #$3C70 : STA.w $FFFE, Y
        ORA.w #$4000 : STA.w $0004, Y
        
        LDA.w #$BC70 : STA.w $003E, Y
        ORA.w #$4000 : STA.w $0044, Y
        
        LDA.w #$BC61 : STA.w $0080, Y
        ORA.w #$4000 : STA.w $0082, Y
        
        LDA.w #$3C60 : STA.w $FFBE, Y
        ORA.w #$4000 : STA.w $FFC4, Y
        ORA.w #$8000 : STA.w $0084, Y
        EOR.w #$4000 : STA.w $007E, Y
    
    .dontUpdate
    
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0010 : BNE .bottleNotSelected
        LDA.l $7EF34F : AND.w #$00FF : BEQ .bottleNotSelected
            TAX
            
            LDA.l $7EF35B, X : AND.w #$00FF : DEC A : ASL #5 : TAX
            
            LDY.w #$0000
            
            .drawBottleDescription
            
            LDA.w $F449, X : STA.w $122C, Y ; loads 24F5, 
            LDA.w $F459, X : STA.w $126C, Y ; loads 2551, 255E, 2563, 2563, 255B, 2554, 24F5, 24F5,   
            
            INX #2
            INY #2 : CPY.w #$0010
            
            BCC .drawBottleDescription
            
            JMP .finished
    
    .bottleNotSelected
    
    ; Magic Powder selected?
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0005 : BNE .powderNotSelected
        LDA.l $7EF344 : AND.w #$00FF : DEC A : BEQ .powderNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writePowderDescription
            
                LDA.w $F549, X : STA.w $122C, Y
                LDA.w $F559, X : STA.w $126C, Y
                
                INX #2
            INY #2 : CPY.w #$0010 : BCC .writePowderDescription
            
            JMP .finished
    
    .powderNotSelected
    
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0014 : BNE .mirrorNotSelected
        LDA.l $7EF353 : AND.w #$00FF : DEC A : BEQ .mirrorNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeMirrorDescription
            
                LDA.w $F5A9, X : STA.w $122C, Y
                LDA.w $F5B9, X : STA.w $126C, Y
                
                INX #2
            INY #2 : CPY.w #$0010 : BCC .writeMirrorDescription
            
            JMP .finished
    
    .mirrorNotSelected
    
    LDA.w $0202 : AND.w #$00FF : CMP.w #$000D : BNE .fluteNotSelected
        LDA.l $7EF34C : AND.w #$00FF : DEC A : BEQ .fluteNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeFluteDescription
            
                LDA.w $F569, X : STA.w $122C, Y
                LDA.w $F579, X : STA.w $126C, Y
                
                INX #2
            INY #2 : CPY.w #$0010 : BCC .writeFluteDescription
            
            BRA .finished
        
    .fluteNotSelected
    
    LDA.w $0202 : AND.w #$00FF : CMP.w #$0001 : BNE .bowNotSelected
        LDA.l $7EF340 : AND.w #$00FF : DEC A : BEQ .bowNotSelected
            DEC A : ASL #5 : TAX
            
            LDY.w #$0000
            
            .writeBowDescription
            
                LDA.w $F5C9, X : STA.w $122C, Y
                LDA.w $F5D9, X : STA.w $126C, Y
                
                INX #2
            INY #2 : CPY.w #$0010 : BCC .writeBowDescription
            
            BRA .finished
    
    .bowNotSelected
    
    TXA : ASL #4 : TAX
    
    LDY.w #$0000                                                
    
    .writeDefaultDescription
    
        LDA.w $F1C9, X : STA.w $122C, Y
        LDA.w $F1D9, X : STA.w $126C, Y
        
        INX #2
    INY #2 : CPY.w #$0010 : BCC .writeDefaultDescription
    
    .finished
    
    SEP #$30
    
    RTS
}

; ==============================================================================
 
; $06ECE9-$06ED03 LOCAL JUMP LOCATION
DrawMoonPearl:
{
    REP #$30
    
    LDA.w #$16E0                 : STA $00
    LDA.l $7EF357 : AND.w #$00FF : STA $02
    LDA.w #$F821                 : STA $04
    
    JSR DrawItem
    
    SEP #$30
    
    RTS
} 

; ==============================================================================
    
; $06ED04-$06ED08 LOCAL JUMP LOCATION
UnfinishedRoutine:
{
    ; MOST WORTHLESS ROUTINE EVAR
    REP #$30
    
    SEP #$30
    
    RTS
}

; ==============================================================================
    
; $06ED09-$06ED28 DATA ; Equipment box text

; $06ED09 - "EQUIPMENT"
    .equipmentChars
    dw $2479, $247A, $247B, $247C, $248C, $24F5, $24F5, $24F5

; $06ED19 - "DUNGEON ITEM"
    .dungeonChars
    dw $2469, $246A, $246B, $246C, $246D, $246E, $246F, $24F5

; ==============================================================================

; $06ED29-$06EE20 LOCAL JUMP LOCATION
DrawEquipment:
{
    REP #$30
    
    ; draw the 4 corners of the border for this section
    LDA.w #$28FB : AND $00 : STA.w $156A
    ORA.w #$8000 : STA.w $176A
    ORA.w #$4000 : STA.w $177C
    EOR.w #$8000 : STA.w $157C
    
    LDX.w #$0000
    LDY.w #$0006
    
    .drawVerticalEdges
    LDA.w #$28FC : AND $00 : STA.w $15AA, X
    ORA.w #$4000 : STA.w $15BC, X
    
    TXA : CLC : ADC.w #$0040 : TAX
    
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    
    .drawHorizontalEdges
    LDA.w #$28F9 : AND $00 : STA.w $156C, X
    ORA.w #$8000 : STA.w $176C, X
    
    INX #2 : DEY : BPL .drawHorizontalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .drawBoxInterior
    STA.w $15AC, X : STA.w $15EC, X : STA.w $162C, X : STA.w $166C, X
    STA.w $16AC, X : STA.w $16EC, X : STA.w $172C, X
    
    INX #2 : DEY : BPL .drawBoxInterior
    
    LDX.w #$0000
    LDY.w #$0007
    
    LDA.w #$28D7 : AND $00
    
    .drawDashedSeparator
    STA.w $166C, X
    
    INX #2 : DEY : BPL .drawDashedSeparator
    
    LDX.w #$0000
    LDY.w #$0007
    
    .drawBoxTitle
    ; Draw the "EQUIPMENT" text.
    LDA .equipmentChars, X : AND $00 : STA.w $15AC, X ; $ED09

    ; Draw the "DUNGEON ITEM" text.
    LDA .dungeonChars, X   : AND $00 : STA.w $16AC, X ; $ED19
    
    INX #2 : DEY : BPL .drawBoxTitle
    
    ; check if we're in a real dungeon (palace) as opposed to just some
    ; house or cave
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BNE .inSpecificDungeon
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    .drawUnknown
        STA.w $16AC, X
    
    INX #2 : DEY : BPL .drawUnknown
    
    LDA.w #$16F2 : STA $00
    LDA.l $7EF36B : AND.w #$00FF : STA $02
    LDA.w #$F911 : STA $04
    
    JSR DrawItem
    
    .inSpecificDungeon
    
    REP #$30
    
    LDA.w #$15EC : STA $00
    
    LDA.l $7EF359 : AND.w #$00FF : CMP.w #$00FF : BNE .hasSword
    LDA.w #$0000
    
    .hasSword
    
               STA $02
    LDA.w #$F839 : STA $04
    
    JSR DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EE21-$06EE3B LOCAL JUMP LOCATION
DrawShield:
{
    REP #$30
    
    LDA.w #$15F2                : STA $00
    LDA.l $7EF35A  : AND.w #$00FF : STA $02
    LDA.w #$F861                : STA $04
    
    JSR DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EE3C-$06EE56 LOCAL JUMP LOCATION
DrawArmor:
{
    REP #$30
    
    LDA.w #$15F8                : STA $00
    LDA.l $7EF35B  : AND.w #$00FF : STA $02
    LDA.w #$F881                : STA $04
    
    JSR DrawItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EE57-$06EEB5 LOCAL JUMP LOCATION
DrawMapAndBigKey:
{
    REP #$30
    
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BEQ .notInPalace
    
    LSR A : TAX
    
    ; Check if we have the big key in this palace
    LDA.l $7EF366
    
    .locateBigKeyFlag
    
    ASL A : DEX : BPL .locateBigKeyFlag : BCC .dontHaveBigKey
    
    JSR CheckPalaceItemPossession
    
    REP #$30
    
    ; Draw the big key (or big key with chest if we've gotten the treasure) icon
    LDA.w #$16F8           : STA $00
    LDA.w #$0001 : CLC : ADC $02 : STA $02
    LDA.w #$F8A9           : STA $04
    
    JSR DrawItem
    
    .dontHaveBigKey
    .notInPalace
    
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BEQ .notInPalaceAgain
    
    LSR A : TAX
    
    ; Check if we have the map in this dungeon
    LDA.l $7EF368
    
    .locateMapFlag
    
    ASL A : DEX : BPL .locateMapFlag : BCC .dontHaveMap
    
    LDA.w #$16EC : STA $00
    LDA.w #$0001 : STA $02
    LDA.w #$F8C1 : STA $04
    
    JSR DrawItem
    
    .dontHaveMap
    .notInPalaceAgain
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EEB6-$06EEDB LOCAL JUMP LOCATION
CheckPalaceItemPossession:
{
    SEP #$30
    
    LDA.w $040C : LSR A
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw .no_item
    dw .no_item
    dw .bow
    dw .power_glove
    dw .no_item
    dw .hookshot
    dw .hammer
    dw .cane_of_somaria
    dw .fire_rod
    dw .blue_mail
    dw .moon_pearl
    dw .titans_mitt
    dw .mirror_shield
    dw .red_mail
}

; ==============================================================================

; $06EEDC-$06EEE0 JUMP LOCATION
Pool_CheckPalaceItemPossession:
{
    .failure
    
    STZ $02
    STZ $03
    
    RTS
    
    .bow
    
    LDA.l $7EF340
    
    .no_item
    .compare
    
    BEQ .failure
    
    .success
    
    LDA.b #$01 : STA $02
                 STZ $03
    
    RTS
    
    .power_glove
    
    LDA.l $7EF354 : BRA .compare
    
    .hookshot
    
    LDA.l $7EF342 : BRA .compare
    
    .hammer
    
    LDA.l $7EF34B : BRA .compare
    
    .cane_of_somaria
    
    LDA.l $7EF350 : BRA .compare
    
    .fire_rod
    
    LDA.l $7EF345 : BRA .compare
    
    .blue_mail
    
    LDA.l $7EF35B : BRA .compare
    
    .moon_pearl
    
    LDA.l $7EF357 : BRA .compare
    
    .titans_mitt
    
    LDA.l $7EF354 : DEC A : BRA .compare
    
    .mirror_shield
    
    LDA.l $7EF35A : CMP.b #$03 : BEQ .success
    
    STZ $02
    STZ $03
    
    RTS
    
    .red_mail
    
    LDA.l $7EF35B : CMP.b #$02 : BEQ .success
    
    STZ $02
    STZ $03
    
    RTS
}

; ==============================================================================

; $06EF39-$06EF66 LOCAL JUMP LOCATION
DrawCompass:
{
    REP #$30
    
    LDA.w $040C : AND.w #$00FF : CMP.w #$00FF : BEQ .notInPalace
    
    LSR A : TAX
    
    LDA.l $7EF364
    
    .locateCompassFlag

    ASL A : DEX : BPL .locateCompassFlag
                  BCC .dontHaveCompass
    
    LDA.w #$16F2 : STA $00
    LDA.w #$0001 : STA $02
    LDA.w #$F899 : STA $04
    
    JSR DrawItem
    
    .dontHaveCompass
    .notInPalace
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06EF67-$06F0F6 LOCAL JUMP LOCATION
DrawBottleMenu:
{
    REP #$30
    
    LDA.w #$28FB : AND $00 : STA.w $12EA
    ORA.w #$8000           : STA.w $176A
    ORA.w #$4000           : STA.w $177C
    EOR.w #$8000           : STA.w $12FC
    
    LDX.w #$0000
    LDY.w #$0010
    
    .drawVerticalEdges
    
    LDA.w #$28FC : AND $00 : STA.w $132A, X
    ORA.w #$4000           : STA.w $133C, X
    
    TXA : CLC : ADC.w #$0040 : TAX
    
    DEY : BPL .drawVerticalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    
    .drawHorizontalEdges
    
    LDA.w #$28F9 : AND $00 : STA.w $12EC, X
    ORA.w #$8000           : STA.w $176C, X
    
    INX #2
    
    DEY : BPL .drawHorizontalEdges
    
    LDX.w #$0000
    LDY.w #$0007
    LDA.w #$24F5
    
    ; fills in a region of 0x11 by 0x07 tiles with one tilemap value
    .drawBoxInterior
    
    STA.w $132C, X : STA.w $136C, X : STA.w $13AC, X : STA.w $13EC, X
    STA.w $142C, X : STA.w $146C, X : STA.w $14AC, X : STA.w $14EC, X
    STA.w $152C, X : STA.w $156C, X : STA.w $15AC, X : STA.w $15EC, X
    STA.w $162C, X : STA.w $166C, X : STA.w $16AC, X : STA.w $16EC, X
    STA.w $172C, X
    
    INX #2
    
    DEY : BPL .drawBoxInterior
    
    REP #$30
    
    ; Draw bottle 0
    LDA.w #$1372               : STA $00
    LDA.l $7EF35C : AND.w #$00FF : STA $02
    LDA.w #$F751               : STA $04
    
    JSR DrawItem
    
    ; Draw bottle 1
    LDA.w #$1472               : STA $00
    LDA.l $7EF35D : AND.w #$00FF : STA $02
    LDA.w #$F751               : STA $04
    
    JSR DrawItem
    
    ; Draw bottle 2
    LDA.w #$1572               : STA $00
    LDA.l $7EF35E : AND.w #$00FF : STA $02
    LDA.w #$F751               : STA $04
    
    JSR DrawItem
    
    ; Draw bottle 3
    LDA.w #$1672               : STA $00
    LDA.l $7EF35F : AND.w #$00FF : STA $02
    LDA.w #$F751               : STA $04
    
    JSR DrawItem
    
    ; Draw the currently selected bottle
    LDA.w #$1408 : STA $00
    
    LDA.l $7EF34F : AND.w #$00FF : TAX
    
    LDA.l $7EF35B, X : AND.w #$00FF : STA $02
    LDA.w #$F751                  : STA $04 ; loads $2837, $2838, $2CC3, $2CD3
    
    JSR DrawItem
    
    ; Take the currently selected item, and draw something with it, perhaps on the main menu region
    LDA.w $0202 : AND.w #$00FF : DEC A : ASL A : TAX
    
    LDY.w $FAD5, X 
    
    LDA.w $0000, Y : STA.w $11B2
    LDA.w $0002, Y : STA.w $11B4
    LDA.w $0040, Y : STA.w $11F2
    LDA.w $0042, Y : STA.w $11F4
    
    LDA.l $7EF34F : DEC A : AND.w #$00FF : ASL A : TAY
    
    LDA.w $E177, Y : TAY
    
    ; appears to be an extraneous load, perhaps something that was unfinished
    ; or meant to be taken out but it just never happened
    LDA.w $0207
    
    LDA.w #$3C61 : STA.w $12AA, Y
    ORA.w #$4000 : STA.w $12AC, Y
    
    LDA.w #$3C70 : STA.w $12E8, Y
    ORA.w #$4000 : STA.w $12EE, Y
    
    LDA.w #$BC70 : STA.w $1328, Y
    ORA.w #$4000 : STA.w $132E, Y
    
    LDA.w #$BC61 : STA.w $136A, Y
    ORA.w #$4000 : STA.w $136C, Y
    
    ; Draw the corners of the bottle submenu
    LDA.w #$3C60 : STA.w $12A8, Y
    ORA.w #$4000 : STA.w $12AE, Y
    ORA.w #$8000 : STA.w $136E, Y
    EOR.w #$4000 : STA.w $1368, Y
    
    SEP #$30
    
    LDA.b #$10 : STA.w $0207
    
    RTS
}

; ==============================================================================

    namespace off
