; ==============================================================================
; Bank 0x01
; ==============================================================================
; BG3 Text module
; Matrix Code Rain Module

print "Start of Bank 0x01: $", pc

; ==============================================================================
; Text Module
; ==============================================================================

; Main text module handler.
TextModuleControl:
{
    PHB : PHK : PLB

    ; TODO: Eventually remove:
    JSL.l CycleRainbowPalette

    JSL.l BG3Move
    JSR.w ProcessGlitchCharsBG3

    ; Submodule *2:
    LDA.b WRAM.Submodule : ASL : TAX
    JSR.w (.Modules, X)

    PLB

    RTL

    .Modules
    dw TextPrep          ; 0x00
    dw TextMain          ; 0x01
    dw TextWait          ; 0x02
    dw TextBlinkCursor   ; 0x03
    dw TextPlayerControl ; 0x04
    dw TextWaitForInput  ; 0x05
    dw TextOptions       ; 0x06
}

; ==============================================================================

; Sets up the the palettes and GFX needed to display text.
; Initializes the necessary WRAM values.
; Text 0x00
TextPrep:
{
    JSL.l LoadTestPalette
    JSR.w LoadGFXInto2bppBuffer

    ;JSR.w LoadTileMapIntoBuffer1
    ;JSR.w LoadTileMapIntoBuffer2
    ;JSR.w LoadTileMapIntoBuffer3
    ;JSR.w LoadGFXIntoBuffer1

    LDA.b #SongToPlay : STA.b WRAM.SongQueue

    LDA.b #$0F : STA.b WRAM.Brightness
    LDA.b WRAM.MainScreenDes : ORA.b #$04 : STA.b WRAM.MainScreenDes

    ; Index for the Hue cycle later.
    LDA.b #$A0 : STA.b $0F

    ; Load the bank of the text block.
    LDA.b #Text>>16 : STA.b WRAM.TextBank

    REP #$30
    STZ.b WRAM.TextCounter
    
    LDA.b WRAM.TextIndex : ASL : TAX
    LDA.l Text_Pointers, X : STA.b WRAM.TextPointer
                             TAX
    SEP #$30

    INC.b WRAM.TextRainbow

    INC.b WRAM.Submodule

    RTS
}

; ==============================================================================

