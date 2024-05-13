
; ==============================================================================

; $06B080-$06B817 DATA
Pool_Sprite_LoadProperties:
{
    ; $06B080
    ; $0E40 - OAM allocation and misc settings.
    db $01, $02, $01, $82, $81, $84, $84, $84
    db $02, $0F, $02, $01, $20, $03, $04, $84
    db $01, $05, $04, $01, $80, $04, $A2, $83
    db $04, $02, $82, $62, $82, $80, $80, $85
    db $01, $A5, $03, $04, $04, $83, $02, $01
    db $82, $A2, $A2, $A3, $AA, $A3, $A4, $82
    db $82, $83, $82, $80, $82, $82, $A5, $80
    db $A4, $82, $81, $82, $82, $82, $81, $06
    db $08, $08, $08, $08, $06, $08, $08, $08
    db $06, $07, $07, $02, $02, $22, $01, $01
    db $20, $82, $07, $85, $0F, $21, $05, $83
    db $02, $01, $01, $01, $01, $07, $07, $07
    db $07, $00, $85, $83, $03, $A4, $00, $00
    db $00, $00, $09, $04, $A0, $00, $01, $00
    db $00, $03, $8B, $86, $C2, $82, $81, $04
    db $82, $21, $06, $03, $01, $03, $03, $03
    db $00, $00, $04, $05, $05, $03, $01, $02
    db $00, $00, $00, $02, $07, $00, $01, $01
    db $87, $06, $00, $83, $02, $22, $22, $22
    db $22, $04, $03, $05, $01, $01, $04, $01
    db $02, $08, $08, $80, $21, $03, $03, $03
    db $02, $02, $08, $8F, $A1, $81, $80, $80
    db $80, $80, $A1, $80, $81, $81, $86, $81
    db $82, $82, $80, $80, $83, $06, $00, $00
    db $05, $04, $06, $05, $02, $00, $00, $05
    db $04, $04, $07, $0B, $0C, $0C, $06, $06
    db $03, $A4, $04, $82, $81, $83, $10, $10
    db $81, $82, $82, $82, $83, $83, $83, $81
    db $82, $83, $83, $81, $82, $81, $82, $A0
    db $A1, $A3, $A1, $A1, $A1, $83, $85, $83
    db $83, $83, $83
    
    ; $06B173
    ; $0E50 - Health
    db $0C, $06, $FF, $03, $03, $03, $03, $03
    db $02, $0C, $04, $FF, $00, $03, $0C, $02
    db $00, $14, $04, $04, $00, $FF, $00, $02
    db $03, $08, $00, $00, $00, $00, $00, $00
    db $08, $03, $08, $02, $02, $00, $03, $FF
    db $00, $03, $03, $03, $03, $03, $03, $03
    db $03, $00, $03, $00, $03, $03, $03, $00
    db $03, $00, $00, $00, $00, $03, $02, $FF
    db $02, $06, $04, $08, $06, $08, $06, $04
    db $08, $08, $08, $04, $04, $02, $02, $02
    db $FF, $08, $FF, $30, $10, $08, $08, $FF
    db $02, $00, $00, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $04, $04, $FF, $FF
    db $FF, $FF, $10, $03, $00, $02, $04, $01
    db $FF, $04, $FF, $00, $00, $00, $00, $FF
    db $00, $00, $60, $FF, $18, $FF, $FF, $FF
    db $03, $04, $FF, $10, $08, $08, $00, $FF
    db $20, $20, $20, $20, $20, $08, $08, $04
    db $08, $40, $30, $FF, $02, $FF, $FF, $FF
    db $FF, $10, $04, $02, $04, $04, $08, $08
    db $08, $10, $40, $40, $08, $04, $08, $04
    db $04, $08, $0C, $10, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $80, $30, $FF
    db $FF, $FF, $FF, $08, $00, $00, $00, $20
    db $00, $08, $05, $28, $28, $28, $5A, $10
    db $18, $40, $00, $04, $00, $00, $FF, $FF
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00
    
    ; $06B266
    ; Goes into $0CD2 - Bump damage.
    db $83, $83, $81, $02, $02, $02, $02, $02
    db $01, $13, $01, $01, $01, $01, $08, $01
    db $01, $08, $05, $03, $40, $04, $00, $02
    db $03, $85, $00, $01, $00, $40, $00, $00
    db $06, $00, $05, $03, $01, $00, $00, $03
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $40
    db $00, $00, $00, $00, $00, $00, $02, $02
    db $00, $01, $01, $03, $01, $03, $01, $01
    db $03, $03, $03, $01, $03, $01, $01, $01
    db $01, $01, $01, $11, $14, $01, $01, $02
    db $05, $00, $00, $04, $04, $08, $08, $08
    db $08, $04, $00, $04, $03, $02, $02, $02
    db $02, $02, $03, $01, $00, $00, $01, $80
    db $05, $01, $00, $00, $00, $40, $00, $04
    db $00, $00, $14, $04, $06, $04, $04, $04
    db $04, $03, $04, $04, $04, $01, $04, $04
    db $15, $05, $04, $05, $15, $15, $03, $05
    db $00, $05, $15, $05, $05, $06, $06, $06
    db $06, $05, $03, $06, $05, $05, $03, $03
    db $03, $06, $17, $15, $15, $05, $05, $01
    db $85, $83, $05, $04, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $17, $17, $05
    db $05, $05, $04, $03, $02, $10, $00, $06
    db $00, $05, $07, $17, $17, $17, $15, $07
    db $06, $10, $00, $03, $03, $00, $19, $19
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $10, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00
    
    ; $06B359
    ; $0E60 - Misc settings
    ; And last 4 bits into $0F50 - Byte 4 $90 properties (palette, priority, H and V flip).
    db $19, $0B, $1B, $4B, $41, $41, $41, $4D
    db $1D, $01, $1D, $19, $8D, $1B, $09, $9D
    db $3D, $01, $09, $11, $40, $01, $4D, $19
    db $07, $1D, $59, $80, $4D, $40, $01, $49
    db $1B, $41, $03, $13, $15, $41, $18, $1B
    db $41, $47, $0F, $49, $4B, $4D, $41, $47
    db $49, $4D, $49, $40, $4D, $47, $49, $41
    db $74, $47, $5B, $58, $51, $49, $1D, $5D
    db $03, $19, $1B, $17, $19, $17, $19, $1B
    db $17, $17, $17, $1B, $0D, $09, $19, $19
    db $49, $5D, $5B, $49, $0D, $03, $13, $41
    db $1B, $5B, $5D, $43, $43, $4D, $4D, $4D
    db $4D, $4D, $49, $01, $00, $41, $4D, $4D
    db $4D, $4D, $1D, $09, $C4, $0D, $0D, $09
    db $03, $03, $4B, $47, $47, $49, $49, $41
    db $47, $36, $8B, $49, $1D, $49, $43, $43
    db $43, $0B, $41, $0D, $07, $0B, $1D, $43
    db $0D, $43, $0D, $1D, $4D, $4D, $1B, $1B
    db $0A, $0B, $00, $05, $0D, $01, $01, $01
    db $01, $0B, $05, $01, $01, $01, $07, $17
    db $19, $0D, $0D, $80, $4D, $19, $17, $19
    db $0B, $09, $0D, $4A, $12, $49, $C3, $C3
    db $C3, $C3, $76, $40, $59, $41, $58, $4F
    db $73, $5B, $44, $41, $51, $0A, $0B, $0B
    db $4B, $00, $40, $5B, $0D, $00, $00, $0D
    db $4B, $0B, $59, $41, $0B, $0D, $01, $0D
    db $0D, $00, $50, $4C, $44, $51, $01, $01
    db $F2, $F8, $F4, $F2, $D4, $D4, $D4, $F8
    db $F8, $F4, $F4, $D8, $F8, $D8, $DF, $C8
    db $69, $C1, $D2, $D2, $DC, $C7, $C1, $C7
    db $C7, $C7, $C1
    
    ; $06B44C
    ; $0F60 - Alive / hit box properties.
    db $00, $00, $00, $43, $43, $43, $43, $43
    db $00, $00, $00, $00, $1C, $00, $00, $02
    
    db $01, $03, $00, $00, $03, $C0, $07, $00
    db $00, $00, $07, $45, $43, $00, $40, $0D
    
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $07, $07, $07, $07, $07, $07, $0D, $07
    
    db $07, $07, $07, $03, $07, $07, $07, $40
    db $03, $07, $0D, $00, $07, $07, $00, $00
    
    db $09, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $00, $00, $00, $00
    
    db $80, $12, $09, $09, $00, $40, $00, $0C
    db $00, $00, $00, $40, $40, $10, $10, $2E
    
    db $2E, $40, $1E, $53, $00, $0A, $00, $00
    db $00, $00, $12, $12, $40, $00, $00, $40
    
    db $19, $00, $00, $0A, $0D, $0A, $0A, $80
    db $0A, $41, $00, $40, $00, $49, $00, $00
    
    db $C0, $00, $40, $00, $00, $40, $00, $00
    db $09, $80, $C0, $00, $40, $00, $00, $80
    
    db $00, $00, $18, $5A, $00, $D4, $D4, $D4
    db $D4, $00, $40, $00, $80, $80, $40, $40
    
    db $40, $00, $09, $1D, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $0A, $1B, $1B
    
    db $1B, $1B, $41, $00, $03, $07, $07, $03
    db $0A, $00, $01, $0A, $0A, $09, $00, $00
    
    db $00, $00, $09, $00, $00, $40, $40, $00
    db $00, $00, $00, $89, $80, $80, $00, $1C
    
    db $00, $40, $00, $00, $1C, $07, $03, $03
    db $44, $44, $44, $44, $44, $44, $44, $44
    
    db $44, $44, $44, $43, $44, $43, $40, $C0
    db $C0, $C7, $C3, $C3, $C0, $1B, $08, $1B
    
    db $1B, $1B, $03
    
    ; $06B53F
    ; $0B6B - Tile hit box and other misc settings.
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $0A, $00, $01, $30, $00, $00, $20
    db $10, $00, $00, $01, $00, $00, $00, $00
    db $00, $00, $00, $08, $20, $00, $04, $00
    db $00, $00, $00, $00, $00, $00, $01, $04
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $68
    db $60, $61, $61, $61, $61, $61, $61, $61
    db $61, $61, $61, $61, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $00, $00, $70
    db $00, $00, $00, $90, $90, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $60, $60, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $80
    db $00, $00, $02, $00, $00, $70, $00, $00
    db $00, $00, $00, $00, $00, $00, $B0, $00
    db $C2, $00, $20, $00, $02, $00, $00, $00
    db $00, $00, $02, $00, $B0, $00, $00, $00
    db $00, $00, $00, $00, $A0, $A0, $00, $00
    db $00, $04, $02, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $C2, $00, $00
    db $00, $00, $00, $00, $04, $00, $00, $00
    db $00, $00, $00, $02, $02, $02, $02, $00
    db $00, $00, $00, $00, $00, $00, $0A, $0A
    db $10, $10, $10, $10, $00, $00, $00, $10
    db $10, $10, $10, $00, $10, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00
    
    ; $06B632
    ; $0BE0 - Prize pack and other misc settings.
    db $83, $96, $84, $80, $80, $80, $80, $80
    db $02, $00, $02, $80, $A0, $83, $97, $80
    db $80, $94, $91, $07, $00, $80, $00, $80
    db $92, $96, $80, $A0, $00, $00, $00, $80
    db $04, $80, $82, $06, $06, $00, $00, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $00, $00, $80, $80, $90
    db $80, $91, $91, $91, $97, $91, $95, $95
    db $93, $97, $14, $91, $92, $81, $82, $82
    db $80, $85, $80, $80, $80, $04, $04, $80
    db $91, $80, $80, $80, $80, $80, $80, $80
    db $80, $00, $80, $80, $82, $8A, $80, $80
    db $80, $80, $92, $91, $80, $82, $81, $81
    db $80, $81, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $97, $80, $80, $80
    db $80, $C2, $80, $15, $15, $17, $06, $00
    db $80, $00, $C0, $13, $40, $00, $02, $06
    db $10, $14, $00, $00, $40, $00, $00, $00
    db $00, $13, $46, $11, $80, $80, $00, $00
    db $00, $10, $00, $00, $00, $16, $16, $16
    db $81, $87, $82, $00, $80, $80, $00, $00
    db $00, $00, $80, $80, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $80, $00, $00, $00, $17
    db $00, $12, $00, $00, $00, $00, $00, $10
    db $17, $00, $40, $01, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $40, $00, $00, $00, $00
    db $00, $00, $00, $00, $80, $00, $00, $00
    db $00, $00, $00
    
    ; $06B725
    ; $0CAA - Deflection properties
    db $00, $00, $44, $20, $20, $20, $20, $20
    db $00, $81, $00, $00, $48, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $04, $00
    db $00, $00, $00, $48, $24, $80, $00, $00
    db $00, $20, $00, $00, $00, $80, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $80
    db $80, $00, $00, $00, $00, $00, $00, $80
    db $00, $80, $00, $02, $00, $00, $00, $04
    db $80, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $84, $00, $81, $05, $01, $40, $08, $A0
    db $00, $00, $00, $00, $00, $84, $84, $84
    db $84, $08, $80, $80, $80, $00, $80, $80
    db $80, $80, $00, $08, $80, $00, $00, $00
    db $40, $00, $00, $00, $00, $00, $00, $00
    db $00, $02, $01, $00, $00, $04, $00, $00
    db $00, $00, $80, $04, $04, $00, $00, $48
    db $00, $00, $04, $00, $01, $01, $00, $00
    db $80, $00, $00, $00, $40, $08, $08, $08
    db $08, $00, $00, $00, $80, $80, $00, $00
    db $00, $04, $01, $05, $00, $00, $00, $00
    db $00, $00, $00, $04, $02, $00, $80, $80
    db $80, $80, $82, $80, $00, $00, $80, $00
    db $00, $80, $80, $00, $00, $01, $01, $40
    db $00, $00, $04, $00, $00, $00, $00, $00
    db $00, $00, $04, $05, $05, $05, $80, $80
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $00, $82, $82, $08, $80, $20, $80
    db $80, $80, $20
}

