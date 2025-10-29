; ==============================================================================

; Bank 19
; $0C8000-$0CFFFF
org $198000

; ==============================================================================

SPC_ENGINE          = $0800
SFX_DATA            = $17C0
SAMPLE_POINTERS     = $3C00
INSTRUMENT_DATA     = $3D00
INSTRUMENT_DATA_SFX = $3E00
SAMPLE_DATA         = $4000
SONG_POINTERS       = $D000
SONG_POINTERS_AUX   = $2B00
CREDITS_AUX_POINTER = $2900

; ==============================================================================

; $0C8000-$0C8073 DATA
SamplePointers:
{
    ; Transfer size, transfer address
    dw $0070, SAMPLE_POINTERS

    ; SPC $D000-$D06F DATA
    ; $0C8004-$0C8073 DATA
    base SAMPLE_POINTERS

    dw $4000, $4012 ; 0x00 - Noise
    dw $4048, $4063 ; 0x01 - Rain
    dw $47F2, $5395 ; 0x02 - Timpani
    dw $5395, $53B0 ; 0x03 - Square wave
    dw $53D4, $53EF ; 0x04 - Saw wave
    dw $5413, $542E ; 0x05 - Clink
    dw $5476, $54A3 ; 0x06 - Wobbly lead
    dw $550F, $5521 ; 0x07 - Compound saw
    dw $55B1, $5B2D ; 0x08 - Tweet
    dw $5B2D, $60BB ; 0x09 - Strings A
    dw $5B2D, $60BB ; 0x0A - Strings B
    dw $68AD, $6C9D ; 0x0B - Trombone
    dw $6CD3, $7A65 ; 0x0C - Cymbal
    dw $7A65, $7BFA ; 0x0D - Ocarina
    dw $7C03, $7C78 ; 0x0E - Chimes
    dw $7CDB, $7EA6 ; 0x0F - Harp
    dw $7EC1, $867D ; 0x10 - Splash
    dw $867D, $8D6A ; 0x11 - Trumpet
    dw $8D85, $944E ; 0x12 - Horn
    dw $948D, $A1BC ; 0x13 - Snare A
    dw $948D, $A1BC ; 0x14 - Snare B
    dw $A1BC, $A6E7 ; 0x15 - Choir
    dw $AEB5, $B0D1 ; 0x16 - Flute
    dw $B0EC, $B32C ; 0x17 - Oof
    dw $B32C, $BA61 ; 0x18 - Piano
    dw $FFFF, $FFFF ; 0x19 - null
    dw $FFFF, $FFFF ; 0x1A - null
    dw $FFFF, $FFFF ; 0x1B - null

    base off
}

; ==============================================================================

; $0C8074-$0CFB17 DATA
BRRSampleData:
{
    ; Transfer size, transfer address
    dw $7AA0, SAMPLE_DATA

    ; SPC $4000-$BA9F DATA
    ; $0C8078-$0CFB17 DATA
    base SAMPLE_DATA

    ; SPC $4000-$4047 DATA
    ; $0C8078-$0C80BF DATA
    .Noise
    incbin "Data/BRR/00_noise.brr"

    ; SPC $4048-$47F1 DATA
    ; $0C80C0-$0C8869 DATA
    .Rain
    incbin "Data/BRR/01_rain.brr"

    ; SPC $47F2-$5394 DATA
    ; $0C886A-$0C940C DATA
    .Timpani
    incbin "Data/BRR/02_timpani.brr"

    ; SPC $5395-$53D3 DATA
    ; $0C940D-$0C944B DATA
    .Square
    incbin "Data/BRR/03_square.brr"

    ; SPC $53D4-$5412 DATA
    ; $0C944C-$0C948A DATA
    .Saw
    incbin "Data/BRR/04_saw.brr"

    ; SPC $5413-$5475 DATA
    ; $0C948B-$0C94ED DATA
    .Clink
    incbin "Data/BRR/05_clink.brr"

    ; SPC $5476-$550E DATA
    ; $0C94EE-$0C9586 DATA
    .Wobbly
    incbin "Data/BRR/06_wobbly.brr"

    ; SPC $550F-$55B0 DATA
    ; $0C9587-$0C9628 DATA
    .CompoundSaw
    incbin "Data/BRR/07_compoundSaw.brr"

    ; SPC $55B1-$5B2C DATA
    ; $0C9629-$0C9BA4 DATA
    .Tweet
    incbin "Data/BRR/08_tweet.brr"

    ; SPC $5B2D-$68AC DATA
    ; $0C9BA5-$0CA924 DATA
    .Strings
    incbin "Data/BRR/09_strings.brr"

    ; SPC $68AD-$6CD2 DATA
    ; $0CA925-$0CAD4A DATA
    .Trombone
    incbin "Data/BRR/0A_trombone.brr"

    ; SPC $6CD3-$7A64 DATA
    ; $0CAD4B-$0CBADC DATA
    .Cymbal
    incbin "Data/BRR/0B_cymbal.brr"

    ; SPC $7A65-$7C02 DATA
    ; $0CBADD-$0CBC7A DATA
    .Ocarina
    incbin "Data/BRR/0C_ocarina.brr"

    ; SPC $7C03-$7CDA DATA
    ; $0CBC7B-$0CBD52 DATA
    .Chime
    incbin "Data/BRR/0D_chime.brr"

    ; SPC $7CDB-$7EC0 DATA
    ; $0CBD53-$0CBF38 DATA
    .Harp
    incbin "Data/BRR/0E_harp.brr"

    ; SPC $7EC1-$867C DATA
    ; $0CBF39-$0CC6F4 DATA
    .Splash
    incbin "Data/BRR/0F_splash.brr"

    ; SPC $867D-$8D84 DATA
    ; $0CC6F5-$0CCDFC DATA
    .Trumpet
    incbin "Data/BRR/10_trumpet.brr"

    ; SPC $8D85-$948C DATA
    ; $0CCDFD-$0CD504 DATA
    .Horn
    incbin "Data/BRR/11_horn.brr"

    ; SPC $948D-$A1BB DATA
    ; $0CD505-$0CE233 DATA
    .Snare
    incbin "Data/BRR/12_snare.brr"

    ; SPC $A1BC-$AEB4 DATA
    ; $0CE234-$0CEF2C DATA
    .Choir
    incbin "Data/BRR/13_choir.brr"

    ; SPC $AEB5-$B0EB DATA
    ; $0CEF2D-$0CF163 DATA
    .Flute
    incbin "Data/BRR/14_flute.brr"

    ; SPC $B0EC-$B32B DATA
    ; $0CF164-$0CF3A3 DATA
    .Oof
    incbin "Data/BRR/15_oof.brr"

    ; SPC $B32C-$BA9F DATA
    ; $0CF3A4-$0CFB17 DATA
    .Piano
    incbin "Data/BRR/16_piano.brr"

    base off
}

