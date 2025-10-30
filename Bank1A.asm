; ==============================================================================

; Bank 1A
; $0D0000-$0D7FFF
org $1A8000

; The second half of the SPC engine
; SFX data
; Overworld and credits music data
; Misc sprite draw

; ==============================================================================

; The later half of the SPC engine is right here and spills over from bank 19.
; TODO: Figure out how to represent that code.

; ==============================================================================

; $0D0B6C-1A9BFF DATA
org $1A8B6C
SFX_Data:
{
    ; Transfer size, transfer address
    dw $1090, SFX_DATA

    ; SPC $17C0-$2850 DATA
    base SFX_DATA

    ; ==========================================================================

    ; SPC $17C0-$17FF DATA
    ; $0D0B70-$0D0BAF DATA
    SFX1_Pointers:
    {
        dw SFX1_01
        dw SFX1_02
        dw SFX1_03
        dw SFX1_04
        dw SFX1_05
        dw SFX1_05
        dw SFX1_07
        dw SFX1_08
        dw SFX1_09
        dw SFX1_0A
        dw SFX1_0B
        dw SFX1_0C
        dw SFX1_0D
        dw SFX1_0E
        dw SFX1_0F
        dw SFX1_10
        dw SFX1_11
        dw SFX1_12
        dw SFX1_13
        dw SFX1_14
        dw SFX1_15
        dw SFX1_16
        dw SFX1_17
        dw SFX1_18
        dw $0000
        dw $0000
        dw SFX1_0B ; TODO: Are these supposed to be duplicates?
        dw SFX1_0C
        dw SFX1_0D
        dw SFX1_0E
        dw SFX1_0F
        dw SFX1_10
    }

    ; ==========================================================================

    ; SPC $1800-$181F DATA
    ; $0D0BB0-$0D0BCF DATA
    SFX1_Accomp:
    {
        db $02 ; SFX1 01
        db $00 ; SFX1 02
        db $04 ; SFX1 03
        db $00 ; SFX1 04
        db $06 ; SFX1 05
        db $00 ; SFX1 06
        db $08 ; SFX1 07
        db $00 ; SFX1 08
        db $0A ; SFX1 09
        db $00 ; SFX1 0A
        db $0C ; SFX1 0B
        db $00 ; SFX1 0C
        db $0E ; SFX1 0D
        db $00 ; SFX1 0E
        db $10 ; SFX1 0F
        db $00 ; SFX1 10
        db $12 ; SFX1 11
        db $00 ; SFX1 12
        db $14 ; SFX1 13
        db $00 ; SFX1 14
        db $16 ; SFX1 15
        db $00 ; SFX1 16
        db $18 ; SFX1 17
        db $00 ; SFX1 18
        db $1A ; SFX1 19
        db $00 ; SFX1 1A
        db $1C ; SFX1 1B
        db $00 ; SFX1 1C
        db $1E ; SFX1 1D
        db $00 ; SFX1 1E
        db $20 ; SFX1 1F
        db $00 ; SFX1 20
    }

    ; ==========================================================================

    ; SPC $1820-$189D DATA
    ; $0D0BD0-0D0C4D DATA
    SFX2_Pointers:
    {
        dw SFX2_01
        dw SFX2_02
        dw SFX2_03
        dw SFX2_04
        dw SFX2_05
        dw SFX2_06
        dw SFX2_07
        dw SFX2_08
        dw SFX2_09
        dw SFX2_0A
        dw SFX2_0B
        dw SFX2_0C
        dw SFX2_0D
        dw SFX2_0E
        dw SFX2_0F
        dw SFX2_10
        dw SFX2_11
        dw SFX2_12
        dw SFX2_13
        dw SFX2_14
        dw SFX2_15
        dw SFX2_16
        dw SFX2_17
        dw SFX2_18
        dw SFX2_19
        dw SFX2_1A
        dw SFX2_1B
        dw SFX2_1C
        dw SFX2_1D
        dw SFX2_1E
        dw SFX2_1F
        dw SFX2_20
        dw SFX2_21
        dw SFX2_22
        dw SFX2_23
        dw SFX2_24
        dw SFX2_25
        dw SFX2_26
        dw SFX2_27
        dw SFX2_28
        dw SFX2_29
        dw SFX2_2A
        dw SFX2_2B
        dw SFX2_2C
        dw SFX2_2D
        dw SFX2_2E
        dw SFX2_2F
        dw SFX2_30
        dw SFX2_31
        dw SFX2_32
        dw SFX2_33
        dw SFX2_34
        dw SFX2_35
        dw SFX2_36
        dw SFX2_37
        dw SFX2_34
        dw SFX2_39
        dw SFX2_3A
        dw SFX2_3B
        dw SFX2_3C
        dw SFX2_3D
        dw SFX2_3E
        dw SFX2_3F
    }

    ; ==========================================================================

    ; SPC $189E-$18DC DATA
    ; $0D0C4E-0D0C8C DATA
    SFX2_Accomp:
    {
        db $00 ; SFX2 01
        db $00 ; SFX2 02
        db $00 ; SFX2 03
        db $00 ; SFX2 04
        db $00 ; SFX2 05
        db $00 ; SFX2 06
        db $00 ; SFX2 07
        db $00 ; SFX2 08
        db $00 ; SFX2 09
        db $00 ; SFX2 0A
        db $00 ; SFX2 0B
        db $00 ; SFX2 0C
        db $3F ; SFX2 0D
        db $00 ; SFX2 0E
        db $00 ; SFX2 0F
        db $00 ; SFX2 10
        db $00 ; SFX2 11
        db $00 ; SFX2 12
        db $3E ; SFX2 13
        db $00 ; SFX2 14
        db $00 ; SFX2 15
        db $00 ; SFX2 16
        db $00 ; SFX2 17
        db $00 ; SFX2 18
        db $00 ; SFX2 19
        db $00 ; SFX2 1A
        db $00 ; SFX2 1B
        db $00 ; SFX2 1C
        db $00 ; SFX2 1D
        db $00 ; SFX2 1E
        db $00 ; SFX2 1F
        db $00 ; SFX2 20
        db $00 ; SFX2 21
        db $00 ; SFX2 22
        db $00 ; SFX2 23
        db $3D ; SFX2 24
        db $00 ; SFX2 25
        db $00 ; SFX2 26
        db $00 ; SFX2 27
        db $00 ; SFX2 28
        db $3B ; SFX2 29
        db $00 ; SFX2 2A
        db $00 ; SFX2 2B
        db $3A ; SFX2 2C
        db $00 ; SFX2 2D
        db $39 ; SFX2 2E
        db $38 ; SFX2 2F
        db $00 ; SFX2 30
        db $00 ; SFX2 31
        db $00 ; SFX2 32
        db $00 ; SFX2 33
        db $33 ; SFX2 34
        db $36 ; SFX2 35
        db $00 ; SFX2 36
        db $00 ; SFX2 37
        db $00 ; SFX2 38
        db $00 ; SFX2 39
        db $00 ; SFX2 3A
        db $00 ; SFX2 3B
        db $00 ; SFX2 3C
        db $00 ; SFX2 3D
        db $00 ; SFX2 3E
        db $00 ; SFX2 3F
    }

    ; ==========================================================================

    ; SPC $18DD-$191B DATA
    ; $0D0C8D-0D0CCB DATA
    SFX2_Echo:
    {
        db $00 ; SFX2 01
        db $00 ; SFX2 02
        db $00 ; SFX2 03
        db $00 ; SFX2 04
        db $00 ; SFX2 05
        db $00 ; SFX2 06
        db $00 ; SFX2 07
        db $00 ; SFX2 08
        db $00 ; SFX2 09
        db $00 ; SFX2 0A
        db $00 ; SFX2 0B
        db $01 ; SFX2 0C
        db $00 ; SFX2 0D
        db $00 ; SFX2 0E
        db $00 ; SFX2 0F
        db $00 ; SFX2 10
        db $00 ; SFX2 11
        db $00 ; SFX2 12
        db $00 ; SFX2 13
        db $00 ; SFX2 14
        db $00 ; SFX2 15
        db $00 ; SFX2 16
        db $00 ; SFX2 17
        db $00 ; SFX2 18
        db $00 ; SFX2 19
        db $00 ; SFX2 1A
        db $00 ; SFX2 1B
        db $00 ; SFX2 1C
        db $00 ; SFX2 1D
        db $00 ; SFX2 1E
        db $00 ; SFX2 1F
        db $00 ; SFX2 20
        db $00 ; SFX2 21
        db $00 ; SFX2 22
        db $00 ; SFX2 23
        db $00 ; SFX2 24
        db $00 ; SFX2 25
        db $00 ; SFX2 26
        db $00 ; SFX2 27
        db $00 ; SFX2 28
        db $3B ; SFX2 29
        db $01 ; SFX2 2A
        db $01 ; SFX2 2B
        db $00 ; SFX2 2C
        db $01 ; SFX2 2D
        db $01 ; SFX2 2E
        db $01 ; SFX2 2F
        db $00 ; SFX2 30
        db $00 ; SFX2 31
        db $00 ; SFX2 32
        db $00 ; SFX2 33
        db $00 ; SFX2 34
        db $01 ; SFX2 35
        db $01 ; SFX2 36
        db $00 ; SFX2 37
        db $00 ; SFX2 38
        db $00 ; SFX2 39
        db $00 ; SFX2 3A
        db $00 ; SFX2 3B
        db $01 ; SFX2 3C
        db $00 ; SFX2 3D
        db $3C ; SFX2 3E
        db $00 ; SFX2 3F
    }

    ; ==========================================================================

    ; SPC $18DD-$191B DATA
    ; $0D0CCC-0D0D49 DATA
    SFX3_Pointers:
    {
        dw SFX3_01
        dw SFX3_02
        dw SFX3_03
        dw SFX3_04
        dw SFX2_07
        dw SFX3_06
        dw SFX3_07
        dw SFX3_08
        dw SFX3_09
        dw SFX3_0A
        dw SFX3_0B
        dw SFX3_0C
        dw SFX3_0D
        dw SFX3_0E
        dw SFX3_0F
        dw SFX3_10
        dw SFX3_11
        dw SFX3_12
        dw SFX3_13
        dw SFX3_14
        dw SFX3_15
        dw SFX3_16
        dw SFX3_17
        dw SFX3_18
        dw SFX3_19
        dw SFX3_1A
        dw SFX3_1B
        dw SFX3_1C
        dw SFX2_2D
        dw SFX3_1E
        dw SFX3_1F
        dw SFX3_20
        dw SFX3_21
        dw SFX3_22
        dw SFX3_23
        dw SFX3_24
        dw SFX3_25
        dw SFX3_26
        dw SFX3_27
        dw SFX3_28
        dw SFX3_29
        dw SFX3_2A
        dw SFX3_2B
        dw SFX3_2C
        dw SFX3_2D
        dw SFX3_2E
        dw SFX3_2F
        dw SFX3_30
        dw SFX3_31
        dw SFX3_32
        dw SFX3_33
        dw SFX3_34
        dw SFX3_35
        dw SFX3_36
        dw SFX3_37
        dw SFX3_38
        dw SFX3_39
        dw SFX3_3A
        dw SFX3_3B
        dw SFX3_3C
        dw SFX3_3D
        dw SFX3_3E
        dw SFX3_3F
    }

    ; ==========================================================================

    ; SPC $199A-$19D8 DATA
    ; $0D0D4A-0D0D88 DATA
    SFX3_Accomp:
    {
        db $00 ; SFX3 01
        db $00 ; SFX3 02
        db $00 ; SFX3 03
        db $00 ; SFX3 04
        db $00 ; SFX3 05
        db $00 ; SFX3 06
        db $00 ; SFX3 07
        db $00 ; SFX3 08
        db $00 ; SFX3 09
        db $00 ; SFX3 0A
        db $00 ; SFX3 0B
        db $00 ; SFX3 0C
        db $00 ; SFX3 0D
        db $00 ; SFX3 0E
        db $3C ; SFX3 0F
        db $3B ; SFX3 10
        db $00 ; SFX3 11
        db $00 ; SFX3 12
        db $00 ; SFX3 13
        db $00 ; SFX3 14
        db $00 ; SFX3 15
        db $00 ; SFX3 16
        db $00 ; SFX3 17
        db $00 ; SFX3 18
        db $00 ; SFX3 19
        db $38 ; SFX3 1A
        db $3A ; SFX3 1B
        db $00 ; SFX3 1C
        db $00 ; SFX3 1D
        db $00 ; SFX3 1E
        db $00 ; SFX3 1F
        db $00 ; SFX3 20
        db $00 ; SFX3 21
        db $00 ; SFX3 22
        db $39 ; SFX3 23
        db $00 ; SFX3 24
        db $00 ; SFX3 25
        db $00 ; SFX3 26
        db $00 ; SFX3 27
        db $00 ; SFX3 28
        db $00 ; SFX3 29
        db $00 ; SFX3 2A
        db $00 ; SFX3 2B
        db $00 ; SFX3 2C
        db $37 ; SFX3 2D
        db $35 ; SFX3 2E
        db $33 ; SFX3 2F
        db $00 ; SFX3 30
        db $00 ; SFX3 31
        db $00 ; SFX3 32
        db $00 ; SFX3 33
        db $00 ; SFX3 34
        db $34 ; SFX3 35
        db $00 ; SFX3 36
        db $00 ; SFX3 37
        db $00 ; SFX3 38
        db $00 ; SFX3 39
        db $00 ; SFX3 3A
        db $00 ; SFX3 3B
        db $3D ; SFX3 3C
        db $3E ; SFX3 3D
        db $3F ; SFX3 3E
        db $00 ; SFX3 3F
    }

    ; ==========================================================================

    ; SPC $19D9-$1A17 DATA
    ; $0D0D89-0D0DC7 DATA
    SFX3_Echo:
    {
        db $00 ; SFX3 01
        db $00 ; SFX3 02
        db $00 ; SFX3 03
        db $00 ; SFX3 04
        db $00 ; SFX3 05
        db $00 ; SFX3 06
        db $00 ; SFX3 07
        db $00 ; SFX3 08
        db $00 ; SFX3 09
        db $00 ; SFX3 0A
        db $00 ; SFX3 0B
        db $01 ; SFX3 0C
        db $01 ; SFX3 0D
        db $00 ; SFX3 0E
        db $3C ; SFX3 0F
        db $3B ; SFX3 10
        db $01 ; SFX3 11
        db $01 ; SFX3 12
        db $00 ; SFX3 13
        db $00 ; SFX3 14
        db $00 ; SFX3 15
        db $00 ; SFX3 16
        db $00 ; SFX3 17
        db $00 ; SFX3 18
        db $00 ; SFX3 19
        db $00 ; SFX3 1A
        db $3A ; SFX3 1B
        db $00 ; SFX3 1C
        db $01 ; SFX3 1D
        db $00 ; SFX3 1E
        db $01 ; SFX3 1F
        db $01 ; SFX3 20
        db $01 ; SFX3 21
        db $01 ; SFX3 22
        db $00 ; SFX3 23
        db $01 ; SFX3 24
        db $00 ; SFX3 25
        db $00 ; SFX3 26
        db $00 ; SFX3 27
        db $00 ; SFX3 28
        db $00 ; SFX3 29
        db $00 ; SFX3 2A
        db $00 ; SFX3 2B
        db $00 ; SFX3 2C
        db $01 ; SFX3 2D
        db $01 ; SFX3 2E
        db $01 ; SFX3 2F
        db $00 ; SFX3 30
        db $01 ; SFX3 31
        db $00 ; SFX3 32
        db $01 ; SFX3 33
        db $01 ; SFX3 34
        db $01 ; SFX3 35
        db $00 ; SFX3 36
        db $01 ; SFX3 37
        db $00 ; SFX3 38
        db $00 ; SFX3 39
        db $00 ; SFX3 3A
        db $00 ; SFX3 3B
        db $3D ; SFX3 3C
        db $3E ; SFX3 3D
        db $3F ; SFX3 3E
        db $01 ; SFX3 3F
    }

    ; ==========================================================================
    ; Sound effects
    ; ==========================================================================

    ; TODO: Write a script to extract the SFX from a ROM.

    ; SPC $1A18-$1A36 DATA
    ; $0D0DC8-$0D0DE6 DATA
    SFX3_01:
    {
        incbin "Data/SFX/sfx3-01.sfx"
    }

    ; SPC $1A37-$1A42 DATA
    ; $0D0DE7-$0D0DF2 DATA
    SFX2_3C:
    {
        incbin "Data/SFX/sfx2-3C.sfx"
    }

    ; SPC $1A43-$1A5A DATA
    ; $0D0DF3-$0D0E0A DATA
    SFX2_37:
    {
        incbin "Data/SFX/sfx2-37.sfx"
    }

    ; SPC $1A5B-$1A61 DATA
    ; $0D0E0B-$0D0E11 DATA
    UnusedSFX_1A5B:
    {
        incbin "Data/SFX/unused-1A5B.sfx"
    }

    ; SPC $1A62-$1A77 DATA
    ; $0D0E12-$0D0E27 DATA
    SFX3_1C:
    {
        incbin "Data/SFX/sfx3-1C.sfx"
    }

    ; SPC $1A78-$1AA6 DATA
    ; $0D0E28-$0D0E56 DATA
    SFX3_32:
    {
        incbin "Data/SFX/sfx3-32.sfx"
    }

    ; SPC $1AA7-$1AC9 DATA
    ; $0D0E57-$0D0E79 DATA
    SFX3_36:
    {
        incbin "Data/SFX/sfx3-36.sfx"
    }

    ; SPC $1ACA-$1AD1 DATA
    ; $0D0E7A-$0D0E81 DATA
    SFX3_31:
    {
        incbin "Data/SFX/sfx3-31.sfx"
    }

    ; SPC $1AD2-$1AE0 DATA
    ; $0D0E82-$0D0E90 DATA
    SFX1_13:
    {
        incbin "Data/SFX/sfx1-13.sfx"
    }

    ; SPC $1AE1-$1AEF DATA
    ; $0D0E91-$0D0E9F DATA
    SFX1_14:
    {
        incbin "Data/SFX/sfx1-14.sfx"
    }

    ; SPC $1AF0-$1AFE DATA
    ; $0D0EA0-$0D0EAE DATA
    SFX1_15:
    {
        incbin "Data/SFX/sfx1-15.sfx"
    }

    ; SPC $1AFF-$1B0D DATA
    ; $0D0EAF-$0D0EBD DATA
    SFX1_16:
    {
        incbin "Data/SFX/sfx1-16.sfx"
    }

    ; SPC $1B0E-$1B1C DATA
    ; $0D0EBE-$0D0ECC DATA
    SFX1_0D:
    {
        incbin "Data/SFX/sfx1-0D.sfx"
    }

    ; SPC $1B1D-$1B2B DATA
    ; $0D0ECD-$0D0EDB DATA
    SFX1_0E:
    {
        incbin "Data/SFX/sfx1-0E.sfx"
    }

    ; SPC $1B2C-$1B3D DATA
    ; $0D0EDC-$0D0EED DATA
    SFX1_0F:
    {
        incbin "Data/SFX/sfx1-0F.sfx"
    }

    ; SPC $1B3E-$1B52 DATA
    ; $0D0EEE-$0D0F02 DATA
    SFX1_10:
    {
        incbin "Data/SFX/sfx1-10.sfx"
    }

    ; SPC $1B53-$1B61 DATA
    ; $0D0F03-$0D0F11 DATA
    SFX3_30:
    {
        incbin "Data/SFX/sfx3-30.sfx"
    }

    ; SPC $1B62-$1BA2 DATA
    ; $0D0F12-$0D0F52 DATA
    SFX1_0C:
    {
        incbin "Data/SFX/sfx1-0C.sfx"
    }

    ; SPC $1BA3-$1BE2 DATA
    ; $0D0F53-$0D0F92 DATA
    SFX1_0B:
    {
        incbin "Data/SFX/sfx1-0B.sfx"
    }

    ; SPC $1BE3-$1C23 DATA
    ; $0D0F93-$0D0FD3 DATA
    SFX1_18:
    {
        incbin "Data/SFX/sfx1-18.sfx"
    }

    ; SPC $1C24-$1C63 DATA
    ; $0D0FD4-$0D1013 DATA
    SFX1_17:
    {
        incbin "Data/SFX/sfx1-17.sfx"
    }

    ; SPC $1C64-$1C66 DATA
    ; $0D1014-$0D1016 DATA
    SFX2_36:
    {
        incbin "Data/SFX/sfx2-36.sfx"
    }

    ; SPC $1C67-$1C8D DATA
    ; $0D1017-$0D103D DATA
    SFX2_35:
    {
        incbin "Data/SFX/sfx2-35.sfx"
    }

    ; SPC $1C8E-$1CBB DATA
    ; $0D103E-$0D106B DATA
    SFX1_09:
    {
        incbin "Data/SFX/sfx1-09.sfx"
    }

    ; SPC $1CBC-$1CDB DATA
    ; $0D106C-$0D108B DATA
    SFX1_0A:
    {
        incbin "Data/SFX/sfx1-0A.sfx"
    }

    ; SPC $1CDC-$1D1B DATA
    ; $0D108C-$0D10CB DATA
    SFX2_33:
    {
        incbin "Data/SFX/sfx2-33.sfx"
    }

    ; SPC $1D1C-$1D46 DATA
    ; $0D10CC-$0D10F6 DATA
    UnusedSFX_1D1C:
    {
        incbin "Data/SFX/unused-1D1C.sfx"
    }

    ; SPC $1D47-$1D5C DATA
    ; $0D10F7-$0D110C DATA
    SFX2_32:
    {
        incbin "Data/SFX/sfx2-32.sfx"
    }

    ; SPC $1D5D-$1D65 DATA
    ; $0D110D-$0D1115 DATA
    SFX3_2E:
    {
        incbin "Data/SFX/sfx3-2E.sfx"
    }

    ; SPC $1D66-$1D72 DATA
    ; $0D1116-$0D1122 DATA
    SFX3_34:
    {
        incbin "Data/SFX/sfx3-34.sfx"
    }

    ; SPC $1D73-$1D7F DATA
    ; $0D1123-$0D112F DATA
    SFX3_35:
    {
        incbin "Data/SFX/sfx3-35.sfx"
    }

    ; SPC $1D80-$1D92 DATA
    ; $0D1130-$0D1142 DATA
    SFX3_2F:
    {
        incbin "Data/SFX/sfx3-2F.sfx"
    }

    ; SPC $1D93-$1DA8 DATA
    ; $0D1143-$0D1158 DATA
    SFX3_33:
    {
        incbin "Data/SFX/sfx3-33.sfx"
    }

    ; SPC $1DA9-$1DB3 DATA
    ; $0D1159-$0D1163 DATA
    SFX3_2D:
    {
        incbin "Data/SFX/sfx3-2D.sfx"
    }

    ; SPC $1DB4-$1DBF DATA
    ; $0D1164-$0D116F DATA
    SFX3_37:
    {
        incbin "Data/SFX/sfx3-37.sfx"
    }

    ; SPC $1DC0-$1DF2 DATA
    ; $0D1170-$0D11A2 DATA
    SFX3_2C:
    {
        incbin "Data/SFX/sfx3-2C.sfx"
    }

    ; SPC $1DF3-$1E11 DATA
    ; $0D11A3-$0D11C1 DATA
    SFX3_2B:
    {
        incbin "Data/SFX/sfx3-2B.sfx"
    }

    ; SPC $1E12-$1E20 DATA
    ; $0D11C2-$0D11D0 DATA
    SFX3_2A:
    {
        incbin "Data/SFX/sfx3-2A.sfx"
    }

    ; SPC $1E21-$1E3F DATA
    ; $0D11D1-$0D11EF DATA
    SFX3_29:
    {
        incbin "Data/SFX/sfx3-29.sfx"
    }

    ; SPC $1E40-$1E7A DATA
    ; $0D11F0-$0D122A DATA
    SFX3_27:
    {
        incbin "Data/SFX/sfx3-27.sfx"
    }

    ; SPC $1E7B-$1E89 DATA
    ; $0D122B-$0D1239 DATA
    SFX3_26:
    {
        incbin "Data/SFX/sfx3-26.sfx"
    }

    ; SPC $1E8A-$1E92 DATA
    ; $0D123A-$0D1242 DATA
    SFX3_1A:
    {
        incbin "Data/SFX/sfx3-1A.sfx"
    }

    ; SPC $1E93-$1E9C DATA
    ; $0D1243-$0D124C DATA
    SFX3_38:
    {
        incbin "Data/SFX/sfx3-38.sfx"
    }

    ; SPC $1E9D-$1EAB DATA
    ; $0D124D-$0D125B DATA
    SFX3_25:
    {
        incbin "Data/SFX/sfx3-25.sfx"
    }

    ; SPC $1EAC-$1EC7 DATA
    ; $0D125C-$0D1277 DATA
    SFX1_11:
    {
        incbin "Data/SFX/sfx1-11.sfx"
    }

    ; SPC $1EC8-$1EE1 DATA
    ; $0D1278-$0D1291 DATA
    SFX1_12:
    {
        incbin "Data/SFX/sfx1-12.sfx"
    }

    ; SPC $1EE2-$1EF0 DATA
    ; $0D1292-$0D12A0 DATA
    UnusedSFX_1EE2:
    {
        incbin "Data/SFX/unused-1EE2.sfx"
    }

    ; SPC $1EF1-$1F12 DATA
    ; $0D12A1-$0D12C2 DATA
    SFX2_30:
    {
        incbin "Data/SFX/sfx2-30.sfx"
    }

    ; SPC $1F13-$1F46 DATA
    ; $0D12C3-$0D12F6 DATA
    UnusedSFX_1F13:
    {
        incbin "Data/SFX/unused-1F13.sfx"
    }

    ; SPC $1F47-$1F6E DATA
    ; $0D12F7-$0D131E DATA
    SFX2_2F:
    {
        incbin "Data/SFX/sfx2-2F.sfx"
    }

    ; SPC $1F6F-$1F9B DATA
    ; $0D131F-$0D134B DATA
    SFX2_34:
    {
        incbin "Data/SFX/sfx2-34.sfx"
    }

    ; SPC $1F9C-$1FC9 DATA
    ; $0D134C-$0D1379 DATA
    SFX2_39:
    {
        incbin "Data/SFX/sfx2-39.sfx"
    }

    ; SPC $1FCA-$1FD8 DATA
    ; $0D137A-$0D1388 DATA
    SFX2_2E:
    {
        incbin "Data/SFX/sfx2-2E.sfx"
    }

    ; SPC $1FD9-$1FE6 DATA
    ; $0D1389-$0D1396 DATA
    SFX2_2C:
    {
        incbin "Data/SFX/sfx2-2C.sfx"
    }

    ; SPC $1FE7-$1FF1 DATA
    ; $0D1397-$0D13A1 DATA
    SFX2_3A:
    {
        incbin "Data/SFX/sfx2-3A.sfx"
    }

    ; SPC $1FF2-$2000 DATA
    ; $0D13A2-$0D13B0 DATA
    SFX2_2B:
    {
        incbin "Data/SFX/sfx2-2B.sfx"
    }

    ; SPC $2001-$2016 DATA
    ; $0D13B1-$0D13C6 DATA
    SFX3_23:
    {
        incbin "Data/SFX/sfx3-23.sfx"
    }

    ; SPC $2017-$2032 DATA
    ; $0D13C7-$0D13E2 DATA
    SFX3_39:
    {
        incbin "Data/SFX/sfx3-39.sfx"
    }

    ; SPC $2033-$2042 DATA
    ; $0D13E3-$0D13F2 DATA
    SFX2_2A:
    {
        incbin "Data/SFX/sfx2-2A.sfx"
    }

    ; SPC $2043-$204A DATA
    ; $0D13F3-$0D13FA DATA
    SFX3_24:
    {
        incbin "Data/SFX/sfx3-24.sfx"
    }

    ; SPC $204B-$2090 DATA
    ; $0D13FB-$0D1440 DATA
    SFX3_1F:
    {
        incbin "Data/SFX/sfx3-1F.sfx"
    }

    ; SPC $2091-$20A5 DATA
    ; $0D1441-$0D1455 DATA
    SFX3_1E:
    {
        incbin "Data/SFX/sfx3-1E.sfx"
    }

    ; SPC $20A6-$20B5 DATA
    ; $0D1456-$0D1465 DATA
    SFX2_2D:
    {
        incbin "Data/SFX/sfx2-2D.sfx"
    }

    ; SPC $20B6-$20BF DATA
    ; $0D1466-$0D146F DATA
    SFX3_1B:
    {
        incbin "Data/SFX/sfx3-1B.sfx"
    }

    ; SPC $20C0-$20CD DATA
    ; $0D1470-$0D147D DATA
    SFX3_3A:
    {
        incbin "Data/SFX/sfx3-3A.sfx"
    }

    ; SPC $20CE-$20DC DATA
    ; $0D147E-$0D148C DATA
    SFX2_31:
    {
        incbin "Data/SFX/sfx2-31.sfx"
    }

    ; SPC $20DD-$2106 DATA
    ; $0D148D-$0D14B6 DATA
    SFX3_18:
    {
        incbin "Data/SFX/sfx3-18.sfx"
    }

    ; SPC $2107-$2122 DATA
    ; $0D14B7-$0D14D2 DATA
    SFX2_22:
    {
        incbin "Data/SFX/sfx2-22.sfx"
    }

    ; SPC $2123-$212E DATA
    ; $0D14D3-$0D14DE DATA
    SFX3_16:
    {
        incbin "Data/SFX/sfx3-16.sfx"
    }

    ; SPC $212F-$213A DATA
    ; $0D14DF-$0D14EA DATA
    SFX3_15:
    {
        incbin "Data/SFX/sfx3-15.sfx"
    }

    ; SPC $213B-$214E DATA
    ; $0D14EB-$0D14FE DATA
    SFX3_13:
    {
        incbin "Data/SFX/sfx3-13.sfx"
    }

    ; SPC $214F-$215D DATA
    ; $0D14FF-$0D150D DATA
    SFX3_11:
    {
        incbin "Data/SFX/sfx3-11.sfx"
    }

    ; SPC $215E-$216C DATA
    ; $0D150E-$0D151C DATA
    SFX3_12:
    {
        incbin "Data/SFX/sfx3-12.sfx"
    }

    ; SPC $216D-$2175 DATA
    ; $0D151D-$0D1525 DATA
    SFX3_10:
    {
        incbin "Data/SFX/sfx3-10.sfx"
    }

    ; SPC $2176-$2181 DATA
    ; $0D1526-$0D1531 DATA
    SFX3_3B:
    {
        incbin "Data/SFX/sfx3-3B.sfx"
    }

    ; SPC $2182-$218D DATA
    ; $0D1532-$0D153D DATA
    SFX3_0E:
    {
        incbin "Data/SFX/sfx3-0E.sfx"
    }

    ; SPC $218E-$2197 DATA
    ; $0D153E-$0D1547 DATA
    SFX3_0C:
    {
        incbin "Data/SFX/sfx3-0C.sfx"
    }

    ; SPC $2198-$21A8 DATA
    ; $0D1548-$0D1558 DATA
    SFX3_0B:
    {
        incbin "Data/SFX/sfx3-0B.sfx"
    }

    ; SPC $21A9-$21B4 DATA
    ; $0D1559-$0D1564 DATA
    SFX3_0A:
    {
        incbin "Data/SFX/sfx3-0A.sfx"
    }

    ; SPC $21B5-$21C0 DATA
    ; $0D1565-$0D1570 DATA
    SFX3_0D:
    {
        incbin "Data/SFX/sfx3-0D.sfx"
    }

    ; SPC $21C1-$21E5 DATA
    ; $0D1571-$0D1595 DATA
    SFX3_09:
    {
        incbin "Data/SFX/sfx3-09.sfx"
    }

    ; SPC $21E6-$21F4 DATA
    ; $0D1596-$0D15A4 DATA
    SFX3_08:
    {
        incbin "Data/SFX/sfx3-08.sfx"
    }

    ; SPC $21F5-$220D DATA
    ; $0D15A5-$0D15BD DATA
    SFX3_06:
    {
        incbin "Data/SFX/sfx3-06.sfx"
    }

    ; SPC $220E-$223C DATA
    ; $0D15BE-$0D15EC DATA
    SFX3_04:
    {
        incbin "Data/SFX/sfx3-04.sfx"
    }

    ; SPC $223D-$2249 DATA
    ; $0D15ED-$0D15F9 DATA
    SFX3_07:
    {
        incbin "Data/SFX/sfx3-07.sfx"
    }

    ; SPC $224A-$2251 DATA
    ; $0D15FA-$0D1601 DATA
    SFX3_03:
    {
        incbin "Data/SFX/sfx3-03.sfx"
    }

    ; SPC $2252-$2286 DATA
    ; $0D1602-$0D1636 DATA
    SFX2_27:
    {
        incbin "Data/SFX/sfx2-27.sfx"
    }

    ; SPC $2287-$2295 DATA
    ; $0D1637-$0D1645 DATA
    SFX2_28:
    {
        incbin "Data/SFX/sfx2-28.sfx"
    }

    ; SPC $2296-$22A4 DATA
    ; $0D1646-$0D1654 DATA
    SFX2_25:
    {
        incbin "Data/SFX/sfx2-25.sfx"
    }

    ; SPC $22A5-$22AA DATA
    ; $0D1655-$0D165A DATA
    SFX2_24:
    {
        incbin "Data/SFX/sfx2-24.sfx"
    }

    ; SPC $22AB-$22B0 DATA
    ; $0D165B-$0D1660 DATA
    SFX2_3D:
    {
        incbin "Data/SFX/sfx2-3D.sfx"
    }

    ; SPC $22B1-$22BA DATA
    ; $0D1661-$0D166A DATA
    SFX2_23:
    {
        incbin "Data/SFX/sfx2-23.sfx"
    }

    ; SPC $22BB-$22CE DATA
    ; $0D166B-$0D167E DATA
    SFX2_1D:
    {
        incbin "Data/SFX/sfx2-1D.sfx"
    }

    ; SPC $22CF-$22D9 DATA
    ; $0D167F-$0D1689 DATA
    SFX2_21:
    {
        incbin "Data/SFX/sfx2-21.sfx"
    }

    ; SPC $22DA-$22E8 DATA
    ; $0D168A-$0D1698 DATA
    SFX2_20:
    {
        incbin "Data/SFX/sfx2-20.sfx"
    }

    ; SPC $22E9-$2300 DATA
    ; $0D1699-$0D16B0 DATA
    SFX2_1F:
    {
        incbin "Data/SFX/sfx2-1F.sfx"
    }

    ; SPC $2301-$2306 DATA
    ; $0D16B1-$0D16B6 DATA
    SFX2_1C:
    {
        incbin "Data/SFX/sfx2-1C.sfx"
    }

    ; SPC $2307-$2315 DATA
    ; $0D16B7-$0D16C5 DATA
    SFX2_1B:
    {
        incbin "Data/SFX/sfx2-1B.sfx"
    }

    ; SPC $2316-$232B DATA
    ; $0D16C6-$0D16DB DATA
    SFX2_1A:
    {
        incbin "Data/SFX/sfx2-1A.sfx"
    }

    ; SPC $232C-$2343 DATA
    ; $0D16DC-$0D16F3 DATA
    SFX2_16:
    {
        incbin "Data/SFX/sfx2-16.sfx"
    }

    ; SPC $2344-$2355 DATA
    ; $0D16F4-$0D1705 DATA
    SFX2_17:
    {
        incbin "Data/SFX/sfx2-17.sfx"
    }

    ; SPC $2356-$236D DATA
    ; $0D1706-$0D171D DATA
    SFX2_18:
    {
        incbin "Data/SFX/sfx2-18.sfx"
    }

    ; SPC $236E-$237F DATA
    ; $0D171E-$0D172F DATA
    SFX2_19:
    {
        incbin "Data/SFX/sfx2-19.sfx"
    }

    ; SPC $2380-$238F DATA
    ; $0D1730-$0D173F DATA
    SFX2_14:
    {
        incbin "Data/SFX/sfx2-14.sfx"
    }

    ; SPC $2390-$239F DATA
    ; $0D1740-$0D174F DATA
    SFX2_15:
    {
        incbin "Data/SFX/sfx2-15.sfx"
    }

    ; SPC $23A0-$23B4 DATA
    ; $0D1750-$0D1764 DATA
    SFX2_13:
    {
        incbin "Data/SFX/sfx2-13.sfx"
    }

    ; SPC $23B5-$23CC DATA
    ; $0D1765-$0D177C DATA
    SFX2_3E:
    {
        incbin "Data/SFX/sfx2-3E.sfx"
    }

    ; SPC $23CD-$23EF DATA
    ; $0D177D-$0D179F DATA
    SFX2_12:
    {
        incbin "Data/SFX/sfx2-12.sfx"
    }

    ; SPC $23F0-$23F9 DATA
    ; $0D17A0-$0D17A9 DATA
    SFX2_11:
    {
        incbin "Data/SFX/sfx2-11.sfx"
    }

    ; SPC $23FA-$2403 DATA
    ; $0D17AA-$0D17B3 DATA
    SFX2_10:
    {
        incbin "Data/SFX/sfx2-10.sfx"
    }

    ; SPC $2404-$2413 DATA
    ; $0D17B4-$0D17C3 DATA
    SFX2_0E:
    {
        incbin "Data/SFX/sfx2-0E.sfx"
    }

    ; SPC $2414-$2434 DATA
    ; $0D17C4-$0D17E4 DATA
    SFX2_0D:
    {
        incbin "Data/SFX/sfx2-0D.sfx"
    }

    ; SPC $2435-$243E DATA
    ; $0D17E5-$0D17EE DATA
    SFX2_3F:
    {
        incbin "Data/SFX/sfx2-3F.sfx"
    }

    ; SPC $243F-$2461 DATA
    ; $0D17EF-$0D1811 DATA
    SFX2_29:
    {
        incbin "Data/SFX/sfx2-29.sfx"
    }

    ; SPC $2462-$246B DATA
    ; $0D1812-$0D181B DATA
    SFX2_3B:
    {
        incbin "Data/SFX/sfx2-3B.sfx"
    }

    ; SPC $246C-$2477 DATA
    ; $0D181C-$0D1827 DATA
    SFX3_14:
    {
        incbin "Data/SFX/sfx3-14.sfx"
    }

    ; SPC $2478-$247F DATA
    ; $0D1828-$0D182F DATA
    SFX2_0B:
    {
        incbin "Data/SFX/sfx2-0B.sfx"
    }

    ; SPC $2480-$2489 DATA
    ; $0D1830-$0D1839 DATA
    SFX3_3F:
    {
        incbin "Data/SFX/sfx3-3F.sfx"
    }

    ; SPC $248A-$2493 DATA
    ; $0D183A-$0D1843 DATA
    SFX3_3C:
    {
        incbin "Data/SFX/sfx3-3C.sfx"
    }

    ; SPC $2494-$249D DATA
    ; $0D1844-$0D184D DATA
    SFX3_3D:
    {
        incbin "Data/SFX/sfx3-3D.sfx"
    }

    ; SPC $249E-$24B8 DATA
    ; $0D184E-$0D1868 DATA
    SFX3_3E:
    {
        incbin "Data/SFX/sfx3-3E.sfx"
    }

    ; SPC $24B9-$24C2 DATA
    ; $0D1869-$0D1872 DATA
    SFX3_0F:
    {
        incbin "Data/SFX/sfx3-0F.sfx"
    }

    ; SPC $24C3-$2509 DATA
    ; $0D1873-$0D18B9 DATA
    SFX2_0F:
    {
        incbin "Data/SFX/sfx2-0F.sfx"
    }

    ; SPC $250A-$252C DATA
    ; $0D18BA-$0D18DC DATA
    SFX3_19:
    {
        incbin "Data/SFX/sfx3-19.sfx"
    }

    ; SPC $252D-$2532 DATA
    ; $0D18DD-$0D18E2 DATA
    UnusedSFX_252D:
    {
        incbin "Data/SFX/unused-252D.sfx"
    }

    ; SPC $2533-$254D DATA
    ; $0D18E3-$0D18FD DATA
    UnusedSFX_2533:
    {
        incbin "Data/SFX/unused-2533.sfx"
    }

    ; SPC $254E-$2576 DATA
    ; $0D18FE-$0D1926 DATA
    SFX3_02:
    {
        incbin "Data/SFX/sfx3-02.sfx"
    }

    ; SPC $2577-$25A5 DATA
    ; $0D1927-$0D1955 DATA
    SFX2_1E:
    {
        incbin "Data/SFX/sfx2-1E.sfx"
    }

    ; SPC $25A6-$25AC DATA
    ; $0D1956-$0D195C DATA
    SFX3_17:
    {
        incbin "Data/SFX/sfx3-17.sfx"
    }

    ; SPC $25AD-$25B6 DATA
    ; $0D195D-$0D1966 DATA
    SFX2_09:
    {
        incbin "Data/SFX/sfx2-09.sfx"
    }

    ; SPC $25B7-$25C6 DATA
    ; $0D1967-$0D1976 DATA
    SFX2_07:
    {
        incbin "Data/SFX/sfx2-07.sfx"
    }

    ; SPC $25C7-$25D6 DATA
    ; $0D1977-$0D1986 DATA
    SFX2_0A:
    {
        incbin "Data/SFX/sfx2-0A.sfx"
    }

    ; SPC $25D7-$25DC DATA
    ; $0D1987-$0D198C DATA
    SFX2_06:
    {
        incbin "Data/SFX/sfx2-06.sfx"
    }

    ; SPC $25DD-$25E2 DATA
    ; $0D198D-$0D1992 DATA
    SFX2_05:
    {
        incbin "Data/SFX/sfx2-05.sfx"
    }

    ; SPC $25E3-$2613 DATA
    ; $0D1993-$0D19C3 DATA
    SFX2_08:
    {
        incbin "Data/SFX/sfx2-08.sfx"
    }

    ; SPC $2614-$2624 DATA
    ; $0D19C4-$0D19D4 DATA
    SFX2_01:
    {
        incbin "Data/SFX/sfx2-01.sfx"
    }

    ; SPC $2625-$2633 DATA
    ; $0D19D5-$0D19E3 DATA
    SFX2_02:
    {
        incbin "Data/SFX/sfx2-02.sfx"
    }

    ; SPC $2634-$2642 DATA
    ; $0D19E4-$0D19F2 DATA
    SFX2_03:
    {
        incbin "Data/SFX/sfx2-03.sfx"
    }

    ; SPC $2643-$2651 DATA
    ; $0D19F3-$0D1A01 DATA
    SFX2_04:
    {
        incbin "Data/SFX/sfx2-04.sfx"
    }

    ; SPC $2652-$2656 DATA
    ; $0D1A02-$0D1A06 DATA
    SFX1_01:
    {
        incbin "Data/SFX/sfx1-01.sfx"
    }

    ; SPC $2657-$2661 DATA
    ; $0D1A07-$0D1A11 DATA
    UnusedSFX_2657:
    {
        incbin "Data/SFX/unused-2657.sfx"
    }

    ; SPC $2662-$2676 DATA
    ; $0D1A12-$0D1A26 DATA
    SFX1_02:
    {
        incbin "Data/SFX/sfx1-02.sfx"
    }

    ; SPC $2677-$267B DATA
    ; $0D1A27-$0D1A2B DATA
    SFX1_03:
    {
        incbin "Data/SFX/sfx1-03.sfx"
    }

    ; SPC $267C-$2686 DATA
    ; $0D1A2C-$0D1A36 DATA
    UnusedSFX_267C:
    {
        incbin "Data/SFX/unused-267C.sfx"
    }

    ; SPC $2687-$269B DATA
    ; $0D1A37-$0D1A4B DATA
    SFX1_04:
    {
        incbin "Data/SFX/sfx1-04.sfx"
    }

    ; SPC $269C-$26A1 DATA
    ; $0D1A4C-$0D1A51 DATA
    SFX2_0C:
    {
        incbin "Data/SFX/sfx2-0C.sfx"
    }

    ; SPC $26A2-$26CE DATA
    ; $0D1A52-$0D1A7E DATA
    UnusedSFX_26A2:
    {
        incbin "Data/SFX/unused-26A2.sfx"
    }

    ; SPC $26CF-$26F6 DATA
    ; $0D1A7F-$0D1AA6 DATA
    SFX3_22:
    {
        incbin "Data/SFX/sfx3-22.sfx"
    }

    ; SPC $26F7-$2735 DATA
    ; $0D1AA7-$0D1AE5 DATA
    SFX3_28:
    {
        incbin "Data/SFX/sfx3-28.sfx"
    }

    ; SPC $2736-$2738 DATA
    ; $0D1AE6-$0D1AE8 DATA
    SFX1_08:
    {
        incbin "Data/SFX/sfx1-08.sfx"
    }

    ; SPC $2739-$276B DATA
    ; $0D1AE9-$0D1B1B DATA
    SFX1_07:
    {
        incbin "Data/SFX/sfx1-07.sfx"
    }

    ; SPC $276C-$277D DATA
    ; $0D1B1C-$0D1B2D DATA
    SFX3_20:
    {
        incbin "Data/SFX/sfx3-20.sfx"
    }

    ; SPC $277E-$279C DATA
    ; $0D1B2E-$0D1B4C DATA
    UnusedSFX_277E:
    {
        incbin "Data/SFX/unused-277E.sfx"
    }

    ; SPC $279D-$27C8 DATA
    ; $0D1B4D-$0D1B78 DATA
    UnusedSFX_279D:
    {
        incbin "Data/SFX/unused-279D.sfx"
    }

    ; SPC $27C9-$27E1 DATA
    ; $0D1B79-$0D1B91 DATA
    UnusedSFX_27C9:
    {
        incbin "Data/SFX/unused-27C9.sfx"
    }

    ; SPC $27E2-$27F5 DATA
    ; $0D1B92-$0D1BA5 DATA
    SFX3_21:
    {
        incbin "Data/SFX/sfx3-21.sfx"
    }

    ; SPC $27F6-$2806 DATA
    ; $0D1BA6-$0D1BB6 DATA
    UnusedSFX_27F6:
    {
        incbin "Data/SFX/unused-27F6.sfx"
    }

    ; SPC $2807-$2817 DATA
    ; $0D1BB7-$0D1BC7 DATA
    UnusedSFX_2807:
    {
        incbin "Data/SFX/unused-2807.sfx"
    }

    ; SPC $2818-$2828 DATA
    ; $0D1BC8-$0D1BD8 DATA
    UnusedSFX_2818:
    {
        incbin "Data/SFX/unused-2818.sfx"
    }

    ; SPC $2829-$2830 DATA
    ; $0D1BD9-$0D1BE0 DATA
    UnusedSFX_2829:
    {
        incbin "Data/SFX/unused-2829.sfx"
    }

    ; SPC $2831-$2843 DATA
    ; $0D1BE1-$0D1BF3 DATA
    UnusedSFX_2831:
    {
        incbin "Data/SFX/unused-2831.sfx"
    }

    ; SPC $2844-$2849 DATA
    ; $0D1BF4-$0D1BF9 DATA
    SFX2_26:
    {
        incbin "Data/SFX/sfx2-26.sfx"
    }

    ; SPC $284A-$284E DATA
    ; $0D1BFA-$0D1BFE DATA
    UnusedSFX_284A:
    {
        incbin "Data/SFX/unused-284A.sfx"
    }

    ; SPC $284F-$2850 DATA
    ; $0D1BFF-$0D1C00 DATA
    SFX1_05:
    {
        incbin "Data/SFX/sfx1-05.sfx"
    }

    base off
}

