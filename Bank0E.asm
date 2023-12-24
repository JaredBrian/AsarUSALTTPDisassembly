; ==============================================================================

; Bank 0E
org $0E8000 ; $070000-$077FFF

; ==============================================================================

incbin "binary_files/font_gfx.bin" ; $070000-$070FFF

; ==============================================================================

; $071000-$071429 DATA
pool Dungeon_LoadCustomTileAttr:
{
    .group_offsets
    dw $0000, $0000, $0000, $0080, $0080, $0100, $0100, $0100
    dw $0180, $0000, $0100, $0200, $0280, $0300, $0380, $0100
    dw $0100, $0080, $0100, $0380, $0100
    
    .groups
    ; This consists of customized tile behaviors based on the value of the current
    ; BG tileset ($0AA2)
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

; $07142A-$071458 LONG
Dungeon_LoadCustomTileAttr:
{
    ; Loads tile attributes that are specific to a tileset type.
    ; The group loaded is dependent on the value of $0AA2.
    PHB : PHK : PLB
        
    REP #$30
        
    LDA $0AA2 : AND.w #$00FF : ASL A : TAX
        
    LDA .group_offsets, X : TAY
        
    LDX.w #$0000
    
    .load_loop
    
        LDA .blocks, Y       : STA $7EFF40, X
        LDA .blocks + $40, Y : STA $7EFF80, X
        
        INY #2
    INX #2 : CPX.w #$0040 : BNE .load_loop
        
    SEP #$30
        
    PLB
        
    RTL
}

; ==============================================================================

; $071459-$071658 DATA (Note: This data is not accessed from this bank)
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
    
    ; \note Values before this comment go to $7EFE00-$7EFF3F, values after
    ; it end up at $7EFFC0-$7EFFFF. The remaining memory contains values
    ; from the custom attributes data.
    
    db $27, $27, $00, $27, $60, $60, $01, $01, $01, $01, $02, $02, $0D, $00, $00, $4B
    db $67, $67, $67, $67, $66, $66, $66, $66, $00, $00, $20, $20, $20, $20, $20, $20
    db $27, $63, $27, $55, $55, $01, $44, $00, $01, $20, $02, $02, $1C, $3A, $3B, $00
    db $27, $63, $27, $53, $53, $01, $44, $01, $0D, $00, $00, $00, $09, $09, $09, $09
}
    
; ==============================================================================

; $0717D9-$071813 LONG
Init_LoadDefaultTileAttr:
{
    REP #$20
        
    LDX.b #$3E
    
    .loop
    
        LDA Dungeon_DefaultAttr + $0000, X : STA $7EFE00, X
        LDA Dungeon_DefaultAttr + $0040, X : STA $7EFE40, X
        LDA Dungeon_DefaultAttr + $0080, X : STA $7EFE80, X
        LDA Dungeon_DefaultAttr + $0100, X : STA $7EFEC0, X
        LDA Dungeon_DefaultAttr + $0140, X : STA $7EFF00, X
        LDA Dungeon_DefaultAttr + $0180, X : STA $7EFFC0, X
    DEX #2 : BPL .loop
        
    SEP #$30
        
    RTL
}

; ==============================================================================

