; ==============================================================================

; Bank 01
; $008000-$00FFFF
org $018000

; Dungeon object draw and code
; Dungeon control
; Dungeon tag code
; Dungeon swamp water code
; Dungeon torch code
; Pot item data

; ==============================================================================

; $008000-$0081FF DATA
Pool_Dungeon_LoadType1Object:
{
    .subtype_1_params
    dw $03D8, $02E8, $02F8, $0328, $0338, $0400, $0410, $0388
    dw $0390, $0420, $042A, $0434, $043E, $0448, $0452, $045C
    dw $0466, $0470, $047A, $0484, $048E, $0498, $04A2, $04AC
    dw $04B6, $04C0, $04CA, $04D4, $04DE, $04E8, $04F2, $04FC
    dw $0506, $0598, $0600, $063C, $063C, $063C, $063C, $063C
    dw $0642, $064C, $0652, $0658, $065E, $0664, $066A, $0688
    dw $0694, $06A8, $06A8, $06A8, $06C8, $0000, $078A, $07AA
    dw $0E26, $084A, $086A, $0882, $08CA, $085A, $08FA, $091A
    
    dw $0920, $092A, $0930, $0936, $093C, $0942, $0948, $094E
    dw $096C, $097E, $098E, $0902, $099E, $09D8, $09D8, $09D8
    dw $09FA, $156C, $1590, $1D86, $0000, $0A14, $0A24, $0A54
    dw $0A54, $0A84, $0A84, $14DC, $1500, $061E, $0E52, $0600
    dw $03D8, $02C8, $02D8, $0308, $0318, $03E0, $03F0, $0378
    dw $0380, $05FA, $0648, $064A, $0670, $067C, $06A8, $06A8
    dw $06A8, $06C8, $0000, $07AA, $07CA, $084A, $089A, $08B2
    dw $090A, $0926, $0928, $0912, $09F8, $1D7E, $0000, $0A34
    
    dw $0A44, $0A54, $0A6C, $0A84, $0A9C, $1524, $1548, $085A
    dw $0606, $0E52, $05FA, $06A0, $06A2, $0B12, $0B14, $09B0
    dw $0B46, $0B56, $1F52, $1F5A, $0288, $0E82, $1DF2, $0000
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
    dw $03D8, $03D8, $03D8, $03D8, $05AA, $05B2, $05B2, $05B2
    dw $05B2, $00E0, $00E0, $00E0, $00E0, $0110, $0000, $0000
    dw $06A4, $06A6, $0AE6, $0B06, $0B0C, $0B16, $0B26, $0B36
    dw $1F52, $1F5A, $0288, $0EBA, $0E82, $1DF2, $0000, $0000
    
    dw $03D8, $0510, $05AA, $05AA, $0000, $0168, $00E0, $0158 ; C7
    dw $0100, $0110, $0178, $072A, $072A, $072A, $075A, $0670 ; CF
    dw $0670, $0130, $0148, $072A, $072A, $072A, $075A, $00E0 ; D7
    dw $0110, $00F0, $0110, $0000, $0AB4, $08DA, $0ADE, $0188 ; DF
    dw $01A0, $01B0, $01C0, $01D0, $01E0, $01F0, $0200, $0120 ; E7
    dw $02A8, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ; EF
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ; F7
    
    ; UNUSED:
    ; This last row is not used, because there are only 0xf8 subtype 1
    ; scripts in actuality. Hackers can use this for whatever they want.
    dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ; FF
}

; ==============================================================================

; $008200-$0083EF JUMP TABLE
Pool_Dungeon_LoadType1Object:
{
    ; Subtype 1 objects (0xF8 distinct object types)
    .subtype_1_params
    
    ; 0x00
    dw Object_Draw2x2s_AdvanceRight_from_1_to_15_or_32
    dw Object_Draw4x2s_AdvanceRight_from_1_to_15_or_26
    dw Object_Draw4x2s_AdvanceRight_from_1_to_15_or_26
    dw Object_Draw4x2s_AdvanceRight_from_1_to_16_BothBgs
    dw Object_Draw4x2s_AdvanceRight_from_1_to_16_BothBgs
    dw RoomDraw_Rightwards2x4spaced4_1to16_BothBG
    dw RoomDraw_Rightwards2x4spaced4_1to16_BothBG
    dw RoomDraw_Rightwards2x2_1to16
    
    ; 0x08
    dw RoomDraw_Rightwards2x2_1to16
    dw RoomDraw_DiagonalAcute_1to16
    dw RoomDraw_DiagonalGrave_1to16
    dw RoomDraw_DiagonalGrave_1to16
    dw RoomDraw_DiagonalAcute_1to16
    dw RoomDraw_DiagonalAcute_1to16
    dw RoomDraw_DiagonalGrave_1to16
    dw RoomDraw_DiagonalGrave_1to16
    
    ; 0x10
    dw RoomDraw_DiagonalAcute_1to16
    dw RoomDraw_DiagonalAcute_1to16
    dw RoomDraw_DiagonalGrave_1to16
    dw RoomDraw_DiagonalGrave_1to16
    dw RoomDraw_DiagonalAcute_1to16
    dw RoomDraw_DiagonalAcute_1to16_BothBG
    dw RoomDraw_DiagonalGrave_1to16_BothBG
    dw RoomDraw_DiagonalGrave_1to16_BothBG
    
    ; 0x18
    dw RoomDraw_DiagonalAcute_1to16_BothBG
    dw RoomDraw_DiagonalAcute_1to16_BothBG
    dw RoomDraw_DiagonalGrave_1to16_BothBG
    dw RoomDraw_DiagonalGrave_1to16_BothBG
    dw RoomDraw_DiagonalAcute_1to16_BothBG
    dw RoomDraw_DiagonalAcute_1to16_BothBG
    dw RoomDraw_DiagonalGrave_1to16_BothBG
    dw RoomDraw_DiagonalGrave_1to16_BothBG
    
    ; 0x20
    dw RoomDraw_DiagonalAcute_1to16_BothBG
    dw RoomDraw_Rightwards1x2_1to16_plus2 ; Mini staircase (just slows you down)
    dw Object_HorizontalRail_short
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    
    ; 0x28
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsTopCorners1x2_1to16_plus13
    
    ; 0x30
    dw RoomDraw_RightwardsBottomCorners1x2_1to16_plus13
    dw RoomDraw_Nothing_A ; UNUSED: Unused object
    dw RoomDraw_Nothing_A ; UNUSED: Unused object
    dw RoomDraw_Rightwards4x4_1to16
    dw RoomDraw_Rightwards1x1Solid_1to16_plus3 ; 34
    dw RoomDraw_DoorSwitcherer ; 35? (HM says unused)
    dw RoomDraw_RightwardsDecor4x4spaced2_1to16 ; Curtains in Agahnim's room (horizontal)
    dw RoomDraw_RightwardsDecor4x4spaced2_1to16 ; Curtains in Agahnim's room (vertical, but not really useful because it tiles horizontally)
    
    ; 0x38
    dw RoomDraw_RightwardsStatue2x3spaced2_1to16
    dw RoomDraw_RightwardsPillar2x4spaced4_1to16
    dw RoomDraw_RightwardsDecor4x3spaced4_1to16
    dw RoomDraw_RightwardsDecor4x3spaced4_1to16
    dw RoomDraw_RightwardsDoubled2x2spaced2_1to16
    dw RoomDraw_RightwardsPillar2x4spaced4_1to16
    dw RoomDraw_RightwardsDecor2x2spaced12_1to16
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    
    ; 0x40
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2 ; Outline for water pools
    dw RoomDraw_Waterfall47 ; Thin waterfall (not used!)
    
    ; 0x48
    dw RoomDraw_Waterfall48 ; Variable width waterfall (also unused)
    dw RoomDraw_RightwardsFloorTile4x2_1to16
    dw RoomDraw_RightwardsFloorTile4x2_1to16
    dw RoomDraw_RightwardsDecor2x2spaced12_1to16
    dw RoomDraw_RightwardsBar4x3_1to16
    dw RoomDraw_RightwardsShelf4x4_1to16 ; Interesting that these three objects are identical and so are their parameters...
    dw RoomDraw_RightwardsShelf4x4_1to16
    dw RoomDraw_RightwardsShelf4x4_1to16
    
    ; 0x50
    dw RoomDraw_RightwardsLine1x1_1to16plus1
    dw RoomDraw_RightwardsCannonHole4x3_1to16
    dw RoomDraw_RightwardsCannonHole4x3_1to16
    dw RoomDraw_Rightwards2x2_1to16
    dw RoomDraw_Nothing_B ; UNUSED: Unused object
    dw RoomDraw_RightwardsDecor4x2spaced8_1to16
    dw RoomDraw_RightwardsDecor4x2spaced8_1to16
    dw RoomDraw_Nothing_C
    
    ; 0x58
    dw RoomDraw_Nothing_C
    dw RoomDraw_Nothing_C
    dw RoomDraw_Nothing_C
    dw RoomDraw_RightwardsCannonHole4x3_1to16
    dw RoomDraw_RightwardsCannonHole4x3_1to16
    dw RoomDraw_RightwardsBigRail1x3_1to16plus5
    dw RoomDraw_RightwardsBlock2x2spaced2_1to16
    dw Object_HorizontalRail_long
    
    ; 0x60
    dw Object_Draw2x2sDownVariableOrFull
    dw RoomDraw_Downwards4x2_1to15or26
    dw RoomDraw_Downwards4x2_1to15or26
    dw RoomDraw_Downwards4x2_1to16_BothBG
    dw RoomDraw_Downwards4x2_1to16_BothBG
    dw RoomDraw_DownwardsDecor4x2spaced4_1to16
    dw RoomDraw_DownwardsDecor4x2spaced4_1to16
    dw RoomDraw_Downwards2x2_1to16
    
    ; 0x68
    dw RoomDraw_Downwards2x2_1to16
    dw RoomDraw_DownwardsHasEdge1x1_1to16_plus3
    dw RoomDraw_DownwardsEdge1x1_1to16
    dw RoomDraw_DownwardsEdge1x1_1to16
    dw RoomDraw_DownwardsLeftCorners2x1_1to16_plus12
    dw RoomDraw_DownwardsRightCorners2x1_1to16_plus12
    dw RoomDraw_Nothing_A ; UNUSED: Unused object?
    dw RoomDraw_Nothing_A ; UNUSED: Unused object?
    
    ; 0x70
    dw RoomDraw_DownwardsFloor4x4_1to16
    dw RoomDraw_Downwards1x1Solid_1to16_plus3
    dw RoomDraw_Nothing_B
    dw RoomDraw_DownwardsDecor4x4spaced2_1to16
    dw RoomDraw_DownwardsDecor4x4spaced2_1to16
    dw RoomDraw_DownwardsPillar2x4spaced2_1to16
    dw RoomDraw_DownwardsDecor3x4spaced4_1to16
    dw RoomDraw_DownwardsDecor3x4spaced4_1to16
    
    ; 0x78
    dw RoomDraw_DownwardsDecor2x2spaced12_1to16
    dw RoomDraw_DownwardsEdge1x1_1to16
    dw RoomDraw_DownwardsEdge1x1_1to16
    dw RoomDraw_DownwardsDecor2x2spaced12_1to16
    dw RoomDraw_DownwardsLine1x1_1to16plus1
    dw RoomDraw_Downwards2x2_1to16
    dw RoomDraw_Nothing_B
    dw RoomDraw_DownwardsDecor2x4spaced8_1to16
    
    ; 0x80
    dw RoomDraw_DownwardsDecor2x4spaced8_1to16
    dw RoomDraw_DownwardsDecor3x4spaced2_1to16
    dw RoomDraw_DownwardsDecor3x4spaced2_1to16
    dw RoomDraw_DownwardsDecor3x4spaced2_1to16
    dw RoomDraw_DownwardsDecor3x4spaced2_1to16
    dw RoomDraw_DownwardsCannonHole3x4_1to16
    dw RoomDraw_DownwardsCannonHole3x4_1to16
    dw RoomDraw_DownwardsPillar2x4spaced2_1to16
    
    ; 0x88
    dw RoomDraw_DownwardsBigRail3x1_1to16plus5
    dw RoomDraw_DownwardsBlock2x2spaced2_1to16
    dw RoomDraw_DownwardsHasEdge1x1_1to16_plus23
    dw RoomDraw_DownwardsEdge1x1_1to16plus7
    dw RoomDraw_DownwardsEdge1x1_1to16plus7
    dw RoomDraw_DownwardsEdge1x1_1to16
    dw RoomDraw_DownwardsEdge1x1_1to16
    dw RoomDraw_DownwardsBar2x5_1to16
    
    ; 0x90
    dw RoomDraw_Downwards4x2_1to15or26
    dw RoomDraw_Downwards4x2_1to15or26
    dw Object_Draw2x2sDownVariableOrFull ; Blue block switch   (vertical)
    dw Object_Draw2x2sDownVariableOrFull ; Orange block switch (vertical)
    dw RoomDraw_DownwardsFloor4x4_1to16 ; Partially see through floor
    dw RoomDraw_DownwardsPots2x2_1to16 ; Vertical line of pots
    dw RoomDraw_DownwardsHammerPegs2x2_1to16 ; Vertical Line of moles
    dw RoomDraw_Nothing_B
    
    ; 0x98
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    
    ; 0xA0
    dw RoomDraw_DiagonalCeilingTopLeftA
    dw RoomDraw_DiagonalCeilingBottomLeftA
    dw RoomDraw_DiagonalCeilingTopRightA
    dw RoomDraw_DiagonalCeilingBottomRightA
    dw Object_Hole
    dw RoomDraw_DiagonalCeilingTopLeftB
    dw RoomDraw_DiagonalCeilingBottomLeftB
    dw RoomDraw_DiagonalCeilingTopRightB
    
    ; 0xA8
    dw RoomDraw_DiagonalCeilingBottomRightB
    dw RoomDraw_DiagonalCeilingTopLeftB
    dw RoomDraw_DiagonalCeilingBottomLeftB
    dw RoomDraw_DiagonalCeilingTopRightB
    dw RoomDraw_DiagonalCeilingBottomRightB
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    
    ; 0xB0
    dw RoomDraw_RightwardsEdge1x1_1to16plus7
    dw RoomDraw_RightwardsEdge1x1_1to16plus7
    dw RoomDraw_Rightwards4x4_1to16
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_RightwardsHasEdge1x1_1to16_plus2
    dw RoomDraw_Weird2x4_1_to_16 ; Fortune teller curtain
    dw Object_Draw4x2s_AdvanceRight_from_1_to_15_or_26
    dw Object_Draw4x2s_AdvanceRight_from_1_to_15_or_26
    
    ; 0xB8
    dw Object_Draw2x2s_AdvanceRight_from_1_to_15_or_32 ; Blue switch block (horizontal)
    dw Object_Draw2x2s_AdvanceRight_from_1_to_15_or_32 ; Orange switch block (horizontal)
    dw RoomDraw_Rightwards4x4_1to16
    dw RoomDraw_RightwardsBlock2x2spaced2_1to16
    dw RoomDraw_RightwardsPots2x2_1to16 ; Horizontal line of pots
    dw RoomDraw_RightwardsHammerPegs2x2_1to16 ; Horizontal line of moles
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    
    ; 0xC0
    dw Object_DrawRectOf1x1s
    dw RoomDraw_ClosedChestPlatform
    dw Object_DrawRectOf1x1s
    dw RoomDraw_3x3FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorOneIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    
    ; 0xC8
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_Nothing_E ; Undefined object
    dw RoomDraw_Nothing_E ; Undefined object
    dw Object_HiddenWallRight
    dw Object_HiddenWallLeft
    dw RoomDraw_Nothing_D
    
    ; 0xD0
    dw RoomDraw_Nothing_D
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_CheckIfWallIsMoved
    dw RoomDraw_CheckIfWallIsMoved
    dw RoomDraw_CheckIfWallIsMoved
    dw RoomDraw_CheckIfWallIsMoved
    dw RoomDraw_3x3FloorIn4x4SuperSquare
    
    ; 0xD8
    dw Object_Water ; Water
    dw RoomDraw_4x4FloorIn4x4SuperSquare ; Large b8FA5lack space
    dw RoomDraw_WaterOverlayB8x8_1to16 ; Water 2?
    dw RoomDraw_4x4FloorTwoIn4x4SuperSquare
    dw RoomDraw_OpenChestPlatform ; Staircase platform
    dw RoomDraw_TableRock4x4_1to16 ; Large rock formation in caves / variable sized table
    dw RoomDraw_Spike2x2In4x4SuperSquare ; Spike block groups
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    
    ; 0xE0
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    
    ; 0xE8
    dw RoomDraw_4x4FloorIn4x4SuperSquare
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    
    ; 0xF0
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
    dw RoomDraw_Nothing_B
}

; ==============================================================================

; $0083F0-$00846F DATA
Subtype2Params:
{
    dw $0B66, $0B86, $0BA6, $0BC6, $0C66, $0C86, $0CA6, $0CC6
    dw $0BE6, $0C06, $0C26, $0C46, $0CE6, $0D06, $0D26, $0D46
    
    dw $0D66, $0D7E, $0D96, $0DAE, $0DC6, $0DDE, $0DF6, $0E0E
    dw $0398, $03A0, $03A8, $03B0, $0E32, $0E26, $0EA2, $0E9A
    
    dw $0ECA, $0ED2, $0EDE, $0EDE, $0F1E, $0F3E, $0F5E, $0F6A
    dw $0EF6, $0F72, $0F92, $0FA2, $0FA2, $1088, $10A8, $10A8
    
    dw $10C8, $10C8, $10C8, $10C8, $0E52, $1108, $1108, $12A8
    dw $1148, $1160, $1178, $1190, $1458, $1488, $2062, $2086
}

; ==============================================================================

; Subtype 2 objects (0x40 distinct object types)
; $008470-$0084EF JUMP TABLE
Subtype2Routines:
{
    ; 0x00
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    
    ; 0x08
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    dw Object_Draw4x4_BothBgs
    
    ; 0x10
    dw Object_Draw4x3_BothBgs
    dw Object_Draw4x3_BothBgs
    dw Object_Draw4x3_BothBgs
    dw Object_Draw4x3_BothBgs
    dw Object_Draw3x4_BothBgs
    dw Object_Draw3x4_BothBgs
    dw Object_Draw3x4_BothBgs
    dw Object_Draw3x4_BothBgs
    
    ; 0x18
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw4x4
    dw Object_Draw3x2
    dw Object_StarTile_disabled 
    dw Object_StarTile
    
    ; 0x20
    dw $9892 ; = $009892 ; Lit torch (distinct from the main torch type. one usage of note is in ganon's room)
    dw Object_Draw3x2
    dw Object_Draw5x4 ; Mangled bed?...
    dw Object_Draw3x4
    dw Object_Draw4x4
    dw Object_Draw4x4
    dw Object_Draw3x2
    dw Object_Draw2x2
    
    ; 0x28
    dw Object_Draw5x4 ; Bed
    dw Object_Draw4x4
    dw Object_Draw2x4
    dw Object_Draw2x2
    dw Object_Draw3x6_Alternate 
    dw RoomDraw_InterRoomFatStairsUp ; Inter-room in-room up-north   staircase
    dw RoomDraw_InterRoomFatStairsDown_A ; Inter-room in-room down-south staircase
    dw RoomDraw_InterRoomFatStairsDown_B ; Inter-room in-room down-north staircase (subtype obscured by hidden wall)
    
    ; 0x30
    dw RoomDraw_AutoStairs_North_MultiLayer_A ; Seems identical to next object, but unused in the original game
    dw RoomDraw_AutoStairs_North_MultiLayer_B ; Inter-bg        in-room up-north staircase
    dw RoomDraw_AutoStairs_North_MergedLayer_A ; Inter-psuedo bg in-room up-north staircase
    dw RoomDraw_AutoStairs_North_MergedLayer_B ; Inter-bg        in-room up-north staircase (subtype used in water rooms like in Swamp Palace)
    dw Object_Draw2x2 ; Single block
    dw Object_WaterLadder ; Swamp Palace activated ladder
    dw Object_InactiveWaterLadder ; Swamp Palace deactivated ladder
    dw Object_Watergate
    
    ; 0x38
    dw RoomDraw_SpiralStairsGoingUpUpper   ; Wall up-north spiral staircase
    dw RoomDraw_SpiralStairsGoingDownUpper ; Wall down-north spiral staircase
    dw RoomDraw_SpiralStairsGoingUpLower   ; Wall up-north spiral staircase
    dw RoomDraw_SpiralStairsGoingDownLower ; Wall down-north spiral staircase
    dw Object_SanctuaryMantle
    dw Object_Draw3x4
    dw Object_Draw3x6
    dw Object_Draw7x8 ; Quick note: Hyrule Magic doesn't appear to display this properly. (What does it look like when used properly?)
}

; ==============================================================================

; $0084F0-$0085EF DATA
Subtype3Params:
{
    dw $1614, $162C, $1654, $0A0E, $0A0C, $09FC, $09FE, $0A00
    dw $0A02, $0A04, $0A06, $0A08, $0A0A, $0000, $0A10, $0A12
    
    dw $1DDA, $1DE2, $1DD6, $1DEA, $15FC, $1DFA, $1DF2, $1488
    dw $1494, $149C, $14A4, $10E8, $10E8, $10E8, $11A8, $11C8
    
    dw $11E8, $1208, $03B8, $03C0, $03C8, $03D0, $1228, $1248
    dw $1268, $1288, $0000, $0E5A, $0E62, $0000, $0000, $0E82
    
    dw $0E8A, $14AC, $14C4, $10E8, $1614, $1614, $1614, $1614
    dw $1614, $1614, $1CBE, $1CEE, $1D1E, $1D4E, $1D8E, $1D96
    
    dw $1D9E, $1DA6, $1DAE, $1DB6, $1DBE, $1DC6, $1DCE, $0220
    dw $0260, $0280, $1F3A, $1F62, $1F92, $1FF2, $2016, $1F42
    
    dw $0EAA, $1F4A, $1F52, $1F5A, $202E, $2062, $09B8, $09C0
    dw $09C8, $09D0, $0FA2, $0FB2, $0FC4, $0FF4, $1018, $1020
    
    dw $15B4, $15D8, $20F6, $0EBA, $22E6, $22EE, $05DA, $281E
    dw $2AE0, $2D2A, $2F2A, $22F6, $2316, $232E, $2346, $235E
    
    dw $2376, $23B6, $1E9A, $0000, $2436, $149C, $24B6, $24E6
    dw $2516, $1028, $1040, $1060, $1070, $1078, $1080, $0000
}

; ==============================================================================

; Subtype 3 Objects (0x80 disinct object types)
; $0085F0-$0086EF JUMP TABLE
Subtype3Routines:
{
    ; 0x00
    dw RoomDraw_EmptyWaterFace
    dw RoomDraw_SpittingWaterFace
    dw RoomDraw_DrenchingWaterFace
    dw RoomDraw_SomariaLine_increment_count
    dw Object_Draw1x1
    dw Object_Draw1x1
    dw Object_Draw1x1
    dw Object_Draw1x1
    
    ; 0x08
    dw Object_Draw1x1
    dw Object_Draw1x1
    dw Object_Draw1x1
    dw Object_Draw1x1
    dw Object_Draw1x1
    dw Object_PrisonBars ; Set of prison bars with slot (unused?)
    dw RoomDraw_SomariaLine_increment_count
    dw Object_Draw1x1
    
    ; 0x10
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Rupees
    dw Object_Draw2x2 ; Telepathic tiles (Zelda, Sahasralah)
    dw Object_Draw3x4
    dw Object_KholdstareShell ; Kholdstare's shell
    dw Object_Mole ; (single mole)
    dw Object_PrisonBars ; Set of prison bars with slot (used)
    
    ; 0x18
    dw Object_BigKeyLock
    dw Object_Chest            ; Normal Chest
    dw Object_Chest_startsOpen
    dw RoomDraw_AutoStairs_South_MultiLayer_A ; In-room up-south staircase
    dw RoomDraw_AutoStairs_South_MultiLayer_B ; In-room up-south staircase
    dw RoomDraw_AutoStairs_South_MultiLayer_C ; In-room up-south staircase
    dw RoomDraw_StraightInterroomStairsGoingUpNorthUpper ; Wall up-north straight staircase
    dw RoomDraw_StraightInterroomStairsGoingDownNorthUpper ; Wall down-north straight staircase
    
    ; 0x20
    dw RoomDraw_StraightInterroomStairsGoingUpSouthUpper ; Wall up-south straight staircase
    dw RoomDraw_StraightInterroomStairsGoingDownSouthUpper ; Wall down-south straight staircase
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw RoomDraw_StraightInterroomStairsGoingUpNorthLower ; Wall up-north straight staircase
    dw RoomDraw_StraightInterroomStairsGoingDownNorthLower ; Wall down-north straight staircase
    
    ; 0x28
    dw RoomDraw_StraightInterroomStairsGoingUpSouthLower ; Wall up-south straight staircase
    dw RoomDraw_StraightInterroomStairsGoingDownSouthLower ; Wall down-south straight staircase  
    dw Object_LanternLayer
    dw RoomDraw_WeirdGloveRequiredPot ; Heavy (unfinished) throwable pot?
    dw Object_LargeLiftableBlock
    dw Object_AgahnimAltar 
    dw Object_AgahnimRoomFrame
    dw Object_Pot ; Pots and Skulls in dungeons
    
    ; 0x30
    dw RoomDraw_WeirdGloveRequiredPot ; Other liftable object (graphics messed up)
    dw Object_BigChest ; Big Chest
    dw Object_OpenedBigChest_fake
    dw RoomDraw_AutoStairs_South_MergedLayer ; In room staircase (facing up)
    dw Object_Draw2x3
    dw Object_Draw2x3
    dw Object_Draw3x6_Alternate
    dw Object_Draw3x6_Alternate
    
    ; 0x38
    dw Object_Draw2x3
    dw Object_Draw2x3
    dw Object_Draw6x4 ; Up facing Turle Rock tube opening
    dw Object_Draw6x4 ; Down facing Turtle Rock tube opening
    dw Object_Draw4x6 ; Left facing Turtle Rock tube opening
    dw Object_Draw4x6 ; Right facing Turtle Rock tube opening
    dw Object_Draw2x2
    dw Object_Draw2x2
    
    ; 0x40
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_BombableFloor
    
    ; 0x48
    dw Object_Draw4x4 ; Fake cracked floor (2x2)
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw3x8
    dw Object_Draw8x6
    dw Object_Draw3x6
    dw Object_Draw3x4
    dw Object_Draw2x2
    
    ; 0x50
    dw Object_StarTile_disabled
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_FortuneTellerTemplate
    dw RoomDraw_Utility3x5
    dw Object_Draw2x2
    dw Object_Draw2x2
    
    ; 0x58
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw RoomDraw_TableBowl
    dw RoomDraw_Utility3x5
    dw Object_Draw4x6 ; Bookcase
    dw Object_Draw3x6
    dw Object_Draw2x2
    dw Object_Draw2x2
    
    ; 0x60
    dw Object_Draw6x3
    dw Object_Draw6x3
    dw RoomDraw_VitreousGooGraphics
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw4x4
    dw Object_Draw3x4
    
    ; 0x68
    dw Object_Draw3x4
    dw Object_Draw4x3
    dw Object_Draw4x3
    dw Object_Draw4x4
    dw Object_Draw3x4
    dw Object_Draw3x4
    dw Object_Draw4x3
    dw Object_Draw4x3
    
    ; 0x70
    dw Object_Stacked4x4s
    dw Object_BlindLight
    dw Object_TrinexxShell ; Trinexx shell
    dw Object_EntireFloorIsPit ; Whatever BG you're on, this will cover it with pit tiles. 
    dw Object_Draw8x8
    dw Object_Draw2x2 ; Minigame chest
    dw Object_Draw3x8
    dw Object_Draw3x8
    
    ; 0x78
    dw Object_Triforce
    dw Object_Draw3x4
    dw Object_Draw4x4
    dw Object_Draw10x20_With4x4
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw Object_Draw2x2
    dw RoomDraw_Nothing_B
}

; ==============================================================================

; $0086F0-$0086F7 JUMP TABLE
DoorObjectRoutines:
{
    ; A   = type
    ; X   = position (0, 2, 4, ..., 24)
    ; $02 = position (0, 2, 4, ..., 24)
    ; $04 = type
    ; $0A = type
    
    dw Door_Up    ; Up
    dw Door_Down  ; Down
    dw Door_Left  ; Left
    dw Door_Right ; Right?
}
    
; ==============================================================================

; $0086F8-$008739 DATA
Dungeon_DrawObjectOffsets:
{
    ; TODO: What is this comment?
    ; $BF, $C2, $C5, $C8
    ; $CB, $CE, $D1, $D4
    ; $D7
    ; $DA
    ; $DD

    ; $0086F8
    .BG2
    dl $7E2000, $7E2002, $7E2004, $7E2006
    dl $7E2080, $7E2082, $7E2084, $7E2086
    dl $7E2100
    dl $7E2180
    dl $7E2200         
    
    ; $008719
    .BG1
    dl $7E4000, $7E4002, $7E4004, $7E4006
    dl $7E4080, $7E4082, $7E4084, $7E4086
    dl $7E4100
    dl $7E4180
    dl $7E4200
}

; ==============================================================================

; Loads dungeon room from start to finish.
; $00873A-$0088E3 LONG JUMP LOCATION
Dungeon_LoadRoom:
{
    JSR.w Dungeon_LoadHeader
    
    STZ.w $03F4
    
    REP #$30
    
    ; Get pointer to object data.
    LDX.w $0110
    LDA.l RoomData_ObjectDataPointers+1, X : STA.b $B8
    LDA.l RoomData_ObjectDataPointers+0, X : STA.b $B7
    
    ; Not sure.
    LDA.b $AD : STA.w $0428
    
    LDA.w #$FF30 : STA.w $041C
    
    STZ.w $041A : STZ.w $0420
    STZ.w $0312 : STZ.w $0310
    STZ.w $0422 : STZ.w $0424
    
    LDA.w #$FFFF : STA.w $0436
    
    STZ.w $0452 : STZ.w $0454 : STZ.w $0456
    
    STZ.w $068A
    
    STZ.w $044E : STZ.w $0450
    
    STZ.b $FC
    
    STZ.w $045C
    
    STZ.w $0438 : STZ.w $043A : STZ.w $043C : STZ.w $043E
    STZ.w $0440 : STZ.w $0442 : STZ.w $0444 : STZ.w $0446
    STZ.w $0448
    
    STZ.w $049A : STZ.w $049C : STZ.w $049E : STZ.w $04AE
    
    STZ.w $047E : STZ.w $0480 : STZ.w $0482 : STZ.w $0484
    
    STZ.w $04A2 : STZ.w $04A4 : STZ.w $04A6 : STZ.w $04A8
    
    STZ.w $19E2 : STZ.w $19E4 : STZ.w $19E6 : STZ.w $19E8
    STZ.w $19E0
    
    STZ.w $0430 : STZ.w $0432
    
    ; Used in some of the graphics routines for determining tile types.
    STZ.w $042C
    STZ.w $042E
    
    STZ.w $0496 : STZ.w $0498
    
    STZ.w $04B0
    
    LDX.w #$001E
    
    STZ.w $0460
    
    .initObjectBuffers
    
        STZ.w $19A0, X : STZ.w $1980, X : STZ.w $19C0, X
        
        STZ.w $04F0, X
        
        STZ.w $0500, X : STZ.w $0520, X : STZ.w $0540, X
    DEX #2 : BPL .initObjectBuffers
    
    STZ.b $BA
    
    JSR.w Dungeon_DrawFloors
    
    LDY.b $BA : PHY
    
    ; Y is always 1 here. Contains layout info as well as starting quadrant
    ; info.
    LDA [$B7], Y : AND.w #$00FF : STA.w $040E
    
    ; X = 3 * $00
    LSR #2 : STA.b $00 : ASL A : CLC : ADC.b $00 : TAX
    
    ; The offset to the pointers for each layout.
    LDA.l RoomDraw_LayoutPointers+1, X : STA.b $B8
    LDA.l RoomDraw_LayoutPointers+0, X : STA.b $B7
    
    STZ.b $BA
    
    JSR.w Dungeon_DrawObjects ; Load the "layout" objects.
    
    ; Y = 2
    PLY : INY : STY.b $BA
    
    ; Get room index * 3.
    LDX.w $0110
    LDA.l RoomData_ObjectDataPointers+1, X : STA.b $B8
    LDA.l RoomData_ObjectDataPointers+0, X : STA.b $B7
    
    ; Draw Layer 1 objects to BG2.
    JSR.w Dungeon_DrawObjects
    
    INC.b $BA : INC.b $BA
    
    LDX.w #$001E
    
    .setupLayer2
    
        ; These objects are drawn onto BG1.
        LDA Dungeon_DrawObjectOffsets_BG1+1, X : STA.b $C0, X
    DEX #3 : BPL .setupLayer2
    
    ; Draw Layer 2 objects to BG1.
    JSR.w Dungeon_DrawObjects
    
    INC.b $BA : INC.b $BA
    
    LDX.w #$001E
    
    .setupLayer3
    
        ; These objects are drawn onto BG1.
        LDA Dungeon_DrawObjectOffsets_BG2+1, X : STA.b $C0, X
    DEX #3 : BPL .setupLayer3
    
    ; Draw layer 3 objects to BG1.
    JSR.w Dungeon_DrawObjects
    
    STZ.b $BA
    
    .next_block
    
        LDX.b $BA
        
        ; If the block's room matches the current room, load.
        LDA.l $7EF940, X : CMP.b $A0 : BNE .notInThisRoom
            ; Load the block's location.
            LDA.l $7EF942, X : STA.b $08 : TAY
            
            JSR.w Dungeon_LoadBlock
        
        .notInThisRoom
        
        ; Move to the next block entry.
        LDA.b $BA : CLC : ADC.w #$0004 : STA.b $BA
    ; There are 99 (decimal) blocks in the game.
    CMP.w #$018C : BNE .next_block
    
    REP #$20
    
    LDA.w $042C : STA.w $042E : STA.w $0478
    
    ; Next load torches.
    STZ.b $BA
    
    .notEndOfTorches
    
        LDX.b $BA
        
        LDA.l $7EFB40, X : CMP.b $A0 : BEQ .torchInThisRoom
            INX #2
            
            .nextTorch
            
                LDA.l $7EFB40, X
                
                INX #2 : STX.b $BA
            CMP.w #$FFFF : BNE .nextTorch
    CPX.w #$0120 : BNE .notEndOfTorches
    
    BRA .return

    .torchInThisRoom

    INX #2
    
    .nextTorchInRoom
    
        ; Get tilemap position.
        LDA.l $7EFB40, X : STA.b $08
        
        INX #2 : STX.b $BA
        
        JSR.w Dungeon_LoadTorch
        
        LDX.b $BA
    LDA.l $7EFB40, X : CMP.w #$FFFF : BNE .nextTorchInRoom
    
    SEP #$30
    
    .return
    
    RTL
}

; ==============================================================================

; Loads Level data?
; $0088E4-$008915 LOCAL JUMP LOCATION
Dungeon_DrawObjects:
{
    .nextType1
    
        STZ.b $B2
        STZ.b $B4
        
        LDY.b $BA
        
        LDA [$B7], Y : CMP.w #$FFFF : BEQ .return
            STA.b $00 : CMP.w #$FFF0 : BEQ .enteredType2Section
                JSR.w Dungeon_LoadType1Object
    BRA .nextType1
    
    .return
    
    RTS
    
    .enteredType2Section
    
    ; After a #$FFF0 move to the next object.
    INC.b $BA : INC.b $BA
    
    .nextType2
    
    LDY.b $BA
    
    ; Still stop if it's an #$FFFF object.
    LDA [$B7], Y : CMP.w #$FFFF : BEQ .return 
        ; Store the object's information at $00.
        STA.b $00
        
        JSR.w Dungeon_LoadType2Object
        
        INC.b $BA : INC.b $BA
        
        BRA .nextType2
}

; ==============================================================================

; This apparently loads doors. More generally loads 2 byte objects.
; $008916-$00893B LOCAL JUMP LOCATION
Dungeon_LoadType2Object:
{
    AND.w #$00F0 : LSR #3 : STA.b $02
    
    LDA.b $00 : XBA : AND.w #$00FF : STA.b $0A : STA.b $04
    
    ; X will be even and at most 6.
    LDA.b $00 : AND.w #$0003 : ASL A : TAX
    
    LDA DoorObjectRoutines, X : STA.b $0E
    
    LDX.b $02
    
    LDA.b $04
    
    JMP ($000E)
}

; ==============================================================================

; Loads a 3 byte object into a room.
; $00893C-$0089DB LOCAL JUMP LOCATION
Dungeon_LoadType1Object:
{
    SEP #$20
    
    ; Basically, if object # >= 0xFC.
    AND.b #$FC : CMP.b #$FC : BEQ .subtype2Object
        ; Will become part of the tilemap offset.
        STA.b $08
        
        ; Reload the first byte of the object.
        ; Store to this location (no idea what it does).
        LDA.b $00 : AND.b #$03 : STA.b $B2
        
        ; Same here. Excuse my ignorance.
        LDA.b $01 : AND.b #$03 : STA.b $B4
        
        ; Move to the third byte of the object.
        INY #2
        
        ; Determines the object "type". I.e. the routine to use.
        LDA [$B7], Y : STA.b $04
        
        ; Set up the index to read the next object.
        INY : STY.b $BA
        
        ; This now forms a full tile map offset.
        LDA.b $01 : LSR #3 : ROR.b $08 : STA.b $09
        
        STZ.b $03
        STZ.b $05
        
        REP #$20
        
        ; Load the object type, multiply by two.
        ; If object type >= 0xF8 goto subtype 3 objects.
        LDA.b $04 : ASL A : CMP.w #$01F0 : BCS .subtype3Object
            ; Handles subtype 1 objects.
            TAX
            
            LDA.w .subtype_1_routines, X : STA.b $0E
            
            LDA.w .subtype_1_params, X : TAX
            
            LDY.b $08
            
            JMP ($000E)
    
    .subtype2Object
    
    REP #$20
    
    ; Retrieve the first two bytes of the object.
    LDA.b $00 : XBA : AND.w #$03F0 : LSR #3 : STA.b $08
    
    INY
    
    LDA [$B7], Y : XBA : AND.w #$0FC0 : ASL A : ORA.b $08 : STA.b $08
    
    LDA [$B7], Y : XBA : AND.w #$003F
    
    ; Look ahead to the next object but we're not done with this one yet ; ).
    INY #2 : STY.b $BA
    
    ASL A : TAX
    
    LDA Subtype2Routines, X : STA.b $0E
    
    LDA Subtype2Params, X : TAX
    
    LDY.b $08
    
    JMP ($000E)
    
    .subtype3Object
    
    AND.w #$000E : ASL #3 : STA.b $04
    
    LDA.b $B4 : ASL #2 : ORA.b $B2 : TSB.b $04
    
    ; A is even and at most 0xE0, Use A as an index into the following jump
    ; table.
    LDA.b $04 : ASL A : TAX
    
    ; The basis for a jump table.
    LDA Subtype3Routines, X : STA.b $0E
    
    LDA Subtype3Params, X : TAX
    
    ; Contains the tile address of the object times two.
    LDY.b $08
    
    JMP ($000E)
}

; ==============================================================================

; $0089DC-$008A43 LOCAL JUMP LOCATION
Dungeon_DrawFloors:
{
    LDX.w #$001E
    
    .nextBg1Offset
    
        ; Sets up the drawing to go to BG1 ($7E4000 and beyond)
        ; I guess we're setting up the addresses that we'll be writing to in
        ; the $BF, X array. This array extends up until $DF.
        LDA.l Dungeon_DrawObjectOffsets_BG1+0, X : STA.b $BF, X
        LDA.l Dungeon_DrawObjectOffsets_BG1+1, X : STA.b $C0, X
    DEX #3 : BPL .nextBg1Offset
    
    LDY.b $BA : INC.b $BA
    
    STZ.b $0C
    
    ; Y = 0 here always, Floor 1 draw.
    LDA [$B7], Y : PHA : AND.w #$00F0 : STA.w $0490 : TAX
    
    ; Draws a 32 x 32 block of tiles to screen.
    JSR.w .nextQuadrant
    
    LDX.w #$001E
    
    .nextBg2Offset
    
        ; Sets up the drawing to now be to BG2 ($7E2000 and beyond).
        LDA.l Dungeon_DrawObjectOffsets_BG2+1, X : STA.b $C0, X
    DEX #3 : BPL .nextBg2Offset
    
    STZ.b $0C
    
    ; Floor 1 draw.
    PLA : AND.w #$000F : ASL #4 : STA.w $046A : TAX
    
    ; $008A1F ALTERNATE ENTRY POINT
    .nextQuadrant
    
        LDY.b $0C
        
        LDA.w Dungeon_QuadrantOffsets, Y : TAY
        
        LDA.w #$0008 : STA.b $0E
        
        .nextRow
        
            LDA.w #$0008
            
            ; Tells the game to draw a 4 x 32 tile block across the screen.
            JSR.w RoomDraw_A_Many32x32Blocks
            
            ADC.w #$01C0 : TAY
        ; This loops 8 times. Thus, this draws a 32 x 32 tile block.
        DEC.b $0E : BNE .nextRow
        
        INC.b $0C : INC.b $0C
    ; This loops 4 times effectively drawing a 64x64 tile block.
    LDA.b $0C : CMP.w #$0008 : BNE .nextQuadrant
    
    RTS
}

; ==============================================================================

; $0A = How many times to perform this routine's goal.
; The routine draws a 32x32 pixel block from right to left and then from up
; to down. e.g. if $0A = 2 it will draw 2 32x32 pixels blocks from left to
; right, if one were to start in the upper left corner.
; $008A44-$008A88 LOCAL JUMP LOCATION
RoomDraw_A_Many32x32Blocks:
{
    STA.b $0A
    
    .next_block
    
        LDA.w #$0002 : STA.b $04
        
        .nextRow

            ; These first four writes draw a 8 x 32 pixel block.
            LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
            LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
            LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
            LDA.w RoomDrawObjectData+06, X : STA [$C8], Y
            
            ; These next four draw another 8 x 32 pixel block directly below
            ; The first tiles. Thus all in all it draws a 16 x 32 pixel block.
            LDA.w RoomDrawObjectData+08, X : STA [$CB], Y
            LDA.w RoomDrawObjectData+10, X : STA [$CE], Y
            LDA.w RoomDrawObjectData+12, X : STA [$D1], Y
            LDA.w RoomDrawObjectData+14, X : STA [$D4], Y
            
            ; Add enough to draw another 16 x 32 directly below the first.
            TYA : CLC : ADC.w #$0100 : TAY
        ; Loops once, which produces a 32 x 32 pixel region in the tilemap.
        ; So this whole loop in effect makes a 4 x 4 tile block.
        DEC.b $04 : BNE .nextRow

        ; Places the next 4 x 4 tile block directly to the right of the
        ; previous one.
        TYA : SEC : SBC.w #$01F8 : TAY
    DEC.b $0A : BNE .next_block
    
    CLC
    
    RTS
}

; ==============================================================================

; $008A89-$008A91 JUMP LOCATION
RoomDraw_Downwards4x2_1to15or26:
{
    JSR.w Object_Size_1_to_15_or_26
    
    LDA.w #$0100
    
    JMP Object_Draw2x4s_VariableOffset
}

; ==============================================================================

; $008A92-$008AA2 JUMP LOCATION
Object_Draw4x2s_AdvanceRight_from_1_to_15_or_26:
{
    JSR.w Object_Size_1_to_15_or_26
    
    ; TODO: Guessing this is the start of the tiles to draw.
    STX.b $0A
    
    .next_block
    
        LDA.w #$0002
        
        JSR.w Object_Draw4xN
        
        LDX.b $0A
    DEC.b $B2 : BNE .next_block

    ; Bleeds into the next function.
}
    
; $008AA3-$008AA3 JUMP LOCATION
RoomDraw_Nothing_B:
{
    RTS
}

; ==============================================================================

; $008AA4-$008B0C JUMP LOCATION
RoomDraw_Downwards4x2_1to16_BothBG:
{
    ; Swap X and Y (destroying A).
    TXA : TYX : TAY
    
    JSR.w Object_Size1to16
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4002, X : STA.l $7E2002, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4004, X : STA.l $7E2004, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4006, X : STA.l $7E2006, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E4080, X : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+10, Y : STA.l $7E4082, X : STA.l $7E2082, X
        LDA.w RoomDrawObjectData+12, Y : STA.l $7E4084, X : STA.l $7E2084, X
        LDA.w RoomDrawObjectData+14, Y : STA.l $7E4086, X : STA.l $7E2086, X
        
        TXA : CLC : ADC.w #$0100 : TAX
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $008B0D-$008B73 JUMP LOCATION
Object_Draw4x2s_AdvanceRight_from_1_to_16_BothBgs:
{
    ; Swap X and Y (destroying A).
    TXA : TYX : TAY
    
    JSR.w Object_Size1to16
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4180, X : STA.l $7E2180, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E4002, X : STA.l $7E2002, X
        LDA.w RoomDrawObjectData+10, Y : STA.l $7E4082, X : STA.l $7E2082, X
        LDA.w RoomDrawObjectData+12, Y : STA.l $7E4102, X : STA.l $7E2102, X
        LDA.w RoomDrawObjectData+14, Y : STA.l $7E4182, X : STA.l $7E2182, X
        
        INX #4
    DEC.b $B2 : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $008B74-$008B78 JUMP LOCATION
RoomDraw_Downwards2x2_1to16:
{
    JSR.w Object_Size1to16
    
    BRA Object_Draw2x2sDownVariableOrFull_next_block
}

; ==============================================================================

; $008B79-$008B7D JUMP LOCATION
RoomDraw_Rightwards2x2_1to16:
{
    JSR.w Object_Size1to16
    
    BRA Object_Draw2x2s_AdvanceRight_next_block
}

; ==============================================================================

; $008B7E-$008B88 JUMP LOCATION
Object_Draw2x2sDownVariableOrFull:
{
    JSR.w Object_Size_1_to_15_or_32
    
    .next_block
    
        JSR.w Object_Draw2x2_AdvanceDown
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $008B89-$008B93 JUMP LOCATIONs
Object_Draw2x2s_AdvanceRight:
{
    .from_1_to_15_or_32
    
    ; 1 to 0x0F or 0x20 tiles wide.
    JSR.w Object_Size_1_to_15_or_32
    
    .next_block
    
        JSR.w Object_Draw2x2
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $008B94-$008BDF JUMP LOCATION
Object_DrawRectOf1x1s:
{
    INC.b $B2
    INC.b $B4
    
    .nextRowOfBlocks
    
        LDA.b $B2 : STA.b $0A
        
        .nextColumnBlock
        
            LDA.w RoomDrawObjectData, X
            STA [$BF], Y : STA [$C2], Y
            STA [$C5], Y : STA [$C8], Y
            STA [$CB], Y : STA [$CE], Y
            STA [$D1], Y : STA [$D4], Y
            
            TYA : CLC : ADC.w #$0100 : TAY
            
            LDA.w RoomDrawObjectData, X
            STA [$BF], Y : STA [$C2], Y
            STA [$C5], Y : STA [$C8], Y
            STA [$CB], Y : STA [$CE], Y
            STA [$D1], Y : STA [$D4], Y
            
            TYA : SEC : SBC.w #$00F8 : TAY
        DEC.b $0A : BNE .nextColumnBlock
        
        LDA.b $08 : CLC : ADC.w #$0200 : STA.b $08 : TAY
    DEC.b $B4 : BNE .nextRowOfBlocks
    
    RTS
}

; ==============================================================================

; $008BE0-$008BF3 JUMP LOCATION
RoomDraw_DiagonalCeilingTopLeftA:
{
    LDA.w #$0004
    
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        ADC.w #$0080 : STA.b $08 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008BF4-$008C0D JUMP LOCATION
RoomDraw_DiagonalCeilingBottomLeftA:
{
    LDA.w #$0004
    
    JSR.w Object_Size_N_to_N_plus_15
    
    INC.b $B4
    
    .nextRow
    
        LDA.b $B4
        
        JSR.w RoomDraw_Repeated1x1
        
        ADC.w #$0080 : STA.b $08 : TAY
        
        INC.b $B4
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008C0E-$008C21 JUMP LOCATION
RoomDraw_DiagonalCeilingTopRightA:
{
    LDA.w #$0004
    
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        ADC.w #$0082 : STA.b $08 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008C22-$008C36 JUMP LOCATION
RoomDraw_DiagonalCeilingBottomRightA:
{
    LDA.w #$0004
    
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        SEC : SBC.w #$007E : STA.b $08 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008C37-$008C4E JUMP LOCATION
RoomDraw_Rightwards2x4spaced4_1to16_BothBG:
{
    JSR.w Object_Size1to16
    
    STX.b $0A
    
    .next_block
    
        LDA.w #$0002
        
        JSR.w Object_Draw4xN
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        LDX.b $0A
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; $008C4F-$008C57 JUMP LOCATION
RoomDraw_DownwardsDecor4x2spaced4_1to16:
{
    JSR.w Object_Size1to16
    
    LDA.w #$0300
    
    JMP Object_Draw2x4s.VariableOffset
}

; $008C58-$008C60 JUMP LOCATION
RoomDraw_DiagonalAcute_1to16:
{
    ; Sets minimum width to 7, maximum to 22.
    LDA.w #$0007
    
    JSR.w Object_Size_N_to_N_plus_15
    
    ; In reality, the width will range from 6 to 21, because of preincrementing
    ; in this destination.
    JMP.w RoomDraw_DrawDiagonalAcute_start
}

; $008C61-$008C69 JUMP LOCATION
RoomDraw_DiagonalGrave_1to16:
{
    ; Sets minimum width to 7, maximum to 22.
    LDA.w #$0007
    
    JSR.w Object_Size_N_to_N_plus_15
    
    ; In reality, the width will range from 6 to 21, because of preincrementing
    ; in this destination.
    JMP.w RoomDraw_DrawDiagonalGrave_start
}

; $008C6A-$008CB8 JUMP LOCATION
RoomDraw_DiagonalAcute_1to16_BothBG:
{
    ; Swap X and Y, destroying A.
    TXA : TYX : TAY
    
    LDA.w #$0006
    
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w #$FF82
    
    ; $008C76 ALTERNATE ENTRY POINT
    .next_bg
    
    STA.b $0E
    
    .loop
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4180, X : STA.l $7E2180, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E4200, X : STA.l $7E2200, X
        
        TXA : CLC : ADC.b $0E : TAX
    DEC.b $B2 : BNE .loop
    
    RTS
}

; $008CB9-$008CC6 JUMP LOCATION
RoomDraw_DiagonalGrave_1to16_BothBG:
{
    ; Swap X and Y, destroying A.
    TXA : TYX : TAY
    
    LDA.w #$0006
    
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w #$0082
    
    BRA RoomDraw_DiagonalAcute_1to16_BothBG_next_bg
}

; $008CC7-$008D46 JUMP LOCATION
RoomDraw_ClosedChestPlatform:
{
    LDA.b $B2 : CLC : ADC.w #$0004 : STA.b $B2 : STA.b $0A
    
    INC.b $B4
    
    JSR.w RoomDraw_ChestPlatformHorizontalWallWithCorners
    
    STX.w $0006
    
    LDA.b $08 : STA.b $04
    
    CLC : ADC.w #$0180 : STA.b $08
    
    LDA.b $B4 : STA.b $0E
    
    .nextMiddleBlockRow
    
        LDA.b $B2 : STA.b $0A
        
        LDY.b $08
        LDX.b $06
        
        JSR.w Object_Draw2x3
        
        TXA : CLC : ADC.w #$000C : TAX
        
        TYA : CLC : ADC.w #$0006 : TAY
        
        .nextMiddleBlock
        
            JSR.w Object_Draw2x2
        DEC.b $0A : BNE .nextMiddleBlock
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        JSR.w Object_Draw2x3
        
        LDA.b $08 : CLC : ADC.w #$0100 : STA.b $08
    DEC.b $0E : BNE .nextMiddleBlockRow
    
    TXA : CLC : ADC.w #$000C : TAX
    
    LDY.b $08
    
    LDA.b $B2 : STA.b $0A
    
    JSR.w RoomDraw_ChestPlatformHorizontalWallWithCorners
    
    LDA.w #$FF80
    
    .locateVerticalMidpoint
    
        SEC : SBC.w #$0080
    DEC.b $B4 : BNE .locateVerticalMidpoint
    
    CLC : ADC.b $08
    
    INC.b $B2 : INC.b $B2
    
    ASL.b $B2 : CLC : ADC.b $B2 : TAY
    
    LDX.w #$0590
    
    JMP Object_Draw2x2
}

; $008D47-$008D5C LOCAL JUMP LOCATION
RoomDraw_ChestPlatformHorizontalWallWithCorners:
{
    JSR.w RoomDraw_ChestPlatformCorner
    
    .next_block
    
        LDA.w #$0002
        
        JSR.w Object_Draw3xN
        
        TXA : SEC : SBC.w #$000C : TAX
    DEC.b $0A : BNE .next_block
    
    JMP.w RoomDraw_ChestPlatformCorner_advance_from_A
}

; $008D5D-$008D7F JUMP LOCATION
RoomDraw_Rightwards1x2_1to16_plus2:
{
    ; Widths range in { 0x01, 0x03, 0x05, ..., 0x1D, 0x1F }.
    LDA.b $B2 : ASL #2 : ORA.b $B4 : ASL A : INC A : STA.b $B2
    
    LDA.w #$0002
    
    JSR.w Object_Draw3xN
    
    .next_two_columns
    
        TXA : SEC : SBC.w #$0006 : TAX
        
        LDA.w #$0001
        
        JSR.w Object_Draw3xN
    DEC.b $B2 : BNE .next_two_columns
    
    LDA.w #$0001
    
    ; Bleeds into the next function.
}
    
; $008D80-$008D9D LOCAL JUMP LOCATION
Object_Draw3xN:
{
    STA.b $0E
    
    .next_column
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
        
        TXA : CLC : ADC.w #$0006 : TAX
        
        INY #2
    DEC.b $0E : BNE .next_column
    
    RTS
}

; $008D9E-$008DDB JUMP LOCATION
RoomDraw_3x3FloorIn4x4SuperSquare:
{
    INC.b $B2
    INC.b $B4
    
    .next_row_of_blocks
    
        LDA.b $B2 : STA.b $0A
        
        .next_block_to_the_right
        
            LDA.w RoomDrawObjectData+00, X
            
            ; Draw a 2x3 block.
            STA [$BF], Y : STA [$C2], Y : STA [$C5], Y
            STA [$CB], Y : STA [$CE], Y : STA [$D1], Y
            
            TYA : CLC : ADC.w #$0100 : TAY
            
            LDA.w RoomDrawObjectData+00, X : STA [$BF], Y : STA [$C2], Y : STA [$C5], Y
            
            TYA : SEC : SBC.w #$00FA : TAY
        DEC.b $0A : BNE .next_block_to_the_right
        
        LDA.b $08 : CLC : ADC.w #$0180 : STA.b $08 : TAY
    DEC.b $B4 : BNE .next_row_of_blocks
    
    RTS
}

; ==============================================================================

; Variable Size Hole object
; Type 1 Subtype 1 Index 0xA4
; $008DDC-$008E66 JUMP LOCATION
Object_Hole:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    
    STA.b $B4 : STA.b $0E
    
    PHY
    
    ; This loop draws the transparent portion.
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        STA.b $0C
        
        ADC.w #$0080 : STA.b $08 : TAY
    DEC.b $0E : BNE .nextRow
       
    ; Start back at the top.
    PLY : STY.b $08
    
    LDA.w #$0002 : STA.b $0E
    
    LDX.w #$063C
    
    .repeatOnBottomRow
    
        LDA.b $B2 : DEC #2 : STA.b $0A
        
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        LDA.w RoomDrawObjectData+02, X
        
        .nextColumn
        
            STA [$C2], Y
            
            INY #2
        DEC.b $0A : BNE .nextColumn
        
        LDA.w RoomDrawObjectData+04, X : STA [$C2], Y
        
        TXA : CLC : ADC.w #$0006 : TAX
        
        LDY.b $0C
    DEC.b $0E : BNE .repeatOnBottomRow
    
    LDA.b $08 : CLC : ADC.w #$0080
    
    LDY.b $B2 : DEY : STY.b $B4
    
    DEC.b $B4
    
    .findRightBoundary
    
        INC #2
    DEY : BNE .findRightBoundary
    
    STA.b $0C
    
    LDA.w #$0002 : STA.b $0E
    
    LDA.b $08 : CLC : ADC.w #$0080 : TAY
    
    LDX.w #$0648
    
    .repeatOnRightBoundary
    
        LDA.b $B4 : STA.b $0A
        
        .nextRow2
        
            LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
            
            TYA : CLC : ADC.w #$0080 : TAY
        DEC.b $0A : BNE .nextRow2
        
        INX #2
        
        LDY.b $0C
    DEC.b $0E : BNE .repeatOnRightBoundary
    
    RTS
}

; ==============================================================================

; $008E67-$008E7A JUMP LOCATION
RoomDraw_DiagonalCeilingTopLeftB:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        ADC.w #$0080 : STA.b $08 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008E7B-$008E94 JUMP LOCATION
RoomDraw_DiagonalCeilingBottomLeftB:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    
    INC.b $B4
    
    .nextRow
    
        LDA.b $B4
        
        JSR.w RoomDraw_Repeated1x1
        
        ADC.w #$0080 : STA.b $08 : TAY
        
        INC.b $B4
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008E95-$008EA8 JUMP LOCATION
RoomDraw_DiagonalCeilingTopRightB:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        ADC.w #$0082 : STA.b $08 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008EA9-$008EBD JUMP LOCATION
RoomDraw_DiagonalCeilingBottomRightB:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        JSR.w RoomDraw_Repeated1x1_CachedCount
        
        SEC : SBC.w #$007E : STA.b $08 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008EBE-$008EEA JUMP LOCATION
RoomDraw_DownwardsHasEdge1x1_1to16_plus23:
{
    LDA.w #$0015
    
    BRA RoomDraw_DownwardsHasEdge1x1_1to16_plus3_setSize
}

; $008EC3 JUMP LOCATION
RoomDraw_DownwardsHasEdge1x1_1to16_plus3:
{
    LDA.w #$0002
    
    .setSize
    
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w #$00E3
    
    JSR.w RoomDraw_SmallRailCorner : BCC .dontOverwrite
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    
    .dontOverwrite

    .nextTile
    
        TYA : CLC : ADC.w #$0080 : TAY
        
        LDA.w RoomDrawObjectData+02, X : STA [$BF], Y 
    DEC.b $B2 : BNE .nextTile
    
    LDA.w RoomDrawObjectData+04, X : STA [$CB], Y
    
    RTS
}

; $008EEB-$008F0B JUMP LOCATION
Object_HorizontalRail:
{
    .long
    
    LDA.w #$0015
    
    BRA .setWidth
    
    ; $008EF0 ALTERNATE ENTRY POINT
    .short
    
    LDA.w #$0002 ; There's a minimum of two segments.
    
    .setWidth
    
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w #$00E2
    
    JSR.w RoomDraw_SmallRailCorner : BCC .beta
        ; If the current tile CHR is not equal to 0x00E2, draw this tile.
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    
    .beta
    
    JSR.w RoomDraw_Repeated1x1_AdvanceWithCachedCount
    
    LDA.w RoomDrawObjectData+02, X : STA [$BF], Y
    
    RTS
}

; $008F0C-$008F35 JUMP LOCATION
RoomDraw_DownwardsBigRail3x1_1to16plus5:
{
    JSR.w Object_Size1to16
    
    JSR.w Object_Draw2x2_AdvanceDown
    
    TXA : CLC : ADC.w #$0008 : TAX
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .nextRow
    
    INX #4

    ; Segues into the next function.
}

; $008F30-008F35 JUMP LOCATION
Object_Draw3x2:
{
    LDA.w #$0002
    JMP Object_Draw3xN
}

; $008F36-$008F61 JUMP LOCATION
RoomDraw_RightwardsBigRail1x3_1to16plus5:
{
    JSR.w Object_Size1to16
    
    INC.b $B2
    
    LDA.w #$0002
    
    JSR.w Object_Draw3xN
    
    .loop
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
        
        INY #2
    DEC.b $B2 : BNE .loop
    
    INX #6
    
    LDA.w #$0002
    
    JMP Object_Draw3xN
}

; $008F62-$008F89 JUMP LOCATION
RoomDraw_RightwardsHasEdge1x1_1to16_plus2:
{
    JSR.w Object_Size1to16
    
    LDA.w #$01DB
    
    ; If(grabbed byte == 0x01DB)
    JSR.w RoomDraw_SmallRailCorner : BCC .BRANCH_ALPHA
        CMP.w #$01A6 : BEQ .BRANCH_ALPHA
        CMP.w #$01DD : BEQ .BRANCH_ALPHA
        CMP.w #$01FC : BEQ .BRANCH_ALPHA
            LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    
    .BRANCH_ALPHA
    
    JSR.w RoomDraw_Repeated1x1_AdvanceWithCachedCount
    
    LDA.w RoomDrawObjectData+02, X : STA [$BF], Y
    
    RTS
}

; $008F8A-$008F9C JUMP LOCATION
RoomDraw_DownwardsEdge1x1_1to16:
{
    JSR.w Object_Size1to16
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $008F9D-$008FA1 JUMP LOCATION
RoomDraw_4x4FloorTwoIn4x4SuperSquare:
{
    LDX.w $0490
    
    BRA RoomDraw_4x4FloorIn4x4SuperSquare
}

; $008FA2-$008FA4 JUMP LOCATION
RoomDraw_4x4FloorOneIn4x4SuperSquare:
{
    LDX.w $046A

    ; Bleeds into the next function.
}

; $008FA5-$008FBB LOCAL JUMP LOCATION
RoomDraw_4x4FloorIn4x4SuperSquare:
{
    INC.b $B2
    INC.b $B4
    
    .next_block
    
    LDA.b $B2
    
        JSR.w RoomDraw_A_Many32x32Blocks
        
        LDA.b $08 : CLC : ADC.w #$0200 : STA.b $08 : TAY
    DEC.b $B4 : BNE .next_block
    
    RTS
}

; $008FBC-$008FBC JUMP LOCATION
RoomDraw_Nothing_D:
{
    RTS
}

; $008FBD-$009000 JUMP LOCATION
RoomDraw_RightwardsTopCorners1x2_1to16_plus13:
{
    LDA.w #$000A
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w RoomDrawObjectData+00, X : STA.b $0E
    
    INX #2
    
    LDA [$BF], Y : AND.w #$03FF : CMP.w #$00E2 : BEQ .dontOverwrite
        JSR.w .draw_2x2_at_endpoint
    
    .dontOverwrite
    
    INX #4
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        LDA.b $0E : STA [$CB], Y
        
        INY #2
    DEC.b $B2 : BNE .nextColumn
    
    INX #2
    
    .draw_2x2_at_endpoint
    
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
    
    LDA.b $0E : STA [$CB], Y : STA [$CE], Y
    
    INY #4
    
    RTS
}

; $009001-$009044 JUMP LOCATION
RoomDraw_RightwardsBottomCorners1x2_1to16_plus13:
{
    LDA.w #$000A
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w RoomDrawObjectData+00, X : STA.b $0E
    
    INX #2
    
    LDA [$CB], Y : AND.w #$03FF : CMP.w #$00E2 : BEQ .dontOverwrite
        JSR.w .draw_2x2_at_endpoint
    
    .dontOverwrite
    
    INX #4
    
    .nextColumn
    
        LDA.b $0E      : STA [$BF], Y
        LDA.w RoomDrawObjectData+00, X : STA [$CB], Y
        
        INY #2
    DEC.b $B2 : BNE .nextColumn
    
    INY #2
    
    .draw_2x2_at_endpoint
    
    LDA.b $0E      : STA [$BF], Y
                     STA [$C2], Y
    LDA.w RoomDrawObjectData+00, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CE], Y
    
    INY #4
    
    RTS
}

; $009045-$00908E JUMP LOCATION
RoomDraw_DownwardsLeftCorners2x1_1to16_plus12:
{
    LDA.w #$000A
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w RoomDrawObjectData+00, X : STA.b $0E
    
    INX #2
    
    LDA [$BF], Y : AND.w #$03FF : CMP.w #$00E3 : BEQ .BRANCH_ALPHA
        JSR.w .draw_2x2_at_endpoint
    
    .BRANCH_ALPHA
    
    INX #4
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.b $0E      : STA [$C2], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .nextRow
    
    INX #2
    
    .draw_2x2_at_endpoint
    
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
    
    LDA.b $0E : STA [$C2], Y
                STA [$CE], Y
    
    TYA : CLC : ADC.w #$0100 : TAY
    
    RTS
}

; $00908F-$0090D8 JUMP LOCATION
RoomDraw_DownwardsRightCorners2x1_1to16_plus12:
{
    LDA.w #$000A
    JSR.w Object_Size_N_to_N_plus_15
    
    LDA.w RoomDrawObjectData+00, X : STA.b $0E
    
    INX #2
    
    LDA [$C2], Y : AND.w #$03FF : CMP.w #$00E3 : BEQ .dontOverwrite
        JSR.w .draw_2x2_at_endpoint
    
    .dontOverwrite
    
    INX #4
    
    .nextRow
    
        LDA.b $0E      : STA [$BF], Y
        LDA.w RoomDrawObjectData+00, X : STA [$C2], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .nextRow
    
    INX #2
    
    .draw_2x2_at_endpoint
    
    LDA.b $0E : STA [$BF], Y : STA [$CB], Y
    
    LDA.w RoomDrawObjectData+00, X : STA [$C2], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CE], Y
    
    TYA : CLC : ADC.w #$0100 : TAY
    
    RTS
}

; $0090D9-$0090E1 JUMP LOCATION
RoomDraw_RightwardsEdge1x1_1to16plus7:
{
    LDA.w #$0008
    JSR.w Object_Size_N_to_N_plus_15
    
    JMP.w RoomDraw_Repeated1x1_CachedCount
}

; $0090E2-$0090F7 JUMP LOCATION
RoomDraw_DownwardsEdge1x1_1to16plus7:
{
    LDA.w #$0008
    JSR.w Object_Size_N_to_N_plus_15
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; $0090F8-$0090F8 JUMP LOCATION
RoomDraw_Nothing_A:
{
    RTS
}

; $0090F9-$009110 JUMP LOCATION
RoomDraw_DownwardsFloor4x4_1to16:
{
    STX.b $0A

    JSR.w Object_Size1to16
    
    .next_block
    
        LDX.b $0A
        
        JSR.w Object_Draw4x4
        
        LDA.b $08 : CLC : ADC.w #$0200 : STA.b $08 : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; $009111-$00911F JUMP LOCATION
RoomDraw_Rightwards4x4_1to16:
{
    STX.b $0A
    
    JSR.w Object_Size1to16
    
    .loop
    
        LDX.b $0A
        
        JSR.w Object_Draw4x4
    DEC.b $B2 : BNE .loop
    
    RTS
}

; $009120-$009135 JUMP LOCATION
RoomDraw_Downwards1x1Solid_1to16_plus3:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    
    .loop
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .loop
    
    RTS
}

; $009136-$00913E JUMP LOCATION
RoomDraw_Rightwards1x1Solid_1to16_plus3:
{
    LDA.w #$0004
    JSR.w Object_Size_N_to_N_plus_15
    JMP.w RoomDraw_Repeated1x1_CachedCount
}

; 1.1.0x35
; This object seems to do something, but it shows up in no room in the ROM! (to
; my knowledge) However, it seems to utilize code used by doors. Seems like it
; might have something to do with Agahnim's curtains, but it's a long shot.
; $00913F-$00918E JUMP LOCATION
RoomDraw_DoorSwitcherer:
{
    STY.w $04B0
    
    ; Check to see which BG we're on.
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        ; Using BG1 so use an address that indexes into its wram tilemap.
        TYA : ORA.w #$2000 : STA.w $04B0 : TAY
    
    .onBG2
    
    ; Check if a flag in the room information is set.
    ; Branch if a chest has been opened in this room?.... strange
    ; probably doesn't mean that.
    LDA.w $0402 : AND.w #$1000 : BEQ .eventHasntOccurred
        STY.b $08
        
        ; Note the two consecutive loads for the Y register here
        ; (double checked). This strongly suggests that the code for and
        ; related to this object was not finished. We may be able to commandeer
        ; it later, though.
        LDY.w #$0052
        LDY.b $08
        
        LDA.w #$0003 : STA.b $0E
        
        ; Draw a 4x3 region of tiles.
        JSR.w DrawUnusedDoorSwitchObject
        
        ; This load of Y is also ignored.
        LDY.w #$0052
        
        LDA.b $08 : CLC : ADC.w #$000A
        
        LDY.b $BF : CPY.w #$4000 : BNE .onBG2_2
            CLC : ADC.w #$0004
        
        .onBG2_2
        
        ; Again note that the above code is clearly nonsensical.
        ; Why go to all the trouble of implementing logic to set a value for A
        ; And then just overwrite it with 0x0003 on this line.
        LDA.w #$0003 : STA.b $0E
        
        ; I'm fairly certain that his is overwriting the 4x3 region
        ; we drew earlier... wtf?
        JSR.w RoomDraw_DrawUnreachableDoorSwitcher
        
        RTS
    
    .eventHasntOccurred
    
    LDA.b $04B0 : ORA.w #$8000 : STA.w $04B0
    
    RTS
}

; Undefined objects (1.1.0xCB, 1.1.0xCC).
; $00918F-$00918F JUMP LOCATION
RoomDraw_Nothing_E:
{
    RTS
}

; Hidden wall (facing right)
; $009190-$00921B JUMP LOCATION
Object_HiddenWallRight:
{
    JSR.w RoomDraw_CheckIfWallIsMoved : BCS .drawWall
        RTS
    
    .drawWall
    
    ; Increment the collision variable as a way of notifying the game
    ; that we should additionally check for collision with BG1, even if
    ; Link is on BG2.
    INC.w $0428
    
    LDA.b $B2 : ASL A : TAY
    
    LDA.w RoomDraw_MovingWallDirection, Y : PHA
    
    ASL A : ADC.w #$0004 : STA.b $0E
    
    LDA.b $B4 : ASL A : STA.w $041E : TAY
    
    LDA.w MovingWallObjectCount, Y : STA.b $0C : TAY
    
    LDA.b $08
    
    .BRANCH_BETA
    
        DEC #2
    DEY : BNE .BRANCH_BETA
    
    PHA : STA.b $06
    
    LDX.w #$03D8
    
    .BRANCH_DELTA
    
        LDA.b $0E : STA.b $0A
        
        LDY.b $06
        
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y

        .BRANCH_GAMMA

            LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
            
            TYA : CLC : ADC.w #$0080 : TAY
        DEC.b $0A : BNE .BRANCH_GAMMA
        
        LDA.w RoomDrawObjectData+04, X : STA [$CB], Y
        
        INC.b $06 : INC.b $06
    DEC.b $0C : BNE .BRANCH_DELTA
    
    PLA : DEC #2 : STA.b $06 : TAY
    
    JSR.w MovingWall_FillReplacementBuffer
    
    LDY.b $08
    
    LDX.w #$072A
    
    JSR.w RoomDraw_ChestPlatformCorner
    
    PLA : STA.b $0E
    
    LDA.b $08 : CLC : ADC.w #$0180 : TAY
    
    .BRANCH_EPSILON
    
        JSR.w Object_Draw2x3
        
        TYA : CLC : ADC.w #$0100 : TAY
    DEC.b $0E : BNE .BRANCH_EPSILON

    ; Bleeds into the next function.
}

; $009210-$009210 JUMP LOCATION
RoomDraw_ChestPlatformCorner_advance_from_X:
{
    TXA

    ; Bleeds into the next function.
}
    
; $009211-$009215 JUMP LOCATION
RoomDraw_ChestPlatformCorner_advance_from_A:
{   
    CLC : ADC.w #$000C : TAX

    ; Bleeds into the next function.
}

; $009216-$00921B JUMP LOCATION
RoomDraw_ChestPlatformCorner:
{
    LDA.w #$0003
    
    JMP Object_Draw3xN
}

; Hidden wall (facing left)
; $00921C-$009297 JUMP LOCATION
Object_HiddenWallLeft:
{
    JSR.w RoomDraw_CheckIfWallIsMoved : BCS .drawWall
        RTS
    
    .drawWall
    
    INC.w $0428
    
    LDY.b $08
    
    LDX.w #$075A
    
    JSR.w RoomDraw_ChestPlatformCorner
    
    LDA.b $B2 : ASL A : TAY
    
    LDA.w RoomDraw_MovingWallDirection, Y : STA.b $0E : PHA
    
    LDA.b $08 : CLC : ADC.w #$0180 : TAY
    
    .BRANCH_BETA
    
        JSR.w Object_Draw2x3
        
        TYA : CLC : ADC.w #$0100 : TAY
    DEC.b $0E : BNE .BRANCH_BETA
    
    JSR.w RoomDraw_ChestPlatformCorner_advance_from_X
    
    PLA : ASL A : ADC.w #$0004 : STA.b $0E
    
    LDA.b $B4 : ASL A : STA.w $041E : TAY
    
    LDA.w MovingWallObjectCount, Y : STA.b $0C
    
    LDA.b $08 : CLC : ADC.w #$0006 : STA.b $06
    
    LDX.w #$03D8
    
    .BRANCH_DELTA
    
        LDA.b $0E : STA.b $0A
        
        LDY.b $06
        
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        .BRANCH_GAMMA
        
            LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
            
            TYA : CLC : ADC.w #$0080 : TAY
        DEC.b $0A : BNE .BRANCH_GAMMA
        
        LDA.w RoomDrawObjectData+04, X : STA [$CB], Y
        
        INC.b $06 : INC.b $06
    DEC.b $0C : BNE .BRANCH_DELTA
    
    LDY.b $06
    
    JMP.w MovingWall_FillReplacementBuffer
}

; ==============================================================================

; Objects (1.1.0xD3, 1.1.0xD4, 1.1.0xD5, 1.1.0xD6)
; $009298-$0092D0 JUMP LOCATION
RoomDraw_CheckIfWallIsMoved:
{
    STZ.w $041C
    STZ.w $041A
    
    SEP #$30
    
    LDX.b #$00 : TXY
    
    LDA.b $AE : CMP.b #$1C : BCC .tryScript2
        CMP.b #$20 : BCC .isHiddenWallScript
    
    .tryScript2
    
    LDY.b #$02
    
    INX
    
    ; Load the Tag2 (other properties 2) setting for the room.
    LDA.b $AF : CMP.b #$1C : BCC .notHiddenWallScript
                CMP.b #$20 : BCS .notHiddenWallScript
        .isHiddenWallScript
    
        LDA.w $0403 : AND.w DoorFlagMasks-1, Y : BEQ .notYetTriggered
            STZ.w $046C
            STZ.b $AE, X
            STZ.w $0414
            
            ; Note that this has an implicit "CLC" instruction embedded in it.
            REP #$31
            
            RTS
        
        .notYetTriggered
    .notHiddenWallScript
    
    REP #$30
    
    SEC
    
    RTS
}

; ==============================================================================

; $0092D1-$0092FA JUMP LOCATION
MovingWall_FillReplacementBuffer:
{
    LDX.w #$007E
    LDA.w #$01EC
    
    .fill_with_value
    
        STA.l $7EC880, X
    DEX #2 : BPL .fill_with_value
    
    LDA.b $06 : AND.w #$003F : LSR A : STA.b $0A
    
    TYA : AND.w #$0040 : BEQ .BRANCH_BETA
        LDA.w #$0400 : TSB.b $0A
    
    .BRANCH_BETA
    
    LDA.b $0A : ORA.w #$1000 : STA.w $042A
    
    RTS
}

; ==============================================================================

; $0092FB-$00930D JUMP LOCATION
RoomDraw_RightwardsDecor4x4spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    STX.b $0A
    
    .next_block_to_right
    
        LDX.b $0A
        
        JSR.w Object_Draw4x4
        
        INY #4
    DEC.b $B2 : BNE .next_block_to_right
    
    RTS
}

; ==============================================================================

; $00930E-$009322 JUMP LOCATION
RoomDraw_DownwardsDecor4x4spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    STX.b $0A
    
    .next_block
    
        LDX.b $0A
        
        JSR.w Object_Draw4x4
        
        TYA : CLC : ADC.w #$02F8 : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $009323-$009337 JUMP LOCATION
RoomDraw_RightwardsStatue2x3spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    .nextTwoColumns
    
        LDX.w #$0E26
        
        LDA.w #$0002
        
        JSR.w Object_Draw3xN
        
        INY #4
    DEC.b $B2 : BNE .nextTwoColumns
    
    RTS
}

; ==============================================================================

; $009338-$009346 JUMP LOCATION
RoomDraw_RightwardsBlock2x2spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    .BRANCH_ALPHA
    
        JSR.w Object_Draw2x2
        
        INY #4
    DEC.b $B2 : BNE .BRANCH_ALPHA
    
    RTS
}

; ==============================================================================

; $009347-$009356 JUMP LOCATION
RoomDraw_DownwardsBlock2x2spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    .next_block
    
        JSR.w Object_Draw2x2_AdvanceDown
        
        CLC : ADC.w #$0100 : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $009357-$00936E JUMP LOCATION
RoomDraw_DownwardsPillar2x4spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    STX.b $0C
    
    .next_block
    
        LDX.b $0C
        
        LDA.w #$0002
        
        JSR.w Object_Draw4xN
        
        TYA : CLC : ADC.w #$02FC : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $00936F-$009386 JUMP LOCATION
RoomDraw_RightwardsPillar2x4spaced4_1to16:
{
    JSR.w Object_Size1to16
    
    STX.b $0C
    
    .loop
    
        LDA.b $0C
        
        ; Two consecutive loads of A? huh...
        LDA.w #$0002
        
        JSR.w Object_Draw4xN
        
        TYA : CLC : ADC.w #$0008 : TAY
    DEC.b $B2 : BNE .loop
    
    RTS
}

; ==============================================================================

; $009387-$00939E JUMP LOCATION
RoomDraw_RightwardsDecor4x3spaced4_1to16:
{
    STA.b $0A
    
    JSR.w Object_Size1to16
    
    .nextFourColumns
    
        LDX.b $0A
        
        LDA.w #$0004
        
        JSR.w Object_Draw3xN
        
        TYA : CLC : ADC.w #$0008 : TAY
    DEC.b $B2 : BNE .nextFourColumns
    
    RTS
}

; ==============================================================================

; $00939F-$0093B6 JUMP LOCATION
RoomDraw_DownwardsDecor3x4spaced4_1to16:
{
    STX.b $0A
    
    JSR.w Object_Size1to16
    
    .next_block
    
        LDX.b $0A
        
        LDA.w #$0003
        
        JSR.w Object_Draw4xN
        
        TYA : CLC : ADC.w #$03FA : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $0093B7-$0093DB JUMP LOCATION
RoomDraw_RightwardsDoubled2x2spaced2_1to16:
{
    JSR.w Object_Size1to16
    
    .loop
    
        LDX.w #$08CA
        
        JSR.w Object_Draw2x2_AdvanceDown
        
        CLC : ADC.w #$0200 : TAY
        
        ; Since this is a known quantity, why calculate it? (Hint: it's 0x08D2).
        TXA : CLC : ADC.w #$0008 : TAX
        
        JSR.w Object_Draw2x2_AdvanceDown
        
        LDA.b $08 : CLC : ADC.w #$0008 : STA.b $08 : TAY
    DEC.b $B2 : BNE .loop
    
    RTS
}

; ==============================================================================

; $0093DC-$009428 JUMP LOCATION
RoomDraw_TableRock4x4_1to16:
{
    ; = 1 to 4
    INC.b $B2
    
    ; = 1 to 7
    ASL.b $B4 : INC.b $B4
    
    JSR.w .draw_rock_segment
    
    INX #8
    
    .loop
    
        JSR.w .draw_rock_segment
    DEC.b $B4 : BNE .loop
    
    JSR.w .draw_rock_segment_with_advance
    
    ; $0093F7 ALTERNATE ENTRY POINT
    .draw_rock_segment_with_advance

    INX #8
    
    ; $0093FF ALTERNATE ENTRY POINT
    .draw_rock_segment
    
    LDA.b $B2 : STA.b $0E
    
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    
    .loop2
    
        LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
        LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
        
        INY #4
    DEC.b $0E : BNE .loop2
    
    LDA.w RoomDrawObjectData+06, X : STA [$C2], Y
    
    LDA.b $08 : CLC : ADC.w #$0080 : STA.b $08 : TAY
    
    RTS
}

; ==============================================================================

; $009429-$009445 JUMP LOCATION
RoomDraw_Spike2x2In4x4SuperSquare:
{
    ; Width = 1 to 4
    INC.b $B2
    
    ; Height = 1 to 4
    INC.b $B4
    
    .next_row
    
        LDA.b $B2 : STA.b $0E
        
        .next_block_right
        
            JSR.w Object_Draw2x2
        DEC.b $0E : BNE .next_block_right
        
        LDA.b $08 : CLC : ADC.w #$0100 : STA.b $08 : TAY
    DEC.b $B4 : BNE .next_row
    
    RTS
}

; ==============================================================================

; $009446-$009455 JUMP LOCATION
RoomDraw_DownwardsDecor2x2spaced12_1to16:
{
    JSR.w Object_Size1to16
    
    .next_piece
    
        JSR.w Object_Draw2x2_AdvanceDown
        
        CLC : ADC.w #$0600 : TAY
    DEC.b $B2 : BNE .next_piece
    
    RTS
}

; ==============================================================================

; $009456-$009465 JUMP LOCATION
RoomDraw_RightwardsDecor2x2spaced12_1to16:
{
    JSR.w Object_Size1to16
    
    .loop
    
        JSR.w Object_Draw2x2_AdvanceDown
        
        CLC : ADC.w #$FF1C : TAY
    DEC.b $B2 : BNE .loop
    
    RTS
}

; ==============================================================================

; UNUSED: This is another unused object in the rom.
; However it is visually something it's a thin waterfall for indoors!
; $009466-$009487 JUMP LOCATION
RoomDraw_Waterfall47:
{
    JSR.w Object_Size1to16
    
    ASL.b $B2
    
    JSR.w Object_Draw5x1
    
    TXA : CLC : ADC.w #$000A : TAX
    
    INY #2
    
    .nextColumn
    
        JSR.w Object_Draw5x1
        
        INY #2
    DEC.b $B2 : BNE .nextColumn
    
    TXA : CLC : ADC.w #$000A : TAX
    
    JMP Object_Draw5x1
}

; ==============================================================================

; $009488-$0094B3 JUMP LOCATION
RoomDraw_Waterfall48:
{
    JSR.w Object_Size1to16
    
    ASL.b $B2
    
    LDA.w #$0001
    
    JSR.w Object_Draw3xN
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
        
        INY #2
    DEC.b $B2 : BNE .nextColumn
    
    INX #6
    
    LDA.w #$0001
    
    JMP Object_Draw3xN
}

; ==============================================================================

; $0094B4-$0094BC JUMP LOCATION
RoomDraw_RightwardsFloorTile4x2_1to16:
{
    JSR.w Object_Size1to16
    
    LDA.w #$0008
    
    JMP Object_Draw2x4s_VariableOffset
}

; ==============================================================================

; $0094BD-$0094DE JUMP LOCATION
RoomDraw_RightwardsBar4x3_1to16:
{
    JSR.w Object_Size1to16
    
    ASL.b $B2
    
    JSR.w Object_Draw3x1
    
    INY #2
    
    TXA : CLC : ADC.w #$0006 : TAX
    
    .loop
    
        JSR.w Object_Draw3x1
        
        INY #2 
    DEC.b $B2 : BNE .loop
    
    TXA : CLC : ADC.w #$0006 : TAX
    
    JMP Object_Draw3x1
}

; ==============================================================================

; $0094DF-$009500 JUMP LOCATION
RoomDraw_RightwardsShelf4x4_1to16:
{
    JSR.w Object_Size1to16
    
    LDA.w #$0001
    
    JSR.w Object_Draw4xN
    
    .alpha
    
        LDA.w #$0002
        
        JSR.w Object_Draw4xN
        
        TXA : SEC : SBC.w #$0010 : TAX
    DEC.b $B2 : BNE .alpha
    
    TXA : CLC : ADC.w #$0010 : TAX
    
    JMP Object_Draw4x1
}

; ==============================================================================

; $009501-$00959F JUMP LOCATION
Object_Water:
{
    LDA.b $B2 : ASL A : TAX
    
    LDA.w WaterOverlayHDMAPositionOffset, X : STA.b $B2
    
    LDA.w WaterOverlayHDMASize, X : STA.w $0686
    
    LDA.b $B4 : ASL A : TAX
    
    LDA.w WaterOverlayHDMAPositionOffset, X : STA.b $B4
    
    ; Looks like all these $06xx addreses are calculated for hdma of the 
    ; water (for rooms that have a script for that).
    LDA.w WaterOverlayHDMASize, X  : STA.w $0684
    SEC : SBC.w #$0018 : STA.w $0688
    
    TYA : AND.w #$007E : ASL #2 : STA.w $0680
    
    LDA.b $B2 : ASL #4 : CLC : ADC.w $062C : CLC : ADC.w $0680 : STA.w $0680
    
    TYA : AND.w #$1F80 : LSR #4 : STA.w $0682
    
    LDA.b $B4 : ASL #4 : CLC : ADC.w $062E : CLC : ADC.w $0682 : STA.w $0682
    
    SEP #$30
    
    ; (AND with 0x08)
    LDA.w $0403 : AND.w DoorFlagMasks+1 : BEQ RoomTag_WaterOff_notTriggered
        STZ.b $AF
        STZ.w $0414
        
        REP #$30
        
        LDA.w $0442 : STA.w $0440
        LDA.w $0444 : STA.w $0448
        
        STZ.w $0444
        STZ.w $0442
        
        LDA.w $04AE : STA.w $049E
        
        STZ.w $04AE
        
        LDA.b $B2 : DEC A : ASL #2 : STA.b $0E
        
        LDA.b $08 : ADC.b $0E : STA.b $08
        
        LDA.b $B4 : DEC A : XBA : STA.b $0E
        
        LDA.b $08 : ADC.b $0E : TAX

        ; Bleeds into the next function.
}
        
; $0095A0-$0095D4 JUMP LOCATION
RoomTag_WaterOff_AdjustWater:
{
    LDY.w #$1438
        
    LDA.w #$0004 : STA.b $0E
        
    .loop
        
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2002, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2004, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2006, X
            
        TYA : CLC : ADC.w #$0008 : TAY
            
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .loop
        
    RTS
}
    
; $0095D5-$0095EE JUMP LOCATION
RoomTag_WaterOff_notTriggered:
{
    REP #$30
    
    LDX.w #$0110
    
    LDY.b $08
    
    .loop2
    
        LDA.b $B2
        
        JSR.w RoomDraw_A_Many32x32Blocks
        
        LDA.b $08 : CLC : ADC.w #$0200 : STA.b $08 : TAY
    DEC.b $B4 : BNE .loop2
    
    RTS
}

; ==============================================================================

; $0095EF-$0096DB JUMP LOCATION
RoomDraw_WaterOverlayB8x8_1to16:
{
    LDA.b $B2 : ASL A : TAX
    
    ; Use the initial height to index into a table to get the actual height.
    LDA.w WaterOverlayHDMAPositionOffset, X : STA.b $B2
    
    LDA.w WaterOverlayHDMASize, X : SEC : SBC.w #$0018 : STA.w $0686
    
    LDA.b $B4 : ASL A : TAX
    
    LDA.w WaterOverlayHDMAPositionOffset, X : STA.b $B4
    
    LDA.w WaterOverlayHDMASize, X : SEC : SBC.w #$0008 : STA.w $0688
    
    SEC : SBC.w #$0018 : STA.w $0684
    
    STZ.w $068A
    
    TYA : AND.w #$007E : ASL #2 : STA.w $0680
    
    LDA.b $B2 : ASL #4 : CLC : ADC.w $062C : CLC : ADC.w $0680 : STA.w $0680
    
    TYA : CLC : ADC.w #$1F80 : LSR #4 : STA.w $0682
    
    LDA.b $B4 : ASL #4
    CLC : ADC.w $062E : CLC : ADC.w $0682
    SEC : SBC.w #$0008 : STA.w $0682
    
    SEP #$30
    
    LDA.w $0403 : AND.w DoorFlagMasks+1 : BEQ .alpha
        STZ.b $AF
        
        BRA .BRANCH_BETA
    
    .alpha
    
    REP #$30
    
    LDA.w $0442 : STA.w $0440
    LDA.w $0444 : STA.w $0448
    
    STZ.w $0444 : STZ.w $0442
    
    LDA.w $04AE : STA.w $049E
    
    STZ.w $04AE
    
    STZ.w $0414
    
    .BRANCH_BETA
    
    REP #$30
    
    LDA.b $B4 : ASL A : TAX
    
    LDA.w WaterOverlayObjectCount, X : STA.b $04
    
    LDX.w #$0110
    
    .loop1
    
        LDY.b $08
        
        LDA.b $B2 : STA.b $0A
        
        .loop2
        
            LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
            LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
            LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
            LDA.w RoomDrawObjectData+06, X : STA [$C8], Y
            LDA.w RoomDrawObjectData+08, X : STA [$CB], Y
            LDA.w RoomDrawObjectData+10, X : STA [$CE], Y
            LDA.w RoomDrawObjectData+12, X : STA [$D1], Y
            LDA.w RoomDrawObjectData+14, X : STA [$D4], Y
            
            INY #8
        DEC.b $0A : BNE .loop2
        
        LDA.b $08 : CLC : ADC.w #$0100 : STA.b $08
    DEC.b $04 : BNE .loop1
    
    RTS
}

; ==============================================================================

; $0096DC-$0096E3 JUMP LOCATION
RoomDraw_RightwardsLine1x1_1to16plus1:
{
    JSR.w Object_Size1to16
    
    INC.b $B2
    
    JMP.w RoomDraw_Repeated1x1_CachedCount
}

; ==============================================================================

; $0096E4-$0096F8 JUMP LOCATION
RoomDraw_DownwardsLine1x1_1to16plus1:
{
    JSR.w Object_Size1to16
    
    INC.b $B2
    
    .next_block
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $0096F9-$009701 JUMP LOCATION
RoomDraw_RightwardsDecor4x2spaced8_1to16:
{
    JSR.w Object_Size1to16
    
    LDA.w #$0018
    
    JMP Object_Draw2x4s_VariableOffset
}

; ==============================================================================

; $009702-$009719 JUMP LOCATION
RoomDraw_DownwardsDecor2x4spaced8_1to16:
{
    STX.b $0A
    
    JSR.w Object_Size1to16
    
    .next_block
    
        LDX.b $0A
        
        LDA.w #$0002
        
        JSR.w Object_Draw4xN
        
        ; Make next block 10 tiles down?
        TYA : CLC : ADC.w #$05FC : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $00971A-$00971A JUMP LOCATION
RoomDraw_Nothing_C:
{
    RTS
}

; ==============================================================================

; $00971B-$009732 JUMP LOCATION
RoomDraw_DownwardsDecor3x4spaced2_1to16:
{
    STX.b $0A
    
    JSR.w Object_Size1to16
    
    .next_block
    
        LDX.b $0A
        
        LDA.w #$0003
        
        JSR.w Object_Draw4xN
        
        ; Make next block 5 tiles down?
        TYA : CLC : ADC.w #$02FA : TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $009733-$0097B4 JUMP LOCATION
RoomDraw_OpenChestPlatform:
{
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TYA : ORA.w #$2000 : TAY
    
    .onBg2
    
    TYX ; X now holds the tilemap address.
    
    LDY.w #$0AB4
    
    INC.b $B2
    
    ; $B4 = ($B4 * 2) + 5.
    LDA.b $B4 : ASL A : CLC : ADC.w #$0005 : STA.b $B4
    
    .BRANCH_DELTA
    
        JSR.w .draw_segment
    DEC.b $B4 : BNE .BRANCH_DELTA
    
    INY #2
    
    JSR.w .draw_segment
    
    INY #2
    
    ; $00975C ALTERNATE ENTRY POINT
    .draw_segment
    
    PHX
    
    LDA.b $B2 : STA.b $0A
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
    
    LDA.w RoomDrawObjectData+06, Y
    
    .BRANCH_BETA
    
        STA.l $7E2002, X
        
        INX #2
    DEC.b $0A : BNE .BRANCH_BETA
    
    LDA.w RoomDrawObjectData+12, Y : STA.l $7E2002, X
    
    LDA.w RoomDrawObjectData+18, Y
    STA.l $7E2004, X : STA.l $7E2006, X
    STA.l $7E2008, X : STA.l $7E200A, X
    
    LDA.b $B2 : STA.b $0A
    
    LDA.w RoomDrawObjectData+24, Y : STA.l $7E200C, X
    
    LDA.w RoomDrawObjectData+30, Y
    
    .BRANCH_GAMMA
    
        STA.l $7E200E, X
        
        INX #2
    DEC.b $0A : BNE .BRANCH_GAMMA
    
    LDA.w RoomDrawObjectData+36, Y : STA.l $7E200E, X
    
    PLA : CLC : ADC.w #$0080 : TAX
    
    RTS
}

; ==============================================================================

; $0097B5-$0097DB JUMP LOCATION
RoomDraw_DownwardsBar2x5_1to16:
{
    LDA.w #$0002
    JSR.w Object_Size_N_to_N_plus_15
    
    ASL.b $B2
    
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
    
    .nextRow
    
        LDA.w RoomDrawObjectData+04, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+06, X : STA [$CE], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $B2 : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $0097DC-$0097EC JUMP LOCATION
RoomDraw_Weird2x4_1_to_16:
{
    JSR.w Object_Size1to16
    
    .next_block
    
        LDX.w #$0B16
        LDA.w #$0002
        
        JSR.w Object_Draw4xN 
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; $0097ED-$009812 JUMP LOCATION
Object_Draw4x4:
{
    LDA.w #$0004

    ; Bleeds into the next function.
} 

; $0097F0 JUMP LOCATION
Object_Draw4xN:
{
    STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
        LDA.w RoomDrawObjectData+06, X : STA [$DA], Y
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        INY #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $009813-$00985B JUMP LOCATION
Object_Draw4x4_BothBgs:
{
    TXA : TYX : TAY
    
    LDA.w #$0004
    
    ; $009819 ALTERNATE ENTRY POINT
    .set_count
    
    STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4180, X : STA.l $7E2180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}
    
; $009854-$00985B JUMP LOCATION
Object_Draw4x3_BothBgs:
{
    TXA : TYX : TAY
    
    LDA.w #$0003
    
    BRA Object_Draw4x4_BothBgs_variableNumberOfColumns
}

; ==============================================================================

; $00985C-$009891 JUMP LOCATION
Object_Draw3x4_BothBgs:
{
    ; Swap X and Y (destroying A).
    TXA : TYX : TAY
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X : STA.l $7E2100, X
        
        TYA : CLC : ADC.w #$0006 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $009892-$0098AD JUMP LOCATION
RoomDraw_LitTorch:
{
    ; Increment number of torches in room?
    INC.w $045A
    
    ; Bleeds into the next function.
}
    
; $009895 JUMP LOCATION
Object_Draw2x2:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+04, X : STA [$C2], Y
    LDA.w RoomDrawObjectData+06, X : STA [$CE], Y
    
    INY #4
    
    RTS
}

; ==============================================================================

; Big Key Lock
; Type 1 Subtype 3 Index 0x18
; Concern: do these not work on BG0?
; $0098AE-$0098CF JUMP LOCATION
Object_BigKeyLock:
{
    LDX.w $0498
    
    TYA : STA.w $06E0, X
    
    LDA.w $0402 : AND.w RoomFlagMask, X : BNE .alreadyOpened
        INX #2 : STX.w $0498
        
        LDX.w #$1494
        
        BRA Object_Draw2x2
    
    .alreadyOpened
    
    STZ.w $06E0, X
    
    INX #2 : STX.w $0498
    
    ; $0098CF ALTERNATE ENTRY POINT 
    .easyOut
    
    RTS
}

; ==============================================================================

; Normal Chest Object ( Type 0x01.0x03.0x19 )
; $0098D0-$0099BA JUMP LOCATION
Object_Chest:
{
    ; Are we in the ending sequence?
    ; If so, don't bother with this stuff.
    LDA.b $10 : AND.w #$00FF : CMP.w #$001A : BEQ Object_BigKeyLock_easyOut
        LDX.w $0496
        
        ; This is the chest's tile address shifted left by one.
        ; (The msb is set if it's a big chest.)
        TYA : STA.w $06E0, X
        
        LDA.b $BF : CMP.w #$4000 : BNE .onBg2
            TYA : ORA.w #$2000 : STA.w $06E0, X
        
        .onBg2
        
        ; Check to see if the chest has already been opened.
        ; It's already been opened.
        LDA.w $0402 : AND.w RoomFlagMask, X : BNE .alreadyOpened
            INX #2 : STX.w $0496 : STX.w $0498
            
            LDY.w #$FF00
            LDX.w #$0000
            
            ; Check the Tag1 Properties.
            LDA.b $AE : AND.w #$00FF
            
            CMP.w #$0027 : BEQ .hiddenChest
            CMP.w #$003C : BEQ .hiddenChest
            CMP.w #$003E : BEQ .hiddenChest
                CMP.w #$0029 : BCC .checkTag2
                    CMP.w #$0033 : BCC .hiddenChest

                .checkTag2
            
                ; Load the tag2 properties.
                LDA.b $AF : AND.w #$00FF
                
                CMP.w #$0027 : BEQ .hiddenChest2
                CMP.w #$003C : BEQ .hiddenChest2
                CMP.w #$003E : BEQ .hiddenChest2
                CMP.w #$0029 : BCC .notHiddenChest
                CMP.w #$0033 : BCS .notHiddenChest
                    .hiddenChest2
                
                    LDY.w #$00FF
                    
                    INX #2
                
            .hiddenChest
            
            ; Has the chest already been opened?
            ; No, we're done and the chest will remain hidden.
            LDA.w $0402 : AND.l RoomFlagMask, X : BEQ Object_BigKeyLock_easyOut
                ; If the chest has been revealed, neutralize the tag routine
                ; that would trigger it.
                TYA : AND.b $AE : STA.b $AE
                
                .notHiddenChest
                
                LDY.b $08
                
                LDX.w #$149C
                
                JMP Object_Draw2x2
        
        .alreadyOpened
        
        ; If the chest has been opened there's obviously no reason to track its
        ; tile address.
        STZ.w $06E0, X
        
        INX #2 : STX.w $0496 : STX.w $0498
        
        LDY.w #$FF00
        LDX.w #$0000
        
        LDA.b $AE : AND.w #$00FF
        
        CMP.w #$0027 : BEQ .hiddenChest_2
        CMP.w #$003C : BEQ .hiddenChest_2
        CMP.w #$003E : BEQ .hiddenChest_2
        CMP.w #$0029 : BCC .checkTag2_2
        CMP.w #$0033 : BCC .hiddenChest_2
            .checkTag2_2
        
            LDA.b $AF : AND.w #$00FF
            
            CMP.w #$0027 : BEQ .hiddenChest2_2
            CMP.w #$003C : BEQ .hiddenChest2_2
            CMP.w #$003E : BEQ .hiddenChest2_2
            CMP.w #$0029 : BCC .notHiddenChest_2
            CMP.w #$0033 : BCS .notHiddenChest_2
                .hiddenChest2_2
            
                LDY.w #$00FF
                
                INX #2
        
        .hiddenChest_2
        
        TYA : AND.b $AE : STA.b $AE
        
        .notHiddenChest_2
        
        LDY.b $08
        
        LDX.w #$14A4
        
        ; $0099B8 ALTERNATE ENTRY POINT
        .startsOpen
        
        JMP Object_Draw2x2
}

; ==============================================================================

; $0099BB-$0099EB JUMP LOCATION
Object_BigChest:
{
    LDX.w $0496
    
    ; Use this value to indicate a big chest?
    TYA : ORA.w #$8000 : STA.w $06E0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TYA : ORA.w #$A000 : STA.w $06E0, X
    
    .onBg2
    
    ; If the chest has already been opened.
    LDA.w $0402 : AND.w RoomFlagMask, X : BNE Object_OpenedBigChest
        INX #2 : STX.w $0496 : STX.w $0498
        
        LDX.w #$14AC

    ; Bleeds into the next function.
}

; $0099E6 ALTERNATE ENTRY POINT
Object_Draw3x4:
{
    LDA.w #$0004
    JMP Object_Draw3xN
}

; ==============================================================================

; $0099EC-$0099F1 JUMP LOCATION
Object_Draw4x3:
{
    LDA.w #$0003
    JMP Object_Draw4xN
}

; ==============================================================================

; $0099F2-$0099FF JUMP LOCATION
Object_OpenedBigChest:
{
    ; Opened chest, so use different tiles.
    STZ.w $06E0, X
    
    INX #2 : STX.w $0496 : STX.w $0498
    
    LDX.w #$14C4

    ; Bleeds into the next function.
}

; Essentially a fake big chest that is opened. (but was never closed to
; begin with).
; $009A00-$009A05 JUMP LOCATION
RoomDraw_OpenBigChest:
{
    LDA.w #$0004
    JMP Object_Draw3xN
}

; ==============================================================================

; $009A06-$009A0B JUMP LOCATION
Object_Draw3x8:
{
    LDA.w #$0008
    JMP Object_Draw3xN
}

; ==============================================================================

; $009A0C-$009A11 JUMP LOCATION
Object_Draw3x6:
{
    LDA.w #$0006
    JMP Object_Draw3xN
}

; ==============================================================================

; $009A12-$009A65 JUMP LOCATION
Object_Draw7x8:
{
    TXY
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        LDA.b $08 : ORA.w #$2000 : STA.b $08
    
    .onBg2
    
    LDX.b $08
    
    LDA.w #$0008 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E2200, X
        LDA.w RoomDrawObjectData+10, Y : STA.l $7E2280, X
        LDA.w RoomDrawObjectData+12, Y : STA.l $7E2300, X
        
        TYA : CLC : ADC.w #$000E : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $009A66-$009A6E JUMP LOCATION
Object_Draw8x6:
{
    LDY.w #$1F92
    LDA.w #$0006
    JMP Object_Draw8xN.draw
}

; ==============================================================================

; Star shaped switch tiles (1.2.0x1F)
; $009A6F-$009A8F JUMP LOCATION
Object_StarTile:
{
    PHX
    
    LDX.w $0432
    
    TYA : LSR A : STA.w $06A0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TYA : ORA.w #$2000 : LSR A : STA.w $06A0, X
    
    .onBg2
    
    INX #2 : STX.w $0432
    
    PLX
    
    ; Disabled star shaped switch tile (1.2.0x1E)
    ; $009A8D ALTERNATE ENTRY POINT
    .disabled
    
    JMP Object_Draw2x2_AdvanceDown
}

; ==============================================================================

; $009A90-$009AA2 JUMP LOCATION
Object_Draw6x4:
{
    LDA.w #$0004
    JSR.w Object_Draw3xN
    
    LDA.b $08 : CLC : ADC.w #$0180 : TAY
    
    LDA.w #$0004
    
    JMP Object_Draw3xN
}

; ==============================================================================

; $009AA3-$009AA8 JUMP LOCATION
Object_Draw4x6:
{
    LDA.w #$0006
    JMP Object_Draw4xN
}

; ==============================================================================

; $009AA9-$009AED JUMP LOCATION
Object_Rupees:
{
    ; Check to see if the rupees were already collected.
    LDA.w $0402 : AND.w #$1000 : BNE .rupeesAlreadyObtained
        LDA.w #$0003 : STA.b $0E
        
        LDY.w #$1DD6
        
        LDX.b $08
        
        LDA.b $BF : CMP.w #$4000 : BNE .onBg2
            TXA : ORA.w #$2000 : TAX
        
        .onBg2

        .moveTwoColumnsRight
        
            LDA.w RoomDrawObjectData+00, Y
            STA.l $7E2000, X : STA.l $7E2180, X : STA.l $7E2300, X
            LDA.w RoomDrawObjectData+02, Y
            STA.l $7E2080, X : STA.l $7E2200, X : STA.l $7E2380, X
            
            INX #4
        DEC.b $0E : BNE .moveTwoColumnsRight
    
    .rupeesAlreadyObtained
    
    RTS
}

; ==============================================================================

; $009AEE-$009B17 JUMP LOCATION
Object_Draw5x4:
{
    LDA.w #$0005 : STA.b $0E
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
        LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
        LDA.w RoomDrawObjectData+06, X : STA [$C8], Y
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $0E : BNE .nextRow
    
    RTS
}

; ==============================================================================

; UNUSED:
; $009B18-$009B1D LOCAL JUMP LOCATION
UNREACHABLE_019B18:
{
    LDA.w #$0002
    JMP Object_Draw4xN
}

; ==============================================================================

; Object 1.2.0x35 (Water ladders)
; $009B1E-$009B4F JUMP LOCATION
Object_WaterLadder:
{
    ; Branch if not the water twin tag
    LDA.b $AF : AND.w #$00FF : CMP.w #$001B : BNE .alpha
        LDA.b $A0 : ASL A : TAX
        
        LDA.l $7EF000, X : AND.w #$0100 : BNE .alpha
            JMP Object_InactiveWaterLadder
    
    .alpha
    
    LDX.w $0444
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2
    
    STX.w $0444
    
    LDX.w #$1108

    ; Bleeds into the next function.
}

; $009B48 ALTERNATE ENTRY POINT
Object_Draw2x4:
{
    LDA.w #$0001 : STA.b $B2
    JMP Object_Draw2x4s_VariableOffset
}

; ==============================================================================

; $009B50-$009B55 JUMP LOCATION
Object_Draw3x6_Alternate:
{
    ; There really is no difference between this object and the
    ; other Draw3x6 object.
    LDA.w #$0006
    JMP Object_Draw3xN
}

; ==============================================================================

; $009B56-$009BD8 JUMP LOCATION
Object_SanctuaryMantle:
{
    TXY
    
    LDX.b $08
    
    LDA.w #$0006 : STA.b $0E
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, Y
        
        STA.l $7E2000, X : STA.l $7E2008, X
        STA.l $7E2010, X : STA.l $7E201C, X
        STA.l $7E2024, X : STA.l $7E202C, X
        
        ORA.w #$4000
        
        STA.l $7E2002, X : STA.l $7E200A, X
        STA.l $7E2012, X : STA.l $7E201E, X
        STA.l $7E2026, X : STA.l $7E202E, X
        
        LDA.w RoomDrawObjectData+12, Y
        
        STA.l $7E2004, X : STA.l $7E200C, X
        STA.l $7E2020, X : STA.l $7E2028, X
        
        ORA.w #$4000
        
        STA.l $7E2006, X : STA.l $7E200E, X
        STA.l $7E2022, X : STA.l $7E202A, X
        
        INY #2
        
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .nextRow
    
    TYA : CLC : ADC.w #$000C : TAX
    
    LDA.b $08 : CLC : ADC.w #$0014 : TAY
    
    LDA.w #$0004
    
    JMP Object_Draw3xN
}

; ==============================================================================

; $009BD9-$009BF7 LOCAL JUMP LOCATION
Object_Draw2x3:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
    LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
    LDA.w RoomDrawObjectData+06, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+08, X : STA [$CE], Y
    LDA.w RoomDrawObjectData+10, X : STA [$D1], Y
    
    RTS
}

; ==============================================================================

; Watergate barrier object
; $009BF8-$009C3A JUMP LOCATION
Object_Watergate:
{
    LDA.w $0402 : AND.w #$0800 : BNE .hasBeenOpened
        LDA.w #$000A
        JSR.w Object_Draw4xN
        
        LDA.w #$000F : STA.w $0470
        
        LDA.b $08 : STA.w $0472
        
        RTS
    
    .hasBeenOpened
    
    LDX.w #$13E8
    LDA.w #$000A
    JSR.w Object_Draw4xN
    
    LDA.b $B7 : PHA
    LDA.b $B8 : PHA
    LDA.b $BA : PHA
    
    LDA.w #$0004 : STA.b $B9
    
    LDA.w #$F1CD
    JSR.w Object_WatergateChannelWater
    
    REP #$30
    
    PLA : STA.b $BA
    PLA : STA.b $B8
    PLA : STA.b $B7
    
    RTS
}

; ==============================================================================

; $009C3B-$009C43 JUMP LOCATION
RoomDraw_SomariaLine_increment_count:
{
    ; Increase the amount of somaria lines in the current room by 1.
    INC.w $03F4

    ; Bleeds into the next function.
}

; $009C3E ALTERNATE ENTRY POINT
Object_Draw1x1:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    
    RTS
}

; ==============================================================================

; $009C44-$009CC5 JUMP LOCATION
Object_PrisonBars:
{
    TYX
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TXA : ORA.w #$2000 : TAX
    
    .onBg2
    
    PHX
    
    LDY.w #$1488
    LDA.w #$0005 : STA.b $0C
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2004, X
                                         STA.l $7E2012, X

        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2084, X
                          ORA.w #$4000 : STA.l $7E2092, X

        LDA.w RoomDrawObjectData+08, Y : STA.l $7E2104, X
                          ORA.w #$4000 : STA.l $7E2112, X

        LDA.w RoomDrawObjectData+10, Y : STA.l $7E2184, X
                          ORA.w #$4000 : STA.l $7E2192, X
        
        INX #2
    DEC.b $0C : BNE .nextColumn
    
    PLX
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
                      ORA.w #$4000 : STA.l $7E201E, X

    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2002, X
                                     STA.l $7E200E, X
                                     STA.l $7E2010, X
                                     STA.l $7E201C, X

    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2102, X
                      ORA.w #$4000 : STA.l $7E211C, X
    
    RTS
}

; $009CC6-$009CEA JUMP LOCATION
RoomDraw_RightwardsCannonHole4x3_1to16:
{
    JMP Object_Size1to16
    
    LDA.w #$0002
    JMP Object_Draw3xN
    
    DEC.b $B2 : BEQ .alpha
        .loop
        
            PHX
            
            LDA.w #$0002
            JSR.w Object_Draw3xN
            
            PLX
        DEC.b $B2 : BNE .loop
    
    .alpha
    
    TXA : CLC : ADC.w #$000C : TAX
    
    LDA.w #$0002
    JMP Object_Draw3xN
}

; $009CEB-$009D28 JUMP LOCATION
RoomDraw_DownwardsCannonHole3x4_1to16:
{
    JSR.w Object_Size1to16
    
    JSR.w .draw_segment
    
    DEC.b $B2 : BEQ .alpha
        .loop
        
            PHX
            
            JSR.w .draw_segment
            
            PLX
        DEC.b $B2 : BNE .loop
    
    .alpha
    
    TXA : CLC : ADC.w #$000C : TAX
    
    ; $009D04 ALTERNATE ENTRY POINT
    .draw_segment
    
    LDA.w #$0002 : STA.b $0A
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
        LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
        
        INX #6
    
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $0A : BNE .nextRow
    
    RTS
}

; $009D29-$009D5C JUMP LOCATION
RoomDraw_EmptyWaterFace:
{
    ; Check if tag2 is water twin
    LDA.b $AF : AND.w #$00FF : CMP.w #$001B : BNE .notWaterTwinTag
        LDA.b $A0 : ASL A : TAX
        
        ; Directly compare with the save data
        LDA.l $7EF000, X : AND.w #$0100 : BNE RoomDraw_SpittingWaterFace
            LDX.w #$1614
    
    .notWaterTwinTag
    
    SEP #$20
    
    ; Also check for the "turn on water" tag
    LDA.w #$19 : CMP.b $AF : BNE .notTurnOnWaterTag
        ; AND with 0x0008
        LDA.w $0403 : AND.w DoorFlagMasks+1 : BNE RoomDraw_SpittingWaterFace
    
    .notTurnOnWaterTag
    
    REP #$20
    
    STY.w $047C
    
    LDA.w #$0003
    
    BRA .BRANCH_EPSILON
}
    
; $009D5D-$009D66 JUMP LOCATION
RoomDraw_SpittingWaterFace:
{
    .BRANCH_BETA
    
    REP #$20
    
    LDX.w #$162C
    LDA.w #$0005
    
    BRA .BRANCH_EPSILON
}

; $009D67-$009D6B JUMP LOCATION
RoomDraw_DrenchingWaterFace:
{
    LDA.w #$0007
    
    BRA .BRANCH_EPSILON
}

; $009D6C-$009D95 JUMP LOCATION
RoomDraw_TableBowl:
{
    LDA.w #$0002
    
    .BRANCH_EPSILON
    
    STA.b $0E
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
        LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
        LDA.w RoomDrawObjectData+06, X : STA [$C8], Y
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $0E : BNE .nextRow
    
    RTS
}

; Kholdstare's Shell object (1.3.0x15)
; $009D96-$009DD8 JUMP LOCATION
Object_Draw8xN:
Object_KholdstareShell:
{
    ; Check the 0x8000 bit if it was set, don't draw at all.
    LDA.w $0402 : ASL A : BCS .boss_defeated
        LDY.w #$1DFA
        LDA.w #$000A
        
        ; $009DA2 ALTERNATE ENTRY POINT / BRANCH LOCATION
        .draw
        
        STA.b $0A
        
        LDA.b $BF : CMP.w #$4000 : BNE .onBg2
            LDA.b $08 : ORA.w #$2000 : STA.b $08
        
        .onBg2
        
        LDA.w #$0008 : STA.b $0C
        
        .nextRow
        
            LDA.b $0A : STA.b $0E
            
            LDX.b $08
            
            .nextColumn
            
                LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
                
                INY #2
                INX #2
            DEC.b $0E : BNE .nextColumn
            
            LDA.b $08 : CLC : ADC.w #$0080 : STA.b $08
        DEC.b $0C : BNE .nextRow
    
    .boss_defeated
    
    RTS
}

; Trinexx Shell (1.3.0x72)
; $009DD9-$019DE5 JUMP LOCATION
Object_TrinexxShell:
{
    LDA.w $0402 : ASL A : BCS Object_Draw8xN_boss_defeated
        TXY
        
        LDA.w #$000A
        
        ; Indicates that structurally, the Trinexx shell is similar to
        ; Kholdstare's
        BRA .draw
}

; ==============================================================================

; $009DE5-$009E2F JUMP LOCATION
Object_LanternLayer:
{
    LDY.w #$16DC
    LDA.w #$0514
    JSR.w .drawLampPortion
    
    LDY.w #$17F6
    LDA.w #$0554
    JMP .drawLampPortion
    
    LDY.w #$1914
    LDA.w #$1514
    JMP .drawLampPortion
    
    LDY.w #$1A2A
    LDA.w #$1554
    
    .drawLampPortion
    
    STA.b $00
    
    LDA.w #$000C : STA.b $02
    
    .nextRow
    
        LDA.w #$000C : STA.b $0C
        
        LDX.b $00
        
        .nextColumn
        
            LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X
            
            INY #2
            INX #2
        DEC.b $0C : BNE .nextColumn
        
        LDA.b $00 : CLC : ADC.w #$0080 : STA.b $00
    DEC.b $02 : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $009E30-$009EA2 JUMP LOCATION
Object_AgahnimAltar:
{
    LDA.w #$000E : STA.b $0E
    
    LDY.w #$1B4A
    
    LDX.b $08
    
    .nextRow
    
        LDA.w RoomDrawObjectData+000, Y : STA.l $7E2000, X
                           ORA.w #$4000 : STA.l $7E201A, X
        
        LDA.w RoomDrawObjectData+028, Y : STA.l $7E2002, X : STA.l $7E2004, X
                           EOR.w #$4000 : STA.l $7E2016, X : STA.l $7E2018, X
        
        LDA.w RoomDrawObjectData+056, Y : STA.l $7E2006, X
                           EOR.w #$4000 : STA.l $7E2014, X
        
        LDA.w RoomDrawObjectData+084, Y : STA.l $7E2008, X
                           EOR.w #$4000 : STA.l $7E2012, X
        
        LDA.w RoomDrawObjectData+112, Y : STA.l $7E200A, X
                           EOR.w #$4000 : STA.l $7E2010, X
        
        LDA.w RoomDrawObjectData+140, Y : STA.l $7E200C, X
                           EOR.w #$4000 : STA.l $7E200E, X
        
        TXA : CLC : ADC.w #$0080 : TAX
        
        INY #2
    DEC.b $0E : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $009EA3-$00A094 JUMP LOCATION
Object_AgahnimRoomFrame:
{
    LDA.w #$0006 : STA.b $0E
    
    LDY.w #$1BF2
    
    LDX.b $08
    
    .topEdgeLoop
    
        LDA.w RoomDrawObjectData+00, Y
        STA.l $7E220E, X : STA.l $7E221A, X : STA.l $7E2226, X

        LDA.w RoomDrawObjectData+02, Y
        STA.l $7E228E, X : STA.l $7E229A, X : STA.l $7E22A6, X

        LDA.w RoomDrawObjectData+04, Y
        STA.l $7E230E, X : STA.l $7E231A, X : STA.l $7E2326, X

        LDA.w RoomDrawObjectData+06, Y
        STA.l $7E238E, X : STA.l $7E239A, X : STA.l $7E23A6, X
        
        INY #8
        INX #2
    DEC.b $0E : BNE .topEdgeLoop
    
    LDA.w #$0005 : STA.b $0E
    
    LDY.w #$1C22
    
    LDX.b $08
    
    .diagonalsLoop
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2504, X 
        STA.l $7E2486, X : STA.l $7E2408, X
        STA.l $7E238A, X : STA.l $7E230C, X 
        STA.l $7E228E, X : STA.l $7E2210, X
        
        ORA.w #$4000
        STA.l $7E222E, X : STA.l $7E22B0, X
        STA.l $7E2332, X : STA.l $7E23B4, X
        STA.l $7E2436, X : STA.l $7E24B8, X
        STA.l $7E253A, X
        
        INY #2
        
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .diagonalsLoop
    
    LDA.w #$0006 : STA.b $0E
    
    LDY.w #$1C2C
    
    LDX.b $08
    
    .sidesLoop
    
        LDA.w RoomDrawObjectData+00, Y
        STA.l $7E2584, X : STA.l $7E2884, X : STA.l $7E2B84, X

        ORA.w #$4000
        STA.l $7E25BA, X : STA.l $7E28BA, X : STA.l $7E2BBA, X
        
        LDA.w RoomDrawObjectData+02, Y
        STA.l $7E2586, X : STA.l $7E2886, X : STA.l $7E2B86, X

        ORA.w #$4000
        STA.l $7E25B8, X : STA.l $7E28B8, X : STA.l $7E2BB8, X
        
        LDA.w RoomDrawObjectData+04, Y
        STA.l $7E2588, X : STA.l $7E2888, X : STA.l $7E2B88, X

        ORA.w #$4000
        STA.l $7E25B6, X : STA.l $7E28B6, X : STA.l $7E2BB6, X
        
        LDA.w RoomDrawObjectData+06, Y
        STA.l $7E258A, X : STA.l $7E288A, X : STA.l $7E2B8A, X

        ORA.w #$4000
        STA.l $7E25B4, X : STA.l $7E28B4, X : STA.l $7E2BB4, X
        
        INY #8
        
        TXA : CLC : ADC.w #$0080 : TAX
        
        DEC.b $0E : BEQ .sidesLoopDone
    JMP .sidesLoop
    
    .sidesLoopDone
    
    LDA.w #$0006 : STA.b $0E
    
    LDY.w #$1C5C
    
    LDX.b $08
    
    .horizLightLoop
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2498, X : STA.l $7E24A4, X
        LDA.w RoomDrawObjectData+12, Y : STA.l $7E2518, X : STA.l $7E2524, X
        
        INY #2
        INX #2
    DEC.b $0E : BNE .horizLightLoop
    
    LDA.w #$0006 : STA.b $0E
    
    LDY.w #$1C74
    
    LDX.b $08
    
    .vertLightLoop
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E270E, X : STA.l $7E2A0E, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2710, X : STA.l $7E2A10, X
        
        INY #4
        
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .vertLightLoop
    
    LDA.w #$0005 : STA.b $0E
    
    LDY.w #$1C8C
    
    LDX.b $08
    
    .draw5x5_LightLoop
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E248E, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E250E, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E258E, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E260E, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E268E, X
        
        TYA : CLC : ADC.w #$000A : TAY
        
        INX #2
    DEC.b $0E : BNE .draw5x5_LightLoop
    
    LDA.w #$0004 : STA.b $0E
    
    LDX.b $08
    
    .addPriorityLoop
    
        LDA.l $7E2E1C, X : ORA.w #$2000 : STA.l $7E2E1C, X
        LDA.l $7E2E9C, X : ORA.w #$2000 : STA.l $7E2E9C, X
        
        INX #2
    DEC.b $0E : BNE .addPriorityLoop
    
    RTS
}

; ==============================================================================

; $00A095-$00A193 JUMP LOCATION
Object_FortuneTellerTemplate:
{
    LDA.w #$0006 : STA.b $0E
    
    LDY.w #$202E
    
    LDX.b $08
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y
        STA.l $7E2002, X : STA.l $7E2004, X
        STA.l $7E2082, X : STA.l $7E2084, X
        
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2102, X
        ORA.w #$4000 : STA.l $7E2104, X
        
        INX #4
    DEC.b $0E : BNE .nextColumn
    
    LDA.w #$0003 : STA.b $0E
    
    LDX.b $08
    
    .nextRow
    
        LDA.w RoomDrawObjectData+04, Y
        STA.l $7E2180, X : STA.l $7E2184, X
        STA.l $7E2194, X : STA.l $7E2198, X

        ORA.w #$4000
        STA.l $7E2182, X : STA.l $7E2186, X
        STA.l $7E2196, X : STA.l $7E219A, X
        
        LDA.w RoomDrawObjectData+10, Y
        STA.l $7E2188, X : STA.l $7E218C, X : STA.l $7E2190, X

        ORA.w #$4000
        STA.l $7E218A, X : STA.l $7E218E, X : STA.l $7E2192, X
        
        INY #2
        
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .nextRow
    
    LDX.b $08
    
    LDA.w RoomDrawObjectData+10, Y : STA.l $7E2000, X : STA.l $7E2080, X
    ORA.w #$4000 : STA.l $7E201A, X : STA.l $7E209A, X
    
    LDA.w RoomDrawObjectData+12, Y : STA.l $7E2100, X
    ORA.w #$4000 : STA.l $7E211A, X
    
    LDA.w #$0004 : STA.b $0E
    
    LDY.w #$202E
    
    LDX.b $08
    
    .nextRow2
    
        LDA.w RoomDrawObjectData+20, Y : STA.l $7E2506, X
                          EOR.w #$4000 : STA.l $7E2514, X
        
        LDA.w RoomDrawObjectData+28, Y : STA.l $7E2508, X
                          EOR.w #$4000 : STA.l $7E2512, X
        
        LDA.w RoomDrawObjectData+36, Y : STA.l $7E250A, X
                          EOR.w #$4000 : STA.l $7E2510, X
        
        LDA.w RoomDrawObjectData+44, Y : STA.l $7E250C, X
                          EOR.w #$4000 : STA.l $7E250E, X
        
        INY #2
        
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .nextRow2
    
    RTS
}

; ==============================================================================

; $00A194-$00A1D0 JUMP LOCATION
RoomDraw_Utility3x5:
{
    LDA.w #$0003 : STA.b $0E
    
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
    LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
    
    .nextRow
    
        LDA.w RoomDrawObjectData+06, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+08, X : STA [$CE], Y
        LDA.w RoomDrawObjectData+10, X : STA [$D1], Y
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $0E : BNE .nextRow
    
    LDA.w RoomDrawObjectData+12, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+14, X : STA [$CE], Y
    LDA.w RoomDrawObjectData+16, X : STA [$D1], Y
    
    RTS
}

; ==============================================================================

; $00A1D1-$00A254 JUMP LOCATION
RoomDraw_VitreousGooGraphics:
{
    LDY.w #$20F6
    
    LDX.b $08
    
    ; Draw 11x11 block
    LDA.w #$0016 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4180, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E4200, X
        LDA.w RoomDrawObjectData+10, Y : STA.l $7E4280, X
        LDA.w RoomDrawObjectData+12, Y : STA.l $7E4300, X
        LDA.w RoomDrawObjectData+14, Y : STA.l $7E4380, X
        LDA.w RoomDrawObjectData+16, Y : STA.l $7E4400, X
        LDA.w RoomDrawObjectData+18, Y : STA.l $7E4480, X
        LDA.w RoomDrawObjectData+20, Y : STA.l $7E4500, X
        
        TYA : CLC : ADC.w #$0016 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    LDY.w #$22DA
    
    LDX.b $08
    
    LDA.w #$0003 : STA.b $0E
    
    .nextColumn2
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4592, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4612, X
        
        INY #2
        INX #2
    DEC.b $0E : BNE .nextColumn2
    
    RTS
}

; ==============================================================================

; $00A255-$00A25C JUMP LOCATION
Object_EntireFloorIsPit:
{
    STZ.b $0C
    
    LDX.w #$00E0
    
    JMP.w Dungeon_DrawFloors_nextQuadrant
}

; ==============================================================================

; In-floor in-room up-north staircase (1.2.0x30)
; $00A25D-$00A26C JUMP LOCATION
RoomDraw_AutoStairs_North_MultiLayer_A:
{
    PHX
    
    LDX.w $043C
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2 : STX.w $043C
    
    BRA RoomDraw_AutoStairs_North_MultiLayer_B_drawObject
}

; (1.2.0x31)
; $00A26D-$00A2C0 ALTERNATE ENTRY POINT
RoomDraw_AutoStairs_North_MultiLayer_B:
{
    PHX
    
    LDX.w $043E
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2 : STX.w $043E
    
    .drawObject
    
    STX.w $0446
    STX.w $0448
    
    TYX
    
    PLY
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.l $7E4000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X : STA.l $7E4180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $00A2C1-$00A2C6 BRANCH LOCATION
AutoStairsNorthMergedStart:
{
    STZ.w $0414
    
    LDX.w #$10C8

    ; Bleeds into the next function.
}

; (1.2.0x32) inter-psuedo-bg north staircase
; $00A2C7-$00A2DE ALTERNATE ENTRY POINT
RoomDraw_AutoStairs_North_MergedLayer_A:
{
    PHX
    
    LDX.w $0440
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2
    
    STX.w $0440
    STX.w $0446
    STX.w $0448
    
    PLX
    
    JMP Object_Draw4x4
}

; (1.2.0x33)
; $00A2DF-$00A30B JUMP LOCATION
RoomDraw_AutoStairs_North_MergedLayer_B:
{
    LDA.b $AF : AND.w #$00FF : CMP.w #$001B : BNE .notWaterTwin
        LDA.b $A0 : ASL A : TAX
        
        LDA.l $7EF000, X : AND.w #$0100 : BEQ AutoStairsNorthMergedStart
    
    .notWaterTwin
    
    LDX.w $0442
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2
    
    STX.w $0442
    STX.w $0444
    
    LDX.w #$10C8
    
    JMP Object_Draw4x4
}

; In-room up-south staircase (1.3.0x1B)
; $00A30C-$00A31B JUMP LOCATION
RoomDraw_AutoStairs_South_MultiLayer_A:
{
    PHX
    
    LDX.w $049A
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2 : STX.w $049A
    
    BRA RoomDraw_AutoStairs_South_MultiLayer_B_drawObject
}

; In-room up-north staircase (1.3.0x1C)
; $00A31C-$00A369 JUMP LOCATION
RoomDraw_AutoStairs_South_MultiLayer_B:
{
    PHX
    
    LDX.w $049C
    
    TYA : LSR A : STA.w $06EC, X
    
    INX #2 : STX.w $049C
    
    .drawObject
    
    TYX
    
    PLY
    
    ; Draw a 4x4 tile object
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.l $7E4000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X : STA.l $7E4180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; $00A36A-$00A37F JUMP LOCATION
South_MergedStairs_BecomeMultiC:
{
    STZ.w $0414
    
    PLX

    ; Bleeds into the next function.
}

; In-room up-south staircase (1.3.0x1D)
; $00A36E-$00A37F JUMP LOCATION
RoomDraw_AutoStairs_South_MultiLayer_C:
{
    PHX
    
    LDX.w $049E
    
    TYA : LSR A : STA.w $06EC, X
    
    INX #2 : STX.w $049E
    
    PLX
    
    JMP Object_Draw4x4
}

; In room up-staircase (1.3.0x33)
; $00A380-$00A3AD JUMP LOCATION
RoomDraw_AutoStairs_South_MergedLayer:
{
    PHX
    
    LDA.b $AF : AND.w #$00FF : CMP.w #$001B : BNE .indoors
        LDA.b $A0 : ASL A : TAX
        
        LDA.l $7EF000, X : AND.w #$0100 : BEQ .BRANCH_$A36A
            LDA.w #$6202 : STA.b $99
    
    .indoors
    
    LDX.w $04AE
    
    TYA : LSR A : STA.w $06EC, X
    
    INX #2 : STX.w $04AE
    
    PLX
    
    JMP Object_Draw4x4
}

; 1.2.0x36 Inactive ladders in the swamp palace
; $00A3AE-$00A41A JUMP LOCATION
Object_InactiveWaterLadder:
{
    LDX.w $0446
    
    TYA : LSR A : STA.w $06B8, X
    
    INX #2
    
    STX.w $0446
    STX.w $0448
    
    TYX
    
    LDY.w #$1108
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.l $7E4000, X
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2002, X : STA.l $7E4002, X
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2004, X : STA.l $7E4004, X
    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2006, X : STA.l $7E4006, X
    LDA.w RoomDrawObjectData+08, Y : STA.l $7E2080, X : STA.l $7E4080, X
    LDA.w RoomDrawObjectData+10, Y : STA.l $7E2082, X : STA.l $7E4082, X
    LDA.w RoomDrawObjectData+12, Y : STA.l $7E2084, X : STA.l $7E4084, X
    LDA.w RoomDrawObjectData+14, Y : STA.l $7E2086, X : STA.l $7E4086, X
    
    RTS
}

; 1.2.0x2D In-Floor up-north staircase
; $00A41B-$00A457 JUMP LOCATION
RoomDraw_InterRoomFatStairsUp:
{
    LDX.w $0438
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBg2
    
    INX #2
    
    STX.w $0438 ; In-floor up-north staircase
    STX.w $047E ; Spiral up layer 1
    STX.w $0482 ; Spiral up layer 2
    STX.w $04A2 ; Straight up north
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$1088
    
    JMP Object_Draw4x4
}

; 1.2.0x2E In-floor inter-floor down-south staircase
; $00A458-$00A485 JUMP LOCATION
RoomDraw_InterRoomFatStairsDown_A:
{
    LDX.w $043A
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2
    
    INX #2
    
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$10A8
    
    JMP Object_Draw4x4
}

; 1.2.0x2F In-floor inter-room down-south staircase (use with hidden wall)
; $00A486-$00A4B3 JUMP LOCATION
RoomDraw_InterRoomFatStairsDown_B:
{
    LDX.w $043A
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2
    
    INX #2
    
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$10A8
    
    JMP Object_Draw4x4
}

; 1.2.0x38 Inter-room in-wall up-north spiral staircase
; $00A4B4-$00A4F4 JUMP LOCATION
RoomDraw_SpiralStairsGoingUpUpper:
{
    LDX.w $047E
    
    TYA : SEC : SBC.w #$0080 : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        TYA : SEC : SBC.w #$0080 : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2
    
    INX #2
    
    ; Update number of 38, 39, 3A, 3B objects
    STX.w $047E ; Spiral up layer 1
    STX.w $0482 ; Spiral up layer 2
    STX.w $04A2 ; Straight up north
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2 
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$1148
    
    BRA .drawLayer1Obj
}

; 1.2.0x3A In-wall inter-room up-north spiral staircase (alternate)
; NOTE: this object is not actually used in the original game
; $00A4F5-$00A532 JUMP LOCATION
RoomDraw_SpiralStairsGoingUpLower:
{
    LDX.w $0482
    
    TYA : SEC : SBC.w #$0080 : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2_2
        TYA : SEC : SBC.w #$0080 : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2_2
    
    INX #2
    
    STX.w $0482 ; Spiral up layer 2
    STX.w $04A2 ; Straight up north
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$1178
    
    BRA RoomDraw_SpiralStairsGoingDownLower_drawLayer2Obj
}

; 1.2.0x39 In-wall inter-floor down-north spiral staircase
; $00A533-$00A583 JUMP LOCATION
RoomDraw_SpiralStairsGoingDownUpper:
{
    LDX.w $0480
    
    ; Take the tilemap address and load it into A
    ; $06B0, X = tilemap addr of the object - 1 line (which is 0x80 bytes)
    TYA : SEC : SBC.w #$0080 : LSR A : STA.w $06B0, X
    
    ; Check which BG we're drawing to.
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2_3
        ; We're on BG1 and we need to indicate that to whatever tracks this object
        ; This is the same as the previous write except it would modify it to be on BG0
        TYA : SEC : SBC.w #$0080 : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2_3
    
    INX #2
    
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$1160
    
    ; TODO: Alternate entry point?
    .drawLayer1Obj
    
    LDA.w #$0004
    
    JSR.w Object_Draw3xN
    
    LDX.b $08 : DEX #2
    
    LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
    LDA.l $7E200A, X : ORA.w #$2000 : STA.l $7E200A, X
    
    RTS
}

; 1.2.0x3B In-wall inter-room down-north spiral staircase
; $00A584-$00A5D1 JUMP LOCATION
RoomDraw_SpiralStairsGoingDownLower:
{
    LDX.w $0484
    
    TYA : SEC : SBC.w #$0080 : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2_4
        TYA : SEC : SBC.w #$0080 : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBg2_4
    
    INX #2
    
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    LDX.w #$1190
    
    .drawLayer2Obj
    
    LDA.w #$0004
    
    JSR.w Object_Draw3xN
    
    LDX.b $08
    
    DEX #2
    
    LDA.l $7E4000, X : ORA.w #$2000 : STA.l $7E4000, X
    LDA.l $7E400A, X : ORA.w #$2000 : STA.l $7E400A, X
    
    RTS
}

; 1.3.0x1E Wall up-north staircase. Similar to 1.3.0x26 but only BG2.
; $00A5D2-$00A5F3 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingUpNorthUpper:
{
    PHX
    
    LDX.w $04A2
    
    TYA : LSR A : STA.w $06B0, X
    
    INX #2
    
    STX.w $04A2 ; Straight up north
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    BRA RoomDraw_StraightInterroomStairsUpper
}

; 1.3.0x1F In-wall inter-room down-north straight staircase (BG2 only)
; $00A5F4-$00A606 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingDownNorthUpper:
{
    PHX
    
    LDX.w $04A6
    
    TYA : LSR A : STA.w $06B0, X
    
    INX #2
    
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    BRA RoomDraw_StraightInterroomStairsUpper
}

; 1.3.0x20 Straight up south staircase
; $00A607-$00A625 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingUpSouthUpper:
{
    PHX
    
    LDX.w $04A4
    
    TYA : LSR A : STA.w $06B0, X
    
    INX #2
    
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    BRA RoomDraw_StraightInterroomStairsUpper
}

; 1.3.0x21 Object
; $00A626-$00A633 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingDownSouthUpper:
{
    PHX
    
    LDX.w $04A8
    
    TYA : LSR A : STA.w $06B0, X
    
    INX #2
    
    STX.w $04A8 ; Straight down south

    ; Bleeds into the next function.
}

; $00A634-$00A663 JUMP LOCATION
RoomDraw_StraightInterroomStairsUpper:
{
    TYX
    PLY
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; 1.3.0x26 Wall up-straight-staircase. Similar to 1.3.0x1E, but only BG1
; $00A664-$00A694 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingUpNorthLower:
{
    PHX
    
    LDX.w $04A2
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2
    
    INX #2
    
    STX.w $04A2 ; Straight up north
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    BRA RoomDraw_StraightInterroomStairsLower
}
    
; 1.3.0x27 In-wall inter-room down-north straight staircase (BG1 only)
; $00A695-$00A6B4 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingDownNorthLower:
{
    PHX
    
    LDX.w $04A6
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2_2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2_2
    
    INX #2
    
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south

    ; Bleeds into the next function.
}

; $00A6B5-$00A71B JUMP LOCATION
RoomDraw_StraightInterroomStairsLower:
{
    TYX
    
    PLY
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.l $7E4000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    LDA.b $08 : SEC : SBC.w #$0200
    
    ; $00A6EE ALTERNATE ENTRY POINT
    .increasePriority
    
    TAX
    
    LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
    LDA.l $7E2080, X : ORA.w #$2000 : STA.l $7E2080, X
    LDA.l $7E2100, X : ORA.w #$2000 : STA.l $7E2100, X
    LDA.l $7E2180, X : ORA.w #$2000 : STA.l $7E2180, X
    
    RTS
}

; Straight up south (1.3.0x28)
; $00A71C-$00A749 JUMP LOCATION
RoomDraw_StraightInterroomStairsGoingUpSouthLower:
{
    PHX
    
    LDX.w $04A4
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2
    
    INX #2
    
    STX.w $04A4 ; Straight up south
    STX.w $043A ; In-floor down
    STX.w $0480 ; Spiral down layer 1
    STX.w $0484 ; Spiral down layer 2
    STX.w $04A6 ; Straight down north
    STX.w $04A8 ; Straight down south
    
    BRA RoomDraw_StraightInterroomStairsGoingDownSouthLower_draw
}

; 1.3.0x29 Straight down south staircase (layer2?)
; $00A74A-$00A7A2 ALTERNATE ENTRY POINT
RoomDraw_StraightInterroomStairsGoingDownSouthLower:
{
    PHX
    
    LDX.w $04A8
    
    TYA : LSR A : STA.w $06B0, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2_2
        TYA : ORA.w #$2000 : LSR A : STA.w $06B0, X
    
    .onBG2_2
    
    ; Straight down south
    INX #2 : STX.w $04A8
    
    .draw
    
    TYX
    
    PLY
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X : STA.l $7E4180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    LDA.b $08 : CLC : ADC.w #$0200
    
    JMP.w RoomDraw_StraightInterroomStairsLower_increasePriority
}

; $00A7A3-$00A7B5 JUMP LOCATION
Object_Draw6x3:
{
    LDA.w #$0003
    
    JSR.w Object_Draw3xN
    
    LDA.b $08 : CLC : ADC.w #$0180 : TAY
    
    LDA.w #$0003
    
    JMP Object_Draw3xN
}

; ==============================================================================

; $00A7B6-$00A7D2 JUMP LOCATION
Object_Stacked4x4s:
{
    JSR.w Object_Draw4x4
    
    LDA.b $08 : CLC : ADC.w #$0100 : TAY
    
    LDX.w #$2376
    
    JSR.w Object_Draw4x4
    
    LDA.b $08 : CLC : ADC.w #$0300 : TAY
    
    LDX.w #$2396
    
    JMP Object_Draw4x4
}

; ==============================================================================

; $00A7D3-$00A7EF JUMP LOCATION
Object_BlindLight:
Object_8x8:
{
    ; Specifically, checks the room "Above" Blind's to see if the
    ; floor has been bombed out, which would let in the light that pisses
    ; Blind off and makes him start fighting you. (Or does it show his true
    ; nature / dispel the magic? Don't really know, but who cares?
    LDA.l $7EF0CA : AND.w #$0100 : BEQ .eventNotTriggered
        ; $00A7DC ALTERNATE ENTRY POINT
        .draw
        
        ; Boss entrance doorways + symbol (and Blind light).
        JSR.w Object_Draw4x4
        JSR.w Object_Draw4x4
        
        LDA.b $08 : CLC : ADC.w #$0200 : TAY
        
        JSR.w Object_Draw4x4
        JSR.w Object_Draw4x4
    
    .eventNotTriggered
    
    RTS
}

; ==============================================================================

; $00A7F0-$00A808 JUMP LOCATION
Object_Triforce:
{
    JSR.w Object_Draw4x4
    
    LDA.b $08 : CLC : ADC.w #$01FC : TAY
    
    PHX
    
    JSR.w Object_Draw4x4
    
    PLX
    
    LDA.b $08 : CLC : ADC.w #$0204 : TAY
    
    JMP Object_Draw4x4
}

; ==============================================================================

; $00A809-$00A81B JUMP LOCATION
Object_Draw10x20_With4x4:
{
    LDA.w #$0005
    JSR.w RoomDraw_A_Many32x32Blocks
    
    LDA.b $08 : CLC : ADC.w #$0200 : TAY
    
    LDA.w #$0005
    JMP.w RoomDraw_A_Many32x32Blocks
}

; ==============================================================================

!door_position = $02
!tilemap_pos   = $08

; $00A81C-$00A8F9 JUMP LOCATION
Door_Up:
{
    ; Determine the position for the door from a table
    LDY.w DoorTilemapPositions_NorthWall, X : STY !tilemap_pos
    
    CMP.w #$0030 : BNE .notBlastWall
        JMP Door_BlastWall
    
    .notBlastWall
    
    ; Invisible door...
    CMP.w #$0016 : BNE .notFloorToggleProperty
        TYA : SEC : SBC.w #$00FE
        
        JMP Door_AddFloorToggleProperty
    
    .notFloorToggleProperty
    
    CMP.w #$0032 : BNE .BRANCH_GAMMA
        JMP Door_SwordActivated
    
    .BRANCH_GAMMA
    
    CMP.w #$0006 : BNE .BRANCH_DELTA
        JMP.w RoomDraw_MakeDoorHighPriorityLowerLayer_North
    
    .BRANCH_DELTA
    
    CMP.w #$0014 : BNE .notPalaceToggleProperty
        TYA : SEC : SBC.w #$00FE
        
        JMP Door_AddDungeonToggleProperty
    
    .notPalaceToggleProperty
    
    CMP.w #$0002 : BNE .BRANCH_ZETA
    
    ; Preserve the layer and column the door is on, but snap the
    ; Y coordinate upwards to the nearest quadrant boundary.
    TYA : AND.w #$F07F
    
    JSR.w Door_Prioritize7x4
    JMP.w RoomDraw_NormalRangedDoors_North
    
    .BRANCH_ZETA
    
    CMP.w #$0012 : BNE .notExitDoor
        LDX.w $19E0
        
        TYA : STA.w $19E2, X
        
        INX #2 : STX.w $19E0
        
        RTS
    
    .notExitDoor
    
    CMP.w #$0008 : BNE .BRANCH_IOTA
        JSR.w RoomDraw_NormalRangedDoors_North
        
        BRA .BRANCH_KAPPA
    
    .BRANCH_IOTA
    
    CMP.w #$0020 : BEQ .BRANCH_LAMBDA
    CMP.w #$0022 : BEQ .BRANCH_LAMBDA
    CMP.w #$0024 : BEQ .BRANCH_LAMBDA
        CMP.w #$0026 : BNE RoomDraw_ChangeTilemapAddressToLowerLayer_BRANCH_MU
            .BRANCH_LAMBDA
    
            LDX.w $0460
            
            LDA.w #$0000 : STA.w $19C0, X
            
            TYA : STA.w $19A0, X
            
            ; Store type and position (0000pppp tttttttt)
            TXA : LSR A : XBA : ORA.b $04 : STA.w $1980, X
            
            TXA : AND.w #$000F : TAY
            
            LDA.w DungeonMask, Y
            
            LDY !tilemap_pos
            
            AND.w $068C : BEQ .BRANCH_NU
                INX #2 : STX.w $0460
                
                RTS
            
            .BRANCH_NU
            
            ; TODO: missing label? Or is it supposed to be the one above.
            ; Branch here if it's a locked door and hasn't been unlocked.
            
            LDA.b $04 : CMP.w #$0024 : BCC RoomDraw_NormalRangedDoors_North_BRANCH_RHO
                STX !tilemap_pos
                
                LDX.w $0460
                
                LDA.w #$0000
                
                JSR.w Door_Register
                
                LDA.w DoorGFXDataOffset_North, Y : TAY
                
                LDX !tilemap_pos
                
                LDA.w #$0004 : STA.b $0E
                
                .nextColumn
                
                    ; Apparently some of these doors can only draw to BG1
                    LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X
                    LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X
                    LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X
                    
                    TYA : CLC : ADC.w #$0006 : TAY
                    
                    INX #2
                DEC.b $0E : BNE .nextColumn

    ; Bleeds into the next function.
}

; $00A8FA-$00A90E JUMP LOCATION
RoomDraw_ChangeTilemapAddressToLowerLayer:
{
    LDX.w $0460
    
    LDA.w $199E, X : ORA.w #$2000 : STA.w $199E, X
    
    RTS
    
    .BRANCH_MU
    
    ; Branch on default and type < 0x40
    CMP.w #$0040 : BCC RoomDraw_NormalRangedDoors_North
        JMP.w RoomDraw_HighRangeDoor_North
}
    
; $00A90F-$00A983 JUMP LOCATION
RoomDraw_NormalRangedDoors_North:
{
    ; Check the door's "Pos" or "location"
    ; If pos < 0x0C (6 in HM)
    LDX !door_position : CPX.w #$000C : BCC .BRANCH_RHO
        PHY
        
        LDA.w $0460 : PHA
        
        ORA.w #$0010 : STA.w $0460
        
        LDY.w DoorTilemapPositions_NorthMiddle, X
        
        LDA.b $04
        
        JSR.w RoomDraw_CheckIfLowerLayerDoors_Vertical
        
        PLA : STA.w $0460
        
        PLY
        
        LDA.b $04 : STA.b $0A
    
    .BRANCH_RHO
    
    STY !tilemap_pos
    
    LDX.w $0460
    
    LDA.w #$0000
    
    JSR.w Door_Register : BCC .registrationFailed ; If failed, return
        LDA.w #$0018
        
        CPY.w #$0036 : BEQ .oneSidedTrapDoor
            LDA.w #$0000
            
            CPY.w #$0038 : BNE .notOneSidedTrapDoor
        
        .oneSidedTrapDoor
        
        STA.b $0E
        
        LDA.w $197E, X : AND.w #$00FF : ORA.b $0E : STA.w $197E, X
        
        LDY.b $0E
        
        .notOneSidedTrapDoor
        
        LDX.w DoorGFXDataOffset_North, Y
        
        LDY !tilemap_pos
        
        LDA.w #$0004 : STA.b $0E
        
        .nextColumn2
        
            LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
            LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
            LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
            
            TXA : CLC : ADC.w #$0006 : TAX
            
            INY #2
        DEC.b $0E : BNE .nextColumn2
    
    .registrationFailed
    
    RTS
}

; ==============================================================================

; $00A984-$00AA2E JUMP LOCATION
Door_Down:
{
    ; Get the position of the door
    LDY.w DoorTilemapPositions_SouthMiddle, X : STY.b $08
    
    CMP.w #$0016 : BNE .notFloorToggleProperty
        TYA : CLC : ADC.w #$0202
        
        JMP Door_AddFloorToggleProperty
    
    .notFloorToggleProperty
    
    CMP.w #$0006 : BNE .notPrioritizeProperty
        JMP Door_PrioritizeDownToQuadBoundary
    
    .notPrioritizeProperty
    
    CMP.w #$0014 : BNE .notPalaceToggleProperty
        TYA : CLC : ADC.w #$0202
        
        JMP Door_AddDungeonToggleProperty
    
    .notPalaceToggleProperty
    
    CMP.w #$0012 : BNE .notExitDoor
        LDX.w $19E0
        
        TYA : STA.w $19E2, X
        
        INX #2 : STX.w $19E0
        
        RTS
    
    .notExitDoor
    
    CMP.w #$0040 : BCC .notTopOnBg1Door
        JMP.w RoomDraw_OneSidedLowerShutters_South
    
    .notTopOnBg1Door
    
    ; Large door entrance type
    CMP.w #$000A : BNE .notBg2_LargeExit
        LDX.w $0460
        LDA.w #$0001
        JSR.w Door_Register
        
        LDA.b $08 : SEC : SBC.w #$0206 : STA.b $08
        
        LDY.w #$2656
        LDA.w #$000A
        JMP Object_Draw8xN.draw
    
    .notBg2_LargeExit
    
    ; Other large entrance door type
    CMP.w #$000C : BNE .notBg1_LargeExit
        TYA : ORA.w #$2000 : STA.b $08 : TAY
        
        LDX.w $0460
        LDA.w #$0001
        JSR.w Door_Register
        
        LDA.b $08 : SEC : SBC.w #$0206 : STA.b $08
        
        LDY.w #$2656
        LDA.w #$000A
        JSR.w Object_Draw8xN.draw
        
        LDA.b $08 : SEC : SBC.w #$2080 : TAX
        
        LDY.w #$000A
        
        .prioritizeLineOnBg2
        
            LDA.l $7E4000, X : ORA.w #$2000 : STA.l $7E2000, X
            
            INX #2
        DEY : BNE .prioritizeLineOnBg2
        
        RTS
    
    .notBg1_LargeExit
    
    CMP.w #$000E : BEQ RoomDraw_HighPriorityExitLight_caveExitDoor
        CMP.w #$0010 : BNE RoomDraw_HighPriorityExitLight_notCaveExitDoor

    ; Bleeds into the next function.
}

; $00AA2F-$00AA65 ALTERNATE ENTRY POINT
RoomDraw_HighPriorityExitLight:
{
    TYA : CLC : ADC.w #$0200
    
    JSR.w Door_Prioritize7x4
    
    .caveExitDoor
    
    LDX.w $0460
    LDA.w #$0001
    JSR.w Door_Register
    
    LDY.b $08
    
    LDX.w #$26F6
    LDA.w #$000A
    JMP Object_Draw4x4
    
    .notCaveExitDoor
    
    CMP.w #$0004 : BNE .notOtherCaveExitDoor
        TYA
        
        PLY
        
        ORA.w #$2000 : STA.b $08 : TAY
        
        JSR.w RoomDraw_HighPriorityExitLight
        
        PHA
        
        CLC : ADC.w #$0180 : TAX
        
        LDY.w #$0004
        
        BRA .prioritizeLineOnBg2

    .notOtherCaveExitDoor

    ; Bleeds into the next function.
}

; $00AA66-$00AA7F JUMP LOCATION
RoomDraw_CheckIfLowerLayerDoors_Vertical:
{
    CMP.w #$0002 : BNE .BRANCH_XI
        TYA : CLC : ADC.w #$0200
        
        JSR.w Door_Prioritize7x4
        
        BRA .BRANCH_OMICRON
    
    .BRANCH_XI
    
    CMP.w #$0008 : BNE .notWaterfallDoor
        JSR.w RoomDraw_OneSidedShutters_South
        JMP.w RoomDraw_ChangeTilemapAddressToLowerLayer

    .notWaterfallDoor

    .BRANCH_OMICRON ; Default behavior

    ; Bleeds into the next function.
}

; $00AA80-$00AAD6 JUMP LOCATION
RoomDraw_OneSidedShutters_South:
{
    STY.b $08
    
    LDX.w $0460
    LDA.w #$0001
    JSR.w Door_Register : BCC .BRANCH_PI
        LDA.w #$0000
        
        CPY.w #$001E : BEQ .BRANCH_RHO ; Not big key -> normal door
        CPY.w #$0036 : BEQ .BRANCH_RHO ; Right side only trap door
            LDA.w #$0018
            
            CPY.w #$0038 : BNE .BRANCH_SIGMA ; Left side only trap door
        
        .BRANCH_RHO
        
        STA.b $0E
        
        LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $197E, X
        
        LDY.b $0E
        
        .BRANCH_SIGMA
        
        LDX.w DoorGFXDataOffset_South, Y
        
        LDY.b $08
        
        LDA.w #$0004 : STA.b $0E
        
        .nextColumn
        
            LDA.w RoomDrawObjectData+00, X : STA [$CB], Y
            LDA.w RoomDrawObjectData+02, X : STA [$D7], Y
            LDA.w RoomDrawObjectData+04, X : STA [$DA], Y
            
            TXA : CLC : ADC.w #$0006 : TAX
            
            INY #2
        DEC.b $0E : BNE .nextColumn
    
    .BRANCH_PI
    
    RTS
}

; ==============================================================================

; $00AAD7-$00AB1E JUMP LOCATION
Door_Left:
{
    ; Get the position of the door
    LDY.w DoorTilemapPositions_WestWall, X : STY.b $08
    
    CMP.w #$0016 : BNE .notFloorToggleProperty
        TYA : CLC : ADC.w #$007C
        
        JMP Door_AddFloorToggleProperty
    
    .notFloorToggleProperty
    
    CMP.w #$0006 : BNE .notPrioritizeProperty
        JMP.w RoomDraw_MakeDoorHighPriorityLowerLayer_West
    
    .notPrioritizeProperty
    
    CMP.w #$0014 : BNE .notPalaceToggleProperty
        TYA : CLC : ADC.w #$007C
        
        JMP Door_AddDungeonToggleProperty
    
    .notPalaceToggleProperty
    
    CMP.w #$0002 : BNE .BRANCH_DELTA
        TYA : AND.w #$FFC0
        
        JSR.w Door_Prioritize4x5
        
        BRA .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    CMP.w #$0008 : BNE .BRANCH_ZETA
        JSR.w RoomDraw_NormalRangedDoors_West
        JMP.w RoomDraw_ChangeTilemapAddressToLowerLayer
    
    .BRANCH_ZETA
    
    CMP.w #$0040 : BCC .BRANCH_EPSILON
        JMP.w RoomDraw_HighRangeDoor_West
    
    .BRANCH_EPSILON ; Default behavior
}

; $00AB1F-$00AB77 ALTERNATE ENTRY POINT
RoomDraw_NormalRangedDoors_West:
{
    LDX !door_position : CPX.w #$000C : BCC .BRANCH_THETA
        PHY
        
        LDA.w $0460 : PHA
        
        ORA.w #$0010 : STA.w $0460
        
        LDY.w DoorTilemapPositions_WestMiddle, X
        
        LDA.b $04
        
        JSR.w RoomDraw_NormalRangedDoors_East
        
        PLA : STA.w $0460
        
        PLY
        
        LDA.b $04 : STA.b $0A
    
    .BRANCH_THETA
    
    STY.b $08
    
    LDX.w $0460
    
    LDA.w #$0002
    
    JSR.w Door_Register : BCC RoomDraw_DrawUnreachableDoorSwitcher_BRANCH_KAPPA
    
    LDA.w #$0018
    
    CPY.w #$0036 : BEQ .BRANCH_LAMBDA
        LDA.w #$0000
        
        CPY.w #$0038 : BNE .BRANCH_MU
    
    .BRANCH_LAMBDA
    
    STA.b $0E
    
    LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $179E, X
    
    LDY.b $0E
    
    .BRANCH_MU
    
    LDX.w DoorGFXDataOffset_West, Y
    
    LDY.b $08
    
    LDA.w #$0003 : STA.b $0E

    ; Bleeds into the next function.
}

; $00AB78-$00AB98 JUMP LOCATION
RoomDraw_DrawUnreachableDoorSwitcher:
{
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
        LDA.w RoomDrawObjectData+06, X : STA [$DA], Y
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        INY #2
    DEC.b $0E : BNE .nextRow
    
    .BRANCH_KAPPA
    
    RTS
}

; ==============================================================================

; Draws a door? Eg #$4632
; $00AB99-$00ABC7 JUMP LOCATION
Door_Right:
{
    ; Get the position of the door
    LDY.w DoorTilemapPositions_EastMiddle, X : STY.b $08
    
    CMP.w #$0016 : BNE .notFloorToggleProperty
        TYA : CLC : ADC.w #$0088
        
        JMP Door_AddFloorToggleProperty
    
    .notFloorToggleProperty
    
    CMP.w #$0006 : BNE .BRANCH_KAPPA
        JMP.w RoomDraw_MakeDoorHighPriorityLowerLayer_East
    
    .BRANCH_KAPPA
    
    CMP.w #$0014 : BNE .notPalaceToggleProperty
        TYA : CLC : ADC.w #$0088
        
        JMP Door_AddDungeonToggleProperty
    
    .notPalaceToggleProperty
    
    ; If less than #$0040, branch.
    CMP.w #$0040 : BCC .BRANCH_THETA
        JMP.w RoomDraw_OneSidedLowerShutters_East

    .BRANCH_THETA

    ; Bleeds into the next function.
}

; $00ABC8-$00ABE1 JUMP LOCATION
RoomDraw_NormalRangedDoors_East:
{
    CMP.w #$0002 : BNE .BRANCH_ALPHA
        TYA : CLC : ADC.w #$0008
        
        JSR.w Door_Prioritize4x5
        
        BRA .BRANCH_ALPHA ; OPTIMIZE: Useless branch.
    
    .BRANCH_ALPHA
    
    CMP.w #$0008 : BNE .BRANCH_BETA
        JSR.w RoomDraw_OneSidedShutters_East
        JMP.w RoomDraw_ChangeTilemapAddressToLowerLayer
    
    .BRANCH_BETA

    ; Bleeds into the next function.
}

; $00ABE2-$00AC19 JUMP LOCATION
; Default behavior
RoomDraw_OneSidedShutters_East:
{
    STY.b $08
    
    LDX.w $0460
    
    LDA.w #$0003
    
    JSR.w Door_Register : BCC DrawUnusedDoorSwitchObject_BRANCH_GAMMA
        LDA.w #$0000
        
        CPY.w #$0036 : BEQ .BRANCH_DELTA
            LDA.w #$0018
            
            CPY.w #$0038 : BNE .BRANCH_EPSILON
        
        .BRANCH_DELTA
        
        STA.b $0E
        
        LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $197E, X
        
        LDY.b $0E
        
        .BRANCH_EPSILON
        
        LDX.w DoorGFXDataOffset_East, Y
        
        LDY.b $08 : INY #2
        
        LDA.w #$0003 : STA.b $0E

    ; Bleeds into the next function.
}
    
; $00AC1A-$00AC3A JUMP LOCATION
DrawUnusedDoorSwitchObject:
{
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
        LDA.w RoomDrawObjectData+06, X : STA [$DA], Y
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        INY #2
    DEC.b $0E : BNE .nextColumn
    
    .BRANCH_GAMMA
    
    RTS
}
    
; ==============================================================================

; Agahnim's curtain covered door and vines in Skull Palace.
; $00AC3B-$00AC5A JUMP LOCATION
Door_SwordActivated:
{
    STY.b $08
    
    LDX.w $0460
    LDA.w #$0000
    
    JSR.w Door_Register : BCC .failedRegistration
        LDX.w DoorGFXDataOffset_North, Y
        
        BRA .drawOtherGraphic ; Temp name
    
    .failedRegistration
    
    LDY.b $08
    LDX.w #$078A
    
    JMP Object_Draw4x4
    
    .drawOtherGraphic
    
    LDY.b $08
    
    JSR.w Object_Draw4x4
    
    RTS
}

; ==============================================================================

; $00AC5B-$00AC6F BRANCH LOCATION
Door_UntouchedBlastWall:
{
    LDX.w $0460
    
    STZ.w $19C0, X
    
    TXA : LSR A : XBA : ORA.w #$0030 : STA.w $1980, X
    
    INX #2 : STX.w $0460
    
    RTS
}

; ==============================================================================

; $00AC70-$00ACE3 JUMP LOCATION
Door_BlastWall:
{
    LDY.w ExplodingWallTilemapPosition, X : STY.b $08
    
    LDX.w $0460
    
    LDA.b $08 : CLC : ADC.w #$0014 : STA.w $19A0, X
    
    TXA : LSR A : XBA : ORA.w #$0030 : STA.w $1980, X
    
    TXA : AND.w #$000F : TAY
    LDA.w $068C : AND.w DungeonMask, Y : BEQ Door_UntouchedBlastWall
        ; The "door" (wall, more like it) has been opened, so we draw that
        ; instead.
        SEP #$30
        
        LDX.b #$00
        
        ; Check if "use switch to bomb wall" tag routine is being used.
        LDA.b $AE : CMP.b #$20 : BEQ .disableTag1
            ; Check if "kill enemy to clear level" tag routine is being used.
            CMP.b #$25 : BEQ .disableTag1
                ; Check if "pull lever to bomb wall" tag routine is being used.
                CMP.b #$28 : BEQ .disableTag1
                    INX
        
        .disableTag1
        
        STZ.b $AE, X
        
        REP #$30
        
        LDA.b $08 : PHA
        
        LDA.b $A7 : ORA.w #$0002 : STA.b $A7
        
        LDA.w $0452 : ORA.w #$0100 : STA.w $0452
        
        LDY.w #$0054
        
        LDX.w DoorGFXDataOffset_South, Y
        
        JSR.w RoomDraw_ExplodingWallSegment
        
        PLA : CLC : ADC.w #$0300 : STA.b $08
        
        INC.w $0460 : INC.w $0460
        
        LDA.b $FC : ORA.w #$0200 : STA.b $FC
        
        LDY.w #$0054
        
        LDX.w DoorGFXDataOffset_North, Y

    ; Bleeds into the next function.
}

; $00ACE4-$00AD24 JUMP LOCATION
RoomDraw_ExplodingWallSegment:
{
    LDA.w #$0012 : STA.b $B2
    
    LDY.b $08
    JSR.w RoomDraw_ExplodingWallColumn
    
    LDA.b $08 : CLC : ADC.w #$0004 : STA.b $08
    
    TXA : CLC : ADC.w #$000C : TAX
    
    PHX
    
    TXY
    
    LDX.b $08
    
    ; RoomDrawObjectData+00, Y THAT IS
    LDA.w RoomDrawObjectData+00, Y
    
    .nextColumn
    
        STA.l $7E2000, X : STA.l $7E2080, X
        STA.l $7E2100, X : STA.l $7E2180, X
        STA.l $7E2200, X : STA.l $7E2280, X
        
        INX #2
    DEC.b $B2 : BNE .nextColumn
    
    TXY
    
    PLX
    
    INX #2

    ; Bleeds into the next function.
}

; $00AD25-$00AD40 JUMP LOCATION
RoomDraw_ExplodingWallColumn:
{
    LDA.w #$0006 : STA.b $0A
    
    .nextRow
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+12, X : STA [$C2], Y
        
        INX #2
        
        TYA : CLC : ADC.w #$0080 : TAY
    DEC.b $0A : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $00AD41-$00ADD3 JUMP LOCATION
RoomDraw_HighRangeDoor_North:
{
    LDX.b $02 : CPX.w #$000C : BCC .BRANCH_ALPHA
        LDA.b $04 : CMP.w #$0046 : BEQ .BRANCH_ALPHA
            PHY
            
            LDA.w $0460 : PHA
            
            ORA.w #$0010 : STA.w $0460
            
            LDY.w DoorTilemapPositions_NorthMiddle, X
            
            JSR.w RoomDraw_OneSidedLowerShutters_South
            
            PLA : STA.w $0460
    
    .BRANCH_ALPHA
    
    PLY : STY.b $08
    
    LDX.w $0460
    
    LDA.w #$0000
    
    JSR.w Door_Register
    
    LDA.w #$0044
    
    CPY.w #$0048 : BEQ .BRANCH_BETA
        LDA.w #$0040
        
        CPY.w #$004A : BNE .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    STA.b $0E
    
    LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $197E, X
    
    LDY.b $0E
    
    .BRANCH_GAMMA
    
    LDA.w DoorGFXDataOffset_North, Y : TAY
    
    LDX.b $08
    
    LDA.w #$0004 : STA.b $0E
    
    .BRANCH_DELTA
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4100, X
        
        TYA : CLC : ADC.w #$0006 : TAY
        
        INX #2
    DEC.b $0E : BNE .BRANCH_DELTA
    
    LDA.b $04 : CMP.w #$0046 : BEQ .BRANCH_EPSILON
        LDA.b $08
        
        JSR.w RoomDraw_MakeDoorHighPriority_North
    
    .BRANCH_EPSILON
    
    LDX.w $0460
    
    LDA.w $199E, X : ORA.w #$2000 : STA.w $199E, X
    
    RTS
}

; ==============================================================================

; Y = tilemap address
; $00ADD4-$00AE3F JUMP LOCATION
RoomDraw_OneSidedLowerShutters_South:
{
    STY.b $08
    
    LDX.w $0460
    
    LDA.w #$0001
    
    JSR.w Door_Register
    
    LDA.w #$0040
    
    CPY.w #$0048 : BEQ .oneSidedTrapDoor
        LDA.w #$0044
        
        CPY.w #$004A : BNE .notOneSidedTrapDoor
    
    .oneSidedTrapDoor
    
    STA.b $0E
    
    LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $197E, X
    
    LDY.b $0E
    
    .notOneSidedTrapDoor
    
    LDA.w DoorGFXDataOffset_South, Y : TAY
    
    LDX.b $08
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, X : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+02, X : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+04, X : STA.l $7E2180, X
        
        TYA : CLC : ADC.w #$0006 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    LDA.b #$08 : CLC : ADC.w #$0200
    
    JSR.w Door_PrioritizeDownToQuadBoundary_variable
    
    LDX.w $0460
    
    ; Indicate that the other part of the door is on BG1 rather than BG2.
    LDA.w $199E, X : ORA.w #$2000 : STA.w $199E, X
    
    RTS
}

; ==============================================================================

; $00AE40-$00AEEF JUMP LOCATION
RoomDraw_HighRangeDoor_West:
{
    ; If position < 0x0C
    LDX.b $02 : CPX.w #$000C : BCC .BRANCH_ALPHA
        PHX
        
        LDA.w $0460 : PHA
        
        ORA.w #$0010 : STA.w $0460
        
        LDY.w DoorTilemapPositions_WestMiddle, X
        
        JSR.w RoomDraw_OneSidedLowerShutters_East
        
        PLA : STA.w $0460
        
        PLY
    
    .BRANCH_ALPHA
    
    STY.b $08
    
    LDX.w $0460
    LDA.w #$0002
    JSR.w Door_Register
    
    LDA.w #$0044
    
    CPY.w #$0048 : BEQ .BRANCH_BETA
        LDA.w #$0040
        
        CPY.w #$004A : BNE .BRANCH_GAMMA
    
    .BRANCH_BETA
    
    STA.b $0E
    
    LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $197E, X
    
    LDY.b $0E
    
    .BRANCH_GAMMA
    
    LDA.w DoorGFXDataOffset_West, Y : TAY
    
    LDX.b $08
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
    
    TYA : CLC : ADC.w #$0008 : TAY
    
    INX #2
    
    LDA.w #$0002 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4080, X
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4100, X
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    LDA.b $08
    
    JSR.w RoomDraw_MakeDoorHighPriority_West
    
    LDX.w $0460
    
    LDA.w $199E, X : ORA.w #$2000 : STA.w $199E, X
    
    RTS
}

; ==============================================================================

; $00AEF0-$00AF7E LOCAL JUMP LOCATION
RoomDraw_OneSidedLowerShutters_East:
{
    ; Store the offset into the tile map here.
    STY.b $08
    
    LDX.w $0460
    LDA.w #$0003
    JSR.w Door_Register
    
    LDA.w #$0040
    
    CPY.w #$0048 : BEQ .BRANCH_ALPHA
        LDA.w #$0044
        
        CPY.w #$004A : BNE .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    STA.b $0E
    
    LDA.w $197E, X : AND.w #$FF00 : ORA.b $0E : STA.w $197E, X
    
    LDY.b $0E
    
    .BRANCH_BETA
    
    ; Offset of the start of the tiles, we're going to be writing to the buffer.
    LDA.w DoorGFXDataOffset_East, Y : TAY
    
    LDX.b $08
    
    LDA.w #$0002 : STA.b $0E
    
    .BRANCH_GAMMA
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E4002, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E4082, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E4102, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E4182, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .BRANCH_GAMMA
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2002, X
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2082, X
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2102, X
    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2182, X
    
    LDA.b $08 : CLC : ADC.w #$0008
    
    JSR.w RoomDraw_MakeDoorHighPriority_East
    
    LDX.w $0460
    
    LDA.w $199E, X : ORA.w #$2000 : STA.w $199E, X
    
    RTS
}

; ==============================================================================

; $00AF7F-$00AF8A LOCAL JUMP LOCATION
RoomDraw_MakeDoorHighPriorityLowerLayer_North:
{
    LDA.w #$0000
    JSR.w Door_Register
    
    LDA.b $08 : CLC : ADC.w #$0080

    ; Bleeds into the next function.
}

; $00AF8B-$00AFC7 JUMP LOCATION
RoomDraw_MakeDoorHighPriority_North:
{
    STA.b $02
    
    AND.w #$F07F : TAX
    
    .nextRow
    
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2002, X : ORA.w #$2000 : STA.l $7E2002, X
        LDA.l $7E2004, X : ORA.w #$2000 : STA.l $7E2004, X
        LDA.l $7E2006, X : ORA.w #$2000 : STA.l $7E2006, X
        
        TXA : CLC : ADC.w #$0080 : TAX
    CPX.b $02 : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $00AFC8-$00AFD3 JUMP LOCATION
Door_PrioritizeDownToQuadBoundary:
{
    LDA.w #$0001
    JSR.w Door_Register
    
    LDA.b $08 : CLC : ADC.w #$0100

    ; Bleeds into the next function.
}

; $00AFD4-$00B00C JUMP LOCATION
RoomDraw_MakeDoorHighPriority_South:
{
    .varaible
    
    TAX
    
    .nextRow
    
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2002, X : ORA.w #$2000 : STA.l $7E2002, X
        LDA.l $7E2004, X : ORA.w #$2000 : STA.l $7E2004, X
        LDA.l $7E2006, X : ORA.w #$2000 : STA.l $7E2006, X
        
        TXA : CLC : ADC.w #$0080 : TAX
    AND.w #$0F80 : BNE .nextRow
    
    RTS
}

; ==============================================================================

; $00B00D-$00B016 JUMP LOCATION
RoomDraw_MakeDoorHighPriorityLowerLayer_West:
{
    LDA.w #$0002
    JSR.w Door_Register
    
    LDA.b $08 : INC #2

    ; Bleeds into the next function.
}

; $00B017-$00B04F JUMP LOCATION
RoomDraw_MakeDoorHighPriority_West:
{
    STA.b $02
    
    AND.w #$FFC0 : TAX
    
    ; Add priority to a region of tiles in the tilemap
    .nextColumn
    
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2080, X : ORA.w #$2000 : STA.l $7E2080, X
        LDA.l $7E2100, X : ORA.w #$2000 : STA.l $7E2100, X
        LDA.l $7E2180, X : ORA.w #$2000 : STA.l $7E2180, X
    INX #2 : CPX.b $02 : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $00B050-$00B05B LOCAL JUMP LOCATION
RoomDraw_MakeDoorHighPriorityLowerLayer_East:
{
    LDA.w #$0003
    JSR.w Door_Register
    
    LDA.b $08 : CLC : ADC.w #$0004
}

; $00B05C-$00B091 LOCAL JUMP LOCATION
RoomDraw_MakeDoorHighPriority_East:
{
    TAX
    
    ; Add priority to a region of tiles in the tilemap
    .nextColumn
    
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2080, X : ORA.w #$2000 : STA.l $7E2080, X
        LDA.l $7E2100, X : ORA.w #$2000 : STA.l $7E2100, X
        LDA.l $7E2180, X : ORA.w #$2000 : STA.l $7E2180, X
        
        INX #2
    TXA : AND.w #$003F : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $00B092-$00B09E JUMP LOCATION
Door_AddDungeonToggleProperty:
{
    LDX.w $0450
    
    LSR A : STA.w $06D0, X
    
    INX #2 : STX.w $0450
    
    RTS
}

; ==============================================================================

; $00B09F-$00B0AB JUMP LOCATION
Door_AddFloorToggleProperty:
{
    LDX.w $044E
    
    LSR A : STA.w $06C0, X
    
    INX #2 : STX.w $044E
    
    RTS
}

; ==============================================================================

; Used by objects needing variable width or height ranging from 0x01 to 0x10
; $00B0AC-$00B0AE LOCAL JUMP LOCATION
Object_Size1to16:
{
    LDA.w #$0001
    
    ; Bleeds into the next function.
}
    
; Alternate entry point for objects needing varaible width or height ranging
; from A (register) to (A (register) + 0x0F).
; $00B0AF-$00B0BD LOCAL JUMP LOCATION
Object_Size_N_to_N_plus_15:
{
    STA.b $0E
    
    LDA.b $B2 : ASL #2 : ORA.b $B4 : ADC.b $0E : STA.b $B2
    
    ; Default width of 1?
    STZ.b $B4
    
    RTS
}

; ==============================================================================

; Used by objects needing variable width or height ranging from 0x01 to 0x0F
; or 0x1A as default in the event of both arguments being zero.
; $00B0BE-$00B0CB JUMP LOCATION
Object_Size_1_to_15_or_26:
{
    LDA.b $B2 : ASL #2 : ORA.b $B4 : BNE .notDefault
        LDA.w #$001A
    
    .notDefault
    
    STA.b $B2
    
    RTS
}

; ==============================================================================

; Used by objects needing variable width or height ranging from 0x01 to 0x0F
; or 0x20 as default in the event of both arguments being zero.
; $00B0CC-$00B0D9 LOCAL JUMP LOCATION
Object_Size_1_to_15_or_32:
{
    LDA.b $B2 : ASL #2 : ORA.b $B4 : BNE .notDefault
        LDA.w #$0020
    
    .notDefault
    
    STA.b $B2
    
    RTS
}

; ==============================================================================

; A represents the direction (0 - up, 1 - down, 2, 3 - left, 4 -right)
; X is the index of the next slot to add a door at
; Y is the tilemap address of the door (doesn't differentiate BGs)
    
; Attempts to register a new door object
; Carry is clear on failure
; Carry is set on success (tentative guess)
; $00B0DA-$00B190 LOCAL JUMP LOCATION
Door_Register:
{
    STA.w $19C0, X
    
    ; Store the tilemap address to this array.
    TYA : STA.w $19A0, X
    
    ; High byte is the object's slot in door memory, the low byte its type.
    TXA : LSR A : XBA : ORA.b $04 : STA.w $1980, X
    
    ; If index >= 0x04
    TXA : AND.w #$000F : TAY : CPY.w #$0008 : BCS .BRANCH_ALPHA
        ; Check if door hasn't been opened?
        LDA.w $068C : AND.w DungeonMask, Y : BEQ .BRANCH_ALPHA
            LDA.w $1980, X : AND.w #$00FF : CMP.w #$0018 : BEQ .triggeredTrapDoor
                ; Both 0x18 and 0x44 are trap doors...
                CMP.w #$0044 : BNE .notTrapDoor
                    .triggeredTrapDoor
                    
                    ; Flag set when trap doors are down.
                    LDA.w $0468 : BNE .BRANCH_ALPHA

                .notTrapDoor
                        
                PHX
                        
                LDX.b $04
                        
                LDA.w DoorwayReplacementDoorGFX, X : STA.b $0A
                        
                PLX
                        
                LDA.w $1980, X : AND.w #$00FF
                        
                CMP.w #$0018 : BEQ .BRANCH_ALPHA
                CMP.w #$0044 : BEQ .BRANCH_ALPHA
                CMP.w #$001A : BCC .BRANCH_ALPHA ; Invisible door    
                CMP.w #$0040 : BEQ .BRANCH_ALPHA
                CMP.w #$0046 : BEQ .BRANCH_ALPHA
                    LDA.w $0400 : ORA.w DungeonMask, X : STA.w $0400
    
    .BRANCH_ALPHA
    
    ; Load the door type.
    LDY.b $0A
    
    INX #2 : STX.w $0460
    
    CPY.w #$0032 : BEQ .BRANCH_DELTA ; Sword slash door
    CPY.w #$0008 : BEQ .BRANCH_DELTA ; Waterfall door
        ; Branch away if not a trap door
        LDA.b $04 : CMP.w #$001A : BNE .BRANCH_EPSILON ; Invisible door
            ; TODO: If this is truly for invisible doors, we should be able
            ; to set a breakpoint here and have this never really... fire?
            ; Find out!
            
            ; Check Link's direction.
            LDA.b $2F : AND.w #$00FF : STA.b $0A
            
            DEX #2
            
            TXA : XBA : STA.w $0436
            
            ; Load the direction of the door.
            LDA.b $00 : AND.w #$0003 : ASL A : ORA.w $0436 : STA.w $0436
            
            AND.w #$00FF : CMP.b $0A : BNE .BRANCH_ZETA
                EOR.w #$0002 : CMP.b $0A : BEQ .BRANCH_DELTA
            
            .BRANCH_ZETA
            
            LDA.w $068C : ORA.w DungeonMask, X : STA.w $068C
            
            LDY.w #$0000
        
        .BRANCH_EPSILON
        
        SEC
        
        RTS
    
    .BRANCH_DELTA
    
    CLC
    
    RTS
}

; ==============================================================================

; $00B191-$00B19D LOCAL JUMP LOCATION
RoomDraw_SmallRailCorner:
{
    STA.b $0E
    
    ; .e. goto CLC; RTS
    LDA [$BF], Y : AND.w #$03FF : CMP.b $0E : BEQ Door_Register_BRANCH_DELTA
        SEC
        
        RTS
}

; ==============================================================================

; UNUSED:
; Unreferenced routine (And this doesn't do anything different from
; what Door_Prioritize7x4 would do anyways.
; $00B19E-$00B1A3 LOCAL JUMP LOCATION
Door_Prioritize7x4_Unreferenced:
{
    TAX
    
    LDA.w #$0007
    
    BRA Door_Prioritize7x4_variable
}

; ==============================================================================

; $00B1A4-$00B1E0 LOCAL JUMP LOCATION
Door_Prioritize7x4:
{
    ; Adds priority bit to a 7 row by 4 column region of tiles 
    TAX
    
    LDA.w #$0007
    
    ; $00B1A8 ALTERNATE ENTRY POINT
    .variable
    
    STA.b $0E
    
    .nextRow
    
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2002, X : ORA.w #$2000 : STA.l $7E2002, X
        LDA.l $7E2004, X : ORA.w #$2000 : STA.l $7E2004, X
        LDA.l $7E2006, X : ORA.w #$2000 : STA.l $7E2006, X
        
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .nextRow
    
    RTS
}

; ==============================================================================

; UNUSED:
; $00B1E1-$00B1E6 LOCAL JUMP LOCATION
Door_Prioritize4x7:
{
    TAX
    
    LDA.w #$0007
    
    BRA Door_Prioritize4x5_variable
}

; ==============================================================================

; $00B1E7-$00B21F LOCAL JUMP LOCATION
Door_Prioritize4x5:
{
    ; Adds priority bit to a 4 row by 5 column region of tiles
    TAX
    
    LDA.w #$0005
    
    ; $00B1EB ALTERNATE ENTRY POINT
    .variable
    
    STA.b $0E
    
    .nextColumn
    
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2080, X : ORA.w #$2000 : STA.l $7E2080, X
        LDA.l $7E2100, X : ORA.w #$2000 : STA.l $7E2100, X
        LDA.l $7E2180, X : ORA.w #$2000 : STA.l $7E2180, X
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $00B220-$00B253 JUMP LOCATION
Object_Draw2x4s_VariableOffset:
{
    STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
        LDA.w RoomDrawObjectData+02, X : STA [$C2], Y
        LDA.w RoomDrawObjectData+04, X : STA [$C5], Y
        LDA.w RoomDrawObjectData+06, X : STA [$C8], Y
        LDA.w RoomDrawObjectData+08, X : STA [$CB], Y
        LDA.w RoomDrawObjectData+10, X : STA [$CE], Y
        LDA.w RoomDrawObjectData+12, X : STA [$D1], Y
        LDA.w RoomDrawObjectData+14, X : STA [$D4], Y
        
        TYA : CLC : ADC.w $0E : TAY
    DEC.b $B2 : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; UNUSED:
; $00B254-$00B263 LOCAL JUMP LOCATION
UNREACHABLE_01B254:
{
    STA.b $0E
    
    .next_block
    
        JSR.w Object_Draw2x2_AdvanceDown
        
        TXA : CLC : ADC.w #$0008 : TAX
    DEC.b $0E : BNE .next_block
    
    RTS
}

; ==============================================================================

; UNUSED:
; $00B264-$00B278 LOCAL JUMP LOCATION
UNREACHABLE_01B264:
{
    LDA.b $B2 : BEQ .terminated
        .loop
        
            LDA.w #$0002
            
            JSR.w Object_Draw4xN
            
            TXA : SEC : SBC.w #$0010 : TAX
        DEC.b $B2 : BNE .loop
    
    .terminated
    
    RTS
}

; ==============================================================================

; $00B279-$00B292 LOCAL JUMP LOCATION
Object_Draw5x1:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
    LDA.w RoomDrawObjectData+06, X : STA [$DA], Y
    LDA.w RoomDrawObjectData+08, X : STA [$DD], Y
    
    RTS
}

; ==============================================================================

; $00B293-$00B2A0 LOCAL JUMP LOCATION
RoomDraw_DrawDiagonalGrave:
{
    .loop
    
        JSR.w Object_Draw5x1
        
        TYA : CLC : ADC.w #$0082 : TAY
        
        ; $00B29C ALTERNATE ENTRY POINT
        .start 
    DEC.b $B2 : BNE .loop
    
    RTS
}

; $00B2A1-$00B2AE LOCAL JUMP LOCATION
RoomDraw_DrawDiagonalAcute:
{   
    .loop
    
        JSR.w Object_Draw5x1
        
        TYA : SEC : SBC.w #$007E : TAY
        
        ; $00B2AA ALTERNATE ENTRY POINT
        .start
    DEC.b $B2 : BNE .loop
    
    RTS
}

; ==============================================================================

; $00B2AF-$00B2C9 LOCAL JUMP LOCATION
Object_Draw2x2_AdvanceDown:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+04, X : STA [$C2], Y
    LDA.w RoomDrawObjectData+06, X : STA [$CE], Y
    
    TYA : CLC : ADC.w #$0100 : TAY
    
    RTS
}

; ==============================================================================

; $00B2CA-$00B2CD LOCAL JUMP LOCATION
RoomDraw_Repeated1x1_AdvanceWithCachedCount:
{
    INX #2
    INY #2

    ; Bleeds into the next function.
}

; $00B2CE-$00B2CF LOCAL JUMP LOCATION
RoomDraw_Repeated1x1_CachedCount:
{
    LDA.b $B2

    ; Bleeds into the next function.
}
    
; $00B2D0-$00B2E0 LOCAL JUMP LOCATION
RoomDraw_Repeated1x1:
{
    STA.b $0A
    
    LDA.w RoomDrawObjectData+00, X
    
    .nextColumn
    
        STA [$BF], Y
        
        INY #2
    DEC.b $0A : BNE .nextColumn
    
    ; Addition is going to happen in the return routine.
    ; Funky setup... I know...
    LDA.b $08 : CLC
    
    RTS
}

; ==============================================================================

; $00B2E1-$00B2F5 JUMP LOCATION
Object_Draw4x1:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
    LDA.w RoomDrawObjectData+06, X : STA [$DA], Y
    
    RTS
}

; ==============================================================================

; $00B2F6-$00B305 JUMP LOCATION
Object_Draw3x1:
{
    LDA.w RoomDrawObjectData+00, X : STA [$BF], Y
    LDA.w RoomDrawObjectData+02, X : STA [$CB], Y
    LDA.w RoomDrawObjectData+04, X : STA [$D7], Y
    
    RTS
}

; ==============================================================================

; Strange pot I don't recognize...
; Although the graphics don't display correctly, this
; pot is heavy, as in it needs at least power glove.
; Was dropped from the original game.
; $00B306-$00B30A JUMP LOCATION
RoomDraw_WeirdGloveRequiredPot:
{
    LDA.w #$1010
    
    BRA Object_LargeLiftableBlock_drawQuadrant
}

; ==============================================================================

; Some other liftable object. graphics are messed up.
; $00B30B-$00B30F JUMP LOCATION
RoomDraw_WeirdGloveRequiredPot:
{
    LDA.w #$1212
    
    BRA Object_LargeLiftableBlock_drawQuadrant
}

; ==============================================================================

; Large liftable blocks in dungeons (requires powerglove).
; $00B310-$00B375 JUMP LOCATION
Object_LargeLiftableBlock:
{
    STY.b $08
    
    LDX.w #$0E62
    LDA.w #$2020
    JSR.w .drawQuadrant
    
    LDX.w #$0E6A
    LDA.w #SNES.CGRAMWriteAddr
    JSR.w .drawQuadrant
    
    LDA.b $08 : CLC : ADC.w #$0100 : TAY
    
    LDX.w #$0E72
    LDA.w #$2222
    JSR.w .drawQuadrant
    
    LDX.w #$0E7A
    LDA.w #$2323
    
    .drawQuadrant
    
    PHX
    
    LDX.w $042C
    
    STA.w $0500, X
    
    INC.w $042C : INC.w $042C
    
    LDA.b $BA : STA.w $0520, X
    
    TYA : STA.w $0540, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TYA : ORA.w #$2000 : STA.w $0540, X
    
    .onBg2
    
    LDA [$BF], Y : STA.w $0560, X
    LDA [$CB], Y : STA.w $0580, X
    LDA [$C2], Y : STA.w $05A0, X
    LDA [$CE], Y : STA.w $05C0, X
    
    PLX
    
    JMP Object_Draw2x2
}

; ==============================================================================

; Horizontal row of pots or skulls (doesn't seem to be used though).
; $00B376-$00B380 JUMP LOCATION
RoomDraw_RightwardsPots2x2_1to16:
{
    JSR.w Object_Size1to16
    
    .next_block
    
        JSR.w Object_Pot
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; Vertical row of pots (also seems unused :\)
; $00B381-$00B394 JUMP LOCATION
RoomDraw_DownwardsPots2x2_1to16:
{
    JSR.w Object_Size1to16
    
    .next_block
    
        JSR.w Object_Pot
        
        LDA.b $08 : CLC : ADC.w #$0100 : STA.b $08
        
        TAY
    DEC.b $B2 : BNE .next_block
    
    RTS
}

; ==============================================================================

; Normal pots / skull pots
; $00B395-$00B3E0 JUMP LOCATION
Object_Pot:
{
    PHX
    
    LDX.w $042C
    
    INC.w $042C : INC.w $042C
    
    LDA.w #$1111 : STA.w $0500, X
    
    ; Store this object's position in the object buffer to $0520, X
    LDA.b $BA : STA.w $0520, X
    
    ; Store it's tilemap position.
    TYA : STA.w $0540, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        ; If it's destined for BG0 make a note of that
        TYA : ORA.w #$2000 : STA.w $0540, X
    
    .onBg2
    
    LDA.w #$0D0E : STA.w $0560, X
    LDA.w #$0D1E : STA.w $0580, X
    LDA.w #$4D0E : STA.w $05A0, X
    LDA.w #$4D1E : STA.w $05C0, X
    
    PLX
    
    LDA.l $7EF3CA : BEQ .inLightWorld
        LDX.w #$0E92
    
    .inLightWorld
    
    JMP Object_Draw2x2
}

; ==============================================================================

; Bombable Cracked floor object
; $00B3E1-$00B473 JUMP LOCATION
Object_BombableFloor:
{
    ; Is this dungeon room number 0x65 (special room in Gargoyle's Domain)
    LDA.b $A0 : CMP.w #$0065 : BNE .notInThatOneRoom
        ; If this pit has already been bombed open, don't make it a cracked
        ; floor.
        LDA.w $0402 : AND.w #$1000 : BEQ .notBombedOpenYet
            STZ.b $B2
            STZ.b $B4
            
            ; Tiles for a bombed open floor
            LDX.w #$05AA
            
            JMP Object_Hole

        .notBombedOpenYet
    .notInThatOneRoom
    
    STY.b $08
    
    LDA.w #$05BA : STA.b $0E
    
    LDX.w #$0220
    LDA.w #$3030
    JSR.w .draw2x2
    
    LDX.w #$0228
    LDA.w #$3131
    JSR.w .draw2x2
    
    LDA.b $08 : CLC : ADC.w #$0100 : TAY
    
    LDX.w #$0230
    LDA.w #$3232
    JSR.w .draw2x2
    
    LDX.w #$0238
    LDA.w #$3333
    
    .draw2x2
    
    PHX
    
    LDX.w $042C
    
    ; Store the tile attributes here.
    STA.w $0500, X
    
    ; Index into the next "object" that sets its own tile type
    INC.w $042C : INC.w $042C
    
    ; Save our position in the object stream
    ; (into $0520,X apparently)
    LDA.b $BA : STA.w $0520, X
    
    ; Store the tilemap position of the object
    TYA : STA.w $0540, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBG2
        TYA : ORA.w #$2000 : STA.w $0540, X
    
    .onBG2
    
    PHY
    
    LDY.b $0E
    
    LDA.w RoomDrawObjectData+00, Y : STA.w $0560, X
    LDA.w RoomDrawObjectData+02, Y : STA.w $0580, X
    LDA.w RoomDrawObjectData+04, Y : STA.w $05A0, X
    LDA.w RoomDrawObjectData+06, Y : STA.w $05C0, X
    
    TYA : CLC : ADC.w #$0008 : STA.b $0E
    
    PLY
    PLX
    
    JMP Object_Draw2x2
}

; ==============================================================================

; 1.1.0xBD Horizontal line of moles.
; $00B474-$00B47E JUMP LOCATION
RoomDraw_RightwardsHammerPegs2x2_1to16:
{
    JSR.w Object_Size1to16
    
    .nextMole
    
        JSR.w Object_Mole
    DEC.b $B2 : BNE .nextMole
    
    RTS
}

; ==============================================================================

; 1.1.96 Vertical line of moles.
; $00B47F-$00B492 JUMP LOCATION
RoomDraw_DownwardsHammerPegs2x2_1to16:
{
    JSR.w Object_Size1to16
    
    .nextMole
    
        JSR.w Object_Mole
        
        LDA.b $08 : CLC : ADC.w #$0100 : STA.b $08
        
        TAY
    DEC.b $B2 : BNE .nextMole
    
    RTS
}

; ==============================================================================

; 1.3.0x16 Single Mole
; $00B493-$00B4D5 LOCAL JUMP LOCATION
Object_Mole:
{
    PHX
    
    LDX.w $042C : INC.w $042C : INC.w $042C
    
    ; Once the mole is whacked, these will be the tile attributes for the
    ; replacement tiles
    LDA.w #$4040 : STA.w $0500, X
    
    LDA.b $BA : STA.w $0520, X
    
    TYA : STA.w $0540, X
    
    LDA.b $BF : CMP.w #$4000 : BNE .onBg2
        TYA : ORA.w #$2000 : STA.w $0540, X
    
    .onBg2
    
    ; This will be the appearance of the mole after being whacked (the new CHR)
    LDA.w #$19D8 : STA.w $0560, X
    LDA.w #$19D9 : STA.w $0580, X
    LDA.w #$59D8 : STA.w $05A0, X
    LDA.w #$59D9 : STA.w $05C0, X
    
    PLX
    
    JMP Object_Draw2x2
}

; ==============================================================================

; Moveable block object
; $00B4D6-$00B508 LOCAL JUMP LOCATION
Dungeon_LoadBlock:
{
    LDX.w $042C : INC.w $042C : INC.w $042C
    
    STZ.w $0500, X
    
    LDA.b $BA : STA.w $0520, X
    
    TYA : STA.w $0540, X : AND.w #$3FFF : TAY
    
    ; Store the tilemap entries that were underneath this block before it was
    ; placed on top
    LDA [$BF], Y : STA.w $0560, X
    LDA [$CB], Y : STA.w $0580, X
    LDA [$C2], Y : STA.w $05A0, X
    LDA [$CE], Y : STA.w $05C0, X
    
    LDX.w #$0E52
    
    JMP Object_Draw2x2
}

; ==============================================================================

; Load special lightable torch objects
; $00B509-$00B53B LOCAL JUMP LOCATION
Dungeon_LoadTorch:
{
    ; Store the object's tilemap position
    LDY.w $042E
    
    ; Position in the tilemap of the torch
    STA.w $0540, Y
    
    DEX #2
    
    ; Store the object's position on the object stream.
    TXA : STA.w $0520, Y
    
    INC.w $042E : INC.w $042E
    
    LDX.w #$0EC2
    
    LDA.b $08 : ASL A : BCC .notPermanentlyLit
        ; Permanently lit torch like in Ganon's room? (or in place where your
        ; uncle dies?)
        LDX.w #$0ECA
        
        ; There's a maximum of 3 light levels in a dark room.
        LDA.w $045A : CMP.w #$0003 : BCS .maxLightLevelReached
            INC.w $045A
            
        .maxLightLevelReached
    .notPermanentlyLit
    
    
    STX.b $0C
    
    LDA.b $08 : AND.w #$3FFF : TAY
    
    JMP Object_Draw2x2
}

; ==============================================================================

; $00B53C-$00B55F NULL
NULL_01B53C:
{
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF
}

; ==============================================================================

; $00B560-$00B563 DATA
DungeonHeader_SpecialAdjustment:
{
    ; First value is for entering a room facing, right, the second
    ; is for entering a room facing left. This might actually
    ; be for intraroom transitions, but I'm not sure yet.
    ; This might not even be used in actual gameplay ever...
    dw 256, -256
}

; ==============================================================================

; $00B564-$00B758 LOCAL JUMP LOCATION
Dungeon_LoadHeader:
{
    STZ.w $0642
    STZ.w $0646
    STZ.w $0641
    
    REP #$30
    
    ; Load submodule index
    LDA.b $11 : AND.w #$00FF : BNE .nonDefaultSubmodule
        ; BG1 horizontal scroll register.
        LDA.b $E2 : AND.w #$FE00 : STA.w $062C
        
        ; BG1 vertical scroll register.
        LDA.b $E8
        
        BRA .setLowerBoundY
    
    .nonDefaultSubmodule
    
    CMP.w #$0015 : BEQ .specialAdjustX
        CMP.w #$0012 : BCS .noSpecialAdjustX
        CMP.w #$0006 : BCC .noSpecialAdjustX
            .specialAdjustX
            
            ; Submodules 0x06 - 0x11 and 0x15 have this adjustment.
            LDA.b $E2 : CLC : ADC.w #$0020
            
            BRA .setLowerBoundX
    
    .noSpecialAdjustX
    
    LDA.b $67 : AND.w #$000F : LSR A : CMP.w #$0002 : BCS .walkingUpOrDown
        ASL A : TAX
        
        LDA.b $E2 : CLC : ADC.l DungeonHeader_SpecialAdjustment, X
        
        .setLowerBoundX
        
        AND.w #$FE00 : STA.w $062C
        
        LDA.b $E8 : CLC : ADC.w #$0020
        
        BRA .setLowerBoundY
    
    .walkingUpOrDown
    
    LSR #3 : TAX
    
    LDA.b $E2 : CLC : ADC.w #$0020 : AND.w #$FE00 : STA.w $062C
    
    LDA.b $E8 : CLC : ADC.l DungeonHeader_SpecialAdjustment, X
    
    .setLowerBoundY
    
    AND.w #$FE00 : STA.w $062E
    
    ; Load the dungeon room offset.
    LDA.b $A0 : ASL A : TAX
    
    ; Get the offset for the base header information    
    LDA.l RoomHeader_RoomToPointer, X : STA.b $0D
    
    SEP #$20
    REP #$10
    
    ; $0D = $04XXXX. I.e. $0F contains the bank number.
    LDA.b #$04 : STA.b $0F
    
    ; TODO: Save whatever this value is...
    LDA.w $0414 : STA.l $7EC208
    
    LDY.w #$0000
    
    ; Load the 0th (first) byte of the header.
    ; "BG2" in HM. TODO: Change to ZS.
    LDA [$0D], Y : AND.b #$E0 : ASL A : ROL #3 : STA.w $0414
    
    ; TODO: ZS-ify.
    ; "collision" in HM
    LDA [$0D], Y : AND.b #$1C : LSR #2 : STA.w $046C
    
    ; Save whether to turn the lights out or not.
    LDA.l $7EC005 : STA.l $7EC006
    
    LDA [$0D], Y : AND.b #$01 : STA.l $7EC005
    
    REP #$20
    
    ; Move to byte 1. Loads a master palette number
    INY : LDA [$0D], Y : AND.w #$00FF : ASL #2 : TAX
    
    SEP #$20
    
    ; Load Palette indices
    LDA.l UnderworldPaletteSets+0, X : STA.w $0AB6  ; BG Palette index
    LDA.l UnderworldPaletteSets+1, X : STA.w $0AAC  ; SP index 0
    LDA.l UnderworldPaletteSets+2, X : STA.w $0AAD  ; SP index 1
    LDA.l UnderworldPaletteSets+3, X : STA.w $0AAE  ; SP index 2
    
    ; Move to byte 2. (Sprite graphics index)
    INY : LDA [$0D], Y : STA.w $0AA2
    
    ; Move to byte 3. (BG graphics index)
    INY : LDA [$0D], Y : CLC : ADC.b #$40 : STA.w $0AA3
    
    ; Move to byte 4. Basically sets uh.... moving floor settings.
    INY : LDA [$0D], Y : STA.b $AD
    
    ; Move to byte 5. Corresponds to Tag1 in Hyrule Magic.
    INY : LDA [$0D], Y : STA.b $AE
    
    ; Move to byte 6. Corresponds to Tag2 in Hyrule Magic
    INY : LDA [$0D], Y : STA.b $AF
    
    ; Move to byte 7.
    INY
    
    ; Teleporter plane
    LDA [$0D], Y : AND.w #$03 : STA.w $063C
    
    ; Staircase 1 plane
    LDA [$0D], Y : AND.b #$0C : LSR #2 : STA.w $063D
    
    ; Staircase 2 plane
    LDA [$0D], Y : AND.b #$30 : LSR #4 : STA.w $063E
    
    ; Staircase 3 / Door plane
    LDA [$0D], Y : AND.b #$C0 : ASL A : ROL A : ROL A : STA.w $063F
    
    ; Move to byte 8. (Staircase 4 / Door plane)
    INY : LDA [$0D], Y : AND.b #$03 : STA.w $0640
    
    ; Move to byte 9 (Teleporter room)
    INY : LDA [$0D], Y : STA.l $7EC000
    
    ; Move to byte A (Staircase 1 room)
    INY : LDA [$0D], Y : STA.l $7EC001
    
    ; Move to byte B (Staircase 2 room)
    INY : LDA [$0D], Y : STA.l $7EC002
    
    ; Move to byte C (Staircase 3 / Door room)
    INY : LDA [$0D], Y : STA.l $7EC003
    
    ; Move to byte D (Staircase 4 / Door room)
    INY : LDA [$0D], Y : STA.l $7EC004
    
    ; We're done with the header after reading out 14 (0x0E) bytes.
    
    REP #$30
    
    ; Put trap doors down initially.
    LDA.w #$0001 : STA.w $0468
    
    ; Initialize dungeon overlay variable to default
    STZ.w $04BA
    
    ; X = $0110 = ($A0 * 3)
    LDA.b $A0 : ASL A : CLC : ADC.b $A0 : STA.w $0110 : TAX
    
    LDA.l RoomData_DoorDataPointers+1, X : STA.b $B8
    LDA.l RoomData_DoorDataPointers+0, X : STA.b $B7
    
    LDA.b $A0 : ASL A : TAX
    
    ; Access the dungeon room's saved data (1 word)
    LDA.l $7EF000, X : AND.w #$F000 : STA.w $0400
    
    ORA.w #$0F00 : STA.w $068C
    
    LDA.l $7EF000, X : AND.w #$0FF0 : ASL #4 : STA.w $0402
    
    LDA.l $7EF000, X : AND.w #$000F : STA.w $0408
    
    ; ...Okay, done loading save game data.
    
    LDX.w #$0000 : TXY
    
    .nextDoor
    
    STZ.w $19A0, X
    
    ; Load Door object information.
    LDA [$B7], Y : CMP.w #$FFFF : BEQ .nullDoor
        ; Write to this array until we hit a 0xFFFF value.
        STA.w $19A0, X
        
        INY #2
        INX #2
        
        BRA .nextDoor
    
    .nullDoor
    
    LDA.b $A0 : DEC A : TAX
    
    ; Checks to see if the room is a multiple of 0x10
    ; Room is a multiple of $10
    AND.w #$000F : CMP.w #$000F : BEQ .divisible_by_16
        ; All others
        LDA.w #$0024
        
        JSR.w Dungeon_CheckAdjacentRoomOpenedDoors
    
    .divisible_by_16
    
    LDA.b $A0 : INC A : TAX
    
    ; Checks to see if the room is right before a room that's a multiple of
    ; 0x10. I.e. ends in 0xF
    AND.w #$000F : BEQ .endsInF
        ; All others
        LDA.w #$0018
        
        JSR.w Dungeon_CheckAdjacentRoomOpenedDoors
    
    .endsInF
    
    ; Checks to see if it's one of the first $F rooms
    LDA.b $A0 : SEC : SBC.w #$0010 : TAX : BMI .first_F_rooms
        LDA.w #$000C
        
        JSR.w Dungeon_CheckAdjacentRoomOpenedDoors
    
    .first_F_rooms
    
    LDA.b $A0 : CLC : ADC.w #$0010 : TAX
    
    ; If room is one of the last $F rooms
    CMP.w #$0140 : BCS .last_F_rooms
        LDA.w #$0000
        
        JSR.w Dungeon_CheckAdjacentRoomOpenedDoors
    
    .last_F_rooms
    
    SEP #$20
    
    .return
    
    RTS
}

; ==============================================================================

; $00B759-$00B7EE LOCAL JUMP LOCATION
Dungeon_CheckAdjacentRoomOpenedDoors:
{
    ; ARGUMENTS: A -> $04 and X -> $0E
    STA.b $04
    
    JSR.w Dungeon_LoadAdjacentRoomDoors
    
    LDY.w #$0000
    
    .nextDoor
    
    LDA.w $1110, Y : CMP.w #$FFFF : BEQ Dungeon_LoadHeader_return
        STA.b $02
        
        LDX.b $04
        
        AND.w #$00FF
        
                 CMP.w RoomDraw_DoorPartnerSelfLocation, X : BEQ .matchPosition
        INX #2 : CMP.w RoomDraw_DoorPartnerSelfLocation, X : BEQ .matchPosition
        INX #2 : CMP.w RoomDraw_DoorPartnerSelfLocation, X : BEQ .matchPosition
        INX #2 : CMP.w RoomDraw_DoorPartnerSelfLocation, X : BEQ .matchPosition
        INX #2 : CMP.w RoomDraw_DoorPartnerSelfLocation, X : BEQ .matchPosition
            INX #2 : CMP.w RoomDraw_DoorPartnerSelfLocation, X : BNE .skipDoor
                .matchPosition
        
                LDA.w RoomDraw_DoorPartnerLocation, X : STA.b $00
                
                LDX.w #$0000
                
                .tryNextDoor
                
                    ; Check out the door's position (direction, orientation, and
                    ; two unused bits.)
                    LDA.w $19A0, X : AND.w #$00FF : CMP.b $00 : BEQ .match
                INX #2 : CPX.w #$0010 : BNE .tryNextDoor
                
                BRA .skipDoor
                
                .match
                
                LDA.w $19A0, X : AND.w #$FF00
                
                CMP.w #$3000 : BEQ .skipDoor
                    CMP.w #$4400 : BEQ .trapDoor
                        CMP.w #$1800 : BNE .notTrapDoor
                            .trapDoor
                
                            LDA.b $0E : CMP.b $A2 : BNE .skipDoor
                            
                            STZ.w $0468
                            
                            BRA .openDoor
                            
                        .notTrapDoor
                
                        LDA.w $1100 : AND.w DungeonMask, Y : BEQ .skipDoor
                            .openDoor
                            
                            ; Open a door in this room because of a correspondin
                            ; open door in an adjacent room.
                            LDA.w $068C : ORA.w DungeonMask, X : STA.w $068C
        
        .skipDoor
        
        INY #2 : CPY.w #$0010 : BEQ .return
            JMP .nextDoor
        
        .return
        
        RTS
}

; ==============================================================================

; $00B7EF-$00B83D LOCAL JUMP LOCATION
Dungeon_LoadAdjacentRoomDoors:
{
    STX.b $0E
    
    ; X = the other room's index multiplied by 3.
    TXA : ASL A : CLC : ADC.b $0E : TAX
    
    LDA.l RoomData_DoorDataPointers+1, X : STA.b $B8
    LDA.l RoomData_DoorDataPointers+0, X : STA.b $B7
    
    LDA.b $0E : ASL A : TAX
    
    ; Obtain the door data for the given room.
    LDA.l $7EF000, X : AND.w #$F000 : ORA.w #$0F00 : STA.w $1100
    
    LDX.w #$0000 : TXY
    
    .nextDoor
    
    ; Loop until we see the terminator word (0xFFFF).
    LDA [$B7], Y : STA.w $1110, X
    CMP.w #$FFFF : BEQ Dungeon_CheckAdjacentRoomOpenedDoors_return
        ; Check to see if the 0x4000 bit is set.
        AND.w #$FF00
        
        ; Checks to see if it's a 2.32 object (that type of door, i mean).
        CMP.w #$4000 : BEQ .beta
            CMP.w #$0200 : BCS .notDefaultDoor
                .beta
                
                ; Or in a bit that corresponds to the door's position in the
                ; buffer (0x8000, 0x4000, 0x2000, etc...)
                LDA.w $1100 : ORA.w DungeonMask, X : STA.w $1100
        
        .notDefaultDoor
        
        INY #2
        INX #2
        
        BRA .nextDoor
}

; ==============================================================================

; $00B83E-$00B8A7 LONG JUMP LOCATION
Dungeon_ApplyOverlay:
{
    REP #$30
    
    LDA.b $BA : BNE .preloaded_pointer
        STZ.w $045E
        
        ; X = $04BA * 3.
        LDA.w $04BA : ASL A : CLC : ADC.w $04BA : TAX
        
        ; Dungeon overlay data
        LDA.l .ptr_table + 1, X : STA.b $B8
        LDA.l .ptr_table + 0, X : STA.b $B7
        
        JSR.w Dungeon_DrawOverlay
        
        REP #$30
        
        STZ.b $BA
        STZ.w $045E
    
    .preloaded_pointer
    
    STZ.b $0C
    
    .next_object
    
    LDY.b $BA
    
    LDA [$B7], Y : CMP.w #$FFFF : BEQ .end_of_data
        STA.b $00
        
        SEP #$20
        
        LDA [$B7], Y : AND.b #$FC : STA.b $08
        
        INY #2
        
        LDA.b $01 : LSR #3 : ROR.b $08 : STA.b $09
        
        INY : STY.b $BA
        
        REP #$20
        
        LDA.b $08
        
        PHA
        
        JSR.w Dungeon_PrepOverlayDma_nextPrep
        
        PLA
        
        JSR.w Dungeon_ApplyOverlayAttr
        
        BRA .next_object
    
    .end_of_data
    
    LDY.b $0C
    
    LDA.w #$FFFF : STA.w $1100, Y
    
    SEP #$30
    
    ; Set a graphics flag.
    LDA.b #$01 : STA.b $18
    
    STZ.b $11
    
    RTL
}

; ==============================================================================

; $00B8A8-$00B8B3 Jump Table
Dungeon_LoadAttrSelectable_jumpTable:
{
    dw Dungeon_LoadBasicAttr         ; 0x00 - $B8E3
    dw Dungeon_LoadBasicAttr_partial ; 0x01 - $B8EC Load the tile attributes differently?
    dw Dungeon_LoadObjAttr           ; 0x02 - $B967
    dw Dungeon_LoadDoorAttr          ; 0x03 - $BE17
    dw Dungeon_InitBarrierAttr       ; 0x04 - $C21C
    dw Dungeon_LoadBasicAttr_easyOut ; 0x05 - $B966
}

; $00B8B4-$00B8BE LONG JUMP LOCATION
Dungeon_LoadAttrSelectable:
{
    LDA.w $0200 : ASL A : TAX
    
    JSR.w (.jumpTable, X)
    
    SEP #$30
    
    RTL
}

; ==============================================================================

!numTiles      = $00
!leftTileAttr  = $02
!rightTileAttr = $04
!tileOffset    = $B2
!attrOffset    = $B4

; $00B8BF-$00B8E2 LONG JUMP LOCATION
Dungeon_LoadAttrTable:
{
    REP #$20
    
    STZ !tileOffset
    STZ !attrOffset
    
    LDA.w #$1000 : STA !numTiles
    
    JSR.w Dungeon_LoadBasicAttr_full
    
    SEP #$30
    
    JSR.w Dungeon_LoadObjAttr
    JSR.w Dungeon_LoadDoorAttr
    
    LDA.l $7EC172 : BEQ .dontFlipBarrierAttr
        JSL.l Dungeon_ToggleBarrierAttr
    
    .dontFlipBarrierAttr
    
    STZ.w $0200
    
    RTL
}

; ==============================================================================

; Notes about this routine:
; $04 is the behavior type of the tile just to the right of the current tile
; $02 is the behavior type of the current tile
; $00B8E3-$00B966 JUMP LOCATION
Dungeon_LoadBasicAttr:
{
    .transition
    
    REP #$20
    
    INC.w $0200
    
    ; These are counters that are initialized
    STZ !tileOffset
    STZ !attrOffset
    
    ; $00B8EC ALTERNATE ENTRY POINT
    .partial
    
    REP #$20
    
    LDA.w #$0040 : STA !numTiles
    
    ; $00B8F3 ALTERNATE ENTRY POINT
    .full
    
    ; Switch to bank $7E which is really just WRAM.
    PHB : LDX.w #$7E : PHX : PLB
    
    REP #$10
    
    .nextTilePair
    
        LDX !tileOffset
        
        ; Load a tile's properties from the tile's character value.
        LDA.l $7E2002, X : AND.w #$03FF : TAY
        
        ; Obtains a the behavior associated with this graphical tile.
        ; e.g. chests have a behavior associated with their tile type.
        LDA.w $FE00, Y : STA !rightTileAttr
        
        ; Y = CHR value
        LDA.l $7E2000, X : AND.w #$03FF : TAY
        
        SEP #$20
        
        ; If tile type < 0x10
        LDA.w $FE00, Y : CMP.b #$10 : BCC .tileIgnoresFlip
            ; If tyle type >= 0x1C
            CMP.b #$1C : BCS .tileIgnoresFlip
                ; Tile types >= $10 and < $1C pay attention to
                ; v and hflip properties.
                LDA.l $7E2001, X : ASL A : ROL A : ROL A
                AND.b #$03 : ORA.w $FE00, Y
        
        .tileIgnoresFlip
        
        STA !leftTileAttr
        
        ; Same as for the current tile, look at hFlip/vFlip ...
        LDA !tileAttr
        
        CMP.b #$10 : BCC .tileIgnoresFlip2
        CMP.b #$1C : BCS .tileIgnoresFlip2
            LDA.l $7E2003, X : ASL A : ROL #2 : AND.w #$03 : ORA !rightTileAttr
        
        .tileIgnoresFlip2
        
        XBA
        
        ; Load the tile behavior for the left
        LDA !leftTileAttr
        
        REP #$21
        
        ; Store the tile attributes for the current two tiles
        LDX !attrOffset : STA.l $7F2000, X : INX #2 : STX !attrOffset
        
        LDA !tileOffset : ADC.w #$0004 : STA !tileOffset
    DEC !numTiles : BNE .nextTilePair
    
    ; If we've reached the end of the tile attribute table we're done.
    LDA !attrOffset : CMP.w #$2000 : BNE .notEndOfTable
        INC.w $0200
    
    .notEndOfTable
    
    PLB ; Restore the bank.
    
    ; $00B966 ALTERNATE ENTRY POINT
    .easyOut
    
    RTS
}

; ==============================================================================

; $00B967-$00BDDA LOCAL JUMP LOCATION
Dungeon_LoadObjAttr:
{
    REP #$30
    
    ; Tell me how many stars there are
    LDX.w $0432 : BEQ .noStars
        LDY.w #$0000
        LDA.w #$3B3B
        
        .nextStar
        
            ; Place 0x3B tiles attributes in a square matching the position of
            ; the star.
            LDX.w $06A0, Y
            
            STA.l $7F2000, X : STA.l $7F2040, X
        INY #2 : CPY.w $0432 : BNE .nextStar
    
    .noStars
    
    LDA.w #$3030 : STA.b $00
    
    LDY.w #$0000
    
    ; Check the number of in-floor inter-room up-north staircases.
    LDX.w $0438 : BEQ .noInRoomUpStaircases
        .nextInRoomUpStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$0000 : STA.l $7F2081, X
            LDA.w #$2626 : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X
            CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $0438 : BNE .nextInRoomUpStaircase
    
    .noInRoomUpStaircases
    
    ; Number of 1.2.0x38 objects.
    CPY.w $047E : BEQ .noSpiralUpStaircases
        .nextSpiralUpStaircases
        
            LDX.w $06B0, Y
            
            LDA.w #$5E5E
            STA.l $7F2001, X : STA.l $7F2081, X : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2041, X
            
            CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $047E : BNE .nextSpiralUpStaircases
    
    .noSpiralUpStaircases
    
    ; Number of 1.2.0x3A objects.
    CPY.w $0482 : BEQ .noSpiralUpStaircases2
        .nextSpiralUpStaircase2
        
            LDX.w $06B0, Y
            
            LDA.w #$5F5F
            STA.l $7F2001, X : STA.l $7F2081, X : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $0482 : BNE .nextSpiralUpStaircase2
    
    .noSpiralUpStaircases2
    
    ; Number of 1.3.0x1E and 1.3.0x26 objects.
    CPY.w $04A2 : BEQ .noStraightUpStaircases
        .nextStraightUpStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$0000 : STA.l $7F2081, X : STA.l $7F20C1, X
            LDA.w #$3838 : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $04A2 : BNE .nextStraightUpStaircase
    
    .noStraightUpStaircases   
    
    ; Number of 1.3.0x20 and 1.3.0x28 objects.
    CPY.w $04A4 : BEQ .noStraightUpSouthStaircases
        .nextStraightUpSouthStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$0000 : STA.l $7F2001, X : STA.l $7F2041, X
            
            LDA.w #$3939 : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2081, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $04A4 : BNE .nextStraightUpSouthStaircase
    
    .noStraightUpSouthStaircases
    
    LDA.b $00 : AND.w #$0707 : ORA.w #$3434 : STA.b $00
    
    ; Number of 1.2.0x2E and 1.2.0x2F objects
    CPY.w $043A : BEQ .noInRoomDownSouthStaircases
        .nextInRoomDownSouthStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$2626 : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2081, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $043A : BNE .nextInRoomDownSouthStaircase
    
    .noInRoomDownSouthStaircases
    
    ; Number of 1.2.0x39 objects
    CPY.w $0480 : BEQ .noSpiralDownNorthStaircases
        .nextSpiralDownNorthStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$5E5E
            STA.l $7F2001, X : STA.l $7F2081, X : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $0480 : BNE .nextSpiralDownNorthStaircase
    
    .noSpiralDownNorthStaircases
    
    ; Number of 1.2.0x3B objects
    CPY.w $0484 : BEQ .noSpiralDownNorthStaircases2
        .nextSpiralDownNorthStaircase2
        
            LDX.w $06B0, Y
            
            LDA.w #$5F5F
            STA.l $7F2001, X : STA.l $7F2081, X : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $0484 : BNE .nextSpiralDownNorthStaircase2
        
    .noSpiralDownNorthStaircases2
    
    ; Number of 1.3.0x1F and 1.3.0x27 objects.
    CPY.w $04A6 : BEQ .noStraightDownNorthStaircases
        .nextStraightDownNorthStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$0000 : STA.l $7F2081, X : STA.l $7F20C1, X
            
            LDA.w #$3838 : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $04A6 : BNE .nextStraightDownNorthStaircase
    
    .noStraightDownNorthStaircases
    
    ; Number of 1.3.0x21 and 1.3.0x29 objects.
    CPY.w $04A8 : BEQ .noStraightDownSouthStaircases
        .nextStraightDownSouthStaircase
        
            LDX.w $06B0, Y
            
            LDA.w #$0000 : STA.l $7F2001, X : STA.l $7F2041, X
            
            LDA.w #$3939 : STA.l $7F20C1, X
            
            LDA.b $00 : STA.l $7F2081, X : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $04A8 : BNE .nextStraightDownSouthStaircase
    
    .noStraightDownSouthStaircases
    
    ; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    ; End of staircases? No, the pain is just beginning.
    LDY.w #$0000 : STY.b $02
    
    LDA.w #$1F1F
    
    LDX.w $043C : BNE .optimus
        INC.b $02
        
        LDA.w #$1E1E
        
        LDX.w $043E : BNE .optimus
            LDX.w $0440 : BEQ .ultima
                INC.b $02
                
                LDA.w #$1D1D
    
    .optimus
    
    STA.b $00
    
    LDA.b $02 : STA.w $044A
    
    STX.b $02
    
    .aleph
    
        LDX.w $06B8, Y
        
        LDA.w #$0002 : STA.l $7F2000, X : STA.l $7F30C0, X
        XBA          : STA.l $7F2002, X : STA.l $7F32C2, X
        
        LDA.w #$0001 : STA.l $7F2040, X : STA.l $7F3080, X
        XBA          : STA.l $7F2042, X : STA.l $7F3082, X
        
        LDA.b $00    : STA.l $7F2041, X : STA.l $7F3041, X 
                       STA.l $7F2081, X : STA.l $7F3081, X
    INY #2 : CPY.b $02 : BNE .aleph
    
    .ultima
    
    CPY.w $0448 : BEQ .bet
        LDA.w #$0002 : STA.w $044A
        
        .gimmel
        
            LDX.w $06B8, Y
            
            LDA.w #$0A03 : STA.l $7F2000, X : STA.l $7F3000, X
            
            XBA          : STA.l $7F2002, X : STA.l $7F3002, X
            
            LDA.w #$0803 : STA.l $7F2040, X
            
            XBA : STA.l $7F2042, X
        INY #2 : CPY.w $0448 : BNE .gimmel
    
    .bet
    
    LDY.w #$0000
    
    LDX.w $0442 : BEQ .dalet
        LDA.w #$0002 : STA.w $044A
        
        .hey
        
            LDX.w $06B8, Y
            
            LDA.w #$0003 : STA.l $7F2000, X
            XBA          : STA.l $7F2002, X
            
            LDA.w #$0A03 : STA.l $7F3000, X
            XBA          : STA.l $7F3002, X
            
            LDA.w #$0808 : STA.l $7F2040, X : STA.l $7F2042, X
        INY #2 : CPY.w $0442 : BNE .hey
    
    .dalet
    
    CPY.w $0444 : BEQ .noActiveWaterLadders
        LDA.w #$0002 : STA.w $044A
        
        .nextActiveWaterLadder
        
            LDX.w $06B8, Y
            
            LDA.w #$0003 : STA.l $7F2000, X : XBA : STA.l $7F2002, X
            LDA.w #$0A03 : STA.l $7F3000, X : XBA : STA.l $7F3002, X 
        INY #2 : CPY.w $0444 : BNE .nextActiveWaterLadder
    
    .noActiveWaterLadders
    
    LDY.w #$0000
    
    ; No misc objects
    LDX.w $042C : BEQ .chet
        LDA.w #$7070 : STA.b $00
        
        .nextMiscObject
        
            ; Check the replacement tile attributes
            ; If attribute & 0xF0 == 0x30, skip
            LDA.w $0500, Y : AND.w #$00F0 : CMP.w #$0030 : BEQ .skipMiscObject
                ; Check the tilemap address
                LDA.w $0540, Y : AND.w #$3FFF : LSR A : TAX
                
                LDA.b $00 : STA.l $7F2000, X : STA.l $7F2040, X
                
            .skipMiscObject
            
            LDA.b $00 : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $042C : BNE .nextMiscObject
    
    .chet
    
    CPY.w $042E : BEQ .noTorches
        STZ.b $04
        
        LDA.w #$C0C0 : STA.b $00
        
        .nextTorch
        
            LDA.w $0540, Y : AND.w #$3FFF : LSR A : TAX
            
            LDA.b $00 : STA.l $7F2000, X : STA.l $7F2040, X
            
            ; First torch uses 0xC0C0, second uses 0xC1C1, etc...
            AND.w #$EFEF : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $042E : BNE .nextTorch
        
        LDA.b $04 : STA.w $042E
        
    .noTorches
    
    ; The code for chest tile information. (base code anyways)
    LDA.w #$5858 : STA.b $00
    
    LDA.w #$0000
    
    LDX.w $0496 : BEQ .noChests
        LDA.b $AE : AND.w #$00FF
        
        CMP.w #$0027 : BEQ .hasHiddenChest
        CMP.w #$003C : BEQ .hasHiddenChest
        CMP.w #$003E : BEQ .hasHiddenChest
        CMP.w #$0029 : BCC .checkTag2 ; If $AE < 0x29
            CMP.w #$0033 : BCC .hasHiddenChest
                .checkTag2
                
                ; Load Tag2 properties
                LDA.b $AF : AND.w #$00FF
                
                CMP.w #$0027 : BEQ .hasHiddenChest
                CMP.w #$003C : BEQ .hasHiddenChest
                CMP.w #$003E : BEQ .hasHiddenChest
                CMP.w #$0029 : BCC .noHiddenChests ; If $AF < #$29
                CMP.w #$0033 : BCC .hasHiddenChest ; If $AF < #$33
        
        .noHiddenChests
        
        JSR.w Dungeon_SetChestAttr
    
    .noChests
    
    ; Number of Big Key Locks
    CPY.w $0498 : BEQ .noBigKeyLocks
        .nextBigKeyLock
        
        ; Tells the game engine that this one is a big key lock instead of a
        ; big chest.
        LDA.w $06E0, Y : ORA.w #$8000 : STA.w $06E0, Y
        
        AND.w #$7FFF : LSR A : TAX
        
        LDA.b $00 : STA.l $7F2000, X : STA.l $7F2040, X
        
        CLC : ADC.w #$0101 : STA.b $00
        
        INY #2 : CPY.w $0498 : BNE .nextBigKeyLock
            .noBigKeyLocks

    .hasHiddenChest
    
    LDY.w #$0000 : STY.b $02
    
    LDA.w #$3F3F
    
    LDX.w $049A : BNE .pey
        INC.b $02
        
        LDA.w #$3E3E
        
        ; Interesting to note that $049A being nonzero would exclude $049C ever
        ; being used.
        LDX.w $049C : BNE .pey
            LDX.w $049E : BEQ .fey
                INC.b $02
                
                LDA.w #$3D3D
        
    .pey
    
    STA.b $00
    
    LDA.b $02 : STA.w $044A
    
    STX.b $02
    
    .tsadie
    
        LDX.w $06EC, Y
        
        LDA.w #$0002 : STA.l $7F3000, X : STA.l $7F20C0, X
        LDA.w #$0001 : STA.l $7F3040, X : STA.l $7F2080, X
        LDA.w #$0200 : STA.l $7F3002, X : STA.l $7F20C2, X
        LDA.w #$0100 : STA.l $7F3042, X : STA.l $7F2082, X
        
        LDA.b $00
        STA.l $7F2041, X : STA.l $7F3041, X
        STA.l $7F2081, X : STA.l $7F3081, X
    INY #2 : CPY.b $02 : BNE .tsadie
    
    .fey
    
    LDY.w #$0000
    
    LDX.w $04AE : BEQ .qof
        LDA.w #$0002 : STA.w $044A
        
        .resh
        
            LDX.w $06EC, Y
            
            LDA.w #$0A03 : STA.l $7F30C0, X : XBA : STA.l $7F30C2, X
            LDA.w #$0003 : STA.l $7F20C0, X : XBA : STA.l $7F20C2, X
            
            LDA.w #$0808 : STA.l $7F2080, X : STA.l $7F2082, X
        INY #2 : CPY.w $04AE : BNE .resh
    
    .qof
    
    INC.w $0200
    
    RTS
}

; ==============================================================================

; This routine loads tile attribute information for chests and big chests.
; $00BDDB-$00BE16 LOCAL JUMP LOCATION
Dungeon_SetChestAttr:
{
    .nextChest
    
        LDA.w $06E0, Y : BEQ .getNextChestAttr
            AND.w #$7FFF : LSR A : TAX
            
            ; Write the tile type to memory. (In my case, chests); So it would
            ; look like 0x5858, 0x5959, etc.
            LDA.b $00 : STA.l $7F2000, X : STA.l $7F2040, X
            
            LDA.w $06E0, Y : ASL A : BCC .getNextChestAttr
                ; It's a big chest, handle it appropriately.
                LSR A : STA.w $06E0, Y
                
                ; Must apply this property over a larger area.
                LDA.b $00
                STA.l $7F2042, X : STA.l $7F2080, X : STA.l $7F2082, X
        
        .getNextChestAttr
        
        ; Add #$0101, makes sense because the next chest is 0x5959 etc.
        LDA.b $00 : CLC : ADC.w #$0101 : STA.b $00
    INY #2 : CPY.w $0496 : BNE .nextChest
    
    RTS
}

; ==============================================================================

; $00BE17-$00BE34 LOCAL JUMP LOCATION
Dungeon_LoadDoorAttr:
{
    REP #$30
    
    LDY.w #$0000
    
    .nextDoor
    
        ; Look at the tile address of each door.
        ; If zero, skip this door (doesn't exist)
        LDA.w $19A0, Y : BEQ .skipDoor
            JSR.w Dungeon_LoadSingleDoorAttr
        
        .skipDoor
    INY #2 : CPY.w #$0020 : BNE .nextDoor
    
    ; Load door tile attributes.
    JSR.w Dungeon_LoadToggleDoorAttr_extern

    ; Random routine for an unfinished object.
    JSR.w ChangeDoorToSwitch
    
    INC.w $0200
    
    RTS
}

; ==============================================================================

; $00BE35-$00BFB1 LOCAL JUMP LOCATION
Dungeon_LoadSingleDoorAttr:
{
    ; Low byte is the object type.
    ; Dat is sum long list o' doors
    LDA.w $1980, Y : AND.w #$00FE : STA.b $02
    
                   BEQ .BRANCH_ALPHA
    CMP.w #$0006 : BEQ .BRANCH_ALPHA
    CMP.w #$0012 : BEQ .BRANCH_ALPHA
    CMP.w #$000A : BEQ .BRANCH_ALPHA
        CMP.w #$000C : BEQ .BRANCH_BETA
            CMP.w #$000E : BEQ .BRANCH_ALPHA
                ; Other special doors report to branch_beta
                CMP.w #$0010 : BEQ .BRANCH_BETA
                CMP.w #$0004 : BEQ .BRANCH_BETA
                CMP.w #$0002 : BEQ .BRANCH_BETA
                    CMP.w #$0008 : BNE .BRANCH_GAMMA ; Everything else...
                        .BRANCH_BETA
    
                        JMP.w AddFullLongDoorDoorwayProps
                    
                    .BRANCH_GAMMA
    
        CMP.w #$0030 : BNE .notBlastWall
            JMP Door_LoadBlastWallAttrStub
        
        .notBlastWall
        
        CMP.w #$0040 : BCC .BRANCH_EPSILON
            JMP.w AddDoorwayPropsForWeirdos
        
        .BRANCH_EPSILON
        
        CMP.w #$0018 : BEQ .BRANCH_ZETA
            ; Wondering how this point would ever be reached...
            ; (see the if(type < 0x0040) earlier)
            CMP.w #$0044 : BEQ .BRANCH_ZETA
                TYA : AND.w #$000F
                
                BRA .BRANCH_THETA
        
        .BRANCH_ZETA
        
        TYA : AND.w #$00FF
        
        .BRANCH_THETA
        
        TAX
        
        LDA.w $068C : AND.w DungeonMask, X : BNE .BRANCH_ALPHA
            SEP #$20
            
            TYA : LSR A : ORA.b #$F0 : STA.b $00 : STA.b $01
            
            REP #$20
            
            LDA.w $19A0, Y : LSR A : TAX
            
            LDA.b $00 : STA.l $7F2041, X : STA.l $7F2081, X
            
            .return
            
            RTS
    
    .BRANCH_ALPHA
    
    LDX.b $02
    
    CPX.w #$0020 : BCC .lockedStaircaseCover
        CPX.w #$0028 : BCC .return
    
    .lockedStaircaseCover
    
    ; Load tile attributes to fill in for the door's passage way.
    LDA.w DoorwayTileProperties, X : STA.b $00
    
    ; Check if it's an up door?
    LDA.w $19C0, Y : AND.w #$0003 : BNE .notUpDoor
        ; Is an up door?
        LDA.w $19A0, Y
        
        CMP.w $19E2 : BEQ .isUpExitDoor
        CMP.w $19E4 : BEQ .isUpExitDoor
        CMP.w $19E6 : BEQ .isUpExitDoor
            CMP.w $19E8 : BNE .notUpExitDoor
                .isUpExitDoor
                
                LDX.w #$8E8E : STX.b $00
            
            .notUpExitDoor
        
        LSR A : TAX
        
        LDA.b $00        : STA.l $7F2001, X
        STA.l $7F2041, X : STA.l $7F2081, X
        STA.l $7F20C1, X : STA.l $7F2101, X
        STA.l $7F2141, X : STA.l $7F2181, X
        
        LDA.w #$0000 : STA.l $7F21C1, X
        
        RTS
    
    .notUpDoor
    
    CMP.w #$0001 : BNE .notDownDoor
        LDA.w $19A0, Y
        
        ; Apparently these types are forced to be exit doors in this context?
        CPX.w #$000A : BEQ .isDownExitDoor
        CPX.w #$000E : BEQ .isDownExitDoor
            CMP.w $19E2 : BEQ .isDownExitDoor
            CMP.w $19E4 : BEQ .isDownExitDoor
            CMP.w $19E6 : BEQ .isDownExitDoor
                CMP.w $19E8 : BNE .notDownExitDoor
                    .isDownExitDoor
        
                    LDX.w #$8E8E : STX.b $00
        
                .notDownExitDoor
        
                LSR A : TAX
                
                LDA.b $00        : STA.l $7F2041, X
                STA.l $7F2081, X : STA.l $7F20C1, X
                STA.l $7F2101, X : STA.l $7F2141, X
                
                RTS
    
    .notDownDoor
    
    CMP.w #$0002 : BNE .notLeftDoor
        LDA.w $19A0, Y : LSR A : AND.w #$FFE0 : TAX
        
        LDA.b $00 : CLC : ADC.w #$0101
        
        STA.l $7F2040, X : STA.l $7F2042, X
        STA.l $7F2080, X : STA.l $7F2082, X
        
        AND.w #$00FF : STA.l $7F2044, X : STA.l $7F2084, X
        
        RTS
    
    .notLeftDoor
    
    LDA.w $19A0, Y : LSR A : TAX
    
    LDA.b $00 : CLC : ADC.w #$0101
    
    STA.l $7F2042, X : STA.l $7F2044, X
    STA.l $7F2082, X : STA.l $7F2084, X
    
    AND.w #$FF00 : STA.l $7F2040, X : STA.l $7F2080, X
    
    RTS
}

; ==============================================================================

; This is handled somewhere else because a blast wall is much different from
; typical doors.
; $00BFB2-$00BFB2 JUMP LOCATION
Door_LoadBlastWallAttrStub:
{
    RTS
}

; ==============================================================================

; UNUSED:
; $00BFB3-$00BFC0 JUMP LOCATION
UNREACHABLE_01BFB3:
{
    TYA : AND.w #$000F : TAX
    
    LDA.w $068C : AND.w DungeonMask, X : BNE .alpha
        RTS
    
    .alpha
    
    ; Bleeds into the next function.
}

; ==============================================================================

; $00BFC1-$00C084 LOCAL JUMP LOCATION
Door_LoadBlastWallAttr:
{
    LDA.w $19C0, Y : AND.w #$0002 : BNE .leftOrRightDoor
        LDA.w $19A0, Y : LSR A : TAX
        
        LDA.w #$000C : STA.b $00
        
        .nextRow
        
            LDA.w #$0102 : STA.l $7F2000, X
            
            LDA.w #$0000
            
            STA.l $7F2002, X : STA.l $7F2004, X
            STA.l $7F2006, X : STA.l $7F2008, X
            STA.l $7F200A, X : STA.l $7F200C, X
            STA.l $7F200E, X : STA.l $7F2010, X
            STA.l $7F2012, X
            
            LDA.w #$0201 : STA.l $7F2014, X
            
            TXA : CLC : ADC.w #$0040 : TAX
        DEC.b $00 : BNE .nextRow
        
        RTS
    
    .leftOrRightDoor
    
    ; I'm pretty sure this never occurs in the actual game (unused), as
    ; the only blast wall type door only takes on a blast wall appearance
    ; when the door direction is up. Perhaps Hyrule Magic is mistaken
    ; though? Wouldn't be the first time.
    LDA.w $19A0, Y : LSR A : TAX
    
    LDA.w #$0005 : STA.b $00
    
    .nextColumn
    
        LDA.w #$0101 : STA.l $7F2000, X : STA.l $7F2540, X
        LDA.w #$0202 : STA.l $7F2040, X : STA.l $7F2500, X
        
        LDA.w #$0000
        
        STA.l $7F2080, X : STA.l $7F20C0, X 
        STA.l $7F2100, X : STA.l $7F2140, X
        STA.l $7F2180, X : STA.l $7F21C0, X 
        STA.l $7F2200, X : STA.l $7F2240, X
        STA.l $7F2280, X : STA.l $7F22C0, X
        STA.l $7F2300, X : STA.l $7F2340, X
        STA.l $7F2380, X : STA.l $7F23C0, X
        STA.l $7F2400, X : STA.l $7F2440, X
        STA.l $7F2480, X : STA.l $7F24C0, X
        
        INX #2
    DEC.b $00 : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; $00C085-$00C0B7 JUMP LOCATION
AddDoorwayPropsForWeirdos:
{
    CMP.w #$0040 : BEQ .alpha
    CMP.w #$0046 : BEQ .alpha
        TYA : AND.w #$00FF : TAX
        
        LDA.w $068C : AND.w DungeonMask, X : BNE .alpha
            SEP #$20
            
            ; The low nybble of the attribute corresponds to the door's
            ; position in the door slots (array of door information).
            TYA : LSR A : ORA.b #$F0 : STA.b $00 : STA.b $01
            
            REP #$20
            
            LDA.w $19A0, Y : LSR A : TAX
            
            ; In the center (2x2) of the door, write this tile attribute value,
            ; which seems to always have upper nybble 0xf.
            LDA.b $00 : STA.l $7F2041, X : STA.l $7F2081, X
            
            RTS

    .alpha

    ; Bleeds into the next function.
}

; $00C0B8-$00C1B9 JUMP LOCATION
AddFullLongDoorDoorwayProps:
{
    ; Load the door type
    LDX.b $02
    
    ; Load the tile attributes to use
    LDA.w DoorwayTileProperties, X : STA.b $00
    
    LDA.w $19C0, Y : AND.w #$0003 : BNE .notUpDoor
        LDA.w $19A0, Y : LSR A : AND.w #$783F : TAX
        
        LDA.b $00
        
        STA.l $7F2001, X : STA.l $7F2041, X
        STA.l $7F2081, X : STA.l $7F20C1, X
        STA.l $7F2101, X : STA.l $7F2141, X
        STA.l $7F2181, X : STA.l $7F21C1, X
        STA.l $7F2201, X : STA.l $7F2241, X
        
        RTS
    
    .notUpDoor
    
    CMP.w #$0001 : BNE .notDownDoor
        CPX.w #$000C : BEQ .isExitDoor
        CPX.w #$0010 : BEQ .isExitDoor
        CPX.w #$0004 : BEQ .isExitDoor
            LDA.w $19A0, Y : AND.w #$1FFF
            
            CMP.w $19E2 : BEQ .isExitDoor
            CMP.w $19E4 : BEQ .isExitDoor
            CMP.w $19E6 : BEQ .isExitDoor
                CMP.w $19E8 : BNE .notExitDoor
                    .isExitDoor
            
                    LDX.w #$8E8E : STX.b $00
            
            .notExitDoor
        
            LDA.w $19A0, Y : LSR A : CLC : ADC.w #$0040 : TAX
            
            LDA.b $00
            
            STA.l $7F2001, X : STA.l $7F2041, X
            STA.l $7F2081, X : STA.l $7F20C1, X
            STA.l $7F2101, X : STA.l $7F2141, X
            STA.l $7F2181, X : STA.l $7F21C1, X
            
            RTS
    
    .notDownDoor
    
    CMP.w #$0002 : BNE .notLeftDoor
        LDA.w $19A0, Y : LSR A : AND.w #$FFE0 : TAX
        
        LDA.b $00 : CLC : ADC.w #$0101
        
        STA.l $7F2040, X : STA.l $7F2042, X
        STA.l $7F2044, X : STA.l $7F2046, X
        STA.l $7F2080, X : STA.l $7F2082, X
        STA.l $7F2084, X : STA.l $7F2086, X
        
        RTS
    
    .notLeftDoor
    
    LDA.w $19A0, Y : LSR A : INC A : TAX
    
    LDA.b $00 : CLC : ADC.w #$0101
    
    STA.l $7F2040, X : STA.l $7F2042, X : STA.l $7F2044, X : STA.l $7F2046, X
    STA.l $7F2080, X : STA.l $7F2082, X : STA.l $7F2084, X : STA.l $7F2086, X
    
    RTS
}

; ==============================================================================

; The code in here seems experimental, and I don't think the object
; that would use this is even used the actual game anywhere.
; $00C1BA-$00C21B LOCAL JUMP LOCATION
ChangeDoorToSwitch:
{
    REP #$30
    
    LDA.w $04B0 : BEQ .return
        LDA.w $04B0 : AND.w #$3FFF : LSR A : TAX
        
        LDY.w #$0004
        
        LDA.w $04B0 : ASL A : BCC .normalSize
            ; Add one column of 16 pixels to this attribute mapping.
            INY
        
        .normalSize
        
        LDA.w $0402 : AND.w #$1000 : BEQ .differentConfig
            .nextColumn
            
                LDA.w #$0101 : STA.l $7F2000, X : STA.l $7F2280, X
                
                LDA.w #$0000
                STA.l $7F2080, X : STA.l $7F2100, X
                STA.l $7F2180, X : STA.l $7F2200, X
                
                INX #2
            DEY : BPL .nextColumn
            
            SEP #$30
            
            RTS
        
        .differentConfig

        .nextColumn2
        
            LDA.w #$2323
            STA.l $7F2080, X : STA.l $7F2100, X
            STA.l $7F2180, X : STA.l $7F2200, X
            
            INX #2
        DEY : BPL .nextColumn2
    
    .return
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; Initializes the tile attributes for the orange/blue barrier tiles
; $00C21C-$00C229 JUMP LOCATION
Dungeon_InitBarrierAttr:
{
    INC.w $0200
    
    ; Check the orange/blue barrier state.
    LDA.l $7EC172 : BEQ .ignore
        ; If it's nonzero, flip the collision states for the barriers.
        JSL.l Dungeon_ToggleBarrierAttr
    
    .ignore
    
    RTS
}

; ==============================================================================

; $00C22A-$00C27C LONG JUMP LOCATION
Dungeon_ToggleBarrierAttr:
{
    REP #$10
    
    LDX.w #$07FF
    
    .nextAttrSet
    
        LDA.l $7F2000, X
        
        CMP.b #$66 : BEQ .toggle1
            CMP.b #$67 : BNE .noToggle1
                .toggle1
                
                EOR.b #$01 : STA.l $7F2000, X
        
            .noToggle1    
        
        LDA.l $7F2800, X
        
        CMP.b #$66 : BEQ .toggle2
            CMP.b #$67 : BNE .noToggle2
                .toggle2
                
                EOR.b #$01 : STA.l $7F2800, X
                
            .noToggle2
        
        LDA.l $7F3000, X
        
        CMP.b #$66 : BEQ .toggle3
            CMP.b #$67 : BNE .noToggle3
                .toggle3
                
                EOR.b #$01 : STA.l $7F3000, X
        
            .noToggle3
        
        LDA.l $7F3800, X
        
        CMP.b #$66 : BEQ .toggle4
            CMP.b #$67 : BNE .noToggle4
                .toggle4
                
                EOR.b #$01 : STA.l $7F3800, X
        
            .noToggle4
    DEX : BPL .nextAttrSet
    
    SEP #$10
    
    RTL
}

; ==============================================================================

; Tag routines
; $00C27D-$00C2FC JUMP TABLE
Dungeon_TagRoutines:
{
    dw Dungeon_DetectStaircaseEasyOut   ; 0x00 - $C328 Routine 0x00 (RTS)
    dw RoomTag_NorthWestTrigger         ; 0x01 - $C432 Routine 0x01 "NW kill enemy to open"
    dw RoomTag_NorthEastTrigger         ; 0x02 - $C438 Routine 0x02 "NE kill enemy to open"
    dw RoomTag_SouthWestTrigger         ; 0x03 - $C43E Routine 0x03 "SW kill enemy to open"
    dw RoomTag_SouthEastTrigger         ; 0x04 - $C444 Routine 0x04 "SE kill enemy to open"
    dw RoomTag_WestTrigger              ; 0x05 - $C44A Routine 0x05 "W kill enemy to open"
    dw RoomTag_EastTrigger              ; 0x06 - $C450 Routine 0x06 "E kill enemy to open"
    dw RoomTag_NorthTrigger             ; 0x07 - $C456 Routine 0x07 "N kill enemy to open"
    
    dw RoomTag_SouthTrigger             ; 0x08 - $C45C Routine 0x08 "S kill enemy to open"
    dw RoomTag_QuadrantTrigger          ; 0x09 - $C461 Routine 0x09 "clear quadrant to open"
    dw RoomTag_RoomTrigger              ; 0x0A - $C4BF Routine 0x0A "clear room to open"
    dw RoomTag_NorthWestTrigger         ; 0x0B - $C432 Routine 0x0B "NW move block to open"
    dw RoomTag_NorthEastTrigger         ; 0x0C - $C438 Routine 0x0C "NE move block to open"
    dw RoomTag_SouthWestTrigger         ; 0x0D - $C43E Routine 0x0D "SW move block to open"
    dw RoomTag_SouthEastTrigger         ; 0x0E - $C444 Routine 0x0E "SE move block to open"
    dw RoomTag_WestTrigger              ; 0x0F - $C44A Routine 0x0F "W move block to open"
    
    dw RoomTag_EastTrigger              ; 0x10 - $C450 Routine 0x10 "E move block to open"
    dw RoomTag_NorthTrigger             ; 0x11 - $C456 Routine 0x11 "N move block to open"
    dw RoomTag_SouthTrigger             ; 0x12 - $C45C Routine 0x12 "S move block to open"
    dw RoomTag_QuadrantTrigger          ; 0x13 - $C461 Routien 0x13 "move block to open"
    dw RoomTag_PullSwitchDoor           ; 0x14 - $C4E7 Routine 0x14 "pull lever to Open"
    dw RoomTag_PrizeTriggerDoorDoor     ; 0x15 - $C508 Routine 0x15 "clear level to open door"
    dw RoomTag_SwitchTrigger_HoldDoor   ; 0x16 - $C541 Routine 0x16 "switch opens doors (hold)"
    dw RoomTag_SwitchTrigger_ToggleDoor ; 0x17 - $C599 Routine 0x17 "switch opens doors (toggle)"
    
    dw RoomTag_WaterOff                 ; 0x18 - $CA94 Routine 0x18 (turn off water)
    dw Tag_TurnOnWater                  ; 0x19 - $CB1A Routine 0x19 (turn on water)
    dw Tag_Watergate                    ; 0x1A - $CB49 Routine 0x1A (watergate room)
    dw Tag_Watergate_easyOut            ; 0x1B - $CBFF (RTS) (water twin)
    dw RoomTag_MovingWall_East          ; 0x1C - $C8D4 Routine 0x1C Secret Wall (Right)
    dw RoomTag_MovingWall_West          ; 0x1D - $C98B Routine 0x1D Secret Wall (Left)
    dw RoomTag_MovingWallTorchesCheck   ; 0x1E - $CA17 Routine 0x1E "Crash"
    dw RoomTag_MovingWallTorchesCheck   ; 0x1F - $CA17 Routine 0x1F "Crash"
    
    dw RoomTag_Switch_ExplodingWall     ; 0x20 - $C67A Routine 0x20 "use switch to bomb wall"
    dw RoomTag_Holes0                   ; 0x21 - $CC00 Routine 0x21 "holes(0)"
    dw RoomTag_ChestHoles0              ; 0x22 - $CC5B Routine 0x22 "open chest for holes (0)"
    dw RoomTag_Holes1                   ; 0x23 - $CC04 Routine 0x23 "holes(1)"
    dw RoomTag_Holes2                   ; 0x24 - $CC89 Routine 0x24 "holes(2)"
    dw RoomTag_GetHeartForPrize         ; 0x25 - $C709 Routine 0x25 "kill enemy to clear level"
    dw RoomTag_KillRoomBlock            ; 0x26 - $C7A2 Routine 0x26 "kill enemy to move block"
    dw RoomTag_TriggerChest             ; 0x27 - $C7CC Routine 0x27 "trigger activated chest"
    
    dw RoomTag_PullSwitchExplodingWall  ; 0x28 - $C685 Routine 0x28 "use lever to bomb wall"
    dw RoomTag_NorthWestTrigger         ; 0x29 - $C432 Routine 0x29 "NW kill enemy for chest"
    dw RoomTag_NorthEastTrigger         ; 0x2A - $C438 Routine 0x2A "NE kill enemy for chest"
    dw RoomTag_SouthWestTrigger         ; 0x2B - $C43E Routine 0x2B "SW kill enemy for chest"
    dw RoomTag_SouthEastTrigger         ; 0x2C - $C444 Routine 0x2C "SE kill enemy for chest"
    dw RoomTag_WestTrigger              ; 0x2D - $C44A Routine 0x2D "W kill enemy for chest"
    dw RoomTag_EastTrigger              ; 0x2E - $C450 Routine 0x2F "E kill enemy for chest"
    dw RoomTag_NorthTrigger             ; 0x2F - $C456 Routine 0x2F "N kill enemy for chest"
    
    dw RoomTag_SouthTrigger             ; 0x30 - $C45C Routine 0x30 "S kill enemy for chest"
    dw RoomTag_QuadrantTrigger          ; 0x31 - $C461 Routine 0x31 "clear quadrant for chest"
    dw RoomTag_RoomTrigger              ; 0x32 - $C4BF Routine 0x32 "clear room for chest"
    dw RoomTag_TorchPuzzleDoor          ; 0x33 - $C629 Routine 0x33 "light torches to open"
    dw RoomTag_Holes3                   ; 0x34 - $CC08 Routine 0x34 "Holes(3)"
    dw RoomTag_Holes4                   ; 0x35 - $CC0C Routine 0x35 "Holes(4)"
    dw RoomTag_Holes5                   ; 0x36 - $CC10 Routine 0x36 "Holes(5)"
    dw RoomTag_Holes6                   ; 0x37 - $CC14 Routine 0x37 "Holes(6)"
    
    dw RoomTag_Agahnim                  ; 0x38 - $C74E Routine 0x38 "Agahnim's room"
    dw RoomTag_Holes7                   ; 0x39 - $CC18 Routine 0x39 "Holes(7)"
    dw RoomTag_Holes8                   ; 0x3A - $CC1C Routine 0x3A "Holes(8)"
    dw RoomTag_ChestHoles8              ; 0x3B - $CC62 Routine 0x3B "open chest for holes (8)"
    dw RoomTag_PushBlockForChest        ; 0x3C - $C7C2 Routine 0x3C "move block to get chest"
    dw RoomTag_GanonDoor                ; 0x3D - $C767 Routine 0x3D "Kill to open Ganon's door"
    dw RoomTag_TorchPuzzleChest         ; 0x3E - $C8AE Routine 0x3E "light torches to get chest"
    dw RoomTag_RekillableBoss           ; 0x3F - $C4DB Routine 0x3F "kill boss again"
}

; $00C2FD-$00C31E LONG JUMP LOCATION
Dungeon_CheckStairsAndRunScripts:
{
    LDA.w $04C7 : BNE .return
        SEP #$30
        
        JSR.w Dungeon_DetectStaircase
        
        STZ.b $0E
        
        LDA.b $AE : ASL A : TAX
        
        ; Handle tag1 routine.
        JSR.w (Dungeon_TagRoutines, X)
        
        ; Based on the whether it's tag1 or tag2, execute different routines.
        LDA.b #$01 : STA.b $0E
        
        LDA.b $AF : ASL A : TAX
        
        ; Handle tag2 routine.
        JSR.w (Dungeon_TagRoutines, X)
    
    .return
    
    STZ.w $04C7
    
    RTL
}

; ==============================================================================

; $00C31F-$00C324 DATA
LayerOfDestination:
{
    ; $00C31F
    .for_0476
    db $00, $01, $01
    
    ; $00C322
    .for_EE
    db $00, $00, $01
}

; ==============================================================================

; $00C325-$00C328 BRANCH LOCATION
Dungeon_DetectStaircaseEasyOut:
{
    ._1
    
    PLA
    
    ; $00C326 ALTERNATE ENTRY POINT
    ._2
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $00C329-$00C431 LOCAL JUMP LOCATION
Dungeon_DetectStaircase:
{
    REP #$20
    
    ; If Link is not moving up or down, or isn't moving, end this routine.
    LDA.b $67 : AND.w #$000C : BEQ Dungeon_DetectStaircaseEasyOut_2
        STA.b $02
        
        TAY
        
        LDA.b $20 : CLC : ADC.w DetectStaircase_offset_y, Y
        AND.w #$01F8 : ASL #3 : STA.b $00

        LDA.b $22
        AND.w #$01F8 : LSR #3 : ORA.b $00
        
        LDX.b $EE : BEQ .onBg2
            ORA.w #$1000
        
        .onBg2
        
        REP #$10
        
        TAX
        
        PHX
        
        ; Link's directional indicator... 0x0004 denotes the down direction
        LDY.b $02 : CPY.w #$0004 : BNE .movingUp
            ; If Link is moving down, look two tiles down for the trigger tile
            CLC : ADC.w #$0080 : TAX
        
        .movingUp
        
        SEP #$20
        
        LDA.l $7F2000, X
        
        PLX
        
        CMP.b #$26 : BEQ .staircaseEdge
        ; North straight up inter-room staircases
        CMP.b #$38 : BEQ .staircaseEdge
        ; South straight down inter-room staircases
        CMP.b #$39 : BEQ .staircaseEdge
        CMP.b #$5E : BEQ .staircaseEdge ; Staircase
            CMP.b #$5F : BNE Dungeon_DetectStaircaseEasyOut_2

        .staircaseEdge
        
        PHA : STA.b $0E
        
        LDA.l $7F2040, X : TAY
        
        ; See if this is a staircase trigger ( 0x30 to 0x37 )
        ; End the routine if Link isn't touching a staircase.
        ; (This leads to an RTS)
        AND.b #$F8 : CMP.b #$30 : BNE Dungeon_DetectStaircaseEasyOut_1
            ; Is Link holding a pot?
            LDA.w $0308 : BPL .notHoldingPot
                PLA
                
                REP #$20
                
                LDA.w $0FC4 : STA.b $20
                
                ; Abort mission! Link is holding a pot.
                BRA Dungeon_DetectStaircaseEasyOut_2
            
            .notHoldingPot
            
            REP #$20
            
            ; Store which staircase it is (0x30 to 0x37).
            STY.w $0462
            
            ; Cache the current room number
            LDA.b $A0 : STA.b $A2
            
            SEP #$30
            
            JSL.l Dungeon_SaveRoomQuadrantData
            
            SEP #$30
            
            LDA.b $0E
            
            CMP.b #$38 : BEQ .BRANCH_EPSILON
                CMP.b #$39 : BNE .BRANCH_ZETA
            
            .BRANCH_EPSILON
            
            LDX.b #$20 : STX.w $0464
            
            CMP.b #$38 : BNE .mystery
                ; Gets called when travelling up a straight inter-room
                ; staircase.
                JSL.l HandleEdgeTransitionMovementNorth
                
                BRA .BRANCH_ZETA
                
            .mystery
            
            JSL.l HandleEdgeTransitionMovementSouth
            
            .BRANCH_ZETA
            
            LDA.w $0462 : AND.b #$03 : TAX
            
            ; Load the target room.
            LDA.l $7EC001, X : STA.b $A0
            
            LDA.w $063D, X : STA.w $048A
            
            LDX.b #$02
            
            LDA.b $EE : BNE .BRANCH_THETA
                LDX.b #$00
                
                LDA.w $0476 : BEQ .BRANCH_THETA
                    LDX.b #$02
            
            .BRANCH_THETA
            
            STX.w $0492
            
            STZ.b $B0
            STZ.b $48
            STZ.b $3D
            STZ.b $3A
            STZ.b $3C
            
            LDA.b $50 : AND.b #$FE : STA.b $50
            
            ; Do an upward floor transition
            LDX.b #$06
            
            PLA : CMP.b #$26 : BEQ .BRANCH_IOTA
                LDX.b #$12
                
                CMP.b #$38 : BEQ .BRANCH_KAPPA
                    LDX.b #$13
                    
                    CMP.b #$39 : BEQ .BRANCH_KAPPA
                        JSL.l Link_AnimateIntraStairClimbAndSFX
                        
                        ; Going up or down stairs mode.
                        LDX.b #$0E : STX.b $11
                        
                        RTS
                
                .BRANCH_KAPPA
                
                STX.b $11
                
                JSL.l LinkResetPushTimer
                
                RTS
            
            .BRANCH_IOTA
            
            STX.b $11
            
            LDY.b #$16
            
            LDA.w $048A : CMP.b #$34 : BCC .BRANCH_LAMBDA
                LDY.b #$18
            
            .BRANCH_LAMBDA
            
            STY.w $012E ; Play one of the stairs sound effects.
            
            RTS
}

; ==============================================================================

; $00C432-$00C437 LOCAL JUMP LOCATION
RoomTag_NorthWestTrigger:
{
    ; Branch if Link is in the left two quadrants
    LDA.b $23 : LSR A : BCC RoomTag_NorthTrigger
        RTS
}

; RoomTag_Trigger:
; Tag routine 0x02 (NE Kill Enemy To Open), 0x0A (NE move block to open),
; 0x2A (NE kill enemy for chest)
; $00C438-$00C43D LOCAL JUMP LOCATION
RoomTag_NorthEastTrigger:
{
    ; Branch if Link in the right two quadrants
    LDA.b $23 : LSR A : BCS RoomTag_NorthTrigger
        RTS
}

; $00C43E-$00C443 LOCAL JUMP LOCATION
RoomTag_SouthWestTrigger:
{
    LDA.b $23 : LSR A : BCC RoomTag_SouthTrigger
        RTS
}

; Tag routine 0x04 (SE kill enemy to open), 0x0E (SE move block to open),
; 0x2C (SE kill enemy for chest)
; $00C444-$00C449 LOCAL JUMP LOCATION
RoomTag_SouthEastTrigger:
{
    LDA.b $23 : LSR A : BCS RoomTag_SouthTrigger
        RTS
}

; Tag routine 0x05 (W kill enemy to open), 0x0F (W move block to open),
; 0x2D (W kill enemy for chest)
; $00C44A-$00C44F LOCAL JUMP LOCATION
RoomTag_WestTrigger:
{
    LDA.b $23 : LSR A : BCC RoomTag_QuadrantTrigger
        RTS
}
        
; $00C450-$00C45B LOCAL JUMP LOCATION
RoomTag_EastTrigger:
{
    LDA.b $23 : LSR A : BCS RoomTag_QuadrantTrigger
        RTS
}
    
; $00C456-$00C45B LOCAL JUMP LOCATION
RoomTag_NorthTrigger:
{
    ; Branch if Link is in the upper two quadrants
    LDA.b $21 : LSR A : BCC RoomTag_QuadrantTrigger
        ; $00C45B ALTERNATE ENTRY POINT
        .coordFail
        
        RTS
}
        
; $00C45C-$00C460 LOCAL JUMP LOCATION
RoomTag_SouthTrigger:
{
    LDA.b $21 : LSR A : BCC RoomTag_NorthTrigger_coordFail
        ; Bleeds into the next function.
}

; $00C461-$00C4BE LOCAL JUMP LOCAION
RoomTag_QuadrantTrigger:
{
    LDX.b $0E
        
    LDA.b $AE, X
        
    CMP.b #$0B : BCC .checkIfEnemiesDead
        CMP.b #$29 : BCC .checkIfBlockMoved
            ; Check if sprites are all dead.
            JSL.l Sprite_VerifyAllOnScreenDefeated : BCC .dontShowChest
                JSR.w RoomTag_OperateChestReveal
                
            .dontShowChest
                
            RTS
            
        .checkIfBlockMoved
            
        LDA.w $0641 : EOR.b #$01 : CMP.w $0468 : BEQ .noDoorStateMatch
            STA.w $0468
                
            ; Play switch triggering sound.
            LDA.b #$25 : STA.w $012F
                
            ; Enter "open trap door" submodule.
            LDA.b #$05 : STA.b $11
                
            REP #$20
                
            STZ.w $068E
            STZ.w $0690
            
        .noDoorStateMatch
            
        SEP #$30
            
        RTS
        
    .checkIfEnemiesDead
        
    JSL.l Sprite_VerifyAllOnScreenDefeated : BCC .dontOpenDoors
        .checkDoorState
            
        ; Success, sprites are all dead.
            
        REP #$30
            
        ; Trap door down flag. (If it's already unset, ignore it!)
        LDX.w #$0000 : CPX.w $0468 : BEQ .dontOpenDoors
            STZ.w $0468
            STZ.w $068E
            STZ.w $0690
                
            SEP #$30
                
            ; The mystery sound when a puzzle is solved.
            LDA.b #$1B : STA.w $012F
                
            ; Open ze doors
            LDA.b #$05 : STA.b $11
        
    .dontOpenDoors
        
    SEP #$30
        
    RTS
}

; $00C4BF-$00C4DA JUMP LOCATION
RoomTag_RoomTrigger:
{
    LDX.b $0E
    
    LDA.b $AE, X : CMP.b #$0A : BEQ .clearRoomToOpen
        ; (clear room for chest portion)
        
        JSL.l Sprite_CheckIfAllDefeated : BCC .return
        
        JSR.w RoomTag_OperateChestReveal
        
        .return
        
        SEP #$30
        
        RTS
    
    .clearRoomToOpen

    RoomTag_FullRoomKillCheck:
    
    JSL.l Sprite_CheckIfAllDefeated : BCC .return : BCS .checkDoorState

    ; Bleeds into the next function.
}

; Tag routine 0x3F "kill boss again"
; $00C4DB-$00C4E6 JUMP LOCATION
RoomTag_RekillableBoss:
{
    ; Carry clear = failure. Sprites are still onscreen.
    JSL.l Sprite_CheckIfAllDefeated : BCC RoomTag_RoomTrigger_return
        STZ.w $0FFC
        STZ.b $AF
        
        RTS
}

; Tag routine 0x14 "pull lever to open"
; $00C4E7-$00C507 JUMP LOCATION
RoomTag_PullSwitchDoor:
{
    LDA.w $0642 : BEQ .stillOnTrigger
        REP #$30
        
        LDX.w #$0000 : CPX.w $0468 : BEQ .trapDoorsAreUp
            STX.w $0468
            
            STZ.w $068E
            STZ.w $0690
            
            SEP #$30
            
            LDA.b #$05 : STA.b $11
        
        .trapDoorsAreUp
    .stillOnTrigger
    
    SEP #$30
    
    RTS
}

; Tag routine 0x16 "clear level to open doors" "Clear_Level_to_Open"
; $00C508-$00C540 JUMP LOCATION
RoomTag_PrizeTriggerDoorDoor:
{
    ; Load the dungeon index.
    LDA.w $040C : LSR A : TAX
    
    ; Which world are we in?
    LDA.l $7EF3CA : BNE .inDarkWorld
        ; See which pendants we have.
        LDA.l $7EF374 : AND.l MilestoneItem_Flags, X : BEQ .dontHaveGoalItem
            BRA .openDoors
    
    .inDarkWorld
    
    ; How many crystals do we have?
    LDA.l $7EF37A : AND.l MilestoneItem_Flags, X : BEQ .dontHaveGoalItem
        .openDoors
        
        REP #$30
        
        STZ.w $0468
        STZ.w $068E
        STZ.w $0690
        
        SEP #$30
        
        LDA.b #$05 : STA.b $11
        
        LDX.b $0E
        
        STZ.b $AE, X
    
    .dontHaveGoalItem
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; Tag routine 0x16 - "switch opens doors (hold)"
; $00C541-$00C598 JUMP LOCATION
RoomTag_SwitchTrigger_HoldDoor:
{
    REP #$30
    
    LDA.w #$0005
    LDX.w #$FFFE
    
    .nextObject
    
        INX #2 : CPX.w $0478 : BEQ .endOfObjectList
    CMP.w $0500, X : BNE .nextObject
    
    LDX.w $0466 : CPX.w #$FFFF : BNE .testAgainstDoorState
        .endOfObjectList
        
        LDX.w #$0000
        
        LDA.w $0646 : AND.w #$00FF : BNE .testAgainstDoorState
            LDA.w $0642 : AND.w #$00FF : BNE .testAgainstDoorState
                JSR.w RoomTag_CheckForPressedSwitch
                LDX.w #$0000 : BCS .testAgainstDoorState
                    INX
    
    .testAgainstDoorState
    
    CPX.w $0468 : BEQ .noChangeInTrapDoorState
        STX.w $0468
        
        STZ.w $068E
        STZ.w $0690
        
        SEP #$30
        
        CPX.b #$00 : BNE .noSoundEffect
            ; Play the "switch triggered" sound effect
            LDA.b #$25 : STA.w $012F

        .noSoundEffect

        LDA.b #$05 : STA.b $11

    .noChangeInTrapDoorState

    SEP #$30
    
    RTS
}

; ==============================================================================

; Dungeon Tag routine 0x17 "switch opens doors"
; $00C599-$00C5CE JUMP LOCATION
RoomTag_SwitchTrigger_ToggleDoor:
{
    REP #$30
    
    LDA.w $0430 : BNE .checkIfStandingOnSwitch
        JSR.w RoomTag_MaybeCheckShutters : BCC .notStandingOnSwitch
            STZ.w $068E
            STZ.w $0690
            
            SEP #$30
            
            LDA.b #$25 : STA.w $012F
            
            LDA.b #$05
            
            ; Toggle the opened / closed status of the trap doors in the room.
            JSR.w PushPressurePlate
            
            LDA.w $0468 : EOR.b #$01 : STA.w $0468
            
            INC.w $0430
            
            BRA .notStandingOnSwitch
    
    .checkIfStandingOnSwitch
    
    ; This code is waiting for Link to step off the switch before it can be
    ; pressed again.
    JSR.w RoomTag_MaybeCheckShutters : BCS .stillStandingOnSwitch
        STZ.w $0430
        
    .stillStandingOnSwitch
    .notStandingOnSwitch
    
    SEP #$30
    
    RTS
}

; $00C5CF-$00C628 LOCAL JUMP LOCATION
PushPressurePlate:
{
    STA.b $11
    
    LDX.b $0C : CPX.b #$23 : BEQ .BRANCH_ALPHA
        LDA.w $04B6 : ORA.w $04B7 : BEQ .BRANCH_ALPHA
            LDA.b $11 : STA.w $010C
            
            LDA.b #$17 : STA.b $11
            
            LDA.b #$20 : STA.b $B0
            
            REP #$30
            
            LDA.b $20 : CLC : ADC.w #$0002 : STA.b $20
            
            LDX.w $04B6
            
            LDA.l $7F2000, X : AND.w #$FE00 : CMP.w #$2400 : BEQ .isTriggerTile
                INX
            
            .isTriggerTile
            
            STX.w $04B6
            
            TXA : STA.b $00
            
            LSR #3 : AND.w #$01F8 : STA.b $02
            
            LDA.b $00 : AND.w #$003F : ASL #3 : STA.b $00
            
            SEP #$30
            
            LDY.b #$10
            
            JSL.l Dungeon_SpriteInducedTilemapUpdate
    
    .BRANCH_ALPHA
    
    SEP #$30
    
    RTS
}

; $00C629-$00C665 JUMP LOCATION
RoomTag_TorchPuzzleDoor:
{
    REP #$30
    
    LDX.w #$0000 : STX.b $00
    
    .BRANCH_BETA
    
        LDA.w $0540, X : ASL A : BCC .BRANCH_ALPHA
            INC.b $00
        
        .BRANCH_ALPHA
    INX #2 : CPX.w #$0020 : BNE .BRANCH_BETA
    
    LDX.w #$0001
    
    LDA.b $00 : CMP.w #$0004 : BCC .BRANCH_GAMMA
        DEX
    
    .BRANCH_GAMMA
    
    CPX.w $0468 : BEQ .BRANCH_DELTA
        STX.w $0468
        
        STZ.w $068E
        STZ.w $0690
        
        SEP #$30
        
        LDA.b #$1B : STA.w $012F
        
        LDA.b #$05 : STA.b $11
    
    .BRANCH_DELTA
    
    SEP #$30
    
    RTS
}

; $00C666-$00C679 DATA
ExplodingWall:
{
    ; $00C666
    .ExplosionMovement
    dw $0004, $0006, $0000, $0000, $0000
    
    ; $00C670
    .TilemapOffset
    dw $0000, $000A, $0000, $0000, $0280
}

; Tag routine 0x20 "use switch to bomb wall"
; $00C67A-$00C684 JUMP LOCATION
RoomTag_Switch_ExplodingWall:
{
    REP #$30
    
    JSR.w RoomTag_MaybeCheckShutters : BCC RoomTag_PullSwitchExplodingWall_return
        REP #$30
        
        BRA RoomTag_PullSwitchExplodingWall_checkForBombableWall
}

; Tag routine 0x28 "use lever to bomb wall"
; $00C685-$00C6FB JUMP LOCATION
RoomTag_PullSwitchExplodingWall:
{
    LDA.w $0642 : BEQ .return
        REP #$30
        
        .checkForBombableWall
        
        LDY.w #$FFFE
        
        .BRANCH_GAMMA
        
            INY #2
        LDA.w $1980, Y : AND.w #$00FE : CMP.w #$0030 : BNE .BRANCH_GAMMA
        
        STY.w $0456
        
        ; WTF: Based on this logic, wouldn't index 6 never get used in the
        ; tables below?
        LDA.b $21 : AND.w #$0001 : INC A : ASL #2 : TAX
        
        LDA.w $19C0, Y : AND.w #$0002 : BEQ .BRANCH_DELTA
            LDA.b $23 : AND.w #$0001 : ASL A : TAX
        
        .BRANCH_DELTA
        
        LDA.l ExplodingWall_ExplosionMovement, X : STA.l $7F001C
        
        LDA.w $19A0, Y : CLC : ADC.l ExplodingWall_TilemapOffset, X : TAY
        
        AND.w #$007E : ASL #2 : CLC : ADC.w $062C : STA.l $7F001A
        
        TYA : AND.w #$1F80 : LSR #4 : CLC : ADC.w $062E : STA.l $7F0018
        
        SEP #$30
        
        ; Play "puzzle solved" sound effect
        LDA.b #$1B : STA.w $012F
        
        LDA.b #$01 : STA.w $0454
        
        LDX.b $0E
        
        STZ.b $AE, X
        
        JSL.l AddBlastWall
    
    .return
    
    SEP #$30
    
    RTS
}

; $00C6FC-$00C708
Pool_RoomTag_GetHeartForPrize:
{
    db $00 ; Sewers
    db $00 ; Hyrule Castle
    db $01 ; Eastern Palace
    db $02 ; Desert Palace
    db $00 ; Agahnim's Tower
    db $06 ; Swamp Palace
    db $06 ; Palace of Darkness
    db $06 ; Misery Mire
    db $06 ; Skull Woods
    db $06 ; Ice Palace
    db $03 ; Tower of Hera
    db $06 ; Thieves' Town
    db $06 ; Turtle Rock
}

; Name: Kill enemy to clear level in hyrule magic
; $00C709-$00C74D JUMP LOCATION
RoomTag_GetHeartForPrize:
{
    ; Has this boss room already been done with? (i.e. has a heart piece been
    ; picked up in this room?)
    LDA.w $0403 : AND.b #$80 : BEQ .heartPieceStillExists
        ; Load the dungeon index, divide by 2.
        LDA.w $040C : LSR A : TAX
        
        ; Are we in the dark world?
        LDA.l $7EF3CA : BNE .inDarkWorld
            ; We're in the Light World.
            LDA.l $7EF374 : AND.l MilestoneItem_Flags, X : BNE .criticalItemAlreadyObtained
                BRA .giveCriticalItem
        
        .inDarkWorld
        
        LDA.l $7EF37A : AND.l MilestoneItem_Flags, X : BNE .criticalItemAlreadyObtained
            .giveCriticalItem
        
            LDA.b #$80 : STA.w $04C2
            
            LDA.b $0E : PHA
            
            LDA.w $040C : LSR A : TAX
            
            LDA.l Pool_RoomTag_GetHeartForPrize, X : JSL.l Sprite_SpawnFallingItem
            
            PLA : STA.b $0E
        
        .criticalItemAlreadyObtained
        
        LDX.b $0E
        
        STZ.b $AE, X
    
    .heartPieceStillExists
    
    RTS
}

; Tag routine 0x38 "Agahnim's room"
; $00C74E-$00C766 JUMP LOCATION
RoomTag_Agahnim:
{
    ; Look at the info for the Pyramid of power area.
    ; Has Ganon busted a nut on it yet? (broken in)
    LDA.l $7EF2DB : AND.b #$20 : BNE .return
        ; And it's checking if we have beaten Agahnim yet.
        LDA.w $0403 : ASL A : BCC .return
            ; Otherwise do some swapping to the palettes in memory.
            JSL.l Palette_RevertTranslucencySwap
            
            STZ.b $AE
            
            JSL.l PrepDungeonExit
    
    .return
    
    RTS
}

; Tag routine 0x3D (Kill to open Ganon's door)
; $00C767-$00C7A1 JUMP LOCATION
RoomTag_GanonDoor:
{
    LDX.b #$0F
    
    LDA.w $0DD0, X : CMP.b #$04 : BEQ .return
        LDA.w $0F60, X : AND.b #$40 : BNE .inactiveSprite
        
        .nextSprite
        
        ; Can't open the door as long even a single sprite lives.
        LDA.w $0DD0, X : BNE .return
        
        .inactiveSprite
        
        DEX : BPL .nextSprite
        
        ; If Link sucks and falls into a pit after he's killed Ganon
        ; there will be no mercy for him. Because he won't get to see this 
        ; spiffy door opening.
        LDA.b $5D : CMP.b #$01 : BEQ .return
            LDA.b #$1A : STA.w $02E4 : STA.b $11
            
            STZ.b $B0
            STZ.b $AE
            
            LDA.b #$01 : STA.w $03EF
            
            STZ.b $3A
            STZ.b $3C
            
            ; Set a timer preventing Link from doing anything until the fanfare
            ; is over.
            LDA.b #$64 : STA.b $C8
            LDA.b #$03 : STA.b $C9
    
    .return
    
    RTS
}

; Routine 0x26 (SE kill enemy to move block)
; $00C7A2-$00C7C1 JUMP LOCATION
RoomTag_KillRoomBlock:
{
    LDA.b $23 : LSR A : BCC .return
        LDA.b $21 : LSR A : BCC .return
            LDA.b $0E : PHA
            
            JSL.l Sprite_VerifyAllOnScreenDefeated : BCC .someSpritesAlive
                ; Play puzzle solved song
                LDA.b #$1B : STA.w $012F
                
                PLX
                
                STZ.b $AE, X
            
            .someSpritesAlive
            
            RTS
            
            ; This instruction is never reached in the original game
            PLA
            
            ; $00C7BE ALTERNATE ENTRY POINT
            .exit
            
            SEP #$30
    
    .return
    
    RTS
}

; Tag routine 0x3C (Move block to get chest)
; $00C7C2-$00C7CB JUMP LOCATION
RoomTag_PushBlockForChest:
{
    LDA.b $14 : BNE .already_doing_tilemap_update
        LDA.w $0641 : BNE RoomTag_OperateChestReveal
    
    .already_doing_tilemap_update
    
    RTS
}

; Tag routine 0x27 "trigger activated chest"
; $00C7CC-$00C7D7 JUMP LOCATION
RoomTag_TriggerChest:
{
    ; Link is flashing, so he can't do anythin.
    LDA.w $031F : BNE RoomTag_KillRoomBlock_return
        REP #$30
        
        JSR.w RoomTag_MaybeCheckShutters : BCC RoomTag_KillRoomBlock_exit

    ; Bleeds into the next function.
}

; $00C7D8-$00C8AD JUMP LOCATION
RoomTag_OperateChestReveal:
{
    SEP #$30
    
    LDX.b $0E
    
    STZ.b $AE, X
    
    REP #$30
    
    STZ.w $1000
    STZ.w $0200
    
    LDA.w #$5858 : STA.b $0C
    
    ; $00C7EB ALTERNATE ENTRY POINT
    .nextChest
    
    LDX.w $0200
    
    LDA.w $06E0, X : AND.w #$3FFF : TAX
    
    LDY.w #$149C
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.b $02
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X : STA.b $04
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2002, X : STA.b $06
    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2082, X : STA.b $08
    
    LDY.w $0200
    
    LDA.w $06E0, Y : AND.w #$3FFF : LSR A : TAX
    
    LDA.b $0C : STA.l $7F2000, X : STA.l $7F2040, X

    CLC : ADC.w #$0101 : STA.b $0C
    
    LDX.w $1000
    LDA.w #$0000
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $1002, X
    LDA.w #$0080
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $1008, X
    LDA.w #$0002
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $100E, X
    LDA.w #$0082
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $1014, X
    
    LDA.b $02 : STA.w $1006, X
    LDA.b $04 : STA.w $100C, X
    LDA.b $06 : STA.w $1012, X
    LDA.b $08 : STA.w $1018, X
    
    LDA.w #$0100
    STA.w $1004, X : STA.w $100A, X : STA.w $1010, X : STA.w $1016, X
    
    LDA.w #$FFFF : STA.w $101A, X
    
    TXA : CLC : ADC.w #$0018 : STA.w $1000
    
    LDA.w $0200 : INC #2 : STA.w $0200 : CMP.w $0496 : BEQ .lastChest
        JMP .nextChest
    
    .lastChest
    
    STZ.w $0200
    
    SEP #$30
    
    ; Play "show chest" sound effect
    LDA.b #$1A : STA.w $012F
    
    ; Update tilemap this frame
    LDA.b #$01 : STA.b $14
    
    RTS
}

; Tag routine 0x3E "light torches to get chest"
; $00C8AE-$00C8D3 JUMP LOCATION
RoomTag_TorchPuzzleChest:
{
    REP #$30
    
    LDX.w #$0000 : STX.b $00
    
    .nextObject
    
        LDA.w $0540, X : ASL A : BCC .torchNotLit
            INC.b $00
        
        .torchNotLit
    INX #2 : CPX.w #$0020 : BNE .nextObject
    
    LDX.w #$0001
    
    LDA.b $00 : CMP.w #$0004 : BCC .dontShowChest
        JSR.w RoomTag_OperateChestReveal
    
    .dontShowChest
    
    SEP #$30
    
    RTS
}

; $00C8D4-$00C960 JUMP LOCATION
RoomTag_MovingWall_East:
{
    REP #$20
    
    LDA.w $041A : BNE .horizontalMovement
        JSR.w RoomTag_MovingWallTorchesCheck
        
        BRA .beta
        
    .horizontalMovement
    
    LDY.b #$01 : STY.w $0FC1
    
    JSR.w RoomTag_MovingWallShakeItUp
    
    LDA.w #$FFFF
    
    JSR.w MovingWall_MoveALittle
    
    .beta
    
    STA.w $0312
    
    LDA.w $0422 : SEC : SBC.w $0312 : STA.w $0422
    
    CLC : ADC.b $E2 : STA.b $E0
    
    LDA.w $0312 : BEQ .zeroHorizontalSpeed
        LDX.w $041E
        
        LDA.w $0422 : CMP.w MovingWallEastBoundaries, X : BCS .BRANCH_DELTA
            JSR.w RoomTag_AdvanceGiganticWall
            
            LDA.w $0422 : CMP.w MovingWallEastBoundaries, X : BCS .BRANCH_DELTA
                ; Play the puzzle solved sound.
                LDX.b #$1B : STX.w $012F
                
                ; "silence" ambient sfx.
                LDX.b #$05 : STX.w $012D
                
                LDX.b $0E
                
                LDY.b #$00 : STY.b $AE, X : STY.w $02E4 : STY.w $0FC1
                
                STZ.w $011A
                STZ.w $011B
                STZ.w $011C
                STZ.w $011D
        
        .BRANCH_DELTA
        
        LDX.b #$05 : STX.b $17
        
        LDA.w #$0000 : SEC : SBC.w $0422 : STA.b $00
        
        AND.w #$01F8 : LSR #3 : STA.b $00
        
        LDA.w $042A : SEC : SBC.b $00 : AND.w #$141F : STA.w $0116
    
    .zeroHorizontalSpeed
    
    SEP #$20
    
    RTS
}

; $00C961-$00C968 DATA
OverworldShake_Offsets:
{
    ; $00C961
    .Y
    db  0,  1, -1, -1
    
    ; $00C965
    .X
    db -1, -1,  1,  0
}

; $00C969-$00C98A LOCAL JUMP LOCATION
RoomTag_MovingWallShakeItUp:
{
    LDA.b $1A : AND.w #$0001 : ASL A : TAX
    
    LDA.l OverworldShake_Offsets_Y, X : STA.w $011A
    LDA.l OverworldShake_Offsets_X, X : STA.w $011C
    
    LDX.b $0E
    
    LDY.b $AE, X : BNE .BRANCH_ALPHA
        STZ.w $011A
        STZ.w $011C
    
    .BRANCH_ALPHA
    
    RTS
}

; $00C98B-$00CA16 JUMP LOCATION Secret Wall (Left
RoomTag_MovingWall_West:
{
    REP #$20
    
    LDA.w $041A : BNE .wallIsMoving
        JSR.w RoomTag_MovingWallTorchesCheck
        
        BRA .BRANCH_BETA
    
    .wallIsMoving
    
    LDY.b #$01 : STY.w $0FC1
    
    JSR.w RoomTag_MovingWallShakeItUp
    
    LDA.w #$0001
    
    JSR.w MovingWall_MoveALittle
    
    .BRANCH_BETA
    
    STA.w $0312
    
    CLC : ADC.w $0422 : STA.w $0422
    CLC : ADC.b $E2   : STA.b $E0
    
    LDA.w $0312 : BEQ .BRANCH_GAMMA
        LDX.w $041E
        
        LDA.w $0422 : CMP.w MovingWallWestBoundaries, X : BCC .BRANCH_DELTA
            JSR.w RoomTag_AdvanceGiganticWall
            
            LDA.w $0422 : CMP.w MovingWallWestBoundaries, X : BCC .BRANCH_DELTA
                ; Play the puzzle solved sound.
                LDX.b #$1B : STX.w $012F
                
                ; "silence" ambient sfx.
                LDX.b #$05 : STX.w $012D
                
                LDX.b $0E
                
                LDY.b #$00 : STY.b $AE, X : STY.w $02E4 : STY.w $0FC1
                
                STZ.w $011A
                STZ.w $011B
                STZ.w $011C
                STZ.w $011D
        
        .BRANCH_DELTA
        
        LDX.b #$05 : STX.b $17
        
        LDA.w $0422 : AND.w #$01F8 : LSR #3 : STA.b $00
        
        LDA.w $042A : CLC : ADC.b $00 : STA.w $0116
        
        AND.w #$1020 : BEQ .BRANCH_GAMMA
            EOR.w #$0420 : STA.w $0116
    
    .BRANCH_GAMMA
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $00CA17-$00CA65 LOCAL JUMP LOCATION
RoomTag_MovingWallTorchesCheck:
{
    REP #$10
    
    LDA.w $0642 : AND.b #$00FF : BNE .ignoreTorchRequirement
        LDX.w #$0000 : STX.b $00
        
        .nextObject
        
            LDA.w $0540, X : ASL A : BCC .torchNotLit
                INC.b $00
            
            .torchNotLit
        INX #2 : CPX.w #$0020 : BNE .nextObject
        
        LDA.b $00 : CMP.w #$0004 : BCC .notEnoughTorches
        
    .ignoreTorchRequirement
    
    INC.w $041A
    
    STZ.w $0642
    
    SEP #$20
    
    LDA.b $0E : ASL A : TAX
    
    LDA.w $0403 : ORA.w DoorFlagMasks-1, X : STA.w $0403
    
    LDA.b #$07 : STA.w $012D
    
    LDA.b #$01 : STA.w $02E4 : STA.w $0FC1
    
    REP #$20
    
    .notEnoughTorches
    
    LDA.w #$0000
    
    SEP #$10
    
    RTS
}

; ==============================================================================

; $00CA66-$00CA74 LOCAL JUMP LOCATION
MovingWall_MoveALittle:
{
    LDA.w #$2200 : CLC : ADC.w $041C : STA.w $041C
    
    ROL A : AND.w #$0001
    
    RTS
}

; ==============================================================================

; $00CA75-$00CA93 LOCAL JUMP LOCATION
RoomTag_AdvanceGiganticWall:
{
    LDX.b $0E
    
    LDY.b $AE, X : CPY.b #$20 : BCS .alpha
        ; Change collision settings to default in the room.
        LDX.b #$00 : STX.w $046C
        
        ; Disable BG1
        LDX.b #$16 : STX.b $1C
    
    .alpha
    
    LDX.w $041E
    
    CPY.b #$20 : BCS .beta
        TXA : CLC : ADC.w #$0008 : TAX
    
    ; $00CA93 ALTERNATE ENTRY POINT
    .beta
    
    RTS
}

; ==============================================================================

; Routine 0x18 - turn off water
; $00CA94-$00CB19 JUMP LOCATION
RoomTag_WaterOff:
{
    LDA.w $0642 : BEQ RoomTag_AdvanceGiganticWall_beta
        ; Change window mask settings...
        LDA.b #$03 : STA.b $96
        
        STZ.b $97 : STZ.b $98
        
        ; Window masking on main screen: BG2, BG3, OBJ
        LDA.b #$16 : STA.b $1E
        
        ; Window masking on subscreen: BG1
        LDA.b #$01 : STA.b $1F
        
        LDA.b #$01 : STA.w $0424
        
        JSL.l Hdma_ConfigureWaterTable
        
        ; Change to "Turn off Water" dungeon submodule.
        LDA.b #$0B : STA.b $11
        
        LDA.b #$00 : STA.l $7EC007 : STA.l $7EC009
        
        LDA.b #$1F : STA.l $7EC00B
        
        INC.b $15
        
        LDA.b #$00 : STA.b $AF
        
        LDA.w $0403 : ORA.l DoorFlagMasks+1 : STA.w $0403
        
        STZ.w $0642
        
        REP #$30
        
        LDA.w $0682 : AND.w #$01FF : SEC : SBC.w #$0010 : ASL #4 : STA.b $08
        LDA.w $0680 : AND.w #$01FF : SEC : SBC.w #$0010 : LSR #2 : TSB.b $08
        
        LDX.b $08
        
        JSR.w RoomTag_WaterOff_AdjustWater
        JSR.w Dungeon_PrepOverlayDma_tilemapAlreadyUpdated
        
        LDY.b $0C : LDA.w #$FFFF : STA.w $1100, Y
        
        SEP #$30
        
        LDA.b #$1B : STA.w $012F
        LDA.b #$2E : STA.w $012E
        
        LDA.b #$01 : STA.b $18

        ; $00CB19 ALTERNAT ENTRY POINT
        .return
        
        RTS
}

; ==============================================================================

; Routine 0x19 - turn on water
; $00CB1A-$00CB48 JUMP LOCATION
Tag_TurnOnWater:
{
    LDA.w $0642 : BEQ RoomTag_WaterOff_return
        ; Play two sound effects together (some sound effects sound good
        ; together)
        LDA.b #$1B : STA.w $012F
        LDA.b #$2F : STA.w $012E
        
        ; Switch to dungeon submodule 0x0C
        LDA.b #$0C : STA.b $11
        
        STZ.b $B0
        
        LDA.b #$01 : STA.w $0424
        
        LDA.b #$00 : STA.b $AF
        
        LDA.w $0403 : ORA.l DoorFlagMasks+1 : STA.w $0403
        
        STZ.w $0642 : STZ.w $045C
    
    .return
    
    RTS
}

; ==============================================================================

; Routine 0x1A - watergate room
; $00CB49-$00CBFF JUMP LOCATION
Tag_Watergate:
{
    ; Ignore this routine because the water is already present
    LDA.w $0403 : AND.l DoorFlagMasks+1 : BNE Tag_TurnOnWater_return
        ; Ignore this routine until the player pulls the lever to let water
        ; enter the room.
        LDA.w $0642 : BEQ Tag_TurnOnWater_return
            LDA.b #$0D : STA.b $11
            
            STZ.b $B0
            
            ; Disable this routine now and start filling the channel with water.
            LDA.b #$00 : STA.b $AF
            
            ; Set the flag so that if we walk in here again, the water will
            ; still be in the channel (and the watergate opened). Note,
            ; however, that overworld code resets this flag when you transition
            ; to another area.
            LDA.w $0403 : ORA.l DoorFlagMasks+1 : STA.w $0403
            
            ; Reset the lever trigger
            STZ.w $0642
            
            ; Reset some hdma stuff?
            STZ.w $0684 : STZ.w $067A
            
            ; Adjust window mask settings
            LDA.b #$03 : STA.b $96
            
            STZ.b $97 : STZ.b $98
            
            LDA.b #$16 : STA.b $1E
            LDA.b #$01 : STA.b $1F
            
            LDA.b #$02 : STA.b $99
            LDA.b #$62 : STA.b $9A
            
            ; Set the overworld flags so that the LW and DW areas outside the
            ; watergate have the water emptied
            LDA.l $7EF2BB : ORA.b #$20 : STA.l $7EF2BB
            LDA.l $7EF2FB : ORA.b #$20 : STA.l $7EF2FB
            
            ; Set it so the channel is full of water next time you enter
            ; Didn't we already do this with $0403?
            LDA.l $7EF051 : ORA.b #$01 : STA.l $7EF051
            
            REP #$30
            
            ; Gear up to load water tile data from $04F1CD.
            LDA.w #$0004 : STA.b $B9
            
            LDA.w #$F1CD
            
            JSR.w Object_WatergateChannelWater
            
            REP #$30
            
            ; Get the X position of the watergate barrier (in pixels)
            LDA.w $0472 : AND.w #$007E : ASL #2 : STA.w $0680
            
            ; Make the X position grid adjusted and move it 5 tiles to the right
            ; (the watergate is 10 tiles wide, so this puts it at the midpoint).
            LDA.b $B2 : ASL #4
            CLC : ADC.w $062C
            CLC : ADC.w $0680
            CLC : ADC.w #$0028
            STA.w $0680
            
            ; Get the Y position of the watergate barrier.
            LDA.w $0472 : AND.w #$1F80 : LSR #4 : STA.w $0676 : STA.w $0678
            
            ; Make it grid adjusted.
            CLC : ADC.w $062E : STA.w $0682
            
            STZ.w $0686
            
            SEP #$30
            
            LDA.b #$1B : STA.w $012F
            LDA.b #$2F : STA.w $012E

            ; $00CBFF ALTERNATE ENTRY POINT
            .easyOut
            
            RTS
}

; ==============================================================================

; $00CC00-$00CC03 JUMP LOCATION
RoomTag_Holes0:
{
    LDA.b #$01
    
    BRA RoomTag_TriggerHoles
}

; $00CC04-$00CC07 JUMP LOCATION
RoomTag_Holes1:
{
    LDA.b #$03
    
    BRA RoomTag_TriggerHoles
} 

; $00CC08-$00CC0B JUMP LOCATION
RoomTag_Holes3:
{
    LDA.b #$06
    
    BRA RoomTag_TriggerHoles
}

; $00CC0C-$00CC0F JUMP LOCATION
RoomTag_Holes4:
{
    LDA.b #$08
    
    BRA RoomTag_TriggerHoles
}

; $00CC10-$00CC13 JUMP LOCATION
RoomTag_Holes5:
{
    LDA.b #$0A
    
    BRA RoomTag_TriggerHoles
}

; $00CC14-$00CC17 JUMP LOCATION
RoomTag_Holes6:
{
    LDA.b #$0C
    
    BRA RoomTag_TriggerHoles
}

; $00CC18-$00CC1B JUMP LOCATION
RoomTag_Holes7:
{
    LDA.b #$0E
    
    BRA RoomTag_TriggerHoles
}

; $00CC1C-$00CC1D JUMP LOCATION
RoomTag_Holes8:
{
    LDA.b #$10

    ; Bleeds into the next function.
}

; $00CC1E-$00CC5A JUMP LOCATION
RoomTag_TriggerHoles:
{
    STA.b $0A
    
    LDY.w $04BA : BNE .BRANCH_BETA
        STA.w $04BA
    
    .BRANCH_BETA
    
    REP #$30
    
    JSR.w RoomTag_CheckForPressedSwitch : BCC .BRANCH_GAMMA
        SEP #$30
        
        TYA : CLC : ADC.b $0A : CMP.w $04BA : BEQ .BRANCH_GAMMA
            STA.w $04BA
            
            STZ.b $BA
            STZ.b $BB
            STZ.b $B0
            
            ; Make the "mystery revealed" noise play.
            LDA.b #$1B : STA.w $012F
            
            ; Update the screen perhaps? (hint: chest appears, etc)
            LDA.b #$03 : STA.b $11
            
            LDA.w $04BC : EOR.b #$01 : STA.w $04BC
            
            JSL.l Dungeon_RestoreStarTileChr
    
    .BRANCH_GAMMA
    
    SEP #$30
    
    RTS
}

; $00CC5B-$00CC61 JUMP LOCATION
RoomTag_ChestHoles0:
{
    REP #$10
    
    ; Holes (0)
    LDY.w #$0000
    
    BRA RoomTag_OperateChestHoles
}

; $00CC62-$00CC66 JUMP LOCATION
RoomTag_ChestHoles8:
{
    ; Tag routine 0xCC62 (Open chest for holes)
    REP #$10
    
    ; Holes (9)
    LDY.w #$0012

    ; Bleeds into the next function.
}

; $00CC67-$00CC88 JUMP LOCATION
RoomTag_OperateChestHoles:
{
    LDA.w $0403 : AND.b #$01 : BEQ .chestNotOpened
        ; $00CC6E ALTERNATE ENTRY POINT
        .TriggerChestHoles
        
        ; Tell the "show dungeon overlay" submodule which overlay to use.
        STY.w $04BA
        
        SEP #$30
        
        STZ.b $BA
        STZ.b $BB
        STZ.b $B0
        
        ; Play "puzzle solved" sound effect
        LDA.b #$1B : STA.w $012F
        
        LDA.b #$03 : STA.b $11
        
        LDX.b $0E
        
        STZ.b $AE, X
    
    ; $00CC86 ALTERNATE ENTRY POINT
    .chestNotOpened
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $00CC89-$00CC94 JUMP LOCATION
RoomTag_Holes2:
{
    REP #$30
    
    JSR.w RoomTag_CheckForPressedSwitch : BCC RoomTag_OperateChestHoles_chestNotOpened
        LDY.w #$0005
        
        BRA RoomTag_OperateChestHoles_TriggerChestHoles
}

; ==============================================================================

; $00CC95-$00CD38 LOCAL JUMP LOCATION
Object_WatergateChannelWater:
{
    STA.b $B7
    
    STZ.b $BA
    
    .nextObjectGroup
    
        STZ.b $B2
        STZ.b $B4
        
        LDY.b $BA : LDA [$BY], Y : CMP.w #$FFFF : BNE .validObjectData
            SEP #$30
            
            RTS
        
        .validObjectData
        
        !startPos = $08
        
        ; Load a dungeon the way we normally would, but in a a more limited
        ; way (hint: it's only water objects we're drawing)
        STA.b $00
        
        SEP #$20
        
        AND.b #$FC : STA !startPos
        
        LDA.b $00 : AND.b #$03 : INC A : STA.b $B2
        LDA.b $01 : AND.b #$03 : INC A : STA.b $B4
        
        INY #3 : STY.b $BA
        
        LDA.b $01 : LSR #3 : ROR !startPos : STA.b $09
        
        REP #$20
        
        LDX !startPos
        
        LDY.w #$0110
        
        .nextRow
        
            !numRows    = $B4
            !numColumns = $0A
            
            LDA.b $B2 : STA !numColumns
            
            .move_right_for_next_block
            
                !num2x4s = $04
                
                ; This loop draws a 4 row by 4 column block of tiles
                LDA.w #$0002 : STA !num2x4s
                
                .next2x4
                
                    LDA.w RoomDrawObjectData+00, Y : STA.l $7E4000, X
                    LDA.w RoomDrawObjectData+02, Y : STA.l $7E4002, X
                    LDA.w RoomDrawObjectData+04, Y : STA.l $7E4004, X
                    LDA.w RoomDrawObjectData+06, Y : STA.l $7E4006, X
                    LDA.w RoomDrawObjectData+08, Y : STA.l $7E4080, X
                    LDA.w RoomDrawObjectData+10, Y : STA.l $7E4082, X
                    LDA.w RoomDrawObjectData+12, Y : STA.l $7E4084, X
                    LDA.w RoomDrawObjectData+14, Y : STA.l $7E4086, X
                    
                    TXA : CLC : ADC.w #$0100 : TAX
                DEC !num2x4s : BNE .next2x4
                
                TXA : SEC : SBC.w #$01F8 : TAX
            DEC !numColumns : BNE .move_right_for_next_block
            
            LDA !startPos : CLC : ADC.w #$0200 : STA !startPos : TAX
        DEC !numRows : BNE .nextRow
    JMP .nextObjectGroup
}

; ==============================================================================

; $00CD39-$00CDA4 LOCAL JUMP LOCATION
RoomTag_MaybeCheckShutters:
{
    LDA.w $02E4 : AND.w #$00FF : BNE .matchFailed
        LDA.b $4D : AND.w #$00FF : BNE .matchFailed
            JSR.w RoomTag_GetTilemapCoords
            
            LDA.l $7F2000, X
            
            CMP.w #$2323 : BEQ .partialMatch
            CMP.w #$2424 : BEQ .partialMatch
                ; Try looking on the next line
                TXA : CLC : ADC.w #$0040 : TAX
                
                LDA.l $7F2000, X
                
                CMP.w #$2323 : BEQ .partialMatch
                CMP.w #$2424 : BEQ .partialMatch
                    INC.b $00
                    
                    LDX.b $00
                    
                    LDA.l $7F2000, X
                    
                    CMP.w #$2323 : BEQ .partialMatch
                    CMP.w #$2424 : BEQ .partialMatch
                        TXA : CLC : ADC.w #$0040 : TAX
                        
                        LDA.l $7F2000, X
                        
                        CMP.w #$2323 : BEQ .partialMatch
                        CMP.w #$2424 : BNE .matchFailed
            
            .partialMatch
            
            CMP.l $7F2040, X : BNE .matchFailed
                STA.b $0C
                
                STX.w $04B6
                
                SEC
                
                RTS
    
    ; $00CDA0 ALTERNATE ENTRY POINT
    .matchFailed
    
    STZ.w $04B6
    
    CLC
    
    RTS
}

; ==============================================================================

; $00CDA5-$00CDCB LOCAL JUMP LOCATION
RoomTag_GetTilemapCoords:
{
    LDA.b $22 : CLC : ADC.w #$FFFF : AND.w #$01F8 : LSR #3 : STA.b $00
    LDA.b $20 : CLC : ADC.w #$000E : AND.w #$01F8 : ASL #3 : ORA.b $00
    
    LDX.b $EE : BEQ .onBG2
        ORA.w #$1000
    
    .onBG2
    
    STA.b $00 : TAX
    
    RTS
}

; ==============================================================================

!star_tiles = $3B3B

; $00CDCC-$00CE5B LOCAL JUMP LOCATION
RoomTag_CheckForPressedSwitch:
{
    LDA.w $02E4 : AND.w #$00FF : BNE RoomTag_MaybeCheckShutters_matchFailed
        LDA.b $4D : AND.w #$00FF : BNE RoomTag_MaybeCheckShutters_matchFailed
            JSR.w RoomTag_GetTilemapCoords
            
            LDY.w #$0000
            
            LDA.l $7F2000, X
            
            CMP.w #$2323 : BEQ .partialMatch
            CMP.w #$3A3A : BEQ .partialMatch
                INY
                
                ; Star tiles
                CMP.w #!star_tiles : BEQ .partialMatch
                    ; Check the two tiles below
                    TXA : CLC : ADC.w #$0040 : TAX
                    
                    LDY.w #$0000
                    
                    LDA.l $7F2000, X
                    
                    CMP.w #$2323 : BEQ .partialMatch
                    CMP.w #$3A3A : BEQ .partialMatch
                        INY
                        
                        CMP.w #!star_tiles : BEQ .partialMatch
                            INC.b $00
                            
                            LDX.b $00
                            
                            LDY.w #$0000
                            
                            LDA.l $7F2000, X
                            
                            CMP.w #$2323 : BEQ .partialMatch
                            CMP.w #$3A3A : BEQ .partialMatch
                                INY
                                
                                CMP.w #!star_tiles : BEQ .partialMatch
                                    TXA : CLC : ADC.w #$0040 : TAX
                                    
                                    LDY.w #$0000
                                    
                                    LDA.l $7F2000, X
                                    
                                    CMP.w #$2323       : BEQ .partialMatch
                                    CMP.w #$3A3A       : BEQ .partialMatch
                                        CMP.w #!star_tiles : BNE .matchFailed
                                            INY
                        
            .partialMatch
            
            CMP.l $7F2040, X : BNE .matchFailed
                STA.b $0C
                
                STX.w $04B6
                
                SEC
                
                RTS
            
            .matchFailed
            
            STZ.w $04B6
            
            CLC
            
            RTS
}

; ==============================================================================

; $00CE5C-$00CE63 DATA
CorrespondingDoorOpeningDirection:
{
    dw $0002
    dw $0000
    dw $0006
    dw $0004
}

; $00CE64-$00CE6B DATA
VineDoorGFXOffset:
{
    dw $07EA
    dw $080A
    dw $080A
    dw $082A
}
    
; $00CE6C-$00CE6F DATA
DoorOpenSFXPan:
{
    db $00, $00, $80, $40
}
    
; ==============================================================================

; $00CE70-$00CFE9 LONG JUMP LOCATION
Dungeon_ProcessTorchAndDoorInteractives:
{
    LDA.b $1A : AND.b #$03 : BNE .skip_torch_logic
        ; Is there a custom animation in progress (e.g. medallion spells)
        LDA.w $0112 : BNE .skip_torch_logic
            LDX.b #$00
            
            .next_torch
            
                ; Count down the torch timers
                ; If timer is zero...
                LDA.w $04F0, X : BEQ .torch_already_out
                    DEC.w $04F0, X : BNE .torch_still_lit
                        ; Tells us which torch to put out...
                        PHX
                        
                        TXA : ORA.b #$C0 : STA.w $0333
                        
                        JSL.l Dungeon_ExtinguishTorch
                        
                        PLX
                    
                    .torch_already_out
                .torch_still_lit
            ; Move on to the next torch.
            INX : CPX.b #$10 : BNE .next_torch
    
    .skip_torch_logic
    
    LDA.w $02E4 : BEQ .player_not_immobilized
        JMP.w DontOpenDoor
    
    .player_not_immobilized
    
    REP #$21
    
    ; Which direction is the player facing?
    LDA.b $2F : AND.w #$00FF : STA.b $08 : TAY
    
    ; Note, data bank here is apparently $00, not $01
    LDA.b $20
          ADC.w DetectStaircase_offset_y, Y : AND.w #$01F8 : ASL #3 : STA.b $00

    LDA.b $22
    CLC : ADC.w DetectStaircase_offset_x, Y : AND.w #$01F8 : LSR #3 : ORA.b $00
    
    ; Based on what floor Link is on, we look at a specific tile.
    LDX.b $EE : BEQ .player_on_bg2
        ORA.w #$1000
    
    .player_on_bg2
    
    REP #$10
    
    TAX
    
    ; Is the tile above me a locked big key door tile?
    ; Yes...
    LDA.l $7F2000, X : AND.w #$00F0 : CMP.w #$00F0 : BEQ .is_openable_door
        ; Is the one to the right of it a locked big key door tile?
        TXA : CLC : ADC.w DetectStaircase_index_offset, Y : TAX
        
        ; No...
        LDA.l $7F2000, X : AND.w #$00F0 : CMP.w #$00F0 : BNE .not_openable_door
    
    .is_openable_door
    
    LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY : STY.w $0694
    
    LDA.w $19C0, Y : AND.w #$0003 : ASL A : CMP.b $08 : BNE .not_openable_door
        ; Check if it's a breakable wall
        LDA.w $1980, Y : AND.w #$00FE
        
        CMP.w #$0028 : BEQ .is_breakable_wall
            CMP.w #$001C : BEQ .isSmallKeyDoor ; Is it a small key door?
                CMP.w #$001E : BNE .notBigKeyDoor ; Is it a big key door?
                    STZ.w $0690
                    
                    STX.w $068E
                    
                    LDY.w $040C
                    
                    ; Check which big keys we have and check it against the big
                    ; key slot for this dungeon. Branch if we find a matching
                    ; key.
                    LDA.l $7EF366 : AND.w DungeonMask, Y : BNE .haveKeyToOpenDoor
                        ; Means the "eh..." message has activated, and we
                        ; haven't moved away from the door
                        LDA.w $04B8 : BNE .skipDoorProcessing
                            ; Otherwise, set that flag.
                            INC.w $04B8
                            
                            ; Set up message $007A (in text mode 0xE of course)
                            LDA.w #$007A : STA.w $1CF0
                            
                            SEP #$30
                            
                            JSL.l Main_ShowTextMessage
                            
                            REP #$30
                        
                        .skipDoorProcessing
                        
                        JMP.w DontOpenDoor
                
                .not_openable_door
                
                STZ.w $04B8
                
                JMP.w DontOpenDoor
        
            .notBigKeyDoor
            
            CMP.w #$001C : BCC .skipDoorProcessing
            CMP.w #$002C : BCS .skipDoorProcessing
            CMP.w #$002A : BEQ .skipDoorProcessing
        
        .isSmallKeyDoor
        
        LDA.l $7EF36F : AND.w #$00FF : BEQ .skipDoorProcessing
        
            LDA.l $7EF36F : DEC A : STA.l $7EF36F
            
            .haveKeyToOpenDoor
            
            STZ.w $0690
            
            ; Store the tilemap address ???
            STX.w $068E
            
            SEP #$30
            
            ; Go to submode 0x04.
            LDA.b #$04 : STA.b $11
            
            LDA.b #$14 : STA.b $00
            
            LDX.w $0694
            
            LDA.w $19C0, X : AND.b #$03 : TAX
            
            ; Play a sound effect because the door opened.
            LDA.l DoorOpenSFXPan, X : ORA.b $00 : STA.w $012F
            
            RTL
    
    .is_breakable_wall
    
    LDA.w $0372 : AND.w #$00FF : BEQ .notDashing
        LDA.w $02F1 : CMP.w #$003F : BCS .notDashing
        
        STX.w $068E
        
        SEP #$30
        
        STY.b $00
        
        JSL.l AddDoorDebris : BCS .BRANCH_OMICRON
            LDY.b $00
            
            LDA.w $19C0, Y : AND.b #$03 : STA.w $03BE, X
            
            TXA : ASL A : TAX
            
            REP #$20
            
            LDA.w $19A0, Y : AND.w #$007E : ASL #2
            CLC : ADC.w $062C : STA.w $03B6, X
            LDA.w $19A0, Y : AND.w #$1F80 : LSR #4
            CLC : ADC.w $062E : STA.w $03BA, X
        
        .BRANCH_OMICRON
        
        SEP #$30
        
        LDA.b #$1B : STA.w $012F
        
        LDA.b #$09 : STA.b $11
        
        JSL.l Sprite_RepelDashAttackLong
        
        .BRANCH_TAU
        
        RTL

    .notDashing

    ; Bleeds into the next function.
}

; $00CFEA-$00D1E2 JUMP LOCATION
DontOpenDoor:
{    
    SEP #$30
    
    ; No... invisible door? Trap door? What? TODO: Part of another task
    ; Once $0436 is documented, we should know what logic would be
    ; skipped. Eye doors? wtf is this?
    LDA.w $0436 : BMI .BRANCH_PI
        LDA.b $6C : BNE .BRANCH_PI
            ; HARDCODED: Checking by room? wtf man.
            LDA.b $23 : CMP.b #$0C : BNE .BRANCH_PI
                LDY.w $0437
                
                LDX.w $0436 : CPX.b $2F : BEQ .BRANCH_RHO
                    LDA.b $2F : CMP.l CorrespondingDoorOpeningDirection, X : BNE .BRANCH_RHO
                        REP #$20
                        
                        LDA.w $068C : ORA.w DungeonMask, Y
                        
                        BRA .BRANCH_SIGMA
                
                .BRANCH_RHO
                
                REP #$20
                
                LDA.w $068C : AND.w DungeonMaskInverted, Y
                
                .BRANCH_SIGMA
                
                CMP.w $068C : BEQ .BRANCH_PI
                    STA.w $068C
                    
                    STZ.b $0C
                    
                    REP #$10
                    
                    LDA.w $0437 : AND.w #$00FF : TAY
                    
                    JSR.w DrawEyeWatchDoor
                    JSR.w Dungeon_PrepOverlayDma_nextPrep
                    
                    LDY.w $0460
                    
                    JSR.w Dungeon_LoadToggleDoorAttr_from_parameter
                    
                    LDY.b $0C
                    
                    LDA.w #$FFFF : STA.w $1100, Y
                    
                    SEP #$30
                    
                    LDA.b #$01 : STA.b $18
                    
                    LDA.b #$15 : STA.w $012F
                    
                    RTL
        
    .BRANCH_PI
    
    SEP #$30
    
    LDA.b $3A : ASL A : BCC Dungeon_ProcessTorchAndDoorInteractives_BRANCH_TAU
    
        LDA.b $3C : CMP.b #$04 : BNE Dungeon_ProcessTorchAndDoorInteractives_BRANCH_TAU
        
            ; I think.... this is checking for a sword slashable door?
            ; TODO: Find out how we get in here.
            REP #$31
            
            LDA.b $44 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_UPSILON
                ORA.w #$FF00
            
            .BRANCH_UPSILON
            
            CLC : ADC.b $20 : AND.w #$01F8 : ASL #3 : STA.b $00
            
            LDA.b $45 : AND.w #$00FF : CMP.w #$0080 : BCC .BRANCH_PHI
                ORA.w #$FF00
            
            .BRANCH_PHI
            
            CLC : ADC.b $22 : AND.w #$01F8 : LSR #3 : ORA.b $00 : TAX
            
            LDY.w #$0041
            
            ; Checking for dash breakable wall? Not sure that I buy that, but
            ; it's a possibility.
            LDA.l $7F2000, X : AND.w #$00FC : CMP.w #$006C : BEQ .BRANCH_CHI
                AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_CHI
                    INX
                    
                    DEY
                    
                    LDA.l $7F2000, X : AND.w #$00FC : CMP.w #$006C : BEQ .BRANCH_CHI
                        AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_CHI
                        
                        TXA : CLC : ADC.w #$003F : TAX
                        
                        LDY.w #$0001
                        
                        LDA.l $7F2000, X : AND.w #$00FC : CMP.w #$006C : BEQ .BRANCH_CHI
                            AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_CHI
                            
                            INX
                            
                            DEY
                            
                            LDA.l $7F2000, X : AND.w #$00FC : CMP.w #$006C : BEQ .BRANCH_CHI
                                AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_CHI
                                    SEP #$30
                                    
                                    RTL
            
            .BRANCH_CHI
            
            STZ.b $0C
            
            CMP.w #$006C : BEQ .BRANCH_PSI
                JMP .not_vines
            
            .BRANCH_PSI
            
            STY.b $0E : CPY.w #$0040 : BCC .BRANCH_OMEGA
                TYA : AND.w #$000F : STA.b $0E
                
                TXA : SEC : SBC.w #$0040 : TAX
                
                LDA.l $7F2000, X : AND.w #$00FC : CMP.w #$006C : BEQ .BRANCH_OMEGA
                    TXA : CLC : ADC.w #$0040 : TAX
            
            .BRANCH_OMEGA
            
            LDY.b $0E : BEQ .BRANCH_ALTIMA 
                DEX
                
                LDA.l $7F2000, X : AND.w #$00FC : CMP.w #$006C : BEQ .BRANCH_ALTIMA
                    INX
            
            .BRANCH_ALTIMA
            
            TXA : SEC : SBC.w #$0041 : ASL A : STA.b $08
            
            LDA.l $7F2000, X : PHA
            
            LDA.w #$0202 : STA.l $7F2000, X : STA.l $7F2040, X
            
            PLA : AND.w #$0003 : ASL A : TAX
            
            LDA.l VineDoorGFXOffset, X : TAY
            
            LDX.b $08
            
            LDA.w #$0004 : STA.b $0E
            
            .next_column
            
                LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
                LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
                LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
                LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
                
                TYA : CLC : ADC.w #$0008 : TAY
                
                INX #2
            DEC.b $0E : BNE .next_column
            
            BRA .BRANCH_OPTIMUS
            
            ; $00D18A ALTERNATE ENTRY POINT
            .not_vines
            
            LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY
            
            STX.w $068E
            
            LDA.w $1980, Y : AND.w #$00FE
            CMP.w #$0032 : BNE RoomDraw_CloseStripes_BRANCH_ALIF
                SEP #$20
                
                LDA.b #$1B : STA.w $012F
                
                REP #$20
                
                LDA.w $19A0, Y : STA.b $08
                
                TYX
                
                LDA.w $068C : ORA.w DungeonMask, X : STA.w $068C
                
                LDA.w $0400 : ORA.w DungeonMask, X : STA.w $0400
                
                STZ.w $0692
                
                JSR.w IndexAndClearCurtainDoor
                
                LDY.w $0460
                
                JSR.w Dungeon_LoadToggleDoorAttr_from_parameter
                
                .BRANCH_OPTIMUS
                
                JSR.w Dungeon_PrepOverlayDma_nextPrep
                
                SEP #$30
                
                LDA.b $08 : AND.b #$7F : ASL A
                
                JSL.l Sound_GetFineSfxPan
                
                ORA.b #$1E : STA.w $012E
                
                REP #$30

    ; Bleeds into the next function.
}

; $00D1E3-$00D1F3 JUMP LOCATION
RoomDraw_CloseStripes:
{
    LDY.b $0C
    
    ; Finalizes the buffer for the future DMA transfer.
    LDA.w #$FFFF : STA.w $1100, Y
    
    SEP #$30
    
    ; Sets it up so that during NMI, the screen will update.
    LDA.b #$01 : STA.b $18
    
    .BRANCH_ALIF
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; Check for cracked floors and expose bombable floor if necessary
; $00D1F4-$00D2C8 LONG JUMP LOCATION
Bomb_CheckForVulnerableTileObjects:
{
    LDA.b $10 : CMP.b #$07 : BEQ .indoors
        JML Overworld_ApplyBombToTiles
    
    .indoors
    
    STZ.b $0F
    
    REP #$30
    
    LDA.b $00 : AND.w #$01F8 : ASL #3 : STA.b $04
    LDA.b $02 : AND.w #$01F8 : LSR #3 : ORA.b $04
    
    ; After computing result move up two tiles and one to the left
    SEC : SBC.w #$0082 : TAX
    
    LDY.w #$0002
    
    .BRANCH_DELTA
    
        ; Look for cracked floors
        LDA.l $7F2000, X : AND.w #$00FF : CMP.w #$0062 : BEQ .BRANCH_BETA
            ; Bombable walls
            AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_GAMMA
                INX #2
                
                ; Cracked floor again
                LDA.l $7F2000, X : AND.w #$00FF : CMP.w #$0062 : BEQ .BRANCH_BETA
                    ; Bombable walls
                    AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_GAMMA
                        INX #2
                        
                        LDA.l $7F2000, X : AND.w #$00FF : CMP.w #$0062 : BEQ .BRANCH_BETA
                            AND.w #$00F0 : CMP.w #$00F0 : BEQ .BRANCH_GAMMA
            
        TXA : CLC : ADC.w #$007C : TAX
    DEY : BPL .BRANCH_DELTA
          BMI .BRANCH_EPSILON
        .BRANCH_BETA
        
        JMP.w BlowOpenBombableFloor
        
        .BRANCH_GAMMA
        
        LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY
        
        ; This whole section is about bombable doors, so it needs to draw a door
        ; This handles the various kinds of tiles that will get replaced in a
        ; bombing.
        LDA.w $1980, Y : AND.w #$00FE : CMP.w #$0028 : BEQ .BRANCH_ZETA
            CMP.w #$002A : BEQ .BRANCH_ZETA
                CMP.w #$002E : BNE .BRANCH_EPSILON
        
        .BRANCH_ZETA
        
        STX.w $068E
        
        LDA.b $0E : ASL A : TAX
        
        LDA.w $19A0, Y : AND.w #$007E : ASL #2
        CLC : ADC.w $062C : STA.w $03B6, X
        LDA.w $19A0, Y : AND.w #$1F80 : LSR #4 
        CLC : ADC.w $062E : STA.w $03BA, X

        SEP #$20

        LDX.b $0E

        LDA.w $19C0, Y : AND.b #$03 : STA.w $03BE, X

        ; Play a "puzzle solved" noise
        LDA.b #$1B : STA.w $012F

        ; Put us in bombing open a door submodule
        LDA.b #$09 : STA.b $11

    .BRANCH_EPSILON

    SEP #$30

    RTL
}

; ==============================================================================

; $00D2C9-$00D2E7 JUMP LOCATION (LONG)
BlowOpenBombableFloor:
{
    ; HARDCODED: Obviously.
    LDA.b $A0 : CMP.w #$0065 : BNE .not_room_above_blind
        LDA.w $0402 : ORA.w #$1000 : STA.w $0402
    
    .not_room_above_blind
    
    LDA.w #$0000
    
    JSL.l Dungeon_CustomIndexedRevealCoveredTiles
    
    SEP #$30
    
    LDA.b #$1B : STA.w $012F
    
    RTL
}

; ==============================================================================

; $00D2E8-$00D310 LOCAL JUMP LOCATION
DrawDoorOpening_Step1:
{
    LDX.w $19A0, Y : STX.b $08
    
    STY.w $0460
    STY.w $0694
    
    LDA.w $19C0, Y : AND.w #$0003 : BNE .not_up
        JMP.w DoorDoorStep1_North
    
    .not_up
    
    CMP.w #$0001 : BNE .not_down
        JMP.w DoorDoorStep1_South
    
    .not_down
    
    CMP.w #$0002 : BNE .not_left
        JMP.w DoorDoorStep1_West
    
    .not_left
    
    ; Must be right then, directionally...
    JMP.w DoorDoorStep1_East
}

; ==============================================================================

; $00D311-$00D339 LOCAL JUMP LOCATION
DrawShutterDoorSteps:
{
    ; Load door's tilemap address
    LDX.w $19A0, Y : STX.b $08
    
    ; Store its position in the door arrays.
    STY.w $0460
    STY.w $0694
    
    LDA.w $19C0, Y : AND.w #$0003 : BNE .not_up
        JMP.w GetDoorDrawDataIndex_North_clean_door_index
    
    .not_up
    
    CMP.w #$0001 : BNE .not_down

        JMP.w GetDoorDrawDataIndex_South_clean_door_index
    
    .not_down
    
    CMP.w #$0002 : BNE .not_left
        JMP.w GetDoorDrawDataIndex_West_clean_door_index
    
    .not_left
    
    ; The direction must be to the right then.
    JMP.w GetDoorDrawDataIndex_East_clean_door_index
}

; ==============================================================================

; $00D33A-$00D364 LOCAL JUMP LOCATION
DrawEyeWatchDoor:
{
    LDX.w $19A0, Y : STX.b $08
    
    STY.w $0460
    STY.b $04
    STY.w $0694
    
    LDA.w $19C0, Y : AND.w #$0003 : BNE .not_up
        JMP.w DrawDoorToTilemap_North
    
    .not_up
    
    CMP.w #$0001 : BNE .not_down
        JMP.w DrawDoorToTilemap_South
    
    .not_down
    
    CMP.w #$0002 : BNE .not_left
        JMP.w DrawDoorToTilemap_West
    
    .not_left
    
    JMP.w DrawDoorToTilemap_East
}

; ==============================================================================

; $00D365-$00D372 LOCAL JUMP LOCATION
IndexAndClearCurtainDoor:
{
    LDX.w $19A0, Y : STX.b $08
    
    STY.w $0460 : STY.w $0694
    
    JMP.w ClearDoorCurtainsFromTilemap
}

; ==============================================================================

; $00D373-$00D38E LOCAL JUMP LOCATION
IndexAndClearExplodingWall:
{
    STZ.w $045E
    STZ.b $0C
    STZ.w $0690
    
    LDY.w $0456 : STY.w $0460
    
    LDX.w $19A0, Y
    
    DEX #2 : STX.b $08
    
    TXA : STA.w $19A0, Y
    
    JMP.w ClearExplodingWallFromTilemap
}

; ==============================================================================

; Invoked from Module 0x07.0x05
; Variables:
; Y seems to be used as the animation state for the door?
; It's selected by logic, of course.
; $00D38F-$00D468 LONG JUMP LOCATION
Dungeon_AnimateTrapDoors:
{
    REP #$30
    
    STZ.b $0C
    
    INC.w $0690
    
    LDA.w $0690
    
    LDY.w $0468 : BNE .trap_doors_are_down
        INY #2
        
        ; Shut the door halfway
        CMP.w #$0004 : BEQ .begin_tile_animation_logic
            INY #2
            
            ; Shut the door all the way.
            CMP.w #$0008 : BEQ .begin_tile_animation_logic
                .no_tile_animation_this_frame
                
                JMP .tile_animation_complete
    
    .trap_doors_are_down
    
    LDY.w #$0002
    
    CMP.w #$0004 : BEQ .begin_tile_animation_logic
        DEY #2
        
        CMP.w #$0008 : BNE .no_tile_animation_this_frame
    
    .begin_tile_animation_logic
    
    ; Y = ...
    ; 0x00 - fully open
    ; 0x02 - half open
    ; 0x04 - fully shut
    STY.w $0692
    
    ; This means we're going to iterate over all doors (almost).
    LDY.w #$0000
    
    .check_next_door
    
    STY.w $068E
    
    LDA.w $1980, Y : AND.w #$00FE
    
    CMP.w #$0044 : BEQ .is_trap_door
        CMP.w #$0018 : BNE .aint_trap_door
            .is_trap_door
            
            ; TODO: I think the name of this branch has it backwards... find
            ; out.
            LDA.w $0468 : BNE .rising_trap_doors
                LDA.w $068C : AND.w DungeonMask, Y : BNE .BRANCH_EPSILON
                    LDA.w $0690 : CMP.w #$0008 : BNE .BRANCH_THETA
                        PHY
                        
                        SEP #$30
                        
                        LDA.b #$15 : STA.w $012F
                        
                        REP #$30
                        
                        PLY
                        
                        LDA.w $068C : ORA.w DungeonMask, Y
                        
                        BRA .BRANCH_IOTA
                
            .rising_trap_doors
            
            LDA.w $068C : AND.w DungeonMask, Y : BEQ .BRANCH_EPSILON
                LDA.w $0690 : CMP.w #$0008 : BNE .BRANCH_THETA
                    PHY
                    
                    SEP #$30
                    
                    LDA.b #$16 : STA.w $012F
                    
                    REP #$30
                    
                    PLY
                    
                    LDA.w $068C : AND.w DungeonMaskInverted, Y
                    
                    .BRANCH_IOTA
                    
                    STA.w $068C
                
                .BRANCH_THETA
                
                ; Called in opening and closing doors.
                JSR.w DrawShutterDoorSteps

                JSR.w Dungeon_PrepOverlayDma_nextPrep
                
                LDA.w $0690 : CMP.w #$0008 : BNE .BRANCH_EPSILON
                    LDY.w $068E
                    
                    JSR.w Dungeon_LoadToggleDoorAttr_from_parameter
            
            .BRANCH_EPSILON
    .aint_trap_door
    
    LDY.w $068E : INY #2 : CPY.w #$0018 : BEQ .done_checking_for_trap_doors
        JMP .check_next_door
    
    .done_checking_for_trap_doors
    
    LDY.b $0C : BEQ .BRANCH_LAMBDA
        LDA.w #$FFFF : STA.w $1100, Y
        
        SEP #$30
        
        LDA.b #$01 : STA.b $18 : STA.w $0710
        
        .tile_animation_complete
        
        SEP #$20
        
        ; Check if we're finished opening / closing trap doors.
        LDA.w $0690 : CMP.b #$10 : BNE .not_finished_animating
    
    .BRANCH_LAMBDA
    
    SEP #$20
    
    STZ.b $11
    STZ.b $18
    
    .not_finished+_animating
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $00D469-$00D475 LONG JUMP LOCATION
Dungeon_AnimateDestroyingWeakDoor:
{
    REP #$30
    
    LDA.w #$0010 : STA.w $0690
    
    LDY.w #$0004
    
    BRA Dungeon_AnimateOpeningLockedDoor_set_event_flags
}

; (Door opening)
; $00D476-$00D50F ALTERNATE ENTRY POINT
Dungeon_AnimateOpeningLockedDoor:
{
    REP #$30
    
    LDY.w #$0002
    
    INC.w $0690
    
    LDA.w $0690 : CMP.w #$0004 : BEQ .halfOpenDoor
        INY #2
        
        CMP.w #$000C : BNE .dont_set_flags_yet
            .set_event_flags
            
            LDX.w $068E
            
            LDA.l $7F2000, X : AND.w #$0007 : ASL A : TAX
            
            LDA.w $068C : ORA.w DungeonMask, X : STA.w $068C
            LDA.w $0400 : ORA.w DungeonMask, X : STA.w $0400
            
    .halfOpenDoor
    
    ; Y = 0x02 or 0x04
    STY.w $0692
    
    STZ.b $0C
    
    LDX.w $068E
    
    LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY
    
    JSR.w DrawDoorOpening_Step1
    JSR.w Dungeon_PrepOverlayDma_nextPrep
    
    LDY.b $0C
    
    LDA.w #$FFFF : STA.w $1100, Y
    
    SEP #$30
    
    LDA.b #$15 : STA.w $012F
    
    LDA.b #$01 : STA.b $18
    
    REP #$30
    
    .dont_set_flags_yet
    
    LDA.w $0690 : CMP.w #$0010 : BNE .notFullyOpen
        ; Blow open bombable wall, open key door.
        JSR.w Dungeon_LoadToggleDoorAttr
        
        LDX.w $068E
        
        LDA.l $7F2000, X : AND.w #$00FF : CMP.w #$00F0 : BCC .notKeyDoor
            AND.w #$000F : ASL A : TAY
            
            LDA.w $1980, Y : AND.w #$00FF
            
            CMP.w #$0020 : BCC .notKeyDoor
            CMP.w #$0028 : BCS .notKeyDoor
                ; Handles special key doors that hide spiral staircases
                JSR.w Object_RefreshStaircaseAttr
        
        .notKeyDoor
        
        SEP #$20
        
        STZ.b $11
    
    .notFullyOpen
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $00D510-$00D5A9 LOCAL JUMP LOCATION
Dungeon_LoadToggleDoorAttr:
{
    LDX.w $068E
    
    LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY

    ; $00D51C ALTERNATE ENTRY POINT
    .from_parameter

    JSR.w Dungeon_LoadSingleDoorAttr
    
    ; $00D51F ALTERNATE ENTRY POINT
    .extern
    
    ; Do attributes for floor toggling doors (doors that toggle which
    ; floor the player is on).
    LDX.w $044E : BEQ .doneWithFloorToggleDoors
        LDY.w #$0000
        
        .nextFloorToggleDoor
        
                LDX.w $06C0, Y
                
                LDA.l $7F2000, X : AND.w #$00F0 : CMP.w #$0080 : BNE .skipFloorToggleDoor
                    LDA.l $7F2000, X : ORA.w #$1010
                    STA.l $7F2000, X : STA.l $7F2040, X
            INY #2 : CPY.w $044E : BNE .nextFloorToggleDoor
            
            BRA .doneWithFloorToggleDoors
            
            .skipFloorToggleDoor
            
            LDA.l $7F3000, X : ORA.w #$1010
            STA.l $7F3000, X : STA.l $7E3040, X
        INY #2 : CPY.w $044E : BNE .nextFloorToggleDoor
    
    .doneWithFloorToggleDoors
    
    ; Do attributes for type 0x14 doors? (dungeon toggling doors)
    LDX.w $0450 : BEQ .return
        LDY.w #$0000
        
        .nextPalaceToggleDoor
        
                LDX.w $06D0, Y
                
                ; If not on BG2, see if there's an open door here on BG1
                LDA.l $7F2000, X : AND.w #$00F0 : CMP.w #$0080 : BNE .tryBG1
                    ; BG2 tile attributes
                    LDA.l $7F2000, X : ORA.w #$2020
                    STA.l $7F2000, X : STA.l $7F2040, X
            INY #2 : CPY.w $0450 : BNE .nextPalaceToggleDoor
            
            BRA .return
            
            .tryBG1
            
            ; BG1 tile attributes
            LDA.l $7F3000, X : ORA.w #$2020 
            STA.l $7F3000, X : STA.l $7E3040, X
        INY #2 : CPY.w $0450 : BNE .nextPalaceToggleDoor
    
    .return
    
    RTS
}

; $00D5AA-$00D6C0 LOCAL JUMP LOCATION
Object_RefreshStaircaseAttr:
{
    LDA.w #$3030 : STA.b $00
    
    LDY.w #$0000
    
    LDX.w $0438 : BEQ .noInFloorUpStaircases
        .nextStaircase
        
            LDA.b $00 : CLC : ADC.w #$0101 : STA.b $00
            
            INY #2
        CPY.w $0438 : BNE .nextStaircase
    
    .noInFloorUpStaircases
    
    CPY.w $047E : BEQ .noSpiralUpStaircasesBG2
        .nextStaircase2
        
            LDX.w $06B0, Y
            
            LDA.w #$5E5E : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
            
            LDA.w #$0000 : STA.l $7F2081, X : STA.l $7F20C1, X
        INY #2 : CPY.w $047E : BNE .nextStaircase2
    
    .noSpiralUpStaircasesBG2
    
    CPY.w $0482 : BEQ .noSpiralUpStaircasesBG1
        .nextStaircase3
        
            LDX.w $06B0, Y
            
            LDA.w #$5F5F : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
            
            LDA.w #$0000 : STA.l $7F2081, X : STA.l $7F20C1, X
        INY #2 : CPY.w $0482 : BNE .nextStaircase3
    
    .noSpiralUpStaircasesBG1
    
    CPY.w $04A2 : BEQ .noInWallUpNorthStraightStaircases
        .nextStaircase4
        
            LDA.b $00 : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $04A2 : BNE .nextStaircase4
        
    .noInWallUpNorthStraightStaircases
    
    CPY.w $04A4 : BEQ .noInWallUpSouthStraightStaircases
        .nextStaircase5
        
            LDA.b $00 : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $04A4 : BNE .nextStaircase5
    
    .noInWallupSouthStraightStaircases
    
    LDA.b $00 : AND.b #$0707 : ORA.b #$3434 : STA.b $00
    
    CPY.w $043A : BEQ .noInFloorDownSouthStaircases
        .nextStaircase6
        
            LDA.b $00 : CLC : ADC.w #$0101 : STA.b $00
        INY #2 : CPY.w $043A : BNE .nextStaircase6

    .noInFloorDownSouthStaircases
    
    CPY.w $0480 : BEQ .noDownNorthSpiralStaircasesBG2
        .nextStaircase7
        
            LDX.w $06B0, Y
            
            LDA.w #$5E5E : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X : CLC : ADC.w #$0101 : STA.b $00
            
            LDA.w #$0000 : STA.l $7F2081, X : STA.l $7F20C1, X
        INY #2 : CPY.w $0480 : BNE .nextStaircase7
    
    .noDownNorthSpiralStaircasesBG2
    
    CPY.w $0484 : BEQ .noDownNorthSpiralStaircasesBG1
        .nextStaircase8
        
            LDX.w $06B0, Y
            
            LDA.w #$5F5F : STA.l $7F2001, X
            
            LDA.b $00 : STA.l $7F2041, X
            CLC : ADC.w #$0101 : STA.b $00
            
            LDA.w #$0000 : STA.l $7F2081, X : STA.l $7F20C1, X
        INY #2 : CPY.w $0484 : BNE .nextStaircase8
    
    .noDownNorthSpiralStaircasesBG1
    
    RTS
}

; ==============================================================================

; $00D6C1-$00D747 LONG JUMP LOCATION
Door_BlastWallExploding:
{
    ; Compare with $7F0000? .... well that's confusing
    LDA.b #$06 : STA.w $02E4 : STA.w $0FC1 : CMP.l $7F0000 : BNE .BRANCH_ALPHA
        REP #$30
        
        JSR.w IndexAndClearExplodingWall
        JSR.w ClearAndStripeExplodingWall
        
        LDA.w #$FFFF : STA.w $1100, Y : STA.w $0710
        
        INC.w $0454 : INC.w $0454
        
        LDA.w $0454 : CMP.w #$0015 : BNE .notDoneExploding
            LDY.w $0456
            
            LDA.w $068C : ORA.w DungeonMask, Y : STA.w $068C
            
            LDA.w $0400 : ORA.w DungeonMask, Y : STA.w $0400
            
            LDX.w #$0001
            
            LDA.w $19C0, Y : LDY.w #$0100 : AND.w #$0002 : BEQ .BRANCH_GAMMA
                LDY.w #$0001
                
                DEX
                
            .BRANCH_GAMMA
            
            TYA : ORA.w $0452 : STA.w $0452
            
            LDA.b $A6, X : ORA.w #$0002 : STA.b $A6, X
            
            LDA.b $A6 : STA.l $7EC19C
            
            LDY.w $0456
            
            JSR.w Door_LoadBlastWallAttr
            
            STZ.w $0454
            STZ.w $0456
            
            SEP #$30
            
            JSL.l Dungeon_SaveRoomQuadrantData
            
            STZ.w $02E4
            STZ.w $0FC1
        
        .notDoneExploding
        
        SEP #$30
        
        LDA.b #$03 : STA.b $18
    
    .BRANCH_ALPHA
    
    RTL
}

; ==============================================================================

; $00D748-$00D7BF LONG JUMP LOCATION
Dungeon_QueryIfTileLiftable:
{
    REP #$30
    
    ; What direction is player facing?
    LDA.b $2F : AND.w #$00FF : TAX
    
    LDA.b $20 : CLC : ADC.l Pool_Dungeon_RevealCoveredTiles_y_offsets, X
    AND.w #$01F8 : ASL #3 : STA.b $06
    
    ; All this rigamarole is to find the position of this tile's data in
    ; memory.
    LDA.b $22 : CLC : ADC.l Pool_Dungeon_RevealCoveredTiles_x_offsets, X
    AND.w #$01F8 : LSR #3 : ORA.b $06 : STA.b $06
    
    LDA.b $EE : AND.w #$00FF : BEQ .on_bg2
        ; If its on a higher floor (layer) just add 0x1000 to the address.
        LDA.b $06 : ORA.w #$1000 : STA.b $06
    
    .on_bg2
    
    LDX.b $06
    
    ; Um... I'm guessing it's checking to see if it's a pot or bush.
    LDA.l $7F2000, X : AND.w #$00F0 : CMP.w #$0070 : BNE .not_liftable
        LDA.l $7F2000, X : AND.w #$000F : ASL A : TAX
        
        ; Means the tile looks like a pot, but has no replacement tile and thus
        ; can't be picked up
        LDA.w $0500, X : BEQ .not_liftable
            LDY.w #$0055
            
            AND.w #$F0F0 : CMP.w #$2020 : BEQ .large_block
                LDA.w $0500, X : AND.w #$000F : ASL A : TAX
                
                LDA.l Pool_Dungeon_RevealCoveredTiles_tile_01d9e0, X : TAY
            
            .large_block
            
            TYA
            
            ; Note that here we're also setting the carry flag.
            SEP #$31
            
            RTL
    
    .not_liftable
    
    LDX.b $06
    
    LDA.l $7F2000, X
    
    SEP #$30
    
    CLC
    
    RTL
}

; ==============================================================================

; $00D7C0-$00D7C7 DATA
PushBlock_Main_move_distances:
{
    dw -256, 256, -4, 4
}
    
; $00D7C8-$00D827 JUMP LOCATION
PushBlock_Main:
{
    .check_for_active_block
    
        LDA.w $0500, Y : BEQ .next_block
            CMP.w #$0001 : BNE .not_block_phase_1
                JSR.w Dungeon_EraseInteractive2x2
                
                ; Move the block's tilemap position 2 tiles in the
                ; appropriate direction.
                LDX.w $0474
                LDA.w $0540, Y : CLC : ADC .move_distances, X : STA.w $0540, Y
                
                BRA .increment_object_state
            
            .not_block_phase_1
            
            CMP.w #$0002 : BNE .not_block_phase_2
                SEP #$30
                
                JSL.l PushBlock_Slide
                
                REP #$30
                
                LDY.w $042C
                
                LDA.w $0500, Y : CMP.w #$0003 : BNE .next_block
                    JSR.w PushBlock_StoppedMoving
                    
                    BRA .increment_object_state
            
            .not_block_phase_2
            
            CMP.w #$0004 : BNE .next_block
                SEP #$20
                
                JSL.l PushBlock_HandleFalling
                
                BRA .next_block
                
                .increment_object_state
                
                LDX.w $042C
                
                INC.w $0500, X
        
        .next_block
        
        INC.w $042C : INC.w $042C
        
        ; $00D81B MAIN ENTRY POINT
        .PushBlock_Handler
        
        REP #$30
    LDY.w $042C : CPY.w $0478 : BNE .check_for_active_block
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $00D828-$00D8D3 LOCAL JUMP LOCATION
Dungeon_EraseInteractive2x2:
{
    LDX.w $1000
    
    LDA.w $0560, Y : STA.w $1006, X
    LDA.w $0580, Y : STA.w $100C, X
    LDA.w $05A0, Y : STA.w $1012, X
    LDA.w $05C0, Y : STA.w $1018, X
    
    LDA.w $0540, Y : AND.w #$3FFF : TAX
    
    LDA.w $0560, Y : STA.l $7E2000, X
    LDA.w $0580, Y : STA.l $7E2080, X
    LDA.w $05A0, Y : STA.l $7E2002, X
    LDA.w $05C0, Y : STA.l $7E2082, X : AND.w #$03FF : TAX
    
    LDA.l $7EFE00, X : AND.w #$00FF : STA.b $00 : STA.b $01
    
    LDA.w $0540, Y : AND.w #$3FFF : LSR A : TAX
    
    LDA.b $00
    
    ; $00D87F ALTERNATE ENTRY POINT
    .partially_prepped
    
    STA.l $7F2000, X : STA.l $7F2040, X
    
    LDX.w $1000
    LDA.w #$0000
    JSR.w Dungeon_GetInteractiveVramAddr
    
    STA.w $1002, X
    LDA.w #$0080
    JSR.w Dungeon_GetInteractiveVramAddr
    
    STA.w $1008, X
    LDA.w #$0002
    JSR.w Dungeon_GetInteractiveVramAddr
    
    STA.w $100E, X
    LDA.w #$0082
    JSR.w Dungeon_GetInteractiveVramAddr
    
    STA.w $1014, X
    
    LDA.w #$0100
    STA.w $1004, X : STA.w $100A, X
    STA.w $1010, X : STA.w $1016, X
    
    LDA.w #$FFFF : STA.w $101A, X
    
    TXA : CLC : ADC.w #$0018 : STA.w $1000
    
    SEP #$20
    
    ; A dma transfer should trigger during the next frame that will
    ; update the 4 tilemap entries we have indicated in VRAM.
    LDA.b #$01 : STA.b $14
    
    REP #$30
    
    RTS
}

; ==============================================================================

; $00D8D4-$00D98D LOCAL JUMP LOCATION
PushBlock_StoppedMoving:
{
    LDA.w $0540, Y : AND.w #$4000 : BNE .blockTriggersSomething
        LDA.w $0641 : EOR.w #$0001 : STA.w $0641
    
    .blockTriggersSomething
    
    LDA.w $0540, Y : AND.w #$3FFF : LSR A : TAX
    
    ; Check if the block landed on a pit tile.
    LDA.l $7F2000, X : AND.w #$00FF : CMP.w #$0020 : BEQ .blockFellIntoPit
        PHA : PHY : PHX
        
        LDX.w $1000
        
        ; Doing preliminary work to update the tilemap with the rematerializing
        ; block that has since moved by 2 tiles in some direction.
        LDA.w #$0922 : STA.w $1006, X : INC A : STA.w $1012, X
        LDA.w #$0932 : STA.w $100C, X : INC A : STA.w $1018, X
        
        LDA.w $0540, Y : AND.w #$3FFF : TAX
        
        LDA.w #$0922 : STA.l $7E2000, X : INC A : STA.l $7E2002, X
        LDA.w #$0932 : STA.l $7E2080, X : INC A : STA.l $7E2082, X
        
        SEP #$20
        
        STY.b $72
        
        LDX.w #$0001
        
        LDA.w $05FC, X : DEC A : ASL A : CMP.b $72 : BEQ .correct_index
            LDX.w #$0000
        
        .correct_index
        
        ; The block has rematerialized, we no longer need to indicate that this
        ; object is active, so terminate it.
        STZ.w $05FC, X
        
        REP #$20
        
        PLX : PLY : PLA
        
        CMP.w #$0023 : BNE .didnt_land_on_switch
            LDA.w $0468 : EOR.w #$0001 : STA.w $0466
            
            LDA.w #$0004
            
            BRA .set_block_state
        
        .didnt_land_on_switch
        
        LDA.w #$FFFF
        
        .set_block_state
        
        STA.w $0500, Y
        LDA.w #$2727
        JMP Dungeon_EraseInteractive2x2_partially_prepped
    
    .blockFellIntoPit
    
    SEP #$20
    
    ; Play a dropping sound effect?
    LDA.b #$20 : STA.w $012E
    
    REP #$20
    
    LDY.w $042C
    
    LDX.w $0520, Y
    
    ; Load the room destination for warp/pits.
    ; (This code is for the ice palace dungeon)
    ; Set the block as being in that room now.
    LDA.l $7EC000 : AND.w #$00FF : STA.l $7EF940, X
    
    ; Set its new position.
    LDA.w $0540, Y : STA.l $7EF942, X
    
    RTS
}

; ==============================================================================

; $00D98E-$00D9B9 LOCAL JUMP LOCATION
Dungeon_GetInteractiveVramAddr:
{
    !tile_offset = $0E
    
    STA !tile_offset
    
    LDA.w $0540, Y : AND.w #$3FFF : CLC : ADC !tile_offset : STA !tile_offset
    
                       AND.w #$0040 : LSR #4 : XBA       : STA.b $00
    LDA !tile_offset : AND.w #$303F : LSR A  : ORA.b $00 : STA.b $00
    LDA !tile_offset : AND.w #$0F80 : LSR #2 : ORA.b $00 : XBA
    
    RTS
}

; ==============================================================================

; $00D9BA-$00D9EB DATA
Pool_Dungeon_RevealCoveredTiles:
{
    ; $00D9BA
    .y_offsets
    dw   3 ; Up
    dw  24 ; Down
    dw  14 ; Left
    dw  14 ; Right
    
    ; $00D9C2
    .x_offsets
    dw   7 ; Up
    dw   7 ; Down
    dw  -3 ; Left
    dw  16 ; Right
    
    ; $00D9CA
    ; Seems to be UNUSED: ...
    .unused
    dw $0000, $FFFE, $FF80, $FF7E
    dw $0000, $0000, $FF80, $FF80
    dw $0000, $FFFE, $0000, $FFFE
    
    ; $00D9E2
    .tile_01d9e0
    dw $5252 ; Hammer pegs
    dw $5050 ; Pots
    dw $5454
    dw $0000
    dw $2323
}
    
; Secrets
; $00D9EC-$00DA70 LONG JUMP LOCATION
Dungeon_RevealCoveredTiles:
{
    REP #$30
    
    LDA.b $2F : AND.w #$00FF : TAX
    
    ; Tells us how far to look from Link's sprite in the Y direction (either
    ; positive or negative depending on the direciton he's currently facing
    LDA.b $20
    CLC : ADC.l Pool_Dungeon_RevealCoveredTiles_y_offsets, X : STA.b $00 : STA.b $C8
    
    ; Mask to increments of 8 in coordinate (one tile)
    AND.w #$01F8 : ASL #3 : STA.b $06
    
    ; Do the same thing for the X direction.
    LDA.b $22
    CLC : ADC.l Pool_Dungeon_RevealCoveredTiles_x_offsets, X
    STA.b $02 : STA.b $CA
    
    ; Mask to increments of 8 in coordinate (one tile)
    ; $06 = 0000yyyy yyxxxxxx
    AND.w #$01F8 : LSR #3 : TSB.b $06
    
    ; See what floor Link is on
    LDA.b $EE : AND.w #$00FF : BEQ .on_bg2
        LDA.b $06 : ORA.w #$1000 : STA.b $06
    
    .on_bg2
    
    LDX.b $06
    
    ; Examine the tile type at this target location
    LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY
    
    ; Check replaceable tile attributes
    ; See if they're in the 0x10 to 0x1F range (I think?)
    LDA.w $0500, Y : AND.w #$F0F0 : CMP.w #$1010 : BNE .not_pot_tiles
        ; If so, push the replaceable tile attributes to the stack.
        LDA.w $0500, Y : PHA
        
        ; Store this offset into $0500, Y and $0540, Y for later use
        STY.w $042C
        
        LDA.w $0540, Y
        
        JSR.w Dungeon_LoadSecret
        
        LDY.w $042C
        
        JSR.w Dungeon_EraseInteractive2x2
        
        PLA : AND.w #$000F : ASL A : TAX
        
        LDA.l Pool_Dungeon_RevealCoveredTiles_tile_01d9e0, X : STA.b $06
        
        BRA .BRANCH_GAMMA
    
    .not_pot_tiles
    
    CMP.w #$2020 : BNE Pool_Dungeon_ToolAndTileInteraction
        LDA.w $0500, Y : AND.w #$000F : ASL A : STA.b $00
        
        TYA : SEC : SBC.b $00

    ; Bleeds into the next function.
}
    
; $00DA71-$00DAB5 JUMP LOCATION
Dungeon_CustomIndexedRevealCoveredTiles:
{
    STA.w $042C : PHA : TAY
    
    PHY
    
    LDA.w $0540, Y
    
    JSR.w Dungeon_LoadSecret
    
    PLY
    
    JSR.w Dungeon_EraseInteractive2x2
    
    INC.w $042C : INC.w $042C : LDY.w $042C
    
    JSR.w Dungeon_EraseInteractive2x2
    
    INC.w $042C : INC.w $042C : LDY.w $042C
    
    JSR.w Dungeon_EraseInteractive2x2
    
    INC.w $042C : INC.w $042C : LDY.w $042C
    
    JSR.w Dungeon_EraseInteractive2x2
    
    LDA.w #$5555 : STA.b $06
    
    PLA : STA.w $042C
    
    .BRANCH_GAMMA
    
    JSR.w Dungeon_GetUprootedTerrainSpawnCoords
    
    LDA.b $06
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $00DAB6-$00DABA JUMP LOCATION
Dungeon_ToolAndTileInteraction_easy_out:
{
    SEP #$30
    
    LDA.b #$00
    
    RTL
}

; $00DABB-$00DB40 JUMP LOCATION
Dungeon_ToolAndTileInteraction:
{
    !pot_tile  = $1010
    !mole_tile = $4040
    
    REP #$30
    
    ; Only tool that dungeons check for is the hammer (for smashing pots).
    LDA.w $0301 : AND.w #$0002 : BEQ Dungeon_ToolAndTileInteraction_easy_out
        LDA.b $00 : AND.w #$01F8 : ASL #3 : ADC.b $02 : STA.b $06
        
        LDA.b $EE : AND.w #$00FF : BEQ .on_bg2
            LDA.b $06 : ORA.w #$1000 : STA.b $06
        
        .on_bg2
        
        LDX.b $06
        
        LDA.l $7F2000, X : AND.w #$00F0 : CMP.w #$0070 : BNE .easy_out
            LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY
            
            LDA.w $0500, Y : AND.w #$F0F0 : CMP.w #$4040 : BNE .not_mole
                LDA.w $0500, Y : PHA
                
                STY.w $042C
                
                JSR.w Dungeon_EraseInteractive2x2
                
                PLA
                
                SEP #$30
                
                LDA.b #$11 : STA.w $012E
                
                LDA.b #$00
                
                RTL
            
            .not_mole
            
            CMP.w #$1010 : BNE .easy_out
                STY.w $042C
                
                LDA.w $0540, Y
                
                JSR.w Dungeon_LoadSecret
                
                LDY.w $042C
                
                JSR.w Dungeon_EraseInteractive2x2
                JSR.w Dungeon_GetUprootedTerrainSpawnCoords
                
                SEP #$30
                
                LDA.w $0B9C : ORA.b #$80 : STA.w $0B9C
                
                LDA.b #$01
                
                JSL.l Sprite_SpawnImmediatelySmashedTerrain
                JML AddDisintegratingBushPoof
}

; ==============================================================================

; $00DB41-$00DB68 LOCAL JUMP LOCATION
Dungeon_GetUprootedTerrainSpawnCoords:
{
    LDY.w $042C
    
    LDA.w $0540, X : PHA
    
    AND.w #$007E : ASL #2 : STA.b $00
    
    ; Since the sprite is instantiating because of the player, it makes
    ; sense to use their upper coordinate bytes as a guide...
    
    LDA.b $22 : AND.w #$FE00 : TSB.b $00
    
    PLA : AND.w #$1F80 : ASL A : XBA : ASL #3 : STA.b $02
    
    LDA.b $20 : AND.w #$FE00 : TSB.b $02
    
    RTS
}

; ==============================================================================

; $00DB69-$00DDE8 DATA
RoomData_PotItems_Pointers:
{
    dw RoomData_PotItems_Room0000
    dw RoomData_PotItems_Room0001
    dw RoomData_PotItems_Room0002
    dw RoomData_PotItems_Room0003
    dw RoomData_PotItems_Room0004
    dw RoomData_PotItems_Room0005
    dw RoomData_PotItems_Room0006
    dw RoomData_PotItems_Room0007
    dw RoomData_PotItems_Room0008
    dw RoomData_PotItems_Room0009
    dw RoomData_PotItems_Room000A
    dw RoomData_PotItems_Room000B
    dw RoomData_PotItems_Room000C
    dw RoomData_PotItems_Room000D
    dw RoomData_PotItems_Room000E
    dw RoomData_PotItems_Room000F
    dw RoomData_PotItems_Room0010
    dw RoomData_PotItems_Room0011
    dw RoomData_PotItems_Room0012
    dw RoomData_PotItems_Room0013
    dw RoomData_PotItems_Room0014
    dw RoomData_PotItems_Room0015
    dw RoomData_PotItems_Room0016
    dw RoomData_PotItems_Room0017
    dw RoomData_PotItems_Room0018
    dw RoomData_PotItems_Room0019
    dw RoomData_PotItems_Room001A
    dw RoomData_PotItems_Room001B
    dw RoomData_PotItems_Room001C
    dw RoomData_PotItems_Room001D
    dw RoomData_PotItems_Room001E
    dw RoomData_PotItems_Room001F
    dw RoomData_PotItems_Room0020
    dw RoomData_PotItems_Room0021
    dw RoomData_PotItems_Room0022
    dw RoomData_PotItems_Room0023
    dw RoomData_PotItems_Room0024
    dw RoomData_PotItems_Room0025
    dw RoomData_PotItems_Room0026
    dw RoomData_PotItems_Room0027
    dw RoomData_PotItems_Room0028
    dw RoomData_PotItems_Room0029
    dw RoomData_PotItems_Room002A
    dw RoomData_PotItems_Room002B
    dw RoomData_PotItems_Room002C
    dw RoomData_PotItems_Room002D
    dw RoomData_PotItems_Room002E
    dw RoomData_PotItems_Room002F
    dw RoomData_PotItems_Room0030
    dw RoomData_PotItems_Room0031
    dw RoomData_PotItems_Room0032
    dw RoomData_PotItems_Room0033
    dw RoomData_PotItems_Room0034
    dw RoomData_PotItems_Room0035
    dw RoomData_PotItems_Room0036
    dw RoomData_PotItems_Room0037
    dw RoomData_PotItems_Room0038
    dw RoomData_PotItems_Room0039
    dw RoomData_PotItems_Room003A
    dw RoomData_PotItems_Room003B
    dw RoomData_PotItems_Room003C
    dw RoomData_PotItems_Room003D
    dw RoomData_PotItems_Room003E
    dw RoomData_PotItems_Room003F
    dw RoomData_PotItems_Room0040
    dw RoomData_PotItems_Room0041
    dw RoomData_PotItems_Room0042
    dw RoomData_PotItems_Room0043
    dw RoomData_PotItems_Room0044
    dw RoomData_PotItems_Room0045
    dw RoomData_PotItems_Room0046
    dw RoomData_PotItems_Room0047
    dw RoomData_PotItems_Room0048
    dw RoomData_PotItems_Room0049
    dw RoomData_PotItems_Room004A
    dw RoomData_PotItems_Room004B
    dw RoomData_PotItems_Room004C
    dw RoomData_PotItems_Room004D
    dw RoomData_PotItems_Room004E
    dw RoomData_PotItems_Room004F
    dw RoomData_PotItems_Room0050
    dw RoomData_PotItems_Room0051
    dw RoomData_PotItems_Room0052
    dw RoomData_PotItems_Room0053
    dw RoomData_PotItems_Room0054
    dw RoomData_PotItems_Room0055
    dw RoomData_PotItems_Room0056
    dw RoomData_PotItems_Room0057
    dw RoomData_PotItems_Room0058
    dw RoomData_PotItems_Room0059
    dw RoomData_PotItems_Room005A
    dw RoomData_PotItems_Room005B
    dw RoomData_PotItems_Room005C
    dw RoomData_PotItems_Room005D
    dw RoomData_PotItems_Room005E
    dw RoomData_PotItems_Room005F
    dw RoomData_PotItems_Room0060
    dw RoomData_PotItems_Room0061
    dw RoomData_PotItems_Room0062
    dw RoomData_PotItems_Room0063
    dw RoomData_PotItems_Room0064
    dw RoomData_PotItems_Room0065
    dw RoomData_PotItems_Room0066
    dw RoomData_PotItems_Room0067
    dw RoomData_PotItems_Room0068
    dw RoomData_PotItems_Room0069
    dw RoomData_PotItems_Room006A
    dw RoomData_PotItems_Room006B
    dw RoomData_PotItems_Room006C
    dw RoomData_PotItems_Room006D
    dw RoomData_PotItems_Room006E
    dw RoomData_PotItems_Room006F
    dw RoomData_PotItems_Room0070
    dw RoomData_PotItems_Room0071
    dw RoomData_PotItems_Room0072
    dw RoomData_PotItems_Room0073
    dw RoomData_PotItems_Room0074
    dw RoomData_PotItems_Room0075
    dw RoomData_PotItems_Room0076
    dw RoomData_PotItems_Room0077
    dw RoomData_PotItems_Room0078
    dw RoomData_PotItems_Room0079
    dw RoomData_PotItems_Room007A
    dw RoomData_PotItems_Room007B
    dw RoomData_PotItems_Room007C
    dw RoomData_PotItems_Room007D
    dw RoomData_PotItems_Room007E
    dw RoomData_PotItems_Room007F
    dw RoomData_PotItems_Room0080
    dw RoomData_PotItems_Room0081
    dw RoomData_PotItems_Room0082
    dw RoomData_PotItems_Room0083
    dw RoomData_PotItems_Room0084
    dw RoomData_PotItems_Room0085
    dw RoomData_PotItems_Room0086
    dw RoomData_PotItems_Room0087
    dw RoomData_PotItems_Room0088
    dw RoomData_PotItems_Room0089
    dw RoomData_PotItems_Room008A
    dw RoomData_PotItems_Room008B
    dw RoomData_PotItems_Room008C
    dw RoomData_PotItems_Room008D
    dw RoomData_PotItems_Room008E
    dw RoomData_PotItems_Room008F
    dw RoomData_PotItems_Room0090
    dw RoomData_PotItems_Room0091
    dw RoomData_PotItems_Room0092
    dw RoomData_PotItems_Room0093
    dw RoomData_PotItems_Room0094
    dw RoomData_PotItems_Room0095
    dw RoomData_PotItems_Room0096
    dw RoomData_PotItems_Room0097
    dw RoomData_PotItems_Room0098
    dw RoomData_PotItems_Room0099
    dw RoomData_PotItems_Room009A
    dw RoomData_PotItems_Room009B
    dw RoomData_PotItems_Room009C
    dw RoomData_PotItems_Room009D
    dw RoomData_PotItems_Room009E
    dw RoomData_PotItems_Room009F
    dw RoomData_PotItems_Room00A0
    dw RoomData_PotItems_Room00A1
    dw RoomData_PotItems_Room00A2
    dw RoomData_PotItems_Room00A3
    dw RoomData_PotItems_Room00A4
    dw RoomData_PotItems_Room00A5
    dw RoomData_PotItems_Room00A6
    dw RoomData_PotItems_Room00A7
    dw RoomData_PotItems_Room00A8
    dw RoomData_PotItems_Room00A9
    dw RoomData_PotItems_Room00AA
    dw RoomData_PotItems_Room00AB
    dw RoomData_PotItems_Room00AC
    dw RoomData_PotItems_Room00AD
    dw RoomData_PotItems_Room00AE
    dw RoomData_PotItems_Room00AF
    dw RoomData_PotItems_Room00B0
    dw RoomData_PotItems_Room00B1
    dw RoomData_PotItems_Room00B2
    dw RoomData_PotItems_Room00B3
    dw RoomData_PotItems_Room00B4
    dw RoomData_PotItems_Room00B5
    dw RoomData_PotItems_Room00B6
    dw RoomData_PotItems_Room00B7
    dw RoomData_PotItems_Room00B8
    dw RoomData_PotItems_Room00B9
    dw RoomData_PotItems_Room00BA
    dw RoomData_PotItems_Room00BB
    dw RoomData_PotItems_Room00BC
    dw RoomData_PotItems_Room00BD
    dw RoomData_PotItems_Room00BE
    dw RoomData_PotItems_Room00BF
    dw RoomData_PotItems_Room00C0
    dw RoomData_PotItems_Room00C1
    dw RoomData_PotItems_Room00C2
    dw RoomData_PotItems_Room00C3
    dw RoomData_PotItems_Room00C4
    dw RoomData_PotItems_Room00C5
    dw RoomData_PotItems_Room00C6
    dw RoomData_PotItems_Room00C7
    dw RoomData_PotItems_Room00C8
    dw RoomData_PotItems_Room00C9
    dw RoomData_PotItems_Room00CA
    dw RoomData_PotItems_Room00CB
    dw RoomData_PotItems_Room00CC
    dw RoomData_PotItems_Room00CD
    dw RoomData_PotItems_Room00CE
    dw RoomData_PotItems_Room00CF
    dw RoomData_PotItems_Room00D0
    dw RoomData_PotItems_Room00D1
    dw RoomData_PotItems_Room00D2
    dw RoomData_PotItems_Room00D3
    dw RoomData_PotItems_Room00D4
    dw RoomData_PotItems_Room00D5
    dw RoomData_PotItems_Room00D6
    dw RoomData_PotItems_Room00D7
    dw RoomData_PotItems_Room00D8
    dw RoomData_PotItems_Room00D9
    dw RoomData_PotItems_Room00DA
    dw RoomData_PotItems_Room00DB
    dw RoomData_PotItems_Room00DC
    dw RoomData_PotItems_Room00DD
    dw RoomData_PotItems_Room00DE
    dw RoomData_PotItems_Room00DF
    dw RoomData_PotItems_Room00E0
    dw RoomData_PotItems_Room00E1
    dw RoomData_PotItems_Room00E2
    dw RoomData_PotItems_Room00E3
    dw RoomData_PotItems_Room00E4
    dw RoomData_PotItems_Room00E5
    dw RoomData_PotItems_Room00E6
    dw RoomData_PotItems_Room00E7
    dw RoomData_PotItems_Room00E8
    dw RoomData_PotItems_Room00E9
    dw RoomData_PotItems_Room00EA
    dw RoomData_PotItems_Room00EB
    dw RoomData_PotItems_Room00EC
    dw RoomData_PotItems_Room00ED
    dw RoomData_PotItems_Room00EE
    dw RoomData_PotItems_Room00EF
    dw RoomData_PotItems_Room00F0
    dw RoomData_PotItems_Room00F1
    dw RoomData_PotItems_Room00F2
    dw RoomData_PotItems_Room00F3
    dw RoomData_PotItems_Room00F4
    dw RoomData_PotItems_Room00F5
    dw RoomData_PotItems_Room00F6
    dw RoomData_PotItems_Room00F7
    dw RoomData_PotItems_Room00F8
    dw RoomData_PotItems_Room00F9
    dw RoomData_PotItems_Room00FA
    dw RoomData_PotItems_Room00FB
    dw RoomData_PotItems_Room00FC
    dw RoomData_PotItems_Room00FD
    dw RoomData_PotItems_Room00FE
    dw RoomData_PotItems_Room00FF
    dw RoomData_PotItems_Room0100
    dw RoomData_PotItems_Room0101
    dw RoomData_PotItems_Room0102
    dw RoomData_PotItems_Room0103
    dw RoomData_PotItems_Room0104
    dw RoomData_PotItems_Room0105
    dw RoomData_PotItems_Room0106
    dw RoomData_PotItems_Room0107
    dw RoomData_PotItems_Room0108
    dw RoomData_PotItems_Room0109
    dw RoomData_PotItems_Room010A
    dw RoomData_PotItems_Room010B
    dw RoomData_PotItems_Room010C
    dw RoomData_PotItems_Room010D
    dw RoomData_PotItems_Room010E
    dw RoomData_PotItems_Room010F
    dw RoomData_PotItems_Room0110
    dw RoomData_PotItems_Room0111
    dw RoomData_PotItems_Room0112
    dw RoomData_PotItems_Room0113
    dw RoomData_PotItems_Room0114
    dw RoomData_PotItems_Room0115
    dw RoomData_PotItems_Room0116
    dw RoomData_PotItems_Room0117
    dw RoomData_PotItems_Room0118
    dw RoomData_PotItems_Room0119
    dw RoomData_PotItems_Room011A
    dw RoomData_PotItems_Room011B
    dw RoomData_PotItems_Room011C
    dw RoomData_PotItems_Room011D
    dw RoomData_PotItems_Room011E
    dw RoomData_PotItems_Room011F
    dw RoomData_PotItems_Room0120
    dw RoomData_PotItems_Room0121
    dw RoomData_PotItems_Room0122
    dw RoomData_PotItems_Room0123
    dw RoomData_PotItems_Room0124
    dw RoomData_PotItems_Room0125
    dw RoomData_PotItems_Room0126
    dw RoomData_PotItems_Room0127
    dw RoomData_PotItems_Room0128
    dw RoomData_PotItems_Room0129
    dw RoomData_PotItems_Room012A
    dw RoomData_PotItems_Room012B
    dw RoomData_PotItems_Room012C
    dw RoomData_PotItems_Room012D
    dw RoomData_PotItems_Room012E
    dw RoomData_PotItems_Room012F
    dw RoomData_PotItems_Room0130
    dw RoomData_PotItems_Room0131
    dw RoomData_PotItems_Room0132
    dw RoomData_PotItems_Room0133
    dw RoomData_PotItems_Room0134
    dw RoomData_PotItems_Room0135
    dw RoomData_PotItems_Room0136
    dw RoomData_PotItems_Room0137
    dw RoomData_PotItems_Room0138
    dw RoomData_PotItems_Room0139
    dw RoomData_PotItems_Room013A
    dw RoomData_PotItems_Room013B
    dw RoomData_PotItems_Room013C
    dw RoomData_PotItems_Room013D
    dw RoomData_PotItems_Room013E
    dw RoomData_PotItems_Room013F
}

; $00DDE9-$00E6B2 DATA
RoomData_PotItems:
{
    ; $00DDE9
    .Room0000
    .Room0001
    .Room0002
    .Room0003
    dw $FFFF

    ; $00DDEB
    .Room0004
    dw $13CC : db $0A ; Bomb        xyz:{ 0x130, 0x130, U }
    dw $13F0 : db $0A ; Bomb        xyz:{ 0x1C0, 0x130, U }

    ; $00DDF1
    .Room0005
    .Room0006
    .Room0007
    .Room0008
    dw $FFFF

    ; $00DDF3
    .Room0009
    dw $040C : db $01 ; Green rupee xyz:{ 0x030, 0x040, U }
    dw $0430 : db $0B ; Heart       xyz:{ 0x0C0, 0x040, U }
    dw $0C0C : db $88 ; Switch      xyz:{ 0x030, 0x0C0, U }
    dw $FFFF

    ; $00DDFE
    .Room000A
    dw $0860 : db $0B ; Heart       xyz:{ 0x180, 0x080, U }
    dw $0868 : db $0B ; Heart       xyz:{ 0x1A0, 0x080, U }
    dw $0BCC : db $88 ; Switch      xyz:{ 0x130, 0x0B0, U }
    dw $119C : db $0A ; Bomb        xyz:{ 0x070, 0x110, U }
    dw $11A0 : db $09 ; 5 arrows    xyz:{ 0x080, 0x110, U }
    dw $FFFF

    ; $00DE0F
    .Room000B
    dw $03CA : db $0A ; Bomb        xyz:{ 0x128, 0x030, U }
    dw $0CCA : db $0A ; Bomb        xyz:{ 0x128, 0x0C0, U }

    ; $00DE15
    .Room000C
    .Room000D
    .Room000E
    .Room000F
    .Room0010
    dw $FFFF

    ; $00DE17
    .Room0011
    dw $0F90 : db $0B ; Heart       xyz:{ 0x040, 0x0F0, U }
    dw $0FA0 : db $0B ; Heart       xyz:{ 0x080, 0x0F0, U }
    dw $1390 : db $0B ; Heart       xyz:{ 0x040, 0x130, U }
    dw $13A0 : db $0B ; Heart       xyz:{ 0x080, 0x130, U }

    ; $00DE23
    .Room0012
    .Room0013
    .Room0014
    dw $FFFF

    ; $00DE25
    .Room0015
    dw $0460 : db $0A ; Bomb        xyz:{ 0x180, 0x040, U }
    dw $0464 : db $0C ; Small magic xyz:{ 0x190, 0x040, U }
    dw $0468 : db $0B ; Heart       xyz:{ 0x1A0, 0x040, U }
    dw $046C : db $0C ; Small magic xyz:{ 0x1B0, 0x040, U }
    dw $0470 : db $09 ; 5 arrows    xyz:{ 0x1C0, 0x040, U }
    dw $060C : db $01 ; Green rupee xyz:{ 0x030, 0x060, U }
    dw $0610 : db $09 ; 5 arrows    xyz:{ 0x040, 0x060, U }
    dw $0614 : db $07 ; Blue rupee  xyz:{ 0x050, 0x060, U }
    dw $0B46 : db $0D ; Full magic  xyz:{ 0x118, 0x0B0, U }
    dw $FFFF

    ; $00DE42
    .Room0016
    dw $03BC : db $0B ; Heart       xyz:{ 0x0F0, 0x030, U }
    dw $03C0 : db $0B ; Heart       xyz:{ 0x100, 0x030, U }
    dw $04BC : db $0C ; Small magic xyz:{ 0x0F0, 0x040, U }
    dw $04C0 : db $0C ; Small magic xyz:{ 0x100, 0x040, U }
    dw $05BC : db $09 ; 5 arrows    xyz:{ 0x0F0, 0x050, U }
    dw $05C0 : db $09 ; 5 arrows    xyz:{ 0x100, 0x050, U }
    dw $06BC : db $0A ; Bomb        xyz:{ 0x0F0, 0x060, U }
    dw $06C0 : db $0A ; Bomb        xyz:{ 0x100, 0x060, U }
    dw $13F0 : db $08 ; Small key   xyz:{ 0x1C0, 0x130, U }
    dw $FFFF

    ; $00DE5F
    .Room0017
    dw $0D64 : db $0B ; Heart       xyz:{ 0x190, 0x0D0, U }
    dw $0E64 : db $0B ; Heart       xyz:{ 0x190, 0x0E0, U }
    dw $0F64 : db $0B ; Heart       xyz:{ 0x190, 0x0F0, U }
    dw $1064 : db $0B ; Heart       xyz:{ 0x190, 0x100, U }
    dw $1164 : db $0B ; Heart       xyz:{ 0x190, 0x110, U }
    dw $1264 : db $0B ; Heart       xyz:{ 0x190, 0x120, U }
    dw $0D68 : db $0B ; Heart       xyz:{ 0x1A0, 0x0D0, U }
    dw $0E68 : db $0B ; Heart       xyz:{ 0x1A0, 0x0E0, U }
    dw $0F68 : db $0B ; Heart       xyz:{ 0x1A0, 0x0F0, U }
    dw $1068 : db $0B ; Heart       xyz:{ 0x1A0, 0x100, U }
    dw $1168 : db $0B ; Heart       xyz:{ 0x1A0, 0x110, U }
    dw $1268 : db $0B ; Heart       xyz:{ 0x1A0, 0x120, U }

    ; $00DE83
    .Room0018
    .Room0019
    dw $FFFF

    ; $00DE85
    .Room001A
    dw $051C : db $0A ; Bomb        xyz:{ 0x070, 0x050, U }
    dw $0520 : db $0A ; Bomb        xyz:{ 0x080, 0x050, U }
    dw $1B1C : db $0A ; Bomb        xyz:{ 0x070, 0x1B0, U }
    dw $1B20 : db $0A ; Bomb        xyz:{ 0x080, 0x1B0, U }
    dw $FFFF

    ; $00DE93
    .Room001B
    dw $1714 : db $09 ; 5 arrows    xyz:{ 0x050, 0x170, U }
    dw $1728 : db $09 ; 5 arrows    xyz:{ 0x0A0, 0x170, U }

    ; $00DE99
    .Room001C
    .Room001D
    dw $FFFF

    ; $00DE9B
    .Room001E
    dw $0954 : db $0A ; Bomb        xyz:{ 0x150, 0x090, U }
    dw $FFFF

    ; $00DEA0
    .Room001F
    dw $191C : db $88 ; Switch      xyz:{ 0x070, 0x190, U }

    ; $00DEA3
    .Room0020
    dw $FFFF

    ; $00DEA5
    .Room0021
    dw $18A8 : db $0C ; Small magic xyz:{ 0x0A0, 0x180, U }
    dw $1C30 : db $0B ; Heart       xyz:{ 0x0C0, 0x1C0, U }
    dw $1C52 : db $0C ; Small magic xyz:{ 0x148, 0x1C0, U }

    ; $00DEAE
    .Room0022
    dw $FFFF

    ; $00DEB0
    .Room0023
    dw $1A56 : db $01 ; Green rupee xyz:{ 0x158, 0x1A0, U }
    dw $1A5A : db $0B ; Heart       xyz:{ 0x168, 0x1A0, U }
    dw $1A5E : db $01 ; Green rupee xyz:{ 0x178, 0x1A0, U }
    dw $1A62 : db $0A ; Bomb        xyz:{ 0x188, 0x1A0, U }
    dw $1A66 : db $01 ; Green rupee xyz:{ 0x198, 0x1A0, U }
    dw $FFFF

    ; $00DEC1
    .Room0024
    dw $040C : db $07 ; Blue rupee  xyz:{ 0x030, 0x040, U }
    dw $0430 : db $0B ; Heart       xyz:{ 0x0C0, 0x040, U }
    dw $0C0C : db $0C ; Small magic xyz:{ 0x030, 0x0C0, U }
    dw $0C30 : db $01 ; Green rupee xyz:{ 0x0C0, 0x0C0, U }

    ; $00DECD
    .Room0025
    dw $FFFF

    ; $00DECF
    .Room0026
    dw $041C : db $0A ; Bomb        xyz:{ 0x070, 0x040, U }
    dw $080C : db $0C ; Small magic xyz:{ 0x030, 0x080, U }
    dw $1396 : db $88 ; Switch      xyz:{ 0x058, 0x130, U }
    dw $1A16 : db $07 ; Blue rupee  xyz:{ 0x058, 0x1A0, U }
    dw $1ADC : db $09 ; 5 arrows    xyz:{ 0x170, 0x1A0, U }
    dw $FFFF

    ; $00DEE0
    .Room0027
    dw $14A6 : db $0A ; Bomb        xyz:{ 0x098, 0x140, U }
    dw $15D6 : db $0B ; Heart       xyz:{ 0x158, 0x150, U }
    dw $1C28 : db $01 ; Green rupee xyz:{ 0x0A0, 0x1C0, U }
    dw $1C2C : db $01 ; Green rupee xyz:{ 0x0B0, 0x1C0, U }
    dw $1C50 : db $07 ; Blue rupee  xyz:{ 0x140, 0x1C0, U }
    dw $1C54 : db $07 ; Blue rupee  xyz:{ 0x150, 0x1C0, U }

    ; $00DEF2
    .Room0028
    .Room0029
    dw $FFFF

    ; $00DEF4
    .Room002A
    dw $0C50 : db $01 ; Green rupee xyz:{ 0x140, 0x0C0, U }
    dw $1350 : db $0B ; Heart       xyz:{ 0x140, 0x130, U }
    dw $FFFF

    ; $00DEFC
    .Room002B
    dw $0510 : db $0B ; Heart       xyz:{ 0x040, 0x050, U }
    dw $052C : db $88 ; Switch      xyz:{ 0x0B0, 0x050, U }
    dw $0610 : db $0B ; Heart       xyz:{ 0x040, 0x060, U }
    dw $062C : db $0A ; Bomb        xyz:{ 0x0B0, 0x060, U }
    dw $0710 : db $0B ; Heart       xyz:{ 0x040, 0x070, U }
    dw $072C : db $0A ; Bomb        xyz:{ 0x0B0, 0x070, U }
    dw $1592 : db $0A ; Bomb        xyz:{ 0x048, 0x150, U }
    dw $15AA : db $09 ; 5 arrows    xyz:{ 0x0A8, 0x150, U }
    dw $1692 : db $0A ; Bomb        xyz:{ 0x048, 0x160, U }
    dw $16AA : db $09 ; 5 arrows    xyz:{ 0x0A8, 0x160, U }
    dw $FFFF

    ; $00DF1C
    .Room002C
    dw $186C : db $0B ; Heart       xyz:{ 0x1B0, 0x180, U }
    dw $1870 : db $0B ; Heart       xyz:{ 0x1C0, 0x180, U }

    ; $00DF22
    .Room002D
    .Room002E
    dw $FFFF

    ; $00DF24
    .Room002F
    dw $071C : db $0B ; Heart       xyz:{ 0x070, 0x070, U }
    dw $0720 : db $0B ; Heart       xyz:{ 0x080, 0x070, U }
    dw $091C : db $07 ; Blue rupee  xyz:{ 0x070, 0x090, U }
    dw $0920 : db $07 ; Blue rupee  xyz:{ 0x080, 0x090, U }
    dw $13AC : db $07 ; Blue rupee  xyz:{ 0x0B0, 0x130, U }
    dw $13B4 : db $07 ; Blue rupee  xyz:{ 0x0D0, 0x130, U }
    dw $1B68 : db $0B ; Heart       xyz:{ 0x1A0, 0x1B0, U }
    dw $1C68 : db $0B ; Heart       xyz:{ 0x1A0, 0x1C0, U }

    ; $00DF3C
    .Room0030
    dw $FFFF

    ; $00DF3E
    .Room0031
    dw $1C5C : db $0A ; Bomb        xyz:{ 0x170, 0x1C0, U }
    dw $FFFF

    ; $00DF43
    .Room0032
    dw $0D1C : db $0C ; Small magic xyz:{ 0x070, 0x0D0, U }

    ; $00DF46
    .Room0033
    dw $FFFF

    ; $00DF48
    .Room0034
    dw $084E : db $07 ; Blue rupee  xyz:{ 0x138, 0x080, U }
    dw $085C : db $07 ; Blue rupee  xyz:{ 0x170, 0x080, U }
    dw $FFFF

    ; $00DF50
    .Room0035
    dw $063C : db $08 ; Small key   xyz:{ 0x0F0, 0x060, U }
    dw $0814 : db $07 ; Blue rupee  xyz:{ 0x050, 0x080, U }
    dw $0818 : db $07 ; Blue rupee  xyz:{ 0x060, 0x080, U }
    dw $081C : db $07 ; Blue rupee  xyz:{ 0x070, 0x080, U }
    dw $0820 : db $07 ; Blue rupee  xyz:{ 0x080, 0x080, U }
    dw $0824 : db $07 ; Blue rupee  xyz:{ 0x090, 0x080, U }
    dw $1430 : db $0B ; Heart       xyz:{ 0x0C0, 0x140, U }
    dw $1770 : db $0B ; Heart       xyz:{ 0x1C0, 0x170, U }
    dw $1C4C : db $0B ; Heart       xyz:{ 0x130, 0x1C0, U }
    dw $FFFF

    ; $00DF6D
    .Room0036
    dw $046C : db $0A ; Bomb        xyz:{ 0x1B0, 0x040, U }
    dw $0470 : db $07 ; Blue rupee  xyz:{ 0x1C0, 0x040, U }
    dw $100A : db $0B ; Heart       xyz:{ 0x028, 0x100, U }
    dw $1072 : db $08 ; Small key   xyz:{ 0x1C8, 0x100, U }
    dw $FFFF

    ; $00DF7B
    .Room0037
    dw $063C : db $08 ; Small key   xyz:{ 0x0F0, 0x060, U }
    dw $FFFF

    ; $00DF80
    .Room0038
    dw $0CA4 : db $0A ; Bomb        xyz:{ 0x090, 0x0C0, U }
    dw $0DA4 : db $07 ; Blue rupee  xyz:{ 0x090, 0x0D0, U }
    dw $12A4 : db $0A ; Bomb        xyz:{ 0x090, 0x120, U }
    dw $13A4 : db $08 ; Small key   xyz:{ 0x090, 0x130, U }
    dw $FFFF

    ; $00DF8E
    .Room0039
    dw $140C : db $0B ; Heart       xyz:{ 0x030, 0x140, U }
    dw $1664 : db $0C ; Small magic xyz:{ 0x190, 0x160, U }
    dw $1A64 : db $09 ; 5 arrows    xyz:{ 0x190, 0x1A0, U }
    dw $1C30 : db $09 ; 5 arrows    xyz:{ 0x0C0, 0x1C0, U }

    ; $00DF9A
    .Room003A
    .Room003B
    dw $FFFF

    ; $00DF9C
    .Room003C
    dw $0818 : db $0C ; Small magic xyz:{ 0x060, 0x080, U }
    dw $0C40 : db $07 ; Blue rupee  xyz:{ 0x100, 0x0C0, U }
    dw $0E14 : db $01 ; Green rupee xyz:{ 0x050, 0x0E0, U }
    dw $1244 : db $07 ; Blue rupee  xyz:{ 0x110, 0x120, U }
    dw $1360 : db $0B ; Heart       xyz:{ 0x180, 0x130, U }
    dw $1440 : db $07 ; Blue rupee  xyz:{ 0x100, 0x140, U }
    dw $1A40 : db $07 ; Blue rupee  xyz:{ 0x100, 0x1A0, U }
    dw $FFFF

    ; $00DFB3
    .Room003D
    dw $0C4C : db $0A ; Bomb        xyz:{ 0x130, 0x0C0, U }
    dw $0C70 : db $0A ; Bomb        xyz:{ 0x1C0, 0x0C0, U }
    dw $1618 : db $0B ; Heart       xyz:{ 0x060, 0x160, U }
    dw $1628 : db $09 ; 5 arrows    xyz:{ 0x0A0, 0x160, U }
    dw $1820 : db $0B ; Heart       xyz:{ 0x080, 0x180, U }
    dw $1A14 : db $07 ; Blue rupee  xyz:{ 0x050, 0x1A0, U }
    dw $1A24 : db $0D ; Full magic  xyz:{ 0x090, 0x1A0, U }
    dw $FFFF

    ; $00DFCA
    .Room003E
    dw $0660 : db $0A ; Bomb        xyz:{ 0x180, 0x060, U }
    dw $0664 : db $0C ; Small magic xyz:{ 0x190, 0x060, U }
    dw $0A58 : db $0B ; Heart       xyz:{ 0x160, 0x0A0, U }
    dw $0A5C : db $0C ; Small magic xyz:{ 0x170, 0x0A0, U }
    dw $FFFF

    ; $00DFD8
    .Room003F
    dw $190C : db $01 ; Green rupee xyz:{ 0x030, 0x190, U }
    dw $1914 : db $01 ; Green rupee xyz:{ 0x050, 0x190, U }
    dw $1A0C : db $0A ; Bomb        xyz:{ 0x030, 0x1A0, U }
    dw $1A14 : db $0A ; Bomb        xyz:{ 0x050, 0x1A0, U }
    dw $1B0C : db $88 ; Switch      xyz:{ 0x030, 0x1B0, U }
    dw $1B14 : db $0B ; Heart       xyz:{ 0x050, 0x1B0, U }
    dw $171C : db $08 ; Small key   xyz:{ 0x070, 0x170, U }

    ; $00DFED
    .Room0040
    dw $FFFF

    ; $00DFEF
    .Room0041
    dw $0A64 : db $0B ; Heart       xyz:{ 0x190, 0x0A0, U }
    dw $0F34 : db $01 ; Green rupee xyz:{ 0x0D0, 0x0F0, U }
    dw $1034 : db $0C ; Small magic xyz:{ 0x0D0, 0x100, U }
    dw $1694 : db $0C ; Small magic xyz:{ 0x050, 0x160, U }

    ; $00DFFB
    .Room0042
    dw $FFFF

    ; $00DFFD
    .Room0043
    dw $0442 : db $09 ; 5 arrows    xyz:{ 0x108, 0x040, U }
    dw $044E : db $0C ; Small magic xyz:{ 0x138, 0x040, U }
    dw $0942 : db $0B ; Heart       xyz:{ 0x108, 0x090, U }
    dw $094E : db $0B ; Heart       xyz:{ 0x138, 0x090, U }
    dw $1470 : db $08 ; Small key   xyz:{ 0x1C0, 0x140, U }

    ; $00E00C
    .Room0044
    dw $FFFF

    ; $00E00E
    .Room0045
    dw $040C : db $09 ; 5 arrows    xyz:{ 0x030, 0x040, U }
    dw $0B6C : db $0B ; Heart       xyz:{ 0x1B0, 0x0B0, U }
    dw $0C30 : db $09 ; 5 arrows    xyz:{ 0x0C0, 0x0C0, U }
    dw $10DC : db $0C ; Small magic xyz:{ 0x170, 0x100, U }
    dw $10EC : db $0B ; Heart       xyz:{ 0x1B0, 0x100, U }
    dw $FFFF

    ; $00E01F
    .Room0046
    dw $0560 : db $0B ; Heart       xyz:{ 0x180, 0x050, U }
    dw $1B1C : db $0B ; Heart       xyz:{ 0x070, 0x1B0, U }

    ; $00E025
    .Room0047
    .Room0048
    dw $FFFF

    ; $00E027
    .Room0049
    dw $0F68 : db $0C ; Small magic xyz:{ 0x1A0, 0x0F0, U }
    dw $1068 : db $0C ; Small magic xyz:{ 0x1A0, 0x100, U }
    dw $1390 : db $0C ; Small magic xyz:{ 0x040, 0x130, U }
    dw $14AC : db $0B ; Heart       xyz:{ 0x0B0, 0x140, U }
    dw $1B90 : db $0B ; Heart       xyz:{ 0x040, 0x1B0, U }
    dw $1CAC : db $0C ; Small magic xyz:{ 0x0B0, 0x1C0, U }
    dw $FFFF

    ; $00E03B
    .Room004A
    dw $050E : db $88 ; Switch      xyz:{ 0x038, 0x050, U }
    dw $0520 : db $0A ; Bomb        xyz:{ 0x080, 0x050, U }
    dw $055C : db $0A ; Bomb        xyz:{ 0x170, 0x050, U }
    dw $056E : db $88 ; Switch      xyz:{ 0x1B8, 0x050, U }
    dw $0838 : db $0A ; Bomb        xyz:{ 0x0E0, 0x080, U }
    dw $0844 : db $0A ; Bomb        xyz:{ 0x110, 0x080, U }
    dw $0B0E : db $0B ; Heart       xyz:{ 0x038, 0x0B0, U }
    dw $0B20 : db $01 ; Green rupee xyz:{ 0x080, 0x0B0, U }
    dw $0B5C : db $01 ; Green rupee xyz:{ 0x170, 0x0B0, U }
    dw $0B6E : db $0B ; Heart       xyz:{ 0x1B8, 0x0B0, U }
    dw $FFFF

    ; $00E05B
    .Room004B
    dw $0614 : db $09 ; 5 arrows    xyz:{ 0x050, 0x060, U }
    dw $0628 : db $0B ; Heart       xyz:{ 0x0A0, 0x060, U }

    ; $00E061
    .Room004C
    .Room004D
    dw $FFFF

    ; $00E063
    .Room004E
    dw $0B8C : db $88 ; Switch      xyz:{ 0x030, 0x0B0, U }
    dw $0C1C : db $0B ; Heart       xyz:{ 0x070, 0x0C0, U }
    dw $0C70 : db $0C ; Small magic xyz:{ 0x1C0, 0x0C0, U }

    ; $00E06C
    .Room004F
    dw $FFFF

    ; $00E06E
    .Room0050
    dw $2660 : db $0B ; Heart       xyz:{ 0x180, 0x060, L }
    dw $2664 : db $0B ; Heart       xyz:{ 0x190, 0x060, L }

    ; $00E074
    .Room0051
    dw $FFFF

    ; $00E076
    .Room0052
    dw $038A : db $0B ; Heart       xyz:{ 0x028, 0x030, U }
    dw $1AC2 : db $0B ; Heart       xyz:{ 0x108, 0x1A0, U }
    dw $FFFF

    ; $00E07E
    .Room0053
    dw $0B5C : db $0B ; Heart       xyz:{ 0x170, 0x0B0, U }
    dw $0B60 : db $0C ; Small magic xyz:{ 0x180, 0x0B0, U }
    dw $0B64 : db $08 ; Small key   xyz:{ 0x190, 0x0B0, U }
    dw $0B68 : db $0B ; Heart       xyz:{ 0x1A0, 0x0B0, U }
    dw $FFFF

    ; $00E08C
    .Room0054
    dw $19BA : db $07 ; Blue rupee  xyz:{ 0x0E8, 0x190, U }
    dw $1ABA : db $0B ; Heart       xyz:{ 0x0E8, 0x1A0, U }
    dw $1BBA : db $0B ; Heart       xyz:{ 0x0E8, 0x1B0, U }
    dw $1CBA : db $0B ; Heart       xyz:{ 0x0E8, 0x1C0, U }
    dw $FFFF

    ; $00E09A
    .Room0055
    dw $18E6 : db $0C ; Small magic xyz:{ 0x198, 0x180, U }
    dw $19E6 : db $0C ; Small magic xyz:{ 0x198, 0x190, U }
    dw $FFFF

    ; $00E0A2
    .Room0056
    dw $0614 : db $0C ; Small magic xyz:{ 0x050, 0x060, U }
    dw $0628 : db $0C ; Small magic xyz:{ 0x0A0, 0x060, U }
    dw $0718 : db $0C ; Small magic xyz:{ 0x060, 0x070, U }
    dw $0724 : db $0C ; Small magic xyz:{ 0x090, 0x070, U }
    dw $080C : db $0B ; Heart       xyz:{ 0x030, 0x080, U }
    dw $0830 : db $0B ; Heart       xyz:{ 0x0C0, 0x080, U }
    dw $0918 : db $0C ; Small magic xyz:{ 0x060, 0x090, U }
    dw $0924 : db $0C ; Small magic xyz:{ 0x090, 0x090, U }
    dw $0A14 : db $07 ; Blue rupee  xyz:{ 0x050, 0x0A0, U }
    dw $0A28 : db $07 ; Blue rupee  xyz:{ 0x0A0, 0x0A0, U }
    dw $140C : db $08 ; Small key   xyz:{ 0x030, 0x140, U }
    dw $FFFF

    ; $00E0C5
    .Room0057
    dw $075C : db $0D ; Full magic  xyz:{ 0x170, 0x070, U }
    dw $140C : db $0C ; Small magic xyz:{ 0x030, 0x140, U }
    dw $175C : db $0A ; Bomb        xyz:{ 0x170, 0x170, U }
    dw $1764 : db $0C ; Small magic xyz:{ 0x190, 0x170, U }
    dw $1954 : db $07 ; Blue rupee  xyz:{ 0x150, 0x190, U }
    dw $1B4C : db $0B ; Heart       xyz:{ 0x130, 0x1B0, U }
    dw $1430 : db $0C ; Small magic xyz:{ 0x0C0, 0x140, U }
    dw $161E : db $88 ; Switch      xyz:{ 0x078, 0x160, U }
    dw $FFFF

    ; $00E0DF
    .Room0058
    dw $0560 : db $0A ; Bomb        xyz:{ 0x180, 0x050, U }
    dw $0564 : db $0C ; Small magic xyz:{ 0x190, 0x050, U }
    dw $070C : db $0C ; Small magic xyz:{ 0x030, 0x070, U }
    dw $075C : db $0B ; Heart       xyz:{ 0x170, 0x070, U }
    dw $076C : db $0B ; Heart       xyz:{ 0x1B0, 0x070, U }
    dw $0810 : db $0C ; Small magic xyz:{ 0x040, 0x080, U }
    dw $0964 : db $0C ; Small magic xyz:{ 0x190, 0x090, U }
    dw $0968 : db $0A ; Bomb        xyz:{ 0x1A0, 0x090, U }
    dw $FFFF

    ; $00E0F9
    .Room0059
    dw $2B1A : db $0B ; Heart       xyz:{ 0x068, 0x0B0, L }

    ; $00E0FC
    .Room005A
    dw $FFFF

    ; $00E0FE
    .Room005B
    dw $25DE : db $88 ; Switch      xyz:{ 0x178, 0x050, L }
    dw $FFFF

    ; $00E103
    .Room005C
    dw $165E : db $0A ; Bomb        xyz:{ 0x178, 0x160, U }
    dw $1A5E : db $0D ; Full magic  xyz:{ 0x178, 0x1A0, U }
    dw $FFFF

    ; $00E10B
    .Room005D
    dw $0510 : db $0A ; Bomb        xyz:{ 0x040, 0x050, U }
    dw $052C : db $07 ; Blue rupee  xyz:{ 0x0B0, 0x050, U }
    dw $0B10 : db $01 ; Green rupee xyz:{ 0x040, 0x0B0, U }
    dw $0B2C : db $09 ; 5 arrows    xyz:{ 0x0B0, 0x0B0, U }
    dw $140C : db $09 ; 5 arrows    xyz:{ 0x030, 0x140, U }
    dw $1430 : db $0A ; Bomb        xyz:{ 0x0C0, 0x140, U }
    dw $1C0C : db $0C ; Small magic xyz:{ 0x030, 0x1C0, U }
    dw $1C30 : db $0A ; Bomb        xyz:{ 0x0C0, 0x1C0, U }
    dw $FFFF

    ; $00E125
    .Room005E
    dw $045C : db $0C ; Small magic xyz:{ 0x170, 0x040, U }
    dw $0460 : db $0C ; Small magic xyz:{ 0x180, 0x040, U }
    dw $084C : db $0B ; Heart       xyz:{ 0x130, 0x080, U }
    dw $0870 : db $0B ; Heart       xyz:{ 0x1C0, 0x080, U }
    dw $FFFF

    ; $00E133
    .Room005F
    dw $1B2C : db $88 ; Switch      xyz:{ 0x0B0, 0x1B0, U }
    dw $FFFF

    ; $00E138
    .Room0060
    dw $044C : db $0B ; Heart       xyz:{ 0x130, 0x040, U }
    dw $0470 : db $0B ; Heart       xyz:{ 0x1C0, 0x040, U }

    ; $00E13E
    .Room0061
    dw $FFFF

    ; $00E140
    .Room0062
    dw $15D0 : db $0B ; Heart       xyz:{ 0x140, 0x150, U }
    dw $FFFF

    ; $00E145
    .Room0063
    dw $0830 : db $0B ; Heart       xyz:{ 0x0C0, 0x080, U }
    dw $0C0C : db $08 ; Small key   xyz:{ 0x030, 0x0C0, U }
    dw $FFFF

    ; $00E14D
    .Room0064
    dw $160C : db $0A ; Bomb        xyz:{ 0x030, 0x160, U }
    dw $1610 : db $0A ; Bomb        xyz:{ 0x040, 0x160, U }
    dw $1614 : db $0A ; Bomb        xyz:{ 0x050, 0x160, U }
    dw $1C24 : db $0A ; Bomb        xyz:{ 0x090, 0x1C0, U }
    dw $1C28 : db $0C ; Small magic xyz:{ 0x0A0, 0x1C0, U }
    dw $1C2C : db $0C ; Small magic xyz:{ 0x0B0, 0x1C0, U }
    dw $1C30 : db $88 ; Switch      xyz:{ 0x0C0, 0x1C0, U }
    dw $FFFF

    ; $00E164
    .Room0065
    dw $1C64 : db $0A ; Bomb        xyz:{ 0x190, 0x1C0, U }
    dw $1C68 : db $0A ; Bomb        xyz:{ 0x1A0, 0x1C0, U }
    dw $FFFF

    ; $00E16C
    .Room0066
    dw $2530 : db $09 ; 5 arrows    xyz:{ 0x0C0, 0x050, L }
    dw $2534 : db $0A ; Bomb        xyz:{ 0x0D0, 0x050, L }
    dw $2538 : db $07 ; Blue rupee  xyz:{ 0x0E0, 0x050, L }
    dw $0554 : db $0B ; Heart       xyz:{ 0x150, 0x050, U }
    dw $0568 : db $09 ; 5 arrows    xyz:{ 0x1A0, 0x050, U }
    dw $2630 : db $09 ; 5 arrows    xyz:{ 0x0C0, 0x060, L }
    dw $2634 : db $0A ; Bomb        xyz:{ 0x0D0, 0x060, L }
    dw $2638 : db $07 ; Blue rupee  xyz:{ 0x0E0, 0x060, L }
    dw $0654 : db $0B ; Heart       xyz:{ 0x150, 0x060, U }
    dw $0668 : db $0A ; Bomb        xyz:{ 0x1A0, 0x060, U }
    dw $FFFF

    ; $00E18C
    .Room0067
    dw $070C : db $09 ; 5 arrows    xyz:{ 0x030, 0x070, U }
    dw $0730 : db $0C ; Small magic xyz:{ 0x0C0, 0x070, U }
    dw $1360 : db $0B ; Heart       xyz:{ 0x180, 0x130, U }
    dw $144A : db $0C ; Small magic xyz:{ 0x128, 0x140, U }
    dw $1712 : db $0C ; Small magic xyz:{ 0x048, 0x170, U }
    dw $1A12 : db $0B ; Heart       xyz:{ 0x048, 0x1A0, U }
    dw $1C68 : db $0B ; Heart       xyz:{ 0x1A0, 0x1C0, U }
    dw $FFFF

    ; $00E1A3
    .Room0068
    dw $0740 : db $0B ; Heart       xyz:{ 0x100, 0x070, U }
    dw $0758 : db $0C ; Small magic xyz:{ 0x160, 0x070, U }
    dw $1040 : db $0B ; Heart       xyz:{ 0x100, 0x100, U }
    dw $1840 : db $0C ; Small magic xyz:{ 0x100, 0x180, U }
    dw $1940 : db $0B ; Heart       xyz:{ 0x100, 0x190, U }

    ; $00E1B2
    .Room0069
    .Room006A
    dw $FFFF

    ; $00E1B4
    .Room006B
    dw $051C : db $0B ; Heart       xyz:{ 0x070, 0x050, U }
    dw $082C : db $0C ; Small magic xyz:{ 0x0B0, 0x080, U }
    dw $0B1C : db $0C ; Small magic xyz:{ 0x070, 0x0B0, U }
    dw $1962 : db $09 ; 5 arrows    xyz:{ 0x188, 0x190, U }
    dw $FFFF

    ; $00E1C2
    .Room006C
    dw $0614 : db $0B ; Heart       xyz:{ 0x050, 0x060, U }
    dw $0628 : db $09 ; 5 arrows    xyz:{ 0x0A0, 0x060, U }
    dw $0A14 : db $0A ; Bomb        xyz:{ 0x050, 0x0A0, U }
    dw $0A28 : db $0C ; Small magic xyz:{ 0x0A0, 0x0A0, U }
    dw $FFFF

    ; $00E1D0
    .Room006D
    dw $1A1C : db $0B ; Heart       xyz:{ 0x070, 0x1A0, U }
    dw $1A20 : db $0B ; Heart       xyz:{ 0x080, 0x1A0, U }
    dw $1B1C : db $0C ; Small magic xyz:{ 0x070, 0x1B0, U }
    dw $1B20 : db $0C ; Small magic xyz:{ 0x080, 0x1B0, U }

    ; $00E1DC
    .Room006E
    .Room006F
    .Room0070
    .Room0071
    .Room0072
    dw $FFFF

    ; $00E1DE
    .Room0073
    dw $159A : db $09 ; 5 arrows    xyz:{ 0x068, 0x150, U }
    dw $159E : db $01 ; Green rupee xyz:{ 0x078, 0x150, U }
    dw $1714 : db $88 ; Switch      xyz:{ 0x050, 0x170, U }
    dw $1724 : db $07 ; Blue rupee  xyz:{ 0x090, 0x170, U }
    dw $1890 : db $0B ; Heart       xyz:{ 0x040, 0x180, U }
    dw $18A8 : db $09 ; 5 arrows    xyz:{ 0x0A0, 0x180, U }
    dw $1A14 : db $0C ; Small magic xyz:{ 0x050, 0x1A0, U }
    dw $1A24 : db $0B ; Heart       xyz:{ 0x090, 0x1A0, U }
    dw $1B9A : db $01 ; Green rupee xyz:{ 0x068, 0x1B0, U }
    dw $1B9E : db $07 ; Blue rupee  xyz:{ 0x078, 0x1B0, U }
    dw $FFFF

    ; $00E1FE
    .Room0074
    dw $051E : db $0C ; Small magic xyz:{ 0x078, 0x050, U }
    dw $053E : db $88 ; Switch      xyz:{ 0x0F8, 0x050, U }
    dw $055E : db $0C ; Small magic xyz:{ 0x178, 0x050, U }
    dw $0B0E : db $0B ; Heart       xyz:{ 0x038, 0x0B0, U }
    dw $0B2E : db $09 ; 5 arrows    xyz:{ 0x0B8, 0x0B0, U }
    dw $0B4E : db $09 ; 5 arrows    xyz:{ 0x138, 0x0B0, U }
    dw $0B6E : db $0B ; Heart       xyz:{ 0x1B8, 0x0B0, U }
    dw $FFFF

    ; $00E215
    .Room0075
    dw $1694 : db $0C ; Small magic xyz:{ 0x050, 0x160, U }
    dw $16A0 : db $09 ; 5 arrows    xyz:{ 0x080, 0x160, U }
    dw $16AC : db $0B ; Heart       xyz:{ 0x0B0, 0x160, U }
    dw $FFFF

    ; $00E220
    .Room0076
    dw $0C70 : db $0B ; Heart       xyz:{ 0x1C0, 0x0C0, U }
    dw $1754 : db $0B ; Heart       xyz:{ 0x150, 0x170, U }
    dw $1760 : db $0B ; Heart       xyz:{ 0x180, 0x170, U }

    ; $00E229
    .Room0077
    .Room0078
    .Room0079
    .Room007A
    dw $FFFF

    ; $00E22B
    .Room007B
    dw $043C : db $0B ; Heart       xyz:{ 0x0F0, 0x040, U }
    dw $0440 : db $08 ; Small key   xyz:{ 0x100, 0x040, U }
    dw $FFFF

    ; $00E233
    .Room007C
    dw $041C : db $0B ; Heart       xyz:{ 0x070, 0x040, U }
    dw $0420 : db $0B ; Heart       xyz:{ 0x080, 0x040, U }
    dw $FFFF

    ; $00E23B
    .Room007D
    dw $0670 : db $0B ; Heart       xyz:{ 0x1C0, 0x060, U }
    dw $146C : db $09 ; 5 arrows    xyz:{ 0x1B0, 0x140, U }
    dw $1472 : db $0A ; Bomb        xyz:{ 0x1C8, 0x140, U }
    dw $1C4C : db $0A ; Bomb        xyz:{ 0x130, 0x1C0, U }
    dw $FFFF

    ; $00E249
    .Room007E
    dw $0F56 : db $0B ; Heart       xyz:{ 0x158, 0x0F0, U }
    dw $1A52 : db $0C ; Small magic xyz:{ 0x148, 0x1A0, U }
    dw $1A64 : db $88 ; Switch      xyz:{ 0x190, 0x1A0, U }

    ; $00E252
    .Room007F
    dw $FFFF

    ; $00E254
    .Room0080
    dw $0430 : db $0B ; Heart       xyz:{ 0x0C0, 0x040, U }
    dw $0434 : db $0B ; Heart       xyz:{ 0x0D0, 0x040, U }
    dw $0438 : db $0B ; Heart       xyz:{ 0x0E0, 0x040, U }

    ; $00E25D
    .Room0081
    dw $FFFF

    ; $00E25F
    .Room0082
    dw $324C : db $0B ; Heart       xyz:{ 0x130, 0x120, L }
    dw $FFFF

    ; $00E264
    .Room0083
    dw $044C : db $09 ; 5 arrows    xyz:{ 0x130, 0x040, U }
    dw $0450 : db $01 ; Green rupee xyz:{ 0x140, 0x040, U }
    dw $1C4C : db $07 ; Blue rupee  xyz:{ 0x130, 0x1C0, U }
    dw $1C50 : db $09 ; 5 arrows    xyz:{ 0x140, 0x1C0, U }
    dw $FFFF

    ; $00E272
    .Room0084
    dw $0718 : db $09 ; 5 arrows    xyz:{ 0x060, 0x070, U }
    dw $0764 : db $09 ; 5 arrows    xyz:{ 0x190, 0x070, U }
    dw $FFFF

    ; $00E27A
    .Room0085
    dw $1C2C : db $0B ; Heart       xyz:{ 0x0B0, 0x1C0, U }
    dw $1C30 : db $09 ; 5 arrows    xyz:{ 0x0C0, 0x1C0, U }

    ; $00E280
    .Room0086
    dw $FFFF

    ; $00E282
    .Room0087
    dw $144C : db $0C ; Small magic xyz:{ 0x130, 0x140, U }
    dw $1470 : db $0D ; Full magic  xyz:{ 0x1C0, 0x140, U }

    ; $00E288
    .Room0088
    .Room0089
    .Room008A
    dw $FFFF

    ; $00E28A
    .Room008B
    dw $0C70 : db $08 ; Small key   xyz:{ 0x1C0, 0x0C0, U }
    dw $0920 : db $0C ; Small magic xyz:{ 0x080, 0x090, U }
    dw $1C4C : db $0B ; Heart       xyz:{ 0x130, 0x1C0, U }
    dw $FFFF

    ; $00E295
    .Room008C
    dw $0C4C : db $88 ; Switch      xyz:{ 0x130, 0x0C0, U }
    dw $0C70 : db $0C ; Small magic xyz:{ 0x1C0, 0x0C0, U }
    dw $144C : db $0A ; Bomb        xyz:{ 0x130, 0x140, U }
    dw $145C : db $0A ; Bomb        xyz:{ 0x170, 0x140, U }
    dw $1564 : db $09 ; 5 arrows    xyz:{ 0x190, 0x150, U }
    dw $1A68 : db $0A ; Bomb        xyz:{ 0x1A0, 0x1A0, U }
    dw $1B58 : db $0A ; Bomb        xyz:{ 0x160, 0x1B0, U }
    dw $FFFF

    ; $00E2AC
    .Room008D
    dw $0ECC : db $0D ; Full magic  xyz:{ 0x130, 0x0E0, U }
    dw $171C : db $0B ; Heart       xyz:{ 0x070, 0x170, U }
    dw $1724 : db $0B ; Heart       xyz:{ 0x090, 0x170, U }
    dw $1820 : db $0D ; Full magic  xyz:{ 0x080, 0x180, U }
    dw $FFFF

    ; $00E2BA
    .Room008E
    dw $0550 : db $09 ; 5 arrows    xyz:{ 0x140, 0x050, U }

    ; $00E2BD
    .Room008F
    .Room0090
    dw $FFFF

    ; $00E2BF
    .Room0091
    dw $0454 : db $0B ; Heart       xyz:{ 0x150, 0x040, U }
    dw $0468 : db $0C ; Small magic xyz:{ 0x1A0, 0x040, U }

    ; $00E2C5
    .Room0092
    dw $FFFF

    ; $00E2C7
    .Room0093
    dw $071C : db $88 ; Switch      xyz:{ 0x070, 0x070, U }
    dw $0760 : db $0B ; Heart       xyz:{ 0x180, 0x070, U }

    ; $00E2CD
    .Room0094
    .Room0095
    dw $FFFF

    ; $00E2CF
    .Room0096
    dw $1120 : db $0C ; Small magic xyz:{ 0x080, 0x110, U }
    dw $1820 : db $0C ; Small magic xyz:{ 0x080, 0x180, U }
    dw $154C : db $0B ; Heart       xyz:{ 0x130, 0x150, U }
    dw $1570 : db $0D ; Full magic  xyz:{ 0x1C0, 0x150, U }

    ; $00E2DB
    .Room0097
    .Room0098
    dw $FFFF

    ; $00E2DD
    .Room0099
    dw $1428 : db $0C ; Small magic xyz:{ 0x0A0, 0x140, U }
    dw $1454 : db $0B ; Heart       xyz:{ 0x150, 0x140, U }

    ; $00E2E3
    .Room009A
    dw $FFFF

    ; $00E2E5
    .Room009B
    dw $0430 : db $0C ; Small magic xyz:{ 0x0C0, 0x040, U }
    dw $0C30 : db $08 ; Small key   xyz:{ 0x0C0, 0x0C0, U }
    dw $FFFF

    ; $00E2ED
    .Room009C
    dw $0838 : db $0C ; Small magic xyz:{ 0x0E0, 0x080, U }
    dw $0938 : db $09 ; 5 arrows    xyz:{ 0x0E0, 0x090, U }
    dw $FFFF

    ; $00E2F5
    .Room009D
    dw $044C : db $0A ; Bomb        xyz:{ 0x130, 0x040, U }
    dw $0454 : db $0C ; Small magic xyz:{ 0x150, 0x040, U }

    ; $00E2FB
    .Room009E
    dw $FFFF

    ; $00E2FD
    .Room009F
    dw $138A : db $0B ; Heart       xyz:{ 0x028, 0x130, U }
    dw $13B2 : db $0B ; Heart       xyz:{ 0x0C8, 0x130, U }
    dw $1528 : db $88 ; Switch      xyz:{ 0x0A0, 0x150, U }
    dw $158A : db $08 ; Small key   xyz:{ 0x028, 0x150, U }
    dw $1B14 : db $0B ; Heart       xyz:{ 0x050, 0x1B0, U }
    dw $1B8A : db $0B ; Heart       xyz:{ 0x028, 0x1B0, U }
    dw $1CB2 : db $0B ; Heart       xyz:{ 0x0C8, 0x1C0, U }

    ; $00E312
    .Room00A0
    dw $FFFF

    ; $00E314
    .Room00A1
    dw $0696 : db $08 ; Small key   xyz:{ 0x058, 0x060, U }
    dw $0B64 : db $0C ; Small magic xyz:{ 0x190, 0x0B0, U }
    dw $0C68 : db $0B ; Heart       xyz:{ 0x1A0, 0x0C0, U }
    dw $0D6C : db $0C ; Small magic xyz:{ 0x1B0, 0x0D0, U }
    dw $0E70 : db $0B ; Heart       xyz:{ 0x1C0, 0x0E0, U }
    dw $1760 : db $0B ; Heart       xyz:{ 0x180, 0x170, U }
    dw $FFFF

    ; $00E328
    .Room00A2
    dw $1C0C : db $0D ; Full magic  xyz:{ 0x030, 0x1C0, U }

    ; $00E32B
    .Room00A3
    .Room00A4
    .Room00A5
    .Room00A6
    .Room00A7
    dw $FFFF

    ; $00E32D
    .Room00A8
    dw $138A : db $0B ; Heart       xyz:{ 0x028, 0x130, U }
    dw $181E : db $01 ; Green rupee xyz:{ 0x078, 0x180, U }
    dw $FFFF

    ; $00E335
    .Room00A9
    dw $2B90 : db $09 ; 5 arrows    xyz:{ 0x040, 0x0B0, L }
    dw $2BEC : db $09 ; 5 arrows    xyz:{ 0x1B0, 0x0B0, L }
    dw $2C90 : db $09 ; 5 arrows    xyz:{ 0x040, 0x0C0, L }
    dw $2CEC : db $0B ; Heart       xyz:{ 0x1B0, 0x0C0, L }
    dw $1410 : db $0B ; Heart       xyz:{ 0x040, 0x140, U }
    dw $146C : db $0B ; Heart       xyz:{ 0x1B0, 0x140, U }
    dw $FFFF

    ; $00E349
    .Room00AA
    dw $05D4 : db $0B ; Heart       xyz:{ 0x150, 0x050, U }
    dw $085E : db $88 ; Switch      xyz:{ 0x178, 0x080, U }
    dw $376C : db $0B ; Heart       xyz:{ 0x1B0, 0x170, L }
    dw $386C : db $0B ; Heart       xyz:{ 0x1B0, 0x180, L }
    dw $396C : db $0B ; Heart       xyz:{ 0x1B0, 0x190, L }
    dw $FFFF

    ; $00E35A
    .Room00AB
    dw $1814 : db $08 ; Small key   xyz:{ 0x050, 0x180, U }

    ; $00E35D
    .Room00AC
    .Room00AD
    dw $FFFF

    ; $00E35F
    .Room00AE
    dw $0C4C : db $88 ; Switch      xyz:{ 0x130, 0x0C0, U }

    ; $00E362
    .Room00AF
    dw $FFFF

    ; $00E364
    .Room00B0
    dw $1514 : db $0A ; Bomb        xyz:{ 0x050, 0x150, U }
    dw $151C : db $01 ; Green rupee xyz:{ 0x070, 0x150, U }
    dw $1520 : db $07 ; Blue rupee  xyz:{ 0x080, 0x150, U }
    dw $1528 : db $09 ; 5 arrows    xyz:{ 0x0A0, 0x150, U }
    dw $1710 : db $07 ; Blue rupee  xyz:{ 0x040, 0x170, U }
    dw $172C : db $01 ; Green rupee xyz:{ 0x0B0, 0x170, U }
    dw $1824 : db $0B ; Heart       xyz:{ 0x090, 0x180, U }
    dw $1910 : db $0B ; Heart       xyz:{ 0x040, 0x190, U }
    dw $1B1C : db $09 ; 5 arrows    xyz:{ 0x070, 0x1B0, U }
    dw $1B28 : db $0A ; Bomb        xyz:{ 0x0A0, 0x1B0, U }
    dw $FFFF

    ; $00E384
    .Room00B1
    dw $044C : db $0B ; Heart       xyz:{ 0x130, 0x040, U }
    dw $0470 : db $01 ; Green rupee xyz:{ 0x1C0, 0x040, U }
    dw $FFFF

    ; $00E38C
    .Room00B2
    dw $2830 : db $01 ; Green rupee xyz:{ 0x0C0, 0x080, L }
    dw $284C : db $01 ; Green rupee xyz:{ 0x130, 0x080, L }
    dw $294C : db $0B ; Heart       xyz:{ 0x130, 0x090, L }
    dw $FFFF

    ; $00E397
    .Room00B3
    dw $140C : db $08 ; Small key   xyz:{ 0x030, 0x140, U }
    dw $1430 : db $0C ; Small magic xyz:{ 0x0C0, 0x140, U }
    dw $1C30 : db $88 ; Switch      xyz:{ 0x0C0, 0x1C0, U }
    dw $FFFF

    ; $00E3A2
    .Room00B4
    dw $1C2C : db $0D ; Full magic  xyz:{ 0x0B0, 0x1C0, U }
    dw $1C30 : db $0B ; Heart       xyz:{ 0x0C0, 0x1C0, U }
    dw $FFFF

    ; $00E3AA
    .Room00B5
    dw $0470 : db $07 ; Blue rupee  xyz:{ 0x1C0, 0x040, U }
    dw $0F70 : db $0B ; Heart       xyz:{ 0x1C0, 0x0F0, U }
    dw $104C : db $88 ; Switch      xyz:{ 0x130, 0x100, U }
    dw $1070 : db $0D ; Full magic  xyz:{ 0x1C0, 0x100, U }
    dw $1170 : db $0B ; Heart       xyz:{ 0x1C0, 0x110, U }
    dw $1C70 : db $0A ; Bomb        xyz:{ 0x1C0, 0x1C0, U }
    dw $FFFF

    ; $00E3BE
    .Room00B6
    dw $095E : db $0D ; Full magic  xyz:{ 0x178, 0x090, U }
    dw $FFFF

    ; $00E3C3
    .Room00B7
    dw $051E : db $0C ; Small magic xyz:{ 0x078, 0x050, U }
    dw $FFFF

    ; $00E3C8
    .Room00B8
    dw $0D60 : db $88 ; Switch      xyz:{ 0x180, 0x0D0, U }
    dw $1058 : db $0B ; Heart       xyz:{ 0x160, 0x100, U }
    dw $1068 : db $0B ; Heart       xyz:{ 0x1A0, 0x100, U }
    dw $FFFF

    ; $00E3D3
    .Room00B9
    dw $125C : db $01 ; Green rupee xyz:{ 0x170, 0x120, U }
    dw $1260 : db $07 ; Blue rupee  xyz:{ 0x180, 0x120, U }
    dw $1268 : db $07 ; Blue rupee  xyz:{ 0x1A0, 0x120, U }
    dw $126C : db $01 ; Green rupee xyz:{ 0x1B0, 0x120, U }
    dw $FFFF

    ; $00E3E1
    .Room00BA
    dw $045E : db $01 ; Green rupee xyz:{ 0x178, 0x040, U }
    dw $064C : db $0B ; Heart       xyz:{ 0x130, 0x060, U }
    dw $0670 : db $08 ; Small key   xyz:{ 0x1C0, 0x060, U }
    dw $0A4C : db $0B ; Heart       xyz:{ 0x130, 0x0A0, U }
    dw $0A70 : db $0C ; Small magic xyz:{ 0x1C0, 0x0A0, U }
    dw $0C5E : db $01 ; Green rupee xyz:{ 0x178, 0x0C0, U }

    ; $00E3F3
    .Room00BB
    dw $FFFF

    ; $00E3F5
    .Room00BC
    dw $038A : db $0A ; Bomb        xyz:{ 0x028, 0x030, U }
    dw $03B2 : db $88 ; Switch      xyz:{ 0x0C8, 0x030, U }
    dw $0456 : db $0B ; Heart       xyz:{ 0x158, 0x040, U }
    dw $0466 : db $08 ; Small key   xyz:{ 0x198, 0x040, U }
    dw $0C8A : db $0B ; Heart       xyz:{ 0x028, 0x0C0, U }
    dw $0CB2 : db $0A ; Bomb        xyz:{ 0x0C8, 0x0C0, U }
    dw $1430 : db $0A ; Bomb        xyz:{ 0x0C0, 0x140, U }
    dw $151C : db $07 ; Blue rupee  xyz:{ 0x070, 0x150, U }
    dw $1520 : db $07 ; Blue rupee  xyz:{ 0x080, 0x150, U }
    dw $1B1C : db $07 ; Blue rupee  xyz:{ 0x070, 0x1B0, U }
    dw $1B20 : db $07 ; Blue rupee  xyz:{ 0x080, 0x1B0, U }
    dw $1C0C : db $0A ; Bomb        xyz:{ 0x030, 0x1C0, U }
    dw $1C30 : db $0A ; Bomb        xyz:{ 0x0C0, 0x1C0, U }

    ; $00E41C
    .Room00BD
    dw $FFFF

    ; $00E41E
    .Room00BE
    dw $195C : db $88 ; Switch      xyz:{ 0x170, 0x190, U }
    dw $FFFF

    ; $00E423
    .Room00BF
    dw $1428 : db $09 ; 5 arrows    xyz:{ 0x0A0, 0x140, U }
    dw $142C : db $0B ; Heart       xyz:{ 0x0B0, 0x140, U }
    dw $1430 : db $0A ; Bomb        xyz:{ 0x0C0, 0x140, U }
    dw $1C28 : db $0C ; Small magic xyz:{ 0x0A0, 0x1C0, U }
    dw $1C2C : db $0C ; Small magic xyz:{ 0x0B0, 0x1C0, U }
    dw $1C30 : db $0C ; Small magic xyz:{ 0x0C0, 0x1C0, U }
    dw $FFFF

    ; $00E437
    .Room00C0
    dw $0A30 : db $0A ; Bomb        xyz:{ 0x0C0, 0x0A0, U }
    dw $0E0C : db $07 ; Blue rupee  xyz:{ 0x030, 0x0E0, U }
    dw $1A0C : db $0B ; Heart       xyz:{ 0x030, 0x1A0, U }
    dw $1B1C : db $01 ; Green rupee xyz:{ 0x070, 0x1B0, U }

    ; $00E443
    .Room00C1
    dw $FFFF

    ; $00E445
    .Room00C2
    dw $07B4 : db $88 ; Switch      xyz:{ 0x0D0, 0x070, U }
    dw $2E64 : db $0C ; Small magic xyz:{ 0x190, 0x0E0, L }
    dw $3044 : db $01 ; Green rupee xyz:{ 0x110, 0x100, L }
    dw $3440 : db $09 ; 5 arrows    xyz:{ 0x100, 0x140, L }

    ; $00E451
    .Room00C3
    dw $FFFF

    ; $00E453
    .Room00C4
    dw $0954 : db $0A ; Bomb        xyz:{ 0x150, 0x090, U }
    dw $0E18 : db $0B ; Heart       xyz:{ 0x060, 0x0E0, U }
    dw $1138 : db $07 ; Blue rupee  xyz:{ 0x0E0, 0x110, U }
    dw $1154 : db $0A ; Bomb        xyz:{ 0x150, 0x110, U }
    dw $150C : db $09 ; 5 arrows    xyz:{ 0x030, 0x150, U }
    dw $174C : db $01 ; Green rupee xyz:{ 0x130, 0x170, U }
    dw $1930 : db $0C ; Small magic xyz:{ 0x0C0, 0x190, U }
    dw $1A0C : db $0B ; Heart       xyz:{ 0x030, 0x1A0, U }

    ; $00E46B
    .Room00C5
    dw $FFFF

    ; $00E46D
    .Room00C6
    dw $070C : db $0D ; Full magic  xyz:{ 0x030, 0x070, U }
    dw $190C : db $0B ; Heart       xyz:{ 0x030, 0x190, U }
    dw $FFFF

    ; $00E475
    .Room00C7
    dw $0A0C : db $0B ; Heart       xyz:{ 0x030, 0x0A0, U }
    dw $0B0C : db $0D ; Full magic  xyz:{ 0x030, 0x0B0, U }
    dw $160C : db $0C ; Small magic xyz:{ 0x030, 0x160, U }
    dw $1C0C : db $09 ; 5 arrows    xyz:{ 0x030, 0x1C0, U }

    ; $00E481
    .Room00C8
    dw $FFFF

    ; $00E483
    .Room00C9
    dw $161E : db $01 ; Green rupee xyz:{ 0x078, 0x160, U }
    dw $165E : db $01 ; Green rupee xyz:{ 0x178, 0x160, U }
    dw $163C : db $88 ; Switch      xyz:{ 0x0F0, 0x160, U }

    ; $00E48C
    .Room00CA
    dw $FFFF

    ; $00E48E
    .Room00CB
    dw $1058 : db $0B ; Heart       xyz:{ 0x160, 0x100, U }
    dw $1C58 : db $07 ; Blue rupee  xyz:{ 0x160, 0x1C0, U }
    dw $FFFF

    ; $00E496
    .Room00CC
    dw $0424 : db $07 ; Blue rupee  xyz:{ 0x090, 0x040, U }
    dw $0470 : db $0B ; Heart       xyz:{ 0x1C0, 0x040, U }
    dw $1C24 : db $07 ; Blue rupee  xyz:{ 0x090, 0x1C0, U }
    dw $1C70 : db $0A ; Bomb        xyz:{ 0x1C0, 0x1C0, U }

    ; $00E4A2
    .Room00CD
    dw $FFFF

    ; $00E41A
    .Room00CE
    dw $084C : db $0C ; Small magic xyz:{ 0x130, 0x080, U }
    dw $0850 : db $0C ; Small magic xyz:{ 0x140, 0x080, U }
    dw $0C6C : db $0A ; Bomb        xyz:{ 0x1B0, 0x0C0, U }
    dw $0C70 : db $09 ; 5 arrows    xyz:{ 0x1C0, 0x0C0, U }
    dw $0BCC : db $80 ; Hole        xyz:{ 0x130, 0x0B0, U }

    ; $00E4B3
    .Room00CF
    dw $FFFF

    ; $00E4B5
    .Room00D0
    dw $059E : db $0C ; Small magic xyz:{ 0x078, 0x050, U }
    dw $0B8C : db $01 ; Green rupee xyz:{ 0x030, 0x0B0, U }
    dw $0D2A : db $0C ; Small magic xyz:{ 0x0A8, 0x0D0, U }
    dw $1030 : db $0B ; Heart       xyz:{ 0x0C0, 0x100, U }
    dw $14B0 : db $01 ; Green rupee xyz:{ 0x0C0, 0x140, U }
    dw $1792 : db $07 ; Blue rupee  xyz:{ 0x048, 0x170, U }
    dw $1C0C : db $0B ; Heart       xyz:{ 0x030, 0x1C0, U }
    dw $FFFF

    ; $00E4CC
    .Room00D1
    dw $0430 : db $0D ; Full magic  xyz:{ 0x0C0, 0x040, U }
    dw $044C : db $01 ; Green rupee xyz:{ 0x130, 0x040, U }
    dw $0470 : db $09 ; 5 arrows    xyz:{ 0x1C0, 0x040, U }
    dw $07A8 : db $01 ; Green rupee xyz:{ 0x0A0, 0x070, U }
    dw $0C70 : db $01 ; Green rupee xyz:{ 0x1C0, 0x0C0, U }

    ; $00E4DB
    .Room00D2
    .Room00D3
    .Room00D4
    .Room00D5
    dw $FFFF

    ; $00E4DD
    .Room00D6
    dw $165C : db $0D ; Full magic  xyz:{ 0x170, 0x160, U }
    dw $1660 : db $0A ; Bomb        xyz:{ 0x180, 0x160, U }

    ; $00E4E3
    .Room00D7
    dw $FFFF

    ; $00E4E5
    .Room00D8
    dw $08CA : db $0B ; Heart       xyz:{ 0x128, 0x080, U }
    dw $08F2 : db $09 ; 5 arrows    xyz:{ 0x1C8, 0x080, U }
    dw $0ACA : db $09 ; 5 arrows    xyz:{ 0x128, 0x0A0, U }
    dw $0AF2 : db $09 ; 5 arrows    xyz:{ 0x1C8, 0x0A0, U }
    dw $0CCA : db $09 ; 5 arrows    xyz:{ 0x128, 0x0C0, U }
    dw $0CF2 : db $0B ; Heart       xyz:{ 0x1C8, 0x0C0, U }
    dw $185C : db $0B ; Heart       xyz:{ 0x170, 0x180, U }
    dw $1860 : db $09 ; 5 arrows    xyz:{ 0x180, 0x180, U }
    dw $FFFF

    ; $00E4FF
    .Room00D9
    dw $145C : db $09 ; 5 arrows    xyz:{ 0x170, 0x140, U }
    dw $1C5C : db $0B ; Heart       xyz:{ 0x170, 0x1C0, U }
    dw $FFFF

    ; $00E507
    .Room00DA
    dw $1718 : db $09 ; 5 arrows    xyz:{ 0x060, 0x170, U }
    dw $1724 : db $09 ; 5 arrows    xyz:{ 0x090, 0x170, U }
    dw $1918 : db $88 ; Switch      xyz:{ 0x060, 0x190, U }
    dw $1924 : db $0B ; Heart       xyz:{ 0x090, 0x190, U }
    dw $FFFF

    ; $00E515
    .Room00DB
    dw $0470 : db $07 ; Blue rupee  xyz:{ 0x1C0, 0x040, U }
    dw $1058 : db $0B ; Heart       xyz:{ 0x160, 0x100, U }
    dw $FFFF

    ; $00E51D
    .Room00DC
    dw $0438 : db $07 ; Blue rupee  xyz:{ 0x0E0, 0x040, U }
    dw $0470 : db $0A ; Bomb        xyz:{ 0x1C0, 0x040, U }
    dw $1044 : db $0B ; Heart       xyz:{ 0x110, 0x100, U }
    dw $1C0C : db $09 ; 5 arrows    xyz:{ 0x030, 0x1C0, U }

    ; $00E529
    .Room00DD
    .Room00DE
    .Room00DF
    dw $FFFF

    ; $00E52B
    .Room00E0
    dw $0818 : db $0B ; Heart       xyz:{ 0x060, 0x080, U }

    ; $00E52E
    .Room00E1
    .Room00E2
    dw $FFFF

    ; $00E530
    .Room00E3
    dw $3964 : db $01 ; Green rupee xyz:{ 0x190, 0x190, L }
    dw $FFFF

    ; $00E535
    .Room00E4
    dw $0920 : db $07 ; Blue rupee  xyz:{ 0x080, 0x090, U }
    dw $0A70 : db $01 ; Green rupee xyz:{ 0x1C0, 0x0A0, U }
    dw $FFFF

    ; $00E53D
    .Room00E5
    dw $0430 : db $01 ; Green rupee xyz:{ 0x0C0, 0x040, U }
    dw $044C : db $01 ; Green rupee xyz:{ 0x130, 0x040, U }
    dw $1070 : db $01 ; Green rupee xyz:{ 0x1C0, 0x100, U }
    dw $1240 : db $07 ; Blue rupee  xyz:{ 0x100, 0x120, U }
    dw $FFFF

    ; $00E54B
    .Room00E6
    dw $0C6C : db $09 ; 5 arrows    xyz:{ 0x1B0, 0x0C0, U }
    dw $1058 : db $0B ; Heart       xyz:{ 0x160, 0x100, U }
    dw $1838 : db $01 ; Green rupee xyz:{ 0x0E0, 0x180, U }
    dw $FFFF

    ; $00E556
    .Room00E7
    dw $0544 : db $01 ; Green rupee xyz:{ 0x110, 0x050, U }
    dw $0548 : db $01 ; Green rupee xyz:{ 0x120, 0x050, U }
    dw $FFFF

    ; $00E55E
    .Room00E8
    dw $0460 : db $0B ; Heart       xyz:{ 0x180, 0x040, U }

    ; $00E561
    .Room00E9
    .Room00EA
    dw $FFFF

    ; $00E563
    .Room00EB
    dw $08CE : db $07 ; Blue rupee  xyz:{ 0x138, 0x080, U }
    dw $08D2 : db $07 ; Blue rupee  xyz:{ 0x148, 0x080, U }
    dw $0E58 : db $0C ; Small magic xyz:{ 0x160, 0x0E0, U }
    dw $0E5C : db $0B ; Heart       xyz:{ 0x170, 0x0E0, U }
    dw $0E60 : db $0C ; Small magic xyz:{ 0x180, 0x0E0, U }

    ; $00E572
    .Room00EC
    .Room00ED
    .Room00EE
    .Room00EF
    .Room00F0
    dw $FFFF

    ; $00E574
    .Room00F1
    dw $0540 : db $0B ; Heart       xyz:{ 0x100, 0x050, U }

    ; $00E577
    .Room00F2
    .Room00F3
    .Room00F4
    .Room00F5
    .Room00F6
    .Room00F7
    dw $FFFF

    ; $00E579
    .Room00F8
    dw $0DF2 : db $0D ; Full magic  xyz:{ 0x1C8, 0x0D0, U }

    ; $00E57C
    .Room00F9
    .Room00FA
    .Room00FB
    .Room00FC
    dw $FFFF

    ; $00E57E
    .Room00FD
    dw $0658 : db $07 ; Blue rupee  xyz:{ 0x160, 0x060, U }
    dw $0664 : db $07 ; Blue rupee  xyz:{ 0x190, 0x060, U }
    dw $1754 : db $07 ; Blue rupee  xyz:{ 0x150, 0x170, U }
    dw $1854 : db $07 ; Blue rupee  xyz:{ 0x150, 0x180, U }

    ; $00E58A
    .Room00FE
    dw $FFFF

    ; $00E58C
    .Room00FF
    dw $085C : db $0B ; Heart       xyz:{ 0x170, 0x080, U }
    dw $0860 : db $0B ; Heart       xyz:{ 0x180, 0x080, U }
    dw $1C70 : db $01 ; Green rupee xyz:{ 0x1C0, 0x1C0, U }

    ; $00E595
    .Room0100
    dw $FFFF

    ; $00E597
    .Room0101
    dw $140C : db $0B ; Heart       xyz:{ 0x030, 0x140, U }
    dw $13E0 : db $0E ; Cucco       xyz:{ 0x180, 0x130, U }
    dw $13E4 : db $0B ; Heart       xyz:{ 0x190, 0x130, U }
    dw $FFFF

    ; $00E5A2
    .Room0102
    dw $1392 : db $0B ; Heart       xyz:{ 0x048, 0x130, U }
    dw $1396 : db $0B ; Heart       xyz:{ 0x058, 0x130, U }
    dw $FFFF

    ; $00E5AA
    .Room0103
    dw $078C : db $0E ; Cucco       xyz:{ 0x030, 0x070, U }
    dw $0C0C : db $0B ; Heart       xyz:{ 0x030, 0x0C0, U }
    dw $FFFF

    ; $00E5B2
    .Room0104
    dw $15CA : db $0B ; Heart       xyz:{ 0x128, 0x150, U }
    dw $16CA : db $0B ; Heart       xyz:{ 0x128, 0x160, U }
    dw $17CA : db $0B ; Heart       xyz:{ 0x128, 0x170, U }
    dw $FFFF

    ; $00E5BD
    .Room0105
    dw $141E : db $0B ; Heart       xyz:{ 0x078, 0x140, U }
    dw $151C : db $0B ; Heart       xyz:{ 0x070, 0x150, U }
    dw $1520 : db $0B ; Heart       xyz:{ 0x080, 0x150, U }

    ; $00E5C6
    .Room0106
    dw $FFFF

    ; $00E5C8
    .Room0107
    dw $17D6 : db $0A ; Bomb        xyz:{ 0x158, 0x170, U }
    dw $17DE : db $09 ; 5 arrows    xyz:{ 0x178, 0x170, U }
    dw $17E6 : db $0A ; Bomb        xyz:{ 0x198, 0x170, U }
    dw $19D6 : db $01 ; Green rupee xyz:{ 0x158, 0x190, U }
    dw $19E6 : db $01 ; Green rupee xyz:{ 0x198, 0x190, U }
    dw $1BD6 : db $0A ; Bomb        xyz:{ 0x158, 0x1B0, U }
    dw $1BE6 : db $0A ; Bomb        xyz:{ 0x198, 0x1B0, U }
    dw $FFFF

    ; $00E5DF
    .Room0108
    dw $13A6 : db $0E ; Cucco       xyz:{ 0x098, 0x130, U }

    ; $00E5E2
    .Room0109
    .Room010A
    .Room010B
    dw $FFFF

    ; $00E5E4
    .Room010C
    dw $0E58 : db $0B ; Heart       xyz:{ 0x160, 0x0E0, U }

    ; $00E5E7
    .Room010D
    .Room010E
    .Room010F
    .Room0110
    .Room0111
    .Room0112
    .Room0113
    dw $FFFF

    ; $00E5E9
    .Room0114
    dw $045C : db $0B ; Heart       xyz:{ 0x170, 0x040, U }
    dw $0460 : db $0B ; Heart       xyz:{ 0x180, 0x040, U }
    dw $055C : db $0A ; Bomb        xyz:{ 0x170, 0x050, U }
    dw $0560 : db $0A ; Bomb        xyz:{ 0x180, 0x050, U }
    dw $0A5C : db $09 ; 5 arrows    xyz:{ 0x170, 0x0A0, U }
    dw $0A60 : db $0B ; Heart       xyz:{ 0x180, 0x0A0, U }

    ; $00E5FB
    .Room0115
    .Room0116
    dw $FFFF

    ; $00E5FD
    .Room0117
    dw $038A : db $0B ; Heart       xyz:{ 0x028, 0x030, U }
    dw $038E : db $0B ; Heart       xyz:{ 0x038, 0x030, U }
    dw $03A6 : db $0B ; Heart       xyz:{ 0x098, 0x030, U }
    dw $03AA : db $0B ; Heart       xyz:{ 0x0A8, 0x030, U }
    dw $048A : db $0B ; Heart       xyz:{ 0x028, 0x040, U }
    dw $048E : db $0B ; Heart       xyz:{ 0x038, 0x040, U }
    dw $04A6 : db $0B ; Heart       xyz:{ 0x098, 0x040, U }
    dw $04AA : db $0B ; Heart       xyz:{ 0x0A8, 0x040, U }

    ; $00E615
    .Room0118
    dw $FFFF

    ; $00E617
    .Room0119
    dw $1C2C : db $0B ; Heart       xyz:{ 0x0B0, 0x1C0, U }
    dw $1C30 : db $01 ; Green rupee xyz:{ 0x0C0, 0x1C0, U }
    dw $1C4C : db $0B ; Heart       xyz:{ 0x130, 0x1C0, U }
    dw $1C50 : db $0B ; Heart       xyz:{ 0x140, 0x1C0, U }
    dw $FFFF

    ; $00E625
    .Room011A
    dw $0AD6 : db $0B ; Heart       xyz:{ 0x158, 0x0A0, U }
    dw $0ADA : db $0B ; Heart       xyz:{ 0x168, 0x0A0, U }
    dw $0AE2 : db $0B ; Heart       xyz:{ 0x188, 0x0A0, U }
    dw $0AE6 : db $0B ; Heart       xyz:{ 0x198, 0x0A0, U }
    dw $FFFF

    ; $00E633
    .Room011B
    dw $3618 : db $0B ; Heart       xyz:{ 0x060, 0x160, L }
    dw $3620 : db $0B ; Heart       xyz:{ 0x080, 0x160, L }
    dw $3628 : db $0B ; Heart       xyz:{ 0x0A0, 0x160, L }
    dw $165C : db $0A ; Bomb        xyz:{ 0x170, 0x160, U }
    dw $1660 : db $0B ; Heart       xyz:{ 0x180, 0x160, U }
    dw $3718 : db $0B ; Heart       xyz:{ 0x060, 0x170, L }
    dw $175C : db $0A ; Bomb        xyz:{ 0x170, 0x170, U }
    dw $1760 : db $0B ; Heart       xyz:{ 0x180, 0x170, U }
    dw $381C : db $0B ; Heart       xyz:{ 0x070, 0x180, L }
    dw $185C : db $0A ; Bomb        xyz:{ 0x170, 0x180, U }
    dw $1860 : db $0B ; Heart       xyz:{ 0x180, 0x180, U }
    dw $195C : db $0A ; Bomb        xyz:{ 0x170, 0x190, U }
    dw $1960 : db $0B ; Heart       xyz:{ 0x180, 0x190, U }

    ; $00E65A
    .Room011C
    dw $FFFF

    ; $00E65C
    .Room011D
    dw $063C : db $07 ; Blue rupee  xyz:{ 0x0F0, 0x060, U }
    dw $0640 : db $07 ; Blue rupee  xyz:{ 0x100, 0x060, U }
    dw $073C : db $07 ; Blue rupee  xyz:{ 0x0F0, 0x070, U }
    dw $0740 : db $07 ; Blue rupee  xyz:{ 0x100, 0x070, U }
    dw $083C : db $07 ; Blue rupee  xyz:{ 0x0F0, 0x080, U }
    dw $0840 : db $07 ; Blue rupee  xyz:{ 0x100, 0x080, U }

    ; $00E66E
    .Room011E
    dw $FFFF

    ; $00E670
    .Room011F
    dw $1CAE : db $0B ; Heart       xyz:{ 0x0B8, 0x1C0, U }
    dw $1CB2 : db $0B ; Heart       xyz:{ 0x0C8, 0x1C0, U }

    ; $00E676
    .Room0120
    .Room0121
    .Room0122
    .Room0123
    dw $FFFF

    ; $00E678
    .Room0124
    dw $1414 : db $07 ; Blue rupee  xyz:{ 0x050, 0x140, U }
    dw $1428 : db $07 ; Blue rupee  xyz:{ 0x0A0, 0x140, U }
    dw $1514 : db $07 ; Blue rupee  xyz:{ 0x050, 0x150, U }
    dw $1528 : db $07 ; Blue rupee  xyz:{ 0x0A0, 0x150, U }
    dw $1614 : db $07 ; Blue rupee  xyz:{ 0x050, 0x160, U }
    dw $1628 : db $07 ; Blue rupee  xyz:{ 0x0A0, 0x160, U }
    dw $1818 : db $07 ; Blue rupee  xyz:{ 0x060, 0x180, U }
    dw $181C : db $07 ; Blue rupee  xyz:{ 0x070, 0x180, U }
    dw $1820 : db $07 ; Blue rupee  xyz:{ 0x080, 0x180, U }
    dw $1824 : db $07 ; Blue rupee  xyz:{ 0x090, 0x180, U }
    dw $FFFF

    ; $00E698
    .Room0125
    dw $1918 : db $07 ; Blue rupee  xyz:{ 0x060, 0x190, U }
    dw $191C : db $07 ; Blue rupee  xyz:{ 0x070, 0x190, U }
    dw $1920 : db $07 ; Blue rupee  xyz:{ 0x080, 0x190, U }
    dw $1924 : db $07 ; Blue rupee  xyz:{ 0x090, 0x190, U }
    dw $1658 : db $0B ; Heart       xyz:{ 0x160, 0x160, U }
    dw $1664 : db $0B ; Heart       xyz:{ 0x190, 0x160, U }
    dw $1C58 : db $0B ; Heart       xyz:{ 0x160, 0x1C0, U }
    dw $1C64 : db $0B ; Heart       xyz:{ 0x190, 0x1C0, U }

    ; $00E6B0
    .Room0126
    .Room0127
    .Room0128
    .Room0129
    .Room012A
    .Room012B
    .Room012C
    .Room012D
    .Room012E
    .Room012F
    .Room0130
    .Room0131
    .Room0132
    .Room0133
    .Room0134
    .Room0135
    .Room0136
    .Room0137
    .Room0138
    .Room0139
    .Room013A
    .Room013B
    .Room013C
    .Room013D
    .Room013E
    .Room013F
    dw $FFFF
}

; ==============================================================================

; Seems to load "secrets" data from ROM when a secret is exposed by various
; means.
; $00E6B2-$00E794 LOCAL JUMP LOCATION
Dungeon_LoadSecret:
{
    STA.b $04
    
    ; TODO: Unknown variable.
    LDA.w $0B9C : AND.w #$FF00 : STA.w $0B9C
    
    ; Load the room, multiply by 2, send to X register.
    LDA.b $A0 : ASL A : TAX
    
    ; Secrets pointer array (16-bit local pointer for each of the 0x140 rooms).
    LDA.l RoomData_PotItems_Pointers, X : STA.b $00
    
    ; When moving the secrets data, this will make it cake.
    LDA.w #$0001 : STA.b $02
    
    LDY.w #$FFFD
    LDX.w #$FFFF
    
    .nextSecret
        INY #3
        
        ; Load up the first word of data. Terminate if it matches this value.
        LDY [$00], Y : CMP.w #$FFFF : BEQ .return
            ; Tells us how many bits to shift in when saving this info.
            INX
    
    ; $04 is the tilemap address in question.
    ; Loop until we find it or run out of options.
    AND.w #$7FFF : CMP.b $04 : BNE .nextSecret
    
    ; In this case, the address matched.
    INY #2
    
    ; Load the next word (but only need a byte).
    ; Terminate if it is nothing... (why would you put nothing?).
    LDA [$00], Y : AND.w #$00FF : BEQ .return
        ; If item >= 0x80, handle them specially.
        CMP.w #$0080 : BCS .specialSecret
            ; Check to see if it's a key.
            STA.b $0E : CMP.w #$0008 : BEQ .isKey
                ; Y corresponds to the bit in the secrets data that will be set
                ; after being revealed. It will be used to set a flag that will
                ; no be set until Link leaves the dungeon or uses the magic
                ; mirror in the dungeon.
                TXY
                
                ; X = room index * 2.
                LDA.b $A0 : ASL A : TAX
                
                STZ.b $00
                
                SEC
            
                .findBit
            
                    ROL.b $00
                DEY : BPL .findBit
                
                LDA.l $7EF580, X : AND.b $00 : BNE .return
                    LDA.l $7EF580, X : ORA.b $00 : STA.l $7EF580, X
                    
                    LDA.b $0E
        
        .isKey
    
        TSB.w $0B9C
    
    .return
    
    RTS
    
    .specialSecret
    
    CMP.w #$0088 : BEQ .isSwitch
        ; The last available option seems to be a 32x32 pixel hole...
        ; Afaik this is only used in one dungeon (ice palace).
        
        LDX.b $06
        
        LDA.l $7F2000, X : AND.w #$000F : ASL A : TAY
        
        LDA.w $0500, Y : AND.w #$000F : ASL A : STA.b $00
        
        TYA : SEC : SBC.b $00 : STA.w $042C : TAY
        
        LDA.w #$0004 : STA.b $00
        
        SEP #$20
        
        ; Play the Zelda puzzle solved sound.
        LDA.b #$1B : STA.w $012F
        
        REP #$20
        
        LDX.w #$05BA
        
        .drawHole
        
            LDA.l RoomDrawObjectData+0, X : STA.w $0560, Y
            LDA.l RoomDrawObjectData+2, X : STA.w $0580, Y
            LDA.l RoomDrawObjectData+4, X : STA.w $05A0, Y
            LDA.l RoomDrawObjectData+6, X : STA.w $05C0, Y
            
            TXA : CLC : ADC.w #$0008 : TAX
            
            INY #2
        DEC.b $00 : BNE .drawHole
        
        RTS
    
    .isSwitch
    
    ; Switch under a pot is revealed.
    
    LDY.w $042C
    
    ; Buffer some tiles to be saved to the tilemap after the pot is lifted
    ; the tiles are the tiles for the switch.
    LDA.w #$0D0B : STA.w $0560, Y
    LDA.w #$0D1B : STA.w $0580, Y
    LDA.w #$4D0B : STA.w $05A0, Y
    LDA.w #$4D1B : STA.w $05C0, Y
    
    RTS
}

; ==============================================================================

; $00E795-$00E7A8 DATA
Dungeon_PrepSpriteInducedDma_replacement_tiles:
{
    dw $00E0 ; 0x00 - pit (floor, rather?) (empty space?)
    dw $0ADE ; 0x02 - spike block
    dw $05AA ; 0x04 - pit
    dw $0198 ; 0x06 - hole from floor tile lifting up and attacking you
    dw $0210 ; 0x08 - ice man tile part 1
    dw $0218 ; 0x0A - ice man tile part 2
    dw $1F3A ; 0x0C - I think this one is unused. Could be interesting to know what the tiles were intended for.
    dw $0EAA ; 0x0E - Perky trigger Tile
    dw $0EB2 ; 0x10 - Depressed trigger tile
    dw $0140 ; 0x12 - Trinexx ice tile (pretty sure, but not certain)
}

; ==============================================================================

; Somehow this routine is related to ice men, moving spike blocks, and
; laser eye that can turn into doorways. Could you really pick a stranger
; bunch? The unifying quality is that you all have tilemap entries changing
; and sometimes turning into sprites. Other things this is related to:
; swimmers in swamp palace that come out of walls.
    
; The parameter to this subroutine, the Y register, should be even when calling
; it.
; $00E7A9-$00E7DE LONG JUMP LOCATION
Dungeon_SpriteInducedTilemapUpdate:
{
    PHX
    
    STY.b $0E : STZ.b $0F
    
    PHB : LDA.b #$00 : PHA : PLB
    
    REP #$30
    
    LDA.b $0E : CMP.w #$0008 : BNE .not_ice_man
        PHA
        
        INC #2 : STA.b $0E
        
        LDA.b $00 : PHA
        
        CLC : ADC.w #$0010 : STA.b $00
        
        JSR.w Dungeon_PrepSpriteInducedDma
        
        PLA : STA.b $00
        PLA : STA.b $0E
    
    .not_ice_man
    
    JSR.w Dungeon_PrepSpriteInducedDma
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    PLB
    
    PLX
    
    RTL
}

; ==============================================================================

; $00E7DF-$00E898 LOCAL JUMP LOCATION
Dungeon_PrepSpriteInducedDma:
{
    ; Convert coordiates to tilemap position.
    LDA.b $02 : INC A : AND.w #$01F8 : ASL #3 : STA.b $06
    LDA.b $00         : AND.w #$01F8 : LSR #3 : ORA.b $06 : ASL A : STA.b $06
    
    LDX.b $0E
    
    LDA.l .replacement_tiles, X : TAY
    
    LDX.w $1000
    
    LDA.w RoomDrawObjectData+00, Y : STA.w $1006, X
    LDA.w RoomDrawObjectData+02, Y : STA.w $100C, X
    LDA.w RoomDrawObjectData+04, Y : STA.w $1012, X
    LDA.w RoomDrawObjectData+06, Y : STA.w $1018, X
    
    LDX.b $06
    
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2002, X
    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2082, X
    
    AND.w #$03FF : TAX
    
    LDA.l $7EFE00, X : AND.w #$00FF : STA.b $08 : STA.b $09
    
    LDA.b $06 : LSR A : TAX
    
    LDA.b $08 : STA.l $7F2000, X
              STA.l $7F2040, X
    
    LDX.w $1000
    
    LDA.w #$0000
    
    JSR.w Dungeon_GetRelativeVramAddr_2
    
    STA.w $1002, X
    
    LDA.w #$0080
    
    JSR.w Dungeon_GetRelativeVramAddr_2
    
    STA.w $1008, X
    
    LDA.w #$0002
    
    JSR.w Dungeon_GetRelativeVramAddr_2
    
    STA.w $100E, X
    
    LDA.w #$0082
    
    JSR.w Dungeon_GetRelativeVramAddr_2
    
    STA.w $1014, X
    
    LDA.w #$0100
    STA.w $1004, X : STA.w $100A, X
    STA.w $1010, X : STA.w $1016, X
    
    LDA.w #$FFFF : STA.w $101A, X
    
    TXA : CLC : ADC.w #$0018 : STA.w $1000
    
    RTS
}

; ==============================================================================

; $00E899-$00E8BC LOCAL JUMP LOCATION
Dungeon_GetRelativeVramAddr_2:
{
    CLC : ADC.b $06 : STA.b $0E
    
                AND.w #$0040 : LSR #4 : XBA       : STA.b $08
    LDA.b $0E : AND.w #$303F : LSR A  : ORA.b $08 : STA.b $08
    LDA.b $0E : AND.w #$0F80 : LSR #2 : ORA.b $08 : XBA
    
    RTS
}

; ==============================================================================

; $00E8BD-$00E949 LONG JUMP LOCATION
Dungeon_ClearRupeeTile:
{
    PHB : LDA.b #$00 : PHA : PLB
    
    REP #$30
    
    LDA.b $00 : AND.w #$01F8 : ASL #3 : STA.b $06
    LDA.b $02 : AND.w #$01F8 : LSR #3 : ORA.b $06 : ASL A : STA.b $06
    
    LDX.w $1000
    
    LDA.w #$190F : STA.w $1006, X : STA.w $100C, X
    
    LDX.b $06
    
    STA.l $7E2000, X : STA.l $7E2080, X
    
    AND.w #$03FF : TAX
    
    LDA.l $7EFE00, X : AND.w #$00FF : STA.b $08 : STA.b $09
    
    LDA.b $06 : LSR A : TAX
    
    LDA.b $08 : STA.l $7F2000, X : STA.l $7F2040, X
    
    LDX.w $1000
    LDA.w #$0000
    JSR.w Dungeon_GetRelativeVramAddr
    
    STA.w $1002, X
    LDA.w #$0080
    JSR.w Dungeon_GetRelativeVramAddr
    
    STA.w $1008, X
    
    LDA.w #$0100 : STA.w $1004, X : STA.w $100A, X
    
    LDA.w #$FFFF : STA.w $100E, X
    
    TXA : CLC : ADC.w #$0018 : STA.w $1000
    
    SEP #$30
    
    LDA.w $0403 : ORA.b #$10 : STA.w $0403
    
    LDA.b #$01 : STA.b $14
    
    PLB
    
    RTL
}

; ==============================================================================

; $00E94A-$00E96D LOCAL JUMP LOCATION
Dungeon_GetRelativeVramAddr:
{
    CLC : ADC.b $06 : STA.b $0C
    
                AND.w #$0040 : LSR #4 : XBA       : STA.b $08
    LDA.b $0C : AND.w #$303F : LSR A  : ORA.b $08 : STA.b $08
    LDA.b $0C : AND.w #$0F80 : LSR #2 : ORA.b $08 : XBA
    
    RTS
}

; ==============================================================================

; Top byte of each entry is the item to give, bottom 15 bits are the room.
; if bit 15 (0x8000) is set, it's for a big chest.
; $00E96E-$00EB65
Dungeon_ChestData:
{
    dl $240032, $120055, $0C0071, $2500A8, $190113, $0B80A9, $280016, $250016
    dl $330037, $0A8036, $28010B, $1B8073, $250067, $28007E, $078058, $330058
    dl $320057, $240057, $32001F, $24007E, $22809E, $330077, $280005, $4000B9
    dl $330074, $3200B8, $120104, $4100FE, $320075, $17010C, $240068, $250085
    dl $160103, $36013D, $25002E, $36012D, $2400B3, $33003F, $24005F, $2400AE
    dl $320087, $0C0108, $2A0106, $46011C, $17010A, $3300AA, $1F8027, $250027
    dl $240059, $3300DB, $3200DB, $2500DC, $3600CB, $280065, $1C8044, $240045
    dl $2400B6, $068024, $3300B7, $2400B7, $2500D6, $320014, $3400D5, $3500D5
    dl $3600D5, $2400D5, $240004, $32003A, $24002A, $24002A, $09801A, $25001A
    dl $35001A, $24000A, $43006A, $24006A, $33002B, $280019, $240019, $240009
    dl $2400C2, $2400A2, $2500C1, $1580C3, $3300C3, $3200D1, $2400B3, $17010D
    dl $36010D, $3F0012, $2800F8, $3600F8, $410105, $280105, $410105, $180117
    dl $17002F, $36002F, $36002F, $36002F, $28002F, $240028, $250046, $360034
    dl $320035, $360076, $360076, $360066, $2400D0, $2400E0, $28007B, $44007B
    dl $36007B, $36007B, $44007C, $44007C, $28007C, $28007C, $24007D, $33008B
    dl $23808C, $44008C, $28008C, $44008C, $24008D, $25009D, $34009D, $36009D
    dl $44009D, $32001C, $44001C, $28001C, $24005B, $28003D, $28003D, $24003D
    dl $36004D, $120080, $330072, $17011D, $36011D, $36011D, $36011D, $36011D
    dl $36011E, $36011E, $36011E, $36011E, $3600EF, $3600EF, $3600EF, $3600EF
    dl $3600EF, $2800FF, $4400FF, $170124, $280123, $360123, $360123, $440123
    dl $080120, $41003C, $41003C, $41003C, $41003C, $280011, $460011, $440011
}
    
; ==============================================================================

; SearchForChest()
; $00EB66-$00ED04 LONG JUMP LOCATION
Dungeon_OpenKeyedObject:
{
    ; Data loads are coming from bank00.
    PHB : LDX.b #$00 : PHX : PLB
    
    CMP.b #$63 : BNE .notMiniGameChest
        JMP Dungeon_OpenMinigameChest
    
    .notMiniGameChest
    
    REP #$30
    
    ; Obtain the tile type of the object and put it in the {0..5} range.
    AND.w #$00FF : SEC : SBC.w #$0058 : STA.b $0E
    
    ASL A : PHA : TAY : PHY
    
    ; If it's not a big key lock.
    LDA.w $06E0, Y : CMP.w #$8000 : BCC .notBigKeyLock
        ; It's a big key lock. We have to examine the Big Key data.
        LDX.w $040C
        
        ; (this is the Big Key data).
        ; Branch if we have the Big Key.
        LDA.l $7EF366 : AND.l DungeonMask, X : BNE .openBigKeyLock
            ; It's the "Eh? You don't have the big key" crap text message.
            LDA.w #$007A : STA.w $1CF0
            
            SEP #$30
            
            JSL.l Main_ShowTextMessage
            
            REP #$30
            
            BRA .cantOpenBigKeyLock
        
        .openBigKeyLock
        
        ; Set it so that the chest/lock is unlocked.
        LDA.w $0402 : ORA.w RoomFlagMask, Y : STA.w $0402
        
        ; Chest opening noise.
        LDA.w #$1529 : STA.w $012E
        
        LDA.w $06E0, Y : AND.w #$7FFF : TAX
        
        LDY.w $046A
        
        ; Draw floor tiles over the old ones (won't be permanent).
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.b $02
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X : STA.b $04
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2002, X : STA.b $06
        LDA.w RoomDrawObjectData+06, Y
        
        JMP .storeTilemapChanges
        
        .couldntFindChest
        
        PLX
        
        .cantOpenBigKeyLock
        
        PLY : PLA
        
        SEP #$30
        
        PLB
        
        CLC
        
        RTL
    
    .notBigKeyLock
    
    AND.w #$7FFF : TAX : PHX
    
    INC.b $0E
    
    LDX.w #$FFFD
    
    .nextChest
    
            ; This limits us to 168 chests... might have to change.
            INX #3 : CPX.w #$01F8 : BEQ .couldntFindChest
        ; An array of chest data, including the room and item number.
        ; Does the room in the data match the room we're in?
        LDA Dungeon_ChestData, X : AND.w #$7FFF : CMP.b $A0 : BNE .nextChest
    ; Not sure why this is here yet...
    DEC.b $0E : BNE .nextChest
    
    ; Load the item value.
    LDA Dungeon_ChestData+2, X : STA.b $0C
    
    ; Load the room index for the chest.
    LDA Dungeon_ChestData, X : ASL A : BCC .smallChest
        ; Otherwise it's a (you guessed it...) Big Chest.
        LDX.w $040C
        
        ; Make sure we have the key to it.
        LDA.l $7EF366 : AND.l DungeonMask, X : BEQ .cantOpenBigChest
            PLX : PLA
            
            JMP Dungeon_OpenBigChest
        
        .cantOpenBigChest
        
        PLX : PLY : PLA
        
        ; Again the "eh, you don't have the big key" message...
        LDA.w #$007A : STA.w $1CF0
        
        SEP #$30
        
        JSL.l Main_ShowTextMessage
        
        PLB
        
        CLC
        
        RTL
    
    .smallChest
    
    PLX
    
    ; TODO: Check whether this refference and all other references to
    ; RoomFlagMask should be long or not.
    ; Load room information about chests. Indicate to the game that this chest
    ; has been opened.
    LDA.w $0402 : ORA RoomFlagMask, Y : STA.w $0402
    
    LDY.w #$14A4
    
    ; I guess this changes the tiles of the chest.
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.b $02
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X : STA.b $04
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2002, X : STA.b $06
    LDA.w RoomDrawObjectData+06, Y
    
    .storeTilemapChanges
    
    STA.l $7E2082, X : STA.b $08
    
    PLY
    
    LDA.w #$2727 : STA.b $00
    
    ; Is this a big key lock?
    LDA.w $06E0, Y : CMP.w #$8000 : BCC .notBigKeyLock2
        AND.w #$7FFF
        
        ; Use tile attr of 0x00 for each updated tile instead.
        STZ.b $00
    
    .notBigKeyLock2
    
    LSR A : TAX
    
    LDA.b $00 : STA.l $7F2000, X : STA.l $7F2040, X
    
    LDX.w $1000
    LDA.w #$0000
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $1002, X
    LDA.w #$0080
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $1008, X
    LDA.w #$0002
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $100E, X
    LDA.w #$0082
    JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
    
    STA.w $1014, X
    
    LDA.b $02 : STA.w $1006, X
    LDA.b $04 : STA.w $100C, X
    LDA.b $06 : STA.w $1012, X
    LDA.b $08 : STA.w $1018, X
    
    ; Two bytes for each dma transfer. Source address increment mode is
    ; incremental, VRAM address increment mode is horizontal.
    LDA.w #$0100
    STA.w $1004, X : STA.w $100A, X : STA.w $1010, X : STA.w $1016, X
    
    LDA.w #$FFFF : STA.w $101A, X
    
    TXA : CLC : ADC.w #$0018 : STA.w $1000
    
    SEP #$30
    
    ; A flag indicating to update the tilemap.
    LDA.b #$01 : STA.b $14
    
    JSR.w Dungeon_SaveRoomQuadrantData
    
    ; Is there a sound channel available?
    LDA.w $012F : BNE .sfx3ChannelNotAvailable
        ; Make the "chest opening" noise.
        LDA.b #$0E : STA.w $012F
    
    .sfx3ChannelNotAvailable
    
    REP #$30
    
    PLY
    
    ; The ReceiveItem portion of the game's code needs this as input to
    ; know the offset at which to place the item sprite.
    LDA.w $06E0, Y : AND.w #$7FFF : STA.b $72
    
    SEP #$31
    
    PLB
    
    RTL
}

; ==============================================================================

; $00ED05-$00ED88 JUMP LOCATION
Dungeon_OpenBigChest:
{
    LDA.w $0402 : ORA.w RoomFlagMask, Y : STA.w $0402
    
    STX.b $08
    
    LDA.w #$0004 : STA.b $0E
    
    LDY.w #$14C4
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        
        INY #6
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    LDA.b $0C : PHA
    
    JSR.w Dungeon_PrepOverlayDma_tilemapAlreadyUpdated
    
    LDY.b $0C
    
    LDA.w #$FFFF : STA.w $1100, Y
    
    PLA : STA.b $0C
    
    PLY
    
    LDA.w $06E0, Y : AND.w #$7FFF : PHA
    
    INC #2 : STA.b $72
    
    PLA : LSR A : TAX
    
    LDA.w #$2727
    STA.l $7F2000, X : STA.l $7F2002, X : STA.l $7F2040, X 
    STA.l $7F2042, X : STA.l $7F2080, X : STA.l $7F2082, X
    
    SEP #$31
    
    PLB
    
    JSL.l Dungeon_SaveRoomQuadrantData
    
    LDA.b #$0E : STA.w $012F
    
    LDA.b #$01 : STA.b $18
                 STA.w $0B9E
    
    SEC
    
    RTL
}

; ==============================================================================

; $00ED89-$00EDA2 BRANCH LOCATION
Dungeon_ShowMinigameChestMessage:
{
    .didnt_pay
    
    STA.b $C8
    
    REP #$20
    
    ; "Hey kid! You can open a chest after paying Rupees!"
    LDA.w #$0162
    
    BRA .showDialogue
    
    ; $00ED92 ALTERNATE ENTRY POINT
    .out_of_credits
    
    REP #$20
    
    ; "You can't open any more chests. The game is over."
    LDA.w #$0163
    
    .showDialogue
    
    STA.w $1CF0
    
    SEP #$20
    
    JSL.l Main_ShowTextMessage
    
    PLB
    
    CLC
    
    RTL
}

; ==============================================================================

; $00EDA3-$00EDAA DATA
Dungeon_MinigameChestPrizes:
{
    ; 100 rupees, 50 rupees, 1 rupee, single heart, 1 array,
    ; 10 arrows, bomb refill, heart piece, respectively.
    db $40, $41, $34, $42, $43, $44, $27, $17
}

; ==============================================================================

; $00EDAB-$00EED6 LONG JUMP LOCATION
Dungeon_OpenMiniGameChest:
{
    ; Number of credits left for opening minigame chests triggers....
    ; "you need to buy more" message?
    LDA.w $04C4 : BEQ Dungeon_ShowMinigameChestMessage_out_of_credits
        ; Triggers "you need to talk to me about my game" message?
        CMP.b #$FF : BEQ Dungeon_ShowMinigameChestMessage_didnt_pay
        
            ; Reduce number of credits.
            DEC.w $04C4
            
            REP #$30
            
            LDA.b $20 : SEC : SBC.w #$0004 : STA.b $00
            AND.w #$01F8 : ASL #3 : STA.b $06
            LDA.b $22 : CLC : ADC.w #$0007 : STA.b $02
            AND.w #$01F8 : LSR #3 : ORA.b $06 : TAX
            
            ; Make sure the tiles we're touching are actually minigame chest
            ; tiles.
            LDA.l $7F2000, X : CMP.w #$6363 : BEQ .match
                DEX
                
                LDA.l $7F2000, X : CMP.w #$6363 : BEQ .match
                    INX #2
            
            .match
            
            ; Make chest tiles impassible now.
            LDA.w #$0202 : STA.l $7F2000, X : STA.l $7F2040, X
            
            TXA : ASL A : STA.b $72
            
            CLC : ADC.w #$0100 : TAX : STA.b $0C
            
            ; Set replacement tiles to be drawn.
            LDY.w #$14A4
            
            LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X : STA.b $02
            LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X : STA.b $04
            LDA.w RoomDrawObjectData+04, Y : STA.l $7E2002, X : STA.b $06
            LDA.w RoomDrawObjectData+06, Y : STA.l $7E2082, X : STA.b $08
            
            LDX.w $1000
            LDA.b $0C
            JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
            
            STA.w $1002, X
            LDA.b $0C : CLC : ADC.w #$0080
            JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
            
            STA.w $1008, X
            LDA.b $0C : CLC : ADC.w #$0002
            JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
            
            STA.w $100E, X
            LDA.b $0C : CLC : ADC.w #$0082
            JSR.w Dungeon_GetKeyedObjectRelativeVramAddr
            
            STA.w $1014, X
            
            LDA.b $02 : STA.w $1006, X
            LDA.b $04 : STA.w $100C, X
            LDA.b $06 : STA.w $1012, X
            LDA.b $08 : STA.w $1018, X
            
            LDA.w #$0100
            
            STA.w $1004, X : STA.w $100A, X
            STA.w $1010, X : STA.w $1016, X
            
            LDA.w #$FFFF : STA.w $101A, X
            
            TXA : CLC : ADC.w #$0018 : STA.w $1000
            
            SEP #$31
            
            ; Just checking different rooms that shops can be in this is and the
            ; following ones are actually 0x0100 and 0x0118 not rooms 0x0000 and
            ; 0x0018. It's implicit that Ganon doesn't have a shop in his room.
            LDA.b $A0 : BEQ Dungeon_GetRupeeChestMinigamePrize_highStakes
                CMP.b #$18 : BEQ Dungeon_GetRupeeChestMinigamePrize_lowStakes
                    ; Must be the village of outcasts chest game room.
                    JSL.l GetRandomInt : AND.b #$07 : TAX
                    
                    CPX.b #$02 : BCC .BRANCH_BETA
                        ; Make sure it's not the same thing we got last time?
                        CPX.b $C8 : BNE .BRANCH_BETA
                            TXA : INC A : AND.b #$07 : TAX
                    
                    .BRANCH_BETA
                    
                    CPX.b #$07 : BNE .BRANCH_GAMMA
                        ; Checking to see if you already got that heart piece.
                        LDA.w $0403 : AND.b #$40 : BNE .BRANCH_DELTA
                            ; Set the flag indicating you've gotten that heart
                            ; piece.
                            LDA.w $0403 : ORA.b #$40 : STA.w $0403
                            
                            BRA .BRANCH_GAMMA
                        
                        .BRANCH_DELTA
                        
                        LDX.b #$00
                    
                    .BRANCH_GAMMA
                    
                    LDA.l Dungeon_MinigameChestPrizes, X
                    
                    ; $00EEC5 ALTERNATE ENTRY POINT
                    .prizeExternallyDetermined
                    
                    ; Set the index of the last item Link received.
                    STX.b $C8
                    
                    STA.b $0C : STZ.b $0D
                    
                    LDA.b #$01 : STA.b $14
                    
                    LDA.b #$0E : STA.w $012F
                    
                    PLB
                    
                    SEC
                    
                    RTL
}

; ==============================================================================
 
; $00EED7-$00EEF6 DATA
Dungeon_RupeeChestMinigamePrizes:
{
    db $47, $34, $46, $34, $46, $46, $34, $47
    db $46, $47, $34, $46, $47, $34, $46, $47
    
    db $34, $47, $41, $47, $41, $41, $47, $34
    db $41, $34, $47, $41, $34, $47, $41, $34
}

; ==============================================================================

; $00EEF7-$00EF0E BRANCH LOCATION
Dungeon_GetRupeeChestMinigamePrize:
{
    .highStakes
    
    JSL.l GetRandomInt : AND.b #$0F
    
    BRA .BRANCH_ALPHA
    
    ; $00EEFF ALTERNATE ENTRY POINT
    .lowStakes
    
    JSL.l GetRandomInt : AND.b #$0F : CLC : ADC.w #$10
    
    .BRANCH_ALPHA
    
    TAX
    
    LDA.l Dungeon_RupeeChestMinigamePrizes, X
    
    BRA Dungeon_OpenMiniGameChest_prizeExternallyDetermined
}
    
; ==============================================================================

; In-game tilemap address format for dungeons:
;    --pvyyyy yhxxxxx-
;
;   p - Plane. 0 for BG2, 1 for BG1
;   v - Selects whether to use an upper or lower tilemap
;   y - 5-bit vertical tile offset
;   h - Selects whether to use a left or right tilemap
;   x - 5-bit horizontal tile offset
;
;    00000h00 00000000
; || 000pv000 000xxxxx
; || 000000yy yyy00000
; -> 000pvhyy yyyxxxxx
; -> yyyxxxxx 000pvhyy
; $00EF0F-$00EF33 LOCAL JUMP LOCATION
Dungeon_GetKeyedObjectRelativeVramAddr:
{
    ; OPTIMIZE: Whole routine takes 62 cycles. Could use some optimization?
    CLC : ADC.w $06E0, Y : STA.b $0E
    
                AND.w #$0040 : LSR #4 : XBA       : STA.b $0A
    LDA.b $0E : AND.w #$303F : LSR A  : ORA.b $0A : STA.b $0A
    LDA.b $0E : AND.w #$0F80 : LSR #2 : ORA.b $0A : XBA
    
    RTS
}
    
; ==============================================================================

; $00EF34-$00EF53 DATA
IncrementallyDrainSwampPool_window_direction:
{
    dw -1, -1, -1,  1
    dw -1, -1, -1,  1
    dw -1, -1, -1,  1
    dw -1, -1, -1,  1
}

; $00EF54-$00EFEB LONG JUMP LOCATION
IncrementallyDrainSwampPool:
{
    LDA.w $0424 : AND.b #$07 : BNE .BRANCH_ALPHA
        LDA.w $0424 : AND.b #$0C : LSR A : TAX
        
        REP #$20
        
        LDA.w $0684 : CMP.w $0688 : BEQ .BRANCH_BETA
            CLC : ADC.l .window_direction, X : STA.w $0684
            
            LDA.w $0686 : CLC : ADC.l .window_direction, X : STA.w $0686
            
            SEP #$30
            
            INC.w $0424
            
            JSL.l Hdma_ConfigureWaterTable
            
            RTL
    
    .BRANCH_ALPHA
    
    SEP #$30
    
    INC.w $0424
    
    JSL.l Hdma_ConfigureWaterTable
    
    RTL
    
    .BRANCH_BETA
    
    SEP #$30
    
    LDA.b #$02 : STA.b $99
    LDA.b #$32 : STA.b $9A
    
    STZ.w SNES.BGAndOBJEnableSubScreen
    STZ.b $1D
    STZ.b $96
    STZ.w $046C
    
    REP #$30
    
    STZ.b $1E
    
    LDX.w $0442 : BEQ .BRANCH_GAMMA
        LDY.w #$0000
        
        .BRANCH_DELTA
        
            LDX.w $06B8, Y
            
            LDA.w #$1D1D : STA.l $7F2041, X : STA.l $7F2081, X
        INY #2 : CPY.w $0442 : BNE .BRANCH_DELTA
    
    .BRANCH_GAMMA
    
    LDX.w $04AE : BEQ .BRANCH_EPSILON
        LDY.w #$0000
        
        .BRANCH_ZETA
        
            LDX.w $06EC, Y
            
            LDA.w #$1D1D : STA.l $7F2041, X : STA.l $7F2081, X
        INY #2 : CPY.w $04AE : BNE .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    SEP #$30
    
    INC.b $15
    INC.b $B0
    
    RTL
}

; ==============================================================================

; $00EFEC-$00F045 LONG JUMP LOCATION
DeleteSwampPoolWaterOverlay:
{
    REP #$30

    LDX.w #$0000
    LDY.w #$01E0

    LDA.w RoomDrawObjectData+00, Y

    .BRANCH_ALPHA

        STA.l $7E4000, X : STA.l $7E4200, X
        STA.l $7E4400, X : STA.l $7E4600, X
        STA.l $7E4800, X : STA.l $7E4A00, X
        STA.l $7E4C00, X : STA.l $7E4E00, X
        STA.l $7E5000, X : STA.l $7E5200, X
        STA.l $7E5400, X : STA.l $7E5600, X
        STA.l $7E5800, X : STA.l $7E5A00, X
        STA.l $7E5C00, X : STA.l $7E5E00, X
    INX #2 : CPX.w #$0200 : BNE .BRANCH_ALPHA

    SEP #$30

    STZ.w $045C

    INC.b $B0

    RTL
}

; ==============================================================================

; $00F046-$00F062 JUMP LOCATION
Underworld_FloodSwampWater_PrepTilemap:
{
    JSL.l WaterFlood_BuildOneQuadrantForVRAM
    
    LDA.w $045C : CLC : ADC.b #$04 : STA.w $045C
    
    INC.b $B0 : LDA.b $B0 : CMP.b #$06 : BNE .notFinished
        STZ.w $045C : STZ.b $B0 : STZ.b $11
    
    .notFinished
    
    RTL
}

; ==============================================================================

; $00F063-$00F07A DATA
WaterDrainSpeed:
{
    ; $00F063
    .tub_fill
    dw  1,  1,  1, -1

    ; $00F06B
    .floor_flood
    dw  1,  2,  1, -1

    ; $00F073
    .flood_width
    dw  1, -1,  1, -1
}

; ==============================================================================

; $00F07B-$00F092 JUMP TABLE
Dungeon_TurnOnWaterLong_handlers:
{
    dw Underworld_FloodSwampWater_PrepTilemap  ; 0x00 - $F046
    dw Underworld_FloodSwampWater_PrepTilemap  ; 0x01 - $F046
    dw Underworld_FloodSwampWater_PrepTilemap  ; 0x02 - $F046
    dw Underworld_FloodSwampWater_PrepTilemap  ; 0x03 - $F046
    dw Underworld_FloodSwampWater_VomitWater   ; 0x04 - $F09B
    dw Underworld_FloodSwampWater_VomitWater   ; 0x05 - $F09B
    dw Underworld_FloodSwampWater_VomitWater   ; 0x06 - $F09B
    dw Underworld_FloodSwampWater_VomitWater   ; 0x07 - $F09B
    dw Underworld_FloodSwampWater_VomitWater   ; 0x08 - $F09B
    dw Underworld_FloodSwampWater_SpillToFloor ; 0x09 - $F16D
    dw Underworld_FloodSwampWater_CoverFloor   ; 0x0A - $F18C
    dw Underworld_FloodSwampWater_RiseInLevel  ; 0x0B - $F1E1
}

; $00F093-$00F09A LONG JUMP LOCATION
Dungeon_TurnOnWaterLong:
{
    LDA.b $B0 : ASL A : TAX
    
    JMP (.handlers, X)

    ; $00F09A ALTERNATE ENTRY POINT
    .exit
    
    RTL
}

; ==============================================================================

; $00F09B-$00F0C8 JUMP LOCATION
Underworld_FloodSwampWater_VomitWater:
{
    DEC.w $0424 : BNE Dungeon_TurnOnWaterLong_exit
        LDA.b #$04 : STA.w $0424
        
        INC.b $B0 : LDA.b $B0 : SEC : SBC.b #$04 : STA.b $0E : STZ.b $0F
        
        REP #$30
        
        LDA.w #$0008 : STA.w $0686
        
        STZ.w $068A
        
        LDA.w #$0030 : STA.w $0684
        
        LDA.w #$1654 : CLC : ADC.w #$0010 : TAY

        ; Bleeds into the next function.
}

; $00F0C9-$00F16C JUMP LOCATION
Underworld_AdjustWaterVomit:
{
    LDA.w $047C : CLC : ADC.w #$0100 : STA.b $08 : TAX
    
    .loop
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2002, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2004, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2006, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        TXA : CLC : ADC.w #$0080 : TAX
    DEC.b $0E : BNE .loop
    
    LDA.w #$0004 : STA.b $0A
    
    LDY.w #$0000
    
    .loop2
    
        LDX.b $08
        
        TXA : AND.w #$0040 : LSR #4             : XBA : STA.b $00
        TXA : AND.w #$303F : LSR A  : ORA.b $00       : STA.b $00
        TXA : AND.w #$0F80 : LSR #2 : ORA.b $00 : XBA : STA.w $1002, Y
        
        LDA.w #$0980 : STA.w $1004, Y
        
        LDA.l $7E2000, X : STA.w $1006, Y
        LDA.l $7E2080, X : STA.w $1008, Y
        LDA.l $7E2100, X : STA.w $100A, Y
        LDA.l $7E2180, X : STA.w $100C, Y
        LDA.l $7E2200, X : STA.w $100E, Y
        
        INC.b $08 : INC.b $08
        
        TYA : CLC : ADC.w #$000E : TAY
    DEC.b $0A : BNE .loop2
    
    LDA.w #$FFFF : STA.w $1002, Y
    
    SEP #$30
    
    LDA.b #$01 : STA.b $14
    
    RTL
}

; ==============================================================================

; $00F16D-$00F18B JUMP LOCATION
Underworld_FloodSwampWater_SpillToFloor:
{
    LDA.b #$03 : STA.b $96
    
    STZ.b $97 : STZ.b $98
    
    LDA.b #$16 : STA.b $1E
    
    LDA.b #$01 : STA.b $1F : STA.b $1D
    
    LDA.b #$02 : STA.b $99
    LDA.b #$62 : STA.b $9A
    
    STZ.w $0424
    
    INC.b $B0

    ; Bleeds into the next function.
}

; $00F18C-$00F1E0 ALTERNATE ENTRY POINT
Underworld_FloodSwampWater_CoverFloor:
{
    LDA.w $0424 : AND.b #$03 : ASL A : TAX
    
    REP #$20
    
    LDA.w #$0688 : SEC : SBC.b $E8 : SEC : SBC.w #$0024 : STA.b $00
    
    LDA.w $0686 : CLC : ADC.l WaterDrainSpeed_flood_width, X : STA.w $0686
    LDA.w $068A : CLC : ADC.l WaterDrainSpeed_floor_flood, X : STA.w $068A
    
    CMP.b $00 : BCC .alpha
        SEP #$20
        
        ; TOOD: I'm pretty sure this is supposed to be BG2.
        ; Make BG1 full addition.
        LDA.b #$07 : STA.w $0414
        
        INC.b $B0
    
    .alpha
    
    REP #$30
    
    INC.w $0424
    
    LDA.w #$0688 : SEC : SBC.b $E8 : SEC : SBC.w $0684 : STA.w $0674
    CLC : ADC.w $068A : STA.b $0A
    
    JSL.l AdjustWaterHDMAWindow_Horizontal
    
    RTL
}

; ==============================================================================

; $00F1E1-$00F2D9 JUMP LOCATION
Underworld_FloodSwampWater_RiseInLevel:
{
    LDA.w $0424 : AND.b #$07 : BNE .BRANCH_ALPHA
        LDA.w $0424 : AND.b #$0C : LSR A : TAX
        
        REP #$20
        
        LDA.w $0684 : CMP.w $0688 : BEQ .BRANCH_BETA
            CLC : ADC.l WaterDrainSpeed_tub_fill, X : STA.w $0684
            
            LDA.w $0686 : CLC : ADC.l WaterDrainSpeed_tub_fill, X : STA.w $0686
            
            REP #$10
            
            LDY.w #$16B4
            
            LDA.w $0688 : SEC : SBC.w $0684 : BEQ .BRANCH_GAMMA
                CMP.w #$0008 : BNE .BRANCH_DELTA
                
                LDY.w #$168C
            
            .BRANCH_GAMMA
            
            LDA.w #$0005 : STA.b $0E
            
            JSL.l Underworld_AdjustWaterVomit
            
            .BRANCH_DELTA
            
            SEP #$30
    
    .BRANCH_ALPHA
    
    SEP #$30
    
    INC.w $0424
    
    JSL.l Hdma_ConfigureWaterTable
    
    RTL
    
    .BRANCH_BETA
    
    REP #$30
    
    STZ.b $1E
    
    LDX.w $0440 : BEQ .BRANCH_EPSILON
    
        LDY.w #$0000
        
        .BRANCH_ZETA
        
            LDX.w $06B8, Y
            
            LDA.w #$0003 : STA.l $7F2000, X
            XBA          : STA.l $7F2002, X
            
            LDA.w #$0A03 : STA.l $7F3000, X
            XBA          : STA.l $7F3002, X
            
            LDA.w #$0808
            
            STA.l $7F2040, X : STA.l $7F2042, X
            STA.l $7F3040, X : STA.l $7F3042, X
            STA.l $7F3080, X : STA.l $7F3082, X
            STA.l $7F30C0, X : STA.l $7F30C2, X
        INY #2 : CPY.w $0440 : BNE .BRANCH_ZETA
    
    .BRANCH_EPSILON
    
    LDX.w $049E : BEQ .BRANCH_THETA
        LDY.w #$0000
        
        .BRANCH_IOTA
        
            LDX.w $06EC, Y
            
            LDA.w #$0003 : STA.l $7F20C0, X
            XBA          : STA.l $7F20C2, X
            
            LDA.w #$0A03 : STA.l $7F30C0, X
            XBA          : STA.l $7F30C2, X
            
            LDA.w #$0808
            
            STA.l $7F2080, X : STA.l $7F2082, X
            STA.l $7F3000, X : STA.l $7F3002, X
            STA.l $7F3040, X : STA.l $7F3042, X
            STA.l $7F3080, X : STA.l $7F3082, X
        INY #2 : CPY.w $049E : BNE .BRANCH_IOTA
    
    .BRANCH_THETA
    
    STZ.b $11
    STZ.b $B0
    
    RTL
}
    
; ==============================================================================

; UNUSED:
; $00F2DA-$00F2E7 DATA
UNREACHABLE_01F2DA:
{
    dw 8, 16, 24, 32
    dw 0, -8, -8
}

; $00F2E8-$01F2F1 DATA
FloodGateTileOffsets:
{
    dw $FFF8
    dw $12F8
    dw $1348
    dw $1398
    dw $13E8
}

; ==============================================================================

; $00F2F2-$00F2FD JUMP TABLE
Watergate_MainJumpTable:
{
    dw FloodDam_PrepTiles_init ; 0x00 - $F3A7
    dw FloodDam_PrepTiles      ; 0x01 - $F3AA
    dw FloodDam_PrepTiles      ; 0x02 - $F3AA
    dw FloodDam_PrepTiles      ; 0x03 - $F3AA
    dw FloodDam_Expand         ; 0x04 - $F30C
    dw FloodDam_Fill           ; 0x05 - $F3BD
}

; $00F2FE-$00F30B LONG JUMP LOCATION
Watergate_Main:
{
    JSL.l FloodDam_PrepFloodHDMA
    
    LDA.b $B0 : ASL : TAX
    
    JMP (Watergate_MainJumpTable, X)
    
    .easyOut
    
    SEP #$30
    
    RTL
}

; ==============================================================================

; $00F30C-$00F3A6 JUMP LOCATION
FloodDam_Expand:
{
    INC.w $0470
    
    LDA.w $0470 : LSR A : STA.w $0686
    
    SEC : SBC.b #$08 : STA.b $00
    
    LDA.w $0678 : STA.w $0676
    
    LDA.w $067A : CLC : ADC.b #$01 : STA.w $067A
    
    CLC : ADC.b $00 : STA.w $0684
    
    LDA.w $0470 : AND.b #$0F : BNE Watergate_Main_easyOut
        LDA.w $0470 : CMP.b #$40 : BNE .BRANCH_ALPHA
            INC.b $B0
        
        .BRANCH_ALPHA
        
        REP #$30
        
        LDA.w $0470 : LSR #3 : TAX
        
        LDA.l FloodGateTileOffsets, X
        
        TAY
        
        LDX.w $0472 : STX.b $08
        
        LDA.w #$000A : STA.b $0E
        
        .BRANCH_BETA
        
            LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
            LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
            LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
            LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
            
            TYA : CLC : ADC.w #$0008 : TAY
            
            INX #2
        DEC.b $0E : BNE .BRANCH_BETA

        STZ.b $0C

        LDA.w #$0003 : STA.b $0E
        
        .BRANCH_GAMMA
        
            LDA.b $08 : PHA
            
            LDA.w #$0004 : STA.b $0A
            
            LDY.b $0C
            
            LDA.w #$0881 : STA.b $06
            
            JSR.w Dungeon_PrepOverlayDma_nextTileGroup
            
            PLA : CLC : ADC.w #$0006 : STA.b $08
        DEC.b $0E : BNE .BRANCH_GAMMA
        
        JMP.w RoomDraw_CloseStripes
}

; ==============================================================================

; $00F3A7-$00F3A9 JUMP LOCATION
FloodDam_PrepTiles_init:
{
    STZ.w $045C

    ; Bleeds into the next function.
}

; $00F3AA-$00F3BC JUMP LOCATION
FloodDam_PrepTiles:
{
    STZ.w $0418
    
    JSL.l WaterFlood_BuildOneQuadrantForVRAM
    
    LDA.w $045C : CLC : ADC.b #$04 : STA.w $045C
    
    INC.b $B0
    
    RTL
}

; ==============================================================================

; $00F3BD-$00F3DA JUMP LOCATION
FloodDam_Fill:
{
    INC.w $0684
    
    LDA.w $0684 : CLC : ADC.w $0676 : CMP.b #$E1 : BCC .alpha

        STZ.w $045C
        STZ.b $11
        STZ.b $B0
        STZ.b $1E
        STZ.b $1F
        
        JSL.l ResetSpotlightTable
    
    .alpha
    
    RTL
}

; ==============================================================================

; $00F3DB-$00F3DE BRANCH LOCATION
Dungeon_LightTorchFail:
{
    STZ.w $0333
    
    RTL
}

; ==============================================================================

; $00F3DF-$00F3EB LONG JUMP LOCATION
UNREACHABLE_01F3DF:
{
    LDA.w $0333 : AND.b #$F0 : CMP.b #$C0 : BNE Dungeon_LightTorchFail    
        LDA.b #$00
        
        BRA Dungeon_LightTorch_notGanonRoom
}
    
; ==============================================================================

; $00F3EC-$00F495 LONG JUMP LOCATION
Dungeon_LightTorch:
{
    ; It's not a torch tile.
    LDA.w $0333 : AND.b #$F0 : CMP.b #$C0 : BNE Dungeon_LightTorchFail
        ; Normally set timer to 0xC0.
        LDA.b #$C0
        
        LDY.b $A0 : BNE .notGanonRoom
            ; In Ganon's room the torches don't stay lit as long.
            LDA.b #$80
        
        .notGanonRoom
        
        STA.b $08 : STZ.b $09
        
        PHA
        
        ; Set data bank to 0x00.
        PHB : LDA.b #$00 : PHA : PLB
        
        REP #$30
        
        LDA.w $0333 : AND.w #$000F : ASL A : CLC : ADC.w $0478 : TAY
        
        LDA.w $0520, Y : AND.w #$00FF : TAX
        
        ; Branch if torch is already lit.
        LDA.w $0540, Y : ASL A : BCS .return
            ; TODO: Light the torch?
            LSR A : ORA.w #$8000 : STA.w $0540, Y
            
            LDA.b $08 : BNE .notZero
                ; TODO: Why would this ever happen give the code base we have?
                ; Seems like this would permanently light the torch?
                LDA.w $0540, Y : STA.l $7EFB40, X
                
            .notZero
            
            LDA.w $0540, Y : AND.w #$3FFF : TAX : STX.b $08 : PHX
            
            LDY.w #$0ECA
            
            JSR.w Dungeon_PrepOverlayDma
            
            LDY.b $0C : LDA.w #$FFFF : STA.w $1100, Y
            
            PLA
            
            SEP #$30
            
            AND.b #$7F : ASL A
            
            JSL.l Sound_GetFineSfxPan
            
            ORA.b #$2A : STA.w $012E
            
            PLB
            
            LDA.b #$01 : STA.b $18
            
            LDA.l $7EC005 : BEQ .dontDisableTorchBg
                LDA.w $045A : INC.w $045A : CMP.b #$03 : BCS .dontDisableTorchBg
                    STZ.b $1D
                    
                    LDX.w $045A
                    LDA.l RoomEffectFixedColors, X : STA.l $7EC017
                    
                    LDA.b #$0A : STA.b $11
                    
                    STZ.b $B0
                
            .dontDisableTorchBg
            
            LDA.w $0333 : AND.b #$0F : TAX
            
            ; Set the timer for the torch.
            PLA : STA.w $04F0, X
            
            STZ.w $0333
            
            RTL
        
        .return
        
        SEP #$30
        
        PLB
        
        PLA
        
        RTL
}

; ==============================================================================

; $00F496-$00F4A0 LONG JUMP LOCATION
Dungeon_ExtinguishFirstTorch:
{
    JSL.l Palette_AssertTranslucencySwap
    
    LDA.b #$C0 : STA.w $0333
    
    BRA Dungeon_ExtinguishTorch_extinguish
}
    
; $00F4A1-$00F4A5 LONG JUMP LOCATION
Dungeon_ExtinguishSecondTorch:
{
    LDA.b #$C1 : STA.w $0333
    
    ; Bleeds into the next function.
}
    
; $00F4A6-$00F527 LONG JUMP LOCATION
Dungeon_ExtinguishTorch:
{
    .extinguish

    LDA.b #$C0 : STA.b $08 : STZ.b $09
    
    PHA
    
    ; Going to be using bank $00.
    PHB : LDA.b #$00 : PHA : PLB
    
    REP #$30
    
    LDA.w $0333 : AND.w #$000F : ASL A : CLC : ADC.w $0478 : TAY
    
    LDA.w $0520, Y : AND.w #$00FF : TAX
    
    LDA.w $0540, Y : ASL #2 : STA.w $0540, Y : STA.l $7EFB40, X
    
    AND.w #$3FFF : TAX : STX.b $08
    
    LDY.w #$0EC2
    
    JSR.w Dungeon_PrepOverlayDma
    
    LDY.b $0C
    
    LDA.w #$FFFF : STA.w $1100, Y
    
    SEP #$30
    
    PLB
    
    LDA.b #$01 : STA.b $18
    
    LDA.l $7EC005 : BEQ .noLightLevelChange
        LDA.w $045A : BEQ .noLightLevelChange
            DEC A : STA.w $045A : CMP.b #$03 : BCS .noLightLevelChange
                CMP.b #$00 : BNE .notFullyDark
                    LDA.b #$01 : STA.b $1D

                .notFullyDark

                LDX.w $045A
                LDA.l RoomEffectFixedColors, X : STA.l $7EC017
                
                LDA.b #$0A : STA.b $11
                
                STZ.b $B0

    .noLightLevelChange

    LDA.w $0333 : AND.b #$0F : TAX
    
    PLA
    
    STZ.w $04F0, X
    STZ.w $0333
    
    RTL
}

; ==============================================================================

; $00F528-$00F584 LONG JUMP LOCATION
Dungeon_ElevateStaircasePriority:
{
    REP #$30
    
    LDA.w $0462 : AND.w #$0003 : ASL A : TAY
    
    LDA.w $06B0, Y : ASL A : SEC : SBC.w #$0008 : TAX
    STX.w $048C : STX.b $08 : PHX
    
    LDY.w #$0004
    
    .next_column
    
        ; What this is doing is setting the priority bits of all these tiles
        ; so that you can't see the player sprite past a certain point.
        LDA.l $7E2000, X : ORA.w #$2000 : STA.l $7E2000, X
        LDA.l $7E2080, X : ORA.w #$2000 : STA.l $7E2080, X
        LDA.l $7E2100, X : ORA.w #$2000 : STA.l $7E2100, X
        LDA.l $7E2180, X : ORA.w #$2000 : STA.l $7E2180, X
        
        INX #2
    DEY : BPL .next_column
    
    JSR.w Dungeon_PrepOverlayDma_tilemapAlreadyUpdated
    
    ; TODO: Investigate exactly what tiles are being reblitted to VRAM,
    ; because something about this just seems off.
    PLA : CLC : ADC.w #$0008 : STA.b $08
    
    JSR.w Dungeon_PrepOverlayDma_nextPrep
    
    ; Finalizes oam buffer...
    JMP.w RoomDraw_CloseStripes
}

; ==============================================================================

; $00F585-$00F5D0 LONG JUMP LOCATION
Dungeon_DecreaseStaircasePriority:
{
    REP #$30
    
    LDX.w $048C : STX.b $08 : PHX
    
    LDY.w #$0004
    
    .nextColumn
    
    LDA.l $7E2000, X : AND.w #$DFFF : STA.l $7E2000, X
    LDA.l $7E2080, X : AND.w #$DFFF : STA.l $7E2080, X
    LDA.l $7E2100, X : AND.w #$DFFF : STA.l $7E2100, X
    LDA.l $7E2180, X : AND.w #$DFFF : STA.l $7E2180, X
    
    INX #2
    
    DEY : BPL .nextColumn
    
    JSR.w Dungeon_PrepOverlayDma_tilemapAlreadyUpdated
    
    PLA : CLC : ADC.w #$0008 : STA.b $08
    
    JSR.w Dungeon_PrepOverlayDma_nextPrep
    JMP.w RoomDraw_CloseStripes
}

; ==============================================================================

; $00F5D1-$00F5D8 DATA
RoomDraw_OpenTriforceDoor_tile_offset:
{
    dw $2556, $2596, $25D6, $2616
}

; ==============================================================================

; $00F5D9-$00F5D9 JUMP LOCATION
Object_OpenGanonDoor_easyOut:
{
    RTL
}

; ==============================================================================

; $00F5DA-$00F6B3 LONG JUMP LOCATION
Object_OpenGanonDoor:
{
    LDA.b #$01 : STA.w $02E4
    
    LDA.b $C8 : ORA.b $C9 : BEQ .doneCountingDown
        DEC.b $C8 : BNE Object_OpenGanonDoor_easyOut
        DEC.b $C9 : BNE Object_OpenGanonDoor_easyOut
            ; Play Ganon's door opening sound effect.
            LDA.b #$15 : STA.w $012D
            
            STZ.w $03EF
            STZ.b $50
        
    .doneCountingDown
    
    STZ.w $02E4
    
    INC.b $B0
    
    LDA.b $B0 : AND.b #$03 : BNE Object_OpenGanonDoor_easyOut
        REP #$30
        
        LDA.b $B0 : SEC : SBC.w #$0004 : LSR A : TAX
        
        LDA.l .tile_offset, X : TAY
        
        LDX.w #$0000
        
        ; Open the door to the triforce room.
        .nextColumn
        
            LDA.w RoomDrawObjectData+00, Y : STA.l $7E21D8, X
            LDA.w RoomDrawObjectData+02, Y : STA.l $7E2258, X
            LDA.w RoomDrawObjectData+04, Y : STA.l $7E22D8, X
            LDA.w RoomDrawObjectData+06, Y : STA.l $7E2358, X
            
            TYA : CLC : ADC.w #$0008 : TAY
        INX #2 : CPX.w #$0010 : BNE .nextColumn
        
        LDA.w #$0008 : STA.b $0A
        LDA.w #$0881 : STA.b $06
        
        LDX.w #$01D8 : STX.b $08
        
        STZ.b $0C
        
        LDY.b $0C
        
        JSR.w Dungeon_PrepOverlayDma_nextTileGroup
        
        LDY.b $0C
        
        ; Terminate the drawing buffer.
        LDA.w #$FFFF : STA.w $1100, Y
        
        LDA.b $B0 : CMP.w #$0010 : BNE .notFinishedYet
            LDA.w #$0202 : STA.l $7F216C : STA.l $7F21AC
            LDA.w #$0200 : STA.l $7F2172 : STA.l $7F21B2
            
            LDX.w #$0000
            LDA.w #$0000
            
            ; Update the tile attributes for the door's region of tiles finally.
            .nextColumn2
            
                STA.l $7F202D, X : STA.l $7F206D, X
                STA.l $7F20AD, X : STA.l $7F20ED, X
                STA.l $7F212D, X : STA.l $7F216D, X
                STA.l $7F21AD, X
            INX #2 : CPX.w #$0006 : BNE .nextColumn2
            
            LDA.w #$FFC0 : STA.w $0600
            
            SEP #$20
            
            STZ.b $11
            STZ.b $B0
        
        .notFinishedYet
        
        SEP #$30
        
        LDA.b #$01 : STA.b $18
        
        RTL
}

; ==============================================================================

; UNUSED:
; Sets up DMA transfers for some unknown purpose.
; $00F6B4-$00F745 LOCAL JUMP LOCATION
UNREACHABLE_01F6B4:
{
    LDA.w #$0004 : STA.b $0A
    
    LDY.b $0C
    
    LDA.w #$0080 : STA.b $06
    
    LDA.b $08 : AND.w #$003F : CMP.w #$003A : BCC .BRANCH_ALPHA
        INC.b $06
    
    .BRANCH_ALPHA
    
    LDX.b $08
    
    TXA : AND.w #$0040 : LSR #4 : XBA     : STA.b $00
    TXA : AND.w #$303F : LSR A            : STA.b $02
    TXA : AND.w #$0F80 : LSR #2 : ORA.b $00 : ORA.b $02 : STA.w $1100, Y
    
    LDX.w $045E
    
    LDA.w $1600, X : STA.w $1104, Y
    
    LDA.b $06 : STA.w $1102, Y
    
    LSR A : BCS .BRANCH_BETA
        LDA.w $1602, X : STA.w $1106, Y
        LDA.w $1604, X : STA.w $1108, Y
        LDA.w $1606, X : STA.w $110A, Y
        
        LDA.b $08 : CLC : ADC.w #$0080 : STA.b $08
        
        TXA : CLC : ADC.w #$0008 : TAX
        
        BRA .BRANCH_GAMMA

    .BRANCH_BETA

    LDA.w $1608, X : STA.w $1106, Y
    LDA.w $1610, X : STA.w $1108, Y
    LDA.w $1618, X : STA.w $110A, Y
    
    INC.b $08 : INC.b $08
    
    INX #2

    .BRANCH_GAMMA

    STX.w $045E
    
    TYA : CLC : ADC.w #$000C : TAY
    
    DEC.b $0A : BNE .BRANCH_ALPHA
        RTS
}

; ==============================================================================

; Preps DMA transfers for updating tilemap during NMI.
; I should mention that the method employed here is stunningly
; slow (inefficient) during NMI, taking on average 1 scanline per tile,
; which is INSANE.
; $00F746-$00F7F0 LOCAL JUMP LOCATION
Dungeon_PrepOverlayDma:
{
    LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
    LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
    LDA.w RoomDrawObjectData+04, Y : STA.l $7E2002, X
    LDA.w RoomDrawObjectData+06, Y : STA.l $7E2082, X
    
    ; $00F762 ALTERNATE ENTRY POINT
    .tilemapAlreadyUpdated
    
    STZ.b $0C
    
    ; $00F764 ALTERNATE ENTRY POINT
    .nextPrep
    
    ; Going to blit 4 separate tiles...
    LDA.w #$0004 : STA.b $0A
    
    LDY.b $0C
    
    LDA.b #$0880 : STA.b $06
    
    ; If A < 0x3A.
    LDA.b $08 : AND.w #$003F : CMP.w #$003A : BCC .useHorizontalDma
        ; As opposed to vertical dma (VRAM).
        INC.b $06

    .useHorizontalDma
    
    ; $00F77C ALTERNATE ENTRY POINT
    
    .nextTileGroup
    
        LDX.b $08
        
        TXA : AND.w #$0040 : LSR #4 : XBA     : STA.b $00
        TXA : AND.w #$303F : LSR A  : ORA.b $00 : STA.b $00
        TXA : AND.w #$0F80 : LSR #2 : ORA.b $00 : STA.w $1100, Y
        
        ; The data to write to VRAM.
        LDA.l $7E2000, X : STA.w $1104, Y
        
        LDA.b $06 : STA.w $1102, Y
        
        LSR A : BCS .vertical
            LDA.l $7E2002, X : STA.w $1106, Y
            LDA.l $7E2004, X : STA.w $1108, Y
            LDA.l $7E2006, X : STA.w $110A, Y
            
            LDA.b $08 : CLC : ADC.w #$0080 : STA.b $08
            
            BRA .advanceVramBufferPosition
        
        .vertical
        
        LDA.l $7E2080, X : STA.w $1106, Y
        LDA.l $7E2100, X : STA.w $1108, Y
        LDA.l $7E2180, X : STA.w $110A, Y
        
        INC.b $08 : INC.b $08
        
        .advanceVramBufferPosition
        
        TYA : CLC : ADC.w #$000C : TAY
    DEC.b $0A : BNE .nextTileGroup
    
    STY.b $0C
    
    RTS
}

; ==============================================================================

; $00F7F1-$00F810 DATA
ClearAndStripeExplodingWall_offset:
{
    dw $0004, $0008, $000C, $0010
    dw $0014, $0018, $001C, $0020
    dw $0100, $0200, $0300, $0400
    dw $0500, $0600, $0700, $0800
}

; Routine used with blast walls to prep VRAM updates for nmi.
; $00F811-$00F907 LOCAL JUMP LOCATION
ClearAndStripeExplodingWall:
{
    LDA.w #$0080 : STA.b $06
    
    STZ.b $0E
    
    LDA.w $0454 : CLC : ADC.w #$0003 : STA.b $0A
    
    SEC : SBC.w #$0006 : CMP.w #$0002 : BMI .alpha
    
        STA.b $02
        
        INC.b $0E
        
        LDA.w #$0003 : STA.b $0A
    
    .alpha
    
    LDY.b $0C
    
    LDX.w $0460
    
    LDA.w $19C0, X : AND.w #$0002 : BNE .beta

        INC.b $06
    
    .beta
    
    LDX.b $08
    
    TXA : AND.w #$0040 : LSR #4 : XBA     : STA.b $00
    TXA : AND.w #$303F : LSR A  : ORA.b $00 : STA.b $00
    TXA : AND.w #$0F80 : LSR #2 : ORA.b $00 : STA.w $1100, Y : PHA
    
    LDA.l $7E2000, X : STA.w $1104, Y
    
    LDA.b $06 : ORA.w #$0A00 : STA.w $1102, Y
    LDA.b $06 : ORA.w #$0E00 : STA.w $1110, Y
    
    PLA : CLC : ADC.w #$04A0 : STA.w $110E, Y
    
    LDA.l $7E2080, X : STA.w $1106, Y
    LDA.l $7E2100, X : STA.w $1108, Y
    LDA.l $7E2180, X : STA.w $110A, Y
    LDA.l $7E2200, X : STA.w $110C, Y
    LDA.l $7E2280, X : STA.w $1112, Y
    LDA.l $7E2300, X : STA.w $1114, Y
    LDA.l $7E2380, X : STA.w $1116, Y
    LDA.l $7E2400, X : STA.w $1118, Y
    LDA.l $7E2480, X : STA.w $111A, Y
    LDA.l $7E2500, X : STA.w $111C, Y
    LDA.l $7E2580, X : STA.w $111E, Y
    
    INC.b $08 : INC.b $08
    
    TYA : CLC : ADC.w #$0020 : TAY
    
    DEC.b $0A : BEQ .gamma
        JMP .beta
    
    .gamma
    
    LDA.b $0E : BEQ .delta
        DEC.b $0E
        
        LDX.b $02
        
        LDA.b $06 : LSR A : BCS .epsilon
            TXA : CLC : ADC.w #$0010 : TAX
        
        .epsilon
        
        LDA.l .offset-2, X : CLC : ADC.b $08 : STA.b $08
        
        LDA.w #$0003 : STA.b $0A
        
        JMP .beta
    
    .delta
    
    STY.b $0C
    
    RTS
}

; ==============================================================================

; This routine appears to be unused and unreferenced in the rom so far...
; I actually only noticed it by seeing that there was a gap in addresses.
; In any case, it's one of those routines that preps a DMA transfer for
; later when NMI hits. Usually these update the tilemaps.
; $00F908-$00F966 LOCAL JUMP LOCATION
UNREACHABLE_01F908:
{
    STA.b $0C
    
    STY.b $0E : STY.b $0A
    
    LDY.w #$0000
    
    .BRANCH_ALPHA
    
            TXA : AND.w #$0040 : LSR #4 : XBA : STA.b $00
            TXA : AND.w #$303F : LSR A  : STA.b $02
            TXA : AND.w #$0F80 : LSR #2 : ORA.b $00 : ORA.b $02 : XBA : STA.w $1002, Y
            
            LDA.w #$0100 : STA.w $1004, Y
            
            LDA.l $7E4000, X : STA.w $1006, Y
            
            INY #6
            
            INX #2
        DEC.b $0E : BNE .BRANCH_ALPHA
        
        LDA.b $0A : STA.b $0E
        
        TXA : CLC : ADC.w #$0070 : TAX
    DEC.b $0C : BNE .BRANCH_ALPHA
    
    LDA.w #$FFFF : STA.w $1002, Y
    
    SEP #$20
    
    LDA.b #$01 : STA.b $14
    
    REP #$20
    
    RTS
}

; ==============================================================================

; $00F967-$00F97F LOCAL JUMP LOCATION
Dungeon_DrawOverlay:
{
    .nextObject
    
        REP #$30
        
        STZ.b $B2
        STZ.b $B4
        
        LDY.b $BA
        
        LDA [$B7], Y : CMP.w #$FFFF : BEQ .endOfObjects
            STA.b $00
            
            JSR.w Dungeon_DrawChunk
    BRA .nextObject
    
    .endOfObjects
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; Dungeon overlay object "drawer".
; Note that it doesn't apply attribute modifications.
; $00F980-$00FA49 LOCAL JUMP LOCATION
Dungeon_DrawChunk:
{
    SEP #$20
    
    LDA [$B7], Y : AND.b #$FC : STA.b $08
    
    INY #2
    
    LDA [$B7], Y : STA.b $04 : STZ.b $05
    
    LDA.b $01 : LSR #3 : ROR.b $08 : STA.b $09
    
    ; There was an error here, it was an STA when it should be a STY.
    INY : STY.b $BA
    
    REP #$20
    
    LDA.b $04
    
    LDX.b $08
    
    CMP.w #$00A4 : BNE .notHole
        LDY.w #$05AA
        
        LDA.w RoomDrawObjectData+00, Y
        STA.l $7E2080, X : STA.l $7E2082, X
        STA.l $7E2084, X : STA.l $7E2086, X
        STA.l $7E2100, X : STA.l $7E2102, X
        STA.l $7E2104, X : STA.l $7E2106, X
        
        LDY.w #$063C
        
        LDA.w RoomDrawObjectData+02, Y
        STA.l $7E2000, X : STA.l $7E2002, X
        STA.l $7E2004, X : STA.l $7E2006, X
        
        LDY.w #$0642
        
        LDA.w RoomDrawObjectData+02, Y
        STA.l $7E2180, X : STA.l $7E2182, X
        STA.l $7E2184, X : STA.l $7E2186, X
        
        RTS
    
    .notHole
    
    ; Use the floor 2 pattern.
    LDY.w $046A
    
    LDA.w RoomDrawObjectData+00, Y
    STA.l $7E2000, X : STA.l $7E2004, X
    STA.l $7E2100, X : STA.l $7E2104, X

    LDA.w RoomDrawObjectData+02, Y
    STA.l $7E2002, X : STA.l $7E2006, X
    STA.l $7E2102, X : STA.l $7E2106, X

    LDA.w RoomDrawObjectData+08, Y
    STA.l $7E2080, X : STA.l $7E2084, X
    STA.l $7E2180, X : STA.l $7E2184, X

    LDA.w RoomDrawObjectData+10, Y
    STA.l $7E2082, X : STA.l $7E2086, X
    STA.l $7E2182, X : STA.l $7E2186, X
    
    RTS
}

; ==============================================================================

; $00FA4A-$00FA53 LOCAL JUMP LOCATION
GetDoorDrawDataIndex_North_clean_door_index:
{
    LDA.w $0460 : AND.w #$00FF : STA.b $04
    
    BRA GetDoorDrawDataIndex_North
}
    
; $00FA54-$00FA9F JUMP LOCATION
DoorDoorStep1_North:
{
    LDA.w $0460 : PHA
    
    AND.w #$000F : STA.b $04
    
    TXA : AND.w #$1FFF : CMP.w DoorTilemapPositions_NorthMiddle : BCC .BRANCH_BETA
        TXA : SEC : SBC.w #$0500 : STA.b $08
        
        PHX
        
        LDX.w $0460
        
        LDA.w $1980, X : AND.w #$00FE : CMP.w #$0042 : BCC .BRANCH_GAMMA
            LDA.b $08 : SEC : SBC.w #$0300 : STA.b $08
        
        .BRANCH_GAMMA
        
        LDA.w $0460 : EOR.w #$0010 : STA.w $0460
        
        JSR.w GetDoorDrawDataIndex_South
        JSR.w Dungeon_PrepOverlayDma_nextPrep
        
        LDY.w $0460
        
        JSR.w Dungeon_LoadSingleDoorAttr
        
        PLX : STX.b $08
    
    .BRANCH_BETA
    
    PLA : STA.w $0460

    ; Bleeds into the next function.
}
    
; $00FAA0-$00FAD6 JUMP LOCATION
GetDoorDrawDataIndex_North:
{
    LDX.w $0460
    
    LDA.w $1980, X : AND.w #$00FE
    
    LDX.w $0692  : BEQ DrawDoorToTilemap_North
    CPX.w #$0004 : BEQ DrawDoorToTilemap_North
        CMP.w #$0024 : BEQ .BRANCH_EPSILON
        CMP.w #$0026 : BEQ .BRANCH_EPSILON
            CMP.w #$0042 : BCC .BRANCH_ZETA
                .BRANCH_EPSILON
                
                INX #4
                
            .BRANCH_ZETA
            
            CMP.w #$0018 : BEQ .BRANCH_THETA
                CMP.w #$0044 : BNE .BRANCH_IOTA
                    .BRANCH_THETA
                    
                    INX #2
                    
                .BRANCH_IOTA
                    
                LDY.w DoorAnimGFXDataOffset_North, X
                    
                BRA DrawDoorToTilemap_North_continue
}

; $00FAD7-$00FB0A LOCAL JUMP LOCATION
DrawDoorToTilemap_North:
{
    JSR.w GetDoorGraphicsIndex
    
    LDY.w DoorGFXDataOffset_North, X
    
    ; $00FADD ALTERNATE ENTRY POINT
    .continue
    
    LDX.w $0460
    
    LDA.w $19A0, X : TAX
    
    LDA.w #$0004 : STA.b $0E
    
    .BRANCH_LAMBDA
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        
        TYA : CLC : ADC.w #$0006 : TAY
        
        INX #2
    DEC.b $0E : BNE .BRANCH_LAMBDA
    
    RTS
}

; ==============================================================================

; $00FB0B-$00FB14 JUMP LOCATION
GetDoorDrawDataIndex_South_clean_door_index:
{
    LDA.w $0460 : AND.w #$00FF : STA.b $04
    
    BRA GetDoorDrawDataIndex_South
}
    
; $00FB15-$00FB60 JUMP LOCATION
DoorDoorStep1_South:
{
    LDA.w $0460 : PHA
    
    AND.w #$000F : STA.b $04
    
    TXA : AND.w #$1FFF : CMP.w DoorTilemapPositions_LowerLayerEntrance : BCS .BRANCH_BETA
        TXA : CLC : ADC.w #$0500 : STA.b $08
        
        PHX
        
        LDX.w $0460
        
        LDA.w $1980, X : AND.w #$00FE : CMP.w #$0042 : BCC .BRANCH_GAMMA
            LDA.b $08 : CLC : ADC.w #$0300 : STA.b $08
        
        .BRANCH_GAMMA
        
        LDA.w $0460 : EOR.w #$0010 : STA.w $0460
        
        JSR.w GetDoorDrawDataIndex_North
        JSR.w Dungeon_PrepOverlayDma_nextPrep
        
        LDY.w $0460
        
        JSR.w Dungeon_LoadSingleDoorAttr
        
        PLX : STX.b $08
    
    .BRANCH_BETA
    
    PLA : STA.w $0460

    ; Bleeds into the next function.
}

; $00FB61-$00FB8D JUMP LOCATION
GetDoorDrawDataIndex_South:
{
    LDX.w $0460
    
    LDA.w $1980, X : AND.w #$00FE
    
    LDX.w $0692  : BEQ DrawDoorToTilemap_South
    CPX.w #$0004 : BEQ DrawDoorToTilemap_South
        CMP.w #$0042 : BCC .BRANCH_EPSILON
            INX #4
        
        .BRANCH_EPSILON
        
        CMP.w #$0018 : BEQ .BRANCH_ZETA
            CMP.w #$0044 : BNE .BRANCH_THETA
        
        .BRANCH_ZETA
        
        INX #2
        
        .BRANCH_THETA
        
        LDY.w DoorAnimGFXDataOffset_South, X
        
        BRA DrawDoorToTilemap_South_continue
}

; $00FB8E-$00FBC1 JUMP LOCATION
DrawDoorToTilemap_South:
{
    JSR.w GetDoorGraphicsIndex
    
    LDY.w DoorGFXDataOffset_South, X
    
    .continue
    
    LDX.w $0460
        
    LDA.w $19A0, X : TAX
        
    LDA.w #$0004 : STA.b $0E
        
    .next_draw
        
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2180, X
        
        TYA : CLC : ADC.w #$0006 : TAY
        
        INX #2
    DEC.b $0E : BNE .next_draw
    
    RTS
}

; ==============================================================================

; $00FBC2-$00FBCB JUMP LOCATION
GetDoorDrawDataIndex_West_clean_door_index:
{
    LDA.w $0460 : AND.w #$00FF : STA.b $04
    
    BRA .BRANCH_ALPHA
}

; $00FBCC-$00FC17 JUMP LOCATION
DoorDoorStep1_West:
{
    LDA.w $0460 : PHA
    
    AND.w #$000F : STA.b $04
    
    TXA : AND.w #$07FF : CMP.w DoorTilemapPositions_WestMiddle : BCC .BRANCH_BETA
        TXA : SEC : SBC.w #$0010 : STA.b $08
        
        PHX
        
        LDX.w $0460
        
        LDA.w $1980, X : AND.w #$00FE : CMP.w #$0042 : BCC .BRANCH_GAMMA
            LDA.b $08 : SEC : SBC.w #$000C : STA.b $08
        
        .BRANCH_GAMMA
        
        LDA.w $0460 : EOR.w #$0010 : STA.w $0460
        
        JSR.w GetDoorDrawDataIndex_East
        JSR.w Dungeon_PrepOverlayDma_nextPrep
        
        LDY.w $0460
        
        JSR.w Dungeon_LoadSingleDoorAttr
        
        PLX : STX.b $08
    
    .BRANCH_BETA
    
    PLA : STA.w $0460

    ; Bleeds into the next function.
}
    
; $00FC18-$00FC44 JUMP LOCATION
GetDoorDrawDataIndex_West:
{
    LDX.w $0460
    
    LDA.w $1980, X : AND.w #$00FE
    
    LDX.w $0692  : BEQ DrawDoorToTilemap_West
    CPX.w #$0004 : BEQ DrawDoorToTilemap_West
        CMP.w #$0042 : BCC .BRANCH_EPSILON
            INX #4
        
        .BRANCH_EPSILON
        
        CMP.w #$0018 : BEQ .BRANCH_ZETA
            CMP.w #$0044 : BNE .BRANCH_THETA
        
        .BRANCH_ZETA
        
        INX #2
        
        .BRANCH_THETA
        
        LDY.w DoorAnimGFXDataOffset_West, X
        
        BRA .BRANCH_IOTA
}

; $00FC45-$00FC7F JUMP LOCATION
DrawDoorToTilemap_West:
{
    JSR.w GetDoorGraphicsIndex
    
    LDY.w DoorGFXDataOffset_West, X
    
    .BRANCH_IOTA
    
    LDX.w $0460
    
    LDA.w $19A0, X : TAX
    
    LDA.w #$0003 : STA.b $0E
    
    .BRANCH_KAPPA
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .BRANCH_KAPPA
    
    RTS
}

; ==============================================================================

; $00FC80-$00FC89 JUMP LOCATION
GetDoorDrawDataIndex_East_clean_door_index:
{
    LDA.w $0460 : AND.w #$00FF : STA.b $04
    
    BRA GetDoorDrawDataIndex_East
}

; $00FC8A-$00FCD5 JUMP LOCATION
DoorDoorStep1_East:
{
    LDA.w $0460 : PHA : AND.w #$000F : STA.b $04
    
    TXA : AND.w #$07FF : CMP.w DoorTilemapPositions_EastWall : BCS .BRANCH_BETA
        TXA : CLC : ADC.w #$0010 : STA.b $08
        
        PHX
        
        LDX.w $0460
        
        LDA.w $1980, X : AND.w #$00FE : CMP.w #$0042 : BCC .BRANCH_GAMMA
            LDA.b $08 : CLC : ADC.w #$000C : STA.b $08
        
        .BRANCH_GAMMA
        
        LDA.w $0460 : EOR.w #$0010 : STA.w $0460
        
        JSR.w GetDoorDrawDataIndex_West
        JSR.w Dungeon_PrepOverlayDma_nextPrep
        
        LDY.w $0460
        
        JSR.w Dungeon_LoadSingleDoorAttr
        
        PLX : STX.b $08
    
    .BRANCH_BETA
    
    PLA : STA.w $0460

    ; Bleeds into the next function.
}

; $00FCD6-$00FD02 JUMP LOCATION
GetDoorDrawDataIndex_East:
{
    LDX.w $0460
    
    LDA.w $1980, X : AND.w #$00FE
    
    LDX.w $0692  : BEQ DrawDoorToTilemap_East
    CPX.w #$0004 : BEQ DrawDoorToTilemap_East
        CMP.w #$0042 : BCC .BRANCH_EPSILON
            INX #4
        
        .BRANCH_EPSILON
        
        CMP.w #$0018 : BEQ .isTrapDoor
            CMP.w #$0044 : BNE .notTrapDoor
        
        .isTrapDoor
        
        INX #2
        
        .notTrapDoor
        
        LDY.w DoorAnimGFXDataOffset_East, X
        
        BRA .drawDoor
}

; $00FD03-$00FD3D JUMP LOCATION
DrawDoorToTilemap_East:
{
    JSR.w GetDoorGraphicsIndex
    
    LDY.w DoorGFXDataOffset_East, X
    
    .drawDoor
    
    LDX.w $0460
    
    LDA.w $19A0, X : TAX
    
    LDA.w #$0003 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2002, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2082, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2102, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2182, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; Seems to draw a very specific door type. I can only guess what...
; Maybe a door revealed by sword swipes like in Agahnim's first room?
; $00FD3E-$00FD78 JUMP LOCATION
ClearDoorCurtainsFromTilemap:
{
    LDX.w #$0056
    
    LDY.w DoorGFXDataOffset_North, X
    
    LDX.w $0460
    
    LDA.w $19A0, X : TAX
    
    LDA.w #$0004 : STA.b $0E
    
    .nextColumn
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
        
        TYA : CLC : ADC.w #$0008 : TAY
        
        INX #2
    DEC.b $0E : BNE .nextColumn
    
    RTS
}

; ==============================================================================

; Used in opening doors and closing doors.... not exactly sure what
; the point is though. Maybe it selects the offset of the tiles
; needed to draw the door's graphical state?
; $00FD79-$00FD91 LOCAL JUMP LOCATION
GetDoorGraphicsIndex:
{
    LDY.w $0460
    
    LDA.w $1980, Y : AND.w #$00FE : TAX
    
    LDY.b $04
    
    LDA.w $068C : AND.w DungeonMask, Y : BEQ .notOpen
        LDA.w DoorwayReplacementDoorGFX, X : TAX
    
    .notOpen
    
    RTS
}

; ==============================================================================

; This routine is used with the exploding walls (not bomb doors! It's easy
; to get confused about terminology).
; $00FD92-$00FDDA JUMP LOCATION
ClearExplodingWallFromTilemap:
{
    LDY.w #$31EA
    JSR.w ClearExplodingWallFromTilemap_ClearOnePair
    
    LDA.w $0454 : DEC A : STA.b $0E : BEQ .skip
        LDA.w RoomDrawObjectData+00, Y
        
        .nextColumn
        
            STA.l $7E2000, X : STA.l $7E2080, X
            STA.l $7E2100, X : STA.l $7E2180, X
            STA.l $7E2200, X : STA.l $7E2280, X
            STA.l $7E2300, X : STA.l $7E2380, X
            STA.l $7E2400, X : STA.l $7E2480, X
            STA.l $7E2500, X : STA.l $7E2580, X
            
            INX #2
        DEC.b $0E : BNE .nextColumn
    
    .skip
    
    INY #2
    
    ; Bleeds into the next function.
}

; $00FDDB-$00FE40 JUMP LOCATION
ClearExplodingWallFromTilemap_ClearOnePair:
{
    LDA.w #$0002 : STA.b $0E
    
    .nextColumn2
    
        LDA.w RoomDrawObjectData+00, Y : STA.l $7E2000, X
        LDA.w RoomDrawObjectData+02, Y : STA.l $7E2080, X
        LDA.w RoomDrawObjectData+04, Y : STA.l $7E2100, X
        LDA.w RoomDrawObjectData+06, Y : STA.l $7E2180, X
        LDA.w RoomDrawObjectData+08, Y : STA.l $7E2200, X
        LDA.w RoomDrawObjectData+10, Y : STA.l $7E2280, X
        LDA.w RoomDrawObjectData+12, Y : STA.l $7E2300, X
        LDA.w RoomDrawObjectData+14, Y : STA.l $7E2380, X
        LDA.w RoomDrawObjectData+16, Y : STA.l $7E2400, X
        LDA.w RoomDrawObjectData+18, Y : STA.l $7E2480, X
        LDA.w RoomDrawObjectData+20, Y : STA.l $7E2500, X
        LDA.w RoomDrawObjectData+22, Y : STA.l $7E2580, X
        
        INX #2
        
        TYA : CLC : ADC.w #$0018 : TAY
    DEC.b $0E : BNE .nextColumn2
    
    RTS
}

; ==============================================================================

; This routine takes performs the modifications to the tile attribute
; buffer resulting from dungeon overlay objects being placed.
; The objects placed can only be either 4x4 blocks of generic floor
; tiles or 4x4 blocks of pit tiles, so as you can see it's fairly easy
; to deduce what tile attributes to use (0x00 or 0x20).
; $00FE41-$00FEAB LOCAL JUMP LOCATION
Dungeon_ApplyOverlayAttr:
{
    STA.b $08
    
    LDA.w #$0004 : STA.b $0A
    
    .nextRow
    
        LDX.b $08
        
        LDA.l $7E2000, X : STA.b $00
        LDA.l $7E2002, X : STA.b $02
        LDA.l $7E2004, X : STA.b $04
        LDA.l $7E2006, X : STA.b $06
        
        LDX.w #$0006
        
        .nextTile
        
            LDA.b $00, X : STZ.b $00, X
            AND.w #$03FE : CMP.w #$00EE : BEQ .notPitTile
                CMP.w #$00FE : BEQ .notPitTile
                    ; Pit attribute.
                    LDA.w #$0020 : STA.b $00, X
            
            .notPitTile
        DEX #2 : BPL .nextTile
        
        LDA.b $08 : LSR A : TAX
        
        SEP #$20
        
        LDA.b $00 : STA.l $7F2000, X
        LDA.b $02 : STA.l $7F2001, X
        LDA.b $04 : STA.l $7F2002, X
        LDA.b $06 : STA.l $7F2003, X
        
        REP #$20
        
        LDA.b $08 : CLC : ADC.w #$0080 : STA.b $08
    DEC.b $0A : BNE .nextRow
    
    RTS
}
    
; ==============================================================================

; $00FEAC-$00FEAF NULL
NULL_01FEAC:
{
    db $FF, $FF, $FF, $FF
}

; ==============================================================================

; $00FEB0-$00FED1 LONG JUMP LOCATION
Dungeon_ApproachFixedColor:
{
    LDA.b $9C : AND.b #$1F : CMP.l $7EC017 : BEQ .targetReached
        ; This coding scheme allows $9C to approach $7EC017 from above or below.
        DEC A : BCS .aboveTarget
            ; (belowTarget)
            INC A : INC A
        
        .aboveTarget
        
        STA.b $00
        
        ; $00FEC1 ALTERNATE ENTRY POINT
        .variable
        
        ; Sets fixed color for +/-.
        ORA.b #$20 : STA.b $9C
        AND.b #$1F : ORA.b #$40 : STA.b $9D
        AND.b #$1F : ORA.b #$80 : STA.b $9E
    
    .targetReached
    
    RTL
}

; ==============================================================================

; This routine's primary purpose is for the Link's electrocution
; mode ($5D == 0x07).
; $00FED2-$00FF04 LONG JUMP LOCATION
Player_SetElectrocutionMosaicLevel:
{
    LDA.w $0647 : BNE .mosaic_decreasing
        ; Add to mosaic? seems related to electrocution (it almost certainly
        ; is).
        LDA.l $7EC011 : CLC : ADC.b #$10 : CMP.b #$C0 : BNE .mosaic_not_at_target
            INC.w $0647
            
            BRA .set_mosaic_level
            
    .mosaic_decreasing
            
    LDA.l $7EC011 : SEC : SBC.b #$10 : BNE .set_mosaic_level    
        ; $00FEF0 ALTERNATE ENTRY POINT
        Player_SetCustomMosaicLevel:
                
        ; Reset mosaic decreasing flag.
        STZ.w $0647

    .set_mosaic_level
    .mosaic_not_at_target
    
    ; Set mosaic level.
    STA.l $7EC011
    
    LDA.b #$09 : STA.b $94
    
    LDA.l $7EC011 : LSR A : ORA.b #$03 : STA.b $95
    
    RTL
}

; ==============================================================================

; Executes when Link hits the ground after jumping off of a ledge.
; $00FF05-$00FF27 LONG JUMP LOCATION
Player_LedgeJumpInducedLayerChange:
{
    ; Make it so Link is on a lower plane.
    LDA.b #$01 : STA.w $0476
    
    LDA.w $044A : BNE .no_room_change
        ; UNUSED: or \tcrf or BUG: I have no idea. It's odd.
        ; I think it's pretty certain this is an unused feature since it would
        ; change the current room we're in without any of the other legwork
        ; necessary.
        LDA.b $A0 : CLC : ADC.b #$10 : STA.b $A0
    
    .no_room_change
    
    LDA.w $044A : CMP.b #$02 : BEQ .use_pseudo_bg
        ; BUG: I think this is where that bug (glitch) that allows you to
        ; get under the floor by pressing select originates from. Not that this
        ; in particular is a bug. It has more to do with the player's
        ; layer probably isn't reset properly when you save and quit, and
        ; then reload the state. (Initializing problem).
        ; TODO: Investigate and find the actual bug location.
        LDA.b #$01 : STA.b $EE
    
    .use_pseudo_bg
    
    STZ.w $047A
    
    JML.l SetAndSaveVisitedQuadrantFlags
}

; ==============================================================================

; $00FF28-$00FFB5 LONG JUMP LOCATION
Player_CacheStatePriorToHandler:
{
    ; OPTIMIZE: We may be able to remove this routine...
    ; OPTIMIZE: Changing the B register would speed it up a lot.
    
    REP #$20
    
    LDA.b $E2 : STA.l $7EC180
    LDA.b $E8 : STA.l $7EC182
    LDA.b $20 : STA.l $7EC184
    LDA.b $22 : STA.l $7EC186
    
    LDA.w $0600 : STA.l $7EC188
    LDA.w $0604 : STA.l $7EC18A
    LDA.w $0608 : STA.l $7EC18C
    LDA.w $060C : STA.l $7EC18E
    LDA.w $0610 : STA.l $7EC190
    LDA.w $0612 : STA.l $7EC192
    LDA.w $0614 : STA.l $7EC194
    LDA.w $0616 : STA.l $7EC196
    LDA.w $0618 : STA.l $7EC198
    LDA.w $061C : STA.l $7EC19A
    
    LDA.b $A6 : STA.l $7EC19C
    LDA.b $A9 : STA.l $7EC19E
    
    SEP #$20
    
    LDA.b $2F : STA.l $7EC1A6
    LDA.b $EE : STA.l $7EC1A7
    
    LDA.w $0476 : STA.l $7EC1A8
    
    LDA.b $6C : STA.l $7EC1A9
    LDA.b $A4 : STA.l $7EC1AA
    
    RTL
}

; ==============================================================================

; $00FFB6-$00FFD8 LONG JUMP LOCATION
Link_CheckSwimCapability:
{
    LDA.w $02E0 : BNE .bunnyGraphics
        LDA.l $7EF356 : BNE .hasFlippers
    
    .bunnyGraphics
    
    LDA.l $7EF357 : BEQ .doesntHaveMoonPearl
        STZ.w $02E0
    
    .doesntHaveMoonPearl
    
    LDA.b #$0C : STA.b $4B
    
    LDA.b #$2A
    
    LDX.b $1B : BEQ .outdoors
        LDA.b #$14
    
    .outdoors
    
    STA.b $11
    
    .hasFlippers
    
    RTL
}

; ==============================================================================

; Take a heart off of Link and put him in the submodule that brings him back to
; where he fell off from. (Damage from pits on Overworld and only in one area,
; at that). Maybe could be used in Dungeons too, but it's not, so... eh.
; $00FFD9-$00FFFC LONG JUMP LOCATION
Overworld_PitDamage:
{
    LDA.b #$0C : STA.b $4B
    
    LDA.b #$2A
    
    LDX.b $1B : BEQ .outdoors
        LDA.b #$14
    
    .outdoors
    
    STA.b $11
    
    LDA.l $7EF36D : SEC : SBC.w #$08 : STA.l $7EF36D : CMP.b #$A8 : BCC .notDead
        LDA.b #$00 : STA.l $7EF36D
    
    .notDead
    
    RTL
}

; ==============================================================================

; $00FFFD-$00FFFF NULL
NULL_01FFFD:
{
    db $FF, $FF, $FF
}

; ==============================================================================
    
warnpc $028000
