; ==============================================================================
; Bank 0x02
; ==============================================================================
; Sprite Module

print "Start of Bank 0x02: $", pc

; ==============================================================================
; Sprite Module
; ==============================================================================

; Main sprite module.
SpriteControl:
{
    PHB : PHK : PLB

    ; Submodule *2:
    LDA.b WRAM.Submodule : ASL : TAX
    JSR.w (.Modules, X)

    PLB

    RTL

    .Modules
    dw SpritePrep ; 0x00
    dw SpriteMain ; 0x01
}

; ==============================================================================

; Sprites 0x00
SpritePrep:
{
    JSL.l LoadTestPalette
    JSR.w LoadShapeGFXIntoBuffer

    LDA.b #$0F : STA.b WRAM.Brightness
    LDA.b WRAM.MainScreenDes : ORA.b #$10 : STA.b WRAM.MainScreenDes

    ; Set the bank.
    PHB : LDA.b #Sprites>>16 : PHA : PLB

    REP #$30

    ; TODO: Remove this.
    LDA.w #$0000 : STA.w WRAM.WorldIndex

    ; Choose which block of sprites to load based on the world index.
    LDA.w WRAM.WorldIndex : ASL : TAX
    LDA.w Sprites_Pointers, X : STA.b $00

    ; Initialize all the sprite values.
    LDX.w #$0000
    BRA .startLoop

    .loop

                      STA.w WRAM.SpriteID, X
        INC.b $00 : INC.b $00

        LDA.b ($00) : STA.w WRAM.SpriteType, X
        INC.b $00 : INC.b $00

        LDA.b ($00) : STA.w WRAM.SpriteSubType, X
        INC.b $00 : INC.b $00

        LDA.b ($00) : STA.w WRAM.SpriteX, X
        INC.b $00 : INC.b $00

        LDA.b ($00) : STA.w WRAM.SpriteY, X
        INC.b $00 : INC.b $00

        LDA.b ($00) : STA.w WRAM.SpriteZ, X
        INC.b $00 : INC.b $00

        ; It's alive!
        LDA.w #$0001 : STA.w WRAM.SpriteState, X

        ; If any other sprite values are added they need to be set here too.
        LDA.w #$0000
        STA.w WRAM.SpriteAIModlue, X
        STA.w WRAM.SpriteHealth, X
        STA.w WRAM.SpriteProp, X
        STA.w WRAM.SpriteAnimationFrame, X
        STA.w WRAM.SpriteXSpeed, X
        STA.w WRAM.SpriteYSpeed, X
        STA.w WRAM.SpriteZSpeed, X
        STA.w WRAM.SpriteXAccel, X
        STA.w WRAM.SpriteYAccel, X
        STA.w WRAM.SpriteZAccel, X
        STA.w WRAM.SpriteTimer1, X
        STA.w WRAM.SpriteTimer2, X
        STA.w WRAM.SpriteTimer3, X
        STA.w WRAM.SpriteCustom1, X
        STA.w WRAM.SpriteCustom2, X
        STA.w WRAM.SpriteCustom3, X

        INX : INX
        
        .startLoop
    LDA.b ($00) : CMP.w #$FFFF : BNE .loop

    SEP #$30

    INC.b WRAM.Submodule

    PLB

    RTS
}

; Sprite data indexed by WRAM.WorldIndex
Sprites:
{
    .Pointers
    dw .block000

    ; Format:
    ; dw $IDID, $TYPE, $STYP, $XXXX, $YYYY, $ZZZZ
    ; dw $FFFF ; To end the block.

    .block000
    dw $0000, $0000, $0000, $0020, $0020, $0000 ; Sprite 1
    ;dw $FFFF
    
    dw $0001, $0001, $0000, $0038, $0030, $0000 ; Sprite 2
    dw $FFFF
}

; Loads some test GFX into the GFXBuffer in WRAM.
LoadShapeGFXIntoBuffer:
{
    ; Set the bank.
    PHB : LDA.b #ShapesGFX>>16 : PHA : PLB

    REP #$30

    LDX.w #$0000
    .loop

        LDA.w ShapesGFX, X : STA.l WRAM2.GFXBuffer, X
    INX : INX : CPX.w #$0800 : BNE .loop

    SEP #$30

    ; Restore the previous bank.
    PLB

    LDA.b WRAM.GFXUpdateMask : ORA.b #$04 : STA.b WRAM.GFXUpdateMask

    RTS
}

; ==============================================================================

