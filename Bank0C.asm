; ==============================================================================

; Bank 0C
org $0C8000 ; $060000-$067FFF

; ==============================================================================

; $064120 - $6415C JUMP LOCATION
Module_Intro:
{
    ; Beginning of Module 0x00, Startup Screen:
    
    LDA $11 : CMP.b #$08 : BCC .dontCheckInput
    
    LDA $F6 : AND.b #$C0 : ORA $F4 : AND.b #$D0 : BEQ .noPressedButtons
    
    ; If ABXY, or Start is pressed, then go to the file selection menu module.
    JMP $C2F0
    
    .noPressedButtons
    .dontCheckInput
    
    ; Otherwise, branch to the appropriate part of the intro.
    LDA $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl Intro_Init           ; $06415D Blank Screen
    dl Intro_Init.justLogo  ; $064170 -Nintendo presents-
    dl Intro_InitGfx        ; $06433C Sets up myriad graphics settings
    dl $0CC404              ; $064404 Copyright Nintendo 1992
    dl $0CC404              ; $064404 Triforces swooping in.
    dl $0CC25C              ; $06425C "Zelda" logo fade in.
    dl $0CC2AE              ; $0642AE Sword coming down...
    dl $0CC284              ; $064284 Fades in bg, Zelda Symbol is sparkling, looking pretty.
    dl $0CC2D4              ; $0642D4 Wait to see if the player does anything.
    dl $0CC404              ; $064404 This one and the next 2 are unused.
    dl Intro_InitGfx        ; $06433C
    dl $0CC404              ; $064404
}

; ==============================================================================

; $06415D-$06419F JUMP LOCATION
Intro_Init:
{
    JSL Intro_SetupScreen
    
    ; Push the screen to full brightness next frame
    LDA.b #$0F : STA $13
    
    ; Initialize the sub-submodule index.
    STZ $B0
    
    ; Indicates that CGRAM needs to be updated next frame
    INC $15
    
    ; Move into the next submodule.
    INC $11
    
    ; Plays the twinkle as the 'Nintendo' logo pops up.
    LDA.b #$0A : STA $012F
    
    ; $064170 ALTERNATE ENTRY POINT
    .justLogo
    
    ; $066D82, sets up sprite information for the N-logo.
    ; (OAM buffer is refreshed every frame, so this must be repeatedly called)
    JSR Intro_DisplayNintendoLogo
    
    ; as long as $B0 is less than 0xB, no branch occurs.
    LDA $B0 : INC $B0 : CMP.b #$0B : BCS Intro_LoadTitleGraphics
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_InitWram
    dl Intro_LoadTextPointersAndPalettes
    dl $00D231 ; = $005231
    dl Tagalong_LoadGfx
}

; ==============================================================================

; $0641A0-$0641F4 JUMP LOCATION
Intro_InitWram:
{
    ; Zerores out a 0x400 byte chunk of wram
    
    REP #$30
    
    ; $C8 is the Upper Bound
    ; $CA stores the Lower Bound
    LDX $C8
    
    LDA.w #$0000
    
    .zeroLoop
    
        ; Erases $7E0000-$7FFFF (all work ram)
        STA $7E2000, X : STA $7E4000, X
        STA $7E6000, X : STA $7E8000, X
        STA $7EA000, X : STA $7EC000, X
        STA $7EE000, X : STA $7F0000, X
        STA $7F2000, X : STA $7F4000, X
        STA $7F6000, X : STA $7F8000, X
        STA $7FA000, X : STA $7FC000, X
        STA $7FE000, X
    DEX #2 : CPX $CA : BNE .zeroLoop
    
    ; The old lower bound is the new upper bound
    STX $C8
    
    ; Reindex $CA 0x400 bytes lower for the next time this gets called
    TXA : SEC : SBC.w #$0400 : STA $CA
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0641F5-$06425B BRANCH LOCATION
Intro_LoadTitleGraphics:
{
    DEC $13 : BNE .waitTillForceBlank
        ; $0641F9 ALTERNATE ENTRY POINT
        .noWait
        
        ; $00093D
        JSL EnableForceBlank
        JSL Vram_EraseTilemaps.normal
        
        LDA.b #$02 : STA $2101
        
        ; What tiles shall we put on the start up screen?
        LDA.b #$23 : STA $0AA1
        
        ; Determines the tiles for the sword on the title screen.
        LDA.b #$7D : STA $0AA3
        
        ; Deterines some of the other tiles used for the title screen.
        LDA.b #$51 : STA $0AA2
        
        ; Extra sprite graphics pack
        LDA.b #$08 : STA $0AA4
        
        ; Why we're calling this prior to InitTileSets.... no idea. It seems that
        ; InitTileSets would overwrite any graphics this routine would decompress
        JSL LoadDefaultGfx ; $0062D0
        JSL InitTileSets   ; $00619B
        
        LDY.b #$5D
        
        JSL DecompDungAnimatedTiles ; $005337
        
        LDA.b #$02 : STA $7EC00D
        LDA.b #$00 : STA $7EC00E
        
        STZ $8A
        
        STZ $0AB6
        
        STA $0AB8
        
        STZ $C8
        STZ $C9
        STZ $CA
        STZ $CB
        
        LDA.b #$02 : STA $7EC009
        LDA.b #$1F : STA $7EC007
        LDA.b #$00 : STA $7EC00B
        
        STZ $0AA6
        
        INC $11
    
    .waitTillForceBlank
    
    RTL
}

; ==============================================================================

; $06425C-$064283 JUMP LOCATION
{
    JSL $0CC404 ; $064404
    
    LDA $1A : LSR A : BCC .evenFrame
        JSL $00ED7C ; $006D7C
        
        LDA $7EC007 : BNE .BRANCH_2
            LDA.b #$2A : STA $B0
            
            INC $11
            
            JSR $FE45 ; $067E45
    
    .evenFrame
    
    RTL
    
    .BRANCH_2
    
    CMP.b #$0D : BNE .dontEnableBGs
        LDA.b #$15 : STA $1C
        
        STZ $1D
    
    .dontEnableBGs
    
    RTL
}

; ==============================================================================

; $064284-$0642AD JUMP LOCATION
{
    JSR $FE56   ; $067E56
    JSL $0CC404 ; $064404
    
    LDA $7EC007 : BEQ .alpha
        LDA $1A : LSR A : BCC .dontAdvanceYet
            JML $00ED8F ; $006D8F
    
    .alpha
    
    LDA $F6 : AND.b #$C0 : ORA $F4 : AND.b #$D0 : BEQ .waitForButtonPress
        JMP $C2F0 ; $0642F0
    
    .waitForButtonPress
    
    DEC $B0 : BNE .dontAdvanceYet
        INC $11
    
    .dontAdvanceYet
    
    RTL
}

; ==============================================================================

; $0642AE-$0642D3 JUMP LOCATION
{
    JSL $0CC404 ; $064404
    
    STZ $1F00
    STZ $012A
    
    JSR $FE56 ; $067E56
    
    DEC $B0 : BNE .BRANCH_1
        INC $11
        
        LDA.b #$02 : STA $99
        LDA.b #$22 : STA $9A
        
        LDA.b #$1F : STA $7EC007
        
        LDA.b #$02 : STA $1D
    
    .BRANCH_1
    
    RTL
}

; ==============================================================================

; $0642D4-$0642EF JUMP LOCATION 
{
    JSL $0CC404 ; $064404
    
    STZ $1F00
    STZ $012A
    
    JSR $FE56 ; $067E56
    
    DEC $B0 : BNE .BRANCH_1
        ; note that this instruction does nothing since
        ; $11 is zeroed out a few lines down. programmers aren't perfect!
        INC $11
        
        ; Change to mode 0x14
        LDA.b #$14 : STA $10
        
        ; Reset the submodule index
        STZ $11
        
        ; Reset the attract mode sequencing index.
        STZ $22
    
    .BRANCH_1
    
    RTL
}

; ==============================================================================

; $0642F0-$06433B JUMP LOCATION
{
    LDA.b #$FF : STA $0128
    
    ; Main screen designation.
    LDA.b #$15 : STA $1C
    
    STZ $1D
    
    STZ $1B
    
    ; Give the silence command for music.
    LDA.b #$F1 : STA $012C
    
    JSL Palette_BgAndFixedColor_justFixedColor
    
    REP #$30
    
    LDX.w #$006E
    
    .loop
    
        ; Zeroes out $20-$8E
        STZ $20, X
    DEX #2 : BPL .loop
    
    LDX.w #$0000
    
    TXA
    
    .initSramBuffer
    
        ; Clear the save memory area.
        STA $7EF000, X : STA $7EF100, X : STA $7EF200, X : STA $7EF300, X : STA $7EF400, X
    INX #2 : CPX.w #$0100 : BNE .initSramBuffer
    
    SEP #$30
    
    ; Go to select screen mode.
    LDA.b #$01 : STA $10 : STA $04AA
    
    STZ $11
    
    RTL
}

; ==============================================================================

; $06433C-$06436E JUMP LOCATION
Intro_InitGfx:
{
    ; Module 0x00.0x02, 0x00.0x0A
    
    ; Set misc. sprite graphics
    LDA.b #$08 : STA $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    JSR $C36F   ; $06436F
    
    LDA.b #$01 : STA $1E10 : STA $1E11 : STA $1E12
    LDA.b #$00 : STA $1E18 : STA $1E19 : STA $1E1A
    
    LDA.b #$01 : STA $1E14
    LDA.b #$02 : STA $1E1C
    
    ; Bring screen to full brightness
    LDA.b #$0F : STA $13
    
    INC $11
    
    RTL
}

; ==============================================================================

; $06436F-$0643BC LOCAL JUMP LOCATION
{
    JSL Polyhedral_InitThread
    JSR $C3BD   ; $0643BD
    
    ; Set vertical IRQ trigger scanline
    LDA.b #$90 : STA $FF
    
    LDA.b #$FF : STA $1F02
    LDA.b #$20 : STA $1F06 : STA $1F07 : STA $1F08
    LDA.b #$A0 : STA $1F04
    LDA.b #$60 : STA $1F05
    LDA.b #$01 : STA $1F01 : STA $1F03 : STA $012A : STA $1F00
    
    ; Initialize RAM for starting Module 0x00
    LDX.b #$0F
    
    .loop
    
        STZ $1E00, X : STZ $1E10, X : STZ $1E20, X
        STZ $1E30, X : STZ $1E40, X : STZ $1E50, X
        STZ $1E60, X
    DEX : BPL .loop
    
    RTS
}

; ==============================================================================

; $0643BD-$064403 LOCAL 
{
    ; The guy who wrote this routine had never heard of MVN or MVP apparently
    ; or DMA, for that matter.
    ; This routine writes a fixed set of colors to SP-6 (first half)
    
    REP #$20
    
    LDA $0CC425 : STA $7EC6A0
    LDA $0CC427 : STA $7EC6A2
    LDA $0CC429 : STA $7EC6A4
    LDA $0CC42B : STA $7EC6A6
    LDA $0CC42D : STA $7EC6A8
    LDA $0CC42F : STA $7EC6AA
    LDA $0CC431 : STA $7EC6AC
    LDA $0CC433 : STA $7EC6AE
    
    SEP #$30
    
    ; Perform palette update this frame
    INC $15
    
    RTS
}

; ==============================================================================

; $064404-$064411 LONG JUMP LOCATION
{
    PHB : PHK : PLB
    
    INC $1E0A
    
    JSR $C435 ; $064435
    JSR $C412 ; $064412
    
    PLB
    
    RTL
}

; ==============================================================================

; $064412-$064424 LOCAL JUMP LOCATION
{
    LDA.b #$00 : STA $1E08
    LDA.b #$09 : STA $1E09
    
    LDX.b #$07
    
    .loop
    
        JSR $C534 ; $064534
    DEX : BPL .loop
    
    RTS
}

; ==============================================================================

; $064425-$064434 DATA
{
    ; FOR USE WITH $643BD
    
    dw $0000, $014D, $01B0, $01F3, $0256, $0279, $02FD, $035F
}

; ==============================================================================

; $064435-$064447 LOCAL JUMP LOCATION
{
    LDA.b #$01 : STA $012A
    
    ; Is this some sort of "IRQ busy" flag?
    LDA $1F00 : BNE .waitForTriforceThread
        JSR $C448 ; $064448
        
        LDA.b #$01 : STA $1F00
    
    .waitForTriforceThread
    
    RTS
}

; ==============================================================================

; $064448-$06445A LOCAL JUMP LOCATION
{
    LDA $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $C45B ; = $06445B
    dw $C47B ; = $06447B
    dw $C4BA ; = $0644BA
    dw $C4D6 ; = $0644D6
    dw $C500 ; = $064500
    dw $C533 ; = $064533 (Empty unimplemented step - RTS)
}

; $06445B-$06447A JUMP LOCATION
{
    INC $1E01
    
    LDA $1E01 : CMP.b #$40 : BNE .countingUp
        INC $1E00
    
    .countingUp
    
    LDA $1F05 : CLC : ADC.b #$05 : STA $1F05
    LDA $1F04 : CLC : ADC.b #$03 : STA $1F04
    
    RTS
}

; $06447B-$0644B9 JUMP LOCATION
{
    LDA $1F02 : CMP.b #$02 : BCS .alpha
        STZ $1F02
        
        INC $1E00
        
        LDA.b #$40 : STA $1E01
        
        RTS
    
    .alpha
    
    SBC.b #$02 : STA $1F02
    
    LDA $1F05 : CLC : ADC.b #$05 : STA $1F05
    LDA $1F04 : CLC : ADC.b #$03 : STA $1F04
    
    LDA $1F02 : CMP.b #$E1 : BCS .beta
        LDX.b #$04 : STX $11
    
    .beta
    
    CMP.b #$71 : BNE .dontStartMusic
        ; Selects the opening theme during the triforce scene/ intro.
        LDA.b #$01 : STA $012C
    
    .dontStartMusic
    
    RTS
}

; $0644BA-$0644D5 JUMP LOCATION
{
    DEC $1E01 : BNE .countingDown
        INC $1E00
        
        RTS
    
    .countingDown
    
    LDA $1F05 : CLC : ADC.b #$05 : STA $1F05
    LDA $1F04 : CLC : ADC.b #$03 : STA $1F04
    
    RTS
}

; $0644D6-$0644FF JUMP LOCATION
{
    LDA $1F05 : CMP.b #$FA : BCC .alpha
        LDA $1F04 : CMP.b #$FC : BCC .alpha
            INC $1E00
            
            LDA.b #$20 : STA $1E01
            
            RTS
    
    .alpha
    
    LDA $1F05 : CLC : ADC.b #$05 : STA $1F05
    LDA $1F04 : CLC : ADC.b #$03 : STA $1F04
    
    RTS
}

; $064500-$064532 JUMP LOCATION
{
    STZ $1F05
    STZ $1F04
    
    DEC $1E01 : BNE .countingDown
        INC $1E00
        
        LDA.b #$01 : STA $1E15
        LDA.b #$03 : STA $1E1D
        
        LDA.b #$10 : STA $1C
        LDA.b #$05 : STA $1D
        
        LDA.b #$02 : STA $99
        LDA.b #$31 : STA $9A
        
        STZ $B0
        
        INC $15
        
        LDA.b #$03
        
        ; $06452E ALTERNATE ENTRY POINT
        .doTilemapUpdate
        
        STA $14
        
        INC $11
    
    .countingDown
    
    RTS
}

; $064533-$064533 JUMP LOCATION
{
    ; Empty step ... put here for a purpose probably though
    ; from what I can tell. I think this does get executed,
    ; contrary to what one might think by looking at the previous step.
    RTS
}

; $064534 - $064542 LOCAL JUMP LOCATION
{
    LDA $1E10, X : BEQ .alpha
        JSL UseImplicitRegIndexedLocalJumpTable
        
        ; Jump table
        dw $C543 ; = $064543
        dw $C544 ; = $064544
        dw $C55B ; = $06455B
    
    .alpha
    
    RTS
}

; $064543-$064543 JUMP LOCATION 
{
    RTS
}

; $064544-$06455A JUMP LOCATION
{
    LDA $1E18, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $C57E ; = $06457E
    dw $C84F ; = $06484F
    dw $C850 ; = $064850
    dw $C8E2 ; = $0648E2
    dw $CBE8 ; = $064BE8
    dw $CBE8 ; = $064BE8
    dw $CBE8 ; = $064BE8
    dw $CD19 ; = $064D19
}

; $06455B-$064571 JUMP LOCATION
{
    LDA $1E18, X
    
    JSR UseImplicitRegIndexedLocalJumpTable
    
    dw $C5B1 ; = $0645B1
    dw $C84F ; = $06484F
    dw $C864 ; = $064864
    dw $C90D ; = $06490D
    dw $CC13 ; = $064C13
    dw $CC13 ; = $064C13
    dw $CC13 ; = $064C13
    dw $CD3E ; = $064D3E
}

; $064572-$06457D DATA
{
    db $DA, $FF, $5F, $00, $E6, $00, $C8, $00, $BD, $FF, $C8, $00
}

; $06457E-$0645B0 JUMP LOCATION
{
    TXA : ASL : TAY
    
    LDA.w $C572, Y : STA $1E30, X
    LDA.w $C573, Y : STA $1E38, X
    LDA.w $C578, Y : STA $1E48, X
    LDA.w $C579, Y : STA $1E50, X
    
    LDA.w $C5CA, X : CLC : ADC $1E58, X : STA $1E58, X
    LDA.w $C5CD, X : CLC : ADC $1E60, X : STA $1E60, X
    
    INC $1E10, X
    
    RTS
}

; $0645B1-$0645C9 JUMP LOCATION
{
    JSR $C70F ; $06470F
    JSR $C9F1 ; $0649F1
    
    LDA $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C608 ; $064608
}

; $0645CA-$0645D5 DATA
{
    ; USED WITH $0645D6
    
    dw $0001, $FFFF, $FF01, $5F4B, $5875, $5830
}

; $0645D6-$064607 JUMP LOCATION
{
    LDA $1E0A : AND.b #$1F : BNE .BRANCH_1
        LDA.w $C5CA, X : CLC : ADC $1E58, X : STA $1E58, X
        LDA.w $C5CD, X : CLC : ADC $1E60, X : STA $1E60, X
        
    .BRANCH_1
    
    LDA.w $C5D0, X : CMP $1E30, X : BNE .BRANCH_2
        STZ $1E58, X
    
    .BRANCH_2
    
    LDA.w $C5D3, X : CMP $1E48, X : BNE .BRANCH_3
        STZ $1E60, X
    
    .BRANCH_3
    
    RTS
}

; $064608-$06460E JUMP LOCATION 
{
    STZ $1E58, X
    STZ $1E60, X
    
    RTS
}

; $06460F-$06470E
AnimateSceneSprite_DrawTriangle
{
    .rightside_objects
    dw   0,   0 : db $80, $1B, $00, $02
    dw  16,   0 : db $82, $1B, $00, $02
    dw  32,   0 : db $84, $1B, $00, $02
    dw  48,   0 : db $86, $1B, $00, $02
    dw   0,  16 : db $A0, $1B, $00, $02
    dw  16,  16 : db $A2, $1B, $00, $02
    dw  32,  16 : db $A4, $1B, $00, $02
    dw  48,  16 : db $A6, $1B, $00, $02
    dw   0,  32 : db $88, $1B, $00, $02
    dw  16,  32 : db $8A, $1B, $00, $02
    dw  32,  32 : db $8C, $1B, $00, $02
    dw  48,  32 : db $8E, $1B, $00, $02
    dw   0,  48 : db $A8, $1B, $00, $02
    dw  16,  48 : db $AA, $1B, $00, $02
    dw  32,  48 : db $AC, $1B, $00, $02
    dw  48,  48 : db $AE, $1B, $00, $02

    ; $06468F
    .leftside_objects
    dw  48,   0 : db $80, $5B, $00, $02
    dw  32,   0 : db $82, $5B, $00, $02
    dw  16,   0 : db $84, $5B, $00, $02
    dw   0,   0 : db $86, $5B, $00, $02
    dw  48,  16 : db $A0, $5B, $00, $02
    dw  32,  16 : db $A2, $5B, $00, $02
    dw  16,  16 : db $A4, $5B, $00, $02
    dw   0,  16 : db $A6, $5B, $00, $02
    dw  48,  32 : db $88, $5B, $00, $02
    dw  32,  32 : db $8A, $5B, $00, $02
    dw  16,  32 : db $8C, $5B, $00, $02
    dw   0,  32 : db $8E, $5B, $00, $02
    dw  48,  48 : db $A8, $5B, $00, $02
    dw  32,  48 : db $AA, $5B, $00, $02
    dw  16,  48 : db $AC, $5B, $00, $02
    dw   0,  48 : db $AE, $5B, $00, $02
}

; $06470F-$06472E LOCAL JUMP LOCATION
{
    LDA.b #$10 : STA $06
                 STZ $07
    
    CPX.b #$02 : BEQ .BRANCH_1
        LDA.b #$0F : STA $08
        LDA.b #$C6 : STA $09
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.b #$8F : STA $08
    LDA $C6    : STA $09
    
    .BRANCH_2
    
    JSR $C972 ; $064972
    
    RTS
}

; $06482F-$06484E LOCAL JUMP LOCATION
{
    LDA.b #$10 : STA $06
                 STZ $07
    
    CPX.b #$02 : BEQ .BRANCH_1
        LDA.b #$2F : STA $08
        LDA $C7    : STA $09
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.b #$AF : STA $08
    LDA.b #$C7 : STA $09
    
    .BRANCH_2
    
    JSR $C972 ; $064972
    
    RTS
}

; $06484F-$06484F JUMP LOCATION
{
    RTS
}

; $064850-$064863 JUMP LOCATION
{
    LDA.b #$4C : STA $1E30, X
    
    STZ $1E38, X
    
    LDA.b #$B8 : STA $1E48, X
    
    STZ $1E50, X
    
    INC $1E10, X
    
    RTS
}

; $064864-$064867 JUMP LOCATION
{
    JSR $C8D0 ; $0648D0
    
    RTS
}

; $0648D0-$0648E1 LOCAL JUMP LOCATION
{
    LDA.b #$0D : STA $06
                 STZ $07
    LDA.b #$68 : STA $08
    LDA.b #$C8 : STA $09
    
    JSR $C972 ; $064972
    
    RTS
}

; $0648E2-$0648FC JUMP LOCATION
{
    LDA $1E0A : LSR #5 : AND.b #$03 : TAY
    
    LDA.w $C8FD, Y : STA $1E30, X
    LDA.w $C901, Y : STA $1E48, X
    
    INC $1E10, X
    
    RTS
}

; $06490D-$064935 JUMP LOCATION
{
    JSR $C956 ; $064956
    
    LDA $1E0A : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $C8FD, Y : STA $1E30, X
    LDA.w $C901, Y : STA $1E48, X
    
    RTS
}

; $064956-$064971 LOCAL JUMP LOCATION
{
    LDA.b #$01 : STA $06 : STZ $07
    
    LDA $1E20, X : BMI .BRANCH_1
        ASL #3 : ADC.b #$36 : STA $08
        
        LDA.b #$C9 : ADC.b #$00 : STA $09
        
        JSR $C972 ; $064972
    
    .BRANCH_1
    
    RTS
}

; ==============================================================================

; $064972-$0649F0 LOCAL JUMP LOCATION
{
    ; Puts triforce sprites in OAM buffer.
    LDA $1E30, X : STA $00
    LDA $1E38, X : STA $01
    LDA $1E48, X : STA $02
    LDA $1E50, X : STA $03
    
    STZ $04 : STZ $05
    
    PHX
    
    REP #$30
    
    LDY.w #$0000
    
    LDX $1E08
    
    LDA $06 : ASL #2 : ADC $1E08 : STA $1E08
    
    .nextSprite
    
        LDA ($08), Y : CLC : ADC $00 : STA $0000, X
        
        AND.w #$0100 : STA $0C
        
        INY #2
        
        LDA ($08), Y : CLC : ADC $02 : STA $0001, X
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .y_in_range
            LDA.w #$00F0 : STA $0001, X
        
        .y_in_range
        
        INY #2
        
        LDA ($08), Y : EOR $04 : STA $0002, X
        
        PHX
        
        TXA : SEC : SBC.w #$0800 : LSR #2 : TAX
        
        SEP #$20
        
        INY #3
        
        LDA ($08), Y : ORA $0D : STA $0A20, X
        
        PLX
        
        REP #$20
        
        INY
        
        INX #4
    DEC $06 : BNE .nextSprite
    
    SEP #$30
    
    PLX
    
    RTS
}

; ==============================================================================

; $0649F1-$064A4B LOCAL JUMP LOCATION
{
    LDA $1E58, X : BEQ .BRANCH_2
        ASL #4 : CLC : ADC $1E28, X : STA $1E28, X
        
        LDA $1E58, X : PHP : LSR #4
        
        LDY.b #$00
        
        PLP : BPL .BRANCH_1
            ORA.b #$F0
            
            DEY
        
        .BRANCH_1
        
        ADC $1E30, X : STA $1E30, X
        
        TYA : ADC $1E38, X : STA $1E38, X
    
    .BRANCH_2
    
    LDA $1E60, X : BEQ .BRANCH_4
        ASL #4 : CLC : ADC $1E40, X : STA $1E40, X
        
        LDA $1E60, X : PHP : LSR #4
        
        LDY.b #$00
        
        PLP : BPL .BRANCH_3
            ORA.b #$F0
            
            DEY
        
        .BRANCH_3
        
        ADC $1E48, X : STA $1E48, X
        
        TYA : ADC $1E50, X : STA $1E50, X
    
    .BRANCH_4
    
    RTS
}

; ==============================================================================

; $064A4C-$064A53 LOCAL JUMP LOCATION
{
    LDA $1E02 : BEQ .BRANCH_1
        ; Note that this maneuver will pull the return address from this Sub off the stack
        ; And we will end up at the sub that called this Sub's caller.
        PLA : PLA
    
    .BRANCH_1
    
    RTS
}

; ==============================================================================

; $064A54-$064A80 LONG ; coming from Module_TriforceRoom
{
    LDA.b #$08 : STA $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    JSR $C36F   ; $06436F
    
    LDA.b #$01 : STA $1E10 : STA $1E11 : STA $1E12
    LDA.b #$04 : STA $1E18
    LDA.b #$05 : STA $1E19
    LDA.b #$06 : STA $1E1A
    
    LDA.b #$0F : STA $13
    
    INC $11
    
    RTL
}

; ==============================================================================

; $064A81-$064AB0 LONG JUMP LOCATION
Credits_InitializePolyhedral:
{
    LDA.b #$08 : STA $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    JSR $C36F   ; $06436F MAKES SURE THE TRIFORCES ARE SET UP.
    
    STZ $1F02
    
    LDA.b #$01 : STA $1E10 : STA $1E11 : STA $1E12
    LDA.b #$07 : STA $1E18
    LDA.b #$07 : STA $1E19
    LDA.b #$07 : STA $1E1A
    
    LDA.b #$0F : STA $13
    
    INC $11
    
    RTS
}

; ==============================================================================

; $064AB1-$064ABB LONG JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR $CABC ; $064ABC
    JSR $C412 ; $064412
    
    PLB
    
    RTL
}

