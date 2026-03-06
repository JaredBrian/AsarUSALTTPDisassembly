; ==============================================================================
; Bank 0x06
; ==============================================================================
; APU Data and Engine

print "Start of Bank 0x06: $", pc

; ==============================================================================

; TODO: Remove these temp vars.
SongToPlay = $01
!SongBank = $00

SongBank00:
{
    ; Transfer size, transfer address
    if !SongBank == 0
    dw .end-.start, SONG_POINTERS
    endif

    .start

    base SONG_POINTERS
    
    if !SongBank == 0
    dw Song01_TestSong              ; 0x01
    dw Song02_Lace                  ; 0x02
    dw Song03_AstralObservatory     ; 0x03
    dw Song04_FrozenHyrule          ; 0x04
    dw Song05_Bellhart              ; 0x05
    dw Song06_AnotherWinter         ; 0x06
    dw Song07_ArcanaCavernOfIce     ; 0x07
    dw Song08_CaveOfWonders         ; 0x08
    dw $0000                        ; 0x09
    dw $0000                        ; 0x0A
    dw $0000                        ; 0x0B
    dw $0000                        ; 0x0C
    dw $0000                        ; 0x0D
    dw $0000                        ; 0x0E
    dw $0000                        ; 0x0F
    dw $0000                        ; 0x10
    dw $0000                        ; 0x11
    dw $0000                        ; 0x12
    dw $0000                        ; 0x13
    dw $0000                        ; 0x14
    dw $0000                        ; 0x15
    dw $0000                        ; 0x16
    dw $0000                        ; 0x17
    dw $0000                        ; 0x18
    dw $0000                        ; 0x19
    dw $0000                        ; 0x1A
    dw $0000                        ; 0x1B
    dw $0000                        ; 0x1C
    dw $0000                        ; 0x1D
    dw $0000                        ; 0x1E
    dw $0000                        ; 0x1F
    dw $0000                        ; 0x20
    dw $0000                        ; 0x21
    dw $0000                        ; 0x22
    dw $0000                        ; 0x23
    endif

    ZarbyTypeBlock:
    {
        if !SongBank == 0
        ;incsrc "Data/Music/MusicMacros.asm"

        Song01_TestSong:
        ;incsrc "Data/Music/TestSong.asm"

        Song02_Lace:
        ;incsrc "Data/Music/Lace.asm"

        Song03_AstralObservatory:
        ;incsrc "Data/Music/AstralObservatory.asm"

        Song04_FrozenHyrule:
        ;incsrc "Data/Music/FrozenHyrule.asm"

        Song06_AnotherWinter:
        ;incsrc "Data/Music/AnotherWinter.asm"

        Song07_ArcanaCavernOfIce:
        ;incsrc "Data/Music/ArcanaCavernOfIce.asm"

        Song08_CaveOfWonders:
        ;incsrc "Data/Music/CaveOfWonders.asm"

        ;incsrc "Data/Music/TempleOfDroplets.asm"
        ;incsrc "Data/Music/DungeonThemeV1-00.asm"
        ;incsrc "Data/Music/LostWoodsThemeV1-00.asm"
        ;incsrc "Data/Music/PalaceThemeV1-00.asm"
        ;incsrc "Data/Music/Winters.asm"
        ;incsrc "Data/Music/Z3_GreatDekuTreeThemeV1-00.asm"
        ;incsrc "Data/Music/Z3_MountainVillageV1-10.asm"

        ;incsrc "Data/Music/BOTWHyruleCastle.asm"
        ;incsrc "Data/Music/GST.asm"
        ;incsrc "Data/Music/SuperMarioLandThemeV1-00.asm"
        endif
    }

    Song05_Bellhart:
    {
        base off

        if !SongBank == 0
        incsrc "Data/Music/defines_music.asm"
        incsrc "Data/Music/Bellhart.asm"
        endif
    }

    assert pc() <= SongBank00_start+$3000, "SongBank00 exceeds ARAM: ", pc

    SongBank00_end:

    if !SongBank == 0
    ; End transfer
    ; This tells the APU the transfer is done and to reset itself.
    dw $0000, SPC_ENGINE
    endif
}

