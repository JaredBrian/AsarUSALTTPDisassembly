; ==============================================================================

; Bank 0A
; $050000-$057FFF
org $0A8000

; Dungeon Room Data
; Bird travel
; Overworld map control
; Dungeon map control

; ==============================================================================

; $050000-$053729 DATA
RoomDataBank0A:
{
    ; ==========================================================================
    ; Link's house and uncle
    ; ==========================================================================

    ; $050000
    RoomDataTiles_0104:
    incbin "bin/rooms/room0104.bin" ; Size: 0x0047

    ; $050047
    RoomDataTiles_0055:
    incbin "bin/rooms/room0055.bin" ; Size: 0x0127

    ; ==========================================================================
    ; Some caves
    ; ==========================================================================

    ; $0509A9
    RoomDataTiles_00E1:
    incbin "bin/rooms/room00E1.bin" ; Size: 0x00D4

    ; $050242
    RoomDataTiles_00E3:
    incbin "bin/rooms/room00E3.bin" ; Size: 0x00F1

    ; $050333
    RoomDataTiles_00E2:
    incbin "bin/rooms/room00E2.bin" ; Size: 0x0137

    ; ==========================================================================
    ; Ganon
    ; ==========================================================================

    ; $05046A
    RoomDataTiles_0000:
    incbin "bin/rooms/room0000.bin" ; Size: 0x004F

    ; $0504B9
    RoomDataTiles_0010:
    incbin "bin/rooms/room0010.bin" ; Size: 0x00E3

    ; ==========================================================================
    ; More caves
    ; ==========================================================================

    ; $05059C
    RoomDataTiles_0008:
    incbin "bin/rooms/room0008.bin" ; Size: 0x00BD

    ; $050659
    RoomDataTiles_0018:
    incbin "bin/rooms/room0018.bin" ; Size: 0x0092

    ; $0506EB
    RoomDataTiles_002F:
    incbin "bin/rooms/room002F.bin" ; Size: 0x00EC

    ; $0507D7
    RoomDataTiles_002C:
    incbin "bin/rooms/room002C.bin" ; Size: 0x0104

    ; $0508DB
    RoomDataTiles_003C:
    incbin "bin/rooms/room003C.bin" ; Size: 0x00CE

    ; $0509A9
    RoomDataTiles_0003:
    incbin "bin/rooms/room0003.bin" ; Size: 0x002A

    ; ==========================================================================
    ; Sewers and Sanctuary
    ; ==========================================================================

    ; $0509D3
    RoomDataTiles_0012:
    incbin "bin/rooms/room0012.bin" ; Size: 0x00D2

    ; $050AA5
    RoomDataTiles_0002:
    incbin "bin/rooms/room0002.bin" ; Size: 0x00FA

    ; $050F19
    RoomDataTiles_0011:
    incbin "bin/rooms/room0011.bin" ; Size: 0x00BB

    ; $050C5A
    RoomDataTiles_0021:
    incbin "bin/rooms/room0021.bin" ; Size: 0x00DC

    ; $050D36
    RoomDataTiles_0022:
    incbin "bin/rooms/room0022.bin" ; Size: 0x00A1

    ; $050DD7
    RoomDataTiles_0032:
    incbin "bin/rooms/room0032.bin" ; Size: 0x0078

    ; $050E4F
    RoomDataTiles_0042:
    incbin "bin/rooms/room0042.bin" ; Size: 0x0046

    ; $050E95
    RoomDataTiles_0041:
    incbin "bin/rooms/room0041.bin" ; Size: 0x0084

    ; ==========================================================================
    ; Hyrule Castle
    ; ==========================================================================

    ; $050F19
    RoomDataTiles_0051:
    incbin "bin/rooms/room0051.bin" ; Size: 0x0116

    ; $0516A1
    RoomDataTiles_0050:
    incbin "bin/rooms/room0050.bin" ; Size: 0x00B3

    ; $0510E2
    RoomDataTiles_0001:
    incbin "bin/rooms/room0001.bin" ; Size: 0x008C

    ; $05116E
    RoomDataTiles_0052:
    incbin "bin/rooms/room0052.bin" ; Size: 0x00CA

    ; $051238
    RoomDataTiles_0060:
    incbin "bin/rooms/room0060.bin" ; Size: 0x00DF

    ; $051317
    RoomDataTiles_0061:
    incbin "bin/rooms/room0061.bin" ; Size: 0x014D

    ; $051464
    RoomDataTiles_0062:
    incbin "bin/rooms/room0062.bin" ; Size: 0x0121

    ; ==========================================================================
    ; Eastern Palace
    ; ==========================================================================

    ; $051585
    RoomDataTiles_00C8:
    incbin "bin/rooms/room00C8.bin" ; Size: 0x0015

    ; $05159A
    RoomDataTiles_00D8:
    incbin "bin/rooms/room00D8.bin" ; Size: 0x005B

    ; $0515F5
    RoomDataTiles_00D9:
    incbin "bin/rooms/room00D9.bin" ; Size: 0x0082

    ; $051677
    RoomDataTiles_00DA:
    incbin "bin/rooms/room00DA.bin" ; Size: 0x002A

    ; $0516A1
    RoomDataTiles_0099:
    incbin "bin/rooms/room0099.bin" ; Size: 0x0091

    ; $051732
    RoomDataTiles_00A8:
    incbin "bin/rooms/room00A8.bin" ; Size: 0x0163

    ; $051895
    RoomDataTiles_00A9:
    incbin "bin/rooms/room00A9.bin" ; Size: 0x0142

    ; $0519D7
    RoomDataTiles_00AA:
    incbin "bin/rooms/room00AA.bin" ; Size: 0x0160

    ; $051B37
    RoomDataTiles_00B8:
    incbin "bin/rooms/room00B8.bin" ; Size: 0x0044

    ; $051B7B
    RoomDataTiles_00B9:
    incbin "bin/rooms/room00B9.bin" ; Size: 0x0198

    ; $051D13
    RoomDataTiles_00BA:
    incbin "bin/rooms/room00BA.bin" ; Size: 0x004C

    ; $051D5F
    RoomDataTiles_00C9:
    incbin "bin/rooms/room00C9.bin" ; Size: 0x0107

    ; $051E66
    RoomDataTiles_0089:
    incbin "bin/rooms/room0089.bin" ; Size: 0x0067

    ; ==========================================================================
    ; Hyrule Castle Dungeon
    ; ==========================================================================

    ; $051ECD
    RoomDataTiles_0072:
    incbin "bin/rooms/room0072.bin" ; Size: 0x0111

    ; $051FDE
    RoomDataTiles_0082:
    incbin "bin/rooms/room0082.bin" ; Size: 0x0142

    ; $052120
    RoomDataTiles_0081:
    incbin "bin/rooms/room0081.bin" ; Size: 0x012F

    ; $05224F
    RoomDataTiles_0071:
    incbin "bin/rooms/room0071.bin" ; Size: 0x00FA

    ; $052349
    RoomDataTiles_0070:
    incbin "bin/rooms/room0070.bin" ; Size: 0x0034

    ; $05237D
    RoomDataTiles_0080:
    incbin "bin/rooms/room0080.bin" ; Size: 0x009D

    ; ==========================================================================
    ; Caves and houses
    ; ==========================================================================

    ; $05241A
    RoomDataTiles_00F0:
    incbin "bin/rooms/room00F0.bin" ; Size: 0x0176

    ; $052590
    RoomDataTiles_00F1:
    incbin "bin/rooms/room00F1.bin" ; Size: 0x0179

    ; $052709
    RoomDataTiles_00F2:
    incbin "bin/rooms/room00F2.bin" ; Size: 0x0049

    ; $052752
    RoomDataTiles_00F3:
    incbin "bin/rooms/room00F3.bin" ; Size: 0x004F

    ; $0527A1
    RoomDataTiles_00F4:
    incbin "bin/rooms/room00F4.bin" ; Size: 0x003A

    ; $0527DB
    RoomDataTiles_00F5:
    incbin "bin/rooms/room00F5.bin" ; Size: 0x0040

    ; $05281B
    RoomDataTiles_00F8:
    incbin "bin/rooms/room00F8.bin" ; Size: 0x00E7

    ; $052902
    RoomDataTiles_00E8:
    incbin "bin/rooms/room00E8.bin" ; Size: 0x00D5

    ; $0529D7
    RoomDataTiles_00FD:
    incbin "bin/rooms/room00FD.bin" ; Size: 0x00DE

    ; $052AB5
    RoomDataTiles_00ED:
    incbin "bin/rooms/room00ED.bin" ; Size: 0x013B

    ; $052BF0
    RoomDataTiles_00FF:
    incbin "bin/rooms/room00FF.bin" ; Size: 0x00B2

    ; $052CA2
    RoomDataTiles_00EF:
    incbin "bin/rooms/room00EF.bin" ; Size: 0x009B

    ; $052D3D
    RoomDataTiles_00DF:
    incbin "bin/rooms/room00DF.bin" ; Size: 0x007B

    ; $052DB8
    RoomDataTiles_00EB:
    incbin "bin/rooms/room00EB.bin" ; Size: 0x0066

    ; $052E1E
    RoomDataTiles_00FB:
    incbin "bin/rooms/room00FB.bin" ; Size: 0x008A

    ; $052EA8
    RoomDataTiles_00EE:
    incbin "bin/rooms/room00EE.bin" ; Size: 0x00D2

    ; $052F7A
    RoomDataTiles_00FE:
    incbin "bin/rooms/room00FE.bin" ; Size: 0x007B

    ; $053FF5
    RoomDataTiles_00F9:
    incbin "bin/rooms/room00F9.bin" ; Size: 0x0069

    ; $05305E
    RoomDataTiles_00FA:
    incbin "bin/rooms/room00FA.bin" ; Size: 0x010B

    ; $053169
    RoomDataTiles_00EA:
    incbin "bin/rooms/room00EA.bin" ; Size: 0x0090

    ; $0531F9
    RoomDataTiles_00E6:
    incbin "bin/rooms/room00E6.bin" ; Size: 0x00FB

    ; $0532F4
    RoomDataTiles_00E7:
    incbin "bin/rooms/room00E7.bin" ; Size: 0x00E0

    ; $0533D4
    RoomDataTiles_00E4:
    incbin "bin/rooms/room00E4.bin" ; Size: 0x00E5

    ; $0534B9
    RoomDataTiles_00E5:
    incbin "bin/rooms/room00E5.bin" ; Size: 0x0107

    ; ==========================================================================
    ; Caves
    ; ==========================================================================

    ; $0535C0
    RoomDataTiles_0124:
    incbin "bin/rooms/room0124.bin" ; Size: 0x003E

    ; $0535FE
    RoomDataTiles_0125:
    incbin "bin/rooms/room0125.bin" ; Size: 0x0053

    ; $053651
    RoomDataTiles_0126:
    incbin "bin/rooms/room0126.bin" ; Size: 0x0080

    ; $0536D1
    RoomDataTiles_0123:
    incbin "bin/rooms/room0123.bin" ; Size: 0x0059
}

; ==============================================================================

; $05372A-$05372F
NULL_0AB72A:
{
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $053730-$05374A LONG JUMP LOCATION
Messaging_BirdTravel:
{
    LDA.w $0200
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw OverworldMap_Backup           ; 0x00 - $B9A3 Also handles fading to black
    dw BirdTravel_InitGfx            ; 0x01 - $B74B On the last frame of fading load the map gfx
    dw OverworldMap_LoadSprGfx       ; 0x02 - $BA9A
    dw OverworldMap_BrightenScreen   ; 0x03 - $BAAA
    dw BirdTravel_InitCounter        ; 0x04 - $B753
    dw BirdTravel_Main               ; 0x05 - $B78B Player selection
    dw OverworldMap_PrepExit         ; 0x06 - $BBD6 Darken screen
    dw BirdTravel_LoadTargetArea     ; 0x07 - $B8C5
    dw BirdTravel_LoadAmbientOverlay ; 0x08 - $B948
    dw BirdTravel_Finish             ; 0x09 - $B964
}

; ==============================================================================

; $05374B-$053752 LONG JUMP LOCATION
BirdTravel_InitGfx:
{
    STZ.w $1AF0
    
    JSL.l OverworldMap_InitGfx
    
    RTL
}

; ==============================================================================

; $053753-$05375A LONG JUMP LOCATION
BirdTravel_InitCounter:
{
    LDA.b #$10 : STA.b $C8
    
    INC.w $0200
    
    RTL
}

; ==============================================================================

; $05375B-$05378A DATA
Pool_BirdTravel_Main:
{
    ; $05375B
    .char
    db $7F, $79, $6C, $6D, $6E, $6F, $7C, $7D

    ; $053763
    .pos_x_low
    db $80, $CF, $10, $B8, $30, $70, $70, $F0

    ; $05376B
    .pos_x_high
    db $06, $0C, $02, $08, $0F, $00, $07, $0E

    ; $053773
    .pos_y_low
    db $5B, $98, $C0, $20, $50, $B0, $30, $80

    ; $05377B
    .pos_y_high
    db $03, $05, $07, $0B, $0B, $0F, $0F, $0F

    ; $053783
    .bits
    db $80, $40, $20, $10, $08, $04, $02, $01
}

; $05378B-$0538C4 LONG JUMP LOCATION
BirdTravel_Main:
{
    LDA.b $C8 : BNE .waitForCounter
        ; Check A, X, B, and Y buttons (BYSTudlr and AXLR----).
        LDA.b $F2 : ORA.b $F0 : AND.b #$C0 : BEQ .noButtonInput
            ; These buttons cause us to exit bird travel and end up at the
            ; selected destination.
            INC.w $0200
            
            RTL

    .waitForCounter

    DEC.b $C8

    .noButtonInput

    LDY.b #$07
    
    LDX.w $1AF0

    .BRANCH_LAMBDA

        BRA .BRANCH_GAMMA

        ; $0537A4 ALTERNATE ENTRY POINT
        TXA : INC A : AND.b #$07 : TAX
    DEY : BPL .BRANCH_LAMBDA

    .BRANCH_GAMMA

    STX.w $1AF0
    
    LDA.b $F4 : AND.b #$0A : BEQ .BRANCH_DELTA
        DEC.w $1AF0
        
        LDA.b #$20 : STA.w $012F

    .BRANCH_DELTA

    LDA.b $F4 : AND.b #$05 : BEQ .BRANCH_EPSILON
        INC.w $1AF0
        
        LDA.b #$20 : STA.w $012F

    .BRANCH_EPSILON

    LDA.w $1AF0 : AND.b #$07 : STA.w $1AF0
    
    LDA.b $1A : AND.b #$10 : BEQ .BRANCH_ZETA
        JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_ZETA
            LDA.b $0E : SEC : SBC.b #$04 : STA.b $0E
            LDA.b $0F : SEC : SBC.b #$04 : STA.b $0F
            
            LDA.b #$00 : STA.b $0D
            LDA.b #$3E : STA.b $0C
            LDA.b #$02 : STA.b $0B
            
            LDX.b #$10
            
            JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_ZETA

    LDA.l $7EC108 : PHA
    LDA.l $7EC109 : PHA
    LDA.l $7EC10A : PHA
    LDA.l $7EC10B : PHA
    
    LDX.b #$07

    ; $053813 ALTERNATE ENTRY POINT
    .next_numeral

    CPX.w $1AF0 : BNE .BRANCH_THETA
        LDA.l Pool_BirdTravel_Main_pos_x_low,  X : STA.w $1AB0, X : STA.l $7EC10A
        LDA.l Pool_BirdTravel_Main_pos_x_high, X : STA.w $1AC0, X : STA.l $7EC10B
        LDA.l Pool_BirdTravel_Main_pos_y_low,  X : STA.w $1AD0, X : STA.l $7EC108
        LDA.l Pool_BirdTravel_Main_pos_y_high, X : STA.w $1AE0, X : STA.l $7EC109
        
        PHX
        
        JSR.w WorldMap_CalculateOAMCoordinates
        
        PLX
        
        BCC .BRANCH_IOTA
            LDA.l Pool_BirdTravel_Main_char, X : STA.b $0D
            
            LDA.b $1A : AND.b #$06 : ORA.b #$30 : STA.b $0C
            
            LDA.b #$00 : STA.b $0B
            
            PHX
            
            JSR.w WorldMap_HandleSpriteBlink
            
            PLX
            
            BRA .BRANCH_IOTA

    .BRANCH_THETA

    LDA.l Pool_BirdTravel_Main_pos_x_low,  X : STA.w $1AB0, X : STA.l $7EC10A
    LDA.l Pool_BirdTravel_Main_pos_x_high, X : STA.w $1AC0, X : STA.l $7EC10B
    LDA.l Pool_BirdTravel_Main_pos_y_low,  X : STA.w $1AD0, X : STA.l $7EC108
    LDA.l Pool_BirdTravel_Main_pos_y_high, X : STA.w $1AE0, X : STA.l $7EC109
    
    PHX
    
    JSR.w WorldMap_CalculateOAMCoordinates
    
    PLX
    
    BCC .BRANCH_IOTA
        LDA.l Pool_BirdTravel_Main_char, X : STA.b $0D
        
        LDA.b #$32 : STA.b $0C
        LDA.b #$00 : STA.b $0B
        
        PHX
        
        JSR.w WorldMap_HandleSpriteBlink
        
        PLX

    .BRANCH_IOTA

    DEX : BMI .BRANCH_KAPPA
        JMP.w BirdTravel_Main_next_numeral

    .BRANCH_KAPPA

    PLA : STA.l $7EC10B
    PLA : STA.l $7EC10A
    PLA : STA.l $7EC109
    PLA : STA.l $7EC108
    
    RTL
}

; ==============================================================================

; ZS replaces most of this function.
; $0538C5-$053947 LONG JUMP LOCATION
BirdTravel_LoadTargetArea:
{
    ; Reset the overlay flags for the swamp palace and its light world
    ; counterpart.
    LDA.l $7EF2BB : AND.b #$DF : STA.l $7EF2BB
    LDA.l $7EF2FB : AND.b #$DF : STA.l $7EF2FB
        
    ; Reset the indoor flags for the swamp palace and the watergate as well.
    LDA.l $7EF216 : AND.b #$7F : STA.l $7EF216
    LDA.l $7EF051 : AND.b #$FE : STA.l $7EF051
        
    JSL.l BirdTravel_LoadTargetAreaData
    JSL.l BirdTravel_LoadTargetAreaPalettes
    
    ; ZS starts writing here.
    ; $0538F5 - ZS Custom Overworld
    ; Load differnt animated tiles for certain areas.
    LDY.b #$58
        
    LDA.b $8A : AND.b #$BF
        
    CMP.b #$03 : BEQ .death_mountain
    CMP.b #$05 : BEQ .death_mountain
    CMP.b #$07 : BEQ .death_mountain
        LDY.b #$5A
    
    .death_mountain
    
    JSL.l DecompOwAnimatedTiles
    JSL.l Overworld_SetFixedColorAndScroll
        
    STZ.w $0AA9
    STZ.w $0AB2
        
    JSL.l InitTilesets
        
    INC.w $0200
        
    STZ.b $B2
        
    JSL.l Overworld_ReloadSubscreenOverlayAndAdvance
        
    ; Play sound effect indicating we're coming out of map mode.
    LDA.b #$10 : STA.w $012F
        
    ; Reset the ambient sound effect to what it was.
    LDX.b $8A : LDA.l $7F5B00, X : LSR #4 : STA.w $012D
        
    ; If it's a different music track than was playing where we came from,
    ; simply change to it (as opposed to setting volume back to full).
    LDA.l $7F5B00, X : AND.b #$0F : TAX : CPX.w $0130 : BNE .different_music
        ; Otherwise, just set the volume back to full.
        LDX.b #$F3
    
    .different_music
    
    STX.w $012C
        
    RTL
}

; ==============================================================================

; $053948-$053963 LONG JUMP LOCATION
BirdTravel_LoadAmbientOverlay:
{
    REP #$20
    
    LDA.b $10 : PHA
    
    LDA.w $0200 : PHA
    
    SEP #$20
    
    ; Loads overworld map32 data (and subsequently map16, etc etc).
    JSL.l Overworld_LoadAndBuildScreen_long
    
    REP #$20
    
    PLA : INC A : STA.w $0200
    
    PLA : STA.b $10
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $053964-$05398A LONG JUMP LOCATION
BirdTravel_Finish:
{
    INC.b $13
    
    LDA.b $13 : CMP.b #$0F : BNE .keep_brightening
        ; $05396C ALTERNATE ENTRY POINT
        .restore_prev_module

        STZ.w $0200
        
        STZ.b $B0
        
        ; Restore the current module.
        LDA.w $010C : STA.b $10
        
        STZ.b $11
        
        LDA.l $7EC229 : STA.b $9B
        
        LDY.b #$04
        LDA.b #$27
        
        JSL.l AddTravelBird_drop_off

    .keep_brightening

    JSL.l Sprite_Main
    
    RTL
}

; ==============================================================================

; $05398B-$0539A1 LONG JUMP LOCATION
Messaging_OverworldMap:
{
    LDA.w $0200
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw OverworldMap_Backup           ; 0x00 - $B9A3
    dw OverworldMap_InitGfx          ; 0x01 - $BA30
    dw OverworldMap_DarkWorldTilemap ; 0x02 - $BA7A
    dw OverworldMap_LoadSprGfx       ; 0x03 - $BA9A
    dw OverworldMap_BrightenScreen   ; 0x04 - $BAAA
    dw OverworldMap_Main             ; 0x05 - $BAE6
    dw OverworldMap_PrepExit         ; 0x06 - $BBD6
    dw OverworldMap_RestoreGfx       ; 0x07 - $BC54
}

; ==============================================================================

; $0539A2-$0539A2 BRANCH LOCATION
OverworldMap_KeepDarkening:
{
    RTS
}

; ==============================================================================

; $0539A3-$053A2F LONG JUMP LOCATION
OverworldMap_Backup:
{
    ; Darken the screen until it's fully black.
    DEC.b $13 : BNE OverworldMap_KeepDarkening
        ; Cache hdma settings.
        LDA.b $9B : STA.l $7EC229
        
        JSL.l EnableForceBlank
        
        ; Set mosaic to disabled on BG1 and BG2.
        LDA.b #$03 : STA.b $95
        
        ; Move to next step of submodule.
        INC.w $0200
        
        REP #$20
        
        ; Cache main screen designation.
        LDA.b $1C : STA.l $7EC211
        
        ; Cache BG offset register mirros.
        LDA.b $E0 : STA.l $7EC200
        LDA.b $E2 : STA.l $7EC202
        LDA.b $E6 : STA.l $7EC204
        LDA.b $E8 : STA.l $7EC206
        
        ; Zero out BG offset register mirrors.
        STZ.b $E0 : STZ.b $E2
        STZ.b $E4 : STZ.b $E6
        STZ.b $E8 : STZ.b $EA
        
        ; Cache CGWSEL register mirror.
        LDA.b $99 : STA.l $7EC225
        
        ; Set link animation.
        LDA.w #$01FC : STA.w $0100
        
        LDX.b $8A : CPX.b #$80 : BCS .specialArea
            ; Cache Link's coordinates.
            LDA.b $20 : STA.l $7EC108
            LDA.b $22 : STA.l $7EC10A

        .specialArea

        SEP #$20
        
        LDA.l $7EF3C5 : CMP.b #$02 : BCS .savedZeldaOnce
            ; Clip to black before color math inside color window only.
            LDA.b #$80 : STA.b $99
            
            ; Apply color math to BG1 and background, with half addition.
            LDA.b #$61 : STA.b $9A

        .savedZeldaOnce

        ; Play sound effect indicating we're entering overworld map mode.
        LDA.b #$10 : STA.w $012F
        
        ; Play another sound effect in conjunction (to produce a nuanced sound).
        LDA.b #$05 : STA.w $012D
        
        ; Set volume to half.
        LDA.b #$F2 : STA.w $012C
        
        ; Set screen mode to mode 7 (because the overworld map is done in mode
        ; 7, obviously).
        LDA.b #$07 : STA.w SNES.BGModeAndTileSize : STA.b $94
        
        ; Set so that the playing field is filled with transparency wherever
        ; there aren't tiles.
        LDA.b #$80 : STA.w SNES.Mode7Init
        
        RTL
}

; ==============================================================================

; $053A30-$053A79 LONG JUMP LOCATION
OverworldMap_InitGfx:
{
    JSR.w ClearMode7Tilemap
    
    ; Put BG1 and OBJ on main screen, and nothing on the subscreen.
    LDA.b #$11 : STA.b $1C
                 STZ.b $1D
    
    JSL.l WriteMode7Chr
    JSR.w WorldMap_SetUpHDMA
    
    ; Set data bank to 0x0A
    PHB : LDA.b #$0A : PHA : PLB
    
    REP #$30
    
    LDX.w #$00FE
    LDY.w #$00FE
    
    ; Loads a different palette if in the DW.
    LDA.b $8A : AND.w #$0040 : BEQ .lightWorld
        LDY.w #$01FE

    .lightWorld

    .copyFullCgramBuffer

        LDA.w Palettes_OWMAP, Y : STA.l $7EC500, X
        
        DEY #2
    DEX #2 : BPL .copyFullCgramBuffer
    
    SEP #$30
    
    PLB
    
    JSL.l LoadActualGearPalettes
    
    ; Tell NMI to update CGRAM this frame.
    INC.b $15
    
    LDA.b #$07 : STA.b $17
    
    STZ.b $13
    
    INC.w $0710
    
    INC.w $0200
    
    RTL
}

; ==============================================================================

; Performs the necessary mods to the light world tilemap to produce
; the dark world tilemap.
; $053A7A-$053A99 LONG JUMP LOCATION
OverworldMap_DarkWorldTilemap:
{
    LDA.b $8A : AND.b #$40 : BEQ .lightWorld
        REP #$30
        
        LDX.w #$03FE

        .copyLoop

            LDA.l WorldMap_DarkWorldTilemap, X : STA.w $1000, X
        DEX #2 : BPL .copyLoop
        
        SEP #$30
        
        LDA.b #$15 : STA.b $17

    .lightWorld

    INC.w $0200
    
    RTL
}

; ==============================================================================

; $053A9A-$053AA9 LOCAL JUMP LOCATION
OverworldMap_LoadSprGfx:
{
    LDA.b #$10 : STA.w $0AAA
    
    JSL.l Graphics_LoadChrHalfSlot
    
    STZ.w $0AAA
    
    ; Move on to next substep.
    INC.w $0200
    
    RTL
}

; ==============================================================================

; $053AAA-$053AB5 LONG JUMP LOCATION
OverworldMap_BrightenScreen:
{
    INC.b $13
    
    LDA.b $13 : CMP.b #$0F : BNE .notDoneBrightening
        ; Move to next step.
        INC.w $0200

    .notDoneBrightening

    RTL
}

; ==============================================================================

; $053AB6-$053AC3 DATA
UNREACHABLE_0ABAB6:
{
    db $1E, $00, $1E, $02, $FE, $02, $00, $80
    db $02, $80, $00, $01, $FF, $01
}

; $053AC4-$053AE5 DATA
Pool_OverworldMap_Main:
{
    ; $053AC4
    .BaseZoom
    db $21 ; Zoomed out
    db $0C ; Zoomed in

    ; $053AC6
    .PanMovements
    dw $0000 ; None
    dw $0000 ; None
    dw $0001 ; Down
    dw $0002 ; Right
    dw $FFFF ; Up
    dw $FFFE ; Left
    dw $0001 ; Never used, but handles UD
    dw $0002 ; Never used, but handles LR

    ; $053AD6
    .PanBoundaries
    db $00, $00 ; None
    db $00, $00 ; None
    db $E0, $00 ; Down
    db $E0, $01 ; Right
    db $B8, $FF ; Up
    db $20, $FF ; Left

    ; $053AE2
    .HDMAZoomPointers
    dw WorldMapHDMA_ZoomedOut
    dw WorldMapHDMA_ZoomedIn
}

; $053AE6-$053BD5 LONG JUMP LOCATION
OverworldMap_Main:
{
    LDA.w $0636 : ASL A : BCC .dontToggleZoomLevel
        TAX
        
        ; We got rid of bit 7 of $0636.
        LSR A : STA.w $0636
        
        ; Change the matrix multiplication done via hdma (changes from
        ; closeup to full view).
        LDA.l Pool_OverworldMap_Main_HDMAZoomPointers, X
        STA.w DMA.6_SourceAddrOffsetLow : STA.w DMA.7_SourceAddrOffsetLow

    .dontToggleZoomLevel

    LDA.w $0636 : BNE .dontExitMap
        ; Check for presses of the X button this frame.
        LDA.b $F6 : AND.b #$40 : BEQ .dontExitMap
            ; The signal to come out of map mode.
            INC.w $0200
            
            RTL

    .dontExitMap

    LDA.b $B2 : BEQ .zoomTransitionFinished
        DEC.b $B2
        
        JMP .noButtonInput

    .zoomTransitionFinished

    ; Checking -XLR---- (AXLR----)
    LDA.b $F6 : AND.b #$70 : BEQ .noButtonInput
        ; Play the "change map screen" sound effect.
        LDA.b #$24 : STA.w $012F
        
        LDA.b #$08 : STA.b $B2
        
        ; Toggle bit 0 of $0636 and OR in bit 7.
        LDA.w $0636 : EOR.b #$01 : TAX
        
        ORA.b #$80 : STA.w $0636
        
        LDA.l Pool_OverworldMap_Main_BaseZoom, X : STA.w $0637
        CMP.b #$0C : BNE .fartherZoomedOut
            REP #$20
            
            LDA.l $7EC108 : LSR #4
            SEC : SBC.w #$0048 : AND.w #$FFFE : STA.b $E6
            
            CLC : ADC.w #$0100 : STA.w $063A
            
            LDA.l $7EC10A : LSR #4
            SEC : SBC.w #$0080 : STA.b $02 : BPL .BRANCH_ZETA
                EOR.w #$FFFF : INC A

            .BRANCH_ZETA

            STA.b $00
                
            ; A = ($00 * 5) / 2
            ASL #2 : CLC : ADC.b $00 : LSR A
            
            LDX.b $03 : BPL .BRANCH_THETA
                EOR.w #$FFFF : INC A

            .BRANCH_THETA

            CLC : ADC.w #$0080
            
            BRA .BRANCH_IOTA

        .fartherZoomedOut

        REP #$21
        
        LDA.w #$00C8 : STA.b $E6
        ADC.w #$0100 : STA.w $063A
        
        LDA.w #$0080

        .BRANCH_IOTA

        AND.w #$FFFE : STA.b $E0

    .noButtonInput

    SEP #$20
    
    LDA.w $0636 : BEQ .BRANCH_KAPPA
        ; BYSTudlr -> ----ud--
        LDA.b $F0 : AND.b #$0C : TAX
        
        REP #$20
        
        LDA.b $E6 : CMP.l Pool_OverworldMap_Main_PanBoundaries, X : BEQ .BRANCH_LAMBDA
            CLC : ADC.l Pool_OverworldMap_Main_PanMovements, X : STA.b $E6
            CLC : ADC.w #$0100 : STA.w $063A

        .BRANCH_LAMBDA

        SEP #$20
        
        ; BYSTudlr -> ----lr10 -> X
        ; .... who knows what they're doing... Anyways, keep reading.
        LDA.b $F0 : AND.b #$03 : ASL A : INC A : ASL A : TAX
        
        REP #$20
        
        LDA.b $E0 : CMP.l Pool_OverworldMap_Main_PanBoundaries, X : BEQ .BRANCH_MU
            CLC : ADC.l Pool_OverworldMap_Main_PanMovements, X : STA.b $E0

        .BRANCH_MU

        SEP #$20

    .BRANCH_KAPPA

    JSR.w WorldMap_HandleSprites

    ; $053BD5 ALTERNATE ENTRY POINT
    .easyOut

    RTL
}

; ==============================================================================

; 0x0E.0x07.0x06 (coming out of overworld map).
; $053BD6-$053C53 JUMP LOCATION
OverworldMap_PrepExit:
{
    ; Darken screen gradually until fully dark.
    DEC.b $13 : BNE OverworldMap_Main_easyOut
        JSL.l EnableForceBlank
        
        INC.w $0200
        
        REP #$20
        
        LDX.b #$00

        .restore_palette

            ; This restores the palette to the original state before the map
            ; was brought up.
            LDA.l $7EC300, X : STA.l $7EC500, X
            LDA.l $7EC380, X : STA.l $7EC580, X
            LDA.l $7EC400, X : STA.l $7EC600, X
            LDA.l $7EC480, X : STA.l $7EC680, X
        INX #2 : CPX.b #$80 : BNE .restore_palette
        
        ; Next we restore other screen settings (needs some research).
        
        LDA.l $7EC225 : STA.b $99
        
        STZ.b $E4 : STZ.b $EA
        
        LDA.l $7EC200 : STA.b $E0
        LDA.l $7EC202 : STA.b $E2
        LDA.l $7EC204 : STA.b $E6
        LDA.l $7EC206 : STA.b $E8
        LDA.l $7EC211 : STA.b $1C

        ; $053C33 ALTERNATE ENTRY POINT
        .restoreHdmaSettings

        ; Restore HDMA settings on channel 7.
        
        LDA.w #$BDDD : STA.w DMA.7_SourceAddrOffsetLow
        
        LDX.b #$0A : STX.w DMA.7_SourceAddrBank
        LDX.b #$00 : STX.w DMA.7__DataBank
        
        SEP #$30
        
        ; Enable hdma only on channel 7 (for spotlight effect).
        LDA.b #$80 : STA.b $9B
        
        ; Return to screen mode 1 (with priority bit enabled).
        LDA.b #$09 : STA.w SNES.BGModeAndTileSize
        
        STA.b $94
        
        STZ.w $0710
        
        RTL
}

; ==============================================================================

; ZS makes a jump in this function.
; 0x0E.0x07.0x07 (restoring graphics?)
; $053C54-$053C95 LONG JUMP LOCATION
OverworldMap_RestoreGfx:
{ 
    ; Indicate that special palette values are no longer in use.
    STZ.w $0AA9
    STZ.w $0AB2
        
    ; ZS writes here.
    ; $053C5A

    JSL.l InitTilesets
        
    ; Update CGRAM this frame.
    INC.b $15
        
    ; Set things back to the way they were, submodule-wise.
    STZ.b $B2
    STZ.w $0200
    STZ.b $B0
        
    ; Restore module we came from.
    LDA.w $010C : STA.b $10
        
    ; Put us in submodule 0x20.
    LDA.b #$20 : STA.b $11
        
    ; Indicate there's no special tile or tilemap transfers this frame.
    STZ.w $1000 : STZ.w $1001
        
    ; Restore CGADSUB.
    LDA.l $7EC229 : STA.b $9B
        
    ; OPTIMIZE: Useless SEP? we are already in 8 bit mode.
    SEP #$20
        
    ; Restore ambient sound effect (rain, etc).
    LDX.b $8A : LDA.l $7F5B00, X : LSR #4 : STA.w $012D
        
    ; Play sound effect indicating we're coming out of map mode.
    LDA.b #$10 : STA.w $012F
        
    ; Signal music to go back to full volume.
    LDA.b #$F3 : STA.w $012C
        
    RTL
}

; ==============================================================================

; $053C96-$053DA4 LOCAL JUMP LOCATION
WorldMap_SetUpHDMA:
{
    REP #$20
    
    LDA.w #$0080 : STA.b $E0
    LDA.w #$00C8 : STA.b $E6
    ADC.w #$0100 : STA.w $063A
    
    LDA.w #$0100 : STA.w $0638
    
    LDA.w #$1B42 : STA.w DMA.6_TransferParameters
    LDA.w #$1E42 : STA.w DMA.7_TransferParameters
    
    SEP #$20
    
    STZ.b $96 : STZ.b $97 : STZ.b $98
    
    STZ.b $1E : STZ.b $1F
    
    STZ.w SNES.Mode7MatrixB : STZ.w SNES.Mode7MatrixB
    STZ.w SNES.Mode7MatrixC : STZ.w SNES.Mode7MatrixC
    
    STZ.w SNES.Mode7CenterPosX : LDA.b #$01 : STA.w SNES.Mode7CenterPosX
    STZ.w SNES.Mode7CenterPosY : STA.w SNES.Mode7CenterPosY 
    
    LDA.b $10 : CMP.b #$14 : BEQ .attractMode
        LDA.b $11 : CMP.b #$0A : BNE .beta
            JMP .flute_map

        .beta

        LDA.b #$04 : STA.w $0635
        LDA.b #$0C : STA.w $0637
        LDA.b #$01 : STA.w $0636
        
        REP #$21
        
        LDA.l $7EC108 : LSR #4
        SEC : SBC.w #$0048 : AND.w #$FFFE : CLC : ADC.l Pool_OverworldMap_Main_PanMovements : STA.b $E6
        CLC : ADC.w #$0100 : STA.w $063A
        
        LDA.l $7EC10A : LSR #4
        SEC : SBC.w #$0080 : STA.b $02 : BPL .BRANCH_GAMMA
            EOR.w #$FFFF : INC A

        .BRANCH_GAMMA

        STA.b $00
        ASL #2 : CLC : ADC.b $00 : LSR A
        
        LDX.b $03 : BPL .BRANCH_DELTA
            EOR.w #$FFFF : INC A

        .BRANCH_DELTA

        CLC : ADC.w #$0080 : AND.w #$FFFE : STA.b $E0
        
        LDA.w #$BDD6 : STA.w DMA.6_SourceAddrOffsetLow : STA.w DMA.7_SourceAddrOffsetLow
        LDX.b #$0A   : STX.w DMA.6_SourceAddrBank : STX.w DMA.7_SourceAddrBank
        
        LDX.b #$0A
        
        BRA .BRANCH_EPSILON

    .attractMode

    REP #$21
    
    LDA.w #$BDDD : STA.w DMA.6_SourceAddrOffsetLow : STA.w DMA.7_SourceAddrOffsetLow
    LDX.b #$0A   : STX.w DMA.6_SourceAddrBank : STX.w DMA.7_SourceAddrBank
    
    LDX.b #$00
    
    BRA .BRANCH_EPSILON

    ; $053D76 ALTERNATE ENTRY POINT
    .flute_map

    LDA.b #$04 : STA.w $0635
    LDA.b #$21 : STA.w $0637
               : STZ.w $0636
    
    REP #$21
    
    LDA.w #$BDCF : STA.w DMA.6_SourceAddrOffsetLow : STA.w DMA.7_SourceAddrOffsetLow
    LDX.b #$0A   : STX.w DMA.6_SourceAddrBank : STX.w DMA.7_SourceAddrBank
    
    LDX.b #$0A

    .BRANCH_EPSILON

    STX.w DMA.6__DataBank : STX.w DMA.7__DataBank
    
    SEP #$20
    
    ; Enable hdma transfers on channels 6 and 7.
    LDA.b #$C0 : STA.b $9B
    
    RTS
}

; ==============================================================================

; $053DA5-$053DCE LOCAL JUMP LOCATION
ClearMode7Tilemap:
{
    ; Clears out the low bytes of the first 0x4000 words of VRAM.
    REP #$20
    
    LDA.w #$00EF : STA.b $00
    
    ; Sets VRAM address to 0x0000 and configures the video port.
    STZ.w SNES.VRAMAddrIncrementVal : STZ.w SNES.VRAMAddrReadWriteLow
    
    ; Destination register is $2118 and DMA address will not be adjusted.
    LDA.w #$1808 : STA.w DMA.1_TransferParameters
    
    ; Use bank $00 for DMA address.
    STZ.w DMA.1_SourceAddrBank
    
    ; Use address $000000 ($7E:0000) for DMA address.
    LDA.w #$0000 : STA.w DMA.1_SourceAddrOffsetLow
    
    ; Write 0x4000 bytes.
    LDA.w #$4000 : STA.w DMA.1_TransferSizeLow
    
    ; Do transfer on DMA channel 0.
    LDY.b #$02 : STY.w SNES.DMAChannelEnable
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $053DCF-$053DD5 DATA
WorldMapHDMA_ZoomedOut:
{
    db $F0 : dw WorldMapHDMA_ZoomedOut_Part1 ; 112 lines, continuous
    db $F0 : dw WorldMapHDMA_ZoomedOut_Part2 ; 112 lines, continuous
    db $00 ; End
}

; ==============================================================================

; $053DD6-$053DDC DATA
WorldMapHDMA_ZoomedIn:
{
    db $F0 : dw WorldMapHDMA_ZoomedIn_Part1 ; 112 lines, continuous
    db $F0 : dw WorldMapHDMA_ZoomedIn_Part2 ; 112 lines, continuous
    db $00 ; End
}

; ==============================================================================

; $053DDD-$053DE3 DATA
WorldMapHDMA_AttractMode:
{
    db $F0 : dw $1B00 ; 112 lines, continuous
    db $F0 : dw $1BE0 ; 112 lines, continuous
    db $00 ; End
}

; ==============================================================================

; $053DE4-$053DF5 DATA
WorldMapIcon_posx_spr0:
{
    dw $07FF ; 0x00
    dw $02C0 ; 0x01
    dw $0D00 ; 0x02
    dw $0F31 ; 0x03
    dw $006D ; 0x04
    dw $07E0 ; 0x05
    dw $0F40 ; 0x06
    dw $0F40 ; 0x07
    dw $08DC ; 0x08
}

; $053DF6-$053E07 DATA
WorldMapIcon_posy_spr0:
{
    dw $0730 ; 0x00
    dw $06A0 ; 0x01
    dw $0710 ; 0x02
    dw $0620 ; 0x03
    dw $0070 ; 0x04
    dw $0640 ; 0x05
    dw $0620 ; 0x06
    dw $0620 ; 0x07
    dw $0030 ; 0x08
}

; ==============================================================================

; $053E08-$053E19 DATA
WorldMapIcon_posx_spr1:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $08D0 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0082 ; 0x07
    dw $FF00 ; 0x08
}

; $053E1A-$053E2B DATA
WorldMapIcon_posy_spr1:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $0080 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $00B0 ; 0x07
    dw $FF00 ; 0x08
}

; ==============================================================================

; $053E2C-$053E3D DATA
WorldMapIcon_posx_spr2:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $0108 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0F11 ; 0x07
    dw $FF00 ; 0x08
}