; The main text routine. Reads in data as either a tilemap chr to display or as
; a command to run.
; Text 0x01
TextMain:
{
    REP #$10

    LDA.b WRAM.TextCounter : CMP.b WRAM.TextSpeed : BEQ .loadNextChar
        INC.b WRAM.TextCounter

        SEP #$10

        RTS
    .loadNextChar

    ; Set the bank.
    PHB : LDA.b WRAM.TextBank : PHA : PLB

    .NextCommand
    LDX.b WRAM.TextDestination

    ; Start text command parsing:
    ; End of the text, move on to the next one.
    ; db $FF
    LDA.b (WRAM.TextPointer) : CMP.b #$FF : BNE .notEnd
        SEP #$10

        INC.b WRAM.TextIndex

        ; Go to TextPrep.
        DEC.b WRAM.Submodule

        RTS
    .notEnd

    ; Does nothing, moves to the next frame.
    ; db $80
    CMP.b #$80 : BNE .NotSkip
        REP #$20
        INC.b WRAM.TextPointer
        SEP #$30

        BRL .end
    .NotSkip

    ; Writes a given value to a given WRAM address.
    ; db $81 : dw $WRAM : db $VV
    CMP.b #$81 : BNE .NotWriteRAM
        REP #$20
        ; Load the address to write to.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b $00

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        SEP #$20

        ; Load the value to write.
        LDA.b (WRAM.TextPointer) : STA.b $02

        ; Switch the bank to write to WRAM.
        PHB : LDA.b #WRAM>>16 : PHA : PLB
        LDA.b $02 : STA.b ($00)
        PLB

        REP #$20 ; Don't remove this!
        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotWriteRAM

    ; Writes a given value to a given WRAM2 address.
    ; db $82 : dw $WRAM : db $VV
    CMP.b #$82 : BNE .NotWriteRAM2
        REP #$20
        ; Load the address to write to.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b $00
        
        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer

        SEP #$20

        ; Load the value to write.
        LDA.b (WRAM.TextPointer) : STA.b $02

        ; Switch the bank to write to WRAM2.
        PHB : LDA.b #WRAM2>>16 : PHA : PLB
        LDA.b $02 : STA.b ($00)
        PLB

        REP #$20 ; Don't remove this!
        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotWriteRAM2

    ; Writes a given 16bit value to a given WRAM address.
    ; db $83 : dw $WRAM, $VVVV
    CMP.b #$83 : BNE .NotWrite16RAM
        REP #$20
        ; Load the address to write to.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b $00
        SEP #$20

        ; Load the value to write.
        REP #$20
        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b $02
        SEP #$20
        
        ; Switch the bank to write to WRAM.
        PHB : LDA.b #WRAM>>16 : PHA : PLB
        REP #$20
        LDA.b $02 : STA.b ($00)

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        SEP #$20
        PLB

        BRL .NextCommand
    .NotWrite16RAM

    ; Writes a given 16bit value to a given WRAM2 address.
    ; db $84 : dw $WRAM, $VVVV
    CMP.b #$84 : BNE .NotWrite16WRAM2
        REP #$20
        ; Load the address to write to.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b $00
        SEP #$20

        ; Load the value to write.
        REP #$20
        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b $02
        SEP #$20
        
        ; Switch the bank to write to WRAM2.
        PHB : LDA.b #WRAM2>>16 : PHA : PLB
        REP #$20
        LDA.b $02 : STA.b ($00)

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        SEP #$20
        PLB

        BRL .NextCommand
    .NotWrite16WRAM2

    ; Moves the cursor up one tile.
    ; db $85
    CMP.b #$85 : BNE .NotMoveCursorUp
        REP #$20
        LDA.b WRAM.TextDestination
        SEC : SBC.w #$003E : STA.b WRAM.TextDestination

        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotMoveCursorUp

    ; Moves the cursor down one tile.
    ; db $86
    CMP.b #$86 : BNE .NotMoveCursorDown
        REP #$20
        LDA.b WRAM.TextDestination
        CLC : ADC.w #$003E : STA.b WRAM.TextDestination

        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotMoveCursorDown

    ; Moves the cursor left one tile.
    ; db $87
    CMP.b #$87 : BNE .NotMoveCursorLeft
        REP #$20
        LDA.b WRAM.TextDestination
        SEC : SBC.w #$0002 : STA.b WRAM.TextDestination

        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotMoveCursorLeft

    ; Moves the cursor right one tile.
    ; db $88
    CMP.b #$88 : BNE .NotMoveCursorRight
        REP #$20
        LDA.b WRAM.TextDestination
        CLC : ADC.w #$0002 : STA.b WRAM.TextDestination

        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotMoveCursorRight

    ; Wait the specified amout of time.
    ; db $89 : dw $WWWW
    CMP.b #$89 : BNE .NotWait
        REP #$20
        ; Load the amount of time.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b WRAM.TextWork

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        SEP #$20

        LDA.b #$02 : STA.b WRAM.Submodule

        BRL .end_update
    .NotWait

    ; Clears the BG1 tilemap.
    ; db $8A
    CMP.b #$8A : BNE .NotBG1Clear
        PHX
        SEP #$30
        JSL.l ClearBG1TileMap
        REP #$30
        PLX

        INC.b WRAM.TextPointer

        SEP #$30

        BRL .end
    .NotBG1Clear

    ; Clears the BG2 tilemap.
    ; db $8B
    CMP.b #$8B : BNE .NotBG2Clear
        PHX
        SEP #$30
        JSL.l ClearBG2TileMap
        REP #$30
        PLX

        INC.b WRAM.TextPointer

        SEP #$30

        BRL .end
    .NotBG2Clear

    ; Clears the BG3 tilemap.
    ; db $8C
    CMP.b #$8C : BNE .NotBG3Clear
        PHX
        SEP #$30
        JSL.l ClearBG3TileMap
        REP #$30
        PLX

        INC.b WRAM.TextPointer

        SEP #$30

        BRL .end
    .NotBG3Clear

    ; Wait until at least one of the given buttons is pressed on joypad1.
    ; db $8D : dw $IIII
    CMP.b #$8D : BNE .NotWaitInput
        REP #$20
        ; Load the wanted input.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b WRAM.TextWork

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        SEP #$20

        LDA.b #$05 : STA.b WRAM.Submodule

        BRL .end_update
    .NotWaitInput

    ; A minecraft §k jumbled text character. $PP is the properties of the tile.
    ; db $8E, $PP
    CMP.b #$8E : BNE .NotGlitchChr
        REP #$20
        ; Load the tile with its properties.
        LDA.b (WRAM.TextPointer)
        STA.l WRAM2.BG3TilemapBuffer, X : STA.l WRAM.MiscBuffer0, X

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        INC.b WRAM.TextDestination : INC.b WRAM.TextDestination
        SEP #$20

        BRL .end_update
    .NotGlitchChr

    ; Loads the parameters for and then goes to option mode.
    ; db $8F : $YYYY, $QQQQ, $PPPP, ....
    CMP.b #$8F : BNE .NotOption 
        REP #$20

        ; Load the quantity of options.
        INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : STA.b WRAM.TextOptionYIncrement

        ; Load the Y increment (how many positions to go up or down when
        ; pressing up or down).
        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        LDA.b (WRAM.TextPointer) : ASL : STA.b WRAM.TextOptionCount

        INC.b WRAM.TextPointer : INC.b WRAM.TextPointer

        LDY.w #$0000

        .optionLoop

            LDA.b (WRAM.TextPointer) : STA.w WRAM.TextOptionPositions, Y
            INY : INY
            INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
        CPY.b WRAM.TextOptionCount : BCC .optionLoop

        LDA.b WRAM.TextOptionCount : LSR : STA.b WRAM.TextOptionCount

        STZ.b WRAM.TextWork
        SEP #$20

        LDA.b #$06 : STA.b WRAM.Submodule

        BRL .end_update
    .NotOption
    
    ; Normal load the tile.
    ; dw $TTTT
    REP #$20
    LDA.b (WRAM.TextPointer) : EOR.b WRAM.TextProperties
    STA.l WRAM2.BG3TilemapBuffer, X : STA.l WRAM.MiscBuffer0, X

    INC.b WRAM.TextPointer : INC.b WRAM.TextPointer
    INC.b WRAM.TextDestination : INC.b WRAM.TextDestination
    SEP #$20

    ; Instead of continuing on and running the next command on the next frame,
    ; stop and run the next command now.
    ; db $80
    LDA.b (WRAM.TextPointer) : CMP.b #$80 : BNE .NotInstant
        REP #$20 ; Don't remove this!
        INC.b WRAM.TextPointer
        SEP #$20

        BRL .NextCommand
    .NotInstant

    STZ.b WRAM.TextCounter

    .end_update

    SEP #$30

    LDA.b WRAM.BGTileMapUpdateMask : ORA.b #$04 : STA.b WRAM.BGTileMapUpdateMask

    .end

    PLB
    
    RTS
}

