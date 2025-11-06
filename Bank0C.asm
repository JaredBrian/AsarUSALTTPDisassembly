; ==============================================================================

; Bank 0x0C
; $060000-$067FFF
org $0C8000

; Overworld map data
; Title screen sequence
; Intro cutscene sequence
; 3D Triforce control
; File select menu control
; File select tilemap
; Copy menu control
; Copy menu tilemap

; ==============================================================================

; $060000-$0600D1 DATA
;org $0C8000
OverworldMap32_Screen62_High:
{
    incbin "bin/ow/screen62-h.bin" ; Size: 0x00D2
}

; $0600D2-$0601C3 DATA
;org $0C80D2
OverworldMap32_Screen62_Low:
{
    incbin "bin/ow/screen62-l.bin" ; Size: 0x00F2
}

; $0601C4-$060264 DATA
;org $0C81C4
OverworldMap32_Screen63_High:
{
    incbin "bin/ow/screen63-h.bin" ; Size: 0x00A1
}

; $060265-$060320 DATA
;org $0C8265
OverworldMap32_Screen63_Low:
{
    incbin "bin/ow/screen63-l.bin" ; Size: 0x00BC
}

; $060321-$0603E5 DATA
;org $0C8321
OverworldMap32_Screen64_High:
{
    incbin "bin/ow/screen64-h.bin" ; Size: 0x00C5
}

; $0603E6-$0604BC DATA
;org $0C83E6
OverworldMap32_Screen64_Low:
{
    incbin "bin/ow/screen64-l.bin" ; Size: 0x00D7
}

; $0604BD-$060597 DATA
;org $0C84BD
OverworldMap32_Screen25_High:
{
    incbin "bin/ow/screen25-h.bin" ; Size: 0x00DB
}

; $060598-$060687 DATA
;org $0C8598
OverworldMap32_Screen25_Low:
{
    incbin "bin/ow/screen25-l.bin" ; Size: 0x00F0
}

; $060688-$060733 DATA
;org $0C8688
OverworldMap32_Screen66_High:
{
    incbin "bin/ow/screen66-h.bin" ; Size: 0x00AC
}

; $060734-$06080C DATA
;org $0C8734
OverworldMap32_Screen66_Low:
{
    incbin "bin/ow/screen66-l.bin" ; Size: 0x00D9
}

; $06080D-$0608DC DATA
;org $0C880D
OverworldMap32_Screen67_High:
{
    incbin "bin/ow/screen67-h.bin" ; Size: 0x00D0
}

; $0608DD-$0609CB DATA
;org $0C88DD
OverworldMap32_Screen67_Low:
{
    incbin "bin/ow/screen67-l.bin" ; Size: 0x00EF
}

; $0609CC-$060AA3 DATA
;org $0C89CC
OverworldMap32_Screen68_High:
{
    incbin "bin/ow/screen68-h.bin" ; Size: 0x00D8
}

; $060AA4-$060B99 DATA
;org $0C8AA4
OverworldMap32_Screen68_Low:
{
    incbin "bin/ow/screen68-l.bin" ; Size: 0x00F6
}

; $060B9A-$060C72 DATA
;org $0C8B9A
OverworldMap32_Screen69_High:
{
    incbin "bin/ow/screen69-h.bin" ; Size: 0x00D9
}

; $060C73-$060D6B DATA
;org $0C8C73
OverworldMap32_Screen69_Low:
{
    incbin "bin/ow/screen69-l.bin" ; Size: 0x00F9
}

; $060D6C-$060E3A DATA
;org $0C8D6C
OverworldMap32_Screen2A_High:
{
    incbin "bin/ow/screen2A-h.bin" ; Size: 0x00CF
}

; $060E3B-$060F2A DATA
;org $0C8E3B
OverworldMap32_Screen2A_Low:
{
    incbin "bin/ow/screen2A-l.bin" ; Size: 0x00F0
}

; $060F2B-$06100B DATA
;org $0C8F2B
OverworldMap32_Screen2B_High:
{
    incbin "bin/ow/screen2B-h.bin" ; Size: 0x00E1
}

; $06100C-$061105 DATA
;org $0C900C
OverworldMap32_Screen2B_Low:
{
    incbin "bin/ow/screen2B-l.bin" ; Size: 0x00FA
}

; $061106-$0611F0 DATA
;org $0C9106
OverworldMap32_Screen2C_High:
{
    incbin "bin/ow/screen2C-h.bin" ; Size: 0x00EB
}

; $0611F1-$0612E7 DATA
;org $0C91F1
OverworldMap32_Screen2C_Low:
{
    incbin "bin/ow/screen2C-l.bin" ; Size: 0x00F7
}

; $0612E8-$0613D3 DATA
;org $0C92E8
OverworldMap32_Screen6D_High:
{
    incbin "bin/ow/screen6D-h.bin" ; Size: 0x00EC
}

; $0613D4-$0614CF DATA
;org $0C93D4
OverworldMap32_Screen6D_Low:
{
    incbin "bin/ow/screen6D-l.bin" ; Size: 0x00FC
}

; $0614D0-$0615C3 DATA
;org $0C94D0
OverworldMap32_Screen2E_High:
{
    incbin "bin/ow/screen2E-h.bin" ; Size: 0x00F4
}

; $0615C4-$0616BE DATA
;org $0C95C4
OverworldMap32_Screen2E_Low:
{
    incbin "bin/ow/screen2E-l.bin" ; Size: 0x00FB
}

; $0616BF-$0617B2 DATA
;org $0C96BF
OverworldMap32_Screen2F_High:
{
    incbin "bin/ow/screen2F-h.bin" ; Size: 0x00F4
}

; $0617B3-$0618AF DATA
;org $0C97B3
OverworldMap32_Screen2F_Low:
{
    incbin "bin/ow/screen2F-l.bin" ; Size: 0x00FD
}

; $0618B0-$06196D DATA
;org $0C98B0
OverworldMap32_Screen70_High:
{
    incbin "bin/ow/screen70-h.bin" ; Size: 0x00BE
}

; $06196E-$061A47 DATA
;org $0C996E
OverworldMap32_Screen70_Low:
{
    incbin "bin/ow/screen70-l.bin" ; Size: 0x00DA
}

; $061A48-$061AF3 DATA
;org $0C9A48
OverworldMap32_Screen71_High:
{
    incbin "bin/ow/screen71-h.bin" ; Size: 0x00AC
}

; $061AF4-$061BC1 DATA
;org $0C9AF4
OverworldMap32_Screen71_Low:
{
    incbin "bin/ow/screen71-l.bin" ; Size: 0x00CE
}

; $061BC2-$061CB2 DATA
;org $0C9BC2
OverworldMap32_Screen72_High:
{
    incbin "bin/ow/screen72-h.bin" ; Size: 0x00F1
}

; $061CB3-$061DAE DATA
;org $0C9CB3
OverworldMap32_Screen72_Low:
{
    incbin "bin/ow/screen72-l.bin" ; Size: 0x00FC
}

; $061DAF-$061E81 DATA
;org $0C9DAF
OverworldMap32_Screen33_High:
{
    incbin "bin/ow/screen33-h.bin" ; Size: 0x00D3
}

; $061E82-$061F72 DATA
;org $0C9E82
OverworldMap32_Screen33_Low:
{
    incbin "bin/ow/screen33-l.bin" ; Size: 0x00F1
}

; $061F73-$062048 DATA
;org $0C9F73
OverworldMap32_Screen34_High:
{
    incbin "bin/ow/screen34-h.bin" ; Size: 0x00D6
}

; $062049-$062131 DATA
;org $0CA049
OverworldMap32_Screen34_Low:
{
    incbin "bin/ow/screen34-l.bin" ; Size: 0x00E9
}

; $062132-$062225 DATA
;org $0CA132
OverworldMap32_Screen75_High:
{
    incbin "bin/ow/screen75-h.bin" ; Size: 0x00F4
}

; $062226-$062328 DATA
;org $0CA226
OverworldMap32_Screen75_Low:
{
    incbin "bin/ow/screen75-l.bin" ; Size: 0x0103
}

; $062329-$0623DB DATA
;org $0CA329
OverworldMap32_Screen76_High:
{
    incbin "bin/ow/screen76-h.bin" ; Size: 0x00B3
}

; $0623DC-$0624B9 DATA
;org $0CA3DC
OverworldMap32_Screen76_Low:
{
    incbin "bin/ow/screen76-l.bin" ; Size: 0x00DE
}

; $0624BA-$0625B2 DATA
;org $0CA4BA
OverworldMap32_Screen37_High:
{
    incbin "bin/ow/screen37-h.bin" ; Size: 0x00F9
}

; $0625B3-$0626B1 DATA
;org $0CA5B3
OverworldMap32_Screen37_Low:
{
    incbin "bin/ow/screen37-l.bin" ; Size: 0x00FF
}

; $0626B2-$062798 DATA
;org $0CA6B2
OverworldMap32_Screen78_High:
{
    incbin "bin/ow/screen78-h.bin" ; Size: 0x00E7
}

; $062799-$062897 DATA
;org $0CA799
OverworldMap32_Screen78_Low:
{
    incbin "bin/ow/screen78-l.bin" ; Size: 0x00FF
}

; $062898-$062970 DATA
;org $0CA898
OverworldMap32_Screen79_High:
{
    incbin "bin/ow/screen79-h.bin" ; Size: 0x00D9
}

; $062971-$062A6C DATA
;org $0CA971
OverworldMap32_Screen79_Low:
{
    incbin "bin/ow/screen79-l.bin" ; Size: 0x00FC
}

; $062A6D-$062B63 DATA
;org $0CAA6D
OverworldMap32_Screen7A_High:
{
    incbin "bin/ow/screen7A-h.bin" ; Size: 0x00F7
}

; $062B64-$062C5E DATA
;org $0CAB64
OverworldMap32_Screen7A_Low:
{
    incbin "bin/ow/screen7A-l.bin" ; Size: 0x00FB
}

; $062C5F-$062D49 DATA
;org $0CAC5F
OverworldMap32_Screen3B_High:
{
    incbin "bin/ow/screen3B-h.bin" ; Size: 0x00EB
}

; $062D4A-$062E36 DATA
;org $0CAD4A
OverworldMap32_Screen3B_Low:
{
    incbin "bin/ow/screen3B-l.bin" ; Size: 0x00ED
}

; $062E37-$062F23 DATA
;org $0CAE37
OverworldMap32_Screen3C_High:
{
    incbin "bin/ow/screen3C-h.bin" ; Size: 0x00ED
}

; $062F24-$063015 DATA
;org $0CAF24
OverworldMap32_Screen3C_Low:
{
    incbin "bin/ow/screen3C-l.bin" ; Size: 0x00F2
}

; $063016-$06310B DATA
;org $0CB016
OverworldMap32_Screen7D_High:
{
    incbin "bin/ow/screen7D-h.bin" ; Size: 0x00F6
}

; $06310C-$06320A DATA
;org $0CB10C
OverworldMap32_Screen7D_Low:
{
    incbin "bin/ow/screen7D-l.bin" ; Size: 0x00FF
}

; $06320B-$0632E5 DATA
;org $0CB20B
OverworldMap32_Screen7E_High:
{
    incbin "bin/ow/screen7E-h.bin" ; Size: 0x00DB
}

; $0632E6-$0633D1 DATA
;org $0CB2E6
OverworldMap32_Screen7E_Low:
{
    incbin "bin/ow/screen7E-l.bin" ; Size: 0x00EC
}

; $0633D2-$0634C7 DATA
;org $0CB3D2
OverworldMap32_Screen3F_High:
{
    incbin "bin/ow/screen3F-h.bin" ; Size: 0x00F6
}

; $0634C8-$0635C7 DATA
;org $0CB4C8
OverworldMap32_Screen3F_Low:
{
    incbin "bin/ow/screen3F-l.bin" ; Size: 0x0100
}

; $0635C8-$0635CB DATA
;org $0CB5C8
OverworldMap32_Screen9E_High:
{
    incbin "bin/ow/screen9E-h.bin" ; Size: 0x0004
}

; $0635CC-$06367A DATA
;org $0CB5CC
OverworldMap32_Screen9E_Low:
{
    incbin "bin/ow/screen9E-l.bin" ; Size: 0x00AF
}

; $06367B-$06367E DATA
;org $0CB67B
OverworldMap32_Screen97_High:
{
    incbin "bin/ow/screen97-h.bin" ; Size: 0x0004
}

; $06367F-$0636BD DATA
;org $0CB67F
OverworldMap32_Screen97_Low:
{
    incbin "bin/ow/screen97-l.bin" ; Size: 0x003F
}

; $0636BE-$063742 DATA
;org $0CB6BE
OverworldMap32_Screen9F_High:
{
    incbin "bin/ow/screen9F-h.bin" ; Size: 0x0085
}

; $063743-$06383B DATA
;org $0CB743
OverworldMap32_Screen9F_Low:
{
    incbin "bin/ow/screen9F-l.bin" ; Size: 0x00F9
}

; $06383C-$0638AB DATA
;org $0CB83C
OverworldMap32_Screen80_High:
{
    incbin "bin/ow/screen80-h.bin" ; Size: 0x0070
}

; $0638AC-$06397B DATA
;org $0CB8AC
OverworldMap32_Screen80_Low:
{
    incbin "bin/ow/screen80-l.bin" ; Size: 0x00D0
}

; $06397C-$063A15 DATA
;org $0CB97C
OverworldMap32_Screen81_High:
{
    incbin "bin/ow/screen81-h.bin" ; Size: 0x009A
}

; $063A16-$063AF1 DATA
;org $0CBA16
OverworldMap32_Screen81_Low:
{
    incbin "bin/ow/screen81-l.bin" ; Size: 0x00DC
}

; $063AF2-$063BB8 DATA
;org $0CBAF2
OverworldMap32_Screen82_High:
{
    incbin "bin/ow/screen82-h.bin" ; Size: 0x00C7
}

; $063BB9-$063CAD DATA
;org $0CBBB9
OverworldMap32_Screen82_Low:
{
    incbin "bin/ow/screen82-l.bin" ; Size: 0x00F5
}

; $063CAE-$063D5D DATA
;org $0CBCAE
OverworldMap32_Screen89_High:
{
    incbin "bin/ow/screen89-h.bin" ; Size: 0x00B0
}

; $063D5E-$063E4A DATA
;org $0CBD5E
OverworldMap32_Screen89_Low:
{
    incbin "bin/ow/screen89-l.bin" ; Size: 0x00ED
}

; $063E4B-$063F04 DATA
;org $0CBE4B
OverworldMap32_Screen8A_High:
{
    incbin "bin/ow/screen8A-h.bin" ; Size: 0x00BA
}

; $063F05-$063FD6 DATA
;org $0CBF05
OverworldMap32_Screen8A_Low:
{
    incbin "bin/ow/screen8A-l.bin" ; Size: 0x00D2
}

; $063FD7-$063FDD DATA
;org $0CBFD7
OverworldMap32_Screen96_High:
{
    incbin "bin/ow/screen96-h.bin" ; Size: 0x0007
}

; $063FDE-$063FF9 DATA
;org $0CBFDE
OverworldMap32_Screen96_Low:
{
    incbin "bin/ow/screen96-l.bin" ; Size: 0x001C
}

; $063FFA-$064043 DATA
;org $0CBFFA
OverworldMap32_Screen95_High:
{
    incbin "bin/ow/screen95-h.bin" ; Size: 0x004A
}

; $064044-$0640AB DATA
;org $0CC044
OverworldMap32_Screen95_Low:
{
    incbin "bin/ow/screen95-l.bin" ; Size: 0x0068
}

; $0640AC-$0640AF DATA
;org $0CC0AC
OverworldMap32_Screen9C_High:
{
    incbin "bin/ow/screen9C-h.bin" ; Size: 0x0004
}

; $0640B0-$0640B3 DATA
;org $0CC0B0
OverworldMap32_Screen9C_Low:
{
    incbin "bin/ow/screen9C-l.bin" ; Size: 0x0004
}

; $0640B4-$0640B7 DATA
;org $0CC0B4
OverworldMap32_Screen88_High:
{
    incbin "bin/ow/screen88-h.bin" ; Size: 0x0004
}