; $071814-$07181F EMPTY
pool Empty:
{
    ; $0C bytes of null.
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $071820-$07186D DATA TABLE
{
    ; Usage: Main Module 1A
        
    ; Parameter: $11
        
    ; Notes: the combination 9889, 9958 is an outdoor scene
    ; the combination 9891, 99C5 is an indoor scene (sanctuary, etc)
    ; Anything after those combinations is of the second part of the ending
    ; Specifically, the credits set against the Triforce spinning in the 
    ; air, overlooking the golden land.
        
    dw $9889 ; 0:  = $071889 ; Hyrule Castle restored
    dw $9958 ; 1:  = $071958
    dw $9891 ; 2:  = $071891 ; Priest Recovers
    dw $99C5 ; 3:  = $0719C5
    dw $9889 ; 4:  = $071889 ; Sahasralah's Homecoming
    dw $9958 ; 5:  = $071958
    dw $9889 ; 6:  = $071889 ; Vultures rule the desert
    dw $9958 ; 7:  = $071958
    
    dw $9889 ; 8:  = $071889 ; The Bully makes a friend
    dw $9958 ; 9:  = $071958
    dw $9889 ; A:  = $071889 ; Uncle recovers
    dw $9958 ; B:  = $071958
    dw $9889 ; C:  = $071889 ; Zora's Area Scene
    dw $9958 ; D:  = $071958
    dw $9889 ; E:  = $071889 ; Witch and Assistant
    dw $9958 ; F:  = $071958
    
    dw $9889 ; 10: = $071889 ; Twin Lumberjacks
    dw $9958 ; 11: = $071958
    dw $9889 ; 12: = $071889 ; Fluteboy plays again
    dw $9958 ; 13: = $071958
    dw $9891 ; 14: = $071891 ; Venus, queen of Fairys (and herpes)
    dw $99C5 ; 15: = $0719C5
    dw $9891 ; 16: = $071891 ; Dwarven Swordsmiths
    dw $99C5 ; 17: = $0719C5
    
    dw $9889 ; 18: = $071889 ; The Bug Catching Kid
    dw $9958 ; 19: = $071958
    dw $9889 ; 1A: = $071889 ; The Lost Old Man
    dw $9958 ; 1B: = $071958
    dw $9889 ; 1C: = $071889 ; The Forest Thief
    dw $9958 ; 1D: = $071958
    dw $9889 ; 1E: = $071889 ; Master Sword Sleeps Again, Forever!
    dw $9958 ; 1F: = $071958
    
    dw $BC6D ; 20: = $073C6D ; Sets up for mode 0x22. Various other things
    dw $C37C ; 21: = $07437C ; Light up the triforce and the screen
    dw $BD8B ; 22: = $073D8B ; Scrolls the credits, and number of deaths, etc.
    dw $C391 ; 23: = $074391
    dw $C3B8 ; 24: = $0743B8 ; ?????
    dw $C3D5 ; 25: = $0743D5
    dw $C41A ; 26: = $07441A
}

; ==============================================================================

; $07186E-$071888 JUMP LOCATION
Module_EndSequence:
{
    ; Beginning of Module 1A, Ending Sequence Mode
        
    REP #$20
        
    LDA.w #$0030 : STA $0FE0
    LDA.w #$01D0 : STA $0FE2
        
    STZ $0FE4
        
    SEP #$20
        
    ; Load the level 1 submodule index and used it to index into a jump table.
    LDA $11 : ASL A : TAX
        
    JSR ($9820, X) ; ($071820, X) that is.
        
    RTL
}
    
; $071889-$071890 LOCAL
{
    ; For overworld portions
    JSL $0285BA ; $0105BA IN ROM
    JSR $C303   ; $074303 IN ROM
        
    RTS
}
    
; $071891-$071898 LOCAL
{
    ; For dungeon portions
    JSL $0286FD     ; $0106FD IN ROM ; Module 1A's basecamp in Bank02
    JSR $C303       ; $074303 IN ROM
}

; $071899-$0718B8 JUMP TABLE ; Seems to be prep functions
{
    dw $9CFE ; = $071CFE ; 
    dw $9D84 ; = $071D84 ; Priest recovers
    dw $9C27 ; = $071C27
    dw $9C2F ; = $071C2F
    dw $9CFE ; = $071CFE
    dw $9CFE ; = $071CFE
    dw $9C1A ; = $071C1A
    dw $9CCA ; = $071CCA
    dw $9CFE ; = $071CFE
    dw $9C5B ; = $071C5B
    dw $9D5C ; = $071D5C ; Venus, goddess of fairies
    dw $9D70 ; = $071D70
    dw $9CD1 ; = $071CD1 ; The Bug-Catching Kid
    dw $9CFE ; = $071CFE ; The Lost Old Man
    dw $9C92 ; = $071C92 ; The Forest Thief
    dw $9CB4 ; = $071CB4 ; And the Master Sword sleeps again... 
}

; $0718B9-$0718D7 LONG
{
    PHB : PHK : PLB
        
    LDX.b #$0F

    .loop

        JSL Sprite_ResetProperties
        
        STZ $0DD0, X
        STZ $0BE0, X
        STZ $0CAA, X
    DEX : BPL .loop
        
    LDA $11 : AND.b #$FE : TAX
        
    JSR ($9899, X)  ; ($071899, X THAT IS) SEE JUMP TABLE
        
    PLB
        
    RTL
}

; $071958-$0719A4 LOCAL
{
    PHB : PHK : PLB
        
    LDX.b #$0F
    
    .loop
    
        LDA $0DF0, X : BEQ .BRANCH_ALPHA
            DEC $0DF0, X
        
        .BRANCH_ALPHA
    DEX : BPL .loop
        
    LDA $11 : AND.b #$FE : TAX
        
    STZ $30
    STZ $31
        
    REP #$20
        
    LDA $C8
        
    CMP.w #$0040 : BCC .BRANCH_GAMMA
    AND.w #$0001 : BNE .BRANCH_GAMMA
        ; $0718D8, X THAT IS
        LDA $E8 : CMP $98D8, X : BEQ .BRANCH_DELTA
            ; // $071918, X THAT IS
            LDY $9918, X : STY $30
        
        .BRANCH_DELTA
    
        ; $0718F8, X THAT IS
        LDA $E2 : CMP $98F8, X : BEQ .BRANCH_GAMMA
            ; $071938, X THAT IS
            LDY $9938, X : STY $31
        
    .BRANCH_GAMMA
    
    REP #$20
        
    PHX
        
    JSL $0286B3 ; $0106B3 IN ROM
        
    PLX
        
    JSR ($99A5, X) ; ($0719A5, X THAT IS)
        
    JMP $9A2A ; $071A2A IN ROM
}

; ==============================================================================

; $0719A5-$0719C4 LOCAL JUMP TABLE ; Actual run time functions
{
    dw $9E9C ; = $071E9C ; Whew just one was a lot of work.
    dw $A9AD ; = $0729AD ; Priest recovers
    dw $A0E2 ; = $0720E2
    dw $A941 ; = $072941
    dw $9F53 ; = $071F53
    dw $A27C ; = $07227C
    dw $A74C ; = $07274C
    dw $A9D3 ; = $0729D3
    dw $A393 ; = $072393
    dw $AA91 ; = $072A91
    dw $A3C7 ; = $0723C7
    dw $A802 ; = $072802
    dw $A54F ; = $07254F
    dw $A358 ; = $072358
    dw $ABF5 ; = $072BF5
    dw $AD22 ; = $072D22
}

; $0719C5-$071A09 LOCAL
{
    ; Dungeon Engine for Ending sequence (module 1A)
        
    PHB : PHK : PLB
        
    LDX.b #$0F
    
    .BRANCH_BETA
    
        LDA $0DF0, X
        
        BEQ .BRANCH_ALPHA
            ; Countdown sprite timer
            DEC $0DF0, X
        
        .BRANCH_ALPHA
    DEX : BPL .BRANCH_BETA
        
    LDA $11 : AND.b #$FE : TAX
        
    REP #$20
        
    LDA $C8 : CMP.w #$0040 : BCC .BRANCH_GAMMA
              AND.w #$0001 : BNE .BRANCH_GAMMA
        LDA $E8 : CMP $98D8, X : BEQ .BRANCH_DELTA
            CLC : ADC $9918, X : STA $E8
        
        .BRANCH_DELTA
    
        LDA $E2 : CMP $98F8, X
        
        BEQ .BRANCH_GAMMA
            CLC : ADC $9938, Y : STA $E2
    
    .BRANCH_GAMMA
    
    SEP #$20
        
    JSR ($99A5, X) ; SEE JUMP TABLE AT $0719A5
    JMP $9A2A      ; $071A2A
}

; $071A2A-$071A75 JUMP LOCATION
{
    LDA $11 : AND.b #$FE : TAX
        
    REP #$20
        
    LDA $C8 : CMP $9A0A, X : SEP #$20 : BCC .BRANCH_ALPHA
        LDA $C8 : AND.b #$01 : BNE .BRANCH_BETA
            DEC $13 : BNE .BRANCH_BETA
        
            INC $11
        
            BRA .BRANCH_GAMMA
    
    .BRANCH_ALPHA
    
    LDA $C8 : AND.b #$01 : BNE .BRANCH_BETA
        LDA $13 : CMP.b #$0F : BEQ .BRANCH_BETA
            INC $13
    
    .BRANCH_BETA
    
    REP #$20
        
    INC $C8
        
    SEP #$20
    
    .BRANCH_GAMMA
    
    REP #$20
        
    LDA $E2 : STA $011E
    LDA $E8 : STA $0122
    LDA $E0 : STA $0120
    LDA $E6 : STA $0124
        
    SEP #$20
        
    PLB
        
    RTS
}

; $071C1A-$071C55 LOCAL
{
    LDA.b #$FF : STA $0DF0 : STA $0DF1 : STA $0DF2
        
    BRA .beta
    
    ; $071C27-$071C55 ALTERNATE ENTRY POINT
    
    LDA $AE62 : STA $0D46
        
    BRA .beta
    
    ; $071C2F ALTERNATE ENTRY POINT
    
    LDA.b #$16 : STA $0D95
        
    LDA $AE62 : STA $0D40
    LDA $AE61 : STA $0D41
        
    LDA.b #$01 : STA $0EB1
        
    LDY.b #$02
    
    .alpha
    
        LDA.b #$57 : STA $0E22, Y
        
        LDA.b #$31 : STA $0F52, Y
    DEY : BPL .alpha
    
    .beta
    
    BRA $071C90
}

; $071C56-$071C5A DATA [ ]
{
    db $00, $13, $26, $39, $4C
}

; $071C5B-$071D5B LOCAL
{
    LDY.b #$04
    
    .BRANCH_1
    
        LDA $9C56, Y : STA $0DF0, Y
        
        LDA.b #$00 : STA $0DD0, Y
    DEY : BPL .BRANCH_1
        
    LDA.b #$2E : STA $0E25
        
    LDY.b #$01
    
    .BRANCH_2
    
        LDA.b #$9F : STA $0E27, Y
        LDA.b #$A0 : STA $0E29, Y
        
        LDA.b #$01 : STA $0E47, Y : INC A : STA $0E49, Y
        LDA.b #$10 : STA $0E67, Y :         STA $0E69, Y
    DEY : BPL .BRANCH_2
    
    ; $071690 EXTERNAL BRANCH POINT
    
    BRA .BRANCH_5
    
    ; $071C92 ALTERNATIVE ENTRY POINT
    
    LDA $AE62 : STA $0D45
    LDA $AE61 : STA $0D46
        
    LDA.b #$01 : STA $0EB6
    LDA.b #$08 : STA $0D90
        
    LDY.b #$03
    
    .BRANCH_3
    
        LDA.b #$04 : STA $0D41, Y
    DEY : BPL .BRANCH_3
        
    BRA .BRANCH_5
    
    ; 71CB4 ALTERNATIVE ENTRY POINT
    
    LDA.b #$02 : STA $0DB4
    LDA.b #$08 : STA $0D45
    LDA.b #$13 : STA $0DF1
        
    LDA.b #$40 : STA $0DF4
        
    BRA .BRANCH_5
    
    ; $071CCA ALTERNATIVE ENTRY POINT
    
    LDA.b #$FF : STA $0DF1
        
    BRA .BRANCH_5
    
    ; $071CD1 ALTERNATIVE ENTRY POINT
    
    LDY.b #$01
    
    .BRANCH_4
    
        LDA.b #$39 : STA $0F53, Y
        LDA.b #$0B : STA $0E23, Y
        LDA.b #$10 : STA $0E63, Y
        LDA.b #$01 : STA $0E43, Y
    DEY : BPL .BRANCH_4
        
    LDA.b #$2A : STA $0E25
        
    LDA.b #$79 : STA $0E26
    LDA.b #$01 : STA $0D86
    LDA.b #$05 : STA $0F76
    
    ; $071CFE ALTERNATIVE ENTRY POINT
    .BRANCH_5
    
    LDA $9BCA, X : STA $04
    LDA $9BCB, X : STA $05
    LDA $9BEA, X : STA $06
    LDA $9BEB, X : STA $07
        
    TXA : LSR A : TAX
        
    LDA $9C0A, X : TAX
    
    .BRANCH_6
    
        TXA : ASL A : TAY
        
        REP #$20
        
        LDA.w #$FFFF : STA $0FBA
                       STA $0FB8
        
        LDA $040A : ASL A : XBA : AND.w #$0F00 : CLC : ADC ($04), Y : STA $00
        
        LDA $040A : LSR A : LSR A : XBA : AND.w #$0E00 : CLC : ADC ($06), Y : STA $02
        
        SEP #$20
        
        LDA $00 : STA $0D10
        LDA $01 : STA $0D30
        LDA $02 : STA $0D00
        LDA $03 : STA $0D20 
    DEX : BPL .BRANCH_6
        
    RTS
}

; $071D5C-$071DFF LOCAL
{
    LDA.b #$10 : STA $0DF1
    LDA.b #$20 : STA $0DF2
        
    LDA.b #$08 : STA $0F53 : STA $0F54
        
    BRA .BRANCH_1
    
    ; $071D70 ALTERNATE ENTRY POINT
    
    LDA.b #$79 : STA $0F54
    LDA.b #$39 : STA $0F55
        
    LDA.b #$01 : STA $0DE1
    LDA.b #$04 : STA $0D91
    
    .BRANCH_1
    ; $071D84 ALTERNATE ENTRY POINT
    
    REP #$20
        
    LDA $048E : LSR #3
        
    SEP #$20
        
    AND.b #$FE : STA $0FB1
        
    LDA $048E : AND.b #$0F : ASL A : STA $0FB0
        
    ; $071BCA, X THAT IS
    LDA $9BCA, X : STA $04
    LDA $9BCB, X : STA $05
    LDA $9BEA, X : STA $06
    LDA $9BEB, X : STA $07
        
    TXA : LSR A : TAX
        
    ; $071C0A in Rom. Number of sprites in ending sequence
    LDA $9C0A, X : TAX
    
    .BRANCH_2
    
        TXA : ASL A : TAY
        
        LDA $0FB1 : XBA
        
        LDA.b #$00
        
        REP #$20
        
        CLC : ADC ($06), Y : STA $02
        
        SEP #$20
        
        LDA $0FB0 : XBA
        
        LDA.b #$00
        
        REP #$20
        
        CLC : ADC ($04), Y : STA $00
        
        SEP #$20
        
        LDA $00 : STA $0D10, X
        LDA $01 : STA $0D30, X
        LDA $02 : STA $0D00, X
        LDA $03 : STA $0D20, X
        
    DEX : BPL .BRANCH_2
        
    RTS
}

; $071E9C-$071EE0 LOCAL
{
	PHX
	
	LDX.b #$0B

    .alpha

        LDA $9E90, X : STA $0F50, X
        
        LDA $9E84, X
        LDY $9E78, X
        
        JSR $A703 ; $072703 IN ROM
	DEX : CPX.b #$07 : BNE .alpha

    .beta

        LDA $1A : ASL #2 : AND.b #$40 : ORA $9E90, X : STA $0F50, X
        
        LDA $9E84, X
        LDY $9E78, X
        
        JSR $A703 ; $072703 IN ROM
	DEX : CPX.b #$01 : BNE .beta

    .gamma

        LDA $9E90, X : STA $0F50, X
        
        LDA $9E84, X
        LDY $9E78, X
        
        JSR $A703 ; $072703 IN ROM
    DEX : BPL .gamma
    
	PLX
	
	RTS
}

; $071F53-$071FBF LOCAL
{
    PHX
    
    LDY.b #$02
    
    LDA.b #$35 : STA $0F50, X
    
    LDA.b #$01
    LDY.b #$3C
    
    JSR $A703 ; $072703 IN ROM

    .BRANCH_BETA

        DEX
        
        LDA $0D50, X : DEC A : LSR A : AND.b #$40 : EOR.b #$72 : STA $0F50, X
        
        LDA $1A : LSR #3 : AND.b #$10 : STA $0DC0, X
        
        TXA : ASL A : TAY
        
        REP #$20
        
        LDA $C8 : CMP $9F2D, Y
        
        SEP #$20
        
        BCC .BRANCH_ALPHA
            LDA $0DF0, X : BNE .BRANCH_ALPHA
                LDY $0D90, X
                
                LDA $9F3B, Y : PHA : AND.b #$F8 : STA $0DF0, X
                
                PLA : AND.b #$07 : TAY
                
                LDA $9F33, Y : STA $0D40, X
                LDA $9F31, Y : STA $0D50, X
                
                INC $0D90, X
            
        .BRANCH_ALPHA

        LDA $9F2B, Y
        LDY $9F29, X
        
        JSR $A703   ; $072703 IN ROM
        JSR $A5FD   ; $0725FD IN ROM
        JSL Sprite_MoveLong
	DEX : BPL .BRANCH_BETA
    
	PLX
    
	RTS
}

; ==============================================================================

; $071FC0-$0720E1 DATA
{
    ; $071FC0
    dw -4,   1 : db $68, $0C, $00, $00
    dw  0,  -8 : db $40, $0C, $00, $02
    dw  0,   1 : db $42, $0C, $00, $02
        
    dw -4,   1 : db $78, $0C, $00, $00
    dw  0,  -8 : db $40, $0C, $00, $02
    dw  0,   1 : db $42, $0C, $00, $02
    
    ; $071FF0
    dw  8,   5 : db $79, $06, $00, $00
    dw  0, -10 : db $8E, $08, $00, $02
    dw  0,   0 : db $6E, $06, $00, $02
        
    dw  0, -10 : db $8E, $08, $00, $02
    dw  0, -10 : db $8E, $08, $00, $02
    dw  0,   0 : db $6E, $06, $00, $02
        
    dw  0,   0 : db $82, $08, $00, $02
    dw  0,   7 : db $4E, $0A, $00, $02
    dw  0,   0 : db $80, $48, $00, $02
        
    dw  0,   7 : db $4E, $0A, $00, $02
    dw  0,   0 : db $82, $08, $00, $02
    dw  0,   7 : db $4E, $0A, $00, $02
        
    ; \wtf Why the leftovers? Is this a mess up or intentional?
    dw  0,   0 : db $80, $08, $00, $02
    dw  0,   7 : db $4E, $0A, $00, $02
    
    ; $072060
    dw 11,  -3 : db $69, $08, $00, $00
    dw  0, -12 : db $04, $08, $00, $02
    dw  0,   0 : db $60, $08, $00, $02
        
    dw 10,  -3 : db $67, $08, $00, $00
    dw  0, -12 : db $04, $08, $00, $02
    dw  0,   0 : db $60, $08, $00, $02
    
    ; $072090
    dw -2,   1 : db $68, $08, $00, $00
    dw  0,  -8 : db $C0, $08, $00, $02
    dw  0,   0 : db $C2, $08, $00, $02
        
    dw -3,   1 : db $78, $08, $00, $00
    dw  0,  -8 : db $C0, $08, $00, $02
    dw  0,   0 : db $C2, $08, $00, $02
        
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
    ; \unused ?
    db 2, 2
    
    ; $0720DE
    db $20, $40
    
    ; $0720E0
    db 16, -16
        
    ; TODO: Finish naming these sublabels and the routine they belong to.
}

; ==============================================================================

; $0720E2-$072163 LOCAL
{
    PHX
        
    LDX.b #$06
        
    LDA $00001A : LSR #2 : AND.b #$01 : TAY
        
    ; Alternate the travel bird's graphics for flappage.
    LDA $A0DE, Y : STA $0AF4
        
    LDA $0D50, X : ROL A : ROR A : AND.b #$01 : TAY
        
    LDA $0D50, X : CLC : ADC $A0E0, X : LSR A : AND.b #$40 : ORA.b #$32 : STA $0F50, X
        
    LDA.b #$02
    LDY.b #$24
        
    JSR $A703 ; $072703 IN ROM
    JSR $AE63 ; $072E63 IN ROM
        
    DEX
        
    LDA.b #$31 : STA $0F50, X
        
    LDA $0DF0, X : BNE .BRANCH_ALPHA
        LDA $0D90, X : TAY
        
        EOR.b #$01 : STA $0D90, X
        
        LDA $A0D0, X : STA $0DF0, X
        
        LDA $0DC0, X : INC A : AND.b #$03 : STA $0DC0, X
    
    .BRANCH_ALPHA
    
    LDY.b #$26
    LDA.b #$02
        
    JSR $A703 ; $072703 IN ROM
        
    DEX
    
    .BRANCH_GAMMA
    
        LDA $1A : AND.b #$0F : BNE .BRANCH_BETA
            LDA $0DC0, X : EOR.b #$01 : STA $0DC0, X
        
        .BRANCH_BETA
    
        LDA.b #$31 : STA $0F50, X
        
        LDY $A0D2, X
        LDA $A0D7, X
        
        JSR $A703 ; $072703 IN ROM
        JSR $A5FD ; $0725FD IN ROM
    DEX : BPL .BRANCH_GAMMA
        
    PLX
        
    RTS
}

; ==============================================================================

; $072164-$07227B DATA
{
    ; TODO: Fill in data later and name routine / pool.
    dw $000A, $0008, $8A32, $0000, $000A, $0010, $8A22, $0000 
    dw $0000, $FFF6, $0800, $0200, $0000, $0000, $082C, $0200 
    dw $000A, $FFF2, $0A22, $0000, $000A, $FFFA, $0A32, $0000 
    dw $0000, $FFF6, $082A, $0200, $0000, $0000, $0828, $0200 
    dw $000A, $0010, $8A05, $0000, $000A, $0008, $8A15, $0000 
    dw $FFFC, $0002, $0A07, $0200, $0000, $FFF9, $0E00, $0200 
    dw $0000, $0001, $0E02, $0200, $000A, $FFEC, $0A05, $0000 
    dw $000A, $FFF4, $0A15, $0000, $FFF9, $0001, $4A07, $0200 
    dw $0000, $FFF9, $0E00, $0200, $0000, $0001, $0E02, $0200 
    dw $0000, $FFF9, $0E00, $0200, $0000, $0001, $4E02, $0200 
    dw $0000, $FFF8, $0E00, $0200, $0000, $0001, $0E02, $0200 
    dw $0000, $FFF7, $0E00, $0200, $0000, $0001, $0E02, $0200 
    dw $0000, $FFF9, $0E00, $0200, $0000, $0001, $0E02, $0200 
    dw $0000, $FFF9, $0E00, $0200, $0000, $0001, $4E02, $0200 
    dw $0000, $FFF8, $0E00, $0200, $0000, $0001, $4E02, $0200 
    dw $0000, $FFF7, $0E00, $0200, $0000, $0001, $4E02, $0200 
    dw $0000, $FFF9, $0E00, $0200, $0000, $0001, $4E02, $0200 
    dw $0400, $000A, $0224, $0E0A
}

; ==============================================================================

; $07227C-$0722F7 LOCAL
{
    PHX
        
    REP #$20
        
    LDA $C8 : CMP.w #$0200 : BNE .BRANCH_ALPHA
        LDY.b #$01
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    CMP.w #$0208 : BNE .BRANCH_GAMMA
        LDY.b #$2C
    
        .BRANCH_BETA
        
        STY $012E
    
    .BRANCH_GAMMA
    
    SEC : SBC.w #$0208 : CMP.w #$0030 : SEP #$20 : BCS .BRANCH_DELTA
        LDY.b #$02
        
        JSR $ACE5 ; $072CE5 IN ROM
    
    .BRANCH_DELTA
    
    LDX.b #$03
        
    REP #$20
        
    LDA $C8 : CMP.w #$0200 : SEP #$20 : BCS .BRANCH_EPSILON
        LDA.b #$01 : STA $0DC0, X
    
    .BRANCH_EPSILON
    
    LDA.b #$31 : STA $0F50, X
        
    LDA.b #$04
    LDY.b #$08
        
    JSR $A703 ; $072703 IN ROM
    JSR $A5FD ; $0725FD IN ROM
        
    LDA $0DC0, X : DEX : STA $0DC0, X : TAY
        
    STZ $0107
        
    LDA $A274, Y : STA $0108
        
    LDA.b #$30 : STA $0F50, X
        
    PHY : TYA : ASL A : TAY
        
    REP #$20
        
    LDA $A276, Y : STA $0100
        
    SEP #$20
        
    PLY
        
    LDA $A27A, Y : TAY
        
    LDA.b #$05
        
    JSR $A703 ; $072703 IN ROM
    JSR $A5FD ; $0725FD IN ROM
        
    PLX
        
    RTS
}

; $072358-$072392 LOCAL
{
    PHX
        
    LDX.b #$00
        
    REP #$20
        
    LDA $C8 : CMP.w #$0200
        
    SEP #$20 : BNE .BRANCH_ALPHA
        LDA.b #$FC : STA $0D50, X
    
    .BRANCH_ALPHA
    
    LDA $1A : AND.b #$10 : LSR #4 : STA $0DC0, X
        
    LDA $0D10, X : CMP.b #$38 : BNE .BRANCH_BETA
        STZ $0D50, X
        
        INC $0DC0, X : INC $0DC0, X
    
    .BRANCH_BETA
    
    LDA.b #$03
    LDY.b #$34
        
    JSR $A703   ; $072703 IN ROM
    JSL Sprite_MoveLong
        
    PLX
        
    RTS
}

; $072393-$0723C6 LOCAL
{
    PHX
        
    LDX.b #$00
        
    LDA.b #$2C : STA $0E20, X
        
    LDA.b #$2C : JSL OAM_AllocateFromRegionA
        
    LDA.b #$3B : STA $0F50, X
        
    JSL Sprite_Get_16_bit_CoordsLong
        
    LDA.b #$02
        
    REP #$10
        
    LDY $C8 : CPY.w #$01C0 : SEP #$10 : BCS .BRANCH_ALPHA
        TYA : AND.b #$20
        
        ASL #3 : ROL A
    
    .BRANCH_ALPHA
    
    STA $0DC0, X
        
    JSL SpriteActive_MainLong
        
    PLX
        
    RTS
}

; $0723C7-$07242C LOCAL
{
    PHX
        
    LDX.b #$05
        
    JSL Sprite_Get_16_bit_CoordsLong
        
    LDA $0F00, X : BNE .BRANCH_ALPHA 
        JSL GetRandomInt : AND.b #$07 : TAX
            
        LDA $06C309, X : CLC : ADC $0FD8 : PHA
            
        JSL GetRandomInt : AND.b #$07 : TAX
            
        LDA $06C311, X : CLC : ADC $0FDA
        
        PLX
        
        LDY.b #$03
        
        JSR $ACE5   ; $072CE5 IN ROM
    
    .BRANCH_ALPHA
    
    LDX.b #$03
    
    .BRANCH_GAMMA
    
        LDA $0E00, X : BEQ .BRANCH_BETA
            DEC $0E00, X
        
        .BRANCH_BETA
    
        LDA.b #$E3 : STA $0E20, X
        
        LDA.b #$01
        
        JSR $ACA2 ; $072CA2 IN ROM
        JSR $A692 ; $072692 IN ROM
    INX : CPX.b #$05 : BNE .BRANCH_GAMMA
        
    LDA.b #$72 : STA $0E20, X
    LDA.b #$3B : STA $0F50, X
    LDA.b #$09 : STA $0DD0, X : STA $0DA0, X
        
    LDA.b #$30
        
    JSR $A6B3   ; $0726B3 IN ROM
        
    PLX
        
    RTS
}

; $07254F-$0725F7 LOCAL
{
    PHX
        
    LDX.b #$06
        
    LDA $1A : AND.b #$01 : STA $0DC0, X : BNE .BRANCH_ALPHA
        LDA.b #$01
            
        LDY $D010, X : CPY.b #$80 : BMI .BRANCH_BETA
            LDA.b #$FF
        
        .BRANCH_BETA
    
        CLC : ADC $0D50, X : STA $0D50, X
        
        LDA.b #$01
        
        LDY $0D00, X : CPY.b #$B0 : BMI .BRANCH_GAMMA
            LDA.b #$FF
        
        .BRANCH_GAMMA
    
        CLC : ADC $0D40, X : STA $0D40, X
        
        JSL Sprite_MoveLong
    
    .BRANCH_ALPHA
    
    LDA $0D50, X : LSR A : AND.b #$40 : EOR.b #$7E : STA $0F50, X
        
    LDA.b #$01 : STA $0E40, X
    LDA.b #$30 : STA $0E60, X
    LDA.b #$10 : STA $0F70, X
        
    JSR $A6B1 ; $0726B1 IN ROM
        
    DEX
        
    LDA.b #$37 : STA $0F50, X
        
    LDA.b #$02
        
    JSR $ACA2 ; $072CA2 IN ROM
        
    LDA.b #$0C
        
    JSR $A694 ; $072694 IN ROM
        
    DEX
        
    JSR $A692 ; $072692 IN ROM
        
    DEX
        
    JSR $A692 ; $072692 IN ROM
        
    DEX
    
    .BRANCH_KAPPA
    
        TXA : ASL A : TAY
        
        LDA $A53D, X
        
        JSR $A703 ; $072703 IN ROM
        
        TXA : BNE .BRANCH_DELTA
            JSR $A643 ; $072643 IN ROM
            
            BRA .BRANCH_EPSILON
    
        .BRANCH_DELTA
    
        LSR A : BEQ .BRANCH_ZETA
            LDA $1A : LSR #3 : AND.b #$01 : STA $0DC0, X
            
            BRA .BRANCH_THETA
    
        .BRANCH_ZETA
    
        LDY.b #$00
        
        LDA $1A : AND.b #$1F : CMP.b #$0F : BCS .BRANCH_IOTA
            TAY
            
            LDA $A540, Y : STA $0F70, X
            
            LDY.b #$01
    
        .BRANCH_IOTA
    
        TYA : STA $0DC0, X
        
        JSR $A5F8 ; $0725F8 IN ROM
    
        .BRANCH_THETA
    DEX : BPL .BRANCH_KAPPA
        
    PLX
        
    RTS
}

; $0725F8-$07260C LOCAL
{
    LDA.b #$30
    
    ; $0725FA ALTERNATE ENTRY POINT
    
    STA $0F50, X
    
    ; $0725FD ALTERNATE ENTRY POINT
    
    LDA.b #$00
        
    JSR $ACA2 ; $072CA2 IN ROM
        
    LDA.b #$04 : JSL OAM_AllocateFromRegionA
        
    JSL Sprite_DrawShadowLong
        
    RTS
}

; ==============================================================================

; $07260D-$072642 DATA
{
    ; TODO: Name this routine / pool.
    db $0A, $0A, $0A, $0A, $14, $08, $08, $00
    db $FF, $0C, $0C, $0C, $0C, $0C, $0C, $1E
    db $08, $04, $04, $04, $00, $00, $FF, $FF
    db $90, $04, $00, $00, $01, $00, $01, $00
    db $02, $03, $00, $02, $00, $01, $00, $01
    db $00, $01, $02, $03, $04, $05, $06, $03
    db $00, $FF, $FF, $FF, $02, $03
}

; ==============================================================================

; $072643-$072691 LOCAL
{
    LDA.b #$30
    
    ; $072645 ALTERNATE ENTRY POINT
    
    JSR $A5FA ; $0725FA IN ROM
        
    LDY $0D90, X
        
    LDA $0DF0, X : BNE .BRANCH_ALPHA
        INY : CPY.b #$08 : BNE .BRANCH_BETA
            LDY.b #$06
    
        .BRANCH_BETA
    
        CPY.b #$16 : BNE .BRANCH_GAMMA
            LDY.b #$15
    
        .BRANCH_GAMMA
    
        CPY.b #$1C : BNE .BRANCH_DELTA
            LDY.b #$1B
    
        .BRANCH_DELTA
    
        TYA : STA $0D90, X
        
        LDA $A60C, X : STA $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA $A627, X : BPL .BRANCH_EPSILON
        LDA $1A : AND.b #$08 : LSR #3
    
    .BRANCH_EPSILON
    
    STA $0DC0, X
        
    CPY.b #$05 : BCC .BRANCH_ZETA
    CPY.b #$0A : BCC .BRANCH_THETA
    CPY.b #$0F : BCS .BRANCH_THETA
        .BRANCH_ZETA
    
        LDA $1A : AND.b #$01 : BNE .BRANCH_THETA
            INC $0D00, X
    
    .BRANCH_THETA
    
    RTS
}

; $072692-$0726B0 LOCAL
{
    LDA.b #$08
    
    ; $072694 ALTERNATE ENTRY POINT
    
    STX $0FA0
        
    JSL OAM_AllocateFromRegionA
    JSR Sprite_Get_16_bit_CoordsLong
        
    LDA $11 : PHA
        
    STZ $11
        
    LDA.b #$09 : STA $0DD0, X
        
    JSL SpriteActive_MainLong
        
    PLA : STA $11
        
    RTS
}

; $0726B1-$0726C2 LOCAL
{
    LDA.b #$08
    
    ; $0726B3 ALTERNATE ENTRY POINT
    
    JSL OAM_AllocateFromRegionA
        
    STX $0FA0
        
    JSL Sprite_Get_16_bit_CoordsLong
    JSL SpriteActive_MainLong
        
    RTS
}

; ==============================================================================

; $0726C3-$072702 DATA
{
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

; $072703-$07273C LOCAL
{
    ; \param A number of oam entries to allocate for and to draw.
    ; \param Y Index into above pointer table to use for drawing oam
    ; entries.
    
    PHA : PHY
    
    PHA : ASL #2 : JSL OAM_AllocateFromRegionA
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    PLA : STA $4202
    
    LDA.b #$08 : STA $4203
    
    ; \optimize Are they seriously using the multiplication registers to
    ; multiply by 8? Rather than just shifting left three times in 16-bit
    ; mode...
    NOP #4
    
    LDA $4216 : STA $4202
    
    ; This part I can understand as it's variable, potentially.
    LDA $0DC0, X : STA $4203
    
    REP #$20
    
    PLY
    
    LDA $A6C3, Y : CLC : ADC $4216, Y : STA $08
    
    SEP #$20
    
    PHA
    
    JSL Sprite_DrawMultiple
    
    RTS
}

; ==============================================================================

; $07274C-$072799 LOCAL
{
    PHX
    
    TXA : LSR A : TAX
    
    LDA $9C0A, X : TAX

    .BRANCH_GAMMA

        STX $0FA0
        
        LDA $A73D, X : STA $0E20, X
        
        LDA $A740, X : JSL OAM_AllocateFromRegionA
        
        LDA $A743, X : STA $0D80, X
        
        TXY
        
        REP #$20
        
        LDA $C8 : CMP.w #$026F : BNE .BRANCH_ALPHA
            PHY
            
            LDY.b #$21 : STY $012F ; SOUND EFFECT BEING PLAYED
            
            PLY

        .BRANCH_ALPHA

        SEP #$20 : BCC .BRANCH_BETA
            INY #3

        .BRANCH_BETA

        LDA $A746, Y : STA $0DC0, X
        
        LDA.b #$33 : STA $0F50, X
        
        JSL Sprite_Get_16_bit_CoordsLong
        JSL SpriteActive_MainLong
    DEX : BPL .BRANCH_GAMMA
    
    PLX
    
    RTS
}

; $072802-$072887 LOCAL
{
    PHX
    
    LDX.b #$00
    
    REP #$20
    
    LDA $C8 : CMP.w #$0170 : SEP #$20 : BCC .BRANCH_ALPHA
        LDX.b #$04

        .BRANCH_BETA

            LDA.b #$01
            LDY.b #$3E
            
            JSR $A703 ; $072703 IN ROM
        INX : CPX.b #$06 : BNE .BRANCH_BETA
        
        LDX.b #$00
        
        LDA.b #$39 : STA $0F50, X
        
        REP #$20
        
        LDA $C8 : CMP.w #$01C0 : SEP #$20 : BCS .BRANCH_GAMMA
            LDA.b #$02
            
            BRA .BRANCH_DELTA

        .BRANCH_GAMMA

        LDA $0DF0, X : BNE .BRANCH_EPSILON
            LDA.b #$20 : STA $0DF0, X
            
            LDA $0DC0, X : EOR.b #$01 : AND.b #$01

            .BRANCH_DELTA

            STA $0DC0, X

        .BRANCH_EPSILON

        LDA.b #$04
        LDY.b #$06
        
        JSR $A703 ; $072703 IN ROM
        
        PLX
        
        RTS

    .BRANCH_ALPHA

    .loop

        LDA #$1A : STA $0E20, X
        
        LDA.b #$39 : STA $0F50, X
        
        LDA.b #$02
        
        JSR $ACA2 ; $072CA2 IN ROM
        
        LDA $10 : PHA
        
        LDA.b #$0C
        
        JSR $A694 ; $072694 IN ROM
        
        PLA : STA $10
        
        LDA $0DA0, X : CMP.b #$0F : BNE .BRANCH_ZETA
            LDA $0D90, X : CMP.b #$04 : BNE .BRANCH_ZETA
                LDA.b #$0F : STA $0DF2, X

        .BRANCH_ZETA

        JSR $A8C8 ; $0728C8 IN ROM
    INX : CPX.b #$02 : BNE .loop
    
    PLX
    
    RTS
}

; $0728C8-$0728E4 LOCAL
{
    PHX
        
    INX #2
        
    LDA $0DF0, X
        
    BEQ .BRANCH_ALPHA
        TAY
        
        LDA.b #$02 : STA $0F50, X
        
        LDA $A8B8, Y : STA $0DC0, X
        
        LDA.b #$02
        LDY.b #$36
        
        JSR $A703 ; $072703 IN ROM
    
    .BRANCH_ALPHA
    
    PLX
        
    RTS
}

; $072941-$072994 LOCAL
{
    PHX
        
    LDX.b #$00
    
    .BRANCH_GAMMA
    
        CPX.b #$02 : BCS .BRANCH_ALPHA
            LDA.b #$01 : STA $0E20, X
            LDA.b #$0B : STA $0F50, X
            
            LDA.b #$02
            
            JSR $ACA2 ; $072CA2 IN ROM
            
            LDA.b #$30 : STA $0F70, X
            
            LDA $1A : CLC : ADC $A95F, X : LSR #2 : AND.b #$03 : TAY
            
            LDA $A93D, Y : STA $0DC0, X
            
            JSR $AE63 ; $072E63 IN ROM
            
            LDA.b #$0C
            
            JSR $A6B3 ; $0726B3 IN ROM
            
            BRA .BRANCH_BETA
    
        .BRANCH_ALPHA
    
        LDA.b #$10
        
        JSR $A6B3 ; $0726B3 IN ROM
    
        .BRANCH_BETA
    INX : CPX.b #$05 : BCC .BRANCH_GAMMA
        
    LDA.b #$02
    LDY.b #$38
        
    JSR $A703 ; $072703 IN ROM
    JSR $A643 ; $072643 IN ROM
        
    INX
        
    LDA.b #$03
    LDY.b #$3A
        
    JSR $A703 ; $072703 IN ROM
        
    PLX
        
    RTS
}

; $0729AD-$0729D0 LONG
{
    PHX
        
    LDX.b #$00
    LDY.b #$0C
    LDA.b #$03
        
    JSR $A703 ; $072703 IN ROM
    JSR $A5F8 ; $0725F8 IN ROM
        
    INX
        
    ; Put the Priest in the ending sanctuary
    LDA.b #$73 : STA $0E20, X
    LDA.b #$27 : STA $0F50, X
    LDA.b #$02 : STA $0E90, X
        
    LDA.b #$10
        
    JSR $A6B3 ; $0726B3 IN ROM ; Keep sprites alive?
        
    PLX
        
    RTS
}

; ==============================================================================

; $0729D1-$0729D2 DATA
{
    .animation_step_amounts
    db  1, -1
}

; ==============================================================================

; $0729D3-$072A52 LOCAL
{
    PHX
        
    LDX.b #$01
    LDA.b #$02
        
    JSR $ACA2 ; $072CA2 IN ROM
        
    LDA.b #$E9 : STA $0E20, X
        
    LDA.b #$0C : JSL OAM_AllocateFromRegionA
        
    LDA.b #$37 : STA $0F50, X
        
    JSL Sprite_Get_16_bit_CoordsLong
        
    LDA $1A : AND.b #$0F : BNE .BRANCH_ALPHA
        LDA $0DC0, X : EOR.b #$01 : STA $0DC0, X
    
    .BRANCH_ALPHA
    
    JSL SpriteActive_MainLong
        
    REP #$20
        
    LDA $C8 : CMP.w #$0180 : SEP #$20 : BCC .BRANCH_BETA
        LDA.b #$04 : STA $0D40, X
        
        LDA $0D00, X : CMP.b #$7C : BEQ .BRANCH_BETA
            JSL Sprite_MoveLong
    
    .BRANCH_BETA
    
    DEX
        
    LDA.b #$36 : STA $0E20, X
        
    LDA.b #$18 : JSL OAM_AllocateFromRegionA
        
    LDA.b #$39 : STA $0F50, X
        
    JSL Sprite_Get_16_bit_CoordsLong
        
    LDA $0DF0, X : BNE .BRANCH_GAMMA
        LDA.b #$04 : STA $0DF0, X
        
        LDA $C9 : LSR A : AND.b #$01 : TAY
        
        LDA $0DC0, X : CLC : ADC .animation_step_amounts, Y : AND.b #$07 : STA $0DC0, X
    
    .BRANCH_GAMMA
    
    JSL SpriteActive_MainLong
        
    PLX
        
    RTS
}

; ==============================================================================

; $072A53-$072A90 DATA
{
    ; TODO: Data seems unused for the moment... except for:
    
    .oam_groups
    dw -16, -24 : db $04, $37, $00, $02
    dw -16, -16 : db $64, $37, $00, $02
    dw -16, -24 : db $62, $37, $00, $02
    dw -16, -16 : db $64, $37, $00, $02
    dw   0, -19 : db $AF, $39, $00, $00
    
    ; $072A7B
    db 1, -1
        
    ; $072A7D
    ; up to the end maybe?
    ; TODO: label this.
    db $0E, $10, $12, $14, $30, $14, $14, $08
    db $08, $0C, $0C, $37, $37, $3B, $3D, $00
    db $01, $00, $01
}

; ==============================================================================

; $072A91-$072B44 LOCAL
{
    PHX
        
    LDX.b #$00
    
    .BRANCH_DELTA
    
        LDA $0DF0, X : BNE .delay
            ; \bug
            ; This seems like.... a mistake.
            ; Writing 0x60 into $0DD0 could possibly cause a crash.
            LDA.b #$60 : STA $0DF0, X
                         STA $0DD0, X
            
            STZ $0D50, X
            
            LDA.b #$EE : STA $0D10, X
            LDA.b #$04 : STA $0D30, X
            
            LDA.b #$18 : STA $0D00, X
            LDA.b #$0B : STA $0D20, X
    
        .delay
    
        LDA $0DD0, X : BEQ .BRANCH_BETA
            LDA.b #$F8 : STA $0D40, X
            
            JSL Sprite_MoveLong
            
            LDA $1A : LSR A : BCS .BRANCH_GAMMA
                STX $00
                
                LDA $1A : LSR #5 : EOR $00 : AND.b #$01 : TAY
                
                LDA $0D50, X : CLC : ADC.b #$7B : TAX : STA $0D50, X
        
            .BRANCH_GAMMA
        
            LDY.b #$10
            LDA.b #$01
            
            JSR $A703 ; $072703 IN ROM
    
        .BRANCH_BETA
    INX : CPX.b #$05 : BCC .BRANCH_DELTA
    
    .BRANCH_IOTA
    
        LDY $0D90, X
        
        LDA $0DF0, X : BNE .BRANCH_EPSILON
            LDA $AA7D, Y : CPX.b #$05 : BEQ .BRANCH_ZETA
                LDA $AA81, Y
        
            .BRANCH_ZETA
        
            STA $0DF0, X
            
            TYA : INC A : AND.b #$03 : STA $0D90, X
            
            LDA $0DC0, X : EOR.b #$01 : STA $0DC0, X
    
        .BRANCH_EPSILON
    
        CPX.b #$05 : BNE .BRANCH_THETA
            LDA.b #$31 : STA $0F50, X
            
            LDA.b #$10
            
            JSR $A6B3 ; $0726B3 IN ROM
            
            INX
        
    BRA .BRANCH_IOTA
    
    .BRANCH_THETA
    
    LDX.b #$12
    LDA.b #$02
        
    JSR $A703 ; $072703 IN ROM
        
    INX
    
    .BRANCH_KAPPA
    
        LDA $AA82, X : STA $0F50, X
        LDA $AA86, X : STA $0DE0, X
        
        LDA $AA7E, X
        
        JSR $A694   ; $072694 IN ROM
    INX : CPX.b #$0B : BCC .BRANCH_KAPPA
        
    PLX
        
    RTS
}

; ==============================================================================

; $072B45-$072BF4 DATA
{
    .oam_groups
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
    
    ; $072BEC
    
    ; \unused TODO: Find out if really unused.
    db $00, $01, $00, $02, $08, $20, $20, $08    
}

; ==============================================================================

; $072BF5-$072CA1 LOCAL
{
    PHX
        
    LDX.b #$06
    
    ; $072BF8 ALTERNATE ENTRY POINT
    
    CPX.b #$05 : BCC .BRANCH_ALPHA
        LDA.b #$00 : STA $0E20, X
        
        LDA.b #$01
        
        JSR $ACA2 ; $072CA2 IN ROM
        
        LDA $1A : CLC : ADC $AC09, X : AND.b #$08 : LSR #3 : STA $0DC0, X
        
        LDA.b #$20 : STA $0F70, X
        
        JSR $AE63 ; $072E63 IN ROM
        
        LDA $0D50, X : LSR A : AND.b #$40 : EOR.b #$0F : STA $0F50, X
        
        LDA.b #$08
        
        JSR $A6B3 ; $0726B3 IN ROM
        
        BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b #$0D : STA $0E20, X
        
    CPX.b #$01 : BNE .BRANCH_GAMMA
        STA $0EB0, X
    
    .BRANCH_GAMMA
    
    LDA.b #$03
        
    JSR $ACA2 ; $072CA2 IN ROM
        
    LDA.b #$2B : STA $0F50, X
        
    LDA $0DF0, X : BNE .BRANCH_DELTA
        LDA.b #$C0 : STA $0DF0, X
    
    .BRANCH_DELTA
    
    LSR A : BNE .BRANCH_EPSILON
        STA $0D40, X
        
        BRA .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    CMP $ABF0, X : BCS .BRANCH_THETA
        LDA $1A : AND.b #$03 : BNE .BRANCH_THETA
            LDA $0D40, X : BEQ .BRANCH_THETA
                DEC A : STA $0D40, X
                
                CLC : ADC.b #$FC
                
                CPX.b #$03 : BCS .BRANCH_ZETA
                    EOR.b #$FF : INC A
                
                .BRANCH_ZETA
            
                STA $0D50, X
    
    .BRANCH_THETA
    
    JSL Sprite_MoveLong
        
    LDA $1A : LSR #3 : AND.b #$03 : TAY
        
    LDA $ABED, Y : STA $0DC0, X
        
    LDA.b #$10
        
    JSR $A6B3   ; $0726B3 IN ROM
    
    .BRANCH_BETA
    
    DEX : BEQ .BRANCH_IOTA
        JMP $ABF8   ; $072BF8 IN ROM
    
    .BRANCH_IOTA
    
    LDY.b #$18
    LDA.b #$03
        
    JSR $A703   ; $072703 IN ROM
        
    LDA.b #$20
        
    JSR $A645   ; $072645 IN ROM
        
    PLX
        
    RTS
}

; $072CA2-$072CAA LOCAL
{
    STA $0E40, X
        
    LDA.b #$10 : STA $0E60, X
        
    RTS
}

; $072CE5-$072D21 LOCAL
{
    STX $00
    STA $02
    STY $0DB0
        
    LDX.b #$00
    
    .BRANCH_DELTA
    
        LDY $0DC0, X
        
        LDA $0DF0, X : BNE .BRANCH_ALPHA
            INY : CPY.b #$06 : BCC .BRANCH_BETA
                LDA $00 : STA $0D10, X
                LDA $02 : STA $0D00, X
                
                LDY.b #$00
            
            .BRANCH_BETA
        
            TYA : STA $0DC0, X
            
            LDA $ACD7, Y : STA $0DF0, X
        
        .BRANCH_ALPHA
    
        TYA : BEQ .BRANCH_GAMMA
            LDY.b #$1C
            LDA.b #$01
            
            JSR $A703   ; $072703 IN ROM
        
        .BRANCH_GAMMA
    INX : CPX $0DB0 : BCC .BRANCH_DELTA
        
    RTS
}

; $072D22-$072DBE LOCAL ; And the Master Sword sleeps again...
{
    PHX
        
    LDY $1A
        
    LDA $AD25, Y : AND.b #$03 : TAY
        
    LDX $ACDD, Y
        
    LDA $E1B9, Y
        
    LDY $02A0
        
    JSR $ACE5   ; $072CE5 IN ROM
        
    LDA.b #$62 : STA $0E20, X
    LDA.b #$39 : STA $0F50, X
        
    LDA.b #$18
        
    JSR $A6B3 ; $0726B3 IN ROM
        
    LDY.b #$01
    
    .BRANCH_ZETA
    
        INX
        
        LDA $0E00, X : 	BEQ .BRANCH_ALPHA
            DEC $0E00, X
    
        .BRANCH_ALPHA
    
        LDA $0D50, X : LSR A : AND.b #$40 : EOR $ACCB, Y : STA $0F50, X
        
        LDA $0DF0, X : BNE .BRANCH_BETA
            LDA.b #$80 : STA $0DF0, X
            
            STZ $0D90, X
    
        .BRANCH_BETA
    
        LDA $0D90, X : BNE .BRANCH_GAMMA
            LDA $1A : LSR #2 : AND.b #$01 : INC #2 : STA $0DC0, X
            
            PHY
            
            JSR $AE35   ; $072E35 IN ROM
            
            PLY
            
            BRA .BRANCH_DELTA
    
        .BRANCH_GAMMA
    
        LDA $0E00, X : BNE .BRANCH_DELTA
            LDA $0DA0, X : CMP.b #$08 : BNE .BRANCH_EPSILON
                STZ $0DA0, X
        
            .BRANCH_EPSILON
        
            PHY
            
            LDA $0DA0, X : AND.b #$07 : TAY
            
            LDA $AFCF, Y : STA $0E00, X
            
            PLY
            
            LDA $0DC0, X : AND.b #$01 : EOR.b #$01 : STA $0DC0, X
            
            INC $0DA0, X
    
        .BRANCH_DELTA
    
        PHY
        
        LDA.b #$01
        LDY.b #$14
        
        JSR $A703   ; $072703 IN ROM
        JSR $A5FD   ; $0725FD IN ROM
    PLY : DEY : BPL .BRANCH_ZETA
        
    INX
        
    JSR $ADF7   ; $072DF7 IN ROM
        
    PLX
        
    RTS
}

; $072DF7-$072E2C LOCAL
{
    LDA $0DF0, X : BNE .BRANCH_ALPHA
        LDA $0DC0, X : INC A : AND.b #$07 : STA $0DC0, X
        
        LDA.b #$04 : STA $0DF0, X
    
    .BRANCH_ALPHA
    
    LDA $0DC0, X : ASL A : TAY
        
    REP #$20
        
    LDA $ADE7, Y : STA $0100
        
    SEP #$20
        
    LDA.b #$20 : STA $0F50, X
        
    LDA.b #$02
    LDY.b #$1A
        
    JSR $A703   ; $072703 IN ROM
    JSR $A5FD   ; $0725FD IN ROM
    JSL Sprite_MoveLong
        
    RTS
}

; ==============================================================================

; $072E2D-$072E34 DATA
{
    .x_speeds
    db  32,  24, -32, -24
    
    .y_speeds
    db   8,  -8,  -8,   8
}

; ==============================================================================

; $072E35-$072E5C LOCAL
{
    LDA $0DF0, X : CMP.b #$40 : BCS .delay
        LDA $0DB0, X : INC A : AND.b #$03 : STA $0DB0, X
        
        INC $0D90, X
        
        RTS
    
    .delay
    
    LDY $0DB0, X
        
    LDA .x_speeds, Y : STA $0D50, X
        
    LDA .y_speeds, Y : STA $0D40, X
        
    JSL Sprite_MoveLong
        
    RTS
}

; ==============================================================================

; $072E5D-$072E62 DATA
{
    .acceleration
    db 1, -1
    
    .x_speed_limits
    db 32, -32
    
    .y_speed_limits
    db 16, -16
}

; ==============================================================================

; $072E63-$072E9D LOCAL
{
    LDA $0DE0, X : AND.b #$01 : TAY
        
    LDA $0D50, X : CLC : ADC .acceleration, X : STA $0D50, X
        
    CMP .x_speed_limits, Y : BNE .anotoggle_x_acceleration
        INC $0DE0, X
    
    .anotoggle_x_direction
    
    LDA $1A : AND.b #$01 : BNE .delay
        LDA $0EB0, X : AND.b #$01 : TAY
        
        LDA $0D40, X : CLC : ADC .acceleration, X : STA $0D40, X
        
        CMP y_speed_limits, Y : BNE .anotoggle_y_acceleration
            INC $0EB0, X

        .anotoggle_y_acceleration
    .delay

    JSL Sprite_MoveLong
        
    RTS
}

; ==============================================================================

; $072E9E-$072EA5 DATA
{
    .flags
    dw $0008, $0004, $0002, $0001
}

; ==============================================================================

; $072EA6-$072FF1 LONG
{
    PHB : PHK : PLB
        
    REP #$20
        
    LDA.w #$0001 : STA $00
        
    LDA $30 : AND.w #$00FF : BNE .BRANCH_ALPHA
        JMP $AF1E   ; $072F1E IN ROM
    
    .BRANCH_ALPHA
    
    CMP.w #$0080 : BCC .BRANCH_BETA
        EOR.w #$00FF : INC A
        
        DEC $00 : DEC $00
        
        STA $02
        
        LDY.b #$00
        
        BRA .BRANCH_GAMMA
    
    .BRANCH_BETA

    STA $02
        
    LDY.b #$02
    
    .BRANCH_GAMMA
    
    LDX.b #$06
        
    JSR $AFF2   ; $072FF2 IN ROM
        
    LDA $04 : STA $069E
        
    LDX $8C : CPX.b #$97 : BEQ .BRANCH_DELTA
              CPX.b #$9D : BEQ .BRANCH_DELTA
        LDA $04 : BEQ .BRANCH_DELTA
        
        STZ $00
        
        LSR A : ROR $00
        
        LDX $8C
        
        CPX.b #$B5 : BEQ .BRANCH_EPSILON
            CPX.b #$BE : BNE .BRANCH_ZETA
        
        .BRANCH_EPSILON
            LSR A : ROR $00
            
            CMP.w #$3000 : BCC .BRANCH_IOTA
                ORA.w #$F000
                
                BRA .BRANCH_IOTA
    
        .BRANCH_ZETA
    
        CMP.w #$7000 : BCC .BRANCH_IOTA
            ORA.w #$F000
        
        .BRANCH_IOTA
    
        STA $06
        
        LDA $0622 : CLC : ADC $00 : STA $0622
        
        LDA $E6 : ADC $06 : STA $E6
    
    ; $072F1E ALTERNATE ENTRY POINT
    .BRANCH_DELTA
    
    LDA.w #$0001 : STA $00
        
    LDA $31 : AND.w #$00FF : BNE .BRANCH_THETA
        JMP $AF91   ; $072F91 IN ROM
    
    .BRANCH_THETA
    
    CMP.w #$0080 : BCC .BRANCH_KAPPA
        EOR.w #$00FF : INC A
        
        DEC $00 : DEC $00
        
        STA $02
        
        LDY.b #$04
        
        BRA .BRANCH_LAMBDA
    
    .BRANCH_KAPPA
        STA $02
        
        LDY.b #$06
    
    .BRANCH_LAMBDA
    
    LDX.b #$00
        
    JSR $AFF2   ; $072FF2 IN ROM
        
    LDA $04 : STA $069F
        
    LDX $8C
        
    CPX.b #$97 : BEQ .BRANCH_MUNU
    CPX.b #$9D : BEQ .BRANCH_MUNU
        LDA $04 : BEQ .BRANCH_MUNU
        
        STZ $00
        
        LSR A : ROR $00
        
        LDX $8C
        
        CPX.b #$95 : BEQ .BRANCH_XI
            CPX.b #$9E : BNE .BRANCH_OMICRON
                .BRANCH_XI
    
                LSR A : ROR $00
                
                CMP.w #$3000 : BCC .BRANCH_PI
                
                ORA.w #$F000
                
                BRA .BRANCH_PI
        
        .BRANCH_OMICRON
    
        CMP.w #$7000 : BCC .BRANCH_PI
            ORA.w #$F000
    
        .BRANCH_PI
    
        STA $06
        
        LDA $0620 : CLC : ADC $00 : STA $0620
        LDA $E0         : ADC $06 : STA $E0
    
    ; $072F91 ALTERNATE ENTRY POINT
    .BRANCH_MUNU
    
    LDX $8C
        
    CPX.b #$9C : BEQ .BRANCH_RHO
        CPX.b #$97 : BEQ .BRANCH_SIGMA
            CPX.b #$9D : BNE .BRANCH_TAU
                .BRANCH_SIGMA
            
                LDA $0622 : CLC : ADC.w #$2000 : STA $0622
                LDA $E6         : ADC.w #$0000 : STA $E6
                LDA $0620 : CLC : ADC.w #$2000 : STA $0620
                LDA $E0         : ADC.w #$0000 : STA $E0
                
                BRA .BRANCH_TAU
    
    .BRANCH_RHO
    
    LDA $0622 : SEC : SBC.w #$2000 : STA $0622
        
    LDA $E6 : SEC : SBC.w #$0000 : CLC : ADC $069E : STA $E6
    LDA $E2                                  : STA $E0
    
    .BRANCH_TAU
    
    LDA $A0 : CMP.w #$0181 : BNE .BRANCH_UPSILON
        LDA $E8 : ORA.w #$0100 : STA $E6
        LDA $E2                : STA $E0
    
    .BRANCH_UPSILON
    
    SEP #$20
        
    PLB
        
    RTL
}

; $072FF2-$073037 LOCAL
{
    STZ $04
    STZ $06
    
    .BRANCH_ALPHA
    
        LDA $E2, X : CLC : ADC $00 : STA $E2, X
        
        INC $06
        
        LDA $04 : CLC : ADC $00 : STA $04
    DEC $02 : BNE .BRANCH_ALPHA
        
    TYA : ORA.w #$0002 : TAX
        
    LDA $0624, Y : CLC : ADC $06 : STA $0624, Y
        
    CMP.w #$0010 : BMI .BRANCH_BETA 
        SEC : SBC.w #$0010 : STA $0624, Y
            
        LDA .flags, Y : ORA $0416 : STA $0416
    
    .BRANCH_BETA
    
    LDA.w #$0000 : SEC : SBC $0624, Y : STA $0624, X
        
    RTS
}

; ==============================================================================

; $073038-$073C6C DATA
{
    ; TODO: Data needs to be filled in or supplied with a binary file,
    ; etc. Seems to be text data for the credits sequence? ; Correct.

    ; Tile format:
    ; vhopppcc cccccccc
    ; These are all the actual tiles themselves, all characters and their available color variants.
    .tileData
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
    dw $3C35, $3C36, $3C37, $3C38, $3C39, $3CB1, $3C7E, $3CA9 

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

    Credit00:
    db $07, $23
    table CreditsSmallGreen.txt
    db "EXECUTIVE PRODUCER"

    ; Blank line
    BlankRow:
    db $FF

    Credit01:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "HIROSHI YAMAUCHI"

    Credit02:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "HIROSHI YAMAUCHI"

    Credit03:
    db $0C, $0F
    table CreditsSmallYellow.txt
    db "PRODUCER"

    Credit04:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "SHIGERU MIYAMOTO"

    Credit05:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "SHIGERU MIYAMOTO"

    Credit06:
    db $0C, $0F
    table CreditsSmallRed.txt
    db "DIRECTOR"

    Credit07:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "TAKASHI TEZUKA"

    Credit08:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "TAKASHI TEZUKA"

    Credit09:
    db $09, $19
    table CreditsSmallGreen.txt
    db "SCRIPT WRITER"

    Credit0A:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "KENSUKE TANABE"

    Credit0B:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "KENSUKE TANABE"

    Credit0C:
    db $06, $25
    table CreditsSmallYellow.txt
    db "ASSISTANT DIRECTORS"

    Credit0D:
    db $07, $21
    table CreditsWhiteTop.txt
    db "YASUHISA YAMAMURA"

    Credit0E:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "YASUHISA YAMAMURA"

    Credit0F:
    db $09, $19
    table CreditsWhiteTop.txt
    db "YOICHI YAMADA"

    Credit10:
    db $09, $19
    table CreditsWhiteBottom.txt
    db "YOICHI YAMADA"

    Credit11:
    db $03, $31
    table CreditsSmallGreen.txt
    db "SCREEN GRAPHICS DESIGNERS"

    Credit12:
    db $08, $1F
    table CreditsSmallYellow.txt
    db "OBJECT DESIGNERS"

    Credit13:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "SOICHIRO TOMITA"

    Credit14:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "SOICHIRO TOMITA"

    Credit15:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "TAKAYA IMAMURA"

    Credit16:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "TAKAYA IMAMURA"

    Credit17:
    db $05, $29
    table CreditsSmallYellow.txt
    db "BACK GROUND DESIGNERS"

    Credit18:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "MASANAO ARIMOTO"

    Credit19:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "MASANAO ARIMOTO"

    Credit1A:
    db $07, $21
    table CreditsWhiteTop.txt
    db "TSUYOSHI WATANABE"

    Credit1B:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "TSUYOSHI WATANABE"

    Credit1C:
    db $08, $1F
    table CreditsSmallRed.txt
    db "PROGRAM DIRECTOR"

    Credit1D:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "TOSHIHIKO NAKAGO"

    Credit1E:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "TOSHIHIKO NAKAGO"

    Credit1F:
    db $08, $1D
    table CreditsSmallGreen.txt
    db "MAIN PROGRAMMER"

    Credit20:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YASUNARI SOEJIMA"

    Credit21:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YASUNARI SOEJIMA"

    Credit22:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "KAZUAKI MORITA"

    Credit23:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "KAZUAKI MORITA"

    Credit24:
    db $0A, $15
    table CreditsSmallYellow.txt
    db "PROGRAMMERS"

    Credit25:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "TATSUO NISHIYAMA"

    Credit26:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "TATSUO NISHIYAMA"

    Credit27:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "YUICHI YAMAMOTO"

    Credit28:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "YUICHI YAMAMOTO"

    Credit29:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YOSHIHIRO NOMOTO"

    Credit2A:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YOSHIHIRO NOMOTO"

    Credit2B:
    db $0B, $11
    table CreditsWhiteTop.txt
    db "EIJI NOTO"

    Credit2C:
    db $0B, $11
    table CreditsWhiteBottom.txt
    db "EIJI NOTO"

    Credit2D:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "SATORU TAKAHATA"

    Credit2E:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "SATORU TAKAHATA"

    Credit2F:
    db $09, $1B
    table CreditsSmallRed.txt
    db "SOUND COMPOSER"

    Credit30:
    db $0B, $13
    table CreditsWhiteTop.txt
    db "KOJI KONDO"

    Credit31:
    db $0B, $13
    table CreditsWhiteBottom.txt
    db "KOJI KONDO"

    Credit32:
    db $0A, $17
    table CreditsSmallGreen.txt
    db "COORDINATORS"

    Credit33:
    db $0B, $13
    table CreditsWhiteTop.txt
    db "KEIZO KATO"

    Credit34:
    db $0B, $13
    table CreditsWhiteBottom.txt
    db "KEIZO KATO"

    Credit35:
    db $0A, $19
    table CreditsWhiteTop.txt
    db "TAKAO SHIMIZU"

    Credit36:
    db $0A, $19
    table CreditsWhiteBottom.txt
    db "TAKAO SHIMIZU"

    Credit37:
    db $08, $1F
    table CreditsSmallYellow.txt
    db "PRINTED ART WORK"

    Credit38:
    db $09, $19
    table CreditsWhiteTop.txt
    db "YOICHI KOTABE"

    Credit39:
    db $09, $19
    table CreditsWhiteBottom.txt
    db "YOICHI KOTABE"

    Credit3A:
    db $0A, $17
    table CreditsWhiteTop.txt
    db "HIDEKI FUJII"

    Credit3B:
    db $0A, $17
    table CreditsWhiteBottom.txt
    db "HIDEKI FUJII"

    Credit3C:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YOSHIAKI KOIZUMI"

    Credit3D:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YOSHIAKI KOIZUMI"

    Credit3E:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "YASUHIRO SAKAI"

    Credit3F:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "YASUHIRO SAKAI"

    Credit40:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "TOMOAKI KUROUME"

    Credit41:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "TOMOAKI KUROUME"

    Credit42:
    db $07, $21
    table CreditsSmallRed.txt
    db "SPECIAL THANKS TO"

    Credit43:
    db $09, $19
    table CreditsWhiteTop.txt
    db "NOBUO OKAJIMA"

    Credit44:
    db $09, $19
    table CreditsWhiteBottom.txt
    db "NOBUO OKAJIMA"

    Credit45:
    db $07, $21
    table CreditsWhiteTop.txt
    db "YASUNORI TAKETANI"

    Credit46:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "YASUNORI TAKETANI"

    Credit47:
    db $0A, $17
    table CreditsWhiteTop.txt
    db "KIYOSHI KODA"

    Credit48:
    db $0A, $17
    table CreditsWhiteBottom.txt
    db "KIYOSHI KODA"

    Credit49:
    db $07, $23
    table CreditsWhiteTop.txt
    db "TAKAMITSU KUZUHARA"

    Credit4A:
    db $07, $23
    table CreditsWhiteBottom.txt
    db "TAKAMITSU KUZUHARA"

    Credit4B:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "HIRONOBU KAKUI"

    Credit4C:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "HIRONOBU KAKUI"

    Credit4D:
    db $07, $21
    table CreditsWhiteTop.txt
    db "SHIGEKI YAMASHIRO"

    Credit4E:
    db $07, $21
    table CreditsWhiteBottom.txt
    db "SHIGEKI YAMASHIRO"

    Credit4F:
    db $07, $21
    table CreditsSmallGreen.txt
    db "OBJECT PROGRAMMER"

    Credit50:
    db $09, $1B
    table CreditsWhiteTop.txt
    db "TOSHIO IWAWAKI"

    Credit51:
    db $09, $1B
    table CreditsWhiteBottom.txt
    db "TOSHIO IWAWAKI"

    Credit52:
    db $06, $25
    table CreditsWhiteTop.txt
    db "SHIGEHIRO KASAMATSU"

    Credit53:
    db $06, $25
    table CreditsWhiteBottom.txt
    db "SHIGEHIRO KASAMATSU"

    Credit54:
    db $0A, $19
    table CreditsWhiteTop.txt
    db "QUEST HISTORY"

    Credit55:
    db $0A, $19
    table CreditsWhiteBottom.txt
    db "QUEST HISTORY"

    Credit56:
    db $03, $33
    table CreditsSmallRed.txt
    db "LOCATION             GAMES"

    Credit57:
    db $04, $1F
    table CreditsSmallYellow.txt
    db "CASTLE OF HYRULE"

    Credit58:
    db $04, $1B
    table CreditsSmallGreen.txt
    db "CASTLE DUNGEON"

    Credit59:
    db $04, $15
    table CreditsSmallYellow.txt
    db "EAST PALACE"

    Credit5A:
    db $04, $19
    table CreditsSmallGreen.txt
    db "DESERT PALACE"

    Credit5B:
    db $04, $1B
    table CreditsSmallYellow.txt
    db "MOUNTAIN TOWER"

    Credit5C:
    db $08, $19
    table CreditsWhiteTop.txt
    db "1 DARK PALACE"

    Credit5D:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "1 DARK PALACE"

    Credit5E:
    db $08, $1B
    table CreditsWhiteTop.txt
    db "2 SWAMP PALACE"

    Credit5F:
    db $03, $25
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "2 SWAMP PALACE"

    Credit60:
    db $08, $19
    table CreditsWhiteTop.txt
    db "3 SKULL WOODS"

    Credit61:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "3 SKULL WOODS"

    Credit62:
    db $08, $1B
    table CreditsWhiteTop.txt
    db "4 THIEVES'TOWN"

    Credit63:
    db $03, $25
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "4 THIEVES'TOWN"

    Credit64:
    db $08, $17
    table CreditsWhiteTop.txt
    db "5 ICE PALACE"

    Credit65:
    db $03, $21
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "5 ICE PALACE"

    Credit66:
    db $08, $19
    table CreditsWhiteTop.txt
    db "6 MISERY MIRE"

    Credit67:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "6 MISERY MIRE"

    Credit68:
    db $08, $19
    table CreditsWhiteTop.txt
    db "7 TURTLE ROCK"

    Credit69:
    db $03, $23
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "7 TURTLE ROCK"

    Credit6A:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "8 GANON's TOWER"

    Credit6B:
    db $03, $27
    table CreditsSmallRed.txt
    db "LEVEL"
    table CreditsWhiteBottom.txt
    db "8 GANON's TOWER"

    Credit6C:
    db $04, $23
    table CreditsWhiteTop.txt
    db "TOTAL GAMES PLAYED"

    Credit6D:
    db $04, $23
    table CreditsWhiteBottom.txt
    db "TOTAL GAMES PLAYED"

    Credit6E:
    db $08, $1F
    table CreditsWhiteTop.txt
    db "YASUNARI NISHIDA"

    Credit6F:
    db $08, $1F
    table CreditsWhiteBottom.txt
    db "YASUNARI NISHIDA"

    Credit70:
    db $05, $2B
    table CreditsSmallYellow.txt
    db "ENGLISH SCRIPT WRITERS"

    Credit71:
    db $0A, $17
    table CreditsWhiteTop.txt
    db "DANIEL OWSEN"

    Credit72:
    db $0A, $17
    table CreditsWhiteBottom.txt
    db "DANIEL OWSEN"

    Credit73:
    db $08, $1D
    table CreditsWhiteTop.txt
    db "HIROYUKI YAMADA"
    
    Credit74:
    db $08, $1D
    table CreditsWhiteBottom.txt
    db "HIROYUKI YAMADA"

    warnpc $0EB93D

    ;$07393D-$073C50 DATA
    org $0EB93D
    .linePointers
    dw #Credit00-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit01-#ST, #Credit02-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit03-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit04-#ST, #Credit05-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit06-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit07-#ST, #Credit08-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit09-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit0A-#ST, #Credit0B-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit0C-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit0D-#ST, #Credit0E-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit0F-#ST, #Credit10-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit11-#ST, #BlankRow-#ST, #Credit12-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit13-#ST, #Credit14-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit15-#ST, #Credit16-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit17-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit18-#ST, #Credit19-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit1A-#ST, #Credit1B-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit1V-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit1D-#ST, #Credit1E-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit1F-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit20-#ST, #Credit21-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit4F-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit22-#ST, #Credit23-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit24-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit25-#ST, #Credit26-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit27-#ST, #Credit28-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit29-#ST, #Credit2A-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit2B-#ST, #Credit2C-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit2D-#ST, #Credit2E-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit50-#ST, #Credit51-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit52-#ST, #Credit53-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit6E-#ST, #Credit6F-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit2F-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit30-#ST, #Credit31-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit32-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit33-#ST, #Credit34-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit35-#ST, #Credit36-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit37-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit38-#ST, #Credit39-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit3A-#ST, #Credit3B-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit3C-#ST, #Credit3D-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit3E-#ST, #Credit3F-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit40-#ST, #Credit41-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit70-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit71-#ST, #Credit72-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit73-#ST, #Credit74-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit42-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit43-#ST, #Credit44-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit45-#ST, #Credit46-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit47-#ST, #Credit48-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit49-#ST, #Credit4A-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit4B-#ST, #Credit4C-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit4D-#ST, #Credit4E-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #Credit54-#ST, #Credit55-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit56-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit57-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit58-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit59-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit5A-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit5B-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit5C-#ST, #Credit5D-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit5E-#ST, #Credit5F-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit60-#ST, #Credit61-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit62-#ST, #Credit63-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit64-#ST, #Credit65-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit66-#ST, #Credit67-#ST, #BlankRow-#ST, #BlankRow-#ST, #Credit68-#ST, #Credit69-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #Credit6A-#ST, #Credit6B-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST, #BlankRow-#ST
    dw #Credit6C-#ST, #Credit6D-#ST

    warnpc $0EBC51
        
    ; $073C51-$073C6C DATA
    ; The are the line numbers where the game will draw the death counts for each dungeon.
    ; once one is hit it will start looking for the next one but if doesn't find the first
    ; one for example it will not show all of the following either.
    dw $0290, $0298, $02A0, $02A8, $02B0, $02BA, $02C2, $02CA, $02D2, $02DA, $02E2, $02EA, $02F2, $0310
}

; ==============================================================================

; $073C6D-$073D4D LOCAL
{
    JSL EnableForceBlank          ; $00093D in ROM. Set up the screen values, resets HDMA, etc.
    JSL Vram_EraseTilemaps_normal ; $008333 in rom
    JSL CopyFontToVram            ; $006556 in rom
    JSL $0286C0 ; $0106C0 IN ROM
    JSL $0CCA81 ; $064A81 IN ROM
        
    ; Force blank the screen
    LDA.b #$80 : STA $13
        
    LDA.b #$02 : STA $0AA9
        
    ; Load a couple of palettes
    LDA.b #$01 : STA $0AB2
        
    JSL Palette_Hud ; $0DEE52 IN ROM
        
    ; note that cgram should be updated for the next frame
    INC $15
        
    REP #$20
        
    LDA.w #$0000 : STA $7EF3EF
        
    ; The counter for the number of times you've saved/died.
    LDA $7EF403 : CLC : ADC $7EF401 : STA $7EF401
        
    LDX.b #$18

    .loop

        ; Read values up to $7EF3FF (WORD)
        ; Cycle through all the dungeons
        CLC : ADC $7EF3E7, X : STA $7EF405
    DEX #2 : BPL .loop
        
    ; Zero out the overall life counter.
    LDA.w #$0000 : STA $7EF403
        
    SEP #$20
        
    ; Find our max health and divide by 8.
    ; Gives us how many heart containers we have. 
    ; (Each heart container counts for 8 health)
    LDA $7EF36C : LSR #3 : TAX
        
    ; This is the table of how many hearts to give when you start up.
    LDA $09F4AC, X : STA $7EF36D
        
    ; Puts us in the Dark World.
    LDA.b #$40 : STA $7EF3CA
        
    JSL Main_SaveGameFile
        
    REP #$20
        
    LDA.w #$0000 : STA $7EC34C : STA $7EC54D
    LDA.w #$0000 : STA $7EC300 : STA $7EC500

    LDA.w #$0016 : STA $1C
    LDA.w #$6800 : STA $C8
        
    STZ $CA
    STZ $CC
        
    LDA.w #$FFB8 : STA $E8
    LDA.w #$0090 : STA $E2
        
    STZ $EA
    STZ $E4
        
    JSR $BE24 ; $073E24 IN ROM
        
    SEP #$20
        
    LDA.b #$22 : STA $012C
        
    STZ $99
        
    LDA.b #$A2 : STA $9A
        
    LDA.b #$12 : STA $2108
        
    LDA.b #$3F : STA $9C
    LDA.b #$5F : STA $9D
    LDA.b #$9F : STA $9E
    LDA.b #$40 : STA $B0
        
    STZ $13
        
    LDX.b #$04
    
    .BRANCH_BETA
    
        LDA $0EBD4E, X : STA $4370, X
    DEX : BPL .BRANCH_BETA
        
    STZ $4377
        
    LDA.b #$80 : STA $9B
        
    BRL .BRANCH_$73DEB
}

; $073D4E-$073D65 DATA
{
    db $42     ; -> DMAP7
    db $0F     ; -> BBAD7
    dl $0EBD53 ; -> A1T7 and A1B7
    
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

; $073D66-$073D8A LOCAL
{
    ; Gradually neutralizes color addition / subtraction to neutral
        
    DEC $B0 : BNE .BRANCH_ALPHA
        LDA.b #$10 : STA $B0
        
        LDA $9C : CMP.b #$20 : BEQ .BRANCH_BETA
            DEC $9C
            
            BRA .BRANCH_ALPHA
    
    .BRANCH_BETA
    
    LDA $9D : CMP.b #$40 : BEQ .BRANCH_GAMMA
        DEC $9D
        
        BRA .BRANCH_ALPHA
    
    .BRANCH_GAMMA
    
    LDA $9E : CMP.b #$80 : BEQ .BRANCH_ALPHA
        DEC $9E
    
    .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $073D8B-$073E03 LOCAL
{
    ; Gradually neutralize color add/sub
    JSR $BD66 ; $073D66 IN ROM
        
    LDA.b #$01 : STA $0710
        
    SEP #$30
        
    ; Presumably something to do with the 3D triforce
    JSL $0CCBA2 ; $064BA2 IN ROM
        
    REP #$30
        
    LDA $1A : AND.w #$0003 : BNE .return
        ; Advance the scenery background to the right 1 pixel
        INC $E2
        
        LDA $E2 : CMP.w #$0C00 : BNE .noTilemapAdjust
            ; Adjust the tilemap size and locations of BG1 and BG2... not entirely clear yet as to why
            LDY.w #$1300 : STY $2107
        
        .noTilemapAdjust
    
        ; $0604 = BG2HOFS / 2, $0600 = BG2HOFS * 3 / 2, $0602 = BG2HOFS * 3 / 4
        LSR A : STA $0604 : CLC : ADC $E2 : STA $0600 : LSR A : STA $0602
        
        ; $0606 = BG2HOFS / 4
        LDA $0604 : LSR A : STA $0606
        
        LDA $EA : CMP.w #$0CD8 : BNE .notDoneWithSubmodule
            LDA.w #$0080 : STA $C8
            
            INC $11
            
            BRA .return
        
        .notDoneWithSubmodule
    
        ; Scroll the credit list up one pixel
        CLC : ADC.w #$0001 : STA $EA
        
        TAY : AND.w #$0007 : BNE .return
            TYA : LSR #3 : STA $CA
            
            JSR $BE24 ; $073E24 IN ROM
    
    ; $073DEB LONG BRANCH LOCATION
    .return
    
    REP #$20
        
    LDA $E2 : STA $011E
    LDA $E8 : STA $0122
        
    LDA $E0 : STA $0120
    LDA $E6 : STA $0124
        
    SEP #$30
        
    RTS
}

; ==============================================================================

; $073E04-$073E23 DATA
{
    .unknown_0
    dw $3CE6, $3CF6
    
    ; $073E08
    .death_count_offsets
    dw $0002, $0000, $0004, $0006, $0014, $000C, $000A, $0010
    dw $0016, $0012, $000E, $0018, $001A, $001E 
}

; ==============================================================================

; $073E24-$073F4B LOCAL
{
    PHB : PHK : PLB
        
    REP #$30
        
    LDX $1000
        
    LDA $C8 : XBA : STA $1002, X
        
    LDA.w #$3E40 : STA $1004, X
        
    ; load the value for a transparent tile on BG3
    LDA $B176 : STA $1006, X
        
    TXA : CLC : ADC.w #$0006 : TAX
        
    ; 0x0314 is the overall height of the credit screen in groups of 16 pixels
    LDA $CA : ASL A : TAY : CPY.w #$0314 : BCC .notAtEnd
        BRL .BRANCH_EPSILON
    
    .notAtEnd
    
    ; Gives us an idea of what row of tiles to look at.
    LDA $B93D, Y : TAY
        
    ; basically a tab in terms of tiles
    ; If it's ...1, that means it's a blank line.
    LDA $B178, Y : AND.w #$00FF : CMP.w #$00FF : BEQ .BRANCH_BETA
        CLC : ADC $C8 : XBA : STA $1002, X
        
        INY : LDA $B178, Y : AND.w #$00FF : XBA : STA $1004, X
        
        ; This gives us the number of tiles to grab after this byte.
        XBA : INC A : LSR A : STA $02
        
        INY : STY $00
    
        .nextTile
    
            LDY $00
            
            ; Grab the next tile of text
            LDA $B178, Y : AND.w #$00FF : ASL A : TAY
            
            ; Here we're loading the actual tile indices for the letters
            LDA $B038, Y : STA $1006, X
            
            INC $00
            
            INX #2
        ; count down until we run out of tiles to grab.
        DEC $02 : BNE .nextTile
        
        INX #4
    
    .BRANCH_BETA
    
    LDA $CC : AND.w #$0001 : TAY : BNE .BRANCH_DELTA
        LDA $CC : AND.w #$00FE : TAY
        
        ; Check if we are on one of the line we need to draw a death count on
        ; $CA c
        LDA $CA : ASL A : CMP $BC51, Y : BNE .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    TYA : AND.w #$0001 : ASL A : TAY
        
    LDA .uknown_0, Y : STA $CE
        
    LDA $C8 : CLC : ADC.w #$0019 : XBA : STA $1002, X
        
    LDA.w #$0500 : STA $1004, X
        
    PHX
        
    LDA $CC : LSR A : ASL A : TAX
        
    LDA .death_count_offsets, X : TAX
        
    LDA $7EF3E7, X
        
    PLX
        
    CMP.w #$03E8 : BCC .lessThanThousand
        LDA.w #$0009 : CLC : ADC $CE : STA $1006, X : STA $1008, X : STA $100A, X
        
        BRA .BRANCH_THETA
    
    .lessThanThousand
    
    LDY.w #$0000
    
    .BRANCH_KAPPA
    
        CMP.w #$000A : BMI .BRANCH_IOTA
            SEC : SBC.w #$000A
            
            INY
    BRA .BRANCH_KAPPA
    
    .BRANCH_IOTA
    
    CLC : ADC $CE : STA $100A, X
        
    TYA
        
    LDY.w #$0000
    
    .BRANCH_MU
    
        CMP.w #$000A : BMI .BRANCH_LAMBDA
            SEC : SBC.w #$000A
            
            INY
    BRA .BRANCH_MU
    
    .BRANCH_LAMBDA
    
    CLC : ADC $CE : STA $1008, X
        
    TYA : CLC : ADC $CE : STA $1006, X
    
    .BRANCH_THETA
    
    INC $CC
        
    TXA : CLC : ADC.w #$000A : TAX
    
    .BRANCH_EPSILON
    
    STX $1000
        
    LDA $C8 : CLC : ADC.w #$0020 : TAY : AND.w #$03FF : BNE .BRANCH_NU
        LDA $C8 : AND.w #$6800 : EOR.w #$0800 : TAY
    
    .BRANCH_NU
    
    STY $C8
        
    SEP #$30
        
    LDA.b #$FF : STA $1002, X
        
    LDA.b #$01 : STA $14
        
    PLB
        
    RTS
}

; ==============================================================================

; $073F4C-$074302 DATA
; TODO: Doccument this.
{
    ; fill in data later or with binary file.
    .unknown
    db $62, $65, $00, $2B, $2D, $21, $1E, $9F, $2B, $1E, $2D, $2E, $2B, $27, $9F, $28
    db $1F, $9F, $2D, $21, $1E, $9F, $24, $22, $27, $20, $62, $E9, $00, $19, $64, $75
    db $6E, $71, $68, $61, $9F, $5F, $5D, $6F, $70, $68, $61, $63, $09, $00, $19, $8A
    db $9B, $94, $97, $8E, $87, $9F, $85, $83, $95, $96, $8E, $87, $62, $68, $00, $1B
    db $2D, $21, $1E, $9F, $25, $28, $32, $1A, $25, $9F, $2C, $1A, $20, $1E, $62, $EB
    db $00, $11, $6F, $5D, $6A, $5F, $70, $71, $5D, $6E, $75, $63, $0B, $00, $11, $95
    db $83, $90, $85, $96, $97, $83, $94, $9B, $62, $4F, $00, $01, $34, $62, $65, $00
    db $2D, $2C, $1A, $21, $1A, $2C, $2B, $1A, $25, $1A, $21, $35, $2C, $9F, $21, $28
    db $26, $1E, $1C, $28, $26, $22, $27, $20, $62, $E9, $00, $19, $67, $5D, $67, $5D
    db $6E, $65, $67, $6B, $9F, $70, $6B, $73, $6A, $63, $09, $00, $19, $8D, $83, $8D
    db $83, $94, $8B, $8D, $91, $9F, $96, $91, $99, $90, $62, $64, $00, $2F, $2F, $2E
    db $25, $2D, $2E, $2B, $1E, $2C, $9F, $2B, $2E, $25, $1E, $9F, $2D, $21, $1E, $9F
    db $1D, $1E, $2C, $1E, $2B, $2D, $62, $E9, $00, $19, $60, $61, $6F, $61, $6E, $70
    db $9F, $6C, $5D, $68, $5D, $5F, $61, $63, $09, $00, $19, $86, $87, $95, $87, $94
    db $96, $9F, $92, $83, $8E, $83, $85, $87, $62, $64, $00, $2F, $2D, $21, $1E, $9F
    db $1B, $2E, $25, $25, $32, $9F, $26, $1A, $24, $1E, $2C, $9F, $1A, $9F, $1F, $2B
    db $22, $1E, $27, $1D, $62, $E9, $00, $1B, $69, $6B, $71, $6A, $70, $5D, $65, $6A
    db $9F, $70, $6B, $73, $61, $6E, $63, $09, $00, $1B, $8F, $91, $97, $90, $96, $83
    db $8B, $90, $9F, $96, $91, $99, $87, $94, $62, $66, $00, $25, $32, $28, $2E, $2B
    db $9F, $2E, $27, $1C, $25, $1E, $9F, $2B, $1E, $1C, $28, $2F, $1E, $2B, $2C, $62
    db $EB, $00, $13, $75, $6B, $71, $6E, $9F, $64, $6B, $71, $6F, $61, $63, $0B, $00
    db $13, $9B, $91, $97, $94, $9F, $8A, $91, $97, $95, $87, $62, $66, $00, $21, $1F
    db $25, $22, $29, $29, $1E, $2B, $2C, $9F, $1F, $28, $2B, $9F, $2C, $1A, $25, $1E
    db $62, $E8, $00, $1F, $76, $6B, $6E, $5D, $77, $6F, $9F, $73, $5D, $70, $61, $6E
    db $62, $5D, $68, $68, $63, $08, $00, $1F, $9C, $91, $94, $83, $9D, $95, $9F, $99
    db $83, $96, $87, $94, $88, $83, $8E, $8E, $62, $64, $00, $2D, $2D, $21, $1E, $9F
    db $30, $22, $2D, $1C, $21, $9F, $1A, $27, $1D, $9F, $1A, $2C, $2C, $22, $2C, $2D
    db $1A, $27, $2D, $62, $EB, $00, $13, $69, $5D, $63, $65, $5F, $9F, $6F, $64, $6B
    db $6C, $63, $0B, $00, $13, $8F, $83, $89, $8B, $85, $9F, $95, $8A, $91, $92, $62
    db $68, $00, $1F, $2D, $30, $22, $27, $9F, $25, $2E, $26, $1B, $1E, $2B, $23, $1A
    db $1C, $24, $2C, $62, $E9, $00, $1B, $73, $6B, $6B, $60, $6F, $69, $61, $6A, $77
    db $6F, $9F, $64, $71, $70, $63, $09, $00, $1B, $99, $91, $91, $86, $95, $8F, $87
    db $90, $9D, $95, $9F, $8A, $97, $96, $62, $64, $00, $29, $1F, $25, $2E, $2D, $1E
    db $9F, $1B, $28, $32, $9F, $29, $25, $1A, $32, $2C, $9F, $1A, $20, $1A, $22, $27
    db $62, $E9, $00, $19, $64, $5D, $71, $6A, $70, $61, $60, $9F, $63, $6E, $6B, $72
    db $61, $63, $09, $00, $19, $8A, $83, $97, $90, $96, $87, $86, $9F, $89, $94, $91
    db $98, $87, $62, $64, $00, $2D, $2F, $1E, $27, $2E, $2C, $37, $9F, $2A, $2E, $1E
    db $1E, $27, $9F, $28, $1F, $9F, $1F, $1A, $1E, $2B, $22, $1E, $2C, $62, $EA, $00
    db $17, $73, $65, $6F, $64, $65, $6A, $63, $9F, $73, $61, $68, $68, $63, $0A, $00
    db $17, $99, $8B, $95, $8A, $8B, $90, $89, $9F, $99, $87, $8E, $8E, $62, $64, $00
    db $2D, $2D, $21, $1E, $9F, $1D, $30, $1A, $2B, $2F, $1E, $27, $9F, $2C, $30, $28
    db $2B, $1D, $2C, $26, $22, $2D, $21, $2C, $62, $EC, $00, $0F, $6F, $69, $65, $70
    db $64, $61, $6E, $75, $63, $0C, $00, $0F, $95, $8F, $8B, $96, $8A, $87, $94, $9B
    db $62, $66, $00, $27, $2D, $21, $1E, $9F, $1B, $2E, $20, $36, $1C, $1A, $2D, $1C
    db $21, $22, $27, $20, $9F, $24, $22, $1D, $62, $E9, $00, $19, $67, $5D, $67, $5D
    db $6E, $65, $67, $6B, $9F, $70, $6B, $73, $6A, $63, $09, $00, $19, $8D, $83, $8D
    db $83, $94, $8B, $8D, $91, $9F, $96, $91, $99, $90, $62, $48, $00, $1F, $2D, $21
    db $1E, $9F, $25, $28, $2C, $2D, $9F, $28, $25, $1D, $9F, $26, $1A, $27, $62, $E9
    db $00, $1B, $60, $61, $5D, $70, $64, $9F, $69, $6B, $71, $6A, $70, $5D, $65, $6A
    db $63, $09, $00, $1B, $86, $87, $83, $96, $8A, $9F, $8F, $91, $97, $90, $96, $83
    db $8B, $90, $62, $68, $00, $1F, $2D, $21, $1E, $9F, $1F, $28, $2B, $1E, $2C, $2D
    db $9F, $2D, $21, $22, $1E, $1F, $62, $EB, $00, $13, $68, $6B, $6F, $70, $9F, $73
    db $6B, $6B, $60, $6F, $63, $0B, $00, $13, $8E, $91, $95, $96, $9F, $99, $91, $91
    db $86, $95, $62, $66, $00, $27, $1A, $27, $1D, $9F, $2D, $21, $1E, $9F, $26, $1A
    db $2C, $2D, $1E, $2B, $9F, $2C, $30, $28, $2B, $1D, $62, $A8, $00, $1D, $4A, $43
    db $3C, $3C, $47, $4A, $9F, $38, $3E, $38, $40, $45, $52, $52, $52, $62, $EC, $00
    db $0F, $62, $6B, $6E, $61, $72, $61, $6E, $78, $63, $0C, $00, $0F, $88, $91, $94
    db $87, $98, $87, $94, $9E
    
    ; $0742E1
    db $00, $00

    ; $0742E3
    db $3C, $00, $68, $00, $AA, $00, $E8, $00, $28, $01, $5B, $01, $98, $01, $CF, $01
    db $07, $02, $42, $02, $7D, $02, $B0, $02, $EA, $02, $22, $03, $52, $03, $95, $03
}

; ==============================================================================

; $074303-$07437B LOCAL
{
    ; Does this draw the tag lines for the ending sequence?
    ; (The text)
    PHB : PHK : PLB
        
    REP #$30
        
    LDA.w #$0060 : STA $1002
    LDA.w #$FE47 : STA $1004
        
    ; $073176 THAT IS; = 0x3CA9
    LDA $B176 : STA $1006
        
    ; Take $11, round to the nearest lowest even integer
    LDA $11 : AND.w #$00FE : TAY
        
    LDA $C2E3, Y : STA $04
        
    LDA $C2E1, Y : TAY
        
    LDX.w #$0000
    
    .BRANCH_BETA
    
        ; $073F4C, Y THAT IS
        LDA $BF4C, Y : STA $1008, X
        
        INY #2
        INX #2
        
        ; $073F4C, Y THAT IS
        LDA $BF4C, Y : STA $1008, X
        
        XBA : AND.w #$00FF : LSR A : STA $00
        
        INY #2
        INX #2
        
        STY $02
    
        .BRANCH_ALPHA
    
            LDY $02
            
            LDA $BF4C, Y : AND.w #$00FF : ASL A : TAY
            
            LDA $B038, Y : STA $1008, X
            
            INC $02
            
            INX #2
        DEC $00 : BPL .BRANCH_ALPHA
    LDY $02 : CPY $04 : BNE .BRANCH_BETA
        
    TXA : CLC : ADC.w #$0006 : STA $1000
        
    SEP #$30
        
    LDA.b #$FF : STA $1008, X
        
    LDA.b #$01 : STA $14
        
    PLB
        
    RTS
}

; $07437C-$0743D4 LOCAL
{
    LDA $1A : AND.b #$0F : BNE .BRANCH_ALPHA
        INC $13
        
        LDA $13 : CMP.b #$0F
        
        BNE .BRANCH_ALPHA
            INC $11
    
    .BRANCH_ALPHA
    
    JSL $0CCBA2 ; $064BA2 IN ROM
        
    RTS
    
    ; $074391 ALTERNATE ENTRY POINT
    
    DEC $C8
            
    BNE .BRANCH_BETA 
        REP #$20
            
        STZ $0AA6
            
        LDA.w #$0000 : STA $7EC009 : STA $7EC007
            
        LDA.w #$001F : STA $7EC00B
            
        SEP #$20
            
        INC $11
            
        LDA.b #$C0 : STA $C8
            
        STZ $CA
    
    .BRANCH_BETA

    .loop
    
        BRA .BRANCH_ALPHA
    
    ; $0743B8 ALTERNATE ENTRY POINT
    
        DEC $C8
        
        LDA $CA : BNE .BRANCH_GAMMA
            JSL PaletteFilter.doFiltering
            
            LDA $7EC007 : BNE .loop
                INC $CA
        
        .BRANCH_GAMMA
    LDA $C8 : BNE .loop
        
    INC $11
        
    JSL PaletteFilter_InitTheEndSprite
        
    RTS
}

; $0743D5-$0743E9 LOCAL
{
    LDA $1A : AND.b #$07 : BNE .frameNotMultipleOf8
        ; Do some palette filtering
        JSL Palette_Filter_SP5F
            
        LDA $7EC007 : BNE .notDoneFiltering
            INC $11
        
        .notDoneFiltering
    .frameNotMultipleOf8
    
    JMP $C3FA ; $0743FA IN ROM
}

; $0743EA-$0743F9 "The End" Oam buffer data for displaying it
{
    db $A0, $B8, $00, $3B
    db $B0, $B8, $02, $3B
    db $C0, $B8, $04, $3B
    db $D0, $B8, $06, $3B
}
    
; $0743FA-$07441B JUMP LOCATION LOCAL
{
    ; The End!
    
    .infiniteLoop
    
        REP #$20
        
        LDX.b #$0E
    
        .writeTheEndWithSprites
        
            ; $0743EA, X THAT IS
            LDA $0EC3EA, X : STA $0800, X
        DEX #2 : BPL .writeTheEndWithSprites
            
        SEP #$20
            
        LDA.b #$02 : STA $0A20 : STA $0A21 : STA $0A22 : STA $0A23
            
        RTS
    
    ; Once you reach this point, you'll have to turn off or reset the system to continue
    ; $07441A ALTERNATE ENTRY POINT
    
    BRA .infiniteLoop
}

; $07441C-$07443F NULL
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF
}
    
; ==============================================================================

incsrc "vwf.asm"
    
; ==============================================================================

; $07544B-$07545F - NULL (bytes with value 0xFF)
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF
}

; $075460-$075503 - used in dungeons to set $0AB6, $0AAC, $0AAD, and $0AAE
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

; $075504-$07557F - used to set $0AB4, $0AB5, and $0AB8
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

; $075580-$0755A7 - used to set $0AAD and $0AAE
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

; $0755A8-$0755F3 LONG
Overworld_LoadPalettes:
{
    ASL #2 : TAX ;*2
        
    STZ $0AA9
        
    LDA $0ED504, X : BMI .noPaletteChange1
        STA $0AB4
    
    .noPaletteChange1
    
    ; $075505, X THAT IS
    LDA $0ED505, X : BMI .noPaletteChange2
        STA $0AB5
    
    .noPaletteChange2
    
    ; $075506, X THAT IS
    LDA $0ED506, X : BMI .noPaletteChange3
        STA $0AB8
    
    .noPaletteChange3
    
    LDA $00 : ASL A : TAX
        
    ; $075580, X THAT IS
    LDA $0ED580, X : BMI .noPaletteChange4
        STA $0AAD
    
    .noPaletteChange4
    
    ; $075581, X THAT IS
    LDA $0ED581, X : BMI .noPaletteChange5
        STA $0AAE
    
    .noPaletteChange5
    
    JSL Palette_OverworldBgAux1
    JSL Palette_OverworldBgAux2
    JSL Palette_OverworldBgAux3
    JSL Palette_SpriteAux1
    JSL Palette_SpriteAux2
    
    ; $0755F3 ALTERNATE ENTRY POINT
    
    RTL
}

; $0755F4-$075617 LONG
Palette_BgAndFixedColor:
{
    ; Zero Bg color
    
    REP #$20
        
    LDA.w #$0000
    
    ; $0755F9 ALTERNATE ENTRY POINT
    .setBgColor
    
    STA $7EC500
    STA $7EC540
    STA $7EC300
    STA $7EC340
        
    SEP #$30
    
    ; $07560B ALTERNATE ENTRY POINT
    .justFixedColor
    
    ; Sets color add / sub settings to normal intensity
    LDA.b #$20 : STA $9C
    LDA.b #$40 : STA $9D
    LDA.b #$80 : STA $9E
        
    RTL
}

; $075618-$07561C LONG
Palette_SetOwBgColor_Long:
{
    JSR Palette_GetOwBgColor
        
    ; Sets fixed color to normal and zeroes the first color of some palettes
    BRA Palette_BgAndFixedColor_setBgColor
}

; $07561D-$075621 LONG
{
    JSR Palette_GetOwBgColor
        
    BRA .BRANCH_$07560B
}

; $075622-$075652 LOCAL
; ZS changes this function.
Palette_GetOwBgColor:
{
    REP #$30
        
    ; default green color
    LDX.w #$2669
        
    ; ZS writes here.
    ; $075627 - ZS Custom Overworld
    ; If area number < 0x80
    LDA $8A : CMP.w #$0080 : BCC .notSpecialArea
        ; Check for special areas
        LDA $A0
        
        CMP.w #$0183 : BEQ .specialArea
        CMP.w #$0182 : BEQ .specialArea
        CMP.w #$0180 : BNE .finished
    
        .specialArea
            ; The special areas apparently have a slightly different shade of green
            ; for their background
            LDX.w #$19C6
        
        BRA .finished
    
    .notSpecialArea
    
    ; default green color
    LDX.w #$2669
        
    LDA $8A : AND.w #$0040 : BEQ .finished
        ; Default tan color for the dark world
        LDX.w #$2A32                            
    
    .finished
    
    TXA
        
    RTS
}

; \unused Only the top label is unused.
; $075653-$0756B8 LONG
Palette_AssertTranslucencySwap_ForcePlayerToBg1:
{
    ; ???
    ; these two instructions don't seem to have a reference.
    LDA.b #$01 : STA $EE
    
    ; $075657 ALTERNATE ENTRY POINT
    Palette_AssertTranslucencySwap:
    
    LDA.b #$01 : STA $0ABD
    
    ; $07565C ALTERNATE ENTRY POINT
    Palette_PerformTranslucencySwap:
    
    REP #$21
        
    LDX.b #$00
    
    .swap_palettes
    
        ; e.g. $415 means $7EC415, for your reference
        ; description: the below swaps memory regions $7EC400-$7EC41F and $7EC4B0-
        ; $7EC4BF with $7EC4E0-$7EC4FF and $7EC470-$7EC47F, respectively.
        ; This suggests 3bpp since each 0x10 byte region could be considered
        ; a full palette.
        ; At the same time, it also copies this info in the Main palette 
        ; buffer and the Auxiliary palette buffer.
        
        ; \optimize This could, at the very least, utilize a data bank value of
        ; 0x7E to speed things up and save space.
        
        ; swap SP0_L with SP7_L.
        LDA $7EC400, X : PHA
        
        LDA $7EC4E0, X : STA $7EC400, X
                         STA $7EC600, X
        
        PLA : STA $7EC4E0, X
              STA $7EC6E0, X
        
        ; swap SP0_H with SP7_H.
        LDA $7EC410, X : PHA
        
        LDA $7EC4F0, X : STA $7EC410, X
                         STA $7EC610, X
        
        PLA : STA $7EC4F0, X
              STA $7EC6F0, X
        
        ; swap SP5_H with SP3_H.
        LDA $7EC4B0, X : PHA
        
        LDA $7EC470, X : STA $7EC4B0, X
                         STA $7EC6B0, X
        
        PLA : STA $7EC470, X
              STA $7EC670, X
    INX #2 : CPX.b #$10 : BNE .swap_palettes
        
    SEP #$20
        
    INC $15
        
    RTL
}

; ==============================================================================
    
; \unused Again, only the top label is unused.
; $0756B9-$0756BF LONG
Palette_RevertTranslucencySwap_ForcePlayerBg2:
{
    STZ $EE
    
    Palette_RevertTranslucencySwap:
    
    STZ $0ABD
        
    BRA Palette_PerformTranslucencySwap
}

; =============================================

; $0756C0-$0756D0 LONG
LoadActualGearPalettes:
{
    ; Called "actual" because none of the types of gear (sword, shield, armor)
    ; are faked or substituted with preset values.
    
    REP #$20
        
    ; Link's sword and shield value
    LDA $7EF359 : STA $0C
        
    ; Link's armor value
    LDA $7EF35B : AND.w #$00FF
        
    BRA LoadGearPalettes.variable
}

; =============================================

; \note Loads player palettes for unusual states, such as being electrocuted
; or using the Ether spell
; $0756D1-$0756DC LONG
Palette_ElectroThemedGear:
{
    REP #$20
        
    LDA.w #$0202 : STA $0C
        
    LDA.w #$0404
        
    BRA LoadGearPalettes.variable
}

; =============================================

; $0756DD-$075740 LONG
LoadGearPalettes:
{
    .bunny
    
    REP #$20
        
    ; What type of sword and armor does Link have? (2 bytes)
    LDA $7EF359 : STA $0C
        
    ; ....... ? .......
    LDA.w #$0303
    
    .variable
    
    STA $0E
        
    ; Setting up the bank for the source data
    LDA.w #$001B : STA $02
        
    ; X = #$0, #$1, #$2, #$3, or #$4 (sword value)
    LDX $0C
        
    ; A = #$0, #$0, #$6, #$C, or #$12
    LDA $1BEBB4, X : AND.w #$00FF : CLC : ADC.w #$D630
        
    REP #$10
        
    LDX.w #$01B2 ; Offset into the palette array.
    LDY.w #$0002 ; Length of the palette in words.
        
    JSR LoadGearPalette
        
    SEP #$10
        
    ; X = #$0, #$1, #$2, or #$3 (shield value)
    LDX $0D
        
    ; A = #$0, #$0, #$8, or #$10
    LDA $1BEBC1, X : AND.w #$00FF : CLC : ADC.w #$D648
        
    REP #$10
        
    LDX.w #$01B8
    LDY.w #$0003
        
    JSR LoadGearPalette
        
    SEP #$10
        
    ; Armor value
    LDX $0E
        
    LDA $1BEC06, X : AND.w #$00FF : ASL A : CLC : ADC.w #$D308
        
    REP #$10
        
    LDX.w #$01E2
    LDY.w #$000E
        
    JSR LoadGearPalette
        
    SEP #$30
        
    INC $15
        
    RTL
}

; =============================================
    
; $075741-$075756 LOCAL
LoadGearPalette:
{
    ; ($00 is variable input)
    STA $00

    .nextColor

        ; LDA from address $1BXXXX into auxiliary cgram buffer and normal cgram buffer. 
        LDA [$00] : STA $7EC300, X : STA $7EC500, X

        ; Y is the length of the palette in colors (words)
        INC $00 : INC $00
        
        INX #2
    DEY : BPL .nextColor

    RTL
}

; ==============================================================================

; $075757-$0757FD LONG
Filter_Majorly_Whiten_Bg:
{
    REP #$20
        
    LDX.b #$00
    
    .next_color_in_each_palette
    
        LDA $7EC340, X : JSR Filter_Majorly_Whiten_Color : STA $7EC540, X
        LDA $7EC350, X : JSR Filter_Majorly_Whiten_Color : STA $7EC550, X
        LDA $7EC360, X : JSR Filter_Majorly_Whiten_Color : STA $7EC560, X
        LDA $7EC370, X : JSR Filter_Majorly_Whiten_Color : STA $7EC570, X
        LDA $7EC380, X : JSR Filter_Majorly_Whiten_Color : STA $7EC580, X
        LDA $7EC390, X : JSR Filter_Majorly_Whiten_Color : STA $7EC590, X
        LDA $7EC3A0, X : JSR Filter_Majorly_Whiten_Color : STA $7EC5A0, X
        LDA $7EC3B0, X : JSR Filter_Majorly_Whiten_Color : STA $7EC5B0, X
        LDA $7EC3C0, X : JSR Filter_Majorly_Whiten_Color : STA $7EC5C0, X
        LDA $7EC3D0, X : JSR Filter_Majorly_Whiten_Color : STA $7EC5D0, X
        LDA $7EC3E0, X : JSR Filter_Majorly_Whiten_Color : STA $7EC5E0, X
        LDA $7EC3F0, X : JSR Filter_Majorly_Whiten_Color : STA $7EC5F0, X
    INX #2 : CPX.b #$10 : BEQ .finished_whitening_increment
        
    JMP .next_color_in_each_palette
    
    .finished_whitening_increment
    
    REP #$10
        
    LDA $7EC540 : TAY
        
    LDA $7EC300 : BNE .non_black_backdrop_color
        
        ; What this is saying is don't whiten or muck with a black backdrop,
        ; but other colors are fine to alter.
        TAY
    .non_black_backdrop_color
    
    TYA : STA $7EC500
        
    SEP #$30
        
    RTL
}

; ==============================================================================

; $0757FE-$075839 LOCAL
Filter_Majorly_Whiten_Color:
{
    STA $00
        
    AND.w #$001F : CLC : ADC.w #$000E : CMP.w #$001F : BCC .red_not_maxed
        LDA.w #$001F
    
    .red_not_maxed
    
    STA $02
        
    LDA $00 : AND.w #$03E0 : CLC : ADC.w #$01C0 : CMP.w #$03E0 : BCC .green_not_maxed
        LDA.w #$03E0
    
    .green_not_maxed
    
    STA $04
        
    LDA $00 : AND.w #$7C00 : CLC : ADC.w #$3800 : CMP.w #$7C00 : BCC .blue_not_maxed
        LDA.w #$7C00
    
    .blue_not_maxed
    
    ORA $02 : ORA $04
        
    RTS
}

; ==============================================================================

; $07583A-$0758FA LONG
Palette_Restore_BG_From_Flash:
; ZS replcaces the latter half of this function.
{
    REP #$20
        
    LDX.b #$00
    
    .restore_loop
        LDA $7EC340, X : STA $7EC540, X
        LDA $7EC350, X : STA $7EC550, X
        LDA $7EC360, X : STA $7EC560, X
        LDA $7EC370, X : STA $7EC570, X
        LDA $7EC380, X : STA $7EC580, X
        LDA $7EC390, X : STA $7EC590, X
        LDA $7EC3A0, X : STA $7EC5A0, X
        LDA $7EC3B0, X : STA $7EC5B0, X
        LDA $7EC3C0, X : STA $7EC5C0, X
        LDA $7EC3D0, X : STA $7EC5D0, X
        LDA $7EC3E0, X : STA $7EC5E0, X
        LDA $7EC3F0, X : STA $7EC5F0, X
        
    INX #2 : CPX.b #$10 : BNE .restore_loop
        
    LDA $7EC540 : STA $7EC500
        
    SEP #$30
    
    ; ZS starts replacing from here.
    ; $0758AE ALTERNATE ENTRY POINT - ZS Custom Overworld
    LDA $1B : BNE .noSpecialColor
        REP #$10
        
        LDX.w #$4020 : STX $9C
        LDX.w #$8040 : STX $9D
        
        LDX.w #$4F33
        LDY.w #$894F
        
        LDA $8A    : BEQ .noSpecialColor
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

            STX $9C
            STY $9D
    
    .noSpecialColor
    
    SEP #$10
        
    RTL
}

; ==============================================================================

; $0758FB-$075919 LONG
Palette_Restore_BG_And_HUD:
{
    REP #$20
        
    LDX.b #$7E
    
    .next_color
    
        LDA $7EC300, X : STA $7EC500, X
        LDA $7EC380, X : STA $7EC580, X
    DEX #2 : BPL .next_color
        
    SEP #$20
        
    INC $15
        
    JMP $D8AE ; $0758AE IN ROM
}

; ==============================================================================

; $07591A-$07593F NULL
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
}

; =============================================

; $075940-$07594B JUMP LOCATION (LONG)
PalaceMap_LightenUpMap:
{
    INC $13
        
    LDA $13 : CMP.b #$0F : BNE .stillTooDark
        INC $0200
    
    .stillTooDark

    .return
    
    RTL
}

; =============================================
    
; $07594C-$075A36 JUMP LOCATION (LONG)
PalaceMap_Backup:
{
    ; Darken the screen until it's fully dark.
    ; Then we can do some actual work.
    DEC $13 : BNE PalaceMap_LightenUpMap_return
        
    ; Turn off mosaic on BG1 and BG2
    LDA.b #$03 : STA $95
        
    ; Cache the hdma setup for later when we're done with the map
    ; because EnableForceBlank turns off hdma
    LDA $9B : STA $7EC229
        
    JSL EnableForceBlank ; $00093D IN ROM
        
    ; Move on to next step of the submodule, and initialize the initilization indicator ($020D)
    INC $0200 : STZ $020D
        
    ; set the fixed color to neutral (a value of 0,0,0)
    LDA.b #$20 : STA $9C
    LDA.b #$40 : STA $9D
    LDA.b #$80 : STA $9E
        
    REP #$20
        
    ; Set's Link's graphics to a particular configuration useful during the palace map mode.
    LDA.w #$0250 : STA $0100
    
    LDX.b #$7E
    
    .cachePaletteBuffer
    
        ; Store the CGRAM buffer away for safe keeping until we get back from map mode.
        LDA $7EC500, X : STA $7FDD80, X : LDA $7EC580, X : STA $7FDE00, X
        LDA $7EC600, X : STA $7FDE80, X : LDA $7EC680, X : STA $7FDF00, X
    DEX #2 : BPL .cachePaletteBuffer
        
    ; cache BG scroll offset (for quaking and such)
    LDA $011A : STA $7EC221
    LDA $011C : STA $7EC223
        
    STZ $011A : STZ $011C
        
    ; cache all BG scroll value
    LDA $E0 : STA $7EC200
    LDA $E2 : STA $7EC202
    LDA $E6 : STA $7EC204
    LDA $E8 : STA $7EC206
        
    ; zero all the BG scroll values after that.
    STZ $E0 : STZ $E2 : STZ $E4
    STZ $E6 : STZ $E8 : STZ $EA
        
    ; cache CGWSEL register
    LDA $99 : STA $7EC225
        
    ; set cg +/- to be subscreen addition and turn on half color math
    ; (but enable it on no layers?)
    LDA.w #$2002 : STA $99
        
    LDX.b #$00
    LDA.w #$0300
    
    .writeLoop
    
        STA $7F0000, X : STA $7F0100, X : STA $7F0200, X : STA $7F0300, X
        STA $7F0400, X : STA $7F0500, X : STA $7F0600, X : STA $7F0700, X
        STA $7F0800, X : STA $7F0900, X : STA $7F0A00, X : STA $7F0B00, X
        STA $7F0C00, X : STA $7F0D00, X : STA $7F0E00, X : STA $7F0F00, X  
    DEX #2 : BNE .writeLoop
        
    SEP #$20
        
    ; Play sound effect for opening the Palace Map.
    LDA.b #$10 : STA $012F
        
    ; Quiet the music a bit when we're in map mode
    LDA.b #$F2 : STA $012C
        
    RTL
}

; =============================================

; $075A37-$075A78 JUMP LOCATION (LONG)
PalaceMap_FadeMapToBlack:
{
    DEC $13 : BNE .notDoneDarkening
        
        ; Forceblank the screen
        JSL EnableForceBlank ; $00093D IN ROM
        
        ; Move to next step of submodule
        INC $0200
        
        REP #$30
        
        LDA $7EC225 : STA $99
        LDA $7EC200 : STA $E0
        LDA $7EC202 : STA $E2
        LDA $7EC204 : STA $E6
        LDA $7EC206 : STA $E8
        
        STZ $E4
        STZ $EA
        
        LDA $7EC221 : STA $011A
        LDA $7EC223 : STA $011C
        
        SEP #$30
        
        INC $15
    .notDoneDarkening
    
    RTL
}

; ==============================================================================

; $075A79-$075A9B JUMP LOCATION (LONG)
PalaceMap_LightenUpDungeon:
{
    JSL OrientLampBg
        
    INC $13
        
    LDA $13 : CMP.b #$0F : BNE .notDoneBrightening
        LDA $010C : STA $10
        
        STZ $11
        STZ $0200
        STZ $B0
        
        ; Bring screen brightness to full
        LDA.b #$0F : STA $13
    
        ; Restore hdma settings from before being in map mode.
        LDA $7EC229 : STA $9B
    
    .notDoneBrightening
    
    RTL
}

; ==============================================================================

; $075A9C-$075D3F DATA
DungeonMap_BG3Tilemap:
{
    dw $4260, $0100 ; VRAM $C084 | 2 bytes | Horizontal
    dw $2100

    dw $4360, $0E40 ; VRAM $C086 | 16 bytes | Fixed horizontal
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

    db $FF ; end of stripes data
}

; $075D31-$075D3F
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF
}

