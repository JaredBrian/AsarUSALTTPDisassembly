; ==============================================================================

; Bank 0x1B
; $0D8000-$0DFFFF
org $1B8000

; Dungeon music data
; Entrance code
; Tile interatction
; Special dungeon entrance animations
;  (Palace of darkness, Skull Woods, Mire, etc.)

; ==============================================================================

; $0D8000-$0DACC2 DATA
SongBank_Underworld_Main:
{
    ; Transfer size, transfer address
    dw .end-.start, SONG_POINTERS

    .start

    ; SPC $D000-$FCBF DATA
    ; $0D8004-$0DACC2 DATA
    base SONG_POINTERS

    dw $0000                 ; 0x01
    dw $0000                 ; 0x02
    dw $0000                 ; 0x03
    dw $0000                 ; 0x04
    dw $0000                 ; 0x05
    dw $0000                 ; 0x06
    dw $0000                 ; 0x07
    dw $0000                 ; 0x08
    dw $0000                 ; 0x09
    dw $0000                 ; 0x0A
    dw Song0B_FairyTheme     ; 0x0B
    dw $0000                 ; 0x0C
    dw $0000                 ; 0x0D
    dw $0000                 ; 0x0E
    dw $0000                 ; 0x0F
    dw Song10_HyruleCastle   ; 0x10
    dw Song11_PendantDungeon ; 0x11
    dw Song12_Cave           ; 0x12
    dw Song13_Fanfare        ; 0x13
    dw Song14_Sanctuary      ; 0x14
    dw Song15_Boss           ; 0x15
    dw Song16_CrystalDungeon ; 0x16
    dw Song17_Shop           ; 0x17
    dw Song12_Cave           ; 0x18
    dw Song19_ZeldaRescue    ; 0x19
    dw Song1A_CrystalMaiden  ; 0x1A
    dw Song1B_BigFairy       ; 0x1B
    dw Song1C_Suspense       ; 0x1C
    dw Song1D_AgahnimEscapes ; 0x1D
    dw Song1E_MeetingGanon   ; 0x1E
    dw Song1F_KingOfThieves  ; 0x1F
    dw $0000                 ; 0x20
    dw Song1D_AgahnimEscapes ; 0x21
    dw Song1E_MeetingGanon   ; 0x22
    dw Song1F_KingOfThieves  ; 0x23

    ; SPC $D046-$DBEB DATA
    ; $0D804A-$0D8BEF DATA
    Song10_HyruleCastle:
    {
        incbin "bin/music/song10.bin" ; Size: 0x0BA6
    }

    ; SPC $DBEC-$E139 DATA
    ; $0D8BF0-$0D913D DATA
    Song11_PendantDungeon:
    {
        incbin "bin/music/song11.bin" ; Size: 0x054E
    }

    ; SPC $E13A-$E430 DATA
    ; $0D913E-$0D9434 DATA
    Song12_Cave:
    {
        incbin "bin/music/song12.bin" ; Size: 0x02F7
    }

    ; SPC $E431-$E6F8 DATA
    ; $0D9435-$0D96FC DATA
    Song13_Fanfare:
    {
        incbin "bin/music/song13.bin" ; Size: 0x02C8
    }

    ; SPC $E6F9-$E91D DATA
    ; $0D96FD-$0D9921 DATA
    Song14_Sanctuary:
    {
        incbin "bin/music/song14.bin" ; Size: 0x0225
    }

    ; SPC $E91E-$EC0A DATA
    ; $0D9922-$0D9C0E DATA
    Song15_Boss:
    {
        incbin "bin/music/song15.bin" ; Size: 0x02ED
    }

    ; SPC $EC0B-$F1D0 DATA
    ; $0D9C0F-$0DA1D4 DATA
    Song16_CrystalDungeon:
    {
        incbin "bin/music/song16.bin" ; Size: 0x05C6
    }

    ; SPC $F1D1-$F303 DATA
    ; $0DA1D5-$0DA307 DATA
    Song17_Shop:
    {
        incbin "bin/music/song17.bin" ; Size: 0x0133
    }

    ; SPC $F304-$F57F DATA
    ; $0DA308-$0DA583 DATA
    Song19_ZeldaRescue:
    {
        incbin "bin/music/song19.bin" ; Size: 0x027C
    }

    ; SPC $F580-$F908 DATA
    ; $0DA584-$0DA90C DATA
    Song1A_CrystalMaiden:
    {
        incbin "bin/music/song1A.bin" ; Size: 0x0389
    }

    ; SPC $F909-$FB69 DATA
    ; $0DA90D-$0DAB6D DATA
    Song1B_BigFairy:
    {
        incbin "bin/music/song1B.bin" ; Size: 0x0261
    }

    ; SPC $FB6A-$FCBF DATA
    ; $0DAB6E-$0DACC2 DATA
    Song1C_Suspense:
    {
        incbin "bin/music/song1C.bin" ; Size: 0x0155
    }

    base off

    SongBank_Underworld_Main_end:
}

; ==============================================================================

; $0DACC3-$0DB1D2 DATA
SongBank_Underworld_Auxiliary:
{
    ; Transfer size, transfer address
    dw .end-.start, SONG_POINTERS_AUX

    .start

    ; SPC $2B00-$300C DATA
    ; $0DACC7-$0DB1D2 DATA
    base SONG_POINTERS_AUX

    ; SPC $2B00-$2BB2 DATA
    ; $0DACC7-$0DAD79 DATA
    Song1D_AgahnimEscapes:
    {
        incbin "bin/music/song1D.bin"
    }

    ; SPC $2BB3-$2F58 DATA
    ; $0DAD7A-$0DB11F DATA
    Song1F_KingOfThieves:
    {
        incbin "bin/music/song1F.bin"
    }

    ; SPC $2F59-$300C DATA
    ; $0DB120-$0DB1D2 DATA
    Song1E_MeetingGanon:
    {
        incbin "bin/music/song1E.bin"
    }

    base off

    SongBank_Underworld_Auxiliary_end:
}

; ==============================================================================

; End of transfer
; $0DB1D3-$0DB1D6 DATA
SongBank_Underworld_End:
{
    dw $0000, SPC_ENGINE
}

; ==============================================================================
; End of SPC Code/Data in this bank.
; ==============================================================================

; $0DB1D7-$0DB1DF DATA
GARBAGE_1BB1D7:
{
    db $C0, $00, $00, $00, $00, $01, $FF, $00, $00
}

; $0DB1E0-$0DB7FF NULL
NULL_1BB1E0:
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
}

; ==============================================================================

; $0DB800-$0DB85F DATA
Pool_Overworld_Hole:
{
    ; $0DB800 - Tile16 coordinates for holes.
    .Tile16
    dw $0CE0, $124E, $12CE, $1162, $11E2, $073C, $07BC, $0CE0
    dw $003C, $00BE, $003E, $0388, $0170, $03A4, $0424, $0518
    dw $028A, $020A, $0108
    
    ; $0DB826 - Area numbers for holes.
    .area
    dw $0040, $0040, $0040, $0040, $0040, $0040, $0040, $0000
    dw $005B, $005B, $005B, $0015, $001B, $0022, $0022, $0002
    dw $0018, $0018, $0014
    
    ; $0DB84C - Dungeon entrance to go into.
    .entrance
    db $76, $77, $77, $78, $78, $79, $79, $7A
    db $7B, $7B, $7B, $7C, $7D, $7E, $7E, $7F
    db $80, $80, $81, $82
}

; Routine used to find the entrance to send Link to when he falls into a hole.
; $0DB860-$0DB8BE LONG JUMP LOCATION
Overworld_Hole:
{
    PHB : PHK : PLB
    
    REP #$31
    
    LDA.b $20 : AND.w #$FFF8 : STA.b $00
    SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
    
    LDA.b $22 : AND.w #$FFF8 : LSR #3 : STA.b $02
    SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $06 : STA.b $00
    
    LDX.w #$0024

    .nextHole

        LDA.b $00 : CMP Pool_Overworld_Hole_Tile16, X : BNE .wrongTile16
            LDA.w $040A : CMP Pool_Overworld_Hole_area, X : BEQ .matchedHole
                .wrongTile16
    DEX : DEX : BPL .nextHole
    
    ; Send us to the Chris Houlihan room.      
    LDX.w #$0026
    
    SEP #$20
    
    ; Put Link in the Light World.
    LDA.b #$00 : STA.l $7EF3CA

    .matchedHole

    SEP #$30
    
    ; Set an entrance index...
    TXA : LSR : TAX
    LDA.w Pool_Overworld_Hole_entrance, X : STA.w $010E
                                            STZ.w $010F
    
    PLB
    
    RTL
}

