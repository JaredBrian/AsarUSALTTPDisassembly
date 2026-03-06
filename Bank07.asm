; ==============================================================================
; Bank 0x07
; ==============================================================================
; Music Player Module

print "Start of Bank 0x07: $", pc

; ==============================================================================
; Music Player Module
; ==============================================================================

; Main music player module handler.
MusicPlayerModuleControl:
{
    PHB : PHK : PLB

    JSL.l CycleRainbowPalette

    ; Submodule *2:
    LDA.b WRAM.Submodule : ASL : TAX
    JSR.w (.Modules, X)

    PLB

    RTL

    .Modules
    dw MusicPlayerPrep ; 0x00
    dw MusicPlayerRun  ; 0x01
    dw MusicPlayerTest ; 0x02
}

; ==============================================================================

; Music Player 0x00
MusicPlayerPrep:
{
    JSR.w LoadMusicPlayerPalette
    JSR.w LoadMusicPlayerGFXIntoBuffer1

    LDA.b #SongToPlay : STA.b WRAM.SongQueue

    LDA.b #.charPointers>>00 : STA.b $00
    LDA.b #.charPointers>>08 : STA.b $01
    LDA.b #.charPointers>>16 : STA.b $02
                               STA.b $05

    REP #$30

    .loop
        LDA.b [$00] : CMP.w #$FFFF : beq .endOfPointers
            STA.b $03
            LDA.b [$03] : TAX
            INC.b $03 : INC.b $03

            .textLoop

                LDA.b [$03] : CMP.w #$FFFF : beq .endOfText
                    ORA.w #$1400 : STA.l WRAM2.BG2TilemapBuffer, X
                    INX : INX
                    INC.b $03 : INC.b $03
            BRA .textLoop

            .endOfText

        .endOfText3
        INC.b $00 : INC.b $00
    BRA .loop

    .endOfPointers

    SEP #$30

    ; Index for the Hue cycle later.
    ;LDA.b #$A0 : STA.b $0F

    LDA.b #$0F : STA.b WRAM.Brightness
    LDA.b WRAM.MainScreenDes : ORA.b #$02 : STA.b WRAM.MainScreenDes
    INC.b WRAM.Submodule

    LDA.b WRAM.BGTileMapUpdateMask
    ORA.b #$02 : STA.b WRAM.BGTileMapUpdateMask

    RTS

    .charPointers
    dw .text1
    dw .text2
    dw .text3
    dw .text4
    dw .text5
    dw .text6
    dw .text7
    dw $FFFF

    incsrc "Data/Text/SmallFont.asm"

    .text1
    dw $0000
    dw "MUSIC PLAYER"
    dw $FFFF

    .text2
    dw $0040
    dw "1:", $0000, $0000
    dw "2:", $0000, $0000
    dw "3:", $0000, $0000
    dw "4:", $0000, $0000
    dw "5:", $0000, $0000
    dw "6:", $0000, $0000
    dw "7:", $0000, $0000
    dw "8:", $0000, $0000
    dw $FFFF

    .text3
    dw $0080
    dw "NOTE:"
    dw $FFFF

    .text4
    dw $0100
    dw "DURATION:"
    dw $FFFF

    .text5
    dw $0180
    dw "STACCATO:"
    dw $FFFF

    .text6
    dw $0200
    dw "INSTRUMENT:"
    dw $FFFF

    .text7
    dw $0280
    dw "VOLUME:"
    dw $FFFF

    cleartable
}

MusicPlayerTest:
{
    RTS
}