; ==============================================================================

; $0CFB18-$0CFBC9 DATA
InstrumentData:
{
    ; TODO: Format transfer block better.
    ; Transfer size, transfer address
    dw $00AE, INSTRUMENT_DATA

    ; SPC $3D00-$3D95 DATA
    ; $0CFB1A-$0CFBB1 DATA
    base INSTRUMENT_DATA

    ; TODO: Define all of these.
    ; SRCN, ADSR1, ADSR2, GAIN, MULT (big endian)
    db $00, $FF, $E0, $B8, $04, $70 ; 0x00 - Noise
    db $01, $FF, $E0, $B8, $07, $90 ; 0x01 - Rain
    db $02, $FF, $E0, $B8, $09, $C0 ; 0x02 - Timpani
    db $03, $FF, $E0, $B8, $04, $00 ; 0x03 - Square wave
    db $04, $FF, $E0, $B8, $04, $00 ; 0x04 - Saw wave
    db $05, $FF, $E0, $B8, $04, $70 ; 0x05 - Clink
    db $06, $FF, $E0, $B8, $04, $70 ; 0x06 - Wobbly lead
    db $07, $FF, $E0, $B8, $04, $70 ; 0x07 - Compound saw
    db $08, $FF, $E0, $B8, $07, $A0 ; 0x08 - Tweet
    db $09, $8F, $E9, $B8, $01, $E0 ; 0x09 - Strings A
    db $0A, $8A, $E9, $B8, $01, $E0 ; 0x0A - Strings B
    db $0B, $FF, $E0, $B8, $03, $00 ; 0x0B - Trombone
    db $0C, $FF, $E0, $B8, $03, $A0 ; 0x0C - Cymbal
    db $0D, $FF, $E0, $B8, $01, $00 ; 0x0D - Ocarina
    db $0E, $FF, $EF, $B8, $0E, $A0 ; 0x0E - Chimes
    db $0F, $FF, $EF, $B8, $06, $00 ; 0x0F - Harp
    db $10, $FF, $E0, $B8, $03, $D0 ; 0x10 - Splash
    db $11, $8F, $E0, $B8, $03, $00 ; 0x11 - Trumpet
    db $12, $8F, $E0, $B8, $06, $F0 ; 0x12 - Horn
    db $13, $FD, $E0, $B8, $07, $A0 ; 0x13 - Snare A
    db $14, $FF, $E0, $B8, $07, $A0 ; 0x14 - Snare B
    db $15, $FF, $E0, $B8, $03, $D0 ; 0x15 - Choir
    db $16, $8F, $E0, $B8, $03, $00 ; 0x16 - Flute
    db $17, $FF, $E0, $B8, $02, $C0 ; 0x17 - Oof
    db $18, $FE, $8F, $B8, $06, $F0 ; 0x18 - Piano

    ; TODO: Wtf is stacc?
    ; stacc and attack table
    ; SPC $3D96-$3D9D DATA
    ; $0CFBB2-0CFBB8 DATA
    NoteStacc:
    {
        db $32, $65, $7F, $98, $B2, $CB, $E5, $FC
    }

    ; SPC $3D9E-$3DAD DATA
    ; $0CFBB8-$0CFBCA
    NoteAttack:
    {
        db $19, $32, $4C, $65, $72, $7F, $8C, $98
        db $A5, $B2, $BF, $CB, $D8, $E5, $F2, $FC  
    }

    base off
}

; ==============================================================================

; $0CFBCA-$0CFBCD DATA
SPCEngine:
{
    ; Transfer size, transfer address
    dw $0F9E, SPC_ENGINE

    ; TODO: Put code here instead of using an incsrc.
    ; TODO: Local jump location?
    ; SPC $0800-$179E
    incsrc "spc.asm"
}

; NOTE: The SPC engine crosses the border into bank 1A here.
; TODO: Figure out how to represent that.

; ==============================================================================

warnpc $1A8000