; $0DB8BF-$0DBBF3 DATA
Pool_Overworld_Entrance:
{
    ; Chr types indicating door entrances right
    ; $0DB8BF
    .ValidDoorTypes_Right
    dw $00FE ; 0x00 - Hyrule Castle Opened big doors
    dw $00C5 ; 0x01 - Normal Houses
    dw $00FE ; 0x02 - Unused
    dw $0114 ; 0x03 - Unused
    dw $0115 ; 0x04 - Unused
    dw $0175 ; 0x05 - Unused
    dw $0156 ; 0x06 - Sanctuary Opened Entrance
    dw $00F5 ; 0x07 - Bombable Hut Opened Entrances
    dw $00E2 ; 0x08 - Tavern Back Entrance
    dw $01EF ; 0x09 - Cave Entrances
    dw $0119 ; 0x0A - Unused
    dw $00FE ; 0x0B - Main Desert Palace Entrance
    dw $0172 ; 0x0C - Unused
    dw $0177 ; 0x0D - East and West Desert Palace Entrance
    dw $013F ; 0x0E - King's Tomb Opened Entrance
    dw $0172 ; 0x0F - Unused
    dw $0112 ; 0x10 - Unused
    dw $0161 ; 0x11 - Small Skull Woods Skull Entrances
    dw $0172 ; 0x12 - Swamp Palace and Light World Dam Entrances
    dw $014C ; 0x13 - Unused
    dw $0156 ; 0x14 - Unused
    dw $01EF ; 0x15 - Old Man Home Cave Entrance
    dw $00FE ; 0x16 - Unused
    dw $00FE ; 0x17 - Misery Mire Opened Entrances
    dw $00FE ; 0x18 - Hyrule Castle Secret Stairs Entrance
    dw $010B ; 0x19 - Ice Palace Entrance
    dw $0173 ; 0x1A - Eastern Palace Entrance
    dw $0143 ; 0x1B - Tower of Hera Entrance
    dw $0149 ; 0x1C - Sahasrahla's Hideout Entrance
    dw $0175 ; 0x1D - Unused
    dw $0103 ; 0x1E - House near Palace of Darkness
    dw $0100 ; 0x1F - Pyramid Wall Entrance
    dw $01CC ; 0x20 - Waterfall of Wishing Entrance
    dw $015E ; 0x21 - Turtle Rock Opened Entrance
    dw $0167 ; 0x22 - Cave Entrances
    dw $0128 ; 0x23 - Lost Woods Hideout Entrance
    dw $0131 ; 0x24 - Ganon's Tower Intermediate Animation Entrance
    dw $0112 ; 0x25 - Palace of Darkness Opened Entrance
    dw $016D ; 0x26 - Skull Woods Opened Entrance
    dw $0163 ; 0x27 - Blind's Old Hideout in Kakariko Entrance
    dw $0173 ; 0x28 - Lost Woods Chest Game Entrance
    dw $00FE ; 0x29 - Flat Ground Cave Entrances
    dw $0113 ; 0x2A - Thieves' Town Opened Entrance
    dw $0177 ; 0x2B - Pyramid Fat Fairy Entrance
    
    ; Chr types indicating door entrances left
    ; $0DB917
    .ValidDoorTypes_Left
    dw $014A ; 0x00 - Hyrule Castle Opened big doors
    dw $00C4 ; 0x01 - Normal Houses
    dw $014F ; 0x02 - Unused
    dw $0115 ; 0x03 - Unused
    dw $0114 ; 0x04 - Unused
    dw $0174 ; 0x05 - Unused
    dw $0155 ; 0x06 - Sanctuary Opened Entrance
    dw $00F5 ; 0x07 - Bombable Hut Opened Entrances
    dw $00EE ; 0x08 - Tavern Back Entrance
    dw $01EB ; 0x09 - Cave Entrances
    dw $0118 ; 0x0A - Unused
    dw $0146 ; 0x0B - Main Desert Palace Entrance
    dw $0171 ; 0x0C - Unused
    dw $0155 ; 0x0D - East and West Desert Palace Entrance
    dw $0137 ; 0x0E - King's Tomb Opened Entrance
    dw $0174 ; 0x0F - Unused
    dw $0173 ; 0x10 - Unused
    dw $0121 ; 0x11 - Small Skull Woods Skull Entrances
    dw $0164 ; 0x12 - Swamp Palace and Light World Dam Entrances
    dw $0155 ; 0x13 - Unused
    dw $0157 ; 0x14 - Unused
    dw $0128 ; 0x15 - Old Man Home Cave Entrance
    dw $0114 ; 0x16 - Unused
    dw $0123 ; 0x17 - Misery Mire Opened Entrances
    dw $0113 ; 0x18 - Hyrule Castle Secret Stairs Entrance
    dw $0109 ; 0x19 - Ice Palace Entrance
    dw $0118 ; 0x1A - Eastern Palace Entrance
    dw $0161 ; 0x1B - Tower of Hera Entrance
    dw $0149 ; 0x1C - Sahasrahla's Hideout Entrance
    dw $0117 ; 0x1D - Unused
    dw $0174 ; 0x1E - House near Palace of Darkness
    dw $0101 ; 0x1F - Pyramid Wall Entrance
    dw $01CC ; 0x20 - Waterfall of Wishing Entrance
    dw $0131 ; 0x21 - Turtle Rock Opened Entrance
    dw $0051 ; 0x22 - Cave Entrances
    dw $014E ; 0x23 - Lost Woods Hideout Entrance
    dw $0131 ; 0x24 - Ganon's Tower Intermediate Animation Entrance
    dw $0112 ; 0x25 - Palace of Darkness Opened Entrance
    dw $017A ; 0x26 - Skull Woods Opened Entrance
    dw $0163 ; 0x27 - Blind's Old Hideout in Kakariko Entrance
    dw $0172 ; 0x28 - Lost Woods Chest Game Entrance
    dw $01BD ; 0x29 - Flat Ground Cave Entrances
    dw $0152 ; 0x2A - Thieves' Town Opened Entrance
    dw $0167 ; 0x2B - Pyramid Fat Fairy Entrance

    ; $0DB96F Area list for entrances
    .Screens
    dw $002C ; 0x00 Link's house
    dw $0013 ; 0x01 Sanctuary
    dw $001B ; 0x02 Castle west wing
    dw $001B ; 0x03 Castle lobby
    dw $001B ; 0x04 Castle east wing
    dw $000A ; 0x05 Old man cave west
    dw $0003 ; 0x06 Old man cave east
    dw $001E ; 0x07 Eastern Palace
    dw $0030 ; 0x08 Desert Palace lobby
    dw $0030 ; 0x09 Desert Palace east
    dw $0030 ; 0x0A Desert Palace west
    dw $0030 ; 0x0B Desert Palace back
    dw $0018 ; 0x0C Sahasrahla's house west
    dw $0018 ; 0x0D Sahasrahla's house east
    dw $0028 ; 0x0E Angry bro west
    dw $0029 ; 0x0F Angry bro east
    dw $0022 ; 0x10 Magic bat
    dw $0002 ; 0x11 Lumberjack cave
    dw $0045 ; 0x12 Super bunny bottom
    dw $0045 ; 0x13 Super bunny top
    dw $0045 ; 0x14 Turtle Rock laser pots
    dw $004A ; 0x15 Bumper cave bottom
    dw $004A ; 0x16 Bumper cave top
    dw $0045 ; 0x17 Turtle Rock laser bridge
    dw $0045 ; 0x18 Turtle Rock big chest
    dw $0005 ; 0x19 East Death Mountain useless bottom
    dw $0005 ; 0x1A East Death Mountain useless top
    dw $0005 ; 0x1B Spiral cave exit
    dw $0005 ; 0x1C Spiral cave top
    dw $0005 ; 0x1D Paradox cave bottom
    dw $0005 ; 0x1E Paradox cave middle
    dw $0005 ; 0x1F Paradox cave top
    dw $0003 ; 0x20 Kiki cave west
    dw $0003 ; 0x21 Kiki cave east
    dw $0003 ; 0x22 Spectacle rock
    dw $001B ; 0x23 Agahnim's Tower
    dw $007B ; 0x24 Swamp Palace
    dw $005E ; 0x25 Palace of Darkness
    dw $0070 ; 0x26 Misery Mire
    dw $0040 ; 0x27 Skull Woods west
    dw $0040 ; 0x28 Skull Woods mummy statue
    dw $0040 ; 0x29 Skull Woods big chest
    dw $0040 ; 0x2A Skull Woods back
    dw $0000 ; 0x2B Lost Woods hideout
    dw $0075 ; 0x2C Ice Palace
    dw $000A ; 0x2D Death Mountain exit west
    dw $0003 ; 0x2E Death Mountain exit from summit
    dw $0003 ; 0x2F Old man home cave west
    dw $0003 ; 0x30 Old man home cave east
    dw $001B ; 0x31 Hyrule Castle secret entrance
    dw $0003 ; 0x32 Tower of Hera
    dw $0058 ; 0x33 Thieves' Town
    dw $0047 ; 0x34 Turtle Rock
    dw $005B ; 0x35 Pyramid drop
    dw $0043 ; 0x36 Ganon's Tower
    dw $0015 ; 0x37 Graveyard fairy
    dw $0018 ; 0x38 Kakariko well
    dw $0045 ; 0x39 Hookshot cave bottom
    dw $0045 ; 0x3A Hookshot cave top
    dw $0000 ; 0x3B Lost Woods chest game
    dw $0074 ; 0x3C Swamp thief cave hideout
    dw $0018 ; 0x3D Eastern snitch house
    dw $0018 ; 0x3E Cucco easter egg
    dw $0018 ; 0x3F Sick kid
    dw $0043 ; 0x40 Spike cave
    dw $0018 ; 0x41 Tavern front
    dw $0018 ; 0x42 Tavern back
    dw $0018 ; 0x43 Kakariko Inn
    dw $001E ; 0x44 Sahasrahla's hideout
    dw $0018 ; 0x45 Kakariko shop
    dw $0058 ; 0x46 Village of Outcasts chest game
    dw $0058 ; 0x47 Village of Outcasts bombable hut
    dw $0029 ; 0x48 Library
    dw $0018 ; 0x49 Kakariko bombable hut
    dw $0018 ; 0x4A Chicken hut
    dw $0016 ; 0x4B Potion shop
    dw $0030 ; 0x4C Aginah's cave
    dw $003B ; 0x4D Dam
    dw $0005 ; 0x4E Mimic cave
    dw $0005 ; 0x4F East Death Mountain fairy pond cave
    dw $0032 ; 0x50 Circle of bushes heart piece cave
    dw $0014 ; 0x51 Graveyard ledge heart piece cave
    dw $006C ; 0x52 Bomb shop
    dw $0058 ; 0x53 C-shaped house
    dw $002F ; 0x54 Southeast of Eastern Ruins fairy cave
    dw $0070 ; 0x55 Mire big fairy
    dw $0042 ; 0x56 Dark World lumberjacks shop
    dw $0035 ; 0x57 Lake Hylia shop
    dw $0069 ; 0x58 Arrow game
    dw $0053 ; 0x59 Dark World sanctuary cave
    dw $0014 ; 0x5A King's tomb
    dw $000F ; 0x5B Waterfall of Wishing
    dw $0035 ; 0x5C Pond of Happiness
    dw $002E ; 0x5D Big fairy (Eastern Ruins)
    dw $0070 ; 0x5E Mire shed
    dw $0058 ; 0x5F Village of Outcasts shop
    dw $0018 ; 0x60 Blind's hut
    dw $0070 ; 0x61 Watto's cave
    dw $005B ; 0x62 Fat Fairy
    dw $0022 ; 0x63 Smithy's house
    dw $0011 ; 0x64 Light World fortune teller (Kakariko)
    dw $0051 ; 0x65 Dark World fortune teller
    dw $0029 ; 0x66 South of Kakariko chest game
    dw $005E ; 0x67 Broccoli's house
    dw $006F ; 0x68 Bird hint NPC cave
    dw $0077 ; 0x69 Hamburger Helper's cave
    dw $0037 ; 0x6A Ice rod cave golden bee
    dw $0034 ; 0x6B Big fairy (South of Link's house)
    dw $006E ; 0x6C Big fairy (South of Kiki)
    dw $0045 ; 0x6D Dark Death Mountain shop
    dw $0056 ; 0x6E Dark World witch shop
    dw $0043 ; 0x6F Dark West Death Mountain big fairy
    dw $0030 ; 0x70 Aginah's cave
    dw $003A ; 0x71 Desert big fairy
    dw $0035 ; 0x72 Light World fortune teller (Lake Hylia)
    dw $0075 ; 0x73 Dark Lake Hylia shop
    dw $005A ; 0x74 East of Village of Outcasts shop
    dw $0002 ; 0x75 Bumpkin residency
    dw $002B ; 0x76 Link's house bonk rocks fairy pond
    dw $006B ; 0x77 Bomb shop bonk rocks fairy pond
    dw $003A ; 0x78 Desert thief hideout
    dw $0013 ; 0x79 Bonk rocks heart piece cave
    dw $0037 ; 0x7A Lake Hylia falls thief hideout
    dw $0077 ; 0x7B Dark Lake Hylia falls spike cave
    dw $0035 ; 0x7C Mini moldorm cave
    dw $0030 ; 0x7D Checkerboard cave heart piece
    dw $0062 ; 0x7E Stake puzzle heart piece cave
    dw $0037 ; 0x7F Ice rod cave
    dw $0077 ; 0x80 Dark ice rod big fairy
    
    ; $0DBA71 - Tile16 list for entrances
    .TileIndex
    dw $0796 ; 0x00 - Link's house
    dw $01AA ; 0x01 - Sanctuary
    dw $0124 ; 0x02 - Castle west wing
    dw $07BE ; 0x03 - Castle lobby
    dw $0158 ; 0x04 - Castle east wing
    dw $0634 ; 0x05 - Old man cave west
    dw $178E ; 0x06 - Old man cave east
    dw $016A ; 0x07 - Eastern Palace
    dw $05A4 ; 0x08 - Desert Palace lobby
    dw $0538 ; 0x09 - Desert Palace east
    dw $0510 ; 0x0A - Desert Palace west
    dw $01A4 ; 0x0B - Desert Palace back
    dw $054C ; 0x0C - Sahasrahla's house west
    dw $0554 ; 0x0D - Sahasrahla's house east
    dw $0B36 ; 0x0E - Angry bro west
    dw $0B06 ; 0x0F - Angry bro east
    dw $06A0 ; 0x10 - Magic bat
    dw $03A8 ; 0x11 - Lumberjack cave
    dw $126E ; 0x12 - Super bunny bottom
    dw $07F6 ; 0x13 - Super bunny top
    dw $0B56 ; 0x14 - Turtle Rock laser pots
    dw $0634 ; 0x15 - Bumper cave bottom
    dw $0336 ; 0x16 - Bumper cave top
    dw $0E62 ; 0x17 - Turtle Rock laser bridge
    dw $0B6E ; 0x18 - Turtle Rock big chest
    dw $1162 ; 0x19 - East Death Mountain useless bottom
    dw $0E62 ; 0x1A - East Death Mountain useless top
    dw $1058 ; 0x1B - Spiral cave exit
    dw $0B56 ; 0x1C - Spiral cave top
    dw $1274 ; 0x1D - Paradox cave bottom
    dw $1B78 ; 0x1E - Paradox cave middle
    dw $07F6 ; 0x1F - Paradox cave top
    dw $1128 ; 0x20 - Kiki cave west
    dw $1238 ; 0x21 - Kiki cave east
    dw $0CB8 ; 0x22 - Spectacle rock
    dw $02BE ; 0x23 - Agahnim's Tower
    dw $072E ; 0x24 - Swamp Palace
    dw $01EA ; 0x25 - Palace of Darkness
    dw $06A4 ; 0x26 - Misery Mire
    dw $101C ; 0x27 - Skull Woods west
    dw $1248 ; 0x28 - Skull Woods mummy statue
    dw $12DC ; 0x29 - Skull Woods big chest
    dw $0612 ; 0x2A - Skull Woods back
    dw $12DC ; 0x2B - Lost Woods hideout
    dw $0E56 ; 0x2C - Ice Palace
    dw $0336 ; 0x2D - Death Mountain exit west
    dw $1108 ; 0x2E - Death Mountain exit from summit
    dw $1DA4 ; 0x2F - Old man home cave west
    dw $1450 ; 0x30 - Old man home cave east
    dw $06D8 ; 0x31 - Hyrule Castle secret entrance
    dw $03DE ; 0x32 - Tower of Hera
    dw $0DBE ; 0x33 - Thieves' Town
    dw $09A0 ; 0x34 - Turtle Rock
    dw $0D9C ; 0x35 - Pyramid drop
    dw $01DE ; 0x36 - Ganon's Tower
    dw $0294 ; 0x37 - Graveyard fairy
    dw $0616 ; 0x38 - Kakariko well
    dw $0868 ; 0x39 - Hookshot cave bottom
    dw $01D8 ; 0x3A - Hookshot cave top
    dw $00DE ; 0x3B - Lost Woods chest game
    dw $0330 ; 0x3C - Swamp thief cave hideout
    dw $0D68 ; 0x3D - Eastern snitch house
    dw $0B18 ; 0x3E - Cucco easter egg
    dw $144E ; 0x3F - Sick kid
    dw $1264 ; 0x40 - Spike cave
    dw $1BD0 ; 0x41 - Tavern front
    dw $18D0 ; 0x42 - Tavern back
    dw $13E6 ; 0x43 - Kakariko Inn
    dw $099E ; 0x44 - Sahasrahla's hideout
    dw $1A36 ; 0x45 - Kakariko shop
    dw $0B18 ; 0x46 - Village of Outcasts chest game
    dw $1A36 ; 0x47 - Village of Outcasts bombable hut
    dw $038E ; 0x48 - Library
    dw $1B8C ; 0x49 - Kakariko bombable hut
    dw $14B0 ; 0x4A - Chicken hut
    dw $0A18 ; 0x4B - Potion shop
    dw $0964 ; 0x4C - Aginah's cave
    dw $072E ; 0x4D - Dam
    dw $0B6E ; 0x4E - Mimic cave
    dw $126E ; 0x4F - East Death Mountain fairy pond cave
    dw $0906 ; 0x50 - Circle of bushes heart piece cave
    dw $02A2 ; 0x51 - Graveyard ledge heart piece cave
    dw $0796 ; 0x52 - Bomb shop
    dw $0D68 ; 0x53 - C-shaped house
    dw $0934 ; 0x54 - Southeast of Eastern Ruins fairy cave
    dw $0636 ; 0x55 - Mire big fairy
    dw $06AA ; 0x56 - Dark World lumberjacks shop
    dw $01B2 ; 0x57 - Lake Hylia shop
    dw $092C ; 0x58 - Arrow game
    dw $02AA ; 0x59 - Dark World sanctuary cave
    dw $05B2 ; 0x5A - King's tomb
    dw $008C ; 0x5B - Waterfall of Wishing
    dw $0CD4 ; 0x5C - Pond of Happiness
    dw $0224 ; 0x5D - Big fairy (Eastern Ruins)
    dw $0612 ; 0x5E - Mire shed
    dw $13E6 ; 0x5F - Village of Outcasts shop
    dw $0540 ; 0x60 - Blind's hut
    dw $0964 ; 0x61 - Watto's cave
    dw $0DAE ; 0x62 - Fat Fairy
    dw $039A ; 0x63 - Smithy's house
    dw $089E ; 0x64 - Light World fortune teller (Kakariko)
    dw $089E ; 0x65 - Dark World fortune teller
    dw $092C ; 0x66 - South of Kakariko chest game
    dw $0FB2 ; 0x67 - Broccoli's house
    dw $0934 ; 0x68 - Bird hint NPC cave
    dw $0212 ; 0x69 - Hamburger Helper's cave
    dw $0212 ; 0x6A - Ice rod cave golden bee
    dw $0330 ; 0x6B - Big fairy (South of Link's house)
    dw $0224 ; 0x6C - Big fairy (South of Kiki)
    dw $1274 ; 0x6D - Dark Death Mountain shop
    dw $0A9A ; 0x6E - Dark World witch shop
    dw $178E ; 0x6F - Dark West Death Mountain big fairy
    dw $0964 ; 0x70 - Aginah's cave
    dw $018C ; 0x71 - Desert big fairy
    dw $060A ; 0x72 - Light World fortune teller (Lake Hylia)
    dw $060A ; 0x73 - Dark Lake Hylia shop
    dw $0A28 ; 0x74 - East of Village of Outcasts shop
    dw $072A ; 0x75 - Bumpkin residency
    dw $0330 ; 0x76 - Link's house bonk rocks fairy pond
    dw $0330 ; 0x77 - Bomb shop bonk rocks fairy pond
    dw $0A1E ; 0x78 - Desert thief hideout
    dw $0506 ; 0x79 - Bonk rocks heart piece cave
    dw $040C ; 0x7A - Lake Hylia falls thief hideout
    dw $040C ; 0x7B - Dark Lake Hylia falls spike cave
    dw $178C ; 0x7C - Mini moldorm cave
    dw $0358 ; 0x7D - Checkerboard cave heart piece
    dw $0D20 ; 0x7E - Stake puzzle heart piece cave
    dw $0208 ; 0x7F - Ice rod cave
    dw $0208 ; 0x80 - Dark ice rod big fairy

    ; TODO: Provide a separate file to provide all the default names.
    ; $0DBB73
    .ID
    db $01 ; 0x00 - Link's house
    db $02 ; 0x01 - Sanctuary
    db $03 ; 0x02 - Castle west wing
    db $04 ; 0x03 - Castle lobby
    db $05 ; 0x04 - Castle east wing
    db $06 ; 0x05 - Old man cave west
    db $07 ; 0x06 - Old man cave east
    db $08 ; 0x07 - Eastern Palace
    db $09 ; 0x08 - Desert Palace lobby
    db $0A ; 0x09 - Desert Palace east
    db $0B ; 0x0A - Desert Palace west
    db $0C ; 0x0B - Desert Palace back
    db $0D ; 0x0C - Sahasrahla's house west
    db $0E ; 0x0D - Sahasrahla's house east
    db $0F ; 0x0E - Angry bro west
    db $10 ; 0x0F - Angry bro east
    db $11 ; 0x10 - Magic bat
    db $12 ; 0x11 - Lumberjack cave
    db $13 ; 0x12 - Super bunny bottom
    db $14 ; 0x13 - Super bunny top
    db $15 ; 0x14 - Turtle Rock laser pots
    db $16 ; 0x15 - Bumper cave bottom
    db $17 ; 0x16 - Bumper cave top
    db $18 ; 0x17 - Turtle Rock laser bridge
    db $19 ; 0x18 - Turtle Rock big chest
    db $1A ; 0x19 - East Death Mountain useless bottom
    db $1B ; 0x1A - East Death Mountain useless top
    db $1C ; 0x1B - Spiral cave exit
    db $1D ; 0x1C - Spiral cave top
    db $1E ; 0x1D - Paradox cave bottom
    db $1F ; 0x1E - Paradox cave middle
    db $20 ; 0x1F - Paradox cave top
    db $21 ; 0x20 - Kiki cave west
    db $22 ; 0x21 - Kiki cave east
    db $23 ; 0x22 - Spectacle rock
    db $24 ; 0x23 - Agahnim's Tower
    db $25 ; 0x24 - Swamp Palace
    db $26 ; 0x25 - Palace of Darkness
    db $27 ; 0x26 - Misery Mire
    db $28 ; 0x27 - Skull Woods west
    db $29 ; 0x28 - Skull Woods mummy statue
    db $2A ; 0x29 - Skull Woods big chest
    db $2B ; 0x2A - Skull Woods back
    db $2C ; 0x2B - Lost Woods hideout
    db $2D ; 0x2C - Ice Palace
    db $2E ; 0x2D - Death Mountain exit west
    db $2F ; 0x2E - Death Mountain exit from summit
    db $30 ; 0x2F - Old man home cave west
    db $31 ; 0x30 - Old man home cave east
    db $32 ; 0x31 - Hyrule Castle secret entrance
    db $33 ; 0x32 - Tower of Hera
    db $34 ; 0x33 - Thieves' Town
    db $35 ; 0x34 - Turtle Rock
    db $36 ; 0x35 - Pyramid drop
    db $37 ; 0x36 - Ganon's Tower
    db $38 ; 0x37 - Graveyard fairy
    db $39 ; 0x38 - Kakariko well
    db $3A ; 0x39 - Hookshot cave bottom
    db $3B ; 0x3A - Hookshot cave top
    db $3C ; 0x3B - Lost Woods chest game
    db $3D ; 0x3C - Swamp thief cave hideout
    db $3E ; 0x3D - Eastern snitch house
    db $3F ; 0x3E - Cucco easter egg
    db $40 ; 0x3F - Sick kid
    db $41 ; 0x40 - Spike cave
    db $42 ; 0x41 - Tavern front
    db $43 ; 0x42 - Tavern back
    db $44 ; 0x43 - Kakariko Inn
    db $45 ; 0x44 - Sahasrahla's hideout
    db $46 ; 0x45 - Kakariko shop
    db $47 ; 0x46 - Village of Outcasts chest game
    db $48 ; 0x47 - Village of Outcasts bombable hut
    db $49 ; 0x48 - Library
    db $4A ; 0x49 - Kakariko bombable hut
    db $4B ; 0x4A - Chicken hut
    db $4C ; 0x4B - Potion shop
    db $4D ; 0x4C - Aginah's cave
    db $4E ; 0x4D - Dam
    db $4F ; 0x4E - Mimic cave
    db $50 ; 0x4F - East Death Mountain fairy pond cave
    db $51 ; 0x50 - Circle of bushes heart piece cave
    db $52 ; 0x51 - Graveyard ledge heart piece cave
    db $53 ; 0x52 - Bomb shop
    db $54 ; 0x53 - C-shaped house
    db $55 ; 0x54 - Southeast of Eastern Ruins fairy cave
    db $5E ; 0x55 - Mire big fairy
    db $60 ; 0x56 - Dark World lumberjacks shop
    db $58 ; 0x57 - Lake Hylia shop
    db $59 ; 0x58 - Arrow game
    db $5A ; 0x59 - Dark World sanctuary cave
    db $5B ; 0x5A - King's tomb
    db $5C ; 0x5B - Waterfall of Wishing
    db $5D ; 0x5C - Pond of Happiness
    db $5E ; 0x5D - Big fairy (Eastern Ruins)
    db $5F ; 0x5E - Mire shed
    db $60 ; 0x5F - Village of Outcasts shop
    db $61 ; 0x60 - Blind's hut
    db $62 ; 0x61 - Watto's cave
    db $63 ; 0x62 - Fat Fairy
    db $64 ; 0x63 - Smithy's house
    db $65 ; 0x64 - Light World fortune teller (Kakariko)
    db $66 ; 0x65 - Dark World fortune teller
    db $67 ; 0x66 - South of Kakariko chest game
    db $68 ; 0x67 - Broccoli's house
    db $69 ; 0x68 - Bird hint NPC cave
    db $6A ; 0x69 - Hamburger Helper's cave
    db $56 ; 0x6A - Ice rod cave golden bee
    db $5E ; 0x6B - Big fairy (South of Link's house)
    db $5E ; 0x6C - Big fairy (South of Kiki)
    db $58 ; 0x6D - Dark Death Mountain shop
    db $60 ; 0x6E - Dark World witch shop
    db $5E ; 0x6F - Dark West Death Mountain big fairy
    db $4D ; 0x70 - Aginah's cave
    db $5E ; 0x71 - Desert big fairy
    db $65 ; 0x72 - Light World fortune teller (Lake Hylia)
    db $60 ; 0x73 - Dark Lake Hylia shop
    db $57 ; 0x74 - East of Village of Outcasts shop
    db $6B ; 0x75 - Bumpkin residency
    db $71 ; 0x76 - Link's house bonk rocks fairy pond
    db $71 ; 0x77 - Bomb shop bonk rocks fairy pond
    db $6D ; 0x78 - Desert thief hideout
    db $6E ; 0x79 - Bonk rocks heart piece cave
    db $6F ; 0x7A - Lake Hylia falls thief hideout
    db $70 ; 0x7B - Dark Lake Hylia falls spike cave
    db $6C ; 0x7C - Mini moldorm cave
    db $72 ; 0x7D - Checkerboard cave heart piece
    db $83 ; 0x7E - Stake puzzle heart piece cave
    db $84 ; 0x7F - Ice rod cave
    db $5E ; 0x80 - Dark ice rod big fairy
}

; $0DBBF4-$0DBD79 LONG JUMP LOCATION
Overworld_Entrance:
{
    REP #$31
    
    LDA.b $20 : CLC : ADC.w #$0007 : STA.b $00
    SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
    
    LDA.b $22 : LSR #3 : STA.b $02
    SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $06 : TAY : TAX
    
    LDA.l $7E2000, X : ASL #3 : TAX
    
    ; If player is facing a different direction than up, branch
    LDA.b $2F : AND.w #$00FF : BNE .notFacingUp
        LDA.l Tile16Definitions_1, X : AND.w #$41FF : CMP.w #$00E9 : BEQ .BRANCH_BETA
            CMP.w #$0149 : BEQ .BRANCH_GAMMA
            CMP.w #$0169 : BEQ .BRANCH_GAMMA
                TYX
                LDA.l $7E2002, X : ASL #3 : TAX
                LDA.l Tile16Definitions_0, X : AND.w #$41FF : CMP.w #$4149 : BEQ .BRANCH_DELTA
                    CMP.w #$4169 : BEQ .BRANCH_DELTA
                        CMP.w #$40E9 : BNE .BRANCH_EPSILON
                            DEY : DEY
            
        .BRANCH_BETA
        
        ; This section opens a normal door on the overworld
        ; It replaces the existing tiles with an open door set of tiles
        
        TYX
        
        LDA.w #$0DA4
        JSL.l Overworld_DrawPersistentTile16
        
        LDA.w #$0DA6 : STA.l $7E2002, X
        
        LDY.w #$0002
        JSL.l Overworld_DrawTile16_Anywhere
        
        SEP #$30
        
        ; Play a sound effect
        LDA.b #$15 : STA.w $012F
        
        ; Make sure to update the tilemap
        LDA.b #$01 : STA.b $14
        
        RTL
    
    .notFacingUp
    
    BRA .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    DEY : DEY
    
    .BRANCH_GAMMA
    
    STZ.w $0692
    
    AND.w #$03FF : CMP.w #$0169 : BNE .BRANCH_IOTA
        ; Check if we've beaten agahnim, and if so, don't open the door.
        LDA.l $7EF3C5 : AND.w #$000F : CMP.w #$0003 : BCS .BRANCH_EPSILON
            LDA.w #$0018 : STA.w $0692
    
    .BRANCH_IOTA
    
    TYA : SEC : SBC.w #$0080 : STA.w $0698
    
    SEP #$20
    
    LDA.b #$15 : STA.w $012F
    
    STZ.b $B0 : STZ.w $0690
    
    LDA.b #$0C : STA.b $11
    
    SEP #$30
    
    RTL
    
    .BRANCH_EPSILON
    
    LDA.l Tile16Definitions_2, X : AND.w #$01FF : STA.b $00
    LDA.l Tile16Definitions_3, X : AND.w #$01FF : STA.b $02
    
    LDX.w #$0056
    
    .loop
    
        LDA.b $00 : CMP.l Pool_Overworld_Entrance_ValidDoorTypes_Right, X : BNE .BRANCH_ZETA
            LDA.b $02 : CMP.l Pool_Overworld_Entrance_ValidDoorTypes_Left, X : BEQ .BRANCH_KAPPA
        
        .BRANCH_ZETA
    DEX : DEX : BPL .loop
    
    STZ.w $04B8
    
    .BRANCH_MU
    
        SEP #$30
        
        RTL
        
        .BRANCH_LAMBDA
    LDA.w $04B8 : BNE .BRANCH_MU
    
    INC.w $04B8
    
    ; "You can't enter with something following you" (this variable holds
    ; the message index.)
    LDA.w #$0005 : STA.w $1CF0
    
    SEP #$30
    
    JML.l Main_ShowTextMessage
    
    .BRANCH_KAPPA
    
    TYA : STA.b $00
    
    ; Number of entrance entries * 2
    LDX.w #$0102
    
    .BRANCH_PI
    
        LDA.b $00
        
        .BRANCH_OMICRON
        
            DEX : DEX : BMI .BRANCH_XI
        CMP.l Pool_Overworld_Entrance_TileIndex, X : BNE .BRANCH_OMICRON
    LDA.w $040A : CMP.l Pool_Overworld_Entrance_Screens, X : BNE .BRANCH_PI
    
    LDA.l $7EF3D3 : AND.w #$00FF : BNE .BRANCH_RHO
        LDA.w $02DA : AND.w #$00FF : CMP.w #$0001 : BEQ .BRANCH_LAMBDA
            LDA.l $7EF3CC : AND.w #$00FF : BEQ .BRANCH_RHO
            CMP.w #$0005 : BEQ .BRANCH_RHO
            CMP.w #$000E : BEQ .BRANCH_RHO
            CMP.w #$0001 : BEQ .BRANCH_RHO
                CMP.w #$0007 : BEQ .BRANCH_SIGMA
                    CMP.w #$0008 : BNE .BRANCH_LAMBDA  
                        CPX.w #$0076 : BCC .BRANCH_LAMBDA
    
    .BRANCH_RHO

    TXA : LSR : TAX
    
    SEP #$30
    
    LDA.l Pool_Overworld_Entrance_ID, X : STA.w $010E
    
    STZ.b $4D : STZ.b $46
    
    LDA.b #$0F : STA.b $10
    
    LDA.b #$06 : STA.w $010C
    
    STZ.b $11
    STZ.b $B0
    
    .BRANCH_XI   

    SEP #$30
    
    RTL
}

; ==============================================================================

; Handles Tile16 interactions with sword, hammer, shovel, magic powder, etc.
; $0DBD7A-$0DBF1D LONG JUMP LOCATION
Overworld_Tile16_ToolInteraction:
{
    LDA.b $1B : BEQ .outdoors ; Yes... branch
        JML.l Dungeon_ToolAndTileInteraction
    
    .outdoors
    
    REP #$30
    
    ; Zero out ??? affected when dashing apparently, Zero out tile interaction.
    STZ.w $04B2 : STZ.b $76
    
    LDA.b $00 : SEC : SBC.w $0708 : AND.w $070A : ASL #3          : STA.b $06
    LDA.b $02 : SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $06 : TAX
    
    ; Is Link using the hammer?
    LDA.w $0301 : AND.w #$0002 : BNE .usingHammer
        ; Is Link using anything else?
        ; No, branch
        LDA.w $0301 : AND.w #$0040 : BEQ .notUsingMagicPowder
            ; We end up here if Link sprinkled magic powder on something.
            LDA.l $7E2000, X : PHA
            
            LDY.w #$0002
            
            ; Is it a bush?
            CMP.w #$0036 : BEQ .isBush
                LDY.w #$0004
                
                ; Is it a dark world bush?
                CMP.w #$072A : BNE .notBush
                
            .isBush
            
            JMP.w .isBush2
    
    ; HAMMER TIME!
    .usingHammer
    
    ; Is it a peg to be pounded down?
    LDA.l $7E2000, X : PHA : CMP.w #$021B : BNE .notPeg
        SEP #$20
        
        ; Play the peg gettin' knocked down sound.
        LDA.b #$11 : STA.w $012E
        
        REP #$20
        
        JSL.l HandlePegPuzzles
        
        ; Choose the Tile16 tile with the "peg pounded down" tile
        LDA.w #$0DCB
        
        JMP.w .noSecret
    
    .notPeg
    
    JSR.w Overworld_HammerSFX
    
    .notBush
    
    JMP.w .return
    
    .notUsingMagicPowder
    
    ; Normal tile interactions
    LDA.l $7E2000, X : PHA
    CMP.w #$0034 : BEQ .shovelable ; Normal blank green ground
    CMP.w #$0071 : BEQ .shovelable ; Non thick grass
    CMP.w #$0035 : BEQ .shovelable ; Non thick grass
    CMP.w #$010D : BEQ .shovelable ; Non thick grass
    CMP.w #$010F : BEQ .shovelable ; Non thick grass
    CMP.w #$00E1 : BEQ .shovelable ; Animated flower tile
    CMP.w #$00E2 : BEQ .shovelable ; Animated flower tile
    CMP.w #$00DA : BEQ .shovelable ; Non thick grass
    CMP.w #$00F8 : BEQ .shovelable ; Non thick grass
    CMP.w #$010E : BEQ .shovelable ; Non thick grass
        CMP.w #$037E : BEQ .isThickGrass ; Thick grass
            LDY.w #$0002
            
            ; Normal bush
            CMP.w #$0036 : BEQ .isBush2
                LDY.w #$0004
                    ; Off color bush
                    CMP.w #$072A : BEQ .isBush2
                        .notShoveling
                        
                        JMP.w .return
    
    .shovelable
    
    ; Is Link shoveling?
    LDA.w $037A : AND.w #$00FF : CMP.w #$0001 : BNE .notShoveling
    
    ; Is this the forest grove?
    LDA.b $8A : CMP.w #$002A : BNE .notFluteLocation
        ; Is it that one special spot the flute is at?
        CPX.w #$0492 : BNE .notFluteLocation
            STX.w $04B2
    
    .notFluteLocation
    
    ; Replacement tile after you shovel out the ground
    LDY.w #$0DC9
    
    BRA .checkForSecret
    
    .isThickGrass
    
    LDA.w $037A : AND.w #$00FF : CMP.w #$0001 : BNE .notShoveling2
        JMP.w .return
    
    .notShoveling2
    
    LDA.b $02 : ASL #3 : SEC : SBC.w #$0008       : PHA
    LDA.b $00 : SEC : SBC.w #$0008 : AND.w #$FFF8 : STA.b $74
    
    ; TODO: RESEARCH: Why was it pushed in the first place? -____-
    PLA : STA.b $72
    
    LDA.w #$0003 : STA.b $76
    
    LDY.w #$0DC5
    
    BRA .checkForSecret
    
    ; $0DBE8D ALTERNATE ENTRY POINT
    .isBush2
    
    LDA.w $037A : AND.w #$00FF : CMP.w #$0001 : BEQ .shoveling
        LDA.b $02 : AND.w #$FFFE : ASL #3 : PHA
        
        LDA.b $00 : AND.w #$FFF0 : STA.b $74
        
        ; TODO: RESEARCH: Again... why?
        PLA : STA.b $72
        
        STY.b $76
        
        PLA : PHA
        
        LDY.w #$0DC7
        
        CMP.w #$072A : BNE .notOffColorBush
            ; Use a different replacement Tile16 tile for the off color bushes
            LDY.w #$0DC8
        
        .notOffColorBush
        .checkForSecret
        
        STY.b $0E
        
        ; Check for secrets under the bush?
        JSR.w Overworld_RevealSecret : BCS .noSecret
            ; If there's a secret under the bush, like a hole or a cave
            ; it would require a different replacement Tile16 tile
            LDA.b $0E
        
        .noSecret
        
        STA.l $7E2000, X
        
        JSL.l Overworld_Memorize_Tile16_Change
        JSL.l Overworld_DrawTile16
        
        SEP #$20
        
        ; Tell NMI to update the tilemap
        LDA.b #$01 : STA.b $14
        
        REP #$20
        
        PLA
        
        BRA .setTileFlags
    
    .shoveling
    
    PLA
    
    LDA.l $7E2000, X
    
    .setTileFlags
    
    ASL : ASL : STA.b $06
    
    LDA.b $00 : AND.w #$0008 : LSR : LSR : TSB.b $06
    
    LDA.b $02 : AND.w #$0001 : ORA.b $06 : ASL : TAX
    LDA.l Tile16Definitions, X : AND.w #$01FF : TAX
    LDA Overworld_TileAttr, X : PHA
    
    LDA.b $72 : STA.b $00
    LDA.b $74 : STA.b $02
    
    SEP #$30
    
    LDA.b $76 : BEQ .noAncilla
        JSL.l Sprite_SpawnImmediatelySmashedTerrain
        JSL.l AddDisintegratingBushPoof
    
    .noAncilla
    
    REP #$30
    
    PLA
    
    .return
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DBF1E-$0DBF4B LOCAL JUMP LOCATION
Overworld_HammerSFX:
{
    ASL #3 : TAX
    LDA.l Tile16Definitions, X : AND.w #$01FF : TAX
    LDA.l Overworld_TileAttr, X
    
    SEP #$30
    
    CMP.b #$50 : BCC .noSoundEffect
        ; We're hitting a bush, so play the swish sound.
        LDY.b #$1A
        CMP.b #$52 : BCC .playSoundEffect
            ; We're hitting a sign post, so play the "hitting a peg" sound.
            LDY.b #$11
            CMP.b #$54 : BEQ .playSoundEffect
                ; We're hitting a small rock, so play the "tink" from hitting a
                ; rock.
                LDY.b #$05
                CMP.b #$58 : BCC .noSoundEffect
        
        .playSoundEffect
        
        STY.w $012E
    
    .noSoundEffect
    
    REP #$30
    
    RTS
}
    
; ==============================================================================

; $0DBF4C-$0DBF63 DATA
RockSmashReplaceOffset:
{
    ; $0DBF4C
    .tile1
    dw    0 ; From top left
    dw   -2 ; From top right
    dw -128 ; From bottom left
    dw -130 ; From bottom right
    
    ; $0DBF54
    .tile2
    dw    0 ; From top left
    dw    0 ; From top right
    dw -128 ; From bottom left
    dw -128 ; From bottom right
    
    ; $0DBF5C
    .tile3
    dw    0 ; From top left
    dw   -2 ; From top right
    dw    0 ; From bottom left
    dw   -2 ; From bottom right
}

; ==============================================================================

; $0DBF64-$0DBF9C LOCAL JUMP LOCATION
Overworld_GetLinkTile16Coords:
{
    LDA.b $2F : AND.w #$00FF : TAX

    LDA.b $20
    CLC : ADC.l Liftable_CheckOffset_Y, X : AND.w #$FFF0 : STA.b $00
    SEC : SBC.w $0708                     : AND.w $070A  : ASL #3
    STA.b $06

    LDA.b $22
    CLC : ADC.l Liftable_CheckOffset_X, X : AND.w #$FFF0 : STA.b $02
    LSR #3 : SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $06
    TAX
    
    RTS
}

; ==============================================================================

; $0DBF9D-$0DC054 LONG JUMP LOCATION
Overworld_LiftableTiles:
{
    ; Handles Tile16 tiles that are liftable.
    
    REP #$30
    
    JSR.w Overworld_GetLinkTile16Coords
    
    LDA.b $00 : PHA
    LDA.b $02 : PHA
    
    LDA.l $7E2000, X
    
    LDY.w #$0000
    ; Is it a big light colored rock?
    CMP.w #$036D : BEQ .liftingLargeRock
        INY
        ; Also a big light colored rock...
        CMP.w #$036E : BEQ .liftingLargeRock
            INY
            ; Ditto
            CMP.w #$0374 : BEQ .liftingLargeRock
                INY
                ; Ditto
                CMP.w #$0375 : BEQ .liftingLargeRock
                    LDY.w #$0000
                    ; Dark colored big rock?
                    CMP.w #$023B : BEQ .liftingLargeRock
                        INY
                        ; Same
                        CMP.w #$023C : BEQ .liftingLargeRock
                            INY
                            ; Same
                            CMP.w #$023D : BEQ .liftingLargeRock
                                ; Same
                                CMP.w #$023E : BNE .notLiftingRock
                                    INY
    
    .liftingLargeRock
    
    JMP.w Overworld_SmashRockPile_isRockPile
    
    .notLiftingRock
    
    LDY.w #$0DC7
    ; Is it a green bush?
    CMP.w #$0036 : BEQ .liftingSmallObject
        LDY.w #$0DC8
        ; Is it a brown bush?
        CMP.w #$072A : BEQ .liftingSmallObject
            LDY.w #$0DCA
            ; Is it a small light colored rock?
            CMP.w #$020F: BEQ .liftingSmallObject
                ; How about a small dark colored rock?
                CMP.w #$0239 : BEQ .liftingSmallObject
                    ; Is it one of those sign posts?
                    CMP.w #$0101 : BNE .notLiftingSmallObject
                        LDY.w #$0DC6
    
    .liftingSmallObject
    
    STY.b $0E
    
    PHA
    
    JSR.w Overworld_RevealSecret : BCS .noSecret
        LDA.b $0E
    
    .noSecret
    
    STA.l $7E2000, X
    
    JSL.l Overworld_Memorize_Tile16_Change
    JSL.l Overworld_DrawTile16
    
    SEP #$20
    
    LDA.b #$01 : STA.b $14
    
    ; $0DC024 ALTERNATE ENTRY POINT
    .getTileAttribute
    
    REP #$30
    
    PLA
    
    .notLiftingSmallObject
    
    ASL : ASL : STA.b $06
    
    LDA.b $02 : AND.w #$0008 : LSR : LSR : TSB.b $06
    
    LDA.b $00 : LSR #3 : AND.w #$0001 : ORA.b $06 : ASL : TAX
    LDA.l Tile16Definitions, X : AND.w #$01FF : TAX
    
    PLA : STA.b $00
    PLA : STA.b $02
    
    LDA.l Overworld_TileAttr, X
    
    SEP #$31
    
    RTL
}

; ==============================================================================

; $0DC055-$0DC062 BRANCH LOCATION
Overworld_SmashRockPile:
{
    .checkForBush
    
    LDY.w #$0DC7
    ; Check if the Tile16 tile is a bush
    CMP.w #$0036 : BEQ Overworld_LiftableTile_liftingSmallObject
        PLA : PLA

        SEP #$30

        CLC

        RTL
}

; $0DC063-$0DC075 LONG JUMP LOCATION
Overworld_SmashRockPileFromAbove:
{
    REP #$30
    
    LDA.b $20 : PHA
    CLC : ADC.w #$0008 : STA.b $20
    
    JSR.w Overworld_GetLinkTile16Coords
    
    PLA : STA.b $20
    
    BRA Overworld_SmashRockPileFromHere_continue
}

; $0DC076-$0DC0F7 LONG JUMP LOCATION
Overworld_SmashRockPileFromHere:
{
    REP #$30
    
    JSR.w Overworld_GetLinkTile16Coords
    
    .continue
    
    LDA.b $00 : PHA
    LDA.b $02 : PHA
    
    LDA.l $7E2000, X
    LDY.w #$0000
    
    ; Check if it's a rock pile
    CMP.w #$0226 : BEQ .isRockPile
        INY
        
        ; Same
        CMP.w #$0227 : BEQ .isRockPile
            INY
            
            ; Same
            CMP.w #$0228 : BEQ .isRockPile
                ; Same
                CMP.w #$0229    
                    BNE Overworld_SmashRockPile_checkForBush
                        INY

    .isRockPile

    STY.b $0C
    
    ; Why store to $0C then TSB it again...?
    PHA : TSB.b $0C
    
    TXA : CLC
    LDX.b $0C
    ADC.l RockSmashReplaceOffset_tile1, X : STA.w $0698
                                            TAX
    
    LDA.w #$0028 : STA.w $0692
    
    STZ.b $0E
    
    JSR.w Overworld_RevealSecret
    
    LDA.b $0E : CMP.w #$FFFF : BNE .noBurrowUnderneath
        SEP #$20
        
        ; Remember that the burrow has been uncovered.
        LDX.b $8A
        LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
        
        ; Play puzzle solved sound
        LDA.b #$1B : STA.w $012F
        
        REP #$20
        
        LDA.b #$0050 : STA.w $0692
    
    .noBurrowUnderneath
    
    LDX.b $0C
    LDA.b $00 : CLC : ADC.l RockSmashReplaceOffset_tile2, X : STA.b $00
    LDA.b $02 : CLC : ADC.l RockSmashReplaceOffset_tile3, X : STA.b $02
    
    JSL.l Overworld_DoMapUpdate32x32_Long
    JMP.w Overworld_LiftableTile_getTileAttribute
}

; ==============================================================================

; $0DC0F8-$0DC154 LONG JUMP LOCATION
Overworld_ApplyBombToTiles:
{
	REP #$30
    
	STZ.b $0E
	STZ.b $08
    
	LDA.w #$0003 : STA.b $C8
    
	LDA.b $00 : SEC : SBC.w #$0014 : AND.w #$FFF8 : STA.w $0488
	LDA.b $02 : SEC : SBC.w #$0017 : AND.w #$FFF8 : STA.w $0486
    
    .downOneRow
    
        LDA.w $0488 : SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $CA
        
        LDA.w $0486
        JSR.w Overworld_ApplyBombToTile
        
        LDA.w $0486 : CLC : ADC.w #$0010
        JSR.w Overworld_ApplyBombToTile

        LDA.w $0486 : CLC : ADC.w #$0020
        JSR.w Overworld_ApplyBombToTile
        
        LDA.w $0488 : CLC : ADC.w #$0010 : STA.w $0488
	DEC.b $C8 : BNE .downOneRow
    
	SEP #$30
    
	RTL
}

; ==============================================================================

; $0DC155-$0DC21C LOCAL JUMP LOCATION
Overworld_ApplyBombToTile:
{
    PHA
    
    LSR #3 : SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $CA : TAX
                                                                 STX.b $04
    
    ; Check to see if Link has a super bomb.
    LDA.l $7EF3CC : AND.w #$00FF : CMP.w #$000D : BEQ .checkForBomableCave
        LDA.l $7E2000, X
        
        LDY.w #$0DC7
        LDX.w #$0002
        
        ; Normal bush
        CMP.w #$0036 : BEQ .grassOrBush
            LDX.w #$0004
            LDY.w #$0DC8
            
            ; Off color bush
            CMP.w #$072A : BEQ .grassOrBush
                ; Thick grass
                CMP.w #$037E : BNE .checkForBombableCave
                    LDY.w #$0DC5
                    LDX.w #$0003
        
        .grassOrBush
        
        STX.b $0A
        STY.b $0E
        
        LDX.b $04
        JSR.w Overworld_RevealSecret : BCS .noSecret
            LDA.b $0E
        
        .noSecret
        
        STA.l $7E2000, X
        
        JSL.l Overworld_Memorize_Tile16_Change
        
        LDY.w #$0000
        JSL.l Overworld_DrawTile16_Anywhere
        
        PLA         : AND.w #$FFF8 : STA.b $00
        LDA.w $0488 : AND.w #$FFF8 : STA.b $02
        
        LDA.b $08 : PHA
        
        SEP #$30
        
        LDA.b $0A
        JSL.l Sprite_SpawnImmediatelySmashedTerrain
        
        LDA.b #$01 : STA.b $14
        
        REP #$30
        
        PLA : STA.b $08
        
        RTS
    
    .checkForBomableCave
    
    LDX.b $04
    JSR.w Overworld_RevealSecret
    
    LDA.b $0E : CMP.w #$0DB4 : BEQ .bombableCave
        PLA
        
        RTS
    
    .bombableCave
    
    STA.l $7E2000, X
    
    JSL.l Overworld_Memorize_Tile16_Change
    
    LDY.w #$0000
    JSL.l Overworld_DrawTile16_Anywhere
    
    LDA.w #$0DB5 : STA.l $7E2002, X
    
    JSL.l Overworld_Memorize_Tile16_Change
    
    LDY.w #$0002
    JSL.l Overworld_DrawTile16_Anywhere
    
    STZ.b $0E
    
    SEP #$20
    
    LDA.b #$01 : STA.b $14
    
    ; A cave has been bombed open. Remember it.
    LDX.b $8A
    LDA.l $7EF280, X : ORA.b #$02 : STA.l $7EF280, X
    
    REP #$30
    
    PLA
    
    RTS
}

; ==============================================================================

; Called when the weather vane is about exploded.
; Draws fresh tiles over the weathercock and displays the N (north) 
; symbol by blitting them to VRAM, and setting $14 to 1, so it will
; register. But note that in order for this to work you have to use the
; array starting at $1000 in WRAM, which this routine does.
; $0DC21D-$0DC263 LONG JUMP LOCATION
Overworld_AlterWeathervane:
{
    REP #$30
    
    ; The replacement Tile16 tile to use?
    LDA.w #$0068 : STA.w $0692
    
    ; The index in the tile map to start from.
    LDA.w #$0C3E : STA.w $0698
    JSL.l Overworld_DoMapUpdate32x32_Long
    
    REP #$30
    
    LDX.w #$0C42
    LDA.w #$0E21 : STA.l $7E2000, X
    
    LDY.w #$0000
    JSL.l Overworld_DrawTile16_Anywhere
    
    LDX.w #$0CC0
    LDA.w #$0E25 : STA.l $7E2002, X
    
    LDY.w #$0002
    JSL.l Overworld_DrawTile16_Anywhere
    
    SEP #$30
    
    ; Indicate that the weather vane has already been smashed open.
    LDA.l $7EF298 : ORA.b #$20 : STA.l $7EF298
    
    ; Update the screen.
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DC264-$0DC2A6 LONG JUMP LOCATION
Overworld_AlterGargoyleEntrance:
{
    ; Seems to me that this routine does the tile modification for the
    ; entrance to Gargoyle's Domain
    
    REP #$30
    
    LDX.w #$0D3E
    LDA.w #$0E1B
    JSL.l Overworld_DrawPersistentTile16
    
    LDX.w #$0D40
    LDA.w #$0E1C
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$0DBE
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$0E3E
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    SEP #$30
    
    LDA.l $7EF2D8 : ORA.b #$20 : STA.l $7EF2D8
    
    LDA.b #$1B : STA.w $012F
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DC2A7-$0DC2F8 LONG JUMP LOCATION
Overworld_CreatePyramidHole:
{
    ; Does tile modification for... the pyramid of power hole
    ; after Ganon slams into it in bat form?
    
    REP #$30
    
    LDX.w #$03BC
    LDA.w #$0E3F
    JSL.l Overworld_DrawPersistentTile16
    
    LDX.w #$03BE
    LDA.w #$0E40
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$043C
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$04BC
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    LDA.w #$3515 : STA.w $012D
    
    SEP #$30
    
    LDA.l $7EF2DB : ORA.b #$20 : STA.l $7EF2DB
    
    LDA.b #$03 : STA.w $012F
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; ZSCREAM: UNUSED: This table is moved somewhere else by ZS and this 
; space is currently unused.
; $0DC2F9-$0DC3F8 DATA - Overworld secrets pointer table
OverworldData_HiddenItems:
{
    dw OverworldData_HiddenItems_00 ; 0x00
    dw OverworldData_HiddenItems_00 ; 0x01
    dw OverworldData_HiddenItems_02 ; 0x02
    dw OverworldData_HiddenItems_03 ; 0x03
    dw OverworldData_HiddenItems_03 ; 0x04
    dw OverworldData_HiddenItems_05 ; 0x05
    dw OverworldData_HiddenItems_05 ; 0x06
    dw OverworldData_HiddenItems_07 ; 0x07
    dw OverworldData_HiddenItems_00 ; 0x08
    dw OverworldData_HiddenItems_00 ; 0x09
    dw OverworldData_HiddenItems_0A ; 0x0A
    dw OverworldData_HiddenItems_03 ; 0x0B
    dw OverworldData_HiddenItems_03 ; 0x0C
    dw OverworldData_HiddenItems_05 ; 0x0D
    dw OverworldData_HiddenItems_05 ; 0x0E
    dw OverworldData_HiddenItems_0F ; 0x0F
    dw OverworldData_HiddenItems_10 ; 0x10
    dw OverworldData_HiddenItems_11 ; 0x11
    dw OverworldData_HiddenItems_12 ; 0x12
    dw OverworldData_HiddenItems_13 ; 0x13
    dw OverworldData_HiddenItems_14 ; 0x14
    dw OverworldData_HiddenItems_15 ; 0x15
    dw OverworldData_HiddenItems_16 ; 0x16
    dw OverworldData_HiddenItems_17 ; 0x17
    dw OverworldData_HiddenItems_18 ; 0x18
    dw OverworldData_HiddenItems_18 ; 0x19
    dw OverworldData_HiddenItems_1A ; 0x1A
    dw OverworldData_HiddenItems_1B ; 0x1B
    dw OverworldData_HiddenItems_1B ; 0x1C
    dw OverworldData_HiddenItems_1D ; 0x1D
    dw OverworldData_HiddenItems_1E ; 0x1E
    dw OverworldData_HiddenItems_1E ; 0x1F
    dw OverworldData_HiddenItems_18 ; 0x20
    dw OverworldData_HiddenItems_18 ; 0x21
    dw OverworldData_HiddenItems_22 ; 0x22
    dw OverworldData_HiddenItems_1B ; 0x23
    dw OverworldData_HiddenItems_1B ; 0x24
    dw OverworldData_HiddenItems_25 ; 0x25
    dw OverworldData_HiddenItems_1E ; 0x26
    dw OverworldData_HiddenItems_1E ; 0x27
    dw OverworldData_HiddenItems_28 ; 0x28
    dw OverworldData_HiddenItems_29 ; 0x29
    dw OverworldData_HiddenItems_2A ; 0x2A
    dw OverworldData_HiddenItems_2B ; 0x2B
    dw OverworldData_HiddenItems_2C ; 0x2C
    dw OverworldData_HiddenItems_2D ; 0x2D
    dw OverworldData_HiddenItems_2E ; 0x2E
    dw OverworldData_HiddenItems_2F ; 0x2F
    dw OverworldData_HiddenItems_30 ; 0x30
    dw OverworldData_HiddenItems_30 ; 0x31
    dw OverworldData_HiddenItems_32 ; 0x32
    dw OverworldData_HiddenItems_33 ; 0x33
    dw OverworldData_HiddenItems_34 ; 0x34
    dw OverworldData_HiddenItems_35 ; 0x35
    dw OverworldData_HiddenItems_35 ; 0x36
    dw OverworldData_HiddenItems_37 ; 0x37
    dw OverworldData_HiddenItems_30 ; 0x38
    dw OverworldData_HiddenItems_30 ; 0x39
    dw OverworldData_HiddenItems_3A ; 0x3A
    dw OverworldData_HiddenItems_3B ; 0x3B
    dw OverworldData_HiddenItems_3C ; 0x3C
    dw OverworldData_HiddenItems_35 ; 0x3D
    dw OverworldData_HiddenItems_35 ; 0x3E
    dw OverworldData_HiddenItems_3F ; 0x3F

    dw OverworldData_HiddenItems_40 ; 0x40
    dw OverworldData_HiddenItems_40 ; 0x41
    dw OverworldData_HiddenItems_42 ; 0x42
    dw OverworldData_HiddenItems_43 ; 0x43
    dw OverworldData_HiddenItems_43 ; 0x44
    dw OverworldData_HiddenItems_45 ; 0x45
    dw OverworldData_HiddenItems_45 ; 0x46
    dw OverworldData_HiddenItems_47 ; 0x47
    dw OverworldData_HiddenItems_40 ; 0x48
    dw OverworldData_HiddenItems_40 ; 0x49
    dw OverworldData_HiddenItems_4A ; 0x4A
    dw OverworldData_HiddenItems_43 ; 0x4B
    dw OverworldData_HiddenItems_43 ; 0x4C
    dw OverworldData_HiddenItems_45 ; 0x4D
    dw OverworldData_HiddenItems_45 ; 0x4E
    dw OverworldData_HiddenItems_4F ; 0x4F
    dw OverworldData_HiddenItems_50 ; 0x50
    dw OverworldData_HiddenItems_51 ; 0x51
    dw OverworldData_HiddenItems_52 ; 0x52
    dw OverworldData_HiddenItems_53 ; 0x53
    dw OverworldData_HiddenItems_54 ; 0x54
    dw OverworldData_HiddenItems_55 ; 0x55
    dw OverworldData_HiddenItems_56 ; 0x56
    dw OverworldData_HiddenItems_57 ; 0x57
    dw OverworldData_HiddenItems_58 ; 0x58
    dw OverworldData_HiddenItems_58 ; 0x59
    dw OverworldData_HiddenItems_5A ; 0x5A
    dw OverworldData_HiddenItems_5B ; 0x5B
    dw OverworldData_HiddenItems_5B ; 0x5C
    dw OverworldData_HiddenItems_5D ; 0x5D
    dw OverworldData_HiddenItems_5E ; 0x5E
    dw OverworldData_HiddenItems_5E ; 0x5F
    dw OverworldData_HiddenItems_58 ; 0x60
    dw OverworldData_HiddenItems_58 ; 0x61
    dw OverworldData_HiddenItems_62 ; 0x62
    dw OverworldData_HiddenItems_5B ; 0x63
    dw OverworldData_HiddenItems_5B ; 0x64
    dw OverworldData_HiddenItems_65 ; 0x65
    dw OverworldData_HiddenItems_5E ; 0x66
    dw OverworldData_HiddenItems_5E ; 0x67
    dw OverworldData_HiddenItems_68 ; 0x68
    dw OverworldData_HiddenItems_69 ; 0x69
    dw OverworldData_HiddenItems_6A ; 0x6A
    dw OverworldData_HiddenItems_6B ; 0x6B
    dw OverworldData_HiddenItems_6C ; 0x6C
    dw OverworldData_HiddenItems_6D ; 0x6D
    dw OverworldData_HiddenItems_6E ; 0x6E
    dw OverworldData_HiddenItems_6F ; 0x6F
    dw OverworldData_HiddenItems_70 ; 0x70
    dw OverworldData_HiddenItems_70 ; 0x71
    dw OverworldData_HiddenItems_72 ; 0x72
    dw OverworldData_HiddenItems_73 ; 0x73
    dw OverworldData_HiddenItems_74 ; 0x74
    dw OverworldData_HiddenItems_75 ; 0x75
    dw OverworldData_HiddenItems_75 ; 0x76
    dw OverworldData_HiddenItems_77 ; 0x77
    dw OverworldData_HiddenItems_70 ; 0x78
    dw OverworldData_HiddenItems_70 ; 0x79
    dw OverworldData_HiddenItems_7A ; 0x7A
    dw OverworldData_HiddenItems_7B ; 0x7B
    dw OverworldData_HiddenItems_7C ; 0x7C
    dw OverworldData_HiddenItems_75 ; 0x7D
    dw OverworldData_HiddenItems_75 ; 0x7E
    dw OverworldData_HiddenItems_7F ; 0x7F
}

; ==============================================================================

; $0DC3F9-$0DC89B Overworld secrets data
; See Pool_Sprite_SpawnSecret for the IDs of each item.

; $0DC3F9-$0DC406 DATA
OverworldData_HiddenItems_00:
{
    dw $036A : db $04
    dw $1914 : db $04
    dw $10E0 : db $80
    dw $1AD0 : db $01
    dw $FFFF
}

; $0DC407-$0DC414 DATA
OverworldData_HiddenItems_02:
{
    dw $04AE : db $01
    dw $0D16 : db $03
    dw $0DA4 : db $01
    dw $0EA0 : db $01
    dw $FFFF
}

; $0DC415-$0DC425 DATA
OverworldData_HiddenItems_03:
{
    dw $186A : db $05
    dw $1872 : db $05
    dw $196E : db $04
    dw $1A6A : db $05
    dw $1A72 : db $05
    dw $FFFF
}

; $0DC426-$0DC428 DATA
OverworldData_HiddenItems_05:
{
    dw $1D4A : db $82
}

; $0DC429-$0DC42A DATA
OverworldData_HiddenItems_07:
{
    dw $FFFF
}

; $0DC42B-$0DC42F DATA
OverworldData_HiddenItems_0A:
{
    dw $0730 : db $02
    dw $FFFF
}

; $0DC430-$0DC434 DATA
OverworldData_HiddenItems_0F:
{
    dw $0618 : db $06
    dw $FFFF
}

; $0DC435-$0DC43C DATA
OverworldData_HiddenItems_10:
{
    dw $0B28 : db $04
    dw $0B2E : db $82
    dw $FFFF
}

; $0DC43D-$0DC444 DATA
OverworldData_HiddenItems_11:
{
    dw $0A34 : db $05
    dw $0D8E : db $06
    dw $FFFF
}

; $0DC445-$0DC44F DATA
OverworldData_HiddenItems_12:
{
    dw $0530 : db $06
    dw $0808 : db $04
    dw $09B2 : db $06
    dw $FFFF
}

; $0DC450-$0DC463 DATA
OverworldData_HiddenItems_13:
{
    dw $0506 : db $84
    dw $07A0 : db $03
    dw $0834 : db $04
    dw $08A8 : db $04
    dw $09A2 : db $06
    dw $09B6 : db $04
    dw $FFFF
}

; $0DC464-$0DC477 DATA
OverworldData_HiddenItems_14:
{
    dw $0490 : db $01
    dw $0492 : db $01
    dw $071C : db $03
    dw $07B8 : db $04
    dw $0A08 : db $04
    dw $0A8C : db $03
    dw $FFFF
}

; $0DC478-$0DC47F DATA
OverworldData_HiddenItems_15:
{
    dw $0390 : db $05
    dw $0788 : db $80
    dw $FFFF
}

; $0DC480-$0DC48D DATA
OverworldData_HiddenItems_16:
{
    dw $079C : db $01
    dw $0826 : db $03
    dw $0928 : db $04
    dw $09A8 : db $04
    dw $FFFF
}

; $0DC48E-$0DC492 DATA
OverworldData_HiddenItems_17:
{
    dw $0E1C : db $06
    dw $FFFF
}

; $0DC493-$0DC4CA DATA
OverworldData_HiddenItems_18:
{
    dw $0AF8 : db $04
    dw $0AFA : db $05
    dw $0EEE : db $01
    dw $1112 : db $03
    dw $111E : db $04
    dw $1216 : db $01
    dw $12A0 : db $01
    dw $1392 : db $01
    dw $139E : db $01
    dw $1A18 : db $04
    dw $1A96 : db $04
    dw $1A9A : db $05
    dw $1B14 : db $04
    dw $1C0C : db $86
    dw $1CB2 : db $03
    dw $156A : db $06
    dw $15E2 : db $04
    dw $15EE : db $04
    dw $FFFF
}

; $0DC4CB-$0DC4D5 DATA
OverworldData_HiddenItems_1A:
{
    dw $04AA : db $03
    dw $0A98 : db $05
    dw $0DAA : db $04
    dw $FFFF
}

; $0DC4D6-$0DC52B DATA
OverworldData_HiddenItems_1B:
{
    dw $028C : db $01
    dw $040C : db $04
    dw $040E : db $04
    dw $0724 : db $03
    dw $02EC : db $04
    dw $0570 : db $80
    dw $065C : db $06
    dw $08F0 : db $01
    dw $09EC : db $06
    dw $0E4A : db $01
    dw $0ED8 : db $01
    dw $0F5A : db $01
    dw $0FD8 : db $01
    dw $10B4 : db $03
    dw $169C : db $04
    dw $16A0 : db $01
    dw $16A2 : db $01
    dw $1C88 : db $01
    dw $1D92 : db $04
    dw $10D4 : db $01
    dw $1554 : db $01
    dw $15DA : db $01
    dw $15DE : db $01
    dw $1652 : db $01
    dw $1666 : db $01
    dw $1D70 : db $05
    dw $1DDA : db $04
    dw $1DE0 : db $06
    dw $FFFF
}

; $0DC52C-$0DC531 DATA
OverworldData_HiddenItems_1D:
{
    dw $0230 : db $01
    dw $0234 : db $05
}

; $0DC532-$0DC533 DATA
OverworldData_HiddenItems_1E:
{
    dw $FFFF
}

; $0DC534-$0DC544 DATA
OverworldData_HiddenItems_22:
{
    dw $0428 : db $05
    dw $0B0E : db $01
    dw $0B10 : db $01
    dw $0B16 : db $01
    dw $0C16 : db $04
    dw $FFFF
}

; $0DC545-$0DC549 DATA
OverworldData_HiddenItems_25:
{
    dw $0908 : db $06
    dw $FFFF
}

; $0DC54A-$0DC54E DATA
OverworldData_HiddenItems_28:
{
    dw $072A : db $04
    dw $FFFF
}

; $0DC54F-$0DC55A DATA
OverworldData_HiddenItems_29:
{
    dw $0308 : db $01
    dw $0728 : db $03
    dw $0808 : db $04
    dw $0926 : db $04
}

; $0DC55B-$0DC55C DATA
OverworldData_HiddenItems_2A:
{
    dw $FFFF
}

; $0DC55D-$0DC573 DATA
OverworldData_HiddenItems_2B:
{
    dw $031E : db $01
    dw $0330 : db $84
    dw $0C10 : db $01
    dw $0C18 : db $04
    dw $0C1A : db $06
    dw $0C8E : db $01
    dw $0C96 : db $01
    dw $FFFF
}

; $0DC574-$0DC58B DATA
OverworldData_HiddenItems_2C:
{
    dw $0214 : db $01
    dw $089E : db $01
    dw $0890 : db $01
    dw $0906 : db $01
    dw $0984 : db $04
    dw $0A1C : db $05
    dw $0AB4 : db $06
    dw $0BB6 : db $01
}

; $0DC58C-$0DC58D DATA
OverworldData_HiddenItems_2D:
OverworldData_HiddenItems_2E:
{
    dw $FFFF
}

; $0DC58E-$0DC595 DATA
OverworldData_HiddenItems_2F:
{
    dw $0BB2 : db $82
    dw $0D12 : db $05
    dw $FFFF
}

; $0DC596-$0DC5A3 DATA
OverworldData_HiddenItems_30:
{
    dw $0358 : db $84
    dw $0A50 : db $04
    dw $1406 : db $06
    dw $1D94 : db $82
    dw $FFFF
}

; $0DC5A4-$0DC5AE DATA
OverworldData_HiddenItems_32:
{
    dw $051E : db $05
    dw $052A : db $04
    dw $059C : db $05
    dw $FFFF
}

; $0DC5AF-$0DC5B6 DATA
OverworldData_HiddenItems_33:
{
    dw $02A8 : db $82
    dw $0B14 : db $02
    dw $FFFF
}

; $0DC5B7-$0DC5BE DATA
OverworldData_HiddenItems_34:
{
    dw $03B0 : db $86
    dw $048C : db $04
    dw $FFFF
}

; $$0DC5BF-$0DC5CF DATA
OverworldData_HiddenItems_35:
{
    dw $0A30 : db $04
    dw $0C10 : db $06
    dw $0F56 : db $82
    dw $180C : db $86
    dw $1CDE : db $03
    dw $FFFF
}

; $0DC5D0-$0DC5DA DATA
OverworldData_HiddenItems_37:
{
    dw $0288 : db $86
    dw $03AA : db $05
    dw $040C : db $84
    dw $FFFF
}

; $0DC5DB-$0DC5E5 DATA
OverworldData_HiddenItems_3A:
{
    dw $081E : db $02
    dw $09AC : db $06
    dw $0A1E : db $84
    dw $FFFF
}

; $0DC5E6-$0DC5EA DATA
OverworldData_HiddenItems_3B:
{
    dw $061A : db $03
    dw $FFFF
}

; $0DC5EB-$0DC5F2 DATA
OverworldData_HiddenItems_3C:
{
    dw $0696 : db $03
    dw $0710 : db $04
    dw $FFFF
}

; $0DC5F3-$0DC5F7 DATA
OverworldData_HiddenItems_3F:
{
    dw $0C28 : db $04
    dw $FFFF
}

; $0DC5F8-$$0DC617 DATA
OverworldData_HiddenItems_40:
{
    dw $0338 : db $04
    dw $036A : db $01
    dw $0570 : db $03
    dw $05F2 : db $04
    dw $1914 : db $03
    dw $1D38 : db $06
    dw $1DBC : db $05
    dw $105E : db $04
    dw $10E0 : db $80
    dw $1162 : db $01
    dw $FFFF
}

; $0DC618-$$0DC62E DATA
OverworldData_HiddenItems_42:
{
    dw $04AC : db $01
    dw $05B4 : db $01
    dw $090A : db $03
    dw $0D98 : db $01
    dw $0DA4 : db $01
    dw $0E1E : db $01
    dw $0EA8 : db $01
    dw $FFFF
}

; $0DC62F-$0DC64E DATA
OverworldData_HiddenItems_43:
{
    dw $0A60 : db $04
    dw $0BDA : db $04
    dw $0BE6 : db $04
    dw $0D60 : db $04
    dw $1920 : db $01
    dw $1A04 : db $04
    dw $17EE : db $06
    dw $1968 : db $06
    dw $1974 : db $06
    dw $1AEE : db $06
    dw $FFFF
}

; $0DC64F-$$0DC657 DATA
OverworldData_HiddenItems_45:
{
    dw $0868 : db $84
    dw $13D8 : db $05
    dw $145A : db $05
}

; $0DC658-$0DC659 DATA
OverworldData_HiddenItems_47:
OverworldData_HiddenItems_4A:
{
    dw $FFFF
}

; $0DC65A-$0DC66A DATA
OverworldData_HiddenItems_4F:
{
    dw $06AE : db $05
    dw $06B4 : db $05
    dw $0832 : db $06
    dw $0A32 : db $06
    dw $0B1C : db $06
    dw $FFFF
}

; $0DC66B-$0DC67E DATA
OverworldData_HiddenItems_50:
{
    dw $040C : db $01
    dw $0792 : db $01
    dw $0798 : db $04
    dw $079E : db $04
    dw $07A4 : db $01
    dw $0A34 : db $01
    dw $FFFF
}

; $0DC67F-$0DC698 DATA
OverworldData_HiddenItems_51:
{
    dw $0716 : db $03
    dw $092A : db $01
    dw $0A34 : db $05
    dw $0AA4 : db $01
    dw $0B98 : db $01
    dw $0C1A : db $01
    dw $0D18 : db $01
    dw $0D8E : db $04
    dw $FFFF
}

; $0DC699-$0DC6AF DATA
OverworldData_HiddenItems_52:
{
    dw $04B2 : db $06
    dw $0530 : db $06
    dw $05AE : db $06
    dw $0788 : db $01
    dw $0808 : db $01
    dw $0888 : db $01
    dw $09B2 : db $04
    dw $FFFF
}

; $0DC6B0-$0DC6E1 DATA
OverworldData_HiddenItems_53:
{
    dw $0584 : db $05
    dw $05B8 : db $04
    dw $0606 : db $05
    dw $0688 : db $05
    dw $070A : db $05
    dw $078C : db $05
    dw $07A0 : db $01
    dw $07B6 : db $03
    dw $0822 : db $01
    dw $082E : db $01
    dw $08A6 : db $01
    dw $08B0 : db $01
    dw $0920 : db $04
    dw $0928 : db $01
    dw $0934 : db $01
    dw $09B6 : db $01
    dw $FFFF
}

; $0DC6E2-$0DC6EF DATA
OverworldData_HiddenItems_54:
{
    dw $0490 : db $04
    dw $0492 : db $04
    dw $05AE : db $01
    dw $07B8 : db $03
    dw $FFFF
}

; $0DC6F0-$0DC6F7 DATA
OverworldData_HiddenItems_55:
{
    dw $038A : db $05
    dw $0788 : db $04
    dw $FFFF
}

; $0DC6F8-$0DC70E DATA
OverworldData_HiddenItems_56:
{
    dw $079C : db $04
    dw $08A6 : db $01
    dw $0926 : db $01
    dw $09A6 : db $01
    dw $0A26 : db $01
    dw $0C98 : db $01
    dw $0D1A : db $01
    dw $FFFF
}

; $0DC70F-$0DC716 DATA
OverworldData_HiddenItems_57:
{
    dw $0E1C : db $06
    dw $0E20 : db $06
    dw $FFFF
}

; $0DC717-$0DC766 DATA
OverworldData_HiddenItems_58:
{
    dw $049A : db $04
    dw $0C96 : db $03
    dw $0654 : db $01
    dw $0656 : db $01
    dw $0AF8 : db $04
    dw $0AFA : db $04
    dw $0CD6 : db $01
    dw $0E64 : db $01
    dw $0F66 : db $01
    dw $1092 : db $01
    dw $10A0 : db $04
    dw $1114 : db $01
    dw $1212 : db $01
    dw $121E : db $04
    dw $1296 : db $01
    dw $199C : db $04
    dw $1A14 : db $04
    dw $1A98 : db $04
    dw $1B1E : db $04
    dw $1C34 : db $05
    dw $1CA6 : db $05
    dw $1AB6 : db $86
    dw $14EC : db $01
    dw $15E2 : db $01
    dw $1A4A : db $04
    dw $1B48 : db $03
    dw $FFFF
}

; $0DC767-$0DC786 DATA
OverworldData_HiddenItems_5A:
{
    dw $041A : db $06
    dw $08B4 : db $01
    dw $0A32 : db $01
    dw $0B32 : db $01
    dw $0C22 : db $01
    dw $0C26 : db $01
    dw $0C2C : db $01
    dw $0C30 : db $01
    dw $0C8E : db $05
    dw $0CB4 : db $01
    dw $FFFF
}

; $0DC787-$0DC79B DATA
OverworldData_HiddenItems_5B:
{
    dw $0E2E : db $86
    dw $1C88 : db $04
    dw $1E0E : db $01
    dw $1E12 : db $01
    dw $1DDA : db $01
    dw $1E60 : db $01
    dw $1E72 : db $03
}

; $0DC79C-$0DC79D DATA
OverworldData_HiddenItems_5D:
OverworldData_HiddenItems_5E:
{
    dw $FFFF
}

; $0DC79E-$0DC7B1 DATA
OverworldData_HiddenItems_62:
{
    dw $0428 : db $04
    dw $0B92 : db $01
    dw $0C92 : db $01
    dw $0C96 : db $01
    dw $0D92 : db $01
    dw $0E10 : db $01
    dw $FFFF
}

; $0DC7B2-$0DC7B6 DATA
OverworldData_HiddenItems_65:
{
    dw $0908 : db $06
    dw $FFFF
}

; $0DC7B7-$0DC7C4 DATA
OverworldData_HiddenItems_68:
{
    dw $0420 : db $01
    dw $0428 : db $01
    dw $0920 : db $03
    dw $0AB2 : db $04
    dw $FFFF
}

; $0DC7C5-$0DC7D6 DATA
OverworldData_HiddenItems_69:
{
    dw $0408 : db $01
    dw $040C : db $01
    dw $0728 : db $04
    dw $0926 : db $01
    dw $09A4 : db $01
    dw $09A6 : db $01
}

; $0DC7D7-$0DC7D8 DATA
OverworldData_HiddenItems_6A:
{
    dw $FFFF
}

; $0DC7D9-$0DC7EC DATA
OverworldData_HiddenItems_6B:
{
    dw $0320 : db $04
    dw $0330 : db $84
    dw $0C0E : db $01
    dw $0C12 : db $01
    dw $0C96 : db $01
    dw $0C9A : db $01
    dw $FFFF
}

; $0DC7ED-$0DC80A DATA
OverworldData_HiddenItems_6C:
{
    dw $0226 : db $01
    dw $0890 : db $01
    dw $089C : db $01
    dw $0906 : db $01
    dw $0912 : db $01
    dw $091E : db $01
    dw $0984 : db $04
    dw $0AB4 : db $04
    dw $0B36 : db $04
    dw $0BB8 : db $04
}

; $0DC80B-$0DC80C DATA
OverworldData_HiddenItems_6D:
OverworldData_HiddenItems_6E:
{
    dw $FFFF
}

; $0DC80D-$0DC81A DATA
OverworldData_HiddenItems_6F:
{
    dw $0B24 : db $05
    dw $0B8C : db $05
    dw $0B96 : db $05
    dw $0D12 : db $05
    dw $FFFF
}

; $0DC81B-$0DC822 DATA
OverworldData_HiddenItems_70:
{
    dw $1406 : db $06
    dw $1486 : db $06
    dw $FFFF
}

; $0DC823-$0DC83D DATA
OverworldData_HiddenItems_72:
{
    dw $051C : db $04
    dw $051E : db $04
    dw $059C : db $04
    dw $059E : db $04
    dw $0626 : db $03
    dw $0A8C : db $01
    dw $0B90 : db $01
    dw $0C08 : db $01
    dw $0D0C : db $01
}

; $0DC83E-$0DC83F DATA
OverworldData_HiddenItems_73:
{
    dw $FFFF
}

; $0DC840-$0DC856 DATA
OverworldData_HiddenItems_74:
{
    dw $03B0 : db $86
    dw $040C : db $01
    dw $0590 : db $01
    dw $0614 : db $01
    dw $0728 : db $06
    dw $090A : db $01
    dw $0D9E : db $04
    dw $FFFF
}

; $0DC857-$0DC85E DATA
OverworldData_HiddenItems_75:
{
    dw $0298 : db $06
    dw $0C10 : db $04
    dw $FFFF
}

; $0DC85F-$0DC86C DATA
OverworldData_HiddenItems_77:
{
    dw $0288 : db $86
    dw $03AA : db $06
    dw $040C : db $84
    dw $0518 : db $05
    dw $FFFF
}

; $0DC86D-$0DC87A DATA
OverworldData_HiddenItems_7A:
{
    dw $0526 : db $05
    dw $052A : db $05
    dw $052E : db $05
    dw $09AC : db $06
    dw $FFFF
}

; $0DC87B-$0DC885 DATA
OverworldData_HiddenItems_7B:
{
    dw $0420 : db $06
    dw $061A : db $04
    dw $0696 : db $04
    dw $FFFF
}

; $0DC886-$0DC893 DATA
OverworldData_HiddenItems_7C:
{
    dw $02A8 : db $05
    dw $0316 : db $06
    dw $0698 : db $06
    dw $0714 : db $04
    dw $FFFF
}

; $0DC894-$0DC89B DATA
OverworldData_HiddenItems_7F:
{
    dw $02AE : db $04
    dw $0C28 : db $04
    dw $FFFF
}

; ==============================================================================

; $0DC89C-$0DC8A3 DATA
Overworld_SecretTileType:
{
    dw $0DCC ; Hole
    dw $0212 ; Portal
    dw $FFFF ; Garbage
    dw $0DB4 ; Bomb hole
}

; ==============================================================================

; ZScream: Updates a couple of references in this function.
; Routine is used for checking if there's secrets underneath a newly
; exposed Tile16 tile.
; $0DC8A4-$0DC942 LOCAL JUMP LOCATION
Overworld_RevealSecret:
{
    STX.b $04
    
    LDA.w $0B9C : AND.w #$FF00 : STA.w $0B9C
    
    ; Special areas don't have secrets.
    LDA.b $8A : CMP.w #$0080 : BCS .isSW
        ; Get pointer to secrets data for this area.
        ASL : TAX

        ; ZScream: This reference is updated by ZS.
        LDA.l OverworldData_HiddenItems, X : STA.b $00
        
        ; Set source bank for data.
        ; ZScream: This reference is updated by ZS.
        LDA.w #OverworldData_HiddenItems>>16 : STA.b $02
        
        LDY.w #$FFFD
        
        .nextSecret
        
            INY #3
            LDA.b [$00], Y : CMP.w #$FFFF : BEQ .failure
        AND.w #$7FFF : CMP.b $04 : BNE .nextSecret
        
        INY : INY
        LDA.b [$00], Y : AND.w #$00FF : BEQ .emptySecret
            CMP.w #$0080 : BCS .extendedSecret
                TSB.w $0B9C

            .extendedSecret
        .emptySecret
        
        AND.w #$00FF : CMP.w #$0080 : BCC .normalSecret
            PHA
        
            LDA.w $0B9C : ORA.w #$00FF : STA.w $0B9C
            
            PLA : CMP.w #$0084 : BEQ .notBurrow
                LDX.b $8A
                LDA.l $7EF280, X : AND.w #$0002 : BNE .overlayAlreadyActivated
                    LDA.b $8A : CMP.w #$005B : BNE .notAtPyramidOfPower
                        LDA.l $7EF3CC : AND.w #$00FF : CMP.w #$000D : BNE .failure
                    
                    .notAtPyramidOfPower
                    
                    SEP #$20
                    LDA.b #$1B : STA.w $012F
                    REP #$20
                    
                .overlayAlreadyActivated
            .notBurrow
            
            LDA.b [$00], Y : AND.w #$000F : TAX
            LDA.l Overworld_SecretTileType, X : STA.b $0E
    
        .failure
    .isSW
    
    JSR.w AdjustSecretForPowder
    
    LDX.b $04
    
    CLC
    
    RTS
    
    .normalSecret
    
    JSR.w AdjustSecretForPowder
    
    LDX.b $04
    LDA.b $0E
    
    SEC
    
    RTS
}

; ==============================================================================

; $0DC943-$0DC951 LOCAL JUMP LOCATION
AdjustSecretForPowder:
{
    LDA.w $0301 : AND.w #$0040 : BEQ .notUsingMagicPowder
        LDA.w #$0004 : STA.w $0B9C
    
    .notUsingMagicPowder
    
    RTS
}

; ==============================================================================

; $0DC952-$0DC97B LONG JUMP LOCATION
Overworld_DrawWoodenDoor:
{
    BCS .draw_closed_door
        ; The only other option is to, you guessed it your cleverness, an open
        ; door.
        LDA.w #$0DA4
        JSL.l Overworld_DrawPersistentTile16
        
        LDA.w #$0DA6
        
        BRA .draw_right_half
    
    .draw_closed_door
    
    LDA.w #$0DA5
    JSL.l Overworld_DrawPersistentTile16
    
    LDA.w #$0DA7
    
    .draw_right_half
    
    STA.l $7E2002, X
    
    LDY.w #$0002
    JSL.l Overworld_DrawTile16_Anywhere
    
    SEP #$3
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DC97C-$$0DC97F LONG JUMP LOCATION
Overworld_DrawPersistentTile16:
{
    STA.l $7E2000, X

    ; Bleeds into the next function.
}

; $0DC980-$0DC982 LONG JUMP LOCATION
Overworld_DrawTile16:
{
    LDY.w #$0000

    ; Bleeds into the next function.
}

; $0DC983-$0DC9DD LONG JUMP LOCATION
Overworld_DrawTile16_Anywhere:
{
    PHX
    
    ; Store the index into the tiles to use in $0C.
    ASL #3 : STA.b $0C
    
    STY.b $00
    
    TXA : CLC : ADC.b $00 : STA.b $00
    
    JSR.w Overworld_FindTile16VRAMAddress

    ; Write the base VRAM (tilemap) address of the first two tiles.
    LDY.w $1000
    LDA.b $02 : XBA : STA.w $1002, Y
    
    ; Write the base VRAM address of the second two tiles.
    LDA.b $02 : CLC : ADC.w #$0020 : XBA : STA.w $100A, Y
    
    ; Probably indicates the number of tiles and some other information.
    LDA.w #$0300 : STA.w $1004, Y
                   STA.w $100C, Y
    
    LDX.b $0C
    LDA.l Tile16Definitions_0, X : STA.w $1006, Y
    LDA.l Tile16Definitions_1, X : STA.w $1008, Y
    LDA.l Tile16Definitions_2, X : STA.w $100E, Y
    LDA.l Tile16Definitions_3, X : STA.w $1010, Y
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    TYA : CLC : ADC.w #$0010 : STA.w $1000
    
    PLX
    
    RTL
}

; ==============================================================================

; $0DC9DE-$0DCA68 LOCAL JUMP LOCATION
Overworld_AlterTileHardcore:
{
    ; Has to do with solidity of the tiles being written.
    PHA : STA.l $7E2000, X
    
    PHX
    
    ; Multiply by 8. Will be an index into a set of tiles
    ASL #3 : STA.b $0C
    
    TXA : CLC : ADC.w #$0000 : STA.b $00
    
    STZ.b $02
    
    ; $If A < #$20, then...
    AND.w #$003F : CMP.w #$0020 : BCC .BRANCH_ALPHA    
        LDA.w #$0400 : STA.b $02
    
    .BRANCH_ALPHA
    
    ; If A < #$800 then...
    LDA.b $00 : AND.w #$0FFF : CMP.w #$0800 : BCC .BRANCH_BETA
        LDA.b $02 : ADC.w #$07FF : STA.b $02
    
    .BRANCH_BETA
    
    LDA.b $00 : AND.w #$001F       : ADC.b $02 : STA.b $02
    LDA.b $00 : AND.w #$0780 : LSR : ADC.b $02 : STA.b $02
    
    LDY.w $1000
    
    XBA
    
    STA.w $1002, Y
    
    LDA.b $02 : CLC : ADC.w #$0020 : XBA : STA.w $100A, Y
    
    LDA.w #$0300 : STA.w $1004, Y
                   STA.w $100C, Y

    ; Load tile indices from ROM.
    LDX.b $0C
    LDA.l Tile16Definitions_0, X : STA.w $1006, Y ; The top left corner.
    LDA.l Tile16Definitions_1, X : STA.w $1008, Y ; The top right corner.
    LDA.l Tile16Definitions_2, X : STA.w $100E, Y ; The bottom left corner.
    LDA.l Tile16Definitions_3, X : STA.w $1010, Y ; The bottom right corner.
    
    TYA : CLC : ADC.w #$0010 : STA.w $1000
    
    PLX
    INX : INX
    
    PLA : INC
    
    RTS
}

; ==============================================================================

; I guess this calculates some sort of VRAM type address for an outdoor tile?
; $0DCA69-$0DCA9E LOCAL JUMP LOCATION
Overworld_FindTile16VRAMAddress:
{
    STZ.b $02
    
    LDA.b $00 : AND.w #$003F : CMP.w #$0020 : BCC .BRANCH_ALPHA
        LDA.w #$0400 : STA.b $02
    
    .BRANCH_ALPHA
    
    LDA.b $00 : AND.w #$0FFF : CMP.w #$0800 : BCC .BRANCH_BETA
        LDA.b $02 : ADC.w #$07FF : STA.b $02
    
    .BRANCH_BETA
    
    LDA.b $00 : AND.w #$001F       : ADC.b $02 : STA.b $02
    LDA.b $00 : AND.w #$0780 : LSR : ADC.b $02 : STA.b $02
    
    RTS
}

; ==============================================================================

; $0DCA9F-$0DCAB9 LONG JUMP LOCATION
Overworld_DrawWarpTile:
{
    REP #$30 
    
    LDA.w #$0212
    LDY.w #$0720
    
    STA.l $7E2000, X
    
    JSL.l Overworld_Memorize_Tile16_Change
    JSL.l Overworld_DrawTile16
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DCABA-$0DCAC3 JUMP TABLE
Overworld_EntranceSequence_handlers:
{
    dw DarkPalaceEntrance_Main               ; 0x00 - $CADE
    dw Overworld_AnimateEntrance_Skull       ; 0x01 - $CBA6
    dw MiseryMireEntrance_Main               ; 0x02 - $CCD4
    dw TurtleRockEntrance_Main               ; 0x03 - $CE28
    dw Overworld_AnimateEntrance_GanonsTower ; 0x04 - $CFD9
}

; A = $04C6 or the index of the entrance animation +1.
; $0DCAC4-$0DCAD3 LONG JUMP LOCATION
Overworld_EntranceSequence:
{
    STA.w $02E4 ; Link can't move.
    STA.w $0FC1 ; Freeze sprites.
    STA.w $0710 ; There is a special graphical effect about to happen.
    
    DEC : ASL : TAX
    JSR.w (.handlers, X)
    
    RTL
}

; ==============================================================================

; $0DCAD4-$0DCADD JUMP TABLE
DarkPalaceEntrance_Main_handlers:
{
    dw AnimateEntrance_PoD_step1 ; 0x00 - $CAE5
    dw AnimateEntrance_PoD_step2 ; 0x01 - $CB2B
    dw AnimateEntrance_PoD_step3 ; 0x02 - $CB47
    dw AnimateEntrance_PoD_step4 ; 0x03 - $CB6C
    dw AnimateEntrance_PoD_step5 ; 0x04 - $CB91
}

; $0DCADE-$0DCAE4 JUMP LOCATION
DarkPalaceEntrance_Main:
{
    LDA.b $B0 : ASL : TAX
    JMP.w (.handlers, X)
}

; ==============================================================================

; $0DCAE5-$0DCB2A JUMP LOCATION
AnimateEntrance_PoD_step1:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$40 : BNE .return
        JSR.w OverworldEntrance_AdvanceAndBoom
    
        LDA.l $7EF2DE : ORA.b #$20 : STA.l $7EF2DE
        
        REP #$30
        
        LDX.w #$01E6
        LDA.w #$0E31
        JSL.l Overworld_DrawPersistentTile16
        
        ; $0DCB18 ALTERNATE ENTRY POINT
        .modify_bottom_stair_part
        
        LDX.w #$02EA
        
        ; $0DCB1B ALTERNATE ENTRY POINT
        .modify_specific_stair_part
        
        LDA.w #$0E30
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$026A
        LDA.w #$0E26
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$02EA
        JSR.w Overworld_AlterTileHardcore
        
        LDA.w #$FFFF : STA.w $1012, X
        
        SEP #$30
        
        LDA.b #$01 : STA.b $14
    
    .return
    
    RTS
}

; ==============================================================================

; $0DCB2B-$0DCB46 JUMP LOCATION
AnimateEntrance_PoD_step2:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_PoD_step1_return
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$026A
        LDA.w #$0E28
        JSL.l Overworld_DrawPersistentTile16
        
        LDA.w #$0E29
        
        BRA AnimateEntrance_PoD_step1_modify_bottom_stair_part
}

; ==============================================================================

; $0DCB47-$0DCB6B JUMP LOCATION
AnimateEntrance_PoD_step3:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_PoD_step1_return
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$026A
        LDA.w #$0E2A
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$02EA
        LDA.w #$0E2B
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$036A
        
        BRA AnimateEntrance_PoD_step1_modify_specific_stair_part
}

; ==============================================================================

; $0DCB6C-$0DCB90 JUMP LOCATION
AnimateEntrance_PoD_step4:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_PoD_step2
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$026A
        LDA.w #$0E2D
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$02EA
        LDA.w #$0E2E
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$036A
        
        BRA AnimateEntrance_PoD_step1_modify_specific_stair_part
}

; ==============================================================================

; $0DCB91-$0DCB9B JUMP LOCATION
AnimateEntrance_PoD_step5:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_PoD_step1
        JMP.w OverworldEntrance_PlayJingle
}

; ==============================================================================

; $0DCB9C-$0DCBA5 JUMP TABLE
Overworld_AnimateEntrance_Skull_handlers:
{
    dw AnimateEntrance_Skull_step1 ; 0x00 - $CBAD
    dw AnimateEntrance_Skull_step2 ; 0x01 - $CBEE
    dw AnimateEntrance_Skull_step3 ; 0x02 - $CC27
    dw AnimateEntrance_Skull_step4 ; 0x03 - $CC4D
    dw AnimateEntrance_Skull_step5 ; 0x04 - $CC8C
}

; $0DCBA6-$0DCBAC JUMP LOCATION
Overworld_AnimateEntrance_Skull:
{
    LDA.b $B0 : ASL : TAX
    JMP.w (.handlers, X)
}

; $0DCBAD-$0DCBED JUMP LOCATION
AnimateEntrance_Skull_step1:
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$04 : BNE .delay
        INC.b $B0
    
        STZ.b $C8
    
        REP #$30
    
        LDX.w #$0812
        LDA.w #$0E06
        JSL.l Overworld_DrawPersistentTile16
    
        LDX.w #$0814
        LDA.w #$0E06
        JSR.w Overworld_AlterTileHardcore
    
        LDA.w #$FFFF : STA.w $1012
    
        SEP #$30
    
        LDX.b $8A
        LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
        SEP #$30
    
        LDA.b #$01 : STA.b $14
    
        LDA.b #$16 : STA.w $012F
    
    ; $0DCBED ALTERNATE ENTRY POINT
    .delay
    
    RTS
}

; $0DCBEE-$0DCC11 JUMP LOCATION
AnimateEntrance_Skull_step2:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$0C : BNE AnimateEntrance_Skull_step1_delay
    	INC.b $B0
    
    	STZ.b $C8
    
    	REP #$30
    
    	LDX.w #$0790
    	LDA.w #$0E07
    	JSL.l Overworld_DrawPersistentTile16
    
    	LDX.w #$0792
    	LDA.w #$0E08
    	JSR.w Overworld_AlterTileHardcore
    	JSR.w Overworld_AlterTileHardcore

    	; Bleeds into the next function.
}

; $0DCC12-$0DCC26 JUMP LOCATION
OverworldEntrance_AdvanceAndThud:
{
    JSR.w Overworld_AlterTileHardcore
    
    LDA.w #$FFFF : STA.w $1012, X
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    LDA.b #$16 : STA.w $012F
    
    RTS
}

; $0DCC27-$0DCC4C JUMP LOCATION
AnimateEntrance_Skull_step3:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$0C : BNE AnimateEntrance_Skull_step1_delay
        INC.b $B0
    
        STZ.b $C8
    
        REP #$30
    
        LDX.w #$0710
        LDA.w #$0E07
        JSL.l Overworld_DrawPersistentTile16
    
        LDX.w #$0712
        LDA.w #$0E08
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
    
        BRA OverworldEntrance_AdvanceAndThud
}

; $0DCC4D-$0DCC8B JUMP LOCATION
AnimateEntrance_Skull_step4:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$0C : BNE AnimateEntrance_Skull_step1_delay
       INC.b $B0
    
       STZ.b $C8
    
       REP #$30
    
       LDX.w #$0590
       LDA.w #$0E11
       JSL.l Overworld_DrawPersistentTile16
    
       LDX.w #$0596
       LDA.w #$0E12
       JSR.w Overworld_AlterTileHardcore
    
       LDX.w #$0610
       LDA.w #$0E0D
       JSR.w Overworld_AlterTileHardcore
       JSR.w Overworld_AlterTileHardcore
       JSR.w Overworld_AlterTileHardcore
       JSR.w Overworld_AlterTileHardcore
    
       LDX.w #$0692
       LDA.w #$0E0B
       JSR.w Overworld_AlterTileHardcore
    
       JMP.w OverworldEntrance_AdvanceAndThud
}

