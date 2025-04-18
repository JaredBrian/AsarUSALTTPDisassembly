; ==============================================================================

; Bank 00
; $000000-$00FFFF
org $008000

; ROM setup
; GFX decompression
; NMI control
; APU setup
; HDMA filters
; Palette filterss

; ==============================================================================

; $000000-$000060 JUMP LOCATION
Vector_Reset:
{
    SEI ; Set interrupt disable bits.

    ; Disables the NMI and various other things.
    STZ.w SNES.NMIVHCountJoypadEnable

    ; HDMA and DMA is disabled.
    STZ.w SNES.HDMAChannelEnable
    STZ.w SNES.DMAChannelEnable  

    ; Clear SPC locations. 
    STZ.w SNES.APUIOPort0
    STZ.w SNES.APUIOPort1
    STZ.w SNES.APUIOPort2
    STZ.w SNES.APUIOPort3

    ; Set brightness to zero and enable force blank (forced V-Blank all the
    ; time).
    LDA.b #$80 : STA.w SNES.ScreenDisplay

    ; Switch to native mode.
    CLC : XCE

    ; Reset M and D flags.
    REP #$28

    ; Direct page is at $0000.
    LDA.w #$0000 : TCD

    ; Stack is located at $01FF.
    LDA.w #$01FF : TCS

    SEP #$30 ; M and X are 8 bit.

    JSR.w Sound_LoadIntroSongBank
    JSR.w Startup_InitializeMemory

    ; Bit 7 enables NMI interrupt.
    ; This register tracks whether NMI is enabled.
    LDA.b #$81 : STA.w SNES.NMIVHCountJoypadEnable

    .nmi_wait_loop

            ; This loop doesn't normally exit unless NMI is enabled!
        LDA.b $12 : BEQ .nmi_wait_loop

        CLI ; Clear the interrupt disable bit.

        BRA .do_frame

        ; Inaccessible code, used for debug if assembled in.
        ; NOP out the above BRA to activate this code.
        .frameStepDebugCode

        ; If the L button is down, then...
        LDA.b $F6 : AND.b #$20 : BEQ .L_ButtonDown
            INC.w $0FD7

        .L_ButtonDown

        ; If the R button is down, then...
        LDA.b $F6 : AND.b #$10 : BNE .R_ButtonDown
            LDA.w $0FD7 : AND.b #$01 : BNE .skip_frame
                .R_ButtonDown
                
                .do_frame

                ; Frame counter. See ZeldaRAM_rtf for more variable listings.
                INC.b $1A

                JSR.w ClearOamBuffer
                JSL.l Module_MainRouting

            .skip_frame

            JSR.w Main_PrepSpritesForNmi

            ; Start the NMI Wait loop again.
            STZ.b $12
    BRA .nmi_wait_loop
}

; ==============================================================================

; $000061-$0000B4 JUMP TABLE FOR SR$0085
Pool_Module_MainRouting:
{
    ; TODO: Reference jpdisasm for interleaved long pointers.
    ; Note: there are 28 distinct modes here (0x1C).

    .low  ; $000061
    .high ; $00007D
    .bank ; $000099

    dl Module_Intro          ; 0x00 - $0CC120
    dl Module_SelectFile     ; 0x01 - $0CCD7D
    dl Module_CopyFile       ; 0x02 - $0CD053
    dl Module_EraseFile      ; 0x03 - $0CD485
    dl Module_NamePlayer     ; 0x04 - $0CD88A
    dl Module_LoadFile       ; 0x05 - $028136
    dl Module_PreDungeon     ; 0x06 - $02821E
    dl Module_Dungeon        ; 0x07 - $0287A2
    dl Module_PreOverworld   ; 0x08 - $0283BF
    dl Module_Overworld      ; 0x09 - $02A475
    dl Module_PreOverworld   ; 0x0A - $0283BF (special overworld)
    dl Module_Overworld      ; 0x0B - $02A475 (special overworld)
    dl Module0C_Unused       ; 0x0C - $02991B
    dl Module0D_Unused       ; 0x0D - $029938
    dl Module_Messaging      ; 0x0E - $00F800
    dl Module_CloseSpotlight ; 0x0F - $029982
    dl Module_OpenSpotlight  ; 0x10 - $029AD7
    dl Module_HoleToDungeon  ; 0x11 - $029AF9
    dl Module_Death          ; 0x12 - $09F290
    dl Module_BossVictory    ; 0x13 - $029C4A
    dl Module_Attract        ; 0x14 - $0CEDAD 
    dl Module_Mirror         ; 0x15 - $029CFC
    dl Module_Victory        ; 0x16 - $029E8A
    dl Module_Quit           ; 0x17 - $09F79F
    dl Module_GanonEmerges   ; 0x18 - $029EDC
    dl Module_TriforceRoom   ; 0x19 - $029FEC
    dl Module_EndSequence    ; 0x1A - $0E986E
    dl Module_LocationMenu   ; 0x1B - $028586
}

; $0000B5-$0000C8 LONG JUMP LOCATION
Module_MainRouting:
{
    ; This variable determines which module we're in.
    LDY.b $10
    
    LDA.w .low, Y  : STA.b $03
    LDA.w .high, Y : STA.b $04
    LDA.w .bank, Y : STA.b $05
    
    ; Jump to a main module depending on addr $7E0010 in WRAM.
    JMP [$0003]
}

; ==============================================================================

; $0000C9-$00022C NMI Interrupt Subroutine (NMI Vector)
Vector_NMI:
{
    ; Ensures this interrupt isn't interrupted by an IRQ.
    SEI
    
    ; Resets M and X flags.
    REP #$30
    
    ; Pushes 16 bit registers to the stack.
    PHA : PHX : PHY : PHD : PHB
    
    ; Sets DP to $0000.
    LDA.w #$0000 : TCD
    
    ; Equate Program and Data banks.
    PHK : PLB
    
    SEP #$30
    
    ; This register needs to be read each time NMI is called.
    ; It apparently resets a latch so that the next NMI can trigger?
    LDA.w SNES.NMIFlagAndCPUVersionNum
    
    ; Used to select a musical track.
    LDA.w $012C : BNE .nonzeroMusicInput
        LDA.w SNES.APUIOPort0 : CMP.w $0133 : BNE .handleAmbientSfxInput
            ; If they were the same, put 0 in $2140.
            STZ.w SNES.APUIOPort0
            
            BRA .handleAmbientSfxInput

    .nonzeroMusicInput

    CMP.w $0133 : BEQ .handleAmbientSfxInput
        ; The song has changed...
        STA.w SNES.APUIOPort0 : STA.w $0133
        CMP.b #$F2 : BCS .volumeOrTransferCommand
            STA.w $0130

        .volumeOrTransferCommand

        STZ.w $012C

    .handleAmbientSfxInput

    LDA.w $012D : BNE .nonzeroAmbientSfxInput
        ; Compare the values.
        LDA.w SNES.APUIOPort1 : CMP.w $0131 : BNE .writeSfx
            STZ.w SNES.APUIOPort1 ; If equal, zero out $2141.
            
            BRA .writeSfx

    .nonzeroAmbientSfxInput

    STA.w $0131 : STA.w SNES.APUIOPort1
    
    STZ.w $012D

    .writeSfx

    ; Addresses will hold SPC memory locations.
    LDA.w $012E : STA.w SNES.APUIOPort2
    LDA.w $012F : STA.w SNES.APUIOPort3
    
    STZ.w $012E
    STZ.w $012F
    
    ; Bring the screen into forceblank (forced vblank).
    LDA.b #$80 : STA.w SNES.ScreenDisplay
    
    ; Disable all DMA transfers.
    STZ.w SNES.HDMAChannelEnable
    
    ; Checks to see if we're still in the infinite loop in the main routine.
    ; If $12 is not 0, it shows that the infinite loop isn't running.
    ; This prevents the NMI updates from running more than once per frame,
    ; preventing lag and preventing lost player input.
    LDA.b $12 : BNE .normalFrameNotFinished
        ; This would happen if NMI had been called from the wait loop.
        INC.b $12
        
        JSR.w NMI_DoUpdates
        JSR.w NMI_ReadJoypads

    .normalFrameNotFinished

    LDA.w $012A : BEQ .helperThreadInactive
        JMP NMI_SwitchThread

    .helperThreadInactive

    ; Sets background clipping...
    LDA.b $96 : STA.w SNES.BG1And2WindowMask
    LDA.b $97 : STA.w SNES.BG3And4WindowMask
    LDA.b $98 : STA.w SNES.OBJAndColorWindow
    
    ; Sets color / sprite windowing registers.
    LDA.b $99 : STA.w SNES.InitColorAddition
    LDA.b $9A : STA.w SNES.AddSubtractSelectAndEnable
    
    ; Possibly a register that must be written 3 times (internal pointer).
    LDA.b $9C : STA.w SNES.FixedColorData
    LDA.b $9D : STA.w SNES.FixedColorData
    LDA.b $9E : STA.w SNES.FixedColorData
    
    ; Main / Subscreen designation registers.
    LDA.b $1C : STA.w SNES.BGAndOBJEnableMainScreen
    LDA.b $1D : STA.w SNES.BGAndOBJEnableSubScreen
    
    ; Window designations...
    LDA.b $1E : STA.w SNES.WindowMaskDesMainScreen
    LDA.b $1F : STA.w SNES.WindowMaskDesSubScreen
    
    ; Written twice each to get a whole word in.
    LDA.w $0120 : STA.w SNES.BG1HScrollOffset
    LDA.w $0121 : STA.w SNES.BG1HScrollOffset
    
    LDA.w $0124 : STA.w SNES.BG1VScrollOffset
    LDA.w $0125 : STA.w SNES.BG1VScrollOffset
    
    LDA.w $011E : STA.w SNES.BG2HScrollOffset
    LDA.w $011F : STA.w SNES.BG2HScrollOffset
    
    LDA.w $0122 : STA.w SNES.BG2VScrollOffset
    LDA.w $0123 : STA.w SNES.BG2VScrollOffset
    
    LDA.b $E4 : STA.w SNES.BG3HScrollOffset
    LDA.b $E5 : STA.w SNES.BG3HScrollOffset
    
    ; All BG registers.
    LDA.b $EA : STA.w SNES.BG3VScrollOffset
    LDA.b $EB : STA.w SNES.BG3VScrollOffset
    
    ; MOSAIC and BGMODE register mirrors.
    LDA.b $95 : STA.w SNES.MosaicAndBGEnable
    LDA.b $94 : STA.w SNES.BGModeAndTileSize
    
    ; Check to see if we're in mode 7.
    AND.b #$07 : CMP.b #$07 : BNE .notInMode7
        STZ.w SNES.Mode7MatrixB : STZ.w SNES.Mode7MatrixB
        STZ.w SNES.Mode7MatrixC : STZ.w SNES.Mode7MatrixC
        
        LDA.w $0638 : STA.w SNES.Mode7CenterPosX
        LDA.w $0639 : STA.w SNES.Mode7CenterPosX
        LDA.w $063A : STA.w SNES.Mode7CenterPosY
        LDA.w $063B : STA.w SNES.Mode7CenterPosY

    .notInMode7

    LDA.w $0128 : BEQ .irqInactive
        ; Clear the IRQ line if one is pending? (reset latch).
        LDA.w SNES.IRQFlagByHVCountTimer
        
        ; Set vertical IRQ trigger position to 128, which is a tad
        ; bit past the middle of the screen, vertically.
        LDA.b #$80 : STA.w SNES.VCountTImer
                     STZ.w SNES.VCountTimerHigh
        
        ; Set horizontal IRQ trigger position to 0
        ; (Will not be used anyways).
        STZ.w SNES.HCountTimer : STZ.w SNES.HCountTimerHigh
        
        ; Will enable NMI, and Joypad, and vertical IRQ trigger.
        LDA.b #$A1 : STA.w SNES.NMIVHCountJoypadEnable ; #$A1 = #%10100001

    .irqInactive

    ; $13 holds the screen state.
    LDA.b $13 : STA.w SNES.ScreenDisplay
    LDA.b $9B : STA.w SNES.HDMAChannelEnable
    
    REP #$30
    
    PLB : PLD : PLY : PLX : PLA

    .return

    RTI
}

; ==============================================================================

; $00022D-$0002D7 JUMP LOCATION
NMI_SwitchThread:
{
    JSR.w NMI_UpdateIrqGfx
    
    LDA.b $FF : STA.w SNES.VCountTImer
    STZ.w SNES.VCountTimerHigh
    
    ; A = #%10100001, which means activate NMI, V-IRQ, and Joypad.
    LDA.b #$A1 : STA.w SNES.NMIVHCountJoypadEnable
    
    LDA.b $96 : STA.w SNES.BG1And2WindowMask
    LDA.b $97 : STA.w SNES.BG3And4WindowMask
    LDA.b $98 : STA.w SNES.OBJAndColorWindow
    
    LDA.b $99 : STA.w SNES.InitColorAddition
    LDA.b $9A : STA.w SNES.AddSubtractSelectAndEnable
    LDA.b $9C : STA.w SNES.FixedColorData
    LDA.b $9D : STA.w SNES.FixedColorData
    LDA.b $9E : STA.w SNES.FixedColorData
    
    LDA.b $1C : STA.w SNES.BGAndOBJEnableMainScreen
    LDA.b $1D : STA.w SNES.BGAndOBJEnableSubScreen
    LDA.b $1E : STA.w SNES.WindowMaskDesMainScreen
    LDA.b $1F : STA.w SNES.WindowMaskDesSubScreen
    
    LDA.w $0120 : STA.w SNES.BG1HScrollOffset
    LDA.w $0121 : STA.w SNES.BG1HScrollOffset
    
    LDA.w $0124 : STA.w SNES.BG1VScrollOffset
    LDA.w $0125 : STA.w SNES.BG1VScrollOffset
    
    LDA.w $011E : STA.w SNES.BG2HScrollOffset
    LDA.w $011F : STA.w SNES.BG2HScrollOffset
    
    LDA.w $0122 : STA.w SNES.BG2VScrollOffset
    LDA.w $0123 : STA.w SNES.BG2VScrollOffset
    
    LDA.b $E4 : STA.w SNES.BG3HScrollOffset
    LDA.b $E5 : STA.w SNES.BG3HScrollOffset
    LDA.b $EA : STA.w SNES.BG3VScrollOffset
    LDA.b $EB : STA.w SNES.BG3VScrollOffset
    LDA.b $13 : STA.w SNES.ScreenDisplay
    LDA.b $9B : STA.w SNES.HDMAChannelEnable
    
    REP #$30
    
    ; This is very tricksy.
    ; X = S; (apparently they did't know about the TSX instruction).
    TSC : TAX
    
    ; S = $1F0A
    ; $1F0A = X
    LDA.w $1F0A : TCS : STX.w $1F0A
    
    PLB : PLD : PLY : PLX : PLA
    
    ; Expect to end up at Polyhedral_RunThread after the RTI.
    RTI
}

; $0002D8-$000332 IRQ INTERRUPT
Vector_IRQ:
{    
    SEI
    
    REP #$30
    
    PHA : PHX : PHY : PHD
    
    PHB : PHK : PLB
    
    SEP #$30
    
    LDA.w $012A : BNE .BRANCH_3
        ; Only d7 is significant in this register. If set, h/v counter has
        ; latched. So in other words, branch if the timer has NOT counted down.
        LDA.w SNES.IRQFlagByHVCountTimer : BPL .BRANCH_2
            ; TODO: Not sure what this does...
            LDA.w $0128 : BEQ .BRANCH_2
                --

                    ; Wait for hBlank.
                BIT.w SNES.HVBlankFlagsAndJoyStatus : BVC --
                        
                LDA.w $0630 : STA.w SNES.BG3HScrollOffset
                LDA.w $0631 : STA.w SNES.BG3HScrollOffset
                        
                STZ.w SNES.BG3VScrollOffset : STZ.w SNES.BG3VScrollOffset
                        
                LDA.w $0128 : BPL .BRANCH_2
                    STZ.w $0128
                            
                    LDA.b #$81 : STA.w SNES.NMIVHCountJoypadEnable

        .BRANCH_2

        ; H/V timer didn't count down yet, so we do nothing.
            
        REP #$30
            
        PLB : PLD : PLY : PLX : PLA
            
        RTI

    .BRANCH_3

    LDA.w SNES.IRQFlagByHVCountTimer
    
    REP #$30
    
    ; X = S
    TSC : TAX
    
    ; Transfer A -> S.
    LDA.w $1F0A : TCS : STX.w $1F0A
    
    PLB : PLD : PLY : PLX : PLA
    
    RTI
}

; OPTIMIZE: This routine might be optimizable.
; $000333-$0003D0 LONG JUMP LOCATION
Vram_EraseTilemaps:
{
    .triforce ; For use with the title screen and the credits sequence.

    !fillBg_1_2 = $00
    !fillBg_3   = $02
    
    REP #$20
    
    LDA.w #$00A9 : STA !fillBg_3
    
    LDA.w #$007F
    
    BRA .fillTilemaps

    ; $00033F ALTERNATE ENTRY POINT
    .palaceMap

    REP #$20
    
    LDA.w #$007F : STA !fillBg_3
    
    LDA.w #$0003
    
    BRA .fillTilemaps

    ; $00034B ALTERNATE ENTRY POINT
    .normal

    ; Performs a tilemap blanking (filling with transparent tiles) for BG1,
    ; BG2, and BG3.
    
    REP #$20
    
    ; $01EC indicates "blank" tiles.
    LDA.w #$007F : STA !fillBg_3
    
    LDA.w #$01EC

    .fillTilemaps

    ; Could be any number of values.
    STA !fillBg_1_2
    
    ; VRAM target address updates on writes to $2118.
    STZ.w SNES.VRAMAddrIncrementVal
    
    ; The VRAM target address is $0000 (word address).
    STZ.w SNES.VRAMAddrReadWriteLow
    
    ; Target register is $2118, write one register once mode, with fixed source
    ; address.
    LDA.w #$1808 : STA.w DMA.1_TransferParameters
    
    ; Dma source address is $000000.
    STZ.w DMA.1_SourceAddrBank
    LDA.w #$0000 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; Will write 0x2000 bytes. since we're only writing to the low byte of each
    ; VRAM word address, we will technically cover 0x4000 bytes worth of
    ; address space, but in terms of VRAM addresses it's till only VRAM
    ; address$0000 to $1FFF.
    LDA.w #$2000 : STA.w DMA.1_TransferSizeLow
    
    ; Transfer the data on channel 1.
    LDY.b #$02 : STY.w SNES.DMAChannelEnable
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ; Increment VRAM address when $2119 is written.
    LDX.b #$80 : STX.w SNES.VRAMAddrIncrementVal
    
    ; Reinitialize VRAM target address to $0000 (word).
    STZ.w SNES.VRAMAddrReadWriteLow
    
    ; Again write 0x2000 bytes.
    STA.w DMA.1_TransferSizeLow
    
    ; Dma target register is $2119, write one register once mode, with fixed
    ; address.
    LDA.w #$1908 : STA.w DMA.1_TransferParameters
    
    ; The DMA source address will now be $000001.
    LDA.w #$0001 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; Transfer data on channel 1.
    STY.w SNES.DMAChannelEnable
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ; This value was saved earliest in the routine.
    LDA !fillBg_3 : STA !fillBg_1_2
    
    ; Increment on writes to $2118 again.
    STZ.w SNES.VRAMAddrIncrementVal
    
    ; Write to VRAM address $6000 (word).
    LDA.w #$6000 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Write to $2118, Non incrementally.
    LDA.w #$1808 : STA.w DMA.1_TransferParameters
    
    ; $DMA source address is $000000.
    LDA.w #$0000 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; Write $00 #$800 times to VRAM.
    LDA.w #$0800 : STA.w DMA.1_TransferSizeLow
    
    ; Transfer data on channel 1.
    STY.w SNES.DMAChannelEnable
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ; Increment on writes to $2119 again.
    STX.w SNES.VRAMAddrIncrementVal
    
    ; Reset the byte amount to 0x800 bytes.
    STA.w DMA.1_TransferSizeLow
    
    ; Reset VRAM target address to $6000 (word).
    LDA.w #$6000 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Write to $2119, write one register once mode, fixed source address.
    LDA.w #$1908 : STA.w DMA.1_TransferParameters
    
    ; DMA source address is $000001.
    LDA.w #$0001 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; Transfer data on channel 1.
    STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    RTL
}

; $0003D1-$0003F7 LOCAL JUMP LOCATION
NMI_ReadJoypads:
{
    ; Probably indicates that we're not using the old style joypad reading.
    STZ.w $4016
    
    ; Storing the state of Joypad 1 to $00-$01.
    LDA.w SNES.JoyPad1DataLow  : STA.b $00
    LDA.w SNES.JoyPad1DataHigh : STA.b $01
    
    ; $F2 has the pure joypad data.
    LDA.b $00 : STA.b $F2 : TAY 
    
    ; $FA at this point contains the joypad data from the last frame.
    ; This is intended to avoid flooding in processing commands.
    ; Send this "button masked" reading here.
    ; Hence $F2 and $FA contain pure joypad readings from this frame now.
    EOR.b $FA : AND.b $F2 : STA.b $F6 : STY.b $FA
    
    ; Essentially the same procedure as above, but for the other half of JP1.
    LDA.b $01 : STA.b $F0 : TAY

    EOR.b $F8 : AND.b $F0 : STA.b $F4 : STY.b $F8

    ; Bleeds into the next function.
}
    
; $0003F8-$00041D LOCAL JUMP LOCATION
Player2JoypadReturn:
{
    !disableJoypad2 = "RTS"
    !enableJoypad2  = "NOP"
    !joypad2_action = !disableJoypad2

    !joypad2_action
    
    ; UNUSED: If it wasn't obvious, please note that the original game, coded
    ; this way, never reaches this section. Yes folks, there is no love for
    ; Joypad2 in Zelda 3.
    
    LDA.w SNES.JoyPad2DataLow  : STA.b $00
    LDA.w SNES.JoyPad2DataHigh : STA.b $01
    
    LDA.b $00 : STA.b $F3 : TAY

    EOR.b $FB : AND.b $F3 : STA.b $F7 : STY.b $FB
    
    LDA.b $01 : STA.b $F1 : TAY

    EOR.b $F9 : AND.b $F1 : STA.b $F5 : STY.b $F9
    
    RTS
}

; ==============================================================================

; Gets rid of old sprites by moving them off screen, basically. E.g., when you
; kill a soldier, his sprite has to disappear, right? Any sprites that are
; still in the game engine will be moved back on screen before VRAM is written
; to again.
; $00041E-$000489 LOCAL JUMP LOCATION
ClearOamBuffer:
{
    LDX.b #$60

    .loop

        LDA.b #$F0
        
        STA.w $0801, X : STA.w $0805, X : STA.w $0809, X : STA.w $080D, X
        STA.w $0811, X : STA.w $0815, X : STA.w $0819, X : STA.w $081D, X
        
        STA.w $0881, X : STA.w $0885, X : STA.w $0889, X : STA.w $088D, X
        STA.w $0891, X : STA.w $0895, X : STA.w $0899, X : STA.w $089D, X
        
        STA.w $0901, X : STA.w $0905, X : STA.w $0909, X : STA.w $090D, X
        STA.w $0911, X : STA.w $0915, X : STA.w $0919, X : STA.w $091D, X
        
        STA.w $0981, X : STA.w $0985, X : STA.w $0989, X : STA.w $098D, X
        STA.w $0991, X : STA.w $0995, X : STA.w $0999, X : STA.w $099D, X

        ; X -= 0x20
    TXA : SEC : SBC.b #$20 : TAX : BPL .loop
    
    RTS
}

; $00048A-$00048B DATA
SaveFileOffsets:
{
    dw $0000
}

; $00048C-$000493 DATA
SaveFileCopyOffsets:
{
    dw $0000, $0500
    dw $0A00, $0F00 
}

; $000494-$00049B DATA
DynamicOAM_PushBlockAddresses:
{
    dw $A480
    dw $A4C0, $A500
    dw $A540
}

; $00049C-$0004AB DATA
LinkOAM_SwordAddresses:
{
    dw $9000, $9020, $9060, $91E0, $90A0, $90C0, $9100, $9140
}

; $0004AC-$0004B1 DATA
LinkOAM_ShieldAddresses:
{
    dw $9300 ; Down
    dw $9340 ; Up
    dw $9380 ; Side
}

; $0004B2-$0005D1 DATA
DynamicOAM_LinkItemAddresses:
{
    dw $7E9480, $7E94C0, $7E94E0, $7E95C0 ; Rod
    dw $7E9500, $7E9520, $7E9540, $7E9480 ; Rod
    dw $7E9640, $7E9680, $7E96A0, $7E9780 ; Hammer
    dw $7E96C0, $7E96E0, $7E9700, $7E9480 ; Hammer

    dw $7E9800, $7E9840, $7E98A0, $7E9480 ; Bow
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9AC0, $7E9B00, $7E9480, $7E9480 ; Hookshot tip
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null

    dw $7E9BC0, $7E9C00, $7E9C40, $7E9C80 ; Net
    dw $7E9CC0, $7E9D00, $7E9D40, $7E9480 ; Net
    dw $7E9F40, $7E9F80, $7E9FC0, $7E9FE0 ; Cane
    dw $7EA000, $7E9480, $7E9480, $7E9480 ; Cane

    dw $7EA100, $7E9480, $7E9480, $7E9480 ; Book
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null

    dw $7E98C0, $7E9900, $7E99C0, $7E99E0 ; Shovel, ZZzzzz
    dw $7E9A00, $7E9A20, $7E9A40, $7E9A60 ; Zzzzz, ♪
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null

    dw $7E9A80, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null

    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null

    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null
    dw $7E9480, $7E9480, $7E9480, $7E9480 ; Null

    ; $0005B2
    .offsets
    dw $00E0, $00E0, $0060, $0080
    dw $01C0, $00E0, $0040, $0000
    dw $0080, $0000, $0040, $0000
    dw $0000, $0000, $0000, $0000
}

; $0005D2-$0005DD DATA
RupeeTile_anim_step:
{
    dw $000E
    dw $0004
    dw $0006
    dw $0010
    dw $0006
    dw $0008
}

; $0005DE-$0005F5 DATA
RupeeTile_anim_stepOffset:
{
    dw $0000, $0020, $0040, $0000
    dw $0020, $0040, $0000, $0040
    dw $0080, $0000, $0040, $0080
}

; $0005F6-$0005FB DATA
StarTileOffset:
{
    dw $7EB340
    dw $7EB400
    dw $7EB4C0
}

; ==============================================================================

; Writes some extra data for the OAM memory. The data is written to $0A00 to
; $0A1F, and the data that is written is formed from the addresses $0A20
; through $0A9F.
; $0005FC-$000780 LOCAL JUMP LOCATION
Main_PrepSpritesForNmi:
{
    LDY.b #$1C

    .buildHighOamTable

        ; Y = 0x1C, X = 0x70
        TYA : ASL #2 : TAX
        
        ; Start at $0A93?
        LDA.w $0A23, X : ASL #2
        ORA.w $0A22, X : ASL #2
        ORA.w $0A21, X : ASL #2
        ORA.w $0A20, X : STA.w $0A00, Y
        
        LDA.w $0A27, X : ASL #2
        ORA.w $0A26, X : ASL #2
        ORA.w $0A25, X : ASL #2
        ORA.w $0A24, X : STA.w $0A01, Y
        
        LDA.w $0A2B, X : ASL #2
        ORA.w $0A2A, X : ASL #2
        ORA.w $0A29, X : ASL #2
        ORA.w $0A28, X : STA.w $0A02, Y
        
        LDA.w $0A2F, X : ASL #2
        ORA.w $0A2E, X : ASL #2
        ORA.w $0A2D, X : ASL #2
        ORA.w $0A2C, X : STA.w $0A03, Y
    DEY #4 : BPL .buildHighOamTable
        
    REP #$31
        
    LDX.w $0100
    LDA.w LinkOAM_HeadAddresses, X : STA.w $0ACC
          ADC.w #$0200             : STA.w $0ACE

    LDA.w LinkOAM_BodyAddresses, X : STA.w $0AD0
    CLC : ADC.w #$0200             : STA.w $0AD2
        
    LDX.w $0102
    LDA.w LinkOAM_AuxAddresses, X : STA.w $0AD4
        
    LDX.w $0104
    LDA.w LinkOAM_AuxAddresses, X : STA.w $0AD6
        
    SEP #$10
        
    LDX.w $0107
    LDA.w LinkOAM_SwordAddresses, X : STA.w $0AC0
    CLC : ADC.w #$0180 : STA.w $0AC2

    LDX.w $0108
    LDA.w LinkOAM_ShieldAddresses, X : STA.w $0AC4
    CLC : ADC.w #$00C0 : STA.w $0AC6
        
    LDA.w $0109 : AND.w #$00F8 : LSR #2 : TAY
        
    LDA.w $0109 : ASL A : TAX
        
    LDA.w DynamicOAM_LinkItemAddresses, X : STA.w $0AC8
        
    CLC : TYX : ADC.w DynamicOAM_LinkItemAddresses_offsets, X : STA.w $0ACA
        
    LDA.w $02C3 : AND.w #$0003 : ASL A : TAX
        
    LDA.w DynamicOAM_PushBlockAddresses, X : STA.w $0AD8
    CLC : ADC.w #$0100 : STA.w $0ADA
        
    LDA.l $7EC00D : DEC A : STA.l $7EC00D : BNE .ignoreTileAnimation
        ; Reset the counter for tile animation.
        LDA.w #$0009
        
        LDX.b $8C : CPX.b #$B5 : BEQ .BRANCH_1A
            CPX.b #$BC : BNE .BRANCH_1B
        
        .BRANCH_1A

        LDA.w #$0017

        .BRANCH_1B

        STA.l $7EC00D
        
        ; Increment the animated tiles counter. #$0400 for each frame.
        LDA.l $7EC00F : CLC : ADC.w #$0400 : CMP.w #$0C00 : BNE .BRANCH_1C
            LDA.w #$0000
        
        .BRANCH_1C

        STA.l $7EC00F : CLC : ADC.w #$A680 : STA.w $0ADC

    .ignoreTileAnimation

    LDA.l $7EC013 : DEC A : STA.l $7EC013 : BNE .ignoreSpriteAnimation
        LDA.l $7EC015 : TAX
        
        INX #2 : CPX.b #$0C : BNE .spriteAnimationLoopIncomplete
            LDX.b #$00
        
        .spriteAnimationLoopIncomplete
        
        TXA : STA.l $7EC015
            
        LDA.w RupeeTile_anim_step, X : STA.l $7EC013
            
        LDA.w #$B280 : CLC : ADC.w RupeeTile_anim_stepOffset, X : STA.w $0AE0
                       CLC : ADC.w #$0060                       : STA.w $0AE2

    .ignoreSpriteAnimation

    ; Setup tagalong sprite for dma transfer.
    LDA.w $0AE8  : ASL A
    ADC.w #$B940 : STA.w $0AEC
    ADC.w #$0200 : STA.w $0AEE
        
    ; Setup tagalong sprite's other component for dma transfer?
    LDA.w $0AEA  : ASL A
    ADC.w #$B940 : STA.w $0AF0
    ADC.w #$0200 : STA.w $0AF2
        
    ; Setup dma transfer for bird's sprite slot.
    LDA.w $0AF4  : ASL A
    ADC.w #$B540 : STA.w $0AF6
    ADC.w #$0200 : STA.w $0AF8
        
    SEP #$20
        
    RTS
}

; ==============================================================================

; Parameters: Stack, A
; $000781-$00079B LONG JUMP LOCATION
UseImplicitRegIndexedLocalJumpTable:
{
    ; Save current Y.
    STY.b $03
    
    ; Pull return PCL to Y.
    PLY : STY.b $00
    
    REP #$30
    
    ; Ensures offset is a Multiple of two.
    AND.w #$00FF : ASL A : TAY
    
    ; Pull the rest of the return address onto A.
    ; Since this is a 16 bit value this ensures that the jump address is 
    ; in the same bank as the return address.
    PLA : STA.b $01
    
    INY
    
    LDA [$00], Y : STA.b $00
    
    SEP #$30
    
    ; Restore Y.
    LDY.b $03
    
    JML [$0000]
}

; ==============================================================================

; $00079C-$0007BF LONG( A, STACK)
UseImplicitRegIndexedLongJumpTable:
{
    STY.b $05
    
    ; Load Y with lower return PC from the stack.
    PLY : STY.b $02
    
    REP #$30
    
    AND.w #$00FF : STA.b $03
    
    ; Shift bits left = multiply by two, since bit 15 will NOT be set.
    ; Add the original number. Essentially, this is 2N + N = 3N.
    ; In other words, Y is indexed as 3 times the value that A had.
    ASL A : ADC.b $03 : TAY
    
    ; Pull the upper return PC and return PB from the Stack.
    PLA : STA.b $03
    
    INY ; Pushes Y past the edge of the original PC.
    
    ; Look up a new address in a table.
    LDA [$02], Y : STA.b $00 : INY
    
    ; Note that the first STA overlapped this one.
    LDA [$02], Y : STA.b $01
    
    ; The idea was to retrieve a 3-byte address from a jump table.
    
    SEP #$30
    
    LDY.b $05 ; Restore Y's earlier value.
    
    JML [$0000]
}

; ==============================================================================

; Zeroes out $7E0000-$7E1FFF, and checks some values in SRAM.
; $0007C0-$00082D LOCAL JUMP LOCATION
Startup_InitializeMemory:
{
    REP #$30
    
    ; Save the return location of this subroutine.
    ; But why do this, why not something like "TSX : TXY"?
    LDY.w $01FE
    
    ; Counter for the loop.
    LDX.w #$03FE
    
    ; The value to write.
    LDA.w #$0000

    .erase

        ; Zero out $0000-$1FFF
        
        STA.w $0000, X : STA.w $0400, X : STA.w $0800, X : STA.w $0C00, X
        STA.w $1000, X : STA.w $1400, X : STA.w $1800, X : STA.w $1C00, X
    DEX #2 : BNE .erase
    
    ; Sets it so we have no memory of opening a save file.
    STA.l $7EC500 : STA.l $701FFE
    
    ; Checks the checksum for the first save file.
    LDA.l $7003E5 : CMP.w #$55AA : BEQ .validSlot1Sram
        ; Effectively sends the program the message to delete this file.
        LDA.w #$0000 : STA.l $7003E5

    .validSlot1Sram

    ; Repeat this for slots 2 and 3.
    LDA.l $7008E5 : CMP.w #$55AA : BEQ .validSlot2Sram
        LDA.w #$0000 : STA.l $7008E5

    .validSlot2Sram

    LDA.l $700DE5 : CMP.w #$55AA : BEQ .validSlot3Sram
        LDA.w #$0000 : STA.l $700DE5

    .validSlot3Sram

    ; Restore the return location for this function to the stack.
    ; As above, I think "TYX : TXS" would have worked.
    STY.w $01FE
    
    ; Window mask activation.
    STZ.w SNES.WindowMaskDesMainScreen
    
    SEP #$30
    
    ; Bring the screen into force blank after NMI.
    LDA.b #$80 : STA.b $13
    
    ; Update CGRAM this frame.
    INC.b $15
    
    RTS
}

; ==============================================================================

; Inputs:
; $00 - full 16-bit Y coordinate of an object.
; $02 - full 16-bit X coordinate of an object.
; $
; $00082E-$000887 LONG JUMP LOCATION
Overworld_GetTileAttrAtLocation:
{
    REP #$30
    
    LDA.b $00 : SEC : SBC.w $0708 : AND.w $070A : ASL #3    : STA.b $06
    LDA.b $02 : SEC : SBC.w $070C : AND.w $070E : ORA.b $06 : TAX
    
    LDA.l $7E2000, X : ASL #2 : STA.b $06
    LDA.b $00 : AND.w #$0008 : LSR #2 : TSB.b $06
    LDA.b $02 : AND.w #$0001 : ORA.b $06 : ASL A : TAX
    
    LDA.l Map16Definitions, X : STA.b $06 : AND.w #$01FF : TAX
    
    LDA Overworld_TileAttr, X
    
    SEP #$30
    
    CMP.b #$10 : BCC .BRANCH_1
    CMP.b #$1C : BCS .BRANCH_1
        STA.b $06
        
        LDA.b $07 : AND.b #$40 : ASL A : ROL #2 : ORA.b $06

    .BRANCH_1

    RTL
}

; ==============================================================================

; Loads SPC with data.
; $000888-$000900 LOCAL JUMP LOCATION
Sound_LoadSongBank:
{
    PHP
    
    REP #$30
    
    LDY.w #$0000
    LDA.w #$AABB

    .BRANCH_INIT_WAIT

        ; Wait for the SPC to initialize to #$AABB.
    CMP.w SNES.APUIOPort0 : BNE .BRANCH_INIT_WAIT
    
    SEP #$20
    
    LDA.b #$CC
    
    BRA .BRANCH_SETUP_TRANSFER

    .BRANCH_BEGIN_TRANSFER
        LDA [$00], Y
        
        INY
        
        XBA
        
        LDA.b #$00
        
        BRA .BRANCH_WRITE_ZERO_BYTE

        .BRANCH_CONTINUE_TRANSFER

            XBA
            
            LDA [$00], Y ; Load the data byte to transmit.
            
            INY
            
            ; Are we at the end of a bank? If not, then branch forward.
            CPY.w #$8000 : BNE .BRANCH_NOT_BANK_END 
                ; Otherwise, increment the bank of the address at [$00].
                LDY.w #$0000
                
                INC.b $02

            .BRANCH_NOT_BANK_END

            XBA

            .BRANCH_WAIT_FOR_ZERO

                ; Wait for $2140 to be #$00 (we're in 8bit mode).
            CMP.w SNES.APUIOPort0 : BNE .BRANCH_WAIT_FOR_ZERO
            
            INC A ; Increment the byte count.

            .BRANCH_WRITE_ZERO_BYTE

            REP #$20
            
            ; Ends up storing the byte count to $2140 and the.
            STA.w SNES.APUIOPort0
            
            SEP #$20 ; Data byte to $2141. (Data byte represented as **).
        DEX : BNE .BRANCH_CONTINUE_TRANSFER

    .BRANCH_SYNCHRONIZE ; We ran out of bytes to transfer.

        ; But we still need to synchronize.
    CMP.w SNES.APUIOPort0 : BNE .BRANCH_SYNCHRONIZE

    .BRANCH_NO_ZERO ; At this point SNES.APUIOPort0 = #$01.

        ; Add four to the byte count.
    ADC.b #$03 : BEQ .BRANCH_NO_ZERO ; (But Don't let A be zero!).

    .BRANCH_SETUP_TRANSFER

        PHA
        
        REP #$20
        
        ; Number of bytes to transmit to the SPC.
        LDA [$00], Y : INY #2 : TAX
        
        ; Location in memory to map the data to.
        LDA [$00], Y : INY #2 : STA.w SNES.APUIOPort2
        
        SEP #$20
        
        CPX.w #$0001 ; If the number of bytes left to transfer > 0...
        
        ; Then the carry bit will be set and rotated into the accumulator
        ; (A = #$01). NOTE ANTITRACK'S DOC IS WRONG ABOUT THIS!!!
        ; He mistook #$0001 to be #$0100.
        LDA.b #$00 : ROL A : STA.w SNES.APUIOPort1 : ADC.b #$7F
        
        ; Hopefully no one was confused.
        PLA : STA.w SNES.APUIOPort0

        .BRANCH_TRANSFER_INIT_WAIT

            ; Initially, a 0xCC byte will be sent to initialize the transfer.
            ; if A was #$01 earlier...
        CMP.w SNES.APUIOPort0 : BNE .BRANCH_TRANSFER_INIT_WAIT
    BVS .BRANCH_BEGIN_TRANSFER
    
    STZ.w SNES.APUIOPort0 : STZ.w SNES.APUIOPort1
    STZ.w SNES.APUIOPort2 : STZ.w SNES.APUIOPort3
    
    PLP
    
    RTS
}

; ==============================================================================

; $000901-$000912 LOCAL JUMP LOCATION
Sound_LoadIntroSongBank:
{
    ; $00[3] = $198000, which is $C8000 in Rom
    LDA.b #$00 : STA.b $00
    LDA.b #$80 : STA.b $01
    LDA.b #$19 : STA.b $02
    
    SEI
    
    JSR.w Sound_LoadSongBank
    
    CLI
    
    RTS
}

; ==============================================================================

; $000913-$000924 LONG JUMP LOCATION
Sound_LoadLightWorldSongBank:
{
    ; $00[3] = $1A9EF5, which is $D1EF5 in Rom
    LDA.b #$F5 : STA.b $00
    LDA.b #$9E : STA.b $01
    LDA.b #$1A

    .do_load

    STA.b $02
    
    SEI
    
    JSR.w Sound_LoadSongBank
    
    CLI
    
    RTL
}

; $000925-$000930 LONG JUMP LOCATION
Sound_LoadIndoorSongBank:
{
    ; $00[3] = $1B8000, which is $D8000 in ROM.
    LDA.b #$00 : STA.b $00
    LDA.b #$80 : STA.b $01
    LDA.b #$1B
    
    BRA Sound_LoadLightWorldSongBank_do_load
}

; $000931-$00093C LONG JUMP LOCATION
Sound_LoadEndingSongBank:
{
    ; $00[3] = $1AD380, which is $D5380 in ROM.
    LDA.b #$80 : STA.b $00
    LDA.b #$D3 : STA.b $01
    LDA.b #$1A
    
    BRA Sound_LoadLightWorldSongBank_do_load
}

; ==============================================================================

; $00093D-$000949 LONG JUMP LOCATION
EnableForceBlank:
{
    ; Bring the screen into forceblank.
    ; Screen state is mirrored at $13.
    LDA.b #$80 : STA.w SNES.ScreenDisplay : STA.b $13
    
    ; Disable HDMA transfers on all channels.
    STZ.w SNES.HDMAChannelEnable : STZ.b $9B
    
    RTL
}

; ==============================================================================

; Loads WRAM into SRAM, calculates an inverse checksum.
; $00094A-$0009C1 LONG JUMP LOCATION
Main_SaveGameFile:
{
    ; Data bank = 0x70, which is the bank that SRAM has been mapped it.
    PHB : LDA.b #$70 : PHA : PLB
    
    REP #$30
    
    ; $701FFE, an offset of 0, 2, 4, 6,...
    ; Will give Y a value of 0, 0x0500, 0x0A00, or 0x0F00.
    LDX.w $1FFE
    LDA.l SaveFileOffsets, X : TAY : PHY
    
    LDX.w #$0000

    .writeSlot

        ; Loads memory from WRAM and writes it into SRAM.
        ; Notice the difference of 0xF00 in the mirrored SRAM locations.
        LDA.l $7EF000, X : STA.w $0000, Y : STA.w $0F00, Y
        LDA.l $7EF100, X : STA.w $0100, Y : STA.w $1000, Y
        LDA.l $7EF200, X : STA.w $0200, Y : STA.w $1100, Y
        LDA.l $7EF300, X : STA.w $0300, Y : STA.w $1200, Y
        LDA.l $7EF400, X : STA.w $0400, Y : STA.w $1300, Y
        
        INY #2
    INX #2 : CPX.w #$0100 : BNE .writeSlot
    
    LDX.w #$0000
    
    TXA

    .calcChecksum

        ; The checksum is a sum of 16-bit words of the first 0x4FE words of the
        ; save file.
        CLC : ADC.l $7EF000, X
    INX #2 : CPX.w #$04FE : BNE .calcChecksum
    
    ; Store the calculated checksum to dp address $00 for temporary keeping.
    STA.b $00
    
    ; Restore the index (0x0000, 0x0500, 0x0A00, ... ).
    PLY
    
    ; Subtract the checksum from 0x5A5A, and store the result at a
    ; corresponding location in WRAM. Because the result is subtracted from
    ; 0x5A5A, I'm inclined to call it an "inverse" checksum.
    LDA.w #$5A5A : SEC : SBC.b $00 : STA.l $7EF4FE
    
    TYX
    
    ; Store the checksum at offset 0x4FE into the SRAM save game slot. (the
    ; last two bytes of the slot).
    STA.l $7004FE, X : STA.l $7013FE, X
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $0009C2-$0009DF NULL
NULL_0089C2:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $0009E0-$0000D12 LOCAL JUMP LOCATION
NMI_DoUpdates:
{
    REP #$10
    
    ; Update target VRAM address after writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Flag used to indicate that special screen updates need to happen.
    LDA.w $0710 : BEQ .doCoreAnimatedSpriteUpdates
        JMP .skipCoreAnimatedTilesUpdate

    .doCoreAnimatedSpriteUpdates

    ; In this section Link's sprite, his sword, his shield, blocks, sparkles,
    ; rupees, tagalongs, and optionally the bird's sprite gets updated
    ; (copied to VRAM).
    
    ; Base dma register is $2118, write two registers once mode ($2118/$2119),
    ; with autoincrementing source addr. Why isn't DMA.2_TransferParameters
    ; set?
    LDX.w #$1801
    STX.w DMA.0_TransferParameters : STX.w DMA.1_TransferParameters
    STX.w DMA.2_TransferParameters : STX.w DMA.3_TransferParameters
    STX.w DMA.4_TransferParameters
    
    ; Sets the bank for the DMA source bank to $10.
    ; Use channels 0 - 2.
    LDA.b #$10
    STA.w DMA.0_SourceAddrBank
    STA.w DMA.1_SourceAddrBank
    STA.w DMA.2_SourceAddrBank
    
    ; The VRAM target address is $4100 (word).
    LDY.w #$4100 : STY.w SNES.VRAMAddrReadWriteLow
    
    ; Sets a source address for dma channel 0.
    LDY.w $0ACE : STY.w DMA.0_SourceAddrOffsetLow
    
    ; Going to write 0x40 bytes on channel 0.
    LDX.w #$0040 : STX.w DMA.0_TransferSizeLow
    
    ; Set source address for channel 1.
    LDY.w $0AD2 : STY.w DMA.1_SourceAddrOffsetLow
    
    ; Also send 0x40 bytes on channel 1.
    STX.w DMA.1_TransferSizeLow
    
    ; Set source for channel 1.
    LDY.w $0AD6 : STY.w DMA.2_SourceAddrOffsetLow
    
    ; Send 32 bytes on channel 2.
    LDY.w #$0020 : STY.w DMA.2_TransferSizeLow
    
    ; VOLLEY 1 *****
    ; Activates DMA transfers on channels 0 - 2.
    LDA.b #$07 : STA.w SNES.DMAChannelEnable
    
    STY.w DMA.2_TransferSizeLow ; Reset for another 32 bytes?
    
    ; Set VRAM target to $4000 word addr. = $8000 byte addr.
    LDY.w #$4000 : STY.w SNES.VRAMAddrReadWriteLow
    
    LDY.w $0ACC ; 0 on first round
    STY.w DMA.0_SourceAddrOffsetLow ; Uses Channel 1
    STX.w DMA.0_TransferSizeLow ; Send 0x40 bytes
    
    LDY.w $0AD0 ; 0 on first round
    STY.w DMA.1_SourceAddrOffsetLow ; Uses channel 2
    STX.w DMA.1_TransferSizeLow ; Send 0x40 bytes
    
    LDY.w $0AD4 ; 0 on first round

    ; Note $4325 is still #$20. This was done above to save cycles.
    STY.w DMA.2_SourceAddrOffsetLow

    ; Activate transfer ( A = #$7 ) End of Volley 2 *****
    STA.w SNES.DMAChannelEnable
    
    ; Set the bank for the source to $7E.
    LDA.b #$7E : STA.w DMA.0_SourceAddrBank
    
    STA.w DMA.1_SourceAddrBank
    STA.w DMA.2_SourceAddrBank
    STA.w DMA.3_SourceAddrBank
    STA.w DMA.4_SourceAddrBank ; Doing five transfers on channels 1 through 5
    
    LDY.w $0AC0 ; 0 on first round
    STY.w DMA.0_SourceAddrOffsetLow ;    
    STX.w DMA.0_TransferSizeLow ; X is still 0x40
    
    LDY.w $0AC4
    STY.w DMA.1_SourceAddrOffsetLow ;
    STX.w DMA.1_TransferSizeLow
    
    LDY.w $0AC8
    STY.w DMA.2_SourceAddrOffsetLow ;
    STX.w DMA.2_TransferSizeLow
    
    LDY.w $0AE0 : STY.w DMA.3_SourceAddrOffsetLow
    
    ; Store 0x20 bytes.
    LDY.w #$0020 : STY.w DMA.3_TransferSizeLow
    
    ; Use as a Rom local source address (channel 5).
    LDY.w $0AD8 : STY.w DMA.4_SourceAddrOffsetLow
    
    STX.w DMA.4_TransferSizeLow ; Store 64 bytes.
    
    ; 0x1F = 0b00011111
    ; Activate DMA channels 0 - 4 ; End of Volley 3 *****
    LDA.b #$1F : STA.w SNES.DMAChannelEnable
    
    ; Target $8300 in VRAM.
    LDY.w #$4150 : STY.w SNES.VRAMAddrReadWriteLow
    
    ; Again X = 0x40.
    LDY.w $0AC2 : STY.w DMA.0_SourceAddrOffsetLow
    STX.w DMA.0_TransferSizeLow
    
    LDY.w $0AC6 : STY.w DMA.1_SourceAddrOffsetLow
    STX.w DMA.1_TransferSizeLow
    
    LDY.w $0ACA : STY.w DMA.2_SourceAddrOffsetLow
    STX.w DMA.2_TransferSizeLow
    
    LDY.w $0AE2 : STY.w DMA.3_SourceAddrOffsetLow
    
    ; Transfer 32 bytes.
    LDY.w #$0020 : STY.w DMA.3_TransferSizeLow
    
    LDY.w $0ADA : STY.w DMA.4_SourceAddrOffsetLow
    STX.w DMA.4_TransferSizeLow
    
    ; Activate lines 0 - 4; End of Volley 4
    STA.w SNES.DMAChannelEnable
    
    ; Target #$8400.
    LDY.w #SNES.NMIVHCountJoypadEnable : STY.w SNES.VRAMAddrReadWriteLow
    
    LDY.w $0AEC : STY.w DMA.0_SourceAddrOffsetLow
    STX.w DMA.0_TransferSizeLow
    
    LDY.w $0AF0 : STY.w DMA.1_SourceAddrOffsetLow
    STX.w DMA.1_TransferSizeLow
    
    LDY.w #$BD40 : STY.w DMA.2_SourceAddrOffsetLow
    STX.w DMA.2_TransferSizeLow
    
    ; Transfer 64 bytes on all lines.
    ; Use lines 0 - 2 ; End of Volley 5 *****
    LDA.b #$07 : STA.w SNES.DMAChannelEnable
    
    ; Target $8600 in VRAM.
    LDY.w #DMA.0_TransferParameters : STY.w SNES.VRAMAddrReadWriteLow
    
    LDY.w $0AEE : STY.w DMA.0_SourceAddrOffsetLow
    STX.w DMA.0_TransferSizeLow
    
    LDY.w $0AF2 : STY.w DMA.1_SourceAddrOffsetLow
    STX.w DMA.1_TransferSizeLow
    
    LDY.w #$BD80 : STY.w DMA.2_SourceAddrOffsetLow
    STX.w DMA.2_TransferSizeLow ; X = 64 still
    
    STA.w SNES.DMAChannelEnable ; Use lines 0 - 2 ; End of Volley 6 *****
    
    LDA.w $0AF4 : BEQ .noBirdSpriteUpdate
        ; Otherwise, Target $81C0.
        LDY.w #$40E0 : STY.w SNES.VRAMAddrReadWriteLow
        
        ; X = 64 = #$40
        LDY.w $0AF6 : STY.w DMA.0_SourceAddrOffsetLow
        STX.w DMA.0_TransferSizeLow
        
        ; Use line 0.
        LDA.b #$01 : STA.w SNES.DMAChannelEnable
        
        ; Target $83C0.
        LDY.w #$41E0 : STY.w SNES.VRAMAddrReadWriteLow
        
        LDY.w $0AF8 : STY.w DMA.0_SourceAddrOffsetLow
        STX.w DMA.0_TransferSizeLow
        
        STA.w SNES.DMAChannelEnable ; Activate line 0.

    .noBirdSpriteUpdate

    LDX.w $0ADC : STX.w DMA.0_SourceAddrOffsetLow
    
    ; Set the target VRAM address.
    LDX.w $0134 : STX.w SNES.VRAMAddrReadWriteLow
    
    ; Transfer #$400 = 4 * 256 = 1024 bytes = 1 Kbyte
    LDX.w #$0400 : STX.w DMA.0_TransferSizeLow
    
    ; Activate line 0.
    LDA.b #$01 : STA.w SNES.DMAChannelEnable

    .skipCoreAnimatedTilesUpdate

    LDA.b $16 : BEQ .noBg3Update
        ; Target VRAM address is determined by $0219, but I'd expect this to be
        ; somewhat... fixed in practice.
        LDX.w $0219 : STX.w SNES.VRAMAddrReadWriteLow
        
        ; $7EC700 is the WRAM buffer for this data.
        LDX.w #$C700 : STX.w DMA.0_SourceAddrOffsetLow
        LDA.b #$7E   : STA.w DMA.0_SourceAddrBank
        
        ; Number of bytes to transfer is 330.
        LDX.w #$014A : STX.w DMA.0_TransferSizeLow
        
        ; Refresh BG3 tilemap data with this transfer on channel 0.
        LDA.b #$01 : STA.w SNES.DMAChannelEnable

    .noBg3Update

    ; If $15 is set, we'll update CGRAM (palette update).
    LDA.b $15 : BEQ .noCgramUpdate
        ; Initialize the CGRAM pointer to color 0 (the start of CGRAM).
        STZ.w SNES.CGRAMWriteAddr
        
        ; We're going to be loading up CGRAM with palette data.
        ; Sets up data to be read in mode 0, to address $2222 (CGRAM DATA IN).
        LDY.w #$2200 : STY.w DMA.1_TransferParameters
        
        ; Sets source address to $7EC500.
        LDY.w #$C500 : STY.w DMA.1_SourceAddrOffsetLow
        LDA.b #$7E   : STA.w DMA.1_SourceAddrBank
        
        ; Number of bytes to transfer is 0x200, which is also the size of CGRAM.
        LDY.w #$0200 : STY.w DMA.1_TransferSizeLow
        
        ; Transfer data on channel 1.
        LDA.b #$02 : STA.w SNES.DMAChannelEnable

    .noCgramUpdate

    ; Zero out the necesary flags and get ready to update OAM data.
    
    REP #$20 : SEP #$10
    
    ; Clear out $15-$16 and an OAM register.
    STZ.b $15 : STZ.w SNES.OAMAccessAddr
    
    ; Will send data to $2104, write one register once mode, autoincrementing
    ; source address.
    LDA.w #$0400 : STA.w DMA.0_TransferParameters
    
    ; Source address will be $7E0800.
    LDA.w #$0800 : STA.w DMA.0_SourceAddrOffsetLow
    STZ.w DMA.0_SourceAddrBank
    
    ; Fetch #$220 = 512 + 32 = 544 bytes
    LDA.w #$0220 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    SEP #$30
    
    ; Another graphics flag... not sure what it does.
    LDY.b $14 : BEQ .BRANCH_6
        ; $00137A, Y in Rom which is the Stripes14_SourceAddress data block -1
        ; for each table.
        LDA.w Stripes14_SourceAddress_low-1, Y :  STA.b $00
        LDA.w Stripes14_SourceAddress_high-1, Y : STA.b $01
        LDA.w Stripes14_SourceAddress_bank-1, Y : STA.b $02
        
        JSR.w HandleStripes14
        
        LDA.b $14 : CMP.b #$01 : BNE .BRANCH_5
            STZ.w $1000 : STZ.w $1001

        .BRANCH_5

        STZ.b $14

    .BRANCH_6

    ; What does $19 do?
    LDA.b $19 : BEQ .BRANCH_7
        ; Apparently part of its function is to determine the upper byte of the
        ; target VRAM address.
        STA.w SNES.VRAMAddrReadWriteHigh
        
        REP #$10
        
        ; Update VRAM target address after writes to $2119.
        LDY.w #$0080 : STY.w SNES.VRAMAddrIncrementVal
        
        ; Dma target address is $2118, write two registers once, autoincrement
        ; source address.
        LDX.w #$1801 : STX.w DMA.0_TransferParameters
        
        ; Source address is ($7F0000 + $0118).
        LDX.w $0118 : STX.w DMA.0_SourceAddrOffsetLow
        LDA.b #$7F  : STA.w DMA.0_SourceAddrBank
        
        ; Number of bytes to transfer is 0x0200.
        LDX.w #$0200 : STX.w DMA.0_TransferSizeLow
        
        ; Transfer data on channel 0.
        LDA.b #$01 : STA.w SNES.DMAChannelEnable
        
        STZ.b $19
        
        SEP #$10
        
    .BRANCH_7

    ; Yet another graphics flag.
    LDX.b $18 : BEQ .BRANCH_9
        ; Write from Bank $00.
        STZ.w DMA.1_SourceAddrBank
        
        REP #$20
        
        ; Writing to $2118 / $2119 alternating, with autoincrementing
        ; addressing.
        LDA.w #$1801 : STA.w DMA.1_TransferParameters
        
        REP #$10
        
        LDX.w #$0000 : LDA.w $1100, X

    .BRANCH_8

    ; Extract the target VRAM Address.
    STA.w SNES.VRAMAddrReadWriteLow
    
    TXA : CLC : ADC.w #$1104 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; Tells us how many bytes to transfer.
    LDA.w $1103, X : AND.w #$00FF : STA.w DMA.1_TransferSizeLow
    
    CLC : ADC.w #$0004 : STA.b $00
    
    SEP #$20
    
    ; Video port settings are determined in the packed data.
    LDA.w $1102, X : STA.w SNES.VRAMAddrIncrementVal
    
    ; Transfer data on channel 1.
    LDA.b #$02 : STA.w SNES.DMAChannelEnable
    
    REP #$21
    
    TXA : ADC.b $00 : TAX
    
    LDA.w $1100, X : CMP.w #$FFFF : BNE .BRANCH_8
        SEP #$30
        
        STZ.b $18 : STZ.w $0710

    .BRANCH_9

    .NMI_UpdateChr_Bg2
    ; This graphics variable is not a flag but an index for which specialized
    ; graphics routine to run this frame.
    LDA.b $17 : ASL A : TAX
    
    ; Disable the variable (meaning it will have to be reenabled next frame).
    STZ.b $17
    
    JMP ($8C7E, X)

    ; $000C7E-$000CAF Jump Table
    dw NMI_UploadTilemap_doNothing           ; 0x00 - $8CE3
    dw NMI_UploadTilemap                     ; 0x01 - $8CB0
    dw NMI_UploadBg3Text                     ; 0x02 - $8CE4
    dw NMI_UpdateScrollingOwMap              ; 0x03 - $8D13
    dw NMI_UploadSubscreenOverlay            ; 0x04 - $8D62
    dw NMI_UpdateBG1Wall                     ; 0x05 - $8E09 Used in the moving wall code
    dw NMI_DoNothing                         ; 0x06 - $8E4B Just and RTS ; Replaced by ZS - ZS Custom Overworld
    dw NMI_LightWorldMode7Tilemap            ; 0x07 - $8E54 Transfers mode 7 tilemap
    dw NMI_UpdateLeftBg2Tilemaps             ; 0x08 - $8EA9 Transfers 0x1000 bytes from $7F0000 to VRAM $0000
    dw NMI_UpdateBgChrSlots_3_to_4           ; 0x09 - $8EE7 Transfers 0x1000 bytes from $7F0000 to VRAM $2C00
    dw NMI_UpdateBgChrSlots_5_to_6           ; 0x0A - $8F16 Transfers 0x1000 bytes from $7F1000 to VRAM $3400
    dw NMI_UpdateChrHalfSlot                 ; 0x0B - $8F45 Transfers 0x400 bytes from $7F1000 to a VRAM address set by $0116 (sets the high byte)
    dw NMI_UploadSubscreenOverlay_secondHalf ; 0x0C - $8D96
    dw NMI_UploadSubscreenOverlay_firstHalf  ; 0x0D - $8D7C
    dw NMI_UpdateChr_Bg0                     ; 0x0E - $8F72 Transfers 0x1000 bytes from $7F0000 to VRAM $2000
    dw NMI_UpdateChr_Bg1                     ; 0x0F - $8F79 Transfers 0x1000 bytes from $7F0000 to VRAM $2800
    dw NMI_UpdateChr_Bg2                     ; 0x10 - $8F80 Transfers 0x1000 bytes from $7F0000 to VRAM $3000
    dw NMI_UpdateChr_Bg3                     ; 0x11 - $8F87 Transfers 0x1000 bytes from $7F0000 to VRAM $3800
    dw NMI_UpdateChr_Spr0                    ; 0x12 - $8F8E Transfers 0x1000 bytes from $7F0000 to VRAM $4400
    dw NMI_UpdateChr_Spr2                    ; 0x13 - $8FBD Transfers 0x1000 bytes from $7F0000 to VRAM $5000
    dw NMI_UpdateChr_Spr3                    ; 0x14 - $8FC4 Transfers 0x1000 bytes from $7F0000 to VRAM $5800
    dw NMI_DarkWorldMode7Tilemap             ; 0x15 - $8FF3
    dw NMI_UpdateBg3ChrForDeathMode          ; 0x16 - $9038
    dw NMI_UpdateBarrierTileChr              ; 0x17 - $908B
    dw NMI_UpdateStarTiles                   ; 0x18 - $90B7
}

; ==============================================================================

; General purpose dma transfer for updating tilemaps, though I suppose you
; could use it to update graphics too.
; $000CB0-$000CE3 JUMP LOCATION
NMI_UploadTilemap:
{    
    ; Sets the high byte of the Target VRAM address.
    LDX.w $0116
    LDA.w TilemapUpload_HighBytes, X : STA.w SNES.VRAMAddrReadWriteHigh
    
    ; Bank of the source address is 0x00.
    STZ.w DMA.0_SourceAddrBank
    
    REP #$20
    
    ; VRAM target address will auto update after writes to $2119. (lower byte
    ; of VRAM addr is also 0x00 now).
    LDA.w #$0080 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Dma target register is $2118, write two registers once mode
    ; ($2118/$2119), autoincrement source address.
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Designates the source addr as $001000.
    LDA.w #$1000 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; The number of bytes to transfer is $800.
    LDA.w #$0800 : STA.w DMA.0_TransferSizeLow
    
    ; Fire DMA channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    ; Do a little clean up.
    STZ.w $1000
    
    SEP #$20
    
    STZ.w $0710

    ; $000CE3 ALTERNATE ENTRY POINT
    .doNothing

    RTS
}

; ==============================================================================

; Copies $7F0000[0x7E0] to $7C00 in VRAM ($F800 in byte addressing).
; $000CE4-$000D12 JUMP LOCATION
NMI_UploadBg3Text:
{
    REP #$10
    
    ; Update target VRAM address after writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Dma target address = $2118, write two registers once mode ($2118/$2119),
    ; autoincrement source address.
    LDX.w #$1801 : STX.w DMA.0_TransferParameters
    
    ; Target VRAM address is $7C00 (word).
    LDY.w #$7C00 : STY.w SNES.VRAMAddrReadWriteLow
    
    ; Source address is $7F0000.
    LDY.w #$0000 : STY.w DMA.0_SourceAddrOffsetLow
    LDA.b #$7F   : STA.w DMA.0_SourceAddrBank
    
    ; Copy 0x07E0 bytes.
    LDX.w #$07E0 : STX.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 0.
    LDA.b #$01 : STA.w SNES.DMAChannelEnable
    
    SEP #$10
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; This updates the tilemap on the overworld every time you reach a map16
; boundary. From a graphical standpoint, that means every time you cross a
; boundary on an imaginary grid of 16x16 pixel tiles.
; $000D13-$000D61 JUMP LOCATION
NMI_UpdateScrollingOwMap:
{
    REP #$10
    
    ; Dma will alternate writing between $2118 and $2119.
    LDX.w #$1801 : STX.w DMA.0_TransferParameters
    
    ; Source bank is determined to be 0x00.
    STZ.w DMA.0_SourceAddrBank
    
    ; Value is either 0x81 or 0x80. This means, increment on writing to $2119
    ; and optionally write to VRAM horizontally (0x80) or vertically (0x81)
    ; It depends on how the data in the $1100 area was set up.
    LDA.w $1101
    AND.b #$80 : ASL A : ROL A : ORA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    REP #$20
    
    ; X = $1100 & 0x3FFF, $02 = X + 2
    LDA.w $1100 : AND.w #$3FFF : TAX : INC #2 : STA.b $02
    
    LDY.w #$0000

    .nextTransfer

        REP #$21
        
        ; The next word in the array determines the target VRAM address (word).
        LDA.w $1102, Y : STA.w SNES.VRAMAddrReadWriteLow
        
        TYA : ADC.w #$1104 : STA.w DMA.0_SourceAddrOffsetLow
        
        ; Brings us to the header of the next transfer block.
        TYA : ADC.b $02 : TAY
        
        ; Set number of bytes to transfer.
        STX.w DMA.0_TransferSizeLow
        
        SEP #$20
        
        ; Transfer data on channel 0.
        LDA.b #$01 : STA.w SNES.DMAChannelEnable
    
    ; While somewhat nonsensical, the signal to stop transferring is a negative
    ; byte (what if you wanted the next transfer to do between 0x80 and 0xFF
    ; bytes?) well apparently it wasn't designed for that.
    LDA.w $1103, Y : BPL .nextTransfer
    
    SEP #$30
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; Write 0x2000 bytes to VRAM.
; $000D62-$000E08 JUMP LOCATION
NMI_UploadSubscreenOverlay:
{
    ; Source bank is 0x7F.
    LDA.b #$7F : STA.w DMA.0_SourceAddrBank
    
    ; Update target VRAM address after writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    REP #$31
    
    ; Source address is $7F2000.
    LDA.w #$2000 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Going to loop many many times to fill the whole screen.
    LDX.w #$0000
    LDA.w #$0080
    
    BRA .startTransfers

    ; $000D7C ALTERNATE ENTRY POINT
    .firstHalf

    ; Write 0x1000 bytes to VRAM (half of a tilemap).
    
    ; Source bank is 0x7F.
    LDA.b #$7F : STA.w DMA.0_SourceAddrBank
    
    ; Update target VRAM address after writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    REP #$31
    
    ; Source address is $7F2000.
    LDA.w #$2000 : STA.w DMA.0_SourceAddrOffsetLow
    
    LDX.w #$0000
    LDA.w #$0040
    
    BRA .startTransfers

    ; $000D96 ALTERNATE ENTRY POINT
    .secondHalf

    ; Write the second 0x1000 bytes to VRAM (half of a tilemap).
    
    ; Source bank is 0x7F.
    LDA.b #$7F : STA.w DMA.0_SourceAddrBank
    
    ; Update target VRAM address after writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    REP #$31
    
    ; Source address is $7F3000.
    LDA.w #$3000 : STA.w DMA.0_SourceAddrOffsetLow
    
    LDX.w #$0040
    LDA.w #$0080

    .startTransfers

    ; This part does several DMA transfers that build a tilemap.
    STA.b $02
    
    ; Alternate writing to $2118 and $2119, autoincrement source address.
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    LDA.w #$0001 : STA.b $00
    
    ; We gonna write 0x80 bytes tonight... doo wop wop.
    LDY.w #$0080
    
    .nextRound

        ; Each iteration of this loop writes four packets of 0x80 bytes each
        ; (0x200 bytes). Since the number of packets [ times two ] is specified
        ; by (A - X) in the various entry points to the function, this results
        ; in either 0x1000 or 0x2000 bytes being written to VRAM.

        ; Target VRAM address (word) is determined by $7F4000.
        LDA.l $7F4000, X : STA.w SNES.VRAMAddrReadWriteLow

        ; Store the number of bytes to use to the proper register.
        STY.w DMA.0_TransferSizeLow

        ; Transfer data on channel 0.
        LDA.b $00 : STA.w SNES.DMAChannelEnable
        
        ; Updating the target VRAM address with a new value.
        LDA.l $7F4002, X : STA.w SNES.VRAMAddrReadWriteLow

        ; Reset the number of bytes to 0x80.
        STY.w DMA.0_TransferSizeLow
        
        ; Perform another 0x80 byte transfer.
        LDA.b $00 : STA.w SNES.DMAChannelEnable
        
        ; Updating target VRAM address (again, yeesh).
        LDA.l $7F4004, X : STA.w SNES.VRAMAddrReadWriteLow
        
        ; 0x80 bytes (again, double yeesh).
        STY.w DMA.0_TransferSizeLow
        
        ; I think you can tell where this is headed.
        LDA.b $00 : STA.w SNES.DMAChannelEnable
        
        LDA.l $7F4006, X : STA.w SNES.VRAMAddrReadWriteLow
        
        STY.w DMA.0_TransferSizeLow
        
        LDA.b $00 : STA.w SNES.DMAChannelEnable

    ; Note there was a REP #$31 earlier that reset the carry. Tells the next
    ; iteration to handle the next 4 packets specified in the $7F4000, X array.
    TXA : ADC.w #$0008 : TAX : CMP.b $02 : BNE .nextRound
    
    SEP #$30
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; $000E09-$000E4A JUMP LOCATION
NMI_UpdateBG1Wall:
{
    REP #$20
    
    ; Target dma address is $2118, write two registers once mode, auto
    ; increment source address.
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; VRAM target address (word) = $0116.
    LDA.w $0116 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Update VRAM address after writes to $2119.
    LDX.b #$81 : STX.w SNES.VRAMAddrIncrementVal
    
    ; Source address = $7EC880.
    LDX.b #$7E   : STX.w DMA.0_SourceAddrBank
    LDA.w #$C880 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Write 0x40 bytes.
    LDA.w #$0040 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 0.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    ; Write 0x40 bytes again.
    STA.w DMA.0_TransferSizeLow
    
    ; Increment VRAM target address by 0x800 words.
    LDA.w $0116 : CLC : ADC.w #$0800 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Source address = $7EC8C0.
    LDA.w #$C8C0 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Transfer data on channel 0.
    STY.w SNES.DMAChannelEnable
    
    REP #$20
    
    RTS
}

; $000E4B JUMP LOCATION
NMI_DoNothing:
{
    .doNothing

    RTS
}

; ==============================================================================

; $000E4C-$000E53 DATA
NMI_UpdateLoadLightWorldMap_VRAM_offset:
{
    dw $0000, $0020, $1000, $1020
}

; $000E54-$000EA8 JUMP LOCATION
NMI_LightWorldMode7Tilemap:
{
    STZ.w SNES.VRAMAddrIncrementVal
    
    ; Source address is in bank 0x0A.
    LDA.b #$0A : STA.w DMA.0_SourceAddrBank
    
    REP #$20
    
    ; Writing to $2118, incrementing of source address enabled (write once).
    LDA.w #$1800 : STA.w DMA.0_TransferParameters
    
    STZ.b $04 : STZ.b $02
    
    LDY.b #$01
    LDX.b #$00

    .alpha

        LDA.w #$0020 : STA.b $06
        
        LDA.w .VRAM_offset, X : STA.b $00

        .beta

            LDA.b $00 : STA.w SNES.VRAMAddrReadWriteLow
            
            ; But is adjusted for each iteration of the loop by 0x80 words
            ; (0x100 bytes).
            CLC : ADC.w #$0080 : STA.b $00
            
            ; Mode 7 tilemap data is based at $054727 in ROM.
            ; This data fills in the tilemap data that isn't "blank".
            LDA.b $02 : CLC : ADC.w #WorldMap_LightWorldTilemap
            STA.w DMA.0_SourceAddrOffsetLow
            
            ; Number of bytes to transfer is 0x0020.
            LDA.w #$0020 : STA.w DMA.0_TransferSizeLow
            
            STY.w SNES.DMAChannelEnable
            
            CLC : ADC.b $02 : STA.b $02
        DEC.b $06 : BNE .beta
        
        INC.b $04 : INC.b $04
    LDX.b $04 : CPX.b #$08 : BNE .alpha
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; Copies $7F0000[0x1000] to VRAM address $0000.
; $000EA9-$000EE6 JUMP LOCATION
NMI_UpdateLeftBg2Tilemaps:
{
    ; VRAM address increments after writing to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    REP #$10
    
    ; Target address in VRAM is (word) 0x0000.
    LDY.w #$0000 : STY.w SNES.VRAMAddrReadWriteLow
    
    ; Target $2118, two registers write once ($2118 / $2119 alternating).
    LDY.w #$1801 : STY.w DMA.1_TransferParameters
    
    ; Source address is $7F0000.
    LDY.w #$0000 : STY.w DMA.1_SourceAddrOffsetLow
    LDA.b #$7F : STA.w DMA.1_SourceAddrBank
    
    ; Transfer 0x0800 bytes.
    LDY.w #$0800 : STY.w DMA.1_TransferSizeLow
    
    ; Use channel 2 to transfer the data.
    LDA.b #$02 : STA.w SNES.DMAChannelEnable
    
    STY.w DMA.1_TransferSizeLow
    
    ; Target address in VRAM is (word) 0x0800.
    LDY.w #$0800 : STY.w SNES.VRAMAddrReadWriteLow
    
    ; Source address is $7F0800.
    LDY.w #$0800 : STY.w DMA.1_SourceAddrOffsetLow
    
    ; Use channel 1 to transfer the data.
    STA.w SNES.DMAChannelEnable
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; Transfers 0x1000 bytes from $7F0000 to VRAM $2C00 (word).
; $000EE7-$000F15 JUMP LOCATION
NMI_UpdateBgChrSlots_3_to_4:
{
    REP #$20
    
    ; VRAM target is $2C00 (word).
    LDA.w #$2C00 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Increment VRAM address on writes to $2119.
    LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
    
    ; Target bbus address is $2118, write two registers once ($2118 / $2119).
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Source address is $7F0000.
    LDA.w #$0000 : STA.w DMA.0_SourceAddrOffsetLow
    LDY.b #$7F : STY.w DMA.0_SourceAddrBank
    
    ; Write 0x1000 bytes.
    LDA.w #$1000 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 0.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; Transfers 0x1000 bytes from $7F0000 to VRAM $3400 (word).
; $000F16-$000F44 JUMP LOCATION
NMI_UpdateBgChrSlots_5_to_6:
{
    REP #$20
    
    ; VRAM target address is $3400 (word).
    LDA.w #$3400 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Increment on writes to $2119.
    LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
    
    ; Target $2118, write twice ($2118 / $2119).
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Source address is $7F1000.
    LDA.w #$1000 : STA.w DMA.0_SourceAddrOffsetLow
    LDY.b #$7F   : STY.w DMA.0_SourceAddrBank
    
    ; Write 0x1000 bytes.
    LDA.w #$1000 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; $000F45-$000F71 JUMP LOCATION
NMI_UpdateChrHalfSlot:
{
    ; Set VRAM target address as variable ($0116).
    LDA.w $0116 : STA.w SNES.VRAMAddrReadWriteHigh
    
    REP #$10
    
    ; Increment on writes to $2119.
    LDX.w #$0080 : STX.w SNES.VRAMAddrIncrementVal
    
    ; Target is $2118, write twice ($2118 / $2119).
    LDX.w #$1801 : STX.w DMA.0_TransferParameters
    
    ; Source address is $7F1000.
    LDX.w #$1000 : STX.w DMA.0_SourceAddrOffsetLow
    LDA.b #$7F   : STA.w DMA.0_SourceAddrBank
    
    ; Write 0x400 bytes.
    LDX.w #$0400 : STX.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDA.b #$01 : STA.w SNES.DMAChannelEnable
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; $000F72-$000F78 JUMP LOCATION
NMI_UpdateChr_Bg0:
{
    REP #$20
    
    ; Set VRAM target to $2000 (word).
    LDA.w #$2000
    
    BRA NMI_UpdateChr_doUpdate
}

; ==============================================================================

; $000F79-$000F7F JUMP LOCATION
NMI_UpdateChr_Bg1:
{
    REP #$20
    
    ; Set VRAM target to $2800 (word).
    LDA.w #$2800
    
    BRA NMI_UpdateChr_doUpdate
}

; ==============================================================================

; $000F80-$000F86 JUMP LOCATION
NMI_UpdateChr_Bg2:
{
    REP #$20
    
    ; Set VRAM target to $3000 (word).
    LDA.w #$3000
    
    BRA NMI_UpdateChr_doUpdate
}

; ==============================================================================

; $000F87-$000F8D JUMP LOCATION
NMI_UpdateChr_Bg3:
{
    REP #$20
    
    ; Set VRAM target to $3800 (word).
    LDA.w #$3800
    
    BRA NMI_UpdateChr_doUpdate
}

; ==============================================================================

; $000F8E-$000FBC JUMP LOCATION
NMI_UpdateChr_Spr0:
{
    REP #$20
    
    ; VRAM target addr is $4400 (word).
    LDA.w #$4400 : STA.w SNES.VRAMAddrReadWriteLow
    
    LDA.w #$0000 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Increment VRAM address on writes to $2119.
    LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
    
    ; Target is $2118, write two registers once ($2118 / $2119).
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Source address is $7F0000.
    LDY.b #$7F : STY.w DMA.0_SourceAddrBank
    
    ; Write 0x0800 bytes.
    LDA.w #$0800 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; $000FBD-$000FC3 JUMP LOCATION
NMI_UpdateChr_Spr2:
{
    REP #$20
    
    ; Set VRAM target to $5000 (word).
    LDA.w #$5000
    
    BRA NMI_UpdateChr_doUpdate
}

; ==============================================================================

; $000FC4-$000FF2 JUMP LOCATION
NMI_UpdateChr_Spr3:
{
    REP #$20
    
    ; Set VRAM target to $5800 (word).
    LDA.w #$5800

    .doUpdate

    STA.w SNES.VRAMAddrReadWriteLow
    
    LDA.w #$0000 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Increment on writes to $2119.
    LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
    
    ; Target is $2118, write two registers once ($2118 / $2119).
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Source address is $7F0000.
    LDY.b #$7F : STY.w DMA.0_SourceAddrBank
    
    ; Write 0x1000 bytes.
    LDA.w #$1000 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    STZ.w $0710
    
    RTS
}

; ==============================================================================

; $000FF3-$001037 JUMP LOCATION
NMI_DarkWorldMode7Tilemap:
{
    ; Increment VRAM address on writes to $2118.
    STZ.w SNES.VRAMAddrIncrementVal
    
    ; Source bank is 0x00.
    STZ.w DMA.0_SourceAddrBank
    
    REP #$20
    
    ; Set dma target register to $2118.
    LDA.w #$1800 : STA.w DMA.0_TransferParameters
    
    STZ.b $02
    
    LDA.w #$0020 : STA.b $06
    LDA.w #$0810 : STA.b $00
    
    ; Going to transfer on channel 0.
    LDY.b #$01

    .writeLoop

        LDA.b $00 : STA.w SNES.VRAMAddrReadWriteLow
        CLC : ADC.w #$0080 : STA.b $00
        
        LDA.b $02 : CLC : ADC.w #$1000 : STA.w DMA.0_SourceAddrOffsetLow
        
        ; Transfering 0x20 bytes.
        LDA.w #$0020 : STA.w DMA.0_TransferSizeLow
        
        ; Perform dma transfer.
        STY.w SNES.DMAChannelEnable
        
        ; Increment source address by 0x20 bytes each iteration.
        CLC : ADC.b $02 : STA.b $02
    
    ; Loop 0x20 times.
    DEC.b $06 : BNE .writeLoop
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; Transfers 0x800 bytes from $7E2000 to VRAM $7800 (word).
; $001038-$00108A JUMP LOCATION
NMI_UpdateBg3ChrForDeathMode:
{
    REP #$20
    
    ; Target VRAM addr is $7800 (word).
    LDA.w #$7800 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Source address is $7E2000.
    LDA.w #$2000 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Increment VRAM addr on writes to $2119.
    LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
    
    ; Target is $2118, write two registers once ($2118 / $2119).
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Source address is $7E2000.
    LDY.b #$7E : STY.w DMA.0_SourceAddrBank
    
    ; Write 0x0800 bytes.
    LDA.b #$0800 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    ; Target VRAM addr is $7D00.
    LDA.w #$7D00 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Source address is $7E3400.
    LDA.w #$3400 : STA.w DMA.0_SourceAddrOffsetLow
    
    ; Don't know why this was written again. The value hasn't changed.
    ; I suspect some macro tomfoolery.
    LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
    
    ; Again, this setting hasn't changed.
    LDA.w #$1801 : STA.w DMA.0_TransferParameters
    
    ; Source address is $7E3400.
    LDY.b #$7E : STY.w DMA.0_SourceAddrBank
    
    ; Transfer 0x0600 bytes.
    LDA.w #$0600 : STA.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDY.b #$01 : STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    RTS
}

; Transfers 0x100 bytes from $7F0000 to VRAM $3D00 (word).
; $00108B-$0010B6 JUMP LOCATION
NMI_UpdateBarrierTileChr:
{
    REP #$10
    
    ; VRAM target address is $3D00 (word).
    LDX.w #$3D00 : STX.w SNES.VRAMAddrReadWriteLow
    
    ; Increment target addr on writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Base register is $2118, write two registers once ($2118 / $2119).
    LDX.w #$1801 : STX.w DMA.0_TransferParameters
    
    ; Source address is $7F0000.
    LDX.w #$0000 : STX.w DMA.0_SourceAddrOffsetLow
    LDA.b #$7F : STA.w DMA.0_SourceAddrBank
    
    ; Write 0x100 bytes.
    LDX.w #$0100 : STX.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDA.b #$01 : STA.w SNES.DMAChannelEnable
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; Transfers 0x40 bytes from $7F0000 to VRAM $3ED0 (word).
; $0010B7-$0010E2 JUMP LOCATION
NMI_UpdateStarTiles:
{
    REP #$10
    
    ; VRAM target address is $3ED0 (word).
    LDX.w #$3ED0 : STX.w SNES.VRAMAddrReadWriteLow
    
    ; Increment VRAM address on writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Base register is $2118, two registers write once ($2118 / $2119).
    LDX.w #$1801 : STX.w DMA.0_TransferParameters
    
    ; Source address is $7F0000.
    LDX.w #$0000 : STX.w DMA.0_SourceAddrOffsetLow
    LDA.b #$7F   : STA.w DMA.0_SourceAddrBank
    
    ; Write 0x40 bytes.
    LDX.w #$0040 : STX.w DMA.0_TransferSizeLow
    
    ; Transfer data on channel 1.
    LDA.b #$01 : STA.w SNES.DMAChannelEnable
    
    REP #$10
    
    RTS
}

; ==============================================================================

; $0010E3-$0010E6 LONG JUMP LOCATION
NMI_UploadTilemap_long:
{
    JSR.w NMI_UploadTilemap
    
    RTL
}

; ==============================================================================

; Unused???
; $0010E7-$0010EA LONG JUMP LOCATION
NMI_UpdateOWScroll_long:
{
    JSR.w NMI_UpdateScrollingOwMap
    
    RTL
}

; ==============================================================================

; $0010EB-$00110E LONG JUMP LOCATION
UNREACHABLE_0090EB:
{
    STA.b $14 : TAY
    
    LDA.w Stripes14_SourceAddress_low-1, Y  : STA.b $00
    LDA.w Stripes14_SourceAddress_high-1, Y : STA.b $01
    LDA.w Stripes14_SourceAddress_bank-1, Y : STA.b $02
    
    JSR.w HandleStripes14
    
    LDA.b $14 : CMP.b #$01 : BNE .alpha
        STZ.w $1000 : STZ.w $1001

    .alpha

    STZ.b $14
    
    RTL
}

; ==============================================================================

; $00110F-$00112E DATA
UnderworldTilemapQuadrantOffset:
{
    dw $0000, $1000, $0000, $0040
    dw $0040, $1040, $1000, $1040
    dw $1000, $0000, $0040, $0000
    dw $1040, $0040, $1040, $1000
}

; $00112F-$00113E DATA
UnderworldTilemapQuadrantVRAMIndex:
{
    db $01, $05, $09, $0D
    db $02, $06, $0A, $0E
    db $03, $07, $0B, $0F
    db $04, $08, $0C, $10
}

; $00113F-$0011C3 LONG JUMP LOCATION
Underworld_PrepareNextRoomQuadrantUpload:
{
    REP #$31
    
    LDA.w $0418 : AND.w #$000F : ADC.w $045C : PHA : ASL A : TAY
    
    LDX.w UnderworldTilemapQuadrantOffset, Y
    
    LDY.w #$0000

    .copyTilemap

            ; Every iteration writes 0x100 bytes.
            LDA.l $7E2000, X : STA.w $1000, Y
            LDA.l $7E2002, X : STA.w $1002, Y
            LDA.l $7E2080, X : STA.w $1040, Y
            LDA.l $7E2082, X : STA.w $1042, Y
            LDA.l $7E2100, X : STA.w $1080, Y
            LDA.l $7E2102, X : STA.w $1082, Y
            LDA.l $7E2180, X : STA.w $10C0, Y
            LDA.l $7E2182, X : STA.w $10C2, Y
            
            INX #4
        
        ; Loop until Y has increased by $40.
        ; (what's wrong with a CPY.w #$0040 : BCC ...?
        INY #4 : TYA : AND.w #$003F : BNE .copyTilemap
        
        ; Y's net increase: $100.
        TYA : CLC : ADC.w #$00C0 : TAY
        
        ; X's net increase: $200.
        TXA : CLC : ADC.w #$01C0 : TAX
    
    ; Loop until Y reaches $800.
    CPY.w #$0800 : BNE .copyTilemap
    
    PLX
    
    SEP #$20
    
    LDA.w $045C : CLC : ADC.b #$04 : STA.w $045C
    
    LDA.w UnderworldTilemapQuadrantVRAMIndex, X : STA.w $0116
    
    LDA.b #$01 : STA.b $17 : STA.w $0710
    
    RTL
}

; ==============================================================================

; Seems to be used to update the tiles of an room (indoors).
; One known use is for the watergate.
; $0011C4-$0012A0 LONG JUMP LOCATION
WaterFlood_BuildOneQuadrantForVRAM:
{
    ; Not a water enabled room?
    LDA.b $AE : CMP.b #$19 : BNE .noWater
        LDA.w $0405 : AND.l DungeonMask+1 : BEQ .skipAllThis

    ; $0011D3 ALTERNATE ENTRY POINT
    .noWater

    REP #$31
    
    ; It's worth noting that both $418 and $45C start off at zero.
    LDA.w $0418 : AND.w #$000F : ADC.w $045C : PHA : ASL A : TAY
    
    LDX.w UnderworldTilemapQuadrantOffset, Y
    
    LDY.w #$0000

    .loadBlitBuffer
        
            ; Every iteration will write 0x100 bytes.
            LDA.l $7E4000, X : STA.w $1000, Y
            LDA.l $7E4002, X : STA.w $1002, Y
            LDA.l $7E4080, X : STA.w $1040, Y
            LDA.l $7E4082, X : STA.w $1042, Y
            LDA.l $7E4100, X : STA.w $1080, Y
            LDA.l $7E4102, X : STA.w $1082, Y
            LDA.l $7E4180, X : STA.w $10C0, Y
            LDA.l $7E4182, X : STA.w $10C2, Y
            
            INX #4
        INY #4 : TYA : AND.w #$003F : BNE .loadBlitBuffer
        
        ; Net Y increase, $100.
        TYA : CLC : ADC.w #$00C0 : TAY
        
        ; Net X increase, $200.
        TXA : CLC : ADC.w #$01C0 : TAX

    ; Stop when we've written $800 bytes.
    CPY.w #$0800 : BNE .loadBlitBuffer
    
    PLX ; X = previously masked value ( ($418 & #$000F) + 0x045C).
    
    SEP #$30
    
    LDA.w UnderworldTilemapQuadrantVRAMIndex, X : CLC : ADC.b #$10 : STA.w $0116
    
    LDA.b #$01 : STA.b $17 : STA.w $0710
    
    RTL

    .skipAllThis

    REP #$31
    
    LDX.w #$00F0
    LDY.w #$0000

    .waterLoop

            LDA.w RoomDrawObjectData, X
            
            STA.w $1000, Y : STA.w $1002, Y : STA.w $1040, Y : STA.w $1042, Y
            STA.w $1080, Y : STA.w $1082, Y : STA.w $10C0, Y : STA.w $10C2, Y
        INY #4 : TYA : AND.w #$003F : BNE .waterLoop
    TYA : CLC : ADC.w #$00C0 : TAY : CPY.w #$0800 : BNE .waterLoop
    
    LDA.w $0418 : AND.w #$000F : CLC : ADC.w $045C : TAX
    
    SEP #$30
    
    LDA.w UnderworldTilemapQuadrantVRAMIndex, X : CLC : ADC.b #$10 : STA.w $0116
    
    RTL
}

; ==============================================================================

; $0012A1-$001346 LOCAL JUMP LOCATION
HandleStripes14:
{
    REP #$10
    
    ; Designates a source bank for a transfer to VRAM.
    STA.w DMA.1_SourceAddrBank
    
    ; You may have noticed this function is passed parameters through memory.
    STZ.b $06
    
    LDY.w #$0000
    
    ; Typically tells us whether to look at $1000 or $1002.
    LDA [$00], Y : BPL .validTransfer
        SEP #$30
        
        RTS

    .validTransfer

    ; Determines the VRAM target address.
                         STA.b $04
    INY : LDA [$00], Y : STA.b $03 
    
    ; If this number is negative, A will end up as 0x01, otherwise 0x00. This
    ; determines whether the transfer will write to the tilemap in a horizontal
    ; or vertical fashion.
    INY : LDA [$00], Y : AND.b #$80 : ASL A : ROL A : STA.b $07
    
    ; Check whether the source address will be fixed or incrmenting during the
    ; transfer.
    LDA [$00], Y : AND.b #$40 : STA.b $05
    
    ; This adds the "two registers, write once" setting.
    LSR #3 : ORA.b #$01 : STA.w DMA.1_TransferParameters
    
    ; Write to $2118 in DMA transfers.
    LDA.b #$18 : STA.w DMA.1_DestinationAddr
    
    REP #$20
    
    ; Write to the VRAM target address register.
    LDA.b $03 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Set the number of bytes to transfer.
    ; (the amount stored in the buffer is the number of bytes minus one).
    LDA [$00], Y : XBA : AND.w #$3FFF : TAX : INX : STX.w DMA.1_TransferSizeLow
    
    ; Set the source address (which will be somewhere in the $1000[0x800]
    ; buffer.
    INY #2 : TYA : CLC : ADC.b $00 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; A = #$40 or #$00.
    ; If DMAing in incremental mode, branch.
    LDA.b $05 : BEQ .incrementSourceAddress
        INX
        
        TXA : LSR A : TAX : STX.w DMA.1_TransferSizeLow
        
        SEP #$20
        
        LDA.b $05 : LSR #3 : STA.w DMA.1_TransferParameters
        
        ; A = 0x00 or 0x01.
        ; Hence we'll either increment VRAM addresses by 2 or 64 bytes.
        LDA.b $07 : STA.w SNES.VRAMAddrIncrementVal
        
        LDA.b #$02 : STA.w SNES.DMAChannelEnable ; Fire DMA channel 2.
        
        ; Now data is written to $2119 (upper byte only gets written).
        LDA.b #$19 : STA.w DMA.1_DestinationAddr
        
        REP #$21
        
        ; Y is still the offset after reading the encoding information earlier.
        TYA
        
        ; Add the original absolute address to this offset.
        ; It becomes the source address for DMA.
        ADC.b $00 : INC A : STA.w DMA.1_SourceAddrOffsetLow
        
        ; $03 contains the VRAM target address.
        LDA.b $03 : STA.w SNES.VRAMAddrReadWriteLow
        
        ; X contains the number of bytes to transfer.
        STX.w DMA.1_TransferSizeLow
        
        LDX.w #$0002

    .incrementSourceAddress

    ; Not sure what the point of this is.... seems useless.
    STX.b $03
    
    ; Again, the offset past the encoding info.
    ; A procedure to position ourselves just past the encoding information.
    TYA : CLC : ADC.b $03 : TAY
    
    SEP #$20
    
    ; A = 0x01 or 0x00
    ; We're incrementing when $2118 is accessed.
    LDA.b $07 : ORA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Fire DMA channel 1.
    LDA.b #$02 : STA.w SNES.DMAChannelEnable
    
    LDA [$00], Y : BMI .endOfTransfers
        JMP .validTransfer

    .endOfTransfers

    SEP #$30
    
    RTS
}

; ==============================================================================

; $001347-$00137A LOCAL JUMP LOCATION
NMI_UpdateIrqGfx:
{
    LDA.w $1F0C : BEQ .noTransfer
        ; Increment VRAM address when $2119 is written.
        LDA.b #$80 : STA.w !VMAINC
        
        REP #$20
        
        ; VRAM target is $5800.
        LDA.w #$5800 : STA.w !VMADDR
        
        ; DMA will write to $2118, write two registers once mode ($2118/$2119).
        LDA.w #$1801 : STA.w !DMAP0
        
        ; Source address is $7EE800.
        LDA.w #$e800 : STA.w !A1T0
        LDX.b #$7e   : STX.w !A1B0
        
        ; We're going to write 0x800 bytes.
        LDA.w #$0800 : STA.w !DAS0
        
        SEP #$20
        
        ; Transfer data on channel 0.
        LDA.b #$01 : STA.w !MDMAEN
        
        STZ.w $1F0C

    .noTransfer

    RTS
}

; ==============================================================================

; $00137B-$001395 DATA TABLE
Stripes14_SourceAddress:
{
    ; $00137B
    .low
    db $02, $00, $6D, $1B, $BF, $A8, $3C, $56, $9C

    ; $001384
    .high
    db $10, $10, $DD, $02, $E7, $E2, $E6, $E4, $DA

    ; $00138D
    .bank
    db $00, $00, $0C, $00, $0C, $0C, $0C, $0C, $0E
}

; $001396-$004FF2 DATA
LinkOAM_HeadAddresses:
{
    dw $8080, $8080, $8080, $8080, $8080, $8040, $8040, $8040
    dw $8040, $8040, $8000, $8000, $8000, $8000, $8000, $8000
    dw $9440, $8080, $8080, $8080, $9400, $8040, $80C0, $80C0
    dw $8000, $8000, $8000, $8000, $8000, $8000, $8000, $8000
    dw $8080, $8080, $8080, $8080, $8080, $8040, $8040, $8040
    dw $8040, $8040, $8000, $A8C0, $A900, $8000, $A8C0, $A900
    dw $9100, $8080, $8080, $90C0, $8040, $8000, $8000, $8000
    dw $8000, $8000, $8000, $9A00, $9140, $9180, $8000, $9500
    dw $9480, $94C0, $94C0, $9AE0, $8080, $8080, $9A60, $80C0
    dw $80C0, $9AA0, $8000, $8000, $9AA0, $8000, $8000, $8080
    dw $8080, $8100, $8100, $85C0, $8000, $8000, $85C0, $8000
    dw $8000, $ADC0, $ADC0, $ADC0, $ADC0, $ADC0, $AD40, $AD40
    dw $AD40, $AD40, $AD40, $AD80, $AD80, $AD80, $AD80, $AD80
    dw $AD80, $8040, $9400, $8040, $8000, $8080, $8080, $9440
    dw $8000, $8000, $8000, $8000, $8080, $8040, $8040, $8000
    dw $8000, $8000, $8000, $8000, $8000, $C440, $8140, $8140
    dw $CA40, $8000, $8000, $8000, $8000, $8000, $8000, $8040
    dw $85C0, $8040, $85C0, $8100, $80C0, $91C0, $8080, $8080
    dw $8040, $8040, $8000, $8000, $8000, $8000, $8080, $8080
    dw $9100, $A0C0, $A100, $A100, $A1C0, $A400, $A440, $A1C0
    dw $A400, $A440, $8080, $C480, $8080, $8040, $8040, $CA80
    dw $CA80, $CA00, $C400, $CA00, $C400, $81C0, $8080, $8080
    dw $8080, $8080, $8080, $8080, $8080, $8080, $8040, $8040
    dw $8040, $8040, $8040, $8040, $8040, $8000, $A8C0, $A900
    dw $8000, $8000, $A8C0, $A900, $8000, $A8C0, $A900, $8000
    dw $8000, $A8C0, $A900, $8040, $8040, $8040, $8080, $8080
    dw $8040, $8040, $8040, $8040, $8000, $8000, $8000, $8000
    dw $D080, $8080, $90C0, $D000, $9080, $D040, $9080, $D040
    dw $D080, $D080, $D080, $D080, $D080, $D000, $D000, $D000
    dw $D000, $D000, $D040, $D040, $D040, $D040, $D040, $D040
    dw $8040, $D000, $85C0, $85C0, $85C0, $DC40, $DC40, $DC40
    dw $85C0, $85C0, $85C0, $DC40, $DC40, $DC40, $E1C0, $D000
    dw $8000, $E400, $E400, $E440, $90C0, $90C0, $D000, $8000
    dw $8000, $D040, $8000, $8000, $D040, $E400, $E400, $E400
    dw $9080, $A5C0, $AC40, $E480, $8180, $90C0, $80C0, $E180
    dw $D000, $E4C0, $E4C0, $E840, $E840, $E840, $E540, $E540
    dw $E540, $E900, $E900, $E900, $E900, $8080, $8080, $8000
    dw $A9C0, $8080, $8140, $91C0, $8040, $A800, $A840
}

; $0015F4-$001851
LinkOAM_BodyAddresses:
{
    dw $8840, $8800, $8580, $8800, $8580, $84C0, $8500, $8540
    dw $8500, $8540, $8400, $8440, $8480, $8400, $8440, $8480
    dw $9640, $8C40, $8C80, $AD00, $9600, $8980, $8C00, $ACC0
    dw $8880, $88C0, $8900, $8940, $8880, $88C0, $8900, $8940
    dw $B0C0, $B100, $B140, $B100, $B140, $B000, $B040, $B080
    dw $EC80, $ECC0, $B180, $D440, $B1C0, $B180, $D440, $B1C0
    dw $8C80, $AD00, $95C0, $99C0, $B440, $9580, $B480, $B4C0
    dw $9580, $B480, $B4C0, $9C20, $8000, $8000, $8000, $9700
    dw $9680, $96C0, $96C0, $9CE0, $8C80, $B540, $9C60, $B580
    dw $8C00, $9CA0, $8900, $B500, $9CA0, $8900, $B500, $8C40
    dw $EC40, $8C00, $EC00, $8DC0, $9540, $89C0, $8DC0, $9540
    dw $89C0, $B940, $B980, $B9C0, $B980, $B9C0, $B5C0, $B800
    dw $B840, $B800, $B840, $B880, $B8C0, $B900, $B880, $B8C0
    dw $B900, $8980, $9600, $BCC0, $8400, $BC80, $8C40, $9640
    dw $A040, $A080, $A000, $BC40, $BD40, $8500, $BD00, $BD80
    dw $BD80, $88C0, $8900, $E9C0, $8900, $C640, $C040, $C000
    dw $CC40, $8940, $88C0, $8900, $E9C0, $8900, $8940, $8D40
    dw $8D80, $8D40, $8D80, $BD00, $B000, $B000, $A480, $A480
    dw $A480, $A480, $AC00, $AC00, $AC00, $AC00, $A140, $A180
    dw $A180, $A4C0, $A4C0, $A500, $9D40, $9D80, $9DC0, $9D40
    dw $9D80, $9DC0, $8D00, $C680, $C180, $C140, $8C00, $CC80
    dw $CC80, $CC00, $C600, $CC00, $C600, $BD00, $8580, $8800
    dw $C9C0, $CCC0, $CDC0, $CD00, $CD40, $CD80, $8500, $8540
    dw $C940, $C980, $8540, $C940, $C980, $8440, $8480, $C1C0
    dw $C900, $C580, $C5C0, $C8C0, $8440, $8480, $C1C0, $C900
    dw $C580, $C5C0, $C8C0, $BD00, $ACC0, $C040, $D540, $D580
    dw $D4C0, $D500, $D4C0, $D500, $D440, $D480, $D440, $D480
    dw $D1C0, $D400, $D100, $D100, $D140, $D180, $D140, $D180
    dw $B0C0, $B100, $B140, $B100, $B140, $DD40, $DD80, $DDC0
    dw $DD80, $DDC0, $DC80, $DCC0, $DD00, $DC80, $DCC0, $DD00
    dw $D100, $D100, $E000, $E040, $E080, $E0C0, $E100, $E140
    dw $E000, $E040, $E080, $E0C0, $E100, $E140, $8000, $D0C0
    dw $8000, $B940, $B980, $B940, $DD40, $DD80, $DD40, $DC80
    dw $DCC0, $C0C0, $DC80, $DCC0, $C0C0, $B9C0, $B980, $B9C0
    dw $A560, $A5A0, $AC80, $ED00, $8000, $8CC0, $BD00, $E380
    dw $BDC0, $E500, $E500, $E880, $E8C0, $E8C0, $E800, $E5C0
    dw $E5C0, $E940, $E980, $E940, $E980, $BD40, $8C80, $A080
    dw $8000, $A980, $BD00, $BDC0, $B400, $A880, $EDC0
}

; $001852-$001887
LinkOAM_AuxAddresses:
{
    dw $9A40, $9E00, $9D20, $9F20, $9B20, $BC20, $BC20, $BE20
    dw $BE20, $BE00, $BE00, $BE00, $BE00, $A540, $A540, $A540
    dw $A540, $BC00, $BC00, $BC00, $BC00, $A740, $A740, $A740
    dw $A740, $E780, $E780
}

; $001888-$0018AA DATA
TilemapUpload_HighBytes:
{
    db $00, $00, $04, $08, $0C, $08, $0C, $00
    db $04, $00, $08, $04, $0C, $04, $0C, $00
    db $08, $10, $14, $18, $1C, $18, $1C, $10
    db $14, $10, $18, $14, $1C, $14, $1C, $10
    db $18, $60, $68
}

; $0018AB-$0018BF - NULL
NULL_0098AB:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF
}

; $0018C0-$0018C7 DATA
DungeonMask:
{
    dw $8000 ; Sewers
    dw $4000 ; Hyrule Castle
    dw $2000 ; Eastern Palace
    dw $1000 ; Desert Palace
}

; $0018C8-$0018DF DATA
DoorFlagMasks:
{
    dw $0800 ; Agahnim's Tower
    dw $0400 ; Swamp Palace
    dw $0200 ; Palace of Darkness
    dw $0100 ; Misery Mire
    dw $0080 ; Skull Woods
    dw $0040 ; Ice Palace
    dw $0020 ; Tower of Hera
    dw $0010 ; Thieves' Town
    dw $0008 ; Turtle Rock
    dw $0004 ; Ganon's Tower
    dw $0002 ; Unused
    dw $0001 ; Unused
}

; $0018E0-$0018FF DATA
DungeonMaskInverted:
{
    dw $7FFF ; Sewers
    dw $BFFF ; Hyrule Castle
    dw $DFFF ; Eastern Palace
    dw $EFFF ; Desert Palace
    dw $F7FF ; Agahnim's Tower
    dw $FBFF ; Swamp Palace
    dw $FDFF ; Palace of Darkness
    dw $FEFF ; Misery Mire
    dw $FF7F ; Skull Woods
    dw $FFBF ; Ice Palace
    dw $FFDF ; Tower of Hera
    dw $FFEF ; Thieves' Town
    dw $FFF7 ; Turtle Rock
    dw $FFFB ; Ganon's Tower
    dw $FFFD ; Unused
    dw $FFFE ; Unused
}

; $001900-$00190B
RoomFlagMask:
{
    dw $0100
    dw $0200
    dw $0400
    dw $0800
    dw $1000
    dw $2000
}

; $00190C-$00197D
RoomsWithPitDamage:
{
    dw $0072 ; ROOM 0072
    dw $0082 ; ROOM 0082
    dw $0040 ; ROOM 0040
    dw $00C0 ; ROOM 00C0
    dw $0112 ; ROOM 0112
    dw $0056 ; ROOM 0056
    dw $0057 ; ROOM 0057
    dw $0058 ; ROOM 0058
    dw $0067 ; ROOM 0067
    dw $0068 ; ROOM 0068
    dw $0049 ; ROOM 0049
    dw $0098 ; ROOM 0098
    dw $00D1 ; ROOM 00D1
    dw $00C3 ; ROOM 00C3
    dw $00A3 ; ROOM 00A3
    dw $00A2 ; ROOM 00A2
    dw $0092 ; ROOM 0092
    dw $00A0 ; ROOM 00A0
    dw $004E ; ROOM 004E
    dw $007F ; ROOM 007F
    dw $00AF ; ROOM 00AF
    dw $00F0 ; ROOM 00F0
    dw $00F1 ; ROOM 00F1
    dw $00E6 ; ROOM 00E6
    dw $00E7 ; ROOM 00E7
    dw $00C6 ; ROOM 00C6
    dw $00C7 ; ROOM 00C7
    dw $00D6 ; ROOM 00D6
    dw $00B4 ; ROOM 00B4
    dw $00B5 ; ROOM 00B5
    dw $00C5 ; ROOM 00C5
    dw $0024 ; ROOM 0024
    dw $00D5 ; ROOM 00D5
    dw $00C9 ; ROOM 00C9
    dw $002A ; ROOM 002A
    dw $001A ; ROOM 001A
    dw $004B ; ROOM 004B
    dw $00BC ; ROOM 00BC
    dw $0044 ; ROOM 0044
    dw $00FB ; ROOM 00FB
    dw $007B ; ROOM 007B
    dw $007C ; ROOM 007C
    dw $008B ; ROOM 008B
    dw $008D ; ROOM 008D
    dw $009B ; ROOM 009B
    dw $009C ; ROOM 009C
    dw $009D ; ROOM 009D
    dw $00A5 ; ROOM 00A5
    dw $0095 ; ROOM 0095
    dw $001C ; ROOM 001C
    dw $005C ; ROOM 005C
    dw $007D ; ROOM 007D
    dw $004C ; ROOM 004C
    dw $0096 ; ROOM 0096
    dw $0120 ; ROOM 0120
    dw $003C ; ROOM 003C
    dw $0123 ; ROOM 0123
}

; $00197E-$001989
DoorTilemapPositions_NorthWall:
{
    dw $021C
    dw $023C
    dw $025C
    dw $039C
    dw $03BC
    dw $03DC
}

; $00198A-$001995
DoorTilemapPositions_NorthMiddle:
{
    dw $121C
    dw $123C
    dw $125C
    dw $139C
    dw $13BC
    dw $13DC
}

; $001996-$0019A7
DoorTilemapPositions_SouthMiddle:
{
    dw $0D1C
    dw $0D3C
    dw $0D5C
    dw $0B9C
    dw $0BBC
    dw $0BDC
    dw $1D1C
    dw $1D3C
    dw $1D5C
}

; $0019A8-$0019AD
DoorTilemapPositions_LowerLayerEntrance:
{
    dw $1B9C
    dw $1BBC
    dw $1BDC
}

; $0019AE-$0019B9
DoorTilemapPositions_WestWall:
{
    dw $0784
    dw $0F84
    dw $1784
    dw $078A
    dw $0F8A
    dw $178A
}

; $0019BA-$0199C5
DoorTilemapPositions_WestMiddle:
{
    dw $07C4
    dw $0FC4
    dw $17C4
    dw $07CA
    dw $0FCA
    dw $17CA
}

; $0019C6-$0019D1
DoorTilemapPositions_EastMiddle:
{
    dw $07B4
    dw $0FB4
    dw $17B4
    dw $07AE
    dw $0FAE
    dw $17AE
}

; $0019D2-$0019DD
DoorTilemapPositions_EastWall:
{
    dw $07F4
    dw $0FF4
    dw $17F4
    dw $07EE
    dw $0FEE
    dw $17EE
}

; ==============================================================================

; $0019DE-$0019E9
ExplodingWallTilemapPosition:
{
    dw $0D8A
    dw $0DAA
    dw $0DCA
    dw $02B6
    dw $0AB6
    dw $12B6
}

; ==============================================================================

; $0019EA-$001A01
DetectStaircase:
{
    ; $0019EA
    .offset_y
    dw $0007
    dw $0018
    dw $0008
    dw $0008

    ; $0019F2
    .offset_x
    dw $0000
    dw $0000
    dw $FFFF
    dw $0011

    ; $0019FA
    .index_offset
    dw $0002
    dw $0002
    dw $0080
    dw $0080
}

; ==============================================================================

; $001A02-$001A51
DoorwayReplacementDoorGFX:
{
    db $00, $00, $02, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $12, $00, $00, $00, $00, $00
    db $50, $00, $00, $00, $50, $00, $50, $00
    db $60, $00, $62, $00, $64, $00, $66, $00
    db $52, $00, $5A, $00, $50, $00, $52, $00
    db $54, $00, $56, $00, $00, $00, $50, $00
    db $50, $00, $00, $00, $00, $00, $00, $00
    db $40, $00, $58, $00, $58, $00, $00, $00
    db $58, $00, $58, $00, $00, $00, $00, $00
}

; $001A52-$001AA1
DoorwayTileProperties:
{
    db $80, $80, $84, $84, $00, $00, $01, $01
    db $84, $84, $8E, $8E, $00, $00, $00, $00
    db $88, $88, $8E, $8E, $80, $80, $80, $80
    db $82, $82, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $82, $82, $8E, $8E, $80, $80, $82, $82
    db $80, $80, $80, $80, $80, $80, $82, $82
    db $82, $82, $80, $80, $80, $80, $80, $80
    db $84, $84, $84, $84, $86, $86, $88, $88
    db $86, $86, $86, $86, $80, $80, $80, $80
}

; ==============================================================================

; $001AA2-$001AD1
RoomDraw_DoorPartnerSelfLocation:
{
    dw $0000, $0010, $0020, $0030, $0040, $0050
    dw $0061, $0071, $0081, $0091, $00A1, $00B1
    dw $0002, $0012, $0022, $0032, $0042, $0052
    dw $0063, $0073, $0083, $0093, $00A3, $00B3
}

; $001AD2-$001B01
RoomDraw_DoorPartnerLocation:
{
    dw $0061, $0071, $0081, $0091, $00A1, $00B1
    dw $0000, $0010, $0020, $0030, $0040, $0050
    dw $0063, $0073, $0083, $0093, $00A3, $00B3
    dw $0002, $0012, $0022, $0032, $0042, $0052
}

; $001B02-$001B09 DATA
Dungeon_QuadrantOffsets:
{
    dw $0000, $0040, $1000, $1040
}

; $001B0A-$001B11 DATA
RoomDraw_MovingWallDirection:
{
    dw 5, 7, 11, 15
}

; $001B12-$001B19
MovingWallObjectCount:
{
    dw 8, 16, 24, 32
}

; ==============================================================================

; $001B1A-$001B29 DATA
MovingWallEastBoundaries:
{
    dw $FFC1
    dw $FF81
    dw $FF41
    dw $FF01

    dw $FFB9
    dw $FF79
    dw $FF39
    dw $FEF9
}

; ==============================================================================

; $001B2A-$001B39 DATA
MovingWallWestBoundaries:
{
    dw $0042
    dw $0082
    dw $00C2
    dw $0102

    dw $004A
    dw $008A
    dw $00CA
    dw $010A
}

; ==============================================================================

; $001B3A-$001B41 DATA
WaterOverlayHDMAPositionOffset:
{
    dw $0002
    dw $0003
    dw $0004
    dw $0005
}

; $001B42-$001B45 DATA
WaterOverlayHDMASize:
{
    dw $0020
    dw $0030
}

; $001B46-$001B49 DATA
WaterOverlayObjectCount:
{
    dw $0040
    dw $0050
}

; ==============================================================================

; $001B4A-$001B51 DATA
UNREACHABLE_009B4A:
{
    dw $0003, $0005, $0007, $0009
}

; ==============================================================================

; $001B52-$004F45 DATA
RoomDrawObjectData:
{
    ; $001B52-$001B61 DATA
    Obj0000:
    {
        dw $14EE, $14EF, $14EE, $14EF
        dw $14FE, $14FF, $14FE, $14FF
    }

    ; ==========================================================================

    ; $001B62-$001B71 DATA
    Obj0010:
    {
        dw $0CEE, $0CEF, $0CEE, $0CEF
        dw $0CFE, $0CFF, $0CFE, $0CFF
    }

    ; ==========================================================================

    ; $001B72-$001B81 DATA
    Obj0020:
    {
        dw $0CEC, $0CED, $0CEC, $0CED
        dw $0CFC, $0CFD, $0CFC, $0CFD
    }

    ; ==========================================================================

    ; $001B82-$001B91 DATA
    Obj0030:
    {
        dw $14EC, $14ED, $14EC, $14ED
        dw $14FC, $14FD, $14FC, $14FD
    }

    ; ==========================================================================

    ; $001B92-$001BA1 DATA
    Obj0040:
    {
        dw $18EE, $18EF, $18EE, $18EF
        dw $18FE, $18FF, $18FE, $18FF
    }

    ; ==========================================================================

    ; $001BA2-$001BB1 DATA
    Obj0050:
    {
        dw $10EE, $10EF, $10EE, $10EF
        dw $10FE, $10FF, $10FE, $10FF
    }

    ; ==========================================================================

    ; $001BB2-$001BC1 DATA
    Obj0060:
    {
        dw $10EC, $10ED, $10EC, $10ED
        dw $10FC, $10FD, $10FC, $10FD
    }

    ; ==========================================================================

    ; $001BC2-$001BD1 DATA
    Obj0070:
    {
        dw $18EC, $18ED, $18EC, $18ED
        dw $18FC, $18FD, $18FC, $18FD
    }

    ; ==========================================================================

    ; $001BD2-$001BE1 DATA
    Obj0080:
    {
        dw $10C1, $10C1, $10C1, $10C1
        dw $10C1, $10C1, $10C1, $10C1
    }

    ; ==========================================================================

    ; $001BE2-$001BF1 DATA
    Obj0090:
    {
        dw $18CA, $18CB, $18CA, $18CB
        dw $18DA, $18DB, $18DA, $18DB
    }

    ; ==========================================================================

    ; $001BF2-$001C01 DATA
    Obj00A0:
    {
        dw $18C9, $18C9, $18C9, $18C9
        dw $18C9, $18C9, $18C9, $18C9
    }

    ; ==========================================================================

    ; $001C02-$001C11 DATA
    Obj00B0:
    {
        dw $1DB6, $1DB7, $1DB6, $1DB7
        dw $1DB8, $1DB9, $1DB8, $1DB9
    }

    ; ==========================================================================

    ; $001C12-$001C21 DATA
    Obj00C0:
    {
        dw $1DAE, $1DAF, $1DAE, $1DAF
        dw $1DBE, $1DBF, $1DBE, $1DBF
    }

    ; ==========================================================================

    ; $001C22-$001C31 DATA
    Obj00D0:
    {
        dw $090C, $490C, $090C, $490C
        dw $890C, $C90C, $890C, $C90C
    }

    ; ==========================================================================

    ; $001C32-$001C41 DATA
    Obj00E0:
    {
        dw $01EC, $01EC, $01EC, $01EC
        dw $01EC, $01EC, $01EC, $01EC
    }

    ; ==========================================================================

    ; $001C42-$009C51 DATA
    Obj00F0:
    {
        dw $01EB, $01EB, $01EB, $01EB
        dw $01EB, $01EB, $01EB, $01EB
    }

    ; ==========================================================================

    ; $009C52-$001C61 DATA
    Obj0100:
    {
        dw $1DBA, $1DBB, $1DBA, $1DBB
        dw $1DBC, $1DBD, $1DBC, $1DBD
    }

    ; ==========================================================================

    ; $001C62-$001C71 DATA
    Obj0110:
    {
        dw $1DB6, $1DB7, $1DB6, $1DB7
        dw $1DB8, $1DB9, $1DB8, $1DB9
    }

    ; ==========================================================================

    ; $001C72-$001C81 DATA
    Obj0120:
    {
        dw $1DB0, $1DB1, $1DB0, $1DB1
        dw $9DB0, $9DB1, $9DB0, $9DB1
    }

    ; ==========================================================================

    ; $001C82-$001C91 DATA
    Obj0130:
    {
        dw $1DBA, $1DBB, $1DBA, $1DBB
        dw $1DBC, $1DBD, $1DBC, $1DBD
    }

    ; ==========================================================================

    ; $001C92-$001C99 DATA
    Obj0140:
    {
        dw $1DB5, $1DB5, $1DB5, $1DB5
    }

    ; ==========================================================================

    ; $001C9A-$001CA9 DATA
    Obj0148:
    {
        dw $1DA6, $5DA6, $1DA6, $5DA6
        dw $9DA6, $DDA6, $9DA6, $DDA6
    }

    ; ==========================================================================

    ; $001CAA-$001CB9 DATA
    Obj0158:
    {
        dw $08D0, $08D0, $08D0, $08D0
        dw $08D0, $08D0, $08D0, $08D0
    }

    ; ==========================================================================

    ; $001CBA-$001CC9 DATA
    Obj0168:
    {
        dw $18CA, $18CB, $18CA, $18CB
        dw $18DA, $18DB, $18DA, $18DB
    }

    ; ==========================================================================

    ; $001CCA-$001CD9 DATA
    Obj0178:
    {
        dw $0C62, $0C63, $0C62, $0C63
        dw $0C62, $0C63, $0C62, $0C63
    }

    ; ==========================================================================

    ; $001CDA-$001CF1 DATA
    Obj0188:
    {
        dw $0DCC, $0DCC, $0DCC, $0DCC
        dw $0DCC, $0DCC, $0DCC, $0DCC
    }

    ; ==========================================================================

    ; $001CF2-$001CF1 DATA
    Obj0198:
    {
        dw $090D, $091D, $490D, $491D
    }

    ; ==========================================================================

    ; $001CF2-$001D01 DATA
    Obj01A0:
    {
        dw $10EC, $10ED, $10EC, $10ED
        dw $10FC, $10FD, $10FC, $10FD
    }

    ; ==========================================================================

    ; $001D02-$001D11 DATA
    Obj01B0:
    {
        dw $090C, $490C, $090C, $490C
        dw $890C, $C90C, $890C, $C90C
    }

    ; ==========================================================================

    ; $001D12-$001D21 DATA
    Obj01C0:
    {
        dw $190F, $190F, $190F, $190F
        dw $190F, $190F, $190F, $190F
    }

    ; ==========================================================================

    ; $001D22-$001D31 DATA
    Obj01D0:
    {
        dw $09BE, $49BE, $09BE, $49BE
        dw $09BE, $49BE, $09BE, $49BE
    }

    ; ==========================================================================

    ; $001D32-$001D41 DATA
    Obj01E0:
    {
        dw $09BF, $49BF, $09BF, $49BF
        dw $09BF, $49BF, $09BF, $49BF
    }

    ; ==========================================================================

    ; $001D42-$001D51 DATA
    Obj01F0:
    {
        dw $09B1, $09B1, $09B1, $09B1
        dw $89B1, $89B1, $89B1, $89B1
    }

    ; ==========================================================================

    ; $001D52-$001D61 DATA
    Obj0200:
    {
        dw $09B0, $09B0, $09B0, $09B0
        dw $89B0, $89B0, $89B0, $89B0
    }

    ; ==========================================================================

    ; $001D62-$001D69 DATA
    Obj0210:
    {
        dw $0982, $0992, $0983, $0993
    }

    ; ==========================================================================

    ; $001D6A-$001D71 DATA
    Obj0218:
    {
        dw $4983, $4993, $4982, $4992
    }

    ; ==========================================================================

    ; $001D72-$001D79 DATA
    Obj0220:
    {
        dw $0CCC, $0CCD, $0CDC, $0CCE
    }

    ; $001D7A-$001D81 DATA
    Obj0228:
    {
        dw $0CCC, $0CCF, $0CDC, $0CDD
    }

    ; $001D82-$001D89 DATA
    Obj0230:
    {
        dw $0CCC, $0CCD, $0CDE, $0CDD
    }

    ; $001D8A-$001DB1 DATA
    Obj0238:
    {
        dw $0CDF, $0CCD, $0CDC, $0CDD

        dw $0CCC, $0CDC, $0CCD, $0CCE
        dw $0CCC, $0CDC, $0CCF, $0CDD
        dw $0CCC, $0CDE, $0CCD, $0CDD
        dw $0CDF, $0CDC, $0CCD, $0CDD
    }

    ; ==========================================================================

    ; $001DB2-$001DD1 DATA
    Obj0260:
    {
        dw $0CCC, $0CCD, $0CCC, $0CCD
        dw $0CDC, $0CDD, $0CDC, $0CDD
        dw $0CCC, $0CCD, $0CCC, $0CCD
        dw $0CDC, $0CDD, $0CDC, $0CDD
    }

    ; ==========================================================================

    ; $001DD2-$001DD9 DATA
    Obj0280:
    {
        dw $0CCC, $0CDC, $0CCD, $0CDD
    }

    ; ==========================================================================

    ; $001DDA-$001DF9 DATA
    Obj0288:
    {
        dw $1C13, $1C41, $1C13, $1C41
        dw $1C40, $1C42, $1C40, $1C42
        dw $1C13, $1C41, $1C13, $1C41
        dw $1C40, $1C42, $1C40, $1C42
    }

    ; ==========================================================================

    ; $001DFA-$001E19 DATA
    Obj02A8:
    {
        dw $1576, $1577, $1576, $1577
        dw $1578, $1579, $1578, $1579
        dw $1576, $1577, $1576, $1577
        dw $1578, $1579, $1578, $1579
    }

    ; ==========================================================================

    ; $001E1A-$001E29 DATA
    Obj02C8:
    {
        dw $0892, $0898, $08A4, $0CAD
        dw $0893, $0899, $08A5, $8CAD
    }

    ; ==========================================================================

    ; $001E2A-$001E39 DATA
    Obj02D8:
    {
        dw $4CAD, $48A4, $4898, $4892
        dw $CCAD, $48A5, $4899, $4893
    }

    ; ==========================================================================

    ; $001E3A-$001E49 DATA
    Obj02E8:
    {
        dw $0890, $0896, $08A2, $0CAC
        dw $0891, $0897, $08A3, $4CAC
    }

    ; ==========================================================================

    ; $001E4A-$001E59 DATA
    Obj02F8:
    {
        dw $8CAC, $88A2, $8896, $8890
        dw $CCAC, $88A3, $8897, $8891
    }

    ; ==========================================================================

    ; $001E5A-$001E69 DATA
    Obj0308:
    {
        dw $0843, $0844, $0871, $90AD
        dw $0853, $0854, $0871, $10AD
    }

    ; ==========================================================================

    ; $001E6A-$001E79 DATA
    Obj0318:
    {
        dw $D0AD, $4871, $4844, $4843
        dw $50AD, $4871, $4854, $4853
    }

    ; ==========================================================================

    ; $001E7A-$001E89 DATA
    Obj0328:
    {
        dw $0850, $0860, $0870, $50AC
        dw $0851, $0861, $0870, $10AC
    }

    ; ==========================================================================

    ; $001E8A-$001EC9 DATA
    Obj0338:
    {
        dw $D0AC, $8870, $8860, $8850
        dw $90AC, $8870, $8861, $8851
        dw $1C6B, $1C6B, $1C6B, $1C6B
        dw $1C6C, $1C8D, $5C8D, $5C6C
        dw $5C6B, $5C6B, $5C6B, $5C6B
        dw $1C6A, $1C6A, $1C6A, $1C6A
        dw $1C7A, $1C8E, $9C8E, $9C7A
        dw $9C6A, $9C6A, $9C6A, $9C6A
    }

    ; ==========================================================================

    ; $001ECA-$001ED1 DATA
    Obj0378:
    {
        dw $1C6B, $1C6B, $1C6C, $1C6C
    }

    ; ==========================================================================

    ; $001ED2-$001ED9 DATA
    Obj0380:
    {
        dw $5C6C, $5C6C, $5C6B, $5C6B
    }

    ; ==========================================================================

    ; $001EDA-$001EE1 DATA
    Obj0388:
    {
        dw $1C6A, $1C7A, $1C6A, $1C7A
    }

    ; ==========================================================================

    ; $001EE2-$001EE9 DATA
    Obj0390:
    {
        dw $9C7A, $9C6A, $9C7A, $9C6A
    }

    ; ==========================================================================

    ; $001EEA-$001EF1 DATA
    Obj0398:
    {
        dw $1C7B, $1C6B, $1C6A, $1C45
    }

    ; ==========================================================================

    ; $001EF2-$001EF9 DATA
    Obj03A0:
    {
        dw $1C6B, $9C7B, $9C45, $9C6A
    }

    ; ==========================================================================

    ; $001EFA-$001F01 DATA
    Obj03A8:
    {
        dw $1C6A, $5C45, $5C7B, $5C6B
    }

    ; ==========================================================================

    ; $001F02-$001F09 DATA
    Obj03B0:
    {
        dw $DC45, $9C6A, $5C6B, $DC7B
    }

    ; ==========================================================================

    ; $001F0A-$001F11 DATA
    Obj03B8:
    {
        dw $1C7C, $1C7A, $1C6C, $1C55
    }

    ; ==========================================================================

    ; $001F12-$001F19 DATA
    Obj03C0:
    {
        dw $9C7A, $9C7C, $9C55, $1C6C
    }

    ; ==========================================================================

    ; $001F1A-$001F21 DATA
    Obj03C8:
    {
        dw $5C6C, $5C55, $5C7C, $1C7A
    }

    ; ==========================================================================

    ; $001F22-$001F29 DATA
    Obj03D0:
    {
        dw $DC55, $5C6C, $9C7A, $DC7C
    }

    ; ==========================================================================

    ; $001F2A-$001F31 DATA
    Obj03D8:
    {
        dw $3C15, $3C15, $3C15, $3C15
    }

    ; ==========================================================================

    ; $001F32-$001F41 DATA
    Obj03E0:
    {
        dw $0951, $0961, $0941, $0971
        dw $8951, $8961, $8941, $8971
    }

    ; ==========================================================================

    ; $001F42-$001F51 DATA
    Obj03F0:
    {
        dw $4971, $4941, $4961, $4951
        dw $C971, $C941, $C961, $C951
    }

    ; ==========================================================================

    ; $001F52-$001F61 DATA
    Obj0400:
    {
        dw $0950, $0960, $0940, $0970
        dw $4950, $4960, $4940, $4970
    }

    ; ==========================================================================

    ; $001F62-$001F71 DATA
    Obj0410:
    {
        dw $8970, $8940, $8960, $8950
        dw $C970, $C940, $C960, $C950
    }

    ; ==========================================================================

    ; $001F72-$001F7B DATA
    Obj0420:
    {
        dw $0880, $0881, $089A, $089B
        dw $14AB
    }

    ; ==========================================================================

    ; $001F7C-$001F85 DATA
    Obj042A:
    {
        dw $94AB, $889B, $889A, $8881
        dw $8880
    }

    ; ==========================================================================

    ; $001F86-$001F8F DATA
    Obj0434:
    {
        dw $4880, $4881, $489A, $489B
        dw $54AB
    }

    ; ==========================================================================

    ; $001F90-$001F99 DATA
    Obj043E:
    {
        dw $D4AB, $C89B, $C89A, $C881
        dw $C880
    }

    ; ==========================================================================

    ; $001F9A-$001FA3 DATA
    Obj0448:
    {
        dw $0880, $0881, $089A, $089B
        dw $0CAB
    }

    ; ==========================================================================

    ; $001FA4-$001FAD DATA
    Obj0452:
    {
        dw $8CAB, $889B, $889A, $8881
        dw $8880
    }

    ; ==========================================================================

    ; $001FAE-$001FB7 DATA
    Obj045C:
    {
        dw $4880, $4881, $489A, $489B
        dw $4CAB
    }

    ; ==========================================================================

    ; $001FB8-$001FC1 DATA
    Obj0466:
    {
        dw $CCAB, $C89B, $C89A, $C881
        dw $C880
    }

    ; ==========================================================================

    ; $001FC2-$001FCB DATA
    Obj0470:
    {
        dw $0880, $0881, $089A, $089B
        dw $10AB
    }

    ; ==========================================================================

    ; $001FCC-$001FD5 DATA
    Obj047A:
    {
        dw $90AB, $889B, $889A, $8881
        dw $8880
    }

    ; ==========================================================================

    ; $001FD6-$001FDF DATA
    Obj0484:
    {
        dw $4880, $4881, $489A, $489B
        dw $50AB
    }

    ; ==========================================================================

    ; $001FE0-$001FE9 DATA
    Obj048E:
    {
        dw $D0AB, $C89B, $C89A, $C881
        dw $C880
    }

    ; ==========================================================================

    ; $001FEA-$001FF3 DATA
    Obj0498:
    {
        dw $0849, $084A, $084B, $089C
        dw $18AB
    }

    ; ==========================================================================

    ; $001FF4-$001FFD DATA
    Obj04A2:
    {
        dw $98AB, $889C, $884B, $884A
        dw $8849
    }

    ; ==========================================================================

    ; $001FFE-$00A007 DATA
    Obj04AC:
    {
        dw $4849, $484A, $484B, $489C
        dw $58AB
    }

    ; ==========================================================================

    ; $00A008-$002011 DATA
    Obj04B6:
    {
        dw $D8AB, $C89C, $C84B, $C84A
        dw $C849
    }

    ; ==========================================================================

    ; $002012-$00201B DATA
    Obj04C0:
    {
        dw $0849, $084A, $084B, $089C
        dw $10AB
    }

    ; ==========================================================================

    ; $00201C-$002025 DATA
    Obj04CA:
    {
        dw $90AB, $889C, $884B, $884A
        dw $8849
    }

    ; ==========================================================================

    ; $002026-$00202F DATA
    Obj04D4:
    {
        dw $4849, $484A, $484B, $489C
        dw $50AB
    }

    ; ==========================================================================

    ; $002030-$002039 DATA
    Obj04DE:
    {
        dw $D0AB, $C89C, $C84B, $C84A
        dw $C849
    }

    ; ==========================================================================

    ; $00203A-$002043 DATA
    Obj04E8:
    {
        dw $0849, $084A, $084B, $089C
        dw $10AB
    }

    ; ==========================================================================

    ; $002044-$00204D DATA
    Obj04F2:
    {
        dw $90AB, $889C, $884B, $884A
        dw $8849
    }

    ; ==========================================================================

    ; $00204E-$002057 DATA
    Obj04FC:
    {
        dw $4849, $484A, $484B, $489C
        dw $50AB
    }

    ; ==========================================================================

    ; $002058-$002061 DATA
    Obj0506:
    {
        dw $D0AB, $C89C, $C84B, $C84A
        dw $C849
    }

    ; ==========================================================================

    ; $002062-$0020E1 DATA
    Obj0510:
    {
        dw $1DAA, $1DAC, $1DAC, $1D8B
        dw $1DAD, $1D8C, $1D8B, $1DAF
        dw $1DA5, $1D8B, $1DAF, $1DA6
        dw $1D8B, $1DAF, $1DA6, $1D8B
        dw $1DAF, $5DA5, $1D8B, $5DAD
        dw $5D8C, $5DAA, $5DAC, $5DAC
        dw $1DAC, $1D8C, $1DA7, $1DAC
        dw $1D8C, $1DA7, $1DA9, $1DA9
        dw $1DA9, $1DA9, $5DA7, $5D8C
        dw $5DAC, $5DA7, $5D8C, $5DAC
        dw $1DAC, $1DAC, $1DAB, $1D8C
        dw $1D9C, $1D9B, $9DA5, $1DAE
        dw $1D9B, $9DA6, $1DAE, $1D9B
        dw $9DA6, $1DAE, $1D9B, $DDA5
        dw $1DAE, $1D9B, $5D8C, $5D9C
        dw $1D9B, $5DAC, $5DAC, $5DAB
    }

    ; ==========================================================================

    ; $0020E2-$0020E9 DATA
    Obj0590:
    {
        dw $1DA8, $9DA8, $5DA8, $DDA8
    }

    ; ==========================================================================

    ; $0020EA-$0020FB DATA
    Obj0598:
    {
        dw $1D9D, $1D8D, $1D8D, $1D72
        dw $1D72, $1D72, $5D9D, $5D8D
        dw $5D8D
    }

    ; ==========================================================================

    ; $0020FC-$002103 DATA
    Obj05AA:
    {
        dw $01E9, $01E9, $01E9, $01E9
    }

    ; ==========================================================================

    ; $002104-$00210B DATA
    Obj05B2:
    {
        dw $18C9, $18C9, $18C9, $18C9
    }

    ; ==========================================================================

    ; $00210C-$00212B DATA
    Obj05BA:
    {
        dw $09DA, $09DE, $09DB, $01E9
        dw $09DB, $01E9, $49DA, $49DE
        dw $09DE, $09DC, $01E9, $09DD
        dw $01E9, $09DD, $49DE, $49DC
    }

    ; ==========================================================================

    ; $00212C-$00214B DATA
    Obj05DA:
    {
        dw $09DB, $01E9, $01E9, $09DD
        dw $09DB, $01E9, $01E9, $09DD
        dw $09DB, $01E9, $01E9, $09DD
        dw $09DB, $01E9, $01E9, $09DD
    }

    ; ==========================================================================

    ; $00214C-$002151 DATA
    Obj05FA:
    {
        dw $08E1, $08E3, $08E1
    }

    ; ==========================================================================

    ; $002152-$002157 DATA
    Obj0600:
    {
        dw $08E1, $08E2, $08E1
    }

    ; ==========================================================================

    ; $002158-$00216F DATA
    Obj0606:
    {
        dw $08E0, $08F0, $48E0, $48F0
        dw $08F3, $48F3, $08E0, $08F1
        dw $08E4, $48E0, $48F1, $48E4
    }

    ; ==========================================================================

    ; $002170-$00218D DATA
    Obj061E:
    {
        dw $08E0, $08F1, $08E4, $48E0
        dw $48F1, $48E4, $08F4, $08F2
        dw $08E5, $08E0, $08F1, $08E4
        dw $48E0, $48F1, $48E4
    }

    ; ==========================================================================

    ; $00218E-$002193 DATA
    Obj063C:
    {
        dw $09DA, $09DB, $49DA
    }

    ; ==========================================================================

    ; $002194-$002199 DATA
    Obj0642:
    {
        dw $09DC, $09DD, $49DC
    }

    ; ==========================================================================

    ; $00219A-$00219B DATA
    Obj0648:
    {
        dw $09DE
    }

    ; ==========================================================================

    ; $00219C-$00219D DATA
    Obj064A:
    {
        dw $49DE
    }

    ; ==========================================================================

    ; $00219E-$0021A3 DATA
    Obj064C:
    {
        dw $09DF, $09DD, $49DF
    }

    ; ==========================================================================

    ; $0021A4-$0021A9 DATA
    Obj0652:
    {
        dw $89DF, $09DB, $C9DF
    }

    ; ==========================================================================

    ; $0021AA-$0021AF DATA
    Obj0658:
    {
        dw $09DF, $09DD, $49DC
    }

    ; ==========================================================================

    ; $0021B0-$0021B5 DATA
    Obj065E:
    {
        dw $09DC, $09DD, $49DF
    }

    ; ==========================================================================

    ; $0021B6-$0021BB DATA
    Obj0664:
    {
        dw $89DF, $09DB, $49DA
    }

    ; ==========================================================================

    ; $0021BC-$0021C1 DATA
    Obj066A:
    {
        dw $09DA, $09DB, $C9DF
    }

    ; ==========================================================================

    ; $0021C2-$0021CD DATA
    Obj0670:
    {
        dw $08E3, $4846, $4843, $4869
        dw $4853, $C846
    }

    ; ==========================================================================

    ; $0021CE-$0021D9 DATA
    Obj067C:
    {
        dw $08E3, $0846, $0843, $0869
        dw $0853, $8846
    }

    ; ==========================================================================

    ; $0021DA-$0021EF DATA
    Obj0688:
    {
        dw $08E2, $8846, $8850, $8868
        dw $8851, $C846
    }

    ; ==========================================================================

    ; $0021F0-$0021F1 DATA
    Obj0694:
    {
        dw $08E2, $0846, $0850, $0868
        dw $0851, $4846
    }

    ; ==========================================================================

    ; $0021F2-$0021F3 DATA
    Obj06A0:
    {
        dw $0852
    }

    ; ==========================================================================

    ; $0021F4-$0021F5 DATA
    Obj06A2:
    {
        dw $4852
    }

    ; ==========================================================================

    ; $0021F6-$0021F7 DATA
    Obj06A4:
    {
        dw $085C
    }

    ; ==========================================================================

    ; $0021F8-$0021F9 DATA
    Obj06A6:
    {
        dw $885C
    }

    ; ==========================================================================

    ; $0021FA-$002219 DATA
    Obj06A8:
    {
        dw $1CC6, $1CC6, $1CC6, $1CC6
        dw $1CC6, $1CC6, $1CC6, $1CC6
        dw $1CC6, $1CC6, $1CC6, $1CC6
        dw $1CC6, $1CC6, $1CC6, $1CC6
    }

    ; ==========================================================================

    ; $00221A-$00227B DATA
    Obj06C8:
    {
        dw $0973, $28A0, $28A1, $A8A1
        dw $A8A0, $0867, $09EF, $09EF
        dw $8867, $0865, $085A, $885A
        dw $8865, $4865, $485A, $C85A
        dw $C865, $4867, $09EF, $09EF
        dw $C867, $68A0, $68A1, $E8A1
        dw $E8A0, $28A0, $28A1, $A8A1
        dw $A8A0, $0867, $09EF, $09EF
        dw $8867, $0865, $085A, $885A
        dw $8865, $4865, $485A, $C85A
        dw $C865, $4867, $09EF, $09EF
        dw $C867, $68A0, $68A1, $E8A1
        dw $E8A0
    }

    ; ==========================================================================

    ; $00227C-$0022AB DATA
    Obj072A:
    {
        dw $294E, $2893, $0892, $01EC
        dw $295E, $0898, $01EC, $01EC
        dw $096E, $0893, $0899, $08A5
        dw $0892, $0898, $08A4, $0893
        dw $A893, $A94E, $0899, $A95E
        dw $01EC, $896E, $01EC, $01EC
    }

    ; ==========================================================================

    ; $0022AC-$0022DB DATA
    Obj075A:
    {
        dw $01EC, $01EC, $496E, $01EC
        dw $695E, $4898, $694E, $6893
        dw $4892, $48A5, $4899, $4893
        dw $48A4, $4898, $4892, $C96E
        dw $01EC, $01EC, $4899, $E95E
        dw $01EC, $4893, $E893, $E94E
    }

    ; ==========================================================================

    ; $0022DC-$0022FB DATA
    Obj078A:
    {
        dw $096E, $1148, $1168, $1159
        dw $496E, $1149, $1169, $5159
        dw $096E, $5149, $5169, $1159
        dw $496E, $5148, $5168, $5159
    }

    ; ==========================================================================

    ; $0022FC-$00231B DATA
    Obj07AA:
    {
        dw $097E, $897E, $097E, $897E
        dw $11AE, $1146, $9146, $91AE
        dw $11AF, $1166, $9166, $91AF
        dw $1156, $9156, $1156, $9156
    }

    ; ==========================================================================

    ; $00231C-$00233B DATA
    Obj07CA:
    {
        dw $5156, $D156, $5156, $D156
        dw $51AF, $1167, $9167, $D1AF
        dw $51AE, $1147, $9147, $D1AE
        dw $497E, $C97E, $497E, $C97E
    }

    ; ==========================================================================

    ; $00233C-$00235B DATA
    Obj07EA:
    {
        dw $096E, $115E, $1178, $1158
        dw $496E, $114E, $1177, $1174
        dw $096E, $114E, $5177, $5174
        dw $496E, $515E, $5178, $5158
    }

    ; ==========================================================================

    ; $00235C-$00237B DATA
    Obj080A:
    {
        dw $097E, $897E, $097E, $897E
        dw $11AC, $11AD, $11AD, $91AC
        dw $1179, $1176, $9176, $9179
        dw $1157, $1175, $9175, $9157
    }

    ; ==========================================================================

    ; $00237C-$00239B DATA
    Obj082A:
    {
        dw $5157, $5175, $D175, $D157
        dw $5179, $5176, $D176, $D179
        dw $51AC, $51AD, $51AD, $D1AC
        dw $497E, $C97E, $497E, $C97E
    }

    ; ==========================================================================

    ; $00239C-$0023AB DATA
    Obj084A:
    {
        dw $28E7, $28F7, $28E6, $08F6
        dw $68E7, $68F7, $68E6, $48F6
    }

    ; ==========================================================================

    ; $0023AC-$0023BB DATA
    Obj085A:
    {
        dw $2DC2, $2DC3, $2D2C, $0D3C
        dw $6DC2, $6DC3, $6D2C, $4D3C
    }

    ; ==========================================================================

    ; $0023BC-$0023D3 DATA
    Obj086A:
    {
        dw $0942, $1162, $1152, $0943
        dw $1163, $1153, $4943, $5163
        dw $5153, $4942, $5162, $5152
    }

    ; ==========================================================================

    ; $0023D4-$0023EB DATA
    Obj0882:
    {
        dw $9152, $9162, $8942, $9153
        dw $9163, $8943, $D153, $D163
        dw $C943, $D152, $D162, $C942
    }

    ; ==========================================================================

    ; $0023EC-$002403 DATA
    Obj089A:
    {
        dw $0944, $0954, $8954, $8944
        dw $1164, $1165, $9165, $9164
        dw $1145, $1155, $9155, $9145
    }

    ; ==========================================================================

    ; $002404-$00241B DATA
    Obj08B2:
    {
        dw $5145, $5155, $D155, $D145
        dw $5164, $5165, $D165, $D164
        dw $4944, $4954, $C954, $C944
    }

    ; ==========================================================================

    ; $00241C-$00242B DATA
    Obj08CA:
    {
        dw $1548, $1549, $5548, $5549
        dw $1548, $1549, $5548, $5549
    }

    ; ==========================================================================

    ; $00242C-$00244B DATA
    Obj08DA:
    {
        dw $1587, $1588, $5588, $5587
        dw $1597, $1598, $5598, $5597
        dw $1589, $158A, $558A, $5589
        dw $1599, $159A, $559A, $5599
    }

    ; ==========================================================================

    ; $00244C-$002453 DATA
    Obj08FA:
    {
        dw $0980, $0990, $4980, $4990
    }

    ; ==========================================================================

    ; $002454-$00245B DATA
    Obj0902:
    {
        dw $8990, $8980, $C990, $C980
    }

    ; ==========================================================================

    ; $00245C-$002463 DATA
    Obj090A:
    {
        dw $0981, $8981, $0991, $8991
    }

    ; ==========================================================================

    ; $002464-$00246B DATA
    Obj0912:
    {
        dw $4991, $C991, $4981, $C981
    }

    ; ==========================================================================

    ; $00246C-$002471 DATA
    Obj091A:
    {
        dw $1DFE, $1DFC, $5DFE
    }

    ; ==========================================================================

    ; $002472-$002477 DATA
    Obj0920:
    {
        dw $9DFE, $9DFC, $DDFE
    }

    ; ==========================================================================

    ; $002478-$002479 DATA
    Obj0926:
    {
        dw $1DFD
    }

    ; ==========================================================================

    ; $00247A-$00247B DATA
    Obj0928:
    {
        dw $5DFD
    }

    ; ==========================================================================

    ; $00247C-$002481 DATA
    Obj092A:
    {
        dw $DDFF, $9DFC, $9DFF
    }

    ; ==========================================================================

    ; $002482-$002487 DATA
    Obj0930:
    {
        dw $5DFF, $1DFC, $1DFF
    }

    ; ==========================================================================

    ; $002488-$00248D DATA
    Obj0936:
    {
        dw $DDFF, $9DFC, $DDFE
    }

    ; ==========================================================================

    ; $00248E-$002493 DATA
    Obj093C:
    {
        dw $9DFE, $9DFC, $9DFF
    }

    ; ==========================================================================

    ; $002494-$002499 DATA
    Obj0942:
    {
        dw $5DFF, $1DFC, $5DFE
    }

    ; ==========================================================================

    ; $00249A-$00249F DATA
    Obj0948:
    {
        dw $1DFE, $1DFC, $1DFF
    }

    ; ==========================================================================

    ; $0024A0-$0024BD DATA
    Obj094E:
    {
        dw $1DF7, $1C40, $1C41, $1C42
        dw $1DB5, $1DB2, $1DB3, $1DB3
        dw $1DB4, $1DB5, $5DF7, $5C40
        dw $5C41, $5C42, $5DB5
    }

    ; ==========================================================================

    ; $0024BE-$0024CF DATA
    Obj096C:
    {
        dw $1DF7, $1C40, $1DB5, $1DB2
        dw $1DB3, $1DB5, $5DF7, $5C40
        dw $5DB5
    }

    ; ==========================================================================

    ; $0024D0-$0024DF DATA
    Obj097E:
    {
        dw $0C14, $0C14, $0C14, $0C14
        dw $8C14, $8C14, $8C14, $8C14
    }

    ; ==========================================================================

    ; $0024E0-$0024EF DATA
    Obj098E:
    {
        dw $0C64, $0C66, $0C64, $0C66
        dw $0C64, $0C66, $0C64, $0C66
    }

    ; ==========================================================================

    ; $0024F0-$002501 DATA
    Obj099E:
    {
        dw $0D46, $0D56, $157E, $0D47
        dw $0D57, $157F, $4D46, $4D56
        dw $557E
    }

    ; ==========================================================================

    ; $002502-$002509 DATA
    Obj09B0:
    {
        dw $0D46, $4D46, $8DAB, $4DAB
    }

    ; ==========================================================================

    ; $00250A-$002511 DATA
    Obj09B8:
    {
        dw $0D46, $0DAB, $0D47, $4DAD
    }

    ; ==========================================================================

    ; $002512-$002519 DATA
    Obj09C0:
    {
        dw $0DAB, $0D56, $4DAC, $0D57
    }

    ; ==========================================================================

    ; $00251A-$002521 DATA
    Obj09C8:
    {
        dw $0D47, $0DAD, $4D46, $4DAB
    }

    ; ==========================================================================

    ; $002522-$002529 DATA
    Obj09D0:
    {
        dw $0DAC, $0D57, $4DAB, $4D56
    }

    ; ==========================================================================

    ; $00252A-$002549 DATA
    Obj09D8:
    {
        dw $0940, $0960, $0950, $0970
        dw $0941, $0961, $0951, $0971
        dw $4941, $4961, $4951, $4971
        dw $4940, $4960, $4950, $4970
    }

    ; ==========================================================================

    ; $00254A-$00254B DATA
    Obj09F8:
    {
        dw $0D42
    }

    ; ==========================================================================

    ; $00254C-$00254D DATA
    Obj09FA:
    {
        dw $0D52
    }

    ; ==========================================================================

    ; $00254E-$00254F DATA
    Obj09FC:
    {
        dw $0D40
    }

    ; ==========================================================================

    ; $002550-$002551 DATA
    Obj09FE:
    {
        dw $0D50
    }

    ; ==========================================================================

    ; $002552-$002553 DATA
    Obj0A00:
    {
        dw $0D41
    }

    ; ==========================================================================

    ; $002554-$002555 DATA
    Obj0A02:
    {
        dw $0D51
    }

    ; ==========================================================================

    ; $002556-$002557 DATA
    Obj0A04:
    {
        dw $0D8E
    }

    ; ==========================================================================

    ; $002558-$002559 DATA
    Obj0A06:
    {
        dw $0D8F
    }

    ; ==========================================================================

    ; $00255A-$00255B DATA
    Obj0A08:
    {
        dw $0D9E
    }

    ; ==========================================================================

    ; $00255C-$00255D DATA
    Obj0A0A:
    {
        dw $0D9F
    }

    ; ==========================================================================

    ; $00255E-$00255F DATA
    Obj0A0C:
    {
        dw $0D43
    }

    ; ==========================================================================

    ; $002560-$002561 DATA
    Obj0A0E:
    {
        dw $0D53
    }

    ; ==========================================================================

    ; $002562-$002563 DATA
    Obj0A10:
    {
        dw $0DA9
    }

    ; ==========================================================================

    ; $002564-$002565 DATA
    Obj0A12:
    {
        dw $0DA8
    }

    ; ==========================================================================

    ; $002566-$002575 DATA
    Obj0A14:
    {
        dw $09C8, $0DC6, $4DC6, $49C8
        dw $09CA, $0D02, $4D02, $49CA
    }

    ; ==========================================================================

    ; $002576-$002585 DATA
    Obj0A24:
    {
        dw $89CA, $8D02, $CD02, $C9CA
        dw $89C8, $8DC6, $CDC6, $C9C8
    }

    ; ==========================================================================

    ; $002586-$002595 DATA
    Obj0A34:
    {
        dw $09C9, $0DC7, $8DC7, $89C9
        dw $09CB, $0D03, $8D03, $89CB
    }

    ; ==========================================================================

    ; $002596-$0025A5 DATA
    Obj0A44:
    {
        dw $49CB, $4D03, $CD03, $C9CB
        dw $49C9, $4DC7, $CDC7, $C9C9
    }

    ; ==========================================================================

    ; $0025A6-$0025BD DATA
    Obj0A54:
    {
        dw $0944, $0954, $8954, $8944
        dw $1164, $1165, $9165, $9164
        dw $1145, $1155, $9155, $9145
    }

    ; ==========================================================================

    ; $0025BE-$0025D5 DATA
    Obj0A6C:
    {
        dw $5145, $5155, $D155, $D145
        dw $5164, $5165, $D165, $D164
        dw $4944, $4954, $C954, $C944
    }

    ; ==========================================================================

    ; $0025D6-$0025ED DATA
    Obj0A84:
    {
        dw $1146, $1147, $9147, $9146
        dw $1166, $1167, $9167, $9166
        dw $1156, $1157, $9157, $9156
    }

    ; ==========================================================================

    ; $0025EE-$002605 DATA
    Obj0A9C:
    {
        dw $5156, $5157, $D157, $D156
        dw $5166, $5167, $D167, $D166
        dw $5146, $5147, $D147, $D146
    }

    ; ==========================================================================

    ; $002606-$00262F DATA
    Obj0AB4:
    {
        dw $098E, $098E, $099E, $1CC6
        dw $1CC6, $099F, $1CC6, $498F
        dw $499E, $1CC6, $0972, $0972
        dw $1CC6, $098F, $099E, $1CC6
        dw $1CC6, $099F, $498E, $498E
        dw $499E
    }

    ; ==========================================================================

    ; $002630-$002637 DATA
    Obj0ADE:
    {
        dw $0DE6, $0DF6, $4DE6, $4DF6
    }

    ; ==========================================================================

    ; $002638-$002657 DATA
    Obj0AE6:
    {
        dw $1DA9, $1DA9, $1DA9, $1DA9
        dw $1DA9, $1DA9, $1DA9, $1DA9
        dw $1DA9, $1DA9, $1DA9, $1DA9
        dw $1DA9, $1DA9, $1DA9, $1DA9
    }

    ; ==========================================================================

    ; $002658-$00265D DATA
    Obj0B06:
    {
        dw $9DA8, $9DA6, $DDA8
    }

    ; ==========================================================================

    ; $00265E-$002663 DATA
    Obj0B0C:
    {
        dw $1DA8, $1DA6, $5DA8
    }

    ; ==========================================================================

    ; $002664-$002665 DATA
    Obj0B12:
    {
        dw $1DA7
    }

    ; ==========================================================================

    ; $002666-$002667 DATA
    Obj0B14:
    {
        dw $5DA7
    }

    ; ==========================================================================

    ; $002668-$002677 DATA
    Obj0B16:
    {
        dw $4D66, $1D64, $1D44, $1D54
        dw $0D66, $5D64, $5D44, $5D54
    }

    ; ==========================================================================

    ; $002678-$002687 DATA
    Obj0B26:
    {
        dw $0946, $0966, $0956, $0CAC
        dw $0947, $0967, $0957, $4CAC
    }

    ; ==========================================================================

    ; $002688-$002697 DATA
    Obj0B36:
    {
        dw $8CAC, $8956, $8966, $8946
        dw $CCAC, $8957, $8967, $8947
    }

    ; ==========================================================================

    ; $002698-$0026A7 DATA
    Obj0B46:
    {
        dw $0948, $0968, $0958, $0CAD
        dw $0949, $0969, $0959, $8CAD
    }

    ; ==========================================================================

    ; $0026A8-$0026B7 DATA
    Obj0B56:
    {
        dw $4CAD, $4958, $4968, $4948
        dw $CCAD, $4959, $4969, $4949
    }

    ; ==========================================================================

    ; $0026B8-$0026D7 DATA
    Obj0B66:
    {
        dw $0894, $0893, $0892, $0893
        dw $0891, $089E, $0898, $0899
        dw $0890, $0896, $08A6, $08A5
        dw $0891, $0897, $08A3, $0CAE
    }

    ; ==========================================================================

    ; $0026D8-$0026F7 DATA
    Obj0B86:
    {
        dw $0892, $0893, $0892, $8894
        dw $0898, $0899, $889E, $8891
        dw $08A4, $88A6, $8896, $8890
        dw $8CAE, $88A3, $8897, $8891
    }

    ; ==========================================================================

    ; $0026F8-$002717 DATA
    Obj0BA6:
    {
        dw $0890, $0896, $08A2, $4CAE
        dw $0891, $0897, $48A6, $48A5
        dw $0890, $489E, $4898, $4899
        dw $4894, $4893, $4892, $4893
    }

    ; ==========================================================================

    ; $002718-$002737 DATA
    Obj0BC6:
    {
        dw $CCAE, $88A2, $8896, $8890
        dw $48A4, $C8A6, $8897, $8891
        dw $4898, $4899, $C89E, $8890
        dw $4892, $4893, $4892, $C894
    }

    ; ==========================================================================

    ; $002738-$002757 DATA
    Obj0BE6:
    {
        dw $0846, $0843, $0853, $0843
        dw $0850, $0847, $0854, $0844
        dw $0851, $0861, $0848, $0871
        dw $0850, $0860, $0870, $10AE
    }

    ; ==========================================================================

    ; $002758-$002777 DATA
    Obj0C06:
    {
        dw $0853, $0843, $0853, $8846
        dw $0854, $0844, $8847, $8850
        dw $0871, $8848, $8861, $8851
        dw $90AE, $8870, $8860, $8850
    }

    ; ==========================================================================

    ; $002778-$002797 DATA
    Obj0C26:
    {
        dw $0851, $0861, $0870, $50AE
        dw $0850, $0860, $4848, $4871
        dw $0851, $4847, $4854, $4844
        dw $4846, $4843, $4853, $4843
    }

    ; ==========================================================================

    ; $002798-$0027B7 DATA
    Obj0C46:
    {
        dw $D0AE, $8870, $8861, $8851
        dw $4871, $C848, $8860, $8850
        dw $4854, $4844, $C847, $8851
        dw $4853, $4843, $4853, $C846
    }

    ; ==========================================================================

    ; $0027B8-$0027D7 DATA
    Obj0C66:
    {
        dw $0895, $0896, $08A2, $0CAC
        dw $0898, $089F, $08A3, $4CAC
        dw $08A4, $08A5, $08A7, $0CAC
        dw $0CAD, $8CAD, $0CAD, $0CAF
    }

    ; ==========================================================================

    ; $0027D8-$0027F7 DATA
    Obj0C86:
    {
        dw $8CAC, $88A2, $8896, $8895
        dw $CCAC, $88A3, $889F, $0899
        dw $8CAC, $88A7, $08A4, $08A5
        dw $8CAF, $8CAD, $0CAD, $0CAD
    }

    ; ==========================================================================

    ; $0027F8-$002817 DATA
    Obj0CA6:
    {
        dw $4CAD, $CCAD, $4CAD, $4CAF
        dw $48A4, $48A5, $48A7, $4CAC
        dw $4898, $489F, $08A2, $0CAC
        dw $4895, $0897, $08A3, $4CAC
    }

    ; ==========================================================================

    ; $002818-$002837 DATA
    Obj0CC6:
    {
        dw $CCAF, $CCAD, $4CAD, $CCAD
        dw $CCAC, $C8A7, $48A4, $48A5
        dw $8CAC, $88A2, $C89F, $4899
        dw $CCAC, $88A3, $8897, $C895
    }

    ; ==========================================================================

    ; $002838-$002857 DATA
    Obj0CE6:
    {
        dw $0856, $0861, $0870, $10AC
        dw $0854, $0857, $0870, $50AC
        dw $0871, $0871, $0858, $10AC
        dw $10AD, $90AD, $10AD, $10AF
    }

    ; ==========================================================================

    ; $002858-$002877 DATA
    Obj0D06:
    {
        dw $90AC, $8870, $8861, $8856
        dw $D0AC, $8870, $8857, $0844
        dw $90AC, $8858, $0871, $0871
        dw $90AF, $90AD, $10AD, $90AD
    }

    ; ==========================================================================

    ; $002878-$002897 DATA
    Obj0D26:
    {
        dw $50AD, $D0AD, $50AD, $50AF
        dw $4871, $4871, $4858, $50AC
        dw $4854, $4857, $0870, $10AC
        dw $4856, $0860, $0870, $50AC
    }

    ; ==========================================================================

    ; $002898-$0028B7 DATA
    Obj0D46:
    {
        dw $D0AF, $D0AD, $50AD, $D0AD
        dw $D0AC, $C858, $4871, $4871
        dw $90AC, $8870, $C857, $4844
        dw $D0AC, $8870, $8860, $C856
    }

    ; ==========================================================================

    ; $0028B8-$0028CF DATA
    Obj0D66:
    {
        dw $0861, $0870, $50AE, $50AF
        dw $0860, $4848, $4858, $10AC
        dw $4847, $4857, $0870, $50AC
    }

    ; ==========================================================================

    ; $0028D0-$0028E7 DATA
    Obj0D7E:
    {
        dw $D0AF, $D0AE, $8870, $8861
        dw $90AC, $C858, $C848, $8860
        dw $D0AC, $8870, $C857, $C847
    }

    ; ==========================================================================

    ; $0028E8-$0028FF DATA
    Obj0D96:
    {
        dw $0847, $0857, $0870, $50AC
        dw $0861, $0848, $0858, $10AC
        dw $0860, $0870, $10AE, $10AF
    }

    ; ==========================================================================

    ; $002900-$002917 DATA
    Obj0DAE:
    {
        dw $D0AC, $8870, $8857, $8847
        dw $90AC, $8858, $8848, $8861
        dw $90AF, $90AE, $8870, $8860
    }

    ; ==========================================================================

    ; $002918-$00292F DATA
    Obj0DC6:
    {
        dw $0854, $0844, $8847, $0871
        dw $8848, $8857, $90AE, $8858
        dw $0871, $90AF, $90AD, $10AD
    }

    ; ==========================================================================

    ; $002930-$002947 DATA
    Obj0DDE:
    {
        dw $0847, $0854, $0844, $0857
        dw $0848, $0871, $0871, $0858
        dw $10AE, $90AD, $10AD, $10AF
    }

    ; ==========================================================================

    ; $002948-$00295F DATA
    Obj0DF6:
    {
        dw $D0AF, $D0AD, $50AD, $D0AE
        dw $C858, $4871, $4871, $C848
        dw $C857, $4854, $4844, $C847
    }

    ; ==========================================================================

    ; $002960-$002977 DATA
    Obj0E0E:
    {
        dw $D0AD, $50AD, $50AF, $4871
        dw $4858, $50AE, $4857, $4848
        dw $4871, $4847, $4854, $4844
    }

    ; ==========================================================================

    ; $002978-$002983 DATA
    Obj0E26:
    {
        dw $0D00, $0D10, $0D12, $4D00
        dw $0D11, $0D13
    }

    ; ==========================================================================

    ; $002984-$0029A3 DATA
    Obj0E32:
    {
        dw $0D04, $0D14, $0D24, $0D34
        dw $0D05, $0D15, $0D25, $0D35
        dw $4D05, $4D15, $4D25, $4D35
        dw $4D04, $4D14, $4D24, $4D34
    }

    ; ==========================================================================

    ; $0029A4-$0029A3 DATA
    Obj0E52:
    {
        dw $0922, $0932, $0923, $0933
    }

    ; ==========================================================================

    ; $0029AC-$0029B3 DATA
    Obj0E5A:
    {
        dw $0DE5, $0DF5, $4DE5, $4DF5
    }

    ; ==========================================================================

    ; $0029B4-$0029BB DATA
    Obj0E62:
    {
        dw $0DE3, $0DF3, $0DE4, $0DF4
    }

    ; ==========================================================================

    ; $0029BC-$0029C3 DATA
    Obj0E6A:
    {
        dw $4DE4, $4DF4, $4DE3, $4DF3
    }

    ; ==========================================================================

    ; $0029C4-$0029CB DATA
    Obj0E72:
    {
        dw $8DF3, $8DE3, $8DF4, $8DE4
    }

    ; ==========================================================================

    ; $0029CC-$0029D3 DATA
    Obj0E7A:
    {
        dw $CDF4, $CDE4, $CDF3, $CDE3
    }

    ; ==========================================================================

    ; $0029D4-$0029DB DATA
    Obj0E82:
    {
        dw $0D28, $0D38, $4D28, $4D38
    }

    ; ==========================================================================

    ; $0029DC-$0029E3 DATA
    Obj0E8A:
    {
        dw $0D2A, $0D3A, $0D2B, $0D3B
    }

    ; ==========================================================================

    ; $0029E4-$0029B DATA
    Obj0E92:
    {
        dw $0D01, $0D1C, $4D01, $4D1C
    }

    ; ==========================================================================

    ; $0029EC-$0029F3 DATA
    Obj0E9A:
    {
        dw $0DEE, $8DEE, $4DEE, $CDEE
    }

    ; ==========================================================================

    ; $0029F4-$0029FB DATA
    Obj0EA2:
    {
        dw $0DED, $8DED, $4DED, $CDED
    }

    ; ==========================================================================

    ; $0029FC-$002A03 DATA
    Obj0EAA:
    {
        dw $0CD2, $0CEB, $0CD3, $0CFB
    }

    ; ==========================================================================

    ; $002A04-$002A0B DATA
    Obj0EB2:
    {
        dw $0CEE, $0CFE, $0CEF, $0CFF
    }

    ; ==========================================================================

    ; $002A0C-$002A13 DATA
    Obj0EBA:
    {
        dw $0CD4, $0CD6, $0CD5, $0CD7
    }

    ; ==========================================================================

    ; $002A14-$002A1B DATA
    Obj0EC2:
    {
        dw $0DE0, $0DF0, $4DE0, $4DF0
    }

    ; ==========================================================================

    ; $002A1C-$002A2F DATA
    Obj0ECA:
    {
        dw $0DC0, $0DC1, $4DC0, $4DC1
    }

    ; ==========================================================================

    ; $00AA30-$002A2F DATA
    Obj0ED2:
    {
        dw $094D, $095D, $096D, $494D
        dw $495D, $496D
    }

    ; ==========================================================================

    ; $002A30-$002A47 DATA
    Obj0EDE:
    {
        dw $1587, $1589, $1599, $1588
        dw $158A, $159A, $5588, $558A
        dw $559A, $5587, $5589, $5599
    }

    ; ==========================================================================

    ; $002A48-$002A6F DATA
    Obj0EF6:
    {
        dw $158C, $158D, $558D, $558C
        dw $159C, $159D, $559D, $559C
        dw $159C, $159D, $559D, $559C
        dw $159C, $159D, $559D, $559C
        dw $158B, $159B, $559B, $558B
    }

    ; ==========================================================================

    ; $002A70-$002A8F DATA
    Obj0F1E:
    {
        dw $154A, $155A, $156A, $157A
        dw $154B, $155B, $156B, $157B
        dw $554B, $555B, $556B, $557B
        dw $554A, $555A, $556A, $557A
    }

    ; ==========================================================================

    ; $002A90-$002AAF DATA
    Obj0F3E:
    {
        dw $1525, $1563, $1553, $1555
        dw $1526, $1564, $1554, $1556
        dw $5526, $5564, $5554, $5556
        dw $5525, $5563, $5553, $5555
    }

    ; ==========================================================================

    ; $002AB0-$002ABB DATA
    Obj0F5E:
    {
        dw $151D, $151E, $151F, $551D
        dw $551E, $551F
    }

    ; ==========================================================================

    ; $002ABC-$002AC3 DATA
    Obj0F6A:
    {
        dw $1548, $1549, $5548, $5549
    }

    ; ==========================================================================

    ; $002AC4-$002AE3 DATA
    Obj0F72:
    {
        dw $094A, $095A, $096A, $097A
        dw $094B, $095B, $096B, $097B
        dw $494B, $495B, $496B, $497B
        dw $494A, $495A, $496A, $497A
    }

    ; ==========================================================================

    ; $002AE4-$002AF3 DATA
    Obj0F92:
    {
        dw $0968, $0969, $4969, $4968
        dw $0958, $0959, $4959, $4958
    }

    ; ==========================================================================

    ; $002AF4-$002B03 DATA
    Obj0FA2:
    {
        dw $1588, $156C, $556C, $5588
        dw $157D, $157C, $557C, $557D
    }

    ; ==========================================================================

    ; $002B04-$002B15 DATA
    Obj0FB2:
    {
        dw $11A0, $11A1, $51A0, $11A2
        dw $11A3, $51A2, $1194, $1195
        dw $5194
    }

    ; ==========================================================================

    ; $002B16-$002B45 DATA
    Obj0FC4:
    {
        dw $094E, $095E, $096E, $09AE
        dw $094F, $095F, $096F, $09AF
        dw $094F, $095F, $096F, $09AF
        dw $094F, $095F, $496F, $09AF
        dw $094F, $095F, $096F, $09AF
        dw $494E, $495E, $496E, $49AE
    }

    ; ==========================================================================

    ; $002B46-$002B69 DATA
    Obj0FF4:
    {
        dw $8D84, $0D84, $0976, $8D85
        dw $0D85, $0977, $0D86, $0D96
        dw $0977, $4D86, $4D96, $4977
        dw $CD85, $4D85, $4977, $CD84
        dw $4D84, $4976
    }

    ; ==========================================================================

    ; $002B6A-$002B71 DATA
    Obj1018:
    {
        dw $0978, $0979, $4978, $4979
    }

    ; ==========================================================================

    ; $002B72-$002B79 DATA
    Obj1020:
    {
        dw $0D92, $0DAA, $0D92, $0DAA
    }

    ; ==========================================================================

    ; $002B7A-$002B91 DATA
    Obj1028:
    {
        dw $0942, $0982, $0992, $0943
        dw $0983, $0993, $4943, $4983
        dw $4993, $4942, $4982, $4992
    }

    ; ==========================================================================

    ; $002B92-$002BB1 DATA
    Obj1040:
    {
        dw $0CEE, $18D8, $0CEE, $0CFE
        dw $18C8, $18D9, $58D9, $0CFF
        dw $18C9, $0CFE, $0CEE, $18D9
        dw $0CEF, $58D9, $58D8, $0CFF
    }

    ; ==========================================================================

    ; $002BB2-$002BC1 DATA
    Obj1060:
    {
        dw $1197, $1198, $1197, $1198
        dw $1187, $1188, $1187, $1188
    }

    ; ==========================================================================

    ; $002BC2-$002BC9 DATA
    Obj1070:
    {
        dw $1D76, $1D77, $5D76, $5D77
    }

    ; ==========================================================================

    ; $002BCA-$002BD1 DATA
    Obj1078:
    {
        dw $9D77, $9D76, $DD77, $DD76
    }

    ; ==========================================================================

    ; $002BD2-$002BD9 DATA
    Obj1080:
    {
        dw $5D79, $DD79, $5D78, $DD78
    }

    ; ==========================================================================

    ; $002BDA-$002BF9 DATA
    Obj1088:
    {
        dw $084C, $085D, $086D, $087D
        dw $084F, $085E, $086E, $087E
        dw $484F, $485E, $486E, $487E
        dw $484C, $485D, $486D, $487D
    }

    ; ==========================================================================

    ; $002BFA-$002C19 DATA
    Obj10A8:
    {
        dw $0864, $0866, $0866, $09F8
        dw $085F, $086F, $087F, $09F9
        dw $485F, $486F, $487F, $49F9
        dw $4864, $4866, $4866, $49F8
    }

    ; ==========================================================================

    ; $002C1A-$00AC39 DATA
    Obj10C8:
    {
        dw $084D, $085D, $086D, $087D
        dw $084E, $085E, $086E, $087E
        dw $484E, $485E, $486E, $487E
        dw $484D, $485D, $486D, $487D
    }

    ; ==========================================================================

    ; $00AC3A-$002C59 DATA
    Obj10E8:
    {
        dw $887D, $886D, $885D, $884D
        dw $887E, $886E, $885E, $884E
        dw $C87E, $C86E, $C85E, $C84E
        dw $C87D, $C86D, $C85D, $C84D
    }

    ; ==========================================================================

    ; $002C5A-$002C99 DATA
    Obj1108:
    {
        dw $0982, $0983, $4983, $4982
        dw $0992, $0993, $4993, $4992
        dw $08C9, $08F4, $48F4, $48C9
        dw $08CA, $08F5, $48F5, $48CA
        dw $0841, $0845, $8845, $8841
        dw $0842, $0855, $8845, $8842
        dw $4842, $4855, $C855, $C842
        dw $4841, $4845, $C845, $C841
    }

    ; ==========================================================================

    ; $002C9A-$002CB1 DATA
    Obj1148:
    {
        dw $28B8, $2808, $0818, $289D
        dw $082E, $083E, $689D, $082F
        dw $083F, $68B8, $6808, $4818
    }

    ; ==========================================================================

    ; $002CB2-$002CC9 DATA
    Obj1160:
    {
        dw $28B8, $2808, $0818, $28B9
        dw $09EF, $0819, $68B9, $09EF
        dw $081A, $68B8, $6808, $4818
    }

    ; ==========================================================================

    ; $002CCA-$002CE1 DATA
    Obj1178:
    {
        dw $28B5, $2808, $080D, $28B7
        dw $082E, $083E, $68B7, $082F
        dw $083F, $68B5, $6808, $480D
    }

    ; ==========================================================================

    ; $002CE2-$002CF9 DATA
    Obj1190:
    {
        dw $28B5, $2808, $080D, $28B6
        dw $09EF, $0819, $68B6, $09EF
        dw $081A, $68B5, $6808, $480D
    }

    ; ==========================================================================

    ; $002CFA-$002D19 DATA
    Obj11A8:
    {
        dw $28B8, $0808, $0818, $4CAC
        dw $289D, $0807, $0817, $0CAC
        dw $689D, $4807, $4817, $4CAC
        dw $68B8, $4808, $4818, $0CAC
    }

    ; ==========================================================================

    ; $002D1A-$002D39 DATA
    Obj11C8:
    {
        dw $28B8, $2808, $0818, $4CAC
        dw $28B9, $09EF, $0816, $0CAC
        dw $68B9, $09EF, $4816, $4CAC
        dw $68B8, $6808, $4818, $0CAC
    }

    ; ==========================================================================

    ; $002D3A-$002D59 DATA
    Obj11E8:
    {
        dw $8CAC, $8818, $8808, $A8B8
        dw $CCAC, $8817, $8807, $A89D
        dw $8CAC, $C817, $C807, $E89D
        dw $CCAC, $C818, $C808, $E8B8
    }

    ; ==========================================================================

    ; $002D5A-$002D79 DATA
    Obj1208:
    {
        dw $8CAC, $880D, $8808, $A8B8
        dw $CCAC, $8816, $89EF, $A8B9
        dw $8CAC, $C816, $C9EF, $E8B9
        dw $CCAC, $C80D, $C808, $E8B8
    }

    ; ==========================================================================

    ; $002D7A-$002D99 DATA
    Obj1228:
    {
        dw $28B5, $0808, $080D, $50AC
        dw $28B7, $0807, $0817, $10AC
        dw $68B7, $4807, $4817, $50AC
        dw $68B5, $4808, $480D, $10AC
    }

    ; ==========================================================================

    ; $002D9A-$002DB9 DATA
    Obj1248:
    {
        dw $28B5, $0818, $080D, $50AC
        dw $28B6, $09EF, $0816, $10AC
        dw $68B6, $09EF, $4816, $50AC
        dw $68B7, $4810, $480D, $10AC
    }

    ; ==========================================================================

    ; $002DBA-$002DD9 DATA
    Obj1268:
    {
        dw $90AC, $880D, $8808, $A8B5
        dw $D0AC, $8817, $8807, $A8B7
        dw $90AC, $C817, $C807, $E8B7
        dw $D0AC, $C80D, $C808, $E8B5
    }

    ; ==========================================================================

    ; $002DDA-$002DF9 DATA
    Obj1288:
    {
        dw $90AC, $880D, $8808, $A8B5
        dw $D0AC, $8816, $89EF, $A8B6
        dw $90AC, $C816, $C9EF, $E8B6
        dw $D0AC, $C80D, $C808, $E8B5
    }

    ; ==========================================================================

    ; $002DFA-$002F39 DATA
    Obj12A8:
    {
        dw $0984, $09A7, $0843, $0853
        dw $0984, $09A4, $09A8, $0854
        dw $0984, $0994, $09A4, $09A8
        dw $0985, $0995, $09A5, $09A9
        dw $0986, $0996, $09A6, $099C
        dw $4986, $4996, $49A6, $499C
        dw $4985, $4995, $49A5, $49A9
        dw $4984, $4994, $49A4, $49A8
        dw $4984, $49A4, $49A8, $4854
        dw $4984, $49A7, $4843, $4853

        dw $0984, $09A7, $0843, $0853
        dw $0984, $0994, $09A8, $0854
        dw $0985, $0995, $09A5, $09A8
        dw $0986, $0996, $09A6, $099C
        dw $18CB, $18DB, $18CB, $18DB
        dw $18CA, $18DA, $18CA, $18DA
        dw $4986, $4996, $49A6, $499C
        dw $4985, $4995, $49A5, $49A8
        dw $4984, $4994, $49A8, $4854
        dw $4984, $49A7, $4843, $4853

        dw $0984, $09A7, $0843, $0853
        dw $0985, $0995, $09A8, $0854
        dw $0986, $0996, $09A6, $09A8
        dw $18CA, $18DA, $18CA, $18DA
        dw $18CB, $18DB, $18CB, $18DB
        dw $18CA, $18DA, $18CA, $18DA
        dw $18CB, $18DB, $18CB, $18DB
        dw $4986, $4996, $49A6, $49A8
        dw $4985, $4995, $49A8, $4854
        dw $4984, $49A7, $4843, $4853

        dw $0985, $09A7, $0843, $0853
        dw $0986, $0996, $09A8, $0854
        dw $0871, $0871, $098B, $099B
        dw $18CA, $18DA, $18CA, $18DA
        dw $18CB, $18DB, $18CB, $18DB
        dw $18CA, $18DA, $18CA, $18DA
        dw $18CB, $18DB, $18CB, $18DB
        dw $4871, $4871, $498B, $499B
        dw $4986, $4996, $49A8, $4854
        dw $4985, $49A7, $4843, $4853
    }

    ; ==========================================================================

    ; $002F3A-$002F89 DATA
    Obj13E8:
    {
        dw $0986, $09A7, $0843, $0853
        dw $0871, $098B, $099B, $0854
        dw $0871, $0871, $098B, $099B
        dw $18CA, $18DA, $18CA, $18DA
        dw $18CB, $18DB, $18CB, $18DB
        dw $18CA, $18DA, $18CA, $18DA
        dw $18CB, $18DB, $18CB, $18DB
        dw $4871, $4871, $498B, $499B
        dw $4871, $498B, $499B, $4854
        dw $4986, $49A7, $4843, $4853
    }

    ; ==========================================================================

    ; $002F8A-$002FA9 DATA
    Obj1438:
    {
        dw $18CA, $18CB, $18CA, $18CB
        dw $18DA, $0974, $4974, $18DB
        dw $18CA, $8974, $C974, $18CB
        dw $18DA, $18DB, $18DA, $18DB
    }

    ; ==========================================================================

    ; $002FAA-$002FD9 DATA
    Obj1458:
    {
        dw $1D48, $1D58, $1568, $1542
        dw $1562, $1552, $1D49, $1D59
        dw $1D69, $1D43, $1D63, $1D53
        dw $1D60, $1D70, $1D78, $1D61
        dw $1D71, $1D79, $5D61, $5D71
        dw $5D79, $5D60, $5D70, $5D78
    }

    ; ==========================================================================

    ; $002FDA-$002FE5 DATA
    Obj1488:
    {
        dw $298D, $298E, $299E, $298F
        dw $299F, $299D
    }

    ; ==========================================================================

    ; $002FE6-$002FED DATA
    Obj1494:
    {
        dw $09A2, $09A3, $49A2, $49A3
    }

    ; ==========================================================================

    ; $002FEE-$002FF5 DATA
    Obj149C:
    {
        dw $19E1, $19F1, $59E1, $59F1
    }

    ; ==========================================================================

    ; $002FF6-$002FFD DATA
    Obj14A4:
    {
        dw $19E2, $19F2, $59E2, $59F2
    }

    ; ==========================================================================

    ; $002FFE-$003015 DATA
    Obj14AC:
    {
        dw $1920, $1930, $1926, $1921
        dw $1931, $1927, $5921, $5931
        dw $5927, $5920, $5930, $5926
    }

    ; ==========================================================================

    ; $003016-$00302D DATA
    Obj14C4:
    {
        dw $1906, $1916, $1926, $1907
        dw $1917, $1927, $5907, $5917
        dw $5927, $5906, $5916, $5926
    }

    ; ==========================================================================

    ; $00302E-$003051 DATA
    Obj14DC:
    {
        dw $2980, $0990, $09A0, $2981
        dw $0991, $09A1, $2981, $0991
        dw $09A1, $6981, $4991, $49A1
        dw $6981, $4991, $49A1, $6980
        dw $4990, $49A1
    }
    
    ; ==========================================================================

    ; $003052-$003075 DATA
    Obj1500:
    {
        dw $89A0, $8990, $A980, $89A1
        dw $8991, $A981, $89A1, $8991
        dw $A981, $C9A1, $C991, $E981
        dw $C9A1, $C991, $E981, $C9A0
        dw $C990, $E980
    }

    ; ==========================================================================

    ; $003076-$003099 DATA
    Obj1524:
    {
        dw $2982, $0983, $09A2, $2992
        dw $0993, $09A3, $2992, $0993
        dw $09A3, $A992, $8993, $89A3
        dw $A992, $8993, $89A3, $A982
        dw $8983, $89A2
    }

    ; ==========================================================================

    ; $00309A-$0030BD DATA
    Obj1548:
    {
        dw $49A2, $4983, $6982, $49A3
        dw $4993, $6992, $49A3, $4993
        dw $6992, $C9A3, $C993, $E992
        dw $C9A3, $C993, $E992, $C9A2
        dw $C983, $E982
    }

    ; ==========================================================================

    ; $0030BE-$0030E1 DATA
    Obj156C:
    {
        dw $2984, $0990, $09A0, $2994
        dw $0991, $09A1, $2994, $0991
        dw $09A1, $6994, $4991, $49A1
        dw $6994, $4991, $49A1, $6984
        dw $4990, $49A0
    }

    ; ==========================================================================

    ; $0030E2-$003105 DATA
    Obj1590:
    {
        dw $89A0, $8990, $A984, $89A1
        dw $8991, $A994, $89A1, $8991
        dw $A994, $C9A1, $C991, $E994
        dw $C9A1, $C991, $E994, $C9A0
        dw $C990, $E984
    }

    ; ==========================================================================

    ; $003106-$003129 DATA
    Obj15B4:
    {
        dw $288A, $288B, $288B, $0809
        dw $09EF, $09EF, $080A, $0879
        dw $0879, $288A, $A88B, $A88B
        dw $09EF, $89EF, $8809, $0879
        dw $8879, $880A
    }

    ; ==========================================================================

    ; $00312A-$00314D DATA
    Obj15D8:
    {
        dw $480A, $4879, $4879, $4809
        dw $49EF, $49EF, $688A, $688B
        dw $688B, $4879, $C879, $C80A
        dw $49EF, $C9EF, $C809, $688B
        dw $E88B, $E88A
    }

    ; ==========================================================================

    ; $00314E-$003165 DATA
    Obj15FC:
    {
        dw $880D, $8808, $A82C, $8878
        dw $09EF, $A82D, $C878, $09EF
        dw $E82D, $C80D, $C808, $E82C
    }

    ; ==========================================================================

    ; $003166-$00B17D DATA
    Obj1614:
    {
        dw $0980, $0981, $4981, $4980
        dw $0990, $0991, $4991, $4990
        dw $09A0, $09A1, $49A1, $49A0
    }

    ; ==========================================================================

    ; $00B17E-$0031A5 DATA
    Obj162C:
    {
        dw $0980, $0981, $4981, $4980
        dw $0990, $0991, $4991, $4990
        dw $09A0, $1DB2, $1DB2, $49A0
        dw $1DB3, $1DB3, $1DB3, $1DB3
        dw $1DB5, $1DB5, $1DB5, $1DB5
    }

    ; ==========================================================================

    ; $0031A6-$0031DD DATA
    Obj1654:
    {
        dw $2980, $2981, $6981, $6980
        dw $2990, $2991, $6991, $6990

        dw $29A0, $3DB2, $3DB2, $69A0
        dw $3DB3, $3DB3, $3DB3, $3DB3
        dw $3DB3, $3DB3, $3DB3, $3DB3
        dw $1DB3, $1DB3, $1DB3, $1DB3
        dw $1DB5, $1DB5, $1DB5, $1DB5
    }

    ; ==========================================================================

    ; $0031DE-$003205 DATA
    Obj168C:
    {
        dw $09A0, $1DB2, $5DB2, $49A0
        dw $1DB3, $1DB3, $1DB3, $1DB3
        dw $1DB3, $1DB3, $1DB3, $1DB3
        dw $1DB5, $1DB5, $1DB5, $1DB5
        dw $18CA, $18CB, $18CA, $18CB
    }

    ; ==========================================================================

    ; $003206-$00322D DATA
    Obj16B4:
    {
        dw $09A0, $1DB2, $5DB2, $49A0
        dw $1DB3, $1DB3, $1DB3, $1DB3
        dw $1DB5, $1DB5, $1DB5, $1DB5
        dw $0870, $0870, $0870, $0870
        dw $18CA, $18CB, $18CA, $18CB
    }

    ; ==========================================================================

    ; $00322E-$003347 DATA
    Obj16DC:
    {
        dw $01EC, $853E, $853F, $853D
        dw $853D, $853D, $C53D, $C53D
        dw $C53D, $C53F, $C53E, $01EC
        dw $052A, $853D, $853D, $853D
        dw $853D, $853D, $C53D, $C53D
        dw $C53D, $C53D, $C53D, $452A
        dw $05E8, $853D, $853D, $852E
        dw $852F, $852D, $C52D, $C52F
        dw $C52E, $C53D, $C53D, $45E8
        dw $05E7, $853D, $052B, $852D
        dw $852D, $852D, $C52D, $C52D
        dw $C52D, $452B, $C53D, $45E7
        dw $05E7, $853D, $053B, $852D
        dw $852D, $852D, $C52D, $C52D
        dw $C52D, $453B, $C53D, $45E7
        dw $85E8, $853D, $853B, $852D
        dw $852D, $852D, $C52D, $C52D
        dw $C52D, $C53B, $C53D, $C5E8
        dw $852A, $853D, $852B, $852D
        dw $852D, $852D, $C52D, $C52D
        dw $C52D, $C52B, $C53D, $C52A
        dw $01EC, $853A, $853D, $853B
        dw $852D, $852D, $C52D, $C52D
        dw $C53B, $C53D, $C53A, $01EC
        dw $01EC, $852A, $853D, $852B
        dw $852D, $852D, $C52D, $C52D
        dw $C52B, $C53D, $C52A, $01EC
        dw $01EC, $01EC, $853A, $853D
        dw $052E, $052F, $452F, $452E
        dw $C53D, $C53A, $01EC, $01EC
        dw $01EC, $01EC, $852A, $853D
        dw $853D, $853D, $C53D, $C53D
        dw $C53D, $C52A, $01EC, $01EC
        dw $01EC, $01EC, $01EC, $053E
        dw $053F, $853D, $C53D, $453F
        dw $453E
    }

    ; ==========================================================================

    ; $003348-$003465 DATA
    Obj17F6:
    {
        dw $01EC, $01EC, $01EC, $853E
        dw $853F, $053D, $453D, $C53F
        dw $C53E, $01EC, $01EC, $01EC
        dw $01EC, $01EC, $052A, $053D
        dw $053D, $053D, $453D, $453D
        dw $453D, $452A, $01EC, $01EC
        dw $01EC, $01EC, $053A, $053D
        dw $852E, $852F, $C52F, $C52E
        dw $453D, $453A, $01EC, $01EC
        dw $01EC, $052A, $053D, $052B
        dw $052D, $052D, $452D, $452D
        dw $452B, $453D, $452A, $01EC
        dw $01EC, $053A, $053D, $053B
        dw $052D, $052D, $452D, $452D
        dw $453B, $453D, $453A, $01EC
        dw $052A, $053D, $052B, $052D
        dw $052D, $052D, $452D, $452D
        dw $452D, $452B, $453D, $452A
        dw $05E8, $053D, $053B, $052D
        dw $052D, $052D, $452D, $452D
        dw $452D, $453B, $453D, $45E8
        dw $05E7, $053D, $853B, $052D
        dw $052D, $052D, $452D, $452D
        dw $452D, $C53B, $453D, $45E7
        dw $05E7, $053D, $852B, $052D
        dw $052D, $052D, $452D, $452D
        dw $452D, $C52B, $453D, $45E7
        dw $85E8, $053D, $053D, $052E
        dw $052F, $052D, $452D, $452F
        dw $452E, $453D, $453D, $C5E8
        dw $852A, $053D, $053D, $053D
        dw $053D, $053D, $453D, $453D
        dw $453D, $453D, $453D, $C52A
        dw $01EC, $053E, $053F, $053D
        dw $053D, $053D, $453D, $453D
        dw $453D, $453F, $453E
    }

    ; ==========================================================================

    ; $003466-$00357B DATA
    Obj1914:
    {
        dw $01EC, $853E, $853F, $053D
        dw $053D, $C53F, $C53E, $01EC
        dw $01EC, $01EC, $01EC, $01EC
        dw $052A, $053D, $053D, $053D
        dw $053D, $053D, $053D, $C53F
        dw $C53E, $01EC, $01EC, $01EC
        dw $053A, $053D, $053D, $852E
        dw $852F, $C52F, $C52E, $053D
        dw $053D, $C53F, $C53E, $01EC
        dw $053D, $053D, $052B, $052D
        dw $052D, $052D, $852D, $C52F
        dw $C52E, $053D, $053D, $452A
        dw $053D, $053D, $053B, $052D
        dw $052D, $052D, $052D, $052D
        dw $052D, $452B, $053D, $453A
        dw $053D, $053D, $052D, $052D
        dw $052D, $052D, $052D, $052D
        dw $052D, $453B, $053D, $053D
        dw $853D, $853D, $852D, $852D
        dw $852D, $852D, $852D, $852D
        dw $852D, $C53B, $853D, $853D
        dw $853D, $853D, $853B, $852D
        dw $852D, $852D, $852D, $852D
        dw $852D, $C52B, $853D, $C53A
        dw $853D, $853D, $852B, $852D
        dw $852D, $852D, $852D, $452F
        dw $452E, $853D, $853D, $C52A
        dw $853A, $853D, $853D, $052E
        dw $052F, $452F, $452E, $853D
        dw $853D, $453F, $453E, $01EC
        dw $852A, $853D, $853D, $853D
        dw $853D, $853D, $853D, $453F
        dw $453E, $01EC, $01EC, $01EC
        dw $01EC, $053E, $053F, $853D
        dw $853D, $453F, $453E
    }

    ; ==========================================================================

    ; $00357C-$00369B DATA
    Obj1A2A:
    {
        dw $01EC, $01EC, $01EC, $01EC
        dw $01EC, $853E, $853F, $453D
        dw $453D, $C53F, $C53E, $01EC
        dw $01EC, $01EC, $01EC, $853E
        dw $853F, $453D, $453D, $453D
        dw $453D, $453D, $453D, $452A
        dw $01EC, $853E, $853F, $453D
        dw $453D, $852E, $852F, $C52F
        dw $C52E, $453D, $453D, $453A
        dw $052A, $453D, $453D, $852E
        dw $852F, $452D, $452D, $452D
        dw $452D, $452B, $453D, $453D
        dw $053A, $453D, $052B, $452D
        dw $452D, $452D, $452D, $452D
        dw $452D, $453B, $453D, $453D
        dw $453D, $453D, $053B, $452D
        dw $452D, $452D, $452D, $452D
        dw $452D, $452D, $453D, $453D
        dw $C53D, $C53D, $853B, $C52D
        dw $C52D, $C52D, $C52D, $C52D
        dw $C52D, $C52D, $C53D, $C53D
        dw $853A, $C53D, $852B, $C52D
        dw $C52D, $C52D, $C52D, $C52D
        dw $C52D, $C53B, $C53D, $C53D
        dw $852A, $C53D, $C53D, $052E
        dw $052F, $C52D, $C52D, $C52D
        dw $C52D, $C52B, $C53D, $C53D
        dw $01EC, $053E, $053F, $C53D
        dw $C53D, $052E, $052F, $452F
        dw $452E, $C53D, $C53D, $C53A
        dw $01EC, $01EC, $01EC, $053E
        dw $053F, $C53D, $C53D, $C53D
        dw $C53D, $C53D, $C53D, $C52A
        dw $01EC, $01EC, $01EC, $01EC
        dw $01EC, $053E, $053F, $C53D
        dw $C53D, $453F, $453E, $01EC
    }

    ; ==========================================================================

    ; $00369C-$003743 DATA
    Obj1B4A:
    {
        dw $099D, $098E, $098E, $098E
        dw $098E, $098E, $098E, $098E
        dw $098E, $098E, $098E, $098E
        dw $098E, $099E, $099F, $18C6
        dw $18C6, $18C6, $18C6, $18C6
        dw $18C6, $18C6, $18C6, $18C6
        dw $18C6, $18C6, $18C6, $099F
        dw $099F, $18C6, $18C6, $18C6
        dw $18C6, $118A, $119A, $118B
        dw $119B, $11A0, $18C6, $18C6
        dw $18C6, $099F, $099F, $18C6
        dw $18C6, $18C6, $18C6, $1183
        dw $1193, $1182, $1192, $11A1
        dw $18C6, $18C6, $498F, $499E
        dw $099F, $18C6, $18D4, $98D4
        dw $18C6, $1189, $1187, $1197
        dw $118C, $11A2, $18C6, $18C6
        dw $0972, $0972, $099F, $18D6
        dw $18D5, $98D5, $98D6, $119C
        dw $1188, $1198, $118D, $11A3
        dw $18C6, $18C6, $0972, $0972
    }

    ; ==========================================================================

    ; $003744-$003773 DATA
    Obj1BF2:
    {
        dw $0995, $1D99, $0994, $0CAC
        dw $0995, $1D99, $0994, $0CAC
        dw $0980, $0990, $0986, $09A6
        dw $4980, $4990, $4986, $49A6
        dw $0995, $1D99, $0994, $0CAC
        dw $0995, $1D99, $0994, $0CAC
    }

    ; $003774-$00377D DATA
    Obj1C22:
    {
        dw $1DA7, $1DA8, $1DA4, $08F5
        dw $0CD8
    }

    ; $00377E-$0037AD DATA
    Obj1C2C:
    {
        dw $0981, $0991, $0985, $09A5
        dw $8981, $8991, $8985, $89A5
        dw $0996, $1D99, $0984, $0CAD
        dw $0996, $1D99, $0984, $0CAD
        dw $0996, $1D99, $0984, $0CAD
        dw $0996, $1D99, $0984, $0CAD
    }

    ; $0037AE-$0037C5 DATA
    Obj1C5C:
    {
        dw $98D9, $D8C7, $98C7, $D8C7
        dw $98C8, $14DB, $14CA, $58C8
        dw $18C7, $58C7, $18C7, $58D9
    }

    ; $0037C6-$0037DD DATA
    Obj1C74:
    {
        dw $58D9, $14CA, $D8C7, $98C8
        dw $58C7, $18C7, $D8C7, $98C7
        dw $58C8, $18C7, $14DB, $98D9
    }

    ; $0037DE-$00380F DATA
    Obj1C8C:
    {
        dw $0CD8, $14CB, $D8C8, $58C8
        dw $14DB, $14DA, $18D9, $98C7
        dw $18C7, $98D9, $D8C8, $58C7
        dw $D8C7, $58C7, $D8D9, $98C8
        dw $18C7, $98C7, $18C8, $14DA
        dw $14DB, $58D9, $D8D9, $14CB
        dw $14DB
    }

    ; ==========================================================================

    ; $003810-$00383F DATA
    Obj1CBE:
    {
        dw $95A6, $958D, $B597, $95A7
        dw $959C, $B598, $D5A7, $D59C
        dw $F598, $D5A6, $D58D, $F597
        dw $B587, $B595, $95A0, $B588
        dw $B596, $9586, $F588, $F596
        dw $D586, $F587, $F595, $D5A0
    }

    ; ==========================================================================

    ; $003840-$00386F DATA
    Obj1CEE:
    {
        dw $15A0, $3595, $3587, $3586
        dw $3596, $3588, $7586, $7596
        dw $7588, $55A0, $7595, $7587
        dw $3597, $158D, $15A6, $3598
        dw $159C, $15A7, $7598, $559C
        dw $55A7, $7597, $558D, $55A6
    }

    ; ==========================================================================

    ; $003870-$00389F DATA
    Obj1D1E:
    {
        dw $55A4, $55A5, $D5A5, $D5A4
        dw $558C, $559C, $D59C, $D58C
        dw $758B, $759B, $F59B, $F58B
        dw $758A, $759A, $F59A, $F58A
        dw $7589, $7599, $F599, $F589
        dw $55A1, $7585, $F585, $D5A1
    }

    ; ==========================================================================

    ; $0038A0-$0038CF DATA
    Obj1D4E:
    {
        dw $15A1, $3585, $B585, $95A1
        dw $3589, $3599, $B599, $B589
        dw $358A, $359A, $B59A, $B58A
        dw $358B, $359B, $B59B, $B58B
        dw $158C, $159C, $959C, $958C
        dw $15A4, $15A5, $95A5, $95A4
    }

    ; ==========================================================================

    ; $0038D0-$0038D7 DATA
    Obj1D7E:
    {
        dw $1590, $1590, $5590, $5590
    }

    ; ==========================================================================

    ; $0038D8-$0038DF DATA
    Obj1D86:
    {
        dw $1580, $9580, $1580, $9580
    }

    ; ==========================================================================

    ; $0038E0-$0038E7 DATA
    Obj1D8E:
    {
        dw $1581, $1590, $1580, $1591
    }

    ; ==========================================================================

    ; $0038E8-$0038EF DATA
    Obj1D96:
    {
        dw $1590, $1592, $1582, $9580
    }

    ; ==========================================================================

    ; $0038F0-$0038F7 DATA
    Obj1D9E:
    {
        dw $1580, $1593, $1583, $5590
    }

    ; ==========================================================================

    ; $0038F8-$0038FF DATA
    Obj1DA6:
    {
        dw $1584, $9580, $5590, $1594
    }

    ; ==========================================================================

    ; $003900-$003907 DATA
    Obj1DAE:
    {
        dw $15A3, $1590, $55A3, $5590
    }

    ; ==========================================================================

    ; $003908-$00390F DATA
    Obj1DB6:
    {
        dw $1590, $95A3, $5590, $D5A3
    }

    ; ==========================================================================

    ; $003910-$00B917 DATA
    Obj1DBE:
    {
        dw $95A2, $15A2, $1580, $9580
    }

    ; ==========================================================================

    ; $00B918-$00391F DATA
    Obj1DC6:
    {
        dw $1580, $9580, $D5A2, $55A2
    }

    ; ==========================================================================

    ; $003920-$003927 DATA
    Obj1DCE:
    {
        dw $159D, $959D, $559D, $D59D
    }

    ; ==========================================================================

    ; $003928-$00392B DATA
    Obj1DD6:
    {
        dw $19C4, $19C5
    }

    ; ==========================================================================

    ; $00392C-$003933 DATA
    Obj1DDA:
    {
        dw $0980, $0990, $0981, $0991
    }

    ; ==========================================================================

    ; $003934-$00393B DATA
    Obj1DE2:
    {
        dw $8990, $8980, $8991, $8981
    }

    ; ==========================================================================

    ; $00393C-$003943 DATA
    Obj1DEA:
    {
        dw $0D29, $0D39, $4D29, $4D39
    }

    ; ==========================================================================

    ; $003944-$00394B DATA
    Obj1DF2:
    {
        dw $19CD, $19CE, $59CD, $59CE
    }

    ; ==========================================================================

    ; $00394C-$0039EB DATA
    Obj1DFA:
    {
        dw $01EC, $1585, $1586, $1587
        dw $1588, $1589, $1578, $5586
        dw $5585, $01EC, $1594, $1595
        dw $1596, $1597, $1598, $1599
        dw $1579, $5596, $5595, $5594
        dw $158A, $158B, $158C, $158D
        dw $158E, $158F, $1572, $558C
        dw $558B, $558A, $159A, $159B
        dw $159C, $159D, $159E, $159F
        dw $559D, $559C, $559B, $559A
        dw $15AA, $15AB, $15AC, $15AD
        dw $15AE, $15AF, $55AD, $55AC
        dw $55AB, $55AA, $15A0, $15A1
        dw $15A2, $15A3, $15A4, $15A5
        dw $55A3, $55A2, $55A1, $55A0
        dw $15A7, $15A8, $154E, $156E
        dw $1576, $1577, $556E, $554E
        dw $55A8, $55A7, $01EC, $15A9
        dw $155E, $157E, $1574, $1575

        dw $557E, $555E, $55A9, $01EC
    }

    ; ==========================================================================

    ; $0039EC-$003A8B DATA
    Obj1E9A:
    {
        dw $01EC, $31AA, $3161, $3162
        dw $3163, $7163, $7162, $7161
        dw $71AA, $01EC, $01EC, $3170
        dw $3171, $3172, $317E, $717E
        dw $7172, $7171, $7170, $01EC
        dw $3144, $3145, $3146, $3147
        dw $3148, $7148, $7147, $7146
        dw $7145, $7144, $3154, $3155
        dw $3156, $3157, $3158, $7158
        dw $7157, $7156, $7155, $7154
        dw $3164, $3165, $3166, $3167
        dw $3168, $7168, $7167, $7166
        dw $7165, $7164, $3174, $3175
        dw $3176, $3177, $3178, $7178
        dw $7177, $7176, $7175, $7174
        dw $3149, $3159, $3169, $3179
        dw $31AF, $71AF, $7179, $7169
        dw $7159, $7149, $31AA, $31AB
        dw $31AC, $31AD, $31AE, $71AE
        dw $71AD, $71AC, $71AB, $71AA
    }

    ; ==========================================================================

    ; $003A8C-$003A93 DATA
    Obj1F3A:
    {
        dw $0DCF, $8DCF, $4DCF, $CDCF
    }

    ; ==========================================================================

    ; $003A94-$003A9B DATA
    Obj1F42:
    {
        dw $0D1F, $8D1F, $4D1F, $CD1F
    }

    ; ==========================================================================

    ; $003A9C-$003AA3 DATA
    Obj1F4A:
    {
        dw $0D01, $8D01, $4D01, $CD01
    }

    ; ==========================================================================

    ; $003AA4-$003AAB DATA
    Obj1F52:
    {
        dw $19D0, $19D2, $19D1, $19D3
    }

    ; ==========================================================================

    ; $003AAC-$003AB3 DATA
    Obj1F5A:
    {
        dw $0DD4, $0DD6, $0DD5, $0DD7
    }

    ; ==========================================================================

    ; $003AB4-$003AE3 DATA
    Obj1F62:
    {
        dw $0993, $0D82, $0D84, $0890
        dw $0D83, $0D85, $0890, $0D92
        dw $0D86, $0890, $4D92, $4D86
        dw $0890, $0D92, $0D86, $0890
        dw $4D92, $4D86, $0890, $4D83
        dw $4D85, $4993, $4D82, $4D84
    }

    ; ==========================================================================

    ; $003AE4-$003B43 DATA
    Obj1F92:
    {
        dw $094A, $094B, $094B, $494B
        dw $494B, $494A, $094E, $0978
        dw $0979, $4979, $4978, $494E
        dw $094E, $094F, $1DB3, $5DB3
        dw $494F, $494E, $094E, $094F
        dw $1DB4, $5DB4, $494F, $494E
        dw $094E, $094F, $1DB4, $5DB4
        dw $494F, $494E, $094E, $094F
        dw $9DB3, $DDB3, $494F, $494E
        dw $096A, $095E, $095F, $495F
        dw $495E, $496A, $097A, $096E
        dw $096F, $496F, $496E, $497A
    }

    ; ==========================================================================

    ; $003B44-$003B67 DATA
    Obj1FF2:
    {
        dw $11A0, $11A2, $1194, $11A1
        dw $11A3, $1195, $51A1, $51A3
        dw $5195, $11A1, $11A3, $1195
        dw $51A1, $51A3, $5195, $51A0
        dw $51A2, $5194
    }

    ; ==========================================================================

    ; $003B68-$003B7F DATA
    Obj2016:
    {
        dw $0DAA, $0DAC, $0DAE, $0DAB
        dw $0DAD, $0DAF, $4DAB, $4DAD
        dw $4DAF, $4DAA, $4DAC, $4DAE
    }

    ; ==========================================================================

    ; $003B80-$003BB3 DATA
    Obj202E:
    {
        dw $0D51, $0D66, $1D64, $1D44
        dw $1D54, $1D64, $1D54, $09EF
        dw $0D55, $0D65, $156B, $157B
        dw $158B, $1D40, $19B2, $157C
        dw $158C, $1D41, $156C, $157D
        dw $158C, $5D41, $14E4, $14E5
        dw $158D, $1D41
    }

    ; ==========================================================================

    ; $003BB4-$003BD7 DATA
    Obj2062:
    {
        dw $1540, $1550, $1576, $1541
        dw $1551, $1577, $5541, $5551
        dw $5577, $1541, $1551, $1577
        dw $5541, $5551, $5577, $5540
        dw $5550, $5576
    }

    ; ==========================================================================

    ; $003BD8-$003C47 DATA
    Obj2086:
    {
        dw $1180, $1190, $1190, $1190
        dw $1191, $1186, $1196, $1181
        dw $5190, $5190, $5190, $5191
        dw $5186, $5196, $1182, $1192
        dw $1184, $1194, $11A4, $11A4
        dw $11A4, $1183, $1193, $1185
        dw $1195, $11A4, $11A4, $11A4
        dw $5183, $5193, $5185, $5195
        dw $51A4, $51A4, $51A4, $5182
        dw $5192, $5184, $5194, $51A4
        dw $51A4, $51A4, $5181, $1190
        dw $1190, $1190, $1191, $1186
        dw $1196, $5180, $5190, $5190
        dw $5190, $5191, $5186, $5196
    }

    ; ==========================================================================

    ; $003C48-$003E2B DATA
    Obj20F6:
    {
        dw $1593, $1580, $1580, $1580
        dw $1580, $1580, $1580, $1580
        dw $1580, $1580, $15A1, $1580
        dw $1580, $1580, $1580, $1580
        dw $1580, $1580, $1580, $1580
        dw $1582, $15A3, $1580, $5583
        dw $5593, $1580, $1580, $1580
        dw $1582, $1592, $1580, $1583
        dw $1596, $1580, $55A1, $D5A1
        dw $1580, $1580, $1580, $1583
        dw $1593, $1580, $1580, $55A1
        dw $1580, $5582, $5592, $1580
        dw $1580, $1580, $1580, $1580
        dw $1580, $1580, $55A0, $1580
        dw $1580, $1580, $15B4, $15B3
        dw $95B3, $95B4, $1580, $1580
        dw $1580, $5591, $1580, $1580
        dw $15B6, $15B5, $1581, $1581
        dw $95B5, $95B6, $1580, $1580
        dw $5590, $95A0, $15B7, $15B5
        dw $1581, $1581, $1581, $1581
        dw $95B5, $95B7, $1580, $55A1
        dw $95A1, $15B8, $1581, $1595
        dw $15A5, $95A5, $9595, $9581
        dw $95B8, $1580, $55A0, $D5A1
        dw $15B9, $1585, $15A4, $15A4
        dw $15A4, $15A4, $9585, $95B9
        dw $1580, $5591, $D5A0, $15B2
        dw $1586, $15A4, $15A4, $15A4
        dw $15A4, $9586, $95B2, $1580
        dw $5590, $1580, $55B2, $5586
        dw $15A4, $15A4, $15A4, $15A4
        dw $D586, $D5B2, $1580, $1590
        dw $1580, $55B9, $5585, $15A4
        dw $15A4, $15A4, $15A4, $D585
        dw $D5B9, $1580, $1591, $1580
        dw $55B8, $5581, $5595, $55A5
        dw $D5A5, $D595, $D581, $D5B8
        dw $1580, $15A0, $1580, $55B7
        dw $55B5, $5581, $5581, $5581
        dw $5581, $D5B5, $D5B7, $1582
        dw $1596, $1580, $1580, $55B6
        dw $55B5, $5581, $5581, $D5B5
        dw $D5B6, $1580, $1583, $1596
        dw $95A0, $1580, $1580, $55B4
        dw $55B3, $D5B3, $D5B4, $1580
        dw $1580, $1580, $1590, $95A1
        dw $1580, $1580, $1580, $1580
        dw $1580, $1580, $1580, $1580
        dw $1580, $1591, $9590, $1580
        dw $5583, $5593, $1580, $1582
        dw $1592, $1580, $1580, $1580
        dw $15A0, $9591, $1580, $55A1
        dw $D5A1, $1580, $1583, $1593
        dw $1580, $1580, $1580, $15A1
        dw $95A0, $1580, $5582, $5592
        dw $1580, $1580, $1580, $1580
        dw $1580, $1580, $1590, $95A1
        dw $1580, $1580, $1580, $1580
        dw $1580, $1580, $1580, $1580
        dw $1580, $1591
    }

    ; ==========================================================================

    ; $003E2C-$003E37 DATA
    Obj22DA:
    {
        dw $0CEE, $D594, $1584, $15A3
        dw $5594, $1594
    }

    ; ==========================================================================

    ; $003E38-$003E3F DATA
    Obj22E6:
    {
        dw $0D09, $0D19, $4D09, $4D19
    }

    ; ==========================================================================

    ; $003E40-$003E47 DATA
    Obj22EE:
    {
        dw $0D0A, $0D1A, $4D0A, $4D1A
    }

    ; ==========================================================================

    ; $-$003E67 DATA
    Obj22F6:
    {
        dw $0D4A, $0D5A, $0D6A, $0D7A
        dw $0D4B, $0D5B, $0D6B, $0D7B
        dw $4D4B, $4D5B, $4D6B, $4D7B
        dw $4D4A, $4D5A, $4D6A, $4D7A
    }

    ; ==========================================================================

    ; $003E68-$003E7F DATA
    Obj2316:
    {
        dw $0966, $0956, $1D48, $0967
        dw $0957, $1DBE, $4967, $4957
        dw $5DBE, $4966, $4956, $5D48
    }

    ; ==========================================================================

    ; $003E80-$003E97 DATA
    Obj232E:
    {
        dw $9D48, $8956, $8966, $9DBE
        dw $8957, $8967, $DDBE, $C957
        dw $C967, $DD48, $C956, $C966
    }

    ; ==========================================================================

    ; $003E98-$003EAF DATA
    Obj2346:
    {
        dw $0968, $0969, $8969, $8968
        dw $0958, $0959, $8959, $8958
        dw $1D49, $1DBF, $9DBF, $9D49
    }

    ; ==========================================================================

    ; $003EB0-$003EC7 DATA
    Obj235E:
    {
        dw $5D49, $5DBF, $DDBF, $DD49
        dw $4958, $4959, $C959, $C958
        dw $4968, $4969, $C969, $C968
    }

    ; ==========================================================================

    ; $003EC8-$003EE7 DATA
    Obj2376:
    {
        dw $113D, $113D, $113D, $113D
        dw $113D, $113D, $113D, $113D
        dw $113D, $113D, $113D, $113D
        dw $113D, $113D, $113D, $113D
    }

    ; $003EE8-$003F07 DATA
    Obj2396:
    {
        dw $1164, $1164, $1164, $1174
        dw $1165, $1165, $1165, $1175
        dw $5165, $5165, $5165, $5175
        dw $5164, $5164, $5164, $5174
    }

    ; ==========================================================================

    ; $003F08-$003F87 DATA
    Obj23B6:
    {
        dw $1144, $1154, $1154, $1154
        dw $1176, $112D, $112D, $112D
        dw $1145, $1155, $1155, $1155
        dw $1176, $112D, $112D, $112D
        dw $5176, $512D, $512D, $512D
        dw $5145, $5155, $5155, $5155
        dw $5176, $512D, $512D, $512D
        dw $5144, $5154, $5154, $5154
        dw $1154, $1154, $1154, $9144
        dw $112D, $112D, $112D, $9176
        dw $1155, $1155, $1155, $9145
        dw $112D, $112D, $112D, $9176
        dw $512D, $512D, $512D, $D176
        dw $5155, $5155, $5155, $D145
        dw $512D, $512D, $512D, $D176
        dw $5154, $5154, $5154, $D144
    }

    ; ==========================================================================

    ; $003F88-$004007 DATA
    Obj2436:
    {
        dw $09E5, $09F5, $0936, $09FA
        dw $49E5, $09F7, $0937, $09FB
        dw $0000, $0000, $0000, $0CAC
        dw $0000, $0000, $0000, $4CAC
        dw $0000, $0000, $0000, $0CAC
        dw $0000, $0000, $0000, $4CAC
        dw $09E5, $49F7, $4937, $49FB
        dw $49E5, $49F5, $4936, $49FA
        dw $1414, $9414, $1414, $9414
        dw $5414, $D414, $5414, $D414
        dw $1414, $14E9, $14F9, $9414
        dw $5414, $14EA, $14FA, $D414
        dw $1414, $54EA, $54FA, $9414
        dw $5414, $54E9, $54F9, $D414
        dw $1414, $9414, $1414, $9414
        dw $5414, $D414, $5414, $D414
    }

    ; ==========================================================================

    ; $004008-$004037 DATA
    Obj24B6:
    {
        dw $2984, $09AC, $0994, $2985
        dw $15AD, $1595, $2986, $15AE
        dw $1596, $2987, $09AF, $0997
        dw $6987, $49AF, $4997, $6986
        dw $55AE, $5596, $6985, $55AD
        dw $5595, $6984, $49AC, $4994
    }

    ; ==========================================================================

    ; $004038-$004067 DATA
    Obj24E6:
    {
        dw $0980, $0990, $09A0, $0981
        dw $0991, $09A1, $0982, $0992
        dw $11A2, $1183, $1193, $11A3
        dw $5183, $5193, $51A3, $4982
        dw $4992, $51A2, $4981, $4991
        dw $49A1, $4980, $4990, $49A0
    }

    ; ==========================================================================

    ; $004068-$0040A7 DATA
    Obj2516:
    {
        dw $490C, $C90C, $099A, $09AA
        dw $090C, $098B, $099B, $09AB
        dw $490C, $498B, $499B, $49AB
        dw $090C, $890C, $499A, $49AA
        dw $490C, $09A8, $09A6, $C90C
        dw $098A, $09A9, $09A7, $890C
        dw $498A, $49A9, $49A7, $C90C
        dw $090C, $49A8, $49A6, $890C
    }

    ; ==========================================================================

    ; $0040A8-$0040E7 DATA
    Obj2556:
    {
        dw $09AC, $0994, $1D8C, $01EC
        dw $15AD, $1595, $1D9C, $01EC
        dw $15AE, $1596, $1D9C, $01EC
        dw $09AF, $0997, $1D9C, $01EC
        dw $49AF, $4997, $1D9C, $01EC
        dw $55AE, $5596, $1D9C, $01EC
        dw $55AD, $5595, $1D9C, $01EC
        dw $49AC, $4994, $5D8C, $01EC
    }

    ; $0040E8-$004127 DATA
    Obj2596:
    {
        dw $09AC, $0994, $1D8C, $1D8C
        dw $15AD, $1595, $1D9C, $1D9C
        dw $15AE, $1596, $1D9C, $1D9C
        dw $1D88, $1D98, $1D9C, $1D9C
        dw $1D88, $1D98, $1D9C, $1D9C
        dw $55AE, $5596, $1D9C, $1D9C
        dw $55AD, $5595, $1D9C, $1D9C
        dw $49AC, $4994, $5D8C, $5D8C
    }

    ; $004128-$004167 DATA
    Obj25D6:
    {
        dw $09AC, $0994, $1D8C, $1D8C
        dw $15AD, $1595, $1D9C, $1D9C
        dw $1D88, $1D98, $1D9C, $1D9C
        dw $1D88, $1D98, $1D89, $1D99
        dw $1D88, $1D98, $1D89, $1D99
        dw $1D88, $1D98, $1D9C, $1D9C
        dw $55AD, $5595, $1D9C, $1D9C
        dw $49AC, $4994, $5D8C, $5D8C
    }

    ; $004168-$0041A7 DATA
    Obj2616:
    {
        dw $09AC, $0994, $1D8C, $1D8C
        dw $1D8D, $1D98, $1D89, $1D99
        dw $1D88, $1D98, $1D89, $1D99
        dw $1D88, $1D98, $1D89, $1D99
        dw $1D88, $1D98, $1D89, $1D99
        dw $1D88, $1D98, $1D89, $1D99
        dw $5D8D, $1D98, $1D89, $1D99
        dw $49AC, $4994, $5D8C, $5D8C
    }

    ; ==========================================================================

    ; $0041A8-$004247 DATA
    Obj2656:
    {
        dw $08D0, $08D0, $08D0, $08D0
        dw $08D0, $48D0, $48D0, $48D0
        dw $48D0, $48D0, $08D0, $14C0
        dw $14C0, $14C0, $14C0, $54C0
        dw $54C0, $54C0, $54C0, $48D0
        dw $08D0, $14C0, $14C0, $14C0
        dw $14D1, $54D1, $54C0, $54C0
        dw $54C0, $48D0, $08D0, $14C0
        dw $14C0, $14C2, $14C3, $54C3
        dw $54C2, $54C0, $54C0, $48D0
        dw $097C, $097D, $097F, $14C4
        dw $14C5, $54C5, $54C4, $497F
        dw $497D, $497C, $096C, $096D
        dw $096F, $0908, $14E8, $54E8
        dw $4908, $496F, $496D, $496C
        dw $095C, $095D, $095F, $0918
        dw $14F8, $54F8, $4918, $495F
        dw $495D, $495C, $094C, $094D
        dw $094F, $A888, $A889, $E889
        dw $E888, $494F, $494D, $494C
    }

    ; ==========================================================================

    ; $004248-$004267 DATA
    Obj26F6:
    {
        dw $14C8, $097E, $096E, $295E
        dw $14D8, $14C9, $14D9, $294E
        dw $54D8, $54C9, $54D9, $694E
        dw $54C8, $497E, $496E, $695E
    }

    ; ==========================================================================

    ; $004268-$00427F DATA
    Obj2716:
    {
        dw $2888, $0808, $0818, $2889
        dw $09EF, $0878, $6889, $09EF
        dw $4878, $6888, $4808, $4818
    }

    ; ==========================================================================

    ; $004280-$004297 DATA
    Obj272E:
    {
        dw $282C, $0808, $080D, $282D
        dw $09EF, $0878, $682D, $09EF
        dw $4878, $682C, $4808, $480D
    }

    ; ==========================================================================

    ; $004298-$0042AF DATA
    Obj2746:
    {
        dw $2888, $0808, $0818, $2889
        dw $09EF, $0878, $6889, $09EF
        dw $4878, $6888, $4808, $4818
    }

    ; ==========================================================================

    ; $0042B0-$0042C7 DATA
    Obj275E:
    {
        dw $0882, $0824, $0834, $0883
        dw $0825, $0835, $4883, $4825
        dw $4835, $4882, $4824, $4834
    }

    ; ==========================================================================

    ; $0042C8-$0042DF DATA
    Obj2776:
    {
        dw $0890, $0896, $08A2, $0891
        dw $0897, $08A3, $0890, $0896
        dw $08A2, $0891, $0897, $08A3
    }

    ; ==========================================================================

    ; $0042E0-$0042F7 DATA
    Obj278E:
    {
        dw $0882, $0800, $0810, $0883
        dw $0802, $0812, $4883, $4802
        dw $4812, $4882, $4800, $4810
    }

    ; ==========================================================================

    ; $0042F8-$00430F DATA
    Obj27A6:
    {
        dw $0882, $0800, $0810, $0883
        dw $0801, $0811, $4883, $4801
        dw $4811, $4882, $4800, $4810
    }

    ; ==========================================================================

    ; $004310-$004327 DATA
    Obj27BE:
    {
        dw $0882, $0800, $0810, $0883
        dw $0802, $0812, $4883, $4802
        dw $4812, $4882, $4800, $4810
    }

    ; ==========================================================================

    ; $004328-$00433F DATA
    Obj27D6:
    {
        dw $08B0, $0800, $080B, $08B1
        dw $0802, $0812, $48B1, $4802
        dw $4812, $48B0, $4800, $480B
    }

    ; ==========================================================================

    ; $004340-$004357 DATA
    Obj27EE:
    {
        dw $0890, $08BA, $08A9, $08B4
        dw $088C, $088E, $48B4, $088D
        dw $088F, $0891, $48BA, $48A9
    }

    ; ==========================================================================

    ; $004358-$00436F DATA
    Obj2806:
    {
        dw $0882, $0800, $0810, $0883
        dw $0801, $0811, $4883, $4801
        dw $4811, $4882, $4800, $4810
    }

    ; ==========================================================================

    ; $004370-$004387 DATA
    Obj281E:
    {
        dw $0890, $0896, $08A2, $0891
        dw $088C, $088E, $0890, $088D
        dw $088F, $0891, $0897, $08A3
    }

    ; ==========================================================================

    ; $004388-$00439F DATA
    Obj2836:
    {
        dw $0882, $0824, $0834, $0883
        dw $0825, $0835, $4883, $4825
        dw $4835, $4882, $4824, $4834
    }

    ; ==========================================================================

    ; $0043A0-$0043B7 DATA
    Obj284E:
    {
        dw $2888, $0808, $0818, $2889
        dw $09EF, $0878, $6889, $09EF
        dw $4878, $6888, $4808, $4818
    }

    ; ==========================================================================

    ; $0043B8-$0043CF DATA
    Obj2866:
    {
        dw $282C, $0808, $080D, $282D
        dw $09EF, $0878, $682D, $09EF
        dw $4878, $682C, $4808, $480D
    }

    ; ==========================================================================

    ; $0043D0-$0043E7 DATA
    Obj287E:
    {
        dw $08B0, $0800, $080B, $08B1
        dw $0801, $0811, $48B1, $4801
        dw $4811, $48B0, $4800, $480B
    }

    ; ==========================================================================

    ; $0043E8-$0043FF DATA
    Obj2896:
    {
        dw $08B0, $0824, $080C, $08B1
        dw $0825, $0835, $48B1, $4825
        dw $4835, $48B0, $4824, $480C
    }

    ; ==========================================================================

    ; $004400-$004417 DATA
    Obj28AE:
    {
        dw $282C, $0808, $080D, $282D
        dw $09EF, $0878, $682D, $09EF
        dw $4878, $682C, $4808, $480D
    }

    ; ==========================================================================

    ; $004418-$00442F DATA
    Obj28C6:
    {
        dw $08B0, $0824, $080C, $08B1
        dw $0825, $0835, $48B1, $4825
        dw $4835, $48B0, $4824, $480C
    }

    ; ==========================================================================

    ; $004430-$004447 DATA
    Obj28DE:
    {
        dw $282C, $0808, $080D, $282D
        dw $09EF, $0878, $682D, $09EF
        dw $4878, $682C, $4808, $480D
    }

    ; ==========================================================================

    ; $004448-$00445F DATA
    Obj28F6:
    {
        dw $2882, $0808, $0818, $2883
        dw $09EF, $0878, $6883, $09EF
        dw $4878, $6882, $4808, $4818
    }

    ; ==========================================================================

    ; $004460-$004477 DATA
    Obj290E:
    {
        dw $2886, $0877, $0875, $2887
        dw $09EF, $0859, $6887, $09EF
        dw $4859, $6886, $4877, $4875
    }

    ; ==========================================================================

    ; $004478-$0044A9 DATA
    Obj2926:
    {
        dw $0872, $0872, $0872, $0873
        dw $0874, $0875, $0876, $0876
        dw $0876, $0876, $0876, $0876
        dw $085B, $4876, $4876, $4876
        dw $4876, $4876, $4876, $4872
        dw $4872, $4872, $4873, $4874
        dw $4875
    }

    ; ==========================================================================

    ; $0044AA-$0044C9 DATA
    Obj2958:
    {
        dw $296E, $115E, $1178, $1158
        dw $696E, $09EF, $0878, $1174
        dw $296E, $49EF, $4878, $5174
        dw $696E, $515E, $5178, $5158
    }

    ; ==========================================================================

    ; $0044CA-$0044E1 DATA
    Obj2978:
    {
        dw $28B0, $0808, $080D, $28B1
        dw $09EF, $0878, $68B1, $09EF
        dw $4878, $68B0, $4808, $480D
    }

    ; ==========================================================================

    ; $0044E2-$0044F9 DATA
    Obj2990:
    {
        dw $28B8, $2808, $0818, $289D
        dw $082E, $083E, $689D, $082F
        dw $083F, $68B8, $6808, $4818
    }

    ; ==========================================================================

    ; $0044FA-$004511 DATA
    Obj29A8:
    {
        dw $28B8, $2808, $0818, $28B9
        dw $09EF, $0819, $68B9, $09EF
        dw $081A, $68B8, $6808, $4818
    }

    ; ==========================================================================

    ; $004512-$004529 DATA
    Obj29C0:
    {
        dw $28B5, $2808, $080D, $28B7
        dw $082E, $083E, $68B7, $082F
        dw $083F, $68B5, $6808, $480D
    }

    ; ==========================================================================

    ; $00452A-$004541 DATA
    Obj29D8:
    {
        dw $28B5, $2808, $080D, $28B6
        dw $09EF, $0819, $68B6, $09EF
        dw $081A, $68B5, $6808, $480D
    }

    ; ==========================================================================

    ; $004542-$004559 DATA
    Obj29F0:
    {
        dw $8818, $8808, $A888, $8878
        dw $09EF, $A889, $8878, $09EF
        dw $E889, $C818, $C808, $E888
    }

    ; ==========================================================================

    ; $00455A-$004571 DATA
    Obj2A08:
    {
        dw $880D, $8808, $A82C, $8878
        dw $09EF, $A82D, $C878, $09EF
        dw $E82D, $C80D, $C808, $E82C
    }

    ; ==========================================================================

    ; $004572-$004589 DATA
    Obj2A20:
    {
        dw $8818, $8808, $A888, $8878
        dw $09EF, $A889, $8878, $09EF
        dw $E889, $C818, $C808, $E888
    }

    ; ==========================================================================

    ; $00458A-$0045A1 DATA
    Obj2A38:
    {
        dw $8834, $8824, $8882, $8835
        dw $8825, $8883, $C835, $C825
        dw $C883, $C834, $C824, $C882
    }

    ; ==========================================================================

    ; $0045A2-$0045B9 DATA
    Obj2A50:
    {
        dw $88A2, $8896, $8890, $88A3
        dw $8897, $8891, $88A2, $8896
        dw $8890, $88A3, $8897, $8891
    }

    ; ==========================================================================

    ; $0045BA-$0045D1 DATA
    Obj2A68:
    {
        dw $8810, $8800, $8882, $8812
        dw $8802, $8883, $C812, $C802
        dw $C883, $C810, $C800, $C882
    }

    ; ==========================================================================

    ; $0045D2-$0045E9 DATA
    Obj2A80:
    {
        dw $8818, $8808, $A888, $8878
        dw $09EF, $A889, $8878, $09EF
        dw $E889, $C818, $C808, $E888
    }

    ; ==========================================================================

    ; $0045EA-$004601 DATA
    Obj2A98:
    {
        dw $88A9, $88BA, $8890, $888E
        dw $888C, $88B4, $888F, $888D
        dw $C8B4, $C8A9, $C8BA, $8891
    }

    ; ==========================================================================

    ; $004602-$004619 DATA
    Obj2AB0:
    {
        dw $88A2, $8896, $8890, $888E
        dw $888C, $8891, $888F, $888D
        dw $8890, $88A3, $8897, $8891
    }

    ; ==========================================================================

    ; $00461A-$004631 DATA
    Obj2AC8:
    {
        dw $8810, $8800, $8882, $8811
        dw $8801, $8883, $C811, $C801
        dw $C883, $C810, $C800, $C882
    }

    ; ==========================================================================

    ; $004632-$004649 DATA
    Obj2AE0:
    {
        dw $88A2, $8896, $8890, $888E
        dw $888C, $8891, $888F, $888D
        dw $8890, $88A3, $8897, $8891
    }

    ; ==========================================================================

    ; $00464A-$004661 DATA
    Obj2AF8:
    {
        dw $8818, $8808, $A888, $8878
        dw $09EF, $A889, $8878, $09EF
        dw $E889, $C818, $C808, $E888
    }

    ; ==========================================================================

    ; $004662-$004679 DATA
    Obj2B10:
    {
        dw $8834, $8824, $8882, $8835
        dw $8825, $8883, $C835, $C825
        dw $C883, $C834, $C824, $C882
    }

    ; ==========================================================================

    ; $00467A-$004691 DATA
    Obj2B28:
    {
        dw $880D, $8808, $A82C, $8878
        dw $09EF, $A82D, $C878, $09EF
        dw $E82D, $C80D, $C808, $E82C
    }

    ; ==========================================================================

    ; $004692-$0046A9 DATA
    Obj2B40:
    {
        dw $880B, $8800, $88B0, $8811
        dw $8801, $88B1, $C811, $C801
        dw $C8B1, $C80B, $C800, $C8B0
    }

    ; ==========================================================================

    ; $0046AA-$0046C1 DATA
    Obj2B58:
    {
        dw $880C, $8824, $88B0, $8835
        dw $8825, $88B1, $C835, $C825
        dw $C8B1, $C80C, $C824, $C8B0
    }

    ; ==========================================================================

    ; $0046C2-$0046D9 DATA
    Obj2B70:
    {
        dw $880D, $8808, $A82C, $8878
        dw $09EF, $A82D, $C878, $09EF
        dw $E82D, $C80D, $C808, $E82C
    }

    ; ==========================================================================

    ; $0046DA-$0046F1 DATA
    Obj2B88:
    {
        dw $880D, $8808, $A82C, $8878
        dw $09EF, $A82D, $C878, $09EF
        dw $E82D, $C80D, $C808, $E82C
    }

    ; ==========================================================================

    ; $0046F2-$004709 DATA
    Obj2BA0:
    {
        dw $880C, $8824, $88B0, $8835
        dw $8825, $88B1, $C835, $C825
        dw $C8B1, $C80C, $C824, $C8B0
    }

    ; ==========================================================================

    ; $00470A-$004721 DATA
    Obj2BB8:
    {
        dw $8818, $8808, $A882, $8878
        dw $09EF, $A883, $C878, $09EF
        dw $E883, $C818, $C808, $E882
    }

    ; ==========================================================================

    ; $004722-$004739 DATA
    Obj2BD0:
    {
        dw $8875, $8877, $A886, $8859
        dw $09EF, $A887, $C859, $09EF
        dw $E887, $C875, $C877, $E886
    }

    ; ==========================================================================

    ; $00473A-$00C76B DATA
    Obj2BE8:
    {
        dw $8875, $8874, $8873, $8872
        dw $8872, $8872, $8876, $8876
        dw $8876, $8876, $8876, $8876
        dw $085B, $C876, $C876, $C876
        dw $C876, $C876, $C876, $C875
        dw $C874, $C873, $C872, $C872
        dw $C872
    }

    ; ==========================================================================

    ; $00C76C-$00478B DATA
    Obj2C1A:
    {
        dw $9158, $9178, $915E, $A96E
        dw $9174, $8878, $89EF, $E96E
        dw $D174, $C878, $C9EF, $A96E
        dw $D158, $D178, $D15E, $E96E
    }

    ; ==========================================================================

    ; $00478C-$0047A3 DATA
    Obj2C3A:
    {
        dw $880D, $8808, $A8B0, $8878
        dw $09EF, $A8B1, $C878, $09EF
        dw $E8B1, $C80D, $C808, $E8B0
    }

    ; ==========================================================================

    ; $0047A4-$0047BB DATA
    Obj2C52:
    {
        dw $0960, $296E, $295E, $14C9
        dw $14D9, $294E, $54C9, $54D9
        dw $694E, $4960, $696E, $695E
    }

    ; ==========================================================================

    ; $0047BC-$0047D3 DATA
    Obj2C6A:
    {
        dw $288A, $288B, $A88B, $A88A
        dw $0809, $09EF, $09EF, $8809
        dw $080A, $0879, $8879, $880A
    }

    ; ==========================================================================

    ; $0047D4-$0047EB DATA
    Obj2C82:
    {
        dw $283C, $283D, $A83D, $A83C
        dw $0809, $09EF, $09EF, $8809
        dw $081D, $0879, $8879, $881D
    }

    ; ==========================================================================

    ; $0047EC-$004803 DATA
    Obj2C9A:
    {
        dw $288A, $288B, $A88B, $A88A
        dw $0809, $09EF, $09EF, $8809
        dw $080A, $0879, $8879, $880A
    }

    ; ==========================================================================

    ; $004804-$00481B DATA
    Obj2CB2:
    {
        dw $0884, $0885, $8885, $8884
        dw $0826, $0836, $8836, $8826
        dw $0827, $0837, $8837, $8827
    }

    ; ==========================================================================

    ; $00481C-$004833 DATA
    Obj2CCA:
    {
        dw $0892, $0893, $0892, $0893
        dw $0898, $0899, $0898, $0899
        dw $082D, $083D, $082D, $083D
    }

    ; ==========================================================================

    ; $004834-$00484B DATA
    Obj2CE2:
    {
        dw $0884, $0885, $8885, $8884
        dw $0803, $0805, $8805, $8803
        dw $0804, $0806, $8806, $8804
    }

    ; ==========================================================================

    ; $00484C-$004863 DATA
    Obj2CFA:
    {
        dw $0892, $08A8, $88A8, $0893
        dw $08BB, $08BC, $08BD, $88BB
        dw $08AA, $08BE, $08BF, $88AA
    }

    ; ==========================================================================

    ; $004864-$00487B DATA
    Obj2D12:
    {
        dw $0884, $0885, $8885, $8884
        dw $0803, $0813, $8813, $8803
        dw $0804, $0814, $8814, $8804
    }

    ; ==========================================================================

    ; $00487C-$004893 DATA
    Obj2D2A:
    {
        dw $0892, $0893, $0892, $0893
        dw $0898, $08BC, $08BD, $0899
        dw $08A4, $08BE, $08BF, $08A5
    }

    ; ==========================================================================

    ; $004894-$0048AB DATA
    Obj2D42:
    {
        dw $0884, $0885, $8885, $8884
        dw $0826, $0836, $8836, $8826
        dw $0827, $0837, $8837, $8827
    }

    ; ==========================================================================

    ; $0048AC-$0048C3 DATA
    Obj2D5A:
    {
        dw $288A, $288B, $A88B, $A88A
        dw $0809, $09EF, $09EF, $8809
        dw $080A, $0879, $8879, $880A
    }

    ; ==========================================================================

    ; $0048C4-$0048DB DATA
    Obj2D72:
    {
        dw $283C, $283D, $A83D, $A83C
        dw $0809, $09EF, $09EF, $8809
        dw $081D, $0879, $8879, $881D
    }

    ; ==========================================================================

    ; $0048DC-$0048F3 DATA
    Obj2D8A:
    {
        dw $08B2, $08B3, $88B3, $88B2
        dw $0803, $0813, $8813, $8803
        dw $081B, $0814, $8814, $881B
    }

    ; ==========================================================================

    ; $0048F4-$00490B DATA
    Obj2DA2:
    {
        dw $08B2, $08B3, $88B3, $88B2
        dw $0826, $0836, $8836, $8826
        dw $081C, $0837, $8837, $881C
    }

    ; ==========================================================================

    ; $00490C-$004923 DATA
    Obj2DBA:
    {
        dw $283C, $283D, $A83D, $A83C
        dw $0809, $09EF, $09EF, $8809
        dw $081D, $0879, $8879, $881D
    }

    ; ==========================================================================

    ; $004924-$00493B DATA
    Obj2DD2:
    {
        dw $08B2, $08B3, $88B3, $88B2
        dw $0826, $0836, $8836, $8826
        dw $081C, $0837, $8837, $881C
    }

    ; ==========================================================================

    ; $00493C-$004953 DATA
    Obj2DEA:
    {
        dw $283C, $283D, $A83D, $A83C
        dw $0809, $09EF, $09EF, $8809
        dw $081D, $0879, $8879, $881D
    }

    ; ==========================================================================

    ; $004954-$00496B DATA
    Obj2E02:
    {
        dw $2884, $2885, $A885, $A884
        dw $0809, $09EF, $09EF, $8809
        dw $080A, $0879, $8879, $880A
    }

    ; ==========================================================================

    ; $00496C-$004983 DATA
    Obj2E1A:
    {
        dw $28A0, $28A1, $A8A1, $A8A0
        dw $0867, $09EF, $09EF, $8867
        dw $0865, $085A, $885A, $8865
    }

    ; ==========================================================================

    ; $004984-$0049A3 DATA
    Obj2E32:
    {
        dw $297E, $A97E, $297E, $A97E
        dw $11AC, $09EF, $89EF, $91AC
        dw $1179, $0879, $8879, $9179
        dw $1157, $1175, $9175, $9157
    }

    ; ==========================================================================

    ; $0049A4-$0049BB DATA
    Obj2E52:
    {
        dw $28B2, $28B3, $A8B3, $A8B2
        dw $0809, $09EF, $09EF, $8809
        dw $081D, $0879, $8879, $881D
    }

    ; ==========================================================================

    ; $0049BC-$0049D3 DATA
    Obj2E6A:
    {
        dw $480A, $4879, $C879, $C80A
        dw $4809, $09EF, $09EF, $C809
        dw $688A, $688B, $E88B, $E88A
    }

    ; ==========================================================================

    ; $0049D4-$0049EB DATA
    Obj2E82:
    {
        dw $481D, $4879, $C879, $C81D
        dw $4809, $09EF, $09EF, $C809
        dw $683C, $683D, $E83D, $E83C
    }

    ; ==========================================================================

    ; $0049EC-$004A03 DATA
    Obj2E9A:
    {
        dw $480A, $4879, $C879, $C80A
        dw $4809, $09EF, $09EF, $C809
        dw $688A, $688B, $E88B, $E88A
    }

    ; ==========================================================================

    ; $004A04-$004A1B DATA
    Obj2EB2:
    {
        dw $4827, $4837, $C837, $C827
        dw $4826, $4836, $C836, $C826
        dw $4884, $4885, $C885, $C884
    }

    ; ==========================================================================

    ; $004A1C-$004A33 DATA
    Obj2ECA:
    {
        dw $482D, $483D, $482D, $483D
        dw $4898, $4899, $4898, $4899
        dw $4892, $4893, $4892, $4893
    }

    ; ==========================================================================

    ; $004A34-$004A4B DATA
    Obj2EE2:
    {
        dw $4804, $4806, $C806, $C804
        dw $4803, $4805, $C805, $C803
        dw $4884, $4885, $C885, $C884
    }

    ; ==========================================================================

    ; $004A4C-$004A63 DATA
    Obj2EFA:
    {
        dw $48AA, $48BE, $48BF, $C8AA
        dw $48BB, $48BC, $48BD, $C8BB
        dw $4892, $48A8, $C8A8, $4893
    }

    ; ==========================================================================

    ; $004A64-$004A7B DATA
    Obj2F12:
    {
        dw $4804, $4814, $C814, $C804
        dw $4803, $4813, $C813, $C803
        dw $4884, $4885, $C885, $C884
    }

    ; ==========================================================================

    ; $004A7C-$004A93 DATA
    Obj2F2A:
    {
        dw $48A4, $48BE, $48BF, $48A5
        dw $4898, $48BC, $48BD, $4899
        dw $4892, $4893, $4892, $4893
    }

    ; ==========================================================================

    ; $004A94-$004AAB DATA
    Obj2F42:
    {
        dw $480A, $4879, $C879, $C80A
        dw $4809, $09EF, $09EF, $C809
        dw $688A, $688B, $E88B, $E88A
    }

    ; ==========================================================================

    ; $004AAC-$004AC3 DATA
    Obj2F5A:
    {
        dw $4827, $4837, $C837, $C827
        dw $4826, $4836, $C836, $C826
        dw $4884, $4885, $C885, $C884
    }

    ; ==========================================================================

    ; $004AC4-$004ADB DATA
    Obj2F72:
    {
        dw $481D, $4879, $C879, $C81D
        dw $4809, $09EF, $09EF, $C809
        dw $683C, $683D, $E83D, $E83C
    }

    ; ==========================================================================

    ; $004ADC-$004AF3 DATA
    Obj2F8A:
    {
        dw $481B, $4814, $C814, $C81B
        dw $4803, $4813, $C813, $C803
        dw $48B2, $48B3, $C8B3, $C8B2
    }

    ; ==========================================================================

    ; $004AF4-$004B0B DATA
    Obj2FA2:
    {
        dw $481C, $4837, $C837, $C81C
        dw $4826, $4836, $C836, $C826
        dw $48B2, $48B3, $C8B3, $C8B2
    }

    ; ==========================================================================

    ; $004B0C-$004B23 DATA
    Obj2FBA:
    {
        dw $481D, $4879, $C879, $C81D
        dw $4809, $09EF, $09EF, $C809
        dw $683C, $683D, $E83D, $E83C
    }

    ; ==========================================================================

    ; $004B24-$004B3B DATA
    Obj2FD2:
    {
        dw $481D, $4879, $C879, $C81D
        dw $4809, $09EF, $09EF, $C809
        dw $683C, $683D, $E83D, $E83C
    }

    ; ==========================================================================

    ; $004B3C-$004B53 DATA
    Obj2FEA:
    {
        dw $481C, $4837, $C837, $C81C
        dw $4826, $4836, $C836, $C826
        dw $48B2, $48B3, $C8B3, $C8B2
    }

    ; ==========================================================================

    ; $004B54-$004B6B DATA
    Obj3002:
    {
        dw $480A, $4879, $C879, $C80A
        dw $4809, $09EF, $09EF, $C809
        dw $6884, $6885, $E885, $E884
    }

    ; ==========================================================================

    ; $004B6C-$004B83 DATA
    Obj301A:
    {
        dw $4865, $485A, $C85A, $C865
        dw $4867, $09EF, $09EF, $C867
        dw $68A0, $68A1, $E8A1, $E8A0
    }

    ; ==========================================================================

    ; $004B84-$004BA3 DATA
    Obj3032:
    {
        dw $5157, $5175, $D175, $D157
        dw $5179, $4879, $C879, $D179
        dw $51AC, $49EF, $C9EF, $D1AC
        dw $697E, $E97E, $697E, $E97E
    }

    ; ==========================================================================

    ; $004BA4-$004BBB DATA
    Obj3052:
    {
        dw $481D, $4879, $C879, $C81D
        dw $4809, $09EF, $09EF, $C809
        dw $68B2, $68B3, $E8B3, $E8B2
    }

    ; ==========================================================================

    ; $004BBC-$004BD3 DATA
    Obj306A:
    {
        dw $2882, $0820, $0830, $2883
        dw $0821, $0831, $6883, $4821
        dw $4831, $6882, $4820, $4830
    }

    ; ==========================================================================

    ; $004BD4-$004BEB DATA
    Obj3082:
    {
        dw $2882, $0828, $0838, $2883
        dw $0829, $0839, $6883, $4829
        dw $4839, $6882, $4828, $4838
    }

    ; ==========================================================================

    ; $004BEC-$004C03 DATA
    Obj309A:
    {
        dw $28B0, $0820, $080E, $28B1
        dw $0821, $0831, $68B1, $4821
        dw $4831, $68B0, $4820, $480E
    }

    ; ==========================================================================

    ; $004C04-$004C1B DATA
    Obj30B2:
    {
        dw $28B0, $0828, $080F, $28B1
        dw $0829, $0839, $68B1, $4829
        dw $4839, $68B0, $4828, $480F
    }

    ; ==========================================================================

    ; $004C1C-$004C33 DATA
    Obj30CA:
    {
        dw $8830, $8820, $A882, $8831
        dw $8821, $A883, $C831, $C821
        dw $E883, $C830, $C820, $E882
    }

    ; ==========================================================================

    ; $004C34-$004C4B DATA
    Obj30E2:
    {
        dw $8838, $8828, $A882, $8839
        dw $8829, $A883, $C839, $C829
        dw $E883, $C838, $C828, $E882
    }

    ; ==========================================================================

    ; $004C4C-$004C63 DATA
    Obj30FA:
    {
        dw $880E, $8820, $A8B0, $8831
        dw $8821, $A8B1, $C831, $C821
        dw $E8B1, $C80E, $C820, $E8B0
    }

    ; ==========================================================================

    ; $004C64-$004C7B DATA
    Obj3112:
    {
        dw $880F, $8828, $A8B0, $8839
        dw $8829, $A8B1, $C839, $C829
        dw $E8B1, $C80F, $C828, $E8B0
    }

    ; ==========================================================================

    ; $004C7C-$004C93 DATA
    Obj312A:
    {
        dw $2884, $2885, $A885, $A884
        dw $0822, $0832, $8832, $8822
        dw $0823, $0833, $8833, $8823
    }

    ; ==========================================================================

    ; $004C94-$004CAB DATA
    Obj3142:
    {
        dw $2884, $2885, $A885, $A884
        dw $082A, $083A, $883A, $882A
        dw $082B, $083B, $883B, $882B
    }

    ; ==========================================================================

    ; $004CAC-$004CC3 DATA
    Obj315A:
    {
        dw $28B2, $28B3, $A8B3, $A8B2
        dw $0822, $0832, $8832, $8822
        dw $081E, $0833, $8833, $881E
    }

    ; ==========================================================================

    ; $004CC4-$004CDB DATA
    Obj3172:
    {
        dw $28B2, $28B3, $A8B3, $A8B2
        dw $082A, $083A, $883A, $882A
        dw $081F, $083B, $883B, $881F
    }

    ; ==========================================================================

    ; $004CDC-$004CF3 DATA
    Obj318A:
    {
        dw $4823, $4833, $C833, $C823
        dw $4822, $4832, $C832, $C822
        dw $6884, $6885, $E885, $E884
    }

    ; ==========================================================================

    ; $004CF4-$004D0B DATA
    Obj31A2:
    {
        dw $482B, $483B, $C83B, $C82B
        dw $482A, $483A, $C83A, $C82A
        dw $6884, $6885, $E885, $E884
    }

    ; ==========================================================================

    ; $004D0C-$004D23 DATA
    Obj31BA:
    {
        dw $481E, $4833, $C833, $C81E
        dw $4822, $4832, $C832, $C822
        dw $68B2, $68B3, $E8B3, $E8B2
    }

    ; ==========================================================================

    ; $004D24-$004D3B DATA
    Obj31D2:
    {
        dw $481F, $483B, $C83B, $C81F
        dw $482A, $483A, $C83A, $C82A
        dw $68B2, $68B3, $E8B3, $E8B2
    }

    ; ==========================================================================

    ; $004D3C-$00CD9D DATA
    Obj31EA:
    {
        dw $8875, $8874, $8873, $8872
        dw $8872, $8872, $0872, $8872
        dw $8872, $0873, $0874, $0875
        dw $8876, $8876, $8876, $8876
        dw $8876, $0876, $0876, $0876
        dw $0876, $0876, $0876, $0876
        dw $085B, $C876, $C876, $C876
        dw $C876, $C876, $4876, $4876
        dw $4876, $4876, $4876, $4876
        dw $4876, $C875, $C874, $C873
        dw $C872, $C872, $C872, $4872
        dw $4872, $4872, $4873, $4874
        dw $4875
    }

    ; ==========================================================================

    ; $004D9E-$004E05 DATA
    DoorGFXDataOffset_North:
    {
        dw obj2716-RoomDrawObjectData ; 0x00 - Normal door
        dw obj272E-RoomDrawObjectData ; 0x02 - Normal door (lower layer)
        dw obj272E-RoomDrawObjectData ; 0x04 - Exit (lower layer)
        dw obj2746-RoomDrawObjectData ; 0x06 - Unused cave exit (lower layer)
        dw obj2746-RoomDrawObjectData ; 0x08 - Waterfall door
        dw obj2746-RoomDrawObjectData ; 0x0A - Fancy dungeon exit
        dw obj2746-RoomDrawObjectData ; 0x0C - Fancy dungeon exit (lower layer)
        dw obj2746-RoomDrawObjectData ; 0x0E - Cave exit
        dw obj2746-RoomDrawObjectData ; 0x10 - Lit cave exit (lower layer)
        dw obj275E-RoomDrawObjectData ; 0x12 - Exit marker
        dw obj275E-RoomDrawObjectData ; 0x14 - Dungeon swap marker
        dw obj275E-RoomDrawObjectData ; 0x16 - Layer swap marker
        dw obj275E-RoomDrawObjectData ; 0x18 - Double sided shutter door
        dw obj2776-RoomDrawObjectData ; 0x1A - Eye watch door
        dw obj278E-RoomDrawObjectData ; 0x1C - Small key door
        dw obj27A6-RoomDrawObjectData ; 0x1E - Big key door
        dw obj27BE-RoomDrawObjectData ; 0x20 - Small key stairs (upwards)
        dw obj27BE-RoomDrawObjectData ; 0x22 - Small key stairs (downwards)
        dw obj27D6-RoomDrawObjectData ; 0x24 - Small key stairs (lower layer upwards)
        dw obj27D6-RoomDrawObjectData ; 0x26 - Small key stairs (lower layer downwards)
        dw obj27EE-RoomDrawObjectData ; 0x28 - Dash wall
        dw obj2806-RoomDrawObjectData ; 0x2A - Bombable cave exit
        dw obj2806-RoomDrawObjectData ; 0x2C - Unopenable, double-sided big key door
        dw obj281E-RoomDrawObjectData ; 0x2E - Bombable door
        dw obj2836-RoomDrawObjectData ; 0x30 - Exploding wall
        dw obj2836-RoomDrawObjectData ; 0x32 - Curtain door
        dw obj2836-RoomDrawObjectData ; 0x34 - Unusable bottom-sided shutter door
        dw obj2836-RoomDrawObjectData ; 0x36 - Bottom-sided shutter door
        dw obj284E-RoomDrawObjectData ; 0x38 - Top-sided shutter door
        dw obj2866-RoomDrawObjectData ; 0x3A - Unusable normal door (lower layer)
        dw obj2866-RoomDrawObjectData ; 0x3C - Unusable normal door (lower layer)
        dw obj2866-RoomDrawObjectData ; 0x3E - Unusable normal door (lower layer)
        dw obj2866-RoomDrawObjectData ; 0x40 - Normal door (lower layer used with one-sided shutters)
        dw obj287E-RoomDrawObjectData ; 0x42 - Unused double-sided shutter
        dw obj2896-RoomDrawObjectData ; 0x44 - Double-sided shutter (lower layer)
        dw obj28AE-RoomDrawObjectData ; 0x46 - Explicit room door
        dw obj28C6-RoomDrawObjectData ; 0x48 - Bottom-sided shutter door (lower layer)
        dw obj28DE-RoomDrawObjectData ; 0x4A - Top-sided shutter door (lower layer)
        dw obj28F6-RoomDrawObjectData ; 0x4C - Unusable normal door (lower layer)
        dw obj28F6-RoomDrawObjectData ; 0x4E - Unusable normal door (lower layer)
        dw obj28F6-RoomDrawObjectData ; 0x50 - Unusable normal door (lower layer)
        dw obj290E-RoomDrawObjectData ; 0x52 - Unusable bombed-open door (lower layer)
        dw obj2926-RoomDrawObjectData ; 0x54 - Unusable glitchy door (lower layer)
        dw obj2958-RoomDrawObjectData ; 0x56 - Unusable glitchy door (lower layer)
        dw obj2978-RoomDrawObjectData ; 0x58 - Unusable normal door (lower layer)
        dw obj2990-RoomDrawObjectData ; 0x5A - Unusable glitchy/stairs up (lower layer)
        dw obj2990-RoomDrawObjectData ; 0x5C - Unusable glitchy/stairs up (lower layer)
        dw obj2990-RoomDrawObjectData ; 0x5E - Unusable glitchy/stairs up (lower layer)
        dw obj2990-RoomDrawObjectData ; 0x60 - Unusable glitchy/stairs up (lower layer)
        dw obj29A8-RoomDrawObjectData ; 0x62 - Unusable glitchy/stairs down (lower layer)
        dw obj29C0-RoomDrawObjectData ; 0x64 - Unusable glitchy/stairs up (lower layer)
        dw obj29D8-RoomDrawObjectData ; 0x66 - Unusable glitchy/stairs down (lower layer)
    }

    ; ==========================================================================

    ; $004E06-$004E65 DATA
    DoorGFXDataOffset_South:
    {
        dw obj29F0-RoomDrawObjectData
        dw obj2A08-RoomDrawObjectData
        dw obj2A08-RoomDrawObjectData
        dw obj2A20-RoomDrawObjectData
        dw obj2A20-RoomDrawObjectData
        dw obj2A20-RoomDrawObjectData
        dw obj2A20-RoomDrawObjectData
        dw obj2A20-RoomDrawObjectData
        dw obj2A20-RoomDrawObjectData
        dw obj2A38-RoomDrawObjectData
        dw obj2A38-RoomDrawObjectData
        dw obj2A38-RoomDrawObjectData
        dw obj2A38-RoomDrawObjectData
        dw obj2A50-RoomDrawObjectData
        dw obj2A68-RoomDrawObjectData
        dw obj2A80-RoomDrawObjectData
        dw obj2A98-RoomDrawObjectData
        dw obj2A98-RoomDrawObjectData
        dw obj2A98-RoomDrawObjectData
        dw obj2A98-RoomDrawObjectData
        dw obj2A98-RoomDrawObjectData
        dw obj2AB0-RoomDrawObjectData
        dw obj2AC8-RoomDrawObjectData
        dw obj2AE0-RoomDrawObjectData
        dw obj2AF8-RoomDrawObjectData
        dw obj2AF8-RoomDrawObjectData
        dw obj2AF8-RoomDrawObjectData
        dw obj2AF8-RoomDrawObjectData
        dw obj2B10-RoomDrawObjectData
        dw obj2B28-RoomDrawObjectData
        dw obj2B28-RoomDrawObjectData
        dw obj2B28-RoomDrawObjectData
        dw obj2B28-RoomDrawObjectData
        dw obj2B40-RoomDrawObjectData
        dw obj2B58-RoomDrawObjectData
        dw obj2B70-RoomDrawObjectData
        dw obj2B88-RoomDrawObjectData
        dw obj2BA0-RoomDrawObjectData
        dw obj2BB8-RoomDrawObjectData
        dw obj2BB8-RoomDrawObjectData
        dw obj2BB8-RoomDrawObjectData
        dw obj2BD0-RoomDrawObjectData
        dw obj2BE8-RoomDrawObjectData
        dw obj2C1A-RoomDrawObjectData
        dw obj2C3A-RoomDrawObjectData
        dw obj2C52-RoomDrawObjectData
        dw obj2C6A-RoomDrawObjectData
        dw obj2C6A-RoomDrawObjectData
    }

    ; ==========================================================================

    ; $004E66-$004EC5 DATA
    DoorGFXDataOffset_West:
    {
        dw obj2C6A-RoomDrawObjectData
        dw obj2C82-RoomDrawObjectData
        dw obj2C82-RoomDrawObjectData
        dw obj2C9A-RoomDrawObjectData
        dw obj2C9A-RoomDrawObjectData
        dw obj2C9A-RoomDrawObjectData
        dw obj2C9A-RoomDrawObjectData
        dw obj2C9A-RoomDrawObjectData
        dw obj2C9A-RoomDrawObjectData
        dw obj2CB2-RoomDrawObjectData
        dw obj2CB2-RoomDrawObjectData
        dw obj2CB2-RoomDrawObjectData
        dw obj2CB2-RoomDrawObjectData
        dw obj2CCA-RoomDrawObjectData
        dw obj2CE2-RoomDrawObjectData
        dw obj2CFA-RoomDrawObjectData
        dw obj2CFA-RoomDrawObjectData
        dw obj2CFA-RoomDrawObjectData
        dw obj2CFA-RoomDrawObjectData
        dw obj2CFA-RoomDrawObjectData
        dw obj2CFA-RoomDrawObjectData
        dw obj2D12-RoomDrawObjectData
        dw obj2D12-RoomDrawObjectData
        dw obj2D2A-RoomDrawObjectData
        dw obj2D42-RoomDrawObjectData
        dw obj2D42-RoomDrawObjectData
        dw obj2D42-RoomDrawObjectData
        dw obj2D42-RoomDrawObjectData
        dw obj2D5A-RoomDrawObjectData
        dw obj2D72-RoomDrawObjectData
        dw obj2D72-RoomDrawObjectData
        dw obj2D72-RoomDrawObjectData
        dw obj2D72-RoomDrawObjectData
        dw obj2D8A-RoomDrawObjectData
        dw obj2DA2-RoomDrawObjectData
        dw obj2DBA-RoomDrawObjectData
        dw obj2DD2-RoomDrawObjectData
        dw obj2DEA-RoomDrawObjectData
        dw obj2E02-RoomDrawObjectData
        dw obj2E02-RoomDrawObjectData
        dw obj2E02-RoomDrawObjectData
        dw obj2E1A-RoomDrawObjectData
        dw obj2E32-RoomDrawObjectData
        dw obj2E32-RoomDrawObjectData
        dw obj2E52-RoomDrawObjectData
        dw obj2E6A-RoomDrawObjectData
        dw obj2E6A-RoomDrawObjectData
        dw obj2E6A-RoomDrawObjectData
    }

    ; ==========================================================================

    ; $004EC6-$004F23 DATA
    DoorGFXDataOffset_East:
    {
        dw obj2E6A-RoomDrawObjectData
        dw obj2E82-RoomDrawObjectData
        dw obj2E82-RoomDrawObjectData
        dw obj2E9A-RoomDrawObjectData
        dw obj2E9A-RoomDrawObjectData
        dw obj2E9A-RoomDrawObjectData
        dw obj2E9A-RoomDrawObjectData
        dw obj2E9A-RoomDrawObjectData
        dw obj2E9A-RoomDrawObjectData
        dw obj2EB2-RoomDrawObjectData
        dw obj2EB2-RoomDrawObjectData
        dw obj2EB2-RoomDrawObjectData
        dw obj2EB2-RoomDrawObjectData
        dw obj2ECA-RoomDrawObjectData
        dw obj2EE2-RoomDrawObjectData
        dw obj2EFA-RoomDrawObjectData
        dw obj2EFA-RoomDrawObjectData
        dw obj2EFA-RoomDrawObjectData
        dw obj2EFA-RoomDrawObjectData
        dw obj2EFA-RoomDrawObjectData
        dw obj2EFA-RoomDrawObjectData
        dw obj2F12-RoomDrawObjectData
        dw obj2F12-RoomDrawObjectData
        dw obj2F2A-RoomDrawObjectData
        dw obj2F42-RoomDrawObjectData
        dw obj2F42-RoomDrawObjectData
        dw obj2F42-RoomDrawObjectData
        dw obj2F42-RoomDrawObjectData
        dw obj2F5A-RoomDrawObjectData
        dw obj2F72-RoomDrawObjectData
        dw obj2F72-RoomDrawObjectData
        dw obj2F72-RoomDrawObjectData
        dw obj2F72-RoomDrawObjectData
        dw obj2F8A-RoomDrawObjectData
        dw obj2FA2-RoomDrawObjectData
        dw obj2FBA-RoomDrawObjectData
        dw obj2FD2-RoomDrawObjectData
        dw obj2FEA-RoomDrawObjectData
        dw obj3002-RoomDrawObjectData
        dw obj3002-RoomDrawObjectData
        dw obj3002-RoomDrawObjectData
        dw obj301A-RoomDrawObjectData
        dw obj3032-RoomDrawObjectData
        dw obj3032-RoomDrawObjectData
        dw obj3052-RoomDrawObjectData
        dw obj306A-RoomDrawObjectData
        dw obj306A-RoomDrawObjectData
    }

    ; ==========================================================================

    ; $004F24-$004F2B DATA
    DoorAnimGFXDataOffset_North:
    {
        dw obj306A-RoomDrawObjectData ; Lower layer shutter
        dw obj306A-RoomDrawObjectData ; Key doors
        dw obj3082-RoomDrawObjectData ; Shutters
        dw obj309A-RoomDrawObjectData ; Lower layer key door
    }

    ; $004F2C-$004F33 DATA
    DoorAnimGFXDataOffset_South:
    {
        dw obj30B2-RoomDrawObjectData ; Lower layer shutter
        dw obj30CA-RoomDrawObjectData ; Key doors
        dw obj30E2-RoomDrawObjectData ; Shutters
        dw obj30FA-RoomDrawObjectData ; Lower layer key door
    }

    ; $004F34-$004F3B DATA
    DoorAnimGFXDataOffset_West:
    {
        dw obj3112-RoomDrawObjectData ; Lower layer shutter
        dw obj312A-RoomDrawObjectData ; Key doors
        dw obj3142-RoomDrawObjectData ; Shutters
        dw obj315A-RoomDrawObjectData ; Lower layer key door
    }

    ; $004F3C-$004F45 DATA
    DoorAnimGFXDataOffset_East:
    {
        dw obj3172-RoomDrawObjectData ; Lower layer shutter
        dw obj318A-RoomDrawObjectData ; Key doors
        dw obj31A2-RoomDrawObjectData ; Shutters
        dw obj31BA-RoomDrawObjectData ; Lower layer key door
        dw obj31D2-RoomDrawObjectData ; Unused cool looking shutter
    }
}

; ==============================================================================

; $004F46-$004F7F DATA
NULL_00CF46:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF
}

; ==============================================================================

; $004F80-$00521C DATA
GFXSheetPointers:
{
    ; $004F80
    .background_bank
    db GFX_00>>16
    db GFX_01>>16
    db GFX_02>>16
    db GFX_03>>16
    db GFX_04>>16
    db GFX_05>>16
    db GFX_06>>16
    db GFX_07>>16
    db GFX_08>>16
    db GFX_09>>16
    db GFX_0A>>16
    db GFX_0B>>16
    db GFX_0C>>16
    db GFX_0D>>16
    db GFX_0E>>16
    db GFX_0F>>16
    db GFX_10>>16
    db GFX_11>>16
    db GFX_12>>16
    db GFX_13>>16
    db GFX_14>>16
    db GFX_15>>16
    db GFX_16>>16
    db GFX_17>>16
    db GFX_18>>16
    db GFX_19>>16
    db GFX_1A>>16
    db GFX_1B>>16
    db GFX_1C>>16
    db GFX_1D>>16
    db GFX_1E>>16
    db GFX_1F>>16
    db GFX_20>>16
    db GFX_21>>16
    db GFX_22>>16
    db GFX_23>>16
    db GFX_24>>16
    db GFX_25>>16
    db GFX_26>>16
    db GFX_27>>16
    db GFX_28>>16
    db GFX_29>>16
    db GFX_2A>>16
    db GFX_2B>>16
    db GFX_2C>>16
    db GFX_2D>>16
    db GFX_2E>>16
    db GFX_2F>>16
    db GFX_30>>16
    db GFX_31>>16
    db GFX_32>>16
    db GFX_33>>16
    db GFX_34>>16
    db GFX_35>>16
    db GFX_36>>16
    db GFX_37>>16
    db GFX_38>>16
    db GFX_39>>16
    db GFX_3A>>16
    db GFX_3B>>16
    db GFX_3C>>16
    db GFX_3D>>16
    db GFX_3E>>16
    db GFX_3F>>16
    db GFX_40>>16
    db GFX_41>>16
    db GFX_42>>16
    db GFX_43>>16
    db GFX_44>>16
    db GFX_45>>16
    db GFX_46>>16
    db GFX_47>>16
    db GFX_48>>16
    db GFX_49>>16
    db GFX_4A>>16
    db GFX_4B>>16
    db GFX_4C>>16
    db GFX_4D>>16
    db GFX_4E>>16
    db GFX_4F>>16
    db GFX_50>>16
    db GFX_51>>16
    db GFX_52>>16
    db GFX_53>>16
    db GFX_54>>16
    db GFX_55>>16
    db GFX_56>>16
    db GFX_57>>16
    db GFX_58>>16
    db GFX_59>>16
    db GFX_5A>>16
    db GFX_5B>>16
    db GFX_5C>>16
    db GFX_5D>>16
    db GFX_5E>>16
    db GFX_5F>>16
    db GFX_60>>16
    db GFX_61>>16
    db GFX_62>>16
    db GFX_63>>16
    db GFX_64>>16
    db GFX_65>>16
    db GFX_66>>16
    db GFX_67>>16
    db GFX_68>>16
    db GFX_69>>16
    db GFX_6A>>16
    db GFX_6B>>16
    db GFX_6C>>16
    db GFX_6D>>16
    db GFX_6E>>16
    db GFX_6F>>16
    db GFX_70>>16
    db GFX_DD>>16
    db GFX_DE>>16
    
    ; $004FF3
    .sprite_bank
    db GFX_73>>16 ; 0x00
    db GFX_74>>16 ; 0x01
    db GFX_75>>16 ; 0x02
    db GFX_76>>16 ; 0x03
    db GFX_77>>16 ; 0x04
    db GFX_78>>16 ; 0x05
    db GFX_79>>16 ; 0x06
    db GFX_7A>>16 ; 0x07
    db GFX_7B>>16 ; 0x08
    db GFX_7C>>16 ; 0x09
    db GFX_7D>>16 ; 0x0A
    db GFX_7E>>16 ; 0x0B
    db GFX_7F>>16 ; 0x0C
    db GFX_80>>16 ; 0x0D
    db GFX_81>>16 ; 0x0E
    db GFX_82>>16 ; 0x0F
    db GFX_83>>16 ; 0x10
    db GFX_84>>16 ; 0x11
    db GFX_85>>16 ; 0x12
    db GFX_86>>16 ; 0x13
    db GFX_87>>16 ; 0x14
    db GFX_88>>16 ; 0x15
    db GFX_89>>16 ; 0x16
    db GFX_8A>>16 ; 0x17
    db GFX_8B>>16 ; 0x18
    db GFX_8C>>16 ; 0x19
    db GFX_8D>>16 ; 0x1A
    db GFX_8E>>16 ; 0x1B
    db GFX_8F>>16 ; 0x1C
    db GFX_90>>16 ; 0x1D
    db GFX_91>>16 ; 0x1E
    db GFX_92>>16 ; 0x1F
    db GFX_93>>16 ; 0x20
    db GFX_94>>16 ; 0x21
    db GFX_95>>16 ; 0x22
    db GFX_96>>16 ; 0x23
    db GFX_97>>16 ; 0x24
    db GFX_98>>16 ; 0x25
    db GFX_99>>16 ; 0x26
    db GFX_9A>>16 ; 0x27
    db GFX_9B>>16 ; 0x28
    db GFX_9C>>16 ; 0x29
    db GFX_9D>>16 ; 0x2A
    db GFX_9E>>16 ; 0x2B
    db GFX_9F>>16 ; 0x2C
    db GFX_A0>>16 ; 0x2D
    db GFX_A1>>16 ; 0x2E
    db GFX_A2>>16 ; 0x2F
    db GFX_A3>>16 ; 0x30
    db GFX_A4>>16 ; 0x31
    db GFX_A5>>16 ; 0x32
    db GFX_A6>>16 ; 0x33
    db GFX_A7>>16 ; 0x34
    db GFX_A8>>16 ; 0x35
    db GFX_A9>>16 ; 0x36
    db GFX_AA>>16 ; 0x37
    db GFX_AB>>16 ; 0x38
    db GFX_AC>>16 ; 0x39
    db GFX_AD>>16 ; 0x3A
    db GFX_AE>>16 ; 0x3B
    db GFX_AF>>16 ; 0x3C
    db GFX_B0>>16 ; 0x3D
    db GFX_B1>>16 ; 0x3E
    db GFX_B2>>16 ; 0x3F
    db GFX_B3>>16 ; 0x40
    db GFX_B4>>16 ; 0x41
    db GFX_B5>>16 ; 0x42
    db GFX_B6>>16 ; 0x43
    db GFX_B7>>16 ; 0x44
    db GFX_B8>>16 ; 0x45
    db GFX_B9>>16 ; 0x46
    db GFX_BA>>16 ; 0x47
    db GFX_BB>>16 ; 0x48
    db GFX_BC>>16 ; 0x49
    db GFX_BD>>16 ; 0x4A
    db GFX_BE>>16 ; 0x4B
    db GFX_BF>>16 ; 0x4C
    db GFX_C0>>16 ; 0x4D
    db GFX_C1>>16 ; 0x4E
    db GFX_C2>>16 ; 0x4F
    db GFX_C3>>16 ; 0x50
    db GFX_C4>>16 ; 0x51
    db GFX_C5>>16 ; 0x52
    db GFX_C6>>16 ; 0x53
    db GFX_C7>>16 ; 0x54
    db GFX_C8>>16 ; 0x55
    db GFX_C9>>16 ; 0x56
    db GFX_CA>>16 ; 0x57
    db GFX_CB>>16 ; 0x58
    db GFX_CC>>16 ; 0x59
    db GFX_CD>>16 ; 0x5A
    db GFX_CE>>16 ; 0x5B
    db GFX_CF>>16 ; 0x5C
    db GFX_D0>>16 ; 0x5D
    db GFX_D1>>16 ; 0x5E
    db GFX_D2>>16 ; 0x5F
    db GFX_D3>>16 ; 0x60
    db GFX_D4>>16 ; 0x61
    db GFX_D5>>16 ; 0x62
    db GFX_D6>>16 ; 0x63
    db GFX_D7>>16 ; 0x64
    db GFX_D8>>16 ; 0x65
    db GFX_D9>>16 ; 0x66
    db GFX_DA>>16 ; 0x67
    db GFX_DB>>16 ; 0x68
    db GFX_DC>>16 ; 0x69
    db GFX_DD>>16 ; 0x6A
    db GFX_DE>>16 ; 0x6B

    ; $00505F
    .background_high
    db GFX_00>>8
    db GFX_01>>8
    db GFX_02>>8
    db GFX_03>>8
    db GFX_04>>8
    db GFX_05>>8
    db GFX_06>>8
    db GFX_07>>8
    db GFX_08>>8
    db GFX_09>>8
    db GFX_0A>>8
    db GFX_0B>>8
    db GFX_0C>>8
    db GFX_0D>>8
    db GFX_0E>>8
    db GFX_0F>>8
    db GFX_10>>8
    db GFX_11>>8
    db GFX_12>>8
    db GFX_13>>8
    db GFX_14>>8
    db GFX_15>>8
    db GFX_16>>8
    db GFX_17>>8
    db GFX_18>>8
    db GFX_19>>8
    db GFX_1A>>8
    db GFX_1B>>8
    db GFX_1C>>8
    db GFX_1D>>8
    db GFX_1E>>8
    db GFX_1F>>8
    db GFX_20>>8
    db GFX_21>>8
    db GFX_22>>8
    db GFX_23>>8
    db GFX_24>>8
    db GFX_25>>8
    db GFX_26>>8
    db GFX_27>>8
    db GFX_28>>8
    db GFX_29>>8
    db GFX_2A>>8
    db GFX_2B>>8
    db GFX_2C>>8
    db GFX_2D>>8
    db GFX_2E>>8
    db GFX_2F>>8
    db GFX_30>>8
    db GFX_31>>8
    db GFX_32>>8
    db GFX_33>>8
    db GFX_34>>8
    db GFX_35>>8
    db GFX_36>>8
    db GFX_37>>8
    db GFX_38>>8
    db GFX_39>>8
    db GFX_3A>>8
    db GFX_3B>>8
    db GFX_3C>>8
    db GFX_3D>>8
    db GFX_3E>>8
    db GFX_3F>>8
    db GFX_40>>8
    db GFX_41>>8
    db GFX_42>>8
    db GFX_43>>8
    db GFX_44>>8
    db GFX_45>>8
    db GFX_46>>8
    db GFX_47>>8
    db GFX_48>>8
    db GFX_49>>8
    db GFX_4A>>8
    db GFX_4B>>8
    db GFX_4C>>8
    db GFX_4D>>8
    db GFX_4E>>8
    db GFX_4F>>8
    db GFX_50>>8
    db GFX_51>>8
    db GFX_52>>8
    db GFX_53>>8
    db GFX_54>>8
    db GFX_55>>8
    db GFX_56>>8
    db GFX_57>>8
    db GFX_58>>8
    db GFX_59>>8
    db GFX_5A>>8
    db GFX_5B>>8
    db GFX_5C>>8
    db GFX_5D>>8
    db GFX_5E>>8
    db GFX_5F>>8
    db GFX_60>>8
    db GFX_61>>8
    db GFX_62>>8
    db GFX_63>>8
    db GFX_64>>8
    db GFX_65>>8
    db GFX_66>>8
    db GFX_67>>8
    db GFX_68>>8
    db GFX_69>>8
    db GFX_6A>>8
    db GFX_6B>>8
    db GFX_6C>>8
    db GFX_6D>>8
    db GFX_6E>>8
    db GFX_6F>>8
    db GFX_70>>8
    db GFX_DD>>8
    db GFX_DE>>8

    ; $0050D2
    .sprite_high
    db GFX_73>>8 ; 0x00
    db GFX_74>>8 ; 0x01
    db GFX_75>>8 ; 0x02
    db GFX_76>>8 ; 0x03
    db GFX_77>>8 ; 0x04
    db GFX_78>>8 ; 0x05
    db GFX_79>>8 ; 0x06
    db GFX_7A>>8 ; 0x07
    db GFX_7B>>8 ; 0x08
    db GFX_7C>>8 ; 0x09
    db GFX_7D>>8 ; 0x0A
    db GFX_7E>>8 ; 0x0B
    db GFX_7F>>8 ; 0x0C
    db GFX_80>>8 ; 0x0D
    db GFX_81>>8 ; 0x0E
    db GFX_82>>8 ; 0x0F
    db GFX_83>>8 ; 0x10
    db GFX_84>>8 ; 0x11
    db GFX_85>>8 ; 0x12
    db GFX_86>>8 ; 0x13
    db GFX_87>>8 ; 0x14
    db GFX_88>>8 ; 0x15
    db GFX_89>>8 ; 0x16
    db GFX_8A>>8 ; 0x17
    db GFX_8B>>8 ; 0x18
    db GFX_8C>>8 ; 0x19
    db GFX_8D>>8 ; 0x1A
    db GFX_8E>>8 ; 0x1B
    db GFX_8F>>8 ; 0x1C
    db GFX_90>>8 ; 0x1D
    db GFX_91>>8 ; 0x1E
    db GFX_92>>8 ; 0x1F
    db GFX_93>>8 ; 0x20
    db GFX_94>>8 ; 0x21
    db GFX_95>>8 ; 0x22
    db GFX_96>>8 ; 0x23
    db GFX_97>>8 ; 0x24
    db GFX_98>>8 ; 0x25
    db GFX_99>>8 ; 0x26
    db GFX_9A>>8 ; 0x27
    db GFX_9B>>8 ; 0x28
    db GFX_9C>>8 ; 0x29
    db GFX_9D>>8 ; 0x2A
    db GFX_9E>>8 ; 0x2B
    db GFX_9F>>8 ; 0x2C
    db GFX_A0>>8 ; 0x2D
    db GFX_A1>>8 ; 0x2E
    db GFX_A2>>8 ; 0x2F
    db GFX_A3>>8 ; 0x30
    db GFX_A4>>8 ; 0x31
    db GFX_A5>>8 ; 0x32
    db GFX_A6>>8 ; 0x33
    db GFX_A7>>8 ; 0x34
    db GFX_A8>>8 ; 0x35
    db GFX_A9>>8 ; 0x36
    db GFX_AA>>8 ; 0x37
    db GFX_AB>>8 ; 0x38
    db GFX_AC>>8 ; 0x39
    db GFX_AD>>8 ; 0x3A
    db GFX_AE>>8 ; 0x3B
    db GFX_AF>>8 ; 0x3C
    db GFX_B0>>8 ; 0x3D
    db GFX_B1>>8 ; 0x3E
    db GFX_B2>>8 ; 0x3F
    db GFX_B3>>8 ; 0x40
    db GFX_B4>>8 ; 0x41
    db GFX_B5>>8 ; 0x42
    db GFX_B6>>8 ; 0x43
    db GFX_B7>>8 ; 0x44
    db GFX_B8>>8 ; 0x45
    db GFX_B9>>8 ; 0x46
    db GFX_BA>>8 ; 0x47
    db GFX_BB>>8 ; 0x48
    db GFX_BC>>8 ; 0x49
    db GFX_BD>>8 ; 0x4A
    db GFX_BE>>8 ; 0x4B
    db GFX_BF>>8 ; 0x4C
    db GFX_C0>>8 ; 0x4D
    db GFX_C1>>8 ; 0x4E
    db GFX_C2>>8 ; 0x4F
    db GFX_C3>>8 ; 0x50
    db GFX_C4>>8 ; 0x51
    db GFX_C5>>8 ; 0x52
    db GFX_C6>>8 ; 0x53
    db GFX_C7>>8 ; 0x54
    db GFX_C8>>8 ; 0x55
    db GFX_C9>>8 ; 0x56
    db GFX_CA>>8 ; 0x57
    db GFX_CB>>8 ; 0x58
    db GFX_CC>>8 ; 0x59
    db GFX_CD>>8 ; 0x5A
    db GFX_CE>>8 ; 0x5B
    db GFX_CF>>8 ; 0x5C
    db GFX_D0>>8 ; 0x5D
    db GFX_D1>>8 ; 0x5E
    db GFX_D2>>8 ; 0x5F
    db GFX_D3>>8 ; 0x60
    db GFX_D4>>8 ; 0x61
    db GFX_D5>>8 ; 0x62
    db GFX_D6>>8 ; 0x63
    db GFX_D7>>8 ; 0x64
    db GFX_D8>>8 ; 0x65
    db GFX_D9>>8 ; 0x66
    db GFX_DA>>8 ; 0x67
    db GFX_DB>>8 ; 0x68
    db GFX_DC>>8 ; 0x69
    db GFX_DD>>8 ; 0x6A
    db GFX_DE>>8 ; 0x6B

    ; $00513E 
    .background_low
    db GFX_00>>0
    db GFX_01>>0
    db GFX_02>>0
    db GFX_03>>0
    db GFX_04>>0
    db GFX_05>>0
    db GFX_06>>0
    db GFX_07>>0
    db GFX_08>>0
    db GFX_09>>0
    db GFX_0A>>0
    db GFX_0B>>0
    db GFX_0C>>0
    db GFX_0D>>0
    db GFX_0E>>0
    db GFX_0F>>0
    db GFX_10>>0
    db GFX_11>>0
    db GFX_12>>0
    db GFX_13>>0
    db GFX_14>>0
    db GFX_15>>0
    db GFX_16>>0
    db GFX_17>>0
    db GFX_18>>0
    db GFX_19>>0
    db GFX_1A>>0
    db GFX_1B>>0
    db GFX_1C>>0
    db GFX_1D>>0
    db GFX_1E>>0
    db GFX_1F>>0
    db GFX_20>>0
    db GFX_21>>0
    db GFX_22>>0
    db GFX_23>>0
    db GFX_24>>0
    db GFX_25>>0
    db GFX_26>>0
    db GFX_27>>0
    db GFX_28>>0
    db GFX_29>>0
    db GFX_2A>>0
    db GFX_2B>>0
    db GFX_2C>>0
    db GFX_2D>>0
    db GFX_2E>>0
    db GFX_2F>>0
    db GFX_30>>0
    db GFX_31>>0
    db GFX_32>>0
    db GFX_33>>0
    db GFX_34>>0
    db GFX_35>>0
    db GFX_36>>0
    db GFX_37>>0
    db GFX_38>>0
    db GFX_39>>0
    db GFX_3A>>0
    db GFX_3B>>0
    db GFX_3C>>0
    db GFX_3D>>0
    db GFX_3E>>0
    db GFX_3F>>0
    db GFX_40>>0
    db GFX_41>>0
    db GFX_42>>0
    db GFX_43>>0
    db GFX_44>>0
    db GFX_45>>0
    db GFX_46>>0
    db GFX_47>>0
    db GFX_48>>0
    db GFX_49>>0
    db GFX_4A>>0
    db GFX_4B>>0
    db GFX_4C>>0
    db GFX_4D>>0
    db GFX_4E>>0
    db GFX_4F>>0
    db GFX_50>>0
    db GFX_51>>0
    db GFX_52>>0
    db GFX_53>>0
    db GFX_54>>0
    db GFX_55>>0
    db GFX_56>>0
    db GFX_57>>0
    db GFX_58>>0
    db GFX_59>>0
    db GFX_5A>>0
    db GFX_5B>>0
    db GFX_5C>>0
    db GFX_5D>>0
    db GFX_5E>>0
    db GFX_5F>>0
    db GFX_60>>0
    db GFX_61>>0
    db GFX_62>>0
    db GFX_63>>0
    db GFX_64>>0
    db GFX_65>>0
    db GFX_66>>0
    db GFX_67>>0
    db GFX_68>>0
    db GFX_69>>0
    db GFX_6A>>0
    db GFX_6B>>0
    db GFX_6C>>0
    db GFX_6D>>0
    db GFX_6E>>0
    db GFX_6F>>0
    db GFX_70>>0
    db GFX_DD>>0
    db GFX_DE>>0

    ; $0051B1 DATA LENGTH 0xDF
    .sprite_low
    db GFX_73>>0 ; 0x00
    db GFX_74>>0 ; 0x01
    db GFX_75>>0 ; 0x02
    db GFX_76>>0 ; 0x03
    db GFX_77>>0 ; 0x04
    db GFX_78>>0 ; 0x05
    db GFX_79>>0 ; 0x06
    db GFX_7A>>0 ; 0x07
    db GFX_7B>>0 ; 0x08
    db GFX_7C>>0 ; 0x09
    db GFX_7D>>0 ; 0x0A
    db GFX_7E>>0 ; 0x0B
    db GFX_7F>>0 ; 0x0C
    db GFX_80>>0 ; 0x0D
    db GFX_81>>0 ; 0x0E
    db GFX_82>>0 ; 0x0F
    db GFX_83>>0 ; 0x10
    db GFX_84>>0 ; 0x11
    db GFX_85>>0 ; 0x12
    db GFX_86>>0 ; 0x13
    db GFX_87>>0 ; 0x14
    db GFX_88>>0 ; 0x15
    db GFX_89>>0 ; 0x16
    db GFX_8A>>0 ; 0x17
    db GFX_8B>>0 ; 0x18
    db GFX_8C>>0 ; 0x19
    db GFX_8D>>0 ; 0x1A
    db GFX_8E>>0 ; 0x1B
    db GFX_8F>>0 ; 0x1C
    db GFX_90>>0 ; 0x1D
    db GFX_91>>0 ; 0x1E
    db GFX_92>>0 ; 0x1F
    db GFX_93>>0 ; 0x20
    db GFX_94>>0 ; 0x21
    db GFX_95>>0 ; 0x22
    db GFX_96>>0 ; 0x23
    db GFX_97>>0 ; 0x24
    db GFX_98>>0 ; 0x25
    db GFX_99>>0 ; 0x26
    db GFX_9A>>0 ; 0x27
    db GFX_9B>>0 ; 0x28
    db GFX_9C>>0 ; 0x29
    db GFX_9D>>0 ; 0x2A
    db GFX_9E>>0 ; 0x2B
    db GFX_9F>>0 ; 0x2C
    db GFX_A0>>0 ; 0x2D
    db GFX_A1>>0 ; 0x2E
    db GFX_A2>>0 ; 0x2F
    db GFX_A3>>0 ; 0x30
    db GFX_A4>>0 ; 0x31
    db GFX_A5>>0 ; 0x32
    db GFX_A6>>0 ; 0x33
    db GFX_A7>>0 ; 0x34
    db GFX_A8>>0 ; 0x35
    db GFX_A9>>0 ; 0x36
    db GFX_AA>>0 ; 0x37
    db GFX_AB>>0 ; 0x38
    db GFX_AC>>0 ; 0x39
    db GFX_AD>>0 ; 0x3A
    db GFX_AE>>0 ; 0x3B
    db GFX_AF>>0 ; 0x3C
    db GFX_B0>>0 ; 0x3D
    db GFX_B1>>0 ; 0x3E
    db GFX_B2>>0 ; 0x3F
    db GFX_B3>>0 ; 0x40
    db GFX_B4>>0 ; 0x41
    db GFX_B5>>0 ; 0x42
    db GFX_B6>>0 ; 0x43
    db GFX_B7>>0 ; 0x44
    db GFX_B8>>0 ; 0x45
    db GFX_B9>>0 ; 0x46
    db GFX_BA>>0 ; 0x47
    db GFX_BB>>0 ; 0x48
    db GFX_BC>>0 ; 0x49
    db GFX_BD>>0 ; 0x4A
    db GFX_BE>>0 ; 0x4B
    db GFX_BF>>0 ; 0x4C
    db GFX_C0>>0 ; 0x4D
    db GFX_C1>>0 ; 0x4E
    db GFX_C2>>0 ; 0x4F
    db GFX_C3>>0 ; 0x50
    db GFX_C4>>0 ; 0x51
    db GFX_C5>>0 ; 0x52
    db GFX_C6>>0 ; 0x53
    db GFX_C7>>0 ; 0x54
    db GFX_C8>>0 ; 0x55
    db GFX_C9>>0 ; 0x56
    db GFX_CA>>0 ; 0x57
    db GFX_CB>>0 ; 0x58
    db GFX_CC>>0 ; 0x59
    db GFX_CD>>0 ; 0x5A
    db GFX_CE>>0 ; 0x5B
    db GFX_CF>>0 ; 0x5C
    db GFX_D0>>0 ; 0x5D
    db GFX_D1>>0 ; 0x5E
    db GFX_D2>>0 ; 0x5F
    db GFX_D3>>0 ; 0x60
    db GFX_D4>>0 ; 0x61
    db GFX_D5>>0 ; 0x62
    db GFX_D6>>0 ; 0x63
    db GFX_D7>>0 ; 0x64
    db GFX_D8>>0 ; 0x65
    db GFX_D9>>0 ; 0x66
    db GFX_DA>>0 ; 0x67
    db GFX_DB>>0 ; 0x68
    db GFX_DC>>0 ; 0x69
    db GFX_DD>>0 ; 0x6A
    db GFX_DE>>0 ; 0x6B
}

; ==============================================================================

; $00521D-$005230 DATA
Pool_LoadItemGFX_offset:
{
    dw $0000 ; Rods
    dw $0108 ; Hammer
    dw $00C0 ; Bow
    dw $0390 ; Shovel
    dw $03F0 ; Zzz ♪
    dw $0438 ; Powder dust
    dw $0330 ; Hookshot
    dw $0048 ; Net
    dw $0318 ; Cane
    dw $0450 ; Book
}

; $005231-$0052BD LONG JUMP LOCATION
LoadItemGFXIntoWRAM4BPPBuffer:
{  
    PHB : PHK : PLB
    
    REP #$20
    
    STZ.b $0A : STZ.b $0C 
    
    LDA.w #$0480 : STA.b $06
    
    SEP #$20
    
    ; Load ice rod tiles?
    LDA.b #$07
    JSR.w LoadItemGFX
    
    ; Load fire rod tiles?
    LDA.b #$07
    JSR.w LoadItemGFX
    
    ; Load hammer tiles?
    LDA.b #$03
    JSR.w LoadItemGFX
    
    LDY.b #$5F
    LDA.b #$04
    JSR.w LoadItemGFX_arbitrary_sheet
    
    LDA.b #$03
    JSR.w LoadItemGFX_current_sheet
    
    LDA.b #$01
    JSR.w LoadItemGFX_current_sheet
    
    LDA.b #$04
    JSR.w LoadItemGFX
    
    LDY.b #$60
    LDA.b #$0E
    JSR.w LoadItemGFX_arbitrary_sheet
    
    LDA.b #$07
    JSR.w LoadItemGFX_current_sheet
    
    LDY.b #$5F
    LDA.b #$02
    JSR.w LoadItemGFX_arbitrary_sheet
    
    LDY.b #$54
    JSR.w Decomp_spr_low
    
    REP #$30
    
    LDA.b $00
    
    ; Skip ahead to write the push block sprite tiles.
    LDX.w #$1480
    
    PHA
    
    LDY.w #$0008
    
    JSR.w Do3To4HighAnimated_variable
    
    PLA : CLC : ADC.w #$0180
    
    LDY.w #$0008
    
    JSR.w Do3To4HighAnimated_variable
    
    SEP #$30
    
    LDY.b #$60
    
    JSL.l Decomp_spr_low
    
    REP #$30
    
    ; Target offset is $7EB280, convert 3 tiles (upper halves of animated rupee
    ; tiles).
    LDA.b $00
    LDX.w #$2280
    LDY.w #$0003
    
    PHA
    
    JSR.w Do3To4HighAnimated_variable
    
    PLA : CLC : ADC.w #$0180
    
    ; Convert 3 tiles again (lower halves of animated rupee tiles).
    LDY.w #$0003
    
    JSR.w Do3To4HighAnimated_variable
    
    SEP #$30
    
    JSR.w LoadItemGFX_Auxiliary
    
    PLB
    
    RTL
}

; ==============================================================================

; $0052BE-$0052C7 DATA
Pool_DecompressSwordGraphics:
{
    dw $0000 ; None
    dw $0000 ; Fighter sword
    dw $0120 ; Master sword
    dw $0120 ; Tempered sword
    dw $0120 ; Gold sword
}

; $0052C8-$0052FF LONG JUMP LOCATION
DecompSwordGfx:
{
    PHB : PHK : PLB
    
    LDY.b #$5F
    
    JSR.w Decomp_spr_high
    
    LDY.b #$5E
    
    JSR.w Decomp_spr_low
    
    REP #$21
    
    ; Load Link's sword value.
    LDA.l $7EF359 : AND.w #$00FF : ASL A : TAY
    
    LDA.b $00 : ADC.w Pool_DecompressSwordGraphics, Y
    
    REP #$10
    
    LDX.w #$0000
    LDY.w #$000C
    PHA
    
    JSR.w Do3To4HighAnimated_variable
    
    PLA : CLC : ADC.w : #$0180
    
    LDY.w #$000C
    
    JSR.w Do3To4HighAnimated_variable
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $005300-$005307 DATA
DecompressShieldGraphics_offset:
{
    dw $0660 ; None
    dw $0660 ; Fighter shield
    dw $06F0 ; Fire shield
    dw $0900 ; Mirror shield
}

; $005308-$005336 LONG JUMP LOCATION
DecompShieldGfx:
{
    PHB : PHK : PLB
    
    LDY.b #$5F
    JSR.w Decomp_spr_high
    
    LDY.b #$5E
    JSR.w Decomp_spr_low
    
    REP #$21
    
    ; Load Link's shield value.
    LDA.l $7EF35A : ASL A : TAY
    
    ; Load the index into $7E9000 to store the graphics to.
    LDA.b $00 : ADC.w .offset, Y

    REP #$10
    
    LDX.w #$0300
    
    PHA
    
    JSR.w Do3To4HighAnimated
    
    PLA : CLC : ADC.w #$0180
    
    JSR.w Do3To4HighAnimated
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; Decompress Animated Tiles for Dungeons.
; $005337-$005393 LONG JUMP LOCATION
DecompDungAnimatedTiles:
{
    PHB : PHK : PLB
    
    JSR.w Decomp_bg_low
    
    REP #$30
    
    ; Sets up animated tiles for the dungeons.
    LDA.b $00
    LDY.w #$0030
    LDX.w #$1680
    
    JSR.w Do3To4LowAnimated_variable
    
    SEP #$30
    
    LDY.b #$5C
    
    JSR.w Decomp_bg_low
    
    REP #$30
    
    ; Sets up the second half of the animated tiles for the dungeons.
    LDA.b $00
    LDY.w #$0030
    LDX.w #$1C80
    
    JSR.w Do3To4LowAnimated_variable
    
    LDX.w #$0000

    .loop

        LDA.l $7EA880, X : PHA
        
        LDA.l $7EAC80, X : STA.l $7EA880, X
        LDA.l $7EAE80, X : STA.l $7EAC80, X
        LDA.l $7EAA80, X : STA.l $7EAE80, X
        
        PLA : STA.l $7EAA80, X
    INX #2 : CPX.w #$0200 : BNE .loop
    
    ; This is the base address in VRAM for animated tiles.
    LDA.w #$3B00 : STA.w $0134
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; Decompress Animated Tiles for Overworld.
; Parameters: Y
; $005394-$0053C5 LONG JUMP LOCATION
DecompOwAnimatedTiles:
{
    PHB : PHK : PLB
    
    PHY
    
    JSR.w Decomp_bg_low
    
    REP #$30
    
    LDA.b $00
    LDY.w #$0040
    LDX.w #$1680
    
    JSR.w Do3To4LowAnimated_variable
    
    SEP #$30
    
    ; Decompress the next consecutive bg graphics pack (e.g. 0x44 -> 0x45).
    PLY : INY
    JSR.w Decomp_bg_low
    
    REP #$30
    
    LDA.b $00
    LDY.w #$0020
    LDX.w #$1E80
    
    JSR.w Do3To4LowAnimated_variable
    
    ; Set offset of animated tiles in VRAM to $3C00 (word).
    LDA.w #$3C00 : STA.w $0134
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $0053C6-$005406 LOCAL JUMP LOCATION
LoadItemGFX_Auxiliary:
{
    ; Loads blue / orange block, bird / thief's chest, and star animated tiles
    ; (in that order).
    LDY.b #$0F
    JSR.w Decomp_bg_low
    
    REP #$30
    
    LDA.b $00
    LDY.w #$0010
    LDX.w #$2340
    
    JSR.w Do3To4LowAnimated_variable
    
    SEP #$30
    
    LDY.b #$58
    JSR.w Decomp_spr_low
    
    REP #$30
    
    LDA.b $00
    LDY.w #$0020
    LDX.w #$2540
    
    JSR.w Do3To4LowAnimated_variable
    
    SEP #$30
    
    LDY.b #$05
    JSR.w Decomp_bg_low
    
    REP #$30
    
    LDA.b $00 : CLC : ADC.w #$0480
    
    LDY.w #$0002
    LDX.w #$2DC0
    JSR.w Do3To4LowAnimated_variable
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $005407-$005422 DATA
LoadFollowerGraphics_gfx_offset:
{
    dw $0000 ; 0x00 - No follower
    dw $0600 ; 0x01 - Zelda
    dw $0300 ; 0x02 - Old man that stops following you
    dw $0300 ; 0x03 - Unused old man
    dw $0300 ; 0x04 - Normal old man
    dw $0000 ; 0x05 - Zelda rescue telepathy
    dw $0000 ; 0x06 - Blind maiden
    dw $0900 ; 0x07 - Frogsmith
    dw $0600 ; 0x08 - Smithy
    dw $0600 ; 0x09 - Locksmith
    dw $0900 ; 0x0A - Kiki
    dw $0900 ; 0x0B - Unused old man
    dw $0600 ; 0x0C - Purple chest
    dw $0900 ; 0x0D - Super bomb
}

; Something of a tagalong graphics decompressor.
; $005423-$005468 LONG JUMP LOCATION
Tagalong_LoadGfx:
{
    PHB : PHK : PLB
    
    LDY.b #$64
    
    ;  If your tagalong is princess zelda...
    LDA.l $7EF3CC : CMP.b #$01 : BEQ .doDecomp
        LDY.b #$66
        
        ; #$09 = Creepy middle aged guy.
        ; If less than the middle aged guy.
        LDA.l $7EF3CC : CMP.b #$09 : BCC .doDecomp
            LDY.b #$59
            
            ; Otherwise if less then #$0C.
            CMP.b #$0C : BCC .doDecomp
                LDY.b #$58

    .doDecomp

    ; Zelda and anything else less than 0x0C.
    
    JSR.w Decomp_spr_high
    
    LDY.b #$65 ; Loads up graphics for the old man and maiden gfx.
    
    JSR.w Decomp_spr_low
    
    REP #$30
    
    LDA.l $7EF3CC : AND.w #$00FF : ASL A : TAX
    
    LDA.b $00 : CLC : ADC.l .gfx_offset, X
    
    LDY.w #$0020
    LDX.w #$2940
    JSR.w Do3To4LowAnimated_variable
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $005469-$0054DA DATA
GetAnimatedSpriteTile_offsets:
{
    dw $09C0, $0030, $0060, $0090, $00C0, $0300, $0318, $0330
    dw $0348, $0360, $0378, $0390, $0930, $03F0, $0420, $0450
    dw $0468, $0600, $0630, $0660, $0690, $06C0, $06F0, $0270
    dw $0750, $0768, $0900, $0930, $0960, $0990, $09F0, $0000
    dw $00F0, $0A20, $0A50, $0660, $0600, $0618, $0630, $0648
    dw $0678, $06D8, $06A8, $0708, $0738, $0768, $0960, $0900
    dw $03C0, $0990, $09A8, $09C0, $09D8, $0A08, $0A38, $0600
}

; Inputs:
; A - indexes into a table of offsets into $7E9000, X. This tells the game
; where in the animated tiles buffer ($7E9000) to place the decompressed tiles.
; More explicitly, the parameter passed to A tells us to grab a specific
; graphic, and this routine uses a table to know where to put it in the
; animated tiles buffer.
; $0054DB-$005536 LONG JUMP LOCATION
GetAnimatedSpriteTile:
{
    PHB : PHK : PLB
    
    PHA
    
    ; $00[3] = $7F4000
    STZ.b $00
    LDA.b #$40 : STA.b $01
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    BRA .copyToBuffer

    ; $0054ED ALTERNATE ENTRY POINT
    .variable

    ; Input for this is the same as the main entry point.
    
    PHB : PHK : PLB
    
    PHA
    
    LDY.b #$5D
    
    CMP.b #$23 : BEQ .firstSet
    CMP.b #$37 : BCS .firstSet
        LDY.b #$5C
        
        CMP.b #$0C : BEQ .secondSet
        CMP.b #$24 : BCS .secondSet
            ; This is the third possible graphics pack that could be loaded.
            LDY.b #$5B

        .secondSet
    .firstSet

    JSR.w Decomp_spr_high
    
    ; Always decompress spr graphics pack 0x5A into the low part of $7E4000.
    LDY.b #$5A
    
    JSR.w Decomp_spr_low

    .copyToBuffer

    ; Copy the decompressed tiles to the animated tiles buffer in WRAM.
    
    PLA
    
    REP #$21
    
    AND.w #$00FF : ASL A : TAX
    
    ; Time to determine where in the decompressed buffer the graphics will
    ; be copied from.
    LDA.b $00 : ADC.w .offsets, X
    
    REP #$10
    
    ; Target address is $7EBD40, convert 2 tiles.
    LDX.w #$2D40
    LDY.w #$0002
    PHA
    
    JSR.w Do3To4HighAnimated_variable
    
    ; Go to the next line.
    PLA : CLC : ADC.w #$0180
    
    ; Convert 2 tiles again.
    LDY.w #$0002
    
    JSR.w Do3To4HighAnimated_variable
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $005537-$005584 LOCAL JUMP LOCATION
LoadItemGFX:
{
    ; Parameters: A
    .sheet0
   
    STA.b $0A
    
    ; Will always load a pointer to sprite graphics pack 0.
    LDY.b #$00
    
    LDA.w GFXSheetPointers_sprite_bank, Y : STA.b $02 : STA.b $05
    LDA.w GFXSheetPointers_sprite_high, Y : STA.b $01
    LDA.w GFXSheetPointers_sprite_low, Y  : STA.b $00
    
    BRA .expandTo4bpp

    ; $00554E ALTERNATE ENTRY POINT
    .arbitrary_sheet

    PHA
    
    JSR.w Decomp_spr_low
    
    PLA

    ; $005553 ALTERNATE ENTRY POINT
    .current_sheet

    STA.b $0A
    
    ; $00[3] = $7F4000
    STZ.b $00
    LDA.b #$40 : STA.b $01
    LDA.b #$7F : STA.b $02 : STA.b $05

    .expandTo4bpp

    REP #$31
    
    LDY.b $0C
    
    LDA.b $00 : ADC.w .offset, Y
    
    LDX.b $06
    LDY.b $0A
    
    PHA
    
    JSR.w Do3To4HighAnimated_variable
    
    PLA : CLC : ADC.w #$0180
    
    LDY.b $0A
    
    JSR.w Do3To4HighAnimated_variable
    
    INC.b $0C : INC.b $0C
    
    STX.b $06
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $005585-$0055CA LOCAL JUMP LOCATION
; This "unpacks" animated tiles.
; Unused 3BPP to WRAM 4BPP routine.
UNREACHABLE_00D585:
{
    LDY.w #$0008 : STY.b $0E

    .nextTile

        STA.b $00 : CLC : ADC.w #$0010 : STA.b $03
        
        LDY.w #$0007

        .writeTile

            LDA [$00] : STA.l $7E9000, X : INC.b $00 : INC.b $00
            
            LDA [$03] : AND.w #$00FF : STA.l $7E9010, X : INC.b $03 : INX #2
        DEY : BPL .writeTile
        
        TXA : CLC : ADC.w #$0010 : TAX
        
        ; Not sure what the point of this is.
        LDA.b $03 : AND.w #$0078 : BNE .mystery
            LDA.b $03 : CLC : ADC.w #$0180 : STA.b $03

        .mystery

        LDA.b $03
    DEC.b $0E : BNE .nextTile
    
    RTS
}

; ==============================================================================

; Isn't this just another 3bpp to 4bpp converter? They have like 8 different
; routines for this. (update: they have at least 3). The main difference among
; them is the target address base. ($7E9000 instead of $7F0000, for example)
; $0055CB-$005618 LOCAL JUMP LOCATION
Do3To4LowAnimated:
{
    LDY.w #$0008
    
    ; $0055CE ALTERNATE ENTRY POINT
    .variable
    ; "variable" because the number of tiles it processes is variable.
    
    STY.b $0E

    .nextTile

        STA.b $00 : CLC : ADC.w #$0010 : STA.b $03
        
        LDY.w #$0003

        .writeTile
        
            LDA [$00] : STA.l $7E9000, X : INC.b $00 : INC.b $00
            LDA [$03] : AND.w #$00FF : STA.l $7E9010, X : INC.b $03 : INX #2
            
            LDA [$00] : STA.l $7E9000, X : INC.b $00 : INC.b $00
            LDA [$03] : AND.w #$00FF : STA.l $7E9010, X : INC.b $03 : INX #2
        DEY : BPL .writeTile
        
        TXA : CLC : ADC.w #$0010 : TAX
        
        LDA.b $03
    DEC.b $0E : BNE .nextTile
    
    RTS
}

; ==============================================================================

; Inputs:
; A - local portion of the pointer to the data to be converted.
; X - offset into the animated tile buffer of WRAM (0x7E9000).
; Y - Number of tiles to convert.
; $005619-$00566D LOCAL JUMP LOCATION
Do3To4HighAnimated:
{
    LDY.w #$0006

    ; $00561C Alternate Entry Point.
    .variable

    STY.b $0E

    .nextTile

        STA.b $00
        
        ; Addresses will be #$10 apart.
        CLC : ADC.w #$0010 : STA.b $03
        
        LDY.w #$0007

        .writeTile

            LDA [$00] : STA.l $7E9000, X
            XBA : ORA [$00] : AND.w #$00FF : STA.b $08 
            INC.b $00 : INC.b $00
            
            LDA [$03] : AND.w #$00FF : STA.b $BD
            ORA.b $08 : XBA : ORA.b $BD : STA.l $7E9010, X
            INC.b $03 : INX #2 
        DEY : BPL .writeTile
        
        TXA : CLC : ADC.w #$0010 : TAX
        
        LDA.b $03 : AND.w #$0078 : BNE .noAdjust
            ; Since we're most likely working with sprite gfx we have to adjust
            ; by 0x10 tiles to get to the next line.
            LDA.b $03 : CLC : ADC.w #$0180 : STA.b $03

        .noAdjust

        LDA.b $03
    DEC.b $0E : BNE .nextTile
    
    RTS
}

; ==============================================================================

; ZS Interupts this function. - ZS Custom Overworld
; $00566E-$0056F8 LONG JUMP LOCATION
LoadTransAuxGFX:
{
    PHB : PHK : PLB
    
    ; Setup the decompression buffer address.
    ; $00[3] = $7E6000
    STZ.b $00

    ; ZS writes a call here.
    ; $005673 - ZS Custom Overworld
    LDA.b #$60 : STA.b $01
    LDA.b #$7E : STA.b $02
    
    REP #$30
    ; $0E = $0AA2 * 4
    LDA.w $0AA2 : AND.w #$00FF : ASL #2 : STA.b $0E
    SEP #$20
    
    ; Sheet 3 (variable 0)
    LDX.b $0E
    LDA.w SheetsTable_0AA2_sheet0, X : BEQ .noBgGfxChange0
        STA.l $7EC2F8
        
        SEP #$10
        
        TAY
        
        JSR.w Decomp_bg_variable

    .noBgGfxChange0

    SEP #$10
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    REP #$10
    
    ; Sheet 4 (variable 1)
    LDX.b $0E
    LDA.w SheetsTable_0AA2_sheet1, X : BEQ .noBgGfxChange1
        STA.l $7EC2F9
        
        SEP #$10
        
        TAY
        
        JSR.w Decomp_bg_variable

    .noBgGfxChange1

    SEP #$10
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    REP #$10
    
    ; Sheet 5 (variable 2)
    LDX.b $0E
    LDA.w SheetsTable_0AA2_sheet2, X : BEQ .noBgGfxChange2
        STA.l $7EC2FA
        
        SEP #$10
        
        TAY
        
        JSR.w Decomp_bg_variable

    .noBgGfxChange2

    SEP #$10
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    REP #$10
    
    ; Sheet 6 (variable 4)
    LDX.b $0E
    LDA.w SheetsTable_0AA2_sheet3, X : BEQ .noBgGfxChange3
        STA.l $7EC2FB
        
        SEP #$10
        
        TAY
        
        JSR.w Decomp_bg_variable

    .noBgGfxChange3

    SEP #$10
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    BRA LoadTransAuxGFX_sprite_continue
}

; $0056F9-$005787 LONG JUMP LOCATION
LoadTransAuxGFX_sprite:
{
    PHB : PHK : PLB
    
    STZ.b $00
    LDA.b #$78 : STA.b $01
    LDA.b #$7E : STA.b $02

    ; $005706 ALTERNATE ENTRY POINT
    .continue

    REP #$30
    
    ; $0E = $0AA3 * 4
    LDA.w $0AA3 : AND.b #$00FF : ASL #2 : STA.b $0E
    
    SEP #$20
    
    LDX.b $0E
    
    LDA.w SheetsTable_0AA3_sheet0, X : BEQ .noSprGfxChange0
        STA.l $7EC2FC

    .noSprGfxChange0

    SEP #$10
    
    LDA.l $7EC2FC : TAY
    
    JSR.w Decomp_spr_variable
    
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    REP #$10
    
    LDX.b $0E
    
    LDA.w SheetsTable_0AA3_sheet1, X : BEQ .noSprGfxChange1
        STA.l $7EC2FD

    .noSprGfxChange1

    SEP #$10
    
    LDA.l $7EC2FD : TAY
    
    JSR.w Decomp_spr_variable
    
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    REP #$10
    
    LDX.b $0E
    
    LDA.w SheetsTable_0AA3_sheet2, X : BEQ .noSprGfxChange2
        STA.l $7EC2FE

    .noSprGfxChange2

    SEP #$10
    
    LDA.l $7EC2FE : TAY
    
    JSR.w Decomp_spr_variable
    
    ; Increment buffer address by 0x0600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    REP #$10
    
    LDX.b $0E
    
    LDA.w SheetsTable_0AA3_sheet3, X : BEQ .noSprGfxChange3
        STA.l $7EC2FF

    .noSprGfxChange3

    SEP #$10
    
    LDA.l $7EC2FF : TAY
    
    JSR.w Decomp_spr_variable
    
    STZ.w $0412
    
    PLB
    
    RTL
}

; ==============================================================================

; $005788-$00580D LONG JUMP LOCATION
ReloadPreviouslyLoadedSheets:
{
    PHB : PHK : PLB
    
    ; Target decompression address = $7E6000.
    ; Y = graphics pack to decompress.
    STZ   $00
    LDA.b #$60 : STA.b $01
    LDA.b #$7E : STA.b $02
    LDA   $7EC2F8 : TAY
    
    JSR.w Decomp_bg_variable
    
    ; Target decompression address = $7E6600.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDA.l $7EC2F9 : TAY
    
    JSR.w Decomp_bg_variable
    
    ; Target decompression address = $7E6C00.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDA.l $7EC2FA : TAY
    
    JSR.w Decomp_bg_variable
    
    ; Target decompression address = $7E7200.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDA.l $7EC2FB : TAY
    
    JSR.w Decomp_bg_variable
    
    ; Target decompression address = $7E7800.
    STZ.b $00
    LDA.b #$78 : STA.b $01
    LDA.b #$7E : STA.b $02
    LDA.l $7EC2FC : TAY
    
    JSR.w Decomp_spr_variable
    
    ; Target decompression address = $7E7E00.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDA.l $7EC2FD : TAY
    
    JSR.w Decomp_spr_variable
    
    ; Target decompression address = $7E8400.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDA.l $7EC2FE : TAY
    
    JSR.w Decomp_spr_variable
    
    ; Target decompression address = $7E8A00.
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDA.l $7EC2FF : TAY
    
    JSR.w Decomp_spr_variable
    
    STZ.w $0412
    
    PLB
    
    RTL
}

; ==============================================================================

; This routine decompresses graphics packs 0x67 and 0x68.
; Now the funny thing is that these are picture graphics for the intro
; (module 0x14).
; I at first thought they were the game's text.
; Graphics pack 0x68 is EMPTY, by the way.
; $00580E-$005836 LONG JUMP LOCATION
Attract_DecompressStoryGfx:
{
    PHB : PHK : PLB
    
    STZ.b $00
    
    LDA.b #$40 : STA.b $01
    
    ; $00[3] = 0x7F4000
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    LDA.b #$67 : STA.b $0E
    
    ; This loop decompresses sprite graphics packs 0x67 and 0x68.

    .loop

        LDY.b $0E
        
        JSR.w Decomp_spr_variable
        
        ; $00[3] = 0x7F4800; Set up the next transfer.
        LDA.b $01 : CLC : ADC.b #$08 : STA.b $01
        
        INC.b $0E
    LDA.b $0E : CMP.b #$69 : BNE .loop
    
    PLB
    
    RTL
}

; ==============================================================================

; $005837-$005854 Jump Table
; Overworld mirror warp gfx decompression.
Pool_AnimateMirrorWarp:
{
    ; $005837
    .vector_low
    db AnimateMirrorWarp_LoadPyramidIfAga>>0        ; $92
    db AnimateMirrorWarp_DecompressNewTileSets>>0   ; $FE
    db AnimateMirrorWarp_DecompressBackgroundsA>>0  ; $B9
    db AnimateMirrorWarp_DecompressBackgroundsB>>0  ; $F8
    db AnimateMirrorWarp_DecompressBackgroundsC>>0  ; $2C
    db AnimateMirrorWarp_TriggerOverlayA_2>>0       ; $A5
    db AnimateMirrorWarp_TriggerOverlayB>>0         ; $C7
    db AnimateMirrorWarp_DrawDestinationScreen>>0   ; $B3
    db AnimateMirrorWarp_DoSpritesPalettes>>0       ; $BB
    db AnimateMirrorWarp_TriggerOverlayB>>0         ; $C7
    db AnimateMirrorWarp_DecompressAnimatedTiles>>0 ; $D5
    db AnimateMirrorWarp_LoadSubscreen>>0           ; $63
    db AnimateMirrorWarp_DecompressSpritesA>>0      ; $BB
    db AnimateMirrorWarp_DecompressSpritesB>>0      ; $1B
    db AnimateMirrorWarp_TriggerBGChar0>>0          ; $CF

    ; $005846
    .vector_high
    db AnimateMirrorWarp_LoadPyramidIfAga>>8        ; $58
    db AnimateMirrorWarp_DecompressNewTileSets>>8   ; $58
    db AnimateMirrorWarp_DecompressBackgroundsA>>8  ; $59
    db AnimateMirrorWarp_DecompressBackgroundsB>>8  ; $59
    db AnimateMirrorWarp_DecompressBackgroundsC>>8  ; $5A
    db AnimateMirrorWarp_TriggerOverlayA_2>>8       ; $58
    db AnimateMirrorWarp_TriggerOverlayB>>8         ; $58
    db AnimateMirrorWarp_DrawDestinationScreen>>8   ; $58
    db AnimateMirrorWarp_DoSpritesPalettes>>8       ; $58
    db AnimateMirrorWarp_TriggerOverlayB>>8         ; $58
    db AnimateMirrorWarp_DecompressAnimatedTiles>>8 ; $58
    db AnimateMirrorWarp_LoadSubscreen>>8           ; $5A
    db AnimateMirrorWarp_DecompressSpritesA>>8      ; $5A
    db AnimateMirrorWarp_DecompressSpritesB>>8      ; $5B
    db AnimateMirrorWarp_TriggerBGChar0>>8          ; $58

    ; $005855-$005863 DATA
    .next_tilemap
    db $00, $0E, $0F, $10, $11, $00, $00, $00
    db $00, $00, $00, $12, $13, $14, $00
}

; Sets up the two low bytes of the decompression target address (0x4000).
; The bank is determined in the subroutine that's called below.
; $005864-$005891 LONG JUMP LOCATION
AnimateMirrorWarp:
{
                 STZ.b $00
    LDA.b #$40 : STA.b $01
    
    LDX.w $0200
    
    LDA.l Pool_AnimateMirrorWarp_next_tilemap, X : STA.b $17 : STA.w $0710
    
    ; Determine which subroutine in the jump table to call.
    LDA.l Pool_AnimateMirrorWarp_vector_low, X  : STA.b $0E
    LDA.l Pool_AnimateMirrorWarp_vector_high, X : STA.b $0F
    
    LDX.b #$00
    
    ; Loads the different cliffs and trees and such for the DW? needs to be
    ; confirmed.
    LDA.b $8A : AND.b #$40 : BEQ .lightWorld
        LDX.b #$08

    .lightWorld

    INC.w $0200
    
    JMP ($000E) ; Use jump table at $5837
}

; ==============================================================================

; $005892-$0058A4 JUMP LOCATION (LONG)
AnimateMirrorWarp_LoadPyramidIfAga:
{
    INC.w $06BA : LDA.w $06BA : CMP.b #$20 : BEQ .ready
        STZ.w $0200
        
        RTL

    .ready

    ; Loads overworld exit data and animated tiles. Initialization, mostly.
    JSL.l SetTargetOverworldWarpToPyramid
    
    RTL
}

; ==============================================================================

; Load overlays and ... silence music? what?
; $0058A5-$0058B2 JUMP LOCATION (LONG)
AnimateMirrorWarp_TriggerOverlayA_2:
{
    JSL.l MirrorWarp_HandleCastlePyramidSubscreen
    
    DEC.b $11
    
    LDA.b #$0C : STA.b $17 : STA.w $0710
    
    RTL
}

; ==============================================================================

; $0058B3-$0058BA JUMP LOCATION (LONG)
AnimateMirrorWarp_DrawDestinationScreen:
{
    JSL.l Overworld_DrawScreenAtCurrentMirrorPosition
    
    INC.w $0710
    
    RTL
}

; ==============================================================================

; $0058BB-$0058C6 JUMP LOCATION (LONG)
AnimateMirrorWarp_DoSpritesPalettes:
{
    JSL.l MirrorWarp_LoadSpritesAndColors
    
    LDA.b #$0C : STA.b $17 : STA.w $0710
    
    RTL
}

; ==============================================================================

; $0058C7-$0058CE JUMP LOCATION (LONG)
AnimateMirrorWarp_TriggerOverlayB:
{
    LDA.b #$0D : STA.b $17 : STA.w $0710
    
    RTL
}

; ==============================================================================

; $0058CF-$0058D4 JUMP LOCATION (LONG)
AnimateMirrorWarp_TriggerBGChar0:
{
    LDA.b #$0E : STA.w $0200
    
    RTL
}

; ==============================================================================

; Updates animated tiles durring mirror warp. May have other uses.
; ZS replaces this whole function. - ZS Custom Overworld
; $0058D5-$0058ED JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressAnimatedTiles:
{
    LDY.b #$58
        
    ; Death mountain here denotes either the light world or the dark world
    ; version bitwise AND with 0xBF masks out the 0x40 bit.
    LDA.b $8A : AND.b #$BF
        
    CMP.b #$03 : BEQ .deathMountain
    CMP.b #$05 : BEQ .deathMountain
    CMP.b #$07 : BEQ .deathMountain
        LDY.b #$5A
    
    .deathMountain
    
    JSL.l DecompOwAnimatedTiles
        
    RTL
}

; ==============================================================================
    
; The next 4 tables are actually only 2 but the way the data is laid out is
; weird. These values are loaded from functios where if X = 0 we are in the LW
; and X = 8 if we are in the DW. So SheetsTable_Mirror and SheetsTable_0AA4
; will be read from in the LW and SheetsTable_Mirror2 and SheetsTable_0AA4_2 in
; the DW. So it was nice for them to lay it out this way so that they could
; still use the same 0 or 8 value for both tables but it makes the data ugly
; here.
; $0058EE-$0058F3 DATA
SheetsTable_Mirror:
{
    ; $0058EE
    .sheet0
    db $3A

    ; $0058EF
    .sheet1
    db $3B

    ; $0058F0
    .sheet2
    db $3C

    ; $0058F1
    .sheet3
    db $3D

    ; $0058F2
    .sheet4
    db $3E

    ; $0058F3
    .sheet5
    db $5B
}

; $0058F4-$0058F5 DATA
SheetsTable_0AA4:
{
    db $01
    db $5A
}

; $0058F6-$0058FB DATA
SheetsTable_Mirror_2:
{
    db $42
    db $43
    db $44
    db $45
    db $3F
    db $59
}

; $0058FC-$0058FD DATA
SheetsTable_0AA4_2:
{
    db $0B
    db $5A
}

; ==============================================================================

; ZS Overwrites part of this function. - ZS Custom Overworld
; Gets ready to decompress typical graphics...
; $0058FE-$0059B8 JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressNewTileSets:
{
    PHB : PHK : PLB
    
    PHX
    
    REP #$30
    
    ; $005904 ZS writes here. - ZS Custom Overworld
    LDA.w $0AA1 : AND.w #$00FF : ASL #3 : TAX
    LDA.w $0AA2 : AND.w #$00FF : ASL #2 : TAY
    
    SEP #$20
    
    LDA.w SheetsTable_0AA2_sheet0, Y : BNE .override0
        LDA.w SheetsTable_0AA1_sheet3, X

    .override0

    STA.l $7EC2F8
    
    LDA.w SheetsTable_0AA2_sheet1, Y : BNE .override1
        LDA.w SheetsTable_0AA1_sheet4, X

    .override1

    STA.l $7EC2F9
    
    LDA.w SheetsTable_0AA2_sheet2, Y : BNE .override2
        LDA.w SheetsTable_0AA1_sheet5, X

    .override2

    STA.l $7EC2FA
    
    LDA.w SheetsTable_0AA2_sheet3, Y : BNE .override3
        LDA.w SheetsTable_0AA1_sheet6, X

    .override3

    STA.l $7EC2FB
    
    REP #$20
    
    LDA.w $0AA3 : AND.w #$00FF : ASL #2 : TAY
    
    SEP #$20
    
    LDA.w SheetsTable_0AA3_sheet0, Y : BEQ .noChange0
        STA.l $7EC2FC

    .noChange0

    LDA.w SheetsTable_0AA3_sheet1, Y : BEQ .noChange1
        STA.l $7EC2FD

    .noChange1

    LDA.w SheetsTable_0AA3_sheet2, Y : BEQ .noChange2
        STA.l $7EC2FE

    .noChange2

    LDA.w SheetsTable_0AA3_sheet3, Y : BEQ .noChange3
        STA.l $7EC2FF

    .noChange3

    SEP #$10
    
    PLX
    
    ; $00597D ZS writes here. - ZS Custom Overworld
    LDA.l SheetsTable_Mirror_sheet1, X : STA.b $08
    LDA.l SheetsTable_Mirror_sheet0, X : TAY
    
    ; Apparently the low 16 bits of the source address are found elsewhere...
    LDA.b #$7F
    
    JSR.w Decomp_bg_variable_bank
    
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    LDY.b $08
    
    JSR.w Decomp_bg_variable
    
    PLB
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    REP #$31
    
    ; Source address is $7F4000, number of tiles is 0x0040, base target address
    ; is $7F0000.
    LDX.w #$0000
    LDY.w #$0040
    LDA.w #$4000
    
    JSR.w Do3To4High16Bit
    
    LDY.w #$0040
    LDA.b $03
    
    JSR.w Do3To4Low16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; ZS overwrites part of this function. - ZS Custom Overworld
; More decompression...
; $0059B9-$0059F7 JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressBackgroundsA:
{
    PHB : PHK : PLB
    
    ; $0059BC ZS writes here. - ZS Custom Overworld
    LDA.l SheetsTable_Mirror_sheet3, X : STA.b $08
    LDA.l SheetsTable_Mirror_sheet2, X : TAY
    
    LDA.b #$7F
    
    JSR.w Decomp_bg_variable_bank
    
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDY.b $08
    
    JSR.w Decomp_bg_variable
    
    PLB
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    REP #$31
    
    ; Source address is $7F4000, number of tiles is 0x0040, base target address
    ; is $7F0000.
    LDX.w #$0000
    LDY.w #$0040
    LDA.w #$4000
    
    JSR.w Do3To4Low16Bit
    
    LDY.w #$0040
    
    LDA.b $03
    
    JSR.w Do3To4High16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0059F8-$005A2B JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressBackgroundsB:
{
    PHB : PHK : PLB
    
    LDA.l $7EC2F9 : TAY
    
    LDA.b #$7F
    
    JSR.w Decomp_bg_variable_bank
    
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    LDA.l $7EC2FA : TAY
    
    JSR.w Decomp_bg_variable
    
    PLB
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    REP #$31
    
    ; Source address is $7F4000, number of tiles is 0x0080, base target address
    ; is $7F0000.
    LDX.w #$0000
    LDY.w #$0080
    LDA.w #$4000
    
    JSR.w Do3To4High16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; ZS Interupts this function. - ZS Custom Overworld
; $005A2C-$005A62 JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressBackgroundsC:
{
    PHB : PHK : PLB
    
    ; $005A2F ZS writes here. - ZS Custom Overworld
    LDA.l SheetsTable_Mirror_sheet5, X : STA.b $08
    LDA.l SheetsTable_Mirror_sheet4, X : TAY
    
    LDA.b #$7F
    
    JSR.w Decomp_bg_variable_bank
    
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    LDY.b $08
    
    JSR.w Decomp_bg_variable
    
    PLB
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    REP #$31
    
    ; Source address is $7F4000, number of tiles is 0x0080, base target address
    ; is $7F0000.
    LDX.w #$0000
    LDY.w #$0080
    LDA.w #$4000
    
    JSR.w Do3To4Low16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; ZS replaces this whole function. - ZS Custom Overworld
; The first half of this function enables or disables BG1 for subscreen overlay
; use depending on the area. The second half reloads global sprite #2 sheet
; (rock vs skulls, different bush gfx, fish vs bone fish, etc.) based on what
; world we are in.
; $005A63-$005ABA JUMP LOCATION (LONG)
AnimateMirrorWarp_LoadSubscreen:
{
    STZ.b $1D
        
    ; For areas with special overlays (fog, clouds, etc.) turn on BG1.
    LDA.b $8A  : BEQ .subscreen
    CMP.b #$70 : BEQ .subscreen
    CMP.b #$40 : BEQ .subscreen
    CMP.b #$5B : BEQ .subscreen
    CMP.b #$03 : BEQ .subscreen
    CMP.b #$05 : BEQ .subscreen
    CMP.b #$07 : BEQ .subscreen
    CMP.b #$43 : BEQ .subscreen
    CMP.b #$45 : BEQ .subscreen
    CMP.b #$47 : BNE .normal
        .subscreen
            LDA.b #$01 : STA.b $1D
    
    .normal
    
    PHB : PHK : PLB
    
    ; X = 0 for LW, 8 for DW
    LDA.l SheetsTable_0AA4, X : TAY
        
    ; Get the pointer for one of the 2 Global sprite #2 sheets.
    LDA.w GFXSheetPointers_sprite_low, Y  : STA.b $00
    LDA.w GFXSheetPointers_sprite_high, Y : STA.b $01
    LDA.w GFXSheetPointers_sprite_bank, Y : STA.b $02
    STA.b $05
        
    PLB
        
    REP #$31
        
    ; Source address is determined above, number of tiles is 0x0040, base
    ; target address is $7F0000.
    LDX.w #$0000
    LDY.w #$0040
        
    LDA.b $00
        
    ; Convert the gfx to 4bpp.
    JSR.w Do3To4High16Bit
        
    SEP #$30
        
    RTL
}

; ==============================================================================

; $005ABB-$005B1A JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressSpritesA:
{
    PHB : PHK : PLB
    
    LDA.l $7EC2FC : TAY
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    JSR.w Decomp_spr_variable
    
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    LDA.l $7EC2FD : TAY
    
    JSR.w Decomp_spr_variable
    
    PLB
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    REP #$31
    
    LDX.w #$0000
    LDY.w #$0040
    
    LDA.l $7EC2FC
    
    CMP.w #$0052 : BEQ .high
    CMP.w #$0053 : BEQ .high
    CMP.w #$005A : BEQ .high
    CMP.w #$005B : BNE .low
        .high

        LDA.w #$4000
        
        JSR.w Do3To4High16Bit
        
        BRA .lastGfxPack

    .low

    LDA.w #$4000
    
    JSR.w Do3To4Low16Bit

    .lastGfxPack

    LDY.w #$0040
    
    LDA.b $03
    
    JSR.w Do3To4Low16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $005B1B-$005B56 JUMP LOCATION (LONG)
AnimateMirrorWarp_DecompressSpritesB:
{
    PHB : PHK : PLB
    
    LDA.l $7EC2FE : TAY
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    JSR.w Decomp_spr_variable
    
    LDA.b $01 : CLC : ADC.b #$06 : STA.b $01
    
    LDA.l $7EC2FF : TAY
    
    JSR.w Decomp_spr_variable
    
    PLB
    
    LDA.b #$7F : STA.b $02 : STA.b $05
    
    REP #$31
    
    LDX.w #$0000
    LDY.w #$0080
    LDA.w #$4000
    
    JSR.w Do3To4Low16Bit
    
    SEP #$30
    
    JSL.l HandleFollowersAfterMirroring
    
    RTL
}

; ==============================================================================

; This is the "Sprites" blockset in the ZS Graphics Manager. This controls
; sheets C, D, E, and F which are the "variable" sprite sheets. These sheets
; can change from room to room or OW area to OW area. This table is indexed by
; $0AA3 * 4 (0x90 entries).
; $005B57-$005D96 DATA
SheetsTable_0AA3:
{
    ; $005B57
    .sheet0
    db $00 ; 0x00 sheet 0

    ; $005B58
    .sheet1
    db $49 ; 0x00 sheet 1

    ; $005B59
    .sheet2
    db $00 ; 0x00 sheet 2

    ; $005B5A
    .sheet3
    db $00 ; 0x00 sheet 3

    db $46, $49, $0C, $1D ; 0x01
    db $48, $49, $13, $1D ; 0x02
    db $46, $49, $13, $0E ; 0x03
    db $48, $49, $0C, $11 ; 0x04
    db $48, $49, $0C, $10 ; 0x05
    db $4F, $49, $4A, $50 ; 0x06
    db $0E, $49, $4A, $11 ; 0x07
    db $46, $49, $12, $00 ; 0x08
    db $00, $49, $00, $50 ; 0x09
    db $00, $49, $00, $11 ; 0x0A
    db $48, $49, $0C, $00 ; 0x0B
    db $00, $00, $37, $36 ; 0x0C
    db $48, $49, $4C, $11 ; 0x0D
    db $5D, $2C, $0C, $44 ; 0x0E
    db $00, $00, $4E, $00 ; 0x0F
    db $0F, $00, $12, $10 ; 0x10
    db $00, $00, $00, $4C ; 0x11
    db $00, $0D, $17, $00 ; 0x12
    db $16, $0D, $17, $1B ; 0x13
    db $16, $0D, $17, $14 ; 0x14
    db $15, $0D, $17, $15 ; 0x15
    db $16, $0D, $18, $19 ; 0x16
    db $16, $0D, $17, $19 ; 0x17
    db $16, $0D, $00, $00 ; 0x18
    db $16, $0D, $18, $1B ; 0x19
    db $0F, $49, $4A, $11 ; 0x1A
    db $4B, $2A, $5C, $15 ; 0x1B
    db $16, $49, $17, $1D ; 0x1C
    db $00, $00, $00, $15 ; 0x1D
    db $16, $0D, $17, $10 ; 0x1E
    db $16, $49, $12, $00 ; 0x1F
    db $16, $49, $0C, $11 ; 0x20
    db $00, $00, $12, $10 ; 0x21
    db $16, $0D, $00, $11 ; 0x22
    db $16, $49, $0C, $00 ; 0x23
    db $16, $0D, $4C, $11 ; 0x24
    db $0E, $0D, $4A, $11 ; 0x25
    db $16, $1A, $17, $1B ; 0x26
    db $4F, $34, $4A, $50 ; 0x27
    db $35, $4D, $65, $36 ; 0x28
    db $4A, $34, $4E, $00 ; 0x29
    db $0E, $34, $4A, $11 ; 0x2A
    db $51, $34, $5D, $59 ; 0x2B
    db $4B, $49, $4C, $11 ; 0x2C
    db $2D, $00, $00, $00 ; 0x2D
    db $5D, $00, $12, $59 ; 0x2E
    db $00, $00, $00, $00 ; 0x2F
    db $00, $00, $00, $00 ; 0x30
    db $00, $00, $00, $00 ; 0x31
    db $00, $00, $00, $00 ; 0x32
    db $00, $00, $00, $00 ; 0x33
    db $00, $00, $00, $00 ; 0x34
    db $00, $00, $00, $00 ; 0x35
    db $00, $00, $00, $00 ; 0x36
    db $00, $00, $00, $00 ; 0x37
    db $00, $00, $00, $00 ; 0x38
    db $00, $00, $00, $00 ; 0x39
    db $00, $00, $00, $00 ; 0x3A
    db $00, $00, $00, $00 ; 0x3B
    db $00, $00, $00, $00 ; 0x3C
    db $00, $00, $00, $00 ; 0x3D
    db $00, $00, $00, $00 ; 0x3E
    db $00, $00, $00, $00 ; 0x3F
    db $47, $49, $2B, $2D ; 0x40 - 0x00 for underworld
    db $46, $49, $1C, $52 ; 0x41 - 0x01 for underworld
    db $00, $49, $1C, $52 ; 0x42 - 0x02 for underworld
    db $5D, $49, $00, $52 ; 0x43 - 0x03 for underworld
    db $46, $49, $13, $52 ; 0x44 - 0x04 for underworld
    db $4B, $4D, $4A, $5A ; 0x45 - 0x05 for underworld
    db $47, $49, $1C, $52 ; 0x46 - 0x06 for underworld
    db $4B, $4D, $39, $36 ; 0x47 - 0x07 for underworld
    db $1F, $2C, $2E, $52 ; 0x48 - 0x08 for underworld
    db $1F, $2C, $2E, $1D ; 0x49 - 0x09 for underworld
    db $2F, $2C, $2E, $52 ; 0x4A - 0x0A for underworld
    db $2F, $2C, $2E, $31 ; 0x4B - 0x0B for underworld
    db $1F, $1E, $30, $52 ; 0x4C - 0x0C for underworld
    db $51, $49, $13, $00 ; 0x4D - 0x0D for underworld
    db $4F, $49, $13, $50 ; 0x4E - 0x0E for underworld
    db $4F, $4D, $4A, $50 ; 0x4F - 0x0F for underworld
    db $4B, $49, $4C, $2B ; 0x50 - 0x10 for underworld
    db $1F, $20, $22, $53 ; 0x51 - 0x11 for underworld
    db $55, $3D, $42, $43 ; 0x52 - 0x12 for underworld
    db $1F, $1E, $23, $52 ; 0x53 - 0x13 for underworld
    db $1F, $1E, $39, $3A ; 0x54 - 0x14 for underworld
    db $1F, $1E, $3A, $3E ; 0x55 - 0x15 for underworld
    db $1F, $1E, $3C, $3D ; 0x56 - 0x16 for underworld
    db $40, $1E, $27, $3F ; 0x57 - 0x17 for underworld
    db $55, $1A, $42, $43 ; 0x58 - 0x18 for underworld
    db $1F, $1E, $2A, $52 ; 0x59 - 0x19 for underworld
    db $1F, $1E, $38, $52 ; 0x5A - 0x1A for underworld
    db $1F, $20, $28, $52 ; 0x5B - 0x1B for underworld
    db $1F, $20, $26, $52 ; 0x5C - 0x1C for underworld
    db $1F, $2C, $25, $52 ; 0x5D - 0x1D for underworld
    db $1F, $20, $27, $52 ; 0x5E - 0x1E for underworld
    db $1F, $1E, $29, $52 ; 0x5F - 0x1F for underworld
    db $1F, $2C, $3B, $52 ; 0x60 - 0x20 for underworld
    db $46, $49, $24, $52 ; 0x61 - 0x21 for underworld
    db $21, $41, $45, $33 ; 0x62 - 0x22 for underworld
    db $1F, $2C, $28, $31 ; 0x63 - 0x23 for underworld
    db $1F, $0D, $29, $52 ; 0x64 - 0x24 for underworld
    db $1F, $1E, $27, $52 ; 0x65 - 0x25 for underworld
    db $1F, $20, $27, $53 ; 0x66 - 0x26 for underworld
    db $48, $49, $13, $52 ; 0x67 - 0x27 for underworld
    db $0E, $1E, $4A, $50 ; 0x68 - 0x28 for underworld
    db $1F, $20, $26, $53 ; 0x69 - 0x29 for underworld
    db $15, $00, $00, $00 ; 0x6A - 0x2A for underworld
    db $1F, $00, $2A, $52 ; 0x6B - 0x2B for underworld
    db $00, $00, $00, $00 ; 0x6C - 0x2C for underworld
    db $00, $00, $00, $00 ; 0x6D - 0x2D for underworld
    db $00, $00, $00, $00 ; 0x6E - 0x2E for underworld
    db $00, $00, $00, $00 ; 0x6F - 0x2F for underworld
    db $00, $00, $00, $00 ; 0x70 - 0x30 for underworld
    db $00, $00, $00, $00 ; 0x71 - 0x31 for underworld
    db $00, $00, $00, $00 ; 0x72 - 0x32 for underworld
    db $00, $00, $00, $00 ; 0x73 - 0x33 for underworld
    db $00, $00, $00, $00 ; 0x74 - 0x34 for underworld
    db $00, $00, $00, $00 ; 0x75 - 0x35 for underworld
    db $00, $00, $00, $00 ; 0x76 - 0x36 for underworld
    db $00, $00, $00, $00 ; 0x77 - 0x37 for underworld
    db $00, $00, $00, $00 ; 0x78 - 0x38 for underworld
    db $00, $00, $00, $00 ; 0x79 - 0x39 for underworld
    db $00, $00, $00, $00 ; 0x7A - 0x3A for underworld
    db $00, $00, $00, $00 ; 0x7B - 0x3B for underworld
    db $00, $00, $00, $00 ; 0x7C - 0x3C for underworld
    db $32, $00, $00, $08 ; 0x7D - 0x3D for underworld
    db $5D, $49, $00, $52 ; 0x7E - 0x3E for underworld
    db $55, $49, $42, $43 ; 0x7F - 0x3F for underworld
    db $61, $62, $63, $50 ; 0x80 - 0x40 for underworld
    db $61, $62, $63, $50 ; 0x81 - 0x41 for underworld
    db $61, $62, $63, $50 ; 0x82 - 0x42 for underworld
    db $61, $62, $63, $50 ; 0x83 - 0x43 for underworld
    db $61, $62, $63, $50 ; 0x84 - 0x44 for underworld
    db $61, $62, $63, $50 ; 0x85 - 0x45 for underworld
    db $61, $56, $57, $50 ; 0x86 - 0x46 for underworld
    db $61, $62, $63, $50 ; 0x87 - 0x47 for underworld
    db $61, $62, $63, $50 ; 0x88 - 0x48 for underworld
    db $61, $56, $57, $50 ; 0x89 - 0x49 for underworld
    db $61, $56, $63, $50 ; 0x8A - 0x4A for underworld
    db $61, $56, $57, $50 ; 0x8B - 0x4B for underworld
    db $61, $56, $33, $50 ; 0x8C - 0x4C for underworld
    db $61, $56, $57, $50 ; 0x8D - 0x4D for underworld
    db $61, $62, $63, $50 ; 0x8E - 0x4E for underworld
    db $61, $62, $63, $50 ; 0x8F - 0x4F for underworld
}

; This is the "Rooms" blockset in the ZS Graphics Manager. Also the Overworld
; GFX number. This controls sheets 3, 4, 5, and 6 which are the "variable"
; dungeon and overworld tile sheets which These sheets can change from room to
; room or OW area to OW area. This table is indexed by $0AA2 * 4 - (0x52
; entries).
; $005D97-$005EDE DATA
SheetsTable_0AA2:
{
    ; $005D97
    .sheet0
    db $06 ; 0x00 sheet 0

    ; $005D98
    .sheet1
    db $00 ; 0x00 sheet 1

    ; $005D99
    .sheet2
    db $1F ; 0x00 sheet 2

    ; $005D9A
    .sheet3
    db $18 ; 0x00 sheet 3

    db $08, $00, $22, $1B ; 0x01
    db $06, $00, $1F, $18 ; 0x02
    db $07, $00, $23, $1C ; 0x03
    db $07, $00, $21, $18 ; 0x04
    db $09, $00, $20, $19 ; 0x05
    db $0B, $00, $21, $1A ; 0x06
    db $0C, $00, $24, $19 ; 0x07
    db $08, $00, $22, $1B ; 0x08
    db $0C, $00, $25, $1B ; 0x09
    db $0C, $00, $26, $1B ; 0x0A
    db $0A, $00, $27, $1D ; 0x0B
    db $0A, $00, $28, $1E ; 0x0C
    db $0B, $00, $29, $16 ; 0x0D
    db $0D, $00, $2A, $18 ; 0x0E
    db $07, $00, $23, $1C ; 0x0F
    db $07, $00, $04, $05 ; 0x10
    db $07, $00, $04, $05 ; 0x11
    db $09, $00, $20, $1B ; 0x12
    db $09, $00, $2A, $17 ; 0x13
    db $0B, $00, $21, $1C ; 0x14
    db $09, $00, $20, $19 ; 0x15
    db $0B, $00, $21, $1A ; 0x16
    db $09, $00, $24, $1B ; 0x17
    db $08, $00, $22, $1B ; 0x18
    db $09, $00, $25, $1B ; 0x19
    db $09, $00, $26, $1B ; 0x1A
    db $0A, $00, $27, $1D ; 0x1B
    db $09, $00, $28, $1E ; 0x1C
    db $0C, $00, $29, $16 ; 0x1D
    db $0D, $00, $2A, $17 ; 0x1E
    db $72, $00, $2B, $5D ; 0x1F

    db $00, $00, $00, $00 ; 0x20
    db $00, $57, $4C, $00 ; 0x21
    db $00, $56, $4F, $00 ; 0x22
    db $00, $53, $4D, $00 ; 0x23
    db $00, $52, $49, $00 ; 0x24
    db $00, $55, $4A, $00 ; 0x25
    db $00, $53, $54, $00 ; 0x26
    db $00, $51, $4E, $00 ; 0x27
    db $00, $00, $00, $00 ; 0x28
    db $00, $50, $4B, $00 ; 0x29
    db $00, $53, $4D, $00 ; 0x2A
    db $00, $55, $54, $00 ; 0x2B
    db $00, $00, $00, $00 ; 0x2C
    db $00, $00, $00, $00 ; 0x2D
    db $00, $00, $00, $00 ; 0x2E
    db $00, $47, $48, $00 ; 0x2F
    db $00, $00, $00, $00 ; 0x30
    db $00, $57, $4C, $00 ; 0x31
    db $00, $56, $4F, $00 ; 0x32
    db $00, $53, $4D, $00 ; 0x33
    db $00, $52, $49, $00 ; 0x34
    db $00, $55, $4A, $00 ; 0x35
    db $00, $53, $54, $00 ; 0x36
    db $00, $51, $4E, $00 ; 0x37
    db $00, $00, $00, $00 ; 0x38
    db $00, $50, $4B, $00 ; 0x39
    db $00, $53, $00, $00 ; 0x3A
    db $00, $35, $36, $00 ; 0x3B
    db $00, $60, $34, $00 ; 0x3C
    db $00, $2B, $2C, $00 ; 0x3D
    db $00, $2D, $2E, $00 ; 0x3E
    db $00, $2F, $30, $00 ; 0x3F
    db $00, $37, $38, $00 ; 0x40
    db $00, $33, $34, $00 ; 0x41
    db $00, $31, $32, $00 ; 0x42
    db $00, $00, $00, $00 ; 0x43
    db $00, $00, $00, $00 ; 0x44
    db $00, $00, $00, $00 ; 0x45
    db $00, $00, $00, $00 ; 0x46
    db $00, $00, $00, $00 ; 0x47
    db $00, $00, $00, $00 ; 0x48
    db $00, $00, $00, $00 ; 0x49
    db $00, $00, $00, $00 ; 0x4A
    db $00, $00, $00, $00 ; 0x4B
    db $00, $00, $00, $00 ; 0x4C
    db $00, $00, $00, $00 ; 0x4D
    db $00, $00, $00, $00 ; 0x4E
    db $00, $00, $00, $00 ; 0x4F
    db $72, $71, $72, $71 ; 0x50
    db $17, $40, $41, $39 ; 0x51
}

; ==============================================================================

; $005EDF-$005EFE DATA
Pool_Graphics_IncrementalVRAMUpload:
{
    ; $005EDF
    .VRAM_address_high
    db $50 ; VRAM $A000
    db $51 ; VRAM $A200
    db $52 ; VRAM $A400
    db $53 ; VRAM $A600
    db $54 ; VRAM $A800
    db $55 ; VRAM $AA00
    db $56 ; VRAM $AC00
    db $57 ; VRAM $AE00
    db $58 ; VRAM $B000
    db $59 ; VRAM $B200
    db $5A ; VRAM $B400
    db $5B ; VRAM $B600
    db $5C ; VRAM $B800
    db $5D ; VRAM $BA00
    db $5E ; VRAM $BC00
    db $5F ; VRAM $BE00
        
    ; $005EEF
    .buffer_address_high
    db $7F0000>>8 ; $50
    db $7F0200>>8 ; $51
    db $7F0400>>8 ; $52
    db $7F0600>>8 ; $53
    db $7F0800>>8 ; $54
    db $7F0A00>>8 ; $55
    db $7F0C00>>8 ; $56
    db $7F0E00>>8 ; $57
    db $7F1000>>8 ; $58
    db $7F1200>>8 ; $59
    db $7F1400>>8 ; $5A
    db $7F1600>>8 ; $5B
    db $7F1800>>8 ; $5C
    db $7F1A00>>8 ; $5D
    db $7F1C00>>8 ; $5E
    db $7F1E00>>8 ; $5F
}
    
; ==============================================================================

; $005EFF-$005F19 LONG JUMP LOCATION
Graphics_IncrementalVRAMUpload:
{
    LDX.w $0412 : CPX.b #$10 : BEQ .finished
        LDA.l Pool_Graphics_IncrementalVRAMUpload_VRAM_address_high, X
        STA.b $19
        
        STZ.w $0118
        
        LDA.l Pool_Graphics_IncrementalVRAMUpload_buffer_address_high, X
        STA.w $0119
        
        INC.w $0412

    .finished

    RTL
}

; ==============================================================================

; $005F1A-$005F4E LONG JUMP LOCATION
PrepTransAuxGFX:
{
    ; Prepares the transition graphics to be transferred to VRAM during NMI.
    ; This could occur either during this frame or any subsequent frame.
    
    ; Set bank for source address.
    LDA.b #$7E : STA.b $02 : STA.b $05
    
    REP #$31
    
    ; Source address is $7E6000, number of tiles is 0x40,
    ; base address is $7F0000.
    LDX.w #$0000
    LDY.w #$0040
    LDA.w #$6000
    
    ; The first graphics pack always uses the higher 8 palette values.
    JSR.w Do3To4High16Bit
    
    ; Number of tiles for next set is 0xC0.
    LDY.w #$00C0
    
    ; If this branch is taken, all 3 graphics packs will use the lower 8.
    ; palette values.
    LDA.w $0AA2 : AND.w #$00FF : CMP.w #$0020 : BCC .low
        ; $0AA2 >= 0x20, the first two graphics packs expand as high 8 palette
        ; values.
        LDY.w #$0080
        
        LDA.b $03
        
        JSR.w Do3To4High16Bit
        
        ; The last set will use the lower 8 palette values in this case.
        LDY.w #$0040

    .low

    LDA.b $03
    
    JSR.w Do3To4Low16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================


; TODO: Come up with a better lable. The main difference in this function as
; opposed to the Non-16bit version is that it stores to a buffer instead of
; directly into VRAM.
; Looks similar to Do3To4High, exept that it accepts more parameters.
; Inputs:
; A - Used to set the low 2 bytes of $00[3] - source address for
;     already decompressed data.
; Y - number of 3bpp tiles to convert to 4bpp (using only the higher 8
;     colors of the palette).
; X - a starting offset into $7F0000.
; $005F4F-$005FB7 LOCAL JUMP LOCATION
Do3To4High16Bit:
{
    STY.b $0C

    .nextTile

        STA.b $00 : CLC : ADC.w #$0010 : STA.b $03
        
        LDY.w #$0003

        .writeTile

            LDA [$00] : STA.l $7F0000, X
            XBA : ORA [$00] : AND.w #$00FF : STA.b $08
            INC.b $00 : INC.b $00
            
            LDA [$03] : AND.w #$00FF : STA.b $0A
            ORA.b $08 : XBA : ORA.b $0A : STA.l $7F0010, X
            INC.b $03 : INX #2
            
            LDA [$00] : STA.l $7F0000, X
            XBA : ORA [$00] : AND.w #$00FF : STA.b $08
            INC.b $00 : INC.b $00
            
            LDA [$03] : AND.w #$00FF : STA.b $0A
            ORA.b $08 : XBA : ORA.b $0A : STA.l $7F0010, X
            INC.b $03 : INX #2
        DEY : BPL .writeTile
        
        TXA : CLC : ADC.w #$0010 : TAX
        
        LDA.b $03
    DEC.b $0C : BNE .nextTile
    
    RTS
}

; ==============================================================================

; TODO: Come up with a better lable. The main difference in this function as
; opposed to the Non-16bit version is that it stores to a buffer instead of
; directly into VRAM.
; Very similar to Do3To4Low, except that the routine is completely
; standalone, and remains in 16-bit until after the routine is finished as
; well. (There are other differences).
; Inputs:
; A - Used to set the low 2 bytes of $00[3] - source address for already
;     decompressed data.
; Y - number of 3bpp tiles to convert to 4bpp (using only the lower 8
;     colors of the palette).
; X - a starting offset into $7F0000.
; $005FB8-$006030 LOCAL JUMP LOCATION
Do3To4Low16Bit:
{
    STY.b $0C

    .nextTile

        STA.b $00 : CLC : ADC.w #$0010 : STA.b $03
        
        LDY.w #$0001

        .nextHalf

            ; Each 12 bytes corresponds to half of the 24-byte 3bpp tile. The
            ; tile is being expanded from 3bpp to 4bpp, where it will use only
            ; the lower 8 colors of the palette.
            
            LDA [$00] : STA.l $7F0000, X : INC.b $00 : INC.b $00
            LDA [$03] : AND.w #$00FF : STA.l $7F0010, X : INC.b $03 : INX #2
            
            LDA [$00] : STA.l $7F0000, X : INC.b $00 : INC.b $00
            LDA [$03] : AND.w #$00FF : STA.l $7F0010, X : INC.b $03 : INX #2
            
            LDA [$00] : STA.l $7F0000, X : INC.b $00 : INC.b $00
            LDA [$03] : AND.w #$00FF : STA.l $7F0010, X : INC.b $03 : INX #2
            
            LDA [$00] : STA.l $7F0000, X : INC.b $00 : INC.b $00
            LDA [$03] : AND.w #$00FF : STA.l $7F0010, X : INC.b $03 : INX #2
        DEY : BPL .nextHalf
        
        TXA : CLC : ADC.w #$0010 : TAX
        
        LDA.b $03
    DEC.b $0C : BNE .nextTile
    
    RTS
}

; ==============================================================================
    
; $006031-$006072 LONG JUMP LOCATION
LoadNewSpriteGFXSet:
{
    LDA.b #$7E : STA.b $02 : STA.b $05
    
    REP #$31
    
    ; Source address is $7E7800, base target address is $7F0000,
    ; number of tiles is 0xC0.
    LDX.w #$0000
    LDA.w #$7800
    LDY.w #$00C0
    
    JSR.w Do3To4Low16Bit
    
    LDY.w #$0040
    
    ; Depending on which graphics pack it was, we decode from 3bpp to 4bpp
    ; using either the lowest 8 colors or the highest 8 colors in
    ; the palette.
    LDA.l $7EC2FF : AND.w #$00FF 
    
    CMP.w #$0052 : BEQ .high
    CMP.w #$0053 : BEQ .high
    CMP.w #$005A : BEQ .high
    CMP.w #$005B : BNE .low
        .high

        LDA.b $03
        
        JSR.w Do3To4High16Bit
        
        SEP #$30
        
        RTL

    .low

    LDA.b $03
    
    JSR.w Do3To4Low16Bit
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; Primary and default BG tilesets contains 0x25 8-byte entries indexed by
; $0AA1 *8. This is the "Main" blockset in the ZS GFX Manager. This controls
; sheets 0-7 of the dungeon and overworld tiles. 3-6 can be overwritten by the
; SheetsTable_0AA2 table room to room or area to area but 0, 1, 2 will stay the
; same. Sheet 7 will be overwritten by the "animated" sheet.
; $006073-$00619A
SheetsTable_0AA1:
{
    ; Underworld
    ; $006073
    .sheet0
    db $00 ; 0x00 sheet 0

    ; $006074
    .sheet1
    db $01 ; 0x00 sheet 1

    ; $006075
    .sheet2
    db $10 ; 0x00 sheet 2

    ; $006076
    .sheet3
    db $06 ; 0x00 sheet 3

    ; $006077
    .sheet4
    db $0E ; 0x00 sheet 4

    ; $006078
    .sheet5
    db $1F ; 0x00 sheet 5

    ; $006079
    .sheet6
    db $18 ; 0x00 sheet 6

    ; $00607A
    .sheet7
    db $0F ; 0x00 sheet 7

    db $00, $01, $10, $08, $0E, $22, $1B, $0F ; 0x01
    db $00, $01, $10, $06, $0E, $1F, $18, $0F ; 0x02
    db $00, $01, $13, $07, $0E, $23, $1C, $0F ; 0x03
    db $00, $01, $10, $07, $0E, $21, $18, $0F ; 0x04
    db $00, $01, $10, $09, $0E, $20, $19, $0F ; 0x05
    db $02, $03, $12, $0B, $0E, $21, $1A, $0F ; 0x06
    db $00, $01, $11, $0C, $0E, $24, $1B, $0F ; 0x07
    db $00, $01, $11, $08, $0E, $22, $1B, $0F ; 0x08
    db $00, $01, $11, $0C, $0E, $25, $1A, $0F ; 0x09
    db $00, $01, $11, $0C, $0E, $26, $1B, $0F ; 0x0A
    db $00, $01, $14, $0A, $0E, $27, $1D, $0F ; 0x0B
    db $00, $01, $11, $0A, $0E, $28, $1E, $0F ; 0x0C
    db $02, $03, $12, $0B, $0E, $29, $16, $0F ; 0x0D
    db $00, $01, $15, $0D, $0E, $2A, $18, $0F ; 0x0E
    db $00, $01, $10, $07, $0E, $23, $1C, $0F ; 0x0F
    db $00, $01, $13, $07, $0E, $04, $05, $0F ; 0x10
    db $00, $01, $13, $07, $0E, $04, $05, $0F ; 0x11
    db $00, $01, $10, $09, $0E, $20, $1B, $0F ; 0x12
    db $00, $01, $10, $09, $0E, $2A, $17, $0F ; 0x13
    db $02, $03, $12, $0B, $0E, $21, $1C, $0F ; 0x14

    db $00, $08, $11, $1B, $22, $2E, $5D, $5B ; 0x15
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x16
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x17

    ; Overworld
    ; $006133
    db $3A, $3B, $3C, $3D, $53, $4D, $3E, $5B ; 0x18 LW and SW 2
    db $42, $43, $44, $45, $20, $2B, $3F, $5D ; 0x19 DW 2
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x1A
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x1B
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x1C
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x1D
    db $00, $08, $10, $18, $20, $2B, $5D, $5B ; 0x1E
    db $71, $72, $71, $72, $20, $2B, $5D, $5B ; 0x1F
    db $3A, $3B, $3C, $3D, $53, $4D, $3E, $5B ; 0x20 LW and SW
    db $42, $43, $44, $45, $20, $2B, $3F, $59 ; 0x21 DW
    db $00, $72, $71, $72, $20, $2B, $5D, $0F ; 0x22
    db $16, $39, $1D, $17, $40, $41, $39, $1E ; 0x23
    db $00, $46, $39, $72, $40, $41, $39, $0F ; 0x24 Triforce Room
}

; ==============================================================================

; Summary of this routine:
; Uses $0AA4 to load the sprite graphics for misc. items.
; Uses $0AA3 to load sprite graphics.
; ZS overwrites part of this function. - ZS Custom Overworld
; $00619B-$0062CF LONG JUMP LOCATION
InitTilesets:
{
    PHB : PHK : PLB
    
    ; Increment target VRAM address after each write to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Target address in VRAM is $4400 (word).
    STZ.w SNES.VRAMAddrReadWriteLow
    LDA.b #$44 : STA.w SNES.VRAMAddrReadWriteHigh
    
    JSR.w LoadCommonSprGfx
    
    REP #$30
    
    LDA.w $0AA3 : AND.w #$00FF : ASL #2 : TAY
    
    SEP #$20
    
    ; Only update the sprite sheets if the value is not 0. Meaning we will keep
    ; the sheet from the previous area/room.
    LDA.w SheetsTable_0AA3_sheet0, Y : BEQ .skipSprSlot0
        STA.l $7EC2FC

    .skipSprSlot0

    LDA.l $7EC2FC : STA.b $09
    
    LDA.w SheetsTable_0AA3_sheet1, Y : BEQ .skipSprSlot1
        STA.l $7EC2FD

    .skipSprSlot1

    LDA.l $7EC2FD : STA.b $08
    
    LDA.w SheetsTable_0AA3_sheet2, Y : BEQ .skipSprSlot2
        STA.l $7EC2FE

    .skipSprSlot2

    LDA.l $7EC2FE : STA.b $07
    
    LDA.w SheetsTable_0AA3_sheet3, Y : BEQ .skipSprSlot3
        STA.l $7EC2FF

    .skipSprSlot3

    LDA.l $7EC2FF : STA.b $06
    
    SEP #$10
    
    LDY.b $09
    
    ; This next section decompresses graphics to $7E7800, $7E7E00, $7E8400, and
    ; $7E8A00, successively. Note that these are all 0x600 bytes apart, the
    ; size of the typical 3bpp graphics pack.
    LDA.b #$7E : STA.b $02
    
    LDX.b #$78
    
    JSR.w LoadSprGfx
    
    LDY.b $08 : LDX.b #$7E
    
    JSR.w LoadSprGfx
    
    LDY.b $07 : LDX.b #$84
    
    JSR.w LoadSprGfx
    
    LDY.b $06 : LDX.b #$8A
    
    JSR.w LoadSprGfx
    
    REP #$30
    
    ; This is the address for BG0 and BG1's graphics (Not tilemap, actual
    ; graphics).
    LDA.w #$2000 : STA.w SNES.VRAMAddrReadWriteLow

    ; ZS starts writing here.
    ; $006221 - ZS Custom Overworld
    LDA.w $0AA1 : AND.w #$00FF : ASL #3 : TAY
    LDA.w $0AA2 : AND.w #$00FF : ASL #2 : TAX
    
    SEP #$20
    
    ; Based on the "Main" (SheetsTable_0AA1) and "Rooms" (SheetsTable_0AA2
    ; group sets, load the tile GFX for the next area.
    LDA.w SheetsTable_0AA1_sheet0, Y : STA.b $0D
    LDA.w SheetsTable_0AA1_sheet1, Y : STA.b $0C
    LDA.w SheetsTable_0AA1_sheet2, Y : STA.b $0B
    
    LDA.w SheetsTable_0AA2_sheet0, X : BNE .overrideDefaultBgSlot0
        LDA.w SheetsTable_0AA1_sheet3, Y

    .overrideDefaultBgSlot0

    STA.l $7EC2F8 : STA.b $0A
    
    LDA.w SheetsTable_0AA2_sheet1, X : BNE .overrideDefaultBgSlot1
        LDA.w SheetsTable_0AA1_sheet4, Y

    .overrideDefaultBgSlot1

    STA.l $7EC2F9 : STA.b $09
    
    LDA.w SheetsTable_0AA2_sheet2, X : BNE .overrideDefaultBgSlot2
        LDA.w SheetsTable_0AA1_sheet5, Y

    .overrideDefaultBgSlot2

    STA.l $7EC2FA : STA.b $08
    
    LDA.w SheetsTable_0AA2_sheet3, X : BNE .overrideDefaultBgSlot3
        LDA.w SheetsTable_0AA1_sheet6, Y

    .overrideDefaultBgSlot3

    STA.l $7EC2FB : STA.b $07
    
    LDA.w SheetsTable_0AA1_sheet7, Y : STA.b $06

    ; $006282 ZS Returns here. - ZS Custom Overworld
    
    SEP #$10
    
    LDA.b #$07 : STA.b $0F
    
    LDY.b $0D
    
    JSR.w LoadBgGFX
    
    DEC.b $0F
    
    LDY.b $0C
    
    JSR.w LoadBgGFX
    
    DEC.b $0F
    
    LDY.b $0B
    
    JSR.w LoadBgGFX
    
    DEC.b $0F
    
    LDY.b $0A : LDA.b #$7E : LDX.b #$60
    
    JSR.w LoadBgGFX_variable
    
    DEC.b $0F
    
    LDY.b $09 : LDA.b #$7E : LDX.b #$66
    
    JSR.w LoadBgGFX_variable
    
    DEC.b $0F
    
    LDY.b $08 : LDA.b #$7E : LDX.b #$6C
    
    JSR.w LoadBgGFX_variable
    
    DEC.b $0F
    
    LDY.b $07 : LDA.b #$7E : LDX.b #$72
    
    JSR.w LoadBgGFX_variable
    
    DEC.b $0F
    
    LDY.b $06
    
    JSR.w LoadBgGFX
    
    PLB
    
    RTL
}

; ==============================================================================

; $0062D0-$00633A LONG JUMP LOCATION
LoadDefaultGfx:
{    
    ; The subroutine loads some default sprite graphics into VRAM miscellaneous
    ; stuff really like blobs, signs, keys, etc probably just a holdover for
    ; the programmers to dick around with though it also does load the default
    ; graphics for the HUD, which is far more useful.
    PHB : PHK : PLB
    
    ; Increment VRAM target address when data is written to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; The long address at $00[3] is $10F000 = $87000 in ROM.
    LDA.w GFXSheetPointers_sprite_bank : STA.b $02
    LDA.w GFXSheetPointers_sprite_high : STA.b $01
    LDA.w GFXSheetPointers_sprite_low  : STA.b $00
    
    REP #$20

    ; Initial target VRAM address is $4000 (word).
    LDA.w #$4000 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; All in all, this loop writes 0x1000 bytes in total, or 0x800 words.
    LDY.b #$40

    .nextTile

        LDX.b #$0E

        .writeLowBitplanes

            ; Tiles are converted from 3bpp to 4bpp using only the latter 8
            ; palette entries (See Do3To4High).
            
            ; The values will be written in reverse order from how they are in
            ; memory.
            LDA [$00] : STA.w SNES.VRAMDataWriteLow
            XBA : ORA [$00] : AND.w #$00FF : STA.b $BF, X
            
            INC.b $00 : INC.b $00
        DEX #2 : BPL .writeLowBitplanes
        
        LDX.b #$0E

        .writeHighBitplanes

            LDA [$00] : AND.w #$00FF : STA.b $BD
            ORA.b $BF, X : XBA : ORA.b $BD : STA.w SNES.VRAMDataWriteLow
            INC.b $00
        DEX #2 : BPL .writeHighBitplanes
    DEY : BNE .nextTile

    ; Now that Link's graphics are in VRAM we'll next load the tiles for the
    ; HUD.
    
    LDA.w #$7000 : STA.w SNES.VRAMAddrReadWriteLow
    
    SEP #$20
    
    ; Load three 0x800 byte CHR sets for the HUD.
    ; The final slot will be occupied by textbox tiles.
    LDY.b #$6A

    JSR.w DecompAndDirectCopy

    LDY.b #$6B

    JSR.w DecompAndDirectCopy
    
    LDY.b #$69

    JSR.w DecompAndDirectCopy
    
    PLB

    RTL
}

; ==============================================================================

; $00633B-$00636C LOCAL JUMP LOCATION
DecompAndDirectCopy:
{
    ; Inputs:
    ; Y - graphics pack to decompress.
    ; Target VRAM address is determined by calling functions,
    ; decompresses a sprite gfx pack and directly copies it to VRAM.
    
    JSR.w Decomp_spr_low
    
    REP #$30
    
    LDX.w #$00FF
    
    ; Iterating $100 times multiplied by 4 word writes
    ; total bytes written = $800.
    .copyToVram

        ; Write the graphics we just decompressed into VRAM.
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
    DEX : BPL .copyToVram
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $00636D-$006383 LONG JUMP LOCATION
Attract_LoadBG3GFX:
{
    PHB : PHK : PLB
    
    ; Increment VRAM target address on writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; VRAM target address is $7800 (word).
                 STZ.w SNES.VRAMAddrReadWriteLow
    LDA.b #$78 : STA.w SNES.VRAMAddrReadWriteHigh
    
    LDY.b #$67
    
    JSR.w DecompAndDirectCopy
    
    PLB
    
    RTL
}

; ==============================================================================

; $006384-$006398 LONG JUMP LOCATION
Graphics_LoadCommonSprLong:
{
    PHB : PHK : PLB
    
    ; Writes to $2119 increment the VRAM target address.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Set initial VRAM target address to 0x4400 (word).
    STZ.w SNES.VRAMAddrReadWriteLow
    LDA.b #$44 : STA.w SNES.VRAMAddrReadWriteHigh
    
    JSR.w LoadCommonSprGfx
    
    PLB
    
    RTL
}

; ==============================================================================

; TODO: Decent name?
; Appears to write the mode 7 chr data to VRAM, however, it would be much
; faster to do this via DMA. in fact, in another place this operation is
; performed with dma, if I'm not mistaken.
; $006399-$0063D1 LONG JUMP LOCATION
CopyMode7Chr:
{
    ; Set source address bank to 0x18.
    LDA.b #$18 : STA.b $02
    
    ; Update VRAM address after writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; VRAM target address = $0000 (word).
    STZ.w SNES.VRAMAddrReadWriteLow : STZ.w SNES.VRAMAddrReadWriteHigh
    
    REP #$10
    
    ; Source address ($00[3]) is $18C000.
    LDY.w #$C000 : STY.b $00
    
    LDY.w #$0000

    ; This loop only updates the upper bytes of the VRAM addresses that are
    ; being written to.
    .writeChr
        
        LDA [$00], Y : STA.w SNES.VRAMDataWriteHigh : INY
        LDA [$00], Y : STA.w SNES.VRAMDataWriteHigh : INY
        LDA [$00], Y : STA.w SNES.VRAMDataWriteHigh : INY
        LDA [$00], Y : STA.w SNES.VRAMDataWriteHigh : INY
    CPY.w #$4000 : BNE .writeChr
    
    SEP #$10

    ; $0063D1 ALTERNATE ENTRY POINT
    .easyOut

    RTL
}

; ==============================================================================

; $0063D2-$0063F9 DATA
Pool_Graphics_LoadChrHalfSlot:
{
    ; Sprite packs to use, $01 indicates that $0aa4 will be used
    ; instead, btw.
    .sheet_id
    db $01 ; 0x74 - Overworld common
    db $01 ; 0x74 - Overworld common
    db $08 ; 0x7B - Intro
    db $08 ; 0x7B - Intro
    db $09 ; 0x7C - Unused
    db $09 ; 0x7C - Unused
    db $02 ; 0x75 - Ether
    db $02 ; 0x75 - Ether
    db $02 ; 0x75 - Ether
    db $02 ; 0x75 - Ether
    db $03 ; 0x76 - Bombos
    db $03 ; 0x76 - Bombos
    db $04 ; 0x77 - Quake
    db $04 ; 0x77 - Quake
    db $05 ; 0x78 - Game over
    db $05 ; 0x78 - Game over
    db $08 ; 0x7B - Intro
    db $08 ; 0x7B - Intro
    db $08 ; 0x7B - Intro
    db $08 ; 0x7B - Intro

    ; $0063E6
    .palette_id
    db $0A ; 0x74 - Overworld common
    db $FF ; 0x74 - Overworld common
    db $03 ; 0x7B - Intro
    db $FF ; 0x7B - Intro
    db $00 ; 0x7C - Unused
    db $FF ; 0x7C - Unused
    db $FF ; 0x75 - Ether
    db $FF ; 0x75 - Ether
    db $01 ; 0x75 - Ether
    db $FF ; 0x75 - Ether
    db $02 ; 0x76 - Bombos
    db $FF ; 0x76 - Bombos
    db $00 ; 0x77 - Quake
    db $FF ; 0x77 - Quake
    db $FF ; 0x78 - Game over
    db $FF ; 0x78 - Game over
    db $FF ; 0x7B - Intro
    db $FF ; 0x7B - Intro
    db $FF ; 0x7B - Intro
    db $FF ; 0x7B - Intro
}

; ==============================================================================

; Okay, so months later I'm back, and this seems to upload 0x20
; tiles to one of two locations in the sprite region of VRAM - 
; 0x4400 or 0x4600. Generally I guess you could say that it's designed
; to load "half slots" or half graphics packs.
; $0063FA-$0064E8 LONG JUMP LOCATION
Graphics_LoadChrHalfSlot:
{
    ; $AAA is 0, return.
    LDX.w $0AAA : BEQ CopyMode7Chr_easyOut
    
    PHB : PHK : PLB
    
    LDA.w Pool_Graphics_LoadChrHalfSlot_palette_id-1, X : BMI .negative
        STA.w $0AB1 ; $0AB1 can be derived from $0AAA.
        
        CPX.b #$01 : BNE .notSlot1
            ; As far as I can tell, this line is totally redundant. It should
            ; already be set to 0x0a (10 decimal).
            LDA.b #$0A : STA.w $0AB1
            
            LDA.b #$02 : STA.w $0AA9
            
            JSL.l Palette_MiscSprite
            
            ; Signal to update CGRAM this frame.
            INC.b $15
            
            BRA .loadGraphics

        .notSlot1

        LDA.b #$02 : STA.w $0AA9
        
        JSL.l Palette_MiscSpr_justSP6
        
        ; Signal to update CGRAM this frame.
        INC.b $15

    .negative

    .loadGraphics

    LDX.w $0AAA
    
    LDY.b #$44
    
    STZ.b $08 : STZ.b $09
    
    ; Toggle Even-Odd state of $0AAA.
    INC.w $0AAA
    
    ; Branch if the new value of $0AAA is even.
    LDA.w $0AAA : LSR A : BCC .even
        STZ.w $0AAA
        
        ; Check the previous value of $0AAA, before all the shenanigans.
        CPX.b #$12 : BEQ .specificValues
            LDA.b #$03 : STA.b $09
            
            LDY.b #$46
            
            CPX.b #$02 : BNE .specificValues
                ; TODO: Unknown usage.
                STZ.w $0112

        .specificValues
    .even

    STY.w $0116
    
    ; Graphics flag.
    LDA.b #$0B : STA.b $17
    
    LDY.w Pool_Graphics_LoadChrHalfSlot_sheet_id, X : CPY.b #$01 : BNE .dontUseDefault
        ; Just load the typical misc sprite graphics in this case.
        LDY.w $0AA4

    .dontUseDefault

    ; Y = sprite graphics pack to load. Note that decompression will not be
    ; occuring, just conversion to 4bpp from 3bpp.
    
    LDA.w GFXSheetPointers_sprite_bank, Y : STA.b $02 : STA.b $05
    LDA.w GFXSheetPointers_sprite_high, Y : STA.b $01
    LDA.w GFXSheetPointers_sprite_low, Y  : STA.b $00
    
    REP #$31
    
    LDY.w #$0020 : STY.b $0C ; $0C serves as a counter here.
    
    LDX.w #$0000
    
    LDA.b $00 : ADC.b $08

    .nextTile

        STA.b $00
        
        CLC : ADC.w #$0010 : BNE .notAtBankEdge
            LDA.w #$8000
            
            INC.b $05

        .notAtBankEdge

        STA.b $03
        
        LDY.w #$0007 ; In this case it seems obvious only 8 loops occur.

        .nextBitplane

            LDA [$00] : STA.l $7F1000, X
            XBA : ORA [$00] : AND.w #$00FF : STA.b $08 
            
            INC.b $00 : INC.b $00 : BNE .notAtBankEdge2
                LDA.b $03 : INC A : STA.b $00
                
                INC.b $02
                
                LDA.b $02 : STA.b $05

            .notAtBankEdge2

            LDA [$03] : AND.w #$00FF : STA.b $0A
            ORA.b $08 : XBA : ORA.b $0A : STA.l $7F1010, X
            
            INC.b $03 : BNE .notAtBankEdge3
                LDA.w #$8000 : STA.b $00
                LDA.w #$8010 : STA.b $03
                
                INC.b $02 : INC.b $05

            .notAtBankEdge3
        INX #2 : DEY : BPL .nextBitplane
            
        TXA : CLC : ADC.w #$0010 : TAX
        
        LDA.b $03
    
    ; This memory location holds a counter.
    DEC.b $0C : BNE .nextTile
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; 00$64E9-$006555 LONG JUMP LOCATION
LoadSelectScreenGfx:
{
    ; The base address for OAM data will be (2 << 14) = $8000 (byte) in VRAM.
    ; TOOD: ^ Unsure of this, anomie's document seems to contradict itself.
    LDA.b #$02 : STA.w SNES.OAMSizeAndDataDes
    
    ; The address in VRAM increments when $2119 is written.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; The intitial target address in VRAM is $5000 (word).
    STZ.w SNES.VRAMAddrReadWriteLow
    LDA.b #$50 : STA.w SNES.VRAMAddrReadWriteHigh
    
    PHB : PHK : PLB     
    
    ; Decompress sprite gfx pack 0x5E, which contains 0x40 tiles, and convert
    ; from 3bpp to 4bpp (high).
    LDY.b #$5E
    
    JSR.w Decomp_spr_low
    
    REP #$20
    
    LDY.b #$3F
    
    JSR.w Do3To4High
    
    ; Decompress sprite gfx pack 0x5F, which contains 0x40 tiles, and convert
    ; from 3bpp to 4bpp (high).
    LDY.b #$5F
    
    JSR.w Decomp_spr_low
    
    REP #$20
    
    LDY.b #$3F
    
    JSR.w Do3To4High
    
    ; Restore data bank.
    PLB
    
    ; ----------------------------------
    
    ; Set source data address bank to 0x0E.
    LDA.b #$0E : STA.b $02
    
    REP #$30
    
    ; Target VRAM address is $7000 (word).
    LDA.w #$7000 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; Set source data address to $0E8000.
    LDA.w #$8000 : STA.b $00
    
    LDX.w #$07FF

    ; Writes 0x800 words to VRAM (0x1000 bytes).
    .copyFont

        LDA [$00] : STA.w SNES.VRAMDataWriteLow
        
        INC.b $00 : INC.b $00
    DEX : BPL .copyFont
    
    SEP #$30
    
    ; ----------------------------------
    
    PHB : PHK : PLB
    
    ; Decompress spr graphics pack 0x6B and manually write it to VRAM address
    ; 0x7800 (word).
    LDY.b #$6B
    
    JSR.w Decomp_spr_low
    
    REP #$30
    
    LDX.w #$02FF
    
    ; Writes 0x300 words to VRAM (0x600 bytes).
    .copyOther2bpp

        LDA [$00] : STA.w SNES.VRAMDataWriteLow
        
        INC.b $00 : INC.b $00
    DEX : BPL .copyOther2bpp
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; Copies font graphics to VRAM (for BG3).
; $006556-$006582 LONG JUMP LOCATION
CopyFontToVram:
{
    ; Set name base table to VRAM $4000 (word).
    LDA.b #$02 : STA.w SNES.OAMSizeAndDataDes
    
    ; Increment on writes to $2119.
    LDA.b #$80 : STA.w SNES.VRAMAddrIncrementVal
    
    ; Set bank of the source address (see below).
    LDA.b #$0E : STA.b $02
    
    REP #$30
    
    ; VRAM target address is $7000 (word).
    LDA.w #$7000 : STA.w SNES.VRAMAddrReadWriteLow
    
    ; $00[3] = $0E8000 (offset for the font data).
    LDA.w #$8000 : STA.b $00
    
    ; Going to write 0x1000 bytes (0x800 words).
    LDX.w #$07FF
        
    .nextWord

        ; Read a word from the font data.
        LDA [$00] : STA.w SNES.VRAMDataWriteLow
        
        ; Increment source address by 2.
        INC.b $00 : INC.b $00
    DEX : BPL .nextWord
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; This function takes as its parameters:
; $01[1] - the high byte of the decompression target address.
; Y - the sprite graphics pack to decrompress.
; $006583-$006608 LOCAL / EXTERN_BRANCH
LoadSprGfx:
{
    STZ.b $00
    STX.b $01
    
    PHY
    
    JSR.w Decomp_spr_variable 
    
    REP #$20
    
    ; The graphics pack is assumed to contain 0x40 tiles (0x600 bytes).
    LDY.b #$3F
    
    ; Depending on which graphics pack we decompressed, convert from 3bpp to
    ; 4bpp using either the first 8 colors of the palette, or the second 8
    ; colors.
    PLX
    
    CPX.b #$52 : BEQ Do3To4High
    CPX.b #$53 : BEQ Do3To4High
    CPX.b #$5A : BEQ Do3To4High
    CPX.b #$5B : BEQ Do3To4High
    CPX.b #$5C : BEQ Do3To4High
    CPX.b #$5E : BEQ Do3To4High
    CPX.b #$5F : BEQ Do3To4High

    ; Write the graphics to VRAM using the 3bpp to 4bpp low technique
    ; (first 8 entries of the palette).
    JMP Do3To4Low
}

; ==============================================================================

; $0065AF-$006608 JUMP LOCATION
; Write graphics to VRAM using the 3bpp to 4bpp high technique (latter 8 entries
; of the palette).
Do3To4High:
{
    .nextTile

        LDX.b #$0E

        .writeLowBitplanes

            LDA [$00] : STA.w SNES.VRAMDataWriteLow
            XBA : ORA [$00] : AND.w #$00FF : STA.b $BF, X
            INC.b $00 : INC.b $00 : DEX #2
            
            LDA [$00] : STA.w SNES.VRAMDataWriteLow
            XBA : ORA [$00] : AND.w #$00FF : STA.b $BF, X
            INC.b $00 : INC.b $00
        DEX #2 : BPL .writeLowBitplanes
        
        LDX.b #$0E

        .writeHighBitplanes
            
            LDA [$00] : AND.w #$00FF : STA.b $BD
            ORA.b $BF, X : XBA : ORA.b $BD : STA.w SNES.VRAMDataWriteLow
            INC.b $00 : DEX #2
            
            LDA [$00] : AND.w #$00FF : STA.b $BD
            ORA.b $BF, X : XBA : ORA.b $BD : STA.w SNES.VRAMDataWriteLow
            INC.b $00
        DEX #2 : BPL .writeHighBitplanes
    DEY : BPL .nextTile
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; Inputs:
; $0F index of the graphics pack slot we're currently working on.
; $006609-$0066B6 LOCAL JUMP LOCATION
LoadBgGFX:
{
    ; Target decompression address is $7F4000.
    LDA.b #$7F
    LDX.b #$40

    ; Uses a variable source data address rather than the fixed one above.
    ; $00660D ALTERNATE ENTRY POINT
    .variable

    ; Going to decompress data to the address pointed at by [$00].
    STZ.b $00
    STX.b $01
    STA.b $02
    
    JSR.w Decomp_bg_variable
    
    REP #$20
    
    LDY.b #$3F
    
    LDX.w $0AA1 : CPX.b #$20 : BCC .typicalGfxPack
        LDX.b $0F
        
        CPX.b #$07 : BEQ Do3To4High
        CPX.b #$02 : BEQ Do3To4High
        CPX.b #$04 : BEQ Do3To4High
        CPX.b #$03 : BNE Do3To4Low
            .high

            JMP Do3To4High ; $00E5AF

    .typicalGfxPack

    LDX.b $0F : CPX.b #$04 : BCS .high
        ; There should be a JMP to Do3To4Low here...

        ; Bleeds into the next function.
}
  
; ==============================================================================
  
; Takes as input:
; Y - number of tiles to convert from 3bpp to 4bpp.
; $00[3] - source address of the already decompressed graphics.
; $00663C-$0066B6 JUMP LOCATION
Do3To4Low:
{
    .nextTile

        ; This whole routine writes $1000 or $800 bytes to VRAM.
        ; Do3To4Low( )
        
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        LDA [$00] : STA.w SNES.VRAMDataWriteLow : INC.b $00 : INC.b $00
        
        LDX.b #$01

        .writeHighBitplanes

            LDA [$00] : AND.w #$00FF : STA.w SNES.VRAMDataWriteLow : INC.b $00
            LDA [$00] : AND.w #$00FF : STA.w SNES.VRAMDataWriteLow : INC.b $00
            LDA [$00] : AND.w #$00FF : STA.w SNES.VRAMDataWriteLow : INC.b $00
            LDA [$00] : AND.w #$00FF : STA.w SNES.VRAMDataWriteLow : INC.b $00
        DEX : BPL .writeHighBitplanes
    ; Loops variable number of times, usually $80 or $40.
    DEY : BPL .nextTile
    
    SEP #$20
    
    RTS 
}

; ==============================================================================

; $0066B7-$00675B LOCAL JUMP LOCATION
LoadCommonSprGfx:
{
    ; Loads basic sprite graphics using $0AA4.
    ; Loads more sprite graphics using index #$06.
    LDY.w $0AA4
    
    LDA.w GFXSheetPointers_sprite_bank, Y : STA.b $02    
    LDA.w GFXSheetPointers_sprite_high, Y : STA.b $01
    LDA.w GFXSheetPointers_sprite_low, Y  : STA.b $00
    
    REP #$20
    
    LDY.b #$40

    .nextTile

        LDX.b #$0E

        .writeLowBitplanes

            LDA [$00] : STA.w SNES.VRAMDataWriteLow
            XBA : ORA [$00] : AND.w #$00FF : STA.b $BF, X
            INC.b $00 : INC.b $00 : DEX #2
            
            LDA [$00] : STA.w SNES.VRAMDataWriteLow
            XBA : ORA [$00] : AND.w #$00FF : STA.b $BF, X
            INC.b $00 : INC.b $00
        DEX #2 : BPL .writeLowBitplanes
        
        LDX.b #$0E

        .writeHighBitplanes

            LDA [$00] : AND.w #$00FF : STA.b $BD
            ORA.b $BF, X : XBA : ORA.b $BD : STA.w SNES.VRAMDataWriteLow
            INC.b $00 : DEX #2
            
            LDA [$00] : AND.w #$00FF : STA.b $BD
            ORA.b $BF, X : XBA : ORA.b $BD : STA.w SNES.VRAMDataWriteLow
            INC.b $00
        DEX #2 : BPL .writeHighBitplanes
    DEY : BNE .nextTile
    
    SEP #$20
    
    ; Are we in the trifoce opening mode?
    LDA.b $10 : CMP.b #$01 : BEQ .triforceMode
        ; 0x06 is a hardcoded sprite graphics pack for us to decompress.
        ; I forget what it contains for the moment...
        LDY.b #$06
        
        ; Determine the address of the data to directly convert from 3bpp to
        ; 4bpp.
        LDA.w GFXSheetPointers_sprite_bank, Y : STA.b $02
        LDA.w GFXSheetPointers_sprite_high, Y : STA.b $01
        LDA.w GFXSheetPointers_sprite_low, Y  : STA.b $00
        
        REP #$20
        
        ; Indicates that it contains 0x80 tiles.
        LDY.b #$7F
        
        JMP Do3To4Low

    .triforceMode

    STZ.b $0F
    
    ; I don't quite understand the significant of writing to $06...
    LDY.b #$5E : STY.b $06
    LDA.b #$7F : STA.b $02
    LDX.b #$40
    
    JSR.w LoadSprGfx
    
    ; I don't quite understand the significant of writing to $06...
    LDY.b #$5F : STY.b $06
    
    LDX.b #$40
        
    JSR.w LoadSprGfx
}

; ==============================================================================

; The infamous graphics decompression routine.
; $00675C-$006851 LOCAL JUMP LOCATION
Decomp:
{
    .spr_high

    ; Sprite (type 1) decompression routine.
    ; Target address will be $7F4600.
    STZ.b $00
    LDA.b #$46 : STA.b $01
    LDA.b #$7F
    
    BRA .spr_set_bank

    .spr_low

    ; Target address will be $7F4000.
    STZ.b $00
    LDA.b #$40 : STA.b $01
    LDA.b #$7F

    .spr_set_bank

    STA.b $02 : STA.b $05

    ; The caller sets the target address for the decompressed data with this
    ; version.
    .spr_variable

    ; Set $C8[3], the indirect long source address.
    LDA.w GFXSheetPointers_sprite_bank, Y : STA.b $CA
    LDA.w GFXSheetPointers_sprite_high, Y : STA.b $C9
    LDA.w GFXSheetPointers_sprite_low, Y  : STA.b $C8
    
    BRA .begin

    .bg_low

    ; Background (type 2) graphics decompression.
    
    ; $00[3] = $7F4000
    STZ.b $00
    LDA.b #$40 : STA.b $01
    LDA.b #$7F

    .bg_variable_bank

    STA.b $02 : STA.b $05

    ; $00678F ALTERNATE ENTRY POINT
    .bg_variable

    ; Type 2 graphics pointers (tiles).
    ; GetSrcTypeTwo( )
    
    ; Set $C8[3], the indirect long source address.
    LDA.w GFXSheetPointers_background_bank, Y : STA.b $CA
    LDA.w GFXSheetPointers_background_high, Y : STA.b $C9
    LDA.w GFXSheetPointers_background_low, Y  : STA.b $C8

    .begin

    REP #$10
    
    LDY.w #$0000

    .next_code

    JSR.w .get_next_byte
    
    ; #$FF signals to terminate the decompression.
    CMP.b #$FF : BNE .continue
        ; This is the termination point of the routine.
        SEP #$10
        
        RTS

    .continue

    STA.b $CD
    
    ; If all the upper 3 bits are set...
    ; [111]
    AND.b #$E0 : CMP.b #$E0 : BEQ .expanded
        PHA ; If not... then:
        
        ; Let's examine the byte again.
        LDA.b $CD
        
        REP #$20
        
        ; A is now between 0 and 31.
        AND.w #$001F
        
        BRA .normal

    .expanded

    ; Extracts bits 2-4 from $CD and push it to the stack.
    LDA.b $CD : ASL #3 : AND.b #$E0 : PHA
    
    ; Examine the byte again.
    ; Get the lower two bits.
    ; Shift this value to the upper byte of the Accumulator.
    LDA.b $CD : AND.b #$03 : XBA
    
    JSR.w .get_next_byte
    
    REP #$20

    .normal

    INC A ; A is between 1 and 32
    STA.b $CB ; $CB = R, the number of bytes to write.
    
    SEP #$20
    
    PLA : BEQ .nonrepeating ; CODE [000]
        ; CODES [101], [110], [100], and [111].
        BMI .copy
            ; CODE [001].
            ASL A : BPL .repeating
                ; CODE [010].
                ASL A : BPL .repeating_word
                    ; This counts as CODE [003].
                    JSR.w .get_next_byte
                    
                    LDX.b $CB

                    .increment_write

                        STA [$00], Y
                        
                        INC A
                        
                        INY
                    DEX : BNE .increment_write
                    
                    BRA .next_code

    ; CODE [000]
    .nonrepeating

        JSR.w .get_next_byte
        
        STA [$00], Y
        
        INY
        
        LDX.b $CB : DEX : STX.b $CB
    BNE .nonrepeating
    
    BRA .next_code

    ; CODE [001]
    .repeating

    JSR.w .get_next_byte
    
    LDX.b $CB

    .loop_back

        STA [$00], Y
        
        INY
    DEX : BNE .loop_back
    
    BRA .next_code

    .repeating_word

    JSR.w .get_next_byte
    
    XBA
    
    JSR.w .get_next_byte
    
    LDX.b $CB

    .more_bytes

        XBA : STA [$00], Y
        
        INY
        
        DEX : BEQ .out_of_bytes
            XBA : STA [$00], Y
            
            INY
    DEX : BNE .more_bytes

    .out_of_bytes

    JMP .next_code

    ; CODES [101], [110], [100]
    .copy

    JSR.w .get_next_byte
    
    XBA
    
    JSR.w .get_next_byte
    
    XBA : TAX

    .loop_back2:

        PHY : TXY
        
        LDA [$00], Y ; Load from the target array.
        TYX ; A value to copy later into the target array.
        PLY
        
        STA [$00], Y
        
        INY : INX
        
        REP #$20
    DEC.b $CB : SEP #$20 : BNE .loop_back2
    
    JMP .next_code

    .get_next_byte

    ; Loads a value from a long address stored at $C8.
    LDA [$C8]
    
    LDX.b $C8 : INX : BNE .no_bank_wrap
        LDX.w #$8000 ; LoROM banks range from 0x8000 to 0xFFFF.
        
        ; Roll the bank number because we've gone past the end of the last bank.
        INC.b $CA
    
    .no_bank_wrap
    
    STX.b $C8
    
    RTS
}

; ==============================================================================

; $006852-$00687F DATA
NULL_00E852:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; $006880-$00688B DATA
PaletteFilterColorAdd:
{
    ; $006880
    .red
    dw $FFFF, $0001

    ; $006884
    .green
    dw $FFE0, $0020

    ; $006888
    .blue
    dw $FC00, $0400
}

; $00688C-$00690B DATA
PaletteFilterColorMasks:
{
    dw $FFFF, $FFFF, $FFFE, $FFFF
    dw $7FFF, $7FFF, $7FDF, $FBFF
    dw $7F7F, $7F7F, $7DF7, $EFBF
    dw $7BDF, $7BDF, $77BB, $DDEF
    dw $7777, $7777, $6EDD, $BB77
    dw $6DB7, $6DB7, $5B6D, $B6DB
    dw $5B5B, $5B5B, $56B6, $AD6B
    dw $5555, $AD6B, $5555, $AAAB
    dw $5555, $5555, $2A55, $5555
    dw $2A55, $2A55, $294A, $5295
    dw $2525, $2525, $2492, $4925
    dw $1249, $1249, $1122, $4489
    dw $1111, $1111, $0844, $2211
    dw $0421, $0421, $0208, $1041
    dw $0101, $0101, $0020, $0401
    dw $0001, $0001, $0000, $0001
}

; ==============================================================================

; Color filtering routine.
; $00690C-$0069E3 LONG JUMP LOCATION
PaletteFilter:
{
    !color      = $04
    !bitFilter  = $0C
    
    SEP #$20
    
    ; Perform the filtering it $1A (frame counter) is even, but don't if it's
    ; odd.
    LDA.b $1A : LSR A : BCC .doFiltering
        RTL

    ; $006914 ALTERNATE ENTRY POINT
    .doFiltering

    REP #$30
    
    LDX.w #PaletteFilterColorMasks
    
    LDA.l $7EC007 : CMP.w #$0010 : BCC .alpha
        ; X = 0xE88E in this case. (darkening process).
        INX #2

    .alpha

    STX.b $B7
    
    AND.w #$000F : ASL A : TAX
    
    ; To avoid confusion, in this routine this does in fact load from bank $00.
    ; $0C will contain a 2-byte value that consists of a single bit.
    LDA.w DungeonMask, X : STA !bitFilter
    
    PHB : PHK : PLB
    
    ; This variable determines whether we're darkening or lightening the screen.
    LDA.l $7EC009 : TAX
    
    LDA.w PaletteFilterColorAdd_red, X   : STA.b $06
    LDA.w PaletteFilterColorAdd_green, X : STA.b $08
    LDA.w PaletteFilterColorAdd_blue, X  : STA.b $0A
    
    LDX.w #$0040
    
    ; Perform filtering on BP2-BP7, SP0-SP4, and SP6.
    JSR.w FilterColors
    
    ; At this point filter the background color the same way the subroutine
    ; does.
    LDA.l $7EC500 : STA !color
    
    ; Obtain the red bits of the color.
    LDA.l $7EC300 : AND.w #$001F : ASL #2 : TAY
    
    LDA ($B7), Y : AND !bitFilter : BNE .noRedFilter
        LDA !color : ADC.b $06 : STA !color

    .noRedFilter
    
    LDA.l $7EC300 : AND.w #$03E0 : LSR #3 : TAY
    
    LDA ($B7), Y : AND !bitFilter : BNE .noGreenFilter
        LDA !color : ADC.b $08 : STA !color

    .noGreenFilter

    LDA.l $7EC301 : AND.w #$007C : TAY
    
    LDA ($B7), Y : AND !bitFilter : BNE .noBlueFilter
        LDA !color : CLC : ADC.b $0A : STA !color

    .noBlueFilter

    LDA !color : STA.l $7EC500
    
    PLB
    
    LDA.l $7EC009 : BNE .lightening
        LDA.l $7EC007 : INC A : STA.l $7EC007
        CMP.l $7EC00B : BNE .stillFiltering
            .switchDirection

            ; We're going to switch the direction of the lightening / darkening
            ; process. If we were lightening we will now be darkening, or vice
            ; versa.
            
            LDA.l $7EC009 : EOR.w #$0002 : STA.l $7EC009
            
            LDA.w #$0000 : STA.l $7EC007
            
            SEP #$20

            INC.b $B0

        .stillFiltering
        
        SEP #$30
        
        ; Tells NMI to update the CGRAM from WRAM.
        INC.b $15
        
        RTL

    .lightening

    ; Screen is being ligthened rather than darkened.
    
    LDA.l $7EC007 : CMP.l $7EC00B : BEQ .switchDirection
        LDA.l $7EC007 : DEC A : STA.l $7EC007
        
        SEP #$30
        
        ; Tells NMI to update the CGRAM from WRAM.
        INC.b $15
        
        RTL
}

; ==============================================================================

; Performs color filtering on the palette data given a starting color, and
; counts up to color 0x1B0, skips sprite palette 5, then filters sprite
; palette 6, and skips sprite palette 7.
; Inputs:
; X - the starting index of the color to work with.
; $0069E4-$006A48 LOCAL JUMP LOCATION
FilterColors:
{
    .nextColor

        LDA.l $7EC500, X : STA !color
        
        LDA.l $7EC300, X : BEQ .color_is_pure_black
            ; Examine the red channel.
            AND.w #$001F : ASL #2 : TAY
            
            LDA ($B7), Y : AND !bitFilter : BNE .noRedFilter
                LDA !color : ADC.b $06 : STA !color

            .noRedFilter

            ; Examine the green channel.
            LDA.l $7EC300, X : AND.w #$03E0 : LSR #3 : TAY
                LDA ($B7), Y : AND !bitFilter : BNE .noGreenFilter

                LDA !color : ADC.b $08 : STA !color

            .noGreenFilter

            ; Examine the blue channel.
            LDA.l $7EC301, X : AND.w #$007C : TAY
                LDA ($B7), Y : AND !bitFilter : BNE .noBlueFilter
                
                LDA !color : CLC : ADC.b $0A : STA !color

            .noBlueFilter

            ; Write the adjusted color to the main palette memory.
            LDA !color : STA.l $7EC500, X

        .color_is_pure_black

        ; Skip sprite palette 5 (second half) for some strange reason?
        INX #2 : CPX.w #$01B0 : BCC .nextColor : BNE .dontSkipPalette
            TXA : CLC : ADC.w #$0010 : TAX

        .dontSkipPalette
    ; Stop at sprite palette 7 (SP-7).
    CPX.w #$01E0 : BNE .nextColor
    
    RTS
}

; ==============================================================================

; This routine and its companion routine below don't seem to be used in the
; game at all but they could potentially be used, they are finished
; products, it seems the key difference is that this routine doesn't skip
; SP5 and SP7, like the ones above do. This could be a "first draft" of
; what the final routine was originally designed to do.
; $006A49-$006AB5 LONG JUMP LOCATION
PaletteFilterUnused:
{
    REP #$30
    
    LDX.w #$E88C
    
    LDA.l $7EC007 : CMP.w #$0010 : BCC .firstHalf
        INX #2 

    .firstHalf
    
    STX.b $B7
    
    AND.w #$000F : ASL A : TAX
    
    LDA.w DungeonMask, X : STA.b $0C
    
    PHB : PHK : PLB
    
    LDA.l $7EC009 : TAX
    
    LDA.w PaletteFilterColorAdd_red, X   : STA.b $06
    LDA.w PaletteFilterColorAdd_green, X : STA.b $08
    LDA.w PaletteFilterColorAdd_blue, X  : STA.b $0A
    
    LDX.w #$0040
    LDA.w #$0200
    
    JSR.w FilterColorsEndpoint
    
    PLB
    
    LDA.l $7EC009 : BNE .lightening
        LDA.l $7EC007 : INC A : STA.l $7EC007
        CMP.l $7EC00B : BNE .stillFiltering
            .switchDirection

            LDA.l $7EC009 : EOR.w #$0002 : STA.l $7EC009
            
            LDA.w #$0000 : STA.l $7EC007
            
            SEP #$20
            
            INC.b $B0

        .stillFiltering

        SEP #$30
        
        INC.b $15
        
        RTL

    .lightening

    LDA.l $7EC007 : CMP.l $7EC00B : BEQ .switchDirection
    
    LDA.l $7EC007 : DEC A : STA.l $7EC007
    
    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; Similar to FilterColors, but it has a variable last color. Also doesn't
; skip SP5 or SP7.
; $006ACE-$006B28 LOCAL JUMP LOCATION
FilterColorsEndpoint:
{
    !lastColor = $0E
    
    STA.b !lastColor

    .nextColor

        LDA.l $7EC500, X : STA !color
        
        LDA.l $7EC300, X : BEQ .color_is_pure_black
            ; NOTE: Makes it a multiple of 4... hrm...
            AND.w #$001F : ASL #2 : TAY
            
            LDA ($B7), Y : AND !bitFilter : BNE .noRedFilter
                ; Adjust red content by +/- 1.
                LDA !color : CLC : ADC.b $06 : STA !color

            .noRedFilter

            ; NOTE: Also a multiple of 4.
            LDA.l $7EC300, X : AND.w #$03E0 : LSR #3 : TAY
            
            LDA ($B7), Y : AND !bitFilter : BNE .noGreenFilter
                ; Adjust green content by +/- 1.
                LDA !color : CLC : ADC.b $08 : STA !color

            .noGreenFilter

            ; \
            LDA.l $7EC301, X : AND.w #$007C : TAY
            
            LDA ($B7), Y : AND !bitFilter : BNE .noBlueFilter
                ; Adjust blue content by +/- 1.
                LDA !color : CLC : ADC.b $0A : STA !color
                
            .noBlueFilter

            LDA !color : STA.l $7EC500, X
        
        .color_is_pure_black
    INX #2 : CPX !lastColor : BNE .nextColor
    
    RTS
}

; ==============================================================================

; Zeroes out BP1 (first half) in the CGRAM buffer and sets $15 high
; so the NMI routine will update CGRAM.
; $006B29-$006B5D LONG JUMP LOCATION
Attract_ResetHudPalettes_4_and_5:
{
    REP #$20
    
    LDA.w #$0000
    
    STA.l $7EC520 : STA.l $7EC522 : STA.l $7EC524 : STA.l $7EC526
    STA.l $7EC528 : STA.l $7EC52A : STA.l $7EC52C : STA.l $7EC52E 
    
    ; Set the mosaic level to zero.
    STA.l $7EC007
    
    ; Going to be lightening the screen.
    LDA.w #$0002 : STA.l $7EC009
    
    SEP #$20
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; $006B5E-$006BC4 LONG JUMP LOCATION
PaletteFilterHistory:
{
    REP #$30
    
    LDX.w #$E88C
    
    LDA.l $7EC007 : CMP.w #$0010 : BCC .firstHalf
        INX #2

    .firstHalf

    STX.b $B7
    
    AND.w #$000F : ASL A : TAX
    
    ; Note that this access is a long address mode, unlike the others.
    LDA.l DungeonMask, X : STA.b $0C
    
    ; Equate banks.
    PHB : PHK : PLB
    
    LDA.l $7EC009 : TAX

    LDA.w PaletteFilterColorAdd_red, X   : STA.b $06
    LDA.w PaletteFilterColorAdd_green, X : STA.b $08
    LDA.w PaletteFilterColorAdd_blue, X  : STA.b $0A
    
    ; Going to just modify BP2.
    LDX.w #$0020
    LDA.w #$0030

    ; $006B98 ALTERNATE ENTRY POINT
    .doFiltering

    JSR.w FilterColorsEndpoint
    
    PLB
    
    LDA.l $7EC007 : INC A : STA.l $7EC007 : CMP.w #$001F : BNE .stillFiltering
        ; At this point the.
        LDA.w #$0000 : STA.l $7EC007
        
        LDA.l $7EC009 : EOR.w #$0002 : STA.l $7EC009 : BEQ .stillFiltering
            ; Tell attract mode to move on to the next 2bpp graphic.
            INC.b $27

    .stillFiltering

    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; TODO: This probably needs a better name.
; $006BC5-$006BF1 LONG JUMP LOCATION
PaletteFilter_WishPonds:
{
    ; Put BG2 on the subscreen? What?
    LDA.b #$02 : STA.b $1D
    
    ; Turn on color math on obj and backdrop.
    LDA.b #$30 : STA.b $9A
    
    BRA .continue

    ; $006BCF ALTERNATE ENTRY POINT
    .Crystal:

    LDA.b #$01 : STA.b $1D

    .continue

    ; TODO: Best guess, rename if turns out incorrect.
    ; $006BD3 ALTERNATE ENTRY POINT
    .InitTheEndSprite:

    REP #$20
    
    LDX.b #$0E
    LDA.w #$0000

    .zero_out_sp5

        ; Zeroes out sprite palette 5 for use with the pond of wishing (seems
        ; like).
    STA.l $7EC6A0, X : DEX #2 : BPL .zero_out_sp5
    
    STA.l $7EC007
    
    LDA.w #$0002 : STA.l $7EC009
    
    SEP #$20
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; $006BF2-$006C0C LONG JUMP LOCATION
Palette_Restore_SP5F:
{
    REP #$20
    
    LDX.b #$0E

    .copy_colors

        ; Copy colors from the auxiliary palette buffer's SP5F to the main
        ; palette buffer's SP5F.
        
        LDA.l $7EC4A0, X : STA.l $7EC6A0, X 
    DEX #2 : BPL .copy_colors
    
    SEP #$20
    
    STZ.b $1D
    
    ; Only the background participates in color addition.
    LDA.b #$20 : STA.b $9A
    
    INC.b $15
    
    ; $006C0C ALTERNATE ENTRY POINT
    .return

    RTL
}

; ==============================================================================

; $006C0D-$006C53 LONG JUMP LOCATION
Palette_Filter_SP5F:
{
    JSR.w .filter
    
    ; Now filter again!
    LDA.l $7EC007 : BEQ Palette_Restore_SP5F_return
        .filter

        REP #$30
        
        LDX.w #$E88C
        
        LDA.l $7EC007 : CMP.w #$0010 : BCC .first_half
            DEX #2

        .first_half

        STX.b $B7
        
        AND.w #$000F : ASL A : TAX
        
        LDA.l DungeonMask, X : STA !bitFilter
        
        PHB : PHK : PLB
        
        LDA.l $7EC009 : TAX

        LDA.w PaletteFilterColorAdd_red, X   : STA.b $06
        LDA.w PaletteFilterColorAdd_green, X : STA.b $08
        LDA.w PaletteFilterColorAdd_blue, X  : STA.b $0A
        
        LDX.w #$01A0
        LDA.w #$01B0
        
        JMP PaletteFilterHistory_doFiltering
}

; ==============================================================================

; $006C54-$006C78 BRANCH LOCATION
KholdstareShell_PaletteFiltering_initialize:
{
    REP #$20
    
    ; This loop copies auxiliary BP4_L to normal BP4_L.
    ; Note Although, to work properly, it ought to be copying BP5_L to
    ; BP5_L axuiliary.
    LDX.b #$0E

    .next_color

        LDA.l $7EC380, X : STA.l $7EC580, X
    DEX #2 : BPL .next_color
    
    LDA.w #$0000 : STA.l $7EC007 : STA.l $7EC009
    
    SEP #$20
    
    INC.b $15
    
    INC.b $B0
    
    RTL

    .disable_subscreen

    STZ.b $1D

    RTL
}

; ==============================================================================

; $006C79-$006CC3 LONG JUMP LOCATION
KholdstareShell_PaletteFiltering:
{
    LDA.b $B0 : BEQ .initialize
        JSL.l .do_filtering
        
        LDA.l $7EC007 : BEQ .disable_subscreen
            .do_filtering

            REP #$30
            
            LDX.w #$E88C
            
            LDA.l $7EC007 : CMP.w #$0010 : BCC .firstHalf
                INX #2

            .firstHalf

            STX.b $B7
            
            AND.w #$000F : ASL A : TAX
            
            ; Get 1 << (15 - i).
            LDA.l DungeonMask, X : STA !bitFilter
            
            PHB : PHK : PLB
            
            LDA.l $7EC009 : TAX

            LDA.w PaletteFilterColorAdd_red, X   : STA.b $06
            LDA.w PaletteFilterColorAdd_green, X : STA.b $08
            LDA.w PaletteFilterColorAdd_blue, X  : STA.b $0A
            
            LDX.w #$0080
            LDA.w #$0090
            
            JMP PaletteFilterHistory_doFiltering
}

; ==============================================================================

; $006CC4-$006CC9 DATA
Pool_PaletteFilter_Agahnim_palette_offsets:
{
    dw $0160, $0180, $01A0
}

; Input:
; X - index of the sprite to perform filtering for.
; Does palette filtering for Agahnim sprite and sprites when there's 2
; or three of him.
; $006CCA-$006D18 LONG JUMP LOCATION
PaletteFilter_Agahnim:
{
    PHX
    
    TXA : ASL A : TAX
    
    REP #$20
    
    LDA.l $7EC019, X : STA.l $7EC007
    LDA.l $7EC01F, X : STA.l $7EC009
    
    LDA.l .palette_offsets, X : STA.b $00
    
    ; Set upper limit of filtering? (non inclusive I assume).
    CLC : ADC.w #$0010 : STA.b $02
    
    REP #$10
    
    JSR.w AgahnimWarpShadowFilter_filter_one
    
    LDA.l $7EC007 : BEQ .done_filtering
        JSR.w AgahnimWarpShadowFilter_filter_one

    .done_filtering

    SEP #$30
    
    PLX
    PHX
    
    TXA : ASL A : TAX
    
    REP #$20
    
    LDA.l $7EC007 : STA.l $7EC019, X
    LDA.l $7EC009 : STA.l $7EC01F, X
    
    SEP #$20
    
    PLX
    
    ; Update the palette WRAM this frame.
    INC.b $15
    
    RTL
}

; ==============================================================================

; $006D19-$006D7B LOCAL JUMP LOCATION
AgahnimWarpShadowFilter_filter_one:
{
    LDY.w #$E88C
    
    LDA.l $7EC007 : CMP.w #$0010 : BCC .firstHalf
        INY #2

    .firstHalf

    STY.b $B7
    
    AND.w #$000F : ASL A : TAX
    
    LDA.l DungeonMask, X : STA !bitFilter
    
    PHB : PHK : PLB
    
    LDA.l $7EC009 : TAX

    LDA.w PaletteFilterColorAdd_red, X   : STA.b $06
    LDA.w PaletteFilterColorAdd_green, X : STA.b $08
    LDA.w PaletteFilterColorAdd_blue, X  : STA.b $0A
    
    LDX.b $00 : PHX
    
    LDA.b $02 : PHA
    
    JSR.w FilterColorsEndpoint
    
    PLA : STA.b $02
    
    PLX : STX.b $00
    
    PLB
    
    LDA.l $7EC007 : INC A : STA.l $7EC007
    CMP.w #$001F : BNE .notDoneFiltering
        LDA.w #$0000 : STA.l $7EC007
        
        ; Change the direction of the filtering (lightening vs. darkening).
        LDA.l $7EC009 : EOR.w #$0002 : STA.l $7EC009

    .notDoneFiltering

    RTS
}

; ==============================================================================

; $006D7C-$006DB0 LONG JUMP LOCATION
IntroLogoPaletteFadeIn:
{
    REP #$30
    
    LDX.w #$0100
    LDA.w #$01A0
    
    JSR.w RestorePaletteAdditive
    
    LDX.w #$00C0
    LDA.w #$0100
    
    BRA .BRANCH_1

    ; $006D8F ALTERNATE ENTRY POINT
    .IntroTitleCardPaletteFadeIn
    REP #$30
    
    LDX.w #$0040
    LDA.w #$00C0
    
    JSR.w RestorePaletteAdditive
    
    LDX.w #$0040
    LDA.w #$00C0

    .BRANCH_1

    JSR.w RestorePaletteAdditive
    
    SEP #$30
    
    LDA.l $7EC007 : DEC A : STA.l $7EC007
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; $006DB1-$006DC9 LONG JUMP LOCATION
PaletteFilter_Restore:
{
    REP #$30
    
    LDX.w #$00B0
    LDA.w #$00C0
    JSR.w RestorePaletteAdditive
    
    LDX.w #$00D0
    LDA.w #$00E0
    JSR.w RestorePaletteSubtractive
    
    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; Gradually changes the colors in the main buffer so that they match those
; in the auxiliary buffer by *increasing* the color values.
; $006DCA-$006E20 LOCAL JUMP LOCATION
RestorePaletteAdditive:
{
    STA.b $0E

    .nextColor

        LDA.l $7EC500, X : TAY 
        
              AND.w #$001F : STA.b $08
        TYA : AND.w #$03E0 : STA.b $0A
        TYA : AND.w #$7C00 : STA.b $0C
        
        LDA.l $7EC300, X : AND.w #$001F : CMP.b $08 : BEQ .redMatch
            TYA : CLC : ADC.w #$0001 : TAY

        .redMatch
        
        LDA.l $7EC300, X : AND.w #$03E0 : CMP.b $0A : BEQ .greenMatch
            TYA : CLC : ADC.w #$0020 : TAY

        .greenMatch

        LDA.l $7EC300, X : AND.w #$7C00 : CMP.b $05 : BEQ .blueMatch
            TYA : CLC : ADC.w #$0400 : TAY
            
        .blueMatch

        TYA : STA.l $7EC500, X
    INX #2 : CPX.b $0E : BNE .nextColor
    
    RTS
}

; ==============================================================================

; Gradually changes the colors in the main buffer so that they match those
; in the auxiliary buffer by *decreasing* the color values.
; $006E21-$006E77 JUMP LOCATION
RestorePaletteSubtractive:
{
    STA.b $0E

    .nextColor

        LDA.l $7EC500, X : TAY
        
        AND.w #$001F       : STA.b $08
        TYA : AND.w #$03E0 : STA.b $0A
        TYA : AND.w #$7C00 : STA.b $0C
        
        LDA.l $7EC300, X : AND.w #$001F : CMP.b $08 : BEQ .redMatch
            TYA : SEC : SBC.w #$0001 : TAY

        .redMatch

        LDA.l $7EC300, X : AND.w #$03E0 : CMP.b $0A : BEQ .greenMatch
            TYA : SEC : SBC.w #$0020 : TAY

        .greenMatch

        LDA.l $7EC300, X : AND.w #$7C00 : CMP.b $0C : BEQ .blueMatch
            TYA : SEC : SBC.w #$0400 : TAY

        .blueMatch

        TYA : STA.l $7EC500, X
    INX #2 : CPX.b $0E : BNE .nextColor
    
    RTS
}

; ==============================================================================

; $006E78-$006EDF JUMP LOCATION
; ZS intercepts this function. - ZS Custom Overworld
Palette_InitWhiteFilter:
{
    REP #$20
        
    LDX.b #$00
        
    LDA.w #$7FFF

    .whiteFill

        STA.l $7EC300, X : STA.l $7EC340, X
        STA.l $7EC380, X : STA.l $7EC3C0, X
        STA.l $7EC400, X : STA.l $7EC440, X
        STA.l $7EC480, X : STA.l $7EC4C0, X
    INX #2 : CPX.b #$40 : BNE .whiteFill
        
    LDA.l $7EC500 : STA.l $7EC540
        
    ; Start the filtering process, we're going to be lightening the screen too.
    LDA.w #$0000 : STA.l $7EC007
    LDA.w #$0002 : STA.l $7EC009
        
    ; ZS writes here.
    ; $006EBB - ZS Custom Overworld
    ; If we are warping from an area with the pyramid BG, set the BG color to
    ; transparent. This is done to prevent a case where the black transparent color
    ; is faded to white on top of the pyramid BG, resulting in a double faded
    ; effect on transparent tiles.
    LDA.b $8A : CMP.w #$001B : BNE .notHyruleCastle
        LDA.w #$0000
        STA.l $7EC300 : STA.l $7EC340 : STA.l $7EC500 : STA.l $7EC540

    .notHyruleCastle

    SEP #$20
        
    LDA.b #$08 : STA.w $06BB
                 STZ.w $06BA
        
    RTL
}

; ==============================================================================

; Seems to be used exclusively during the mirror sequence to gradually
; decompress graphics.
; $006EE0-$006EE6 BRANCH LOCATION (LONG)
MirrorGFXDecompress:
{
    JSL.l AnimateMirrorWarp

    ; $006EE4 ALTERNATE ENTRY POINT
    .return

    SEP #$30
    
    RTL
}

; ==============================================================================

; $006EE7-$006EF0 LONG JUMP LOCATION
MirrorWarp_RunAnimationSubmodules:
{
    DEC.w $06BB : BNE MirrorGFXDecompress
        LDA.b #$02 : STA.w $06BB

        ; Bleeds into the next function.
}

; $006EF1-$006F89 LONG JUMP LOCATION
PaletteFilter:
{
    .BlindingWhite

    REP #$30
        
    LDA.l $7EC009
        
    CMP.w #$00FF : BEQ MirrorGFXDecompress_return
        CMP.w #$0002 : BNE .alpha
            
            LDX.w #$0040 : LDA.w #$01B0
                
            JSR.w RestorePaletteAdditive
                
            LDX.w #$01C0
            LDA.w #$01E0
                
            JSR.w RestorePaletteAdditive
                
            BRA .PaletteFilter_StartBlindingWhite

        .alpha

        LDX.w #$0040
        LDA.w #$01B0
            
        JSR.w RestorePaletteSubtractive
            
        LDX.w #$01C0
        LDA.w #$01E0
            
        JSR.w RestorePaletteSubtractive

        ; $006F27 ALTERNATE ENTRY POINT
        .StartBlindingWhite

        LDA.l $7EC540 : STA.l $7EC500
            
        LDA.l $7EC009 : BNE .gamma
            LDA.l $7EC007 : INC A : STA.l $7EC007 : CMP.w #$0042 : BNE .delta
                LDA.w #$00FF : STA.l $7EC009
                    
                SEP #$20
                    
                LDA.b #$20 : STA.w $06BB

            .delta

            SEP #$30
                
            INC.b $15
                
            RTL

        .gamma

        LDA.l $7EC007 : INC A : STA.l $7EC007 : CMP.w #$001F : BNE .delta
            LDA.l $7EC009 : EOR.w #$0002 : STA.l $7EC009
                
            SEP #$30
                
            LDA.b $10 : CMP.b #$15 : BNE .epsilon
                STZ.w SNES.HDMAChannelEnable : STZ.b $9B
                    
                REP #$20
                    
                LDX.b #$3E : LDA.w #$0778
                    
                JSL.l Mirror_InitHdmaSettings_init_hdma_table
                    
                INC.b $15

            .epsilon

            RTL
}

; ==============================================================================

; $006F8A-$006F96 LONG JUMP LOCATION
PaletteFilter_BlindingWhiteTriforce:
{
    REP #$30
    
    LDX.w #$0040
    LDA.w #$0200
    
    JSR.w RestorePaletteAdditive
    
    BRA PaletteFilterStartBlindingWhite
}

; ==============================================================================

; Causes all the colors in the palette to saturate their blue component
; (saturated = 0x1F). This occurs first when you slip into a whirlpool.
; The routine below eliminates the nonblue components.
; $006F97-$00700B LONG JUMP LOCATION
WhirlpoolSaturateBlue:
{
    LDA.b $1A : LSR A : BCC .skipFrame
        REP #$30
        
        PHB : PHK : PLB
        
        LDX.w #$0040

        .nextColor

            LDA.l $7EC500, X : TAY
            
            AND.w #$7C00 : CMP.w #$7C00 : BEQ .fullBlue
                TYA : CLC : ADC.w #$0400 : TAY

            .fullBlue

            TYA : STA.l $7EC500, X
        INX #2 : CPX.w #$0200 : BNE .nextColor
        
        LDA.l $7EC540 : STA.l $7EC500
        
        PLB
        
        SEP #$20
        
        LDA.l $7EC007 : LSR A : BCS .noMosaicIncrease
            LDA.l $7EC011 : CLC : ADC.b #$10 : STA.l $7EC011

        ; $006FE0 ALTERNATE ENTRY POINT
        .noMosaicIncrease

        LDA.l $7EC007 : INC A : STA.l $7EC007 : CMP.b #$1F : BNE .notDone
            LDA.b #$00 : STA.l $7EC007
            
            INC.b $B0
            
            ; Set mosaic to full.
            LDA.b #$F0 : STA.l $7EC011

        .notDone
    .skipFrame

    SEP #$30
    
    LDA.b #$09 : STA.b $94
    
    LDA.l $7EC011 : ORA.b #$03 : STA.b $95
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; Cycles through all colors in the palette and decrements the red and green
; components of each color by one each frame.
; $00700C-$007049 LONG JUMP LOCATION
WhirlpoolIsolateBlue:
{
    REP #$30
    
    PHB : PHK : PLB
    
    LDX.w #$0040

    .nextColor

        LDA.l $7EC500, X : TAY : AND.w #$03E0 : BEQ .noGreen
            TYA : SEC : SBC.w #$0020 : TAY

        .noGreen

        TYA : AND.w #$001F : BEQ .noRed
            TYA : SEC : SBC.w #$0001 : TAY

        .noRed

        TYA : STA.l $7EC500, X
    INX #2 : CPX.w #$0200 : BNE .nextColor
    
    LDA.l $7EC540 : STA.l $7EC500
    
    PLB
    
    SEP #$20
    
    JMP WhirlpoolSaturateBlue_noMosaicIncrease
}

; ==============================================================================

; Restores the blue components in the palette colors to their original states.
; $00704A-$0070C6 LONG JUMP LOCATION
WhirlpoolRestoreBlue:
{
    LDA.b $1A : LSR A : BCC .skipFrame
        REP #$30
        
        PHB : PHK : PLB
        
        LDX.w #$0040

        .nextColor

            LDA.l $7EC300, X : AND.w #$7C00 : STA.b $00
            
            LDA.l $7EC500, X : TAY : AND.w #$7C00 : CMP.b $00 : EQ .blueMatch
                TYA : SEC : SBC.w #$0400 : TAY

            .blueMatch

            TYA : STA.l $7EC500, X
        INX #2 : CPX.w #$0200 : BNE .nextColor
        
        LDA.l $7EC540 : STA.l $7EC500
        
        PLB
        
        SEP #$20
        
        LDA.l $7EC007 : LSR A : BCS .noMosaicDecrease
            LDA.l $7EC011 : BEQ .noMosaicDecrease
                SEC : SBC.b #$10 : STA.l $7EC011

        .noMosaicDecrease

        LDA.l $7EC007 : INC A : STA.l $7EC007 : CMP.b #$1F : BNE .notDone
            LDA.b #$00 : STA.l $7EC007 : STA.l $7EC011
            
            INC.b $B0

        .notDone
    .skipFrame

    SEP #$30
    
    LDA.b #$09 : STA.b $94
    
    LDA.l $7EC011 : ORA.b #$03 : STA.b $95
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; Restores the red and green component levels of the palette's colors
; to their original levels from before we entered the whirlpool.
; $0070C7-$007131 LONG JUMP LOCATION
WhirlpoolRestoreRedGreen:
{
    REP #$30
    
    PHB : PHK : PLB
    
    LDX.w #$0040

    .nextColor

        LDA.l $7EC300, X : AND.w #$03E0 : STA.b $00
        LDA.l $7EC300, X : AND.w #$001F : STA.b $02
        
        LDA.l $7EC500, X : TAY
        
        AND.w #$03E0 : CMP.b $00 : BEQ .greenMatch
            TYA : CLC : ADC.w #$0020 : TAY

        .greenMatch

        TYA : AND.w #$001F : CMP.b $02 : BEQ .redMatch
            TYA : CLC : ADC.w #$0001 : TAY

        .redMatch

        TYA : STA.l $7EC500, X
    INX #2 : CPX.w #$0200 : BNE .nextColor
    
    LDA.l $7EC540 : STA.l $7EC500
    
    PLB
    
    SEP #$20
    
    LDA.l $7EC007 : INC A : STA.l $7EC007 : CMP.b #$1F : BNE .notDone
        LDA.b #$00 : STA.l $7EC007
        
        INC.b $B0

    .notDone

    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; $007132-$007168 BRANCH LOCATION
PaletteFilter_EasyOut:
{
    SEP #$30

    RTL
}

; $007135 ENTRY POINT LONG JUMP LOCATION
PaletteFilter_Restore_Strictly_Bg_Subtractive:
{
    REP #$30
    
    LDA.l $7EC009 : CMP.w #$00FF : BEQ PaletteFilter_EasyOut
        PHB : PHK : PLB
        
        LDX.w #$0040
        LDA.w #$0100
        
        JSR.w RestorePaletteSubtractive
        
        PLB
        
        LDA.l $7EC007 : INC A : STA.l $7EC007
        
        CMP.w #$0020 : BNE .not_finished
            LDA.w #$00FF : STA.l $7EC009
            
            STZ.b $1D

        ; $007164 ALTERNATE ENTRY POINT
        .not_finished

        SEP #$30
        
        INC.b $15
        
        RTL
}

; ==============================================================================

; $007169-$007182 LONG JUMP LOCATION
PaletteFilter_Restore_Strictly_Bg_Additive:
{
    REP #$30
    
    PHB : PHK : PLB
    
    LDX.w #$0040
    LDA.w #$0100
    
    JSR.w RestorePaletteAdditive
    
    PLB
    
    LDA.l $7EC007 : INC A : STA.l $7EC007
    
    BRA PaletteFilter_Restore_Strictly_Bg_Subtractive_not_finished
}

; ==============================================================================

; Increases the red component in the sprite palette of Trinexx, or one of
; his parts.
; $007183-$0071CE LONG JUMP LOCATION
PaletteFilter_IncreaseTrinexxRed:
{
    LDA.w $04BE : BNE .countdown
        REP #$20
        
        LDX.b #$00

        .nextColor

            LDA.l $7EC582, X : AND.w #$001F : CMP.w #$001F : BEQ .redMatch
                CLC : ADC.w #$0001

            .redMatch

            STA.b $00
            
            LDA.l $7EC582, X : AND.w #$FFE0 : ORA.b $00 : STA.l $7EC582, X
        INX #2 : CPX.b #$0E : BNE .nextColor

        ; $0071B1 ALTERNATE ENTRY POINT
        TrinexxFilterRed_continue:

        SEP #$20
        
        INC.b $15
        
        INC.w $04C0
        LDA.w $04C0 : CMP.b #$0C : BCS .finished
            LDA.b #$03 : STA.w $04BE

    ; $0071C4 ALTERNATE ENTRY POINT
    .countdown

    DEC.w $04BE
    
    RTL

    .finished

    STZ.w $04BE
    STZ.w $04C0
    
    RTL
}

; ==============================================================================

; $0071CF-$007206 LONG JUMP LOCATION
PaletteFilter_RestoreTrinexxRed:
{
    LDA.w $04BE : BNE IncreaseTrinexxRed_countdown
        REP #$20
        
        LDX.b #$00

        .nextColor

            LDA.l $7EC382, X : AND.w #$001F : STA.b $0C
            
            LDA.l $7EC582, X : AND.w #$001F : CMP.b $0C : BEQ .redMatch
                SEC : SBC.w #$0001

            .redMatch

            STA.b $00
            
            LDA.l $7EC582, X : AND.w #$FFE0 : ORA.b $00 : STA.l $7EC582, X
        INX #2 : CPX.b #$0E : BNE .nextColor
        
        BRA IncreaseTrinexxRed_finished
}

; ==============================================================================

; Increases the blue component of trinexx or one of his parts by one
; each time the routine is called.
; $007207-$007252 LONG JUMP LOCATION
PaletteFilter_IncreaseTrinexxBlue:
{
    LDA.w $04BF : BNE .countdown
        REP #$20
        
        LDX.b #$00

        .nextColor

            LDA.l $7EC582, X : AND.w #$7C00 : CMP.w #$7C00 : BEQ .blueMatch
                CLC : ADC.w #$0400

            .blueMatch

            STA.b $00
            
            LDA.l $7EC582, X : AND.w #$83FF : ORA.b $00 : STA.l $7EC582, X
        INX #2 : CPX.b #$0E : BNE .nextColor

        ; $007235 ALTERNATE ENTRY POINT
        TrinexxFilterBlue_continue:

        SEP #$20
        
        INC.b $15
        INC.w $04C1
        
        LDA.w $04C1 : CMP.b #$0C : BCS .finished
            LDA.b #$03 : STA.w $04BF

            ; $007248 ALTERNATE ENTRY POINT
            .countdown

            DEC.w $04BF
            
            RTL

    .finished

    STZ.w $04BF
    STZ.w $04C1
    
    RTL
}

; ==============================================================================

; $007253-$00728A LONG JUMP LOCATION
PaletteFilter_RestoreTrinexxBlue:
{
    LDA.w $04BF : BNE IncreaseTrinexxBlue_countdown
    
    REP #$20
    
    LDX.b #$00

    .nextColor

        LDA.l $7EC382, X : AND.w #$7C00 : STA.b $0C
        
        LDA.l $7EC582, X : AND.w #$7C00 : CMP.b $0C : BEQ .blueMatch
            SEC : SBC.w #$0400

        .blueMatch

        STA.b $00
        
        LDA.l $7EC582, X : AND.w #$83FF : ORA.b $00 : STA.l $7EC582, X
    INX #2 : CPX.b #$0E : BNE .nextColor
    
    BRA IncreaseTrinexxBlue_finished
}

; ==============================================================================

; $00728B-$007301 JUMP LOCATION
Spotlight:
{
    .close

    REP #$10
    
    LDY.w #$0000 : LDX.w #$007E
    
    BRA .setValues

    ; $007295 ALTERNATE ENTRY POINT
    .open

    REP #$10
    
    LDY.w #$0002 : LDX.w #$0000

    .setValues

    STY.w $067E 
    STX.w $067C
    
    STZ.w SNES.HDMAChannelEnable
    
    ; Target dma register is $2126 (WH0), Window 1 Left Position. $2127 (WH1)
    ; will also be written because of the mode. Indirect HDMA is being used as
    ; well. transfer mode is write two registers once, ($2126 / $2127).
    LDX.w #$2641
    STX.w DMA.6_TransferParameters : STX.w DMA.7_TransferParameters
    
    ; The source address of the indirect HDMA table.
    LDX.w #.hdma_table : STX.w DMA.6_SourceAddrOffsetLow
                         STX.w DMA.7_SourceAddrOffsetLow
    
    ; Source bank is bank $00.
    LDA.b #$00 : STA.w DMA.6_SourceAddrBank : STA.w DMA.7_SourceAddrBank
    LDA.b #$00 : STA.w DMA.6__DataBank      : STA.w DMA.7__DataBank
    
    ; Configure window mask settings.
    LDA.b #$33 : STA.b $96
    LDA.b #$03 : STA.b $97
    LDA.b #$33 : STA.b $98
    
    ; Cache screen designation information into temp variables.
    LDA.b $1C : STA.b $1E
    LDA.b $1D : STA.b $1F
    
    LDA.b $1B : BNE .indoors
        ; Set up fixed color add / sub value.
        LDA.b #$20 : STA.b $9C
        LDA.b #$40 : STA.b $9D
        LDA.b #$80 : STA.b $9E

    .indoors

    SEP #$10
    
    JSL.l ConfigureSpotlightTable
    
    ; Enable HDMA on channel 7 during the NMI of the next frame.
    LDA.b #$80 : STA.b $9B
    
    ; Set screen brightness to full.
    LDA.b #$0F : STA.b $13
    
    RTL

    .hdma_table
    dw $F8    ; Line count with repeat flag set.
    dw $1B00  ; Address of the data for the first 120 scanlines.
    db $F8    ; Line count with repeat flag set.
    dw $1BF0  ; Address of the data for the second 120 scanlines.
    db $00    ; Termination byte.
}
    
; ==============================================================================

; $007302-$007311 DATA
Pool_ConfigureSpotlightTable:
{
    ; Granularity of how much the spotlight expands or dilates each frame.
    ; $007302
    .delta_size
    dw -7,   7,   7,   7

    ; $00730A
    .goal
    dw  0, 126,  35, 126
}

; ==============================================================================

; $007312-$007426 LONG JUMP LOCATION
ConfigureSpotlightTable:
{
    PHB : PHK : PLB
    
    REP #$30
    
    ; $0E = (Link's Y coordinate - BG2VOFS mirror + 0x0C).
    ; $0674 = $0E - $067C
    LDA.b $20 : SEC : SBC.b $E8 : CLC : ADC.w #$000C : STA.b $0E
    SEC : SBC.w $067C : STA.w $0674
    
    LDA.b $0E : CLC : ADC.w $067C : STA.w $0676
    
    ; $0670 = (Link's X coordinate - BG2HOFS mirror + 0x08).
    LDA.b $22 : SEC : SBC.b $E2 : CLC : ADC.w #$0008 : STA.w $0670
    
    ; Temporary caching of this value?
    LDA.w $067C : STA.w $067A
    
    ; $06 = $0E << 1, check if >= 0xE0.
    LDA.b $0E : ASL A : STA.b $06 : CMP.w #$00E0 : BCS .largeEnough
        ; The length of the table must span at least 224 scanlines (0xE0).
        LDA.w #$00E0 : STA.b $06

    .largeEnough

    ; $0A = $06 - $0E, $04 = $0E - $0A = ( (2 * $0E) - $06 ).
    LDA.b $06 : SEC : SBC.b $0E : STA.b $0A
    LDA.b $0E : SEC : SBC.b $0A : STA.b $04

    ; $007361 ALTERNATE ENTRY POINT
    .next_check

    LDA.w #$00FF : STA.b $08
    
    LDA.b $06 : CMP.w $0676 : BCS .BRANCH_BETA
        LDA.w $067A : BEQ .BRANCH_GAMMA
            DEC.w $067A

        .BRANCH_GAMMA

        JSR.w IrisSpotlight_CalculateCircleValue

    .BRANCH_BETA

    LDA.b $04 : ASL A : CMP.w #$01C0 : BCS .BRANCH_DELTA
        TAX
        
        LDA.b $08 : STA.l $7F7000, X

    .BRANCH_DELTA

    LDA.b $06 : ASL A : CMP.w #$01C0 : BCS .BRANCH_EPSILON
        TAX
        
        LDA.b $08 : STA.l $7F7000, X

    .BRANCH_EPSILON

    LDA.b $0E : CMP.b $04 : BEQ .BRANCH_ZETA
        INC.b $04
        DEC.b $06
        
        JMP.w ConfigureSpotlightTable_next_check

    .BRANCH_ZETA

        LDA.w SNES.OAMReadDataLowHigh 
        LDA.w SNES.PPUStatusFlag2
    LDA.w SNES.VCounterData : AND.w #$00FF : CMP.w #$00C0 : BCC .BRANCH_ZETA
    
    LDX.w #$0000

    .copyTable

        LDA.l $7F7000, X : STA.w $1B00, X
    INX #2 : CPX.w #$01C0 : BCC .copyTable
    
    LDX.w $067E
    
    ; $067C = (+/-) 0x07, compare with either 0 or 0x7E.
    LDA.w $067C : CLC : ADC .delta_size, X : STA.w $067C
    
    CMP .goal, X : BNE .return
        SEP #$20
        
        LDA.w $067E : BNE .resetTable
            ; Enable forceblank.
            LDA.b #$80 : STA.b $13 : STA.w SNES.ScreenDisplay
            
            BRA .BRANCH_LAMBDA

        .resetTable

        JSL.l ResetSpotLightTable

        .BRANCH_LAMBDA

        SEP #$30
        
        STZ.b $B0 : STZ.b $11
        
        LDA.b $10
        
        CMP.b #$07 : BEQ .BRANCH_MU
        CMP.b #$10 : BNE .BRANCH_NU
            .BRANCH_MU

            LDA.b $1B : BNE .BRANCH_XI
                LDX.b $8A
                
                LDA.l $7F5B00, X : LSR #4 : STA.w $012D

            .BRANCH_XI

            LDA.w $0132 : CMP.b #$FF : BEQ .BRANCH_NU
                STA.w $012C

        .BRANCH_NU

        ; Restore the current module.
        LDA.w $010C : STA.b $10
        CMP.b #$06 : BNE .notPreDungeon
            JSL.l Sprite_ResetAll

        .notPreDungeon
    .return

    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $007427-$00744A LONG JUMP LOCATION
ResetSpotlightTable:
{
    REP #$30
    
    LDX.w #$003E
    LDA.w #$FF00

    .loop

        STA.w $1B00, X : STA.w $1B40, X
        STA.w $1B80, X : STA.w $1BC0, X
        STA.w $1C00, X : STA.w $1C40, X
        
        STZ.w $1C80, X
    DEX #2 : BPL .loop
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $00744B-$0074CB DATA
IrisSpotlight_CalculateCircleValue_multiplicand:
{
    db 255, 255, 255, 255, 255, 255, 255, 255
    db 255, 255, 255, 255, 254, 254, 254, 254
    db 253, 253, 253, 253, 252, 252, 252, 251
    db 251, 251, 250, 250, 249, 249, 248, 248
    db 247, 247, 246, 246, 245, 245, 244, 243
    db 243, 242, 241, 241, 240, 239, 238, 238
    db 237, 236, 235, 234, 233, 233, 232, 231
    db 230, 229, 228, 227, 226, 225, 223, 222
    db 221, 220, 219, 218, 216, 215, 214, 213
    db 211, 210, 208, 207, 205, 204, 202, 201
    db 199, 198, 196, 194, 193, 191, 189, 187
    db 185, 183, 182, 180, 177, 175, 173, 171
    db 169, 167, 164, 162, 159, 157, 154, 151
    db 149, 146, 143, 140, 137, 134, 130, 127
    db 123, 120, 116, 112, 108, 103,  99,  94
    db  89,  83,  77,  70,  63,  55,  45,  31
    db   0
}

; $0074CC-$00753D LOCAL JUMP LOCATION
IrisSpotlight_CalculateCircleValue:
{
    SEP #$30
    
    ; Set up an 8-bit dividend.
    STA.w SNES.DividendHigh
    STZ.w SNES.DividendLow
    
    ; Set the divisor.
    LDA.w $067C : STA.w SNES.DivisorB
    
    NOP #6
    
    REP #$20
    
    ; Obtain the quotient of the division, and divide by two.
    LDA.w SNES.DivideResultQuotientLow : LSR A
    
    SEP #$20
    
    TAX
    
    LDY.w .multiplicand, X : STY.b $0A : STY.w SNES.MultiplicandA
    
    LDA.w $067C : STA.w SNES.MultiplierB
    
    NOP #2
    
    STZ.b $01 : STZ.b $0B
    
    LDA.w SNES.RemainderResultHigh : STA.b $00
    
    REP #$30
    
    ASL.b $00
    
    LDA.b $0A : BEQ .BRANCH_ALPHA
        LDA.b $00 : CLC : ADC.w $0670 : STA.b $02
        
        LDA.w $0670 : SEC : SBC.b $00 : STZ.b $00 : BMI .BRANCH_BETA
            BIT.w #$FF00 : BEQ .BRANCH_GAMMA
                LDA.w #$00FF

            .BRANCH_GAMMA

            STA.b $00

        .BRANCH_BETA

        LDA.b $02 : BIT.w #$FF00 : BEQ .BRANCH_DELTA
            LDA.w #$00FF

        .BRANCH_DELTA

        XBA : ORA.b $00 : CMP.w #$FFFF : BNE .BRANCH_EPSILON
            LDA.w #$00FF

        .BRANCH_EPSILON

        STA.b $08

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; Data for the following routine.
; $00753E-$007565 DATA
OrientLampData:
{
    ; $00753E
    .horitzonal
    dw   0, 256,   0, 256
    
    ; $007546
    .vertical
    dw   0,   0, 256, 256

    ; $00754E
    .adjustment
    dw  52,  -2,  56,   6

    ; $007556
    .margin
    dw  64,  64, 82, -176

    ; $00755E
    .maxima
    dw 128, 384, 160, 160
}

; $007566-$007566 LONG JUMP LOCATION
OrientLampBg_easyOut:
{
    RTL
}

; If necessary, this function orients BG1 (which would have lamp graphics
; on it) to match Link's direction and movement.
; $007567-$007648 LONG JUMP LOCATION
OrientLampBg:
{
    ; This variable is nonzero if Link has the lantern and the room is dark.
    LDA.w $0458 : BEQ .easyOut
        LDA.b $11 : CMP.b #$14 : BEQ .easyOut
            REP #$30
            
            ; $00 = X = direction Link is facing.
            LDA.b $2F : AND.w #$00FF : STA.b $00 : TAX
            
            LDA.b $6C : AND.w #$00FF : BEQ .notInDoorway
                AND.w #$00FE : ASL A : TAX : BEQ .verticalDoorway
                    LDA.b $00 : CMP.w #$0004 : BCS .facingLeftOrRight
                        LDA.b $22 : CLC : ADC.w #$0008 : AND.w #$00FF
                        
                        BRA .BRANCH_DELTA

                    .facingLeftOrRight

                        TAX
                        
                        BRA .notInDoorway

                        .verticalDoorway
                    LDA.b $00 : CMP.w #$0004 : BCC .facingLeftOrRight
                
                    LDA.b $20 : AND.w #$00FF

                .BRANCH_DELTA

                CMP.w #$0080 : BCC .notInDoorway
                    INX #2

            .notInDoorway

            CPX.w #$0004 : BCS .facingLeftOrRight2
                LDA.b $22 : SEC : SBC.w #$0077 : STA.b $00
                
                ; BG1HOFS mirror = BG2HOFS mirror - Link's X coordinate + 0x77 +
                ; $00F43E, X.
                LDA.b $E2 : SEC : SBC.b $00
                CLC : ADC.l OrientLampData_horizontal, X : STA.b $E0
                
                LDA.b $20 : SEC : SBC.w #$0058 : STA.b $00
                
                ; A = BG2VOFS mirror - Link's Y coordinate + 0x58 + bunch of stuff.
                LDA.b $E8 : SEC : SBC.b $00
                CLC : ADC.l OrientLampData_vertical, X 
                CLC : ADC.l OrientLampData_adjustment, X
                CLC : ADC.l OrientLampData_margin, X
                
                BPL .positive
                
                ; Don't allow the vertical offset to be negative.
                LDA.w #$0000

                .positive

                CMP.l OrientLampData_maxima, X : BCC .inBounds
                    LDA.l OrientLampData_maxima, X

                .inBounds

                ; BG1VOFS mirror = the bounds-checked result of the eaarlier operations.
                SEC : SBC.l OrientLampData_margin, X : STA.b $E6
                
                SEP #$30
                
                RTL

            .facingLeftOrRight2

            LDA.b $20 : SEC : SBC.w #$0072 : STA.b $00
            
            ; BG1VOFS mirror = BG2VOFS mirror - Link's Y coordinate + 0x72 + $00F546, X.
            LDA.b $E8 : SEC : SBC.b $00
            CLC : ADC.l OrientLampData_vertical, X : STA.b $E6
            
            LDA.b $22 : SEC : SBC.w #$0058 : STA.b $00
            
            ; A = BG2HOFS mirror - Link's X coordinate + 0x58 + bunch of stuff...
            LDA.b $E2 : SEC : SBC.b $00
            CLC : ADC.l OrientLampData_horizontal, X 
            CLC : ADC.l OrientLampData_adjustment, X
            CLC : ADC.l OrientLampData_margin, X
            
            BPL .positive2
                LDA.w #$0000

            .positive2

            CMP.l OrientLampData_maxima, X : BCC .inBounds2
                LDA.l OrientLampData_maxima, X

            .inBounds2

            SEC : SBC OrientLampData_margin, X : STA.b $E0
            
            SEP #$30
            
            RTL
}

; ==============================================================================

; $007649-$00765F LONG JUMP LOCATION
Hdma_ConfigureWaterTable:
{
    REP #$30
    
    ; $0A = $0682 - $E8.
    ; $0674 = $0A - $0684.
    LDA.w $0682 : SEC : SBC.b $E8 : STA.b $0A : SEC : SBC.w $0684 : STA.w $0674
    
    LDA.b $0A : CLC : ADC.w $0684

    ; Bleeds into the next function.
}

; $007660-$007733 LONG JUMP LOCATION
AdjustWaterHDMAWindow_Horizontal:
{
    ; $0676 = $0A + $0684.
    STA.w $0676
    
    ; Subtract off the current BG2 scroll position.
    LDA.w $0680 : SEC : SBC.b $E2 : STA.w $0670
    
    LDA.w $0686 : BEQ .alpha
        DEC A

    .alpha

    ; $02 = ($0686 ? $0686 : 1) + $0670.
    STA.b $0C : CLC : ADC.w $0670 : STA.b $02
    
    ; $00 = $0670 - $0C.
    LDA.w $0670 : SEC : SBC.b $0C : STA.b $00
    
    ; This appears to be a compile time thing, given that it loads a
    ; constant value then immediately tests for negativity.
    LDY.w #$0000 : BMI .beta
    
    TAY : AND.w #$FF00 : BEQ .beta
        LDY.w #$00FF

    .beta

    TYA : AND.w #$00FF : STA.b $00
    
    LDA.b $02 : TAY : AND.w #$FF00 : BEQ .gamma
        LDY.w #$00FF

    .gamma

    TYA : AND.w #$00FF : XBA : ORA.b $00 : STA.b $0C
    
    LDA.b $0A : ASL A : STA.b $06 : CMP.w #$00E0 : BCS .delta
        LDA.w #$00E0 : STA.b $06

    .delta

    LDA.b $06 : SEC : SBC.b $0A : STA.b $08
    LDA.b $0A : SEC : SBC.b $08 : STA.b $04
    
    BRA .epsilon

    .rho

        INC.b $04
        DEC.b $06

        .epsilon

        LDA.b $04 : BMI .zeta
        
        LDA.w $0674 : BMI .theta
            LDA.b $04 : CMP.w $0674 : BCS .theta
                ASL A : TAX
                
                LDA.w #$00FF
                
                BRA .iota

        .theta

        LDA.b $04 : ASL A : TAX
        
        LDA.b $0C

        .iota

        CPX.w #$01C0 : BCS .zeta
            CMP.w #$FFFF : BNE .kappa
                LDA.w #$00FF

            .kappa

            STA.w $1B00, X

        .zeta

        LDA.b $06 : CMP.w $0676 : BCS .mu
            ASL A : TAX
            
            LDA.w #$00FF
            
            BRA .nu

        .mu

        CMP.w #$00E1 : BCS .xi
            LDA.w $0678 : BEQ .xi
                DEC.w $0678

        .xi

        LDA.b $06 : ASL A : TAX
        
        LDA.b $0C

        .nu

        CPX.w #$01C0 : BCS .omicron
            CMP.w #$FFFF : BNE .pi
            
            LDA.w #$00FF

            .pi

            STA.w $1B00, X

        .omicron
    LDA.b $0A : CMP.b $04 : BNE .rho
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $007734-$0077DF LONG JUMP LOCATION
FloodDam_PrepFloodHDMA:
{
    !leftFinal  = $00
    !scanline   = $04
    !lineBounds = $0C
    
    !leftBase   = $0670
    !startLine  = $0676
    !lineOffset = $0686
    
    REP #$30
    
    STZ.b !scanline
    
    ; $0674 = $0682 - BG2VOFS mirror.
    ; $0670 = $0680 - BG2HOFS mirror.
    LDA.w $0682 : SEC : SBC.b $E8 : STA.w $0674
    LDA.w $0680 : SEC : SBC.b $E2 : STA.w !leftBase
    
    ; $0E = $0686 ^ 0x0001.
    LDA.w !lineOffset : EOR.w #$0001 : STA.b $0E
    
    ; $02 = $0E + $0670.
    CLC : ADC.w !leftBase : STA.b $02
    
    LDA.w !leftBase : SEC : SBC.b $0E : AND.w #$00FF : STA.b !leftFinal
    
    LDA.b $02 : AND.w #$00FF : XBA : ORA.b !leftFinal : STA.b !lineBounds

    .disableLoop

        LDA.b !scanline : ASL A : TAX
        
        LDA.w #$FF00 : STA.w $1B00, X
        
        ; $0676 / !startLine was determined when the watergate barrier was placed.
    INC.b !scanline : LDA.b !scanline : CMP.w !startLine : BNE .disableLoop
    
    LDA.b $0E : SEC : SBC.w #$0007 : CLC : ADC.w #$0008 : STA.b !lineBounds
    
    CLC : ADC.w !leftBase : STA.b $02
    
    LDA.w !leftBase : SEC : SBC.b !lineBounds : AND.w #$00FF : STA.b !leftFinal
    
    LDA.b $02 : AND.w #$00FF : XBA : ORA.b !leftFinal : STA.b !lineBounds
    
    LDA.w !startLine : CLC : ADC.w $0684 : EOR.w #$0001 : STA.b $0A

    .nextScanline

        LDA.b !scanline : CMP.b $0A : BCC .beta
            ASL A : TAX
            
            LDA.w #$00FF
            
            BRA .gamma

        .beta

        ASL A : TAX : CPX.w #$01C0 : BCS .beta

        LDA.b $0C

        .gamma

        CMP.w #$FFFF : BNE .delta
            LDA.w #$00FF

        .delta

        STA.w $1B00, X
    INC !scanline : LDA !scanline : CMP.w #$00E1 : BCC .nextScanline
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; Beginning of Module 0x0E - Messaging Mode, Item Screen, Map
; $007800-$007875 JUMP LOCATION
Module_Messaging:
{
    LDA.b $1B : BEQ .outdoors
        LDA.b $11 : CMP.b #$03 : BNE .notDungeonMapMode
            LDA.w $0200 : BEQ .processCoreTasks
            CMP.b #$07 : BEQ .processCoreTasks
                BRA .ignoreCoreTasks

        .notDungeonMapMode

        ; Handles moving blocks and other stuff we're trying to finish up
        ; before pausing the action on screen.
        JSL.l PushBlock_Handler
        
        BRA .processCoreTasks

    .outdoors

    LDA.b $11 : CMP.b #$07 : BEQ .mode7MapMode
        CMP.b #$0A : BNE .processCoreTasks

    .mode7MapMode

    LDA.w $0200 : BNE .ignoreCoreTasks
        .processCoreTasks

        JSL.l Sprite_Main
        JSL.l PlayerOam_Main
        
        LDA.b $1B : BNE .indoors
            JSL.l Module_Overworld_rainAnimation

        .indoors

        JSL.l HUD.RefillLogicLong
        
        LDA.b $11 : CMP.b #$02 : BEQ .dialogueMode
            JSL.l OrientLampBg

        .dialogueMode
    .ignoreCoreTasks

    SEP #$30
    
    JSL.l Messaging_Main
    
    REP #$21
    
    LDA.b $E2       : ADC.w $011A : STA.w $011E
    LDA.b $E8 : CLC : ADC.w $011C : STA.w $0122
    LDA.b $E0 : CLC : ADC.w $011A : STA.w $0120
    LDA.b $E6 : CLC : ADC.w $011C : STA.w $0124
    
    SEP #$20

    ; $007875 ALTERNATE ENTRY POINT
    .doNothing

    RTL
}

; ==============================================================================

; $007876-$007899 JUMP TABLE
Messaging_MainJumpTable:
{
    ; $007876
    .low
    db Module_Messaging_doNothing>>0 ; 0x00 - $00F875 RTL (do nothing).
    db Messaging_Equipment>>0        ; 0x01 - $0DDD2A Link's item submenu
                                     ;        (press start).
    db Messaging_Text>>0             ; 0x02 - $0EC440 Dialogue Mode.
    db Messaging_DungeonMap>>0        ; 0x03 - $0AE0B0 Dungeon Map Mode.
    db RefillHeathFromRedPotion>>0   ; 0x04 - $00F8FB Fills life (red potion).
    db Messaging_PrayingPlayer>>0    ; 0x05 - $00F8B1 Praying at desert palace
                                     ;        before it opens.
    db Module0E_06_Unused>>0         ; 0x06 - $00F8E9 unused? Agahnim 2 related
                                     ;        code?
    db Messaging_OverworldMap>>0     ; 0x07 - $0AB98B Overworld Map Mode.
    db Module0E_08_GreenPotion>>0    ; 0x08 - $00F911 Fill up all magic (green
                                     ;        potion).
    db Module0E_09_BluePotion>>0     ; 0x09 - $00F918 Fill up magic and life
                                     ;        (blue potion).
    db Messaging_BirdTravel>>0       ; 0x0A - $0AB730 The flute bird that flies
                                     ;        you around.
    db Module0E_0B_SaveMenu>>0       ; 0x0B - $00F9FA Continue/Save & Quit Mode.

    ; $007882
    .high
    db Module_Messaging_doNothing>>8
    db Messaging_Equipment>>8
    db Messaging_Text>>8
    db Messaging_DungeonMap>>8
    db RefillHeathFromRedPotion>>8
    db Messaging_PrayingPlayer>>8
    db Module0E_06_Unused>>8
    db Messaging_OverworldMap>>8
    db Module0E_08_GreenPotion>>8
    db Module0E_09_BluePotion>>8
    db Messaging_BirdTravel>>8
    db Module0E_0B_SaveMenu>>8

    ; $00788E
    .bank
    db Module_Messaging_doNothing>>16
    db Messaging_Equipment>>16
    db Messaging_Text>>16
    db Messaging_DungeonMap>>16
    db RefillHeathFromRedPotion>>16
    db Messaging_PrayingPlayer>>16
    db Module0E_06_Unused>>16
    db Messaging_OverworldMap>>16
    db Module0E_08_GreenPotion>>16
    db Module0E_09_BluePotion>>16
    db Messaging_BirdTravel>>16
    db Module0E_0B_SaveMenu>>16
}

; $00789A-$0078B0 LONG JUMP LOCATION
Messaging_Main:
{
    LDX.b $11
    
    LDA.l Messaging_MainJumpTable_low, X  : STA.b $00
    LDA.l Messaging_MainJumpTable_high, X : STA.b $01
    LDA.l Messaging_MainJumpTable_bank, X : STA.b $02
    
    JMP [$0000]
}

; ==============================================================================

; For using messaging functions without being in module 0x0E.
; $0078B1-$0078C5 LONG JUMP LOCATION
Messaging_PrayingPlayer:
{
    LDA.b $B0
    
    JSL.l UseImplicitRegIndexedLongJumpTable
    
    dl ResetTransitionPropsAndAdvance_ResetInterface_long ; 0x00 - (initialize overworld color filtering settings).
    dl PaletteFilter_doFiltering      ;  0x01 - $02A2A5 Fade out before we set up the actual scene.
    dl PrayingPlayer_InitScene        ; 0x02 - $00F8C6
    dl PrayingPlayer_FadeInScene      ; 0x03 - $00F8E0
    dl PrayingPlayer_AwaitButtonInput ; 0x04 - $00F8E4
}

; ==============================================================================

; $0078C6-$0078DF LONG JUMP LOCATION
PrayingPlayer_InitScene:
{
    JSL.l Player_InitPrayingScene_HDMA
    
    ; Reverse filtering direction?
    LDA.l $7EC00B : DEC A : STA.l $7EC007
    
    LDA.b #$00 : STA.l $7EC00B
    LDA.b #$02 : STA.l $7EC009
    
    RTL
}

; ==============================================================================

; $0078E0-$0078E3 LONG JUMP LOCATION
PrayingPlayer_FadeInScene:
{
    ; Lightens scene until fully illuminated.
    JSL.l PaletteFilter_doFiltering

    ; Bleeds into the next function.
}

; $0078E4-$0078E8 ALTERNATE ENTRY POINT
PrayingPlayer_AwaitButtonInput:
{
    JSL.l DesertPrayer_BuildIrisHDMATable
    
    RTL
}

; ==============================================================================

; $0078E9-$0078FA LONG JUMP LOCATION
Module0E_06_Unused:
{
    LDA.b $B0
    
    JSL.l UseImplicitRegIndexedLongJumpTable
    
    dl ResetTransitionPropsAndAdvance_ResetInterface_long ; 0x00 - $02A2A5 Initialize a bunch of overworld crap.
    dl PaletteFilter_doFiltering                          ; 0x01 - $00E914
    dl Underworld_HandleTranslucencyAndPalettes_long      ; 0x02 - $02A2A9 Swap some palettes in memory?
    dl UnusedInterfacePaletteRecovery_long                ; 0x03 - $02A2AD
}

; ==============================================================================

; $0078FB-$7910 LONG JUMP LOCATION
RefillHeathFromRedPotion:
{
    JSL.l HUD_RefillHealth : BCC .stillHealing
        ; $007901 ALTERNATE ENTRY POINT
        .MoveOn

        LDA.b $3A : AND.b #$BF : STA.b $3A
        
        INC.b $16
        
        STZ.b $11
        
        ; Restore the current module.
        LDA.w $010C : STA.b $10

    .stillHealing

    RTL
}

; ==============================================================================

; $007911-$007917 LONG JUMP LOCATION
Module0E_08_GreenPotion:
{
    JSL.l HUD_RefillMagicPower : BCS RefillHeathFromRedPotion_MoveOn
        RTL
}

; ==============================================================================

; $007918-$00792C LONG JUMP LOCATION
Module0E_09_BluePotion:
{
    JSL.l HUD_RefillHealth : BCC .alreadyHealing
        LDA.b #$08 : STA.b $11

    .alreadyHealing

    JSL.l HUD.RefillMagicPower : BCC .beta
        LDA.b #$04 : STA.b $11

    .beta

    RTL
}

; ==============================================================================

; $00792D-$007944 DATA
; See ZScream "Dungeon Properties". - ZS Custom Overworld
Pool_PrepareDungeonExitFromBossFight:
{
    ; $00792D
    .boss_room
    db $C8 ; ROOM 00C8 - Armos→Eastern lobby
    db $33 ; ROOM 0033 - Lanmolas→Desert 3
    db $07 ; ROOM 0007 - Moldorm→Hera lobby
    db $20 ; ROOM 0020 - Agahnim→self
    db $06 ; ROOM 0006 - Arrghus→Swamp lobby
    db $5A ; ROOM 005A - Helmasaur→PoD lobby
    db $29 ; ROOM 0029 - Mothula→Skull 3
    db $90 ; ROOM 0090 - Vitreous→Mire foyer
    db $DE ; ROOM 00DE - Kholdstare→Ice 1
    db $A4 ; ROOM 00A4 - Trinexx→TR foyer
    db $AC ; ROOM 00AC - Blind→Thieves' lobby
    db $0D ; ROOM 000D - Agahnim 2→self
        
    ; $007939
    .exit_room
    db $C9 ; ROOM C9 - Armos→Eastern lobby
    db $63 ; ROOM 63 - Lanmolas→Desert 3
    db $77 ; ROOM 77 - Moldorm→Hera lobby
    db $20 ; ROOM 20 - Agahnim→self
    db $28 ; ROOM 28 - Arrghus→Swamp lobby
    db $4A ; ROOM 4A - Helmasaur→PoD lobby
    db $59 ; ROOM 59 - Mothula→Skull 3
    db $98 ; ROOM 98 - Vitreous→Mire foyer
    db $0E ; ROOM 0E - Kholdstare→Ice 1
    db $D6 ; ROOM D6 - Trinexx→TR foyer
    db $DB ; ROOM DB - Blind→Thieves' lobby
    db $0D ; ROOM 0D - Agahnim 2→self
}

; ==============================================================================

; $007945-$0079DC LONG JUMP LOCATION
PrepDungeonExit:
{
    JSL.l SavePalaceDeaths

    ; Save current dungeon keys to proper slots.
    JSL.l Dungeon_SaveRoomData_justKeys
    
    ; Indicate a boss has been killed in this room.
    LDA.w $0403 : ORA.b #$80 : STA.w $0403
    
    ; Save the room data as we exit.
    JSL.l Dungeon_SaveRoomQuadrantData
    
    LDX.b #$0C
    
    LDA.b $A0

    .next_room

        ; Cycle through all the registered boss rooms.
        ; If it's not the room we're in, branch.
    DEX : CMP .boss_room, X : BNE .next_room ; $00F92D
    
    ; Set the room to the entrance room of the palace (I'm guessing this is so
    ; we can use an exit object?). Are we in Agahnim's room?
    LDA.w .exit_room, X : STA.b $A0 : CMP.b #$20 : BNE .not_agahnim ; $00F939
        ; After beating Agahnim the world state gets set to 3 ("second part").
        LDA.b #$03 : STA.l $7EF3C5
        
        ; Set up the lumber jack's pit tree overlay so that the tree looks
        ; different.
        LDA.l $7EF282 : ORA.b #$20 : STA.l $7EF282
        
        ; Put us in the Dark World.
        LDA.l $7EF3CA : EOR.b #$40 : STA.l $7EF3CA
        
        JSL.l Sprite_LoadGfxProperties_justLightWorld
        JSL.l Ancilla_TerminateSelectInteractives
        
        STZ.w $037B : STZ.b $3C : STZ.b $3A : STZ.w $03EF
        
        ; Link can't move.
        LDA.b #$01 : STA.w $02E4
        
        ; The module to return to is #$08 (preoverworld).
        LDA.b #$08 : STA.w $010C
        
        ; Do the magic mirror sequence (after all, we just beat Agahnim).
        LDA.b #$15 : STA.b $10
        
        STZ.b $11 : STZ.b $B0
        
        RTL

    .not_agahnim

    ; Are we in Agahnim's second room in Ganon's tower?
    CMP.b #$0D : BNE .not_agahnim_2
        ; If in Agahnim's second room, do the "Ganon pops out to say hi"
        ; sequence.
        LDA.b #$18 : STA.b $10
        
        STZ.b $11 : STZ.w $0200
        
        ; Disable that red flashing?
        LDA.b #$20 : STA.b $9A
        
        RTL

    .not_agahnim_2

    ; Ganon and normal Boss victory modes, If room index < Chris Houlihan room.
    CPX.b #$03 : BCC .ganon
        ; In this case room index >= Chris Houlihan room
        ; do a volume fade out.
        LDA.b #$F1 : STA.w $012C : STA.w $0130
        
        ; Do the normal boss victory mode.
        LDA.b #$16
        
        BRA .normal

    .ganon

    ; Probably Ganon's boss victory mode.
    LDA.b #$13

    .normal

    ; Put us in either boss victory mode or boss refill mode.
    STA.b $10
    
    ; After we're done with doing... whatever go to preoverworld module.
    LDA.b #$08 : STA.w $010C
    
    STZ.b $11 : STZ.b $B0
    
    RTL
}

; ==============================================================================
    
; $0079DD-$0079F9 LONG JUMP LOCATION
SavePalaceDeaths:
{
    PHX
        
    REP #$20
        
    ; Load the dungeon index.
    LDX.w $040C
        
    ; Store the running count of deaths and store it as the count for the
    ; dungeon we just completed. If it's Hyrule Castle 2, then branch.
    LDA.l $7EF403 : STA.l $7EF3E7, X : CPX.b #$08 : BEQ .hyruleCastle
        ; Otherwise zero out the number of deaths.
        LDA.w #$0000 : STA.l $7EF403
    
    .hyruleCastle
    
    SEP #$20
        
    PLX
        
    RTL
}

; ==============================================================================
    
; $0079FA-$007A40 JUMP LOCATION
Module0E_0B_SaveMenu:
{
    LDA.b $1B : BNE .indoors
        JSL.l Overworld_DwDeathMountainPaletteAnimation

    .indoors

    JSL.l Messaging_Text

    STZ.b $16 : STZ.w $0710

    LDA.b $B0 : CMP.b #$03 : BCS .BRANCH_BETA
        INC.b $B0

        BRA .BRANCH_GAMMA

    .BRANCH_BETA

    STZ.b $14

    .BRANCH_GAMMA

    LDA.b $11 : BNE .notBaseSubmodule
        STZ.b $B0

        LDA.b #$01 : STA.b $14

        ; If zero, the player choose "continue", if not "save and quit".
        LDA.w $1CE8 : BEQ .continue
            ; Save and quit.

            ; Play the save and quit sound effect.
            LDA.b #$0F : STA.w $012D

            ; Go in to the save and quit main module.
            LDA.b #$17 : STA.b $10

            ; Use the 0x01 submodule (???).
            LDA.b #$01 : STA.b $11

            STZ.w $05FC : STZ.w $05FD

            RTL

        .continue

        ; Restore $1CE8's value and carry on.
        LDA.w $1CF4 : STA.w $1CE8

    .notBaseSubmodule

    RTL
}
    
; ==============================================================================

; $007A41-$007B40 DATA
Sprite_GfxIndices:
{
    ; Phase 0 / 1 (light world)
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $02, $02, $00, $00, $00
    db $00, $00, $00, $02, $02, $00, $00, $00
    db $00, $00, $00, $02, $02, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    ; Phase 2 (light world)
    db $07, $07, $07, $10, $10, $10, $10, $10
    db $07, $07, $07, $10, $10, $10, $10, $04
    db $06, $06, $00, $03, $03, $00, $0D, $0A
    db $06, $06, $01, $01, $01, $04, $05, $05
    db $06, $06, $06, $01, $01, $04, $05, $05
    db $06, $09, $0F, $00, $00, $0B, $0B, $05
    db $08, $08, $0A, $04, $04, $04, $04, $04
    db $08, $08, $0A, $04, $04, $04, $04, $04
    
    ; Phase 3 (light world)
    db $07, $07, $1A, $10, $10, $10, $10, $10
    db $07, $07, $1A, $10, $10, $10, $10, $04
    db $06, $06, $00, $03, $03, $00, $0D, $0A
    db $06, $06, $1C, $1C, $1C, $02, $05, $05
    db $06, $06, $06, $1C, $1C, $00, $05, $05
    db $06, $00, $0F, $00, $00, $23, $23, $05
    db $1F, $1F, $0A, $20, $20, $20, $20, $20
    db $1F, $1F, $0A, $20, $20, $20, $20, $20
    
    ; All phases (dark world)
    db $13, $13, $17, $14, $14, $14, $14, $14
    db $13, $13, $17, $14, $14, $14, $14, $16
    db $15, $15, $12, $13, $13, $18, $16, $16
    db $15, $15, $13, $26, $26, $13, $17, $17
    db $15, $15, $15, $26, $26, $13, $17, $17
    db $1B, $1D, $11, $13, $13, $18, $18, $17
    db $16, $16, $13, $13, $13, $19, $19, $19
    db $16, $16, $18, $13, $18, $19, $19, $19
}
    
; ==============================================================================

; $007B41-$007C40 DATA
Sprite_PaletteIndices:
{
    ; Phase 0 / 1 (light world)
    db $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01
    
    ; Phase 2 (light world)
    db $05, $05, $06, $09, $09, $09, $09, $09
    db $05, $05, $06, $09, $09, $09, $09, $03
    db $01, $01, $00, $02, $02, $00, $06, $03
    db $01, $01, $01, $03, $03, $03, $07, $07
    db $01, $01, $01, $03, $03, $03, $07, $07
    db $01, $00, $01, $00, $00, $03, $03, $07
    db $04, $04, $00, $03, $03, $03, $03, $03
    db $04, $04, $00, $03, $03, $03, $03, $03
    
    ; Phase 3 (light world)
    db $05, $05, $06, $09, $09, $09, $09, $09
    db $05, $05, $06, $09, $09, $09, $09, $03
    db $01, $01, $00, $02, $02, $00, $06, $03
    db $01, $01, $01, $01, $01, $03, $07, $07
    db $01, $01, $01, $01, $01, $03, $07, $07
    db $01, $00, $01, $00, $00, $03, $03, $07
    db $04, $04, $00, $03, $03, $03, $03, $03
    db $04, $04, $00, $03, $03, $03, $03, $03
    
    ; All phases (dark world)
    db $0E, $0E, $10, $0C, $0C, $0C, $0C, $0C
    db $0E, $0E, $10, $0C, $0C, $0C, $0C, $0A
    db $10, $10, $00, $0E, $0E, $00, $0D, $0A
    db $10, $10, $10, $0E, $0E, $0E, $0D, $0D
    db $10, $10, $10, $0E, $0E, $0E, $0D, $0D
    db $12, $00, $0B, $0E, $0E, $0E, $0E, $0D
    db $0F, $0F, $00, $0E, $0E, $0E, $0E, $0E
    db $0F, $0F, $00, $0E, $0E, $0E, $0E, $0E
}

; ==============================================================================

; $007C41-$007C9B LONG JUMP LOCATION
Sprite_LoadGfxProperties:
{
    PHB : PHK : PLB
    
    REP #$30
    
    LDY.w #$00FE
    LDX.w #$003E

    .darkWorldLoop

        LDA Sprite_GfxIndices, Y     : STA.l $7EFD00, X
        LDA Sprite_PaletteIndices, Y : STA.l $7EFD80, X
        
        DEY #2
    DEX #2 : BPL .darkWorldLoop
    
    BRA .doLightWorld

    ; $007C62 ALTERNATE ENTRY POINT
    .justLightWorld

    PHB : PHK : PLB
    
    REP #$30

    .doLightWorld

    ; If game stage == 0 or 1.
    LDY.w #$003E
    
    ; Which game stage are we in?
    LDA.l $7EF3C5 : AND.w #$00FF : CMP.w #$0002 : BCC .beforeSavingZelda
        LDY.w #$007E
    
        CMP.w #$0003 : BNE .beforeKillingAgahnim
            LDY.w #$00BE

        .beforeKillingAgahnim
    .beforeSavingZelda

    LDX.w #$003E

    .lightWorldLoop

        ; This array will be used to load values for $0AA3 and $0AB1 at a later
        ; time.
        LDA Sprite_GfxIndices, Y     : STA.l $7EFCC0, X
        LDA Sprite_PaletteIndices, Y : STA.l $7EFD40, X
    DEY #2 : DEX #2 : BPL .lightWorldLoop
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $007C9C-$007D1B DATA
; Auxiliary graphics index for overworld areas (0x80 entries).
GFXAA2ValsOW:
{
    db $21, $21, $21, $22, $22, $22, $22, $22
    db $21, $21, $21, $22, $22, $22, $22, $27
    db $23, $23, $20, $29, $29, $20, $29, $29
    db $23, $23, $20, $24, $24, $27, $25, $25
    db $23, $23, $23, $24, $24, $20, $25, $25
    db $23, $2A, $21, $20, $20, $27, $20, $25
    db $2B, $2B, $20, $27, $27, $27, $27, $27
    db $2B, $2B, $20, $27, $27, $27, $27, $27

    db $3E, $3E, $3E, $41, $41, $41, $41, $3C
    db $3E, $3E, $3E, $41, $41, $41, $41, $40
    db $3F, $3F, $30, $40, $40, $30, $40, $30
    db $3F, $3F, $30, $3B, $3B, $40, $3D, $3D
    db $3F, $3F, $3F, $3B, $3B, $30, $3D, $3D
    db $3F, $3F, $30, $30, $30, $40, $30, $3D
    db $42, $42, $30, $40, $40, $42, $42, $40
    db $42, $42, $30, $40, $40, $42, $42, $30
}

; $007D1C-$007DA3 DATA
; Overworld palette group data.
OverworldPalettesScreenToSet:
{
    db $06, $06, $08, $07, $07, $07, $07, $07
    db $06, $06, $08, $07, $07, $07, $07, $04
    db $08, $08, $00, $01, $01, $00, $09, $00
    db $08, $08, $00, $02, $02, $04, $09, $09
    db $08, $08, $08, $02, $02, $00, $09, $09
    db $08, $08, $01, $00, $00, $04, $00, $09
    db $09, $00, $00, $04, $04, $04, $04, $04
    db $09, $09, $00, $04, $04, $04, $04, $04

    db $1B, $1B, $1E, $17, $17, $17, $17, $18
    db $1B, $1B, $1E, $17, $17, $17, $17, $1D
    db $1E, $1E, $10, $1E, $1E, $10, $1E, $10
    db $1E, $1E, $10, $12, $12, $10, $1A, $1A
    db $1E, $1E, $1E, $12, $12, $10, $1A, $1A
    db $1E, $10, $12, $10, $10, $1D, $10, $1A
    db $1C, $1C, $10, $1D, $1D, $1C, $1C, $1D
    db $1C, $1C, $10, $1D, $1D, $1C, $1C, $10

    db $0A, $0A, $0A, $0A, $02, $02, $02, $0A
}

; ==============================================================================

; $007DA4-$007DED LONG JUMP LOCATION
Dungeon_InitStarTileChr:
{
    ; Swaps star tiles.
    STZ.w $04BC

    ; $007DA7 ALTERNATE ENTRY POINT
    .Dungeon_RestoreStarTileChr

    ; This entry point is used when we want to toggle the chr state of the
    ; star tiles, or if we need to restore it after coming back from
    ; some other submode like the dungeon map.
    REP #$10
    
    LDX.w #$0000
    LDY.w #$0020
    
    LDA.w $04BC : BEQ .notToggled
        ; Swap X and Y.
        TYX : LDY.w #$0000

    .notToggled

    STY.b $0E
    
    ; Set data bank to 0x7F.
    PHB : LDA.b #$7F : PHA : PLB
    
    REP #$20
    
    LDY.w #$0000

    ; These two loops are for swapping the star tiles in VRAM
    ; tricky stuff, took me a while to figure out what the offset
    ; $7EBDC0 was for!
    .swapTile1

        LDA.l $7EBDC0, X : STA.w $0000, Y
        
        INX #2
    INY #2 : CPY.w #$0020 : BNE .swapTile1
    
    LDX.b $0E

    .swapTile2

        LDA.l $7EBDC0, X : STA.w $0000, Y
        
        INX #2
    INY #2 : CPY.w #$0040 : BNE .swapTile2
    
    SEP #$30
    
    PLB
    
    ; Tell NMI to update the star tiles in VRAM.
    LDA.b #$18 : STA.b $17
    
    RTL
}

; ==============================================================================

; $007DEE-$007E5D LONG JUMP LOCATION
Mirror_InitHdmaSettings:
{
    STZ.b $9B
    
    REP #$20
    
    STZ.w $06A0 : STZ.w $06AC : STZ.w $06AA : STZ.w $06AE : STZ.w $06B0
    
    LDA.w #$0008 : STA.w $06B4
                   STA.w $06B6
    
    LDA.w #$0015 : STA.w $06B2
    LDA.w #$FFC0 : STA.w $06A6
    LDA.w #$0040 : STA.w $06A8
    LDA.w #$FE00 : STA.w $06A2
    LDA.w #$0200 : STA.w $06A4
    
    ; OPTIMIZE: You already set this to 0 lol.
    STZ.w $06AC : STZ.w $06AE
    
    LDA.w #$0F42 : STA.w DMA.7_TransferParameters
    LDA.w #$0D42 : STA.w DMA.6_TransferParameters
    
    LDX.b #$3E
    
    LDA.b $E2

    ; $007E3E ALTERNATE ENTRY POINT
    .init_hdma_table

        STA.w $1B00, X : STA.w $1B40, X : STA.w $1B80, X : STA.w $1BC0, X
        STA.w $1C00, X : STA.w $1C40, X : STA.w $1C80, X
    DEX #2 : BPL .init_hdma_table
    
    SEP #$20
    
    ; Enable HDMA channels 6 and 7.
    LDA.b #$C0 : STA.b $9B
    
    .easy_out
    
    RTL
}

; ==============================================================================

; $007E5E-$007E63 LONG JUMP LOCATION
MirrorHDMA:
{
    INC.b $B0
    
    ; Enable HDMA (though I thought it already would be at this point).
    LDA.b #$C0 : STA.b $9B

    ; Bleeds into the next function.
}

; $007E64-$007F2E LONG JUMP LOCATION
MirrorWarp_BuildWavingHDMATable:
{
    JSL.l MirrorWarp_RunAnimationSubmodules
    
    ; Only do something every other frame.
    LDA.b $1A : LSR A : BCS Mirror_InitHdmaSettings_easy_out
    
    REP #$30
    
    LDX.w #$01A0
    LDY.w #$01B0
    
    LDA.w #$0002 : STA.b $00
    
    LDA.w #$0003 : STA.b $02

    .gamma

        LDA.w $1B00, X
        
        STA.w $1B00, Y : STA.w $1B04, Y
        STA.w $1B08, Y : STA.w $1B0C, Y
        
        TXA : SEC : SBC.w #$0010 : TAX
        
        DEC.b $00 : BNE .alpha
            LDA.w #$0008 : STA.b $00

        .alpha

        TYA : SEC : SBC.w #$0010 : TAY
        
        DEC.b $02 : BNE .beta
            LDA.w #$0008 : STA.b $02

        .beta
    CPY.w #$0000 : BNE .gamma
    
    LDX.w $06A0
    LDA.w $06AC : CLC : ADC.w $06A6, X : PHA
    SEC : SBC.w $06A2, X : EOR.w $06A2, X : BMI .delta
        STZ.w $06AA
        STZ.w $06AE
        
        ; Toggle this variable's state.
        LDA.w $06A0 : EOR.w #$0002 : STA.w $06A0
        
        ; Replace the value on the stack with this.
        PLA : LDA.w $06A2, X : PHA

    .delta

    PLA : STA.w $06AC
    
    CLC : ADC.w $06AE : PHA : AND.w #$00FF : STA.w $06AE
    
    PLA : BPL .epsilon
        ORA.w #$00FF
        
        BRA .zeta

    .epsilon

    AND.w #$FF00

    .zeta

    XBA : CLC : ADC.w $06AA : STA.w $06AA : TAX
    
    LDA.l $7EC007 : CMP.w #$0030 : BCC .BRANCH_THETA
        TXA : AND.w #$FFF8 : BNE .BRANCH_THETA
            LDA.w #$FF00 : STA.w $06A2
            
            LDA.w #$0100 : STA.w $06A4
            
            LDX.w #$0000
            
            INC.b $B0

    .BRANCH_THETA

    TXA : CLC : ADC.b $E2
    STA.w $1B00 : STA.w $1B04 : STA.w $1B08 : STA.w $1B0C
    
    SEP #$30

    ; $007F2E ALTERNATE ENTRY POINT
    .return

    RTL
}

; ZS rewrites part of this function. - ZS Custom Overworld
; $007F2F-$007FB6 JUMP LOCATION (LONG)
MirrorWarp_BuildDewavingHDMATable:
{
    JSL.l MirrorWarp_RunAnimationSubmodules
        
    LDA.b $1A : LSR A : BCS MirrorHDMA_return
        REP #$30
            
        LDX.w #$01A0
        LDY.w #$01B0
            
        LDA.w #$0002 : STA.b $00
        LDA.w #$0003 : STA.b $02
        
        .BRANCH_GAMMA
        
            LDA.w $1B00, X
            STA.w $1B00, Y : STA.w $1B04, Y : STA.w $1B08, Y : STA.w $1B0C, Y
            
            TXA : SEC : SBC.w #$0010 : TAX
            
            DEC.b $00 : BNE .BRANCH_ALPHA
                LDA.w #$0008 : STA.b $00
        
            .BRANCH_ALPHA
        
            TYA : SEC : SBC.w #$0010 : TAY
            
            DEC.b $02 : BNE .BRANCH_BETA
                LDA.w #$0008 : STA.b $02
        
            .BRANCH_BETA
        CPY.w #$0000 : BNE .BRANCH_GAMMA
            
        ; ZS starts writing here.
        ; $007F7C - ZS Custom Overworld
        LDA.w $1C80 : ORA.w $1C90 : ORA.w $1CA0 : ORA.w $1CB0 : CMP.b $E2 : BNE .BRANCH_DELTA
            SEP #$20
            
            STZ.b $9B
            
            INC.b $B0
            
            JSL.l Overworld_SetFixedColorAndScroll
            
            ; Check if area is the Hyrule Castle screen or pyramid of power
            ; screen.
            LDA.b $8A : AND.b #$3F : CMP.b #$1B : BEQ .dont_align_bgs
                REP #$20
            
                LDA.b $E2 : STA.b $E0 : STA.w $0120 : STA.w $011E
                LDA.b $E8 : STA.b $E6 : STA.w $0122 : STA.w $0124
        
            .dont_align_bgs
        .BRANCH_DELTA
        
        SEP #$30
            
        RTL
}

; ==============================================================================

; $007FB7-$007FBF NULL
NULL_00FFB7:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}
    
; ==============================================================================

; $007FC0-$007FFF Internal ROM Header
Internal_ROM_Header:
{
    db "THE LEGEND OF ZELDA  "
        
    db $20   ; ROM layout
    db $02   ; Cartridge type
    db $0A   ; ROM size
    db $03   ; WRAM size (SRAM size)
    db $01   ; Country code (NTSC here)
    db $01   ; Licensee (Nintendo here)
    db $00   ; Game version
    dw $50F2 ; Game image checksum
    dw $AF0D ; Game image inverse checksum
        
    dw $FFFF, $FFFF, Vector_NMI_return, $FFFF
    dw Vector_NMI_return, Vector_NMI, Vector_Reset, Vector_IRQ
    dw $FFFF, $FFFF, Vector_NMI_return, Vector_NMI_return
    dw Vector_NMI_return, Vector_NMI_return, Vector_Reset, Vector_IRQ
}

; ==============================================================================

warnpc $018000