; $053E3E-$053E4F DATA
WorldMapIcon_posy_spr2:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $0D70 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0103 ; 0x07
    dw $FF00 ; 0x08
}

; ==============================================================================

; $053E50-$053E61 DATA
WorldMapIcon_posx_spr3:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $006D ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $01D0 ; 0x07
    dw $FF00 ; 0x08
}

; $053E62-$053E73 DATA
WorldMapIcon_posy_spr3:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $0070 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0780 ; 0x07
    dw $FF00 ; 0x08
}

; ==============================================================================

; $053E74-$053E85 DATA
WorldMapIcon_posx_spr4:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $FF00 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0100 ; 0x07
    dw $FF00 ; 0x08
}

; $053E86-$053E97 DATA
WorldMapIcon_posy_spr4:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $FF00 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0CA0 ; 0x07
    dw $FF00 ; 0x08
}

; ==============================================================================

; $053E98-$053EA9 DATA
WorldMapIcon_posx_spr5:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $FF00 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0CA0 ; 0x07
    dw $FF00 ; 0x08
}

; $053EAA-$053EBB DATA
WorldMapIcon_posy_spr5:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $FF00 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0DA0 ; 0x07
    dw $FF00 ; 0x08
}

; ==============================================================================

; $053EBC-$053ECD DATA
WorldMapIcon_posx_spr6:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $FF00 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0759 ; 0x07
    dw $FF00 ; 0x08
}

; $053ECE-$053EDF DATA
WorldMapIcon_posy_spr6:
{
    dw $FF00 ; 0x00
    dw $FF00 ; 0x01
    dw $FF00 ; 0x02
    dw $FF00 ; 0x03
    dw $FF00 ; 0x04
    dw $FF00 ; 0x05
    dw $FF00 ; 0x06
    dw $0ED0 ; 0x07
    dw $FF00 ; 0x08
}

; ==============================================================================

; $053EE0-$053EF1 DATA
WorldMapIcon_tile_spr0:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $38, $60 ; 0x03
    db $34, $62 ; 0x04
    db $32, $66 ; 0x05
    db $34, $64 ; 0x06
    db $34, $64 ; 0x07
    db $32, $66 ; 0x08
}

; ==============================================================================

; $053EF2-$053F03 DATA
WorldMapIcon_tile_spr1:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $32, $60 ; 0x03
    db $00, $00 ; 0x04
    db $00, $00 ; 0x05
    db $00, $00 ; 0x06
    db $34, $64 ; 0x07
    db $00, $00 ; 0x08
}

; ==============================================================================

; $053F04-$053F15 DATA
WorldMapIcon_tile_spr2:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $34, $60 ; 0x03
    db $00, $00 ; 0x04
    db $00, $00 ; 0x05
    db $00, $00 ; 0x06
    db $34, $64 ; 0x07
    db $00, $00 ; 0x08
}

; ==============================================================================

; $053F16-$053F27 DATA
WorldMapIcon_tile_spr3:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $34, $62 ; 0x03
    db $00, $00 ; 0x04
    db $00, $00 ; 0x05
    db $00, $00 ; 0x06
    db $34, $64 ; 0x07
    db $00, $00 ; 0x08
}

; ==============================================================================

; $053F28-$053F39 DATA
WorldMapIcon_tile_spr4:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $00, $00 ; 0x03
    db $00, $00 ; 0x04
    db $00, $00 ; 0x05
    db $00, $00 ; 0x06
    db $34, $64 ; 0x07
    db $00, $00 ; 0x08
}

; ==============================================================================

; $053F3A-$053F4B DATA
WorldMapIcon_tile_spr5:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $00, $00 ; 0x03
    db $00, $00 ; 0x04
    db $00, $00 ; 0x05
    db $00, $00 ; 0x06
    db $34, $64 ; 0x07
    db $00, $00 ; 0x08
}

; ==============================================================================

; $053F4C-$053F5D DATA
WorldMapIcon_tile_spr6:
{
    db $00, $00 ; 0x00
    db $00, $00 ; 0x01
    db $00, $00 ; 0x02
    db $00, $00 ; 0x03
    db $00, $00 ; 0x04
    db $00, $00 ; 0x05
    db $00, $00 ; 0x06
    db $34, $64 ; 0x07
    db $00, $00 ; 0x08
}

; ==============================================================================

; $053F5E-$053F61 DATA
WorldMap_RedXChars:
{
    db $68, $69, $78, $69
}

; ==============================================================================

; $053F62-$053F65
WorldMap_PortalProps:
{
    db $34, $74, $F4, $B4
}

; ==============================================================================

; $053F66-$05439E LOCAL JUMP LOCATION
WorldMap_HandleSprites:
{
    LDA.b $1A : AND.b #$10 : BEQ .BRANCH_ALPHA
        JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_ALPHA
            LDA.b $0E : SEC : SBC.b #$04 : STA.b $0E
            LDA.b $0F : SEC : SBC.b #$04 : STA.b $0F
            
            LDA.b #$00 : STA.b $0D
            LDA.b #$3E : STA.b $0C
            LDA.b #$02 : STA.b $0B
            
            LDX.b #$00
            
            JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_ALPHA

    LDA.l $7EC108 : PHA
    LDA.l $7EC109 : PHA
    LDA.l $7EC10A : PHA
    LDA.l $7EC10B : PHA
    
    LDA.w $008A : CMP.b #$40 : BCS .BRANCH_BETA
        LDX.b #$0F
        
        LDA.w $1AB0, X : ORA.w $1AC0, X : ORA.w $1AD0, X : ORA.w $1AE0, X : BEQ .BRANCH_BETA
            LDA.b $1A : BNE .BRANCH_GAMMA
                LDA.w $1AF0, X : INC A : STA.w $1AF0, X

            .BRANCH_GAMMA

            LDA.w $1AB0, X : STA.l $7EC10A
            LDA.w $1AC0, X : STA.l $7EC10B
            LDA.w $1AD0, X : STA.l $7EC108
            LDA.w $1AE0, X : STA.l $7EC109
            
            JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_BETA
                LDA.b #$6A : STA.b $0D
                
                LDA.b $1A : LSR A : AND.b #$03 : TAX
                
                LDA.l WorldMap_PortalProps, X : STA.b $0C
                
                LDA.b #$02 : STA.b $0B
                
                LDX.b #$0F
                
                JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_BETA

    LDA.l $7EF2DB : AND.b #$20 : BNE .BRANCH_DELTA
        ; Load map icon indicator variable.
        LDA.l $7EF3C7 : CMP.b #$06 : ROL A : EOR.w $0FFF : AND.b #$01 : BEQ .lightWorldSprites

    .BRANCH_DELTA

    JMP.w WorldMap_HandleSprites_restore_coords_and_exit

    .lightWorldSprites

    ; Checking pendant 0 (courage).
    LDX.b #$00
    
    JSR.w OverworldMap_CheckPendant : BCS .BRANCH_ZETA
        JSR.w OverworldMap_CheckCrystal : BCS .BRANCH_ZETA
            ; X = (map sprites indicator << 1)
            LDA.l $7EF3C7 : ASL A : TAX
            
            LDA.l WorldMapIcon_posx_spr0-1, X : BMI .BRANCH_ZETA
                STA.l $7EC10B
                
                LDA.l WorldMapIcon_posx_spr0+0, X : STA.l $7EC10A
                LDA.l WorldMapIcon_posy_spr0+1, X : STA.l $7EC109
                LDA.l WorldMapIcon_posy_spr0+2, X : STA.l $7EC108
                
                LDA.l WorldMapIcon_tile_spr0+1, X : BEQ .BRANCH_THETA
                    CMP.b #$64 : BEQ .BRANCH_IOTA
                        LDA.b $1A : AND.b #$10 : BNE .BRANCH_ZETA
                            .BRANCH_IOTA

                            JSR.w WorldMapIcon_AdjustCoordinate

                .BRANCH_THETA

                LDX.b #$0E
                
                JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_ZETA
                    ; X = (map sprites indicator << 1)
                    LDA.l $7EF3C7 : ASL A : TAX
                    
                    LDA.l WorldMapIcon_tile_spr0+1, X : BEQ .BRANCH_KAPPA
                        STA.b $0D
                        
                        LDA.l WorldMapIcon_tile_spr0, X : STA.b $0C
                        
                        LDA.b #$02
                        
                        BRA .BRANCH_LAMBDA

                    .BRANCH_KAPPA

                    LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                    
                    LDA.l WorldMap_RedXChars, X : STA.b $0D
                    LDA.b #$32                  : STA.b $0C
                    LDA.b #$00

                    .BRANCH_LAMBDA

                    STA.b $0B
                    
                    LDX.b #$0E
                    
                    JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_ZETA

    LDX.b #$01
    
    JSR.w Overworldmap_CheckPendant : BCS .BRANCH_MU
        JSR.w OverworldMap_CheckCrystal : BCS .BRANCH_MU
            ; X = (map sprites indicator << 1)
            LDA.l $7EF3C7 : ASL A : TAX
            
            LDA.l WorldMapIcon_posx_spr1+1, X : BMI .BRANCH_MU
                STA.l $7EC10B
                
                LDA.l WorldMapIcon_posx_spr1, X : STA.l $7EC10A
                LDA.l WorldMapIcon_posy_spr1+1, X : STA.l $7EC109
                LDA.l WorldMapIcon_posy_spr1+0, X : STA.l $7EC108
                
                LDA.l WorldMapIcon_tile_spr1+1, X : BEQ .BRANCH_NU
                    CMP.b #$64 : BEQ .BRANCH_XI
                        ; Every 16 frames...
                        LDA.b $1A : AND.b #$10 : BNE .BRANCH_MU
                            .BRANCH_XI

                            JSR.w WorldMapIcon_AdjustCoordinate

                .BRANCH_NU

                JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_MU
                    ; X = (map sprites indicator << 1)
                    LDA.l $7EF3C7 : ASL A : TAX
                            
                    LDA.l WorldMapIcon_tile_spr1+1, X : BEQ .BRANCH_OMICRON
                        STA.b $0D
                                
                        LDA.l WorldMapIcon_tile_spr1+0, X : STA.b $0C
                                
                        LDA.b #$02
                                
                        BRA .BRANCH_PI

                    .BRANCH_OMICRON

                    LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                            
                    LDA.lWorldMap_RedXChars, X : STA.b $0D
                    LDA.b #$32 : STA.b $0C
                    LDA.b #$00

                    .BRANCH_PI

                    STA.b $0B
                            
                    LDX.b #$0D
                            
                    JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_MU

    LDX.b #$02
    
    JSR.w Overworldmap_CheckPendant : BCS .BRANCH_RHO
        JSR.w OverworldMap_CheckCrystal : BCS .BRANCH_RHO
            ; X = (map sprites indicator << 1)
            LDA.l $7EF3C7 : ASL A : TAX
            
            LDA.l WorldMapIcon_posx_spr2+1, X : BMI .BRANCH_RHO
                STA.l $7EC10B
                
                LDA.l WorldMapIcon_posx_spr2+0, X : STA.l $7EC10A
                LDA.l WorldMapIcon_posy_spr2+1, X : STA.l $7EC109
                LDA.l WorldMapIcon_posy_spr2+0, X : STA.l $7EC108
                
                LDA.l WorldMapIcon_tile_spr2+1, X : BEQ .BRANCH_SIGMA
                    CMP.b #$64 : BEQ .BRANCH_TAU
                        LDA.b $1A : AND.b #$10 : BNE .BRANCH_RHO
                            .BRANCH_TAU

                            JSR.w WorldMapIcon_AdjustCoordinate

                .BRANCH_SIGMA

                LDX.b #$0C
                            
                JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_RHO
                    ; X = (map sprites indictaor << 1)
                    LDA.l $7EF3C7 : ASL A : TAX
                                
                    LDA.l WorldMapIcon_tile_spr2+1, X : BEQ .BRANCH_UPSILON
                        STA.b $0D
                                    
                        LDA.l WorldMapIcon_tile_spr2+0, X : STA.b $0C
                                    
                        LDA.b #$02
                                    
                        BRA .BRANCH_PHI

                    .BRANCH_UPSILON

                    LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                                
                    LDA.l WorldMap_RedXChars, X : STA.b $0D
                                
                    LDA.b #$32 : STA.b $0C
                                
                    LDA.b #$00

                    .BRANCH_PHI

                    STA.b $0B
                                
                    LDX.b #$0C
                                
                    JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_RHO

    LDX.b #$03
    
    JSR.w OverworldMap_CheckCrystal : BCS .BRANCH_CHI
        ; X = (map sprites indicator << 1)
        LDA.l $7EF3C7 : ASL A : TAX
        
        LDA.l WorldMapIcon_posx_spr3+1, X : BMI .BRANCH_CHI
            STA.l $7EC10B
            
            LDA.l WorldMapIcon_posx_spr3+0, X : STA.l $7EC10A
            LDA.l WorldMapIcon_posy_spr3+1, X : STA.l $7EC109
            LDA.l WorldMapIcon_posy_spr3+0, X : STA.l $7EC108
            
            LDA.l WorldMapIcon_tile_spr3+1, X : BEQ .BRANCH_PSI
                CMP.b #$64 : BEQ .BRANCH_OMEGA
                    LDA.b $1A : AND.b #$10 : BNE .BRANCH_CHI
                        .BRANCH_OMEGA

                        JSR.w WorldMapIcon_AdjustCoordinate

            .BRANCH_PSI

            LDX.b #$0B
            
            JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_CHI
                ; X = (map sprites indicator << 1)
                LDA.l $7EF3C7 : ASL A : TAX
                
                LDA.l WorldMapIcon_tile_spr3+1, X : BEQ .BRANCH_ALTIMA
                    STA.b $0D
                    
                    LDA.l WorldMapIcon_tile_spr3+0, X : STA.b $0C
                    
                    LDA.b #$02
                    
                    BRA .BRANCH_ULTIMA

                .BRANCH_ALTIMA

                LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                
                LDA.l WorldMap_RedXChars, X : STA.b $0D
                LDA.b #$32 : STA.b $0C
                LDA.b #$00

                .BRANCH_ULTIMA

                STA.b $0B
                
                LDX.b #$0B
                
                JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_CHI

    LDX.b #$04
    
    JSR.w OverworldMap_CheckCrystal : BCS .BRANCH_OPTIMUS
        ; X = (map sprites indicator << 1)
        LDA.l $7EF3C7 : ASL A : TAX
        
        LDA.l WorldMapIcon_posx_spr4+1, X : BMI .BRANCH_OPTIMUS
            STA.l $7EC10B
            
            LDA.l WorldMapIcon_posx_spr4+0, X : STA.l $7EC10A
            LDA.l WorldMapIcon_posy_spr4+1, X : STA.l $7EC109
            LDA.l WorldMapIcon_posy_spr4+0, X : STA.l $7EC108
            
            LDA.l WorldMapIcon_tile_spr4+1, X : BEQ .BRANCH_ALIF
                CMP.b #$64 : BEQ .BRANCH_BET
                    LDA.b $1A : AND.b #$10 : BNE .BRANCH_OPTIMUS
                        .BRANCH_BET

                        JSR.w WorldMapIcon_AdjustCoordinate

            .BRANCH_ALIF

            LDX.b #$0A
            
            JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_OPTIMUS
                ; X = (map sprites indicator << 1)
                LDA.l $7EF3C7 : ASL A : TAX
                
                LDA.l WorldMapIcon_tile_spr4+1, X : BEQ .BRANCH_DEL
                    STA.b $0D
                    
                    LDA.l WorldMapIcon_tile_spr4+0, X : STA.b $0C
                    
                    LDA.b #$02
                    
                    BRA .BRANCH_THEL

                .BRANCH_DEL

                LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                
                LDA.l WorldMap_RedXChars, X : STA.b $0D
                LDA.b #$32 : STA.b $0C
                
                LDA.b #$00

                .BRANCH_THEL

                STA.b $0B
                
                LDX.b #$0A
                
                JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_OPTIMUS

    LDX.b #$05
    
    JSR.w OverworldMap_CheckCrystal : BCS .BRANCH_SIN
        LDA.l $7EF3C7 : ASL A : TAX
        
        LDA.l WorldMapIcon_posx_spr5+1, X : BMI .BRANCH_SIN
            STA.l $7EC10B
            
            LDA.l WorldMapIcon_posx_spr5+0, X : STA.l $7EC10A
            LDA.l WorldMapIcon_posy_spr5+1, X : STA.l $7EC109
            LDA.l WorldMapIcon_posy_spr5+0, X : STA.l $7EC108
            
            LDA.l WorldMapIcon_tile_spr5+1, X : BEQ .BRANCH_SHIN
                CMP.b #$64 : BEQ .BRANCH_SOD
                    LDA.b $1A : AND.b #$10 : BNE .BRANCH_SIN
                        .BRANCH_SOD

                        JSR.w WorldMapIcon_AdjustCoordinate

            .BRANCH_SHIN

            LDX.b #$09
            
            JSR.w WorldMap_CalculateOAMCoordinates : BCC .BRANCH_SIN
                LDA.l $7EF3C7 : ASL A : TAX
                
                LDA.l WorldMapIcon_tile_spr5+1, X : BEQ .BRANCH_DOD
                    STA.b $0D
                    
                    LDA.l WorldMapIcon_tile_spr56+0, X : STA.b $0C
                    
                    LDA.b #$02
                    
                    BRA .BRANCH_TOD

                .BRANCH_DOD

                LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                
                LDA.l WorldMap_RedXChars, X : STA.b $0D
                LDA.b #$32 : STA.b $0C
                
                LDA.b #$00

                .BRANCH_TOD

                STA.b $0B
                
                LDX.b #$09
                
                JSR.w WorldMap_HandleSpriteBlink

    .BRANCH_SIN

    LDX.b #$06
    
    JSR.w OverworldMap_CheckCrystal : BCS .restore_coords_and_exit
        LDA.l $7EF3C7 : ASL A : TAX
        
        LDA.l WorldMapIcon_posx_spr6+1, X : BMI .restore_coords_and_exit
            STA.l $7EC10B
            
            LDA.l WorldMapIcon_posx_spr6+0, X : STA.l $7EC10A
            LDA.l WorldMapIcon_posy_spr6+1, X : STA.l $7EC109
            LDA.l WorldMapIcon_posy_spr6+0, X : STA.l $7EC108
            
            LDA.l WorldMapIcon_tile_spr6+1, X : BEQ .BRANCH_FATHA
                CMP.b #$64 : BEQ .BRANCH_KESRA
                    LDA.b $1A : AND.b #$10 : BNE .restore_coords_and_exit
                        .BRANCH_KESRA

                        JSR.w WorldMapIcon_AdjustCoordinate

            .BRANCH_FATHA

            LDX.b #$08
            
            JSR.w WorldMap_CalculateOAMCoordinates : BCC .restore_coords_and_exit
                ; X = (map sprites indicator << 1)
                LDA.l $7EF3C7 : ASL A : TAX
                
                LDA.l WorldMapIcon_tile_spr6+1, X : BEQ .BRANCH_DUMMA
                    STA.b $0D
                    
                    LDA.l WorldMapIcon_tile_spr6+0, X : STA.b $0C
                    
                    LDA.b #$02
                    
                    BRA .BRANCH_EIN

                .BRANCH_DUMMA

                LDA.b $1A : LSR #3 : AND.b #$03 : TAX
                
                LDA.l WorldMap_RedXChars, X : STA.b $0D
                LDA.b #$32 : STA.b $0C
                
                LDA.b #$00

                .BRANCH_EIN

                STA.b $0B
                
                LDX.b #$08
                
                JSR.w WorldMap_HandleSpriteBlink

    ; $05438A ALTERNATE ENTRY POINT
    .restore_coords_and_exit

    PLA : STA.l $7EC10B
    PLA : STA.l $7EC10A
    PLA : STA.l $7EC109
    PLA : STA.l $7EC108
    
    RTS
}

; ==============================================================================

; $05439F-$054514 LOCAL JUMP LOCATION
WorldMap_CalculateOAMCoordinates:
{
    LDA.w $0636 : BNE .BRANCH_ALPHA
        REP #$30
        
        LDA.l $7EC108 : LSR #4 : EOR.w #$FFFF : INC A : ADC.w $063A : SEC : SBC.w #$00C0 : TAX
        
        SEP #$20
        
        LDA.l WorldMap_SpritePositions, X : STA.b $0F
        
        SEP #$30
        
        XBA
        
        LDA.b #$0D
        
        JSR.w WorldMap_MultiplyAxB
        JSR.w WorldMap_ShiftNibblesRight
        
        STA.b $0F
        
        REP #$30
        
        LDA.l $7EC10A : LSR #4
        
        SEP #$30
        
        SEC : SBC.b #$80
        
        PHP : BPL .BRANCH_BETA
            EOR.b #$FF

        .BRANCH_BETA

        PHA
        
        LDA.b $0F : CMP.b #$E0 : BCC .BRANCH_GAMMA
            LDA.b #$00

        .BRANCH_GAMMA

        XBA
        
        LDA.b #$54
        
        JSR.w WorldMap_MultiplyAxB
        
        XBA : CLC : ADC.b #$B2 : XBA
        
        PLA
        
        JSR.w WorldMap_MultiplyAxB
        
        XBA
        
        PLP : BCS .BRANCH_DELTA
            STA.b $00
            
            LDA.b #$80 : SEC : SBC.b $00
            
            BRA .BRANCH_EPSILON

        .BRANCH_DELTA

        CLC : ADC.b #$80

        .BRANCH_EPSILON

        SEC : SBC.b $E0 : STA.b $0E
        
        LDA.b $0E : CLC : ADC.b #$80 : STA.b $0E
        LDA.b $0F : CLC : ADC.b #$0C : STA.b $0F
        
        JMP.w WorldMap_CalculateOAMCoordinates_exit_successfully

    .BRANCH_ALPHA

    REP #$30
    
    LDA.l $7EC108 : LSR #4
    EOR.w #$FFFF : INC A
    CLC : ADC.w $063A : SEC : SBC.w #$0080 : CMP.w #$0100 : BCC .BRANCH_ZETA
        JMP.w WorldMap_CalculateOAMCoordinates_exit_fail

    .BRANCH_ZETA

    SEP #$30
    
    XBA
    
    LDA.b #$25
    
    JSR.w WorldMap_MultiplyAxB
    JSR.w WorldMap_ShiftNibblesRight
    
    REP #$10
    
    TAX : CPX.w #$014D : BCC .BRANCH_THETA
        JMP.w WorldMap_CalculateOAMCoordinates_exit_fail

    .BRANCH_THETA

    LDA.l WorldMap_SpritePositions, X : STA.b $0F
    
    REP #$20
    
    LDA.l $7EC10A : SEC : SBC.w #$07F8
    
    ; TODO: Supposed to be PLP? (check rom).
    PHP

    BPL .BRANCH_IOTA
        EOR.w #$FFFF : INC A
    
    .BRANCH_IOTA

    PHA
    
    SEP #$20
    
    LDA.b $0F : CMP.b #$E2 : BCC .BRANCH_KAPPA
        LDA.b #$00

    .BRANCH_KAPPA

    XBA
    
    LDA.b #$54
    
    JSR.w WorldMap_MultiplyAxB
    
    XBA : CLC : ADC.b #$B2 : STA.b $00 : XBA
    
    PLA
    
    JSR.w WorldMap_MultiplyAxB
    
    XBA : STA.b $01
    
    PLA : XBA
    
    LDA.b $00
    
    JSR.w WorldMap_MultiplyAxB
    
    CLC : ADC.b $01 : XBA : ADC.b #$00 : XBA
    
    PLP : BCS .BRANCH_LAMBDA
        STA.b $00

        LDA.w #$0800 : SEC : SBC.b $00

        BRA .BRANCH_MU

    .BRANCH_LAMBDA

    CLC : ADC.w #$0800

    .BRANCH_MU

    SEC : SBC.w #$0800 : BCS .BRANCH_NU
        EOR.w #$FFFF : INC A

    .BRANCH_NU

    SEP #$20

    PHP

    XBA : PHA

    LDA.b #$2D

    JSR.w WorldMap_MultiplyAxB

    XBA : STA.b $00

    PLA : XBA

    LDA.b #$2D

    JSR.w WorldMap_MultiplyAxB

    CLC : ADC.b $00 : XBA : ADC.b #$00 : XBA

    PLP

    BCS .BRANCH_XI
        STA.b $00

        LDA.b #$80 : SEC : SBC.b $00 : XBA : STA.b $00
        LDA.b #$00 : SBC.b $00 : XBA
        
        BRA .BRANCH_OMICRON

    .BRANCH_XI

    CLC : ADC.b #$80 : XBA : ADC.b #$00 : XBA

    .BRANCH_OMICRON

    PHA : SEC : SBC.b $E0 : STA.b $0E
    
    PLA
    
    REP #$30
    
    SEC : SBC.w #$FF80 : SEC : SBC.b $E0
    
    SEP #$30
    
    XBA : BNE .exit_fail
        LDA.b $0E : CLC : ADC.b #$81 : STA.b $0E
        LDA.b $0F : CLC : ADC.b #$10 : STA.b $0F

        ; $05450D ALTERNATE ENTRY POINT
        .exit_successfully

        SEP #$30
        
        SEC
        
        RTS

    ; $054511 ALTERNATE ENTRY POINT
    .exit_fail

    SEP #$30
    
    CLC
    
    RTS
}