; ==============================================================================

; Waits the given amount of time.
; Text 0x02
TextWait:
{
    JSR TextBlinkCursor
    
    REP #$20

    DEC.b WRAM.TextWork
    LDA.b WRAM.TextWork : BNE .stillWaiting
        SEP #$20
        LDA.b #$01 : STA.b WRAM.Submodule ; Go back to main.

        STZ.b WRAM.TextCounter
        STZ.b WRAM.TextWork

    .stillWaiting

    SEP #$20

    RTS
}

; ==============================================================================

!_ = $0030

; Replaces the chr at the current destination with an _ and back every few
; frames.
; Text 0x03
TextBlinkCursor:
{
    REP #$30

    ; Only blink every XXXX frames.
    LDA.b WRAM.TextCounter : CMP.w #$0018 : BEQ .loadNextChar
        ; Wait to blink.
        INC.b WRAM.TextCounter

        SEP #$30

        RTS

    .loadNextChar

    LDX.b WRAM.TextDestination

    ; Check the current tile:
    LDA.l WRAM2.BG3TilemapBuffer, X : AND.w #$00FF
    CMP.w #!_ : BEQ .cursor
        ; If the current tile was not already the cursor, place the cursor.
        LDA.l WRAM2.BG3TilemapBuffer, X : STA.b WRAM.TextTileBuffer

        LDA.w #!_ : EOR.b WRAM.TextProperties

        BRA .notCursor

    .cursor

    ; If the current tile was the cursor, replace the actual tile.
    LDA.b WRAM.TextTileBuffer

    .notCursor

    STA.l WRAM2.BG3TilemapBuffer, X

    STZ.b WRAM.TextCounter

    SEP #$30

    LDA.b #$04 : STA.b WRAM.BGTileMapUpdateMask

    RTS
}

