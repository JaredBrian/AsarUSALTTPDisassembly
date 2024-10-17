; ==============================================================================

; Bank 0E
; $070000-$077FFF
org $0E8000

; Dialog control and data
; End cutscene
; Credits
; Message code
; Message dictionary data
; Overworld overlay cotrol and data

; ==============================================================================

; $070000-$070FFF
incbin "binary_files/font_gfx.bin"

; ==============================================================================

; $071000-$071429 DATA
Pool_Dungeon_LoadCustomTileAttr:
{
    ; $071000
    .group_offsets
    dw $0000, $0000, $0000, $0080, $0080, $0100, $0100, $0100
    dw $0180, $0000, $0100, $0200, $0280, $0300, $0380, $0100
    dw $0100, $0080, $0100, $0380, $0100
    
    ; $07102A
    .groups
    ; This consists of customized tile behaviors based on the value of the
    ; current BG tileset ($0AA2).
    db $02, $02, $02, $02, $02, $02, $6E, $6F
    db $01, $6C, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $00, $00
    db $00, $00, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $6E, $6F
    db $01, $6C, $02, $02, $02, $02, $01, $02
    db $00, $00, $22, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $00, $00, $01, $00
    db $01, $01, $01, $01, $01, $01, $01, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $01, $01, $01, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $18, $00, $00, $00
    db $00, $00, $02, $02, $01, $01, $01, $01
    db $02, $02, $02, $01, $02, $02, $08, $08
    db $08, $08, $09, $09, $09, $09, $09, $09
        
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $18, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $02, $02, $08, $08
    db $08, $08, $09, $09, $09, $09, $09, $09
        
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $00, $00, $02, $00
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $02, $02
    db $6B, $6A, $02, $01, $02, $02, $08, $08
    db $08, $08, $09, $09, $09, $09, $68, $69
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $09, $09, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $00, $00, $00, $00
    db $01, $01, $01, $00, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $08, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $18, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $02, $02
    db $08, $08, $02, $01, $01, $09, $08, $08
    db $08, $08, $09, $09, $09, $09, $09, $09
    
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $00, $00, $00, $00
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $00, $0F, $00
    db $00, $00, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $02, $02, $08, $08
    db $08, $08, $0E, $0E, $0E, $0E, $00, $00

    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $02, $02
    db $01, $02, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $00, $00, $00, $00
    db $01, $01, $01, $01, $02, $02, $02, $0D
    db $0D, $02, $02, $02, $02, $02, $02, $02
    db $01, $01, $01, $01, $02, $02, $02, $0D
    db $0D, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $02, $02
    db $6B, $6A, $02, $01, $02, $02, $08, $08
    db $08, $08, $09, $09, $09, $09, $68, $69

    db $B2, $B4, $B1, $BB, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $B3, $B5, $B0, $B6, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $00, $00, $00, $00
    db $B1, $B2, $B3, $B4, $B5, $B1, $B0, $02
    db $BE, $02, $02, $02, $02, $02, $B7, $B8
    db $B0, $B2, $B3, $B4, $B5, $02, $B0, $02
    db $00, $02, $B1, $BE, $00, $BD, $B9, $BA
    db $02, $02, $B1, $B0, $02, $00, $00, $00
    db $BD, $BC, $02, $02, $02, $02, $02, $02
    db $00, $00, $00, $00, $00, $0E, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00

    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $02, $02, $02, $02, $02, $02
    db $00, $00, $22, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $00, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $00, $00, $00, $00, $02, $02
    db $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $00, $00, $00, $00, $02, $02
    db $02, $02, $02, $02, $18, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01
    db $6B, $6A, $02, $01, $02, $02, $08, $08
    db $08, $08, $0E, $0E, $0E, $0E, $68, $69
}

; ==============================================================================

; $07142A-$071458 LONG JUMP LOCATION
Dungeon_LoadCustomTileAttr:
{
    ; Loads tile attributes that are specific to a tileset type.
    ; The group loaded is dependent on the value of $0AA2.
    PHB : PHK : PLB
        
    REP #$30
        
    LDA.w $0AA2 : AND.w #$00FF : ASL A : TAX
        
    LDA Pool_Dungeon_LoadCustomTileAttr_group_offsets, X : TAY
        
    LDX.w #$0000
    
    .load_loop
    
        LDA Pool_Dungeon_LoadCustomTileAttr_groups, Y       : STA.l $7EFF40, X
        LDA Pool_Dungeon_LoadCustomTileAttr_groups + $40, Y : STA.l $7EFF80, X
        
        INY #2
    INX #2 : CPX.w #$0040 : BNE .load_loop
        
    SEP #$30
        
    PLB
        
    RTL
}

; ==============================================================================

; $071459-$071658 DATA (Note: This data is not accessed from this bank.)
Overworld_TileAttr:
{
    db $27, $27, $27, $27, $27, $27, $02, $02, $01, $01, $01, $00, $00, $00, $00, $00
    db $27, $01, $01, $01, $01, $01, $02, $02, $27, $27, $27, $00, $00, $00, $00, $00
    db $27, $01, $01, $01, $20, $01, $02, $02, $27, $27, $27, $00, $00, $00, $00, $00
    db $27, $01, $01, $01, $01, $20, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00
    db $01, $01, $01, $01, $1A, $01, $12, $01, $01, $02, $01, $01, $28, $2E, $2A, $2B
    db $01, $01, $18, $18, $1A, $01, $12, $01, $01, $2C, $02, $2D, $29, $2F, $02, $02
    db $01, $01, $01, $01, $01, $01, $02, $01, $02, $2E, $00, $00, $2C, $00, $4E, $4F
    db $01, $01, $01, $01, $01, $01, $02, $01, $02, $00, $2E, $00, $00, $00, $02, $22
    db $01, $01, $02, $00, $00, $00, $18, $12, $02, $02, $00, $48, $00, $00, $00, $00
    db $01, $01, $02, $00, $01, $01, $10, $1A, $02, $00, $00, $48, $00, $00, $00, $00
    db $10, $10, $02, $00, $01, $01, $01, $01, $00, $00, $48, $00, $00, $09, $00, $00
    db $02, $02, $02, $00, $01, $01, $2B, $00, $00, $09, $00, $00, $00, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
    db $01, $01, $01, $46, $01, $01, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00
    db $02, $02, $42, $02, $02, $02, $02, $02, $02, $02, $29, $22, $00, $00, $00, $00
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $29, $22, $00, $00, $00, $00
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $02, $44
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $00, $00, $00, $02, $44
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $00, $00, $00, $00, $00
    db $01, $01, $43, $01, $01, $01, $01, $01, $02, $02, $02, $00, $00, $00, $00, $00
    db $50, $02, $54, $51, $57, $57, $56, $56, $27, $27, $27, $00, $40, $40, $48, $48
    db $50, $02, $54, $51, $57, $2A, $56, $56, $27, $27, $27, $00, $40, $40, $57, $48
    db $27, $02, $52, $53, $02, $01, $12, $18, $55, $55, $00, $00, $48, $02, $02, $00
    db $27, $02, $52, $53, $09, $01, $1A, $10, $55, $55, $00, $00, $48, $02, $02, $00
    db $02, $02, $18, $08, $08, $08, $09, $09, $08, $08, $29, $02, $02, $02, $1A, $02
    db $08, $08, $10, $08, $12, $00, $09, $09, $09, $09, $09, $48, $09, $29, $00, $4B
    db $02, $02, $02, $00, $08, $02, $02, $00, $00, $00, $00, $01, $00, $00, $20, $00
    db $02, $02, $02, $02, $02, $02, $02, $00, $00, $01, $01, $01, $02, $00, $08, $00
}

; ==============================================================================

; $071659-$0717D8 DATA
Dungeon_DefaultAttr:
{
    db $01, $01, $01, $00, $02, $01, $02, $00, $01, $01, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $00, $00, $01, $00, $00, $02, $00, $00, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $01, $01, $01, $02, $02, $02, $02, $02, $01, $01, $00, $00
    db $02, $02, $02, $02, $02, $02, $01, $02, $02, $02, $02, $02, $01, $01, $00, $00
    
    db $00, $00, $00, $2A, $01, $20, $01, $01, $04, $01, $01, $18, $01, $02, $1C, $01
    db $28, $28, $2A, $2A, $01, $02, $01, $01, $04, $00, $00, $00, $28, $01, $0A, $00
    db $01, $01, $0C, $0C, $02, $02, $02, $02, $28, $2A, $20, $20, $20, $02, $08, $00
    db $04, $04, $01, $01, $01, $02, $02, $02, $00, $00, $20, $20, $00, $02, $00, $00
    
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $18, $10, $10, $01, $01, $01
    db $01, $01, $04, $04, $04, $04, $04, $04, $01, $02, $02, $00, $00, $00, $00, $00
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02
    
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $62, $62
    db $00, $00, $24, $24, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $62, $62
    db $27, $02, $02, $02, $27, $27, $01, $00, $00, $00, $00, $24, $00, $00, $00, $00
    db $27, $27, $27, $27, $27, $10, $02, $01, $00, $00, $00, $24, $00, $00, $00, $00
    
    db $27, $02, $02, $02, $27, $27, $27, $27, $02, $02, $02, $24, $00, $00, $00, $00
    db $27, $27, $27, $27, $27, $20, $02, $02, $01, $02, $02, $23, $02, $00, $00, $00
    db $27, $27, $27, $27, $27, $20, $02, $27, $02, $54, $00, $00, $27, $02, $02, $02
    db $27, $27, $27, $27, $27, $27, $02, $27, $02, $54, $00, $00, $27, $02, $02, $02
    
    ; Values before this comment go to $7EFE00-$7EFF3F, values after
    ; it end up at $7EFFC0-$7EFFFF. The remaining memory contains values
    ; from the custom attributes data.
    
    db $27, $27, $00, $27, $60, $60, $01, $01, $01, $01, $02, $02, $0D, $00, $00, $4B
    db $67, $67, $67, $67, $66, $66, $66, $66, $00, $00, $20, $20, $20, $20, $20, $20
    db $27, $63, $27, $55, $55, $01, $44, $00, $01, $20, $02, $02, $1C, $3A, $3B, $00
    db $27, $63, $27, $53, $53, $01, $44, $01, $0D, $00, $00, $00, $09, $09, $09, $09
}
    
; ==============================================================================

; $0717D9-$071813 LONG JUMP LOCATION
Init_LoadDefaultTileAttr:
{
    REP #$20
        
    LDX.b #$3E
    
    .loop
    
        LDA Dungeon_DefaultAttr + $0000, X : STA.l $7EFE00, X
        LDA Dungeon_DefaultAttr + $0040, X : STA.l $7EFE40, X
        LDA Dungeon_DefaultAttr + $0080, X : STA.l $7EFE80, X
        LDA Dungeon_DefaultAttr + $0100, X : STA.l $7EFEC0, X
        LDA Dungeon_DefaultAttr + $0140, X : STA.l $7EFF00, X
        LDA Dungeon_DefaultAttr + $0180, X : STA.l $7EFFC0, X
    DEX #2 : BPL .loop
        
    SEP #$30
        
    RTL
}

; ==============================================================================

; $071814-$07181F NULL
NULL_0E9814:
{
    ; $0C bytes of null.
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; Notes: the combination 9889, 9958 is an outdoor scene the combination 9891,
; 99C5 is an indoor scene (sanctuary, etc). Anything after those combinations
; is of the second part of the ending  Specifically, the credits set against
; the Triforce spinning in the air, overlooking the golden land.
; Parameter: $11
; Usage: Main Module 1A
; $071820-$07186D DATA TABLE
Pool_Module_EndSequence:
{ 
    dw Credits_LoadNextScene_Overworld    ; 0x00 - $9889 Hyrule Castle restored
    dw Credits_ScrollScene_Overworld      ; 0x01 - $9958 
    dw Credits_LoadNextScene_Underworld   ; 0x02 - $9891 Priest Recovers
    dw Credits_ScrollScene_Underworld     ; 0x03 - $99C5
    dw Credits_LoadNextScene_Overworld    ; 0x04 - $9889 Sahasralah's Homecoming
    dw Credits_ScrollScene_Overworld      ; 0x05 - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x06 - $9889 Vultures rule the desert
    dw Credits_ScrollScene_Overworld      ; 0x07 - $9958
    
    dw Credits_LoadNextScene_Overworld    ; 0x08 - $9889 The Bully makes a friend
    dw Credits_ScrollScene_Overworld      ; 0x09 - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x0A - $9889 Uncle recovers
    dw Credits_ScrollScene_Overworld      ; 0x0B - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x0C - $9889 Zora's Area Scene
    dw Credits_ScrollScene_Overworld      ; 0x0D - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x0E - $9889 Witch and Assistant
    dw Credits_ScrollScene_Overworld      ; 0x0F - $9958
    
    dw Credits_LoadNextScene_Overworld    ; 0x10 - $9889 Twin Lumberjacks
    dw Credits_ScrollScene_Overworld      ; 0x11 - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x12 - $9889 Fluteboy plays again
    dw Credits_ScrollScene_Overworld      ; 0x13 - $9958
    dw Credits_LoadNextScene_Underworld   ; 0x14 - $9891 Venus, queen of Fairys (and herpes)
    dw Credits_ScrollScene_Underworld     ; 0x15 - $99C5
    dw Credits_LoadNextScene_Underworld   ; 0x16 - $9891 Dwarven Swordsmiths
    dw Credits_ScrollScene_Underworld     ; 0x17 - $99C5
    
    dw Credits_LoadNextScene_Overworld    ; 0x18 - $9889 The Bug Catching Kid
    dw Credits_ScrollScene_Overworld      ; 0x19 - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x1A - $9889 The Lost Old Man
    dw Credits_ScrollScene_Overworld      ; 0x1B - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x1C - $9889 The Forest Thief
    dw Credits_ScrollScene_Overworld      ; 0x1D - $9958
    dw Credits_LoadNextScene_Overworld    ; 0x1E - $9889 Master Sword Sleeps Again, Forever!
    dw Credits_ScrollScene_Overworld      ; 0x1F - $9958
    
    dw Credits_InitializeTheActualCredits ; 0x20 - $BC6D Sets up for mode 0x22. Various other things
    dw Credits_BrightenTriangles          ; 0x21 - $C37C Light up the triforce and the screen
    dw Credits_FadeColorAndBeginAnimating ; 0x22 - $BD8B Scrolls the credits, and number of deaths, etc.
    dw Credits_StopCreditsScroll          ; 0x23 - $C391
    dw Credits_FadeAndDisperseTriangles   ; 0x24 - $C3B8
    dw Credits_FadeInTheEnd               ; 0x25 - $C3D5
    dw Credits_DrawTheEnd_HangForever     ; 0x26 - $C41A
}

; Module 0x1A - Ending Sequence Mode
; $07186E-$071888 JUMP LOCATION
Module_EndSequence:
{   
    REP #$20
        
    LDA.w #$0030 : STA.w $0FE0
    LDA.w #$01D0 : STA.w $0FE2
        
    STZ.w $0FE4
        
    SEP #$20
        
    ; Load the level 1 submodule index and used it to index into a jump table.
    LDA.b $11 : ASL A : TAX
        
    SR.w (Pool_Module_EndSequence, X)
        
    RTL
}
    
; $071889-$071890 LOCAL JUMP LOCATION
Credits_LoadNextScene_Overworld:
{
    ; For overworld portions:
    JSL.l Credits_LoadScene_Overworld
    SR.w Credits_AddEndingSequenceText
        
    RTS
}
    
; $071891-$071898 LOCAL JUMP LOCATION
Credits_LoadNextScene_Underworld:
{
    ; For dungeon portions
    JSL.l Credits_LoadScene_Dungeon ; Module 1A's basecamp in Bank02.
    SR.w Credits_AddEndingSequenceText
}

; Seems to be prep functions.
; $071899-$0718B8 JUMP TABLE
Pool_Credits_PrepAndLoadSprites:
{
    dw Credits_LoadSprites_GenericOW ; 0x00 - $9CFE
    dw Credits_LoadSprites_GenericUW ; 0x01 - $9D84 Priest recovers
    dw Credits_LoadSprites_Kakariko1 ; 0x02 - $9C27
    dw Credits_LoadSprites_Desert    ; 0x03 - $9C2F
    dw Credits_LoadSprites_GenericOW ; 0x04 - $9CFE
    dw Credits_LoadSprites_GenericOW ; 0x05 - $9CFE
    dw Credits_LoadSprites_Zora      ; 0x06 - $9C1A
    dw Credits_LoadSprites_Witch     ; 0x07 - $9CCA
    dw Credits_LoadSprites_GenericOW ; 0x08 - $9CFE
    dw Credits_LoadSprites_Grove     ; 0x09 - $9C5B
    dw Credits_LoadSprites_Venus     ; 0x0A - $9D5C Venus, goddess of fairies
    dw Credits_LoadSprites_Smithy    ; 0x0B - $9D70
    dw Credits_LoadSprites_Kakariko2 ; 0x0C - $9CD1 The Bug-Catching Kid
    dw Credits_LoadSprites_GenericOW ; 0x0D - $9CFE The Lost Old Man
    dw Credits_LoadSprites_LostWoods ; 0x0E - $9C92 The Forest Thief
    dw Credits_LoadSprites_Pedestal  ; 0x0F - $9CB4 And the Master Sword sleeps again... 
}

; $0718B9-$0718D7 LONG JUMP LOCATION
Credits_PrepAndLoadSprites:
{
    PHB : PHK : PLB
        
    LDX.b #$0F

    .loop

        JSL.l Sprite_ResetProperties
        
        STZ.w $0DD0, X
        STZ.w $0BE0, X
        STZ.w $0CAA, X
    DEX : BPL .loop
        
    LDA.b $11 : AND.b #$FE : TAX
        
    SR.w (Pool_Credits_PrepAndLoadSprites, X)
        
    PLB
        
    RTL
}

; $0718D8-$071957 DATA
Pool_Credits_ScrollScene:
{
    ; $0718D8
    .target_y
    dw $06F2 ; Hyrule Castle
    dw $0210 ; Sanctuary
    dw $072C ; Kakariko
    dw $0C00 ; Desert
    dw $010C ; Tower of Hera
    dw $0A9B ; Link's house
    dw $0010 ; Zora's Domain
    dw $0510 ; Potion shop
    dw $0089 ; Lumberjacks
    dw $0A8E ; Haunted Grove
    dw $222C ; Wishing Well
    dw $2510 ; Smithery
    dw $0826 ; Kakariko (bug net)
    dw $005C ; Death Mountain
    dw $020A ; Lost Woods
    dw $0030 ; Master Sword

    ; $0718F8
    .target_x
    dw $077F ; Hyrule Castle
    dw $0480 ; Sanctuary
    dw $0193 ; Kakariko
    dw $00AA ; Desert
    dw $0878 ; Tower of Hera
    dw $0847 ; Link's house
    dw $04FD ; Zora's Domain
    dw $0C57 ; Potion shop
    dw $040F ; Lumberjacks
    dw $0478 ; Haunted Grove
    dw $0A00 ; Wishing Well
    dw $0200 ; Smithery
    dw $0201 ; Kakariko (bug net)
    dw $0AA1 ; Death Mountain
    dw $026F ; Lost Woods
    dw $0000 ; Master Sword

    ; $071918
    .movement_y
    dw  -1   ; Hyrule Castle
    dw  -1   ; Sanctuary
    dw   1   ; Kakariko
    dw  -1   ; Desert
    dw   1   ; Tower of Hera
    dw   1   ; Link's house
    dw   0   ; Zora's Domain
    dw   1   ; Potion shop
    dw   0   ; Lumberjacks
    dw  -1   ; Haunted Grove
    dw  -1   ; Wishing Well
    dw   0   ; Smithery
    dw   0   ; Kakariko (bug net)
    dw   0   ; Death Mountain
    dw   1   ; Lost Woods
    dw  -1   ; Master Sword

    ; $071938
    .movement_x
    dw   0   ; Hyrule Castle
    dw   0   ; Sanctuary
    dw  -1   ; Kakariko
    dw   0   ; Desert
    dw   0   ; Tower of Hera
    dw  -1   ; Link's house
    dw   1   ; Zora's Domain
    dw   0   ; Potion shop
    dw  -1   ; Lumberjacks
    dw   0   ; Haunted Grove
    dw   0   ; Wishing Well
    dw   0   ; Smithery
    dw   1   ; Kakariko (bug net)
    dw  -1   ; Death Mountain
    dw   1   ; Lost Woods
    dw   0   ; Master Sword
}

; $071958-$0719A4 LOCAL JUMP LOCATION
Credits_ScrollScene_Overworld:
{
    PHB : PHK : PLB
        
    LDX.b #$0F
    
    .loop
    
        LDA.w $0DF0, X : BEQ .BRANCH_ALPHA
            DEC.w $0DF0, X
        
        .BRANCH_ALPHA
    DEX : BPL .loop
        
    LDA.b $11 : AND.b #$FE : TAX
        
    STZ.b $30
    STZ.b $31
        
    REP #$20
        
    LDA.b $C8
        
    CMP.w #$0040 : BCC .BRANCH_GAMMA
    AND.w #$0001 : BNE .BRANCH_GAMMA
        LDA.b $E8 : CMP.w Pool_Credits_ScrollScene_target_y, X : BEQ .BRANCH_DELTA
            LDY.w Pool_Credits_ScrollScene_movement_y, X : STY.b $30
        
        .BRANCH_DELTA
    
        LDA.b $E2 : CMP.w Pool_Credits_ScrollScene_target_x, X : BEQ .BRANCH_GAMMA
            LDY.w Pool_Credits_ScrollScene_movement_x, X : STY.b $31
        
    .BRANCH_GAMMA
    
    REP #$20
        
    PHX
        
    JSL.l Credits_OperateScrollingAndTilemap
        
    PLX
        
    SR.w (Pool_Credits_ScrollScene_Underworld, X)
        
    JMP Credits_HandleSceneFade
}

; ==============================================================================

; $0719A5-$0719C4 LOCAL JUMP TABLE ; Actual run time functions.
Pool_Credits_ScrollScene_Underworld:
{
    dw Credits_SpriteDraw_Castle        ; 0x00 - $9E9C Whew just one was a lot of work.
    dw Credits_SpriteDraw_Sanctuary     ; 0x01 - $A9AD Priest recovers
    dw Credits_SpriteDraw_Kakariko1     ; 0x02 - $A0E2
    dw Credits_SpriteDraw_Desert        ; 0x03 - $A941
    dw Credits_SpriteDraw_Hera          ; 0x04 - $9F53
    dw Credits_SpriteDraw_House         ; 0x05 - $A27C
    dw Credits_SpriteDraw_Zora          ; 0x06 - $A74C
    dw Credits_SpriteDraw_Witch         ; 0x07 - $A9D3
    dw Credits_SpriteDraw_Lumberjacks   ; 0x08 - $A393
    dw Credits_SpriteDraw_Grove         ; 0x09 - $AA91
    dw Credits_SpriteDraw_Venus         ; 0x0A - $A3C7
    dw Credits_SpriteDraw_Smithy        ; 0x0B - $A802
    dw Credits_SpriteDraw_Kakariko2     ; 0x0C - $A54F
    dw Credits_SpriteDraw_DeathMountain ; 0x0D - $A358
    dw Credits_SpriteDraw_LostWoods     ; 0x0E - $ABF5
    dw Credits_SpriteDraw_Pedestal      ; 0x0F - $AD22
}

; Dungeon Engine for Ending sequence (module 1A).
; $0719C5-$071A09 LOCAL JUMP LOCATION
Credits_ScrollScene_Underworld:
{
    PHB : PHK : PLB
        
    LDX.b #$0F
    
    .BRANCH_BETA
    
        LDA.w $0DF0, X
        
        BEQ .BRANCH_ALPHA
            ; Countdown sprite timer
            DEC.w $0DF0, X
        
        .BRANCH_ALPHA
    DEX : BPL .BRANCH_BETA
        
    LDA.b $11 : AND.b #$FE : TAX
        
    REP #$20
        
    LDA.b $C8 : CMP.w #$0040 : BCC .BRANCH_GAMMA
              AND.w #$0001 : BNE .BRANCH_GAMMA
        LDA.b $E8 : CMP.w Pool_Credits_ScrollScene_target_y, X : BEQ .BRANCH_DELTA
            CLC : ADC.w Pool_Credits_ScrollScene_movement_y, X : STA.b $E8
        
        .BRANCH_DELTA
    
        LDA.b $E2 : CMP.w Pool_Credits_ScrollScene_target_x, X : BEQ .BRANCH_GAMMA
            CLC : ADC.w Pool_Credits_ScrollScene_movement_x, Y : STA.b $E2
    
    .BRANCH_GAMMA
    
    SEP #$20
        
    SR.w (Pool_Credits_ScrollScene_Underworld, X)

    ; Why.... this just jumps to the function right after acomplishing
    ; literally nothing.
    JMP.w Credits_HandleSceneFade
}

; $071A0A-$071A29 DATA
Pool_Credits_HandleSceneFade:
{
    .timer
    dw $0300 ;  768 - Hyrule Castle
    dw $0280 ;  640 - Sanctuary
    dw $0250 ;  592 - Kakariko
    dw $02E0 ;  736 - Desert
    dw $0280 ;  640 - Tower of Hera
    dw $0250 ;  592 - Link's house
    dw $02C0 ;  704 - Zora's Domain
    dw $02C0 ;  704 - Potion shop
    dw $0250 ;  592 - Lumberjacks
    dw $0250 ;  592 - Haunted Grove
    dw $0280 ;  640 - Wishing Well
    dw $0250 ;  592 - Smithery
    dw $0480 ; 1152 - Kakariko (bug net)
    dw $0400 ; 1024 - Death Mountain
    dw $0250 ;  592 - Lost Woods
    dw $0500 ; 1280 - Master Sword
}

; $071A2A-$071A75 JUMP LOCATION
Credits_HandleSceneFade:
{
    LDA.b $11 : AND.b #$FE : TAX
        
    REP #$20
        
    LDA.b $C8 : CMP Pool_Credits_HandleSceneFade, X : SEP #$20 : BCC .BRANCH_ALPHA
        LDA.b $C8 : AND.b #$01 : BNE .BRANCH_BETA
            DEC.b $13 : BNE .BRANCH_BETA
        
            INC.b $11
        
            BRA .BRANCH_GAMMA
    
    .BRANCH_ALPHA
    
    LDA.b $C8 : AND.b #$01 : BNE .BRANCH_BETA
        LDA.b $13 : CMP.b #$0F : BEQ .BRANCH_BETA
            INC.b $13
    
    .BRANCH_BETA
    
    REP #$20
        
    INC.b $C8
        
    SEP #$20
    
    .BRANCH_GAMMA
    
    REP #$20
        
    LDA.b $E2 : STA.w $011E
    LDA.b $E8 : STA.w $0122
    LDA.b $E0 : STA.w $0120
    LDA.b $E6 : STA.w $0124
        
    SEP #$20
        
    PLB
        
    RTS
}

; $071A76-$071C19 DATA
Credits_SpriteData:
{
    ; $071A76
    .castle_position_x
    dw $01E0 ; King
    dw $0200 ; Zelda
    dw $01ED ; Maiden 3
    dw $0203 ; Maiden 4
    dw $01DA ; Maiden 2
    dw $0216 ; Maiden 5
    dw $01C8 ; Maiden 1
    dw $0228 ; Maiden 6
    dw $01C0 ; Guard 1
    dw $01E0 ; Guard 2
    dw $0208 ; Guard 3
    dw $0228 ; Guard 4

    ; $071A8E
    .castle_position_y
    dw $0158 ; King
    dw $0158 ; Zelda
    dw $0138 ; Maiden 3
    dw $0138 ; Maiden 4
    dw $0140 ; Maiden 2
    dw $0140 ; Maiden 5
    dw $0150 ; Maiden 1
    dw $0150 ; Maiden 6
    dw $0120 ; Guard 1
    dw $0120 ; Guard 2
    dw $0120 ; Guard 3
    dw $0120 ; Guard 4

    ; $071AA6
    .kak1_position_x
    dw $0278
    dw $0298
    dw $01E0
    dw $0200
    dw $0220
    dw $0288
    dw $01E2

    ; $071AB4
    .kak1_position_y
    dw $00C2
    dw $00C2
    dw $016B
    dw $016C
    dw $016B
    dw $00B8
    dw $016B

    ; $071AC2
    .hera_position_x
    dw $0335
    dw $0335
    dw $0300

    ; $071AC8
    .hera_position_y
    dw $0128
    dw $0128
    dw $016F

    ; $071ACE
    .house_position_x
    dw $00B8
    dw $00CE
    dw $00AC
    dw $00C4

    ; $071AD6
    .house_position_y
    dw $00F5
    dw $00FC
    dw $010D
    dw $010D

    ; $071ADE
    .mountain_position_x
    dw $0180

    ; $071AE0
    .mountain_position_y
    dw $00D8

    ; $071AE2
    .bumpkin_position_x
    dw $0080

    ; $071AE4
    .bumpkin_position_y
    dw $00F4

    ; $071AE6
    .venus_position_x
    dw $0070
    dw $0070
    dw $0070
    dw $0068
    dw $0088
    dw $0070

    ; $071AF2
    .venus_position_y
    dw $003C
    dw $003C
    dw $003C
    dw $0090
    dw $0080
    dw $003C

    ; $071AFE
    .kak2_position_x
    dw $00C8
    dw $0278
    dw $0258
    dw $01D8
    dw $01C8
    dw $0188
    dw $0270

    ; $071B0C
    .kak2_position_y
    dw $0250
    dw $02B0
    dw $02B0
    dw $02A0
    dw $02B0
    dw $02B0
    dw $02B8

    ; $071B1A
    .zora_position_x
    dw $03B0
    dw $0390
    dw $03D0

    ; $071B20
    .zora_position_y
    dw $0040
    dw $0040
    dw $0040

    ; $071B26
    .smithy_position_x
    dw $0040
    dw $0070
    dw $004F
    dw $0061
    dw $0037
    dw $0079

    ; $071B32
    .smithy_position_y
    dw $016C
    dw $016C
    dw $0174
    dw $0174
    dw $0175
    dw $0175

    ; $071B3E
    .desert_position_x
    dw $00E0
    dw $0150
    dw $00E8
    dw $0168
    dw $0128
    dw $0170
    dw $0170

    ; $071B4C
    .desert_position_y
    dw $0080
    dw $0060
    dw $0146
    dw $0146
    dw $01C6
    dw $0070
    dw $0070

    ; $071B5A
    .sanc_position_x
    dw $00F8
    dw $00F0

    ; $071B5E
    .sanc_position_y
    dw $0060
    dw $0037

    ; $071B62
    .witch_position_x
    dw $00F8
    dw $00C8

    ; $071B66
    .witch_position_y
    dw $0150
    dw $0158

    ; $071B6A
    .grove_position_x
    dw $00F8
    dw $00F8
    dw $00F8
    dw $00F8
    dw $00F8
    dw $00E8
    dw $00F8
    dw $00D8
    dw $00F8
    dw $00C8
    dw $0108

    ; $071B80
    .grove_position_y
    dw $0120
    dw $0120
    dw $0120
    dw $0120
    dw $0120
    dw $0108
    dw $0100
    dw $00D8
    dw $00D8
    dw $00F0
    dw $00F0

    ; $071B96
    .lostwoods_position_x
    dw $02E8
    dw $0270
    dw $0270
    dw $02A0
    dw $02A0
    dw $02A4
    dw $02FC

    ; $071BA4
    .lostwoods_position_y
    dw $024B
    dw $01B0
    dw $01C8
    dw $01C8
    dw $01B0
    dw $0230
    dw $0230

    ; $071BB2
    .pedestal_position_x
    dw $0076
    dw $0073
    dw $0076
    dw $0000
    dw $00D0
    dw $0080

    ; $071BBE
    .pedestal_position_y
    dw $008B
    dw $0083
    dw $0085
    dw $002C
    dw $00F8
    dw $0100

    ; $071BCA
    .position_x_pointers
    dw .castle_position_x
    dw .sanc_position_x
    dw .kak1_position_x
    dw .desert_position_x
    dw .hera_position_x
    dw .house_position_x
    dw .zora_position_x
    dw .witch_position_x
    dw .bumpkin_position_x
    dw .grove_position_x
    dw .venus_position_x
    dw .smithy_position_x
    dw .kak2_position_x
    dw .mountain_position_x
    dw .lostwoods_position_x
    dw .pedestal_position_x

    ; $071BEA
    .position_y_pointers
    dw .castle_position_y
    dw .sanc_position_y
    dw .kak1_position_y
    dw .desert_position_y
    dw .hera_position_y
    dw .house_position_y
    dw .zora_position_y
    dw .witch_position_y
    dw .bumpkin_position_y
    dw .grove_position_y
    dw .venus_position_y
    dw .smithy_position_y
    dw .kak2_position_y
    dw .mountain_position_y
    dw .lostwoods_position_y
    dw .pedestal_position_y

    ; $071C0A
    .sprite_count
    db  11 ; Hyrule Castle
    db   1 ; Sanctuary
    db   6 ; Kakariko
    db   6 ; Desert
    db   2 ; Tower of Hera
    db   3 ; Link's house
    db   2 ; Zora's Domain
    db   1 ; Potion shop
    db   0 ; Lumberjacks
    db  10 ; Haunted Grove
    db   5 ; Wishing Well
    db   5 ; Smithery
    db   6 ; Kakariko (bug net)
    db   0 ; Death Mountain
    db   6 ; Lost Woods
    db   5 ; Master Sword
}

; $071C1A-$071C55 LOCAL JUMP LOCATION
Credits_LoadSprites_Zora:
{
    LDA.b #$FF : STA.w $0DF0 : STA.w $0DF1 : STA.w $0DF2
        
    BRA Credits_LoadSprites_Desert_Bounce
}

; $071C27-$071C55 LOCAL JUMP LOCATION
Credits_LoadSprites_Kakariko1:
{
    LDA CreditsSpriteSpeeds_y_speed_limits_negative : STA.w $0D46
        
    BRA Credits_LoadSprites_Desert_Bounce
}

; $071C2F LOCAL JUMP LOCATION
Credits_LoadSprites_Desert:
{
    LDA.b #$16 : STA.w $0D95
        
    LDA CreditsSpriteSpeeds_y_speed_limits_negative : STA.w $0D40
    LDA CreditsSpriteSpeeds_y_speed_limits          : STA.w $0D41
        
    LDA.b #$01 : STA.w $0EB1
        
    LDY.b #$02
    
    .loop
    
        LDA.b #$57 : STA.w $0E22, Y
        
        LDA.b #$31 : STA.w $0F52, Y
    DEY : BPL .loop
    
    ; $071C54 ALTERNATE ENTRY POINT
    .Bounce
    
    BRA Credits_LoadSprites_Grove_Bounce
}

; $071C56-$071C5A DATA
Pool_Credits_LoadSprites_Grove:
{
    .sprite_timers
    db $00, $13, $26, $39, $4C
}

; $071C5B-$071C91 LOCAL JUMP LOCATION
Credits_LoadSprites_Grove:
{
    LDY.b #$04
    
    .loop1
    
        LDA Pool_Credits_LoadSprites_Grove_sprite_timers, Y : STA.w $0DF0, Y
        
        LDA.b #$00 : STA.w $0DD0, Y
    DEY : BPL .loop1
        
    LDA.b #$2E : STA.w $0E25
        
    LDY.b #$01
    
    .loop2
    
        LDA.b #$9F : STA.w $0E27, Y
        LDA.b #$A0 : STA.w $0E29, Y
        
        LDA.b #$01 : STA.w $0E47, Y : INC A : STA.w $0E49, Y
        LDA.b #$10 : STA.w $0E67, Y :         STA.w $0E69, Y
    DEY : BPL .loop2

    ; $071C90 ALTERNATE ENTRY POINT
    .Bounce
  
    BRA Credits_LoadSprites_GenericOW
}
    
; $071C92-$071CB3 LOCAL JUMP LOCATION
Credits_LoadSprites_LostWoods:
{
    LDA CreditsSpriteSpeeds_y_speed_limits_negative : STA.w $0D45
    LDA CreditsSpriteSpeeds_y_speed_limits          : STA.w $0D46
        
    LDA.b #$01 : STA.w $0EB6
    LDA.b #$08 : STA.w $0D90
        
    LDY.b #$03
    
    .loop
    
        LDA.b #$04 : STA.w $0D41, Y
    DEY : BPL .loop
        
    BRA Credits_LoadSprites_GenericOW
}

; $071CB4-$071CC9 LOCAL JUMP LOCATION
Credits_LoadSprites_Pedestal:
{
    LDA.b #$02 : STA.w $0DB4
    LDA.b #$08 : STA.w $0D45
    LDA.b #$13 : STA.w $0DF1
        
    LDA.b #$40 : STA.w $0DF4
        
    BRA Credits_LoadSprites_GenericOW
}

; $071CCA-$071CD0 LOCAL JUMP LOCATION
Credits_LoadSprites_Witch:
{
    LDA.b #$FF : STA.w $0DF1
        
    BRA Credits_LoadSprites_GenericOW
}

; $071CD1-$071CFD LOCAL JUMP LOCATION
Credits_LoadSprites_Kakariko2:
{
    LDY.b #$01
    
    .loop
    
        LDA.b #$39 : STA.w $0F53, Y
        LDA.b #$0B : STA.w $0E23, Y
        LDA.b #$10 : STA.w $0E63, Y
        LDA.b #$01 : STA.w $0E43, Y
    DEY : BPL .loop
        
    LDA.b #$2A : STA.w $0E25
        
    LDA.b #$79 : STA.w $0E26
    LDA.b #$01 : STA.w $0D86
    LDA.b #$05 : STA.w $0F76

    ; Bleed into the next function.
}

; $071CFE-$071D5B LOCAL JUMP LOCATION
Credits_LoadSprites_GenericOW:
{
    LDA Credits_SpriteData_position_x_pointers, X      : STA.b $04
    LDA Credits_SpriteData_position_x_pointers + $1, X : STA.b $05
    LDA Credits_SpriteData_position_y_pointers, X      : STA.b $06
    LDA Credits_SpriteData_position_y_pointers + $1, X : STA.b $07
        
    TXA : LSR A : TAX
        
    LDA Credits_SpriteData_sprite_count, X : TAX
    
    .loop
    
        TXA : ASL A : TAY
        
        REP #$20
        
        LDA.w #$FFFF : STA.w $0FBA
                       STA.w $0FB8
        
        LDA.w $040A : ASL A
        XBA : AND.w #$0F00 : CLC : ADC ($04), Y : STA.b $00
        
        LDA.w $040A : LSR A : LSR A 
        XBA : AND.w #$0E00 : CLC : ADC ($06), Y : STA.b $02
        
        SEP #$20
        
        LDA.b $00 : STA.w $0D10
        LDA.b $01 : STA.w $0D30
        LDA.b $02 : STA.w $0D00
        LDA.b $03 : STA.w $0D20 
    DEX : BPL .loop
        
    RTS
}

; $071D5C-$071D6F LOCAL JUMP LOCATION
Credits_LoadSprites_Venus:
{
    LDA.b #$10 : STA.w $0DF1
    LDA.b #$20 : STA.w $0DF2
        
    LDA.b #$08 : STA.w $0F53 : STA.w $0F54
        
    BRA Credits_LoadSprites_GenericUW
}
    
; $071D70-$071D83 LOCAL JUMP LOCATION
Credits_LoadSprites_Smithy:
{
    LDA.b #$79 : STA.w $0F54
    LDA.b #$39 : STA.w $0F55
        
    LDA.b #$01 : STA.w $0DE1
    LDA.b #$04 : STA.w $0D91

    ; Bleed into next function.
}

; $071D84-$071DEF LOCAL JUMP LOCATION
Credits_LoadSprites_GenericUW:
{
    REP #$20
        
    LDA.w $048E : LSR #3
        
    SEP #$20
        
    AND.b #$FE : STA.w $0FB1
        
    LDA.w $048E : AND.b #$0F : ASL A : STA.w $0FB0
        
    LDA Credits_SpriteData_position_x_pointers, X      : STA.b $04
    LDA Credits_SpriteData_position_x_pointers + $1, X : STA.b $05
    LDA Credits_SpriteData_position_y_pointers, X      : STA.b $06
    LDA Credits_SpriteData_position_y_pointers + $1, X : STA.b $07
        
    TXA : LSR A : TAX
        
    ; Number of sprites in ending sequence.
    LDA Credits_SpriteData_sprite_count, X : TAX
    
    .loop
    
        TXA : ASL A : TAY
        
        LDA.w $0FB1 : XBA
        
        LDA.b #$00
        
        REP #$20
        
        CLC : ADC ($06), Y : STA.b $02
        
        SEP #$20
        
        LDA.w $0FB0 : XBA
        
        LDA.b #$00
        
        REP #$20
        
        CLC : ADC ($04), Y : STA.b $00
        
        SEP #$20
        
        LDA.b $00 : STA.w $0D10, X
        LDA.b $01 : STA.w $0D30, X
        LDA.b $02 : STA.w $0D00, X
        LDA.b $03 : STA.w $0D20, X
    DEX : BPL .loop
        
    RTS
}

; $071DF0-$071E1F DATA
CreditsOAMGroup_King:
{
    dw  -3,  17 : db $2B, $00, $00, $00
    dw  -3,  25 : db $3B, $00, $00, $00
    dw   0,   0 : db $0E, $00, $00, $02
    dw  16,   0 : db $0E, $40, $00, $02
    dw   0,  16 : db $2E, $00, $00, $02
    dw  16,  16 : db $2E, $40, $00, $02
}

; $071E20-$071E37 DATA
CreditsOAMGroup_Zelda:
{
    dw   8,   5 : db $04, $0A, $00, $02
    dw   0,  16 : db $06, $08, $00, $02
    dw  16,  16 : db $06, $48, $00, $02
}

; $071E38-$071E47 DATA
CreditsOAMGroup_Maiden:
{
    dw   0,   0 : db $00, $00, $00, $02
    dw   0,  11 : db $02, $00, $00, $02
}

; $071E48-$071E77 DATA
CreditsOAMGroup_Guard:
{
    dw   1,   4 : db $2A, $00, $00, $00
    dw   1,  12 : db $3A, $00, $00, $00
    dw   4,   0 : db $26, $00, $00, $02
    dw   0,   9 : db $24, $00, $00, $02
    dw   8,   9 : db $24, $40, $00, $02
    dw   4,  20 : db $6C, $01, $00, $02
}

; $071E78-$071E9B DATA
Pool_Credits_SpriteDraw_Castle:
{
    ; $071E78
    .pointer_offset
    db $1E ; King
    db $20 ; Zelda
    db $22 ; Maiden 3
    db $22 ; Maiden 4
    db $22 ; Maiden 2
    db $22 ; Maiden 5
    db $22 ; Maiden 1
    db $22 ; Maiden 6
    db $16 ; Guard 1
    db $16 ; Guard 2
    db $16 ; Guard 3
    db $16 ; Guard 4

    ; $071E84
    .group_size
    db $06 ; King
    db $03 ; Zelda
    db $02 ; Maiden 3
    db $02 ; Maiden 4
    db $02 ; Maiden 2
    db $02 ; Maiden 5
    db $02 ; Maiden 1
    db $02 ; Maiden 6
    db $06 ; Guard 1
    db $06 ; Guard 2
    db $06 ; Guard 3
    db $06 ; Guard 4

    ; $071E90
    .props
    db $3B ; King
    db $31 ; Zelda
    db $3D ; Maiden 3
    db $3F ; Maiden 4
    db $39 ; Maiden 2
    db $3B ; Maiden 5
    db $37 ; Maiden 1
    db $3D ; Maiden 6
    db $39 ; Guard 1
    db $37 ; Guard 2
    db $37 ; Guard 3
    db $39 ; Guard 4
}

; $071E9C-$071EE0 LOCAL JUMP LOCATION
Credits_SpriteDraw_Castle:
{
	PHX
	
	LDX.b #$0B

    .loop1

        LDA.w Pool_Credits_SpriteDraw_Castle_props, X : STA.w $0F50, X
        
        LDA.w Pool_Credits_SpriteDraw_Castle_group_size, X
        LDY.w Pool_Credits_SpriteDraw_Castle_pointer_offset, X
        
        SR.w Credits_SpriteDraw_Single
	DEX : CPX.b #$07 : BNE .loop1

    .loop2

        LDA.b $1A : ASL #2 : AND.b #$40 : ORA.w Pool_Credits_SpriteDraw_Castle_props, X : STA.w $0F50, X
        
        LDA.w Pool_Credits_SpriteDraw_Castle_group_size, X
        LDY.w Pool_Credits_SpriteDraw_Castle_pointer_offset, X
        
        SR.w Credits_SpriteDraw_Single
	DEX : CPX.b #$01 : BNE .loop2

    .loop3

        LDA.w Pool_Credits_SpriteDraw_Castle_props, X : STA.w $0F50, X
        
        LDA.w Pool_Credits_SpriteDraw_Castle_group_size, X
        LDY.w Pool_Credits_SpriteDraw_Castle_pointer_offset, X
        
        SR.w Credits_SpriteDraw_Single
    DEX : BPL .loop3
    
	PLX
	
	RTS
}

; $071EE1-$071F00 DATA
CreditsOAMGroup_Bully:
{
    dw   0, -10 : db $4C, $08, $00, $02
    dw   0,   0 : db $6C, $0A, $00, $02
    dw   0,  -9 : db $4C, $08, $00, $02
    dw   0,   0 : db $A8, $0A, $00, $02
}

; $071F01-$071F20 DATA
CreditsOAMGroup_Victim:
{
    dw   0,  -7 : db $4A, $08, $00, $02
    dw   0,   0 : db $6A, $0C, $00, $02
    dw   0,  -7 : db $4A, $08, $00, $02
    dw   0,   0 : db $A6, $0C, $00, $02
}

; $071F21-$071F28 DATA
CreditsOAMGroup_HeraPortal:
{
    dw   0,   0 : db $86, $00, $00, $02
}

; $071F29-$071F53 DATA
Pool_Credits_SpriteDraw_Hera:
{
    ; $071F29
    .group_data_index
    db $30 ; Bully
    db $32 ; Victim

    ; $071F2B
    .object_count
    db $02 ; Bully
    db $02 ; Victim

    ; $071F2D
    .movement_control
    db $20, $00, $00, $00

    ; $071F31
    .speed_x
    db   0, -12

    ; $071F33
    .speed_y
    db -16, -12,   0,  12
    db  16,  12,   0, -12

    ; $071F3B
    .timer
    db  59,  20,  30,  29
    db  44,  43,  66,  32
    db  39,  40

    ; This seems to be the only part of the data that's used.
    db  46,  56,  58,  76,  50,  68

    db  46,  47,  30,  40,  71,  53,  50,  48
}

; $071F53-$071FBF LOCAL JUMP LOCATION
Credits_SpriteDraw_Hera:
{
    PHX
    
    LDY.b #$02
    
    LDA.b #$35 : STA.w $0F50, X
    
    LDA.b #$01
    LDY.b #$3C
    
    SR.w Credits_SpriteDraw_Single

    .BRANCH_BETA

        DEX
        
        LDA.w $0D50, X : DEC A : LSR A : AND.b #$40 : EOR.b #$72 : STA.w $0F50, X
        
        LDA.b $1A : LSR #3 : AND.b #$10 : STA.w $0DC0, X
        
        TXA : ASL A : TAY
        
        REP #$20
        
        LDA.b $C8 : CMP.w Pool_Credits_SpriteDraw_Hera_movement_control, Y
        
        SEP #$20
        
        BCC .BRANCH_ALPHA
            LDA.w $0DF0, X : BNE .BRANCH_ALPHA
                LDY.w $0D90, X
                
                LDA.w Pool_Credits_SpriteDraw_Hera_timer, Y : PHA
                AND.b #$F8 : STA.w $0DF0, X
                
                PLA : AND.b #$07 : TAY
                
                LDA.w Pool_Credits_SpriteDraw_Hera_speed_y, Y : STA.w $0D40, X
                LDA.w Pool_Credits_SpriteDraw_Hera_speed_x, Y : STA.w $0D50, X
                
                INC.w $0D90, X
            
        .BRANCH_ALPHA

        LDA.w Pool_Credits_SpriteDraw_Hera_object_count, Y
        LDY.w Pool_Credits_SpriteDraw_Hera_group_data_index, X
        
        SR.w Credits_SpriteDraw_Single
        SR.w Credits_SpriteDraw_DrawShadow_priority_set
        JSL.l Sprite_MoveLong
	DEX : BPL .BRANCH_BETA
    
	PLX
    
	RTS
}

; ==============================================================================

; $071FC0-$0720E1 DATA
CreditsOAMGroup1:
{
    ; $071FC0
    .Sahasrahla
    dw -4,   1 : db $68, $0C, $00, $00
    dw  0,  -8 : db $40, $0C, $00, $02
    dw  0,   1 : db $42, $0C, $00, $02
        
    dw -4,   1 : db $78, $0C, $00, $00
    dw  0,  -8 : db $40, $0C, $00, $02
    dw  0,   1 : db $42, $0C, $00, $02

    ; $071FF0
    .MrsSahasrahla
    dw  8,   5 : db $79, $06, $00, $00
    dw  0, -10 : db $8E, $08, $00, $02
    dw  0,   0 : db $6E, $06, $00, $02
        
    dw  0, -10 : db $8E, $08, $00, $02
    dw  0, -10 : db $8E, $08, $00, $02
    dw  0,   0 : db $6E, $06, $00, $02
        
    ; $072020
    .LittleKakBoy
    dw  0,   0 : db $82, $08, $00, $02
    dw  0,   7 : db $4E, $0A, $00, $02
    dw  0,   0 : db $80, $48, $00, $02
        
    dw  0,   7 : db $4E, $0A, $00, $02
    dw  0,   0 : db $82, $08, $00, $02
    dw  0,   7 : db $4E, $0A, $00, $02
        
    ; TODO: Investigate this comment. Its not marked in Kan's.
    ; WTF: Why the leftovers? Is this a mess up or intentional?
    dw  0,   0 : db $80, $08, $00, $02
    dw  0,   7 : db $4E, $0A, $00, $02
    
    ; $072060
    .FightingBros
    dw 11,  -3 : db $69, $08, $00, $00
    dw  0, -12 : db $04, $08, $00, $02
    dw  0,   0 : db $60, $08, $00, $02
        
    dw 10,  -3 : db $67, $08, $00, $00
    dw  0, -12 : db $04, $08, $00, $02
    dw  0,   0 : db $60, $08, $00, $02
    
    ; $072090
    .YoungSnitch
    dw -2,   1 : db $68, $08, $00, $00
    dw  0,  -8 : db $C0, $08, $00, $02
    dw  0,   0 : db $C2, $08, $00, $02
        
    dw -3,   1 : db $78, $08, $00, $00
    dw  0,  -8 : db $C0, $08, $00, $02
    dw  0,   0 : db $C2, $08, $00, $02
        
    ; $0720C0
    .SwagDuck
    dw  0,   0 : db $0E, $00, $00, $02
    dw  0,  64 : db $6C, $00, $00, $02
    
    ; $0720D0
    .timers
    db 48, 16
    
    ; $0720D2
    .oam_pointers
    db $28, $2A, $2C, $2E, $2C
    
    ; $0720D7
    .num_oam_entries
    db 3, 3, 3, 3, 3
    
    ; $0720DC
    ; Unused
    db 2, 2
    
    ; $0720DE
    .duck_flap
    db $20, $40
    
    ; $0720E0
    .duck_flip
    db 16, -16
}

; $0720E2-$072163 LOCAL JUMP LOCATION
Credits_SpriteDraw_Kakariko1:
{
    PHX
        
    LDX.b #$06
        
    ; OPTIMIZE: Why are we loading $1A as a long address?
    LDA.l $00001A : LSR #2 : AND.b #$01 : TAY
        
    ; Alternate the travel bird's graphics for flappage.
    LDA.w CreditsOAMGroup1_duck_flap, Y : STA.w $0AF4
        
    LDA.w $0D50, X : ROL A : ROR A : AND.b #$01 : TAY
        
    LDA.w $0D50, X : CLC : ADC.w CreditsOAMGroup1_duck_flip, X
    LSR A : AND.b #$40 : ORA.b #$32 : STA.w $0F50, X
        
    LDA.b #$02
    LDY.b #$24
        
    JSR.w Credits_SpriteDraw_Single
    JSR.w Credits_SpriteDraw_CirclingBirds
        
    DEX
        
    LDA.b #$31 : STA.w $0F50, X
        
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.w $0D90, X : TAY
        
        EOR.b #$01 : STA.w $0D90, X
        
        LDA.w CreditsOAMGroup1_timers, X : STA.w $0DF0, X
        
        LDA.w $0DC0, X : INC A : AND.b #$03 : STA.w $0DC0, X
    
    .BRANCH_ALPHA
    
    LDY.b #$26
    LDA.b #$02
        
    SR.w Credits_SpriteDraw_Single
        
    DEX
    
    .BRANCH_GAMMA
    
        LDA.b $1A : AND.b #$0F : BNE .BRANCH_BETA
            LDA.w $0DC0, X : EOR.b #$01 : STA.w $0DC0, X
        
        .BRANCH_BETA
    
        LDA.b #$31 : STA.w $0F50, X
        
        LDY.w CreditsOAMGroup1_oam_pointers, X
        LDA.w CreditsOAMGroup1_num_oam_entries, X
        
        SR.w Credits_SpriteDraw_Single
        SR.w Credits_SpriteDraw_DrawShadow_priority_set
    DEX : BPL .BRANCH_GAMMA
        
    PLX
        
    RTS
}

; ==============================================================================

; $072164-$07227B DATA
CreditsOAMGroup2:
{
    ; $072164
    .Uncle
    dw  10,   8 : db $32, $8A, $00, $00
    dw  10,  16 : db $22, $8A, $00, $00
    dw   0, -10 : db $00, $08, $00, $02
    dw   0,   0 : db $2C, $08, $00, $02
    dw  10, -14 : db $22, $0A, $00, $00
    dw  10,  -6 : db $32, $0A, $00, $00

    ; $072194
    .LinkBrandishing
    dw   0, -10 : db $2A, $08, $00, $02
    dw   0,   0 : db $28, $08, $00, $02

    ; $0721A4
    .LinkAtHouse
    dw  10,  16 : db $05, $8A, $00, $00
    dw  10,   8 : db $15, $8A, $00, $00
    dw  -4,   2 : db $07, $0A, $00, $02
    dw   0,  -7 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $0E, $00, $02
    dw  10, -20 : db $05, $0A, $00, $00
    dw  10, -12 : db $15, $0A, $00, $00
    dw  -7,   1 : db $07, $4A, $00, $02
    dw   0,  -7 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $0E, $00, $02

    ; $0721F4
    .PedestalLink
    dw   0,  -7 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $4E, $00, $02
    dw   0,  -8 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $0E, $00, $02
    dw   0,  -9 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $0E, $00, $02
    dw   0,  -7 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $0E, $00, $02
    dw   0,  -7 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $4E, $00, $02
    dw   0,  -8 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $4E, $00, $02
    dw   0,  -9 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $4E, $00, $02
    dw   0,  -7 : db $00, $0E, $00, $02
    dw   0,   1 : db $02, $4E, $00, $02

    ; $072274
    .link_gfx
    db $00 ; Link standing
    db $04 ; Link brandishing

    ; $072276
    .link_pose
    dw $000A ; Link standing
    dw $0224 ; Link brandishing

    ; $07227A
    .group_data_index
    db $0A ; Link standing
    db $0E ; Link brandishing
}

; $07227C-$0722F7 LOCAL JUMP LOCATION
Credits_SpriteDraw_House:
{
    PHX
        
    REP #$20
        
    LDA.b $C8 : CMP.w #$0200 : BNE .BRANCH_ALPHA
        LDY.b #$01
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    CMP.w #$0208 : BNE .BRANCH_GAMMA
        LDY.b #$2C
    
        .BRANCH_BETA
        
        STY.w $012E
    
    .BRANCH_GAMMA
    
    SEC : SBC.w #$0208 : CMP.w #$0030 : SEP #$20 : BCS .BRANCH_DELTA
        LDY.b #$02
        
        SR.w Credits_SpriteDraw_AddSparkle
    
    .BRANCH_DELTA
    
    LDX.b #$03
        
    REP #$20
        
    LDA.b $C8 : CMP.w #$0200 : SEP #$20 : BCS .BRANCH_EPSILON
        LDA.b #$01 : STA.w $0DC0, X
    
    .BRANCH_EPSILON
    
    LDA.b #$31 : STA.w $0F50, X
        
    LDA.b #$04
    LDY.b #$08
        
    SR.w Credits_SpriteDraw_Single
    SR.w Credits_SpriteDraw_DrawShadow_priority_set
        
    LDA.w $0DC0, X : DEX : STA.w $0DC0, X : TAY
        
    STZ.w $0107
        
    LDA.w CreditsOAMGroup2_link_gfx, Y : STA.w $0108
        
    LDA.b #$30 : STA.w $0F50, X
        
    PHY : TYA : ASL A : TAY
        
    REP #$20
        
    LDA.w CreditsOAMGroup2_link_pose, Y : STA.w $0100
        
    SEP #$20
        
    PLY
        
    LDA.w CreditsOAMGroup2_group_data_index, Y : TAY
        
    LDA.b #$05
        
    SR.w Credits_SpriteDraw_Single
    SR.w Credits_SpriteDraw_DrawShadow_priority_set
        
    PLX
        
    RTS
}

; $0722F8-$072357 DATA
CreditsOAMGroup_OldMan:
{
    dw -18, -24 : db $A4, $39, $00, $02
    dw -16, -16 : db $A8, $39, $00, $02
    dw -18, -24 : db $A4, $39, $00, $02
    dw -18, -24 : db $A4, $39, $00, $02
    dw -16, -16 : db $A6, $39, $00, $02
    dw -18, -24 : db $A4, $39, $00, $02
    dw  -6, -17 : db $2D, $39, $00, $00
    dw -16, -24 : db $A0, $39, $00, $02
    dw -16, -16 : db $AA, $39, $00, $02
    dw  -5, -17 : db $2C, $39, $00, $00
    dw -16, -24 : db $A0, $39, $00, $02
    dw -16, -16 : db $AA, $39, $00, $02
}

; $072358-$072392 LOCAL JUMP LOCATION
Credits_SpriteDraw_DeathMountain:
{
    PHX
        
    LDX.b #$00
        
    REP #$20
        
    LDA.b $C8 : CMP.w #$0200
        
    SEP #$20 : BNE .BRANCH_ALPHA
        LDA.b #$FC : STA.w $0D50, X
    
    .BRANCH_ALPHA
    
    LDA.b $1A : AND.b #$10 : LSR #4 : STA.w $0DC0, X
        
    LDA.w $0D10, X : CMP.b #$38 : BNE .BRANCH_BETA
        STZ.w $0D50, X
        
        INC.w $0DC0, X : INC.w $0DC0, X
    
    .BRANCH_BETA
    
    LDA.b #$03
    LDY.b #$34
        
    SR.w Credits_SpriteDraw_Single
    JSL.l Sprite_MoveLong
        
    PLX
        
    RTS
}

; $072393-$0723C6 LOCAL JUMP LOCATION
Credits_SpriteDraw_Lumberjacks:
{
    PHX
        
    LDX.b #$00
        
    LDA.b #$2C : STA.w $0E20, X
        
    LDA.b #$2C : JSL.l OAM_AllocateFromRegionA
        
    LDA.b #$3B : STA.w $0F50, X
        
    JSL.l Sprite_Get_16_bit_CoordsLong
        
    LDA.b #$02
        
    REP #$10
        
    LDY.b $C8 : CPY.w #$01C0 : SEP #$10 : BCS .BRANCH_ALPHA
        TYA : AND.b #$20
        
        ASL #3 : ROL A
    
    .BRANCH_ALPHA
    
    STA.w $0DC0, X
        
    JSL.l SpriteActive_MainLong
        
    PLX
        
    RTS
}

; $0723C7-$07242C LOCAL JUMP LOCATION
Credits_SpriteDraw_Venus:
{
    PHX
        
    LDX.b #$05
        
    JSL.l Sprite_Get_16_bit_CoordsLong
        
    LDA.w $0F00, X : BNE .BRANCH_ALPHA 
        JSL.l GetRandomInt : AND.b #$07 : TAX
            
        LDA.l Pool_Sprite_WishPond_x_offsets, X : CLC : ADC.w $0FD8 : PHA
            
        JSL.l GetRandomInt : AND.b #$07 : TAX
            
        LDA.l Pool_Sprite_WishPond_y_offsets, X : CLC : ADC.w $0FDA
        
        PLX
        
        LDY.b #$03
        
        SR.w Credits_SpriteDraw_AddSparkle
    
    .BRANCH_ALPHA
    
    LDX.b #$03
    
    .BRANCH_GAMMA
    
        LDA.w $0E00, X : BEQ .BRANCH_BETA
            DEC.w $0E00, X
        
        .BRANCH_BETA
    
        LDA.b #$E3 : STA.w $0E20, X
        
        LDA.b #$01
        
        SR.w Credits_SpriteDraw_SetShadowProp
        SR.w Credits_SpriteDraw_ActivateAndRunSprite_allocate8
    INX : CPX.b #$05 : BNE .BRANCH_GAMMA
        
    LDA.b #$72 : STA.w $0E20, X
    LDA.b #$3B : STA.w $0F50, X
    LDA.b #$09 : STA.w $0DD0, X : STA.w $0DA0, X
        
    LDA.b #$30
        
    SR.w Credits_SpriteDraw_PreexistingSpriteDraw

    PLX
        
    RTS
}

; ==============================================================================

; $07242D-$07248C DATA
CreditsOAMGroup_RunningKid:
{
    dw   0,  -8 : db $2A, $07, $00, $02
    dw   0,  -8 : db $2A, $07, $00, $02
    dw   0,   0 : db $CA, $4F, $00, $02
    dw   0,  -8 : db $2A, $07, $00, $02
    dw   0,  -8 : db $2A, $07, $00, $02
    dw   0,   0 : db $CA, $0F, $00, $02
    dw  -2,   0 : db $77, $0F, $00, $00
    dw   0,  -8 : db $2A, $07, $00, $02
    dw   0,   0 : db $CA, $4F, $00, $02
    dw  -3,   0 : db $66, $0F, $00, $00
    dw   0,  -8 : db $2A, $07, $00, $02
    dw   0,   0 : db $CA, $4F, $00, $02
}

; $07248D-$0724BC DATA
CreditsOAMGroup_SickKid:
{
    dw  14,  -7 : db $48, $0D, $00, $02
    dw   0,  -6 : db $44, $09, $00, $02
    dw   0,   0 : db $4E, $09, $00, $02
    dw  13, -14 : db $48, $0D, $00, $02
    dw   0,  -8 : db $44, $09, $00, $02
    dw   0,   0 : db $46, $09, $00, $02
}

; $0724BD-$07253C DATA
CreditsOAMGroup_SickParents:
{
    dw  -2, -16 : db $78, $3D, $00, $00
    dw   0, -24 : db $24, $3D, $00, $02
    dw   0, -16 : db $C2, $3D, $00, $02
    dw  61, -16 : db $77, $37, $00, $00
    dw  64, -24 : db $C4, $37, $00, $02
    dw  64, -16 : db $CA, $77, $00, $02
    dw   0,  -6 : db $6C, $32, $00, $02
    dw  64,  -6 : db $6C, $32, $00, $02
    dw  -2, -16 : db $68, $3D, $00, $00
    dw   0, -24 : db $24, $3D, $00, $02
    dw   0, -16 : db $C2, $3D, $00, $02
    dw  61, -16 : db $66, $37, $00, $00
    dw  64, -24 : db $C4, $37, $00, $02
    dw  64, -16 : db $CA, $77, $00, $02
    dw   0,  -6 : db $6C, $32, $00, $02
    dw  64,  -6 : db $6C, $32, $00, $02
}

; $07253D-$07254E DATA
Pool_Credits_SpriteDraw_Kakariko2:
{
    ; $07253D
    .object_count
    db $03
    db $03
    db $08

    ; $072540
    .sick_kid_height
    db $02, $04, $05, $06, $06, $07, $07, $07
    db $07, $06, $06, $05, $04, $02, $00
}

; $07254F-$0725F7 LOCAL JUMP LOCATION
Credits_SpriteDraw_Kakariko2:
{
    PHX
        
    LDX.b #$06
        
    LDA.b $1A : AND.b #$01 : STA.w $0DC0, X : BNE .BRANCH_ALPHA
        LDA.b #$01
            
        LDY.w $0D10, X : CPY.b #$80 : BMI .BRANCH_BETA
            LDA.b #$FF
        
        .BRANCH_BETA
    
        CLC : ADC.w $0D50, X : STA.w $0D50, X
        
        LDA.b #$01
        
        LDY.w $0D00, X : CPY.b #$B0 : BMI .BRANCH_GAMMA
            LDA.b #$FF
        
        .BRANCH_GAMMA
    
        CLC : ADC.w $0D40, X : STA.w $0D40, X
        
        JSL.l Sprite_MoveLong
    
    .BRANCH_ALPHA
    
    LDA.w $0D50, X : LSR A : AND.b #$40 : EOR.b #$7E : STA.w $0F50, X
        
    LDA.b #$01 : STA.w $0E40, X
    LDA.b #$30 : STA.w $0E60, X
    LDA.b #$10 : STA.w $0F70, X
        
    SR.w Credits_SpriteDraw_PreexistingSpriteDraw_eight
        
    DEX
        
    LDA.b #$37 : STA.w $0F50, X
        
    LDA.b #$02
        
    SR.w Credits_SpriteDraw_SetShadowProp
        
    LDA.b #$0C
        
    SR.w Credits_SpriteDraw_ActivateAndRunSprite
        
    DEX
        
    SR.w Credits_SpriteDraw_ActivateAndRunSprite_allocate8
        
    DEX
        
    SR.w Credits_SpriteDraw_ActivateAndRunSprite_allocate8
        
    DEX
    
    .loop
    
        TXA : ASL A : TAY
        
        LDA.w Pool_Credits_SpriteDraw_Kakariko2_object_count, X
        
        SR.w Credits_SpriteDraw_Single
        
        TXA : BNE .BRANCH_DELTA
            SR.w Credits_SpriteDraw
            
            BRA .BRANCH_EPSILON
    
        .BRANCH_DELTA
    
        LSR A : BEQ .BRANCH_ZETA
            LDA.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
            
            BRA .BRANCH_THETA
    
        .BRANCH_ZETA
    
        LDY.b #$00
        
        LDA.b $1A : AND.b #$1F : CMP.b #$0F : BCS .BRANCH_IOTA
            TAY
            
            LDA.w Pool_Credits_SpriteDraw_Kakariko2_sick_kid_height, Y : STA.w $0F70, X
            
            LDY.b #$01
    
        .BRANCH_IOTA
    
        TYA : STA.w $0DC0, X
        
        SR.w Credits_SpriteDraw_DrawShadow
    
        .BRANCH_THETA
    DEX : BPL .loop
        
    PLX
        
    RTS
}

; $0725F8-$07260C LOCAL JUMP LOCATION
Credits_SpriteDraw_DrawShadow:
{
    .high_prioritize
    LDA.b #$30
    
    ; $0725FA ALTERNATE ENTRY POINT
    .parameterized_priority
    STA.w $0F50, X
    
    ; $0725FD ALTERNATE ENTRY POINT
    .priority_set
    LDA.b #$00
        
    SR.w Credits_SpriteDraw_SetShadowProp
        
    LDA.b #$04 : JSL.l OAM_AllocateFromRegionA
        
    JSL.l Sprite_DrawShadowLong
        
    RTS
}

; ==============================================================================

; $07260D-$072642 DATA
Credits_SpriteDraw_AnimateLostWoodsThief:
{
    ; $07260D
    .timer
    db $0A, $0A, $0A, $0A, $14, $08, $08, $00
    db $FF, $0C, $0C, $0C, $0C, $0C, $0C, $1E
    db $08, $04, $04, $04, $00, $00, $FF, $FF
    db $90, $04, $00

    ; $072628
    .pose
    db $00, $01, $00, $01, $00, $02, $03, $00
    db $02, $00, $01, $00, $01, $00, $01, $02
    db $03, $04, $05, $06, $03, $00, $FF, $FF
    db $FF, $02, $03
}

; ==============================================================================

; $072643-$072691 LOCAL JUMP LOCATION
Credits_SpriteDraw:
{
    .AnimateRunningKidAndLocksmith
    LDA.b #$30
    
    ; $072645 ALTERNATE ENTRY POINT
    .AnimateLostWoodsThief
    SR.w Credits_SpriteDraw_DrawShadow_parameterized_priority
        
    LDY.w $0D90, X
        
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        INY : CPY.b #$08 : BNE .BRANCH_BETA
            LDY.b #$06
    
        .BRANCH_BETA
    
        CPY.b #$16 : BNE .BRANCH_GAMMA
            LDY.b #$15
    
        .BRANCH_GAMMA
    
        CPY.b #$1C : BNE .BRANCH_DELTA
            LDY.b #$1B
    
        .BRANCH_DELTA
    
        TYA : STA.w $0D90, X
        
        LDA.w Credits_SpriteDraw_AnimateLostWoodsThief_timer-1, X : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA.w Credits_SpriteDraw_AnimateLostWoodsThief_pose-1, X : BPL .BRANCH_EPSILON
        LDA.b $1A : AND.b #$08 : LSR #3
    
    .BRANCH_EPSILON
    
    STA.w $0DC0, X
        
    CPY.b #$05 : BCC .BRANCH_ZETA
    CPY.b #$0A : BCC .BRANCH_THETA
    CPY.b #$0F : BCS .BRANCH_THETA
        .BRANCH_ZETA
    
        LDA.b $1A : AND.b #$01 : BNE .BRANCH_THETA
            INC.w $0D00, X
    
    .BRANCH_THETA
    
    RTS
}

; $072692-$072693 LOCAL JUMP LOCATION
Credits_SpriteDraw_ActivateAndRunSprite_allocate8:
{
    LDA.b #$08

    ; Bleeds into the next function.
}
    
; $072694-$0726B0 LOCAL JUMP LOCATION
Credits_SpriteDraw_ActivateAndRunSprite:
{
    STX.w $0FA0
        
    JSL.l OAM_AllocateFromRegionA
    SR.w Sprite_Get_16_bit_CoordsLong
        
    LDA.b $11 : PHA
        
    STZ.b $11
        
    LDA.b #$09 : STA.w $0DD0, X
        
    JSL.l SpriteActive_MainLong
        
    PLA : STA.b $11
        
    RTS
}

; $0726B1-$0726B2 LOCAL JUMP LOCATION
Credits_SpriteDraw_PreexistingSpriteDraw_eight:
{
    LDA.b #$08

    ; Bleeds into the next function.
}

; $0726B3-$0726C2 LOCAL JUMP LOCATION
Credits_SpriteDraw_PreexistingSpriteDraw:
{
    JSL.l OAM_AllocateFromRegionA
        
    STX.w $0FA0
        
    JSL.l Sprite_Get_16_bit_CoordsLong
    JSL.l SpriteActive_MainLong
        
    RTS
}

; ==============================================================================

; $0726C3-$072702 DATA
Pool_Credits_SpriteDraw_Single:
{
    .group_pointers
    dw $A42D
    dw $A48D
    dw $A4BD
    dw $A79A
    dw $A164
    dw $A1A4
    dw $A995
    dw $A194
    
    ; 0x10
    dw $AA73
    dw $AA53
    dw $ACAB
    dw $9E48
    dw $AB45
    dw $A1F4
    dw $ADB7
    dw $9DF0
    
    ; 0x20
    dw $9E20
    dw $9E38
    dw $A0C0
    dw $A020
    dw $9FC0
    dw $9FF0
    dw $A060
    dw $A090
    
    ; 0x30
    dw $9EE1
    dw $9F01
    dw $A2F8
    dw $A888
    dw $A8E5
    dw $A925
    dw $9F21
    dw $A7FA
}

; ==============================================================================

; A number of oam entries to allocate for and to draw.
; Y Index into above pointer table to use for drawing oam
; entries.
; $072703-$07273C LOCAL JUMP LOCATION
Credits_SpriteDraw_Single:
{
    PHA : PHY
    
    PHA : ASL #2 : JSL.l OAM_AllocateFromRegionA
    
    JSL.l Sprite_Get_16_bit_CoordsLong
    
    PLA : STA.w SNES.MultiplicandA
    
    LDA.b #$08 : STA.w SNES.MultiplierB
    
    ; OPTIMIZE: Are they seriously using the multiplication registers to
    ; multiply by 8? Rather than just shifting left three times in 16-bit
    ; mode...
    NOP #4
    
    LDA.w SNES.RemainderResultLow : STA.w SNES.MultiplicandA
    
    ; This part I can understand as it's variable, potentially.
    LDA.w $0DC0, X : STA.w SNES.MultiplierB
    
    REP #$20
    
    PLY
    
    LDA.w Pool_Credits_SpriteDraw_Single_group_pointers, Y
    CLC : ADC.w SNES.RemainderResultLow, Y : STA.b $08
    
    SEP #$20
    
    PHA
    
    JSL.l Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

; $07273D-$07274B DATA
Pool_Credits_SpriteDraw_Zora:
{
    ; $07273D
    .sprite_id
    db $52 ; King Zora - SPRITE 52
    db $55 ; Left zora - SPRITE 55
    db $55 ; Right zora - SPRITE 55

    ; $072740
    .object_allocation
    db $20 ; King Zora
    db $08 ; Left zora
    db $08 ; Right zora

    ; $072743
    .sprite_ai
    db $03 ; King Zora
    db $01 ; Left zora
    db $01 ; Right zora

    ; $072746
    .pose
    db $00 ; King Zora
    db $05 ; Left zora
    db $05 ; Right zora

    db $01 ; King Zora
    db $06 ; Left zora
    db $06 ; Right zora
}

; $07274C-$072799 LOCAL JUMP LOCATION
Credits_SpriteDraw_Zora:
{
    PHX
    
    TXA : LSR A : TAX
    
    LDA Credits_SpriteData_sprite_count, X : TAX

    .loop

        STX.w $0FA0
        
        LDA.w Pool_Credits_SpriteDraw_Zora_sprite_id, X : STA.w $0E20, X
        
        LDA.w Pool_Credits_SpriteDraw_Zora_object_allocation, X
        JSL.l OAM_AllocateFromRegionA
        
        LDA.w Pool_Credits_SpriteDraw_Zora_sprite_ai, X : STA.w $0D80, X
        
        TXY
        
        REP #$20
        
        LDA.b $C8 : CMP.w #$026F : BNE .BRANCH_ALPHA
            PHY
            
            ; SOUND EFFECT BEING PLAYED.
            LDY.b #$21 : STY.w $012F
            
            PLY

        .BRANCH_ALPHA

        SEP #$20 : BCC .BRANCH_BETA
            INY #3

        .BRANCH_BETA

        LDA.w Pool_Credits_SpriteDraw_Zora_pose, Y : STA.w $0DC0, X
        
        LDA.b #$33 : STA.w $0F50, X
        
        JSL.l Sprite_Get_16_bit_CoordsLong
        JSL.l SpriteActive_MainLong
    DEX : BPL .loop
    
    PLX
    
    RTS
}

; $072802-$072887 LOCAL JUMP LOCATION
Credits_SpriteDraw_Smithy:
{
    PHX
    
    LDX.b #$00
    
    REP #$20
    
    LDA.b $C8 : CMP.w #$0170 : SEP #$20 : BCC .BRANCH_ALPHA
        LDX.b #$04

        .loop

            LDA.b #$01
            LDY.b #$3E
            
            SR.w Credits_SpriteDraw_Single
        INX : CPX.b #$06 : BNE .loop
        
        LDX.b #$00
        
        LDA.b #$39 : STA.w $0F50, X
        
        REP #$20
        
        LDA.b $C8 : CMP.w #$01C0 : SEP #$20 : BCS .BRANCH_GAMMA
            LDA.b #$02
            
            BRA .BRANCH_DELTA

        .BRANCH_GAMMA

        LDA.w $0DF0, X : BNE .BRANCH_EPSILON
            LDA.b #$20 : STA.w $0DF0, X
            
            LDA.w $0DC0, X : EOR.b #$01 : AND.b #$01

            .BRANCH_DELTA

            STA.w $0DC0, X

        .BRANCH_EPSILON

        LDA.b #$04
        LDY.b #$06
        
        SR.w Credits_SpriteDraw_Single
        
        PLX
        
        RTS

    .BRANCH_ALPHA

    .loop

        LDA.b #$1A : STA.w $0E20, X
        
        LDA.b #$39 : STA.w $0F50, X
        
        LDA.b #$02
        
        SR.w Credits_SpriteDraw_SetShadowProp
        
        LDA.b $10 : PHA
        
        LDA.b #$0C
        
        SR.w Credits_SpriteDraw_ActivateAndRunSprite
        
        PLA : STA.b $10
        
        LDA.w $0DA0, X : CMP.b #$0F : BNE .BRANCH_ZETA
            LDA.w $0D90, X : CMP.b #$04 : BNE .BRANCH_ZETA
                LDA.b #$0F : STA.w $0DF2, X

        .BRANCH_ZETA

        SR.w Credits_SpriteDraw_DrawSmithSpark
    INX : CPX.b #$02 : BNE .loop
    
    PLX
    
    RTS
}

; $072888-$0728B7 DATA
CreditsOAMGroup_SmithSpark:
{
    dw   0,  -4 : db $AA, $30, $00, $02
    dw   0,  -4 : db $AA, $30, $00, $02
    dw  -4,  -8 : db $90, $30, $00, $00
    dw  12,  -8 : db $90, $70, $00, $00
    dw  -6, -10 : db $91, $30, $00, $00
    dw  14, -10 : db $91, $70, $00, $00
}

; $0728B8-$0728C7 DATA
Pool_Credits_SpriteDraw_DrawSmithSpark:
{
    .anim_step
    db $01, $01, $02, $02
    db $01, $01, $01, $01
    db $02, $02, $02, $02
    db $00, $00, $00, $00
}

; $0728C8-$0728E4 LOCAL JUMP LOCATION
Credits_SpriteDraw_DrawSmithSpark:
{
    PHX
        
    INX #2
        
    LDA.w $0DF0, X
        
    BEQ .BRANCH_ALPHA
        TAY
        
        LDA.b #$02 : STA.w $0F50, X
        
        LDA.w Pool_Credits_SpriteDraw_DrawSmithSpark, Y : STA.w $0DC0, X
        
        LDA.b #$02
        LDY.b #$36
        
        SR.w Credits_SpriteDraw_Single
    
    .BRANCH_ALPHA
    
    PLX
        
    RTS
}

; $0728E5-$072924 DATA
CreditsOAMGroup_DesertThief:
{
    dw   0,   0 : db $22, $07, $00, $02
    dw   0,  -8 : db $C2, $09, $00, $02
    dw   0,   0 : db $22, $47, $00, $02
    dw   0,  -8 : db $C2, $09, $00, $02
    dw   0,  -9 : db $C4, $09, $00, $02
    dw   0,   0 : db $22, $07, $00, $02
    dw   0,  -9 : db $24, $09, $00, $02
    dw   0,   0 : db $22, $07, $00, $02
}

; $072925-$07293C DATA
CreditsOAMGroup_DesertChests:
{
    dw -16, -12 : db $08, $3F, $00, $02
    dw   0, -12 : db $20, $3F, $00, $02
    dw  16, -12 : db $20, $3F, $00, $02
}

; $07293D-$072940 DATA
Pool_Credits_SpriteDraw_Desert:
{
    .vulture_pose
    db $01, $02, $03, $02
}

; $072941-$072994 LOCAL JUMP LOCATION
Credits_SpriteDraw_Desert:
{
    PHX
        
    LDX.b #$00
    
    .BRANCH_GAMMA
    
        CPX.b #$02 : BCS .BRANCH_ALPHA
            LDA.b #$01 : STA.w $0E20, X
            LDA.b #$0B : STA.w $0F50, X
            
            LDA.b #$02
            
            SR.w Credits_SpriteDraw_SetShadowProp
            
            LDA.b #$30 : STA.w $0F70, X
            
            LDA.b $1A : CLC 
            
            ; TODO: Go look what the XX should be.
            ; This ADC is adding itself, this means it is adding XX.
            .this
            ADC.w .this, X : LSR #2 : AND.b #$03 : TAY
            
            LDA.w Pool_Credits_SpriteDraw_Desert, Y : STA.w $0DC0, X
            
            SR.w Credits_SpriteDraw_CirclingBirds
            
            LDA.b #$0C
            
            SR.w Credits_SpriteDraw_PreexistingSpriteDraw
            
            BRA .BRANCH_BETA
    
        .BRANCH_ALPHA
    
        LDA.b #$10
        
        SR.w Credits_SpriteDraw_PreexistingSpriteDraw
    
        .BRANCH_BETA
    INX : CPX.b #$05 : BCC .BRANCH_GAMMA
        
    LDA.b #$02
    LDY.b #$38
        
    SR.w Credits_SpriteDraw_Single
    SR.w Credits_SpriteDraw
        
    INX
        
    LDA.b #$03
    LDY.b #$3A
        
    SR.w Credits_SpriteDraw_Single
        
    PLX
        
    RTS
}

; $072995-$0729AC DATA
CreditsOAMGroup_Priest:
{
    dw  -6,  -2 : db $06, $07, $00, $02 ; Book
    dw   0,  -9 : db $0E, $09, $00, $02 ; Head
    dw   0,  -1 : db $08, $09, $00, $02 ; Body
}

; $0729AD-$0729D0 LONG JUMP LOCATION
Credits_SpriteDraw_Sanctuary:
{
    PHX
        
    LDX.b #$00
    LDY.b #$0C
    LDA.b #$03
        
    SR.w Credits_SpriteDraw_Single
    SR.w Credits_SpriteDraw_DrawShadow
        
    INX
        
    ; Put the Priest in the ending sanctuary.
    LDA.b #$73 : STA.w $0E20, X
    LDA.b #$27 : STA.w $0F50, X
    LDA.b #$02 : STA.w $0E90, X
        
    LDA.b #$10
        
    ; Keep sprites alive?
    SR.w Credits_SpriteDraw_PreexistingSpriteDraw
        
    PLX
        
    RTS
}

; ==============================================================================

; $0729D1-$0729D2 DATA
Pool_Credits_SpriteDraw_Witch:
{
    .animation_step_amounts
    db  1, -1
}

; ==============================================================================

; $0729D3-$072A52 LOCAL JUMP LOCATION
Credits_SpriteDraw_Witch:
{
    PHX
        
    LDX.b #$01
    LDA.b #$02
        
    SR.w Credits_SpriteDraw_SetShadowProp
        
    LDA.b #$E9 : STA.w $0E20, X
        
    LDA.b #$0C : JSL.l OAM_AllocateFromRegionA
        
    LDA.b #$37 : STA.w $0F50, X
        
    JSL.l Sprite_Get_16_bit_CoordsLong
        
    LDA.b $1A : AND.b #$0F : BNE .BRANCH_ALPHA
        LDA.w $0DC0, X : EOR.b #$01 : STA.w $0DC0, X
    
    .BRANCH_ALPHA
    
    JSL.l SpriteActive_MainLong
        
    REP #$20
        
    LDA.b $C8 : CMP.w #$0180 : SEP #$20 : BCC .BRANCH_BETA
        LDA.b #$04 : STA.w $0D40, X
        
        LDA.w $0D00, X : CMP.b #$7C : BEQ .BRANCH_BETA
            JSL.l Sprite_MoveLong
    
    .BRANCH_BETA
    
    DEX
        
    LDA.b #$36 : STA.w $0E20, X
        
    LDA.b #$18 : JSL.l OAM_AllocateFromRegionA
        
    LDA.b #$39 : STA.w $0F50, X
        
    JSL.l Sprite_Get_16_bit_CoordsLong
        
    LDA.w $0DF0, X : BNE .BRANCH_GAMMA
        LDA.b #$04 : STA.w $0DF0, X
        
        LDA.b $C9 : LSR A : AND.b #$01 : TAY
        
        LDA.w $0DC0, X : CLC : ADC .animation_step_amounts, Y : AND.b #$07 : STA.w $0DC0, X
    
    .BRANCH_GAMMA
    
    JSL.l SpriteActive_MainLong
        
    PLX
        
    RTS
}

; ==============================================================================

; $072A53-$072A72 DATA
CreditsOAMGroup_FluteDad:
{
    dw -16, -24 : db $04, $37, $00, $02
    dw -16, -16 : db $64, $37, $00, $02
    dw -16, -24 : db $62, $37, $00, $02
    dw -16, -16 : db $64, $37, $00, $02
}

; $072A73-$072A7A DATA
CreditsOAMGroup_Quaver:
{
    dw   0, -19 : db $AF, $39, $00, $00
}

; $072A7B-$072A90 DATA
Pool_Credits_SpriteDraw_Grove:
{
    ; $072A7B
    .quaver_speed_x
    db 1, -1
        
    ; $072A7D
    .flute_kid_foot_tempo
    db  16,  14,  16,  18

    ; $072A81
    .flute_dad_headbang_timer
    db  20,  48,  20,  20

    ; $072A85
    .animal_object_allocation
    db $08 ; Left rabbit
    db $08 ; Right rabbit
    db $0C ; Left bird
    db $0C ; Right bird

    ; $072A89
    .animal_props
    db $37 ; Left rabbit
    db $37 ; Right rabbit
    db $3B ; Left bird
    db $3D ; Right bird

    ; $072A8D
    .animal_direction
    db $00 ; Left rabbit
    db $01 ; Right rabbit
    db $00 ; Left bird
    db $01 ; Right bird
}

; ==============================================================================

; $072A91-$072B44 LOCAL JUMP LOCATION
Credits_SpriteDraw_Grove:
{
    PHX
        
    LDX.b #$00
    
    .loop1
    
        LDA.w $0DF0, X : BNE .delay
            ; BUG: This seems like.... a mistake.
            ; Writing 0x60 into $0DD0 could possibly cause a crash.
            LDA.b #$60 : STA.w $0DF0, X
                         STA.w $0DD0, X
            
            STZ.w $0D50, X
            
            LDA.b #$EE : STA.w $0D10, X
            LDA.b #$04 : STA.w $0D30, X
            
            LDA.b #$18 : STA.w $0D00, X
            LDA.b #$0B : STA.w $0D20, X
    
        .delay
    
        LDA.w $0DD0, X : BEQ .BRANCH_BETA
            LDA.b #$F8 : STA.w $0D40, X
            
            JSL.l Sprite_MoveLong
            
            LDA.b $1A : LSR A : BCS .BRANCH_GAMMA
                STX.b $00
                
                LDA.b $1A : LSR #5 : EOR.b $00 : AND.b #$01 : TAY
                
                LDA.w $0D50, X : CLC : ADC.b #$7B : TAX : STA.w $0D50, X
        
            .BRANCH_GAMMA
        
            LDY.b #$10
            LDA.b #$01
            
            SR.w Credits_SpriteDraw_Single
    
        .BRANCH_BETA
    INX : CPX.b #$05 : BCC .loop1
    
    .loop2
    
        LDY.w $0D90, X
        
        LDA.w $0DF0, X : BNE .BRANCH_EPSILON
            LDA.w Pool_Credits_SpriteDraw_Grove_flute_kid_foot_tempo, Y : CPX.b #$05 : BEQ .BRANCH_ZETA
                LDA.w Pool_Credits_SpriteDraw_Grove_flute_dad_headbang_timer, Y
        
            .BRANCH_ZETA
        
            STA.w $0DF0, X
            
            TYA : INC A : AND.b #$03 : STA.w $0D90, X
            
            LDA.w $0DC0, X : EOR.b #$01 : STA.w $0DC0, X
    
        .BRANCH_EPSILON
    
        CPX.b #$05 : BNE .BRANCH_THETA
            LDA.b #$31 : STA.w $0F50, X
            
            LDA.b #$10
            
            SR.w Credits_SpriteDraw_PreexistingSpriteDraw
            
            INX
        
    BRA .loop2
    
    .BRANCH_THETA
    
    LDX.b #$12
    LDA.b #$02
        
    SR.w Credits_SpriteDraw_Single
        
    INX
    
    .loop3
    
        LDA.w Pool_Credits_SpriteDraw_Grove_animal_props-7, X
        STA.w $0F50, X

        LDA.w Pool_Credits_SpriteDraw_Grove_animal_direction-7, X
        STA.w $0DE0, X

        LDA.w Pool_Credits_SpriteDraw_Grove_animal_object_allocation-7, X
        SR.w Credits_SpriteDraw_ActivateAndRunSprite
    INX : CPX.b #$0B : BCC .loop3
        
    PLX
        
    RTS
}

; ==============================================================================

; $072B45-$072BEC DATA
CreditsOAMGroup_WoodsThief:
{
    dw  0, -7 : db $00, $0D, $00, $02
    dw  0, -7 : db $00, $0D, $00, $02
    dw  0,  0 : db $06, $0D, $00, $02
    
    dw  0, -7 : db $00, $0D, $00, $02
    dw  0, -7 : db $00, $0D, $00, $02
    dw  0,  0 : db $06, $4D, $00, $02
    
    dw  0, -8 : db $00, $0D, $00, $02
    dw  0, -8 : db $00, $0D, $00, $02
    dw  0,  0 : db $20, $0D, $00, $02
    
    dw  0, -8 : db $02, $0D, $00, $02
    dw  0, -8 : db $02, $0D, $00, $02
    dw  0,  0 : db $2C, $0D, $00, $02
    
    dw -3,  0 : db $2F, $0D, $00, $00
    dw  0, -7 : db $02, $0D, $00, $02
    dw  0,  0 : db $2C, $0D, $00, $02
    
    dw -5,  2 : db $2F, $0D, $00, $00
    dw  0, -8 : db $02, $0D, $00, $02
    dw  0,  0 : db $2C, $0D, $00, $02
    
    dw -5,  2 : db $3F, $0D, $00, $00
    dw  0, -8 : db $02, $0D, $00, $02
    dw  0,  0 : db $2C, $0D, $00, $02
}   

; $072BED-$072BF4
Pool_Credits_SpriteDraw_LostWoods:
{
    ; $072BED
    .pickle_pose
    db $00, $01, $00

    ; $072BF0
    .target_y
    db $02, $08, $20, $20, $08    
}

; ==============================================================================

; $072BF5-$072CA1 LOCAL JUMP LOCATION
Credits_SpriteDraw_LostWoods:
{
    PHX
        
    LDX.b #$06
    
    ; $072BF8 ALTERNATE ENTRY POINT
    .next_sprite
    
        CPX.b #$05 : BCC .BRANCH_ALPHA
            LDA.b #$00 : STA.w $0E20, X
            
            LDA.b #$01
            
            SR.w Credits_SpriteDraw_SetShadowProp
            
            LDA.b $1A : CLC
            
            ; TODO: Go look what the XX should be.
            ; This ADC is adding itself, this means it is adding XX.
            .this
            ADC.w .this, X : AND.b #$08 : LSR #3 : STA.w $0DC0, X
            
            LDA.b #$20 : STA.w $0F70, X
            
            SR.w Credits_SpriteDraw_CirclingBirds
            
            LDA.w $0D50, X : LSR A : AND.b #$40 : EOR.b #$0F : STA.w $0F50, X
            
            LDA.b #$08
            
            SR.w Credits_SpriteDraw_PreexistingSpriteDraw
            
            BRA .BRANCH_BETA
        
        .BRANCH_ALPHA
        
        LDA.b #$0D : STA.w $0E20, X
            
        CPX.b #$01 : BNE .BRANCH_GAMMA
            STA.w $0EB0, X
        
        .BRANCH_GAMMA
        
        LDA.b #$03
            
        SR.w Credits_SpriteDraw_SetShadowProp
            
        LDA.b #$2B : STA.w $0F50, X
            
        LDA.w $0DF0, X : BNE .BRANCH_DELTA
            LDA.b #$C0 : STA.w $0DF0, X
        
        .BRANCH_DELTA
        
        LSR A : BNE .BRANCH_EPSILON
            STA.w $0D40, X
            
            BRA .BRANCH_ZETA
        
        .BRANCH_EPSILON
        
        CMP.w Pool_Credits_SpriteDraw_LostWoods_target_y, X : BCS .BRANCH_THETA
            LDA.b $1A : AND.b #$03 : BNE .BRANCH_THETA
                LDA.w $0D40, X : BEQ .BRANCH_THETA
                    DEC A : STA.w $0D40, X
                    
                    CLC : ADC.b #$FC
                    072645
                    CPX.b #$03 : BCS .BRANCH_ZETA
                        EOR.b #$FF : INC A
                    
                    .BRANCH_ZETA
                
                    STA.w $0D50, X
        
        .BRANCH_THETA
        
        JSL.l Sprite_MoveLong
            
        LDA.b $1A : LSR #3 : AND.b #$03 : TAY
            
        LDA.w Pool_Credits_SpriteDraw_LostWoods_pickle_pose, Y : STA.w $0DC0, X
            
        LDA.b #$10
            
        SR.w Credits_SpriteDraw_PreexistingSpriteDraw
        
        .BRANCH_BETA
        
        DEX : BEQ .BRANCH_IOTA
    JMP.w Credits_SpriteDraw_LostWoods_next_sprite
    
    .BRANCH_IOTA
    
    LDY.b #$18
    LDA.b #$03
        
    SR.w Credits_SpriteDraw_Single
        
    LDA.b #$20
        
    SR.w Credits_SpriteDraw_AnimateLostWoodsThief
        
    PLX
        
    RTS
}

; $072CA2-$072CAA LOCAL JUMP LOCATION
Credits_SpriteDraw_SetShadowProp:
{
    STA.w $0E40, X
        
    LDA.b #$10 : STA.w $0E60, X
        
    RTS
}

; $072CAB-$072CCA DATA
CreditsOAMGroup_PedestalSquirrel:
{
    dw   0,   0 : db $0C, $0C, $00, $02
    dw   0,   0 : db $0A, $0C, $00, $02
    dw   0,   0 : db $C5, $0C, $00, $02
    dw   0,   0 : db $E1, $0C, $00, $02
}

; $072CCB-$072CD6 DATA
Pool_Credits_SpriteDraw_Pedestal:
{
    ; $072CCB
    .props
    db $61, $61, $3B, $39

    ; $072CCF
    .squirrel_timer
    db   6,   6,   6,   6,   6,   6,  10,   8
}

; $072CD7-$072CE4 DATA
Pool_Credits_SpriteDraw_AddSparkle:
{
    ; $072CD7
    .timer
    db  32,   4,   4,   4,   5,   6

    ; $072CDD
    .sparkle_position_x
    db $76, $73, $71, $78

    ; $072CE1
    .sparkle_position_y
    db $8B, $83, $8D, $85
}

; $072CE5-$072D21 LOCAL JUMP LOCATION
Credits_SpriteDraw_AddSparkle:
{
    STX.b $00
    STA.b $02
    STY.w $0DB0
        
    LDX.b #$00
    
    .loop
    
        LDY.w $0DC0, X
        
        LDA.w $0DF0, X : BNE .BRANCH_ALPHA
            INY : CPY.b #$06 : BCC .BRANCH_BETA
                LDA.b $00 : STA.w $0D10, X
                LDA.b $02 : STA.w $0D00, X
                
                LDY.b #$00
            
            .BRANCH_BETA
        
            TYA : STA.w $0DC0, X
            
            LDA.w Pool_Credits_SpriteDraw_AddSparkle_timer, Y : STA.w $0DF0, X
        
        .BRANCH_ALPHA
    
        TYA : BEQ .BRANCH_GAMMA
            LDY.b #$1C
            LDA.b #$01
            
            SR.w Credits_SpriteDraw_Single
        
        .BRANCH_GAMMA
    INX : CPX.w $0DB0 : BCC .loop
        
    RTS
}

; And the Master Sword sleeps again...
; $072D22-$072DBE LOCAL
Credits_SpriteDraw_Pedestal:
{
    PHX
        
    LDY.b $1A
    
    ; TODO: Go look what the XX should be.
    ; This LDA is loading itself, this means it is loading XX.
    .this
    LDA.w .this, Y : AND.b #$03 : TAY
        
    LDX.w Pool_Credits_SpriteDraw_AddSparkle_sparkle_position_x, Y
        
    ; TODO: Confirm that this is reading from the correct place.
    LDA.w Pool_Credits_SpriteDraw_AddSparkle_sparkle_position_y, Y
        
    LDY.b $02
        
    SR.w Credits_SpriteDraw_AddSparkle
        
    LDA.b #$62 : STA.w $0E20, X
    LDA.b #$39 : STA.w $0F50, X
        
    LDA.b #$18
        
    SR.w Credits_SpriteDraw_PreexistingSpriteDraw
        
    LDY.b #$01
    
    .loop
    
        INX
        
        LDA.w $0E00, X : 	BEQ .BRANCH_ALPHA
            DEC.w $0E00, X
    
        .BRANCH_ALPHA
    
        LDA.w $0D50, X : LSR A : AND.b #$40
        EOR.w Pool_Credits_SpriteDraw_Pedestal_props, Y : STA.w $0F50, X
        
        LDA.w $0DF0, X : BNE .BRANCH_BETA
            LDA.b #$80 : STA.w $0DF0, X
            
            STZ.w $0D90, X
    
        .BRANCH_BETA
    
        LDA.w $0D90, X : BNE .BRANCH_GAMMA
            LDA.b $1A : LSR #2 : AND.b #$01 : INC #2 : STA.w $0DC0, X
            
            PHY
            
            SR.w Credits_SpriteDraw_MoveSquirrel
            
            PLY
            
            BRA .BRANCH_DELTA
    
        .BRANCH_GAMMA
    
        LDA.w $0E00, X : BNE .BRANCH_DELTA
            LDA.w $0DA0, X : CMP.b #$08 : BNE .BRANCH_EPSILON
                STZ.w $0DA0, X
        
            .BRANCH_EPSILON
        
            PHY
            
            LDA.w $0DA0, X : AND.b #$07 : TAY
            
            LDA.w Pool_Credits_SpriteDraw_Pedestal_squirrel_timer, Y
            STA.w $0E00, X
            
            PLY
            
            LDA.w $0DC0, X : AND.b #$01 : EOR.b #$01 : STA.w $0DC0, X
            
            INC.w $0DA0, X
    
        .BRANCH_DELTA
    
        PHY
        
        LDA.b #$01
        LDY.b #$14
        
        SR.w Credits_SpriteDraw_Single
        SR.w Credits_SpriteDraw_DrawShadow_priority_set
    PLY : DEY : BPL .loop
        
    INX
        
    SR.w Credits_SpriteDraw_WalkLinkAwayFromPedestal
        
    PLX
        
    RTS
}

; $072DBF-$072DE6 DATA
CreditsOAMGroup_SwordSparkle:
{
    dw   0,   0 : db $C7, $34, $00, $00
    dw   0,   0 : db $80, $34, $00, $00
    dw   0,   0 : db $B6, $34, $00, $00
    dw   0,   0 : db $B7, $34, $00, $00
    dw   0,   0 : db $A6, $34, $00, $00
}

; $072DE7-$072DF6
Credits_SpriteDraw_WalkLinkAwayFromPedestal_pose:
{
    dw $016C
    dw $016E
    dw $0170
    dw $0172
    dw $016C
    dw $0174
    dw $0176
    dw $0178
}

; $072DF7-$072E2C LOCAL JUMP LOCATION
Credits_SpriteDraw_WalkLinkAwayFromPedestal:
{
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.w $0DC0, X : INC A : AND.b #$07 : STA.w $0DC0, X
        
        LDA.b #$04 : STA.w $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA.w $0DC0, X : ASL A : TAY
        
    REP #$20
        
    LDA.w Credits_SpriteDraw_WalkLinkAwayFromPedestal_pose, Y : STA.w $0100
        
    SEP #$20
        
    LDA.b #$20 : STA.w $0F50, X
        
    LDA.b #$02
    LDY.b #$1A
        
    SR.w Credits_SpriteDraw_Single
    SR.w Credits_SpriteDraw_DrawShadow_priority_set
    JSL.l Sprite_MoveLong
        
    RTS
}

; ==============================================================================

; $072E2D-$072E34 DATA
Pool_Credits_SpriteDraw_MoveSquirrel:
{
    .x_speeds
    db  32,  24, -32, -24
    
    .y_speeds
    db   8,  -8,  -8,   8
}

; ==============================================================================

; $072E35-$072E5C LOCAL JUMP LOCATION
Credits_SpriteDraw_MoveSquirrel:
{
    LDA.w $0DF0, X : CMP.b #$40 : BCS .delay
        LDA.w $0DB0, X : INC A : AND.b #$03 : STA.w $0DB0, X
        
        INC.w $0D90, X
        
        RTS
    
    .delay
    
    LDY.w $0DB0, X
        
    LDA.w .x_speeds, Y : STA.w $0D50, X
        
    LDA.w .y_speeds, Y : STA.w $0D40, X
        
    JSL.l Sprite_MoveLong
        
    RTS
}

; ==============================================================================

; $072E5D-$072E62 DATA
CreditsSpriteSpeeds:
{
    .acceleration
    db 1, -1
    
    .x_speed_limits
    db 32, -32
    
    .y_speed_limits
    db 16

    .y_speed_limits_negative
    db -16
}

; ==============================================================================

; $072E63-$072E9D LOCAL JUMP LOCATION
Credits_SpriteDraw_CirclingBirds:
{
    LDA.w $0DE0, X : AND.b #$01 : TAY
        
    LDA.w $0D50, X : CLC : ADC .acceleration, X : STA.w $0D50, X
        
    CMP .x_speed_limits, Y : BNE .anotoggle_x_acceleration
        INC.w $0DE0, X
    
    .anotoggle_x_direction
    
    LDA.b $1A : AND.b #$01 : BNE .delay
        LDA.w $0EB0, X : AND.b #$01 : TAY
        
        LDA.w $0D40, X : CLC : ADC .acceleration, X : STA.w $0D40, X
        
        CMP y_speed_limits, Y : BNE .anotoggle_y_acceleration
            INC.w $0EB0, X

        .anotoggle_y_acceleration
    .delay

    JSL.l Sprite_MoveLong
        
    RTS
}

; ==============================================================================

; $072E9E-$072EA5 DATA
Pool_Credits_SingleCameraScrollControl:
{
    .flags
    dw $0008, $0004, $0002, $0001
}

; ==============================================================================

; $072EA6-$072FF1 LONG JUMP LOCATION
Credits_HandleCameraScrollControl:
{
    PHB : PHK : PLB
        
    REP #$20
        
    LDA.w #$0001 : STA.b $00
        
    LDA.b $30 : AND.w #$00FF : BNE .BRANCH_ALPHA
        JMP.w .handle_horizontal
    
    .BRANCH_ALPHA
    
    CMP.w #$0080 : BCC .BRANCH_BETA
        EOR.w #$00FF : INC A
        
        DEC.b $00 : DEC.b $00
        
        STA.b $02
        
        LDY.b #$00
        
        BRA .BRANCH_GAMMA
    
    .BRANCH_BETA

    STA.b $02
        
    LDY.b #$02
    
    .BRANCH_GAMMA
    
    LDX.b #$06
        
    SR.w Credits_SingleCameraScrollControl
        
    LDA.b $04 : STA.w $069E
        
    LDX.b $8C : CPX.b #$97 : BEQ .handle_horizontal
              CPX.b #$9D : BEQ .handle_horizontal
        LDA.b $04 : BEQ .handle_horizontal
        
        STZ.b $00
        
        LSR A : ROR.b $00
        
        LDX.b $8C
        
        CPX.b #$B5 : BEQ .BRANCH_EPSILON
            CPX.b #$BE : BNE .BRANCH_ZETA
        
        .BRANCH_EPSILON
            LSR A : ROR.b $00
            
            CMP.w #$3000 : BCC .BRANCH_IOTA
                ORA.w #$F000
                
                BRA .BRANCH_IOTA
    
        .BRANCH_ZETA
    
        CMP.w #$7000 : BCC .BRANCH_IOTA
            ORA.w #$F000
        
        .BRANCH_IOTA
    
        STA.b $06
        
        LDA.w $0622 : CLC : ADC.b $00 : STA.w $0622
        
        LDA.b $E6 : ADC.b $06 : STA.b $E6
    
    ; $072F1E ALTERNATE ENTRY POINT
    .handle_horizontal
    
    LDA.w #$0001 : STA.b $00
        
    LDA.b $31 : AND.w #$00FF : BNE .BRANCH_THETA
        JMP.w .horizontal_control_done
    
    .BRANCH_THETA
    
    CMP.w #$0080 : BCC .BRANCH_KAPPA
        EOR.w #$00FF : INC A
        
        DEC.b $00 : DEC.b $00
        
        STA.b $02
        
        LDY.b #$04
        
        BRA .BRANCH_LAMBDA
    
    .BRANCH_KAPPA
        STA.b $02
        
        LDY.b #$06
    
    .BRANCH_LAMBDA
    
    LDX.b #$00
        
    SR.w Credits_SingleCameraScrollControl
        
    LDA.b $04 : STA.w $069F
        
    LDX.b $8C
        
    CPX.b #$97 : BEQ .horizontal_control_done
    CPX.b #$9D : BEQ .horizontal_control_done
        LDA.b $04 : BEQ .horizontal_control_done
        
        STZ.b $00
        
        LSR A : ROR.b $00
        
        LDX.b $8C
        
        CPX.b #$95 : BEQ .BRANCH_XI
            CPX.b #$9E : BNE .BRANCH_OMICRON
                .BRANCH_XI
    
                LSR A : ROR.b $00
                
                CMP.w #$3000 : BCC .BRANCH_PI
                
                ORA.w #$F000
                
                BRA .BRANCH_PI
        
        .BRANCH_OMICRON
    
        CMP.w #$7000 : BCC .BRANCH_PI
            ORA.w #$F000
    
        .BRANCH_PI
    
        STA.b $06
        
        LDA.w $0620 : CLC : ADC.b $00 : STA.w $0620
        LDA.b $E0         : ADC.b $06 : STA.b $E0
    
    ; $072F91 ALTERNATE ENTRY POINT
    .horizontal_control_done
    
    LDX.b $8C
        
    CPX.b #$9C : BEQ .BRANCH_RHO
        CPX.b #$97 : BEQ .BRANCH_SIGMA
            CPX.b #$9D : BNE .BRANCH_TAU
                .BRANCH_SIGMA
            
                LDA.w $0622 : CLC : ADC.w #$2000 : STA.w $0622
                LDA.b $E6         : ADC.w #$0000 : STA.b $E6
                LDA.w $0620 : CLC : ADC.w #$2000 : STA.w $0620
                LDA.b $E0         : ADC.w #$0000 : STA.b $E0
                
                BRA .BRANCH_TAU
    
    .BRANCH_RHO
    
    LDA.w $0622 : SEC : SBC.w #$2000 : STA.w $0622
        
    LDA.b $E6 : SEC : SBC.w #$0000 : CLC : ADC.w $069E : STA.b $E6
    LDA.b $E2                                          : STA.b $E0
    
    .BRANCH_TAU
    
    LDA.b $A0 : CMP.w #$0181 : BNE .BRANCH_UPSILON
        LDA.b $E8 : ORA.w #$0100 : STA.b $E6
        LDA.b $E2                : STA.b $E0
    
    .BRANCH_UPSILON
    
    SEP #$20
        
    PLB
        
    RTL
}

; $072FF2-$073037 LOCAL JUMP LOCATION
Credits_SingleCameraScrollControl:
{
    STZ.b $04
    STZ.b $06
    
    .BRANCH_ALPHA
    
        LDA.b $E2, X : CLC : ADC.b $00 : STA.b $E2, X
        
        INC.b $06
        
        LDA.b $04 : CLC : ADC.b $00 : STA.b $04
    DEC.b $02 : BNE .BRANCH_ALPHA
        
    TYA : ORA.w #$0002 : TAX
        
    LDA.w $0624, Y : CLC : ADC.b $06 : STA.w $0624, Y
        
    CMP.w #$0010 : BMI .BRANCH_BETA 
        SEC : SBC.w #$0010 : STA.w $0624, Y
            
        LDA.w .flags, Y : ORA.w $0416 : STA.w $0416
    
    .BRANCH_BETA
    
    LDA.w #$0000 : SEC : SBC.w $0624, Y : STA.w $0624, X
        
    RTS
}

; ==============================================================================

; $073038-$073C6C DATA
; 0x0C34 total
CreditsData:
{
    ; Tile format:
    ; vhopppcc cccccccc
    ; These are all the actual tiles themselves, all characters and their
    ; available color variants.
    .TileData
    dw $38C7, $38C8, $38C9, $38CA, $38CB, $38CC, $38CD, $38CE
    dw $38CF, $38D7, $38D8, $38D9, $38DA, $38DB, $38DC, $38DD

    dw $38DE, $38DF, $38E0, $38E1, $38E2, $38E3, $38E4, $38F0
    dw $38F1, $38F2, $2CC7, $2CC8, $2CC9, $2CCA, $2CCB, $2CCC

    dw $2CCD, $2CCE, $2CCF, $2CD7, $2CD8, $2CD9, $2CDA, $2CDB
    dw $2CDC, $2CDD, $2CDE, $2CDF, $2CE0, $2CE1, $2CE2, $2CE3

    dw $2CE4, $2CF0, $2CF1, $2CF2, $2CE5, $2CF5, $2CF3, $2CF4
    dw $28C7, $28C8, $28C9, $28CA, $28CB, $28CC, $28CD, $28CE

    dw $28CF, $28D7, $28D8, $28D9, $28DA, $28DB, $28DC, $28DD
    dw $28DE, $28DF, $28E0, $28E1, $28E2, $28E3, $28E4, $28F0

    dw $28F1, $28F2, $28D6, $3CE6, $3CE7, $3CE8, $3CE9, $3CEA
    dw $3CEB, $3CEC, $3CED, $3CEE, $3CEF, $3C00, $3C01, $3C02

    dw $3C03, $3C04, $3C05, $3C06, $3C07, $3CAF, $3C09, $3C0A
    dw $3C0B, $3C0C, $3C0D, $3C0E, $3C0F, $3C20, $3C21, $3C22

    dw $3C23, $3C24, $3C25, $3C26, $3C27, $3C28, $3C29, $3CA1
    dw $3C6E, $3CF6, $3CF7, $3CF8, $3CF9, $3CFA, $3CFB, $3CFC

    dw $3CFD, $3CFE, $3CFF, $3C10, $3C11, $3C12, $3C13, $3C14
    dw $3C15, $3C16, $3C17, $3CBF, $3C19, $3C1A, $3C1B, $3C1C

    dw $3C1D, $3C1E, $3C1F, $3C30, $3C31, $3C32, $3C33, $3C34
    dw $3C35, $3C36, $3C37, $3C38, $3C39, $3CB1, $3C7E
    
    ; $073176
    .BlankFillTile
    dw $3CA9 

    warnpc $0EB178

    ; Line format:
    ; First byte: The number of blank tiles preceding the text.
    ; If 0xFF the whole line is blank.
    ; Second byte: The number of characters *2 -1.
    ; Third byte+: The characters themselves.

    ; $073178-$07393C DATA
    org $0EB178
    .LineData
    ST: ; ST short for start, makes the pointers not so messy below.

    ; $073178
    Credit00:
    db $07, $23
    table CreditsSmallGreen.txt
    db "EXECUTIVE PRODUCER"

    ; Blank line
    ; $07318C
    BlankRow:
    db $FF

    ; $07318D
    Credit01:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "HIROSHI YAMAUCHI"

    ; $07319F
    Credit02:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "HIROSHI YAMAUCHI"

    ; $0731B1
    Credit03:
    db $0C, $0F
    table CreditsSmallYellow.txt
    db "PRODUCER"

    ; $0731BB
    Credit04:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "SHIGERU MIYAMOTO"

    ; $0731CD
    Credit05:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "SHIGERU MIYAMOTO"

    ; $0731DF
    Credit06:
    db $0C, $0F
    table CreditsSmallRed.txt
    db "DIRECTOR"

    ; $0731E9
    Credit07:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "TAKASHI TEZUKA"

    ; $0731F9
    Credit08:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "TAKASHI TEZUKA"

    ; $073209
    Credit09:
    db $09, $19
    table CreditsSmallGreen.txt
    db "SCRIPT WRITER"

    ; $0732018
    Credit0A:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "KENSUKE TANABE"

    ; $073228
    Credit0B:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "KENSUKE TANABE"

    ; $073238
    Credit0C:
    db $06, $25
    table CreditsSmallYellow.txt
    db "ASSISTANT DIRECTORS"

    ; $07324D
    Credit0D:
    db $07, $21
    table CreditsWhiteTop.txt
    db "YASUHISA YAMAMURA"

    ; $073260
    Credit0E:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "YASUHISA YAMAMURA"

    ; $073273
    Credit0F:
    db $09, $19
    table CreditsWhiteTop.txt
    db "YOICHI YAMADA"

    ; $073282
    Credit10:
    db $09, $19
    table CreditsWhiteBottom.txt
    db "YOICHI YAMADA"

    ; $073291
    Credit11:
    db $03, $31
    table CreditsSmallGreen.txt
    db "SCREEN GRAPHICS DESIGNERS"

    ; $0732AC
    Credit12:
    db $08, $1F
    table CreditsSmallYellow.txt
    db "OBJECT DESIGNERS"

    ; $0732BE
    Credit13:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "SOICHIRO TOMITA"

    ; $0732CF
    Credit14:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "SOICHIRO TOMITA"

    ; $0732E0
    Credit15:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "TAKAYA IMAMURA"

    ; $0732F0
    Credit16:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "TAKAYA IMAMURA"

    ; $073300
    Credit17:
    db $05, $29
    table CreditsSmallYellow.txt
    db "BACK GROUND DESIGNERS"

    ; $073317
    Credit18:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "MASANAO ARIMOTO"

    ; $073328
    Credit19:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "MASANAO ARIMOTO"

    ; $073339
    Credit1A:
    db $07, $21
    table CreditsWhiteTop.txt
    db "TSUYOSHI WATANABE"

    ; $07334C
    Credit1B:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "TSUYOSHI WATANABE"

    ; $07335F
    Credit1C:
    db $08, $1F
    table CreditsSmallRed.txt
    db "PROGRAM DIRECTOR"

    ; $073371
    Credit1D:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "TOSHIHIKO NAKAGO"

    ; $073383
    Credit1E:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "TOSHIHIKO NAKAGO"

    ; $073395
    Credit1F:
    db $08, $1D
    table CreditsSmallGreen.txt
    db "MAIN PROGRAMMER"

    ; $0733A6
    Credit20:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YASUNARI SOEJIMA"

    ; $0733B8
    Credit21:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YASUNARI SOEJIMA"

    ; $0733CA
    Credit22:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "KAZUAKI MORITA"

    ; $0733DA
    Credit23:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "KAZUAKI MORITA"

    ; $0733EA
    Credit24:
    db $0A, $15
    table CreditsSmallYellow.txt
    db "PROGRAMMERS"

    ; $0733F7
    Credit25:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "TATSUO NISHIYAMA"

    ; $073409
    Credit26:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "TATSUO NISHIYAMA"

    ; $07341B
    Credit27:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "YUICHI YAMAMOTO"

    ; $07342C
    Credit28:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "YUICHI YAMAMOTO"

    ; $07343D
    Credit29:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YOSHIHIRO NOMOTO"

    ; $07344F
    Credit2A:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YOSHIHIRO NOMOTO"

    ; $073461
    Credit2B:
    db $0B, $11
    table CreditsWhiteTop.txt
    db "EIJI NOTO"

    ; $07346C
    Credit2C:
    db $0B, $11
    table CreditsWhiteBottom.txt
    db "EIJI NOTO"

    ; $073477
    Credit2D:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "SATORU TAKAHATA"

    ; $073488
    Credit2E:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "SATORU TAKAHATA"

    ; $073499
    Credit2F:
    db $09, $1B
    table CreditsSmallRed.txt
    db "SOUND COMPOSER"

    ; $0734A9
    Credit30:
    db $0B, $13
    table CreditsWhiteTop.txt
    db "KOJI KONDO"

    ; $0734B5
    Credit31:
    db $0B, $13
    table CreditsWhiteBottom.txt
    db "KOJI KONDO"

    ; $0734C1
    Credit32:
    db $0A, $17
    table CreditsSmallGreen.txt
    db "COORDINATORS"

    ; $0734CF
    Credit33:
    db $0B, $13
    table CreditsWhiteTop.txt
    db "KEIZO KATO"

    ; $0734DB
    Credit34:
    db $0B, $13
    table CreditsWhiteBottom.txt
    db "KEIZO KATO"

    ; $0734E7
    Credit35:
    db $0A, $19
    table CreditsWhiteTop.txt
    db "TAKAO SHIMIZU"

    ; $0734F6
    Credit36:
    db $0A, $19
    table CreditsWhiteBottom.txt
    db "TAKAO SHIMIZU"

    ; $073505
    Credit37:
    db $08, $1F
    table CreditsSmallYellow.txt
    db "PRINTED ART WORK"

    ; $073517
    Credit38:
    db $09, $19
    table CreditsWhiteTop.txt
    db "YOICHI KOTABE"

    ; $073526
    Credit39:
    db $09, $19
    table CreditsWhiteBottom.txt
    db "YOICHI KOTABE"

    ; $073535
    Credit3A:
    db $0A, $17
    table CreditsWhiteTop.txt
    db "HIDEKI FUJII"

    ; $073543
    Credit3B:
    db $0A, $17
    table CreditsWhiteBottom.txt
    db "HIDEKI FUJII"

    ; $073551
    Credit3C:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YOSHIAKI KOIZUMI"

    ; $073563
    Credit3D:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YOSHIAKI KOIZUMI"

    ; $073575
    Credit3E:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "YASUHIRO SAKAI"

    ; $073585
    Credit3F:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "YASUHIRO SAKAI"

    ; $073595
    Credit40:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "TOMOAKI KUROUME"

    ; $0735A6
    Credit41:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "TOMOAKI KUROUME"

    ; $0735B7
    Credit42:
    db $07, $21
    table CreditsSmallRed.txt
    db "SPECIAL THANKS TO"

    ; $0735CA
    Credit43:
    db $09, $19
    table CreditsWhiteTop.txt
    db "NOBUO OKAJIMA"

    ; $0735D9
    Credit44:
    db $09, $19
    table CreditsWhiteBottom.txt
    db "NOBUO OKAJIMA"

    ; $0735E8
    Credit45:
    db $07, $21
    table CreditsWhiteTop.txt
    db "YASUNORI TAKETANI"

    ; $0735FB
    Credit46:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "YASUNORI TAKETANI"

    ; $07360E
    Credit47:
    db $0A, $17
    table CreditsWhiteTop.txt
    db "KIYOSHI KODA"

    ; $07361C
    Credit48:
    db $0A, $17
    table CreditsWhiteBottom.txt
    db "KIYOSHI KODA"

    ; $07362A
    Credit49:
    db $07, $23
    table CreditsWhiteTop.txt
    db "TAKAMITSU KUZUHARA"

    ; $07363E
    Credit4A:
    db $07, $23
    table CreditsWhiteBottom.txt
    db "TAKAMITSU KUZUHARA"

    ; $073652
    Credit4B:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "HIRONOBU KAKUI"

    ; $073662
    Credit4C:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "HIRONOBU KAKUI"

    ; $073672
    Credit4D:
    db $07, $21
    table CreditsWhiteTop.txt
    db "SHIGEKI YAMASHIRO"

    ; $073685
    Credit4E:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "SHIGEKI YAMASHIRO"

    ; $073698
    Credit4F:
    db $07, $21
    table CreditsSmallGreen.txt
    db "OBJECT PROGRAMMER"

    ; $0736AB
    Credit50:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "TOSHIO IWAWAKI"

    ; $0736BB
    Credit51:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "TOSHIO IWAWAKI"

    ; $0736CB
    Credit52:
    db $06, $25
    table CreditsWhiteTop.txt
    db "SHIGEHIRO KASAMATSU"

    ; $0736E0
    Credit53:
    db $06, $25
    table CreditsWhiteBottom.txt
    db "SHIGEHIRO KASAMATSU"

    ; $0736F5
    Credit54:
    db $0A, $19
    table CreditsWhiteTop.txt
    db "QUEST HISTORY"

    ; $073704
    Credit55:
    db $0A, $19
    table CreditsWhiteBottom.txt
    db "QUEST HISTORY"

    ; $073713
    Credit56:
    db $03, $33
    table CreditsSmallRed.txt
    db "LOCATION             GAMES"

    ; $07372F
    Credit57:
    db $04, $1F
    table CreditsSmallYellow.txt
    db "CASTLE OF HYRULE"

    ; $073741
    Credit58:
    db $04, $1B
    table CreditsSmallGreen.txt
    db "CASTLE DUNGEON"

    ; $073751
    Credit59:
    db $04, $15
    table CreditsSmallYellow.txt
    db "EAST PALACE"

    ; $07375E
    Credit5A:
    db $04, $19
    table CreditsSmallGreen.txt
    db "DESERT PALACE"

    ; $07376D
    Credit5B:
    db $04, $1B
    table CreditsSmallYellow.txt
    db "MOUNTAIN TOWER"

    ; $07377D
    Credit5C:
    db $08, $19
    table CreditsWhiteTop.txt
    db "1 DARK PALACE"

    ; $07378C
    Credit5D:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "1 DARK PALACE"

    ; $0737A0
    Credit5E:
    db $08, $1B
    table CreditsWhiteTop.txt
    db "2 SWAMP PALACE"

    ; $0737B0
    Credit5F:
    db $03, $25
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "2 SWAMP PALACE"

    ; $0737C5
    Credit60:
    db $08, $19
    table CreditsWhiteTop.txt
    db "3 SKULL WOODS"

    ; $0737D4
    Credit61:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "3 SKULL WOODS"

    ; $0737E8
    Credit62:
    db $08, $1B
    table CreditsWhiteTop.txt
    db "4 THIEVES'TOWN"

    ; $0737F8
    Credit63:
    db $03, $25
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "4 THIEVES'TOWN"

    ; $07380D
    Credit64:
    db $08, $17
    table CreditsWhiteTop.txt
    db "5 ICE PALACE"

    ; $07381B
    Credit65:
    db $03, $21
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "5 ICE PALACE"

    ; $07382E
    Credit66:
    db $08, $19
    table CreditsWhiteTop.txt
    db "6 MISERY MIRE"

    ; $07383D
    Credit67:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "6 MISERY MIRE"

    ; $073851
    Credit68:
    db $08, $19
    table CreditsWhiteTop.txt
    db "7 TURTLE ROCK"

    ; $073860
    Credit69:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "7 TURTLE ROCK"

    ; $073874
    Credit6A:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "8 GANON's TOWER"

    ; $073885
    Credit6B:
    db $03, $27
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "8 GANON's TOWER"

    ; $07389B
    Credit6C:
    db $04, $23
    table CreditsWhiteTop.txt
    db "TOTAL GAMES PLAYED"

    ; $0738AF
    Credit6D:
    db $04, $23
    table CreditsWhiteBottom.txt
    db "TOTAL GAMES PLAYED"

    ; $0738C3
    Credit6E:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YASUNARI NISHIDA"

    ; $0738D5
    Credit6F:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YASUNARI NISHIDA"

    ; $0738E7
    Credit70:
    db $05, $2B
    table CreditsSmallYellow.txt
    db "ENGLISH SCRIPT WRITERS"

    ; $0738FF
    Credit71:
    db $0A, $17
    table CreditsWhiteTop.txt
    db "DANIEL OWSEN"

    ; $07390D
    Credit72:
    db $0A, $17
    table CreditsWhiteBottom.txt
    db "DANIEL OWSEN"

    ; $07391B
    Credit73:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "HIROYUKI YAMADA"
    
    ; $07392C
    Credit74:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "HIROYUKI YAMADA"

    warnpc $0EB93D

    ; $07393D-$073C50 DATA
    org $0EB93D
    .LinePointers
    dw #Credit00-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit01-#ST, #Credit02-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit03-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit04-#ST, #Credit05-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit06-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit07-#ST, #Credit08-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit09-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit0A-#ST, #Credit0B-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit0C-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit0D-#ST, #Credit0E-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit0F-#ST, #Credit10-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit11-#ST, #BlankRow-#ST
    dw #Credit12-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST

    dw #Credit13-#ST, #Credit14-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit15-#ST, #Credit16-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit17-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit18-#ST, #Credit19-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit1A-#ST, #Credit1B-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit1V-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit1D-#ST, #Credit1E-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit1F-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit20-#ST, #Credit21-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit4F-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit22-#ST, #Credit23-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit24-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST

    dw #Credit25-#ST, #Credit26-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit27-#ST, #Credit28-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit29-#ST, #Credit2A-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit2B-#ST, #Credit2C-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit2D-#ST, #Credit2E-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit50-#ST, #Credit51-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit52-#ST, #Credit53-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit6E-#ST, #Credit6F-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit2F-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit30-#ST, #Credit31-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit32-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit33-#ST, #Credit34-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit35-#ST, #Credit36-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit37-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit38-#ST, #Credit39-#ST, #BlankRow-#ST, #BlankRow-#ST

    dw #Credit3A-#ST, #Credit3B-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit3C-#ST, #Credit3D-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit3E-#ST, #Credit3F-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit40-#ST, #Credit41-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit70-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit71-#ST, #Credit72-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit73-#ST, #Credit74-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit42-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit43-#ST, #Credit44-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit45-#ST, #Credit46-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit47-#ST, #Credit48-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit49-#ST, #Credit4A-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit4B-#ST, #Credit4C-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit4D-#ST, #Credit4E-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST

    dw #BlankRow-#ST, #BlankRow-#ST, #Credit54-#ST, #Credit55-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit56-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit57-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit58-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit59-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit5A-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit5B-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit5C-#ST, #Credit5D-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit5E-#ST, #Credit5F-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit60-#ST, #Credit61-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit62-#ST, #Credit63-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit64-#ST, #Credit65-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit66-#ST, #Credit67-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit68-#ST, #Credit69-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit6A-#ST, #Credit6B-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    
    dw #Credit6C-#ST, #Credit6D-#ST

    warnpc $0EBC51
        
    ; $073C51-$073C6C DATA
    org $0EBC51
    ; These are the line numbers where the game will draw the death counts for
    ; each dungeon. Once one is hit it will start looking for the next one but
    ; if doesn't find the first one for example it will not show all of the
    ; following either.
    .DeathCountLine
    dw $0290, $0298, $02A0, $02A8, $02B0, $02BA, $02C2
    dw $02CA, $02D2, $02DA, $02E2, $02EA, $02F2, $0310

    warnpc $0EBC6D
}

; ==============================================================================

; $073C6D-$073D65 LOCAL JUMP LOCATION
Credits_InitializeTheActualCredits:
{
    ; Set up the screen values, resets HDMA, etc.
    JSL.l EnableForceBlank

    JSL.l Vram_EraseTilemaps_normal
    JSL.l CopyFontToVram
    JSL.l Credits_LoadCoolBackground
    JSL.l Credits_InitializePolyhedral
        
    ; Force blank the screen.
    LDA.b #$80 : STA.b $13
        
    LDA.b #$02 : STA.w $0AA9
        
    ; Load a couple of palettes.
    LDA.b #$01 : STA.w $0AB2
        
    JSL.l Palette_Hud
        
    ; Note that cgram should be updated for the next frame.
    INC.b $15
        
    REP #$20
        
    ; Zero out the Hyrule Castle 2 death counter? why?
    LDA.w #$0000 : STA.l $7EF3EF
        
    ; The counter for the number of times you've saved/died.
    LDA.l $7EF403 : CLC : ADC.l $7EF401 : STA.l $7EF401
        
    LDX.b #$18

    .loop

        ; Read values up to $7EF3FF (WORD).
        ; Cycle through all the dungeons.
        CLC : ADC.l $7EF3E7, X : STA.l $7EF405
    DEX #2 : BPL .loop
        
    ; Zero out the overall life counter.
    LDA.w #$0000 : STA.l $7EF403
        
    SEP #$20
        
    ; Find our max health and divide by 8.
    ; Gives us how many heart containers we have.
    ; (Each heart container counts for 8 health).
    LDA.l $7EF36C : LSR #3 : TAX
        
    ; This is the table of how many hearts to give when you start up.
    LDA.l MaxHealthBasedSpawnHP, X : STA.l $7EF36D
        
    ; Puts us in the Dark World.
    LDA.b #$40 : STA.l $7EF3CA
        
    JSL.l Main_SaveGameFile
        
    REP #$20
        
    LDA.w #$0000 : STA.l $7EC34C : STA.l $7EC54D
    LDA.w #$0000 : STA.l $7EC300 : STA.l $7EC500

    LDA.w #$0016 : STA.b $1C
    LDA.w #$6800 : STA.b $C8
        
    STZ.b $CA
    STZ.b $CC
        
    LDA.w #$FFB8 : STA.b $E8
    LDA.w #$0090 : STA.b $E2
        
    STZ.b $EA
    STZ.b $E4
        
    ; Draws the first row of tiles.
    SR.w Credits_AddNextAttribution
        
    SEP #$20
        
    LDA.b #$22 : STA.w $012C
        
    STZ.b $99
        
    LDA.b #$A2 : STA.b $9A
        
    LDA.b #$12 : STA.w SNES.BG2AddrAndSize
        
    LDA.b #$3F : STA.b $9C
    LDA.b #$5F : STA.b $9D
    LDA.b #$9F : STA.b $9E
    LDA.b #$40 : STA.b $B0
        
    STZ.b $13
        
    LDX.b #$04
    
    .BRANCH_BETA
    
        LDA.w .hdma_data, X : STA.w DMA.7_TransferParameters, X
    DEX : BPL .BRANCH_BETA
        
    STZ.w DMA.7__DataBank
        
    LDA.b #$80 : STA.b $9B
        
    BRL Credits_FadeColorAndBeginAnimating_return

    ; $073D4E
    .hdma_data
    db $42     ; -> DMAP7
    db $0F     ; -> BBAD7
    dl $0EBD53 ; -> A1T7 and A1B7
    
    ; $073D53
    .table
    db $52
    dw $0600
        
    db $08
    dw $00E2
        
    db $08
    dw $0602
        
    db $05
    dw $0604
        
    db $10
    dw $0606
        
    db $81
    db $00E2
        
    db $00
}

; Gradually neutralizes color addition / subtraction to neutral.
; $073D66-$073D8A LOCAL JUMP LOCATION
Credits_FadeOutFixedCol:
{  
    DEC.b $B0 : BNE .BRANCH_ALPHA
        LDA.b #$10 : STA.b $B0
        
        LDA.b $9C : CMP.b #$20 : BEQ .BRANCH_BETA
            DEC.b $9C
            
            BRA .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    LDA.b $9D : CMP.b #$40 : BEQ .BRANCH_GAMMA
        DEC.b $9D
        
        BRA .BRANCH_ALPHA
    
    .BRANCH_GAMMA
    
    LDA.b $9E : CMP.b #$80 : BEQ .BRANCH_ALPHA
        DEC.b $9E
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $073D8B-$073E03 LOCAL JUMP LOCATION
Credits_FadeColorAndBeginAnimating:
{
    ; Gradually neutralize color add/sub.
    SR.w Credits_FadeOutFixedCol
        
    LDA.b #$01 : STA.w $0710
        
    SEP #$30
        
    ; Presumably something to do with the 3D triforce.
    JSL.l Credits_AnimateTheTriangles
        
    REP #$30
        
    LDA.b $1A : AND.w #$0003 : BNE .return
        ; Advance the scenery background to the right 1 pixel.
        INC.b $E2
        
        LDA.b $E2 : CMP.w #$0C00 : BNE .noTilemapAdjust
            ; Adjust the tilemap size and locations of BG1 and BG2... not
            ; entirely clear yet as to why.
            LDY.w #$1300 : STY.w SNES.BG1AddrAndSize
        
        .noTilemapAdjust
    
        ; $0604 = BG2HOFS / 2, $0600 = BG2HOFS * 3 / 2, $0602 = BG2HOFS * 3 / 4
        LSR A : STA.w $0604 : CLC : ADC.b $E2 : STA.w $0600
        LSR A : STA.w $0602
        
        ; $0606 = BG2HOFS / 4
        LDA.w $0604 : LSR A : STA.w $0606
        
        LDA.b $EA : CMP.w #$0CD8 : BNE .notDoneWithSubmodule
            LDA.w #$0080 : STA.b $C8
            
            INC.b $11
            
            BRA .return
        
        .notDoneWithSubmodule
    
        ; Scroll the credit list up one pixel.
        CLC : ADC.w #$0001 : STA.b $EA
        
        TAY : AND.w #$0007 : BNE .return
            TYA : LSR #3 : STA.b $CA
            
            SR.w Credits_AddNextAttribution
    
    ; $073DEB LONG BRANCH LOCATION
    .return
    
    REP #$20
        
    LDA.b $E2 : STA.w $011E
    LDA.b $E8 : STA.w $0122
        
    LDA.b $E0 : STA.w $0120
    LDA.b $E6 : STA.w $0124
        
    SEP #$30
        
    RTS
}

; ==============================================================================

; $073E04-$073E23 DATA
Pool_Credits_AddNextAttribution:
{
    ; $073E04
    .digits
    dw $3CE6, $3CF6
    
    ; $073E08
    .death_count_offsets
    dw $0002, $0000, $0004, $0006, $0014, $000C, $000A, $0010
    dw $0016, $0012, $000E, $0018, $001A, $001E 
}

; ==============================================================================

; $073E24-$073F4B LOCAL JUMP LOCATION
Credits_AddNextAttribution:
{
    PHB : PHK : PLB
        
    REP #$30
        
    LDX.w $1000
        
    LDA.b $C8 : XBA : STA.w $1002, X
        
    LDA.w #$3E40 : STA.w $1004, X
        
    ; Load the value for a transparent tile on BG3.
    LDA.w CreditsData_BlankFillTile : STA.w $1006, X
        
    TXA : CLC : ADC.w #$0006 : TAX
        
    ; 0x0314 is the overall height of the credit screen in groups of 16 pixels.
    LDA.b $CA : ASL A : TAY : CPY.w #$0314 : BCC .notAtEnd
        BRL .BRANCH_EPSILON
    
    .notAtEnd
    
    ; Gives us an idea of what row of tiles to look at.
    LDA.w CreditsData_LinePointers, Y : TAY
        
    ; Basically a tab in terms of tiles.
    ; If it's ...1, that means it's a blank line.
    LDA.w CreditsData_LineData, Y : AND.w #$00FF : CMP.w #$00FF : BEQ .BRANCH_BETA
        CLC : ADC.b $C8 : XBA : STA.w $1002, X
        
        INY
        
        LDA.w CreditsData_LineData, Y : AND.w #$00FF : XBA : STA.w $1004, X
        
        ; This gives us the number of tiles to grab after this byte.
        XBA : INC A : LSR A : STA.b $02
        
        INY : STY.b $00
    
        .nextTile
    
            LDY.b $00
            
            ; Grab the next tile of text.
            LDA.w CreditsData_LineData, Y : AND.w #$00FF : ASL A : TAY
            
            ; Here we're loading the actual tile indices for the letters.
            LDA.w CreditsData_TileData, Y : STA.w $1006, X
            
            INC.b $00
            
            INX #2
        ; Count down until we run out of tiles to grab.
        DEC.b $02 : BNE .nextTile
        
        INX #4
    
    .BRANCH_BETA
    
    LDA.b $CC : AND.w #$0001 : TAY : BNE .BRANCH_DELTA
        LDA.b $CC : AND.w #$00FE : TAY
        
        ; Check if we are on one of the line we need to draw a death count on.
        LDA.b $CA : ASL A : CMP.w CreditsData_DeathCountLine, Y : BNE .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    TYA : AND.w #$0001 : ASL A : TAY
        
    LDA.w Pool_Credits_AddNextAttribution_digits, Y : STA.b $CE
        
    LDA.b $C8 : CLC : ADC.w #$0019 : XBA : STA.w $1002, X
        
    LDA.w #$0500 : STA.w $1004, X
        
    PHX
        
    LDA.b $CC : LSR A : ASL A : TAX
        
    LDA.w Pool_Credits_AddNextAttribution_death_count_offsets, X : TAX
        
    LDA.l $7EF3E7, X
        
    PLX
        
    CMP.w #$03E8 : BCC .lessThanThousand
        LDA.w #$0009 : CLC : ADC.b $CE
        STA.w $1006, X : STA.w $1008, X : STA.w $100A, X
        
        BRA .BRANCH_THETA
    
    .lessThanThousand
    
    LDY.w #$0000
    
    .loop1
    
        CMP.w #$000A : BMI .BRANCH_IOTA
            SEC : SBC.w #$000A
            
            INY
    BRA .loop1
    
    .BRANCH_IOTA
    
    CLC : ADC.b $CE : STA.w $100A, X
        
    TYA
        
    LDY.w #$0000
    
    .loop2
    
        CMP.w #$000A : BMI .BRANCH_LAMBDA
            SEC : SBC.w #$000A
            
            INY
    BRA .loop2
    
    .BRANCH_LAMBDA
    
    CLC : ADC.b $CE : STA.w $1008, X
        
    TYA : CLC : ADC.b $CE : STA.w $1006, X
    
    .BRANCH_THETA
    
    INC.b $CC
        
    TXA : CLC : ADC.w #$000A : TAX
    
    .BRANCH_EPSILON
    
    STX.w $1000
        
    LDA.b $C8 : CLC : ADC.w #$0020 : TAY : AND.w #$03FF : BNE .BRANCH_NU
        LDA.b $C8 : AND.w #$6800 : EOR.w #$0800 : TAY
    
    .BRANCH_NU
    
    STY.b $C8
        
    SEP #$30
        
    LDA.b #$FF : STA.w $1002, X
        
    LDA.b #$01 : STA.b $14
        
    PLB
        
    RTS
}

; ==============================================================================

; $073F4C-$074302 DATA
Pool_Credits_AddEndingSequenceText:
{
    ; $073F4C
    .chargfx_castle
    ; SMALL: THE RETURN OF THE KING
    dw $6562, $2B00 ; VRAM $C4CA | 44 bytes
    db $2D, $21, $1E, $9F, $2B, $1E, $2D, $2E
    db $2B, $27, $9F, $28, $1F, $9F, $2D, $21
    db $1E, $9F, $24, $22, $27, $20

    ; TOP: HYRULE CASTLE
    dw $E962, $1900 ; VRAM $C5D2 | 26 bytes
    db $64, $75, $6E, $71, $68, $61, $9F, $5F
    db $5D, $6F, $70, $68, $61

    ; BOTTOM: HYRULE CASTLE
    dw $0963, $1900 ; VRAM $C612 | 26 bytes
    db $8A, $9B, $94, $97, $8E, $87, $9F, $85
    db $83, $95, $96, $8E, $87


    ; $073F88
    .chargfx_sanc
    ; SMALL: THE LOYAL SAGE
    dw $6862, $1B00 ; VRAM $C4D0 | 28 bytes
    db $2D, $21, $1E, $9F, $25, $28, $32, $1A
    db $25, $9F, $2C, $1A, $20, $1E

    ; TOP: SANCTUARY
    dw $EB62, $1100 ; VRAM $C5D6 | 18 bytes
    db $6F, $5D, $6A, $5F, $70, $71, $5D, $6E
    db $75

    ; BOTTOM: SANCTUARY
    dw $0B63, $1100 ; VRAM $C616 | 18 bytes
    db $95, $83, $90, $85, $96, $97, $83, $94
    db $9B


    ; $073FB4
    .chargfx_kak1
    ; SMALL: , (top of apostrophe)
    dw $4F62, $0100 ; VRAM $C49E | 2 bytes
    db $34

    ; SMALL: SAHASRALAH'S HOMECOMING
    dw $6562, $2D00 ; VRAM $C4CA | 46 bytes
    db $2C, $1A, $21, $1A, $2C, $2B, $1A, $25
    db $1A, $21, $35, $2C, $9F, $21, $28, $26
    db $1E, $1C, $28, $26, $22, $27, $20

    ; TOP: KAKARIKO TOWN
    dw $E962, $1900 ; VRAM $C5D2 | 26 bytes
    db $67, $5D, $67, $5D, $6E, $65, $67, $6B
    db $9F, $70, $6B, $73, $6A

    ; BOTTOM: KAKARIKO TOWN
    dw $0963, $1900 ; VRAM $C612 | 26 bytes
    db $8D, $83, $8D, $83, $94, $8B, $8D, $91
    db $9F, $96, $91, $99, $90


    ; $073FF6
    .chargfx_desert
    ; SMALL: VULTURES RULE THE DESERT
    dw $6462, $2F00 ; VRAM $C4C8 | 48 bytes
    db $2F, $2E, $25, $2D, $2E, $2B, $1E, $2C
    db $9F, $2B, $2E, $25, $1E, $9F, $2D, $21
    db $1E, $9F, $1D, $1E, $2C, $1E, $2B, $2D

    ; TOP: DESERT PALACE
    dw $E962, $1900 ; VRAM $C5D2 | 26 bytes
    db $60, $61, $6F, $61, $6E, $70, $9F, $6C
    db $5D, $68, $5D, $5F, $61

    ; BOTTOM: DESERT PALACE
    dw $0963, $1900 ; VRAM $C612 | 26 bytes
    db $86, $87, $95, $87, $94, $96, $9F, $92
    db $83, $8E, $83, $85, $87


    ; $074034
    .chargfx_hera
    ; SMALL: THE BULLY MAKES A FRIEND
    dw $6462, $2F00 ; VRAM $C4C8 | 48 bytes
    db $2D, $21, $1E, $9F, $1B, $2E, $25, $25
    db $32, $9F, $26, $1A, $24, $1E, $2C, $9F
    db $1A, $9F, $1F, $2B, $22, $1E, $27, $1D

    ; TOP: MOUNTAIN TOWER
    dw $E962, $1B00 ; VRAM $C5D2 | 28 bytes
    db $69, $6B, $71, $6A, $70, $5D, $65, $6A
    db $9F, $70, $6B, $73, $61, $6E

    ; BOTTOM: MOUNTAIN TOWER
    dw $0963, $1B00 ; VRAM $C612 | 28 bytes
    db $8F, $91, $97, $90, $96, $83, $8B, $90
    db $9F, $96, $91, $99, $87, $94


    ; $074074
    .chargfx_house
    ; SMALL: YOUR UNCLE RECOVERS
    dw $6662, $2500 ; VRAM $C4CC | 38 bytes
    db $32, $28, $2E, $2B, $9F, $2E, $27, $1C
    db $25, $1E, $9F, $2B, $1E, $1C, $28, $2F
    db $1E, $2B, $2C

    ; TOP: YOUR HOUSE
    dw $EB62, $1300 ; VRAM $C5D6 | 20 bytes
    db $75, $6B, $71, $6E, $9F, $64, $6B, $71
    db $6F, $61

    ; BOTTOM: YOUR HOUSE
    dw $0B63, $1300 ; VRAM $C616 | 20 bytes
    db $9B, $91, $97, $94, $9F, $8A, $91, $97
    db $95, $87


    ; $0740A7
    .chargfx_zora
    ; SMALL: FLIPPERS FOR SALE
    dw $6662, $2100 ; VRAM $C4CC | 34 bytes
    db $1F, $25, $22, $29, $29, $1E, $2B, $2C
    db $9F, $1F, $28, $2B, $9F, $2C, $1A, $25
    db $1E

    ; TOP: ZORA'S WATERFALL
    dw $E862, $1F00 ; VRAM $C5D0 | 32 bytes
    db $76, $6B, $6E, $5D, $77, $6F, $9F, $73
    db $5D, $70, $61, $6E, $62, $5D, $68, $68

    ; BOTTOM: ZORA'S WATERFALL
    dw $0863, $1F00 ; VRAM $C610 | 32 bytes
    db $9C, $91, $94, $83, $9D, $95, $9F, $99
    db $83, $96, $87, $94, $88, $83, $8E, $8E


    ; $0740E4
    .chargfx_witch
    ; SMALL: THE WITCH AND ASSISTANT
    dw $6462, $2D00 ; VRAM $C4C8 | 46 bytes
    db $2D, $21, $1E, $9F, $30, $22, $2D, $1C
    db $21, $9F, $1A, $27, $1D, $9F, $1A, $2C
    db $2C, $22, $2C, $2D, $1A, $27, $2D

    ; TOP: MAGIC SHOP
    dw $EB62, $1300 ; VRAM $C5D6 | 20 bytes
    db $69, $5D, $63, $65, $5F, $9F, $6F, $64
    db $6B, $6C

    ; BOTTOM: MAGIC SHOP
    dw $0B63, $1300 ; VRAM $C616 | 20 bytes
    db $8F, $83, $89, $8B, $85, $9F, $95, $8A
    db $91, $92


    ; $07411B
    .chargfx_lumberjack
    ; SMALL: TWIN LUMBERJACKS
    dw $6862, $1F00 ; VRAM $C4D0 | 32 bytes
    db $2D, $30, $22, $27, $9F, $25, $2E, $26
    db $1B, $1E, $2B, $23, $1A, $1C, $24, $2C

    ; TOP: WOODSMEN'S HUT
    dw $E962, $1B00 ; VRAM $C5D2 | 28 bytes
    db $73, $6B, $6B, $60, $6F, $69, $61, $6A
    db $77, $6F, $9F, $64, $71, $70

    ; BOTTOM: WOODSMEN'S HUT
    dw $0963, $1B00 ; VRAM $C612 | 28 bytes
    db $99, $91, $91, $86, $95, $8F, $87, $90
    db $9D, $95, $9F, $8A, $97, $96


    ; $074153
    .chargfx_grove
    ; SMALL: FLUTE BOY PLAYS AGAIN
    dw $6462, $2900 ; VRAM $C4C8 | 42 bytes
    db $1F, $25, $2E, $2D, $1E, $9F, $1B, $28
    db $32, $9F, $29, $25, $1A, $32, $2C, $9F
    db $1A, $20, $1A, $22, $27

    ; TOP: HAUNTED GROVE
    dw $E962, $1900 ; VRAM $C5D2 | 26 bytes
    db $64, $5D, $71, $6A, $70, $61, $60, $9F
    db $63, $6E, $6B, $72, $61

    ; BOTTOM: HAUNTED GROVE
    dw $0963, $1900 ; VRAM $C612 | 26 bytes
    db $8A, $83, $97, $90, $96, $87, $86, $9F
    db $89, $94, $91, $98, $87


    ; $07418E
    .chargfx_venus
    ; SMALL: VENUS. QUEEN OF FAERIES
    dw $6462, $2D00 ; VRAM $C4C8 | 46 bytes
    db $2F, $1E, $27, $2E, $2C, $37, $9F, $2A
    db $2E, $1E, $1E, $27, $9F, $28, $1F, $9F
    db $1F, $1A, $1E, $2B, $22, $1E, $2C

    ; TOP: WISHING WELL
    dw $EA62, $1700 ; VRAM $C5D4 | 24 bytes
    db $73, $65, $6F, $64, $65, $6A, $63, $9F
    db $73, $61, $68, $68

    ; BOTTOM: WISHING WELL
    dw $0A63, $1700 ; VRAM $C614 | 24 bytes
    db $99, $8B, $95, $8A, $8B, $90, $89, $9F
    db $99, $87, $8E, $8E


    ; $0741C9
    .chargfx_smithy
    ; SMALL: THE DWARVEN SWORDSMITHS
    dw $6462, $2D00 ; VRAM $C4C8 | 46 bytes
    db $2D, $21, $1E, $9F, $1D, $30, $1A, $2B
    db $2F, $1E, $27, $9F, $2C, $30, $28, $2B
    db $1D, $2C, $26, $22, $2D, $21, $2C

    ; TOP: SMITHERY
    dw $EC62, $0F00 ; VRAM $C5D8 | 16 bytes
    db $6F, $69, $65, $70, $64, $61, $6E, $75

    ; BOTTOM: SMITHERY
    dw $0C63, $0F00 ; VRAM $C618 | 16 bytes
    db $95, $8F, $8B, $96, $8A, $87, $94, $9B


    ; $0741FC
    .chargfx_kak2
    ; SMALL: THE BUG-CATCHING KID
    dw $6662, $2700 ; VRAM $C4CC | 40 bytes
    db $2D, $21, $1E, $9F, $1B, $2E, $20, $36
    db $1C, $1A, $2D, $1C, $21, $22, $27, $20
    db $9F, $24, $22, $1D

    ; TOP: KAKARIKO TOWN
    dw $E962, $1900 ; VRAM $C5D2 | 26 bytes
    db $67, $5D, $67, $5D, $6E, $65, $67, $6B
    db $9F, $70, $6B, $73, $6A

    ; BOTTOM: KAKARIKO TOWN
    dw $0963, $1900 ; VRAM $C612 | 26 bytes
    db $8D, $83, $8D, $83, $94, $8B, $8D, $91
    db $9F, $96, $91, $99, $90


    ; $074236
    .chargfx_deathmountain
    ; SMALL: THE LOST OLD MAN
    dw $4862, $1F00 ; VRAM $C490 | 32 bytes
    db $2D, $21, $1E, $9F, $25, $28, $2C, $2D
    db $9F, $28, $25, $1D, $9F, $26, $1A, $27

    ; TOP: DEATH MOUNTAIN
    dw $E962, $1B00 ; VRAM $C5D2 | 28 bytes
    db $60, $61, $5D, $70, $64, $9F, $69, $6B
    db $71, $6A, $70, $5D, $65, $6A

    ; BOTTOM: DEATH MOUNTAIN
    dw $0963, $1B00 ; VRAM $C612 | 28 bytes
    db $86, $87, $83, $96, $8A, $9F, $8F, $91
    db $97, $90, $96, $83, $8B, $90


    ; $07426E
    .chargfx_lostwoods
    ; SMALL: THE FOREST THIEF
    dw $6862, $1F00 ; VRAM $C4D0 | 32 bytes
    db $2D, $21, $1E, $9F, $1F, $28, $2B, $1E
    db $2C, $2D, $9F, $2D, $21, $22, $1E, $1F

    ; TOP: LOST WOODS
    dw $EB62, $1300 ; VRAM $C5D6 | 20 bytes
    db $68, $6B, $6F, $70, $9F, $73, $6B, $6B
    db $60, $6F

    ; BOTTOM: LOST WOODS
    dw $0B63, $1300 ; VRAM $C616 | 20 bytes
    db $8E, $91, $95, $96, $9F, $99, $91, $91
    db $86, $95


    ; $07429E
    .chargfx_pedestal
    ; SMALL: AND THE MASTER SWORD
    dw $6662, $2700 ; VRAM $C4CC | 40 bytes
    db $1A, $27, $1D, $9F, $2D, $21, $1E, $9F
    db $26, $1A, $2C, $2D, $1E, $2B, $9F, $2C
    db $30, $28, $2B, $1D

    ; SMALL: SLEEPS AGAIN...
    dw $A862, $1D00 ; VRAM $C550 | 30 bytes
    db $4A, $43, $3C, $3C, $47, $4A, $9F, $38
    db $3E, $38, $40, $45, $52, $52, $52

    ; TOP: FOREVER!
    dw $EC62, $0F00 ; VRAM $C5D8 | 16 bytes
    db $62, $6B, $6E, $61, $72, $61, $6E, $78

    ; BOTTOM: FOREVER!
    dw $0C63, $0F00 ; VRAM $C618 | 16 bytes
    db $88, $91, $94, $87, $98, $87, $94, $9E

    ; $0742E1
    .offset
    dw .chargfx_castle-.chargfx        ; $0000
    dw .chargfx_sanc-.chargfx          ; $003C
    dw .chargfx_kak1-.chargfx          ; $0068
    dw .chargfx_desert-.chargfx        ; $00AA
    dw .chargfx_hera-.chargfx          ; $00E8
    dw .chargfx_house-.chargfx         ; $0128
    dw .chargfx_zora-.chargfx          ; $015B
    dw .chargfx_witch-.chargfx         ; $0198
    dw .chargfx_lumberjack-.chargfx    ; $01CF
    dw .chargfx_grove-.chargfx         ; $0207
    dw .chargfx_venus-.chargfx         ; $0242
    dw .chargfx_smithy-.chargfx        ; $027D
    dw .chargfx_kak2-.chargfx          ; $02B0
    dw .chargfx_deathmountain-.chargfx ; $02EA
    dw .chargfx_lostwoods-.chargfx     ; $0322
    dw .chargfx_pedestal-.chargfx      ; $0352
    dw .offset-.chargfx                ; $0395
}

; ==============================================================================

; Does this draw the tag lines for the ending sequence? (The text)
; $074303-$07437B LOCAL JUMP LOCATION
Credits_AddEndingSequenceText:
{
    PHB : PHK : PLB
        
    REP #$30
        
    LDA.w #$0060 : STA.w $1002
    LDA.w #$FE47 : STA.w $1004
        
    LDA.w CreditsData_BlankFillTile : STA.w $1006
        
    ; Take $11, round to the nearest lowest even integer.
    LDA.b $11 : AND.w #$00FE : TAY
        
    LDA.w Pool_Credits_AddEndingSequenceText_offset+2, Y : STA.b $04
        
    LDA.w Pool_Credits_AddEndingSequenceText_offset+0, Y : TAY
        
    LDX.w #$0000
    
    .loop1
    
        LDA.w Pool_Credits_AddEndingSequenceText, Y : STA.w $1008, X
        
        INY #2
        INX #2
        
        LDA.w Pool_Credits_AddEndingSequenceText, Y : STA.w $1008, X
        
        XBA : AND.w #$00FF : LSR A : STA.b $00
        
        INY #2
        INX #2
        
        STY.b $02
    
        .loop2
    
            LDY.b $02
            
            LDA.w Pool_Credits_AddEndingSequenceText, Y : AND.w #$00FF : ASL A : TAY
            
            LDA CreditsData_TileData, Y : STA.w $1008, X
            
            INC.b $02
            
            INX #2
        DEC.b $00 : BPL .loop2
    LDY.b $02 : CPY.b $04 : BNE .loop1
        
    TXA : CLC : ADC.w #$0006 : STA.w $1000
        
    SEP #$30
        
    LDA.b #$FF : STA.w $1008, X
        
    LDA.b #$01 : STA.b $14
        
    PLB
        
    RTS
}

; $07437C-$074390 LOCAL JUMP LOCATION
Credits_BrightenTriangles:
{
    LDA.b $1A : AND.b #$0F : BNE .BRANCH_ALPHA
        INC.b $13
        
        LDA.b $13 : CMP.b #$0F
        
        BNE .BRANCH_ALPHA
            INC.b $11
    
    .BRANCH_ALPHA
    
    JSL.l Credits_AnimateTheTriangles
        
    RTS
}

; $074391-$0743D4 LOCAL JUMP LOCATION
Credits_StopCreditsScroll:
{
    DEC.b $C8
            
    BNE .exit
        REP #$20
            
        STZ.w $0AA6
            
        LDA.w #$0000 : STA.l $7EC009 : STA.l $7EC007
            
        LDA.w #$001F : STA.l $7EC00B
            
        SEP #$20
            
        INC.b $11
            
        LDA.b #$C0 : STA.b $C8
            
        STZ.b $CA
    
    .exit

    BRA Credits_BrightenTriangles_BRANCH_ALPHA
}
    
; $0743B8 ALTERNATE ENTRY POINT
Credits_FadeAndDisperseTriangles:
{
    DEC.b $C8
        
    LDA.b $CA : BNE .BRANCH_GAMMA
        JSL.l PaletteFilter_doFiltering
            
        LDA.l $7EC007 : BNE Credits_StopCreditsScroll_exit
            INC.b $CA
        
    .BRANCH_GAMMA

    LDA.b $C8 : BNE Credits_StopCreditsScroll_exit   
        INC.b $11
            
        JSL.l PaletteFilter_InitTheEndSprite
            
        RTS
}

; $0743D5-$0743E9 LOCAL JUMP LOCATION
Credits_FadeInTheEnd:
{
    LDA.b $1A : AND.b #$07 : BNE .frameNotMultipleOf8
        ; Do some palette filtering.
        JSL.l Palette_Filter_SP5F
            
        LDA.l $7EC007 : BNE .notDoneFiltering
            INC.b $11
        
        .notDoneFiltering
    .frameNotMultipleOf8
    
    JMP Credits_DrawTheEnd
}

; $0743EA-$0743F9 "The End" Oam buffer data for displaying it.
Pool_Credits_DrawTheEnd:
{
    db $A0, $B8, $00, $3B
    db $B0, $B8, $02, $3B
    db $C0, $B8, $04, $3B
    db $D0, $B8, $06, $3B
}
    
; The End!
; $0743FA-$07441B LOCAL JUMP LOCATION
Credits_DrawTheEnd:
{
    .infiniteLoop
    
        REP #$20
        
        LDX.b #$0E
    
        .writeTheEndWithSprites
        
            LDA.l Pool_Credits_DrawTheEnd, X : STA.w $0800, X
        DEX #2 : BPL .writeTheEndWithSprites
            
        SEP #$20
            
        LDA.b #$02 : STA.w $0A20 : STA.w $0A21 : STA.w $0A22 : STA.w $0A23
            
        RTS
    
    ; Once you reach this point, you'll have to turn off or reset the system to
    ; continue.
    ; $07441A ALTERNATE ENTRY POINT
    .HangForever
    
    BRA .infiniteLoop
}

; $07441C-$07443F NULL
NULL_0EC41C:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF
} 

; ==============================================================================

; Module 0x0E.0x02 (dialogue or "text" mode)
; $074440-$074447 JUMP LOCATION (LONG)
Messaging_Text:
{
    PHB : PHK : PLB
    
    SR.w Text_Local
    
    PLB
    
    RTL
}

; ==============================================================================

; $074448-$074454 LOCAL JUMP LOCATION
Text_Local:
{
    LDA.w $1CD8
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Text_Initialize           ; 0x00 - $C483
    dw Text_Render               ; 0x01 - $C8D9
    dw Text_PostDeathSaveOptions ; 0x02 - $C455
}

; $074455-$074482 JUMP LOCATION
Text_PostDeathSaveOptions:
{
    ; "Load the save & continue, save & quit, do not save or quit" dialog box
    ; that appears after you've died and the game wants you to decide what to
    ; do next.
    LDA.b #$03 : STA.w $1CF0
    LDA.b #$00 : STA.w $1CF1
    
    LDX.b #$00
    
    SR.w Text_Initialize_initModuleStateLoop
    
    ; Manually sets the .... position? Window type?
    LDA.b #$E8 : STA.w $1CD2
    LDA.b #$61 : STA.w $1CD3
    LDA.b #$02 : STA.w $1CD4
    
    ; The first call sets up the border, the second sets up the vwf tilemap the
    ; third, fourth, and fifth calls render one line of text each, with the
    ; fifth doing clean up. could be wrong about all this, but best guess so
    ; far...
    SR.w Text_Render
    SR.w Text_Render
    SR.w Text_Render
    SR.w Text_Render
    SR.w Text_Render
    
    RTS
}

; ==============================================================================

; The increment into the next sub-submodule is obscured a bit. Load the
; characters for the text message and zero out some buffers also sets up the
; frame, if necessary.
; Module 0x0E.0x02.0x00
; $074483-$0744C8 JUMP LOCATION
Text_Initialize:
{
    ; Are we in History mode?
    LDA.b $10 : CMP.b #$14 : BNE .notInAtractMode
        JSL.l Attract_ResetHudPalettes_4_and_5
    
    .notInAttractMode
    
    ; This is is always called - not the best use of time since we're not
    ; always in attract mode. What gives?
    JSL.l Attract_DecompressStoryGfx
    
    LDX.b #$00
    
    .initModuleStateLoop
    
        ; Assign predetermined initial states for many of the text variables It
        ; should be noted that this is the mechanism that increments $1CD8 into
        ; the next submodule :/ (It would be hard to spot unless you examined
        ; the above array in a hex editor).
        LDA Text_InitializationData, X : STA.w $1CD0, X
    INX : CPX.b #$20 : BCC .initModuleStateLoop
    
    SR.w Text_InitVwfState
    SR.w Text_SetDefaultWindowPos
    
    REP #$30
    
    ; Why is this all manually done? Probably due to using an assembler and
    ; not a compiler. This gives us a hint that some of these were probably
    ; compile time constants which could be considered variables in some sense.
    LDA.w #$387F : AND.w #$FF00 : ORA.w #$0180 : STA.w $1CE2
    
    SEP #$30
    
    SR.w Text_LoadCharacterBuffer
    SR.w VWF_ClearBuffer
    
    REP #$30
    
    STZ.w $1CD9
    
    SEP #$30
    
    ; Lets NMI routine know to copy $7F0000[0x7E0] to the BG2 tilemap.
    LDA.b #$02 : STA.b $17 : STA.w $0710
    
    RTS
}

; ==============================================================================

; $0744C9-$0744E1 LOCAL JUMP LOCATION
Text_InitVwfState:
{
    STZ.w $0722
    STZ.w $0723
    STZ.w $0720
    STZ.w $0721
    STZ.w $0724
    STZ.w $0725
    STZ.w $0726
    STZ.w $0727
    
    RTS
}

; ==============================================================================

; $0744E2-$074546 LOCAL JUMP LOCATION
Text_LoadCharacterBuffer:
{
    REP #$30
    
    ; X = $1CF0 * 3
    LDA.w $1CF0 : ASL A : ADC.w $1CF0 : TAX
    
    ; Load the address for the text's data from WRAM.
    LDA.l $7F71C0, X : STA.b $04
    LDA.l $7F71C2, X : STA.b $06
    
    ; Initialize the beginning of the character buffer to the "terminate"
    ; message, in case we load no actual characters.
    LDA.w #$7F7F : STA.l $7F1200
    
    LDY.w #$0000 : TYX : STY.w $1CD9 : STY.w $1CDD
    
    SEP #$20
    
    .nextByte
    
    ; Load the first byte of data.
    ; Negative byte
    LDA [$04], Y : BMI .dictionarySequence
        CMP.b #$67 : BCS .commandByte
            ; Put text to buffer.
            STA.l $7F1200, X
            
            INY : STY.w $1CDD
            INX : STX.w $1CD9
            
            BRA .nextByte
        
        .commandByte
        
        ; Terminator byte = bye bye.
        CMP.b #$7F : BEQ .endOfMessage
            SR.w Text_Command
            
            LDX.w $1CD9
            LDY.w $1CDD
            
            BRA .nextByte
        
    .dictionarySequence
    
    ; Dictionary compression for partial words.
    SEC : SBC.b #$88
    
    SR.w Text_DictionarySequence
    
    LDX.w $1CD9
    LDY.w $1CDD
    
    BRA .nextByte
    
    .endOfMessage
    
    LDA.b #$7F : STA.l $7F1200, X
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $074547-$074580 LOCAL JUMP LOCATION
Text_Command:
{
    SEP #$31
    
    SBC.b #$67
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    ; Text Routines 1 (preparation)
    ; These routines are used for setting up the $7F1200[0x800] buffer that
    ; will later be used to generate the actual VWF (variable width font) text
    ; as well as handle commands.
    
    dw Text_IgnoreCommand        ; 0x67 - $C581 [NextPic] command
    dw Text_IgnoreCommand        ; 0x68 - $C581 [Choose] command
    dw Text_IgnoreCommand        ; 0x69 - $C581 [Item] command (for waterfall of wishing)
    dw Text_WritePlayerName      ; 0x6A - $C5B3 [Name] command (insert's player's name)
    dw Text_SetWindowType        ; 0x6B - $C657 [Window XX] command (takes next byte as argument)
    dw Text_WritePreloadedNumber ; 0x6C - $C667 [Number XX] command (takes next byte as argument)
    dw Text_SetWindowPos         ; 0x6D - $C69C [Position XX] command (takes next byte as argument)
    dw Text_IgnoreParamCommand   ; 0x6E - $C598 [ScrollSpd XX] command (takes next byte as argument)
    dw Text_IgnoreCommand        ; 0x6F - $C581 [SelChng] command
    dw Text_IgnoreCommand        ; 0x70 - $C581 [Crash] in Hyrule Magic (don't use)
    dw Text_IgnoreCommand        ; 0x71 - $C581 [Choose2]
    dw Text_IgnoreCommand        ; 0x72 - $C581 [Choose3]
    dw Text_IgnoreCommand        ; 0x73 - $C581 [Scroll] command
    dw Text_IgnoreCommand        ; 0x74 - $C581 [1] command
    dw Text_IgnoreCommand        ; 0x75 - $C581 [2] command
    dw Text_IgnoreCommand        ; 0x76 - $C581 [3] command
    dw Text_SetColor             ; 0x77 - $C6B6 [Color XX] command (takes next byte as argument)
    dw Text_IgnoreParamCommand   ; 0x78 - $C598 [Wait XX] command (takes next byte as argument)
    dw Text_IgnoreParamCommand   ; 0x79 - $C598 [Sound XX] command (takes next byte as argument)
    dw Text_IgnoreParamCommand   ; 0x7A - $C598 [Speed XX] command (takes next byte as argument)
    dw Text_IgnoreCommand        ; 0x7B - $C581 [Command 7B]
    dw Text_IgnoreCommand        ; 0x7C - $C581 [Command 7C]
    dw Text_IgnoreCommand        ; 0x7D - $C581 [Command 7D]
    dw Text_IgnoreCommand        ; 0x7E - $C581 [waitkey] command
    dw Text_IgnoreCommand        ; 0x7F - $C581 [End] stop command for the whole message
}

; ==============================================================================

; $074581-$074597 JUMP LOCATION
Text_IgnoreCommand:
{
    REP #$10
    
    LDX.w $1CD9
    LDY.w $1CDD
    
    LDA [$04], Y : STA.l $7F1200, X
    
    INY
    INX
    
    STX.w $1CD9
    STY.w $1CDD
    
    RTS
}

; ==============================================================================

; $074598-$0745B2 JUMP LOCATION
Text_IgnoreParamCommand:
{
    REP #$30
    
    LDX.w $1CD9
    LDY.w $1CDD
    
    LDA [$04], Y : STA.l $7F1200, X
    
    INY #2
    INX #2
    
    STX.w $1CD9
    STY.w $1CDD
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; [Name] command (setup)
; In this routine $08[6] contains the character values for the player's name
; This routine is a tad sloppy in how it does things, I might add. I'd
; write it somewhat differently on my own.
; $0745B3-$074638 JUMP LOCATION
Text_WritePlayerName:
{
    REP #$30
    
    ; Check which file is active.
    LDA.l $701FFE : TAX
    
    ; Get its offset in sram.
    LDA.l SaveFileOffsets, X : TAX
    
    LDY.w #$0000
    
    .nextCharacter
    
        LDA.l $7003D9, X : PHA : AND.w #$000F : STA.w $0008, Y
        
        PLA : LSR A : AND.w #$FFF0 : ORA.w $0008, Y : STA.w $0008, Y
        
        INX #2
    INY : CPY.w #$0006 : BCC .nextCharacter

    SEP #$20
        
    LDY.w #$0000
    
    .nextCharacter2
    
        ; Now that the name is in memory check it for spaces.
        LDA.w $0008, Y
        
        SR.w Text_FilterPlayerNameCharacters
        
        STA.w $0008, Y
    INY : CPY.w #$0006 : BCC .nextCharacter2
    
    REP #$30
    
    ; Target Buffer position ($1CD9).
    LDA.w $1CD9 : CLC : ADC.w #$0006 : TAX
    
    ; Source Buffer position ($1CDD).
    INC.w $1CDD
    
    SEP #$20
    
    ; Write player name to the text buffer.
    LDA.b $08 : STA.l $7F11FA, X
    LDA.b $09 : STA.l $7F11FB, X
    LDA.b $0A : STA.l $7F11FC, X
    LDA.b $0B : STA.l $7F11FD, X
    LDA.b $0C : STA.l $7F11FE, X
    LDA.b $0D : STA.l $7F11FF, X
    
    LDY.w #$0005
    
    .nextCharacter3
    
        ; Now the length for spaces.
        LDA.w $0008, Y : CMP.b #$59 : BNE .notSpaceCharacter
            DEX
    DEY : BPL .nextCharacter3
    
    .notSpaceCharacter
    
    STX.w $1CD9
    
    RTS
}

; ==============================================================================

; $074639-$074656 LOCAL JUMP LOCATION
Text_FilterPlayerNameCharacters:
{
    CMP.b #$5F : BCC .alpha
        CMP.b #$76 : BCS .beta
            CMP.b #$5F : BNE .gamma
                LDA.b #$08
            
            .gamma
            
            CMP.b #$60 : BNE .delta
                LDA.b #$22
            
            .delta
            
            CMP.b #$61 : BNE .alpha
                LDA.b #$3E
        
    .alpha
    
    RTS
    
    .beta
    
    SBC.b #$42
    
    RTS
}

; ==============================================================================

; [Window XX] Command (preparation)
; $074657-$074666 JUMP LOCATION
Text_SetWindowType:
{
    REP #$10
    
    LDY.w $1CDD : INY
    
    ; This modifies the second level module controller, but why? Maybe that
    ; changes which window type is displayed by changing the pointer to
    ; different code? You could, in theory, end the message with this command
    ; by setting it to 4, crash the game by setting it to 5 or more, and this
    ; makes my head hurt, honestly. Probably could use a rewrite to be more
    ; safe.
    LDA [$04], Y : STA.w $1CD4
    
    ; $1CDD is incremented by two bytes because this command has an argument.
    INY : STY.w $1CDD
    
    RTS
} 

; ==============================================================================

; [Number XX] Command
; Writes one of the four preloaded numerical parameters the programmer was
; supposed to have stored before entering text mode This command isn't very
; safe in the sense that it doesn't validate the input.
; $074667-$07469B JUMP LOCATION
Text_WritePreloadedNumber:
{
    REP #$30
    
    LDX.w $1CD9
    LDY.w $1CDD
    
    ; The lower byte of this load is the command byte, and the upper is the
    ; parameter to use to determine the number to write.
    LDA [$04], Y
    
    INY #2 : STY.w $1CDD
    
    XBA : AND.w #$00FF : LSR A
    
    PHP
    
    TAY
    
    ; Since the expected parameter is only 0 to 3 inclusive, this means that Y
    ; here is expected to be 0 or 1, grabbing one of two bytes further down,
    ; one of two nybbles will be selected from one of these two bytes.
    LDA.w $1CF2, Y
    
    PLP : BCC .useLowerNybble
        LSR #4
    
    .useLowerNybble
    
    AND.w #$000F : CLC : ADC.w #$0004 : ORA.w #$0030 : STA.l $7F1200, X
    
    INX : STX.w $1CD9
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; [Position XX]
; This routine is dangerous too, what is with these preparation routines and
; them not validating their input, even when it would incur virtually no extra
; performance hit.
; $07469C-$0746B5 JUMP LOCATION
Text_SetWindowPos:
{
    REP #$30
    
    LDY.w $1CDD : INY
    
    LDA [$04], Y : AND.w #$00FF : ASL A : TAX
    
    ; Chooses from one of two preset window positions (high or low, basically).
    LDA Text_Positions, X : STA.w $1CD2
    
    INY : STY.w $1CDD
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; [Color XX]
; And it's worth noting that this stage (the loading process) is the only time
; [Color XX] does any meaningful work. The command it leaves in the $7F120
; [0x800] buffer doesn't work as they probably realized it would be difficult
; to make work anyway.
; $0746B6-$0746D9 JUMP LOCATION
Text_SetColor:
{
    REP #$30
    
    LDY.w $1CDD
    
    ; Why are they ANDing with 0x3c00? That would seem to give the illusion
    ; that you could specify the priority bit, but the code below begs
    ; otherwise, unless it was something that was determined at compile time.
    ; Either way, the parameter is probably only good from 0 to 7, but feel
    ; free to use 8 to 0x0f if you like wasting bits *grumble*...
    LDA [$04], Y : ASL #2 : AND.w #$3C00 : STA.b $00
    
    ; This just preserves the priority bit i.e., A = 0x2000. Then provides it
    ; with a starting CHR of 0x0180, with palette, hflip, and vflip all zero.
    ; The palette provided by [Color XX] here XX ranges from 0 to 7, is then
    ; inserted. $1CE2 is therefore the template tilemap entry for all text
    ; characters.
    LDA.w #$387F : AND.w #$E300 : ORA.w #$0180 : ORA.b $00 : STA.w $1CE2
    
    INY #2 : STY.w $1CDD
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; Handle dictionary compressed word fragments. Generally speaking its arguments
; are 0x80 and above but have had 0x88 subtracted from them. This would produce
; something like 0x00 to 0x78 as well as 0xF8 to 0xFF.
; $0746DA-$074702 LOCAL JUMP LOCATION
Text_DictionarySequence:
{
    REP #$30
    
    INC.w $1CDD ; Position in the $7F1200, X buffer.
    
    LDX.w $1CD9 : ASL A : AND.w #$00FF : TAY
    
    LDA Text_DictionaryPointers+2, Y : STA.b $00
    LDA Text_DictionaryPointers, Y   : TAY
    
    SEP #$20
    
    .nextCharacter
    
        LDA.w $0000, Y : STA.l $7F1200, X
        
        INX 
    INY : CPY.b $00 : BCC .nextCharacter
    
    STX.w $1CD9
    
    RTS
}

; ==============================================================================

; Dictionary pointers
; $074703-$0747C6 DATA
DictionaryPointers:
{
    dw DictionaryEntries_fourSpaces           ; 0x00 - $C703
    dw DictionaryEntries_threeSpaces          ; 0x01 - $C705
    dw DictionaryEntries_twoSpaces            ; 0x02 - $C707
    dw DictionaryEntries_possessive           ; 0x03 - $C709
    dw DictionaryEntries_and_space            ; 0x04 - $C70B
    dw DictionaryEntries_are_space            ; 0x05 - $C70D
    dw DictionaryEntries_all_space            ; 0x06 - $C70F
    dw DictionaryEntries_ain                  ; 0x07 - $C711
    dw DictionaryEntries_and_no_space         ; 0x08 - $C713
    dw DictionaryEntries_at_space             ; 0x09 - $C715
    dw DictionaryEntries_ast                  ; 0x0A - $C717
    dw DictionaryEntries_an                   ; 0x0B - $C719
    dw DictionaryEntries_at_no_space          ; 0x0C - $C71B
    dw DictionaryEntries_ble                  ; 0x0D - $C71D
    dw DictionaryEntries_ba                   ; 0x0E - $C71F
    dw DictionaryEntries_be                   ; 0x0F - $C721
    dw DictionaryEntries_bo                   ; 0x10 - $C723
    dw DictionaryEntries_can_space            ; 0x11 - $C725
    dw DictionaryEntries_che                  ; 0x12 - $C727
    dw DictionaryEntries_com                  ; 0x13 - $C729
    dw DictionaryEntries_ck                   ; 0x14 - $C72B
    dw DictionaryEntries_des                  ; 0x15 - $C72D
    dw DictionaryEntries_di                   ; 0x16 - $C72F
    dw DictionaryEntries_do                   ; 0x17 - $C731
    dw DictionaryEntries_en_space             ; 0x18 - $C733
    dw DictionaryEntries_er_space             ; 0x19 - $C735
    dw DictionaryEntries_ear                  ; 0x1A - $C737
    dw DictionaryEntries_ent                  ; 0x1B - $C739
    dw DictionaryEntries_ed_space             ; 0x1C - $C73B
    dw DictionaryEntries_en_no_space          ; 0x1D - $C73D
    dw DictionaryEntries_er_no_space          ; 0x1E - $C73F
    dw DictionaryEntries_ev                   ; 0x1F - $C741
    dw DictionaryEntries_for                  ; 0x20 - $C743
    dw DictionaryEntries_fro                  ; 0x21 - $C745
    dw DictionaryEntries_give_space           ; 0x22 - $C747
    dw DictionaryEntries_get                  ; 0x23 - $C749
    dw DictionaryEntries_go                   ; 0x24 - $C74B
    dw DictionaryEntries_have                 ; 0x25 - $C74D
    dw DictionaryEntries_has                  ; 0x26 - $C74F
    dw DictionaryEntries_her                  ; 0x27 - $C751
    dw DictionaryEntries_hi                   ; 0x28 - $C753
    dw DictionaryEntries_ha                   ; 0x29 - $C755
    dw DictionaryEntries_ight_space           ; 0x2A - $C757
    dw DictionaryEntries_ing_space            ; 0x2B - $C759
    dw DictionaryEntries_in                   ; 0x2C - $C75B
    dw DictionaryEntries_is                   ; 0x2D - $C75D
    dw DictionaryEntries_it                   ; 0x2E - $C75F
    dw DictionaryEntries_just                 ; 0x2F - $C761
    dw DictionaryEntries_know                 ; 0x30 - $C763
    dw DictionaryEntries_ly_space             ; 0x31 - $C765
    dw DictionaryEntries_la                   ; 0x32 - $C767
    dw DictionaryEntries_lo                   ; 0x33 - $C769
    dw DictionaryEntries_man                  ; 0x34 - $C76B
    dw DictionaryEntries_ma                   ; 0x35 - $C76D
    dw DictionaryEntries_me                   ; 0x36 - $C76F
    dw DictionaryEntries_mu                   ; 0x37 - $C771
    dw DictionaryEntries_nt_contraction_space ; 0x38 - $C773
    dw DictionaryEntries_non                  ; 0x39 - $C775
    dw DictionaryEntries_not                  ; 0x3A - $C777
    dw DictionaryEntries_open                 ; 0x3B - $C779
    dw DictionaryEntries_ound                 ; 0x3C - $C77B
    dw DictionaryEntries_out_space            ; 0x3D - $C77D
    dw DictionaryEntries_of                   ; 0x3E - $C77F
    dw DictionaryEntries_on                   ; 0x3F - $C781
    dw DictionaryEntries_or                   ; 0x40 - $C783
    dw DictionaryEntries_per_not_asm          ; 0x41 - $C785
    dw DictionaryEntries_ple                  ; 0x42 - $C787
    dw DictionaryEntries_pow                  ; 0x43 - $C789
    dw DictionaryEntries_pro                  ; 0x44 - $C78B
    dw DictionaryEntries_re_space             ; 0x45 - $C78D
    dw DictionaryEntries_re_no_space          ; 0x46 - $C78F
    dw DictionaryEntries_some                 ; 0x47 - $C791
    dw DictionaryEntries_se                   ; 0x48 - $C793
    dw DictionaryEntries_sh                   ; 0x49 - $C795
    dw DictionaryEntries_so                   ; 0x4A - $C797
    dw DictionaryEntries_st                   ; 0x4B - $C799
    dw DictionaryEntries_ter_space            ; 0x4C - $C79B
    dw DictionaryEntries_thin                 ; 0x4D - $C79D
    dw DictionaryEntries_ter                  ; 0x4E - $C79F
    dw DictionaryEntries_tha                  ; 0x4F - $C7A1
    dw DictionaryEntries_the                  ; 0x50 - $C7A3
    dw DictionaryEntries_thi                  ; 0x51 - $C7A5
    dw DictionaryEntries_to                   ; 0x52 - $C7A7
    dw DictionaryEntries_tr                   ; 0x53 - $C7A9
    dw DictionaryEntries_up                   ; 0x54 - $C7AB
    dw DictionaryEntries_ver                  ; 0x55 - $C7AD
    dw DictionaryEntries_with                 ; 0x56 - $C7AF
    dw DictionaryEntries_wa                   ; 0x57 - $C7B1
    dw DictionaryEntries_we                   ; 0x58 - $C7B3
    dw DictionaryEntries_wh                   ; 0x59 - $C7B5
    dw DictionaryEntries_wi                   ; 0x5A - $C7B7
    dw DictionaryEntries_you                  ; 0x5B - $C7B9
    dw DictionaryEntries_Her                  ; 0x5C - $C7BB
    dw DictionaryEntries_Tha                  ; 0x5D - $C7BD
    dw DictionaryEntries_The                  ; 0x5E - $C7BF
    dw DictionaryEntries_Thi                  ; 0x5F - $C7C1
    dw DictionaryEntries_You                  ; 0x60 - $C7C3
    dw DictionaryEntries_endOfTable           ; 0x61 - $C7C5
}
    
; ==============================================================================

; Dictionary data
; $0747C7-$0748D8 DATA
DictionaryEntries:
{
    ; $0747C7
    .fourSpaces
    db $59, $59, $59, $59 ; "    "
    
    ; $0747CB
    .threeSpaces
    db $59, $59, $59 ; "   "
    
    ; $0747CE
    .twoSpaces
    db $59, $59 ; "  "
    
    ; $0747D0
    .possessive ; "'s "
    db $51, $2C, $59
    
    ; $0747D3
    .and_space
    db $1A, $27, $1D, $59 ; "and "
    
    ; $0747D7
    .are_space
    db $1A, $2B, $1E, $59 ; "are "
    
    ; $0747DB
    .all_space
    db $1A, $25, $25, $59 ; "all "
    
    ; $0747DF
    .ain
    db $1A, $22, $27 ; "ain"
    
    ; $0747E2
    .and_no_space
    db $1A, $27, $1D ; "and"
    
    ; $0747E5
    .at_space
    db $1A, $2D, $59 ; "at "
    
    ; $0747E8
    .ast
    db $1A, $2C, $2D ; "ast"
    
    ; $0747EB
    .an
    db $1A, $27 ; "an"
    
    ; $0747ED
    .at_no_space
    db $1A, $2D ; "at"
    
    ; $0747EF
    .ble
    db $1B, $25, $1E ; "ble"
    
    ; $0747F2
    .ba
    db $1B, $1A ; "ba"
    
    ; $0747F4
    .be
    db $1B, $1E ; "be"
    
    ; $0747F6
    .bo
    db $1B, $28 ; "bo"
    
    ; $0747F8
    .can_space
    db $1C, $1A, $27, $59 ; "can "
    
    ; $0747FC
    .che
    db $1C, $21, $1E ; "che"
    
    ; $0747FF
    .com
    db $1C, $28, $26 ; "com"
    
    ; $074802
    .ck
    db $1C, $24 ; "ck"
    
    ; $074804
    .des
    db $1D, $1E, $2C ; "des"
    
    ; $074807
    .di
    db $1D, $22 ; "di"
    
    ; $074809
    .do
    db $1D, $28 ; "do"
    
    ; $07480B
    .en_space
    db $1E, $27, $59 ; "en "
    
    ; $07480E
    .er_space
    db $1E, $2B, $59 ; "er "
    
    ; $074811
    .ear
    db $1E, $1A, $2B ; "ear"
    
    ; $074814
    .ent
    db $1E, $27, $2D ; "ent"
    
    ; $074817
    .ed_space
    db $1E, $1D, $59 ; "ed "
    
    ; $07481A
    .en_no_space
    db $1E, $27 ; "en"
    
    ; $07481C
    .er_no_space
    db $1E, $2B ; "er"
    
    ; $07481E
    .ev
    db $1E, $2F ; "ev"
    
    ; $074820
    .for
    db $1F, $28, $2B ; "for"
    
    ; $074823
    .fro    
    db $1F, $2B, $28 ; "fro"
    
    ; $074826
    .give_space
    db $20, $22, $2F, $1E, $59 ; "give "
    
    ; $07482B
    .get
    db $20, $1E, $2D ; "get"
    
    ; $07482E
    .go
    db $20, $28 ; "go"
    
    ; $074830
    .have
    db $21, $1A, $2F, $1E ; "have"
    
    ; $074834
    .has
    db $21, $1A, $2C ; "has"
    
    ; $074837
    .her
    db $21, $1E, $2B ; "her"
    
    ; $07483A
    .hi
    db $21, $22 ; "hi"
    
    ; $07483C
    .ha
    db $21, $1A ; "ha"
    
    ; $07483E
    .ight_space
    db $22, $20, $21, $2D, $59 ; "ight "
    
    ; $074843
    .ing_space
    db $22, $27, $20, $59 ; "ing "
    
    ; $074847
    .in
    db $22, $27 ; "in"
    
    ; $074849
    .is
    db $22, $2C ; ""
    
    ; $07484B
    .it
    db $22, $2D ; "it"
    
    ; $07484D
    .just
    db $23, $2E, $2C, $2D ; "just"
    
    ; $074851
    .know
    db $24, $27, $28, $30 ; "know"
    
    ; $074855
    .ly_space
    db $25, $32, $59 ; "ly "
    
    ; $074858
    .la
    db $25, $1A ; "la"
    
    ; $07485A
    .lo
    db $25, $28 ; "lo"
    
    ; $07485C
    .man
    db $26, $1A, $27 ; ""
    
    ; $07485F
    .ma
    db $26, $1A ; "ma"
    
    ; $074861
    .me
    db $26, $1E ; "me"
    
    ; $074863
    .mu
    db $26, $2E ; "mu"
    
    ; $074865
    .nt_contraction_space
    db $27, $51, $2D, $59 ; "n't "
    
    ; $074869
    .non
    db $27, $28, $27 ; "non"
    
    ; $07486C
    .not
    db $27, $28, $2D ; "not"
    
    ; $07486F
    .open
    db $28, $29, $1E, $27 ; "open"
    
    ; $074873
    .ound
    db $28, $2E, $27, $1D ; "ound"
    
    ; $074877
    .out_space
    db $28, $2E, $2D, $59 ; "out"
    
    ; $07487B
    .of
    db $28, $1F ; "of"
    
    ; $07487D
    .on
    db $28, $27 ; "on"
    
    ; $07487F
    .or
    db $28, $2B ; "or"
    
    ; $074881
    .per_not_asm
    db $29, $1E, $2B ; "per"
    
    ; $074884
    .ple
    db $29, $25, $1E ; "ple"
    
    ; $074887
    .pow
    db $29, $28, $30 ; "pow"
    
    ; $07488A
    .pro
    db $29, $2B, $28 ; "pro"
    
    ; $07488D
    .re_space
    db $2B, $1E, $59 ; "re "
    
    ; $074890
    .re_no_space
    db $2B, $1E ; "re"
    
    ; $074892
    .some
    db $2C, $28, $26, $1E ; "some"
    
    ; $074896
    .se
    db $2C, $1E ; "se"
    
    ; $074898
    .sh
    db $2C, $21 ; "sh"
    
    ; $07489A
    .so
    db $2C, $28 ; "so"
    
    ; $07489C
    .st
    db $2C, $2D ; "st"
    
    ; $07489E
    .ter_space
    db $2D, $1E, $2B, $59 ; "ter "
    
    ; $0748A2
    .thin
    db $2D, $21, $22, $27 ; "thin"
    
    ; $0748A6
    .ter
    db $2D, $1E, $2B ; "ter"
    
    ; $0748A9
    .tha
    db $2D, $21, $1A ; "tha"
    
    ; $0748AC
    .the
    db $2D, $21, $1E ; "the"
    
    ; $0748AF
    .thi
    db $2D, $21, $22 ; "thi"
    
    ; $0748B2
    .to
    db $2D, $28 ; "to"
    
    ; $0748B4
    .tr
    db $2D, $2B ; "tr"
    
    ; $0748B6
    .up
    db $2E, $29 ; "up"
    
    ; $0748B8
    .ver
    db $2F, $1E, $2B ; "ver"
    
    ; $0748BB
    .with
    db $30, $22, $2D, $21 ; "with"
    
    ; $0748BF
    .wa
    db $30, $1A ; "wa"
    
    ; $0748C1
    .we
    db $30, $1E ; "we"
    
    ; $0748C3
    .wh
    db $30, $21 ; "wh"
    
    ; $0748C5
    .wi
    db $30, $22 ; "wi"
    
    ; $0748C7
    .you
    db $32, $28, $2E ; "you"
    
    ; $0748CA
    .Her
    db $07, $1E, $2B ; "Her"
    
    ; $0748CD
    .Tha
    db $13, $21, $1A ; "Tha"
    
    ; $0748D0
    .The
    db $13, $21, $1E ; "The"
    
    ; $0748D3
    .Thi
    db $13, $21, $22 ; "Thi"
    
    ; $0748D6
    .You
    dw $18, $28, $2E ; "You"
    
    ; $0748D8
    .endOfTable
}

; ==============================================================================

; $0748D9-$0748E9 JUMP LOCATION
Text_Render:
{
    LDA.w $1CD4 ; Second level controller for text mode submodules.
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Text_DrawBorder           ; 0x00 - $C8EA
    dw Text_DrawBorderIncremenal ; 0x01 - $C919
    dw Text_CharacterTilemap     ; 0x02 - $C97D
    dw Text_MessageHandler       ; 0x03 - $C984
    dw Text_Close                ; 0x04 - $CA35
}

; ==============================================================================

; Set up a DMA transfer to blit the message box frame during NMI.
; $0748EA-$074918 JUMP LOCATION
Text_DrawBorder:
{
    SR.w Text_InitBorderOffsets
    
    ; Draw the top line of the box frame.
    SR.w Text_DrawBorderRow
    
    REP #$30
    
    LDA.w #$0006 : STA.b $00
    
    .nextRow
    
        ; This loop draws the middle rows of the message box border.
        LDY.w #$0006
        
        SR.w Text_DrawBorderRow
    DEC.b $00 : BNE .nextRow
    
    LDY.w #$000C
    
    SR.w Text_DrawBorderRow
    
    LDA.w #$FFFF : STA.w $1002, X
    
    SEP #$30
    
    ; Indicates to update the tilemap using the array at $7E1000[0x???] (I'm
    ; not sure how long it can get).
    LDA.b #$01 : STA.b $14
    
    ; Skip the second routine and begin drawing the text. (Then what does $1CD4
    ; = 0x01 mean?).
    LDA.b #$02 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; This appears to be unused... it might be worth investigating what it does.
; Unlike the previous method of drawing the border, this method takes place
; over the course of 8 frames, drawing one row per frame.
; $074919-$074935 JUMP LOCATION
Text_DrawBorderIncremenal:
{
    ; Use $1000[???] to update the tilemap(s)
    LDA.b #$01 : STA.b $14
    
    ; They wanted to save 12 bytes by not including extra entries in the jump
    ; table for the 6 middle rows, (just one row). The irony here is that the
    ; code they added to do this completely negated to a whopping net savings
    ; of zero(!) bytes, whilst incurring additional, unnecessary CPU cycles.
    LDA.w $1CD7 : BEQ .alpha
        CMP.b #$07 : BCC .beta
            LDA.b #$02 : BRA .alpha
        
        .beta
        
        LDA.b #$01
    
    .alpha
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Text_DrawFirstBorderRow  ; 0x00 - $C936
    dw Text_DrawMiddleBorderRow ; 0x01 - $C94A
    dw Text_DrawBottomBorderRow ; 0x02 - $C94A
}

; ==============================================================================

; $074936-$074949 JUMP LOCATION
Text_DrawFirstBorderRow:
{
    REP #$30
    
    SR.w Text_InitBorderOffsets
    SR.w Text_DrawBorderRow
    
    LDA.w #$FFFF : STA.w $1002, X
    
    SEP #$30
    
    INC.w $1CD7
    
    RTS
} 

; ==============================================================================

; $07494A-$074960 JUMP LOCATION
Text_DrawMiddleBorderRow:
{
    REP #$30
    
    LDX.w #$0000
    LDY.w #$0006
    
    SR.w Text_DrawBorderRow
    
    LDA.w #$FFFF : STA.w $1002, X
    
    SEP #$30
    
    INC.w $1CD7
    
    RTS
}

; ==============================================================================

; $074961-$07497C JUMP LOCATION
Text_DrawBottomBorderRow:
{
    REP #$30
    
    LDX.w #$0000
    LDY.w #$000C
    
    SR.w Text_DrawBorderRow
    
    LDA.w #$FFFF : STA.w $1002, X
    
    SEP #$30
    
    INC.w $1CD7
    
    LDA.b #$02 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; Sets up a template tilemap, for which actual graphical data will be loaded
; for in the next section (joys of VWF).
; $07497D-$074983 JUMP LOCATION
Text_CharacterTilemap:
{
    SR.w Text_BuildCharacterTilemap
    
    INC.w $1CD4
    
    RTS
}

; ==============================================================================

; Generates the game text text and other processing.
; $074984-$0749FC JUMP LOCATION
Text_MessageHandler:
{
    .epsilon
    
    REP #$30
    
    ; If $1CDD < 0x63:
    LDA.w $1CDD : LDY.w #$0000 : CMP.w #$0063 : BCC .alpha
        ; Else:
        LDA.w #$0000
        
        STY.w $1CE6 ; $1CE6 = 0
        
        BRA .beta
    
    .alpha
    
    ; What is the significance of this?
    ; If( ($1CDD >= 0x3B) && ($1CDD < 0x50) ):
    CMP.w #$003B : BCC .zeta
    CMP.w #$0050 : BCS .zeta ; Or this?
        LDA.w #$0050
        
        STY.w $1CE6 ; $1CE6 = 0
        
        BRA .beta
    
    .zeta
    
    ; If($1CDD >= 0x0013 && $1CDD < 0x0028) STY.w $1CE6:
    CMP.w #$0013 : BCC .beta
    CMP.w #$0028 : BCS .beta
        LDA.w #$0028
        
        STY.w $1CE6
    
    .beta
    
    ; Maybe $1CDD in this case is something different? (also some kind of
    ; positioner?)
    STA.w $1CDD
    
    CMP.w #$0012 : BEQ .gamma
    CMP.w #$003A : BEQ .gamma
        CMP.w #$0062 : BNE .loadNextByte
    
    .gamma
    
    LDA.w $1CE6 : AND.w #$0007 : CMP.w #$0006 : BCC .loadNextByte
        ; I don't think this location is ever reached, therefore I hypothesize
        ; that this variable is never changed during VWF rendering.
        INC.w $1CDD
        
        BRA .epsilon
    
    .loadNextByte
    
    LDX.w $1CD9
    
    ; Load a character (or maybe a command) from the text buffer
    ; (Dictionary doesn't matter here so AND with 0x7F).
    LDA.l $7F1200, X : AND.w #$007F : SEC : SBC.w #$0066 : BPL .commandByte
        ; In this case it's a character.
        LDA.w #$0000
    
    .commandByte
    
    SEP #$30
    
    SR.w VWF_CharacterOrCommand
    
    LDA.b #$02 : STA.b $17 : STA.w $0710
    
    RTS
}

; ==============================================================================

; $0749FD-$074A34 LOCAL JUMP LOCATION
VWF_CharacterOrCommand:
{
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    ; Text Routines 2
    ; These routines are used in the actual generation of the text.
    
    dw VWF_Render              ; 0x00 - $CA6C
    dw VWF_NextPicture         ; 0x01 - $CCFE [NextPic]
    dw VWF_Select2Or3_Indented ; 0x02 - $CD1A [Choose]
    dw VWF_SelectItem          ; 0x03 - $CD88 [Item]
    dw VWF_IgnoreCommand       ; 0x04 - $CE6B [Name]
    dw VWF_IgnoreCommand       ; 0x05 - $CE6B [Window XX]
    dw VWF_IgnoreCommand       ; 0x06 - $CE6B [Number XX]
    dw VWF_IgnoreCommand       ; 0x07 - $CE6B [Postion XX]
    dw VWF_IgnoreCommand       ; 0x08 - $CE6B [ScrollSpd XX]
    dw VWF_Select2Or3          ; 0x09 - $CE83 [SelChng]
    dw VWF_Crash               ; 0x0A - $CEF1 [Crash]
    dw VWF_Choose3             ; 0x0B - $CEF7 [Choose3]
    dw VWF_Choose1Or2          ; 0x0C - $CF72 [Choose2]
    dw VWF_Scroll              ; 0x0D - $CFE2 [Scroll]
    dw VWF_SetLine             ; 0x0E - $D0C9 [1]
    dw VWF_SetLine             ; 0x0F - $D0C9 [2]
    dw VWF_SetLine             ; 0x10 - $D0C9 [3]
    dw VWF_SetPalette          ; 0x11 - $D0F2 [Color XX]
    dw VWF_Wait                ; 0x12 - $D115 [Wait XX] 
    dw VWF_PlaySound           ; 0x13 - $D162 [Sound XX]
    dw VWF_SetSpeed            ; 0x14 - $D176 [Speed XX]
    dw VWF_Command7B           ; 0x15 - $D18D [Command 7B]
    dw VWF_Command7C           ; 0x16 - $D1BD [Command 7C]
    dw VWF_ClearBuffer         ; 0x17 - $D1F9 [Command 7D]
    dw VWF_WaitKey             ; 0x18 - $D230 [WaitKey]
    dw VWF_EndMessage          ; 0x19 - $D25B [End]
}

; ==============================================================================

; Called after player hits A, B, Y, or X
; $074A35-$074A6B JUMP LOCATION
Text_Close:
{
    REP #$30
    
    SR.w Text_InitBorderOffsets
    
    REP #$30
    
    LDA.w $1CD0 : XBA : STA.w $1002, X : INX #2
    LDA.w .reg_config : STA.w $1002, X : INX #2
    LDA.w .data       : STA.w $1002, X : INX #2
    
    LDA.w #$FFFF : STA.w $1002, X
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    STZ.w $1CD8
    STZ.b $11
    
    ; Restore us to whatever mode we came from.
    LDA.w $010C : STA.b $10
    
    RTS
}

; ==============================================================================

; This thing takes forever to execute (handles normal characters)
; $074A6C-$074A98 JUMP LOCATION
VWF_Render:
{
    ; Which line the text is currently printing to?
    LDA.w $1CD5 : CMP.b #$02 : BCC .validSpeed
        LDA.b #$02
    
    .validSpeed
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw VWF_RenderRecursive ; 0x00 - $CA99
    dw VWF_RenderSingle    ; 0x01 - $CAB8 Speed = 1
    dw VWF_InvalidSpeed_1  ; 0x02 - $CCF9 Speed = 2 (immediately drops down to speed = 1)
    dw VWF_InvalidSpeed_2  ; 0x03 - $CCFD Speed = 3 ... doesn't do anything at all???
    dw VWF_InvalidSpeed_2  ; 0x04 - $CCFD Speed = 4 ...*rips hair out*
    dw VWF_InvalidSpeed_2  ; 0x05 - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x06 - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x07 - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x08 - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x09 - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x0A - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x0B - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x0C - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x0D - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x0E - $CCFD 
    dw VWF_InvalidSpeed_2  ; 0x0F - $CCFD 
}

; ==============================================================================

; $074A99-$074AB7 JUMP LOCATION
VWF_RenderRecursive:
{
    SR.w VWF_RenderSingle
    
    REP #$30
    
    LDA.w $1CDD
    
    ; Basically, branch if $1CDD = 19, 59, or 99 (why?).
    CMP.w #$0013 : BEQ .BRANCH_ALPHA
    CMP.w #$003B : BEQ .BRANCH_ALPHA
    CMP.w #$0063 : BEQ .BRANCH_ALPHA
        SEP #$30
        
        ; This is recursion, son. Fear it (stack overflows are possible).
        JMP.w Text_MessageHandler

    .BRANCH_ALPHA

    SEP #$30
    
    RTS
}

; ==============================================================================

; Renders a single character (non recursive).
; $074AB8-$074ADE LOCAL JUMP LOCATION
VWF_RenderSingle:
{
    REP #$10
    
    LDX.w $1CD9
    
    ; Is it a space (as in, " ").
    LDA.l $7F1200, X : CMP.b #$59 : BEQ .blankCharacter
        ; No, so make some noise.
        SEP #$30
        
        LDA.b #$0C : STA.w $012F
    
    .blankCharacter
    
    REP #$30
    
    ; There's no point to this.... X's value is destroyed in the callee below.
    LDA.w $1CDD : ASL A : TAX
    
    SEP #$30
    
    SR.w VWF_RenderCharacter
    
    LDA.w $1CD6 : STA.w $1CD5
    
    RTS
}

; $074ADF-$074B5D DATA
Pool_VWF_RenderCharacter:
{
    .widths
    
    db 6, 6, 6, 6, 6, 6, 6, 6, 3, 6, 6, 6, 7, 6, 6, 6
    db 6, 6, 6, 7, 6, 7, 7, 7, 7, 6, 6, 6, 6, 6, 6, 6
    db 6, 6, 3, 5, 6, 3, 7, 6, 6, 6, 6, 5, 6, 6, 6, 7
    db 7, 7, 7, 6, 6, 4, 6, 6, 6, 6, 6, 6, 6, 6, 3, 7
    db 6, 4, 4, 6, 8, 6, 6, 6, 6, 6, 8, 8, 8, 7, 7, 7
    db 7, 4, 8, 8, 8, 8, 8, 8, 8, 4, 8, 8, 8, 8, 8, 8
    db 8, 8, 4
    ; Interesting that there are only widths for characters
    ; 0x0 through 0x62.... what about the other 4 characters?
    
    .setMasks
    
    db $80, $40, $20, $10, $08, $04, $02, $01
    
    .renderPositions
    
    dw $0000, $02A0, $0540
    
    .linePositions
    
    dw $0000, $0040, $0080
    
    .unsetMasks
    
    db ~$80, ~$40, ~$20, ~$10, ~$08, ~$04, ~$02, ~$01
}

; ==============================================================================

; Notes:
; In this routine, "tile" means an 8 pixel by 8 pixel graphic (2bpp native to
; SNES) "character" is tile data taken from the rom for each letter of symbol.
; It could be up to 8 pixels wide, but frequently it is less, usually 3 to 7
; pixels wide. The characters are stored in 8 pixel by 16 pixels entries at
; $0E:8000 ($70000 in the Rom) each character obviously consists of 16 lines.
; If you've played the game you'd know this. $0724[2] indexes into
; $7EC230[0xC0] to indicate how many pixels (horizontally) we are into the
; current tile location once it reaches 8 we move on to the next tile.
; $074B5E-$074CF8 LOCAL JUMP LOCATION
VWF_RenderCharacter:
{
    !charWidth        = $02
    !charWidthCounter = $03

    ; Pixel data for a single horizontal row of the current (source) font tile.
    !rowOfPixels      = $04

    ; How many rows into the current (source) font tile we are.
    !charLinePos      = $06

    ; Offset relative to the beginning of the font data in ROM.
    !fontTileOffset   = $0A

    !fontBase         = $0D
    
    !changeRowFlag      = $0720
    !rowIndex           = $0722
    !cumulativePosIndex = $0724
    !renderBase         = $0726
    
    ; ---------------------------------------
    
    SEP #$30
    
    PHB : PHK : PLB
    
    REP #$20
    
    LDA !changeRowFlag : BEQ .notChangingRow
        ; Index of the line text is being generated on.
        LDY !rowIndex
        
        LDA.w .renderPositions, Y : STA !renderBase
        LDA.w .linePositions, Y   : STA !cumulativePosIndex
        
        STZ !changeRowFlag
    
    .notChangingRow
    
    SEP #$20
    REP #$10
    
    STZ !charWidthCounter
    
    LDX.w $1CD9
    
    LDA.l $7F1200, X ; Load the character value.
    
    SEP #$10
    
    ; Y = the character value.
    TAY : LDA.w .widths, Y : STA !charWidth
    
    ; Take our current (H) position in the tile, add the width of the last
    ; character, store it as the our h pixel position on the line as a whole
    ; and then moves on to the next character's cumulative position index.
    LDX !cumulativePosIndex : CLC : ADC.l $7EC230, X : STA.l $7EC231, X
    
    INX : STX !cumulativePosIndex
    
    ; Multiply the character value's upper nybble by 2 (0x62 -> 0xE2, etc).
    TYA : AND.b #$F0 : ASL A     : STA.b $00
    TYA : AND.b #$0F : ORA.b $00 : STA !fontTileOffset : STZ !fontTileOffset+1
    
    REP #$20
    
    LDA.w #$8000 : STA !fontBase
    LDY.b #$0E   : STY !fontBase+2
    
    REP #$10
    
    ; $00[2] = the byte position in the vwfBuffer, I think.
    LDA.l $7EC22F, X : AND.w #$00FF : ASL A : STA.b $00
    
    LDX.w #$0000
    
    ; Shift left by 4 to express the offset in 2bpp tiles (each is 16 bytes
    ; long).
    LDA !fontTileOffset : ASL #4 : TAY
    
    .topHalf_nextSourceRow
    
        ; Note: $0E:8000 contains uncompressed graphics for all the characters
        ; This VWF copies them byte by byte based on a width value.
        
        ; A = value at ($0E:8000 + Y).
        LDA [!fontBase], Y : STA !rowOfPixels
        
        PHY
        
        ; X is um....
        STX !charLinePos
        
        ; $00[2] is the width we have remaining for this particular CHR?
        LDA.b $00 : CLC : ADC !renderBase : TAY
        
        ; This AND operation tells us which tile in the vwfBuffer to draw to.
        AND.w #$0FF0 : CLC : ADC !charLinePos : TAX
        
        ; A = pixel position in the vwfBuffer (mod 8 because we're only
        ; concerned about the current tile).
        TYA : LSR A : AND.w #$0007 : TAY
        
        SEP #$20
        
        LDA !charWidth : STA !charWidthCounter
        
        .topHalf_notAtTargetTileBoundary
        
                ; Cycle through each bit.
                ; If the bit is clear branch.
                ASL !rowOfPixels : BCC .topHalf_unsetPlane0
                    LDA.l $7F0000, X : EOR .setMasks, Y : STA.l $7F0000, X
                    
                    BRA .topHalf_doPlane1
                
                .topHalf_unsetPlane0
                
                ; Use masks to "erase" a dot.
                ; Unset a bit in the bitmap.
                LDA.l $7F0000, X : AND .unsetMasks, Y : STA.l $7F0000, X
                
                .topHalf_doPlane1
                
                ASL !rowOfPixels+1 : BCC .topHalf_unsetPlane1
                    LDA.l $7F0001, X : EOR .setMasks, Y : STA.l $7F0001, X
                    
                    BRA .topHalf_decWidthCounter
                
                .topHalf_unsetPlane1
                
                LDA.l $7F0001, X : AND .unsetMasks, Y : STA.l $7F0001, X
                
                .topHalf_decWidthCounter
                
                DEC !charWidthCounter : BEQ .topHalf_outOfWidth
                    ; See if there's still room in the current tile. Yep,
                    ; there's still room, so branch up and handle the next bit
                    ; in the data.
        INY : CPY.w #$0008 : BNE .topHalf_notAtTargetTileBoundary
        
        .topHalf_outOfWidth
        
        ; This is reached if we run out of room in the tile or run out of
        ; "length" in the character.
        REP #$20
        
        ; Moves us to the next tile to the right in the target buffer
        ; (possibly to the next line in some cases).
        TXA : CLC : ADC.w #$0010 : TAX
        
        LDA !rowOfPixels : BEQ .topHalf_noRemainingSetPixels
            STA.l $7F0000, X
        
        .topHalf_noRemainingSetPixels
        
        PLY : INY #2
    LDX !charLinePos : INX #2 : CPX.w #$0010 : BNE .topHalf_nextSourceRow
    
    ; Positions us on the lower half of the text line.
    LDA !renderBase : CLC : ADC.w #$0150 : STA.b $08
    
    LDX.w #$0000
    
    ; Increment the row, then shift left 4 times (this grabs the next tile
    ; down).
    LDA !fontTileOffset : CLC : ADC.w #$0010 : ASL #4 : TAY
    
    .bottomHalf_NextSourceRow
    
    ; Handles the lower half of the character.
    ; A = value at ($0E:8000 + Y)
    LDA [!fontBase], Y : STA !rowOfPixels
    
    PHY
    
    STX !charLinePos
    
    LDX !cumulativePosIndex
    LDA.l $7EC22F, X : AND.w #$00FF : ASL A : CLC : ADC.b $08 : TAY
    
    AND.w #$0FF0 : CLC : ADC !charLinePos : TAX
    
    TYA : LSR A : AND.w #$0007 : TAY
    
    SEP #$20
    
    LDA !charWidth : STA !charWidthCounter
    
    .bottomHalf_notAtTargetTileBoundary
    
        ; Shift through the next bit in the line of 2bpp pixel data.
        ASL !rowOfPixels : BCC .bottomHalf_unsetPlane0
            ; Set a bit in the bitmap.
            LDA.l $7F0000, X : EOR .setMasks, Y : STA.l $7F0000, X
            
            BRA .bottomHalf_doPlane1
        
        .bottomHalf_unsetPlane0
        
        ; Unset a bit in the bitmap.
        LDA.l $7F0000, X : AND .unsetMasks, Y : STA.l $7F0000, X
        
        .bottomHalf_doPlane1
        
        ; Shift through the next bit in the "line" of 2bpp pixel data.
        ASL !rowOfPixels+1 : BCC .bottomHalf_unsetPlane1
            ; Set a bit in the bitmap.
            LDA.l $7F0001, X : EOR .setMasks, Y : STA.l $7F0001, X
            
            BRA .bottomHalf_decWidthCounter
        
        .bottomHalf_unsetPlane1
        
        ; Unset a bit in the bitmap.
        LDA.l $7F0001, X : AND .unsetMasks, Y : STA.l $7F0001, X
        
        .bottomHalf_decWidthCounter
        
        DEC !charWidthCounter : BEQ .bottomHalf_outOfWidth
            ; If not, see if we've run out of room in the current tile.
            ; We still have room in the current tile, so branch.
    INY : CPY.w #$0008 : BNE .bottomHalf_notAtTargetTileBoundary
    
    ,bottomHalf_outOfWidth
    
    ; This is reached if we run out of room in either the tile or the character.
    
    REP #$20
    
    ; Moves on to the next tile.
    TXA : CLC : ADC.w #$0010 : TAX
    
    ; See if there is any pixel data left in the current line.
    ; if there's only transparent pixels left, there's no need to keep drawing.
    LDA !rowOfPixels : BEQ .bottomHalf_noRemainingSetPixels
        ; If there still is pixel data, the "remainder" will end up in the next
        ; tile.
        STA.l $7F0000, X
    
    .bottomHalf_noRemainingSetPixels
    
    PLY : INY #2
    
    LDX !charLinePos : INX #2 : CPX.w #$0010 : BEQ .characterFinished
        BRL .bottomHalf_NextSourceRow
    
    .characterFinished
    
    ; After all that... move on to the next character!
    INC.w $1CD9
    
    SEP #$30
    
    PLB
    
    RTS
    
    ; TODO: Unused location, pretty sure.
    ; $074CF8 ALTERNATE ENTRY POINT
    .unused
    
    RTS
}

; ==============================================================================

; $074CF9-$074CFD JUMP LOCATION
VWF_InvalidSpeed:
{
    ; $074CF9
    ._1
    
    DEC.w $1CD5
    
    RTS
    
    ; $074CFD
    ._2
    
    RTS
}

; ==============================================================================

; [NextPic] Command (rendering stage)
; $074CFE-$074D15 JUMP LOCATION
VWF_NextPicture:
{
    ; Is it history mode?
    ; If it's not history module, just move to the next character.
    LDA.b $10 : CMP.b #$14 : BNE .notInAttractMode
        JSL.l PaletteFilterHistory
        
        LDA.l $7EC007 : BNE .notDoneFiltering
    
    .notInAttractMode
    
    ; Wait for the colors to finished being modified before advancing to the
    ; next character or command.
    
    REP #$30
    
    INC.w $1CD9
    
    SEP #$30
    
    .notDoneFiltering
    
    RTS
}

; $074D16-$074D19 DATA
VWF_Select2Or3_Indented_messages:
{
    dw $0001, $0002
}

; ==============================================================================

; $074D1A-$074D87 JUMP LOCATION
VWF_Select2Or3_Indented:
{
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BNE .return
            LDA.b #$24 : STA.w $012F
        
            BRA .return
    
    .readyForInput
    
    LDA.b $F4 : TAY : ORA.b $F6
    
    ; Player has chosen if the A, B, X, or Y buttons are pressed.
    AND.b #$C0 : BNE .playerHasChosen
        TYA : AND.b #$08 : BNE .upPushed
            TYA : AND.b #$04 : BNE .downPushed
                .return
                
                RTS
        
        .upPushed
        
        LDA.w $1CE8 : BEQ .return
            STZ.w $1CE8
            
            BRA .moveChoiceArrow
            
            .downPushed
            
            LDA.w $1CE8 : DEC A : BEQ .return
                LDA.b #$01 : STA.w $1CE8
                
                .moveChoiceArrow
                
                LDA.b #$20 : STA.w $012F
                
                LDA.w $1CE8 : ASL A : TAX
                
                LDA VWF_Select2Or3_Indented_messages+0, X : STA.w $1CF0
                LDA VWF_Select2Or3_Indented_messages+1, X : STA.w $1CF1
                
                SR.w Text_LoadCharacterBuffer
                
                STZ.w $1CE6
                STZ.w $1CD9
                STZ.w $1CDA
                
                SR.w Text_InitVwfState
                
            RTS
        
    .playerHasChosen
    
    ; Play a sound.
    LDA.b #$2B : STA.w $012E
    
    ; Move on to the final step of 0x0E.0x02.0x00.
    LDA.b #$04 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; [Item] command
; $074D88-$074DC7 JUMP LOCATION
VWF_SelectItem:
{
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BEQ VWF_SelectNextItem
            BRA .return
    
    .readyForInput
    
    LDA.b $F4 : ORA.b $F6 : AND.b #$C0 : BNE .playerHasChosen
        LDA.b $F4 : AND.b #$05 : BEQ .noDownOrLeftInput
            INC.w $1CE8
            
            BRA .BRANCH_EPSILON
        
        .noDownOrLeftInput
        
        LDA.b $F4 : AND.b #$0A : BEQ .noDownOrRightInput
            DEC.w $1CE8
            
            SR.w VWF_SelectPrevItem
            SR.w Text_DrawCharacterTilemap
            
            BRA .return
            
        .noDownOrRightInput

        .BRANCH_EPSILON
        
        SR.w VWF_SelectNextItem
        SR.w Text_DrawCharacterTilemap
        
        .return
        
        RTS
    
    .playerHasChosen
    
    LDA.b #$04 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; $074DC8-$074DEC LOCAL JUMP LOCATION
VWF_SelectPrevItem:
{
    .tryPrevSlot
    
        LDX.w $1CE8 : BPL .inRange
            LDX.b #$1F : STX.w $1CE8
        
        .inRange
        
        CPX.b #$0F : BEQ .invalidSlot
            LDA.l $7EF340, X : BMI .invalidValue
                BNE VWF_ChangeItemTiles

            .invalidValue
                
            CPX.b #$20 : BNE .invalidSlot
                LDA.l $7EF341, X : BNE VWF_ChangeItemTiles
        
        .invalidSlot
    DEC.w $1CE8 : BRA .tryPrevSlot
}

; ==============================================================================

; $074DED-$074E13 LOCAL JUMP LOCATION
VWF_SelectNextItem:
{
    .tryNextSlot
    
        LDX.w $1CE8 : CPX.b #$20 : BCC .inRange
            ; Wrap around back to 0x00 (so valid range is 0x00 to 0x1f).
            LDX.b #$00 : STX.w $1CE8
            
        .inRange
        
        ; The "has bottles" slot is invalid because it only is a flag for
        ; whether we have any bottles, not a tangible item.
        CPX.b #$0F : BEQ .invalidSlot
            LDA.l $7EF340, X : BMI .invalidValue
                BNE VWF_ChangeItemTiles

            .invalidValue
                
            CPX.b #$20 : BNE .invalidSlot
                
            LDA.l $7EF341, X : BNE VWF_ChangeItemTiles
            
        .invalidSlot
    INC.w $1CE8 : BRA .tryNextSlot
}
    
; $074E14-$074E6A
VWF_ChangeItemTiles:
{
    ; Y = X, Y = X << 1, A is destroyed.
    TXY : TXA : ASL A : TAX
    
    LDA.l ItemMenu_ItemGFXPointers+0, X : STA.b $00
    LDA.l ItemMenu_ItemGFXPointers+1, X : STA.b $01
    LDA.b #$0D       : STA.b $02
    
    TYX
    
    LDA.l $7EF340, X
    
    CPX.b #$20 : BEQ .isRupeesSlot
        CPX.b #$03 : BNE .notBombsSlot
    
    .isRupeesSlot
    
    LDA.b #$01
    
    .notBombsSlot
    
    ASL #3 : TAY
    
    ; Loads the 4 tilemap entries for the currently selected item type.
    LDA [$00], Y : STA.w $13C2 : INY
    LDA [$00], Y : STA.w $13C3 : INY
    LDA [$00], Y : STA.w $13C4 : INY
    LDA [$00], Y : STA.w $13C5 : INY
    LDA [$00], Y : STA.w $13EC : INY
    LDA [$00], Y : STA.w $13ED : INY
    LDA [$00], Y : STA.w $13EE : INY
    LDA [$00], Y : STA.w $13EF
    
    RTS
}

; ==============================================================================

; [Window XX], [Name], [Number XX] point here in text generation but this
; routine doesn't really do anything except grab the next character or
; command byte.
; $074E6B-$074E7E LOCAL JUMP LOCATION
VWF_IgnoreCommand:
{
    REP #$10
    
    ; Get position in character stream.
    LDX.w $1CD9 : INX
    
    ; This determines how many lines to scroll up per frame.
    LDA.l $7F1200, X : STA.w $1CEA
    
    ; Increment to the next byte in the stream.
    INX : STX.w $1CD9
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $074E7F-$074E82 DATA
VWF_Select2Or3_messages:
{
    dw $000B, $000C
}

; [SelChng]
; Check for player input. It's worth noting that there are no clear
; distinctions between this command and [Choose], other than the difference in
; the positions of the subsequent options it brings up.
; $074E83-$074EF0 JUMP LOCATION
VWF_Select2Or3:
{
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BNE .return
            LDA.b #$24 : STA.w $012F
            
            BRA .return
    
    .readyForInput
    
    ; Player has chosen if the A, B, X, or Y buttons are pressed.
    LDA.b $F4 : TAY : ORA.b $F6
    
    AND.b #$C0 : BNE .playerHasChosen
        TYA : AND.b #$08 : BNE .upPushed
            TYA : AND.b #$04 : BNE .downPushed
                .return
                
                RTS
            
                .upPushed
                
                LDA.w $1CE8 : BEQ .return
                    STZ.w $1CE8
                    
                    BRA .moveChoiceArrow
            
            .downPushed
            
            LDA.w $1CE8 : DEC A : BEQ .return
                LDA.b #$01 : STA.w $1CE8
                
                .moveChoiceArrow
                
                LDA.b #$20 : STA.w $012F
                
                LDA.w $1CE8 : ASL A : TAX
                
                LDA VWF_Select2Or3_messages+0, X : STA.w $1CF0
                LDA VWF_Select2Or3_messages+1, X : STA.w $1CF1
                
                SR.w Text_LoadCharacterBuffer
                
                STZ.w $1CE6
                STZ.w $1CD9
                STZ.w $1CDA
                
                SR.w Text_InitVwfState
                
                RTS
        
    .playerHasChosen
    
    ; Play a sound.
    LDA.b #$2B : STA.w $012E
    
    ; Move on to the final step of 0x0E.0x02.0x00.
    LDA.b #$04 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; Leads to data, hence it crashes.
; $074EF1-$074EF6 DATA
VWF_Crash:
{
}

; ==============================================================================

; $074EF1-$074EF6 DATA
VWF_Choose3_ArrowDialogs:
{
    dw $0006, $0007, $0008
}

; $074EF7-$074F6D JUMP LOCATION
VWF_Choose3:
{
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BNE .return
            ; Play flutey sound effect.
            LDA.b #$24 : STA.w $012F
            
            BRA .return
    
    .readyForInput
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : TAY
    
    AND.b #$D0 : BNE .playerHasChosen
        TYA : AND.b #$08 : BNE .upPushed
            TYA : AND.b #$04 : BNE .downPushed
                .return
                
                RTS
        
                .upPushed
                
                LDA.w $1CE8 : DEC A : CMP.b #$FF : BNE .didntUnderflow
                    LDA.b #$02
                
                .didntUnderflow
                
                STA.w $1CE8
                
                BRA .moveChoiceArrow
        
            .downPushed
            
            LDA.w $1CE8 : INC A : CMP.b #$03 : BNE .didntOverflow
                LDA.b #$00
            
            .didntOverflow
            
            STA.w $1CE8
            
            .moveChoiceArrow
            
            LDA.b #$20 : STA.w $012F
            
            LDA.w $1CE8 : ASL A : TAX
            
            LDA VWF_Choose3_ArrowDialogs+0, X : STA.w $1CF0
            LDA VWF_Choose3_ArrowDialogs+1, X : STA.w $1CF1
            
            SR.w Text_LoadCharacterBuffer
            
            STZ.w $1CE6
            STZ.w $1CD9
            STZ.w $1CDA
            
            SR.w Text_InitVwfState
            
            RTS
    
    .playerHasChosen
    
    LDA.b #$2B : STA.w $012E
    
    LDA.b #$04 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; $074F6E-$074F71 DATA
VWF_Choose1Or2_messages:
{
    dw $0009, $000A
}

; [Choose2]
; The only difference between this and [Choose] / [SelChng] is that it accepts
; the Start button as a valid affirmative input. (And the messages it links to
; for choice arrows).
; $074F72-$074FE1 JUMP LOCATION
VWF_Choose1Or2:
{
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BNE .return
            ; Play flutey sound effect.
            LDA.b #$24 : STA.w $012F
            
            BRA .return
        
    .readyForInput
    
    LDA.b $F6 : AND.b #$C0 : ORA.b $F4 : TAY
    
    ; Player has chosen if the A, B, X, Y, or Start buttons are pressed.
    AND.b #$D0 : BNE .playerHasChosen
        TYA : AND.b #$08 : BNE .upPushed
            TYA : AND.b #$04 : BNE .downPushed
                .return
                
                RTS
                
                .upPushed
                
                LDA.w $1CE8 : BEQ .return
                    STZ.w $1CE8
                    
                    BRA .moveChoiceArrow
            
            .downPushed
            
            LDA.w $1CE8 : DEC A : BEQ .return
                LDA.b #$01 : STA.w $1CE8
                
                .moveChoiceArrow
                
                LDA.b #$20 : STA.w $012F
                
                LDA.w $1CE8 : ASL A : TAX
                
                LDA VWF_Choose1Or2_messages, X   : STA.w $1CF0
                LDA VWF_Choose1Or2_messages+1, X : STA.w $1CF1
                
                SR.w Text_LoadCharacterBuffer
                
                STZ.w $1CE6
                STZ.w $1CD9
                STZ.w $1CDA
                
                SR.w Text_InitVwfState
                
            RTS
    
    .playerHasChosen
    
    LDA.b #$2B : STA.w $012E
    LDA.b #$04 : STA.w $1CD4
    
    RTS
}

; ==============================================================================

; [Scroll] (rendering stage)
; $074FE2-$0750C2 JUMP LOCATION
VWF_Scroll:
{
    ; Data bank = 0x7F.
    PHB : LDA.b #$7F : PHA : PLB
    
    ; OPTIMIZE: Useless branch.
    ; (note this is unfiltered joypad 1 input) Look for A button presses.
    LDA.b $F2 : AND.b #$80 : BEQ .A_ButtonNotHeld
        ; Holding A down doesn't make any real difference.
        LDA.l $001CEA
        
        BRA .UselessAdditionalLogic
    
    .A_ButtonNotHeld
    
    LDA.l $001CEA
    
    .UselessAdditionalLogic
    
    STA.b $02
    
    .nextLine
    
        REP #$30
        
        STZ.b $00
        
        .moveTileUpOnePixel
        
            ; This loop modifies graphical tile data by making it appear to
            ; scroll up.
            
            LDX.b $00
            
            LDA.w $0002, X : STA.w $0000, X ; Line 0 = the old Line 1
            LDA.w $0004, X : STA.w $0002, X ; Line 1 = the old Line 2, and so on
            LDA.w $0006, X : STA.w $0004, X
            LDA.w $0008, X : STA.w $0006, X
            LDA.w $000A, X : STA.w $0008, X
            LDA.w $000C, X : STA.w $000A, X
            LDA.w $000E, X : STA.w $000C, X
            LDA.w $0150, X : STA.w $000E, X ; Line 7 = the old Line 1 from the tile that is "below" this tile
            
            ; Hence the scrolling effect.
            
            LDA.b $00 : CLC : ADC.w #$0010 : STA.b $00
        CMP.w #$07E0 : BCC .moveTileUpOnePixel
        
        STZ.w $07DE
        STZ.w $07CE
        STZ.w $07BE
        STZ.w $07AE
        STZ.w $079E
        STZ.w $078E
        STZ.w $077E
        STZ.w $076E
        STZ.w $075E
        STZ.w $074E
        STZ.w $073E
        STZ.w $072E
        STZ.w $071E
        STZ.w $070E
        STZ.w $06FE
        STZ.w $06EE
        STZ.w $06DE
        STZ.w $06CE
        STZ.w $06BE
        STZ.w $06AE
        STZ.w $069E
        
        SEP #$30
        
        LDA.l $001CDF : CLC : ADC.b #$01 : STA.l $001CDF
        AND.b #$0F : BNE .lineFinished
            ; This gets called after the text has moved up 0x10 pixels.
            
            REP #$30
            
            ; Move on to the next byte in the character stream.
            LDA.l $001CD9 : CLC : ADC.w #$0001 : STA.l $001CD9
            
            ; Signify that we are on row 3 (figure head).
            LDA.w #$0050 : STA.l $001CDD
            
            ; Signify that we are on row 3 (actually does something).
            LDA.l VWF_RowPositions+4 : STA.l $000722
            
            ; Signify that we need to draw a new line.
            LDA.w #$0001 : STA.l $000720
            
            SEP #$30
            
            LDA.b #$00 : STA.l $001CE6
            
            STZ.b $02
        
        .lineFinished
        
        DEC.b $02 : BMI .doneScrolling
    JMP .nextLine
    
    .doneScrolling
    
    PLB
    
    RTS
}

; Consists of values for $7E0722
; $0750C3-$0750C8 DATA
VWF_RowPositions:
{
    dw $0000, $0002, $0004
}

; ==============================================================================

; [1], [2], and [3]
; $0750C9-$0750F1 JUMP LOCATION
VWF_SetLine:
{
    REP #$30
    
    ; X = next character in the buffer.
    LDX.w $1CD9
    
    ; Possible values are 0x74, 0x75, or 0x76.
    LDA.l $7F1200, X : AND.w #$0003 : ASL A : TAX
    
    LDA VWF_LinePositions, X : STA.w $1CDD
    
    LDA VWF_RowPositions, X : STA.w $0722
    
    ; Signal the need for a new line.
    LDA.w #$0001 : STA.w $0720
    
    ; Move to the next character in the buffer.
    INC.w $1CD9
    
    SEP #$30
    
    STZ.w $1CE6
    
    RTS
}

; ==============================================================================

; UNUSED: Does nothing unfortunately
; [Color XX]
; Color 7 is the only one used normally.
; $0750F2-$075114 JUMP LOCATION
VWF_SetPalette:
{
    REP #$10
    
    ; 0b11100011 (presumably this is to preserve vflip, hflip, priority, and
    ; the chr bits).
    LDA.w $1CDC : AND.b #$E3 : STA.w $1CDC
    
    LDX.w $1CD9 : INX
    
    ; Sets the tile palette, or rather, it would If this variable was actually
    ; used anywhere else in rendering. Sorry folks this is an abandoned feature,
    ; the command is useless, and probably rightly so in this VWF's design. The
    ; only way you could change color in this engine is to make sure you've
    ; started a new tile, which would be terribly inconvenient for a VWF.
    LDA.l $7F1200, X : AND.b #$07 : ASL #2 : ORA.w $1CDC : STA.w $1CDC
    
    INX : STX.w $1CD9
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; [Wait XX] command (actual generation)
; $075115-$075137 JUMP LOCATION
VWF_Wait:
{
    ; Check for input from the player.
    ; note that in history mode the game does not record input other than the
    ; start button specifically, NMI does record it and then later history mode
    ; deletes the input.
    LDA.b $F2 : AND.b #$80 : BEQ .A_ButtonNotHeld
        ; A button has been held down down, so break out of this wait loop
        ; prematurely.
        LDA.b #$01
        
        BRA .runWaitProcedure
        
    .A_ButtonNotHeld
    
    REP #$30
    
    LDA.w $1CE0 : CMP.w #$0002 : BCC .runWaitProcedure
        LDA.w #$0002
    
    .runWaitProcedure
    
    SEP #$30
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw VWF_WaitLoop_initCounter ; 0x00 - $D138
    dw VWF_EndWait              ; 0x01 - $D154
    dw VWF_WaitLoop_decCounter  ; 0x02 - $D14C
}

; Sets up the wait loop (valid input would be 0 - F).
; $075138-07514B JUMP LOCATION
VWF_WaitLoop_initCounter:
{
    REP #$30
    
    LDX.w $1CD9
    
    LDA.l $7F1201, X : AND.w #$000F : ASL A : TAX
    
    LDA Text_WaitDurations, X : STA.w $1CE0

    ; Bleeds into the next function.
}

; Just counts down the timer (can be as high as 8.33 seconds!).
; $07514C-$075153 JUMP LOCATION
VWF_WaitLoop_decCounter:
{   
    REP #$30
    
    DEC.w $1CE0 ; Decrement the loop counter.
    
    SEP #$30
    
    RTS
} 

; Break out of the wait loop.
; $075154-$075161 JUMP LOCATION
VWF_EndWait:
{
    REP #$30
    
    ; Moves on to the next command or character.
    INC.w $1CD9
    INC.w $1CD9
    
    SEP #$30
    
    STZ.w $1CE0
    
    RTS
}

; [Sound XX] (rendering stage)
; $075162-$075175 JUMP LOCATION
VWF_PlaySound:
{
    REP #$10
    
    LDX.w $1CD9 : INX
    
    ; Plays a sound effect.
    LDA.l $7F1200, X : STA.w $012F
    
    INX : STX.w $1CD9
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; [Speed XX] (rendering stage)
; $075176-$07518C JUMP LOCATION
VWF_SetSpeed:
{
    REP #$10
    
    LDX.w $1CD9 : INX
    
    ; Speed, also mirror location for speed.
    LDA.l $7F1200, X : STA.w $1CD6 : STA.w $1CD5
    
    ; Move to the next byte.
    INX : STX.w $1CD9
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; [Command 7B] - TODO: unused?
; Seems like it was intended to draw a item graphics (2bpp) selected from a
; list to screen, not sure though.
; $07518D-$0751BC JUMP LOCATION
VWF_Command7B:
{
    REP #$30
    
    INC.w $1CD9 : LDX.w $1CD9
    
    LDA.l $7F1200, X : AND.w #$007F : ASL #2 : TAX
    
    LDY.w $1CDD
    
    LDA Pool_VWF_Command7B_unknown, X : STA.w $12D8, Y
    
    INX #2
    
    LDA Pool_VWF_Command7B_unknown, X : STA.w $1300, Y
    
    INY #2
    
    STY.w $1CDD
    
    INC.w $1CD9
    
    SEP #$30
    
    JMP.w Text_MessageHandler
}

; ==============================================================================

; UNUSED: Command 0x7C
; $0751BD-$0751F8 JUMP LOCATION
VWF_Command7C:
{
    REP #$30
    
    INC.w $1CD9 : LDX.w $1CD9
    
    LDA.l $7F1200, X : AND.w #$007F : ASL #3 : TAX
    
    LDA.w #$0002 : STA.b $00

    LDY.w $1CDD
    
    .alpha
    
        LDA Text_Command_7C_Data, X : STA.w $12D8, Y
        
        INX #2
        
        LDA Text_Command_7C_Data, X : STA.w $1300, Y
        
        INX #2
        
        INY #2
    DEC.b $00 : BNE .alpha
    
    STY.w $1CDD
    
    INC.w $1CD9
    
    SEP #$30
    
    JMP.w Text_MessageHandler
}

; ==============================================================================

; This routine sets $7F0000 to $7F07DF to zero.
; OPTIMIZE: This could of course be sped up with a $2180 DMA transfer. Large
; zeroing loops are annoying time dumps.
; $0751F9-$07522F JUMP LOCATION
VWF_ClearBuffer:
{
    PHB : LDA.b #$7F : PHA : PLB
    
    REP #$30
    
    LDA.w #$07D0 : TAX

    .zeroLoop

        STZ.w $0000, X : STZ.w $0002, X : STZ.w $0004, X : STZ.w $0006, X
        STZ.w $0008, X : STZ.w $000A, X : STZ.w $000C, X : STZ.w $000E, X
    SEC : SBC.w #$0010 : TAX : BPL .zeroLoop
    
    PLB
    
    ; Initialize the text buffer positions.
    STZ.w $1CDD
    
    INC.w $1CD9
    
    SEP #$30
    
    STZ.w $1CE6
    
    RTS
}

; ==============================================================================

; [WaitKey] command
; Waits for someone to press a button.
; $075230-$07525A JUMP LOCATION
VWF_WaitKey:
{
    ; Note this is set to 0x1C when the game enters text mode.
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BNE .return
            ; Play that flutey sound effect.
            LDA.b #$24 : STA.w $012F
            
            BRA .return
    
    .readyForInput
    
    ; SNES equivalent to "press any key to continue", checks for A, B, X, and Y
    ; presses.
    LDA.w $00F4 : ORA.w $00F6 : AND.b #$C0 : BEQ .return
        ; If a key is pressed, move on to the next character or command.
        REP #$30
        
        INC.w $1CD9
        
        SEP #$30
        
        ; Reset the delay timer (almost half a second).
        LDA.b #$1C : STA.w $1CE9
    
    .return
    
    RTS
}

; ==============================================================================

; [End] Command
; This stops the text message completely. Corresponds to byte 0x7F in the data.
; $07525B-$07527F JUMP LOCATION
VWF_EndMessage:
{
    LDA.w $1CE9 : BEQ .readyForInput
        DEC A : STA.w $1CE9 : CMP.b #$01 : BNE .return
            ; Play flutey sound effect.
            LDA.b #$24 : STA.w $012F
            
            BRA .return
        
    .readyForInput
    
    ; This command will take any joypad input as the signal to continue,
    ; unlike [WaitKey].
    LDA.b $F4 : ORA.b $F6 : BEQ .return
        ; Exit Text mode
        LDA.b #$04 : STA.w $1CD4
        LDA.b #$1C : STA.w $1CE9
    
    .return
    
    RTS
}

; ==============================================================================

; Determines one of two positions for the text box, based on what Link's
; vertical position is.
; $075280-$07529B LOCAL JUMP LOCATION
Text_SetDefaultWindowPos:
{
    REP #$30
    
    ; Get Link's Y coordinate, Subtract Y coordinate of scroll register. This
    ; is a nifty trick, an alternative to branching to load one of two values.
    LDA.b $20 : SEC : SBC.b $E8 : CMP.w #$0078
    ROL A : EOR.w #$0001 : AND.w #$0001 : ASL A : TAX
    
    ; Ultimately, a vram address gets stored here, so the system knows where to
    ; draw the tiles.
    LDA Text_Positions, X : STA.w $1CD2
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $07529C-$0752AA LOCAL JUMP LOCATION
Text_InitBorderOffsets:
{
    REP #$30
    
    LDA.w $1CD2 : STA.w $1CD0
    
    LDX.w #$0000 : TXY
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $0752AB-$0752EB LOCAL JUMP LOCATION
Text_DrawBorderRow:
{
    REP #$30
    
    ; Store the big endian version of the base VRAM address.
    LDA.w $1CD0 : XBA : STA.w $1002, X
    
    INX #2
    
    ; Our vram address will be moving "down", so increment by 32 words.
    XBA : CLC : ADC.w #$0020 : STA.w $1CD0
    
    ; Write 0x30 bytes, use incrementing dma mode, increment on writes to $2119.
    LDA.w #$2F00 : STA.w $1002, X : INX #2
    
    LDA Text_BorderTiles, Y : STA.w $1002, X : INX #2
    
    INY #2
    
    LDA.w #$0016 : STA.b $0E
    
    LDA Text_BorderTiles, Y
    
    .repeatTile
    
        STA.w $1002, X
        
        INX #2
    DEC.b $0E : BNE .repeatTile
    
    INY #2
    
    LDA Text_BorderTiles, Y : STA.w $1002, X
    
    INX #2
    
    RTS
}

; ==============================================================================

; $0752EC-$075306 LOCAL JUMP LOCATION
Text_BuildCharacterTilemap:
{
    REP #$30
    
    LDX.w #$0000
    
    ; This loop fills $7E1300[0xFC] with incremented values of $1CE2 Which is
    ; the starting tilemap entry value. Generally speaking, this tilemap entry
    ; has settings that are determined earlier during initialization. Some of
    ; those settings are variable at compile time, like vflip (0), hflip (0),
    ; priority(1), chr (0x180).  Each iteration of this loop is essentially
    ; increasing the chr property, all the way up to 0x27b. Later on, the VWF
    ; will be constructing.
    .buildLoop
    
        LDA.w $1CE2 : STA.w $1300, X
        
        INC.w $1CE2
    INX #2 : CPX.w #$00FC : BCC .buildLoop
    
    SR.w Text_DrawCharacterTilemap
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; This routine is where the tilemap actually gets configured to be transferred
; to vram during the NMI interrupt.
; $075307-$075359 LOCAL JUMP LOCATION
Text_DrawCharacterTilemap:
{
    !num_columns = $0C
    !num_rows    = $0E
    
    ; ----------------------------------------
    
    REP #$30
    
    LDA.w #$0006 : STA !num_rows
    
    SR.w Text_InitBorderOffsets
    
    REP #$30
    
    ; Move vram target address down one tile and to the right one tile from the
    ; upper left corner of the message box's border address in vram.
    LDA.w $1CD0 : CLC : ADC.w #$0021 : STA.w $1CD0
    
    .nextRow
    
        ; Store vram address (big endian, not sure why they felt like it was
        ; good to do that).
        LDA.w $1CD0 : XBA : STA.w $1002, X
        
        ; Make it so the dma will start one row down from this one (adding 0x20
        ; to a vram address typically accopmlishes this if you can be sure that
        ; you'll remain in the same tilemap).
        XBA : CLC : ADC.w #$0020 : STA.w $1CD0
        
        ; dma will transfer 0x2a bytes (which is twice 0x15 or 21). Each row is
        ; 21 tiles, so this makes sense.
        INX #2 : LDA.w #$2900 : STA.w $1002, X
        INX #2
        
        LDA.w #$0015 : STA !num_columns
        
        ; The rows will contain tilemap entries that reference chr values 0x180
        ; through 0x194, the next 0x195 to 0x1a9, 0x1aa to 0x1be, to 0x1bf to
        ; 0x1d3, ... I think...
        .nextColumn
        
            ; Store consecutive tilemap entries from the buffer we generated
            ; just prior this subroutine call.
            LDA.w $1300, Y : STA.w $1002, X
            
            INX #2
            INY #2
        DEC !num_columns : BNE .nextColumn
    DEC !num_rows    : BNE .nextRow
    
    LDA.w #$FFFF : STA.w $1002, X
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    RTS
}
    
; ==============================================================================

; $07535A-$07536A DATA
Text_InitializationData:
{
    ; Nothing of note here, sets $1CD0-$1CD7 to 0x00.
    db $00, $00, $00, $00, $00, $00, $00, $00
    
    ; Of note, this first byte sets $1CD8, to 1, advancing the submodule index
    ; in the text module The 5th byte sets $1CDC 0b00111001 (unused variable,
    ; but best guess indicates that it would direct a previous version of the
    ; engine to set the priority bits in VWF tilemap entries, and use palette
    ; 6, and to use chr starting at 0x100.
    db $01, $00, $00, $00, $39, $00, $00, $00

    db $00
}

; $07536B-$07537E DATA
RenderText_MoreInitialSettings:
{
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $1C, $04, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00
}
    
; ==============================================================================

; $07537F-$075390 DATA
Text_BorderTiles:
{
    .top
    dw $28F3, $28F4, $28F3
    
    .middle
    dw $28C8, $387F, $68C8
    
    .bottom
    dw $A8F3, $A8F4, $E8F3
}
    
; ==============================================================================

; $075391-$075394
Text_Positions:
{
    dw $6125, $6244
}
    
; ==============================================================================

; $075395-$075398
Pool_Text_Close:
{
    .reg_config
    
    dw $2E42
    
    .data
    
    dw $387F
}
    
; ==============================================================================

; $075399-$07539E DATA
VWF_LinePositions:
{
    ; Line position values
    dw $0000, $0028, $0050
}
    
; ==============================================================================

; $07539F-$0753A6 DATA
Text_Command_7C_Data:
{
    ; For use with command 0x7C (looks like items if you look at vram).
    dw $24B8, $24BA, $24BC, $24BE
}
    
; ==============================================================================

; $0753A7-$0753AE DATA
Pool_VWF_Command7B:
{
    ; For use with command 0x7B (looks like items if you look at vram).
    .unknown
    dw $24B8, $24BA, $24BC, $24BE
}
    
; ==============================================================================

; $0753AF-$0753CE DATA
Text_WaitDurations:
{
    ; As expressed in frames or (1/60ths of a second).
    dw $001F, $003F, $005E, $007D, $009C, $00BC, $00DB, $00FA
    dw $0119, $0139, $0158, $0177, $0196, $01B6, $01D5, $01F4
}
    
; ==============================================================================

; $0753CF-$0753D1
Text_UnusedData:
{
    ; Unused? I can't find this used anywhere in the ROM, and it has no clear
    ; contextual hidden usage, except maybe they used to have more commands,
    ; but I think it's a stretch that one of them was 8 bytes long.... dunno.
    db 8, 3, 1
}
    
; $0753D2-$0753EA
Text_CommandLengths:
{
    ; Command argument lengths, starting with command 0x67 all the way up to
    ; command 0x7f (terminate). The length includes the command itself, for
    ; reference.
    db 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1
    db 2, 2, 2, 2, 1, 1, 1, 1, 1
}

; ==============================================================================

; In this routine:
; $00[3] - index into $1C:8000
; $0753EB-$07544A LONG JUMP LOCATION
Text_GenerateMessagePointers:
{
    !commandLengthTable = Text_CommandLengths-$67
    
    ; -------------------------------------------
    
    PHB : PHK : PLB
    
    ; Would indicate that memory accesses at $00 will have.
    ; Bank 1C/2 = 8 + 6 = E IN ROM
    LDA.b #$1C : STA.b $02
    
    REP #$30
    
    ; $00[3]: $1C8000, which is rom address $E0000.
    LDA.w #$8000 : STA.b $00
    
    LDX.w #$0000
    
    .nextPointer
    
    LDA.b $00 : STA.l $7F71C0, X
    
    ; $7F71C0[3] = #$1C8000 on the first iteration.
    LDA.b $01 : STA.l $7F71C1, X
    
    INX #3
    
    .keepGoing
    
        ; $1C8000 => $0E0000 IN ROM
        LDA [$00] : AND.w #$00FF : TAY
        
        LDA !commandLengthTable, Y : AND.w #$00FF
        
        CPY.w #$0067 : BCC .characterCodeOrDictionary
            CPY.w #$0080 : BCC .isCommand
        
        .characterCodeOrDictionary
        
        ; Characters and dictionary entries are always 1 byte, whereas
        ; commands are variable length (1 or 2).
        LDA.w #$0001
        
        .isCommand
        
        ; Increment our position in the pointer table by one.
        CLC : ADC.b $00 : STA.b $00
        
        ; Is it the terminator byte? If so, load the next pointer.
        CPY.w #$007F : BEQ .nextPointer
            ; Refers to the fact that you won't switch data sets yet.
            CPY.w #$0080 : BNE .noSwitch
                ; A byte of 0x80 indicates the end of all text.
                DEX #3
                
                LDA.w #$DF40 : STA.b $00
                
                LDA.w #$000E : STA.b $02
                
                BRA .nextPointer
            
            .noSwitch
    
        ; This is not entirely necessary but I guess it provides another stop
        ; condition.
    CPY.w #$00FF : BNE .keepGoing
    
    SEP #$30
    
    PLB
    
    RTL
}

; ==============================================================================

; $07544B-$07545F - NULL (bytes with value 0xFF)
NULL_0ED44B:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF
}

; $075460-$075503 - used in dungeons to set $0AB6, $0AAC, $0AAD, and $0AAE.
UnderworldPaletteSets:
{
    db $00, $00, $03, $01
    db $02, $00, $03, $01
    db $04, $00, $0A, $01
    db $06, $00, $01, $07
    db $0A, $02, $02, $07
    db $04, $04, $03, $0A
    db $0C, $05, $08, $14
    db $0E, $00, $03, $0A
    db $02, $00, $0F, $14
    db $0A, $02, $00, $07
    db $02, $00, $0F, $0C
    db $06, $00, $06, $07
    db $00, $00, $0E, $12
    db $12, $05, $05, $0B
    db $12, $00, $02, $0C
    db $10, $05, $0A, $07
    db $10, $00, $10, $0C
    db $16, $07, $02, $07
    db $16, $00, $07, $0F
    db $08, $00, $04, $0C
    db $08, $00, $04, $09
    db $04, $00, $03, $01
    db $14, $00, $04, $04
    db $14, $00, $14, $0C
    db $18, $05, $07, $0B
    db $18, $06, $10, $0C
    db $1A, $05, $08, $14
    db $1A, $02, $00, $07
    db $06, $00, $03, $0A
    db $1C, $00, $03, $01
    db $1E, $00, $0B, $11
    db $04, $00, $0B, $11
    db $0E, $00, $00, $02
    db $20, $08, $13, $0D
    db $0A, $00, $03, $0A
    db $14, $00, $04, $04
    db $1A, $02, $02, $07
    db $1A, $0A, $00, $00
    db $00, $00, $03, $02
    db $0E, $00, $03, $07
    db $1A, $05, $05, $0B
}

; $075504-$07557F - used to set $0AB4, $0AB5, and $0AB8.
OverworldPaletteSet:
{
    db $00, $FF, $07, $FF
    db $00, $01, $07, $FF
    db $00, $02, $07, $FF
    db $00, $03, $07, $FF
    db $00, $04, $07, $FF
    db $00, $05, $07, $FF
    db $00, $06, $07, $FF
    db $07, $06, $05, $FF
    db $00, $08, $07, $FF
    db $00, $09, $07, $FF
    db $00, $0A, $07, $FF
    db $00, $0B, $07, $FF
    db $00, $FF, $07, $FF
    db $00, $FF, $07, $FF
    db $03, $04, $07, $FF
    db $04, $04, $03, $FF
    db $10, $FF, $06, $FF
    db $10, $01, $06, $FF
    db $10, $11, $06, $FF
    db $10, $03, $06, $FF
    db $10, $04, $06, $FF
    db $10, $05, $06, $FF
    db $10, $06, $06, $FF
    db $12, $13, $04, $FF
    db $12, $05, $04, $FF
    db $10, $09, $06, $FF
    db $10, $0B, $06, $FF
    db $10, $0C, $06, $FF
    db $10, $0D, $06, $FF
    db $10, $0E, $06, $FF
    db $10, $0F, $06, $FF
}

; $075580-$0755A7 - used to set $0AAD and $0AAE.
OverworldSpritesPaletteSet:
{
    db $FF, $FF
    db $03, $0A
    db $03, $06
    db $03, $01
    db $00, $02
    db $03, $0E
    db $03, $02
    db $13, $01
    db $0B, $0C
    db $11, $01
    db $07, $05
    db $11, $00
    db $09, $0B
    db $0F, $05
    db $03, $05
    db $03, $07
    db $0F, $02
    db $0A, $02
    db $05, $01
    db $0C, $0E
}

; $0755A8-$0755F3 LONG JUMP LOCATION
Overworld_LoadPalettes:
{
    ASL #2 : TAX ; *2
        
    STZ.w $0AA9
        
    LDA.l OverworldPaletteSet+0, X : BMI .noPaletteChange1
        STA.w $0AB4
    
    .noPaletteChange1
    
    LDA.l OverworldPaletteSet+1, X : BMI .noPaletteChange2
        STA.w $0AB5
    
    .noPaletteChange2
    
    LDA.l OverworldPaletteSet+2, X : BMI .noPaletteChange3
        STA.w $0AB8
    
    .noPaletteChange3
    
    LDA.b $00 : ASL A : TAX
        
    LDA.l OverworldPaletteSet+3, X : BMI .noPaletteChange4
        STA.w $0AAD
    
    .noPaletteChange4
    
    LDA.l OverworldPaletteSet+5, X : BMI .noPaletteChange5
        STA.w $0AAE
    
    .noPaletteChange5
    
    JSL.l Palette_OverworldBgAux1
    JSL.l Palette_OverworldBgAux2
    JSL.l Palette_OverworldBgAux3
    JSL.l Palette_SpriteAux1
    JSL.l Palette_SpriteAux2
    
    ; TODO: Confirm whether this is an actual alternate entry point or not.
    ; $0755F3 ALTERNATE ENTRY POINT
    
    RTL
}

; Zero Bg color
; $0755F4-$07560A LONG JUMP LOCATION
Palette_BgAndFixedColor:
{
    REP #$20
        
    LDA.w #$0000
    
    ; $0755F9 ALTERNATE ENTRY POINT
    .setBgColor
    
    STA.l $7EC500
    STA.l $7EC540
    STA.l $7EC300
    STA.l $7EC340
        
    SEP #$30

    ; Bleed into the next function.
}

; $07560B-$075617 LONG JUMP LOCATION
SetBGColorCacheOnly:
{
    .justFixedColor
    
    ; Sets color add / sub settings to normal intensity.
    LDA.b #$20 : STA.b $9C
    LDA.b #$40 : STA.b $9D
    LDA.b #$80 : STA.b $9E
        
    RTL
}

; $075618-$07561C LONG JUMP LOCATION
Palette_SetOwBgColor_Long:
{
    SR.w Palette_GetOwBgColor
        
    ; Sets fixed color to normal and zeroes the first color of some palettes.
    BRA Palette_BgAndFixedColor_setBgColor
}

; $07561D-$075621 LONG JUMP LOCATION
Overworld_SetScreenBGColorCacheOnly:
{
    SR.w Palette_GetOwBgColor
        
    BRA SetBGColorCacheOnly
}

; $075622-$075652 LOCAL JUMP LOCATION
; ZS changes this function.
Palette_GetOwBgColor:
{
    REP #$30
        
    ; Default green color
    LDX.w #$2669
        
    ; ZS writes here.
    ; $075627 - ZS Custom Overworld
    ; If area number < 0x80
    LDA.b $8A : CMP.w #$0080 : BCC .notSpecialArea
        ; Check for special areas
        LDA.b $A0
        
        CMP.w #$0183 : BEQ .specialArea
        CMP.w #$0182 : BEQ .specialArea
        CMP.w #$0180 : BNE .finished
            .specialArea

            ; The special areas have a slightly darker shade of green.
            LDX.w #$19C6
        
        BRA .finished
    
    .notSpecialArea
    
    ; Default green color.
    LDX.w #$2669
        
    LDA.b $8A : AND.w #$0040 : BEQ .finished
        ; Default tan color for the dark world.
        LDX.w #$2A32                            
    
    .finished
    
    TXA
        
    RTS
}

; UNUSED:
; $075653-$075655 LONG JUMP LOCATION
Palette_AssertTranslucencySwap_ForcePlayerToBg1:
{
    ; These two instructions don't seem to have a reference.
    LDA.b #$01 : STA.b $EE

    ; Bleed into the next function.
}

; $075657-$07565B LONG JUMP LOCATION
Palette_AssertTranslucencySwap:
{   
    LDA.b #$01 : STA.w $0ABD

    ; Bleed into the next function.
}

; $07565C-$0756B8 LOCAL JUMP LOCAION
Palette_PerformTranslucencySwap:
{
    REP #$21
        
    LDX.b #$00
    
    .swap_palettes
    
        ; e.g. $415 means $7EC415, for your reference
        ; Description: the below swaps memory regions $7EC400-$7EC41F and
        ; $7EC4B0-$7EC4BF with $7EC4E0-$7EC4FF and $7EC470-$7EC47F,
        ; respectively. This suggests 3bpp since each 0x10 byte region could be 
        ; considered a full palette.
        ; At the same time, it also copies this info in the Main palette 
        ; buffer and the Auxiliary palette buffer.
        
        ; OPTIMIZE: This could, at the very least, utilize a data bank value of
        ; 0x7E to speed things up and save space.
        
        ; Swap SP0_L with SP7_L.
        LDA.l $7EC400, X : PHA
        
        LDA.l $7EC4E0, X : STA.l $7EC400, X
                           STA.l $7EC600, X
        
        PLA : STA.l $7EC4E0, X
              STA.l $7EC6E0, X
        
        ; Swap SP0_H with SP7_H.
        LDA.l $7EC410, X : PHA
        
        LDA.l $7EC4F0, X : STA.l $7EC410, X
                           STA.l $7EC610, X
        
        PLA : STA.l $7EC4F0, X
              STA.l $7EC6F0, X
        
        ; Swap SP5_H with SP3_H.
        LDA.l $7EC4B0, X : PHA
        
        LDA.l $7EC470, X : STA.l $7EC4B0, X
                           STA.l $7EC6B0, X
        
        PLA : STA.l $7EC470, X
              STA.l $7EC670, X
    INX #2 : CPX.b #$10 : BNE .swap_palettes
        
    SEP #$20
        
    INC.b $15
        
    RTL
}

; ==============================================================================
    
; UNUSED: Again, only the top label is unused.
; $0756B9-$0756BA LONG JUMP LOCATION
Palette_RevertTranslucencySwap_ForcePlayerBg2:
{
    STZ.b $EE

    ; Bleed into the next function.
}

; $0756BB-$0756BF
Palette_RevertTranslucencySwap:
{
    STZ.w $0ABD
        
    BRA Palette_PerformTranslucencySwap
}

; ==============================================================================

; Called "actual" because none of the types of gear (sword, shield, armor)
; are faked or substituted with preset values.
; $0756C0-$0756D0 LONG JUMP LOCATION
LoadActualGearPalettes:
{
    REP #$20
        
    ; Link's sword and shield value.
    LDA.l $7EF359 : STA.b $0C
        
    ; Link's armor value.
    LDA.l $7EF35B : AND.w #$00FF
        
    BRA LoadGearPalettes_variable
}

; ==============================================================================

; Loads player palettes for unusual states, such as being electrocuted
; or using the Ether spell.
; $0756D1-$0756DC LONG JUMP LOCATION
Palette_ElectroThemedGear:
{
    REP #$20
        
    LDA.w #$0202 : STA.b $0C
        
    LDA.w #$0404
        
    BRA LoadGearPalettes_variable
}

; ==============================================================================

; $0756DD-$075740 LONG JUMP LOCATION
LoadGearPalettes:
{
    .bunny
    
    REP #$20
        
    ; What type of sword and armor does Link have? (2 bytes).
    LDA.l $7EF359 : STA.b $0C
        
    ; ....... ? .......
    LDA.w #$0303
    
    .variable
    
    STA.b $0E
        
    ; Setting up the bank for the source data.
    LDA.w #$001B : STA.b $02
        
    ; X = #$0, #$1, #$2, #$3, or #$4 (sword value).
    LDX.b $0C
        
    ; A = #$0, #$0, #$6, #$C, or #$12.
    LDA.l SwordPaletteOffsets, X : AND.w #$00FF : CLC : ADC.w #$D630
        
    REP #$10
        
    LDX.w #$01B2 ; Offset into the palette array.
    LDY.w #$0002 ; Length of the palette in words.
        
    SR.w LoadGearPalette
        
    SEP #$10
        
    ; X = #$0, #$1, #$2, or #$3 (shield value).
    LDX.b $0D
        
    ; A = #$0, #$0, #$8, or #$10.
    LDA.l ShieldPaletteOffsets, X : AND.w #$00FF : CLC : ADC.w #$D648
        
    REP #$10
        
    LDX.w #$01B8
    LDY.w #$0003
        
    SR.w LoadGearPalette
        
    SEP #$10
        
    ; Armor value
    LDX.b $0E
        
    LDA.l LinkMailPalettesOffsets, X : AND.w #$00FF : ASL A : CLC : ADC.w #$D308
        
    REP #$10
        
    LDX.w #$01E2
    LDY.w #$000E
        
    SR.w LoadGearPalette
        
    SEP #$30
        
    INC.b $15
        
    RTL
}

; ==============================================================================
    
; $075741-$075756 LONG JUMP LOCATION
LoadGearPalette:
{
    ; ($00 is variable input).
    STA.b $00

    .nextColor

        ; LDA from address $1BXXXX into auxiliary cgram buffer and normal cgra
        ; buffer. 
        LDA [$00] : STA.l $7EC300, X : STA.l $7EC500, X

        ; Y is the length of the palette in colors (words).
        INC.b $00 : INC.b $00
        
        INX #2
    DEY : BPL .nextColor

    RTL
}

; ==============================================================================

; $075757-$0757FD LONG JUMP LOCATION
Filter_Majorly_Whiten_Bg:
{
    REP #$20
        
    LDX.b #$00
    
    .next_color_in_each_palette
    
        LDA.l $7EC340, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC540, X
        LDA.l $7EC350, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC550, X
        LDA.l $7EC360, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC560, X
        LDA.l $7EC370, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC570, X
        LDA.l $7EC380, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC580, X
        LDA.l $7EC390, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC590, X
        LDA.l $7EC3A0, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC5A0, X
        LDA.l $7EC3B0, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC5B0, X
        LDA.l $7EC3C0, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC5C0, X
        LDA.l $7EC3D0, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC5D0, X
        LDA.l $7EC3E0, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC5E0, X
        LDA.l $7EC3F0, X : SR.w Filter_Majorly_Whiten_Color : STA.l $7EC5F0, X
    INX #2 : CPX.b #$10 : BEQ .finished_whitening_increment
        
    JMP .next_color_in_each_palette
    
    .finished_whitening_increment
    
    REP #$10
        
    LDA.l $7EC540 : TAY
        
    LDA.l $7EC300 : BNE .non_black_backdrop_color
        
        ; What this is saying is don't whiten or muck with a black backdrop,
        ; but other colors are fine to alter.
        TAY
    .non_black_backdrop_color
    
    TYA : STA.l $7EC500
        
    SEP #$30
        
    RTL
}

; ==============================================================================

; $0757FE-$075839 LOCAL JUMP LOCATION
Filter_Majorly_Whiten_Color:
{
    STA.b $00
        
    AND.w #$001F : CLC : ADC.w #$000E : CMP.w #$001F : BCC .red_not_maxed
        LDA.w #$001F
    
    .red_not_maxed
    
    STA.b $02
        
    LDA.b $00 : AND.w #$03E0 : CLC : ADC.w #$01C0 : CMP.w #$03E0 : BCC .green_not_maxed
        LDA.w #$03E0
    
    .green_not_maxed
    
    STA.b $04
        
    LDA.b $00 : AND.w #$7C00 : CLC : ADC.w #$3800 : CMP.w #$7C00 : BCC .blue_not_maxed
        LDA.w #$7C00
    
    .blue_not_maxed
    
    ORA.b $02 : ORA.b $04
        
    RTS
}

; ==============================================================================

; $07583A-$0758AD LONG JUMP LOCATION
Palette_Restore_BG_From_Flash:
{
    REP #$20
        
    LDX.b #$00
    
    .restore_loop
        LDA.l $7EC340, X : STA.l $7EC540, X
        LDA.l $7EC350, X : STA.l $7EC550, X
        LDA.l $7EC360, X : STA.l $7EC560, X
        LDA.l $7EC370, X : STA.l $7EC570, X
        LDA.l $7EC380, X : STA.l $7EC580, X
        LDA.l $7EC390, X : STA.l $7EC590, X
        LDA.l $7EC3A0, X : STA.l $7EC5A0, X
        LDA.l $7EC3B0, X : STA.l $7EC5B0, X
        LDA.l $7EC3C0, X : STA.l $7EC5C0, X
        LDA.l $7EC3D0, X : STA.l $7EC5D0, X
        LDA.l $7EC3E0, X : STA.l $7EC5E0, X
        LDA.l $7EC3F0, X : STA.l $7EC5F0, X
        
    INX #2 : CPX.b #$10 : BNE .restore_loop
        
    LDA.l $7EC540 : STA.l $7EC500
        
    SEP #$30
    
    ; Bleeds into the next function.
}

; ZS replaces this whole function. - ZS Custom Overworld
; $0758AE-$0758FA LONG JUMP LOCATION
Palette_RestoreFixedColor:
{
    LDA.b $1B : BNE .noSpecialColor
        REP #$10
        
        LDX.w #$4020 : STX.b $9C
        LDX.w #$8040 : STX.b $9D
        
        LDX.w #$4F33
        LDY.w #$894F
        
        LDA.b $8A    : BEQ .noSpecialColor
        CMP.b #$40 : BEQ .noSpecialColor
            CMP.b #$5B : BEQ .specialColor
                LDX.w #$4C26
                LDY.w #$8C4C
                
                CMP.b #$03 : BEQ .specialColor
                CMP.b #$05 : BEQ .specialColor
                CMP.b #$07 : BEQ .specialColor
                    LDX.w #$4A26
                    LDY.w #$874A
                    
                    ; DW death mountain.
                    CMP.b #$43 : BEQ .specialColor
                    CMP.b #$45 : BEQ .specialColor
                        CMP.b #$47 : BNE .noSpecialColor
                    
            .specialColor

            STX.b $9C
            STY.b $9D
    
    .noSpecialColor
    
    SEP #$10
        
    RTL
}

; ==============================================================================

; $0758FB-$075919 LONG JUMP LOCATION
Palette_Restore_BG_And_HUD:
{
    REP #$20
        
    LDX.b #$7E
    
    .next_color
    
        LDA.l $7EC300, X : STA.l $7EC500, X
        LDA.l $7EC380, X : STA.l $7EC580, X
    DEX #2 : BPL .next_color
        
    SEP #$20
        
    INC.b $15
        
    JMP.w Palette_RestoreFixedColor
}

; ==============================================================================

; $07591A-$07593F NULL 0x26
NULL_0ED91A:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $075940-$07594B JUMP LOCATION (LONG)
PalaceMap_LightenUpMap:
{
    INC.b $13
        
    LDA.b $13 : CMP.b #$0F : BNE .stillTooDark
        INC.w $0200
    
    .stillTooDark

    .return
    
    RTL
}

; ==============================================================================
    
; $07594C-$075A36 JUMP LOCATION (LONG)
PalaceMap_Backup:
{
    ; Darken the screen until it's fully dark.
    ; Then we can do some actual work.
    DEC.b $13 : BNE PalaceMap_LightenUpMap_return
        ; Turn off mosaic on BG1 and BG2.
        LDA.b #$03 : STA.b $95
            
        ; Cache the HDMA setup for later when we're done with the map
        ; because EnableForceBlank turns off HDMA.
        LDA.b $9B : STA.l $7EC229
            
        JSL.l EnableForceBlank
            
        ; Move on to next step of the submodule, and initialize the
        ; initilization indicator ($020D).
        INC.w $0200 : STZ.w $020D
            
        ; Set the fixed color to neutral (a value of 0,0,0).
        LDA.b #$20 : STA.b $9C
        LDA.b #$40 : STA.b $9D
        LDA.b #$80 : STA.b $9E
            
        REP #$20
            
        ; Set's Link's graphics to a particular configuration useful during the
        ; palace map mode.
        LDA.w #$0250 : STA.w $0100
        
        LDX.b #$7E
        
        .cachePaletteBuffer
        
            ; Store the CGRAM buffer away for safe keeping until we get back
            ; from map mode.
            LDA.l $7EC500, X : STA.l $7FDD80, X
            LDA.l $7EC580, X : STA.l $7FDE00, X
            LDA.l $7EC600, X : STA.l $7FDE80, X 
            LDA.l $7EC680, X : STA.l $7FDF00, X
        DEX #2 : BPL .cachePaletteBuffer
            
        ; Cache BG scroll offset (for quaking and such).
        LDA.w $011A : STA.l $7EC221
        LDA.w $011C : STA.l $7EC223
            
        STZ.w $011A : STZ.w $011C
            
        ; Cache all BG scroll value.
        LDA.b $E0 : STA.l $7EC200
        LDA.b $E2 : STA.l $7EC202
        LDA.b $E6 : STA.l $7EC204
        LDA.b $E8 : STA.l $7EC206
            
        ; Zero all the BG scroll values after that.
        STZ.b $E0 : STZ.b $E2 : STZ.b $E4
        STZ.b $E6 : STZ.b $E8 : STZ.b $EA
            
        ; Cache CGWSEL register.
        LDA.b $99 : STA.l $7EC225
            
        ; Set cg +/- to be subscreen addition and turn on half color math
        ; (but enable it on no layers?).
        LDA.w #$2002 : STA.b $99
            
        LDX.b #$00
        LDA.w #$0300
        
        .writeLoop
        
            STA.l $7F0000, X : STA.l $7F0100, X
            STA.l $7F0200, X : STA.l $7F0300, X
            STA.l $7F0400, X : STA.l $7F0500, X
            STA.l $7F0600, X : STA.l $7F0700, X
            STA.l $7F0800, X : STA.l $7F0900, X
            STA.l $7F0A00, X : STA.l $7F0B00, X
            STA.l $7F0C00, X : STA.l $7F0D00, X
            STA.l $7F0E00, X : STA.l $7F0F00, X  
        DEX #2 : BNE .writeLoop
            
        SEP #$20
            
        ; Play sound effect for opening the Palace Map.
        LDA.b #$10 : STA.w $012F
            
        ; Quiet the music a bit when we're in map mode.
        LDA.b #$F2 : STA.w $012C
            
        RTL
}

; =============================================

; $075A37-$075A78 JUMP LOCATION (LONG)
PalaceMap_FadeMapToBlack:
{
    DEC.b $13 : BNE .notDoneDarkening
        
        ; Forceblank the screen
        JSL.l EnableForceBlank
        
        ; Move to next step of submodule.
        INC.w $0200
        
        REP #$30
        
        LDA.l $7EC225 : STA.b $99
        LDA.l $7EC200 : STA.b $E0
        LDA.l $7EC202 : STA.b $E2
        LDA.l $7EC204 : STA.b $E6
        LDA.l $7EC206 : STA.b $E8
        
        STZ.b $E4
        STZ.b $EA
        
        LDA.l $7EC221 : STA.w $011A
        LDA.l $7EC223 : STA.w $011C
        
        SEP #$30
        
        INC.b $15
    .notDoneDarkening
    
    RTL
}

; ==============================================================================

; $075A79-$075A9B JUMP LOCATION (LONG)
PalaceMap_LightenUpDungeon:
{
    JSL.l OrientLampBg
        
    INC.b $13
        
    LDA.b $13 : CMP.b #$0F : BNE .notDoneBrightening
        LDA.w $010C : STA.b $10
        
        STZ.b $11
        STZ.w $0200
        STZ.b $B0
        
        ; Bring screen brightness to full.
        LDA.b #$0F : STA.b $13
    
        ; Restore hdma settings from before being in map mode.
        LDA.l $7EC229 : STA.b $9B
    
    .notDoneBrightening
    
    RTL
}

; ==============================================================================

; $075A9C-$075D3F DATA
DungeonMap_BG3Tilemap:
{
    dw $4260, $0100 ; VRAM $C084 | 2 bytes | Horizontal
    dw $2100

    dw DMA.6_TransferParameters, $0E40 ; VRAM $C086 | 16 bytes | Fixed horizontal
    dw $2101

    dw $4B60, $0100 ; VRAM $C096 | 2 bytes | Horizontal
    dw $6100

    dw $6260, $2EC0 ; VRAM $C0C4 | 48 bytes | Fixed vertical
    dw $2110

    dw $6B60, $2EC0 ; VRAM $C0D6 | 48 bytes | Fixed vertical
    dw $6110

    dw $6263, $0100 ; VRAM $C6C4 | 2 bytes | Horizontal
    dw $A100

    dw $6363, $0E40 ; VRAM $C6C6 | 16 bytes | Fixed horizontal
    dw $A101

    dw $6B63, $0100 ; VRAM $C6D6 | 2 bytes | Horizontal
    dw $E100

    dw $8460, $0B00 ; VRAM $C108 | 12 bytes | Horizontal
    dw $2102, $2103, $2104, $2105, $2106, $2107

    dw $A460, $0B00 ; VRAM $C148 | 12 bytes | Horizontal
    dw $2112, $2113, $2114, $2115, $2116, $2117

    dw $4E60, $0100 ; VRAM $C09C | 2 bytes | Horizontal
    dw $2100

    dw $4F60, $1A40 ; VRAM $C09E | 28 bytes | Fixed horizontal
    dw $2101

    dw $5D60, $0100 ; VRAM $C0BA | 2 bytes | Horizontal
    dw $6100

    dw $6E60, $2EC0 ; VRAM $C0DC | 48 bytes | Fixed vertical
    dw $2110

    dw $7D60, $2EC0 ; VRAM $C0FA | 48 bytes | Fixed vertical
    dw $6110

    dw $6E63, $0100 ; VRAM $C6DC | 2 bytes | Horizontal
    dw $A100

    dw $6F63, $1A40 ; VRAM $C6DE | 28 bytes | Fixed horizontal
    dw $A101

    dw $7D63, $0100 ; VRAM $C6FA | 2 bytes | Horizontal
    dw $E100

    dw $0060, $7E40 ; VRAM $C000 | 128 bytes | Fixed horizontal
    dw $2111

    dw $8063, $3E41 ; VRAM $C700 | 320 bytes | Fixed horizontal
    dw $2111

    dw $0060, $3EC0 ; VRAM $C000 | 64 bytes | Fixed vertical
    dw $2111

    dw $0160, $3EC0 ; VRAM $C002 | 64 bytes | Fixed vertical
    dw $2111

    dw $0C60, $3EC0 ; VRAM $C018 | 64 bytes | Fixed vertical
    dw $2111

    dw $0D60, $3EC0 ; VRAM $C01A | 64 bytes | Fixed vertical
    dw $2111

    dw $1E60, $3EC0 ; VRAM $C03C | 64 bytes | Fixed vertical
    dw $2111

    dw $1F60, $3EC0 ; VRAM $C03E | 64 bytes | Fixed vertical
    dw $2111

    dw $9110, $12C0 ; VRAM $2122 | 20 bytes | Fixed vertical
    dw $0B12

    dw $9210, $1300 ; VRAM $2124 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $B310, $1100 ; VRAM $2166 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $D210, $1300 ; VRAM $21A4 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $F310, $1100 ; VRAM $21E6 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $1211, $1300 ; VRAM $2224 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $3311, $1100 ; VRAM $2266 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $5211, $1300 ; VRAM $22A4 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $7311, $1100 ; VRAM $22E6 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $9211, $1300 ; VRAM $2324 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $B311, $1100 ; VRAM $2366 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $D211, $1240 ; VRAM $23A4 | 20 bytes | Fixed horizontal
    dw $0B06

    dw $1112, $12C0 ; VRAM $2422 | 20 bytes | Fixed vertical
    dw $0B12

    dw $1212, $1300 ; VRAM $2424 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $3312, $1100 ; VRAM $2466 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $5212, $1300 ; VRAM $24A4 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $7312, $1100 ; VRAM $24E6 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $9212, $1300 ; VRAM $2524 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $B312, $1100 ; VRAM $2566 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $D212, $1300 ; VRAM $25A4 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $F312, $1100 ; VRAM $25E6 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $1213, $1300 ; VRAM $2624 | 20 bytes | Horizontal
    dw $0B06, $0B30, $0B06, $0B30, $0B06, $0B30, $0B06, $0B30
    dw $0B06, $0B30

    dw $3313, $1100 ; VRAM $2666 | 18 bytes | Horizontal
    dw $0B12, $0B00, $0B12, $0B00, $0B12, $0B00, $0B12, $0B00
    dw $0B12

    dw $5213, $1240 ; VRAM $26A4 | 20 bytes | Fixed horizontal
    dw $0B06

    db $FF ; End of stripes data.
}

; $075D31-$075D3F 0x0F
NULL_0EDD31:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $075D40-$075D60 LONG JUMP LOCATION
Overworld_Memorize_Map16_Change:
{
    ; Keeps track of map modifications for when warping between worlds.
        
    ; Shovel hole
    CMP.w #$0DC5 : BEQ .dontRemember
        ; Hole from picking up a bush / rock.
        CMP.w #$0DC9 : BEQ .dontRemember
            PHA : PHX : TXY
            
            LDX.w $04AC : STA.l $7EFA00, X
            
            TYA : STA.l $7EF800, X : INX #2 : STX.w $04AC
            
            PLX : PLA
    
    .dontRemember
    
    RTL
}

; ==============================================================================

; $075D61-$075D66
LwTurtleRockPegPositions:
{
    dw $0826
    dw $05A0
    dw $081A
}

; $075D67-$075DFB LONG JUMP LOCATION
HandlePegPuzzles:
{
    LDA.b $8A : CMP.w #$0007 : BNE .notLwTurtleRock
        LDA.l $7EF287 : AND.w #$0020 : BNE .warpAlreadyOpen
            ; Y in this routine apparently contains the map16 address of the
            ; peg tile that Link hit.
            STY.b $00
            
            LDX.w $04C8 : CPX.w #$FFFF : BEQ .puzzleFailed
                ; As you all probably realize, the 3 pegs in this area have to
                ; be hit in a specific order in order for the warp to open up.
                ; If you fail, you have to exit the screen and come back.
                ; That's what $04C8 being -1 (0xFFFF) indicates.
                LDA LwTurtleRockPegPositions, X : CMP.b $00 : BNE .puzzleFailed
                    ; Play the successful puzzle step sound effect.
                    LDA.w #$2D00 : STA.w $012E
                    
                    ; Move to the next peg.
                    INX #2 : STX.w $04C8 : CPX.w #$0006 : BNE .puzzleIncomplete
                        ; Play mystery solved sound effect.
                        LDA.w #$1B00 : STA.w $012E
                        
                        ; Set a flag so that next time we enter this screen
                        ; The puzzle will already be complete.
                        LDA.l $7EF287 : ORA.w #$0020 : STA.l $7EF287
                        
                        SEP #$20
                        
                        LDA.b #$2F : STA.b $11
                        
                        REP #$20
                    
                    .puzzleIncomplete
                    
                    LDX.b $00
                        
                    RTL
        
            .puzzleFailed
        
            LDA.w #$003C : STA.w $012E
            LDA.w #$FFFF : STA.w $04C8
            
            LDX.b $00
    
        .warpAlreadyOpen
    
        RTL
    
    .notLwTurtleRock
    
    CMP.w #$0062 : BNE .notDwSmithyHouse
        INC.w $04C8
        
        LDA.w $04C8 : CMP.w #$0016 : BNE .notEnoughPegs
            PHX
            
            SEP #$20
            
            LDA.l $7EF2E2 : ORA.b #$20 : STA.l $7EF2E2
            
            LDA.b #$1B : STA.w $012F
            
            REP #$20
            
            LDA.w #$0050 : STA.w $0692
            LDA.w #$0D20 : STA.w $0698
            
            JSL.l Overworld_DoMapUpdate32x32_Long
            
            REP #$30
            
            PLX
    
        .notEnoughPegs
    .notDwSmithyHouse
        
    RTL
}

; $075DFC-$075E28 LONG JUMP LOCATION
HandleStakeField:
{
    LDA.b $B0 : BNE .BRANCH_ALPHA
        LDA.b #$29 : STA.w $012E
            
        JML PaletteBlackAndWhiteSomething_NonConditional
    
    .BRANCH_ALPHA
    
    JSL.l PaletteFilter_BlindingWhite
        
    REP #$30
        
    LDA.l $7EC009 : CMP.w #$00FF : BNE .BRANCH_BETA
        STA.l $7EC007
        STA.l $7EC009
        
        SEP #$30
        
        INC.b $B0
        
        RTL
    
    .BRANCH_BETA
    
    JML PaletteBlackAndWhiteSomething_RestorePalette
}

; $075E29-$075E48 DATA
Pool_Overworld_CheckForSpecialOverworldTrigger:
{
    ; Corresponding warp types that lead to special overworld areas.
    ; $075E29
    .tile_type
    dw $0105, $01E4, $00AD, $00B9
        
    ; Lost woods, Hyrule Castle Bridge, Entrance to Zora falls, and in Zora
    ; Falls... (I think the last one is broken or a mistake).
    ; $075E31
    .screen_id
    dw $0000, $002D, $000F, $0081
        
    ; Direction Link will face when he enters the special area.
    ; $075E39
    .direction
    dw $0008, $0002, $0008, $0008
        
    ; Exit value for the special area. In Hyrule Magic these are those White
    ; markers.
    ; $075E41
    .special_id
    dw $0180, $0181, $0182, $0189
}

; $075E49-$075E99 LONG JUMP LOCATION
Overworld_CheckForSpecialOverworldTrigger:
{
    ; This routine specifically checks to see if Link will enter a special are
    ; (areas >= 0x80).
        
    REP #$31
        
    ; Get the map16 address of Link's coordinates.
    SR.w GetMap16Tile
        
    ; Get the CHR at that location...
    LDA.l Map16Definitions, X : AND.w #$01FF : STA.b $00
        
    LDX.w #$0008
    
    .matchFailed
    
        LDA.b $00
    
        .nextChrValue
    
            DEX #2
        
            ; We've run out of CHR types to check (there's only 4).
            BMI .return
        ; Compare map8 CHR number to see if the scroll to the next area has
        ; triggered.
        CMP.l Pool_Overworld_CheckForSpecialOverworldTrigger_tile_type, X : BNE .nextChrValue
    ; Compare the area number, because only specific locations lead to the
    ; special OW areas. The CHR value and the area number must match for a warp
    ; to occur. (this is bizarre, I know.)
    LDA.b $8A : CMP.l Pool_Overworld_CheckForSpecialOverworldTrigger_screen_id, X : BNE .matchFailed
        
    ; Loads the exit number to use (so that we can get to the proper
    ; destination).
    LDA.l Pool_Overworld_CheckForSpecialOverworldTrigger_special_id, X : STA.b $A0
        
    SEP #$20
        
    ; Sets the direction Link will face when he comes in or out of the special
    ; area.
    LDA.l Pool_Overworld_CheckForSpecialOverworldTrigger_direction, X : STA.b $67 : STA.w $0410 : STA.w $0416
        
    LDX.w #$0004
    
    ; Converts a bitwise direction indicator to a value based one.
    .convertLoop
    
        DEX
    LSR A : BCC .convertLoop
        
    STX.w $0418 : STX.w $069C
        
    LDA.b #$17 : STA.b $11
        
    ; Go to special overworld mode (under bridge and master sword).
    LDA.b #$0B : STA.b $10
    
    .return
    
    SEP #$30
        
    RTL
}

; $075E9A-$075ECD LOCAL JUMP LOCATION
GetMap16Tile:
{
    LDA.b $20 : CLC : ADC.w #$000C : STA.b $00
    SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $06
        
    LDA.b $22 : CLC : ADC.w #$0008 : LSR #3 : STA.b $02
    SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $06 : TAY : TAX
        
    LDA.l $7E2000, X : ASL #3 : TAX
        
    RTS
}

; ==============================================================================

; $075ECE-$075EDF DATA
Pool_SpecialOverworld_CheckForReturnTrigger:
{
    ; Again, CHR values that must match with a respective area number.
    ; $075ECE
    .tile_type
    dw $017C, $01E4, $00AD
        
    ; Master Sword grove, Under Hyrule bridge, Zora Falls.
    ; Note only 3 areas to warp back from whereas there were 4 areas to warp to.
    ; However I think this just confirms that the last warp to special area
    ; was something unfinished.
    ; $075ED4
    .screen_id
    dw $0080, $0080, $0081
        
    ; Direction Link faces when getting back to the normal overworld area.
    ; $075EDA
    .direction
    dw $0004, $0001, $0004
}

; $075EE0-$075EE2
Exit0EDEE0:
{
    SEP #$30
        
    RTL
}

; The reverse of $075E49, in that it detects tiles and area numbers that
; lead back to normal OW areas (from special areas).
; $075EE3-$075F2E LONG JUMP LOCATION
SpecialOverworld_CheckForReturnTrigger:
{
    REP #$31
        
    SR.w GetMap16Tile
        
    LDA.l Map16Definitions, X : AND.w #$01FF : STA.b $00
        
    LDX.w #$0006
    
    .matchFailed
    
        LDA.b $00
    
        .nextChrValue
    
            DEX #2
            
            ; Ends the routine (Link is not going back to the normal Overworld
            ; this frame.)
            BMI Exit0EDEE0
        CMP.l Pool_SpecialOverworld_CheckForReturnTrigger_tile_type, X : BNE .nextChrValue
    LDA.b $8A : CMP.l Pool_SpecialOverworld_CheckForReturnTrigger_screen_id, X : BNE .matchFailed
        
    SEP #$30
        
    LDA.l Pool_SpecialOverworld_CheckForReturnTrigger_direction, X : STA.b $67
        
    LDX.b #$04
    
    ; Converts a bitwise direction indicator to a value based one.
    .convertLoop
    
        DEX
        
        LSR A
    BCC .convertLoop
        
    TXA : STA.w $0418
        
    LDA.b $67 
        
    LDX.b #$04
    
    ; Same idea here but for Link's walking direction. This loops is actually
    ; pointless and redundant because it generates the exact same result as the
    ; previous one.
    .convertLoop2
    
        DEX
    LSR A : BCC .convertLoop2
        
    TXA : STA.w $069C
        
    LDA.b #$24 : STA.b $11
        
    STZ.b $B0
    STZ.b $A0
        
    RTL
}

; ==============================================================================

; $075F2F-$075F3F NULL
NULL_0EDF2F:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF
}
    
; ==============================================================================

; Remainder of the dialogue data.
; $075F40-$076E21
Message_DataExtra:
{
    ; ==========================================================================
    ; Thank you very much.
    ; Whenever you lose your shield,
    ; come back here again.
    ; --------------------------------------------------------------------------
    Message_0167:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; Line 2
    db $16, $21, $A5, $A7, $A1, $E3, $59, $BB ; Wh[en][ev][er ][you]⎵[lo]
    db $D0, $59, $E3, $2B, $59, $D1, $22, $1E ; [se]⎵[you]r⎵[sh]ie
    db $25, $1D, $42 ; Ld,
    db $76 ; Line 3
    db $9B, $1E, $59, $96, $9C, $59, $AF, $1E ; [com]e⎵[ba][ck]⎵[her]e
    db $59, $1A, $20, $8F, $41 ; ⎵ag[ain].
    db $7F ; End of message

    ; ==========================================================================
    ; Thank you very much.
    ; This is the Medicine of Life.
    ; It helps you recover your Life.
    ; --------------------------------------------------------------------------
    Message_0168:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; Line 2
    db $E7, $2C, $59, $B5, $59, $D8, $59, $0C ; [Thi]s⎵[is]⎵[the]⎵M
    db $1E, $9E, $1C, $B4, $1E, $59, $C6, $59 ; e[di]c[in]e⎵[of]⎵
    db $0B, $22, $1F, $1E, $41 ; Life.
    db $76 ; Line 3
    db $08, $2D, $59, $21, $1E, $25, $29, $2C ; It⎵helps
    db $59, $E3, $59, $CE, $1C, $28, $DD, $59 ; ⎵[you]⎵[re]co[ver]⎵
    db $E3, $2B, $59, $0B, $22, $1F, $1E, $41 ; [you]r⎵Life.
    db $7F ; End of message

    ; ==========================================================================
    ; Thank you very much.
    ; These are Arrows.  You can't
    ; use them without a Bow.
    ; --------------------------------------------------------------------------
    Message_0169:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; Line 2
    db $E6, $D0, $59, $8D, $00, $2B, $2B, $28 ; [The][se]⎵[are ]Arro
    db $30, $2C, $41, $8A, $E8, $59, $1C, $93 ; ws.[  ][You]⎵c[an]
    db $51, $2D ; 't
    db $76 ; Line 3
    db $2E, $D0, $59, $D8, $26, $59, $DE, $C5 ; u[se]⎵[the]m⎵[with][out ]
    db $1A, $59, $01, $28, $30, $41 ; a⎵Bow.
    db $7F ; End of message

    ; ==========================================================================
    ; These are Bombs.
    ; Did you know you can pick up
    ; a Bomb you already placed ?
    ; (Press the Ⓐ Button).
    ; --------------------------------------------------------------------------
    Message_016A:
    db $E6, $D0, $59, $8D, $01, $28, $26, $1B ; [The][se]⎵[are ]Bomb
    db $2C, $41 ; s.
    db $75 ; Line 2
    db $03, $22, $1D, $59, $E3, $59, $B8, $59 ; Did⎵[you]⎵[know]⎵
    db $E3, $59, $99, $29, $22, $9C, $59, $DC ; [you]⎵[can ]pi[ck]⎵[up]
    db $76 ; Line 3
    db $1A, $59, $01, $28, $26, $1B, $59, $E3 ; a⎵Bomb⎵[you]
    db $59, $1A, $25, $CE, $1A, $1D, $32, $59 ; ⎵al[re]ady⎵
    db $29, $BA, $1C, $A4, $3F ; p[la]c[ed ]?
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $45, $0F, $CE, $2C, $2C, $59, $D8, $59 ; (P[re]ss⎵[the]⎵
    db $5B, $59, $01, $2E, $2D, $DA, $27, $46 ; Ⓐ⎵But[to]n)
    db $41 ; .
    db $7F ; End of message

    ; ==========================================================================
    ; Thank you very much.
    ; That is a Bee.  Don't ask me
    ; what it is used for, either.
    ; --------------------------------------------------------------------------
    Message_016B:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; Line 2
    db $E5, $2D, $59, $B5, $59, $1A, $59, $01 ; [Tha]t⎵[is]⎵a⎵B
    db $1E, $1E, $41, $8A, $03, $C7, $51, $2D ; ee.[  ]D[on]'t
    db $59, $1A, $2C, $24, $59, $BE ; ⎵ask⎵[me]
    db $76 ; Line 3
    db $E1, $91, $B6, $59, $B5, $59, $2E, $D0 ; [wh][at ][it]⎵[is]⎵u[se]
    db $1D, $59, $A8, $42, $59, $1E, $B6, $AF ; d⎵[for],⎵e[it][her]
    db $41 ; .
    db $7F ; End of message

    ; ==========================================================================
    ; Thank you very much.
    ; You can recover one Heart.
    ; --------------------------------------------------------------------------
    Message_016C:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; Line 2
    db $E8, $59, $99, $CE, $1C, $28, $DD, $59 ; [You]⎵[can ][re]co[ver]⎵
    db $C7, $1E, $59, $07, $A2, $2D, $41 ; [on]e⎵H[ear]t.
    db $7F ; End of message

    ; ==========================================================================
    ; No no no…  I can't sell the
    ; merchandise because you don't
    ; have an empty bottle.
    ; --------------------------------------------------------------------------
    Message_016D:
    db $0D, $28, $59, $27, $28, $59, $27, $28 ; No⎵no⎵no
    db $43, $8A, $08, $59, $1C, $93, $51, $2D ; …[  ]I⎵c[an]'t
    db $59, $D0, $25, $25, $59, $D8 ; ⎵[se]ll⎵[the]
    db $75 ; Line 2
    db $BE, $2B, $1C, $B1, $27, $9E, $D0, $59 ; [me]rc[ha]n[di][se]⎵
    db $97, $1C, $1A, $2E, $D0, $59, $E3, $59 ; [be]cau[se]⎵[you]⎵
    db $9F, $27, $51, $2D ; [do]n't
    db $76 ; Line 3
    db $AD, $59, $93, $59, $1E, $26, $29, $2D ; [have]⎵[an]⎵empt
    db $32, $59, $98, $2D, $2D, $25, $1E, $41 ; y⎵[bo]ttle.
    db $7F ; End of message

    ; ==========================================================================
    ; You can't carry any more
    ; now, but you may need
    ; some later!
    ; --------------------------------------------------------------------------
    Message_016E:
    db $E8, $59, $1C, $93, $51, $2D, $59, $1C ; [You]⎵c[an]'t⎵c
    db $1A, $2B, $2B, $32, $59, $93, $32, $59 ; arry⎵[an]y⎵
    db $26, $C8, $1E ; m[or]e
    db $75 ; Line 2
    db $27, $28, $30, $42, $59, $1B, $2E, $2D ; now,⎵but
    db $59, $E3, $59, $BD, $32, $59, $27, $1E ; ⎵[you]⎵[ma]y⎵ne
    db $1E, $1D ; ed
    db $76 ; Line 3
    db $CF, $59, $BA, $D6, $3E ; [some]⎵[la][ter]!
    db $7F ; End of message

    ; ==========================================================================
    ; I never imagined a boy like you
    ; could give me so much trouble.
    ; It's unbelievable that you
    ; defeated my alterego, Agahnim
    ; the Dark Wizard, twice!
    ; But I will never give you the
    ; Triforce.  I will destroy you
    ; and make my wish to conquer
    ; both Light and Dark Worlds
    ; come true without delay.
    ; --------------------------------------------------------------------------
    Message_016F:
    db $08, $59, $27, $A7, $A1, $22, $BD, $20 ; I⎵n[ev][er ]i[ma]g
    db $B4, $A4, $1A, $59, $98, $32, $59, $25 ; [in][ed ]a⎵[bo]y⎵l
    db $22, $24, $1E, $59, $E3 ; ike⎵[you]
    db $75 ; Line 2
    db $1C, $28, $2E, $25, $1D, $59, $AA, $BE ; could⎵[give ][me]
    db $59, $D2, $59, $BF, $1C, $21, $59, $DB ; ⎵[so]⎵[mu]ch⎵[tr]
    db $28, $2E, $95, $41 ; ou[ble].
    db $76 ; Line 3
    db $08, $2D, $8B, $2E, $27, $97, $25, $22 ; It['s ]un[be]li
    db $A7, $1A, $95, $59, $D7, $2D, $59, $E3 ; [ev]a[ble]⎵[tha]t⎵[you]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $1D, $1E, $1F, $1E, $94, $A4, $26, $32 ; defe[at][ed ]my
    db $59, $1A, $25, $D6, $1E, $AC, $42, $59 ; ⎵al[ter]e[go],⎵
    db $00, $20, $1A, $21, $27, $22, $26 ; Agahnim
    db $73 ; Scroll text
    db $D8, $59, $03, $1A, $2B, $24, $59, $16 ; [the]⎵Dark⎵W
    db $22, $33, $1A, $2B, $1D, $42, $59, $2D ; izard,⎵t
    db $E2, $1C, $1E, $3E ; [wi]ce!
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $01, $2E, $2D, $59, $08, $59, $E2, $25 ; But⎵I⎵[wi]l
    db $25, $59, $27, $A7, $A1, $AA, $E3, $59 ; l⎵n[ev][er ][give ][you]⎵
    db $D8 ; [the]
    db $73 ; Scroll text
    db $13, $2B, $22, $A8, $1C, $1E, $41, $8A ; Tri[for]ce.[  ]
    db $08, $59, $E2, $25, $25, $59, $9D, $DB ; I⎵[wi]ll⎵[des][tr]
    db $28, $32, $59, $E3 ; oy⎵[you]
    db $73 ; Scroll text
    db $8C, $BD, $24, $1E, $59, $26, $32, $59 ; [and ][ma]ke⎵my⎵
    db $E2, $D1, $59, $DA, $59, $1C, $C7, $2A ; [wi][sh]⎵[to]⎵c[on]q
    db $2E, $A6 ; u[er]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $98, $2D, $21, $59, $0B, $B2, $8C, $03 ; [bo]th⎵L[ight ][and ]D
    db $1A, $2B, $24, $59, $16, $C8, $25, $1D ; ark⎵W[or]ld
    db $2C ; s
    db $73 ; Scroll text
    db $9B, $1E, $59, $DB, $2E, $1E, $59, $DE ; [com]e⎵[tr]ue⎵[with]
    db $C5, $1D, $1E, $BA, $32, $41 ; [out ]de[la]y.
    db $7F ; End of message

    ; ==========================================================================
    ; You are doing well, lad.  But
    ; can you break through this
    ; secret technique of Darkness?
    ; En Garde!
    ; --------------------------------------------------------------------------
    Message_0170:
    db $E8, $59, $8D, $9F, $B3, $E0, $25, $25 ; [You]⎵[are ][do][ing ][we]ll
    db $42, $59, $BA, $1D, $41, $8A, $01, $2E ; ,⎵[la]d.[  ]Bu
    db $2D ; t
    db $75 ; Line 2
    db $99, $E3, $59, $1B, $CE, $1A, $24, $59 ; [can ][you]⎵b[re]ak⎵
    db $2D, $21, $2B, $28, $2E, $20, $21, $59 ; through⎵
    db $D9, $2C ; [thi]s
    db $76 ; Line 3
    db $D0, $1C, $CE, $2D, $59, $2D, $1E, $1C ; [se]c[re]t⎵tec
    db $21, $27, $22, $2A, $2E, $1E, $59, $C6 ; hnique⎵[of]
    db $59, $03, $1A, $2B, $24, $27, $1E, $2C ; ⎵Darknes
    db $2C, $3F ; s?
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $04, $27, $59, $06, $1A, $2B, $1D, $1E ; En⎵Garde
    db $3E ; !
    db $7F ; End of message

    ; ==========================================================================
    ; Hey kid, this is a secret hide-
    ; out for a gang of thieves!
    ; Don't enter without permission!
    ; By the way, I heard that one
    ; of our ex-members is staying
    ; at the entrance to the Desert.
    ; --------------------------------------------------------------------------
    Message_0171:
    db $07, $1E, $32, $59, $24, $22, $1D, $42 ; Hey⎵kid,
    db $59, $D9, $2C, $59, $B5, $59, $1A, $59 ; ⎵[thi]s⎵[is]⎵a⎵
    db $D0, $1C, $CE, $2D, $59, $B0, $1D, $1E ; [se]c[re]t⎵[hi]de
    db $40 ; -
    db $75 ; Line 2
    db $C5, $A8, $59, $1A, $59, $20, $93, $20 ; [out ][for]⎵a⎵g[an]g
    db $59, $C6, $59, $D9, $A7, $1E, $2C, $3E ; ⎵[of]⎵[thi][ev]es!
    db $76 ; Line 3
    db $03, $C7, $51, $2D, $59, $A3, $A1, $DE ; D[on]'t⎵[ent][er ][with]
    db $C5, $C9, $26, $B5, $2C, $22, $C7, $3E ; [out ][per]m[is]si[on]!
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $01, $32, $59, $D8, $59, $DF, $32, $42 ; By⎵[the]⎵[wa]y,
    db $59, $08, $59, $21, $A2, $1D, $59, $D7 ; ⎵I⎵h[ear]d⎵[tha]
    db $2D, $59, $C7, $1E ; t⎵[on]e
    db $73 ; Scroll text
    db $C6, $59, $28, $2E, $2B, $59, $1E, $31 ; [of]⎵our⎵ex
    db $40, $BE, $26, $97, $2B, $2C, $59, $B5 ; -[me]m[be]rs⎵[is]
    db $59, $D3, $1A, $32, $B4, $20 ; ⎵[st]ay[in]g
    db $73 ; Scroll text
    db $91, $D8, $59, $A3, $2B, $93, $1C, $1E ; [at ][the]⎵[ent]r[an]ce
    db $59, $DA, $59, $D8, $59, $03, $1E, $D0 ; ⎵[to]⎵[the]⎵De[se]
    db $2B, $2D, $41 ; rt.
    db $7F ; End of message

    ; ==========================================================================
    ; Yo [LINK]!  This house used
    ; to be a hideout for a gang of
    ; thieves.
    ; What was their leader's name…
    ; Oh yeah, his name was Blind and
    ; he hated bright light a lot.
    ; --------------------------------------------------------------------------
    Message_0172:
    db $18, $28, $59, $6A, $3E, $8A, $E7, $2C ; Yo⎵[LINK]![  ][Thi]s
    db $59, $21, $28, $2E, $D0, $59, $2E, $D0 ; ⎵hou[se]⎵u[se]
    db $1D ; d
    db $75 ; Line 2
    db $DA, $59, $97, $59, $1A, $59, $B0, $1D ; [to]⎵[be]⎵a⎵[hi]d
    db $1E, $C5, $A8, $59, $1A, $59, $20, $93 ; e[out ][for]⎵a⎵g[an]
    db $20, $59, $C6 ; g⎵[of]
    db $76 ; Line 3
    db $D9, $A7, $1E, $2C, $41 ; [thi][ev]es.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $16, $B1, $2D, $59, $DF, $2C, $59, $D8 ; W[ha]t⎵[wa]s⎵[the]
    db $22, $2B, $59, $25, $1E, $1A, $1D, $A6 ; ir⎵lead[er]
    db $8B, $27, $1A, $BE, $43 ; ['s ]na[me]…
    db $73 ; Scroll text
    db $0E, $21, $59, $32, $1E, $1A, $21, $42 ; Oh⎵yeah,
    db $59, $B0, $2C, $59, $27, $1A, $BE, $59 ; ⎵[hi]s⎵na[me]⎵
    db $DF, $2C, $59, $01, $25, $B4, $1D, $59 ; [wa]s⎵Bl[in]d⎵
    db $90 ; [and]
    db $73 ; Scroll text
    db $21, $1E, $59, $B1, $2D, $A4, $1B, $2B ; he⎵[ha]t[ed ]br
    db $B2, $25, $B2, $1A, $59, $BB, $2D, $41 ; [ight ]l[ight ]a⎵[lo]t.
    db $7F ; End of message

    ; ==========================================================================
    ; Welcome, [LINK]…
    ; I   am   the   Essence   Of   The
    ; Triforce.
    ; …   …   …
    ;                                           
    ;                                           
    ;                                           
    ; The Triforce will grant the
    ; wishes in the heart and mind of
    ; the person who touches it.
    ;                                           
    ;                                           
    ;                                           
    ; If a person with a good heart
    ; touches it, it will make his good
    ; wishes come true…  If an evil-
    ; hearted person touches it, it
    ; grants his evil wishes.
    ;                                           
    ;                                           
    ;                                           
    ; The stronger the wish, the
    ; more powerful the Triforce's
    ; expression of that wish.
    ;                                           
    ;                                           
    ;                                           
    ; Ganon's wish was to conquer
    ; the world.  That wish changed
    ; the Golden Land to the Dark
    ; World.
    ;                                           
    ;                                           
    ;                                           
    ; Ganon was building up his
    ; power here so he could conquer
    ; the Light World and make his
    ; wish come completely true.
    ;                                           
    ;                                           
    ;                                           
    ; But now, you have totally
    ; destroyed Ganon.  His Dark
    ; World will vanish.
    ;                                           
    ;                                           
    ;                                           
    ; The Triforce is waiting for a
    ; new owner.  Its Golden Power is
    ; in your hands…
    ;                                           
    ;                                           
    ;                                           
    ; Now, touch it with a wish in
    ; your heart.
    ; …  …  …  …
    ; --------------------------------------------------------------------------
    Message_0173:
    db $7A, $02 ; Set draw speed
    db $6D, $00 ; Set window position
    db $6B, $02 ; Set window border
    db $16, $1E, $25, $9B, $1E, $42, $59, $6A ; Wel[com]e,⎵[LINK]
    db $43 ; …
    db $75 ; Line 2
    db $08, $89, $1A, $26, $89, $D8, $89, $04 ; I[   ]am[   ][the][   ]E
    db $2C, $D0, $27, $1C, $1E, $89, $0E, $1F ; s[se]nce[   ]Of
    db $89, $E6 ; [   ][The]
    db $76 ; Line 3
    db $13, $2B, $22, $A8, $1C, $1E, $41 ; Tri[for]ce.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $43, $89, $43, $89, $43 ; …[   ]…[   ]…
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $E6, $59, $13, $2B, $22, $A8, $1C, $1E ; [The]⎵Tri[for]ce
    db $59, $E2, $25, $25, $59, $20, $2B, $93 ; ⎵[wi]ll⎵gr[an]
    db $2D, $59, $D8 ; t⎵[the]
    db $75 ; Line 2
    db $E2, $D1, $1E, $2C, $59, $B4, $59, $D8 ; [wi][sh]es⎵[in]⎵[the]
    db $59, $21, $A2, $2D, $59, $8C, $26, $B4 ; ⎵h[ear]t⎵[and ]m[in]
    db $1D, $59, $C6 ; d⎵[of]
    db $76 ; Line 3
    db $D8, $59, $C9, $D2, $27, $59, $E1, $28 ; [the]⎵[per][so]n⎵[wh]o
    db $59, $DA, $2E, $9A, $2C, $59, $B6, $41 ; ⎵[to]u[che]s⎵[it].
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $08, $1F, $59, $1A, $59, $C9, $D2, $27 ; If⎵a⎵[per][so]n
    db $59, $DE, $59, $1A, $59, $AC, $28, $1D ; ⎵[with]⎵a⎵[go]od
    db $59, $21, $A2, $2D ; ⎵h[ear]t
    db $75 ; Line 2
    db $DA, $2E, $9A, $2C, $59, $B6, $42, $59 ; [to]u[che]s⎵[it],⎵
    db $B6, $59, $E2, $25, $25, $59, $BD, $24 ; [it]⎵[wi]ll⎵[ma]k
    db $1E, $59, $B0, $2C, $59, $AC, $28, $1D ; e⎵[hi]s⎵[go]od
    db $76 ; Line 3
    db $E2, $D1, $1E, $2C, $59, $9B, $1E, $59 ; [wi][sh]es⎵[com]e⎵
    db $DB, $2E, $1E, $43, $8A, $08, $1F, $59 ; [tr]ue…[  ]If⎵
    db $93, $59, $A7, $22, $25, $40 ; [an]⎵[ev]il-
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $21, $A2, $2D, $A4, $C9, $D2, $27, $59 ; h[ear]t[ed ][per][so]n⎵
    db $DA, $2E, $9A, $2C, $59, $B6, $42, $59 ; [to]u[che]s⎵[it],⎵
    db $B6 ; [it]
    db $73 ; Scroll text
    db $20, $2B, $93, $2D, $2C, $59, $B0, $2C ; gr[an]ts⎵[hi]s
    db $59, $A7, $22, $25, $59, $E2, $D1, $1E ; ⎵[ev]il⎵[wi][sh]e
    db $2C, $41 ; s.
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $E6, $59, $D3, $2B, $C7, $20, $A1, $D8 ; [The]⎵[st]r[on]g[er ][the]
    db $59, $E2, $D1, $42, $59, $D8 ; ⎵[wi][sh],⎵[the]
    db $75 ; Line 2
    db $26, $C8, $1E, $59, $CB, $A6, $1F, $2E ; m[or]e⎵[pow][er]fu
    db $25, $59, $D8, $59, $13, $2B, $22, $A8 ; l⎵[the]⎵Tri[for]
    db $1C, $1E, $51, $2C ; ce's
    db $76 ; Line 3
    db $1E, $31, $29, $CE, $2C, $2C, $22, $C7 ; exp[re]ssi[on]
    db $59, $C6, $59, $D7, $2D, $59, $E2, $D1 ; ⎵[of]⎵[tha]t⎵[wi][sh]
    db $41 ; .
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $06, $93, $C7, $8B, $E2, $D1, $59, $DF ; G[an][on]['s ][wi][sh]⎵[wa]
    db $2C, $59, $DA, $59, $1C, $C7, $2A, $2E ; s⎵[to]⎵c[on]qu
    db $A6 ; [er]
    db $75 ; Line 2
    db $D8, $59, $30, $C8, $25, $1D, $41, $8A ; [the]⎵w[or]ld.[  ]
    db $E5, $2D, $59, $E2, $D1, $59, $1C, $B1 ; [Tha]t⎵[wi][sh]⎵c[ha]
    db $27, $20, $1E, $1D ; nged
    db $76 ; Line 3
    db $D8, $59, $06, $28, $25, $1D, $A0, $0B ; [the]⎵Gold[en ]L
    db $8C, $DA, $59, $D8, $59, $03, $1A, $2B ; [and ][to]⎵[the]⎵Dar
    db $24 ; k
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $16, $C8, $25, $1D, $41 ; W[or]ld.
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $06, $93, $C7, $59, $DF, $2C, $59, $1B ; G[an][on]⎵[wa]s⎵b
    db $2E, $22, $25, $9E, $27, $20, $59, $DC ; uil[di]ng⎵[up]
    db $59, $B0, $2C ; ⎵[hi]s
    db $75 ; Line 2
    db $CB, $A1, $AF, $1E, $59, $D2, $59, $21 ; [pow][er ][her]e⎵[so]⎵h
    db $1E, $59, $1C, $28, $2E, $25, $1D, $59 ; e⎵could⎵
    db $1C, $C7, $2A, $2E, $A6 ; c[on]qu[er]
    db $76 ; Line 3
    db $D8, $59, $0B, $B2, $16, $C8, $25, $1D ; [the]⎵L[ight ]W[or]ld
    db $59, $8C, $BD, $24, $1E, $59, $B0, $2C ; ⎵[and ][ma]ke⎵[hi]s
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $E2, $D1, $59, $9B, $1E, $59, $9B, $CA ; [wi][sh]⎵[com]e⎵[com][ple]
    db $2D, $1E, $B9, $DB, $2E, $1E, $41 ; te[ly ][tr]ue.
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $01, $2E, $2D, $59, $27, $28, $30, $42 ; But⎵now,
    db $59, $E3, $59, $AD, $59, $DA, $2D, $1A ; ⎵[you]⎵[have]⎵[to]ta
    db $25, $25, $32 ; lly
    db $75 ; Line 2
    db $9D, $DB, $28, $32, $A4, $06, $93, $C7 ; [des][tr]oy[ed ]G[an][on]
    db $41, $8A, $07, $B5, $59, $03, $1A, $2B ; .[  ]H[is]⎵Dar
    db $24 ; k
    db $76 ; Line 3
    db $16, $C8, $25, $1D, $59, $E2, $25, $25 ; W[or]ld⎵[wi]ll
    db $59, $2F, $93, $B5, $21, $41 ; ⎵v[an][is]h.
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $E6, $59, $13, $2B, $22, $A8, $1C, $1E ; [The]⎵Tri[for]ce
    db $59, $B5, $59, $DF, $B6, $B3, $A8, $59 ; ⎵[is]⎵[wa][it][ing ][for]⎵
    db $1A ; a
    db $75 ; Line 2
    db $27, $1E, $30, $59, $28, $30, $27, $A6 ; new⎵own[er]
    db $41, $8A, $08, $2D, $2C, $59, $06, $28 ; .[  ]Its⎵Go
    db $25, $1D, $A0, $0F, $28, $E0, $2B, $59 ; ld[en ]Po[we]r⎵
    db $B5 ; [is]
    db $76 ; Line 3
    db $B4, $59, $E3, $2B, $59, $B1, $27, $1D ; [in]⎵[you]r⎵[ha]nd
    db $2C, $43 ; s…
    db $7A, $01 ; Set draw speed
    db $7E ; Wait for key
    db $74 ; Line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; Line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; Line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; Set draw speed
    db $74 ; Line 1
    db $0D, $28, $30, $42, $59, $DA, $2E, $1C ; Now,⎵[to]uc
    db $21, $59, $B6, $59, $DE, $59, $1A, $59 ; h⎵[it]⎵[with]⎵a⎵
    db $E2, $D1, $59, $B4 ; [wi][sh]⎵[in]
    db $75 ; Line 2
    db $E3, $2B, $59, $21, $A2, $2D, $41 ; [you]r⎵h[ear]t.
    db $76 ; Line 3
    db $43, $8A, $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…[  ]…
    db $7F ; End of message

    ; ==========================================================================
    ; All right! Take it, thief!
    ; --------------------------------------------------------------------------
    Message_0174:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $3E, $59, $13, $1A, $24, $1E, $59 ; t!⎵Take⎵
    db $B6, $42, $59, $D9, $1E, $1F, $3E ; [it],⎵[thi]ef!
    db $7F ; End of message

    ; ==========================================================================
    ; Whoa…  I saw her.
    ; A very nice young lady at the
    ; Waterfall Of Wishing in the
    ; hills where the river
    ; begins…
    ; [LINK], you should meet her
    ; at least once.  I'm sure you will
    ; like her.
    ; --------------------------------------------------------------------------
    Message_0175:
    db $16, $21, $28, $1A, $43, $8A, $08, $59 ; Whoa…[  ]I⎵
    db $2C, $1A, $30, $59, $AF, $41 ; saw⎵[her].
    db $75 ; Line 2
    db $00, $59, $DD, $32, $59, $27, $22, $1C ; A⎵[ver]y⎵nic
    db $1E, $59, $E3, $27, $20, $59, $BA, $1D ; e⎵[you]ng⎵[la]d
    db $32, $59, $91, $D8 ; y⎵[at ][the]
    db $76 ; Line 3
    db $16, $94, $A6, $1F, $8E, $0E, $1F, $59 ; W[at][er]f[all ]Of⎵
    db $16, $B5, $B0, $27, $20, $59, $B4, $59 ; W[is][hi]ng⎵[in]⎵
    db $D8 ; [the]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $B0, $25, $25, $2C, $59, $E1, $A6, $1E ; [hi]lls⎵[wh][er]e
    db $59, $D8, $59, $2B, $22, $DD ; ⎵[the]⎵ri[ver]
    db $73 ; Scroll text
    db $97, $20, $B4, $2C, $43 ; [be]g[in]s…
    db $73 ; Scroll text
    db $6A, $42, $59, $E3, $59, $D1, $28, $2E ; [LINK],⎵[you]⎵[sh]ou
    db $25, $1D, $59, $BE, $1E, $2D, $59, $AF ; ld⎵[me]et⎵[her]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $91, $25, $1E, $92, $59, $C7, $1C, $1E ; [at ]le[ast]⎵[on]ce
    db $41, $8A, $08, $51, $26, $59, $2C, $2E ; .[  ]I'm⎵su
    db $CD, $E3, $59, $E2, $25, $25 ; [re ][you]⎵[wi]ll
    db $73 ; Scroll text
    db $25, $22, $24, $1E, $59, $AF, $41 ; like⎵[her].
    db $7F ; End of message

    ; ==========================================================================
    ; Take some Rupees, but don't
    ; tell anyone I gave them to you.
    ; Keep it between us, OK?
    ; --------------------------------------------------------------------------
    Message_0176:
    db $13, $1A, $24, $1E, $59, $CF, $59, $11 ; Take⎵[some]⎵R
    db $DC, $1E, $1E, $2C, $42, $59, $1B, $2E ; [up]ees,⎵bu
    db $2D, $59, $9F, $27, $51, $2D ; t⎵[do]n't
    db $75 ; Line 2
    db $2D, $1E, $25, $25, $59, $93, $32, $C7 ; tell⎵[an]y[on]
    db $1E, $59, $08, $59, $20, $1A, $2F, $1E ; e⎵I⎵gave
    db $59, $D8, $26, $59, $DA, $59, $E3, $41 ; ⎵[the]m⎵[to]⎵[you].
    db $76 ; Line 3
    db $0A, $1E, $1E, $29, $59, $B6, $59, $97 ; Keep⎵[it]⎵[be]
    db $2D, $E0, $A0, $2E, $2C, $42, $59, $0E ; t[we][en ]us,⎵O
    db $0A, $3F ; K?
    db $7F ; End of message

    ; ==========================================================================
    ; Check out the cave east of
    ; Lake Hylia.  Strange and
    ; wonderful things live in it…
    ; --------------------------------------------------------------------------
    Message_0177:
    db $02, $21, $1E, $9C, $59, $C5, $D8, $59 ; Che[ck]⎵[out ][the]⎵
    db $1C, $1A, $2F, $1E, $59, $1E, $92, $59 ; cave⎵e[ast]⎵
    db $C6 ; [of]
    db $75 ; Line 2
    db $0B, $1A, $24, $1E, $59, $07, $32, $25 ; Lake⎵Hyl
    db $22, $1A, $41, $8A, $12, $DB, $93, $20 ; ia.[  ]S[tr][an]g
    db $1E, $59, $90 ; e⎵[and]
    db $76 ; Line 3
    db $30, $C7, $1D, $A6, $1F, $2E, $25, $59 ; w[on]d[er]ful⎵
    db $D5, $20, $2C, $59, $25, $22, $2F, $1E ; [thin]gs⎵live
    db $59, $B4, $59, $B6, $43 ; ⎵[in]⎵[it]…
    db $7F ; End of message

    ; ==========================================================================
    ; You can earn a lot of Rupees
    ; by defeating enemies.  It's
    ; the secret of my success…
    ; --------------------------------------------------------------------------
    Message_0178:
    db $E8, $59, $99, $A2, $27, $59, $1A, $59 ; [You]⎵[can ][ear]n⎵a⎵
    db $BB, $2D, $59, $C6, $59, $11, $DC, $1E ; [lo]t⎵[of]⎵R[up]e
    db $1E, $2C ; es
    db $75 ; Line 2
    db $1B, $32, $59, $1D, $1E, $1F, $1E, $94 ; by⎵defe[at]
    db $B3, $A5, $1E, $26, $22, $1E, $2C, $41 ; [ing ][en]emies.
    db $8A, $08, $2D, $51, $2C ; [  ]It's
    db $76 ; Line 3
    db $D8, $59, $D0, $1C, $CE, $2D, $59, $C6 ; [the]⎵[se]c[re]t⎵[of]
    db $59, $26, $32, $59, $2C, $2E, $1C, $1C ; ⎵my⎵succ
    db $1E, $2C, $2C, $43 ; ess…
    db $7F ; End of message

    ; ==========================================================================
    ; [LINK], did you know that if
    ; you destroy frozen enemies
    ; with the Hammer, you will often
    ; get a Magic Decanter?
    ; --------------------------------------------------------------------------
    Message_0179:
    db $6A, $42, $59, $9E, $1D, $59, $E3, $59 ; [LINK],⎵[di]d⎵[you]⎵
    db $B8, $59, $D7, $2D, $59, $22, $1F ; [know]⎵[tha]t⎵if
    db $75 ; Line 2
    db $E3, $59, $9D, $DB, $28, $32, $59, $A9 ; [you]⎵[des][tr]oy⎵[fro]
    db $33, $A0, $A5, $1E, $26, $22, $1E, $2C ; z[en ][en]emies
    db $76 ; Line 3
    db $DE, $59, $D8, $59, $07, $1A, $26, $BE ; [with]⎵[the]⎵Ham[me]
    db $2B, $42, $59, $E3, $59, $E2, $25, $25 ; r,⎵[you]⎵[wi]ll
    db $59, $C6, $2D, $A5 ; ⎵[of]t[en]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $AB, $59, $1A, $59, $0C, $1A, $20, $22 ; [get]⎵a⎵Magi
    db $1C, $59, $03, $1E, $1C, $93, $D6, $3F ; c⎵Dec[an][ter]?
    db $7F ; End of message

    ; ==========================================================================
    ; Tra la la, look for
    ; Sahasrahla.
    ; …  …  …
    ; --------------------------------------------------------------------------
    Message_017A:
    db $13, $2B, $1A, $59, $BA, $59, $BA, $42 ; Tra⎵[la]⎵[la],
    db $59, $BB, $28, $24, $59, $A8 ; ⎵[lo]ok⎵[for]
    db $75 ; Line 2
    db $12, $1A, $AE, $2B, $1A, $21, $BA, $41 ; Sa[has]rah[la].
    db $76 ; Line 3
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7F ; End of message

    ; ==========================================================================
    ; Oh yah, you found Sahasrahla!
    ; …  …  …
    ; Good job la la!
    ; --------------------------------------------------------------------------
    Message_017B:
    db $0E, $21, $59, $32, $1A, $21, $42, $59 ; Oh⎵yah,⎵
    db $E3, $59, $1F, $C4, $59, $12, $1A, $AE ; [you]⎵f[ound]⎵Sa[has]
    db $2B, $1A, $21, $BA, $3E ; rah[la]!
    db $75 ; Line 2
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $76 ; Line 3
    db $06, $28, $28, $1D, $59, $23, $28, $1B ; Good⎵job
    db $59, $BA, $59, $BA, $3E ; ⎵[la]⎵[la]!
    db $7F ; End of message

    ; ==========================================================================
    ; I'm sorry, but you don't
    ; seem to have enough Rupees…
    ; --------------------------------------------------------------------------
    Message_017C:
    db $08, $51, $26, $59, $D2, $2B, $2B, $32 ; I'm⎵[so]rry
    db $42, $59, $1B, $2E, $2D, $59, $E3, $59 ; ,⎵but⎵[you]⎵
    db $9F, $27, $51, $2D ; [do]n't
    db $75 ; Line 2
    db $D0, $1E, $26, $59, $DA, $59, $AD, $59 ; [se]em⎵[to]⎵[have]⎵
    db $A5, $28, $2E, $20, $21, $59, $11, $DC ; [en]ough⎵R[up]
    db $1E, $1E, $2C, $43 ; ees…
    db $7F ; End of message

    ; ==========================================================================
    ; Cluck cluck…  What?!
    ; You turned me into a human.
    ; I can even speak!
    ; Aha, it must be you who is
    ; always teasing my friends.
    ; The Weathercock is always
    ; watching you harass them.
    ; Well, this human shape is
    ; uncomfortable for me.
    ; Ahhh, I want to be a chicken
    ; again!  Cluck cluck…
    ; --------------------------------------------------------------------------
    Message_017D:
    db $02, $25, $2E, $9C, $59, $1C, $25, $2E ; Clu[ck]⎵clu
    db $9C, $43, $8A, $16, $B1, $2D, $3F, $3E ; [ck]…[  ]W[ha]t?!
    db $75 ; Line 2
    db $E8, $59, $2D, $2E, $2B, $27, $A4, $BE ; [You]⎵turn[ed ][me]
    db $59, $B4, $DA, $59, $1A, $59, $21, $2E ; ⎵[in][to]⎵a⎵hu
    db $BC, $41 ; [man].
    db $76 ; Line 3
    db $08, $59, $99, $A7, $A0, $2C, $29, $1E ; I⎵[can ][ev][en ]spe
    db $1A, $24, $3E ; ak!
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $00, $B1, $42, $59, $B6, $59, $BF, $D3 ; A[ha],⎵[it]⎵[mu][st]
    db $59, $97, $59, $E3, $59, $E1, $28, $59 ; ⎵[be]⎵[you]⎵[wh]o⎵
    db $B5 ; [is]
    db $73 ; Scroll text
    db $1A, $25, $DF, $32, $2C, $59, $2D, $1E ; al[wa]ys⎵te
    db $1A, $2C, $B3, $26, $32, $59, $1F, $2B ; as[ing ]my⎵fr
    db $22, $A5, $1D, $2C, $41 ; i[en]ds.
    db $73 ; Scroll text
    db $E6, $59, $16, $1E, $94, $AF, $1C, $28 ; [The]⎵We[at][her]co
    db $9C, $59, $B5, $59, $1A, $25, $DF, $32 ; [ck]⎵[is]⎵al[wa]y
    db $2C ; s
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $DF, $2D, $1C, $B0, $27, $20, $59, $E3 ; [wa]tc[hi]ng⎵[you]
    db $59, $B1, $2B, $1A, $2C, $2C, $59, $D8 ; ⎵[ha]rass⎵[the]
    db $26, $41 ; m.
    db $73 ; Scroll text
    db $16, $1E, $25, $25, $42, $59, $D9, $2C ; Well,⎵[thi]s
    db $59, $21, $2E, $BC, $59, $D1, $1A, $29 ; ⎵hu[man]⎵[sh]ap
    db $1E, $59, $B5 ; e⎵[is]
    db $73 ; Scroll text
    db $2E, $27, $9B, $A8, $2D, $1A, $95, $59 ; un[com][for]ta[ble]⎵
    db $A8, $59, $BE, $41 ; [for]⎵[me].
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $00, $21, $21, $21, $42, $59, $08, $59 ; Ahhh,⎵I⎵
    db $DF, $27, $2D, $59, $DA, $59, $97, $59 ; [wa]nt⎵[to]⎵[be]⎵
    db $1A, $59, $1C, $B0, $9C, $A5 ; a⎵c[hi][ck][en]
    db $73 ; Scroll text
    db $1A, $20, $8F, $3E, $8A, $02, $25, $2E ; ag[ain]![  ]Clu
    db $9C, $59, $1C, $25, $2E, $9C, $43 ; [ck]⎵clu[ck]…
    db $7F ; End of message

    ; ==========================================================================
    ; Pay me 20 Rupees and I'll let
    ; you open one chest.  You can
    ; keep what is inside.
    ; What will you do?
    ;     >  Open A Chest
    ;         Escape
    ; --------------------------------------------------------------------------
    Message_017E:
    db $0F, $1A, $32, $59, $BE, $59, $36, $34 ; Pay⎵[me]⎵20
    db $59, $11, $DC, $1E, $1E, $2C, $59, $8C ; ⎵R[up]ees⎵[and ]
    db $08, $51, $25, $25, $59, $25, $1E, $2D ; I'll⎵let
    db $75 ; Line 2
    db $E3, $59, $C3, $59, $C7, $1E, $59, $9A ; [you]⎵[open]⎵[on]e⎵[che]
    db $D3, $41, $8A, $E8, $59, $1C, $93 ; [st].[  ][You]⎵c[an]
    db $76 ; Line 3
    db $24, $1E, $1E, $29, $59, $E1, $91, $B5 ; keep⎵[wh][at ][is]
    db $59, $B4, $2C, $22, $1D, $1E, $41 ; ⎵[in]side.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $73 ; Scroll text
    db $88, $44, $8A, $0E, $29, $A0, $00, $59 ; [    ]>[  ]Op[en ]A⎵
    db $02, $21, $1E, $D3 ; Che[st]
    db $73 ; Scroll text
    db $88, $88, $04, $2C, $1C, $1A, $29, $1E ; [    ][    ]Escape
    db $68 ; Choose 2 indented
    db $7F ; End of message

    ; ==========================================================================
    ; All right!  Open the chest you
    ; like!
    ; --------------------------------------------------------------------------
    Message_017F:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $3E, $8A, $0E, $29, $A0, $D8, $59 ; t![  ]Op[en ][the]⎵
    db $9A, $D3, $59, $E3 ; [che][st]⎵[you]
    db $75 ; Line 2
    db $25, $22, $24, $1E, $3E ; like!
    db $7F ; End of message

    ; ==========================================================================
    ; Oh, I see…  Too bad.
    ; Drop by again after collecting
    ; Rupees.
    ; --------------------------------------------------------------------------
    Message_0180:
    db $0E, $21, $42, $59, $08, $59, $D0, $1E ; Oh,⎵I⎵[se]e
    db $43, $8A, $13, $28, $28, $59, $96, $1D ; …[  ]Too⎵[ba]d
    db $41 ; .
    db $75 ; Line 2
    db $03, $2B, $28, $29, $59, $1B, $32, $59 ; Drop⎵by⎵
    db $1A, $20, $8F, $59, $1A, $1F, $D4, $1C ; ag[ain]⎵af[ter ]c
    db $28, $25, $25, $1E, $1C, $2D, $B4, $20 ; ollect[in]g
    db $76 ; Line 3
    db $11, $DC, $1E, $1E, $2C, $41 ; R[up]ees.
    db $7F ; End of message

    ; ==========================================================================
    ; For 100 Rupees, I'll let you
    ; open one chest and keep the
    ; treasure that is inside.
    ; What will you do?
    ;     >  Open A Chest
    ;         Escape
    ; --------------------------------------------------------------------------
    Message_0181:
    db $05, $C8, $59, $35, $34, $34, $59, $11 ; F[or]⎵100⎵R
    db $DC, $1E, $1E, $2C, $42, $59, $08, $51 ; [up]ees,⎵I'
    db $25, $25, $59, $25, $1E, $2D, $59, $E3 ; ll⎵let⎵[you]
    db $75 ; Line 2
    db $C3, $59, $C7, $1E, $59, $9A, $D3, $59 ; [open]⎵[on]e⎵[che][st]⎵
    db $8C, $24, $1E, $1E, $29, $59, $D8 ; [and ]keep⎵[the]
    db $76 ; Line 3
    db $DB, $1E, $1A, $2C, $2E, $CD, $D7, $2D ; [tr]easu[re ][tha]t
    db $59, $B5, $59, $B4, $2C, $22, $1D, $1E ; ⎵[is]⎵[in]side
    db $41 ; .
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $73 ; Scroll text
    db $88, $44, $8A, $0E, $29, $A0, $00, $59 ; [    ]>[  ]Op[en ]A⎵
    db $02, $21, $1E, $D3 ; Che[st]
    db $73 ; Scroll text
    db $88, $88, $04, $2C, $1C, $1A, $29, $1E ; [    ][    ]Escape
    db $68 ; Choose 2 indented
    db $7F ; End of message

    ; ==========================================================================
    ; Hi, [LINK].  Sorry about my
    ; yard.  It's a little over
    ; grown.  Thanks for visiting.
    ; I'm glad to have company to
    ; talk to.  I will tell you an
    ; interesting story.
    ; There is a lake swimming with
    ; Zoras at the source of the
    ; river, but it is hard to find.
    ; The treasure of Zora can turn
    ; people into fish.  Heh heh heh.
    ; I'd love to see that.
    ; --------------------------------------------------------------------------
    Message_0182:
    db $07, $22, $42, $59, $6A, $41, $8A, $12 ; Hi,⎵[LINK].[  ]S
    db $C8, $2B, $32, $59, $1A, $98, $2E, $2D ; [or]ry⎵a[bo]ut
    db $59, $26, $32 ; ⎵my
    db $75 ; Line 2
    db $32, $1A, $2B, $1D, $41, $8A, $08, $2D ; yard.[  ]It
    db $8B, $1A, $59, $25, $B6, $2D, $25, $1E ; ['s ]a⎵l[it]tle
    db $59, $28, $DD ; ⎵o[ver]
    db $76 ; Line 3
    db $20, $2B, $28, $30, $27, $41, $8A, $E5 ; grown.[  ][Tha]
    db $27, $24, $2C, $59, $A8, $59, $2F, $B5 ; nks⎵[for]⎵v[is]
    db $B6, $B4, $20, $41 ; [it][in]g.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $08, $51, $26, $59, $20, $BA, $1D, $59 ; I'm⎵g[la]d⎵
    db $DA, $59, $AD, $59, $9B, $29, $93, $32 ; [to]⎵[have]⎵[com]p[an]y
    db $59, $DA ; ⎵[to]
    db $73 ; Scroll text
    db $2D, $1A, $25, $24, $59, $DA, $41, $8A ; talk⎵[to].[  ]
    db $08, $59, $E2, $25, $25, $59, $2D, $1E ; I⎵[wi]ll⎵te
    db $25, $25, $59, $E3, $59, $93 ; ll⎵[you]⎵[an]
    db $73 ; Scroll text
    db $B4, $D6, $1E, $D3, $B3, $D3, $C8, $32 ; [in][ter]e[st][ing ][st][or]y
    db $41 ; .
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $E6, $CD, $B5, $59, $1A, $59, $BA, $24 ; [The][re ][is]⎵a⎵[la]k
    db $1E, $59, $2C, $E2, $26, $26, $B3, $DE ; e⎵s[wi]mm[ing ][with]
    db $73 ; Scroll text
    db $19, $C8, $1A, $2C, $59, $91, $D8, $59 ; Z[or]as⎵[at ][the]⎵
    db $D2, $2E, $2B, $1C, $1E, $59, $C6, $59 ; [so]urce⎵[of]⎵
    db $D8 ; [the]
    db $73 ; Scroll text
    db $2B, $22, $DD, $42, $59, $1B, $2E, $2D ; ri[ver],⎵but
    db $59, $B6, $59, $B5, $59, $B1, $2B, $1D ; ⎵[it]⎵[is]⎵[ha]rd
    db $59, $DA, $59, $1F, $B4, $1D, $41 ; ⎵[to]⎵f[in]d.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $E6, $59, $DB, $1E, $1A, $2C, $2E, $CD ; [The]⎵[tr]easu[re ]
    db $C6, $59, $19, $C8, $1A, $59, $99, $2D ; [of]⎵Z[or]a⎵[can ]t
    db $2E, $2B, $27 ; urn
    db $73 ; Scroll text
    db $29, $1E, $28, $CA, $59, $B4, $DA, $59 ; peo[ple]⎵[in][to]⎵
    db $1F, $B5, $21, $41, $8A, $07, $1E, $21 ; f[is]h.[  ]Heh
    db $59, $21, $1E, $21, $59, $21, $1E, $21 ; ⎵heh⎵heh
    db $41 ; .
    db $73 ; Scroll text
    db $08, $51, $1D, $59, $BB, $2F, $1E, $59 ; I'd⎵[lo]ve⎵
    db $DA, $59, $D0, $1E, $59, $D7, $2D, $41 ; [to]⎵[se]e⎵[tha]t.
    db $7F ; End of message

    ; ==========================================================================
    ; I haven't had a chance to trim
    ; my hedges recently.  Thanks
    ; for visiting anyway…
    ; A while ago, there was a boy in
    ; this village who could talk to
    ; animals with his Flute.
    ; He had a pet bird that flew
    ; with him everywhere, but
    ; he went to the mountain and
    ; never returned.
    ; --------------------------------------------------------------------------
    Message_0183:
    db $08, $59, $AD, $C0, $B1, $1D, $59, $1A ; I⎵[have][n't ][ha]d⎵a
    db $59, $1C, $B1, $27, $1C, $1E, $59, $DA ; ⎵c[ha]nce⎵[to]
    db $59, $DB, $22, $26 ; ⎵[tr]im
    db $75 ; Line 2
    db $26, $32, $59, $21, $1E, $1D, $20, $1E ; my⎵hedge
    db $2C, $59, $CE, $1C, $A3, $25, $32, $41 ; s⎵[re]c[ent]ly.
    db $8A, $E5, $27, $24, $2C ; [  ][Tha]nks
    db $76 ; Line 3
    db $A8, $59, $2F, $B5, $B6, $B3, $93, $32 ; [for]⎵v[is][it][ing ][an]y
    db $DF, $32, $43 ; [wa]y…
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $00, $59, $E1, $22, $25, $1E, $59, $1A ; A⎵[wh]ile⎵a
    db $AC, $42, $59, $D8, $CD, $DF, $2C, $59 ; [go],⎵[the][re ][wa]s⎵
    db $1A, $59, $98, $32, $59, $B4 ; a⎵[bo]y⎵[in]
    db $73 ; Scroll text
    db $D9, $2C, $59, $2F, $22, $25, $BA, $20 ; [thi]s⎵vil[la]g
    db $1E, $59, $E1, $28, $59, $1C, $28, $2E ; e⎵[wh]o⎵cou
    db $25, $1D, $59, $2D, $1A, $25, $24, $59 ; ld⎵talk⎵
    db $DA ; [to]
    db $73 ; Scroll text
    db $93, $22, $BD, $25, $2C, $59, $DE, $59 ; [an]i[ma]ls⎵[with]⎵
    db $B0, $2C, $59, $05, $25, $2E, $2D, $1E ; [hi]s⎵Flute
    db $41 ; .
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $07, $1E, $59, $B1, $1D, $59, $1A, $59 ; He⎵[ha]d⎵a⎵
    db $29, $1E, $2D, $59, $1B, $22, $2B, $1D ; pet⎵bird
    db $59, $D7, $2D, $59, $1F, $25, $1E, $30 ; ⎵[tha]t⎵flew
    db $73 ; Scroll text
    db $DE, $59, $B0, $26, $59, $A7, $A6, $32 ; [with]⎵[hi]m⎵[ev][er]y
    db $E1, $A6, $1E, $42, $59, $1B, $2E, $2D ; [wh][er]e,⎵but
    db $73 ; Scroll text
    db $21, $1E, $59, $E0, $27, $2D, $59, $DA ; he⎵[we]nt⎵[to]
    db $59, $D8, $59, $26, $28, $2E, $27, $2D ; ⎵[the]⎵mount
    db $8F, $59, $90 ; [ain]⎵[and]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $27, $A7, $A1, $CE, $2D, $2E, $2B, $27 ; n[ev][er ][re]turn
    db $1E, $1D, $41 ; ed.
    db $7F ; End of message

    ; ==========================================================================
    ; >Start From [LINK]'s House
    ;   Start From Sanctuary
    ; --------------------------------------------------------------------------
    Message_0184:
    db $6D, $00 ; Set window position
    db $7A, $00 ; Set draw speed
    db $44, $12, $2D, $1A, $2B, $2D, $59, $05 ; >Start⎵F
    db $2B, $28, $26, $59, $6A, $8B, $07, $28 ; rom⎵[LINK]['s ]Ho
    db $2E, $D0 ; u[se]
    db $75 ; Line 2
    db $8A, $12, $2D, $1A, $2B, $2D, $59, $05 ; [  ]Start⎵F
    db $2B, $28, $26, $59, $12, $93, $1C, $2D ; rom⎵S[an]ct
    db $2E, $1A, $2B, $32 ; uary
    db $72 ; Choose 2 high
    db $7F ; End of message

    ; ==========================================================================
    ; >Start From [LINK]'s House
    ;   Start From Sanctuary
    ;   Start From The Mountain Cave
    ; --------------------------------------------------------------------------
    Message_0185:
    db $6D, $00 ; Set window position
    db $7A, $00 ; Set draw speed
    db $44, $12, $2D, $1A, $2B, $2D, $59, $05 ; >Start⎵F
    db $2B, $28, $26, $59, $6A, $8B, $07, $28 ; rom⎵[LINK]['s ]Ho
    db $2E, $D0 ; u[se]
    db $75 ; Line 2
    db $8A, $12, $2D, $1A, $2B, $2D, $59, $05 ; [  ]Start⎵F
    db $2B, $28, $26, $59, $12, $93, $1C, $2D ; rom⎵S[an]ct
    db $2E, $1A, $2B, $32 ; uary
    db $76 ; Line 3
    db $8A, $12, $2D, $1A, $2B, $2D, $59, $05 ; [  ]Start⎵F
    db $2B, $28, $26, $59, $E6, $59, $0C, $28 ; rom⎵[The]⎵Mo
    db $2E, $27, $2D, $8F, $59, $02, $1A, $2F ; unt[ain]⎵Cav
    db $1E ; e
    db $71 ; Choose 3
    db $7F ; End of message

    ; ==========================================================================
    ; > Continue Game
    ;    Save and Quit
    ; --------------------------------------------------------------------------
    Message_0186:
    db $7A, $00 ; Set draw speed
    db $44, $59, $02, $C7, $2D, $B4, $2E, $1E ; >⎵C[on]t[in]ue
    db $59, $06, $1A, $BE ; ⎵Ga[me]
    db $75 ; Line 2
    db $89, $12, $1A, $2F, $1E, $59, $8C, $10 ; [   ]Save⎵[and ]Q
    db $2E, $B6 ; u[it]
    db $72 ; Choose 2 high
    db $7F ; End of message

    ; ==========================================================================
    ; Welcome to the treasure field.
    ; The object is to dig as many
    ; holes as you can in 30 seconds.
    ; Any treasures you dig up will
    ; be yours to keep.
    ; It's only 80 Rupees to play.
    ; What do you say?
    ;     > I want to dig
    ;        I don't want to dig
    ; --------------------------------------------------------------------------
    Message_0187:
    db $16, $1E, $25, $9B, $1E, $59, $DA, $59 ; Wel[com]e⎵[to]⎵
    db $D8, $59, $DB, $1E, $1A, $2C, $2E, $CD ; [the]⎵[tr]easu[re ]
    db $1F, $22, $1E, $25, $1D, $41 ; field.
    db $75 ; Line 2
    db $E6, $59, $28, $1B, $23, $1E, $1C, $2D ; [The]⎵object
    db $59, $B5, $59, $DA, $59, $9E, $20, $59 ; ⎵[is]⎵[to]⎵[di]g⎵
    db $1A, $2C, $59, $BC, $32 ; as⎵[man]y
    db $76 ; Line 3
    db $21, $28, $25, $1E, $2C, $59, $1A, $2C ; holes⎵as
    db $59, $E3, $59, $99, $B4, $59, $37, $34 ; ⎵[you]⎵[can ][in]⎵30
    db $59, $D0, $1C, $C7, $1D, $2C, $41 ; ⎵[se]c[on]ds.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $00, $27, $32, $59, $DB, $1E, $1A, $2C ; Any⎵[tr]eas
    db $2E, $CE, $2C, $59, $E3, $59, $9E, $20 ; u[re]s⎵[you]⎵[di]g
    db $59, $DC, $59, $E2, $25, $25 ; ⎵[up]⎵[wi]ll
    db $73 ; Scroll text
    db $97, $59, $E3, $2B, $2C, $59, $DA, $59 ; [be]⎵[you]rs⎵[to]⎵
    db $24, $1E, $1E, $29, $41 ; keep.
    db $73 ; Scroll text
    db $08, $2D, $8B, $C7, $B9, $3C, $34, $59 ; It['s ][on][ly ]80⎵
    db $11, $DC, $1E, $1E, $2C, $59, $DA, $59 ; R[up]ees⎵[to]⎵
    db $29, $BA, $32, $41 ; p[la]y.
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $16, $B1, $2D, $59, $9F, $59, $E3, $59 ; W[ha]t⎵[do]⎵[you]⎵
    db $2C, $1A, $32, $3F ; say?
    db $73 ; Scroll text
    db $88, $44, $59, $08, $59, $DF, $27, $2D ; [    ]>⎵I⎵[wa]nt
    db $59, $DA, $59, $9E, $20 ; ⎵[to]⎵[di]g
    db $73 ; Scroll text
    db $88, $89, $08, $59, $9F, $C0, $DF, $27 ; [    ][   ]I⎵[do][n't ][wa]n
    db $2D, $59, $DA, $59, $9E, $20 ; t⎵[to]⎵[di]g
    db $68 ; Choose 2 indented
    db $7F ; End of message

    ; ==========================================================================
    ; Then I will lend you a shovel.
    ; When you have it in your hand,
    ; start digging! (Press the
    ; ⓨ Button to dig.)
    ; --------------------------------------------------------------------------
    Message_0188:
    db $E6, $27, $59, $08, $59, $E2, $25, $25 ; [The]n⎵I⎵[wi]ll
    db $59, $25, $A5, $1D, $59, $E3, $59, $1A ; ⎵l[en]d⎵[you]⎵a
    db $59, $D1, $28, $2F, $1E, $25, $41 ; ⎵[sh]ovel.
    db $75 ; Line 2
    db $16, $21, $A0, $E3, $59, $AD, $59, $B6 ; Wh[en ][you]⎵[have]⎵[it]
    db $59, $B4, $59, $E3, $2B, $59, $B1, $27 ; ⎵[in]⎵[you]r⎵[ha]n
    db $1D, $42 ; d,
    db $76 ; Line 3
    db $D3, $1A, $2B, $2D, $59, $9E, $20, $20 ; [st]art⎵[di]gg
    db $B4, $20, $3E, $59, $45, $0F, $CE, $2C ; [in]g!⎵(P[re]s
    db $2C, $59, $D8 ; s⎵[the]
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $5E, $59, $01, $2E, $2D, $DA, $27, $59 ; ⓨ⎵But[to]n⎵
    db $DA, $59, $9E, $20, $41, $46 ; [to]⎵[di]g.)
    db $7F ; End of message

    ; ==========================================================================
    ; I see.  Then I give up.  Save
    ; some Rupees and come back.
    ; --------------------------------------------------------------------------
    Message_0189:
    db $08, $59, $D0, $1E, $41, $8A, $E6, $27 ; I⎵[se]e.[  ][The]n
    db $59, $08, $59, $AA, $DC, $41, $8A, $12 ; ⎵I⎵[give ][up].[  ]S
    db $1A, $2F, $1E ; ave
    db $75 ; Line 2
    db $CF, $59, $11, $DC, $1E, $1E, $2C, $59 ; [some]⎵R[up]ees⎵
    db $8C, $9B, $1E, $59, $96, $9C, $41 ; [and ][com]e⎵[ba][ck].
    db $7F ; End of message

    ; ==========================================================================
    ; OK!  Time's up, game over.
    ; Come back again.  Good bye…
    ; --------------------------------------------------------------------------
    Message_018A:
    db $0E, $0A, $3E, $8A, $13, $22, $BE, $8B ; OK![  ]Ti[me]['s ]
    db $DC, $42, $59, $20, $1A, $BE, $59, $28 ; [up],⎵ga[me]⎵o
    db $DD, $41 ; [ver].
    db $75 ; Line 2
    db $02, $28, $BE, $59, $96, $9C, $59, $1A ; Co[me]⎵[ba][ck]⎵a
    db $20, $8F, $41, $8A, $06, $28, $28, $1D ; g[ain].[  ]Good
    db $59, $1B, $32, $1E, $43 ; ⎵bye…
    db $7F ; End of message

    ; ==========================================================================
    ; Come back again!
    ; I will be waiting for you.
    ; --------------------------------------------------------------------------
    Message_018B:
    db $02, $28, $BE, $59, $96, $9C, $59, $1A ; Co[me]⎵[ba][ck]⎵a
    db $20, $8F, $3E ; g[ain]!
    db $75 ; Line 2
    db $08, $59, $E2, $25, $25, $59, $97, $59 ; I⎵[wi]ll⎵[be]⎵
    db $DF, $B6, $B3, $A8, $59, $E3, $41 ; [wa][it][ing ][for]⎵[you].
    db $7F ; End of message

    ; ==========================================================================
    ; I can't tell you details, but
    ; it's not a convenient time for
    ; me now.  Come back here again.
    ; Sorry.
    ; --------------------------------------------------------------------------
    Message_018C:
    db $08, $59, $1C, $93, $51, $2D, $59, $2D ; I⎵c[an]'t⎵t
    db $1E, $25, $25, $59, $E3, $59, $1D, $1E ; ell⎵[you]⎵de
    db $2D, $1A, $22, $25, $2C, $42, $59, $1B ; tails,⎵b
    db $2E, $2D ; ut
    db $75 ; Line 2
    db $B6, $8B, $C2, $59, $1A, $59, $1C, $C7 ; [it]['s ][not]⎵a⎵c[on]
    db $2F, $A5, $22, $A3, $59, $2D, $22, $BE ; v[en]i[ent]⎵ti[me]
    db $59, $A8 ; ⎵[for]
    db $76 ; Line 3
    db $BE, $59, $27, $28, $30, $41, $8A, $02 ; [me]⎵now.[  ]C
    db $28, $BE, $59, $96, $9C, $59, $AF, $1E ; o[me]⎵[ba][ck]⎵[her]e
    db $59, $1A, $20, $8F, $41 ; ⎵ag[ain].
    db $7E ; Wait for key
    db $73 ; Scroll text
    db $12, $C8, $2B, $32, $41 ; S[or]ry.
    db $7F ; End of message
}
    
; ==============================================================================

; $076E21-$0773FF NULL
; ZScream uses this space as an extention of the dialog data block above.
NULL_0EEE21:
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
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $077400-$0774EA LONG JUMP LOCATION
PaletteBlackAndWhiteSomething:
{
    .Conditional
    ; Causes the screen to flash white (e.g. the master sword retrieval and
    ; ganon's tower opening).
        
    ; Don't do the following section if it's not the 0th part of a
    ; sub-submodule.
    LDA.b $B0 : BNE .BRANCH_ALPHA
    
        ; $077404 ALTERNATE ENTRY POINT
        .NonConditional
    
        REP #$20
        
        LDX.b #$00
    
        .cache_colors_and_whiten_loop
    
            ; This loop turns all the colors in the temporary palette buffer to
            ; white. It also saves them to a a temporary buffer
            ; (0x7FDD80[0x200]).
            LDA.l $7EC300, X : STA.l $7FDD80, X
            LDA.l $7EC380, X : STA.l $7FDE00, X
            LDA.l $7EC400, X : STA.l $7FDE80, X
            LDA.l $7EC480, X : STA.l $7FDF00, X
            
            LDA.w #$7FFF : STA.l $7EC300, X
                         STA.l $7EC380, X
                         STA.l $7EC400, X
                         STA.l $7EC480, X
        INX #2 : CPX.b #$80 : BNE .cache_colors_and_whiten_loop
        
        ; Save the background color to another area of the palette buffer.
        LDA.l $7EC500 : STA.l $7EC540
        
        ; Mosaic level is zero.
        LDA.w #$0000 : STA.l $7EC007
        
        ; Turn on color filtering.
        LDA.w #$0002 : STA.l $7EC009
        
        SEP #$20
        
        INC.b $B0
        
        RTL
    
    .BRANCH_ALPHA
    
    JSL.l PaletteFilter_BlindingWhite
        
    REP #$30
        
    LDA.l $7EC009 : CMP.w #$00FF : BNE .RestorePalette
        LDX.w #$000E : LDA.w #$0000
    
        .BRANCH_DELTA
    
            STA.l $7EC3B0, X : STA.l $7EC5B0, X
        DEX #2 : BPL .BRANCH_DELTA
        
        STA.l $7EC007
        STA.l $7EC009
        
        SEP #$20
        
        STZ.b $11
        
        SEP #$30
        
        RTL
    
    ; $07748C ALTERNATE ENTRY POINT
    .RestorePalette
    
    CMP.w #$0000 : BNE .BRANCH_EPSILON
        LDA.l $7EC007 : CMP.w #$001F : BNE .BRANCH_EPSILON
        
        LDX.w #$0000
    
        .restore_cached_colors_loop
    
            LDA.l $7FDD80, X : STA.l $7EC300, X
            LDA.l $7FDDC0, X : STA.l $7EC340, X
            LDA.l $7FDE00, X : STA.l $7EC380, X
            LDA.l $7FDE40, X : STA.l $7EC3C0, X
            LDA.l $7FDE80, X : STA.l $7EC400, X
            LDA.l $7FDEC0, X : STA.l $7EC440, X
            LDA.l $7FDF00, X : STA.l $7EC480, X
        INX #2 : CPX.w #$0040 : BNE .restore_cached_colors_loop
        
        SEP #$20
        
        STZ.b $1D
    
    .BRANCH_EPSILON
    
    SEP #$30
        
    RTL
}

; ==============================================================================

; $0774EB-$0774F8 DATA
Palettes_BlueThunder1:
{
    dw  $0884,  $0CC7,  $150A,  $154D,  $7FF6,  $5944,  $7AD1
}

; $0774F9-$077506 DATA
Palettes_BlueThunder2:
{
    dw  $0884,  $0CC7,  $150A,  $154D,  $5BFF,  $7AD1,  $21AF
}

; $077507-$077514 DATA
Palettes_BlueThunder3:
{
    dw  $1084,  $48C0,  $6186,  $7E6D,  $7FE0,  $5944,  $7E20
}

; $077515-$077522 DATA
Palettes_BlueThunder4:
{
    dw  $1084,  $000E,  $1059,  $291F,  $7FE0,  $5944,  $7E20
}

; $077523-$077530 DATA
Palettes_BlueThunder5:
{
    dw  $1084,  $1508,  $196C,  $21AF,  $7FF6,  $1D4C,  $7AD1
}

; $077531-$077580 DATA
Palettes_GanonTowerFlash:
{
    dw  $7FFF,  $0884,  $1CC8,  $1DCE,  $3694,  $4718,  $1D4A,  $18AC
    dw  $7FFF,  $1908,  $2D2F,  $3614,  $4EDA,  $471F,  $1D4A,  $390F
    dw  $7FFF,  $34CD,  $5971,  $5635,  $7F1B,  $7FFF,  $1D4A,  $3D54
    dw  $7FFF,  $1908,  $2D2F,  $3614,  $4EDA,  $471F,  $1D4A,  $390F
    dw  $7FFF,  $0884,  $052A,  $21EF,  $3AB5,  $4B39,  $1D4C,  $18AC
}

; $077581-$077581 BRANCH LOCATION
Overworld_DwDeathMountainPaletteAnimation_easyOut:
{
    RTL
}

; $077582-$077651 LONG JUMP LOCATION
; This function controls the lighting flashing int he background of DW death
; mountain as well as the Ganon's tower palette cycling.
Overworld_DwDeathMountainPaletteAnimation:
{
    LDA.w $04C6 : BNE .easyOut
        LDA.b $8A
        CMP.b #$43 : BEQ .dwDeathMountain
        CMP.b #$45 : BEQ .dwDeathMountain
        CMP.b #$47 : BNE .easyOut
            .dwDeathMountain
            
            PHB : PHK : PLB
                
            LDA.b $1A
            CMP.b #$03 : BEQ .alter_palettes
            CMP.b #$05 : BEQ .restore_palettes
            CMP.b #$24 : BEQ .play_sound
            CMP.b #$2C : BEQ .restore_palettes
            CMP.b #$58 : BEQ .alter_palettes
            CMP.b #$5A : BNE .abstain        
                .restore_palettes
                    
                REP #$20
                        
                LDX.b #$02
                    
                .loop_1
                    LDA.l $7EC360, X : STA.l $7EC560, X
                    LDA.l $7EC370, X : STA.l $7EC570, X
                    LDA.l $7EC390, X : STA.l $7EC590, X
                    LDA.l $7EC3E0, X : STA.l $7EC5E0, X
                    LDA.l $7EC3F0, X : STA.l $7EC5F0, X
                        
                INX #2 : CPX.b #$10 : BNE .loop_1
                        
                BRA .abstain
                    
            .play_sound
                
            LDX.b #$36 : STX.w $012E
            
            .alter_palettes

            REP #$20
                
            LDX.b #$02
            LDY.b #$00
            
            .loop_2
                LDA.w Palettes_BlueThunder1, Y : STA.l $7EC560, X
                LDA.w Palettes_BlueThunder2, Y : STA.l $7EC570, X
                LDA.w Palettes_BlueThunder3, Y : STA.l $7EC590, X
                LDA.w Palettes_BlueThunder4, Y : STA.l $7EC5E0, X
                LDA.w Palettes_BlueThunder5, Y : STA.l $7EC5F0, X
                
                INY #2
                
            INX #2 : CPX.b #$10 : BNE .loop_2
            
            .abstain
            
            SEP #$20
                
            LDX.b #$00
            LDY.b #$40
                
            LDA.b $8A
                
            CMP.b #$43 : BEQ .check_flag
                CMP.b #$45 : BNE .do_palette_animation
            
            .check_flag
            
            LDA.l $7EF2C3 : AND.b #$20 : BNE .ganons_tower_opened
                LDA.b $1A : AND.b #$0C : ASL #2 : TAY
            
                .do_palette_animation
                .palette_write_loop
                    REP #$20
                    
                    LDA.w Palettes_GanonTowerFlash, Y : STA.l $7EC5D0, X
                    
                    INY #2
                
                INX #2 : CPX.b #$10 : BNE .palette_write_loop
            
            .ganons_tower_opened
            
            SEP #$20
                
            PLB
                
            INC.b $15
                
            RTL
}

; ==============================================================================

; $077652-$077663 LONG JUMP LOCATION
Overworld_LoadEventOverlay:
{
    PHB
        
    ; Set the data bank to $7E.
    LDA.b #$7E : PHA : PLB
        
    REP #$30
        
    ; Check to see what Overworld area we're in.
    ; Use it as an index into a jump table.
    LDA.b $8A : ASL A : TAX
        
    SR.w (Overworld_EventOverlayTable, X)
        
    SEP #$30
        
    PLB
        
    RTL
}

; ==============================================================================

; Overlay pointers (for use with the 0x20 overlays on OW).
; $077664-$077763 JUMP TABLE
Overworld_EventOverlayTable:
{
    dw OverworldOverlay_LumberjackTree      ; 0x00 - $F764
    dw OverworldOverlay_LumberjackTree      ; 0x01 - $F764
    dw OverworldOverlay_LumberjackTree      ; 0x02 - $F764
    dw OverworldOverlay_TurtleRockPortal    ; 0x03 - $F7AA
    dw OverworldOverlay_TurtleRockPortal    ; 0x04 - $F7AA
    dw OverworldOverlay_TurtleRockPortal    ; 0x05 - $F7AA
    dw OverworldOverlay_TurtleRockPortal    ; 0x06 - $F7AA
    dw OverworldOverlay_TurtleRockPortal    ; 0x07 - $F7AA
    
    dw OverworldOverlay_BonkRocks           ; 0x08 - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x09 - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x0A - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x0B - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x0C - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x0D - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x0E - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x0F - $F7B1
    
    dw OverworldOverlay_BonkRocks           ; 0x10 - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x11 - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x12 - $F7B1
    dw OverworldOverlay_BonkRocks           ; 0x13 - $F7B1
    dw OverworldOverlay_KingsTomb           ; 0x14 - $F7C7
    dw OverworldOverlay_WeatherVane         ; 0x15 - $F7E4
    dw OverworldOverlay_WeatherVane         ; 0x16 - $F7E4
    dw OverworldOverlay_WeatherVane         ; 0x17 - $F7E4
    
    dw OverworldOverlay_WeatherVane         ; 0x18 - $F7E4 Used in drawing over the weather vane after it has been exploded.
    dw OverworldOverlay_WeatherVane         ; 0x19 - $F7E4
    dw OverworldOverlay_CastleGate          ; 0x1A - $F7FE
    dw OverworldOverlay_CastleGate          ; 0x1B - $F7FE
    dw OverworldOverlay_CastleGate          ; 0x1C - $F7FE
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x1D - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x1E - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x1F - $F827
    
    dw OverworldOverlay_WeatherVane         ; 0x20 - $F7E4
    dw OverworldOverlay_WeatherVane         ; 0x21 - $F7E4
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x22 - $F827
    dw OverworldOverlay_WeatherVane         ; 0x23 - $F7E4
    dw OverworldOverlay_WeatherVane         ; 0x24 - $F7E4
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x25 - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x26 - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x27 - $F827
    
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x28 - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x29 - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x2A - $F827
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x2B - $F827
    dw OverworldOverlay_CheckerBoardCave    ; 0x2C - $F82D
    dw OverworldOverlay_CheckerBoardCave    ; 0x2D - $F82D
    dw OverworldOverlay_CheckerBoardCave    ; 0x2E - $F82D
    dw OverworldOverlay_CheckerBoardCave    ; 0x2F - $F82D
    
    dw OverworldOverlay_CheckerBoardCave    ; 0x30 - $F82D to move weathervane, this may be need changing to match area $18.
    dw OverworldOverlay_CheckerBoardCave    ; 0x31 - $F82D
    dw OverworldOverlay_IceRodThief         ; 0x32 - $F833
    dw OverworldOverlay_IceRodThief         ; 0x33 - $F833
    dw OverworldOverlay_IceRodThief         ; 0x34 - $F833
    dw OverworldOverlay_IceRodThief         ; 0x35 - $F833
    dw OverworldOverlay_IceRodThief         ; 0x36 - $F833
    dw OverworldOverlay_IceRodThief         ; 0x37 - $F833
    
    dw OverworldOverlay_CheckerBoardCave    ; 0x38 - $F82D
    dw OverworldOverlay_CheckerBoardCave    ; 0x39 - $F82D
    dw OverworldOverlay_DesertThief         ; 0x3A - $F839
    dw OverworldOverlay_DrainedDam          ; 0x3B - $F83F
    dw OverworldOverlay_SkullWoods          ; 0x3C - $F9E6
    dw OverworldOverlay_SkullWoods          ; 0x3D - $F9E6
    dw OverworldOverlay_SkullWoods          ; 0x3E - $F9E6
    dw OverworldOverlay_SkullWoods          ; 0x3F - $F9E6
    
    dw OverworldOverlay_SkullWoods          ; 0x40 - $F9E6
    dw OverworldOverlay_SkullWoods          ; 0x41 - $F9E6
    dw OverworldOverlay_GanonsTower         ; 0x42 - $FA2E
    dw OverworldOverlay_GanonsTower         ; 0x43 - $FA2E Ganon's Tower Overlay (opened tower stairs).
    dw OverworldOverlay_GanonsTower         ; 0x44 - $FA2E
    dw OverworldOverlay_HookshotCave        ; 0x45 - $FA5B
    dw OverworldOverlay_HookshotCave        ; 0x46 - $FA5B
    dw OverworldOverlay_TurtleRock          ; 0x47 - $FA61
    
    dw OverworldOverlay_SkullWoods          ; 0x48 - $F9E6
    dw OverworldOverlay_SkullWoods          ; 0x49 - $F9E6
    dw OverworldOverlay_GargoylesDomain     ; 0x4A - $FAB4
    dw OverworldOverlay_GanonsTower         ; 0x4B - $FA2E
    dw OverworldOverlay_GanonsTower         ; 0x4C - $FA2E
    dw OverworldOverlay_HookshotCave        ; 0x4D - $FA5B
    dw OverworldOverlay_HookshotCave        ; 0x4E - $FA5B
    dw OverworldOverlay_GargoylesDomain     ; 0x4F - $FAB4
    
    dw OverworldOverlay_GargoylesDomain     ; 0x50 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x51 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x52 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x53 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x54 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x55 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x56 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x57 - $FAB4
    
    dw OverworldOverlay_GargoylesDomain     ; 0x58 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x59 - $FAB4
    dw OverworldOverlay_PyramidHole         ; 0x5A - $FACF
    dw OverworldOverlay_PyramidHole         ; 0x5B - $FACF Pyramid
    dw OverworldOverlay_PyramidHole         ; 0x5C - $FACF
    dw OverworldOverlay_POD                 ; 0x5D - $FAF6
    dw OverworldOverlay_POD                 ; 0x5E - $FAF6
    dw OverworldOverlay_POD                 ; 0x5F - $FAF6
    
    dw OverworldOverlay_GargoylesDomain     ; 0x60 - $FAB4
    dw OverworldOverlay_GargoylesDomain     ; 0x61 - $FAB4
    dw OverworldOverlay_PegPuzzle           ; 0x62 - $FB0B
    dw OverworldOverlay_PyramidHole         ; 0x63 - $FACF
    dw OverworldOverlay_PyramidHole         ; 0x64 - $FACF
    dw OverworldOverlay_MiseryMire          ; 0x65 - $FB11
    dw OverworldOverlay_POD                 ; 0x66 - $FAF6
    dw OverworldOverlay_POD                 ; 0x67 - $FAF6
    
    dw OverworldOverlay_MiseryMire          ; 0x68 - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x69 - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x6A - $FB11
    dw OverworldOverlay_LinksHouseBonkRocks ; 0x6B - $F827
    dw OverworldOverlay_MiseryMire          ; 0x6C - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x6D - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x6E - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x6F - $FB11
    
    dw OverworldOverlay_MiseryMire          ; 0x70 - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x71 - $FB11
    dw NULL_0EFB64                          ; 0x72 - $FB64
    dw NULL_0EFB64                          ; 0x73 - $FB64
    dw NULL_0EFB64                          ; 0x74 - $FB64
    dw NULL_0EFB64                          ; 0x75 - $FB64
    dw NULL_0EFB64                          ; 0x76 - $FB64
    dw OverworldOverlay_IceRodThief         ; 0x77 - $F833
    
    dw OverworldOverlay_MiseryMire          ; 0x78 - $FB11
    dw OverworldOverlay_MiseryMire          ; 0x79 - $FB11
    dw NULL_0EFB64                          ; 0x7A - $FB64
    dw OverworldOverlay_DrainedDam          ; 0x7B - $F83F
    dw NULL_0EFB64                          ; 0x7C - $FB64
    dw NULL_0EFB64                          ; 0x7D - $FB64
    dw NULL_0EFB64                          ; 0x7E - $FB64
    dw NULL_0EFB64                          ; 0x7F - $FB64

    ; Note there is nothing here for the Master Sword resting place and Zora
    ; falls. Must be handled elsewhere.
}

; $077764-$0777A9 LOCAL JUMP LOCATION
OverworldOverlay_LumberjackTree:
{
    LDA.w #$0E32
    
    STA.w $2816 : STA.w $2818 : STA.w $281A 
    STA.w $281C : STA.w $2896 : STA.w $289C
    
    INC A : STA.w $2898
    INC A : STA.w $2E9A
    INC A : STA.w $2916
    INC A : STA.w $2918
    INC A : STA.w $291A
    INC A : STA.w $291C
    INC A : STA.w $2996
    INC A : STA.w $2998
    INC A : STA.w $299A
    INC A : STA.w $299C
    INC A : STA.w $2A18
    INC A : STA.w $2A1A
    
    RTS
}

; $0777AA-$0777B0 LOCAL JUMP LOCATION
OverworldOverlay_TurtleRockPortal:
{
    LDA.w #$0212 : STA.w $2720
    
    RTS
}

; $0777B1-$0777B3 LOCAL JUMP LOCATION
OverworldOverlay_BonkRocks:
{
    LDX.w #$0506

    ; Bleeds into the next function.
}

; $0777B4-$0777C6 LOCAL JUMP LOCATION
OverworldOverlay_DrawRevealedStairs:
{
    LDA.w #$0918 : STA.w $2000, X
    INC A        : STA.w $2002, X
    INC A        : STA.w $2080, X
    INC A        : STA.w $2082, X
    
    RTS
}

; $0777C7-$0777E3 LOCAL JUMP LOCATION
OverworldOverlay_KingsTomb:
{
    LDA.w #$0DD1 : STA.w $2532
    INC A        : STA.w $2534
    
    LDA.w #$0DD7 : STA.w $25B2
    INC A        : STA.w $25B4
    INC A        : STA.w $2632
    INC A        : STA.w $2634
    
    RTS
}

; $0777E4-$0777FD LOCAL JUMP LOCATION
OverworldOverlay_WeatherVane:
{
    LDA.w #$0E21 : STA.w $2C3E : STA.w $2C42
    INC A        : STA.w $2C40
    INC A        : STA.w $2CBE
    INC A        : STA.w $2CC0
    INC A        : STA.w $2CC2
    
    RTS
}

; $0777FE-$077826 LOCAL JUMP LOCATION
OverworldOverlay_CastleGate:
{
    LDA.w #$0DC1 : STA.w $33BC
    INC A        : STA.w $33BE
    
    LDA.w #$0DBE : STA.w $343C
    INC A        : STA.w $343E
    
    LDA.w #$0DC2 : STA.w $33C0
    INC A        : STA.w $33C2
    
    LDA.w #$0DBF : STA.w $3440
    INC A        : STA.w $3442
    
    RTS
}

; $077827-$07782C LOCAL JUMP LOCATION
OverworldOverlay_LinksHouseBonkRocks:
{
    LDX.w #$0330
    
    JMP.w OverworldOverlay_DrawRevealedStairs
}

; $07782D-$077832 LOCAL JUMP LOCATION
OverworldOverlay_CheckerBoardCave:
{
    LDX.w #$0358
    
    JMP.w OverworldOverlay_DrawRevealedStairs
}

; $077833-$077838 LOCAL JUMP LOCATION
OverworldOverlay_IceRodThief:
{
    LDX.w #$040C
    
    JMP.w OverworldOverlay_DrawRevealedStairs
}

; $077839-$07783E LOCAL JUMP LOCATION
OverworldOverlay_DesertThief:
{
    LDX.w #$0A1E
    
    JMP.w OverworldOverlay_DrawRevealedStairs
}

; $07783F-$0779E5 LOCAL JUMP LOCATION
OverworldOverlay_DrainedDam:
{
    LDA.w #$0DDF
    
    STA.w $23AC : STA.w $2424 : STA.w $24A0 : STA.w $251E
    STA.w $261C : STA.w $2734
    
    INC A : STA.w $23AE : STA.w $24A2
    INC A : STA.w $23B0 : STA.w $2438 : STA.w $24BA : STA.w $25AA : STA.w $273A
    INC A : STA.w $2426 : STA.w $2428 : STA.w $242A : STA.w $2432 : STA.w $2434
    STA.w $2436

    INC A : STA.w $242C : STA.w $24A4 : STA.w $2520 : STA.w $261E
    
    INC A
    
    STA.w $242E : STA.w $2426 : STA.w $24A8 : STA.w $24B0
    STA.w $24B6 : STA.w $2522 : STA.w $2524 : STA.w $2526
    STA.w $2538 : STA.w $25A0 : STA.w $25A2 : STA.w $25A4
    STA.w $25A6 : STA.w $2620 : STA.w $2622 : STA.w $269E
    STA.w $26A0 : STA.w $271E : STA.w $2720 : STA.w $2826
    STA.w $28A6 : STA.w $28A8 : STA.w $2926
    
    INC A
    
    STA.w $2430 : STA.w $24B8 : STA.w $25A8 : STA.w $262A
    
    INC A
    
    STA.w $24AA : STA.w $24B2 : STA.w $2528 : STA.w $25B8
    STA.w $28AA : STA.w $2928
    
    INC A
    
    STA.w $24AC : STA.w $2530 : STA.w $279E : STA.w $27A0
    STA.w $29A6 : STA.w $29B8
    
    INC A
    
    STA.w $24AE : STA.w $24B4 : STA.w $2536 : STA.w $27A2
    STA.w $2824
    
    INC A
    
    STA.w $252E : STA.w $2534 : STA.w $279C : STA.w $2822
    STA.w $2934 : STA.w $29B6
    
    INC A
    
    STA.w $253A : STA.w $2638 : STA.w $26B8 : STA.w $293A
    
    INC A
    
    STA.w $259E : STA.w $25B6 : STA.w $2636 : STA.w $269C
    STA.w $26B6 : STA.w $271C : STA.w $28A4 : STA.w $2924
    
    INC A : STA.w $2624 : STA.w $26A2
    INC A : STA.w $2626
    INC A : STA.w $2628
    INC A : STA.w $26A4 : STA.w $27B6
    
    INC A
    
    STA.w $26A6 : STA.w $2726 : STA.w $2728 : STA.w $272A
    STA.w $27AA : STA.w $2836 : STA.w $2838
    
    INC A : STA.w $26A8 : STA.w $27B8
    INC A : STA.w $26AA
    INC A : STA.w $2727 : STA.w $27A4 : STA.w $2828
    INC A : STA.w $2724
    INC A : STA.w $27A6
    INC A : STA.w $27A8 : STA.w $28B6
    INC A : STA.w $27B4
    INC A : STA.w $27BA
    INC A : STA.w $282A
    INC A : STA.w $2834
    INC A : STA.w $283A
    INC A : STA.w $28B4
    INC A : STA.w $28B8
    INC A : STA.w $28BA
    INC A : STA.w $2936
    INC A : STA.w $2938
    INC A : STA.w $252A : STA.w $2532 : STA.w $292A
    INC A : STA.w $25BA : STA.w $29A8 : STA.w $29BA
    INC A : STA.w $29A4
    INC A : STA.w $2736
    INC A : STA.w $2738
    
    RTS
}

; $0779E6-$077A2D LOCAL JUMP LOCATION
OverworldOverlay_SkullWoods:
{
    LDA.w #$0E13 : STA.w $2590
    INC A        : STA.w $2596
    INC A        : STA.w $2610
    INC A        : STA.w $2612
    INC A        : STA.w $2614
    INC A        : STA.w $2616
    INC A        : STA.w $2692
    INC A        : STA.w $2694
    
    LDA.w #$0E06 : STA.w $2812 : STA.w $2814
    INC A        : STA.w $2710 : STA.w $2790
    INC A        : STA.w $2712 : STA.w $2792
    INC A        : STA.w $2714 : STA.w $2794
    INC A        : STA.w $2716 : STA.w $2796
    
    RTS
}

; $077A2E-$077A5A LOCAL JUMP LOCATION
OverworldOverlay_GanonsTower:
{
    LDA.w #$0E96 : STA.l $7E245E
    INC A        : STA.l $7E2460
    
    LDA.w #$0E9C : STA.l $7E24DE : STA.l $7E255E
    INC A        : STA.l $7E24E0 : STA.l $7E2560
    
    LDA.w #$0E9A : STA.l $7E25DE
    INC A        : STA.l $7E25E0
    
    RTS
}

; $077A5B-$077A60 LOCAL JUMP LOCATION
OverworldOverlay_HookshotCave:
{
    LDX.w #$0868
    
    JMP.w OverworldOverlay_DrawRevealedStairs
}

; $077A61-$077AB3 LOCAL JUMP LOCATION
OverworldOverlay_TurtleRock:
{
    LDA.w #$0E78 : STA.l $7E299E
    INC A        : STA.l $7E29A0
    INC A        : STA.l $7E29A2
    INC A        : STA.l $7E29A4
    INC A        : STA.l $7E2A1E
    INC A        : STA.l $7E202A
    INC A        : STA.l $7E2A22
    INC A        : STA.l $7E2A24
    INC A        : STA.l $7E2A9E
    INC A        : STA.l $7E2AA0
    INC A        : STA.l $7E2AA2
    INC A        : STA.l $7E2AA4
    INC A        : STA.l $7E2B1E
    INC A        : STA.l $7E2B20
    INC A        : STA.l $7E2B22
    INC A        : STA.l $7E2B24
    
    RTS
}

; $077AB4-$077ACE LOCAL JUMP LOCATION
OverworldOverlay_GargoylesDomain:
{
    LDA.w #$0E1B : STA.w $2D3E
    INC A        : STA.w $2D40
    INC A        : STA.w $2DBE
    INC A        : STA.w $2DC0
    INC A        : STA.w $2E3E
    INC A        : STA.w $2E40
    
    RTS
}

; $077ACF-$077AF5 LOCAL JUMP LOCATION
OverworldOverlay_PyramidHole:
{
    LDA.w #$0E3F : STA.w $23BC
    INC A        : STA.w $23BE
    INC A        : STA.w $23C0
    INC A        : STA.w $243C
    INC A        : STA.w $243E
    INC A        : STA.w $2440
    INC A        : STA.w $24BC
    INC A        : STA.w $24BE
    INC A        : STA.w $24C0
    
    RTS
}

; $077AF6-$077B0A LOCAL JUMP LOCATION
OverworldOverlay_POD:
{
    LDA.w #$0E31 : STA.w $21E6
    
    LDA.w #$0E2D : STA.w $226A
    
    INC A : STA.w $22EA
    INC A : STA.w $236A
    
    RTS
}

; $077B0B-$077B10 LOCAL JUMP LOCATION
OverworldOverlay_PegPuzzle:
{
    LDX.w #$0D20
    
    JMP.w OverworldOverlay_DrawRevealedStairs
}

; $077B11-$077B63 LOCAL JUMP LOCATION
OverworldOverlay_MiseryMire:
{
    LDA.w #$0E64 : STA.w $2522
    
    INC A : STA.w $2524
    INC A : STA.w $2526
    INC A : STA.w $2528
    INC A : STA.w $25A2
    INC A : STA.w $25A4
    INC A : STA.w $25A6
    INC A : STA.w $25A8
    INC A : STA.w $2622
    INC A : STA.w $2624
    INC A : STA.w $2626
    INC A : STA.w $2628
    INC A : STA.w $26A2
    INC A : STA.w $26A4
    INC A : STA.w $26A6
    INC A : STA.w $26A8
    INC A : STA.w $2722
    INC A : STA.w $2724
    INC A : STA.w $2726
    INC A : STA.w $2728
    
    RTS
}

; $077B64-$077FFF NULL
NULL_0EFB64:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

warnpc $0F8000