; ==============================================================================
; Bank 0x00
; ==============================================================================
; NMI
; Main Game Loop
; Other test code.

print "Start of Bank 0x00: $", pc

; ==============================================================================
; RESET Code Start
; Used for Native and Emulation Mode.
; The SNES starts the game here.
; ==============================================================================

; Start the program.
NativeRES:
{
    ; Turn in native mode.
    CLC : XCE

    ; Turn the screen off.
    LDX.b #$80 : STX.w SNES.ScreenDisplay

    REP #$20

    ; Sets direct page to $0000.
    LDA.w #$0000 : TCD

    ; Set the stack pointer to $01FF.
    LDA.w #$01FF : TCS

    ; Reset M and D flags.
    REP #$08

    ; Clear APU Input/Output ports. 
    STZ.w SNES.APUIOPort0
    STZ.w SNES.APUIOPort1
    STZ.w SNES.APUIOPort2
    STZ.w SNES.APUIOPort3

    ; Clear WRAM.
    ; Fixed, Pattern 0 (WRAM) to SNES.IndirectWorkRAMPort.
    LDA.w #$8018     : STA.w DMA.0_TransferParameters
    LDA.w #.Zero     : STA.w DMA.0_SourceAddrOffsetLow
    LDX.b #.Zero>>16 : STX.w DMA.0_SourceAddrBank 
    LDA.w #$FFFF     : STA.w DMA.0_TransferSizeLow
    LDA.w #$0000     : STA.w SNES.IndirectWorkRAMAddrLow ; Address
    LDX.b #$00       : STX.w SNES.IndirectWorkRAMAddrHigh ; Bank 7E

    ; Fire the DMA.
    LDX.b #$01 : STX.w SNES.DMAChannelEnable

    ; Re-use most of the settings above.
    LDA.w #$0000     : STA.w SNES.IndirectWorkRAMAddrLow ; Address
    LDX.b #$7F       : STX.w SNES.IndirectWorkRAMAddrHigh ; Bank 7F

    ; Fire the DMA.
    LDX.b #$01 : STX.w SNES.DMAChannelEnable

    SEP #$20

    ; Setup the video RAM.
    JSR.w VideoInit

    ; Setup the APU.
    JSR.w APUInitialize

    LDA.b #$81 : STA.w SNES.NMIVHCountJoypadEnable

    ; TODO: Set starting module.
    LDA.b #$03 : STA.b WRAM.Module

    JMP Main

    .Zero
    dw $0000

    .Null
    dw $FFFF
}

; Clears most WRAM and initializes video settings.
VideoInit:
{
    REP #$20

    ; Clear the VRAM, OAM, and CGRAM.
    ; See https://snes.nesdev.org/wiki/DMA_registers

    ; Fixed, Pattern 1 (VRAM) to SNES.VRAMDataWriteLow.
    LDA.w #$1809              : STA.w DMA.0_TransferParameters
    LDA.w #NativeRES_Zero     : STA.w DMA.0_SourceAddrOffsetLow
    LDX.b #NativeRES_Zero>>16 : STX.w DMA.0_SourceAddrBank
    LDA.w #$0000              : STA.w DMA.0_TransferSizeLow

   ; Fixed, Pattern 2 (OAM and CGRAM) to SNES.OMADataWrite.
    LDA.w #$040A              : STA.w DMA.1_TransferParameters
    LDA.w #NativeRES_Null     : STA.w DMA.1_SourceAddrOffsetLow
    LDX.b #NativeRES_Null>>16 : STX.w DMA.1_SourceAddrBank
    LDA.w #$0220              : STA.w DMA.1_TransferSizeLow
    LDA.w #$0000              : STA.w SNES.OAMAccessAddr

    ; Fixed, Pattern 2 (OAM and CGRAM) to SNES.CGRAMWriteData.
    LDA.w #$220A              : STA.w DMA.2_TransferParameters
    LDA.w #NativeRES_Zero     : STA.w DMA.2_SourceAddrOffsetLow
    LDX.b #NativeRES_Zero>>16 : STX.w DMA.2_SourceAddrBank
    LDA.w #$0200              : STA.w DMA.2_TransferSizeLow

    ; Fire the DMAs.
    LDX.b #$07 : STX.w SNES.DMAChannelEnable

    SEP #$20

    LDA.b #$00
    STA.w SNES.BG1HScrollOffset
    STA.w SNES.BG1VScrollOffset
    STA.w SNES.BG2HScrollOffset
    STA.w SNES.BG2VScrollOffset
    STA.w SNES.BG3HScrollOffset
    STA.w SNES.BG3VScrollOffset
    STA.w SNES.BG4HScrollOffset
    STA.w SNES.BG4VScrollOffset

    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    LDA.b #$00 : STA.w SNES.VRAMAddrReadWriteLow
    LDA.b #$00 : STA.w SNES.VRAMAddrReadWriteHigh
    LDA.b #$09 : STA.w SNES.BGModeAndTileSize
    ; LDA.b #$11 : STA.w SNES.BGAndOBJEnableSubScreen
    
    STZ.w SNES.PPUStatusFlag1
    STZ.w SNES.PPUStatusFlag2
    STZ.w SNES.ScreenInit

    ; See the VRAM MAP in WRAM.asm.
    ; BG1 Tile map begins at $0000 in VRAM. Tile map is 64x64.
    LDA.b #$03 : STA.w SNES.BG1AddrAndSize

    ; BG2 Tile map begins at $2000 in VRAM. Tile map is 64x64.
    LDA.b #$13 : STA.w SNES.BG2AddrAndSize

    ; BG3 Tile map begins at $4000 in VRAM. Tile map is 64x64.
    LDA.b #$23 : STA.w SNES.BG3AddrAndSize

    ; BG4 Tile map begins at $4000 in VRAM. Tile map is 64x64.
    LDA.b #$23 : STA.w SNES.BG4AddrAndSize

    ; BG3 and BG4 Character Data is at $6000 in VRAM.
    LDA.b #$33 : STA.w SNES.BG3And4TileDataDes

    ; BG1 and BG2 Character Data is at $8000 in VRAM.
    LDA.b #$44 : STA.w SNES.BG1And2TileDataDes

    ; OAM Character Data is at $C000 in VRAM
    LDA.b #$03 : STA.w SNES.OAMSizeAndDataDes ; sssn nbbb

    RTS
}

; ==============================================================================
; NMI Code
; ==============================================================================