; ==============================================================================

; A module that allows the player to freely place and manipulate tiles on BG3.
; Text 0x04
TextPlayerControl:
{
    JSR TextBlinkCursor

    REP #$30

    LDY.b WRAM.TextPointer
    LDX.b WRAM.TextDestination

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Start : BEQ .notStart
        SEP #$30

        ; Even though we don't return from this, a JML should be fine because
        ; NativeRES resets the stack anyway.
        JML NativeRES

    .notStart

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Up : BEQ .notUp
        ; Restore the buffer tile.
        LDA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        ; Move the destination.
        LDA.b WRAM.TextDestination
        SEC : SBC.w #$0040 : STA.b WRAM.TextDestination : TAX

        BRL .inputSuccess

    .notUp

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Down : BEQ .notDown
        ; Restore the buffer tile.
        LDA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        ; Move the destination.
        LDA.b WRAM.TextDestination
        CLC : ADC.w #$0040 : STA.b WRAM.TextDestination : TAX

        BRL .inputSuccess

    .notDown

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Left : BEQ .notLeft
        ; Restore the buffer tile.
        LDA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        ; Move the destination.
        LDA.b WRAM.TextDestination
        SEC : SBC.w #$0002 : STA.b WRAM.TextDestination : TAX

        BRL .inputSuccess

    .notLeft

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Right : BEQ .notRight
        ; Restore the buffer tile.
        LDA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        ; Move the destination.
        LDA.b WRAM.TextDestination
        CLC : ADC.w #$0002 : STA.b WRAM.TextDestination : TAX

        .inputSuccess

        ; Store the current tile as the buffer.
        LDA.l WRAM2.BG3TilemapBuffer, X : STA.b WRAM.TextTileBuffer

        ; Set the current tile to the _.
        LDA.w #!_ : EOR.b WRAM.TextProperties : STA.l WRAM2.BG3TilemapBuffer, X

        BRL .end

    .notRight

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_R : BEQ .notR
        SEP #$20

        ; Set the tile to the cursor tile properties.
        LDA.b WRAM.TextProperties+1 : XBA

        LDA.b WRAM.TextTileBuffer : INC : CMP.b #$80 : BCC .LessThan80
            LDA.b #$00

        .LessThan80

        REP #$30

        STA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        BRL .end

    .notR

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_L : BEQ .notL
        SEP #$20

        ; Set the tile to the cursor tile properties.
        LDA.b WRAM.TextProperties+1 : XBA

        LDA.b WRAM.TextTileBuffer : DEC : BPL .positive
            LDA.b #$7F

        .positive

        REP #$30

        STA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        BRA .end

    .notL

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_B : BEQ .notB
        SEP #$20
        LDA.b #$00 : STA.l WRAM2.BG3TilemapBuffer, X : STA.b WRAM.TextTileBuffer

        BRA .end

    .notB

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_X : BEQ .notX
        SEP #$20

        LDA.b WRAM.TextTileBuffer+1 : AND.b #$1C : STA.b $00
        LDA.b WRAM.TextProperties+1 : AND.b #$1C : CMP.b $00 : BEQ .sameColor
            ; If the current tile color does not equal our cursor color, set the
            ; tile to the cursor color.
            LDA.b WRAM.TextTileBuffer+1 : AND.b #$E3 : ORA.b WRAM.TextProperties+1

            BRA .notSameColor

        .sameColor

        ; Increase the palette by one.
        CLC : ADC.b #$04 : AND.b #$1C : STA.b $00

        LDA.b WRAM.TextProperties+1 : AND.b #$E3 : ORA.b $00

        STA.b WRAM.TextProperties+1

        .notSameColor
        
        STA.l WRAM2.BG3TilemapBuffer+1, X : STA.b WRAM.TextTileBuffer+1
        
        REP #$30

        BRA .end

    .notX

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Y : BEQ .notY
        SEP #$20

        ; Increase the palette by one.
        LDA.b WRAM.TextTileBuffer+1 : CLC : ADC.b #$40 : AND.b #$C0 : STA.b $00

        LDA.b WRAM.TextTileBuffer+1 : AND.b #$3F : ORA.b $00

        STA.l WRAM2.BG3TilemapBuffer+1, X : STA.b WRAM.TextTileBuffer+1
        
        REP #$30

        LDA.b WRAM.TextTileBuffer : STA.l WRAM2.BG3TilemapBuffer, X

        BRA .end

    .notY

    BRA .noInput

    .end

    STZ.b WRAM.TextCounter

    .noInput

    SEP #$30

    LDA.b #$04 : STA.b WRAM.BGTileMapUpdateMask

    RTS
}