; ==============================================================================

; $054515-$05451B DATA
WorldMap_HandleSpriteBlink_crystal_numbers:
{
    db $79 ; 2
    db $6E ; 5
    db $6F ; 6
    db $6D ; 4
    db $7C ; 7
    db $6C ; 3
    db $7F ; 1
}

; $05451C-$05456C LOCAL JUMP LOCATION
WorldMap_HandleSpriteBlink:
{
    ; Alternates on and off every 16 frames.
    LDA.b $1A : LSR #4 : AND.b #$01 : BNE .BRANCH_ALPHA
        LDA.b $0D : CMP.b #$64 : BNE .BRANCH_ALPHA
            ; Since the base of this array starts in code, we deduce that
            ; X must range from 0x08 and 0x0E.
            LDA.l .crystal_numbers-8, X : STA.b $0D
            LDA.b #$32 : STA.b $0C
            
            STZ.w $0A20, X
            
            TXA : ASL #2 : TAX
            
            ; Set coordinates of the sprite.
            LDA.b $0E : STA.w $0800, X
            LDA.b $0F : STA.w $0801, X
            
            BRA .finishedWithCoords

    .BRANCH_ALPHA

    LDA.b $0B : STA.w $0A20, X
    
    TXA : ASL #2 : TAX
    
    ; Offset the coordinates of the sprite by -4, vertically and horizontally.
    LDA.b $0E : SEC : SBC.b #$04 : STA.w $0800, X
    LDA.b $0F : SEC : SBC.b #$04 : STA.w $0801, X

    .finishedWithCoords

    ; Set CHR, palette, and priority of the sprite.
    LDA.b $0D : STA.w $0802, X
    LDA.b $0C : STA.w $0803, X
    
    RTS
}

; ==============================================================================
    
; $05456D-$05457F LOCAL JUMP LOCATION
WorldMap_MultiplyAxB:
{
    STA.w SNES.MultiplicandA
    
    XBA : STA.w SNES.MultiplierB
    
    NOP #4
    
    LDA.w SNES.RemainderResultHigh : XBA
    
    LDA.w SNES.RemainderResultLow
    
    RTS
}

; ==============================================================================

; $054580-$054588 LOCAL JUMP LOCATION
WorldMap_ShiftNibblesRight:
{
    REP #$30
    
    LSR #4
    
    SEP #$30
    
    RTS
}