; The main NMI interupt.
; The NMI or Non-Maskable Interupt is what is run in between frames of the game.
; This takes place during the time the laser in the CRT TV takes to get from the
; bottom of the screen after having drawn a full frame to the top of the screen
; when its ready to draw a new frame.
; See: https://snes.nesdev.org/wiki/VBlank_interrupts
NativeNMI:
{
    ; Ensures this interrupt isn't interrupted by an IRQ.
    SEI

    ; Resets M and X flags.
    REP #$38

    ; Save the work registers to the stack.
    PHA : PHX : PHY : PHD : PHB

    ; Sets direct page to $0000.
    LDA.w #$0000 : TCD

    ; Equate Program and Data banks.
    PHK : PLB

    SEP #$30

    LDA.w SNES.NMIFlagAndCPUVersionNum ; Needed for the NMI.

    ; Turn off screen.
    LDA.b #$80 : STA.w SNES.ScreenDisplay

    ; Checks to see if we're still in the infinite loop in the main routine.
    ; If WRAM.NMIWaitFlag is not 0, it shows that the infinite loop isn't
    ; running. This prevents the NMI updates from running more than once per
    ; frame, preventing lag and preventing lost player input.
    LDA.b WRAM.NMIWaitFlag : BNE .normalFrameNotFinished
        JSR.w NMI_DoUpdates
        JSR.w ReadJoypads

        ; NMI has been ran.
        INC.b WRAM.NMIWaitFlag

    .normalFrameNotFinished

    ; Apply the BG scroll registers.
    ; Each register is written to twice for both the low and high bytes.

    ; BG1
    LDA.b WRAM.BG1HScrollOffset+0 : STA.w SNES.BG1HScrollOffset
    LDA.b WRAM.BG1HScrollOffset+1 : STA.w SNES.BG1HScrollOffset
    LDA.b WRAM.BG1VScrollOffset+0 : STA.w SNES.BG1VScrollOffset
    LDA.b WRAM.BG1VScrollOffset+1 : STA.w SNES.BG1VScrollOffset
    
    ; BG2
    LDA.b WRAM.BG2HScrollOffset+0 : STA.w SNES.BG2HScrollOffset
    LDA.b WRAM.BG2HScrollOffset+1 : STA.w SNES.BG2HScrollOffset
    LDA.b WRAM.BG2VScrollOffset+0 : STA.w SNES.BG2VScrollOffset
    LDA.b WRAM.BG2VScrollOffset+1 : STA.w SNES.BG2VScrollOffset
    
    ; BG3
    LDA.b WRAM.BG3HScrollOffset+0 : STA.w SNES.BG3HScrollOffset
    LDA.b WRAM.BG3HScrollOffset+1 : STA.w SNES.BG3HScrollOffset
    LDA.b WRAM.BG3VScrollOffset+0 : STA.w SNES.BG3VScrollOffset
    LDA.b WRAM.BG3VScrollOffset+1 : STA.w SNES.BG3VScrollOffset

    ; BG4
    ;LDA.b WRAM.BG4HScrollOffset+0 : STA.w SNES.BG4HScrollOffset
    ;LDA.b WRAM.BG4HScrollOffset+1 : STA.w SNES.BG4HScrollOffset
    ;LDA.b WRAM.BG4VScrollOffset+0 : STA.w SNES.BG4VScrollOffset
    ;LDA.b WRAM.BG4VScrollOffset+1 : STA.w SNES.BG4VScrollOffset

    ; Turn on screen.
    LDA.b WRAM.Brightness : STA.w SNES.ScreenDisplay

    LDA.b WRAM.MainScreenDes : STA.w SNES.BGAndOBJEnableMainScreen

    REP #$30

    ; Restore the work registers.
    PLB : PLD : PLY : PLX : PLA

    CLI

    RTI
}

NativeIRQ:
{
    RTI
}

; Runs DMA updates that need to be run during NMI.
NMI_DoUpdates:
{
    ; ================================================

    ; Handle the APU

    LDA.w WRAM.SongQueue : BNE .nonZeroMusicInput
        ; Check if the APU has handled the command we previously sent it:
        LDA.w SNES.APUIOPort0 : CMP.w WRAM.LastSong : BNE .handleAmbientSFXInput
            ; If the APU sent back the command we previously sent it, zero out
            ; the sent command so it doesn't get triggered again.
            STZ.w SNES.APUIOPort0
            
            BRA .handleAmbientSFXInput

    .nonZeroMusicInput

    ; Check if we are already playing the same song:
    CMP.w WRAM.LastSong : BEQ .sameSong
        ; The song has changed, tell the APU.
        STA.w SNES.APUIOPort0 : STA.w WRAM.LastSong

        STZ.w WRAM.SongQueue

    .sameSong

    .handleAmbientSFXInput

    ; TODO: Handle SFX.

    ; ================================================

    JSR.w WriteOAM

    ; CGRAM
    LDA.b WRAM.CGRAMUpdate : BEQ +
        JSR.w WriteCGRAM

        STZ.b WRAM.CGRAMUpdate
    +

    ; ================================================

    ; BG1 Tile map
    LDA.b WRAM.BGTileMapUpdateMask : AND.b #$01 : BEQ +
        JSR.w WriteBG1Tilemap

        LDA.b WRAM.BGTileMapUpdateMask : AND.b #$FE
        STA.b WRAM.BGTileMapUpdateMask
    +

    ; TODO: Optimize once blocks are established.
    ; Fire DMA block.
    LDA.b WRAM.DMAMask : BEQ +
        STA.w SNES.DMAChannelEnable

        STZ.b WRAM.DMAMask
    +

    ; ================================================

    ; BG2 Tile map
    LDA.b WRAM.BGTileMapUpdateMask : AND.b #$02 : BEQ +
        JSR.w WriteBG2Tilemap

        LDA.b WRAM.BGTileMapUpdateMask : AND.b #$FD
        STA.b WRAM.BGTileMapUpdateMask

        ; TODO: Optimize once blocks are established.
        ; Fire DMA block.
        LDA.b WRAM.DMAMask : STA.w SNES.DMAChannelEnable
        STZ.b WRAM.DMAMask
    +

    ; ================================================

    ; BG3 Tile map
    LDA.b WRAM.BGTileMapUpdateMask : AND.b #$04 : BEQ +
        JSR.w WriteBG3Tilemap

        LDA.b WRAM.BGTileMapUpdateMask : AND.b #$FB
        STA.b WRAM.BGTileMapUpdateMask

        ; TODO: Optimize once blocks are established.
        ; Fire DMA block.
        LDA.b WRAM.DMAMask : STA.w SNES.DMAChannelEnable
        STZ.b WRAM.DMAMask
    +

    ; ================================================

    ; 4bpp BG1 and BG2
    LDA.b WRAM.GFXUpdateMask : AND #$01 : BEQ +
        JSR.w WriteGFXBufferBG1BG2

        LDA.b WRAM.GFXUpdateMask : AND #$FE
        STA.b WRAM.GFXUpdateMask

        ; TODO: Optimize once blocks are established.
        ; Fire DMA block.
        LDA.b WRAM.DMAMask : STA.w SNES.DMAChannelEnable
        STZ.b WRAM.DMAMask
    +

    ; ================================================

    ; 2bpp BG3
    LDA.b WRAM.GFXUpdateMask : AND.b #$02 : BEQ +
        JSR.w WriteGFX2bppBuffer

        LDA.b WRAM.GFXUpdateMask : AND.b #$FD
        STA.b WRAM.GFXUpdateMask

        ; TODO: Optimize once blocks are established.
        ; Fire DMA block.
        LDA.b WRAM.DMAMask : STA.w SNES.DMAChannelEnable
        STZ.b WRAM.DMAMask
    +

    ; ================================================

    ; 4bpp OAM
    LDA.b WRAM.GFXUpdateMask : AND #$04 : BEQ +
        JSR.w WriteGFXBufferOAM

        LDA.b WRAM.GFXUpdateMask : AND #$FB
        STA.b WRAM.GFXUpdateMask

        ; TODO: Optimize once blocks are established.
        ; Fire DMA block.
        LDA.b WRAM.DMAMask : STA.w SNES.DMAChannelEnable
        STZ.b WRAM.DMAMask
    +

    ; ================================================

    ;STZ.b WRAM.GetDataFromAPU

    ; TODO: Fix this.
    STZ.b WRAM.BGTileMapUpdateMask
    STZ.b WRAM.GFXUpdateMask

    RTS
}