; ==============================================================================

; Waits for the player to press the given button.
; Text 0x05
TextWaitForInput:
{
    JSR.w TextBlinkCursor
    
    REP #$20

    ; If any of the bits match, we are done waiting.
    LDA.b WRAM.Joypad1PressedLow : AND.b WRAM.TextWork : BEQ .stillWaiting
        SEP #$20
        LDA.b #$01 : STA.b WRAM.Submodule ; Go back to main.

        STZ.b WRAM.TextCounter
        STZ.b WRAM.TextWork

    .stillWaiting

    SEP #$20

    RTS
}

; ==============================================================================

!playButton = $003C
!space = $0000

; Allows the player to select from a predetermined list of an options.
; Text 0x06
TextOptions:
{
    REP #$20

    ; Process input:
    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Up : BEQ .notUp
        LDA.b WRAM.TextWork : SEC : SBC.b WRAM.TextOptionYIncrement

        ; Make sure we haven't gone past the first option.
        BPL .greaterThan0_1
            CLC : ADC.b WRAM.TextOptionCount

        .greaterThan0_1

        STA.b WRAM.TextWork

    .notUp

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Down : BEQ .notDown
        LDA.b WRAM.TextWork : CLC : ADC.b WRAM.TextOptionYIncrement

        ; Make sure we haven't gone past the last option.
        CMP.b WRAM.TextOptionCount : BCC .lessThanMax_1
            SEC : SBC.b WRAM.TextOptionCount

        .lessThanMax_1

        STA.b WRAM.TextWork

    .notDown

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Left : BEQ .notLeft
        LDA.b WRAM.TextWork : SEC : SBC.w #$0001

        ; Make sure we haven't gone past the first option.
        BPL .greaterThan0_2
            CLC : ADC.b WRAM.TextOptionCount

        .greaterThan0_2

        STA.b WRAM.TextWork

    .notLeft

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_Right : BEQ .notRight
        LDA.b WRAM.TextWork : CLC : ADC.w #$0001

        ; Make sure we haven't gone past the last option.
        CMP.b WRAM.TextOptionCount : BCC .lessThanMax_2
            SEC : SBC.b WRAM.TextOptionCount

        .lessThanMax_2

        STA.b WRAM.TextWork

    .notRight

    LDA.b WRAM.Joypad1PressedLow : BIT.w #!Joypad1_16_A : BEQ .notA
        SEP #$20
        LDA.b #$01 : STA.b WRAM.Submodule ; Go back to TextMain.
        ; WRAM.TextWork is the what the player selected.

        REP #$20

    .notA

    REP #$10

    LDY.w #$0000

    ; Loop through all the options.
    .loop

        TYA : ASL : TAX
        LDA.w WRAM.TextOptionPositions, X : TAX

        LDA.w #!space

        ; If this is the selected option, draw an arrow instead.
        CPY.b WRAM.TextWork : BNE .notSelected
            LDA.w #!playButton

        .notSelected

        EOR.b WRAM.TextProperties : STA.l WRAM2.BG3TilemapBuffer, X
    INY : CPY.b WRAM.TextOptionCount : BNE .loop

    SEP #$30

    LDA.b WRAM.BGTileMapUpdateMask : ORA.b #$04 : STA.b WRAM.BGTileMapUpdateMask

    RTS
}

; ==============================================================================
; Text Helper Functions
; ==============================================================================