; $0DCC8C-$0DCCC7 JUMP LOCATION
AnimateEntrance_Skull_step5:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$0C : BNE AnimateEntrance_Skull_step1_delay
        INC.b $B0
        
        STZ.b $C8
        
        REP #$30
        
        LDX.w #$0590
        LDA.w #$0E13
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0596
        LDA.w #$0E14
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$0610
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$0692
        JSR.w Overworld_AlterTileHardcore
        
        JSR.w OverworldEntrance_AdvanceAndThud
        
        JMP.w OverworldEntrance_PlayJingle
}

; ==============================================================================

; $0DCCC8-$0DCCD3 JUMP TABLE
MiseryMireEntrance_Main_handlers:
{
    dw MiseryMireEntrance_PhaseOutRain ; 0x00 - $CD14
    dw AnimateEntrance_Mire_step2      ; 0x01 - $CD41 Set up the rumbling noise 
    dw AnimateEntrance_Mire_step2      ; 0x02 - $CD41 The first graphical change
    dw AnimateEntrance_Mire_step3      ; 0x03 - $CDA9 The second graphical change
    dw AnimateEntrance_Mire_step4      ; 0x04 - $CDD7 The third graphical change
    dw AnimateEntrance_Mire_step5      ; 0x05 - $CE05
}