; Writes to CGRAM from the CGRAM buffer in WRAM.
WriteCGRAM:
{
    STZ.w SNES.CGRAMWriteAddr ; Set palette writing offset to 0.

    REP #$10
    LDA.b #$00            : STA.w DMA.0_TransferParameters

    ; Register CGRAMWriteData ($2122)
    LDA.b #$22            : STA.w DMA.0_DestinationAddr
    LDX.w #WRAM.CGRAMData : STX.w DMA.0_SourceAddrOffsetLow
    LDA.b #WRAM>>16       : STA.w DMA.0_SourceAddrBank
    LDX.w #$0200          : STX.w DMA.0_TransferSizeLow

    LDA.b WRAM.DMAMask : ORA.b #$01 : STA.b WRAM.DMAMask 
    SEP #$10

    RTS
}

; Writes to OAM WRAM from the OAM buffer in WRAM.
WriteOAM:
{
    REP #$10
    LDX.w #$0000             : STX.w SNES.OAMAccessAddr
    LDA.b #$00               : STA.w DMA.1_TransferParameters

    ; Register OMADataWrite ($2104)
    LDA.b #$04               : STA.w DMA.1_DestinationAddr
    LDX.w #WRAM.OAMLowBuffer : STX.w DMA.1_SourceAddrOffsetLow
    LDA.b #WRAM>>16          : STA.w DMA.1_SourceAddrBank
    LDX.w #$0220             : STX.w DMA.1_TransferSizeLow

    LDA.b WRAM.DMAMask : ORA.b #$02 : STA.b WRAM.DMAMask 
    SEP #$10

    RTS
}

; Reads joypad1 input and stores the results into 3 different variables.
; 1. JoypadXLow is the current state of the input.
; 2. JoypadXLastLow is the state of the input last frame.
; 3. JoypadXPressedLow is the current state of the input but only for one frame.
; So if you press A for 3 frames:
; +=======+========+============+===============+
; | Frame | Joypad | JoypadLast | JoypadPressed |
; +=======+========+============+===============+
; | 0     | 0      | 0          | 0             |
; +-------+--------+------------+---------------+
; | 1     | 1      | 0          | 1             |
; +-------+--------+------------+---------------+
; | 2     | 1      | 1          | 0             |
; +-------+--------+------------+---------------+
; | 3     | 1      | 1          | 0             |
; +-------+--------+------------+---------------+
; | 4     | 0      | 1          | 0             |
; +-------+--------+------------+---------------+
; | 5     | 0      | 0          | 0             |
; +-------+--------+------------+---------------+
ReadJoypads:
{
    ; Probably indicates that we're not using the old style joypad reading.
    STZ.w $4016

    REP #$30

    LDA.w #$0001

    --
        ; loop.
    BIT.w SNES.HVBlankFlagsAndJoyStatus : BNE --

    LDA.w SNES.JoyPad1DataLow : STA.b WRAM.Joypad1Low : TAY

    EOR.b WRAM.Joypad1LastLow : AND.b WRAM.Joypad1Low
    STA.b WRAM.Joypad1PressedLow : STY.b WRAM.Joypad1LastLow
    SEP #$30

    RTS
}

; ==============================================================================

; Writes to the BG1 and BG2 GFX section of the VRAM from the GFX buffer in WRAM.
WriteGFXBufferBG1BG2:
{
    REP #$20 ; A = 16, XY = 8

    ; Set the video port register every time we write it increase by 1.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA in VRAM <- this needs to be divided by 2.
    LDA.w #$4000 : STA.w SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA.w #$1801 : STA.w DMA.3_TransferParameters

    ; This is the source address where you want gfx from ROM.
    LDA.w #WRAM2.GFXBuffer : STA.w DMA.3_SourceAddrOffsetLow
    LDX.b #WRAM2>>16       : STX.w DMA.3_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA.w #$1000 : STA.w DMA.3_TransferSizeLow

    SEP #$20

    LDA.b WRAM.DMAMask : ORA.b #$08 : STA.b WRAM.DMAMask 

    RTS
}

; Writes to the OAM GFX section of the VRAM from the GFX buffer in WRAM.
WriteGFXBufferOAM:
{
    REP #$20 ; A = 16, XY = 8

    ; Set the video port register every time we write it increase by 1.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA in VRAM <- this needs to be divided by 2.
    LDA.w #$6000 : STA.w SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA.w #$1801 : STA.w DMA.3_TransferParameters

    ; This is the source address where you want gfx from ROM.
    LDA.w #WRAM2.GFXBuffer : STA.w DMA.3_SourceAddrOffsetLow
    LDX.b #WRAM2>>16       : STX.w DMA.3_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA.w #$1000 : STA.w DMA.3_TransferSizeLow

    SEP #$20

    LDA.b WRAM.DMAMask : ORA.b #$08 : STA.b WRAM.DMAMask 

    RTS
}