; Sprites 0x01
SpriteMain:
{
    REP #$20

    LDX.b #$00
    .loop

        ; Tick down all of the spirte timers.
        LDA.w WRAM.SpriteTimer1, X : BEQ .not0_1
            DEC.w WRAM.SpriteTimer1, X

        .not0_1

        LDA.w WRAM.SpriteTimer2, X : BEQ .not0_2
            DEC.w WRAM.SpriteTimer2, X

        .not0_2

        LDA.w WRAM.SpriteTimer3, X : BEQ .not0_3
            DEC.w WRAM.SpriteTimer3, X

        .not0_3

        ; Run the sprite if its not dead.
        LDA.w WRAM.SpriteState, X : BEQ .notAlive
            SEP #$20
            JSL.l SpriteExecute
            REP #$20

        .notAlive
        
        INX : INX
    CPX.b #$20 : BCC .loop

    SEP #$20

    RTS
}

; Runs the code for a single sprite at index of X.
SpriteExecute:
{
    ; SpriteType *3:
    LDA.w WRAM.SpriteType, X : ASL : CLC : ADC.w WRAM.SpriteType, X : TAY
    LDA.w .Sprites+0, Y : STA.b $00
    LDA.w .Sprites+1, Y : STA.b $01
    LDA.w .Sprites+2, Y : STA.b $02

    JML.w [$0000]

    .Sprites
    dl TestSprite0 ; 0x00
    dl TestSprite1 ; 0x01
}

; ==============================================================================
; General Sprite Functions.
; TODO: Add more of these.
; TODO: Write generic draw function.
; ==============================================================================

; Applies speed to the given sprite's x and y position.
SpriteMoveXY:
{
    REP #$20

    LDA.w WRAM.SpriteX, X
    CLC : ADC.w WRAM.SpriteXSpeed, X : STA.w WRAM.SpriteX, X

    LDA.w WRAM.SpriteY, X
    CLC : ADC.w WRAM.SpriteYSpeed, X : STA.w WRAM.SpriteY, X

    SEP #$20

    RTL
}

; Applies speed to the given sprite's x, y, and z position.
SpriteMoveXYZ:
{
    REP #$20

    LDA.w WRAM.SpriteX, X
    CLC : ADC.w WRAM.SpriteXSpeed, X : STA.w WRAM.SpriteX, X

    LDA.w WRAM.SpriteY, X
    CLC : ADC.w WRAM.SpriteYSpeed, X : STA.w WRAM.SpriteY, X

    LDA.w WRAM.SpriteZ, X
    CLC : ADC.w WRAM.SpriteZSpeed, X : STA.w WRAM.SpriteZ, X

    SEP #$20

    RTL
}

; Applies acceleration to the given sprite's x and y speed.
SpriteAccelerateXY:
{
    REP #$20

    LDA.w WRAM.SpriteXSpeed, X
    CLC : ADC.w WRAM.SpriteXAccel, X : STA.w WRAM.SpriteXSpeed, X

    LDA.w WRAM.SpriteYSpeed, X
    CLC : ADC.w WRAM.SpriteYAccel, X : STA.w WRAM.SpriteYSpeed, X

    SEP #$20

    RTL
}

; Applies acceleration to the given sprite's x, y, and z speed.
SpriteAccelerateXYZ:
{
    REP #$20

    LDA.w WRAM.SpriteXSpeed, X
    CLC : ADC.w WRAM.SpriteXAccel, X : STA.w WRAM.SpriteXSpeed, X

    LDA.w WRAM.SpriteYSpeed, X
    CLC : ADC.w WRAM.SpriteYAccel, X : STA.w WRAM.SpriteYSpeed, X

    LDA.w WRAM.SpriteZSpeed, X
    CLC : ADC.w WRAM.SpriteZAccel, X : STA.w WRAM.SpriteZSpeed, X

    SEP #$20

    RTL
}

Sprite_CheckIfActive:
{
    LDA.b WRAM.GamePause : AND.b #$01 : BEQ .notPaused
        ; TODO: Verify that this works. It doesn't, fix it.
        PLA : PLA : PLA

        RTL

    .notPaused

    JSL Sprite_CheckIfOffScreen : BCS .notOutOfBounds
        ; TODO: Verify that this works.
        PLA : PLA : PLA

        RTL

    .notOutOfBounds

    RTL
}