MusicPlayerRun:
{
    ; TODO: Speed test line.
    JSL APUGetNotes_LONG

    REP #$30

    LDY.w #$0000
    
    .charLoop

        LDA.w WRAM.ChannelNoteArray, Y : ASL : CLC : ADC.w WRAM.ChannelNoteArray, Y
        AND.w #$00FF : ASL : TAX
        LDA.w .notes+0, X : STA.w WRAM.ChannelNoteArrayChar1, Y
        LDA.w .notes+2, X : STA.w WRAM.ChannelNoteArrayChar2, Y
        LDA.w .notes+4, X : STA.w WRAM.ChannelNoteArrayChar3, Y

        LDA.w WRAM.ChannelDurationArray, Y : LSR : LSR : LSR
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelDurArrayChar1, Y

        LDA.w WRAM.ChannelDurationArray, Y : ASL
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelDurArrayChar2, Y

        LDA.w WRAM.ChannelStaccatoArray, Y : LSR : LSR : LSR
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelStaccArrayChar1, Y

        LDA.w WRAM.ChannelStaccatoArray, Y : ASL
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelStaccArrayChar2, Y

        LDA.w WRAM.ChannelInstrumentArray, Y : LSR : LSR : LSR
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelInsArrayChar1, Y

        LDA.w WRAM.ChannelInstrumentArray, Y : ASL
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelInsArrayChar2, Y

        LDA.w WRAM.ChannelVolumeArray, Y : LSR : LSR : LSR
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelVolArrayChar1, Y

        LDA.w WRAM.ChannelVolumeArray, Y : ASL
        AND.w #$001E : TAX
        LDA.w .hexNumbers, X : STA.w WRAM.ChannelVolArrayChar2, Y
        
        INY : INY : CPY.w #$0010 : BEQ .exitCharLoop
    BRL .charLoop

    .exitCharLoop

    STZ.b $00
    LDX.w #$00C0
    LDY.w #$0000
    
    .noteCharLoop

        LDA.w WRAM.ChannelNoteArrayChar1, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        LDA.w WRAM.ChannelNoteArrayChar2, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        LDA.w WRAM.ChannelNoteArrayChar3, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX
        
        INX : INX

        LDA.b $00 : CLC : ADC.w #$0400 : STA.b $00
    INY : INY : CPY.w #$0010 : BNE .noteCharLoop

    STZ.b $00
    LDX.w #$0140
    LDY.w #$0000

    .durationCharLoop

        LDA.w WRAM.ChannelDurArrayChar1, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        LDA.w WRAM.ChannelDurArrayChar2, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        INX : INX : INX : INX

        LDA.b $00 : CLC : ADC.w #$0400 : STA.b $00
    INY : INY : CPY.w #$0010 : BNE .durationCharLoop

    STZ.b $00
    LDX.w #$01C0
    LDY.w #$0000

    .staccatoCharLoop

        LDA.w WRAM.ChannelStaccArrayChar1, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        LDA.w WRAM.ChannelStaccArrayChar2, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        INX : INX : INX : INX

        LDA.b $00 : CLC : ADC.w #$0400 : STA.b $00
    INY : INY : CPY.w #$0010 : BNE .staccatoCharLoop

    STZ.b $00
    LDX.w #$0240
    LDY.w #$0000

    .instrumentCharLoop

        LDA.w WRAM.ChannelInsArrayChar1, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        LDA.w WRAM.ChannelInsArrayChar2, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        INX : INX : INX : INX

        LDA.b $00 : CLC : ADC.w #$0400 : STA.b $00
    INY : INY : CPY.w #$0010 : BNE .instrumentCharLoop

    STZ.b $00
    LDX.w #$02C0
    LDY.w #$0000

    .volumeCharLoop

        LDA.w WRAM.ChannelVolArrayChar1, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        LDA.w WRAM.ChannelVolArrayChar2, Y
        ORA.b $00 : STA.l WRAM2.BG2TilemapBuffer, X
        INX : INX

        INX : INX : INX : INX

        LDA.b $00 : CLC : ADC.w #$0400 : STA.b $00
    INY : INY : CPY.w #$0010 : BNE .volumeCharLoop

    SEP #$30

    LDA.b WRAM.BGTileMapUpdateMask
    ORA.b #$02 : STA.b WRAM.BGTileMapUpdateMask

    ;INC.b WRAM.Submodule

    RTS

    incsrc "Data/Text/SmallFont.asm"

    .notes
    dw $0030, $0030, $0030 ; ---
    ;dw $000C, $0002, $0000 ; C1
    dw $000C, $0002, $0036 ; C1s
    dw $000D, $0002, $0000 ; D1
    dw $000D, $0002, $0036 ; D1s
    dw $000E, $0002, $0000 ; E1
    dw $000F, $0002, $0000 ; F1
    dw $000F, $0002, $0036 ; F1s
    dw $0010, $0002, $0000 ; G1
    dw $0010, $0002, $0036 ; G1s
    dw $000A, $0002, $0000 ; A1
    dw $000A, $0002, $0036 ; A1s
    dw $000B, $0002, $0000 ; B1

    dw $000C, $0003, $0000 ; C2
    dw $000C, $0003, $0036 ; C2s
    dw $000D, $0003, $0000 ; D2
    dw $000D, $0003, $0036 ; D2s
    dw $000E, $0003, $0000 ; E2
    dw $000F, $0003, $0000 ; F2
    dw $000F, $0003, $0036 ; F2s
    dw $0010, $0003, $0000 ; G2
    dw $0010, $0003, $0036 ; G2s
    dw $000A, $0003, $0000 ; A2
    dw $000A, $0003, $0036 ; A2s
    dw $000B, $0003, $0000 ; B2

    dw $000C, $0004, $0000 ; C3
    dw $000C, $0004, $0036 ; C3s
    dw $000D, $0004, $0000 ; D3
    dw $000D, $0004, $0036 ; D3s
    dw $000E, $0004, $0000 ; E3
    dw $000F, $0004, $0000 ; F3
    dw $000F, $0004, $0036 ; F3s
    dw $0010, $0004, $0000 ; G3
    dw $0010, $0004, $0036 ; G3s
    dw $000A, $0004, $0000 ; A3
    dw $000A, $0004, $0036 ; A3s
    dw $000B, $0004, $0000 ; B3

    dw $000C, $0005, $0000 ; C4
    dw $000C, $0005, $0036 ; C4s
    dw $000D, $0005, $0000 ; D4
    dw $000D, $0005, $0036 ; D4s
    dw $000E, $0005, $0000 ; E4
    dw $000F, $0005, $0000 ; F4
    dw $000F, $0005, $0036 ; F4s
    dw $0010, $0005, $0000 ; G4
    dw $0010, $0005, $0036 ; G4s
    dw $000A, $0005, $0000 ; A4
    dw $000A, $0005, $0036 ; A4s
    dw $000B, $0005, $0000 ; B4

    dw $000C, $0006, $0000 ; C5
    dw $000C, $0006, $0036 ; C5s
    dw $000D, $0006, $0000 ; D5
    dw $000D, $0006, $0036 ; D5s
    dw $000E, $0006, $0000 ; E5
    dw $000F, $0006, $0000 ; F5
    dw $000F, $0006, $0036 ; F5s
    dw $0010, $0006, $000 ; G50
    dw $0010, $0006, $0036 ; G5s
    dw $000A, $0006, $0000 ; A5
    dw $000A, $0006, $0036 ; A5s
    dw $000B, $0006, $0000 ; B5

    dw $000C, $0007, $0000 ; C6
    dw $000C, $0007, $0036 ; C6s
    dw $000D, $0007, $0000 ; D6
    dw $000D, $0007, $0036 ; D6s
    dw $000E, $0007, $0000 ; E6
    dw $000F, $0007, $0000 ; F6
    dw $000F, $0007, $0036 ; F6s
    dw $0010, $0007, $0000 ; G6
    dw $0010, $0007, $0036 ; G6s
    dw $000A, $0007, $0000 ; A6
    dw $000A, $0007, $0036 ; A6s
    dw $000B, $0007, $0000 ; B6

    .hexNumbers
    dw "0", "1", "2", "3", "4", "5", "6", "7"
    dw "8", "9", "A", "B", "C", "D", "E", "F"

    cleartable
}