; Writes to the BG3 GFX section of the VRAM from the BG3 GFX buffer in WRAM.
WriteGFX2bppBuffer:
{
    REP #$20 ; A = 16, XY = 8

    ; Set the video port register every time we write it increase by 1.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA in VRAM <- this needs to be divided by 2.
    LDA.w #$3000 : STA.w SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA.w #$1801 : STA.w DMA.3_TransferParameters

    ; This is the source address where you want gfx from ROM.
    LDA.w #WRAM2.GFX2bppBuffer : STA.w DMA.3_SourceAddrOffsetLow
    LDX.b #WRAM2>>16           : STX.w DMA.3_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA.w #$1000 : STA.w DMA.3_TransferSizeLow

    SEP #$20

    LDA.b WRAM.DMAMask : ORA.b #$08 : STA.b WRAM.DMAMask 

    RTS
}

; ==============================================================================

; Writes to the BG1 tilemap from the BG1 tilemap buffer in WRAM.
WriteBG1Tilemap:
{
    REP #$20

    ; Set the video port register every time we write it increase by 1.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA $0000 in VRAM <- this need to be divided by 2.
    LDA.w #$0000 : STA.w SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA.w #$1801 : STA.w DMA.2_TransferParameters

    ; This is the source address where you want the data from ROM.
    LDA.w #WRAM2.BG1TilemapBuffer : STA.w DMA.2_SourceAddrOffsetLow
    LDX.b #WRAM2>>16              : STX.w DMA.2_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA.w #$0800 : STA.w DMA.2_TransferSizeLow

    SEP #$20

    LDA.b WRAM.DMAMask : ORA.b #$04 : STA.b WRAM.DMAMask

    RTS
}

; Writes to the BG2 Tilemap from the BG2 tilemap buffer in WRAM.
WriteBG2Tilemap:
{
    REP #$20

    ; Set the video port register every time we write it increase by 1.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA $0000 in VRAM <- this need to be divided by 2.
    LDA.w #$1000 : STA.w SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA.w #$1801 : STA.w DMA.2_TransferParameters

    ; This is the source address where you want the data from ROM.
    LDA.w #WRAM2.BG2TilemapBuffer : STA.w DMA.2_SourceAddrOffsetLow
    LDX.b #WRAM2>>16              : STX.w DMA.2_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA.w #$0800 : STA.w DMA.2_TransferSizeLow

    SEP #$20

    LDA.b WRAM.DMAMask : ORA.b #$04 : STA.b WRAM.DMAMask

    RTS
}

; Writes to the BG3 Tilemap from the BG3 buffer tilemap in WRAM.
WriteBG3Tilemap:
{
    REP #$20

    ; Set the video port register every time we write it increase by 1.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA $0000 in VRAM <- this need to be divided by 2.
    LDA.w #$2000 : STA.w SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA.w #$1801 : STA.w DMA.2_TransferParameters

    ; This is the source address where you want the data from ROM.
    LDA.w #WRAM2.BG3TilemapBuffer : STA.w DMA.2_SourceAddrOffsetLow
    LDX.b #WRAM2>>16              : STX.w DMA.2_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA.w #$0800 : STA.w DMA.2_TransferSizeLow

    SEP #$20

    LDA.b WRAM.DMAMask : ORA.b #$04 : STA.b WRAM.DMAMask

    RTS
}

; ==============================================================================
; Standardized DMA Functions
; ==============================================================================

; TODO: Finish this.
DMAChannel0:
{
    REP #$20 ; A = 16, XY = 8

    ; Turn the screen off (required).
    LDX #$80 : STX.w SNES.ScreenDisplay

    ; Set the video port register every time we write it increase by 1.
    LDX #$80 : STX.w SNES.VRAMAddrIncrementVal

    ; Destination of the DMA in VRAM <- this needs to be divided by 2.
    LDA #$5C00 : STA SNES.VRAMAddrReadWriteLow

    ; DMA Transfer Mode and destination register "001 => 2 registers write once.
    ; (2 bytes: p, p+1)"
    LDA #$1801 : STA DMA.0_TransferParameters

    ; This is the source address where you want gfx from ROM.
    LDA.w #SmallFontGFX : STA DMA.0_SourceAddrOffsetLow
    LDX.b #SmallFontGFX>>16 : STX.w DMA.0_SourceAddrBank

    ; Size of the transfer, #$0800 for each sheet.
    LDA #$4600 : STA DMA.0_TransferSizeLow

    ; Do the DMA.
    LDX #$01 : STX.w SNES.DMAChannelEnable

    ; Turn the screen back on.
    LDX #$0F : STX.w SNES.ScreenDisplay

    SEP #$20

    RTS
}

; ==============================================================================
; Standardized Math Functions
; ==============================================================================

; Input: A = dividend, X = divisor
; Output: A = quotient, X = remainder
Divide:
{
    REP #$20
    STA.w SNES.DividendLow

    STX.w SNES.DivisorB

    REP #$10

    NOP #07 ; Wait 16 machine cycles (including REP above).

    LDA.w SNES.DivideResultQuotientLow
    
    LDX.w SNES.RemainderResultLow

    SEP #$30

    RTS
}

; Input: A = multiplicand, X = multiplier
; Output: A = product
Multiply:
{
    STA.w SNES.MultiplicandA

    STX.w SNES.MultiplierB

    REP #$20

    NOP #03 ; Wait 8 machine cycles (including REP above).

    LDA.w SNES.RemainderResultLow

    SEP #$20

    RTS
}

; Generates a random int.
; See: https://en.wikipedia.org/wiki/Linear_congruential_generator
GetRandomInt:
{
    REP #$20

    ; * $10101
    LDA.b WRAM.RandomAccumulator : XBA : AND.w #$FF00 : STA.b $00
    LDA.b WRAM.RandomAccumulator : ASL : CLC : ADC.b $00
    CLC : ADC.b WRAM.RandomAccumulator

    ; + $415927
    CLC : ADC.w #$5927
    
    ; Add the program counter.
    CLC : ADC.b WRAM.Counter : STA.b WRAM.RandomAccumulator

    SEP #$20

    RTL
}

; ==============================================================================
; Standardized APU control functions.
; ==============================================================================