; Output: $00 = 16 bit relative screen X coord
;         $02 = 16 bit relative screen Y coord
Sprite_CheckIfOffScreen:
{
    REP #$20

    JSL.l CaluclateRelativeScreenCoords

    ; Add $0040 and If >= 0x170 don't display at all.
    LDA.b $00 : CLC : ADC.w #$0040 : CMP.w #$0170 : BCC .xInBounds
        ; Out of bounds.
        CLC

        SEP #$20

        RTL

    .xInBounds

    ; Add $0040 and If >= 0x170 don't display at all.
    LDA.b $02 : CLC : ADC.w #$0040 : CMP.w #$0170 : BCC .yInBounds
        ; Out of bounds.
        CLC

        SEP #$20

        RTL

    .yInBounds

    ; In bounds.
    SEC

    SEP #$20

    RTL
}

; Calculate the sprite's coordinates relative to BG2 or our screen.
; Output: $00 = 16 bit relative screen X coord
;         $02 = 16 bit relative screen Y coord
CaluclateRelativeScreenCoords:
{
    REP #$20

    ; X coordinate for the sprite.
    LDA.w WRAM.SpriteX, X : SEC : SBC.b WRAM.BG2HScrollOffset : STA.b $00

    ; TODO: Add Z coordinate.
    ; Sprite's Y coord. Subtract the Y coordinate of the camera.
    LDA.w WRAM.SpriteY, X : SEC : SBC.b WRAM.BG2VScrollOffset : STA.b $02

    SEP #$20

    RTL
}

; ==============================================================================
; Test Sprites
; ==============================================================================

; Test Sprite 0
TestSprite0:
{
    PHB : PHK : PLB

    JSR.w TestSprite0Main

    JSR.w TestSprite0Draw

    PLB

    RTL
}

; The main AI control for TestSprite1.
TestSprite0Main:
{
    LDA.w WRAM.SpriteAIModlue, X : ASL : TAY

    LDA.w .States+0, Y : STA.b $00
    LDA.w .States+1, Y : STA.b $01

    JMP.w ($0000)

    .States
    dw TestSprite0Prep       ; 0x00
    dw TestSprite0PlayerMove ; 0x01
}

; Sets up TestSprite1.
; TestSprite0 0x00
TestSprite0Prep:
{
    LDA.b #$02 : STA.w WRAM.SpriteProp, X

    REP #$20
    LDA.w #$0002 : STA.w WRAM.SpriteXSpeed, X
    SEP #$20
    
    INC.w WRAM.SpriteAIModlue, X

    RTS
}

; Moves the sprite based on the player D-Pad input.
; TestSprite0 0x01
TestSprite0PlayerMove:
{
    REP #$20

    ; Process input:
    LDA.b WRAM.Joypad1Low : BIT.w #!Joypad1_16_Up : BEQ .notUp
        LDA.w WRAM.SpriteY, X : SEC : SBC.w #$0002 : STA.w WRAM.SpriteY, X

    .notUp

    LDA.b WRAM.Joypad1Low : BIT.w #!Joypad1_16_Down : BEQ .notDown
        LDA.w WRAM.SpriteY, X : CLC : ADC.w #$0002 : STA.w WRAM.SpriteY, X

    .notDown

    LDA.b WRAM.Joypad1Low : BIT.w #!Joypad1_16_Left : BEQ .notLeft
        LDA.w WRAM.SpriteX, X : SEC : SBC.w #$0002 : STA.w WRAM.SpriteX, X

    .notLeft

    LDA.b WRAM.Joypad1Low : BIT.w #!Joypad1_16_Right : BEQ .notRight
        LDA.w WRAM.SpriteX, X : CLC : ADC.w #$0002 : STA.w WRAM.SpriteX, X

    .notRight

    SEP #$20

    RTS
}