; ==============================================================================

; $06B818-$06B870 LONG JUMP LOCATION
Sprite_LoadProperties:
{
    ; Load's sprite characteristics, such as HP
    
    JSL Sprite_ResetProperties
    
    PHY
    
    PHB : PHK : PLB
    
    LDY $0E20, X ; What kind of sprite is it?
    
    LDA.w $B080, Y : STA $0E40, X
    
    LDA.w $B173, Y : STA $0E50, X ; Load its HP.
    LDA.w $B44C, Y : STA $0F60, X ; ????
    LDA.w $B632, Y : STA $0BE0, X
    LDA.w $B725, Y : STA $0CAA, X
    LDA.w $B266, Y : STA $0CD2, X ; Load how much damage the sprite can do.
    LDA.w $B53F, Y : STA $0B6B, X
    
    ; Load the outdoor area number.
    LDA $040A
    
    LDY $1B : BEQ .outdoors
        ; If indoors, instead load the room number. (in this case, the lower byte)
        LDA $048E
    
    .outdoors
    
    ; And store that index here.
    STA $0C9A, X
    
    PLB
    
    PLY
    
    ; $06B85C ALTERNATE ENTRY POINT
    Sprite_LoadPalette:
    
    PHY
    
    PHB : PHK : PLB
    
    ; Again, tell us what sprite it is
    LDY $0E20, X
    
    LDA.w $B359, Y : STA $0E60, X : AND.b #$0F : STA $0F50, X
    
    PLB
    
    PLY
    
    RTL
}

