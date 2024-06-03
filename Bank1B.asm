; ==============================================================================

; Bank 1B
; $0D8000-$0DFFFF
org $1B8000

; SPC Data
; Entrance code
; Tile interatction

; ==============================================================================

; $0D8000-$0DB1D6 - tail end of the music (SPC) data
SongBank_Underworld_Main:
{
    dw $2CBF, SONG_POINTERS ; Transfer size, transfer address

    base SONG_POINTERS

    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw Song0B_FairyTheme
    dw $0000
    dw $0000
    dw $0000
    dw $0000
    dw Song10_HyruleCastle
    dw Song11_PendantDungeon
    dw Song12_Cave
    dw Song13_Fanfare
    dw Song14_Sanctuary
    dw Song15_Boss
    dw Song16_CrystalDungeon
    dw Song17_Shop
    dw Song12_Cave
    dw Song19_ZeldaRescue
    dw Song1A_CrystalMaiden
    dw Song1B_BigFairy
    dw Song1C_Suspense
    dw Song1D_AgahnimEscapes
    dw Song1E_MeetingGanon
    dw Song1F_KingOfThieves
    dw $0000
    dw Song1D_AgahnimEscapes
    dw Song1E_MeetingGanon
    dw Song1F_KingOfThieves
}

; $0D804A-$0D8BEF DATA
Song10_HyruleCastle:
{
    incbin "bin/music/song10.bin" ; size: 0x0BA6
}

; $0D8BF0-$0D913D DATA
Song11_PendantDungeon:
{
    incbin "bin/music/song11.bin" ; size: 0x054E
}

; $0D913E-$0D9434 DATA
Song12_Cave:
{
    incbin "bin/music/song12.bin" ; size: 0x02F7
}

; $0D9435-$0D96FC DATA
Song13_Fanfare:
{
    incbin "bin/music/song13.bin" ; size: 0x02C8
}

; $0D96FD-$0D9921 DATA
Song14_Sanctuary:
{
    incbin "bin/music/song14.bin" ; size: 0x0225
}

; $0D9922-$0D9C0E DATA
Song15_Boss:
{
    incbin "bin/music/song15.bin" ; size: 0x02ED
}

; $0D9C0F-$0DA1D4 DATA
Song16_CrystalDungeon:
{
    incbin "bin/music/song16.bin" ; size: 0x05C6
}

; $0DA1D5-$0DA307 DATA
Song17_Shop:
{
    incbin "bin/music/song17.bin" ; size: 0x0133
}

; $0DA308-$0DA583 DATA
Song19_ZeldaRescue:
{
    incbin "bin/music/song19.bin" ; size: 0x027C
}

; $0DA584-$0DA90C DATA
Song1A_CrystalMaiden:
{
    incbin "bin/music/song1A.bin" ; size: 0x0389
}

; $0DA90D-$0DAB6D DATA
Song1B_BigFairy:
{
    incbin "bin/music/song1B.bin" ; size: 0x0261
}

; $0DAB6E-$0DACC3 DATA
Song1C_Suspense:
{
    incbin "bin/music/song1C.bin" ; size: 0x0155
}

base off

; ==============================================================================

SongBank_Underworld_Auxiliary:
#_1BACC3: dw $050C, SONG_POINTERS_AUX ; Transfer size, transfer address

base SONG_POINTERS_AUX

; $0DACC7-0DAD79 DATA
Song1D_AgahnimEscapes:
{
    incbin "bin/music/song1D.bin" ; size: 0x00B3
}

; $0DAD7A-0DB11F DATA
Song1F_KingOfThieves:
{
    incbin "bin/music/song1F.bin" ; size: 0x03A6
}

; $0DB120-$0DB1D6 DATA
Song1E_MeetingGanon:
{
    incbin "bin/music/song1E.bin" ; size: 0x00B3

    base off

    ; $0DB1D3
    dw $0000, SPC_ENGINE ; end of transfer
}

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
    ; $0DB800 - Map16 coordinates for holes.
    .map16
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

; ==============================================================================

; $0DB860-$0DB8BE LONG JUMP LOCATION
Overworld_Hole:
{
    ; Routine used to find the entrance to send Link to when he falls into a
    ; hole.
    
    PHB : PHK : PLB
    
    REP #$31
    
    LDA.b $20 : AND.w #$FFF8 : STA.b $00
    SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
    
    LDA.b $22 : AND.w #$FFF8 : LSR #3 : STA.b $02
    SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $06 : STA.b $00
    
    LDX.w #$0024

    .nextHole

        LDA.b $00 : CMP .map16, X : BNE .wrongMap16
            LDA.w $040A : CMP .area, X : BEQ .matchedHole
                .wrongMap16
    DEX #2 : BPL .nextHole
    
    ; Send us to the Chris Houlihan room        
    LDX.w #$0026
    
    SEP #$20
    
    ; Put Link in the Light World
    LDA.b #$00 : STA.l $7EF3CA

    .matchedHole

    SEP #$30
    
    TXA : LSR A : TAX
    
    ; Set an entrance index...
    LDA .entrance, X : STA.w $010E : STZ.w $010F
    
    PLB
    
    RTL
}