; ==============================================================================

SongBank_Overworld_Main:
{
    ; Transfer size, transfer address
    if !SongBank == 1
    dw .end-.start, SONG_POINTERS
    endif

    .start

    base SONG_POINTERS

    if !SongBank == 1
    dw Song01_TriforceIntro         ; 0x01
    dw Song02_LightWorldOverture    ; 0x02
    dw Song03_Rain                  ; 0x03
    dw Song04_BunnyTheme            ; 0x04
    dw Song05_LostWoods             ; 0x05
    dw Song06_LegendsTheme_Attract  ; 0x06
    dw Song07_KakarikoVillage       ; 0x07
    dw Song08_MirrorWarp            ; 0x08
    dw Song09_DarkWorld             ; 0x09
    dw Song0A_PullingTheMasterSword ; 0x0A
    dw Song0B_FairyTheme            ; 0x0B
    dw Song0C_Fugitive              ; 0x0C
    dw Song0D_SkullWoodsMarch       ; 0x0D
    dw Song0E_MinigameTheme         ; 0x0E
    dw Song0F_IntroFanfare          ; 0x0F
    dw Song10_HyruleCastle          ; 0x10
    dw Song11_PendantDungeon        ; 0x11
    dw Song12_Cave                  ; 0x12
    dw Song13_Fanfare               ; 0x13
    dw Song14_Sanctuary             ; 0x14
    dw Song15_Boss                  ; 0x15
    dw Song16_CrystalDungeon        ; 0x16
    dw Song17_Shop                  ; 0x17
    dw Song12_Cave                  ; 0x18
    dw Song19_ZeldaRescue           ; 0x19
    dw Song1A_CrystalMaiden         ; 0x1A
    dw Song1B_BigFairy              ; 0x1B
    endif

    ; SPC $D036-$D0FE DATA
    Song01_TriforceIntro:
    {
        if !SongBank == 1
        incbin "Data/Music/01_TriforceIntro.bin" ; size: 0x00C8
        endif
    }

    ; SPC $D0FF-$D869 DATA
    Song02_LightWorldOverture:
    {
        if !SongBank == 1
        incbin "Data/Music/02_LightWorldOverture.bin" ; size: 0x076A
        endif
    }

    ; SPC $D86A-$DCA6 DATA
    Song03_Rain:
    {
        if !SongBank == 1
        incbin "Data/Music/03_Rain.bin" ; size: 0x043D
        endif
    }

    ; SPC $DCA7-$DEE4 DATA
    Song04_BunnyTheme:
    {
        if !SongBank == 1
        incbin "Data/Music/04_BunnyTheme.bin" ; size: 0x023E
        endif
    }

    ; SPC $DEE5-$E369 DATA
    Song05_LostWoods:
    {
        if !SongBank == 1
        incbin "Data/Music/05_LostWoods.bin" ; size: 0x0485
        endif
    }

    ; SPC $E36A-$E8DB DATA
    Song06_LegendsTheme_Attract:
    {
        if !SongBank == 1
        incbin "Data/Music/06_LegendsTheme_Attract.bin" ; size: 0x0572
        endif
    }

    ; SPC $E8DC-$EE10 DATA
    Song07_KakarikoVillage:
    {
        if !SongBank == 1
        incbin "Data/Music/07_KakarikoVillage.bin" ; size: 0x0535
        endif
    }

    ; SPC $EE11-$EF6C DATA
    Song08_MirrorWarp:
    {
        if !SongBank == 1
        incbin "Data/Music/08_MirrorWarp.bin" ; size: 0x015C
        endif
    }

    ; SPC $EF6D-$F812 DATA
    Song09_DarkWorld:
    {
        if !SongBank == 1
        incbin "Data/Music/09_DarkWorld.bin" ; size: 0x08A6
        endif
    }

    ; SPC $F813-$F8F5 DATA
    Song0A_PullingTheMasterSword:
    {
        if !SongBank == 1
        incbin "Data/Music/0A_PullingTheMasterSword.bin" ; size: 0x00E3
        endif
    }

    ; SPC $F8F6-$FAF9 DATA
    Song0C_Fugitive:
    {
        if !SongBank == 1
        incbin "Data/Music/0C_Fugitive.bin" ; size: 0x0204
        endif
    }

    ; SPC $FAFA-$FDAE DATA
    Song0F_IntroFanfare:
    {
        if !SongBank == 1
        incbin "Data/Music/0F_IntroFanfare.bin" ; size: 0x02B4
        endif
    }

    base off

    SongBank_Overworld_Main_end:

    assert pc() <= SongBank_Overworld_Main_start+$3000, "SongBank_Overworld_Main exceeds ARAM: ", pc
}