; ==============================================================================

; $064ABC-$064AD7 LOCAL JUMP LOCATION
{
    LDA.b #$01 : STA $012A
                 STA $1E02
    
    LDA $1F00 : BNE .alpha
        JSR $CAD8 ; $064AD8
        
        LDA.b #$01 : STA $1F00
        
        STZ $1E02
        
        INC $1E0A
    
    .alpha
    
    RTS
}

; ==============================================================================

; $064AD8-$064AE8 LOCAL JUMP LOCATION
{
    LDA $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $CAE9 ; $064AE9
    dw $CAFE ; $064AFE
    dw $CB1F ; $064B1F
    dw $CB84 ; $064B84
    dw $CBA1 ; $064BA1
}

; ==============================================================================

; $064AE9-$064B1E JUMP LOCATION
{
    LDA $1F02 : SEC : SBC.b #$02 : STA $1F02
    
    CMP.b #$02 : BCS .alpha
        STZ $1F02
        
        INC $1E00
        
        INC $B0
    
    .alpha
    
    ; $064AFE ALTERNATE ENTRY POINT
    
    LDA $B0 : CMP.b #$0A : BCC .beta
        INC $1E00
        
        LDA.b #$05 : STA $1E61
    
    .beta
    
    LDA $1F05 : CLC : ADC.b #$02 : STA $1F05
    
    LDA $1F04 : CLC : ADC.b #$01 : STA $1F04
    
    RTS
}

; ==============================================================================

; $064B1F-$064B83 JUMP LOCATION
{
    LDA.b #$C0 : STA $1E0C
    
    LDA.b #$01 : STA $1E0D
    
    LDA $1F02 : CMP.b #$80 : BCS .alpha
        ADC.b #$01 : STA $1F02
        
        BRA .beta
    
    .alpha
    
    LDA $1F05 : SEC : SBC.b #$0A : AND.b #$7F : CMP.b #$5C : BCC .beta
        LDA $1F04 : SEC : SBC.b #$0B : CMP.b #$DC : BCC .beta
            STZ $1F04
            
            STZ $1F05
            
            INC $B0
            
            INC $1E00
            
            LDA.b #$2C : STA $012E
            
            LDA.b #$FF : STA $7EC6AE
            
            LDA.b #$7F : STA $7EC6AF
            
            INC $15
            
            LDA.b #$06 : STA $1E01
            
            RTS
    
    .beta
    
    LDA $1F05 : CLC : ADC.b #$05 : STA $1F05
    
    LDA $1F04 : CLC : ADC.b #$03 : STA $1F04
    
    RTS
}

; ==============================================================================

; $064B84-$064BA1 JUMP LOCATION
{
    DEC $1E01
    
    LDA $1E01 : BNE .alpha
        LDA $0CC433 : STA $7EC6AE
        LDA $0CC434 : STA $7EC6AF
        
        INC $15
        
        INC $1E00
    
    .alpha
    
    ; $064BA1 ALTERNATE ENTRY POINT
    
    RTS
}

; ==============================================================================

; $064BA2-$064BAF LONG JUMP LOCATION
Credits_AnimateTheTriangles:
{
    PHB : PHK : PLB
    
    INC $1E0A
    
    JSR $CBB0 ; $064BB0
    JSR $C412 ; $064412
    
    PLB
    
    RTL
}

; ==============================================================================