; $054589-$0545A5 LOCAL JUMP LOCATION
WorldMapIcon_AdjustCoordinate:
{
    REP #$20
    
    LDA.l $7EC10A : SEC : SBC.w #$0004 : STA.l $7EC10A
    LDA.l $7EC108 : SEC : SBC.w #$0004 : STA.l $7EC108
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0545A6-$0545A8 DATA
OverworldMap_CheckForPendant_bit:
{
    db $04, $02, $01
}

; $0545A9-$0545BE LOCAL JUMP LOCATION
Overworldmap_CheckPendant:
{
    ; X is an input variable to this function.
    
    ; Check if the sprites indicator tells us to show the three pendants.
    LDA.l $7EF3C7 : CMP.b #$03 : BNE .fail
        ; Check if we have that pendant.
        LDA.l $7EF374 : AND.l .bit, X : BEQ .fail
            SEC
            
            RTS

    ; $0545BD ALTERNATE ENTRY POINT
    .fail

    CLC
    
    RTS
}

; ==============================================================================
    
; $0545BF-$0545C5 DATA
OverworldMap_CheckForCrystal_bit:
{
    db $02, $40, $08, $20, $01, $04, $10
}

; $0545C6-$0545D9 LOCAL JUMP LOCATION
OverworldMap_CheckCrystal:
{
    ; Check if the sprite indicator tells us to show all 7 crystals
    ; (ones we've yet to obtain).
    LDA.l $7EF3C7 : CMP.b #$07 : BNE OverworldMap_CheckPendant_fail
        ; Check if we have that crystal.
        LDA.l $7EF37A : AND.l .bit, X : BEQ OverworldMap_CheckPendant_fail
            SEC
            
            RTS
}

; ==============================================================================

; $0545DA-$054726 DATA
WorldMap_SpritePositions:
{
    db $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
    db $E0, $E0, $E0, $E0, $E0, $E0, $E0, $DF
    db $DE, $DD, $DC, $DB, $DA, $D8, $D7, $D6
    db $D5, $D4, $D3, $D2, $D1, $D0, $CF, $CE
    db $CD, $CC, $CB, $CA, $C9, $C7, $C6, $C5
    db $C4, $C3, $C2, $C1, $C0, $BF, $BE, $BD
    db $BC, $BB, $BA, $B9, $B8, $B7, $B6, $B5
    db $B4, $B3, $B2, $B1, $B0, $AF, $AE, $AD
    db $AC, $AB, $AA, $A9, $A8, $A7, $A6, $A5
    db $A4, $A3, $A2, $A1, $A0, $9F, $9E, $9D
    db $9C, $9B, $9B, $9A, $99, $98, $97, $96
    db $95, $94, $93, $92, $91, $90, $8F, $8E
    db $8D, $8C, $8B, $8B, $8A, $89, $88, $87
    db $86, $85, $84, $83, $82, $81, $81, $80
    db $7F, $7E, $7D, $7C, $7B, $7A, $79, $79
    db $78, $77, $76, $75, $74, $73, $72, $72
    db $71, $70, $6F, $6E, $6D, $6C, $6C, $6B
    db $6A, $69, $68, $67, $67, $66, $65, $64
    db $63, $62, $62, $61, $60, $5F, $5E, $5D
    db $5D, $5C, $5B, $5A, $59, $59, $58, $57
    db $56, $55, $55, $54, $53, $52, $51, $51
    db $50, $4F, $4E, $4E, $4D, $4C, $4B, $4A
    db $4A, $49, $48, $47, $47, $46, $45, $44
    db $44, $43, $42, $41, $41, $40, $3F, $3E
    db $3E, $3D, $3C, $3C, $3B, $3A, $39, $39
    db $38, $37, $36, $36, $35, $34, $34, $33
    db $32, $32, $31, $30, $2F, $2F, $2E, $2D
    db $2D, $2C, $2B, $2B, $2A, $29, $29, $28
    db $27, $27, $26, $25, $25, $24, $23, $23
    db $22, $21, $21, $20, $1F, $1F, $1E, $1D
    db $1D, $1C, $1C, $1B, $1A, $1A, $19, $18
    db $18, $17, $17, $16, $15, $15, $14, $14
    db $13, $12, $12, $11, $10, $10, $0F, $0F
    db $0E, $0E, $0D, $0C, $0C, $0B, $0B, $0A
    db $09, $09, $08, $08, $07, $07, $06, $05
    db $05, $04, $04, $03, $03, $02, $01, $01
    db $00, $00, $00, $00, $FF, $FE, $FE, $FD
    db $FC, $FC, $FB, $FB, $FA, $F9, $F9, $F8
    db $F7, $F7, $F6, $F5, $F4, $F4, $F3, $F2
    db $F2, $F1, $F0, $EF, $EE, $EE, $ED, $EC
    db $EB, $EA, $E9, $E8, $E8, $E7, $E6, $E5
    db $E4, $E3, $E2, $E1, $E0
}

; ==============================================================================

; $054727-$055726 DATA
WorldMap_LightWorldTilemap:
{
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 00, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 00, Strip 1
    db $28, $28, $28, $28, $28, $2C, $09, $08 ; Quadrant 0, Row 00, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 00, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 0, Row 01, Strip 0
    db $29, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 01, Strip 1
    db $28, $28, $28, $28, $28, $28, $2A, $28 ; Quadrant 0, Row 01, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 01, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 02, Strip 0
    db $2C, $09, $08, $09, $28, $28, $28, $28 ; Quadrant 0, Row 02, Strip 1
    db $28, $28, $28, $28, $28, $08, $29, $28 ; Quadrant 0, Row 02, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 02, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 03, Strip 0
    db $28, $2C, $2D, $2C, $09, $28, $28, $28 ; Quadrant 0, Row 03, Strip 1
    db $28, $28, $28, $28, $08, $28, $2C, $09 ; Quadrant 0, Row 03, Strip 2
    db $08, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 0, Row 03, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 04, Strip 0
    db $28, $28, $2C, $28, $2B, $09, $28, $28 ; Quadrant 0, Row 04, Strip 1
    db $28, $28, $28, $08, $28, $28, $28, $2A ; Quadrant 0, Row 04, Strip 2
    db $28, $28, $28, $28, $28, $28, $08, $28 ; Quadrant 0, Row 04, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 05, Strip 0
    db $28, $28, $28, $28, $2B, $2A, $28, $28 ; Quadrant 0, Row 05, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 05, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 05, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 06, Strip 0
    db $28, $29, $28, $28, $2A, $28, $28, $28 ; Quadrant 0, Row 06, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 06, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 06, Strip 3
    db $28, $28, $08, $29, $28, $28, $28, $28 ; Quadrant 0, Row 07, Strip 0
    db $28, $2C, $29, $28, $28, $28, $28, $28 ; Quadrant 0, Row 07, Strip 1
    db $28, $08, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 07, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 07, Strip 3
    db $28, $08, $28, $2C, $09, $08, $28, $28 ; Quadrant 0, Row 08, Strip 0
    db $28, $28, $2B, $09, $08, $29, $08, $29 ; Quadrant 0, Row 08, Strip 1
    db $08, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 08, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 08, Strip 3
    db $08, $28, $28, $28, $2A, $28, $28, $28 ; Quadrant 0, Row 09, Strip 0
    db $28, $28, $2B, $2E, $2D, $2C, $2D, $2C ; Quadrant 0, Row 09, Strip 1
    db $2D, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 09, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 09, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0A, Strip 0
    db $28, $28, $2C, $2C, $2C, $28, $2C, $28 ; Quadrant 0, Row 0A, Strip 1
    db $2C, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0A, Strip 2
    db $28, $28, $28, $28, $08, $29, $28, $2F ; Quadrant 0, Row 0A, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0B, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0B, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0B, Strip 2
    db $28, $08, $09, $08, $28, $2C, $09, $1B ; Quadrant 0, Row 0B, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0C, Strip 0
    db $28, $28, $28, $29, $28, $28, $28, $28 ; Quadrant 0, Row 0C, Strip 1
    db $28, $2F, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0C, Strip 2
    db $08, $28, $2C, $2D, $28, $28, $2B, $19 ; Quadrant 0, Row 0C, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0D, Strip 0
    db $28, $28, $28, $2C, $29, $28, $2F, $28 ; Quadrant 0, Row 0D, Strip 1
    db $2F, $1B, $1A, $28, $2F, $28, $2F, $08 ; Quadrant 0, Row 0D, Strip 2
    db $28, $28, $28, $2C, $28, $28, $2C, $2E ; Quadrant 0, Row 0D, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0E, Strip 0
    db $28, $28, $28, $28, $2C, $38, $1B, $1C ; Quadrant 0, Row 0E, Strip 1
    db $1D, $1F, $1E, $1A, $1B, $1C, $1D, $1A ; Quadrant 0, Row 0E, Strip 2
    db $28, $2F, $28, $2F, $28, $28, $28, $2B ; Quadrant 0, Row 0E, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 0F, Strip 0
    db $28, $28, $28, $28, $28, $2E, $19, $1E ; Quadrant 0, Row 0F, Strip 1
    db $1F, $14, $14, $1E, $1F, $1E, $1F, $1E ; Quadrant 0, Row 0F, Strip 2
    db $1A, $1B, $3B, $3C, $3B, $28, $28, $28 ; Quadrant 0, Row 0F, Strip 3
    db $28, $28, $28, $28, $08, $29, $08, $29 ; Quadrant 0, Row 10, Strip 0
    db $28, $28, $28, $28, $28, $2B, $2E, $0B ; Quadrant 0, Row 10, Strip 1
    db $26, $27, $14, $14, $14, $A5, $14, $26 ; Quadrant 0, Row 10, Strip 2
    db $24, $25, $56, $35, $5B, $73, $74, $28 ; Quadrant 0, Row 10, Strip 3
    db $28, $28, $28, $08, $28, $2C, $28, $2B ; Quadrant 0, Row 11, Strip 0
    db $09, $08, $29, $28, $28, $2C, $2E, $1B ; Quadrant 0, Row 11, Strip 1
    db $36, $37, $14, $14, $14, $14, $14, $15 ; Quadrant 0, Row 11, Strip 2
    db $34, $A7, $64, $5B, $90, $73, $73, $52 ; Quadrant 0, Row 11, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $2C ; Quadrant 0, Row 12, Strip 0
    db $2E, $2D, $2C, $09, $28, $2F, $1B, $1F ; Quadrant 0, Row 12, Strip 1
    db $14, $14, $14, $14, $14, $14, $14, $15 ; Quadrant 0, Row 12, Strip 2
    db $A7, $34, $E4, $90, $82, $83, $83, $83 ; Quadrant 0, Row 12, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 13, Strip 0
    db $2C, $2E, $2D, $2A, $29, $2C, $19, $14 ; Quadrant 0, Row 13, Strip 1
    db $A5, $14, $14, $14, $A5, $14, $14, $15 ; Quadrant 0, Row 13, Strip 2
    db $A7, $B6, $DF, $82, $B2, $93, $D6, $D6 ; Quadrant 0, Row 13, Strip 3
    db $09, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 14, Strip 0
    db $28, $2C, $2A, $28, $2C, $09, $1B, $14 ; Quadrant 0, Row 14, Strip 1
    db $14, $A5, $14, $14, $14, $14, $14, $15 ; Quadrant 0, Row 14, Strip 2
    db $34, $A7, $82, $B2, $D6, $93, $93, $93 ; Quadrant 0, Row 14, Strip 3
    db $2B, $09, $08, $29, $28, $28, $28, $28 ; Quadrant 0, Row 15, Strip 0
    db $28, $28, $28, $28, $28, $2B, $19, $14 ; Quadrant 0, Row 15, Strip 1
    db $14, $14, $14, $14, $A5, $14, $A5, $36 ; Quadrant 0, Row 15, Strip 2
    db $05, $34, $B0, $D6, $D6, $82, $83, $83 ; Quadrant 0, Row 15, Strip 3
    db $2C, $2A, $28, $2B, $2D, $28, $28, $28 ; Quadrant 0, Row 16, Strip 0
    db $28, $28, $28, $28, $28, $2C, $2B, $0B ; Quadrant 0, Row 16, Strip 1
    db $A5, $14, $14, $A5, $14, $A5, $14, $14 ; Quadrant 0, Row 16, Strip 2
    db $15, $33, $33, $33, $90, $B2, $D6, $93 ; Quadrant 0, Row 16, Strip 3
    db $28, $28, $28, $2C, $2E, $2D, $08, $28 ; Quadrant 0, Row 17, Strip 0
    db $28, $28, $28, $28, $28, $28, $2F, $1B ; Quadrant 0, Row 17, Strip 1
    db $14, $14, $A5, $A5, $14, $14, $14, $A5 ; Quadrant 0, Row 17, Strip 2
    db $15, $A6, $FB, $34, $82, $83, $83, $83 ; Quadrant 0, Row 17, Strip 3
    db $28, $28, $28, $28, $2C, $2A, $28, $28 ; Quadrant 0, Row 18, Strip 0
    db $28, $28, $08, $29, $08, $29, $1B, $1F ; Quadrant 0, Row 18, Strip 1
    db $26, $27, $26, $27, $26, $24, $24, $D5 ; Quadrant 0, Row 18, Strip 2
    db $25, $34, $34, $34, $B0, $93, $71, $93 ; Quadrant 0, Row 18, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 19, Strip 0
    db $28, $2F, $28, $2C, $28, $2C, $19, $14 ; Quadrant 0, Row 19, Strip 1
    db $15, $13, $15, $13, $15, $33, $40, $41 ; Quadrant 0, Row 19, Strip 2
    db $33, $BF, $34, $34, $30, $23, $81, $23 ; Quadrant 0, Row 19, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 0, Row 1A, Strip 0
    db $2F, $1B, $1A, $28, $28, $2F, $1B, $14 ; Quadrant 0, Row 1A, Strip 1
    db $15, $13, $15, $13, $15, $BC, $BD, $A6 ; Quadrant 0, Row 1A, Strip 2
    db $A7, $34, $41, $33, $40, $34, $C0, $34 ; Quadrant 0, Row 1A, Strip 3
    db $29, $28, $28, $28, $28, $08, $2D, $28 ; Quadrant 0, Row 1B, Strip 0
    db $28, $19, $0A, $28, $2F, $1B, $1F, $14 ; Quadrant 0, Row 1B, Strip 1
    db $15, $13, $15, $13, $36, $05, $D0, $D0 ; Quadrant 0, Row 1B, Strip 2
    db $D0, $D0, $D0, $D0, $D0, $D0, $C3, $D0 ; Quadrant 0, Row 1B, Strip 3
    db $2C, $09, $28, $28, $08, $28, $2B, $2D ; Quadrant 0, Row 1C, Strip 0
    db $28, $2C, $28, $2F, $1B, $1F, $14, $14 ; Quadrant 0, Row 1C, Strip 1
    db $15, $23, $25, $23, $24, $25, $C0, $A6 ; Quadrant 0, Row 1C, Strip 2
    db $FB, $A7, $A6, $00, $6A, $3D, $6E, $8B ; Quadrant 0, Row 1C, Strip 3
    db $28, $2C, $09, $08, $28, $28, $2C, $2E ; Quadrant 0, Row 1D, Strip 0
    db $2D, $08, $29, $1B, $1F, $A5, $14, $26 ; Quadrant 0, Row 1D, Strip 1
    db $25, $31, $B6, $E4, $FD, $FE, $C0, $10 ; Quadrant 0, Row 1D, Strip 2
    db $12, $A6, $FB, $10, $12, $4D, $7E, $9B ; Quadrant 0, Row 1D, Strip 3
    db $28, $28, $2A, $29, $28, $28, $28, $2C ; Quadrant 0, Row 1E, Strip 0
    db $2A, $28, $2C, $19, $14, $14, $A5, $15 ; Quadrant 0, Row 1E, Strip 1
    db $34, $41, $33, $33, $33, $33, $C0, $10 ; Quadrant 0, Row 1E, Strip 2
    db $12, $A7, $FB, $20, $22, $CD, $A7, $3E ; Quadrant 0, Row 1E, Strip 3
    db $28, $28, $28, $2C, $2D, $28, $28, $28 ; Quadrant 0, Row 1F, Strip 0
    db $28, $28, $28, $2B, $0B, $A5, $14, $15 ; Quadrant 0, Row 1F, Strip 1
    db $34, $F6, $89, $6B, $6C, $89, $F6, $10 ; Quadrant 0, Row 1F, Strip 2
    db $12, $FB, $FB, $00, $02, $CD, $34, $3E ; Quadrant 0, Row 1F, Strip 3

    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 00, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 00, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 00, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 00, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 01, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 01, Strip 1
    db $28, $28, $28, $28, $08, $29, $28, $28 ; Quadrant 1, Row 01, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 01, Strip 3
    db $28, $28, $08, $28, $08, $29, $28, $28 ; Quadrant 1, Row 02, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 02, Strip 1
    db $28, $28, $28, $08, $28, $2C, $09, $28 ; Quadrant 1, Row 02, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 02, Strip 3
    db $09, $08, $28, $08, $28, $2C, $09, $28 ; Quadrant 1, Row 03, Strip 0
    db $28, $28, $28, $28, $28, $29, $08, $29 ; Quadrant 1, Row 03, Strip 1
    db $08, $29, $08, $28, $28, $28, $2B, $09 ; Quadrant 1, Row 03, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 03, Strip 3
    db $2C, $2D, $28, $28, $28, $28, $2B, $09 ; Quadrant 1, Row 04, Strip 0
    db $28, $28, $08, $28, $28, $2C, $2D, $2C ; Quadrant 1, Row 04, Strip 1
    db $2D, $2C, $2D, $28, $28, $28, $2C, $2E ; Quadrant 1, Row 04, Strip 2
    db $09, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 04, Strip 3
    db $28, $2C, $28, $28, $28, $28, $2C, $2E ; Quadrant 1, Row 05, Strip 0
    db $09, $08, $28, $28, $28, $28, $2C, $28 ; Quadrant 1, Row 05, Strip 1
    db $2C, $28, $2C, $28, $28, $28, $28, $2B ; Quadrant 1, Row 05, Strip 2
    db $2A, $29, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 05, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $2B ; Quadrant 1, Row 06, Strip 0
    db $2A, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 06, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 1, Row 06, Strip 2
    db $09, $2C, $09, $28, $28, $28, $28, $28 ; Quadrant 1, Row 06, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 1, Row 07, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 07, Strip 1
    db $28, $28, $28, $28, $28, $28, $08, $28 ; Quadrant 1, Row 07, Strip 2
    db $2C, $28, $2B, $09, $28, $28, $28, $28 ; Quadrant 1, Row 07, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 08, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 08, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 08, Strip 2
    db $28, $28, $2C, $2E, $2D, $28, $28, $28 ; Quadrant 1, Row 08, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 09, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 09, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 09, Strip 2
    db $28, $28, $28, $2B, $2A, $2D, $28, $28 ; Quadrant 1, Row 09, Strip 3
    db $28, $28, $28, $28, $28, $28, $2F, $28 ; Quadrant 1, Row 0A, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0A, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0A, Strip 2
    db $28, $28, $28, $2A, $28, $2C, $28, $28 ; Quadrant 1, Row 0A, Strip 3
    db $1A, $28, $08, $29, $08, $29, $1B, $1A ; Quadrant 1, Row 0B, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0B, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0B, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0B, Strip 3
    db $0A, $08, $2D, $2C, $2D, $1B, $1F, $0A ; Quadrant 1, Row 0C, Strip 0
    db $28, $28, $28, $2F, $28, $28, $28, $28 ; Quadrant 1, Row 0C, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0C, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0C, Strip 3
    db $2D, $28, $2C, $28, $2C, $19, $0A, $28 ; Quadrant 1, Row 0D, Strip 0
    db $28, $28, $2F, $1B, $1A, $28, $28, $28 ; Quadrant 1, Row 0D, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0D, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0D, Strip 3
    db $2E, $28, $08, $29, $28, $2C, $2D, $28 ; Quadrant 1, Row 0E, Strip 0
    db $28, $28, $2C, $19, $0A, $28, $28, $28 ; Quadrant 1, Row 0E, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 1, Row 0E, Strip 2
    db $29, $08, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0E, Strip 3
    db $2C, $98, $42, $2C, $09, $28, $2C, $28 ; Quadrant 1, Row 0F, Strip 0
    db $28, $08, $29, $2C, $28, $28, $28, $28 ; Quadrant 1, Row 0F, Strip 1
    db $28, $28, $28, $28, $28, $28, $08, $28 ; Quadrant 1, Row 0F, Strip 2
    db $2C, $2D, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 0F, Strip 3
    db $72, $99, $63, $73, $73, $74, $2C, $72 ; Quadrant 1, Row 10, Strip 0
    db $73, $73, $73, $A1, $A0, $73, $73, $74 ; Quadrant 1, Row 10, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 10, Strip 2
    db $28, $2C, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 10, Strip 3
    db $52, $9A, $70, $A0, $73, $91, $09, $90 ; Quadrant 1, Row 11, Strip 0
    db $73, $73, $A1, $84, $90, $73, $73, $91 ; Quadrant 1, Row 11, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 11, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 11, Strip 3
    db $83, $83, $84, $82, $83, $52, $52, $83 ; Quadrant 1, Row 12, Strip 0
    db $83, $83, $84, $B3, $90, $A1, $83, $84 ; Quadrant 1, Row 12, Strip 1
    db $3B, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 12, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 12, Strip 3
    db $93, $93, $94, $92, $93, $94, $72, $93 ; Quadrant 1, Row 13, Strip 0
    db $93, $93, $B3, $A1, $82, $84, $93, $A2 ; Quadrant 1, Row 13, Strip 1
    db $4A, $3B, $08, $28, $28, $28, $28, $28 ; Quadrant 1, Row 13, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 13, Strip 3
    db $D6, $93, $94, $92, $93, $94, $82, $93 ; Quadrant 1, Row 14, Strip 0
    db $82, $83, $83, $84, $B4, $94, $06, $54 ; Quadrant 1, Row 14, Strip 1
    db $35, $4C, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 14, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 14, Strip 3
    db $83, $84, $B3, $B2, $93, $94, $B4, $90 ; Quadrant 1, Row 15, Strip 0
    db $B2, $93, $93, $B3, $CA, $B7, $95, $54 ; Quadrant 1, Row 15, Strip 1
    db $48, $3B, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 15, Strip 2
    db $28, $28, $28, $28, $08, $29, $28, $28 ; Quadrant 1, Row 15, Strip 3
    db $93, $B3, $73, $A1, $83, $52, $62, $90 ; Quadrant 1, Row 16, Strip 0
    db $73, $73, $73, $91, $9F, $06, $22, $54 ; Quadrant 1, Row 16, Strip 1
    db $5C, $4A, $3B, $28, $28, $28, $28, $28 ; Quadrant 1, Row 16, Strip 2
    db $28, $28, $28, $08, $28, $2C, $09, $08 ; Quadrant 1, Row 16, Strip 3
    db $83, $83, $83, $84, $93, $94, $CA, $82 ; Quadrant 1, Row 17, Strip 0
    db $83, $83, $83, $84, $A9, $16, $02, $54 ; Quadrant 1, Row 17, Strip 1
    db $58, $56, $4A, $3B, $08, $28, $28, $28 ; Quadrant 1, Row 17, Strip 2
    db $28, $28, $08, $28, $28, $28, $2B, $2D ; Quadrant 1, Row 17, Strip 3
    db $93, $93, $93, $A4, $93, $A4, $CA, $B4 ; Quadrant 1, Row 18, Strip 0
    db $93, $93, $93, $B7, $11, $11, $12, $54 ; Quadrant 1, Row 18, Strip 1
    db $35, $58, $56, $4C, $29, $28, $28, $28 ; Quadrant 1, Row 18, Strip 2
    db $28, $28, $28, $28, $28, $28, $2C, $2E ; Quadrant 1, Row 18, Strip 3
    db $24, $24, $24, $25, $00, $85, $06, $21 ; Quadrant 1, Row 19, Strip 0
    db $21, $21, $21, $21, $21, $21, $22, $54 ; Quadrant 1, Row 19, Strip 1
    db $39, $3A, $39, $28, $2C, $2D, $28, $28 ; Quadrant 1, Row 19, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $2C ; Quadrant 1, Row 19, Strip 3
    db $B6, $80, $80, $B6, $20, $07, $95, $A6 ; Quadrant 1, Row 1A, Strip 0
    db $A6, $F6, $A7, $44, $45, $41, $31, $54 ; Quadrant 1, Row 1A, Strip 1
    db $3B, $28, $28, $28, $28, $2C, $28, $28 ; Quadrant 1, Row 1A, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1A, Strip 3
    db $D0, $D0, $D0, $D0, $D0, $10, $06, $77 ; Quadrant 1, Row 1B, Strip 0
    db $7B, $7B, $7B, $43, $7A, $7B, $8D, $8E ; Quadrant 1, Row 1B, Strip 1
    db $4A, $3B, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1B, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 1, Row 1B, Strip 3
    db $8C, $6E, $3F, $8A, $02, $10, $12, $54 ; Quadrant 1, Row 1C, Strip 0
    db $57, $9D, $9D, $9D, $9D, $9D, $C8, $C9 ; Quadrant 1, Row 1C, Strip 1
    db $35, $4C, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1C, Strip 2
    db $28, $28, $28, $28, $28, $28, $08, $28 ; Quadrant 1, Row 1C, Strip 3
    db $9C, $7E, $4F, $10, $12, $10, $12, $54 ; Quadrant 1, Row 1D, Strip 0
    db $C7, $57, $56, $48, $35, $89, $89, $5C ; Quadrant 1, Row 1D, Strip 1
    db $35, $3B, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1D, Strip 2
    db $28, $28, $28, $28, $28, $08, $28, $28 ; Quadrant 1, Row 1D, Strip 3
    db $5E, $A7, $CE, $10, $12, $52, $52, $54 ; Quadrant 1, Row 1E, Strip 0
    db $C7, $EE, $EF, $58, $9D, $9D, $9D, $5C ; Quadrant 1, Row 1E, Strip 1
    db $48, $4A, $3B, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1E, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1E, Strip 3
    db $5E, $34, $CE, $10, $F3, $F4, $22, $54 ; Quadrant 1, Row 1F, Strip 0
    db $C7, $89, $49, $56, $57, $9D, $56, $5C ; Quadrant 1, Row 1F, Strip 1
    db $5C, $35, $4C, $28, $29, $28, $28, $28 ; Quadrant 1, Row 1F, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 1, Row 1F, Strip 3

    db $28, $28, $28, $28, $2B, $2D, $28, $28 ; Quadrant 2, Row 00, Strip 0
    db $28, $28, $28, $2C, $2A, $0B, $14, $15 ; Quadrant 2, Row 00, Strip 1
    db $34, $B6, $34, $3E, $5E, $88, $88, $10 ; Quadrant 2, Row 00, Strip 2
    db $12, $FB, $A6, $10, $12, $CD, $34, $3E ; Quadrant 2, Row 00, Strip 3
    db $28, $28, $28, $28, $2C, $2E, $2D, $08 ; Quadrant 2, Row 01, Strip 0
    db $09, $28, $28, $28, $2F, $2A, $0B, $15 ; Quadrant 2, Row 01, Strip 1
    db $88, $88, $BC, $BD, $BC, $BD, $F6, $10 ; Quadrant 2, Row 01, Strip 2
    db $12, $BC, $BD, $10, $12, $5D, $4E, $7D ; Quadrant 2, Row 01, Strip 3
    db $28, $28, $28, $28, $28, $2C, $2A, $28 ; Quadrant 2, Row 02, Strip 0
    db $2B, $09, $28, $28, $28, $2F, $1B, $25 ; Quadrant 2, Row 02, Strip 1
    db $34, $A7, $34, $34, $34, $34, $A7, $20 ; Quadrant 2, Row 02, Strip 2
    db $22, $33, $33, $10, $16, $01, $01, $50 ; Quadrant 2, Row 02, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 03, Strip 0
    db $2C, $2A, $28, $28, $2F, $3C, $4B, $66 ; Quadrant 2, Row 03, Strip 1
    db $CF, $04, $04, $CB, $04, $BB, $C0, $03 ; Quadrant 2, Row 03, Strip 2
    db $04, $04, $04, $DB, $E6, $21, $21, $60 ; Quadrant 2, Row 03, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 04, Strip 0
    db $28, $28, $08, $09, $08, $5A, $35, $35 ; Quadrant 2, Row 04, Strip 1
    db $69, $24, $24, $27, $26, $25, $C0, $13 ; Quadrant 2, Row 04, Strip 2
    db $26, $24, $24, $27, $15, $A7, $FB, $FB ; Quadrant 2, Row 04, Strip 3
    db $09, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 05, Strip 0
    db $28, $28, $28, $2C, $2D, $2B, $3A, $35 ; Quadrant 2, Row 05, Strip 1
    db $55, $34, $34, $13, $15, $E4, $33, $13 ; Quadrant 2, Row 05, Strip 2
    db $15, $FB, $A7, $13, $15, $A7, $FB, $FB ; Quadrant 2, Row 05, Strip 3
    db $2B, $09, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 06, Strip 0
    db $28, $28, $28, $28, $2C, $2F, $3C, $35 ; Quadrant 2, Row 06, Strip 1
    db $55, $33, $31, $23, $25, $33, $F6, $13 ; Quadrant 2, Row 06, Strip 2
    db $15, $A7, $FB, $13, $15, $A7, $A6, $34 ; Quadrant 2, Row 06, Strip 3
    db $2C, $2E, $09, $08, $29, $28, $28, $28 ; Quadrant 2, Row 07, Strip 0
    db $28, $2C, $09, $28, $2F, $3C, $4B, $35 ; Quadrant 2, Row 07, Strip 1
    db $7A, $7B, $7B, $A3, $D2, $7B, $7C, $23 ; Quadrant 2, Row 07, Strip 2
    db $36, $05, $03, $37, $15, $A7, $41, $33 ; Quadrant 2, Row 07, Strip 3
    db $28, $2C, $2A, $28, $2C, $09, $28, $28 ; Quadrant 2, Row 08, Strip 0
    db $28, $28, $2C, $09, $3C, $4B, $35, $57 ; Quadrant 2, Row 08, Strip 1
    db $9D, $9D, $C5, $9D, $9D, $56, $55, $A6 ; Quadrant 2, Row 08, Strip 2
    db $23, $25, $23, $24, $25, $34, $44, $66 ; Quadrant 2, Row 08, Strip 3
    db $28, $28, $28, $28, $28, $2B, $2D, $28 ; Quadrant 2, Row 09, Strip 0
    db $28, $28, $28, $2C, $5A, $35, $35, $C7 ; Quadrant 2, Row 09, Strip 1
    db $35, $DE, $CC, $DE, $57, $5C, $47, $66 ; Quadrant 2, Row 09, Strip 2
    db $45, $D0, $D0, $D0, $C3, $34, $AF, $67 ; Quadrant 2, Row 09, Strip 3
    db $28, $28, $28, $28, $28, $2B, $2A, $28 ; Quadrant 2, Row 0A, Strip 0
    db $28, $28, $28, $28, $2C, $3A, $35, $C7 ; Quadrant 2, Row 0A, Strip 1
    db $57, $9D, $78, $9D, $59, $58, $56, $35 ; Quadrant 2, Row 0A, Strip 2
    db $7A, $7B, $7C, $A7, $34, $B1, $AD, $B6 ; Quadrant 2, Row 0A, Strip 3
    db $28, $28, $28, $28, $2F, $2A, $28, $28 ; Quadrant 2, Row 0B, Strip 0
    db $28, $28, $28, $28, $28, $2C, $3A, $C7 ; Quadrant 2, Row 0B, Strip 1
    db $C7, $86, $DC, $57, $59, $86, $58, $56 ; Quadrant 2, Row 0B, Strip 2
    db $35, $35, $7A, $7B, $7B, $D3, $AC, $BF ; Quadrant 2, Row 0B, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 0C, Strip 0
    db $28, $28, $08, $09, $08, $29, $3C, $C7 ; Quadrant 2, Row 0C, Strip 1
    db $C7, $86, $58, $59, $86, $86, $86, $5C ; Quadrant 2, Row 0C, Strip 2
    db $57, $56, $57, $56, $57, $65, $B6, $B6 ; Quadrant 2, Row 0C, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 0D, Strip 0
    db $28, $28, $28, $2C, $2D, $3C, $4B, $C7 ; Quadrant 2, Row 0D, Strip 1
    db $59, $86, $86, $86, $86, $86, $86, $5C ; Quadrant 2, Row 0D, Strip 2
    db $C7, $64, $65, $54, $55, $B6, $B6, $B6 ; Quadrant 2, Row 0D, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 0E, Strip 0
    db $28, $28, $28, $28, $2C, $5A, $35, $C7 ; Quadrant 2, Row 0E, Strip 1
    db $86, $86, $86, $86, $86, $86, $86, $58 ; Quadrant 2, Row 0E, Strip 2
    db $C2, $7F, $6F, $C1, $65, $B6, $79, $F5 ; Quadrant 2, Row 0E, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 0F, Strip 0
    db $28, $28, $28, $08, $29, $2C, $3A, $C7 ; Quadrant 2, Row 0F, Strip 1
    db $66, $49, $86, $86, $86, $86, $86, $86 ; Quadrant 2, Row 0F, Strip 2
    db $5C, $47, $46, $55, $B6, $B6, $B6, $B6 ; Quadrant 2, Row 0F, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 10, Strip 0
    db $08, $29, $08, $28, $2C, $09, $3C, $47 ; Quadrant 2, Row 10, Strip 1
    db $66, $66, $66, $66, $66, $66, $66, $66 ; Quadrant 2, Row 10, Strip 2
    db $46, $35, $35, $47, $66, $66, $66, $66 ; Quadrant 2, Row 10, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 11, Strip 0
    db $28, $2C, $09, $28, $28, $2B, $5A, $39 ; Quadrant 2, Row 11, Strip 1
    db $3A, $39, $3A, $35, $35, $39, $3A, $48 ; Quadrant 2, Row 11, Strip 2
    db $66, $66, $49, $39, $3A, $35, $35, $39 ; Quadrant 2, Row 11, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 12, Strip 0
    db $28, $28, $2C, $28, $28, $2C, $2C, $2D ; Quadrant 2, Row 12, Strip 1
    db $2C, $28, $2C, $3A, $39, $2F, $3C, $5C ; Quadrant 2, Row 12, Strip 2
    db $39, $3A, $39, $28, $2C, $3A, $39, $28 ; Quadrant 2, Row 12, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 13, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $2C ; Quadrant 2, Row 13, Strip 1
    db $28, $28, $28, $2C, $28, $2C, $5A, $46 ; Quadrant 2, Row 13, Strip 2
    db $3B, $2C, $2D, $28, $28, $2C, $2D, $28 ; Quadrant 2, Row 13, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 2, Row 14, Strip 0
    db $29, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 14, Strip 1
    db $28, $28, $28, $28, $28, $28, $3C, $35 ; Quadrant 2, Row 14, Strip 2
    db $4A, $3B, $2C, $2D, $28, $28, $2C, $28 ; Quadrant 2, Row 14, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 15, Strip 0
    db $2C, $09, $08, $29, $28, $28, $28, $28 ; Quadrant 2, Row 15, Strip 1
    db $28, $28, $28, $28, $28, $08, $5A, $35 ; Quadrant 2, Row 15, Strip 2
    db $35, $4A, $3B, $3C, $3B, $08, $29, $28 ; Quadrant 2, Row 15, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 16, Strip 0
    db $28, $2C, $2D, $2C, $09, $28, $28, $28 ; Quadrant 2, Row 16, Strip 1
    db $28, $28, $28, $28, $08, $28, $2C, $3A ; Quadrant 2, Row 16, Strip 2
    db $39, $3A, $4A, $4B, $4C, $28, $2C, $09 ; Quadrant 2, Row 16, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 17, Strip 0
    db $28, $28, $2C, $28, $2B, $09, $08, $29 ; Quadrant 2, Row 17, Strip 1
    db $28, $28, $28, $08, $28, $28, $28, $2A ; Quadrant 2, Row 17, Strip 2
    db $28, $2C, $3A, $39, $28, $28, $28, $08 ; Quadrant 2, Row 17, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 18, Strip 0
    db $28, $28, $28, $28, $2B, $2A, $28, $2C ; Quadrant 2, Row 18, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 18, Strip 2
    db $28, $28, $2B, $2D, $28, $28, $28, $28 ; Quadrant 2, Row 18, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 19, Strip 0
    db $28, $28, $28, $28, $2A, $28, $28, $28 ; Quadrant 2, Row 19, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 19, Strip 2
    db $28, $28, $2C, $2E, $2D, $28, $28, $28 ; Quadrant 2, Row 19, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1A, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1A, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1A, Strip 2
    db $28, $28, $28, $2C, $2E, $28, $28, $28 ; Quadrant 2, Row 1A, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1B, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1B, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1B, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1B, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1C, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1C, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1C, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1C, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1D, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1D, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1D, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1D, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1E, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1E, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1E, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1E, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1F, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1F, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1F, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 2, Row 1F, Strip 3

    db $5E, $34, $CE, $10, $12, $FC, $FC, $5C ; Quadrant 3, Row 00, Strip 0
    db $C7, $9D, $59, $58, $59, $89, $58, $5C ; Quadrant 3, Row 00, Strip 1
    db $58, $39, $28, $28, $2C, $2D, $28, $28 ; Quadrant 3, Row 00, Strip 2
    db $08, $29, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 00, Strip 3
    db $6D, $4E, $5F, $20, $22, $FC, $FC, $5C ; Quadrant 3, Row 01, Strip 0
    db $C7, $67, $56, $89, $57, $67, $67, $5C ; Quadrant 3, Row 01, Strip 1
    db $39, $28, $28, $28, $28, $2B, $2D, $08 ; Quadrant 3, Row 01, Strip 2
    db $28, $2C, $2D, $28, $28, $28, $28, $28 ; Quadrant 3, Row 01, Strip 3
    db $51, $01, $01, $01, $02, $FC, $FC, $5C ; Quadrant 3, Row 02, Strip 0
    db $55, $9E, $64, $67, $65, $FB, $A7, $54 ; Quadrant 3, Row 02, Strip 1
    db $3B, $28, $28, $08, $28, $28, $2C, $28 ; Quadrant 3, Row 02, Strip 2
    db $28, $28, $2C, $28, $28, $28, $28, $28 ; Quadrant 3, Row 02, Strip 3
    db $61, $21, $21, $07, $12, $FC, $FC, $5C ; Quadrant 3, Row 03, Strip 0
    db $55, $77, $7B, $7B, $7B, $7B, $7C, $54 ; Quadrant 3, Row 03, Strip 1
    db $4A, $3B, $08, $28, $28, $28, $28, $28 ; Quadrant 3, Row 03, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 03, Strip 3
    db $FB, $A7, $C0, $10, $12, $FC, $FC, $5C ; Quadrant 3, Row 04, Strip 0
    db $55, $64, $67, $56, $57, $67, $65, $54 ; Quadrant 3, Row 04, Strip 1
    db $48, $4C, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 04, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 04, Strip 3
    db $FB, $B6, $C0, $10, $12, $34, $34, $64 ; Quadrant 3, Row 05, Strip 0
    db $65, $A6, $A6, $54, $55, $31, $44, $46 ; Quadrant 3, Row 05, Strip 1
    db $58, $3B, $28, $2F, $28, $28, $28, $28 ; Quadrant 3, Row 05, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 05, Strip 3
    db $B6, $F6, $C0, $10, $16, $50, $51, $01 ; Quadrant 3, Row 06, Strip 0
    db $01, $01, $01, $68, $55, $41, $64, $56 ; Quadrant 3, Row 06, Strip 1
    db $48, $4A, $3B, $3C, $3B, $28, $28, $28 ; Quadrant 3, Row 06, Strip 2
    db $2F, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 06, Strip 3
    db $33, $33, $C3, $20, $21, $60, $61, $AB ; Quadrant 3, Row 07, Strip 0
    db $97, $97, $BE, $68, $7A, $7B, $7B, $43 ; Quadrant 3, Row 07, Strip 1
    db $5C, $35, $4A, $4B, $4A, $3B, $08, $29 ; Quadrant 3, Row 07, Strip 2
    db $3C, $3B, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 07, Strip 3
    db $66, $45, $44, $66, $45, $34, $34, $64 ; Quadrant 3, Row 08, Strip 0
    db $AE, $AE, $A9, $68, $57, $C6, $67, $56 ; Quadrant 3, Row 08, Strip 1
    db $58, $56, $35, $35, $35, $4C, $2F, $3C ; Quadrant 3, Row 08, Strip 2
    db $4B, $4C, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 08, Strip 3
    db $67, $65, $64, $56, $75, $76, $96, $01 ; Quadrant 3, Row 09, Strip 0
    db $17, $11, $11, $B8, $53, $01, $02, $54 ; Quadrant 3, Row 09, Strip 1
    db $35, $58, $39, $3A, $39, $28, $28, $5A ; Quadrant 3, Row 09, Strip 2
    db $39, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 09, Strip 3
    db $B6, $B6, $B6, $54, $55, $10, $06, $07 ; Quadrant 3, Row 0A, Strip 0
    db $87, $97, $BE, $8F, $9F, $06, $12, $54 ; Quadrant 3, Row 0A, Strip 1
    db $35, $39, $28, $2C, $2D, $28, $28, $2C ; Quadrant 3, Row 0A, Strip 2
    db $2D, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 3, Row 0A, Strip 3
    db $BF, $B6, $B6, $54, $55, $10, $16, $17 ; Quadrant 3, Row 0B, Strip 0
    db $B9, $C6, $BA, $8F, $9F, $12, $12, $54 ; Quadrant 3, Row 0B, Strip 1
    db $35, $3B, $08, $28, $2C, $28, $28, $28 ; Quadrant 3, Row 0B, Strip 2
    db $2C, $28, $28, $28, $28, $28, $08, $28 ; Quadrant 3, Row 0B, Strip 3
    db $B6, $B6, $B6, $54, $47, $AA, $11, $11 ; Quadrant 3, Row 0C, Strip 0
    db $16, $96, $17, $8F, $9F, $12, $22, $54 ; Quadrant 3, Row 0C, Strip 1
    db $35, $4C, $2D, $28, $28, $28, $28, $28 ; Quadrant 3, Row 0C, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 0C, Strip 3
    db $B6, $30, $33, $54, $57, $F2, $11, $11 ; Quadrant 3, Row 0D, Strip 0
    db $11, $11, $11, $A8, $A9, $95, $02, $54 ; Quadrant 3, Row 0D, Strip 1
    db $39, $28, $2C, $2D, $28, $28, $08, $29 ; Quadrant 3, Row 0D, Strip 2
    db $08, $29, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 0D, Strip 3
    db $B6, $32, $34, $64, $65, $10, $11, $11 ; Quadrant 3, Row 0E, Strip 0
    db $06, $21, $07, $11, $11, $06, $22, $54 ; Quadrant 3, Row 0E, Strip 1
    db $3B, $28, $28, $2C, $28, $28, $28, $2C ; Quadrant 3, Row 0E, Strip 2
    db $28, $2C, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 0E, Strip 3
    db $30, $40, $34, $B6, $34, $20, $21, $21 ; Quadrant 3, Row 0F, Strip 0
    db $22, $34, $B6, $34, $34, $34, $B6, $54 ; Quadrant 3, Row 0F, Strip 1
    db $39, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 0F, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 0F, Strip 3
    db $66, $66, $66, $66, $66, $66, $66, $66 ; Quadrant 3, Row 10, Strip 0
    db $66, $66, $66, $66, $66, $66, $66, $46 ; Quadrant 3, Row 10, Strip 1
    db $3B, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 10, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 10, Strip 3
    db $3A, $48, $66, $66, $66, $49, $48, $49 ; Quadrant 3, Row 11, Strip 0
    db $39, $3A, $35, $35, $39, $3A, $35, $35 ; Quadrant 3, Row 11, Strip 1
    db $39, $2D, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 11, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 11, Strip 3
    db $2C, $3A, $39, $3A, $35, $47, $46, $39 ; Quadrant 3, Row 12, Strip 0
    db $28, $2C, $3A, $39, $28, $2C, $3A, $39 ; Quadrant 3, Row 12, Strip 1
    db $28, $2C, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 12, Strip 2
    db $28, $28, $28, $28, $28, $08, $29, $08 ; Quadrant 3, Row 12, Strip 3
    db $28, $2C, $2D, $2C, $3A, $35, $39, $28 ; Quadrant 3, Row 13, Strip 0
    db $28, $28, $2C, $08, $29, $28, $2C, $28 ; Quadrant 3, Row 13, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 13, Strip 2
    db $28, $28, $28, $28, $08, $28, $2C, $2D ; Quadrant 3, Row 13, Strip 3
    db $28, $28, $2C, $28, $2C, $39, $28, $28 ; Quadrant 3, Row 14, Strip 0
    db $28, $28, $28, $28, $2B, $09, $08, $29 ; Quadrant 3, Row 14, Strip 1
    db $28, $28, $28, $28, $08, $29, $28, $28 ; Quadrant 3, Row 14, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $2C ; Quadrant 3, Row 14, Strip 3
    db $28, $28, $28, $28, $08, $29, $28, $28 ; Quadrant 3, Row 15, Strip 0
    db $28, $28, $28, $28, $2C, $2A, $28, $2C ; Quadrant 3, Row 15, Strip 1
    db $09, $28, $28, $08, $28, $2C, $09, $28 ; Quadrant 3, Row 15, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 15, Strip 3
    db $28, $28, $28, $08, $28, $2C, $2D, $28 ; Quadrant 3, Row 16, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 16, Strip 1
    db $08, $29, $08, $28, $28, $28, $2B, $09 ; Quadrant 3, Row 16, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 16, Strip 3
    db $29, $28, $08, $28, $28, $28, $2C, $28 ; Quadrant 3, Row 17, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 17, Strip 1
    db $28, $2C, $2D, $28, $28, $28, $2C, $2E ; Quadrant 3, Row 17, Strip 2
    db $09, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 17, Strip 3
    db $2C, $2D, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 18, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 18, Strip 1
    db $28, $28, $2C, $28, $28, $28, $28, $2B ; Quadrant 3, Row 18, Strip 2
    db $2A, $29, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 18, Strip 3
    db $28, $2C, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 19, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 19, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $08 ; Quadrant 3, Row 19, Strip 2
    db $09, $2C, $09, $28, $28, $28, $28, $28 ; Quadrant 3, Row 19, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1A, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1A, Strip 1
    db $28, $28, $28, $28, $28, $28, $08, $28 ; Quadrant 3, Row 1A, Strip 2
    db $28, $28, $2B, $09, $28, $28, $28, $28 ; Quadrant 3, Row 1A, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1B, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1B, Strip 1
    db $28, $28, $28, $28, $28, $08, $28, $28 ; Quadrant 3, Row 1B, Strip 2
    db $28, $28, $2C, $2E, $2D, $28, $28, $28 ; Quadrant 3, Row 1B, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1C, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1C, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1C, Strip 2
    db $28, $28, $28, $2B, $2A, $28, $28, $28 ; Quadrant 3, Row 1C, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1D, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1D, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1D, Strip 2
    db $28, $28, $28, $2A, $28, $28, $28, $28 ; Quadrant 3, Row 1D, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1E, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1E, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1E, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1E, Strip 3
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1F, Strip 0
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1F, Strip 1
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1F, Strip 2
    db $28, $28, $28, $28, $28, $28, $28, $28 ; Quadrant 3, Row 1F, Strip 3
}

; ==============================================================================

; $055727-$055B26 DATA
WorldMap_DarkWorldTilemap:
{
    db $26, $27, $14, $14, $14, $A5, $14, $26 ; Row 00, Strip 0
    db $24, $25, $56, $35, $5B, $73, $74, $28 ; Row 00, Strip 1
    db $72, $99, $63, $73, $73, $74, $2C, $72 ; Row 00, Strip 2
    db $73, $73, $73, $A1, $A0, $73, $73, $74 ; Row 00, Strip 3
    db $36, $37, $14, $14, $14, $14, $14, $15 ; Row 01, Strip 0
    db $34, $A7, $64, $5B, $90, $73, $73, $73 ; Row 01, Strip 1
    db $73, $9A, $70, $A0, $73, $91, $09, $90 ; Row 01, Strip 2
    db $73, $73, $A1, $84, $90, $73, $FF, $91 ; Row 01, Strip 3
    db $14, $14, $14, $14, $14, $14, $14, $15 ; Row 02, Strip 0
    db $A7, $34, $E4, $90, $82, $83, $83, $83 ; Row 02, Strip 1
    db $83, $83, $84, $82, $83, $83, $83, $83 ; Row 02, Strip 2
    db $83, $83, $84, $B3, $82, $83, $83, $84 ; Row 02, Strip 3
    db $A5, $14, $14, $14, $A5, $14, $14, $15 ; Row 03, Strip 0
    db $A7, $B6, $DF, $82, $B2, $93, $93, $93 ; Row 03, Strip 1
    db $93, $93, $94, $92, $93, $94, $72, $93 ; Row 03, Strip 2
    db $93, $93, $B3, $91, $B4, $93, $93, $A2 ; Row 03, Strip 3
    db $14, $A5, $14, $14, $14, $14, $14, $15 ; Row 04, Strip 0
    db $34, $A7, $82, $B2, $93, $93, $93, $93 ; Row 04, Strip 1
    db $93, $93, $94, $92, $93, $94, $82, $93 ; Row 04, Strip 2
    db $82, $83, $83, $84, $CA, $CA, $CA, $8F ; Row 04, Strip 3
    db $14, $14, $14, $14, $A5, $14, $A5, $36 ; Row 05, Strip 0
    db $05, $34, $B0, $D6, $93, $82, $83, $83 ; Row 05, Strip 1
    db $83, $84, $B3, $B2, $93, $B3, $B4, $90 ; Row 05, Strip 2
    db $B2, $93, $93, $B3, $BE, $11, $95, $54 ; Row 05, Strip 3
    db $A5, $14, $14, $A5, $14, $A5, $14, $14 ; Row 06, Strip 0
    db $15, $33, $33, $33, $90, $B2, $93, $93 ; Row 06, Strip 1
    db $93, $B3, $73, $A1, $83, $84, $11, $90 ; Row 06, Strip 2
    db $73, $73, $73, $91, $9F, $06, $22, $54 ; Row 06, Strip 3
    db $14, $14, $A5, $A5, $14, $14, $14, $A5 ; Row 07, Strip 0
    db $15, $A6, $FB, $34, $82, $83, $83, $83 ; Row 07, Strip 1
    db $83, $83, $83, $84, $93, $94, $CA, $82 ; Row 07, Strip 2
    db $83, $83, $83, $84, $A9, $16, $02, $54 ; Row 07, Strip 3
    db $26, $27, $26, $27, $26, $24, $24, $D5 ; Row 08, Strip 0
    db $25, $34, $34, $34, $B0, $93, $D6, $93 ; Row 08, Strip 1
    db $93, $93, $93, $A4, $93, $A4, $CA, $B4 ; Row 08, Strip 2
    db $93, $93, $93, $B7, $11, $11, $12, $54 ; Row 08, Strip 3
    db $15, $13, $15, $13, $15, $33, $40, $41 ; Row 09, Strip 0
    db $33, $BF, $34, $34, $30, $FB, $C0, $23 ; Row 09, Strip 1
    db $24, $24, $24, $25, $00, $17, $06, $21 ; Row 09, Strip 2
    db $21, $21, $21, $21, $21, $21, $22, $54 ; Row 09, Strip 3
    db $15, $13, $15, $13, $15, $BC, $BD, $A6 ; Row 0A, Strip 0
    db $A7, $34, $41, $33, $40, $34, $C0, $34 ; Row 0A, Strip 1
    db $B6, $80, $80, $B6, $20, $07, $95, $A6 ; Row 0A, Strip 2
    db $A6, $F6, $A7, $44, $45, $34, $41, $54 ; Row 0A, Strip 3
    db $15, $13, $15, $13, $36, $05, $D0, $D0 ; Row 0B, Strip 0
    db $D0, $D0, $D0, $D0, $D0, $D0, $C3, $D0 ; Row 0B, Strip 1
    db $D0, $D0, $D0, $D0, $D0, $10, $06, $77 ; Row 0B, Strip 2
    db $7B, $7B, $7B, $43, $7A, $7B, $8D, $8E ; Row 0B, Strip 3
    db $15, $23, $25, $23, $24, $25, $C0, $A6 ; Row 0C, Strip 0
    db $FB, $A7, $A6, $00, $EA, $E8, $E8, $E8 ; Row 0C, Strip 1
    db $E9, $E9, $E9, $EB, $02, $10, $12, $54 ; Row 0C, Strip 2
    db $57, $9D, $9D, $9D, $9D, $9D, $C8, $C9 ; Row 0C, Strip 3
    db $25, $31, $B6, $34, $6E, $6E, $C0, $10 ; Row 0D, Strip 0
    db $12, $A7, $A6, $10, $C4, $D9, $D9, $D7 ; Row 0D, Strip 1
    db $E7, $DA, $DA, $D4, $12, $10, $12, $54 ; Row 0D, Strip 2
    db $C7, $E2, $E2, $E2, $E2, $F1, $89, $54 ; Row 0D, Strip 3
    db $34, $41, $33, $33, $33, $33, $C0, $10 ; Row 0E, Strip 0
    db $12, $A6, $F6, $10, $C4, $D9, $D7, $D8 ; Row 0E, Strip 1
    db $EC, $E7, $DA, $D4, $12, $10, $12, $54 ; Row 0E, Strip 2
    db $C7, $E2, $E2, $E2, $E2, $E1, $F1, $54 ; Row 0E, Strip 3
    db $34, $F6, $89, $6B, $6C, $89, $F6, $10 ; Row 0F, Strip 0
    db $12, $FB, $FB, $10, $C4, $D7, $EC, $D8 ; Row 0F, Strip 1
    db $D8, $D8, $E7, $D4, $F3, $F4, $22, $54 ; Row 0F, Strip 2
    db $C7, $E2, $E1, $E1, $E2, $E1, $F1, $54 ; Row 0F, Strip 3
    db $34, $B6, $34, $3E, $5E, $88, $88, $10 ; Row 10, Strip 0
    db $12, $A6, $A6, $10, $D1, $D8, $D8, $EC ; Row 10, Strip 1
    db $EC, $D8, $D8, $E5, $12, $FC, $FC, $5C ; Row 10, Strip 2
    db $C7, $E0, $6D, $7D, $E0, $E1, $F1, $54 ; Row 10, Strip 3
    db $88, $88, $E3, $BD, $E3, $BD, $F6, $10 ; Row 11, Strip 0
    db $12, $E3, $BD, $10, $12, $34, $A7, $89 ; Row 11, Strip 1
    db $89, $A7, $34, $20, $22, $FC, $FC, $5C ; Row 11, Strip 2
    db $C7, $E2, $E1, $E2, $E2, $F1, $89, $54 ; Row 11, Strip 3
    db $34, $A7, $34, $34, $34, $34, $A7, $20 ; Row 12, Strip 0
    db $22, $33, $33, $10, $16, $01, $01, $01 ; Row 12, Strip 1
    db $01, $01, $01, $01, $02, $FC, $FC, $5C ; Row 12, Strip 2
    db $55, $F0, $89, $F0, $F0, $FB, $A7, $54 ; Row 12, Strip 3
    db $CF, $04, $04, $CB, $04, $BB, $C0, $03 ; Row 13, Strip 0
    db $04, $04, $04, $DB, $E6, $21, $21, $21 ; Row 13, Strip 1
    db $21, $21, $21, $07, $12, $FC, $FC, $5C ; Row 13, Strip 2
    db $55, $77, $7B, $7B, $7B, $7B, $7C, $54 ; Row 13, Strip 3
    db $69, $24, $24, $27, $26, $25, $C0, $13 ; Row 14, Strip 0
    db $26, $24, $24, $27, $15, $A7, $FB, $FB ; Row 14, Strip 1
    db $FB, $A7, $C0, $10, $12, $FC, $FC, $5C ; Row 14, Strip 2
    db $55, $64, $67, $56, $57, $67, $65, $54 ; Row 14, Strip 3
    db $55, $34, $34, $13, $15, $33, $33, $13 ; Row 15, Strip 0
    db $15, $FB, $A7, $13, $15, $A7, $FB, $FB ; Row 15, Strip 1
    db $FB, $B6, $C0, $10, $12, $34, $34, $64 ; Row 15, Strip 2
    db $65, $A6, $A6, $54, $55, $31, $44, $46 ; Row 15, Strip 3
    db $55, $33, $31, $23, $25, $33, $F6, $13 ; Row 16, Strip 0
    db $15, $A7, $FB, $13, $15, $A7, $A6, $34 ; Row 16, Strip 1
    db $B6, $F6, $C0, $10, $16, $02, $00, $96 ; Row 16, Strip 2
    db $01, $01, $01, $68, $55, $41, $64, $56 ; Row 16, Strip 3
    db $7A, $7B, $7B, $7B, $7B, $7B, $7C, $23 ; Row 17, Strip 0
    db $36, $05, $03, $37, $15, $A7, $41, $33 ; Row 17, Strip 1
    db $33, $33, $C3, $20, $21, $22, $20, $AB ; Row 17, Strip 2
    db $97, $97, $BE, $68, $7A, $7B, $7B, $43 ; Row 17, Strip 3
    db $9D, $9D, $9D, $9D, $9D, $56, $55, $A6 ; Row 18, Strip 0
    db $23, $25, $23, $24, $25, $34, $44, $66 ; Row 18, Strip 1
    db $66, $45, $44, $66, $45, $34, $34, $64 ; Row 18, Strip 2
    db $AE, $AE, $A9, $68, $57, $C6, $67, $56 ; Row 18, Strip 3
    db $9F, $DD, $DD, $DD, $11, $8F, $47, $66 ; Row 19, Strip 0
    db $45, $D0, $D0, $D0, $C3, $34, $AF, $67 ; Row 19, Strip 1
    db $67, $65, $64, $56, $75, $76, $01, $01 ; Row 19, Strip 2
    db $17, $11, $11, $B8, $53, $96, $02, $54 ; Row 19, Strip 3
    db $9F, $11, $11, $11, $11, $A8, $56, $35 ; Row 1A, Strip 0
    db $55, $77, $7C, $A7, $34, $B1, $AD, $B6 ; Row 1A, Strip 1
    db $B6, $B6, $B6, $54, $55, $10, $11, $11 ; Row 1A, Strip 2
    db $11, $11, $11, $8F, $9F, $06, $12, $54 ; Row 1A, Strip 3
    db $9F, $ED, $ED, $11, $ED, $11, $A8, $56 ; Row 1B, Strip 0
    db $7A, $43, $7A, $7B, $7B, $D3, $AC, $BF ; Row 1B, Strip 1
    db $BF, $B6, $B6, $54, $55, $10, $11, $11 ; Row 1B, Strip 2
    db $F7, $F8, $11, $8F, $9F, $12, $22, $54 ; Row 1B, Strip 3
    db $9F, $ED, $11, $11, $11, $ED, $11, $54 ; Row 1C, Strip 0
    db $57, $56, $57, $56, $57, $65, $B6, $B6 ; Row 1C, Strip 1
    db $B6, $B6, $B6, $54, $47, $AA, $11, $11 ; Row 1C, Strip 2
    db $F9, $FA, $11, $8F, $9F, $12, $34, $54 ; Row 1C, Strip 3
    db $A9, $11, $11, $ED, $11, $11, $11, $54 ; Row 1D, Strip 0
    db $55, $64, $65, $54, $55, $B6, $B6, $B6 ; Row 1D, Strip 1
    db $B6, $30, $33, $54, $57, $F2, $11, $11 ; Row 1D, Strip 2
    db $11, $11, $11, $A8, $A9, $95, $02, $54 ; Row 1D, Strip 3
    db $11, $11, $ED, $11, $11, $ED, $11, $54 ; Row 1E, Strip 0
    db $7A, $7F, $6F, $C1, $65, $B6, $79, $F5 ; Row 1E, Strip 1
    db $B6, $32, $34, $64, $65, $20, $07, $11 ; Row 1E, Strip 2
    db $11, $11, $11, $11, $06, $21, $22, $54 ; Row 1E, Strip 3
    db $21, $07, $11, $ED, $11, $ED, $06, $54 ; Row 1F, Strip 0
    db $35, $47, $46, $55, $B6, $B6, $B6, $B6 ; Row 1F, Strip 1
    db $30, $40, $34, $B6, $34, $34, $10, $11 ; Row 1F, Strip 2
    db $11, $11, $06, $21, $22, $34, $B6, $54 ; Row 1F, Strip 3
}

; ==============================================================================

; $055B27-$055D26 DATA
Palettes_OWMAP:
{
    ; $055B27-$055C26 DATA
    Palettes_LWMAP:
    {
        dw  $0000,  $094B,  $1563,  $1203,  $2995,  $5BDF,  $2191,  $2E37
        dw  $7C1F,  $6F37,  $7359,  $777A,  $7B9B,  $7FBD,  $0000,  $0000
        dw  $0000,  $0100,  $0000,  $0000,  $7B9B,  $11B6,  $1A9B,  $5FFF
        dw  $2995,  $6E94,  $76D6,  $7F39,  $7F7B,  $7FBD,  $0000,  $0000
        dw  $0000,  $0100,  $1D74,  $67F9,  $1EE9,  $338E,  $6144,  $7E6A
        dw  $0A44,  $7C1F,  $6144,  $22EB,  $3DCA,  $5ED2,  $7FDA,  $316A
        dw  $0000,  $0100,  $14CC,  $1910,  $2995,  $3E3A,  $1963,  $15E3
        dw  $25F5,  $2E37,  $15E3,  $22EB,  $6144,  $7E33,  $5D99,  $771D
        dw  $0000,  $0CEC,  $22EB,  $2FB1,  $1D70,  $2E37,  $25F5,  $3E77
        dw  $473A,  $6144,  $7E6A,  $15E3,  $2E0B,  $5354,  $7FFF,  $16A6
        dw  $0000,  $0100,  $15C5,  $16A6,  $1EE9,  $2F4D,  $25F5,  $3E77
        dw  $473A,  $5354,  $15E3,  $22EB,  $2918,  $4A1F,  $3F7F,  $7C1F
        dw  $0000,  $0100,  $1563,  $1203,  $1EE9,  $2FB0,  $1D70,  $2E37
        dw  $473A,  $6144,  $15E3,  $22EB,  $1D70,  $2E37,  $4F3F,  $7FBD
        dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $25F5
        dw  $316A,  $5ED2,  $7FFF,  $15E3,  $473A,  $2918,  $771D,  $0000
    }

    ; $055C27-$055D26 DATA
    Palettes_DWMAP:
    {
        dw  $0000,  $18C6,  $0948,  $118A,  $25CF,  $57BF,  $1971,  $2A18
        dw  $7C1F,  $52D8,  $5AF9,  $5F1A,  $633B,  $6B5C,  $0000,  $0000
        dw  $0000,  $18C6,  $0005,  $45FC,  $633B,  $1DCE,  $3694,  $4718
        dw  $25CF,  $1D40,  $34EA,  $616F,  $771B,  $26D6,  $2B18,  $2F5A
        dw  $0000,  $18C6,  $2571,  $63DA,  $2A32,  $3A94,  $1D40,  $2580
        dw  $7C1F,  $7C1F,  $0CC0,  $1ECC,  $3135,  $1DCE,  $4718,  $3694
        dw  $0000,  $18C6,  $14E7,  $216C,  $25D0,  $3A75,  $2169,  $2E0E
        dw  $21D6,  $2A18,  $1971,  $2A32,  $1D40,  $2580,  $597A,  $72FE
        dw  $0000,  $18C6,  $2A32,  $3A94,  $2171,  $3238,  $29F6,  $4278
        dw  $4EDB,  $1D40,  $35CD,  $15AB,  $198E,  $3254,  $731F,  $1ED4
        dw  $0000,  $18C6,  $016A,  $21CE,  $2A32,  $3A94,  $29F6,  $4278
        dw  $4EDB,  $1D40,  $1971,  $2A32,  $496C,  $5A10,  $3B5F,  $7C1F
        dw  $0000,  $18C6,  $0948,  $118A,  $222E,  $32F2,  $1951,  $2A18
        dw  $431B,  $1D40,  $1971,  $2A32,  $21D4,  $2A18,  $4B1F,  $7B9D
        dw  $0000,  $7C1F,  $7C1F,  $7C1F,  $7C1F,  $2E31,  $00E4,  $2169
        dw  $2E0E,  $42F1,  $7C1F,  $7C1F,  $7C1F,  $4A1D,  $4E3F,  $5A5F
    }
}
; ==============================================================================

; $055D27-$055E06 DATA
WorldMapHDMA_ZoomedOut_Part1:
{
    dw $0177 ; Scanline   0
    dw $0176 ; Scanline   1
    dw $0175 ; Scanline   2
    dw $0175 ; Scanline   3
    dw $0174 ; Scanline   4
    dw $0173 ; Scanline   5
    dw $0173 ; Scanline   6
    dw $0172 ; Scanline   7
    dw $0171 ; Scanline   8
    dw $0171 ; Scanline   9
    dw $0170 ; Scanline  10
    dw $016F ; Scanline  11
    dw $016F ; Scanline  12
    dw $016E ; Scanline  13
    dw $016D ; Scanline  14
    dw $016D ; Scanline  15
    dw $016C ; Scanline  16
    dw $016B ; Scanline  17
    dw $016B ; Scanline  18
    dw $0169 ; Scanline  19
    dw $0169 ; Scanline  20
    dw $0168 ; Scanline  21
    dw $0167 ; Scanline  22
    dw $0167 ; Scanline  23
    dw $0166 ; Scanline  24
    dw $0165 ; Scanline  25
    dw $0165 ; Scanline  26
    dw $0164 ; Scanline  27
    dw $0163 ; Scanline  28
    dw $0163 ; Scanline  29
    dw $0162 ; Scanline  30
    dw $0162 ; Scanline  31
    dw $0161 ; Scanline  32
    dw $0160 ; Scanline  33
    dw $0160 ; Scanline  34
    dw $015F ; Scanline  35
    dw $015F ; Scanline  36
    dw $015E ; Scanline  37
    dw $015D ; Scanline  38
    dw $015D ; Scanline  39
    dw $015C ; Scanline  40
    dw $015C ; Scanline  41
    dw $015B ; Scanline  42
    dw $015A ; Scanline  43
    dw $015A ; Scanline  44
    dw $0159 ; Scanline  45
    dw $0159 ; Scanline  46
    dw $0158 ; Scanline  47
    dw $0157 ; Scanline  48
    dw $0157 ; Scanline  49
    dw $0156 ; Scanline  50
    dw $0156 ; Scanline  51
    dw $0155 ; Scanline  52
    dw $0155 ; Scanline  53
    dw $0154 ; Scanline  54
    dw $0153 ; Scanline  55
    dw $0153 ; Scanline  56
    dw $0152 ; Scanline  57
    dw $0152 ; Scanline  58
    dw $0151 ; Scanline  59
    dw $0151 ; Scanline  60
    dw $0150 ; Scanline  61
    dw $014F ; Scanline  62
    dw $014F ; Scanline  63
    dw $014E ; Scanline  64
    dw $014E ; Scanline  65
    dw $014D ; Scanline  66
    dw $014D ; Scanline  67
    dw $014C ; Scanline  68
    dw $014C ; Scanline  69
    dw $014B ; Scanline  70
    dw $014B ; Scanline  71
    dw $014A ; Scanline  72
    dw $014A ; Scanline  73
    dw $0148 ; Scanline  74
    dw $0147 ; Scanline  75
    dw $0147 ; Scanline  76
    dw $0146 ; Scanline  77
    dw $0146 ; Scanline  78
    dw $0145 ; Scanline  79
    dw $0145 ; Scanline  80
    dw $0144 ; Scanline  81
    dw $0144 ; Scanline  82
    dw $0143 ; Scanline  83
    dw $0143 ; Scanline  84
    dw $0142 ; Scanline  85
    dw $0142 ; Scanline  86
    dw $0141 ; Scanline  87
    dw $0141 ; Scanline  88
    dw $0140 ; Scanline  89
    dw $0140 ; Scanline  90
    dw $013F ; Scanline  91
    dw $013F ; Scanline  92
    dw $013E ; Scanline  93
    dw $013E ; Scanline  94
    dw $013D ; Scanline  95
    dw $013D ; Scanline  96
    dw $013C ; Scanline  97
    dw $013C ; Scanline  98
    dw $013B ; Scanline  99
    dw $013B ; Scanline 100
    dw $013A ; Scanline 101
    dw $013A ; Scanline 102
    dw $0139 ; Scanline 103
    dw $0139 ; Scanline 104
    dw $0138 ; Scanline 105
    dw $0138 ; Scanline 106
    dw $0137 ; Scanline 107
    dw $0137 ; Scanline 108
    dw $0136 ; Scanline 109
    dw $0136 ; Scanline 110
    dw $0135 ; Scanline 111
}

; ==============================================================================

; $055E07-$055EE6 DATA
WorldMapHDMA_ZoomedOut_Part2:
{
    dw $0135 ; Scanline 112
    dw $0135 ; Scanline 113
    dw $0134 ; Scanline 114
    dw $0134 ; Scanline 115
    dw $0133 ; Scanline 116
    dw $0133 ; Scanline 117
    dw $0132 ; Scanline 118
    dw $0132 ; Scanline 119
    dw $0131 ; Scanline 120
    dw $0131 ; Scanline 121
    dw $0130 ; Scanline 122
    dw $0130 ; Scanline 123
    dw $012F ; Scanline 124
    dw $012F ; Scanline 125
    dw $012F ; Scanline 126
    dw $012E ; Scanline 127
    dw $012E ; Scanline 128
    dw $012D ; Scanline 129
    dw $012D ; Scanline 130
    dw $012C ; Scanline 131
    dw $012C ; Scanline 132
    dw $012B ; Scanline 133
    dw $012B ; Scanline 134
    dw $012B ; Scanline 135
    dw $012A ; Scanline 136
    dw $012A ; Scanline 137
    dw $0129 ; Scanline 138
    dw $0129 ; Scanline 139
    dw $0127 ; Scanline 140
    dw $0127 ; Scanline 141
    dw $0126 ; Scanline 142
    dw $0126 ; Scanline 143
    dw $0126 ; Scanline 144
    dw $0125 ; Scanline 145
    dw $0125 ; Scanline 146
    dw $0124 ; Scanline 147
    dw $0124 ; Scanline 148
    dw $0124 ; Scanline 149
    dw $0123 ; Scanline 150
    dw $0123 ; Scanline 151
    dw $0122 ; Scanline 152
    dw $0122 ; Scanline 153
    dw $0121 ; Scanline 154
    dw $0121 ; Scanline 155
    dw $0121 ; Scanline 156
    dw $0120 ; Scanline 157
    dw $0120 ; Scanline 158
    dw $011F ; Scanline 159
    dw $011F ; Scanline 160
    dw $011F ; Scanline 161
    dw $011E ; Scanline 162
    dw $011E ; Scanline 163
    dw $011D ; Scanline 164
    dw $011D ; Scanline 165
    dw $011D ; Scanline 166
    dw $011C ; Scanline 167
    dw $011C ; Scanline 168
    dw $011B ; Scanline 169
    dw $011B ; Scanline 170
    dw $011B ; Scanline 171
    dw $011A ; Scanline 172
    dw $011A ; Scanline 173
    dw $0119 ; Scanline 174
    dw $0119 ; Scanline 175
    dw $0119 ; Scanline 176
    dw $0118 ; Scanline 177
    dw $0118 ; Scanline 178
    dw $0117 ; Scanline 179
    dw $0117 ; Scanline 180
    dw $0117 ; Scanline 181
    dw $0116 ; Scanline 182
    dw $0116 ; Scanline 183
    dw $0116 ; Scanline 184
    dw $0115 ; Scanline 185
    dw $0115 ; Scanline 186
    dw $0114 ; Scanline 187
    dw $0114 ; Scanline 188
    dw $0114 ; Scanline 189
    dw $0113 ; Scanline 190
    dw $0113 ; Scanline 191
    dw $0113 ; Scanline 192
    dw $0112 ; Scanline 193
    dw $0112 ; Scanline 194
    dw $0111 ; Scanline 195
    dw $0111 ; Scanline 196
    dw $0111 ; Scanline 197
    dw $0110 ; Scanline 198
    dw $0110 ; Scanline 199
    dw $0110 ; Scanline 200
    dw $010F ; Scanline 201
    dw $010F ; Scanline 202
    dw $010F ; Scanline 203
    dw $010E ; Scanline 204
    dw $010E ; Scanline 205
    dw $010D ; Scanline 206
    dw $010D ; Scanline 207
    dw $010D ; Scanline 208
    dw $010C ; Scanline 209
    dw $010C ; Scanline 210
    dw $010C ; Scanline 211
    dw $010B ; Scanline 212
    dw $010B ; Scanline 213
    dw $010B ; Scanline 214
    dw $010A ; Scanline 215
    dw $010A ; Scanline 216
    dw $010A ; Scanline 217
    dw $0109 ; Scanline 218
    dw $0109 ; Scanline 219
    dw $0109 ; Scanline 220
    dw $0108 ; Scanline 221
    dw $0108 ; Scanline 222
    dw $0108 ; Scanline 223
}

; ==============================================================================

; $055EE7-$055FC6 DATA
WorldMapHDMA_ZoomedIn_Part1:
{
    dw $0088 ; Scanline   0
    dw $0088 ; Scanline   1
    dw $0087 ; Scanline   2
    dw $0087 ; Scanline   3
    dw $0087 ; Scanline   4
    dw $0087 ; Scanline   5
    dw $0087 ; Scanline   6
    dw $0086 ; Scanline   7
    dw $0086 ; Scanline   8
    dw $0086 ; Scanline   9
    dw $0085 ; Scanline  10
    dw $0085 ; Scanline  11
    dw $0085 ; Scanline  12
    dw $0085 ; Scanline  13
    dw $0084 ; Scanline  14
    dw $0084 ; Scanline  15
    dw $0084 ; Scanline  16
    dw $0084 ; Scanline  17
    dw $0084 ; Scanline  18
    dw $0083 ; Scanline  19
    dw $0083 ; Scanline  20
    dw $0083 ; Scanline  21
    dw $0082 ; Scanline  22
    dw $0082 ; Scanline  23
    dw $0082 ; Scanline  24
    dw $0082 ; Scanline  25
    dw $0082 ; Scanline  26
    dw $0081 ; Scanline  27
    dw $0081 ; Scanline  28
    dw $0081 ; Scanline  29
    dw $0081 ; Scanline  30
    dw $0081 ; Scanline  31
    dw $0080 ; Scanline  32
    dw $0080 ; Scanline  33
    dw $0080 ; Scanline  34
    dw $007F ; Scanline  35
    dw $007F ; Scanline  36
    dw $007F ; Scanline  37
    dw $007F ; Scanline  38
    dw $007F ; Scanline  39
    dw $007E ; Scanline  40
    dw $007E ; Scanline  41
    dw $007E ; Scanline  42
    dw $007E ; Scanline  43
    dw $007E ; Scanline  44
    dw $007D ; Scanline  45
    dw $007D ; Scanline  46
    dw $007D ; Scanline  47
    dw $007C ; Scanline  48
    dw $007C ; Scanline  49
    dw $007C ; Scanline  50
    dw $007C ; Scanline  51
    dw $007C ; Scanline  52
    dw $007C ; Scanline  53
    dw $007B ; Scanline  54
    dw $007B ; Scanline  55
    dw $007B ; Scanline  56
    dw $007B ; Scanline  57
    dw $007B ; Scanline  58
    dw $007A ; Scanline  59
    dw $007A ; Scanline  60
    dw $007A ; Scanline  61
    dw $0079 ; Scanline  62
    dw $0079 ; Scanline  63
    dw $0079 ; Scanline  64
    dw $0079 ; Scanline  65
    dw $0079 ; Scanline  66
    dw $0079 ; Scanline  67
    dw $0078 ; Scanline  68
    dw $0078 ; Scanline  69
    dw $0078 ; Scanline  70
    dw $0078 ; Scanline  71
    dw $0078 ; Scanline  72
    dw $0078 ; Scanline  73
    dw $0077 ; Scanline  74
    dw $0077 ; Scanline  75
    dw $0077 ; Scanline  76
    dw $0076 ; Scanline  77
    dw $0076 ; Scanline  78
    dw $0076 ; Scanline  79
    dw $0076 ; Scanline  80
    dw $0076 ; Scanline  81
    dw $0076 ; Scanline  82
    dw $0075 ; Scanline  83
    dw $0075 ; Scanline  84
    dw $0075 ; Scanline  85
    dw $0075 ; Scanline  86
    dw $0075 ; Scanline  87
    dw $0075 ; Scanline  88
    dw $0074 ; Scanline  89
    dw $0074 ; Scanline  90
    dw $0074 ; Scanline  91
    dw $0074 ; Scanline  92
    dw $0073 ; Scanline  93
    dw $0073 ; Scanline  94
    dw $0073 ; Scanline  95
    dw $0073 ; Scanline  96
    dw $0073 ; Scanline  97
    dw $0073 ; Scanline  98
    dw $0072 ; Scanline  99
    dw $0072 ; Scanline 100
    dw $0072 ; Scanline 101
    dw $0072 ; Scanline 102
    dw $0072 ; Scanline 103
    dw $0072 ; Scanline 104
    dw $0071 ; Scanline 105
    dw $0071 ; Scanline 106
    dw $0071 ; Scanline 107
    dw $0071 ; Scanline 108
    dw $0070 ; Scanline 109
    dw $0070 ; Scanline 110
    dw $0070 ; Scanline 111
}

; ==============================================================================

; $055FC7-$0560A6 DATA
WorldMapHDMA_ZoomedIn_Part2:
{
    dw $0070 ; Scanline 112
    dw $0070 ; Scanline 113
    dw $0070 ; Scanline 114
    dw $0070 ; Scanline 115
    dw $006F ; Scanline 116
    dw $006F ; Scanline 117
    dw $006F ; Scanline 118
    dw $006F ; Scanline 119
    dw $006F ; Scanline 120
    dw $006F ; Scanline 121
    dw $006E ; Scanline 122
    dw $006E ; Scanline 123
    dw $006E ; Scanline 124
    dw $006E ; Scanline 125
    dw $006E ; Scanline 126
    dw $006D ; Scanline 127
    dw $006D ; Scanline 128
    dw $006D ; Scanline 129
    dw $006D ; Scanline 130
    dw $006D ; Scanline 131
    dw $006D ; Scanline 132
    dw $006C ; Scanline 133
    dw $006C ; Scanline 134
    dw $006C ; Scanline 135
    dw $006C ; Scanline 136
    dw $006C ; Scanline 137
    dw $006C ; Scanline 138
    dw $006C ; Scanline 139
    dw $006B ; Scanline 140
    dw $006B ; Scanline 141
    dw $006B ; Scanline 142
    dw $006B ; Scanline 143
    dw $006B ; Scanline 144
    dw $006A ; Scanline 145
    dw $006A ; Scanline 146
    dw $006A ; Scanline 147
    dw $006A ; Scanline 148
    dw $006A ; Scanline 149
    dw $006A ; Scanline 150
    dw $006A ; Scanline 151
    dw $0069 ; Scanline 152
    dw $0069 ; Scanline 153
    dw $0069 ; Scanline 154
    dw $0069 ; Scanline 155
    dw $0069 ; Scanline 156
    dw $0069 ; Scanline 157
    dw $0069 ; Scanline 158
    dw $0068 ; Scanline 159
    dw $0068 ; Scanline 160
    dw $0068 ; Scanline 161
    dw $0068 ; Scanline 162
    dw $0068 ; Scanline 163
    dw $0067 ; Scanline 164
    dw $0067 ; Scanline 165
    dw $0067 ; Scanline 166
    dw $0067 ; Scanline 167
    dw $0067 ; Scanline 168
    dw $0067 ; Scanline 169
    dw $0067 ; Scanline 170
    dw $0067 ; Scanline 171
    dw $0066 ; Scanline 172
    dw $0066 ; Scanline 173
    dw $0066 ; Scanline 174
    dw $0066 ; Scanline 175
    dw $0066 ; Scanline 176
    dw $0066 ; Scanline 177
    dw $0066 ; Scanline 178
    dw $0065 ; Scanline 179
    dw $0065 ; Scanline 180
    dw $0065 ; Scanline 181
    dw $0065 ; Scanline 182
    dw $0065 ; Scanline 183
    dw $0065 ; Scanline 184
    dw $0064 ; Scanline 185
    dw $0064 ; Scanline 186
    dw $0064 ; Scanline 187
    dw $0064 ; Scanline 188
    dw $0064 ; Scanline 189
    dw $0064 ; Scanline 190
    dw $0064 ; Scanline 191
    dw $0064 ; Scanline 192
    dw $0063 ; Scanline 193
    dw $0063 ; Scanline 194
    dw $0063 ; Scanline 195
    dw $0063 ; Scanline 196
    dw $0063 ; Scanline 197
    dw $0063 ; Scanline 198
    dw $0063 ; Scanline 199
    dw $0063 ; Scanline 200
    dw $0062 ; Scanline 201
    dw $0062 ; Scanline 202
    dw $0062 ; Scanline 203
    dw $0062 ; Scanline 204
    dw $0062 ; Scanline 205
    dw $0061 ; Scanline 206
    dw $0061 ; Scanline 207
    dw $0061 ; Scanline 208
    dw $0061 ; Scanline 209
    dw $0061 ; Scanline 210
    dw $0061 ; Scanline 211
    dw $0061 ; Scanline 212
    dw $0061 ; Scanline 213
    dw $0061 ; Scanline 214
    dw $0060 ; Scanline 215
    dw $0060 ; Scanline 216
    dw $0060 ; Scanline 217
    dw $0060 ; Scanline 218
    dw $0060 ; Scanline 219
    dw $0060 ; Scanline 220
    dw $0060 ; Scanline 221
    dw $0060 ; Scanline 222
    dw $0060 ; Scanline 223
}

; ==============================================================================

; $0560A7-$0560AF DATA
NULL_0AE0A7:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF
}

; ==============================================================================

; $0560B0-$0560D1 JUMP LOCATION (LONG)
Messaging_DungeonMap:
{
    LDA.w $0200 ; An index into what type of display to use.
    JSL.l UseImplicitRegIndexedLongJumpTable
    dl DungeonMap_Backup               ; 0x00 - $0ED94C Fade to full darkness (amidst other things)
    dl DungeonMap_Init                 ; 0x01 - $0AE0DC Loading Dungeon Map
    dl DungeonMap_LightenUpMap         ; 0x02 - $0ED940 Fade to full brightness
    dl DungeonMap_3                    ; 0x03 - $0AE954 Dungeon map Mode
    dl DungeonMap_4                    ; 0x04 - $0AEEF6  
    dl DungeonMap_FadeMapToBlack       ; 0x05 - $0EDA37
    dl DungeonMap_RestoreGraphics      ; 0x06 - $0AEF19
    dl DungeonMap_RestoreStarTileState ; 0x07 - $0AEFC9
    dl DungeonMap_LightenUpDungeon     ; 0x08 - $0EDA79
}

; ==============================================================================

; $0560D2-$0560DB Jump Table
DungeonMap_Init_JumpTable:
{
    dw DungeonMap_SetupGraphics             ; 0x00 - $E0E4
    dw DungeonMap_OptionalGraphic           ; 0x01 - $E1A4
    dw Module0E_03_01_02_DrawFloorsBackdrop ; 0x02 - $E1F3
    dw Module0E_03_01_03_DrawRooms          ; 0x03 - $E384
    dw DungeonMap_DrawRoomMarkers           ; 0x04 - $E823
}

; $0560DC-$0560E3 JUMP LOCATION (LONG)
DungeonMap_Init:
{
    LDA.w $020D : ASL A : TAX
    JMP (.JumpTable, X)
}

; ==============================================================================

; $0560E4-$056159 JUMP LOCATION (LONG)
DungeonMap_SetupGraphics:
{
    ; Cache HDMA settings elsewhere and turn off HDMA for the time being.
    LDA.b $9B : PHA : STZ.w SNES.HDMAChannelEnable : STZ.b $9B
    
    ; Cache graphics settings to temp variables.
    LDA.w $0AA1 : STA.l $7EC20E
    LDA.w $0AA3 : STA.l $7EC20F
    LDA.w $0AA2 : STA.l $7EC210
    
    ; Cache bg screen settings to temp variables.
    LDA.b $1C : STA.l $7EC211
    LDA.b $1D : STA.l $7EC212
    
    ; Set a fixed main graphics index.
    LDA.b #$20 : STA.w $0AA1
    
    ; Use the current palace we're in to determine the sprite tileset.
    LDA.w $040C : LSR A : ORA.b #$80 : STA.w $0AA3
    
    ; Set the auxiliary bg graphics tileset.
    LDA.b #$40 : STA.w $0AA2
    
    ; BG1 on subscreen; BG2, BG3, and OAM on main screen.
    LDA.b #$16 : STA.b $1C
    LDA.b #$01 : STA.b $1D
    
    ; Writes blanks to $0000-$01FFF (byte addr) in VRAM. Clears BG2 tilemap.
    JSL.l VRAM_EraseTilemaps_palace
    
    ; Perform the standard graphics decompression routine.
    JSL.l InitTilesets
    
    ; Set special palette index.
    LDA.b #$02 : STA.w $0AA9
    
    ; Load palettes.
    JSL.l Palette_PalaceMapBg
    JSL.l Palette_PalaceMapSpr
    
    ; Set another palette index.
    LDA.b #$01 : STA.w $0AB2
    
    ; Load palettes for BG3 (2bpp) graphics.
    JSL.l Palette_Hud
    
    JSL.l LoadActualGearPalettes
    
    INC.b $15
    
    INC.w $020D
        
    PLA : STA.b $9B
    
    LDA.b #$09 : STA.b $14
    
    STA.w $0710
    
    RTL
}
    
; ==============================================================================

; Module0E_03_01_01_DrawLEVEL
; $05615A-$0561A3 DATA
Pool_DungeonMap_OptionalGraphic:
{
    ; $05615A
    .LEVEL_top
    dw $8460, $0B00 ; VRAM $C108 | 12 bytes | Horizontal
    dw $2132, $2133, $2138, $213A, $207F

    ; $056168
    .LEVEL_bottom
    dw $A460, $0B00 ; VRAM $C148 | 12 bytes | Horizontal
    dw $2142, $2143, $2149, $214A, $207F

    ; $056176
    .numerals_top
    dw $2108, $2109, $2109, $210A
    dw $210B, $210C, $210D, $211D

    ; $056186
    .numerals_bottom
    dw $2118, $2119, $A109, $211A
    dw $211B, $211C, $2118, $A11D

    ; $056196
    .dungeon_level
    db $FF ; Sewers
    db $FF ; Hyrule Castle
    db $FF ; Eastern Palace
    db $FF ; Desert Palace
    db $FF ; Agahnim's Tower
    db $02 ; Swamp Palace
    db $00 ; Palace of Darkness
    db $0A ; Misery Mire
    db $04 ; Skull Woods
    db $08 ; Ice Palace
    db $FF ; Tower of Hera
    db $06 ; Thieves' Town
    db $0C ; Turtle Rock
    db $0E ; Ganon's Tower
}

; ==============================================================================

; Module0E_03_01_01_DrawLEVEL
; $0561A4-$0561E0 JUMP LOCATION (LONG)
DungeonMap_OptionalGraphic:
{
    PHB : PHK : PLB
    
    ; Load palace index.
    LDA.w $040C : LSR A : TAX
    
    ; Guessing this means that there's no special graphic for this palace.
    LDY.w .dungeon_level, X : BMI .return
        LDA.b #$FF : STA.w $1022
        
        LDX.b #$0E
        
        REP #$20
        
        LDA.w Pool_DungeonMap_OptionalGraphic_numerals_top, Y    : STA.w $1002, X
        LDA.w Pool_DungeonMap_OptionalGraphic_numerals_bottom, Y : STA.w $1012, X
        
        SEP #$20
        
        DEX

        .copyTiles

            LDA.w Pool_DungeonMap_OptionalGraphic_LEVEL_top, X
            STA.w $1002, X

            LDA.w Pool_DungeonMap_OptionalGraphic_LEVEL_bottom, X
            STA.w $1012, X
        DEX : BPL .copyTiles
        
        LDA.b #$01 : STA.b $14

    .return

    ; Move to next step of submodule.
    INC.w $020D
    
    PLB
    
    RTL
}

; ==============================================================================

; $0561E1-$0561F2 DATA
DungeonMap_BackdropFloorPosition:
{
    dw $1223 ; 4B-4F | VRAM $2446
    dw $1263 ; 5F    | VRAM $24C6
    dw $12A3 ; 6F    | VRAM $2546
    dw $12E3 ; 7F    | VRAM $25C6
    dw $1323 ; 8F    | VRAM $2646

    dw $11E3 ; 5B    | VRAM $23C6
    dw $11A3 ; 6B    | VRAM $2346
    dw $1163 ; 7B    | VRAM $22C6
    dw $1123 ; 8B    | VRAM $2246
}

; ==============================================================================

; $0561F3-$0562E4 JUMP LOCATION (LONG)
Module0E_03_01_02_DrawFloorsBackdrop:
{
    PHB : PHK : PLB
    
    REP #$30
    
    STZ.w $1000
    
    LDX.w $040C : PHX
    LDA.w DungeonMapFloorCountData, X
    
    AND.w #$0300 : BEQ .skipTileCopy
    AND.w #$0100 : BEQ .skipTileCopy
        LDX.w #$002A : PHX

        .copyTiles

            LDA.w DungeonMap_MountainStripes-2, X : STA.w $1000, X   
        DEX #2 : BNE .copyTiles
        
        PLX
        
        LDA.w #$1123 : STA.b $00
        
        LDY.w #$0010

        .copyTiles2

            LDA.b $00 : XBA : STA.w $1002, X
            XBA : CLC : ADC.w #$0020 : STA.b $00
            
            LDA.w #$0E40 : STA.w $1004, X
            LDA.w #$1B2E : STA.w $1006, X
            
            INX #6
        DEY : BNE .copyTiles2
        
        STX.w $1000

    .skipTileCopy

    STZ.b $00
    STZ.b $02
    
    LDX.w $040C
    LDA.w DungeonMapFloorCountData, X : AND.w #$00FF : CMP.w #$0050 : BCC .notTower
        ; Seems to be looking for tower style levels (tower of hera, hyrule
        ; castle 2, ganon's tower).
        LSR #4 : SEC : SBC.w #$0004 : ASL A : STA.b $00
        
        BRA .setupVramTarget

    .notTower

    AND.w #$000F : CMP.w #$0005 : BCC .setupVramTarget
        ASL A : STA.b $00

    .setupVramTarget

    LDX.b $00
    
    LDY.w $1000
    
    LDA.w DungeonMap_BackdropFloorPosition, X : STA.b $00 : STA.b $0E

    .limitNotReached

        ; Store big endian VRAM target address????
        LDA.b $00 : XBA : STA.w $1002, Y
        
        INY #2
        
        ; TODO: Have to look up NMI workings to know what this does.
        LDA.w #$0E40 : STA.w $1002, Y
        
        INY #2
        
        LDX.b $02
        
        LDA.w DungeonMap_BackdropFloorGradientTiles, X : STA.b $04
        
        ; Check bit 13 in palace properties word.
        LDX.w $040C
        LDA.w DungeonMapFloorCountData, X : AND.w #$0200 : BEQ .noOffset
            LDA.b $04 : CLC : ADC.w #$0400 : STA.b $04

        .noOffset

        LDA.b $04 : STA.w $1002, Y
        
        INY #2
        
        ; Apparently stop incrementing once $02 reaches 0x000C.
        LDA.b $02 : CMP.w #$000C : BEQ .stopIncrementing
            INC.b $02 : INC.b $02

        .stopIncrementing

        LDA.b $00 : CLC : ADC.w #$0020 : STA.b $00
    CMP.w #$1360 : BCC .limitNotReached
    
    ; Tell NMI how large the buffer is as of now.
    STY.w $1000
    
    SEP #$20
    
    PLX
    
    JSR.w DungeonMap_BuildFloorListBoxes
    
    REP #$10
    
    LDY.w $1000
    
    LDA.b #$FF : STA.w $1002, Y
    
    SEP #$10
    
    ; Move to next step of submodule.
    INC.w $020D
    
    LDA.b #$01 : STA.b $14
    
    PLB
    
    RTL
}

; ==============================================================================

; $0562E5-$0562F4 DATA
Pool_DungeonMap_BuildFloorListBoxes:
{
    dw $0F26, $0F27, $4F27, $4F26
    dw $8F26, $8F27, $CF27, $CF26
}

; $0562F5-$056383 LOCAL JUMP LOCATION
DungeonMap_BuildFloorListBoxes:
{
    REP #$20
    
    LDA.w DungeonMapFloorCountData, X : AND.w #$00FF : STA.b $02
    AND.w #$000F : STA.b $00
    
    LDA.b $02 : LSR #4 : CLC : ADC.b $00 : STA.b $02
    
    LDA.b $A4 : CLC : ADC.b $00 : AND.w #$00FF : STA.b $0C
    
    STZ.b $0A
    
    LDA.b $0E : SEC : SBC.w #$0040 : CLC : ADC.w #$0002 : STA.b $0E
    
    LDX.b $00 : BEQ .BRANCH_ALPHA
        LDA.b $0E
        
        .BRANCH_BETA

            CLC : ADC.w #$0040
        DEX : BNE .BRANCH_BETA
        
        STA.b $0E

    .BRANCH_ALPHA

    REP #$10
    
    LDY.w $1000

    .BRANCH_ZETA

        LDX.w #$0000
        
        LDA.b $0E

        .BRANCH_THETA

        XBA : STA.w $1002, Y
        
        INY #2
        
        LDA.w #$0700 : STA.w $1002, Y
        
        INY #2

        .BRANCH_GAMMA

            LDA.w Pool_DungeonMap_BuildFloorListBoxes, X : STA.w $1002, Y
            
            INY #2
        INX #2 : CPX.w #$0008 : BCC .BRANCH_GAMMA : BEQ .BRANCH_DELTA
            CPX.w #$0010 : BNE .BRANCH_GAMMA
                BRA .BRANCH_EPSILON

        .BRANCH_DELTA

        LDA.b $0E : CLC : ADC.w #$0020
        
        BRA .BRANCH_THETA

        .BRANCH_EPSILON

        LDA.b $0E : SEC : SBC.w #$0040 : STA.b $0E
    INC.b $0A : LDA.b $0A : CMP.b $02 : BMI .BRANCH_ZETA
    
    STY.w $1000
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $056384-$056428 JUMP LOCATION (LONG)
Module0E_03_01_03_DrawRooms:
{
    PHB : PHK : PLB
    
    STZ.w $0210
    
    REP #$30
    
    STZ.b $00 : STZ.b $02 : STZ.b $04 : STZ.b $06
    STZ.b $08 : STZ.b $0A : STZ.b $0C
    
    STZ.w $0211
    
    LDX.w $040C
    
    LDA.w DungeonMapFloorCountData, X : AND.w #$000F : EOR.w #$00FF : INC A : AND.w #$00FF : CMP.b $A4 : BEQ .BRANCH_ALPHA
        LDA.b $A4 : AND.w #$00FF : STA.w $020E
        
        BRA .BRANCH_BETA

    .BRANCH_ALPHA

    LDA.b $A4 : INC A : STA.w $020E
    
    INC.w $0211 : INC.w $0211

    .BRANCH_BETA

    LDA.w $020E : AND.w #$0050 : BNE .BRANCH_GAMMA
        LDA.w #$EFFF : STA.b $08
        
        BRA .BRANCH_DELTA

    .BRANCH_GAMMA

    LDA.w #$EFFF : STA.b $08

    .BRANCH_DELTA

    JSR.w DungeonMap_DrawFloorNumbersByRoom
    JSR.w DungeonMap_DrawBorderForRooms
    JSR.w DungeonMap_DrawDungeonLayout
    
    DEC.w $020E
    
    REP #$30
    
    LDA.w #$0300 : STA.b $06
    
    ; OPTIMIZE: Useless branches.
    LDA.w $0211 : BNE .BRANCH_EPSILON
        BRA .BRANCH_EPSILON

    .BRANCH_EPSILON

    LDA.w $020E : AND.w #$0050 : BNE .BRANCH_ZETA
        LDA.w #$EFFF : STA.b $08
        
        BRA .BRANCH_THETA

    .BRANCH_ZETA

    LDA.w #$EFFF : STA.b $08

    .BRANCH_THETA

    JSR.w DungeonMap_DrawFloorNumbersByRoom
    JSR.w DungeonMap_DrawBorderForRooms
    JSR.w DungeonMap_DrawDungeonLayout
    
    REP #$30
    
    INC.w $020E
    
    STZ.b $06
    
    SEP #$30
    
    LDA.b #$08 : STA.b $17
    
    LDA.b #$22 : STA.w $0116
    
    INC.w $020D
    
    PLB
    
    RTL
}

; ==============================================================================

; $056429-$056448 DATA
Pool_DungeonMap_DrawBorderForRooms:
{
    ; $056429
    .tiles_corner
    dw $1F19, $5F19, $9F19, $DF19

    ; $056431
    .tiles_corner_address
    dw $00E2, $00F8, $03A2, $03B8

    ; $056439
    .tiles_vertical_border
    dw $1F1A, $9F1A

    ; $05643D
    .tiles_vertical_border_address
    dw $00E4, $03A4

    ; $056441
    .tiles_horizontal_border
    dw $1F1B, $5F1B

    ; $056445
    .tiles_horizontal_border_address
    dw $0122, $0138
}
    
; $056449-$0564E8 LOCAL JUMP LOCATION
DungeonMap_DrawBorderForRooms:
{
    REP #$30
    
    STZ.b $02

    .BRANCH_ALPHA

        LDY.b $02
        LDA.w Pool_DungeonMap_DrawBorderForRooms_tiles_corner_address, Y
        CLC : ADC.b $06 : AND.w #$0FFF : TAX
        
        LDA.w #$0F00 : STA.l $7F0000, X
        
        LDA.w Pool_DungeonMap_DrawBorderForRooms_tiles_corner, Y : AND.b $08 : STA.l $7F0000, X
        
        INC.b $02 : INC.b $02
    LDA.b $02 : CMP.w #$0008 : BNE .BRANCH_ALPHA
    
    LDY.w #$0000

    .BRANCH_GAMMA

        STZ.b $02
        
        LDA.w Pool_DungeonMap_DrawBorderForRooms_tiles_vertical_border_address, Y : CLC : ADC.b $06 : STA.b $04

        .BRANCH_BETA

            LDA.b $04 : CLC : ADC.b $02 : AND.w #$0FFF : TAX
            
            LDA.w #$0F00 : STA.l $7F0000, X
            
            LDA.w Pool_DungeonMap_DrawBorderForRooms_tiles_vertical_border, Y
            AND.b $08 : STA.l $7F0000, X
        INC.b $02 : INC.b $02 : LDA.b $02 : CMP.w #$0014 : BNE .BRANCH_BETA
    INY #2 : CPY.w #$0004 : BNE .BRANCH_GAMMA
    
    LDY.w #$0000

    .BRANCH_EPSILON

        STZ.b $02
        
        LDA.w Pool_DungeonMap_DrawBorderForRooms_tiles_horizontal_border_address, Y
        CLC : ADC.b $06 : STA.b $04

        .BRANCH_DELTA

            LDA.b $04 : CLC : ADC.b $02 : AND.w #$0FFF : TAX
            
            LDA.w #$0F00 : STA.l $7F0000, X
            
            LDA.w Pool_DungeonMap_DrawBorderForRooms_tiles_horizontal_border, Y
            AND.b $08 : STA.l $7F0000, X
        LDA.b $02 : CLC : ADC.w #$0040 : STA.b $02 : CMP.w #$0280 : BNE .BRANCH_DELTA
    INY #2 : CPY.w #$0004 : BNE .BRANCH_EPSILON
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0564E9-$0564F8 DATA
Pool_DungeonMap_DrawFloorNumbersByRoom:
{
    .floor_numbers
    dw $1F1E ; 1
    dw $1F1F ; 2
    dw $1F20 ; 3
    dw $1F21 ; 4
    dw $1F22 ; 5
    dw $1F23 ; 6
    dw $1F24 ; 7
    dw $1F25 ; 8
}

; $0564F9-$05656E LOCAL JUMP LOCATION
DungeonMap_DrawFloorNumbersByRoom:
{
    REP #$30
    
    LDA.w #$00DE : STA.b $00

    .BRANCH_ALPHA

        LDA.b $00 : CLC : ADC.b $06 : AND.w #$0FFF : TAX
        
        LDA.w #$0F00 : STA.l $7F0000, X : STA.l $7F0002, X
    LDA.b $00 : CLC : ADC.w #$0040 : STA.b $00
    CMP.w #$039E : BNE .BRANCH_ALPHA
    
    LDA.w $020E : AND.w #$0080 : BEQ .BRANCH_BETA
        LDA.w #$1F1C
        
        BRA .BRANCH_GAMMA

    .BRANCH_BETA

    LDA.w $020E : AND.w #$000F : ASL A : TAY
    
    LDA.w Pool_DungeonMap_DrawFloorNumbersByRoom_floor_numbers, Y

    .BRANCH_GAMMA

    PHA
    
    LDA.w #$035E : CLC : ADC.b $06 : AND.w #$0FFF : TAX
    
    PLA : AND.b $08 : STA.l $7F0000, X
    
    LDA.w $020E : AND.w #$0080 : BEQ .BRANCH_DELTA
        LDA.w $020E : AND.w #$00FF : EOR.w #$00FF : ASL A : TAY
        
        LDA.w Pool_DungeonMap_DrawFloorNumbersByRoom_floor_numbers, Y
        
        BRA .BRANCH_EPSILON

    .BRANCH_DELTA

    LDA.w #$1F1D

    .BRANCH_EPSILON

    AND.b $08 : STA.l $7F0002, X
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $05656F-$056578 DATA
DungeonMap_DrawDungeonLayout_row_offset:
{
    dw $0124, $01A4, $0224, $02A4, $0324
}

; Draws a 5x5 floor grid for the map?
; $056579-$056599 LOCAL JUMP LOCATION
DungeonMap_DrawDungeonLayout:
{
    REP #$30
    
    STZ.b $00

    .nextRow

        LDA.b $00 : ASL A : TAX
        
        LDA.w .row_offset, X : CLC : ADC.b $06 : AND.w #$0FFF : TAX
        
        JSR.w DungeonMap_DrawSingleRowOfRooms
        
        INC.b $00
    LDA.b $00 : CMP.w #$0005 : BNE .nextRow
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $05659A-$0565BB DATA
Pool_DungeonMap_DrawSingleRowOfRooms:
{
    ; $05659A
    .row_draw_offset
    dw $0000, $0005, $000A, $000F, $0014
    
    ; $0565A4
    .unused
    dw $0000, $0032, $0064, $0096
    dw $00C8, $00FA, $012C, $015E
    dw $0190, $0300, $0B00, $0F00
}

; $0565BC-$0567F2 LOCAL JUMP LOCATION
DungeonMap_DrawSingleRowOfRooms:
{
    REP #$30
    
    STZ.b $02

    .nextColumn

        STZ.b $0E
        
        PHX
        
        LDA.b $00 : ASL A : TAX
        
        ; $04 = column * 5.
        LDA.b $02
        ADC.w Pool_DungeonMap_DrawSingleRowOfRooms_row_draw_offset, X : STA.b $04
        
        SEP #$20
        
        LDX.w $040C
        
        ; I think this is trying to figure out the current floor against
        ; the deepest depth of the current palace.
        LDA.w DungeonMapFloorCountData, X : AND.b #$0F
        CLC : ADC.w $020E : ASL A : STA.b $0E
        TAY
        
        REP #$20
        
        LDA.w DungeonMapRoomPointers, X : STA.b $0C
        
        ; Y = (???? * 0x19) + $04.
        LDA.w DungeonMapFloorToDataOffset, Y : CLC : ADC.b $04 : TAY
        
        SEP #$20
        
        ; 0x0F incdiates a blank room in the map, or so it would seem.
        LDA ($0C), Y : CMP.b #$0F : BNE .BRANCH_ALPHA
            REP #$20
            
            LDA.w #$0051
            
            BRA .BRANCH_BETA

        .BRANCH_ALPHA

        REP #$20
        
        AND.w #$00FF : STA.b $CA
        
        ASL A : PHA
        
        LDA.b $CA : ASL A : TAX
        
        ; $0E = the quadrants Link has visited.
        LDA.l $7EF000, X : AND.w #$000F : STA.b $0E
        
        PLA
        
        BRA .BRANCH_ULTIMA

        .BRANCH_BETA

        ASL #3 : TAY
        
        BRA .BRANCH_GAMMA

        .BRANCH_ULTIMA

        STZ.b $C8
        
        LDY.w #$0000
        
        LDX.w $040C : LDA.w DungeonMapRoomPointers, X : STA.b $0C

        .BRANCH_ALIF

        SEP #$20
        
        LDA ($0C), Y : CMP.b #$0F : BNE .BRANCH_OPTIMUS
            INY
            
            BRA .BRANCH_ALIF

        .BRANCH_OPTIMUS

        CMP.b $CA : BEQ .BRANCH_BET
            INC.b $C8
            
            INY
                
            BRA .BRANCH_ALIF

        .BRANCH_BET

        REP #$20
        
        LDA.w DungeonMapRoomLayoutPointers, X : STA.b $0C
        
        LDA.b $C8 : TAY
        
        SEP #$20
        
        LDA ($0C), Y
        
        REP #$20
        
        ASL #3 : TAY

        .BRANCH_GAMMA

        PLX
        
        LDA.w DungeonMap_RoomTemplates, Y : STA.b $0C : PHA
        CMP.w #$0B00 : BEQ .BRANCH_DELTA
            ; Check if top left quadrant has been seen.
            LDA.b $0E : AND.w #$0008 : BNE .BRANCH_DELTA
                LDA.b $0C : AND.w #$1000 : BNE .BRANCH_EPSILON
                    LDA.w #$0400 : STA.b $0C
                    
                    BRA .BRANCH_ZETA

                .BRANCH_EPSILON

                PHX
                
                LDX.w $040C
                
                ; Check if Link has the map.
                LDA.l $7EF368 : AND.l DungeonMask, X : BEQ .BRANCH_DEL
                    PLX : PLA
                    
                    LDA.b $0C : AND.w #$E3FF : ORA.w #$0C00
                    
                    BRA .BRANCH_THEL

                .BRANCH_DEL

                PLX

        .BRANCH_DELTA

        STZ.b $0C

        .BRANCH_ZETA
        
        PLA : CLC : ADC.b $0C : PHX : STA.b $0C
        
        LDX.w $040C
        
        ; Check if Link has the map.
        LDA.l $7EF368 : AND.l DungeonMask, X : BNE .BRANCH_THETA
            LDA.b $0E : AND.w #$0008 : BNE .BRANCH_THETA
                LDA.w #$0B00
                
                BRA .BRANCH_IOTA

        .BRANCH_THETA

        LDA.b $0C

        .BRANCH_IOTA

        PLX

        .BRANCH_THEL

        STA.l $7F0000, X
        
        LDA.w DungeonMap_RoomTemplates+2, Y : STA.b $0C : PHA
        CMP.w #$0B00 : BEQ .BRANCH_KAPPA
            ; Check if top right quadrant has been seen.
            LDA.b $0E : AND.w #$0004 : BNE .BRANCH_KAPPA
                LDA.b $0C : AND.w #$1000 : BNE .BRANCH_LAMBDA
                    LDA.w #$0400 : STA.b $0C
                    
                    BRA .BRANCH_MU

                .BRANCH_LAMBDA

                PHX

                LDX.w $040C
                
                ; Check if Link has the map.
                LDA.l $7EF368 : AND.l DungeonMask, X : BEQ .BRANCH_SIN
                    PLX : PLA
                    
                    LDA.b $0C : AND.w #$E3FF : ORA.w #$0C00
                    
                    BRA .BRANCH_SHIN

                .BRANCH_SIN

                PLX

        .BRANCH_KAPPA

        STZ.b $0C

        .BRANCH_MU

        ; PHX in the middle... whatever. But it's an eyesore.
        PLA : CLC : ADC.b $0C : PHX : STA.b $0C
        
        LDX.w $040C
        
        ; Check if we have the map for this dungeon.
        LDA.l $7EF368 : AND.l DungeonMask, X : BNE .BRANCH_NU
            LDA.b $0E : AND.w #$0004 : BNE .BRANCH_NU
                LDA.w #$0B00
                
                BRA .BRANCH_XI

        .BRANCH_NU

        LDA.b $0C

        .BRANCH_XI

        PLX

        .BRANCH_SHIN

        STA.l $7F0002, X
        
        LDA.w DungeonMap_RoomTemplates+4, Y : STA.b $0C : PHA
        CMP.w #$0B00 : BEQ .BRANCH_OMICRON
            LDA.b $0E : AND.w #$0002 : BNE .BRANCH_OMICRON
                LDA.b $0C : AND.w #$1000 : BNE .BRANCH_PI
                    LDA.w #$0400 : STA.b $0C
                    
                    BRA .BRANCH_RHO

                .BRANCH_PI

                PHX
                
                LDX.w $040C
                
                ; Check if we have the map... again.
                LDA.l $7EF368 : AND.l DungeonMask, X : BEQ .BRANCH_SOD
                    PLX : PLA
                    
                    LDA.b $0C : AND.w #$E3FF : ORA.w #$0C00
                    
                    BRA .BRANCH_DOD

                .BRANCH_SOD

                PLX

        .BRANCH_OMICRON

        STZ.b $0C

        .BRANCH_RHO

        PLA : CLC : ADC.b $0C : PHX : STA.b $0C
        
        LDX.w $040C
        
        LDA.l $7EF368 : AND.l DungeonMask, X : BNE .BRANCH_SIGMA
            LDA.b $0E : AND.w #$0002 : BNE .BRANCH_SIGMA
                LDA.w #$0B00
                
                BRA .BRANCH_TAU

        .BRANCH_SIGMA

        LDA.b $0C

        .BRANCH_TAU

        PLX

        .BRANCH_DOD

        STA.l $7F0040, X
        
        LDA.w DungeonMap_RoomTemplates+6, Y : STA.b $0C : PHA
        CMP.w #$0B00 : BEQ .BRANCH_UPSILON
            LDA.b $0E : AND.w #$0001 : BNE .BRANCH_UPSILON
                LDA.b $0C : AND.w #$1000 : BNE .BRANCH_PHI
                    LDA.w #$0400 : STA.b $0C
                    
                    BRA .BRANCH_CHI

                .BRANCH_PHI

                PHX
                
                LDX.w $040C
                
                ; Check if Link has the map.
                LDA.l $7EF368 : AND.l DungeonMask, X : BEQ .BRANCH_TOD
                    PLX : PLA
                    
                    LDA.b $0C : AND.w #$E3FF : ORA.w #$0C00
                    
                    BRA .BRANCH_ZOD

                .BRANCH_TOD

                PLX

        .BRANCH_UPSILON

        STZ.b $0C

        .BRANCH_CHI

        PLA : CLC : ADC.b $0C : PHX : STA.b $0C

        LDX.w $040C
        
        ; Check if Link has the map.
        LDA.l $7EF368 : AND.l DungeonMask, X : BNE .BRANCH_PSI
            LDA.b $0E : AND.w #$0001 : BNE .BRANCH_PSI
                LDA.w #$0B00
                
                BRA .BRANCH_OMEGA

        .BRANCH_PSI

        LDA.b $0C

        .BRANCH_OMEGA

        PLX

        .BRANCH_ZOD

        STA.l $7F0042, X
        
        INX #4
        
        INC.b $02
        
        LDA.b $02 : CMP.w #$0005 : BEQ .BRANCH_ALTIMA
    JMP .nextColumn

    .BRANCH_ALTIMA

    RTS
}

; ==============================================================================

; $0567F3-$0567F6 DATA
DungeonMapRoomMarkerYBase:
{
    dw $001F, $007F
}

; $0567F7-$056806 DATA
Pool_DungeonMap_DrawRoomMarkers:
{
    ; $0567F7
    .offset_x_base
    dw $0090

    ; $0567F9
    .fairy_rooms
    dw $0089 ; ROOM 0089 - Eastern fairy room
    dw $00A7 ; ROOM 00A7 - Hera fairy room
    dw $004F ; ROOM 004F - Ice Palace fairy room

    ; $0567FF
    .fairy_room_replacements
    dw $00A9 ; ROOM 00A9 - Eastern big chest room
    dw $0077 ; ROOM 0077 - Hera lobby
    dw $00BE ; ROOM 00BE - Ice Palace block switch room

    ; $056805
    .floor_threshold
    dw $0004
}

; $056807-$056822 DATA
DungeonMapBossRooms:
{
    dw $000F ; ROOM 000F - Sewers: none
    dw $000F ; ROOM 000F - Castle: none
    dw $00C8 ; ROOM 00C8 - Eastern
    dw $0033 ; ROOM 0033 - Desert
    dw $0020 ; ROOM 0020 - Agahnim's tower
    dw $0006 ; ROOM 0006 - Swamp palace
    dw $005A ; ROOM 005A - Palace of Darkness
    dw $0090 ; ROOM 0090 - Misery Mire
    dw $0029 ; ROOM 0029 - Skull Woods
    dw $00DE ; ROOM 00DE - Ice Palace
    dw $0007 ; ROOM 0007 - Tower of Hera
    dw $00AC ; ROOM 00AC - Thieves' Town
    dw $00A4 ; ROOM 00A4 - Turtle Rock
    dw $000D ; ROOM 000D - Ganon's tower
}

; $056823-$056953 JUMP LOCATION (LONG)
DungeonMap_DrawRoomMarkers:
{
    PHB : PHK : PLB
    
    REP #$10
    
    LDA.b #$00 : XBA
    
    LDX.w $040C
    LDA.w DungeonMapFloorCountData, X : AND.b #$0F : CLC : ADC.b $A4 : ASL A : TAY : STY.b $0C
    
    REP #$20
    
    STZ.b $00 : STZ.b $02
    
    PHY
    
    LDY.w Pool_DungeonMap_DrawRoomMarkers_floor_threshold
    
    ; This loop is searching for rooms that you can fall into that are out
    ; of the way (secret locations you can get to by falling through
    ; pots in the Tower of Hera or Eastern Palace.
    LDA.b $A0

    .secretRoomLoop

        CMP.w Pool_DungeonMap_DrawRoomMarkers_fairy_rooms, Y : BEQ .isSecretRoom
    DEY #2 : BPL .secretRoomLoop
    
    BRA .notSecretRoom

    .isSecretRoom

    ; Substitute a different room to use in the case that we're in a secret
    ; room.
    LDA.w Pool_DungeonMap_DrawRoomMarkers_fairy_room_replacements, Y

    .notSecretRoom

    STA.b $0E
    
    PLY
    
    LDA.w DungeonMapRoomPointers, X : STA.b $04
    
    LDA.w DungeonMapFloorToDataOffset, Y : TAY
    
    SEP #$20

    ; This loop tries to locate the current (or substituted) room in the
    ; palace's map data.
    .BRANCH_ZETA
    
    LDA ($04), Y : INY : CMP.b $0E : BEQ .BRANCH_DELTA
        LDA.b $00 : CMP.b #$40 : BCC .BRANCH_EPSILON
            STZ.b $00
            
            LDA.b $02 : CLC : ADC.b #$10 : STA.b $02
            
            BRA .BRANCH_ZETA

        .BRANCH_EPSILON

        CLC : ADC.b #$10 : STA.b $00
        
        BRA .BRANCH_ZETA

    .BRANCH_DELTA

    REP #$20
    
    LDA.b $00
    CLC : ADC.w Pool_DungeonMap_DrawRoomMarkers_offset_x_base : STA.w $0215
    
    LDA.b $22 : AND.w #$01E0 : ASL #3 : XBA : CLC : ADC.w $0215 : STA.w $0215
    
    LDY.w $0211
    
    LDA.b $02 : STA.w $0CF5
    CLC : ADC.w DungeonMapRoomMarkerYBase, Y : STA.w $0217
    
    LDA.b $20 : AND.w #$01E0 : ASL #3 : XBA : CLC : ADC.w $0217 : STA.w $0217
        
    SEP #$20
    
    LDA.b #$00 : XBA
    
    LDA.w DungeonMapFloorCountData, X
    AND.b #$0F : CLC : ADC.w DungeonMap_BossRoomFloor, X
    
    REP #$20
    
    ASL A : TAY
    
    LDA.w DungeonMapRoomPointers, X
    CLC : ADC.w DungeonMapFloorToDataOffset, Y : STA.b $0E
    
    SEP #$20
    
    LDA.b #$40 : STA.w $0FA8 : STZ.w $0FA9
                 STA.w $0FAA : STZ.w $0FAB
    
    LDY.w #$0018

    .BRANCH_LAMBDA

        LDA ($0E), Y : CMP.b #$0F : BEQ .BRANCH_THETA
            CMP.w DungeonMapBossRooms, X : BEQ .BRANCH_IOTA

        .BRANCH_THETA

        LDA.w $0FA8 : SEC : SBC.b #$10 : STA.w $0FA8 : BPL .BRANCH_KAPPA
            LDA.b #$40 : STA.w $0FA8
            
            LDA.w $0FAA : SEC : SBC.b #$10 : STA.w $0FAA

        .BRANCH_KAPPA
    DEY : BPL .BRANCH_LAMBDA

    .BRANCH_IOTA

    STZ.b $02
    STZ.b $0F
    
    LDA.w $020E : SEC : SBC.w DungeonMap_BossRoomFloor, X : STA.b $0E
    BPL .BRANCH_MU
        EOR.b #$FF : INC A : STA.b $0E
        
        INC.b $02 : INC.b $02

    .BRANCH_MU

    SEP #$10
    
    LDY.b $02
    
    REP #$20

    .BRANCH_XI

    DEC.b $0E : BMI .BRANCH_NU
        LDA.w $0FAA : CLC : ADC.w DungeonMap_PanValues, Y : STA.w $0FAA
        
        BRA .BRANCH_XI

    .BRANCH_NU

    LDA.w $0FAA : CLC : ADC.w DungeonMapRoomMarkerYBase : STA.w $0FAA
    
    SEP #$20
    
    INC.w $0200
    
    STZ.b $13
    STZ.w $020D
    
    PLB
    
    RTL
}

; ==============================================================================

; $056954-$05695A JUMP LOCATION
DungeonMap_3:
{
    JSL.l DungeonMap_HandleInput
    JMP.w DungeonMap_DrawSprites
}

; ==============================================================================

; $05695B-$056974 LONG JUMP LOCATION
DungeonMap_HandleInput:
{
    PHB : PHK : PLB
    
    ; Unless the depressed button is X, continue.
    LDA.b $F6 : AND.b #$40 : BNE .exitPalaceMapMode
        JSL.l DungeonMap_HandleMovementInput
        
        PLB
        
        RTL

    .exitPalaceMapMode
    
    ; In this case, we need come out of map mode.

    INC.w $0200 : INC.w $0200
    
    STZ.w $020D
    
    PLB
    
    RTL
}

; ==============================================================================

; $056975-$056978 DATA
DungeonMap_PanValues:
{
    dw $0060, $FFA0
}

; $056979-$056985 LONG JUMP LOCATION
DungeonMap_HandleMovementInput:
{
    JSL.l DungeonMap_HandleFloorSelect
    
    LDA.w $0210 : BEQ .notScrolling
        JMP PalaceMap_Scroll

    .notScrolling

    RTL
}

; ==============================================================================

; $056986-$056A76 LONG JUMP LOCATION
DungeonMap_HandleFloorSelect:
{
    REP #$30
    
    LDX.w $040C
    LDA.w DungeonMapFloorCountData, X : AND.w #$00F0 : LSR #4 : STA.b $00
    
    LDA.w DungeonMapFloorCountData, X : AND.w #$000F : CLC : ADC.b $00 : CMP.w #$0003 : BMI .BRANCH_ALPHA
        SEP #$30
        
        LDA.w $0210 : BNE .BRANCH_ALPHA
            ; BYSTudlr -> ----ud--
            LDA.b $F0 : AND.b #$0C : BNE .BRANCH_BETA

    .BRANCH_ALPHA

    JMP.w DungeonMap_HandleFloorSelect_proceed_to_exit

    .BRANCH_BETA

    STA.b $0A
    
    STZ.w $020F
    
    AND.b #$08 : BEQ .BRANCH_GAMMA
        REP #$30
        
        LDX.w $040C
        LDA.w DungeonMapFloorCountData, X : AND.w #$00F0 : LSR #4 : DEC A : CMP.w $020E : BNE .BRANCH_DELTA
            JMP.w DungeonMap_HandleFloorSelect_proceed_to_exit

        .BRANCH_DELTA

        INC.w $020E
        
        LDA.b $06 : SEC : SBC.w #$0300 : AND.w #$0FFF : STA.b $06
        
        BRA .BRANCH_EPSILON

    .BRANCH_GAMMA

    REP #$30
    
    LDX.w $040C
    LDA.w DungeonMapFloorCountData, X : AND.w #$000F : EOR.w #$00FF : INC #2 : AND.w #$00FF : CMP.w $020E : BEQ .proceed_to_exit
        DEC.w $020E : DEC.w $020E
        
        LDA.b $06 : CLC : ADC.w #$0600 : AND.w #$0FFF : STA.b $06

        .BRANCH_EPSILON

        SEP #$20
        
        LDA.w $020E : CMP.b $A4 : BNE .BRANCH_ZETA
            REP #$20
            
            BRA .BRANCH_THETA

        .BRANCH_ZETA

        BMI .BRANCH_NU
            REP #$20
            
            BRA .BRANCH_THETA

        .BRANCH_NU

        REP #$20

        .BRANCH_THETA

        LDA.w $020E : AND.w #$0080 : BNE .BRANCH_IOTA
            LDA.w #$EFFF : STA.b $08
            
            BRA .BRANCH_KAPPA

        .BRANCH_IOTA

        LDA.w #$EFFF : STA.b $08

        .BRANCH_KAPPA

        SEP #$20
        
        JSR.w DungeonMap_DrawFloorNumbersByRoom
        JSR.w DungeonMap_DrawBorderForRooms
        JSR.w DungeonMap_DrawDungeonLayout
        
        SEP #$20
        
        INC.w $0210
        
        LDA.b $0A : AND.b #$08 : LSR #2 : TAX
        
        REP #$30
        
        LDA.b $E8 : CLC : ADC.w DungeonMap_PanValues, X : STA.w $0213
        
        LDA.b $0A : AND.w #$0008 : BNE .BRANCH_LAMBDA
            LDA.b $06 : SEC : SBC.w #$0300 : AND.w #$0FFF : STA.b $06
            
            INC.w $020E
        
        .BRANCH_LAMBDA
        
        SEP #$20
        
        LDA.b #$08 : STA.b $17
    
    ; $056A75 ALTERNATE ENTRY POINT
    .proceed_to_exit
    
    BRA PalaceMap_Scroll_easyOut
}

; ==============================================================================

; $056A77-$056A7E DATA
Pool_DungeonMap_ScrollFloors:
Pool_PalaceMap_Scroll:
{
    .speed_bg
    dw   4 ; Down
    dw  -4 ; Up
    
    ; $056A7B
    .speed_sprites
    dw  -4 ; Down
    dw   4 ; Up
}

; $056A7F-$056AB1 JUMP LOCATION (LONG)
PalaceMap_Scroll:
{
    REP #$30
    
    ; $0A is direction?
    LDA.b $0A : AND.w #$0008 : LSR #2 : TAX
    
    LDA.w $0217 : CLC : ADC .speed_sprites, X : STA.w $0217
    LDA.w $0FAA : CLC : ADC .speed_sprites, X : STA.w $0FAA
    
    LDA.b $E8 : CLC : ADC .speed_bg, X : STA.b $E8
    CMP.w $0213 : BNE .notDoneScrolling
        SEP #$20
        
        STZ.w $0210

    .notDoneScrolling

    ; $056AAF ALTERNATE ENTRY POINT
    .easyOut

    SEP #$30
    
    RTL
}

; ==============================================================================

; $056AB2-$056AED JUMP LOCATION (LONG)
DungeonMap_DrawSprites:
{
    PHB : PHK : PLB
    
    REP #$10
    
    LDX.w $040C : LDA.w DungeonMapFloorCountData, X : AND.b #$0F : STA.b $02
    
    CLC : ADC.b $A4 : STA.b $01 : STA.b $03
    
    SEP #$10
    
    STZ.b $00
    STZ.b $0E
    
    JSR.w PalaceMap_DrawPlayerFloorIndicator
    
    INC.b $00

    .BRANCH_ALPHA

        JSR.w DungeonMap_DrawLocationMarker
        
        INC.b $0E
    LDA.b $00 : CMP.b #$09 : BNE .BRANCH_ALPHA
    
    JSR.w DungeonMap_DrawBlinkingIndicator
    
    INC.b $00
    
    JSR.w DungeonMap_DrawBossIcon
    JSR.w DungeonMap_DrawFloorNumberObjects
    JSR.w DungeonMap_DrawFloorBlinker
    
    PLB
    
    RTL
}

; ==============================================================================

; $056AEE-$056AEE DATA
Pool_PalaceMap_DrawPlayerFloorIndicator:
{
    .x_offset
    db $19
}
    
; ==============================================================================

; $056AEF-$056AEF DATA
Pool_PalaceMap_DrawBossFloorIndicator:
{
    .x_offset
    db $4C
}
    
; ==============================================================================

; $056AF0-$056B3F LOCAL JUMP LOCATION
PalaceMap_DrawPlayerFloorIndicator:
{
    REP #$10
    
    LDA.b #$04 : SEC : SBC.b $02 : BMI .BRANCH_ALPHA
        CLC : ADC.b $03 : STA.b $03
        
        LDA.w DungeonMapFloorCountData, X : LSR #4 : SEC : SBC.b #$04 : BMI .BRANCH_ALPHA
            SEC : SBC.b $03 : EOR.b #$FF : INC A : STA.b $03

    .BRANCH_ALPHA

    SEP #$10
    
    LDX.b $00
    
    LDA.b #$02 : STA.w $0A20, X
    
    TXA : ASL #2 : TAX
    
    LDA.w .x_offset : STA.w $0800, X
    
    LDY.b $03
    
    LDA.w FloorIconOffsetY, Y : SEC : SBC.b #$04 : STA.w $0801, X
    STZ.w $0802, X
    
    LDA.b #$3E
    
    LDY.w $0ABD : BEQ .playerPaletteSwapped
        LDA.b #$30

    .playerPaletteSwapped

    STA.w $0803, X
    
    RTS
}

; ==============================================================================

; $056B40-$056B4F DATA
Pool_DungeonMap_DrawBlinkingIndicator:
{
    ; $056B40
    .tile
    db $34, $35, $36, $34
    db $31, $32, $33, $32

    ; $056B48
    .prop
    db $39, $3B, $3D, $3B
    db $3B, $3B, $3B, $3B
}

; This is the little blinking red/yellow/white dot that shows link's exact
; position in the map.
; $056B50-$056B89 LOCAL JUMP LOCATION
DungeonMap_DrawBlinkingIndicator:
{
    LDX.b $00
    
    LDA.b #$00 : STA.w $0A20, X
    
    TXA : ASL #2 : TAX
    
    LDA.w $0215 : SEC : SBC.b #$03 : STA.w $0800, X
    
    LDA.w $0218 : BEQ .BRANCH_ALPHA
        LDA.b #$F0 : BRA .BRANCH_BETA

    .BRANCH_ALPHA

    LDA.w $0217

    .BRANCH_BETA

    SEC : SBC.b #$03 : STA.w $0801, X
    
    LDA.b $1A : AND.b #$0C : LSR #2 : TAY
    
    LDA.w Pool_DungeonMap_DrawBlinkingIndicator_tile    : STA.w $0802, X
    LDA.w Pool_DungeonMap_DrawBlinkingIndicator_prop, Y : STA.w $0803, X
    
    RTS
}

; ==============================================================================

; $056B8A-$056BA7 DATA
Pool_DungeonMap_DrawLocationMarker:
{
    ; $056B8A
    .offset_x
    db  -9 ; Top left
    db   8 ; Top right
    db  -9 ; Bottom left
    db   8 ; Bottom right

    ; $056B8E
    .offset_y
    db  -8 ; Top left
    db  -8 ; Top right
    db   9 ; Bottom left
    db   9 ; Bottom right

    ; $056B92
    .props
    db $F1 ; Top left
    db $B1 ; Top right
    db $71 ; Bottom left
    db $31 ; Bottom right

    ; $056B96
    .palette_flash
    db $0C, $0C
    db $08, $0A

    ; $056B9A
    .unsued
    dw $0000, $0060, $00C0, $0120
    dw $0180, $01E0, $0240
}

; This is the blinking white/red box on the grid in the dungeon map.
; $056BA8-$056C09 LOCAL JUMP LOCATION
DungeonMap_DrawLocationMarker:
{
    LDY.b #$03

    .BRANCH_BETA

        LDA.b $00 : TAX
        
        LDA.b #$02 : STA.w $0A20, X
        
        TXA : ASL #2 : TAX
        
        LDA.w $0215 : AND.b #$F0
        CLC : ADC.w Pool_DungeonMap_DrawLocationMarker_offset_x, Y
        STA.w $0800, X
        
        PHY
        
        LDA.b $0E : ASL A : TAY
        
        LDA.w $0CF5 : CLC : ADC.w DungeonMapRoomMarkerYBase, Y : STA.b $0F
        
        PLY
        
        CLC : ADC.w Pool_DungeonMap_DrawLocationMarker_offset_y, Y
        STA.w $0801, X
        
        STZ.w $0802, X
        
        LDA.w Pool_DungeonMap_DrawLocationMarker_props, Y : STA.b $0C 
        
        PHY
        
        LDA.b $1A : LSR #2 : AND.b #$01 : TAY
        
        INC.b $0F
        
        LDA.w $0217 : INC A : AND.b #$F0 : CMP.b $0F : BNE .BRANCH_ALPHA
            LDA.w $0218 : BNE .BRANCH_ALPHA
                INY #2

        .BRANCH_ALPHA

        LDA.b $0C : ORA.w Pool_DungeonMap_DrawLocationMarker_palette_flash, Y
        STA.w $0803, X
        
        PLY
        
        INC.b $00
    DEY : BPL .BRANCH_BETA
    
    RTS
}

; $056C0A-$056CBD LOCAL JUMP LOCATION
DungeonMap_DrawFloorNumberObjects:
{
    REP #$10
    
    LDX.w $040C : LDA.w DungeonMapFloorCountData, X : PHA : LSR #4 : STA.b $02
    
    PLA : AND.b #$0F : STA.b $03
    
    SEP #$10
    
    LDY.b #$07
    
    LDA.b $02 : CLC : ADC.b $03 : CMP.b #$08 : BEQ .BRANCH_ALPHA
        LDA.b $02 : CMP.b #$04 : BPL .BRANCH_ALPHA
            DEY
            
            LDX.b #$03 : STX.b $04

            .BRANCH_GAMMA

            CMP.b $04 : BEQ .BRANCH_BETA
                DEY
                
                DEC.b $04 : BNE .BRANCH_GAMMA

            .BRANCH_BETA

            LDA.b $03 : CMP.b #$05 : BMI .BRANCH_ALPHA
                LDX.b #$05 : STX.b $04

                .BRANCH_DELTA

                    CMP.b $04 : BEQ .BRANCH_ALPHA
                        INY
                        
                        INC.b $04
                CMP.b #$08 : BNE .BRANCH_DELTA

    .BRANCH_ALPHA

    LDA.w FloorIconOffsetY, Y : INC A : STA.b $04
    
    DEC.b $02
    
    LDA.b $03 : EOR.b #$FF : INC A : STA.b $03

    .BRANCH_THETA

        LDX.b $00
        
        LDA.b #$00 : STA.w $0A20, X : STA.w $0A21, X
        
        TXA : ASL #2 : TAX
        
        LDA.b #$30 : STA.w $0800, X
        LDA.b #$38 : STA.w $0804, X
        
        LDA.b $04 : STA.w $0801, X : STA.w $0805, X
        
        CLC : ADC.b #$10 : STA.b $04
        
        LDA.b #$3D : STA.w $0803, X : STA.w $0807, X
        LDA.b #$1C : STA.w $0802, X
        LDA.b #$1D : STA.w $0806, X
        
        LDY.b $02 : BMI .BRANCH_EPSILON
            LDA.w FloorNumberOAMChar, Y : STA.w $0802, X
            
            BRA .BRANCH_ZETA

        .BRANCH_EPSILON

        TYA : EOR.b #$FF : TAY
        
        LDA.w FloorNumberOAMChar, Y : STA.w $0806, X

        .BRANCH_ZETA

        INC.b $00 : INC.b $00
        
        DEC.b $02
    LDA.b $02 : INC A : CMP.b $03 : BNE .BRANCH_THETA
    
    RTS
}

; ==============================================================================

; $056CBE-$056CC5 DATA
FloorIconOffsetY:
{
    db $BB
    db $AB
    db $9B
    db $8B
    db $7B
    db $6B
    db $5B
    db $4B
}

; $056CC6-$056CCD DATA
FloorNumberOAMChar:
{
    db $1E ; 1
    db $1F ; 2
    db $20 ; 3
    db $21 ; 4
    db $22 ; 5
    db $23 ; 6
    db $24 ; 7
    db $25 ; 8
}

; $056CCE-$056CCE DATA
FloorNumberBlinkProps:
{
    db $3D
}

; $056CCF-$056D4D LOCAL JUMP LOCATION
DungeonMap_DrawFloorBlinker:
{
    LDA.b $00 : STA.b $05
    
    LDA.w $020E : STA.b $03
    
    LDY.b #$00
    
    REP #$10
    
    LDX.w $040C : LDA.w DungeonMapFloorCountData, X : LSR #4 : STA.b $02
    
    LDA.w DungeonMapFloorCountData, X : AND.b #$0F
    
    SEP #$10
    
    CLC : ADC.b $02 : CMP.b #$01 : BEQ .BRANCH_ALPHA
        INC.b $05 : INC.b $05
        DEC.b $03
        
        LDY.b #$01

    .BRANCH_ALPHA

    STY.b $02

    .BRANCH_DELTA

        LDX.b $02 : LDA.w FloorNumberBlinkProps : STA.b $0E, X
        
        REP #$10
        
        LDX.w $040C : LDA.w DungeonMapFloorCountData, X : AND.b #$0F : STA.b $01
        CLC : ADC.b $03 : STA.b $00
        
        LDA.b #$04 : SEC : SBC.b $01 : BMI .BRANCH_BETA
            CLC : ADC.b $00 : STA.b $00
            
            LDA.w DungeonMapFloorCountData, X : LSR #4 : SEC : SBC.b #$04 : BMI .BRANCH_BETA
                SEC : SBC.b $00 : EOR.b #$FF : INC A : STA.b $00

        .BRANCH_BETA

        SEP #$10
        
        DEC.b $05 : DEC.b $05
        
        INC.b $03
        
        DEC.b $02 : BMI .BRANCH_GAMMA
    BRL .BRANCH_DELTA

    .BRANCH_GAMMA

    LDA.b $1A : AND.b #$10 : BNE .blink_on  
        RTS

    ; $056D4E
    .oam_data_offset
    db $00, $08

    ; $056D50
    .char
    db $37, $38, $38, $37

    ; $056D54-$056DE3 BRANCH LOCATION
    .blink_on

    LDY.b $00 : LDA.w FloorIconOffsetY, Y : SEC : SBC.b #$04 : STA.b $02
    CLC : ADC.b #$10 : STA.b $03
    
    LDY.b #$00
    
    REP #$10
    
    LDX.w $040C : LDA.w DungeonMapFloorCountData, X : LSR #4 : STA.b $0D
    
    LDA.w DungeonMapFloorCountData, X : AND.b #$0F 
    
    SEP #$10
    
    CLC : ADC.b $0D : CMP.b #$01 : BEQ .BRANCH_ALPHA
        LDY.b #$01

    .BRANCH_ALPHA

    STY.b $0D

    .BRANCH_DELTA

        LDA.b #$28 : STA.b $01
        LDA.b #$03 : STA.b $0C
        
        LDX.b $0D
        LDA.w DungeonMap_DrawFloorBlinker_oam_data_offset, X : TAY

        .BRANCH_GAMMA

            LDA.b #$00 : STA.w $0A60, Y : STA.w $0A64, Y
            
            PHY
            
            TYA : ASL #2 : TAY
            
            LDA.b $01 : STA.w $0900, Y : STA.w $0910, Y
            LDA.b $02, X : STA.w $0901, Y : CLC : ADC.b #$08 : STA.w $0911, Y
            
            PHX
            
            LDX.b $0C
            LDA.w DungeonMap_DrawFloorBlinker_char, X
            STA.w $0902, Y : STA.w $0912, Y
            
            PLX : PHY
            
            LDA.b $0E, X
            
            LDY.b $0C : BNE .BRANCH_BETA
                ORA.b #$40

            .BRANCH_BETA

            PLY
            
            STA.w $0903, Y
            
            ORA.b #$80 : STA.w $0913, Y
            
            PLY : INY
            
            LDA.b $01 : CLC : ADC.b #$08 : STA.b $01
        DEC.b $0C : BPL .BRANCH_GAMMA
    DEC.b $0D : BPL .BRANCH_DELTA
    
    RTS
}

; ==============================================================================

; $056DE4-$056E5A LOCAL JUMP LOCATION
DungeonMap_DrawBossIcon:
{
    REP #$10
    
    ; Load palace index.
    LDX.w $040C
    
    REP #$20
    
    PHX
    
    ; X = boss room of the palace.
    LDA.w DungeonMapBossRooms, X : ASL A : TAX
    
    SEP #$20
    
    ; Check if the boss of the palace has been beaten.
    LDA.l $7EF001, X : PLX : AND.b #$08 : BNE .dontShowBossIcon
        REP #$20
        
        ; Check if we have the compass for this palace.
        LDA.l $7EF364 : AND.l DungeonMask, X : SEP #$20 : BEQ .dontShowBossIcon
            LDA.w DungeonMap_BossRoomFloor+1, X : BPL .palaceHasBoss

    .dontShowBossIcon

    SEP #$10
    
    RTS

    .palaceHasBoss

    PHX
    
    JSR.w PalaceMap_DrawBossFloorIndicator
    
    PLX
    
    SEP #$10
    
    LDA.b $1A : AND.b #$0F : CMP.b #$0A : BCS .BRANCH_GAMMA
        LDY.b $00
        
        LDA.b #$00 : STA.w $0A20, Y
        
        TYA : ASL #2 : TAY
        
        LDA.w DungeonMap_BossSkull_offsets+1, X
        CLC : ADC.w $0FA8 : CLC : ADC.b #$90 : STA.w $0800, Y
        
        LDA.w $0FAB : BEQ .BRANCH_DELTA
            LDA.b #$F0
            
            BRA .BRANCH_EPSILON

        .BRANCH_DELTA

        LDA.w DungeonMap_BossSkull_offsets+0, X : CLC : ADC.w $0FAA

        .BRANCH_EPSILON

                      STA.w $0801, Y
        LDA.w DungeonMap_BossSkull_char : STA.w $0802, Y
        LDA.w DungeonMap_BossSkull_prop : STA.w $0803, Y
        
        INC.b $00

    .BRANCH_GAMMA

    RTS
}

; $056E5B-$056E94 DATA
DungeonMap_BossSkull:
{
    ; $056E5B
    .char
    db $31
    
    ; $056E5C
    .prop
    db $33
    
    ; $056E5D
    .offsets
    db $FF, $FF
    db $FF, $FF
    db $08, $08
    db $00, $08
    db $00, $00
    db $00, $08
    db $08, $08
    db $00, $08
    
    db $08, $08
    db $08, $00
    db $04, $04
    db $08, $08
    db $00, $08
    db $00, $08
}

; ==============================================================================

; $056E79-$056E94 DATA
DungeonMap_BossRoomFloor:
{
    dw $FFFF ; // - Sewers
    dw $FFFF ; // - Hyrule Castle
    dw $0001 ; 2F - Eastern Palace
    dw $0001 ; 2F - Desert Palace
    dw $0006 ; 7F - Agahnim's Tower
    dw $00FF ; B1 - Swamp Palace
    dw $00FF ; B1 - Palace of Darkness
    dw $00FF ; B1 - Misery Mire
    dw $00FE ; B2 - Skull Woods
    dw $00F9 ; B7 - Ice Palace
    dw $0005 ; 6F - Tower of Hera
    dw $00FF ; B1 - Thieves' Town
    dw $00FD ; B3 - Turtle Rock
    dw $0006 ; 7F - Ganon's Tower
}

; $056E95-$056EF5 LOCAL JUMP LOCATION
PalaceMap_DrawBossFloorIndicator:
{
    LDA.w DungeonMapFloorCountData, X : AND.b #$0F : STA.b $02
    CLC : ADC.w DungeonMap_BossRoomFloor, X : STA.b $03
    
    LDA.b #$04 : SEC : SBC.b $02 : BMI .BRANCH_ALPHA
        CLC : ADC.b $03 : STA.b $03
        
        LDA.w DungeonMapFloorCountData, X : LSR #4 : SEC : SBC.b #$04 : BMI .BRANCH_ALPHA
            SEC : SBC.b $03 : EOR.b #$FF : INC A : STA.b $03

    .BRANCH_ALPHA

    SEP #$10
    
    LDA.b $1A : AND.b #$0F : CMP.b #$0A : BCS .BRANCH_BETA
        LDX.b $00 : LDA.b #$00 : STA.w $0A20, X
        
        TXA : ASL #2 : TAX
        
        LDA.w .x_offset : STA.w $0800, X
        
        LDY.b $03
        
        LDA.w FloorIconOffsetY, Y : STA.w $0801, X
        
        LDA.w DungeonMap_BossSkull_char : STA.w $0802, X
        LDA.w DungeonMap_BossSkull_prop : STA.w $0803, X
        
        INC.b $00

    .BRANCH_BETA

    REP #$10
    
    RTS
}

; ==============================================================================

; UNUSED:
; $056EF6-$056F18 JUMP LOCATION (LONG)
DungeonMap_4:
{
    REP #$30
    
    LDA.w $0213 : CLC : ADC.b $E8 : STA.b $E8
    
    LDA.w $0213 : EOR.w #$FFFF : INC A : CLC : ADC.w $0217 : STA.w $0217
    
    SEP #$30
    
    DEC.w $0205 : BNE .alpha
        ; Go back to previous mode.
        DEC.w $0200

    .alpha

    RTL
}

; ==============================================================================

; $056F19-$056FC8 JUMP LOCATION (LONG)
DungeonMap_RestoreGraphics:
{
    LDA.b $9B : PHA
    
    STZ.w SNES.HDMAChannelEnable
    STZ.b $9B
    
    JSL.l VRAM_EraseTilemaps_normal
    
    ; Restore main screen designation.
    LDA.l $7EC211 : STA.b $1C
    
    ; OPTIMIZE: Assembler problem much?
    ; (compiled as long address when only a direct page access was necessary).
    LDA.l $7EC212 : STA.l $00001D
    
    ; Restore graphics tileset indices.
    LDA.l $7EC20E : STA.w $0AA1
    LDA.l $7EC20F : STA.w $0AA3
    LDA.l $7EC210 : STA.w $0AA2
    
    ; Restore graphic from the mode we came from.
    JSL.l InitTilesets
    
    ; Begin ignoring any special palette loads.
    STZ.w $0AA9
    STZ.w $0AB2
    
    JSL.l HUD_RebuildLong2
    
    STZ.w $0418
    STZ.w $045C

    .drawQuadrants

        JSL.l WaterFlood_BuildOneQuadrantForVRAM
        JSL.l NMI_UploadTilemap_long
        JSL.l Underworld_PrepareNextRoomQuadrantUpload
        JSL.l NMI_UploadTilemap_long
    LDA.w $045C : CMP.b #$10 : BNE .drawQuadrants
    
    STZ.b $17
    STZ.b $B0
    
    PLA : STA.b $9B
    
    REP #$20
    
    LDX.b #$00

    .restorePaletteBuffer

        LDA.l $7FDD80, X : STA.l $7EC500, X
        LDA.l $7FDE00, X : STA.l $7EC580, X
        LDA.l $7FDE80, X : STA.l $7EC600, X
        LDA.l $7FDF00, X : STA.l $7EC680, X
    INX #2 : CPX.b #$80 : BNE .restorePaletteBuffer
    
    SEP #$20
    
    LDA.l $7EC017 : TSB.b $9C : TSB.b $9D : TSB.b $9E
    
    ; Play sound effect indicating we're coming out of map mode.
    LDA.b #$10 : STA.w $012F
    
    ; Bring volume back to full
    LDA.b #$F3 : STA.w $012C
    
    JSL.l RecoverPegGFXFromMapping
    
    ; Refresh CGRAM this frame.
    INC.b $15
    
    ; Move to next step of the submodule.
    INC.w $0200
    
    STZ.b $13
    STZ.w $0710
    
    RTL
}

; ==============================================================================

; $056FC9-$056FD0 JUMP LOCATION (LONG)
DungeonMap_RestoreStarTileState:
{
    JSL.l Dungeon_RestoreStarTileChr
    
    INC.w $0200
    
    RTL
} 

; ==============================================================================
    
; $056FD1-$056FDE DATA
DungeonMap_BackdropFloorGradientTiles:
{
    dw $1B28, $1B29, $1B2A, $1B2B, $1B2C, $1B2D, $1B2E
}

; $056FDF-$057008 DATA
DungeonMap_MountainStripes:
{
    dw $AA10, $0100 ; VRAM $2154 | 2 bytes | Horizontal
    dw $1B2F

    dw $C910, $0300 ; VRAM $2192 | 4 bytes | Horizontal
    dw $1B2F, $1B2E

    dw $E510, $0B00 ; VRAM $21CA | 12 bytes | Horizontal
    dw $1B2F, $1B2E, $5B2F, $1B2F, $1B2E, $1B2E

    dw $0311, $0100 ; VRAM $2206 | 2 bytes | Horizontal
    dw $1B2F

    dw $0411, $0C40 ; VRAM $2208 | 14 bytes | Fixed horizontal
    dw $1B2E
}

; $057009-$0575D8 DATA
DungeonMap_RoomTemplates:
{
    dw $0B61, $5361, $8B61, $8B62 ; 0x00 - ROOM 0011
    dw $0B60, $0B63, $8B60, $0B64 ; 0x01 - ROOM 0021
    dw $0B00, $0B00, $0B65, $0B66 ; 0x02 - ROOM 0022
    dw $0B67, $4B67, $9367, $D367 ; 0x03 - ROOM 0032
    dw $0B60, $5360, $8B60, $CB60 ; 0x04 - ROOM 0002
    dw $0B6A, $4B6A, $4B6D, $0B6D ; 0x05 - ROOM 0012
    dw $1368, $1369, $0B00, $0B00 ; 0x06 - ROOM 0042
    dw $0B6A, $136B, $0B6C, $0B6D ; 0x07 - ROOM 0041

    dw $136E, $4B6E, $0B00, $0B00 ; 0x08 - ROOM 0080
    dw $136F, $0B00, $0B00, $0B00 ; 0x09 - ROOM 0070
    dw $1340, $0B00, $0B78, $1744 ; 0x0A - ROOM 0071
    dw $536D, $136D, $4B76, $0B76 ; 0x0B - ROOM 0072
    dw $0B70, $0B71, $0B72, $8B71 ; 0x0C - ROOM 0081
    dw $0B75, $0B76, $8B75, $8B76 ; 0x0D - ROOM 0082
    dw $0B00, $0B53, $0B00, $0B55 ; 0x0E - ROOM 0050
    dw $1354, $5354, $0B00, $0B00 ; 0x0F - ROOM 0001
    dw $4B53, $0B00, $0B56, $0B57 ; 0x10 - ROOM 0052
    dw $0B00, $0B59, $0B00, $135E ; 0x11 - ROOM 0060
    dw $135A, $135B, $135F, $535F ; 0x12 - ROOM 0061
    dw $0B5C, $0B5D, $535E, $CB58 ; 0x13 - ROOM 0062
    dw $0B50, $4B50, $1352, $5352 ; 0x14 - ROOM 0051

    dw $0B00, $0B40, $1345, $0B46 ; 0x15 - ROOM 0099
    dw $8B42, $0B47, $0B42, $0B49 ; 0x16 - ROOM 00A8
    dw $1348, $5348, $174A, $574A ; 0x17 - ROOM 00A9
    dw $4B47, $CB42, $4B49, $4B42 ; 0x18 - ROOM 00AA
    dw $0B00, $0B4B, $0B00, $0B4D ; 0x19 - ROOM 00B8
    dw $0B4C, $4B4C, $0B4E, $4B4E ; 0x1A - ROOM 00B9
    dw $0B51, $0B44, $0B00, $0B00 ; 0x1B - ROOM 00BA
    dw $0B4F, $4B4F, $934F, $D34F ; 0x1C - ROOM 00C9
    dw $0B00, $0B00, $0B00, $0B40 ; 0x1D - ROOM 00C8
    dw $0B00, $0B41, $0B00, $0B42 ; 0x1E - ROOM 00D8
    dw $0B00, $0B00, $0B43, $0B43 ; 0x1F - ROOM 00D9
    dw $0B00, $0B00, $9344, $0B00 ; 0x20 - ROOM 00DA

    dw $1340, $0B00, $1341, $0B00 ; 0x21 - ROOM 0063
    dw $1740, $0B40, $0B42, $0B7D ; 0x22 - ROOM 0073
    dw $4B7A, $0B7A, $0B7E, $4B7E ; 0x23 - ROOM 0074
    dw $0B40, $8B4D, $4BBA, $0B55 ; 0x24 - ROOM 0076
    dw $0B40, $8B55, $1378, $CB53 ; 0x25 - ROOM 0083
    dw $4B76, $4B75, $13BB, $53BB ; 0x26 - ROOM 0084
    dw $4B7F, $4B42, $0B83, $13BC ; 0x27 - ROOM 0086
    dw $0B00, $0B00, $0B79, $0B00 ; 0x28 - ROOM 0033
    dw $0B6E, $4B7C, $0B00, $0B41 ; 0x29 - ROOM 0042
    dw $1340, $8B55, $0B42, $0B7B ; 0x2A - ROOM 0053

    dw $8B42, $9344, $1341, $0B00 ; 0x2B - ROOM 00E0
    dw $0B53, $9344, $8B53, $9344 ; 0x2C - ROOM 00C0/ROOM 00D0
    dw $8B42, $9344, $0B42, $9344 ; 0x2D - ROOM 00B0
    dw $934D, $0B00, $8B53, $9344 ; 0x2E - ROOM 0040
    dw $0B00, $0B00, $0B40, $0B00 ; 0x2F - ROOM 0020
    dw $0B41, $0B00, $1384, $0B00 ; 0x30 - ROOM 0030

    dw $0BB8, $13B9, $4B85, $CB7C ; 0x31 - ROOM 0066
    dw $0B87, $13B0, $4B7B, $9344 ; 0x32 - ROOM 0076
    dw $0B00, $0B00, $0B40, $0B00 ; 0x33 - ROOM 0006
    dw $0B91, $5391, $0B9C, $4B9C ; 0x34 - ROOM 0016
    dw $8B42, $1392, $0B93, $1394 ; 0x35 - ROOM 0026
    dw $0B95, $0B96, $9395, $8B96 ; 0x36 - ROOM 0034
    dw $0B97, $0B98, $8B97, $8B98 ; 0x37 - ROOM 0035
    dw $1799, $5799, $9799, $D799 ; 0x38 - ROOM 0036
    dw $4B98, $4B97, $CB98, $CB97 ; 0x39 - ROOM 0037
    dw $937B, $0B00, $0B7B, $0B00 ; 0x3A - ROOM 0038
    dw $0BA6, $4BA6, $CB7A, $8B7A ; 0x3B - ROOM 0046
    dw $0B8E, $4B8E, $938E, $CB8E ; 0x3C - ROOM 0054
    dw $934D, $0B8F, $1390, $5390 ; 0x3D - ROOM 0028

    dw $0B00, $934E, $0B00, $8B4D ; 0x3F - ROOM 006A
    dw $8B72, $1346, $0B45, $0B46 ; 0x40 - ROOM 000B
    dw $0B00, $0B00, $0B00, $8B48 ; 0x3E - ROOM 005A
    dw $5744, $1744, $0B00, $0B00 ; 0x41 - ROOM 000A
    dw $134D, $0B00, $8B54, $0B00 ; 0x42 - ROOM 003B
    dw $1349, $1349, $0B00, $0B00 ; 0x43 - ROOM 0009
    dw $0B4B, $8B48, $0B72, $4B72 ; 0x44 - ROOM 004B
    dw $0B00, $0B74, $0B00, $0BB0 ; 0x45 - ROOM 0019
    dw $0B71, $1747, $17AF, $0B4B ; 0x46 - ROOM 001A
    dw $0B6F, $1370, $0B4B, $0B00 ; 0x47 - ROOM 001B
    dw $0B6B, $8B6C, $8B6B, $0BAD ; 0x48 - ROOM 002A
    dw $0B73, $0B00, $13AE, $0B46 ; 0x49 - ROOM 002B
    dw $176B, $576B, $0B6A, $4B6A ; 0x4A - ROOM 003A
    dw $1368, $5368, $1369, $5369 ; 0x4B - ROOM 004A

    dw $8B4E, $0B00, $9354, $0B00 ; 0x4C - ROOM 00D5
    dw $0B00, $0B00, $0B00, $5377 ; 0x4D - ROOM 0023

    dw $0B00, $974D, $0B00, $4B7B ; 0x4E - ROOM 0091
    dw $0B40, $8B4D, $0B51, $0B8D ; 0x4F - ROOM 0092
    dw $537A, $137A, $4B42, $8B40 ; 0x50 - ROOM 0093
    dw $0B00, $0B00, $0B00, $0B00 ; 0x51 - UNUSED
    dw $0B00, $0B00, $0B40, $0B00 ; 0x52 - ROOM 0090
    dw $CB7A, $576E, $0B00, $0B00 ; 0x53 - ROOM 00A0
    dw $0B6E, $0B9F, $0B00, $4BA5 ; 0x54 - ROOM 00A1
    dw $13A0, $13A1, $0BA2, $0BA3 ; 0x55 - ROOM 00A2
    dw $0BA4, $0B00, $0BA5, $0B00 ; 0x56 - ROOM 00A3
    dw $0B40, $8B55, $0B42, $CB87 ; 0x57 - ROOM 00B1
    dw $8B95, $0BA7, $8B42, $0BAF ; 0x58 - ROOM 00B2
    dw $4B78, $0B00, $4B78, $0B00 ; 0x59 - ROOM 00B3
    dw $8B42, $0B51, $0B78, $8B51 ; 0x5A - ROOM 00C1
    dw $0BA8, $0BA9, $0BAC, $8BA9 ; 0x5B - ROOM 00C2
    dw $0BAA, $17AB, $13B4, $8BAB ; 0x5C - ROOM 00C3
    dw $17B1, $0B41, $4B44, $4B42 ; 0x5D - ROOM 00D1
    dw $0B00, $0BAD, $0B00, $13AE ; 0x5E - ROOM 00D2
    dw $1340, $0BB7, $0B42, $0BB6 ; 0x5F - ROOM 0097
    dw $0B00, $0B00, $139D, $139E ; 0x60 - ROOM 0098

    dw $0B00, $0B00, $0B00, $0B79 ; 0x61 - ROOM 0029
    dw $0B00, $0B00, $8B42, $0B86 ; 0x62 - ROOM 0039
    dw $0B42, $8B7B, $8B42, $0B7B ; 0x63 - ROOM 0049
    dw $0B87, $8B7B, $9387, $0B7B ; 0x64 - ROOM 0059
    dw $0B40, $13B3, $1378, $0B8D ; 0x65 - ROOM 0056
    dw $8B42, $0B88, $5378, $0B40 ; 0x66 - ROOM 0057
    dw $4B44, $D342, $97B5, $4B78 ; 0x67 - ROOM 0058
    dw $13B3, $8B55, $4B7B, $0B8D ; 0x68 - ROOM 0067
    dw $0B89, $138A, $0B8B, $0B8C ; 0x69 - ROOM 0068

    dw $0B00, $0B7C, $0B00, $0B00 ; 0x6A - ROOM 00DE
    dw $0B00, $9348, $0B00, $0B56 ; 0x6B - ROOM 00BE
    dw $0B00, $0B00, $0B88, $0B00 ; 0x6C - ROOM 00BF
    dw $0B00, $0B48, $0B00, $0B00 ; 0x6D - ROOM 00CE
    dw $0B00, $9348, $1786, $0B65 ; 0x6E - ROOM 009E
    dw $0B00, $0B00, $CB5A, $0B00 ; 0x6F - ROOM 009F
    dw $0B00, $5388, $0B00, $0B00 ; 0x70 - ROOM 00AE
    dw $4B5A, $0B00, $0B00, $0B00 ; 0x71 - ROOM 00AF
    dw $0B00, $CB5B, $13AB, $0BAC ; 0x72 - ROOM 007E
    dw $CB5A, $0B00, $137E, $0B00 ; 0x73 - ROOM 007F
    dw $0B00, $137E, $0B00, $0B00 ; 0x74 - ROOM 008E
    dw $0B00, $8B48, $1783, $1384 ; 0x75 - ROOM 005E
    dw $0B00, $0B00, $1385, $0B00 ; 0x76 - ROOM 005F
    dw $0B00, $537E, $0B00, $0B00 ; 0x77 - ROOM 006E
    dw $0B00, $8B48, $0B43, $CB43 ; 0x78 - ROOM 003E
    dw $0B00, $0B00, $1379, $137A ; 0x79 - ROOM 003F
    dw $0B5A, $137B, $0B00, $0B00 ; 0x7A - ROOM 004E
    dw $0B00, $8B48, $137F, $1380 ; 0x7B - ROOM 001E
    dw $0B00, $0B00, $1381, $1382 ; 0x7C - ROOM 001F
    dw $0B00, $0B48, $0B00, $0B00 ; 0x7D - ROOM 002E
    dw $0B00, $0B00, $1387, $1377 ; 0x7E - ROOM 000E

    dw $5746, $0B47, $1349, $0B48 ; 0x7F - ROOM 0087
    dw $1375, $4B42, $174A, $574A ; 0x80 - ROOM 0077
    dw $0B43, $1344, $0B45, $1746 ; 0x81 - ROOM 0031
    dw $1742, $5742, $8B42, $CB42 ; 0x82 - ROOM 0027
    dw $1375, $5375, $8B42, $CB42 ; 0x83 - ROOM 0017
    dw $4B40, $1340, $0B41, $4B41 ; 0x84 - ROOM 0007

    dw $4B46, $0B71, $1786, $8B71 ; 0x85 - ROOM 0044
    dw $1347, $0B4D, $0B65, $0B5B ; 0x86 - ROOM 0045
    dw $0B00, $0B00, $9348, $0B00 ; 0x87 - ROOM 00AB
    dw $0B00, $0B00, $0B00, $8B48 ; 0x88 - ROOM 00AC
    dw $4B66, $8B65, $4B5B, $0B65 ; 0x89 - ROOM 00BB
    dw $9365, $0B66, $0B63, $8B66 ; 0x8A - ROOM 00BC
    dw $4B51, $0B5F, $CB76, $0B60 ; 0x8B - ROOM 00CB
    dw $0B64, $4B4F, $4B60, $8B76 ; 0x8C - ROOM 00CC
    dw $4B76, $0B61, $D376, $1362 ; 0x8D - ROOM 00DB
    dw $4B61, $0B76, $CB58, $8B51 ; 0x8E - ROOM 00DC
    dw $0B00, $0B00, $5746, $0B5E ; 0x8F - ROOM 0064
    dw $0B00, $0B00, $0B5E, $0B46 ; 0x90 - ROOM 0065

    dw $0B00, $0B00, $8B48, $0B00 ; 0x91 - ROOM 00A4
    dw $0B4F, $0B51, $CB76, $8B76 ; 0x92 - ROOM 00B4
    dw $5351, $0B51, $8B4F, $8B51 ; 0x93 - ROOM 00B5
    dw $4B76, $0B76, $CB51, $8B58 ; 0x94 - ROOM 00C4
    dw $0B54, $0B00, $8B66, $0B00 ; 0x95 - ROOM 00C5
    dw $9348, $8B48, $0B56, $4B45 ; 0x96 - ROOM 0004
    dw $0B00, $0B57, $0B00, $0B59 ; 0x97 - ROOM 0013
    dw $4B50, $0B58, $CB50, $8B50 ; 0x98 - ROOM 0014
    dw $5758, $1751, $CB58, $8B51 ; 0x99 - ROOM 0015
    dw $0B56, $4B56, $0B65, $5756 ; 0x9A - ROOM 0024
    dw $9348, $8B48, $0B4C, $0B4B ; 0x9B - ROOM 00B6
    dw $0B4D, $0B00, $8B54, $0B00 ; 0x9C - ROOM 00B7
    dw $0B4F, $0B50, $8B4F, $8B50 ; 0x9D - ROOM 00C6
    dw $4B50, $0B51, $CB58, $8B51 ; 0x9E - ROOM 00C7
    dw $0B52, $0B54, $0B53, $9354 ; 0x9F - ROOM 00D6

    dw $9748, $9748, $138D, $138E ; 0xA0 - ROOM 001C
    dw $1391, $1392, $138C, $138F ; 0xA1 - ROOM 007B
    dw $1393, $1390, $9393, $138F ; 0xA2 - ROOM 007C
    dw $1394, $1395, $138E, $138C ; 0xA3 - ROOM 007D
    dw $175D, $1399, $975D, $538F ; 0xA4 - ROOM 008B
    dw $1397, $1398, $179A, $138C ; 0xA5 - ROOM 008C
    dw $1399, $1766, $138F, $D75D ; 0xA6 - ROOM 008D
    dw $538E, $538F, $1391, $1392 ; 0xA7 - ROOM 009B
    dw $139B, $539B, $139C, $539C ; 0xA8 - ROOM 009C
    dw $138F, $138E, $5392, $5391 ; 0xA9 - ROOM 009D
    dw $138A, $538A, $138B, $538B ; 0xAA - ROOM 000C
    dw $0B00, $CB5B, $0B00, $8B54 ; 0xAB - ROOM 005B
    dw $4B74, $13A6, $0B00, $4B48 ; 0xAC - ROOM 005C
    dw $13A0, $13A1, $538E, $138E ; 0xAD - ROOM 006B
    dw $D38E, $53A3, $13A4, $0B00 ; 0xAE - ROOM 005D
    dw $97AA, $0B00, $538E, $1399 ; 0xAF - ROOM 006C
    dw $13A4, $0B00, $138E, $0B00 ; 0xB0 - ROOM 006D
    dw $0B00, $5393, $0B00, $574E ; 0xB1 - ROOM 0095
    dw $4B7D, $0B00, $8B7D, $139F ; 0xB2 - ROOM 0096
    dw $97AA, $13A4, $13A9, $53A9 ; 0xB3 - ROOM 00A5
    dw $13A5, $13A6, $93A5, $D3A5 ; 0xB4 - ROOM 00A6
    dw $D38E, $938E, $13A4, $13AA ; 0xB5 - ROOM 0034
    dw $0B00, $13A6, $0B00, $8B5F ; 0xB6 - ROOM 004C
    dw $139B, $13A6, $139C, $53A2 ; 0xB7 - ROOM 004D
    dw $0B00, $0B00, $138C, $0B00 ; 0xB8 - ROOM 000D
    dw $9394, $139E, $0B00, $0B00 ; 0xB9 - ROOM 001D
}

; ==============================================================================

; $0575D9-$0575F4 DATA
DungeonMapFloorCountData:
{
    db $21, $00 ; Sewers
    db $23, $00 ; Hyrule Castle
    db $20, $00 ; Eastern Palace
    db $21, $00 ; Desert Palace
    db $70, $00 ; Agahnim's Tower
    db $12, $00 ; Swamp Palace
    db $11, $00 ; Palace of Darkness
    db $12, $02 ; Misery Mire
    db $02, $00 ; Skull Woods
    db $17, $02 ; Ice Palace
    db $60, $01 ; Tower of Hera
    db $12, $00 ; Thieves' Town
    db $13, $01 ; Turtle Rock
    db $71, $01 ; Ganon's Tower
}
    
; $0575F5-$057604 DATA
DungeonMapFloorToDataOffset:
{
    dw $0000
    dw $0019
    dw $0032
    dw $004B
    dw $0064
    dw $007D
    dw $0096
    dw $00AF
}

; Quick note, all of these pointers seem to be a multiple of 25 bytes apart.
; $057605-$057620 DATA
DungeonMapRoomPointers:
{
    db $F621, $F66C, $F6E9, $F71B, $F766, $F815, $F860, $F892
    db $F8DD, $F90F, $F9D7, $FA6D, $FAB8, $FB1C
}

; $057621-$05766B DATA
DungeonMapRoomData_Sewers:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $11, $0F, $0F ; Row 1
    db $0F, $0F, $21, $22, $0F ; Row 2
    db $0F, $0F, $0F, $32, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $02, $0F, $0F ; Row 1
    db $0F, $0F, $12, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $42, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $41, $0F ; Row 4
}

; $05766C-$0576E8 DATA
DungeonMapRoomData_HyruleCastle:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $80, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $70, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $71, $72, $0F, $0F ; Row 2
    db $0F, $81, $82, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $50, $01, $52, $0F ; Row 2
    db $0F, $60, $61, $62, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $51, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}
    
; $0576E9-$05771A DATA
DungeonMapRoomData_EasternPalace:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $99, $0F, $0F ; Row 1
    db $0F, $A8, $A9, $AA, $0F ; Row 2
    db $0F, $B8, $B9, $BA, $0F ; Row 3
    db $0F, $0F, $C9, $0F, $0F ; Row 4

    db $C8, $0F, $0F, $0F, $0F ; Row 0
    db $D8, $D9, $DA, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}

; $05771B-$057765 DATA
DungeonMapRoomData_DesertPalace:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $73, $74, $75, $0F ; Row 3
    db $0F, $83, $84, $85, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $63, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $33, $0F, $0F ; Row 0
    db $0F, $0F, $43, $0F, $0F ; Row 1
    db $0F, $0F, $53, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}

; $057766-$057814 DATA
DungeonMapRoomData_AgahnimsTower:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $E0, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $D0, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $C0, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $B0, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $40, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $20, $0F, $0F ; Row 1
    db $0F, $0F, $30, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}
    
; $057815-$05785F DATA
DungeonMapRoomData_SwampPalace:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $66, $0F, $0F ; Row 1
    db $0F, $0F, $76, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $06, $0F, $0F ; Row 0
    db $0F, $0F, $16, $0F, $0F ; Row 1
    db $0F, $0F, $26, $0F, $0F ; Row 2
    db $34, $35, $36, $37, $38 ; Row 3
    db $0F, $0F, $46, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $54, $0F, $0F, $0F, $28 ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}
    
; $057860-$057891 DATA
DungeonMapRoomData_PalaceofDarkness:
{
    db $0F, $0F, $5A, $0F, $0F ; Row 0
    db $0F, $0F, $6A, $0B, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0A, $3B, $0F ; Row 3
    db $0F, $0F, $09, $4B, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $19, $1A, $1B, $0F ; Row 1
    db $0F, $0F, $2A, $2B, $0F ; Row 2
    db $0F, $0F, $3A, $0F, $0F ; Row 3
    db $0F, $0F, $4A, $0F, $0F ; Row 4
}
    
; $057892-$0578DC DATA
DungeonMapRoomData_MiseryMire:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $91, $92, $93, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $90, $0F, $0F, $0F ; Row 0
    db $0F, $A0, $A1, $A2, $A3 ; Row 1
    db $0F, $0F, $B1, $B2, $B3 ; Row 2
    db $0F, $0F, $C1, $C2, $C3 ; Row 3
    db $0F, $0F, $D1, $D2, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $97, $98, $0F ; Row 4
}
    