SongBank_Fairy:
{
    ; Transfer size, transfer address
    if !SongBank == 1
    dw .end-.start, SONG_FAIRY_POINTER
    endif

    .start

    ; SPC $2880-$2A8C DATA
    base SONG_FAIRY_POINTER

    Song0B_FairyTheme:
    {
        if !SongBank == 1
        incbin "Data/Music/0B_FairyTheme.bin"
        endif
    }

    base off

    SongBank_Fairy_end:
}

SongBank_Overworld_Auxiliary:
{
    ; Transfer size, transfer address
    if !SongBank == 1
    dw .end-.start, SONG_POINTERS_AUX
    endif

    .start

    base SONG_POINTERS_AUX

    ; SPC $2B00-$2FA5 DATA
    Song0D_SkullWoodsMarch:
    {
        if !SongBank == 1
        incbin "Data/Music/0D_SkullWoodsMarch.bin"
        endif
    }

    ; SPC $2FA6-$3187 DATA
    Song0E_MinigameTheme:
    {
        if !SongBank == 1
        incbin "Data/Music/0E_MinigameTheme.bin" ; TODO: This one is broken.
        endif
    }

    base off

    SongBank_Overworld_Auxiliary_end:

    assert pc() <= SongBank_Overworld_Auxiliary_start+$1100, "SongBank_Overworld_Auxiliary exceeds SAMPLE_POINTERS: ", pc

    if !SongBank == 1
    ; End transfer
    ; This tells the APU the transfer is done and to reset itself.
    dw $0000, SPC_ENGINE
    endif
}

; ==============================================================================

SongBank_Credits_Main:
{
    ; Transfer size, transfer address
    if !SongBank == 2
    dw .end-.start, SONG_POINTERS
    endif

    .start

    base SONG_POINTERS

    if !SongBank == 2
    dw Song01_TriforceIntro         ; 0x01
    dw Song02_LightWorldOverture    ; 0x02
    dw Song03_Rain                  ; 0x03
    dw Song04_BunnyTheme            ; 0x04
    dw Song05_LostWoods             ; 0x05
    dw Song06_LegendsTheme_Attract  ; 0x06
    dw Song07_KakarikoVillage       ; 0x07
    dw Song08_MirrorWarp            ; 0x08
    dw Song09_DarkWorld             ; 0x09
    dw Song0A_PullingTheMasterSword ; 0x0A
    dw Song0B_FairyTheme            ; 0x0B
    dw Song0C_Fugitive              ; 0x0C
    dw Song0D_SkullWoodsMarch       ; 0x0D
    dw Song0E_MinigameTheme         ; 0x0E
    dw Song0F_IntroFanfare          ; 0x0F
    dw Song10_HyruleCastle          ; 0x10
    dw Song11_PendantDungeon        ; 0x11
    dw Song12_Cave                  ; 0x12
    dw Song13_Fanfare               ; 0x13
    dw Song14_Sanctuary             ; 0x14
    dw Song15_Boss                  ; 0x15
    dw Song16_CrystalDungeon        ; 0x16
    dw Song17_Shop                  ; 0x17
    dw Song12_Cave                  ; 0x18
    dw Song19_ZeldaRescue           ; 0x19
    dw Song1A_CrystalMaiden         ; 0x1A
    dw Song1B_BigFairy              ; 0x1B
    dw Song1C_Suspense              ; 0x1C
    dw Song1D_AgahnimEscapes        ; 0x1D
    dw Song1E_MeetingGanon          ; 0x1E
    dw Song1F_KingOfThieves         ; 0x1F
    dw Song20_TriforceRoom          ; 0x20
    dw Song21_EndingTheme           ; 0x21
    dw Song22_Credits               ; 0x22
    dw $0000                        ; 0x23

    incsrc "Data/Music/MusicMacros.asm"
    endif

    ; SPC $D046-$D2FC DATA
    Song20_TriforceRoom:
    {
        if !SongBank == 2
        incbin "Data/Music/20_TriforceRoom.bin"
        endif
    }

    ; SPC $D2FD-$E05F DATA
    Song22_Credits:
    {
        if !SongBank == 2
        ;incbin "Data/Music/22_Credits.bin"
        incsrc "Data/Music/22_Credits.asm"
        endif
    }

    base off

    SongBank_Credits_Main_end:

    assert pc() <= SongBank_Credits_Main_start+$1100, "SongBank_Credits_Main exceeds SAMPLE_POINTERS: ", pc
}

