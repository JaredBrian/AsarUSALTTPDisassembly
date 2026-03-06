; ==============================================================================
; Bank 0x03
; ==============================================================================
; GFX
; Tilemaps

print "Start of Bank 0x03: $", pc

SmallFontGFX:
{
    incbin "Data/GFX/SmallFont.bin"
}

HiraganaGFX:
{
    incbin "Data/GFX/Hiragana.bin"
}

ShapesGFX:
{
    incbin "Data/GFX/Shapes.bin"
}

SmallFontGFX2bpp:
{
    incbin "Data/GFX/SmallFont2bpp.bin"
}

HiraganaGFX2bpp:
{
    incbin "Data/GFX/Hiragana2bpp.bin"
}

TestTileMap:
{
    incbin "Data/GFX/TestTileMap.bin"
}

GodTileMap:
{
    incbin "Data/GFX/GodTileMap.bin"
}

GodTileMap2bpp:
{
    incbin "Data/GFX/GodTileMap2bpp.bin"
}

; ==============================================================================

print "End of Bank 0x03:   $", pc
print " "