; ==============================================================================

; $0D1C04-$0D1CE4 DATA
SFXInstruments:
{
    ; Transfer size, transfer address
    dw $00E1, INSTRUMENT_DATA_SFX

    ; SPC $3E00-$3EE0 DATA
    ; $0D1BFF-$0D1CE4 DATA
    base INSTRUMENT_DATA_SFX
    
    ; TODO: Define all of these.
    ; VOLL VOLR      Pitch     SRCN    ADSR   GAIN Mult
    db $70, $70 : dw $1000 : db $00, $F6, $6A, $B8, $03 ; 00
    db $70, $70 : dw $1000 : db $01, $8E, $E0, $B8, $02 ; 01
    db $70, $70 : dw $1000 : db $14, $FE, $6A, $B8, $02 ; 02
    db $70, $70 : dw $1000 : db $03, $FE, $F8, $B8, $0D ; 03
    db $70, $70 : dw $1000 : db $04, $FE, $6A, $7F, $03 ; 04
    db $70, $70 : dw $1000 : db $02, $FE, $6A, $7F, $03 ; 05
    db $70, $70 : dw $1000 : db $05, $FE, $6A, $70, $03 ; 06
    db $70, $70 : dw $1000 : db $06, $FE, $6A, $70, $03 ; 07
    db $70, $70 : dw $1000 : db $08, $FA, $6A, $70, $03 ; 08
    db $70, $70 : dw $1000 : db $06, $FE, $6A, $70, $01 ; 09
    db $70, $70 : dw $1000 : db $07, $FE, $6A, $70, $05 ; 0A
    db $70, $70 : dw $1000 : db $0B, $FE, $6A, $B8, $03 ; 0B
    db $70, $70 : dw $1000 : db $0C, $FE, $E0, $B8, $02 ; 0C
    db $70, $70 : dw $1000 : db $0D, $F9, $6E, $B8, $03 ; 0D
    db $70, $70 : dw $1000 : db $0E, $FE, $F5, $B8, $07 ; 0E
    db $70, $70 : dw $1000 : db $0F, $FE, $F5, $B8, $06 ; 0F
    db $70, $70 : dw $1000 : db $01, $FE, $FC, $B8, $03 ; 10
    db $70, $70 : dw $1000 : db $10, $8E, $E0, $B8, $03 ; 11
    db $70, $70 : dw $1000 : db $08, $8E, $E0, $B8, $02 ; 12
    db $70, $70 : dw $1000 : db $14, $8E, $E0, $B8, $02 ; 13
    db $70, $70 : dw $1000 : db $0A, $88, $E0, $B8, $02 ; 14
    db $70, $70 : dw $1000 : db $17, $8E, $E0, $B8, $02 ; 15
    db $70, $70 : dw $1000 : db $15, $FF, $E0, $B8, $04 ; 16
    db $70, $70 : dw $1000 : db $03, $DF, $11, $B8, $0F ; 17
    db $70, $70 : dw $1000 : db $01, $88, $E0, $B8, $01 ; 18

    base off
}