; This function sets up a transfer to move all of the SPC700 code, BRR samples,
; SFX data, and music data into the APU. If this function is not run at least
; once on boot none of the sound effects and music will work even if another
; load function is run.
APUInitialize:
{
    LDA.b #APUInitTransfer>>0  : STA.b $00
    LDA.b #APUInitTransfer>>8  : STA.b $01
    LDA.b #APUInitTransfer>>16 : STA.b $02
    
    SEI
    
    JSR.w APUTransfer
    
    CLI
    
    RTS
}

; This function transfers data to the APU by communicating with the SMP's boot
; ROM. $00-$02 is the long address in ROM to transfer the data from.
APUTransfer:
{
    REP #$30

    LDY.w #$0000
    LDA.w #$BBAA

    .waitForAPU

        ; Wait for the SMP to initialize with the message #$BBAA.
        ; If for whatever reason the APU was removed from the SNES, the
        ; game would get stuck here forever waiting for the APU to respond.
    CMP.w SNES.APUIOPort0 : BNE .waitForAPU

    SEP #$20
    LDA.b #$CC : PHA
    REP #$20

    .checkForAnotherTransfer

        ; If non-0, this is the number of bytes to transmit to the APU.
        ; If 0, this will tell the APU that the transfer is complete.
        LDA.b [$00], Y : TAX
        INY : INY

        ; If the previous byte was non-0, this will be the address in ARAM to
        ; transfer the data to. If the previous byte was 0, this will be the
        ; address in ARAM that the APU will jump to when its boot ROM is
        ; finished running.
        LDA.b [$00], Y : STA.w SNES.APUIOPort2
        INY : INY
        
        SEP #$20

        ; If the number of bytes left to transfer > 0, then we have a block
        ; to transfer.
        CPX.w #$0001 : BCS .startTransfer
            ; Tell the APU we don't have any more to transfer.
            STZ.w SNES.APUIOPort1

            ; Tell the APU to move on.
            PLA : STA.w SNES.APUIOPort0

            .sync

                ; Make sure the APU got the message that we're done.
            CMP.w SNES.APUIOPort0 : BNE .sync

            STZ.w SNES.APUIOPort0 : STZ.w SNES.APUIOPort1
            STZ.w SNES.APUIOPort2 : STZ.w SNES.APUIOPort3

            SEP #$30

            RTS

        .startTransfer

        ; Store the number of bytes to transfer.
        STX.b $03

        ; Tell the APU we have a block to transfer. Anything non-0 will do here.
        LDA.b #$01 : STA.w SNES.APUIOPort1
        
        ; Tell the APU we're ready to move on. This will be #$CC for the first
        ; transfer and will be the last byte index +3 for all of the following
        ; blocks.
        PLA : STA.w SNES.APUIOPort0

        .waitForTransfer

            ; Wait for the APU to send the #$CC or the byte index +3 back.
        CMP.w SNES.APUIOPort0 : BNE .waitForTransfer

        LDX.w #$0000

        .nextByte
            ; Send the data byte to the APU.
            LDA.b [$00], Y : STA.w SNES.APUIOPort1
            INY

            ; Are we at the end of a bank?
            CPY.w #$8000 : BNE .notBankEnd
                LDY.w #$0000
                
                ; Increment the bank of the address at [$00].
                INC.b $02

            .notBankEnd

            ; Tell the APU this is the next byte.
            TXA : STA.w SNES.APUIOPort0

            .waitForByteRecieved

                ; Wait the APU to respond with the same byte index,
                ; meaning it has read the byte and is ready for the next one.
            CMP.w SNES.APUIOPort0 : BNE .waitForByteRecieved
        ; Check if we have anymore bytes to send.
        INX : CPX.b $03 : BNE .nextByte

        ; If we've made it here, that means we've reached the end of the block.

        TXA

        ; To tell the APU we are done with this block, we need to send the byte
        ; index that is greater than the last byte index +1.
        ; Add 3 to signal to the APU that we're done with that block.
        .noZero

            ; OPTIMIZE: If the blocks are laid out well enough, the loop
            ; wouldn't be needed.
            ; But don't let A be 0 or the APU will think this is the last block.
        ADC.b #$03 : BEQ .noZero

        ; Save this index value greater than 0 so that later we can tell the
        ; APU we have a new block.
        PHA

        REP #$20

    ; Essentially a do-while loop. If we have run this function we can safely
    ; assume theres at least one block to transfer.
    BRA .checkForAnotherTransfer
}

APUGetNotes_LONG:
{
    PHB : PHK : PLB

    JSR.w APUGetNotes

    PLB

    RTL
}

; Reads note data from the APU into WRAM.ChannelNoteArray.
APUGetNotes:
{
    SEI

    LDA.b #$7E : STA.b $03

    LDA.b #$69 : STA.w SNES.APUIOPort2
                 STA.b $00

    .waitForAPUInit
        ; Wait for the SMP to initialize with the message #$69.
    CMP.w SNES.APUIOPort1 : BNE .waitForAPUInit
    STA.w SNES.APUIOPort1

    LDX.b #$00

    .storeLoop

        REP #$20
        LDA.w .StoreValues, X : CMP.w #$FFFF : BEQ .endOfStoreLoop
            STA.b $01

            SEP #$20

            INX : INX : PHX

            LDX.b #$00
            LDY.b #$00

            ; Get the channel volume.
            .loop
                .waitForAPU
                    ; Wait for the SMP to initialize with the index of the data.
                CPX.w SNES.APUIOPort2 : BNE .waitForAPU

                ; Get the data and tell the APU we recieved it.
                LDA.w SNES.APUIOPort3 : STA.b [$01], Y
                STX.w SNES.APUIOPort2

                INY : INY
            INX : CPX.b #$08 : BNE .loop

            DEC.b $00
            LDA.b $00 : STA.w SNES.APUIOPort1

            .waitForAPUNext
                ; Wait for the SMP to move on.
            CMP.w SNES.APUIOPort1 : BNE .waitForAPUNext

            PLX
    BRA .storeLoop

    .endOfStoreLoop

    SEP #$20

    ;DEC.b $00
    ;LDA.b $00 : STA.w SNES.APUIOPort1

    ;.waitForAPUEnd
        ; Wait for the SMP to end.
    ;CMP.w SNES.APUIOPort1 : BNE .waitForAPUEnd
    
    ; TODO: We should be able to reset 0, figure out why we can't.
    LDA.b #$00 ;: STA.w SNES.APUIOPort0
                 ;STA.w SNES.APUIOPort1
                 STA.w SNES.APUIOPort2
                 STA.w SNES.APUIOPort3

    CLI

    RTS

    .StoreValues
    dw WRAM.ChannelNoteArray
    dw WRAM.ChannelDurationArray
    dw WRAM.ChannelStaccatoArray
    dw WRAM.ChannelInstrumentArray
    dw WRAM.ChannelVolumeArray
    dw $FFFF
}