; Loads a test palette from ROM into the CGRAMBuffer in WRAM.
LoadTestPalette:
{
    PHB : PHK : PLB

    REP #$30

    LDX.w #$0000

    .loop
        LDA.w TestPalette, X : STA.w WRAM.CGRAMData, X
                               STA.w WRAM.CGRAMBuffer, X

    INX : INX : CPX.w #$0200 : BNE .loop

    SEP #$30

    INC.b WRAM.CGRAMUpdate

    PLB

    RTL
}

!ColorBlack = HexTo555($000000)
!LightGray = HexTo555($B0B0B0)
!ColorWhite = HexTo555($FFFFFF)

!DeepRed = HexTo555($8C0000)
!DeepOrange = HexTo555($F77000)
!DeepYellow = HexTo555($FFD700)
!DeepGreen = HexTo555($008C00)
!DeepCyan = HexTo555($008C8C)
!DeepBlue = HexTo555($00008C)
!DeepMagenta = HexTo555($8C008C)

; TODO: Move this somewhere else.
TestPalette:
{
    ; Line 0
    dw !ColorBlack, !ColorWhite, !LightGray,  !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepRed,    !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepOrange, !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepYellow, !ColorWhite
    
    ; Line 1
    dw !ColorBlack, !ColorWhite, !DeepGreen,   !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepCyan,    !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepBlue,    !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepMagenta, !ColorWhite
    
    ; Line 2
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line 3
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line 4
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line 5
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line 6
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line 7
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line 8
    dw !ColorBlack, !ColorWhite, !LightGray,  !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepRed,    !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepOrange, !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepYellow, !ColorWhite
    
    ; Line 9
    dw !ColorBlack, !ColorWhite, !DeepGreen,   !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepCyan,    !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepBlue,    !ColorWhite
    dw !ColorBlack, !ColorWhite, !DeepMagenta, !ColorWhite

    ; Line A
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line B
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line C
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line D
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line E
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite

    ; Line F
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorBlack, !ColorWhite, !ColorWhite, !ColorWhite
    dw !ColorWhite, !ColorWhite, !ColorWhite, !ColorWhite
}

LoadGFXInto2bppBuffer_LONG:
{
    JSR.w LoadGFXInto2bppBuffer

    RTL
}

; Loads the 2bpp small font GFX into the GFX2bppBuffer in WRAM.
LoadGFXInto2bppBuffer:
{
    ; Set the bank.
    PHB : LDA.b #SmallFontGFX2bpp>>16 : PHA : PLB

    REP #$30

    LDX.w #$0000
    .loop

        LDA.w SmallFontGFX2bpp, X : STA.l WRAM2.GFX2bppBuffer, X
    INX : INX : CPX.w #$0800 : BNE .loop

    SEP #$30

    ; Restore the previous bank.
    PLB

    LDA.b WRAM.GFXUpdateMask : ORA.b #$02 : STA.b WRAM.GFXUpdateMask

    RTS
}

; Loops through a buffer that holds which chrs need to be updated.
ProcessGlitchCharsBG3:
{
    ; Only update every X frames.
    LDA.b WRAM.Counter : AND.b #$07 : BNE .dontUpdate
        REP #$30

        LDY.w #$0000

        .loop

            TYA : ASL : STA.b $02 : TAX
            ; Check if we need to scramble the tile.
            LDA.l WRAM.MiscBuffer0, X : AND.w #$00FF : CMP.w #$008E : BNE .notGlitch
                SEP #$20

                ; Get a valid tile.
                JSL.l GetRandomInt : AND.b #$7F : CMP.b #$55 : BCC .lessThan55
                    ; Greater than 55.
                    SEC : SBC.b #$55

                .lessThan55

                XBA : PHA : LDA.b #$00 : XBA

                TAX
                LDA.w MatrixCodeRainMain_validChrs, X

                XBA : PLA : XBA

                ; Cut out the palette and piority properties.
                REP #$20
                LDX.b $02
                AND.w #$C07F : STA.b $00
                
                ; Write the new tile.
                LDA.l WRAM2.BG3TilemapBuffer, X
                AND.w #$3F00 : ORA.b $00 : STA.l WRAM2.BG3TilemapBuffer, X

            .notGlitch
        INY : CPY.w #$0400 : BNE .loop

        SEP #$30

        LDA.b WRAM.BGTileMapUpdateMask
        ORA.b #$04 : STA.b WRAM.BGTileMapUpdateMask

    .dontUpdate

    RTS
}

