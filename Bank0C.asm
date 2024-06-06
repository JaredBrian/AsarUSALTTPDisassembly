; ==============================================================================

; Bank 0C
; $060000-$067FFF
org $0C8000

; Overworld map data
; Title screen sequence
; Intro cutscene sequence
; 3D Triforce control
; File select menu control

; ==============================================================================

; $060000-$0600D1 DATA
;org $0C8000
OverworldMap32_Screen62_High:
{
    incbin "bin/ow/screen62-h.bin" ; size: 0x00D2
}

; $0600D2-$0601C3 DATA
;org $0C80D2
OverworldMap32_Screen62_Low: 
{
    incbin "bin/ow/screen62-l.bin" ; size: 0x00F2
}

; $0601C4-$060264 DATA
;org $0C81C4
OverworldMap32_Screen63_High:
{
    incbin "bin/ow/screen63-h.bin" ; size: 0x00A1
}

; $060265-$060320 DATA
;org $0C8265
OverworldMap32_Screen63_Low: 
{
    incbin "bin/ow/screen63-l.bin" ; size: 0x00BC
}

; $060321-$0603E5 DATA
;org $0C8321
OverworldMap32_Screen64_High:
{
    incbin "bin/ow/screen64-h.bin" ; size: 0x00C5
}

; $0603E6-$0604BC DATA
;org $0C83E6
OverworldMap32_Screen64_Low: 
{
    incbin "bin/ow/screen64-l.bin" ; size: 0x00D7
}

; $0604BD-$060597 DATA
;org $0C84BD
OverworldMap32_Screen25_High:
{
    incbin "bin/ow/screen25-h.bin" ; size: 0x00DB
}

; $060598-$060687 DATA
;org $0C8598
OverworldMap32_Screen25_Low: 
{
    incbin "bin/ow/screen25-l.bin" ; size: 0x00F0
}

; $060688-$060733 DATA
;org $0C8688
OverworldMap32_Screen66_High:
{
    incbin "bin/ow/screen66-h.bin" ; size: 0x00AC
}

; $060734-$06080C DATA
;org $0C8734
OverworldMap32_Screen66_Low: 
{
    incbin "bin/ow/screen66-l.bin" ; size: 0x00D9
}

; $06080D-$0608DC DATA
;org $0C880D
OverworldMap32_Screen67_High:
{
    incbin "bin/ow/screen67-h.bin" ; size: 0x00D0
}

; $0608DD-$0609CB DATA
;org $0C88DD
OverworldMap32_Screen67_Low: 
{
    incbin "bin/ow/screen67-l.bin" ; size: 0x00EF
}

; $0609CC-$060AA3 DATA
;org $0C89CC
OverworldMap32_Screen68_High:
{
    incbin "bin/ow/screen68-h.bin" ; size: 0x00D8
}

; $060AA4-$060B99 DATA
;org $0C8AA4
OverworldMap32_Screen68_Low: 
{
    incbin "bin/ow/screen68-l.bin" ; size: 0x00F6
}

; $060B9A-$060C72 DATA
;org $0C8B9A
OverworldMap32_Screen69_High:
{
    incbin "bin/ow/screen69-h.bin" ; size: 0x00D9
}

; $060C73-$060D6B DATA
;org $0C8C73
OverworldMap32_Screen69_Low: 
{
    incbin "bin/ow/screen69-l.bin" ; size: 0x00F9
}

; $060D6C-$060E3A DATA
;org $0C8D6C
OverworldMap32_Screen2A_High:
{
    incbin "bin/ow/screen2A-h.bin" ; size: 0x00CF
}

; $060E3B-$060F2A DATA
;org $0C8E3B
OverworldMap32_Screen2A_Low: 
{
    incbin "bin/ow/screen2A-l.bin" ; size: 0x00F0
}

; $060F2B-$06100B DATA
;org $0C8F2B
OverworldMap32_Screen2B_High:
{
    incbin "bin/ow/screen2B-h.bin" ; size: 0x00E1
}

; $06100C-$061105 DATA
;org $0C900C
OverworldMap32_Screen2B_Low: 
{
    incbin "bin/ow/screen2B-l.bin" ; size: 0x00FA
}

; $061106-$0611F0 DATA
;org $0C9106
OverworldMap32_Screen2C_High:
{
    incbin "bin/ow/screen2C-h.bin" ; size: 0x00EB
}

; $0611F1-$0612E7 DATA
;org $0C91F1
OverworldMap32_Screen2C_Low: 
{
    incbin "bin/ow/screen2C-l.bin" ; size: 0x00F7
}

; $0612E8-$0613D3 DATA
;org $0C92E8
OverworldMap32_Screen6D_High:
{
    incbin "bin/ow/screen6D-h.bin" ; size: 0x00EC
}

; $0613D4-$0614CF DATA
;org $0C93D4
OverworldMap32_Screen6D_Low: 
{
    incbin "bin/ow/screen6D-l.bin" ; size: 0x00FC
}

; $0614D0-$0615C3 DATA
;org $0C94D0
OverworldMap32_Screen2E_High:
{
    incbin "bin/ow/screen2E-h.bin" ; size: 0x00F4
}

; $0615C4-$0616BE DATA
;org $0C95C4
OverworldMap32_Screen2E_Low: 
{
    incbin "bin/ow/screen2E-l.bin" ; size: 0x00FB
}

; $0616BF-$0617B2 DATA
;org $0C96BF
OverworldMap32_Screen2F_High:
{
    incbin "bin/ow/screen2F-h.bin" ; size: 0x00F4
}

; $0617B3-$0618AF DATA
;org $0C97B3
OverworldMap32_Screen2F_Low: 
{
    incbin "bin/ow/screen2F-l.bin" ; size: 0x00FD
}

; $0618B0-$06196D DATA
;org $0C98B0
OverworldMap32_Screen70_High:
{
    incbin "bin/ow/screen70-h.bin" ; size: 0x00BE
}

; $06196E-$061A47 DATA
;org $0C996E
OverworldMap32_Screen70_Low: 
{
    incbin "bin/ow/screen70-l.bin" ; size: 0x00DA
}

; $061A48-$061AF3 DATA
;org $0C9A48
OverworldMap32_Screen71_High:
{
    incbin "bin/ow/screen71-h.bin" ; size: 0x00AC
}

; $061AF4-$061BC1 DATA
;org $0C9AF4
OverworldMap32_Screen71_Low: 
{
    incbin "bin/ow/screen71-l.bin" ; size: 0x00CE
}

; $061BC2-$061CB2 DATA
;org $0C9BC2
OverworldMap32_Screen72_High:
{
    incbin "bin/ow/screen72-h.bin" ; size: 0x00F1
}

; $061CB3-$061DAE DATA
;org $0C9CB3
OverworldMap32_Screen72_Low: 
{
    incbin "bin/ow/screen72-l.bin" ; size: 0x00FC
}

; $061DAF-$061E81 DATA
;org $0C9DAF
OverworldMap32_Screen33_High:
{
    incbin "bin/ow/screen33-h.bin" ; size: 0x00D3
}

; $061E82-$061F72 DATA
;org $0C9E82
OverworldMap32_Screen33_Low: 
{
    incbin "bin/ow/screen33-l.bin" ; size: 0x00F1
}

; $061F73-$062048 DATA
;org $0C9F73
OverworldMap32_Screen34_High:
{
    incbin "bin/ow/screen34-h.bin" ; size: 0x00D6
}

; $062049-$062131 DATA
;org $0CA049
OverworldMap32_Screen34_Low: 
{
    incbin "bin/ow/screen34-l.bin" ; size: 0x00E9
}

; $062132-$062225 DATA
;org $0CA132
OverworldMap32_Screen75_High:
{
    incbin "bin/ow/screen75-h.bin" ; size: 0x00F4
}

; $062226-$062328 DATA
;org $0CA226
OverworldMap32_Screen75_Low: 
{
    incbin "bin/ow/screen75-l.bin" ; size: 0x0103
}

; $062329-$0623DB DATA
;org $0CA329
OverworldMap32_Screen76_High:
{
    incbin "bin/ow/screen76-h.bin" ; size: 0x00B3
}

; $0623DC-$0624B9 DATA
;org $0CA3DC
OverworldMap32_Screen76_Low: 
{
    incbin "bin/ow/screen76-l.bin" ; size: 0x00DE
}

; $0624BA-$0625B2 DATA
;org $0CA4BA
OverworldMap32_Screen37_High:
{
    incbin "bin/ow/screen37-h.bin" ; size: 0x00F9
}

; $0625B3-$0626B1 DATA
;org $0CA5B3
OverworldMap32_Screen37_Low: 
{
    incbin "bin/ow/screen37-l.bin" ; size: 0x00FF
}

; $0626B2-$062798 DATA
;org $0CA6B2
OverworldMap32_Screen78_High:
{
    incbin "bin/ow/screen78-h.bin" ; size: 0x00E7
}

; $062799-$062897 DATA
;org $0CA799
OverworldMap32_Screen78_Low: 
{
    incbin "bin/ow/screen78-l.bin" ; size: 0x00FF
}

; $062898-$062970 DATA
;org $0CA898
OverworldMap32_Screen79_High:
{
    incbin "bin/ow/screen79-h.bin" ; size: 0x00D9
}

; $062971-$062A6C DATA
;org $0CA971
OverworldMap32_Screen79_Low: 
{
    incbin "bin/ow/screen79-l.bin" ; size: 0x00FC
}

; $062A6D-$062B63 DATA
;org $0CAA6D
OverworldMap32_Screen7A_High:
{
    incbin "bin/ow/screen7A-h.bin" ; size: 0x00F7
}

; $062B64-$062C5E DATA
;org $0CAB64
OverworldMap32_Screen7A_Low: 
{
    incbin "bin/ow/screen7A-l.bin" ; size: 0x00FB
}

; $062C5F-$062D49 DATA
;org $0CAC5F
OverworldMap32_Screen3B_High:
{
    incbin "bin/ow/screen3B-h.bin" ; size: 0x00EB
}

; $062D4A-$062E36 DATA
;org $0CAD4A
OverworldMap32_Screen3B_Low: 
{
    incbin "bin/ow/screen3B-l.bin" ; size: 0x00ED
}

; $062E37-$062F23 DATA
;org $0CAE37
OverworldMap32_Screen3C_High:
{
    incbin "bin/ow/screen3C-h.bin" ; size: 0x00ED
}

; $062F24-$063015 DATA
;org $0CAF24
OverworldMap32_Screen3C_Low: 
{
    incbin "bin/ow/screen3C-l.bin" ; size: 0x00F2
}

; $063016-$06310B DATA
;org $0CB016
OverworldMap32_Screen7D_High:
{
    incbin "bin/ow/screen7D-h.bin" ; size: 0x00F6
}

; $06310C-$06320A DATA
;org $0CB10C
OverworldMap32_Screen7D_Low: 
{
    incbin "bin/ow/screen7D-l.bin" ; size: 0x00FF
}

; $06320B-$0632E5 DATA
;org $0CB20B
OverworldMap32_Screen7E_High:
{
    incbin "bin/ow/screen7E-h.bin" ; size: 0x00DB
}

; $0632E6-$0633D1 DATA
;org $0CB2E6
OverworldMap32_Screen7E_Low: 
{
    incbin "bin/ow/screen7E-l.bin" ; size: 0x00EC
}

; $0633D2-$0634C7 DATA
;org $0CB3D2
OverworldMap32_Screen3F_High:
{
    incbin "bin/ow/screen3F-h.bin" ; size: 0x00F6
}

; $0634C8-$0635C7 DATA
;org $0CB4C8
OverworldMap32_Screen3F_Low: 
{
    incbin "bin/ow/screen3F-l.bin" ; size: 0x0100
}

; $0635C8-$0635CB DATA
;org $0CB5C8
OverworldMap32_Screen9E_High:
{
    incbin "bin/ow/screen9E-h.bin" ; size: 0x0004
}

; $0635CC-$06367A DATA
;org $0CB5CC
OverworldMap32_Screen9E_Low: 
{
    incbin "bin/ow/screen9E-l.bin" ; size: 0x00AF
}

; $06367B-$06367E DATA
;org $0CB67B
OverworldMap32_Screen97_High:
{
    incbin "bin/ow/screen97-h.bin" ; size: 0x0004
}

; $06367F-$0636BD DATA
;org $0CB67F
OverworldMap32_Screen97_Low: 
{
    incbin "bin/ow/screen97-l.bin" ; size: 0x003F
}

; $0636BE-$063742 DATA
;org $0CB6BE
OverworldMap32_Screen9F_High:
{
    incbin "bin/ow/screen9F-h.bin" ; size: 0x0085
}

; $063743-$06383B DATA
;org $0CB743
OverworldMap32_Screen9F_Low: 
{
    incbin "bin/ow/screen9F-l.bin" ; size: 0x00F9
}

; $06383C-$0638AB DATA
;org $0CB83C
OverworldMap32_Screen80_High:
{
    incbin "bin/ow/screen80-h.bin" ; size: 0x0070
}

; $0638AC-$06397B DATA
;org $0CB8AC
OverworldMap32_Screen80_Low: 
{
    incbin "bin/ow/screen80-l.bin" ; size: 0x00D0
}

; $06397C-$063A15 DATA
;org $0CB97C
OverworldMap32_Screen81_High:
{
    incbin "bin/ow/screen81-h.bin" ; size: 0x009A
}

; $063A16-$063AF1 DATA
;org $0CBA16
OverworldMap32_Screen81_Low: 
{
    incbin "bin/ow/screen81-l.bin" ; size: 0x00DC
}

; $063AF2-$063BB8 DATA
;org $0CBAF2
OverworldMap32_Screen82_High:
{
    incbin "bin/ow/screen82-h.bin" ; size: 0x00C7
}

; $063BB9-$063CAD DATA
;org $0CBBB9
OverworldMap32_Screen82_Low: 
{
    incbin "bin/ow/screen82-l.bin" ; size: 0x00F5
}

; $063CAE-$063D5D DATA
;org $0CBCAE
OverworldMap32_Screen89_High:
{
    incbin "bin/ow/screen89-h.bin" ; size: 0x00B0
}

; $063D5E-$063E4A DATA
;org $0CBD5E
OverworldMap32_Screen89_Low: 
{
    incbin "bin/ow/screen89-l.bin" ; size: 0x00ED
}

; $063E4B-$063F04 DATA
;org $0CBE4B
OverworldMap32_Screen8A_High:
{
    incbin "bin/ow/screen8A-h.bin" ; size: 0x00BA
}

; $063F05-$063FD6 DATA
;org $0CBF05
OverworldMap32_Screen8A_Low: 
{
    incbin "bin/ow/screen8A-l.bin" ; size: 0x00D2
}

; $063FD7-$063FDD DATA
;org $0CBFD7
OverworldMap32_Screen96_High:
{
    incbin "bin/ow/screen96-h.bin" ; size: 0x0007
}

; $063FDE-$063FF9 DATA
;org $0CBFDE
OverworldMap32_Screen96_Low: 
{
    incbin "bin/ow/screen96-l.bin" ; size: 0x001C
}

; $063FFA-$064043 DATA
;org $0CBFFA
OverworldMap32_Screen95_High:
{
    incbin "bin/ow/screen95-h.bin" ; size: 0x004A
}

; $064044-$0640AB DATA
;org $0CC044
OverworldMap32_Screen95_Low: 
{
    incbin "bin/ow/screen95-l.bin" ; size: 0x0068
}

; $0640AC-$0640AF DATA
;org $0CC0AC
OverworldMap32_Screen9C_High:
{
    incbin "bin/ow/screen9C-h.bin" ; size: 0x0004
}

; $0640B0-$0640B3 DATA
;org $0CC0B0
OverworldMap32_Screen9C_Low: 
{
    incbin "bin/ow/screen9C-l.bin" ; size: 0x0004
}

; $0640B4-$0640B7 DATA
;org $0CC0B4
OverworldMap32_Screen88_High:
{
    incbin "bin/ow/screen88-h.bin" ; size: 0x0004
}

; $0640B8-$06410A DATA
;org $0CC0B8
OverworldMap32_Screen88_Low: 
{
    incbin "bin/ow/screen88-l.bin" ; size: 0x0054
}

; ==============================================================================

; $06410C-$06411F DATA
NULL_0CC10C:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF
}

; ==============================================================================

; $064120-$06415C JUMP LOCATION
Module_Intro:
{
    ; Beginning of Module 0x00, Startup Screen:
    
    LDA.b $11 : CMP.b #$08 : BCC .dontCheckInput
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ .noPressedButtons
        ; If ABXY, or Start is pressed, then go to the file selection menu
        ; module.
        JMP $C2F0
    
    .noPressedButtons
    .dontCheckInput
    
    ; Otherwise, branch to the appropriate part of the intro.
    LDA.b $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl Intro_Init          ; $06415D Blank Screen
    dl Intro_Init.justLogo ; $064170 -Nintendo presents-
    dl Intro_InitGfx       ; $06433C Sets up myriad graphics settings
    dl $0CC404             ; $064404 Copyright Nintendo 1992
    dl $0CC404             ; $064404 Triforces swooping in.
    dl $0CC25C             ; $06425C "Zelda" logo fade in.
    dl $0CC2AE             ; $0642AE Sword coming down...
    dl $0CC284             ; $064284 Fades in bg, Zelda Symbol is sparkling, looking pretty.
    dl $0CC2D4             ; $0642D4 Wait to see if the player does anything.
    dl $0CC404             ; $064404 This one and the next 2 are unused.
    dl Intro_InitGfx       ; $06433C
    dl $0CC404             ; $064404
}

; ==============================================================================