; ==============================================================================

; $06B871-$06B8F0 LONG JUMP LOCATION
Sprite_ResetProperties:
{
    STZ $0F00, X
    STZ $0E90, X
    STZ $0D50, X
    STZ $0D40, X
    STZ $0F80, X
    STZ $0D70, X
    STZ $0D60, X
    STZ $0F90, X
    STZ $0D80, X
    STZ $0DC0, X
    STZ $0DE0, X
    STZ $0DF0, X
    STZ $0E00, X
    STZ $0E10, X
    STZ $0F10, X
    STZ $0EB0, X
    STZ $0EC0, X
    STZ $0ED0, X
    STZ $0EF0, X
    STZ $0E70, X
    STZ $0F70, X
    STZ $0E50, X
    STZ $0EA0, X
    STZ $0F40, X
    STZ $0F30, X
    STZ $0D90, X
    STZ $0DA0, X
    STZ $0DB0, X
    STZ $0BB0, X
    STZ $0E80, X
    STZ $0BA0, X
    STZ $0B89, X
    STZ $0F50, X
    STZ $0B58, X
    STZ $0CE2, X
    
    LDA.b #$00 : STA $7FFA1C, X
                 STA $7FFA2C, X
                 STA $7FFA3C, X
                 STA $7FFA4C, X
                 STA $7FF9C2, X
    
    RTL
}