; $064BB0-$064BC2 LOCAL JUMP LOCATION
{
    LDA.b #$01 : STA $012A
    
    LDA $1F00 : BNE .BRANCH_ALPHA
        JSR $CBC3 ; $04CBC3
        
        LDA.b #$01 : STA $1F00
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $064BC3-$064BD5 LOCAL JUMP LOCATION
{
    LDA $1F05 : CLC : ADC.b #$03 : STA $1F05
    LDA $1F04 : CLC : ADC.b #$01 : STA $1F04
    
    RTS
}

; ==============================================================================

; $064BE8-$064C12 JUMP LOCATION
{
    TXA : ASL A : TAY
    
    LDA.w $CBD6, Y : STA $1E30, X
    LDA.w $CBD7, Y : STA $1E38, Y
    LDA.w $CBDC, Y : STA $1E48, X
    LDA.w $CBDD, Y : STA $1E50, X
    LDA.w $CBE2, X : STA $1E58, X
    LDA.w $CBE5, X : STA $1E60, X
    
    INC $1E10, X
    
    RTS
}

; ==============================================================================

; $064C13-$064C22 JUMP LOCATION
{
    JSR $C82F ; $06482F
    JSR $CA4C ; $064A4C
    JSR $C9F1 ; $0649F1
    
    LDA $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $CC33 ; = $064C33
    dw $CC56 ; = $064C56
    dw $CC6B ; = $064C6B
    dw $CC8F ; = $064C8F
    dw $CC8F ; = $064C8F
}

; ==============================================================================

; $064C2D-$064C32 DATA
{
    db $FF, $00, $01
    db $FF, $FF, $FF
}

; $064C33-$064C55 JUMP LOCATION
{
    LDA $1E0A : AND.b #$07 : BNE .BRANCH_1
        LDA.w $CC2D, X : CLC : ADC $1E58, X : STA $1E58, X
    
    .BRANCH_1
    
    LDA $1E0A : AND.b #$03 : BNE .BRANCH_2
        LDA.w $CC30, X : CLC : ADC $1E60, X : STA $1E60, X
    
    .BRANCH_2
    
    RTS
}

; ==============================================================================

; $064C56-$064C5C JUMP LOCATION
{
    STZ $1E58, X
    STZ $1E60, X
    
    RTS
}

; ==============================================================================

; $064C5D-$064C6A DATA
{
    db $FF, $FF, $FF
    db $01, $01, $01, $EF, $11
    db $59, $5F, $67
    db $74, $68, $74
}

; ==============================================================================

; $064C6B-$064C8B JUMP LOCATION
{
    LDA $1E0A : AND.b #$03 : BNE .BRANCH_1
        JSR $CCB0 ; $064CB0
    
    .BRANCH_1
    
    LDA.w $CC65, X : CMP $1E30, X : BNE .BRANCH_2
        STZ $1E58, X
    
    .BRANCH_2
    
    LDA.w $CC68, X : CMP $1E48, X : BNE .BRANCH_3
        STZ $1E60, X
    
    .BRANCH_3
    
    RTS
}

; ==============================================================================

; $064C8C-$064C8E DATA
{
    db $72, $66, $72
}

; ==============================================================================

; $064C8F-$064CAF JUMP LOCATION
{
    LDA $1E0C : ORA $1E0D : BNE .BRANCH_1
        LDA.w $CC8C, X : STA $1E48, X
        
        RTS
    
    .BRANCH_1
    
    LDA $1E0C : SEC : SBC.b #$01 : STA $1E0C
    LDA $1E0D : SBC.b #$00 : STA $1E0D
    
    RTS
}

; ==============================================================================

; $064CB0-$064D0C LOCAL JUMP LOCATION
{
    LDA.w $CC65, X : CMP $1E30, X : BCC .BRANCH_1
        LDA.w $CC60, X
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.w $CC5D, X
    
    .BRANCH_2
    
    CLC : ADC $1E58, X : STA $1E58, X : CMP $CC63 : BNE .BRANCH_3
        LDA.w $CC63 : INC A
        
        BRA .BRANCH_4
    
    .BRANCH_3
    
    CMP $CC64 : BNE .BRANCH_5
        LDA.w $CC64 : INC A
        
        .BRANCH_4
        
        STA $1E58, X
    
    .BRANCH_5
    
    LDA.w $CC68, X : CMP $1E48, X : BCC .BRANCH_6
        LDA.w $CC60, X
        
        BRA .BRANCH_7
    
    .BRANCH_6
    
    LDA.w $CC5D, X
    
    .BRANCH_7
    
    CLC : ADC $1E60, X : STA $1E60, X : CMP $CC63 : BNE .BRANCH_8
        LDA.w $CC63 : INC A
        
        BRA .BRANCH_9
    
    .BRANCH_8
    
    CMP $CC64 : BNE .BRANCH_10
        LDA.w $CC64 : DEC A
        
        .BRANCH_9
        
        STA $1E60, X
    
    .BRANCH_10
    
    RTS
}

; ==============================================================================

; $064D0D-$064D18 DATA
{
    db $29, $00
    db $5F, $00
    db $97, $00
    
    ; $064D13
    db $70, $00
    db $20, $00
    db $70, $00
}

; ==============================================================================

; $064D19-$064D37 JUMP LOCATION
{
    TXA : ASL A : TAY
    
    LDA.w $CD0D, Y : STA $1E30, X
    LDA.w $CD0E, Y : STA $1E38, X
    LDA.w $CD13, Y : STA $1E48, X
    LDA.w $CD14, Y : STA $1E50, X
    
    INC $1E10, X
    
    RTS
}

; ==============================================================================

; $064D38-$064D3D DATA
{
    db $FF, $00, $01
    db $01, $F0, $01
}

; ==============================================================================

; $064D3E-$064D6F JUMP LOCATION
{
    JSR $C3BD ; $0643BD
    JSR $C82F ; $06482F
    JSR $C9F1 ; $0649F1
    
    LDA $11 : CMP.b #$24 : BNE .BRANCH_2
        LDA $1E20, X : CMP.b #$50 : BEQ .BRANCH_1
            INC $1E20, X
            
            LDA.w $CD38, X : CLC : ADC $1E58, X : STA $1E58, X
            LDA.w $CD3B, X : CLC : ADC $1E60, X : STA $1E60, X
        
        .BRANCH_1
        
        RTS
        
    .BRANCH_2
    
    STZ $1E20, X
    
    RTS
}

; ==============================================================================

; $064D70-$064D7C NONINDEXED DATA
{
    ; Unused?
    dw 0, 84, 168, -113
    
    ; $64D78
    
    db $4A, $6A, $8A, $AF, $BF
}

; ==============================================================================

; $064D7D-$0064D9C JUMP LOCATION
Module_SelectFile:
{
    ; Beginning of Module 1, Game Select Screen:
    STZ $E4
    STZ $E5
    STZ $EA
    STZ $EB
    
    LDA $11 ; Load the submodule index
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl $0CCD9D ; = $064D9D
    dl $0CCDF2 ; = $064DF2
    dl $0CCE53 ; = $064E53
    dl $0CCEA5 ; = $064EA5
    dl $0CCEB1 ; = $064EB1
    dl $0CCEBD ; = $064EBD
}

; ==============================================================================

; $064D9D-$064DF1 JUMP LOCATION
{
    JSL EnableForceBlank ; $00093D
    
    STZ $012A
    STZ $1F0C
    
    ; Play Fairy fountain theme.
    LDA.b #$0B : STA $012C
    
    INC $11
    
    LDA.b #$02 : STA $0AA9
    
    LDA.b #$06 : STA $0AB6 : STA $0710
    
    JSL Palette_DungBgMain
    JSL Palette_OverworldBgAux3
    
    LDA.b #$00 : STA $0AB2
    
    JSL Palette_Hud ; $0DEE52
    
    STZ $0202
    
    LDA.b #$01 : STA $0AA4
    LDA.b #$23 : STA $0AA1
    LDA.b #$51 : STA $0AA2
    
    JSL LoadDefaultGfx
    JSL InitTileSets
    JSL LoadSelectScreenGfx
    JSL Intro_ValidateSram
    JML Intro_LoadSpriteStats
}

; ==============================================================================

; $064DF2-$064E0E JUMP LOCATION
{
    LDX.b #$05
    
    .zeroLoop
    
    STZ $BF, X ; Zero out $BF - $C4
    
    DEX : BPL .zeroLoop
    
    ; $064DF9 ALTERNATE ENTRY POINT
    
    LDA.b #$80 : STA $0710
    
    JSL EnableForceBlank
    JSL Vram_EraseTilemaps_triforce
    JSL Palette_SelectScreen
    
    INC $15
    
    ; Go to the next submodule
    INC $11 
    
    RTL
}

; ==============================================================================

; $064E1B-$064E52 LOCAL JUMP LOCATION
{
    ; vram target is 0x1000 (0x2000 in bytes) aka BG0's tilemap
    LDA.w #$0010 : STA $1002
    
    ; blitting 0x800 bytes
    LDA.w #$FF07 : STA $1004
    
    STZ $00
    
    LDX.w #$0000
    
    .nextValue
    
        ; This will be zero when the loop begins.
        ; Y can end up as 0x00 or 0x02
        LDA $00 : PHA : AND.w #$0020 : LSR #4; TAY; 
        
        ; $064E17, A = 0xCE0F OR 0xCE13
        LDA.w $CE17, Y : STA $02
        
        ; A is Odd or Even?
        ; i.e. 0x00 if even or 0x02 if odd
        PLA : AND.w #$0001 : ASL A : TAY
        
        ; Notice in this function that $00 ranges over 0x0 - 0x3FF
        ; Addresses written range from $1006 to $1805
        ; Sets up a complex data table.
        LDA ($02), Y : STA $1006, X
        
        INX #2 
        
        INC $00
    ; The number of words that will be written.
    LDA $00 : CMP.w #$0400 : BNE .nextValue
    
    RTS
}

; ==============================================================================

; $064E53-$064EA4 JUMP LOCATION
{
    PHB : PHK : PLB
    
    REP #$30
    
    JSR $CE1B ; $064E1B
    
    LDY.w #$00DE ; Y's usage is an index in what follows (for a loop)
    
    .loop
    
        ; Addresses $1806 - $18E5 are written
        LDA.w $E1C8, Y : STA $1806, Y
        
        ; Notice that X is increasing but has nothing to do with the loop.
        INX #2
    DEY #2 : BPL .loop
    
    LDA.w #$1103 : STA $00
    
    ; Index for the following loop.
    LDA.w #$0011 : STA $02
    
    .loop2
    
        ; If you've been paying attention, you'd know that X places STA at $18E6
        ; Write a series of numbers 0x0311, 0x0331, 0x0351, etc.
        LDA $00 : XBA : STA $1006, X
        
        ; Write from $18E6-$194D
        XBA : CLC : ADC.w #$0020 : STA $00
        
        INX #2
        
        ; Store fixed numbers after the varying number above.
        LDA.w #$3240 : STA $1006, X
        
        INX #2
        
        LDA.w #$347F : STA $1006, X
        
        ; All in all 0x66 bytes are written
        INX #2
    ; We'll loop #$11 times
    DEC $02 : BPL .loop2
    
    SEP #$20 ; Accumulator is now 8-bit.
    
    ; Possibly an ending indicator for this block of data.
    ; Written at $194E
    LDA.b #$FF : STA $1006, X
    
    SEP #$10
    
    INC $11 ; Increment the submodule index.
    
    JMP $D09C ; $06509C
}

; ==============================================================================

; $064EA5-$064EB0 JUMP LOCATION
FileSelect_TriggerStripesAndAdvance:
{
    LDA $0B9D : STA $CB
    
    .alpha
    
    INC $11 ; Increment the submodule index.
        
    LDA.b #$06 : STA $14
        
    RTL
}

; $064EB1-$064EBC
{
    JSR $CEC7 ; $064EC7
        
    LDA.b #$0F : STA $13
        
    STZ $0710

    BRA FileSelect_TriggerStripesAndAdvance_alpha
}

; ==============================================================================

; $064EBD-$064EC6 JUMP LOCATION
{
    ; Module 0x01.0x05
    
    PHB : PHK : PLB
    
    JSL $0CCEDC ; ($064EDC) Main logic for the select screen.
    JMP $D09C   ; ($06509C) Sets the tile map update flag and exits.
}

; ==============================================================================

; $064EC7-$064EDB LOCAL JUMP LOCATION
{
    PHB : PHK : PLB
    
    REP #$10
    
    LDX.w #$00FD
    
    .BRANCH_1
    
        ; Write from $1001 to $10FE
        LDA.w $E358, X : STA $1001, X
    DEX : BNE .BRANCH_1
    
    SEP #$10
    
    PLB
    
    RTS
}

; ==============================================================================

; $064EDC-$065052 JUMP LOCATION
{
    ; This routine handles input on the select screen, changing it appropriately
    
    ; The menu index on the select screen (0-2 save files)
    ; (3 - copy player, 4 - erase player)
    LDA $C8 : CMP.b #$03 : BCS .notSaveFile
        STA $0B9D
    
    .notSaveFile
    
    REP #$30
    
    LDX.w #$0000
    
    .nextFile
    
        STX $00
        
        ; $048C, X; it holds the SRAM offsets. 
        ; X = #$0, #$500, #$A00
        LDA $00848C, X : TAX
        
        ; isValid variable
        ; If the file actually has this written, we do something.
        ; What happens if the file is empty
        LDA $7003E5, X : CMP.w #$55AA : BNE .invalidSaveFile
        
        ; Here we actually have a file to work with.
        ; X = 0x00, 0x02, or 0x04
        ; Write a 1 to each entry of $BF that corresponds to an active file
        PHX : LDX $00 : LDA.w #$0001 : STA $BF, X : PLX
        
        LDA.w #$D698 : STA $04
        LDA.w #$D699 : STA $02
        
        PHX ; Save the SRAM offset
        
        ; set OAM for Link's shield and sword (mainly)
        JSR $D6AF ; $0656AF
        
        ; set number of deaths OAM
        JSR $D7DB ; $0657DB
        
        PLX ; Restore the SRAM offset
        
        ; draw hearts and player's name for this file.
        JSR $D63C ; $06563C
        
        .invalidSaveFile
    ; If there's more files to look at, go back to .BRANCH_2
    LDX $00 : INX #2 : CPX.w #$0006 : BCC .nextFile
    
    SEP #$30
    
    ; Index of the "fairy" cursor 0-4
    LDX $C8
    
    LDA.b #$1C : STA $00
    
    ; Tells us what height the "fairy" selector should be at.
    LDA.w $CD78, X : STA $01
    
    ; animates the fairy icon
    JSR SelectFile_DrawFairy
    
    LDY.b #$02
    
    ; Ignore left and right. See info on $4218, joypad 1
    ; In this case, no important buttons are down.
    LDA $F6 : AND.b #$C0 : ORA $F4 : AND.b #$FC : BEQ .return
    
    AND.b #$2C : BEQ .actionButtonDown
        AND.b #$08 : BEQ .dpadDownButton ; What happens if the down direction was pressed
        
            ; What happens if up or select was pressed.
            LDA.b #$20 : STA $012F
            
            DEC $C8 : BPL .done
                ; This allows the fairy to wrap around to the bottom.
                LDA.b #$04 : STA $C8
                
                BRA .done
        
        .dpadDownButton
        
        LDA.b #$20 : STA $012F
        
        INC $C8
        
        LDA $C8 : CMP.b #$05 : BNE .done
        
        STZ $C8 ; Allows the fairy to wrap around to the top
        
        .done
        
        BRA .return
    
    .actionButtonDown
    
    LDA.b #$2C : STA $012E
    
    LDA $C8 : CMP.b #$03 : BEQ .gotoCopyMode
        BCS .gotoEraseMode
            ; Otherwise, find out which save slot this is.
            LDA $C8 : ASL A : TAX
            
            ; If this save file is empty, go to the naming mode for a new player.
            LDA $BF, X : BEQ .emptyFile
                ; Tells us to cut the music for the moment.
                LDA.b #$F1 : STA $012C
                
                ; As to not interfere with the 16 bit value of $C8
                STZ $C9
                
                REP #$20
                
                ;  Obtain the SRAM offset of the save file we chose.
                LDA $00848C, X : STA $00
                
                ;  A = #$02, #$04, #$06
                ; Indicates in SRAM which save slot was loaded last.
                LDA $C8 : ASL A : INC #2 : STA $701FFE
                
                SEP #$20
                
                BRL .loadSram ; Why this is a long branch (BRL), I have no idea.
            
            .emptyFile
            
            STZ $C9
            
            LDY.b #$04 ; Gives the signal to go to naming mode.
            
            BRA .changeMode
            
    .gotoCopyMode
            
    ; gives the signal to go to copy mode.
    LDY.b #$02
            
    BRA .checkIfFilesPresent
    
    .gotoEraseMode
    
    ; Gives the signal to go to erase mode.
    LDY.b #$03
    
    .checkIfFilesPresent
    
    ; Checking to see if there are any files actually written...
    LDA $BF : ORA $C1 : ORA $C3 : BNE .filesExist
        ; since no files exist to be copied / erased, the error noise is played
        LDA.b #$3C : STA $012E
        
        BRA .return
    
    .filesExist
    
    STZ $C8
    
    .changeMode
    
    ; Set the next mode to copy, erase, or name mode.
    STY $10
    
    ; Reset the submodule indices.
    STZ $11 : STZ $B0
    
    .return
    
    RTL
    
    ; $064FBB ALTERNATE ENTRY POINT
    .loadSram
    
    ; We end up here if we've selected a game that has data in it already.
    LDX.b #$0F
    
    LDA.b #$00 : STA $001AC0, X : STA $001AE0, X
    LDA.b #$00 : STA $001AB0, X : STA $001AD0, X : STA $001AF0, X
    
    PHB : LDA.b #$7E : PHA : PLB
    
    REP #$30
    
    ; The SRAM offset based on which save slot you picked.
    LDY.w #$0000 : LDX $00
    
    .sramLoadLoop
    
        ; Loads the save file from SRAM into WRAM ($7EF000-$7EF4FF)
        LDA $700000, X : STA $F000, Y
        LDA $700100, X : STA $F100, Y
        LDA $700200, X : STA $F200, Y
        LDA $700300, X : STA $F300, Y
        LDA $700400, X : STA $F400, Y
        
        INX #2
    INY #2 : CPY.w #$0100 : BNE .sramLoadLoop
    
    PLB
    
    LDA.w #$0007 : STA $7EC00D : STA $7EC013
    LDA.w #$0000 : STA $7EC00F : STA $7EC015
    
    LDA.w #$6040 : STA $0219
    LDA.w #$4841 : STA $021D
    LDA.w #$007F : STA $021F
    LDA.w #$FFFF : STA $0221
    
    SEP #$30
    
    LDA.b #$80 : STA $0204
    
    ; Send us to module 5
    LDA.b #$05 : STA $10
    
    STZ $11 : STZ $010E : STZ $0710 : STZ $0AB2
    
    RTL
}

; ==============================================================================

; $065053-$06506D JUMP LOCATION
Module_CopyFile:
{
    ; Beginning of Module 0x02, Copy Game
    
    STZ $0B9D
    
    LDA $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl $0CCDF9 ; = $064DF9 ; Sets up palettes and other things.
    dl $0CCE53 ; = $064E53 ; 
    dl $0CD06E ; = $06506E
    dl $0CD087 ; = $065087
    dl $0CD0A2 ; = $0650A2
    dl $0CD0B9 ; = $0650B9
}

; ==============================================================================

; $06506E-$065086 JUMP LOCATION
{
    LDA.b #$07
    
    ; $065070 ALTERNATE ENTRY POINT
    
    JSR $C52E ; $06452E
    
    LDA.b #$0F : STA $13
    
    STZ $0710
    
    LDX.b #$FE
    
    .loop
    
        INX #2
    LDA $BF, X : BEQ .loop
    
    TXA : LSR A : STA $C8
    
    RTL
}

; ==============================================================================

; $065087-$0650B8 JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR $D13F ; $06513F
    
    LDA $11 : CMP.b #$03 : BNE .BRANCH_1
        LDA $1A : AND.b #$30 : BNE .BRANCH_1
            JSR $D0C6 ; $0650C6
    
    .BRANCH_1
    ; $06509C ALTERNATE ENTRY POINT
    
    ; Indicates to the NMI routine that the tilemap needs updating.
    LDA.b #$01 : STA $14
    
    PLB
    
    RTL
    
    ; $0650A2 ALTERNATE ENTRY POINT
    
    PHB : PHK : PLB
    
    JSR $D27B ; $06527B
    
    LDA $11 : CMP.b #$04 : BNE .BRANCH_2
        LDA $1A : AND.b #$30 : BNE .BRANCH_1
            JSR $D0C6 ; $0650C6
    
    .BRANCH_2
    
    BRA .BRANCH_1
}

; ==============================================================================

; $0650B9-$0650C1 JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR $D371 ; $065371
    JMP $D09C ; $06509C
}

; ==============================================================================

; $0650C2-$0650C5 DATA
{
    ; TODO: Name this pool / routine.
    
    .offsets
    dw $0004
    dw $001E
}

; ==============================================================================