; $06415D-$06419F JUMP LOCATION
Intro_Init:
{
    JSL Intro_SetupScreen
    
    ; Push the screen to full brightness next frame.
    LDA.b #$0F : STA.b $13
    
    ; Initialize the sub-submodule index.
    STZ.b $B0
    
    ; Indicates that CGRAM needs to be updated next frame.
    INC.b $15
    
    ; Move into the next submodule.
    INC.b $11
    
    ; Plays the twinkle as the 'Nintendo' logo pops up.
    LDA.b #$0A : STA.w $012F
    
    ; $064170 ALTERNATE ENTRY POINT
    .justLogo
    
    ; $066D82, sets up sprite information for the N-logo.
    ; (OAM buffer is refreshed every frame, so this must be repeatedly called)
    JSR Intro_DisplayNintendoLogo
    
    ; As long as $B0 is less than 0xB, no branch occurs.
    LDA.b $B0 : INC.b $B0 : CMP.b #$0B : BCS Intro_LoadTitleGraphics
    
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
    ; Zerores out a 0x400 byte chunk of wram.
    
    REP #$30
    
    ; $C8 is the Upper Bound, $CA stores the Lower Bound.
    LDX.b $C8
    
    LDA.w #$0000
    
    .zeroLoop
    
        ; Erases $7E0000-$7FFFF (all work ram)
        STA.l $7E2000, X : STA.l $7E4000, X
        STA.l $7E6000, X : STA.l $7E8000, X
        STA.l $7EA000, X : STA.l $7EC000, X
        STA.l $7EE000, X : STA.l $7F0000, X
        STA.l $7F2000, X : STA.l $7F4000, X
        STA.l $7F6000, X : STA.l $7F8000, X
        STA.l $7FA000, X : STA.l $7FC000, X
        STA.l $7FE000, X
    DEX #2 : CPX.b $CA : BNE .zeroLoop
    
    ; The old lower bound is the new upper bound.
    STX.b $C8
    
    ; Reindex $CA 0x400 bytes lower for the next time this gets called.
    TXA : SEC : SBC.w #$0400 : STA.b $CA
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0641F5-$06425B BRANCH LOCATION
Intro_LoadTitleGraphics:
{
    DEC.b $13 : BNE .waitTillForceBlank
        ; $0641F9 ALTERNATE ENTRY POINT
        .noWait
        
        ; $00093D
        JSL EnableForceBlank
        JSL Vram_EraseTilemaps.normal
        
        LDA.b #$02 : STA.w $2101
        
        ; What tiles shall we put on the start up screen?
        LDA.b #$23 : STA.w $0AA1
        
        ; Determines the tiles for the sword on the title screen.
        LDA.b #$7D : STA.w $0AA3
        
        ; Deterines some of the other tiles used for the title screen.
        LDA.b #$51 : STA.w $0AA2
        
        ; Extra sprite graphics pack.
        LDA.b #$08 : STA.w $0AA4
        
        ; Why we're calling this prior to InitTileSets.... no idea. It seems 
        ; that InitTileSets would overwrite any graphics this routine would
        ; decompress.
        JSL LoadDefaultGfx ; $0062D0
        JSL InitTileSets   ; $00619B
        
        LDY.b #$5D
        
        JSL DecompDungAnimatedTiles ; $005337
        
        LDA.b #$02 : STA.l $7EC00D
        LDA.b #$00 : STA.l $7EC00E
        
        STZ.b $8A
        
        STZ.w $0AB6
        
        STA.w $0AB8
        
        STZ.b $C8
        STZ.b $C9
        STZ.b $CA
        STZ.b $CB
        
        LDA.b #$02 : STA.l $7EC009
        LDA.b #$1F : STA.l $7EC007
        LDA.b #$00 : STA.l $7EC00B
        
        STZ.w $0AA6
        
        INC.b $11
    
    .waitTillForceBlank
    
    RTL
}

; ==============================================================================

; $06425C-$064283 JUMP LOCATION
Intro_FadeLogoIn:
{
    JSL.l $0CC404 ; $064404
    
    LDA.b $1A : LSR A : BCC .evenFrame
        JSL.l $00ED7C ; $006D7C
        
        LDA.l $7EC007 : BNE .BRANCH_2
            LDA.b #$2A : STA.b $B0
            
            INC.b $11
            
            JSR $FE45 ; $067E45
    
    .evenFrame
    
    RTL
    
    .BRANCH_2
    
    CMP.b #$0D : BNE .dontEnableBGs
        LDA.b #$15 : STA.b $1C
        
        STZ.b $1D
    
    .dontEnableBGs
    
    RTL
}

; ==============================================================================

; $064284-$0642AD JUMP LOCATION
Intro_PopSubtitleCard:
{
    JSR $FE56   ; $067E56
    JSL.l $0CC404 ; $064404
    
    LDA.l $7EC007 : BEQ .alpha
        LDA.b $1A : LSR A : BCC .dontAdvanceYet
            JML.l $00ED8F ; $006D8F
    
    .alpha
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ .waitForButtonPress
        JMP $C2F0 ; $0642F0
    
    .waitForButtonPress
    
    DEC.b $B0 : BNE .dontAdvanceYet
        INC.b $11
    
    .dontAdvanceYet
    
    RTL
}

; ==============================================================================

; $0642AE-$0642D3 JUMP LOCATION
Intro_SwordStab:
{
    JSL.l $0CC404 ; $064404
    
    STZ.w $1F00
    STZ.w $012A
    
    JSR $FE56 ; $067E56
    
    DEC.b $B0 : BNE .BRANCH_1
        INC.b $11
        
        LDA.b #$02 : STA.b $99
        LDA.b #$22 : STA.b $9A
        
        LDA.b #$1F : STA.l $7EC007
        
        LDA.b #$02 : STA.b $1D
    
    .BRANCH_1
    
    RTL
}

; ==============================================================================

; $0642D4-$0642EF JUMP LOCATION 
Intro_TrianglesBeforeAttract:
{
    JSL.l $0CC404 ; $064404
    
    STZ.w $1F00
    STZ.w $012A
    
    JSR $FE56 ; $067E56
    
    DEC.b $B0 : BNE .BRANCH_1
        ; Note that this instruction does nothing since
        ; $11 is zeroed out a few lines down. programmers aren't perfect!
        INC.b $11
        
        ; Change to mode 0x14.
        LDA.b #$14 : STA.b $10
        
        ; Reset the submodule index.
        STZ.b $11
        
        ; Reset the attract mode sequencing index.
        STZ.b $22
    
    .BRANCH_1
    
    RTL
}

; ==============================================================================

; $0642F0-$06433B JUMP LOCATION
FadeMusicAndResetSRAMMirror:
{
    LDA.b #$FF : STA.w $0128
    
    ; Main screen designation.
    LDA.b #$15 : STA.b $1C
    
    STZ.b $1D
    
    STZ.b $1B
    
    ; Give the silence command for music.
    LDA.b #$F1 : STA.w $012C
    
    JSL Palette_BgAndFixedColor_justFixedColor
    
    REP #$30
    
    LDX.w #$006E
    
    .loop
    
        ; Zeroes out $20-$8E.
        STZ.b $20, X
    DEX #2 : BPL .loop
    
    LDX.w #$0000
    
    TXA
    
    .initSramBuffer
    
        ; Clear the save memory area.
        STA.l $7EF000, X : STA.l $7EF100, X
        STA.l $7EF200, X : STA.l $7EF300, X
        STA.l $7EF400, X
    INX #2 : CPX.w #$0100 : BNE .initSramBuffer
    
    SEP #$30
    
    ; Go to select screen mode.
    LDA.b #$01 : STA.b $10 : STA.w $04AA
    
    STZ.b $11
    
    RTL
}

; ==============================================================================

; $06433C-$06436E JUMP LOCATION
Intro_InitGfx:
{
    ; Module 0x00.0x02, 0x00.0x0A
    
    ; Set misc. sprite graphics.
    LDA.b #$08 : STA.w $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    JSR $C36F ; $06436F
    
    LDA.b #$01 : STA.w $1E10 : STA.w $1E11 : STA.w $1E12
    LDA.b #$00 : STA.w $1E18 : STA.w $1E19 : STA.w $1E1A
    
    LDA.b #$01 : STA.w $1E14
    LDA.b #$02 : STA.w $1E1C
    
    ; Bring screen to full brightness.
    LDA.b #$0F : STA.b $13
    
    INC.b $11
    
    RTL
}

; ==============================================================================

; $06436F-$0643BC LOCAL JUMP LOCATION
TriforceInitializePolyhedralModule:
{
    JSL Polyhedral_InitThread
    JSR $C3BD ; $0643BD
    
    ; Set vertical IRQ trigger scanline.
    LDA.b #$90 : STA.b $FF
    
    LDA.b #$FF : STA.w $1F02
    LDA.b #$20 : STA.w $1F06 : STA.w $1F07 : STA.w $1F08
    LDA.b #$A0 : STA.w $1F04
    LDA.b #$60 : STA.w $1F05
    LDA.b #$01 : STA.w $1F01 : STA.w $1F03 : STA.w $012A : STA.w $1F00
    
    ; Initialize RAM for starting Module 0x00.
    LDX.b #$0F
    
    .loop
    
        STZ.w $1E00, X : STZ.w $1E10, X : STZ.w $1E20, X
        STZ.w $1E30, X : STZ.w $1E40, X : STZ.w $1E50, X
        STZ.w $1E60, X
    DEX : BPL .loop
    
    RTS
}

; ==============================================================================

; $0643BD-$064403 LOCAL
LoadTriforceSpritePalette:
{
    ; The guy who wrote this routine had never heard of MVN or MVP apparently
    ; or DMA, for that matter.
    ; This routine writes a fixed set of colors to SP-6 (first half).
    
    REP #$20
    
    LDA.l $0CC425 : STA.l $7EC6A0
    LDA.l $0CC427 : STA.l $7EC6A2
    LDA.l $0CC429 : STA.l $7EC6A4
    LDA.l $0CC42B : STA.l $7EC6A6
    LDA.l $0CC42D : STA.l $7EC6A8
    LDA.l $0CC42F : STA.l $7EC6AA
    LDA.l $0CC431 : STA.l $7EC6AC
    LDA.l $0CC433 : STA.l $7EC6AE
    
    SEP #$30
    
    ; Perform palette update this frame.
    INC.b $15
    
    RTS
}

; ==============================================================================

; $064404-$064411 LONG JUMP LOCATION
Intro_HandleAllTriforceAnimations:
{
    PHB : PHK : PLB
    
    INC.w $1E0A
    
    JSR $C435 ; $064435
    JSR $C412 ; $064412
    
    PLB
    
    RTL
}

; ==============================================================================

; $064412-$064424 LOCAL JUMP LOCATION
Scene_AnimateEverySprite:
{
    LDA.b #$00 : STA.w $1E08
    LDA.b #$09 : STA.w $1E09
    
    LDX.b #$07
    
    .loop
    
        JSR $C534 ; $064534
    DEX : BPL .loop
    
    RTS
}

; ==============================================================================

; $064425-$064434 DATA
Palettes_Triforce:
{
    ; FOR USE WITH $643BD
    
    dw $0000, $014D, $01B0, $01F3, $0256, $0279, $02FD, $035F
}

; ==============================================================================

; $064435-$064447 LOCAL JUMP LOCATION
Intro_AnimateTriforce:
{
    LDA.b #$01 : STA.w $012A
    
    ; Is this some sort of "IRQ busy" flag?
    LDA.w $1F00 : BNE .waitForTriforceThread
        JSR $C448 ; $064448
        
        LDA.b #$01 : STA.w $1F00
    
    .waitForTriforceThread
    
    RTS
}

; ==============================================================================

; $064448-$06445A LOCAL JUMP LOCATION
Intro_AnimateTriforceDanceMoves:
{
    LDA.w $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $C45B ; = $06445B
    dw $C47B ; = $06447B
    dw $C4BA ; = $0644BA
    dw $C4D6 ; = $0644D6
    dw $C500 ; = $064500
    dw $C533 ; = $064533 (Empty unimplemented step - RTS)
}

; $06445B-$06447A JUMP LOCATION
Intro_TriforceTinyDancers:
{
    INC.w $1E01
    
    LDA.w $1E01 : CMP.b #$40 : BNE .countingUp
        INC.w $1E00
    
    .countingUp
    
    LDA.w $1F05 : CLC : ADC.b #$05 : STA.w $1F05
    LDA.w $1F04 : CLC : ADC.b #$03 : STA.w $1F04
    
    RTS
}

; $06447B-$0644B9 JUMP LOCATION
Intro_TriforceSpinInwards:
{
    LDA.w $1F02 : CMP.b #$02 : BCS .alpha
        STZ.w $1F02
        
        INC.w $1E00
        
        LDA.b #$40 : STA.w $1E01
        
        RTS
    
    .alpha
    
    SBC.b #$02 : STA.w $1F02
    
    LDA.w $1F05 : CLC : ADC.b #$05 : STA.w $1F05
    LDA.w $1F04 : CLC : ADC.b #$03 : STA.w $1F04
    
    LDA.w $1F02 : CMP.b #$E1 : BCS .beta
        LDX.b #$04 : STX.b $11
    
    .beta
    
    CMP.b #$71 : BNE .dontStartMusic
        ; Selects the opening theme during the triforce scene/ intro.
        LDA.b #$01 : STA.w $012C
    
    .dontStartMusic
    
    RTS
}

; $0644BA-$0644D5 JUMP LOCATION
Intro_TriforceNearingMerge:
{
    DEC.w $1E01 : BNE .countingDown
        INC.w $1E00
        
        RTS
    
    .countingDown
    
    LDA.w $1F05 : CLC : ADC.b #$05 : STA.w $1F05
    LDA.w $1F04 : CLC : ADC.b #$03 : STA.w $1F04
    
    RTS
}

; $0644D6-$0644FF JUMP LOCATION
Intro_MergeTriforceSpin:
{
    LDA.w $1F05 : CMP.b #$FA : BCC .alpha
        LDA.w $1F04 : CMP.b #$FC : BCC .alpha
            INC.w $1E00
            
            LDA.b #$20 : STA.w $1E01
            
            RTS
    
    .alpha
    
    LDA.w $1F05 : CLC : ADC.b #$05 : STA.w $1F05
    LDA.w $1F04 : CLC : ADC.b #$03 : STA.w $1F04
    
    RTS
}

; $064500-$064532 JUMP LOCATION
Intro_TriforceTerminateSpin:
{
    STZ.w $1F05
    STZ.w $1F04
    
    DEC.w $1E01 : BNE .countingDown
        INC.w $1E00
        
        LDA.b #$01 : STA.w $1E15
        LDA.b #$03 : STA.w $1E1D
        
        LDA.b #$10 : STA.b $1C
        LDA.b #$05 : STA.b $1D
        
        LDA.b #$02 : STA.b $99
        LDA.b #$31 : STA.b $9A
        
        STZ.b $B0
        
        INC.b $15
        
        LDA.b #$03
        
        ; $06452E ALTERNATE ENTRY POINT
        .doTilemapUpdate
        
        STA.b $14
        
        INC.b $11
    
    .countingDown
    
    RTS
}

; $064533-$064533 JUMP LOCATION
Intro_TriforceDoNothing:
{
    ; Empty step ... put here for a purpose probably though
    ; from what I can tell. I think this does get executed,
    ; contrary to what one might think by looking at the previous step.
    RTS
}

; $064534-$064542 LOCAL JUMP LOCATION
Scene_AnimateSingleSprite:
{
    LDA.w $1E10, X : BEQ .exit
        JSL UseImplicitRegIndexedLocalJumpTable
        
        ; Jump table
        dw .exit ; = $064543
        dw $C544 ; = $064544
        dw $C55B ; = $06455B
    
    .exit
    
    RTS
}

; $064544-$06455A JUMP LOCATION
InitializeSceneSprite:
{
    LDA.w $1E18, X
    
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
AnimateSceneSprite:
{
    LDA.w $1E18, X
    
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
Pool_InitializeSceneSprite_Triangle:
{
    ; $064572
    .pos_x_start
    dw $FFDA
    dw $005F
    dw $00E6

    ; $064578
    .pos_y_start
    dw $00C8
    dw $FFBD
    dw $00C8
}

; $06457E-$0645B0 JUMP LOCATION
InitializeSceneSprite_Triangle:
{
    TXA : ASL : TAY
    
    LDA.w $C572, Y : STA.w $1E30, X
    LDA.w $C573, Y : STA.w $1E38, X
    LDA.w $C578, Y : STA.w $1E48, X
    LDA.w $C579, Y : STA.w $1E50, X
    
    LDA.w $C5CA, X : CLC : ADC.w $1E58, X : STA.w $1E58, X
    LDA.w $C5CD, X : CLC : ADC.w $1E60, X : STA.w $1E60, X
    
    INC.w $1E10, X
    
    RTS
}

; $0645B1-$0645C9 JUMP LOCATION
AnimateSceneSprite_Triangle:
{
    JSR $C70F ; $06470F
    JSR $C9F1 ; $0649F1
    
    LDA.w $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C5D6 ; $0645D6
    dw $C608 ; $064608
}

; $0645CA-$0645CC DATA
IntroTriangleSpeedX:
{
    ; USED WITH $0645D6
    dw $0001, $FFFF, $FF01
}

; $0645CD-$0645D5 DATA
IntroTriangleSpeedY:
{
    dw $5F4B, $5875, $5830
}

; $0645D6-$064607 JUMP LOCATION
IntroTriangle_MoveIntoPlace:
{
    LDA.w $1E0A : AND.b #$1F : BNE .BRANCH_1
        LDA.w $C5CA, X : CLC : ADC.w $1E58, X : STA.w $1E58, X
        LDA.w $C5CD, X : CLC : ADC.w $1E60, X : STA.w $1E60, X
        
    .BRANCH_1
    
    LDA.w $C5D0, X : CMP.w $1E30, X : BNE .BRANCH_2
        STZ.w $1E58, X
    
    .BRANCH_2
    
    LDA.w $C5D3, X : CMP.w $1E48, X : BNE .BRANCH_3
        STZ.w $1E60, X
    
    .BRANCH_3
    
    RTS
}

; $064608-$06460E JUMP LOCATION
IntroTriangle_StopMoving:
{
    STZ.w $1E58, X
    STZ.w $1E60, X
    
    RTS
}

; $06460F-$06470E
AnimateSceneSprite_DrawTriangle:
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
AnimateSceneSprite_DrawTriangle:
{
    LDA.b #$10 : STA.b $06
                 STZ.b $07
    
    CPX.b #$02 : BEQ .BRANCH_1
        LDA.b #$0F : STA.b $08
        LDA.b #$C6 : STA.b $09
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.b #$8F : STA.b $08
    LDA.b $C6    : STA.b $09
    
    .BRANCH_2
    
    JSR $C972 ; $064972
    
    RTS
}

; $06482F-$06484E LOCAL JUMP LOCATION
AnimateSceneSprite_DrawTriforceRoomTriangle:
{
    LDA.b #$10 : STA.b $06
                 STZ.b $07
    
    CPX.b #$02 : BEQ .BRANCH_1
        LDA.b #$2F : STA.b $08
        LDA.b $C7    : STA.b $09
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.b #$AF : STA.b $08
    LDA.b #$C7 : STA.b $09
    
    .BRANCH_2
    
    JSR $C972 ; $064972
    
    RTS
}

; $06484F-$06484F JUMP LOCATION
SceneSprite_TitleCard:
{
    RTS
}

; $064850-$064863 JUMP LOCATION
InitializeSceneSprite_Copyright:
{
    LDA.b #$4C : STA.w $1E30, X
    
    STZ.w $1E38, X
    
    LDA.b #$B8 : STA.w $1E48, X
    
    STZ.w $1E50, X
    
    INC.w $1E10, X
    
    RTS
}

; $064864-$064867 JUMP LOCATION
AnimateSceneSprite_Copyright:
{
    JSR $C8D0 ; $0648D0
    
    RTS
}

Pool_AnimateSceneSprite_DrawCopyright:
{
    .groups
    dw   0,   0 : db $40, $0A, $00, $00
    dw   8,   0 : db $41, $0A, $00, $00
    dw  16,   0 : db $42, $0A, $00, $00
    dw  24,   0 : db $68, $0A, $00, $00
    dw  32,   0 : db $41, $0A, $00, $00
    dw  40,   0 : db $42, $0A, $00, $00
    dw  48,   0 : db $43, $0A, $00, $00
    dw  56,   0 : db $44, $0A, $00, $00
    dw  64,   0 : db $50, $0A, $00, $00
    dw  72,   0 : db $51, $0A, $00, $00
    dw  80,   0 : db $52, $0A, $00, $00
    dw  88,   0 : db $53, $0A, $00, $00
    dw  96,   0 : db $54, $0A, $00, $00
}

; $0648D0-$0648E1 LOCAL JUMP LOCATION
AnimateSceneSprite_DrawCopyright:
{
    LDA.b #$0D : STA.b $06
                 STZ.b $07
    LDA.b #$68 : STA.b $08
    LDA.b #$C8 : STA.b $09
    
    JSR $C972 ; $064972
    
    RTS
}

; $0648E2-$0648FC JUMP LOCATION
InitializeSceneSprite_Sparkle:
{
    LDA.w $1E0A : LSR #5 : AND.b #$03 : TAY
    
    LDA.w $C8FD, Y : STA.w $1E30, X
    LDA.w $C901, Y : STA.w $1E48, X
    
    INC.w $1E10, X
    
    RTS
}

; $0648FD-$06490C DATA
Pool_AnimateSceneSprite_Sparkle:
{
    ; $0648FD
    .position_x
    db $C2, $98, $6F, $34

    ; $064901
    .position_y
    db $7C, $54, $7C, $57

    ; $064905
    .anim_step
    db $00, $01, $02, $03, $02, $01, $FF, $FF
}

; $06490D-$064935 JUMP LOCATION
AnimateSceneSprite_Sparkle:
{
    JSR $C956 ; $064956
    
    LDA.w $1E0A : LSR #2 : AND.b #$03 : TAY
    
    LDA.w $C8FD, Y : STA.w $1E30, X
    LDA.w $C901, Y : STA.w $1E48, X
    
    RTS
}

; $064936-$064955 DATA
Pool_AnimateSceneSprite_DrawSparkle:
{
    .groups
    dw   0,   0 : db $80, $34, $00, $00
    dw   0,   0 : db $B7, $34, $00, $00
    dw  -4,  -3 : db $64, $38, $00, $02
    dw  -4,  -3 : db $62, $34, $00, $02
}

; $064956-$064971 LOCAL JUMP LOCATION
AnimateSceneSprite_DrawSparkle:
{
    LDA.b #$01 : STA.b $06 : STZ.b $07
    
    LDA.w $1E20, X : BMI .BRANCH_1
        ASL #3 : ADC.b #$36 : STA.b $08
        
        LDA.b #$C9 : ADC.b #$00 : STA.b $09
        
        JSR $C972 ; $064972
    
    .BRANCH_1
    
    RTS
}

; ==============================================================================

; $064972-$0649F0 LOCAL JUMP LOCATION
AnimateSceneSprite_AddObjectsToOAMBuffer:
{
    ; Puts triforce sprites in OAM buffer.
    LDA.w $1E30, X : STA.b $00
    LDA.w $1E38, X : STA.b $01
    LDA.w $1E48, X : STA.b $02
    LDA.w $1E50, X : STA.b $03
    
    STZ.b $04 : STZ.b $05
    
    PHX
    
    REP #$30
    
    LDY.w #$0000
    
    LDX.w $1E08
    
    LDA.b $06 : ASL #2 : ADC.w $1E08 : STA.w $1E08
    
    .nextSprite
    
        LDA ($08), Y : CLC : ADC.b $00 : STA.w $0000, X
        
        AND.w #$0100 : STA.b $0C
        
        INY #2
        
        LDA ($08), Y : CLC : ADC.b $02 : STA.w $0001, X
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .y_in_range
            LDA.w #$00F0 : STA.w $0001, X
        
        .y_in_range
        
        INY #2
        
        LDA ($08), Y : EOR.b $04 : STA.w $0002, X
        
        PHX
        
        TXA : SEC : SBC.w #$0800 : LSR #2 : TAX
        
        SEP #$20
        
        INY #3
        
        LDA ($08), Y : ORA.b $0D : STA.w $0A20, X
        
        PLX
        
        REP #$20
        
        INY
        
        INX #4
    DEC.b $06 : BNE .nextSprite
    
    SEP #$30
    
    PLX
    
    RTS
}

; ==============================================================================

; $0649F1-$064A4B LOCAL JUMP LOCATION
AnimateSceneSprite_MoveTriangle:
{
    LDA.w $1E58, X : BEQ .BRANCH_2
        ASL #4 : CLC : ADC.w $1E28, X : STA.w $1E28, X
        
        LDA.w $1E58, X : PHP : LSR #4
        
        LDY.b #$00
        
        PLP : BPL .BRANCH_1
            ORA.b #$F0
            
            DEY
        
        .BRANCH_1
        
        ADC.w $1E30, X : STA.w $1E30, X
        
        TYA : ADC.w $1E38, X : STA.w $1E38, X
    
    .BRANCH_2
    
    LDA.w $1E60, X : BEQ .BRANCH_4
        ASL #4 : CLC : ADC.w $1E40, X : STA.w $1E40, X
        
        LDA.w $1E60, X : PHP : LSR #4
        
        LDY.b #$00
        
        PLP : BPL .BRANCH_3
            ORA.b #$F0
            
            DEY
        
        .BRANCH_3
        
        ADC.w $1E48, X : STA.w $1E48, X
        
        TYA : ADC.w $1E50, X : STA.w $1E50, X
    
    .BRANCH_4
    
    RTS
}

; ==============================================================================

; $064A4C-$064A53 LOCAL JUMP LOCATION
AnimateSceneSprite_TerminateTriangle:
{
    LDA.w $1E02 : BEQ .BRANCH_1
        ; Note that this maneuver will pull the return address from this Sub
        ;off the stack and we will end up at the sub that called this Sub's
        ; caller.
        PLA : PLA
    
    .BRANCH_1
    
    RTS
}

; ==============================================================================

; $064A54-$064A80 LONG ; Coming from Module_TriforceRoom
TriforceRoom_PrepGFXSlotForPoly:
{
    LDA.b #$08 : STA.w $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    JSR $C36F   ; $06436F
    
    LDA.b #$01 : STA.w $1E10 : STA.w $1E11 : STA.w $1E12
    LDA.b #$04 : STA.w $1E18
    LDA.b #$05 : STA.w $1E19
    LDA.b #$06 : STA.w $1E1A
    
    LDA.b #$0F : STA.b $13
    
    INC.b $11
    
    RTL
}

; ==============================================================================

; $064A81-$064AB0 LONG JUMP LOCATION
Credits_InitializePolyhedral:
{
    LDA.b #$08 : STA.w $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    JSR $C36F ; $06436F MAKES SURE THE TRIFORCES ARE SET UP.
    
    STZ.w $1F02
    
    LDA.b #$01 : STA.w $1E10 : STA.w $1E11 : STA.w $1E12
    LDA.b #$07 : STA.w $1E18
    LDA.b #$07 : STA.w $1E19
    LDA.b #$07 : STA.w $1E1A
    
    LDA.b #$0F : STA.b $13
    
    INC.b $11
    
    RTS
}

; ==============================================================================

; $064AB1-$064ABB LONG JUMP LOCATION
AdvancePolyhedral:
{
    PHB : PHK : PLB
    
    JSR $CABC ; $064ABC
    JSR $C412 ; $064412
    
    PLB
    
    RTL
}

; ==============================================================================

; $064ABC-$064AD7 LOCAL JUMP LOCATION
AdvancePolyhedral_do_advance:
{
    LDA.b #$01 : STA.w $012A
                 STA.w $1E02
    
    LDA.w $1F00 : BNE .alpha
        JSR $CAD8 ; $064AD8
        
        LDA.b #$01 : STA.w $1F00
        
        STZ.w $1E02
        
        INC.w $1E0A
    
    .alpha
    
    RTS
}

; ==============================================================================

; $064AD8-$064AE8 LOCAL JUMP LOCATION
AdvancePolyhedral_run_sub:
{
    LDA.w $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $CAE9 ; $064AE9
    dw $CAFE ; $064AFE
    dw $CB1F ; $064B1F
    dw $CB84 ; $064B84
    dw $CBA1 ; $064BA1
}

; ==============================================================================

; $064AE9-$064B1E JUMP LOCATION
IntroPolyhedral_StartUp:
{
    LDA.w $1F02 : SEC : SBC.b #$02 : STA.w $1F02
    
    CMP.b #$02 : BCS .alpha
        STZ.w $1F02
        
        INC.w $1E00
        
        INC.b $B0
    
    .alpha
    
    ; $064AFE ALTERNATE ENTRY POINT
    .MoveGrowRotate
    
    LDA.b $B0 : CMP.b #$0A : BCC .beta
        INC.w $1E00
        
        LDA.b #$05 : STA.w $1E61
    
    .beta
    
    LDA.w $1F05 : CLC : ADC.b #$02 : STA.w $1F05
    
    LDA.w $1F04 : CLC : ADC.b #$01 : STA.w $1F04
    
    RTS
}

; ==============================================================================

; $064B1F-$064B83 JUMP LOCATION
IntroPolyhedral_MoveRotate:
{
    LDA.b #$C0 : STA.w $1E0C
    
    LDA.b #$01 : STA.w $1E0D
    
    LDA.w $1F02 : CMP.b #$80 : BCS .alpha
        ADC.b #$01 : STA.w $1F02
        
        BRA .beta
    
    .alpha
    
    LDA.w $1F05 : SEC : SBC.b #$0A : AND.b #$7F : CMP.b #$5C : BCC .beta
        LDA.w $1F04 : SEC : SBC.b #$0B : CMP.b #$DC : BCC .beta
            STZ.w $1F04
            
            STZ.w $1F05
            
            INC.b $B0
            
            INC.w $1E00
            
            LDA.b #$2C : STA.w $012E
            
            LDA.b #$FF : STA.l $7EC6AE
            
            LDA.b #$7F : STA.l $7EC6AF
            
            INC.b $15
            
            LDA.b #$06 : STA.w $1E01
            
            RTS
    
    .beta
    
    LDA.w $1F05 : CLC : ADC.b #$05 : STA.w $1F05
    
    LDA.w $1F04 : CLC : ADC.b #$03 : STA.w $1F04
    
    RTS
}

; ==============================================================================

; $064B84-$064BA1 JUMP LOCATION
IntroPolyhedral_LockIntoPlace:
{
    DEC.w $1E01
    
    LDA.w $1E01 : BNE .alpha
        LDA.l $0CC433 : STA.l $7EC6AE
        LDA.l $0CC434 : STA.l $7EC6AF
        
        INC.b $15
        
        INC.w $1E00
    
    .alpha
    
    ; $064BA1 ALTERNATE ENTRY POINT
    
    RTS
}

; ==============================================================================

; $064BA2-$064BAF LONG JUMP LOCATION
Credits_AnimateTheTriangles:
{
    PHB : PHK : PLB
    
    INC.w $1E0A
    
    JSR $CBB0 ; $064BB0
    JSR $C412 ; $064412
    
    PLB
    
    RTL
}

; ==============================================================================

; $064BB0-$064BC2 LOCAL JUMP LOCATION
CreditsTriangle_HandleRotation:
{
    LDA.b #$01 : STA.w $012A
    
    LDA.w $1F00 : BNE .BRANCH_ALPHA
        JSR $CBC3 ; $04CBC3
        
        LDA.b #$01 : STA.w $1F00
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $064BC3-$064BD5 LOCAL JUMP LOCATION
CreditsTriangle_ApplyRotation:
{
    LDA.w $1F05 : CLC : ADC.b #$03 : STA.w $1F05
    LDA.w $1F04 : CLC : ADC.b #$01 : STA.w $1F04
    
    RTS
}

; ==============================================================================

; $064BD6-$064BE7 DATA
Pool_InitializeSceneSprite_TriforceRoomTriangle:
{
    ; $064BD6
    .position_x
    dw $004E
    dw $005F
    dw $0072

    ; $064BDC
    .position_y
    dw $009C
    dw $009C
    dw $009C

    ; $064BE2
    .speed_x
    db $FE
    db $00
    db $02

    ; $064BE5
    .speed_y
    db $04
    db $FC
    db $04
}

; $064BE8-$064C12 JUMP LOCATION
InitializeSceneSprite_TriforceRoomTriangle:
{
    TXA : ASL A : TAY
    
    LDA.w $CBD6, Y : STA.w $1E30, X
    LDA.w $CBD7, Y : STA.w $1E38, Y
    LDA.w $CBDC, Y : STA.w $1E48, X
    LDA.w $CBDD, Y : STA.w $1E50, X
    LDA.w $CBE2, X : STA.w $1E58, X
    LDA.w $CBE5, X : STA.w $1E60, X
    
    INC.w $1E10, X
    
    RTS
}

; ==============================================================================

; $064C13-$064C2C JUMP LOCATION
AnimateSceneSprite_TriforceRoomTriangle:
{
    JSR $C82F ; $06482F
    JSR $CA4C ; $064A4C
    JSR $C9F1 ; $0649F1
    
    LDA.w $1E00
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw $CC33 ; = $064C33
    dw $CC56 ; = $064C56
    dw $CC6B ; = $064C6B
    dw $CC8F ; = $064C8F
    dw $CC8F ; = $064C8F
}

; ==============================================================================

; $064C2D-$064C32 DATA
Pool_AnimateTriforceRoomTriangle_Expand:
{
    .speed_x
    db $FF, $00, $01

    .speed_y
    db $FF, $FF, $FF
}

; $064C33-$064C55 JUMP LOCATION
AnimateTriforceRoomTriangle_Expand:
{
    LDA.w $1E0A : AND.b #$07 : BNE .BRANCH_1
        LDA.w $CC2D, X : CLC : ADC.w $1E58, X : STA.w $1E58, X
    
    .BRANCH_1
    
    LDA.w $1E0A : AND.b #$03 : BNE .BRANCH_2
        LDA.w $CC30, X : CLC : ADC.w $1E60, X : STA.w $1E60, X
    
    .BRANCH_2
    
    RTS
}

; ==============================================================================

; $064C56-$064C5C JUMP LOCATION
AnimateTriforceRoomTriangle_RotateInPlace:
{
    STZ.w $1E58, X
    STZ.w $1E60, X
    
    RTS
}

; ==============================================================================

; $064C5D-$064C6A DATA
Pool_AnimateTriforceRoomTriangle_Contract:
{
    ; $064C5D
    .speed_x
    db $FF
    db $FF
    db $FF

    ; $064C60
    .speed_y
    db $01
    db $01
    db $01

    ; $064C63
    .limit_x
    db $EF

    ; $064C64
    .limit_y
    db $11

    ; $064C65
    .target_x
    db $59
    db $5F
    db $67

    ; $064C68
    .target_y
    db $74
    db $68
    db $74
}

; ==============================================================================

; $064C6B-$064C8B JUMP LOCATION
AnimateTriforceRoomTriangle_Contract:
{
    LDA.w $1E0A : AND.b #$03 : BNE .BRANCH_1
        JSR $CCB0 ; $064CB0
    
    .BRANCH_1
    
    LDA.w $CC65, X : CMP.w $1E30, X : BNE .BRANCH_2
        STZ.w $1E58, X
    
    .BRANCH_2
    
    LDA.w $CC68, X : CMP.w $1E48, X : BNE .BRANCH_3
        STZ.w $1E60, X
    
    .BRANCH_3
    
    RTS
}

; ==============================================================================

; $064C8C-$064C8E DATA
Pool_AnimateTriforceRoomTriangle_Stopped:
{
    db $72, $66, $72
}

; ==============================================================================

; $064C8F-$064CAF JUMP LOCATION
AnimateTriforceRoomTriangle_Stopped:
{
    LDA.w $1E0C : ORA.w $1E0D : BNE .BRANCH_1
        LDA.w $CC8C, X : STA.w $1E48, X
        
        RTS
    
    .BRANCH_1
    
    LDA.w $1E0C : SEC : SBC.b #$01 : STA.w $1E0C
    LDA.w $1E0D : SBC.b #$00 : STA.w $1E0D
    
    RTS
}

; ==============================================================================

; $064CB0-$064D0C LOCAL JUMP LOCATION
AnimateTriforceRoomTriangle_HandleContracting:
{
    LDA.w $CC65, X : CMP.w $1E30, X : BCC .BRANCH_1
        LDA.w $CC60, X
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.w $CC5D, X
    
    .BRANCH_2
    
    CLC : ADC.w $1E58, X : STA.w $1E58, X : CMP.w $CC63 : BNE .BRANCH_3
        LDA.w $CC63 : INC A
        
        BRA .BRANCH_4
    
    .BRANCH_3
    
    CMP.w $CC64 : BNE .BRANCH_5
        LDA.w $CC64 : INC A
        
        .BRANCH_4
        
        STA.w $1E58, X
    
    .BRANCH_5
    
    LDA.w $CC68, X : CMP.w $1E48, X : BCC .BRANCH_6
        LDA.w $CC60, X
        
        BRA .BRANCH_7
    
    .BRANCH_6
    
    LDA.w $CC5D, X
    
    .BRANCH_7
    
    CLC : ADC.w $1E60, X : STA.w $1E60, X : CMP.w $CC63 : BNE .BRANCH_8
        LDA.w $CC63 : INC A
        
        BRA .BRANCH_9
    
    .BRANCH_8
    
    CMP.w $CC64 : BNE .BRANCH_10
        LDA.w $CC64 : DEC A
        
        .BRANCH_9
        
        STA.w $1E60, X
    
    .BRANCH_10
    
    RTS
}

; ==============================================================================

; $064D0D-$064D18 DATA
Pool_InitializeSceneSprite_CreditsTriangle:
{
    ; $064D0D
    .position_x
    db $29, $00
    db $5F, $00
    db $97, $00
    
    ; $064D13
    .position_y
    db $70, $00
    db $20, $00
    db $70, $00
}

; $064D19-$064D37 JUMP LOCATION
InitializeSceneSprite_CreditsTriangle:
{
    TXA : ASL A : TAY
    
    LDA.w $CD0D, Y : STA.w $1E30, X
    LDA.w $CD0E, Y : STA.w $1E38, X
    LDA.w $CD13, Y : STA.w $1E48, X
    LDA.w $CD14, Y : STA.w $1E50, X
    
    INC.w $1E10, X
    
    RTS
}

; ==============================================================================

; $064D38-$064D3D DATA
Pool_AnimateSceneSprite_CreditsTriangle:
{
    ; $064D38
    .speed_x
    db -1
    db  0
    db  1

    ; $064D3B
    .speed_y
    db  1
    db -1
    db  1
}

; $064D3E-$064D6F JUMP LOCATION
AnimateSceneSprite_CreditsTriangle:
{
    JSR $C3BD ; $0643BD
    JSR $C82F ; $06482F
    JSR $C9F1 ; $0649F1
    
    LDA.b $11 : CMP.b #$24 : BNE .BRANCH_2
        LDA.w $1E20, X : CMP.b #$50 : BEQ .BRANCH_1
            INC.w $1E20, X
            
            LDA.w $CD38, X : CLC : ADC.w $1E58, X : STA.w $1E58, X
            LDA.w $CD3B, X : CLC : ADC.w $1E60, X : STA.w $1E60, X
        
        .BRANCH_1
        
        RTS
        
    .BRANCH_2
    
    STZ.w $1E20, X
    
    RTS
}

; ==============================================================================

; $064D70-$064D787 DATA
UNREACHABLE_0CCD70:
{
    ; Unused
    dw $0000
    dw $0054
    dw $00A8
    dw $FF8F
}

; $064D78-$064D7C DATA
FileSelect_FairyY:
{
    db $4A, $6A, $8A, $AF, $BF
}

; ==============================================================================

; $064D7D-$0064D9C JUMP LOCATION
Module_SelectFile:
{
    ; Beginning of Module 1, Game Select Screen:
    STZ.b $E4
    STZ.b $E5
    STZ.b $EA
    STZ.b $EB
    
    LDA.b $11 ; Load the submodule index.
    
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
FileSelect_InitializeGFX:
{
    JSL EnableForceBlank ; $00093D
    
    STZ.w $012A
    STZ.w $1F0C
    
    ; Play Fairy fountain theme.
    LDA.b #$0B : STA.w $012C
    
    INC.b $11
    
    LDA.b #$02 : STA.w $0AA9
    
    LDA.b #$06 : STA.w $0AB6 : STA.w $0710
    
    JSL Palette_DungBgMain
    JSL Palette_OverworldBgAux3
    
    LDA.b #$00 : STA.w $0AB2
    
    JSL Palette_Hud ; $0DEE52
    
    STZ.w $0202
    
    LDA.b #$01 : STA.w $0AA4
    LDA.b #$23 : STA.w $0AA1
    LDA.b #$51 : STA.w $0AA2
    
    JSL LoadDefaultGfx
    JSL InitTileSets
    JSL LoadSelectScreenGfx
    JSL Intro_ValidateSram
    JML Intro_LoadSpriteStats
}

; ==============================================================================

; $064DF2-$064E0E JUMP LOCATION
FileSelect_ReInitSaveFlagsAndEraseTriforce:
{
    LDX.b #$05
    
    .zeroLoop
    
    STZ.b $BF, X ; Zero out $BF - $C4.
    
    DEX : BPL .zeroLoop
    
    ; $064DF9 ALTERNATE ENTRY POINT
    .EraseTriforce
    
    LDA.b #$80 : STA.w $0710
    
    JSL EnableForceBlank
    JSL Vram_EraseTilemaps_triforce
    JSL Palette_SelectScreen
    
    INC.b $15
    
    ; Go to the next submodule.
    INC.b $11 
    
    RTL
}

; ==============================================================================

; $064E0F-$064E19 DATA
Pool_FileSelect_UploadLinoleum:
{
    ; $064E0F
    .set0
    db $81, $35, $82, $35

    ; $064E13
    .set1
    db $91, $35, $92, $35

    ; $064E17
    .pointers
    dw .set0
    dw .set1
}

; $064E1B-$064E52 LOCAL JUMP LOCATION
FileSelect_UploadLinoleum:
{
    ; VRAM target is 0x1000 (0x2000 in bytes) aka BG0's tilemap.
    LDA.w #$0010 : STA.w $1002
    
    ; Blitting 0x800 bytes.
    LDA.w #$FF07 : STA.w $1004
    
    STZ.b $00
    
    LDX.w #$0000
    
    .nextValue
    
        ; This will be zero when the loop begins.
        ; Y can end up as 0x00 or 0x02.
        LDA.b $00 : PHA : AND.w #$0020 : LSR #4; TAY; 
        
        ; $064E17, A = 0xCE0F OR 0xCE13
        LDA.w $CE17, Y : STA.b $02
        
        ; A is Odd or Even?
        ; i.e. 0x00 if even or 0x02 if odd.
        PLA : AND.w #$0001 : ASL A : TAY
        
        ; Notice in this function that $00 ranges over 0x0 - 0x3FF.
        ; Addresses written range from $1006 to $1805.
        ; Sets up a complex data table.
        LDA ($02), Y : STA.w $1006, X
        
        INX #2 
        
        INC.b $00
    ; The number of words that will be written.
    LDA.b $00 : CMP.w #$0400 : BNE .nextValue
    
    RTS
}

; ==============================================================================

; $064E53-$064EA4 JUMP LOCATION
FileSelect_UploadFancyBackground:
{
    PHB : PHK : PLB
    
    REP #$30
    
    JSR $CE1B ; $064E1B
    
    LDY.w #$00DE ; Y's usage is an index in what follows (for a loop).
    
    .loop
    
        ; Addresses $1806 - $18E5 are written.
        LDA.w $E1C8, Y : STA.w $1806, Y
        
        ; Notice that X is increasing but has nothing to do with the loop.
        INX #2
    DEY #2 : BPL .loop
    
    LDA.w #$1103 : STA.b $00
    
    ; Index for the following loop.
    LDA.w #$0011 : STA.b $02
    
    .loop2
    
        ; If you've been paying attention, you'd know that X places STA
        ; at $18E6.
        ; Write a series of numbers 0x0311, 0x0331, 0x0351, etc.
        LDA.b $00 : XBA : STA.w $1006, X
        
        ; Write from $18E6-$194D.
        XBA : CLC : ADC.w #$0020 : STA.b $00
        
        INX #2
        
        ; Store fixed numbers after the varying number above.
        LDA.w #$3240 : STA.w $1006, X
        
        INX #2
        
        LDA.w #$347F : STA.w $1006, X
        
        ; All in all 0x66 bytes are written.
        INX #2
    ; We'll loop #$11 times.
    DEC.b $02 : BPL .loop2
    
    SEP #$20 ; Accumulator is now 8-bit.
    
    ; Possibly an ending indicator for this block of data.
    ; Written at $194E.
    LDA.b #$FF : STA.w $1006, X
    
    SEP #$10
    
    INC.b $11 ; Increment the submodule index.
    
    JMP $D09C ; $06509C
}

; ==============================================================================

; $064EA5-$064EB0 JUMP LOCATION
FileSelect_TriggerStripesAndAdvance:
{
    LDA.w $0B9D : STA.b $CB
    
    .alpha
    
    INC.b $11 ; Increment the submodule index.
        
    LDA.b #$06 : STA.b $14
        
    RTL
}

; $064EB1-$064EBC
FileSelect_TriggerNameStripesAndAdvance:
{
    JSR $CEC7 ; $064EC7
        
    LDA.b #$0F : STA.b $13
        
    STZ.w $0710

    BRA FileSelect_TriggerStripesAndAdvance_alpha
}

; ==============================================================================

; $064EBD-$064EC6 JUMP LOCATION
FileSelect_Main:
{
    ; Module 0x01.0x05
    
    PHB : PHK : PLB
    
    JSL.l $0CCEDC ; ($064EDC) Main logic for the select screen.
    JMP $D09C   ; ($06509C) Sets the tile map update flag and exits.
}

; ==============================================================================

; $064EC7-$064EDB LOCAL JUMP LOCATION
FileSelect_SetUpNamesStripes:
{
    PHB : PHK : PLB
    
    REP #$10
    
    LDX.w #$00FD
    
    .BRANCH_1
    
        ; Write from $1001 to $10FE.
        LDA.w $E358, X : STA.w $1001, X
    DEX : BNE .BRANCH_1
    
    SEP #$10
    
    PLB
    
    RTS
}

; ==============================================================================

; $064EDC-$065052 JUMP LOCATION
FileSelect_HandleInput:
{
    ; This routine handles input on the select screen, changing it
    ; appropriately.
    
    ; The menu index on the select screen (0-2 save files,
    ; 3 - copy player, 4 - erase player).
    LDA.b $C8 : CMP.b #$03 : BCS .notSaveFile
        STA.w $0B9D
    
    .notSaveFile
    
    REP #$30
    
    LDX.w #$0000
    
    .nextFile
    
        STX.b $00
        
        ; $048C, X; It holds the SRAM offsets. 
        ; X = #$0, #$500, #$A00
        LDA.l $00848C, X : TAX
        
        ; isValid variable
        ; If the file actually has this written, we do something.
        ; What happens if the file is empty.
        LDA.l $7003E5, X : CMP.w #$55AA : BNE .invalidSaveFile
        
        ; Here we actually have a file to work with.
        ; X = 0x00, 0x02, or 0x04
        ; Write a 1 to each entry of $BF that corresponds to an active file.
        PHX : LDX.b $00 : LDA.w #$0001 : STA.b $BF, X : PLX
        
        LDA.w #$D698 : STA.b $04
        LDA.w #$D699 : STA.b $02
        
        PHX ; Save the SRAM offset.
        
        ; Set OAM for Link's shield and sword (mainly).
        JSR $D6AF ; $0656AF
        
        ; Set number of deaths OAM.
        JSR $D7DB ; $0657DB
        
        PLX ; Restore the SRAM offset.
        
        ; Draw hearts and player's name for this file.
        JSR $D63C ; $06563C
        
        .invalidSaveFile
    ; If there's more files to look at, go back to .BRANCH_2.
    LDX.b $00 : INX #2 : CPX.w #$0006 : BCC .nextFile
    
    SEP #$30
    
    ; Index of the "fairy" cursor 0-4.
    LDX.b $C8
    
    LDA.b #$1C : STA.b $00
    
    ; Tells us what height the "fairy" selector should be at.
    LDA.w $CD78, X : STA.b $01
    
    ; Animates the fairy icon.
    JSR SelectFile_DrawFairy
    
    LDY.b #$02
    
    ; Ignore left and right. See info on $4218, joypad 1.
    ; In this case, no important buttons are down.
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$FC : BEQ .return
    
    AND.b #$2C : BEQ .actionButtonDown
        ; What happens if the down direction was pressed.
        AND.b #$08 : BEQ .dpadDownButton
        
            ; What happens if up or select was pressed.
            LDA.b #$20 : STA.w $012F
            
            DEC.b $C8 : BPL .done
                ; This allows the fairy to wrap around to the bottom.
                LDA.b #$04 : STA.b $C8
                
                BRA .done
        
        .dpadDownButton
        
        LDA.b #$20 : STA.w $012F
        
        INC.b $C8
        
        LDA.b $C8 : CMP.b #$05 : BNE .done
        
        STZ.b $C8 ; Allows the fairy to wrap around to the top.
        
        .done
        
        BRA .return
    
    .actionButtonDown
    
    LDA.b #$2C : STA.w $012E
    
    LDA.b $C8 : CMP.b #$03 : BEQ .gotoCopyMode
        BCS .gotoEraseMode
            ; Otherwise, find out which save slot this is.
            LDA.b $C8 : ASL A : TAX
            
            ; If this save file is empty, go to the naming mode for a new
            ; player.
            LDA.b $BF, X : BEQ .emptyFile
                ; Tells us to cut the music for the moment.
                LDA.b #$F1 : STA.w $012C
                
                ; As to not interfere with the 16 bit value of $C8.
                STZ.b $C9
                
                REP #$20
                
                ;  Obtain the SRAM offset of the save file we chose.
                LDA.l $00848C, X : STA.b $00
                
                ;  A = #$02, #$04, #$06
                ; Indicates in SRAM which save slot was loaded last.
                LDA.b $C8 : ASL A : INC #2 : STA.l $701FFE
                
                SEP #$20
                
                BRL .loadSram ; Why this is a long branch (BRL), I have no idea.
            
            .emptyFile
            
            STZ.b $C9
            
            LDY.b #$04 ; Gives the signal to go to naming mode.
            
            BRA .changeMode
            
    .gotoCopyMode
            
    ; Gives the signal to go to copy mode.
    LDY.b #$02
            
    BRA .checkIfFilesPresent
    
    .gotoEraseMode
    
    ; Gives the signal to go to erase mode.
    LDY.b #$03
    
    .checkIfFilesPresent
    
    ; Checking to see if there are any files actually written...
    LDA.b $BF : ORA.b $C1 : ORA.b $C3 : BNE .filesExist
        ; Since no files exist to be copied / erased, the error noise is played.
        LDA.b #$3C : STA.w $012E
        
        BRA .return
    
    .filesExist
    
    STZ.b $C8
    
    .changeMode
    
    ; Set the next mode to copy, erase, or name mode.
    STY.b $10
    
    ; Reset the submodule indices.
    STZ.b $11 : STZ.b $B0
    
    .return
    
    RTL
    
    ; $064FBB ALTERNATE ENTRY POINT
    .loadSram
    
    ; We end up here if we've selected a game that has data in it already.
    LDX.b #$0F
    
    LDA.b #$00 : STA.l $001AC0, X : STA.l $001AE0, X
    LDA.b #$00 : STA.l $001AB0, X : STA.l $001AD0, X : STA.l $001AF0, X
    
    PHB : LDA.b #$7E : PHA : PLB
    
    REP #$30
    
    ; The SRAM offset based on which save slot you picked.
    LDY.w #$0000 : LDX.b $00
    
    .sramLoadLoop
    
        ; Loads the save file from SRAM into WRAM ($7EF000-$7EF4FF).
        LDA.l $700000, X : STA.w $F000, Y
        LDA.l $700100, X : STA.w $F100, Y
        LDA.l $700200, X : STA.w $F200, Y
        LDA.l $700300, X : STA.w $F300, Y
        LDA.l $700400, X : STA.w $F400, Y
        
        INX #2
    INY #2 : CPY.w #$0100 : BNE .sramLoadLoop
    
    PLB
    
    LDA.w #$0007 : STA.l $7EC00D : STA.l $7EC013
    LDA.w #$0000 : STA.l $7EC00F : STA.l $7EC015
    
    LDA.w #$6040 : STA.w $0219
    LDA.w #$4841 : STA.w $021D
    LDA.w #$007F : STA.w $021F
    LDA.w #$FFFF : STA.w $0221
    
    SEP #$30
    
    LDA.b #$80 : STA.w $0204
    
    ; Send us to module 5.
    LDA.b #$05 : STA.b $10
    
    STZ.b $11 : STZ.w $010E : STZ.w $0710 : STZ.w $0AB2
    
    RTL
}

; ==============================================================================

; $065053-$06506D JUMP LOCATION
Module_CopyFile:
{
    ; Beginning of Module 0x02, Copy Game
    
    STZ.w $0B9D
    
    LDA.b $11
    
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
CopyFile_FindFileIndices:
{
    LDA.b #$07
    
    ; $065070 ALTERNATE ENTRY POINT
    .KILLFile_FindFileIndices
    
    JSR $C52E ; $06452E
    
    LDA.b #$0F : STA.b $13
    
    STZ.w $0710
    
    LDX.b #$FE
    
    .loop
    
        INX #2
    LDA.b $BF, X : BEQ .loop
    
    TXA : LSR A : STA.b $C8
    
    RTL
}

; ==============================================================================

; $065087-$0650B8 JUMP LOCATION
CopyFile_ChooseSelection:
{
    PHB : PHK : PLB
    
    JSR $D13F ; $06513F
    
    LDA.b $11 : CMP.b #$03 : BNE .BRANCH_1
        LDA.b $1A : AND.b #$30 : BNE .BRANCH_1
            JSR $D0C6 ; $0650C6
    
    .BRANCH_1

    ; $06509C ALTERNATE ENTRY POINT
    .FileSelect_TriggerTheStripes
    
    ; Indicates to the NMI routine that the tilemap needs updating.
    LDA.b #$01 : STA.b $14
    
    PLB
    
    RTL
    
    ; $0650A2 ALTERNATE ENTRY POINT
    .CopyFile_ChooseTarget
    
    PHB : PHK : PLB
    
    JSR $D27B ; $06527B
    
    LDA.b $11 : CMP.b #$04 : BNE .BRANCH_2
        LDA.b $1A : AND.b #$30 : BNE .BRANCH_1
            JSR $D0C6 ; $0650C6
    
    .BRANCH_2
    
    BRA .BRANCH_1
}

; ==============================================================================

; $0650B9-$0650C1 JUMP LOCATION
CopyFile_ConfirmSelection:
{
    PHB : PHK : PLB
    
    JSR $D371 ; $065371
    JMP $D09C ; $06509C
}

; ==============================================================================

; $0650C2-$0650C5 DATA
Pool_FilePicker_DeleteHeaderStripe:
{
    .offsets
    dw $0004
    dw $001E
}

; $0650C6-$0650E5 LOCAL JUMP LOCATION
FilePicker_DeleteHeaderStripe:
{
    REP #$30
    
    LDX.w #$0002
    LDA.w #$00A9
    
    .BRANCH_1
    
        LDY.w #$000B : STY.b $00
        
        LDY.w $D0C2, X
        
        .BRANCH_2
        
            STA.w $1002, Y
            
            INY #2
        DEC.b $00 : BNE .BRANCH_2
    DEX #2 : BPL .BRANCH_1
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0650E6-$0650E9 DATA
CopyFile_FairyIndent:
{
    db $24 ; File 1
    db $24 ; File 2
    db $24 ; File 3
    db $1C ; Exit
}

; $0650EA-$0650ED DATA
CopyFile_FairyHeight:
{
    db $57
    db $6F
    db $87
    db $BF
}

; $0650EE-$065136 DATA
CopyFile_CopyToMenuStripe:
{
    dw $6761, $0E40 ; VRAM $C2CE | 16 bytes | Fixed horizontal
    dw $00A9

    dw $8761, $0E40 ; VRAM $C30E | 16 bytes | Fixed horizontal
    dw $00A9

    dw $C761, $0E40 ; VRAM $C38E | 16 bytes | Fixed horizontal
    dw $00A9

    dw $E761, $0E40 ; VRAM $C3CE | 16 bytes | Fixed horizontal
    dw $00A9

    dw $3011, $0100 ; VRAM $2260 | 2 bytes | Horizontal
    dw $3583

    dw $3111, $1440 ; VRAM $2262 | 22 bytes | Fixed horizontal
    dw $3585

    dw $3C11, $0100 ; VRAM $2278 | 2 bytes | Horizontal
    dw $3584

    dw $5011, $0EC0 ; VRAM $22A0 | 16 bytes | Fixed vertical
    dw $3586

    dw $5C11, $0EC0 ; VRAM $22B8 | 16 bytes | Fixed vertical
    dw $3596

    dw $5012, $0100 ; VRAM $24A0 | 2 bytes | Horizontal
    dw $3593

    dw $5112, $1440 ; VRAM $24A2 | 22 bytes | Fixed horizontal
    dw $3595

    dw $5C12, $0100 ; VRAM $24B8 | 2 bytes | Horizontal
    dw $3594

    db $FF ; end of stripes data
}

; $065137-$065138 DATA
CopyFile_TargetStripeOffsetAdjuster:
{
    db $00 ; File 1
    db $0C ; File 2
}

; $065139-$06513E DATA
CopyFile_NameStripeBufferOffset:
{
    dw $003C ; File 1
    dw $0064 ; File 2
    dw $008C ; File 3
}

; ==============================================================================

; $06513F-$065239 LOCAL JUMP LOCATION
CopyFile_SelectionAndBlinker:
{
    REP #$10
    
    LDX.w #$00AC : STX.w $1000
    
    .BRANCH_1
    
        LDA.w $E68D, X : STA.w $1002, X
    DEX : BPL .BRANCH_1
    
    REP #$20
    
    LDX.w #$0000
    
    .BRANCH_2
    
        STX.b $00
        
        LDA.b $BF, X : AND.w #$0001 : BEQ .BRANCH_4
            LDA.l $00848C, X
            
            TXY
            
            TAX
            
            LDA.w $D139, Y : TAY
            
            LDA.w #$0006 : STA.b $02
            
            .BRANCH_3
            
                LDA.l $7003D9, X : CLC : ADC.w #$1800 : STA.w $1002, Y
                                   CLC : ADC.w #$0010 : STA.w $1016, Y
                
                INX #2
                
                INY #2
            DEC.b $02 : BNE .BRANCH_3
        
        .BRANCH_4
    LDX.b $00 : INX #2 : CPX.w #$0006 : BCC .BRANCH_2
    
    SEP #$30
    
    LDX.b $C8
    
    LDA.w $D0E6, X : STA.b $00
    LDA.w $D0EA, X : STA.b $01
    
    JSR SelectFile_DrawFairy
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$FC : BNE .BRANCH_5
        BRL .BRANCH_17
    
    .BRANCH_5
    
    AND.b #$2C : BEQ .BRANCH_12
        AND.b #$08 : BEQ .BRANCH_8
            LDX.b $C8 : DEX : BPL .BRANCH_7
                .BRANCH_6
                
                    TXA : ASL A : TAY
                    
                    LDA.w $00BF, Y : BNE .BRANCH_11
                DEX : BPL .BRANCH_6
            
            .BRANCH_7
            
            LDX.b #$03
            
            BRA .BRANCH_11
        
        .BRANCH_8
        
        LDX.b $C8 : INX : CPX.b #$03 : BCS .BRANCH_10
            .BRANCH_9
            
            TXA : ASL A : TAY
            
            LDA.w $00BF, Y : BNE .BRANCH_11
                INX : CPX.b #$03 : BNE .BRANCH_9
                    BRA .BRANCH_11
        
        .BRANCH_10
        
        CPX.b #$04 : BNE .BRANCH_11
            LDX.b #$00
            
            BRA .BRANCH_9
        
        .BRANCH_11
        
        LDA.b #$20 : STA.w $012F
        
        STX.b $C8
        
        BRA .BRANCH_17
    
    .BRANCH_12
    
    ; Presumably record that the result was 0x2C.
    LDA.b #$2C : STA.w $012E
    
    ; $C8 Indexes your selection so far.
    ; i.e. They chose the quit option. #$0-2 are the save games.
    LDA.b $C8 : CPX.b #$03 : BEQ .BRANCH_15
    
        ; So if they didn't choose to quit... they must have chosen a game
        ; to copy.
        ASL A : STA.b $CC
        
        ; So use the menu index shifted left ( $C8 * 2 -> $CC).
        STZ.b $CD
        
        LDX.b #$49
        
        .BRANCH_13
        
            ; $0650ED
            LDA.w $D0ED, X : STA.w $1035, X
        DEX : BNE .BRANCH_13
        
        ; Tell me what menu item they really picked...
        LDX.b $C8 : CPX.b #$02 : BEQ .BRANCH_14
            ; If not, then look up a value...
            LDA.w $D137, X : TAX
            
            LDA.b #$6C : STA.w $1036, X : STA.w $103C, X
            
            LDA.b #$27 : STA.w $1037, X : CLC : ADC.b #$20 : STA.w $103D, X
        
        .BRANCH_14
        
        INC.b $11
        
        BRA .BRANCH_16
    ; $06522D ALTERNATE ENTRY POINT
    .BRANCH_15
    
    ; This means the mode will change to select screen mode.
    LDA.b #$01 : STA.b $10
    ; And the submodule will be the second (#$01) one.
    LDA.b #$01 : STA.b $11
    
    STZ.b $B0 ; Reset the sub-index of the submodule as well.
    
    .BRANCH_16
    
    STZ.b $C8 ; Reset the menu marker too.
    
    .BRANCH_17
    
    RTS
}

; ==============================================================================

; $06527B-$06536E LOCAL JUMP LOCATION
CopyFile_TargetSelectionAndBlink:
{
    LDA.b #$04
    LDX.b #$01
    
    .BRANCH_1
    
        CMP.b $CC : BNE .BRANCH_2
            STA.b $CA, X : DEX
        
        .BRANCH_2
    DEC A : DEC A : BPL .BRANCH_1
    
    REP #$10
    
    LDX.w #$0084 : STX.b $0E
    
    .BRANCH_3
    
        LDA.w $E73A, X : STA.w $1002, X
    DEX : BPL .BRANCH_3
    
    REP #$20
    
    LDX.w #$0000 : STX.b $04
    
    .BRANCH_4
    
        STX.b $00 : CPX.b $CC : BEQ .BRANCH_6
            LDY.b $04 : LDA.w $D271, Y : TAY
            
            INC.b $04 : INC.b $04
            
            LDA.w $D275, X  : STA.w $1002, Y
            CLC : ADC.w #$0010 : STA.w $1016, Y
            
            LDA.b $BF, X : BEQ .BRANCH_6
                LDA.w #$0006 : STA.b $02
                
                LDA.l $00848C, X : TAX
                
                .BRANCH_5
                
                    LDA.l $7003D9, X : CLC : ADC.w #$1800 : STA.w $1006, Y
                    
                    CLC : ADC.w #$0010 : STA.w $101A, Y
                    
                    INX #2
                    
                    INY #2
                DEC.b $02 : BNE .BRANCH_5
        
        .BRANCH_6
    LDX.b $00 : INX #2 : CPX.w #$0006 : BCC .BRANCH_4
    
    LDX.b $0E : STX.w $1000
    
    SEP #$30
    
    LDX.b $C8 : LDA.w $D26B, X : STA.b $00
    
    LDA.w $D26E, X : STA.b $01
    
    JSR SelectFile_DrawFairy
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4
    
    AND.b #$FC : BEQ .BRANCH_14
        AND.b #$2C : BEQ .BRANCH_9
            AND.b #$08 : BEQ .BRANCH_7
                LDX.b $C8 : DEX : BPL .BRANCH_8
                    LDX.b #$02
                
                    BRA .BRANCH_8
            
            .BRANCH_7
            
            LDX.b $C8 : INX : CPX.b #$03 : BCC .BRANCH_8
                LDX.b #$00
            
            .BRANCH_8
            
            LDA.b #$20 : STA.w $012F : STX.b $C8
        
        BRA .BRANCH_14
    
        .BRANCH_9
        
        LDA.b #$2C : STA.w $012E
        
        LDX.b $C8 : CPX.b #$02 : BEQ .BRANCH_12
            LDA.b $CA, X : STA.b $CA : STZ.b $CB
            
            LDX.b #$30
            
            .BRANCH_10
            
                ; Write out "copy ok?".
                LDA.w $D23A, X : STA.w $1036, X
            DEX : BPL .BRANCH_10
            
            LDA.b $C8 : BNE .BRANCH_11
                LDA.b #$62 : STA.w $1036 : STA.w $103C
                
                LDA.b #$14  : STA.w $1037
                CLC : ADC.b #$20 : STA.w $103D
            
            .BRANCH_11
            
            INC.b $11
            
            BRA .BRANCH_13
        
        .BRANCH_12
        
        JSR $D22D ; $06522D
        
        .BRANCH_13
        
        STZ.b $C8
    
    .BRANCH_14
    
    RTS
}

; ==============================================================================

; $06536F-$065370 DATA
Pool_CopyFile_HandleConfirmation:
{
    .fairy_y
    db $AF ; Yes
    db $BF ; No
}

; $065371-$0653DB LOCAL JUMP LOCATION
CopyFile_HandleConfirmation:
{
    LDX.b $C8
    
    LDA.b #$1C   : STA.b $00
    LDA.w $D36F, X : STA.b $01
    
    JSR SelectFile_DrawFairy
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4
    
    AND.b #$FC : BEQ .BRANCH_4
        AND.b #$2C : BEQ .BRANCH_2
            AND.b #$24 : BEQ .BRANCH_1
                LDA.b #$20 : STA.w $012F
                
                INC.b $C8
                
                LDA.b $C8 : CMP.b #$02 : BCC .BRANCH_4
                    STZ.b $C8
                
                BRA .BRANCH_4
            
            .BRANCH_1
            
            LDA.b #$20 : STA.w $012F
            
            DEC.b $C8 : BPL .BRANCH_4
                LDA.b #$01 : STA.b $C8
            
                BRA .BRANCH_4
        
        .BRANCH_2
        
        LDA.b #$2C : STA.w $012E
        
        LDA.b $C8 : BNE .BRANCH_3
            REP #$30
            
            LDX.b $CA : LDA.l $00848C, X : TAY
            LDX.b $CC : LDA.l $00848C, X : TAX
            
            JSR $D3DC ; $0653DC
            
            LDX.b $CA
            
            LDA.w #$0001 : STA.b $BF, X
            
            SEP #$30
        
        .BRANCH_3
        
        JSR $D22D ; $06522D
        
        STZ.b $C8
    
    .BRANCH_4
    
    RTS
}

; ==============================================================================

; $0653DC-$065415 LOCAL JUMP LOCATION
CopyFile_CopyData:
{
    SEP #$20
    
    ; Set data bank register to 0x70 (SRAM).
    PHB : LDA.b #$70 : PHA : PLB
    
    REP #$20
    
    LDA.w #$0080 : STA.b $00
    
    .BRANCH_1
    
        LDA.w $0000, X : STA.w $0000, Y
        LDA.w $0001, X : STA.w $0001, Y
        LDA.w $0002, X : STA.w $0002, Y
        LDA.w $0003, X : STA.w $0003, Y
        LDA.w $0004, X : STA.w $0004, Y
        
        INX #2
        
        INY #2
    DEC.b $00 : BNE .BRANCH_1
    
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
    
    LDA.b $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl $0CCDF9 ; = $064DF9
    dl $0CCE53 ; = $064E53
    dl $0CD49A ; = $06549A
    dl $0CD49F ; = $06549F
    dl $0CD4B1 ; = $0654B1
}

; $06549A-$06549E JUMP LOCATION
KILLFile_SetUp:
{
    LDA.b #$08
    
    JMP $D070 ; $065070
}

; $06549F-$0654B0 JUMP LOCATION
KILLFile_HandleSelection:
{
    PHB : PHK : PLB
    
    LDA.b $C8 : CMP.b #$03 : BCS .alpha
    
    STA.w $0B9D
    
    .alpha
    
    JSR $D4BA ; $0654BA
    JMP $D09C ; $06509C
}

; ==============================================================================

; $0654B1-$0654B9 JUMP LOCATION
KILLFile_HandleConfirmation:
{
    PHB : PHK : PLB
    
    JSR $D599 ; $065599
    JMP $D09C ; $06509C
}

; ==============================================================================

; $0654BA-$065596 LOCAL JUMP LOCATION
KILLFile_ChooseTarget:
{
    REP #$10
    
    LDX.w #$00FD
    
    .BRANCH_1
    
        LDA.w $E53E, X : STA.w $1001, X
    DEX : BNE .BRANCH_1
    
    REP #$20
    
    LDX.w #$0000
    
    .BRANCH_2
    
        STX.b $00
        
        LDA.b $BF, X : AND.w #$0001 : BEQ .BRANCH_3
            LDA.l $00848C, X : TAX
            
            JSR $D63C ; $6563C
        
        .BRANCH_3
    LDX.b $00 : INX #2 : CPX.w #$0006 : BCC .BRANCH_2
    
    SEP #$30
    
    LDX.b $C8
    
    LDA.w $D416, X : STA.b $00
    LDA.w $D41A, X : STA.b $01
    
    JSR SelectFile_DrawFairy
    
    LDY.b #$02
    
    LDA.b $F4 : AND.b #$20 : BNE .BRANCH_6
        LDA.b $F4
        
        AND.b #$0C : BEQ .BRANCH_9
            AND.b #$04 : BNE .BRANCH_6
                LDA.b #$20 : STA.w $012F
                
                LDY.b #$FE
                
                LDX.b $C8 : DEX : BMI .BRANCH_5
                    .BRANCH_4
                    
                        TXA : ASL A : TAY
                        
                        LDA.w $00BF, Y : BNE .BRANCH_9
                    DEX : BPL .BRANCH_4
                
                .BRANCH_5
                
                LDX.b #$03
                
                BRA .BRANCH_9
    
    .BRANCH_6
    
    LDA.b #$20 : STA.w $012F
    
    LDX.b $C8 : INX : CPX.b #$03 : BCS .BRANCH_8
        .BRANCH_7
        
            TXA : ASL A : TAY
            
            LDA.w $00BF, Y : BNE .BRANCH_9
        INX : CPX.b #$03 : BNE .BRANCH_7

        BRA .BRANCH_9
    
    .BRANCH_8
    
    CPX.b #$04 : BNE .BRANCH_9
        LDX.b #$00
        
        BRA .BRANCH_7
    
    .BRANCH_9
    
    STX.b $C8
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ .BRANCH_13
        LDA.b #$2C : STA.w $012E
        
        LDA.b $C8 : CMP.b #$03 : BEQ .BRANCH_12
            LDX.b #$64
            
            .BRANCH_10
            
            LDA.w $D41E, X : STA.w $1002, X
            
            DEX : BPL .BRANCH_10
            
            INC.b $11
            
            LDX.b $C8 : CPX.b #$02 : BEQ .BRANCH_11
                LDA.w $D483, X : TAX
                
                LDA.b #$62 : STA.w $1002, X : STA.w $1008, X
                
                LDA.b #$67  : STA.w $1003, X
                CLC : ADC.b #$20 : STA.w $1009, X
            
            .BRANCH_11
            
            LDA.b $C8 : STA.b $B0
            
            STZ.b $C8
            
            BRA .BRANCH_13
        
        .BRANCH_12
        
        SEP #$30
        
        JSR $D22D ; $06522D
    
    .BRANCH_13
    
    RTS
}

; ==============================================================================

; $065597-$065598 DATA
Pool_KILLFile_VerifyDeletion:
{
    .fairy_pos_y
    db $AF, $BF
}

; ==============================================================================

; $065599-$06562F LOCAL JUMP LOCATION
KILLFile_VerifyDeletion:
{
    LDA.b $B0 : ASL A : STA.b $00
    
    REP #$30
    
    LDX.b $C8
    
    LDA.b #$1C : STA.b $00
    
    LDA .fairy_pos_y, X : STA.b $01
    
    JSR SelectFile_DrawFairy
    
    LDY.b #$02
    
    LDA.b $F4 : AND.b #$2C : BEQ .BRANCH_3
        AND.b #$24 : BNE .BRANCH_1
            DEX
            
            BRA .BRANCH_2
        
        .BRANCH_1
        
        INX
        
        .BRANCH_2
        
        TXA : AND.b #$01 : STA.b $C8
        
        LDA.b #$20 : STA.w $012F
    
    .BRANCH_3
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ .BRANCH_6
        AND.b #$2C : STA.w $012E
        
        LDA.b $C8 : BNE .BRANCH_5
            LDA.b #$22 : STA.w $012F
            
            STZ.w $012E
            
            REP #$30
            
            LDA.b $B0 : AND.w #$00FF : ASL A : TAX
            
            STZ.b $BF, X
            
            LDA.l $00848C, X : TAX
            
            LDY.w #$0000 : TYA
            
            .BRANCH_4
            
                STA.l $700000, X : STA.l $700100, X
                STA.l $700200, X : STA.l $700300, X
                STA.l $700400, X : STA.l $700F00, X
                STA.l $701000, X : STA.l $701100, X
                STA.l $701200, X : STA.l $701300, X
                
                INX #2
            INY #2 : CPY.w #$0100 : BNE .BRANCH_4
            
            SEP #$30
        
        .BRANCH_5
        
        JSR $D22D ; $06522D
        
        STZ.b $B0
    
    .BRANCH_6
    
    RTS
}

; ==============================================================================

; $06563C-$065694 LOCAL JUMP LOCATION
FileSelect_CopyNameToStripes:
{
    ; Draws both the Player's name and the hearts of that player to screen.
    
    PHX
    
    ; Sets the position in the tilemap buffer to draw to.
    LDY.b $00 : LDA.w $D630, Y : TAY
    
    LDA.w #$0006 : STA.b $02
    
    .nextLetter
    
        LDA.l $7003D9, X : CLC : ADC.w #$1800 : STA.w $1002, Y
        
        CLC : ADC.w #$0010 : STA.w $102C, Y
        
        INX #2
        
        INY #2
    DEC.b $02 :BNE .nextLetter
    
    PLX
    
    LDY.w #$0001 : LDA.l $70036C, X : AND.w #$00FF : LSR #3 : STA.b $02
    
    LDX.b $00 : LDY.w $D636, X : STY.b $04
    
    LDA.w #$0520 : LDX.w #$000A
    
    .nextHeart
    
        STA.w $1002, Y
        
        INY #2 : DEX : BNE .BRANCH_3
            PHA
            
            LDA.b $04 : CLC : ADC.w #$002A : TAY
            
            PLA
        
        .BRANCH_3
    DEC.b $02 : BNE .nextHeart
    
    RTS
}

; $065695-$0656AE DATA TABLE
Pool_FileSelect_DrawLink:
{
    ; $065695
    .unused
    db $01, $06, $0B

    ; $065698
    .offset_y
    db $34 ; IDK
    db $43 ; file 1
    db $63 ; file 2
    db $83 ; file 3

    ; $06569C
    .oam_offset
    db $28 ; file 1
    db $3C ; file 2
    db $50 ; file 3

    ; $06569F
    .sword_gfx
    db $85 ; fighter sword
    db $A1 ; master sword
    db $A1 ; tempered sword
    db $A1 ; gold sword

    ; $0656A3
    .shield_gfx
    db $C4 ; fighter shield
    db $CA ; fire shield
    db $E0 ; mirror shield

    ; $0656A6
    .sword_props
    db $72 ; file 1
    db $76 ; file 2
    db $7A ; file 3

    ; $0656A9
    .shield_props
    db $32 ; file 1
    db $36 ; file 2
    db $3A ; file 3

    ; $0656AC
    .link_props
    db $30 ; file 1
    db $34 ; file 2
    db $38 ; file 3
}

; ==============================================================================

; $0656AF-$0657A2 LOCAL JUMP LOCATION
FileSelect_DrawLink:
{
    REP #$30
    
    LDA.w #$0116 : ASL A : STA.w $0100
    
    ; A = 0, 2, 4, or 6.
    LDA.b $00 : AND.w #$00FF : TAX
    
    ; Get that SRAM offset again, Mirror it at $0E.
    LDA.l $00848C, X : STA.b $0E
    
    SEP #$30
    
    ; A = 0, 1, 2, or 3.
    LDA.b $00 : LSR A : TAY
    
    ; $06569C that is. A -> #$28, #$3C, #$50 in Decimal 40, 60, 80.
    LDA.w $D69C, Y : TAX
    
    ; $D698 -> $65698 #$34 = 52
    ; A -> #$40 = 64
    ; Mirror to this location.
    LDA ($04) : CLC : ADC.b #$0C : STA.w $0800, X : STA.w $0804, X
    
    ; i.e. from $D699, Y; A = 0x43, 0x63, or 0x83
    ; A = 0x3E, 0x5E, or 0x7E
    LDA ($02), Y : CLC : ADC.b #$FB : STA.w $0801, X
    
    ; The last add obviously overflowed, so clc
    ; A -> 0x46, 0x66, or 0x86
    CLC : ADC.b #$08 : STA.w $0805, X
    
    ; A -> #$72, #$76, #$7A
    LDA.w $D6A6, Y : STA.w $0803, X : STA.w $0807, X
    
    PHY : PHX 
    
    REP #$10
    
    ; Retrieve the SRAM offset.
    LDX.b $0E
    
    ; Give me the sword value.
    LDA.l $700359, X
    
    SEP #$10
    
    PLX ; X -> #$28, #$3C, #$50
    
    ; Y -> #$0, #$1, #$2, #$3, #$4
    TAY : DEY : BPL .hasSword
        ; We'll end up here if Link doesn't have a sword.
        ; Apparently 0xF0 disables these sprites?
        LDA.b #$F0 : STA.w $0801, X : STA.w $0805, X
        
        ; So yeah, we want that 0 back from the 0xFF it was.
        INY
    
    .hasSword
    
    ; A -> #$85, #$A1, #$A1, #$A1 (#$85 is for the fighter sword shape).
    ; I guess this is where the sprite data for the sword is kept.
    LDA.w $D69F, Y : STA.w $0802, X
    
    ; Adding 0x10 gives you the lower part of the sword. (0x95 or 0xB1)
    ; So this is also tile data apparently.
    CLC : ADC.b #$10 : STA.w $0806, X
    
    ; Y -> #$0, #$1, #$2, #$3
    PLY
    
    ; 0x28, 0x3C, or 0x50 -> Stack
    ; X -> 0x0A, 0x0F, or 0x14 (10,15,20)
    ; A -> 0x28, 0x3C, or 0x50
    PHX : TXA : LSR #2 : TAX
    
    LDA.w #$00 : STA.w $0A20, X : STA.w $0A21, X
    
    ; A -> 0x28, 0x3C, or 0x50
    ; A -> 0x30, 0x44, or 0x58
    PLA : CLC : ADC.b #$08 : TAX
    
    ; $065698 A -> #$34
    ; A -> 0x2F
    ; Controls the position of the shield on the select screen.
    LDA ($04) : CLC : ADC.b #$FB : STA.w $0800, X
    
    ; Controls the display of the shield on the select screen.
    LDA ($02), Y : CLC : ADC.b #$0A : STA.w $0801, X
    
    ; A -> #$32, #$36, #$3A
    LDA.w $D6A9, Y : STA.w $0803, X
    
    PHY : PHX
    
    REP #$10
    
    ; X -> SRAM offset
    LDX.b $0E
    
    ; Load what shield Link has.
    LDA.l $70035A, X
    
    SEP #$10
    
    PLX
    
    TAY : DEY : BPL .hasShield
        ; If Link doesn't have a shield, don't draw one (-> #$F0).
        LDA.b #$F0 : STA.w $0801, X
        
        ; Put it back to zero like it should be.
        INY
    
    .hasShield
    
    ; Tells us which graphic to use for the shield.
    LDA.w $D6A3, Y : STA.w $0802, X
    
    ; We're back to Y = 0x0, 0x1, or 0x2.
    PLY
    
    PHX
    
    TXA : LSR #2 : TAX
    
    LDA.b #$02 : STA.w $0A20, X
    
    PLA : CLC : ADC.b #$04 : TAX
    
    LDA ($04) : STA.w $0800, X : STA.w $0804, X
    
    LDA.b #$00 : STA.w $0802, X
    LDA.b #$02 : STA.w $0806, X
    
    LDA.w $D6AC, Y : STA.w $0803, X
    ORA.b #$40  : STA.w $0807, X
    
    LDA ($02), Y : STA.w $0801, X
    CLC : ADC.b #$08 : STA.w $0805, X
    
    TXA : LSR #2 : TAX
    
    LDA.b #$02 : STA.w $0A20, X : STA.w $0A21, X
    
    REP #$30
    
    RTS
}

; ==============================================================================

; $0657A3-$0657A4 DATA
Pool_SelectFile_DrawFairy:
{
    .chr
    db $A8, $AA
}

; ==============================================================================

; $0657A5-$0657CA LOCAL JUMP LOCATION
SelectFile_DrawFairy:
{
    ; This routine animates the fairy on the select screen.
    
    LDA.b $00 : STA.w $0800
    LDA.b $01 : STA.w $0801
    
    PHX
    
    LDX.b #$00
    
    ; Alternate 8 frames one way, 8 frames another.
    LDA.b $1A : AND.b #$08 : BEQ .set_chr
        INX
    
    .set_chr
    
    LDA .chr, X : STA.w $0802
    
    PLX
    
    LDA.b #$7E : STA.w $0803
    
    LDA.b #$02 : STA.w $0A20
    
    RTS
}

; ==============================================================================

; $0657DB-$065889 LOCAL JUMP LOCATION
FileSelect_DrawDeaths:
{
    !onesDigit     = $02
    !tensDigit     = $04
    !hundredsDigit = $06
    
    REP #$30
    
    LDA.b $02 : PHA : STA.b $08
    LDA.b $04 : PHA : STA.b $0A
    
    ; Check the death counter (which is set to 0xFFFF until you beat the game).
    LDX.b $0E : LDA.l $700405, X : CMP.w #$FFFF : BNE .gameBeaten
        JMP .return ; $065883
    
    .gameBeaten
    
    CMP.w #$03E8 : BCC .lessThan1000 ; Less than a thousand.
        ; The number of deaths maxes out at 999, so we just set the digits to all 9s.
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
    
    ; Y contains number of deaths divided by 10.
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
    
    LDA.b $00 : LSR A : TAY
    
    LDA.w $D7D5, Y : TAY
    
    .nextDigit
    
        PHX
        
        LDA.b $02, X : TAX
        
        ; Set the sprite CHR based on the digit value.
        LDA.w $D7CB, X : STA.w $0802, Y
        
        PHY
        
        LDA.b $00 : LSR A : TAY
        
        LDA ($08), Y : CLC : ADC.w #$7A10 : STA.w $0801, Y
        
        PLA : PHA : LSR A : TAX
        
        LDA ($0A) : CLC : ADC.w $D7D8, X : STA.w $0800, Y
        LDA.b #$3C : STA.w $0803, Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$00 : STA.w $0A20, Y
        
        PLY : INY #4
    PLX : DEX #2 : BPL .nextDigit
    
    REP #$30
    
    .return
    
    PLA : STA.b $04
    PLA : STA.b $02
    
    RTS
}

; ==============================================================================

; $06588A-$06589B JUMP LOCATION
Module_NamePlayer:
{
    ; Beginning of Module 0x04 - Name Player
    
    LDA.b $11
    
    JSL UseImplicitRegIndexedLongJumpTable
    
    dl $0CD89C ; = $06589C
    dl $0CD911 ; = $065911
    dl $0CD928 ; = $065928
    dl $0CDA4D ; = $065A4D
}

; ==============================================================================

; $06589C-$065910 JUMP LOCATION
NameFile_EraseSave:
{
    JSL.l $0CCDF9 ; $064DF9
    
    LDA.b #$01 : STA.w $0128
    
    STZ.w $0B10
    STZ.w $0B12
    STZ.w $0B15
    STZ.w $00CA
    STZ.w $00CC
    
    LDA.b #$83 : STA.w $0B11
    
    REP #$30
    
    LDA.w #$01F0 : STA.w $0630
    
    STZ.b $E4
    
    ; Remember $C8 is an index into what menu choice was selected.
    ; Hence, this tells us which save slot was picked.
    LDA.b $C8 : ASL A : TAX
    
    ; Offsets for each of the save slots. #$0, #$500, #$A00, #$F00 for mirrors.
    ; $200 will hold the offset, And it will be the index in SRAM for the
    ; following loop.
    LDA.l $00848C, X : STA.w $0200 : TAX
    
    ; We're going to be putting zeroes in SRAM.
    LDY.w #$0000 : TYA
    
    .zeroLoop
    
        STA.l $700000, X ; In effect what this does is zero out the save file
        STA.l $700100, X ; before adding anything into it.
        STA.l $700200, X
        STA.l $700300, X
        STA.l $700400, X
        
        INX #2
    INY #2 : CPY.w #$0100 : BNE .zeroLoop
    
    ; Here that offset pops up again.
    LDX.w $0200
    
    LDA.w #$00A9
    
    STA.l $7003D9, X ; These are the naming spots.
    STA.l $7003DB, X ; Note that they are being filled with 0xA9.
    STA.l $7003DD, X ; If you can get a hold of my SRAM faq, you'd know
    STA.l $7003DF, X ; that 0xA9 is interpreted as a blank character.
    STA.l $7003E1, X
    STA.l $7003E3, X
    
    SEP #$30
    
    RTL
}

; $065911-$065927 JUMP LOCATION
NameFile_FillBackground:
{
    PHB : PHK : PLB
    
    REP #$30
    
    JSR $CE1B ; $064E1B
    
    LDA.w #$FFFF : STA.w $1006, X
    
    SEP #$30
    
    PLB
    
    LDA.b #$01
    
    JSR $C52E ; $06452E
    
    RTL
}

; $065928-$065934 JUMP LOCATION
NameFile_MakeScreenVisible:
{
    LDA.b #$05
    
    JSR $C52E ; $06452E
    
    LDA.b #$0F : STA.b $13
    
    STZ.w $0710
    
    RTL
}

; $065935-$065A4C DATA
Pool_NameFile:
{
    ; $065935
    .CharacterLayout:
    #_0CD935: db $06, $07, $5F, $09, $59, $59, $1A, $1B
    #_0CD93D: db $1C, $1D, $1E, $1F, $20, $21, $60, $23
    #_0CD945: db $59, $59, $76, $77, $78, $79, $7A, $59
    #_0CD94D: db $59, $59, $00, $01, $02, $03, $04, $05
    #_0CD955: db $10, $11, $12, $13, $59, $59, $24, $5F
    #_0CD95D: db $26, $27, $28, $29, $2A, $2B, $2C, $2D
    #_0CD965: db $59, $59, $7B, $7C, $7D, $7E, $7F, $59
    #_0CD96D: db $59, $59, $0A, $0B, $0C, $0D, $0E, $0F
    #_0CD975: db $40, $41, $42, $59, $59, $59, $2E, $2F
    #_0CD97D: db $30, $31, $32, $33, $40, $41, $42, $59
    #_0CD985: db $59, $59, $61, $3F, $45, $46, $59, $59
    #_0CD98D: db $59, $59, $14, $15, $16, $17, $18, $19
    #_0CD995: db $44, $59, $6F, $6F, $59, $59, $59, $59
    #_0CD99D: db $59, $59, $59, $5A, $44, $59, $6F, $6F
    #_0CD9A5: db $59, $59, $5A, $44, $59, $6F, $6F, $59
    #_0CD9AD: db $59, $59, $59, $59, $59, $59, $59, $5A


    ; $0659B5
    .CursorPositionX:
    #_0CD9B5: dw $01F0, $0000, $0010, $0020
    #_0CD9BD: dw $0030, $0040, $0050, $0060
    #_0CD9C5: dw $0070, $0080, $0090, $00A0
    #_0CD9CD: dw $00B0, $00C0, $00D0, $00E0
    #_0CD9D5: dw $00F0, $0100, $0110, $0120
    #_0CD9DD: dw $0130, $0140, $0150, $0160
    #_0CD9E5: dw $0170, $0180, $0190, $01A0
    #_0CD9ED: dw $01B0, $01C0, $01D0, $01E0

    ; $0659F5
    .CursorIndexMovementX:
    #_0CD9F5: dw $0001 ; Right
    #_0CD9F7: dw $00FF ; Left

    ; $0659F9
    .CursorIndexBoundaryX:
    #_0CD9F9: dw $0020 ; Right
    #_0CD9FB: dw $00FF ; Left

    ; $0659FD
    .CursorIndexWrapX:
    #_0CD9FD: dw $0000 ; Right
    #_0CD9FF: dw $001F ; Left

    ; $065A01
    .CursorPositionY:
    #_0CDA01: db $83, $93, $A3, $B3

    ; $065A05
    .CursorIndexMovementY:
    #_0CDA05: db $01, $FF

    ; $065A07
    .CursorIndexBoundaryY:
    #_0CDA07: db $04, $FF

    ; $065A09
    .CursorStickY:
    #_0CDA09: db $00, $03

    ; $065A0B
    .YtoXIndexOffset:
    #_0CDA0B: dw $0000, $0020, $0040, $0060


    ; $065A13
    .HeartXPosition:
    #_0CDA13: db $1F, $2F, $3F, $4F, $5F, $6F

    ; $065A19
    .CursorMovement:
    #_0CDA19: dw  -1,   1,  -1,   1
    #_0CDA21: dw  -1,   1,  -1,   1
    #_0CDA29: dw  -1,   1,  -1,   1
    #_0CDA31: dw  -1,   1,  -1,   1
    #_0CDA39: dw  -2,   2,  -2,   2
    #_0CDA41: dw  -2,   2,  -2,   2
    #_0CDA49: dw  -4,   4
}

; $065A4D-$065C8B JUMP LOCATION
NameFile_DoTheNaming:
{
    .BRANCH_1
    
    LDY.w $0B13 : BEQ .BRANCH_6
        TYA : CMP.b #$31 : BEQ .BRANCH_2
            CLC : ADC.b #$04 : STA.w $0B13
    
        .BRANCH_2
        
        LDA.w $0B10 : ASL A : TAX
        
        REP #$20
        
        DEY
        
        LDA.w $0630 : CMP.l $0CD9B5, X : BNE .BRANCH_4
            SEP #$20
            
            LDA.b #$30 : STA.w $0B13
            
            LDA.b $F0 : AND.b #$03 : BNE .BRANCH_3
                STZ.w $0B13
        
            .BRANCH_3
        
            JSR $DC8C ; $065C8C
            
            BRA .BRANCH_1
        
        .BRANCH_4
        
        REP #$20
        
        LDX.w $0B16 : BNE .BRANCH_5
            INY #2
        
        .BRANCH_5
        
        LDA.w $0630
        
        TYX
        
        CLC : ADC.l $0CDA19, X : AND.w #$01FF : STA.w $0630
        
        SEP #$20
        
        BRA .BRANCH_7
    
    .BRANCH_6
    
    JSR $DC8C ; $065C8C
    
    .BRANCH_7
    
    LDA.w $0B14 : BEQ .BRANCH_10
        LDX.w $0B15
        
        LDY.b #$02
        
        LDA.w $0B11 : CMP.l $0CDA01, X : BNE .BRANCH_8
            STZ.w $0B14
            
            JSR $DCBF ; $065CBF
            
            BRA .BRANCH_7
        
        .BRANCH_8
        
        BMI .BRANCH_9
            LDY.b #$FE
        
        .BRANCH_9
        
        TYA : CLC : ADC.w $0B11 : STA.w $0B11
        
        BRA .BRANCH_11
    
    .BRANCH_10
    
    JSR $DCBF ; $065CBF.
    
    .BRANCH_11
    
    LDX.b #$00 : TXY
    
    LDA.b #$18 : STA.b $00
    
    .BRANCH_12
    
        LDA.b $00 : STA.w $0800, Y
        
        CLC : ADC.b #$08 : STA.b $00
        
        LDA.w $0B11 : STA.w $0801, Y
        
        LDA.b #$2E : STA.w $0802, Y
        
        LDA.b #$3C : STA.w $0803, Y
        
        STZ.w $0A20, X
        
        INY #4
    INX : CPX.b #$1A : BNE .BRANCH_12
    
    PHX
    
    LDX.w $0B12
    
    LDA.l $0CDA13, X : STA.w $0800, Y
    
    LDA.b #$58 : STA.w $0801, Y
    
    PLX
    
    LDA.b #$29 : STA.w $0802, Y
    LDA.b #$0C : STA.w $0803, Y
    
    STZ.w $0A20, X
    
    LDA.w $0B13 : ORA.w $0B14 : BNE .BRANCH_14
        LDA.b $F4 : AND.b #$10 : BEQ .BRANCH_13
            JMP $DBB1 ; $065BB1
        
        .BRANCH_13
        
        LDA.b $F4 : AND.b #$C0 : BNE .BRANCH_15
            LDA.b $F6 : AND.b #$C0 : BNE .BRANCH_15
    
    .BRANCH_14
    
    JMP $DBD9 ; $065BB9
    
    .BRANCH_15
    
    ; Play low life warning beep sound?
    LDA.b #$2B : STA.w $012E
    
    REP #$30
    
    LDA.w $0B15 : AND.w #$00FF : ASL A : TAX
    
    LDA.l $0CDA0B, X : CLC : ADC.w $0B10 : AND.w #$00FF : TAX
    
    SEP #$20
    
    LDA.l $0CD935, X
    
    CMP.b #$5A : BEQ .BRANCH_16
        CMP.b #$44 : BEQ .BRANCH_18
            CMP.b #$6F : BEQ .confirm_name
                STA.b $00
                STZ.b $01
        
                BRA .BRANCH_20
    
    .BRANCH_16
    
    LDA.w $0B12 : BNE .BRANCH_17
        LDA.b #$05 : STA.w $0B12
        
        BRA .BRANCH_24
    
    .BRANCH_17
    
    DEC.w $0B12
    
    BRA .BRANCH_24
    
    .BRANCH_18
    
    INC.w $0B12
    
    LDA.w $0B12 : CMP.b #$06 : BNE .BRANCH_19
        STZ.w $0B12
    
    .BRANCH_19
    
    BRA .BRANCH_24
    
    .BRANCH_20
    
    REP #$30
    
    AND.w #$000F : STA.b $02
    
    LDA.w $0B12 : AND.w #$00FF : ASL A : TAY
    
    CLC : ADC.w $0200 : TAX
    
    LDA.b $00 : AND.w #$FFF0 : ASL A : ORA.b $02 : STA.l $7003D9, X
    
    JSR $DD30 ; $065D30
    
    BRA .BRANCH_18
    
    ; $065BB1 ALTERNATE ENTRY POINT
    .confirm_name
    
    REP #$30
    
    STZ.b $02
    
    .BRANCH_22
    
    LDA.w $0200 : CLC
    
    ; $065BB9 ALTERNATE ENTRY POINT
    ; TODO: Find label for this.
    
    ADC.b $02 : TAX
    
    ; Checking if the spot is blank.
    LDA.l $7003D9, X : CMP.w #$00A9 : BNE .BRANCH_25
        LDA.b $02 : CMP.w #$000A : BEQ .BRANCH_23
            INC #2 : STA.b $02
            
            BRA .BRANCH_22
    
        .BRANCH_23
        
        SEP #$20
        
        LDA.b #$3C : STA.w $012E
        
        .BRANCH_24
        
        SEP #$30
        
        RTL
    
    .BRANCH_25
    
    SEP #$30
    
    ; Make the data bank 0x04.
    PHB : LDA.b #$04 : PHA : PLB
    
    REP #$30
    
    LDA.b $C8 : ASL A : INC #2 : STA.l $701FFE : TAX
    
    LDA.l $00848A, X : STA.b $00 : TAX
    
    LDA.w #$55AA : STA.l $7003E5, X
    
    LDA.w #$F000 : STA.l $70020C, X : STA.l $70020E, X
    
    LDA.w #$FFFF : STA.l $700405, X
    
    LDA.w #$001D : STA.b $02
    
    ; Branch if it's not the first save game slot.
    LDY.w #$003C : CPX.w #$0000 : BNE .loadInitialEquipment
        ; Lol.... wow, this is checking if the end of the "get joypad input"
        ; routine ends with an RTS instruction or not. In otherwords, it's
        ; checking the game's own code to determine if the player 2 joypad is
        ; enabled interesting manuever, I must say.
        LDA.l $0083F8 : AND.w #$00FF : CMP.w #$0060 : BEQ .loadInitialEquipment
            ; If the first letter of the player's name is not an uppercase 'B', no cheat code for you!
            LDA.l $7003D9 : CMP.w #$0001 : BNE .loadInitialEquipment
                ; If you've reached this section of code, it's a cheat code
                ; designed to help playtest the game by giving you a headstart
                ; on certain things in the game.
                ; The conditions for reaching here are
                ; 1. only works in first save game slot
                ; 2. the second controller must be enabled in the code
                ; 3. player name must start with letter 'B' (or perhaps a
                ; certain Japanese character).
                
                ; Presumably this is to... keep Link from getting magic powder
                ; again.
                LDA.w #$00F0 : STA.l $700212, X
                
                ; Set the game mode to after saving Zelda.
                LDA.w #$1502 : STA.l $7003C5, X
                
                ; Set map indicators on overworld and put Link starting in his house.
                LDA.w #$0100 : STA.l $7003C7, X
                
                LDY.w #$0000
        
    .loadInitialEquipment

        ; Setup initial equipment and flags values.
        LDA.w $F48A, Y : STA.l $700340, X
            
        INX #2
        INY #2
    DEC.b $02 : BPL .loadInitialEquipment
    
    LDX.b $00
    
    LDY.w #$0000 : TYA
    
    .computeChecksum
    
        CLC : ADC.l $700000, X
        
        INX #2 
    INY : CPY.w #$027F : BNE .computeChecksum
    
    STA.b $02
    
    LDX.b $00
    
    LDA.w #$5A5A : SEC : SBC.b $02 : STA.l $7004FE, X
    
    SEP #$30
    
    PLB
    
    JSR $D22D ; $06522D
    
    LDA.b #$FF : STA.w $0128
    
    LDA.b #$2C : STA.w $012E
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $065C8C-$065CBE LOCAL JUMP LOCATION
NameFile_CheckForScrollInputX:
{
    REP #$30
    
    ; Check if left or right directions are being held.
    LDA.b $F0 : AND.b #$03 : BEQ .BRANCH_2
        INC.w $0B13
        
        DEC A : STA.w $0B16
        
        REP #$30
        
        AND.w #$00FF : ASL A : TAX
        
        LDA.w $0B10 : AND.w #$00FF : CLC : ADC.l $0CD9F5, X : CMP.l $0CD9F9, X : BNE .BRANCH_1
            LDA.l $0CD9FD, X
        
        .BRANCH_1
        
        SEP #$30
        
        STA.w $0B10
    
    .BRANCH_2
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $065CBF-$065D23 LOCAL JUMP LOCATION
NameFile_CheckForScrollInputY:
{
    LDA.b $F0 : AND.b #$C0 : BEQ .BRANCH_5
        STA.b $02
        
        ASL A : ORA.w $0B15 : CMP.b #$10 : BEQ .BRANCH_6
            LDA.b $02 : ASL #2 : ORA.w $0B15
            
            LDX.w $0B10
            
            CMP.b #$13 : BEQ .BRANCH_6
                LDA.b $02 : LSR #2
                
                .BRANCH_1
                
                    TAX
                    
                    LDA.w $0B15 : CLC : ADC.l $0CDA04, X : CMP.l $0CDA06, X : BNE .BRANCH_2
                        LDA.l $0CDA08, X
                    
                    .BRANCH_2
                    
                    STA.w $0B15
                    
                    BRA .BRANCH_3
                    
                    ; Unreachable code?
                    STA.b $01
                    
                    LDX.w $0B15
                    
                    LDA.l $0CDA0B, X : CLC : ADC.w $0B10 : AND.b #$FF : TAX
                    
                    LDA.l $0CD935, X
                    
                    .BRANCH_3
                    
                    CMP.b #$59 : BNE .BRANCH_4
                        LDA.b $01
                BRA .BRANCH_1
                
                .BRANCH_4
                
                INC.w $0B14
                
                BRA .BRANCH_6
    
    .BRANCH_5
    
    STZ.w $00CA
    
    .BRANCH_6
    
    LDA.w $0002 : STA.w $00CB
    
    RTS
}

; ==============================================================================

; $065D30-$065D6C LOCAL JUMP LOCATION
NameFile_DrawSelectedCharacter:
{
    PHB : PHK : PLB
    
    LDA.w #$6100 : ORA.w $DD24, Y : XBA : STA.w $1002
    
    XBA : CLC : ADC.w #$0020 : XBA : STA.w $1008
    
    LDA.w #$0100 : STA.w $1004 : STA.w $100A
    
    LDA.l $7003D9, X : ORA.w #$1800 : STA.w $1006
    
    CLC : ADC.w #$0010 : STA.w $100C
    
    SEP #$30
    
    LDA.b #$FF : STA.w $100E
    
    LDA.b #$01 : STA.b $14
    
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
    
        LDA.b #$02 : STA.w $0A20, Y
        
        ; These are the X-coordinates of the Nintendo Logo Sprites.
        LDA.w $ED7A, Y : STA.w $0800, X
        
        ; The (hardcoded) Y coordinate for the Nintendo Logo sprites.
        LDA.b #$68   : STA.w $0801, X
        
        ; The sprite index (which sprite CHR is used.
        LDA.w $ED7E, Y : STA.w $0802, X
        
        ; Palette, priority, and flip in formation for each sprite.
        LDA.b #$32 : STA.w $0803, X
        
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
    
    ; Check the screen brightness.
    LDA.b $13 : BEQ .ignoreInput
        ; If screen is force blanked.
        CMP.b #$80 : BEQ .ignoreInput
            ; Ignore input during all of the fading submodules.
            LDA.b $22    : BEQ .ignoreInput
            CMP.b #$02 : BEQ .ignoreInput
            CMP.b #$06 : BEQ .ignoreInput
                ; Check the joypad for activity on B or Start.
                LDA.b $F4 : AND.b #$90 : BEQ .dontEndSequence
                    ; Begin exiting attract mode if one of those buttons was
                    ; pressed.
                    LDA.b #$09 : STA.b $22

                .dontEndSequence
    
    .ignoreInput
    
    LDA.b $22 : ASL A : TAX
    
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
    ; Keeps the title screen status quo running while we darken the screen.
    
    JSL.l $0CC404 ; $064404
    
    STZ.w $1F00
    STZ.w $012A
    
    JSR $FE56 ; $067E56
    
    LDA.b $13 : BEQ .fullyDark
        ; Decrease screen brightness.
        DEC.b $13
        
        RTL
    
    .fullyDark
    
    JSL EnableForceBlank ; $93D
    
    ; Disable all that crazy 3D triforce stuff.
    LDA.b #$FF : STA.w $0128
    
    STZ.w $012A
    STZ.w $1F0C
    
    ; Step to the next submodule.
    INC.b $22
    
    RTL
}

; ==============================================================================

; $066E0C-$066EA5 LONG JUMP LOCATION
Attract_InitGraphics:
{
    LDX.b #$50
    
    .zeroVars
    
        STZ.b $20, X
    DEX : BPL .zeroVars
    
    JSL Vram_EraseTilemaps_normal
    JSL.l $00E36D ; $00636D
    
    LDA.b #$04 : STA.w $0AB3
    LDA.b #$01 : STA.w $0AB2
    
    STZ.w $0AA9
    
    JSL Palette_Hud ; $0DEE52
    
    LDA.b #$02 : STA.w $0AA9
    
    JSL Palette_OverworldBgMain
    JSL Palette_Hud
    JSL Palette_ArmorAndGloves
    
    LDA.b #$00 : STA.l $7EC53A
    LDA.b #$38 : STA.l $7EC53B
    
    INC.b $15
    
    LDA.b #$14 : STA.b $EA
    
    JSR $F7E6 ; $0677E6
    
    REP #$10
    
    STZ.w $1CD8
    
    LDX.w #$0112 : STX.w $1CF0
    
    STZ.b $E8
    STZ.b $E9
    
    ; Timer for the legend in frames.
    LDX.w #$1010 : STX.w $0200
    
    ; Go to module 0x14.0x03 next frame.
    INC.b $22 : INC.b $22 : INC.b $22
    
    SEP #$10
    
    JSR Attract_SetupHdma
    
    STZ.b $96
    STZ.b $97
    
    LDA.b #$B0 : STA.b $98
    
    LDA.b #$03 : STA.b $1E 
                 STZ.b $1F
    
    LDA.b #$25 : STA.b $9C
    LDA.b #$45 : STA.b $9D
    LDA.b #$85 : STA.b $9E
    LDA.b #$10 : STA.b $99
    LDA.b #$A3 : STA.b $9A
    
    STZ.w $212A
    STZ.w $212B
    
    ; Resume hdma next frame using channels 6 and 7.
    LDA.b #$C0 : STA.b $9B
    
    ; Play "Legend" theme music.
    LDA.b #$06 : STA.w $012C
    
    INC.b $27
    
    RTL
}

; ==============================================================================

; $066EA6-$066EB9 LOCAL JUMP LOCATION
Attract_SlowBrigthenSetFlag:
{
    ; Wait until screen brightness is at max.
    LDA.b $13 : CMP.b #$0F : BEQ .fullyBrightened
        DEC.b $5E : BPL .oneFrameDelay
            INC.b $13
            
            LDA.b #$01 : STA.b $5E
        
        .oneFrameDelay
        
        RTS
    
    .fullyBrightened
    
    INC.b $5F
    
    RTS
}

; ==============================================================================

; $066EBA-$066ECA LONG JUMP LOCATION
Attract_SlowBrighten:
{
    LDA.b $13 : CMP.b #$0F : BEQ Attract_SlowFadeToBlank_nextSubmodule
    
    DEC.b $5E : BPL .oneFrameDelay
        INC.b $13
        
        LDA.b #$01 : STA.b $5E
    
    .oneFrameDelay
    
    RTL
}

; ==============================================================================

; $066ECB-$066EE4 LONG JUMP LOCATION
Attract_SlowFadeToBlank:
{
    LDA.b $13 : BEQ .fullyDarkened
        DEC.b $5E : BPL .oneFrameDelay
            DEC.b $13
            
            LDA.b #$01 : STA.b $5E
        
        .oneFrameDelay
        
        RTL
    
    .fullyDarkened
    
    JSL EnableForceBlank ; $00093D
    JSL Vram_EraseTilemaps.normal
    
    .nextSubmodule
    
    INC.b $22
    
    RTL
}

; ==============================================================================

; $066EE5-$066EEB LONG JUMP LOCATION
Attract_PrepNextSequence:
{
    LDA.b $23 : ASL A : TAX
    
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
    STZ.b $26
    
    INC.b $22
    
    STZ.b $13
    
    RTL
}

; ==============================================================================

; $066EFF-$066F4D JUMP LOCATION
Attract_PrepMapZoom:
{
    LDA.b #$13 : STA.w $2107
    LDA.b #$03 : STA.w $2108
    
    LDA.b #$80 : STA.b $99
    LDA.b #$21 : STA.b $9A
    
    LDA.b #$07 : STA.w $2105 : STA.b $94
    
    LDA.b #$80 : STA.w $211A
    
    JSL OverworldMap_InitGfx
    
    REP #$20
    
    LDA.w #$00ED : STA.w $063A
    LDA.w #$0100 : STA.w $0638
    
    LDA.w #$0080 : STA.w $0120
    LDA.w #$00C0 : STA.w $0124
    
    SEP #$20
    
    LDA.b #$FF : STA.w $0637
    
    JSR Attract_AdjustMapZoom
    
    LDA.b #$01 : STA.b $25
    
    INC.b $22
    
    STZ.b $13
    
    RTL
}

; ==============================================================================

; $066F4E-$066FE2 LONG JUMP LOCATION
Attract_PrepThroneRoom:
{
    STZ.w $420C
    STZ.b $9B
    
    ; Sets up subscreen addition a certain way because this room has
    ; two floors. This will be disabled in the latter two sequences.
    LDA.b #$02 : STA.b $99
    LDA.b #$20 : STA.b $9A
    
    ; Set misc. sprite index.
    LDA.b #$0A : STA.w $0AA4
    
    JSL Graphics_LoadCommonSprLong ; $006384
    
    REP #$20
    
    ; Since we're loading a dungeon entrance, and that attempts to write
    ; to Link's coordinates (which this attract mode for whatever reason
    ; also decided to allocate in the same location), we have to cache these
    ; for the moment, lest attract mode go out of its mind.
    LDA.b $20 : PHA
    LDA.b $22 : PHA
    
    SEP #$20
    
    ; The entrance number to load.
    LDA.b #$74
    
    JSL Attract_LoadDungeonRoom
    
    REP #$20
    
    PLA : STA.b $22
    PLA : STA.b $20
    
    SEP #$20
    
    STZ.w $0AB6
    STZ.w $0AAC
    
    LDA.b #$0E : STA.w $0AAD
    LDA.b #$03 : STA.w $0AAE
    
    LDX.b #$7E
    
    LDA.b #$00
    
    JSL Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA.l $7EC53A
    LDA.b #$38 : STA.l $7EC53B
    
    STZ.w $1CD8
    
    LDA.b #$13 : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    LDA.b #$02 : STA.b $25
    LDA.b #$E0 : STA.b $2C
    
    REP #$20
    
    LDA.w #$0210 : STA.b $64
    
    SEP #$20
    
    ; $066FC0 ALTERNATE ENTRY POINT
    
    INC.b $22
    
    STZ.b $13
    STZ.b $EA
    
    ; Since the entrance loader loads scroll values in dungeon relative 
    ; coordinates, which are often much larger than 0x200, bound them for
    ; attract mode purposes. The throne room sequence counts $0122 down to
    ; zero, and it could take quite a while and it would look funny if we
    ; didn't do this. i.e. it would be looping several times before finally
    ; showing the text message and then moving on to the next sequence.
    LDA.w $011F : AND.b #$01 : STA.w $011F
    LDA.w $0123 : AND.b #$01 : STA.w $0123
    
    ; Same thing here.
    LDA.b $E3 : AND.b #$01 : STA.b $E3
    LDA.b $E9 : AND.b #$01 : STA.b $E9
    
    RTL
}

; ==============================================================================

; $066FE3-$067057 LONG JUMP LOCATION
Attract_PrepZeldaPrison:
{
    STZ.b $99
    STZ.b $9A
    
    REP #$20
    
    LDA.b $20 : PHA
    LDA.b $22 : PHA
    
    SEP #$20
    
    LDA.b #$73
    
    JSL Attract_LoadDungeonRoom
    
    REP #$20
    
    PLA : STA.b $22
    PLA : STA.b $20
    
    SEP #$20
    
    LDA.b #$02 : STA.w $0AB6
    
    STZ.w $0AAC
    
    LDA.b #$0E : STA.w $0AAD
    LDA.b #$03 : STA.w $0AAE
    
    LDX.b #$7F
    LDA.b #$01
    
    JSL Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA.l $7EC53A
    LDA.b #$38 : STA.l $7EC53B
    
    STZ.w $1CD8
    
    LDA.b #$14 : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    LDA.b #$94 : STA.b $2B
    LDA.b #$68 : STA.b $30
    
    STZ.b $31
    STZ.b $32
    STZ.b $33
    STZ.b $40
    STZ.b $50
    STZ.b $5F
    
    LDA.b #$FF : STA.b $25
    
    REP #$20
    
    LDA.w #$0240 : STA.b $64
    
    SEP #$20
    
    JMP $EFC0 ; $066FC0
}

; ==============================================================================

; $067058-$0670DB LONG JUMP LOCATION
Attract_PrepMaidenWarp:
{
    REP #$20
    
    LDA.b $20 : PHA
    LDA.b $22 : PHA
    
    SEP #$20
    
    LDA.b #$75
    
    JSL Attract_LoadDungeonRoom
    
    REP #$20
    
    PLA : STA.b $22
    PLA : STA.b $20
    
    SEP #$20
    
    STZ.w $0AB6
    STZ.w $0AAC
    
    LDA.b #$0E : STA.w $0AAD
    
    LDA.b #$03 : STA.w $0AAE
    
    STZ.w $0AA9
    
    ; This call confuses me, as it seems that the next call after this
    ; would undo what this one does...
    JSL Attract_LoadDungeonGfxAndTiles_justPalettes
    
    LDX.b #$7F
    LDA.b #$02
    
    JSL Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA.l $7EC33A : STA.l $7EC53A
    LDA.b #$38 : STA.l $7EC33B : STA.l $7EC53B
    
    STZ.w $1CD8
    
    LDA.b #$15 : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    LDA.b #$FF : STA.b $25
    
    LDA.b #$70 : STA.b $30 : STA.b $62
    LDA.b #$70           : STA.b $63
    
    LDA.b #$08 : STA.b $32
    
    STZ.b $50
    STZ.b $51
    STZ.b $52
    STZ.b $5F
    STZ.b $60
    STZ.b $61
    
    REP #$20
    
    LDA.w #$00C0 : STA.b $64
    
    SEP #$20
    
    JMP $EFC0 ; $066FC0
}

; ==============================================================================

; $0670DC-$067114 LONG JUMP LOCATION
AttractScene_EndOfStory:
{
    REP #$20
    
    JSL OverworldMap_PrepExit_restoreHdmaSettings
    
    ; $0670E2 ALTERNATE ENTRY POINT
    
    INC.w $0710
    
    JSL Intro_LoadTitleGraphics.noWait
    JSL Intro_LoadTextPointersAndPalettes.justPalettes
    
    STZ.b $EA
    
    REP #$20
    
    STZ.w $063A
    STZ.w $0638
    STZ.w $0120
    STZ.w $0124
    STZ.w $011E
    STZ.w $0122
    
    SEP #$20
    
    LDA.b #$F1 : STA.w $012C
    
    STZ.b $23
    STZ.b $10
    
    LDA.b #$0A : STA.b $11 : STA.b $B0
    
    RTL
}

; ==============================================================================

; $067115-$06711B LONG JUMP LOCATION
Attract_RunSequence:
{
    LDA.b $23 : ASL A : TAX
    
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
    LDA.b $1A : AND.b #$03 : BNE .dontMoveBgs
        INC.w $0124
        
        INC.w $0120
        
        INC.w $0122
        
        DEC.w $011E
    
    .dontMoveBgs
    
    LDA.b $27 : BEQ .noNewGraphic
        JSR Attract_LoadNextLegendGraphic
        
        STZ.b $27
        
        INC.b $26 : INC.b $26
    
    .noNewGraphic
    
    STZ.b $F2
    STZ.b $F6
    STZ.b $F4
    
    JSL Messaging_Text
    
    REP #$20
    
    DEC.w $0200 : BNE .timerNotFinished
        SEP #$20
        
        ; Move to the next sub submodule.
        INC.b $23
        
        DEC.b $22 : DEC.b $22 : DEC.b $22
        
        BRA .return
    
    .timerNotFinished
    
    LDA.w $0200 : CMP.w #$0018 : BCS .dontFadeThisFrame
        AND.w #$0001 : BEQ .dontFadeThisFrame
            SEP #$20
            
            DEC.b $13
    
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
    
    LDA.w $0637
    
    CMP.b #$00 : BEQ .advanceToNextSequence
    CMP.b #$0F : BCS .dontFadeThisFrame
        DEC.b $13
        
        .dontFadeThisFrame
        
        LDY.b #$01
        
        DEC.b $25 : BNE .noZoomAdjustThisFrame
            STY.b $25
            
            ; Decrement the timer by one.
            LDA.w $0637 : SEC : SBC.b #$01 : STA.w $0637
            
            JSR Attract_AdjustMapZoom
        
        .noZoomAdjustThisFrame
        
        RTL
    
    .advanceToNextSequence
    
    JSL EnableForceBlank
    
    LDA.b #$09 : STA.w $2105 : STA.b $94
    
    JSL Vram_EraseTilemaps_normal
    
    ; Go to the throne room sequence.
    INC.b $23
    
    DEC.b $22 : DEC.b $22
    
    RTL
}

; ==============================================================================

; $0671AE-$0671C7 DATA
Pool_AttractDramatize_ThroneRoom:
{
    ; $0671AE
    .pointer_size
    dw $F8A7, $F8BB
    
    ; $0671B2
    .pointer_offset_x
    dw $F8AB, $F8C1
    
    ; $0671B6
    .pointer_offset_y
    dw $F8AF, $F8C7
    
    ; $0671BA
    .pointer_char
    dw $F8B3, $F8CD
    
    ; $0671BE
    .pointer_prop
    dw $F8B7, $F8D3
    
    ; $0671C2
    .offset_x
    db $50 ; king
    db $68 ; mantle
    
    ; $0671C4
    .offset_y
    db $58 ; king
    db $20 ; mantle
    
    ; $0671C6
    .oam_count
    db $03 ; king
    db $05 ; mantle
}

; ==============================================================================

; $0671C8-$06725F LONG JUMP LOCATION
Attract_ThroneRoom:
{
    STZ.b $2A
    
    LDA.b $52 : BNE .brighteningTaskFinished
        LDA.b $13 : CMP.b #$0F : BEQ .fullyBrightened
            INC.b $13
            
            BRA .brighteningTaskFinished
            
        .fullyBrightened
        
        INC.b $52
        
    .brighteningTaskFinished
    
    REP #$20
    
    LDA.w $0122 : BNE .stillScrolling
        SEP #$20
        
        JSR Attract_ShowTimedTextMessage
        
        REP #$20
        
        LDA.b $64 : SEP #$20 : BNE .textTimerNotFinished
            LDA.b $2C : CMP.b #$1F : BCS .dontDarkenThisFrame
                AND.b #$01 : BNE .dontDarkenThisFrame
                    DEC.b $13
            
            .dontDarkenThisFrame
            
            DEC.b $2C : BNE .sequenceNotFinished
                ; Go to the Zelda in prison sequence.
                INC.b $23
                INC.b $22
                
                RTL
    
    .stillScrolling
    
    DEC.w $0122
    DEC.w $0124
    
    .textTimerNotFinished
    .sequenceNotFinished
    
    SEP #$20
    
    LDX.b #$02
    
    .nextSpriteSet
    
        PHX
        
        REP #$20
        
        LDA.l $0CF1AE, X : STA.b $2D
        LDA.l $0CF1B2, X : STA.b $02
        LDA.l $0CF1B6, X : STA.b $04
        LDA.l $0CF1BA, X : STA.b $06
        LDA.l $0CF1BE, X : STA.b $08
        
        TXA : AND.w #$00FF : LSR A : TAX
        
        LDA.l $0CF1C4, X : AND.w #$00FF : SEC : SBC.w $0122 : STA.b $00
        
        CMP.w #$FFE0 : SEP #$20 : BMI .spriteSetOffscreen
            LDA.l $0CF1C2, X : STA.b $28
            
            LDA.b $00 : STA.b $29
            
            LDA.l $0CF1C6, X : TAY
            
            JSR Attract_DrawSpriteSet
        
        .spriteSetOffscreen
    PLX : DEX #2 : BPL .nextSpriteSet
    
    RTL
}

; ==============================================================================

; $067260-$067279 DATA
Pool_AttractDramatize_Prison:
{
    ; $067260
    .soldier_offset_x
    dw  32, -12

    ; $067264
    .soldier_offset_y
    db  24,  24

    ; $067266
    .soldier_direction
    db $01, $01

    ; $067268
    .soldier_palette
    db $09, $07

    ; Maybe has something to do with the offset of the prisoner being
    ; led away?
    ; $06726A
    .maiden_jab_offset_x
    db  0,  1,  2,  3
    db  4,  5,  5,  5
    db  4,  4,  3,  3
    db  2,  2,  1,  1
}   

; ==============================================================================

; $06727A-$06731F LONG JUMP LOCATION
Attract_ZeldaPrison:
{
    STZ.b $2A
    
    LDA.b $5F : BNE .brighteningTaskFinished
        JSR Attract_SlowBrigthenSetFlag
    
    .brighteningTaskFinished
    
    LDA.b #$38 : STA.b $28
    
    JSR Atract_DrawZelda
    
    LDA.b $25 : CMP.b #$C0 : BCS .BRANCH_BETA
        JMP $F319 ; $067319
    
    .BRANCH_BETA
    
    LDA.b #$70 : STA.b $29
    
    DEC.b $50 : BPL .BRANCH_GAMMA
        LDA.b #$0F : STA.b $50
    
    .BRANCH_GAMMA
    
    LDX.b $50
    
    LDA.b $31 : STA.b $40
    
    LDA.b $30 : CLC : ADC.l $0CF26A, X : STA.b $28 : BCC .BRANCH_DELTA
        INC.b $40
    
    .BRANCH_DELTA
    
    JSR $FA30 ; $067A30
    
    LDX.b #$01
    
    .nextSoldier
    
        STZ.b $03
        
        LDA.b $33 : STA.b $06
        
        LDA.b $29 : CLC : ADC.l $0CF264, X : STA.b $02
        
        LDA.l $0CF266, X : STA.b $04
        LDA.l $0CF268, X : STA.b $05
        
        PHX
        
        REP #$20
        
        TXA : ASL A : TAX
        
        LDA.b $30 : CLC : ADC.w #$0100 : CLC : ADC.l $0CF260, X : STA.b $00
        TAY : STY.b $34
        
        SEP #$20
        
        JSL Sprite_ResetProperties
        
        ; I think that this animates the soldiers leading the prisoner away.
        ; As in, generates their appearance and puts it into oam and such.
        ; Kind of like a marionette being controlled by a puppeteer, but one
        ; frame at a time.
        JSL Sprite_SimulateSoldier
    PLX : DEX : BPL .nextSoldier
    
    INC.b $32
    
    LDA.b $32 : AND.b #$07 : BNE .BRANCH_ZETA
        LDY.b #$FF
        
        LDA.b $33 : CMP.b #$02 : BNE .BRANCH_THETA
            STY.b $33
            
            LDA.b $31 : BNE .BRANCH_THETA
                LDA.b $32 : AND.b #$08 : BEQ .BRANCH_THETA
                    LDA.b #$04 : STA.w $012F
        
        .BRANCH_THETA
        
        INC.b $33
    
    ; $067319 ALTERNATE ENTRY POINT
    .BRANCH_ZETA
    
    LDA.b $60 : ASL A : TAX
    
    JMP ($.vectors, X) ; $067320

    ; $067320-$067323 Jump Table
    .vectors
    dw $F32B ; = $06732B
    dw $F379 ; = $067379
}

; ==============================================================================

; $067324-$06732A LONG JUMP LOCATION
Attract_AdvanceToNextSequence:
{
    INC.b $23
    
    DEC.b $22 : DEC.b $22
    
    RTL
}

; ==============================================================================

; $06732B-$067364 LONG JUMP LOCATION
Dramaghanim_WaitForCue:
{
    LDA.b $34 : BNE .BRANCH_ALPHA
        INC.b $60
    
    .BRANCH_ALPHA
    
    REP #$20
    
    LDA.b $1A : AND.w #$0001 : BEQ .BRANCH_BETA
        DEC.b $30
    
    .BRANCH_BETA
    
    LDA.w #$F8D9 : STA.b $2D
    LDA.w #$F8DF : STA.b $02
    LDA.w #$F8E5 : STA.b $04
    LDA.w #$F903 : STA.b $06
    LDA.w #$F915 : STA.b $08
    
    SEP #$20
    
    LDA.b #$58 : STA.b $28
    
    LDA.b $2B : STA.b $29
    
    LDY.b #$05
    
    JSR Attract_DrawSpriteSet
    
    RTL
}

; ==============================================================================

; $067379-$067400 LONG JUMP LOCATION
Dramaghanim_MoveAndSpin:
{
    LDA.b $25 : CMP.b #$80 : BCS .BRANCH_ALPHA
        JSR Attract_ShowTimedTextMessage
        
        REP #$20
        
        LDA.b $64 : SEP #$20 : BEQ .BRANCH_ALPHA
            LDX.b #$08
            
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDX.b #$00
    
    LDA.b $2B : CMP.b #$6E : BEQ .BRANCH_DELTA
        DEC.b $2B : BRA .BRANCH_BETA
    
    .BRANCH_DELTA
    
    LDA.b $25
    
    CMP.b #$1F : BCS .BRANCH_EPSILON
    AND.b #$01 : BNE .BRANCH_EPSILON
        DEC.b $13
    
    .BRANCH_EPSILON
    
    DEC.b $25 : BNE .BRANCH_ZETA
        JMP Attract_AdvanceToNextSequence
    
    .BRANCH_ZETA
    
    LDA.b $25 : CMP.b #$C0 : BCS .BRANCH_BETA
        INX #2
        
        CMP.b #$B8 : BCS .BRANCH_BETA
            INX #2
            
            CMP.b #$B0 : BCS .BRANCH_BETA
                INX #2
                
                CMP.b #$A0 : BCS .BRANCH_BETA
                    INX #2

    .BRANCH_BETA

    LDA.b #$A8 : STA.b $28
    
    REP #$20
    
    LDA.b $1A : AND.w #$0001 : BEQ .BRANCH_GAMMA
        DEC.b $30
    
    .BRANCH_GAMMA
    
    LDA.w #$F8D9 : STA.b $2D
    LDA.w #$F8DF : STA.b $02
    LDA.w #$F8E5 : STA.b $04
    
    LDA.l $0CF365, X : STA.b $06
    LDA.l $0CF36F, X : STA.b $08
    
    SEP #$20
    
    LDA.b #$58 : STA.b $28
    
    LDA.b $2B : STA.b $29
    
    LDY.b #$05
    
    JSR Attract_DrawSpriteSet
    
    RTL
}

; ==============================================================================

; $067419-$067422 Jump Table
Pool_Attract_MaidenWarp:
{
    .vectors
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
    LDA.b $5D : BEQ .sequenceNotFinished
        JMP Attract_AdvanceToNextSequence
    
    .sequenceNotFinished
    
    STZ.b $2A
    
    JSL Filter_MajorWhitenMain
    
    LDA.b $5F : BNE .brighteningTaskFinished
        JSR Attract_SlowBrigthenSetFlag
    
    .brighteningTaskFinished
    
    LDA.b $50 : CMP.b #$FF : BEQ .counterAtMax
        INC.b $50
    
    .counterAtMax
    
    LDA.w $0FF9 : BEQ .BRANCH_DELTA
    AND.b #$04 : BEQ .BRANCH_DELTA
    
        ; Sound effect.
        LDX.b #$2B : STX.w $012F
    
    .BRANCH_DELTA
    
    LDA.b $60 : ASL A : TAX
    
    JSR (Pool_Attract_MaidenWarp_vectors, X) ; $067419
    
    LDX.b #$05
    
    .nextSoldier
    
        STZ.b $01
        STZ.b $03
        STZ.b $06
        
        LDA.l $0CF401, X : STA.b $00
        LDA.l $0CF407, X : STA.b $02
        LDA.l $0CF40D, X : STA.b $04
        LDA.l $0CF413, X : STA.b $05
        
        PHX
        
        JSL Sprite_ResetProperties
        JSL Sprite_SimulateSoldier
    PLX : DEX : BPL .nextSoldier
    
    LDX.b $50 : CPX.b #$A0 : BCC .BRANCH_ZETA
        LDA.b $30 : CMP.b #$60 : BEQ .BRANCH_THETA
            DEC.b $32 : BNE .BRANCH_ZETA
                DEC.b $30
                
                LDA.b #$08 : STA.b $32
                
                BRA .BRANCH_ZETA
        
        .BRANCH_THETA
        
        INC.b $61
    
    .BRANCH_ZETA
    
    LDA.b $52 : BNE .BRANCH_IOTA
        REP #$20
        
        LDA.w #$F927 : STA.b $2D
        LDA.w #$F929 : STA.b $02
        LDA.w #$F92B : STA.b $04
        
        LDX.b #$00
        
        LDA.b $30 : AND.w #$00FF : CMP.w #$0070 : BEQ .BRANCH_KAPPA
            INX #2
        
        .BRANCH_KAPPA
        
        LDA.l $0CF567, X : STA.b $06
        
        LDA.w #$F931 : STA.b $08
        
        SEP #$20
        
        LDA.b #$74 : STA.b $28
        
        LDA.b $30 : STA.b $29
        
        LDY.b #$01
        
        JSR Attract_DrawSpriteSet
        
        LDX.b #$0E
        
        LDA.b $30 : CMP,.b #$68 : BCS .BRANCH_LAMBDA
            SEC : SBC.b #$68 : ASL A : AND.b #$0E : TAX
        
        .BRANCH_LAMBDA
        
        REP #$20
        
        LDA.w #$F933 : STA.b $2D
        
        LDA.l $0CF54F, X : STA.b $02
        
        LDA.w #$F93F : STA.b $04
        LDA.w #$F941 : STA.b $06
        LDA.w #$F943 : STA.b $08
        
        SEP #$20
        
        TXA : LSR A : TAX
        
        LDA.b #$74 : CLC : ADC.l $0CF55F, X : STA.b $28
        
        LDA.b #$76 : STA.b $29
        
        LDY.b #$01
        
        JSR Attract_DrawSpriteSet
    
    .BRANCH_IOTA
    
    LDA.b $50 : LSR #4 : AND.b #$0E : TAX
    
    REP #$20
    
    LDA.w #$F8D9   : STA.b $2D
    LDA.w #$F8DF   : STA.b $02
    LDA.w #$F8E5   : STA.b $04
    LDA.l $0CF56B, X : STA.b $06
    LDA.w #$F915   : STA.b $08
    
    SEP #$20
    
    LDA.b #$70 : STA.b $28
    LDA.b #$46 : STA.b $29
    
    LDY.b #$05
    
    JSR Attract_DrawSpriteSet
    
    RTL
}

; $06757B-$067581 LOCAL JUMP LOCATION
Dramagahnim_RaiseTheRoof:
{
    LDA.b $61 : BEQ .BRANCH_ALPHA
        INC.b $60
    
    .BRANCH_ALPHA
    
    RTS
}

; $067592-$0675FA LOCAL JUMP LOCATION
Dramagahnim_ReadySpell:
{
    LDA.b $1A : LSR A : AND.b #$02 : TAX
    
    REP #$20
    
    LDA.w #$F945 : STA.b $2D
    LDA.w #$F953 : STA.b $02
    LDA.w #$F961 : STA.b $04
    
    LDA.l $0CF582, X : STA.b $06
    LDA.l $0CF586, X : STA.b $08
    
    SEP #$20
    
    LDA.b #$6E : STA.b $28
    LDA.b #$48 : STA.b $29
    
    LDA.b $51 : LSR A : AND.b #$07 : TAX
    
    LDA.l $0CF58A, X : TAY
    
    JSR Attract_DrawSpriteSet
    
    LDA.b $51 : BNE .BRANCH_ALPHA
        LDY.b $63 : CPY.b #$70 : BNE .BRANCH_ALPHA
            LDX.b #$27 : STX.w $012F
    
    .BRANCH_ALPHA
    
    CMP.b #$0F : BEQ .BRANCH_BETA
        CMP.b #$06 : BNE .BRANCH_GAMMA
            LDX.b #$90 : STX.w $0FF9
            LDX.b #$2B : STX.w $012F
        
        .BRANCH_GAMMA
        
        LDA.b $63 : BEQ .BRANCH_DELTA
            DEC.b $63
            
            RTS
            
        .BRANCH_DELTA
        
        INC.b $51
        
        RTS
    
    ; $0675F8 ALTERNATE ENTRY POINT
    .BRANCH_BETA
    
    INC.b $60
    
    RTS
}

; $067613-$067674 LOCAL JUMP LOCATION
Dramagahnim_CastSpell:
{
    PHB : PHK : PLB
    
    LDA.b $1A : LSR A : AND.b #$02 : TAX
    
    LDA.b $51 : LSR A : AND.b #$07 : STA.b $00
    
    ASL A : TAY
    
    REP #$20
    
    LDA.w #$F945 : CLC : ADC.w $F603, Y : STA.b $2D
    LDA.w #$F953 : CLC : ADC.w $F603, Y : STA.b $02
    LDA.w #$F961 : CLC : ADC.w $F603, Y : STA.b $04
    
    LDA.w $F582, X : CLC : ADC.w $F603, Y : STA.b $06
    LDA.w $F586, X : CLC : ADC.w $F603, Y : STA.b $08
    
    SEP #$20
    
    LDA.b #$6E : STA.b $28
    LDA.b #$48 : STA.b $29
    
    LDX.b $00
    
    LDA.w $F5FB, X : TAY
    
    JSR Attract_DrawSpriteSet
    
    PLB
    
    LDA.b $51 : BNE .BRANCH_ALPHA
        DEC.b $62 : BEQ Dramagahnim_ReadySpell_BRANCH_BETA
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    DEC.b $51
    
    .BRANCH_BETA
    
    RTS
}

; $067689-$0676E1 LOCAL JUMP LOCATION
Dramagahnim_RealizeWhatJustHappened:
{
    LDA.b $51 : CMP.b #$06 : BNE .BRANCH_ALPHA
        INC.b $52
        
        LDA.b #$33 : STA.w $012E
    
    .BRANCH_ALPHA
    
    CMP.b #$40 : BNE .BRANCH_BETA
        LDA.b #$E0 : STA.b $51
        
        INC.b $60
    
    .BRANCH_BETA
    
    CMP.b #$0F : BCS .BRANCH_GAMMA
        LSR #2 : AND.b #$02 : TAX
        
        REP #$20
        
        LDA.w #$F9A7 : STA.b $2D
        
        LDA.l $0CF675, X : STA.b $02
        LDA.l $0CF679, X : STA.b $04
        LDA.l $0CF67D, X : STA.b $06
        LDA.l $0CF681, X : STA.b $08
        
        SEP #$20
        
        TXA : LSR A : TAX
        
        LDA.l $0CF685, X : STA.b $28
        
        LDA.b #$60 : STA.b $29
        
        LDA.l $0CF687, X : TAY
        
        JSR Attract_DrawSpriteSet
    
    .BRANCH_GAMMA
    
    INC.b $51
    
    RTS
}

; $0676E2-$0676FF LOCAL JUMP LOCATION
Dramagahnim_IdleGuiltily:
{
    JSR Attract_ShowTimedTextMessage
    
    REP #$20
    
    LDA.b $64 : SEP #$20 : BNE .BRANCH_ALPHA
        LDA.b $51 : CMP.b #$1F : BCS .BRANCH_BETA
            AND.b #$01 : BNE .BRANCH_BETA
                DEC.b $13
        
        .BRANCH_BETA
        
        DEC.b $51 : BNE .BRANCH_ALPHA
            INC.b $5D
    
    .BRANCH_ALPHA
    
    RTS
}

; $067700-$06772D LONG JUMP LOCATION
Attract_Exit:
{
    DEC.b $13 : BNE .stillDarkening
        JSL EnableForceBlank
        
        ; Set BG1 tilemap to xy-mirrored, at VRAM address $1000.
        LDA.b #$13 : STA.w $2107
        
        ; Set BG2 tilemap to xy-mirrored, at VRAM address $0000.
        LDA.b #$03 : STA.w $2108
        
        REP #$20
        
        JSL OverworldMap_PrepExit.restoreHdmaSettings
        
        REP #$20
        
        STZ.w $063A
        STZ.w $0638
        
        ; Set BG1 horizontal and vertical scroll buffer regs to 0.
        STZ.w $0120
        STZ.w $0124
        
        ; Set BG3 vertical scroll buffer reg to 0.
        STZ.b $EA
        
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
    
    LDX.b $26
    
    LDA Attract_LegendGraphics_sizes, X    : STA !picSize
    LDA Attract_LegendGraphics_pointers, X : STA !picData
    
    LDX.b #$0C : STX.b $04
    
    REP #$10
    
    ; Write the tilemap data into a buffer to be transferred once NMI hits.
    LDY !picSize
    
    .writeLoop
    
        LDA [!picData], Y : STA.w $1002, Y
    DEY #2 : BPL .writeLoop
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    RTS
}

; ==============================================================================

; $067766-$067782 LOCAL JUMP LOCATION
Attract_ShowTimedTextMessage:
{
    LDA.b $E8 : STA.b $20
    LDA.b $E9 : STA.b $21
    
    STZ.b $F2
    STZ.b $F6
    STZ.b $F4
    
    JSL Messaging_Text
    
    REP #$20
    
    LDA.b $64 : BEQ .textTimerHasExpired
        DEC.b $64
    
    .textTimerHasExpired
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $067783-$0677BD LOCAL JUMP LOCATION
Attract_AdjustMapZoom:
{
    REP #$10
    
    LDA.w $0637 : STA.w $4202
    
    LDX.w #$01BE
    
    .adjustHdmaTableLoop
    
        LDA.l $0ADD27, X : STA.w $4203
        
        NOP #4
        
        LDA.w $4217 : STA.b $00
        
        LDA.l $0ADD28, X : STA.w $4203
        
        NOP
        
        ; This is effectively the top 16-bits of the 24-bit result of
        ; multiplying $0637 (byte) by the current word from the table.
        LDA.b $00   : CLC : ADC.w $4216  : STA.w $1B00, X
        LDA.w $4217 : ADC.b #$00 : STA.w $1B01, X
    DEX #2 : BPL .adjustHdmaTableLoop
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; $0677E6-$067878 LOCAL JUMP LOCATION
Attract_BuildBackgrounds:
{
    LDA.b #$09 : STA.b $94
    
    LDA.b #$17 : STA.b $1C
    
    STZ.b $1D
    
    LDA.b #$10 : STA.w $2107
    LDA.b #$00 : STA.w $2108
    
    PHB : PHK : PLB
    
    REP #$30
    
    LDX.w #$0000
    
    LDA.w #$F7BE : STA.b $30
    
    .BRANCH_BETA
    
            TXA : AND.w #$0007 : TAY
            
            .BRANCH_ALPHA
            
                LDA ($30), Y : STA.w $1006, X
                
                INY #2
                
                INX #2
            TYA : AND.w #$0007 : BNE .BRANCH_ALPHA
        TXA : AND.w #$003F : BNE .BRANCH_BETA
        
        LDA.b $30 : CLC : ADC.w #$0008 : STA.b $30
    CPX.w #$0100 : BNE .BRANCH_BETA
    
    LDA.w #$1000 : STA.b $30
    
    JSR $F879 ; $067879

    REP #$30

    LDX.w #$0000
    
    LDA.w #$F7DE : STA.b $30
    
    .BRANCH_DELTA
    
        TXA : AND.w #$0003 : TAY
        
        .BRANCH_GAMMA
        
            LDA ($30), Y : STA.w $1006, X
            
            INY #2
            
            INX #2
            
            TYA : AND.w #$0003 : BNE .BRANCH_GAMMA
        TXA : AND.w #$003F : BNE .BRANCH_DELTA
        
        TXA : AND.w #$0040 : LSR #4 : CLC : ADC.w #$F7DE : STA.b $30
    CPX.w #$0100 : BNE .BRANCH_DELTA
    
    LDA.w #$0000 : STA.b $30
    
    JSR $F879 ; $067879
    
    SEP #$30
    
    PLB
    
    RTS
}

; ==============================================================================

; $067879-$0678A6 LOCAL JUMP LOCATION
Attract_TriggerBGDMA:
{
    SEP #$10
    
    LDX.b #$07
    
    LDA.b $30 : STA.w $2116
    
    .nextTransfer
    
        LDY.b #$80 : STY.w $2115
        
        LDA.w #$1801 : STA.w $4300
        
        LDA.w #$1006 : STA.w $4302
        LDY.b #$00   : STY.w $4304
        
        LDA.w #$0100 : STA.w $4305
        
        LDY.b #$01 : STY.w $420B
    DEX : BPL .nextTransfer
    
    RTS
}

; ==============================================================================

; $0679B5-$0679E3 LOCAL JUMP LOCATION
Attract_DrawSpriteSet:
{
    ; Y - One less than the number of sprites to draw to OAM buffer.
    ; 
    ; $02 - Pointer to list of relative X coordinates for each sprite.
    ; $04 - Pointer to list of relative Y coordinates for each sprite.
    ; $06 - Pointer to list of character values for each sprite.
    ; $08 - Pointer to list of property values for each sprites (vhoopppc).
    ; 
    ; $2A - index into the second half of the OAM buffer. This index gets
    ; multiplied by 4 for the actual byte offset within that buffer.
    ; 
    ; $2D - Pointer to list of size bits and 9th X coordinate bits for each
    ; sprite.
    
    PHB : PHK : PLB
    
    .nextSprite
    
        LDX.b $2A
        
        LDA ($2D), Y : STA.w $0A60, X
        
        TXA : ASL #2 : TAX
        
        LDA ($02), Y : CLC : ADC.b $28 : STA.w $0900, X
        LDA ($04), Y : CLC : ADC.b $29 : STA.w $0901, X
        LDA ($06), Y                   : STA.w $0902, X
        LDA ($08), Y                   : STA.w $0903, X
        
        INC.b $2A
    DEY : BPL .nextSprite
    
    PLB
    
    RTS
}

; ==============================================================================

; $0679E4-$0679E7 DATA
Pool_Attract_DrawZelda:
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
    
    LDX.b $2A
    
    ; Both sprites are larger (16x16).
    LDA.b #$02 : STA.w $0A60, X
    
    TXA : ASL #2 : TAX
    
    ; X coordinates are fixed at 0x60?
    LDA.b #$60 : STA.w $0900, X
                 STA.w $0904, X
    
    ; Set Y coordinate of first sprite by input variable, and the second
    ; sprite is 10 pixels below it.
    LDA.b $28        : STA.w $0901, X
    CLC : ADC.b #$0A : STA.w $0905, X
    
    ; Set chr.
    LDA.l .head_chr : STA.w $0902, X
    LDA.l .body_chr : STA.w $0906, X
    
    ; Set properties.
    LDA.l .head_properties : STA.w $0903, X
    LDA.l .body_properties : STA.w $0907, X
    
    INC.b $2A : INC.b $2A
    
    RTS
}

; ==============================================================================

; $067A30-$067A86 LOCAL JUMP LOCATION
Attract_DrawKidnappedMaiden:
{
    PHB : PHK : PLB
    
    PHY
    
    LDX.b $2A
    
    LDA.b #$02
    
    LDY.b $40 : BEQ .BRANCH_ALPHA
        ORA.b #$01
    
    .BRANCH_ALPHA
    
    STA.w $0A60, X : STA.w $0A61, X
    
    TXA : ASL #2 : TAX
    
    LDA.b $28 : STA.w $0900, X : STA.w $0904, X
    
    LDA.b $32 : LSR #3 : AND.b #$01 : TAY
    
    LDA.b $29 : CLC : ADC.w $FA2A, Y : STA.w $0901, X
                CLC : ADC.w $FA2C, Y : STA.w $0905, X
    
    LDA.w $FA27    : STA.w $0902, X
    LDA.w $FA28, Y : STA.w $0906, X
    LDA.w $FA2E    : STA.w $0903, X
    LDA.w $FA2F    : STA.w $0907, X
    
    INC.b $2A : INC.b $2A
    
    PLY
    
    PLB
    
    RTS
}

; ==============================================================================

; $067A87-$067AA2 DATA
Attract_WindowingHDMA:
{
    ; $067A87
    .table_a
    db $20 : db $FF, $00
    db $50 : db $18, $E0
    db $50 : db $18, $E0
    db $01 : db $FF, $00
    db $00
    
    ; $067A94
    .table_b
    db $48 : db $FF, $00
    db $30 : db $30, $D8
    db $01 : db $FF, $00
    db $00
    
    ; Use direct hdma to write from A bus to registers $2126 and $2127,
    ; alternating on channel 6.
    ; $067A9E
    db $01
    db $26
    dl .table_a
}

; $067AA3-$067AC1 LOCAL JUMP LOCATION
Attract_SetupHdma:
{
    ; Note: This sets up the windowing via hdma for the legend sequence.
    
    LDX.b #$04
    
    .configLoop
    
        LDA.l $0CFA9E, X : STA.w $4360, X : STA.w $4370, X
    DEX : BPL .configLoop
    
    REP #$20
    
    ; I don't think they realized that this special casing actually lost
    ; bytes in the end. Using two 5 byte groups and an extra load uses 6
    ; bytes less.
    LDA.w #$FA94 : STA.w $4372
    
    SEP #$20
    
    ; Channel 7 will write to registers $2128 and $2129 (alternating).
    LDA.b #$28 : STA.w $4371
    
    RTS
}

; ==============================================================================

; $067AC2-$067B5E DATA
AttractImage0Stripes:
{
    ; $067AC2
    dw $6561, $2840 ; VRAM $C2CA | 42 bytes | Fixed horizontal
    dw $3500

    ; $067AC8
    dw $8561, $2840 ; VRAM $C30A | 42 bytes | Fixed horizontal
    dw $3510

    ; $067ACE
    dw $A561, $2900 ; VRAM $C34A | 42 bytes | Horizontal
    dw $3501, $3502, $3501, $3502, $3501, $3502, $3501, $3502
    dw $3501, $3103, $7103, $3502, $3501, $3502, $3501, $3502
    dw $3501, $3502, $3501, $3502, $3501

    ; $067AFC
    dw $C561, $2900 ; VRAM $C38A | 42 bytes | Horizontal
    dw $3511, $3512, $3511, $3512, $3511, $3512, $3511, $3512
    dw $3511, $3513, $7513, $3512, $3511, $3512, $3511, $3512
    dw $3511, $3512, $3511, $3512, $3511

    ; $067B2A
    dw $E561, $2900 ; VRAM $C3CA | 42 bytes | Horizontal
    dw $3520, $3521, $3520, $3521, $3520, $3521, $3520, $3521
    dw $3520, $3521, $3520, $3521, $3520, $3521, $3520, $3521
    dw $3520, $3521, $3520, $3521, $3520

    ; $067B58
    dw $0562, $2840 ; VRAM $C40A | 42 bytes | Fixed horizontal
    dw $B500

    ; $067B5E
    db $FF ; end of stripes data
}

; ==============================================================================

; $067B5F-$067C4B DATA
AttractImage1Stripes:
{
    ; $067B5F
    dw $6561, $2840 ; VRAM $C2CA | 42 bytes | Fixed horizontal
    dw $3500

    ; $067B65
    dw $8561, $1300 ; VRAM $C30A | 20 bytes | Horizontal
    dw $3510, $754E, $356E, $3510, $354E, $3510, $354C, $3510
    dw $754E, $3549

    ; $067B7D
    dw $8F61, $0840 ; VRAM $C31E | 10 bytes | Fixed horizontal
    dw $3510

    ; $067B83
    dw $9461, $0B00 ; VRAM $C328 | 12 bytes | Horizontal
    dw $754E, $356E, $3510, $354E, $3510, $354C

    ; $067B93
    dw $A561, $2900 ; VRAM $C34A | 42 bytes | Horizontal
    dw $755F, $755E, $357E, $357F, $355E, $355F, $354D, $755F
    dw $755E, $354A, $354B, $3510, $7549, $3510, $755F, $755E
    dw $357E, $357F, $355E, $355F, $354D

    ; $067BC1
    dw $C561, $2900 ; VRAM $C38A | 42 bytes | Horizontal
    dw $3550, $3551, $3552, $3553, $3554, $3555, $3556, $3557
    dw $3558, $3559, $355A, $355B, $355C, $355D, $3550, $3551
    dw $3552, $3553, $3554, $3555, $3556

    ; $067BEF
    dw $E561, $2900 ; VRAM $C3CA | 42 bytes | Horizontal
    dw $3560, $3561, $3562, $3563, $3564, $3565, $3566, $3567
    dw $3568, $3569, $356A, $356B, $356C, $356D, $3560, $3561
    dw $3562, $3563, $3564, $3565, $3566

    ; $067C1D
    dw $0562, $2900 ; VRAM $C40A | 42 bytes | Horizontal
    dw $3570, $3571, $3572, $3573, $3574, $3575, $3576, $3577
    dw $3578, $3579, $357A, $357B, $357C, $357D, $3570, $3571
    dw $3572, $3573, $3574, $3575, $3576

    ; $067C4B
    db $FF ; end of stripes data
}

; ==============================================================================

; $067C4C-$067D12 DATA
AttractImage2Stripes:
{
    ; $067C4C
    dw $6561, $2840 ; VRAM $C2CA | 42 bytes | Fixed horizontal
    dw $3500

    ; $067C52
    dw $8561, $2840 ; VRAM $C30A | 42 bytes | Fixed horizontal
    dw $3510

    ; $067C58
    dw $A561, $1D00 ; VRAM $C34A | 30 bytes | Horizontal
    dw $3522, $3523, $3510, $3522, $3523, $3510, $3522, $3523
    dw $3510, $3522, $3523, $3510, $7510, $7523, $7522

    ; $067C7A
    dw $B461, $0640 ; VRAM $C368 | 8 bytes | Fixed horizontal
    dw $3510

    ; $067C80
    dw $B861, $0300 ; VRAM $C370 | 4 bytes | Horizontal
    dw $7523, $7522

    ; $067C88
    dw $C561, $2900 ; VRAM $C38A | 42 bytes | Horizontal
    dw $3504, $3505, $3506, $3504, $3505, $3506, $3504, $3505
    dw $3506, $3504, $3505, $3506, $7506, $7505, $7504, $7510
    dw $7523, $7522, $7506, $7505, $7504

    ; $067CB6
    dw $E561, $2900 ; VRAM $C3CA | 42 bytes | Horizontal
    dw $3514, $3515, $3516, $3514, $3515, $3516, $3514, $3515
    dw $3516, $3514, $3515, $3516, $7516, $7515, $7514, $7506
    dw $7505, $7504, $7516, $7515, $7514

    ; $067CE4
    dw $0562, $2900 ; VRAM $C40A | 42 bytes | Horizontal
    dw $3524, $3525, $3526, $3524, $3525, $3526, $3524, $3525
    dw $3526, $3524, $3525, $3526, $7526, $7525, $7524, $7526
    dw $7525, $7524, $7526, $7525, $7524

    ; $067D13
    db $FF ; end of stripes data
}

; ==============================================================================

; $067D13-$067E1B DATA
AttractImage3Stripes:
{
    ; $067D13
    dw $6561, $2900 ; VRAM $C2CA | 42 bytes | Horizontal
    dw $3500, $3500, $351B, $3530, $3531, $3532, $3500, $3500
    dw $3500, $3533, $3541, $7541, $7533, $7500, $7500, $7500
    dw $7532, $7531, $7530, $751B, $7500

    ; $067D41
    dw $8561, $1E40 ; VRAM $C30A | 32 bytes | Fixed horizontal
    dw $3510

    ; $067D47
    dw $8661, $0900 ; VRAM $C30C | 10 bytes | Horizontal
    dw $3534, $350B, $3540, $3541, $3542

    ; $067D55
    dw $9561, $0900 ; VRAM $C32A | 10 bytes | Horizontal
    dw $7542, $7541, $7540, $750B, $7534

    ; $067D63
    dw $A561, $2900 ; VRAM $C34A | 42 bytes | Horizontal
    dw $3543, $3544, $3507, $3508, $3509, $350A, $3510, $350C
    dw $350D, $350E, $350F, $750F, $750E, $750D, $750C, $7510
    dw $750A, $7509, $7508, $7507, $7544

    ; $067D91
    dw $C561, $2900 ; VRAM $C38A | 42 bytes | Horizontal
    dw $3535, $3536, $3517, $3518, $3519, $351A, $3510, $351C
    dw $351D, $351E, $351F, $751F, $751E, $751D, $751C, $7510
    dw $751A, $7519, $7518, $7517, $7536

    ; $067DBF
    dw $E561, $2900 ; VRAM $C3CA | 42 bytes | Horizontal
    dw $3545, $3546, $3527, $3528, $3529, $352A, $352B, $352C
    dw $352D, $352E, $352F, $752F, $752E, $752D, $752C, $752B
    dw $752A, $7529, $7528, $7527, $7546

    ; $067DED
    dw $0562, $2900 ; VRAM $C40A | 42 bytes | Horizontal
    dw $3547, $3548, $3537, $3538, $3539, $353A, $353B, $353C
    dw $353D, $353E, $353F, $753F, $753E, $753D, $753C, $753B
    dw $753A, $7539, $7538, $7537, $7548

    ; $067E1B
    db $FF ; end of stripes data
}

; ==============================================================================
    
; $067E1C-$067E44 DATA
Pool_Intro_InitLogoSword:
{
    ; $067E1C
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

    ; $067E26
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

    ; $067E30
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

    ; $067E44
    db $00
}
    
; $067E45-$067EE8 LOCAL JUMP LOCATION
Intro_InitLogoSword:
{
    LDA.b #$07 : STA.b $CB
    
    STZ.b $CC
    STZ.b $CD
    
    REP #$20
    
    LDA.w #$FF7E : STA.b $C8
    
    SEP #$20
    
    ; $067E56 ALTERNATE ENTRY POINT
    .HandleLogoSword
    
    ; Draws sword and does screen flashing in intro.
    
    PHB : PHK : PLB
    
    LDA.b $CA : BEQ .BRANCH_1
        DEC.b $CA
    
    .BRANCH_1
    
    JSL Palette_BgAndFixedColor_justFixedColor
    
    LDA.w $0FF9 : BEQ .BRANCH_4
        AND.b #$03 : BEQ .BRANCH_3
            LDX.b $D0
            
            LDA.b $1F : ORA.b $9C, X : STA.b $9C, X
            
            DEX : CPX.b #$03 : BNE .BRANCH_2
                LDX.b #$00
            
            .BRANCH_2
            
            STX.b $D0
        
        .BRANCH_3
        
        DEC.w $0FF9
    
    .BRANCH_4

    .loop
    
        LDY.b #$09 : TYA : ASL #2 : TAX
        
        LDA.b #$02 : STA.w $0A72, Y
        
        LDA.w $FE1C, Y : STA.w $094A, X
        LDA.b #$21     : STA.w $094B, X
        LDA.w $FE26, Y : STA.w $0948, X
        
        PHY : TYA : ASL A : TAY
        
        REP #$20
        
        LDA.b $C8 : CLC : ADC.w $FE30, Y
        
        SEP #$20
        
        XBA : BEQ .BRANCH_5
            LDA.b #$F8 : XBA
        
        .BRANCH_5
        
        XBA : SEC : SBC.b #$08 : STA.w $0949, X
    PHY : DEY : BPL .loop
    
    REP #$20
    
    LDA.b $C8 : CMP.w $001E : BEQ .BRANCH_8
        LDY.b #$01
        
        CMP.w $FFBE : BEQ .BRANCH_6
            CMP.w $000E : BNE .BRANCH_7
                STZ.b $D0
                
                LDX.b #$20 : STX.w $0FF9
                
                LDY.b #$2C
            
        .BRANCH_6
        
        STY.w $012E
        
        .BRANCH_7
        
        CLC : ADC.w #$0010 : STA.b $C8
    
    .BRANCH_8
    
    SEP #$20
    
    LDX.b $CC
    
    JMP (.vectors, X)

    ; $067EE9
    .vectors
    dw $FEEF ; = $067EEF
    dw $FF13 ; = $067F13
    dw $FF51 ; = $067F51
}

; ==============================================================================

; $067EEF-$067F04 JUMP LOCATION
LogoSword_IdleState:
{
    LDA.w $0FF9 : BNE .BRANCH_1
        REP #$20
        
        LDA.b $C8 : CMP.w $001E : SEP #$20 : BNE .BRANCH_1
            INC.b $CC : INC.b $CC
    
    .BRANCH_1
    
    PLB ; RESTORES THE OLD DATA BANK.
    
    RTS
}

; $067F05-$067F12 DATA TABLE
Pool_LogoSword_EyeTwinkle:
{
    .timer
    db $04, $04, $06, $06, $06, $04, $04

    .char
    db $28, $37, $27, $36, $27, $37, $28
}

; $067F13-$067F48 JUMP LOCATION
LogoSword_EyeTwinkle:
{
    LDX.b $CB
    
    LDA.b $CA : BNE .BRANCH_2
        DEX : STX.b $CB : BPL .BRANCH_1
            STZ.b $CB
            
            LDA.b #$02 : STA.b $CA
            
            INC.b $CC : INC.b $CC
            
            BRA .BRANCH_3
        
        .BRANCH_1
        
        ; $067F05. SEE DATA TABLE ABOVE.
        LDA.w $FF05, X : STA.b $CA
    
    .BRANCH_2
    
    STZ.w $0A70
    
    LDA.b #$44 : STA.w $0940
    LDA.b #$43 : STA.w $0941
    
    LDA.b $25 : STA.w $0943
    
    LDA.w $FF0C, X : STA.w $0942
    
    .BRANCH_3
    
    PLB ; RESTORES THE OLD DATA BANK.
    
    RTS
}

; ==============================================================================

; $067F49-067F50 DATA
Pool_LogoSword_BladeShimmer:
{
    .char
    db $26, $20
    db $24, $34
    db $25, $20
    db $35, $20
}

; $067F51-$067FB0 JUMP LOCATION
LogoSword_BladeShimmer:
{
    LDX.b $CB : CPX.b #$07 : BCS .BRANCH_3
        STZ.w $0A70
        STZ.w $0A71
        
        LDA.b #$42 : STA.w $0940 : STA.w $0944
        
        LDA.b $CD : CMP.b #$50 : BCC .BRANCH_1
            LDA.b #$4F
        
        .BRANCH_1
        
        CLC : ADC.b #$C8 : CLC : ADC.b #$31 : STA.w $0941
        
        CLC : ADC.b #$08 : STA.w $0945
        
        LDA.b #$23 : STA.w $0943 : STA.w $0947
        
        LDA.w $FF49, X : STA.w $0942
        LDA.w $FF4A, X : STA.w $0946
        
        LDA.b $CA : BNE .BRANCH_3
            LDA.b $CD : CLC : ADC.b #$04 : STA.b $CD
            
            CMP.b #$04 : BEQ .BRANCH_2
            CMP.b #$48 : BEQ .BRANCH_2
            CMP.b #$4C : BEQ .BRANCH_2
                CMP.b #$58 : BNE .BRANCH_3
            
            .BRANCH_2
            
            INC.b $CB : INC.b $CB
    
    .BRANCH_3
    
    PLB
    
    RTS
}

; ==============================================================================

; $067FB1-$067FFF NULL
NULL_0CFFB1:
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