; $0DCCD4-$0DCCF9 LOCAL JUMP LOCATION
MiseryMireEntrance_Main:
{
    ; if($B0 < 0x02)
    LDA.b $B0 : CMP.b #$02 : BCC .anoshake_screen
        REP #$20
        
        ; Load the frame counter.
        LDA.b $1A : AND.w #$0001 : ASL : TAX
        
        ; Shake the earth! This is the earthquake type effect.
        LDA.l OverworldShake_Offsets_Y, X : STA.w $011A
        LDA.l OverworldShake_Offsets_X, X : STA.w $011C
        
        SEP #$20
    
    .anoshake_screen
    
    LDA.b $B0 : ASL : TAX
    JMP.w (.handlers, X)
}

; $0DCCFA-$0DCD13 DATA
MiseryMireEntrance_PhaseOutRain_phase_masks:
{
    db $FF, $F7, $F7, $FB, $EE, $EE, $EE, $EE
    db $EE, $EE, $AA, $AA, $AA, $AA, $AA, $AA
    db $AA, $88, $88, $88, $88, $80, $80, $80
    db $80, $80
}

; NOTE: Assume a data bank register value of 0x00 here. Yeah, strange, I know.
; $0DCD14-$0DCD40 JUMP LOCATION
MiseryMireEntrance_PhaseOutRain:
{
    ; If $C8 <= #$20. Delay for 20 frames basically.
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BCC .delay
        ; ($C8 - 0x20) != 0xCF
        SEC : SBC.b #$20 : CMP.b #$CF : BNE .not_next_step_yet
            ; After 0xEF frames have counted down, go on to the next step
            ; And reset the substep index.
            INC.b $B0
            STZ.b $C8
        
        .not_next_step_yet
        
                           PHA
        AND.b #$07 : ASL : TAY
        
        PLA : AND.b #$F8 : LSR #3 : TAX
        
        LDA.w DungeonMask+1, Y
        
        STZ.b $1D
        
        AND.l .phase_masks, X : BEQ .no_rain
            ; Turn the overlay back on if the two numbers share some bits
            INC.b $1D
        
        .no_rain
    .delay
    
    RTS
}

; $0DCD41-$0DCDA8 JUMP LOCATION
AnimateEntrance_Mire_step2:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$10 : BNE .delay
        ; On the 0x10th frame move to the next step.
        INC.b $B0
        
        ; Play a sound effect.
        LDY.b #$07 : STY.w $012D
    
    .delay
    
    ; If $C8 != 0x48, end the routine.
    CMP.b #$48 : BNE .return
        JSR.w OverworldEntrance_AdvanceAndBoom; SFX FOR THE ENTRANCE OPENING
        
        ; So, on the 0x48th frame, 
        
        ; Check off the fact that this has been opened.
        LDX.b $8A
        LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
        
        REP #$30
        
        ; A tile grid coordinate for the animation.
        ; Add 0x80 to move down one block. Add #$02 to move over one block.
        LDX.w #$0622
        
        ; An index into the set of tiles to use.
        LDA.w #$0E48
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0624
        LDA.w #$0E49
        
        ; $0DCD75 ALTERNATE ENTRY POINT
        .drawBulk
        
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore ; Draw the next 3 tiles
        
        LDX.w #$06A2
        JSR.w Overworld_AlterTileHardcore ; Draw the next 4 tiles
        JSR.w Overworld_AlterTileHardcore ; one line below
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$0722
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        
        LDA.w #$FFFF : STA.w $1012, Y
        
        SEP #$30
        
        LDA.b #$01 : STA.b $14
    
    ; $0DCDA8 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; $0DCDA9-$0DCDD6 JUMP LOCATION
AnimateEntrance_Mire_step3:
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$48 : BNE AnimateEntrance_Mire_step2_return
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$05A2
        LDA.w #$0E54
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$05A4
        LDA.w #$0E55
        
        ; $0DCDC6 BRANCH LOCATION
        .continue_many_many_replacements
        
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$0622
        JSR.w Overworld_AlterTileHardcore
        
        BRA AnimateEntrance_Mire_step2_drawBulk
}

; $0DCDD7-$0DCE04 JUMP LOCATION
AnimateEntrance_Mire_step4:
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$50 : BNE AnimateEntrance_Mire_step2_return
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$0522
        LDA.w #$0E64
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0524
        LDA.w $0E65
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$05A2
        JSR.w Overworld_AlterTileHardcore
        
        BRA AnimateEntrance_Mire_step3_continue_many_many_replacements
}

; $0DCE05-$0DCE15 JUMP LOCATION
AnimateEntrance_Mire_step5:
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$80 : BNE .BRANCH_ALPHA
        ; CLEAN UP, PLAY SOUND AND RETURN NORMALCY.
        JSR.w OverworldEntrance_PlayJingle
        
        LDA.b #$05 : STA.w $012D
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0DCE16-$0DCE27 DATA
TurtleRockEntrance_Main_handlers:
{
    dw AnimateEntrance_TurtleRock_step1 ; 0x00 - $CE48
    dw AnimateEntrance_TurtleRock_step2 ; 0x01 - $CE5E
    dw AnimateEntrance_TurtleRock_step3 ; 0x02 - $CE62
    dw AnimateEntrance_TurtleRock_step4 ; 0x03 - $CE66
    dw AnimateEntrance_TurtleRock_step5 ; 0x04 - $CE8A
    dw AnimateEntrance_TurtleRock_step6 ; 0x05 - $CEAC
    dw AnimateEntrance_TurtleRock_step7 ; 0x06 - $CEF8
    dw AnimateEntrance_TurtleRock_step8 ; 0x07 - $CF17
    dw OverworldEntrance_PlayJingle     ; 0x08 - $CF40
}

; $0DCE28-$0DCE47 JUMP LOCATION
TurtleRockEntrance_Main:
{
    REP #$20
    
    LDA.b $1A : AND.w #$0001 : ASL : TAX
    LDA.l OverworldShake_Offsets_Y, X : STA.w $011A
    LDA.l OverworldShake_Offsets_X, X : STA.w $011C
    
    SEP #$20
    
    LDA.b $B0 : ASL : TAX
    JMP.w (.handlers, X)
}

; $0DCE48-$0DCE5D JUMP LOCATION
AnimateEntrance_TurtleRock_step1:
{
    LDX.b $8A
    LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
    LDA.b #$00
    JSL.l Dungeon_ApproachFixedColor_variable
    
    LDA.b #$10
    
    BRA AnimateEntrance_TurtleRock_step4_step_parameterized
}
    
; $0DCE5E-$0DCE61 JUMP LOCATION
AnimateEntrance_TurtleRock_step2:
{
    LDA.b #$14
    
    BRA AnimateEntrance_TurtleRock_step4_step_parameterized
}

; $0DCE62-$0DCE65 JUMP LOCATION
AnimateEntrance_TurtleRock_step3:
{
    LDA.b #$18
    
    BRA AnimateEntrance_TurtleRock_step4_step_parameterized
}

; $0DCE66-$0DCE89 JUMP LOCATION
AnimateEntrance_TurtleRock_step4:
{
    LDA.b #$1C
    
    ; $0DCE68 ALTERNATE ENTRY POINT
    .step_parameterized
    
    STA.w $1002
    STZ.w $1003
    
    REP #$30
    LDA.w #$FE47 : STA.w $1004
    LDA.w #$01E3 : STA.w $1006
    SEP #$20
    
    LDA.b #$FF : STA.w $1008
    
    INC.b $B0
    
    LDA.b #$01 : STA.b $14
    
    RTS
}

; $0DCE8A-$0DCEAB JUMP LOCATION
AnimateEntrance_TurtleRock_step5:
{
    REP #$20
    
    LDX.b #$0E
    
    LDA.w #$0000
    
    .loop
    
        STA.l $7EC5B0, X
        STA.l $7EC3D0, X
    DEX : DEX : BPL .loop
    
    LDA.b $E8 : STA.b $E6
    
    LDA.b $E2 : STA.b $E0
    
    SEP #$20
    
    INC.b $B0
    
    INC.b $15
    
    RTS
}

; $0DCEAC-$0DCEF7 JUMP LOCATION
AnimateEntrance_TurtleRock_step6:
{
    JSR.w OverworldEntrance_DrawManyTR
    
    LDA.b #$01 : STA.b $1D
    
    LDA.b #$02 : STA.b $99
    
    LDA.b #$22 : STA.b $9A
    
    REP #$30
    
    LDX.w #$0000
    
    .gamma
    
        LDA.w $1002, X : ORA.w #$0010 : STA.w $1002, X
        
        LDA.w $1006, X : CMP.w #$08AA : BNE .alpha
            LDA.w #$01E3 : STA.w $1006, X
        
        .alpha
        
        LDA.w $1008, X : CMP.w #$08AA : BNE .beta
            LDA.w #$01E3 : STA.w $1008, X
        
        .beta
        
        INX #8
    CPX.b $00 : BNE .gamma
    
    SEP #$30
    
    STZ.b $C8
    
    INC.b $B0
    
    RTS
}

; $0DCEF8-$0DCF16 JUMP LOCATION
AnimateEntrance_TurtleRock_step7:
{
    LDA.b $1A : LSR : BCS .exit
        LDA.b $C8 : AND.b #$07 : BNE .skip_SFX7
            JSL.l PaletteFilter_Restore
            
            LDA.b #$02 : STA.w $012F
        
        .skip_SFX7
        
        DEC.b $C8 : BNE .exit
            LDA.b #$30 : STA.b $C8
            
            INC.b $B0
    
    .exit
    
    RTS
}