; Draw function for test sprite 0.
TestSprite0Draw:
{
    JSL CaluclateRelativeScreenCoords

    LDY.w WRAM.SpriteAnimationFrame, X
    LDA.w .start_index, Y : STA.b $06

    TXY

    LDX.b #$00
    .tileLoop

        PHX ; Save the current tile index.

        ; Add the animation index offest and save it for later.
        TXA : CLC : ADC.b $06 : PHA

        ASL : TAX ; *2

        REP #$20

        ; Add the relative screen X coordinate.
        LDA.b $00 : CLC : ADC.w .x_offsets, X : STA.b (WRAM.OAMPointerBlockA)
        INC.w WRAM.OAMPointerBlockA

        ; See if we are off screen to the left and save that value for later.
        PHA
        AND.w #$0100 : STA.b $0E
        PLA

        CLC : ADC.w #$0018 : CMP.w #$0130 : BCS .outOfBounds
            ; Add the relative screen Y coordinate.
            LDA.b $02 : CLC : ADC.w .y_offsets, X : STA.b (WRAM.OAMPointerBlockA)
            CLC : ADC.w #$0018 : CMP.w #$0100 : BCC .notOutOfBounds

        .outOfBounds

        ; Move the tile to the bottom of the screen where it is hidden.
        LDA.w #$00F0 : STA.b (WRAM.OAMPointerBlockA)

        .notOutOfBounds

        INC.w WRAM.OAMPointerBlockA

        SEP #$20

        PLX ; Get back the original animation index offset.

        LDA.w .chr, X : STA.B (WRAM.OAMPointerBlockA)
        INC.w WRAM.OAMPointerBlockA

        ; TODO: Maybe change to an ADC instead of an ORA?
        LDA.w .prop, X : ORA.w WRAM.SpriteProp, Y : STA.b (WRAM.OAMPointerBlockA)
        INC.w WRAM.OAMPointerBlockA

        ; Use the value we saved earlier to set the X negative bit.
        LDA.w .sizes, X : ORA.b $0F : STA.b (WRAM.OAMPointerExtBlockA)
        INC.b WRAM.OAMPointerExtBlockA
    PLX : INX : CPX.w .numOfTiles : BCC .tileLoop

    SEP #$20

    TYX

    RTS

    .start_index
    db $00

    .numOfTiles
    db $04

    .x_offsets
    dw $0000, $0008, $0000, $0008

    .y_offsets
    dw $0000, $0000, $0008, $0008

    .chr
    db $10, $10, $10, $10

    .prop
    db $00, $40, $80, $C0

    .sizes
    db $00, $00, $00, $00
}

; ==============================================================================

; Test sprite 1
TestSprite1:
{
    PHB : PHK : PLB

    JSR.w TestSprite1Main

    JSR.w TestSprite1Draw

    PLB

    RTL
}

; The main AI control for TestSprite1.
TestSprite1Main:
{
    LDA.w WRAM.SpriteAIModlue, X : ASL : TAY

    LDA.w .States+0, Y : STA.b $00
    LDA.w .States+1, Y : STA.b $01

    JMP.w ($0000)

    .States
    dw TestSprite1Prep  ; 0x00
    dw TestSprite1Right ; 0x01
    dw TestSprite1Down  ; 0x02
    dw TestSprite1Left  ; 0x03
    dw TestSprite1Up    ; 0x04
}

; Sets up TestSprite1.
; TestSprite1 0x00
TestSprite1Prep:
{
    LDA.b #$40 : STA.w WRAM.SpriteTimer1, X
    LDA.b #$02 : STA.w WRAM.SpriteProp, X

    REP #$20
    LDA.w #$0002 : STA.w WRAM.SpriteXSpeed, X
    SEP #$20
    
    INC.w WRAM.SpriteAIModlue, X

    RTS
}

; Moves the sprite to the right and then moves to down and increase the
; animation frame.
; TestSprite1 0x01
TestSprite1Right:
{
    JSL SpriteMoveXY

    LDA.w WRAM.SpriteTimer1, X : BNE .not0
        LDA.b #$40 : STA.w WRAM.SpriteTimer1, X
        INC.w WRAM.SpriteAnimationFrame, X

        REP #$20
        LDA.w #$0000 : STA.w WRAM.SpriteXSpeed, X
        LDA.w #$0002 : STA.w WRAM.SpriteYSpeed, X
        SEP #$20

        INC.w WRAM.SpriteAIModlue, X

    .not0

    RTS
}

; Moves the sprite down and then moves to left and increase the
; animation frame.
; TestSprite1 0x02
TestSprite1Down:
{
    JSL SpriteMoveXY

    LDA.w WRAM.SpriteTimer1, X : BNE .not0
        LDA.b #$40 : STA.w WRAM.SpriteTimer1, X
        INC.w WRAM.SpriteAnimationFrame, X

        REP #$20
        LDA.w #$FFFE : STA.w WRAM.SpriteXSpeed, X
        LDA.w #$0000 : STA.w WRAM.SpriteYSpeed, X
        SEP #$20

        INC.w WRAM.SpriteAIModlue, X

    .not0

    RTS
}