; ==============================================================================

; TODO: Write a script to extract the music from a ROM.
; TODO: Find out if the Fairy_Theme label is actually used. I don't think it is.

; $0D1CE5-$0D1EF4 DATA
Fairy_Theme:
SongBlock_1:
{
    ; Transfer size, transfer address
    dw $020C, $2880

    ; SPC $2880-$2A8C DATA
    ; $0D1CE9-$0D1CE4 DATA
    base $2880

    Song0B_FairyTheme:
    {
        incbin "Data/Music/song0B.bin"
    }

    base off
}

; ==============================================================================

; $0D1EF5-$0D4CA7 DATA
SongBank_Overworld_Main:
{
    ; Transfer size, transfer address
    dw $2DAE, SONG_POINTERS

    ; SPC $D000-$D035 DATA
    ; $0D1EF9-$0D1F2E DATA
    base SONG_POINTERS

    dw Song01_TriforceIntro
    dw Song02_LightWorldOverture
    dw Song03_Rain
    dw Song04_BunnyTheme
    dw Song05_LostWoods
    dw Song06_LegendsTheme_Attract
    dw Song07_KakarikoVillage
    dw Song08_MirrorWarp
    dw Song09_DarkWorld
    dw Song0A_PullingTheMasterSword
    dw Song0B_FairyTheme
    dw Song0C_Fugitive
    dw Song0D_SkullWoodsMarch
    dw Song0E_MinigameTheme
    dw Song0F_IntroFanfare
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
    dw $0000
    dw $0000

    ; ==========================================================================

    ; SPC $D036-$D0FE DATA
    ; $0D1F2F-$0D1FF7 DATA
    Song01_TriforceIntro:
    {
        incbin "bin/music/song01.bin" ; size: 0x00C9
    }

    ; SPC $D0FF-$D869 DATA
    ; $0D1FF8-$0D2762 DATA
    Song02_LightWorldOverture:
    {
        incbin "bin/music/song02.bin" ; size: 0x076B
    }

    ; SPC $D86A-$DCA6 DATA
    ; $0D2763-$0D2B9F DATA
    Song03_Rain:
    {
        incbin "bin/music/song03.bin" ; size: 0x043D
    }

    ; SPC $DCA7-$DEE4 DATA
    ; $0D2BA0-$0D2DDD DATA
    Song04_BunnyTheme:
    {
        incbin "bin/music/song04.bin" ; size: 0x023E
    }

    ; SPC $DEE5-$E369 DATA
    ; $0D2DDE-$0D3262 DATA
    Song05_LostWoods:
    {
        incbin "bin/music/song05.bin" ; size: 0x0485
    }

    ; SPC $E36A-$E8DB DATA
    ; $0D3263-$0D37D4 DATA
    Song06_LegendsTheme_Attract:
    {
        incbin "bin/music/song06.bin" ; size: 0x0572
    }

    ; SPC $E8DC-$EE10 DATA
    ; $0D37D5-$0D3D09 DATA
    Song07_KakarikoVillage:
    {
        incbin "bin/music/song07.bin" ; size: 0x0535
    }

    ; SPC $EE11-$EF6C DATA
    ; $0D3D0A-$0D3E65 DATA
    Song08_MirrorWarp:
    {
        incbin "bin/music/song08.bin" ; size: 0x015C
    }

    ; SPC $EF6D-$F812 DATA
    ; $0D3E66-$0D470B DATA
    Song09_DarkWorld:
    {
        incbin "bin/music/song09.bin" ; size: 0x08A6
    }

    ; SPC $F813-$F8F5 DATA
    ; $0D470C-$0D47EE DATA
    Song0A_PullingTheMasterSword:
    {
        incbin "bin/music/song0A.bin" ; size: 0x00E3
    }

    ; SPC $F8F6-$FAF9 DATA
    ; $0D47EF-$0D49F2 DATA
    Song0C_Fugitive:
    {
        incbin "bin/music/song0C.bin" ; size: 0x0204
    }

    ; SPC $FAFA-$FDAE DATA
    ; $0D49F3-$0D4CA7 DATA
    Song0F_IntroFanfare:
    {
        incbin "bin/music/song0F.bin" ; size: 0x02B4
    }

    base off
}