; ==============================================================================
; Standardized BG control functions.
; ==============================================================================

BG1Move:
{
    REP #$20 ; A = 16, XY = 8
    LDA.b WRAM.BG1HScrollOffset
    CLC : ADC.b WRAM.BG1HScrollSpeed : STA.b WRAM.BG1HScrollOffset

    LDA.b WRAM.BG1VScrollOffset
    CLC : ADC.b WRAM.BG1VScrollSpeed : STA.b WRAM.BG1VScrollOffset
    SEP #$20

    RTL
}

BG2Move:
{
    REP #$20 ; A = 16, XY = 8
    LDA.b WRAM.BG2HScrollOffset
    CLC : ADC.b WRAM.BG2HScrollSpeed : STA.b WRAM.BG2HScrollOffset
    
    LDA.b WRAM.BG2VScrollOffset
    CLC : ADC.b WRAM.BG2VScrollSpeed : STA.b WRAM.BG2VScrollOffset
    SEP #$20

    RTL
}

BG3Move:
{
    REP #$20 ; A = 16, XY = 8
    LDA.b WRAM.BG3HScrollOffset
    CLC : ADC.b WRAM.BG3HScrollSpeed : STA.b WRAM.BG3HScrollOffset
    
    LDA.b WRAM.BG3VScrollOffset
    CLC : ADC.b WRAM.BG3VScrollSpeed : STA.b WRAM.BG3VScrollOffset
    SEP #$20

    RTL
}

BG4Move:
{
    REP #$20 ; A = 16, XY = 8
    LDA.b WRAM.BG4HScrollOffset
    CLC : ADC.b WRAM.BG4HScrollSpeed : STA.b WRAM.BG4HScrollOffset
    
    LDA.b WRAM.BG4VScrollOffset
    CLC : ADC.b WRAM.BG4VScrollSpeed : STA.b WRAM.BG4VScrollOffset
    SEP #$20

    RTL
}

; Uses a DMA transfer to set all of the bytes in the BG1Tilemap to 0000.
ClearBG1TileMap:
{
    PHB : PHK : PLB

    REP #$20

    ; Clear the BG1 Buffer.
    ; Fixed, Pattern 0 (WRAM) to SNES.IndirectWorkRAMPort.
    LDA.w #$8018                      : STA.w DMA.0_TransferParameters
    LDA.w #NativeRES_Zero             : STA.w DMA.0_SourceAddrOffsetLow
    LDX.b #NativeRES_Zero>>16         : STX.w DMA.0_SourceAddrBank 
    LDA.w #$2000                      : STA.w DMA.0_TransferSizeLow
    LDA.w #WRAM2.BG1TilemapBuffer     : STA.w SNES.IndirectWorkRAMAddrLow ; Address
    LDX.b #WRAM2.BG1TilemapBuffer>>16 : STX.w SNES.IndirectWorkRAMAddrHigh ; Bank 7F

    ; Fire the DMA.
    LDX.b #$01 : STX.w SNES.DMAChannelEnable

    SEP #$20

    PLB

    RTL
}

; Uses a DMA transfer to set all of the bytes in the BG2Tilemap to 0000.
ClearBG2TileMap:
{
    PHB : PHK : PLB

    REP #$20

    ; Clear the BG2 Buffer.
    ; Fixed, Pattern 0 (WRAM) to SNES.IndirectWorkRAMPort.
    LDA.w #$8018                      : STA.w DMA.0_TransferParameters
    LDA.w #NativeRES_Zero             : STA.w DMA.0_SourceAddrOffsetLow
    LDX.b #NativeRES_Zero>>16         : STX.w DMA.0_SourceAddrBank 
    LDA.w #$2000                      : STA.w DMA.0_TransferSizeLow
    LDA.w #WRAM2.BG2TilemapBuffer     : STA.w SNES.IndirectWorkRAMAddrLow ; Address
    LDX.b #WRAM2.BG2TilemapBuffer>>16 : STX.w SNES.IndirectWorkRAMAddrHigh ; Bank 7F

    ; Fire the DMA.
    LDX.b #$01 : STX.w SNES.DMAChannelEnable

    SEP #$20

    PLB

    RTL
}

; Uses a DMA transfer to set all of the bytes in the BG3Tilemap to 0000.
ClearBG3TileMap:
{
    PHB : PHK : PLB

    REP #$20

    ; Clear the BG3 Buffer.
    ; Fixed, Pattern 0 (WRAM) to SNES.IndirectWorkRAMPort.
    LDA.w #$8018                      : STA.w DMA.0_TransferParameters
    LDA.w #NativeRES_Zero             : STA.w DMA.0_SourceAddrOffsetLow
    LDX.b #NativeRES_Zero>>16         : STX.w DMA.0_SourceAddrBank 
    LDA.w #$2000                      : STA.w DMA.0_TransferSizeLow
    LDA.w #WRAM2.BG3TilemapBuffer     : STA.w SNES.IndirectWorkRAMAddrLow ; Address
    LDX.b #WRAM2.BG3TilemapBuffer>>16 : STX.w SNES.IndirectWorkRAMAddrHigh ; Bank 7F

    ; Fire the DMA.
    LDX.b #$01 : STX.w SNES.DMAChannelEnable

    SEP #$20

    PLB

    RTL
}

; ==============================================================================
; Palette manimupation functions.
; TODO: Add fade to black and fade to white functions.
; ==============================================================================

; The ASM version of Kan's hexto55 function for Asar. Converts the RGB Hex color
; format into the SNES 555 format.
; Input: $00 = Hex Blue, $01 = Hex Green, $02 = Hex Red
; Output: $06[0x02]
; (h) = ((((h&$FF)/8)<<10)|(((h>>8&$FF)/8)<<5)|(((h>>16&$FF)/8)<<0))
RGBTo555:
{
    REP #$20

    LDA.b $00 : AND.w #$00F8 : ASL #7             : STA.b $06
    LDA.b $01 : AND.w #$00F8 : ASL #2 : ORA.b $06 : STA.b $06
    LDA.b $02 : AND.w #$00F8 : LSR #3 : ORA.b $06 : STA.b $06

    SEP #$20

    RTS
}