; $0640B8-$06410A DATA
;org $0CC0B8
OverworldMap32_Screen88_Low:
{
    incbin "bin/ow/screen88-l.bin" ; Size: 0x0054
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

; Beginning of Module 0x00: Triforce / Zelda startup screens
; $064120-$06415C JUMP LOCATION
Module_Intro:
{
    LDA.b $11 : CMP.b #$08 : BCC .dontCheckInput
        LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ .noPressedButtons
            ; If ABXY, or Start is pressed, then go to the file selection
            ; menu module.
            JMP.w FadeMusicAndResetSRAMMirror
        
        .noPressedButtons
    .dontCheckInput
    
    ; Otherwise, branch to the appropriate part of the intro.
    LDA.b $11
    JSL.l UseImplicitRegIndexedLongJumpTable
    dl Intro_Init                        ; 0x00 - $0CC15D Blank Screen
    dl Intro_Init_justLogo               ; 0x01 - $0CC170 -Nintendo presents-
    dl Intro_InitGfx                     ; 0x02 - $0CC33C Sets up myriad graphics
                                         ;        settings
    dl Intro_HandleAllTriforceAnimations ; 0x03 - $0CC404 Copyright Nintendo 1992
    dl Intro_HandleAllTriforceAnimations ; 0x04 - $0CC404 Triforces swooping in
    dl Intro_FadeLogoIn                  ; 0x05 - $0CC25C "Zelda" logo fade in
    dl Intro_SwordStab                   ; 0x06 - $0CC2AE Sword coming down...
    dl Intro_PopSubtitleCard             ; 0x07 - $0CC284 Fades in bg, Zelda Symbol
                                         ;        is sparkling, looking pretty
    dl Intro_TrianglesBeforeAttract      ; 0x08 - $0CC2D4 Wait to see if the player
                                         ;        does anything
    dl Intro_HandleAllTriforceAnimations ; 0x09 - $0CC404 This one and the next 2
                                         ;        are unused
    dl Intro_InitGfx                     ; 0x0A - $0CC33C
    dl Intro_HandleAllTriforceAnimations ; 0x0B - $0CC404
}

; ==============================================================================

; $06415D-$06419F JUMP LOCATION
Intro_Init:
{
    JSL.l Intro_SetupScreen
    
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
    
    ; Sets up sprite information for the N-logo.
    ; (OAM buffer is refreshed every frame, so this must be repeatedly called.)
    JSR.w Intro_DisplayNintendoLogo
    
    ; As long as $B0 is less than 0xB, no branch occurs.
    LDA.b $B0 : INC.b $B0 : CMP.b #$0B : BCS Intro_LoadTitleGraphics
        JSL.l UseImplicitRegIndexedLongJumpTable
        dl Intro_InitWram                    ; 0x00 - $0CC1A0
        dl Intro_InitWram                    ; 0x01 - $0CC1A0
        dl Intro_InitWram                    ; 0x02 - $0CC1A0
        dl Intro_InitWram                    ; 0x03 - $0CC1A0
        dl Intro_InitWram                    ; 0x04 - $0CC1A0
        dl Intro_InitWram                    ; 0x05 - $0CC1A0
        dl Intro_InitWram                    ; 0x06 - $0CC1A0
        dl Intro_InitWram                    ; 0x07 - $0CC1A0
        dl Intro_LoadTextPointersAndPalettes ; 0x08 - $028116
        dl LoadItemGFXIntoWRAM4BPPBuffer     ; 0x09 - $00D231
        dl Tagalong_LoadGfx                  ; 0x0A - $00D423
}

; ==============================================================================

; Zerores out a 0x400 byte chunk of WRAM.
; $0641A0-$0641F4 JUMP LOCATION
Intro_InitWram:
{
    REP #$30
    
    ; $C8 is the Upper Bound, $CA stores the Lower Bound.
    LDX.b $C8
    
    LDA.w #$0000
    
    .zeroLoop
    
        ; Erases $7E0000-$7FFFF (all work WRAM).
        STA.l $7E2000, X : STA.l $7E4000, X
        STA.l $7E6000, X : STA.l $7E8000, X
        STA.l $7EA000, X : STA.l $7EC000, X
        STA.l $7EE000, X : STA.l $7F0000, X
        STA.l $7F2000, X : STA.l $7F4000, X
        STA.l $7F6000, X : STA.l $7F8000, X
        STA.l $7FA000, X : STA.l $7FC000, X
        STA.l $7FE000, X
    DEX : DEX : CPX.b $CA : BNE .zeroLoop
    
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
        
        JSL.l EnableForceBlank
        JSL.l VRAM_EraseTilemaps_normal
        
        LDA.b #$02 : STA.w SNES.OAMSizeAndDataDes
        
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
        JSL.l LoadDefaultGfx
        JSL.l InitTileSets
        
        LDY.b #$5D
        JSL.l DecompDungAnimatedTiles
        
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
    JSL.l Intro_HandleAllTriforceAnimations
    
    LDA.b $1A : LSR : BCC .evenFrame
        JSL.l IntroLogoPaletteFadeIn
        
        LDA.l $7EC007 : BNE .BRANCH_2
            LDA.b #$2A : STA.b $B0
            
            INC.b $11
            
            JSR.w Intro_InitLogoSword
    
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
    JSR.w Intro_InitLogoSword_HandleLogoSword
    JSL.l Intro_HandleAllTriforceAnimations
    
    LDA.l $7EC007 : BEQ .alpha
        LDA.b $1A : LSR : BCC .dontAdvanceYet
            JML.l IntroLogoPaletteFadeIn_IntroTitleCardPaletteFadeIn
    
    .alpha
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$D0 : BEQ .waitForButtonPress
        JMP.w FadeMusicAndResetSRAMMirror
    
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
    JSL.l Intro_HandleAllTriforceAnimations
    
    STZ.w $1F00
    STZ.w $012A
    
    JSR.w Intro_InitLogoSword_HandleLogoSword
    
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
    JSL.l Intro_HandleAllTriforceAnimations
    
    STZ.w $1F00
    STZ.w $012A
    
    JSR.w Intro_InitLogoSword_HandleLogoSword
    
    DEC.b $B0 : BNE .BRANCH_1
        ; Note that this instruction does nothing since $11 is zeroed out a few
        ; lines down. programmers aren't perfect!
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
    
    JSL.l Palette_BgAndFixedColor_justFixedColor
    
    REP #$30
    
    LDX.w #$006E
    
    .loop
    
        ; Zeroes out $20-$8E.
        STZ.b $20, X
    DEX : DEX : BPL .loop
    
    LDX.w #$0000 : TXA
    
    .initSramBuffer
    
        ; Clear the save memory area.
        STA.l $7EF000, X : STA.l $7EF100, X
        STA.l $7EF200, X : STA.l $7EF300, X
        STA.l $7EF400, X
    INX : INX : CPX.w #$0100 : BNE .initSramBuffer
    
    SEP #$30
    
    ; Go to select screen mode.
    LDA.b #$01 : STA.b $10
                 STA.w $04AA
    
    STZ.b $11
    
    RTL
}

; ==============================================================================

; Module 0x00.0x02, 0x00.0x0A
; $06433C-$06436E JUMP LOCATION
Intro_InitGfx:
{
    ; Set misc. sprite graphics.
    LDA.b #$08 : STA.w $0AA4
    
    JSL.l Graphics_LoadCommonSprLong
    JSR.w TriforceInitializePolyhedralModule
    
    LDA.b #$01 : STA.w $1E10
                 STA.w $1E11
                 STA.w $1E12

    LDA.b #$00 : STA.w $1E18
                 STA.w $1E19
                 STA.w $1E1A
    
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
    JSL.l Polyhedral_InitThread
    JSR.w LoadTriforceSpritePalette
    
    ; Set vertical IRQ trigger scanline.
    LDA.b #$90 : STA.b $FF
    
    LDA.b #$FF : STA.w $1F02

    LDA.b #$20 : STA.w $1F06
                 STA.w $1F07
                 STA.w $1F08

    LDA.b #$A0 : STA.w $1F04
    LDA.b #$60 : STA.w $1F05

    LDA.b #$01 : STA.w $1F01
                 STA.w $1F03
                 STA.w $012A
                 STA.w $1F00
    
    ; Initialize WRAM for starting Module 0x00.
    LDX.b #$0F
    
    .loop
    
        STZ.w $1E00, X : STZ.w $1E10, X
        STZ.w $1E20, X : STZ.w $1E30, X
        STZ.w $1E40, X : STZ.w $1E50, X
        STZ.w $1E60, X
    DEX : BPL .loop
    
    RTS
}

; ==============================================================================

; OPTIMIZE: The guy who wrote this routine had never heard of MVN or MVP
; apparently or DMA, for that matter. This routine writes a fixed set of colors
; to SP-6 (first half).
; $0643BD-$064403 LOCAL
LoadTriforceSpritePalette:
{
    REP #$20
    
    LDA.l Palettes_Triforce+$00 : STA.l $7EC6A0
    LDA.l Palettes_Triforce+$02 : STA.l $7EC6A2
    LDA.l Palettes_Triforce+$04 : STA.l $7EC6A4
    LDA.l Palettes_Triforce+$06 : STA.l $7EC6A6
    LDA.l Palettes_Triforce+$08 : STA.l $7EC6A8
    LDA.l Palettes_Triforce+$0A : STA.l $7EC6AA
    LDA.l Palettes_Triforce+$0C : STA.l $7EC6AC
    LDA.l Palettes_Triforce+$0E : STA.l $7EC6AE
    
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
    
    JSR.w Intro_AnimateTriforce
    JSR.w Scene_AnimateEverySprite
    
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
    
        JSR.w Scene_AnimateSingleSprite
    DEX : BPL .loop
    
    RTS
}

; ==============================================================================

; FOR USE WITH $0643BD
; $064425-$064434 DATA
Palettes_Triforce:
{
    dw $0000, $014D, $01B0, $01F3, $0256, $0279, $02FD, $035F
}

; ==============================================================================

; $064435-$064447 LOCAL JUMP LOCATION
Intro_AnimateTriforce:
{
    LDA.b #$01 : STA.w $012A
    
    ; Is this some sort of "IRQ busy" flag?
    LDA.w $1F00 : BNE .waitForTriforceThread
        JSR.w Intro_AnimateTriforceDanceMoves
        
        LDA.b #$01 : STA.w $1F00
    
    .waitForTriforceThread
    
    RTS
}

; ==============================================================================

; $064448-$06445A LOCAL JUMP LOCATION
Intro_AnimateTriforceDanceMoves:
{
    LDA.w $1E00
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Intro_TriforceTinyDancers   ; 0x00 - $C45B
    dw Intro_TriforceSpinInwards   ; 0x01 - $C47B
    dw Intro_TriforceNearingMerge  ; 0x02 - $C4BA
    dw Intro_MergeTriforceSpin     ; 0x03 - $C4D6
    dw Intro_TriforceTerminateSpin ; 0x04 - $C500
    dw Intro_TriforceDoNothing     ; 0x05 - $C533
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
    RTS
}

; $064534-$064542 LOCAL JUMP LOCATION
Scene_AnimateSingleSprite:
{
    LDA.w $1E10, X : BEQ .exit
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw .exit                 ; 0x00 - $C543
        dw InitializeSceneSprite ; 0x01 - $C544
        dw AnimateSceneSprite    ; 0x02 - $C55B
    
    ; $064543 ALTERNATE ENTRY POINT
    .exit
    
    RTS
}

; $064544-$06455A JUMP LOCATION
InitializeSceneSprite:
{
    LDA.w $1E18, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw InitializeSceneSprite_Triangle             ; 0x00 - $C57E
    dw SceneSprite_TitleCard                      ; 0x01 - $C84F
    dw InitializeSceneSprite_Copyright            ; 0x02 - $C850
    dw InitializeSceneSprite_Sparkle              ; 0x03 - $C8E2
    dw InitializeSceneSprite_TriforceRoomTriangle ; 0x04 - $CBE8
    dw InitializeSceneSprite_TriforceRoomTriangle ; 0x05 - $CBE8
    dw InitializeSceneSprite_TriforceRoomTriangle ; 0x06 - $CBE8
    dw InitializeSceneSprite_CreditsTriangle      ; 0x07 - $CD19
}

; $06455B-$064571 JUMP LOCATION
AnimateSceneSprite:
{
    LDA.w $1E18, X
    JSR.w UseImplicitRegIndexedLocalJumpTable
    dw AnimateSceneSprite_Triangle             ; 0x00 - $C5B1
    dw SceneSprite_TitleCard                   ; 0x01 - $C84F
    dw AnimateSceneSprite_Copyright            ; 0x02 - $C864
    dw AnimateSceneSprite_Sparkle              ; 0x03 - $C90D
    dw AnimateSceneSprite_TriforceRoomTriangle ; 0x04 - $CC13
    dw AnimateSceneSprite_TriforceRoomTriangle ; 0x05 - $CC13
    dw AnimateSceneSprite_TriforceRoomTriangle ; 0x06 - $CC13
    dw AnimateSceneSprite_CreditsTriangle      ; 0x07 - $CD3E
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
    LDA.w Pool_InitializeSceneSprite_Triangle_pos_x_start+0, Y : STA.w $1E30, X
    LDA.w Pool_InitializeSceneSprite_Triangle_pos_x_start+1, Y : STA.w $1E38, X
    LDA.w Pool_InitializeSceneSprite_Triangle_pos_y_start+0, Y : STA.w $1E48, X
    LDA.w Pool_InitializeSceneSprite_Triangle_pos_y_start+1, Y : STA.w $1E50, X
    
    LDA.w IntroTriangleSpeedX, X : CLC : ADC.w $1E58, X : STA.w $1E58, X
    LDA.w IntroTriangleSpeedY, X : CLC : ADC.w $1E60, X : STA.w $1E60, X
    
    INC.w $1E10, X
    
    RTS
}

; $0645B1-$0645C9 JUMP LOCATION
AnimateSceneSprite_Triangle:
{
    JSR.w AnimateSceneSprite_DrawTriangle
    JSR.w AnimateSceneSprite_MoveTriangle
    
    LDA.w $1E00
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw IntroTriangle_MoveIntoPlace ; 0x00 - $C5D6
    dw IntroTriangle_MoveIntoPlace ; 0x01 - $C5D6
    dw IntroTriangle_MoveIntoPlace ; 0x02 - $C5D6
    dw IntroTriangle_MoveIntoPlace ; 0x03 - $C5D6
    dw IntroTriangle_MoveIntoPlace ; 0x04 - $C5D6
    dw IntroTriangle_StopMoving    ; 0x05 - $C608
}

; $0645CA-$0645CC DATA
IntroTriangleSpeedX:
{
    ; USED WITH $0645D6
    db   1
    db   0
    db  -1
}

; $0645CD-$0645CF DATA
IntroTriangleSpeedY:
{
    db  -1
    db   1
    db  -1
}

; $0645D0-$0645D5 DATA
Pool_IntroTriangle_MoveIntoPlace:
{
    ; $0645D0
    .target_x
    db $4B
    db $5F
    db $75

    ; $0645D3
    .target_y
    db $58
    db $30
    db $58
}

; $0645D6-$064607 JUMP LOCATION
IntroTriangle_MoveIntoPlace:
{
    LDA.w $1E0A : AND.b #$1F : BNE .BRANCH_1
        LDA.w IntroTriangleSpeedX, X : CLC : ADC.w $1E58, X : STA.w $1E58, X
        LDA.w IntroTriangleSpeedY, X : CLC : ADC.w $1E60, X : STA.w $1E60, X
        
    .BRANCH_1
    
    LDA.w Pool_IntroTriangle_MoveIntoPlace_target_x, X : CMP.w $1E30, X : BNE .BRANCH_2
        STZ.w $1E58, X
    
    .BRANCH_2
    
    LDA.w Pool_IntroTriangle_MoveIntoPlace_target_y, X : CMP.w $1E48, X : BNE .BRANCH_3
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
    LDA.b #$C6 : STA.b $09
    
    .BRANCH_2
    
    JSR.w AnimateSceneSprite_AddObjectsToOAMBuffer
    
    RTS
}

; $06482F-$06484E LOCAL JUMP LOCATION
AnimateSceneSprite_DrawTriforceRoomTriangle:
{
    LDA.b #$10 : STA.b $06
                 STZ.b $07
    
    CPX.b #$02 : BEQ .BRANCH_1
        LDA.b #$2F : STA.b $08
        LDA.b #$C7 : STA.b $09
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.b #$AF : STA.b $08
    LDA.b #$C7 : STA.b $09
    
    .BRANCH_2
    
    JSR.w AnimateSceneSprite_AddObjectsToOAMBuffer
    
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
    ; Set the starting X position for the draw.
    LDA.b #$4C : STA.w $1E30, X
    
    STZ.w $1E38, X
    
    ; Set the starting Y position for the draw.
    LDA.b #$B8 : STA.w $1E48, X
    
    STZ.w $1E50, X
    
    INC.w $1E10, X
    
    RTS
}

; $064864-$064867 JUMP LOCATION
AnimateSceneSprite_Copyright:
{
    JSR.w AnimateSceneSprite_DrawCopyright
    
    RTS
}

; $064868-$0648CF DATA
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
    ; Set the amount of tiles to be drawn.
    LDA.b #$0D : STA.b $06
                 STZ.b $07

    LDA.b #groups    : STA.b $08
    LDA.b #groups>>8 : STA.b $09
    
    JSR.w AnimateSceneSprite_AddObjectsToOAMBuffer
    
    RTS
}

; $0648E2-$0648FC JUMP LOCATION
InitializeSceneSprite_Sparkle:
{
    LDA.w $1E0A : LSR #5 : AND.b #$03 : TAY
    LDA.w Pool_AnimateSceneSprite_Sparkle_position_x, Y : STA.w $1E30, X
    LDA.w Pool_AnimateSceneSprite_Sparkle_position_y, Y : STA.w $1E48, X
    
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
    JSR.w AnimateSceneSprite_DrawSparkle
    
    LDA.w $1E0A : LSR : LSR : AND.b #$03 : TAY
    LDA.w Pool_AnimateSceneSprite_Sparkle_position_x, Y : STA.w $1E30, X
    LDA.w Pool_AnimateSceneSprite_Sparkle_position_y, Y : STA.w $1E48, X
    
    RTS
}

; $064936-$064955 DATA
AnimateSceneSprite_DrawSparkle_groups:
{
    dw   0,   0 : db $80, $34, $00, $00
    dw   0,   0 : db $B7, $34, $00, $00
    dw  -4,  -3 : db $64, $38, $00, $02
    dw  -4,  -3 : db $62, $34, $00, $02
}

; $064956-$064971 LOCAL JUMP LOCATION
AnimateSceneSprite_DrawSparkle:
{
    LDA.b #$01 : STA.b $06
                 STZ.b $07
    
    LDA.w $1E20, X : BMI .BRANCH_1
        ASL #3 : ADC.b #groups : STA.b $08
        
        ; TODO: Add 0?
        LDA.b #.groups>>8 : ADC.b #$00 : STA.b $09
        
        JSR.w AnimateSceneSprite_AddObjectsToOAMBuffer
    
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
    
    LDA.b $06 : ASL : ASL : ADC.w $1E08 : STA.w $1E08
    
    .nextSprite
    
        LDA.b ($08), Y : CLC : ADC.b $00 : STA.w $0000, X
        AND.w #$0100                     : STA.b $0C
        
        INY
        INY
        LDA.b ($08), Y : CLC : ADC.b $02 : STA.w $0001, X
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .y_in_range
            LDA.w #$00F0 : STA.w $0001, X
        
        .y_in_range
        
        INY
        INY
        LDA.b ($08), Y : EOR.b $04 : STA.w $0002, X
        
        PHX
        
        TXA : SEC : SBC.w #$0800 : LSR : LSR : TAX
        
        SEP #$20
        
        INY #3
        LDA.b ($08), Y : ORA.b $0D : STA.w $0A20, X
        
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
        ; off the stack and we will end up at the sub that called this Sub's
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
    
    JSL.l Graphics_LoadCommonSprLong
    JSR.w TriforceInitializePolyhedralModule
    
    LDA.b #$01 : STA.w $1E10
                 STA.w $1E11
                 STA.w $1E12

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
    
    JSL.l Graphics_LoadCommonSprLong

    ; MAKES SURE THE TRIFORCES ARE SET UP.
    JSR.w TriforceInitializePolyhedralModule
    
    STZ.w $1F02
    
    LDA.b #$01 : STA.w $1E10
                 STA.w $1E11
                 STA.w $1E12

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
    
    JSR.w AdvancePolyhedral_do_advance
    JSR.w Scene_AnimateEverySprite
    
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
        JSR.w AdvancePolyhedral_run_sub
        
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
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw IntroPolyhedral_StartUp                ; 0x00 - $CAE9
    dw IntroPolyhedral_StartUp_MoveGrowRotate ; 0x01 - $CAFE
    dw IntroPolyhedral_MoveRotate             ; 0x02 - $CB1F
    dw IntroPolyhedral_LockIntoPlace          ; 0x03 - $CB84
    dw IntroPolyhedral_LockIntoPlace_exit     ; 0x04 - $CBA1
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
    
    LDA.w $1E01 : BNE .exit
        LDA.l Palettes_Triforce+$0E : STA.l $7EC6AE
        LDA.l Palettes_Triforce+$0F : STA.l $7EC6AF
        
        INC.b $15
        
        INC.w $1E00

    ; $064BA1 ALTERNATE ENTRY POINT
    .exit

    RTS
}

; ==============================================================================

; $064BA2-$064BAF LONG JUMP LOCATION
Credits_AnimateTheTriangles:
{
    PHB : PHK : PLB
    
    INC.w $1E0A
    
    JSR.w CreditsTriangle_HandleRotation
    JSR.w Scene_AnimateEverySprite
    
    PLB
    
    RTL
}

; ==============================================================================

; $064BB0-$064BC2 LOCAL JUMP LOCATION
CreditsTriangle_HandleRotation:
{
    LDA.b #$01 : STA.w $012A
    
    LDA.w $1F00 : BNE .BRANCH_ALPHA
        JSR.w CreditsTriangle_ApplyRotation
        
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
    TXA : ASL : TAY
    
    LDA.w Pool_InitializeSceneSprite_TriforceRoomTriangle_position_x+0, Y
    STA.w $1E30, X

    LDA.w Pool_InitializeSceneSprite_TriforceRoomTriangle_position_x+1, Y
    STA.w $1E38, Y

    LDA.w Pool_InitializeSceneSprite_TriforceRoomTriangle_position_y+0, Y
    STA.w $1E48, X

    LDA.w Pool_InitializeSceneSprite_TriforceRoomTriangle_position_y+1, Y
    STA.w $1E50, X

    LDA.w Pool_InitializeSceneSprite_TriforceRoomTriangle_speed_x, X
    STA.w $1E58, X

    LDA.w Pool_InitializeSceneSprite_TriforceRoomTriangle_speed_y, X
    STA.w $1E60, X
    
    INC.w $1E10, X
    
    RTS
}

; ==============================================================================

; $064C13-$064C2C JUMP LOCATION
AnimateSceneSprite_TriforceRoomTriangle:
{
    JSR.w AnimateSceneSprite_DrawTriforceRoomTriangle
    JSR.w AnimateSceneSprite_TerminateTriangle
    JSR.w AnimateSceneSprite_MoveTriangle
    
    LDA.w $1E00
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw AnimateTriforceRoomTriangle_Expand        ; 0x00 - $CC33
    dw AnimateTriforceRoomTriangle_RotateInPlace ; 0x01 - $CC56
    dw AnimateTriforceRoomTriangle_Contract      ; 0x02 - $CC6B
    dw AnimateTriforceRoomTriangle_Stopped       ; 0x03 - $CC8F
    dw AnimateTriforceRoomTriangle_Stopped       ; 0x04 - $CC8F
}

; ==============================================================================

; $064C2D-$064C32 DATA
Pool_AnimateTriforceRoomTriangle_Expand:
{
    ; $064C2D
    .speed_x
    db $FF, $00, $01

    ; $064C30
    .speed_y
    db $FF, $FF, $FF
}