; ==============================================================================

; $0D4CA7-$0D5336 DATA
SongBank_Overworld_Auxiliary:
{
    ; Transfer size, transfer address
    dw $0688, SONG_POINTERS_AUX

    ; SPC $2B00-$3188 DATA
    ; $0D4CA7-$0D5332 DATA
    base SONG_POINTERS_AUX

    ; SPC $2B00-$2FA5 DATA
    ; $0D4CAB-$0D5150 DATA
    Song0D_SkullWoodsMarch:
    {
        incbin "bin/music/song0D.bin"
    }

    ; SPC $2FA6-$3188 DATA
    ; $0D4151-$0D5332 DATA
    Song0E_MinigameTheme:
    {
        incbin "bin/music/song0E.bin"
    }

    base off

    ; end of transfer
    ; $0D5333
    dw $0000, SPC_ENGINE
}

; ==============================================================================
; End of SPC Code/Data in this bank.
; ==============================================================================

; $0D5337-$0D533F DATA
GARBAGE_1AD337:
{
    db $77, $00, $00, $00, $00, $01, $FF, $00, $00
}

; ==============================================================================

; $0D5340-$0D5380 DATA
NULL_1AD340:
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

; $0D5380-$0D63E3 DATA
SongBank_Credits_Main:
{
    ; Transfer size, transfer address
    dw $1060, SONG_POINTERS

    ; SPC $D000-$E05F DATA
    ; $0D5384-$0D53E3 DATA
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
    dw $0000
    dw Song20_TriforceRoom
    dw Song21_EndingTheme
    dw Song22_Credits
    dw $0000

    ; ==========================================================================

    ; SPC $D046-$D2FC DATA
    ; $0D53CA-$0D5680 DATA
    Song20_TriforceRoom:
    {
        incbin "bin/music/song20.bin"
    }

    ; SPC $D2FD-$E05F DATA
    ; $0D5681-$0D63E3 DATA
    Song22_Credits:
    {
        incbin "bin/music/song22.bin"
    }

    base off
}