; ==============================================================================

; $075D40-$075D60 LONG
Overworld_Memorize_Map16_Change:
{
    ; Keeps track of map modifications for when warping between worlds.
        
    ; shovel hole
    CMP.w #$0DC5 : BEQ .dontRemember
        ; hole from picking up a bush / rock
        CMP.w #$0DC9 : BEQ .dontRemember
            PHA : PHX : TXY
            
            LDX $04AC : STA $7EFA00, X
            
            TYA : STA $7EF800, X : INX #2 : STX $04AC
            
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

; $075D67-$075DFB LONG
HandlePegPuzzles:
{
    LDA $8A : CMP.w #$0007 : BNE .notLwTurtleRock
        LDA $7EF287 : AND.w #$0020 : BNE .warpAlreadyOpen
            ; Y in this routine apparently contains the map16 address of the peg tile that Link hit
            STY $00
            
            LDX $04C8 : CPX.w #$FFFF : BEQ .puzzleFailed
                ; As you all probably realize, the 3 pegs in this area have to be hit in a specific order
                ; in order for the warp to open up. If you fail, you have to exit the screen and come back.
                ; That's what $04C8 being -1 (0xFFFF) indicates
                LDA LwTurtleRockPegPositions, X : CMP $00 : BNE .puzzleFailed
                    ; Play the successful puzzle step sound effect
                    LDA.w #$2D00 : STA $012E
                    
                    ; Move to the next peg
                    INX #2 : STX $04C8 : CPX.w #$0006 : BNE .puzzleIncomplete
                        ; Play mystery solved sound effect
                        LDA.w #$1B00 : STA $012E
                        
                        ; Set a flag so that next time we enter this screen
                        ; The puzzle will already be complete
                        LDA $7EF287 : ORA.w #$0020 : STA $7EF287
                        
                        SEP #$20
                        
                        LDA.b #$2F : STA $11
                        
                        REP #$20
                    
                    .puzzleIncomplete
                    
                    LDX $00
                        
                    RTL
        
            .puzzleFailed
        
            LDA.w #$003C : STA $012E
            LDA.w #$FFFF : STA $04C8
            
            LDX $00
    
        .warpAlreadyOpen
    
        RTL
    
    .notLwTurtleRock
    
    CMP.w #$0062 : BNE .notDwSmithyHouse
        INC $04C8
        
        LDA $04C8 : CMP.w #$0016 : BNE .notEnoughPegs
            PHX
            
            SEP #$20
            
            LDA $7EF2E2 : ORA.b #$20 : STA $7EF2E2
            
            LDA.b #$1B : STA $012F
            
            REP #$20
            
            LDA.w #$0050 : STA $0692
            LDA.w #$0D20 : STA $0698
            
            JSL Overworld_DoMapUpdate32x32_Long
            
            REP #$30
            
            PLX
    
        .notEnoughPegs
    .notDwSmithyHouse
        
    RTL
}

; $075DFC-$075E28 LONG
{
    LDA $B0 : BNE .BRANCH_ALPHA
        LDA.b #$29 : STA $012E
            
        JML $0EF404 ; $077404 IN ROM
    
    .BRANCH_ALPHA
    
    JSL $00EEF1 ; $006EF1 IN ROM
        
    REP #$30
        
    LDA $7EC009 : CMP.w #$00FF : BNE .BRANCH_BETA
        STA $7EC007
        STA $7EC009
        
        SEP #$30
        
        INC $B0
        
        RTL
    
    .BRANCH_BETA
    
    JML $0EF48C ; $07748C IN ROM
}

; $075E29-$075E48 DATA
{
    ; corresponding warp types that lead to special overworld areas
    dw $0105, $01E4, $00AD, $00B9
        
    ; Lost woods, Hyrule Castle Bridge, Entrance to Zora falls, and in Zora Falls...
    ; (I think the last one is broken or a mistake)
    dw $0000, $002D, $000F, $0081
        
    ; Direction Link will face when he enters the special area
    dw $0008, $0002, $0008, $0008
        
    ; Exit value for the special area. In Hyrule Magic these are those White markers.
    dw $0180, $0181, $0182, $0189
}

; $075E49-$075E99 LONG
{
    ; This routine specifically checks to see if Link will enter a special area (areas >= 0x80)
        
    REP #$31
        
    ; get the map16 address of Link's coordinates
    JSR $DE9A ; $075E9A IN ROM
        
    ; get the CHR at that location...
    LDA $0F8000, X : AND.w #$01FF : STA $00
        
    LDX.w #$0008
    
    .matchFailed
    
        LDA $00
    
        .nextChrValue
    
            DEX #2
        
            ; We've run out of CHR types to check (there's only 4)
            BMI .return
        ; compare map8 CHR number to see if the scroll to the next area has triggered
        CMP $0EDE29, X : BNE .nextChrValue
    ; Compare the area number, b/c only specific locations lead to the special OW areas.
    ; The CHR value and the area number must match for a warp to occur. (this is bizarre, I know)
    LDA $8A : CMP $0EDE31, X : BNE .matchFailed
        
    ; Loads the exit number to use (so that we can get to the proper destination)
    LDA $0EDE41, X : STA $A0
        
    SEP #$20
        
    ; Sets the direction Link will face when he comes in or out of the special area.
    LDA $0EDE39, X : STA $67 : STA $0410 : STA $0416
        
    LDX.w #$0004
    
    ; converts a bitwise direction indicator to a value based one
    .convertLoop
    
        DEX
    LSR A : BCC .convertLoop
        
    STX $0418 : STX $069C
        
    LDA.b #$17 : STA $11
        
    ; Go to special overworld mode (under bridge and master sword)
    LDA.b #$0B : STA $10
    
    .return
    
    SEP #$30
        
    RTL
}