; $0650C6-$0650E5 LOCAL JUMP LOCATION
{
    REP #$30
    
    LDX.w #$0002
    LDA.w #$00A9
    
    .BRANCH_1
    
        LDY.w #$000B : STY $00
        
        LDY.w $D0C2, X
        
        .BRANCH_2
        
            STA $1002, Y
            
            INY #2
        DEC $00 : BNE .BRANCH_2
    DEX #2 : BPL .BRANCH_1
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $06513F-$065239 LOCAL JUMP LOCATION
{
    REP #$10
    
    LDX.w #$00AC : STX $1000
    
    .BRANCH_1
    
        LDA.w $E68D, X : STA $1002, X
    DEX : BPL .BRANCH_1
    
    REP #$20
    
    LDX.w #$0000
    
    .BRANCH_2
    
        STX $00
        
        LDA $BF, X : AND.w #$0001 : BEQ .BRANCH_4
            LDA $00848C, X
            
            TXY
            
            TAX
            
            LDA.w $D139, Y : TAY
            
            LDA.w #$0006 : STA $02
            
            .BRANCH_3
            
                LDA $7003D9, X : CLC : ADC.w #$1800 : STA $1002, Y
                                CLC : ADC.w #$0010 : STA $1016, Y
                
                INX #2
                
                INY #2
            DEC $02 : BNE .BRANCH_3
        
        .BRANCH_4
    LDX $00 : INX #2 : CPX.w #$0006 : BCC .BRANCH_2
    
    SEP #$30
    
    LDX $C8
    
    LDA.w $D0E6, X : STA $00
    LDA.w $D0EA, X : STA $01
    
    JSR SelectFile_DrawFairy
    
    LDA $F6 : AND.b #$C0 : ORA $F4 : AND.b #$FC : BNE .BRANCH_5
        BRL .BRANCH_17
    
    .BRANCH_5
    
    AND.b #$2C : BEQ .BRANCH_12
        AND.b #$08 : BEQ .BRANCH_8
            LDX $C8 : DEX : BPL .BRANCH_7
                .BRANCH_6
                
                    TXA : ASL A : TAY
                    
                    LDA $00BF, Y : BNE .BRANCH_11
                DEX : BPL .BRANCH_6
            
            .BRANCH_7
            
            LDX.b #$03
            
            BRA .BRANCH_11
        
        .BRANCH_8
        
        LDX $C8 : INX : CPX.b #$03 : BCS .BRANCH_10
            .BRANCH_9
            
            TXA : ASL A : TAY
            
            LDA $00BF, Y : BNE .BRANCH_11
                INX : CPX.b #$03 : BNE .BRANCH_9
                    BRA .BRANCH_11
        
        .BRANCH_10
        
        CPX.b #$04 : BNE .BRANCH_11
            LDX.b #$00
            
            BRA .BRANCH_9
        
        .BRANCH_11
        
        LDA.b #$20 : STA $012F
        
        STX $C8
        
        BRA .BRANCH_17
    
    .BRANCH_12
    
    ; Presumably record that the result was 0x2C.
    LDA.b #$2C : STA $012E
    
    ; $C8 Indexes your selection so far.
    ; i.e. They chose the quit option. #$0-2 are the save games.
    LDA $C8 : CPX.b #$03 : BEQ .BRANCH_15
    
        ; So if they didn't choose to quit... they must have chosen a game to copy
        ASL A : STA $CC
        
        ; So use the menu index shifted left ( $C8 * 2 -> $CC)
        STZ $CD
        
        LDX.b #$49
        
        .BRANCH_13
        
            ; $0650ED
            LDA.w $D0ED, X : STA $1035, X
        DEX : BNE .BRANCH_13
        
        ; Tell me what menu item they really picked...
        LDX $C8 : CPX.b #$02 : BEQ .BRANCH_14
            ; If not, then look up a value...
            LDA.w $D137, X : TAX
            
            LDA.b #$6C : STA $1036, X : STA $103C, X
            
            LDA.b #$27 : STA $1037, X : CLC : ADC.b #$20 : STA $103D, X
        
        .BRANCH_14
        
        INC $11
        
        BRA .BRANCH_16
    ; $06522D ALTERNATE ENTRY POINT
    .BRANCH_15
    
    LDA.b #$01 : STA $10 ; This means the mode will change to select screen mode.
    LDA.b #$01 : STA $11 ; And the submodule will be the second (#$01) one.
    
    STZ $B0 ; Reset the sub-index of the submodule as well.
    
    .BRANCH_16
    
    STZ $C8 ; Reset the menu marker too
    
    .BRANCH_17
    
    RTS
}

; ==============================================================================

; $06527B-$06536E LOCAL JUMP LOCATION
{
    LDA.b #$04
    LDX.b #$01
    
    .BRANCH_1
    
        CMP $CC : BNE .BRANCH_2
            STA $CA, X : DEX
        
        .BRANCH_2
    DEC A : DEC A : BPL .BRANCH_1
    
    REP #$10
    
    LDX.w #$0084 : STX $0E
    
    .BRANCH_3
    
        LDA.w $E73A, X : STA $1002, X
    DEX : BPL .BRANCH_3
    
    REP #$20
    
    LDX.w #$0000 : STX $04
    
    .BRANCH_4
    
        STX $00 : CPX $CC : BEQ .BRANCH_6
            LDY $04 : LDA.w $D271, Y : TAY
            
            INC $04 : INC $04
            
            LDA.w $D275, X  : STA $1002, Y
            CLC : ADC.w #$0010 : STA $1016, Y
            
            LDA $BF, X : BEQ .BRANCH_6
                LDA.w #$0006 : STA $02
                
                LDA $00848C, X : TAX
                
                .BRANCH_5
                
                    LDA $7003D9, X : CLC : ADC.w #$1800 : STA $1006, Y
                    
                    CLC : ADC.w #$0010 : STA $101A, Y
                    
                    INX #2
                    
                    INY #2
                DEC $02 : BNE .BRANCH_5
        
        .BRANCH_6
    LDX $00 : INX #2 : CPX.w #$0006 : BCC .BRANCH_4
    
    LDX $0E : STX $1000
    
    SEP #$30
    
    LDX $C8 : LDA.w $D26B, X : STA $00
    
    LDA.w $D26E, X : STA $01
    
    JSR SelectFile_DrawFairy
    
    LDA $F6 : AND.b #$C0 : ORA $F4
    
    AND.b #$FC : BEQ .BRANCH_14
        AND.b #$2C : BEQ .BRANCH_9
            AND.b #$08 : BEQ .BRANCH_7
                LDX $C8 : DEX : BPL .BRANCH_8
                    LDX.b #$02
                
                    BRA .BRANCH_8
            
            .BRANCH_7
            
            LDX $C8 : INX : CPX.b #$03 : BCC .BRANCH_8
                LDX.b #$00
            
            .BRANCH_8
            
            LDA.b #$20 : STA $012F : STX $C8
        
        BRA .BRANCH_14
    
        .BRANCH_9
        
        LDA.b #$2C : STA $012E
        
        LDX $C8 : CPX.b #$02 : BEQ .BRANCH_12
            LDA $CA, X : STA $CA : STZ $CB
            
            LDX.b #$30
            
            .BRANCH_10
            
                ; write out "copy ok?"
                LDA.w $D23A, X : STA $1036, X
            DEX : BPL .BRANCH_10
            
            LDA $C8 : BNE .BRANCH_11
                LDA.b #$62 : STA $1036 : STA $103C
                
                LDA.b #$14  : STA $1037
                CLC : ADC.b #$20 : STA $103D
            
            .BRANCH_11
            
            INC $11
            
            BRA .BRANCH_13
        
        .BRANCH_12
        
        JSR $D22D ; $06522D
        
        .BRANCH_13
        
        STZ $C8
    
    .BRANCH_14
    
    RTS
}

; ==============================================================================

; $06536F-$065370 DATA
{
    .unknown_
    db $AF, $BF
}

; ==============================================================================

; $065371-$0653DB LOCAL JUMP LOCATION
{
    LDX $C8
    
    LDA.b #$1C   : STA $00
    LDA.w $D36F, X : STA $01
    
    JSR SelectFile_DrawFairy
    
    LDA $F6 : AND.b #$C0 : ORA $F4
    
    AND.b #$FC : BEQ .BRANCH_4
        AND.b #$2C : BEQ .BRANCH_2
            AND.b #$24 : BEQ .BRANCH_1
                LDA.b #$20 : STA $012F
                
                INC $C8
                
                LDA $C8 : CMP.b #$02 : BCC .BRANCH_4
                    STZ $C8
                
                BRA .BRANCH_4
            
            .BRANCH_1
            
            LDA.b #$20 : STA $012F
            
            DEC $C8 : BPL .BRANCH_4
                LDA.b #$01 : STA $C8
            
                BRA .BRANCH_4
        
        .BRANCH_2
        
        LDA.b #$2C : STA $012E
        
        LDA $C8 : BNE .BRANCH_3
            REP #$30
            
            LDX $CA : LDA $00848C, X : TAY
            LDX $CC : LDA $00848C, X : TAX
            
            JSR $D3DC ; $0653DC
            
            LDX $CA
            
            LDA.w #$0001 : STA $BF, X
            
            SEP #$30
        
        .BRANCH_3
        
        JSR $D22D ; $06522D
        
        STZ $C8
    
    .BRANCH_4
    
    RTS
}

; ==============================================================================

; $0653DC-$065415 LOCAL JUMP LOCATION
{
    SEP #$20
    
    ; Set data bank register to 0x70 (SRAM)
    PHB : LDA.b #$70 : PHA : PLB
    
    REP #$20
    
    LDA.w #$0080 : STA $00
    
    .BRANCH_1
    
        LDA $0000, X : STA $0000, Y
        LDA $0001, X : STA $0001, Y
        LDA $0002, X : STA $0002, Y
        LDA $0003, X : STA $0003, Y
        LDA $0004, X : STA $0004, Y
        
        INX #2
        
        INY #2
    DEC $00 : BNE .BRANCH_1
    
    SEP #$20
    
    PLB
    
    REP #$20
    
    RTS
}

; ==============================================================================

; $065485-$065499 JUMP LOCATION
Module_EraseFile:
{
    ; Beginning of Module 3, Erase Mode:
    
    LDA $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl $0CCDF9 ; = $064DF9
    dl $0CCE53 ; = $064E53
    dl $0CD49A ; = $06549A
    dl $0CD49F ; = $06549F
    dl $0CD4B1 ; = $0654B1
}

; $06549A-$06549E JUMP LOCATION
{
    LDA.b #$08
    
    JMP $D070 ; $065070
}

; $06549F-$0654B0 JUMP LOCATION
{
    PHB : PHK : PLB
    
    LDA $C8 : CMP.b #$03 : BCS .alpha
    
    STA $0B9D
    
    .alpha
    
    JSR $D4BA ; $0654BA
    JMP $D09C ; $06509C
}

; ==============================================================================

; $0654B1-$0654B9 JUMP LOCATION
{
    PHB : PHK : PLB
    
    JSR $D599 ; $065599
    JMP $D09C ; $06509C
}

; ==============================================================================

; $0654BA-$065596 LOCAL JUMP LOCATION
{
    REP #$10
    
    LDX.w #$00FD
    
    .BRANCH_1
    
        LDA.w $E53E, X : STA $1001, X
    DEX : BNE .BRANCH_1
    
    REP #$20
    
    LDX.w #$0000
    
    .BRANCH_2
    
        STX $00
        
        LDA $BF, X : AND.w #$0001 : BEQ .BRANCH_3
            LDA $00848C, X : TAX
            
            JSR $D63C ; $6563C
        
        .BRANCH_3
    LDX $00 : INX #2 : CPX.w #$0006 : BCC .BRANCH_2
    
    SEP #$30
    
    LDX $C8
    
    LDA.w $D416, X : STA $00
    LDA.w $D41A, X : STA $01
    
    JSR SelectFile_DrawFairy
    
    LDY.b #$02
    
    LDA $F4 : AND.b #$20 : BNE .BRANCH_6
        LDA $F4
        
        AND.b #$0C : BEQ .BRANCH_9
            AND.b #$04 : BNE .BRANCH_6
                LDA.b #$20 : STA $012F
                
                LDY.b #$FE
                
                LDX $C8 : DEX : BMI .BRANCH_5
                    .BRANCH_4
                    
                        TXA : ASL A : TAY
                        
                        LDA $00BF, Y : BNE .BRANCH_9
                    DEX : BPL .BRANCH_4
                
                .BRANCH_5
                
                LDX.b #$03
                
                BRA .BRANCH_9
    
    .BRANCH_6
    
    LDA.b #$20 : STA $012F
    
    LDX $C8 : INX : CPX.b #$03 : BCS .BRANCH_8
        .BRANCH_7
        
            TXA : ASL A : TAY
            
            LDA $00BF, Y : BNE .BRANCH_9
        INX : CPX.b #$03 : BNE .BRANCH_7

        BRA .BRANCH_9
    
    .BRANCH_8
    
    CPX.b #$04 : BNE .BRANCH_9
        LDX.b #$00
        
        BRA .BRANCH_7
    
    .BRANCH_9
    
    STX $C8
    
    LDA $F6 : AND.b #$C0 : ORA $F4 : AND.b #$D0 : BEQ .BRANCH_13
        LDA.b #$2C : STA $012E
        
        LDA $C8 : CMP.b #$03 : BEQ .BRANCH_12
            LDX.b #$64
            
            .BRANCH_10
            
            LDA.w $D41E, X : STA $1002, X
            
            DEX : BPL .BRANCH_10
            
            INC $11
            
            LDX $C8 : CPX.b #$02 : BEQ .BRANCH_11
                LDA.w $D483, X : TAX
                
                LDA.b #$62 : STA $1002, X : STA $1008, X
                
                LDA.b #$67  : STA $1003, X
                CLC : ADC.b #$20 : STA $1009, X
            
            .BRANCH_11
            
            LDA $C8 : STA $B0
            
            STZ $C8
            
            BRA .BRANCH_13
        
        .BRANCH_12
        
        SEP #$30
        
        JSR $D22D ; $06522D
    
    .BRANCH_13
    
    RTS
}

; ==============================================================================

; $065597-$065598 DATA
{
    ; TODO: Name this pool / routine.
    
    .y_offsets
    db $AF, $BF
}

; ==============================================================================

; $065599-$06562F LOCAL JUMP LOCATION
{
    LDA $B0 : ASL A : STA $00
    
    REP #$30
    
    LDX $C8
    
    LDA.b #$1C : STA $00
    
    LDA .y_offsets, X : STA $01
    
    JSR SelectFile_DrawFairy
    
    LDY.b #$02
    
    LDA $F4 : AND.b #$2C : BEQ .BRANCH_3
        AND.b #$24 : BNE .BRANCH_1
            DEX
            
            BRA .BRANCH_2
        
        .BRANCH_1
        
        INX
        
        .BRANCH_2
        
        TXA : AND.b #$01 : STA $C8
        
        LDA.b #$20 : STA $012F
    
    .BRANCH_3
    
    LDA $F6 : AND.b #$C0 : ORA $F4 : AND.b #$D0 : BEQ .BRANCH_6
        AND.b #$2C : STA $012E
        
        LDA $C8 : BNE .BRANCH_5
            LDA.b #$22 : STA $012F
            
            STZ $012E
            
            REP #$30
            
            LDA $B0 : AND.w #$00FF : ASL A : TAX
            
            STZ $BF, X
            
            LDA $00848C, X : TAX
            
            LDY.w #$0000 : TYA
            
            .BRANCH_4
            
                STA $700000, X : STA $700100, X : STA $700200, X : STA $700300, X
                STA $700400, X : STA $700F00, X : STA $701000, X : STA $701100, X
                STA $701200, X : STA $701300, X
                
                INX #2
            INY #2 : CPY.w #$0100 : BNE .BRANCH_4
            
            SEP #$30
        
        .BRANCH_5
        
        JSR $D22D ; $06522D
        
        STZ $B0
    
    .BRANCH_6
    
    RTS
}

; ==============================================================================

; $06563C-$065694 LOCAL JUMP LOCATION
{
    ; Draws both the Player's name and the hearts of that player to screen.
    
    PHX
    
    ; sets the position in the tilemap buffer to draw to.
    LDY $00 : LDA.w $D630, Y : TAY
    
    LDA.w #$0006 : STA $02
    
    .nextLetter
    
        LDA $7003D9, X : CLC : ADC.w #$1800 : STA $1002, Y
        
        CLC : ADC.w #$0010 : STA $102C, Y
        
        INX #2
        
        INY #2
    DEC $02 :BNE .nextLetter
    
    PLX
    
    LDY.w #$0001 : LDA $70036C, X : AND.w #$00FF : LSR #3 : STA $02
    
    LDX $00 : LDY.w $D636, X : STY $04
    
    LDA.w #$0520 : LDX.w #$000A
    
    .nextHeart
    
        STA $1002, Y
        
        INY #2 : DEX : BNE .BRANCH_3
            PHA
            
            LDA $04 : CLC : ADC.w #$002A : TAY
            
            PLA
        
        .BRANCH_3
    DEC $02 : BNE .nextHeart
    
    RTS
}

; $065695 - $656AE DATA TABLE
{
    db $01, $06, $0B
    db $34
    db $43, $63, $83
    db $28, $3C, $50
    db $85, $A1, $A1, $A1
    db $C4, $CA, $E0
    db $72, $76, $7A
    db $32, $36, $3A
    db $30, $34, $38
}

; ==============================================================================

; $0656AF-$0657A2 LOCAL JUMP LOCATION
{
    REP #$30
    
    LDA.w #$0116 : ASL A : STA $0100
    
    ; A = 0, 2, 4, or 6
    LDA $00 : AND.w #$00FF : TAX
    
    ; Get that SRAM offset again,  Mirror it at $0E
    LDA $00848C, X : STA $0E
    
    SEP #$30
    
    ; A = 0, 1, 2, or 3
    LDA $00 : LSR A : TAY
    
    ; $06569C that is. A -> #$28, #$3C, #$50
    ; in Decimal 40, 60, 80
    LDA.w $D69C, Y : TAX
    
    ; $D698 -> $65698 #$34 = 52
    ; A -> #$40 = 64
    ; Mirror to this location.
    LDA ($04) : CLC : ADC.b #$0C : STA $0800, X : STA $0804, X
    
    ; i.e. from $D699, Y; A = 0x43, 0x63, or 0x83
    ; A = 0x3E, 0x5E, or 0x7E
    LDA ($02), Y : CLC : ADC.b #$FB : STA $0801, X
    
    ; The last add obviously overflowed, so clc
    ; A -> 0x46, 0x66, or 0x86
    CLC : ADC.b #$08 : STA $0805, X
    
    ; A -> #$72, #$76, #$7A
    LDA.w $D6A6, Y : STA $0803, X : STA $0807, X
    
    PHY : PHX 
    
    REP #$10
    
    ; Retrieve the SRAM offset
    LDX $0E
    
    ; Give me the sword value.
    LDA $700359, X
    
    SEP #$10
    
    PLX ; X -> #$28, #$3C, #$50
    
    ; Y -> #$0, #$1, #$2, #$3, #$4
    TAY : DEY : BPL .hasSword
        ; We'll end up here if Link doesn't have a sword.
        ; Apparently 0xF0 disables these sprites?
        LDA.b #$F0 : STA $0801, X : STA $0805, X
        
        ; So yeah, we want that 0 back from the 0xFF it was.
        INY
    
    .hasSword
    
    ; A -> #$85, #$A1, #$A1, #$A1 (#$85 is for the fighter sword shape)
    ; I guess this is where the sprite data for the sword is kept.
    LDA.w $D69F, Y : STA $0802, X
    
    ; Adding 0x10 gives you the lower part of the sword. (0x95 or 0xB1)
    ; So this is also tile data apparently.
    CLC : ADC.b #$10 : STA $0806, X
    
    ; Y -> #$0, #$1, #$2, #$3
    PLY
    
    ; 0x28, 0x3C, or 0x50 -> Stack
    ; X -> 0x0A, 0x0F, or 0x14 (10,15,20)
    ; A -> 0x28, 0x3C, or 0x50
    PHX : TXA : LSR #2 : TAX
    
    LDA.w #$00 : STA $0A20, X : STA $0A21, X
    
    ; A -> 0x28, 0x3C, or 0x50
    ; A -> 0x30, 0x44, or 0x58
    PLA : CLC : ADC.b #$08 : TAX
    
    ; $065698 A -> #$34
    ; A -> 0x2F
    ; Controls the position of the shield on the select screen.
    LDA ($04) : CLC : ADC.b #$FB : STA $0800, X
    
    ; Controls the display of the shield on the select screen.
    LDA ($02), Y : CLC : ADC.b #$0A : STA $0801, X
    
    ; A -> #$32, #$36, #$3A
    LDA.w $D6A9, Y : STA $0803, X
    
    PHY : PHX
    
    REP #$10
    
    ; X -> SRAM offset
    LDX $0E
    
    ; Load what shield Link has
    LDA $70035A, X
    
    SEP #$10
    
    PLX
    
    TAY : DEY : BPL .hasShield
        ; If Link doesn't have a shield, don't draw one (-> #$F0)
        LDA.b #$F0 : STA $0801, X
        
        ; Put it back to zero like it should be.
        INY
    
    .hasShield
    
    ; Tells us which graphic to use for the shield
    LDA.w $D6A3, Y : STA $0802, X
    
    ; We're back to Y = 0x0, 0x1, or 0x2
    PLY
    
    PHX
    
    TXA : LSR #2 : TAX
    
    LDA.b #$02 : STA $0A20, X
    
    PLA : CLC : ADC.b #$04 : TAX
    
    LDA ($04) : STA $0800, X : STA $0804, X
    
    LDA.b #$00 : STA $0802, X
    LDA.b #$02 : STA $0806, X
    
    LDA.w $D6AC, Y : STA $0803, X
    ORA.b #$40   : STA $0807, X
    
    LDA ($02), Y : STA $0801, X
    CLC : ADC.b #$08  : STA $0805, X
    
    TXA : LSR #2 : TAX
    
    LDA.b #$02 : STA $0A20, X : STA $0A21, X
    
    REP #$30
    
    RTS
}

; ==============================================================================

; $0657A3-$0657A4 DATA
pool SelectFile_DrawFairy:
{
    .chr
    db $A8, $AA
}

; ==============================================================================

; $0657A5-$0657CA LOCAL JUMP LOCATION
SelectFile_DrawFairy:
{
    ; This routine animates the fairy on the select screen.
    
    LDA $00 : STA $0800
    LDA $01 : STA $0801
    
    PHX
    
    LDX.b #$00
    
    ; Alternate 8 frames one way, 8 frames another
    LDA $1A : AND.b #$08 : BEQ .set_chr
        INX
    
    .set_chr
    
    LDA .chr, X : STA $0802
    
    PLX
    
    LDA.b #$7E : STA $0803
    
    LDA.b #$02 : STA $0A20
    
    RTS
}

; ==============================================================================

; $0657DB-$065889 LOCAL JUMP LOCATION
{
    !onesDigit     = $02
    !tensDigit     = $04
    !hundredsDigit = $06
    
    REP #$30
    
    LDA $02 : PHA : STA $08
    LDA $04 : PHA : STA $0A
    
    ; check the death counter
    ; (which is set to 0xFFFF until you beat the game.)
    LDX $0E : LDA $700405, X : CMP.w #$FFFF : BNE .gameBeaten
        JMP .return ; $065883
    
    .gameBeaten
    
    CMP.w #$03E8 : BCC .lessThan1000 ; less than a thousand
        ; the number of deaths maxes out at 999, so we just set the digits to all 9s.
        LDA.w #$0009 : STA !onesDigit : STA !tensDigit : STA !hundredsDigit
        
        BRA .BRANCH_7
    
    .lessThan1000
    
    LDY.w #$0000
    
    .onesDigitLoop
    
        CMP.w #$000A : BCC .breakOnesLoop
            SEC : SBC.w #$000A
            
            INY
    BRA .onesDigitLoop
    
    .breakOnesLoop
    
    STA !onesDigit
    
    ; Y contains number of deaths divided by 10
    TYA : LDY.w #$0000
    
    .tensDigitLoop
    
        CMP.w #$000A : .breakTensLoop
            SEC : SBC.w #$000A
            
            INY
    BRA .tensDigitLoop
    .breakTensLoop
    
    STA !tensDigit : STY !hundredsDigit
    
    .BRANCH_7
    
    LDX.w #$0004
    
    LDA !hundredsDigit : BNE .setHighestDigit
        DEX #2
        
        LDA !tensDigit : BNE .setHighestDigit
            DEX #2
        
    .setHighestDigit
    
    SEP #$30
    
    LDA $00 : LSR A : TAY
    
    LDA.w $D7D5, Y : TAY
    
    .nextDigit
    
        PHX
        
        LDA $02, X : TAX
        
        ; set the sprite CHR based on the digit value
        LDA.w $D7CB, X : STA $0802, Y
        
        PHY
        
        LDA $00 : LSR A : TAY
        
        LDA ($08), Y : CLC : ADC.w #$7A10 : STA $0801, Y
        
        PLA : PHA : LSR A : TAX
        
        LDA ($0A) : CLC : ADC $D7D8, X : STA $0800, Y
        LDA.b #$3C : STA $0803, Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$00 : STA $0A20, Y
        
        PLY : INY #4
    PLX : DEX #2 : BPL .nextDigit
    
    REP #$30
    
    .return
    
    PLA : STA $04
    PLA : STA $02
    
    RTS
}

; ==============================================================================

; $06588A-$06589B JUMP LOCATION
Module_NamePlayer:
{
    ; Beginning of Module 0x04 - Name Player
    
    LDA $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl $0CD89C ; = $06589C
    dl $0CD911 ; = $065911
    dl $0CD928 ; = $065928
    dl $0CDA4D ; = $065A4D
}

; ==============================================================================

; $06589C-$065910 JUMP LOCATION
{
    JSL $0CCDF9 ; $064DF9
    
    LDA.b #$01 : STA $0128
    
    STZ $0B10
    STZ $0B12
    STZ $0B15
    STZ $00CA
    STZ $00CC
    
    LDA.b #$83 : STA $0B11
    
    REP #$30
    
    LDA.w #$01F0 : STA $0630
    
    STZ $E4
    
    ; Remember $C8 is an index into what menu choice was selected.
    ; Hence, this tells us which save slot was picked.
    LDA $C8 : ASL A : TAX
    
    ; Offsets for each of the save slots. #$0, #$500, #$A00, #$F00 for mirrors.
    ; $200 will hold the offset, And it will be the index in SRAM for the
    ; following loop
    LDA $00848C, X : STA $0200 : TAX
    
    ; We're going to be putting zeroes in SRAM.
    LDY.w #$0000 : TYA
    
    .zeroLoop
    
        STA $700000, X ; In effect what this does is zero out the save file before
        STA $700100, X ; Adding anything into it.
        STA $700200, X
        STA $700300, X
        STA $700400, X
        
        INX #2
    INY #2 : CPY.w #$0100 : BNE .zeroLoop
    
    ; Here that offset pops up again.
    LDX $0200
    
    LDA.w #$00A9
    
    STA $7003D9, X ; These are the naming spots
    STA $7003DB, X ; Note that they are being filled with 0xA9
    STA $7003DD, X ; If you can get a hold of my SRAM faq, you'd know
    STA $7003DF, X ; That 0xA9 is interpreted as a blank character.
    STA $7003E1, X
    STA $7003E3, X
    
    SEP #$30
    
    RTL
}

; $065911-$065927 JUMP LOCATION
{
    PHB : PHK : PLB
    
    REP #$30
    
    JSR $CE1B ; $064E1B
    
    LDA.w #$FFFF : STA $1006, X
    
    SEP #$30
    
    PLB
    
    LDA.b #$01
    
    JSR $C52E ; $06452E
    
    RTL
}

; $065928-$065934 JUMP LOCATION
{
    LDA.b #$05
    
    JSR $C52E ; $06452E
    
    LDA.b #$0F : STA $13
    
    STZ $0710
    
    RTL
}

; $065A4D-$065C8B JUMP LOCATION
{
    .BRANCH_1
    
    LDY $0B13 : BEQ .BRANCH_6
        TYA : CMP.b #$31 : BEQ .BRANCH_2
            CLC : ADC.b #$04 : STA $0B13
    
        .BRANCH_2
        
        LDA $0B10 : ASL A : TAX
        
        REP #$20
        
        DEY
        
        LDA $0630 : CMP $0CD9B5, X : BNE .BRANCH_4
            SEP #$20
            
            LDA.b #$30 : STA $0B13
            
            LDA $F0 : AND.b #$03 : BNE .BRANCH_3
                STZ $0B13
        
            .BRANCH_3
        
            JSR $DC8C ; $065C8C
            
            BRA .BRANCH_1
        
        .BRANCH_4
        
        REP #$20
        
        LDX $0B16 : BNE .BRANCH_5
            INY #2
        
        .BRANCH_5
        
        LDA $0630
        
        TYX
        
        CLC : ADC $0CDA19, X : AND.w #$01FF : STA $0630
        
        SEP #$20
        
        BRA .BRANCH_7
    
    .BRANCH_6
    
    JSR $DC8C ; $065C8C
    
    .BRANCH_7
    
    LDA $0B14 : BEQ .BRANCH_10
        LDX $0B15
        
        LDY.b #$02
        
        LDA $0B11 : CMP $0CDA01, X : BNE .BRANCH_8
            STZ $0B14
            
            JSR $DCBF ; $065CBF
            
            BRA .BRANCH_7
        
        .BRANCH_8
        
        BMI .BRANCH_9
            LDY.b #$FE
        
        .BRANCH_9
        
        TYA : CLC : ADC $0B11 : STA $0B11
        
        BRA .BRANCH_11
    
    .BRANCH_10
    
    JSR $DCBF ; $065CBF.
    
    .BRANCH_11
    
    LDX.b #$00 : TXY
    
    LDA.b #$18 : STA $00
    
    .BRANCH_12
    
        LDA $00 : STA $0800, Y
        
        CLC : ADC.b #$08 : STA $00
        
        LDA $0B11 : STA $0801, Y
        
        LDA.b #$2E : STA $0802, Y
        
        LDA.b #$3C : STA $0803, Y
        
        STZ $0A20, X
        
        INY #4
    INX : CPX.b #$1A : BNE .BRANCH_12
    
    PHX
    
    LDX $0B12
    
    LDA $0CDA13, X : STA $0800, Y
    
    LDA.b #$58 : STA $0801, Y
    
    PLX
    
    LDA.b #$29 : STA $0802, Y
    LDA.b #$0C : STA $0803, Y
    
    STZ $0A20, X
    
    LDA $0B13 : ORA $0B14 : BNE .BRANCH_14
        LDA $F4 : AND.b #$10 : BEQ .BRANCH_13
            JMP $DBB1 ; $065BB1
        
        .BRANCH_13
        
        LDA $F4 : AND.b #$C0 : BNE .BRANCH_15
            LDA $F6 : AND.b #$C0 : BNE .BRANCH_15
    
    .BRANCH_14
    
    JMP $DBD9 ; $065BB9
    
    .BRANCH_15
    
    ; play low life warning beep sound?
    LDA.b #$2B : STA $012E
    
    REP #$30
    
    LDA $0B15 : AND.w #$00FF : ASL A : TAX
    
    LDA $0CDA0B, X : CLC : ADC $0B10 : AND.w #$00FF : TAX
    
    SEP #$20
    
    LDA $0CD935, X
    
    CMP.b #$5A : BEQ .BRANCH_16
        CMP.b #$44 : BEQ .BRANCH_18
            CMP.b #$6F : BEQ .BRANCH_21
                STA $00
                STZ $01
        
                BRA .BRANCH_20
    
    .BRANCH_16
    
    LDA $0B12 : BNE .BRANCH_17
        LDA.b #$05 : STA $0B12
        
        BRA .BRANCH_24
    
    .BRANCH_17
    
    DEC $0B12
    
    BRA .BRANCH_24
    
    .BRANCH_18
    
    INC $0B12
    
    LDA $0B12 : CMP.b #$06 : BNE .BRANCH_19
        STZ $0B12
    
    .BRANCH_19
    
    BRA .BRANCH_24
    
    .BRANCH_20
    
    REP #$30
    
    AND.w #$000F : STA $02
    
    LDA $0B12 : AND.w #$00FF : ASL A : TAY
    
    CLC : ADC $0200 : TAX
    
    LDA $00 : AND.w #$FFF0 : ASL A : ORA $02 : STA $7003D9, X
    
    JSR $DD30 ; $065D30
    
    BRA .BRANCH_18
    
    .BRANCH_21 ; $065BB1 ALTERNATE ENTRY POINT
    
    REP #$30
    
    STZ $02
    
    .BRANCH_22
    
    LDA $0200 : CLC
    
    ; $065BB9 ALTERNATE ENTRY POINT
    
    ADC $02 : TAX
    
    ; Checking if the spot is blank
    LDA $7003D9, X : CMP.w #$00A9 : BNE .BRANCH_25
        LDA $02 : CMP.w #$000A : BEQ .BRANCH_23
            INC #2 : STA $02
            
            BRA .BRANCH_22
    
        .BRANCH_23
        
        SEP #$20
        
        LDA.b #$3C : STA $012E
        
        .BRANCH_24
        
        SEP #$30
        
        RTL
    
    .BRANCH_25
    
    SEP #$30
    
    ; Make the data bank 0x04
    PHB : LDA.b #$04 : PHA : PLB
    
    REP #$30
    
    LDA $C8 : ASL A : INC #2 : STA $701FFE : TAX
    
    LDA $00848A, X : STA $00 : TAX
    
    LDA.w #$55AA : STA $7003E5, X
    
    LDA.w #$F000 : STA $70020C, X : STA $70020E, X
    
    LDA.w #$FFFF : STA $700405, X
    
    LDA.w #$001D : STA $02
    
    ; branch if it's not the first save game slot
    LDY.w #$003C : CPX.w #$0000 : BNE .loadInitialEquipment
        ; lol.... wow, this is checking if the end of the "get joypad input"
        ; routine ends with an RTS instruction or not. In otherwords, it's checking
        ; the game's own code to determine if the player 2 joypad is enabled
        ; interesting manuever, I must say
        LDA $0083F8 : AND.w #$00FF : CMP.w #$0060 : BEQ .loadInitialEquipment
            ; if the first letter of the player's name is not an uppercase 'B', no cheat code for you!
            LDA $7003D9 : CMP.w #$0001 : BNE .loadInitialEquipment
                ; If you've reached this section of code, it's a cheat code designed to help playtest the game
                ; by giving you a headstart on certain things in the game.
                ; The conditions for reaching here are
                ; 1. only works in first save game slot
                ; 2. the second controller must be enabled in the code
                ; 3. player name must start with letter 'B' (or perhaps a certain Japanese character)
                
                ; presumably this is to... keep Link from getting magic powder again
                LDA.w #$00F0 : STA $700212, X
                
                ; Set the game mode to after saving Zelda
                LDA.w #$1502 : STA $7003C5, X
                
                ; set map indicators on overworld and put Link starting in his house.
                LDA.w #$0100 : STA $7003C7, X
                
                LDY.w #$0000
        
    .loadInitialEquipment

        ; Setup initial equipment and flags values
        LDA.w $F48A, Y : STA $700340, X
            
        INX #2
        INY #2
    DEC $02 : BPL .loadInitialEquipment
    
    LDX $00
    
    LDY.w #$0000 : TYA
    
    .computeChecksum
    
        CLC : ADC $700000, X
        
        INX #2 
    INY : CPY.w #$027F : BNE .computeChecksum
    
    STA $02
    
    LDX $00
    
    LDA.w #$5A5A : SEC : SBC $02 : STA $7004FE, X
    
    SEP #$30
    
    PLB
    
    JSR $D22D ; $06522D
    
    LDA.b #$FF : STA $0128
    
    LDA.b #$2C : STA $012E
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $065C8C-$065CBE LOCAL JUMP LOCATION
{
    REP #$30
    
    ; Check if left or right directions are being held.
    LDA $F0 : AND.b #$03 : BEQ .BRANCH_2
        INC $0B13
        
        DEC A : STA $0B16
        
        REP #$30
        
        AND.w #$00FF : ASL A : TAX
        
        LDA $0B10 : AND.w #$00FF : CLC : ADC $0CD9F5, X : CMP $0CD9F9, X : BNE .BRANCH_1
            LDA $0CD9FD, X
        
        .BRANCH_1
        
        SEP #$30
        
        STA $0B10
    
    .BRANCH_2
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $065CBF-$065D23 LOCAL JUMP LOCATION
{
    LDA $F0 : AND.b #$C0 : BEQ .BRANCH_5
        STA $02
        
        ASL A : ORA $0B15 : CMP.b #$10 : BEQ .BRANCH_6
            LDA $02 : ASL #2 : ORA $0B15
            
            LDX $0B10
            
            CMP.b #$13 : BEQ .BRANCH_6
                LDA $02 : LSR #2
                
                .BRANCH_1
                
                    TAX
                    
                    LDA $0B15 : CLC : ADC $0CDA04, X : CMP $0CDA06, X : BNE .BRANCH_2
                        LDA $0CDA08, X
                    
                    .BRANCH_2
                    
                    STA $0B15
                    
                    BRA .BRANCH_3
                    
                    ; Unreachable code?
                    STA $01
                    
                    LDX $0B15
                    
                    LDA $0CDA0B, X : CLC : ADC $0B10 : AND.b #$FF : TAX
                    
                    LDA $0CD935, X
                    
                    .BRANCH_3
                    
                    CMP.b #$59 : BNE .BRANCH_4
                        LDA $01
                BRA .BRANCH_1
                
                .BRANCH_4
                
                INC $0B14
                
                BRA .BRANCH_6
    
    .BRANCH_5
    
    STZ $00CA
    
    .BRANCH_6
    
    LDA $0002 : STA $00CB
    
    RTS
}

; ==============================================================================

; $065D30-$065D6C LOCAL JUMP LOCATION
{
    PHB : PHK : PLB
    
    LDA.w #$6100 : ORA $DD24, Y : XBA : STA $1002
    
    XBA : CLC : ADC.w #$0020 : XBA : STA $1008
    
    LDA.w #$0100 : STA $1004 : STA $100A
    
    LDA $7003D9, X : ORA.w #$1800 : STA $1006
    
    CLC : ADC.w #$0010 : STA $100C
    
    SEP #$30
    
    LDA.b #$FF : STA $100E
    
    LDA.b #$01 : STA $14
    
    PLB
    
    RTS
}

; $066D82-$066DAC LOCAL JUMP LOCATION
Intro_DisplayNintendoLogo:
{
    PHB : PHK : PLB
    
    LDY.b #$03
    LDX.b #$0C
    
    .setupOam
    
        LDA.b #$02 : STA $0A20, Y
        
        ; These are the X-coordinates of the Nintendo Logo Sprites
        LDA.w $ED7A, Y : STA $0800, X
        
        ; The (hardcoded) Y coordinate for the Nintendo Logo sprites.
        LDA.b #$68   : STA $0801, X
        
        ; The sprite index (which sprite CHR is used
        LDA.w $ED7E, Y : STA $0802, X
        
        ; Palette, priority, and flip in formation for each sprite.
        LDA.b #$32 : STA $0803, X
        
        DEX #4
    DEY : BPL .setupOam
    
    PLB
    
    RTS
}

; ==============================================================================

; $066DAD-$066DD1 LONG JUMP LOCATION
Module_Attract:
{
    ; Beginning of Module 0x14, History Mode
    
    ; Check the screen brightness
    LDA $13 : BEQ .ignoreInput
        ; If screen is force blanked
        CMP.b #$80 : BEQ .ignoreInput
            ; Ignore input during all of the fading submodules.
            LDA $22    : BEQ .ignoreInput
            CMP.b #$02 : BEQ .ignoreInput
            CMP.b #$06 : BEQ .ignoreInput
                ; Check the joypad for activity on B or Start.
                LDA $F4 : AND.b #$90 : BEQ .dontEndSequence
                    ; Begin exiting attract mode if one of those buttons was pressed.
                    LDA.b #$09 : STA $22

                .dontEndSequence
    
    .ignoreInput
    
    LDA $22 : ASL A : TAX
    
    JMP (Attract_Submodules, X)
}

; ==============================================================================

; $066DD2-$066DE5 Jump Table
Attract_Submodules:
{
    dw Attract_Fade
    dw Attract_InitGraphics
    dw Attract_SlowFadeToBlank
    dw Attract_PrepNextSequence
    dw Attract_SlowBrighten
    dw Attract_RunSequence
    dw Attract_SlowFadeToBlank
    dw Attract_PrepNextSequence
    dw Attract_RunSequence
    dw Attract_Exit
}

; ==============================================================================

; $066DE6-$066E0B LONG JUMP LOCATION
Attract_Fade:
{
    ; Module 0x14.0x00
    ; Keeps the title screen status quo running while we darken the screen
    
    JSL $0CC404 ; $064404
    
    STZ $1F00
    STZ $012A
    
    JSR $FE56 ; $067E56
    
    LDA $13 : BEQ .fullyDark
        ; Decrease screen brightness.
        DEC $13
        
        RTL
    
    .fullyDark
    
    JSL EnableForceBlank ; $93D
    
    ; Disable all that crazy 3D triforce stuff
    LDA.b #$FF : STA $0128
    
    STZ $012A
    STZ $1F0C
    
    ; Step to the next submodule.
    INC $22
    
    RTL
}

; ==============================================================================

; $066E0C-$066EA5 LONG JUMP LOCATION
Attract_InitGraphics:
{
    LDX.b #$50
    
    .zeroVars
    
        STZ $20, X
    DEX : BPL .zeroVars
    
    JSL Vram_EraseTilemaps_normal
    JSL $00E36D ; $00636D
    
    LDA.b #$04 : STA $0AB3
    LDA.b #$01 : STA $0AB2
    
    STZ $0AA9
    
    JSL Palette_Hud ; $0DEE52
    
    LDA.b #$02 : STA $0AA9
    
    JSL Palette_OverworldBgMain
    JSL Palette_Hud
    JSL Palette_ArmorAndGloves
    
    LDA.b #$00 : STA $7EC53A
    LDA.b #$38 : STA $7EC53B
    
    INC $15
    
    LDA.b #$14 : STA $EA
    
    JSR $F7E6 ; $0677E6
    
    REP #$10
    
    STZ $1CD8
    
    LDX.w #$0112 : STX $1CF0
    
    STZ $E8
    STZ $E9
    
    ; Timer for the legend in frames.
    LDX.w #$1010 : STX $0200
    
    ; Go to module 0x14.0x03 next frame.
    INC $22 : INC $22 : INC $22
    
    SEP #$10
    
    JSR Attract_SetupHdma
    
    STZ $96
    STZ $97
    
    LDA.b #$B0 : STA $98
    
    LDA.b #$03 : STA $1E 
                 STZ $1F
    
    LDA.b #$25 : STA $9C
    LDA.b #$45 : STA $9D
    LDA.b #$85 : STA $9E
    LDA.b #$10 : STA $99
    LDA.b #$A3 : STA $9A
    
    STZ $212A
    STZ $212B
    
    ; Resume hdma next frame using channels 6 and 7.
    LDA.b #$C0 : STA $9B
    
    ; Play "Legend" theme music.
    LDA.b #$06 : STA $012C
    
    INC $27
    
    RTL
}

; ==============================================================================

; $066EA6-$066EB9 LOCAL JUMP LOCATION
Attract_SlowBrigthenSetFlag:
{
    ; Wait until screen brightness is at max.
    LDA $13 : CMP.b #$0F : BEQ .fullyBrightened
        DEC $5E : BPL .oneFrameDelay
            INC $13
            
            LDA.b #$01 : STA $5E
        
        .oneFrameDelay
        
        RTS
    
    .fullyBrightened
    
    INC $5F
    
    RTS
}

; ==============================================================================

; $066EBA-$066ECA LONG JUMP LOCATION
Attract_SlowBrighten:
{
    LDA $13 : CMP.b #$0F : BEQ Attract_SlowFadeToBlank_nextSubmodule
    
    DEC $5E : BPL .oneFrameDelay
        INC $13
        
        LDA.b #$01 : STA $5E
    
    .oneFrameDelay
    
    RTL
}

; ==============================================================================

; $066ECB-$066EE4 LONG JUMP LOCATION
Attract_SlowFadeToBlank:
{
    LDA $13 : BEQ .fullyDarkened
        DEC $5E : BPL .oneFrameDelay
            DEC $13
            
            LDA.b #$01 : STA $5E
        
        .oneFrameDelay
        
        RTL
    
    .fullyDarkened
    
    JSL EnableForceBlank ; $00093D
    JSL Vram_EraseTilemaps.normal
    
    .nextSubmodule
    
    INC $22
    
    RTL
}

; ==============================================================================

; $066EE5-$066EEB LONG JUMP LOCATION
Attract_PrepNextSequence:
{
    LDA $23 : ASL A : TAX
    
    JMP (Attract_PrepRoutines, X)
}

; ==============================================================================

; $066EEC-$066EF7 Jump Table
Attract_PrepRoutines:
{
    dw Attract_PrepLegend
    dw Attract_PrepMapZoom
    dw Attract_PrepThroneRoom
    dw Attract_PrepZeldaPrison
    dw Attract_PrepMaidenWarp
    dw $F0DC ; = $0670DC
}

; ==============================================================================

; $066EF8-$066EFE LONG JUMP LOCATION
Attract_PrepLegend:
{
    STZ $26
    
    INC $22
    
    STZ $13
    
    RTL
}

; ==============================================================================

; $066EFF-$066F4D JUMP LOCATION
Attract_PrepMapZoom:
{
    LDA.b #$13 : STA $2107
    LDA.b #$03 : STA $2108
    
    LDA.b #$80 : STA $99
    LDA.b #$21 : STA $9A
    
    LDA.b #$07 : STA $2105 : STA $94
    
    LDA.b #$80 : STA $211A
    
    JSL OverworldMap_InitGfx
    
    REP #$20
    
    LDA.w #$00ED : STA $063A
    LDA.w #$0100 : STA $0638
    
    LDA.w #$0080 : STA $0120
    LDA.w #$00C0 : STA $0124
    
    SEP #$20
    
    LDA.b #$FF : STA $0637
    
    JSR Attract_AdjustMapZoom
    
    LDA.b #$01 : STA $25
    
    INC $22
    
    STZ $13
    
    RTL
}

; ==============================================================================

; $066F4E-$066FE2 LONG JUMP LOCATION
Attract_PrepThroneRoom:
{
    STZ $420C
    STZ $9B
    
    ; Sets up subscreen addition a certain way because this room has
    ; two floors. This will be disabled in the latter two sequences.
    LDA.b #$02 : STA $99
    LDA.b #$20 : STA $9A
    
    ; Set misc. sprite index.
    LDA.b #$0A : STA $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    
    REP #$20
    
    ; Since we're loading a dungeon entrance, and that attempts to write
    ; to Link's coordinates (which this attract mode for whatever reason
    ; also decided to allocate in the same location), we have to cache these
    ; for the moment, lest attract mode go out of its mind.
    LDA $20 : PHA
    LDA $22 : PHA
    
    SEP #$20
    
    ; The entrance number to load.
    LDA.b #$74
    
    JSL Attract_LoadDungeonRoom
    
    REP #$20
    
    PLA : STA $22
    PLA : STA $20
    
    SEP #$20
    
    STZ $0AB6
    STZ $0AAC
    
    LDA.b #$0E : STA $0AAD
    LDA.b #$03 : STA $0AAE
    
    LDX.b #$7E
    
    LDA.b #$00
    
    JSL Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA $7EC53A
    LDA.b #$38 : STA $7EC53B
    
    STZ $1CD8
    
    LDA.b #$13 : STA $1CF0
    LDA.b #$01 : STA $1CF1
    
    LDA.b #$02 : STA $25
    LDA.b #$E0 : STA $2C
    
    REP #$20
    
    LDA.w #$0210 : STA $64
    
    SEP #$20
    
    ; $066FC0 ALTERNATE ENTRY POINT
    
    INC $22
    
    STZ $13
    STZ $EA
    
    ; Since the entrance loader loads scroll values in dungeon relative 
    ; coordinates, which are often much larger than 0x200, bound them for
    ; attract mode purposes. The throne room sequence counts $0122 down to
    ; zero, and it could take quite a while and it would look funny if we
    ; didn't do this. i.e. it would be looping several times before finally
    ; showing the text message and then moving on to the next sequence.
    LDA $011F : AND.b #$01 : STA $011F
    LDA $0123 : AND.b #$01 : STA $0123
    
    ; Same thing here.
    LDA $E3 : AND.b #$01 : STA $E3
    LDA $E9 : AND.b #$01 : STA $E9
    
    RTL
}

; ==============================================================================

; $066FE3-$067057 LONG JUMP LOCATION
Attract_PrepZeldaPrison:
{
    STZ $99
    STZ $9A
    
    REP #$20
    
    LDA $20 : PHA
    LDA $22 : PHA
    
    SEP #$20
    
    LDA.b #$73
    
    JSL Attract_LoadDungeonRoom
    
    REP #$20
    
    PLA : STA $22
    PLA : STA $20
    
    SEP #$20
    
    LDA.b #$02 : STA $0AB6
    
    STZ $0AAC
    
    LDA.b #$0E : STA $0AAD
    LDA.b #$03 : STA $0AAE
    
    LDX.b #$7F
    LDA.b #$01
    
    JSL Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA $7EC53A
    LDA.b #$38 : STA $7EC53B
    
    STZ $1CD8
    
    LDA.b #$14 : STA $1CF0
    LDA.b #$01 : STA $1CF1
    
    LDA.b #$94 : STA $2B
    LDA.b #$68 : STA $30
    
    STZ $31
    STZ $32
    STZ $33
    STZ $40
    STZ $50
    STZ $5F
    
    LDA.b #$FF : STA $25
    
    REP #$20
    
    LDA.w #$0240 : STA $64
    
    SEP #$20
    
    JMP $EFC0 ; $066FC0
}

; ==============================================================================

; $067058-$0670DB LONG JUMP LOCATION
Attract_PrepMaidenWarp:
{
    REP #$20
    
    LDA $20 : PHA
    LDA $22 : PHA
    
    SEP #$20
    
    LDA.b #$75
    
    JSL Attract_LoadDungeonRoom
    
    REP #$20
    
    PLA : STA $22
    PLA : STA $20
    
    SEP #$20
    
    STZ $0AB6
    STZ $0AAC
    
    LDA.b #$0E : STA $0AAD
    
    LDA.b #$03 : STA $0AAE
    
    STZ $0AA9
    
    ; This call confuses me, as it seems that the next call after this
    ; would undo what this one does...
    JSL Attract_LoadDungeonGfxAndTiles_justPalettes
    
    LDX.b #$7F
    LDA.b #$02
    
    JSL Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA $7EC33A : STA $7EC53A
    LDA.b #$38 : STA $7EC33B : STA $7EC53B
    
    STZ $1CD8
    
    LDA.b #$15 : STA $1CF0
    LDA.b #$01 : STA $1CF1
    
    LDA.b #$FF : STA $25
    
    LDA.b #$70 : STA $30 : STA $62
    LDA.b #$70           : STA $63
    
    LDA.b #$08 : STA $32
    
    STZ $50
    STZ $51
    STZ $52
    STZ $5F
    STZ $60
    STZ $61
    
    REP #$20
    
    LDA.w #$00C0 : STA $64
    
    SEP #$20
    
    JMP $EFC0 ; $066FC0
}

; ==============================================================================

; $0670DC-$067114 LONG JUMP LOCATION
{
    REP #$20
    
    JSL OverworldMap_PrepExit.restoreHdmaSettings
    
    ; $0670E2 ALTERNATE ENTRY POINT
    
    INC $0710
    
    JSL Intro_LoadTitleGraphics.noWait
    JSL Intro_LoadTextPointersAndPalettes.justPalettes
    
    STZ $EA
    
    REP #$20
    
    STZ $063A
    STZ $0638
    STZ $0120
    STZ $0124
    STZ $011E
    STZ $0122
    
    SEP #$20
    
    LDA.b #$F1 : STA $012C
    
    STZ $23
    STZ $10
    
    LDA.b #$0A : STA $11 : STA $B0
    
    RTL
}

; ==============================================================================

; $067115-$06711B LONG JUMP LOCATION
Attract_RunSequence:
{
    LDA $23 : ASL A : TAX
    
    JMP (Attract_SequenceRoutines, X)
}

; ==============================================================================

; $06711C-$067125 Jump Table
Attract_SequenceRoutines:
{
    dw Attract_Legend
    dw Attract_MapZoom
    dw Attract_ThroneRoom
    dw Attract_ZeldaPrison
    dw Attract_MaidenWarp
}

; ==============================================================================

; $067126-$067175 LONG JUMP LOCATION
Attract_Legend:
{
    ; Move the BGs every fourth frame.
    LDA $1A : AND.b #$03 : BNE .dontMoveBgs
        INC $0124
        
        INC $0120
        
        INC $0122
        
        DEC $011E
    
    .dontMoveBgs
    
    LDA $27 : BEQ .noNewGraphic
        JSR Attract_LoadNextLegendGraphic
        
        STZ $27
        
        INC $26 : INC $26
    
    .noNewGraphic
    
    STZ $F2
    STZ $F6
    STZ $F4
    
    JSL Messaging_Text
    
    REP #$20
    
    DEC $0200 : BNE .timerNotFinished
        SEP #$20
        
        ; Move to the next sub submodule.
        INC $23
        
        DEC $22 : DEC $22 : DEC $22
        
        BRA .return
    
    .timerNotFinished
    
    LDA $0200 : CMP.w #$0018 : BCS .dontFadeThisFrame
        AND.w #$0001 : BEQ .dontFadeThisFrame
            SEP #$20
            
            DEC $13
    
    .dontFadeThisFrame
    .return
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $067176-$0671AD LONG JUMP LOCATION
Attract_MapZoom:
{
    ; Zoom into hyrule castle on the mode 7 overworld map.
    
    LDA $0637
    
    CMP.b #$00 : BEQ .advanceToNextSequence
    CMP.b #$0F : BCS .dontFadeThisFrame
        DEC $13
        
        .dontFadeThisFrame
        
        LDY.b #$01
        
        DEC $25 : BNE .noZoomAdjustThisFrame
            STY $25
            
            ; Decrement the timer by one.
            LDA $0637 : SEC : SBC.b #$01 : STA $0637
            
            JSR Attract_AdjustMapZoom
        
        .noZoomAdjustThisFrame
        
        RTL
    
    .advanceToNextSequence
    
    JSL EnableForceBlank
    
    LDA.b #$09 : STA $2105 : STA $94
    
    JSL Vram_EraseTilemaps_normal
    
    ; Go to the throne room sequence.
    INC $23
    
    DEC $22 : DEC $22
    
    RTL
}

; ==============================================================================

; $0671AE-$0671C7 DATA
{
    dw $F8A7, $F8BB
    
    ; $671B2
    
    dw $F8AB, $F8C1
    
    ; $671B6
    
    dw $F8AF, $F8C7
    
    ; $671BA
    
    dw $F8B3, $F8CD
    
    ; $671BE
    
    dw $F8B7, $F8D3
    
    ; $671C2
    
    db $50, $68
    
    ; $671C4
    
    db $58, $20
    
    ; $671C6
    
    db $03, $05
}

; ==============================================================================

; $0671C8-$06725F LONG JUMP LOCATION
Attract_ThroneRoom:
{
    STZ $2A
    
    LDA $52 : BNE .brighteningTaskFinished
        LDA $13 : CMP.b #$0F : BEQ .fullyBrightened
            INC $13
            
            BRA .brighteningTaskFinished
            
        .fullyBrightened
        
        INC $52
        
    .brighteningTaskFinished
    
    REP #$20
    
    LDA $0122 : BNE .stillScrolling
        SEP #$20
        
        JSR Attract_ShowTimedTextMessage
        
        REP #$20
        
        LDA $64 : SEP #$20 : BNE .textTimerNotFinished
            LDA $2C : CMP.b #$1F : BCS .dontDarkenThisFrame
                AND.b #$01 : BNE .dontDarkenThisFrame
                    DEC $13
            
            .dontDarkenThisFrame
            
            DEC $2C : BNE .sequenceNotFinished
                ; Go to the Zelda in prison sequence.
                INC $23
                INC $22
                
                RTL
    
    .stillScrolling
    
    DEC $0122
    DEC $0124
    
    .textTimerNotFinished
    .sequenceNotFinished
    
    SEP #$20
    
    LDX.b #$02
    
    .nextSpriteSet
    
        PHX
        
        REP #$20
        
        LDA $0CF1AE, X : STA $2D
        LDA $0CF1B2, X : STA $02
        LDA $0CF1B6, X : STA $04
        LDA $0CF1BA, X : STA $06
        LDA $0CF1BE, X : STA $08
        
        TXA : AND.w #$00FF : LSR A : TAX
        
        LDA $0CF1C4, X : AND.w #$00FF : SEC : SBC $0122 : STA $00
        
        CMP.w #$FFE0 : SEP #$20 : BMI .spriteSetOffscreen
            LDA $0CF1C2, X : STA $28
            
            LDA $00 : STA $29
            
            LDA $0CF1C6, X : TAY
            
            JSR Attract_DrawSpriteSet
        
        .spriteSetOffscreen
    PLX : DEX #2 : BPL .nextSpriteSet
    
    RTL
}

; ==============================================================================

; $67260
{
    dw 32, -12
    
    ; $67264
    
    db 24, 24
    
    ; $67266
    
    db 1, 1
    
    ; $67268
    
    db 9, 7
    
    ; $6726A
    
    ; Maybe has something to do with the offset of the prisoner being
    ; led away?
    db 0, 1, 2, 3, 4, 5, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1
}   


; ==============================================================================

; $06727A-$06731F LONG JUMP LOCATION
Attract_ZeldaPrison:
{
    STZ $2A
    
    LDA $5F : BNE .brighteningTaskFinished
        JSR Attract_SlowBrigthenSetFlag
    
    .brighteningTaskFinished
    
    LDA.b #$38 : STA $28
    
    JSR Atract_DrawZelda
    
    LDA $25 : CMP.b #$C0 : BCS .BRANCH_BETA
        JMP $F319 ; $067319
    
    .BRANCH_BETA
    
    LDA.b #$70 : STA $29
    
    DEC $50 : BPL .BRANCH_GAMMA
        LDA.b #$0F : STA $50
    
    .BRANCH_GAMMA
    
    LDX $50
    
    LDA $31 : STA $40
    
    LDA $30 : CLC : ADC $0CF26A, X : STA $28 : BCC .BRANCH_DELTA
        INC $40
    
    .BRANCH_DELTA
    
    JSR $FA30 ; $067A30
    
    LDX.b #$01
    
    .nextSoldier
    
        STZ $03
        
        LDA $33 : STA $06
        
        LDA $29 : CLC : ADC $0CF264, X : STA $02
        
        LDA $0CF266, X : STA $04
        LDA $0CF268, X : STA $05
        
        PHX
        
        REP #$20
        
        TXA : ASL A : TAX
        
        LDA $30 : CLC : ADC.w #$0100 : CLC : ADC $0CF260, X : STA $00 : TAY : STY $34
        
        SEP #$20
        
        JSL Sprite_ResetProperties
        
        ; I think that this animates the soldiers leading the prisoner away.
        ; As in, generates their appearance and puts it into oam and such.
        ; Kind of like a marionette being controlled by a puppeteer, but one
        ; frame at a time.
        JSL Sprite_SimulateSoldier
    PLX : DEX : BPL .nextSoldier
    
    INC $32
    
    LDA $32 : AND.b #$07 : BNE .BRANCH_ZETA
        LDY.b #$FF
        
        LDA $33 : CMP.b #$02 : BNE .BRANCH_THETA
            STY $33
            
            LDA $31 : BNE .BRANCH_THETA
                LDA $32 : AND.b #$08 : BEQ .BRANCH_THETA
                    LDA.b #$04 : STA $012F
        
        .BRANCH_THETA
        
        INC $33
    
    ; $067319 ALTERNATE ENTRY POINT
    .BRANCH_ZETA
    
    LDA $60 : ASL A : TAX
    
    JMP ($F320, X) ; $067320
}

; ==============================================================================

; $067320-$067323 Jump Table
{
    dw $F32B ; = $06732B
    dw $F379 ; = $067379
}

; ==============================================================================

; $067324-$06732A LONG JUMP LOCATION
Attract_AdvanceToNextSequence:
{
    INC $23
    
    DEC $22 : DEC $22
    
    RTL
}

; ==============================================================================

; $06732B-$067364 LONG JUMP LOCATION
{
    LDA $34 : BNE .BRANCH_ALPHA
        INC $60
    
    .BRANCH_ALPHA
    
    REP #$20
    
    LDA $1A : AND.w #$0001 : BEQ .BRANCH_BETA
        DEC $30
    
    .BRANCH_BETA
    
    LDA.w #$F8D9 : STA $2D
    LDA.w #$F8DF : STA $02
    LDA.w #$F8E5 : STA $04
    LDA.w #$F903 : STA $06
    LDA.w #$F915 : STA $08
    
    SEP #$20
    
    LDA.b #$58 : STA $28
    
    LDA $2B : STA $29
    
    LDY.b #$05
    
    JSR Attract_DrawSpriteSet
    
    RTL
}

; ==============================================================================

; $067379-$067400 LONG JUMP LOCATION
{
    LDA $25 : CMP.b #$80 : BCS .BRANCH_ALPHA
        JSR Attract_ShowTimedTextMessage
        
        REP #$20
        
        LDA $64 : SEP #$20 : BEQ .BRANCH_ALPHA
            LDX.b #$08
            
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDX.b #$00
    
    LDA $2B : CMP.b #$6E : BEQ .BRANCH_DELTA
        DEC $2B : BRA .BRANCH_BETA
    
    .BRANCH_DELTA
    
    LDA $25
    
    CMP.b #$1F : BCS .BRANCH_EPSILON
    AND.b #$01 : BNE .BRANCH_EPSILON
        DEC $13
    
    .BRANCH_EPSILON
    
    DEC $25 : BNE .BRANCH_ZETA
        JMP Attract_AdvanceToNextSequence
    
    .BRANCH_ZETA
    
    LDA $25 : CMP.b #$C0 : BCS .BRANCH_BETA
        INX #2
        
        CMP.b #$B8 : BCS .BRANCH_BETA
            INX #2
            
            CMP.b #$B0 : BCS .BRANCH_BETA
                INX #2
                
                CMP.b #$A0 : BCS .BRANCH_BETA
                    INX #2

    .BRANCH_BETA

    LDA.b #$A8 : STA $28
    
    REP #$20
    
    LDA $1A : AND.w #$0001 : BEQ .BRANCH_GAMMA
        DEC $30
    
    .BRANCH_GAMMA
    
    LDA.w #$F8D9 : STA $2D
    LDA.w #$F8DF : STA $02
    LDA.w #$F8E5 : STA $04
    
    LDA $0CF365, X : STA $06
    LDA $0CF36F, X : STA $08
    
    SEP #$20
    
    LDA.b #$58 : STA $28
    
    LDA $2B : STA $29
    
    LDY.b #$05
    
    JSR Attract_DrawSpriteSet
    
    RTL
}

; ==============================================================================

; $067419-$067422 Jump Table
{
    dw $F57B ; = $06757B
    dw $F592 ; = $067592
    dw $F613 ; = $067613
    dw $F689 ; = $067689
    dw $F6E2 ; = $0676E2
}

; ==============================================================================

; $067423-$06754E LONG JUMP LOCATION
Attract_MaidenWarp:
{
    LDA $5D : BEQ .sequenceNotFinished
        JMP Attract_AdvanceToNextSequence
    
    .sequenceNotFinished
    
    STZ $2A
    
    JSL Filter_MajorWhitenMain
    
    LDA $5F : BNE .brighteningTaskFinished
        JSR Attract_SlowBrigthenSetFlag
    
    .brighteningTaskFinished
    
    LDA $50 : CMP.b #$FF : BEQ .counterAtMax
        INC $50
    
    .counterAtMax
    
    LDA $0FF9 : BEQ .BRANCH_DELTA
    AND.b #$04 : BEQ .BRANCH_DELTA
    
        ; Sound effect.
        LDX.b #$2B : STX $012F
    
    .BRANCH_DELTA
    
    LDA $60 : ASL A : TAX
    
    JSR ($F419, X) ; $067419
    
    LDX.b #$05
    
    .nextSoldier
    
        STZ $01
        STZ $03
        STZ $06
        
        LDA $0CF401, X : STA $00
        LDA $0CF407, X : STA $02
        LDA $0CF40D, X : STA $04
        LDA $0CF413, X : STA $05
        
        PHX
        
        JSL Sprite_ResetProperties
        JSL Sprite_SimulateSoldier
    PLX : DEX : BPL .nextSoldier
    
    LDX $50 : CPX.b #$A0 : BCC .BRANCH_ZETA
        LDA $30 : CMP.b #$60 : BEQ .BRANCH_THETA
            DEC $32 : BNE .BRANCH_ZETA
                DEC $30
                
                LDA.b #$08 : STA $32
                
                BRA .BRANCH_ZETA
        
        .BRANCH_THETA
        
        INC $61
    
    .BRANCH_ZETA
    
    LDA $52 : BNE .BRANCH_IOTA
        REP #$20
        
        LDA.w #$F927 : STA $2D
        LDA.w #$F929 : STA $02
        LDA.w #$F92B : STA $04
        
        LDX.b #$00
        
        LDA $30 : AND.w #$00FF : CMP.w #$0070 : BEQ .BRANCH_KAPPA
            INX #2
        
        .BRANCH_KAPPA
        
        LDA $0CF567, X : STA $06
        
        LDA.w #$F931 : STA $08
        
        SEP #$20
        
        LDA.b #$74 : STA $28
        
        LDA $30 : STA $29
        
        LDY.b #$01
        
        JSR Attract_DrawSpriteSet
        
        LDX.b #$0E
        
        LDA $30 : CMP,.b #$68 : BCS .BRANCH_LAMBDA
            SEC : SBC.b #$68 : ASL A : AND.b #$0E : TAX
        
        .BRANCH_LAMBDA
        
        REP #$20
        
        LDA.w #$F933 : STA $2D
        
        LDA $0CF54F, X : STA $02
        
        LDA.w #$F93F : STA $04
        LDA.w #$F941 : STA $06
        LDA.w #$F943 : STA $08
        
        SEP #$20
        
        TXA : LSR A : TAX
        
        LDA.b #$74 : CLC : ADC $0CF55F, X : STA $28
        
        LDA.b #$76 : STA $29
        
        LDY.b #$01
        
        JSR Attract_DrawSpriteSet
    
    .BRANCH_IOTA
    
    LDA $50 : LSR #4 : AND.b #$0E : TAX
    
    REP #$20
    
    LDA.w #$F8D9   : STA $2D
    LDA.w #$F8DF   : STA $02
    LDA.w #$F8E5   : STA $04
    LDA $0CF56B, X : STA $06
    LDA.w #$F915   : STA $08
    
    SEP #$20
    
    LDA.b #$70 : STA $28
    LDA.b #$46 : STA $29
    
    LDY.b #$05
    
    JSR Attract_DrawSpriteSet
    
    RTL
}

; $06757B-$067581 LOCAL JUMP LOCATION
{
    LDA $61 : BEQ .BRANCH_ALPHA
        INC $60
    
    .BRANCH_ALPHA
    
    RTS
}

; $067592-$0675FA LOCAL JUMP LOCATION
Dramagahnim_ReadySpell:
{
    LDA $1A : LSR A : AND.b #$02 : TAX
    
    REP #$20
    
    LDA.w #$F945 : STA $2D
    LDA.w #$F953 : STA $02
    LDA.w #$F961 : STA $04
    
    LDA $0CF582, X : STA $06
    LDA $0CF586, X : STA $08
    
    SEP #$20
    
    LDA.b #$6E : STA $28
    LDA.b #$48 : STA $29
    
    LDA $51 : LSR A : AND.b #$07 : TAX
    
    LDA $0CF58A, X : TAY
    
    JSR Attract_DrawSpriteSet
    
    LDA $51 : BNE .BRANCH_ALPHA
        LDY $63 : CPY.b #$70 : BNE .BRANCH_ALPHA
            LDX.b #$27 : STX $012F
    
    .BRANCH_ALPHA
    
    CMP.b #$0F : BEQ .BRANCH_BETA
        CMP.b #$06 : BNE .BRANCH_GAMMA
            LDX.b #$90 : STX $0FF9
            LDX.b #$2B : STX $012F
        
        .BRANCH_GAMMA
        
        LDA $63 : BEQ .BRANCH_DELTA
            DEC $63
            
            RTS
            
        .BRANCH_DELTA
        
        INC $51
        
        RTS
    
    ; $0675F8 ALTERNATE ENTRY POINT
    .BRANCH_BETA
    
    INC $60
    
    RTS
}

; $067613-$067674 LOCAL JUMP LOCATION
{
    PHB : PHK : PLB
    
    LDA $1A : LSR A : AND.b #$02 : TAX
    
    LDA $51 : LSR A : AND.b #$07 : STA $00
    
    ASL A : TAY
    
    REP #$20
    
    LDA.w #$F945 : CLC : ADC $F603, Y : STA $2D
    LDA.w #$F953 : CLC : ADC $F603, Y : STA $02
    LDA.w #$F961 : CLC : ADC $F603, Y : STA $04
    
    LDA.w $F582, X : CLC : ADC $F603, Y : STA $06
    LDA.w $F586, X : CLC : ADC $F603, Y : STA $08
    
    SEP #$20
    
    LDA.b #$6E : STA $28
    LDA.b #$48 : STA $29
    
    LDX $00
    
    LDA.w $F5FB, X : TAY
    
    JSR Attract_DrawSpriteSet
    
    PLB
    
    LDA $51 : BNE .BRANCH_ALPHA
        DEC $62 : BEQ Dramagahnim_ReadySpell_BRANCH_BETA
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    DEC $51
    
    .BRANCH_BETA
    
    RTS
}

; $067689-$0676E1 LOCAL JUMP LOCATION
{
    LDA $51 : CMP.b #$06 : BNE .BRANCH_ALPHA
        INC $52
        
        LDA.b #$33 : STA $012E
    
    .BRANCH_ALPHA
    
    CMP.b #$40 : BNE .BRANCH_BETA
        LDA.b #$E0 : STA $51
        
        INC $60
    
    .BRANCH_BETA
    
    CMP.b #$0F : BCS .BRANCH_GAMMA
        LSR #2 : AND.b #$02 : TAX
        
        REP #$20
        
        LDA.w #$F9A7 : STA $2D
        
        LDA $0CF675, X : STA $02
        LDA $0CF679, X : STA $04
        LDA $0CF67D, X : STA $06
        LDA $0CF681, X : STA $08
        
        SEP #$20
        
        TXA : LSR A : TAX
        
        LDA $0CF685, X : STA $28
        
        LDA.b #$60 : STA $29
        
        LDA $0CF687, X : TAY
        
        JSR Attract_DrawSpriteSet
    
    .BRANCH_GAMMA
    
    INC $51
    
    RTS
}

; $0676E2-$0676FF LOCAL JUMP LOCATION
{
    JSR Attract_ShowTimedTextMessage
    
    REP #$20
    
    LDA $64 : SEP #$20 : BNE .BRANCH_ALPHA
        LDA $51 : CMP.b #$1F : BCS .BRANCH_BETA
            AND.b #$01 : BNE .BRANCH_BETA
                DEC $13
        
        .BRANCH_BETA
        
        DEC $51 : BNE .BRANCH_ALPHA
            INC $5D
    
    .BRANCH_ALPHA
    
    RTS
}

; $067700-$06772D LONG JUMP LOCATION
Attract_Exit:
{
    DEC $13 : BNE .stillDarkening
        JSL EnableForceBlank
        
        ; Set BG1 tilemap to xy-mirrored, at VRAM address $1000
        LDA.b #$13 : STA $2107
        
        ; Set BG2 tilemap to xy-mirrored, at VRAM address $0000
        LDA.b #$03 : STA $2108
        
        REP #$20
        
        JSL OverworldMap_PrepExit.restoreHdmaSettings
        
        REP #$20
        
        STZ $063A
        STZ $0638
        
        ; Set BG1 horizontal and vertical scroll buffer regs to 0.
        STZ $0120
        STZ $0124
        
        ; Set BG3 vertical scroll buffer reg to 0.
        STZ $EA
        
        SEP #$20
        
        JMP $C2F0 ; $0642F0
    
    .stillDarkening
    
    RTL
}
    
; ==============================================================================

; $06772E-06773D DATA
Attract_LegendGraphics:
{
    .pointers
    dw $FAC2, $FB5F, $FC4C, $FD13
    
    .sizes
    dw $009C, $00EC, $00C6, $0108
}

; ==============================================================================

; $06773E-$067765 LOCAL JUMP LOCATION
Attract_LoadNextLegendGraphic:
{
    !picSize = $00
    !picData = $02
    
    REP #$20
    
    LDX $26
    
    LDA Attract_LegendGraphics_sizes, X    : STA !picSize
    LDA Attract_LegendGraphics_pointers, X : STA !picData
    
    LDX.b #$0C : STX $04
    
    REP #$10
    
    ; Write the tilemap data into a buffer to be transferred once NMI hits.
    LDY !picSize
    
    .writeLoop
    
        LDA [!picData], Y : STA $1002, Y
    DEY #2 : BPL .writeLoop
    
    SEP #$30
    
    LDA.b #$01 : STA $14
    
    RTS
}

; ==============================================================================

; $067766-$067782 LOCAL JUMP LOCATION
Attract_ShowTimedTextMessage:
{
    LDA $E8 : STA $20
    LDA $E9 : STA $21
    
    STZ $F2
    STZ $F6
    STZ $F4
    
    JSL Messaging_Text
    
    REP #$20
    
    LDA $64 : BEQ .textTimerHasExpired
        DEC $64
    
    .textTimerHasExpired
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $067783-$0677BD LOCAL JUMP LOCATION
Attract_AdjustMapZoom:
{
    REP #$10
    
    LDA $0637 : STA $4202
    
    LDX.w #$01BE
    
    .adjustHdmaTableLoop
    
        LDA $0ADD27, X : STA $4203
        
        NOP #4
        
        LDA $4217 : STA $00
        
        LDA $0ADD28, X : STA $4203
        
        NOP
        
        ; This is effectively the top 16-bits of the 24-bit result of
        ; multiplying $0637 (byte) by the current word from the table.
        LDA $00   : CLC : ADC $4216  : STA $1B00, X
        LDA $4217 : ADC.b #$00 : STA $1B01, X
    DEX #2 : BPL .adjustHdmaTableLoop
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; $0677E6-$067878 LOCAL JUMP LOCATION
{
    LDA.b #$09 : STA $94
    
    LDA.b #$17 : STA $1C
    
    STZ $1D
    
    LDA.b #$10 : STA $2107
    LDA.b #$00 : STA $2108
    
    PHB : PHK : PLB
    
    REP #$30
    
    LDX.w #$0000
    
    LDA.w #$F7BE : STA $30
    
    .BRANCH_BETA
    
            TXA : AND.w #$0007 : TAY
            
            .BRANCH_ALPHA
            
                LDA ($30), Y : STA $1006, X
                
                INY #2
                
                INX #2
            TYA : AND.w #$0007 : BNE .BRANCH_ALPHA
        TXA : AND.w #$003F : BNE .BRANCH_BETA
        
        LDA $30 : CLC : ADC.w #$0008 : STA $30
    CPX.w #$0100 : BNE .BRANCH_BETA
    
    LDA.w #$1000 : STA $30
    
    JSR $F879 ; $067879

    REP #$30

    LDX.w #$0000
    
    LDA.w #$F7DE : STA $30
    
    .BRANCH_DELTA
    
        TXA : AND.w #$0003 : TAY
        
        .BRANCH_GAMMA
        
            LDA ($30), Y : STA $1006, X
            
            INY #2
            
            INX #2
            
            TYA : AND.w #$0003 : BNE .BRANCH_GAMMA
        TXA : AND.w #$003F : BNE .BRANCH_DELTA
        
        TXA : AND.w #$0040 : LSR #4 : CLC : ADC.w #$F7DE : STA $30
    CPX.w #$0100 : BNE .BRANCH_DELTA
    
    LDA.w #$0000 : STA $30
    
    JSR $F879 ; $067879
    
    SEP #$30
    
    PLB
    
    RTS
}

; ==============================================================================

; $067879-$0678A6 LOCAL JUMP LOCATION
{
    SEP #$10
    
    LDX.b #$07
    
    LDA $30 : STA $2116
    
    .nextTransfer
    
        LDY.b #$80 : STY $2115
        
        LDA.w #$1801 : STA $4300
        
        LDA.w #$1006 : STA $4302
        LDY.b #$00   : STY $4304
        
        LDA.w #$0100 : STA $4305
        
        LDY.b #$01 : STY $420B
    DEX : BPL .nextTransfer
    
    RTS
}

; ==============================================================================

; $0679B5-$0679E3 LOCAL JUMP LOCATION
Attract_DrawSpriteSet:
{
    ; Y - One less than the number of sprites to draw to OAM buffer
    ; 
    ; $02 - Pointer to list of relative X coordinates for each sprite.
    ; $04 - Pointer to list of relative Y coordinates for each sprite.
    ; $06 - Pointer to list of character values for each sprite.
    ; $08 - Pointer to list of property values for each sprites (vhoopppc)
    ; 
    ; $2A - index into the second half of the OAM buffer. This index gets
    ; multiplied by 4 for the actual byte offset within that buffer.
    ; 
    ; $2D - Pointer to list of size bits and 9th X coordinate bits for each
    ; sprite.
    
    PHB : PHK : PLB
    
    .nextSprite
    
        LDX $2A
        
        LDA ($2D), Y : STA $0A60, X
        
        TXA : ASL #2 : TAX
        
        LDA ($02), Y : CLC : ADC $28 : STA $0900, X
        LDA ($04), Y : CLC : ADC $29 : STA $0901, X
        LDA ($06), Y                 : STA $0902, X
        LDA ($08), Y                 : STA $0903, X
        
        INC $2A
    DEY : BPL .nextSprite
    
    PLB
    
    RTS
}

; ==============================================================================

; $0679E4-$0679E7 DATA
pool Attract_DrawZelda:
{
    .head_chr
    db $28
    
    .body_chr
    db $2A
    
    .head_properties
    db $29
    
    .body_properties
    db $29
}
    
; ==============================================================================

; $0679E8-$067A26 LOCAL JUMP LOCATION
Atract_DrawZelda:
{
    ; Pardon me for saying so, but this routine is pretty damn silly.
    ; I'm guessing it was done earlier on in the development of the attract
    ; mode, as its purpose is extremely narrowly defined.
    
    LDX $2A
    
    ; Both sprites are larger (16x16).
    LDA.b #$02 : STA $0A60, X
    
    TXA : ASL #2 : TAX
    
    ; X coordinates are fixed at 0x60?
    LDA.b #$60 : STA $0900, X
                 STA $0904, X
    
    ; Set Y coordinate of first sprite by input variable, and the second
    ; sprite is 10 pixels below it.
    LDA $28    : STA $0901, X
    CLC : ADC.b #$0A : STA $0905, X
    
    ; Set chr
    LDA.l .head_chr : STA $0902, X
    LDA.l .body_chr : STA $0906, X
    
    ; Set properties
    LDA.l .head_properties : STA $0903, X
    LDA.l .body_properties : STA $0907, X
    
    INC $2A : INC $2A
    
    RTS
}

; ==============================================================================

; $067A30-$067A86 LOCAL JUMP LOCATION
{
    PHB : PHK : PLB
    
    PHY
    
    LDX $2A
    
    LDA.b #$02
    
    LDY $40 : BEQ .BRANCH_ALPHA
        ORA.b #$01
    
    .BRANCH_ALPHA
    
    STA $0A60, X : STA $0A61, X
    
    TXA : ASL #2 : TAX
    
    LDA $28 : STA $0900, X : STA $0904, X
    
    LDA $32 : LSR #3 : AND.b #$01 : TAY
    
    LDA $29 : CLC : ADC $FA2A, Y : STA $0901, X
              CLC : ADC $FA2C, Y : STA $0905, X
    
    LDA.w $FA27    : STA $0902, X
    LDA.w $FA28, Y : STA $0906, X
    LDA.w $FA2E    : STA $0903, X
    LDA.w $FA2F    : STA $0907, X
    
    INC $2A : INC $2A
    
    PLY
    
    PLB
    
    RTS
}

; ==============================================================================

    ; $67A87
{
    db $20, $FF, $00, $50, $18, $E0, $50, $18, $E0, $01, $FF, $00, $00
    
    ; $67A94
    
    db $48, $FF, $00, $30, $30, $D8, $01, $FF, $00, $00
    
    ; $67A9E
    
    ; Use direct hdma to write from A bus to registers $2126 and $2127,
    ; alternating on channel 6. 
    db $01
    db $26
    dl $0CFA87
}

; $067AA3-$067AC1 LOCAL JUMP LOCATION
Attract_SetupHdma:
{
    ; Note: This sets up the windowing via hdma for the legend sequence.
    
    LDX.b #$04
    
    .configLoop
    
        LDA $0CFA9E, X : STA $4360, X : STA $4370, X
    DEX : BPL .configLoop
    
    REP #$20
    
    ; I don't think they realized that this special casing actually lost
    ; bytes in the end. Using two 5 byte groups and an extra load uses 6
    ; bytes less.
    LDA.w #$FA94 : STA $4372
    
    SEP #$20
    
    ; Channel 7 will write to registers $2128 and $2129 (alternating).
    LDA.b #$28 : STA $4371
    
    RTS
}

; ==============================================================================

; $067AC2 DATA
{
    dw $6561, $2840, $3500, $8561, $2840, $3510, $A561, $2900
    dw $3501, $3502, $3501, $3502, $3501, $3502, $3501, $3502
    dw $3501, $3103, $7103, $3502, $3501, $3502, $3501, $3502
    dw $3501, $3502, $3501, $3502, $3501, $C561, $2900, $3511
    dw $3512, $3511, $3512, $3511, $3512, $3511, $3512, $3511
    dw $3513, $7513, $3512, $3511, $3512, $3511, $3512, $3511
    dw $3512, $3511, $3512, $3511, $E561, $2900, $3520, $3521
    dw $3520, $3521, $3520, $3521, $3520, $3521, $3520, $3521
    dw $3520, $3521, $3520, $3521, $3520, $3521, $3520, $3521
    dw $3520, $3521, $3520, $0562, $2840, $B500
    
    db $FF
    
    ; $067B5F
    dw $6561, $2840, $3500, $8561, $1300, $3510, $754E, $356E
    dw $3510, $354E, $3510, $354C, $3510, $754E, $3549, $8F61
    dw $0840, $3510, $9461, $0B00, $754E, $356E, $3510, $354E
    dw $3510, $354C, $A561, $2900, $755F, $755E, $357E, $357F
    dw $355E, $355F, $354D, $755F, $755E, $354A, $354B, $3510
    dw $7549, $3510, $755F, $755E, $357E, $357F, $355E, $355F
    dw $354D, $C561, $2900, $3550, $3551, $3552, $3553, $3554
    dw $3555, $3556, $3557, $3558, $3559, $355A, $355B, $355C
    dw $355D, $3550, $3551, $3552, $3553, $3554, $3555, $3556
    dw $E561, $2900, $3560, $3561, $3562, $3563, $3564, $3565
    dw $3566, $3567, $3568, $3569, $356A, $356B, $356C, $356D
    dw $3560, $3561, $3562, $3563, $3564, $3565, $3566, $0562
    dw $2900, $3570, $3571, $3572, $3573, $3574, $3575, $3576
    dw $3577, $3578, $3579, $357A, $357B, $357C, $357D, $3570
    dw $3571, $3572, $3573, $3574, $3575, $3576

    db $FF
    
    ; $067C4C
    dw $6561, $2840, $3500, $8561, $2840, $3510, $A561, $1D00
    dw $3522, $3523, $3510, $3522, $3523, $3510, $3522, $3523
    dw $3510, $3522, $3523, $3510, $7510, $7523, $7522, $B461
    dw $0640, $3510, $B861, $0300, $7523, $7522, $C561, $2900
    dw $3504, $3505, $3506, $3504, $3505, $3506, $3504, $3505
    dw $3506, $3504, $3505, $3506, $7506, $7505, $7504, $7510
    dw $7523, $7522, $7506, $7505, $7504, $E561, $2900, $3514
    dw $3515, $3516, $3514, $3515, $3516, $3514, $3515, $3516
    dw $3514, $3515, $3516, $7516, $7515, $7514, $7506, $7505
    dw $7504, $7516, $7515, $7514, $0562, $2900, $3524, $3525
    dw $3526, $3524, $3525, $3526, $3524, $3525, $3526, $3524
    dw $3525, $3526, $7526, $7525, $7524, $7526, $7525, $7524
    dw $7526, $7525, $7524
    
    db $FF
    
    ; $067D13
    dw $6561, $2900, $3500, $3500, $351B, $3530, $3531, $3532
    dw $3500, $3500, $3500, $3533, $3541, $7541, $7533, $7500
    dw $7500, $7500, $7532, $7531, $7530, $751B, $7500, $8561
    dw $1E40, $3510, $8661, $0900, $3534, $350B, $3540, $3541
    dw $3542, $9561, $0900, $7542, $7541, $7540, $750B, $7534
    dw $A561, $2900, $3543, $3544, $3507, $3508, $3509, $350A
    dw $3510, $350C, $350D, $350E, $350F, $750F, $750E, $750D
    dw $750C, $7510, $750A, $7509, $7508, $7507, $7544, $C561
    dw $2900, $3535, $3536, $3517, $3518, $3519, $351A, $3510
    dw $351C, $351D, $351E, $351F, $751F, $751E, $751D, $751C
    dw $7510, $751A, $7519, $7518, $7517, $7536, $E561, $2900
    dw $3545, $3546, $3527, $3528, $3529, $352A, $352B, $352C
    dw $352D, $352E, $352F, $752F, $752E, $752D, $752C, $752B
    dw $752A, $7529, $7528, $7527, $7546, $0562, $2900, $3547
    dw $3548, $3537, $3538, $3539, $353A, $353B, $353C, $353D
    dw $353E, $353F, $753F, $753E, $753D, $753C, $753B, $753A
    dw $7539, $7538, $7537, $7548
    
    db $FF
}
    
; $067E1C
Intro_HandleLogoSword:
{
    .char
    db $00
    db $02
    db $20
    db $22
    db $04
    db $06
    db $08
    db $0A
    db $0C
    db $0E

    .position_x
    db $40
    db $40
    db $30
    db $50
    db $40
    db $40
    db $40
    db $40
    db $40
    db $40

    .position_y
    dw $0010
    dw $0020
    dw $0028
    dw $0028
    dw $0030
    dw $0040
    dw $0050
    dw $0060
    dw $0070
    dw $0080

    db $00
}

; ==============================================================================
    
; $067E45-$067EE8 LOCAL JUMP LOCATION
{
    LDA.b #$07 : STA $CB
    
    STZ $CC
    STZ $CD
    
    REP #$20
    
    LDA.w #$FF7E : STA $C8
    
    SEP #$20
    
    ; $067E56 ALTERNATE ENTRY POINT
    
    ; Draws sword and does screen flashing in intro.
    
    PHB : PHK : PLB
    
    LDA $CA : BEQ .BRANCH_1
        DEC $CA
    
    .BRANCH_1
    
    JSL Palette_BgAndFixedColor_justFixedColor
    
    LDA $0FF9 : BEQ .BRANCH_4
        AND.b #$03 : BEQ .BRANCH_3
            LDX $D0
            
            LDA $1F : ORA $9C, X : STA $9C, X
            
            DEX : CPX.b #$03 : BNE .BRANCH_2
                LDX.b #$00
            
            .BRANCH_2
            
            STX $D0
        
        .BRANCH_3
        
        DEC $0FF9
    
    .BRANCH_4

    .loop
    
        LDY.b #$09 : TYA : ASL #2 : TAX
        
        LDA.b #$02 : STA $0A72, Y
        
        LDA.w $FE1C, Y : STA $094A, X
        LDA.b #$21   : STA $094B, X
        LDA.w $FE26, Y : STA $0948, X
        
        PHY : TYA : ASL A : TAY
        
        REP #$20
        
        LDA $C8 : CLC : ADC $FE30, Y
        
        SEP #$20
        
        XBA : BEQ .BRANCH_5
            LDA.b #$F8 : XBA
        
        .BRANCH_5
        
        XBA : SEC : SBC.b #$08 : STA $0949, X
    PHY : DEY : BPL .loop
    
    REP #$20
    
    LDA $C8 : CMP $001E : BEQ .BRANCH_8
        LDY.b #$01
        
        CMP $FFBE : BEQ .BRANCH_6
            CMP $000E : BNE .BRANCH_7
                STZ $D0
                
                LDX.b #$20 : STX $0FF9
                
                LDY.b #$2C
            
        .BRANCH_6
        
        STY $012E
        
        .BRANCH_7
        
        CLC : ADC.w #$0010 : STA $C8
    
    .BRANCH_8
    
    SEP #$20
    
    LDX $CC
    
    JMP ($FEE9, X) ; $067EE9
}

; ==============================================================================

; $067EE9-$067EEE JUMP TABLE for SR $067E56
{
    ; Parameter: $CC
    
    dw $FEEF ; = $067EEF
    dw $FF13 ; = $067F13
    dw $FF51 ; = $067F51
}

; ==============================================================================

; $067EEF-$067F04 JUMP LOCATION
{
    LDA $0FF9 : BNE .BRANCH_1
        REP #$20
        
        LDA $C8 : CMP $001E : SEP #$20 : BNE .BRANCH_1
            INC $CC : INC $CC
    
    .BRANCH_1
    
    PLB ; RESTORES THE OLD DATA BANK
    
    RTS
}

; $067F05-$067F12 DATA TABLE
{
    db $04, $04
    db $06, $06
    db $06, $04
    db $04, $28
    db $37, $27
    db $36, $27
    db $37, $28
}

; $067F13-$067F48 JUMP LOCATION
{
    LDX $CB
    
    LDA $CA : BNE .BRANCH_2
        DEX : STX $CB : BPL .BRANCH_1
            STZ $CB
            
            LDA.b #$02 : STA $CA
            
            INC $CC : INC $CC
            
            BRA .BRANCH_3
        
        .BRANCH_1
        
        ; $067F05. SEE DATA TABLE ABOVE.
        LDA.w $FF05, X : STA $CA
    
    .BRANCH_2
    
    STZ $0A70
    
    LDA.b #$44 : STA $0940
    LDA.b #$43 : STA $0941
    
    LDA $25 : STA $0943
    
    LDA.w $FF0C, X : STA $0942
    
    .BRANCH_3
    
    PLB ; RESTORES THE OLD DATA BANK
    
    RTS
}

; ==============================================================================

; $067F49 DATA
{
    db $26, $20
    db $24, $34
    db $25, $20
    db $35, $20
}

; $067F51-$067FB0 JUMP LOCATION
{
    LDX $CB : CPX.b #$07 : BCS .BRANCH_3
        STZ $0A70
        STZ $0A71
        
        LDA.b #$42 : STA $0940 : STA $0944
        
        LDA $CD : CMP.b #$50 : BCC .BRANCH_1
            LDA.b #$4F
        
        .BRANCH_1
        
        CLC : ADC.b #$C8 : CLC : ADC.b #$31 : STA $0941
        
        CLC : ADC.b #$08 : STA $0945
        
        LDA.b #$23 : STA $0943 : STA $0947
        
        LDA.w $FF49, X : STA $0942
        LDA.w $FF4A, X : STA $0946
        
        LDA $CA : BNE .BRANCH_3
            LDA $CD : CLC : ADC.b #$04 : STA $CD
            
            CMP.b #$04 : BEQ .BRANCH_2
            CMP.b #$48 : BEQ .BRANCH_2
            CMP.b #$4C : BEQ .BRANCH_2
                CMP.b #$58 : BNE .BRANCH_3
            
            .BRANCH_2
            
            INC $CB : INC $CB
    
    .BRANCH_3
    
    PLB
    
    RTS
}

; ==============================================================================

; $067FB1 NULL
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $0D8000