; $0DCF17-$0DCF3F JUMP LOCATION
AnimateEntrance_TurtleRock_step8:
{
    LDA.b $1A : LSR : BCS .alpha
        LDA.b $C8 : AND.b #$07 : BNE .alpha
            LDA.b #$02 : STA.w $012F
    
    .alpha
    
    DEC.b $C8 : BNE AnimateEntrance_TurtleRock_step7_exit
        JSR.w OverworldEntrance_DrawManyTR
        
        STZ.b $1D
        
        LDA.b #$82 : STA.b $99
        
        LDA.b #$20 : STA.b $9A
        
        INC.b $B0
        
        LDA.b #$05 : STA.w $012D
        
        RTS
}

; ==============================================================================

; Pretty much puts a stop to any entrance animation.
; $0DCF40-$0DCF5F LOCAL JUMP LOCATION
OverworldEntrance_PlayJingle:
{
    ; Play the mystery sound that happens when you beat a puzzle.
    LDA.b #$1B : STA.w $012F
    
    STZ.w $04C6
    STZ.b $B0
    STZ.w $0710
    STZ.w $02E4
    
    STZ.w $0FC1
    
    STZ.w $011A
    STZ.w $011B
    STZ.w $011C
    STZ.w $011D
    
    RTS
}

; ==============================================================================

; $0DCF60-$0DCFBE JUMP LOCATION
OverworldEntrance_DrawManyTR:
{
    REP #$30
    
    LDX.w #$099E
    LDA.w #$0E78
    JSL.l Overworld_DrawPersistentTile16
    
    LDX.w #$09A0
    LDA.w #$0E79
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$0A1E
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$0A9E
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDX.w #$0B1E
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    JSR.w Overworld_AlterTileHardcore
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    TYA : CLC : ADC.w #$0010 : STA.b $00
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
                 STA.w $0710
    
    RTS
}

; ==============================================================================

; $0DCFBF-$0DCFD8 JUMP TABLE
Overworld_AnimateEntrance_GanonsTower_handlers:
{
    dw AnimateEntrance_GanonsTower_step01 ; 0x00 - $CFE0
    dw AnimateEntrance_GanonsTower_step01 ; 0x01 - $CFE0
    dw AnimateEntrance_GanonsTower_step02 ; 0x02 - $CFF1
    dw AnimateEntrance_GanonsTower_step03 ; 0x03 - $D01D
    dw AnimateEntrance_GanonsTower_step04 ; 0x04 - $D062
    dw AnimateEntrance_GanonsTower_step05 ; 0x05 - $D093
    dw AnimateEntrance_GanonsTower_step06 ; 0x06 - $D0DE
    dw AnimateEntrance_GanonsTower_step07 ; 0x07 - $D107
    dw AnimateEntrance_GanonsTower_step08 ; 0x08 - $D127
    dw AnimateEntrance_GanonsTower_step09 ; 0x09 - $D14D
    dw AnimateEntrance_GanonsTower_step10 ; 0x0A - $D16D
    dw AnimateEntrance_GanonsTower_step11 ; 0x0B - $D19F Place the last step
                                          ;        of Ganon's Tower.
    dw AnimateEntrance_GanonsTower_step12 ; 0x0C - $D1C0 Restore music, play
                                          ;        some SFX, and let Link move
                                          ;        again.
}

; $0DCFD9-$0DCFDF JUMP LOCATION
Overworld_AnimateEntrance_GanonsTower:
{
    LDA.b $B0 : ASL : TAX
    JMP.w (.handlers, X)
}

; $0DCFE0-$0DCFF0 JUMP LOCATION
AnimateEntrance_GanonsTower_step01:
{
    LDX.b $8A
    LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
    JSL.l HandleStakeField
    
    RTS
}

; $0DCFF1-$0DD00D JUMP LOCATION
AnimateEntrance_GanonsTower_step02:
{
    JSL.l HandleStakeField
    
    LDA.b $1D : BNE .BRANCH_BETA
        INC.b $1D
        
        INC.b $C8
        LDA.b $C8 : CMP.b #$03 : BNE .BRANCH_ALPHA
            STZ.b $C8
            
            LDA.b #$07 : STA.w $012D
            
            RTS
        
        .BRANCH_ALPHA
        
        STZ.b $B0
    
    .BRANCH_BETA
    
    RTS
}

; $0DD00E-$0DD01C LOCAL JUMP LOCATION
OverworldEntrance_AdvanceAndBoom:
{
    INC.b $B0
    
    STZ.b $C8
    
    LDA.b #$0C : STA.w $012E ; PLAY SFX
    LDA.b #$07 : STA.w $012F ; PLAY SFX IN CONJUNCTION WITH THE FIRST.
    
    RTS
}

; $0DD01D-$0DD061 LOCAL JUMP LOCATION
AnimateEntrance_GanonsTower_step03:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$30 : BNE .exit_a
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$045E
        LDA.w #$0E88
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0460
        LDA.w #$0E89
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$04DE
        LDA.w #$0EA2
        JSR.w Overworld_AlterTileHardcore
        JSR.w Overworld_AlterTileHardcore
        
        LDA.w #$0E8A
        
        ; $0DD04C ALTERNATE ENTRY POINT
        .draw_at_055E
        
        LDX.w #$055E
        
        ; $0DD04F ALTERNATE ENTRY POINT
        .draw2_advance
        
        JSR.w Overworld_AlterTileHardcore
        
        ; $0DD052 ALTERNATE ENTRY POINT
        .draw1_advance
        
        JSR.w Overworld_AlterTileHardcore
        
        LDA.w #$FFFF : STA.w $1012, Y
        
        SEP #$30
        
        LDA.b #$01 : STA.b $14
        
    ; $0DD061 ALTERNATE ENTRY POINT
    .exit_a
    
    RTS
}

; $0DD062-$0DD092 JUMP LOCATION
AnimateEntrance_GanonsTower_step04:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$30 : BNE AnimateEntrance_GanonsTower_step03_exit_a
        JSR.w OverworldEntrance_AdvanceAndBoom.
        
        REP #$30
        
        LDX.w #$045E
        LDA.w #$0E8C
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0460
        LDA.w #$0E8D
        JSR.w Overworld_AlterTileHardcore.
        
        LDX.w #$04DE
        LDA.w #$0E8E
        JSR.w Overworld_AlterTileHardcore.
        JSR.w Overworld_AlterTileHardcore.
        
        LDA.w #$0E90
        
        BRA AnimateEntrance_GanonsTower_step03_draw_at_055E
}

; $0DD093-$0DD0DD JUMP LOCATION
AnimateEntrance_GanonsTower_step05:
{
	INC.b $C8
	LDA.b $C8 : CMP.b #$34 : BNE .exit
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$045E
        LDA.w #$0E92
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0460
        LDA.w #$0E93
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$04DE
        LDA.w #$0E94
        JSR.w Overworld_AlterTileHardcore.
        
        LDA.w #$0E94
        JSR.w Overworld_AlterTileHardcore.
        
        LDX.w #$055E
        LDA.w #$0E95
        JSR.w Overworld_AlterTileHardcore.
        
        LDA.w #$0E95
        JSR.w Overworld_AlterTileHardcore.
        
        LDA.w #$FFFF : STA.w $1012, Y
        
        SEP #$30
        
        LDA.b #$01 : STA.b $14

    ; $0DD0DD ALTERNATE ENTRY POINT
    .exit

	RTS
}

; $0DD0DE-$0DD106 JUMP LOCATION
AnimateEntrance_GanonsTower_step06:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_GanonsTower_step05_exit
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$045E
        LDA.w #$0E9C
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0460
        LDA.w #$0E97
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$04DE
        LDA.w #$0E98
        JMP.w AnimateEntrance_GanonsTower_step03_draw2_advance
}

; $0DD107-$0DD126 JUMP LOCATION
AnimateEntrance_GanonsTower_step07:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_GanonsTower_step05_exit
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$04DE
        LDA.w #$0E9A
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$04E0
        LDA.w #$0E9B
        JMP.w AnimateEntrance_GanonsTower_step03_draw1_advance
}

; $0DD127-$0DD14C JUMP LOCATION
AnimateEntrance_GanonsTower_step08:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_GanonsTower_step05_exit
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$04DE
        LDA.w #$0E9C
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$04E0
        LDA.w #$0E9D
        JSR.w Overworld_AlterTileHardcore
        
        LDA.w #$0E9E
        JMP.w AnimateEntrance_GanonsTower_step03_draw1_advance
}

; $0DD14D-$0DD16C JUMP LOCATION
AnimateEntrance_GanonsTower_step09:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_GanonsTower_step05_exit
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$055E
        LDA.w #$0E9A
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0560
        LDA.w #$0E9B
        JMP.w AnimateEntrance_GanonsTower_step03_draw1_advance
}

; $0DD16D-$0DD19E JUMP LOCATION
AnimateEntrance_GanonsTower_step10:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_GanonsTower_step12_waitForTimer
        JSR.w OverworldEntrance_AdvanceAndBoom.
        
        REP #$30
        
        LDX.w #$055E
        LDA.w #$0E9C
        JSL.l Overworld_DrawPersistentTile16
        
        LDX.w #$0560
        LDA.w #$0E9D
        JSR.w Overworld_AlterTileHardcore
        
        LDX.w #$05DE
        LDA.w #$0EA0
        JSR.w Overworld_AlterTileHardcore.
        
        LDA.w #$0EA1

        ; $0DD199 ALTERNATE ENTRY POINT
        .draw1_at_05E0_advance

        LDX.w #$05E0
        JMP.w AnimateEntrance_GanonsTower_step03_draw1_advance
}

; $0DD19F-$0DD1BF JUMP LOCATION
AnimateEntrance_GanonsTower_step11:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$20 : BNE AnimateEntrance_GanonsTower_step12_waitForTimer
        LDA.b #$05 : STA.w $012D 
        
        JSR.w OverworldEntrance_AdvanceAndBoom
        
        REP #$30
        
        LDX.w #$05DE
        LDA.w #$0E9A
        JSL.l Overworld_DrawPersistentTile16
        
        LDA.w #$0E9B
        BRA .draw1_at_05E0_advance
}

; $0DD1C0-$0DD1D7 JUMP LOCATION
AnimateEntrance_GanonsTower_step12:
{
    INC.b $C8
    LDA.b $C8 : CMP.b #$48 : BNE .waitForTimer
        ; Play "you solved puzzle" sound.
        JSR.w OverworldEntrance_PlayJingle
        
        STZ.b $C8
        
        ; Restore music to DW Death Mountain music.
        LDA.b #$0D : STA.w $012C
        
        ; Rumble sound effect.
        LDA.b #$09 : STA.w $012D
    
    ; $0DD1D7 ALTERNATE ENTRY POINT
    .waitForTimer
    
    RTS
}

; ==============================================================================

; $0DD1D8-$0DD217 NULL
NULL_1BD1D8:
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

; ==============================================================================