; $0578DD-$05790E DATA
DungeonMapRoomData_SkullWoods:
{
    db $29, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $39, $0F, $0F, $0F, $0F ; Row 0
    db $49, $0F, $0F, $0F, $0F ; Row 1
    db $59, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $56, $57, $58, $0F ; Row 3
    db $0F, $0F, $67, $68, $0F ; Row 4
}
        
; $05790F-$0579D6 DATA
DungeonMapRoomData_IcePalace:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $DE, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $BE, $BF, $0F ; Row 2
    db $0F, $0F, $CE, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $9E, $9F, $0F ; Row 2
    db $0F, $0F, $AE, $AF, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $7E, $7F, $0F ; Row 2
    db $0F, $0F, $8E, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $5E, $5F, $0F ; Row 2
    db $0F, $0F, $6E, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $3E, $3F, $0F ; Row 2
    db $0F, $0F, $4E, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $1E, $1F, $0F ; Row 2
    db $0F, $0F, $2E, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0E, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}

; $0579D7-$057A6C DATA
DungeonMapRoomData_TowerofHera:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $87, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $77, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $31, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $27, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $17, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $07, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}

; $057A6D-$057AB7 DATA
DungeonMapRoomData_ThievesTown:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $44, $45, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $AB, $AC, $0F, $0F ; Row 1
    db $0F, $BB, $BC, $0F, $0F ; Row 2
    db $0F, $CB, $CC, $0F, $0F ; Row 3
    db $0F, $DB, $DC, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $64, $65, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}
        