; ==============================================================================

; $0D63E4-$0D7423 DATA
SongBank_Credits_Auxiliary:
{
    ; Transfer size, transfer address
    dw $1038, CREDITS_AUX_POINTER

    base CREDITS_AUX_POINTER

    ; SPC $2900-$3937 DATA
    ; $0D63E8-$0D741F DATA
    Song21_EndingTheme:
    {
        incbin "bin/music/song21.bin"
    }

    base off

    ; End of transfer
    ; $0D7420
    dw $0000, SPC_ENGINE
}

; ==============================================================================

; $0D7424-$0D742F
GARBAGE_1AF424:
{
    db $34, $00, $00, $00, $00, $01, $FF, $00, $00, $00, $00, $00
}

; $0D7430-$0D74FF NULL
NULL_1AF430:
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
}

; ==============================================================================

; $0D7500-$0D758F DATA
SpriteDraw_BatCrash_OAM_group:
{
    ; $0D7500
    .00
    dw   0,   0 : db $4B, $04, $00, $00

    ; $0D7508
    .01
    dw   5,  -4 : db $5B, $04, $00, $00

    ; $0D7510
    .02
    dw  -2,  -4 : db $64, $04, $00, $02

    ; $0D7518
    .03
    dw  -2,  -4 : db $49, $04, $00, $02

    ; $0D7520
    .04
    dw  -8,  -9 : db $6C, $04, $00, $02
    dw   8,  -9 : db $6C, $44, $00, $02

    ; $0D7530
    .05
    dw  -8,  -7 : db $4C, $04, $00, $02
    dw   8,  -7 : db $4C, $44, $00, $02

    ; $0D7540
    .06
    dw  -8,  -9 : db $44, $04, $00, $02
    dw   8,  -9 : db $44, $44, $00, $02

    ; $0D7550
    .07
    dw  -8,  -8 : db $62, $04, $00, $02
    dw   8,  -8 : db $62, $44, $00, $02

    ; $0D7560
    .08
    dw  -8,  -7 : db $60, $04, $00, $02
    dw   8,  -7 : db $60, $44, $00, $02

    ; $0D7570
    .09
    dw   0,   0 : db $4E, $04, $00, $02
    dw  16,   0 : db $4E, $44, $00, $02
    dw   0,  16 : db $6E, $04, $00, $02
    dw  16,  16 : db $6E, $44, $00, $02
}