; Main Palette Data
; $0DD218-$0DEBB3 DATA
PaletteData:
{
    ; Standard HEX #RRGGBB format shown above each of the 555 values.

    ; ===============================================================
    ; Main Sprite Palettes 1
    ; ===============================================================

    ; $0DD218
    .sprite
    .sprite_00
    dw          $7FFF,  $08D9,  $1E07,  $4ACA,  $14A5,  $133F,  $19DF

    ; $0DD226
    .sprite_00_right
    dw  $0000,  $7FFF,  $1979,  $14B6,  $39DC,  $14A5,  $66F7,  $45EF

    ; $0DD236
    .sprite_01
    dw          $7FFF,  $6949,  $62EC,  $6FF4,  $14A5,  $7F51,  $7E4F

    ; $0DD244
    .sprite_01_right
    dw  $0000,  $7FFF,  $5A1F,  $55AA,  $76B2,  $14A5,  $2ADF,  $1597

    ; $0DD254
    .sprite_02
    dw          $7FFF,  $1AF6,  $1596,  $369E,  $14A5,  $41FE,  $2517
    dw  $0000,  $14A5,  $14A5,  $14A5,  $14A5,  $14A5,  $14A5,  $14A5

    ; $0DD272
    .sprite_03
    dw          $7FFF,  $319B,  $1596,  $369E,  $14A5,  $7E56,  $65CA
    dw  $0000,  $7FFF,  $0CD9,  $1A49,  $3B53,  $14A5,  $1F5F,  $1237

    ; $0DD290
    .sprite_04
    dw          $7FFF,  $08D9,  $1A2F,  $32F5,  $14A5,  $133F,  $19DF
    dw  $0000,  $7FFF,  $1979,  $14B6,  $39DC,  $14A5,  $66F7,  $45EF

    ; $0DD2AE
    .sprite_05
    dw          $7FFF,  $2DC4,  $66CF,  $7FD5,  $14A5,  $5F50,  $468A
    dw  $0000,  $7FFF,  $5A1F,  $55AA,  $76B2,  $14A5,  $2ADF,  $1597

    ; $0DD2CC
    .sprite_06
    dw          $7FFF,  $0EFB,  $1596,  $369E,  $14A5,  $41FE,  $2517
    dw  $0000,  $14A5,  $14A5,  $14A5,  $14A5,  $14A5,  $14A5,  $14A5

    ; $0DD2EA
    .sprite_07
    dw          $7FFF,  $319B,  $1596,  $369E,  $14A5,  $7E56,  $65CA
    dw  $0000,  $7FFF,  $0CD9,  $1A49,  $3B53,  $14A5,  $1F5F,  $1237

    ; ===============================================================
    ; Link Palettes
    ; ===============================================================

    ; $0DD308
    .Link
    .link_00
    Palettes_GreenMail:
    dw          $7FFF,  $237E,  $11B7,  $369E,  $14A5,  $01FF,  $1078
    dw  $599D,  $3647,  $3B68,  $0A4A,  $12EF,  $2A5C,  $1571,  $7A18

    ; $0DD326
    .link_01
    Palettes_BlueMail:
    dw          $7FFF,  $237E,  $11B7,  $369E,  $14A5,  $01FF,  $1078
    dw  $599D,  $6980,  $7691,  $26B8,  $437F,  $2A5C,  $1199,  $7A18

    ; $0DD344
    .link_02
    Palettes_RedMail:
    dw          $7FFF,  $237E,  $11B7,  $369E,  $14A5,  $01FF,  $1078
    dw  $599D,  $1057,  $457E,  $6DF3,  $7EB9,  $2A5C,  $2227,  $7A18

    ; $0DD362
    .link_03
    Palettes_Bunny:
    dw          $7FFF,  $237E,  $11DA,  $369E,  $14A5,  $01FF,  $1078
    dw  $3D97,  $3647,  $3B68,  $0A4A,  $12EF,  $567E,  $1872,  $7A18

    ; $0DD380
    .link_04
    Palettes_Zap:
    dw          $0000,  $0EFA,  $7DD1,  $0000,  $7F1A,  $0000,  $7F1A
    dw  $716E,  $7DD1,  $40A7,  $7DD1,  $40A7,  $48E9,  $50CF,  $7FFF

    ; ===============================================================
    ; Main Sprite Palettes 2
    ; ===============================================================

    ; $0DD39E
    .spritePalette
    .spritePalette_00
    dw  $10C6,  $1214,  $3B3D,  $66DE,  $5219,  $42ED,  $2629

    ; $0DD3AC
    .spritePalette_01
    dw  $7FFF,  $0D66,  $2D58,  $463D,  $14A5,  $3290,  $1DEB

    ; $0DD3BA
    .spritePalette_02
    dw  $25F1,  $0D09,  $512A,  $7251,  $14A5,  $21CF,  $194B

    ; $0DD3C8
    .spritePalette_03
    dw  $3676,  $04EA,  $12A0,  $2F80,  $14A5,  $21D1,  $114D

    ; $0DD3D6
    .spritePalette_04
    dw  $7FFF,  $4FF3,  $1175,  $369E,  $14A5,  $0DFF,  $00F9

    ; $0DD3E4
    .spritePalette_05
    dw  $7FFF,  $273A,  $1175,  $369E,  $14A5,  $132F,  $0669

    ; $0DD3F2
    .spritePalette_06
    dw  $7FFF,  $314A,  $4A2F,  $570F,  $14A5,  $57AF,  $30EA

    ; $0DD400
    .spritePalette_07
    dw  $7FFF,  $191B,  $16AC,  $3BD5,  $14A5,  $267E,  $0D98

    ; $0DD40E
    .spritePalette_08
    dw  $7FFF,  $1D2C,  $4DAD,  $4DAD,  $14A5,  $2A14,  $1D91

    ; $0DD41C
    .spritePalette_09
    dw  $7FFF,  $2185,  $2D58,  $463D,  $14A5,  $428D,  $3209

    ; $0DD42A
    .spritePalette_0A
    dw  $7FFF,  $5294,  $44C7,  $61AE,  $14A5,  $1A3B,  $1175

    ; $0DD438
    .spritePalette_0B
    dw  $377F,  $54E9,  $165F,  $1016,  $2C43,  $6B18,  $61EF

    ; ===============================================================
    ; Environment Palettes
    ; ===============================================================

    ; $0DD446
    .environment
    .environment_00
    dw  $14C4,  $2D6B,  $612E,  $5DB4,  $7AD9,  $77BD,  $5294

    ; $0DD454
    .environment_01
    dw  $14C4,  $2D6B,  $4DE8,  $66AE,  $7F74,  $77BD,  $5294

    ; $0DD462
    .environment_02
    dw  $14C4,  $2D6B,  $011F,  $01FF,  $03DF,  $77BD,  $5294

    ; $0DD470
    .environment_03
    dw  $7FFF,  $0000,  $0000,  $0000,  $7810,  $7F7F,  $7C17

    ; $0DD47E
    .environment_04
    dw  $7FFF,  $0000,  $5907,  $6E0E,  $0000,  $7FBB,  $7672

    ; $0DD48C
    .environment_05
    dw  $7FFF,  $5F9F,  $000A,  $7E15,  $2C24,  $75D0,  $612B

    ; $0DD49A
    .environment_06
    dw  $14A5,  $3A0A,  $1DE5,  $2669,  $3234,  $5FB6,  $4AEF

    ; $0DD4A8
    .environment_07
    dw  $14A5,  $14A5,  $158D,  $2211,  $3234,  $4AEF,  $3A0A

    ; $0DD4B6
    .environment_08
    dw  $08C4,  $21C9,  $4DB1,  $72D3,  $12B7,  $4F34,  $366E

    ; $0DD4C4
    .environment_09
    dw  $0C63,  $08C4,  $196E,  $29F2,  $29F2,  $366E,  $21C9

    ; $0DD4D2
    .environment_0A
    dw  $18C6,  $2D6B,  $29F5,  $1ABA,  $252F,  $77BD,  $5294

    ; ===============================================================
    ; AUX Sprite Palettes
    ; ===============================================================

    ; $0DD4E0
    .spriteAux
    .spriteAux_00
    dw  $7FFF,  $7B14,  $5C92,  $791A,  $14A5,  $02BF,  $11BD

    ; $0DD4EE
    .spriteAux_01
    dw  $7FFF,  $32DB,  $00B6,  $263E,  $14A5,  $5694,  $39AD

    ; $0DD4FC
    .spriteAux_02
    dw  $7FFF,  $0551,  $5D8D,  $7272,  $14A5,  $0EFD,  $0DF6

    ; $0DD50A
    .spriteAux_03
    dw  $7FFF,  $237E,  $1175,  $369E,  $14A5,  $1B71,  $1E60

    ; $0DD518
    .spriteAux_04
    dw  $7FFF,  $209A,  $0DB4,  $2AFB,  $14A5,  $036F,  $026B

    ; $0DD526
    .spriteAux_05
    dw  $7FFF,  $0975,  $34D2,  $51B9,  $14A5,  $2EDF,  $11FC

    ; $0DD534
    .spriteAux_06
    dw  $77BD,  $08FC,  $09D4,  $12DC,  $14A5,  $4ED8,  $29D1

    ; $0DD542
    .spriteAux_07
    dw  $7FFF,  $1966,  $0D9C,  $02BB,  $14A5,  $4B0A,  $2E28

    ; $0DD550
    .spriteAux_08
    dw  $7FFF,  $0CEA,  $0EF9,  $0F5F,  $14A5,  $0E75,  $0DB0

    ; $0DD55E
    .spriteAux_09
    dw  $7FFF,  $5A3C,  $626E,  $7F34,  $0000,  $7F3F,  $6E9E

    ; $0DD56C
    .spriteAux_0A
    dw  $7FFF,  $08D9,  $1175,  $369E,  $14A5,  $231A,  $0E33

    ; $0DD57A
    .spriteAux_0B
    dw  $7FFF,  $0914,  $1665,  $5F6E,  $14A5,  $267F,  $15B9

    ; $0DD588
    .spriteAux_0C
    dw  $7FFF,  $5929,  $117B,  $22BF,  $14A5,  $7EB5,  $75CF

    ; $0DD596
    .spriteAux_0D
    dw  $7FFF,  $4547,  $0591,  $1698,  $14A5,  $5331,  $562A

    ; $0DD5A4
    .spriteAux_0E
    dw  $7FFF,  $4118,  $1636,  $3B1D,  $14A5,  $1F52,  $120D

    ; $0DD5B2
    .spriteAux_0F
    dw  $7FFF,  $369B,  $228B,  $3F72,  $14A5,  $35BC,  $2115

    ; $0DD5CE
    .spriteAux_10
    dw  $7FFF,  $1414,  $0F40,  $231F,  $14A5,  $123D,  $14FA

    ; $0DD5CE
    .spriteAux_11
    dw  $7FFF,  $5E5F,  $0972,  $2638,  $14A5,  $7636,  $512F

    ; $0DD5DC
    .spriteAux_12
    dw  $7E35,  $187B,  $1175,  $369E,  $14A5,  $7FFF,  $7E35

    ; $0DD5EA
    .spriteAux_13
    dw  $7FFF,  $5A94,  $08D7,  $219D,  $14A5,  $1698,  $0591

    ; $0DD5F8
    .spriteAux_14
    dw  $7FFF,  $0CD2,  $017B,  $16BF,  $14A5,  $361D,  $1D16

    ; $0DD606
    .spriteAux_15
    dw  $4E73,  $34E4,  $0532,  $0DF8,  $0000,  $04D7,  $45C6

    ; $0DD614
    .spriteAux_16
    dw  $7FFF,  $366E,  $15F4,  $231C,  $14A5,  $4F34,  $5FB8

    ; $0DD622
    .spriteAux_17
    dw  $294A,  $77BD,  $6318,  $4631,  $77BD,  $4631,  $6318

    ; ===============================================================
    ; Sword Palettes
    ; ===============================================================

    ; $0DD630
    .sword
    .sword_00 ; No sword and fighter sword
    dw  $7FFF,  $27FF,  $5E2D

    ; $0DD636
    .sword_01 ; Fighter sword
    dw  $7E4E,  $6FF4,  $1CF5

    ; $0DD63C
    .sword_02 ; Tempered sword
    dw  $093B,  $169F,  $7E8D

    ; $0DD642
    .sword_03 ; Golden sword
    dw  $033F,  $67FF,  $2640

    ; ===============================================================
    ; Shield Palettes
    ; ===============================================================

    ; $0DD648
    .shield
    .shield_00
    dw  $7FFF,  $1CE7,  $7A10,  $64A5

    ; $0DD650
    .shield_01
    dw  $4F5F,  $1CE7,  $2E9C,  $14B6

    ; $0DD658
    .shield_02
    dw  $7399,  $1CE7,  $02F9,  $0233

    ; ===============================================================
    ; HUD Palettes
    ; ===============================================================

    ; $0DD660
    .hud
    .hud_00
    dw  $0000,  $0198,  $56B5,  $0000

    ; $0DD668
    .hud_01
    dw  $0000,  $0018,  $7FFF,  $0000

    ; $0DD670
    .hud_02
    dw  $0000,  $02BC,  $7FFF,  $0000

    ; $0DD678
    .hud_03
    dw  $0000,  $69C9,  $7FFF,  $0000

    ; $0DD680
    .hud_04
    dw  $0000,  $18C6,  $39AD,  $0000

    ; $0DD688
    .hud_05
    dw  $0000,  $00B8,  $433D,  $0000

    ; $0DD690
    .hud_06
    dw  $0000,  $3800,  $7FFF,  $0018

    ; $0DD698
    .hud_07
    dw  $0000,  $1704,  $7FFF,  $0000

    ; $0DD6A0
    .hud_08
    dw  $0000,  $216F,  $2E59,  $14C8

    ; $0DD6A8
    .hud_09
    dw  $0000,  $0018,  $7FFF,  $0000

    ; $0DD6B0
    .hud_0A
    dw  $0000,  $0000,  $2FE5,  $0000

    ; $0DD6B8
    .hud_0B
    dw  $0000,  $0000,  $1F1F,  $0000

    ; $0DD6C0
    .hud_0C
    dw  $0000,  $3ED8,  $2E54,  $27BD

    ; $0DD6C8
    .hud_0D
    dw  $0000,  $3ED8,  $2E54,  $1DD0

    ; $0DD6D0
    .hud_0E
    dw  $0000,  $3800,  $1D5E,  $0000

    ; $0DD6D8
    .hud_0F
    dw  $0000,  $0000,  $7FFF,  $0000

    ; ===============================================================
    ; Unused Palettes
    ; ===============================================================

    ; $0DD6E0
    .sword_04
    dw  $033F,  $67FF,  $2640

    ; $0DD6E6
    dw  $7599,  $7599,  $7599,  $7599

    ; $0DD6EE
    .unused_00
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; ===============================================================
    ; Dungeon Map Sprite Palettes
    ; ===============================================================

    ; $0DD70A
    .dungeonMapSprites_00
    dw  $7FFF,  $0019,  $7FFF,  $7FFF,  $14A5,  $0000,  $0000
    dw  $7FFF,  $17FF,  $7F52,  $216E,  $14A5,  $0000,  $0000
    dw  $7DD3,  $7F8E,  $66AD,  $2CF7,  $14A5,  $7ED8,  $0000

    ; ===============================================================
    ; Dungeon Palettes
    ; ===============================================================

    ; $0DD734
    .dungeon_00
    dw          $0CC6,  $152B,  $19D0,  $3675,  $535D,  $1CEE,  $1089
    dw  $7FFF,  $0CC6,  $152B,  $19D0,  $3675,  $535D,  $1CEE,  $1089
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $0C84,  $3168,  $3DCB,  $460D,  $28E7,  $19D0,  $1CEE
    dw          $0CC6,  $152B,  $1A33,  $3B19,  $14AC,  $4DC7,  $4546
    dw  $7FFF,  $0C84,  $2925,  $3166,  $39A8,  $7D6B,  $152B,  $1089
    dw          $10C6,  $216E,  $21F3,  $3ADC,  $18CD,  $66DE,  $59D9
    dw  $7FFF,  $0CA5,  $2D29,  $2D71,  $35B3,  $28E7,  $19D0,  $1CEE
    dw          $1463,  $2110,  $35B8,  $739C,  $4108,  $16DB,  $61AD
    dw  $7FFF,  $0CA5,  $2D29,  $210E,  $2950,  $28E7,  $314A,  $7D6B
    dw          $0CC6,  $152B,  $19D0,  $3675,  $535D,  $152B,  $7D6B
    dw  $7FFF,  $0CA5,  $150A,  $0000,  $0000,  $18CD,  $3675,  $19D0

    ; $0DD7E8
    .dungeon_01
    dw          $1463,  $2CC7,  $3D2A,  $49AE,  $6274,  $1CEC,  $1089
    dw  $7FFF,  $1463,  $2CC7,  $3D2A,  $49AE,  $6274,  $1D2D,  $10CA
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $1463,  $2D26,  $3989,  $3DCB,  $2D26,  $3D2A,  $1D2D
    dw          $1463,  $2CC7,  $3D2A,  $49AE,  $6274,  $1CEC,  $1089
    dw  $7FFF,  $1463,  $24E4,  $2905,  $3147,  $24E4,  $2CC7,  $10CA
    dw          $18C6,  $1D0B,  $2590,  $21F4,  $14C8,  $1CEC,  $1089
    dw  $7FFF,  $0C86,  $10C8,  $190A,  $214C,  $3635,  $4B1C,  $6FBF
    dw          $18C6,  $2110,  $35B8,  $739C,  $4108,  $16DB,  $61AD
    dw  $7FFF,  $1463,  $24E4,  $2D26,  $3989,  $3989,  $4E73,  $5EF7
    dw          $1463,  $6507,  $6949,  $7F51,  $44E7,  $5D69,  $7E4F
    dw  $7FFF,  $1063,  $28C7,  $24E4,  $15A5,  $15A5,  $49AE,  $3D2A

    ; $0DD89C
    .dungeon_02
    dw          $14A7,  $214F,  $21B3,  $3215,  $3EBA,  $56F8,  $250F
    dw  $7FFF,  $14A7,  $214F,  $21B3,  $3215,  $3EBA,  $56F8,  $1CEC
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $14A7,  $3168,  $3DCB,  $460D,  $3168,  $2193,  $1CEC
    dw          $14A7,  $214F,  $21B3,  $3258,  $64C8,  $7DAF,  $7FFF
    dw  $7FFF,  $0CA5,  $192D,  $216F,  $29B1,  $192D,  $214F,  $18CA
    dw          $14E9,  $21B1,  $3657,  $3A9A,  $03AB,  $56D9,  $4A77
    dw  $7FFF,  $0CA5,  $192D,  $216F,  $29B1,  $192D,  $2193,  $1CEC
    dw          $18C6,  $2110,  $35B8,  $739C,  $3D08,  $1ABA,  $5DCE
    dw  $7FFF,  $0CA5,  $2504,  $3166,  $39A8,  $7FFF,  $214F,  $18CA
    dw          $14A7,  $0673,  $21AD,  $21EF,  $7FFF,  $7FFF,  $7FFF
    dw  $7FFF,  $0CA5,  $0885,  $14E8,  $2984,  $2984,  $14A7,  $14A7

    ; $0DD950
    .dungeon_03
    dw          $14A5,  $1946,  $25C8,  $3AB0,  $5359,  $418C,  $3529
    dw  $7FFF,  $14A5,  $1946,  $25C8,  $3AB0,  $5359,  $3D28,  $28E7
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $0C63,  $3128,  $394A,  $418C,  $2CE6,  $29C8,  $3D28
    dw          $14A5,  $1946,  $25C8,  $3AB0,  $5359,  $2A9C,  $2955
    dw  $7FFF,  $0C63,  $2CC6,  $2CE7,  $3529,  $28C5,  $1D24,  $28E7
    dw          $1505,  $2168,  $2DCB,  $3E4F,  $4B5D,  $3699,  $25F5
    dw  $7FFF,  $14A5,  $2108,  $294A,  $318C,  $4E73,  $6B5A,  $7FFF
    dw          $18C6,  $2110,  $35B8,  $739C,  $3D08,  $1ABA,  $5DCE
    dw  $7FFF,  $1084,  $1CA7,  $24C9,  $2D0B,  $394A,  $5294,  $739C
    dw          $14A5,  $4568,  $59ED,  $6650,  $2985,  $3A48,  $532B
    dw  $7FFF,  $14A5,  $1525,  $0000,  $1CED,  $1CED,  $3AB0,  $25C8

    ; $0DDA04
    .dungeon_04
    dw          $24A4,  $5925,  $6A4B,  $7795,  $7FFB,  $5DCE,  $558C
    dw  $7FFF,  $24A4,  $5925,  $6A4B,  $7795,  $7FFB,  $5DEE,  $4D6A
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $24A4,  $4D6A,  $55AC,  $5DEE,  $4D25,  $5DEE,  $51A8
    dw          $24A4,  $5925,  $6A4B,  $77BB,  $117B,  $75CF,  $7EB5
    dw  $7FFF,  $24A4,  $4D6A,  $55AC,  $5DEE,  $3D47,  $5DEE,  $51A8
    dw          $24A4,  $78A9,  $7DD0,  $76CB,  $7FFA,  $64A9,  $55AC
    dw  $7FFF,  $34C8,  $4D6A,  $55AC,  $5DEE,  $6AB3,  $7B58,  $7FFF
    dw          $1463,  $2910,  $3DB8,  $739C,  $614A,  $1ABA,  $7E31
    dw  $7FFF,  $24A4,  $5D8B,  $4D28,  $4106,  $5B09,  $5294,  $739C
    dw          $24A4,  $4988,  $5EE4,  $7367,  $44E7,  $5D69,  $7E4F
    dw  $7FFF,  $2084,  $5505,  $0000,  $0000,  $5D8B,  $7795,  $7FF9

    ; $0DDAB8
    .dungeon_05
    dw          $0CA5,  $10EA,  $194D,  $29F3,  $3EB6,  $2DCB,  $2589
    dw  $7FFF,  $0CA5,  $10EA,  $194D,  $29F3,  $3EB6,  $2168,  $1906
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $0C63,  $2168,  $29AA,  $29AD,  $2190,  $194D,  $2168
    dw          $0CA5,  $10EA,  $194D,  $29F3,  $3EB6,  $2ACC,  $15E5
    dw  $7FFF,  $0C63,  $1926,  $2167,  $216B,  $1905,  $10EA,  $1906
    dw          $0CA5,  $10EA,  $194D,  $29F3,  $3EB6,  $29AD,  $29AA
    dw  $7FFF,  $10E7,  $154A,  $1DAD,  $2A10,  $42F7,  $5FBD,  $7FFF
    dw          $18C6,  $2110,  $35B8,  $739C,  $4108,  $1ABA,  $61AD
    dw  $7FFF,  $0C63,  $15AE,  $1DF0,  $15AE,  $29AA,  $5294,  $739C
    dw          $24C6,  $4526,  $6167,  $65C9,  $4547,  $59C8,  $6A8C
    dw  $7FFF,  $0CA5,  $10EA,  $0000,  $1DEC,  $1DEC,  $29F3,  $194D

    ; $0DDB6C
    .dungeon_06
    dw          $1084,  $18CA,  $252E,  $39D3,  $529A,  $418C,  $3529
    dw  $7FFF,  $1084,  $18CA,  $252E,  $39F3,  $52BA,  $2D29,  $24E7
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $0C63,  $3529,  $394A,  $418C,  $3108,  $252E,  $2D29
    dw          $1084,  $18CA,  $252E,  $39D3,  $52BA,  $1E5A,  $1CF5
    dw  $7FFF,  $0C63,  $28C6,  $2CE7,  $3129,  $28C6,  $18CA,  $24E7
    dw          $1084,  $18CA,  $252E,  $39D3,  $52BA,  $3D6B,  $3529
    dw  $7FFF,  $1CE4,  $2545,  $2D86,  $35C7,  $5A2F,  $7738,  $7FFF
    dw          $1084,  $2110,  $35B8,  $739C,  $4108,  $16DB,  $5D8C
    dw  $7FFF,  $1084,  $14C9,  $14CC,  $190D,  $3529,  $5294,  $739C
    dw          $28A5,  $3128,  $396A,  $41AC,  $40E7,  $5D69,  $720E
    dw  $7FFF,  $0C64,  $14A9,  $0000,  $1CEB,  $1CEB,  $39F3,  $212F

    ; $0DDC20
    .dungeon_07
    dw          $1085,  $10C8,  $18EB,  $1D91,  $2E35,  $254F,  $210C
    dw  $7FFF,  $1085,  $10C9,  $192D,  $1D91,  $2E35,  $4209,  $3187
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $1085,  $14C9,  $18EB,  $212E,  $10C8,  $216E,  $190B
    dw          $18C6,  $1984,  $2646,  $3B69,  $19FF,  $18D5,  $10A9
    dw  $7FFF,  $1085,  $1088,  $10A9,  $14CB,  $1086,  $192C,  $10C8
    dw          $1085,  $216E,  $21F3,  $42B7,  $65AA,  $190B,  $18EB
    dw  $7FFF,  $1085,  $14C9,  $18EB,  $212E,  $2DB2,  $4298,  $67BF
    dw          $1084,  $2110,  $35B8,  $739C,  $4126,  $16DB,  $61CB
    dw  $7FFF,  $0C63,  $110D,  $1D91,  $2E35,  $212D,  $5294,  $739C
    dw          $1463,  $58E6,  $6149,  $658B,  $44E7,  $5D69,  $7A2E
    dw  $7FFF,  $1085,  $10C9,  $0000,  $0000,  $35A5,  $1085,  $1085

    ; $0DDCD4
    .dungeon_08
    dw          $0C63,  $2108,  $35AD,  $4A52,  $6739,  $31CC,  $298A
    dw  $7FFF,  $0C63,  $2108,  $35AD,  $4A52,  $6739,  $2569,  $1D27
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $1084,  $2148,  $298A,  $31AC,  $2148,  $35AD,  $2569
    dw          $0C63,  $2108,  $35AD,  $4A52,  $6739,  $1AD7,  $19AE
    dw  $0000,  $1084,  $1906,  $1D27,  $2569,  $1906,  $2108,  $1D27
    dw          $0C63,  $2D6B,  $5294,  $739C,  $2E26,  $4F8A,  $3AA6
    dw  $7FFF,  $10C7,  $1109,  $1D8D,  $29F0,  $42F8,  $5F9D,  $7FFF
    dw          $18C6,  $2110,  $35B8,  $739C,  $4108,  $1ABA,  $61AD
    dw  $7FFF,  $1084,  $10E9,  $152B,  $1D6D,  $298A,  $5294,  $739C
    dw          $1084,  $2148,  $31CC,  $3677,  $44E7,  $5D69,  $7E4F
    dw  $7FFF,  $0C63,  $1CE7,  $0000,  $0000,  $1DCC,  $4A52,  $35AD

    ; $0DDD88
    .dungeon_09
    dw          $1084,  $18E6,  $194C,  $29F2,  $46D8,  $298C,  $114A
    dw  $7FFF,  $1084,  $18E6,  $194C,  $29F2,  $46D8,  $14AA,  $1086
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $1463,  $1148,  $114A,  $298C,  $1945,  $258A,  $14AA
    dw          $1084,  $18E6,  $194C,  $29F2,  $46D8,  $298C,  $14AA
    dw  $7FFF,  $1463,  $1087,  $14A8,  $1508,  $7FFF,  $1D07,  $1086
    dw          $1084,  $18E6,  $194C,  $29F2,  $46D8,  $298C,  $14AA
    dw  $7FFF,  $20C6,  $3108,  $416B,  $51CE,  $6252,  $7F39,  $7FFF
    dw          $1463,  $2110,  $35B8,  $739C,  $4108,  $16DB,  $61AD
    dw  $7FFF,  $1084,  $3924,  $4986,  $5A0B,  $114A,  $4631,  $5AD6
    dw          $1463,  $7F51,  $6949,  $6507,  $44E7,  $5D69,  $7E4F
    dw  $7FFF,  $1463,  $2CC7,  $2108,  $7FFF,  $18CD,  $29F2,  $216D

    ; $0DDE3C
    .dungeon_0A
    dw          $1084,  $2508,  $314A,  $45EF,  $66F7,  $3188,  $1986
    dw  $7FFF,  $1084,  $2508,  $314A,  $45EF,  $66F7,  $1D87,  $1926
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $1084,  $1525,  $1986,  $3188,  $198D,  $314A,  $1D87
    dw          $1084,  $2508,  $314A,  $45EF,  $66F7,  $3188,  $1986
    dw  $7FFF,  $1084,  $10A7,  $14C8,  $18E9,  $10A6,  $2508,  $1926
    dw          $1084,  $190A,  $214C,  $298E,  $6B18,  $3188,  $1986
    dw  $7FFF,  $10E9,  $192A,  $216C,  $29AE,  $3634,  $571A,  $6FBF
    dw          $18C6,  $2110,  $35B8,  $739C,  $4108,  $16DB,  $61AD
    dw  $7FFF,  $1084,  $1525,  $1986,  $3188,  $1986,  $5294,  $739C
    dw          $1463,  $6507,  $6949,  $7F51,  $44E7,  $5D69,  $7E4F
    dw  $7FFF,  $0C63,  $14A5,  $18C6,  $198D,  $198D,  $45EF,  $294A

    ; $0DDEF0
    .dungeon_0B
    dw          $0C63,  $1945,  $1DE6,  $3AD0,  $5777,  $426A,  $3608
    dw  $7FFF,  $0C63,  $1945,  $1DE6,  $3AD0,  $5777,  $1DAF,  $114B
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $0C63,  $29A7,  $3608,  $426A,  $2565,  $19E6,  $1DAF
    dw          $0C63,  $1945,  $1DE6,  $3AD0,  $29A7,  $3608,  $426A
    dw  $7FFF,  $0C63,  $2545,  $2985,  $2DC7,  $2545,  $1545,  $114B
    dw          $14A5,  $1966,  $2EEB,  $4B0A,  $7FFF,  $25B1,  $1CED
    dw  $7FFF,  $14E9,  $152B,  $1D6D,  $29D0,  $3633,  $46B7,  $6FBF
    dw          $1463,  $2110,  $35B8,  $739C,  $4108,  $16DB,  $61AD
    dw  $7FFF,  $0C63,  $10A7,  $14EA,  $1D2B,  $2DC7,  $5294,  $739C
    dw          $18C6,  $7000,  $7C84,  $7CA5,  $3543,  $41A3,  $5243
    dw  $7FFF,  $0C42,  $1525,  $0000,  $0000,  $1DD0,  $3AD0,  $256D

    ; $0DDFA4
    .dungeon_0C
    dw          $1085,  $10C9,  $192D,  $1D91,  $2E35,  $254F,  $210C
    dw  $7FFF,  $1085,  $10C9,  $192D,  $1D91,  $2E35,  $4209,  $3187
    dw          $18C6,  $2D6B,  $5294,  $77BD,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $1085,  $14C9,  $18EB,  $212E,  $10C8,  $216E,  $190B
    dw          $7FFF,  $3673,  $3718,  $37BD,  $14A5,  $3529,  $35CE
    dw  $7FFF,  $1085,  $1088,  $10A9,  $14CB,  $1086,  $192C,  $10C8
    dw          $1463,  $1508,  $196B,  $3252,  $5318,  $190C,  $18EB
    dw  $7FFF,  $1085,  $14C9,  $18EB,  $212E,  $2DB2,  $4298,  $67BF
    dw          $1084,  $2110,  $35B8,  $739C,  $3528,  $16DB,  $59AC
    dw  $7FFF,  $0C63,  $110D,  $1D91,  $2E35,  $212D,  $5294,  $739C
    dw          $14A5,  $0C72,  $109C,  $11FF,  $4D27,  $61EC,  $7E4E
    dw  $7FFF,  $1085,  $10C9,  $0000,  $19CE,  $35A5,  $1085,  $1085

    ; $0DE058
    .dungeon_0D
    dw          $0C63,  $24CB,  $296F,  $3634,  $4AF9,  $39AD,  $316B
    dw  $7FFF,  $0C63,  $24CB,  $296F,  $3634,  $4AF9,  $3187,  $2525
    dw          $18C6,  $2D6B,  $5294,  $739C,  $252F,  $1ABA,  $29F5
    dw  $7FFF,  $0C63,  $2D4A,  $316B,  $39AD,  $14AA,  $296F,  $3187
    dw          $0C63,  $24CB,  $296F,  $3634,  $4AF9,  $16A6,  $15C5
    dw  $0000,  $0C63,  $20E7,  $2508,  $2929,  $20C6,  $24CB,  $2525
    dw          $0C63,  $24CB,  $296F,  $3634,  $4AF9,  $25F1,  $1DAF
    dw  $7FFF,  $1088,  $14AA,  $18CD,  $2533,  $463A,  $6B5D,  $7FFF
    dw          $18C6,  $2110,  $35B8,  $739C,  $3D28,  $1ABA,  $5DCE
    dw  $7FFF,  $1088,  $14AA,  $18CD,  $2533,  $18CD,  $2533,  $0000
    dw          $14A5,  $3505,  $51C6,  $5A69,  $4AF9,  $24CB,  $0000
    dw  $7FFF,  $0C63,  $24CA,  $0000,  $0000,  $34E7,  $3634,  $3E75

    ; $0DE10C
    .dungeon_0E
    dw          $0C63,  $14C9,  $218D,  $3E73,  $5739,  $114E,  $11CE
    dw  $7FFF,  $0C63,  $14C9,  $218D,  $3E73,  $5739,  $114E,  $11CE
    dw          $14C4,  $2D6B,  $5294,  $77BD,  $2532,  $16DB,  $25F9
    dw  $7FFF,  $0C63,  $14E9,  $190C,  $1D2D,  $14E9,  $112B,  $10C9
    dw          $0C63,  $18CA,  $11D0,  $1683,  $16BF,  $7D4D,  $0C7B
    dw  $7FFF,  $0C63,  $10C6,  $14E8,  $1909,  $10C6,  $112B,  $10C9
    dw          $0C63,  $1CAA,  $1130,  $2A13,  $108D,  $7FFF,  $24EC
    dw  $7FFF,  $0C63,  $108D,  $2953,  $4218,  $631F,  $112B,  $10C9
    dw          $1084,  $1CF5,  $35BB,  $739C,  $3529,  $16DB,  $59AD
    dw  $7FFF,  $0C63,  $10C6,  $14E8,  $1909,  $190C,  $5294,  $739C
    dw          $0C63,  $1110,  $19F7,  $26FD,  $7D29,  $18DB,  $1683
    dw  $7FFF,  $0C63,  $14C9,  $0000,  $108D,  $108D,  $1104,  $1104

    ; $0DE1C0
    .dungeon_0F
    dw          $1084,  $24EA,  $252F,  $39D3,  $4E7A,  $3ED6,  $156B
    dw  $7FFF,  $1084,  $24EA,  $252F,  $39D3,  $4E7A,  $3ED6,  $156B
    dw          $14C4,  $2D6B,  $5294,  $77BD,  $2532,  $16DB,  $25F9
    dw  $7FFF,  $1084,  $210C,  $252E,  $2950,  $1986,  $2D92,  $156B
    dw          $1084,  $24EA,  $252F,  $39D3,  $7F9C,  $7D8C,  $64A5
    dw  $7FFF,  $2084,  $3908,  $3D4A,  $458C,  $1986,  $2D92,  $156B
    dw          $1084,  $1D2C,  $21F0,  $3274,  $1CFB,  $7F9C,  $4D29
    dw  $7FFF,  $1084,  $6DA0,  $7F60,  $3274,  $7FFF,  $3DFF,  $1CFB
    dw          $1084,  $1275,  $4929,  $739C,  $1505,  $3DFF,  $1CFB
    dw  $7FFF,  $1084,  $28C9,  $310B,  $354C,  $1986,  $2D92,  $156B
    dw          $1084,  $2D91,  $290B,  $229B,  $11A8,  $1CFB,  $0853
    dw  $7FFF,  $1084,  $3589,  $0120,  $1DA7,  $1986,  $0CC3,  $0CC3

    ; $0DE274
    .dungeon_10
    dw          $0CA5,  $10E9,  $1D6E,  $2E54,  $433B,  $46B1,  $320C
    dw  $7FFF,  $0CA5,  $10EB,  $1D6E,  $2E54,  $3F39,  $1D47,  $14C5
    dw          $14C4,  $2D6B,  $5294,  $77BD,  $2532,  $16DB,  $25F9
    dw  $7FFF,  $1084,  $2D08,  $354A,  $398C,  $7FFF,  $1D6E,  $1D47
    dw          $0CA5,  $10E9,  $1D6E,  $2E54,  $433B,  $1E59,  $1555
    dw  $7FFF,  $0C63,  $1D2C,  $1D91,  $21D2,  $24E5,  $110B,  $14C5
    dw          $0CA5,  $1926,  $29CA,  $4290,  $5B5A,  $2E54,  $1D6E
    dw  $7FFF,  $10E7,  $10EB,  $1D6E,  $2E54,  $42F7,  $5FBD,  $7FFF
    dw          $1084,  $1CF5,  $35BB,  $739C,  $3529,  $16DB,  $59AD
    dw  $7FFF,  $0C63,  $24A5,  $28C6,  $28C6,  $2D08,  $5294,  $739C
    dw          $1084,  $210D,  $3191,  $4E78,  $77DF,  $1D6E,  $2E54
    dw  $7FFF,  $0C84,  $10CA,  $0000,  $0000,  $1CF1,  $2E54,  $2E11

    ; $0DE328
    .dungeon_11
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE

    ; $0DE3DC
    .dungeon_12
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw  $0000,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE,  $77DE
    dw          $14A5,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $14A5,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw          $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F

    ; $0DE490
    .dungeon_13
    dw          $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $14A5,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw          $14A5,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw          $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $14A5,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw          $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw          $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw          $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F
    dw  $0000,  $0000,  $380E,  $6018,  $7C1F,  $7DBF,  $7E7F,  $7F3F

    ; ===============================================================
    ; Palace Map BG palettes
    ; ===============================================================

    ; $0DE544
    .dungeonmap_bg_00
    dw  $0000,  $71E7,  $71E7,  $71E7,  $71E7,  $71E7,  $7EB5,  $1CE7
    dw  $0000,  $7FFF,  $02BD,  $4E2D,  $66F3,  $7F99,  $4E2D,  $7F99
    dw  $0000,  $34E0,  $34E0,  $34E0,  $34E0,  $34E0,  $7EB5,  $1CE7
    dw  $0000,  $7FFF,  $4D67,  $01FE,  $02BD,  $3F7E,  $66F3,  $7F99
    dw  $0000,  $71E7,  $3B5F,  $71E7,  $71E7,  $71E7,  $7EB5,  $1CE7
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000
    dw  $0000,  $71E7,  $71E7,  $2DFF,  $3B5F,  $71E7,  $7EB5,  $1CE7
    dw  $0000,  $7FFF,  $4D67,  $4E2D,  $66F3,  $7F99,  $02BD,  $3F7E
    dw  $0000,  $0069,  $04AB,  $0D0E,  $1552,  $1DB4,  $2614,  $2A55
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000
    dw  $0000,  $38C0,  $4102,  $4944,  $5186,  $59C8,  $620A,  $6A4C
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; ===============================================================
    ; Overworld Auxiliary 3 palettes
    ; ===============================================================

    ; $0DE604
    .owanim_00
    dw  $190A,  $3549,  $45EC,  $6E50,  $258D,  $3A32,  $5F3A

    ; $0DE612
    .owanim_01
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE620
    .owanim_02
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE62E
    .owanim_03
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE63C
    .owanim_04
    dw  $1084,  $000E,  $1059,  $291F,  $1CE8,  $0842,  $2109

    ; $0DE64A
    .owanim_05
    dw  $0C63,  $40A5,  $5D67,  $7EAE,  $7F18,  $19CF,  $7B5C

    ; $0DE658
    .owanim_06
    dw  $08C4,  $0044,  $1540,  $3226,  $10CA,  $1980,  $1D90

    ; $0DE666
    .owanim_07
    dw  $14A5,  $3D26,  $5587,  $7ACE,  $14E9,  $620B,  $1D8F

    ; $0DE674
    .owanim_08
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE682
    .owanim_09
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE690
    .owanim_0A
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE69E
    .owanim_0B
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE6AC
    .owanim_0C
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; $0DE6BA
    .owanim_0D
    dw  $0000,  $0000,  $0000,  $0000,  $0000,  $0000,  $0000

    ; ===============================================================
    ; Main Overworld Palettes
    ; ===============================================================

    ; $0DE6C8
    .owmain
    .owmain_00
    dw  $14A5,  $14E9,  $152C,  $1D8F,  $19C6,  $2669,  $25F1
    dw  $14A5,  $14E9,  $152C,  $1D8F,  $158D,  $2211,  $25F1
    dw  $14A5,  $14E9,  $152C,  $1D8F,  $152C,  $25F1,  $25F1
    dw  $14A5,  $3A0A,  $4AEF,  $5FB6,  $1565,  $2669,  $1B46
    dw  $14A5,  $194C,  $25D1,  $3234,  $1DE5,  $2669,  $2628

    ; $0DE70E
    .owmain_01
    dw  $0C63,  $0C87,  $10CA,  $112D,  $198C,  $2A32,  $1D90
    dw  $0C63,  $0CA7,  $10CA,  $112D,  $196E,  $29F2,  $1D90
    dw  $0C63,  $0CA7,  $10CA,  $112D,  $112D,  $1D90,  $1D90
    dw  $08C4,  $21C9,  $366E,  $4F34,  $198C,  $2A32,  $3274
    dw  $08C4,  $4DB1,  $72D3,  $12B7,  $198C,  $2A32,  $1DCF

    ; $0DE754
    .owmain_02
    dw  $0C63,  $0C87,  $10CA,  $112D,  $158D,  $19CF,  $1D90
    dw  $0C63,  $0C87,  $10CA,  $112D,  $6FB6,  $2150,  $7FFF
    dw  $0C63,  $0C87,  $10CA,  $112D,  $112D,  $1D90,  $1D90
    dw  $14E6,  $3A0A,  $4AEF,  $5FD6,  $158D,  $19CF,  $7DBF
    dw  $14A5,  $114C,  $1DD1,  $2E35,  $158D,  $19CF,  $1D90

    ; $0DE79A
    .owmain_03
    dw  $0884,  $0CC7,  $150A,  $154D,  $150A,  $1D4C,  $21AF
    dw  $0884,  $0CC7,  $1509,  $196C,  $41F5,  $0842,  $569A
    dw  $0884,  $0CC7,  $1509,  $196C,  $1509,  $21AF,  $21AF
    dw  $1084,  $21C9,  $366E,  $4F34,  $150A,  $1D4C,  $258E
    dw  $1084,  $4DB1,  $72D3,  $12B7,  $10E9,  $1D4C,  $150A

    ; $0DE7E0
    .owmain_04
    dw  $0084,  $00A5,  $00E7,  $00E8,  $014B,  $010D,  $0118
    dw  $00A0,  $0100,  $0942,  $0D83,  $11A4,  $258C,  $1908
    dw  $24E6,  $1462,  $1CA4,  $2907,  $1CCD,  $250F,  $20EE
    dw  $398B,  $3149,  $2906,  $24E6,  $14A4,  $258C,  $1908
    dw  $1084,  $1908,  $258C,  $4273,  $52F7,  $188B,  $1532

    ; $0DE826
    .owmain_05
    dw  $5D8C,  $558A,  $76B3,  $7AF4,  $0D23,  $11C4,  $2287
    dw  $4908,  $558A,  $76B3,  $7AF4,  $2CA3,  $3584,  $3E09
    dw  $6A0F,  $6E50,  $6E71,  $76B3,  $558A,  $69EE,  $7B17
    dw  $190A,  $3549,  $45EC,  $6E50,  $258D,  $3A32,  $5F3A
    dw  $1084,  $1908,  $258C,  $4273,  $52F7,  $188B,  $1532

    ; ===============================================================
    ; Overworld Auxiliary Palettes (pool of palettes for aux 1 and aux 2)
    ; ===============================================================

    ; $0DE86C
    .owaux
    .owaux_00
    dw  $14C5,  $216E,  $29F3,  $3677,  $1CED,  $2952,  $46D7
    dw  $14C5,  $3A0A,  $4AEF,  $5FB6,  $6BDA,  $19C6,  $2669
    dw  $14A5,  $194C,  $21D1,  $3255,  $21A5,  $21E8,  $1965

    ; $0DE896
    .owaux_01
    dw  $14A5,  $3570,  $5237,  $6B1C,  $2273,  $498B,  $6250
    dw  $14A5,  $194C,  $21D1,  $1965,  $2952,  $19C6,  $1CEE
    dw  $14A5,  $29D1,  $4ED8,  $77BD,  $1947,  $320D,  $19C6

    ; $0DE8C0
    .owaux_02
    dw  $14A5,  $1D91,  $1E19,  $26BD,  $6B5F,  $2D77,  $4A1B
    dw  $14A5,  $7FFF,  $3DA4,  $4631,  $1CF1,  $7FFF,  $7FFF
    dw  $14C7,  $2DCF,  $3E74,  $635C,  $19C6,  $2669,  $7BFF

    ; $0DE8EA
    .owaux_03
    dw  $7F13,  $7F55,  $7FD9,  $7FFD,  $31C8,  $0000,  $7ED0
    dw  $044E,  $0009,  $0CFC,  $63DF,  $4E73,  $323F,  $0C75
    dw  $7FFF,  $3DEF,  $14A5,  $14A5,  $0000,  $6318,  $4E73

    ; $0DE914
    .owaux_04
    dw  $18C6,  $1D8F,  $620B,  $6B98,  $1DE7,  $2669,  $25F1
    dw  $18C6,  $5187,  $1E36,  $3F9E,  $1DE7,  $2669,  $620B
    dw  $14A5,  $14E9,  $152C,  $1D8F,  $19C6,  $2669,  $25F1

    ; $0DE93E
    .owaux_05
    dw  $0884,  $052A,  $21EF,  $3AB5,  $4B39,  $1D4C,  $18AC
    dw  $0884,  $052A,  $21EF,  $3AB5,  $4B39,  $1D4C,  $18AC
    dw  $0884,  $1508,  $196C,  $21AF,  $41F5,  $1D4C,  $569A

    ; $0DE968
    .owaux_06
    dw  $38C2,  $5903,  $75A7,  $7EEB,  $7FB2,  $19CF,  $0C63
    dw  $0C63,  $152B,  $2A12,  $3AD8,  $146A,  $1D90,  $14E9
    dw  $0C63,  $1D2C,  $2150,  $2676,  $6FB6,  $19CF,  $7FFF

    ; $0DE992
    .owaux_07
    dw  $0C63,  $0C87,  $10CA,  $112D,  $158D,  $19CF,  $1D90
    dw  $0C63,  $0C87,  $10CA,  $112D,  $6FB6,  $7FFF,  $1D90
    dw  $0C63,  $3186,  $39C6,  $2DD1,  $7F18,  $326A,  $7B5C

    ; $0DE9BC
    .owaux_08
    dw  $14A5,  $3A0A,  $4AEF,  $5794,  $19C6,  $3A33,  $46B6
    dw  $14A5,  $1D6D,  $2DF1,  $7FFF,  $21A5,  $49F7,  $3594
    dw  $14A5,  $216E,  $29F3,  $3677,  $3125,  $45A8,  $46D7

    ; $0DE9E6
    .owaux_09
    dw  $14A5,  $25AB,  $3271,  $4717,  $1926,  $14E9,  $25F1
    dw  $14A5,  $194C,  $21D1,  $2211,  $1A53,  $2253,  $15AE
    dw  $14A5,  $25AB,  $3271,  $4717,  $5F5A,  $19AE,  $2211

    ; $0DEA10
    .owaux_0A
    dw  $2800,  $3840,  $44A1,  $5104,  $658C,  $6A0C,  $2669
    dw  $1CE7,  $320B,  $46F3,  $5399,  $6BFE,  $41A8,  $2669
    dw  $1505,  $114C,  $2669,  $19A4,  $2605,  $3265,  $36C8

    ; $0DEA3A
    .owaux_0B
    dw  $00E8,  $3336,  $298E,  $4654,  $2AB1,  $15EB,  $3AF5
    dw  $0884,  $04EA,  $114D,  $21D1,  $1216,  $1EDA,  $0150
    dw  $0884,  $0D2B,  $19F1,  $3EB7,  $5BBD,  $196E,  $29F2

    ; $0DEA64
    .owaux_0C
    dw  $0000,  $0821,  $1063,  $18A5,  $2CE7,  $3529,  $496B
    dw  $0CA7,  $294E,  $4614,  $5EFA,  $1DAD,  $7FFF,  $3AF5
    dw  $0884,  $218C,  $2E52,  $3AF5,  $1DCC,  $2E50,  $1129

    ; $0DEA8E
    .owaux_0D
    dw  $2504,  $2D68,  $41EC,  $4E6C,  $5AD0,  $1980,  $6F75
    dw  $0884,  $1980,  $0D6A,  $1A2F,  $3319,  $09F5,  $2EBC
    dw  $0884,  $1540,  $10C0,  $1DF0,  $196E,  $29F2,  $1980

    ; $0DEAB8
    .owaux_0E
    dw  $0C63,  $112D,  $1980,  $2A02,  $198C,  $2A32,  $1D90
    dw  $0C63,  $1540,  $7FFF,  $7FFF,  $198C,  $2A32,  $1980
    dw  $0C63,  $0C87,  $10CA,  $112D,  $198C,  $2A32,  $1D90

    ; $0DEAE2
    .owaux_0F
    dw  $14E8,  $1DB0,  $2E75,  $3F1A,  $7FFF,  $4718,  $4F5A
    dw  $0884,  $04EA,  $114D,  $21D1,  $31D7,  $467B,  $2553
    dw  $10C6,  $25B2,  $3257,  $3ADB,  $2D94,  $3A18,  $4EBC

    ; $0DEB0C
    .owaux_10
    dw  $0C63,  $25B2,  $3257,  $36FB,  $2948,  $396C,  $4A10
    dw  $14E6,  $21C9,  $366E,  $4F34,  $5FB8,  $198C,  $2A32
    dw  $0884,  $04EA,  $114D,  $21D1,  $19AC,  $262F,  $1D67

    ; $0DEB36
    .owaux_11
    dw  $148E,  $1914,  $21D9,  $32FF,  $0C01,  $0C01,  $180A
    dw  $0884,  $04EA,  $114D,  $21D1,  $498E,  $5A13,  $3D2A
    dw  $0884,  $0D6E,  $19F3,  $2656,  $2E97,  $110C,  $00CA

    ; $0DEB60
    .owaux_12
    dw  $0884,  $0509,  $116B,  $2A31,  $3AB5,  $1D4C,  $01D0
    dw  $0884,  $0CC7,  $150A,  $154D,  $5BFF,  $569A,  $21AF
    dw  $0842,  $0842,  $0C63,  $0849,  $1CE8,  $0C63,  $2109

    ; $0DEB8A
    .owaux_13
    dw  $1084,  $0407,  $106A,  $04CE,  $1552,  $1925,  $0CE8
    dw  $0884,  $1CCB,  $1DCE,  $3694,  $4718,  $1D4C,  $18AC
    dw  $0884,  $1508,  $196C,  $21AF,  $41F5,  $1D4C,  $569A
}