; ==============================================================================
; Matrix Code Rain Module
; ==============================================================================

; Main Matrix code rain module.
MatrixCodeRainControl:
{
    PHB : PHK : PLB

    JSL.l BG2Move

    ; Submodule *2:
    LDA.b WRAM.Submodule : ASL : TAX
    JSR.w (.Modules, X)

    PLB

    RTL

    .Modules
    dw MatrixCodeRainPrep ; 0x00
    dw MatrixCodeRainMain ; 0x01
}

; Initializes the necessary WRAM values.
; Matrix 0x00
MatrixCodeRainPrep:
{
    JSR.w LoadMatrixPalette
    JSR.w LoadGFXIntoBuffer1

    LDA.b #SongToPlay : STA.b WRAM.SongQueue

    LDA.b #$0F : STA.b WRAM.Brightness
    LDA.b WRAM.MainScreenDes : ORA.b #$02 : STA.b WRAM.MainScreenDes
    INC.b WRAM.Submodule

    RTS
}

; Matrix 0x01
MatrixCodeRainMain:
{
    ; Only create a new drop every X frames.
    LDA.b WRAM.Counter : AND.b #$03 : BNE .dontPlaceNewDrop
        JSL.l GetRandomInt
        
        REP #$20
        ; Make it an even number and only the max X width.
        AND.w #$003E : TAX
        BRA .firstCheck

        .alreadyOneThere

            TXA
            
            .checkAgain

            CLC : ADC.w #$0012 : CMP.w #$0040 : BCC .lessThan40
                SEC : SBC.w #$0040

                BRA .checkAgain

            .lessThan40

            TAX

            .firstCheck
            ; Check the top line timers to see if we can place a tile there yet.
        LDA.l WRAM.MiscBuffer1, X : BNE .alreadyOneThere

        ; Load the tile with its properties.
        LDA.w #$1C40 : STA.l WRAM2.BG2TilemapBuffer, X

        SEP #$20

        ; Start the wait timer for that column.
        LDA.b #$11 : STA.l WRAM.MiscBuffer1, X

    .dontPlaceNewDrop

    ; Loop though the top line and decrement their timers.
    LDX.b #$40

    .loopTopLine

        DEX : DEX

        LDA.l WRAM.MiscBuffer1, X : BEQ .is0
            DEC : STA.l WRAM.MiscBuffer1, X

        .is0
    CPX.b #$00 : BNE .loopTopLine

    ; Only update every X frames.
    LDA.b WRAM.Counter : AND.b #$00 : BEQ .update
        RTS

    .update

    REP #$30

    LDY.w #$0400

    .bufferLoop
        DEY

        TYA : ASL : STA.b $02 : TAX
        ; Check if we need to scramble the tile.
        LDA.l WRAM2.BG2TilemapBuffer, X
        AND.w #$00FF : CMP.w #$0040 : BNE .notGlitch
            SEP #$20

            ; Get a valid tile.
            JSL.l GetRandomInt : AND.b #$7F : CMP.b #$55 : BCC .lessThan55
                ; Greater than 55.
                SEC : SBC.b #$55

            .lessThan55

            XBA : PHA : LDA.b #$00 : XBA

            TAX
            LDA.w .validChrs, X

            XBA : PLA : XBA

            ; Cut out the palette and piority properties.
            REP #$20
            LDX.b $02
            AND.w #$C07F : ORA.w #$1C00
            STA.l WRAM2.BG2TilemapBuffer, X

            ; Move the glitch down by one tile.
            TXA : CLC : ADC.w #$0020 : TAX
            LDA.w #$1C40 : STA.l WRAM2.BG2TilemapBuffer, X

            BRA .endLoop

        .notGlitch

        LDA.b WRAM.Counter : AND.w #$0001 : BNE .endLoop
            ; Cycle the palette.
            LDA.l WRAM2.BG2TilemapBuffer, X
            AND.w #$1C00 : XBA : LSR #2 : BEQ .Pal0
                DEC : ASL #2 : XBA : STA $00
                LDA.l WRAM2.BG2TilemapBuffer, X : AND.w #$E3FF : ORA.b $00
                STA.l WRAM2.BG2TilemapBuffer, X

            .Pal0

        .endLoop
    CPY.w #$0000 : BNE .bufferLoop

    SEP #$30

    LDA.b WRAM.BGTileMapUpdateMask
    ORA.b #$02 : STA.b WRAM.BGTileMapUpdateMask

    RTS

    .validChrs
    ;         0,   1,   2,   3,   4,   5,   6
    db      $01, $02, $03, $04, $05, $06, $07

    ;    7,   8,   A,   B,   C,   D,   E,   F
    db $08, $09, $0A, $0B, $0C, $0D, $0E, $0F 

    ;    G,   H,   I,   J,   K,   L,   M,   N
    db $10, $11, $12, $13, $14, $15, $16, $17

    ;    O,   P,   Q,   R,   S,   T,   U,   V
    db $18, $19, $1A, $1B, $1C, $1D, $1E, $1F

    ;    W,   X,   Y,   Z
    db $20, $21, $22, $23

    ;        H0,  H1,  H2,  H3,  H4,  H5,  H6
    db      $41, $42, $43, $44, $45, $46, $47

    ;   H7,  H8,  H9, H10
    db $48, $49, $4A, $4B, $4C, $4D, $4E, $4F

    db $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5A, $5B, $5C, $5D, $5E, $5F

    db $60, $61, $62, $63, $64, $65, $66, $67
    db $68, $69, $6A, $6B, $6C, $6D, $6E, $6F

    db $70, $71, $72, $73, $74, $75, $76, $77
    db $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
}

