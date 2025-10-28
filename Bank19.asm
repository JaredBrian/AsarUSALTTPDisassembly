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
}

; ==============================================================================

; $0C8074-$0CFB17 DATA
BRRSampleData:
{
    ; Transfer size, transfer address
    dw $7AA0, SAMPLE_DATA

    ; $0C8078-$0C80BF
    .Noise
    incbin "Data/BRR/00_noise.brr"

    ; $0C80C0-$0C8869
    .Rain
    incbin "Data/BRR/01_rain.brr"

    ; $0C886A-$0C940C
    .Timpani
    incbin "Data/BRR/02_timpani.brr"

    ; $0C940D-$0C944B
    .Square
    incbin "Data/BRR/03_square.brr"

    ; $0C944C-$0C948A
    .Saw
    incbin "Data/BRR/04_saw.brr"

    ; $0C948B-$0C94ED
    .Clink
    incbin "Data/BRR/05_clink.brr"

    ; $0C94EE-$0C9586
    .Wobbly
    incbin "Data/BRR/06_wobbly.brr"

    ; $0C9587-$0C9628
    .CompoundSaw
    incbin "Data/BRR/07_compoundSaw.brr"

    ; $0C9629-$0C9BA4
    .Tweet
    incbin "Data/BRR/08_tweet.brr"

    ; $0C9BA5-$0CA924
    .Strings
    incbin "Data/BRR/09_strings.brr"

    ; $0CA925-$0CAD4A
    .Trombone
    incbin "Data/BRR/0A_trombone.brr"

    ; $0CAD4B-$0CBADC
    .Cymbal
    incbin "Data/BRR/0B_cymbal.brr"

    ; $0CBADD-$0CBC7A
    .Ocarina
    incbin "Data/BRR/0C_ocarina.brr"

    ; $0CBC7B-$0CBD52
    .Chime
    incbin "Data/BRR/0D_chime.brr"

    ; $0CBD53-$0CBF38
    .Harp
    incbin "Data/BRR/0E_harp.brr"

    ; $0CBF39-$0CC6F4
    .Splash
    incbin "Data/BRR/0F_splash.brr"

    ; $0CC6F5-$0CCDFC
    .Trumpet
    incbin "Data/BRR/10_trumpet.brr"

    ; $0CCDFD-$0CD504
    .Horn
    incbin "Data/BRR/11_horn.brr"

    ; $0CD505-$0CE233
    .Snare
    incbin "Data/BRR/12_snare.brr"

    ; $0CE234-$0CEF2C
    .Choir
    incbin "Data/BRR/13_choir.brr"

    ; $0CEF2D-$0CF163
    .Flute
    incbin "Data/BRR/14_flute.brr"

    ; $0CF164-$0CF3A3
    .Oof
    incbin "Data/BRR/15_oof.brr"

    ; $0CF3A4-$0CFB17
    .Piano
    incbin "Data/BRR/16_piano.brr"
}

; ==============================================================================

warnpc $1A8000