; Moves the sprite to the left and then moves to up and increase the
; animation frame.
; TestSprite1 0x03
TestSprite1Left:
{
    JSL SpriteMoveXY

    LDA.w WRAM.SpriteTimer1, X : BNE .not0
        LDA.b #$40 : STA.w WRAM.SpriteTimer1, X
        INC.w WRAM.SpriteAnimationFrame, X

        REP #$20
        LDA.w #$0000 : STA.w WRAM.SpriteXSpeed, X
        LDA.w #$FFFE : STA.w WRAM.SpriteYSpeed, X
        SEP #$20

        INC.w WRAM.SpriteAIModlue, X

    .not0

    RTS
}

; Moves the sprite up and then moves to down and increase the
; animation frame.
; TestSprite1 0x04
TestSprite1Up:
{
    JSL SpriteMoveXY

    LDA.w WRAM.SpriteTimer1, X : BNE .not0
        LDA.b #$40 : STA.w WRAM.SpriteTimer1, X
        STZ.w WRAM.SpriteAnimationFrame, X

        REP #$20
        LDA.w #$0002 : STA.w WRAM.SpriteXSpeed, X
        LDA.w #$0000 : STA.w WRAM.SpriteYSpeed, X
        SEP #$20

        LDA.b #$01 : STA.w WRAM.SpriteAIModlue, X

    .not0

    RTS
}

; Draw function for test sprite 1.
TestSprite1Draw:
{
    JSL CaluclateRelativeScreenCoords

    LDY.w WRAM.SpriteAnimationFrame, X
    LDA.w .start_index, Y : STA.b $06

    TXY

    LDX.b #$00
    .tileLoop

        PHX ; Save the current tile index.

        ; Add the animation index offest and save it for later.
        TXA : CLC : ADC.b $06 : PHA

        ASL : TAX ; *2

        REP #$20

        ; Add the relative screen X coordinate.
        LDA.b $00 : CLC : ADC.w .x_offsets, X : STA.b (WRAM.OAMPointerBlockA)
        INC.w WRAM.OAMPointerBlockA

        ; See if we are off screen to the left and save that value for later.
        PHA
        AND.w #$0100 : STA.b $0E
        PLA

        CLC : ADC.w #$0018 : CMP.w #$0130 : BCS .outOfBounds
            ; Add the relative screen Y coordinate.
            LDA.b $02 : CLC : ADC.w .y_offsets, X : STA.b (WRAM.OAMPointerBlockA)
            CLC : ADC.w #$0018 : CMP.w #$0100 : BCC .notOutOfBounds

        .outOfBounds

        ; Move the tile to the bottom of the screen where it is hidden.
        LDA.w #$00F0 : STA.b (WRAM.OAMPointerBlockA)

        .notOutOfBounds

        INC.w WRAM.OAMPointerBlockA

        SEP #$20

        PLX ; Get back the original animation index offset.

        LDA.w .chr, X : STA.B (WRAM.OAMPointerBlockA)
        INC.w WRAM.OAMPointerBlockA

        ; TODO: Maybe change to an ADC instead of an ORA?
        LDA.w .prop, X : ORA.w WRAM.SpriteProp, Y : STA.b (WRAM.OAMPointerBlockA)
        INC.w WRAM.OAMPointerBlockA

        ; Use the value we saved earlier to set the X negative bit.
        LDA.w .sizes, X : ORA.b $0F : STA.b (WRAM.OAMPointerExtBlockA)
        INC.b WRAM.OAMPointerExtBlockA
    PLX : INX : CPX.w .numOfTiles : BCC .tileLoop

    SEP #$20

    TYX

    RTS

    .start_index
    db $00, $04, $08, $0C

    .numOfTiles
    db $04, $04, $04, $04

    .x_offsets
    dw $0000, $0008, $0000, $0008
    dw $0000, $0008, $0000, $0008
    dw $0000, $0008, $0000, $0008
    dw $0000, $0008, $0000, $0008

    .y_offsets
    dw $0000, $0000, $0008, $0008
    dw $0000, $0000, $0008, $0008
    dw $0000, $0000, $0008, $0008
    dw $0000, $0000, $0008, $0008

    .chr
    db $01, $01, $01, $01
    db $11, $11, $11, $11
    db $02, $02, $12, $12
    db $03, $03, $13, $13

    .prop
    db $00, $40, $80, $C0
    db $00, $40, $80, $C0
    db $00, $40, $00, $40
    db $00, $40, $00, $40

    .sizes
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
}

; ==============================================================================

print "End of Bank 0x02:   $", pc
print " "