SongBank_Credits_Auxiliary:
{
    ; Transfer size, transfer address
    if !SongBank == 2
    dw .end-.start, CREDITS_AUX_POINTER
    endif

    .start

    base CREDITS_AUX_POINTER

    ; SPC $2900-$3937 DATA
    ; $0D63E8-$0D741F DATA
    Song21_EndingTheme:
    {
        if !SongBank == 2
        incbin "Data/Music/21_EndingTheme.bin"
        endif
    }

    base off

    SongBank_Credits_Auxiliary_end:

    assert pc() <= SongBank_Credits_Auxiliary_start+$1300, "SongBank_Credits_Auxiliary exceeds SAMPLE_POINTERS: ", pc

    if !SongBank == 2
    ; End transfer
    ; This tells the APU the transfer is done and to reset itself.
    dw $0000, SPC_ENGINE
    endif
}

; ==============================================================================

SongBank_Underworld_Main:
{
    ; Transfer size, transfer address
    if !SongBank == 3
    dw .end-.start, SONG_POINTERS
    endif

    .start

    base SONG_POINTERS

    if !SongBank == 3
    dw Song01_TriforceIntro         ; 0x01
    dw Song02_LightWorldOverture    ; 0x02
    dw Song03_Rain                  ; 0x03
    dw Song04_BunnyTheme            ; 0x04
    dw Song05_LostWoods             ; 0x05
    dw Song06_LegendsTheme_Attract  ; 0x06
    dw Song07_KakarikoVillage       ; 0x07
    dw Song08_MirrorWarp            ; 0x08
    dw Song09_DarkWorld             ; 0x09
    dw Song0A_PullingTheMasterSword ; 0x0A
    dw Song0B_FairyTheme            ; 0x0B
    dw Song0C_Fugitive              ; 0x0C
    dw Song0D_SkullWoodsMarch       ; 0x0D
    dw Song0E_MinigameTheme         ; 0x0E
    dw Song0F_IntroFanfare          ; 0x0F
    dw Song10_HyruleCastle          ; 0x10
    dw Song11_PendantDungeon        ; 0x11
    dw Song12_Cave                  ; 0x12
    dw Song13_Fanfare               ; 0x13
    dw Song14_Sanctuary             ; 0x14
    dw Song15_Boss                  ; 0x15
    dw Song16_CrystalDungeon        ; 0x16
    dw Song17_Shop                  ; 0x17
    dw Song12_Cave                  ; 0x18
    dw Song19_ZeldaRescue           ; 0x19
    dw Song1A_CrystalMaiden         ; 0x1A
    dw Song1B_BigFairy              ; 0x1B
    dw Song1C_Suspense              ; 0x1C
    dw Song1D_AgahnimEscapes        ; 0x1D
    dw Song1E_MeetingGanon          ; 0x1E
    dw Song1F_KingOfThieves         ; 0x1F
    dw Song20_TriforceRoom          ; 0x20
    dw Song21_EndingTheme           ; 0x21
    dw Song22_Credits               ; 0x22
    dw $0000                        ; 0x23

    incsrc "Data/Music/MusicMacros.asm"
    endif

    ; SPC $D046-$DBEB DATA
    Song10_HyruleCastle:
    {
        if !SongBank == 3
        ;incbin "Data/Music/10_HyruleCastle.bin" ; Size: 0x0BA6
        incsrc "Data/Music/10_HyruleCastle.asm"
        endif
    }

    ; SPC $DBEC-$E139 DATA
    Song11_PendantDungeon:
    {
        if !SongBank == 3
        incbin "Data/Music/11_PendantDungeon.bin" ; Size: 0x054E
        endif
    }

    ; SPC $E13A-$E430 DATA
    Song12_Cave:
    {
        if !SongBank == 3
        incbin "Data/Music/12_Cave.bin" ; Size: 0x02F7
        endif
    }

    ; SPC $E431-$E6F8 DATA
    Song13_Fanfare:
    {
        if !SongBank == 3
        incbin "Data/Music/13_Fanfare.bin" ; Size: 0x02C8
        endif
    }

    ; SPC $E6F9-$E91D DATA
    Song14_Sanctuary:
    {
        if !SongBank == 3
        incbin "Data/Music/14_Sanctuary.bin" ; Size: 0x0225
        endif
    }

    ; SPC $E91E-$EC0A DATA
    Song15_Boss:
    {
        if !SongBank == 3
        incbin "Data/Music/15_Boss.bin" ; Size: 0x02ED
        endif
    }

    ; SPC $EC0B-$F1D0 DATA
    Song16_CrystalDungeon:
    {
        if !SongBank == 3
        incbin "Data/Music/16_CrystalDungeon.bin" ; Size: 0x05C6
        endif
    }

    ; SPC $F1D1-$F303 DATA
    Song17_Shop:
    {
        if !SongBank == 3
        incbin "Data/Music/17_Shop.bin" ; Size: 0x0133
        endif
    }

    ; SPC $F304-$F57F DATA
    Song19_ZeldaRescue:
    {
        if !SongBank == 3
        incbin "Data/Music/19_ZeldaRescue.bin" ; Size: 0x027C
        endif
    }

    ; SPC $F580-$F908 DATA
    Song1A_CrystalMaiden:
    {
        if !SongBank == 3
        incbin "Data/Music/1A_CrystalMaiden.bin" ; Size: 0x0389
        endif
    }

    ; SPC $F909-$FB69 DATA
    Song1B_BigFairy:
    {
        if !SongBank == 3
        incbin "Data/Music/1B_BigFairy.bin" ; Size: 0x0261
        endif
    }

    ; SPC $FB6A-$FCBF DATA
    Song1C_Suspense:
    {
        if !SongBank == 3
        incbin "Data/Music/1C_Suspense.bin" ; Size: 0x0155
        endif
    }

    base off

    SongBank_Underworld_Main_end:

    assert pc() <= SongBank_Credits_Auxiliary_start+$3000, "SongBank_Underworld_Main exceeds ARAM: ", pc
}