; $057AB8-$057B1B DATA
DungeonMapRoomData_TurtleRock:
{
    db $0F, $A4, $0F, $0F, $0F ; Row 0
    db $0F, $B4, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $B5, $0F, $0F ; Row 1
    db $0F, $C4, $C5, $0F, $0F ; Row 2
    db $0F, $0F, $D5, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $04, $0F, $0F ; Row 1
    db $0F, $13, $14, $15, $0F ; Row 2
    db $0F, $23, $24, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0F, $B6, $B7 ; Row 2
    db $0F, $0F, $0F, $C6, $C7 ; Row 3
    db $0F, $0F, $0F, $D6, $0F ; Row 4
}
        
; $057B1C-$057BE3 DATA
DungeonMapRoomData_GanonsTower:
{
    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $1C, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $7B, $7C, $7D, $0F ; Row 1
    db $0F, $8B, $8C, $8D, $0F ; Row 2
    db $0F, $9B, $9C, $9D, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $0F, $0F ; Row 1
    db $0F, $0F, $0C, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $5B, $5C, $0F ; Row 1
    db $0F, $0F, $6B, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $5D, $0F ; Row 1
    db $0F, $0F, $6C, $6D, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $95, $96, $0F ; Row 1
    db $0F, $0F, $A5, $A6, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0F, $3D, $0F ; Row 1
    db $0F, $0F, $4C, $4D, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4

    db $0F, $0F, $0F, $0F, $0F ; Row 0
    db $0F, $0F, $0D, $0F, $0F ; Row 1
    db $0F, $0F, $1D, $0F, $0F ; Row 2
    db $0F, $0F, $0F, $0F, $0F ; Row 3
    db $0F, $0F, $0F, $0F, $0F ; Row 4
}