; $0D7590-$0D75A4 DATA
Pool_BatCrash_Approach:
{
    ; $0D7590
    .position_x
    dw $07DC, $07F0, $0820, $0818

    ; $0D7598
    .position_y
    dw $062E, $0636, $0630, $05E0

    ; $0D75A0
    .anim_timer
    db 4, 3, 4, 6, 0
}

; ==============================================================================

; $0D75A5-$0D75D4
incsrc "sprite_waterfall.asm"

; $0D75D5-$0D785B
incsrc "sprite_retreat_bat.asm"

; ==============================================================================

; $0D785C-$0D788B DATA
DrinkingGuy_Draw_OAM_groups:
{
    dw 8,  2 : db $AE, $00, $00, $00
    dw 0, -9 : db $22, $08, $00, $02
    dw 0,  0 : db $06, $00, $00, $02
    
    dw 7,  0 : db $AF, $00, $00, $00
    dw 0, -9 : db $22, $08, $00, $02
    dw 0,  0 : db $06, $00, $00, $02        
}

; $0D788C-$0D78AB LONG JUMP LOCATION
DrinkingGuy_Draw:
{
    PHB : PHK : PLB
    
    LDA.w $0D40, X : ASL : ADC.w $0D40, X : ASL #3
    ADC.b #(.OAM_groups)              : STA.b $08
    LDA.b #(.OAM_groups) : ADC.b #$00 : STA.b $09
    
    LDA.b #$03 : STA.b $06
                 STZ.b $07
    
    JMP.w Lady_Draw_DrinkingGuy_continue
}