; Converts a RGB hex color format into the HSV color format.
; See: https://stackoverflow.com/questions/24152553/hsv-to-rgb-and-back-without-floating-point-math-in-python
; Input: $00 = Hex Blue, $01 = Hex Green, $02 = Hex Red
; Output: $03 = H, $04 = S, $05 = V
; Used: $00 - $07
RGBToHSV:
{
    !Blue       = $00
    !Green      = $01
    !Red        = $02
    !Hue        = $03
    !Saturation = $04
    !Value      = $05
    !RGBMax     = $05
    !RGBMin     = $06
    !DeltaRGB   = $07

    ; Find RGB_Max.
    LDA.b !Blue : CMP.b !Green : BCS .0IsBigger
        ; !Green is bigger.
        LDA.b !Green

    .0IsBigger

    CMP.b !Red : BCS .2IsBigger
        ; !Red is bigger.
        LDA.b !Red

    .2IsBigger

    ; Compute the value.
    STA !Value ; V AND RGB_Max

    BNE .not0_1 ; if V == 0:
        STZ.b !Hue : STZ.b !Saturation
        RTS

    .not0_1

    ; Find RGB_Min.
    LDA.b !Blue : CMP.b !Green : BCC .0IsSmaller
        ; !Green is smaller.
        LDA.b !Green

    .0IsSmaller

    CMP.b !Red : BCC .2IsSmaller
        ; !Red is smaller.
        LDA.b !Red

    .2IsSmaller

    STA.b !RGBMin

    ; Compute the saturation value.
    LDA.b !RGBMax : SEC : SBC.b !RGBMin : STA.b !DeltaRGB ; (RGB_Max - RGB_Min)

    ; ((RGB_Max - RGB_Min) * 256) - (RGB_Max - RGB_Min) = * 255
    XBA : LDA.b #$00 
    
    REP #$20
    SEC : SBC.b !DeltaRGB
    SEP #$20

    LDX.b !Value
    JSR.w Divide : STA.b !Saturation ; // V

    BNE .not0_2
        STZ.b !Hue

        RTS

    .not0_2

    ; Compute the Hue.
    LDA.b !RGBMax : CMP.b !Red : BNE .notRed
        LDA.b !Green : SEC : SBC.b !Blue ; (G - B)
        LDX.b !DeltaRGB
        JSR.w Divide ; // (RGB_Max - RGB_Min)

        LDX.b #$2B
        JSR.w Multiply ; * 43

        STA.b !Hue
        
        BRA .end

    .notRed

    CMP.b !Green : BNE .notGreen
        LDA.b !Blue : SEC : SBC.b !Red ; (B - R)
        LDX.b !DeltaRGB
        JSR.w Divide ; // (RGB_Max - RGB_Min)

        LDX.b #$2B
        JSR.w Multiply ; * 43

        CLC : ADC.b #$55 : STA.b !Hue ; + 85

        BRA .end

    .notGreen

    CMP.b !Blue : BNE .notBlue
        LDA.b !Red : SEC : SBC.b !Green ; (R - G)
        LDX.b !DeltaRGB
        JSR.w Divide ; // (RGB_Max - RGB_Min)

        LDX.b #$2B
        JSR.w Multiply ; * 43

        CLC : ADC.b #$AB : STA.b !Hue ; + 171

        ; BRA .end

    .notBlue
    
    .end

    RTS
}

; Converts a HSV hex color format into an RGB hex color format.
; Input: $03 = H, $04 = S, $05 = V
; Output: $00 = Hex Blue, $01 = Hex Green, $02 = Hex Red
; Used: $00 - $0A
HSVToRGB:
{
    !Blue       = $00
    !Green      = $01
    !Red        = $02
    !Hue        = $03
    !Saturation = $04
    !Value      = $05
    !Region     = $06
    !Remainder  = $07
    !P          = $08
    !Q          = $09
    !T          = $0A

    ; Check if the color is Grayscale.
    LDA.b !Saturation : BNE .notGray
        LDA.b !Value : STA.b !Blue : STA.b !Green : STA.b !Red

        RTS

    .notGray

    ; Make hue 0-5.
    LDA.b #$00 : XBA
    LDA.b !Hue
    LDX.b #$2B
    JSR.w Divide ; // 43
    STA.b !Region

    ; Find remainder part, make it from 0-255.
    TXA : STA.b !Remainder

    ; (((A * 2) + 1) * 2 ) == * 6
    ASL : CLC : ADC.b !Remainder : ASL : STA.b !Remainder

    ; Calculate temp vars, doing integer multiplication.
    ; P
    LDA.b #$FF : SEC : SBC.b !Saturation ; (255 - S)
    LDX.b !Value
    JSR.w Multiply ; * V
    XBA : STA.b !P ; >> #08

    ; Q
    LDA.b !Saturation
    LDX.b !Remainder
    JSR.w Multiply ; (S * remainder)
    XBA : STA !Q ; >> #08

    LDA.b #$FF : SEC : SBC.b !Q ; (255 - ((S * remainder) >> 8)))
    LDX.b !Value
    JSR.w Multiply ; * V
    XBA : STA.b !Q ; >> #08

    ; T
    LDA.b #$FF : SEC : SBC.b !Remainder ; (255 - remainder)
    LDX.b !Saturation
    JSR.w Multiply ; * S
    XBA : STA.b !T ; >> #08

    LDA.b #$FF : SEC : SBC.b !T ; (255 - ((S * (255 - remainder)) >> 8)))
    LDX.b !Value
    JSR.w Multiply ; * V
    XBA : STA.b !T ; >> #08

    ; Assign temp vars based on color cone region.
    LDA.b !Region : BNE .not0
        LDA.b !Value : STA.b !Red
        LDA.b !T     : STA.b !Green
        LDA.b !P     : STA.b !Blue

        RTS

    .not0

    CMP.b #$01 : BNE .not1
        LDA.b !Q     : STA.b !Red
        LDA.b !Value : STA.b !Green
        LDA.b !P     : STA.b !Blue

        RTS

    .not1

    CMP.b #$02 : BNE .not2
        LDA.b !P     : STA.b !Red
        LDA.b !Value : STA.b !Green
        LDA.b !T     : STA.b !Blue

        RTS

    .not2

    CMP.b #$03 : BNE .not3
        LDA.b !P     : STA.b !Red
        LDA.b !Q     : STA.b !Green
        LDA.b !Value : STA.b !Blue

        RTS

    .not3

    CMP.b #$04 : BNE .not4
        LDA.b !T     : STA.b !Red
        LDA.b !P     : STA.b !Green
        LDA.b !Value : STA.b !Blue

        RTS

    .not4

    LDA.b !Value : STA.b !Red
    LDA.b !P     : STA.b !Green
    LDA.b !Q     : STA.b !Blue

    RTS
}