; ==============================================================================

; TODO: What data was this referning to?
; I'm tentatively assuming this is chest data for the maps (i.e. a listing of
; references to chest numbers), but so far it's inconclusive.

; $057BE4-$057BFF
DungeonMapRoomLayoutPointers:
{
    dw DungeonMapLayoutData_Sewers
    dw DungeonMapLayoutData_HyruleCastle
    dw DungeonMapLayoutData_EasternPalace
    dw DungeonMapLayoutData_DesertPalace
    dw DungeonMapLayoutData_AgahnimsTower
    dw DungeonMapLayoutData_SwampPalace
    dw DungeonMapLayoutData_PalaceOfDarkness
    dw DungeonMapLayoutData_MiseryMire
    dw DungeonMapLayoutData_SkullWoods
    dw DungeonMapLayoutData_IcePalace
    dw DungeonMapLayoutData_TowerOfHera
    dw DungeonMapLayoutData_ThievesTown
    dw DungeonMapLayoutData_TurtleRock
    dw DungeonMapLayoutData_GanonsTower
}
    
; $057C00-$057C07 DATA
DungeonMapLayoutData_Sewers:
{
    db $00 ; Room 0011
    db $01 ; Room 0021
    db $02 ; Room 0022
    db $03 ; Room 0032
    db $04 ; Room 0002
    db $05 ; Room 0012
    db $06 ; Room 0042
    db $07 ; Room 0041
}