; $0DB8BF-$0DBBF3 - chr types indicating door entrances left
Pool_Overworld_Entrance:
{
    ; $0DB8BF
    .ValidDoorTypes_low
    dw $00FE, $00C5, $00FE, $0114
    dw $0115, $0175, $0156, $00F5
    dw $00E2, $01EF, $0119, $00FE
    dw $0172, $0177, $013F, $0172
    dw $0112, $0161, $0172, $014C
    dw $0156, $01EF, $00FE, $00FE
    dw $00FE, $010B, $0173, $0143
    dw $0149, $0175, $0103, $0100
    dw $01CC, $015E, $0167, $0128
    dw $0131, $0112, $016D, $0163
    dw $0173, $00FE, $0113, $0177
    
    ; $0DB917 chr types indicating door entrances right
    .ValidDoorTypes_high
    dw $014A, $00C4, $014F, $0115
    dw $0114, $0174, $0155, $00F5
    dw $00EE, $01EB, $0118, $0146
    dw $0171, $0155, $0137, $0174
    dw $0173, $0121, $0164, $0155
    dw $0157, $0128, $0114, $0123
    dw $0113, $0109, $0118, $0161
    dw $0149, $0117, $0174, $0101
    dw $01CC, $0131, $0051, $014E
    dw $0131, $0112, $017A, $0163
    dw $0172, $01BD, $0152, $0167

    ; $0DB96F Area list for entrances
    .EntranceScreens
    dw $002C ; 0x00 - OW 2C - Link's house
    dw $0013 ; 0x01 - OW 13 - Sanctuary
    dw $001B ; 0x02 - OW 1B - Castle west wing
    dw $001B ; 0x03 - OW 1B - Castle lobby
    dw $001B ; 0x04 - OW 1B - Castle east wing
    dw $000A ; 0x05 - OW 0A - Old man cave west
    dw $0003 ; 0x06 - OW 03 - Old man cave east
    dw $001E ; 0x07 - OW 1E - Eastern Palace
    dw $0030 ; 0x08 - OW 30 - Desert Palace lobby
    dw $0030 ; 0x09 - OW 30 - Desert Palace east
    dw $0030 ; 0x0A - OW 30 - Desert Palace west
    dw $0030 ; 0x0B - OW 30 - Desert Palace back
    dw $0018 ; 0x0C - OW 18 - Sahasrahla's house west
    dw $0018 ; 0x0D - OW 18 - Sahasrahla's house east
    dw $0028 ; 0x0E - OW 28 - Angry bro west
    dw $0029 ; 0x0F - OW 29 - Angry bro east
    dw $0022 ; 0x10 - OW 22 - Magic bat
    dw $0002 ; 0x11 - OW 02 - Lumberjack cave
    dw $0045 ; 0x12 - OW 45 - Super bunny bottom
    dw $0045 ; 0x13 - OW 45 - Super bunny top
    dw $0045 ; 0x14 - OW 45 - Turtle Rock laser pots
    dw $004A ; 0x15 - OW 4A - Bumper cave bottom
    dw $004A ; 0x16 - OW 4A - Bumper cave top
    dw $0045 ; 0x17 - OW 45 - Turtle Rock laser bridge
    dw $0045 ; 0x18 - OW 45 - Turtle Rock big chest
    dw $0005 ; 0x19 - OW 05 - East Death Mountain useless bottom
    dw $0005 ; 0x1A - OW 05 - East Death Mountain useless top
    dw $0005 ; 0x1B - OW 05 - Spiral cave exit
    dw $0005 ; 0x1C - OW 05 - Spiral cave top
    dw $0005 ; 0x1D - OW 05 - Paradox cave bottom
    dw $0005 ; 0x1E - OW 05 - Paradox cave middle
    dw $0005 ; 0x1F - OW 05 - Paradox cave top
    dw $0003 ; 0x20 - OW 03 - Kiki cave west
    dw $0003 ; 0x21 - OW 03 - Kiki cave east
    dw $0003 ; 0x22 - OW 03 - Spectacle rock
    dw $001B ; 0x23 - OW 1B - Agahnim's Tower
    dw $007B ; 0x24 - OW 7B - Swamp Palace
    dw $005E ; 0x25 - OW 5E - Palace of Darkness
    dw $0070 ; 0x26 - OW 70 - Misery Mire
    dw $0040 ; 0x27 - OW 40 - Skull Woods west
    dw $0040 ; 0x28 - OW 40 - Skull Woods mummy statue
    dw $0040 ; 0x29 - OW 40 - Skull Woods big chest
    dw $0040 ; 0x2A - OW 40 - Skull Woods back
    dw $0000 ; 0x2B - OW 00 - Lost Woods hideout
    dw $0075 ; 0x2C - OW 75 - Ice Palace
    dw $000A ; 0x2D - OW 0A - Death Mountain exit west
    dw $0003 ; 0x2E - OW 03 - Death Mountain exit from summit
    dw $0003 ; 0x2F - OW 03 - Old man home cave west
    dw $0003 ; 0x30 - OW 03 - Old man home cave east
    dw $001B ; 0x31 - OW 1B - Hyrule Castle secret entrance
    dw $0003 ; 0x32 - OW 03 - Tower of Hera
    dw $0058 ; 0x33 - OW 58 - Thieves' Town
    dw $0047 ; 0x34 - OW 47 - Turtle Rock
    dw $005B ; 0x35 - OW 5B - Pyramid drop
    dw $0043 ; 0x36 - OW 43 - Ganon's Tower
    dw $0015 ; 0x37 - OW 15 - Graveyard fairy
    dw $0018 ; 0x38 - OW 18 - Kakariko well
    dw $0045 ; 0x39 - OW 45 - Hookshot cave bottom
    dw $0045 ; 0x3A - OW 45 - Hookshot cave top
    dw $0000 ; 0x3B - OW 00 - Lost Woods chest game
    dw $0074 ; 0x3C - OW 74 - Swamp thief cave hideout
    dw $0018 ; 0x3D - OW 18 - Eastern snitch house
    dw $0018 ; 0x3E - OW 18 - Cucco easter egg
    dw $0018 ; 0x3F - OW 18 - Sick kid
    dw $0043 ; 0x40 - OW 43 - Spike cave
    dw $0018 ; 0x41 - OW 18 - Tavern front
    dw $0018 ; 0x42 - OW 18 - Tavern back
    dw $0018 ; 0x43 - OW 18 - Kakariko Inn
    dw $001E ; 0x44 - OW 1E - Sahasrahla's hideout
    dw $0018 ; 0x45 - OW 18 - Kakariko shop
    dw $0058 ; 0x46 - OW 58 - Village of Outcasts chest game
    dw $0058 ; 0x47 - OW 58 - Village of Outcasts bombable hut
    dw $0029 ; 0x48 - OW 29 - Library
    dw $0018 ; 0x49 - OW 18 - Kakariko bombable hut
    dw $0018 ; 0x4A - OW 18 - Chicken hut
    dw $0016 ; 0x4B - OW 16 - Potion shop
    dw $0030 ; 0x4C - OW 30 - Aginah's cave
    dw $003B ; 0x4D - OW 3B - Dam
    dw $0005 ; 0x4E - OW 05 - Mimic cave
    dw $0005 ; 0x4F - OW 05 - East Death Mountain fairy pond cave
    dw $0032 ; 0x50 - OW 32 - Circle of bushes heart piece cave
    dw $0014 ; 0x51 - OW 14 - Graveyard ledge heart piece cave
    dw $006C ; 0x52 - OW 6C - Bomb shop
    dw $0058 ; 0x53 - OW 58 - C-shaped house
    dw $002F ; 0x54 - OW 2F - Southeast of Eastern Ruins fairy cave
    dw $0070 ; 0x55 - OW 70 - Mire big fairy
    dw $0042 ; 0x56 - OW 42 - Dark World lumberjacks shop
    dw $0035 ; 0x57 - OW 35 - Lake Hylia shop
    dw $0069 ; 0x58 - OW 69 - Arrow game
    dw $0053 ; 0x59 - OW 53 - Dark World sanctuary cave
    dw $0014 ; 0x5A - OW 14 - King's tomb
    dw $000F ; 0x5B - OW 0F - Waterfall of Wishing
    dw $0035 ; 0x5C - OW 35 - Pond of Happiness
    dw $002E ; 0x5D - OW 2E - Big fairy (Eastern Ruins)
    dw $0070 ; 0x5E - OW 70 - Mire shed
    dw $0058 ; 0x5F - OW 58 - Village of Outcasts shop
    dw $0018 ; 0x60 - OW 18 - Blind's hut
    dw $0070 ; 0x61 - OW 70 - Watto's cave
    dw $005B ; 0x62 - OW 5B - Fat Fairy
    dw $0022 ; 0x63 - OW 22 - Smithy's house
    dw $0011 ; 0x64 - OW 11 - Light World fortune teller (Kakariko)
    dw $0051 ; 0x65 - OW 51 - Dark World fortune teller
    dw $0029 ; 0x66 - OW 29 - South of Kakariko chest game
    dw $005E ; 0x67 - OW 5E - Broccoli's house
    dw $006F ; 0x68 - OW 6F - Bird hint NPC cave
    dw $0077 ; 0x69 - OW 77 - Hamburger Helper's cave
    dw $0037 ; 0x6A - OW 37 - Ice rod cave golden bee
    dw $0034 ; 0x6B - OW 34 - Big fairy (South of Link's house)
    dw $006E ; 0x6C - OW 6E - Big fairy (South of Kiki)
    dw $0045 ; 0x6D - OW 45 - Dark Death Mountain shop
    dw $0056 ; 0x6E - OW 56 - Dark World witch shop
    dw $0043 ; 0x6F - OW 43 - Dark West Death Mountain big fairy
    dw $0030 ; 0x70 - OW 30 - Aginah's cave
    dw $003A ; 0x71 - OW 3A - Desert big fairy
    dw $0035 ; 0x72 - OW 35 - Light World fortune teller (Lake Hylia)
    dw $0075 ; 0x73 - OW 75 - Dark Lake Hylia shop
    dw $005A ; 0x74 - OW 5A - East of Village of Outcasts shop
    dw $0002 ; 0x75 - OW 02 - Bumpkin residency
    dw $002B ; 0x76 - OW 2B - Link's house bonk rocks fairy pond
    dw $006B ; 0x77 - OW 6B - Bomb shop bonk rocks fairy pond
    dw $003A ; 0x78 - OW 3A - Desert thief hideout
    dw $0013 ; 0x79 - OW 13 - Bonk rocks heart piece cave
    dw $0037 ; 0x7A - OW 37 - Lake Hylia falls thief hideout
    dw $0077 ; 0x7B - OW 77 - Dark Lake Hylia falls spike cave
    dw $0035 ; 0x7C - OW 35 - Mini moldorm cave
    dw $0030 ; 0x7D - OW 30 - Checkerboard cave heart piece
    dw $0062 ; 0x7E - OW 62 - Stake puzzle heart piece cave
    dw $0037 ; 0x7F - OW 37 - Ice rod cave
    dw $0077 ; 0x80 - OW 77 - Dark ice rod big fairy
    
    ; $0DBA71 - Map16 list for entrances
    .EntranceTileIndex
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
    
    LDA.l $0F8002, X : AND.w #$41FF : CMP.w #$00E9 : BEQ .BRANCH_BETA
        CMP.w #$0149 : BEQ .BRANCH_GAMMA
        CMP.w #$0169 : BEQ .BRANCH_GAMMA
            TYX
            
            LDA.l $7E2002, X : ASL #3 : TAX
            
            LDA.l $0F8000, X : AND.w #$41FF : CMP.w #$4149 : BEQ .BRANCH_DELTA
                CMP.w #$4169 : BEQ .BRANCH_DELTA
                    CMP.w #$40E9 : BNE .BRANCH_EPSILON
                        DEY #2
        
    .BRANCH_BETA
    
    ; This section opens a normal door on the overworld
    ; It replaces the existing tiles with an open door set of tiles
    
    TYX
    
    LDA.w #$0DA4
    
    JSL Overworld_DrawPersistentMap16
    
    LDA.w #$0DA6 : STA.l $7E2002, X
    
    LDY.w #$0002
    
    JSL Overworld_DrawMap16_Anywhere
    
    SEP #$30
    
    ; Play a sound effect
    LDA.b #$15 : STA.w $012F
    
    ; Make sure to update the tilemap
    LDA.b #$01 : STA.b $14
    
    RTL
    
    .notFacingUp
    
    BRA .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    DEY #2
    
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
    
    LDA.l $0F8004, X : AND.w #$01FF : STA.b $00
    LDA.l $0F8006, X : AND.w #$01FF : STA.b $02
    
    LDX.w #$0056
    
    .loop
    
        LDA.b $00 : CMP.l $1BB8BF, X : BNE .BRANCH_ZETA
            LDA.b $02 : CMP.l $1BB917, X : BEQ .BRANCH_KAPPA
        
        .BRANCH_ZETA
    DEX #2 : BPL .loop
    
    STZ.w $04B8
    
    .BRANCH_MU
    
        SEP #$30
        
        RTL
        
        .BRANCH_LAMBDA
    LDA.w $04B8 : BNE .BRANCH_MU
    
    INC.w $04B8
    
    ; "You can't enter with something following you" (this variable holds the message index.)
    LDA.w #$0005 : STA.w $1CF0
    
    SEP #$30
    
    JML Main_ShowTextMessage
    
    .BRANCH_KAPPA
    
    TYA : STA.b $00
    
    ; Number of entrance entries * 2
    LDX.w #$0102
    
    .BRANCH_PI
    
        LDA.b $00
        
        .BRANCH_OMICRON
        
            DEX #2 : BMI .BRANCH_XI
        CMP.l $1BBA71, X : BNE .BRANCH_OMICRON
    LDA.w $040A : CMP.l $1BB96F, X : BNE .BRANCH_PI
    
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

    TXA : LSR A : TAX
    
    SEP #$30
    
    LDA.l $1BBB73, X : STA.w $010E
    
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

; $0DBD7A-$0DBF1D LONG JUMP LOCATION
Overworld_Map16_ToolInteraction:
{
    ; Handles Map16 interactions with sword, hammer, shovel, magic powder, etc
    
    LDA.b $1B : BEQ .outdoors ; Yes... branch
        JML Dungeon_ToolAndTileInteraction
    
    .outdoors
    
    REP #$30
    
    ; Zero out ??? affected when dashing apparently, Zero out tile interaction
    STZ.w $04B2 : STZ.b $76
    
    LDA.b $00 : SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
    
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
            
            JMP .isBush2
    
    ; HAMMER TIME!
    .usingHammer
    
    ; Is it a peg to be pounded down?
    LDA.l $7E2000, X : PHA : CMP.w #$021B : BNE .notPeg
        SEP #$20
        
        ; Play the peg gettin' knocked down sound.
        LDA.b #$11 : STA.w $012E
        
        REP #$20
        
        JSL HandlePegPuzzles
        
        ; Choose the map16 tile with the "peg pounded down" tile
        LDA.w #$0DCB
        
        JMP .noSecret
    
    .notPeg
    
    JSR Overworld_HammerSfx
    
    .notBush
    
    JMP .return
    
    .notUsingMagicPowder
    
    ; Normal tile interactions
    LDA.l $7E2000, X : PHA
    
    CMP.w #$0034 : BEQ .shovelable   ; normal blank green ground
    CMP.w #$0071 : BEQ .shovelable   ; non thick grass
    CMP.w #$0035 : BEQ .shovelable   ; non thick grass
    CMP.w #$010D : BEQ .shovelable   ; non thick grass
    CMP.w #$010F : BEQ .shovelable   ; non thick grass
    CMP.w #$00E1 : BEQ .shovelable   ; animated flower tile
    CMP.w #$00E2 : BEQ .shovelable   ; animated flower tile
    CMP.w #$00DA : BEQ .shovelable   ; non thick grass
    CMP.w #$00F8 : BEQ .shovelable   ; non thick grass
    CMP.w #$010E : BEQ .shovelable   ; non thick grass
        CMP.w #$037E : BEQ .isThickGrass ; thick grass
            LDY.w #$0002
            
            ; normal bush
            CMP.w #$0036 : BEQ .isBush2
                LDY.w #$0004
                    ; off color bush
                    CMP.w #$072A : BEQ .isBush2
                        .notShoveling
                        
                        JMP .return
    
    .shovelable
    
    ; Is Link shoveling?
    LDA.w $037A : AND.w #$00FF : CMP.w #$0001 : BNE .notShoveling
    
    ; Is this the forest grove?
    LDA.b $8A : CMP.w #$002A : BNE .notFluteLocation
        ; Is it that one special spot the flute is at?
        CPX.w #$0492 : BNE .notFluteLocation
            STX.w $04B2
    
    .notFluteLocation
    
    ; replacement tile after you shovel out the ground
    LDY.w #$0DC9
    
    BRA .checkForSecret
    
    .isThickGrass
    
    LDA.w $037A : AND.w #$00FF : CMP.w #$0001 : BNE .notShoveling2
        JMP .return
    
    .notShoveling2
    
    LDA.b $02 : ASL #3 : SEC : SBC.w #$0008 : PHA
    LDA.b $00 : SEC : SBC.w #$0008 : AND.w #$FFF8 : STA.b $74
    
    ; Why was it pushed in the first place? -____-
    PLA : STA.b $72
    
    LDA.w #$0003 : STA.b $76
    
    LDY.w #$0DC5
    
    BRA .checkForSecret
    
    ; $0DBE8D ALTERNATE ENTRY POINT
    .isBush2
    
    LDA.w $037A : AND.w #$00FF : CMP.w #$0001 : BEQ .shoveling
        LDA.b $02 : AND.w #$FFFE : ASL #3 : PHA
        
        LDA.b $00 : AND.w #$FFF0 : STA.b $74
        
        ; again... why?
        PLA : STA.b $72
        
        STY.b $76
        
        PLA : PHA
        
        LDY.w #$0DC7
        
        CMP.w #$072A : BNE .notOffColorBush
            ; use a different replacement map16 tile for the off color bushes
            LDY.w #$0DC8
        
        .notOffColorBush
        .checkForSecret
        
        STY.b $0E
        
        ; check for secrets under the bush?
        JSR Overworld_RevealSecret : BCS .noSecret
            ; if there's a secret under the bush, like a hole or a cave
            ; it would require a different replacement map16 tile
            LDA.b $0E
        
        .noSecret
        
        STA.l $7E2000, X
        
        JSL Overworld_Memorize_Map16_Change
        JSL Overworld_DrawMap16
        
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
    
    ASL #2 : STA.b $06
    
    LDA.b $00 : AND.w #$0008 : LSR #2 : TSB.b $06
    
    LDA.b $02 : AND.w #$0001 : ORA.b $06 : ASL A : TAX
    
    LDA.l $0F8000, X : AND.w #$01FF : TAX
    
    LDA Overworld_TileAttr, X : PHA
    
    LDA.b $72 : STA.b $00
    LDA.b $74 : STA.b $02
    
    SEP #$30
    
    LDA.b $76 : BEQ .noAncilla
        JSL Sprite_SpawnImmediatelySmashedTerrain
        JSL AddDisintegratingBushPoof
    
    .noAncilla
    
    REP #$30
    
    PLA
    
    .return
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $0DBF1E-$0DBF4B LOCAL JUMP LOCATION
Overworld_HammerSfx:
{
    ASL #3 : TAX
    
    LDA.l $0F8000, X : AND.w #$01FF : TAX
    
    LDA Overworld_TileAttr, X
    
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
    dw    0 ; from top left
    dw   -2 ; from top right
    dw -128 ; from bottom left
    dw -130 ; from bottom right
    
    ; $0DBF54
    dw    0 ; from top left
    dw    0 ; from top right
    dw -128 ; from bottom left
    dw -128 ; from bottom right
    
    ; $0DBF5C
    dw    0 ; from top left
    dw   -2 ; from top right
    dw    0 ; from bottom left
    dw   -2 ; from bottom right
}

; ==============================================================================

; $0DBF64-$0DBF9C LOCAL JUMP LOCATION
Overworld_GetLinkMap16Coords:
{
    LDA.b $2F : AND.w #$00FF : TAX

    LDA.b $20    : CLC : ADC.l $07D365, X : AND.w #$FFF0  : STA.b $00
    SEC : SBC.w $0708 : AND.w $070A       : ASL #3        : STA.b $06

    LDA.b $22 : CLC : ADC.l $07D36D, X : AND.w #$FFF0 : STA.b $02
    LSR #3  : SEC : SBC.w $070C      : AND.w $070E    : CLC : ADC.b $06 : TAX
    
    RTS
}

; ==============================================================================

; $0DBF9D-$0DC054 LONG JUMP LOCATION
Overworld_LiftableTiles:
{
    ; Handles Map16 tiles that are liftable.
    
    REP #$30
    
    JSR Overworld_GetLinkMap16Coords
    
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
            ; ditto
            CMP.w #$0374 : BEQ .liftingLargeRock
                INY
                ; ditto
                CMP.w #$0375 : BEQ .liftingLargeRock
                    LDY.w #$0000
                    ; dark colored big rock?
                    CMP.w #$023B : BEQ .liftingLargeRock
                        INY
                        ; same
                        CMP.w #$023C : BEQ .liftingLargeRock
                            INY
                            ; same
                            CMP.w #$023D : BEQ .liftingLargeRock
                                ; same
                                CMP.w #$023E : BNE .notLiftingRock
                                    INY
    
    .liftingLargeRock
    
    JMP Overworld_SmashRockPile_isRockPile
    
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
    
    JSR Overworld_RevealSecret : BCS .noSecret
        LDA.b $0E
    
    .noSecret
    
    STA.l $7E2000, X
    
    JSL Overworld_Memorize_Map16_Change
    JSL Overworld_DrawMap16
    
    SEP #$20
    
    LDA.b #$01 : STA.b $14
    
    ; $0DC024 ALTERNATE ENTRY POINT
    .getTileAttribute
    
    REP #$30
    
    PLA
    
    .notLiftingSmallObject
    
    ASL #2 : STA.b $06
    
    LDA.b $02 : AND.w #$0008 : LSR #2 : TSB.b $06
    
    LDA.b $00 : LSR #3 : AND.w #$0001 : ORA.b $06 : ASL A : TAX
    
    LDA.l $0F8000, X : AND.w #$01FF : TAX
    
    PLA : STA.b $00
    PLA : STA.b $02
    
    LDA Overworld_TileAttr, X
    
    SEP #$31
    
    RTL
}

; ==============================================================================

; $0DC055-$0DC062 BRANCH LOCATION
Overworld_SmashRockPile:
{
    .checkForBush
    
    LDY.w #$0DC7
    ; check if the map16 tile is a bush
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
    
    JSR Overworld_GetLinkMap16Coords
    
    PLA : STA.b $20
    
    BRA Overworld_SmashRockPileFromHere_continue
}

; $0DC076-$0DC0F7 LONG JUMP LOCATION
Overworld_SmashRockPileFromHere:
{
    REP #$30
    
    JSR Overworld_GetLinkMap16Coords
    
    .continue
    
    LDA.b $00 : PHA
    LDA.b $02 : PHA
    
    LDA.l $7E2000, X : LDY.w #$0000
    
    ; check if it's a rock pile
    CMP.w #$0226 : BEQ .isRockPile
        INY
        
        ; same
        CMP.w #$0227 : BEQ .isRockPile
            INY
            
            ; same
            CMP.w #$0228 : BEQ .isRockPile
                ; same
                CMP.w #$0229    
                    BNE Overworld_SmashRockPile_checkForBush
                        INY

    .isRockPile

    STY.b $0C
    
    ; why store to $0C then TSB it again...?
    PHA : TSB.b $0C
    
    TXA : CLC
    
    LDX.b $0C : ADC.l $1BBF4C, X : STA.w $0698 : TAX
    
    LDA.w #$0028 : STA.w $0692
    
    STZ.b $0E
    
    JSR Overworld_RevealSecret
    
    LDA.b $0E : CMP.w #$FFFF : BNE .noBurrowUnderneath
        SEP #$20
        
        ; Remember that the burrow has been uncovered.
        LDY.b $8A : LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
        
        ; Play puzzle solved sound
        LDA.b #$1B : STA.w $012F
        
        REP #$20
        
        LDA.b #$0050 : STA.w $0692
    
    .noBurrowUnderneath
    
    LDX.b $0C
    
    LDA.b $00 : CLC : ADC.l $1BBF54, X : STA.b $00
    LDA.b $02 : CLC : ADC.l $1BBF5C, X : STA.b $02
    
    JSL Overworld_DoMapUpdate32x32_Long
    JMP Overworld_LiftableTile_getTileAttribute
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
        
        JSR Overworld_ApplyBombToTile
        
        LDA.w $0486 : CLC : ADC.w #$0010
        
        JSR Overworld_ApplyBombToTile
        
        LDA.w $0486 : CLC : ADC.w #$0020
        
        JSR Overworld_ApplyBombToTile
        
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
    
    LSR #3 : SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $CA : TAX : STX.b $04
    
    ; Check to see if Link has a super bomb.
    LDA.l $7EF3CC : AND.w #$00FF : CMP.w #$000D : BEQ .checkForBomableCave
        LDA.l $7E2000, X
        
        LDY.w #$0DC7
        LDX.w #$0002
        
        ; normal bush
        CMP.w #$0036 : BEQ .grassOrBush
            LDX.w #$0004
            LDY.w #$0DC8
            
            ; off color bush
            CMP.w #$072A : BEQ .grassOrBush
                ; thick grass
                CMP.w #$037E : BNE .checkForBombableCave
                    LDY.w #$0DC5
                    LDX.w #$0003
        
        .grassOrBush
        
        STX.b $0A
        STY.b $0E
        
        LDX.b $04
        
        JSR Overworld_RevealSecret : BCS .noSecret
            LDA.b $0E
        
        .noSecret
        
        STA.l $7E2000, X
        
        JSL Overworld_Memorize_Map16_Change
        
        LDY.w #$0000
        
        JSL Overworld_DrawMap16_Anywhere
        
        PLA         : AND.w #$FFF8 : STA.b $00
        LDA.w $0488 : AND.w #$FFF8 : STA.b $02
        
        LDA.b $08 : PHA
        
        SEP #$30
        
        LDA.b $0A
        
        JSL Sprite_SpawnImmediatelySmashedTerrain
        
        LDA.b #$01 : STA.b $14
        
        REP #$30
        
        PLA : STA.b $08
        
        RTS
    
    .checkForBomableCave
    
    LDX.b $04
    
    JSR Overworld_RevealSecret
    
    LDA.b $0E : CMP.w #$0DB4 : BEQ .bombableCave
        PLA
        
        RTS
    
    .bombableCave
    
    STA.l $7E2000, X
    
    JSL Overworld_Memorize_Map16_Change
    
    LDY.w #$0000
    
    JSL Overworld_DrawMap16_Anywhere
    
    LDA.w #$0DB5 : STA.l $7E2002, X
    
    JSL Overworld_Memorize_Map16_Change
    
    LDY.w #$0002
    
    JSL Overworld_DrawMap16_Anywhere
    
    STZ.b $0E
    
    SEP #$20
    
    LDA.b #$01 : STA.b $14
    
    ; A cave has been bombed open. Remember it.
    LDX.b $8A : LDA.l $7EF280, X : ORA.b #$02 : STA.l $7EF280, X
    
    REP #$30
    
    PLA
    
    RTS
}

; ==============================================================================

; $0DC21D-$0DC263 LONG JUMP LOCATION
Overworld_AlterWeathervane:
{
    ; Called when the weather vane is about exploded.
    ; Draws fresh tiles over the weathercock and displays the N (north) 
    ; symbol by blitting them to VRAM, and setting $14 to 1, so it will
    ; register. But note that in order for this to work you have to use the
    ; array starting at $1000 in WRAM, which this routine does.
    
    REP #$30
    
    ; the replacement map16 tile to use?
    LDA.w #$0068 : STA.w $0692
    
    ; The index in the tile map to start from.
    LDA.w #$0C3E : STA.w $0698
    
    JSL Overworld_DoMapUpdate32x32_Long
    
    REP #$30
    
    LDX.w #$0C42
    
    LDA.w #$0E21 : STA.l $7E2000, X
    
    LDY.w #$0000
    
    JSL Overworld_DrawMap16_Anywhere
    
    LDX.w #$0CC0
    
    LDA.w #$0E25 : STA.l $7E2002, X
    
    LDY.w #$0002
    
    JSL Overworld_DrawMap16_Anywhere
    
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
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0D40
    LDA.w #$0E1C
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0DBE
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0E3E
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
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
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$03BE
    LDA.w #$0E40
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$043C
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$04BC
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    LDA.w #$3515 : STA.w $012D
    
    SEP #$30
    
    LDA.l $7EF2DB : ORA.b #$20 : STA.l $7EF2DB
    
    LDA.b #$03 : STA.w $012F
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DC2F9-$0DC3F8 DATA - Overworld secrets pointer table
OverworldData_HiddenItems:
{
    dw OverworldData_HiddenItems_Screen_00 ; 0x00 - Lost Woods
    dw OverworldData_HiddenItems_Screen_00 ; 0x01 - Lost Woods
    dw OverworldData_HiddenItems_Screen_02 ; 0x02 - Lumberjacks
    dw OverworldData_HiddenItems_Screen_03 ; 0x03 - West Death Mountain
    dw OverworldData_HiddenItems_Screen_03 ; 0x04 - West Death Mountain
    dw OverworldData_HiddenItems_Screen_05 ; 0x05 - East Death Mountain
    dw OverworldData_HiddenItems_Screen_05 ; 0x06 - East Death Mountain
    dw OverworldData_HiddenItems_Screen_07 ; 0x07 - Turtle Rock Portalway
    dw OverworldData_HiddenItems_Screen_00 ; 0x08 - Lost Woods
    dw OverworldData_HiddenItems_Screen_00 ; 0x09 - Lost Woods
    dw OverworldData_HiddenItems_Screen_0A ; 0x0A - Death Mountain Foot
    dw OverworldData_HiddenItems_Screen_03 ; 0x0B - West Death Mountain
    dw OverworldData_HiddenItems_Screen_03 ; 0x0C - West Death Mountain
    dw OverworldData_HiddenItems_Screen_05 ; 0x0D - East Death Mountain
    dw OverworldData_HiddenItems_Screen_05 ; 0x0E - East Death Mountain
    dw OverworldData_HiddenItems_Screen_0F ; 0x0F - Waterfall of Wishing
    dw OverworldData_HiddenItems_Screen_10 ; 0x10 - Lost Woods Alcove
    dw OverworldData_HiddenItems_Screen_11 ; 0x11 - North of Kakariko
    dw OverworldData_HiddenItems_Screen_12 ; 0x12 - Northwest Pond
    dw OverworldData_HiddenItems_Screen_13 ; 0x13 - Sanctuary
    dw OverworldData_HiddenItems_Screen_14 ; 0x14 - Graveyard
    dw OverworldData_HiddenItems_Screen_15 ; 0x15 - Hylia River Bend
    dw OverworldData_HiddenItems_Screen_16 ; 0x16 - Potion Shop
    dw OverworldData_HiddenItems_Screen_17 ; 0x17 - Octorok Pit
    dw OverworldData_HiddenItems_Screen_18 ; 0x18 - Kakariko Village
    dw OverworldData_HiddenItems_Screen_18 ; 0x19 - Kakariko Village
    dw OverworldData_HiddenItems_Screen_1A ; 0x1A - Kakariko Orchard
    dw OverworldData_HiddenItems_Screen_1B ; 0x1B - Hyrule Castle
    dw OverworldData_HiddenItems_Screen_1B ; 0x1C - Hyrule Castle
    dw OverworldData_HiddenItems_Screen_1D ; 0x1D - Hylia River Peninsula
    dw OverworldData_HiddenItems_Screen_1E ; 0x1E - Eastern Ruins
    dw OverworldData_HiddenItems_Screen_1E ; 0x1F - Eastern Ruins
    dw OverworldData_HiddenItems_Screen_18 ; 0x20 - Kakariko Village
    dw OverworldData_HiddenItems_Screen_18 ; 0x21 - Kakariko Village
    dw OverworldData_HiddenItems_Screen_22 ; 0x22 - Smith's House
    dw OverworldData_HiddenItems_Screen_1B ; 0x23 - Hyrule Castle
    dw OverworldData_HiddenItems_Screen_1B ; 0x24 - Hyrule Castle
    dw OverworldData_HiddenItems_Screen_25 ; 0x25 - Boulder Field
    dw OverworldData_HiddenItems_Screen_1E ; 0x26 - Eastern Ruins
    dw OverworldData_HiddenItems_Screen_1E ; 0x27 - Eastern Ruins
    dw OverworldData_HiddenItems_Screen_28 ; 0x28 - Racing Game
    dw OverworldData_HiddenItems_Screen_29 ; 0x29 - South of Kakariko
    dw OverworldData_HiddenItems_Screen_2A ; 0x2A - Haunted Grove
    dw OverworldData_HiddenItems_Screen_2B ; 0x2B - West of Link's House
    dw OverworldData_HiddenItems_Screen_2C ; 0x2C - Link's House
    dw OverworldData_HiddenItems_Screen_2D ; 0x2D - Eastern Bridge
    dw OverworldData_HiddenItems_Screen_2E ; 0x2E - Lake Hylia River Bend
    dw OverworldData_HiddenItems_Screen_2F ; 0x2F - Eastern Portalway
    dw OverworldData_HiddenItems_Screen_30 ; 0x30 - Desert
    dw OverworldData_HiddenItems_Screen_30 ; 0x31 - Desert
    dw OverworldData_HiddenItems_Screen_32 ; 0x32 - Haunted Grove Entrance
    dw OverworldData_HiddenItems_Screen_33 ; 0x33 - Marshlands Portalway
    dw OverworldData_HiddenItems_Screen_34 ; 0x34 - Marshlands Totems
    dw OverworldData_HiddenItems_Screen_35 ; 0x35 - Lake Hylia
    dw OverworldData_HiddenItems_Screen_35 ; 0x36 - Lake Hylia
    dw OverworldData_HiddenItems_Screen_37 ; 0x37 - Lake Hylia River End
    dw OverworldData_HiddenItems_Screen_30 ; 0x38 - Desert
    dw OverworldData_HiddenItems_Screen_30 ; 0x39 - Desert
    dw OverworldData_HiddenItems_Screen_3A ; 0x3A - Desert Pass
    dw OverworldData_HiddenItems_Screen_3B ; 0x3B - Marshlands Dam Entrance
    dw OverworldData_HiddenItems_Screen_3C ; 0x3C - Marshlands Ravine
    dw OverworldData_HiddenItems_Screen_35 ; 0x3D - Lake Hylia
    dw OverworldData_HiddenItems_Screen_35 ; 0x3E - Lake Hylia
    dw OverworldData_HiddenItems_Screen_3F ; 0x3F - Lake Hylia Waterfall

    dw OverworldData_HiddenItems_Screen_40 ; 0x40 - Skull Woods
    dw OverworldData_HiddenItems_Screen_40 ; 0x41 - Skull Woods
    dw OverworldData_HiddenItems_Screen_42 ; 0x42 - Dark Lumberjacks
    dw OverworldData_HiddenItems_Screen_43 ; 0x43 - West Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_43 ; 0x44 - West Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_45 ; 0x45 - East Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_45 ; 0x46 - East Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_47 ; 0x47 - Turtle Rock
    dw OverworldData_HiddenItems_Screen_40 ; 0x48 - Skull Woods
    dw OverworldData_HiddenItems_Screen_40 ; 0x49 - Skull Woods
    dw OverworldData_HiddenItems_Screen_4A ; 0x4A - Bumper Ledge
    dw OverworldData_HiddenItems_Screen_43 ; 0x4B - West Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_43 ; 0x4C - West Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_45 ; 0x4D - East Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_45 ; 0x4E - East Dark Death Mountain
    dw OverworldData_HiddenItems_Screen_4F ; 0x4F - Lake of Bad Omens
    dw OverworldData_HiddenItems_Screen_50 ; 0x50 - Skull Woods Alcove
    dw OverworldData_HiddenItems_Screen_51 ; 0x51 - North of Outcasts
    dw OverworldData_HiddenItems_Screen_52 ; 0x52 - Dark Northwest Pond
    dw OverworldData_HiddenItems_Screen_53 ; 0x53 - Dark Sanctuary
    dw OverworldData_HiddenItems_Screen_54 ; 0x54 - Dark Graveyard
    dw OverworldData_HiddenItems_Screen_55 ; 0x55 - Dark Hylia River Bend
    dw OverworldData_HiddenItems_Screen_56 ; 0x56 - Dark Northeast Shop
    dw OverworldData_HiddenItems_Screen_57 ; 0x57 - Dark Octorok Pit
    dw OverworldData_HiddenItems_Screen_58 ; 0x58 - Village of Outcasts
    dw OverworldData_HiddenItems_Screen_58 ; 0x59 - Village of Outcasts
    dw OverworldData_HiddenItems_Screen_5A ; 0x5A - Outcasts Orchard
    dw OverworldData_HiddenItems_Screen_5B ; 0x5B - Pyramid of Power
    dw OverworldData_HiddenItems_Screen_5B ; 0x5C - Pyramid of Power
    dw OverworldData_HiddenItems_Screen_5D ; 0x5D - Dark Hylia River Peninsula
    dw OverworldData_HiddenItems_Screen_5E ; 0x5E - Palace of Darkness Maze
    dw OverworldData_HiddenItems_Screen_5E ; 0x5F - Palace of Darkness Maze
    dw OverworldData_HiddenItems_Screen_58 ; 0x60 - Village of Outcasts
    dw OverworldData_HiddenItems_Screen_58 ; 0x61 - Village of Outcasts
    dw OverworldData_HiddenItems_Screen_62 ; 0x62 - Stake Puzzle
    dw OverworldData_HiddenItems_Screen_5B ; 0x63 - Pyramid of Power
    dw OverworldData_HiddenItems_Screen_5B ; 0x64 - Pyramid of Power
    dw OverworldData_HiddenItems_Screen_65 ; 0x65 - Boulder Field
    dw OverworldData_HiddenItems_Screen_5E ; 0x66 - Palace of Darkness Maze
    dw OverworldData_HiddenItems_Screen_5E ; 0x67 - Palace of Darkness Maze
    dw OverworldData_HiddenItems_Screen_68 ; 0x68 - Digging Game
    dw OverworldData_HiddenItems_Screen_69 ; 0x69 - South of Outcasts
    dw OverworldData_HiddenItems_Screen_6A ; 0x6A - Stumpy Grove
    dw OverworldData_HiddenItems_Screen_6B ; 0x6B - West of Bomb Shoppe
    dw OverworldData_HiddenItems_Screen_6C ; 0x6C - Bomb Shoppe
    dw OverworldData_HiddenItems_Screen_6D ; 0x6D - Hammer Bridge
    dw OverworldData_HiddenItems_Screen_6E ; 0x6E - Dark Lake Hylia River Bend
    dw OverworldData_HiddenItems_Screen_6F ; 0x6F - East Dark World Portalway
    dw OverworldData_HiddenItems_Screen_70 ; 0x70 - Misery Mire
    dw OverworldData_HiddenItems_Screen_70 ; 0x71 - Misery Mire
    dw OverworldData_HiddenItems_Screen_72 ; 0x72 - Stumpy Grove Entrance
    dw OverworldData_HiddenItems_Screen_73 ; 0x73 - Swamplands Portalway
    dw OverworldData_HiddenItems_Screen_74 ; 0x74 - Swamplands Totems
    dw OverworldData_HiddenItems_Screen_75 ; 0x75 - Dark Lake Hylia
    dw OverworldData_HiddenItems_Screen_75 ; 0x76 - Dark Lake Hylia
    dw OverworldData_HiddenItems_Screen_77 ; 0x77 - Dark Lake Hylia River End
    dw OverworldData_HiddenItems_Screen_70 ; 0x78 - Misery Mire
    dw OverworldData_HiddenItems_Screen_70 ; 0x79 - Misery Mire
    dw OverworldData_HiddenItems_Screen_7A ; 0x7A - West of Swamplands
    dw OverworldData_HiddenItems_Screen_7B ; 0x7B - Swamplands Palace Entrance
    dw OverworldData_HiddenItems_Screen_7C ; 0x7C - Swamplands Ravine
    dw OverworldData_HiddenItems_Screen_75 ; 0x7D - Dark Lake Hylia
    dw OverworldData_HiddenItems_Screen_75 ; 0x7E - Dark Lake Hylia
    dw OverworldData_HiddenItems_Screen_7F ; 0x7F - Dark Lake Hylia Waterfall
}

; ==============================================================================

; $0DC3F9-$0DC89B Overworld secrets data

; $0DC3F9-0DC406
OverworldData_HiddenItems_Screen_00:
{
    #_1BC3F9: dw $036A : db $04 ; Random pack xy:{ 0x350, 0x060 }
    #_1BC3FC: dw $1914 : db $04 ; Random pack xy:{ 0x0A0, 0x320 }
    #_1BC3FF: dw $10E0 : db $80 ; Hole        xy:{ 0x300, 0x200 }
    #_1BC402: dw $1AD0 : db $01 ; Green rupee xy:{ 0x280, 0x340 }
    #_1BC405: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_02:
{
    #_1BC407: dw $04AE : db $01 ; Green rupee xy:{ 0x170, 0x080 }
    #_1BC40A: dw $0D16 : db $03 ; Bee         xy:{ 0x0B0, 0x1A0 }
    #_1BC40D: dw $0DA4 : db $01 ; Green rupee xy:{ 0x120, 0x1A0 }
    #_1BC410: dw $0EA0 : db $01 ; Green rupee xy:{ 0x100, 0x1C0 }
    #_1BC413: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_03:
{
    #_1BC415: dw $186A : db $05 ; Bomb        xy:{ 0x350, 0x300 }
    #_1BC418: dw $1872 : db $05 ; Bomb        xy:{ 0x390, 0x300 }
    #_1BC41B: dw $196E : db $04 ; Random pack xy:{ 0x370, 0x320 }
    #_1BC41E: dw $1A6A : db $05 ; Bomb        xy:{ 0x350, 0x340 }
    #_1BC421: dw $1A72 : db $05 ; Bomb        xy:{ 0x390, 0x340 }
    #_1BC424: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_05:
{
    #_1BC426: dw $1D4A : db $82 ; Warp        xy:{ 0x250, 0x3A0 }
}

; $
OverworldData_HiddenItems_Screen_07:
{
    #_1BC429: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_0A:
{
    #_1BC42B: dw $0730 : db $02 ; Hoarder     xy:{ 0x180, 0x0E0 }
    #_1BC42E: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_0F:
{
    #_1BC430: dw $0618 : db $06 ; Heart       xy:{ 0x0C0, 0x0C0 }
    #_1BC433: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_10:
{
    #_1BC435: dw $0B28 : db $04 ; Random pack xy:{ 0x140, 0x160 }
    #_1BC438: dw $0B2E : db $82 ; Warp        xy:{ 0x170, 0x160 }
    #_1BC43B: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_11:
{
    #_1BC43D: dw $0A34 : db $05 ; Bomb        xy:{ 0x1A0, 0x140 }
    #_1BC440: dw $0D8E : db $06 ; Heart       xy:{ 0x070, 0x1A0 }
    #_1BC443: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_12:
{
    #_1BC445: dw $0530 : db $06 ; Heart       xy:{ 0x180, 0x0A0 }
    #_1BC448: dw $0808 : db $04 ; Random pack xy:{ 0x040, 0x100 }
    #_1BC44B: dw $09B2 : db $06 ; Heart       xy:{ 0x190, 0x120 }
    #_1BC44E: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_13:
{
    #_1BC450: dw $0506 : db $84 ; Staircase   xy:{ 0x030, 0x0A0 }
    #_1BC453: dw $07A0 : db $03 ; Bee         xy:{ 0x100, 0x0E0 }
    #_1BC456: dw $0834 : db $04 ; Random pack xy:{ 0x1A0, 0x100 }
    #_1BC459: dw $08A8 : db $04 ; Random pack xy:{ 0x140, 0x100 }
    #_1BC45C: dw $09A2 : db $06 ; Heart       xy:{ 0x110, 0x120 }
    #_1BC45F: dw $09B6 : db $04 ; Random pack xy:{ 0x1B0, 0x120 }
    #_1BC462: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_14:
{
    #_1BC464: dw $0490 : db $01 ; Green rupee xy:{ 0x080, 0x080 }
    #_1BC467: dw $0492 : db $01 ; Green rupee xy:{ 0x090, 0x080 }
    #_1BC46A: dw $071C : db $03 ; Bee         xy:{ 0x0E0, 0x0E0 }
    #_1BC46D: dw $07B8 : db $04 ; Random pack xy:{ 0x1C0, 0x0E0 }
    #_1BC470: dw $0A08 : db $04 ; Random pack xy:{ 0x040, 0x140 }
    #_1BC473: dw $0A8C : db $03 ; Bee         xy:{ 0x060, 0x140 }
    #_1BC476: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_15:
{
    #_1BC478: dw $0390 : db $05 ; Bomb        xy:{ 0x080, 0x060 }
    #_1BC47B: dw $0788 : db $80 ; Hole        xy:{ 0x040, 0x0E0 }
    #_1BC47E: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_16:
{
    #_1BC480: dw $079C : db $01 ; Green rupee xy:{ 0x0E0, 0x0E0 }
    #_1BC483: dw $0826 : db $03 ; Bee         xy:{ 0x130, 0x100 }
    #_1BC486: dw $0928 : db $04 ; Random pack xy:{ 0x140, 0x120 }
    #_1BC489: dw $09A8 : db $04 ; Random pack xy:{ 0x140, 0x120 }
    #_1BC48C: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_17:
{
    #_1BC48E: dw $0E1C : db $06 ; Heart       xy:{ 0x0E0, 0x1C0 }
    #_1BC491: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_18:
{
    #_1BC493: dw $0AF8 : db $04 ; Random pack xy:{ 0x3C0, 0x140 }
    #_1BC496: dw $0AFA : db $05 ; Bomb        xy:{ 0x3D0, 0x140 }
    #_1BC499: dw $0EEE : db $01 ; Green rupee xy:{ 0x370, 0x1C0 }
    #_1BC49C: dw $1112 : db $03 ; Bee         xy:{ 0x090, 0x220 }
    #_1BC49F: dw $111E : db $04 ; Random pack xy:{ 0x0F0, 0x220 }
    #_1BC4A2: dw $1216 : db $01 ; Green rupee xy:{ 0x0B0, 0x240 }
    #_1BC4A5: dw $12A0 : db $01 ; Green rupee xy:{ 0x100, 0x240 }
    #_1BC4A8: dw $1392 : db $01 ; Green rupee xy:{ 0x090, 0x260 }
    #_1BC4AB: dw $139E : db $01 ; Green rupee xy:{ 0x0F0, 0x260 }
    #_1BC4AE: dw $1A18 : db $04 ; Random pack xy:{ 0x0C0, 0x340 }
    #_1BC4B1: dw $1A96 : db $04 ; Random pack xy:{ 0x0B0, 0x340 }
    #_1BC4B4: dw $1A9A : db $05 ; Bomb        xy:{ 0x0D0, 0x340 }
    #_1BC4B7: dw $1B14 : db $04 ; Random pack xy:{ 0x0A0, 0x360 }
    #_1BC4BA: dw $1C0C : db $86 ; Bomb door   xy:{ 0x060, 0x380 }
    #_1BC4BD: dw $1CB2 : db $03 ; Bee         xy:{ 0x190, 0x380 }
    #_1BC4C0: dw $156A : db $06 ; Heart       xy:{ 0x350, 0x2A0 }
    #_1BC4C3: dw $15E2 : db $04 ; Random pack xy:{ 0x310, 0x2A0 }
    #_1BC4C6: dw $15EE : db $04 ; Random pack xy:{ 0x370, 0x2A0 }
    #_1BC4C9: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_1A:
{
    #_1BC4CB: dw $04AA : db $03 ; Bee         xy:{ 0x150, 0x080 }
    #_1BC4CE: dw $0A98 : db $05 ; Bomb        xy:{ 0x0C0, 0x140 }
    #_1BC4D1: dw $0DAA : db $04 ; Random pack xy:{ 0x150, 0x1A0 }
    #_1BC4D4: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_1B:
{
    #_1BC4D6: dw $028C : db $01 ; Green rupee xy:{ 0x060, 0x040 }
    #_1BC4D9: dw $040C : db $04 ; Random pack xy:{ 0x060, 0x080 }
    #_1BC4DC: dw $040E : db $04 ; Random pack xy:{ 0x070, 0x080 }
    #_1BC4DF: dw $0724 : db $03 ; Bee         xy:{ 0x120, 0x0E0 }
    #_1BC4E2: dw $02EC : db $04 ; Random pack xy:{ 0x360, 0x040 }
    #_1BC4E5: dw $0570 : db $80 ; Hole        xy:{ 0x380, 0x0A0 }
    #_1BC4E8: dw $065C : db $06 ; Heart       xy:{ 0x2E0, 0x0C0 }
    #_1BC4EB: dw $08F0 : db $01 ; Green rupee xy:{ 0x380, 0x100 }
    #_1BC4EE: dw $09EC : db $06 ; Heart       xy:{ 0x360, 0x120 }
    #_1BC4F1: dw $0E4A : db $01 ; Green rupee xy:{ 0x250, 0x1C0 }
    #_1BC4F4: dw $0ED8 : db $01 ; Green rupee xy:{ 0x2C0, 0x1C0 }
    #_1BC4F7: dw $0F5A : db $01 ; Green rupee xy:{ 0x2D0, 0x1E0 }
    #_1BC4FA: dw $0FD8 : db $01 ; Green rupee xy:{ 0x2C0, 0x1E0 }
    #_1BC4FD: dw $10B4 : db $03 ; Bee         xy:{ 0x1A0, 0x200 }
    #_1BC500: dw $169C : db $04 ; Random pack xy:{ 0x0E0, 0x2C0 }
    #_1BC503: dw $16A0 : db $01 ; Green rupee xy:{ 0x100, 0x2C0 }
    #_1BC506: dw $16A2 : db $01 ; Green rupee xy:{ 0x110, 0x2C0 }
    #_1BC509: dw $1C88 : db $01 ; Green rupee xy:{ 0x040, 0x380 }
    #_1BC50C: dw $1D92 : db $04 ; Random pack xy:{ 0x090, 0x3A0 }
    #_1BC50F: dw $10D4 : db $01 ; Green rupee xy:{ 0x2A0, 0x200 }
    #_1BC512: dw $1554 : db $01 ; Green rupee xy:{ 0x2A0, 0x2A0 }
    #_1BC515: dw $15DA : db $01 ; Green rupee xy:{ 0x2D0, 0x2A0 }
    #_1BC518: dw $15DE : db $01 ; Green rupee xy:{ 0x2F0, 0x2A0 }
    #_1BC51B: dw $1652 : db $01 ; Green rupee xy:{ 0x290, 0x2C0 }
    #_1BC51E: dw $1666 : db $01 ; Green rupee xy:{ 0x330, 0x2C0 }
    #_1BC521: dw $1D70 : db $05 ; Bomb        xy:{ 0x380, 0x3A0 }
    #_1BC524: dw $1DDA : db $04 ; Random pack xy:{ 0x2D0, 0x3A0 }
    #_1BC527: dw $1DE0 : db $06 ; Heart       xy:{ 0x300, 0x3A0 }
    #_1BC52A: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_1D:
{
    #_1BC52C: dw $0230 : db $01 ; Green rupee xy:{ 0x180, 0x040 }
    #_1BC52F: dw $0234 : db $05 ; Bomb        xy:{ 0x1A0, 0x040 }
}

; $
OverworldData_HiddenItems_Screen_1E:
{
    #_1BC532: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_22:
{
    #_1BC534: dw $0428 : db $05 ; Bomb        xy:{ 0x140, 0x080 }
    #_1BC537: dw $0B0E : db $01 ; Green rupee xy:{ 0x070, 0x160 }
    #_1BC53A: dw $0B10 : db $01 ; Green rupee xy:{ 0x080, 0x160 }
    #_1BC53D: dw $0B16 : db $01 ; Green rupee xy:{ 0x0B0, 0x160 }
    #_1BC540: dw $0C16 : db $04 ; Random pack xy:{ 0x0B0, 0x180 }
    #_1BC543: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_25:
{
    #_1BC545: dw $0908 : db $06 ; Heart       xy:{ 0x040, 0x120 }
    #_1BC548: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_28:
{
    #_1BC54A: dw $072A : db $04 ; Random pack xy:{ 0x150, 0x0E0 }
    #_1BC54D: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_29:
{
    #_1BC54F: dw $0308 : db $01 ; Green rupee xy:{ 0x040, 0x060 }
    #_1BC552: dw $0728 : db $03 ; Bee         xy:{ 0x140, 0x0E0 }
    #_1BC555: dw $0808 : db $04 ; Random pack xy:{ 0x040, 0x100 }
    #_1BC558: dw $0926 : db $04 ; Random pack xy:{ 0x130, 0x120 }
}

; $
OverworldData_HiddenItems_Screen_2A:
{
    #_1BC55B: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_2B:
{
    #_1BC55D: dw $031E : db $01 ; Green rupee xy:{ 0x0F0, 0x060 }
    #_1BC560: dw $0330 : db $84 ; Staircase   xy:{ 0x180, 0x060 }
    #_1BC563: dw $0C10 : db $01 ; Green rupee xy:{ 0x080, 0x180 }
    #_1BC566: dw $0C18 : db $04 ; Random pack xy:{ 0x0C0, 0x180 }
    #_1BC569: dw $0C1A : db $06 ; Heart       xy:{ 0x0D0, 0x180 }
    #_1BC56C: dw $0C8E : db $01 ; Green rupee xy:{ 0x070, 0x180 }
    #_1BC56F: dw $0C96 : db $01 ; Green rupee xy:{ 0x0B0, 0x180 }
    #_1BC572: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_2C:
{
    #_1BC574: dw $0214 : db $01 ; Green rupee xy:{ 0x0A0, 0x040 }
    #_1BC577: dw $089E : db $01 ; Green rupee xy:{ 0x0F0, 0x100 }
    #_1BC57A: dw $0890 : db $01 ; Green rupee xy:{ 0x080, 0x100 }
    #_1BC57D: dw $0906 : db $01 ; Green rupee xy:{ 0x030, 0x120 }
    #_1BC580: dw $0984 : db $04 ; Random pack xy:{ 0x020, 0x120 }
    #_1BC583: dw $0A1C : db $05 ; Bomb        xy:{ 0x0E0, 0x140 }
    #_1BC586: dw $0AB4 : db $06 ; Heart       xy:{ 0x1A0, 0x140 }
    #_1BC589: dw $0BB6 : db $01 ; Green rupee xy:{ 0x1B0, 0x160 }
}

; $
OverworldData_HiddenItems_Screen_2D:
OverworldData_HiddenItems_Screen_2E:
{
    #_1BC58C: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_2F:
{
    #_1BC58E: dw $0BB2 : db $82 ; Warp        xy:{ 0x190, 0x160 }
    #_1BC591: dw $0D12 : db $05 ; Bomb        xy:{ 0x090, 0x1A0 }
    #_1BC594: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_30:
{
    #_1BC596: dw $0358 : db $84 ; Staircase   xy:{ 0x2C0, 0x060 }
    #_1BC599: dw $0A50 : db $04 ; Random pack xy:{ 0x280, 0x140 }
    #_1BC59C: dw $1406 : db $06 ; Heart       xy:{ 0x030, 0x280 }
    #_1BC59F: dw $1D94 : db $82 ; Warp        xy:{ 0x0A0, 0x3A0 }
    #_1BC5A2: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_32:
{
    #_1BC5A4: dw $051E : db $05 ; Bomb        xy:{ 0x0F0, 0x0A0 }
    #_1BC5A7: dw $052A : db $04 ; Random pack xy:{ 0x150, 0x0A0 }
    #_1BC5AA: dw $059C : db $05 ; Bomb        xy:{ 0x0E0, 0x0A0 }
    #_1BC5AD: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_33:
{
    #_1BC5AF: dw $02A8 : db $82 ; Warp        xy:{ 0x140, 0x040 }
    #_1BC5B2: dw $0B14 : db $02 ; Hoarder     xy:{ 0x0A0, 0x160 }
    #_1BC5B5: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_34:
{
    #_1BC5B7: dw $03B0 : db $86 ; Bomb door   xy:{ 0x180, 0x060 }
    #_1BC5BA: dw $048C : db $04 ; Random pack xy:{ 0x060, 0x080 }
    #_1BC5BD: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_35:
{
    #_1BC5BF: dw $0A30 : db $04 ; Random pack xy:{ 0x180, 0x140 }
    #_1BC5C2: dw $0C10 : db $06 ; Heart       xy:{ 0x080, 0x180 }
    #_1BC5C5: dw $0F56 : db $82 ; Warp        xy:{ 0x2B0, 0x1E0 }
    #_1BC5C8: dw $180C : db $86 ; Bomb door   xy:{ 0x060, 0x300 }
    #_1BC5CB: dw $1CDE : db $03 ; Bee         xy:{ 0x2F0, 0x380 }
    #_1BC5CE: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_37:
{
    #_1BC5D0: dw $0288 : db $86 ; Bomb door   xy:{ 0x040, 0x040 }
    #_1BC5D3: dw $03AA : db $05 ; Bomb        xy:{ 0x150, 0x060 }
    #_1BC5D6: dw $040C : db $84 ; Staircase   xy:{ 0x060, 0x080 }
    #_1BC5D9: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_3A:
{
    #_1BC5DB: dw $081E : db $02 ; Hoarder     xy:{ 0x0F0, 0x100 }
    #_1BC5DE: dw $09AC : db $06 ; Heart       xy:{ 0x160, 0x120 }
    #_1BC5E1: dw $0A1E : db $84 ; Staircase   xy:{ 0x0F0, 0x140 }
    #_1BC5E4: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_3B:
{
    #_1BC5E6: dw $061A : db $03 ; Bee         xy:{ 0x0D0, 0x0C0 }
    #_1BC5E9: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_3C:
{
    #_1BC5EB: dw $0696 : db $03 ; Bee         xy:{ 0x0B0, 0x0C0 }
    #_1BC5EE: dw $0710 : db $04 ; Random pack xy:{ 0x080, 0x0E0 }
    #_1BC5F1: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_3F:
{
    #_1BC5F3: dw $0C28 : db $04 ; Random pack xy:{ 0x140, 0x180 }
    #_1BC5F6: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_40:
{
    #_1BC5F8: dw $0338 : db $04 ; Random pack xy:{ 0x1C0, 0x060 }
    #_1BC5FB: dw $036A : db $01 ; Green rupee xy:{ 0x350, 0x060 }
    #_1BC5FE: dw $0570 : db $03 ; Bee         xy:{ 0x380, 0x0A0 }
    #_1BC601: dw $05F2 : db $04 ; Random pack xy:{ 0x390, 0x0A0 }
    #_1BC604: dw $1914 : db $03 ; Bee         xy:{ 0x0A0, 0x320 }
    #_1BC607: dw $1D38 : db $06 ; Heart       xy:{ 0x1C0, 0x3A0 }
    #_1BC60A: dw $1DBC : db $05 ; Bomb        xy:{ 0x1E0, 0x3A0 }
    #_1BC60D: dw $105E : db $04 ; Random pack xy:{ 0x2F0, 0x200 }
    #_1BC610: dw $10E0 : db $80 ; Hole        xy:{ 0x300, 0x200 }
    #_1BC613: dw $1162 : db $01 ; Green rupee xy:{ 0x310, 0x220 }
    #_1BC616: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_42:
{
    #_1BC618: dw $04AC : db $01 ; Green rupee xy:{ 0x160, 0x080 }
    #_1BC61B: dw $05B4 : db $01 ; Green rupee xy:{ 0x1A0, 0x0A0 }
    #_1BC61E: dw $090A : db $03 ; Bee         xy:{ 0x050, 0x120 }
    #_1BC621: dw $0D98 : db $01 ; Green rupee xy:{ 0x0C0, 0x1A0 }
    #_1BC624: dw $0DA4 : db $01 ; Green rupee xy:{ 0x120, 0x1A0 }
    #_1BC627: dw $0E1E : db $01 ; Green rupee xy:{ 0x0F0, 0x1C0 }
    #_1BC62A: dw $0EA8 : db $01 ; Green rupee xy:{ 0x140, 0x1C0 }
    #_1BC62D: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_43:
{
    #_1BC62F: dw $0A60 : db $04 ; Random pack xy:{ 0x300, 0x140 }
    #_1BC632: dw $0BDA : db $04 ; Random pack xy:{ 0x2D0, 0x160 }
    #_1BC635: dw $0BE6 : db $04 ; Random pack xy:{ 0x330, 0x160 }
    #_1BC638: dw $0D60 : db $04 ; Random pack xy:{ 0x300, 0x1A0 }
    #_1BC63B: dw $1920 : db $01 ; Green rupee xy:{ 0x100, 0x320 }
    #_1BC63E: dw $1A04 : db $04 ; Random pack xy:{ 0x020, 0x340 }
    #_1BC641: dw $17EE : db $06 ; Heart       xy:{ 0x370, 0x2E0 }
    #_1BC644: dw $1968 : db $06 ; Heart       xy:{ 0x340, 0x320 }
    #_1BC647: dw $1974 : db $06 ; Heart       xy:{ 0x3A0, 0x320 }
    #_1BC64A: dw $1AEE : db $06 ; Heart       xy:{ 0x370, 0x340 }
    #_1BC64D: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_45:
{
    #_1BC64F: dw $0868 : db $84 ; Staircase   xy:{ 0x340, 0x100 }
    #_1BC652: dw $13D8 : db $05 ; Bomb        xy:{ 0x2C0, 0x260 }
    #_1BC655: dw $145A : db $05 ; Bomb        xy:{ 0x2D0, 0x280 }
}

; $
OverworldData_HiddenItems_Screen_47:
OverworldData_HiddenItems_Screen_4A:
{
    #_1BC658: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_4F:
{
    #_1BC65A: dw $06AE : db $05 ; Bomb        xy:{ 0x170, 0x0C0 }
    #_1BC65D: dw $06B4 : db $05 ; Bomb        xy:{ 0x1A0, 0x0C0 }
    #_1BC660: dw $0832 : db $06 ; Heart       xy:{ 0x190, 0x100 }
    #_1BC663: dw $0A32 : db $06 ; Heart       xy:{ 0x190, 0x140 }
    #_1BC666: dw $0B1C : db $06 ; Heart       xy:{ 0x0E0, 0x160 }
    #_1BC669: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_50:
{
    #_1BC66B: dw $040C : db $01 ; Green rupee xy:{ 0x060, 0x080 }
    #_1BC66E: dw $0792 : db $01 ; Green rupee xy:{ 0x090, 0x0E0 }
    #_1BC671: dw $0798 : db $04 ; Random pack xy:{ 0x0C0, 0x0E0 }
    #_1BC674: dw $079E : db $04 ; Random pack xy:{ 0x0F0, 0x0E0 }
    #_1BC677: dw $07A4 : db $01 ; Green rupee xy:{ 0x120, 0x0E0 }
    #_1BC67A: dw $0A34 : db $01 ; Green rupee xy:{ 0x1A0, 0x140 }
    #_1BC67D: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_51:
{
    #_1BC67F: dw $0716 : db $03 ; Bee         xy:{ 0x0B0, 0x0E0 }
    #_1BC682: dw $092A : db $01 ; Green rupee xy:{ 0x150, 0x120 }
    #_1BC685: dw $0A34 : db $05 ; Bomb        xy:{ 0x1A0, 0x140 }
    #_1BC688: dw $0AA4 : db $01 ; Green rupee xy:{ 0x120, 0x140 }
    #_1BC68B: dw $0B98 : db $01 ; Green rupee xy:{ 0x0C0, 0x160 }
    #_1BC68E: dw $0C1A : db $01 ; Green rupee xy:{ 0x0D0, 0x180 }
    #_1BC691: dw $0D18 : db $01 ; Green rupee xy:{ 0x0C0, 0x1A0 }
    #_1BC694: dw $0D8E : db $04 ; Random pack xy:{ 0x070, 0x1A0 }
    #_1BC697: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_52:
{
    #_1BC699: dw $04B2 : db $06 ; Heart       xy:{ 0x190, 0x080 }
    #_1BC69C: dw $0530 : db $06 ; Heart       xy:{ 0x180, 0x0A0 }
    #_1BC69F: dw $05AE : db $06 ; Heart       xy:{ 0x170, 0x0A0 }
    #_1BC6A2: dw $0788 : db $01 ; Green rupee xy:{ 0x040, 0x0E0 }
    #_1BC6A5: dw $0808 : db $01 ; Green rupee xy:{ 0x040, 0x100 }
    #_1BC6A8: dw $0888 : db $01 ; Green rupee xy:{ 0x040, 0x100 }
    #_1BC6AB: dw $09B2 : db $04 ; Random pack xy:{ 0x190, 0x120 }
    #_1BC6AE: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_53:
{
    #_1BC6B0: dw $0584 : db $05 ; Bomb        xy:{ 0x020, 0x0A0 }
    #_1BC6B3: dw $05B8 : db $04 ; Random pack xy:{ 0x1C0, 0x0A0 }
    #_1BC6B6: dw $0606 : db $05 ; Bomb        xy:{ 0x030, 0x0C0 }
    #_1BC6B9: dw $0688 : db $05 ; Bomb        xy:{ 0x040, 0x0C0 }
    #_1BC6BC: dw $070A : db $05 ; Bomb        xy:{ 0x050, 0x0E0 }
    #_1BC6BF: dw $078C : db $05 ; Bomb        xy:{ 0x060, 0x0E0 }
    #_1BC6C2: dw $07A0 : db $01 ; Green rupee xy:{ 0x100, 0x0E0 }
    #_1BC6C5: dw $07B6 : db $03 ; Bee         xy:{ 0x1B0, 0x0E0 }
    #_1BC6C8: dw $0822 : db $01 ; Green rupee xy:{ 0x110, 0x100 }
    #_1BC6CB: dw $082E : db $01 ; Green rupee xy:{ 0x170, 0x100 }
    #_1BC6CE: dw $08A6 : db $01 ; Green rupee xy:{ 0x130, 0x100 }
    #_1BC6D1: dw $08B0 : db $01 ; Green rupee xy:{ 0x180, 0x100 }
    #_1BC6D4: dw $0920 : db $04 ; Random pack xy:{ 0x100, 0x120 }
    #_1BC6D7: dw $0928 : db $01 ; Green rupee xy:{ 0x140, 0x120 }
    #_1BC6DA: dw $0934 : db $01 ; Green rupee xy:{ 0x1A0, 0x120 }
    #_1BC6DD: dw $09B6 : db $01 ; Green rupee xy:{ 0x1B0, 0x120 }
    #_1BC6E0: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_54:
{
    #_1BC6E2: dw $0490 : db $04 ; Random pack xy:{ 0x080, 0x080 }
    #_1BC6E5: dw $0492 : db $04 ; Random pack xy:{ 0x090, 0x080 }
    #_1BC6E8: dw $05AE : db $01 ; Green rupee xy:{ 0x170, 0x0A0 }
    #_1BC6EB: dw $07B8 : db $03 ; Bee         xy:{ 0x1C0, 0x0E0 }
    #_1BC6EE: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_55:
{
    #_1BC6F0: dw $038A : db $05 ; Bomb        xy:{ 0x050, 0x060 }
    #_1BC6F3: dw $0788 : db $04 ; Random pack xy:{ 0x040, 0x0E0 }
    #_1BC6F6: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_56:
{
    #_1BC6F8: dw $079C : db $04 ; Random pack xy:{ 0x0E0, 0x0E0 }
    #_1BC6FB: dw $08A6 : db $01 ; Green rupee xy:{ 0x130, 0x100 }
    #_1BC6FE: dw $0926 : db $01 ; Green rupee xy:{ 0x130, 0x120 }
    #_1BC701: dw $09A6 : db $01 ; Green rupee xy:{ 0x130, 0x120 }
    #_1BC704: dw $0A26 : db $01 ; Green rupee xy:{ 0x130, 0x140 }
    #_1BC707: dw $0C98 : db $01 ; Green rupee xy:{ 0x0C0, 0x180 }
    #_1BC70A: dw $0D1A : db $01 ; Green rupee xy:{ 0x0D0, 0x1A0 }
    #_1BC70D: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_57:
{
    #_1BC70F: dw $0E1C : db $06 ; Heart       xy:{ 0x0E0, 0x1C0 }
    #_1BC712: dw $0E20 : db $06 ; Heart       xy:{ 0x100, 0x1C0 }
    #_1BC715: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_58:
{
    #_1BC717: dw $049A : db $04 ; Random pack xy:{ 0x0D0, 0x080 }
    #_1BC71A: dw $0C96 : db $03 ; Bee         xy:{ 0x0B0, 0x180 }
    #_1BC71D: dw $0654 : db $01 ; Green rupee xy:{ 0x2A0, 0x0C0 }
    #_1BC720: dw $0656 : db $01 ; Green rupee xy:{ 0x2B0, 0x0C0 }
    #_1BC723: dw $0AF8 : db $04 ; Random pack xy:{ 0x3C0, 0x140 }
    #_1BC726: dw $0AFA : db $04 ; Random pack xy:{ 0x3D0, 0x140 }
    #_1BC729: dw $0CD6 : db $01 ; Green rupee xy:{ 0x2B0, 0x180 }
    #_1BC72C: dw $0E64 : db $01 ; Green rupee xy:{ 0x320, 0x1C0 }
    #_1BC72F: dw $0F66 : db $01 ; Green rupee xy:{ 0x330, 0x1E0 }
    #_1BC732: dw $1092 : db $01 ; Green rupee xy:{ 0x090, 0x200 }
    #_1BC735: dw $10A0 : db $04 ; Random pack xy:{ 0x100, 0x200 }
    #_1BC738: dw $1114 : db $01 ; Green rupee xy:{ 0x0A0, 0x220 }
    #_1BC73B: dw $1212 : db $01 ; Green rupee xy:{ 0x090, 0x240 }
    #_1BC73E: dw $121E : db $04 ; Random pack xy:{ 0x0F0, 0x240 }
    #_1BC741: dw $1296 : db $01 ; Green rupee xy:{ 0x0B0, 0x240 }
    #_1BC744: dw $199C : db $04 ; Random pack xy:{ 0x0E0, 0x320 }
    #_1BC747: dw $1A14 : db $04 ; Random pack xy:{ 0x0A0, 0x340 }
    #_1BC74A: dw $1A98 : db $04 ; Random pack xy:{ 0x0C0, 0x340 }
    #_1BC74D: dw $1B1E : db $04 ; Random pack xy:{ 0x0F0, 0x360 }
    #_1BC750: dw $1C34 : db $05 ; Bomb        xy:{ 0x1A0, 0x380 }
    #_1BC753: dw $1CA6 : db $05 ; Bomb        xy:{ 0x130, 0x380 }
    #_1BC756: dw $1AB6 : db $86 ; Bomb door   xy:{ 0x1B0, 0x340 }
    #_1BC759: dw $14EC : db $01 ; Green rupee xy:{ 0x360, 0x280 }
    #_1BC75C: dw $15E2 : db $01 ; Green rupee xy:{ 0x310, 0x2A0 }
    #_1BC75F: dw $1A4A : db $04 ; Random pack xy:{ 0x250, 0x340 }
    #_1BC762: dw $1B48 : db $03 ; Bee         xy:{ 0x240, 0x360 }
    #_1BC765: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_5A:
{
    #_1BC767: dw $041A : db $06 ; Heart       xy:{ 0x0D0, 0x080 }
    #_1BC76A: dw $08B4 : db $01 ; Green rupee xy:{ 0x1A0, 0x100 }
    #_1BC76D: dw $0A32 : db $01 ; Green rupee xy:{ 0x190, 0x140 }
    #_1BC770: dw $0B32 : db $01 ; Green rupee xy:{ 0x190, 0x160 }
    #_1BC773: dw $0C22 : db $01 ; Green rupee xy:{ 0x110, 0x180 }
    #_1BC776: dw $0C26 : db $01 ; Green rupee xy:{ 0x130, 0x180 }
    #_1BC779: dw $0C2C : db $01 ; Green rupee xy:{ 0x160, 0x180 }
    #_1BC77C: dw $0C30 : db $01 ; Green rupee xy:{ 0x180, 0x180 }
    #_1BC77F: dw $0C8E : db $05 ; Bomb        xy:{ 0x070, 0x180 }
    #_1BC782: dw $0CB4 : db $01 ; Green rupee xy:{ 0x1A0, 0x180 }
    #_1BC785: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_5B:
{
    #_1BC787: dw $0E2E : db $86 ; Bomb door   xy:{ 0x170, 0x1C0 }
    #_1BC78A: dw $1C88 : db $04 ; Random pack xy:{ 0x040, 0x380 }
    #_1BC78D: dw $1E0E : db $01 ; Green rupee xy:{ 0x070, 0x3C0 }
    #_1BC790: dw $1E12 : db $01 ; Green rupee xy:{ 0x090, 0x3C0 }
    #_1BC793: dw $1DDA : db $01 ; Green rupee xy:{ 0x2D0, 0x3A0 }
    #_1BC796: dw $1E60 : db $01 ; Green rupee xy:{ 0x300, 0x3C0 }
    #_1BC799: dw $1E72 : db $03 ; Bee         xy:{ 0x390, 0x3C0 }
}

; $
OverworldData_HiddenItems_Screen_5D:
OverworldData_HiddenItems_Screen_5E:
{
    #_1BC79C: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_62:
{
    #_1BC79E: dw $0428 : db $04 ; Random pack xy:{ 0x140, 0x080 }
    #_1BC7A1: dw $0B92 : db $01 ; Green rupee xy:{ 0x090, 0x160 }
    #_1BC7A4: dw $0C92 : db $01 ; Green rupee xy:{ 0x090, 0x180 }
    #_1BC7A7: dw $0C96 : db $01 ; Green rupee xy:{ 0x0B0, 0x180 }
    #_1BC7AA: dw $0D92 : db $01 ; Green rupee xy:{ 0x090, 0x1A0 }
    #_1BC7AD: dw $0E10 : db $01 ; Green rupee xy:{ 0x080, 0x1C0 }
    #_1BC7B0: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_65:
{
    #_1BC7B2: dw $0908 : db $06 ; Heart       xy:{ 0x040, 0x120 }
    #_1BC7B5: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_68:
{
    #_1BC7B7: dw $0420 : db $01 ; Green rupee xy:{ 0x100, 0x080 }
    #_1BC7BA: dw $0428 : db $01 ; Green rupee xy:{ 0x140, 0x080 }
    #_1BC7BD: dw $0920 : db $03 ; Bee         xy:{ 0x100, 0x120 }
    #_1BC7C0: dw $0AB2 : db $04 ; Random pack xy:{ 0x190, 0x140 }
    #_1BC7C3: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_69:
{
    #_1BC7C5: dw $0408 : db $01 ; Green rupee xy:{ 0x040, 0x080 }
    #_1BC7C8: dw $040C : db $01 ; Green rupee xy:{ 0x060, 0x080 }
    #_1BC7CB: dw $0728 : db $04 ; Random pack xy:{ 0x140, 0x0E0 }
    #_1BC7CE: dw $0926 : db $01 ; Green rupee xy:{ 0x130, 0x120 }
    #_1BC7D1: dw $09A4 : db $01 ; Green rupee xy:{ 0x120, 0x120 }
    #_1BC7D4: dw $09A6 : db $01 ; Green rupee xy:{ 0x130, 0x120 }
}

; $
OverworldData_HiddenItems_Screen_6A:
{
    #_1BC7D7: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_6B:
{
    #_1BC7D9: dw $0320 : db $04 ; Random pack xy:{ 0x100, 0x060 }
    #_1BC7DC: dw $0330 : db $84 ; Staircase   xy:{ 0x180, 0x060 }
    #_1BC7DF: dw $0C0E : db $01 ; Green rupee xy:{ 0x070, 0x180 }
    #_1BC7E2: dw $0C12 : db $01 ; Green rupee xy:{ 0x090, 0x180 }
    #_1BC7E5: dw $0C96 : db $01 ; Green rupee xy:{ 0x0B0, 0x180 }
    #_1BC7E8: dw $0C9A : db $01 ; Green rupee xy:{ 0x0D0, 0x180 }
    #_1BC7EB: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_6C:
{
    #_1BC7ED: dw $0226 : db $01 ; Green rupee xy:{ 0x130, 0x040 }
    #_1BC7F0: dw $0890 : db $01 ; Green rupee xy:{ 0x080, 0x100 }
    #_1BC7F3: dw $089C : db $01 ; Green rupee xy:{ 0x0E0, 0x100 }
    #_1BC7F6: dw $0906 : db $01 ; Green rupee xy:{ 0x030, 0x120 }
    #_1BC7F9: dw $0912 : db $01 ; Green rupee xy:{ 0x090, 0x120 }
    #_1BC7FC: dw $091E : db $01 ; Green rupee xy:{ 0x0F0, 0x120 }
    #_1BC7FF: dw $0984 : db $04 ; Random pack xy:{ 0x020, 0x120 }
    #_1BC802: dw $0AB4 : db $04 ; Random pack xy:{ 0x1A0, 0x140 }
    #_1BC805: dw $0B36 : db $04 ; Random pack xy:{ 0x1B0, 0x160 }
    #_1BC808: dw $0BB8 : db $04 ; Random pack xy:{ 0x1C0, 0x160 }
}

; $
OverworldData_HiddenItems_Screen_6D:
OverworldData_HiddenItems_Screen_6E:
{
    #_1BC80B: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_6F:
{
    #_1BC80D: dw $0B24 : db $05 ; Bomb        xy:{ 0x120, 0x160 }
    #_1BC810: dw $0B8C : db $05 ; Bomb        xy:{ 0x060, 0x160 }
    #_1BC813: dw $0B96 : db $05 ; Bomb        xy:{ 0x0B0, 0x160 }
    #_1BC816: dw $0D12 : db $05 ; Bomb        xy:{ 0x090, 0x1A0 }
    #_1BC819: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_70:
{
    #_1BC81B: dw $1406 : db $06 ; Heart       xy:{ 0x030, 0x280 }
    #_1BC81E: dw $1486 : db $06 ; Heart       xy:{ 0x030, 0x280 }
    #_1BC821: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_72:
{
    #_1BC823: dw $051C : db $04 ; Random pack xy:{ 0x0E0, 0x0A0 }
    #_1BC826: dw $051E : db $04 ; Random pack xy:{ 0x0F0, 0x0A0 }
    #_1BC829: dw $059C : db $04 ; Random pack xy:{ 0x0E0, 0x0A0 }
    #_1BC82C: dw $059E : db $04 ; Random pack xy:{ 0x0F0, 0x0A0 }
    #_1BC82F: dw $0626 : db $03 ; Bee         xy:{ 0x130, 0x0C0 }
    #_1BC832: dw $0A8C : db $01 ; Green rupee xy:{ 0x060, 0x140 }
    #_1BC835: dw $0B90 : db $01 ; Green rupee xy:{ 0x080, 0x160 }
    #_1BC838: dw $0C08 : db $01 ; Green rupee xy:{ 0x040, 0x180 }
    #_1BC83B: dw $0D0C : db $01 ; Green rupee xy:{ 0x060, 0x1A0 }
}

; $
OverworldData_HiddenItems_Screen_73:
{
    #_1BC83E: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_74:
{
    #_1BC840: dw $03B0 : db $86 ; Bomb door   xy:{ 0x180, 0x060 }
    #_1BC843: dw $040C : db $01 ; Green rupee xy:{ 0x060, 0x080 }
    #_1BC846: dw $0590 : db $01 ; Green rupee xy:{ 0x080, 0x0A0 }
    #_1BC849: dw $0614 : db $01 ; Green rupee xy:{ 0x0A0, 0x0C0 }
    #_1BC84C: dw $0728 : db $06 ; Heart       xy:{ 0x140, 0x0E0 }
    #_1BC84F: dw $090A : db $01 ; Green rupee xy:{ 0x050, 0x120 }
    #_1BC852: dw $0D9E : db $04 ; Random pack xy:{ 0x0F0, 0x1A0 }
    #_1BC855: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_75:
{
    #_1BC857: dw $0298 : db $06 ; Heart       xy:{ 0x0C0, 0x040 }
    #_1BC85A: dw $0C10 : db $04 ; Random pack xy:{ 0x080, 0x180 }
    #_1BC85D: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_77:
{
    #_1BC85F: dw $0288 : db $86 ; Bomb door   xy:{ 0x040, 0x040 }
    #_1BC862: dw $03AA : db $06 ; Heart       xy:{ 0x150, 0x060 }
    #_1BC865: dw $040C : db $84 ; Staircase   xy:{ 0x060, 0x080 }
    #_1BC868: dw $0518 : db $05 ; Bomb        xy:{ 0x0C0, 0x0A0 }
    #_1BC86B: dw $FFFF
}

; $
OverworldData_HiddenItems_Screen_7A:
{
    #_1BC86D: dw $0526 : db $05 ; Bomb        xy:{ 0x130, 0x0A0 }
    #_1BC870: dw $052A : db $05 ; Bomb        xy:{ 0x150, 0x0A0 }
    #_1BC873: dw $052E : db $05 ; Bomb        xy:{ 0x170, 0x0A0 }
    #_1BC876: dw $09AC : db $06 ; Heart       xy:{ 0x160, 0x120 }
    #_1BC879: dw $FFFF
}

; $0DC87B-$0DC885
OverworldData_HiddenItems_Screen_7B:
{
    #_1BC87B: dw $0420 : db $06 ; Heart       xy:{ 0x100, 0x080 }
    #_1BC87E: dw $061A : db $04 ; Random pack xy:{ 0x0D0, 0x0C0 }
    #_1BC881: dw $0696 : db $04 ; Random pack xy:{ 0x0B0, 0x0C0 }
    #_1BC884: dw $FFFF
}

; $0DC886-$0DC893
OverworldData_HiddenItems_Screen_7C:
{
    #_1BC886: dw $02A8 : db $05 ; Bomb        xy:{ 0x140, 0x040 }
    #_1BC889: dw $0316 : db $06 ; Heart       xy:{ 0x0B0, 0x060 }
    #_1BC88C: dw $0698 : db $06 ; Heart       xy:{ 0x0C0, 0x0C0 }
    #_1BC88F: dw $0714 : db $04 ; Random pack xy:{ 0x0A0, 0x0E0 }
    #_1BC892: dw $FFFF
}

; $0DC894-$0DC89B
OverworldData_HiddenItems_Screen_7F:
{
    #_1BC894: dw $02AE : db $04 ; Random pack xy:{ 0x170, 0x040 }
    #_1BC897: dw $0C28 : db $04 ; Random pack xy:{ 0x140, 0x180 }
    #_1BC89A: dw $FFFF
}

; ==============================================================================

Overworld_SecretTileType:
{
    #_1BC89C: dw $0DCC ; hole
    #_1BC89E: dw $0212 ; portal
    #_1BC8A0: dw $FFFF ; garbage
    #_1BC8A2: dw $0DB4 ; bomb hole
}

; ==============================================================================

; $0DC8A4-$0DC942 LOCAL JUMP LOCATION
Overworld_RevealSecret:
{
    ; Routine is used for checking if there's secrets underneath a newly
    ; exposed map16 tile
    
    STX.b $04
    
    LDA.w $0B9C : AND.w #$FF00 : STA.w $0B9C
    
    LDA.b $8A : CMP.w #$0080
    
    ; special areas don't have secrets
    BCS .failure
    
    ASL A : TAX
    
    ; Get pointer to secrets data for this area.
    LDA.l $1BC2F9, X : STA.b $00
    
    ; Set source bank for data
    LDA.w #$001B : STA.b $02
    
    LDY.w #$FFFD
    
    .nextSecret
    
    INY #3
    
    LDA [$00], Y : CMP.w #$FFFF : BEQ .failure
    
    AND.w #$7FFF : CMP.b $04 : BNE .nextSecret
    
    INY #2
    
    LDA [$00], Y : AND.w #$00FF : BEQ .emptySecret
    
    CMP.w #$0080 : BCS .extendedSecret
    
    TSB.w $0B9C
    
    .emptySecret
    .extendedSecret
    
    AND.w #$00FF : CMP.w #$0080
    
    BCC .normalSecret
    
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
    
    .notBurrow
    .overlayAlreadyActivated
    
    LDA [$00], Y : AND.w #$000F : TAX
    
    LDA.l $1BC89C, X : STA.b $0E
    
    .failure
    
    JSR $C943   ; $0DC943 IN ROM
    
    LDX.b $04
    
    CLC
    
    RTS
    
    .normalSecret
    
    JSR $C943   ; $0DC943 IN ROM
    
    LDX.b $04
    
    LDA.b $0E
    
    SEC
    
    RTS
}

; ==============================================================================

; $0DC943-$0DC951 LOCAL JUMP LOCATION
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
    
    JSL Overworld_DrawPersistentMap16
    
    LDA.w #$0DA6
    
    BRA .draw_right_half
    
    .draw_closed_door
    
    LDA.w #$0DA5
    
    JSL Overworld_DrawPersistentMap16
    
    LDA.w #$0DA7
    
    .draw_right_half
    
    STA.l $7E2002, X
    
    LDY.w #$0002
    
    JSL Overworld_DrawMap16_Anywhere
    
    SEP #$3
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DC97C-$0DC9DD LONG JUMP LOCATION
Overworld_DrawPersistentMap16:
{
    STA.l $7E2000, X
    
    ; $0DC980 ALTERNATE ENTRY POINT
    shared Overworld_DrawMap16:
    
    LDY.w #$0000
    
    ; $0DC983 ALTERNATE ENTRY POINT
    shared Overworld_DrawMap16_Anywhere
    
    PHX
    
    ; Store the index into the tiles to use in $0C
    ASL #3 : STA.b $0C
    
    STY.b $00
    
    TXA : CLC : ADC.b $00 : STA.b $00
    
    JSR $CA69 ; $0DCA69 IN ROM
    
    LDY.w $1000
    
    ; write the base vram (tilemap) address of the first two tiles
    LDA.b $02 : XBA : STA.w $1002, Y
    
    ; write the base vram address of the second two tiles
    LDA.b $02 : CLC : ADC.w #$0020 : XBA : STA.w $100A, Y
    
    ; probably indicates the number of tiles and some other information
    LDA.w #$0300 : STA.w $1004, Y : STA.w $100C, Y
    
    LDX.b $0C
    
    LDA.l $0F8000, X : STA.w $1006, Y
    LDA.l $0F8002, X : STA.w $1008, Y
    LDA.l $0F8004, X : STA.w $100E, Y
    LDA.l $0F8006, X : STA.w $1010, Y
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    TYA : CLC : ADC.w #$0010 : STA.w $1000
    
    PLX
    
    RTL
}

; ==============================================================================

; $0DC9DE-$0DCA68 LOCAL JUMP LOCATION
{
    ; Has to do with solidity of the tiles being written.
    PHA : STA.l $7E2000, X
    
    PHX
    
    ; Multiply by 8. Will be an index into a set of tiles
    ASL #3 : STA.b $0C
    
    TXA : CLC : ADC.w #$0000 : STA.b $00
    
    STZ.b $02
    
    AND.w #$003F : CMP.w #$0020
    
    BCC .BRANCH_ALPHA    ; $If A < #$20, then...
    
    LDA.w #$0400 : STA.b $02
    
    .BRANCH_ALPHA
    
    LDA.b $00 : AND.w #$0FFF : CMP.w #$0800
    
    BCC .BRANCH_BETA     ; If A < #$800 then...
    
    LDA.b $02 : ADC.w #$07FF : STA.b $02
    
    .BRANCH_BETA
    
    LDA.b $00 : AND.w #$001F : ADC.b $02 : STA.b $02
    
    LDA.b $00 : AND.w #$0780 : LSR A : ADC.b $02 : STA.b $02
    
    LDY.w $1000
    
    XBA
    
    STA.w $1002, Y
    
    LDA.b $02 : CLC : ADC.w #$0020 : XBA : STA.w $100A, Y
    
    LDA.w #$0300 : STA.w $1004, Y : STA.w $100C, Y
    
    LDX.b $0C
    
    ; Load tile indices from ROM.
    LDA.l $0F8000, X : STA.w $1006, Y   ; Writes to the top left corner of the block
    LDA.l $0F8002, X : STA.w $1008, Y   ; Writes the top right 8x8 tile of the block
    LDA.l $0F8004, X : STA.w $100E, Y   ; The bottom left corner.
    LDA.l $0F8006, X : STA.w $1010, Y   ; The bottom right corner
    
    TYA : CLC : ADC.w #$0010 : STA.w $1000
    
    PLX
    
    INX #2
    
    PLA : INC A
    
    RTS
}

; ==============================================================================

; $0DCA69-$0DCA9E LOCAL JUMP LOCATION
{
    ; I guess this calculates some sort of vram type address for an
    ; outdoor tile?
    
    STZ.b $02
    
    LDA.b $00 : AND.w #$003F : CMP.w #$0020 : BCC .BRANCH_ALPHA
    
    LDA.w #$0400 : STA.b $02
    
    .BRANCH_ALPHA
    
    LDA.b $00 : AND.w #$0FFF : CMP.w #$0800 : BCC .BRANCH_BETA
    
    LDA.b $02 : ADC.w #$07FF : STA.b $02
    
    .BRANCH_BETA
    
    LDA.b $00 : AND.w #$001F : ADC.b $02 : STA.b $02
    
    LDA.b $00 : AND.w #$0780 : LSR A : ADC.b $02 : STA.b $02
    
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
    
    JSL Overworld_Memorize_Map16_Change
    JSL Overworld_DrawMap16
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $0DCABA-$0DCAC3 JUMP TABLE
Pool_Overworld_EntranceSequence:
{
    .handlers
    dw DarkPalaceEntrance_Main
    dw $CBA6 ; = $DCBA6 ; Skull Woods Entrance Animation
    dw MiseryMireEntrance_Main
    dw TurtleRockEntrance_Main
    dw $CFD9 ; = $DCFD9 ; Ganon's Tower Entrance Animation
}

; ==============================================================================

; $0DCAC4-$0DCAD3 LONG JUMP LOCATION
Overworld_EntranceSequence:
{
    ; The input to the function is which animation is currently ongoing ($04C6 I think)
    
    STA.w $02E4 ; Link can't move.
    STA.w $0FC1 ; not sure...
    STA.w $0710 ; There is a special graphical effect about to happen
    
    DEC A : ASL A : TAX
    
    JSR (.handlers, X)
    
    RTL
}

; ==============================================================================

; $0DCAD4-$0DCADD JUMP TABLE
Pool_DarkPalaceEntrance_Main:
{
    .handlers
    dw $CAE5
    dw $CB2B
    dw $CB47
    dw $CB6C
    dw $CB91
}

; ==============================================================================

; $0DCADE-$0DCAE4 JUMP LOCATION
DarkPalaceEntrance_Main:
{
    LDA.b $B0 : ASL A : TAX
    
    JMP (.handlers, X)
}

; ==============================================================================

; $0DCAE5-$0DCB2A JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$40 : BNE .alpha
    
    JSR $D00E ; $0DD00E IN ROM
    
    LDA.l $7EF2DE : ORA.b #$20 : STA.l $7EF2DE
    
    REP #$30
    
    LDX.w #$01E6
    LDA.w #$0E31
    
    JSL Overworld_DrawPersistentMap16
    
    ; $0DCB18 ALTERNATE ENTRY POINT
    
    LDX.w #$02EA
    
    ; $0DCB1B ALTERNATE ENTRY POINT
    
    LDA.w #$0E30
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$026A
    LDA.w #$0E26
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$02EA
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$FFFF : STA.w $1012, X
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    .alpha
    
    RTS
}

; ==============================================================================

; $0DCB2B-$0DCB46 JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_DCB2A
    
    JSR $D00E ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$026A
    LDA.w #$0E28
    
    JSL Overworld_DrawPersistentMap16
    
    LDA.w #$0E29
    
    BRA .BRANCH_DCB18
}

; ==============================================================================

; $0DCB47-$0DCB6B JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_DCB2A
    
    JSR $D00E ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$026A
    LDA.w #$0E2A
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$02EA
    LDA.w #$0E2B
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$036A
    
    BRA .BRANCH_DCB1B
}

; ==============================================================================

; $0DCB6C-$0DCB90 JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_DCB2B
    
    JSR $D00E ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$026A
    LDA.w #$0E2D
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$02EA
    LDA.w #$0E2E
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$036A
    
    BRA .BRANCH_DCB1B
}

; ==============================================================================

; $0DCB91-$0DCB9B JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_DCB2A
    
    JMP $CF40 ; $0DCF40 IN ROM
}

; ==============================================================================

; $0DCB9C-$0DCBA5 JUMP TABLE
{
    dw $CBAD
    dw $CBEE
    dw $CC27
    dw $CC4D
    dw $CC8C
}

; ==============================================================================

; $0DCBA6-$0DCBAC JUMP LOCATION
{
    LDA.b $B0 : ASL A : TAX
    
    JMP ($CB9C, X) ; $0DCB9C IN ROM
}

; ==============================================================================

; $0DCBAD-$0DCBED JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$04 : BNE .delay
    
    INC.b $B0
    
    STZ.b $C8
    
    REP #$30
    
    LDX.w #$0812
    LDA.w #$0E06
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0814
    LDA.w #$0E06
    
    JSR $C9DE ; $0DC9DE IN ROM
    
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

; ==============================================================================

; $0DCBEE-$0DCC26 JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$0C : BNE .BRANCH_DCBED
    
    INC.b $B0
    
    STZ.b $C8
    
    REP #$30
    
    LDX.w #$0790
    LDA.w #$0E07
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0792
    LDA.w #$0E08
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    ; $0DCC12 ALTERNATE ENTRY POINT
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$FFFF : STA.w $1012, X
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    LDA.b #$16 : STA.w $012F
    
    RTS
}

; ==============================================================================

; $0DCC27-$0DCC4C JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$0C : BNE .BRANCH_DCBED
    
    INC.b $B0
    
    STZ.b $C8
    
    REP #$30
    
    LDX.w #$0710
    LDA.w #$0E07
    
    JSL $1BC97C
    
    LDX.w #$0712
    LDA.w #$0E08
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    BRA .BRANCH_DCC12
}

; ==============================================================================

; $0DCC4D-$0DCC8B JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$0C : BNE .BRANCH_DCBED
    
    INC.b $B0
    
    STZ.b $C8
    
    REP #$30
    
    LDX.w #$0590
    LDA.w #$0E11
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0596
    LDA.w #$0E12
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0610
    LDA.w #$0E0D
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0692
    LDA.w #$0E0B
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    JMP $CC12 ; $0DCC12 IN ROM
}

; ==============================================================================

; $0DCC8C-$0DCCC7 JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$0C : BNE .BRANCH_DCBED
    
    INC.b $B0
    
    STZ.b $C8
    
    REP #$30
    
    LDX.w #$0590
    LDA.w #$0E13
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0596
    LDA.w #$0E14
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0610
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0692
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    JSR $CC12 ; $0DCC12 IN ROM
    
    JMP $CF40 ; $0DCF40 IN ROM
}

; ==============================================================================

; $0DCCC8-$0DCCD3 JUMP TABLE
Pool_MiseryMireEntrance_Main:
{
    .handlers
    dw MiseryMireEntrance_PhaseOutRain
    dw $CD41 ; = $DCD41*; Set up the rumbling noise 
    dw $CD41 ; = $DCD41*; Do the first graphical change
    dw $CDA9 ; = $DCDA9*; Do the second graphical change
    dw $CDD7 ; = $DCDD7*; Do the third graphical change
    dw $CE05 ; = $DCE05*
}

; ==============================================================================

; $0DCCD4-$0DCCF9 LOCAL JUMP LOCATION
MiseryMireEntrance_Main:
{
    ; if($B0 < 0x02)
    LDA.b $B0 : CMP.b #$02 : BCC .anoshake_screen
    
    REP #$20
    
    ; Load the frame counter.
    LDA.b $1A : AND.w #$0001 : ASL A : TAX
    
    ; Shake the earth! This is the earthquake type effect.
    LDA.l $01C961, X : STA.w $011A
    LDA.l $01C965, X : STA.w $011C
    
    SEP #$20
    
    .anoshake_screen
    
    LDA.b $B0 : ASL A : TAX
    
    JMP (.handlers, X)
}

; ==============================================================================

; $0DCCFA-$0DCD13 DATA
Pool_MiseryMireEntrance_PhaseOutRain:
{
    .phase_masks
    db $FF, $F7, $F7, $FB, $EE, $EE, $EE, $EE
    db $EE, $EE, $AA, $AA, $AA, $AA, $AA, $AA
    db $AA, $88, $88, $88, $88, $80, $80, $80
    db $80, $80
}

; ==============================================================================

; $0DCD14-$0DCD40 JUMP LOCATION
MiseryMireEntrance_PhaseOutRain:
{
    ; \note Assume a data bank register value of 0x00 here. Yeah, strange,
    ; I know.
    
    INC.b $C8
    
    ; If $C8 <= #$20. Delay for 20 frames basically.
    LDA.b $C8 : CMP.b #$20 : BCC .delay
    
    ; ($C8 - 0x20) != 0xCF
    SEC : SBC.b #$20 : CMP.b #$CF : BNE .not_next_step_yet
    
    ; After 0xEF frames have counted down, go on to the next step
    ; And reset the substep index.
    INC.b $B0
    STZ.b $C8
    
    .not_next_step_yet
    
    PHA : AND.b #$07 : ASL A : TAY
    
    PLA : AND.b #$F8 : LSR #3 : TAX
    
    ; $98C1, Y THAT IS
    LDA.w $98C1, Y
    
    STZ.b $1D
    
    AND.l .phase_masks, X : BEQ .no_rain
    
    ; turn the overlay back on if the two numbers share some bits
    INC.b $1D
    
    .no_rain
    .delay
    
    RTS
}

; ==============================================================================

; $0DCD41-$0DCDA8 JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$10 : BNE .delay
    
    ; On the 0x10th frame move to the next step.
    INC.b $B0
    
    ; Play a sound effect.
    LDY.b #$07 : STY.w $012D
    
    .delay
    
    ; If $C8 != 0x48, end the routine.
    CMP.b #$48 : BNE .return
    
    JSR $D00E ; $0DD00E IN ROM; SFX FOR THE ENTRANCE OPENING
    
    ; So, on the 0x48th frame, 
    
    ; Check off the fact that this has been opened.
    LDX.b $8A : LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
    REP #$30
    
    ; A tile grid coordinate for the animation.
    ; Add 0x80 to move down one block. Add #$02 to move over one block.
    LDX.w #$0622
    
    ; An index into the set of tiles to use.
    LDA.w #$0E48
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0624 : LDA.w #$0E49
    
    ; $0DCD75 ALTERNATE ENTRY POINT
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM Draw the next 3 tiles
    
    LDX.w #$06A2
    
    JSR $C9DE ; $0DC9DE IN ROM Draw the next 4 tiles
    JSR $C9DE ; $0DC9DE IN ROM one line below
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0722
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    ; $0DCDA8 ALTERNATE ENTRY POINT
    .return
    
    RTS
}

; $0DCDA9-$0DCDD6 JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$48
    
    BNE .BRANCH_$DCDA8
    
    JSR $D00E   ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$05A2
    LDA.w #$0E54
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$05A4
    LDA.w #$0E55
    
    ; $0DCDC6 BRANCH LOCATION
    
    JSR $C9DE   ; $0DC9DE IN ROM
    JSR $C9DE   ; $0DC9DE IN ROM
    JSR $C9DE   ; $0DC9DE IN ROM
    
    LDX.w #$0622
    
    JSR $C9DE   ; $0DC9DE IN ROM
    
    BRA .BRANCH_$DCD75
}

; $0DCDD7-$0DCE04 JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$50 : BNE .BRANCH_$DCDA8
    
    JSR $D00E   ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$0522
    LDA.w #$0E64
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0524
    LDA.w $0E65
    
    JSR $C9DE   ; $0DC9DE IN ROM
    JSR $C9DE   ; $0DC9DE IN ROM
    JSR $C9DE   ; $0DC9DE IN ROM
    
    LDX.w #$05A2
    
    JSR $C9DE   ; $0DC9DE IN ROM
    
    BRA .BRANCH_$DCDC6
}

; $0DCE05-$0DCE15 JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$80 : BNE .BRANCH_ALPHA
    
    JSR $CF40 ; $0DCF40 IN ROM; CLEAN UP, PLAY A SOUND AND RETURN NORMALCY
    
    LDA.b #$05 : STA.w $012D
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $0DCE16-$0DCE27 DATA
Pool_TurtleRockEntrance_Main:
{
    .handlers
    dw $CE48
    dw $CE5E
    dw $CE62
    dw $CE66
    dw $CE8A
    dw $CEAC
    dw $CEF8
    dw $CF17
    dw $CF40
}

; ==============================================================================

; $0DCE28-$0DCE47 JUMP LOCATION
TurtleRockEntrance_Main:
{
    REP #$20
    
    LDA.b $1A : AND.w #$0001 : ASL A : TAX
    
    LDA.l $01C961, X : STA.w $011A
    
    LDA.l $01C965, X : STA.w $011C
    
    SEP #$20
    
    LDA.b $B0 : ASL : TAX
    
    JMP (.handlers, X)
}

; ==============================================================================

; $0DCE48-$0DCE89 JUMP LOCATION
{
    LDX.b $8A
    
    LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
    LDA.b #$00
    
    JSL Dungeon_ApproachFixedColor.variable
    
    LDA.b #$10
    
    BRA .BRANCH_DCE68
    
    ; $0DCE5E ALTERNATE ENTRY POINT
    
    LDA.b #$14
    
    BRA .BRANCH_DCE68
    
    ; $0DCE62 ALTERNATE ENTRY POINT
    
    LDA.b #$18
    
    BRA .BRANCH_DCE68
    
    ; $0DCE66 ALTERNATE ENTRY POINT
    
    LDA.b #$1C
    
    ; $0DCE68 ALTERNATE ENTRY POINT
    
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

; ==============================================================================

; $0DCE8A-$0DCEAB JUMP LOCATION
{
    REP #$20
    
    LDX.b #$0E
    
    LDA.w #$0000
    
    .loop
    
    STA.l $7EC5B0, X
    STA.l $7EC3D0, X
    
    DEX #2 : BPL .loop
    
    LDA.b $E8 : STA.b $E6
    
    LDA.b $E2 : STA.b $E0
    
    SEP #$20
    
    INC.b $B0
    
    INC.b $15
    
    RTS
}

; ==============================================================================

; $0DCEAC-$0DCEF7 JUMP LOCATION
{
    JSR $CF60
    
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

; ==============================================================================

; $0DCEF8-$0DCF16 JUMP LOCATION
{
    LDA.b $1A : LSR A : BCS .alpha
    
    LDA.b $C8 : AND.b #$07 : BNE .beta
    
    JSL $00EDB1 ; $006DB1 IN ROM
    
    LDA.b #$02 : STA.w $012F
    
    .beta
    
    DEC.b $C8 .alpha
    
    LDA.b #$30 : STA.b $C8
    
    INC.b $B0
    
    .alpha
    
    RTS
}

; ==============================================================================

; $0DCF17-$0DCF3F JUMP LOCATION
{
    LDA.b $1A : LSR A : BCS .alpha
    
    LDA.b $C8 : AND.b #$07 : BNE .alpha
    
    LDA.b #$02 : STA.w $012F
    
    .alpha
    
    DEC.b $C8 : BNE .BRANCH_DCF16
    
    JSR $CF60 ; $0DCF60 IN ROM
    
    STZ.b $1D
    
    LDA.b #$82 : STA.b $99
    
    LDA.b #$20 : STA.b $9A
    
    INC.b $B0
    
    LDA.b #$05 : STA.w $012D
    
    RTS
}

; ==============================================================================

; $0DCF40-$0DCF5F LOCAL JUMP LOCATION
{
    ; Pretty much puts a stop to any entrance animation
    
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
{
    REP #$30
    
    LDX.w #$099E
    LDA.w #$0E78
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$09A0
    LDA.w #$0E79
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0A1E
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0A9E
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$0B1E
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    TYA : CLC : ADC.w #$0010 : STA.b $00
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
                 STA.w $0710
    
    RTS
}

; ==============================================================================


; $0DCFBF-$0DCFD8 JUMP TABLE
{
    dw $CFE0 ; = $DCFE0
    dw $CFE0 ; = $DCFE0
    dw $CFF1 ; = $DCFF1
    dw $D01D ; = $DD01D
    dw $D062 ; = $DD062*
    dw $D093 ; = $DD093*
    dw $D0DE ; = $DD0DE*
    dw $D107 ; = $DD107*
    dw $D127 ; = $DD127*
    dw $D14D ; = $DD14D*
    dw $D16D ; = $DD16D* 
    dw $D19F ; = $DD19F* ; place the last step of Ganon's Tower.
    dw $D1C0 ; = $DD1C0* ; restore music, play some sfx, and let Link move again
}

; $0DCFD9-$0DCFDF ????
{
    LDA.b $B0 : ASL A : TAX

    JMP ($CFBF, X) ; SEE JUMP TABLE AT $DCFBF
}

; $0DCFE0-$0DCFF0 JUMP LOCATION
{
    LDX.b $8A
    
    LDA.l $7EF280, X : ORA.b #$20 : STA.l $7EF280, X
    
    JSL $0EDDFC ; $075DFC IN ROM
    
    RTS
}

; $0DCFF1-$0DD00D JUMP LOCATION
{
    JSL $0EDDFC ; $075DFC IN ROM
    
    LDA.b $1D : BNE .BRANCH_BETA
    
    INC.b $1D
    
    INC.b $C8 : LDA.b $C8 : CMP.b #$03 : BNE .BRANCH_ALPHA
    
    STZ.b $C8
    
    LDA.b #$07 : STA.w $012D
    
    RTS
    
    .BRANCH_ALPHA
    
    STZ.b $B0
    
    .BRANCH_BETA
    
    RTS
}

; $0DD00E-$0DD01C LOCAL JUMP LOCATION
{
    INC.b $B0
    
    STZ.b $C8
    
    LDA.b #$0C : STA.w $012E ; PLAY SFX
    LDA.b #$07 : STA.w $012F ; PLAY SFX IN CONJUNCTION WITH THE FIRST.
    
    RTS
}

; $0DD01D-$0DD061 LOCAL JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$30
    
    BNE .BRANCH_ALPHA
    
    JSR $D00E ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$045E
    LDA.w #$0E88
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0460
    LDA.w #$0E89
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDX.w #$04DE
    LDA.w #$0EA2
    
    JSR $C9DE ; $0DC9DE IN ROM
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$0E8A
    
    ; $0DD04C ALTERNATE ENTRY POINT
    
    LDX.w #$055E
    
    ; $0DD04F ALTERNATE ENTRY POINT
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    ; $0DD052 ALTERNATE ENTRY POINT
    
    JSR $C9DE ; $0DC9DE IN ROM
    
    LDA.w #$FFFF : STA.w $1012, Y
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    ; $0DD061 ALTERNATE ENTRY POINT
    .BRANCH_ALPHA
    
    RTS
}

; $0DD062-$0DD092 JUMP LOCATION
{
    INC.b $C8
    
    LDA.b $C8 : CMP.b #$30 : BNE .BRANCH_$DD061; (RTS)
    
    JSR $D00E ; $0DD00E in Rom.
    
    REP #$30
    
    LDX.w #$045E
    LDA.w #$0E8C
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0460
    LDA.w #$0E8D
    
    JSR $C9DE ; $0DC9DE in Rom.
    
    LDX.w #$04DE
    LDA.w #$0E8E
    
    JSR $C9DE ; $0DC9DE in Rom.
    JSR $C9DE ; $0DC9DE in Rom.
    
    LDA.w #$0E90
    
    BRA .BRANCH_$DD04C
}

; $0DD093-$0DD0DD JUMP LOCATION
{
	INC.b $C8
	
	LDA.b $C8 : CMP.b #$34
	
	BNE .BRANCH_$DD0DD; (RTS)
    
	JSR $D00E ; $0DD00E IN ROM
    
	REP #$30
	
	LDX.w #$045E
	LDA.w #$0E92
	
	JSL Overworld_DrawPersistentMap16
    
	LDX.w #$0460
	LDA.w #$0E93
	
	JSR $C9DE ; $0DC9DE IN ROM
    
	LDX.w #$04DE
	LDA.w #$0E94
	
	JSR $C9DE ; $0DC9DE in Rom.
	
	LDA.w #$0E94
	
	JSR $C9DE ; $0DC9DE in Rom.
	
	LDX.w #$055E
	LDA.w #$0E95
	
	JSR $C9DE ; $0DC9DE in Rom.
	
	LDA.w #$0E95
	
	JSR $C9DE ; $0DC9DE in Rom.
    
	LDA.w #$FFFF : STA.w $1012, Y
	
	SEP #$30
    
	LDA.b #$01 : STA.b $14

    ; $0DD0DD ALTERNATE ENTRY POINT

	RTS
}

; $0DD0DE-$0DD106 JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_$DD0DD ; (RTS)
    
    JSR $D00E ; $DD00E
    
    REP #$30
    
    LDX.w #$045E
    LDA.w #$0E9C
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0460
    LDA.w #$0E97
    
    JSR $C9DE ; $0DC9DE in rom
    
    LDX.w #$04DE
    LDA.w #$0E98
    
    JMP $D04F   ; $0DD04F IN ROM
}

; $0DD107-$0DD126 JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_$DD0DD; (RTS)
    
    JSR $D00E   ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$04DE
    LDA.w #$0E9A
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$04E0
    LDA.w #$0E9B
    
    JMP $D052   ; $0DD052 IN ROM
}

; $0DD127-$0DD14C JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_$DD0DD
    
    JSR $D00E   ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$04DE
    LDA.w #$0E9C
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$04E0
    LDA.w #$0E9D
    
    JSR $C9DE   ; $0DC9DE IN ROM
    
    LDA.w #$0E9E
    
    JMP $D04C   ; $0DD052 IN ROM
}

; $0DD14D-$0DD16C JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_DD0DD ; (RTS)
    
    JSR $D00E ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$055E
    LDA.w #$0E9A
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0560
    LDA.w #$0E9B
    
    JMP $D052   ; $0DD052 IN ROM
}

; $0DD16D-$0DD19E JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$20  BNE .BRANCH_DD1D7; (RTS)
    
    JSR $D00E ; $0DD00E in Rom.
    
    REP #$30
    
    LDX.w #$055E
    LDA.w #$0E9C
    
    JSL Overworld_DrawPersistentMap16
    
    LDX.w #$0560
    LDA.w #$0E9D
    
    JSR $C9DE ; $DC9DE
    
    LDX.w #$05DE
    LDA.w #$0EA0
    
    JSR $C9DE ; $0DC9DE in Rom.
    
    LDA.w #$0EA1
    LDX.w #$05E0
    
    JMP $D052 ; $0DD052 IN ROM.
}

; $0DD19F-$0DD1BF JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$20 : BNE .BRANCH_DD1D7 ; (RTS)
    
    LDA.b #$05 : STA.w $012D 
    
    JSR $D00E ; $0DD00E IN ROM
    
    REP #$30
    
    LDX.w #$05DE
    LDA.w #$0E9A
    
    JSL Overworld_DrawPersistentMap16
    
    LDA.w #$0E9B
    
    BRA .BRANCH_$DD199
}

; $0DD1C0-$0DD1D7 JUMP LOCATION
{
    INC.b $C8 : LDA.b $C8 : CMP.b #$48 : BNE .waitForTimer
    
    JSR $CF40 ; $0DCF40 IN ROM; Play "you solved puzzle" sound
    
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
{
    fillbyte $FF
    
    fill $40
}

; ==============================================================================

incsrc "palettes.asm"

; ==============================================================================

warnpc $1C8000