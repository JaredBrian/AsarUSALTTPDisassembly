; ==============================================================================

; Bank 02
; $010000-$017FFF BANK
org $028000

; A lot of the main dungeon and overworld game engine functions live here.
;
; MainRouting Modules: (defined in Bank00)
;   - LoadFile       0x05
;   - PreDungeon     0x06
;   - Dungeon        0x07
;   - PreOverworld   0x08
;   - Overworld      0x09
;   - CloseSpotlight 0x0F
;   - Victory
;   - BossVictory
;   - LoadMusic
;   - TriforceRoom   0x19
;   - LocationMenu   0x1B

; ==============================================================================

; $010000-$010053 LONG JUMP LOCATION
Intro_SetupScreen:
{
    ; Indicate to NMI that updates to sprites will not be occurring.
    LDA.b #$80 : STA.w $0710

    ; Resets screen and HDMA.
    JSL EnableForceBlank

    ; Only enable OBJ on main screen.
    LDA.b #$10 : STA.b $1C

    ; Subscreen has nothing on it.
    STZ.b $1D

    JSR.w Intro_InitBgSettings

    ; Indicates that clipping is done using the inverted window mask mode.
    LDA.b #$20 : STA.b $99

    ; Sets sprites to 8x8 or 16x16, name select to 0, and puts sprite tables
    ; at 0x4000 and 0x5000 in VRAM (word addresses).
    LDA.b #$02 : STA.w $2101

    ; This selects the offset to load the "Nintendo" sprite graphics pack.
    LDA.b #$14 : STA.w $0AAA

    JSL Graphics_LoadChrHalfSlot

    ; Reset this setting because we only needed it for loading the "Nintendo" logo.
    STZ.w $0AAA

    JSR.w Overworld_LoadMusicIfNeeded

    REP #$20

    LDX.b #$80 : STX.w $2115

    ; Target vram address is $27F0 (word).
    LDA.w #$27F0 : STA.w $2116

    LDX.b #$20 : LDA.w #$7FFF

    ; Will plug initialize sprite palette 1 to be completely white.
    .initSP1

        ; Zero out this portion of VRAM.
        STZ.w $2118

        STA.l $7EC620, X
    DEX #2 : BPL .initSP1

    LDA.w #$1FFE : STA.b $C8
    LDA.w #$1BFE : STA.b $CA

    SEP #$20

    RTL
}

; ==============================================================================

; $010054-$010115 LONG JUMP LOCATION
Intro_ValidateSram:
{
    REP #$30

    STZ.b $00

    .checkNextSlot

        ; $848C contains the offsets for each sram save slot. i.e. #$0000,
        ; #$500, #$A00.
        LDX.b $00 : LDA.l SaveFileCopyOffset, X : TAX : PHX

        LDY.w #$0000 : TYA

        .calcChecksum

            ; Compute the checksum of the save file.
            CLC : ADC.l $700000, X

            ; Since #$280 = #$500 / 2, we'll loop through #$500 bytes.
            INX #2
        INY : CPY.w #$0280 : BNE .calcChecksum

        ; Restore the sram save file offset.
        PLX

        ; If it worked, go to the next file.
        ; See if the checksum adds up to this value.
        CMP.w #$5A5A : BEQ .prepareNextSlot
            ; If not...
            PLX

            ; Try the mirrored version.
            LDY.w #$0000 : TYA

            .calcMirrorSum

                ; This time we check the mirrored version #$F00 bytes ahead.
                CLC : ADC.l $700F00, X

                INX #2
            INY : CPY.w #$0280 : BEQ .calcMirrorSum

            ; Restore the sram save file offset.
            PLX

            ; Do the same check to see if it adds up correctly.
            ; If it didn't add up correctly again, just go and delete it.
            CMP.w #$5A5A : BNE .delete

                LDY.w #$0000

                .restoreLoop

                    ; If it check outs, however, let's copy the good mirrored
                    ; version to The bad version's slot too!
                    LDA.l $700F00, X : STA.l $700000, X
                    LDA.l $701000, X : STA.l $700100, X
                    LDA.l $701100, X : STA.l $700200, X
                    LDA.l $701200, X : STA.l $700300, X
                    LDA.l $701300, X : STA.l $700400, X

                    INX #2
                INY : CPY.w #$0080 : BNE .restoreLoop

        .prepareNextSlot

        ; Then when we're done, move on to the next save slot.
        INC.b $00 : INC.b $00
    ; There is no fourth save slot, so if the index is 0x06, we're done.
    LDX.b $00 : CPX.w #$0006 : BNE .checkNextSlot

    ; If we're done, let X = #$FE.
    LDX.w #$00FE

    .zeroLoop

        ; Then zero out the memory region between $0D00 and $0FFF.
        STZ.w $0D00, X : STZ.w $0E00, X : STZ.w $0F00, X
    DEX #2 : BPL .zeroLoop

    SEP #$30

    ; Finally we're done.
    RTL

    .delete

    ; Load Y with a big fat zero.
    LDY.w #$0000 : TYA

    .deleteLoop

        ; We're going to zero out the whole save file. Are you happy? You
        ; created a corrupt file!
        STA.l $700F00, X : STA.l $700000, X
        STA.l $701000, X : STA.l $700100, X
        STA.l $701100, X : STA.l $700200, X
        STA.l $701200, X : STA.l $700300, X
        STA.l $701300, X : STA.l $700400, X

        ; Don't forget that 0x80 is half of 0x100, so this make sense.
        INX #2
    DEY : CPY.w #$0080 : BNE .deleteLoop

    BRA .prepareNextSlot
}

; ==============================================================================

; $010116-$01011D LONG JUMP LOCATION
Intro_LoadTextPointersAndPalettes:
{
    JSL Text_GenerateMessagePointers

    .justPalettes

    JSR.w Intro_LoadPalettes

    RTL
}

; ==============================================================================

; $01011E-$010135 DATA TABLE
AnimatedTileSheets:
{
    ; 0x18 entries used for animated tiles.
    db $5D, $5D, $5D, $5D, $5D, $5D, $5D, $5F
    db $5D, $5F, $5F, $5E, $5F, $5E, $5E, $5D
    db $5D, $5E, $5D, $5D, $5D, $5D, $5D, $5D
}

; ==============================================================================

; Beginning of Module 5: Loading Game Mode.
; $010136-$010207 LONG JUMP LOCATION
Module_LoadFile:
{
    ; Disable Screen (force blank).
    JSL EnableForceBlank

    ; Initialize a bunch of tagalong, submodule and other related variables
    ; (document these at some point in the future, but for now they're just
    ; confusing).
    STZ.w $0200
    STZ.w $03F4
    STZ.w $02D4
    STZ.w $02D7
    STZ.w $02F9
    STZ.w $0379
    STZ.w $03FD

    JSL Vram_EraseTilemaps.normal

    ; Set OAM CHR position to $8000 (byte) / $4000 (word) in VRAM.
    LDA.b #$02 : STA.w $2101

    JSL LoadDefaultGfx
    JSL Sprite_LoadGfxProperties
    JSL Init_LoadDefaultTileAttr
    JSL DecompSwordGfx
    JSL DecompShieldGfx
    JSL Init_Player
    JSL Tagalong_LoadGfx

    ; Is this even useful? Seems to set all sprite graphics slots to default
    ; graphics sets really, because they're all the same.
    LDA.b #$46 : STA.l $7EC2FC
                 STA.l $7EC2FD
                 STA.l $7EC2FE
                 STA.l $7EC2FF

    ; The Zelda message tagalong counter is 0x200 (frames).
                 STZ.w $02CD
    LDA.b #$02 : STA.w $02CE

    ; V-IRQ triggers at scanline 0x30.
    LDA.b #$30 : STA.b $FF

    ; Check if we're in the dark world.
    LDA.l $7EF3CA : BEQ .inLightWorld
        ; We're in the dark world, but are we in a dungeon?
        LDA.b $1B : BNE .indoors
            JSL Equipment_DrawItem
            JSL HUD.RebuildLong2
            JSL Equipment_UpdateEquippedItemLong

            ; Dying outside in the Dark World apparently doesn't have any
            ; bearing on the next load.
            STZ.w $010A

            ; This is the exit that takes Link to the Pyramid of Power. It's
            ; done this way because the PreOverworld module operates via
            ; exits. rather than area numbers.
            LDA.b #$20 : STA.b $A0
                         STZ.b $A1

            ; Go to pre-overworld mode.
            LDA.b #$08 : STA.b $10

            STZ.b $11
            STZ.b $B0

            STZ.w $04AA

            RTL

    .inLightWorld

    ; If mosaic enabled, branch? This makes very little sense.
    LDA.l $7EC011 : BNE .indoors
        LDA.w $010A : BEQ .notSavedAndContinue
            ; See if we need to load a starting point entrance.
            LDA.w $04AA : BEQ .indoors

        .notSavedAndContinue

        ; If we're not in game state 2 yet, $7EF3C8 alone decides the starting
        ; location.
        LDA.l $7EF3C5 : CMP.b #$02 : BCC .indoors
            ; If we got here, it means we're in game state 2 or above.

            ; Only starting location 5 is enforced when the game state is >=
            ; 0x02. I didn't even realize this until recently (9/19/2007) but
            ; this is a starting location that only happens if you die on the
            ; way to returning the Old Man to his cave. It's like 2 rooms, but
            ; I guess they figured some people would really really suck at the
            ; game. So they made starting location 5 put you in the cave where
            ; you meet the old man. I guess the only way you'd conceivably die 
            ; is from pits or enemies outside.
            LDA.l $7EF3C8 : CMP.b #$05 : BEQ .indoors
                REP #$10

                LDX.w #$0185

                ; Does Link have the mirror?
                LDA.l $7EF353 : CMP.b #$02 : BEQ .hasMirror
                    ; Add the extra entrance to Old Man's cave.
                    LDX.w #$0184

                .hasMirror

                STX.w $1CF0

                SEP #$10

                JSL Main_ShowTextMessage
                JSR.w Dungeon_LoadPalettes

                LDA.b #$0F : STA.b $13

                LDA.b #$04 : STA.b $1C

                STZ.b $1D

                ; Bring up the box that asks where you'd like to start from.
                ; Module 1B will fake a text mode engine and wait for input.
                LDA.b #$1B : STA.b $10

                RTL

    .indoors

    ; Bleed into the next function.
}

; $010208-$01021D LONG JUMP LOCATION
LoadDungeonRoomRebuildHUD:
{
    LDA.b #$00 : STA.l $7EC011

    ; Apply mosaic settings to BGs 1,2, and 3.
    ORA.b #$07 : STA.b $95

    JSL Equipment_DrawItem
    JSL HUD.RebuildLong2
    JSL Equipment_UpdateEquippedItemLong

    ; Bleed into the next function.
}

; Beginning of Module 6: Pre-Dungeon Mode
; $01021E-$0103B4 LONG JUMP LOCATION
Module_PreDungeon:
{
    REP #$20

    ; Play an ambient sound effect. (This one is probably silence).
    LDA.w #$0005 : STA.w $012D

    ; Zero out the dungeon room index and the previous dungeon room index.
    STZ.b $A0 : STZ.b $A2

    ; Initialize the room's memory record.
    STZ.w $0402

    LDA.w #$0000

    ; Initialize some color filtering variables related to agahnim.
    STA.l $7EC019 : STA.l $7EC01B : STA.l $7EC01D
    STA.l $7EC01F : STA.l $7EC021 : STA.l $7EC023

    SEP #$20

    JSR.w Dungeon_LoadEntrance

    ; Tell me what level I'm in. (swamp palace, misery mire, etc.)
    ; 0xff means it's not a true dungeon. Don't need keys. Etc..
    LDA.w $040C : CMP.b #$FF : BEQ .notPalace
        ; Is it Hyrule Castle 1?
        CMP.b #$02 : BNE .notHyruleCastle
            ; I guess we treat the Hyrule castle keys the same as the Sewer
            ; ones. Why? Because for some reason the developers want them to be
            ; considered the same dungeon in most cases. That's why!
            LDA.b #$00

        .notHyruleCastle

        LSR A : TAX

        ; Load the number of keys for this dungeon from gameplay data.
        LDA.l $7EF37C, X

    .notPalace

    JSL RebuildHUD_Keys

    STZ.w $045A
    STZ.w $0458

    JSR.w Dungeon_LoadAndDrawRoom

    ; Then, Draws BG0 and 1 tilemaps into VRAM from $7E2000 and $7E4000.
    ; Loads graphics dependent behavior types for tiles.
    JSL Dungeon_LoadCustomTileAttr

    ; Derived from entrance index.
    LDX.w $0AA1

    LDA.l AnimatedTileSheets, X : TAY

    JSL DecompDungAnimatedTiles
    JSL Dungeon_LoadAttrTable

    LDA.b #$0A : STA.w $0AA4

    JSL InitTilesets

    ; Specify the tileset for throwable objects (rocks, pots, etc).
    LDA.b #$0A : STA.w $0AB1

    JSR.w Dungeon_LoadPalettes

    LDA.w $02E0 : ORA.b $56 : BEQ .player_not_using_bunny_gfx
        JSL LoadGearPalettes.bunny

    .player_not_using_bunny_gfx

    REP #$30

    LDA.b $A0 : AND.w #$000F : ASL A  : XBA : STA.w $062C
    LDA.b $A0 : AND.w #$0FF0 : LSR #3 : XBA : STA.w $062E

    LDA.b $A0 : CMP.w #$0104 : BNE .notLinksHouse
        LDA.l $7EF3C6 : AND.w #$0010 : BEQ .hasNoEquipment
            ; Apparently under these conditions a room can never be dark?
            LDA.w #$0000 : STA.l $7EC005

        .hasNoEquipment
    .notLinksHouse
    
    SEP #$30

    JSL SetAndSaveVisitedQuadrantFlags

    ; Set color addition parameters.
    LDA.b #$02 : STA.b $99
    LDA.b #$B3 : STA.b $9A

    ; Check light level in room.
    LDX.w $045A

    LDA.l $7EC005 : BNE .darkTransition
        LDX.b #$03

        ; Have a look at the BG2 setting.
        LDY.w $0414 : BEQ .defaultGfxSetting
            LDA.b #$32

            ; If "addition":
            CPY.b #$07 : BEQ .customColorMath
                LDA.b #$62

                ; If "translucent":
                CPY.b #$04 : BEQ .customColorMath

        .defaultGfxSetting

        LDA.b #$20

        .customColorMath

        STA.b $9A

    .darkTransition

    LDA.l RoomEffectFixedColors, X : STA.l $7EC017

    JSL Dungeon_ApproachFixedColor_variable

    LDA.b #$1F : STA.l $7EC007
    LDA.b #$00 : STA.l $7EC008
    LDA.b #$02 : STA.l $7EC009

    STZ.w $0AA9
    STZ.b $57
    STZ.b $3A
    STZ.b $3C

    JSR.w Dungeon_ResetTorchBackgroundAndPlayer
    JSL Link_CheckBunnyStatus
    JSR.w ResetThenCacheRoomEntryProperties

    LDA.l $7EF3CC : CMP.b #$0D : BNE .notSuperBombTagalong
        ; If we saved the game having a super bomb, sad to say it's going to be
        ; gone.
        LDA.b #$00 : STA.l $7EF3CC

        STZ.w $04B4

        JSL FloorIndicator_hideIndicator

    .notSuperBombTagalong

    LDA.b #$09 : STA.b $94

    JSL Tagalong_Init
    JSL Sprite_ResetAll
    JSL Dungeon_ResetSprites

    STZ.w $02F0

    INC.w $04C7

    LDA.l $7EF3C5 : BNE .notOpeningScene
        LDA.l $7EF3C6 : AND.b #$10 : BNE .notOpeningScene
            ; Set fixed color at the very start of the game to a .... bluish
            ; tint I guess.
            LDA.b #$30 : STA.b $9C
            LDA.b #$50 : STA.b $9D
            LDA.b #$80 : STA.b $9E

            LDA.b #$00 : STA.l $7EC005 : STA.l $7EC006

            ; Puts Link into a sleep state at the beginning of the game.
            JSL Link_TuckIntoBed

    .notOpeningScene

    ; Put us into the dungeon module.
    LDA.b #$07 : STA.w $010C : STA.b $10

    ; With initial state 0x0F...
    LDA.b #$0F : STA.b $11

    JSR.w Dungeon_LoadSongBankIfNeeded

    ; $01038C ALTERNATE ENTRY POINT
    .setAmbientSfx

    ; If worldstate >= 2:
    LDA.l $7EF3C5 : CMP.b #$02 : BCS .noAmbientRainSfx
        ; By default set the ambient sound effect to silence.
        LDA.b #$05 : STA.w $012D

        LDA.b $A4 : BMI .noAmbientRainSfx
            REP #$20

            ; If this is the sewer room right before sanctuary.
            LDA.b $A0 : CMP.w #$0002 : BEQ .noAmbientRainSfx
                ; Is it Sanctuary itself?
                CMP.w #$0012 : BEQ .noAmbientRainSfx
                    SEP #$20

                    ; Play the rain ambient sound effect.
                    LDA.b #$03 : STA.w $012D

    .noAmbientRainSfx

    SEP #$20

    RTL
}

; ==============================================================================

; $0103B5-$0103B8 LONG JUMP LOCATION
CacheRoomEntryProperties_long:
{
    JSR.w CacheRoomEntryProperties

    RTL
}

; ==============================================================================

; $0103B9-$0103BE LOCAL JUMP TABLE
PreOverworld_JumpTable:
{
    dw PreOverworld_LoadProperties           ; 0x00 - $83C7 
    dw Overworld_LoadSubscreenAndSilenceSFX1 ; 0x01 - $AF19
    dw PreOverworld_LoadAndAdvance           ; 0x02 - $EDB9
}

; Module 0x08, 0x0A - Pre Overworld Mode (0x08) and Pre Overworld Mode for
; special overworlds (0x0A).
; $0103BF-$0103C6 LONG JUMP LOCATION
Module_PreOverworld:
{
    LDA.b $11 : ASL A : TAX

    JSR.w (PreOverworld_JumpTable, X)

    RTL
}

; ==============================================================================

; Module 0x08.0x00, 0x0A.0x00 - Loads palettes.
; ZS overwrites most of this function. - ZS Custom Overworld
; $0103C7-$010569 LOCAL JUMP LOCATION
PreOverworld_LoadProperties:
{
    ; Clip colors to black before color math inside the color window (this
    ; logic may be inverted by another register, though). Also enables
    ; subscreen addition rather than fixed color addition.
    LDA.b #$82 : STA.b $99

    ; Cane of Somaria variable?
    STZ.w $03F4

    ; If Link has moon pearl, load his default graphic states and otherwise.
    JSL AdjustBunnyLinkStatus

    ; Special branch for if you are outside the normal overworld area e.g.
    ; Master Sword woods.
    LDA.b $10 : CMP.b #$08 : BNE .specialArea
        JSR.w Overworld_LoadExitData

        BRA .normalArea

    .specialArea

    JSR.w LoadOverworldFromSpecialOverworld

    .normalArea

    JSL Overworld_SetSongList

    ; We have no keys on the overworld.
    LDA.b #$FF : STA.l $7EF36F

    JSL HUD_RefillLogicLong

    ; ZS starts writing here.
    ; $0103EE - ZS Custom Overworld
    ; This is for later on when we load the animated tiles. Loads the clouds.
    LDY.b #$58

    ; Not sure what theme this is. might be the beginning song.
    LDX.b #$02

    LDA.b $8A

    CMP.b #$03 : BEQ .setCustomSong
    CMP.b #$05 : BEQ .setCustomSong
    CMP.b #$07 : BEQ .setCustomSong
        ; Death mountain theme.
        LDX.b #$09

        LDA.b $8A

        CMP.b #$43 : BEQ .setCustomSong
        CMP.b #$45 : BEQ .setCustomSong
        CMP.b #$47 : BEQ .setCustomSong
            ; This is for later on when we load the animated tiles. Loads the
            ; water.
            LDY.b #$5A

            ; If we're in the dark world.
            LDA.b $8A : CMP.b #$40 : BCS .darkWorld
                ; Default village theme.
                LDX.b #$07

                ; Check what phase we're in (If less than phase 3).
                LDA.l $7EF3C5 : CMP.b #$03 : BCC .beforeAgahnim
                    ; Default light world theme.
                    LDX.b #$02

                .beforeAgahnim

                ; Were we just in the smithy's well?
                LDA.b $A0 : CMP.b #$E3 : BEQ .setCustomSong

                ; Or were we just near a hole with a big fairy?
                CMP.b #$18 : BEQ .setCustomSong

                ; Or were we just in the village hole?
                CMP.b #$2F : BEQ .setCustomSong

                LDA.b $A0 : CMP.b #$1F : BNE .notWeirdoShopInVillage
                    ; Check if we're entering the village.
                    LDA.b $8A : CMP.b #$18 : BEQ .setCustomSong

                .notWeirdoShopInVillage

                LDX.b #$05

                ; Check if we've received the master sword yet or not.
                LDA.l $7EF300 : AND.b #$40 : BEQ .noMasterSword
                    ; Set music to default Light World theme.
                    LDX.b #$02

                .noMasterSword

                LDA.b $A0  : BEQ .setCustomSong
                CMP.b #$E1 : BEQ .setCustomSong

            .darkWorld

            LDX.b #$F3

            ; If the volume was set to half, set it back to full.
            LDA.w $0132 : CMP.b #$F2 : BEQ .setSong
                ; Use the normal overworld (light world) music.
                LDX.b #$02

                ; Check phase. In phase >= 2.
                LDA.l $7EF3C5 : CMP.b #$02 : BCS .setCustomSong
                    ; If phase < 2, play the legend music.
                    LDX.b #$03

    .setCustomSong

    ; Check world status.
    LDA.l $7EF3CA : BEQ .setSong
        ; Not in the lightworld, so play the dark woods theme.
        LDX.b #$0D

        ; But only in certain OW areas.
        LDA.b $8A : CMP.b #$40 : BEQ .checkMoonPearl
            ; Check a certain list of overworld locations that have the dark
            ; forest theme.
            CMP.b #$43 : BEQ .checkMoonPearl
            CMP.b #$45 : BEQ .checkMoonPearl
            CMP.b #$47 : BEQ .checkMoonPearl
                ; Otherwise play the normal dark world overworld music.
                LDX.b #$09

        .checkMoonPearl

        ; Does Link have a moon pearl?
        LDA.l $7EF357 : BNE .setSong
            ; If not, play that stupid music that plays when you're a bunny in
            ; the Dark World.
            LDX.b #$04

    .setSong

    ; The value written here will take effect during NMI.
    STX.w $0132

    ; This forces the game to update the animated tiles when going from one
    ; area to another.
    JSL DecompOwAnimatedTiles

    ; Decompress all other graphics.
    JSL InitTilesets

    ; Load palettes for overworld.
    JSR.w Overworld_LoadAreaPalettes

    LDX.b $8A

    LDA.l $7EFD40, X : STA.b $00

    LDA.l OverworldPalettesScreenToSet, X

    ; Load some other palettes.
    JSL Overworld_LoadPalettes

    ; Sets the background color (changes depending on area).
    JSL Palette_SetOwBgColor_Long

    LDA.b $10 : CMP.b #$08 : BNE .specialArea2
        ; Copies $7EC300[0x200] to $7EC500[0x200].
        JSR.w Overworld_CopyPalettesToCache_WithPrep

        BRA .normalArea2

    .specialArea2

    ; Apparently special overworld handles palettes a bit differently?
    JSR.w SpecialOverworld_CopyPalettesToCache

    .normalArea2

    JSL Overworld_SetFixedColorAndScroll ; Sets fixed colors and scroll values.

    ; Something fixed color related.
    LDA.b #$00 : STA.l $7EC017

    ; Sets up properties in the event a tagalong shows up.
    JSL Tagalong_Init

    LDA.b $8A : AND.b #$3F : BNE .notForestArea
        LDA.b #$1E

        JSL GetAnimatedSpriteTile.variable

    .notForestArea

    LDA.b #$09 : STA.w $010C

    JSL Sprite_OverworldReloadAll

    ; Are we in the dark world? If so, there's no warp vortex there.
    LDA.b $8A : AND.b #$40 : BNE .noWarpVortex
        JSL Sprite_ReinitWarpVortex

    .noWarpVortex

    ; The sound of silence (as in, no ambient sound effect).
    LDX.b #$05

    LDA.l $7EF3C5 : CMP.b #$02 : BCS .dontMakeRainSound
        ; Ambient rain noise.
        LDX.b #$01

    .dontMakeRainSound

    STX.w $012D

    ; Check if Blind disguised as a crystal maiden was following us when we
    ; left the dungeon area.
    LDA.l $7EF3CC : CMP.b #$06 : BNE .notBlindGirl
        ; If it is Blind, kill her!
        LDA.b #$00 : STA.l $7EF3CC

    .notBlindGirl

    STZ.b $6C
    STZ.b $3A
    STZ.b $3C
    STZ.b $50
    STZ.b $5E
    STZ.w $0351

    ; Reinitialize many of Link's gameplay variables.
    JSR.w DeleteCertainAncillaeStopDashing

    LDA.l $7EF357 : BNE .notBunny
        LDA.l $7EF3CA : BEQ .notBunny
            LDA.b #$01 : STA.w $02E0 : STA.b $56

            LDA.b #$17 : STA.b $5D

            JSL LoadGearPalettes.bunny

    .notBunny

    ; Set screen to mode 1 with BG3 priority.
    LDA.b #$09 : STA.b $94

    LDA.b #$00 : STA.l $7EC005

    STZ.w $046C
    STZ.b $EE
    STZ.w $0476

    INC.b $11
    INC.b $16

    STZ.w $0402 : STZ.w $0403

    ; $01054C ALTERNATE ENTRY POINT
    Overworld_LoadMusicIfNeeded:

    LDA.w $0136 : BEQ .no_music_load_needed
        SEI

        ; Shut down NMI until music loads.
        STZ.w $4200

        ; Stop all HDMA.
        STZ.w $420C

        STZ.w $0136

        LDA.b #$FF : STA.w $2140

        JSL Sound_LoadLightWorldSongBank

        ; Re-enable NMI and joypad.
        LDA.b #$81 : STA.w $4200

    .no_music_load_needed

    RTS
}

; ==============================================================================

; $01056A-$01056F LONG JUMP LOCATION
AdjustBunnyLinkStatus:
{
    ; Do we have the Moon pearl?
    LDA.l $7EF357 : BEQ ForceNonBunnyStatus_noMoonPearl
        ; Bleeds into the next function.
}

; $010570-$010582 LONG JUMP LOCATION
ForceNonBunnyStatus:
{
    ; Set Link's initial state.
    LDA.b #$00 : STA.b $5D

    ; Link is not a bunny, so reset variables relating to his bunny
    ; transformation state.
    STZ.w $03F5
    STZ.w $03F6
    STZ.w $03F7

    ; Link's graphics are his normal ones, not bunny.
    STZ.b $56
    STZ.w $02E0

	.noMoonPearl

    RTL
}

; ==============================================================================

; $010583-$010585 DATA TABLE
Pool_Module_LocationMenu:
{
    .starting_points
    db $00 ; Link's House
    db $01 ; Sanctuary
    db $06 ; Mountain Cave
}

; Beginning of Module 0x1B - Start Location Select, screen to select where to
; start from (House, sanctuary, etc.)
; $010586-$0105B3 LONG JUMP LOCATION
Module_LocationMenu:
{
    JSL Messaging_Text

    LDA.b $11 : BNE .notBaseSubmodule
        STZ.b $14

        JSL EnableForceBlank
        JSL Vram_EraseTilemaps.normal

        LDA.l $7EF3C8 : PHA

        LDX.w $1CE8

        LDA.l Pool_Module_LocationMenu_starting_points, X : STA.l $7EF3C8

        STZ.b $B0

        ; Finish up with pre dungeon mode after the selection is made.
        JSL LoadDungeonRoomRebuildHUD

        PLA : STA.l $7EF3C8

	.notBaseSubmodule

    RTL
}

; ==============================================================================

; $0105B4-$0105B9 LOCAL JUMP TABLE
Credits_LoadScene_OverworldJumpTable
{
    dw Credits_LoadScene_Overworld_PrepGFX ; 0x00 - $8604
    dw Credits_LoadScene_Overworld_Overlay ; 0x01 - $8697
    dw Credits_LoadScene_Overworld_LoadMap ; 0x02 - $86A5
}

; Note: ending sequence code.
; $0105BA-$0105C1 LONG JUMP LOCATION
Credits_LoadScene_Overworld:
{
    ; As usual, the level 2 submodule index.
    LDA.b $B0 : ASL A : TAX
    JSR (Credits_LoadScene_OverworldJumpTable, X)

    RTL
}

; ==============================================================================

; $0105C2-$010603 DATA TABLE
Pool_Credits_LoadScene_Overworld_PrepGFX:
{
    ; $0105C2
    .screen
    dw $1000 ; Overworld
    dw $0002 ; Dungeon
    dw $1002 ; Overworld
    dw $1012 ; Overworld
    dw $1004 ; Tower of Hera
    dw $1006 ; Link's House
    dw $1010 ; Zora's Domain
    dw $1014 ; Potion Shop
    dw $100A ; Lumberjacks
    dw $1016 ; Haunted Grove
    dw $005D ; Wishing Well
    dw $0064 ; Smithery
    dw $100E ; Kakariko (bug net)
    dw $1008 ; Death Mountain
    dw $1018 ; Lost Woods
    dw $0180 ; Master Sword

    ; $0105E2
    .sprite_gfx
    dw $4628
    dw $2E27
    dw $2B2B
    dw $2C0E
    dw $291A
    dw $2847
    dw $2827
    dw $282A
    dw $012D

    ; $0105F3
    .sprite_palette
    dw $0140
    dw $0104
    dw $0101
    dw $0111
    dw $4701
    dw $0140
    dw $0101
    dw $0101
}

; ==============================================================================

; ZS rewrites the latter half of this function. - ZS Custom Overworld
; $010604-$010696 LOCAL JUMP LOCATION
Credits_LoadScene_Overworld_PrepGFX:
{
    JSL EnableForceBlank ; Sets the screen mode.
    JSL Vram_EraseTilemaps_normal

    ; Activates subscreen color add/subtract mode.
    LDA.b #$82 : STA.b $99

    REP #$20

    ; Load the level 1 submodule index.
    LDX.b $11

    ; Since this is called every other submodule.
    LDA.l Credits_LoadScene_Overworld_PrepGFX, X : STA.b $A0

    SEP #$20

    ; If this is the seventh sequence in the ending.
    CPX.b #$0C : BEQ .specialArea
    CPX.b #$1E : BEQ .specialArea
        JSR.w Overworld_LoadExitData

        BRA .normalArea

    .specialArea

    ; Needed for running sequence 0xC or 0x1E. This is because they are special
    ; outdoor areas (zora's domain and master sword).
    JSR.w LoadSpecialOverworld
    
    .normalArea

    STZ.w $012C ; No change of music.
    STZ.w $012D ; No change of sound effects.

    ; ZS starts writing here.
    ; $010632 - ZS Custom Overworld
    LDY.b #$58

    ; 0x03, 0x05, and 0x07 are all mountain areas.
    LDA.b $8A : AND.b #$BF

    CMP.b #$03 : BEQ .deathMountain
    CMP.b #$05 : BEQ .deathMountain
    CMP.b #$07 : BEQ .deathMountain
        ; Just load a different overlay in that case.
        LDY.b #$5A

    .deathMountain

    JSL DecompOwAnimatedTiles

    LDA.b $11 : LSR A : TAX

    LDA.l Pool_Credits_LoadScene_Overworld_PrepGFX_sprite_gfx, X : STA.w $0AA3

    LDA.l Pool_Credits_LoadScene_Overworld_PrepGFX_sprite_palette, X : PHA

    JSL InitTilesets

    ; Load Palettes.
    JSR.w Overworld_LoadAreaPalettes

    PLA : STA.b $00

    LDX.b $8A

    LDA.l OverworldPalettesScreenToSet, X

    JSL Overworld_LoadPalettes

    LDA.b #$01 : STA.w $0AB2

    JSL Palette_Hud

    LDA.b $11 : BNE .BRANCH_4
        JSL CopyFontToVram

    .BRANCH_4

    JSR.w Overworld_CopyPalettesToCache_WithPrep
    JSL Overworld_SetFixedColorAndScroll

    LDA.b $8A : CMP.b #$80 : BCC .BRANCH_5
        JSL Palette_SetOwBgColor_Long

    .BRANCH_5

    LDA.b #$09 : STA.b $94

    INC.b $B0

    RTS
}

; ==============================================================================

; $010697-$0106A4 LOCAL JUMP LOCATION
Credits_LoadScene_Overworld_Overlay:
{
    JSR.w Overworld_ReloadSubscreenOverlay

    STZ.w $012C
    STZ.w $012D

    DEC.b $11

    INC.b $B0

    RTS
}

; $0106A5-$0106B2 LOCAL JUMP LOCATION
Credits_LoadScene_Overworld_LoadMap:
{
    JSR.w Overworld_LoadAndBuildScreen
    JSL Credits_PrepAndLoadSprites
    STZ.b $C8
    STZ.b $C9
    STZ.b $B0

    RTS
}

; $0106B3-$0106BF LONG JUMP LOCATION
Credits_OperateScrollingAndTilemap:
{
    JSL Credits_HandleCameraScrollControl

    LDA.w $0416 : BEQ .alpha
        JSR.w Overworld_ScrollMap

    .alpha

    RTL
}

; $0106C0-$0106FC LONG JUMP LOCATION
Credits_LoadCoolBackground:
{
    ; Not sure...
    LDA.b #$21 : STA.w $0AA1

    ; Loads the proper tile set for the scrolling view of Hyrule.
    LDA.b #$3B : STA.w $0AA2

    ; Sprite GFX index. used later in loading the "THE END" text.
    LDA.b #$2D : STA.w $0AA3

    ; Using the parameters above, loads all the necessary tile sets.
    JSL InitTilesets

    ; Put us at the pyrmaid of power.
    LDX.b #$5B : STX.b $8A

    ; Sets an index for setting $0AB8.
    LDA.b #$13 : STA.b $00

    LDA.l OverworldPalettesScreenToSet, X

    ; Loads several palettes based on the X = 0x5B above.
    JSL Overworld_LoadPalettes

    ; Reload the BG auxiliary 2 palette with a different value.
    LDA.b #$03 : STA.w $0AB5

    JSL Palette_OverworldBgAux2

    JSR.w Overworld_CgramAuxToMain

    JSR.w Overworld_ReloadSubscreenOverlay

    STZ.b $E6
    STZ.b $E7
    STZ.b $E0
    STZ.b $E1

    DEC.b $11

    RTL
}

; ==============================================================================

; This is only called from the ending module (1A). It's an initializer for the
; cinema sequences that are indoors.
; $0106FD-$01076B LONG JUMP LOCATION
Credits_LoadScene_Dungeon:
{
    JSL EnableForceBlank
    JSL Vram_EraseTilemaps_normal

    REP #$20

    LDX.b $11

    ; Load the dungeon entrance to use.
    LDA.l Pool_Credits_LoadScene_Overworld_PrepGFX_screen, X : STA.w $010E

    SEP #$20

    JSR.w Dungeon_LoadEntrance

    STZ.w $045A
    STZ.w $0458

    JSR.w Dungeon_LoadAndDrawRoom

    LDX.w $0AA1 : LDA.l AnimatedTileSheets, X : TAY

    JSL DecompDungAnimatedTiles

    LDA.b $11 : LSR A : TAX

    LDA.l Pool_Credits_LoadScene_Overworld_PrepGFX_sprite_gfx, X
    STA.w $0AA3

    LDA.l Pool_Credits_LoadScene_Overworld_PrepGFX_sprite_palette, X
    ASL #2 : TAX

    LDA.l $0ED462, X : STA.w $0AAD
    LDA.l $0ED463, X : STA.w $0AAE

    ; Use indoor liftable sprites (pointless for an ending but whatever).
    LDA.b #$0A : STA.w $0AA4

    JSL InitTilesets

    LDA.b #$0A : STA.w $0AB1

    JSR.w Dungeon_LoadPalettes

    ; Set screen mode.
    LDA.b #$09 : STA.b $94

    STZ.b $C8
    STZ.b $C9
    STZ.b $13

    INC.b $11

    ; Do sprite loading specific to ending mode.
    JSL Credits_PrepAndLoadSprites

    RTL
}

; ==============================================================================

; PARAMETER: X
; $01076C-$0107A1 LOCAL JUMP TABLE FOR MODULE 0x07
Module_DungeonTable:
{
    dw Dungeon_Normal               ; 0x00 - $88DE
    dw Dungeon_IntraRoomTrans       ; 0x01 - $897C
    dw Dungeon_InterRoomTrans       ; 0x02 - $8A26
    dw Dungeon_OverlayChange        ; 0x03 - $8C05
    dw Dungeon_OpeningLockedDoor    ; 0x04 - $8C0A
    dw Dungeon_ControlShutters      ; 0x05 - $8C0F
    dw Dungeon_FatInterRoomStairs   ; 0x06 - $8C14
    dw Dungeon_FallingTransition    ; 0x07 - $8E27

    dw Dungeon_NorthIntraRoomStairs ; 0x08 - $8F0C
    dw Dungeon_DestroyingWeakDoor   ; 0x09 - $900F
    dw Dungeon_ChangeBrightness     ; 0x0A - $9014
    dw Dungeon_TurnOffWater         ; 0x0B - $902D
    dw Dungeon_TurnOnWater          ; 0x0C - $904A
    dw Dungeon_Watergate            ; 0x0D - $904F
    dw Dungeon_SpiralStaircase      ; 0x0E - $9054
    dw Dungeon_LandingWipe          ; 0x0F - $931D

    dw Dungeon_SouthIntraRoomStairs ; 0x10 - $8F88
    dw Dungeon_StraightStairs       ; 0x11 - $9357
    dw Dungeon_StraightStairs       ; 0x12 - $9357
    dw Dungeon_StraightStairs       ; 0x13 - $9357
    dw Dungeon_RecoverFromFall      ; 0x14 - $9520
    dw Dungeon_Teleport             ; 0x15 - $967A
    dw Dungeon_UpdatePegs           ; 0x16 - $972A
    dw Dungeon_PressurePlate        ; 0x17 - $97C8

    dw Dungeon_Crystal              ; 0x18 - $980A
    dw Dungeon_MirrorFade           ; 0x19 - $98F7
    dw Dungeon_OpenGanonDoor        ; 0x1A - $9916
}

; ==============================================================================

; Module 0x07: Dungeon Mode
; $0107A2-$01085D LONG JUMP LOCATION
Module_Dungeon:
{
    SEP #$30

    JSL Effect_Handler

    LDA.b $11 : ASL A : TAX

    JSR (Module_DungeonTable, X)

    STZ.w $042C

    JSL PushBlock_Handler

    LDA.b $11 : BNE .enteredNonDefaultSubmodule
        JSL Graphics_LoadChrHalfSlot
        JSR.w Dungeon_HandleCamera

        LDA.b $11 : BNE .enteredNonDefaultSubmodule
            JSL Dungeon_CheckStairsAndRunScripts

            LDA.b $11 : BNE .enteredNonDefaultSubmodule
                JSL Dungeon_ProcessTorchAndDoorInteractives

                LDA.w $0454 : BEQ .blastWallNotOpening
                    JSL Door_BlastWallExploding

                .blastWallNotOpening

                ; Is Link standing in a door way?
                LDA.b $6C : BNE .standingInDoorway
                    ; Check if the player triggered an inter-room transition
                    ; this frame.
                    JSR.w Dungeon_TryScreenEdgeTransition

                .standingInDoorway
    .enteredNonDefaultSubmodule

    JSL OrientLampBg

    REP $21

    LDA.b $E2 : PHA :       ADC.w $011A : STA.b $E2 : STA.w $011E

    LDA.b $E8 : PHA : CLC : ADC.w $011C : STA.b $E8 : STA.w $0122

    LDA.b $E0 :       CLC : ADC.w $011A : STA.b $E0 : STA.w $0120

    LDA.b $E6 : PHA : CLC : ADC.w $011C : STA.b $E6 : STA.w $0124

    LDA.b $0428 : AND.w #$00FF : BEQ .noMovingFloor
        ; Adjusts BG0 by the offset of the moving floor.
        PLA : PLA

        LDA.w $0422 : CLC : ADC.b $E2 : STA.w $0120 : STA.b $E0 : PHA
        LDA.w $0424 : CLC : ADC.b $E8 : STA.w $0124 : STA.b $E6 : PHA

    .noMovingFloor

    SEP #$20

    ; Handle the sprites of pushed blocks.
    JSL Underworld_DrawAllPushBlocks
    JSL Sprite_Main

    REP #$20

    PLA : STA.b $E6
    PLA : STA.b $E0
    PLA : STA.b $E8
    PLA : STA.b $E2

    SEP #$20

    JSL PlayerOam_Main
    JSL HUD_RefillLogicLong
    JML FloorIndicator ; Handles HUD floor indicator.
}

; =====================================================

; $01085E-$0108C0 LOCAL JUMP LOCATION
Dungeon_TryScreenEdgeTransition:
{
    REP #$20

    LDA.b $30 : AND.w #$00FF : BEQ .noChangeY
        ; Is Link walking in the up or down direction?
        LDA.b $67 : AND.w #$000C : STA.b $00

        LDA.b $20 : AND.w #$01FF

        ; Up transition
        LDX.b #$03

        CMP.w #$0004 : BCC .triggerRoomTransition
            ; Down transition
            LDX.b #$02

            CMP.w #$01DC : BCS .triggerRoomTransition

    .noChangeY

    LDA.b $31 : AND.w #$00FF : BEQ .noChangeX
        ; See if Link is facing right or left.
        LDA.b $67 : AND.w #$0003 : STA.b $00

        LDA.b $22 : AND.w #$01FF

        ; Left transition
        LDX.b #$01

        CMP.w #$0008 : BCC .triggerRoomTransition
            ; Right transition
            LDX.b #$00

            CMP.w #$01E9 : BCC .noRoomTransition

        .triggerRoomTransition

        SEP #$20

        JSL Player_IsScreenTransitionPermitted : BCS .noRoomTransition
            ; Are we in dungeon mode?
            LDA.b $10 : CMP.b #$07 : BNE .noRoomTransition
                JSL Dungeon_StartInterRoomTrans

                LDA.b $10 : CMP.b #$07 : BNE .noRoomTransition
                    ; Set the submode to dungeon inter-room transition.
                    LDA.b #$02 : STA .b$11

        .noRoomTransition
    .noChangeX
    
    SEP #$20

    RTS
}

; ==============================================================================

; $0108C1-$0108C4 DATA TABLE
Pool_Dungeon_HandleEdgeTransitionMovement:
{
    .masks
    db $03, $03, $0C, $0C
}

; ==============================================================================

; $0108C5-$0108DD LONG JUMP LOCATION
Dungeon_StartInterRoomTrans:
{
    ; Forces Link to be moving on one axis (negates diagonal movement
    ; while scrolling).
    LDA.b $67 : AND.l $0288C1, X : STA.b $67

    TXA

    JSL UseImplicitRegIndexedLongJumpTable

    dl HandleEdgeTransitionMovementEast  ; 0x00 - $B63A
    dl HandleEdgeTransitionMovementWest  ; 0x01 - $B6D9
    dl HandleEdgeTransitionMovementSouth ; 0x02 - $B77A
    dl HandleEdgeTransitionMovementNorth ; 0x03 - $B81C
}

; ==============================================================================

; Default behavior.
; $0108DE-$01094B LOCAL JUMP LOCATION
Dungeon_Normal:
{
    LDA.w $0112 : ORA.w $02E4 : ORA.w $0FFC : BEQ .allowJoypadInput
        JMP .ignoreInput

    .allowJoypadInput

    ; Is the start button down?
    LDA.b $F4 : AND.b #$10 : BEQ .startNotDown
        STZ.w $0200

        ; Switch to the item menu.
        LDA.b #$01

        BRA .switchMode

    .startNotDown

    ; Is the X button being pressed?
    LDA.b $F6 : AND.b #$40 : BEQ .dontActivateMap
        ; Do we actually have a map? 0xFF indicates that a series of rooms is not in a dungeon.
        LDA.w $040C : CMP.b #$FF : BEQ .dontActivateMap
            ; Apparently Ganon's room is in a dungeon? Can't explain that. In
            ; any case this hard coded check prevents you from opening a map in
            ; Ganon's room.
            LDA.b $A0 : BEQ .dontActivateMap
                STZ.w $0200

                ; Change to dungeon map mode in the text module.
                LDA.b #$03

                .switchMode

                ; A is loaded with the submodule that module E will use.
                STA.b $11

                ; The mode that text mode is called from goes to $010C.
                LDA.b $10 : STA.w $010C

                ; Change to text mode (0E).
                LDA.b #$0E : STA.b $10

                RTS

    .dontActivateMap

    ; Is select being held/pressed?
    LDA.b $F0 : AND.b #$20 : BEQ .ignoreInput
        ; Select was pressed. But has Link woken up and gotten out of bed?
        ; No, so don't bring up the start menu.
        LDA.l $7EF3C5 : BEQ .ignoreInput
            ; Here select was pressed and Link has gotten out of his house.
            LDA.w $1CE8 : STA.w $1CF4

            REP #$20

            ; Message index for the "continue / save and quit menu".
            LDA.w #$0186 : STA.w $1CF0

            SEP #$20

            LDA.b $10 : PHA

            ; Switch to text mode and wait for input.
            JSL Main_ShowTextMessage

            PLA : STA.b $10

            STZ.b $B0

            ; This will go to $11, and it is the continue/ save submodule in
            ; mode E.
            LDA.b #$0B

            BRA .switchMode

    .ignoreInput

    JSL Player_Main

    RTS
}

; ==============================================================================

; $01094C-$010953 DATA
Dungeon_SubscreenEnable:
{
    db $00, $01, $01, $FF, $01, $01, $01, $01
}

; $010954-$01095B DATA TABLE
PendantBossRooms:
{
    dw $00C8 ; ROOM 00C8 - Armos
    dw $0033 ; ROOM 0033 - Lanmolas
    dw $0007 ; ROOM 0007 - Moldorm
    dw $0020 ; ROOM 0020 - Agahnim 1
}

; $01095C-$01096B DATA TABLE
CrystalBossRooms:
{
    dw $0006 ; ROOM 0006 - Arrghus
    dw $005A ; ROOM 005A - Helmasaur
    dw $0029 ; ROOM 0029 - Mothula
    dw $0090 ; ROOM 0090 - Vitreous
    dw $00DE ; ROOM 00DE - Kholdstare
    dw $00A4 ; ROOM 00A4 - Trinexx
    dw $00AC ; ROOM 00AC - Blind
    dw $000D ; ROOM 000D - Agahnim 2
}

; ==============================================================================

; $01096C-$01097B LOCAL JUMP TABLE
Dungeon_IntraRoomTransTable:
{
    dw Dungeon_IntraRoomTransInit                 ; 0x00 - $89B6
    dw Dungeon_IntraRoomTransFilter               ; 0x01 - $89D8
    dw Dungeon_IntraRoomTransShutDoors            ; 0x02 - $8995
    dw UnderworldTransition_ScrollRoom            ; 0x03 - $BE03
    dw UnderworldTransition_FindTransitionLanding ; 0x04 - $C110
    dw UnderworldTransition_HandleFinalMovement   ; 0x05 - $C170
    dw Dungeon_IntraRoomTransFilter               ; 0x06 - $89D8
    dw Dungeon_IntraRoomTransOpenDoors            ; 0x07 - $89F0
}

; Module 0x07.0x01 - Intra-room transition.
; $01097C-$010994 LOCAL JUMP LOCATION
Dungeon_IntraRoomTrans:
{
    REP #$20

    ; Cache link's coordinates.
    LDA.b $22 : STA.w $0FC2
    LDA.b $20 : STA.w $0FC4

    SEP #$20

    ; Only seems to handle aspects of Link's appearance during the transition
    ; (speculative).
    JSL Link_HandleMovingAnimation_FullLongEntry

    LDA.b $B0 : ASL A : TAX

    JMP (Dungeon_IntraRoomTrans, X)
}

; ==============================================================================

; $010995-$0109B5 LOCAL JUMP LOCATION
Dungeon_IntraRoomTransShutDoors:
{
    ; Open trap doors?
    STZ.w $0468

    ; Open trap doors?
    LDA.b #$07 : STA.w $0690

    LDA.b $11 : PHA

    JSL Dungeon_AnimateTrapDoors

    PLA : STA.b $11

    LDA.b #$1F : STA.l $7EC007

    LDA.b #$00 : STA.l $7EC00B

    INC.b $B0

    RTS
}

; ==============================================================================

; $0109B6-$0109D7 LOCAL JUMP LOCATION
Dungeon_IntraRoomTransInit:
{
    REP #$20

    LDA.w #$0000 : STA.l $7EC009 : STA.l $7EC007

    LDA.w #$001F : STA.l $7EC00B

    ; While this variable is zeroed a few places around the rom,
    ; no sign that it's actually used anywhere.
    STZ.w $0AA6

    SEP #$20

    ; Reset dungeon variables pertaining to switches.
    STZ.w $0646
    STZ.w $0642

    INC.b $B0

    RTS
}

; $0109D8-$0109EF LOCAL JUMP LOCATION
Dungeon_IntraRoomTransFilter:
{
    LDA.l $7EC005 : BEQ .noFiltering
        JSL PaletteFilter.doFiltering

        LDA.l $7EC007 : BEQ .doneFiltering
            JSL PaletteFilter.doFiltering

        .doneFiltering

        RTS

    .noFiltering

    INC.b $B0

    RTS
}

; ==============================================================================

; Make any applicable trap doors shut.
; $0109F0-$010A05 LOCAL JUMP LOCATION
Dungeon_IntraRoomTransOpenDoors:
{
    JSR.w ResetThenCacheRoomEntryProperties

    LDA.w $0468 : BNE .alpha
        INC.w $0468

        STZ.w $068E
        STZ.w $0690

        LDA.b #$05 : STA.b $11

    .alpha

    RTS
}

; ==============================================================================

; $010A06-$010A25 LOCAL JUMP TABLE
Dungeon_InterRoomTransTable:
{
    ; TODO: Come up with better names for some of theses.
    dw Dungeon_InterRoomTrans_Init              ; 0x00 - $8A4F
    dw Dungeon_InterRoomTrans_LoadNextRoom      ; 0x01 - $8A5B
    dw Dungeon_FadedFilter                      ; 0x02 - $8B92
    dw Dungeon_02_03                            ; 0x03 - $8A87
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x04 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance            ; 0x05 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x06 - $8AC8
    dw Dungeon_02_07                            ; 0x07 - $8B2E
    dw UnderworldTransition_ScrollRoom          ; 0x08 - $BE03
    dw Dungeon_02_09                            ; 0x09 - $8ABA
    dw Dungeon_02_0A                            ; 0x0A - $8AA5
    dw Dungeon_02_09                            ; 0x0B - $8ABA
    dw Dungeon_02_0C                            ; 0x0C - $8ACF
    dw Module07_02_0D                           ; 0x0D - $C162
    dw Dungeon_FadedFilter                      ; 0x0E - $8B92
    dw Dungeon_02_0F                            ; 0x0F - $8BAE
}

; Module 0x07.0x02 - Inter-room transition.
; $010A26-$010A4E LOCAL JUMP LOCATION
Dungeon_InterRoomTrans:
{
    REP #$20

    LDA.b $22 : STA.w $0FC2
    LDA.b $20 : STA.w $0FC4

    SEP #$20

    LDA.b $B0 : BEQ .alpha
        CMP.b #$07 : BCC .beta
            JSL Graphics_IncrementalVramUpload

        .beta

        JSL Dungeon_LoadAttrSelectable

    .alpha

    JSL Link_HandleMovingAnimation_FullLongEntry

    LDA.b $B0 : ASL A : TAX

    JMP (Dungeon_InterRoomTransTable, X)
}

; Configure graphics settings.
; $010A4F-$010A5A LOCAL JUMP LOCATION
Dungeon_InterRoomTrans_Init:
{
    LDA.w $0458 : PHA

    JSR.w ResetTransitionPropsAndAdvanceSubmodule

    PLA : STA.w $0458

    RTS
}

; Module 0x07.0x02.0x01 - Load dungeon room objects.
; $010A5B-$010A86 LOCAL JUMP LOCATION
Dungeon_InterRoomTrans_LoadNextRoom:
{
    JSL Dungeon_LoadRoom
    JSL Dungeon_InitStarTileChr
    JSL LoadTransAuxGFX_sprite

    INC.b $B0

    STZ.w $0200

    LDA.b $A2 : PHA

    LDA.b $A0 : STA.w $048E

    PLA : STA.b $A2

    JSL Dungeon_ResetSprites

    LDA.w $0458 : BNE .darkRoomWithTorch
        JSR.w Dungeon_SyncBG1and2Scroll

    .darkRoomWithTorch

    STZ.w $0458

    RTS
}

; Module 0x07.0x02.0x03 - Transitiony actions...
; $010A87-$010AA4 LOCAL JUMP LOCATION
Dungeon_02_03:
{
    LDA.l $7EC005 : ORA.l $7EC006 : BEQ .notDarkRoom
        ; Hide torch bg.
        STZ.b $1D

    .notDarkRoom

    JSL Dungeon_AdjustForRoomLayout
    JSL LoadNewSpriteGFXSet
    JSR.w Dungeon_SyncBG1and2Scroll

    ; Tile updates of a room.
    JSL WaterFlood_BuildOneQuadrantForVRAM

    INC.b $B0

    RTS
}

; Even more palette filtering + tilemap updating.
; $010AA5-$010AAF LOCAL JUMP LOCATION
Dungeon_02_0A:
{
    ; Check if we are in a dark room.
    LDA.l $7EC005 : ORA.l $7EC006 : BEQ Dungeon_PrepTilemapAndAdvance
        ; Dark room.

    ; Bleeds into the next function.
}

; Target room load tilemaps
; $010AAF-$010AB3 LOCAL JUMP LOCATION
Dungeon_Dungeon_FilterPrepTilemapAndAdvance:
{
    JSL PaletteFilter_doFiltering

    ; Bleeds into the next function.
}

; Updates BG1 tilemap.
; $010AB3-$010AB9 LOCAL JUMP LOCATION
Dungeon_PrepTilemapAndAdvance:
{
    JSL WaterFlood_BuildOneQuadrantForVRAM

    INC.b $B0

    RTS
}

; ==============================================================================

; Do more palette filtering and tilemap updating.
; $010ABA-$010AC3 LOCAL JUMP LOCATION
Dungeon_02_09:
{
    ; Check if we are in a dark room.
    LDA.l $7EC005 : ORA.l $7EC006 : BEQ Dungeon_PrepNextQuadrantUploadAndAdvance
        ; Dark room.

    ; Bleeds into the next function.
}

; $010AC4-$010AC7 LOCAL JUMP LOCATION
Dungeon_FilterUploadAndAdvance:
{
    JSL PaletteFilter_doFiltering

    ; Bleeds into the next function.
}

; Updates BG2 tilemap. Target quadrant load tilemaps.
; $010AC8-$010ACE LOCAL JUMP LOCATION
Dungeon_PrepNextQuadrantUploadAndAdvance:
{
    JSL Dungeon_PrepareNextRoomQuadrantUpload

    INC.b $B0

    RTS
}

; ==============================================================================

; Transitioning...
; $010ACF-$010AEC LOCAL JUMP LOCATION
Dungeon_02_0C:
{
    LDA.b $11 : CMP.b #$02 : BNE .BRANCH_ALPHA
        LDA.w $0200 : CMP.b #$05 : BNE DeleteCertainAncillaeStopDashing_return
            ; Ugh... wtf does this do.
            JSR.w IntraroomTransitionCalculateLanding

            LDA.l $7EC005 : ORA.l $7EC006 : BEQ .BRANCH_ALPHA
                JSL PaletteFilter.doFiltering

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $010AED-$010AEE LOCAL JUMP LOCATION
Underworld_AdvanceAndReset:
{
    INC.b $B0

    ; Bleeds into the next function.
}

; $010AEF-$010B0B LOCAL JUMP LOCATION
Dungeon_ResetTorchBackgroundAndPlayer:
{
    ; Config screens. "screens" as in the main and subscreen designations.
    LDY.b #$16

    ; Load BG1 properties setting.
    LDX.w $0414 : LDA.w Dungeon_SubscreenEnable, X : BPL .bg1OnSubscreen
        ; This setting corresponds to the "on top" setting for BG1.
        LDY.b #$17
        LDA.b #$00

    .bg1OnSubscreen

    CPX.b #$02 : BNE .notDarkRoom
        ; Put BG1 and BG2 both on the subscreen.
        LDA.b #$03

    .notDarkRoom

    ; Set main and subscreen designation mirror registers.
    STY.b $1C
    STA.b $1D

    JSL RestoreTorchBackground

    ; Bleeds into the next function.
}

; $010B0C-$010B2D LOCAL JUMP LOCATION
DeleteCertainAncillaeStopDashing:
{
    ; Not really sure, terminates some ancillae, probably.
    JSL Ancilla_TerminateSelectInteractives

    ; Check if Link will bounce off of a wall if he touches one.
    LDA.w $0372 : BEQ .return
        ; All this appears to reset Link's dashing /
        ; bounce off wall state during a screen transition.
        STZ.b $4D : STZ.b $46

        LDA.b #$FF : STA.b $29 : STA.b $C7

        STZ.b $3D : STZ.b $5E : STZ.w $032B : STZ.w $0372

        LDA.b #$00 : STA.b $5D

    .return

    RTS
}

; ==============================================================================

; Updates BG1 tilemap.
; $010B2E-$010B66 LOCAL JUMP LOCATION
Dungeon_02_07:
{
    REP #$10

    LDX.b $E2 : STX.b $E0
    LDX.b $E8 : STX.b $E6

    LDX.b $A0

    CPX.w #$0036 : BEQ .dontChangeMainAndSubscreen
    CPX.w #$0038 : BEQ .dontChangeMainAndSubscreen
        ; Check the BG0 value.
        LDX.w $0414

        LDY.w #$0016

        LDA.w Dungeon_SubscreenEnable, X : BEQ .BRANCH_BETA
            LDY.w #$0116

        .BRANCH_BETA

        ; Check the Y value against main/sub settings.
        CPY.b $1C : BEQ .dontChangeMainAndSubscreen
            LDA.b $1C : CMP.b #$17 : BEQ .BRANCH_GAMMA
                ORA.b $1D : CMP.b #$17 : BEQ .dontChangeMainAndSubscreen

            .BRANCH_GAMMA

            STY.b $1C

    .dontChangeMainAndSubscreen

    SEP #$10

    ; Bleeds into the next function.
}

; $010B67-$010B91 LOCAL JUMP LOCATION
UnderworldTransition_RunFiltering:
{
    LDA.l $7EC005 : ORA.l $7EC006 : BEQ .notDarkTransition
        LDX.b #$03

        LDA.l $7EC005 : BEQ .currentRoomNotDarkTransition
            LDX.w $045A

        .currentRoomNotDarkTransition

        LDA.l RoomEffectFixedColors, X : STA.l $7EC017

        JSL Dungeon_ApproachFixedColor_variable

        LDA.b #$00 : STA.l $7EC00B

    .notDarkTransition

    JSR.w Dungeon_HandleTranslucencyAndPalettes

    RTS
}

; ==============================================================================

; Palette filtering for dark rooms.
; $010B92-$010BAD LOCAL JUMP LOCATION
Dungeon_FadedFilter:
{
    LDA.l $7EC005 : ORA.l $7EC006 : BEQ .noFilteringNeeded
        JSL PaletteFilter_doFiltering

        LDA.l $7EC007 : BEQ .beta
            JSL PaletteFilter_doFiltering

        .beta

        RTS

    .noFilteringNeeded

    INC.b $B0

    RTS
}

; ==============================================================================

; Module 0x07.0x02.0x0F
; $010BAE-$010BD6 LOCAL JUMP LOCATION
Dungeon_02_0F:
{
    ; Reset variables and return to normal dungeon mode next frame.
    JSR.w ResetThenCacheRoomEntryProperties

    LDA.w $0468 : BNE .doorDown
        LDA.b $A0 : CMP.b #$AC : BNE .notBlindsRoom
            LDA.w $0403 : AND.b #$20 : BNE .eventCompleted
                LDA.w $0403 : AND.b #$10 : BEQ .doorDown

            .eventCompleted
        .notBlindsRoom

        INC.w $0468

        STZ.w $068E
        STZ.w $0690

        LDA.b #$05 : STA.b $11

    .doorDown
}

; $010BD7-$010C04 LOCAL JUMP LOCATION
Underworld_SetBossOrSancMusicUponEntry:
{
    REP #$20

    ; Value for Sanctuary music.
    LDX.b #$14

    LDA.b $A0 : CMP.w #$0012 : BEQ .setSong
        ; Value for Hyrule Castle music.
        LDX.b #$10

        CMP.w #$0002 : BEQ .setSong
            ; Value for cave music.
            LDX.b #$18

            .nextEntry

                DEX #2 : BMI .noSongChange
            CMP.l $028954, X : BNE .nextEntry

            SEP #$20

            JSL Sprite_VerifyAllOnScreenDefeated : BCS .noSongChange
                ; Activate boss music.
                LDX.b #$15

    .setSong

    STX.w $012C

    .noSongChange

    SEP #$20

    RTS
}

; ==============================================================================

; Module 0x07.0x03 - Perform overlay change (e.g. adding holes).
; $010C05-$010C09 LOCAL JUMP LOCATION
Dungeon_OverlayChange:
{
    JSL Dungeon_ApplyOverlay

    RTS
}

; ==============================================================================

; Opening key or big key door.
; $010C0A-$010C0E LOCAL JUMP LOCATION
Dungeon_OpeningLockedDoor:
{
    JSL Dungeon_AnimateOpeningLockedDoor

    RTS
}

; ==============================================================================

; Module 0x07.0x05 - Trigger an animation?
; $010C0F-$010C13 LOCAL JUMP LOCATION
Dungeon_ControlShutters:
{
    JSL Dungeon_AnimateTrapDoors

    RTS
}

; ==============================================================================

; Upward floor transition.
; $010C14-$010C77 LOCAL JUMP LOCATION
Dungeon_FatInterRoomStairs:
{
    LDA.b $B0 : CMP.b #$03 : BCC .BRANCH_ALPHA
        JSL Dungeon_LoadAttrSelectable

    .BRANCH_ALPHA

    LDA.b $B0 : CMP.b #$0D : BCC .BRANCH_BETA
        JSL Graphics_IncrementalVramUpload

        LDA.w $0464 : BEQ .BRANCH_GAMMA
            DEC.w $0464

            CMP.b #$10 : BNE .BRANCH_DELTA
                LDA.b #$02 : STA.b $57

            .BRANCH_DELTA

            LDX.b #$08

            LDA.w $0462 : AND.b #$04 : BEQ .BRANCH_EPSILON
                LDX.b #$04

            .BRANCH_EPSILON

            STX.b $67

            JSL Link_HandleVelocity
            JSR.w Dungeon_HandleCamera

    .BRANCH_BETA

    JSL Link_HandleMovingAnimation_FullLongEntry

    .BRANCH_GAMMA

    LDA.b $B0 : JSL UseImplicitRegIndexedLocalJumpTable

    dw ResetTransitionPropsAndAdvance_ResetInterface  ; 0x00 - $8CA9
    dw DungeonTransition_FatStairs_RunFade            ; 0x01 - $8D01
    dw Dungeon_InitializeRoomFromSpecial              ; 0x02 - $8CE2
    dw DungeonTransition_TriggerBGC34UpdateAndAdvance ; 0x03 - $8E0F
    dw DungeonTransition_TriggerBGC56UpdateAndAdvance ; 0x04 - $8E1D
    dw DungeonTransition_LoadSpriteGFX                ; 0x05 - $8D10
    dw DungeonTransition_AdjustForFatStairScroll      ; 0x06 - $8D1B
    dw Dungeon_PrepNextQuadrantUploadAndAdvance       ; 0x07 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance                  ; 0x08 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance       ; 0x09 - $8AC8
    dw Dungeon_FilterPrepTilemapAndAdvance            ; 0x0A - $8AAF
    dw Dungeon_FilterUploadAndAdvance                 ; 0x0B - $8AC4
    dw Dungeon_FilterPrepTilemapAndAdvance            ; 0x0C - $8AAF
    dw Dungeon_FilterUploadAndAdvance                 ; 0x0D - $8AC4
    dw Dungeon_DoubleApplyAndIncrementGrayscale       ; 0x0E - $9094
    dw Underworld_AdvanceAndReset                     ; 0x0F - $8AED
    dw DungeonTransition_FatStairsEntryCache          ; 0x10 - $8D5F
}

; ==============================================================================

; $010C78-$010CA8 LOCAL JUMP LOCATION
Dungeon_0E_01_HandleMusicAndResetProps:
{
    REP #$20

    LDA.b $A0 : CMP.w #$0007 : BEQ .moldormRoom
        CMP.w #$0017 : BNE .BRANCH_BETA
            LDX.w $0130 : CPX.b #$11 : BEQ .BRANCH_BETA

    .moldormRoom

    ; Check if Link has the Pendant of Courage.
    LDA.l $7EF374 : LSR A : BCS .BRANCH_BETA
        LDX.b #$F1 : STX.w $012C

    .BRANCH_BETA

    SEP #$20

    LDX.b #$58

    LDA.w $0462 : AND.b #$04 : BEQ .BRANCH_GAMMA
        LDX.b #$6A

    .BRANCH_GAMMA

    STX.w $0464

    ; Bleeds into the next function.
}

; $010CA9-$010CAB LOCAL JUMP LOCATION
ResetTransitionPropsAndAdvance_ResetInterface:
{
    STZ.w $0200

    ; Bleeds into the next function.
}

; $010CAC-$010CE1 LOCAL JUMP LOCATION
ResetTransitionPropsAndAdvanceSubmodule:
{
    REP #$30

    ; Set all mosaic settings to disabled.
    LDA.w #$0000 : STA.l $7EC011 : STA.l $7EC009 : STA.l $7EC007

    ; Set the color filtering state to "unfiltered".
    LDA.w #$001F : STA.l $7EC00B

    STZ.w $0AA6 : STZ.w $045A

    LDA.w $0458 : BEQ .torchBgNotActivated
        ; Configure color +/- to add the subscreen instead of fixed color also
        ; configure CGADSUB to use color subtraction, with background, OBJ, and
        ; BG2 having the subscreen applied to them.
        LDA.w #$B302 : STA.b $99

    .torchBgNotActivated

    SEP #$30

    STZ.w $0458

    ; Performs a lot of resetting of Link's game engine variables.
    JSR.w DeleteCertainAncillaeStopDashing

    JSR.w Overworld_CgramAuxToMain

    INC.b $B0

    RTS
}

; ==============================================================================

; Dungeon_Load_From_Hole?
; $010CE2-$010D00 LOCAL JUMP LOCATION
Dungeon_InitializeRoomFromSpecial:
{
    JSR.w Dungeon_AdjustAfterSpiralStairs
    JSL Dungeon_LoadRoom
    JSL Dungeon_InitStarTileChr
    JSL LoadTransAuxGFX
    JSL Dungeon_LoadCustomTileAttr

    LDA.b $A0 : STA.w $048E

    JSL Tagalong_Init

    INC.b $B0

    RTS
}

; ==============================================================================

; $010D01-$010D0F LOCAL JUMP LOCATION
DungeonTransition_FatStairs_RunFade:
{
    JSL PaletteFilter.doFiltering

    LDA.l $7EC007 : BEQ .BRANCH_ALPHA
        JSL PaletteFilter.doFiltering

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $010D10-$010D1A LOCAL JUMP LOCATION
DungeonTransition_LoadSpriteGFX:
{
    ; Prep some graphics for loading.
    JSL LoadNewSpriteGFXSet
    JSL Dungeon_ResetSprites
    JMP.w UnderworldTransition_RunFiltering
}

; ==============================================================================

; $010D1B-$010D5E LOCAL JUMP LOCATION
DungeonTransition_AdjustForFatStairScroll:
{
    JSR.w Dungeon_SyncBG1and2Scroll
    JSL Dungeon_AdjustForRoomLayout

    LDY.b #$16

    LDX.w $0414

    LDA.w Dungeon_SubscreenEnable, X : BPL .BRANCH_ALPHA
        LDY.b #$17
        LDA.b #$00

    .BRANCH_ALPHA

    STY.b $1C
    STA.b $1D

    INC.b $A4

    LDA.b #$01 : STA.b $57

    LDY.b #$17
    LDX.b #$30

    LDA.w $0462 : AND.b #$04 : BEQ .BRANCH_BETA
        LDY.b #$19

        DEC.b $A4 : DEC.b $A4

        LDX.b #$20

    .BRANCH_BETA

    STX.w $0464
    STY.w $012E

    LDA.b #$24 : STA.w $012F

    JSR.w Dungeon_PlayBlipAndCacheQuadrantVisits
    JMP Dungeon_PrepTilemapAndAdvance
}

; ==============================================================================

; $010D5F-$010D70 LOCAL JUMP LOCATION
DungeonTransition_FatStairsEntryCache:
{
    LDA.l $7EC009 : ORA.l $7EC007 : BEQ .BRANCH_ALPHA
        .BRANCH_BETA

        RTS

    .BRANCH_ALPHA

    LDA.w $0200 : CMP.b #$05 : BNE .BRANCH_BETA
        ; Bleeds into the next function.
}

; Reset a lot of state variables.
; $010D71-$010D80 LOCAL JUMP LOCATION
ResetThenCacheRoomEntryProperties:
{
    STZ.w $0200
    STZ.b $B0
    STZ.w $0418
    STZ.b $11
    STZ.w $0642
    STZ.w $0641

    ; Bleeds into the next function.
}

; $010D81-$010E0E LOCAL JUMP LOCATION
CacheRoomEntryProperties:
{
    REP #$20

    LDA.b $E2 : STA.l $7EC180

    LDA.b $E8 : STA.l $7EC182

    LDA.b $20 : STA.l $7EC184

    LDA.b $22 : STA.l $7EC186

    LDA.w $0600 : STA.l $7EC188
    LDA.w $0604 : STA.l $7EC18A
    LDA.w $0608 : STA.l $7EC18C
    LDA.w $060C : STA.l $7EC18E
    LDA.w $0610 : STA.l $7EC190
    LDA.w $0612 : STA.l $7EC192
    LDA.w $0614 : STA.l $7EC194
    LDA.w $0616 : STA.l $7EC196
    LDA.w $0618 : STA.l $7EC198
    LDA.w $061C : STA.l $7EC19A

    LDA.b $A6 : STA.l $7EC19C
    LDA.b $A9 : STA.l $7EC19E

    SEP #$20

    LDA.b $2F : STA.l $7EC1A6
    LDA.b $EE : STA.l $7EC1A7

    LDA.w $0476 : STA.l $7EC1A8

    LDA.b $6C : STA.l $7EC1A9
    LDA.b $A4 : STA.l $7EC1AA

    RTS
}

; ==============================================================================

; $010E0F-$010E1C LOCAL JUMP LOCATION
DungeonTransition_TriggerBGC34UpdateAndAdvance:
{
    JSL PrepTransAuxGFX

    LDA.b #$09 : STA.b $17 : STA.w $0710

    INC.b $B0

    RTS
}

; ==============================================================================

; $010E1D-$010E26 LOCAL JUMP LOCATION
DungeonTransition_TriggerBGC56UpdateAndAdvance:
{
    LDA.b #$0A : STA.b $17 : STA.w $0710

    INC.b $B0

    RTS
}

; ==============================================================================

; Downward floor transition.
; $010E27-$010E62 LOCAL JUMP LOCATION
Dungeon_FallingTransition:
{
    LDA.b $B0 : CMP.b #$06 : BCC .alpha
        JSL Graphics_IncrementalVramUpload
        JSL Dungeon_LoadAttrSelectable
        JSL Dungeon_ApproachFixedColor

    .alpha

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw Dungeon_FallingTransition_HandleMusicAndResetRoom ; 0x00 - $010E63
    dw ApplyPaletteFilter_bounce                         ; 0x01 - $0122A0
    dw Dungeon_InitializeRoomFromSpecial                 ; 0x02 - $010CE2
    dw DungeonTransition_TriggerBGC34UpdateAndAdvance    ; 0x03 - $010E0F
    dw DungeonTransition_TriggerBGC56UpdateAndAdvance    ; 0x04 - $010E1D
    dw DungeonTransition_LoadSpriteGFX                   ; 0x05 - $010D10
    dw Dungeon_FallingTransition_SyncBG1andBG2           ; 0x06 - $010E80
    dw Dungeon_PrepNextQuadrantUploadAndAdvance          ; 0x07 - $010AC8
    dw Dungeon_PrepTilemapAndAdvance                     ; 0x08 - $010AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance          ; 0x09 - $010AC8
    dw Dungeon_PrepTilemapAndAdvance                     ; 0x0A - $010AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance          ; 0x0B - $010AC8
    dw Dungeon_PrepTilemapAndAdvance                     ; 0x0C - $010AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance          ; 0x0D - $010AC8
    dw Underworld_AdvanceAndReset                        ; 0x0E - $010AED
    dw Dungeon_FallingTransition_FallingFadeIn           ; 0x0F - $010EA1
    dw Dungeon_FallingTransition_LandLinkFromFalling     ; 0x10 - $010EE0
    dw Dungeon_FallingTransition_CacheRoomAndSetMusic    ; 0x11 - $010EFA
}

; ==============================================================================

; $010E63-$010E7F LOCAL JUMP LOCATION
Dungeon_FallingTransition_HandleMusicAndResetRoom:
{
    REP #$20

    LDA.b $A0

    CMP.w #$0010 : BEQ .fadeMusicOut
    CMP.w #$0007 : BEQ .fadeMusicOut
    CMP.w #$0017 : BNE .dontFade
        .fadeMusicOut

        LDX.b #$F1 : STX.w $012C

    .dontFade

    SEP #$20

    JMP ResetTransitionPropsAndAdvance_ResetInterface
}

; ==============================================================================

; $010E80-$010EA0 LOCAL JUMP LOCATION
Dungeon_FallingTransition_SyncBG1andBG2:
{
    JSR.w Dungeon_SyncBG1and2Scroll
    JSL Dungeon_AdjustForRoomLayout

    LDY.b #$16

    LDX.w $0414

    LDA.w Dungeon_SubscreenEnable, X : BPL .BRANCH_ALPHA
        LDY.b #$17
        LDA.b #$00

    .BRANCH_ALPHA

    STY.b $1C
    STA.b $1D

    JSL WaterFlood_BuildOneQuadrantForVRAM

    INC.b $B0

    RTS
}

; $010EA1-$010EC8 LOCAL JUMP LOCATION
Dungeon_FallingTransition_FallingFadeIn:
{
    JSL PaletteFilter.doFiltering

    LDA.l $7EC009 : BNE Dungeon_PlayBlipAndCacheQuadrantVisits_exit
        LDA.b $21

        LDY.b $20 : CPY.b $51 : BCC .at_target
            INC A

        .at_target

        STA.b $52

        JSR.w Underworld_SetBossMusicUnorthodox

        LDA.b $A0

        CMP.b #$89 : BEQ Dungeon_PlayBlipAndCacheQuadrantVisits_exit
        CMP.b #$4F : BEQ Dungeon_PlayBlipAndCacheQuadrantVisits_exit
            CMP.b #$A7 : BEQ Dungeon_PlayBlipAndCacheQuadrantVisits_is_hera_fairies
                ; Drop one level in the palace / dungeon.
                DEC.b $A4

                ; Bleeds into the next function.
}

; $010EC9-$010EDF LOCAL JUMP LOCATION
Dungeon_PlayBlipAndCacheQuadrantVisits:
{
    LDA.b #$01 : STA.w $04A0

    LDA.b #$24 : STA.w $012F

    JSL SetAndSaveVisitedQuadrantFlags

    ; $010ED7 ALTERNATE ENTRY POINT
    .exit

    RTS

    ; $010ED8 ALTERNATE ENTRY POINT
    .is_hera_fairies

    STZ.w $04A0

    LDA.b #$01 : STA.b $A4

    RTS
}

; $010EE0-$010EF9 LOCAL JUMP LOCATION
Dungeon_FallingTransition_LandLinkFromFalling:
{
    JSL HandleUnderworldLandingFromPit

    LDA.b $11 : BNE .BRANCH_ALPHA
        LDA.b #$07 : STA.b $11

        LDA.b #$11 : STA.b $B0

        LDA.b #$01 : STA.w $0AAA

        JSL Graphics_LoadChrHalfSlot

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $010EFA-$010F0B LOCAL JUMP LOCATION
Dungeon_FallingTransition_CacheRoomAndSetMusic:
{
    LDA.w $0200 : CMP.b #$05 : BNE .BRANCH_ALPHA
        JSR.w ResetThenCacheRoomEntryProperties
        JSR.w Underworld_SetBossOrSancMusicUponEntry
        JSL Graphics_LoadChrHalfSlot

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; Module 0x07.0x08 - Walking up/down an in-room staircase.
; $010F0C-$010F34 LOCAL JUMP LOCATION
Dungeon_NorthIntraRoomStairs:
{
    LDA.w $0464 : BEQ .BRANCH_ALPHA
        DEC.w $0464

        CMP.b #$14 : BNE .BRANCH_BETA
            LDA.b #$02 : STA.b $57

        .BRANCH_BETA

        JSL Link_HandleVelocity
        JSL ApplyLinksMovementToCamera
        JSR.w Dungeon_HandleCamera
        JSL Link_HandleMovingAnimation_FullLongEntry

    .BRANCH_ALPHA

    LDA.b $B0 : JSL UseImplicitRegIndexedLocalJumpTable

    dw Dungeon_NorthIntraRoomStairs_InitStairs  ; 0x00 - $010F35
    dw Dungeon_NorthIntraRoomStairs_ClimbStairs ; 0x01 - $010F5F
}

; ==============================================================================

; $010F35-$010F5E LOCAL JUMP LOCATION
Dungeon_NorthIntraRoomStairs_InitStairs:
{
    STZ.w $0351

    LDY.b #$19
    LDX.b #$3C

    LDA.b $67 : AND.b #$08 : BEQ .BRANCH_ALPHA

        LDY.b #$17
        LDX.b #$38

        STZ.w $0476

        LDA.w $044A : CMP.b #$02 : BEQ .BRANCH_ALPHA
            STZ.b $EE

    .BRANCH_ALPHA

    STX.w $0464
    STY.w $012E

    LDA.b #$01 : STA.b $57

    INC.b $B0

    .return

    RTS
}

; ==============================================================================

; $010F5F-$010F87 LOCAL JUMP LOCATION
Dungeon_NorthIntraRoomStairs_ClimbStairs:
{
    LDA.w $0464 : BNE Dungeon_NorthIntraRoomStairs_InitStairs_return
        LDA.b $67 : AND.b #$04 : BEQ .BRANCH_ALPHA
            LDA.b #$01 : STA.w $0476

            LDA.w $044A : CMP.b #$02 : BEQ .BRANCH_ALPHA
                LDA.b #$01 : STA.b $EE

                ; Lol what?
                BRA .BRANCH_ALPHA

        .BRANCH_ALPHA

        STZ.b $B0
        STZ.w $0418
        STZ.b $11

        JSL SetAndSaveVisitedQuadrantFlags

        RTS
}

; ==============================================================================

; Module 0x07.0x10 - Going up or down in-room staircases.
; $010F88-$010FB0 LOCAL JUMP LOCATION
Dungeon_SouthIntraRoomStairs:
{
    LDA.w $0464 : BEQ .runGreatGrandSub
        DEC.w $0464

        CMP.b #$14 : BNE .skipStairDrag
            LDA.b #$02 : STA.b $57

        .skipStairDrag:

        JSL Link_HandleVelocity
        JSL ApplyLinksMovementToCamera
        JSR.w Dungeon_HandleCamera
        JSL Link_HandleMovingAnimation_FullLongEntry

    .runGreatGrandSub:

    LDA.b $B0 : JSL UseImplicitRegIndexedLocalJumpTable

    dw Dungeon_SouthIntraRoomStairs_InitStairs  ; 0x00 $010FB1
    dw Dungeon_SouthIntraRoomStairs_ClimbStairs ; 0x01 $010FE1
}

; ==============================================================================

; $010FB1-$010FE0 LOCAL JUMP LOCATION
Dungeon_SouthIntraRoomStairs_InitStairs:
{
    LDY.b #$19
    LDX.b #$3C

    LDA.b $67 : AND.b #$04 : BEQ .BRANCH_ALPHA
        LDY.b #$17
        LDX.b #$38

        LDA.w $0476 : EOR.b #$01 : STA.w $0476

        LDA.w $044A : CMP.b #$02 : BEQ .BRANCH_ALPHA
            LDA.b $EE : EOR.b #$01 : STA.b $EE

    .BRANCH_ALPHA

    STX.w $0464
    STY.w $012E

    LDA.b #$01 : STA.b $57

    INC.b $B0

    .return

    RTS
}

; ==============================================================================

; $010FE1-$01100E LOCAL JUMP LOCATION
Dungeon_SouthIntraRoomStairs_ClimbStairs:
{
    LDA.w $0464 : BNE Dungeon_SouthIntraRoomStairs_InitStairs_return
        LDA.b $67 : AND.b #$08 : BEQ .BRANCH_ALPHA
            LDA.w $0476 : EOR.b #$01 : STA.w $0476

            LDA.w $044A : CMP.b #$02 : BEQ .BRANCH_ALPHA
                LDA.b $EE : EOR.b #$01 : STA.b $EE

                ; Lol what again?
                BRA .BRANCH_ALPHA

        .BRANCH_ALPHA

        STZ.b $B0
        STZ.w $0418
        STZ.b $11

        JSL SetAndSaveVisitedQuadrantFlags

        RTS
}

; ==============================================================================

; Bombing or using dash attack to open a door.
; $01100F-$011013 LOCAL JUMP LOCATION
Dungeon_DestroyingWeakDoor:
{
    JSL Dungeon_AnimateDestroyingWeakDoor

    RTS
}

; ==============================================================================

; Module 0x07.0x0A - Agahnim's room in Ganon's Tower (or room light).
; $011014-$01102C LOCAL JUMP LOCATION
Dungeon_ChangeBrightness:
{
    JSL OrientLampBg
    JSL Dungeon_ApproachFixedColor

    LDA.l $00009C : AND.b #$1F : CMP.l $7EC017 : BNE .notAtTarget
        STZ.b $11
        STZ.b $B0

    .notAtTarget

    RTS
}

; ==============================================================================

; Module 0x07.0x0B - Turn off water (used in swamp palace).
; $01102D-$011031 LOCAL JUMP LOCATION
Dungeon_TurnOffWater:
{
    ; I don't quite understand why it was necessary to call a long routine
    ; from the same bank. The work could have been done in this routine
    ; just as easily.

    JSL Dungeon_TurnOffWaterActual

    RTS
}

; ==============================================================================

; $011032-$011049 LONG JUMP LOCATION
Dungeon_TurnOffWaterActual:
{
    LDA.b $B0

    JSL UseImplicitRegIndexedLongJumpTable

    dl $01EF54 ; $00EF54
    dl $01EFEC ; $00EFEC
    dl $01F046 ; $00F046
    dl $01F046 ; $00F046
    dl $01F046 ; $00F046
    dl $01F046 ; $00F046
}

; ==============================================================================

; Turn on water submodule (used in swamp palace).
; $01104A-$01104E LOCAL JUMP LOCATION
Dungeon_TurnOnWater:
{
    JSL Dungeon_TurnOnWaterLong

    RTS
}

; ==============================================================================

; Watergate room filling with water submodule.
; $01104F-$011053 LOCAL JUMP LOCATION
Dungeon_Watergate:
{
    JSL Watergate_Main

    RTS
}

; ==============================================================================

; Module 0x07.0x0E - Going up or down inter-room spiral staircases (floor to
; floor).
; $011054-$011093 LOCAL JUMP LOCATION
Dungeon_SpiralStaircase:
{
    LDA.b $B0 : CMP.b #$07 : BCC .BRANCH_ALPHA
        JSL Graphics_IncrementalVramUpload
        JSL Dungeon_LoadAttrSelectable

    .BRANCH_ALPHA

    JSL HandleLinkOnSpiralStairs

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw Module07_0E_00_InitPriorityAndScreens          ; 0x00 - $91C4
    dw Dungeon_0E_01_HandleMusicAndResetProps         ; 0x01 - $8C78
    dw Dungeon_ApplyFilterIf                          ; 0x02 - $90A1
    dw Dungeon_InitializeRoomFromSpecial              ; 0x03 - $8CE2
    dw DungeonTransition_TriggerBGC34UpdateAndAdvance ; 0x04 - $8E0F
    dw DungeonTransition_TriggerBGC56UpdateAndAdvance ; 0x05 - $8E1D
    dw DungeonTransition_LoadSpriteGFX                ; 0x06 - $8D10
    dw Dungeon_SyncBackgroundsFromSpiralStairs        ; 0x07 - $90C7

    dw Dungeon_PrepNextQuadrantUploadAndAdvance       ; 0x08 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance                  ; 0x09 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance       ; 0x0A - $8AC8
    dw Dungeon_FilterPrepTilemapAndAdvance            ; 0x00 - $8AAF
    dw Dungeon_FilterUploadAndAdvance                 ; 0x0B - $8AC4
    dw Dungeon_FilterPrepTilemapAndAdvance            ; 0x0C - $8AAF
    dw Dungeon_FilterUploadAndAdvance                 ; 0x0D - $8AC4
    dw Dungeon_DoubleApplyAndIncrementGrayscale       ; 0x0E - $9094
    dw Dungeon_AdvanceThenSetBossMusicUnorthodox      ; 0x0F - $915B

    dw Module07_0E_11                                 ; 0x10 - $919B
    dw Module07_0E_12                                 ; 0x11 - $91B5
    dw Module07_0E_13_SetRoomAndLayerAndCache         ; 0x12 - $91DD
}

; Initiate some palette filtering crap we will likely continue in the
; subsequent submodules.
; $011094-$0110A0 LOCAL JUMP LOCATION
Dungeon_DoubleApplyAndIncrementGrayscale:
{
    JSL PaletteFilter_doFiltering
    JSL PaletteFilter_doFiltering
    JSL Dungeon_ApproachFixedColor

    RTS
}

; ==============================================================================

; $0110A1-$0110C6 LOCAL JUMP LOCATION
Dungeon_ApplyFilterIf:
{
    LDA.w $0464 : CMP.b #$09 : BCS .BRANCH_ALPHA
        JSL PaletteFilter.doFiltering

        LDA.l $7EC007 : BEQ .BRANCH_ALPHA
            JSL PaletteFilter.doFiltering

    .BRANCH_ALPHA

    LDA.w $0464 : BNE .BRANCH_BETA
        LDA.b #$0C : STA.b $4B : STA.w $02F9

        RTS

    .BRANCH_BETA

    DEC.w $0464

    RTS
}

; ==============================================================================

; $0110C7-$01115A LOCAL JUMP LOCATION
Dungeon_SyncBackgroundsFromSpiralStairs:
{
    LDA.l $7EF3CC : CMP.b #$06 : BNE .BRANCH_ALPHA
        LDA.b $A0 : CMP.b #$64 : BNE .BRANCH_ALPHA
            LDA.b #$00 : STA.l $7EF3CC

    .BRANCH_ALPHA

    LDA.b $EE : PHA

    REP #$10

    LDX.w #$0030

    LDA.w $0462 : AND.b #$04 : BNE .BRANCH_BETA
        LDX.w #$FFD0

    .BRANCH_BETA

    REP #$20

    TXA : CLC : ADC.b $20 : STA.b $20

    SEP #$30

    LDX.w $048A

    LDA.l $01C322, X : STA.b $EE

    JSR.w SpiralStairs_MakeNearbyWallsHighPriority_Exiting

    PLA : STA.b $EE

    REP #$10

    LDX.w #$FFD0

    LDA.w $0462 : AND.b #$04 : BNE .BRANCH_GAMMA
        LDX.w #$0030

    .BRANCH_GAMMA

    REP #$20

    TXA : CLC : ADC.b $20 : STA.b $20

    JSR.w Dungeon_SyncBG1and2Scroll

    SEP #$30

    JSL Dungeon_AdjustForRoomLayout

    LDY.b #$16

    LDX.w $0414

    LDA.w Dungeon_SubscreenEnable, X : BPL .BRANCH_DELTA
        LDY.b #$17
        LDA.b #$00

    .BRANCH_DELTA

    CPX.b #$02 : BNE .BRANCH_EPSILON
        LDA.b #$03

    .BRANCH_EPSILON

    STY.b $1C
    STA.b $1D

    INC.b $A4 ; Going up a flight of stairs.

    LDA.w $0462 : AND.b #$04 : BEQ .upStaircase
        ; Going down a flight of stairs.
        DEC.b $A4 : DEC.b $A4

    .upStaircase

    LDX.b #$18 : STX.w $0464

    JSR.w Dungeon_PlayBlipAndCacheQuadrantVisits
    JSL RestoreTorchBackground
    JMP Dungeon_PrepTilemapAndAdvance
}

; ==============================================================================

; $01115B-$011164 LOCAL JUMP LOCATION
Dungeon_AdvanceThenSetBossMusicUnorthodox:
{
    JSR.w DeleteCertainAncillaeStopDashing

    LDA.b #$38 : STA.w $0464

    INC.b $B0

    ; Bleeds into the next function.
}

; $011165-$01119A LOCAL JUMP LOCATION
Underworld_SetBossMusicUnorthodox:
{
    REP #$20

    LDX.b #$1C

    LDA.b $A0 : CMP.w #$0010 : BEQ .BRANCH_ALPHA
        LDX.b #$15

        CMP.w #$0007 : BEQ .BRANCH_BETA
            LDX.b #$11

            CMP.w #$0017 : BNE .BRANCH_GAMMA
            CPX.w $0130 : BEQ .BRANCH_GAMMA

        .BRANCH_BETA

        LDA.w $0130 : AND.w #$00FF : CMP.w #$00F1 : BEQ .BRANCH_ALPHA
            LDA.l $7EF374 : LSR A : BCS .BRANCH_GAMMA

    .BRANCH_ALPHA

    STX.w $012C

    .BRANCH_GAMMA

    SEP #$20

    RTS
}

; ==============================================================================

; $01119B-$0111B4 LOCAL JUMP LOCATION
Module07_0E_11:
{
    JSL SpiralStairs_FindLandingSpot

    DEC.w $0464 : BNE .BRANCH_ALPHA
        LDX.b #$0A

        LDA.w $0462 : AND.b #$04 : BNE .upStaircase
            LDX.b #$18

        .upStaircase

        STX.w $0464

        INC.b $B0

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $0111B5-$0111C3 LOCAL JUMP LOCATION
Module07_0E_12:
{
    JSL SpiralStairs_FindLandingSpot

    DEC.w $0464 : BNE .BRANCH_ALPHA
        INC.b $B0

        STZ.w $0200

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $0111C4-$0111DC LOCAL JUMP LOCATION
Module07_0E_00_InitPriorityAndScreens:
{
    JSL Dungeon_ElevateStaircasePriority

    LDA.b $EE : BEQ .onBG2
        LDA.b $1C : AND.b #$0F : STA.b $1C

        LDA.b #$10 : TSB.b $1D
        LDA.b #$03 : STA.b $EE

    .onBG2

    INC.b $B0

    RTS
}

; ==============================================================================

; $0111DD-$011209 LOCAL JUMP LOCATION
Module07_0E_13_SetRoomAndLayerAndCache:
{
    LDX.w $048A

    LDA.l $01C31F, X : STA.w $0476

    LDA.l $01C322, X : STA.b $EE

    LDA.b #$10 : TSB.b $1C

    LDA.b $1D : AND.b #$0F : STA.b $1D

    LDA.w $0462 : AND.b #$04 : BNE .up_staircase
        JSL Dungeon_DecreaseStaircasePriority

    .up_staircase

    LDA.b $A0 : STA.w $048E

    JMP ResetThenCacheRoomEntryProperties
}

; ==============================================================================

; $01120A-$011219 DATA TABLE
Pool_RepositionLinkAfterSpiralStairs:
{
    .x_offsets
    dw -28, -28,  24,  24

    .y_offsets
    dw  16, -10, -10, -32
}

; ==============================================================================

; $01121A-$0112B0 LONG JUMP LOCATION
RepositionLinkAfterSpiralStairs:
{
    SEP #$30

    STZ.b $4B
    STZ.w $02F9

    LDX.b #$00

    LDA.w $048A : BNE .BRANCH_ALPHA
    CMP.w $0492 : BEQ .BRANCH_ALPHA
        LDX.b #$02

    .BRANCH_ALPHA

    LDA.w $0462 : AND.b #$04 : BEQ .BRANCH_BETA
        TXA : CLC : ADC.b #$04 : TAX

    .BRANCH_BETA

    REP #$20

    ; Staircases and how they affect your X and Y coordinates.
    LDA.b $22 : CLC : ADC.l $02920A, X : STA.b $22
    LDA.b $20 : CLC : ADC.l $029212, X : STA.b $20

    SEP #$20

    ; See if the sprite layer is not enabled
    LDA.b $1C : AND.b #$10 : BEQ .BRANCH_DELTA
        ; Is enabled.
        LDA.w $048A : CMP.b #$02 : BNE .BRANCH_GAMMA
            LDA.b #$03 : STA.b $EE

            LDA.b $1C : AND.b #$0F : STA.b $1C

            LDA.b #$10 : TSB.b $1D

            LDA.w $0492 : CMP.b #$02 : BEQ .BRANCH_GAMMA
                REP #$20

                LDA.b $20 : CLC : ADC.w #$0018 : STA.b $20

        .BRANCH_GAMMA

        SEP #$20

        JSL Tagalong_Init

        REP #$20

        RTL

    .BRANCH_DELTA

    LDA.w $048A : CMP.b #$02 : BEQ .BRANCH_EPSILON
        LDA.b #$10 : TSB.b $1C

        LDA.b $1D : AND.b #$0F : STA .b$0F

        LDA.w $0492 : CMP.b #$02 : BEQ .BRANCH_GAMMA
            REP #$20

            LDA.b $20 : SEC : SBC.w #$0018 : STA.b $20

    .BRANCH_EPSILON

    SEP #$20

    JSL Tagalong_Init

    REP #$20

    RTL
}

; ==============================================================================

; $0112B1-$011318 LOCAL JUMP LOCATION
SpiralStairs_MakeNearbyWallsHighPriority_Exiting:
{
    LDA.w $0462 : AND.b #$04 : BNE .BRANCH_ALPHA
        REP #$30

        LDA.w $048C : CLC : ADC.w #$0008 : AND.w #$007F : STA.b $00

        LDX.w #$FFFE

        .BRANCH_BETA

            INX #2
        LDA.w $06B0, X : ASL A : AND.w #$007F : CMP.b $00 : BNE .BRANCH_BETA

        LDA.w $06B0, X : ASL A : SEC : SBC.w #$0008 : STA.w $048C : TAX

        LDY.w #$0004

        .BRANCH_GAMMA

            LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
            LDA.l $7E2080, X : ORA.w #$2000 : STA.l $7E2080, X
            LDA.l $7E2100, X : ORA.w #$2000 : STA.l $7E2100, X
            LDA.l $7E2180, X : ORA.w #$2000 : STA.l $7E2180, X

            INX #2
        DEY : BPL .BRANCH_GAMMA

        SEP #$30

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $011319-$01131C LOCAL JUMP TABLE
Pool_Dungeon_LandingWipe:
{
    dw Module07_0F_00_InitSpotlight ; 0x00 - $01132D
    dw $9334                        ; 0x01 - $011334
}

; $01131D-$01132C LOCAL JUMP LOCATION
Dungeon_LandingWipe:
{
    LDA.b $B0 : ASL A : TAX

    JSR (Pool_Dungeon_LandingWipe, X)

    JSL Link_HandleMovingAnimation_FullLongEntry
    JSL PlayerOam_Main

    RTS
}

; ==============================================================================

; $01132D-$011333 LOCAL JUMP LOCATION
Module07_0F_00_InitSpotlight:
{
    JSL Spotlight_open

    INC.b $B0

    RTS
}

; ==============================================================================

; $011334-$011356 LOCAL JUMP LOCATION
Module07_0F_01_OperateSpotlight
{
    JSL Sprite_Main
    JSL ConfigureSpotlightTable

    LDA.b $11 : BNE .BRANCH_ALPHA
        STZ.b $96
        STZ.b $97
        STZ.b $98
        STZ.b $1E
        STZ.b $1F
        STZ.b $B0

        LDA.w $0132 : CMP.b #$FF : BEQ .BRANCH_ALPHA
            STA.w $012C

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; Walking up straight inter-room staircase. Walking down straight inter-room
; staircase. ??? adds extra sprites on screen. 
; $011357-$0113BA LOCAL JUMP LOCATION
Dungeon_StraightStairs:
{
    LDA.b $B0 : CMP.b #$03 : BCC .doneWithAttrLoads
        JSL Dungeon_LoadAttrSelectable

    .doneWithAttrLoads

    LDA.b $B0 : CMP.b #$0D : BCC .waitForVramConfig
        JSL Graphics_IncrementalVramUpload

    .waitForVramConfig

    LDA.w $0464 : BEQ .counterElapsed
        DEC.w $0464

        CMP.b #$10 : BNE .noSlow
            ; When the counter is down to 0x10, slow the player sprite down.
            LDA.b #$02 : STA.b $57

        .noSlow

        LDX.b #$08

        LDA.b $11 : CMP.b #$12 : BEQ .downfacingStaircase
            LDX.b #$04

        .downfacingStaircase

        STX.b $67

        JSL Link_HandleVelocity

    .counterElapsed

    JSL Link_HandleMovingAnimation_FullLongEntry

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw Dungeon_StraightStairs_PrepAndReset      ; 0x00 - $93BB
    dw Dungeon_StraightStairs_FadeOut           ; 0x01 - $93ED
    dw Dungeon_StraightStairs_LoadAndPrepRoom   ; 0x02 - $9403
    dw StraightStairs_3                         ; 0x03 - $9422
    dw StraightStairs_4                         ; 0x04 - $942A
    dw Dungeon_FilterPrepTilemapAndAdvance      ; 0x05 - $8AAF
    dw Dungeon_FilterUploadAndAdvance           ; 0x06 - $8AC4
    dw Dungeon_FilterPrepTilemapAndAdvance      ; 0x07 - $8AAF
    dw Dungeon_FilterUploadAndAdvance           ; 0x08 - $8AC4
    dw StraightStairs_9                         ; 0x09 - $94E0
    dw StraightStairs_10                        ; 0x0A - $BE75
    dw StraightStairs_11                        ; 0x0B - $943B
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x0C - $8AC8
    dw Dungeon_PrepTilemapAndAdvance            ; 0x0D - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x0E - $8AC8
    dw Dungeon_DoubleApplyAndIncrementGrayscale ; 0x0F - $9094
    dw Module07_11_19_SetSongAndFilter          ; 0x10 - $94ED
    dw Module07_11_11_KeepSliding               ; 0x11 - $9518
    dw ResetThenCacheRoomEntryProperties        ; 0x12 - $8D71
}

; ==============================================================================

; $0113BB-$0113EC LOCAL JUMP LOCATION
Dungeon_StraightStairs_PrepAndReset:
{
    LDA.w $0372 : BEQ .notDashing
        STZ.w $0372

        LDA.b #$02 : STA.b $5E

    .notDashing

    LDX.b #$16

    ; Walking on an up staircase makes a different sound from a down one.
    LDA.w $0462 : AND.b #$04 : BEQ .upStaircase
        LDX.b #$18

    .upStaircase

    STX.w $012E

    REP #$20

    ; Fade the music when transitioning on the staircases between Agahnim's
    ; first room and the HC 2 floor that connects to it (going either up or
    ; down). This let's the player notice that the music is about to change.
    LDA.b $A0

    CMP.w #$0030 : BEQ .fadeMusicOut
        CMP.w #$0040 : BNE .dontFade

    .fadeMusicOut

    LDX.b #$F1 : STX.w $012C

    .dontFade

    SEP #$20

    JMP ResetTransitionPropsAndAdvance_ResetInterface
}

; ==============================================================================

; $0113ED-$011402 LOCAL JUMP LOCATION
Dungeon_StraightStairs_FadeOut:
{
    LDA.w $0464 : CMP.b #$09 : BCS .BRANCH_ALPHA
        JSL PaletteFilter_doFiltering

        LDA.l $7EC007 : CMP.b #$17 : BNE .BRANCH_ALPHA
            INC.b $B0

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $011403-$011421 LOCAL JUMP LOCATION
Dungeon_StraightStairs_LoadAndPrepRoom:
{
    JSL PaletteFilter_doFiltering
    JSL Dungeon_LoadRoom
    JSL Dungeon_RestoreStarTileChr
    JSL LoadTransAuxGFX
    JSL Dungeon_LoadCustomTileAttr
    JSL Dungeon_AdjustForRoomLayout
    JSL Tagalong_Init

    INC.b $B0

    RTS
}

; ==============================================================================

; Filter and load BG chars.
; $011422-$011429 LOCAL JUMP LOCATION
StraightStairs_3:
{
    JSL PaletteFilter_doFiltering
    JSR.w DungeonTransition_TriggerBGC34UpdateAndAdvance

    RTS
}

; ==============================================================================

; Filter do BG and reset sprites
; $01142A-$01143A LOCAL JUMP LOCATION
StraightStairs_4:
{
    JSL PaletteFilter_doFiltering
    JSR.w DungeonTransition_TriggerBGC56UpdateAndAdvance

    LDA.b $A0 : STA.w $048E

    JSL Dungeon_ResetSprites

    RTS
}

; ==============================================================================

; $01143B-$0114DF LOCAL JUMP LOCATION
StraightStairs_11:
{
    LDY.b #$16

    LDX.w $0414

    LDA.w Dungeon_SubscreenEnable, X : BPL .subscreenEnabled
        LDY.b #$17
        LDA.b #$00

    .subscreenEnabled

    STY.b $1C
    STA.b $1D

    LDY.b #$17

    INC.b $A4

    LDA.b #$01 : STA.b $57

    LDX.b #$3C

    ; The timer ($0464) and sound effect differ based on whether we're
    ; going up a staircase or down.
    LDA.w $0462 : AND.b #$04 : BEQ .upStaircase
        LDY.b #$19

        DEC.b $A4 : DEC.b $A4

        LDX.b #$32

    .upStaircase

    STX.w $0464
    STY.w $012E

    STZ.b $00

    LDY.b $11

    LDA.b $EE : BEQ .onBg2

    REP #$20

    LDA.w #$0020

    CPY.b #$12 : BNE .walkingDownStaircase
        LDA.w #$FFE0

    .walkingDownStaircase

    CLC : ADC.b $20 : STA.b $20

    INC.b $00

    SEP #$20

    .onBg2

    LDX.w $048A

    LDA.l $01C31F, X : STA.w $0476

    LDA.l $01C322, X : STA.b $EE : BEQ .BRANCH_EPSILON
        REP #$20

        LDA.w #$0020

        CPY.b #$12 : BNE .BRANCH_ZETA
            LDA.w #$FFE0

        .BRANCH_ZETA

        CLC : ADC.b $20 : STA.b $20

        INC.b $00

        SEP #$20

    .BRANCH_EPSILON

    LDA.b $00 : BNE .BRANCH_THETA
        REP #$20

        LDA.w #$000C

        CPY.b #$12 : BNE .BRANCH_IOTA
            REP #$10

            LDX.w #$FFE8

            LDA.w $0462 : AND.w #$0004 : BNE .BRANCH_KAPPA
                LDX.w #$FFF8

            .BRANCH_KAPPA

            TXA

        .BRANCH_IOTA

        CLC : ADC.b $20 : STA.b $20

        SEP #$30

    .BRANCH_THETA

    JSR.w Dungeon_PlayBlipAndCacheQuadrantVisits
    JSL RestoreTorchBackground
    JMP Dungeon_PrepTilemapAndAdvance
}

; ==============================================================================

; $0114E0-$0114EC LOCAL JUMP LOCATION
StraightStairs_9:
{
    JSL PaletteFilter.doFiltering

    DEC.b $B0

    JSL LoadNewSpriteGFXSet
    JMP.w Dungeon_HandleTranslucencyAndPalettes
}

; ==============================================================================

; $0114ED-$011512 LOCAL JUMP LOCATION
Module07_11_19_SetSongAndFilter:
{
    LDA.w $0200 : CMP.b #$05 : BNE .BRANCH_ALPHA
        LDA.l $7EC009 : BNE .BRANCH_ALPHA
            INC.b $B0

            REP #$20

            LDX.b #$1C

            LDA.b $A0

            CMP.w #$0030 : BEQ .BRANCH_BETA
                CMP.w #$0040 : BNE .BRANCH_GAMMA
                    LDX.b #$10

            .BRANCH_BETA

            STX.w $012C

            .BRANCH_GAMMA

            SEP #$20

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $011513-$011517 LOCAL JUMP LOCATION
ApplyGrayscaleFixed_Incremental_bounce:
{
    JSL Dungeon_ApproachFixedColor

    RTS
}

; ==============================================================================

; $011518-$01151F LOCAL JUMP LOCATION
Module07_11_11_KeepSliding:
{
    LDA.w $0464 : BNE ApplyGrayscaleFixed_Incremental_bounce
        INC.b $B0

        RTS
}

; ==============================================================================

; What Happens when Link falls into a damaging pit.
; $011520-$011529 LOCAL JUMP LOCATION
Dungeon_RecoverFromFall:
{
    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw Module07_14_00_ScrollCamera  ; 0x00 - $952A
    dw RecoverPositionAfterDrowning ; 0x01 - $9583
}

; ==============================================================================

; $01152A-$011582 LOCAL JUMP LOCATION
Module07_14_00_ScrollCamera:
{
    REP #$20

    ; Compare the stored BG1 H value with current one.
    LDA.b $E2 : CMP.l $7EC180 : BEQ .BRANCH_ALPHA
        ; If the current value is < stored value.
        BCC .BRANCH_BETA 
            DEC A : CMP.l $7EC180 : BEQ .BRANCH_ALPHA
                DEC A

                BRA .BRANCH_ALPHA

        .BRANCH_BETA

        ; Increment so we can back to the origin.
        INC A : CMP.l $7EC180 : BEQ .BRANCH_ALPHA
            INC A

    .BRANCH_ALPHA

    STA.b $E2

    LDA.b $E8 : CMP.l $7EC182 : BEQ .BRANCH_GAMMA  BCC .BRANCH_DELTA
        DEC A : CMP.l $7EC182 : BEQ .BRANCH_GAMMA
            DEC A

            BRA .BRANCH_GAMMA

    .BRANCH_DELTA

    INC A : CMP.l $7EC182 : BEQ .BRANCH_GAMMA
        INC A

    .BRANCH_GAMMA

    STA.b $E8 : CMP.l $7EC182 : BNE .BRANCH_EPSILON
        LDA.b $E2 : CMP.l $7EC180 : BNE .BRANCH_EPSILON
            INC.b $B0

    .BRANCH_EPSILON

    LDA.w $0458 : BNE .BRANCH_ZETA
        JSR.w Dungeon_SyncBG1and2Scroll

    .BRANCH_ZETA

    SEP #$20

    RTS
}

; ==============================================================================

; $011583-$011679 LOCAL JUMP LOCATION
RecoverPositionAfterDrowning:
{
    REP #$20

    LDA.l $7EC184 : STA.b $20
    LDA.l $7EC186 : STA.b $22
    LDA.l $7EC188 : STA.w $0600
    LDA.l $7EC18A : STA.w $0604
    LDA.l $7EC18C : STA.w $0608
    LDA.l $7EC18E : STA.w $060C
    LDA.l $7EC190 : STA.w $0610
    LDA.l $7EC192 : STA.w $0612
    LDA.l $7EC194 : STA.w $0614
    LDA.l $7EC196 : STA.w $0616

    LDA.b $1B : AND.w #$00FF : BEQ .outdoors
        LDA.l $7EC198 : STA.w $0618

        INC #2 : STA.w $061A

        LDA.l $7EC19A : STA.w $061C

        INC #2 : STA.w $061E

    .outdoors

    LDA.l $7EC19C : STA.b $A6
    LDA.l $7EC19E : STA.b $A9

    LDA.b $1B : AND.w #$00FF : BNE .indoors
        LDA.w $0618 : DEC #2 : STA.w $061A
        LDA.w $061C : DEC #2 : STA.w $061E

    .indoors

    SEP #$20

    LDA.l $7EC1A6 : STA.b $2F
    LDA.l $7EC1A7 : STA.b $EE

    LDA.l $7EC1A8 : STA.w $0476

    LDA.l $7EC1A9 : STA.b $6C

    LDA.l $7EC1AA : STA.b $A4

    STZ.b $4B

    LDA.b #$90 : STA.w $031F

    JSR.w Dungeon_PlayBlipAndCacheQuadrantVisits

    STZ.w $037B

    JSL Link_ResetStateAfterDamagingPit

    STZ.w $02F9

    JSL Tagalong_Init

    STZ.w $0642
    STZ.w $0200
    STZ.b $B0
    STZ.w $0418
    STZ.b $11

    LDA.l $7EF36D : BNE .notDead
        LDA.b #$00 : STA.l $7EF36D

        LDA.b $1C : STA.l $7EC211
        LDA.b $1D : STA.l $7EC212

        LDA.b $10 : STA.w $010C

        LDA.b #$12 : STA.b $10
        LDA.b #$01 : STA.b $11

        STZ.w $031F

    .notDead

    RTS
}

; ==============================================================================

; Module 0x07.0x15 - Warping to another room.
; $01167A-$0116AB LOCAL JUMP LOCATION
Dungeon_Teleport:
{
    LDA.b $B0 : CMP.b #$03 : BCC .alpha
        JSL Graphics_IncrementalVramUpload
        JSL Dungeon_LoadAttrSelectable

    .alpha

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw ResetTransitionPropsAndAdvance_ResetInterface ; 0x00 - $8CA9
    dw Module07_15_01_ApplyMosaicAndFilter           ; 0x01 - $96AC
    dw Dungeon_InitializeRoomFromSpecial             ; 0x02 - $8CE2
    dw DungeonTransition_LoadSpriteGFX               ; 0x03 - $8D10
    dw Module07_15_04_SyncRoomPropsAndBuildOverlay   ; 0x04 - $96BA
    dw Dungeon_PrepNextQuadrantUploadAndAdvance      ; 0x05 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance                 ; 0x06 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance      ; 0x07 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance                 ; 0x08 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance      ; 0x09 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance                 ; 0x0A - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance      ; 0x0B - $8AC8
    dw Underworld_AdvanceAndReset                    ; 0x0C - $8AED
    dw Module07_15_0E_FadeInFromWarp                 ; 0x0D - $96EC
    dw Module07_15_0F_FinalizeAndCacheEntry          ; 0x0E - $970F
}

; $0116AC-$0116B9 LOCAL JUMP LOCATION
Module07_15_01_ApplyMosaicAndFilter:
{
    JSR.w Overworld_ResetMosaic

    LDA.l $7EC011 : ORA.b #$03 : STA.b $95

    JMP ApplyPaletteFilter_bounce
}

; $0116BA-$0116EB LOCAL JUMP LOCATION
Module07_15_04_SyncRoomPropsAndBuildOverlay:
{
    JSL Dungeon_ApproachFixedColor

    REP #$20

    LDA.b $A0 : CMP.w #$0017 : BNE .notRoomRightBeforeMoldorm
        ; Set floor to "F5"?
        LDX.b #$04 : STX.b $A4

    .notRoomRightBeforeMoldorm

    JSR.w Dungeon_SyncBG1and2Scroll
    JSL Dungeon_AdjustForRoomLayout

    LDY.b #$16

    LDX.w $0414

    LDA.w Dungeon_SubscreenEnable, X : BPL .subscreenEnabled
        LDY.b #$17
        LDA.b #$00

    .subscreenEnabled

    STY.b $1C
    STA.b $1D

    JSL WaterFlood_BuildOneQuadrantForVRAM

    INC.b $B0

    RTS
}

; $0116EC-$01170E LOCAL JUMP LOCATION
Module07_15_0E_FadeInFromWarp:
{
    LDA.l $7EC007 : LSR A : BCC .mosaicDisabled
        LDA.l $7EC011 : BEQ .mosaicDisabled
            SEC : SBC.b #$10 : STA.l $7EC011

    .mosaicDisabled

    LDA.b #$09 : STA.b $94

    LDA.l $7EC011 : ORA.b #$03 : STA.b $95

    JMP ApplyPaletteFilter_bounce
}

; ==============================================================================

; $01170F-$01171F LOCAL JUMP LOCATION
Module07_15_0F_FinalizeAndCacheEntry:
{
    LDA.w $0200 : CMP.b #$05 : BNE .return
        JSL SetAndSaveVisitedQuadrantFlags
        STZ.b $11

        JSR.w ResetThenCacheRoomEntryProperties

    .return

    RTS
}

; ==============================================================================

; Orange/blue barrier state change?
; $011720-$011729 LOCAL JUMP TABLE
Dungeon_UpdatePegsTable:
{
    dw Module07_16_UpdatePegs_Step1    ; 0x00 - $9739
    dw Module07_16_UpdatePegs_Step1    ; 0x01 - $9739
    dw Module07_16_UpdatePegs_Step2    ; 0x02 - $974D
    dw Module07_16_UpdatePegs_Step3    ; 0x03 - $9761
    dw Module07_16_UpdatePegs_FinishUp ; 0x04 - $97A9
}

; Module 0x07.0x16 - Orange/Blue Barrier swapping.
; $01172A-$011738 LOCAL JUMP LOCATION
Dungeon_UpdatePegs:
{
    INC.b $B0 : LDA.b $B0 : AND.b #$03 : BNE Module07_15_0F_FinalizeAndCacheEntry_return
        LDA.b $B0 : LSR A : TAX

        JMP (Dungeon_UpdatePegsTable, X)
}

; First four steps perform animation to show one barrier type.
; Going up while the other goes down.
; $011739-$01174C LOCAL JUMP LOCATION
Module07_16_UpdatePegs_Step1:
{
    REP #$10

    LDX.w #$0100
    LDY.w #$0080

    LDA.l $7EC172 : BEQ .BRANCH_ALPHA
        TYX

        LDY.w #$0100

    .BRANCH_ALPHA

    BRA Underworld_UpdatePegGFXBuffer
}

; The last step updates the tile attribute table.
; $01174D-$011760 LOCAL JUMP LOCATION
Module07_16_UpdatePegs_Step2:
{
    REP #$10

    LDX.w #$0080
    LDY.w #$0100

    LDA.l $7EC172 : BEQ .BRANCH_EPSILON
        TYX

        LDY.w #$0080

    .BRANCH_EPSILON

    BRA Module07_16_UpdatePegs_Step3
}

; $011761-$011772 LOCAL JUMP LOCATION
Module07_16_UpdatePegs_Step3:
{
    REP #$10

    LDX.w #$0000
    LDY.w #$0180

    LDA.l $7EC172 : BEQ .BRANCH_BETA
        TYX

        LDY.w #$0000

    .BRANCH_BETA

    ; Bleeds into the next function.
}

; $011773-$0117A8 LOCAL JUMP LOCATION
Underworld_UpdatePegGFXBuffer:
{
    STY.b $0E

    PHB : LDA.b #$7F : PHA : PLB

    REP #$20

    LDY.w #$0000

    .BRANCH_GAMMA

        LDA.l $7EB340, X : STA.w $0000, Y

        INX #2
    INY #2 : CPY.w #$0080 : BNE .BRANCH_GAMMA

    LDX.b $0E

    .BRANCH_DELTA

        LDA.l $7EB340, X : STA.w $0000, Y

        INX #2
    INY #2 : CPY.w #$0100 : BNE .BRANCH_DELTA

    SEP #$30

    PLB

    LDA.b #$17 : STA.b $17

    RTS
}

; Swap the barrier collision states.
; $0117A9-$0117B1 LOCAL JUMP LOCATION
Module07_16_UpdatePegs_FinishUp:
{
    JSL Dungeon_ToggleBarrierAttr

    STZ.b $B0
    STZ.b $11

    RTS
}

; $0117B2-$0117C7 LONG JUMP LOCATION
RecoverPegGFXFromMapping:
{
    REP #$10

    LDX.w #$0000
    LDY.w #$0180

    LDA.l $7EC172 : BEQ .BRANCH_ALPHA
        TYX

        LDY.w #$0000

    .BRANCH_ALPHA

    JSR.w Underworld_UpdatePegGFXBuffer

    RTL
}

; ==============================================================================

; Module 0x07.0x17 - Runs when you step on a switch to open trap doors.
; $0117C8-$0117F9 LOCAL JUMP LOCATION
Dungeon_PressurePlate:
{
    DEC.b $B0 : BNE .stillCountingDown
        REP #$30

        LDA.b $20 : SEC : SBC.w #$0002 : STA.b $20

        ; Restore the button to its rightful graphics?
        LDA.w $04B6 : LSR #3 : AND.w #$01F8 : STA.b $02

        LDA.w $04B6 : AND.w #$003F : ASL #3 : STA.b $00

        SEP #$30

        LDY.b #$0E

        JSL Dungeon_SpriteInducedTilemapUpdate

        LDA.w $010C : STA.b $11

    .stillCountingDown

    RTS
}

; ==============================================================================

; $0117FA-$011809 DATA TABLE
CrystalGraphicsTilemapLocation:
{
    dw $1618, $1658, $1658, $1618, $0658, $1618, $1658, $0000
}

; ==============================================================================

; Module 0x07.0x18 - Crystal Maiden sequence.
; $01180A-$011825 LOCAL JUMP LOCATION
Dungeon_Crystal:
{
    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw PrepareForCrystalCutscene                ; 0x00 - $9826
    dw BuildCrystalCutsceneTilemap              ; 0x01 - $9888
    dw Dungeon_PrepTilemapAndAdvance            ; 0x02 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x03 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance            ; 0x04 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x05 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance            ; 0x06 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x07 - $8AC8
    dw Dungeon_PrepTilemapAndAdvance            ; 0x08 - $8AB3
    dw Dungeon_PrepNextQuadrantUploadAndAdvance ; 0x09 - $8AC8
    dw StartCrystalCutscene                     ; 0x0A - $98E7
}

; ==============================================================================

; $011826-$011887 LOCAL JUMP LOCATION
PrepareForCrystalCutscene:
{
    JSL PaletteFilter_Restore_Strictly_Bg_Subtractive

    LDA.l $7EC540 : STA.l $7EC500
    LDA.l $7EC541 : STA.l $7EC501

    LDA.l $7EC009 : CMP.b #$FF : BNE .BRANCH_ALPHA
        REP #$30

        LDX.w #$0000
        LDA.w #$01EC

        .BRANCH_BETA

            STA.l $7E2000, X : STA.l $7E2800, X
            STA.l $7E3000, X : STA.l $7E3800, X
            STA.l $7E4000, X : STA.l $7E4800, X
            STA.l $7E5000, X : STA.l $7E5800, X
        INX #2 : CPX.w #$0800 : BNE .BRANCH_BETA

        STZ.w $011C
        STZ.w $011A

        STZ.w $0422
        STZ.w $0424

        SEP #$30

        STZ.w $0418
        STZ.w $045C

        INC.b $B0

    .BRANCH_ALPHA

    RTS
}

; Figure out which quadrant the crystal is in.
; $011888-$0118E6 LOCAL JUMP LOCATION
BuildCrystalCutsceneTilemap:
{
    JSL PaletteFilter_Crystal

    LDA.b #$01 : STA.b $1D

    LDA.b #$02 : STA.w $02E4

    REP #$20

    LDX.b #$0E

    LDA.b $A0

    .BRANCH_ALPHA

        DEX #2
    CMP.l $02895C, X : BNE .BRANCH_ALPHA

    LDA.l $0297FA, X : STA.b $08

    REP #$10

    LDA.w #$0004 : STA.b $0C
    STZ.b $0E

    .BRANCH_GAMMA

        LDY.w #$0007

        LDX.b $08

        .BRANCH_BETA

            LDA.b $0E : ORA.w #$1F80 : STA.l $7E4000, X
                        ORA.w #$1F88 : STA.l $7E4200, X

            INC.b $0E

            INX #2
        DEY : BPL .BRANCH_BETA

        LDA.b $0E : CLC : ADC.w #$0008 : STA.b $0E
        LDA.b $08 : CLC : ADC.w #$0080 : STA.b $08
    DEC.b $0C : BNE .BRANCH_GAMMA

    SEP #$30

    INC.b $B0

    RTS
}

; $0118E7-$0118F6 LOCAL JUMP LOCATION
StartCrystalCutscene:
{
    INC.w $012A

    JSL Polyhedral_InitThread
    JSL CrystalMaiden_Configure

    STZ.b $11
    STZ.b $B0

    RTS
}

; Module 0x07.0x19 Magic mirror as used in a dungeon (Palaces only).
; $0118F7-$011915 LOCAL JUMP LOCATION
Dungeon_MirrorFade:
{
    JSR.w MosaicControlIncrease

    DEC.b $13 : BNE .notFullyDarkened
        ; Go to "load game" module...?
        LDA.b #$05 : STA.b $10

        STZ.b $11
        STZ.b $14

        LDA.w $0130 : STA.w $0133

        LDA.w $0ABD : BEQ .noPaletteSwap
            JSL Palette_RevertTranslucencySwap

        .noPaletteSwap
    .notFullyDarkened

    RTS
}

; Module 0x07.0x1A
; $011916-$01191A LOCAL JUMP LOCATION
Dungeon_OpenGanonDoor:
{
    JSL Object_OpenGanonDoor

    RTS
}

; Beginning of Module 0x0C, ???? Mode. I think we can declare this one unused,
; almost with complete certainty.
; $01191B-$011921 LOCAL JUMP LOCATION
Module0C_Unused:
{
    JSR.w Overworld_ResetMosaic
    JSR.w Module0C_RunSubmodule

    RTL
}

; $011922-$01192D LOCAL JUMP LOCATION
Module0C_RunSubmodule:
{
    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw ResetTransitionPropsAndAdvance_ResetInterface ; 0x00 - $8CA9
    dw ApplyPaletteFilter_bounce                     ; 0x01 - $A2A0
    dw Module0C_RestoreSubmodule                     ; 0x02 - $992E
}

; $01192E-$011937 LOCAL JUMP LOCATION
Module0C_RestoreSubmodule:
{
    LDA.w $010C : STA.b $10

    STZ.b $11
    STZ.b $B0

    RTS
}

; Beginning of Module 0x0D - Unused? Blank Screen
; $011938-$011950 LONG JUMP LOCATION
Module0D_Unused:
{
    LDA.l $7EC007 : LSR A : BCC .BRANCH_ALPHA
        LDA.l $7EC011 : SEC : SBC.b #$10 : STA.l $7EC011

    .BRANCH_ALPHA

    JSR.w CopyMosaicControl
    JSR.w Module0D_RunSubmodule

    RTL
}

; $011951-$01195A LOCAL JUMP LOCATION
Module0D_RunSubmodule:
{
    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw ApplyPaletteFilter_bounce ; 0x00 - $A2A0
    dw Module0C_RestoreModule    ; 0x01 - $995B
}

; $01195B-$011979 LOCAL JUMP LOCATION
Module0C_RestoreModule:
{
    STZ.b $11
    STZ.b $B0

    LDA.w $010C : STA.b $10 : CMP.b #$09 : BNE .BRANCH_ALPHA
        LDA.w $0696 : ORA.w $0698 : BEQ .BRANCH_ALPHA
            ; Mode for coming out of a special door?
            LDA.b #$0A : STA.b $11

            LDA.b #$10 : STA.w $069A

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $01197A-$01197D DATA TABLE
Pool_Module0F_SpotlightClose:
{
    .direction
    db $08
    db $04
    db $02
    db $01
}

; $01197E-$011981 LOCAL JUMP TABLE
Module_CloseSpotlightTable:
{
    dw Dungeon_PrepExitWithSpotlight      ; 0x00 - $99CA
    dw Spotlight_ConfigureTableAndControl ; 0x01 - $9A19
}

; Beginning of Module 0x0F - HDMA spotlights closing
; $011982-$0119C9 LONG JUMP LOCATION
Module_CloseSpotlight:
{
    JSL Sprite_Main

    LDA.b $11 : ASL A : TAX

    JSR (Module_CloseSpotlightTable, X)

    LDA.b $1B : BNE .BRANCH_ALPHA
        LDA.b $8A : CMP.b #$0F : BNE .BRANCH_BETA
            LDA.b #$01 : STA.w $0351

        .BRANCH_BETA

        LDA.b #$06 : STA.b $5E

        JSL Link_HandleVelocity

        STZ.b $31
        STZ.b $30

    .BRANCH_ALPHA

    LDA.b $2F : LSR A : TAX

    LDA.b $1B : BNE .BRANCH_GAMMA
        LDX.b #$00

        LDA.w $010E : CMP.b #$43 : BNE .BRANCH_GAMMA
            INX

    .BRANCH_GAMMA

    LDA.l Pool_Module0F_SpotlightClose_direction, X : STA.b $26 : STA.b $67

    JSL Link_HandleMovingAnimation_FullLongEntry
    JML PlayerOam_Main
}

; ==============================================================================

; $0119CA-$011A18 LOCAL JUMP LOCATION
Dungeon_PrepExitWithSpotlight:
{
    STZ.w $012A
    STZ.w $1F0C

    LDA.b $1B : BNE .BRANCH_ALPHA
        JSL Ancilla_TerminateWaterfallSplashes

        REP #$20

        LDA.b $20 : STA.l $7EC148

        SEP #$20

    .BRANCH_ALPHA

    LDX.w $010E

    LDA.l $02D82E, X : CMP.b #$03 : BNE .BRANCH_BETA
        LDA.l $7EF3C5 : CMP.b #$02 : BCC .BRANCH_GAMMA

    .BRANCH_BETA

    CMP.b #$F2 : BNE .BRANCH_DELTA
        LDX.w $0130 : CPX.b #$0C : BNE .BRANCH_EPSILON
            LDA.b #$07

            BRA .BRANCH_EPSILON

    .BRANCH_DELTA

    LDA.b #$F1

    .BRANCH_EPSILON

    STA.w $012C

    .BRANCH_GAMMA

    STZ.w $04A0

    JSL FloorIndicator

    INC.b $16

    JSL Spotlight_close

    INC.b $11

    .return

    RTS
}

; $011A19-$011AD2 LOCAL JUMP LOCATION
; ZS rewrites part of this function. - ZS Custom Overworld
Spotlight_ConfigureTableAndControl:
{
    JSL ConfigureSpotlightTable

    ; Disable IRQ logic.
    STZ.w $012A
    STZ.w $1F0C

    LDA.b $11 : BNE Dungeon_PrepExitWithSpotlight_return

    LDA.b $10 : CMP.b #$06 : BNE .dont_restore_y_coord
        REP #$20

        LDA.l $7EC148 : STA.b $20

        SEP #$20

    ; $011A37 ALTERNATE ENTRY POINT
    .dont_restore_y_coord

    LDA.b $10 : CMP.b #$09 : BEQ .BRANCH_BETA
        ; Force V-blank in preperation for Dungeon mode.
        JSL EnableForceBlank

        JSL Link_ItemReset_FromOverworldThings

    .BRANCH_BETA

    LDA.b $10 : CMP.b #$09 : BNE .BRANCH_GAMMA
        LDA.b $A1 : BNE .BRANCH_DELTA
            LDA.b $A0 : CMP.b #$20 : BEQ .BRANCH_EPSILON

        .BRANCH_DELTA

        LDA.b #$0A

        LDX.b $2F : BNE .BRANCH_ZETA
            LDA.b #$0B

        .BRANCH_ZETA

        STA.b $11

        .BRANCH_EPSILON

        LDA.b #$10 : STA.w $069A

        ; Not an extended door type (palace or sanctuary).
        LDA.w $0696 : ORA.w $0698 : BEQ .BRANCH_GAMMA
            LDA.w $0699 : BEQ .BRANCH_GAMMA
                LDX.b #$00

                ASL A : BCC .BRANCH_THETA
                    LDX.b #$18

                .BRANCH_THETA

                LDA.w $0699 : AND.b #$7F : STA.w $0699

                STX.w $0692

                STZ.w $0690

                LDA.b #$09 : STA.b $11

                STZ.b $B0

                LDA.b #$15 : STA.w $012F

    .BRANCH_GAMMA

    STZ.b $96 : STZ.b $97 : STZ.b $98
    STZ.b $1E : STZ.b $1F : STZ.w $03EF

    REP #$30

    ; ZS starts writing here.
    ; $011AA6 - ZS Custom Overworld
    ; Setup fixed color values based on area number.
    LDX.w #$4C26
    LDY.w #$8C4C

    ; TODO: Needs more investigation.
    ; When exiting a dungeon, the code reaches this point twice.
    ; The first time $8A has not been set yet and thus loads the incorrect
    ; values?
    LDA.b $8A

    CMP.w #$0003 : BEQ .mountain
    CMP.w #$0005 : BEQ .mountain
    CMP.w #$0007 : BEQ .mountain
        LDX.w #$4A26 : LDY.w #$874A

        CMP.w #$0043 : BEQ .mountain
        CMP.w #$0045 : BEQ .mountain
        CMP.w #$0047 : BNE .other
            .mountain

            STX.b $9C : STY.b $9D

    .other

    SEP #$30

    RTS
}

; ==============================================================================

; $011AD3-$011AD6 LOCAL JUMP TABLE
Module_OpenSpotlightTable:
{
    dw Module_OpenSpotlight_Iris          ; 0x00 - $9AE6
    dw Spotlight_ConfigureTableAndControl ; 0x01 - $9A19
}

; Module 0x10 - Opening Spotlight
; $011AD7-$011AE5 LONG JUMP LOCATION
Module_OpenSpotlight:
{
    JSL Sprite_Main

    LDA.b $11 : ASL A : TAX

    JSR (Module_OpenSpotlightTable, X)

    JML PlayerOam_Main
}

; ==============================================================================

; Module 0x10.0x00
; $011AE6-$011AEC LOCAL JUMP LOCATION
Module_OpenSpotlight_Iris:
{
    JSL Spotlight_open

    ; Move to the next submodule.
    INC.b $11

    RTS
}

; ==============================================================================

; $011AED-$011AF8 LOCAL JUMP TABLE
Pool_Module_HoleToDungeon:
{
    .submodules
    dw HoleToDungeon_FadeMusic                         ; 0x00 - $9B01
    dw HoleToDungeon_PaletteFilter                     ; 0x01 - $A29B
    dw HoleToDungeon_LoadDungeon                       ; 0x02 - $9B1C
    dw DungeonTransition_LoadSpriteGFX                 ; 0x03 - $8D10
    dw Module11_04_FadeAndLoadQuadrants                ; 0x04 - $9C0F
    dw Module11_04_FadeAndLoadQuadrants_notFullyBright ; 0x05 - $9C1C
}

; ==============================================================================

; Module 0x11 - Happens when you fall into a hole from the OW
; $011AF9-$011B00 LONG JUMP LOCATION
Module_HoleToDungeon:
{
    LDA.b $B0 : ASL A : TAX

    JSR (Pool_Module_HoleToDungeon_submodules, X)

    RTL
}

; ==============================================================================

; Module 0x11.0x00
; $011B01-$011B1B LOCAL JUMP LOCATION
HoleToDungeon_FadeMusic:
{
    LDX.w $010E

    LDA.l $02D82E, X : CMP.b #$03 : BNE .not_legend_theme
        LDA.l $7EF3C5 : CMP.b #$02 : BCC .dont_fade

    .not_legend_theme

    LDA.b #$F1 : STA.w $012C

    .dont_fade

    JMP ResetTransitionPropsAndAdvance_ResetInterface
}

; ==============================================================================

; Module 0x11.0x02 (falling into a hole).
; $011B1C-$011BD6 LOCAL JUMP LOCATION
HoleToDungeon_LoadDungeon:
{
    JSL EnableForceBlank

    LDA.b #$02 : STA.b $99

    JSR.w Dungeon_LoadEntrance

    LDA.w $040C : CMP.b #$FF : BEQ .not_palace
        CMP.b #$02 : BNE .not_sewer
            LDA.b #$00

        .not_sewer

        LSR A : TAX

        LDA.l $7EF37C, X

    .not_palace

    JSL HUD.RebuildIndoor.palace

    LDA.b #$04 : STA.b $5A
    LDA.b #$03 : STA.b $5B
    LDA.b #$0C : STA.b $4B
    LDA.b #$10 : STA.b $57

    LDA.b $20 : SEC : SBC.b $E8 : STA.b $00 : STZ.b $01

    STZ.w $0308
    STZ.w $0309
    STZ.w $030B

    REP #$30

    LDA.b $A0 : STA.b $A2

    LDA.w #$0010 : CLC : ADC.b $00 : STA.b $00

    LDA.b $20 : STA.b $51

    SEC : SBC.b $00 : STA.b $20

    SEP #$30

    LDA.b $B0 : PHA

    STZ.w $045A
    STZ.w $0458

    JSR.w Dungeon_LoadAndDrawRoom
    JSL Dungeon_LoadCustomTileAttr

    ; Load main tileset index.
    LDX.w $0AA1

    ; Use it to compress the appropriate animated tiles?
    LDA.l $02811E, X : TAY

    JSL DecompDungAnimatedTiles
    JSL Dungeon_LoadAttrTable

    ; Increment to next submodule.
    PLA : INC A : STA.b $B0

    LDA.b #$0A : STA.w $0AA4

    ; Set OBJSEL.
    LDA.b #$02 : STA.w $2101

    JSL InitTilesets

    LDA.b #$0A : STA.w $0AB1

    JSR.w Dungeon_LoadPalettes
    JSL HUD_RestoreTorchBackground

    STZ.b $3A
    STZ.b $3C

    JSR.w Dungeon_ResetTorchBackgroundAndPlayer

    LDA.w $02E0 : BEQ .using_normal_player_gfx
        JSL LoadGearPalettes.bunny

    .using_normal_player_gfx

    LDA.b #$80 : STA.b $9B

    JSL HUD.RefillLogicLong
    JSL Module_PreDungeon.setAmbientSfx

    LDA.b #$07 : STA.b $11

    ; Bleeds into the next function.
}

; $011BD7-$011C0E LOCAL JUMP LOCATION
Dungeon_LoadSongBankIfNeeded:
{
    ; Is there no music loading?
    LDA.w $0132

    CMP.b #$FF : BEQ .dontLoadMusic
    CMP.b #$F2 : BEQ .dontLoadMusic ; Half volume music.
        CMP.b #$03 : BEQ .song_is_in_outdoor_bank
        CMP.b #$07 : BEQ .song_is_in_outdoor_bank
        CMP.b #$0E : BEQ .song_is_in_outdoor_bank

        LDA.w $0136 : BNE .dontLoadMusic
            SEI

            STZ.w $4200
            STZ.w $420C

            INC.w $0136

            LDA.b #$FF : STA.w $2140

            JSL Sound_LoadIndoorSongBank

            LDA.b #$81 : STA.w $4200

    .dontLoadMusic

    RTS

    .song_is_in_outdoor_bank

    JMP Overworld_LoadMusicIfNeeded
}

; ==============================================================================

; $011C0F-$011C3D LOCAL JUMP LOCATION
Module11_04_FadeAndLoadQuadrants:
{
    LDA.b $13 : INC A : AND.b #$0F : STA.b $13

    CMP.b #$0F : BNE .notFullyBright
        INC.b $B0

    ; $011C1C ALTERNATE ENTRY POINT
    .notFullyBright

    JSL HandleUnderworldLandingFromPit

    LDA.b $11 : BNE .notDefaultSubmodule
        LDA.b #$07 : STA.b $10

        ; Disable tag routines while Link is still falling.
        INC.w $04C7

        JSR.w Dungeon_PlayBlipAndCacheQuadrantVisits
        JSR.w ResetThenCacheRoomEntryProperties

        LDA.w $0132 : STA.w $012C

        LDA.w $0130 : STA.w $0133

    .notDefaultSubmodule

    RTS
}

; ==============================================================================

; $011C3E-$011C49 LOCAL JUMP TABLE
Module_BossVictoryTable:
{
    dw Module_BossVictory_Heal               ; 0x00 - $9C59
    dw Module_BossVictory_StartSpinAnimation ; 0x01 - $9C93
    dw Module_BossVictory_RunSpinAnimation   ; 0x02 - $9CAD
    dw Module_BossVictory_EndSpinAnimation   ; 0x03 - $9CD1
    dw Dungeon_PrepExitWithSpotlight         ; 0x04 - $99CA
    dw Spotlight_ConfigureTableAndControl    ; 0x05 - $9A19
}

; Beginning of Module 0x13 - Boss Victory and Refill Mode
; $011C4A-$011C58 LONG JUMP LOCATION
Module_BossVictory:
{
    LDA.b $11 : ASL A : TAX

    JSR (Module_BossVictoryTable, X)

    JSL Sprite_Main
    JML PlayerOam_Main
}

; ==============================================================================

; $011C59-$011C92 LOCAL JUMP LOCATION
Module_BossVictory_Heal:
{
    JSL HUD.RefillMagicPower : BCS .still_restoring_magic
        INC.w $0200

    .still_restoring_magic

    JSL HUD.RefillHealth : BCS .still_healing_hp
        INC.w $0200

    .still_healing_hp

    LDA.w $0200 : BNE .reset_module
        LDA.b $3A : AND.b #$BF : STA.b $3A

        JSR.w DeleteCertainAncillaeStopDashing

        LDA.b #$02 : STA.b $2F

        ASL A : STA.b $26

        INC.b $16 : INC.b $11

        LDA.b #$10 : STA.b $B0

        ; Make it so Link can't move.
        INC.w $02E4

    .reset_module

    STZ.w $0200

    JSL HUD_RefillLogicLong

    RTS
}

; ==============================================================================

; $011C93-$011CAC LOCAL JUMP LOCATION
Module_BossVictory_StartSpinAnimation:
{
    DEC.b $B0 : BNE .countingDown
        STZ.w $02E4

        LDA.b #$02 : STA.b $2F

        JSL Link_AnimateVictorySpin_long
        JSL Ancilla_TerminateSelectInteractives
        JSL addVictorySpinEffect

        INC.b $11

    .countingDown

    RTS
}

; ==============================================================================

; $011CAD-$011CD0 LOCAL JUMP LOCATION
Module_BossVictory_RunSpinAnimation:
{
    JSL Player_Main

    LDA.b $5D : CMP.b #$00 : BNE .return
        ; What the deuce... are we supposed to be able to get. the master sword
        ; without having the original sword? The sound effect only triggers if
        ; you have the fighter sword, or the tempered sword.
        LDA.l $7EF359 : INC A : AND.b #$FE : BEQ .noSound
            ; Play "pulling master sword out" sound.
            LDA.b #$2C : STA.w $012E

        .noSound

        LDA.b #$01 : STA.w $03EF

        LDA.b #$20 : STA.b $B0

        INC.b $11

    .return

    RTS
}

; ==============================================================================

; $011CD1-$011CE1 LOCAL JUMP LOCATION
Module_BossVictory_EndSpinAnimation:
{
    DEC.b $B0 : BNE .exit
        INC.b $11

        STZ.b $30
        STZ.b $31

        LDA.b #$00 : STA.l $7EC017

    .exit

    RTS
}


; ==============================================================================

; $011CE2-$011CFB LOCAL JUMP TABLE
Module_MirrorTable:
{
    ; TODO: Come up with better names for some of these.
    .states
    dw Mirror_LoadMusic                      ; 0x00 - $9D16
    dw Mirror_Init                           ; 0x01 - $9D22
    dw Module15_02_RunMirrorWarp_Part1       ; 0x02 - $9E06
    dw Module15_03_RunMirrorWarp_Part2       ; 0x03 - $9E0F
    dw Module15_04_RunMirrorWarp_Part3       ; 0x04 - $9E15
    dw Module15_05                           ; 0x05 - $9D5D
    dw Module15_06                           ; 0x06 - $9DB6
    dw Module15_07                           ; 0x07 - $9DC2
    dw Module15_08                           ; 0x08 - $9DF5
    dw Module_BossVictory_Heal               ; 0x09 - $9C59
    dw Module_BossVictory_StartSpinAnimation ; 0x0A - $9C93
    dw Module_BossVictory_RunSpinAnimation   ; 0x0B - $9CAD
    dw Module15_0C                           ; 0x0C - $9E22
}

; Beginning of Module 0x15 - Magic Mirror
; $011CFC-$011D15 LONG JUMP LOCATION
Module_Mirror:
{
    LDA.b $11 : ASL A : TAX

    JSR (Module_MirrorTable_states, X)

    LDA.b $11

    CMP.b #$02 : BCC .runCoreTasks
        CMP.b #$05 : BCC .ignoreCoreTasks

    .runCoreTasks

    JSL Sprite_Main
    JSL PlayerOam_Main

    .ignoreCoreTasks

    RTL
}

; ==============================================================================

; $011D16-$011D21 LOCAL JUMP LOCATION
Mirror_LoadMusic:
{
    STZ.w $0710

    INC.w $0200
    INC.b $11

    JSR.w Overworld_LoadMusicIfNeeded

    RTS
}

; ==============================================================================

; $011D22-$011D5C LOCAL JUMP LOCATION
Mirror_Init:
{
    ; Play the mirror warp "music".
    LDA.b #$08 : STA.w $012C
                 STA.w $0410

    JSL Mirror_InitHdmaSettings

    STZ.w $0200

    JSL Palette_InitWhiteFilter
    JSR.w Overworld_LoadMapProperties

    INC.b $11

    ; Put player into the "Being magic mirror warped state".
    LDA.b #$14 : STA.b $5D

    REP #$20

    STZ.w $011A
    STZ.w $011C
    STZ.w $0402
    STZ.b $30

    LDA.w #$7FFF : STA.l $7EC500 : STA.l $7EC540

    SEP #$20

    JSL ResetAncillaAndLink

    RTS
}

; ==============================================================================

; $011D5D-$011DB5 LOCAL JUMP LOCATION
Module15_05:
{
    REP #$30

    LDA.w #$2641 : STA.w $4370

    LDX.w #$003E
    LDA.w #$FF00

    .alpha

        STA.w $1B00, X : STA.w $1B40, X : STA.w $1B80, X : STA.w $1BC0, X
        STA.w $1C00, X : STA.w $1C40, X : STA.w $1C80, X
    DEX #2 : BPL .alpha

    LDA.w #$0000 : STA.l $7EC007 : STA.l $7EC009

    SEP #$20

    LDX.w #$0035 : STX.w $1CF0

    SEP #$10

    JSL Main_ShowTextMessage
    JSL ReloadPreviouslyLoadedSheets
    JSL HUD_RebuildIndoor

    LDA.b #$80 : STA.b $9B

    LDA.b #$15 : STA.b $10
    LDA.b #$06 : STA.b $11
    LDA.b #$18 : STA.b $B0

    RTS
}

; ==============================================================================

; $011DB6-$011DC1 LOCAL JUMP LOCATION
Module15_06:
{
    DEC.b $B0 : BNE .BRANCH_ALPHA
        INC.b $11

        LDA.b #$09 : STA.w $012D

    .BRANCH_ALPHA

    RTS
}

; $011DC2-$011DF4 LOCAL JUMP LOCATION
Module15_07:
{
    JSL Messaging_Text

    LDA.b $11 : BNE .BRANCH_ALPHA
        STZ.w $0200

        LDA.b #$05 : STA.w $012D

        LDX.b #$09

        LDA.l $7EF357 : BNE .BRANCH_BETA
            REP #$20

            LDA.w #$0036 : STA.w $1CF0

            SEP #$20

            JSL Main_ShowTextMessage

            STZ.w $012D

            LDA.b #$15 : STA.b $10

            LDX.b #$09

            DEX

        .BRANCH_BETA

        STX.b $11

    .BRANCH_ALPHA

    RTS
}

; $011DF5-$011E05 LOCAL JUMP LOCATION
Module15_08:
{
    JSL Messaging_Text

    LDA.b $11 : BNE .BRANCH_ALPHA
        LDA.b #$20 : STA.b $B0
        LDX.b #$0C : STX.b $11

    .BRANCH_ALPHA

    RTS
}

; $011E06-$011E0E LOCAL JUMP LOCATION
Module15_02_RunMirrorWarp_Part1:
{
    JSL MirrorHDMA

    INC.b $11

    STZ.b $B0

    RTS
}

; $011E0F-$011E14 LOCAL JUMP LOCATION
Module15_03_RunMirrorWarp_Part2:
{
    JSL MirrorWarp_BuildWavingHDMATable

    BRA Module15_04_RunMirrorWarp_Part3_check_subsub
}

; $011E15-$011E21 LOCAL JUMP LOCATION
Module15_04_RunMirrorWarp_Part3:
{
    JSL MirrorWarp_BuildDewavingHDMATable

    .check_subsub

    LDA.b $B0 : BEQ .BRANCH_BETA
        STZ.b $B0

        INC.b $11

    .BRANCH_BETA

    RTS
}

; $011E22-$011E5E LOCAL JUMP LOCATION
Module15_0C:
{
    DEC.b $B0 : BNE .stillCountingDown
        JSL SetTargetOverworldWarpToPyramid_ResetAncillaAndCutscene
        JSL Overworld_SetSongList

        LDA.l $7EF29B : ORA.b #$20 : STA.l $7EF29B

        LDA.b #$FF : STA.w $040C

        STZ.b $11
        STZ.w $0200
        STZ.w $0710

        LDA.b #$09 : STA.b $10

        STZ.b $E6

        LDX.b #$09

        LDA.l $7EF357 : BNE .hasMoonPearl
            ; Set the music differently if Link has no moon pearl.
            LDX.b #$04

        .hasMoonPearl

        STX.w $012C

        LDA.b #$06 : STA.l $7EF3C7

    .stillCountingDown

    RTS
}

; ==============================================================================

; $011E5F-$011E7F LONG JUMP LOCATION
SetTargetOverworldWarpToPyramid:
{
    ; If Link is not currently in a mirror warp, return
    ; This seems silly though, because the only routine that references this
    ; is from the mirror module...
    LDA.b $10 : CMP.b #$15 : BNE .not_in_mirror_module
        JSR.w Overworld_LoadExitData

        LDY.b #$5A

        JSL DecompOwAnimatedTiles

        ; $011E6E ALTERNATE ENTRY POINT
        .ResetAncillaAndCutscene

        JSL Ancilla_TerminateSelectInteractives

        STZ.w $037B

        STZ.b $3C : STZ.b $3A

        STZ.w $03EF : STZ.w $02E4

    .not_in_mirror_module

    RTL
}

; ==============================================================================

; $011E80-$011E89 LOCAL JUMP TABLE
Pool_Module_Victory:
{
    .states
    dw Module_BossVictory_Heal               ; 0x00 - $9C59
    dw Module_BossVictory_StartSpinAnimation ; 0x01 - $9C93
    dw Module_BossVictory_RunSpinAnimation   ; 0x02 - $9CAD
    dw Module_BossVictory_EndSpinAnimation   ; 0x03 - $9CD1
    dw Module16_04_FadeAndEnd                ; 0x04 - $9E9A
}

; Module 0x16 - Module for refilling stats after boss
; $011E8A-$011E98 LONG JUMP LOCATION
Module_Victory:
{
    LDA.b $11 : ASL A : TAX

    JSR (Pool_Module_Victory_states, X)

    JSL Sprite_Main
    JML PlayerOam_Main
}

; ==============================================================================

; $011E99-$011E99 LOCAL BRANCH LOCATION
EXIT_029E99:
{
    RTS
}

; $011E9A-$011EC9 LOCAL JUMP LOCATION
Module16_04_FadeAndEnd:
{
    DEC.b $13 : BNE EXIT_029E99
        REP #$20

        STZ.w $011A : STZ.w $011C : STZ.b $30

        SEP #$20

        STZ.w $02E4

        JSL Palette_RevertTranslucencySwap

        LDA.b #$00 : STA.b $5D

        STZ.w $02D8 : STZ.w $02DA : STZ.w $037B

        LDA.w $010C : STA.b $10

        STZ.b $11 : STZ.b $B0

        JMP.w Spotlight_ConfigureTableAndControl_dont_restore_y_coord
}

; ==============================================================================

; $011ECA-$011EDB LOCAL JUMP TABLE
Pool_Module_GanonEmerges:
{
    .submodules
    dw GanonEmerges_GetBirdForPursuit           ; 0x00 - $9F2F
    dw GanonEmerges_PrepForPyramidLocation      ; 0x01 - $9F42
    dw GanonEmerges_FadeOutDungeonScreen        ; 0x02 - $9F5E
    dw GanonEmerges_LOadPyramidArea             ; 0x03 - $9F76
    dw GanonEmerges_LoadAmbientOverlay          ; 0x04 - $9F8B
    dw GanonEmerges_BrightenScreenThenSpawnBat  ; 0x05 - $9F94
    dw GanonEmerges_DelayForBatSmashIntoPyramid ; 0x06 - $9FC0
    dw GanonEmerges_DelayPlayerDropOff          ; 0x07 - $9FC1
    dw GanonEmerges_DropOffPlayerAtPyramid      ; 0x08 - $9FC9
}

; Module 0x18 - Ganon exits from Agahnim's body, Chase Mode
; $011EDC-$011F2E LONG JUMP LOCATION
Module_GanonEmerges:
{
    REP #$21

    LDA.b $E2 : PHA :       ADC.w $011A : STA.b $E2 : STA.w $011E
    LDA.b $E8 : PHA : CLC : ADC.w $011C : STA.b $E8 : STA.w $0122
    LDA.b $E0 : PHA : CLC : ADC.w $011A : STA.b $E0 : STA.w $0120
    LDA.b $E6 : PHA : CLC : ADC.w $011C : STA.b $E6 : STA.w $0124

    SEP #$20

    JSL Sprite_Main

    REP #$20

    PLA : STA.b $E6
    PLA : STA.b $E0
    PLA : STA.b $E8
    PLA : STA.b $E2

    SEP #$20

    LDA.w $0200 : ASL A : TAX

    JSR (Pool_Module_GanonEmerges_submodules, X)

    JML PlayerOam_Main
}

; ==============================================================================

; $011F2F-$011F41 LOCAL JUMP LOCATION
GanonEmerges_GetBirdForPursuit:
{
    JSL Effect_Handler
    JSL GanonEmerges_SpawnTravelBird
    JSL Dungeon_SaveRoomData.justKeys

    INC.w $0200
    INC.w $02E4

    RTS
}

; ==============================================================================

; $011F42-$011F5D LOCAL JUMP LOCATION
GanonEmerges_PrepForPyramidLocation:
{
    JSL Effect_Handler

    LDA.b $11 : CMP.b #$0A : BNE .dont_transfer_yet
        LDA.b #$5B : STA.b $8A

        STZ.b $1B

        LDA.b #$18 : STA.b $10

        STZ.b $11

        LDA.b #$02 : STA.w $0200

    .dont_transfer_yet

    RTS
}

; ==============================================================================

; $011F5E-$011F75 LOCAL JUMP LOCATION
GanonEmerges_FadeOutDungeonScreen:
{
    JSL Effect_Handler

    DEC.b $13 : BNE .not_fully_darkened
        JSL EnableForceBlank

        INC.w $0200

        JSL HUD_RebuildIndoor

        STZ.b $30 : STZ.b $31

    .not_fully_darkened

    RTS
}

; ==============================================================================

; $011F76-$011F8A LOCAL JUMP LOCATION
GanonEmerges_LOadPyramidArea:
{
    ; The 9th bird travel target is only accessible via this code.
    ; It also happens to put you in the Dark World.
    LDA.b #$08 : STA.w $1AF0
                 STZ.w $1AF1

    JSL BirdTravel_LoadTargetArea
    JSR.w Overworld_LoadMusicIfNeeded

    ; Load the dark world music.
    LDA.b #$09 : STA.w $012C

    RTS
}

; ==============================================================================

; $011F8B-$011F93 LOCAL JUMP LOCATION
GanonEmerges_LoadAmbientOverlay:
{
    JSL BirdTravel_LoadAmbientOverlay

    LDA.b #$00 : STA.b $B0

    RTS
}

; ==============================================================================

; Module 0x18, submodule 0x05
; $011F94-$011FBF LOCAL JUMP LOCATION
GanonEmerges_BrightenScreenThenSpawnBat:
{
    INC.b $13

    ; Wait until screen reaches full brightness.
    LDA.b $13 : CMP.b #$0F : BNE .still_brightening
        STZ.w $0402
        STZ.w $0403
        STZ.w $0FC1

        JSL GanonEmerges_SpawnRetreatBat

        LDA.b #$02 : STA.b $2F

        LDA.b #$09 : STA.w $010C

        STZ.b $1B

        ; Go to the next submodule.
        INC.w $0200

        LDA.b #$80 : STA.b $B0

        LDA.b #$FF : STA.w $040C

    .still_brightening

    ; Bleeds into the next function.
}

; $011FC0-$011FC0 LOCAL JUMP LOCATION
GanonEmerges_DelayForBatSmashIntoPyramid:
{
    RTS
}

; ==============================================================================

; $011FC1-$011FC8 LOCAL JUMP LOCATION
GanonEmerges_DelayPlayerDropOff:
{
    ; Why not just branch to this routine's return instruction?
    DEC.b $B0 : BNE GanonEmerges_DelayForBatSmashIntoPyramid
        INC.w $0200

        RTS
}

; ==============================================================================

; $011FC9-$011FCD LOCAL JUMP LOCATION
GanonEmerges_DropOffPlayerAtPyramid:
{
    ; \wtf Wasn't the previous module dungeon?
    JSL BirdTravel_Finish_restore_prev_module

    RTS
}

; ==============================================================================

; $011FCE-$011FEB LOCAL JUMP TABLE
Pool_Module_TriforceRoom:
{
    .submodules
    dw TriforceRoom_Step0      ; 0x00 - $A021
    dw TriforceRoom_Step1      ; 0x01 - $A02F
    dw TriforceRoom_Step2      ; 0x02 - $A035
    dw TriforceRoom_Step3      ; 0x03 - $A065
    dw TriforceRoom_Step4      ; 0x04 - $A089
    dw TriforceRoom_Step5      ; 0x05 - $A0CD
    dw TriforceRoom_Step6      ; 0x06 - $A0E4
    dw TriforceRoom_Step7      ; 0x07 - $A100
    dw TriforceRoom_Step8And10 ; 0x08 - $A137
    dw TriforceRoom_Step9      ; 0x09 - $A121
    dw TriforceRoom_Step8And10 ; 0x0A - $A137
    dw TriforceRoom_Step11     ; 0x0B - $A151
    dw TriforceRoom_Step12     ; 0x0C - $A164
    dw TriforceRoom_Step13     ; 0x0D - $A173
    dw TriforceRoom_Step14     ; 0x0E - $A186
}

; ==============================================================================

; Module 0x19 - Triforce Room scene
; $011FEC-$012020 LONG JUMP LOCATION
Module_TriforceRoom:
{
    LDA.b $B0 : ASL A : TAX

    JSR (Pool_Module_TriforceRoom_submodules, X)

    REP #$20

    LDA.b $E0 : STA.w $0120

    LDA.b $E6 : STA.w $0124

    LDA.b $E2 : STA.w $011E

    LDA.b $E8 : STA.w $0122

    SEP #$20

    LDA.b $B0 : CMP.b #$07 : BCC .BRANCH_ALPHA
        CMP.b #$0B : BCC .BRANCH_BETA

    .BRANCH_ALPHA

    JSL Link_HandleVelocity
    JSL Link_HandleMovingAnimation_FullLongEntry

    .BRANCH_BETA

    JML PlayerOam_Main
}

; ==============================================================================

; $012021-$01202E LOCAL JUMP LOCATION
TriforceRoom_Step0:
{
    JSL Player_ResetState

    STZ.b $66

    ; Make music fade out.
    LDA.b #$F1 : STA.w $012C

    JMP ResetTransitionPropsAndAdvance_ResetInterface
}

; $01202F-$012034 LOCAL JUMP LOCATION
TriforceRoom_Step1:
{
    JSR.w Overworld_ResetMosaic
    JMP ApplyPaletteFilter_bounce
}

; $012035-$012064 LOCAL JUMP LOCATION
TriforceRoom_Step2:
{
    JSL EnableForceBlank

    SEI

    ; Disable NMI, IRQ, and automatic joypad reads.
    STZ.w $4200

    ; Load in the ending music.
    LDA.b #$FF : STA.w $2140
    JSL Sound_LoadEndingSongBank

    ; Reenable NMI and automatic joypad reads.
    LDA.b #$81 : STA.w $4200

    ; Set exit identifier to 0x0189 (special area, probably) ; Yes it is.
    LDA.b #$89 : STA.b $A0
    LDA.b #$01 : STA.b $A1

    JSL Vram_EraseTilemaps.normal
    JSL Palette_RevertTranslucencySwap
    JSR.w LoadSpecialOverworld
    JSR.w Overworld_ReloadSubscreenOverlay

    INC.b $B0

    BRA RefreshTriforceModule
}

; ZS overwrites part of this function. - ZS Custom Overworld
; Module 0x19.0x03
; $012065-$012088 LOCAL JUMP LOCATION
TriforceRoom_Step3:
{
    LDA.b #$24 : STA.w $0AA1
    LDA.b #$7D : STA.w $0AA3
    LDA.b #$51 : STA.w $0AA2

    JSL InitTilesets

    LDX.b #$04

    ; ZS writes here. - ZS Custom Overworld
    ; $01207A
    JSR.w Overworld_LoadAreaPalettes_preloaded

    LDA.b #$0E

    JSL Overworld_LoadPalettes
    JSR.w SpecialOverworld_CopyPalettesToCache

    INC.b $B0

    RTS
}

; $012089-$0120C5 LOCAL JUMP LOCATION
TriforceRoom_Step4:
{
    LDA.b $B0 : PHA

    JSR.w PreOverworld_LoadAndAdvance

    PLA : INC A : STA.b $B0

    LDA.b #$0F : STA.b $13

    LDA.b #$1F : STA.l $7EC007
    LDA.b #$00 : STA.l $7EC00B

    LDA.b #$01 : STA.b $E1

    LDA.b #$02 : STA.b $99
    LDA.b #$32 : STA.b $9A

    LDA.b #$F0 : STA.l $7EC011

    LDA.b #$EC : STA.b $20
    LDA.b #$78 : STA.b $22

    LDA.b #$02 : STA.b $EE

    LDA.b #$20 : STA.w $012C

    ; Bleeds into the next function.
}

; $0120C6-$0120CC LOCAL JUMP LOCATION
RefreshTriforceModule:
{
    LDA.b #$19 : STA.b $10

    STZ.b $11

    RTS
}

; $0120CD-$0120E3 LOCAL JUMP LOCATION
TriforceRoom_Step5:
{
    LDA.b #$08 : STA.b $67 : STA.b $26

    STZ.b $2F

    LDA.b $20 : CMP.b #$C0 : BCS .alpha
        STZ.b $67
        STZ.b $26
        STZ.b $2E

        INC.b $B0

    .alpha

    RTS
}

; $0120E4-$0120FF LOCAL JUMP LOCATION
TriforceRoom_Step6:
{
    LDA.l $7EC007 : LSR A : BCS .BRANCH_ALPHA
        LDA.l $7EC011 : BEQ .BRANCH_ALPHA
            SEC : SBC.b #$10 : STA.l $7EC011

    .BRANCH_ALPHA

    JSR.w CopyMosaicControl
    JSL PaletteFilter.doFiltering

    RTS
}

; $012100-$012120 LOCAL JUMP LOCATION
TriforceRoom_Step7:
{
    JSL TriforceRoom_PrepGFXSlotForPoly

    REP #$20

    LDA.w #$0173 : STA.w $1CF0

    SEP #$20

    JSL Main_ShowTextMessage
    JSL Messaging_Text

    LDA.b #$80 : STA.b $C8
    LDA.b #$19 : STA.b $10

    INC.b $B0

    RTS
}

; $012121-$012136 LOCAL JUMP LOCATION
TriforceRoom_Step9:
{
    JSL AdvancePolyhedral
    JSL Messaging_Text

    LDA.b $11 : BNE .waitForTextToEnd
        STZ.w $0200

        LDA.b #$19 : STA.b $10

        INC.b $B0

    .waitForTextToEnd
    
    RTS
}

; $012137-$012150 LOCAL JUMP LOCATION
TriforceRoom_Step8And10:
{
    JSL AdvancePolyhedral

    LDA.b $B0 : CMP.b #$0B : BNE .BRANCH_ALPHA
        LDA.b #$21 : STA.w $012C

        LDA.b #$19 : STA.b $10

        STZ.b $67
        STZ.b $26

        INC.b $11

    .BRANCH_ALPHA

    RTS
}

; ==============================================================================

; $012151-$012163 LOCAL JUMP LOCATION
TriforceRoom_Step11:
{
    JSL AdvancePolyhedral
    JSL Player_ApproachTriforce

    LDA.b $B0 : CMP.b #$0C : BNE .alpha
        STZ.b $67
        STZ.b $26

    .alpha

    RTS
}

; ==============================================================================

; Submodule ??? of triforce room scene (fades screen to white after a time).
; $012164-$012172 LOCAL JUMP LOCATION
TriforceRoom_Step12:
{
    JSL AdvancePolyhedral

    ; $C8 used as a timer here?
    DEC.b $C8 : BNE .alpha
        JSL PaletteBlackAndWhiteSomething_NonConditional

        INC.b $11

    .alpha

    RTS
}

; ==============================================================================

; Totally brighten the screen (manipulate almost all palettes to be fully
; white).
; $012173-$012185 LOCAL JUMP LOCATION
TriforceRoom_Step13:
{
    JSL AdvancePolyhedral
    JSL PaletteFilter_BlindingWhiteTriforce

    LDA.l $7EC009 : CMP.b #$FF : BNE .alpha
        INC.b $B0

    .alpha

    RTS
}

; ==============================================================================

; $012186-$0121A3 LOCAL JUMP LOCATION
TriforceRoom_Step14:
{
    ; Make the screen dark and transition to the ending sequence module.
    DEC.b $13 : BNE .continue_darkening
        LDA.b #$1A : STA.b $10

        STZ.b $11
        STZ.b $B0

        LDA.b #$FF : STA.w $0128

        STZ.w $012A
        STZ.w $1F0C

        LDA.b #$00 : STA.l $7EF3CA

    .continue_darkening

    RTS
}

; ==============================================================================

; Note: Crystals and pendant bitfiels indicating status.
; $0121A4-$0121B0 DATA
Pool_MilestoneItem_Flags:
{
    db $00, $00, $04, $02, $00, $10, $02, $01
    db $40, $04, $01, $20, $08
}

; ==============================================================================

; $0121B1-$0121E4 LONG JUMP LOCATION
Dungeon_SaveRoomData:
{
    LDA.w $040C : CMP.b #$FF : BEQ .notInPalace
        LDA.b #$19 : STA.b $11

        STZ.b $B0

        LDA.b #$33 : STA.w $012E

        JSL Dungeon_SaveRoomQuadrantData

        ; $0121C7 ALTERNATE ENTRY POINT
        .justKeys

        ; Branch if in a non palace interior.
        LDA.w $040C : CMP.b #$FF : BEQ .return
            ; Is it the Sewer?
            CMP.b #$02 : BNE .notSewer
                ; If it's the sewer, put them in the same slot as Hyrule
                ; Castles's. annoying :p.
                LDA.b #$00

            .notSewer

            LSR A : TAX

            ; Load our current count of keys for this dungeon.
            ; Save it to an appropriate slot.
            LDA.l $7EF36F : STA.l $7EF37C, X

        .return

        RTL

    .notInPalace

    ; Play the error sound effect.
    LDA.b #$3C : STA.w $012E

    RTL
}

; ==============================================================================

; $0121E5-$0121E8 DATA
RoomEffectFixedColors:
{
    db 31,  8,  4,  0
}

; $0121E9-$012280 LOCAL JUMP LOCATION
Dungeon_HandleTranslucencyAndPalettes:
{
    LDA.w $0ABD : BEQ .no_swap
        JSL Palette_RevertTranslucencySwap

    .no_swap

    LDA.b #$02 : STA.b $99
    LDA.b #$B3 : STA.b $9A

    LDX.w $045A

    LDA.l $7EC005 : BNE .darkTransition
        LDA.b #$20
        LDX.b #$03

        LDY.w $0414 : BEQ .setColorMath
            LDA.b #$32

            CPY.b #$07 : BEQ .setColorMath
                LDA.b #$62

                CPY.b #$04 : BEQ .setColorMath
                    LDA.b #$20

                    CPY.b #$02 : BNE .setColorMath
                        PHX

                        JSL Palette_AssertTranslucencySwap

                        PLX

                        LDA.b $A0 : CMP.b #$0D : BNE .notAgahnim2
                            REP #$20

                            LDA.w #$0000

                            STA.l $7EC019 : STA.l $7EC01B : STA.l $7EC01D
                            STA.l $7EC01F : STA.l $7EC021 : STA.l $7EC023

                            SEP #$20

                            JSL Palette_AgahnimClones

                        .notAgahnim2

                        LDA.b #$70

        .setColorMath

        STA.b $9A

    .darkTransition

    LDA.l RoomEffectFixedColors, X : STA.l $7EC017

    LDA.b #$1F : STA.l $7EC007
    LDA.b #$00 : STA.l $7EC00B
    LDA.b #$02 : STA.l $7EC009

    STZ.w $0AA9

    JSL Palette_DungBgMain
    JSL Palette_SpriteAux3
    JSL Palette_SpriteAux1
    JSL Palette_SpriteAux2

    INC.b $B0

    RTS
}

; ==============================================================================

; $012281-$01229A LOCAL JUMP LOCATION
UnusedInterfacePaletteRecovery:
{
    JSL PaletteFilter_doFiltering

    LDA.l $7EC007 : BNE .stillFiltering
        ; Turn off the dark transition.
        LDA.b #$00 : STA.l $7EC005

        LDA.w $010C : STA.b $10

        STZ.b $B0 : STZ.b $11

    .stillFiltering

    RTS
}

; ==============================================================================

; $01229B-$01229F LOCAL JUMP LOCATION
HoleToDungeon_PaletteFilter:
{
    JSL PaletteFilter

    RTS
}

; ==============================================================================

; Perform color filtering (darken the screen).
; $0122A0-$0122A4 LOCAL JUMP LOCATION
ApplyPaletteFilter_bounce:
{
    JSL PaletteFilter_doFiltering

    RTS
}

; ==============================================================================

; $0122A5-$0122A8 LONG JUMP LOCATION
ResetTransitionPropsAndAdvance_ResetInterface_long:
{
    JSR.w ResetTransitionPropsAndAdvance_ResetInterface

    RTL
}

; ==============================================================================

; Only known reference is from a seemingly unused submodule of module 0x0E
; (submodule 0x06).
; $0122A9-$0122AC LONG JUMP LOCATION 
Underworld_HandleTranslucencyAndPalettes_long:
{
    JSR.w Dungeon_HandleTranslucencyAndPalettes

    RTL
}

; $0122AD-$0122B0 LONG JUMP LOCATION
UnusedInterfacePaletteRecovery_long:
{
    JSR.w UnusedInterfacePaletteRecovery

    RTL
}

; $0122F0-$01237B LOCAL JUMP LOCATION
Dungeon_AdjustAfterSpiralStairs:
{
    LDA.b $A2 : AND.b #$0F : STA.b $00

    ; $00 = ( (prev_room & 0x0F) - (current_room & 0x0F) ) << 1
    LDA.b $A0 : AND.b #$0F : SEC : SBC.b $00 : ASL A : STA.b $00

    LDA.b $23 : CLC : ADC.b $00 : STA.b $23

    LDA.b $E3 : CLC : ADC.b $00 : STA.b $E3

    LDA.w $060D : CLC : ADC.b $00 : STA.w $060D
    LDA.w $060F : CLC : ADC.b $00 : STA.w $060F
    LDA.w $0609 : CLC : ADC.b $00 : STA.w $0609
    LDA.w $060B : CLC : ADC.b $00 : STA.w $060B

    LDA.b $A2 : AND.b #$F0 : LSR #3 : STA.b $00
    LDA.b $A0 : AND.b #$F0 : LSR #3 : STA.b $01

    SEC : SBC.b $00 : STA.b $00

    LDA.b $21 : CLC : ADC.b $00 : STA.b $21

    LDA.b $E9 : CLC : ADC.b $00 : STA.b $E9

    LDA.w $0605 : CLC : ADC.b $00 : STA.w $0605
    LDA.w $0607 : CLC : ADC.b $00 : STA.w $0607
    LDA.w $0601 : CLC : ADC.b $00 : STA.w $0601
    LDA.w $0603 : CLC : ADC.b $00 : STA.w $0603

    RTS
}

; $01237C-$01240C LOCAL JUMP LOCATION
Dungeon_AdjustCoordsForLinkedRoom:
{
    ; Y indicates the X direction we're moving in (-1 - left, 1 - right)
    ; A is (new room number - 1)

    ; It seems like this attempts to find the difference in X and Y
    ; coordinates between the source room and the target room and adjust
    ; the high bytes of the X and Y coordinates accordingly. Whether it's
    ; 100% sound logic, I'm not sure.

    STY.b $00

    STA.w $048E : STA.b $A2

    LDA.b $A2 : AND.b #$0F : ASL A : SEC : SBC.b $23 : CLC : ADC.b $00 : STA.b $00

    LDA.b $23 : CLC : ADC.b $00 : STA.b $23

    LDA.b $E3 : CLC : ADC.b $00 : STA.b $E3

    LDA.w $060D : CLC : ADC.b $00 : STA.w $060D
    LDA.w $060F : CLC : ADC.b $00 : STA.w $060F
    LDA.w $0609 : CLC : ADC.b $00 : STA.w $0609
    LDA.w $060B : CLC : ADC.b $00 : STA.w $060B

    LDA.b $A2 : AND.b #$F0 : LSR #3 : SEC : SBC.b $21 : STA.b $00

    LDA.b $21 : CLC : ADC.b $00 : STA.b $21

    LDA.b $E9 : CLC : ADC.b $00 : STA.b $E9

    LDA.w $0605 : CLC : ADC.b $00 : STA.w $0605
    LDA.w $0607 : CLC : ADC.b $00 : STA.w $0607
    LDA.w $0601 : CLC : ADC.b $00 : STA.w $0601
    LDA.w $0603 : CLC : ADC.b $00 : STA.w $0603

    LDY.b #$00

    .updateTagalong_y_coord

        LDA.b $21 : STA.w $1A14, Y
    INY : CPY.b #$14 : BNE .updateTagalong_y_coord

    RTS
}

; ==============================================================================
; OVERWORLD MODULE
; ==============================================================================

; Module 0x09
; $01240D-$01246C LOCAL JUMP TABLE
Module_OverworldTable:
{
    ; TODO: Figure out how to format all this.
    ; (Indexed by $11)
    dw Overworld_PlayerControl              ; 0x00 Default mode.
    dw Overworld_LoadTransGfx               ; 0x01 1 through 8 seem to be screen transitioning.
    dw Overworld_FinishTransGfx             ; 0x02 Blits the remainder of the bg / spr graphics to vram.
    dw Overworld_LoadNewMapAndGfx           ; 0x03 Loads map32 data, event overlay, converts to map16 and map8.
    dw Overworld_LoadNewSprites             ; 0x04 Loads new sprites.
    dw Overworld_LoadNewSprites_justScroll  ; 0x05 Start Scroll Transition.
    dw Overworld_RunScrollTransition        ; 0x06 Run scroll transition.
    dw Overworld_EaseOffScrollTransition    ; 0x07 Ease off scroll transition.
    dw Overworld_FinalizeEntryOntoScreen    ; 0x08 Referenced in relation to bombs.
    dw Overworld_OpenBigDoorFromExiting     ; 0x09 Exiting a big door mode.
    dw Overworld_WalkFromExiting_FaceDown   ; 0x0A Positioning Link after coming out a door.
    dw Overworld_WalkFromExiting_FaceUp     ; 0x0B
    dw Overworld_OpenBigFancyDoor           ; 0x0C Submodule for opening fancy doors.
    dw Overworld_StartMosaicTransition      ; 0x0D Entering forest submodule (areas 0x40 or 0x00).
    dw Overworld_LoadSubscreenAndSilenceSFX1; 0x0E $012F19
    dw Overworld_LoadTransGfx               ; 0x0F AB88 = $012B88 ; Run when triggering a mosaic.
    dw Overworld_FinishTransGfx             ; 0x10 referenced in relation to bombs.
    dw Overworld_TransMapData               ; 0x11 ABC6 = $012BC6
    dw Overworld_LoadNewSprites             ; 0x12 ABED = $012BED ; ???
    dw Overworld_LoadNewSprites_justScroll  ; 0x13 AC27 = $012C27
    dw Overworld_RunScrollTransition        ; 0x14
    dw Overworld_EaseOffScrollTransition    ; 0x15
    dw Overworld_FadeBackInFromMosaic       ; 0x16 $0130D2
    dw Overworld_StartMosaicTransition      ; 0x17 #$17 - #$1C occurs entering Master Sword area.
    dw Module09_18                          ; 0x18 Load exit data and palettes for special areas?
    dw Module09_19                          ; 0x19 Loads map data for module B?
    dw Overworld_LoadTransGfx               ; 0x1A Starts loading new gfx on a module B scrolling transition ; Run when entering a special area.
    dw Overworld_FinishTransGfx             ; 0x1B Finishes loading new gfx.
    dw Module09_1C                          ; 0x1C $013150
    dw Module09_1D                          ; 0x1D $012ECE
    dw Module09_1E                          ; 0x1E $012EEA
    dw Module09_1F                          ; 0x1F $0142A4 Coming out of Lost woods.
    dw Overworld_ReloadSubscreenOverlay     ; 0x20 Coming back from Overworld Map.... reloads subscreen overlay to wram?
    dw Overworld_LoadAmbientOverlay         ; 0x21 Coming back from Overworld Map.... sends command to reupload subscreen overlay to vram?
    dw Overworld_BrightenScreen             ; 0x22 $0131BB - Brightens screen.
    dw Overworld_MirrorWarp                 ; 0x23 Magic Mirror routine (normal warp between worlds).
    dw Overworld_StartMosaicTransition      ; 0x24 Also part of magic mirror stuff?
    dw OverworldLoadSubScreenOverlay        ; 0x25 Occurs leaving Master Sword area.
    dw Overworld_LoadTransGfx               ; 0x26 $012B88 Run when leaving a special area.
    dw Overworld_FinishTransGfx             ; 0x27
    dw Overworld_LoadAndBuildScreen         ; 0x28 Alt entry for LoadAmbientOverlay.
    dw Overworld_FadeBackInFromMosaic       ; 0x29
    dw Overworld_RecoverFromDrowning        ; 0x2A Recover Link from drowning without flippers.
    dw Overworld_MasterSword                ; 0x2B Retrieving the master sword from its pedestal.
    dw Overworld_MirrorWarp                 ; 0x2C Magic Mirror routine (warping back from a failed warp).
    dw Overworld_WeathervaneExplosion       ; 0x2D Used for breaking open the weather vane (RTS!).
    dw Overworld_Whirlpool                  ; 0x2E 0x2E and 0x2F are used for the whirlpool teleporters.
    dw Module09_2F                          ; 0x2F $013521 Is jumped to from the previous submodule.
}

; $01246D-$012474 DATA TABLE
OWOverlay:
{
    ; $01246D
    .HShift:
    db  1,  0,  1,  0

    ; $012471
    .VShift:
    db  0, 17,  0, 17
}

; ZS overwrites the latter half of this function. - ZS Custom Overworld
; Module 0x09, 0x0B - Overworld Module (0x09) and Overworld Module for special
; overworlds (0x0B).
; $012475-$01252C LONG JUMP LOCATION
Module_Overworld:
{
    REP #$30

    ; Submodule index
    LDA.b $11 : ASL A : TAX

    JSR (Module_OverworldTable, X)

    REP #$21

    LDA.b $E2 : PHA : ADC.w $011A : STA.b $E2 : STA.w $011E
    LDA.b $E8 : PHA : CLC : ADC.w $011C : STA.b $E8 : STA.w $0122
    LDA.b $E0 : PHA : CLC : ADC.w $011A : STA.b $E0 : STA.w $0120
    LDA.b $E6 : PHA : CLC : ADC.w $011C : STA.b $E6 : STA.w $0124

    SEP #$20

    JSL Sprite_Main

    REP #$20

    PLA : STA.b $E6
    PLA : STA.b $E0
    PLA : STA.b $E8
    PLA : STA.b $E2

    SEP #$20

    JSL PlayerOam_Main
    JSL HUD_RefillLogicLong

    ; $0124CD ALTERNATE ENTRY POINT - ZS Custom Overworld
    ; ZS only overwrites the rest of this function.
    .rainAnimation
    LDA.b $8A : CMP.b #$70 : BEQ .evilSwamp
        ; Check the progress indicator.
        LDA.l $7EF3C5 : CMP.b #$02 : BCS .skipMovement
            .evilSwamp

            ; If misery mire has been opened already, we're done.
            LDA.l $7EF2F0 : AND.b #$20 : BNE .skipMovement
                ; Check the frame counter.
                ; On the third frame do a flash of lightning.
                LDA.b $1A

                ; On the 0x03rd frame, cue the lightning.
                CMP.b #$03 : BEQ .lightning
                    ; On the 0x05th frame, normal light level.
                    CMP.b #$05 : BEQ .normalLight
                        ; On the 0x24th frame, cue the thunder.
                        CMP.b #$24 : BEQ .thunder
                            ; On the 0x2Cth frame, normal light level.
                            CMP.b #$2C : BEQ .normalLight
                                ; On the 0x58th frame, cue the lightning.
                                CMP.b #$58 : BEQ .lightning
                                    ; On the 0x5Ath frame, normal light level.
                                    CMP.b #$5A : BNE .moveOverlay

                .normalLight

                ; Keep the screen semi-dark.
                LDA.b #$72

                BRA .setBrightness

                .thunder

                ; Play the thunder sound when outdoors.
                LDX.b #$36 : STX.w $012E

                .lightning

                LDA.b #$32 ; Make the screen flash with lightning.

                .setBrightness

                STA.b $9A

                .moveOverlay

                ; Overlay is only moved every 4th frame.
                LDA.b $1A : AND.b #$03 : BNE .skipMovement
                    LDA.w $0494 : INC A : AND.b #$03 : STA.w $0494 : TAX

                    LDA.b $E1 : CLC : ADC.l $02A46D, X : STA.b $E1
                    LDA.b $E7 : CLC : ADC.l $02A471, X : STA.b $E7

    .skipMovement

    RTL
}

; ==============================================================================

; $01252D-$01253B DATA
UNREACHABLE_02A52D:
{
    db $08, $09, $02, $04, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02
}

; ==============================================================================

; Main overworld submodule - Module 0x09.0x00, Module 0x0B.0x00.
; $01253C-$0125EB LONG JUMP LOCATION
Overworld_PlayerControl:
{
    LDA.w $0121 : ORA.w $02E4 ; Stop everything flag.
                  ORA.w $0FFC ; Link's can't bring up menu flag.
                  ORA.w $04C6 ; Special animation trigger.
                  BEQ .checkButtonInput

    JMP .skipButtonInput

    .checkButtonInput

    ; Check the start button.
    LDA.b $F4 : AND.b #$10 : BEQ .startButtonNotDown
        STZ.w $0200

        LDA.b #$01

        ; Go to menu submodule of module 0x0E.
        BRA .changeSubmodule

    .startButtonNotDown

    ; AXLR----
    LDA.b $F6 : AND.b #$40 : BEQ .xButtonNotDown
        STZ.w $0200

        ; Go to map submodule of module 0x0E.
        LDA.b #$07

        .changeSubmodule

        STA.b $11

        LDA.b $10 : STA.w $010C

        LDA.b #$0E : STA.b $10

        RTS

    .xButtonNotDown

    ; Check unfiltered output for "select" button.
    LDA.b $F0 : AND.b #$20 : BEQ .selectButtonNotDown
        LDA.w $1CE8 : STA.w $1CF4

        REP #$20

        LDA.w #$0186 : STA.w $1CF0

        SEP #$20

        LDA.b $10 : PHA

        JSL Main_ShowTextMessage

        ; Indicates that above Subroutine may have altered play mode.
        PLA : STA.b $10

        STZ.b $B0

        LDA.b #$0B

        BRA .changeSubmodule

    .selectButtonNotDown

    ; $012597 ALTERNATE ENTRY POINT
    .skipButtonInput

    ; Is there a special animation to do?
    LDA.w $04C6 : BEQ .noEntranceAnimation
        JSL Overworld_EntranceSequence

    .noEntranceAnimation

    SEP #$30

    JSL Player_Main

    LDA.w $04B4 : CMP.b #$FF : BEQ .noSuperBombIndicator
        ; Handles Super bomb countdown indicator on HUD.
        JSL HUD_SuperBombIndicator

    .noSuperBombIndicator

    REP #$20

    LDA.b $20 : AND.w #$1E00 : ASL #3            : STA.w $0700
    LDA.b $22 : AND.w #$1E00 : ORA.w $0700 : XBA : STA.w $0700

    SEP #$20

    JSL Graphics_LoadChrHalfSlot
    JSR.w Overworld_OperateCameraScroll

    ; If special outdoors mode skip this part.
    LDA.b $10 : CMP.b #$0B : BEQ .specialOverworld
        JSL Overworld_Entrance
        JSL Overworld_DwDeathMountainPaletteAnimation
        JSR.w OverworldHandleTransitions

        BRA .return

    .specialOverworld

    JSR.w ScrollAndCheckForSOWExit

    .return

    SEP #$20

    RTL
}

; ==============================================================================

; Has something to do with how the lightworld moving from one area to another
; works.
; $0125EC-$01262B DATA
Overworld_ActualScreenID:
{
    ; $0125EC
    db $00, $00, $02, $03, $03, $05, $05, $07
    db $00, $00, $0A, $03, $03, $05, $05, $0F
    db $10, $11, $12, $13, $14, $15, $16, $17
    db $18, $18, $1A, $1B, $1B, $1D, $1E, $1E
    db $18, $18, $22, $1B, $1B, $25, $1E, $1E
    db $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
    db $30, $30, $32, $33, $34, $35, $35, $37
    db $30, $30, $3A, $3B, $3C, $35, $35, $3F
}

; $01262C-$012833 DATA
OverworldScreenTileMapChange:
{
    ; $01262C
    dw $0F80, $0F80, $003F, $003F

    ; $012634 transitioning right
    .ByScreen1
    dw $0060, $0060, $0060, $0060, $0060, $0060, $0060, $0060
    dw $0060, $0060, $0060, $1060, $1060, $1060, $1060, $0060
    dw $0060, $0060, $0060, $0060, $0060, $0060, $0060, $0060
    dw $0060, $0060, $0060, $0060, $0060, $0060, $0060, $0060
    dw $0060, $0060, $0060, $1060, $1060, $0060, $1060, $1060
    dw $0060, $0060, $0060, $0060, $0060, $0060, $0060, $0060
    dw $0060, $0060, $0060, $0060, $0060, $0060, $0060, $0060
    dw $0060, $0060, $0060, $0060, $0060, $1060, $1060, $0060

    ; $0126B4 transitioning left
    .ByScreen2
    dw $0080, $0080, $0040, $0080, $0080, $0080, $0080, $0040
    dw $1080, $1080, $0040, $1080, $1080, $1080, $1080, $0040
    dw $0040, $0040, $0040, $0040, $0040, $0040, $0040, $0040
    dw $0080, $0080, $0040, $0080, $0080, $0040, $0080, $0080
    dw $1080, $1080, $0040, $1080, $1080, $0040, $1080, $1080
    dw $0040, $0040, $0040, $0040, $0040, $0040, $0040, $0040
    dw $0080, $0080, $0040, $0040, $0040, $0080, $0080, $0040
    dw $1080, $1080, $0040, $0040, $0040, $1080, $1080, $0040

    ; $012734 transitioning down
    .ByScreen3
    dw $1800, $1840, $1800, $1800, $1840, $1800, $1840, $1800
    dw $1800, $1840, $1800, $1800, $1840, $1800, $1840, $1800
    dw $1800, $1800, $1800, $1800, $1800, $1800, $1800, $1800
    dw $1800, $1840, $1800, $1800, $1840, $1800, $1800, $1840
    dw $1800, $1840, $1800, $1800, $1840, $1800, $1800, $1840
    dw $1800, $1800, $1800, $1800, $1800, $1800, $1800, $1800
    dw $1800, $1840, $1800, $1800, $1800, $1800, $1840, $1800
    dw $1800, $1840, $1800, $1800, $1800, $1800, $1840, $1800

    ; $0127B4 transitioning up
    .ByScreen4
    dw $2000, $2040, $1000, $2000, $2040, $2000, $2040, $1000
    dw $2000, $2040, $1000, $2000, $2040, $2000, $2040, $1000
    dw $1000, $1000, $1000, $1000, $1000, $1000, $1000, $1000
    dw $2000, $2040, $1000, $2000, $2040, $1000, $2000, $2040
    dw $2000, $2040, $1000, $2000, $2040, $1000, $2000, $2040
    dw $1000, $1000, $1000, $1000, $1000, $1000, $1000, $1000
    dw $2000, $2040, $1000, $1000, $1000, $2000, $2040, $1000
    dw $2000, $2040, $1000, $1000, $1000, $2000, $2040, $1000
}

; $012834-$01283B DATA
OverworldScreenIDChange:
{
    dw $0002, $FFFE, $0010, $FFF0
}

; $01283C-$012843 DATA
OverworldMixedCoordsChange:
{
    dw $FFF0, $0010, $FFFE, $0002
}

; $012844-$012883 DATA
OverworldScreenSizeFlag:
{
    .overworldMapSize
    db $20, $20, $00, $20, $20, $20, $20, $00
    db $20, $20, $00, $20, $20, $20, $20, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $20, $20, $00, $20, $20, $00, $20, $20
    db $20, $20, $00, $20, $20, $00, $20, $20
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $20, $20, $00, $00, $00, $20, $20, $00
    db $20, $20, $00, $00, $00, $20, $20, $00
}

; $012884-0128C3 DATA
OverworldScreenSizeHighByte:
{
    db $03, $03, $01, $03, $03, $03, $03, $01
    db $03, $03, $01, $03, $03, $03, $03, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $03, $03, $01, $03, $03, $01, $03, $03
    db $03, $03, $01, $03, $03, $01, $03, $03
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $03, $03, $01, $01, $01, $03, $03, $01
    db $03, $03, $01, $01, $01, $03, $03, $01
}

; $0128C4-$012943 DATA
OverworldTransitionPositionY:
{
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0200, $0000, $0000, $0000, $0000, $0200
    dw $0400, $0400, $0400, $0400, $0400, $0400, $0400, $0400
    dw $0600, $0600, $0600, $0600, $0600, $0600, $0600, $0600
    dw $0600, $0600, $0800, $0600, $0600, $0800, $0600, $0600
    dw $0A00, $0A00, $0A00, $0A00, $0A00, $0A00, $0A00, $0A00
    dw $0C00, $0C00, $0C00, $0C00, $0C00, $0C00, $0C00, $0C00
    dw $0C00, $0C00, $0E00, $0E00, $0E00, $0C00, $0C00, $0E00
}

; $012944-$0129C3
OverworldTransitionPositionX:
{
    dw $0000, $0000, $0400, $0600, $0600, $0A00, $0A00, $0E00
    dw $0000, $0000, $0400, $0600, $0600, $0A00, $0A00, $0E00
    dw $0000, $0200, $0400, $0600, $0800, $0A00, $0C00, $0E00
    dw $0000, 00000, $0400, $0600, $0600, $0A00, $0C00, $0C00
    dw $0000, $0000, $0400, $0600, $0600, $0A00, $0C00, $0C00
    dw $0000, $0200, $0400, $0600, $0800, $0A00, $0C00, $0E00
    dw $0000, $0000, $0400, $0600, $0800, $0A00, $0A00, $0E00
    dw $0000, $0000, $0400, $0600, $0800, $0A00, $0A00, $0E00
}

; ==============================================================================

; ZS modifies part of this function. - ZS Custom Overworld
; $0129C4-$012B07 LOCAL JUMP LOCATION
OverworldHandleTransitions:
{
    ; Tells us which direction we're scrolling in.
    LDA.w $0416 : BEQ .noScroll
        JSR.w Overworld_ScrollMap

    .noScroll

    REP #$20

    LDA.b $30 : AND.w #$00FF : BEQ .noDeltaY
        ; Check if link is moving up/down.
        LDA.b $67 : AND.w #$000C : STA.b $00

        LDX.w $0700 : LDA.b $20 : SEC : SBC OverworldTransitionPositionY, X

        LDY.b #$06 : LDX.b #$08

        CMP.w #$0004 : BCC .BRANCH_GAMMA
            LDY.b #$04 : LDX.b #$04

            CMP.w $0716 : BCS .BRANCH_GAMMA

    .noDeltaY

    LDA.b $31 : AND.w #$00FF : BEQ .noDeltaX
        LDA.w $0716 : CLC : ADC.w #$0004 : STA.b $02

        LDA.b $67 : AND.w #$0003 : STA.b $00

        LDX.w $0700 : LDA.b $22 : SEC : SBC OverworldTransitionPositionX, X

        LDY.b #$02 : LDX.b #$02 : CMP.w #$0006 : BCC .BRANCH_GAMMA

            LDY.b #$00 : LDX.b #$01 : CMP.b $02 : BCC .BRANCH_DELTA

    .BRANCH_GAMMA

    CPX.b $00 : BEQ .BRANCH_EPSILON
        .BRANCH_DELTA
        .noDeltaX

        JSL Overworld_CheckForSpecialOverworldTrigger

        RTS

    ; Triggers when Link finally reaches the edge of the screen.
    ; $012A33
    .BRANCH_EPSILON

    SEP #$20

    ; Just makes sure we're not using a medallion or input is disabled.
    JSL Player_IsScreenTransitionPermitted : BCS .BRANCH_DELTA
        STY.b $02 : STZ.b $03

        JSR.w DeleteCertainAncillaeStopDashing

        REP #$31

        ; Remove potential large world offest.
        LDX.b $02 : LDA.b $84 : AND.l OverworldScreenTileMapChange, X : STA.b $84

        LDA.w $0700
        CLC : ADC.w OverworldScreenIDChange, X : PHA
        STA.b $04

        TXA : ASL #6 : ORA.b $04 : TAX

        LDA.b $84
        CLC : ADC.w OverworldScreenTileMapChange_ByScreen1, X
        STA.b $84

        PLA : LSR A : TAX

        SEP #$30

        LDA.b $8A : PHA : CMP.b #$2A : BNE .notFluteBoyGrove
            ; Flute boy area has special flute sound effect (surprise?).
            LDA.b #$80 : STA.w $012D

        .notFluteBoyGrove

        ; The "custom lost woods" asm hooks in right here.
        ; $012A7D Sets the OW area number
        LDA.l $02A5EC, X : ORA.l $7EF3CA : STA.b $8A : STA.w $040A : TAX

        LDA.l $7EF3CA : BEQ .lightWorld
            ; Check for moon pearl.
            LDA.l $7EF357 : BEQ .BRANCH_IOTA

        .lightWorld

        ; Extract the ambient sound from this array.
        LDA.l $7F5B00, X : LSR #4 : BNE .ambientSound
            LDA.b #$05 : STA.w $012D ; No ambient sound.

        .ambientSound

        LDA.l $7F5B00, X : AND.b #$0F : CMP.w $0130 : BEQ .noMusicChange
            LDA.b #$F1 : STA.w $012C

        .noMusicChange ; BANCH_IOTA

        JSR.w Overworld_LoadMapProperties

        LDA.b #$01 : STA.b $11

        LDA.b $00 : STA.w $0410 : STA.w $0416

        LDX.b #$04

        .BRANCH_LAMBDA
            ; Doing a weird math loop here.
        DEX : LSR A : BCC .BRANCH_LAMBDA

        STX.w $0418 : STX.w $069C : STZ.w $0696 : STZ.w $0698 : STZ.w $0126

        PLA

        ; ZS writes a jump here. - ZS Custom Overworld
        ; $012ADB
        AND.b #$3F : BEQ .BRANCH_MU ; Area it was
            LDA.b $8A : AND.b #$BF : BNE .BRANCH_NU ; Area it is.

        .BRANCH_MU

        ; Probably only for areas 0x00 and 0x40.

        STZ.b $B0

        ; Send us to a submodule that will handle going into a forest.
        LDA.b #$0D : STA.b $11

        ; Reset mosaic settings.
        LDA.b #$00 : STA.b $95 : STA.l $7EC011

        RTS

        .BRANCH_NU

        LDX.b $8A : LDA.l $7EFD40, X : STA.b $00

        LDA.l $00FD1C, X

        JSL Overworld_LoadPalettes
        JSR.w Overworld_CgramAuxToMain

        RTS
}

; ==============================================================================

; $012B08-$012B7A LOCAL JUMP LOCATION
Overworld_LoadMapProperties:
{
    LDX.b $8A

    ; Reset the incremental counter for updating VRAM from frame to frame.
    STZ.w $0412

    ; This array was loaded up based on the world state variable ($7EF3C5).
    ; It contains 0x40 entries (disputed).
    ; $0AA3 is the sprite graphics index.
    LDA.l $7EFCC0, X : STA.w $0AA3

    ; $0AA2 is the secondary background graphics index.
    LDA.l $00FC9C, X : STA.w $0AA2

    ; Overworld screen widths and heights match for DW and LW.
    TXA : AND.b #$3F : TAX

    ; Cache previous dimension setting in $0714.
    LDA.w $0712 : STA.w $0714

    ; Sets width and height of the OW area (512x512 or 1024x1024).
    LDA.w OverworldScreenSizeFlag, X     : STA.w $0712
    LDA.w OverworldScreenSizeHighByte, X : STA.w $0717

    LDY.b #$20 : LDX.b #$00

    LDA.b $8A : AND.b #$40 : BEQ .lightWorld
        ; $0AA1 = 0x21 for dark world, 0x20 for light world.
        INY

        ; $0AA4 = 0x08 for dark world, 0x00 for light world.
        LDX.b #$08

    .lightWorld

    STY.w $0AA1

    ; $0AA4 = 0x01 in LW, 0x0B in DW.
    LDA.l $00D8F4, X : STA.w $0AA4

    REP #$30

    ; This is misleading as the subsequent arrays are only 0x80 bytes.
    LDA.b $8A : AND.w #$00BF : ASL A : TAX

    LDA.w OverworldTransitionPositionY, X : STA.w $0708

    LDA.w OverworldTransitionPositionX, X : LSR #3 : STA.w $070C

    LDA.w #$03F0 : LDX.w $0712 : BNE .largeOwMap
        LDA.w #$01F0 ; The 512x512 maps have smaller limits of course.

    .largeOwMap

    STA.w $070A : LSR #3 : STA.w $070E

    SEP #$30

    RTS
}

; ==============================================================================

; $012B7B-$012B87 LOCAL JUMP LOCATION
ScrollAndCheckForSOWExit:
{
    LDA.w $0416 : BEQ .alpha
        JSR.w Overworld_ScrollMap

    .alpha

    ; Checks for tiles that lead back to normal overworld.
    JSL SpecialOverworld_CheckForReturnTrigger

    RTS
}

; ==============================================================================

; Module 0x09.0x01, 0x09.0x0F, 0x09.0x1A, 0x09.0x26
; Also referenced one other place.
; $012B88-$012BC5 LOCAL JUMP LOCATION
Overworld_LoadTransGfx:
{
    ; Reset the water outside the watergate.
    LDA.l $7EF2BB : AND.b #$DF : STA.l $7EF2BB

    ; Reset the water outside the swamp palace.
    LDA.l $7EF2FB : AND.b #$DF : STA.l $7EF2FB

    ; Reset the water inside the watergate.
    LDA.l $7EF216 : AND.b #$7F : STA.l $7EF216

    ; Reset the water inside the swamp palace.
    LDA.l $7EF051 : AND.b #$FE : STA.l $7EF051

    ; Load the graphics that have changed during the screen transition.
    JSL LoadTransAuxGFX

    ; Convert those graphics to 4bpp while copying them into the buffer
    ; starting at $7F0000. It's necessary to do it this way because we can't
    ; blank the screen (no screen fade / darkness).
    JSL PrepTransAuxGFX

    ; Trigger NMI module: NMI_UpdateBgChrSlots_3_to_4.
    LDA.b #$09

    BRA Overworld_FinishTransGfx_firstHalf
}

; ==============================================================================

; ZS overwrites most of this function. - ZS Custom Overworld
; Module 0x09.0x02, 0x09.0x10, 0x09.0x1B, 0x09.0x27
; Also referenced one other place.
; $012BBC-$012BC5 JUMP LOCATION
Overworld_FinishTransGfx:
{
    ; The purpose of this submodule is to finish blitting the rest of the
    ; graphics that were decompressed in the previous module to vram (from the
    ; $7F0000 buffer).

    ; Trigger NMI module: NMI_UpdateBgChrSlots_5_to_6.
    LDA.b #$0A

    ; ZS starts writing here. - ZS Custom Overworld
    ; $012BBE ALTERNATE ENTRY POINT
    .firstHalf

    ; Signal for a graphics transfer in the NMI routine later.
    STA.b $17 : STA.w $0710

    ; Move on to next submodule.
    INC.b $11

    RTS
}

; ==============================================================================

; Module 0x09.0x03, 0x09.0x11
; $012BC6-$012BD9 LOCAL JUMP LOCATION
Overworld_TransMapData:
Overworld_LoadNewMapAndGfx:
{
    ; Unknown variables
    STZ.w $04C8 : STZ.w $04C9

    JSR.w Overworld_LoadTransMapData

    INC.w $0710

    ; This mess all looks like it does map16 to map8 conversion, and the
    ; subsequent one sets up the system to blit it to vram during the next
    ; vblank.
    JSR.w Overworld_StartTransMapUpdate

    JSL LoadNewSpriteGFXSet

    RTL
}

; $012BDA-$012BEC LOCAL JUMP LOCATION
Overworld_RunScrollTransition:
{
    JSL Link_HandleMovingAnimation_FullLongEntry
    JSL Graphics_IncrementalVramUpload
    JSR.w OverworldScrollTransition

    AND.b #$0F : BEQ .alpha
        RTS

    .alpha

    JMP OverworldTranScrollSet
}

; ==============================================================================

; Module 0x09.0x04, 0x09.0x12
; $012BED-$012C2F LOCAL JUMP LOCATION
Overworld_LoadNewSprites:
{
    LDA.w $0418 : CMP.b #$01 : BNE .notDownTransition
        REP #$20

        ; Move down 2 pixels if transitioning down.
        ; Why this is a special case... I don't quite get.
        LDA.b $E8 : CLC : ADC.w #$0002 : STA.b $E8
        LDA.b $20 : CLC : ADC.w #$0002 : STA.b $20

        SEP #$20

    .notDownTransition

    JSL Sprite_OverworldReloadAll_justLoad

    ; Reset tile modification index (keeps track of modified tiles when warping
    ; between worlds).
    STZ.w $04AC : STZ.w $04AD

    LDA.l $7EF3C5 : CMP.b #$02 : BCS .rescuedZeldaOnce
        .specialTransition

        JMP .skipBgColor

    .rescuedZeldaOnce

    ; OPTIMIZE: What a jank branch.
    LDA.b $11 : CMP.b #$12 : BEQ .specialTransition
        ; Load bg color and other stuff.
        JSL Overworld_SetFixedColorAndScroll

    .skipBgColor

    ; $012C27 ALTERNATE ENTRY POINT
    .justScroll

    INC.b $11

    ; Horizontal transitions apparently don't do this step...
    LDX.w $0410 : CPX.b #$04 : BCC OverworldTranScrollSet_notVerticalTransition
        ; Bleeds into the next function
}

; $012C30-$012C39 LOCAL JUMP LOCATION
OverworldTranScrollSet:
{
    STX.w $0416

    JSR.w OverworldTransitionScrollAndLoadMap

    STZ.w $0416

    .notVerticalTransition

    RTS
}

; ==============================================================================

; $012C3A-$012C8E LOCAL JUMP LOCATION
Overworld_EaseOffScrollTransition:
{
    LDX.b $8A

    LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : BEQ .largeArea
        LDX.w $0410 : STX.w $0416

        JSR.w OverworldTransitionScrollAndLoadMap

        STZ.w $0416

    .largeArea

    ; $B0 is used as an index counter.
    INC.b $B0 : LDA.b $B0 : CMP.b #$08 : BCC .return
        LDX.w $0410 : CPX.b #$08 : BEQ .scrollUpOrLeft
            CPX.b #$02 : BNE .scrollDownOrRight

        .scrollUpOrLeft

        CPX.b #$09 : BCC .return
            .scrollDownOrRight

            STZ.b $B0
            STZ.w $0410

            LDX.b $8A

            LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : BEQ .largeArea2
                REP #$20

                LDA.l $7EC172 : STA.b $84
                LDA.l $7EC174 : STA.b $86
                LDA.l $7EC176 : STA.b $88

                SEP #$20

            .largeArea2

            INC.b $11

            JSL Tagalong_Disable

    .return

    RTS
}

; $012C8F-$012CC1 LOCAL JUMP LOCATION
Overworld_WalkFromExiting_FaceDown:
{
    JSL Link_HandleMovingAnimation_SetFacingDown

    REP #$20

    LDA.b $20 : CLC : ADC.w #$0001 : STA.b $20

    SEP #$20

    DEC.w $069A : BNE .timedWait
        STZ.b $11

        REP #$20

        ; Move Link down by 3 pixels.
        LDA.b $20 : CLC : ADC.w #$0003 : STA.b $20

        SEP #$20

        LDA.b #$03 : STA.b $30

        JSR.w Overworld_OperateCameraScroll
        LDA.w $0416 : BEQ .noScroll
            JSR.w Overworld_ScrollMap
        .noScroll

    .timedWait

    RTS
}

; $012CC2-$012CD9 LOCAL JUMP LOCATION
Overworld_WalkFromExiting_FaceUp:
{
    JSL Link_HandleMovingAnimation_FullLongEntry

    REP #$20

    LDA.b $20 : SEC : SBC.w #$0001 : STA.b $20

    SEP #$20

    DEC.w $069A : BNE .BRANCH_ALPHA
        STZ.b $11

    .BRANCH_ALPHA

    RTS
}

; $012CDA-$012D49 DATA
Map32UpdateTiles:
{
    ; Sanc doors half open.
    ; $012CDA
    .0
    dw $0DA2

    ; $012CDC
    .1
    dw $0DA3

    ; $012CDE
    .2
    dw $0DA4

    ; $012CE0
    .3 
    dw $0DA5 

    dw $0DA6, $0DA7, $0DA8, $0DA9 ; Sanc doors 2/3 open.
    dw $0DAA, $0DAB, $0DAC, $0DAD ; Sanc doors fully open.
    dw $0DB0, $0DB1, $0DB2, $0DB3 ; Castle doors 2/3 open.
    dw $0DB4, $0DB5, $0DB6, $0DB7 ; Castle doors fully open.
    dw $0DC7, $0DC8, $0DC9, $0DCA ; Big rock imprint.
    dw $0DCD, $0DCE, $0DCF, $0DD0 ; Open grave with corpse bottom half.
    dw $0DD1, $0DD2, $0DD3, $0DD4 ; Open grave with stairs bottom half.
    dw $0DCB, $0DCC, $0DCD, $0DCE ; Open grave with corpse top half.
    dw $0DCB, $0DCC, $0DD1, $0DD2 ; Open grave with stairs top half.
    dw $0912, $0913, $0914, $0915 ; Stairs to cave.
    dw $0DD5, $0DD6, $0DD7, $0DD8 ; Open grave with pit bottom half.
    dw $0DCB, $0DCC, $0DD5, $0DD6 ; Open grave with pit top half.
    dw $0E1B, $0E1C, $0E1D, $0E1E ; Broken weather vane.
}

; $012D4A-$012D5B LOCAL JUMP LOCATION
Module09_09_OpenBigDoorFromExiting:
{
    LDA.w $0690 : CMP.b #$03 : BNE Overworld_OpenBigFancyDoor_BRANCH_ALPHA
        LDA.b #$24 : STA.w $069A

        STZ.w $0416

        INC.b $11

        RTS
}

; ==============================================================================

; $012D5C-$012D62 LONG JUMP LOCATION
Overworld_DoMapUpdate32x32_Long:
{
    JSR.w Overworld_DoMapUpdate32x32

    STZ.w $0692

    RTL
}

; ==============================================================================

; $012D63-$012D6B LONG JUMP LOCATION (UNUSED?)
UNREACHABLE_02AD63:
{
    REP #$30

    JSR.w Overworld_DoMapUpdate32x32_16bit_already

    STZ.w $0692

    RTL
}

; $012D6C-$012D7A LOCAL JUMP LOCATION
Overworld_OpenBigFancyDoor:
{
    LDA.w $0690 : CMP.b #$03 : BNE .BRANCH_ALPHA
        STZ.b $B0 : STZ.b $11 : STZ.w $0416

        RTS

    .BRANCH_ALPHA

    ; Bleeds into the next function.
}

; $012D7B-$012D84 LOCAL JUMP LOCATION
Overworld_DoMapUpdate32x32_conditional:
{
    LDA.w $0692 : AND.b #$07 : BEQ .BRANCH_BETA
        JMP NoMap32Update

    .BRANCH_BETA

    ; Bleeds into the next function.
}

; $012D85-$012D86 LOCAL JUMP LOCATION
Overworld_DoMapUpdate32x32:
{
    REP #$30

    ; Bleeds into the next function.
}

; This appears to happen if you pick up a large rock (Or other map16
; modifications like a place sanctuary door opening)
; $012D87-$012E59 LOCAL JUMP LOCATION
Overworld_DoMapUpdate32x32_16bit_already:
{
    PHB : PHK : PLB

    ; This is the starting address for the 2x2 (map16) replacement.
    ; Store the address of the map16 modification.
    LDA.w $0698 : LDX.w $04AC : STA.l $7EF800, X : TAX

    ; Load a map16 tile type based on this input and store it to the tile map.
    ; A here is the tile16, X is the location on the tilemap.
    LDY.w $0692 : LDA.w Map32UpdateTiles_0, Y : STA.l $7E2000, X

    ; Store the actual map16 value to our array for failed warps.
    LDX.w $04AC : STA.l $7EFA00, X

    LDY.w #$0000 : LDX.w $0698

    JSL Overworld_DrawMap16_Anywhere

    LDA.w $0698 : LDX.w $04AC : INC #2 : STA.l $7EF802, X

    ; Load the next tile type. Store it to the next location in the tilemap.
    LDX.w $0698 : LDY.w $0692 : LDA.w Map32UpdateTiles_1, Y : STA.l $7E2002, X

    LDX.w $04AC : STA.l $7EFA02, X

    LDY.w #$0002 : LDX.w $0698

    JSL Overworld_DrawMap16_Anywhere

    LDA.w $0698 : LDX.w $04AC : CLC : ADC.w #$0080 : STA.l $7EF804, X

    ; Load the third tile (block?) type, and then store in a place to be
    ; blitted to VRAM.
    LDX.w $0698 : LDY.w $0692 : LDA.w Map32UpdateTiles_2, Y : STA.l $7E2080, X

    LDX.w $04AC : STA.l $7EFA04, X

    LDY.w #$0080 : LDX.w $0698

    JSL Overworld_DrawMap16_Anywhere

    LDA.w $0698 : LDX.w $04AC : CLC : ADC.w ADC #$0082 : STA.l $7EF806, X

    LDX.w $0698 : LDY.w $0692 : LDA.w Map32UpdateTiles_3, Y : STA.l $7E2082, X

    LDX.w $04AC : STA.l $7EFA06, X

    LDY.w #$0082 : LDX.w $0698

    JSL Overworld_DrawMap16_Anywhere

    ; Put the finishing touches on the VRAM package that will be sent.
    LDY.w $1000 : LDA.w #$FFFF : STA.w $1002, X

    ; Increment the modification index by 8 (indicates we replaced 4 tiles).
    LDA.w $04AC : CLC : ADC.w #$0008 : STA.w $04AC

    INC.w $0690

    LDA.w $0692 : CMP.w #$0020 : BNE .BRANCH_ALPHA
        INC.w $0690

    .BRANCH_ALPHA

    PLB

    SEP #$30

    LDA.b #$01 : STA.b $14

    ; Bleeds into the next function.
}

; $012E5A-$012E5D LOCAL JUMP LOCATION
NoMap32Update:
{
    INC.w $0692

    RTS
}

; ==============================================================================

; Modules 0x09.0x0D, 0x09.0x17, 0x09.0x24
; $012E5E-$012E6C LOCAL JUMP LOCATION
Overworld_StartMosaicTransition:
{
    ; Set Mosaic level.
    JSR.w Overworld_ResetMosaic

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw OverworldMosaicTransition_HandleSong                 ; 0x00 - $AE6D
    dw ApplyPaletteFilter_bounce                            ; 0x01 - $A2A0
    dw OverworldMosaicTransition_HandleScreensAndLoadShroom ; 0x02 - $AE86
}

; Module 0x0B.0x24/0x17/0x0D.0x00
; $012E6D-$012E85 LOCAL JUMP LOCATION
OverworldMosaicTransition_HandleSong:
{
    ; Check if it's the master sword area / area under bridge.
    LDX.b $8A : CPX.b #$80 : BEQ .noFadeout
        ; Check if the currently playing music is the same as the target area.
        LDA.l $7F5B00, X : AND.b #$0F : CMP.w $0130 : BEQ .noFadeout
            ; Fade the music out if they differ.
            LDA.b #$F1 : STA.w $012C

    .noFadeout

    ; Do more basic common initialization of OW variables.
    JMP ResetTransitionPropsAndAdvance_ResetInterface
}

; ==============================================================================

; $012E86-$012ECD LOCAL JUMP LOCATION
OverworldMosaicTransition_HandleScreensAndLoadShroom:
{
    ; Forceblank the screen.
    LDA.b #$80 : STA.b $13

    STZ.b $B0

    ; Forest areas are 0x00 and 0x40.
    ; $012E8C - ZS Custom Overworld? - Loads some sort of animated tile, needs
    ; more investigation.
    LDA.b $8A : AND.b #$3F : BNE .notForestArea 
        LDA.b #$1E

        ; Load animated graphics into WRAM.
        JSL GetAnimatedSpriteTile.variable

    .notForestArea

    LDA.w $040A : BEQ .lostWoods
        ; Check for special overworld areas.
        LDA.b $10 : CMP.b #$0B : BEQ .lostWoods
            ; OBJ, BG2, and BG3 on main screen, BG1 on subscreen.
            LDY.b #$16 : LDA.b #$01
            STY.b $1C    : STA.b $1D

            ; Set CGWSEL to clip colors to black "inside color window only"
            ; and enabled subscreen addition (not fixed color).
            LDA.b #$82 : STA.b $99

            ; Add the subscreen only to the background, though.
            LDA.b #$20 : STA.b $9A

            ; Move to next submodule.
            INC.b $11

            RTS

    .lostWoods

    LDA.b $11 : CMP.b #$24 : BNE .BRANCH_GAMMA
        JSR.w LoadOverworldFromSpecialOverworld

        ; $012EBF - ZS Custom Overworld? - loads some sort of animated tile,
        ; needs more investigation.
        LDA.b $8A : AND.b #$3F : BNE .BRANCH_GAMMA 
            LDA.b #$1E

            ; Load a certain sprite into the animated tiles buffer.
            JSL GetAnimatedSpriteTile.variable

    .BRANCH_GAMMA

    INC.b $11

    RTS
}

; $012ECE-$012EDC LOCAL JUMP LOCATION
Module09_1D:
{
    JSR.w Overworld_ResetMosaic

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw ResetTransitionPropsAndAdvance_ResetInterface ; 0x00 - $8CA9
    dw ApplyPaletteFilter_bounce                     ; 0x01 - $A2A0
    dw Module09_1D_02_FBlankAndEnterModule0A         ; 0x02 - $AEDD
}

; $012EDD-$012EE9 LOCAL JUMP LOCATION
Module09_1D_02_FBlankAndEnterModule0A:
{
    LDA.b #$80 : STA.b $13 : STZ.b $B0

    LDA.b #$0A : STA.b $10 : STZ.b $11

    RTS
}

; $012EEA-$012EF8 LOCAL JUMP LOCATION
Module09_1E:
{
    JSR.w Overworld_ResetMosaic

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw ResetTransitionPropsAndAdvance_ResetInterface ; 0x00 - $8CA9
    dw ApplyPaletteFilter_bounce                     ; 0x01 - $A2A0
    dw Module09_1E_02_FBlankAndLoadSPOW              ; 0x02 - $AEF9
}

; $012EF9-$012F0A LOCAL JUMP LOCATION
Module09_1E_02_FBlankAndLoadSPOW:
{
    LDA.b #$80 : STA.b $13

    JSR.w LoadOverworldFromSpecialOverworld

    LDA.b #$09 : STA.b $10
    LDA.b #$0F : STA.b $11

    STZ.b $B0

    RTS
}

; ==============================================================================

; ZS rewrites most of this function. - ZS Custom Overworld
; $012F0B-$012F18 LOCAL JUMP LOCATION
OverworldLoadSubScreenOverlay:
{
    JSL InitSpriteSlots
    JSL Sprite_OverworldReloadAll

    STZ.w $0308
    STZ.w $0309

    ; Bleeds into the next function.
}

; Module 0x08.0x01, 0x09.0x0E, 0x0A.0x01 - Loads overlays.
; $012F19-$012F1D LOCAL JUMP LOCATION
Overworld_LoadSubscreenAndSilenceSFX1:
{
    LDA.b #$05 : STA.w $012D ; Play silence. yes, literally play silence.

    ; Bleeds into the next function.
}

; $012F1E-$0130D1 LOCAL JUMP LOCATION
Overworld_ReloadSubscreenOverlay:
{
    REP #$30

    ; Feed the Overworld index to this location.
    LDA.b $8A : STA.l $7EC213
    LDA.b $84 : STA.l $7EC215
    LDA.b $88 : STA.l $7EC217
    LDA.b $86 : STA.l $7EC219

    LDA.w $0418 : STA.l $7EC21B
    LDA.w $0410 : STA.l $7EC21D
    LDA.w $0416 : STA.l $7EC21F

    STZ.b $8C
    STZ.w $0622
    STZ.w $0620

    LDY.w #$0390

    ; ZS starts writing here.
    ; $012F58 - ZS Custom Overworld
    ; Check to see if we are in a SW overworld area.
    LDA.b $8A : CMP.w #$0080 : BCC .notExtendedArea
        ; The first fog overlay.
        LDX.w #$0097

        ; Check for exit rooms (the faked way of getting from one overworld
        ; area to another). $0180 is the exit room number used for getting into
        ; the mastersword area.
        LDA.b $A0 : CMP.w #$0180 : BNE .notMasterSwordArea
            ; If the Master sword is retrieved, don't do the mist overlay.
            LDX.w #$0080

            ; Branch if the sword has in fact been pulled out.
            LDA.l $7EF280, X

            ; The first fog overlay.
            LDX.w #$0097

            AND.w #$0040 : BNE .noSubscreenOverlay
                .loadOverlayShortcut

                JMP .loadSubScreenOverlay

        .notMasterSwordArea

        ; The second mastersword/under the bridge area.
        LDX.w #$0094

        ; $0181 is the exit room number used for getting into the under the
        ; bridge area.
        CMP.w #$0181 : BEQ .loadOverlayShortcut
            ; The second Triforce room area.
            LDX.w #$0093

            ; $0189 is the exit room number used for getting to the Triforce
            ; room? TODO: Confirm this.
            CMP.w #$0189 : BEQ .loadOverlayShortcut

            ; $0182 is the exit room number used for getting to Zora's Domain.
            CMP.w #$0182 : BEQ .zoraFalls
            CMP.w #$0183 : BNE .noSubscreenOverlay
                .zoraFalls

                SEP #$30

                ; Why Nintendo, why did you place this here?
                ; Play rain (waterfall) sound.
                LDA.b #$01 : STA.w $012D

            .noSubscreenOverlay

            SEP #$30

            STZ.b $1D

            INC.b $11

            RTS

    .notExtendedArea

    AND.w #$003F : BNE .notForest
        ; Check to see if we are in the skull woods.
        LDA.b $8A : AND.w #$0040 : BNE .skullWoods
            ; Check if we have the master sword.
            LDX.w #$0080 : LDA.l $7EF280, X

            ; The forest canopy overlay.
            LDX.w #$009E

            AND.w #$0040 : BNE .loadSubScreenOverlay

        .skullWoods

        ; The second fog overlay.
        LDX.w #$009D

        BRA .loadSubScreenOverlay

    .notForest

    ; The LW death mountain sky background.
    LDX.w #$0095

    LDA.b $8A

    CMP.w #$0003 : BEQ .loadSubScreenOverlay
    CMP.w #$0005 : BEQ .loadSubScreenOverlay
    CMP.w #$0007 : BEQ .loadSubScreenOverlay
        ; The DW death mountain lava background.
        LDX.w #$009C

        CMP.w #$0043 : BEQ .loadSubScreenOverlay
        CMP.w #$0045 : BEQ .loadSubScreenOverlay
        CMP.w #$0047 : BEQ .loadSubScreenOverlay

        CMP.w #$0070 : BNE .notSwampOfEvil
            ; Has Misery Mire been triggered yet?
            LDA.l $7EF2F0 : AND.w #$0020 : BNE .loadSubScreenOverlay
                ; No it has not been triggered.
                BRA .makeItRain

        .notSwampOfEvil

        ; This ends up being the default overlay for most areas while not
        ; raining. the pyramid background.
        LDX.w #$0096

        ; Check if we are in the beginning phase, if not, no rain.
        ; If $7EF3C5 >= 0x02
        LDA.l $7EF3C5 : AND.w #$00FF : CMP.w #$0002 : BCS .loadSubScreenOverlay
            .makeItRain

            ; The rain overlay.
            LDX.w #$009F

    .loadSubScreenOverlay

    STY.b $84

    STX.b $8A : STX.b $8C

    LDA.b $84 : SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

    LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    STZ.w $0418 : STZ.w $0410 : STZ.w $0416

    SEP #$30

    ; Color +/- buffered register.
    LDA.b #$82 : STA.b $99

    ; Puts OBJ, BG2, and BG3 on the main screen.
    LDA.b #$16 : STA.b $1C

    ; Puts BG1 on the subscreen.
    LDA.b #$01 : STA.b $1D

    ; Save X for uno momento.
    PHX

    ; TODO: Verify this.
    ; Set the ambient sound effect. Why? $8A is the current overlay right now,
    ; we shouldn't load the ambient sound fromt here. Plus the sound gets loaded
    ; in another spot later on again so this shouldn't be necessary.

    ; Ok so the one use for this that i've found is it loads the rain sound
    ; effect when the overlay is set to rain. This is only really important for
    ; the mire rain and doesn't make much of a difference anywhere else as far
    ; as I can tell.
    LDX.b $8A : LDA.l $7F5B00, X : LSR #4 : STA.w $012D

    PLX

    ; One possible configuration for $2131 (CGADSUB).
    LDA.b #$72

    ; Comparing different screen types.
    CPX.b #$97 : BEQ .loadOverlay ; Fog 1
    CPX.b #$94 : BEQ .loadOverlay ; Master sword/bridge 2
    CPX.b #$93 : BEQ .loadOverlay ; Triforce room 2
    CPX.b #$9D : BEQ .loadOverlay ; Fog 2
    CPX.b #$9E : BEQ .loadOverlay ; Tree canopy
    CPX.b #$9F : BEQ .loadOverlay ; Rain
        ; Alternative setting for CGADSUB (only background is enabled on
        ; subscreen).
        LDA.b #$20

        CPX.b #$95 : BEQ .loadOverlay
        CPX.b #$9C : BEQ .loadOverlay
            LDA.l $7EC213 : TAX

            LDA.b #$20

            CPX.b #$5B : BEQ .loadOverlay
            CPX.b #$1B : BNE .disableSubscreen
                LDX.b $11

                CPX.b #$23 : BEQ .loadOverlay
                CPX.b #$2C : BEQ .loadOverlay

            .disableSubscreen

            STZ.b $1D

    .loadOverlay

    ; Apply the selected settings to CGADSUB's mirror ($9A)
    STA.b $9A

    JSR.w LoadSubscreenOverlay

    ; This is the "under the bridge" area.
    LDA.b $8C : CMP.b #$94 : BNE .notUnderBridge
        ; All this is doing is setting the X coordinate of BG1 to 0x0100
        ; Rather than 0x0000. (this area usees the second half of the data
        ; only, similar to the master sword area.
        LDA.b $E7 : ORA.b #$01 : STA.b $E7

    .notUnderBridge

    REP #$20

    ; We were pretending to be in a different area to load the subscreen
    ; overlay, so we're restoring all those settings.
    LDA.l $7EC213 : STA.b $8A
    LDA.l $7EC215 : STA.b $84
    LDA.l $7EC217 : STA.b $88
    LDA.l $7EC219 : STA.b $86

    LDA.l $7EC21B : STA.w $0418
    LDA.l $7EC21D : STA.w $0410
    LDA.l $7EC21F : STA.w $0416

    SEP #$20

    RTS
}

; ==============================================================================

; $0130D2-$0130F2 LOCAL JUMP LOCATION
Module09_FadeBackInFromMosaic:
{
    LDA.l $7EC007 : LSR A : BCC .BRANCH_ALPHA
        LDA.l $7EC011 : SEC : SBC.b #$10 : STA.l $7EC011

    .BRANCH_ALPHA

    JSR.w CopyMosaicControl

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw OverworldMosaicTransition_RecoverDestinationPalettes ; 0x00 - $B0F3
    dw OverworldMosaicTransition_FilterAndLoadGraphics      ; 0x01 - $B195
    dw OverworldMosaicTransition_RecoverSongAndSetMoving    ; 0x02 - $B105
}

; $0130F3-$013104 LOCAL JUMP LOCATION
OverworldMosaicTransition_RecoverDestinationPalettes:
{
    LDX.b $8A

    LDA.l $7EFD40, X : STA.b $00

    LDA.l $00FD1C, X

    JSL Overworld_LoadPalettes

    BRA OverworldMosaicTransition_LoadSpriteGraphicsAndSetMosaic
}

; $013105-$01314F LOCAL JUMP LOCATION
OverworldMosaicTransition_RecoverSongAndSetMoving:
{
    LDA.w $0130 : STA.w $0133

    LDA.b $8A

    CMP.b #$80 : BEQ .BRANCH_ALPHA
    CMP.b #$2A : BEQ .BRANCH_ALPHA

    LDX.b $8A

    LDA.l $7F5B00, X : LSR #4 : BNE .BRANCH_BETA
        LDA.b #$05

    .BRANCH_BETA

    STA.w $012D

    LDA.l $7F5B00, X : AND.b #$0F : CMP.w $0130 : BEQ .BRANCH_ALPHA
        STA.w $012C

    .BRANCH_ALPHA

    STZ.b $11

    LDA.b #$08 : STA.b $11

    STZ.b $B0

    LDA.b $10 : CMP.b #$0B : BNE .BRANCH_GAMMA
        ; Go from special overworld to normal overworld.
        LDA.b #$09 : STA.b $10

        LDA.b #$1F : STA.b $11

        LDA.b #$0C : STA.w $069A

    .BRANCH_GAMMA

    RTS
}

; $013150-$013170 LOCAL JUMP LOCATION
Module09_1C:
{
    ; if(!($7EC007 % 2)) goto .BRANCH_ALPHA
    LDA.l $7EC007 : LSR A : BCC .BRANCH_ALPHA
        ; $7EC011 -= 0x10
        LDA.l $7EC011 : SEC : SBC.b #$10 : STA.l $7EC011

    .BRANCH_ALPHA

    JSR.w CopyMosaicControl

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw OverworldMosaicTransition_LoadSpriteGraphicsAndSetMosaic ; 0x00 - $B171
    dw OverworldMosaicTransition_FilterAndLoadGraphics          ; 0x01 - $B195
    dw Module09_1C_02_HandleMusic                               ; 0x02 - $B19E
}

; $013171-$013194 LOCAL JUMP LOCATION
OverworldMosaicTransition_LoadSpriteGraphicsAndSetMosaic:
{
    JSL LoadNewSpriteGFXSet

    LDA.b #$0F : STA.b $13
    LDA.b #$80 : STA.b $9B

    LDA.l $7EC00B : DEC A : STA.l $7EC007

    LDA.b #$00 : STA.l $7EC00B
    LDA.b #$02 : STA.l $7EC009

    INC.b $B0

    RTS
}

; $013195-$01319D LOCAL JUMP LOCATION
OverworldMosaicTransition_FilterAndLoadGraphics:
{
    JSL Graphics_IncrementalVramUpload
    JSL PaletteFilter_doFiltering

    RTS
}

; $01319E-$0131BA LOCAL JUMP LOCATION
Module09_1C_02_HandleMusic:
{
    LDA.b $8A : CMP.b #$80 : BCS .BRANCH_ALPHA
        LDA.b #$02 : STA.w $012C

        LDA.b $8A : AND.b #$3F : BNE .BRANCH_ALPHA
            LDA.b #$05 : STA.w $012C

    .BRANCH_ALPHA

    LDA.b #$08 : STA.b $11

    STZ.b $B0

    RTS
}

; $0131BB-$0131C7 LOCAL JUMP LOCATION
Overworld_BrightenScreen:
{
    INC.b $13

    LDA.b $13 : CMP.b #$0F : BNE .notBrightEnough
        STZ.b $11
        STZ.b $B0

    .notBrightEnough

    RTS
}

; Module 0x09.0x18 (overworld loading an area submodule)
; $0131C8-$0131DE LOCAL JUMP LOCATION
Module09_18:
{
    STZ.w $032A

    LDA.b $10 : PHA ; Save module number
    LDA.b $11 : PHA ; Save submodule number

    JSR.w LoadSpecialOverworld
    JSR.w OverworldLoadSubScreenOverlay

    PLA : INC A : STA.b $11 ; Move on to the next module (0x19)
    PLA :         STA.b $10

    RTS
}

; Goes on to load a bunch of OW data like Map16 / Map32
; $0131DF-$0131EF LOCAL JUMP LOCATION
Module09_19:
{
    LDA.b $10 : PHA
    LDA.b $11 : PHA

    JSR.w PreOverworld_LoadAndAdvance

    PLA : INC A : STA.b $11
    PLA : STA.b $10

    RTS
}

; ==============================================================================

; $0131F0-$0131F3 LONG JUMP LOCATION
Overworld_LoadAndBuildScreen_long:
{
    JSR.w Overworld_LoadAndBuildScreen

    RTL
}

; ==============================================================================

; $0131F4-$0131F9 LONG JUMP LOCATION
Overworld_ReloadSubscreenOverlayAndAdvance_long:
{
    JSR.w Overworld_ReloadSubscreenOverlay

    DEC.b $11

    RTL
}

; ==============================================================================

; $0131FA-$0131FE LOCAL JUMP LOCATION
Overworld_MirrorWarp:
{
    JSL Overworld_MirrorWarp_Main

    RTS
}

; ==============================================================================

; $0131FF-$013216 LONG JUMP LOCATION
Overworld_MirrorWarp_Main:
{
    INC.w $0710

    LDA.b $B0

    JSL UseImplicitRegIndexedLongJumpTable

    dl Overworld_InitMirrorWarp

    ; These three appear to do palette filtering and manipulation of the
    ; hdma table, but how the latter works exactly is not understood yet.
    dl MirrorHDMA                        ; 0x00 - $FE5E
    dl MirrorWarp_BuildWavingHDMATable   ; 0x01 - $FE64
    dl MirrorWarp_BuildDewavingHDMATable ; 0x02 - $FF2F
    dl Overworld_FinishMirrorWarp        ; 0x03 - $B260
}

; ==============================================================================

; $013217-$01325F LONG JUMP LOCATION
Overworld_InitMirrorWarp:
{
    LDA.b $8A : CMP.b #$80 : BCC .not_extended_area
        STZ.b $11
        STZ.b $B0
        STZ.w $0200

        RTL

    .not_extended_area

    LDA.b #$08 : STA.w $012C : STA.w $0ABF

    LDA.b #$90 : STA.w $031F

    JSL Mirror_InitHdmaSettings

    ; SWAP DARKWORLD / LIGHTWORLD STATUS
    LDA.l $7EF3CA : EOR.b #$40 : STA.l $7EF3CA

    STZ.w $04C8
    STZ.w $04C9

    LDA.b $8A : AND.b #$3F : ORA.l $7EF3CA : STA.b $8A : STA.w $040A

    STZ.w $0200

    JSL Palette_InitWhiteFilter
    JSR.w Overworld_LoadMapProperties

    INC.b $B0

    RTL
}

; ==============================================================================

; $013260-$0132D3 LONG JUMP LOCATION
Overworld_FinishMirrorWarp:
{
    REP #$20

    LDA.w #$2641 : STA.w $4370

    LDX.b #$3E

    LDA.w #$FF00

    .clear_hdma_table

        STA.w $1B00, X : STA.w $1B40, X
        STA.w $1B80, X : STA.w $1BC0, X
        STA.w $1C00, X : STA.w $1C40, X
        STA.w $1C80, X
    DEX #2 : BPL .clear_hdma_table

    LDA.w #$0000 : STA.l $7EC007 : STA.l $7EC009

    SEP #$20

    JSL ReloadPreviouslyLoadedSheets
    JSL Overworld_SetSongList

    LDA.b #$80 : STA.b $9B

    LDX.b $8A

    LDA.l $7F5B00, X : AND.b #$0F : STA.w $012C

    LDA.l $7F5B00, X : LSR #4 : STA.w $012D

    CPX.b #$40 : BCC .not_bunny_music
        LDA.l $7EF357 : BNE .not_bunny_music
            LDA.b #$04 : STA.w $012C

    .not_bunny_music

    LDA.b $11 : STA.w $010C

    STZ.b $11
    STZ.b $B0
    STZ.w $0200
    STZ.w $0710

    RTL
}

; ==============================================================================

; ZS replaces this whole function. - ZS Custom Overworld
; $0132D4-$0132E5 LONG JUMP LOCATION
MirrorWarp_HandleCastlePyramidSubscreen:
{
    JSR.w Overworld_LoadSubscreenAndSilenceSFX1

    LDA.b $8A

    CMP.b #$1B : BEQ .isPyramidOrCastle
        CMP.b #$5B : BNE .notPyramidOrCastle
            .isPyramidOrCastle

            LDA.b #$01 : STA.b $1D

    .notPyramidOrCastle

    RTL
}

; ==============================================================================

; $0132E6-$013333 LONG JUMP LOCATION
Overworld_DrawScreenAtCurrentMirrorPosition:
{
    REP #$20

    LDA.b $84 : PHA
    LDA.b $86 : PHA
    LDA.b $88 : PHA

    LDX.b $8A

    LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BEQ .large_area
        LDA.w #$0390 : STA.b $84

        SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

        LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    .large_area

    SEP #$20

    JSR.w Overworld_LoadMapData

    ; Compare it to the other magic mirror mode
    LDA.b $11 : CMP.b #$2C : BNE .notFailedWarp
        JSR.w Overworld_RestoreFailedWarpMap16

    .notFailedWarp

    REP #$20

    PLA : STA.b $88
    PLA : STA.b $86
    PLA : STA.b $84

    SEP #$20

    RTL
}

; ==============================================================================

; ZS rewrites part of this function. - ZS Custom Overworld
; $013334-$013409 LONG JUMP LOCATION
MirrorWarp_LoadSpritesAndColors:
{
    LDA.b #$90 : STA.w $031F

    REP #$20

    LDA.b $84 : PHA
    LDA.b $86 : PHA
    LDA.b $88 : PHA

    LDA.w #$FFFF : STA.b $C8

    STZ.b $CA : STZ.b $CC

    LDX.b $8A

    LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BEQ .BRANCH_ALPHA
        LDA.w #$0390 : STA.b $84

        SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

        LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    .BRANCH_ALPHA

    SEP #$20

    JSR.w Map16ToMap8_normalArea

    REP #$20

    PLA : STA.b $88
    PLA : STA.b $86
    PLA : STA.b $84

    SEP #$20

    JSR.w Overworld_LoadAreaPalettes

    LDX.b $8A

    LDA.l $7EFD40, X : STA.b $00

    LDA.l $00FD1C, X

    JSL Overworld_LoadPalettes
    JSL Overworld_SetScreenBGColorCacheOnly
    JSL Overworld_SetFixedColorAndScroll

    ; ZS starts writing here.
    ; $0133A1 - ZS Custom Overworld
    LDA.b $8A
    CMP.b #$1B : BEQ .activateSubscreenBg0
        CMP.b #$5B : BNE .ignoreBg0
            .activateSubscreenBg0

            LDA.b #$01 : STA.b $1D

    .ignoreBg0

    REP #$20

    LDX.b #$00

    LDA.w #$7FFF

    .setBgPalettesToWhite
        STA.l $7EC540, X
        STA.l $7EC560, X
        STA.l $7EC580, X

        STA.l $7EC5A0, X
        STA.l $7EC5C0, X
        STA.l $7EC5E0, X

    INX #2 : CPX.b #$20 : BNE .setBgPalettesToWhite

    ; Also set the background color to white
    STA.l $7EC500

    ; This sets the color to transparent so that we don't see an additional
    ; white layer on top of the pyramid bg.
    LDA.b $8A : CMP.w #$005B : BNE .notPyramidOfPower
        LDA.w #$0000 : STA.l $7EC500 : STA.l $7EC540

    .notPyramidOfPower

    SEP #$20

    JSL Sprite_ResetAll
    JSL Sprite_OverworldReloadAll
    JSL Link_ItemReset_FromOverworldThings
    JSR.w DeleteCertainAncillaeStopDashing

    LDA.b #$14 : STA.b $5D

    LDA.b $8A : AND.b #$40 : BNE .darkWorld
        JSL Sprite_ReinitWarpVortex

    .darkWorld

    RTL
}

; Module 0x09.0x2B - making the screen flash white during the master sword
; retrieval.
; $01340A-$01340E LOCAL JUMP LOCATION
Overworld_MasterSword:
{
    JSL PaletteBlackAndWhiteSomething

    Overworld_WeathervaneExplosion:

    RTS
}

; $01340F-$013431 LOCAL JUMP LOCATION
Overworld_Whirlpool:
{
    INC.w $0710

    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw Whirlpool_InitWhirlpool        ; 0x00 - $B432
    dw Whirlpool_FilterBlue           ; 0x01 - $B44C
    dw Whirlpool_MoreBlue             ; 0x02 - $B451
    dw Whirlpool_FindDestination      ; 0x03 - $B46E
    dw Module09_2E_04                 ; 0x04 - $B48A
    dw Whirlpool_LoadDestinationMap   ; 0x05 - $B490
    dw Module09_2E_04                 ; 0x06 - $B48A
    dw Whirlpool_LoadAuxGraphics      ; 0x07 - $B49A
    dw Whirlpool_TriggerTilemapUpdate ; 0x08 - $B49F
    dw Whirlpool_LoadPalettes         ; 0x09 - $B4AE
    dw Module09_2E_0A                 ; 0x0A - $B45F
    dw Module09_2E_0B                 ; 0x0B - $B456
    dw Whirlpool_FinalizeWarp         ; 0x0C - $B4EF
}

; $013432-$01344B LOCAL JUMP LOCATION
Whirlpool_InitWhirlpool:
{
    LDA.b #$34 : STA.w $012E
    LDA.b #$05 : STA.w $012D

    STZ.w $0200

    LDA.b #$00 : STA.l $7EC007 : STA.l $7EC008

    INC.b $B0

    RTS
}

; $01344C-$013450 LOCAL JUMP LOCATION
Whirlpool_FilterBlue:
{
    JSL WhirlpoolSaturateBlue

    RTS
}

; $013451-$013455 LOCAL JUMP LOCATION
Whirlpool_MoreBlue:
{
    JSL WhirlpoolIsolateBlue

    RTS
}

; $013456-$01345E LOCAL JUMP LOCATION
Module09_2E_0B:
{
    JSL Graphics_IncrementalVramUpload
    JSL WhirlpoolRestoreBlue

    RTS
}

; $01345F-$01346D LOCAL JUMP LOCATION
Module09_2E_0A:
{
    JSL WhirlpoolRestoreRedGreen

    LDA.l $7EC007 : BEQ .alpha
        JSL WhirlpoolRestoreRedGreen

    .alpha

    RTS
}

; $01346E-$013489 LOCAL JUMP LOCATION
Module09_2E_03_FindDestination:
{
    LDA.b #$9F : STA.b $9E

    STZ.w $0AA9
    STZ.w $0AB2

    JSL Whirlpool_LookUpAndLoadTargetArea

    STZ.b $B2

    JSL Overworld_ReloadSubscreenOverlayAndAdvance_long

    LDA.b #$0C : STA.b $17

    STZ.b $15

    BRA Module09_2E_09_LoadPalettes_BRANCH_DELTA
}

; $01348A-$01348F LOCAL JUMP LOCATION
Module09_2E_04:
{
    LDA.b #$0D : STA.b $17

    BRA Module09_2E_09_LoadPalettes_BRANCH_ALPHA
}

; $013490-$013499 LOCAL JUMP LOCATION
Module09_2E_05_LoadDestinationMap:
{
    JSL BirdTravel_LoadAmbientOverlay

    LDA.b #$0C : STA.b $17

    BRA Module09_2E_09_LoadPalettes_BRANCH_BETA
}

; $01349A-$01349E LOCAL JUMP LOCATION
Module09_2E_07_LoadAuxGraphics:
{
    JSR.w Overworld_LoadTransGfx

    BRA Whirlpool_ToSubmod2D
}

; $01349F-$0134A8 LOCAL JUMP LOCATION
Module09_2E_08_TriggerTilemapUpdate:
{
    JSR.w Overworld_FinishTransGfx

    LDA.b #$0F : STA.b $13

    INC.w $0710

    ; Bleeds into the next function.
}

; $0134A9-$0134AD LOCAL JUMP LOCATION
Whirlpool_ToSubmod2D:
{
    DEC.b $11
    INC.b $B0

    RTS
}

; $0134AE-$0134EE LOCAL JUMP LOCATION
Module09_2E_09_LoadPalettes:
{
    STZ.w $0AA9

    JSL Palette_MainSpr
    JSL Palette_MiscSpr
    JSL Palette_SpriteAux3
    JSL Palette_Hud
    JSL Palette_OverworldBgMain

    LDX.b $8A

    LDA.l $7EFD40, X : STA.b $00

    LDA.l $00FD1C, X

    JSL Overworld_LoadPalettes
    JSL Palette_SetOwBgColor_Long
    JSL Overworld_SetFixedColorAndScroll
    JSL LoadNewSpriteGFXSet

    .BRANCH_DELTA

    LDA.b #$80 : STA.b $9E

    .BRANCH_BETA

    LDA.b #$0F : STA.b $13

    .BRANCH_ALPHA

    INC.w $0710
    INC.b $B0

    RTS
}

; $0134EF-$013520 LOCAL JUMP LOCATION
Module09_2E_0C_FinalizeWarp:
{
    LDA.b #$90 : STA.w $031F

    JSL ReloadPreviouslyLoadedSheets

    LDA.b #$80 : STA.b $9B

    LDX.b $8A

    LDA.l $7F5B00, X : LSR #4 : STA.w $012D

    LDX.b #$02

    LDA.l $7EF3CA : BEQ .BRANCH_ALPHA
        LDX.b #$09

    .BRANCH_ALPHA

    STX.w $012C

    STZ.b $11
    STZ.b $B0
    STZ.w $0200
    STZ.w $0710

    RTS
}

; ==============================================================================

; $013521-$013527 LOCAL JUMP LOCATION
Module09_2F:
{
    JSL Overworld_DrawWarpTile

    STZ.b $11

    RTS
}

; ==============================================================================

; $013528-$013531 LOCAL JUMP LOCATION
Overworld_RecoverFromDrowning:
{
    LDA.b $B0

    JSL UseImplicitRegIndexedLocalJumpTable

    dw Module09_2A_00_ScrollToLand  ; 0x00 - $B532
    dw RecoverPositionAfterDrowning ; 0x01 - $9583
}

; $013532-$0135AB LOCAL JUMP LOCATION
Module09_2A_00_ScrollToLand:
{
    REP #$20

    STZ.b $00
    STZ.b $02

    LDA.b $22 : CMP.l $7EC186 : BEQ .BRANCH_ALPHA  BCC .BRANCH_BETA
        DEC.b $02

        DEC A : CMP.l $7EC186 : BEQ .BRANCH_ALPHA
            DEC.b $02

            DEC A

        BRA .BRANCH_ALPHA

    .BRANCH_BETA

    INC.b $02

    INC A : CMP.l $7EC186 : BEQ .BRANCH_ALPHA
        INC.b $02

        INC A

    .BRANCH_ALPHA

    STA.b $22

    LDA.b $20 : CMP.l $7EC184 : BEQ .BRANCH_GAMMA  BCC .BRANCH_DELTA
        DEC.b $00

        DEC A : CMP.l $7EC184 : BEQ .BRANCH_GAMMA
            DEC.b $00

            DEC A

            BRA .BRANCH_GAMMA

    .BRANCH_DELTA

    INC.b $00

    INC A : CMP.l $7EC184 : BEQ .BRANCH_GAMMA
        INC.b $00

        INC A

    .BRANCH_GAMMA

    STA.b $20

    CMP.l $7EC184 : BNE .BRANCH_EPSILON
        LDA.b $22 : CMP.l $7EC186 : BNE .BRANCH_EPSILON
            INC.b $B0

            STZ.b $46

    .BRANCH_EPSILON

    SEP #$20

    LDA.b $00 : STA.b $30
    LDA.b $02 : STA.b $31

    JSR.w Overworld_OperateCameraScroll

    LDA.w $0416 : BEQ .BRANCH_ZETA
        JSR.w Overworld_ScrollMap

    .BRANCH_ZETA

    RTS
}

; $0135AC-$0135CB DATA
RoomQuadrantLayoutValues:
{
    db $0F, $0F, $0F, $0F ; Layout 0
    db $0B, $0B, $07, $07 ; Layout 1
    db $0F, $0B, $0F, $07 ; Layout 2, etc...
    db $0B, $0F, $07, $0F
    db $0E, $0D, $0E, $0D
    db $0F, $0F, $0E, $0D
    db $0E, $0D, $0F, $0F
    db $0A, $09, $06, $05
}

; $0135CC-$0135DB DATA
QuadrantLayoutFlagBitfield:
{
    db $08, $04, $02, $01, $0C, $0C, $03, $03
    db $0A, $05, $0A, $05, $0F, $0F, $0F, $0F
}

; ==============================================================================

; $0135DC-$01362D LONG JUMP LOCATION
Dungeon_AdjustForRoomLayout:
{
    PHB : PHK : PLB

    SEP #$30

    ; Set $A8 to a composite of quadrants we're in.
    JSR.w Underworld_AdjustQuadrant

    STZ.b $A6

    LDY.b #$02

    LDA.b $A9 : BNE .inRightHalf
        ; Value for left half of screen
        LDY.b #$01

    .inRightHalf

    STY.b $00

    ; Since there are no horizontal blast walls in the original game,
    ; this code is kind of moot. See other comment on them below, though.
    LDA.w $0452 : BNE .blastWallOpenHoriz
        LDX.b $A8

        LDA.w RoomQuadrantLayoutValues, X : AND.b $00 : BNE .gamma

    .blastWallOpenHoriz

    LDA.b #$02 : STA.b $A6

    .gamma

    STZ.b $A7

    LDY.b #$08

    LDA.b $AA : BNE .inLowerHalf
        ; Value for upper half
        LDY.b #$04

    .inLowerHalf

    STY.b $00

    ; I think this has to do with scroll control. Opening up a blast wall
    ; alters a room's scrolling regions, or something like that.
    LDA.w $0453 : BNE .blastWallOpenVert
        LDX.b $A8

        LDA.w RoomQuadrantLayoutValues, X : AND.b $00 : BNE .zeta

    .blastWallOpenVert

    LDA.b #$02 : STA.b $A7

    .zeta

    LDA.b $FC : BEQ .blastWallHorizOverride
        STA.b $A6

    .blastWallHorizOverride

    LDA.b $FD : BEQ .blastWallVertOverride
        STA.b $A7

    .blastWallVertOverride

    PLB

    RTL
}

; ==============================================================================

; $01362E-$013639 LONG JUMP LOCATION
HandleEdgeTransitionMovementEast_RightBy8:
{
    REP #$20

    LDA.b $22 : CLC : ADC.w #$0008 : STA.b $22

    SEP #$20

    ; Bleeds into the next function.
}

; $01363A-$0136CC LONG JUMP LOCATION
HandleEdgeTransitionMovementEast:
{
    PHB : PHK : PLB

    LDA.b $A9 : EOR.b #$01 : STA.b $A9

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$08

    JSR.w AdjustCameraBounds_DownOrRightQuadrant
    JSR.w Underworld_SaveRoomData

    LDA.b $A9

    JSR.w UnderworldTransition_AdjustCamera_Horizontal

    LDY.b #$02

    JSR.w HandleEdgeTransition_AdjustCameraBounds

    INC.b $11

    LDA.b $A9 : BNE .BRANCH_ALPHA
        LDX.b #$08

        JSR.w AdjustCameraBounds_DownOrRightWholeRoom

        LDA.b $A0 : STA.b $A2

        ; Load the tile type we're standing on.
        ; Is it the linking doorway?
        LDA.w $0114 : AND.b #$CF : CMP.b #$89 : BNE .notRoomLinkDoor
            ; Yep
            LDA.l $7EC004 : STA.b $A0 : DEC A

            ; Moving right, so add positive to X coords.
            LDY.b #$01

            JSR.w Dungeon_AdjustCoordsForLinkedRoom

            BRA .BRANCH_GAMMA

        .notRoomLinkDoor

        ; Load the room number
        ; Compare it to the... um, room number?
        LDA.w $048E : CMP.b $A0 : BEQ .BRANCH_DELTA
            STA.b $A2

            JSR.w Dungeon_AdjustAfterSpiralStairs

        .BRANCH_DELTA

        INC.b $A0

        .BRANCH_GAMMA

        INC.b $11

        LDA.b $EF : AND.b #$01 : BEQ .BRANCH_EPSILON
            LDA.b $EE : EOR.b #$01 : STA.b $EE : STA.w $0476

        .BRANCH_EPSILON

        LDA.b $EF : AND.b #$02 : BEQ .BRANCH_ALPHA
            LDA.w $040C : EOR.b #$02 : STA.w $040C

    .BRANCH_ALPHA

    STZ.b $EF
    STZ.b $A7

    LDY.b #$08

    LDA.b $AA : BNE .BRANCH_THETA
        LDY.b #$04

    .BRANCH_THETA

    STY.b $00

    LDA.w $0453 : BNE .BRANCH_IOTA
        LDX.b $A8

        LDA.w RoomQuadrantLayoutValues, X : AND.b $00 : BNE .BRANCH_KAPPA

    .BRANCH_IOTA

    LDA.b #$02 : STA.b $A7

    .BRANCH_KAPPA

    PLB

    RTL
}

; ==============================================================================

; $0136CD-$0136D8 LONG JUMP LOCATION
HandleEdgeTransitionMovementWest_LeftBy8:
{
    REP #$20

    LDA.b $22 : SEC : SBC.w #$0008 : STA.b $22

    SEP #$20

    ; Bleeds into the next function.
}

; $0136D9-$01376D LONG JUMP LOCATION
HandleEdgeTransitionMovementWest:
{
    PHB : PHK : PLB

    LDA.b $A9 : EOR.b #$01 : STA.b $A9

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$08

    JSR.w AdjustCameraBounds_UpOrLeftQuadrant
    JSR.w Underworld_SaveRoomData

    LDA.b $A9 : EOR.b #$01

    JSR.w UnderworldTransition_AdjustCamera_Horizontal

    LDY.b #$03

    JSR.w HandleEdgeTransition_AdjustCameraBounds

    INC.b $11

    LDA.b $A9 : BNE .BRANCH_ALPHA
        LDX.b #$08

        JSR.w AdjustCameraBounds_UpOrLeftWholeRoom

        LDA.b $A0 : STA.b $A2

        ; Is it a linking doorway?
        LDA.w $0114 : AND.b #$CF : CMP.b #$89 : BNE .notRoomLinkDoor
            ; Yep
            LDA.l $7EC003 : STA.b $A0 : DEC A

            LDY.b #$FF ; Moving left... so add negatives to X cooords.

            JSR.w Dungeon_AdjustCoordsForLinkedRoom

            BRA .BRANCH_GAMMA

        .notRoomLinkDoor

        LDA.w $048E : CMP.b $A0 : BEQ .BRANCH_DELTA
            STA.b $A2

            JSR.w Dungeon_AdjustAfterSpiralStairs

        .BRANCH_DELTA

        DEC.b $A0

        .BRANCH_GAMMA

        INC.b $11

        LDA.b $EF : AND.b #$01 : BEQ .BRANCH_EPSILON
            LDA.b $EE : EOR.b #$01 : STA.b $EE : STA.w $0476

        .BRANCH_EPSILON

        LDA.b $EF : AND.b #$02 : BEQ .BRANCH_ALPHA
            LDA.w $040C : EOR.b #$02 : STA.w $040C

    .BRANCH_ALPHA

    STZ.b $EF
    STZ.b $A7

    LDY.b #$08

    LDA.b $AA : BNE .BRANCH_THETA
        LDY.b #$04

    .BRANCH_THETA

    STY.b $00

    LDA.w $0453 : BNE .BRANCH_IOTA
        LDX.b $A8

        LDA.w RoomQuadrantLayoutValues, X : AND.b $00 : BNE .BRANCH_KAPPA

    .BRANCH_IOTA

    LDA.b #$02 : STA.b $A7

    .BRANCH_KAPPA

    PLB

    RTL
}

; ==============================================================================

; $01376E-$013779 LONG JUMP LOCATION
HandleEdgeTransitionMovementSouth_DownBy16:
{
    REP #$20

    LDA.b $20 : CLC : ADC.w #$0010 : STA.b $20

    SEP #$20

    ; Bleeds into the next function.
}

; $01377A-$0137AD LONG JUMP LOCATION
HandleEdgeTransitionMovementSouth:
{
    PHB : PHK : PLB

    ; Alternate between being in the lower half and the upper half of the room.
    LDA.b $AA : EOR #$02 : STA.b $AA

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$00

    JSR.w AdjustCameraBounds_DownOrRightQuadrant
    JSR.w Underworld_SaveRoomData

    LDA.b $AA

    JSR.w UnderworldTransition_AdjustCamera_Vertical

    LDY.b #$00

    JSR.w HandleEdgeTransition_AdjustCameraBounds

    INC.b $11

    LDA.b $AA : BNE PrepForOverworldExit_inRoomLowerHalf
        LDX.b #$00

        JSR.w AdjustCameraBounds_DownOrRightWholeRoom

        LDA.b $A0 : STA.b $A2

        LDA.w $0114 : CMP.b #$8E : BNE PrepForOverworldExit_notGoingToOverworld
            ; Bleeds into the next function.
}

; $0137AE-$01381B LONG JUMP LOCATION
PrepForOverworldExit:
{
    JSL Dungeon_SaveRoomData_justKeys
    JSL SaveVisitedQuadrantFlags

    LDA.b #$08 : STA.w $010C

    ; Go to pre-overworld mode.
    LDA.b #$0F : STA.b $10

    STZ.b $11
    STZ.b $B0

    JSR.w DeleteCertainAncillaeStopDashing

    PLB

    RTL

    .notGoingToOverworld

    LDA.w $048E : CMP.b $A0 : BEQ .gamma
        STA.b $A2

        JSR.w Dungeon_AdjustAfterSpiralStairs

    .gamma

    ; Move down to the next room.
    LDA.b $A0 : CLC : ADC.b #$10 : STA.b $A0

    INC.b $11

    LDA.b $EF : AND.b #$01 : BEQ .BRANCH_DELTA
        LDA.b $EE : EOR.b #$01 : STA.b $EE : STA.w $0476

    .BRANCH_DELTA

    LDA.b $EF : AND.b #$00 : BEQ .inRoomLowerHalf
        LDA.w $040C : EOR.b #$02 : STA.w $040C

    .inRoomLowerHalf

    STZ.b $EF
    STZ.b $A6

    LDY.b #$02

    LDA.b $A9 : BNE .BRANCH_EPSILON
        LDY.b #$01

    .BRANCH_EPSILON

    STY.b $00

    LDA.w $0452 : BNE .BRANCH_ZETA
        LDX.b $A8

        LDA.w RoomQuadrantLayoutValues, X : AND.b $00 : BNE .BRANCH_THETA

    .BRANCH_ZETA

    LDA.b #$02 : STA.b $A6

    .BRANCH_THETA

    PLB

    RTL
}

; ==============================================================================

; $01381C-$0138BC LONG JUMP LOCATION
HandleEdgeTransitionMovementNorth:
{
    PHB : PHK : PLB

    LDA.b $AA : EOR.b #$02 : STA.b $AA

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$00

    JSR.w AdjustCameraBounds_UpOrLeftQuadrant
    JSR.w Underworld_SaveRoomData

    LDA.b $AA : EOR.b #$02

    JSR.w UnderworldTransition_AdjustCamera_Vertical

    LDY.b #$01

    JSR.w HandleEdgeTransition_AdjustCameraBounds

    INC.b $11

    LDA.b $AA : BEQ .inRoomUpperHalf
        LDX.b #$00

        JSR.w AdjustCameraBounds_UpOrLeftWholeRoom

        LDA.b $A0 : STA.b $A2

        LDA.w $0114 : CMP.b #$8E : BNE .notGoingToOverworld
            JMP.w PrepForOverworldExit

        .notGoingToOverworld

        LDA.b $A0 : ORA.b $A1 : BNE .notInGanonsRoom
            JSL Dungeon_SaveRoomData_justKeys

            ; Go to the triforce room scene.
            LDA.b #$19 : STA.b $10

            STZ.b $11
            STZ.b $B0

            PLB

            RTL

        .notInGanonsRoom

        LDA.w $048E : CMP.b $A0 : BEQ .BRANCH_DELTA
            STA.b $A2

            JSR.w Dungeon_AdjustAfterSpiralStairs

        .BRANCH_DELTA

        ; Set the room number to the room "north" of the current one.
        LDA.b $A0 : SEC : SBC.b #$10 : STA.b $A0

        ; Enter room transition mode
        INC.b $11

        LDA.b $EF : AND.b #$01 : BEQ .noFloorToggle
            LDA.b $EE : EOR.b #$01 : STA.b $EE : STA.w $0476

        .noFloorToggle

        ; Do we need to do a transition between sewer / HC
        LDA.b $EF : AND.b #$02 : BEQ .noPalaceToggle
            ; Toggle between sewer / HC
            LDA.w $040C : EOR.b #$02 : STA.w $040C

        .noPalaceToggle
    .inRoomUpperHalf

    STZ.b $EF
    STZ.b $A6

    LDY.b #$02

    LDA.b $A9 : BNE .inRoomRightHalf
        LDY.b #$01

    .inRoomRightHalf

    STY.b $00

    LDA.w $0452 : BNE .iota
        LDX.b $A8

        LDA.w RoomQuadrantLayoutValues, X : AND.b $00 : BNE .kappa

    .iota

    LDA.b #$02 : STA.b $A6

    .kappa

    PLB

    RTL
}

; $0138BD-$0138CA LONG JUMP LOCATION
AdjustQuadrantAndCamera_right:
{
    LDA.b $A9 : EOR #$01 : STA.b $A9

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$08

    JSR.w AdjustCameraBounds_DownOrRightQuadrant

    ; Bleeds into the next function.
}

; Update qudrants visited and store to srams
; $0138CB-$0138E4 LONG JUMP LOCATION
SetAndSaveVisitedQuadrantFlags:
{
    LDA.b $A7 : ASL #2 : STA.b $00
    LDA.b $A6 : ASL A  : ORA.b $00
    ORA.b $AA
    ORA.b $A9

    TAX

    LDA.l $02B5CC, X : ORA.w $0408 : STA.w $0408

    ; Bleeds into the next function.
}

; $0138E5-$0138F8 LONG JUMP LOCATION
SaveVisitedQuadrantFlags:
{
    REP #$30

    LDA.b $A0 : ASL A : TAX

    ; Save quadrants explored to save ram buffer
    LDA.l $7EF000, X : ORA.w $0408 : STA.l $7EF000, X

    SEP #$30

    RTL
}

; $0138F9-$013908 LONG JUMP LOCATION
AdjustQuadrantAndCamera_left:
{
    LDA.b $A9 : EOR #$01 : STA.b $A9

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$08

    JSR.w AdjustCameraBounds_UpOrLeftQuadrant

    BRA SetAndSaveVisitedQuadrantFlags
}

; $013909-$013918 LONG JUMP LOCATION
AdjustQuadrantAndCamera_down:
{
    LDA.b $AA : EOR.b #$02 : STA.b $AA

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$00

    ; Moving down...
    JSR.w AdjustCameraBounds_DownOrRightQuadrant

    BRA SetAndSaveVisitedQuadrantFlags
}

; $013919-$013928 LONG JUMP LOCATION
AdjustQuadrantAndCamera_up:
{
    LDA.b $AA : EOR.b #$02 : STA.b $AA

    JSR.w Underworld_AdjustQuadrant

    LDX.b #$00

    ; Moving up...
    JSR.w AdjustCameraBounds_UpOrLeftQuadrant

    BRA SetAndSaveVisitedQuadrantFlags
}

; Figures out which Quadrants Link has visited in a room.
; $013929-$013946 LONG JUMP LOCATION
Dungeon_SaveRoomQuadrantData:
{
    ; Mapped to bit 3.
    LDA.b $A7 : ASL #2 : STA.b $00

    ; Mapped to bit 2.
    LDA.b $A6 : ASL A : ORA.b $00

    ; Mapped to bit 1.
    ORA.b $AA

    ; Mapped to bit 0.
    ORA.b $A9

    ; X ranges from 0x00 to 0x0F
    TAX

    ; These determine the quadrants Link has seen in this room.
    LDA.l $02B5CC, X : ORA.w $0408 : STA.w $0408

    JSR.w Underworld_SaveRoomData ; Save the room data and exit.

    RTL
}

; ==============================================================================

; Saves data for the current room
; $013947-$013967 LOCAL JUMP LOCATION
Underworld_SaveRoomData:
{
    REP #$30

    ; What room are we in... use it as an index.
    LDA.b $A0 : ASL A : TAX

    ; Store other data, like chests opened, bosses killed, etc.
    LDA.w $0402 : LSR #4 : STA.b $06

    ; Store information about this room when it changes.
    LDA.w $0400 : AND.w #$F000 : ORA.w $0408 : ORA.b $06 : STA.l $7EF000, X

    SEP #$30

    RTS
}

; Moving on down....
; $013968-$013980 LOCAL JUMP LOCATION
AdjustCameraBounds_DownOrRightQuadrant:
{
    REP #$20

    LDA.w $0600, X : CLC : ADC.w #$0100 : STA.w $0600, X
    LDA.w $0604, X : CLC : ADC.w #$0100 : STA.w $0604, X

    SEP #$20

    RTS
}

; $013981-$013999 LOCAL JUMP LOCATION
AdjustCameraBounds_DownOrRightWholeRoom:
{
    REP #$20

    LDA.w $0602, X : CLC : ADC.w #$0200 : STA.w $0602, X
    LDA.w $0606, X : CLC : ADC.w #$0200 : STA.w $0606, X

    SEP #$20

    RTS
}

; Movin on up....
; $01399A-$0139B2 LOCAL JUMP LOCATION
AdjustCameraBounds_UpOrLeftQuadrant:
{
    REP #$20

    LDA.w $0600, X : SEC : SBC.w #$0100 : STA.w $0600, X
    LDA.w $0604, X : SEC : SBC.w #$0100 : STA.w $0604, X

    SEP #$20

    RTS
}

; $0139B3-$0139CB LOCAL JUMP LOCATION
AdjustCameraBounds_UpOrLeftWholeRoom:
{
    REP #$20

    LDA.w $0602, X : SEC : SBC.w #$0200 : STA.w $0602, X
    LDA.w $0606, X : SEC : SBC.w #$0200 : STA.w $0606, X

    SEP #$20

    RTS
}

; $0139CC-$0139DB DATA
Pool_HandleEdgeTransition_AdjustCameraBounds:
{
    ; $0139CC
    .vertical_bounds
    dw $0078
    dw $0178
    dw $0088
    dw $0188

    ; $0139D4
    .horizontal_bounds
    dw $007F
    dw $017F
    dw $007F
    dw $017F
}

; $0139DC-$013A26 LOCAL JUMP LOCATION
HandleEdgeTransition_AdjustCameraBounds:
{
    STY.w $0418

    LDA.b $67 : AND.b #$03 : BEQ .BRANCH_ALPHA
        REP #$20

        LDX.b #$04

        LDA.b $67 : AND.w #$0001 : BEQ .BRANCH_BETA
            LDX.b #$00

        .BRANCH_BETA

        LDY.b $A9 : BEQ .BRANCH_GAMMA
            INX #2

        .BRANCH_GAMMA

        LDA.w Pool_HandleEdgeTransition_AdjustCameraBounds_horizontal_bounds, X
        STA.w $061C

        INC A : INC A : STA.w $061E

        SEP #$20

        RTS

    .BRANCH_ALPHA

    REP #$20

    LDX.b #$04

    LDA.b $67 : AND.w #$0004 : BEQ .BRANCH_DELTA
        LDX.b #$00

    .BRANCH_DELTA

    LDY.b $AA : BEQ .BRANCH_EPSILON
        INX #2

    .BRANCH_EPSILON

    LDA.w Pool_HandleEdgeTransition_AdjustCameraBounds_vertical_bounds, X
    STA.w $0618

    INC A : INC A : STA.w $061A

    SEP #$20

    RTS
}

; Set $A8 to a composite of quadrants we're in.
; $013A27-$013A30 LOCAL JUMP LOCATION
Underworld_AdjustQuadrant:
{
    LDA.w $040E : ORA.b $AA : ORA.b $A9 : STA.b $A8

    RTS
}

; ==============================================================================

; $013A31-$013B87 LOCAL JUMP LOCATION
Underworld_HandleCamera:
{
    REP #$20

    LDA.w #$0001 : STA.b $00

    LDA.b $78 : AND.w #$00FF : BEQ .BRANCH_ALPHA
        LDA.b $24 : CMP.w #$FFFF : BNE .BRANCH_ALPHA
            LDA.w #$0000

    .BRANCH_ALPHA

    STA.b $0E

    LDA.b $20 : SEC : SBC.b $0E : AND.w #$01FF : CLC : ADC.w #$000C : STA.b $0E

    LDA.b $30 : AND.w #$00FF : BEQ .BRANCH_BETA
        LDX.b $A7

        CMP.w #$0080 : BCC .BRANCH_GAMMA
            EOR.w #$00FF : INC A

            DEC.b $00 : DEC.b $00

        .BRANCH_GAMMA

        TAY

        .BRANCH_IOTA

            LDX.b $A7

            LDA.b $30 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_DELTA

            LDA.w $0618 : CMP.b $0E : BCS .BRANCH_EPSILON  BCC .BRANCH_ZETA
                .BRANCH_DELTA

                LDA.b $0E : CMP.w $061A : BCC .BRANCH_ZETA
                    INX #4

                    .BRANCH_EPSILON

                    ; Comapare against y coordinate limits
                    LDA.b $E8 : CMP.w $0600, X : BEQ .BRANCH_ZETA
                        CLC : ADC.b $00 : STA.b $E8

                        LDA.b $A0 : CMP.w #$FFFF : BEQ .BRANCH_ZETA
                            LDA.b $00

                            STZ.b $04

                            LSR A : ROR.b $04 : CMP.w #$7000 : BCC .BRANCH_THETA
                                ORA.w #$F000

                            .BRANCH_THETA

                            STA.b $06

                            LDA.w $0622 : CLC : ADC.b $04 : STA.w $0622

                            LDA.b $E6 : ADC.b $06 : STA.b $E6

                            LDA.w $0618 : CLC : ADC.b $00 : STA.w $0618

                            INC #2 : STA.w $061A

            .BRANCH_ZETA
        DEY : BNE .BRANCH_IOTA

    .BRANCH_BETA

    LDA.w #$0001 : STA.b $00

    LDA.b $22 : AND.w #$01FF : CLC : ADC.w #$0008 : STA.b $0E

    LDA.b $31 : AND.w #$00FF : BEQ .BRANCH_KAPPA
        LDX.b $A6

        CMP.w #$0080 : BCC .BRANCH_LAMBDA
            EOR #$00FF : INC A

            DEC.b $00 : DEC.b $00

        .BRANCH_LAMBDA

        TAY

        .BRANCH_PI

            LDX.b $A6

            LDA.b $31 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_MU
                LDA.w $061C : CMP.b $0E : BCS .BRANCH_NU  BCC .BRANCH_XI

            .BRANCH_MU

            LDA.b $0E : CMP.w $061E : BCC .BRANCH_XI
                INX #4

                .BRANCH_NU

                ; Compare with screen coordinate limits...? (x coordinate)
                LDA.b $E2 : CMP.w $0608, X : BEQ .BRANCH_XI
                    CLC : ADC.b $00 : STA.b $E2

                    LDA.b $A0 : CMP.w #$FFFF : BEQ .BRANCH_XI
                        LDA.b $00 : STZ.b $04 : LSR A : ROR.b $04 : CMP.w #$7000 : BCC .BRANCH_OMICRON
                            ORA.w #$F000

                        .BRANCH_OMICRON

                        STA.b $06

                        LDA.w $0620 : CLC : ADC.b $04 : STA.w $0620

                        LDA.b $E0 : ADC.b $06 : STA.b $E0

                        LDA.w $061C : CLC : ADC.b $00 : STA.w $061C

                        INC #2 : STA.w $061E

            .BRANCH_XI
        DEY : BNE .BRANCH_PI

    .BRANCH_KAPPA

    LDA.b $A0 : CMP.w #$FFFF : BEQ .BRANCH_RHO
        LDX.w $0414  : BEQ .BRANCH_SIGMA
        CPX.b #$06 : BCS .BRANCH_SIGMA
        CPX.b #$04 : BEQ .BRANCH_SIGMA
        CPX.b #$03 : BEQ .BRANCH_SIGMA
        CPX.b #$02 : BNE .BRANCH_RHO
            .BRANCH_SIGMA

            ; $013B7B ALTERNATE ENTRY POINT
            Dungeon_SyncBG1and2Scroll:

            REP #$20

            ; Synchronize BG2 and BG1 scroll regs
            LDA.b $E2 : STA.b $E0
            LDA.b $E8 : STA.b $E6

    .BRANCH_RHO

    SEP #$20

    RTS
}

; ==============================================================================

; bit masks describing which direction(s) to update the OW tilemap in.
; $013B88-$013B8F DATA
OverworldTransitionDirections:
{
    dw $0008, $0004, $0002, $0001
}

; ==============================================================================

; ZS rewrites part of this function. - ZS Custom Overworld
; $013B90-$013CFA LOCAL JUMP LOCATION
Overworld_OperateCameraScroll:
{
    PHB : PHK : PLB

    REP #$20

    LDA.b $78 : AND.w #$00FF : BEQ .BRANCH_ALPHA
        LDA.b $24 : CMP.w #$FFFF : BNE .BRANCH_ALPHA
            LDA.w #$0000

    .BRANCH_ALPHA

    STA.b $0E

    LDA.b $20 : SEC : SBC.b $0E : CLC : ADC.w #$000C : STA.b $0E

    LDA.w #$0001 : STA.b $00

    LDA.b $30 : AND.w #$00FF : BNE .BRANCH_BETA
        JMP.w Overworld_OperateCameraScroll_handle_x_camera

    .BRANCH_BETA

    STZ.b $04

    CMP.w #$0080 : BCC .BRANCH_GAMMA
        EOR.w #$00FF : INC A

        DEC.b $00 : DEC.b $00

    .BRANCH_GAMMA

    STA.b $02

    STZ.b $08

    .BRANCH_THETA

        LDA.b $30 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_DELTA
            LDA.w $0618 : CMP.b $0E : BCC .BRANCH_EPSILON
                LDY.b #$00

                BRA .BRANCH_ZETA

                .BRANCH_DELTA

                LDA.b $0E : CMP.w $061A : BCC .BRANCH_EPSILON
                    LDY.b #$02

                    .BRANCH_ZETA

                    LDX.b #$06

                    JSR.w OverworldCameraBoundaryCheck

            .BRANCH_EPSILON
    DEC.b $02 : BNE .BRANCH_THETA

    LDA.b $04 : STA.w $069E

    LDX.b $8C

    CPX.w #$97 : BEQ .handle_x_camera
    CPX.b #$9D : BEQ .handle_x_camera
        LDA.b $04 : BEQ .handle_x_camera

        STZ.b $00

        LSR A : ROR.b $00

        LDX.b $8C

        CPX.b #$B5 : BEQ .BRANCH_KAPPA
            CPX.b #$BE : BNE .BRANCH_LAMBDA
                .BRANCH_KAPPA

                LSR A : ROR.b $00 : CMP.w #$3000 : BCC .BRANCH_MU
                    ORA.w #$F000

                    BRA .BRANCH_MU

            .BRANCH_LAMBDA

            CMP.w #$7000 : BCC .BRANCH_MU
                ORA.w #$F000

            .BRANCH_MU

            STA.b $06

            LDA.w $0622 : CLC : ADC.b $00 : STA.w $0622

            LDA.b $E6 : ADC.b $06 : STA.b $E6

            ; ZS writes here.
            ; $013C44 - ZS Custom Overworld
            LDA.b $8A : AND.w #$003F : CMP.w #$001B : BNE .handle_x_camera
                LDA.w #$0600 : CMP.b $E6 : BCC .BRANCH_NU
                    STA.b $E6

                .BRANCH_NU

                LDA.w #$06C0 : CMP.b $E6 : BCS .handle_x_camera
                    STA.b $E6

    ; $013C60 ALTERNATE ENTRY POINT
    .handle_x_camera

    LDA.b $22 : CLC : ADC.w #$0008 : STA.b $0E

    LDA.w #$0001 : STA.b $00

    LDA.b $31 : AND.w #$00FF : BNE .BRANCH_XI
        JMP.w OverworldHandleBGOverlayScroll

    .BRANCH_XI

    STZ.b $04

    CMP.w #$0080 : BCC .BRANCH_OMICRON
        EOR.w #$00FF : INC A : DEC.b $00 : DEC.b $00

    .BRANCH_OMICRON

    STA.b $02

    LDX.b #$04 : STX.b $08

    .BRANCH_TAU
        LDA.b $31 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_PI
            LDA.w $061C : CMP.b $0E : BCC .BRANCH_RHO
                LDY.b #$04

                BRA .BRANCH_SIGMA

        .BRANCH_PI

        LDA.b $0E : CMP.w $061E : BCC .BRANCH_RHO
            LDY.b #$06

        .BRANCH_SIGMA

        LDX.b #$00

        JSR.w OverworldCameraBoundaryCheck

        .BRANCH_RHO

    DEC.b $02 : BNE .BRANCH_TAU

    LDA.b $04 : STA.w $069F

    LDX.b $8C

    CPX.b #$97 : BEQ .BRANCH_UPSILON
    CPX.b #$9D : BEQ .BRANCH_UPSILON
        LDA.b $04 : BEQ .BRANCH_UPSILON
            STZ.b $00 : LSR A : ROR.b $00

            LDX.b $8C

            CPX.b #$95 : BEQ .BRANCH_PHI
                CPX.b #$9E : BNE .BRANCH_CHI
                    .BRANCH_PHI

                    LSR A : ROR.b $00 : CMP.w #$3000 : BCC .BRANCH_PSI
                        ORA.w #$F000

                        BRA .BRANCH_PSI

                .BRANCH_CHI

                CMP.w #$7000 : BCC .BRANCH_PSI
                    ORA.w #$F000

                .BRANCH_PSI

                STA.b $06

                LDA.w $0620 : CLC : ADC.b $00 : STA.w $0620

                LDA.b $E0 : ADC.b $06 : STA.b $E0

    .BRANCH_UPSILON

    ; Bleeds into the next function.
}

; $013CFB-$013D61 LOCAL JUMP LOCATION
OverworldHandleBGOverlayScroll:
{
    ; $013CFB - ZS Custom Overworld? - This one seems to control some sort of
    ; subscreen movement but only for turtle rock. This will need to be
    ; investigated further as to why.
    LDX.b $8A : CPX.b #$47 : BEQ .BRANCH_OMEGA
        LDX.b $8C

        CPX.b #$9C : BEQ .BRANCH_ALTIMA
            CPX.b #$97 : BEQ .BRANCH_ULTIMA
                CPX.b #$9D : BNE .BRANCH_OMEGA
                    .BRANCH_ULTIMA

                    LDA.w $0622 : CLC : ADC.w #$2000 : STA.w $0622

                    LDA.b $E6 : ADC.w #$0000 : STA.b $E6

                    LDA.w $0620 : CLC : ADC.w #$2000 : STA.w $0620

                    LDA.b $E0 : ADC.w #$0000 : STA.b $E0

                    BRA .BRANCH_OMEGA

        .BRANCH_ALTIMA

        LDA.w $0622 : SEC : SBC.w #$2000 : STA.w $0622

        LDA.b $E6 : SBC.w #$0000 : CLC : ADC.w $069E : STA.b $E6

        LDA.b $E2 : STA.b $E0

    .BRANCH_OMEGA

    LDA.b $A0 : CMP.w #$0181 : BNE .BRANCH_OPTIMUS
        LDA.b $E8 : ORA.w #$0100 : STA.b $E6

        LDA.b $E2 : STA.b $E0

    .BRANCH_OPTIMUS

    SEP #$20

    PLB

    RTS
}

; ==============================================================================

; $013D62-$013DBF LOCAL JUMP LOCATION
OverworldCameraBoundaryCheck:
{
    ; Compare X or Y scroll coordinate to the current position coordinate
    LDA.b $E2, X : CMP.w $0600, Y : BNE .BRANCH_ALPHA
        TYA : EOR.w #$0002 : TAX

        ; Clears out both $0624 and $0626 (this is a silly trick, they could
        ; have just done STZ.w $0624 : STZ.w $0626)
        LDA.w #$0000 : STA.w $0624, Y : STA.w $0624, X

        RTS

    .BRANCH_ALPHA

    ; Updating a number of coordinates, including the scroll register mirror.
    CLC : ADC.b $00 : STA.b $E2, X

    LDA.b $04 : CLC : ADC.b $00 : STA.b $04

    LDX.b $08
    LDA.w $061A, X : CLC : ADC.b $00 : STA.w $061A, X
                              INC #2 : STA.w $0618, X

    TYA : EOR.w #$0002 : TAX

    ; A coordinate that is not on the 16 pixel grid
    LDA.w $0624, Y : INC A : STA.w $0624, Y : CMP.w #$0010 : BMI .notGrid
        SEC : SBC.w #$0010 : STA.w $0624, Y

        ; Sets the side (east , north, etc) the tilemap needs to be updated on.
        LDA.w OverworldTransitionDirections, Y : ORA.w $0416 : STA.w $0416

    .notGrid

    ; $0624,X = -($0624,Y)
    LDA.w #$0000 : SEC : SBC.w $0624, Y : STA.w $0624, X

    RTS
}

; ==============================================================================


; $013DC0-$013DC7 DATA
Pool_UnderworldTransition_AdjustCamera_Horizontal:
{
    .boundary
    dw $0000, $0100, $0100, $0000
}

; $013DC8-$013DD9 LOCAL JUMP LOCATION
UnderworldTransition_AdjustCamera_Horizontal:
{
    ASL #2 : TAY

    LDX.b #$00

    .nextDirection

        LDA.w Pool_UnderworldTransition_AdjustCamera_Horizontal, Y
        STA.w $0614, X
    INX #2 : CPX.b #$04 : BNE .nextDirection

    RTS
}

; ==============================================================================

; $013DDA-$013DE1 DATA
Pool_UnderworldTransition_AdjustCamera_Vertical:
{
    .boundary
    dw $0000, $0110, $0100, $0010
}

; $013DE2-$013DF2 LOCAL JUMP LOCATION
UnderworldTransition_AdjustCamera_Vertical:
{
    ASL A : TAY

    LDX.b #$00

    .nextDirection

        LDA.w Pool_UnderworldTransition_AdjustCamera_Vertical, Y
        STA.w $0610, X

        INY
    INX : CPX.b #$04 : BNE .nextDirection

    RTS
}

; ==============================================================================

; $013DF3-$013E02 DATA
Pool_UnderworldTransition_ScrollRoom:
{
    ; $013DF3
    .camera_scroll
    dw 4, -4, 4, -4

    ; $013DFB
    .bounds
    dw $0034, $0034, $003B, $003A
}

; More scrolling transitionary stuff...
; $013E03-$013E6C LOCAL JUMP LOCATION
UnderworldTransition_ScrollRoom:
{
    PHB : PHK : PLB

    INC.w $0126

    ; Direction of the transition.
    LDA.w $0418 : ASL A : TAY

    REP #$20

    STZ.w $011A
    STZ.w $011C

    LDX.b #$00

    CPY.b #$04 : BCS .horizontalScrolling
        ; Operate on the vertical scroll register.
        LDX.b #$06

    .horizontalScrolling
    LDA.b $E2, X
    CLC : ADC.w Pool_UnderworldTransition_ScrollRoom_camera_scroll, Y
    AND.w #$FFFE : STA.b $E2, X : STA.b $E0, X : STA.b $00

    LDX.b #$00

    CPY.b #$04 : BCC .verticalScrolling
        LDX.b #$02

    .verticalScrolling ; ???? is this name correct?

    LDA.w $0126 : AND.w #$00FF : CMP.w Pool_UnderworldTransition_ScrollRoom_bounds, Y : BCC .BRANCH_GAMMA
        LDA.b $20, X
        CLC : ADC.w Pool_UnderworldTransition_ScrollRoom_camera_scroll, Y
        STA.b $20, X

    .BRANCH_GAMMA

    ; Check the scroll register mirror against the target scroll value
    LDA.b $00 : AND.w #$01FC : CMP.w $0610, Y : BNE .BRANCH_DELTA
        SEP #$20

        JSL SetAndSaveVisitedQuadrantFlags

        PLB

        INC.b $B0

        STZ.w $0126

        LDA.b $11 : CMP.b #$02 : BNE .BRANCH_EPSILON
            JSL WaterFlood_BuildOneQuadrantForVRAM

            RTS

    .BRANCH_DELTA

    PLB

    SEP #$20

    .BRANCH_EPSILON

    RTS
}

; $013E6D-$013E74 DATA
Pool_Module07_11_0A_ScrollCamera:
{
    .offset
    dw  32
    dw -64
    dw  32
    dw -32
}

; ==============================================================================

; $013E75-$013EB9 LOCAL JUMP LOCATION
StraightStairs_10:
{
    PHB : PHK : PLB

    LDA.b #$0C : STA.b $4B : STA.w $02F9

    LDA.w $0418 : ASL A : TAX

    REP #$20

    LDA.b $E8
    CLC : ADC.w Pool_UnderworldTransition_ScrollRoom_camera_scroll, X
    AND.w #$FFFC : STA.b $E8 : STA.b $E6

    AND.w #$01FC : CMP.w $0610, X : BNE .alpha
        LDY.b $11 : CPY.b #$12 : BCC .beta
            INX #4

        .beta

        LDA.b $20 : CLC : ADC.w Pool_Module07_11_0A_ScrollCamera_offset, X : STA.b $20

        SEP #$20

        STZ.b $4B
        STZ.w $02F9

        INC.b $B0

    .alpha

    SEP #$20

    PLB

    RTS
}

; ==============================================================================

; $013EBA-$013FF9 DATA
Pool_Overworld_SetCameraBounds:
{
    ; $013EBA
    .coordinate_camera_adjust
    dw $FFF8, $0008, $FFF8, $0008
    dw $FFE8, $0018, $FFD8, $0018

    ; $013ECA
    .boundary_delta
    dw $FF90, $0070, $FF90, $0070
    dw $FE00, $0200, $FE00, $0200
    dw $0018, $00E8, $0008, $00E8

    ; $013EE2
    .trans_target_north
    dw $FF20, $FF20, $FF20, $FF20, $FF20, $FF20, $FF20, $FF20
    dw $FF20, $FF20, $0120, $FF20, $FF20, $FF20, $FF20, $0120
    dw $0320, $0320, $0320, $0320, $0320, $0320, $0320, $0320
    dw $0520, $0520, $0520, $0520, $0520, $0520, $0520, $0520
    dw $0520, $0520, $0720, $0520, $0520, $0720, $0520, $0520
    dw $0920, $0920, $0920, $0920, $0920, $0920, $0920, $0920
    dw $0B20, $0B20, $0B20, $0B20, $0B20, $0B20, $0B20, $0B20
    dw $0B20, $0B20, $0D20, $0D20, $0D20, $0B20, $0B20, $0D20

    ; $013F62
    .trans_target_west
    dw $FF00, $FF00, $0300, $0500, $0500, $0900, $0900, $0D00
    dw $FF00, $FF00, $0300, $0500, $0500, $0900, $0900, $0D00
    dw $FF00, $0100, $0300, $0500, $0700, $0900, $0B00, $0D00
    dw $FF00, $FF00, $0300, $0500, $0500, $0900, $0B00, $0B00
    dw $FF00, $FF00, $0300, $0500, $0500, $0900, $0B00, $0B00
    dw $FF00, $0100, $0300, $0500, $0700, $0900, $0B00, $0D00
    dw $FF00, $FF00, $0300, $0500, $0700, $0900, $0900, $0D00
    dw $FF00, $FF00, $0300, $0500, $0700, $0900, $0900, $0D00

    ; $013FE2
    .boundary_y_size
    dw $011E, $031E

    ; $013FE6
    .boundary_x_size
    dw $0100, $0300

    ; $013FEA
    .trans_target_south_offset
    dw $02E0, $04E0

    ; $013FEE
    .trans_target_east_offset
    dw $0300, $0500

    ; $013FF2
    .camera_matters_when
    dw $001B, $001B, $001E, $001E
}

; $013FFA-$014000 LOCAL JUMP LOCATION
OverworldScrollTransition_dirty_exit:
{
    SEP #$20

    PLB

    LDX.w $0410

    RTS
}

; $014001-$0140C2 LOCAL JUMP LOCATION
; ZS rewrites part of this function. - ZS Custom Overworld
OverworldScrollTransition:
{
    PHB : PHK : PLB

    INC.w $0126

    LDA.w $0418 : ASL A : TAY

    LDX.b #$01
    CPY.b #$04 : BCS .horizScroll
        LDX.b #$00

    .horizScroll

    LDA.w Pool_Overworld_SetCameraBounds_coordinate_camera_adjust, Y
    STA.w $069E, X

    REP #$20

    PHY

    LDX.b #$00

    CPY.b #$04 : BCS .horizScroll2
        ; Affect the Y scroll offset instead
        LDX.b #$06

    .horizScroll2

    LDA.b $E2, X
    CLC : ADC.w Pool_Overworld_SetCameraBounds_coordinate_camera_adjust, Y
    STA.b $E2, X

    ; $01402D ZS writes here. - ZS Custom Overworld
    ; Hyrule Castle and Pyramid of Power have special BG1 overlays
    ; that must remain in fixed scroll position
    LDY.b $8A

    CPY.b #$1B : BEQ .dontMoveBg1
    CPY.b #$5B : BEQ .dontMoveBg1
        STA.b $E0, X

    .dontMoveBg1

    STA.b $00

    PLY

    LDX.b #$00

    CPY.b #$04 : BCC .verticalScroll
        LDX.b #$02

    .verticalScroll

    LDA.w $0126 : AND.w #$00FF
    CMP.w Pool_Overworld_SetCameraBounds_camera_matters_when, Y
    BCC .dontMoveLink
        LDA.b $20, X
        CLC : ADC.w Pool_Overworld_SetCameraBounds_coordinate_camera_adjust, Y
        STA.b $20, X

    .dontMoveLink

    ; Return
    LDA.b $00 : CMP.w $0610, Y : BNE .BRANCH_$13FFA

    LDA.w $0418 : AND.w #$00FF : BNE .notUpScroll
        LDA.b $E8 : SEC : SBC.w #$0002 : STA.b $E8

    .notUpScroll

    ; Snap Link's coordinate to an 8-pixel grid
    LDA.b $20, X : AND.w #$FFF8 : STA.b $20, X
    CLC : ADC.w Pool_Overworld_SetCameraBounds_boundary_delta, Y : PHA

    ; X = 0x00 or 0x04
    TXA : ASL A : TAX

    PLA : CLC : ADC.w #$000B : STA.w $061A, X

    INC #2 : STA.w $0618, X

    PHX

    LDX.b #$00

    LDA.w $0712 : BEQ .largeOwMap
        INX #2

    .largeOwMap

    LDA.w $0700 : CLC : ADC.w OverworldMixedCoordsChange, Y : TAY

    JSR.w Overworld_SetCameraBounds

    PLX

    STZ.w $0624, X : STZ.w $0626, X

    SEP #$20

    LDA.b #$01 : STA.w $0ABF

    LDX.w $0410

    ; Move on to next submodule.
    INC.b $11

    STZ.b $B0
    STZ.w $0126

    PLB

    LDA.b $00

    PHA : PHX

    JSL InitSpriteSlots

    PLX : PLA

    RTS
}

; Inputs:
; Y - an overworld area number * 2
; X - 0 for small map, 2 for large map
; $0140C3-$0140F7 LOCAL JUMP LOCATION
Overworld_SetCameraBounds:
{
    ; ADDs are from $013FE2-$013FF1

    LDA.w OverworldTransitionPositionY, Y
    STA.w $0600

    CLC : ADC Pool_Overworld_SetCameraBounds_boundary_y_size, X
    STA.w $0602
    
    LDA.w OverworldTransitionPositionX, Y
    STA.w $0604

    CLC : ADC Pool_Overworld_SetCameraBounds_boundary_x_size, X
    STA.w $0606

    LDA.w Pool_Overworld_SetCameraBounds_trans_target_north, Y
    STA.w $0610

    CLC : ADC Pool_Overworld_SetCameraBounds_trans_target_south_offset, X
    STA.w $0612

    LDA.w Pool_Overworld_SetCameraBounds_trans_target_west, Y
    STA.w $0614

    CLC : ADC Pool_Overworld_SetCameraBounds_trans_target_east_offset, X
    STA.w $0616

    RTS
}

; ==============================================================================

; $0140F8-$0141FB DATA
LinkLandingIndexOffset:
{
    db $00, $05, $0A, $0F
}

; $0140FC-$01410F DATA
UnderworldTransitionLandingCoordinate:
{
    db $0C, $20, $30, $38, $48
    db $D4, $D8, $C0, $C0, $A8
    db $0C, $18, $28, $30, $40
    db $E4, $D8, $C8, $C0, $B0
}

; ==============================================================================

; $014110-$01412B LOCAL JUMP LOCATION
UnderworldTransition_FindTransitionLanding:
{
    ; This routine apparently positions link after the transition has occurred?
    ; Erases special effects and resets dash status.
    JSR.w DeleteCertainAncillaeStopDashing
    JSR.w IntraroomTransitionCalculateLanding

    INC.b $B0

    REP #$30

    LDA.b $A0 : ASL A : TAX

    ; Save current quadrant status to save game buffer.
    LDA.l $7EF000, X : ORA.w $0408 : STA.l $7EF000, X

    SEP #$30

    RTS
}

; ==============================================================================

; $01412C-$014161 LOCAL JUMP LOCATION
IntraroomTransitionCalculateLanding:
{
    LDA.w $0418 : AND.b #$02

    PHA

    JSR.w CalculateTransitionLanding

    LDX.w $0418

    ; The above subroutine returns a tile type in the A register
    CMP.b #$02 : BNE .notDefault
        LDA.b #$01

    .notDefault

    CMP.b #$04 : BNE .beta
        LDA.b #$02

    .beta

    CLC : ADC.l $02C0F8, X : TAX

    LDY.b #$08

    LDA.l $02C0FC, X : BPL .positive
        LDY.b #$F8

    .positive

    ; Y = 8 or -8, depending
    STY.b $00

    SEC : SBC.b $00

    PLY

    STA.w $0020, Y

    LDX.b #$00 : STX.b $4B

    RTS
}

; =====================================================

; Transitioning.....
; $014162-$01416F LOCAL JUMP LOCATION
Module07_02_0D:
{
    LDA.l $7EC005 : ORA.l $7EC006 : BEQ .noDarkTransition
        JSL PaletteFilter.doFiltering

    .noDarkTransition

    ; Bleeds into the next function.
}

; $014170-$014190 LOCAL JUMP LOCATION
UnderworldTransition_HandleFinalMovements:
{
    JSL Link_HandleMovingAnimation_FullLongEntry

    JSR.w UnderworldTransition_MoveLinkOutDoor : BCC .BRANCH_BETA
        LDX.b $4E

        CPX.b #$02 : BEQ .BRANCH_GAMMA
        CPX.b #$04 : BNE .BRANCH_DELTA
            .BRANCH_GAMMA

            STZ.b $6C

        .BRANCH_DELTA

        STZ.b $6F
        STZ.b $49
        STZ.b $4E
        STZ.w $0418

        INC.b $B0

    .BRANCH_BETA

    RTS
}

; =====================================================

; $014191-$0141E4 LOCAL JUMP LOCATION
UnderworldTransition_MoveLinkOutDoor:
{
    LDX.w $0418

    ; Add to a multiple of 4 based on the current direction.
    LDA.b $4E : CLC : ADC.l $02C0F8, X : TAX

    LDY.b #$02

    LDA.w $0418 : LSR A : BCC .BRANCH_ALPHA
        LDY.b #$FE

    .BRANCH_ALPHA

    STY.b $00

    LSR A : BCS .BRANCH_BETA
        LDY.b #$FF

        LDA.b $00 : BMI .BRANCH_GAMMA
            INX

        .BRANCH_GAMMA

        CLC : ADC.b $20 : STA.b $20

        TYA : ADC.b $21 : STA.b $21

        LDA.b $20 : AND.b #$FE : CMP.l $02C0FC, X : BEQ .BRANCH_DELTA
            .BRANCH_ZETA

            CLC

            RTS

    .BRANCH_BETA

    LDY.b #$FF

    LDA.b $00 : BMI .BRANCH_EPSILON
        INX

    .BRANCH_EPSILON

          CLC : ADC.b $22 : STA.b $22
    TYA : ADC.b $23 : STA.b $23

    LDA.b $22 : AND.b #$FE : CMP.l $02C0FC, X : BNE .BRANCH_ZETA
        .BRANCH_DELTA

        SEC

        RTS
}

; $0141E5-$01423D LOCAL JUMP LOCATION
CalculateTransitionLanding:
{
    REP #$20

    LDA.b $20 : CLC : ADC.w #$000C : AND.w #$01F8 : ASL #3 : STA.b $00
    LDA.b $22 : CLC : ADC.w #$0008 : AND.w #$01F8 : LSR #3 : ORA.b $00

    LDX.b $EE : BEQ .onBg2
        CLC : ADC.w #$1000

    .onBg2

    REP #$10

    TAX

    ; Grab tile attribute
    LDA.l $7F2000, X

    SEP #$30

    LDY.b #$00

    CMP.b #$00 : BEQ .beta
    CMP.b #$09 : BEQ .beta
        INY ; Y = 1

        AND.b #$8E : CMP.b #$80 : BEQ .beta
            INY ; Y = 2

            CMP.b #$82 : BEQ .beta
                INY ; Y = 3

                CMP.b #$84 : BEQ .beta
                CMP.b #$88 : BEQ .beta
                    INY ; Y = 4

                    CMP.b #$86 : BEQ .beta
                        DEY #2 ; Y = 2

    .beta

    STY.b $4E

    TYA

    RTS
}

; $01423E-$014241 DATA
Pool_Overworld_FinalizeEntryOntoScreen
{
    .song_change_directions
    db $E0
    db $08
    db $E0
    db $10
}

; $014242-$0142A3 LOCAL JUMP LOCATION
Overworld_FinalizeEntryOntoScreen:
{
    JSL Link_HandleMovingAnimation_FullLongEntry

    LDY.b #$02

    LDA.w $069C : LSR A : BCS .BRANCH_ALPHA
        LDY.b #$FE

    .BRANCH_ALPHA

    STY.b $00

    LDX.b #$02

    LSR A : BCS .BRANCH_BETA
        LDX.b #$00

    .BRANCH_BETA

    LDY.b #$FF

    LDA.b $00 : BMI .BRANCH_GAMMA
        INY

    .BRANCH_GAMMA

    CLC : ADC.b $20, X : STA.b $20, X

    TYA : ADC.b $21, X : STA.b $21, X

    LDA.b $20, X

    LDX.w $069C

    AND.b #$FE : CMP.l $02C23E, X : BNE .BRANCH_DELTA
        ; Return to normal overworld operating mode
        STZ.b $11
        STZ.b $B0

        LDX.b $8A

        LDA.l $7F5B00, X : LSR #4 : STA.w $012D

        LDA.w $0130 : CMP.b #$F1 : BNE .BRANCH_DELTA
            LDA.l $7F5B00, X : AND.b #$0F : STA.w $012C

    .BRANCH_DELTA

    JSR.w Overworld_OperateCameraScroll

    LDA.w $0416 : BEQ .BRANCH_EPSILON
        JSR.w Overworld_ScrollMap

    .BRANCH_EPSILON

    RTS
}

; $0142A4-$0142E3 LOCAL JUMP LOCATION
Module09_1F:
{
    JSL Link_HandleMovingAnimation_FullLongEntry
    LDY.b #$01

    LDA.w $069C : LSR A : BCS .BRANCH_ALPHA
        LDY.b #$FF

    .BRANCH_ALPHA

    STY.b $00

    LDX.b #$02

    LSR A : BCS .BRANCH_BETA
        LDX.b #$00

    .BRANCH_BETA

    LDY.b #$FF

    LDA.b $00 : BMI .BRANCH_GAMMA
        INY

    .BRANCH_GAMMA

    CLC : ADC.b $20, X : STA.b $20, X
    TYA : ADC.b $21, X : STA.b $21, X

    TXA : LSR A : TAX

    LDA.b $00 : STA.b $30, X

    DEC.w $069A : BNE .BRANCH_DELTA
        LDA.b #$09 : STA.b $10

        STZ.b $11
        STZ.b $B0

    .BRANCH_DELTA

    JSR.w Overworld_OperateCameraScroll

    RTS
}

; ==============================================================================

; $0142E4-$0142EA LOCAL JUMP LOCATION
Overworld_ResetMosaic:
{
    ; if(($7EC007 & 0x01) == 0)
    LDA.l $7EC007 : LSR A : BCC CopyMosaicControl
        ; Bleeds into the next function.
}

; $0142EB-$0142F5 LOCAL JUMP LOCATION
MosaicControlIncrease:
{
    LDA.l $7EC011 : CLC : ADC.b #$10 : STA.l $7EC011

    ; Bleeds into the next function.
}

; $0142F6-$014302 LOCAL JUMP LOCATION
CopyMosaicControl:
{
    ; The purpose of this is ensure that the priority bit is set
    LDA.b #$09 : STA.b $94

    ; Enable mosaic on BG1, BG2, and BG3 and set the mosaic level to 0 (for startsrs)
    LDA.l $7EC011 : ORA.b #$07 : STA.b $95

    RTS
}

; ==============================================================================

; $014303-$014462 DATA
; Overworld music map
Overworld_SetSongList_Pool:
{
    ; $014303
    .LWMap
    db $05, $05, $03, $03, $03, $03, $03, $03
    db $05, $05, $03, $03, $03, $03, $03, $03
    db $03, $03, $13, $13, $13, $03, $03, $03
    db $03, $03, $13, $13, $13, $03, $03, $03
    db $03, $03, $13, $13, $13, $03, $03, $03
    db $03, $03, $13, $13, $13, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03

    ; $014343
    db $55, $55, $02, $52, $52, $52, $52, $52
    db $55, $55, $02, $52, $52, $52, $52, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $07, $07, $02, $02, $02, $02, $02, $02
    db $07, $07, $07, $02, $02, $02, $02, $02
    db $07, $07, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02

    ; $014383
    db $52, $52, $02, $52, $52, $52, $52, $52
    db $52, $52, $02, $52, $52, $52, $52, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $07, $07, $02, $02, $02, $02, $02, $02
    db $07, $07, $07, $02, $02, $02, $02, $02
    db $07, $07, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02

    ; $0143C3
    db $52, $52, $02, $52, $52, $52, $52, $52
    db $52, $52, $02, $52, $52, $52, $52, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $52, $52, $02, $02, $02, $02, $02, $02
    db $52, $52, $02, $02, $02, $02, $02, $02

    ; $014403
    .DWMap
    db $9D, $9D, $09, $9D, $9D, $9D, $9D, $9D
    db $9D, $9D, $09, $9D, $9D, $9D, $9D, $09
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $05, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $12
}
; ==============================================================================

; $014463-$0144BF LONG JUMP LOCATION
Overworld_SetSongList:
{
    ; Interesting note on this routine:
    ; There's actually four sets of song / sound effect data
    ; 1st - before getting Fighter Sword
    ; 2nd - after escaping with Zelda
    ; 3rd - after obtaining Master Sword
    ; 4th - after beating Agahnim

    PHB : PHK : PLB

    REP #$10

    LDA.b #$02 : STA.b $00

    LDX.w #$0000
    LDY.w #$00C0

    ; See if we've already beaten agahnim.
    LDA.l $7EF3C5 : CMP.b #$03 : BCS .writeLightWorldSongs
        LDY.b #$0080

        ; See if we have the mastersword.
        LDA.l $7EF359 : CMP.b #$02 : BCS .writeLightWorldSongs
            LDA.b #$05 : STA.b $00

            LDY.w #$0040

            ; See if we have gotten out of the rain phase.
            LDA.l $7EF3C5 : CMP.b #$02 : BCS .writeLightWorldSongs
                LDY.w #$0000

    .writeLightWorldSongs

    ; Load the LW music based on the state of the game.
    .lightWorldLoop
        LDA.w Overworld_SetSongList_Pool_LWMap, Y : STA.l $7F5B00, X

        INY

    INX : CPX.w #$0040 : BNE .lightWorldLoop

    LDY.w #$0000

    ; Load the DW and SW music.
    .darkWorldLoop
        LDA.w Overworld_SetSongList_Pool_DWMap, Y : STA.l $7F5B00, X

        INX

    INY : CPY.w #$0060 : BNE .darkWorldLoop

    ; The song for the master sword grove depends on $7EF3C5 in the same
    ; way the other light world songs do.
    LDA.b $00 : STA.l $7F5B80

    SEP #$10

    PLB

    RTL
}

; ==============================================================================

; $0144C0-$0144FF NULL
NULL_02C4C0:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; $014500-$014532 LOCAL JUMP LOCATION
Intro_InitBgSettings:
{
    ; Setini variable. No interlacing and such.
    STZ.w $2133

    ; Give BG1 priority, and we're in mode 1.
    LDA.b #$09 : STA.b $94

    ; No mosaic effect.
    STZ.b $95

    ; BG1 Tile map begins at $800 in VRAM. Tile map is 64x64.
    LDA.b #$13 : STA.w $2107

    ; BG2 Tile map begins at $0 in VRAM. Tile map is 64x64.
    LDA.b #$03 : STA.w $2108

    ; BG3 Tile map begins at $6000 in VRAM. Tile map is 64x64.
    LDA.b #$63 : STA.w $2109

    ; BG1 Character Data is at $4000 in VRAM. Same for BG2
    LDA.b #$22 : STA.w $210B

    ; BG3 Character Data is at $E000 in VRAM. BG4 is at $0
    ; Note: BG4 is never used in the game
    LDA.b #$07 : STA.w $210C

    ; Means that only the backdrop will be participating in color addition
    ; currently.
    LDA.b #$20 : STA.b $9A

    ; Set fixed color to neutral (no fixed color)
    LDA.b #$20 : STA.b $9C
    LDA.b #$40 : STA.b $9D
    LDA.b #$80 : STA.b $9E

    RTS
}

; ==============================================================================

; Loads an entrance
; $014533-$014545 LONG JUMP LOCATION
Attract_LoadDungeonRoom:
{
    STA.w $010E

    JSR.w Dungeon_LoadEntrance

    STZ.w $045A : STZ.w $0458

    JSR.w Dungeon_LoadAndDrawRoom
    JSR.w Dungeon_ResetTorchBackgroundAndPlayer

    RTL
}

; ==============================================================================

; $014546-$01457A LONG JUMP LOCATION
Attract_LoadDungeonGfxAndTiles:
{
    STX.w $0AA3
    STA.w $0AA1
    STA.w $0AA2

    JSL InitTilesets

    LDA.b #$02 : STA.w $0AA9

    INC.b $15

    JSL Palette_BgAndFixedColor
    ; $01455E ALTERNATE ENTRY POINT
    .justPalettes

    JSL Palette_SpriteAux3
    JSL Palette_MainSpr
    JSL Palette_SpriteAux1
    JSL Palette_SpriteAux2
    JSL Palette_MiscSpr_justSp6
    JSL Palette_Hud
    JSL Palette_DungBgMain

    RTL
}

; ==============================================================================

; $01457B-$0145B1 LOCAL JUMP LOCATION
Dungeon_LoadAndDrawRoom:
{
    ; Calls routines that 1. Load the room's header.
    ; 2. Load dungeon objects into a temporary tile map
    ; Then this function writes those into a tile map

    LDA.b $9B : PHA

    STZ.w $420C
    STZ.b $9B

    JSL Dungeon_LoadRoom

    STZ.w $0418
    STZ.w $045C
    STZ.w $0200

    .next_quadrant

        ; Draws the dungeons.
        JSL TilemapPrep_NotWaterOnTag

        ; Since we are in forced v-blank.
        JSL NMI_UploadTilemap_long 

        ; We can do these DMA transfers.
        JSL Dungeon_PrepareNextRoomQuadrantUpload

        JSL NMI_UploadTilemap_long

        ; Each iteration draws a quadrant on BG1 and BG2
        ; i.e. it draws the tilemaps, which are taken from WRAM.
    LDA.w $045C : CMP.b #$10 : BNE .next_quadrant

    PLA : STA.b $9B

    STZ.b $17
    STZ.w $0200
    STZ.b $B0

    RTS
}

; ==============================================================================

; $0145B2-$01462F LOCAL JUMP LOCATION
Intro_LoadPalettes:
{
    REP #$20

    LDX.b #$00

    LDA.w #$0000

    .zeroOutPalettes

        ; Zeroes out $7EC480-$7EC6FF
        STA.l $7EC480, X : STA.l $7EC500, X
        STA.l $7EC580, X : STA.l $7EC600, X
        STA.l $7EC680, X
    INX #2 : CPX.b #$80 : BNE .zeroOutPalettes

    SEP #$20

    LDA.b #$05 : STA.w $0AB3

    LDA.b #$03 : STA.w $0AB4 : STA.w $0AB5

    LDA.b #$00 : STA.w $0AB8
    LDA.b #$05 : STA.w $0AB1
    LDA.b #$0B : STA.w $0AAC

    STZ.w $0ABD
    STZ.w $0AA9

    JSL Palette_BgAndFixedColor
    JSL Palette_SpriteAux3
    JSL Palette_MainSpr
    JSL Palette_OverworldBgMain
    JSL Palette_OverworldBgAux1
    JSL Palette_OverworldBgAux2
    JSL Palette_OverworldBgAux3
    JSL Palette_MiscSpr_justSp6
    JSL Palette_Hud

    REP #$20

    LDX.b #$00

    .copyHalfPalette

        ; Copies $7EC4D0-8 -> $7EC6B0-8
        LDA.l $7EC4D0, X : STA.l $7EC6B0, X
    INX #2 : CPX.b #$10 : BNE .copyHalfPalette

    SEP #$20

    RTS
}

; ==============================================================================

; Loads dungeon palettes
; $014630-$01465E LOCAL JUMP LOCATION
Dungeon_LoadPalettes:
{
    STZ.w $0AA9

    JSL Palette_BgAndFixedColor
    JSL Palette_SpriteAux3
    JSL Palette_MainSpr
    JSL Palette_SpriteAux1
    JSL Palette_SpriteAux2
    JSL Palette_Sword
    JSL Palette_Shield
    JSL Palette_MiscSpr
    JSL Palette_ArmorAndGloves
    JSL Palette_Hud
    JSL Palette_DungBgMain

    ; Bleeds into the next function.
}

; $01465F-$01468D LOCAL JUMP LOCATION
Overworld_CopyPalettesToCache_WithPrep:
{
    ; This alternate entry point can be used for the pre-overworld module.

    LDA.w $0AB6 : STA.l $7EC20A
    LDA.w $0AB8 : STA.l $7EC20B
    LDA.w $0AB7 : STA.l $7EC20C

    REP #$20

    LDA.w #$0002 : STA.l $7EC009
    LDA.w #$0000 : STA.l $7EC007
    LDA.w #$0000 : STA.l $7EC00B

    JMP Overworld_CgramAuxToMain
}

; ==============================================================================

; UNUSED: Perhaps was used at one time, but not in the final build.
; $01468E-$014691 LONG JUMP LOCATION
Overworld_LoadAreaPalettesLong:
{
    JSR.w Overworld_LoadAreaPalettes

    RTL
}

; ==============================================================================

; ZS rewrites this whole function. - ZS Custom Overworld
; $014692-$0146EA LOCAL JUMP LOCATION
Overworld_LoadAreaPalettes:
{
    ; Loads overworld palettes (based upon area and world, mainly)
    LDX.b #$02

    ; Checks for 6 specific areas in the light world (death mountain LW & DW)
    LDA.b $8A : AND.b #$3F

    CMP.b #$03 : BEQ .deathMountain
    CMP.b #$05 : BEQ .deathMountain
    CMP.b #$07 : BEQ .deathMountain
        ; Use a different index if we're not on death mountain
        LDX.b #$00

    .deathMountain

    LDA.b $8A : AND.b #$40 : BEQ .lightWorld
        ; Adjust for the dark world / light world difference
        INX

    .lightWorld

    ; $0146AD ALTERNATE ENTRY POINT
    .preloaded
    
    ; $0AB3 = 0 - LW
    ;         1 - DW
    ;         2 - LW death mountain
    ;         3 - DW death mountain
    ;         4 - triforce room
    STX.w $0AB3

    STZ.w $0AA9

    ; Load SP1 through SP4.
    JSL Palette_MainSpr

    ; Load SP0 (2nd half) and SP6 (2nd half).
    JSL Palette_MiscSpr

    ; Load SP5 (1st half).
    JSL Palette_SpriteAux1

    ; Load SP6 (1st half).
    JSL Palette_SpriteAux2

    ; Load SP5 (2nd half, 1st 3 colors), which is the sword palette.
    JSL Palette_Sword

    ; Load SP5 (2nd half, next 4 colors), which is the shield.
    JSL Palette_Shield

    ; Load SP7 (full) Link's whole palette, including Armor.
    JSL Palette_ArmorAndGloves

    LDX.b #$01

    LDA.l $7EF3CA : AND.b #$40 : BEQ .lightWorld2
        LDX.b #$03

    .lightWorld2

    STX.w $0AAC

    ; Load SP0 (first half) (or SP7 (first half))
    JSL Palette_SpriteAux3

    ; Load BP0 and BP1 (first halves)
    JSL Palette_Hud

    ; Load BP2 through BP5 (first halves)
    JSL Palette_OverworldBgMain

    RTS
}

; ==============================================================================

; $0146EB-$014768 LOCAL JUMP LOCATION
SpecialOverworld_CopyPalettesToCache:
{
    REP #$20

    LDX.b #$00
    LDA.w #$0000

    .zero4bppPalettes

        STA.l $7EC540, X : STA.l $7EC580, X : STA.l $7EC5C0, X : STA.l $7EC600, X
        STA.l $7EC640, X : STA.l $7EC680, X : STA.l $7EC6C0, X
    INX #2 : CPX.b #$40 : BNE .zero4bppPalettes

    LDX.b #$00

    .copyFromAuxPalette

        ; Looks like it copies all the hud palettes (2bpp) and two sprite
        ; palettes (4bpp).
        LDA.l $7EC300, X : STA.l $7EC500, X
        LDA.l $7EC310, X : STA.l $7EC510, X
        LDA.l $7EC320, X : STA.l $7EC520, X
        LDA.l $7EC330, X : STA.l $7EC530, X
        LDA.l $7EC4B0, X : STA.l $7EC6B0, X
        LDA.l $7EC4D0, X : STA.l $7EC6D0, X
        LDA.l $7EC4E0, X : STA.l $7EC6E0, X
        LDA.l $7EC4F0, X : STA.l $7EC6F0, X
    INX #2 : CPX.b #$10 : BNE .copyFromAuxPalette

    SEP #$20

    ; Set mosaic settings to full.
    LDA.b #$F7 : STA.b $95 : STA.l $7EC011

    ; Tell the game to update CGRAM this frame.
    INC.b $15

    RTS
}

; ==============================================================================

; $014769-$0147B7 LOCAL JUMP LOCATION
Overworld_CgramAuxToMain:
{
    ; Copies the auxiliary CGRAM buffer to the main one and causes NMI to
    ; reupload the palette.

    REP #$20

    LDX.b #$00

    .loop

        LDA.l $7EC300, X : STA.l $7EC500, X
        LDA.l $7EC340, X : STA.l $7EC540, X
        LDA.l $7EC380, X : STA.l $7EC580, X
        LDA.l $7EC3C0, X : STA.l $7EC5C0, X
        LDA.l $7EC400, X : STA.l $7EC600, X
        LDA.l $7EC440, X : STA.l $7EC640, X
        LDA.l $7EC480, X : STA.l $7EC680, X
        LDA.l $7EC4C0, X : STA.l $7EC6C0, X
    INX #2 : CPX.b #$40 : BNE .loop

    SEP #$20

    ; Tell NMI to upload new CGRAM data.
    INC.b $15

    RTS
}

; ==============================================================================

; Seems mode7 related... (hdma for mode 7 manipulation, I mean).
; $0147B8-$0147F1 LONG JUMP LOCATION
CleanUpAndPrepDesertPrayerHDMA:
{
    PHB : PHK : PLB

    ; Set up this channel we'll be using for hdma (spotlight?).
    LDX.b #$04

    .configure_dma_channel

        LDA.w Pool_CleanUpAndPrepDesertPrayerHDMA_hdma_props, X
        STA.w $4370, X
    DEX : BPL .configure_dma_channel

    LDA.b #$00 : STA.w $4377

    LDA.b #$33 : STA.b $96
    LDA.b #$03 : STA.b $97
    LDA.b #$33 : STA.b $98

    LDA.b $1C : STA.b $1E
    LDA.b $1D : STA.b $1F

    LDA.b #$80 : STA.b $9B

    ; OPTIMIZING: Would be faster with 16-bit zeroing.
    REP #$10

    LDX.w #$01DF

    .zeroing_spotlight_buffer

        STZ.w $1B00, X
    DEX : BPL .zeroing_spotlight_buffer

    SEP #$10

    PLB

    RTL
}

; ==============================================================================

; UNUSED: (not totally verified yet) kan agrees though.
; $0147F2-$0158B2 DATA TABLE
UNUSED_$02C7F2
{
    ; Seems to be unreferenced data, but what is interesting is it appears to
    ; be some sort of .... disabled hdma table (note the presence of $1B00 and
    ; $1BF0 in this data) this information appears to be unused in the final
    ; product.
    .unused_hdma_data
    db $01 : dw $FF00 ; 1 line
    db $01 : dw $FF00 ; 1 line
    db $01 : dw $FF00 ; 1 line
    db $01 : dw $FF00 ; 1 line
    db $81 : dw $0000 ; 1 line continuous
    db $00 ; End

    .unused_hdma_props
    db $01 ; Direct transfer, 2 registers write once
    db $26
    dl $001B00 ; Table location
}

; $014807-$014812 DATA TABLE
Pool_CleanUpAndPrepDesertPrayerHDMA:
{
    .hdma_props
    db $41 ; Indirect transfer, 2 registers write once
    db $26
    dl .indirect_table

    .indirect_table
    db $F8 : dw $1B00 ; 120 lines, continuous
    db $F8 : dw $1BF0 ; 120 lines, continuous
    db $00 ; End
}

; ==============================================================================

; $014813-$0158B2 DATA
EntranceData:
{
    ; $014813
    .rooms
    dw $0104, $0104, $0012, $0060, $0061, $0062, $00F0, $00F1
    dw $00C9, $0084, $0085, $0083, $0063, $00F2, $00F3, $00F4
    dw $00F5, $00E3, $00E2, $00F8, $00E8, $0023, $00FB, $00EB
    dw $00D5, $0024, $00FD, $00ED, $00FE, $00EE, $00FF, $00EF
    dw $00DF, $00F9, $00FA, $00EA, $00E0, $0028, $004A, $0098
    dw $0056, $0057, $0058, $0059, $00E1, $000E, $00E6, $00E7
    dw $00E4, $00E5, $0055, $0077, $00DB, $00D6, $0010, $000C
    dw $0008, $002F, $003C, $002C, $0100, $011E, $0101, $0101
    dw $0102, $0117, $0103, $0103, $0103, $0105, $011F, $0106
    dw $0106, $0107, $0107, $0108, $0109, $010A, $010B, $010C
    dw $010C, $011B, $011B, $011C, $011C, $011E, $0120, $0110
    dw $0112, $0111, $0112, $0113, $0114, $0115, $0115, $010D
    dw $010F, $0119, $0114, $0116, $0121, $0122, $0122, $0118
    dw $011A, $010E, $010E, $011F, $0123, $0124, $0124, $0125
    dw $0125, $0126, $0126, $0080, $0051, $0030, $0058, $0067
    dw $0068, $0056, $00E1, $0000, $0018, $0055, $00E3, $00E2
    dw $002F, $0011, $0003, $0127, $0120
    
    ; $01491D
    .relativeCoords0
    db $21

    ; $01491E
    .relativeCoords1
    db $20

    ; $01491F
    .relativeCoords2
    db $21

    ; $014920
    .relativeCoords3
    db $21

    ; $014921
    .relativeCoords4
    db $09

    ; $014922
    .relativeCoords5
    db $09

    ; $014923
    .relativeCoords6
    db $09

    ; $014924
    .relativeCoords7
    db $0A

    db $21, $20, $21, $21, $09, $09, $09, $0A
    db $03, $02, $03, $03, $04, $04, $04, $05
    db $0D, $0C, $0D, $0D, $01, $00, $01, $01
    db $0D, $0C, $0D, $0D, $02, $02, $02, $03
    db $0D, $0C, $0D, $0D, $04, $04, $04, $05
    db $1F, $1E, $1F, $1F, $00, $00, $00, $01
    db $1F, $1E, $1F, $1F, $03, $02, $03, $03
    db $19, $18, $19, $19, $12, $12, $12, $13
    db $11, $10, $11, $11, $08, $08, $08, $09
    db $11, $10, $11, $11, $0B, $0A, $0B, $0B
    db $11, $10, $11, $11, $06, $06, $06, $07
    db $0D, $0C, $0D, $0D, $06, $06, $06, $07
    db $1F, $1E, $1F, $1F, $05, $05, $05, $06
    db $1F, $1E, $1F, $1F, $06, $06, $06, $07
    db $1F, $1E, $1F, $1F, $09, $09, $09, $0A
    db $1F, $1E, $1F, $1F, $0A, $0A, $0A, $0B
    db $1D, $1C, $1D, $1D, $06, $06, $06, $07
    db $1D, $1C, $1D, $1D, $05, $04, $05, $05
    db $1F, $1E, $1F, $1F, $10, $10, $10, $11
    db $1D, $1C, $1D, $1D, $11, $10, $11, $11
    db $05, $04, $05, $05, $07, $06, $07, $07
    db $1F, $1E, $1F, $1F, $16, $16, $16, $17
    db $1D, $1C, $1D, $1D, $17, $16, $17, $17
    db $1B, $1A, $1B, $1B, $0A, $0A, $0A, $0B
    db $05, $04, $05, $05, $09, $08, $09, $09
    db $1F, $1E, $1F, $1F, $1A, $1A, $1A, $1B
    db $1D, $1C, $1D, $1D, $1A, $1A, $1A, $1B
    db $1F, $1E, $1F, $1F, $1D, $1D, $1D, $1E
    db $1D, $1C, $1D, $1D, $1D, $1C, $1D, $1D
    db $1F, $1E, $1F, $1F, $1F, $1E, $1F, $1F
    db $1D, $1C, $1D, $1D, $1E, $1E, $1E, $1F
    db $1B, $1A, $1B, $1B, $1E, $1E, $1E, $1F
    db $1F, $1E, $1F, $1F, $12, $12, $12, $13
    db $1F, $1E, $1F, $1F, $14, $14, $14, $15
    db $1D, $1C, $1D, $1D, $14, $14, $14, $15
    db $1D, $1C, $1D, $1D, $00, $00, $00, $01
    db $05, $04, $05, $05, $10, $10, $10, $11
    db $09, $08, $09, $09, $14, $14, $14, $15
    db $13, $12, $13, $13, $10, $10, $10, $11
    db $0B, $0A, $0B, $0B, $0C, $0C, $0C, $0D
    db $0B, $0A, $0B, $0B, $0E, $0E, $0E, $0F
    db $0B, $0A, $0B, $0B, $10, $10, $10, $11
    db $0B, $0A, $0B, $0B, $12, $12, $12, $13
    db $1D, $1C, $1D, $1D, $02, $02, $02, $03
    db $01, $00, $01, $01, $1D, $1C, $1D, $1D
    db $1D, $1C, $1D, $1D, $0C, $0C, $0C, $0D
    db $1D, $1C, $1D, $1D, $0F, $0E, $0F, $0F
    db $1D, $1C, $1D, $1D, $08, $08, $08, $09
    db $1D, $1C, $1D, $1D, $0A, $0A, $0A, $0B
    db $0B, $0A, $0B, $0B, $0A, $0A, $0A, $0B
    db $0F, $0E, $0F, $0F, $0E, $0E, $0E, $0F
    db $1B, $1A, $1B, $1B, $16, $16, $16, $17
    db $1B, $1A, $1B, $1B, $0D, $0C, $0D, $0D
    db $03, $02, $03, $03, $00, $00, $00, $01
    db $01, $00, $01, $01, $18, $18, $18, $19
    db $01, $00, $01, $01, $11, $10, $11, $11
    db $05, $04, $05, $05, $1F, $1E, $1F, $1F
    db $07, $06, $07, $07, $19, $18, $19, $19
    db $05, $04, $05, $05, $18, $18, $18, $19
    db $21, $20, $21, $21, $00, $00, $00, $01
    db $23, $22, $23, $23, $1D, $1D, $1D, $1E
    db $21, $20, $21, $21, $02, $02, $02, $03
    db $21, $20, $21, $21, $03, $03, $03, $04
    db $21, $20, $21, $21, $04, $04, $04, $05
    db $23, $22, $23, $23, $0F, $0E, $0F, $0F
    db $21, $20, $21, $21, $06, $06, $06, $07
    db $21, $20, $21, $21, $06, $06, $06, $07
    db $21, $20, $21, $21, $07, $07, $07, $08
    db $21, $20, $21, $21, $0A, $0A, $0A, $0B
    db $23, $22, $23, $23, $1F, $1F, $1F, $20
    db $21, $20, $21, $21, $0C, $0C, $0C, $0D
    db $21, $20, $21, $21, $0D, $0D, $0D, $0E
    db $21, $20, $21, $21, $0E, $0E, $0E, $0F
    db $21, $20, $21, $21, $0F, $0F, $0F, $10
    db $21, $20, $21, $21, $10, $10, $10, $11
    db $21, $20, $21, $21, $12, $12, $12, $13
    db $21, $20, $21, $21, $14, $14, $14, $15
    db $21, $20, $21, $21, $16, $16, $16, $17
    db $21, $20, $21, $21, $18, $18, $18, $19
    db $21, $20, $21, $21, $19, $19, $19, $1A
    db $23, $22, $23, $23, $16, $16, $16, $17
    db $23, $22, $23, $23, $17, $17, $17, $18
    db $23, $22, $23, $23, $18, $18, $18, $19
    db $23, $22, $23, $23, $19, $19, $19, $19
    db $23, $22, $23, $23, $1C, $1C, $1C, $1D
    db $25, $24, $25, $25, $01, $00, $01, $01
    db $23, $22, $23, $23, $00, $00, $00, $01
    db $23, $22, $23, $23, $05, $05, $05, $06
    db $23, $22, $23, $23, $02, $02, $02, $03
    db $23, $22, $23, $23, $04, $04, $04, $05
    db $23, $22, $23, $23, $06, $06, $06, $07
    db $23, $22, $23, $23, $08, $08, $08, $09
    db $23, $22, $23, $23, $0A, $0A, $0A, $0B
    db $23, $22, $23, $23, $0B, $0B, $0B, $0C
    db $21, $20, $21, $21, $1A, $1A, $1A, $1B
    db $21, $20, $21, $21, $1E, $1E, $1E, $1F
    db $23, $22, $23, $23, $12, $12, $12, $13
    db $23, $22, $23, $23, $09, $09, $09, $0A
    db $23, $22, $23, $23, $0D, $0D, $0D, $0E
    db $25, $24, $25, $25, $02, $02, $02, $03
    db $25, $24, $25, $25, $04, $04, $04, $05
    db $25, $24, $25, $25, $05, $05, $05, $06
    db $23, $22, $23, $23, $11, $11, $11, $12
    db $23, $22, $23, $23, $15, $15, $15, $16
    db $21, $20, $21, $21, $1C, $1C, $1C, $1D
    db $21, $20, $21, $21, $1D, $1D, $1D, $1E
    db $23, $22, $23, $23, $1E, $1E, $1E, $1F
    db $25, $24, $25, $25, $06, $06, $06, $07
    db $25, $24, $25, $25, $08, $08, $08, $09
    db $25, $24, $25, $25, $09, $09, $09, $0A
    db $25, $24, $25, $25, $0A, $0A, $0A, $0B
    db $25, $24, $25, $25, $0B, $0B, $0B, $0C
    db $25, $24, $25, $25, $0C, $0C, $0C, $0D
    db $25, $24, $25, $25, $0D, $0D, $0D, $0E
    db $10, $10, $10, $11, $01, $00, $01, $01
    db $0B, $0A, $0B, $0B, $02, $02, $02, $03
    db $06, $06, $06, $07, $00, $00, $00, $01
    db $0A, $0A, $0A, $0B, $11, $10, $11, $11
    db $0C, $0C, $0C, $0D, $0E, $0E, $0E, $0F
    db $0C, $0C, $0C, $0D, $11, $10, $11, $11
    db $0A, $0A, $0A, $0B, $0D, $0C, $0D, $0D
    db $1C, $1C, $1C, $1D, $03, $02, $03, $03
    db $00, $00, $00, $01, $01, $00, $01, $01
    db $03, $02, $03, $03, $10, $10, $10, $11
    db $0A, $0A, $0A, $0B, $0B, $0A, $0B, $0B
    db $1D, $1C, $1D, $1D, $07, $06, $07, $07
    db $1D, $1C, $1D, $1D, $04, $04, $04, $05
    db $05, $04, $05, $05, $1E, $1E, $1E, $1F
    db $03, $02, $03, $03, $03, $02, $03, $03
    db $01, $00, $01, $01, $06, $06, $06, $07
    db $25, $24, $25, $25, $0E, $0E, $0E, $0F
    db $25, $24, $25, $25, $00, $00, $00, $01
    
    ; $014D45
    .scrollX
    dw $0900, $0900, $0480, $0100, $0280, $0400, $0000, $0300
    dw $1280, $0880, $0B00, $0600, $0600, $0500, $0600, $0900
    dw $0A00, $0600, $0500, $1080, $1100, $0700, $1680, $1700
    dw $0A00, $0900, $1A80, $1B00, $1D00, $1D00, $1F00, $1E80
    dw $1E80, $1200, $1400, $1400, $0000, $1080, $1480, $1000
    dw $0C00, $0E00, $1000, $1200, $0200, $1D00, $0C00, $0F00
    dw $0800, $0A80, $0A00, $0E80, $1680, $0D00, $0000, $1880
    dw $1100, $1F00, $1900, $1800, $0000, $1D00, $0200, $0300
    dw $0400, $0F00, $0600, $0600, $0700, $0A00, $1F00, $0C00
    dw $0D00, $0E00, $0F00, $1000, $1200, $1400, $1680, $1800
    dw $1900, $1600, $1700, $1800, $1900, $1C00, $0100, $0000
    dw $0500, $0200, $0400, $0600, $0800, $0A00, $0B00, $1A00
    dw $1E00, $1280, $0900, $0D00, $0200, $0400, $0500, $1100
    dw $1500, $1C00, $1D00, $1E00, $0600, $0800, $0900, $0A00
    dw $0B00, $0C00, $0D00, $0100, $0280, $0000, $1100, $0E00
    dw $1088, $0D00, $0300, $0100, $1000, $0B00, $0700, $0400
    dw $1E00, $0300, $0600, $0E00, $0000
    
    ; $014E4F
    .scrollY
    dw $2110, $2110, $0310, $0D10, $0D10, $0D10, $1F10, $1F10
    dw $1910, $1110, $1110, $1110, $0D10, $1F10, $1F10, $1F10
    dw $1F10, $1D10, $1D10, $1F10, $1D10, $0510, $1F10, $1D10
    dw $1B10, $0510, $1F10, $1D10, $1F10, $1D10, $1F10, $1D10
    dw $1B10, $1F10, $1F10, $1D10, $1D10, $0510, $0910, $1310
    dw $0B10, $0B10, $0B10, $0B10, $1D10, $0110, $1D10, $1D10
    dw $1D10, $1D10, $0B10, $0F10, $1B10, $1B10, $0310, $0110
    dw $0110, $0510, $0710, $0510, $2110, $2310, $2110, $2110
    dw $2110, $2310, $2110, $2000, $2110, $2110, $2310, $2110
    dw $2110, $2110, $2110, $2110, $2110, $2110, $2110, $2110
    dw $2110, $2310, $2310, $2310, $2310, $2310, $2510, $2310
    dw $2310, $2310, $2310, $2310, $2310, $2310, $2310, $2110
    dw $2110, $2310, $2310, $2310, $2510, $2510, $2510, $2310
    dw $2310, $2110, $2110, $2310, $2510, $2510, $2510, $2510
    dw $2510, $2510, $2510, $1010, $0B10, $0610, $0A00, $0C00
    dw $0C29, $0A00, $1C3D, $0010, $02CE, $0A10, $1D10, $1D10
    dw $0510, $02AD, $0110, $2510, $2510
    
    ; $014F59
    .playerY
    dw $2178, $21D8, $03C0, $0DD8, $0DC0, $0DD8, $1FD8, $1FC0
    dw $19D8, $11D8, $11D8, $11D8, $0DD8, $1FD8, $1FD8, $1FD8
    dw $1FD8, $1DD8, $1DD8, $1FD8, $1DD8, $05D8, $1FD8, $1DD8
    dw $1BD8, $05D8, $1FC0, $1DD8, $1FC0, $1DD8, $1FD8, $1DD8
    dw $1BD8, $1FD8, $1FC0, $1DD8, $1DD8, $05D8, $09D8, $13D8
    dw $0BD8, $0BD8, $0BD8, $0BD8, $1DD8, $01D8, $1DC0, $1DC0
    dw $1DC0, $1DD8, $0BD8, $0FC0, $1BD8, $1BD8, $03D8, $01D8
    dw $01D8, $05D8, $07D8, $05D8, $21D8, $23D8, $21D8, $21D8
    dw $21D8, $23D8, $21D8, $2020, $21D8, $21D8, $23D8, $21D8
    dw $21D8, $21D8, $21D8, $21D8, $21D8, $21C0, $21D8, $21D8
    dw $21D8, $23C0, $23D8, $23D8, $23D8, $23D8, $25D8, $23D8
    dw $23D8, $23D8, $23D8, $23D8, $23D8, $23D8, $23D8, $21D8
    dw $21D8, $23D8, $23D8, $23D8, $25D8, $25D8, $25D8, $23D8
    dw $23D8, $21C0, $21C0, $23D8, $25D8, $25D8, $25D8, $25D8
    dw $25D8, $25D8, $25D8, $1080, $0BA8, $0698, $0A69, $0C68
    dw $0C96, $0A68, $1CA9, $0089, $033B, $0A96, $1D7D, $1D89
    dw $0589, $031A, $0197, $25D8, $25D8

    ; $015063
    .playerX
    dw $0978, $0978, $04F8, $0178, $02F8, $0478, $0078, $0378
    dw $12F8, $08F8, $0B78, $0678, $0678, $0578, $0678, $0978
    dw $0A78, $0678, $0578, $10F8, $1178, $0778, $16F8, $1778
    dw $0A78, $0978, $1AF8, $1B78, $1D78, $1D78, $1F78, $1EF8
    dw $1EF8, $1278, $1478, $1478, $0078, $10F8, $14F8, $1078
    dw $0C78, $0E78, $1078, $1278, $0278, $1D78, $0C78, $0F78
    dw $0878, $0AF8, $0A78, $0EF8, $16F8, $0D78, $0078, $18F8
    dw $1178, $1F78, $1978, $1878, $0078, $1D78, $0278, $0378
    dw $0478, $0F78, $0678, $0678, $0778, $0A78, $1F78, $0C78
    dw $0D78, $0E78, $0F78, $1078, $1278, $1478, $16F8, $1878
    dw $1978, $1678, $1778, $1878, $1978, $1C78, $0178, $0078
    dw $0578, $0278, $0478, $0678, $0878, $0A78, $0B78, $1A78
    dw $1E78, $12F8, $0978, $0D78, $0278, $0478, $0578, $1178
    dw $1578, $1C78, $1D78, $1E78, $0678, $0878, $0978, $0A78
    dw $0B78, $0C78, $0D78, $01A8, $02F8, $0078, $1190, $0E80
    dw $1100, $0D40, $0370, $017F, $1073, $0B9F, $0778, $047F
    dw $1E61, $0393, $0677, $0E78, $0078
    
    ; $01516D
    .cameraY
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0074, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0187, $0187, $0187, $0187, $0187
    dw $0187, $0187, $0187, $0088, $0188, $0088, $0077, $0078
    dw $00A1, $0077, $00B4, $0088, $0146, $0088, $0188, $0187
    dw $0187, $0125, $0188, $0187, $0187
    
    ; $015277
    .cameraX
    dw $017F, $017F, $00FF, $017F, $00FF, $007F, $007F, $017F
    dw $00FF, $00FF, $017F, $007F, $007F, $017F, $007F, $017F
    dw $007F, $007F, $017F, $00FF, $017F, $017F, $00FF, $017F
    dw $007F, $017F, $00FF, $017F, $017F, $017F, $017F, $00FF
    dw $00FF, $007F, $007F, $007F, $007F, $00FF, $00FF, $007F
    dw $007F, $007F, $007F, $007F, $007F, $017F, $007F, $017F
    dw $007F, $00FF, $007F, $00FF, $00FF, $017F, $007F, $00FF
    dw $017F, $017F, $017F, $007F, $007F, $017F, $007F, $017F
    dw $007F, $017F, $007F, $007F, $017F, $007F, $017F, $007F
    dw $017F, $007F, $017F, $007F, $007F, $007F, $00FF, $007F
    dw $017F, $007F, $017F, $007F, $017F, $007F, $017F, $007F
    dw $017F, $007F, $007F, $007F, $007F, $007F, $017F, $007F
    dw $007F, $00FF, $017F, $017F, $007F, $007F, $017F, $017F
    dw $017F, $007F, $017F, $007F, $007F, $007F, $017F, $007F
    dw $017F, $007F, $017F, $017F, $00FF, $007F, $017F, $007F
    dw $0107, $017F, $017F, $017F, $007F, $017F, $017F, $007F
    dw $007F, $017F, $007F, $007F, $007F

    ; $015381
    .mainGraphics
    db $03, $03, $04, $04, $04, $04, $06, $06
    db $05, $12, $12, $12, $12, $03, $03, $03
    db $03, $06, $06, $06, $06, $0D, $06, $06
    db $0D, $0D, $06, $06, $06, $06, $06, $06
    db $06, $06, $06, $06, $04, $08, $07, $0C
    db $09, $09, $09, $09, $06, $0B, $06, $06
    db $14, $14, $01, $05, $0A, $0D, $13, $0E
    db $06, $06, $06, $06, $03, $06, $03, $03
    db $03, $14, $03, $03, $03, $0F, $03, $03
    db $03, $03, $03, $03, $03, $06, $08, $06
    db $06, $06, $06, $03, $03, $06, $06, $03
    db $14, $11, $14, $01, $06, $06, $06, $08
    db $03, $0A, $06, $12, $11, $11, $11, $03
    db $0F, $14, $14, $03, $06, $06, $06, $06
    db $06, $06, $06, $01, $04, $02, $09, $09
    db $09, $09, $06, $13, $06, $01, $06, $06
    db $06, $01, $06, $06, $06

    ; $015406
    .startingFloor
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $FF, $FF, $00, $01, $FF, $00, $01
    db $FE, $FF, $00, $01, $00, $01, $FF, $00
    db $01, $00, $00, $01, $01, $00, $00, $00
    db $FF, $FF, $FF, $FF, $FF, $00, $00, $00
    db $00, $00, $FF, $01, $FF, $00, $00, $01
    db $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $01, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $00, $00
    
    ; $01548B
    .palace
    db $FF, $FF, $00, $02, $02, $02, $FF, $FF
    db $04, $06, $06, $06, $06, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $18, $FF, $FF
    db $18, $18, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $08, $0A, $0C, $0E
    db $10, $10, $10, $10, $FF, $12, $FF, $FF
    db $FF, $FF, $FF, $14, $16, $18, $FF, $1A
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $10, $10
    db $10, $10, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $00, $FF, $FF, $FF

    ; $015510
    .doorwayOrientation
    db $00, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $01, $01
    
    ; $015595
    .startingBg
    db $00, $00, $01, $00, $01, $00, $00, $01
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $01, $00, $01, $00, $00, $00
    db $00, $00, $11, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $01, $01
    db $01, $00, $00, $11, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $01, $00, $00
    db $00, $11, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $01, $01, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $11, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $11, $01
    db $00, $00, $00, $00, $00
    
    ; $01561A
    .quadrant1
    db $00, $00, $22, $02, $22, $22, $22, $22
    db $20, $22, $00, $00, $00, $00, $00, $00
    db $00, $00, $02, $22, $22, $00, $22, $02
    db $02, $00, $22, $22, $02, $22, $20, $20
    db $20, $22, $22, $22, $00, $22, $20, $20
    db $00, $00, $00, $02, $02, $00, $22, $22
    db $02, $22, $20, $22, $22, $02, $02, $22
    db $00, $20, $22, $00, $00, $00, $00, $00
    db $00, $22, $02, $02, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $02, $20, $00
    db $02, $00, $00, $00, $00, $02, $00, $00
    db $00, $00, $02, $02, $00, $02, $00, $02
    db $00, $20, $00, $00, $00, $00, $00, $00
    db $00, $02, $02, $00, $00, $00, $00, $00
    db $00, $00, $00, $20, $22, $00, $02, $02
    db $22, $02, $02, $00, $02, $20, $00, $02
    db $20, $02, $00, $00, $00
    
    ; $01569F
    .quadrant2
    db $02, $02, $02, $12, $02, $02, $02, $12
    db $02, $02, $12, $02, $02, $12, $02, $12
    db $02, $02, $12, $02, $12, $12, $02, $12
    db $02, $12, $02, $12, $02, $12, $12, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $12, $02, $12
    db $02, $02, $02, $02, $02, $12, $02, $02
    db $12, $12, $12, $02, $02, $12, $02, $02
    db $02, $12, $02, $00, $02, $02, $12, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $12, $02, $12, $02
    db $12, $02, $02, $02, $02, $02, $12, $02
    db $02, $02, $12, $12, $02, $02, $12, $12
    db $12, $02, $12, $02, $02, $02, $12, $02
    db $12, $02, $12, $10, $02, $00, $10, $00
    db $10, $10, $10, $10, $02, $10, $12, $02
    db $02, $12, $02, $02, $02
    
    ; $015724
    .doorSettings
    dw $0816, $0816, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $05CC, $05D4, $0BB6
    dw $0B86, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0DE8, $0B98
    dw $14CE, $0000, $1C50, $FFFF, $1466, $0000, $1AB6, $0B98
    dw $1AB6, $040E, $9C0C, $1530, $0A98, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0816, $0DE8, $0000, $0000, $0AA8
    dw $0000, $09AC, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $041A, $0000, $091E, $09AC
    dw $0000, $0000, $0000, $07AA, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000
    
    ; $01582E
    .musicTrack
    db $FF, $07, $14, $10, $10, $10, $12, $12
    db $11, $11, $11, $11, $11, $F2, $F2, $F2
    db $F2, $18, $1B, $12, $12, $16, $12, $12
    db $16, $16, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $10, $16, $16, $16
    db $16, $16, $16, $16, $18, $16, $12, $12
    db $12, $12, $03, $11, $16, $16, $1C, $16
    db $1B, $12, $12, $12, $0E, $12, $F2, $F2
    db $F2, $12, $F2, $F2, $F2, $18, $17, $0E
    db $F2, $F2, $F2, $F2, $F2, $18, $18, $12
    db $12, $18, $18, $F2, $F2, $1B, $1B, $17
    db $12, $0E, $12, $18, $18, $18, $1B, $12
    db $17, $F2, $12, $18, $F2, $17, $17, $0E
    db $18, $12, $12, $F2, $12, $12, $12, $12
    db $12, $1B, $12, $FF, $FF, $FF, $16, $16
    db $16, $16, $18, $15, $1B, $03, $18, $1B
    db $12, $10, $12, $12, $1B
}

; ==============================================================================

; Routine initializes dungeons
; $0158B3-$015B6D LOCAL JUMP LOCATION
Dungeon_LoadEntrance:
{
    PHB : PHK : PLB

    ; Link is officially in a dungeon now.
    LDA.b #$01 : STA.b $1B

    ; Did Link just die and he's being respawned in this dungeon?
    LDA.w $010A : BEQ .notDeathReload
        STZ.w $010A

        ; If Link died in this dungeon, presumably all these variables are
        ; still cached anyway.
        JMP .skipCaching

    .notDeathReload

    REP #$20

    LDA.w $040A : STA.l $7EC140 ; Mirror the aux overworld area number.

    LDA.b $1C   : STA.l $7EC142 ; Mirror the main screen designation.

    LDA.b $E8   : STA.l $7EC144 ; Mirror BG1 V scroll.
    LDA.b $E2   : STA.l $7EC146 ; Mirror BG1 H scroll.

    LDA.b $20   : STA.l $7EC148 ; Mirror Link's Y coordinate.
    LDA.b $22   : STA.l $7EC14A ; Mirror Link's X coordinate.

    LDA.w $0618 : STA.l $7EC150 ; Mirror Camera Y coord lower bound.
    LDA.w $061C : STA.l $7EC152 ; Mirror Camera X coord lower bound.

    LDA.b $8A   : STA.l $7EC14C ; Mirror the overworld area number.

    LDA.b $84   : STA.l $7EC14E ; Not sure about this one.

    STZ.b $8A
    STZ.b $8C

    LDA.w $0600 : STA.l $7EC154
    LDA.w $0602 : STA.l $7EC156
    LDA.w $0604 : STA.l $7EC158
    LDA.w $0606 : STA.l $7EC15A

    LDA.w $0610 : STA.l $7EC15C
    LDA.w $0612 : STA.l $7EC15E
    LDA.w $0614 : STA.l $7EC160
    LDA.w $0616 : STA.l $7EC162

    LDA.w $0624 : STA.l $7EC16A
    LDA.w $0626 : STA.l $7EC16C
    LDA.w $0628 : STA.l $7EC16E
    LDA.w $062A : STA.l $7EC170

    SEP #$20

    ; Cache graphics settings.
    LDA.w $0AA0 : STA.l $7EC164
    LDA.w $0AA1 : STA.l $7EC165
    LDA.w $0AA2 : STA.l $7EC166
    LDA.w $0AA3 : STA.l $7EC167

    REP #$30

    .skipCaching

    STZ.w $011A : STZ.w $011C : STZ.w $010A

    ; Check which character is following Link. Check if it's the old man
    ; Yep, must use an entrance.
    LDA.l $7EF3CC : CMP.w #$0004 : BEQ .useStartingPointEntrance
        LDA.w $04AA : BEQ .notSaveAndContinue

    .useStartingPointEntrance

    ; Load using an starting point entrance index instead.
    JMP Dungeon_LoadStartingPoint

    .notSaveAndContinue

    ; Use a normal entrance instead.
    LDA.w $010E : AND.w #$00FF : ASL A : TAX : ASL #2 : TAY

    LDA.w EntranceData_rooms, X
    STA.b $A0 : STA.w $048E

    LDA.w EntranceData_scrollY, X
    STA.b $E8 : STA.b $E6 : STA.w $0122 : STA.w $0124

    LDA.w EntranceData_scrollX, X
    STA.b $E2 : STA.b $E0 : STA.w $011E : STA.w $0120

    ; Has Link woken up yet?
    LDA.l $7EF3C5 : BEQ .beforeUncleGear
        LDA.w EntranceData_playerY, X : STA.b $20
        LDA.w EntranceData_playerX, X : STA.b $22

    .beforeUncleGear

    LDA.w EntranceData_cameraY, X : STA.w $0618 : INC #2 : STA.w $061A
    LDA.w EntranceData_cameraX, X : STA.w $061C : INC #2 : STA.w $061E

    LDA.w #$01F8 : STA.b $EC

    LDA.w EntranceData_doorSettings, X : STA.w $0696 : STZ.w $0698

    LDA.w #$0000 : STA.w $0610
    LDA.w #$0110 : STA.w $0612
    LDA.w #$0000 : STA.w $0614
    LDA.w #$0100 : STA.w $0616

    LDA.w $010E : AND.w #$00FF : TAX

    SEP #$20

    ; HM calls these scroll edges. Must investigate.
    LDA.w EntranceData_relativeCoords0, Y : STA.w $0601
    LDA.w EntranceData_relativeCoords1, Y : STA.w $0603
    LDA.w EntranceData_relativeCoords2, Y : STA.w $0605
    LDA.w EntranceData_relativeCoords3, Y : STA.w $0607
    LDA.w EntranceData_relativeCoords4, Y : STA.w $0609
    LDA.w EntranceData_relativeCoords5, Y : STA.w $060B
    LDA.w EntranceData_relativeCoords6, Y : STA.w $060D
    LDA.w EntranceData_relativeCoords7, Y : STA.w $060F

    STZ.w $0600 : STZ.w $0602

    LDA.b #$10
    STA.w $0604 : STA.w $0606 : STA.w $0608
    STA.w $060A : STA.w $060C : STA.w $060E

    ; Make it so Link faces south (down) at most entrances.
    LDA.b #$02

    CPX.w #$0000 : BEQ .linkFacesSouth
        ; One special cases where Link enters from the top. Potential for an
        ; edit here.
        CPX.w #$0043 : BEQ .linkFacesSouth
            LDA.b #$00 ; Make it so Link faces north.

    .linkFacesSouth

    STA.b $2F

    ; Main blockset value
    LDA.w EntranceData_mainGraphics, X : STA.w $0AA1

    ; Music value. Is it the beginning music?
    LDA.w EntranceData_musicTrack, X : STA.w $0132
    CMP.b #$03 : BNE .notBeginningMusic
        ; Check game status
        ; Is it less than first part?
        LDA.l $7EF3C5 : CMP.b #$02 : BCC .haventSavedZelda
            ; Play the cave music if it's first or second part.
            LDA.b #$12

        .haventSavedZelda

        STA.w $0132

    .notBeginningMusic

    LDA.w EntranceData_startingFloor, X : STA.b $A4

    ; Load the palace number.
    LDA.w EntranceData_palace, X : STA.w $040C

    ; Interestingly enough, this could allow for horizontal doorways?
    LDA.w EntranceData_doorwayOrientation, X : STA.b $6C

    ; Set the position that Link starts at.
    LDA.w EntranceData_startingBg, X : LSR #4 : STA.b $EE

    ; Set Pseudo bg level
    LDA.w EntranceData_startingBg, X : AND.b #$0F : STA.w $0476

    LDA.w EntranceData_quadrant1, X : LSR #4     : STA.b $A6
    LDA.w EntranceData_quadrant1, X : AND.b #$0F : STA.b $A7
    LDA.w EntranceData_quadrant2, X : LSR #4     : STA.b $A9
    LDA.w EntranceData_quadrant2, X : AND.b #$0F : STA.b $AA

    LDX.b $A0 : CPX.w #$0100 : BCC .notExtendedRoom
        ; Rooms above room 255 apparently can't have multiple floors?
        ; Probably because they can't utilize exits
        STZ.b $A4

    ; $015ADB ALTERNATE ENTRY POINT
    .notExtendedRoom

    LDA.b #$80 : STA.b $45 : STA.b $44

    LDA.b #$0F : STA.b $42 : STA.b $43

    LDA.b #$FF : STA.b $24 : STA.b $29

    SEP #$30

    PLB

    ; Make 0x7E the data bank.
    PHB : LDA.b #$7E : PHA : PLB

    REP #$20

    LDX.b #$00

    .loadPushBlocks

        ; Note that we are now storing data in bank $7E.
        ; Hence this goes to $7EF940, X
        LDA.l $04F1DE, X : STA.w $F940, X
        LDA.l $04F25E, X : STA.w $F9C0, X
        LDA.l $04F2DE, X : STA.w $FA40, X
        LDA.l $04F35E, X : STA.w $FAC0, X
        LDA.l $04F36A, X : STA.w $FB40, X
        LDA.l $04F3EA, X : STA.w $FBC0, X
        LDA.l $04F46A, X : STA.w $FC40, X
    INX #2 : CPX.b #$80 : BNE .loadPushBlocks

    LDX.b #$3E
    LDA.w #$0000

    .resetSecretsObtained

        ; $7EF580[0x280] is an array that stores which "secret" items have been
        ; obtained while you're in a dungeon. This is resetting those (either
        ; via mirror or reentry to the dungeon world)
        STA.w $F800, X : STA.w $F840, X : STA.w $F880, X : STA.w $F8C0, X
        STA.w $F580, X : STA.w $F5C0, X : STA.w $F600, X : STA.w $F640, X
        STA.w $F680, X : STA.w $F6C0, X : STA.w $F700, X : STA.w $F740, X
        STA.w $F780, X : STA.w $F7C0, X
    DEX #2 : BPL .resetSecretsObtained

    ; Initial orange/blue barrier state is orange down, blue up (0)
    STA.l $7EC172

    STZ.w $04BC

    SEP #$30

    PLB

    RTS
}

; $015B6E-$015C54 DATA
SpawnPointData:
{
    .rooms ; Writes to $A0, $048E
    dw $0104 ; 0x00 - Link's house - ROOM 0104
    dw $0012 ; 0x01 - Sanctuary    - ROOM 0012
    dw $0080 ; 0x02 - Prison       - ROOM 0080
    dw $0055 ; 0x03 - Uncle        - ROOM 0055
    dw $0051 ; 0x04 - Throne       - ROOM 0051
    dw $00F0 ; 0x05 - Old man cave - ROOM 00F0
    dw $00E4 ; 0x06 - Old man home - ROOM 00E4

    ; 0x00 - Link's house
    ; $015B7C To $0600
    .relativeCoords_0 
    db $21

    ; $015B7D
    .relativeCoords_1
    db $20

    ; $015B7E
    .relativeCoords_2
    db $21

    ; $015B7F
    .relativeCoords_3
    db $21

    ; $015B80
    .relativeCoords_4
    db $09

    ; $015B81
    .relativeCoords_5
    db $09

    ; $015B82
    .relativeCoords_6
    db $09

    ; $015B83
    .relativeCoords_7
    db $0A 

    ; +$1, +$3, +$5, +$7, +$9, +$B, +$D, +$F
    db $02, $02, $02, $03, $04, $04, $04, $05 ; 0x01 - Sanctuary
    db $10, $10, $10, $11, $01, $00, $01, $01 ; 0x02 - Prison
    db $0A, $0A, $0A, $0B, $0B, $0A, $0B, $0B ; 0x03 - Uncle
    db $0A, $0A, $0A, $0B, $02, $02, $02, $03 ; 0x04 - Throne
    db $1E, $1E, $1E, $1F, $01, $00, $01, $01 ; 0x05 - Old man cave
    db $1D, $1C, $1D, $1D, $08, $08, $08, $09 ; 0x06 - Old man hom

    ; $015BB4
    .scrollX
    dw $0900, $0480, $00DB, $0A8E, $0280, $0100, $0800

    ; $015BC2
    .scrollY
    dw $2110, $0231, $1000, $0A03, $0A22, $1E8C, $1D10

    ; $015BD0
    .linkY
    dw $0978, $04F8, $0160, $0B06, $02F8, $01A8, $0878

    ; $015BDE
    .linkX
    dw $2178, $029C, $1041, $0A70, $0A8F, $1EF8, $1D98

    ; $015BEC
    .cameraY
    dw $017F, $00FF, $0167, $010D, $00FF, $017F, $007F

    ; $015BFA
    .cameraX
    dw $017F, $00A7, $0083, $007B, $009A, $0103, $0187

    ; $015C08
    .mainGraphics
    db $03, $04, $04, $01, $04, $06, $14

    ; $015C0F
    .startingFloor
    db $00, $00, $FD, $FF, $01, $00, $00

    ; $015C16
    .palace
    db $FF, $00, $02, $FF, $02, $FF, $FF

    ; $015C1D
    .startingBg
    db $00, $00, $00, $01, $00, $00, $01

    ; $015C24
    .quadrant1
    db $00, $22, $20, $20, $22, $22, $02

    ; $015C2B
    .quadrant2
    db $02, $00, $10, $10, $00, $10, $02

    ; $015C32
    .doorSettings
    dw $0816, $0000, $0000, $0000, $0000, $0000, $0000

    ; $015C40
    .associatedEntrance
    dw $0000, $0002, $0002, $0032, $0004, $0006, $0030

    ; $015C4E
    .song
    db $07, $14, $10, $03, $10, $12, $12
}

; $015C55-$015D89 LOCAL JUMP LOCATION
Dungeon_LoadStartingPoint:
{
    ; An SRAM value that tells us what starting location to use?
    LDA.l $7EF3C8 : AND.w #$00FF : ASL A : TAX : ASL #2 : TAY

    ; Set the entrance
    LDA.w SpawnPointData_entrance_id, X : STA.w $010E

    ; Load the dungeon room index
    LDA.w SpawnPointData_room_id, X : STA.b $A0 : STA.w $048E

    ; Load Camera Y and X coordinates
    LDA.w SpawnPointData_vertical_scroll, X
    STA.b $E8 : STA.b $E6 : STA.w $0122 : STA.w $0124

    LDA.w SpawnPointData_horizontal_scroll, X
    STA.b $E2 : STA.b $E0 : STA.w $011E : STA.w $0120

    ; You goin' to bed!
    LDA.l $7EF3C5 : BEQ .veryBeginning
        ; Set Link's Y and X coordinates
        LDA.w SpawnPointData_y_coordinate, X : STA.b $20
        LDA.w SpawnPointData_x_coordinate, X : STA.b $22

    .veryBeginning

    ; Set camera scroll bounds
    LDA.w SpawnPointData_camera_trigger_y, X : STA.w $0618
    INC #2 : STA.w $061A
    LDA.w SpawnPointData_camera_trigger_x, X : STA.w $061C
    INC #2 : STA.w $061E

    ; Set coordinate mask
    LDA.w #$01F8 : STA.b $EC

    ; Load the door settings (for use when exiting)
    LDA.w SpawnPointData_overworld_door_tilemap, X : STA.w $0696

    ; Scroll bounds for intraroom and interroom transitions
    LDA.w #$0000 : STA.w $0610
    LDA.w #$0110 : STA.w $0612
    LDA.w #$0000 : STA.w $0614
    LDA.w #$0100 : STA.w $0616

    LDA.l $7EF3C8 : AND.w #$00FF : TAX

    SEP #$20

    ; Set a bunch of quadrant bounds
    ; SpawnPointData_camera_scroll_bounds, Y
    LDA.w SpawnPointData_relativeCoords_0, Y : STA.w $0601
    LDA.w SpawnPointData_relativeCoords_1, Y : STA.w $0603
    LDA.w SpawnPointData_relativeCoords_2, Y : STA.w $0605
    LDA.w SpawnPointData_relativeCoords_3, Y : STA.w $0607
    LDA.w SpawnPointData_relativeCoords_4, Y : STA.w $0609
    LDA.w SpawnPointData_relativeCoords_5, Y : STA.w $060B
    LDA.w SpawnPointData_relativeCoords_6, Y : STA.w $060D
    LDA.w SpawnPointData_relativeCoords_7, Y : STA.w $060F

    STZ.w $0600 : STZ.w $0602

    LDA.b #$10
    STA.w $0604 : STA.w $0606 : STA.w $0608
    STA.w $060A : STA.w $060C : STA.w $060E

    ; Make Link face south
    LDA.b #$02 : STA.b $2F

    ; Set main bg graphics
    LDA.w SpawnPointData_main_GFX, X : STA.w $0AA1

    ; Set starting floor
    LDA.w SpawnPointData_floor, X : STA.b $A4

    ; Set palace Link is in, if any
    LDA.w SpawnPointData_dungeon_id, X : STA.w $040C

    ; Start off by not being in a doorway
    STZ.b $6C

    ; Set starting floor level for Link (BG2 or BG1)
    LDA.w SpawnPointData_layer, X : LSR #4 : STA.b $EE

    ; Set starting speudo bg level
    LDA.w SpawnPointData_startingBg, X : AND.w #$0F : STA.w $0476

    ; Set quadrant information
    LDA.w SpawnPointData_camera_scroll_controller, X : LSR #4     : STA.b $A6
    LDA.w SpawnPointData_camera_scroll_controller, X : AND.b #$0F : STA.b $A7
    LDA.w SpawnPointData_quadrant, X :                 LSR #4     : STA.b $A9
    LDA.w SpawnPointData_quadrant, X :                 AND.b #$0F : STA.b $AA

    ; Set musicical number to play
    LDA.w SpawnPointData_song, X : STA.w $0132

    CPX.w #$0000 : BNE .notVeryStart
        LDA.l $7EF3C5 : BNE .notVeryStart
            ; Set music variable as to... initiate a load of music data?
            LDA.b #$FF : STA.w $0132

    .notVeryStart

    ; Disable starting point now (upon save and continue you'll use the
    ; associated entrance value).
    STZ.w $04AA

    JMP Dungeon_LoadEntrance_notExtendedRoom
}

; ==============================================================================

; $015D8A-$015E82 LOCAL DATA
UnderworldExitData:
{
    ; Something to do with overworld overlay data?
    ; In SePH's notes it mentions the first ahganim transport

    ; $015D8A
    .room_id
    dw $0104 ; 0x00
    dw $0012 ; 0x01
    dw $0060 ; 0x02
    dw $0061 ; 0x03
    dw $0062 ; 0x04
    dw $FFFF ; 0x05
    dw $0020 ; 0x06
    dw $00F0 ; 0x07
    dw $00F1 ; 0x08
    dw $00C9 ; 0x09
    dw $0084 ; 0x0A
    dw $0085 ; 0x0B
    dw $0083 ; 0x0C
    dw $0063 ; 0x0D
    dw $00F2 ; 0x0E
    dw $00F3 ; 0x0F
    dw $00F4 ; 0x10
    dw $00F5 ; 0x11
    dw $00E3 ; 0x12
    dw $00E2 ; 0x13
    dw $00F8 ; 0x14
    dw $00E8 ; 0x15
    dw $0023 ; 0x16
    dw $00FB ; 0x17
    dw $00EB ; 0x18
    dw $00D5 ; 0x19
    dw $0024 ; 0x1A
    dw $00FD ; 0x1B
    dw $00ED ; 0x1C
    dw $00FE ; 0x1D
    dw $00EE ; 0x1E
    dw $00FF ; 0x1F
    dw $00EF ; 0x20
    dw $00DF ; 0x21
    dw $00F9 ; 0x22
    dw $00FA ; 0x23
    dw $00EA ; 0x24
    dw $00E0 ; 0x25
    dw $0028 ; 0x26
    dw $004A ; 0x27
    dw $0098 ; 0x28
    dw $0056 ; 0x29
    dw $0057 ; 0x2A
    dw $0058 ; 0x2B
    dw $0059 ; 0x2C
    dw $0077 ; 0x2D
    dw $000E ; 0x2E
    dw $00E6 ; 0x2F
    dw $00E7 ; 0x30
    dw $00E4 ; 0x31
    dw $00E5 ; 0x32
    dw $0055 ; 0x33
    dw $00D6 ; 0x34
    dw $00DB ; 0x35
    dw $00E1 ; 0x36
    dw $0010 ; 0x37
    dw $000C ; 0x38
    dw $0008 ; 0x39
    dw $002F ; 0x3A
    dw $003C ; 0x3B
    dw $002C ; 0x3C
    dw $0003 ; 0x3D
    dw $1000 ; 0x3E
    dw $1002 ; 0x3F
    dw $1004 ; 0x40
    dw $1006 ; 0x41
    dw $1008 ; 0x42
    dw $100A ; 0x43
    dw $100C ; 0x44
    dw $100E ; 0x45
    dw $1010 ; 0x46
    dw $1012 ; 0x47
    dw $1014 ; 0x48
    dw $1016 ; 0x49
    dw $1018 ; 0x4A
    dw $0180 ; 0x4B
    dw $0181 ; 0x4C
    dw $0182 ; 0x4D
    dw $0189 ; 0x4E

    ; $015E28
    .overworld_id
    db $2C ; 0x00
    db $13 ; 0x01
    db $1B ; 0x02
    db $1B ; 0x03
    db $1B ; 0x04
    db $0F ; 0x05
    db $5B ; 0x06
    db $0A ; 0x07
    db $03 ; 0x08
    db $1E ; 0x09
    db $30 ; 0x0A
    db $30 ; 0x0B
    db $30 ; 0x0C
    db $30 ; 0x0D
    db $18 ; 0x0E
    db $18 ; 0x0F
    db $28 ; 0x10
    db $29 ; 0x11
    db $22 ; 0x12
    db $02 ; 0x13
    db $45 ; 0x14
    db $45 ; 0x15
    db $45 ; 0x16
    db $4A ; 0x17
    db $4A ; 0x18
    db $45 ; 0x19
    db $45 ; 0x1A
    db $05 ; 0x1B
    db $05 ; 0x1C
    db $05 ; 0x1D
    db $05 ; 0x1E
    db $05 ; 0x1F
    db $05 ; 0x20
    db $05 ; 0x21
    db $03 ; 0x22
    db $03 ; 0x23
    db $03 ; 0x24
    db $1B ; 0x25
    db $7B ; 0x26
    db $5E ; 0x27
    db $70 ; 0x28
    db $40 ; 0x29
    db $40 ; 0x2A
    db $40 ; 0x2B
    db $40 ; 0x2C
    db $03 ; 0x2D
    db $75 ; 0x2E
    db $0A ; 0x2F
    db $03 ; 0x30
    db $03 ; 0x31
    db $03 ; 0x32
    db $1B ; 0x33
    db $47 ; 0x34
    db $58 ; 0x35
    db $00 ; 0x36
    db $5B ; 0x37
    db $43 ; 0x38
    db $15 ; 0x39
    db $18 ; 0x3A
    db $45 ; 0x3B
    db $45 ; 0x3C
    db $2C ; 0x3D
    db $1B ; 0x3E
    db $18 ; 0x3F
    db $03 ; 0x40
    db $2C ; 0x41
    db $05 ; 0x42
    db $02 ; 0x43
    db $1E ; 0x44
    db $18 ; 0x45
    db $81 ; 0x46
    db $30 ; 0x47
    db $16 ; 0x48
    db $2A ; 0x49
    db $00 ; 0x4A
    db $80 ; 0x4B
    db $80 ; 0x4C
    db $81 ; 0x4D
    db $88 ; 0x4E

    ; $015E77
    .exit_vram_addr
    dw $0506 ; 0x00
    dw $001C ; 0x01
    dw $0016 ; 0x02
    dw $0530 ; 0x03
    dw $004A ; 0x04
    dw $001C ; 0x05
    dw $002E ; 0x06
    dw $03A0 ; 0x07
    dw $1402 ; 0x08
    dw $005A ; 0x09
    dw $0314 ; 0x0A
    dw $02A8 ; 0x0B
    dw $0280 ; 0x0C
    dw $0016 ; 0x0D
    dw $02BC ; 0x0E
    dw $02C4 ; 0x0F
    dw $08A0 ; 0x10
    dw $0880 ; 0x11
    dw $0412 ; 0x12
    dw $0118 ; 0x13
    dw $0EE0 ; 0x14
    dw $0460 ; 0x15
    dw $07CA ; 0x16
    dw $03A0 ; 0x17
    dw $00A0 ; 0x18
    dw $0AD4 ; 0x19
    dw $07E0 ; 0x1A
    dw $0DD4 ; 0x1B
    dw $0AD4 ; 0x1C
    dw $0CCA ; 0x1D
    dw $07C8 ; 0x1E
    dw $0EE0 ; 0x1F
    dw $17E0 ; 0x20
    dw $0460 ; 0x21
    dw $0D9C ; 0x22
    dw $0EAC ; 0x23
    dw $092C ; 0x24
    dw $0032 ; 0x25
    dw $049E ; 0x26
    dw $005A ; 0x27
    dw $0414 ; 0x28
    dw $0C8E ; 0x29
    dw $0EB8 ; 0x2A
    dw $0F4C ; 0x2B
    dw $0282 ; 0x2C
    dw $0050 ; 0x2D
    dw $0BC6 ; 0x2E
    dw $00A0 ; 0x2F
    dw $0D82 ; 0x30
    dw $181A ; 0x31
    dw $10C6 ; 0x32
    dw $044A ; 0x33
    dw $0712 ; 0x34
    dw $0B2E ; 0x35
    dw $0F4E ; 0x36
    dw $0B0E ; 0x37
    dw $0052 ; 0x38
    dw $0088 ; 0x39
    dw $0386 ; 0x3A
    dw $04DA ; 0x3B
    dw $004C ; 0x3C
    dw $0506 ; 0x3D
    dw $1230 ; 0x3E
    dw $0448 ; 0x3F
    dw $0050 ; 0x40
    dw $009A ; 0x41
    dw $034E ; 0x42
    dw $049A ; 0x43
    dw $07C0 ; 0x44
    dw $1100 ; 0x45
    dw $0040 ; 0x46
    dw $0916 ; 0x47
    dw $000A ; 0x48
    dw $0910 ; 0x49
    dw $0A3A ; 0x4A
    dw $0000 ; 0x4B
    dw $0020 ; 0x4C
    dw $1782 ; 0x4D
    dw $0000 ; 0x4E

    ; $015F15
    .vertical_scroll
    dw $0A9A ; 0x00
    dw $0400 ; 0x01
    dw $0600 ; 0x02
    dw $0692 ; 0x03
    dw $0600 ; 0x04
    dw $0200 ; 0x05
    dw $0600 ; 0x06
    dw $0264 ; 0x07
    dw $0294 ; 0x08
    dw $0600 ; 0x09
    dw $0C56 ; 0x0A
    dw $0C4A ; 0x0B
    dw $0C46 ; 0x0C
    dw $0C00 ; 0x0D
    dw $064C ; 0x0E
    dw $064A ; 0x0F
    dw $0B06 ; 0x10
    dw $0B07 ; 0x11
    dw $087A ; 0x12
    dw $0015 ; 0x13
    dw $01E4 ; 0x14
    dw $0093 ; 0x15
    dw $0103 ; 0x16
    dw $0263 ; 0x17
    dw $020A ; 0x18
    dw $0164 ; 0x19
    dw $0103 ; 0x1A
    dw $01C4 ; 0x1B
    dw $0163 ; 0x1C
    dw $01A3 ; 0x1D
    dw $0108 ; 0x1E
    dw $01E3 ; 0x1F
    dw $0304 ; 0x20
    dw $0093 ; 0x21
    dw $01C3 ; 0x22
    dw $01E3 ; 0x23
    dw $0133 ; 0x24
    dw $0600 ; 0x25
    dw $0E8C ; 0x26
    dw $0600 ; 0x27
    dw $0C79 ; 0x28
    dw $01A6 ; 0x29
    dw $01E6 ; 0x2A
    dw $01F6 ; 0x2B
    dw $0066 ; 0x2C
    dw $0014 ; 0x2D
    dw $0D6A ; 0x2E
    dw $0205 ; 0x2F
    dw $01C4 ; 0x30
    dw $031E ; 0x31
    dw $0224 ; 0x32
    dw $067A ; 0x33
    dw $00DA ; 0x34
    dw $075A ; 0x35
    dw $01F6 ; 0x36
    dw $075A ; 0x37
    dw $0000 ; 0x38
    dw $0400 ; 0x39
    dw $0665 ; 0x3A
    dw $00A3 ; 0x3B
    dw $0000 ; 0x3C
    dw $0A9A ; 0x3D
    dw $0842 ; 0x3E
    dw $0674 ; 0x3F
    dw $0000 ; 0x40
    dw $0A0B ; 0x41
    dw $005C ; 0x42
    dw $0089 ; 0x43
    dw $06E4 ; 0x44
    dw $0826 ; 0x45
    dw $0010 ; 0x46
    dw $0D20 ; 0x47
    dw $0400 ; 0x48
    dw $0B1E ; 0x49
    dw $016A ; 0x4A
    dw $0120 ; 0x4B
    dw $0000 ; 0x4C
    dw $0320 ; 0x4D
    dw $0000 ; 0x4E

    ; $015FB3
    .horizontal_scroll
    dw $0832 ; 0x00
    dw $06DE ; 0x01
    dw $06AE ; 0x02
    dw $0784 ; 0x03
    dw $0856 ; 0x04
    dw $0EE2 ; 0x05
    dw $0778 ; 0x06
    dw $0500 ; 0x07
    dw $0604 ; 0x08
    dw $0ED6 ; 0x09
    dw $00A6 ; 0x0A
    dw $0142 ; 0x0B
    dw $0003 ; 0x0C
    dw $00A2 ; 0x0D
    dw $01E2 ; 0x0E
    dw $0222 ; 0x0F
    dw $0100 ; 0x10
    dw $0200 ; 0x11
    dw $048E ; 0x12
    dw $04C6 ; 0x13
    dw $0D00 ; 0x14
    dw $0D00 ; 0x15
    dw $0C46 ; 0x16
    dw $0500 ; 0x17
    dw $0500 ; 0x18
    dw $0CA6 ; 0x19
    dw $0D00 ; 0x1A
    dw $0CA6 ; 0x1B
    dw $0CA6 ; 0x1C
    dw $0C56 ; 0x1D
    dw $0C46 ; 0x1E
    dw $0D00 ; 0x1F
    dw $0D00 ; 0x20
    dw $0D00 ; 0x21
    dw $06D4 ; 0x22
    dw $0754 ; 0x23
    dw $0754 ; 0x24
    dw $0784 ; 0x25
    dw $06F2 ; 0x26
    dw $0ED6 ; 0x27
    dw $00A6 ; 0x28
    dw $0062 ; 0x29
    dw $01C2 ; 0x2A
    dw $0262 ; 0x2B
    dw $0016 ; 0x2C
    dw $087C ; 0x2D
    dw $0C3E ; 0x2E
    dw $0500 ; 0x2F
    dw $0600 ; 0x30
    dw $06B4 ; 0x31
    dw $0814 ; 0x32
    dw $0854 ; 0x33
    dw $0E96 ; 0x34
    dw $0176 ; 0x35
    dw $0262 ; 0x36
    dw $0674 ; 0x37
    dw $0884 ; 0x38
    dw $0A36 ; 0x39
    dw $0032 ; 0x3A
    dw $0CD6 ; 0x3B
    dw $0C56 ; 0x3C
    dw $0832 ; 0x3D
    dw $077F ; 0x3E
    dw $024B ; 0x3F
    dw $0878 ; 0x40
    dw $08D7 ; 0x41
    dw $0C6D ; 0x42
    dw $04CF ; 0x43
    dw $0DFE ; 0x44
    dw $0001 ; 0x45
    dw $0401 ; 0x46
    dw $00AA ; 0x47
    dw $0C57 ; 0x48
    dw $0478 ; 0x49
    dw $01CF ; 0x4A
    dw $0000 ; 0x4B
    dw $0100 ; 0x4C
    dw $021E ; 0x4D
    dw $0000 ; 0x4E

    ; $016051
    .y_coordinate
    dw $0AE8 ; 0x00
    dw $0414 ; 0x01
    dw $0604 ; 0x02
    dw $06CC ; 0x03
    dw $0604 ; 0x04
    dw $0203 ; 0x05
    dw $065C ; 0x06
    dw $02B8 ; 0x07
    dw $02E8 ; 0x08
    dw $0618 ; 0x09
    dw $0CA8 ; 0x0A
    dw $0C98 ; 0x0B
    dw $0C98 ; 0x0C
    dw $0C28 ; 0x0D
    dw $0698 ; 0x0E
    dw $0698 ; 0x0F
    dw $0B58 ; 0x10
    dw $0B58 ; 0x11
    dw $08C8 ; 0x12
    dw $0067 ; 0x13
    dw $0238 ; 0x14
    dw $00E7 ; 0x15
    dw $0157 ; 0x16
    dw $02B7 ; 0x17
    dw $0258 ; 0x18
    dw $01B8 ; 0x19
    dw $0157 ; 0x1A
    dw $0218 ; 0x1B
    dw $01B7 ; 0x1C
    dw $01F7 ; 0x1D
    dw $0158 ; 0x1E
    dw $0237 ; 0x1F
    dw $0358 ; 0x20
    dw $00E7 ; 0x21
    dw $0217 ; 0x22
    dw $0237 ; 0x23
    dw $0187 ; 0x24
    dw $0634 ; 0x25
    dw $0ED8 ; 0x26
    dw $0628 ; 0x27
    dw $0CC7 ; 0x28
    dw $01F8 ; 0x29
    dw $0238 ; 0x2A
    dw $0248 ; 0x2B
    dw $00B8 ; 0x2C
    dw $0068 ; 0x2D
    dw $0DB8 ; 0x2E
    dw $0257 ; 0x2F
    dw $0218 ; 0x30
    dw $03A7 ; 0x31
    dw $0278 ; 0x32
    dw $06C8 ; 0x33
    dw $0128 ; 0x34
    dw $07A8 ; 0x35
    dw $0248 ; 0x36
    dw $07A8 ; 0x37
    dw $0028 ; 0x38
    dw $0448 ; 0x39
    dw $06B7 ; 0x3A
    dw $0107 ; 0x3B
    dw $0038 ; 0x3C
    dw $0AE8 ; 0x3D
    dw $0890 ; 0x3E
    dw $06C2 ; 0x3F
    dw $004D ; 0x40
    dw $0A59 ; 0x41
    dw $00AA ; 0x42
    dw $00DB ; 0x43
    dw $0732 ; 0x44
    dw $0874 ; 0x45
    dw $006E ; 0x46
    dw $0D72 ; 0x47
    dw $044D ; 0x48
    dw $0B72 ; 0x49
    dw $01BE ; 0x4A
    dw $01E8 ; 0x4B
    dw $0080 ; 0x4C
    dw $03E8 ; 0x4D
    dw $0100 ; 0x4E

    ; $0160EF
    .x_coordinate
    dw $08B8 ; 0x00
    dw $0758 ; 0x01
    dw $0728 ; 0x02
    dw $07F8 ; 0x03
    dw $08C8 ; 0x04
    dw $0F50 ; 0x05
    dw $07F0 ; 0x06
    dw $05A8 ; 0x07
    dw $0678 ; 0x08
    dw $0F50 ; 0x09
    dw $0128 ; 0x0A
    dw $01C8 ; 0x0B
    dw $0088 ; 0x0C
    dw $0128 ; 0x0D
    dw $0268 ; 0x0E
    dw $02A8 ; 0x0F
    dw $01B8 ; 0x10
    dw $0238 ; 0x11
    dw $0508 ; 0x12
    dw $0548 ; 0x13
    dw $0D78 ; 0x14
    dw $0DB8 ; 0x15
    dw $0CB8 ; 0x16
    dw $05A8 ; 0x17
    dw $05B8 ; 0x18
    dw $0D18 ; 0x19
    dw $0D78 ; 0x1A
    dw $0D18 ; 0x1B
    dw $0D18 ; 0x1C
    dw $0CC8 ; 0x1D
    dw $0CB8 ; 0x1E
    dw $0DA8 ; 0x1F
    dw $0DC8 ; 0x20
    dw $0DB8 ; 0x21
    dw $0748 ; 0x22
    dw $07C8 ; 0x23
    dw $07C8 ; 0x24
    dw $07F8 ; 0x25
    dw $0778 ; 0x26
    dw $0F50 ; 0x27
    dw $0128 ; 0x28
    dw $00E8 ; 0x29
    dw $0248 ; 0x2A
    dw $02E8 ; 0x2B
    dw $0098 ; 0x2C
    dw $08F0 ; 0x2D
    dw $0CB8 ; 0x2E
    dw $05B8 ; 0x2F
    dw $0648 ; 0x30
    dw $0728 ; 0x31
    dw $0888 ; 0x32
    dw $08C8 ; 0x33
    dw $0F08 ; 0x34
    dw $01F8 ; 0x35
    dw $02E8 ; 0x36
    dw $06E8 ; 0x37
    dw $08F8 ; 0x38
    dw $0AA8 ; 0x39
    dw $00B8 ; 0x3A
    dw $0D48 ; 0x3B
    dw $0CC8 ; 0x3C
    dw $08B8 ; 0x3D
    dw $07F3 ; 0x3E
    dw $02CD ; 0x3F
    dw $08E6 ; 0x40
    dw $094F ; 0x41
    dw $0CDF ; 0x42
    dw $0551 ; 0x43
    dw $0E7C ; 0x44
    dw $0083 ; 0x45
    dw $047D ; 0x46
    dw $0130 ; 0x47
    dw $0CD1 ; 0x48
    dw $04FE ; 0x49
    dw $0255 ; 0x4A
    dw $0080 ; 0x4B
    dw $01F0 ; 0x4C
    dw $029E ; 0x4D
    dw $0080 ; 0x4E

    ; $01618D
    .camera_trigger_y
    dw $0B07 ; 0x00
    dw $046D ; 0x01
    dw $066D ; 0x02
    dw $06FF ; 0x03
    dw $066D ; 0x04
    dw $026D ; 0x05
    dw $066D ; 0x06
    dw $02D3 ; 0x07
    dw $0303 ; 0x08
    dw $066D ; 0x09
    dw $0CC3 ; 0x0A
    dw $0CB7 ; 0x0B
    dw $0CB3 ; 0x0C
    dw $0C6D ; 0x0D
    dw $06B9 ; 0x0E
    dw $06B7 ; 0x0F
    dw $0B73 ; 0x10
    dw $0B74 ; 0x11
    dw $08E7 ; 0x12
    dw $0082 ; 0x13
    dw $0253 ; 0x14
    dw $0102 ; 0x15
    dw $0172 ; 0x16
    dw $02D2 ; 0x17
    dw $0277 ; 0x18
    dw $01D3 ; 0x19
    dw $0172 ; 0x1A
    dw $0233 ; 0x1B
    dw $01D2 ; 0x1C
    dw $0212 ; 0x1D
    dw $0177 ; 0x1E
    dw $0252 ; 0x1F
    dw $0373 ; 0x20
    dw $0102 ; 0x21
    dw $0232 ; 0x22
    dw $0252 ; 0x23
    dw $01A2 ; 0x24
    dw $066D ; 0x25
    dw $0EF9 ; 0x26
    dw $066D ; 0x27
    dw $0CE6 ; 0x28
    dw $0213 ; 0x29
    dw $0253 ; 0x2A
    dw $0263 ; 0x2B
    dw $00D3 ; 0x2C
    dw $0083 ; 0x2D
    dw $0DD7 ; 0x2E
    dw $0272 ; 0x2F
    dw $0233 ; 0x30
    dw $038D ; 0x31
    dw $0293 ; 0x32
    dw $06E7 ; 0x33
    dw $0147 ; 0x34
    dw $07C7 ; 0x35
    dw $0263 ; 0x36
    dw $07C7 ; 0x37
    dw $006F ; 0x38
    dw $046F ; 0x39
    dw $06D2 ; 0x3A
    dw $0112 ; 0x3B
    dw $006F ; 0x3C
    dw $0B07 ; 0x3D
    dw $08AF ; 0x3E
    dw $06E1 ; 0x3F
    dw $006D ; 0x40
    dw $0A78 ; 0x41
    dw $00C9 ; 0x42
    dw $00F6 ; 0x43
    dw $0751 ; 0x44
    dw $0893 ; 0x45
    dw $008D ; 0x46
    dw $0D8D ; 0x47
    dw $046D ; 0x48
    dw $0B8D ; 0x49
    dw $01D9 ; 0x4A
    dw $019D ; 0x4B
    dw $008F ; 0x4C
    dw $039D ; 0x4D
    dw $009D ; 0x4E

    ; $01622B
    .camera_trigger_x
    dw $08BF ; 0x00
    dw $0763 ; 0x01
    dw $0733 ; 0x02
    dw $0803 ; 0x03
    dw $08D3 ; 0x04
    dw $0F57 ; 0x05
    dw $07F7 ; 0x06
    dw $058D ; 0x07
    dw $0683 ; 0x08
    dw $0F5B ; 0x09
    dw $0133 ; 0x0A
    dw $01CF ; 0x0B
    dw $0090 ; 0x0C
    dw $012F ; 0x0D
    dw $026F ; 0x0E
    dw $02AF ; 0x0F
    dw $018D ; 0x10
    dw $028D ; 0x11
    dw $0513 ; 0x12
    dw $0553 ; 0x13
    dw $0D7D ; 0x14
    dw $0D7D ; 0x15
    dw $0CC3 ; 0x16
    dw $058D ; 0x17
    dw $058D ; 0x18
    dw $0D23 ; 0x19
    dw $0D7D ; 0x1A
    dw $0D23 ; 0x1B
    dw $0D23 ; 0x1C
    dw $0CD3 ; 0x1D
    dw $0CC3 ; 0x1E
    dw $0D7D ; 0x1F
    dw $0D7D ; 0x20
    dw $0D7D ; 0x21
    dw $0753 ; 0x22
    dw $07D3 ; 0x23
    dw $07D3 ; 0x24
    dw $0803 ; 0x25
    dw $077F ; 0x26
    dw $0F5B ; 0x27
    dw $0133 ; 0x28
    dw $00EF ; 0x29
    dw $024F ; 0x2A
    dw $02EF ; 0x2B
    dw $00A3 ; 0x2C
    dw $08FB ; 0x2D
    dw $0CC3 ; 0x2E
    dw $058D ; 0x2F
    dw $067F ; 0x30
    dw $0733 ; 0x31
    dw $0893 ; 0x32
    dw $08D3 ; 0x33
    dw $0F13 ; 0x34
    dw $0203 ; 0x35
    dw $02EF ; 0x36
    dw $06F3 ; 0x37
    dw $0903 ; 0x38
    dw $0AB3 ; 0x39
    dw $00BF ; 0x3A
    dw $0D53 ; 0x3B
    dw $0CD3 ; 0x3C
    dw $08BF ; 0x3D
    dw $07FE ; 0x3E
    dw $02D8 ; 0x3F
    dw $08ED ; 0x40
    dw $0956 ; 0x41
    dw $0CEA ; 0x42
    dw $055C ; 0x43
    dw $0E83 ; 0x44
    dw $008E ; 0x45
    dw $0484 ; 0x46
    dw $0137 ; 0x47
    dw $0CDC ; 0x48
    dw $0505 ; 0x49
    dw $025C ; 0x4A
    dw $0083 ; 0x4B
    dw $018D ; 0x4C
    dw $02A1 ; 0x4D
    dw $0083 ; 0x4E

    ; $0162C9
    .scroll_mod_y
    db $06 ; 0x00
    db $00 ; 0x01
    db $00 ; 0x02
    db $0E ; 0x03
    db $00 ; 0x04
    db $00 ; 0x05
    db $00 ; 0x06
    db $0A ; 0x07
    db $0A ; 0x08
    db $00 ; 0x09
    db $0A ; 0x0A
    db $06 ; 0x0B
    db $0A ; 0x0C
    db $00 ; 0x0D
    db $04 ; 0x0E
    db $06 ; 0x0F
    db $0A ; 0x10
    db $09 ; 0x11
    db $06 ; 0x12
    db $0B ; 0x13
    db $0A ; 0x14
    db $0B ; 0x15
    db $0B ; 0x16
    db $0B ; 0x17
    db $06 ; 0x18
    db $0A ; 0x19
    db $0B ; 0x1A
    db $0A ; 0x1B
    db $0B ; 0x1C
    db $0B ; 0x1D
    db $06 ; 0x1E
    db $0B ; 0x1F
    db $0A ; 0x20
    db $0B ; 0x21
    db $0B ; 0x22
    db $0B ; 0x23
    db $0B ; 0x24
    db $00 ; 0x25
    db $04 ; 0x26
    db $00 ; 0x27
    db $07 ; 0x28
    db $0A ; 0x29
    db $0A ; 0x2A
    db $0A ; 0x2B
    db $0A ; 0x2C
    db $0A ; 0x2D
    db $06 ; 0x2E
    db $0B ; 0x2F
    db $0A ; 0x30
    db $00 ; 0x31
    db $0A ; 0x32
    db $06 ; 0x33
    db $06 ; 0x34
    db $06 ; 0x35
    db $0A ; 0x36
    db $06 ; 0x37
    db $00 ; 0x38
    db $00 ; 0x39
    db $0B ; 0x3A
    db $0B ; 0x3B
    db $00 ; 0x3C
    db $06 ; 0x3D
    db $FE ; 0x3E
    db $0C ; 0x3F
    db $00 ; 0x40
    db $05 ; 0x41
    db $04 ; 0x42
    db $01 ; 0x43
    db $07 ; 0x44
    db $FA ; 0x45
    db $00 ; 0x46
    db $00 ; 0x47
    db $00 ; 0x48
    db $00 ; 0x49
    db $F4 ; 0x4A
    db $00 ; 0x4B
    db $00 ; 0x4C
    db $00 ; 0x4D
    db $00 ; 0x4E

    ; $016318
    .scroll_mod_x
    db $FE ; 0x00
    db $02 ; 0x01
    db $02 ; 0x02
    db $FA ; 0x03
    db $FA ; 0x04
    db $FE ; 0x05
    db $F8 ; 0x06
    db $00 ; 0x07
    db $FC ; 0x08
    db $FA ; 0x09
    db $FA ; 0x0A
    db $FE ; 0x0B
    db $FD ; 0x0C
    db $0E ; 0x0D
    db $FE ; 0x0E
    db $FE ; 0x0F
    db $00 ; 0x10
    db $00 ; 0x11
    db $02 ; 0x12
    db $FA ; 0x13
    db $00 ; 0x14
    db $00 ; 0x15
    db $0A ; 0x16
    db $00 ; 0x17
    db $00 ; 0x18
    db $FA ; 0x19
    db $00 ; 0x1A
    db $FA ; 0x1B
    db $FA ; 0x1C
    db $FA ; 0x1D
    db $FA ; 0x1E
    db $00 ; 0x1F
    db $00 ; 0x20
    db $00 ; 0x21
    db $FC ; 0x22
    db $FC ; 0x23
    db $FC ; 0x24
    db $0A ; 0x25
    db $FE ; 0x26
    db $FA ; 0x27
    db $FA ; 0x28
    db $0E ; 0x29
    db $FE ; 0x2A
    db $FE ; 0x2B
    db $FA ; 0x2C
    db $F4 ; 0x2D
    db $F2 ; 0x2E
    db $00 ; 0x2F
    db $00 ; 0x30
    db $0C ; 0x31
    db $0C ; 0x32
    db $FA ; 0x33
    db $FA ; 0x34
    db $FA ; 0x35
    db $0E ; 0x36
    db $FA ; 0x37
    db $FC ; 0x38
    db $0A ; 0x39
    db $FE ; 0x3A
    db $FA ; 0x3B
    db $0A ; 0x3C
    db $FE ; 0x3D
    db $FF ; 0x3E
    db $F5 ; 0x3F
    db $08 ; 0x40
    db $F9 ; 0x41
    db $03 ; 0x42
    db $01 ; 0x43
    db $02 ; 0x44
    db $FF ; 0x45
    db $FF ; 0x46
    db $06 ; 0x47
    db $F9 ; 0x48
    db $08 ; 0x49
    db $01 ; 0x4A
    db $00 ; 0x4B
    db $00 ; 0x4C
    db $F2 ; 0x4D
    db $00 ; 0x4E

    ; $016367
    .door_graphic
    dw $0816 ; 0x00
    dw $0000 ; 0x01
    dw $0000 ; 0x02
    dw $0000 ; 0x03
    dw $0000 ; 0x04
    dw $0000 ; 0x05
    dw $0000 ; 0x06
    dw $0000 ; 0x07
    dw $0000 ; 0x08
    dw $0000 ; 0x09
    dw $0000 ; 0x0A
    dw $0000 ; 0x0B
    dw $0000 ; 0x0C
    dw $0000 ; 0x0D
    dw $05CC ; 0x0E
    dw $05D4 ; 0x0F
    dw $0BB6 ; 0x10
    dw $0B86 ; 0x11
    dw $0000 ; 0x12
    dw $0000 ; 0x13
    dw $0000 ; 0x14
    dw $0000 ; 0x15
    dw $0000 ; 0x16
    dw $0000 ; 0x17
    dw $0000 ; 0x18
    dw $0000 ; 0x19
    dw $0000 ; 0x1A
    dw $0000 ; 0x1B
    dw $0000 ; 0x1C
    dw $0000 ; 0x1D
    dw $0000 ; 0x1E
    dw $0000 ; 0x1F
    dw $0000 ; 0x20
    dw $0000 ; 0x21
    dw $0000 ; 0x22
    dw $0000 ; 0x23
    dw $0000 ; 0x24
    dw $0000 ; 0x25
    dw $0000 ; 0x26
    dw $0000 ; 0x27
    dw $0000 ; 0x28
    dw $0000 ; 0x29
    dw $0000 ; 0x2A
    dw $0000 ; 0x2B
    dw $0000 ; 0x2C
    dw $0000 ; 0x2D
    dw $0000 ; 0x2E
    dw $0000 ; 0x2F
    dw $0000 ; 0x30
    dw $0000 ; 0x31
    dw $0000 ; 0x32
    dw $0000 ; 0x33
    dw $0000 ; 0x34
    dw $0000 ; 0x35
    dw $0000 ; 0x36
    dw $0000 ; 0x37
    dw $0000 ; 0x38
    dw $0000 ; 0x39
    dw $0000 ; 0x3A
    dw $0000 ; 0x3B
    dw $0000 ; 0x3C
    dw $0816 ; 0x3D
    dw $0000 ; 0x3E
    dw $0000 ; 0x3F
    dw $0000 ; 0x40
    dw $0000 ; 0x41
    dw $0000 ; 0x42
    dw $0000 ; 0x43
    dw $0000 ; 0x44
    dw $0000 ; 0x45
    dw $0000 ; 0x46
    dw $0000 ; 0x47
    dw $0000 ; 0x48
    dw $0000 ; 0x49
    dw $0000 ; 0x4A
    dw $0000 ; 0x4B
    dw $0000 ; 0x4C
    dw $0000 ; 0x4D
    dw $0000 ; 0x4E

    ; $016405
    .door_graphic_location
    dw $0000 ; 0x00
    dw $01AA ; 0x01
    dw $8124 ; 0x02
    dw $87BE ; 0x03
    dw $8158 ; 0x04
    dw $0000 ; 0x05
    dw $0000 ; 0x06
    dw $0000 ; 0x07
    dw $0000 ; 0x08
    dw $0000 ; 0x09
    dw $0000 ; 0x0A
    dw $0000 ; 0x0B
    dw $0000 ; 0x0C
    dw $0000 ; 0x0D
    dw $0000 ; 0x0E
    dw $0000 ; 0x0F
    dw $0000 ; 0x10
    dw $0000 ; 0x11
    dw $0000 ; 0x12
    dw $0000 ; 0x13
    dw $0000 ; 0x14
    dw $0000 ; 0x15
    dw $0000 ; 0x16
    dw $0000 ; 0x17
    dw $0000 ; 0x18
    dw $0000 ; 0x19
    dw $0000 ; 0x1A
    dw $0000 ; 0x1B
    dw $0000 ; 0x1C
    dw $0000 ; 0x1D
    dw $0000 ; 0x1E
    dw $0000 ; 0x1F
    dw $0000 ; 0x20
    dw $0000 ; 0x21
    dw $0000 ; 0x22
    dw $0000 ; 0x23
    dw $0000 ; 0x24
    dw $82BE ; 0x25
    dw $0000 ; 0x26
    dw $0000 ; 0x27
    dw $0000 ; 0x28
    dw $0000 ; 0x29
    dw $0000 ; 0x2A
    dw $0000 ; 0x2B
    dw $0000 ; 0x2C
    dw $0000 ; 0x2D
    dw $0000 ; 0x2E
    dw $0000 ; 0x2F
    dw $0000 ; 0x30
    dw $0000 ; 0x31
    dw $0000 ; 0x32
    dw $0000 ; 0x33
    dw $0000 ; 0x34
    dw $0000 ; 0x35
    dw $0000 ; 0x36
    dw $0000 ; 0x37
    dw $0000 ; 0x38
    dw $0000 ; 0x39
    dw $0000 ; 0x3A
    dw $0000 ; 0x3B
    dw $0000 ; 0x3C
    dw $0000 ; 0x3D
    dw $0000 ; 0x3E
    dw $0000 ; 0x3F
    dw $0000 ; 0x40
    dw $0000 ; 0x41
    dw $0000 ; 0x42
    dw $0000 ; 0x43
    dw $0000 ; 0x44
    dw $0000 ; 0x45
    dw $0000 ; 0x46
    dw $0000 ; 0x47
    dw $0000 ; 0x48
    dw $0000 ; 0x49
    dw $0000 ; 0x4A
    dw $0000 ; 0x4B
    dw $0000 ; 0x4C
    dw $0000 ; 0x4D
    dw $0000 ; 0x4E
}

; ==============================================================================

; Loads a bunch of exit data (e.g. Link's coordinates)
; $0164A3-$0165D2 LOCAL JUMP LOCATION
Overworld_LoadExitData:
{
    ; Data Bank = Program Bank
    PHB : PHK : PLB

    ; Set it so that we are outdoors...
    STZ.b $1B

    ; Reset dark room settings? (why we'd do this in the overworld, I dunno)
    STZ.w $0458

    REP #$20

    ; Something relating to fixed color
    LDA.w #$0000 : STA.l $7EC017

    ; Since we're not in a dungeon, set our palace index to -1
    LDA.w #$00FF : STA.w $040C

    ; Reset the variable that tracks tile modifications to the current area
    STZ.w $04AC

    ; If we're exiting Link's house...
    LDA.b $A0 : CMP.w #$0104 : BEQ .hasExitData
        ; Special outdoor areas like Zora falls
        CMP.w #$0180 : BCS .hasExitData
            ; Rooms less than 0x0100 can have exit data (though they don't
            ; Necessarily have any.
            CMP.w #$0100 : BCC .hasExitData
                ; This code apparently executes for all rooms >= 0x0100 and <
                ; 0x0180. (Excluding Link's house)
                ; These rooms only exit out the way we came.
                ; (Meaning they have no specific exit data)

                JSR.w Overworld_SimpleExit

                JMP .skipComplexExit

    .hasExitData

    ; Search for an exit from this overworld area
    LDX.b #$9E

    .findRoomExit

        DEX #2

        ; Tries to find the appropriate room in a large array.
        ; X in this case becomes the exit number * 2
        ; Note the lack of any kind of error handling here, which can lead
        ; to infinite loops in hacked or unintentionally corrupted games.
        ; In other words, in Vanilla ALTTP, if your room has a door that exits
        ; to the overworld, it had better be in this list.
    CMP.w UnderworldExitData_room_id, X : BNE .findRoomExit

    ; Load things like scroll data
    LDA.w UnderworldExitData_vertical_scroll, X
    STA.b $E6 : STA.b $E8 : STA.w $0122 : STA.w $0124

    LDA.w UnderworldExitData_horizontal_scroll, X
    STA.b $E0 : STA.b $E2 : STA.w $011E : STA.w $0120

    ; Loads up Link's coordinates
    LDA.w UnderworldExitData_y_coordinate, X : STA.b $20

    ; See the data document for details
    LDA.w UnderworldExitData_x_coordinate, X : STA.b $22

    LDA.w UnderworldExitData_exit_vram_addr, X : STA.b $84
    SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

    LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    LDA.w UnderworldExitData_camera_trigger_y, X : STA.w $0618
    DEC #2         : STA.w $061A

    LDA.w UnderworldExitData_camera_trigger_x, X : STA.w $061C
    DEC #2         : STA.w $061E

    ; Make Link face the downwards direction.
    LDA.w #$0002 : STA.b $2F

    LDA.w UnderworldExitData_door_graphic, X : STA.w $0696

    LDA.w UnderworldExitData_door_graphic_location, X : STA.w $0698

    TXA : LSR A : TAX

    SEP #$20

    ; These are the exits.
    LDA.w UnderworldExitData_overworld_id, X : STA.b $8A : STA.w $040A

    ; Zero out the upper byte of the area index.
    STZ.b $8B

    STZ.w $040B

    LDA.w UnderworldExitData_scroll_mod_y, X : STA.w $0624
    STZ.w $0625 : ASL A : BCC .positive1
        DEC.w $0625 ; Sign extends to 16-bit.

    .positive1

    LDA.w UnderworldExitData_scroll_mod_x, X : STA.w $0628
    STZ.w $0629 : ASL A : BCC .positive2
        DEC.w $0629 ; Sign extend to 16-bit.

    .positive2

    REP #$20

    LDA.w #$0000 : SEC : SBC.w $0624 : STA.w $0626
    LDA.w #$0000 : SEC : SBC.w $0628 : STA.w $062A

    .skipComplexExit

    PLB

    ; Bleeds into the next function.
}

; $0165D3-$01658B JUMP LOCATION
Overworld_LoadNewScreenProperties:
{
    ; $EC = -8. Will be used during tilemap calculations to provide granularity
    ; for tile width. Here it's setting it so that tile calculations occur on
    ; an 8x8 pixel grid (as it ought to, since the tiles are an 8x8 grid)
    LDA.w #$FFF8 : STA.b $EC

    SEP #$30

    PHB : PHK : PLB

    JSR.w Overworld_LoadMapProperties

    LDA.b #$E4 : STA.w $0716

    STZ.w $0713

    LDA.b $8A : AND.b #$3F : ASL A : TAY

    REP #$20

    LDX.b #$00

    LDA.w $0712 : BEQ .largeOwMap
        INX #2

    .largeOwMap

    ; Sets up numerous bounds ($06xx vars) but I don't know their exact
    ; function.
    JSR.w Overworld_SetCameraBounds

    SEP #$20

    PLB

    STZ.b $A9

    LDA.b #$02 : STA.b $AA : STA.b $A6 : STA.b $A7

    LDA.b #$80 : STA.b $45 : STA.b $44

    LDA.b #$0F : STA.b $42 : STA.b $43

    LDA.b #$FF : STA.b $24 : STA.b $29

    RTS
}

; ==============================================================================

; $0165D4-$0166E0 LOCAL JUMP LOCATION
Overworld_SimpleExit:
{
    ; Unlike some dungeon rooms that have specific exit data attached to them
    ; this type of exit merely restores data that was cached away when the
    ; player entered the dungeon room. In other words, we are merely
    ; going back to the overworld area we came in from.

    REP #$20

    LDA.l $7EC140 : STA.w $040A

    LDA.l $7EC142 : STA.b $1C

    LDA.l $7EC144 : STA.b $E8 : STA.w $0122 : STA.b $E6 : STA.w $0124
    LDA.l $7EC146 : STA.b $E2 : STA.w $011E : STA.b $E0 : STA.w $0120

    LDA.l $7EC14A : STA.b $22
    LDA.l $7EC148 : STA.b $20

    ; If $A0 >= #$0124, don't take back a 0x10 offset on the Y axis
    LDA.b $A0 : CMP.w #$0124 : BCS .dontOffsetY
        ; The exits where this branch would be taken are special in that
        ; they're exits to caves under rocks or similar types of rooms

        LDA.b $20 : SEC : SBC.w #$0010 : STA.b $20

    .dontOffsetY

    ; Default is to face downwards on exit
    LDA.w #$0002 : STA.b $2F

    ; (0xFFFF means that Link will exit facing up)
    LDA.w $0696 : CMP.w #$FFFF : BNE .notFacingUp
        ; Move Link down 32 pixels if he's going to be facing up coming out of
        ; the exit.
        LDA.b $20 : CLC : ADC.w #$0020 : STA.b $20

        STZ.b $2F

    .notFacingUp

    ; Restore various settings that were cahced when we entered the dungeon room
    LDA.l $7EC14C : STA.b $8A

    LDA.l $7EC14E : STA.b $84
    SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

    LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    LDA.l $7EC150 : STA.w $0618 : DEC #2 : STA.w $061A
    LDA.l $7EC152 : STA.w $061C : DEC #2 : STA.w $061E

    LDA.l $7EC154 : STA.w $0600
    LDA.l $7EC156 : STA.w $0602
    LDA.l $7EC158 : STA.w $0604
    LDA.l $7EC15A : STA.w $0606

    LDA.l $7EC15C : STA.w $0610
    LDA.l $7EC15E : STA.w $0612
    LDA.l $7EC160 : STA.w $0614
    LDA.l $7EC162 : STA.w $0616

    LDA.l $7EC16A : STA.w $0624
    LDA.l $7EC16C : STA.w $0626
    LDA.l $7EC16E : STA.w $0628
    LDA.l $7EC170 : STA.w $062A

    SEP #$20

    LDA.l $7EC164 : STA.w $0AA0
    LDA.l $7EC165 : STA.w $0AA1
    LDA.l $7EC166 : STA.w $0AA2
    LDA.l $7EC167 : STA.w $0AA3

    REP #$20

    RTS
}

; ==============================================================================

; $0166E1-$016850 DATA
Pool_LoadSpecialOverworld:
{
    ; $0166E1
    .camera600
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0200, $0200, $0000, $0000, $0000, $0000, $0000, $0000

    ; $016701
    .camera602
    dw $0120, $0020, $0320, $0020, $0000, $0000, $0320, $0320
    dw $0320, $0220, $0000, $0000, $0000, $0000, $0320, $0320

    ; $016721
    .camera604
    dw $0000, $0100, $0200, $0600, $0600, $0A00, $0C00, $0C00
    dw $0000, $0100, $0200, $0600, $0600, $0A00, $0C00, $0C00

    ; $016741
    .camera606
    dw $0000, $0100, $0500, $0600, $0600, $0A00, $0C00, $0C00
    dw $0000, $0100, $0400, $0600, $0600, $0A00, $0C00, $0C00

    ; $016761
    .camera610
    dw $FF20, $FF20, $FF20, $FF20, $FF20, $FF20, $FF20, $FF20
    dw $FF20, $FF20, $0120, $FF20, $FF20, $FF20, $FF20, $0120

    ; $016781
    .camera614
    dw $FFFC, $0100, $0300, $0100, $0500, $0900, $0B00, $0B00
    dw $FFFC, $0100, $0300, $0500, $0500, $0900, $0B00, $0B00

    ; $0167A1
    .camera612
    dw $FF20, $FF20, $FF20, $FF20, $FF20, $FF20, $0400, $0400
    dw $FF20, $FF20, $0120, $FF20, $FF20, $FF20, $0400, $0400

    ; $0167C1
    .camera616
    dw $0004, $0104, $0300, $0100, $0500, $0900, $0B00, $0B00
    dw $0004, $0104, $0300, $0100, $0500, $0900, $0B00, $0B00

    ; $0167E1
    .camera70C
    dw $0000, $0000, $0200, $0600, $0600, $0A00, $0C00, $0C00
    dw $0000, $0000, $0200, $0600, $0600, $0A00, $0C00, $0C00


    ; $016801
    .direction
    db $00, $04, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00

    ; $016811
    .gfx_0AA3
    db $0C, $0C, $0E, $0E, $0E, $10, $10, $10
    db $0E, $0E, $0E, $0E, $10, $10, $10, $10

    ; $016821
    .gfx_0AA2
    db $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F
    db $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F

    ; $016831
    .palette_prop_a
    db $0A, $0A, $0A, $0A, $02, $02, $02, $0A
    db $02, $02, $0A, $02, $02, $02, $02, $0A

    ; $016841
    .palette_prop_b
    db $01, $08, $08, $08, $00, $00, $00, $00
    db $00, $00, $08, $00, $00, $00, $00, $02
}

; Caches a bunch of values and...?
; $016851-$0169BB LOCAL JUMP LOCATION
LoadSpecialOverworld:
{
    REP #$20

    STZ.w $04AC

    LDA.w $040A : STA.l $7EC100

    LDA.b $1C : STA.l $7EC102
    LDA.b $E8 : STA.l $7EC104
    LDA.b $E2 : STA.l $7EC106
    LDA.b $20 : STA.l $7EC108
    LDA.b $22 : STA.l $7EC10A

    LDA.w $0618 : STA.l $7EC110
    LDA.w $061C : STA.l $7EC112

    LDA.b $8A : STA.l $7EC10C
    LDA.b $84 : STA.l $7EC10E

    LDA.w $0600 : STA.l $7EC114
    LDA.w $0602 : STA.l $7EC116
    LDA.w $0604 : STA.l $7EC118
    LDA.w $0606 : STA.l $7EC11A
    LDA.w $0610 : STA.l $7EC11C
    LDA.w $0612 : STA.l $7EC11E
    LDA.w $0614 : STA.l $7EC120
    LDA.w $0616 : STA.l $7EC122
    LDA.w $0624 : STA.l $7EC12A
    LDA.w $0626 : STA.l $7EC12C
    LDA.w $0628 : STA.l $7EC12E
    LDA.w $062A : STA.l $7EC130

    SEP #$20

    LDA.w $0AA0 : STA.l $7EC124
    LDA.w $0AA1 : STA.l $7EC125
    LDA.w $0AA2 : STA.l $7EC126
    LDA.w $0AA3 : STA.l $7EC127

    SEP #$20

    JSR.w Overworld_LoadExitData

    REP #$20

    LDA.b $A0 : CMP.w #$1010 : BNE .notZoraFalls
        LDA.w #$0182 : STA.b $A0

    .notZoraFalls

    SEP #$20

    PHB : PHK : PLB

    LDA.b $A0 : PHA : SEC : SBC.b #$80 : STA.b $A0 : TAX

    ; Direction
    LDA.l Pool_LoadSpecialOverworld_direction, X : STA.b $2F : STZ.w $0412

    ; GFX $0AA3
    LDA.l Pool_LoadSpecialOverworld_gfx_0AA3, X : STA.w $0AA3

    ; GFX $0AA2
    LDA.l Pool_LoadSpecialOverworld_gfx_0AA2, X : STA.w $0AA2 : PHX

    ; Palette property b
    LDA.l Pool_LoadSpecialOverworld_palette_prop_b, X : STA.b $00

    ; Property property a
    LDA.l Pool_LoadSpecialOverworld_palette_prop_a, X

    JSL Overworld_LoadPalettes

    PLX

    REP #$30

    LDA.w #$03F0 : STA.b $00

    LDA.b $A0 : AND.w #$003F : ASL A : TAX

    LDA.l Pool_LoadSpecialOverworld_camera600, X : STA.w $0708

    LDA.l Pool_LoadSpecialOverworld_camera70C, X : LSR #3 : STA.w $070C

    LDA.b $00 : STA.w $070A

    LDA.b $00 : LSR #3 : STA.w $070E

    LDA.b $A0 : ASL A : TAY

    SEP #$10

    LDA.w Pool_LoadSpecialOverworld_camera600, Y : STA.w $0600
    LDA.w Pool_LoadSpecialOverworld_camera602, Y : STA.w $0602
    LDA.w Pool_LoadSpecialOverworld_camera604, Y : STA.w $0604
    LDA.w Pool_LoadSpecialOverworld_camera606, Y : STA.w $0606
    LDA.w Pool_LoadSpecialOverworld_camera610, Y : STA.w $0610
    LDA.w Pool_LoadSpecialOverworld_camera612, Y : STA.w $0612
    LDA.w Pool_LoadSpecialOverworld_camera614, Y : STA.w $0614
    LDA.w Pool_LoadSpecialOverworld_camera616, Y : STA.w $0616

    SEP #$20

    PLA : STA.b $A0

    PLB

    JSL Overworld_SetScreenBGColorCacheOnly

    RTS
}

; Returns from a special area to a normal overworld area.
; $0169BC-$016AE4 LOCAL JUMP LOCATION
LoadOverworldFromSpecialOverworld:
{
    REP #$20

    STZ.w $04AC

    LDA.l $7EC100 : STA.w $040A

    LDA.l $7EC102 : STA.b $1C

    LDA.l $7EC104 : STA.b $E8 : STA.w $0122 : STA.b $E6 : STA.w $0124
    LDA.l $7EC106 : STA.b $E2 : STA.w $011E : STA.b $E0 : STA.w $0120

    LDA.l $7EC108 : STA.b $20
    LDA.l $7EC10A : STA.b $22
    LDA.l $7EC10C : STA.b $8A

    LDA.l $7EC10E : STA.b $84 : SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

    LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    LDA.l $7EC110 : STA.w $0618 : DEC #2 : STA.w $061A
    LDA.l $7EC112 : STA.w $061C : DEC #2 : STA.w $061E

    LDA.l $7EC114 : STA.w $0600
    LDA.l $7EC116 : STA.w $0602
    LDA.l $7EC118 : STA.w $0604
    LDA.l $7EC11A : STA.w $0606
    LDA.l $7EC11C : STA.w $0610
    LDA.l $7EC11E : STA.w $0612
    LDA.l $7EC120 : STA.w $0614
    LDA.l $7EC122 : STA.w $0616
    LDA.l $7EC12A : STA.w $0624
    LDA.l $7EC12C : STA.w $0626
    LDA.l $7EC12E : STA.w $0628
    LDA.l $7EC130 : STA.w $062A

    SEP #$20

    LDA.l $7EC124 : STA.w $0AA0
    LDA.l $7EC125 : STA.w $0AA1
    LDA.l $7EC126 : STA.w $0AA2
    LDA.l $7EC127 : STA.w $0AA3

    LDX.b $8A : LDA.l $7EFD40, X : STA.b $00

    LDA.l $00FD1C, X

    ; Set palettes and background color
    JSL Overworld_LoadPalettes
    JSL Overworld_SetScreenBGColorCacheOnly

    STZ.b $A9

    LDA.b #$02 : STA.b $AA : STA.b $A6 : STA.b $A7
    LDA.b #$80 : STA.b $45 : STA.b $44
    LDA.b #$0F : STA.b $42 : STA.b $43
    LDA.b #$FF : STA.b $24 : STA.b $29

    SEP #$30

    JSL Player_ResetSwimState
    JSR.w Overworld_LoadMapProperties

    LDA.b #$E4 : STA.w $0716

    STZ.w $0713

    RTS
}

; ==============================================================================

; $016AE5-$016C38 DATA TABLE
Pool_BirdTravel_LoadTargetAreaData:
{
    ; $016AE5
    .screen_id
    dw $0003 ; OW 03 - Flute 1
    dw $0016 ; OW 16 - Flute 2
    dw $0018 ; OW 18 - Flute 3
    dw $002C ; OW 2C - Flute 4
    dw $002F ; OW 2F - Flute 5
    dw $0030 ; OW 30 - Flute 6
    dw $003B ; OW 3B - Flute 7
    dw $003F ; OW 3F - Flute 8
    dw $005B ; OW 5B - Pyramid
    dw $0035 ; OW 35 - Lake Hylia whirlpool
    dw $000F ; OW 0F - Waterfall of Wishing whirlpool
    dw $0015 ; OW 15 - Witch whirlpool
    dw $0033 ; OW 33 - South of Link's house whirlpool
    dw $0012 ; OW 12 - Death Mountain whirlpool
    dw $003F ; OW 3F - Lake Hylia falls whirlpool
    dw $0055 ; OW 55 - Dark witch whirlpool
    dw $007F ; OW 7F - Dark Lake Hylia falls whirlpool

    ; $016B07
    .map16_index
    dw $1600 ; Flute 1
    dw $0888 ; Flute 2
    dw $0B30 ; Flute 3
    dw $0588 ; Flute 4
    dw $0798 ; Flute 5
    dw $1880 ; Flute 6
    dw $069E ; Flute 7
    dw $0810 ; Flute 8
    dw $002E ; Pyramid
    dw $1242 ; Lake Hylia whirlpool
    dw $0680 ; Waterfall of Wishing whirlpool
    dw $0112 ; Witch whirlpool
    dw $059E ; South of Link's house whirlpool
    dw $048E ; Death Mountain whirlpool
    dw $0280 ; Lake Hylia falls whirlpool
    dw $0112 ; Dark witch whirlpool
    dw $0280 ; Dark Lake Hylia falls whirlpool

    ; $016B29
    .vertical_scroll
    dw $02CA ; Flute 1
    dw $0516 ; Flute 2
    dw $0759 ; Flute 3
    dw $0AB9 ; Flute 4
    dw $0AFA ; Flute 5
    dw $0F1E ; Flute 6
    dw $0EDF ; Flute 7
    dw $0F05 ; Flute 8
    dw $0600 ; Pyramid
    dw $0E46 ; Lake Hylia whirlpool
    dw $02C6 ; Waterfall of Wishing whirlpool
    dw $042A ; Witch whirlpool
    dw $0CBA ; South of Link's house whirlpool
    dw $049A ; Death Mountain whirlpool
    dw $0E56 ; Lake Hylia falls whirlpool
    dw $042A ; Dark witch whirlpool
    dw $0E56 ; Dark Lake Hylia falls whirlpool

    ; $016B4B
    .horizontal_scroll
    dw $060E ; Flute 1
    dw $0C4E ; Flute 2
    dw $017E ; Flute 3
    dw $0840 ; Flute 4
    dw $0EB2 ; Flute 5
    dw $0000 ; Flute 6
    dw $06F2 ; Flute 7
    dw $0E75 ; Flute 8
    dw $0778 ; Pyramid
    dw $0C0A ; Lake Hylia whirlpool
    dw $0E06 ; Waterfall of Wishing whirlpool
    dw $0A8A ; Witch whirlpool
    dw $06EA ; South of Link's house whirlpool
    dw $0462 ; Death Mountain whirlpool
    dw $0E00 ; Lake Hylia falls whirlpool
    dw $0A8A ; Dark witch whirlpool
    dw $0E00 ; Dark Lake Hylia falls whirlpool

    ; $016B6D
    .link_pos_y
    dw $0328 ; Flute 1
    dw $0578 ; Flute 2
    dw $07B7 ; Flute 3
    dw $0B17 ; Flute 4
    dw $0B58 ; Flute 5
    dw $0FA8 ; Flute 6
    dw $0F3D ; Flute 7
    dw $0F67 ; Flute 8
    dw $065C ; Pyramid
    dw $0EA8 ; Lake Hylia whirlpool
    dw $0328 ; Waterfall of Wishing whirlpool
    dw $0488 ; Witch whirlpool
    dw $0D18 ; South of Link's house whirlpool
    dw $04F8 ; Death Mountain whirlpool
    dw $0EB8 ; Lake Hylia falls whirlpool
    dw $0488 ; Dark witch whirlpool
    dw $0EB8 ; Dark Lake Hylia falls whirlpool

    ; $016B8F
    .link_pos_x
    dw $0678 ; Flute 1
    dw $0CC8 ; Flute 2
    dw $0200 ; Flute 3
    dw $08B8 ; Flute 4
    dw $0F30 ; Flute 5
    dw $0078 ; Flute 6
    dw $0778 ; Flute 7
    dw $0EF3 ; Flute 8
    dw $07F0 ; Pyramid
    dw $0C90 ; Lake Hylia whirlpool
    dw $0E80 ; Waterfall of Wishing whirlpool
    dw $0B10 ; Witch whirlpool
    dw $0770 ; South of Link's house whirlpool
    dw $04E8 ; Death Mountain whirlpool
    dw $0E68 ; Lake Hylia falls whirlpool
    dw $0B10 ; Dark witch whirlpool
    dw $0E68 ; Dark Lake Hylia falls whirlpool

    ; $016BB1
    .camera_trigger_y
    dw $0337 ; Flute 1
    dw $0583 ; Flute 2
    dw $07C6 ; Flute 3
    dw $0B26 ; Flute 4
    dw $0B67 ; Flute 5
    dw $0F8D ; Flute 6
    dw $0F4C ; Flute 7
    dw $0F72 ; Flute 8
    dw $066D ; Pyramid
    dw $0EB3 ; Lake Hylia whirlpool
    dw $0333 ; Waterfall of Wishing whirlpool
    dw $0497 ; Witch whirlpool
    dw $0D27 ; South of Link's house whirlpool
    dw $0507 ; Death Mountain whirlpool
    dw $0EC3 ; Lake Hylia falls whirlpool
    dw $0497 ; Dark witch whirlpool
    dw $0EC3 ; Dark Lake Hylia falls whirlpool

    ; $016BD3
    .camera_trigger_x
    dw $0683 ; Flute 1
    dw $0CD3 ; Flute 2
    dw $020B ; Flute 3
    dw $08BF ; Flute 4
    dw $0F37 ; Flute 5
    dw $008D ; Flute 6
    dw $077F ; Flute 7
    dw $0EFA ; Flute 8
    dw $07F7 ; Pyramid
    dw $0C97 ; Lake Hylia whirlpool
    dw $0E8B ; Waterfall of Wishing whirlpool
    dw $0B17 ; Witch whirlpool
    dw $0777 ; South of Link's house whirlpool
    dw $04EF ; Death Mountain whirlpool
    dw $0E85 ; Lake Hylia falls whirlpool
    dw $0B17 ; Dark witch whirlpool
    dw $0E85 ; Dark Lake Hylia falls whirlpool

    ; $016BF5
    .scroll_mod_y
    dw $FFF6 ; Flute 1
    dw $FFFA ; Flute 2
    dw $0007 ; Flute 3
    dw $FFF7 ; Flute 4
    dw $FFF6 ; Flute 5
    dw $0000 ; Flute 6
    dw $FFF1 ; Flute 7
    dw $FFFB ; Flute 8
    dw $0000 ; Pyramid
    dw $FFFA ; Lake Hylia whirlpool
    dw $000A ; Waterfall of Wishing whirlpool
    dw $FFF6 ; Witch whirlpool
    dw $FFF6 ; South of Link's house whirlpool
    dw $FFF6 ; Death Mountain whirlpool
    dw $FFFA ; Lake Hylia falls whirlpool
    dw $FFF6 ; Dark witch whirlpool
    dw $FFFA ; Dark Lake Hylia falls whirlpool

    ; $016C17
    .scroll_mod_x
    dw $FFF2 ; Flute 1
    dw $FFF2 ; Flute 2
    dw $0002 ; Flute 3
    dw $0000 ; Flute 4
    dw $000E ; Flute 5
    dw $0000 ; Flute 6
    dw $FFFE ; Flute 7
    dw $000B ; Flute 8
    dw $FFF8 ; Pyramid
    dw $0006 ; Lake Hylia whirlpool
    dw $FFFA ; Waterfall of Wishing whirlpool
    dw $FFFA ; Witch whirlpool
    dw $0006 ; South of Link's house whirlpool
    dw $000E ; Death Mountain whirlpool
    dw $0000 ; Lake Hylia falls whirlpool
    dw $FFFA ; Dark witch whirlpool
    dw $0000 ; Dark Lake Hylia falls whirlpool
}

; $016C39-$016C46 LONG JUMP LOCATION
BirdTravel_LoadTargetAreaData:
{
    PHB : PHK : PLB

    REP #$20

    STZ.w $04AC

    ASL.w $1AF0

    LDX.w $1AF0

    ; Bleeds into the next function.
}

; $016C47-$016CDC LONG JUMP LOCATION
Whirlpool_LoadTargetAreaData:
{
    LDA.w Pool_BirdTravel_LoadTargetAreaData_vertical_scroll, X
    STA.b $E6 : STA.b $E8 : STA.w $0122 : STA.w $0124

    LDA.w Pool_BirdTravel_LoadTargetAreaData_horizontal_scroll, X
    STA.b $E0 : STA.b $E2 : STA.w $011E : STA.w $0120

    LDA.w Pool_BirdTravel_LoadTargetAreaData_link_pos_y, X : STA.b $20
    LDA.w Pool_BirdTravel_LoadTargetAreaData_link_pos_x, X : STA.b $22

    LDA.w Pool_BirdTravel_LoadTargetAreaData_scroll_mod_y, X : STA.w $0624

    LDA.w #$0000 : SEC : SBC.w $0624 : STA.w $0626

    LDA.w Pool_BirdTravel_LoadTargetAreaData_scroll_mod_x, X : STA.w $0628

    LDA.w #$0000 : SEC : SBC.w $0628 : STA.w $062A

    LDA.w Pool_BirdTravel_LoadTargetAreaData_screen_id, X
    STA.b $8A : STA.w $040A

    LDA.w Pool_BirdTravel_LoadTargetAreaData_map16_index, X : STA.b $84
    SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

    LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

    LDA.w Pool_BirdTravel_LoadTargetAreaData_camera_trigger_y, X
    STA.w $0618 : DEC #2 : STA.w $061A

    LDA.w Pool_BirdTravel_LoadTargetAreaData_camera_trigger_x, X
    STA.w $061C : DEC #2 : STA.w $061E

    STZ.w $0696 : STZ.w $0698

    PLB

    JSR.w Overworld_LoadNewScreenProperties
    JSL Sprite_ResetAll
    JSL Sprite_OverworldReloadAll

    STZ.b $6C

    JSR.w DeleteCertainAncillaeStopDashing

    RTL
}

; ==============================================================================

; $016CDD-$016CF7 LONG JUMP LOCATION
BirdTravel_LoadTargetAreaPalettes:
{
    JSR.w Overworld_LoadAreaPalettes

    LDX.b $8A

    LDA.l $7EFD40, X : STA.b $00

    LDA.l OverworldPalettesScreenToSet, X

    JSL Overworld_LoadPalettes
    JSL Palette_SetOwBgColor_Long
    JSR.w Overworld_CopyPalettesToCache_WithPrep

    RTL
}

; ==============================================================================

; $016CF8-$016D07 DATA TABLE
Pool_Whirlpool_LookUpAndLoadTargetArea:
{
    dw $000F ; OW 0F - Lake Hylia whirlpool
    dw $0035 ; OW 35 - Waterfall of Wishing whirlpool
    dw $0033 ; OW 33 - Witch whirlpool
    dw $0015 ; OW 15 - South of Link's house whirlpool
    dw $003F ; OW 3F - Death Mountain whirlpool
    dw $0012 ; OW 12 - Lake Hylia falls whirlpool
    dw $007F ; OW 7F - Dark witch whirlpool
    dw $0055 ; OW 55 - Dark Lake Hylia falls whirlpool
}

; ==============================================================================

; $016D08-$016D24 LONG JUMP LOCATION
Whirlpool_LookUpAndLoadTargetArea:
{
    PHB : PHK : PLB

    REP #$20

    LDX.b #$10

    LDA.b $8A

    .locate_target_area

        ; Appears to be a routine dealing with whirlpool warps.
    DEX #2 : CMP.l $02ECF8, X : BNE .locate_target_area

    TXA : CLC : ADC.w #$0012 : TAX

    STZ.w $04AC

    JMP Whirlpool_LoadTargetAreaData
}

; ==============================================================================

; TODO: This and its companion routines probably need better naming.
; $016D25-$016DB8 LOCAL JUMP LOCATION
Overworld_LoadAmbientOverlay:
{
    REP #$20

    LDA.b $84 : PHA
    LDA.b $86 : PHA
    LDA.b $88 : PHA

    LDX.b $8A

    LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BEQ .large_area
        LDA.w #$0390 : STA.b $84

        SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

        LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

        BRA .load_overlay

        ; $016D59 ALTERNATE ENTRY POINT
        Overworld_LoadAndBuildScreen:

        REP #$20

        ; A = overlay value
        LDA.b $84 : PHA
        LDA.b $86 : PHA
        LDA.b $88 : PHA

        ; X = Area number
        LDX.b $8A
        LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BEQ .large_area_2
            LDA.w #$0390 : STA.b $84

            SEC : SBC.w #$0400 : AND.w #$0F80 : ASL A : XBA : STA.b $88

            LDA.b $84 : SEC : SBC.w #$0010 : AND.w #$003E : LSR A : STA.b $86

        .large_area_2

        SEP #$20

        JSR.w Overworld_LoadMapData

        REP #$20

        .load_overlay

        LDA.w #-1 : STA.b $C8

        STZ.b $CA
        STZ.b $CC

        SEP #$20

        JSR.w Map16ToMap8.normalArea

    .large_area

    REP #$20

    PLA : STA.b $88
    PLA : STA.b $86
    PLA : STA.b $84

    SEP #$20

    ; Upload subscreen overlay command
    LDA.b #$04 : STA.b $17 : STA.w $0710

    ; Move to next submodule
    INC.b $11

    ; Set screen brightness to zero
    STZ.b $13

    RTS
}

; ==============================================================================

; Module 0x08.0x02, 0x0A.0x02 - Loads level data.
; $016DB9-$016DC4 LOCAL JUMP LOCATION
PreOverworld_LoadAndAdvance:
{
    JSR.w Overworld_LoadAndBuildScreen

    ; Put us in the Opening Spotlight module
    LDA.b #$10 : STA.b $10

    STZ.b $B0 : STZ.b $11

    RTS
}

; $016DC5-$016EC4 DATA (Map16 locations of bombable doors)
Pool_Overworld_HandleOverlaysAndBombDoors:
{
    .bombable_door_location
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $1C0C, $1C0C, $0000, $0000, $0000, $0000, $0000, $0000
    dw $1C0C, $1C0C, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $03B0, $180C, $180C, $0288
    dw $0000, $0000, $0000, $0000, $0000, $180C, $180C, $0000

    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $1AB6, $1AB6, $0000, $0E2E, $0E2E, $0000, $0000, $0000
    dw $1AB6, $1AB6, $0000, $0E2E, $0E2E, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $0000, $0000, $0000, $0000, $03B0, $0000, $0000, $0288
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
}

; ==============================================================================

; $016EC5-$016F79 LOCAL JUMP LOCATION
Overworld_LoadMapData:
{
    REP #$30

    ; Decompresses and loads the Area's map16 data.
    JSR.w Overworld_LoadMap32

    LDX.w #$001E

    LDA.w #$0DC4

    .blankBuffer

        STA.l $7E4000, X

        ; Why did this repeat? probably just a mistake.
        STA.l $7E4020, X
        STA.l $7E4020, X

        STA.l $7E4040, X
        STA.l $7E4060, X
    DEX #2 : BPL .blankBuffer

    ; Load the doorway value for this overworld area (determines where to draw
    ; a door frame, if at all).
    LDX.w $0696 : BEQ .noDoor
        ; 0xFFFF indicates you will come out of the building heading north
        ; rather than south (but it still doesn't draw a door frame).
        CPX.w #$FFFF : BEQ .noDoor
            ; If $0696 > 0x8000 we'll draw a bombable door.
            CPX.w #$8000 : BCS .drawBombableDoor
                LDA.w #$0DA4 : STA.l $7E2000, X

                JSL Overworld_Memorize_Map16_Change

                ; 0x0DA4 and 0x0DA6 are the wooden door frames.
                LDA.w #$0DA6

                BRA .finishDoor

            .drawBombableDoor

            TXA : AND.w #$1FFF : TAX

            ; Bombable door tile (left)
            LDA.w #$0DB4

            JSL Overworld_Memorize_Map16_Change

            STA.l $7E2000, X

            ; Bombable door tile (right)
            LDA.w #$0DB5

            .finishDoor

            STA.l $7E2002, X : INX #2

            JSL Overworld_Memorize_Map16_Change

            ; Doorway has been handled, zero it out.
            DEX #2 : STZ.w $0696

    .noDoor

    ; $016F29 ALTERNATE ENTRY POINT
    ; This alternate entry point is for scrolling OW area loads
    ; because drawing a door only applies to when you transition from a dungeon
    ; to the OW the exceptioon is OW areas 0x80 and above which are handled
    ; similar to entrances.
    .justOverlays

    ; Area that contains the warp near the watergate in the LW.
    LDA.w #$020F : LDX.b $8A : CPX.w #$0033 : BNE .noRock
        ; This places a rock at a particular part of area 0x33. Why?
        ; Well basiclly it's because the data between area 0x33 and 0x73 only
        ; differ by this (one rock) so they hardcoded it in. What a stupid
        ; place toput this though, if you ask me. all that unused overlay flag
        ; space and they didn't use it for this.
        STA.l $7E22A8 ; HARDCODED ROCK

    .noRock

    ; Same for this other area.
    CPX.w #$002F : BNE .noRock2
        STA.l $7E2BB2 ; HARDCODED ROCK

    .noRock2

    SEP #$30

    LDX.b $8A : CPX.b #$80 : BCS .dontDrawOverlay
        ; If some flag has already been triggered, do something appropriate,
        ; such as changing tiles to reflect this.
        LDA.l $7EF280, X : AND.b #$20 : BEQ .dontDrawOverlay
            ; The routine that makes the overlay show up.
            JSL Overworld_LoadEventOverlay

    .dontDrawOverlay

    LDX.b $8A

    ; Check the overworld flags array In the second position.
    ; Only pertains to bombs?
    ; If the flag is set, draw a bombed open door (and sometimes other stuff)
    LDA.l $7EF280, X : AND.b #$02 : BEQ .noBombedDoor
        REP #$30

        LDA.b $8A : ASL A : TAX

        ; Designates locations to write opened bomb doors to. i.e. it contains
        ; the map16 coordinates for them.
        LDA.l Pool_Overworld_HandleOverlaysAndBombDoors, X : TAX

        LDA.w #$0DB4 : STA.l $7E2000, X
        LDA.w #$0DB5 : STA.l $7E2002, X

        SEP #$30

    .noBombedDoor

    RTS
}

; ==============================================================================

; $016F7A-$016FB2 LOCAL JUMP LOCATION
Overworld_TransVertical:
{
    SEP #$30

    LDA.b #$08 : STA.w $0416

    LDA.b #$03 : STA.b $17

    REP #$30

    LDY.b $0E : LDA.w #$0080 : STA.w $1100, Y

    INY #2 : STY.b $0E

    .alpha

        JSR.w Overworld_DrawVerticalStrip

        LDA.b $84 : SEC : SBC.w #$0080 : STA.b $84

        LDA.b $88 : DEC A : AND.w #$001F : STA.b $88
    DEC.b $08 : BNE .alpha

    LDA.w #$FFFF : LDX.b $0E : STA.w $1100, X

    RTS
}

; ==============================================================================

; $016FB3-$016FE7 LOCAL JUMP LOCATION
Overworld_TransHorizontal:
{
    SEP #$30

    LDA.b #$02 : STA.w $0416

    LDA.b #$03 : STA.b $17

    REP #$30

    LDY.b $0E : LDA.w #$8040 : STA.w $1100, Y

    INY #2 : STY.b $0E

    .alpha

        JSR.w Overworld_DrawHorizontalStrip

        DEC.b $84 : DEC.b $84

        LDA.b $86 : DEC A : AND.w #$001F : STA.b $86
    DEC.b $08 : BNE .alpha

    LDA.w #$FFFF : LDX.b $0E : STA.w $1100, X

    RTS
}

; ==============================================================================

; $016FE8-$01700C LOCAL JUMP LOCATION
Overworld_LoadTransMapData:
{
    REP #$30

    JSR.w Overworld_LoadMap32

    LDX.w #$001E

    LDA.w #$0DC4

    .default

        ; Fills $7E4000-$7E407F with the map16 value 0x0DC4, which is a blank
        ; transparent tile.
        STA.l $7E4000, X : STA.l $7E4020, X
        STA.l $7E4040, X : STA.l $7E4060, X
    DEX #2 : BPL .default

    ; Draws the "overlay", which is an event sensitive set of map16 tiles that
    ; show that an event has occurred. One example is the Misery Mire dungeon's
    ; entrance being overdrawn as open rather than close
    JSR.w Overworld_LoadMapData_justOverlays

    ; Clean up and finish up all the stuff a dungeon->OW load would do,
    ; except for drawing an opened door. Next we'll be moving on to turning
    ; the map16 data into map8

    INC.b $11

    RTS
}

; ==============================================================================

; $01700D-$01701E LOCAL JUMP TABLE
Overworld_LargeTransTable:
{
    dw Overworld_TransError      ; 0x00 - $F2A2
    dw Overworld_LargeTransRight ; 0x01 - $F0DC
    dw Overworld_LargeTransLeft  ; 0x02 - $F0C0
    dw Overworld_TransError      ; 0x03 - $F2A2
    dw Overworld_LargeTransDown  ; 0x04 - $F087
    dw Overworld_TransError      ; 0x05 - $F2A2
    dw Overworld_TransError      ; 0x06 - $F2A2
    dw Overworld_TransError      ; 0x07 - $F2A2
    dw Overworld_LargeTransUp    ; 0x08 - $F06B
}

; $01701F-$017030 LOCAL JUMP TABLE
Overworld_SmallTransTable:
{
    dw Overworld_TransError      ; 0x00 - $F2A2
    dw Overworld_SmallTransRight ; 0x01 - $F1B7
    dw Overworld_SmallTransLeft  ; 0x02 - $F185
    dw Overworld_TransError      ; 0x03 - $F2A2
    dw Overworld_SmallTransDown  ; 0x04 - $F141
    dw Overworld_TransError      ; 0x05 - $F2A2
    dw Overworld_TransError      ; 0x06 - $F2A2
    dw Overworld_TransError      ; 0x07 - $F2A2
    dw Overworld_SmallTransUp    ; 0x08 - $F10F
}

; $017031-$01704A LOCAL JUMP LOCATION
Overworld_StartTransMapUpdate:
{
    SEP #$30

    LDX.b $8A

    ; Performa a different routine depending on whether the area is 512x512 or
    ; 1024x1024.
    LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : BNE .smallArea
        LDA.w $0416 : ASL A : TAX

        JMP (Overworld_LargeTransTable, X)

    .smallArea

    LDA.w $0416 : ASL A : TAX

    JMP (Overworld_SmallTransTable, X)
}

; $01706B-$017086 LOCAL JUMP LOCATION
Overworld_LargeTransUp:
{
    REP #$30

    LDA.b $84 : CLC : ADC.w #$0380 : STA.b $84

    LDA.w #$001F : STA.b $88

    STZ.b $0E

    LDA.w #$0007 : STA.b $08

    JSR.w Overworld_TransVertical

    SEP #$30

    RTS
}

; ==============================================================================

; $017087-$0170BF LOCAL JUMP LOCATION
Overworld_LargeTransDown:
{
    REP #$30

    LDA.b $84

    .BRANCH_BETA

    CMP.w #$0080 : BCC .BRANCH_ALPHA
        SBC.w #$0080

        BRA .BRANCH_BETA

    .BRANCH_ALPHA

    CLC : ADC.w #$0780 : STA.b $84

    STZ.b $0E

    LDA.w #$0007 : STA.b $88

    LDA.w #$0008 : STA.b $08

    JSR.w Overworld_TransVertical

    LDA.b $88 : CLC : ADC.w #$0009 : AND.w #$001F : STA.b $88

    LDA.b $84 : SEC : SBC.w #$0B80 : STA.b $84

    SEP #$30

    RTS
}

; ==============================================================================

; $0170C0-$0170DB LOCAL JUMP LOCATION
Overworld_LargeTransLeft:
{
    REP #$30

    LDA.b $84 : CLC : ADC.w #$000E : STA.b $84

    LDA.w #$001F : STA.b $86

    STZ.b $0E

    LDA.w #$0007 : STA.b $08

    JSR.w Overworld_TransHorizontal

    SEP #$30

    RTS
}

; ==============================================================================

; $0170DC-$01710E LOCAL JUMP LOCATION
Overworld_LargeTransRight:
{
    REP #$30

    LDA.b $84 : SEC : SBC.w #$0060 : CLC : ADC.w #$001E : STA.b $84

    STZ.b $0E

    LDA.w #$0007 : STA.b $86

    LDA.w #$0008 : STA.b $08

    JSR.w Overworld_TransHorizontal

    LDA.b $86 : CLC : ADC.w #$0009 : AND.w #$001F : STA.b $86

    LDA.b $84 : SEC : SBC.w #$002E : STA.b $84

    SEP #$30

    RTS
}

; ==============================================================================

; $01710F-$017140 LOCAL JUMP LOCATION
Overworld_SmallTransUp:
{
    REP #$30

    ; Cache a bunch of overworld update related variables
    LDA.b $84 : SEC : SBC.w #$0700 : STA.l $7EC172

    LDA.b $86 : STA.l $7EC174

    LDA.w #$000A : STA.l $7EC176

    LDA.w #$1390 : STA.b $84

    STZ.b $86

    LDA.w #$001F : STA.b $88

    STZ.b $0E

    LDA.w #$0007 : STA.b $08

    JSR.w Overworld_TransVertical

    SEP #$30

    RTS
}

; ==============================================================================

; $017141-$017184 LOCAL JUMP LOCATION
Overworld_SmallTransDown:
{
    REP #$30

    LDA.b $84 : AND.w #$00FF : STA.l $7EC172

    LDA.b $86 : STA.l $7EC174

    LDA.w #$0018 : STA.l $7EC176

    LDA.w #$0790 : STA.b $84

    STZ.b $86

    LDA.w #$0007 : STA.b $88

    STZ.b $0E

    LDA.w #$0008 : STA.b $08

    JSR.w Overworld_TransVertical

    LDA.b $88 : CLC : ADC.w #$0009 : AND.w #$001F : STA.b $88
    LDA.b $84 : SEC : SBC.w #$0B80 :                STA.b $84

    SEP #$30

    RTS
}

; ==============================================================================

; $017185-$0171B6 LOCAL JUMP LOCATION
Overworld_SmallTransLeft:
{
    REP #$30

    LDA.b $84 : SEC : SBC.w #$0020 : STA.l $7EC172

    LDA.w #$0008 : STA.l $7EC174

    LDA.b $88 : STA.l $7EC176

    LDA.w #$044E : STA.b $84

    STZ.b $88

    LDA.w #$001F : STA.b $86

    STZ.b $0E

    LDA.w #$0007 : STA.b $08

    JSR.w Overworld_TransHorizontal

    SEP #$30

    RTS
}

; ==============================================================================

; $0171B7-$0171FB LOCAL JUMP LOCATION
Overworld_SmallTransRight:
{
    REP #$30

    LDA.b $84 : SEC : SBC.w #$0060 : STA.l $7EC172

    LDA.w #$0018 : STA.l $7EC174

    LDA.b $88 : STA.l $7EC176

    LDA.w #$041E : STA.b $84

    STZ.b $88

    LDA.w #$0007 : STA.b $86

    STZ.b $0E

    LDA.w #$0008 : STA.b $08

    JSR.w Overworld_TransHorizontal

    LDA.b $86 : CLC : ADC.w #$0009 : AND.w #$001F : STA.b $86

    LDA.b $84 : SEC : SBC.w #$002E : STA.b $84

    SEP #$30

    RTS
}

; ==============================================================================

; $0171FC-$01720D LOCAL JUMP TABLE
OverworldTransitionScrollAndLoadMapJumpTable:
{
    dw Overworld_TransError                  ; 0x00 - $F2A2
    dw BuildFullStripeDuringTransition_East  ; 0x01 - $F24A
    dw BuildFullStripeDuringTransition_West  ; 0x02 - $F241
    dw Overworld_TransError                  ; 0x03 - $F2A2
    dw BuildFullStripeDuringTransition_South ; 0x04 - $F238
    dw Overworld_TransError                  ; 0x05 - $F2A2
    dw Overworld_TransError                  ; 0x06 - $F2A2
    dw Overworld_TransError                  ; 0x07 - $F2A2
    dw BuildFullStripeDuringTransition_North ; 0x08 - $F218
}

; $01720E-$017217 LOCAL JUMP LOCATION
OverworldTransitionScrollAndLoadMap:
{
    SEP #$30

    LDA.w $0416 : ASL A : TAX

    JMP (OverworldTransitionScrollAndLoadMapJumpTable, X)
}

; $017218-$01721E LOCAL JUMP LOCATION
BuildFullStripeDuringTransition_North:
{
    REP #$30

    STZ.b $0E

    JSR.w CheckForNewlyLoadedMapAreas_North_NewStripe

    ; Bleeds into the next function.
}

; $01721F-$017237 ALTERNATE ENTRY POINT
OverworldTransitionScrollAndLoadMap_BuildStripe:
{
    LDY.b $0E

    LDA.w #$FFFF : STA.w $1100, Y : STA.w $1102, Y

    CPY.w #$0000 : BEQ .noUpdate
        SEP #$30

        LDA.b #$03 : STA.b $17

    .noUpdate

    SEP #$30

    RTS
}

; $017238-$017240 LOCAL JUMP LOCATION
BuildFullStripeDuringTransition_South:
{
    REP #$30

    STZ.b $0E

    JSR.w CheckForNewlyLoadedMapAreas_South_NewStripe

    BRA OverworldTransitionScrollAndLoadMap_BuildStripe
}

; $017241-$017249 LOCAL JUMP LOCATION
BuildFullStripeDuringTransition_West:
{
    REP #$30

    STZ.b $0E

    JSR.w CheckForNewlyLoadedMapAreas_West_NewStripe

    BRA OverworldTransitionScrollAndLoadMap_BuildStripe
}

; $01724A-$017252 LOCAL JUMP LOCATION
BuildFullStripeDuringTransition_East:
{
    REP #$30

    STZ.b $0E

    JSR.w CheckForNewlyLoadedMapAreas_East_NewStripe

    BRA OverworldTransitionScrollAndLoadMap_BuildStripe
}

; $017253-$017272 LOCAL JUMP TABLE
Overworld_ScrollTable:
{
    dw Overworld_TransError    ; 0x00 - $F2A2 No direction = no update
    dw Overworld_ScrollRight   ; 0x01 - $F2A5 Moving right
    dw Overworld_ScrollLeft    ; 0x02 - $F2AC Moving left
    dw Overworld_TransError    ; 0x03 - $F2A2 Impossible left + right
    dw Overworld_ScrollUp      ; 0x04 - $F2B3 Moving up
    dw MapScroll_SouthAndClear ; 0x05 - $F2BA Moving up + right
    dw MapScroll_SouthAndClear ; 0x06 - $F2BA Moving up + left
    dw Overworld_TransError    ; 0x07 - $F2A2 Impossible up + left + right
    dw Overworld_ScrollDown    ; 0x08 - $F2C8 Moving down
    dw MapScroll_NorthAndClear ; 0x09 - $F2CF Moving down + right
    dw MapScroll_NorthAndClear ; 0x0A - $F2CF Moving down + left
    dw Overworld_TransError    ; 0x0B - $F2A2 Impossible down + left + right
    dw Overworld_TransError    ; 0x0C - $F2A2 Impossible down + up
    dw Overworld_TransError    ; 0x0D - $F2A2 Impossible down + up + right
    dw Overworld_TransError    ; 0x0E - $F2A2 Impossible down + up + left
    dw Overworld_TransError    ; 0x0F - $F2A2 Impossible down + up + left + right
}

; $017273-$0172A1 LOCAL JUMP LOCATION
Overworld_ScrollMap:
{
    REP #$30

    STZ.b $0E

    SEP #$30

    ; Based on the flags in the
    LDA.w $0416 : ASL A : TAX

    JSR.w (Overworld_ScrollTable, X)

    REP #$30

    LDY.b $0E : LDA.w #$FFFF : STA.w $1100, Y : STA.w $1102, Y

    CPY.w #$0000 : BEQ .noTilemapUpdate
        SEP #$30

        LDA.b #$03 : STA.b $17

    .noTilemapUpdate

    SEP #$30

    LDA.w $0416 : STA.w $0418

    RTS
}

; ==============================================================================

; $0172A2-$0172A4 LOCAL JUMP LOCATION
Overworld_TransError:
{
    ; Resets the submodule index to normal. This routine... should never occur
    ; under normal circumstances if I understand correctly.
    STZ.b $11

    RTS
}

; ==============================================================================

; $0172A5-$0172AB LOCAL JUMP LOCATION
Overworld_ScrollRight:
{
    JSR.w CheckForNewlyLoadedMapAreas_East

    STZ.w $0416

    RTS
}

; ==============================================================================

; $0172AC-$0172B2 LOCAL JUMP LOCATION
Overworld_ScrollLeft:
{
    JSR.w CheckForNewlyLoadedMapAreas_West

    STZ.w $0416

    RTS
}

; ==============================================================================

; $0172B3-$0172B9 LOCAL JUMP LOCATION
Overworld_ScrollUp:
{
    JSR.w CheckForNewlyLoadedMapAreas_South

    STZ.w $0416

    RTS
}

; ==============================================================================

; $0172BA-$0172C7 LOCAL JUMP LOCATION
MapScroll_SouthAndClear:
{
    JSR.w CheckForNewlyLoadedMapAreas_South

    SEP #$30

    LDA.w $0416 : AND.b #$03 : STA.w $0416

    RTS
}

; $0172C8-$0172CE LOCAL JUMP LOCATION
Overworld_ScrollDown:
{
    JSR.w CheckForNewlyLoadedMapAreas_North

    STZ.w $0416

    RTS
}

; $0172CF-$0172DC LOCAL JUMP LOCATION
MapScroll_NorthAndClear:
{
    JSR.w CheckForNewlyLoadedMapAreas_North

    SEP #$30

    LDA.w $0416 : AND.b #$03 : STA.w $0416

    RTS
}

; $0172DD-$017310 LOCAL JUMP LOCATION
CheckForNewlyLoadedMapAreas_North:
{
    REP #$30

    LDA.b $84 : CMP.w #$0080 : BMI .BRANCH_ALPHA
        LDX.b $8A
        LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BNE .BRANCH_BETA
            ; $0172F1 ALTERNATE ENTRY POINT
            .NewStripe

            LDY.b $0E

            LDA.w #$0080 : STA.w $1100, Y

            INY #2 : STY.b $0E

            JSR.w Overworld_DrawVerticalStrip

        .BRANCH_BETA

        LDA.b $84 : SEC : SBC.w #$0080 : STA.b $84

        LDA.b $88 : DEC A : AND.w #$001F : STA.b $88

    .BRANCH_ALPHA

    RTS
}

; $017311-$017344 LOCAL JUMP LOCATION
CheckForNewlyLoadedMapAreas_South:
{
    REP #$30

    LDA.b $84 : CMP.w #$1800 : BCS .BRANCH_ALPHA
        LDX.b $8A
        LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BNE .BRANCH_BETA
            ; $017325 ALTERNATE ENTRY POINT
            .NewStripe

            LDY.b $0E

            LDA.w #$0080 : STA.w $1100, Y

            INX #2

            STY.b $0E

            JSR.w Overworld_DrawVerticalStrip

        .BRANCH_BETA

        LDA.b $84 : CLC : ADC.w #$0080 : STA.b $84

        LDA.b $88 : INC A : AND.w #$001F : STA.b $88

    .BRANCH_ALPHA

    RTS
}

; $017345-$01737E LOCAL JUMP LOCATION
CheckForNewlyLoadedMapAreas_West:
{
    REP #$30

    LDA.b $84

    .BRANCH_BETA

    CMP.w #$0080 : BCC .BRANCH_ALPHA
        SBC.w #$0080

        BRA .BRANCH_BETA

    .BRANCH_ALPHA

    CMP.w #$0000 : BEQ .BRANCH_GAMMA
        LDX.b $8A
        LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BNE .BRANCH_DELTA
            ; $017363 ALTERNATE ENTRY POINT
            .NewStripe

            LDY.b $0E

            LDA.w #$8040 : STA.w $1100, Y

            INY #2 : STY.b $0E

            JSR.w Overworld_DrawHorizontalStrip

        .BRANCH_DELTA

        DEC.b $84 : DEC.b $84

        LDA.b $86 : DEC A : AND.w #$001F : STA.b $86

    .BRANCH_GAMMA

    RTS
}

; ==============================================================================

; $01737F-$0173B8 LOCAL JUMP LOCATION
CheckForNewlyLoadedMapAreas_East:
{
    REP #$30

    LDA.b $84

    .BRANCH_BETA

    CMP.w #$0080 : BCC .BRANCH_ALPHA
        SBC.w #$0080

        BRA .BRANCH_BETA

    .BRANCH_ALPHA

    CMP.w #$0060 : BCS .BRANCH_GAMMA
        LDX.b $8A
        LDA.w Pool_BufferAndBuildMap16Stripes_overworldScreenSize, X : AND.w #$00FF : BNE .BRANCH_DELTA
            ; $01739D ALTERNATE ENTRY POINT
            .NewStripe

            LDY.b $0E

            LDA.w #$8040 : STA.w $1100, Y

            INY #2 : STA.b $0E

            JSR.w Overworld_DrawHorizontalStrip

        .BRANCH_DELTA

        INC.b $84 : INC.b $84

        LDA.b $86 : INC A : AND.w #$001F : STA.b $86

    .BRANCH_GAMMA

    RTS
}

; ==============================================================================

; $0173B9-$017434 LOCAL JUMP LOCATION
Overworld_DrawHorizontalStrip:
{
    LDA.w $0416 : AND.w #$0002 : TAX

    LDA.b $84
    SEC : SBC.l Pool_BufferAndBuildMap16Stripes_verticalScrollTileOffset, X
    TAY

    LDA.b $88 : ASL A : TAX

    ; $00[3] = $7E2000
    ; $03[2] = $0010
    LDA.w #$2000 : STA.b $00
    LDA.w #$007E : STA.b $02
    LDA.w #$0010 : STA.b $03

    LDA.b [$00], Y : STA.w $0500, X

    INX #2

    TXA : AND.w #$003F : TAX

    ; Move down one map16 tile
    TYA : CLC : ADC.w #$0080 : TAY

    .fillBuffer

        ; Populate the buffer ( $0500[0x40] ) with 0x10 map16 entries (256
        ; pixels)
        LDA.b [$00], Y : STA.w $0500, X : INX #2

        ; Advance by one map16 tile in our temporary buffer
        TXA : AND.w #$003F : TAX

        ; Move down one map16 tile
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $03 : BNE .fillBuffer

    STZ.b $00

    LDA.b $86 : STA.b $02 : CMP.w #$0010 : BCC .inBounds
        AND.w #$000F : STA.b $02

        LDA.w #$0400 : STA.b $00

    .inBounds

    LDA.b $02 : ASL A : CLC : ADC.b $00    : STA.b $00
                        CLC : ADC.w #$0800 : STA.b $0C

    LDA.l Pool_BufferAndBuildMap16Stripes_Map16BufferOffsetLow

    JSR.w CreateMap16Stripes_Horizontal

    LDA.b $0C : STA.b $00

    LDA.l Pool_BufferAndBuildMap16Stripes_Map16BufferOffsetHigh

    ; Bleeds into the next function.
}

; $017435-$017481 LOCAL JUMP LOCATION
CreateMap16Stripes_Horizontal:
{
    STA.b $02

    LDY.b $0E : LDA.b $00 : STA.w $1100, Y : INC A : STA.w $1142, Y : INY #2

    LDA.w #$0010 : STA.b $06

    .copyToNmiBuf

        LDX.b $02 : LDA.w $0500, X : INX #2 : STX.b $02

        ASL #3 : TAX

        LDA.l Map16Definitions_0, X : STA.w $1100, Y
        LDA.l Map16Definitions_1, X : STA.w $1142, Y

        INY #2

        LDA.l Map16Definitions_2, X : STA.w $1100, Y
        LDA.l Map16Definitions_3, X : STA.w $1142, Y

        INY #2
    DEC.b $06 : BNE .copyToNmiBuf

    ; 0x10 map16 tiles = 0x40 bytes of map8 data
    ; And there's also 2 bytes of header information in the nmi buffer, so
    ; we advance by that much.
    TYA : CLC : ADC.w #$0042 : STA.b $0E

    RTS
}

; ==============================================================================

; $017482-$017509 LOCAL JUMP LOCATION
Overworld_DrawVerticalStrip:
{
    LDA.w $0416 : AND.w #$0004 : LSR A : TAX

    LDA.b $84
    SEC : SBC Pool_BufferAndBuildMap16Stripes_verticalScrollTileOffset, X
    TAY

    LDA.b $86 : ASL A : TAX

    ; $00[3] = $7E2000
    LDA.w #$2000 : STA.b $00
    LDA.w #$007E : STA.b $02

    ; $03[2] = 0x0010
    LDA.w #$0010 : STA.b $03

    .fillBuffer

        ; Writes 0x40 bytes to $0500[0x40]
        LDA.b [$00], Y : STA.w $0500, X

        INX #2 : TXA : AND.w #$003F : TAX
        INY #2

        LDA.b [$00], Y : STA.w $0500, X

        INX #2 : TXA : AND.w #$003F : TAX
        INY #2
    DEC.b $03 : BNE .fillBuffer

    STZ.b $00

    LDA.b $88 : STA.b $02 : CMP.w #$0010 : BCC .inBounds
        AND.w #$000F : STA.b $02

        LDA.w #$0800 : STA.b $00

    .inBounds

    LDA.b $02 : ASL #6 : CLC : ADC.b $00 : STA.b $00

    CLC : ADC.w #$0400 : STA.b $0C

    LDY.b $0E

    LDA.b $00 : STA.w $1100, Y : INY #2

    LDA.l Pool_BufferAndBuildMap16Stripes_Map16BufferOffsetLow

    JSR.w CreateMap16Stripes_Vertical

    LDY.b $0E

    LDA.b $0C : STA.w $1100, Y : INY #2

    LDA.l Pool_BufferAndBuildMap16Stripes_Map16BufferOffsetHigh

    ; Bleeds into the next function.
}

; $01750A-$017549 JUMP LOCATION
CreateMap16Stripes_Vertical:
{
    STA.b $02

    LDA.w #$0010 : STA.b $06

    .nextMap16Tile

        LDX.b $02

        LDA.w $0500, X : INX #2 : STX.b $02 : ASL #3 : TAX

        ; Place the top left map8 tile.
        LDA.l Map16Definitions_0, X : STA.w $1100, Y

        ; Place the bottom left map8 tile.
        LDA.l Map16Definitions_2, X : STA.w $1140, Y

        INY #2

        ; Place the top right map8 tile.
        LDA.l Map16Definitions_1, X : STA.w $1100, Y

        ; Place the bottom right map8 tile.
        LDA.l Map16Definitions_3, X : STA.w $1104, Y

        INY #2
    DEC.b $06 : BNE .nextMap16Tile

    TYA : CLC : ADC.w #$0040 : STA.b $0E

    RTS
}

; ==============================================================================

; This routine loads the tile data for the OW section
; $00[3] is the target address, in this case $7E2000[0x2000]
; $03[3] is the target address + 0x80
; $C8[3] is the source address for the data to be written
; $01754A-$017637 LOCAL JUMP LOCATION
Overworld_LoadMap32:
{
    ; X = $8A * 3
    LDA.b $8A : ASL A : ADC.b $8A : TAX

    LDA.w #$007E : STA.b $02 : STA.b $05

    LDA.w #$2000

    JSR.w .loadQuadrant

    ; X = 3 * ($8A + 1)
    LDA.b $8A : INC A : STA.b $00 : ASL A : ADC.b $00 : TAX

    ; This should be written as just "LDA.w #$2040"
    LDA.w #$2000 : CLC : ADC.w #$0040

    JSR.w .loadQuadrant

    ; $00 = ($8A + 8)
    LDA.b $8A : CLC : ADC.w #$0008 : STA.b $00

    ; X = 3 * ($8A + 8)
    ASL A : ADC.b $00 : TAX

    LDA.w #$3000

    JSR.w .loadQuadrant

    ; $00 = ($8A + 9)
    LDA.b $8A : CLC : ADC.w #$0009 : STA.b $00

    ; X = 3 * ($8A + 9)
    ASL A : ADC.b $00 : TAX

    ; This should be written as just "LDA.w #$0304"
    LDA.w #$3000 : CLC : ADC.w #$0040

    .loadQuadrant

    STA.b $00 : CLC : ADC.w #$0080 : STA.b $03

    ; Load the source address into $C8[3]
    LDA.l .high_byte_packs+0, X : STA.b $C8
    LDA.l .high_byte_packs+1, X : STA.b $C9

    LDA.b $00 : PHA
    LDA.b $02 : PHA
    LDA.b $04 : PHA

    LDA.w #$4400 : STA.b $00

    LDA.w #$007F : STA.b $02

    PHX

    SEP #$30

    ; Decompresses the map32 data packet.
    JSR.w Overworld_Decomp

    REP #$30

    JSR.w InterlaceMap32.highBytes

    PLX

    LDA.l .low_byte_packs+0, X : STA.b $C8
    LDA.l .low_byte_packs+1, X : STA.b $C9

    ; $00[3] = $7F4400
    LDA.w #$4400 : STA.b $00
    LDA.w #$007F : STA.b $02

    PHX

    SEP #$30

    JSR.w Overworld_Decomp

    REP #$30

    JSR.w InterlaceMap32.lowBytes

    PLX

    PLA : STA.b $04
    PLA : STA.b $02
    PLA : STA.b $00

    ; $08[3] = 0x7F4000 (source address)
    LDA.w #$4000 : STA.b $08
    LDA.w #$007F : STA.b $0A

    SEP #$20

    ; Data bank = 0x7F
    PHB : LDA.b #$7F : PHA : PLB

    REP #$30

    LDA.w #$FFFF : STA.w $4440

    STZ.b $06 : STZ.b $0B

    .yLoop

        LDA.w #$0010 : STA.b $0D

        .xLoop

            LDY.b $0B

            LDA.b [$08], Y : ASL A

            LDY.b $06

            JSR.w Map32ToMap16

            STY.b $06

            INC.b $0B : INC.b $0B
        DEC.b $0D : BNE .xLoop
    LDA.b $06 : CLC : ADC.w #$00C0 : STA.b $06 : CMP.w #$1000 : BCC .yLoop

    PLB

    RTS
}

; ==============================================================================

; Copies decompressed map32 data into the odd bytes in $7F4000[0x200]
; $017638-$017690 LOCAL JUMP LOCATION
InterlaceMap32:
{
    .highBytes

    SEP #$20

    ; Set the data bank to $7F.
    PHB : LDA.b #$7F : PHA : PLB

    ; Changing the bank of the target address.
    STA.b $02

    REP #$30

    LDX.w #$0000
    LDY.w #$0001

    ; $00[3] = $7F4000
    LDA.w #$4000 : STA.b $00

    SEP #$20

    .doInterlace

        ; Copy $7F4400, X to $7F4000, Y
        LDA.w $4400, X : STA.b [$00], Y : INY #2 : INX
        LDA.w $4400, X : STA.b [$00], Y : INY #2 : INX
        LDA.w $4400, X : STA.b [$00], Y : INY #2 : INX
        LDA.w $4400, X : STA.b [$00], Y : INY #2 : INX
    CPX.w #$0100 : BCC .doInterlace

    REP #$30

    PLB

    RTS

    ; Copies decompressed map32 data into the even bytes in $7F4000[0x200]
    ; $017679 ALTERNATE ENTRY POINT
    .lowBytes

    SEP #$20

    PHB : LDA.b #$7F : PHA : PLB

    STA.b $02

    REP #$30

    LDX.w #$0000 : TXY

    ; $02[3] = $7F4000
    LDA.w #$4000 : STA.b $00

    SEP #$20

    BRA .doInterlace
}

; ==============================================================================

; Converts a map32 tile to its 4 map16 tiles.
; $017691-$0177CA LOCAL JUMP LOCATION
Map32ToMap16:
{
    ; Map32 value...
    ; if(A != $4440) goto .BRANCH_1
    PHA : AND.w #$FFF8 : CMP.w $4440 : BNE .different
        ; This is a shortcut to load the same data if the new map32 value
        ; matches the previous one.
        JMP .same

    .different

    ; $4440 = input
    STA.w $4440

    ; $4442 = input >> 1
    LSR A : STA.w $4442

    ; X = (input >> 2) + (input >> 1)
    ; Thus the formula is X = (input / 4) + (input / 2) = input * (3 / 4)
    ; The map32 to map16 conversion data is packed 12 bits at time, hence we
    ; take a 16-bit index and multiply it by (3/4) to get a 12-bit index.
    LSR A : ADC.w $4442 : TAX

    SEP #$20

    LDA.l Tile32_TopLeft_0, X : STA.w $4400
    LDA.l Tile32_TopLeft_1, X : STA.w $4402
    LDA.l Tile32_TopLeft_2, X : STA.w $4404
    LDA.l Tile32_TopLeft_3, X : STA.w $4406

    LDA.l Tile32_TopLeft_4, X : PHA : LSR #4 :     STA.w $4401
                                PLA : AND.b #$0F : STA.w $4403

    LDA.l Tile32_TopLeft_5, X : PHA : LSR #4 :     STA.w $4405
                                PLA : AND.b #$0F : STA.w $4407

    LDA.l Tile32_TopRight_0, X : STA.w $4410
    LDA.l Tile32_TopRight_1, X : STA.w $4412
    LDA.l Tile32_TopRight_2, X : STA.w $4414
    LDA.l Tile32_TopRight_3, X : STA.w $4416

    LDA.l Tile32_TopRight_4, X : PHA : LSR #4 :     STA.w $4411
                                 PLA : AND.b #$0F : STA.w $4413

    LDA.l Tile32_TopRight_5, X : PHA : LSR #4 :     STA.w $4415
                                 PLA : AND.b #$0F : STA.w $4417

    LDA.l Tile32_BottomLeft_0, X : STA.w $4420
    LDA.l Tile32_BottomLeft_1, X : STA.w $4422
    LDA.l Tile32_BottomLeft_2, X : STA.w $4424
    LDA.l Tile32_BottomLeft_3, X : STA.w $4426

    LDA.l Tile32_BottomLeft_4, X : PHA : LSR #4 :     STA.w $4421
                                   PLA : AND.b #$0F : STA.w $4423

    LDA.l Tile32_BottomLeft_5, X : PHA : LSR #4 :     STA.w $4425
                                   PLA : AND.b #$0F : STA.w $4427

    LDA.l Tile32_BottomRight_0, X : STA.w $4430
    LDA.l Tile32_BottomRight_1, X : STA.w $4432
    LDA.l Tile32_BottomRight_2, X : STA.w $4434
    LDA.l Tile32_BottomRight_3, X : STA.w $4436

    LDA.l Tile32_BottomRight_4, X : PHA : LSR #4 :     STA.w $4431
                                    PLA : AND.b #$0F : STA.w $4433

    LDA.l Tile32_BottomRight_5, X : PHA : LSR #4 :     STA.w $4435
                                    PLA : AND.b #$0F : STA.w $4437

    REP #$30

    ; $0177AD ALTERNATE ENTRY POINT
    .same

    PLA : AND.w #$0007 : TAX

    LDA.w $4400, X : STA.b [$00], Y
    LDA.w $4420, X : STA.b [$03], Y : INY #2
    LDA.w $4410, X : STA.b [$00], Y
    LDA.w $4430, X : STA.b [$03], Y : INY #2

    RTS
}

; ==============================================================================

; $0177CB-$01787E LOCAL JUMP LOCATION
LoadSubOverlayMap32:
{
    ; X = (3 * $8A)
    LDA.b $8A : ASL A : ADC.b $8A : TAX

    ; $00 = $7E4000, $03 = $7E4080
    LDA.w #$007E : STA.b $02 : STA.b $05
    LDA.w #$4000 : STA.b $00 : CLC : ADC.w #$0080 : STA.b $03

    ; $C8[3] = base address of the compressed map32 data
    LDA.l .high_byte_packs+0, X : STA.b $C8
    LDA.l .high_byte_packs+1, X : STA.b $C9

    ; We're going to save those two long addresses for later.
    LDA.b $00 : PHA
    LDA.b $02 : PHA
    LDA.b $04 : PHA

    ; $00[3] = $7F4400
    LDA.w #$4400 : STA.b $00
    LDA.w #$007F : STA.b $02

    ; Push ($8A * 3) to the stack.
    PHX

    SEP #$30

    ; Decompress data to $7F4400.
    JSR.w Overworld_Decomp

    REP #$30

    JSR.w InterlaceMap32.highBytes

    PLX

    ; Change the source address for the decompression.
    LDA.l .low_byte_packs+0, X : STA.b $C8
    LDA.l .low_byte_packs+1, X : STA.b $C9

    ; TargetAddress = $7F4400
    LDA.w #$4400 : STA.b $00
    LDA.w #$007F : STA.b $02

    PHX

    SEP #$30

    JSR.w Overworld_Decomp

    REP #$30

    JSR.w InterlaceMap32.lowBytes

    PLX

    ; Restore the old long addresses.
    ; ($00 = $7E4000, $03 = $7E4080)
    PLA : STA.b $04
    PLA : STA.b $02
    PLA : STA.b $00

    ; $08[3] = $7F4000
    LDA.w #$4000 : STA.b $08
    LDA.w #$007F : STA.b $0A

    SEP #$20

    ; Set data bank to 0x7F
    PHB : LDA.b #$7F : PHA : PLB

    REP #$30

    ; Store to $7F4440
    LDA.w #$FFFF : STA.w $4440

    STZ.b $06 : STZ.b $0B

    .nextLine
        ; By line, we mean a 32 x 512 pixel swath. 0x10 map32 tiles consists of
        ; exactly this.

        ; Set up a loop of 0x10 iterations.
        LDA.w #$0010 : STA.b $0D

        .nextTile
            ; X = ($7F4000 + Y) << 1, the map32 value.
            LDY.b $0B : LDA.b [$08], Y : ASL A : TAX

            LDY.b $06

            JSR.w Map32ToMap16

            STY.b $06

            ; Increment by two to obtain the next map32 value.
            INC.b $0B : INC.b $0B

        DEC.b $0D : BNE .nextTile

    ; $06 += 0xC0
    ; if($06 < 0x100)
    LDA.b $06 : CLC : ADC.w #$00C0 : STA.b $06 : CMP.w #$1000 : BCC .nextLine

    PLB

    RTS
}

; ==============================================================================

; $01787F-$017882 DATA TABLE
UNREACHABLE_02F87F:
{
    db $02, $00, $04, $00,
}

; $017883-$01794C DATA TABLE
Pool_BufferAndBuildMap16Stripes:
{
    ; $017883
    .horizontalScrollTileOffset
    dw $03D0

    ; $017885
    .verticalScrollTileOffset
    dw $0410, $F410

    ; $017889
    .Map16BufferOffsetLow
    dw $0000

    ; $01788B
    .Map16BufferOffsetHigh
    dw $0020

    ; Has something to do with seeing whether an area is 2x2 or not?
    ; $01788D
    .overworldScreenSize
    ; LW
    db $00, $00, $01, $00, $00, $00, $00, $01
    db $00, $00, $01, $00, $00, $00, $00, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $01, $00, $00, $01, $00, $00
    db $00, $00, $01, $00, $00, $01, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $01, $01, $01, $00, $00, $01
    db $00, $00, $01, $01, $01, $00, $00, $01

    ; DW
    db $00, $00, $01, $00, $00, $00, $00, $01
    db $00, $00, $01, $00, $00, $00, $00, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $01, $00, $00, $01, $00, $00
    db $00, $00, $01, $00, $00, $01, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $01, $01, $01, $00, $00, $01
    db $00, $00, $01, $01, $01, $00, $00, $01

    ; SP
    db $01, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
}

; ==============================================================================

; $01794D-$017D0C DATA TABLE
Pool_Overworld_LoadMap32:
Pool_LoadSubOverlayMap32:
{
    .high_byte_packs
    dl $0B8000, $0B80D6, $0B81C2, $0B8316
    dl $0B83EA, $0B850E, $0B8671, $0B880F
    dl $0B89D3, $0B8B90, $0BD709, $0B8D24
    dl $0B8EE3, $0B9070, $0B91EA, $0B93CC

    dl $0B9527, $0BE39A, $0BE557, $0B96D5
    dl $0B9843, $0B998C, $0B9B55, $0BEDC2
    dl $0B9D07, $0B9E89, $0BA016, $0BA209
    dl $0BA3A6, $0BA543, $0BA714, $0BA819

    dl $0BA94E, $0BAACE, $0BAC5F, $0BAE22
    dl $0BAFA0, $0C84BD, $0BB140, $0BB2F3
    dl $0BB4B1, $0BB644, $0C8D6C, $0C8F2B
    dl $0C9106, $0BB800, $0C94D0, $0C96BF

    dl $0BB9BB, $0BBAFE, $0BBBFE, $0C9DAF
    dl $0C9F73, $0BBDC7, $0BBFA1, $0CA4BA
    dl $0BC18F, $0BC2A4, $0BC3B8, $0CAC5F
    dl $0CAE37, $0BC590, $0BC76C, $0CB3D2

    dl $0BC93F, $0BCA19, $0BCB5A, $0BCCD0
    dl $0BCE13, $0BCF6C, $0BD0B1, $0BD244
    dl $0BD3F6, $0BD588, $0BD709, $0BD8E9
    dl $0BDAA7, $0BDC4D, $0BDE23, $0BE011

    dl $0BE1DE, $0BE39A, $0BE557, $0BE74B
    dl $0BE8DF, $0BEA37, $0BEC01, $0BEDC2
    dl $0BEF9A, $0BF156, $0BF2F4, $0BF4E4
    dl $0BF5BB, $0BF6B3, $0BF8A4, $0BF9AA

    dl $0BFB15, $0BFCB9, $0C8000, $0C81C4
    dl $0C8321, $0C84BD, $0C8688, $0C880D
    dl $0C89CC, $0C8B9A, $0C8D6C, $0C8F2B
    dl $0C9106, $0C92E8, $0C94D0, $0C96BF

    dl $0C98B0, $0C9A48, $0C9BC2, $0C9DAF
    dl $0C9F73, $0CA132, $0CA329, $0CA4BA
    dl $0CA6B2, $0CA898, $0CAA6D, $0CAC5F
    dl $0CAE37, $0CB016, $0CB20B, $0CB3D2

    dl $0CB83C, $0CB97C, $0CBAF2, $0B8000
    dl $0B8000, $0B8000, $0B8000, $0B8000
    dl $0CC0B4, $0CBCAE, $0CBE4B, $0B8000
    dl $0B8000, $0B8000, $0B8000, $0B8000

    dl $0B8000, $0B8000, $0B8000, $0CC0B4
    dl $0CB83C, $0CBFFA, $0CBFD7, $0CB67B
    dl $0B8000, $0B8000, $0B8000, $0B8000
    dl $0CC0AC, $0CB67B, $0CB5C8, $0CB6BE

    ; $017B2D
    .lower_byte_packs
    dl $0B8004, $0B80DA, $0B8238, $0B8340
    dl $0B8460, $0B85A3, $0B8724, $0B88E0
    dl $0B8A91, $0B8C35, $0BD7F0, $0B8DF6
    dl $0B8F87, $0B9118, $0B92CF, $0B9465

    dl $0B95E7, $0BE468, $0BE64A, $0B9775
    dl $0B98C7, $0B9A65, $0B9C18, $0BEEA7
    dl $0B9DAC, $0B9F39, $0BA107, $0BA2C1
    dl $0BA45E, $0BA622, $0BA746, $0BA86A

    dl $0BA9FB, $0BAB79, $0BAD2E, $0BAECD
    dl $0BB064, $0C8598, $0BB204, $0BB3CA
    dl $0BB567, $0BB718, $0C8E3B, $0C900C
    dl $0C91F1, $0BB8D3, $0C95C4, $0C97B3

    dl $0BBA25, $0BBB3C, $0BBCDA, $0C9E82
    dl $0CA049, $0BBEAC, $0BC08B, $0CA5B3
    dl $0BC200, $0BC300, $0BC49A, $0CAD4A
    dl $0CAF24, $0BC673, $0BC848, $0CB4C8

    dl $0BC948, $0BCA78, $0BCBE3, $0BCD58
    dl $0BCEB0, $0BCFF6, $0BD169, $0BD30B
    dl $0BD4A4, $0BD61C, $0BD7F0, $0BD9BF
    dl $0BDB60, $0BDD2A, $0BDF13, $0BE0F0

    dl $0BE2A3, $0BE468, $0BE64A, $0BE807
    dl $0BE976, $0BEB0F, $0BECCB, $0BEEA7
    dl $0BF067, $0BF213, $0BF3E3, $0BF51F
    dl $0BF612, $0BF7A4, $0BF8DE, $0BFA3F

    dl $0BFBD5, $0BFD6D, $0C80D2, $0C8265
    dl $0C83E6, $0C8598, $0C8734, $0C88DD
    dl $0C8AA4, $0C8C73, $0C8E3B, $0C900C
    dl $0C91F1, $0C93D4, $0C95C4, $0C97B3

    dl $0C996E, $0C9AF4, $0C9CB3, $0C9E82
    dl $0CA049, $0CA226, $0CA3DC, $0CA5B3
    dl $0CA799, $0CA971, $0CAB64, $0CAD4A
    dl $0CAF24, $0CB10C, $0CB2E6, $0CB4C8

    dl $0CB8AC, $0CBA16, $0CBBB9, $0B8004
    dl $0B8004, $0B8004, $0B8004, $0B8004
    dl $0CC0B8, $0CBD5E, $0CBF05, $0B8004
    dl $0B8004, $0B8004, $0B8004, $0B8004

    dl $0B8004, $0B8004, $0B8004, $0CC0B8
    dl $0CB8AC, $0CC044, $0CBFDE, $0CB67F
    dl $0B8004, $0B8004, $0B8004, $0B8004
    dl $0CC0B0, $0CB67F, $0CB5CC, $0CB743
}

; ==============================================================================

; $017D0D-$017D25 LOCAL JUMP LOCATION
LoadSubscreenOverlay:
{
    REP #$30

    ; Loads data for the overlay and converts from map32 to map16.
    JSR.w LoadSubOverlayMap32

    LDA.w #$1000 : STA.b $CC

    SEP #$30

    JSR.w Map16ToMap8_subscreenOverlay

    ; Trigger an NMI routine that will upload the subscreen overlay to
    ; vram during vblank.
    LDA.b #$04 : STA.b $17 : STA.w $0710

    INC.b $11

    RTS
}

; ==============================================================================

; $017D26-$017D86 LOCAL JUMP LOCATION
Map16ToMap8:
{
    !srcAddr    = $04
    !srcBank    = $06
    !counter    = $08

    ; -------------------------------

    .subscreenOverlay

    ; Data bank = 0x0F
    PHB : LDA.b #$0F : PHA : PLB

    REP #$30

    ; $04[3] = $7E4000, which is the source address.
    LDA.w #$4000 : STA !srcAddr
    LDA.w #$007E

    BRA .ready

    ; $017D37 ALTERNATE ENTRY POINT
    .normalArea

    ; Data bank = 0x0F
    PHB : LDA.b #$0F : PHA : PLB

    REP #$30

    ; $04[3] = $7E2000, which is the source address.
    LDA.w #$2000 : STA !srcAddr
    LDA.w #$007E

    .ready

    STA !srcBank

    ; $84 += 0x1000
    LDA.b $84 : CLC : ADC.w #$1000 : STA.b $84

    STZ.b $0A : STA.b $0E

    LDA.w #$0010 : STA !counter

    .conversionLoop

        JSR.w Map16ChunkToMap8

        ; $84 -= 0x0080, $88 = ($88 - 1) % 32
        LDA.b $84 : SEC   : SBC.w #$0080 : STA.b $84
        LDA.b $88 : DEC A : AND.w #$001F : STA.b $88

        JSR.w Map16ChunkToMap8

        ; $84 -= 0x0080, $88 = ($88 - 1) & 32
        LDA.b $84 : SEC   : SBC.w #$0080 : STA.b $84
        LDA.b $88 : DEC A : AND.w #$001F : STA.b $88
    DEC !counter : BNE .conversionLoop

    SEP #$30

    PLB

    RTS
}

; ==============================================================================

; Converts Map16 data to Map8 data (normal tile data) 0x40 bytes at a time.
; Also populates $7F4000 with the addresses of each of the resultant Map8
; chunks.
; $017D87-$017E46 LOCAL JUMP LOCATION
Map16ChunkToMap8:
{
    !srcAddr    = $04
    !map16Buf   = $0500

    ; ---------------------------------------

    ; Y = ($84 - 0x0410) & 0x1FFF
    ; X = $86 << 1
    ; $00 = 0x0010
    LDA.b $84 : SEC : SBC.w #$0410 : AND.w #$1FFF : TAY
    LDA.b $86 : ASL A : TAX
    LDA.w #$0010 : STA.b $00

    .getMap16Chunk

        ; Grab 0x20 map16 tiles (which is a 16 X 512 pixel swath) and populate
        ; the buffer with these tiles.

        LDA.b [!srcAddr], Y : STA !map16Buf, X

        ; X = (X + 2) & 0x003F, Y = (Y + 2) & 0x1FFF
        INX #2 : TXA : AND.w #$003F : TAX
        INY #2 : TYA : AND.w #$1FFF : TAY

        LDA.b [!srcAddr], Y : STA !map16Buf, X

        ; X = (X + 2) & 0x003F, Y = (Y + 2) & 0x1FFF
        INX #2 : TXA : AND.w #$003F : TAX
        INY #2 : TYA : AND.w #$1FFF : TAY
    DEC.b $00 : BNE .getMap16Chunk

    LDA.b $88 : STA.b $02 : CMP.w #$0010 : BCC .inRange
        ; Limit $02 to the range 0x00 to 0x0F
        AND.w #$000F : STA.b $02

        LDA.w #$0800 : STA.b $00

    .inRange

    ; $00 += ($02 * 0x40)
    LDA.b $02 : ASL #6 : CLC : ADC.b $00 : STA.b $00

    ; Why they needed to use a long address for this, I don't know.
    ; LDA.w #$0000 would have sufficed.
    LDA.l Pool_BufferAndBuildMap16Stripes_Map16BufferOffsetLow

    JSR.w .prepForUpload

    ; $00 += 0x0400
    LDA.b $00 : CLC : ADC.w #$0400 : STA.b $00

    ; Why they needed to use a long address for this, I don't know.
    ; LDA.w #$0020 would have sufficed.
    LDA.l Pool_BufferAndBuildMap16Stripes_Map16BufferOffsetHigh

    .prepForUpload

    ; $02 = either 0x0000 or 0x0020.
    STA.b $02

    ; This is how the DMA transfer later knows where to blit to.
    LDX.b $0A : LDA.b $00 : ORA.b $CC : STA.l $7F4000, X : INX #2 : STX.b $0A

    ; The index for the target array.
    LDX.b $0E

    ; Going to loop #$10 times and write #$80 bytes overall.
    LDA.w #$0010 : STA.b $0C

    .nextMap16Tile

        ; Load a map16 value from the buffer at $7E0500.
        LDY.b $02 : LDA.w !map16Buf, Y

        ; Increment to the next map16 value's position.
        INY #2 : STY.b $02

        ; A *= 8
        ASL #3 : TAY

        ; The data in $7F2000 will end up as the tilemap for BG0 or BG1
        ; (depending on settings) Also note that $8000 and its cousins here
        ; represent $0F8000, etc, in actuality.
        LDA.w Map16Definitions_0, Y : STA.l $7F2000, X
        LDA.w Map16Definitions_2, Y : STA.l $7F2040, X : INX #2
        LDA.w Map16Definitions_1, Y : STA.l $7F2000, X
        LDA.w Map16Definitions_3, Y : STA.l $7F2040, X : INX #2
    DEC.b $0C : BNE .nextMap16Tile

    ; Increment the index for the target array by #$40 (since we weren't doing
    ; it during the loop).
    TXA : CLC : ADC.w #$0040 : STA.b $0E

    RTS
}

; ==============================================================================

; When Link warps between worlds and the warp fails, he has to warp  back to
; the world he came from. This routine ensures that any rocks, bushes, signs
; Link picked up before he warped retain that state after he gets warped back.
; If the warp was successful, however, this routine will not be used. This
; prevents you from say, getting stuck on a rock because and having and
; infinite loop of failed warps from the DW to the LW and back. It makes it
; like the warp never happened, from a graphical standpoint.
; $017E47-$017E70 LOCAL JUMP LOCATION
Overworld_RestoreFailedWarpMap16:
{
    REP #$30

    LDA.w $04AC : BEQ .return
        LDX.w #$0000 : STX.b $00

        .loop

            ; Supply the address of the modification to the tilemap
            LDX.b $00 : LDA.l $7EF800, X : TAY

            ; Supply the actual map16 tile value to be used
            LDA.l $7EFA00, X : TYX : STA.l $7E2000, X : INC.b $00 : INC.b $00
        LDA.b $00 : CMP.w $04AC : BNE .loop

    .return

    SEP #$30

    RTS
}

; ==============================================================================

; Decompresses and then stores battle information relevant to enemy sprites.
; $017E71-$017EBA LONG JUMP LOCATION
Intro_LoadSpriteStats:
{
    ; Target address at $00 = $7F4000
    LDA.b #$00 : STA.b $00
    LDA.b #$40 : STA.b $01
    LDA.b #$7F : STA.b $02

    ; Source address at $C8 = $03E800 = $01E800 in ROM.
    LDA.b #$00 : STA.b $C8
    LDA.b #$E8 : STA.b $C9
    LDA.b #$03 : STA.b $CA

    JSR.w Overworld_Decomp

    ; Long address at $00 = $7F4000
    LDA.b #$00 : STA.b $00
    LDA.b #$40 : STA.b $01
    LDA.b #$7F : STA.b $02

    ; Index registers will be 16-bit for the loop.
    REP #$10

    LDX.w #$0000 : TXY

    .loadLoop

        ; Addresses accessed will be $7F4000-$7F47FF
        ; Divide by 16
        LDA.b [$00], Y : PHA : LSR #4 : STA.l $7F6000, X

        ; Get the original value, take the least four bits, and store it at
        ; the high byte location.
        PLA : AND.b #$0F : STA.l $7F6001, X

        ; Addresses written to will be $7F6000-$7F6FFF
        INY
    INX #2 : CPX.w #$1000 : BCC .loadLoop

    SEP #$30

    RTL
}

; ==============================================================================

; A slight variant on the normal Decomp routine (the only difference is an
; extra XBA somewhere in the routine).
; $017EBB-$017F5E LOCAL JUMP LOCATION
Overworld_Decomp:
{
    REP #$10

    LDY.w #$0000

    ; Bleeds into the next funtion.
}

; $017EC0-$017F5E LOCAL JUMP LOCATION
Overworld_Decomp_next_byte:
{
    JSR.w OverworldDecomp_GetNextSourceOctet

    ; Is it 0xFF? If not get data until we get a 0xFF byte.
    CMP.b #$FF : BNE .BRANCH_ITERATE
        ; If yes, set the X-flag and exit the subroutine.
        SEP #$10

        RTS

    .BRANCH_ITERATE

    STA.b $CD : AND.b #$E0 : CMP.b #$E0 : BEQ .BRANCH_EXPANDED ; [111]
        PHA

        LDA.b $CD

        REP #$20

        AND.w #$001F ; Now get me the bottom five bits.

        BRA .BRANCH_NORMAL

    ; EXPANDED MODE APPEARS TO ALLOW US TO INTERFACE WITH VALUES LARGER THAN
    ; #$32, MAYBE AS LARGE AS $132?
    .BRANCH_EXPANDED

    ; Get $CD, and shift it left three times.
    ; Again we're interested in the top three bits.
    LDA.b $CD : ASL #3 : AND.b #$E0 : PHA

    LDA.b $CD : AND.b #$03 : XBA

    JSR.w OverworldDecomp_GetNextSourceOctet

    REP #$20

    .BRANCH_NORMAL

    ; Increment the value and save it to $CB
    INC A : STA.b $CB

    SEP #$20; Return to 8-bit accumulator.

    ; Get the top three bits that were set in $CD.
    ; If none of the top three bits were set: [000]
    PLA : BEQ .BRANCH_NONREPEATING
        BMI .BRANCH_COPY ; If the top most bit was set [101], [110], [100]
            ; Provided nothing shifted into the MSB [001]
            ASL A : BPL .BRANCH_REPEATING
                ; If it was negative, shift again. [010]
                ASL A : BPL .BRANCH_REPEATINGWORD
                    ; And of course the last case, [011]
                    JSR.w OverworldDecomp_GetNextSourceOctet

                    LDX.b $CB

                    .BRANCH_INCREMENTWRITE

                        STA.b [$00], Y

                        INC A

                        INY
                    DEX : BNE .BRANCH_INCREMENTWRITE

                    BRA Overworld_Decomp_next_byte

    .BRANCH_NONREPEATING

        ; Get the next value.
        JSR.w OverworldDecomp_GetNextSourceOctet

        ; Store it at TargetAddress, Y
        STA.b [$00], Y

        INY

        ; This is the bottom LSB's of $CD + 1
        ; Decrement $CB until it's zero.
    LDX.b $CB : DEX : STX.b $CB : BNE .BRANCH_NONREPEATING

    BRA Overworld_Decomp_next_byte

    .BRANCH_REPEATING

    ; Get the next value.
    JSR.w OverworldDecomp_GetNextSourceOctet

    LDX.b $CB ; Get the 5 LSB plus one.

    .BRANCH_LOOPBACK

        ; Store to TargetAddress, Y
        STA.b [$00], Y

        INY

        ; Loop until X = 0.
    DEX : BNE .BRANCH_LOOPBACK

    BRA Overworld_Decomp_next_byte

    .BRANCH_REPEATINGWORD

    JSR.w OverworldDecomp_GetNextSourceOctet

    XBA

    JSR.w OverworldDecomp_GetNextSourceOctet

    LDX.b $CB

    .BRANCH_MOREBYTES

        ; Two byte were read, this is the first one
        XBA : STA.b [$00], Y

        INY

        DEX : BEQ .BRANCH_OUTOFBYTES
            ; Store the second value, alternate, repeat.
            XBA : STA.b [$00], Y

            INY
    DEX : BNE .BRANCH_MOREBYTES

    .BRANCH_OUTOFBYTES

    JMP.w Overworld_Decomp_next_byte

    .BRANCH_COPY

    ; If the topmost bit was set, retrieve the next value.

    JSR.w OverworldDecomp_GetNextSourceOctet

    XBA ; Exchange the accumulators.

    JSR.w OverworldDecomp_GetNextSourceOctet

    TAX ; Put that sucker in X (full 16-bit)

    .BRANCH_LOOPBACK2

        ; And push the current Y index, Then shove X into Y (The newest byte
        ; value).
        PHY : TXY

        ; Load from TargetAddress, Y
        LDA.b [$00], Y : TYX

        ; Retrieve the proper index
        PLY

        STA.b [$00], Y

        INY

        INX

        REP #$20
    DEC.b $CB : SEP #$20 : BNE .BRANCH_LOOPBACK2

    JMP.w Overworld_Decomp_next_byte
}

; ==============================================================================

; $017F5F-$017F6D LOCAL JUMP LOCATION
OverworldDecomp_GetNextSourceOctet:
{
    LDA.b [$C8]

    LDX.b $C8 : INX : BNE .didnt_cross_bank_boundary
        ; Made to avoid crossing the 0x8000 wide bank bounds
        ; We can see this since $CA (the bank) is incremented.
        LDX.w #$8000

        INC.b $CA

    .didnt_cross_bank_boundary

    ; X might be one more than it was, or 0x8000, depending.
    STX.b $C8

    RTS
}

; ==============================================================================

; $017F6E-$017FFF NULL (Use for expansion)
NULL_02FF6E:
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
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
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

warnpc $038000