; $064C33-$064C55 JUMP LOCATION
AnimateTriforceRoomTriangle_Expand:
{
    LDA.w $1E0A : AND.b #$07 : BNE .BRANCH_1
        LDA.w Pool_AnimateTriforceRoomTriangle_Expand_speed_x, X
        CLC : ADC.w $1E58, X : STA.w $1E58, X
    
    .BRANCH_1
    
    LDA.w $1E0A : AND.b #$03 : BNE .BRANCH_2
        LDA.w Pool_AnimateTriforceRoomTriangle_Expand_speed_y, X
        CLC : ADC.w $1E60, X : STA.w $1E60, X
    
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

; $064C6B-$064C8B JUMP LOCATION
AnimateTriforceRoomTriangle_Contract:
{
    LDA.w $1E0A : AND.b #$03 : BNE .BRANCH_1
        JSR.w AnimateTriforceRoomTriangle_HandleContracting
    
    .BRANCH_1
    
    LDA.w Pool_AnimateTriforceRoomTriangle_Contract_target_x, X
    CMP.w $1E30, X : BNE .BRANCH_2
        STZ.w $1E58, X
    
    .BRANCH_2
    
    LDA.w Pool_AnimateTriforceRoomTriangle_Contract_target_y, X
    CMP.w $1E48, X : BNE .BRANCH_3
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

; $064C8F-$064CAF JUMP LOCATION
AnimateTriforceRoomTriangle_Stopped:
{
    LDA.w $1E0C : ORA.w $1E0D : BNE .BRANCH_1
        LDA.w Pool_AnimateTriforceRoomTriangle_Stopped, X : STA.w $1E48, X
        
        RTS
    
    .BRANCH_1
    
    LDA.w $1E0C : SEC : SBC.b #$01 : STA.w $1E0C
    LDA.w $1E0D       : SBC.b #$00 : STA.w $1E0D
    
    RTS
}

; ==============================================================================

; $064CB0-$064D0C LOCAL JUMP LOCATION
AnimateTriforceRoomTriangle_HandleContracting:
{
    LDA.w Pool_AnimateTriforceRoomTriangle_Contract_target_x, X
    CMP.w $1E30, X : BCC .BRANCH_1
        LDA.w Pool_AnimateTriforceRoomTriangle_Contract_speed_y, X
        
        BRA .BRANCH_2
    
    .BRANCH_1
    
    LDA.w Pool_AnimateTriforceRoomTriangle_Contract_speed_x, X
    
    .BRANCH_2
    
    CLC : ADC.w $1E58, X : STA.w $1E58, X
    CMP.w Pool_AnimateTriforceRoomTriangle_Contract_limit_x : BNE .BRANCH_3
        LDA.w Pool_AnimateTriforceRoomTriangle_Contract_limit_x : INC
        
        BRA .BRANCH_4
    
    .BRANCH_3
    
    CMP.w Pool_AnimateTriforceRoomTriangle_Contract_limit_y : BNE .BRANCH_5
        LDA.w Pool_AnimateTriforceRoomTriangle_Contract_limit_y : INC
        
        .BRANCH_4
        
        STA.w $1E58, X
    
    .BRANCH_5
    
    LDA.w Pool_AnimateTriforceRoomTriangle_Contract_target_y, X
    CMP.w $1E48, X : BCC .BRANCH_6
        LDA.w Pool_AnimateTriforceRoomTriangle_Contract_speed_y, X
        
        BRA .BRANCH_7
    
    .BRANCH_6
    
    LDA.w Pool_AnimateTriforceRoomTriangle_Contract_speed_x, X
    
    .BRANCH_7
    
    CLC : ADC.w $1E60, X : STA.w $1E60, X
    CMP.w Pool_AnimateTriforceRoomTriangle_Contract_limit_x : BNE .BRANCH_8
        LDA.w Pool_AnimateTriforceRoomTriangle_Contract_limit_x : INC
        
        BRA .BRANCH_9
    
    .BRANCH_8
    
    CMP.w Pool_AnimateTriforceRoomTriangle_Contract_limit_y : BNE .BRANCH_10
        LDA.w Pool_AnimateTriforceRoomTriangle_Contract_limit_y : DEC
        
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
    TXA : ASL : TAY
    LDA.w Pool_InitializeSceneSprite_CreditsTriangle_position_x+0, Y
    STA.w $1E30, X

    LDA.w Pool_InitializeSceneSprite_CreditsTriangle_position_x+1, Y
    STA.w $1E38, X

    LDA.w Pool_InitializeSceneSprite_CreditsTriangle_position_y+0, Y
    STA.w $1E48, X

    LDA.w Pool_InitializeSceneSprite_CreditsTriangle_position_y+1, Y
    STA.w $1E50, X
    
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
    JSR.w LoadTriforceSpritePalette
    JSR.w AnimateSceneSprite_DrawTriforceRoomTriangle
    JSR.w AnimateSceneSprite_MoveTriangle
    
    LDA.b $11 : CMP.b #$24 : BNE .BRANCH_2
        LDA.w $1E20, X : CMP.b #$50 : BEQ .BRANCH_1
            INC.w $1E20, X
            
            LDA.w Pool_AnimateSceneSprite_CreditsTriangle_speed_x, X
            CLC : ADC.w $1E58, X : STA.w $1E58, X
            
            LDA.w Pool_AnimateSceneSprite_CreditsTriangle_speed_y, X
            CLC : ADC.w $1E60, X : STA.w $1E60, X
        
        .BRANCH_1
        
        RTS
        
    .BRANCH_2
    
    STZ.w $1E20, X
    
    RTS
}

; ==============================================================================

; $064D70-$064D77 DATA
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

; Beginning of Module 1: File Select Screen:
; $064D7D-$0064D9C JUMP LOCATION
Module_SelectFile:
{
    STZ.b $E4
    STZ.b $E5
    STZ.b $EA
    STZ.b $EB
    
    LDA.b $11 ; Load the submodule index.
    JSL.l UseImplicitRegIndexedLongJumpTable
    dl FileSelect_InitializeGFX                   ; 0x00 - $0CCD9D
    dl FileSelect_UploadFancyBackground           ; 0x01 - $0CCDF2
    dl FileSelect_ReInitSaveFlagsAndEraseTriforce ; 0x02 - $0CCE53
    dl FileSelect_TriggerStripesAndAdvance        ; 0x03 - $0CCEA5
    dl FileSelect_TriggerNameStripesAndAdvance    ; 0x04 - $0CCEB1
    dl FileSelect_Main                            ; 0x05 - $0CCEBD
}

; ==============================================================================

; $064D9D-$064DF1 JUMP LOCATION
FileSelect_InitializeGFX:
{
    JSL.l EnableForceBlank
    
    STZ.w $012A
    STZ.w $1F0C
    
    ; Play Fairy fountain theme.
    LDA.b #$0B : STA.w $012C
    
    INC.b $11
    
    LDA.b #$02 : STA.w $0AA9
    
    LDA.b #$06 : STA.w $0AB6
                 STA.w $0710
    
    JSL.l Palette_DungBgMain
    JSL.l Palette_OverworldBgAux3
    
    LDA.b #$00 : STA.w $0AB2
    
    JSL.l Palette_HUD
    
    STZ.w $0202
    
    LDA.b #$01 : STA.w $0AA4
    LDA.b #$23 : STA.w $0AA1
    LDA.b #$51 : STA.w $0AA2
    
    JSL.l LoadDefaultGfx
    JSL.l InitTileSets
    JSL.l LoadSelectScreenGfx
    JSL.l Intro_ValidateSram
    JML.l Intro_LoadSpriteStats
}

; ==============================================================================

; $064DF2-$064E0E JUMP LOCATION
FileSelect_ReInitSaveFlagsAndEraseTriforce:
{
    LDX.b #$05
    
    .zeroLoop
    
        STZ.b $BF, X ; Zero out $BF - $C4.
    DEX : BPL .zeroLoop
    
    ; Sets up palettes and other things.
    ; $064DF9 ALTERNATE ENTRY POINT
    .EraseTriforce
    
    LDA.b #$80 : STA.w $0710
    
    JSL.l EnableForceBlank
    JSL.l VRAM_EraseTilemaps_triforce
    JSL.l Palette_SelectScreen
    
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
        LDA.b $00             : PHA
        AND.w #$0020 : LSR #4 : TAY
        
        ; $064E17, A = 0xCE0F OR 0xCE13
        LDA.w Pool_FileSelect_UploadLinoleum_pointers, Y : STA.b $02
        
        ; A is Odd or Even?
        ; I.e. 0x00 if even or 0x02 if odd.
        PLA : AND.w #$0001 : ASL : TAY
        
        ; Notice in this function that $00 ranges over 0x0 - 0x3FF.
        ; Addresses written range from $1006 to $1805.
        ; Sets up a complex data table.
        LDA.b ($02), Y : STA.w $1006, X
        
        INX : INX
        
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
    
    JSR.w FileSelect_UploadLinoleum
    
    LDY.w #$00DE ; Y's usage is an index in what follows (for a loop).
    
    .loop
    
        ; Addresses $1806 - $18E5 are written.
        LDA.w FancyBackgroundTileMap, Y : STA.w $1806, Y
        
        ; Notice that X is increasing but has nothing to do with the loop.
        INX : INX
    DEY : DEY : BPL .loop
    
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
        
        INX : INX
        
        ; Store fixed numbers after the varying number above.
        LDA.w #$3240 : STA.w $1006, X
        
        INX : INX
        
        LDA.w #$347F : STA.w $1006, X
        
        ; All in all 0x66 bytes are written.
        INX : INX
    ; We'll loop #$11 times.
    DEC.b $02 : BPL .loop2
    
    SEP #$20 ; Accumulator is now 8-bit.
    
    ; Possibly an ending indicator for this block of data.
    ; Written at $194E.
    LDA.b #$FF : STA.w $1006, X
    
    SEP #$10
    
    INC.b $11 ; Increment the submodule index.
    
    JMP.w FileSelect_TriggerTheStripes
}

; ==============================================================================

; $064EA5-$064EB0 JUMP LOCATION
FileSelect_TriggerStripesAndAdvance:
{
    LDA.w $0B9D : STA.b $CB
    
    ; $064EAA ALTERNATE ENTRY POINT
    .alpha
    
    INC.b $11 ; Increment the submodule index.
        
    LDA.b #$06 : STA.b $14
        
    RTL
}

; $064EB1-$064EBC
FileSelect_TriggerNameStripesAndAdvance:
{
    JSR.w FileSelect_SetUpNamesStripes
        
    LDA.b #$0F : STA.b $13
        
    STZ.w $0710

    BRA FileSelect_TriggerStripesAndAdvance_alpha
}

; ==============================================================================

; Module 0x01.0x05
; $064EBD-$064EC6 JUMP LOCATION
FileSelect_Main:
{
    PHB : PHK : PLB
    
    ; Main logic for the select screen.
    JSL.l FileSelect_HandleInput

    ; Sets the tile map update flag and exits.
    JMP.w FileSelect_TriggerTheStripes
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
        LDA.w FileSelectNamesTilemap-1, X : STA.w $1001, X
    DEX : BNE .BRANCH_1
    
    SEP #$10
    
    PLB
    
    RTS
}

; ==============================================================================

; This routine handles input on the select screen, changing it appropriately.
; $064EDC-$064FBA JUMP LOCATION
FileSelect_HandleInput:
{
    ; The menu index on the select screen (0-2 save files,
    ; 3 - copy player, 4 - erase player).
    LDA.b $C8 : CMP.b #$03 : BCS .notSaveFile
        STA.w $0B9D
    
    .notSaveFile
    
    REP #$30
    
    LDX.w #$0000
    
    .nextFile
    
        STX.b $00
        
        ; SaveFileCopyOffsets holds the SRAM offsets.
        ; X = #$0, #$500, #$A00
        LDA.l SaveFileCopyOffsets, X : TAX
        
        ; isValid variable
        ; If the file actually has this written, we do something.
        ; What happens if the file is empty.
        LDA.l $7003E5, X : CMP.w #$55AA : BNE .invalidSaveFile
        
        ; Here we actually have a file to work with.
        ; X = 0x00, 0x02, or 0x04
        ; Write a 1 to each entry of $BF that corresponds to an active file.
        PHX
        LDX.b $00
        LDA.w #$0001 : STA.b $BF, X
        PLX
        
        LDA.w #$D698 : STA.b $04
        LDA.w #$D699 : STA.b $02
        
        PHX ; Save the SRAM offset.
        
        ; Set OAM for Link's shield and sword (mainly).
        JSR.w FileSelect_DrawLink
        
        ; Set number of deaths OAM.
        JSR.w FileSelect_DrawDeaths
        
        PLX ; Restore the SRAM offset.
        
        ; Draw hearts and player's name for this file.
        JSR.w FileSelect_CopyNameToStripes
        
        .invalidSaveFile
    ; If there's more files to look at, go back to .BRANCH_2.
    LDX.b $00 : INX : INX : CPX.w #$0006 : BCC .nextFile
    
    SEP #$30
    
    ; Index of the "fairy" cursor 0-4.
    LDX.b $C8
    
    LDA.b #$1C : STA.b $00
    
    ; Tells us what height the "fairy" selector should be at.
    LDA.w FileSelect_FairyY, X : STA.b $01
    
    ; Animates the fairy icon.
    JSR.w SelectFile_DrawFairy
    
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
                ; Allows the fairy to wrap around to the top.
                STZ.b $C8
            
            .done
            
            BRA .return
    
        .actionButtonDown
        
        LDA.b #$2C : STA.w $012E
        
        LDA.b $C8 : CMP.b #$03 : BEQ .gotoCopyMode
            BCS .gotoEraseMode
                ; Otherwise, find out which save slot this is.
                LDA.b $C8 : ASL : TAX
                
                ; If this save file is empty, go to the naming mode for a new
                ; player.
                LDA.b $BF, X : BEQ .emptyFile
                    ; Tells us to cut the music for the moment.
                    LDA.b #$F1 : STA.w $012C
                    
                    ; As to not interfere with the 16 bit value of $C8.
                    STZ.b $C9
                    
                    REP #$20
                    
                    ;  Obtain the SRAM offset of the save file we chose.
                    LDA.l SaveFileCopyOffsets, X : STA.b $00
                    
                    ;  A = #$02, #$04, #$06
                    ; Indicates in SRAM which save slot was loaded last.
                    LDA.b $C8 : ASL : INC : INC : STA.l $701FFE
                    
                    SEP #$20
                    
                    ; Why this is a long branch (BRL), I have no idea.
                    BRL CopySaveToWRAM
                
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
}

; $064FBB-$065052 JUMP LOCATION
CopySaveToWRAM:
{
    ; OPTIMIZE: Why not just add 0x0F to the addresses instead?
    ; We end up here if we've selected a game that has data in it already.
    LDX.b #$0F
    LDA.b #$00 : STA.l $001AC0, X
                 STA.l $001AE0, X

    LDA.b #$00 : STA.l $001AB0, X
                 STA.l $001AD0, X 
                 STA.l $001AF0, X
    
    ; Change the bank to $7E so that we can use "STA.w ZZ, Y" and so we don't
    ; have to make a bunch of long SRM writes later.
    PHB : LDA.b #$7E : PHA : PLB
    
    REP #$30
    
    ; The SRAM offset based on which save slot you picked.
    LDY.w #$0000
    LDX.b $00
    
    .SRAMLoadLoop
    
        ; Loads the save file from SRAM into WRAM ($7EF000-$7EF4FF).
        LDA.l $700000, X : STA.w $F000, Y
        LDA.l $700100, X : STA.w $F100, Y
        LDA.l $700200, X : STA.w $F200, Y
        LDA.l $700300, X : STA.w $F300, Y
        LDA.l $700400, X : STA.w $F400, Y
        
        INX : INX
    INY : INY : CPY.w #$0100 : BNE .SRAMLoadLoop

    ; Restore the previous bank.
    PLB
    
    LDA.w #$0007 : STA.l $7EC00D
                   STA.l $7EC013

    LDA.w #$0000 : STA.l $7EC00F
                   STA.l $7EC015 
    
    ; OPTIMIZE: Unused: These values are unused and can be remvoed.
    LDA.w #$6040 : STA.w $0219
    LDA.w #$4841 : STA.w $021D
    LDA.w #$007F : STA.w $021F
    LDA.w #$FFFF : STA.w $0221
    
    SEP #$30
    
    LDA.b #$80 : STA.w $0204
    
    ; Send us to module 5.
    LDA.b #$05 : STA.b $10
    
    STZ.b $11
    STZ.w $010E
    STZ.w $0710
    STZ.w $0AB2
    
    RTL
}

; ==============================================================================

; Beginning of Module 0x02: Copy File Mode
; $065053-$06506D JUMP LOCATION
Module_CopyFile:
{
    STZ.w $0B9D
    
    LDA.b $11
    JSL.l UseImplicitRegIndexedLongJumpTable
    dl FileSelect_ReInitSaveFlagsAndEraseTriforce_EraseTriforce ; 0x00 - $0CCDF9
    dl FileSelect_ReInitSaveFlagsAndEraseTriforce               ; 0x01 - $0CCE53
    dl CopyFile_FindFileIndices                                 ; 0x02 - $0CD06E
    dl CopyFile_ChooseSelection                                 ; 0x03 - $0CD087
    dl CopyFile_ChooseTarget                                    ; 0x04 - $0CD0A2
    dl CopyFile_ConfirmSelection                                ; 0x05 - $0CD0B9
}

; $06506E-$06506F JUMP LOCATION
CopyFile_FindFileIndices:
{
    LDA.b #$07

    ; Bleeds into the next function.
}
    
; $065070-$065086 JUMP LOCATION
KILLFile_FindFileIndices:
{
    JSR.w Intro_TriforceTerminateSpin_doTilemapUpdate
    
    LDA.b #$0F : STA.b $13
    
    STZ.w $0710
    
    LDX.b #$FE
    
    .loop
    
        INX : INX
    LDA.b $BF, X : BEQ .loop
    
    TXA : LSR : STA.b $C8
    
    RTL
}

; ==============================================================================

; $065087-$06509B JUMP LOCATION
CopyFile_ChooseSelection:
{
    PHB : PHK : PLB
    
    JSR.w CopyFile_SelectionAndBlinker
    
    LDA.b $11 : CMP.b #$03 : BNE .BRANCH_1
        LDA.b $1A : AND.b #$30 : BNE .BRANCH_1
            JSR.w FilePicker_DeleteHeaderStripe
    
    .BRANCH_1

    ; Bleeds into the next function
}

; $06509C-$0650A1 JUMP LOCATION
FileSelect_TriggerTheStripes:
{
    ; Indicates to the NMI routine that the tilemap needs updating.
    LDA.b #$01 : STA.b $14
    
    PLB
    
    RTL
}

; $0650A2-$0650B8 JUMP LOCATION
CopyFile_ChooseTarget:
{
    PHB : PHK : PLB
    
    JSR.w CopyFile_TargetSelectionAndBlink
    
    LDA.b $11 : CMP.b #$04 : BNE .BRANCH_2
        LDA.b $1A : AND.b #$30 : BNE .BRANCH_1
            JSR.w FilePicker_DeleteHeaderStripe
    
    .BRANCH_2
    
    BRA .BRANCH_1
}

; ==============================================================================

; $0650B9-$0650C1 JUMP LOCATION
CopyFile_ConfirmSelection:
{
    PHB : PHK : PLB
    
    JSR.w CopyFile_HandleConfirmation
    JMP.w FileSelect_TriggerTheStripes
}

; ==============================================================================

; $0650C2-$0650C5 DATA
FilePicker_DeleteHeaderStripe_offsets:
{
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
        
        LDY.w .offsets, X
        
        .BRANCH_2
        
            STA.w $1002, Y
            
            INY : INY
        DEC.b $00 : BNE .BRANCH_2
    DEX : DEX : BPL .BRANCH_1
    
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

    db $FF ; End of stripes data
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

; $06513F-$06522C LOCAL JUMP LOCATION
CopyFile_SelectionAndBlinker:
{
    REP #$10
    
    LDX.w #$00AC : STX.w $1000
    
    .BRANCH_1
    
        LDA.w CopyFile_HeaderStripe, X : STA.w $1002, X
    DEX : BPL .BRANCH_1
    
    REP #$20
    
    LDX.w #$0000
    
    .BRANCH_2
    
        STX.b $00
        
        LDA.b $BF, X : AND.w #$0001 : BEQ .BRANCH_4
            LDA.l SaveFileCopyOffsets, X
            
            TXY
            TAX
            LDA.w CopyFile_NameStripeBufferOffset, Y : TAY
            
            LDA.w #$0006 : STA.b $02
            
            .BRANCH_3
            
                LDA.l $7003D9, X : CLC : ADC.w #$1800 : STA.w $1002, Y
                                   CLC : ADC.w #$0010 : STA.w $1016, Y
                
                INX : INX 
                
                INY : INY
            DEC.b $02 : BNE .BRANCH_3
        
        .BRANCH_4
    LDX.b $00 : INX : INX : CPX.w #$0006 : BCC .BRANCH_2
    
    SEP #$30
    
    LDX.b $C8
    LDA.w CopyFile_FairyIndent, X : STA.b $00
    LDA.w CopyFile_FairyHeight, X : STA.b $01
    
    JSR.w SelectFile_DrawFairy
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : AND.b #$FC : BNE .BRANCH_5
        BRL ReturnToFileSelect_exit
    
    .BRANCH_5
    
    AND.b #$2C : BEQ .BRANCH_12
        AND.b #$08 : BEQ .BRANCH_8
            LDX.b $C8 : DEX : BPL .BRANCH_7
                .BRANCH_6
                
                    TXA : ASL : TAY
                    LDA.w $00BF, Y : BNE .BRANCH_11
                DEX : BPL .BRANCH_6
            
            .BRANCH_7
            
            LDX.b #$03
            
            BRA .BRANCH_11
        
        .BRANCH_8
        
        LDX.b $C8 : INX : CPX.b #$03 : BCS .BRANCH_10
            .BRANCH_9
            
            TXA : ASL : TAY
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
        
        BRA ReturnToFileSelect_exit
    
    .BRANCH_12
    
    ; Presumably record that the result was 0x2C.
    LDA.b #$2C : STA.w $012E
    
    ; $C8 Indexes your selection so far.
    ; I.e. They chose the quit option. #$0-2 are the save games.
    LDA.b $C8 : CPX.b #$03 : BEQ .BRANCH_15
        ; So if they didn't choose to quit... they must have chosen a game
        ; to copy.
        ASL : STA.b $CC
        
        ; So use the menu index shifted left ( $C8 * 2 -> $CC).
        STZ.b $CD
        
        LDX.b #$49
        
        .BRANCH_13
        
            LDA.w CopyFile_FairyHeight, X : STA.w $1035, X
        DEX : BNE .BRANCH_13
        
        ; Tell me what menu item they really picked...
        LDX.b $C8 : CPX.b #$02 : BEQ .BRANCH_14
            ; If not, then look up a value...
            LDA.w CopyFile_TargetStripeOffsetAdjuster, X : TAX
            
            LDA.b #$6C : STA.w $1036, X
                         STA.w $103C, X
            
            LDA.b #$27       : STA.w $1037, X
            CLC : ADC.b #$20 : STA.w $103D, X
        
        .BRANCH_14
        
        INC.b $11
        
        BRA ReturnToFileSelect_reset_cursor
    
    .BRANCH_15

    ; Bleeds into the next function.
}

; $06522D-$065239 LOCAL JUMP LOCATION
ReturnToFileSelect:
{
    ; This means the mode will change to select screen mode.
    LDA.b #$01 : STA.b $10

    ; And the submodule will be the second (#$01) one.
    LDA.b #$01 : STA.b $11
    
    STZ.b $B0 ; Reset the sub-index of the submodule as well.
    
    .reset_cursor
    
    STZ.b $C8 ; Reset the menu marker too.
    
    .exit
    
    RTS
}

; ==============================================================================

; $06523A-$06526A DATA
CopyFile_ConfirmationStripes:
{
    dw $B461, $0E40 ; VRAM $C368 | 16 bytes | Fixed horizontal
    dw $00A9

    dw $D461, $0E40 ; VRAM $C3A8 | 16 bytes | Fixed horizontal
    dw $00A9

    dw $C662, $0D00 ; VRAM $C58C | 14 bytes | Horizontal
    dw $1802, $180E, $180F, $1828, $18A9, $180E, $180A

    dw $E662, $0D00 ; VRAM $C5CC | 14 bytes | Horizontal
    dw $1812, $181E, $181F, $1838, $18A9, $181E, $181A

    db $FF ; End of stripes data
}

; ==============================================================================

; $06526B-$06526D DATA
CopyFile_TargetFairyX:
{
    db $8C ; 1
    db $8C ; 2
    db $1C ; Exit
}

; $06526E-$065270 DATA
CopyFile_TargetFairyY:
{
    db $67 ; 1
    db $7F ; 2
    db $BF ; Exit
}

; $065271-$065274 DATA
CopyFile_BufferOffset:
{
    dw $0038
    dw $0060
}

; $065275-$06527A DATA
CopyFile_TargetNumerals:
{
    dw $18E7 ; 1
    dw $18E8 ; 2
    dw $18E9 ; 3
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
    DEC : DEC : BPL .BRANCH_1
    
    REP #$10
    
    LDX.w #$0084 : STX.b $0E
    
    .BRANCH_3
    
        LDA.w CopyFile_TargetHeaderStripes, X : STA.w $1002, X
    DEX : BPL .BRANCH_3
    
    REP #$20
    
    LDX.w #$0000 : STX.b $04
    
    .BRANCH_4
    
        STX.b $00 : CPX.b $CC : BEQ .BRANCH_6
            LDY.b $04
            LDA.w CopyFile_BufferOffset, Y : TAY
            
            INC.b $04 : INC.b $04
            
            LDA.w CopyFile_TargetNumerals, X : STA.w $1002, Y
            CLC : ADC.w #$0010               : STA.w $1016, Y
            
            LDA.b $BF, X : BEQ .BRANCH_6
                LDA.w #$0006 : STA.b $02
                
                LDA.l SaveFileCopyOffsets, X : TAX
                
                .BRANCH_5
                
                    LDA.l $7003D9, X : CLC : ADC.w #$1800 : STA.w $1006, Y
                                       CLC : ADC.w #$0010 : STA.w $101A, Y
                    
                    INX : INX
                    
                    INY ; INY
                DEC.b $02 : BNE .BRANCH_5
        
        .BRANCH_6
    LDX.b $00 : INX : INX : CPX.w #$0006 : BCC .BRANCH_4
    
    LDX.b $0E : STX.w $1000
    
    SEP #$30
    
    LDX.b $C8
    LDA.w CopyFile_TargetFairyX, X : STA.b $00
    LDA.w CopyFile_TargetFairyY, X : STA.b $01
    
    JSR.w SelectFile_DrawFairy
    
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
            LDA.b $CA, X : STA.b $CA
                           STZ.b $CB
            
            LDX.b #$30
            
            .BRANCH_10
            
                ; Write out "copy ok?".
                LDA.w CopyFile_ConfirmationStripes, X : STA.w $1036, X
            DEX : BPL .BRANCH_10
            
            LDA.b $C8 : BNE .BRANCH_11
                LDA.b #$62 : STA.w $1036
                             STA.w $103C
                
                LDA.b #$14       : STA.w $1037
                CLC : ADC.b #$20 : STA.w $103D
            
            .BRANCH_11
            
            INC.b $11
            
            BRA .BRANCH_13
        
        .BRANCH_12
        
        JSR.w ReturnToFileSelect
        
        .BRANCH_13
        
        STZ.b $C8
    
    .BRANCH_14
    
    RTS
}

; ==============================================================================

; $06536F-$065370 DATA
CopyFile_HandleConfirmation_fairy_y:
{
    db $AF ; Yes
    db $BF ; No
}

; $065371-$0653DB LOCAL JUMP LOCATION
CopyFile_HandleConfirmation:
{
    LDX.b $C8
    
    LDA.b #$1C        : STA.b $00
    LDA.w .fairy_y, X : STA.b $01
    
    JSR.w SelectFile_DrawFairy
    
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
            
            LDX.b $CA
            LDA.l SaveFileCopyOffsets, X : TAY

            LDX.b $CC
            LDA.l SaveFileCopyOffsets, X : TAX
            
            JSR.w CopyFile_CopyData
            
            LDX.b $CA
            LDA.w #$0001 : STA.b $BF, X
            
            SEP #$30
        
        .BRANCH_3
        
        JSR.w ReturnToFileSelect
        
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
        
        INX : INX
        
        INY : INY
    DEC.b $00 : BNE .BRANCH_1
    
    SEP #$20
    
    PLB
    
    REP #$20
    
    RTS
}

; ==============================================================================

; $065416-$065419 DATA
KILLFile_FairyX:
{
    db $24 ; File 1
    db $24 ; File 2
    db $24 ; File 3
    db $1C ; Exit
}

; $06541A-$06541D DATA
KILLFile_FairyY:
{
    db $67 ; File 1
    db $7F ; File 2
    db $97 ; File 3
    db $BF ; Exit
}

; ==============================================================================

; $06541E-$065482 DATA
KILL_OK_stripes:
{
    db $61, $A7, $40, $24, $A9, $00, $61, $C7
    db $40, $24, $A9, $00, $62, $07, $40, $24
    db $A9, $00, $62, $27, $40, $24, $A9, $00
    db $62, $C6, $00, $21, $04, $18, $21, $18
    db $00, $18, $22, $18, $04, $18, $A9, $18
    db $23, $18, $07, $18, $AF, $18, $22, $18
    db $A9, $18, $0F, $18, $0B, $18, $00, $18
    db $28, $18, $04, $18, $21, $18, $62, $E6
    db $00, $21, $14, $18, $31, $18, $10, $18
    db $32, $18, $14, $18, $A9, $18, $33, $18
    db $17, $18, $BF, $18, $32, $18, $A9, $18
    db $1F, $18, $1B, $18, $10, $18, $38, $18
    db $14, $18, $31, $18

    db $FF ; End of stripes data
}

; ==============================================================================

; $065483-$065484 DATA
KILL_OK_FileNameStripesAdjustment:
{
    db $00 ; File 1
    db $0C ; File 2
}

; ==============================================================================

; Beginning of Module 3: Erase File Mode
; $065485-$065499 JUMP LOCATION
Module_EraseFile:
{
    LDA.b $11
    JSL.l UseImplicitRegIndexedLongJumpTable
    dl FileSelect_ReInitSaveFlagsAndEraseTriforce_EraseTriforce ; 0x00 - $0CCDF9
    dl FileSelect_ReInitSaveFlagsAndEraseTriforce               ; 0x01 - $0CD89C
    dl KILLFile_SetUp                                           ; 0x02 - $0CD49A
    dl KILLFile_HandleSelection                                 ; 0x03 - $0CD49F
    dl KILLFile_HandleConfirmation                              ; 0x04 - $0CD4B1
}

; $06549A-$06549E JUMP LOCATION
KILLFile_SetUp:
{
    LDA.b #$08
    
    JMP.w KILLFile_FindFileIndices
}

; $06549F-$0654B0 JUMP LOCATION
KILLFile_HandleSelection:
{
    PHB : PHK : PLB
    
    LDA.b $C8 : CMP.b #$03 : BCS .alpha
        STA.w $0B9D
    
    .alpha
    
    JSR.w KILLFile_ChooseTarget
    JMP.w FileSelect_TriggerTheStripes
}

; ==============================================================================

; $0654B1-$0654B9 JUMP LOCATION
KILLFile_HandleConfirmation:
{
    PHB : PHK : PLB
    
    JSR.w KILLFile_VerifyDeletion
    JMP.w FileSelect_TriggerTheStripes
}

; ==============================================================================

; $0654BA-$065596 LOCAL JUMP LOCATION
KILLFile_ChooseTarget:
{
    REP #$10
    
    LDX.w #$00FD
    
    .BRANCH_1
    
        LDA.w KILLFile_BlankNameStripes-1, X : STA.w $1001, X
    DEX : BNE .BRANCH_1
    
    REP #$20
    
    LDX.w #$0000
    
    .BRANCH_2
    
        STX.b $00
        
        LDA.b $BF, X : AND.w #$0001 : BEQ .BRANCH_3
            LDA.l SaveFileCopyOffsets, X : TAX
            JSR.w FileSelect_CopyNameToStripes
        
        .BRANCH_3
    LDX.b $00 : INX : INX : CPX.w #$0006 : BCC .BRANCH_2
    
    SEP #$30
    
    LDX.b $C8
    
    LDA.w KILLFile_FairyX, X : STA.b $00
    LDA.w KILLFile_FairyY, X : STA.b $01
    
    JSR.w SelectFile_DrawFairy
    
    LDY.b #$02
    
    LDA.b $F4 : AND.b #$20 : BNE .BRANCH_6
        LDA.b $F4 : AND.b #$0C : BEQ .BRANCH_9
            AND.b #$04 : BNE .BRANCH_6
                LDA.b #$20 : STA.w $012F
                
                LDY.b #$FE
                
                LDX.b $C8 : DEX : BMI .BRANCH_5
                    .BRANCH_4
                    
                        TXA : ASL : TAY
                        LDA.w $00BF, Y : BNE .BRANCH_9
                    DEX : BPL .BRANCH_4
                
                .BRANCH_5
                
                LDX.b #$03
                
                BRA .BRANCH_9
    
    .BRANCH_6
    
    LDA.b #$20 : STA.w $012F
    
    LDX.b $C8 : INX : CPX.b #$03 : BCS .BRANCH_8
        .BRANCH_7
        
            TXA : ASL : TAY
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
            
                LDA.w KILL_OK_stripes, X : STA.w $1002, X
            DEX : BPL .BRANCH_10
            
            INC.b $11
            
            LDX.b $C8 : CPX.b #$02 : BEQ .BRANCH_11
                LDA.w KILL_OK_FileNameStripesAdjustment, X : TAX
                LDA.b #$62 : STA.w $1002, X
                             STA.w $1008, X
                
                LDA.b #$67       : STA.w $1003, X
                CLC : ADC.b #$20 : STA.w $1009, X
            
            .BRANCH_11
            
            LDA.b $C8 : STA.b $B0
            STZ.b $C8
            
            BRA .BRANCH_13
        
        .BRANCH_12
        
        SEP #$30
        
        JSR.w ReturnToFileSelect
    
    .BRANCH_13
    
    RTS
}

; ==============================================================================

; $065597-$065598 DATA
KILLFile_VerifyDeletion_fairy_pos_y:
{
    db $AF, $BF
}

; $065599-$06562F LOCAL JUMP LOCATION
KILLFile_VerifyDeletion:
{
    LDA.b $B0 : ASL : STA.b $00
    
    REP #$30
    
    LDX.b $C8
    
    LDA.b #$1C : STA.b $00
    
    LDA.w .fairy_pos_y, X : STA.b $01
    
    JSR.w SelectFile_DrawFairy
    
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
            
            LDA.b $B0 : AND.w #$00FF : ASL : TAX
            STZ.b $BF, X
            LDA.l SaveFileCopyOffsets, X : TAX
            
            LDY.w #$0000 : TYA
            
            .BRANCH_4
            
                STA.l $700000, X : STA.l $700100, X
                STA.l $700200, X : STA.l $700300, X
                STA.l $700400, X : STA.l $700F00, X
                STA.l $701000, X : STA.l $701100, X
                STA.l $701200, X : STA.l $701300, X
                
                INX : INX
            INY : INY : CPY.w #$0100 : BNE .BRANCH_4
            
            SEP #$30
        
        .BRANCH_5
        
        JSR.w ReturnToFileSelect
        
        STZ.b $B0
    
    .BRANCH_6
    
    RTS
}

; ==============================================================================

; $065630-$06563C DATA
Pool_FileSelect_CopyNameToStripes:
{
    ; $065630
    .name_offset
    dw $0008
    dw $005C
    dw $00B0

    ; $065636
    .hearts_offset
    dw $0016
    dw $006A
    dw $00BE
}

; Draws both the Player's name and the hearts of that player to screen.
; $06563C-$065694 LOCAL JUMP LOCATION
FileSelect_CopyNameToStripes:
{
    PHX
    
    ; Sets the position in the tilemap buffer to draw to.
    LDY.b $00 : LDA.w Pool_FileSelect_CopyNameToStripes_name_offset, Y : TAY
    
    LDA.w #$0006 : STA.b $02
    
    .nextLetter
    
        LDA.l $7003D9, X : CLC : ADC.w #$1800 : STA.w $1002, Y
                           CLC : ADC.w #$0010 : STA.w $102C, Y
        
        INX : INX
        
        INY : INY
    DEC.b $02 :BNE .nextLetter
    
    PLX
    
    LDY.w #$0001 : LDA.l $70036C, X : AND.w #$00FF : LSR #3 : STA.b $02
    
    LDX.b $00
    LDY.w Pool_FileSelect_CopyNameToStripes_hearts_offset, X : STY.b $04 
    
    LDA.w #$0520
    LDX.w #$000A
    
    .nextHeart
    
        STA.w $1002, Y
        
        INY : INY : DEX : BNE .BRANCH_3
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
    db $43 ; File 1
    db $63 ; File 2
    db $83 ; File 3

    ; $06569C
    .OAM_offset
    db $28 ; File 1
    db $3C ; File 2
    db $50 ; File 3

    ; $06569F
    .sword_GFX
    db $85 ; Fighter sword
    db $A1 ; Master sword
    db $A1 ; Tempered sword
    db $A1 ; Gold sword

    ; $0656A3
    .shield_GFX
    db $C4 ; Fighter shield
    db $CA ; Fire shield
    db $E0 ; Mirror shield

    ; $0656A6
    .sword_props
    db $72 ; File 1
    db $76 ; File 2
    db $7A ; File 3

    ; $0656A9
    .shield_props
    db $32 ; File 1
    db $36 ; File 2
    db $3A ; File 3

    ; $0656AC
    .link_props
    db $30 ; File 1
    db $34 ; File 2
    db $38 ; File 3
}

; $0656AF-$0657A2 LOCAL JUMP LOCATION
FileSelect_DrawLink:
{
    REP #$30
    
    LDA.w #$0116 : ASL : STA.w $0100
    
    ; A = 0, 2, 4, or 6.
    LDA.b $00 : AND.w #$00FF : TAX
    
    ; Get that SRAM offset again, Mirror it at $0E.
    LDA.l SaveFileCopyOffsets, X : STA.b $0E
    
    SEP #$30
    
    ; A = 0, 1, 2, or 3.
    LDA.b $00 : LSR : TAY
    
    ; A -> #$28, #$3C, #$50 in Decimal 40, 60, 80.
    LDA.w Pool_FileSelect_DrawLink_OAM_offset, Y : TAX
    
    ; $D698 -> $65698 #$34 = 52
    ; A -> #$40 = 64
    ; Mirror to this location.
    LDA.b ($04) : CLC : ADC.b #$0C : STA.w $0800, X
                                     STA.w $0804, X
    
    ; I.e. from $D699, Y; A = 0x43, 0x63, or 0x83
    ; A = 0x3E, 0x5E, or 0x7E
    LDA.b ($02), Y : CLC : ADC.b #$FB : STA.w $0801, X
    
    ; The last add obviously overflowed, so clc
    ; A -> 0x46, 0x66, or 0x86
    CLC : ADC.b #$08 : STA.w $0805, X
    
    ; A -> #$72, #$76, #$7A
    LDA.w Pool_FileSelect_DrawLink_sword_props, Y : STA.w $0803, X
                                                    STA.w $0807, X
    
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
        LDA.b #$F0 : STA.w $0801, X
                     STA.w $0805, X
        
        ; So yeah, we want that 0 back from the 0xFF it was.
        INY
    
    .hasSword
    
    ; A -> #$85, #$A1, #$A1, #$A1 (#$85 is for the fighter sword shape).
    ; I guess this is where the sprite data for the sword is kept.
    LDA.w Pool_FileSelect_DrawLink_sword_GFX, Y : STA.w $0802, X
    
    ; Adding 0x10 gives you the lower part of the sword. (0x95 or 0xB1)
    ; So this is also tile data apparently.
    CLC : ADC.b #$10 : STA.w $0806, X
    
    ; Y -> #$0, #$1, #$2, #$3
    PLY
    
    ; 0x28, 0x3C, or 0x50 -> Stack
    ; X -> 0x0A, 0x0F, or 0x14 (10,15,20)
    ; A -> 0x28, 0x3C, or 0x50
    PHX
    TXA : LSR : LSR : TAX
    
    LDA.w #$00 : STA.w $0A20, X
                 STA.w $0A21, X
    
    ; A -> 0x28, 0x3C, or 0x50
    ; A -> 0x30, 0x44, or 0x58
    PLA : CLC : ADC.b #$08 : TAX
    
    ; $065698 A -> #$34
    ; A -> 0x2F
    ; Controls the position of the shield on the select screen.
    LDA.b ($04) : CLC : ADC.b #$FB : STA.w $0800, X
    
    ; Controls the display of the shield on the select screen.
    LDA.b ($02), Y : CLC : ADC.b #$0A : STA.w $0801, X
    
    ; A -> #$32, #$36, #$3A
    LDA.w Pool_FileSelect_DrawLink_shield_props, Y : STA.w $0803, X
    
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
    LDA.w Pool_FileSelect_DrawLink_shield_GFX, Y : STA.w $0802, X
    
    ; We're back to Y = 0x0, 0x1, or 0x2.
    PLY
    
    PHX
    
    TXA : LSR : LSR : TAX
    LDA.b #$02 : STA.w $0A20, X
    
    PLA : CLC : ADC.b #$04 : TAX
    LDA.b ($04) : STA.w $0800, X : STA.w $0804, X
    
    LDA.b #$00 : STA.w $0802, X
    LDA.b #$02 : STA.w $0806, X
    
    LDA.w Pool_FileSelect_DrawLink_link_props, Y : STA.w $0803, X
    ORA.b #$40                                   : STA.w $0807, X
    
    LDA.b ($02), Y   : STA.w $0801, X
    CLC : ADC.b #$08 : STA.w $0805, X
    
    TXA : LSR : LSR : TAX
    
    LDA.b #$02 : STA.w $0A20, X
                 STA.w $0A21, X
    
    REP #$30
    
    RTS
}

; ==============================================================================

; $0657A3-$0657A4 DATA
SelectFile_DrawFairy_chr:
{
    db $A8, $AA
}

; This routine animates the fairy on the select screen.
; $0657A5-$0657CA LOCAL JUMP LOCATION
SelectFile_DrawFairy:
{
    LDA.b $00 : STA.w $0800
    LDA.b $01 : STA.w $0801
    
    PHX
    
    LDX.b #$00
    
    ; Alternate 8 frames one way, 8 frames another.
    LDA.b $1A : AND.b #$08 : BEQ .set_chr
        INX
    
    .set_chr
    
    LDA.w .chr, X : STA.w $0802
    
    PLX
    
    LDA.b #$7E : STA.w $0803
    
    LDA.b #$02 : STA.w $0A20

    ; TODO: Confirm this:
    ; $0657CA ALTERNATE ENTRY POINT
    .exit
    
    RTS
}

; ==============================================================================

; $0657CB-$0657DA DATA
Pool_FileSelect_DrawDeaths:
{
    ; $0657CB
    .digit_char
    db $D0 ; 0
    db $AC ; 1
    db $AD ; 2
    db $BC ; 3
    db $BD ; 4
    db $AE ; 5
    db $AF ; 6
    db $BE ; 7
    db $BF ; 8
    db $C0 ; 9

    ; $0657D5
    .buffer_offset
    db $04 ; ..#
    db $10 ; .#.
    db $1C ; #..

    ; $0657D8
    .digit_position_x
    db $0C ; ..#
    db $04 ; .#.
    db $FC ; #..
}

; $0657DB-$065889 LOCAL JUMP LOCATION
FileSelect_DrawDeaths:
{
    !onesDigit     = $02
    !tensDigit     = $04
    !hundredsDigit = $06
    
    REP #$30
    
    LDA.b $02 : PHA
                STA.b $08

    LDA.b $04 : PHA
                STA.b $0A
    
    ; Check the death counter (which is set to 0xFFFF until you beat the game).
    LDX.b $0E
    LDA.l $700405, X : CMP.w #$FFFF : BNE .gameBeaten
        JMP.w .return ; $065883
    
    .gameBeaten
    
    CMP.w #$03E8 : BCC .lessThan1000 ; Less than a thousand.
        ; The number of deaths maxes out at 999, so we just set the digits to all 9s.
        LDA.w #$0009 : STA.b !onesDigit
                       STA.b !tensDigit
                       STA.b !hundredsDigit
        
        BRA .BRANCH_7
    
    .lessThan1000
    
    LDY.w #$0000
    
    .onesDigitLoop
    
        CMP.w #$000A : BCC .breakOnesLoop
            SEC : SBC.w #$000A
            
            INY
    BRA .onesDigitLoop
    
    .breakOnesLoop
    
    STA.b !onesDigit
    
    ; Y contains number of deaths divided by 10.
    TYA : LDY.w #$0000
    
    .tensDigitLoop
    
        CMP.w #$000A : .breakTensLoop
            SEC : SBC.w #$000A
            
            INY
    BRA .tensDigitLoop
    .breakTensLoop
    
    STA.b !tensDigit
    STY.b !hundredsDigit
    
    .BRANCH_7
    
    LDX.w #$0004
    
    LDA.b !hundredsDigit : BNE .setHighestDigit
        DEX : DEX
        
        LDA.b !tensDigit : BNE .setHighestDigit
            DEX : DEX
        
    .setHighestDigit
    
    SEP #$30
    
    LDA.b $00 : LSR : TAY
    LDA.w Pool_FileSelect_DrawDeaths_buffer_offset, Y : TAY
    
    .nextDigit
    
        PHX
        
        ; Set the sprite CHR based on the digit value.
        LDA.b $02, X : TAX
        LDA.w Pool_FileSelect_DrawDeaths_digit_char, X : STA.w $0802, Y
        
        PHY
        
        LDA.b $00 : LSR : TAY
        LDA.b ($08), Y : CLC : ADC.w #$7A10 : STA.w $0801, Y
        
        PLA : PHA : LSR : TAX
        LDA.b ($0A)
        CLC : ADC.w Pool_FileSelect_DrawDeaths_digit_position_x, X : STA.w $0800, Y

        LDA.b #$3C : STA.w $0803, Y
        
        PHY
        TYA : LSR : LSR : TAY
        
        LDA.b #$00 : STA.w $0A20, Y
        
        PLY : INY #4
    PLX : DEX : DEX : BPL .nextDigit
    
    REP #$30
    
    .return
    
    PLA : STA.b $04
    PLA : STA.b $02
    
    RTS
}

; ==============================================================================

; Beginning of Module 0x04: Name Player Mode
; $06588A-$06589B JUMP LOCATION
Module_NamePlayer:
{
    LDA.b $11
    JSL.l UseImplicitRegIndexedLongJumpTable
    dl NameFile_EraseSave         ; 0x00 - $0CD89C
    dl NameFile_FillBackground    ; 0x01 - $0CD911
    dl NameFile_MakeScreenVisible ; 0x02 - $0CD928
    dl NameFile_DoTheNaming       ; 0x03 - $0CDA4D
}

; $06589C-$065910 JUMP LOCATION
NameFile_EraseSave:
{
    JSL.l FileSelect_ReInitSaveFlagsAndEraseTriforce_EraseTriforce
    
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
    LDA.b $C8 : ASL : TAX
    
    ; Offsets for each of the save slots. #$0, #$500, #$A00, #$F00 for mirrors.
    ; $200 will hold the offset, And it will be the index in SRAM for the
    ; following loop.
    LDA.l SaveFileCopyOffsets, X : STA.w $0200
                                   TAX
    
    ; We're going to be putting zeroes in SRAM.
    LDY.w #$0000 : TYA
    
    .zeroLoop
    
        STA.l $700000, X ; In effect what this does is zero out the save file
        STA.l $700100, X ; before adding anything into it.
        STA.l $700200, X
        STA.l $700300, X
        STA.l $700400, X
        
        INX : INX
    INY : INY : CPY.w #$0100 : BNE .zeroLoop
    
    ; Here that offset pops up again.
    LDX.w $0200
    LDA.w #$00A9 : STA.l $7003D9, X ; These are the naming spots.
                   STA.l $7003DB, X ; 0xA9 is a blank character.
                   STA.l $7003DD, X
                   STA.l $7003DF, X
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
    
    JSR.w FileSelect_UploadLinoleum
    
    LDA.w #$FFFF : STA.w $1006, X
    
    SEP #$30
    
    PLB
    
    LDA.b #$01
    JSR.w Intro_TriforceTerminateSpin_doTilemapUpdate
    
    RTL
}

; $065928-$065934 JUMP LOCATION
NameFile_MakeScreenVisible:
{
    LDA.b #$05
    JSR.w Intro_TriforceTerminateSpin_doTilemapUpdate
    
    LDA.b #$0F : STA.b $13
    
    STZ.w $0710
    
    RTL
}

; $065935-$065A4C DATA
Pool_NameFile:
{
    ; $065935
    .CharacterLayout
    db $06, $07, $5F, $09, $59, $59, $1A, $1B
    db $1C, $1D, $1E, $1F, $20, $21, $60, $23
    db $59, $59, $76, $77, $78, $79, $7A, $59
    db $59, $59, $00, $01, $02, $03, $04, $05
    db $10, $11, $12, $13, $59, $59, $24, $5F
    db $26, $27, $28, $29, $2A, $2B, $2C, $2D
    db $59, $59, $7B, $7C, $7D, $7E, $7F, $59
    db $59, $59, $0A, $0B, $0C, $0D, $0E, $0F
    db $40, $41, $42, $59, $59, $59, $2E, $2F
    db $30, $31, $32, $33, $40, $41, $42, $59
    db $59, $59, $61, $3F, $45, $46, $59, $59
    db $59, $59, $14, $15, $16, $17, $18, $19
    db $44, $59, $6F, $6F, $59, $59, $59, $59
    db $59, $59, $59, $5A, $44, $59, $6F, $6F
    db $59, $59, $5A, $44, $59, $6F, $6F, $59
    db $59, $59, $59, $59, $59, $59, $59, $5A

    ; $0659B5
    .CursorPositionX
    dw $01F0, $0000, $0010, $0020
    dw $0030, $0040, $0050, $0060
    dw $0070, $0080, $0090, $00A0
    dw $00B0, $00C0, $00D0, $00E0
    dw $00F0, $0100, $0110, $0120
    dw $0130, $0140, $0150, $0160
    dw $0170, $0180, $0190, $01A0
    dw $01B0, $01C0, $01D0, $01E0

    ; $0659F5
    .CursorIndexMovementX
    dw $0001 ; Right
    dw $00FF ; Left

    ; $0659F9
    .CursorIndexBoundaryX
    dw $0020 ; Right
    dw $00FF ; Left

    ; $0659FD
    .CursorIndexWrapX
    dw $0000 ; Right
    dw $001F ; Left

    ; $065A01
    .CursorPositionY
    db $83, $93, $A3, $B3

    ; $065A05
    .CursorIndexMovementY
    db $01, $FF

    ; $065A07
    .CursorIndexBoundaryY
    db $04, $FF

    ; $065A09
    .CursorStickY
    db $00, $03

    ; $065A0B
    .YtoXIndexOffset
    dw $0000, $0020, $0040, $0060

    ; $065A13
    .HeartXPosition
    db $1F, $2F, $3F, $4F, $5F, $6F

    ; $065A19
    .CursorMovement
    dw  -1,   1,  -1,   1
    dw  -1,   1,  -1,   1
    dw  -1,   1,  -1,   1
    dw  -1,   1,  -1,   1
    dw  -2,   2,  -2,   2
    dw  -2,   2,  -2,   2
    dw  -4,   4
}

; $065A4D-$065C8B JUMP LOCATION
NameFile_DoTheNaming:
{
    .BRANCH_1
    
    LDY.w $0B13 : BEQ .BRANCH_6
        TYA : CMP.b #$31 : BEQ .BRANCH_2
            CLC : ADC.b #$04 : STA.w $0B13
    
        .BRANCH_2
        
        LDA.w $0B10 : ASL : TAX
        
        REP #$20
        
        DEY
        
        LDA.w $0630 : CMP.l Pool_NameFile_CursorPositionX, X : BNE .BRANCH_4
            SEP #$20
            
            LDA.b #$30 : STA.w $0B13
            
            LDA.b $F0 : AND.b #$03 : BNE .BRANCH_3
                STZ.w $0B13
        
            .BRANCH_3
        
            JSR.w NameFile_CheckForScrollInputX
            
            BRA .BRANCH_1
        
        .BRANCH_4
        
        REP #$20
        
        LDX.w $0B16 : BNE .BRANCH_5
            INY : INY
        
        .BRANCH_5
        
        LDA.w $0630
        TYX
        CLC : ADC.l Pool_NameFile_CursorMovement, X : AND.w #$01FF : STA.w $0630
        
        SEP #$20
        
        BRA .BRANCH_7
    
    .BRANCH_6
    
    JSR.w NameFile_CheckForScrollInputX
    
    .BRANCH_7
    
    LDA.w $0B14 : BEQ .BRANCH_10
        LDX.w $0B15

        LDY.b #$02
        
        LDA.w $0B11 : CMP.l Pool_NameFile_CursorPositionY, X : BNE .BRANCH_8
            STZ.w $0B14
            
            JSR.w NameFile_CheckForScrollInputY
            
            BRA .BRANCH_7
        
        .BRANCH_8
        
        BMI .BRANCH_9
            LDY.b #$FE
        
        .BRANCH_9
        
        TYA : CLC : ADC.w $0B11 : STA.w $0B11
        
        BRA .BRANCH_11
    
    .BRANCH_10
    
    JSR.w NameFile_CheckForScrollInputY
    
    .BRANCH_11
    
    LDX.b #$00 : TXY
    
    LDA.b #$18 : STA.b $00
    
    .BRANCH_12
    
        LDA.b $00        : STA.w $0800, Y
        CLC : ADC.b #$08 : STA.b $00
        
        LDA.w $0B11 : STA.w $0801, Y
        
        LDA.b #$2E : STA.w $0802, Y
        
        LDA.b #$3C : STA.w $0803, Y
        
        STZ.w $0A20, X
        
        INY #4
    INX : CPX.b #$1A : BNE .BRANCH_12
    
    PHX
    
    LDX.w $0B12
    LDA.l Pool_NameFile_HeartXPosition, X : STA.w $0800, Y
    
    LDA.b #$58 : STA.w $0801, Y
    
    PLX
    
    LDA.b #$29 : STA.w $0802, Y
    LDA.b #$0C : STA.w $0803, Y
    
    STZ.w $0A20, X
    
    LDA.w $0B13 : ORA.w $0B14 : BNE .BRANCH_14
        LDA.b $F4 : AND.b #$10 : BEQ .BRANCH_13
            JMP.w NameFile_DoTheNaming_confirm_name
        
        .BRANCH_13
        
        LDA.b $F4 : AND.b #$C0 : BNE .BRANCH_15
            LDA.b $F6 : AND.b #$C0 : BNE .BRANCH_15
    
    .BRANCH_14
    
    JMP.w .exit
    
    .BRANCH_15
    
    ; Play low life warning beep sound?
    LDA.b #$2B : STA.w $012E
    
    REP #$30
    
    LDA.w $0B15 : AND.w #$00FF : ASL : TAX
    LDA.l Pool_NameFile_YtoXIndexOffset, X : CLC : ADC.w $0B10 : AND.w #$00FF : TAX
    
    SEP #$20
    
    LDA.l Pool_NameFile_CharacterLayout, X : CMP.b #$5A : BEQ .BRANCH_16
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
    
    LDA.w $0B12 : AND.w #$00FF : ASL : TAY
    CLC : ADC.w $0200                : TAX
    
    LDA.b $00 : AND.w #$FFF0 : ASL : ORA.b $02 : STA.l $7003D9, X
    
    JSR.w NameFile_DrawSelectedCharacter
    
    BRA .BRANCH_18
    
    ; $065BB1 ALTERNATE ENTRY POINT
    .confirm_name
    
    REP #$30
    
    STZ.b $02
    
    .BRANCH_22

    ; Checking if the spot is blank.
    LDA.w $0200 : CLC : ADC.b $02 : TAX
    LDA.l $7003D9, X : CMP.w #$00A9 : BNE .BRANCH_25
        LDA.b $02 : CMP.w #$000A : BEQ .BRANCH_23
            INC : INC : STA.b $02
            
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
    
    LDA.b $C8 : ASL : INC : INC : STA.l $701FFE
                                  TAX
    
    LDA.l SaveFileOffsets, X : STA.b $00
                               TAX
    
    LDA.w #$55AA : STA.l $7003E5, X
    
    LDA.w #$F000 : STA.l $70020C, X
                   STA.l $70020E, X
    
    LDA.w #$FFFF : STA.l $700405, X
    
    LDA.w #$001D : STA.b $02
    
    ; Branch if it's not the first save game slot.
    LDY.w #$003C : CPX.w #$0000 : BNE .loadInitialEquipment
        ; OPTIMIZE: Just add a BRA.
        ; DEBUG: Lol.... wow, this is checking if the end of the "get joypad input"
        ; routine ends with an RTS instruction or not. In otherwords, it's
        ; checking the game's own code to determine if the player 2 joypad is
        ; enabled interesting manuever, I must say.
        LDA.l Player2JoypadReturn : AND.w #$00FF : CMP.w #$0060 : BEQ .loadInitialEquipment
            ; If the first letter of the player's name is not an uppercase 'B',
            ; no cheat code for you!
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
                
                ; Set map indicators on overworld and put Link starting in his
                ; house.
                LDA.w #$0100 : STA.l $7003C7, X
                
                LDY.w #$0000
        
    .loadInitialEquipment

        ; Setup initial equipment and flags values.
        LDA.w DefaultSaveFileItems, Y : STA.l $700340, X
            
        INX : INX
        INY : INY
    DEC.b $02 : BPL .loadInitialEquipment
    
    LDX.b $00
    
    LDY.w #$0000 : TYA
    
    .computeChecksum
    
        CLC : ADC.l $700000, X
        
        INX : INX
    INY : CPY.w #$027F : BNE .computeChecksum
    
    STA.b $02
    
    LDX.b $00
    LDA.w #$5A5A : SEC : SBC.b $02 : STA.l $7004FE, X
    
    SEP #$30
    
    ; Reset the bank.
    PLB
    
    JSR.w ReturnToFileSelect
    
    LDA.b #$FF : STA.w $0128
    
    LDA.b #$2C : STA.w $012E

    ; $065BD9 ALTERNATE ENTRY POINT
    .exit
    
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
        
        DEC : STA.w $0B16
        
        REP #$30
        
        AND.w #$00FF : ASL : TAX
        
        LDA.w $0B10 : AND.w #$00FF
        CLC : ADC.l Pool_NameFile_CursorIndexMovementX, X
        CMP.l Pool_NameFile_CursorIndexBoundaryX, X : BNE .BRANCH_1
            LDA.l Pool_NameFile_CursorIndexWrapX, X
        
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
        ASL : ORA.w $0B15 : CMP.b #$10 : BEQ .BRANCH_6
            LDA.b $02 : ASL : ASL : ORA.w $0B15
            
            LDX.w $0B10
            
            CMP.b #$13 : BEQ .BRANCH_6
                LDA.b $02 : LSR : LSR
                
                .BRANCH_1
                
                    TAX
                    LDA.w $0B15
                    CLC : ADC.l Pool_NameFile_CursorIndexMovementY-1, X
                    CMP.l Pool_NameFile_CursorIndexBoundaryY-1, X : BNE .BRANCH_2
                        LDA.l Pool_NameFile_CursorStickY-1, X
                    
                    .BRANCH_2
                    
                    STA.w $0B15
                    
                    BRA .BRANCH_3
                    
                    ; Unreachable code?
                    STA.b $01
                    
                    LDX.w $0B15
                    LDA.l Pool_NameFile_YtoXIndexOffset, X : CLC : ADC.w $0B10 : AND.b #$FF : TAX
                    
                    LDA.l Pool_NameFile_CharacterLayout, X
                    
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

; $065D24-$065D2F DATA
NameFile_DrawSelectedCharacter_VRAM_position_low:
{
    dw $0084
    dw $0086
    dw $0088
    dw $008A
    dw $008C
    dw $008E
}

; $065D30-$065D6C LOCAL JUMP LOCATION
NameFile_DrawSelectedCharacter:
{
    PHB : PHK : PLB
    
    LDA.w #$6100 : ORA.w .VRAM_position_low, Y : XBA : STA.w $1002
    XBA : CLC : ADC.w #$0020 : XBA : STA.w $1008
    
    LDA.w #$0100 : STA.w $1004
                   STA.w $100A
    
    LDA.l $7003D9, X : ORA.w #$1800 : STA.w $1006
    CLC : ADC.w #$0010              : STA.w $100C
    
    SEP #$30
    
    LDA.b #$FF : STA.w $100E
    
    LDA.b #$01 : STA.b $14
    
    PLB
    
    RTS
}

; ==============================================================================

; $065D6D-$0661C7 DATA
IntroLogoTilemap:
{
    dw $0B11, $1900 ; VRAM $2216 | 26 bytes | Horizontal
    dw $1D68, $1D69, $1D6A, $1D6B, $1D5D, $1D5E, $1C30, $1C31
    dw $1C32, $1C33, $1C34, $1C35, $1C36

    dw $2B11, $1900 ; VRAM $2256 | 26 bytes | Horizontal
    dw $1D78, $1D79, $1D7A, $1D7B, $1C37, $1C38, $1C39, $1C3A
    dw $1C3B, $1C3C, $1C3D, $1C3E, $1C3F

    dw $4611, $2500 ; VRAM $228C | 38 bytes | Horizontal
    dw $18F7, $1900, $1901, $1902, $1903, $1904, $1905, $1905
    dw $1906, $1905, $1907, $5907, $1905, $1908, $1909, $190A
    dw $190B, $190C, $1CF0

    dw $6611, $2300 ; VRAM $22CC | 36 bytes | Horizontal
    dw $190D, $190E, $18F9, $390F, $1910, $1911, $1912, $1913
    dw $1914, $1915, $18FA, $58FA, $1916, $1917, $1918, $18FB
    dw $1919, $191A

    dw $8611, $2300 ; VRAM $230C | 36 bytes | Horizontal
    dw $18F8, $195F, $391B, $391C, $191D, $191E, $191F, $1920
    dw $1921, $1922, $195F, $195F, $1923, $1924, $1925, $1926
    dw $1927, $1928

    dw $A811, $1F00 ; VRAM $2350 | 32 bytes | Horizontal
    dw $3929, $392A, $192B, $191E, $192C, $192D, $1938, $1922
    dw $195F, $195F, $1923, $18FC, $192E, $192F, $1930, $1931

    dw $C711, $2300 ; VRAM $238E | 36 bytes | Horizontal
    dw $1932, $3933, $3934, $195F, $191E, $191F, $1936, $1937
    dw $1922, $195F, $1939, $1923, $9924, $193A, $193B, $193C
    dw $193D, $193E

    dw $E711, $2300 ; VRAM $23CE | 36 bytes | Horizontal
    dw $193F, $3940, $3941, $195F, $1942, $1943, $1944, $1945
    dw $1946, $1947, $1948, $1949, $194A, $194B, $194C, $194D
    dw $194E, $194F

    dw $0612, $2500 ; VRAM $240C | 38 bytes | Horizontal
    dw $18FD, $1950, $3951, $98F9, $1952, $1953, $1954, $1954
    dw $1955, $1954, $1954, $1956, $1954, $1957, $1958, $1959
    dw $195A, $195B, $195C

    dw $2612, $2B00 ; VRAM $244C | 44 bytes | Horizontal
    dw $18F1, $18F2, $18F3, $18F4, $18F5, $18F6, $1D60, $1D61
    dw $1D62, $1D63, $1D64, $1D65, $1D66, $1D67, $1D68, $1D69
    dw $1D6A, $1D6B, $1D6C, $1D6D, $1D6E, $1D6F

    dw $4C12, $1F00 ; VRAM $2498 | 32 bytes | Horizontal
    dw $1D70, $1D71, $1D72, $1D73, $1D74, $1D75, $1D76, $1D77
    dw $1D78, $1D79, $1D7A, $1D7B, $1D7C, $1D7D, $1D7E, $1D7F

    dw $8000, $BE41 ; VRAM $0100 | 448 bytes | Fixed horizontal
    dw $10BD

    dw $6501, $2A40 ; VRAM $02CA | 44 bytes | Fixed horizontal
    dw $10BE

    dw $8801, $2440 ; VRAM $0310 | 38 bytes | Fixed horizontal
    dw $10BF

    dw $2802, $2440 ; VRAM $0450 | 38 bytes | Fixed horizontal
    dw $90BF

    dw $4502, $2A40 ; VRAM $048A | 44 bytes | Fixed horizontal
    dw $90BE

    dw $6A02, $1A40 ; VRAM $04D4 | 28 bytes | Fixed horizontal
    dw $90BD

    dw $4001, $1300 ; VRAM $0280 | 20 bytes | Horizontal
    dw $11B3, $11B4, $51B4, $51B3, $10BD, $10BD, $11B3, $11B4
    dw $51B4, $51B3

    dw $5801, $0500 ; VRAM $02B0 | 6 bytes | Horizontal
    dw $11B3, $11B4, $51B4

    dw $6001, $0900 ; VRAM $02C0 | 10 bytes | Horizontal
    dw $10B0, $10B1, $10B2, $10B3, $10B4

    dw $8001, $0F00 ; VRAM $0300 | 16 bytes | Horizontal
    dw $10B5, $10B6, $10B7, $10B8, $10B9, $10BA, $10BB, $10BC

    dw $A001, $3500 ; VRAM $0340 | 54 bytes | Horizontal
    dw $09C9, $09CA, $09C9, $09CA, $09C9, $09CA, $09C9, $09CA
    dw $09FF, $09E7, $09E8, $09E7, $09E8, $09E7, $09E8, $09E7
    dw $09E8, $09E7, $09E8, $09E7, $09E8, $09E7, $09E8, $09E7
    dw $09E8, $09E7, $09E8

    dw $C001, $3500 ; VRAM $0380 | 54 bytes | Horizontal
    dw $09D9, $09DA, $09D9, $09DA, $09D9, $09DA, $09D9, $09DA
    dw $09D9, $09DA, $09D9, $09DA, $09D9, $09DA, $09D9, $09DA
    dw $09D9, $09DA, $09D9, $09DA, $09D9, $09DA, $09D9, $09DA
    dw $09D9, $09DA, $09D9

    dw $E001, $3500 ; VRAM $03C0 | 54 bytes | Horizontal
    dw $0DB1, $0DB2, $0DB1, $0DB2, $0DB1, $0DB2, $0DB1, $0DB2
    dw $0DB1, $0DB2, $0DB1, $0DB2, $0DB1, $0DB2, $0DB1, $0DB2
    dw $0DB1, $0DB2, $0DB1, $0DB2, $0DB1, $0DB2, $0DB1, $0DB2
    dw $0DB1, $0DB2, $0DB1

    dw $0002, $3500 ; VRAM $0400 | 54 bytes | Horizontal
    dw $8DC9, $8DCA, $8DC9, $8DCA, $8DC9, $8DCA, $8DC9, $8DCA
    dw $8DFF, $8DE7, $8DE8, $8DE7, $8DE8, $8DE7, $8DE8, $8DE7
    dw $8DE8, $8DE7, $8DE8, $8DE7, $8DE8, $8DE7, $8DE8, $8DE7
    dw $8DE8, $8DE7, $8DE8

    dw $2002, $0F00 ; VRAM $0440 | 16 bytes | Horizontal
    dw $90B5, $90B6, $90B7, $90B8, $90B9, $90BA, $90BB, $90BC

    dw $4002, $0900 ; VRAM $0480 | 10 bytes | Horizontal
    dw $90B0, $90B1, $90B2, $90B3, $90B4

    dw $6002, $1300 ; VRAM $04C0 | 20 bytes | Horizontal
    dw $91B3, $91B4, $D1B4, $D1B3, $90BD, $90BD, $91B3, $91B4
    dw $D1B4, $D1B3

    dw $7802, $0500 ; VRAM $04F0 | 6 bytes | Horizontal
    dw $91B3, $91B4, $D1B4

    dw $8002, $3500 ; VRAM $0500 | 54 bytes | Horizontal
    dw $11F0, $11F1, $11F0, $11F1, $11F0, $11F1, $11F0, $11F1
    dw $11F0, $11F1, $11F0, $11F1, $11F0, $11F1, $11F0, $11F1
    dw $11F0, $11F1, $11F0, $11F1, $11F0, $11F1, $11F0, $11F1
    dw $11F0, $11F1, $11F0

    dw $A002, $3500 ; VRAM $0540 | 54 bytes | Horizontal
    dw $11F2, $11F3, $11F2, $11F3, $11F2, $11F3, $11F2, $11F3
    dw $11F2, $11F3, $11F2, $11F3, $11F2, $11F3, $11F2, $11F3
    dw $11F2, $11F3, $11F2, $11F3, $11F2, $11F3, $11F2, $11F3
    dw $11F2, $11F3, $11F2

    dw $3B01, $1980 ; VRAM $0276 | 26 bytes | Vertical
    dw $15F6, $15F4, $15CB, $15DB, $15DB, $15DB, $15DB, $15DB
    dw $15EB, $15FB, $15FD, $15FD, $15FD

    dw $3C01, $1980 ; VRAM $0278 | 26 bytes | Vertical
    dw $15F7, $15F5, $15DC, $15DC, $15DC, $15DC, $15DC, $15DC
    dw $15B0, $15FC, $15FE, $15FE, $15FE

    dw $3D01, $1980 ; VRAM $027A | 26 bytes | Vertical
    dw $15F8, $15CD, $15DD, $15DD, $15DD, $15DD, $15DD, $15DD
    dw $15CC, $15ED, $14BD, $14BD, $15FE

    dw $9E00, $2380 ; VRAM $013C | 36 bytes | Vertical
    dw $15F6, $15F4, $15CB, $15DB, $15E9, $15F9, $15CE, $15DE
    dw $15DE, $15DE, $15DE, $15DE, $15DE, $15CC, $15EE, $14BD
    dw $14BD, $14BD

    dw $9F00, $2380 ; VRAM $013E | 36 bytes | Vertical
    dw $15F7, $15F5, $15DC, $15DC, $15EA, $15FA, $15CF, $15DF
    dw $15DF, $15DF, $15DF, $15DF, $15DF, $15CC, $15EF, $14BD
    dw $14BD, $14BD

    db $FF ; End of stripes data
}

; ==============================================================================

; $0661C8-$0662A7 DATA
FancyBackgroundTileMap:
{
    dw $4210, $2700 ; VRAM $2084 | 40 bytes | Horizontal
    dw $3589, $358A, $358B, $358C, $358B, $358C, $358B, $358C
    dw $358B, $358C, $358B, $358C, $358B, $358C, $358B, $358C
    dw $358B, $358C, $758A, $7589

    dw $6210, $0300 ; VRAM $20C4 | 4 bytes | Horizontal
    dw $3599, $359A

    dw $6410, $1E40 ; VRAM $20C8 | 32 bytes | Fixed horizontal
    dw $347F

    dw $7410, $0300 ; VRAM $20E8 | 4 bytes | Horizontal
    dw $759A, $7599

    dw $8210, $0300 ; VRAM $2104 | 4 bytes | Horizontal
    dw $35A9, $35AA

    dw $8410, $1E40 ; VRAM $2108 | 32 bytes | Fixed horizontal
    dw $347F

    dw $9410, $0300 ; VRAM $2128 | 4 bytes | Horizontal
    dw $75AA, $75A9

    dw $A210, $2700 ; VRAM $2144 | 40 bytes | Horizontal
    dw $359D, $35AD, $359B, $359C, $359B, $359C, $359B, $359C
    dw $359B, $359C, $359B, $359C, $359B, $359C, $359B, $359C
    dw $359B, $359C, $75AD, $759D

    dw $C210, $2700 ; VRAM $2184 | 40 bytes | Horizontal
    dw $35AB, $35AC, $35AB, $35AC, $35AB, $35AC, $35AB, $35AC
    dw $35AB, $35AC, $35AB, $35AC, $35AB, $35AC, $35AB, $35AC
    dw $35AB, $35AC, $75AB, $75AC

    dw $E210, $0100 ; VRAM $21C4 | 2 bytes | Horizontal
    dw $3583

    dw $E310, $3240 ; VRAM $21C6 | 52 bytes | Fixed horizontal
    dw $3585

    dw $FD10, $0100 ; VRAM $21FA | 2 bytes | Horizontal
    dw $3584

    dw $0211, $22C0 ; VRAM $2204 | 36 bytes | Fixed vertical
    dw $3586

    dw $1D11, $22C0 ; VRAM $223A | 36 bytes | Fixed vertical
    dw $3596

    dw $4213, $0100 ; VRAM $2684 | 2 bytes | Horizontal
    dw $3593

    dw $4313, $3240 ; VRAM $2686 | 52 bytes | Fixed horizontal
    dw $3595

    dw $5D13, $0100 ; VRAM $26BA | 2 bytes | Horizontal
    dw $3594
}

; ==============================================================================

; $0662A8-$066358 DATA
FileSelectTilemap:
{
    dw $6560, $1B00 ; VRAM $C0CA | 28 bytes | Horizontal
    dw $180F, $180B, $1800, $1828, $1804, $1821, $18A9, $18A9
    dw $1822, $1804, $180B, $1804, $1802, $1823

    dw $8560, $1B00 ; VRAM $C10A | 28 bytes | Horizontal
    dw $181F, $181B, $1810, $1838, $1814, $1831, $18B9, $18B9
    dw $1832, $1814, $181B, $1814, $1812, $1833

    dw $C662, $1700 ; VRAM $C58C | 24 bytes | Horizontal
    dw $1802, $180E, $180F, $1828, $18A9, $18A9, $180F, $180B
    dw $1800, $1828, $1804, $1821

    dw $E662, $1700 ; VRAM $C5CC | 24 bytes | Horizontal
    dw $1812, $181E, $181F, $1838, $18A9, $18A9, $181F, $181B
    dw $1810, $1838, $1814, $1831

    dw $0663, $1700 ; VRAM $C60C | 24 bytes | Horizontal
    dw $1804, $1821, $1800, $1822, $1804, $18A9, $180F, $180B
    dw $1800, $1828, $1804, $1821

    dw $2663, $1700 ; VRAM $C64C | 24 bytes | Horizontal
    dw $1814, $1831, $1810, $1832, $1814, $18A9, $181F, $181B
    dw $1810, $1838, $1814, $1831

    db $FF ; End of stripes data
}

; ==============================================================================

; $066359-$066455 DATA
FileSelectNamesTilemap:
{
    dw $2961, $2500 ; VRAM $C252 | 38 bytes | Horizontal
    dw $18E7, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $4961, $2500 ; VRAM $C292 | 38 bytes | Horizontal
    dw $18F7, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $A961, $2500 ; VRAM $C352 | 38 bytes | Horizontal
    dw $18E8, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $C961, $2500 ; VRAM $C392 | 38 bytes | Horizontal
    dw $18F8, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $2962, $2500 ; VRAM $C452 | 38 bytes | Horizontal
    dw $18E9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $4962, $2500 ; VRAM $C492 | 38 bytes | Horizontal
    dw $18F9, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    db $FF ; End of stripes data
}

; ==============================================================================

; $066456-$06653E DATA
FileSelectKILLFileTilemap:
{
    dw $6560, $1700 ; VRAM $C0CA | 24 bytes | Horizontal
    dw $1804, $1821, $1800, $1822, $1804, $18A9, $180F, $180B
    dw $1800, $1828, $1804, $1821

    dw $8560, $1700 ; VRAM $C10A | 24 bytes | Horizontal
    dw $1814, $1831, $1810, $1832, $1814, $18A9, $181F, $181B
    dw $1810, $1838, $1814, $1831

    dw $0461, $2F00 ; VRAM $C208 | 48 bytes | Horizontal
    dw $1826, $1807, $18AF, $1802, $1807, $18A9, $180F, $180B
    dw $1800, $1828, $1804, $1821, $18A9, $1803, $180E, $18A9
    dw $1828, $180E, $1824, $18A9, $1826, $1800, $180D, $1823

    dw $2461, $2F00 ; VRAM $C248 | 48 bytes | Horizontal
    dw $1836, $1817, $18BF, $1812, $1817, $18A9, $181F, $181B
    dw $1810, $1838, $1814, $1831, $18A9, $1813, $181E, $18A9
    dw $1838, $181E, $1834, $18A9, $1836, $1810, $181D, $1833

    dw $4461, $1300 ; VRAM $C288 | 20 bytes | Horizontal
    dw $1823, $180E, $18A9, $1804, $1821, $1800, $1822, $1804
    dw $18A9, $186F

    dw $6461, $1300 ; VRAM $C2C8 | 20 bytes | Horizontal
    dw $1833, $181E, $18A9, $1814, $1831, $1810, $1832, $1814
    dw $18A9, $187F

    dw $0663, $0700 ; VRAM $C60C | 8 bytes | Horizontal
    dw $1820, $1824, $18AF, $1823

    dw $2663, $0700 ; VRAM $C64C | 8 bytes | Horizontal
    dw $1830, $1834, $18BF, $1833

    db $FF ; End of stripes data
}

; ==============================================================================

; $06653F-$06663B DATA
KILLFile_BlankNameStripes:
{
    dw $A761, $2500 ; VRAM $C34E | 38 bytes | Horizontal
    dw $18E7, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $C761, $2500 ; VRAM $C38E | 38 bytes | Horizontal
    dw $18F7, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $0762, $2500 ; VRAM $C40E | 38 bytes | Horizontal
    dw $18E8, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $2762, $2500 ; VRAM $C44E | 38 bytes | Horizontal
    dw $18F8, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $6762, $2500 ; VRAM $C4CE | 38 bytes | Horizontal
    dw $18E9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    dw $8762, $2500 ; VRAM $C50E | 38 bytes | Horizontal
    dw $18F9, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18A9

    db $FF ; End of stripes data
}

; ==============================================================================

; $06663C-$06668C DATA
FileSelectCopyFileTilemap:
{
    dw $6560, $1700 ; VRAM $C0CA | 24 bytes | Horizontal
    dw $1802, $180E, $180F, $1828, $18A9, $18A9, $180F, $180B
    dw $1800, $1828, $1804, $1821

    dw $8560, $1700 ; VRAM $C10A | 24 bytes | Horizontal
    dw $1812, $181E, $181F, $1838, $18A9, $18A9, $181F, $181B
    dw $1810, $1838, $1814, $1831

    dw $0663, $0700 ; VRAM $C60C | 8 bytes | Horizontal
    dw $1820, $1824, $18AF, $1823

    dw $2663, $0700 ; VRAM $C64C | 8 bytes | Horizontal
    dw $1830, $1834, $18BF, $1833

    db $FF ; End of stripes data
}

; ==============================================================================

; $06668D-$066739 DATA
CopyFile_HeaderStripe:
{
    dw $0461, $1500 ; VRAM $C208 | 22 bytes | Horizontal
    dw $1885, $1826, $1807, $18AF, $1802, $1807, $186F, $1886
    dw $18A9, $18A9, $18A9

    dw $2461, $1500 ; VRAM $C248 | 22 bytes | Horizontal
    dw $1895, $1836, $1817, $18BF, $1812, $1817, $187F, $1896
    dw $18A9, $18A9, $18A9

    dw $6761, $0F00 ; VRAM $C2CE | 16 bytes | Horizontal
    dw $18E7, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $8761, $0F00 ; VRAM $C30E | 16 bytes | Horizontal
    dw $18F7, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $C761, $0F00 ; VRAM $C38E | 16 bytes | Horizontal
    dw $18E8, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $E761, $0F00 ; VRAM $C3CE | 16 bytes | Horizontal
    dw $18F8, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $2762, $0F00 ; VRAM $C44E | 16 bytes | Horizontal
    dw $18E9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $4762, $0F00 ; VRAM $C48E | 16 bytes | Horizontal
    dw $18F9, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    db $FF ; End of stripes data
}

; ==============================================================================

; $06673A-$0667BE DATA
CopyFile_TargetHeaderStripes:
{
    dw $5161, $1500 ; VRAM $C2A2 | 22 bytes | Horizontal
    dw $1885, $1823, $180E, $18A9, $1826, $1807, $18AF, $1802
    dw $1807, $186F, $1886

    dw $7161, $1500 ; VRAM $C2E2 | 22 bytes | Horizontal
    dw $1895, $1833, $181E, $18B9, $1836, $1817, $18BF, $1812
    dw $1817, $187F, $1896

    dw $B461, $0F00 ; VRAM $C368 | 16 bytes | Horizontal
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $D461, $0F00 ; VRAM $C3A8 | 16 bytes | Horizontal
    dw $18A9, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $1462, $0F00 ; VRAM $C428 | 16 bytes | Horizontal
    dw $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    dw $3462, $0F00 ; VRAM $C468 | 16 bytes | Horizontal
    dw $18A9, $1891, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9

    db $FF ; End of stripes data
}

; ==============================================================================

; $0667BF-$066D79 DATA
NamePlayerTilemap:
{
    dw $A410, $2A40 ; VRAM $2148 | 44 bytes | Fixed horizontal
    dw $147F

    dw $C410, $2A40 ; VRAM $2188 | 44 bytes | Fixed horizontal
    dw $147F

    dw $6311, $1840 ; VRAM $22C6 | 26 bytes | Fixed horizontal
    dw $147F

    dw $8311, $1840 ; VRAM $2306 | 26 bytes | Fixed horizontal
    dw $147F

    dw $A311, $1840 ; VRAM $2346 | 26 bytes | Fixed horizontal
    dw $147F

    dw $E311, $3240 ; VRAM $23C6 | 52 bytes | Fixed horizontal
    dw $147F

    dw $0312, $3240 ; VRAM $2406 | 52 bytes | Fixed horizontal
    dw $147F

    dw $2312, $3240 ; VRAM $2446 | 52 bytes | Fixed horizontal
    dw $147F

    dw $4302, $3240 ; VRAM $2486 | 52 bytes | Fixed horizontal
    dw $147F

    dw $6312, $3240 ; VRAM $24C6 | 52 bytes | Fixed horizontal
    dw $147F

    dw $8312, $3240 ; VRAM $2506 | 52 bytes | Fixed horizontal
    dw $147F

    dw $A312, $3240 ; VRAM $2546 | 52 bytes | Fixed horizontal
    dw $147F

    dw $C312, $3240 ; VRAM $2586 | 52 bytes | Fixed horizontal
    dw $147F

    dw $E312, $3240 ; VRAM $25C6 | 52 bytes | Fixed horizontal
    dw $147F

    dw $0313, $3240 ; VRAM $2606 | 52 bytes | Fixed horizontal
    dw $147F

    dw $8210, $3300 ; VRAM $2104 | 52 bytes | Horizontal
    dw $1589, $158A, $158B, $158C, $158B, $158C, $158B, $158C
    dw $158B, $158C, $158B, $158C, $158B, $158C, $158B, $158C
    dw $158B, $158C, $158B, $158C, $158B, $158C, $158B, $158C
    dw $558A, $5589

    dw $A210, $0300 ; VRAM $2144 | 4 bytes | Horizontal
    dw $1599, $159A

    dw $BA10, $0300 ; VRAM $2174 | 4 bytes | Horizontal
    dw $559A, $5599

    dw $C210, $0300 ; VRAM $2184 | 4 bytes | Horizontal
    dw $15A9, $15AA

    dw $DA10, $0300 ; VRAM $21B4 | 4 bytes | Horizontal
    dw $559A, $5599

    dw $E210, $3300 ; VRAM $21C4 | 52 bytes | Horizontal
    dw $159D, $15AD, $159B, $159C, $159B, $159C, $159B, $159C
    dw $159B, $159C, $159B, $159C, $159B, $159C, $159B, $159C
    dw $159B, $159C, $159B, $159C, $159B, $159C, $159B, $159C
    dw $55AD, $559D

    dw $0211, $3300 ; VRAM $2204 | 52 bytes | Horizontal
    dw $15AB, $15AC, $15AB, $15AC, $15AB, $15AC, $15AB, $15AC
    dw $15AB, $15AC, $15AB, $15AC, $15AB, $15AC, $15AB, $15AC
    dw $15AB, $15AC, $15AB, $15AC, $15AB, $15AC, $15AB, $15AC
    dw $15AB, $15AC

    dw $4211, $1D00 ; VRAM $2284 | 30 bytes | Horizontal
    dw $1587, $1588, $1587, $1588, $1587, $1588, $1587, $1588
    dw $1587, $1588, $1587, $1588, $1587, $1588, $1587

    dw $6211, $1B80 ; VRAM $22C4 | 28 bytes | Vertical
    dw $15AF, $15A7, $15AF, $15A7, $15AF, $15A7, $15AF, $15A7
    dw $15AF, $15A7, $15AF, $15A7, $15AF, $15A7

    dw $7011, $0580 ; VRAM $22E0 | 6 bytes | Vertical
    dw $15A8, $15AE, $15A8

    dw $C311, $3500 ; VRAM $2386 | 54 bytes | Horizontal
    dw $1588, $1598, $1588, $1598, $1588, $1598, $1588, $1598
    dw $1588, $1598, $1588, $1598, $1588, $1598, $1588, $1587
    dw $1588, $1587, $1588, $1587, $1588, $1587, $1588, $1587
    dw $1588, $1587, $1588

    dw $FD11, $1380 ; VRAM $23FA | 20 bytes | Vertical
    dw $15A8, $15AE, $15A8, $15AE, $15A8, $15AE, $15A8, $15AE
    dw $15A8, $15AE

    dw $2213, $3700 ; VRAM $2644 | 56 bytes | Horizontal
    dw $1597, $1598, $1597, $1598, $1597, $1598, $1597, $1598
    dw $1597, $1598, $1597, $1598, $1597, $1598, $1597, $1598
    dw $1597, $1598, $1597, $1598, $1597, $1598, $1597, $1598
    dw $1597, $1598, $1597, $1598

    dw $F011, $12C0 ; VRAM $23E0 | 20 bytes | Fixed vertical
    dw $158D

    dw $A460, $2B00 ; VRAM $C148 | 44 bytes | Horizontal
    dw $18A9, $1821, $1804, $1806, $18AF, $1822, $1823, $1804
    dw $1821, $18A9, $18A9, $1828, $180E, $1824, $1821, $18A9
    dw $18A9, $180D, $1800, $180C, $1804, $18A9

    dw $C460, $2B00 ; VRAM $C188 | 44 bytes | Horizontal
    dw $18A9, $1831, $1814, $1816, $18BF, $1832, $1833, $1814
    dw $1831, $18A9, $18A9, $1838, $181E, $1834, $1831, $18A9
    dw $18A9, $181D, $1810, $181C, $1814, $18A9

    dw $0262, $3900 ; VRAM $C404 | 58 bytes | Horizontal
    dw $1800, $18A9, $1801, $18A9, $1802, $18A9, $1803, $18A9
    dw $1804, $18A9, $1805, $18A9, $1806, $18A9, $1807, $18A9
    dw $18AF, $18A9, $1809, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $182A, $18A9, $182B, $18A9, $182C

    dw $2262, $3900 ; VRAM $C444 | 58 bytes | Horizontal
    dw $1810, $18A9, $1811, $18A9, $1812, $18A9, $1813, $18A9
    dw $1814, $18A9, $1815, $18A9, $1816, $18A9, $1817, $18A9
    dw $18BF, $18A9, $1819, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $183A, $18A9, $183B, $18A9, $183C

    dw $4262, $3900 ; VRAM $C484 | 58 bytes | Horizontal
    dw $180A, $18A9, $180B, $18A9, $180C, $18A9, $180D, $18A9
    dw $180E, $18A9, $180F, $18A9, $1820, $18A9, $1821, $18A9
    dw $1822, $18A9, $1823, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $1844, $18A9, $18AF, $18A9, $1846

    dw $6262, $3900 ; VRAM $C4C4 | 58 bytes | Horizontal
    dw $181A, $18A9, $181B, $18A9, $181C, $18A9, $181D, $18A9
    dw $181E, $18A9, $181F, $18A9, $1830, $18A9, $1831, $18A9
    dw $1832, $18A9, $1833, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $1854, $18A9, $18BF, $18A9, $1856

    dw $8262, $3900 ; VRAM $C504 | 58 bytes | Horizontal
    dw $1824, $18A9, $1825, $18A9, $1826, $18A9, $1827, $18A9
    dw $1828, $18A9, $1829, $18A9, $1880, $18A9, $1881, $18A9
    dw $1882, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $184E, $18A9, $184F, $18A9, $1860

    dw $A262, $3900 ; VRAM $C544 | 58 bytes | Horizontal
    dw $1834, $18A9, $1835, $18A9, $1836, $18A9, $1837, $18A9
    dw $1838, $18A9, $1839, $18A9, $1890, $18A9, $1891, $18A9
    dw $1892, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $185E, $18A9, $185F, $18A9, $1870

    dw $CC62, $1100 ; VRAM $C598 | 18 bytes | Horizontal
    dw $18AA, $18A9, $1884, $18A9, $18A9, $18A9, $1804, $180D
    dw $1803

    dw $EC62, $1100 ; VRAM $C5D8 | 18 bytes | Horizontal
    dw $18BA, $18A9, $1894, $18A9, $18A9, $18A9, $1814, $181D
    dw $1813

    dw $0066, $3500 ; VRAM $CC00 | 54 bytes | Horizontal
    dw $182D, $18A9, $182E, $18A9, $182F, $18A9, $1840, $18A9
    dw $1841, $18A9, $18C0, $18A9, $1843, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18E6, $18A9, $18E7, $18A9, $18E8, $18A9
    dw $18E9, $18A9, $18EA

    dw $2066, $3500 ; VRAM $CC40 | 54 bytes | Horizontal
    dw $183D, $18A9, $183E, $18A9, $183F, $18A9, $1850, $18A9
    dw $1851, $18A9, $18D0, $18A9, $1853, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18F6, $18A9, $18F7, $18A9, $18F8, $18A9
    dw $18F9, $18A9, $18FA

    dw $4066, $3500 ; VRAM $CC80 | 54 bytes | Horizontal
    dw $1847, $18A9, $1848, $18A9, $1849, $18A9, $184A, $18A9
    dw $184B, $18A9, $184C, $18A9, $184D, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18EB, $18A9, $18EC, $18A9, $18ED, $18A9
    dw $18EE, $18A9, $18EF

    dw $6066, $3500 ; VRAM $CCC0 | 54 bytes | Horizontal
    dw $1857, $18A9, $1858, $18A9, $1859, $18A9, $185A, $18A9
    dw $185B, $18A9, $185C, $18A9, $185D, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18FB, $18A9, $18FC, $18A9, $18FD, $18A9
    dw $18FE, $18A9, $18FF

    dw $8066, $3100 ; VRAM $CD00 | 50 bytes | Horizontal
    dw $1861, $18A9, $1862, $18A9, $1863, $18A9, $1880, $18A9
    dw $1881, $18A9, $1882, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18C1, $18A9, $186F, $18A9, $1885, $18A9
    dw $1886

    dw $A066, $3100 ; VRAM $CD40 | 50 bytes | Horizontal
    dw $1871, $18A9, $1872, $18A9, $1873, $18A9, $1890, $18A9
    dw $1891, $18A9, $1892, $18A9, $18A9, $18A9, $18A9, $18A9
    dw $18A9, $18A9, $18D1, $18A9, $187F, $18A9, $1895, $18A9
    dw $1896

    dw $C466, $2D00 ; VRAM $CD88 | 46 bytes | Horizontal
    dw $18AA, $18A9, $1884, $18A9, $18A9, $18A9, $1804, $180D
    dw $1803, $18A9, $18A9, $18A9, $18A9, $18A9, $18AA, $18A9
    dw $1884, $18A9, $18A9, $18A9, $1804, $180D, $1803

    dw $E466, $2D00 ; VRAM $CDC8 | 46 bytes | Horizontal
    dw $18BA, $18A9, $1894, $18A9, $18A9, $18A9, $1814, $181D
    dw $1813, $18A9, $18A9, $18A9, $18A9, $18A9, $18BA, $18A9
    dw $1894, $18A9, $18A9, $18A9, $1814, $181D, $1813

    db $FF ; End of stripes data
}

; ==============================================================================

; $066D7A-$066D7E DATA
Pool_Intro_DisplayLogo:
{
    ; $066D7A
    .object_a
    db $60, $70, $80, $88

    ; $066D7E
    .object_b
    db $69, $6B, $6D, $6E
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
        LDA.w Pool_Intro_DisplayLogo_object_a, Y : STA.w $0800, X
        
        ; The (hardcoded) Y coordinate for the Nintendo Logo sprites.
        LDA.b #$68 : STA.w $0801, X
        
        ; The sprite index (which sprite CHR is used.
        LDA.w Pool_Intro_DisplayLogo_object_b, Y : STA.w $0802, X
        
        ; Palette, priority, and flip in formation for each sprite.
        LDA.b #$32 : STA.w $0803, X
        
        DEX #4
    DEY : BPL .setupOam
    
    PLB
    
    RTS
}

; ==============================================================================

; TODO: Confirm what this does.
; Beginning of Module 0x14 - History Mode? Attract Mode
; $066DAD-$066DD1 LONG JUMP LOCATION
Module_Attract:
{
    ; Check the screen brightness.
    LDA.b $13 : BEQ .ignoreInput
        ; If screen is force blanked.
        CMP.b #$80 : BEQ .ignoreInput
            ; Ignore input during all of the fading submodules.
            LDA.b $22  : BEQ .ignoreInput
            CMP.b #$02 : BEQ .ignoreInput
            CMP.b #$06 : BEQ .ignoreInput
                ; Check the joypad for activity on B or Start.
                LDA.b $F4 : AND.b #$90 : BEQ .dontEndSequence
                    ; Begin exiting attract mode if one of those buttons was
                    ; pressed.
                    LDA.b #$09 : STA.b $22

                .dontEndSequence
    
    .ignoreInput
    
    LDA.b $22 : ASL : TAX
    JMP.w (.Submodules, X)

    ; $066DD2
    .Submodules
    dw Attract_Fade             ; 0x00 - $EDE6
    dw Attract_InitGraphics     ; 0x01 - $EE0C
    dw Attract_SlowFadeToBlank  ; 0x02 - $EECB
    dw Attract_PrepNextSequence ; 0x03 - $EEE5
    dw Attract_SlowBrighten     ; 0x04 - $EEBA
    dw Attract_RunSequence      ; 0x05 - $F115
    dw Attract_SlowFadeToBlank  ; 0x06 - $EECB
    dw Attract_PrepNextSequence ; 0x07 - $EEE5
    dw Attract_RunSequence      ; 0x08 - $F115
    dw Attract_Exit             ; 0x09 - $F700
}

; ==============================================================================

; Module 0x14.0x00
; Keeps the title screen status quo running while we darken the screen.
; $066DE6-$066E0B LONG JUMP LOCATION
Attract_Fade:
{
    JSL.l Intro_HandleAllTriforceAnimations
    
    STZ.w $1F00
    STZ.w $012A
    
    JSR.w Intro_InitLogoSword_HandleLogoSword
    
    LDA.b $13 : BEQ .fullyDark
        ; Decrease screen brightness.
        DEC.b $13
        
        RTL
    
    .fullyDark
    
    JSL.l EnableForceBlank
    
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
    
    JSL.l VRAM_EraseTilemaps_normal
    JSL.l Attract_LoadBG3GFX
    
    LDA.b #$04 : STA.w $0AB3
    LDA.b #$01 : STA.w $0AB2
    
    STZ.w $0AA9
    
    JSL.l Palette_HUD
    
    LDA.b #$02 : STA.w $0AA9
    
    JSL.l Palette_OverworldBgMain
    JSL.l Palette_HUD
    JSL.l Palette_ArmorAndGloves
    
    LDA.b #$00 : STA.l $7EC53A
    LDA.b #$38 : STA.l $7EC53B
    
    INC.b $15
    
    LDA.b #$14 : STA.b $EA
    
    JSR.w Attract_BuildBackgrounds
    
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
    
    JSR.w Attract_SetupHDMA
    
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
    
    STZ.w SNES.BG123And4WindowLogic
    STZ.w SNES.ColorAndOBJWindowLogic
    
    ; Resume HDMA next frame using channels 6 and 7.
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
    
    JSL.l EnableForceBlank
    JSL.l VRAM_EraseTilemaps_normal
    
    .nextSubmodule
    
    INC.b $22
    
    RTL
}

; ==============================================================================

; $066EE5-$066EF7 LONG JUMP LOCATION
Attract_PrepNextSequence:
{
    LDA.b $23 : ASL : TAX
    JMP.w (.modules, X)

    ; $066EEC
    .modules
    dw Attract_PrepLegend      ; 0x00 - $EEF8
    dw Attract_PrepMapZoom     ; 0x01 - $EEFF
    dw Attract_PrepThroneRoom  ; 0x02 - $EF4E
    dw Attract_PrepZeldaPrison ; 0x03 - $EFE3
    dw Attract_PrepMaidenWarp  ; 0x04 - $F058
    dw AttractScene_EndOfStory ; 0x05 - $F0DC
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
    LDA.b #$13 : STA.w SNES.BG1AddrAndSize
    LDA.b #$03 : STA.w SNES.BG2AddrAndSize
    
    LDA.b #$80 : STA.b $99
    LDA.b #$21 : STA.b $9A
    
    LDA.b #$07 : STA.w SNES.BGModeAndTileSize
                 STA.b $94
    
    LDA.b #$80 : STA.w SNES.Mode7Init
    
    JSL.l OverworldMap_InitGfx
    
    REP #$20
    
    LDA.w #$00ED : STA.w $063A
    LDA.w #$0100 : STA.w $0638
    
    LDA.w #$0080 : STA.w $0120
    LDA.w #$00C0 : STA.w $0124
    
    SEP #$20
    
    LDA.b #$FF : STA.w $0637
    
    JSR.w Attract_AdjustMapZoom
    
    LDA.b #$01 : STA.b $25
    
    INC.b $22
    
    STZ.b $13
    
    RTL
}

; ==============================================================================

; $066F4E-$066FBF LONG JUMP LOCATION
Attract_PrepThroneRoom:
{
    STZ.w SNES.HDMAChannelEnable
    STZ.b $9B
    
    ; Sets up subscreen addition a certain way because this room has
    ; two floors. This will be disabled in the latter two sequences.
    LDA.b #$02 : STA.b $99
    LDA.b #$20 : STA.b $9A
    
    ; Set misc. sprite index.
    LDA.b #$0A : STA.w $0AA4
    
    JSL.l Graphics_LoadCommonSprLong ; $006384
    
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
    
    JSL.l Attract_LoadDungeonRoom
    
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
    JSL.l Attract_LoadDungeonGfxAndTiles
    
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

    ; Bleeds into the next function.
}
    
; $066FC0-$066FE2 LONG JUMP LOCATION
AttractScene_AdvanceFromDungeon:
{
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
    JSL.l Attract_LoadDungeonRoom
    
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
    JSL.l Attract_LoadDungeonGfxAndTiles
    
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
    
    JMP.w AttractScene_AdvanceFromDungeon
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
    JSL.l Attract_LoadDungeonRoom
    
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
    JSL.l Attract_LoadDungeonGfxAndTiles_justPalettes
    
    LDX.b #$7F
    LDA.b #$02
    JSL.l Attract_LoadDungeonGfxAndTiles
    
    LDA.b #$00 : STA.l $7EC33A
                 STA.l $7EC53A
    LDA.b #$38 : STA.l $7EC33B
                 STA.l $7EC53B
    
    STZ.w $1CD8
    
    LDA.b #$15 : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    LDA.b #$FF : STA.b $25
    
    LDA.b #$70 : STA.b $30
                 STA.b $62

    ; OPTIMIZE: Extra LDA.b #$70
    LDA.b #$70 : STA.b $63
    
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
    
    JMP.w AttractScene_AdvanceFromDungeon
}

; ==============================================================================

; $0670DC-$0670E1 LONG JUMP LOCATION
AttractScene_EndOfStory:
{
    REP #$20
    
    JSL.l OverworldMap_PrepExit_restoreHDMASettings
}

; $0670E2-$067114 LONG JUMP LOCATION
InitializeTriforceIntro:
{
    INC.w $0710
    
    JSL.l Intro_LoadTitleGraphics_noWait
    JSL.l Intro_LoadPalettes_LONG
    
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
    
    LDA.b #$0A : STA.b $11
                 STA.b $B0
    
    RTL
}

; ==============================================================================

; $067115-$067125 LONG JUMP LOCATION
Attract_RunSequence:
{
    LDA.b $23 : ASL : TAX
    JMP.w (Attract_SequenceRoutines, X)

    ; $06711C
    .modules
    dw Attract_Legend      ; 0x00 - $F126
    dw Attract_MapZoom     ; 0x01 - $F176
    dw Attract_ThroneRoom  ; 0x02 - $F1C8
    dw Attract_ZeldaPrison ; 0x03 - $F27A
    dw Attract_MaidenWarp  ; 0x04 - $F423
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
        JSR.w Attract_LoadNextLegendGraphic
        
        STZ.b $27
        
        INC.b $26 : INC.b $26
    
    .noNewGraphic
    
    STZ.b $F2
    STZ.b $F6
    STZ.b $F4
    
    JSL.l Messaging_Text
    
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

; Zoom into hyrule castle on the mode 7 overworld map.
; $067176-$0671AD LONG JUMP LOCATION
Attract_MapZoom:
{
    LDA.w $0637 : CMP.b #$00 : BEQ .advanceToNextSequence
                  CMP.b #$0F : BCS .dontFadeThisFrame
        DEC.b $13
        
        .dontFadeThisFrame
        
        LDY.b #$01
        
        DEC.b $25 : BNE .noZoomAdjustThisFrame
            STY.b $25
            
            ; Decrement the timer/zoom modifier by one.
            LDA.w $0637 : SEC : SBC.b #$01 : STA.w $0637
            
            JSR.w Attract_AdjustMapZoom
        
        .noZoomAdjustThisFrame
        
        RTL
    
    .advanceToNextSequence
    
    JSL.l EnableForceBlank
    
    LDA.b #$09 : STA.w SNES.BGModeAndTileSize
                 STA.b $94
    
    JSL.l VRAM_EraseTilemaps_normal
    
    ; Go to the throne room sequence.
    INC.b $23
    
    DEC.b $22 : DEC.b $22
    
    RTL
}

; ==============================================================================

; $0671AE-$0671C7 DATA
Pool_Attract_ThroneRoom:
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
    db $50 ; King
    db $68 ; Mantle
    
    ; $0671C4
    .offset_y
    db $58 ; King
    db $20 ; Mantle
    
    ; $0671C6
    .OAM_count
    db $03 ; King
    db $05 ; Mantle
}

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
        
        JSR.w Attract_ShowTimedTextMessage
        
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
        
        LDA.l Pool_Attract_ThroneRoom_pointer_size, X     : STA.b $2D
        LDA.l Pool_Attract_ThroneRoom_pointer_offset_x, X : STA.b $02
        LDA.l Pool_Attract_ThroneRoom_pointer_offset_y, X : STA.b $04
        LDA.l Pool_Attract_ThroneRoom_pointer_char, X     : STA.b $06
        LDA.l Pool_Attract_ThroneRoom_pointer_prop, X     : STA.b $08
        
        TXA : AND.w #$00FF : LSR : TAX
        LDA.l Pool_Attract_ThroneRoom_offset_y, X
        AND.w #$00FF : SEC : SBC.w $0122 : STA.b $00
        
        CMP.w #$FFE0 : SEP #$20 : BMI .spriteSetOffscreen
            LDA.l Pool_Attract_ThroneRoom_offset_x, X : STA.b $28
            
            LDA.b $00 : STA.b $29
            
            LDA.l Pool_Attract_ThroneRoom_OAM_count, X : TAY
            JSR.w Attract_DrawSpriteSet
        
        .spriteSetOffscreen
    PLX : DEX : DEX : BPL .nextSpriteSet
    
    RTL
}

; ==============================================================================

; $067260-$067279 DATA
Pool_Attract_Prison:
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

; $06727A-$067318 LONG JUMP LOCATION
Attract_ZeldaPrison:
{
    STZ.b $2A
    
    LDA.b $5F : BNE .brighteningTaskFinished
        JSR.w Attract_SlowBrigthenSetFlag
    
    .brighteningTaskFinished
    
    LDA.b #$38 : STA.b $28
    
    JSR.w Atract_DrawZelda
    
    LDA.b $25 : CMP.b #$C0 : BCS .BRANCH_BETA
        JMP.w AttractDramatize_Agahnim
    
    .BRANCH_BETA
    
    LDA.b #$70 : STA.b $29
    
    DEC.b $50 : BPL .BRANCH_GAMMA
        LDA.b #$0F : STA.b $50
    
    .BRANCH_GAMMA
    
    LDX.b $50
    
    LDA.b $31 : STA.b $40
    
    LDA.b $30 : CLC : ADC.l Pool_Attract_Prison_maiden_jab_offset_x, X : STA.b $28
    BCC .BRANCH_DELTA
        INC.b $40
    
    .BRANCH_DELTA
    
    JSR.w Attract_DrawKidnappedMaiden
    
    LDX.b #$01
    
    .nextSoldier
    
        STZ.b $03
        
        LDA.b $33 : STA.b $06
        
        LDA.b $29 : CLC : ADC.l Pool_Attract_Prison_soldier_offset_y, X : STA.b $02
        
        LDA.l Pool_Attract_Prison_soldier_direction, X : STA.b $04
        LDA.l Pool_Attract_Prison_soldier_palette, X   : STA.b $05
        
        PHX
        
        REP #$20
        
        TXA : ASL : TAX
        LDA.b $30 : CLC : ADC.w #$0100
        CLC : ADC.l Pool_Attract_Prison_soldier_offset_x, X : STA.b $00
                                                              TAY
                                                              STY.b $34
        
        SEP #$20
        
        JSL.l Sprite_ResetProperties
        
        ; I think that this animates the soldiers leading the prisoner away.
        ; As in, generates their appearance and puts it into OAM and such.
        ; Kind of like a marionette being controlled by a puppeteer, but one
        ; frame at a time.
        JSL.l Sprite_SimulateSoldier
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
    
    .BRANCH_ZETA

    ; Bleeds into the next function.
}

; $067319-$067323 LONG JUMP LOCATION
AttractDramatize_Agahnim:
{
    LDA.b $60 : ASL : TAX
    JMP.w ($.vectors, X)

    ; $067320
    .vectors
    dw Dramaghanim_WaitForCue  ; 0x00 - $F32B
    dw Dramaghanim_MoveAndSpin ; 0x01 - $F379
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
    
    JSR.w Attract_DrawSpriteSet
    
    RTL
}

; ==============================================================================

; $067365-$067378 DATA
Dramaghanim_MoveAndSpin:
{
    ; $067365
    .pointers_char
    dw AttractAgahnimOAM_char_step0
    dw AttractAgahnimOAM_char_step1
    dw AttractAgahnimOAM_char_step2
    dw AttractAgahnimOAM_char_step3
    dw AttractAgahnimOAM_char_step4

    ; $06736F
    .pointers_prop
    dw AttractAgahnimOAM_prop_step0
    dw AttractAgahnimOAM_prop_step1
    dw AttractAgahnimOAM_prop_step2
    dw AttractAgahnimOAM_prop_step0
    dw AttractAgahnimOAM_prop_step0
}

; $067379-$067400 LONG JUMP LOCATION
Dramaghanim_MoveAndSpin:
{
    LDA.b $25 : CMP.b #$80 : BCS .BRANCH_ALPHA
        JSR.w Attract_ShowTimedTextMessage
        
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
        JMP.w Attract_AdvanceToNextSequence
    
    .BRANCH_ZETA
    
    LDA.b $25 : CMP.b #$C0 : BCS .BRANCH_BETA
        INX : INX
        
        CMP.b #$B8 : BCS .BRANCH_BETA
            INX : INX
            
            CMP.b #$B0 : BCS .BRANCH_BETA
                INX : INX
                
                CMP.b #$A0 : BCS .BRANCH_BETA
                    INX : INX

    .BRANCH_BETA

    LDA.b #$A8 : STA.b $28
    
    REP #$20
    
    LDA.b $1A : AND.w #$0001 : BEQ .BRANCH_GAMMA
        DEC.b $30
    
    .BRANCH_GAMMA
    
    LDA.w #$F8D9 : STA.b $2D
    LDA.w #$F8DF : STA.b $02
    LDA.w #$F8E5 : STA.b $04
    
    LDA.l Dramaghanim_MoveAndSpin_pointers_char, X : STA.b $06
    LDA.l Dramaghanim_MoveAndSpin_pointers_prop, X : STA.b $08
    
    SEP #$20
    
    LDA.b #$58 : STA.b $28
    
    LDA.b $2B : STA.b $29
    
    LDY.b #$05
    JSR.w Attract_DrawSpriteSet
    
    RTL
}

; ==============================================================================

; $067401-$067422 DATA
Pool_Attract_MaidenWarp:
{
    ; $067401
    .soldier_position_x
    db $30, $C0, $30, $C0, $50, $A0

    ; $067407
    .soldier_position_y
    db $70, $70, $98, $98, $C0, $C0

    ; $06740D
    .soldier_direction
    db $00, $01, $00, $01, $03, $03

    ; $067413
    .soldier_palette
    db $09, $09, $09, $09, $07, $09

    ; $067419
    .vectors
    dw Dramagahnim_RaiseTheRoof            ; 0x00 - $F57B
    dw Dramagahnim_ReadySpell              ; 0x01 - $F592
    dw Dramagahnim_CastSpell               ; 0x02 - $F613
    dw Dramagahnim_RealizeWhatJustHappened ; 0x03 - $F689
    dw Dramagahnim_IdleGuiltily            ; 0x04 - $F6E2
}

; $067423-$06757A LONG JUMP LOCATION
Attract_MaidenWarp:
{
    LDA.b $5D : BEQ .sequenceNotFinished
        JMP.w Attract_AdvanceToNextSequence
    
    .sequenceNotFinished
    
    STZ.b $2A
    
    JSL.l Filter_MajorWhitenMain
    
    LDA.b $5F : BNE .brighteningTaskFinished
        JSR.w Attract_SlowBrigthenSetFlag
    
    .brighteningTaskFinished
    
    LDA.b $50 : CMP.b #$FF : BEQ .counterAtMax
        INC.b $50
    
    .counterAtMax
    
    LDA.w $0FF9 : BEQ .BRANCH_DELTA
    AND.b #$04 : BEQ .BRANCH_DELTA
    
        ; Sound effect.
        LDX.b #$2B : STX.w $012F
    
    .BRANCH_DELTA
    
    LDA.b $60 : ASL : TAX
    JSR.w (Pool_Attract_MaidenWarp_vectors, X)
    
    LDX.b #$05
    
    .nextSoldier
    
        STZ.b $01
        STZ.b $03
        STZ.b $06
        
        LDA.l Pool_Attract_MaidenWarp_soldier_position_x, X : STA.b $00
        LDA.l Pool_Attract_MaidenWarp_soldier_position_y, X : STA.b $02
        LDA.l Pool_Attract_MaidenWarp_soldier_direction, X  : STA.b $04
        LDA.l Pool_Attract_MaidenWarp_soldier_palette, X    : STA.b $05
        
        PHX
        
        JSL.l Sprite_ResetProperties
        JSL.l Sprite_SimulateSoldier
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
            INX : INX
        
        .BRANCH_KAPPA
        
        LDA.l .maiden_char_pointer, X : STA.b $06
        
        LDA.w #$F931 : STA.b $08
        
        SEP #$20
        
        LDA.b #$74 : STA.b $28
        
        LDA.b $30 : STA.b $29
        
        LDY.b #$01
        JSR.w Attract_DrawSpriteSet
        
        LDX.b #$0E
        
        LDA.b $30 : CMP.b #$68 : BCS .BRANCH_LAMBDA
            SEC : SBC.b #$68 : ASL : AND.b #$0E : TAX
        
        .BRANCH_LAMBDA
        
        REP #$20
        
        LDA.w #$F933 : STA.b $2D
        
        LDA.l .shadow_offset_x_pointer, X : STA.b $02
        
        LDA.w #$F93F : STA.b $04
        LDA.w #$F941 : STA.b $06
        LDA.w #$F943 : STA.b $08
        
        SEP #$20
        
        TXA : LSR : TAX
        LDA.b #$74 : CLC : ADC.l .shadow_base_offset_x, X : STA.b $28
        
        LDA.b #$76 : STA.b $29
        
        LDY.b #$01
        
        JSR.w Attract_DrawSpriteSet
    
    .BRANCH_IOTA
    
    LDA.b $50 : LSR #4 : AND.b #$0E : TAX
    
    REP #$20
    
    LDA.w #$F8D9                   : STA.b $2D
    LDA.w #$F8DF                   : STA.b $02
    LDA.w #$F8E5                   : STA.b $04
    LDA.l .agahnim_char_pointer, X : STA.b $06
    LDA.w #$F915                   : STA.b $08
    
    SEP #$20
    
    LDA.b #$70 : STA.b $28
    LDA.b #$46 : STA.b $29
    
    LDY.b #$05
    JSR.w Attract_DrawSpriteSet
    
    RTL

    ; $06754F
    .shadow_offset_x_pointer
    dw AttractAltarMaidenShadowOAM_offset_x_step0
    dw AttractAltarMaidenShadowOAM_offset_x_step0
    dw AttractAltarMaidenShadowOAM_offset_x_step1
    dw AttractAltarMaidenShadowOAM_offset_x_step1
    dw AttractAltarMaidenShadowOAM_offset_x_step2
    dw AttractAltarMaidenShadowOAM_offset_x_step2
    dw AttractAltarMaidenShadowOAM_offset_x_step3
    dw AttractAltarMaidenShadowOAM_offset_x_step4

    ; $06755F
    .shadow_base_offset_x
    db  4,  4,  3,  3
    db  2,  2,  1,  0

    ; $067567
    .maiden_char_pointer
    dw AttractAltarMaidenOAM_char_step0
    dw AttractAltarMaidenOAM_char_step1

    ; $06756B
    .agahnim_char_pointer
    dw AttractAgahnimOAM_char_step3
    dw AttractAgahnimOAM_char_step5
    dw AttractAgahnimOAM_char_step3
    dw AttractAgahnimOAM_char_step6
    dw AttractAgahnimOAM_char_step3
    dw AttractAgahnimOAM_char_step5
    dw AttractAgahnimOAM_char_step3
    dw AttractAgahnimOAM_char_step4
}

; $06757B-$067581 LOCAL JUMP LOCATION
Dramagahnim_RaiseTheRoof:
{
    LDA.b $61 : BEQ .BRANCH_ALPHA
        INC.b $60
    
    .BRANCH_ALPHA
    
    RTS
}

; $067582-$0675F5 DATA
DramagahnimSpellCharPointer:
{
    dw DramagahnimSpellOAM_char_step0
    dw DramagahnimSpellOAM_char_step1
}

; $067586-$067589 DATA
DramagahnimSpellPropPointer:
{
    dw DramagahnimSpellOAM_prop_step0
    dw DramagahnimSpellOAM_prop_step1
}

; $06758A-$067591 DATA
Dramagahnim_ReadySpell_OAM_count:
{
    db  1
    db  1
    db  1
    db  5
    db  5
    db  9
    db  9
    db 13
}

; $067592-$0675FA LOCAL JUMP LOCATION
Dramagahnim_ReadySpell:
{
    LDA.b $1A : LSR : AND.b #$02 : TAX
    
    REP #$20
    
    LDA.w #$F945 : STA.b $2D
    LDA.w #$F953 : STA.b $02
    LDA.w #$F961 : STA.b $04
    
    LDA.l DramagahnimSpellCharPointer, X : STA.b $06
    LDA.l DramagahnimSpellPropPointer, X : STA.b $08
    
    SEP #$20
    
    LDA.b #$6E : STA.b $28
    LDA.b #$48 : STA.b $29
    
    LDA.b $51 : LSR : AND.b #$07 : TAX
    LDA.l Dramagahnim_ReadySpell_OAM_count, X : TAY
    
    JSR.w Attract_DrawSpriteSet
    
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

; $0675FB-$067612 DATA
Pool_Dramagahnim_CastSpell:
{
    ; $0675FB
    .OAM_count
    db  3
    db  3
    db  7
    db  7
    db 11
    db 11
    db 13
    db 13

    ; $067603
    .index_offset
    dw 10
    dw 10
    dw  6
    dw  6
    dw  2
    dw  2
    dw  0
    dw  0
}

; $067613-$067674 LOCAL JUMP LOCATION
Dramagahnim_CastSpell:
{
    PHB : PHK : PLB
    
    LDA.b $1A : LSR : AND.b #$02 : TAX
    
    LDA.b $51 : LSR : AND.b #$07 : STA.b $00
    
    ASL : TAY
    
    REP #$20
    
    LDA.w #$F945 : CLC : ADC.w Pool_Dramagahnim_CastSpell_index_offset, Y : STA.b $2D
    LDA.w #$F953 : CLC : ADC.w Pool_Dramagahnim_CastSpell_index_offset, Y : STA.b $02
    LDA.w #$F961 : CLC : ADC.w Pool_Dramagahnim_CastSpell_index_offset, Y : STA.b $04
    
    LDA.w DramagahnimSpellCharPointer, X
    CLC : ADC.w Pool_Dramagahnim_CastSpell_index_offset, Y : STA.b $06

    LDA.w DramagahnimSpellPropPointer, X
    CLC : ADC.w Pool_Dramagahnim_CastSpell_index_offset, Y : STA.b $08
    
    SEP #$20
    
    LDA.b #$6E : STA.b $28
    LDA.b #$48 : STA.b $29
    
    LDX.b $00
    LDA.w Pool_Dramagahnim_CastSpell_OAM_count, X : TAY
    
    JSR.w Attract_DrawSpriteSet
    
    PLB
    
    LDA.b $51 : BNE .BRANCH_ALPHA
        DEC.b $62 : BEQ Dramagahnim_ReadySpell_BRANCH_BETA
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    DEC.b $51
    
    .BRANCH_BETA
    
    RTS
}

; $067675-$067688
Pool_Dramagahnim_Realize:
{
    ; $067675
    .pointers_offset_x
    dw AttractTelebubbleOAM_step0_offset_x
    dw AttractTelebubbleOAM_step1_offset_x

    ; $067679
    .pointers_offset_y
    dw AttractTelebubbleOAM_step0_offset_y
    dw AttractTelebubbleOAM_step1_offset_y

    ; $06767D
    .pointers_char
    dw AttractTelebubbleOAM_step0_char
    dw AttractTelebubbleOAM_step1_char

    ; $067681
    .pointers_prop
    dw AttractTelebubbleOAM_step0_prop
    dw AttractTelebubbleOAM_step1_prop

    ; $067685
    .position_x
    db $78
    db $70

    ; $067687
    .object_count
    db $00
    db $01
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
        LSR : LSR : AND.b #$02 : TAX
        
        REP #$20
        
        LDA.w #$F9A7 : STA.b $2D
        
        LDA.l Pool_Dramagahnim_Realize_pointers_offset_x, X : STA.b $02
        LDA.l Pool_Dramagahnim_Realize_pointers_offset_y, X : STA.b $04
        LDA.l Pool_Dramagahnim_Realize_pointers_char, X     : STA.b $06
        LDA.l Pool_Dramagahnim_Realize_pointers_prop, X     : STA.b $08
        
        SEP #$20
        
        TXA : LSR : TAX
        LDA.l Pool_Dramagahnim_Realize_position_x, X : STA.b $28
        
        LDA.b #$60 : STA.b $29
        
        LDA.l Pool_Dramagahnim_Realize_object_count, X : TAY
        
        JSR.w Attract_DrawSpriteSet
    
    .BRANCH_GAMMA
    
    INC.b $51
    
    RTS
}

; $0676E2-$0676FF LOCAL JUMP LOCATION
Dramagahnim_IdleGuiltily:
{
    JSR.w Attract_ShowTimedTextMessage
    
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
        JSL.l EnableForceBlank
        
        ; Set BG1 tilemap to xy-mirrored, at VRAM address $1000.
        LDA.b #$13 : STA.w SNES.BG1AddrAndSize
        
        ; Set BG2 tilemap to xy-mirrored, at VRAM address $0000.
        LDA.b #$03 : STA.w SNES.BG2AddrAndSize
        
        REP #$20
        
        JSL.l OverworldMap_PrepExit_restoreHDMASettings
        
        REP #$20
        
        STZ.w $063A
        STZ.w $0638
        
        ; Set BG1 horizontal and vertical scroll buffer regs to 0.
        STZ.w $0120
        STZ.w $0124
        
        ; Set BG3 vertical scroll buffer reg to 0.
        STZ.b $EA
        
        SEP #$20
        
        JMP.w FadeMusicAndResetSRAMMirror
    
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
    
    LDA Attract_LegendGraphics_sizes, X    : STA.b !picSize
    LDA Attract_LegendGraphics_pointers, X : STA.b !picData
    
    LDX.b #$0C : STX.b $04
    
    REP #$10
    
    ; Write the tilemap data into a buffer to be transferred once NMI hits.
    LDY.b !picSize
    
    .writeLoop
    
        LDA.b [!picData], Y : STA.w $1002, Y
    DEY : DEY : BPL .writeLoop
    
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
    
    JSL.l Messaging_Text
    
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
    
    LDA.w $0637 : STA.w SNES.MultiplicandA
    
    LDX.w #$01BE
    
    .adjustHDMATableLoop
    
        LDA.l WorldMapHDMA_ZoomedOut_Part1+0, X : STA.w SNES.MultiplierB
        
        NOP #4
        
        LDA.w SNES.RemainderResultHigh : STA.b $00
        
        LDA.l WorldMapHDMA_ZoomedOut_Part1+1, X : STA.w SNES.MultiplierB
        
        NOP
        
        ; This is effectively the top 16-bits of the 24-bit result of
        ; multiplying $0637 (byte) by the current word from the table.
        LDA.b $00 : CLC : ADC.w SNES.RemainderResultLow : STA.w $1B00, X
        LDA.w SNES.RemainderResultHigh : ADC.b #$00 : STA.w $1B01, X
    DEX : DEX : BPL .adjustHDMATableLoop
    
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
    
    LDA.b #$10 : STA.w SNES.BG1AddrAndSize
    LDA.b #$00 : STA.w SNES.BG2AddrAndSize
    
    PHB : PHK : PLB
    
    REP #$30
    
    LDX.w #$0000
    
    LDA.w #$F7BE : STA.b $30
    
    .BRANCH_BETA
    
            TXA : AND.w #$0007 : TAY
            
            .BRANCH_ALPHA
            
                LDA.b ($30), Y : STA.w $1006, X
                
                INY : INY
                
                INX : INX
            TYA : AND.w #$0007 : BNE .BRANCH_ALPHA
        TXA : AND.w #$003F : BNE .BRANCH_BETA
        
        LDA.b $30 : CLC : ADC.w #$0008 : STA.b $30
    CPX.w #$0100 : BNE .BRANCH_BETA
    
    LDA.w #$1000 : STA.b $30
    
    JSR.w Attract_TriggerBGDMA

    REP #$30

    LDX.w #$0000
    
    LDA.w #$F7DE : STA.b $30
    
    .BRANCH_DELTA
    
        TXA : AND.w #$0003 : TAY
        
        .BRANCH_GAMMA
        
            LDA.b ($30), Y : STA.w $1006, X
            
            INY : INY
                
            INX : INX
            
            TYA : AND.w #$0003 : BNE .BRANCH_GAMMA
        TXA : AND.w #$003F : BNE .BRANCH_DELTA
        
        TXA : AND.w #$0040 : LSR #4 : CLC : ADC.w #$F7DE : STA.b $30
    CPX.w #$0100 : BNE .BRANCH_DELTA
    
    LDA.w #$0000 : STA.b $30
    
    JSR.w Attract_TriggerBGDMA
    
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
    
    LDA.b $30 : STA.w SNES.VRAMAddrReadWriteLow
    
    .nextTransfer
    
        LDY.b #$80 : STY.w SNES.VRAMAddrIncrementVal
        
        LDA.w #$1801 : STA.w DMA.0_TransferParameters
        
        LDA.w #$1006 : STA.w DMA.0_SourceAddrOffsetLow
        LDY.b #$00   : STY.w DMA.0_SourceAddrBank
        
        LDA.w #$0100 : STA.w DMA.0_TransferSizeLow
        
        LDY.b #$01 : STY.w SNES.DMAChannelEnable
    DEX : BPL .nextTransfer
    
    RTS
}

; ==============================================================================

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
; $0679B5-$0679E3 LOCAL JUMP LOCATION
Attract_DrawSpriteSet:
{
    PHB : PHK : PLB
    
    .nextSprite
    
        LDX.b $2A
        
        LDA.b ($2D), Y : STA.w $0A60, X
        
        TXA : ASL : ASL : TAX
        LDA.b ($02), Y : CLC : ADC.b $28 : STA.w $0900, X
        LDA.b ($04), Y : CLC : ADC.b $29 : STA.w $0901, X
        LDA.b ($06), Y                   : STA.w $0902, X
        LDA.b ($08), Y                   : STA.w $0903, X
        
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

; $0679E8-$067A26 LOCAL JUMP LOCATION
Atract_DrawZelda:
{
    ; Both sprites are larger (16x16).
    LDX.b $2A
    LDA.b #$02 : STA.w $0A60, X
    
    ; X coordinates are fixed at 0x60?
    TXA : ASL : ASL : TAX
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

; $067A27-$067A2F DATA
Pool_Attract_DrawKidnappedMaiden:
{
    ; $067A27
    .head_char
    db $06

    ; $067A28
    .body_char
    db $08, $0A

    ; $067A2A
    .offset_y
    db   0,   1

    ; $067A2C
    .body_offset_y
    db  10,   9

    ; $067A2E
    .head_prop
    db $3D

    ; $067A2F
    .body_prop
    db $3D
}

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
    
    STA.w $0A60, X
    STA.w $0A61, X
    
    TXA : ASL : ASL : TAX
    LDA.b $28 : STA.w $0900, X
                STA.w $0904, X
    
    LDA.b $32 : LSR #3 : AND.b #$01 : TAY
    LDA.b $29
    CLC : ADC.w Pool_Attract_DrawKidnappedMaiden_offset_y, Y      : STA.w $0901, X
    CLC : ADC.w Pool_Attract_DrawKidnappedMaiden_body_offset_y, Y : STA.w $0905, X
    
    LDA.w Pool_Attract_DrawKidnappedMaiden_head_char    : STA.w $0902, X
    LDA.w Pool_Attract_DrawKidnappedMaiden_body_char, Y : STA.w $0906, X
    LDA.w Pool_Attract_DrawKidnappedMaiden_head_prop    : STA.w $0903, X
    LDA.w Pool_Attract_DrawKidnappedMaiden_body_prop    : STA.w $0907, X
    
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
    
    ; Use direct HDMA to write from A bus to registers $2126 and $2127,
    ; alternating on channel 6.
    ; $067A9E
    .settings
    db $01
    db $26
    dl .table_a ; $0CFA87
}

; Note: This sets up the windowing via HDMA for the legend sequence.
; $067AA3-$067AC1 LOCAL JUMP LOCATION
Attract_SetupHDMA:
{
    LDX.b #$04
    
    .configLoop
    
        LDA.l Attract_WindowingHDMA_settings, X : STA.w DMA.6_TransferParameters, X
                                                  STA.w DMA.7_TransferParameters, X
    DEX : BPL .configLoop
    
    REP #$20
    
    ; I don't think they realized that this special casing actually lost
    ; bytes in the end. Using two 5 byte groups and an extra load uses 6
    ; bytes less.
    LDA.w #$FA94 : STA.w DMA.7_SourceAddrOffsetLow
    
    SEP #$20
    
    ; Channel 7 will write to registers $2128 and $2129 (alternating).
    LDA.b #$28 : STA.w DMA.7_DestinationAddr
    
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
    db $FF ; End of stripes data
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
    db $FF ; End of stripes data
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
    db $FF ; End of stripes data
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
    db $FF ; End of stripes data
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
    
; $067E45-$067E55 LOCAL JUMP LOCATION
Intro_InitLogoSword:
{
    LDA.b #$07 : STA.b $CB
    
    STZ.b $CC
    STZ.b $CD
    
    REP #$20
    
    LDA.w #$FF7E : STA.b $C8
    
    SEP #$20
    
    ; Bleeds into the next functino.
}

; Draws sword and does screen flashing in intro.
; $067E56-$067EE8 LOCAL JUMP LOCATION
Intro_HandleLogoSword:
{
    PHB : PHK : PLB
    
    LDA.b $CA : BEQ .BRANCH_1
        DEC.b $CA
    
    .BRANCH_1
    
    JSL.l Palette_BgAndFixedColor_justFixedColor
    
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
    
        LDY.b #$09 : TYA : ASL : ASL : TAX
        
        LDA.b #$02 : STA.w $0A72, Y
        
        LDA.w Pool_Intro_InitLogoSword_char, Y       : STA.w $094A, X
        LDA.b #$21                                   : STA.w $094B, X
        LDA.w Pool_Intro_InitLogoSword_position_x, Y : STA.w $0948, X
        
        PHY : TYA : ASL : TAY
        
        REP #$20
        
        LDA.b $C8 : CLC : ADC.w Pool_Intro_InitLogoSword_position_y, Y
        
        SEP #$20
        
        XBA : BEQ .BRANCH_5
            LDA.b #$F8 : XBA
        
        .BRANCH_5
        
        XBA : SEC : SBC.b #$08 : STA.w $0949, X
    PHY : DEY : BPL .loop
    
    REP #$20
    
    LDA.b $C8 : CMP.w $001E : BEQ .BRANCH_8
        LDY.b #$01
        
        CMP.w #$FFBE : BEQ .BRANCH_6
            CMP.w #$000E : BNE .BRANCH_7
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
    JMP.w (.vectors, X)

    ; $067EE9
    .vectors
    dw LogoSword_IdleState    ; 0x00 - $FEEF
    dw LogoSword_EyeTwinkle   ; 0x01 - $FF13
    dw LogoSword_BladeShimmer ; 0x02 - $FF51
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
    ; $067F05
    .timer
    db $04, $04, $06, $06, $06, $04, $04

    ; $067F0C
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
        
        LDA.w Pool_LogoSword_EyeTwinkle_timer, X : STA.b $CA
    
    .BRANCH_2
    
    STZ.w $0A70
    
    LDA.b #$44 : STA.w $0940
    LDA.b #$43 : STA.w $0941
    
    LDA.b $25 : STA.w $0943
    
    LDA.w Pool_LogoSword_EyeTwinkle_char, X : STA.w $0942
    
    .BRANCH_3
    
    PLB ; RESTORES THE OLD DATA BANK.
    
    RTS
}

; ==============================================================================

; $067F49-067F50 DATA
LogoSword_BladeShimmer_char:
{
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
        
        LDA.b #$42 : STA.w $0940
                     STA.w $0944
        
        LDA.b $CD : CMP.b #$50 : BCC .BRANCH_1
            LDA.b #$4F
        
        .BRANCH_1
        
        CLC : ADC.b #$C8 : CLC : ADC.b #$31 : STA.w $0941
                           CLC : ADC.b #$08 : STA.w $0945
        
        LDA.b #$23 : STA.w $0943
                     STA.w $0947
        
        LDA.w .char+0, X : STA.w $0942
        LDA.w .char+1, X : STA.w $0946
        
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