; ==============================================================================
; Matrix Code Rain Helper Functions
; ==============================================================================

; Loads the matrix palette from ROM into the CGRAMBuffer in WRAM.
LoadMatrixPalette:
{
    REP #$30

    LDX.w #$0000

    .loop
        LDA.w MatrixPalette, X
        STA.w WRAM.CGRAMData, X : STA.w WRAM.CGRAMBuffer, X

    INX : INX : CPX.w #$0200 : BNE .loop

    SEP #$30

    INC.b WRAM.CGRAMUpdate

    RTS
}

!ColorGreen0 = HexTo555($008C00)
!ColorGreen1 = HexTo555($007800)
!ColorGreen2 = HexTo555($006400)
!ColorGreen3 = HexTo555($005000)
!ColorGreen4 = HexTo555($003C00)
!ColorGreen5 = HexTo555($002800)
!ColorGreen6 = HexTo555($001400)

!ColorWhite0 = HexTo555($FFFFFF)
!ColorWhite1 = HexTo555($D8D8D8)
!ColorWhite2 = HexTo555($B7B7B7)
!ColorWhite3 = HexTo555($939393)
!ColorWhite4 = HexTo555($6F6F6F)
!ColorWhite5 = HexTo555($4B4B4B)
!ColorWhite6 = HexTo555($272727)

MatrixPalette:
{
    ; Line 0
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    
    ; Line 1
    dw !ColorBlack, !ColorWhite6, !ColorGreen6, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    
    ; Line 2
    dw !ColorBlack, !ColorWhite5, !ColorGreen5, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 3
    dw !ColorBlack, !ColorWhite4, !ColorGreen4, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 4
    dw !ColorBlack, !ColorWhite3, !ColorGreen3, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 5
    dw !ColorBlack, !ColorWhite2, !ColorGreen2, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 6
    dw !ColorBlack, !ColorWhite1, !ColorGreen1, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 7
    dw !ColorBlack, !ColorWhite0, !ColorGreen0, !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 8
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line 9
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line A
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line B
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line C
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line D
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line E
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack

    ; Line F
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
    dw !ColorBlack, !ColorBlack, !ColorBlack, !ColorBlack
}

; Loads some test GFX into the GFXBuffer in WRAM.
LoadGFXIntoBuffer1:
{
    ; Set the bank.
    PHB : LDA.b #SmallFontGFX>>16 : PHA : PLB

    REP #$30

    LDX.w #$0000
    .loop

        LDA.w SmallFontGFX, X : STA.l WRAM2.GFXBuffer, X
    INX : INX : CPX.w #$1000 : BNE .loop

    SEP #$30

    ; Restore the previous bank.
    PLB

    LDA.b WRAM.GFXUpdateMask : ORA.b #$01 : STA.b WRAM.GFXUpdateMask

    RTS
}

; ==============================================================================

print "End of Bank 0x01:   $", pc
print " "