; $075E9A-$075ECD LOCAL
{
    LDA $20 : CLC : ADC.w #$000C : STA $00
    SEC : SBC $0708 : AND $070A : ASL #3 : STA $06
        
    LDA $22 : CLC : ADC.w #$0008 : LSR #3 : STA $02
    SEC : SBC $070C : AND $070E : CLC : ADC $06 : TAY : TAX
        
    LDA $7E2000, X : ASL #3 : TAX
        
    RTS
}

; ==============================================================================

; $075ECE-$075EDF DATA
{
    ; Again, CHR values that must match with a respective area number
    dw $017C, $01E4, $00AD
        
    ; Master Sword grove, Under Hyrule bridge, Zora Falls.
    ; Note only 3 areas to warp back from whereas there were 4 areas to warp to
    ; However I think this just confirms that the last warp to special areas was something unfinished
    dw $0080, $0080, $0081
        
    ; Direction Link faces when getting back to the normal overworld area
    dw $0004, $0001, $0004
}

; ==============================================================================

; $075EE0-$075EE2
WeirdAssPlaceForAnExit:
{
    SEP #$30
        
    RTL
}

; ==============================================================================

; $075EE3-$075F2E LONG
{
    ; The reverse of $075E49, in that it detects tiles and area numbers that lead back to normal OW areas (from special areas)
        
    REP #$31
        
    JSR $DE9A   ; $075E9A IN ROM
        
    LDA $0F8000, X : AND.w #$01FF : STA $00
        
    LDX.w #$0006
    
    .matchFailed
    
        LDA $00
    
        .nextChrValue
    
            DEX #2
            
            ; ends the routine (Link is not going back to the normal Overworld this frame.)
            BMI WeirdAssPlaceForAnExit
        CMP $0EDECE, X : BNE .nextChrValue
    LDA $8A : CMP $0EDED4, X : BNE .matchFailed
        
    SEP #$30
        
    LDA $0EDEDA, X : STA $67
        
    LDX.b #$04
    
    ; converts a bitwise direction indicator to a value based one
    .convertLoop
    
        DEX
        
        LSR A
    BCC .convertLoop
        
    TXA : STA $0418
        
    LDA $67 
        
    LDX.b #$04
    
    ; Same idea here but for Link's walking direction.
    ; This loops is actually pointless and redundant
    ; because it generates the exact same result
    ; as the previous one.
    .convertLoop2
    
        DEX
    LSR A : BCC .convertLoop2
        
    TXA : STA $069C
        
    LDA.b #$24 : STA $11
        
    STZ $B0
    STZ $A0
        
    RTL
}