; ==============================================================================
; Music Player Helper Functions
; ==============================================================================

; Loads the music player palette from ROM into the CGRAMBuffer in WRAM.
LoadMusicPlayerPalette:
{
    REP #$30

    LDX.w #$0000

    .loop
        LDA.w MusicPlayerPalette, X
        STA.w WRAM.CGRAMData, X : STA.w WRAM.CGRAMBuffer, X

    INX : INX : CPX.w #$0200 : BNE .loop

    SEP #$30

    INC.b WRAM.CGRAMUpdate

    RTS
}

!ColorBlack = HexTo555($000000)
!ColorLightGray = HexTo555($B0B0B0)
!ColorWhite = HexTo555($FFFFFF)

!ColorRed = HexTo555($8C0000)
!ColorOrange = HexTo555($BF5802)
!ColorYellow = HexTo555($8F7801)
!ColorGreen = HexTo555($006900)
!ColorCyan = HexTo555($006664)
!ColorBlue = HexTo555($00008C)
!ColorPurple = HexTo555($673AB7)
!ColorMagenta = HexTo555($8C008C)

MusicPlayerPalette:
{
    ; Line 0
    dw !ColorBlack, !ColorWhite,    !ColorRed,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    
    ; Line 1
    dw !ColorBlack, !ColorWhite, !ColorOrange,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    
    ; Line 2
    dw !ColorBlack, !ColorWhite, !ColorYellow,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 3
    dw !ColorBlack, !ColorWhite,  !ColorGreen,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 4
    dw !ColorBlack, !ColorWhite,   !ColorCyan,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 5
    dw !ColorBlack, !ColorWhite,   !ColorBlue,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 6
    dw !ColorBlack, !ColorWhite, !ColorPurple,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 7
    dw !ColorBlack, !ColorWhite, !ColorMagenta,  !ColorBlack
    dw !ColorBlack, !ColorBlack,   !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,   !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,   !ColorBlack,  !ColorBlack

    ; Line 8
    dw !ColorBlack, !ColorWhite,    !ColorRed,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line 9
    dw !ColorBlack, !ColorWhite, !ColorOrange,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line A
    dw !ColorBlack, !ColorWhite, !ColorYellow,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line B
    dw !ColorBlack, !ColorWhite,  !ColorGreen,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line C
    dw !ColorBlack, !ColorWhite,   !ColorCyan,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line D
    dw !ColorBlack, !ColorWhite,   !ColorBlue,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line E
    dw !ColorBlack, !ColorWhite, !ColorPurple,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,  !ColorBlack,  !ColorBlack

    ; Line F
    dw !ColorBlack, !ColorWhite, !ColorMagenta,  !ColorBlack
    dw !ColorBlack, !ColorBlack,   !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,   !ColorBlack,  !ColorBlack
    dw !ColorBlack, !ColorBlack,   !ColorBlack,  !ColorBlack
}

; Loads some test GFX into the GFXBuffer in WRAM.
LoadMusicPlayerGFXIntoBuffer1:
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

print "End of Bank 0x07:   $", pc
print " "