SongBank_Underworld_Auxiliary:
{
    ; Transfer size, transfer address
    if !SongBank == 3
    dw .end-.start, SONG_POINTERS_AUX
    endif

    .start

    ; SPC $2B00-$300C DATA
    base SONG_POINTERS_AUX

    ; SPC $2B00-$2BB2 DATA
    Song1D_AgahnimEscapes:
    {
        if !SongBank == 3
        incbin "Data/Music/1D_AgahnimEscapes.bin"
        endif
    }

    ; SPC $2BB3-$2F58 DATA
    Song1F_KingOfThieves:
    {
        if !SongBank == 3
        incbin "Data/Music/1F_KingOfThieves.bin"
        endif
    }

    ; SPC $2F59-$300C DATA
    Song1E_MeetingGanon:
    {
        if !SongBank == 3
        incbin "Data/Music/1E_MeetingGanon.bin"
        endif
    }

    base off

    SongBank_Underworld_Auxiliary_end:

    assert pc() <= SongBank_Underworld_Auxiliary_start+$1100, "SongBank_Credits_Auxiliary exceeds SAMPLE_POINTERS: ", pc

    if !SongBank == 3
    ; End transfer
    ; This tells the APU the transfer is done and to reset itself.
    dw $0000, SPC_ENGINE
    endif
}

; ==============================================================================

print "End of Bank 0x06:   $", pc
print " "

; ==============================================================================