; $057C08-$057C14 DATA
DungeonMapLayoutData_HyruleCastle:
{
    db $08 ; Room 0080
    db $09 ; Room 0070
    db $0A ; Room 0071
    db $0B ; Room 0072
    db $0C ; Room 0081
    db $0D ; Room 0082
    db $0E ; Room 0050
    db $0F ; Room 0001
    db $10 ; Room 0052
    db $11 ; Room 0060
    db $12 ; Room 0061
    db $13 ; Room 0062
    db $14 ; Room 0051
}

; $057C14-$057C20 DATA
DungeonMapLayoutData_EasternPalace:
{
    db $15 ; Room 0099
    db $16 ; Room 00A8
    db $17 ; Room 00A9
    db $18 ; Room 00AA
    db $19 ; Room 00B8
    db $1A ; Room 00B9
    db $1B ; Room 00BA
    db $1C ; Room 00C9
    db $1D ; Room 00C8
    db $1E ; Room 00D8
    db $1F ; Room 00D9
    db $20 ; Room 00DA
}

; $057C21-$057C2A DATA
DungeonMapLayoutData_DesertPalace:
{
    db $22 ; Room 0073
    db $23 ; Room 0074
    db $24 ; Room 0076
    db $25 ; Room 0083
    db $26 ; Room 0084
    db $27 ; Room 0086
    db $21 ; Room 0063
    db $28 ; Room 0033
    db $29 ; Room 0042
    db $2A ; Room 0053
}

; $057C2B-$057C31 DATA
DungeonMapLayoutData_AgahnimsTower:
{
    db $2B ; Room 00E0
    db $2C ; Room 00D0
    db $2C ; Room 00C0
    db $2D ; Room 00B0
    db $2E ; Room 0040
    db $2F ; Room 0020
    db $30 ; Room 0030
}

; $057C32-$057C3E DATA
DungeonMapLayoutData_SwampPalace:
{
    db $31 ; Room 0066
    db $32 ; Room 0076
    db $33 ; Room 0006
    db $34 ; Room 0016
    db $35 ; Room 0026
    db $36 ; Room 0034
    db $37 ; Room 0035
    db $38 ; Room 0036
    db $39 ; Room 0037
    db $3A ; Room 0038
    db $3B ; Room 0046
    db $3C ; Room 0054
    db $3D ; Room 0028
}

; $057C3F-$057C4C DATA
DungeonMapLayoutData_PalaceOfDarkness:
{
    db $3E ; Room 005A
    db $3F ; Room 006A
    db $40 ; Room 000B
    db $41 ; Room 000A
    db $42 ; Room 003B
    db $43 ; Room 0009
    db $44 ; Room 004B
    db $45 ; Room 0019
    db $46 ; Room 001A
    db $47 ; Room 001B
    db $48 ; Room 002A
    db $49 ; Room 002B
    db $4A ; Room 003A
    db $4B ; Room 004A
}

; $057C4D-$057C5E DATA
DungeonMapLayoutData_MiseryMire:
{
    db $4E ; Room 0091
    db $4F ; Room 0092
    db $50 ; Room 0093
    db $52 ; Room 0090
    db $53 ; Room 00A0
    db $54 ; Room 00A1
    db $55 ; Room 00A2
    db $56 ; Room 00A3
    db $57 ; Room 00B1
    db $58 ; Room 00B2
    db $59 ; Room 00B3
    db $5A ; Room 00C1
    db $5B ; Room 00C2
    db $5C ; Room 00C3
    db $5D ; Room 00D1
    db $5E ; Room 00D2
    db $5F ; Room 0097
    db $60 ; Room 0098
}

; $057C5F-$057C67 DATA
DungeonMapLayoutData_SkullWoods:
{
    db $61 ; Room 0029
    db $62 ; Room 0039
    db $63 ; Room 0049
    db $64 ; Room 0059
    db $65 ; Room 0056
    db $66 ; Room 0057
    db $67 ; Room 0058
    db $68 ; Room 0067
    db $69 ; Room 0068
}

; $057C68-$057C7C DATA
DungeonMapLayoutData_IcePalace:
{
    db $6A ; Room 00DE
    db $6B ; Room 00BE
    db $6C ; Room 00BF
    db $6D ; Room 00CE
    db $6E ; Room 009E
    db $6F ; Room 009F
    db $70 ; Room 00AE
    db $71 ; Room 00AF
    db $72 ; Room 007E
    db $73 ; Room 007F
    db $74 ; Room 008E
    db $75 ; Room 005E
    db $76 ; Room 005F
    db $77 ; Room 006E
    db $78 ; Room 003E
    db $79 ; Room 003F
    db $7A ; Room 004E
    db $7B ; Room 001E
    db $7C ; Room 001F
    db $7D ; Room 002E
    db $7E ; Room 000E
}

; $057C7D-$057C82 DATA
DungeonMapLayoutData_TowerOfHera:
{
    db $7F ; Room 0087
    db $80 ; Room 0077
    db $81 ; Room 0031
    db $82 ; Room 0027
    db $83 ; Room 0017
    db $84 ; Room 0007
}

; $057C83-$057C8E DATA
DungeonMapLayoutData_ThievesTown:
{
    db $85 ; Room 0044
    db $86 ; Room 0045
    db $87 ; Room 00AB
    db $88 ; Room 00AC
    db $89 ; Room 00BB
    db $8A ; Room 00BC
    db $8B ; Room 00CB
    db $8C ; Room 00CC
    db $8D ; Room 00DB
    db $8E ; Room 00DC
    db $8F ; Room 0064
    db $90 ; Room 0065
}

; $057C8F-$057C9F DATA
DungeonMapLayoutData_TurtleRock:
{
    db $91 ; Room 00A4
    db $92 ; Room 00B4
    db $93 ; Room 00B5
    db $94 ; Room 00C4
    db $95 ; Room 00C5
    db $4C ; Room 00D5
    db $96 ; Room 0004
    db $97 ; Room 0013
    db $98 ; Room 0014
    db $99 ; Room 0015
    db $4D ; Room 0023
    db $9A ; Room 0024
    db $9B ; Room 00B6
    db $9C ; Room 00B7
    db $9D ; Room 00C6
    db $9E ; Room 00C7
    db $9F ; Room 00D6
}

; $057CA0-$057CB9 DATA
DungeonMapLayoutData_GanonsTower:
{
    db $A0 ; Room 001C
    db $A1 ; Room 007B
    db $A2 ; Room 007C
    db $A3 ; Room 007D
    db $A4 ; Room 008B
    db $A5 ; Room 008C
    db $A6 ; Room 008D
    db $A7 ; Room 009B
    db $A8 ; Room 009C
    db $A9 ; Room 009D
    db $AA ; Room 000C
    db $AB ; Room 005B
    db $AC ; Room 005C
    db $AD ; Room 006B
    db $AE ; Room 005D
    db $AF ; Room 006C
    db $B0 ; Room 006D
    db $B1 ; Room 0095
    db $B2 ; Room 0096
    db $B3 ; Room 00A5
    db $B4 ; Room 00A6
    db $B5 ; Room 0034
    db $B6 ; Room 004C
    db $B7 ; Room 004D
    db $B8 ; Room 000D
    db $B9 ; Room 001D
}

; ==============================================================================
    
; $057CBA-$057CDF NULL
NULL_0AFCBA:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF        
}

; ==============================================================================

; $057CE0-$057CF5 DATA
HUD_FloorIndicatorNumberHigh:
{
    dw $2508, $2509, $2509, $250A, $250B, $250C, $250D, $251D
    dw $E51C, $250E, $007F
}

; $057CF6-$057D0B DATA
HUD_FloorIndicatorNumberLow:
{
    dw $2518, $2519, $A509, $251A, $251B, $251C, $2518, $A51D
    dw $E50C, $A50E, $007F
}

; ==============================================================================

; Handles display of the Floor indicator on BG3 (1F, B1, etc).
; $057D0C-$057DA7 JUMP LOCATION (LONG)
FloorIndicator:
{
    REP #$30
    
    LDA.w $04A0 : AND.w #$00FF : BEQ .hideIndicator
        INC A : CMP.w #$00C0 : BNE .dontDisable
            ; If the count up timer reaches 0x00BF frames, disable the floor
            ; indicator during the next frame.
            LDA.w #$0000

        .dontDisable

        STA.w $04A0
        
        PHB : PHK : PLB
        
        LDA.w #$251E : STA.l $7EC7F2
        INC A        : STA.l $7EC834
        INC A        : STA.l $7EC832
        
        LDA.w #$250F : STA.l $7EC7F4
        
        LDX.w #$0000
        
        ; This confused me at first, but it's actually looking at whether $A4[1]
        ; has a negative value $A3 has nothing to do with $A4.
        LDA.b $A3 : BMI .basementFloor
            ; Check which floor Link is on.
            LDA.b $A4 : BNE .notFloor1F
                LDA.b $A0 : CMP.w #$0002 : BEQ .sanctuaryRatRoom
                    SEP #$20
                    
                    ; Check the world state.
                    LDA.l $7EF3C5 : CMP.b #$02 : BCS .noRainSound
                        ; Cause the ambient rain sound to occur (indoor
                        ; version).
                        LDA.b #$03 : STA.w $012D

                    .noRainSound

                    REP #$20

                .sanctuaryRatRoom
            .notFloor1F

            LDA.b $A4 : AND.w #$00FF
            
            BRA .setFloorIndicatorNumber

        .basementFloor

        SEP #$20
            
        ; Turn off any ambient sound effects.
        LDA.b #$05 : STA.w $012D
        
        REP #$20
        
        INX #2
        
        LDA.b $A4 : ORA.w #$FF00 : EOR.w #$FFFF
        
        .setFloorIndicatorNumber
        
        ASL A : TAY
        
        LDA FloorIndicatorNumberHigh, Y : STA.l $7EC7F2, X
        LDA FloorIndicatorNumberLow, Y  : STA.l $7EC832, X
        
        SEP #$30
        
        PLB
        
        ; Send a signal indicating that bg3 needs updating.
        INC.b $16
        
        RTL
    
    ; $057D90 ALTERNATE ENTRY POINT
    .hideIndicator
    
    REP #$20
    
    ; Disable the display of the floor indicator.
    LDA.w #$007F : STA.l $7EC7F2 : STA.l $7EC832 : STA.l $7EC7F4 : STA.l $7EC834
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; TODO: Change the name of this function becuase it is used for the digging guy
; minigame too.
; $057DA8-$057E17 LONG JUMP LOCATION
HUD_SuperBombIndicator:
{
    LDA.w $04B5 : BNE .BRANCH_ALPHA
        LDA.w $04B4 : BMI .BRANCH_BETA
            DEC.w $04B4
            
            ; Reset the frame counter to 62 frames.
            ; TODO: Does the SNES run at 62 fps?
            LDA.b #$3E : STA.w $04B5

    .BRANCH_ALPHA

    DEC.w $04B5
    
    LDA.w $04B4 : BPL .BRANCH_GAMMA
        .BRANCH_BETA

        ; Set the HUD timer to inactive.
        LDA.b #$FF : STA.w $04B4
        
        REP #$30
        
        BRA FloorIndicator_hideIndicator

    .BRANCH_GAMMA

    LDA.w $04B4 : STA.w SNES.DividendLow
                  STZ.w SNES.DividendHigh
    
    LDA.b #$0A : STA.w SNES.DivisorB
    
    NOP #8
    
    LDA.w SNES.DivideResultQuotientLow : ASL A : STA.b $00
    
    LDA.w SNES.RemainderResultLow : ASL A : STA.b $02
    
    PHB : PHK : PLB
    
    REP #$20
    
    LDX.b #$02

    .BRANCH_EPSILON

        LDY.b $00, X : DEY #2 : BPL .BRANCH_DELTA
            LDY.b #$12
            
            CPX.b #$00 : BNE .BRANCH_DELTA
                LDY.b #$14

        .BRANCH_DELTA

        LDA.w HUD_FloorIndicatorNumberHigh, Y : STA.l $7EC7F2, X
        LDA.w HUD_FloorIndicatorNumberLow, Y : STA.l $7EC832, X
    DEX #2 : BPL .BRANCH_EPSILON
    
    SEP #$20
    
    PLB
    
    RTL
}

; ==============================================================================

; $057E18-$057E1F NULL
NULL_0AFE18:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $057E20-$057E64 LONG JUMP LOCATION
Death_InitializeGameOverLetters:
{
    PHB : PHK : PLB
    
    STZ.w $035F
    
    ; Sets X coordinates for the first 8 special effects to 0x00B0.
    LDA.b #$B0 : STA.w $0C04
                 STA.w $0C05
                 STA.w $0C06
                 STA.w $0C07
                 STA.w $0C08
                 STA.w $0C09
                 STA.w $0C0A
                 STA.w $0C0B
    
    LDA.b #$00 : STA.w $0C18
                 STA.w $0C19
                 STA.w $0C1A
                 STA.w $0C1B
                 STA.w $0C1C
                 STA.w $0C1D
                 STA.w $0C1E
                 STA.w $0C1F
    
    INC A : STA.w $0C4A
    
    LDA.b #$06 : STA.w $039D
    
    PLB
    
    RTL
} 

; ==============================================================================

; $057E65-$057E6F NULL
NULL_0AFE65:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF
}

; ==============================================================================

; $057E70-$057E7F DATA
Pool_Effect_Handler:
{
    dw Effect_DoNothing        ; 0x00 - $FE87
    dw Effect_DoNothing        ; 0x01 - $FE87
    dw Effect_MovingFloor      ; 0x02 - $FE88
    dw Effect_MovingWater      ; 0x03 - $FFDE
    dw Effect_MovingFloor2     ; 0x04 - $FEEE Not sure if this is used anywhere
    dw Effect_RedFlashes       ; 0x05 - $FF0D (Agahnim's room in Ganon's tower)
    dw Effect_TorchHiddenTiles ; 0x06 - $FF5D
    dw Effect_TorchGanonRoom   ; 0x07 - $FFA4
}
    
; $057E80-$057E86 LONG JUMP LOCATION
Effect_Handler:
{
    LDA.b $AD : ASL A : TAX
    
    JMP (Pool_Effect_Handler, X)
}

; ==============================================================================

; $057E87-$057E87 JUMP LOCATION
Effect_DoNothing:
{
    RTL
}

; ==============================================================================
    
; $057E88-$057EED JUMP LOCATION
Effect_MovingFloor:
{
    ; If the boss has been beaten in this room don't move the floor anymore.
    LDA.w $0403 : AND.b #$80 : BEQ .bossNotDead
        STZ.b $AD
        
        RTL

    .bossNotDead

    REP #$30
    
    ; Set moving floor speeds to zero, both X and Y velocities.
    STZ.w $0312 : STZ.w $0310
    
    ; Test the low bit of $041A[2].
    ; The low bit of that variable disables floor movement.
    LDA.w $041A : LSR A : BCS .return
        ; X = the bit 1 of $041A[2]
        ASL A : AND.w #$0002 : TAX
        
        ; $041C[2] += 0x8000
        LDA.w $041C : CLC : ADC.w #$8000 : STA.w $041C
        
        ; If $041C[2] was negative before the addition, then A = 1, otherwise
        ; A = 0.
        ROL A : AND.w #$0001
        
        CPX.w #$0002 : BNE .notInverted
            ; Invert the accumulator, thus A = A *-1.
            EOR.w #$FFFF : INC A

        .notInverted

        LDX.w $041A : CPX.w #$0004 : BCS .vertical
            ; Set the horizontal floor movement speed.
            STA.w $0312
            
            LDA.w $0422 : SEC : SBC.w $0312 : STA.w $0422
            
            CLC : ADC.b $E2 : STA.b $E0
            
            SEP #$30
            
            RTL

        .vertical

        ; Tells the floor to move in a Y direction instead.
        ; Set the vertical floor movement speed.
        STA.w $0310
            
        LDA.w $0424 : SEC : SBC.w $0310 : STA.w $0424
        
        CLC : ADC.b $E8 : STA.b $E6

    .return

    SEP #$30
    
    RTL
}

; ==============================================================================
   
; $057EEE-$057F0C JUMP LOCATION
Effect_MovingFloor2:
{
    REP #$20
    
    ; Causes the background to move by the amounts specified by the variables
    ; below.
    LDA.w $0422 : CLC : ADC.w $0312 : STA.w $0422
    LDA.w $0424 : CLC : ADC.w $0310 : STA.w $0424
    
    ; Sets the velocities of the background to zero, meaning they must be set
    ; again for the bg to continue moving.
    STZ.w $0312 : STZ.w $0310
    
    SEP #$20
    
    RTL
}

; ==============================================================================
    
; $057F0D-$057F5C JUMP LOCATION
Effect_RedFlashes:
{
    LDA.b $1A : AND.b #$7F
    
    CMP.b #$03 : BEQ .redFlash
        CMP.b #$05 : BEQ .restoreColors
            CMP.b #$24 : BEQ .redFlash
                CMP.b #$26 : BNE .noChange
                    .restoreColors

                    REP #$20
                    
                    LDA.l $7EC3DA : STA.l $7EC5DA
                    LDA.l $7EC3DC : STA.l $7EC5DC
                    
                    LDA.l $7EC3DE

                    .finishUp

                    STA.l $7EC5DE : STA.l $7EC5EE
                    
                    SEP #$20
                    
                    INC.b $15

                .noChange

                ; Put bg2 on the subscreen.
                LDA.b #$02 : STA.b $1D
                
                RTL

    .redFlash

    REP #$20
    
    LDA.w #$1D59 : STA.l $7EC5DA
    LDA.w #$25FF : STA.l $7EC5DC
    
    ; Change the sky to a very red color.
    LDA.w #$001A
    
    BRA .finishUp
}

; ==============================================================================

; Light torch to see floor?
; $057F5D-$057FA3 JUMP LOCATION
Effect_TorchHiddenTiles:
{
    REP #$30
    
    LDX.w #$0000 : STX.b $00

    .countLitTorches

        ; Special object tile position...
        LDA.w $0540, X : ASL A : BCC .notLit
            INC.b $00

        .notLit
    INX #2 : CPX.w #$0020 : BNE .countLitTorches
    
    ; Cause the tiles to be seen by setting them two bluish colors.
    LDX.w #$2940
    LDY.w #$4E60
    
    ; Check how many torches are lit  ; At least one is lit.
    LDA.b $00 : BNE .atLeastOne
        ; Hides the tiles by setting critical colors in the tiles' palette
        ; to black.
        LDX.w #$0000
        LDY.w #$0000

    .atLeastOne

    TXA : CMP.l $7EC3F6 : BEQ .matchesAuxiliary
        STA.l $7EC3F6 : STA.l $7EC5F6 ; Changing a palette value.
        
        TYA : STA.l $7EC3F8 : STA.l $7EC5F8
        
        ; Tell NMI to reupload CGRAM data.
        INC.b $15

    .matchesAuxiliary

    SEP #$30
    
    ; Enable bg2 on the subscreen.
    LDA.b #$02 : STA.b $1D
    
    RTL
}

; ==============================================================================

; $057FA4-$057FDD JUMP LOCATION
Effect_TorchGanonRoom:
{
    ; Initialize number of lit torches to zero.
    STZ.w $04C5
    
    REP #$30
    
    LDX.w #$0000

    .nextTorch

        LDA.w $0540, X : ASL A : BCC .notLit
            INC.w $04C5

        .notLit

        ; Only check the first 3 torches in memory. (this probably causes bugs
        ; in some hacks) Cycle through all the torche.
    INX #2 : CPX.w #$0006 : BNE .nextTorch
    
    SEP #$30
    
    LDA.w $04C5 : BNE .oneLit
        ; Effectively this darkens the room so you can't see Ganon
        ; diable all layers on the subscreen.
        STZ.b $1D
        
        ; $9A = !CGSUB | !CGBG0 | !CGBG1 | !CGOBJ | !CGBGD
        LDA.b #$B3 : STA.b $9A
        
        RTL

    .oneLit

    ; Only one torch is lit in Ganon's room.
    CMP.b #$01 : BNE .fullyLit
        ; Put BG1 on the subscreen    
        LDA.b #$02 : STA.b $1D
        
        ; $9A = !CGADDHALF | !CGOBJ | !CGBGD
        LDA.b #$70 : STA.b $9A
        
        RTL

    .fullyLit

    ; Since BG1 does not participate in color math anymore, it appears
    ; normal (fully lit).
    STZ.b $1D ; Take BG1 off of the subscreen.
    
    ; $9A = !CGADDHALF | !CGOBJ | !CGBGD
    LDA.b #$70 : STA.b $9A
    
    RTL
}

; ==============================================================================

; $057FDE-$057FFA JUMP LOCATION
Effect_MovingWater:
{
    REP #$21
    
    ; $041C alternates between being negative and non negative.
    LDA.w #$8000 : ADC.w $041C : STA.w $041C
    
    ; Effectively this means that $00 alternates between being 0 and 1 each
    ; frame.
    ROL A : AND.w #$0001 : STA.b $00
    
    ; Adjust the horizontal position of the water background by either 0 or
    ; -1.
    LDA.w #$0000 : SEC : SBC.b $00 : STA.w $0312
    
    SEP #$20
    
    RTL
}

; ==============================================================================

; $057FFB-$057FFF NULL
NULL_0AFFFB:
{
    db $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $0B8000