; ==============================================================================

; $0DEBB4-$0DEBC0 DATA
SwordPaletteOffsets:
{
    db (PaletteData_sword_00-PaletteData_sword) ; $00
    db (PaletteData_sword_00-PaletteData_sword) ; $00
    db (PaletteData_sword_01-PaletteData_sword) ; $06
    db (PaletteData_sword_02-PaletteData_sword) ; $0C
    db (PaletteData_sword_03-PaletteData_sword) ; $12
    db $18, $1E, $24, $2A, $30, $36, $3C, $42
}
    
; $0DEBC1-$0DEBC5 DATA
ShieldPaletteOffsets:
{
    db (PaletteData_shield_00-PaletteData_shield) ; $00
    db (PaletteData_shield_00-PaletteData_shield) ; $00
    db (PaletteData_shield_01-PaletteData_shield) ; $08
    db (PaletteData_shield_02-PaletteData_shield) ; $10
    db $18
}
    
; $0DEBC6-$0DEBD5 DATA
PaletteIDtoOffset:
{
    db $00 ; 0x00
    db $0E ; 0x01
    db $1C ; 0x02
    db $2A ; 0x03
    db $38 ; 0x04
    db $46 ; 0x05
    db $54 ; 0x06
    db $62 ; 0x07
    db $70 ; 0x08
    db $7E ; 0x09
    db $8C ; 0x0A
    db $9A ; 0x0B
    db $A8 ; 0x0C
    db $B6 ; 0x0D
    db $C4 ; 0x0E
    db $D2 ; 0x0F
}
    
; $0DEBD6-$0DEC05 DATA
PaletteIDtoOffset_16bit:
{
    ; $0DEBD6
    dw $0000 ; 0x00
    dw $000E ; 0x01
    dw $001C ; 0x02
    dw $002A ; 0x03
    dw $0038 ; 0x04
    dw $0046 ; 0x05
    dw $0054 ; 0x06
    dw $0062 ; 0x07
    dw $0070 ; 0x08
    dw $007E ; 0x09
    dw $008C ; 0x0A
    dw $009A ; 0x0B
    dw $00A8 ; 0x0C
    dw $00B6 ; 0x0D

    ; $0DEBF2
    .agah
    dw $00C4 ; 0x0E
    dw $00D2 ; 0x0F
    dw $00E0 ; 0x10
    dw $00EE ; 0x11
    dw $00FC ; 0x12
    dw $010A ; 0x13
    dw $0118 ; 0x14
    dw $0126 ; 0x15
    dw $0134 ; 0x16
    dw $0142 ; 0x17
}

; $0DEC06-$0DEC0A DATA
LinkMailPalettesOffsets:
{
    db (Palettes_GreenMail-PaletteData_Link)/2 ; $00
    db (Palettes_BlueMail-PaletteData_Link)/2  ; $0F
    db (Palettes_RedMail-PaletteData_Link)/2   ; $1E
    db (Palettes_Bunny-PaletteData_Link)/2     ; $2D
    db (Palettes_Zap-PaletteData_Link)/2       ; $3C
}
    
; $0DEC0B-$0DEC12 DATA
UnusedPaletteOffsets:
{
    db $00, $1C, $38, $54, $70, $8C, $A8, $C4
}
    
; $0DEC13-$0DEC3A DATA
PaletteIDtoOffset_OW_AUX:
{
    dw $0000 ; 0x00
    dw $002A ; 0x01
    dw $0054 ; 0x02
    dw $007E ; 0x03
    dw $00A8 ; 0x04
    dw $00D2 ; 0x05
    dw $00FC ; 0x06
    dw $0126 ; 0x07
    dw $0150 ; 0x08
    dw $017A ; 0x09
    dw $01A4 ; 0x0A
    dw $01CE ; 0x0B
    dw $01F8 ; 0x0C
    dw $0222 ; 0x0D
    dw $024C ; 0x0E
    dw $0276 ; 0x0F
    dw $02A0 ; 0x10
    dw $02CA ; 0x11
    dw $02F4 ; 0x12
    dw $031E ; 0x13
}
    
; $0DEC3B-$0DEC46 DATA
PaletteIDtoOffset_OW_Main:
{
    dw $0000 ; 0x00
    dw $0046 ; 0x01
    dw $008C ; 0x02
    dw $00D2 ; 0x03
    dw $0118 ; 0x04
    dw $015E ; 0x05
}
    
; $0DEC47-$0DEC4A DATA
PaletteIDtoOffset_HUD:
{
    db $00, $40, $00, $30
}
    
; $0DEC4B-$0DEC72 DATA
PaletteIDtoOffset_UW:
{
    dw $0000 ; $00
    dw $00B4 ; $01
    dw $0168 ; $02
    dw $021C ; $03
    dw $02D0 ; $04
    dw $0384 ; $05
    dw $0438 ; $06
    dw $04EC ; $07
    dw $05A0 ; $08
    dw $0654 ; $09
    dw $0708 ; $0A
    dw $07BC ; $0B
    dw $0870 ; $0C
    dw $0924 ; $0D
    dw $09D8 ; $0E
    dw $0A8C ; $0F
    dw $0B40 ; $10
    dw $0BF4 ; $11
    dw $0CA8 ; $12
    dw $0D5C ; $13
}
    
; $0DEC73-$0DEC76 DATA
PaletteWorldIDtoOffset:
{
    dw $0000 ; Light World
    dw $0078 ; Dark World
}

; ==============================================================================