; ==============================================================================

; Generally speaking, this draws a lady sprite... can be young or old,
; but the same graphics either way.
; $0D792C-$0D7953 LONG JUMP LOCATION
Lady_Draw:
{
    PHB : PHK : PLB
    
    LDA.b #$02 : STA.b $06
                 STZ.b $07
    
    LDA.w $0DE0, X : ASL : ADC.w $0D40, X : ASL #4
    
    ; TODO: Figure out where the reference goes.
    ; OPTIMIZE: Add 0?
    ; $0D78AC
    ADC.b #$AC              : STA.b $08
    LDA.b #$F8 : ADC.b #$00 : STA.b $09
    
    ; $0D794A ALTERNATE ENTRY POINT
    .DrinkingGuy_continue
    
    JSL.l Sprite_DrawMultiple_player_deferred
    JSL.l Sprite_DrawShadowLong
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7954-$0D7970 LOCAL JUMP LOCATION
Sprite6_CheckIfActive:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .inactive
        LDA.w $0FC1 : BNE .inactive
            LDA.b $11 : BNE .inactive
                LDA.w $0CAA, X : BMI .active  
                    LDA.w $0F00, X : BEQ .active
    
    .inactive
    
    PLA : PLA
    
    .active
    
    RTS
}

; ==============================================================================

; $0D7971-$0D7980 DATA
Pool_Lanmola_SpawnShrapnel:
{
    ; $0D7971
    .speed_y
    db  28, -28,  28, -28,   0,  36,   0, -36

    ; $0D7979
    .speed_x
    db -28, -28,  28,  28, -36,   0,  36,   0
}
    
; $0D7981-$0D79E5 LONG JUMP LOCATION
Lanmola_SpawnShrapnel:
{
    ; Spawns Lanmolas' rocks when they pop out of the ground.
    LDY.b #$03
    
    LDA.w $0DD0 : CLC : ADC.w $0DD1 : ADC.w $0DD2 : CMP.b #$0A : BCS .BRANCH_ALPHA
        LDY.b #$07
    
    .BRANCH_ALPHA
    
    STY.w $0FB5
    
    .BRANCH_GAMMA
    
    LDA.b #$C2
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b $00 : ADC.b #$04 : STA.w $0D10, Y
        LDA.b $02 : ADC.b #$04 : STA.w $0D00, Y
        
        LDA.b #$01 : STA.w $0BA0, Y
                     STA.w $0CD2, Y
                     STA.w $0F60, Y
        
        DEC : STA.w $0F70, Y
        
        LDA.b #$20 : STA.w $0E40, Y
        
        PHX
        
        LDX.w $0FB5
        LDA.l Pool_Lanmola_SpawnShrapnel_speed_x, X : STA.w $0D50, Y
        LDA.l Pool_Lanmola_SpawnShrapnel_speed_y, X : STA.w $0D40, Y
        
        JSL.l GetRandomInt : AND.b #$01 : STA.w $0D40, Y
        
        PLX
    
    .spawn_failed
    
    DEC.w $0FB5 : BPL .BRANCH_GAMMA
    
    RTL
}

; ==============================================================================

; $0D79E6-$0D7B2B
incsrc "sprite_cukeman.asm"

; ==============================================================================

; $0D7B2C-$0D7B7A LONG JUMP LOCATION
RunningMan_SpawnDashDustGarnish:
{
    INC.w $0CBA, X
    LDA.w $0CBA, X : AND.b #$0F : BNE .delay
        PHX : TXY
        
        LDX.b #$1D
        
        .find_empty_slot
        
            LDA.l $7FF800, X : BEQ .empty_slot
        DEX : BPL .find_empty_slot
        
        INX
        
        .empty_slot
        
        LDA.b #$14 : STA.l $7FF800, X
                     STA.w $0FB4
        
        LDA.w $0D10, Y : CLC : ADC.b #$04 : STA.l $7FF83C, X
        LDA.w $0D30, Y       : ADC.b #$00 : STA.l $7FF878, X
        
        LDA.w $0D00, Y : CLC : ADC.b #$1C : STA.l $7FF81E, X
        LDA.w $0D20, Y       : ADC.b #$00 : STA.l $7FF85A, X
        
        LDA.b #$0A : STA.l $7FF90E, X
        
        PLX
    
    .delay
    
    RTL ; Original dissasembly had this as an RTS.
}

; ==============================================================================

; $0D7B7B-$0D7BDA DATA
Pool_Overworld_SubstituteAlternateSecret:
{
    ; $0D7B7B
    .AreaIndex
    db $00, $00, $00, $00, $00, $00, $00, $04
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $04, $04, $06, $04, $04, $06, $00, $00
    db $0F, $0F, $04, $05, $05, $04, $06, $06
    db $0F, $0F, $04, $05, $05, $07, $06, $06
    db $1F, $1F, $04, $07, $07, $04, $06, $06
    db $06, $07, $02, $00, $00, $00, $00, $00
    db $06, $06, $02, $00, $00, $00, $00, $00

    ; $D7BBB
    .ItemPool
    db $01, $01, $01, $01, $0F, $01, $01, $12
    db $10, $01, $01, $01, $11, $01, $01, $03

    ; $D7BCB
    .AreaMask
    db $00, $00, $00, $00, $02, $00, $00, $08
    db $10, $00, $00, $00, $01, $00, $00, $00
}