; ==============================================================================

; $075F2F-$075F3F NULL
{
    db $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
}
    
; ==============================================================================

; $075F40-$076E21 Remainder of the dialogue data (unmapped)
{
    ; ==============================================================================
    ; Thank you very much.
    ; Whenever you lose your shield,
    ; come back here again.
    ;-------------------------------------------------------------------------------
    Message_0167:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; line 2
    db $16, $21, $A5, $A7, $A1, $E3, $59, $BB ; Wh[en][ev][er ][you]⎵[lo]
    db $D0, $59, $E3, $2B, $59, $D1, $22, $1E ; [se]⎵[you]r⎵[sh]ie
    db $25, $1D, $42 ; ld,
    db $76 ; line 3
    db $9B, $1E, $59, $96, $9C, $59, $AF, $1E ; [com]e⎵[ba][ck]⎵[her]e
    db $59, $1A, $20, $8F, $41 ; ⎵ag[ain].
    db $7F ; end of message

    ; ==============================================================================
    ; Thank you very much.
    ; This is the Medicine of Life.
    ; It helps you recover your Life.
    ;-------------------------------------------------------------------------------
    Message_0168:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; line 2
    db $E7, $2C, $59, $B5, $59, $D8, $59, $0C ; [Thi]s⎵[is]⎵[the]⎵M
    db $1E, $9E, $1C, $B4, $1E, $59, $C6, $59 ; e[di]c[in]e⎵[of]⎵
    db $0B, $22, $1F, $1E, $41 ; Life.
    db $76 ; line 3
    db $08, $2D, $59, $21, $1E, $25, $29, $2C ; It⎵helps
    db $59, $E3, $59, $CE, $1C, $28, $DD, $59 ; ⎵[you]⎵[re]co[ver]⎵
    db $E3, $2B, $59, $0B, $22, $1F, $1E, $41 ; [you]r⎵Life.
    db $7F ; end of message

    ; ==============================================================================
    ; Thank you very much.
    ; These are Arrows.  You can't
    ; use them without a Bow.
    ;-------------------------------------------------------------------------------
    Message_0169:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; line 2
    db $E6, $D0, $59, $8D, $00, $2B, $2B, $28 ; [The][se]⎵[are ]Arro
    db $30, $2C, $41, $8A, $E8, $59, $1C, $93 ; ws.[  ][You]⎵c[an]
    db $51, $2D ; 't
    db $76 ; line 3
    db $2E, $D0, $59, $D8, $26, $59, $DE, $C5 ; u[se]⎵[the]m⎵[with][out ]
    db $1A, $59, $01, $28, $30, $41 ; a⎵Bow.
    db $7F ; end of message

    ; ==============================================================================
    ; These are Bombs.
    ; Did you know you can pick up
    ; a Bomb you already placed ?
    ; (Press the Ⓐ Button).
    ;-------------------------------------------------------------------------------
    Message_016A:
    db $E6, $D0, $59, $8D, $01, $28, $26, $1B ; [The][se]⎵[are ]Bomb
    db $2C, $41 ; s.
    db $75 ; line 2
    db $03, $22, $1D, $59, $E3, $59, $B8, $59 ; Did⎵[you]⎵[know]⎵
    db $E3, $59, $99, $29, $22, $9C, $59, $DC ; [you]⎵[can ]pi[ck]⎵[up]
    db $76 ; line 3
    db $1A, $59, $01, $28, $26, $1B, $59, $E3 ; a⎵Bomb⎵[you]
    db $59, $1A, $25, $CE, $1A, $1D, $32, $59 ; ⎵al[re]ady⎵
    db $29, $BA, $1C, $A4, $3F ; p[la]c[ed ]?
    db $7E ; wait for key
    db $73 ; scroll text
    db $45, $0F, $CE, $2C, $2C, $59, $D8, $59 ; (P[re]ss⎵[the]⎵
    db $5B, $59, $01, $2E, $2D, $DA, $27, $46 ; Ⓐ⎵But[to]n)
    db $41 ; .
    db $7F ; end of message

    ; ==============================================================================
    ; Thank you very much.
    ; That is a Bee.  Don't ask me
    ; what it is used for, either.
    ;-------------------------------------------------------------------------------
    Message_016B:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; line 2
    db $E5, $2D, $59, $B5, $59, $1A, $59, $01 ; [Tha]t⎵[is]⎵a⎵B
    db $1E, $1E, $41, $8A, $03, $C7, $51, $2D ; ee.[  ]D[on]'t
    db $59, $1A, $2C, $24, $59, $BE ; ⎵ask⎵[me]
    db $76 ; line 3
    db $E1, $91, $B6, $59, $B5, $59, $2E, $D0 ; [wh][at ][it]⎵[is]⎵u[se]
    db $1D, $59, $A8, $42, $59, $1E, $B6, $AF ; d⎵[for],⎵e[it][her]
    db $41 ; .
    db $7F ; end of message

    ; ==============================================================================
    ; Thank you very much.
    ; You can recover one Heart.
    ;-------------------------------------------------------------------------------
    Message_016C:
    db $E5, $27, $24, $59, $E3, $59, $DD, $32 ; [Tha]nk⎵[you]⎵[ver]y
    db $59, $BF, $1C, $21, $41 ; ⎵[mu]ch.
    db $75 ; line 2
    db $E8, $59, $99, $CE, $1C, $28, $DD, $59 ; [You]⎵[can ][re]co[ver]⎵
    db $C7, $1E, $59, $07, $A2, $2D, $41 ; [on]e⎵H[ear]t.
    db $7F ; end of message

    ; ==============================================================================
    ; No no no…  I can't sell the
    ; merchandise because you don't
    ; have an empty bottle.
    ;-------------------------------------------------------------------------------
    Message_016D:
    db $0D, $28, $59, $27, $28, $59, $27, $28 ; No⎵no⎵no
    db $43, $8A, $08, $59, $1C, $93, $51, $2D ; …[  ]I⎵c[an]'t
    db $59, $D0, $25, $25, $59, $D8 ; ⎵[se]ll⎵[the]
    db $75 ; line 2
    db $BE, $2B, $1C, $B1, $27, $9E, $D0, $59 ; [me]rc[ha]n[di][se]⎵
    db $97, $1C, $1A, $2E, $D0, $59, $E3, $59 ; [be]cau[se]⎵[you]⎵
    db $9F, $27, $51, $2D ; [do]n't
    db $76 ; line 3
    db $AD, $59, $93, $59, $1E, $26, $29, $2D ; [have]⎵[an]⎵empt
    db $32, $59, $98, $2D, $2D, $25, $1E, $41 ; y⎵[bo]ttle.
    db $7F ; end of message

    ; ==============================================================================
    ; You can't carry any more
    ; now, but you may need
    ; some later!
    ;-------------------------------------------------------------------------------
    Message_016E:
    db $E8, $59, $1C, $93, $51, $2D, $59, $1C ; [You]⎵c[an]'t⎵c
    db $1A, $2B, $2B, $32, $59, $93, $32, $59 ; arry⎵[an]y⎵
    db $26, $C8, $1E ; m[or]e
    db $75 ; line 2
    db $27, $28, $30, $42, $59, $1B, $2E, $2D ; now,⎵but
    db $59, $E3, $59, $BD, $32, $59, $27, $1E ; ⎵[you]⎵[ma]y⎵ne
    db $1E, $1D ; ed
    db $76 ; line 3
    db $CF, $59, $BA, $D6, $3E ; [some]⎵[la][ter]!
    db $7F ; end of message

    ; ==============================================================================
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
    ;-------------------------------------------------------------------------------
    Message_016F:
    db $08, $59, $27, $A7, $A1, $22, $BD, $20 ; I⎵n[ev][er ]i[ma]g
    db $B4, $A4, $1A, $59, $98, $32, $59, $25 ; [in][ed ]a⎵[bo]y⎵l
    db $22, $24, $1E, $59, $E3 ; ike⎵[you]
    db $75 ; line 2
    db $1C, $28, $2E, $25, $1D, $59, $AA, $BE ; could⎵[give ][me]
    db $59, $D2, $59, $BF, $1C, $21, $59, $DB ; ⎵[so]⎵[mu]ch⎵[tr]
    db $28, $2E, $95, $41 ; ou[ble].
    db $76 ; line 3
    db $08, $2D, $8B, $2E, $27, $97, $25, $22 ; It['s ]un[be]li
    db $A7, $1A, $95, $59, $D7, $2D, $59, $E3 ; [ev]a[ble]⎵[tha]t⎵[you]
    db $7E ; wait for key
    db $73 ; scroll text
    db $1D, $1E, $1F, $1E, $94, $A4, $26, $32 ; defe[at][ed ]my
    db $59, $1A, $25, $D6, $1E, $AC, $42, $59 ; ⎵al[ter]e[go],⎵
    db $00, $20, $1A, $21, $27, $22, $26 ; Agahnim
    db $73 ; scroll text
    db $D8, $59, $03, $1A, $2B, $24, $59, $16 ; [the]⎵Dark⎵W
    db $22, $33, $1A, $2B, $1D, $42, $59, $2D ; izard,⎵t
    db $E2, $1C, $1E, $3E ; [wi]ce!
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $2E, $2D, $59, $08, $59, $E2, $25 ; But⎵I⎵[wi]l
    db $25, $59, $27, $A7, $A1, $AA, $E3, $59 ; l⎵n[ev][er ][give ][you]⎵
    db $D8 ; [the]
    db $73 ; scroll text
    db $13, $2B, $22, $A8, $1C, $1E, $41, $8A ; Tri[for]ce.[  ]
    db $08, $59, $E2, $25, $25, $59, $9D, $DB ; I⎵[wi]ll⎵[des][tr]
    db $28, $32, $59, $E3 ; oy⎵[you]
    db $73 ; scroll text
    db $8C, $BD, $24, $1E, $59, $26, $32, $59 ; [and ][ma]ke⎵my⎵
    db $E2, $D1, $59, $DA, $59, $1C, $C7, $2A ; [wi][sh]⎵[to]⎵c[on]q
    db $2E, $A6 ; u[er]
    db $7E ; wait for key
    db $73 ; scroll text
    db $98, $2D, $21, $59, $0B, $B2, $8C, $03 ; [bo]th⎵L[ight ][and ]D
    db $1A, $2B, $24, $59, $16, $C8, $25, $1D ; ark⎵W[or]ld
    db $2C ; s
    db $73 ; scroll text
    db $9B, $1E, $59, $DB, $2E, $1E, $59, $DE ; [com]e⎵[tr]ue⎵[with]
    db $C5, $1D, $1E, $BA, $32, $41 ; [out ]de[la]y.
    db $7F ; end of message

    ; ==============================================================================
    ; You are doing well, lad.  But
    ; can you break through this
    ; secret technique of Darkness?
    ; En Garde!
    ;-------------------------------------------------------------------------------
    Message_0170:
    db $E8, $59, $8D, $9F, $B3, $E0, $25, $25 ; [You]⎵[are ][do][ing ][we]ll
    db $42, $59, $BA, $1D, $41, $8A, $01, $2E ; ,⎵[la]d.[  ]Bu
    db $2D ; t
    db $75 ; line 2
    db $99, $E3, $59, $1B, $CE, $1A, $24, $59 ; [can ][you]⎵b[re]ak⎵
    db $2D, $21, $2B, $28, $2E, $20, $21, $59 ; through⎵
    db $D9, $2C ; [thi]s
    db $76 ; line 3
    db $D0, $1C, $CE, $2D, $59, $2D, $1E, $1C ; [se]c[re]t⎵tec
    db $21, $27, $22, $2A, $2E, $1E, $59, $C6 ; hnique⎵[of]
    db $59, $03, $1A, $2B, $24, $27, $1E, $2C ; ⎵Darknes
    db $2C, $3F ; s?
    db $7E ; wait for key
    db $73 ; scroll text
    db $04, $27, $59, $06, $1A, $2B, $1D, $1E ; En⎵Garde
    db $3E ; !
    db $7F ; end of message

    ; ==============================================================================
    ; Hey kid, this is a secret hide-
    ; out for a gang of thieves!
    ; Don't enter without permission!
    ; By the way, I heard that one
    ; of our ex-members is staying
    ; at the entrance to the Desert.
    ;-------------------------------------------------------------------------------
    Message_0171:
    db $07, $1E, $32, $59, $24, $22, $1D, $42 ; Hey⎵kid,
    db $59, $D9, $2C, $59, $B5, $59, $1A, $59 ; ⎵[thi]s⎵[is]⎵a⎵
    db $D0, $1C, $CE, $2D, $59, $B0, $1D, $1E ; [se]c[re]t⎵[hi]de
    db $40 ; -
    db $75 ; line 2
    db $C5, $A8, $59, $1A, $59, $20, $93, $20 ; [out ][for]⎵a⎵g[an]g
    db $59, $C6, $59, $D9, $A7, $1E, $2C, $3E ; ⎵[of]⎵[thi][ev]es!
    db $76 ; line 3
    db $03, $C7, $51, $2D, $59, $A3, $A1, $DE ; D[on]'t⎵[ent][er ][with]
    db $C5, $C9, $26, $B5, $2C, $22, $C7, $3E ; [out ][per]m[is]si[on]!
    db $7E ; wait for key
    db $73 ; scroll text
    db $01, $32, $59, $D8, $59, $DF, $32, $42 ; By⎵[the]⎵[wa]y,
    db $59, $08, $59, $21, $A2, $1D, $59, $D7 ; ⎵I⎵h[ear]d⎵[tha]
    db $2D, $59, $C7, $1E ; t⎵[on]e
    db $73 ; scroll text
    db $C6, $59, $28, $2E, $2B, $59, $1E, $31 ; [of]⎵our⎵ex
    db $40, $BE, $26, $97, $2B, $2C, $59, $B5 ; -[me]m[be]rs⎵[is]
    db $59, $D3, $1A, $32, $B4, $20 ; ⎵[st]ay[in]g
    db $73 ; scroll text
    db $91, $D8, $59, $A3, $2B, $93, $1C, $1E ; [at ][the]⎵[ent]r[an]ce
    db $59, $DA, $59, $D8, $59, $03, $1E, $D0 ; ⎵[to]⎵[the]⎵De[se]
    db $2B, $2D, $41 ; rt.
    db $7F ; end of message

    ; ==============================================================================
    ; Yo [LINK]!  This house used
    ; to be a hideout for a gang of
    ; thieves.
    ; What was their leader's name…
    ; Oh yeah, his name was Blind and
    ; he hated bright light a lot.
    ;-------------------------------------------------------------------------------
    Message_0172:
    db $18, $28, $59, $6A, $3E, $8A, $E7, $2C ; Yo⎵[LINK]![  ][Thi]s
    db $59, $21, $28, $2E, $D0, $59, $2E, $D0 ; ⎵hou[se]⎵u[se]
    db $1D ; d
    db $75 ; line 2
    db $DA, $59, $97, $59, $1A, $59, $B0, $1D ; [to]⎵[be]⎵a⎵[hi]d
    db $1E, $C5, $A8, $59, $1A, $59, $20, $93 ; e[out ][for]⎵a⎵g[an]
    db $20, $59, $C6 ; g⎵[of]
    db $76 ; line 3
    db $D9, $A7, $1E, $2C, $41 ; [thi][ev]es.
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $DF, $2C, $59, $D8 ; W[ha]t⎵[wa]s⎵[the]
    db $22, $2B, $59, $25, $1E, $1A, $1D, $A6 ; ir⎵lead[er]
    db $8B, $27, $1A, $BE, $43 ; ['s ]na[me]…
    db $73 ; scroll text
    db $0E, $21, $59, $32, $1E, $1A, $21, $42 ; Oh⎵yeah,
    db $59, $B0, $2C, $59, $27, $1A, $BE, $59 ; ⎵[hi]s⎵na[me]⎵
    db $DF, $2C, $59, $01, $25, $B4, $1D, $59 ; [wa]s⎵Bl[in]d⎵
    db $90 ; [and]
    db $73 ; scroll text
    db $21, $1E, $59, $B1, $2D, $A4, $1B, $2B ; he⎵[ha]t[ed ]br
    db $B2, $25, $B2, $1A, $59, $BB, $2D, $41 ; [ight ]l[ight ]a⎵[lo]t.
    db $7F ; end of message

    ; ==============================================================================
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
    ;-------------------------------------------------------------------------------
    Message_0173:
    db $7A, $02 ; set draw speed
    db $6D, $00 ; set window position
    db $6B, $02 ; set window border
    db $16, $1E, $25, $9B, $1E, $42, $59, $6A ; Wel[com]e,⎵[LINK]
    db $43 ; …
    db $75 ; line 2
    db $08, $89, $1A, $26, $89, $D8, $89, $04 ; I[   ]am[   ][the][   ]E
    db $2C, $D0, $27, $1C, $1E, $89, $0E, $1F ; s[se]nce[   ]Of
    db $89, $E6 ; [   ][The]
    db $76 ; line 3
    db $13, $2B, $22, $A8, $1C, $1E, $41 ; Tri[for]ce.
    db $7E ; wait for key
    db $73 ; scroll text
    db $43, $89, $43, $89, $43 ; …[   ]…[   ]…
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $E6, $59, $13, $2B, $22, $A8, $1C, $1E ; [The]⎵Tri[for]ce
    db $59, $E2, $25, $25, $59, $20, $2B, $93 ; ⎵[wi]ll⎵gr[an]
    db $2D, $59, $D8 ; t⎵[the]
    db $75 ; line 2
    db $E2, $D1, $1E, $2C, $59, $B4, $59, $D8 ; [wi][sh]es⎵[in]⎵[the]
    db $59, $21, $A2, $2D, $59, $8C, $26, $B4 ; ⎵h[ear]t⎵[and ]m[in]
    db $1D, $59, $C6 ; d⎵[of]
    db $76 ; line 3
    db $D8, $59, $C9, $D2, $27, $59, $E1, $28 ; [the]⎵[per][so]n⎵[wh]o
    db $59, $DA, $2E, $9A, $2C, $59, $B6, $41 ; ⎵[to]u[che]s⎵[it].
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $08, $1F, $59, $1A, $59, $C9, $D2, $27 ; If⎵a⎵[per][so]n
    db $59, $DE, $59, $1A, $59, $AC, $28, $1D ; ⎵[with]⎵a⎵[go]od
    db $59, $21, $A2, $2D ; ⎵h[ear]t
    db $75 ; line 2
    db $DA, $2E, $9A, $2C, $59, $B6, $42, $59 ; [to]u[che]s⎵[it],⎵
    db $B6, $59, $E2, $25, $25, $59, $BD, $24 ; [it]⎵[wi]ll⎵[ma]k
    db $1E, $59, $B0, $2C, $59, $AC, $28, $1D ; e⎵[hi]s⎵[go]od
    db $76 ; line 3
    db $E2, $D1, $1E, $2C, $59, $9B, $1E, $59 ; [wi][sh]es⎵[com]e⎵
    db $DB, $2E, $1E, $43, $8A, $08, $1F, $59 ; [tr]ue…[  ]If⎵
    db $93, $59, $A7, $22, $25, $40 ; [an]⎵[ev]il-
    db $7E ; wait for key
    db $73 ; scroll text
    db $21, $A2, $2D, $A4, $C9, $D2, $27, $59 ; h[ear]t[ed ][per][so]n⎵
    db $DA, $2E, $9A, $2C, $59, $B6, $42, $59 ; [to]u[che]s⎵[it],⎵
    db $B6 ; [it]
    db $73 ; scroll text
    db $20, $2B, $93, $2D, $2C, $59, $B0, $2C ; gr[an]ts⎵[hi]s
    db $59, $A7, $22, $25, $59, $E2, $D1, $1E ; ⎵[ev]il⎵[wi][sh]e
    db $2C, $41 ; s.
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $E6, $59, $D3, $2B, $C7, $20, $A1, $D8 ; [The]⎵[st]r[on]g[er ][the]
    db $59, $E2, $D1, $42, $59, $D8 ; ⎵[wi][sh],⎵[the]
    db $75 ; line 2
    db $26, $C8, $1E, $59, $CB, $A6, $1F, $2E ; m[or]e⎵[pow][er]fu
    db $25, $59, $D8, $59, $13, $2B, $22, $A8 ; l⎵[the]⎵Tri[for]
    db $1C, $1E, $51, $2C ; ce's
    db $76 ; line 3
    db $1E, $31, $29, $CE, $2C, $2C, $22, $C7 ; exp[re]ssi[on]
    db $59, $C6, $59, $D7, $2D, $59, $E2, $D1 ; ⎵[of]⎵[tha]t⎵[wi][sh]
    db $41 ; .
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $06, $93, $C7, $8B, $E2, $D1, $59, $DF ; G[an][on]['s ][wi][sh]⎵[wa]
    db $2C, $59, $DA, $59, $1C, $C7, $2A, $2E ; s⎵[to]⎵c[on]qu
    db $A6 ; [er]
    db $75 ; line 2
    db $D8, $59, $30, $C8, $25, $1D, $41, $8A ; [the]⎵w[or]ld.[  ]
    db $E5, $2D, $59, $E2, $D1, $59, $1C, $B1 ; [Tha]t⎵[wi][sh]⎵c[ha]
    db $27, $20, $1E, $1D ; nged
    db $76 ; line 3
    db $D8, $59, $06, $28, $25, $1D, $A0, $0B ; [the]⎵Gold[en ]L
    db $8C, $DA, $59, $D8, $59, $03, $1A, $2B ; [and ][to]⎵[the]⎵Dar
    db $24 ; k
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $C8, $25, $1D, $41 ; W[or]ld.
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $06, $93, $C7, $59, $DF, $2C, $59, $1B ; G[an][on]⎵[wa]s⎵b
    db $2E, $22, $25, $9E, $27, $20, $59, $DC ; uil[di]ng⎵[up]
    db $59, $B0, $2C ; ⎵[hi]s
    db $75 ; line 2
    db $CB, $A1, $AF, $1E, $59, $D2, $59, $21 ; [pow][er ][her]e⎵[so]⎵h
    db $1E, $59, $1C, $28, $2E, $25, $1D, $59 ; e⎵could⎵
    db $1C, $C7, $2A, $2E, $A6 ; c[on]qu[er]
    db $76 ; line 3
    db $D8, $59, $0B, $B2, $16, $C8, $25, $1D ; [the]⎵L[ight ]W[or]ld
    db $59, $8C, $BD, $24, $1E, $59, $B0, $2C ; ⎵[and ][ma]ke⎵[hi]s
    db $7E ; wait for key
    db $73 ; scroll text
    db $E2, $D1, $59, $9B, $1E, $59, $9B, $CA ; [wi][sh]⎵[com]e⎵[com][ple]
    db $2D, $1E, $B9, $DB, $2E, $1E, $41 ; te[ly ][tr]ue.
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $01, $2E, $2D, $59, $27, $28, $30, $42 ; But⎵now,
    db $59, $E3, $59, $AD, $59, $DA, $2D, $1A ; ⎵[you]⎵[have]⎵[to]ta
    db $25, $25, $32 ; lly
    db $75 ; line 2
    db $9D, $DB, $28, $32, $A4, $06, $93, $C7 ; [des][tr]oy[ed ]G[an][on]
    db $41, $8A, $07, $B5, $59, $03, $1A, $2B ; .[  ]H[is]⎵Dar
    db $24 ; k
    db $76 ; line 3
    db $16, $C8, $25, $1D, $59, $E2, $25, $25 ; W[or]ld⎵[wi]ll
    db $59, $2F, $93, $B5, $21, $41 ; ⎵v[an][is]h.
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $E6, $59, $13, $2B, $22, $A8, $1C, $1E ; [The]⎵Tri[for]ce
    db $59, $B5, $59, $DF, $B6, $B3, $A8, $59 ; ⎵[is]⎵[wa][it][ing ][for]⎵
    db $1A ; a
    db $75 ; line 2
    db $27, $1E, $30, $59, $28, $30, $27, $A6 ; new⎵own[er]
    db $41, $8A, $08, $2D, $2C, $59, $06, $28 ; .[  ]Its⎵Go
    db $25, $1D, $A0, $0F, $28, $E0, $2B, $59 ; ld[en ]Po[we]r⎵
    db $B5 ; [is]
    db $76 ; line 3
    db $B4, $59, $E3, $2B, $59, $B1, $27, $1D ; [in]⎵[you]r⎵[ha]nd
    db $2C, $43 ; s…
    db $7A, $01 ; set draw speed
    db $7E ; wait for key
    db $74 ; line 1
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $75 ; line 2
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $76 ; line 3
    db $88, $88, $88, $88, $88, $88, $88, $88 ; [    ][    ][    ][    ][    ][    ][    ][    ]
    db $88, $88, $8A ; [    ][    ][  ]
    db $7A, $02 ; set draw speed
    db $74 ; line 1
    db $0D, $28, $30, $42, $59, $DA, $2E, $1C ; Now,⎵[to]uc
    db $21, $59, $B6, $59, $DE, $59, $1A, $59 ; h⎵[it]⎵[with]⎵a⎵
    db $E2, $D1, $59, $B4 ; [wi][sh]⎵[in]
    db $75 ; line 2
    db $E3, $2B, $59, $21, $A2, $2D, $41 ; [you]r⎵h[ear]t.
    db $76 ; line 3
    db $43, $8A, $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…[  ]…
    db $7F ; end of message

    ; ==============================================================================
    ; All right! Take it, thief!
    ;-------------------------------------------------------------------------------
    Message_0174:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $3E, $59, $13, $1A, $24, $1E, $59 ; t!⎵Take⎵
    db $B6, $42, $59, $D9, $1E, $1F, $3E ; [it],⎵[thi]ef!
    db $7F ; end of message

    ; ==============================================================================
    ; Whoa…  I saw her.
    ; A very nice young lady at the
    ; Waterfall Of Wishing in the
    ; hills where the river
    ; begins…
    ; [LINK], you should meet her
    ; at least once.  I'm sure you will
    ; like her.
    ;-------------------------------------------------------------------------------
    Message_0175:
    db $16, $21, $28, $1A, $43, $8A, $08, $59 ; Whoa…[  ]I⎵
    db $2C, $1A, $30, $59, $AF, $41 ; saw⎵[her].
    db $75 ; line 2
    db $00, $59, $DD, $32, $59, $27, $22, $1C ; A⎵[ver]y⎵nic
    db $1E, $59, $E3, $27, $20, $59, $BA, $1D ; e⎵[you]ng⎵[la]d
    db $32, $59, $91, $D8 ; y⎵[at ][the]
    db $76 ; line 3
    db $16, $94, $A6, $1F, $8E, $0E, $1F, $59 ; W[at][er]f[all ]Of⎵
    db $16, $B5, $B0, $27, $20, $59, $B4, $59 ; W[is][hi]ng⎵[in]⎵
    db $D8 ; [the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $B0, $25, $25, $2C, $59, $E1, $A6, $1E ; [hi]lls⎵[wh][er]e
    db $59, $D8, $59, $2B, $22, $DD ; ⎵[the]⎵ri[ver]
    db $73 ; scroll text
    db $97, $20, $B4, $2C, $43 ; [be]g[in]s…
    db $73 ; scroll text
    db $6A, $42, $59, $E3, $59, $D1, $28, $2E ; [LINK],⎵[you]⎵[sh]ou
    db $25, $1D, $59, $BE, $1E, $2D, $59, $AF ; ld⎵[me]et⎵[her]
    db $7E ; wait for key
    db $73 ; scroll text
    db $91, $25, $1E, $92, $59, $C7, $1C, $1E ; [at ]le[ast]⎵[on]ce
    db $41, $8A, $08, $51, $26, $59, $2C, $2E ; .[  ]I'm⎵su
    db $CD, $E3, $59, $E2, $25, $25 ; [re ][you]⎵[wi]ll
    db $73 ; scroll text
    db $25, $22, $24, $1E, $59, $AF, $41 ; like⎵[her].
    db $7F ; end of message

    ; ==============================================================================
    ; Take some Rupees, but don't
    ; tell anyone I gave them to you.
    ; Keep it between us, OK?
    ;-------------------------------------------------------------------------------
    Message_0176:
    db $13, $1A, $24, $1E, $59, $CF, $59, $11 ; Take⎵[some]⎵R
    db $DC, $1E, $1E, $2C, $42, $59, $1B, $2E ; [up]ees,⎵bu
    db $2D, $59, $9F, $27, $51, $2D ; t⎵[do]n't
    db $75 ; line 2
    db $2D, $1E, $25, $25, $59, $93, $32, $C7 ; tell⎵[an]y[on]
    db $1E, $59, $08, $59, $20, $1A, $2F, $1E ; e⎵I⎵gave
    db $59, $D8, $26, $59, $DA, $59, $E3, $41 ; ⎵[the]m⎵[to]⎵[you].
    db $76 ; line 3
    db $0A, $1E, $1E, $29, $59, $B6, $59, $97 ; Keep⎵[it]⎵[be]
    db $2D, $E0, $A0, $2E, $2C, $42, $59, $0E ; t[we][en ]us,⎵O
    db $0A, $3F ; K?
    db $7F ; end of message

    ; ==============================================================================
    ; Check out the cave east of
    ; Lake Hylia.  Strange and
    ; wonderful things live in it…
    ;-------------------------------------------------------------------------------
    Message_0177:
    db $02, $21, $1E, $9C, $59, $C5, $D8, $59 ; Che[ck]⎵[out ][the]⎵
    db $1C, $1A, $2F, $1E, $59, $1E, $92, $59 ; cave⎵e[ast]⎵
    db $C6 ; [of]
    db $75 ; line 2
    db $0B, $1A, $24, $1E, $59, $07, $32, $25 ; Lake⎵Hyl
    db $22, $1A, $41, $8A, $12, $DB, $93, $20 ; ia.[  ]S[tr][an]g
    db $1E, $59, $90 ; e⎵[and]
    db $76 ; line 3
    db $30, $C7, $1D, $A6, $1F, $2E, $25, $59 ; w[on]d[er]ful⎵
    db $D5, $20, $2C, $59, $25, $22, $2F, $1E ; [thin]gs⎵live
    db $59, $B4, $59, $B6, $43 ; ⎵[in]⎵[it]…
    db $7F ; end of message

    ; ==============================================================================
    ; You can earn a lot of Rupees
    ; by defeating enemies.  It's
    ; the secret of my success…
    ;-------------------------------------------------------------------------------
    Message_0178:
    db $E8, $59, $99, $A2, $27, $59, $1A, $59 ; [You]⎵[can ][ear]n⎵a⎵
    db $BB, $2D, $59, $C6, $59, $11, $DC, $1E ; [lo]t⎵[of]⎵R[up]e
    db $1E, $2C ; es
    db $75 ; line 2
    db $1B, $32, $59, $1D, $1E, $1F, $1E, $94 ; by⎵defe[at]
    db $B3, $A5, $1E, $26, $22, $1E, $2C, $41 ; [ing ][en]emies.
    db $8A, $08, $2D, $51, $2C ; [  ]It's
    db $76 ; line 3
    db $D8, $59, $D0, $1C, $CE, $2D, $59, $C6 ; [the]⎵[se]c[re]t⎵[of]
    db $59, $26, $32, $59, $2C, $2E, $1C, $1C ; ⎵my⎵succ
    db $1E, $2C, $2C, $43 ; ess…
    db $7F ; end of message

    ; ==============================================================================
    ; [LINK], did you know that if
    ; you destroy frozen enemies
    ; with the Hammer, you will often
    ; get a Magic Decanter?
    ;-------------------------------------------------------------------------------
    Message_0179:
    db $6A, $42, $59, $9E, $1D, $59, $E3, $59 ; [LINK],⎵[di]d⎵[you]⎵
    db $B8, $59, $D7, $2D, $59, $22, $1F ; [know]⎵[tha]t⎵if
    db $75 ; line 2
    db $E3, $59, $9D, $DB, $28, $32, $59, $A9 ; [you]⎵[des][tr]oy⎵[fro]
    db $33, $A0, $A5, $1E, $26, $22, $1E, $2C ; z[en ][en]emies
    db $76 ; line 3
    db $DE, $59, $D8, $59, $07, $1A, $26, $BE ; [with]⎵[the]⎵Ham[me]
    db $2B, $42, $59, $E3, $59, $E2, $25, $25 ; r,⎵[you]⎵[wi]ll
    db $59, $C6, $2D, $A5 ; ⎵[of]t[en]
    db $7E ; wait for key
    db $73 ; scroll text
    db $AB, $59, $1A, $59, $0C, $1A, $20, $22 ; [get]⎵a⎵Magi
    db $1C, $59, $03, $1E, $1C, $93, $D6, $3F ; c⎵Dec[an][ter]?
    db $7F ; end of message

    ; ==============================================================================
    ; Tra la la, look for
    ; Sahasrahla.
    ; …  …  …
    ;-------------------------------------------------------------------------------
    Message_017A:
    db $13, $2B, $1A, $59, $BA, $59, $BA, $42 ; Tra⎵[la]⎵[la],
    db $59, $BB, $28, $24, $59, $A8 ; ⎵[lo]ok⎵[for]
    db $75 ; line 2
    db $12, $1A, $AE, $2B, $1A, $21, $BA, $41 ; Sa[has]rah[la].
    db $76 ; line 3
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $7F ; end of message

    ; ==============================================================================
    ; Oh yah, you found Sahasrahla!
    ; …  …  …
    ; Good job la la!
    ;-------------------------------------------------------------------------------
    Message_017B:
    db $0E, $21, $59, $32, $1A, $21, $42, $59 ; Oh⎵yah,⎵
    db $E3, $59, $1F, $C4, $59, $12, $1A, $AE ; [you]⎵f[ound]⎵Sa[has]
    db $2B, $1A, $21, $BA, $3E ; rah[la]!
    db $75 ; line 2
    db $43, $8A, $43, $8A, $43 ; …[  ]…[  ]…
    db $76 ; line 3
    db $06, $28, $28, $1D, $59, $23, $28, $1B ; Good⎵job
    db $59, $BA, $59, $BA, $3E ; ⎵[la]⎵[la]!
    db $7F ; end of message

    ; ==============================================================================
    ; I'm sorry, but you don't
    ; seem to have enough Rupees…
    ;-------------------------------------------------------------------------------
    Message_017C:
    db $08, $51, $26, $59, $D2, $2B, $2B, $32 ; I'm⎵[so]rry
    db $42, $59, $1B, $2E, $2D, $59, $E3, $59 ; ,⎵but⎵[you]⎵
    db $9F, $27, $51, $2D ; [do]n't
    db $75 ; line 2
    db $D0, $1E, $26, $59, $DA, $59, $AD, $59 ; [se]em⎵[to]⎵[have]⎵
    db $A5, $28, $2E, $20, $21, $59, $11, $DC ; [en]ough⎵R[up]
    db $1E, $1E, $2C, $43 ; ees…
    db $7F ; end of message

    ; ==============================================================================
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
    ;-------------------------------------------------------------------------------
    Message_017D:
    db $02, $25, $2E, $9C, $59, $1C, $25, $2E ; Clu[ck]⎵clu
    db $9C, $43, $8A, $16, $B1, $2D, $3F, $3E ; [ck]…[  ]W[ha]t?!
    db $75 ; line 2
    db $E8, $59, $2D, $2E, $2B, $27, $A4, $BE ; [You]⎵turn[ed ][me]
    db $59, $B4, $DA, $59, $1A, $59, $21, $2E ; ⎵[in][to]⎵a⎵hu
    db $BC, $41 ; [man].
    db $76 ; line 3
    db $08, $59, $99, $A7, $A0, $2C, $29, $1E ; I⎵[can ][ev][en ]spe
    db $1A, $24, $3E ; ak!
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $B1, $42, $59, $B6, $59, $BF, $D3 ; A[ha],⎵[it]⎵[mu][st]
    db $59, $97, $59, $E3, $59, $E1, $28, $59 ; ⎵[be]⎵[you]⎵[wh]o⎵
    db $B5 ; [is]
    db $73 ; scroll text
    db $1A, $25, $DF, $32, $2C, $59, $2D, $1E ; al[wa]ys⎵te
    db $1A, $2C, $B3, $26, $32, $59, $1F, $2B ; as[ing ]my⎵fr
    db $22, $A5, $1D, $2C, $41 ; i[en]ds.
    db $73 ; scroll text
    db $E6, $59, $16, $1E, $94, $AF, $1C, $28 ; [The]⎵We[at][her]co
    db $9C, $59, $B5, $59, $1A, $25, $DF, $32 ; [ck]⎵[is]⎵al[wa]y
    db $2C ; s
    db $7E ; wait for key
    db $73 ; scroll text
    db $DF, $2D, $1C, $B0, $27, $20, $59, $E3 ; [wa]tc[hi]ng⎵[you]
    db $59, $B1, $2B, $1A, $2C, $2C, $59, $D8 ; ⎵[ha]rass⎵[the]
    db $26, $41 ; m.
    db $73 ; scroll text
    db $16, $1E, $25, $25, $42, $59, $D9, $2C ; Well,⎵[thi]s
    db $59, $21, $2E, $BC, $59, $D1, $1A, $29 ; ⎵hu[man]⎵[sh]ap
    db $1E, $59, $B5 ; e⎵[is]
    db $73 ; scroll text
    db $2E, $27, $9B, $A8, $2D, $1A, $95, $59 ; un[com][for]ta[ble]⎵
    db $A8, $59, $BE, $41 ; [for]⎵[me].
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $21, $21, $21, $42, $59, $08, $59 ; Ahhh,⎵I⎵
    db $DF, $27, $2D, $59, $DA, $59, $97, $59 ; [wa]nt⎵[to]⎵[be]⎵
    db $1A, $59, $1C, $B0, $9C, $A5 ; a⎵c[hi][ck][en]
    db $73 ; scroll text
    db $1A, $20, $8F, $3E, $8A, $02, $25, $2E ; ag[ain]![  ]Clu
    db $9C, $59, $1C, $25, $2E, $9C, $43 ; [ck]⎵clu[ck]…
    db $7F ; end of message

    ; ==============================================================================
    ; Pay me 20 Rupees and I'll let
    ; you open one chest.  You can
    ; keep what is inside.
    ; What will you do?
    ;     >  Open A Chest
    ;         Escape
    ;-------------------------------------------------------------------------------
    Message_017E:
    db $0F, $1A, $32, $59, $BE, $59, $36, $34 ; Pay⎵[me]⎵20
    db $59, $11, $DC, $1E, $1E, $2C, $59, $8C ; ⎵R[up]ees⎵[and ]
    db $08, $51, $25, $25, $59, $25, $1E, $2D ; I'll⎵let
    db $75 ; line 2
    db $E3, $59, $C3, $59, $C7, $1E, $59, $9A ; [you]⎵[open]⎵[on]e⎵[che]
    db $D3, $41, $8A, $E8, $59, $1C, $93 ; [st].[  ][You]⎵c[an]
    db $76 ; line 3
    db $24, $1E, $1E, $29, $59, $E1, $91, $B5 ; keep⎵[wh][at ][is]
    db $59, $B4, $2C, $22, $1D, $1E, $41 ; ⎵[in]side.
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $73 ; scroll text
    db $88, $44, $8A, $0E, $29, $A0, $00, $59 ; [    ]>[  ]Op[en ]A⎵
    db $02, $21, $1E, $D3 ; Che[st]
    db $73 ; scroll text
    db $88, $88, $04, $2C, $1C, $1A, $29, $1E ; [    ][    ]Escape
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==============================================================================
    ; All right!  Open the chest you
    ; like!
    ;-------------------------------------------------------------------------------
    Message_017F:
    db $00, $25, $25, $59, $2B, $22, $20, $21 ; All⎵righ
    db $2D, $3E, $8A, $0E, $29, $A0, $D8, $59 ; t![  ]Op[en ][the]⎵
    db $9A, $D3, $59, $E3 ; [che][st]⎵[you]
    db $75 ; line 2
    db $25, $22, $24, $1E, $3E ; like!
    db $7F ; end of message

    ; ==============================================================================
    ; Oh, I see…  Too bad.
    ; Drop by again after collecting
    ; Rupees.
    ;-------------------------------------------------------------------------------
    Message_0180:
    db $0E, $21, $42, $59, $08, $59, $D0, $1E ; Oh,⎵I⎵[se]e
    db $43, $8A, $13, $28, $28, $59, $96, $1D ; …[  ]Too⎵[ba]d
    db $41 ; .
    db $75 ; line 2
    db $03, $2B, $28, $29, $59, $1B, $32, $59 ; Drop⎵by⎵
    db $1A, $20, $8F, $59, $1A, $1F, $D4, $1C ; ag[ain]⎵af[ter ]c
    db $28, $25, $25, $1E, $1C, $2D, $B4, $20 ; ollect[in]g
    db $76 ; line 3
    db $11, $DC, $1E, $1E, $2C, $41 ; R[up]ees.
    db $7F ; end of message

    ; ==============================================================================
    ; For 100 Rupees, I'll let you
    ; open one chest and keep the
    ; treasure that is inside.
    ; What will you do?
    ;     >  Open A Chest
    ;         Escape
    ;-------------------------------------------------------------------------------
    Message_0181:
    db $05, $C8, $59, $35, $34, $34, $59, $11 ; F[or]⎵100⎵R
    db $DC, $1E, $1E, $2C, $42, $59, $08, $51 ; [up]ees,⎵I'
    db $25, $25, $59, $25, $1E, $2D, $59, $E3 ; ll⎵let⎵[you]
    db $75 ; line 2
    db $C3, $59, $C7, $1E, $59, $9A, $D3, $59 ; [open]⎵[on]e⎵[che][st]⎵
    db $8C, $24, $1E, $1E, $29, $59, $D8 ; [and ]keep⎵[the]
    db $76 ; line 3
    db $DB, $1E, $1A, $2C, $2E, $CD, $D7, $2D ; [tr]easu[re ][tha]t
    db $59, $B5, $59, $B4, $2C, $22, $1D, $1E ; ⎵[is]⎵[in]side
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $E2, $25, $25, $59 ; W[ha]t⎵[wi]ll⎵
    db $E3, $59, $9F, $3F ; [you]⎵[do]?
    db $73 ; scroll text
    db $88, $44, $8A, $0E, $29, $A0, $00, $59 ; [    ]>[  ]Op[en ]A⎵
    db $02, $21, $1E, $D3 ; Che[st]
    db $73 ; scroll text
    db $88, $88, $04, $2C, $1C, $1A, $29, $1E ; [    ][    ]Escape
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==============================================================================
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
    ;-------------------------------------------------------------------------------
    Message_0182:
    db $07, $22, $42, $59, $6A, $41, $8A, $12 ; Hi,⎵[LINK].[  ]S
    db $C8, $2B, $32, $59, $1A, $98, $2E, $2D ; [or]ry⎵a[bo]ut
    db $59, $26, $32 ; ⎵my
    db $75 ; line 2
    db $32, $1A, $2B, $1D, $41, $8A, $08, $2D ; yard.[  ]It
    db $8B, $1A, $59, $25, $B6, $2D, $25, $1E ; ['s ]a⎵l[it]tle
    db $59, $28, $DD ; ⎵o[ver]
    db $76 ; line 3
    db $20, $2B, $28, $30, $27, $41, $8A, $E5 ; grown.[  ][Tha]
    db $27, $24, $2C, $59, $A8, $59, $2F, $B5 ; nks⎵[for]⎵v[is]
    db $B6, $B4, $20, $41 ; [it][in]g.
    db $7E ; wait for key
    db $73 ; scroll text
    db $08, $51, $26, $59, $20, $BA, $1D, $59 ; I'm⎵g[la]d⎵
    db $DA, $59, $AD, $59, $9B, $29, $93, $32 ; [to]⎵[have]⎵[com]p[an]y
    db $59, $DA ; ⎵[to]
    db $73 ; scroll text
    db $2D, $1A, $25, $24, $59, $DA, $41, $8A ; talk⎵[to].[  ]
    db $08, $59, $E2, $25, $25, $59, $2D, $1E ; I⎵[wi]ll⎵te
    db $25, $25, $59, $E3, $59, $93 ; ll⎵[you]⎵[an]
    db $73 ; scroll text
    db $B4, $D6, $1E, $D3, $B3, $D3, $C8, $32 ; [in][ter]e[st][ing ][st][or]y
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $CD, $B5, $59, $1A, $59, $BA, $24 ; [The][re ][is]⎵a⎵[la]k
    db $1E, $59, $2C, $E2, $26, $26, $B3, $DE ; e⎵s[wi]mm[ing ][with]
    db $73 ; scroll text
    db $19, $C8, $1A, $2C, $59, $91, $D8, $59 ; Z[or]as⎵[at ][the]⎵
    db $D2, $2E, $2B, $1C, $1E, $59, $C6, $59 ; [so]urce⎵[of]⎵
    db $D8 ; [the]
    db $73 ; scroll text
    db $2B, $22, $DD, $42, $59, $1B, $2E, $2D ; ri[ver],⎵but
    db $59, $B6, $59, $B5, $59, $B1, $2B, $1D ; ⎵[it]⎵[is]⎵[ha]rd
    db $59, $DA, $59, $1F, $B4, $1D, $41 ; ⎵[to]⎵f[in]d.
    db $7E ; wait for key
    db $73 ; scroll text
    db $E6, $59, $DB, $1E, $1A, $2C, $2E, $CD ; [The]⎵[tr]easu[re ]
    db $C6, $59, $19, $C8, $1A, $59, $99, $2D ; [of]⎵Z[or]a⎵[can ]t
    db $2E, $2B, $27 ; urn
    db $73 ; scroll text
    db $29, $1E, $28, $CA, $59, $B4, $DA, $59 ; peo[ple]⎵[in][to]⎵
    db $1F, $B5, $21, $41, $8A, $07, $1E, $21 ; f[is]h.[  ]Heh
    db $59, $21, $1E, $21, $59, $21, $1E, $21 ; ⎵heh⎵heh
    db $41 ; .
    db $73 ; scroll text
    db $08, $51, $1D, $59, $BB, $2F, $1E, $59 ; I'd⎵[lo]ve⎵
    db $DA, $59, $D0, $1E, $59, $D7, $2D, $41 ; [to]⎵[se]e⎵[tha]t.
    db $7F ; end of message

    ; ==============================================================================
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
    ;-------------------------------------------------------------------------------
    Message_0183:
    db $08, $59, $AD, $C0, $B1, $1D, $59, $1A ; I⎵[have][n't ][ha]d⎵a
    db $59, $1C, $B1, $27, $1C, $1E, $59, $DA ; ⎵c[ha]nce⎵[to]
    db $59, $DB, $22, $26 ; ⎵[tr]im
    db $75 ; line 2
    db $26, $32, $59, $21, $1E, $1D, $20, $1E ; my⎵hedge
    db $2C, $59, $CE, $1C, $A3, $25, $32, $41 ; s⎵[re]c[ent]ly.
    db $8A, $E5, $27, $24, $2C ; [  ][Tha]nks
    db $76 ; line 3
    db $A8, $59, $2F, $B5, $B6, $B3, $93, $32 ; [for]⎵v[is][it][ing ][an]y
    db $DF, $32, $43 ; [wa]y…
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $59, $E1, $22, $25, $1E, $59, $1A ; A⎵[wh]ile⎵a
    db $AC, $42, $59, $D8, $CD, $DF, $2C, $59 ; [go],⎵[the][re ][wa]s⎵
    db $1A, $59, $98, $32, $59, $B4 ; a⎵[bo]y⎵[in]
    db $73 ; scroll text
    db $D9, $2C, $59, $2F, $22, $25, $BA, $20 ; [thi]s⎵vil[la]g
    db $1E, $59, $E1, $28, $59, $1C, $28, $2E ; e⎵[wh]o⎵cou
    db $25, $1D, $59, $2D, $1A, $25, $24, $59 ; ld⎵talk⎵
    db $DA ; [to]
    db $73 ; scroll text
    db $93, $22, $BD, $25, $2C, $59, $DE, $59 ; [an]i[ma]ls⎵[with]⎵
    db $B0, $2C, $59, $05, $25, $2E, $2D, $1E ; [hi]s⎵Flute
    db $41 ; .
    db $7E ; wait for key
    db $73 ; scroll text
    db $07, $1E, $59, $B1, $1D, $59, $1A, $59 ; He⎵[ha]d⎵a⎵
    db $29, $1E, $2D, $59, $1B, $22, $2B, $1D ; pet⎵bird
    db $59, $D7, $2D, $59, $1F, $25, $1E, $30 ; ⎵[tha]t⎵flew
    db $73 ; scroll text
    db $DE, $59, $B0, $26, $59, $A7, $A6, $32 ; [with]⎵[hi]m⎵[ev][er]y
    db $E1, $A6, $1E, $42, $59, $1B, $2E, $2D ; [wh][er]e,⎵but
    db $73 ; scroll text
    db $21, $1E, $59, $E0, $27, $2D, $59, $DA ; he⎵[we]nt⎵[to]
    db $59, $D8, $59, $26, $28, $2E, $27, $2D ; ⎵[the]⎵mount
    db $8F, $59, $90 ; [ain]⎵[and]
    db $7E ; wait for key
    db $73 ; scroll text
    db $27, $A7, $A1, $CE, $2D, $2E, $2B, $27 ; n[ev][er ][re]turn
    db $1E, $1D, $41 ; ed.
    db $7F ; end of message

    ; ==============================================================================
    ; >Start From [LINK]'s House
    ;   Start From Sanctuary
    ;-------------------------------------------------------------------------------
    Message_0184:
    db $6D, $00 ; set window position
    db $7A, $00 ; set draw speed
    db $44, $12, $2D, $1A, $2B, $2D, $59, $05 ; >Start⎵F
    db $2B, $28, $26, $59, $6A, $8B, $07, $28 ; rom⎵[LINK]['s ]Ho
    db $2E, $D0 ; u[se]
    db $75 ; line 2
    db $8A, $12, $2D, $1A, $2B, $2D, $59, $05 ; [  ]Start⎵F
    db $2B, $28, $26, $59, $12, $93, $1C, $2D ; rom⎵S[an]ct
    db $2E, $1A, $2B, $32 ; uary
    db $72 ; choose 2 high
    db $7F ; end of message

    ; ==============================================================================
    ; >Start From [LINK]'s House
    ;   Start From Sanctuary
    ;   Start From The Mountain Cave
    ;-------------------------------------------------------------------------------
    Message_0185:
    db $6D, $00 ; set window position
    db $7A, $00 ; set draw speed
    db $44, $12, $2D, $1A, $2B, $2D, $59, $05 ; >Start⎵F
    db $2B, $28, $26, $59, $6A, $8B, $07, $28 ; rom⎵[LINK]['s ]Ho
    db $2E, $D0 ; u[se]
    db $75 ; line 2
    db $8A, $12, $2D, $1A, $2B, $2D, $59, $05 ; [  ]Start⎵F
    db $2B, $28, $26, $59, $12, $93, $1C, $2D ; rom⎵S[an]ct
    db $2E, $1A, $2B, $32 ; uary
    db $76 ; line 3
    db $8A, $12, $2D, $1A, $2B, $2D, $59, $05 ; [  ]Start⎵F
    db $2B, $28, $26, $59, $E6, $59, $0C, $28 ; rom⎵[The]⎵Mo
    db $2E, $27, $2D, $8F, $59, $02, $1A, $2F ; unt[ain]⎵Cav
    db $1E ; e
    db $71 ; choose 3
    db $7F ; end of message

    ; ==============================================================================
    ; > Continue Game
    ;    Save and Quit
    ;-------------------------------------------------------------------------------
    Message_0186:
    db $7A, $00 ; set draw speed
    db $44, $59, $02, $C7, $2D, $B4, $2E, $1E ; >⎵C[on]t[in]ue
    db $59, $06, $1A, $BE ; ⎵Ga[me]
    db $75 ; line 2
    db $89, $12, $1A, $2F, $1E, $59, $8C, $10 ; [   ]Save⎵[and ]Q
    db $2E, $B6 ; u[it]
    db $72 ; choose 2 high
    db $7F ; end of message

    ; ==============================================================================
    ; Welcome to the treasure field.
    ; The object is to dig as many
    ; holes as you can in 30 seconds.
    ; Any treasures you dig up will
    ; be yours to keep.
    ; It's only 80 Rupees to play.
    ; What do you say?
    ;     > I want to dig
    ;        I don't want to dig
    ;-------------------------------------------------------------------------------
    Message_0187:
    db $16, $1E, $25, $9B, $1E, $59, $DA, $59 ; Wel[com]e⎵[to]⎵
    db $D8, $59, $DB, $1E, $1A, $2C, $2E, $CD ; [the]⎵[tr]easu[re ]
    db $1F, $22, $1E, $25, $1D, $41 ; field.
    db $75 ; line 2
    db $E6, $59, $28, $1B, $23, $1E, $1C, $2D ; [The]⎵object
    db $59, $B5, $59, $DA, $59, $9E, $20, $59 ; ⎵[is]⎵[to]⎵[di]g⎵
    db $1A, $2C, $59, $BC, $32 ; as⎵[man]y
    db $76 ; line 3
    db $21, $28, $25, $1E, $2C, $59, $1A, $2C ; holes⎵as
    db $59, $E3, $59, $99, $B4, $59, $37, $34 ; ⎵[you]⎵[can ][in]⎵30
    db $59, $D0, $1C, $C7, $1D, $2C, $41 ; ⎵[se]c[on]ds.
    db $7E ; wait for key
    db $73 ; scroll text
    db $00, $27, $32, $59, $DB, $1E, $1A, $2C ; Any⎵[tr]eas
    db $2E, $CE, $2C, $59, $E3, $59, $9E, $20 ; u[re]s⎵[you]⎵[di]g
    db $59, $DC, $59, $E2, $25, $25 ; ⎵[up]⎵[wi]ll
    db $73 ; scroll text
    db $97, $59, $E3, $2B, $2C, $59, $DA, $59 ; [be]⎵[you]rs⎵[to]⎵
    db $24, $1E, $1E, $29, $41 ; keep.
    db $73 ; scroll text
    db $08, $2D, $8B, $C7, $B9, $3C, $34, $59 ; It['s ][on][ly ]80⎵
    db $11, $DC, $1E, $1E, $2C, $59, $DA, $59 ; R[up]ees⎵[to]⎵
    db $29, $BA, $32, $41 ; p[la]y.
    db $7E ; wait for key
    db $73 ; scroll text
    db $16, $B1, $2D, $59, $9F, $59, $E3, $59 ; W[ha]t⎵[do]⎵[you]⎵
    db $2C, $1A, $32, $3F ; say?
    db $73 ; scroll text
    db $88, $44, $59, $08, $59, $DF, $27, $2D ; [    ]>⎵I⎵[wa]nt
    db $59, $DA, $59, $9E, $20 ; ⎵[to]⎵[di]g
    db $73 ; scroll text
    db $88, $89, $08, $59, $9F, $C0, $DF, $27 ; [    ][   ]I⎵[do][n't ][wa]n
    db $2D, $59, $DA, $59, $9E, $20 ; t⎵[to]⎵[di]g
    db $68 ; choose 2 indented
    db $7F ; end of message

    ; ==============================================================================
    ; Then I will lend you a shovel.
    ; When you have it in your hand,
    ; start digging! (Press the
    ; ⓨ Button to dig.)
    ;-------------------------------------------------------------------------------
    Message_0188:
    db $E6, $27, $59, $08, $59, $E2, $25, $25 ; [The]n⎵I⎵[wi]ll
    db $59, $25, $A5, $1D, $59, $E3, $59, $1A ; ⎵l[en]d⎵[you]⎵a
    db $59, $D1, $28, $2F, $1E, $25, $41 ; ⎵[sh]ovel.
    db $75 ; line 2
    db $16, $21, $A0, $E3, $59, $AD, $59, $B6 ; Wh[en ][you]⎵[have]⎵[it]
    db $59, $B4, $59, $E3, $2B, $59, $B1, $27 ; ⎵[in]⎵[you]r⎵[ha]n
    db $1D, $42 ; d,
    db $76 ; line 3
    db $D3, $1A, $2B, $2D, $59, $9E, $20, $20 ; [st]art⎵[di]gg
    db $B4, $20, $3E, $59, $45, $0F, $CE, $2C ; [in]g!⎵(P[re]s
    db $2C, $59, $D8 ; s⎵[the]
    db $7E ; wait for key
    db $73 ; scroll text
    db $5E, $59, $01, $2E, $2D, $DA, $27, $59 ; ⓨ⎵But[to]n⎵
    db $DA, $59, $9E, $20, $41, $46 ; [to]⎵[di]g.)
    db $7F ; end of message

    ; ==============================================================================
    ; I see.  Then I give up.  Save
    ; some Rupees and come back.
    ;-------------------------------------------------------------------------------
    Message_0189:
    db $08, $59, $D0, $1E, $41, $8A, $E6, $27 ; I⎵[se]e.[  ][The]n
    db $59, $08, $59, $AA, $DC, $41, $8A, $12 ; ⎵I⎵[give ][up].[  ]S
    db $1A, $2F, $1E ; ave
    db $75 ; line 2
    db $CF, $59, $11, $DC, $1E, $1E, $2C, $59 ; [some]⎵R[up]ees⎵
    db $8C, $9B, $1E, $59, $96, $9C, $41 ; [and ][com]e⎵[ba][ck].
    db $7F ; end of message

    ; ==============================================================================
    ; OK!  Time's up, game over.
    ; Come back again.  Good bye…
    ;-------------------------------------------------------------------------------
    Message_018A:
    db $0E, $0A, $3E, $8A, $13, $22, $BE, $8B ; OK![  ]Ti[me]['s ]
    db $DC, $42, $59, $20, $1A, $BE, $59, $28 ; [up],⎵ga[me]⎵o
    db $DD, $41 ; [ver].
    db $75 ; line 2
    db $02, $28, $BE, $59, $96, $9C, $59, $1A ; Co[me]⎵[ba][ck]⎵a
    db $20, $8F, $41, $8A, $06, $28, $28, $1D ; g[ain].[  ]Good
    db $59, $1B, $32, $1E, $43 ; ⎵bye…
    db $7F ; end of message

    ; ==============================================================================
    ; Come back again!
    ; I will be waiting for you.
    ;-------------------------------------------------------------------------------
    Message_018B:
    db $02, $28, $BE, $59, $96, $9C, $59, $1A ; Co[me]⎵[ba][ck]⎵a
    db $20, $8F, $3E ; g[ain]!
    db $75 ; line 2
    db $08, $59, $E2, $25, $25, $59, $97, $59 ; I⎵[wi]ll⎵[be]⎵
    db $DF, $B6, $B3, $A8, $59, $E3, $41 ; [wa][it][ing ][for]⎵[you].
    db $7F ; end of message

    ; ==============================================================================
    ; I can't tell you details, but
    ; it's not a convenient time for
    ; me now.  Come back here again.
    ; Sorry.
    ;-------------------------------------------------------------------------------
    Message_018C:
    db $08, $59, $1C, $93, $51, $2D, $59, $2D ; I⎵c[an]'t⎵t
    db $1E, $25, $25, $59, $E3, $59, $1D, $1E ; ell⎵[you]⎵de
    db $2D, $1A, $22, $25, $2C, $42, $59, $1B ; tails,⎵b
    db $2E, $2D ; ut
    db $75 ; line 2
    db $B6, $8B, $C2, $59, $1A, $59, $1C, $C7 ; [it]['s ][not]⎵a⎵c[on]
    db $2F, $A5, $22, $A3, $59, $2D, $22, $BE ; v[en]i[ent]⎵ti[me]
    db $59, $A8 ; ⎵[for]
    db $76 ; line 3
    db $BE, $59, $27, $28, $30, $41, $8A, $02 ; [me]⎵now.[  ]C
    db $28, $BE, $59, $96, $9C, $59, $AF, $1E ; o[me]⎵[ba][ck]⎵[her]e
    db $59, $1A, $20, $8F, $41 ; ⎵ag[ain].
    db $7E ; wait for key
    db $73 ; scroll text
    db $12, $C8, $2B, $32, $41 ; S[or]ry.
    db $7F ; end of message
}
    
; ==============================================================================

; $076E21-$0773FF NULL
; ZScream uses this space as an extention of the dialog data block above.
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

; $077400-$0774EA LONG
{
    ; causes the screen to flash white (e.g. the master sword retrieval and
    ; ganon's tower opening)
        
    ; don't do the following section if it's not the 0th part of a sub-submodule
    LDA $B0 : BNE .BRANCH_ALPHA
    
    ; $077404 ALTERNATE ENTRY POINT
    
        REP #$20
        
        LDX.b #$00
    
        .cache_colors_and_whiten_loop
    
            ; this loop turns all the colors in the temporary palette buffer to white
            ; It also saves them to a a temporary buffer (0x7FDD80[0x200])
            LDA $7EC300, X : STA $7FDD80, X
            LDA $7EC380, X : STA $7FDE00, X
            LDA $7EC400, X : STA $7FDE80, X
            LDA $7EC480, X : STA $7FDF00, X
            
            LDA.w #$7FFF : STA $7EC300, X
                         STA $7EC380, X
                         STA $7EC400, X
                         STA $7EC480, X
        INX #2 : CPX.b #$80 : BNE .cache_colors_and_whiten_loop
        
        ; save the background color to another area of the palette buffer
        LDA $7EC500 : STA $7EC540
        
        ; mosaic level is zero
        LDA.w #$0000 : STA $7EC007
        
        ; turn on color filtering
        LDA.w #$0002 : STA $7EC009
        
        SEP #$20
        
        INC $B0
        
        RTL
    
    .BRANCH_ALPHA
    
    JSL $00EEF1 ; $006EF1 IN ROM
        
    REP #$30
        
    LDA $7EC009 : CMP.w #$00FF : BNE .BRANCH_GAMMA
        LDX.w #$000E : LDA.w #$0000
    
        .BRANCH_DELTA
    
            STA $7EC3B0, X : STA $7EC5B0, X
        DEX #2 : BPL .BRANCH_DELTA
        
        STA $7EC007
        STA $7EC009
        
        SEP #$20
        
        STZ $11
        
        SEP #$30
        
        RTL
    
    .BRANCH_GAMMA
    
    CMP.w #$0000 : BNE .BRANCH_EPSILON
        LDA $7EC007 : CMP.w #$001F : BNE .BRANCH_EPSILON
        
        LDX.w #$0000
    
        .restore_cached_colors_loop
    
            LDA $7FDD80, X : STA $7EC300, X
            LDA $7FDDC0, X : STA $7EC340, X
            LDA $7FDE00, X : STA $7EC380, X
            LDA $7FDE40, X : STA $7EC3C0, X
            LDA $7FDE80, X : STA $7EC400, X
            LDA $7FDEC0, X : STA $7EC440, X
            LDA $7FDF00, X : STA $7EC480, X
        INX #2 : CPX.w #$0040 : BNE .restore_cached_colors_loop
        
        SEP #$20
        
        STZ $1D
    
    .BRANCH_EPSILON
    
    SEP #$30
        
    RTL
}

; ==============================================================================

; $077581-$077581
Overworld_DwDeathMountainPaletteAnimation_easyOut:
{
    RTL
}

; $077582-$077651 LONG
; This function controls the lighting flashing int he background of DW death mountain as well as the Ganon's tower palette cycling.
Overworld_DwDeathMountainPaletteAnimation:
{
    LDA $04C6 : BNE .easyOut
        LDA $8A
        CMP.b #$43 : BEQ .dwDeathMountain
        CMP.b #$45 : BEQ .dwDeathMountain
        CMP.b #$47 : BNE .easyOut
            .dwDeathMountain
            
            PHB : PHK : PLB
                
            LDA $1A
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
                    LDA $7EC360, X : STA $7EC560, X
                    LDA $7EC370, X : STA $7EC570, X
                    LDA $7EC390, X : STA $7EC590, X
                    LDA $7EC3E0, X : STA $7EC5E0, X
                    LDA $7EC3F0, X : STA $7EC5F0, X
                        
                INX #2 : CPX.b #$10 : BNE .loop_1
                        
                BRA .abstain
                    
            .play_sound
                
            LDX.b #$36 : STX $012E
            
            .alter_palettes

            REP #$20
                
            LDX.b #$02
            LDY.b #$00
            
            .loop_2
                LDA $F4EB, Y : STA $7EC560, X
                LDA $F4F9, Y : STA $7EC570, X
                LDA $F507, Y : STA $7EC590, X
                LDA $F515, Y : STA $7EC5E0, X
                LDA $F523, Y : STA $7EC5F0, X
                
                INY #2
                
            INX #2 : CPX.b #$10 : BNE .loop_2
            
            .abstain
            
            SEP #$20
                
            LDX.b #$00
            LDY.b #$40
                
            LDA $8A
                
            CMP.b #$43 : BEQ .check_flag
                CMP.b #$45 : BNE .do_palette_animation
            
            .check_flag
            
            LDA $7EF2C3 : AND.b #$20 : BNE .ganons_tower_opened
                LDA $1A : AND.b #$0C : ASL #2 : TAY
            
                .do_palette_animation
                .palette_write_loop
                    REP #$20
                    
                    LDA $F531, Y : STA $7EC5D0, X
                    
                    INY #2
                
                INX #2 : CPX.b #$10 : BNE .palette_write_loop
            
            .ganons_tower_opened
            
            SEP #$20
                
            PLB
                
            INC $15
                
            RTL
}

; ==============================================================================

; $077652-$077663 LONG
Overworld_LoadEventOverlay:
{
    PHB
        
    ; Set the data bank to $7E.
    LDA.b #$7E : PHA : PLB
        
    REP #$30
        
    ; Check to see what Overworld area we're in.
    ; Use it as an index into a jump table.
    LDA $8A : ASL A : TAX
        
    JSR (Overworld_EventOverlayTable, X)
        
    SEP #$30
        
    PLB
        
    RTL
}

; ==============================================================================

; $077664-$077763 JUMP TABLE
Overworld_EventOverlayTable:
{
    ; Overlay pointers (for use with the 0x20 overlays on OW)
    
    dw $F764 ; = $077764 ; 0x00
    dw $F764 ; = $077764
    dw $F764 ; = $077764
    dw $F7AA ; = $0777AA
    dw $F7AA ; = $0777AA
    dw $F7AA ; = $0777AA
    dw $F7AA ; = $0777AA
    dw $F7AA ; = $0777AA
    
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7B1 ; = $0777B1
    dw $F7C7 ; = $0777C7
    dw $F7E4 ; = $0777E4
    dw $F7E4 ; = $0777E4
    dw $F7E4 ; = $0777E4
    
    dw $F7E4 ; = $0777E4 ;Used in drawing over the weather vane after it has been exploded.
    dw $F7E4 ; = $0777E4
    dw $F7FE ; = $0777FE
    dw $F7FE ; = $0777FE
    dw $F7FE ; = $0777FE
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    
    dw $F7E4 ; = $0777E4
    dw $F7E4 ; = $0777E4
    dw $F827 ; = $077827
    dw $F7E4 ; = $0777E4
    dw $F7E4 ; = $0777E4
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    dw $F827 ; = $077827
    dw $F82D ; = $07782D
    dw $F82D ; = $07782D
    dw $F82D ; = $07782D
    dw $F82D ; = $07782D
    
    dw $F82D ; = $07782D ; to move weathervane, this may be need changing to match area $18.
    dw $F82D ; = $07782D
    dw $F833 ; = $077833
    dw $F833 ; = $077833
    dw $F833 ; = $077833
    dw $F833 ; = $077833
    dw $F833 ; = $077833
    dw $F833 ; = $077833
    
    dw $F82D ; = $07782D
    dw $F82D ; = $07782D
    dw $F839 ; = $077839
    dw $F83F ; = $07783F
    dw $F9E6 ; = $0779E6
    dw $F9E6 ; = $0779E6
    dw $F9E6 ; = $0779E6
    dw $F9E6 ; = $0779E6
    
    dw $F9E6 ; = $0779E6
    dw $F9E6 ; = $0779E6
    dw $FA2E ; = $077A2E
    dw $FA2E ; = $077A2E ; Ganon's Tower Overlay (opened tower stairs)
    dw $FA2E ; = $077A2E
    dw $FA5B ; = $077A5B
    dw $FA5B ; = $077A5B
    dw $FA61 ; = $077A61
    
    dw $F9E6 ; = $0779E6
    dw $F9E6 ; = $0779E6
    dw $FAB4 ; = $077AB4
    dw $FA2E ; = $077A2E
    dw $FA2E ; = $077A2E
    dw $FA5B ; = $077A5B
    dw $FA5B ; = $077A5B
    dw $FAB4 ; = $077AB4
    
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FACF ; = $077ACF
    dw $FACF ; = $077ACF ;Pyramid
    dw $FACF ; = $077ACF
    dw $FAF6 ; = $077AF6
    dw $FAF6 ; = $077AF6
    dw $FAF6 ; = $077AF6
    
    dw $FAB4 ; = $077AB4
    dw $FAB4 ; = $077AB4
    dw $FB0B ; = $077B0B
    dw $FACF ; = $077ACF
    dw $FACF ; = $077ACF
    dw $FB11 ; = $077B11
    dw $FAF6 ; = $077AF6
    dw $FAF6 ; = $077AF6
    
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    dw $F827 ; = $077827
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    dw $FB64 ; = $077B64 ; Caution, as far as I know this is in fact blank space
    dw $FB64 ; = $077B64 ; It may be that some code is mapped here
    dw $FB64 ; = $077B64 ; But as it stands this portion is a sea of "FF"s
    dw $FB64 ; = $077B64
    dw $FB64 ; = $077B64
    dw $F833 ; = $077833
    
    dw $FB11 ; = $077B11
    dw $FB11 ; = $077B11
    dw $FB64 ; = $077B64
    dw $F83F ; = $07783F
    dw $FB64 ; = $077B64
    dw $FB64 ; = $077B64
    dw $FB64 ; = $077B64
    dw $FB64 ; = $077B64

; Note there is nothing here for the Master Sword resting place and Zora falls. 
; Must be handled elsewhere.
}

; $077764-$0777A9 LOCAL
{
    LDA.w #$0E32
    
    STA $2816 : STA $2818 : STA $281A 
    STA $281C : STA $2896 : STA $289C
    
    INC A : STA $2898
    INC A : STA $2E9A
    INC A : STA $2916
    INC A : STA $2918
    INC A : STA $291A
    INC A : STA $291C
    INC A : STA $2996
    INC A : STA $2998
    INC A : STA $299A
    INC A : STA $299C
    INC A : STA $2A18
    INC A : STA $2A1A
    
    RTS
}

; $0777AA-$0777B0 LOCAL
{
    LDA.w #$0212 : STA $2720
    
    RTS
}

; $0777B1-$0777C6 LOCAL
{
    LDX.w #$0506

    ; $0777B4 ALTERNATIVE ENTRY POINT

    LDA.w #$0918 : STA $2000, X
    INC A        : STA $2002, X
    INC A        : STA $2080, X
    INC A        : STA $2082, X
    
    RTS
}

; $0777C7-$0777E3 LOCAL
{
    LDA.w #$0DD1 : STA $2532
    INC A        : STA $2534
    
    LDA.w #$0DD7 : STA $25B2
    INC A        : STA $25B4
    INC A        : STA $2632
    INC A        : STA $2634
    
    RTS
}

; $0777E4-$0777FD LOCAL
{
    LDA.w #$0E21 : STA $2C3E : STA $2C42
    INC A        : STA $2C40
    INC A        : STA $2CBE
    INC A        : STA $2CC0
    INC A        : STA $2CC2
    
    RTS
}

; $0777FE-$077826 LOCAL
{
    LDA.w #$0DC1 : STA $33BC
    INC A        : STA $33BE
    
    LDA.w #$0DBE : STA $343C
    INC A        : STA $343E
    
    LDA.w #$0DC2 : STA $33C0
    INC A        : STA $33C2
    
    LDA.w #$0DBF : STA $3440
    INC A        : STA $3442
    
    RTS
}

; $077827-$07782C LOCAL
{
    LDX.w #$0330
    
    JMP $F7B4 ; $0777B4 IN ROM
}

; $07782D-$077832 LOCAL
{
    LDX.w #$0358
    
    JMP $F7B4 ; $0777B4 IN ROM
}

; $077833-$077838 LOCAL
{
    LDX.w #$040C
    
    JMP $F7B4 ; $0777B4 IN ROM
}

; $077839-$07783E LOCAL
{
    LDX.w #$0A1E
    
    JMP $F7B4 ; $0777B4
}

; $07783F-$0779E5 LOCAL
{
    LDA.w #$0DDF
    
    STA $23AC : STA $2424 : STA $24A0 : STA $251E
    STA $261C : STA $2734
    
    INC A : STA $23AE : STA $24A2
    INC A : STA $23B0 : STA $2438 : STA $24BA : STA $25AA : STA $273A
    INC A : STA $2426 : STA $2428 : STA $242A : STA $2432 : STA $2434 : STA $2436
    INC A : STA $242C : STA $24A4 : STA $2520 : STA $261E
    
    INC A
    
    STA $242E : STA $2426 : STA $24A8 : STA $24B0
    STA $24B6 : STA $2522 : STA $2524 : STA $2526
    STA $2538 : STA $25A0 : STA $25A2 : STA $25A4
    STA $25A6 : STA $2620 : STA $2622 : STA $269E
    STA $26A0 : STA $271E : STA $2720 : STA $2826
    STA $28A6 : STA $28A8 : STA $2926
    
    INC A
    
    STA $2430 : STA $24B8 : STA $25A8 : STA $262A
    
    INC A
    
    STA $24AA : STA $24B2 : STA $2528 : STA $25B8
    STA $28AA : STA $2928
    
    INC A
    
    STA $24AC : STA $2530 : STA $279E : STA $27A0
    STA $29A6 : STA $29B8
    
    INC A
    
    STA $24AE : STA $24B4 : STA $2536 : STA $27A2
    STA $2824
    
    INC A
    
    STA $252E : STA $2534 : STA $279C : STA $2822
    STA $2934 : STA $29B6
    
    INC A
    
    STA $253A : STA $2638 : STA $26B8 : STA $293A
    
    INC A
    
    STA $259E : STA $25B6 : STA $2636 : STA $269C
    STA $26B6 : STA $271C : STA $28A4 : STA $2924
    
    INC A : STA $2624 : STA $26A2
    INC A : STA $2626
    INC A : STA $2628
    INC A : STA $26A4 : STA $27B6
    
    INC A
    
    STA $26A6 : STA $2726 : STA $2728 : STA $272A
    STA $27AA : STA $2836 : STA $2838
    
    INC A : STA $26A8 : STA $27B8
    INC A : STA $26AA
    INC A : STA $2727 : STA $27A4 : STA $2828
    INC A : STA $2724
    INC A : STA $27A6
    INC A : STA $27A8 : STA $28B6
    INC A : STA $27B4
    INC A : STA $27BA
    INC A : STA $282A
    INC A : STA $2834
    INC A : STA $283A
    INC A : STA $28B4
    INC A : STA $28B8
    INC A : STA $28BA
    INC A : STA $2936
    INC A : STA $2938
    INC A : STA $252A : STA $2532 : STA $292A
    INC A : STA $25BA : STA $29A8 : STA $29BA
    INC A : STA $29A4
    INC A : STA $2736
    INC A : STA $2738
    
    RTS
}

; $0779E6-$077A2D LOCAL
{
    LDA.w #$0E13 : STA $2590
    INC A        : STA $2596
    INC A        : STA $2610
    INC A        : STA $2612
    INC A        : STA $2614
    INC A        : STA $2616
    INC A        : STA $2692
    INC A        : STA $2694
    
    LDA.w #$0E06 : STA $2812 : STA $2814
    INC A        : STA $2710 : STA $2790
    INC A        : STA $2712 : STA $2792
    INC A        : STA $2714 : STA $2794
    INC A        : STA $2716 : STA $2796
    
    RTS
}

; $077A2E-$077A5A LOCAL
{
    LDA.w #$0E96 : STA $7E245E
    INC A        : STA $7E2460
    
    LDA.w #$0E9C : STA $7E24DE : STA $7E255E
    INC A        : STA $7E24E0 : STA $7E2560
    
    LDA.w #$0E9A : STA $7E25DE
    INC A        : STA $7E25E0
    
    RTS
}

; $077A5B-$077A60 LOCAL
{
    LDX.w #$0868
    
    JMP $F7B4   ; $0777B4 IN ROM
}

; $077A61-$077AB3 LOCAL
{
    LDA.w #$0E78 : STA $7E299E
    INC A        : STA $7E29A0
    INC A        : STA $7E29A2
    INC A        : STA $7E29A4
    INC A        : STA $7E2A1E
    INC A        : STA $7E202A
    INC A        : STA $7E2A22
    INC A        : STA $7E2A24
    INC A        : STA $7E2A9E
    INC A        : STA $7E2AA0
    INC A        : STA $7E2AA2
    INC A        : STA $7E2AA4
    INC A        : STA $7E2B1E
    INC A        : STA $7E2B20
    INC A        : STA $7E2B22
    INC A        : STA $7E2B24
    
    RTS
}

; $077AB4-$077ACE LOCAL
{
    LDA.w #$0E1B : STA $2D3E
    INC A        : STA $2D40
    INC A        : STA $2DBE
    INC A        : STA $2DC0
    INC A        : STA $2E3E
    INC A        : STA $2E40
    
    RTS
}

; $077ACF-$077AF5 LOCAL
{
    LDA.w #$0E3F : STA $23BC
    INC A        : STA $23BE
    INC A        : STA $23C0
    INC A        : STA $243C
    INC A        : STA $243E
    INC A        : STA $2440
    INC A        : STA $24BC
    INC A        : STA $24BE
    INC A        : STA $24C0
    
    RTS
}

; $077AF6-$077B0A LOCAL
{
    LDA.w #$0E31 : STA $21E6
    
    LDA.w #$0E2D : STA $226A
    
    INC A : STA $22EA
    INC A : STA $236A
    
    RTS
}

; $077B0B-$077B10 LOCAL
{
    LDX.w #$0D20
    
    JMP $F7B4 ; $0777B4 IN ROM
}

; $077B11-$077B63 LOCAL
{
    LDA.w #$0E64 : STA $2522
    
    INC A : STA $2524
    INC A : STA $2526
    INC A : STA $2528
    INC A : STA $25A2
    INC A : STA $25A4
    INC A : STA $25A6
    INC A : STA $25A8
    INC A : STA $2622
    INC A : STA $2624
    INC A : STA $2626
    INC A : STA $2628
    INC A : STA $26A2
    INC A : STA $26A4
    INC A : STA $26A6
    INC A : STA $26A8
    INC A : STA $2722
    INC A : STA $2724
    INC A : STA $2726
    INC A : STA $2728
    
    RTS
}

; $077B63-$077FFF NULL
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

warnpc $0F8000

; ==============================================================================