; $0DEC77-$0DEC9D LONG JUMP LOCATION
Palette_SpriteAux3:
{
    REP #$21
    
    ; Palette 1
    LDX.w $0AAC
    LDA.w PaletteIDtoOffset, X : AND.w #$00FF
    ADC.w PaletteData_spritePalette : STA.b $00
    
    REP #$10
    
    LDA.w #$0102 ; Target SP-0 (first half)
    
    ; Depending on this flag, use different palette areas.
    LDX.w $0ABD : BEQ .useSP0
        LDA.w #$01E2 ; Target SP-7 (first half)
    
    .useSP0
    
    ; Write a palette consisting of 7 colors to CGRAM buffer
    LDX.w #$0006
    JSR.w Palette_SingleLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DEC9E-$0DECC4 LONG JUMP LOCATION
Palette_MainSpr:
{
    ; Loads palettes for the commonly used sprites like fairys, blue / red
    ; creatures, hearts, rupees, etc
    REP #$21
    
    ; X = 0x00 for light world
    LDX.b #$00
    
    ; ZScream Custom Overworld? not sure, needs investigation.
    LDA.b $8A : AND.w #$0040 : BEQ .lightWorld
        ; X = 0x02 for dark world
        INX : INX
    
    .lightWorld
    
    LDA.w PaletteWorldIDtoOffset, X : ADC.w PaletteData_sprite : STA.b $00
    
    REP #$10
    
    LDA.w #$0122 ; Target SP-1 through SP-4 (full)
    LDX.w #$000E ; Load 15 colors
    LDY.w #$0003 ; Load 4 palettes
    JSR.w Palette_MultiLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DECC5-$0DECE3 LONG JUMP LOCATION
Palette_SpriteAux1:
{
    REP #$31
    
    ; Load sprite palette 2 value
    LDA.w $0AAD : AND.w #$00FF : ASL : TAX
    LDA.w PaletteIDtoOffset, X : ADC.w PaletteData_spriteAux : STA.b $00
    
    LDA.w #$01A2 ; Target SP-5 (first half)
    LDX.w #$0006 ; Palette has 7 colors
    JSR.w Palette_SingleLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DECE4-$0DED02 LONG JUMP LOCATION
Palette_SpriteAux2:
{
    REP #$31
    
    ; Load sprite palette 3 value
    LDA.w $0AAE : AND.w #$00FF : ASL : TAX
    LDA.w PaletteIDtoOffset, X : ADC.w PaletteData_spriteAux : STA.b $00
    
    LDA.w $01C2  ; Target SP-6 (first half)
    LDX.w #$0006 ; Palette has 7 colors
    JSR.w Palette_SingleLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DED03-$0DED28 LONG JUMP LOCATION
Palette_Sword:
{
    ; Load sword palette
    
    REP #$21
    
    ; Figure out what kind of sword Link has.
    LDA.l $7EF359 : AND.w #$00FF : TAX
    LDA.w SwordPaletteOffsets, X : AND.w #$00FF
    ADC.w PaletteData_sword : STA.b $00
    
    REP #$10
    
    LDA.w #$01B2 ; Target SP-5 (second half)
    LDX.w #$0002 ; Palette has 3 colors
    JSR.w Palette_ArbitraryLoad
    
    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; $0DED29-$0DED4E LONG JUMP LOCATION
Palette_Shield:
{
    ; Load shield palette
    
    REP #$21
    
    ; Figure out what kind of shield Link has.
    LDA.l $7EF35A : AND.w #$00FF : TAX
    LDA.w ShieldPaletteOffsets, X : AND.w #$00FF
    ADC.w PaletteData_shield : STA.b $00
    
    REP #$10
    
    LDA.w #$01B8 ; Target SP-5 (second half)
    LDX.w #$0003 ; Load 4 colors
    JSR.w Palette_ArbitraryLoad
    
    SEP #$30
    
    ; Set the palette update flag
    INC.b $15
    
    RTL
}

; ==============================================================================

; UNUSED: This routine isn't referenced anywhere in the game... that i can tell...
; $0DED4F-$0DED6D
Palette_Unused:
{
    REP #$21
    
    LDX.w $0AB0
    LDA.w PaletteIDtoOffset, X : AND.w #$00FF
    ADC.w PaletteData_environment : STA.b $00
    
    REP #$10
    
    LDA.w #$01C2 ; Target SP-6 (first half)
    LDX.w #$0006 ; 7 colors
    JSR.w Palette_SingleLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DED6E-$0DEDDC LONG JUMP LOCATION
Palette_MiscSpr:
{
    ; If we're outdoors do something else...
    LDA.b $1B : BEQ .outdoors
        ; $0DED72 ALTERNATE ENTRY POINT 
        .justSP6
        
        REP #$21
        
        LDX.w $0AB1
        LDA.w PaletteIDtoOffset, X : AND.w #$00FF
        ADC.w PaletteData_environment : STA.b $00
        
        REP #$10
        
        LDA.w #$01D2 ; Target SP-6 (second half)
        LDX.w #$0006 ; Palette has 7 colors
        JSR.w Palette_SingleLoad
        
        SEP #$30
        
        RTL
    
    .outdoors
    
    ; This section loads the palette for thrown objects like bushes and rocks.
    REP #$21
    
    LDX.w #$07
    
    ; See if we're in the dark world.
    ; ZScream Custom Overworld? not sure, needs investigation.
    LDA.b $8A : AND.w #$0040 : BEQ .lightWorld
        INX : INX
    
    .lightWorld
    
    PHX
    
    ; X = 0x07 or 0x09
    LDA.w PaletteIDtoOffset, X : AND.w #$00FF
    ADC.w PaletteData_environment : STA.b $00
    
    REP #$10
    
    LDA.w #$0112 ; Target SP-0 (second half)
    
    ; Not sure but it's definitely palette related.
    LDX.w $0ABD : BEQ .useSP0
        LDA.w #$01F2 ; Target SP-7 (second half)
    
    .useSP0
    
    LDX.w #$0006 ; 7 color palette
    JSR.w Palette_SingleLoad
    
    SEP #$10
    
    PLX : DEX
    
    LDA.w PaletteIDtoOffset, X : AND.w #$00FF : CLC
    ADC.w PaletteData_environment : STA.b $00
    
    REP #$10
    
    LDA.w #$01D2 ; Target SP-6 (second half)
    LDX.w #$0006 ; 7 color palette
    JSR.w Palette_SingleLoad
    
    REP #$30
    
    RTL
}

; ==============================================================================

; Load palettes for Palace Map sprite graphics.
; $0DEDDD-$0DEDF4 LONG JUMP LOCATION
Palette_PalaceMapSpr:
{
    REP #$21
    
    ; Load palettes from $1BD70A
    LDA.w PaletteData_dungeonMapSprites_00 : STA.b $00
    
    REP #$10
    
    LDA.w #$0182 ; Starting target palette is SP4
    LDX.w #$0006 ; 7 colors
    LDY.w #$0002 ; Load 3 palettes
    JSR.w Palette_MultiLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DEDF5-$0DEDF8 DATA - Glove colors (other than skin colored)
Palettes_LinkGloveColors:
{
    dw $52F6, $0376
}

; Load armor palette
; $0DEDF9-$0DEE39 LONG JUMP LOCATION
; Palette_ChangeGloveColor:
Palette_ArmorAndGloves:
{
    REP #$21
    
    ; Check what Link's armor value is.
    LDA.l $7EF35B : AND.w #$00FF : TAX
    
    LDA.w PaletteIDtoOffset_16bit, X : AND.w #$00FF : ASL
    ADC.w PaletteData_Link : STA.b $00
    
    REP #$10
    
    LDA.w #$01E2 ; Target SP-7 (sprite palette 6)
    LDX.w #$000E ; Palette has 15 colors
    JSR.w Palette_ArbitraryLoad
    
    ; $0DEE1B ALTERNATE ENTRY POINT
    .justGloves

    REP #$30
    
    ; Check what type of Gloves Link has.
    ; If Link has no special gloves I guess you use a default?
    LDA.l $7EF354 : AND.w #$00FF : BEQ .defaultGloveColor
        DEC : ASL : TAX
        LDA.w Palettes_LinkGloveColors, X : STA.l $7EC4FA
                                            STA.l $7EC6FA
    
    .defaultGloveColor
    
    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; Much like the name implies, loads the palettes for the Palace Map BG graphics.
; $0DEE3A-$0DEE51 LONG JUMP LOCATION
Palette_PalaceMapBg:
{
    REP #$21
    
    ; Sets source address to $1BE544 (cpu address)
    ; The bank of 0x1B is plugged in by Palette_MultiLoad
    LDA.w PaletteData_dungeonmap_bg_00 : STA.b $00
    
    REP #$10
    
    LDA.w #$0040 ; Starting target palette is BP-2
    LDX.w #$000F ; Each palette has 16 colors
    LDY.w #$0005 ; Load 6 palettes
    JSR.w Palette_MultiLoad
    
    SEP #$30
    
    RTL
}

; =============================================

; $0DEE52-$0DEE73 LONG JUMP LOCATION
Palette_HUD:
{
    REP #$21
    
    LDX.w $0AB2
    LDA.w PaletteIDtoOffset_HUD, X : AND.w #$00FF
    ADC.w PaletteData_hud : STA.b $00
    
    ; X/Y registers are 8-bit
    REP #$10
    
    LDA.w #$0000 ; Target BP0 through BP1 (full)
    LDX.w #$000F ; Each palette has 16 colors.
    LDY.w #$0001 ; Load 2 palettes.
    JSR.w Palette_MultiLoad
    
    SEP #$30
    
    RTL
}

; =============================================

; $0DEE74-$0DEEA7 LONG JUMP LOCATION
Palette_DungBgMain:
{
    ; Note this resets the carry. (For the ADC below.)
    REP #$21
    
    ; This is the palette index for a certain background
    LDX.w $0AB6
    LDA.w PaletteIDtoOffset_UW, X : ADC.w #$D734 : STA.b $00
                                                   PHA
    
    REP #$10
    
    LDA.w #$0042 ; Target BP-2 through BP-7 (full)
    LDX.w #$000E ; Load 15 colors
    LDY.w #$0005 ; Load 6 palettes
    JSR.w Palette_MultiLoad
    
    ; Now get that value of A before the subroutine.
    PLA
    
    ; Reload it to $00.
    STA.b $00
    
    LDA.w #$0112 ; Target SP-0 (second half)
    
    ; Unknown variable
    LDX.w $0ABD : BEQ .useSP0
        LDA.w #$01F2 ; Target SP-7 (second half)
    
    .useSP0
    
    LDX.w #$0006 ; Load 7 colors
    JSR.w Palette_SingleLoad
    
    SEP #$30
    
    RTL
}

; =============================================

; $0DEEA8-$0DEEC6 LONG JUMP LOCATION
Palette_OverworldBgAux3:
{
    REP #$21
    
    LDX.w $0AB8
    LDA.w PaletteIDtoOffset, X : AND.w #$00FF
    ADC.w PaletteData_owanim : STA.b $00
    
    REP #$10
    
    LDA.w #$00E2 ; Target BP-7 (first half)
    LDX.w #$0006 ; Load 7 colors
    JSR.w Palette_SingleLoad
    
    SEP #$30
    
    RTL
}

; =============================================

; $0DEEC7-$0DEEE7 LONG JUMP LOCATION
Palette_OverworldBgMain:
{
    REP #$21
    
    LDA.w $0AB3 : ASL : TAX
    LDA.w PaletteIDtoOffset_OW_Main, X : ADC.w PaletteData_owmain : STA.b $00
    
    REP #$10
    
    LDA.w #$0042 ; Target BP2 through BP6 (first halves)
    LDX.w #$0006 ; each palette has 7 colors
    LDY.w #$0004 ; Load 5 palettes
    JSR.w Palette_MultiLoad
    
    SEP #$30
    
    RTL
}

; =============================================

; $0DEEE8-$0DEF0B LONG JUMP LOCATION
Palette_OverworldBgAux1:
{
    REP #$21
    
    LDA.w $0AB4 : AND.w #$00FF : ASL : TAX
    LDA.l PaletteIDtoOffset_OW_AUX, X : ADC.w #PaletteData_owaux : STA.b $00
    
    REP #$10
    
    LDA.w #$0052 ; Target BP-2 through BP-4 (second halves)
    LDX.w #$0006 ; Each one has 7 colors
    LDY.w #$0002 ; Load 3 palettes
    JSR.w Palette_MultiLoad
    
    REP #$30
    
    RTL
}

; =============================================

; $0DEF0C-$0DEF2F LONG JUMP LOCATION
Palette_OverworldBgAux2:
{
    REP #$21
    
    LDA.w $0AB5 : AND.w #$00FF : ASL : TAX
    LDA.l PaletteIDtoOffset_OW_AUX, X : ADC.w #PaletteData_owaux : STA.b $00
    
    REP #$10
    
    LDA.w #$00B2 ; Target BP-5 through BP-7 (second halves)
    LDX.w #$0006 ; Each one has 7 colors
    LDY.w #$0002 ; Load 3 palettes
    JSR.w Palette_MultiLoad
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; Unlike like the Subroutine after this one, it only loads one palette to
; memory.
; Parameters:
; X = number of colors (i.e. number of words/16-bit values to write)
; A = offset for placing palette in memory.
; $0DEF30-$0DEF4A LOCAL JUMP LOCATION
Palette_SingleLoad:
{
    ; Ensures the counter is saved.
    ; Generally the place to look for this value is $0AA9 (high byte).
    TXY : CLC : ADC.w $0AA8 : TAX
    
    ; Ensure the data bank being drawn from is 1B = #$D in ROM.
    LDA.w #$001B : STA.b $02

    .copyPalette

        ; Since this is a long indirect, that's why #$1B was put in $02.
        LDA.b [$00] : STA.l $7EC300, X
        
        INC.b $00 : INC.b $00
        
        INX : INX
    DEY : BPL .copyPalette
    
    RTS
}

; ==============================================================================

; Description: Generally used to load multiple palettes for BGs. Upon close
; inspection, one sees that this algorithm is almost the same as the last
; subroutine.
; Parameters: X = (number of colors in the palette - 1)
;             A = offset to add to $7EC300, in other words, where to write 
;             in palette memory.
;             Y = (number of palettes to load - 1)
; $0DEF4B-$0DEF7A LOCAL JUMP LOCATION
Palette_MultiLoad:
{
    STA.b $04 ; Save the values for future reference.
    STX.b $06
    STY.b $08
    
    ; The absolute address at $00 was planted in the calling function. This
    ; value is the bank 0x1B. The address is found from $0AB6.
    LDA.w #pc()>>16 : STA.b $02 ; #$001B
    
    .nextPalette

        ; $0AA8 + A parameter will be the X value.
        LDA.w $0AA8 : CLC : ADC.b $04 : TAX
        
        LDY.b $06 ; Tell me how long the palette is.
        
        .copyColors

            ; We're loading A from the address set up in the calling function.
            LDA.b [$00] : STA.l $7EC300, X 
            
            ; Increment the absolute portion of the address by two, and decrease
            ; the color count by one.
            INC.b $00 : INC.b $00
            
            INX : INX
        
            ; So basically loop (Y+1) times, taking (Y * 2 bytes) to $7EC300, X.
        DEY : BPL .copyColors
        
        ; This technique bumps us up to the next 4bpp (16 color) palette.
        LDA.b $04 : CLC : ADC.w #$0020 : STA.b $04
        
        ; Decrease the number of palettes we have to load.
        DEC.b $08
    BPL .nextPalette
    
    ; We're done loading palettes.
    
    RTS
}

; =============================================

; This routine accepts a 2 byte pointer local to bank 0x1B
; A = starting offset into the palette buffer to copy to
; X = the number of colors in the palette
; $0DEF7B-$0DEF95 LOCAL JUMP LOCATION
Palette_ArbitraryLoad:
{
    TXY : TAX
    
    LDA.w #$001B : STA.b $02
    
    .loop

        LDA.b [$00] : STA.l $7EC300, X
                      STA.l $7EC500, X
        
        INC.b $00 : INC.b $00
        
        INX : INX
    DEY : BPL .loop
    
    RTS
}

; ==============================================================================

; This routine sets up the palettes for each of the three Links on the
; Select screen.
; $0DEF96-$0DF031 LONG JUMP LOCATION
Palette_SelectScreen:
{
    ; Set data bank to 0x1B.
    PHB : LDA.b #$1B : PHA : PLB
    
    REP #$30
    
    ; Save slot 1.
    LDX.w #$0000
    
    ; This tells us what kind of gloves link has.
    LDA.l $700354 : STA.b $0C
    
    ; The value for your armor.
    LDA.l $70035B
    JSR.w Palette_SelectScreenArmor
    
    LDX.w #$0000
    LDA.l $700359
    JSR.w Palette_SelectScreenSword
    
    LDX.w #$0000
    LDA.l $70035A
    JSR.w Palette_SelectScreenShield
    
    ; Save slot two.
    LDX.w #$0040
    
    ; Again we need the palette for his gloves.
    LDA.l $700854 : STA.b $0C
    
    ; The value for the armor.
    LDA.l $70085B
    JSR.w Palette_SelectScreenArmor
    
    LDX.w #$0040
    LDA.l $700859
    JSR.w Palette_SelectScreenSword
    
    LDX.w #$0040
    LDA.l $70085A
    JSR.w Palette_SelectScreenShield
    
    ; Save slot three.
    LDX.w #$0080
    
    ; Again we need the palette for his gloves.
    LDA.l $700D54 : STA.b $0C
    
    LDA.l $700D5B
    JSR.w Palette_SelectScreenArmor
    
    LDX.w #$0080
    LDA.l $700D59
    JSR.w Palette_SelectScreenSword
    
    LDX.w #$0080
    LDA.l $700D5A
    JSR.w Palette_SelectScreenShield
    
    LDY.w #$0000
    LDX.w #$0000
    
    .loadFairyPalette
    
        ; This section of code has to do with loading the fairy sprite used
        ; For selecting which game you're in.
        
        LDA.w PaletteData_sprite_00_right, Y : STA.l $7EC4D0, X
                                               STA.l $7EC6D0, X
        
        LDA.w PaletteData_sprite_01_right, Y : STA.l $7EC4F0, X
                                               STA.l $7EC6F0, X
        
        INY : INY
        INX : INX
    CPX.w #$000E : BNE .loadFairyPalette
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; And gloves!
; $0DF032-$0DF071 LOCAL JUMP LOCATION
Palette_SelectScreenArmor:
{
    PHX
    
    ;  Varies among #$00, #$40, #$80
    AND.w #$00FF : ASL : TAY
    
    ; Will be 0, 30, or 60
    LDA.w PaletteIDtoOffset_16bit, Y : AND.w #$00FF : CLC : ADC.w #$00F0 : TAY
    
    ; Length of the palette in Words
    LDA.w #$000F : STA.b $0E
    
    .loadArmorPalette
    
        ; Load the fairys's palette data?
        LDA.w PaletteData, Y : STA.l $7EC402, X
                               STA.l $7EC602, X
        
        INY : INY
        
        INX : INX ; Hence we will be writing #$F * 2 bytes = #$1E
    DEC.b $0E : BNE .loadArmorPalette
    
    PLX
    
    ; This had $700354 (or 834 or D34)'s value.
    LDA.b $0C : AND.w #$00FF : BEQ .defaultGloveColor
        ; We're here if $0C was nonzero.
        ; Y = 2*(A - 1)
        DEC : ASL : TAY
        
        ; X will be #$00, #$40, #$80...
        LDA.w Palettes_LinkGloveColors, Y : STA.l $7EC41A, X
                                            STA.l $7EC61A, X
    
    .defaultGloveColor
    
    RTS
}

; =============================================

; $0DF072-$0DF099 LOCAL JUMP LOCATION
Palette_SelectScreenSword:
{
    ; Expects A to be the sword's value.
    AND.w #$00FF : TAY ; Will be 0-4.
    
    ; Will be #$00, #$06, #$0C, #$12...
    ; Generally will be #$418, #$41E, #$424, #$42A
    LDA.w SwordPaletteOffsets, Y : AND.w #$00FF : CLC : ADC.w #$0418 : TAY
    
    ; The length of the palette in Word Length
    LDA.w #$0003 : STA.b $0E
    
    .copyPalette
    
        LDA.w PaletteData, Y : STA.l $7EC432, X
                               STA.l $7EC632, X
        
        INY : INY
        INX : INX
        
        ; Branch 3 times, write 6 bytes, go home...
    DEC.b $0E : BNE .copyPalette
    
    RTS
}
    
; =============================================

; $0DF09A-$0DF0C1 LOCAL JUMP LOCATION
Palette_SelectScreenShield:
{
    ; This routine is generally the same as the two above.
    ; A is expected to be the value of your shield. (0 - 3)
    AND.w #$00FF : TAY
    
    ; #$00, #$08, #$10
    ; A will be #$430, #$438, #$440
    LDA.w ShieldPaletteOffsets, Y : AND.w #$00FF : CLC : ADC.w #$0430 : TAY
    
    ; Length of the palette in Word Length. (8 bytes)
    LDA.w #$0004 : STA.b $0E
    
    .copyPalette
    
        LDA.w PaletteData, Y : STA.l $7EC438, X
                               STA.l $7EC638, X
        
        INY : INY
        INX : INX
    DEC.b $0E : BNE .copyPalette
    
    RTS
}

; ==============================================================================

; $0DF0C2-$0DF107 LONG JUMP LOCATION
Palettes_LoadAgahnim:
{
    ; The only place this routine is referenced from is the
    ; (assumed for now) unused submodule 0x06 of module 0x0E
    ; Seems to have something to do with Agahnim 2 though.
    
    ; In general terms this loads the upper halves of SP_3, SP_4, SP_5,
    ; and SP_6.
    REP #$31
    
    ; TODO: See if there is a way to reference the address directly here.
    ; #$D4E0 is the address for PaletteData_spriteAux_00.
    LDA.w PaletteIDtoOffset_16bit_agah : ADC.w #$D4E0 : STA.b $00
    
    PHA
    
    LDA.w #$0162
    LDX.w #$0006
    JSR.w Palette_ArbitraryLoad
    
    PLA : STA.b $00
    
    PHA
    
    LDA.w #$0182
    LDX.w #$0006
    JSR.w Palette_ArbitraryLoad
    
    PLA : STA.b $00
    
    LDA.w #$01A2
    LDX.w #$0006
    JSR.w Palette_ArbitraryLoad
    
    ; #$D4E0 is the address for PaletteData_spriteAux_00.
    LDA.l PaletteIDtoOffset_16bit_agah+$0E
    CLC : ADC.w #PaletteData_spriteAux_00 : STA.b $00
    
    LDA.w #$01C2
    LDX.w #$0006
    JSR.w Palette_ArbitraryLoad
    
    SEP #$30
    
    INC.b $15
    
    RTL
}

; ==============================================================================

; $0DF108-$0DF10F NULL
NULL_1BF108:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; TODO: Some kind of tile properties data for bank $05... Seems to be
; indexed by Tile16 values.
; $0DF110-$0DFFBF DATA
OverworldTileTypeTable:
{
    db $01, $27, $01, $02, $02, $02, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $02
    db $01, $27, $01, $01, $01, $01, $27, $27
    db $01, $02, $01, $02, $01, $01, $27, $27
    db $01, $01, $02, $27, $01, $01, $27, $27
    db $02, $27, $01, $01, $02, $02, $27, $02
    db $02, $01, $01, $02, $48, $48, $50, $02
    db $02, $01, $48, $02, $02, $00, $02, $02
    db $02, $02, $01, $02, $01, $27, $02, $02
    db $01, $00, $01, $02, $02, $01, $01, $01
    db $02, $02, $02, $02, $27, $43, $00, $01
    db $02, $02, $01, $01, $01, $01, $43, $01
    db $02, $01, $00, $01, $42, $02, $02, $48
    db $02, $02, $01, $02, $48, $02, $02, $42
    db $02, $48, $00, $48, $01, $02, $27, $27
    db $27, $48, $01, $48, $48, $02, $27, $27
    db $01, $02, $01, $01, $02, $02, $27, $27
    db $27, $27, $01, $01, $02, $01, $02, $02
    db $01, $01, $01, $01, $02, $27, $02, $01
    db $02, $02, $27, $27, $27, $27, $00, $00
    db $00, $00, $02, $00, $00, $00, $00, $48
    db $27, $00, $00, $00, $48, $00, $27, $27
    db $27, $27, $02, $02, $02, $00, $27, $02
    db $02, $00, $01, $01, $02, $02, $00, $02
    db $01, $02, $02, $02, $01, $00, $00, $10
    db $18, $01, $01, $02, $01, $01, $02, $01
    db $01, $29, $00, $18, $02, $02, $01, $01
    db $01, $01, $48, $10, $01, $01, $27, $01
    db $01, $48, $48, $01, $01, $01, $18, $00
    db $48, $01, $01, $01, $48, $01, $01, $01
    db $48, $01, $27, $01, $01, $01, $01, $01
    db $48, $02, $02, $02, $02, $02, $02, $48
    db $00, $54, $48, $48, $12, $1A, $1A, $00
    db $27, $00, $27, $27, $12, $48, $48, $48
    db $00, $00, $00, $09, $48, $09, $01, $01
    db $01, $09, $09, $09, $18, $48, $10, $09
    db $09, $09, $10, $10, $01, $48, $48, $01
    db $08, $10, $09, $09, $08, $02, $00, $48
    db $02, $01, $08, $09, $00, $02, $02, $02
    db $02, $48, $02, $01, $02, $02, $02, $02
    db $01, $12, $02, $01, $02, $02, $02, $02
    db $02, $10, $08, $00, $09, $00, $00, $12
    db $1A, $01, $01, $01, $01, $10, $01, $08
    db $01, $09, $09, $01, $00, $12, $01, $01
    db $48, $01, $12, $1A, $01, $00, $1A, $12
    db $48, $00, $01, $01, $29, $00, $18, $00
    db $00, $00, $12, $01, $01, $01, $01, $01
    db $01, $00, $01, $00, $00, $00, $00, $01
    db $02, $22, $01, $01, $02, $22, $01, $01
    db $01, $01, $01, $02, $02, $01, $01, $02
    db $42, $01, $01, $01, $02, $01, $43, $02
    db $02, $43, $42, $44, $01, $00, $29, $01
    db $42, $01, $02, $02, $01, $00, $01, $02
    db $02, $02, $02, $02, $02, $02, $02, $01
    db $02, $02, $02, $02, $02, $01, $00, $01
    db $01, $01, $01, $01, $01, $02, $02, $01
    db $00, $01, $00, $02, $00, $01, $02, $02
    db $02, $02, $02, $02, $22, $01, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $02
    db $02, $01, $01, $01, $01, $02, $43, $01
    db $02, $02, $01, $02, $02, $00, $12, $00
    db $01, $02, $12, $01, $01, $2B, $01, $00
    db $00, $01, $18, $00, $00, $00, $00, $00
    db $00, $10, $01, $00, $00, $48, $00, $00
    db $48, $01, $00, $02, $01, $02, $00, $00
    db $02, $01, $02, $00, $01, $00, $48, $52
    db $00, $00, $4B, $00, $00, $00, $00, $00
    db $00, $01, $12, $27, $2B, $01, $00, $12
    db $01, $01, $01, $01, $09, $01, $57, $57
    db $57, $57, $01, $1A, $02, $02, $01, $02
    db $02, $01, $1A, $00, $1A, $48, $00, $00
    db $01, $53, $18, $56, $56, $56, $56, $01
    db $48, $48, $02, $01, $02, $01, $02, $02
    db $01, $01, $01, $02, $01, $01, $02, $01
    db $01, $01, $01, $01, $01, $02, $01, $01
    db $01, $01, $01, $01, $01, $01, $18, $10
    db $02, $02, $10, $01, $02, $02, $00, $00
    db $02, $00, $02, $02, $02, $02, $02, $02
    db $00, $01, $01, $48, $02, $48, $01, $02
    db $00, $00, $00, $00, $02, $01, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $01
    db $01, $02, $02, $02, $02, $02, $02, $00
    db $27, $20, $20, $20, $27, $27, $27, $02
    db $20, $20, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $00, $00, $02, $02
    db $02, $01, $18, $02, $02, $01, $02, $02
    db $02, $02, $02, $5C, $09, $01, $02, $02
    db $02, $5C, $09, $09, $09, $02, $08, $09
    db $09, $48, $02, $09, $02, $08, $08, $02
    db $01, $10, $08, $09, $08, $18, $08, $09
    db $08, $08, $09, $09, $02, $09, $1A, $09
    db $1A, $00, $01, $01, $08, $00, $48, $48
    db $48, $09, $09, $00, $48, $48, $10, $09
    db $00, $01, $02, $22, $29, $00, $09, $1A
    db $08, $5C, $08, $5C, $01, $01, $02, $08
    db $12, $01, $18, $01, $12, $01, $1A, $48
    db $02, $08, $5C, $08, $00, $02, $02, $08
    db $02, $5C, $02, $02, $08, $00, $48, $00
    db $12, $01, $48, $00, $02, $02, $12, $12
    db $12, $02, $00, $02, $08, $08, $08, $02
    db $02, $01, $00, $01, $02, $01, $02, $02
    db $01, $02, $02, $27, $27, $27, $27, $27
    db $27, $01, $01, $01, $02, $02, $01, $01
    db $01, $02, $02, $02, $02, $01, $01, $02
    db $02, $02, $02, $01, $01, $01, $02, $02
    db $01, $01, $02, $01, $02, $2B, $01, $43
    db $01, $01, $01, $01, $01, $01, $02, $02
    db $02, $00, $00, $02, $02, $27, $27, $27
    db $27, $27, $01, $01, $27, $55, $55, $27
    db $01, $01, $27, $02, $55, $55, $01, $01
    db $01, $01, $01, $02, $02, $00, $40, $01
    db $02, $02, $48, $48, $48, $00, $29, $01
    db $01, $01, $2B, $01, $02, $01, $02, $42
    db $00, $02, $02, $01, $00, $00, $08, $08
    db $01, $08, $1A, $01, $01, $08, $02, $01
    db $08, $02, $01, $27, $01, $02, $00, $27
    db $27, $00, $00, $00, $00, $27, $00, $00
    db $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $27, $01, $22, $27
    db $48, $48, $48, $02, $01, $00, $00, $02
    db $01, $00, $00, $01, $01, $01, $00, $01
    db $01, $01, $00, $01, $01, $27, $27, $27
    db $27, $01, $01, $01, $01, $02, $01, $02
    db $01, $02, $02, $02, $02, $02, $20, $01
    db $00, $00, $01, $00, $00, $01, $01, $01
    db $02, $22, $22, $00, $01, $43, $01, $01
    db $01, $01, $02, $01, $01, $01, $01, $01
    db $01, $48, $01, $01, $01, $01, $01, $00
    db $00, $00, $01, $01, $01, $01, $01, $00
    db $02, $00, $00, $02, $00, $00, $00, $00
    db $00, $00, $00, $02, $00, $01, $01, $01
    db $00, $01, $02, $02, $02, $48, $00, $01
    db $00, $02, $01, $02, $01, $01, $27, $01
    db $01, $00, $02, $22, $02, $02, $00, $00
    db $48, $01, $01, $01, $01, $00, $02, $02
    db $00, $48, $01, $01, $01, $27, $27, $27
    db $02, $27, $27, $27, $02, $01, $02, $01
    db $01, $01, $01, $02, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $02
    db $02, $02, $01, $44, $01, $27, $01, $00
    db $00, $02, $02, $02, $01, $01, $01, $01
    db $02, $01, $01, $02, $02, $02, $01, $01
    db $01, $02, $02, $02, $01, $02, $00, $02
    db $02, $02, $02, $02, $02, $00, $01, $42
    db $01, $42, $42, $00, $00, $01, $01, $01
    db $01, $00, $02, $01, $01, $01, $02, $42
    db $01, $01, $02, $02, $02, $02, $02, $00
    db $02, $02, $22, $02, $02, $00, $00, $00
    db $02, $02, $00, $02, $02, $01, $01, $01
    db $01, $42, $01, $02, $02, $02, $48, $02
    db $01, $01, $01, $01, $01, $48, $02, $01
    db $02, $01, $02, $01, $02, $01, $00, $01
    db $01, $01, $01, $00, $00, $00, $00, $00
    db $48, $00, $01, $00, $48, $48, $48, $48
    db $02, $02, $00, $01, $01, $01, $01, $02
    db $02, $02, $02, $02, $02, $22, $02, $48
    db $02, $02, $00, $00, $02, $02, $02, $02
    db $48, $02, $02, $02, $02, $02, $00, $48
    db $02, $02, $02, $02, $02, $5C, $08, $08
    db $08, $02, $27, $02, $02, $02, $02, $02
    db $00, $00, $00, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $08, $02, $02, $02, $01, $01, $01
    db $48, $01, $01, $01, $01, $01, $01, $01
    db $22, $01, $01, $01, $01, $2B, $01, $01
    db $01, $00, $00, $00, $01, $01, $00, $02
    db $01, $48, $01, $00, $00, $00, $00, $48
    db $00, $00, $00, $00, $00, $00, $12, $01
    db $02, $48, $00, $00, $00, $00, $00, $01
    db $01, $01, $02, $01, $01, $00, $00, $02
    db $01, $01, $00, $02, $02, $01, $01, $01
    db $01, $00, $01, $01, $00, $00, $00, $01
    db $00, $48, $01, $02, $01, $01, $01, $01
    db $01, $01, $02, $01, $01, $02, $02, $01
    db $01, $01, $01, $01, $00, $02, $02, $02
    db $02, $01, $02, $01, $02, $02, $02, $00
    db $00, $01, $01, $01, $01, $00, $00, $00
    db $00, $01, $00, $00, $12, $01, $01, $02
    db $01, $01, $00, $01, $29, $01, $42, $02
    db $02, $01, $00, $02, $01, $01, $01, $02
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $00, $02, $02, $00
    db $00, $48, $48, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $48
    db $02, $02, $48, $00, $00, $00, $00, $00
    db $48, $01, $01, $48, $48, $01, $01, $00
    db $02, $02, $48, $02, $02, $01, $01, $02
    db $02, $42, $02, $02, $02, $27, $00, $01
    db $29, $01, $01, $01, $01, $00, $01, $01
    db $01, $00, $01, $01, $00, $01, $01, $01
    db $01, $01, $01, $01, $00, $00, $02, $00
    db $02, $01, $02, $02, $00, $00, $02, $01
    db $01, $01, $01, $01, $01, $02, $27, $27
    db $00, $27, $02, $00, $01, $00, $00, $00
    db $00, $00, $48, $00, $00, $00, $00, $00
    db $48, $01, $01, $01, $00, $01, $01, $01
    db $02, $02, $02, $48, $02, $02, $01, $00
    db $00, $48, $48, $00, $27, $27, $27, $48
    db $00, $27, $01, $01, $48, $00, $27, $01
    db $01, $48, $01, $01, $01, $01, $01, $27
    db $27, $12, $01, $02, $27, $01, $01, $01
    db $01, $01, $48, $27, $02, $01, $01, $01
    db $00, $12, $00, $29, $27, $01, $01, $01
    db $10, $02, $01, $01, $01, $02, $01, $01
    db $00, $00, $00, $02, $01, $00, $00, $00
    db $02, $01, $00, $00, $00, $00, $02, $02
    db $00, $00, $09, $00, $00, $48, $00, $02
    db $00, $00, $00, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $08, $5C, $09, $02, $02, $48, $48, $48
    db $48, $01, $01, $01, $12, $00, $00, $01
    db $01, $02, $01, $01, $01, $01, $02, $01
    db $1A, $02, $02, $00, $02, $02, $2B, $01
    db $01, $02, $01, $02, $01, $01, $02, $02
    db $02, $01, $02, $00, $02, $02, $2B, $02
    db $01, $01, $01, $02, $02, $01, $01, $22
    db $02, $01, $01, $02, $02, $02, $01, $22
    db $10, $01, $22, $00, $00, $00, $00, $00
    db $00, $01, $10, $01, $01, $22, $01, $00
    db $00, $00, $00, $01, $01, $01, $01, $00
    db $00, $00, $00, $01, $01, $01, $01, $01
    db $01, $01, $01, $00, $01, $00, $00, $00
    db $00, $48, $02, $02, $46, $46, $01, $01
    db $01, $22, $01, $01, $00, $02, $02, $02
    db $22, $02, $02, $01, $44, $00, $01, $01
    db $00, $00, $00, $00, $01, $00, $02, $00
    db $01, $02, $51, $02, $02, $02, $02, $00
    db $00, $12, $01, $01, $01, $02, $02, $01
    db $01, $01, $01, $01, $02, $01, $01, $02
    db $01, $01, $02, $01, $02, $02, $44, $01
    db $02, $02, $02, $02, $02, $00, $01, $08
    db $02, $02, $02, $00, $00, $00, $00, $00
    db $02, $48, $00, $00, $00, $02, $29, $00
    db $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $12, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $48, $00, $00, $48, $00
    db $00, $00, $00, $01, $48, $00, $12, $12
    db $1A, $12, $29, $01, $01, $01, $01, $00
    db $01, $01, $10, $48, $48, $48, $02, $48
    db $01, $01, $02, $01, $27, $01, $02, $02
    db $02, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $01, $27, $01, $01
    db $01, $01, $27, $27, $01, $02, $02, $01
    db $01, $27, $27, $02, $02, $01, $01, $01
    db $01, $02, $02, $01, $01, $01, $01, $02
    db $02, $02, $02, $02, $02, $02, $00, $48
    db $02, $02, $00, $02, $01, $00, $01, $02
    db $02, $02, $02, $01, $27, $02, $02, $01
    db $00, $01, $02, $02, $27, $02, $01, $01
    db $02, $02, $27, $02, $02, $01, $02, $02
    db $02, $02, $01, $01, $02, $02, $02, $02
    db $27, $02, $02, $02, $02, $02, $02, $44
    db $02, $01, $01, $02, $02, $02, $02, $01
    db $02, $02, $02, $27, $02, $02, $01, $02
    db $02, $02, $01, $01, $01, $02, $02, $01
    db $00, $01, $02, $02, $00, $20, $20, $20
    db $20, $02, $27, $27, $27, $00, $02, $00
    db $00, $02, $02, $02, $27, $27, $01, $01
    db $27, $27, $27, $27, $01, $02, $02, $01
    db $01, $02, $27, $02, $01, $27, $27, $27
    db $27, $00, $00, $02, $00, $27, $00, $00
    db $27, $27, $00, $27, $27, $02, $01, $02
    db $01, $01, $00, $02, $02, $48, $02, $10
    db $00, $02, $01, $02, $00, $00, $00, $00
    db $01, $00, $00, $02, $01, $02, $01, $01
    db $00, $00, $02, $08, $02, $00, $02, $09
    db $01, $02, $01, $01, $08, $01, $08, $01
    db $02, $12, $01, $02, $10, $12, $02, $02
    db $02, $01, $02, $02, $02, $02, $01, $08
    db $01, $00, $00, $00, $01, $01, $10, $01
    db $02, $08, $08, $09, $08, $02, $01, $01
    db $02, $01, $01, $00, $01, $02, $01, $42
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $01, $01, $01, $01, $42, $42, $01, $02
    db $02, $01, $02, $02, $02, $02, $01, $01
    db $01, $01, $01, $01, $01, $01, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $02, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $01, $01, $01
    db $01, $02, $22, $02, $01, $02, $02, $02
    db $01, $02, $02, $02, $22, $02, $02, $02
    db $01, $01, $02, $02, $01, $02, $02, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $00, $01, $01, $01, $01
    db $02, $02, $02, $02, $01, $01, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $00, $02, $00, $00
    db $00, $00, $00, $10, $02, $02, $02, $02
    db $02, $02, $02, $02, $01, $08, $08, $00
    db $01, $02, $02, $02, $02, $01, $02, $01
    db $22, $01, $01, $02, $02, $18, $01, $01
    db $01, $02, $02, $02, $02, $02, $02, $02
    db $01, $02, $02, $02, $02, $02, $02, $42
    db $02, $01, $02, $02, $02, $02, $02, $48
    db $48, $48, $48, $00, $02, $01, $00, $02
    db $02, $27, $27, $01, $00, $27, $02, $00
    db $02, $00, $00, $02, $02, $00, $00, $02
    db $01, $02, $27, $00, $00, $02, $00, $01
    db $01, $29, $00, $02, $00, $10, $01, $00
    db $12, $00, $00, $01, $01, $48, $02, $02
    db $00, $00, $02, $02, $00, $02, $02, $00
    db $00, $00, $02, $02, $00, $02, $00, $00
    db $00, $02, $00, $02, $00, $00, $00, $02
    db $00, $00, $00, $02, $00, $02, $00, $00
    db $00, $02, $00, $02, $02, $00, $00, $00
    db $00, $02, $00, $01, $09, $10, $27, $44
    db $02, $01, $00, $00, $02, $02, $02, $01
    db $01, $02, $02, $00, $01, $01, $01, $48
    db $00, $01, $00, $00, $01, $01, $00, $48
    db $48, $00, $02, $02, $02, $02, $02, $02
    db $00, $02, $00, $02, $02, $02, $00, $02
    db $48, $00, $01, $48, $48, $00, $01, $48
    db $01, $01, $01, $01, $01, $02, $02, $01
    db $01, $01, $01, $00, $02, $48, $02, $48
    db $01, $48, $01, $48, $00, $02, $02, $02
    db $01, $01, $02, $01, $01, $01, $00, $00
    db $01, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $01, $01, $01, $02, $22, $00
    db $02, $01, $01, $01, $02, $01, $44, $01
    db $01, $02, $00, $01, $02, $22, $01, $02
    db $42, $22, $02, $02, $01, $01, $02, $02
    db $02, $01, $01, $01, $01, $02, $02, $01
    db $01, $02, $01, $01, $02, $02, $01, $01
    db $01, $02, $01, $01, $02, $02, $43, $02
    db $02, $02, $02, $02, $01, $02, $02, $01
    db $01, $01, $02, $02, $01, $01, $01, $02
    db $02, $02, $01, $02, $43, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $00, $01
    db $00, $00, $00, $01, $01, $00, $01, $01
    db $01, $01, $01, $01, $02, $48, $02, $02
    db $01, $00, $00, $00, $02, $43, $00, $02
    db $01, $00, $00, $01, $01, $00, $00, $02
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $02, $02
    db $02, $01, $01, $01, $01, $01, $02, $02
    db $01, $02, $02, $01, $01, $42, $01, $02
    db $02, $01, $02, $00, $02, $01, $02, $01
    db $00, $01, $01, $00, $00, $02, $01, $01
    db $02, $02, $02, $02, $01, $00, $01, $02
    db $01, $01, $01, $01, $01, $01, $00, $00
    db $01, $01, $01, $00, $00, $48, $00, $00
    db $00, $01, $01, $01, $02, $02, $01, $01
    db $02, $02, $01, $02, $02, $01, $01, $01
    db $01, $01, $01, $00, $48, $00, $48, $00
    db $00, $00, $01, $01, $01, $01, $01, $00
    db $00, $01, $00, $00, $00, $00, $01, $02
    db $01, $00, $02, $27, $00, $01, $01, $01
    db $01, $00, $02, $00, $01, $02, $00, $01
    db $01, $01, $02, $00, $02, $01, $02, $01
    db $01, $01, $27, $00, $09, $09, $00, $09
    db $02, $1A, $10, $01, $01, $01, $01, $00
    db $00, $48, $09, $09, $02, $00, $09, $09
    db $02, $09, $09, $01, $02, $02, $09, $09
    db $09, $42, $09, $01, $02, $09, $02, $02
    db $02, $02, $02, $09, $09, $09, $09, $02
    db $09, $02, $09, $01, $01, $01, $09, $09
    db $09, $09, $09, $00, $00, $02, $09, $02
    db $02, $02, $09, $00, $00, $02, $48, $09
    db $09, $09, $09, $00, $00, $02, $09, $09
    db $02, $09, $00, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $01, $02, $00, $02
    db $02, $00, $00, $00, $00, $00, $00, $09
    db $48, $09, $01, $01, $02, $02, $02, $01
    db $02, $48, $00, $00, $48, $00, $00, $00
    db $00, $12, $09, $09, $02, $02, $09, $02
    db $01, $02, $02, $09, $02, $12, $01, $12
    db $02, $01, $01, $00, $00, $10, $01, $00
    db $01, $1A, $01, $02, $01, $01, $18, $00
    db $00, $00, $00, $01, $08, $01, $09, $00
    db $09, $09, $00, $09, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $02, $02, $02, $00, $09, $00, $01, $01
    db $01, $02, $02, $01, $00, $00, $01, $02
    db $02, $02, $00, $09, $01, $01, $01, $01
    db $02, $02, $00, $01, $02, $02, $01, $01
    db $02, $01, $01, $02, $00, $02, $22, $09
    db $00, $00, $00, $01, $00, $02, $00, $00
    db $48, $48, $48, $09, $09, $09, $09, $42
    db $02, $09, $09, $02, $09, $01, $09, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $00, $00, $00, $00, $01, $01
    db $22, $22, $01, $01, $00, $02, $00, $02
    db $02, $02, $09, $01, $02, $01, $01, $01
    db $01, $02, $02, $02, $02, $00, $02, $02
    db $00, $01, $08, $02, $00, $12, $01, $01
    db $01, $01, $01, $01, $01, $01, $02, $01
    db $01, $02, $02, $02, $02, $02, $01, $02
    db $01, $01, $01, $01, $02, $02, $02, $01
    db $02, $01, $01, $01, $01, $01, $01, $02
    db $01, $01, $01, $00, $01, $01, $02, $01
    db $01, $01, $01, $01, $01, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $48, $48, $02, $00, $02, $02, $02
    db $02, $02, $02, $02, $01, $01, $02, $02
    db $02, $02, $01, $01, $48, $00, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $48
    db $02, $02, $02, $02, $02, $02, $00, $02
    db $00, $00, $02, $02, $00, $02, $00, $02
    db $00, $02, $02, $00, $02, $02, $02, $02
    db $02, $00, $00, $02, $02, $48, $02, $02
    db $02, $02, $02, $02, $42, $42, $02, $02
    db $02, $02, $02, $22, $22, $22, $02, $02
    db $08, $00, $02, $22, $22, $22, $02, $08
    db $02, $02, $02, $02, $00, $02, $02, $02
    db $02, $00, $01, $01, $01, $01, $02, $02
    db $02, $01, $01, $02, $01, $00, $01, $02
    db $01, $01, $02, $00, $02, $00, $00, $01
    db $02, $02, $02, $00, $01, $01, $01, $00
    db $01, $02, $02, $01, $02, $02, $01, $00
    db $01, $02, $01, $02, $02, $02, $00, $02
    db $02, $00, $00, $48, $09, $09, $09, $00
    db $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $08, $09, $08, $00, $00, $02
    db $02, $02, $02, $09, $5C, $08, $00, $00
    db $02, $02, $00, $02, $02, $5C, $09, $10
    db $09, $09, $27, $27, $27, $09, $00, $5C
    db $02, $00, $00, $02, $01, $00, $00, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $01, $00, $00
    db $00, $09, $09, $09, $09, $09, $00, $00
    db $09, $09, $09, $48, $09, $09, $09, $09
    db $09, $09, $00, $09, $09, $09, $48, $00
    db $00, $00, $02, $2E, $28, $2B, $2A, $01
    db $01, $00, $01, $01, $01, $01, $01, $02
    db $01, $22, $01, $01, $22, $01, $02, $01
    db $01, $01, $01, $01, $00, $2E, $22, $2F
    db $29, $02, $01, $01, $01, $01, $01, $01
    db $1A, $1A, $1A, $1A, $1A, $1A, $1A, $01
    db $01, $12, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $12, $01, $02, $02, $01
    db $01, $02, $02, $02, $12, $02, $02, $01
    db $01, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $00, $00, $01, $01, $00, $00
    db $01, $01, $01, $01, $02, $02, $01, $01
    db $00, $00, $01, $01, $02, $02, $00, $00
    db $00, $00, $00, $00, $00, $48, $00, $48
    db $48, $48, $48, $00, $20, $00, $00, $00
    db $48, $02, $01, $02, $42, $02, $02, $02
    db $42, $02, $02, $02, $42, $02, $20, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $09
    db $09, $09, $00, $00, $09, $00, $09, $00
    db $00, $00, $00, $00, $00, $09, $00, $00
    db $00, $48, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $02, $02, $01, $02, $02
    db $22, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $02, $01, $01, $01
    db $22, $00, $00, $01, $01, $01, $22, $01
    db $44, $44, $29, $22, $00, $00, $00, $00
    db $00, $01, $48, $02, $02, $02, $01, $01
    db $02, $02, $01, $20, $02, $27, $22, $00
    db $00, $20, $20, $20, $20, $00, $20, $00
    db $09, $02, $02, $09, $01, $01, $02, $02
    db $09, $01, $01, $01, $09, $02, $02, $09
    db $02, $01, $02, $01, $02, $01, $01, $01
    db $01, $01, $02, $01, $09, $02, $02, $09
    db $02, $01, $02, $01, $02, $01, $01, $01
    db $02, $01, $02, $01, $02, $02, $09, $02
    db $02, $02, $02, $02, $44, $02, $02, $44
    db $44, $02, $22, $44, $43, $02, $22, $43
    db $01, $01, $01, $01, $01, $22, $01, $01
    db $01, $02, $02, $22, $00, $02, $02, $22
    db $02, $22, $02, $22, $02, $22, $02, $22
    db $02, $22, $01, $01, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
}

; ==============================================================================

; $0DFFC0-$0DFFFF NULL
Pool_Null:
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

; ==============================================================================

warnpc $1C8000