; $0D7BDB-$0D7C30 LONG JUMP LOCATION
Overworld_SubstituteAlternateSecret:
{
    PHB : PHK : PLB
    
    !num_live_sprites = $0D
    
    JSL.l GetRandomInt : AND.b #$01 : BNE .return
        STZ.b !num_live_sprites
        
        LDY.b #$0F
        
        .next_sprite
            
            LDA.w $0DD0, Y : BEQ .dead_sprite
                LDA.w $0E20, Y : CMP.b #$6C : BEQ .is_warp_vortex
                    INC.b !num_live_sprites
                
                .is_warp_vortex
            .dead_sprite
        DEY : BPL .next_sprite
        
        LDA.b !num_live_sprites : CMP.b #$04 : BCS .return
            LDA.l $7EF3C5 : CMP.b #$02 : BCC .return
                LDA.w $0CF7 : INC.w $0CF7 : AND.b #$07
                
                LDY.w $0FFF : BEQ .in_light_world
                    ORA.b #$08
                
                .in_light_world
                
                TAY
                
                PHX
                
                LDA.w $040A : AND.b #$3F : TAX
                LDA.w Pool_Overworld_SubstituteAlternateSecret_AreaIndex, X
                AND .AreaMask, Y : BNE .BRANCH_EPSILON
                    LDA.w Pool_Overworld_SubstituteAlternateSecret_ItemPool, Y : STA.w $0B9C
                
                .BRANCH_EPSILON
                
                PLX
    
    .return
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7C31-$0D7CEC
incsrc "sprite_movable_mantle.asm"

; ==============================================================================

; $0D7CED-$0D7DAC DATA
Pool_Mothula_Draw:
{
    .OAM_groups
    dw -24,  -8 : db $80, $00, $00, $02
    dw  -8,  -8 : db $82, $00, $00, $02
    dw   8,  -8 : db $82, $40, $00, $02
    dw  24,  -8 : db $80, $40, $00, $02
    dw -24,   8 : db $A0, $00, $00, $02
    dw  -8,   8 : db $A2, $00, $00, $02
    dw   8,   8 : db $A2, $40, $00, $02
    dw  24,   8 : db $A0, $40, $00, $02

    dw -24,  -8 : db $84, $00, $00, $02
    dw  -8,  -8 : db $86, $00, $00, $02
    dw   8,  -8 : db $86, $40, $00, $02
    dw  24,  -8 : db $84, $40, $00, $02
    dw -24,   8 : db $A4, $00, $00, $02
    dw  -8,   8 : db $A6, $00, $00, $02
    dw   8,   8 : db $A6, $40, $00, $02
    dw  24,   8 : db $A4, $40, $00, $02

    dw  -8,  -8 : db $88, $00, $00, $02
    dw  -8,  -8 : db $88, $00, $00, $02
    dw   8,  -8 : db $88, $40, $00, $02
    dw   8,  -8 : db $88, $40, $00, $02
    dw  -8,   8 : db $A8, $00, $00, $02
    dw  -8,   8 : db $A8, $00, $00, $02
    dw   8,   8 : db $A8, $40, $00, $02
    dw   8,   8 : db $A8, $40, $00, $02
}

; ==============================================================================

; $0D7DAD-$0D7DB4 LONG JUMP LOCATION
Mothula_DrawLong:
{
    ; Something related to drawing Mothula (Gamoth?) or his beams?
    PHB : PHK : PLB
    
    JSR.w Mothula_Draw
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7DB5-$0D7E7D LOCAL JUMP LOCATION
Mothula_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0D40, X
    
    REP #$20
    
    ASL #6 : ADC.w #$FCED : STA.b $08
    
    LDA.w #$0920 : STA.b $90
    LDA.w #$0A68 : STA.b $92
    
    SEP #$20
    
    LDA.b #$08
    JSL.l Sprite_DrawMultiple
    
    LDA.w $0F00, X : BNE .skip
        PHX
        
        LDA.w $0D40, X : ASL #3 : ADC.w $0D40, X : STA.b $06
        
        LDA.b $02 : CLC : ADC.w $0F70, X : STA.b $02
        LDA.b $03       : ADC.b #$00     : STA.b $03
        
        LDY.b #$28
        LDX.b #$08

        .next_OAM_entry

            PHX
            
            TXA : CLC : ADC.b $06 : ASL : TAX
            
            REP #$20
            
            LDA.b $00 : CLC : ADC.w .x_offsets, X : STA.b ($90), Y
            AND.w #$0100                          : STA.b $0E
            
            INY
            
            LDA.b $02 : CLC : ADC.w #$0010 : STA.b ($90), Y
            CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
                LDA.b #$F0 : STA.b ($90), Y

            .on_screen_y

            INY
            
            LDA.b #$6C : STA.b ($90), Y
            
            INY
            
            LDA.b #$24 : STA.b ($90), Y
            
            PHY
            
            TYA : LSR : LSR : TAY
            LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_OAM_entry
        
        PLX
    
    .skip
    
    RTS
    
    .x_offsets
    dw   0,   3,   6,   9,  12,  -3,  -6,  -9
    dw -12,   0,   2,   4,   6,   8,  -2,  -4
    dw  -6,  -8,   0,   1,   2,   3,   4,  -1
    dw  -2,  -3,  -4
}

; ==============================================================================

; $0D7E7E-$0D7E87 DATA
Pool_BottleVendor_PayForGoodBee:
{
    ; $0D7E7E
    .x_speeds
    db -6, -3,  0,  4,  7
    
    ; $0D7E83
    .y_speeds
    db 11, 14, 16, 14, 11
}

; $0D7E88-$0D7ECE LONG JUMP LOCATION
BottleVendor_PayForGoodBee:
{
    PHB : PHK : PLB
    
    LDA.b #$13
    JSL.l Sound_SetSfx3PanLong
    
    LDA.b #$04 : STA.w $0FB5
    
    .next_red_rupee
    
        LDA.b #$DB
        JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.b $00 : CLC : ADC.b #$04 : STA.w $0D10, Y
            
            LDA.b #$FF : STA.w $0B58, Y
            
            PHX
            
            LDX.w $0FB5
            LDA.w .x_speeds, X : STA.w $0D50, Y
            LDA.w .y_speeds, X : STA.w $0D40, Y
            
            LDA.b #$20 : STA.w $0F80, Y
                         STA.w $0F10, Y
            
            PLX
        
        .spawn_failed
    DEC.w $0FB5 : BPL .next_red_rupee
    
    PLB
    
    RTL
}

; ==============================================================================

; $0D7ECF-$0D7ED2 LONG JUMP LOCATION
Sprite_ChickenLadyLong:
{
    JSR.w Sprite_ChickenLady        
    
    RTL
}

; ==============================================================================

; $0D7ED3-$0D7EFF LOCAL JUMP LOCATION
Sprite_ChickenLady:
{
    LDA.b #$01 : STA.w $0DE0, X
    
    JSL.l Lady_Draw
    JSR.w Sprite6_CheckIfActive
    
    LDA.w $0DF0, X : CMP.b #$01 : BNE .anoshow_message
        ; "Cluck cluck...  What?! (...) I can even speak! ...".
        LDA.b #$7D : STA.w $1CF0
        LDA.b #$01 : STA.w $1CF1
        JSL.l Sprite_ShowMessageMinimal
    
    .anoshow_message
    
    LDA.b $1A : LSR #4 : AND.b #$01 : STA.w $0D40, X
    
    RTS
}

; ==============================================================================

; $0D7F00-$0D7F2A LONG JUMP LOCATION
SpritePrep_DiggingGameGuy:
{
    LDA.w $0D00, X : STA.b $00
    LDA.w $0D20, X : STA.b $01
    
    REP #$20
    
    LDA.b $20 : CMP.b $00 : SEP #$30 : BCS .player_below_proprietor
        ; This is in case you warp into the digging game field from the light
        ; world (as a result of the mirror warp vortex taking you back to the
        ; dark world).
        LDA.b #$05 : STA.w $0D80, X
        
        LDA.w $0D10, X : SEC : SBC.b #$09 : STA.w $0D10, X
        
        LDA.b #$01 : STA.w $0D40, X
    
    .player_below_proprietor
    
    INC.w $0BA0, X
    
    RTL
}

; ==============================================================================

; $0D7F2B-$0D7F3B DATA
Pool_Player_SpawnSmallWaterSplashFromHammer:
{
    ; $0D7F2B
    .x_offsets
    dw 0, 12, -8, 24
    
    ; $0D7F33
    .y_offsets
    dw 8, 32, 24, 24
    
    ; $0D7F3B
    .easy_out
    RTL
}

; ==============================================================================

; $0D7F3C-$0D7FFD LONG JUMP LOCATION
Player_SpawnSmallWaterSplashFromHammer:
{
    LDA.b $11 : ORA.w $02E4 : ORA.w $0FC1 : BNE Pool_Player_SpawnSmallWaterSplashFromHammer_easy_out
        PHX : PHY
        
        LDY.b $2F
        
        REP #$20
        
        LDA.b $22 : CLC : ADC.l .x_offsets, X : STA.b $00
        LDA.b $20 : CLC : ADC.l .y_offsets, X : STA.b $02
        
        SEP #$20
        
        LDA.b $EE : CMP.b #$01

        REP #$30
        
        STZ.b $05
        BCC .on_bg2
            LDA.w #$1000 : STA.b $05
        
        .on_bg2
        
        SEP #$20
        
        LDA.b $1B : REP #$20 : BEQ .outdoors
            LDA.b $00 : AND.w #$01FF : LSR #3 : STA.b $04
            LDA.b $02 : AND.w #$01F8 : ASL #3
            CLC : ADC.b $04 : CLC : ADC.b $05 : TAX
            
            LDA.l $7F2000, X
            
            BRA .check_tile_type
        
        .outdoors
        
        LDA.b $02          : PHA
        LDA.b $00 : LSR #3 : STA.b $02
        PLA                : STA.b $00
        
        SEP #$30
        
        JSL.l Overworld_ReadTileAttr
        
        REP #$10
        
        .check_tile_type
        
        SEP #$30
        
        CMP.b #$08 : BEQ .water_tile
            CMP.b #$09 : BNE .not_water_tile
                .water_tile
                
                JSL.l Sprite_SpawnSmallWaterSplash : BMI .spawn_failed
                    LDY.b $2F
                    LDA.b $20 : CLC : ADC.l .y_offsets, X : PHP : SEC : SBC.b #$10        : STA.w $0D00, Y
                    LDA.b $21       : SBC.b #$00          : PLP : ADC.l .y_offsets + 1, X : STA.w $0D20, Y
                    
                    LDA.b $22 : CLC : ADC.l .x_offsets, X : PHP : SEC : SBC.b #$08        : STA.w $0D10, Y
                    LDA.b $23       : SBC.b #$00          : PLP : ADC.l .x_offsets + 1, X : STA.w $0D30, Y
                    
                    LDA.b $EE : STA.w $0F20, Y
                    LDA.b #$00 : STA.w $0F70, Y
                    
                    PLX : PLY
                
                .spawn_failed
        .not_water_tile
        
        RTL
}

; ==============================================================================

; $0D7FFE-$0D7FFF NULL
NULL_1AFFFE:
{
    db $FF, $FF
}

; ==============================================================================

warnpc $1B8000