; Cycle through a stored hue value over time and store it in the 4th color in
; the first palette.
CycleRainbowPalette:
{
    PHB : PHK : PLB

    LDA.b WRAM.TextRainbow : BEQ .noRainbow
        STZ.b $00 : STZ.b $01 : STZ.b $02

        LDA.b $0F : STA.b $03 ; Set the hue.
        LDA.b #$FF : STA.b $04 ; Set the saturation.
        LDA.b #$7F : STA.b $05 ; Set the value.

        JSR.w HSVToRGB
        JSR.w RGBTo555

        REP #$20
        STA.w WRAM.CGRAMData+$04 : STA.w WRAM.CGRAMBuffer+$04
        SEP #$20

        INC.b $0F

        INC.b WRAM.CGRAMUpdate

    .noRainbow

    PLB

    RTL
}

; ==============================================================================
; Main Game Code
; ==============================================================================

; After all the program setup, start our main game loop.
Main:
{
    .loop
        STZ.b WRAM.NMIWaitFlag

        .wait
            ; Wait until NMI has been run to start the next frame.
        LDA.b WRAM.NMIWaitFlag : BEQ .wait

        INC.b WRAM.Counter

        JSR.w ClearOAM

        ; Always turn on the screen.
        LDA.b WRAM.Brightness : STA.w SNES.ScreenDisplay

        ; OPTIMIZE: This may not be necessary, ClearOAM already sets this.
        ; Always start our frame on 8 bit.
        SEP #$30

        JSL.l ModuleHandler

        ; Merge the OAM after all the game code is run so we catch all the draw
        ; that was run this frame.
        JSR.w MergeOAM
    BRA .loop
}

; The main game state handler.
ModuleHandler:
{
    ; Module *3:
    LDA.b WRAM.Module : ASL : CLC : ADC.b WRAM.Module : TAX
    LDA.w .Modules+0, X : STA.b $00
    LDA.w .Modules+1, X : STA.b $01
    LDA.w .Modules+2, X : STA.b $02

    JML.w [$0000]

    .Modules
    dl TextModuleControl        ; 0x00
    dl SpriteControl            ; 0x01
    dl MatrixCodeRainControl    ; 0x02
    dl MusicPlayerModuleControl ; 0x03
    dl TestRandom               ; 0x04
    dl Count8BitLong            ; 0x05

    ; TODO: Add player handler.
    ; TODO: Add a tilemap scroller.
    ; TODO: Add some funky HDMA effects.
    ; TODO: Add SRM handler.
    ; TODO: Add 3D object handler.
}

; ==============================================================================
; Main Game Code helper functions
; ==============================================================================

; Clears out all of the OAM data in the WRAM buffer.
ClearOAM:
{
    ; Init OAM Data to be outside of screen.
    REP #$10
    LDX.w #$01FF
    LDA.b #$F0

    -- 
        STA.w WRAM.OAMLowBuffer, X
        DEX
    BNE --


    LDX.w #$001F
    LDA.b #$00

    -- 
        STA.w WRAM.OAMHighBuffer, X
        DEX
    BNE --

    LDX.w #$007F
    -- 
        STA.w WRAM.OAMDataExt, X
        DEX
    BNE --

    REP #$20

    ; TODO: Change these blocks.
    ; TODO: Add block end protection, don't allow draw functions to go past the
    ; end of the block somehow.
    LDA.w #WRAM.OAMLowBuffer+$0000 : STA.b WRAM.OAMPointerBlockA
    LDA.w #WRAM.OAMLowBuffer+$0080 : STA.b WRAM.OAMPointerBlockB
    LDA.w #WRAM.OAMLowBuffer+$0100 : STA.b WRAM.OAMPointerBlockC
    LDA.w #WRAM.OAMLowBuffer+$0180 : STA.b WRAM.OAMPointerBlockD
    LDA.w #WRAM.OAMLowBuffer+$0000 : STA.b WRAM.OAMPointerBlockE

    LDA.w #WRAM.OAMDataExt+$0000 : STA.b WRAM.OAMPointerExtBlockA
    LDA.w #WRAM.OAMDataExt+$0080 : STA.b WRAM.OAMPointerExtBlockB
    LDA.w #WRAM.OAMDataExt+$0100 : STA.b WRAM.OAMPointerExtBlockC
    LDA.w #WRAM.OAMDataExt+$0180 : STA.b WRAM.OAMPointerExtBlockD
    LDA.w #WRAM.OAMDataExt+$0000 : STA.b WRAM.OAMPointerExtBlockE

    SEP #$30

    RTS
}

; Merges the OAMDataExt down into its actual size.
; Each OAM entry only needs 2 bits per entry but its annoying to condense 4
; entries down into one byte while running draw functions so instead we store
; them in separate bytes during draw and merge them back down here. 
MergeOAM:
{
    LDX.b #$00
    LDY.b #$00

    ----
        LDA.w WRAM.OAMDataExt+3, Y             : STA.b $04
        ASL.b $04 : ASL.b $04

        LDA.w WRAM.OAMDataExt+2, Y : ORA.b $04 : STA.b $04
        ASL.b $04 : ASL.b $04

        LDA.w WRAM.OAMDataExt+1, Y : ORA.b $04 : STA.b $04
        ASL.b $04 : ASL.b $04

        LDA.w WRAM.OAMDataExt+0, Y : ORA.b $04 : STA.b $04
        INY : INY  : INY  : INY

        STA.w WRAM.OAMHighBuffer+0, X
    INX : CPX.b #$20 : BNE ----

    RTS
}

; ==============================================================================
; Test modules
; ==============================================================================

; An early test function.
; Counts up on $05-$07.
Count8BitLong:
{
    LDX.b #$00

    CLC

    LDA.b $07 : CLC : ADC.b #$01 : STA.b $07
        
    BCC +
        LDA.b $06 : CLC : ADC.b #$01 : STA.b $06
    +

    BCC +
        LDA.b $05 : CLC : ADC.b #$01 : STA.b $05
    +

    RTL
}

; A function that tests the capability of the GetRandomInt function.
TestRandom:
{
    JSL.l GetRandomInt

    REP #$20 ; A = 16, XY = 8
    CMP.w #$0000 : BNE .not0
        NOP

    .not0

    SEP #$20

    RTL
}

; ==============================================================================

print "End of Bank 0x00:   $", pc
print " "