; ==============================================================================

; $06B8F1-$06B970 (This data is used in bank 0x06, so look there)
{
    db $00, $01, $20, $FF, $FC, $FB, $00, $00
    db $00, $02, $40, $04, $00, $00, $00, $00
    
    db $00, $04, $40, $02, $03, $00, $00, $00
    db $00, $08, $40, $04, $00, $00, $00, $00
    
    db $00, $10, $40, $08, $00, $00, $00, $00
    db $00, $10, $40, $08, $00, $00, $00, $00
    
    db $00, $04, $40, $10, $00, $00, $00, $00
    db $00, $FF, $40, $FF, $FC, $FB, $00, $00
    
    db $00, $04, $40, $FF, $FC, $FB, $20, $00
    db $00, $64, $18, $64, $00, $00, $00, $00
    
    db $00, $F9, $FA, $FF, $64, $00, $00, $00
    db $00, $08, $40, $FD, $04, $10, $00, $00
    
    db $00, $08, $40, $FE, $04, $00, $00, $00
    db $00, $10, $40, $FD, $00, $00, $00, $00
    
    db $00, $FE, $40, $10, $00, $00, $00, $00
    db $00, $20, $40, $FF, $00, $00, $00, $FA
}
    

; ==============================================================================

; $06B971-$06BA70 DATA
Sprite_SimplifiedTileAttr:
{
    db 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0
    
    db 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 3, 3, 3
    
    db 0, 0, 0, 0, 0, 0, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
    
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; row 7
    
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
}

; ==============================================================================
