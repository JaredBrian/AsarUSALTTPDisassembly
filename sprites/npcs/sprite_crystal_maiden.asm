
; ==============================================================================

; $0F4CD3-$0F4CE2 DATA
Pool_CrystalMaiden_Configure:
{
    .palette
    dw $0000, $3821, $4463, $54A5, $5CE7, $6D29, $79AD, $7E10
}

; ==============================================================================

; $0F4CE3-$0F4D47 LONG JUMP LOCATION
CrystalMaiden_Configure:
{
    ; USED DURING THE CRYSTAL SEQUENCE
    
    ; Enable color addition on backdrop/obj/bg1/bg2
    LDA.b #$33 : STA.b $9A
    
    LDA.b #$00 : STA.l $7EC007
                 STA.l $7EC009
    
    PHX
    
    JSL Palette_AssertTranslucencySwap
    JSL PaletteFilter_Crystal
    
    PLX
    
    REP #$20
    
    LDA.l .palette + $00 : STA.l $7EC5E0
    LDA.l .palette + $02 : STA.l $7EC5E2
    LDA.l .palette + $04 : STA.l $7EC5E4
    LDA.l .palette + $06 : STA.l $7EC5E6
    LDA.l .palette + $08 : STA.l $7EC5E8
    LDA.l .palette + $0A : STA.l $7EC5EA
    LDA.l .palette + $0C : STA.l $7EC5EC
    LDA.l .palette + $0E : STA.l $7EC5EE
    
    SEP #$30
    
    INC.b $15
    
    JSR CrystalMaiden_SpawnAndConfigMaiden
    JSR CrystalMaiden_InitPolyhedral
    
    RTL
}

; ==============================================================================

; $0F4D48-$0F4DD8 LOCAL JUMP LOCATION
CrystalMaiden_SpawnAndConfigMaiden:
{
    LDY.b #$0F
    LDA.b #$00
    
    .kill_next_sprite
    
    ; Kill all normal sprites on screen.
    STA.w $0DD0, Y
    
    DEY : BPL .kill_next_sprite
    
    ; Create a maiden.
    LDA.b #$AB : JSL Sprite_SpawnDynamically
    
    ; Give the maiden the same upper byte coordinates as Link.
    LDA.b $23 : STA.w $0D30, Y
    
    LDA.b $21 : STA.w $0D20, Y
    
    LDA.b #$78 : STA.w $0D10, Y
    
    LDA.b #$7C : STA.w $0D00, Y
    
    LDA.b #$01 : STA.w $0DE0, Y
    
    LDA.b #$0B : STA.w $0F50, Y
    
    LDA.b #$00 : STA.w $0E80, Y : STA.w $0F20, Y
    
    PHY
    
    ; Resets certains actions the player might be doing, like using the
    ; hookshot or carrying extensions.
    JSL Ancilla_TerminateSelectInteractives
    
    STZ.w $02E9
    
    TYA : PLY : STA.w $0D90, Y
    
    LDA.w $040C : CMP.b #$18 : BNE .not_in_turtle_rock
    
    ; Zelda has a special palette.
    LDA.b #$09 : STA.w $0F50, Y
    
    ; Use a Zelda tagalong
    LDA.b #$01
    
    BRA .load_tagalong_graphics
    
    .not_in_turtle_rock
    
    ; Use a maiden tagalong
    LDA.b #$06
    
    .load_tagalong_graphics
    
    STA.l $7EF3CC
    
    PHX
    
    JSL Tagalong_LoadGfx
    
    PLX
    
    LDA.b #$00 : STA.l $7EF3CC
    
    STZ.w $0428
    
    REP #$20
    
    ; what? sec : adc ? ohhhhhhhh. it's being all clever and shit.
    ; the normal way to get the negative of a number in 2's complement
    ; is to xor all the bits (0xffff) and then add 1. This is just doing it
    ; by way of the addition. So it is in fact a pure add of 0x0079, really.
    LDA.b $22 : SEC : SBC.b $E2 : EOR.w #$FFFF : SEC : ADC.w #$0079 : STA.w $0422
    
    LDA.b $E6 : AND.w #$00FF : STA.b $00
    
    LDA.w #$0030 : SEC : SBC.b $00 : STA.w $0424
    
    SEP #$30
    
    LDA.b #$01 : STA.w $0428 ; Set a special flag.
    
    RTS
}

; ==============================================================================

; $0F4DD9-$0F4E02 LOCAL JUMP LOCATION
CrystalMaiden_InitPolyhedral:
{
    LDA.b #$9C : STA.w $1F02
    
    LDA.b #$01 : STA.w $1F01
                 STA.w $012A
                 STA.w $1F00
    
    LDA.b #$20 : STA.w $1F06
                 STA.w $1F07
                 STA.w $1F08
    
    STZ.w $1F03
    
    LDA.b #$10 : STA.w $1F04
    
    STZ.b $1D
    
    LDA.b #$16 : STA.b $1C
    
    RTS
}

; ==============================================================================

; $0F4E03-$0F4E38 JUMP LOCATION
Sprite_CrystalMaiden:
{
    ; Crystal Maiden sprite (after beating Dark World Palace)
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.w $0422 : STA.w $0FD8
    LDA.w $0FDA : SEC : SBC.w $0424 : STA.w $0FDA
    
    SEP #$30
    
    LDA.w $0D80, X : CMP.b #$03 : BCC .not_visible
    
    JSL CrystalMaiden_Draw
    
    .not_visible
    
    LDA.b #$01 : STA.w $012A
    
    LDA.w $1F00 : BNE .polyhedral_thread_sync
    
    JSR CrystalMaiden_Main
    
    LDA.b #$01 : STA.w $1F00
    
    .polyhedral_thread_sync
    
    RTS
}

; ==============================================================================

; $0F4E39-$0F4E62 LOCAL JUMP LOCATION
CrystalMaiden_Main:
{
    INC.w $0E90, X
    
    LDA.w $1F05 : CLC : ADC.b #$06 : STA.w $1F05
    
    LDA.b $11 : BEQ .basic_submodule
    
    RTS
    
    .basic_submodule
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw CrystalMaiden_DisableSubscreen
    dw CrystalMaiden_EnableSubscreen
    dw CrystalMaiden_GenerateSparkles
    dw CrystalMaiden_FilterPalette
    dw CrystalMaiden_FilterPalette.finish
    dw CrystalMaiden_ShowMessage
    dw CrystalMaiden_ReadingComprehensionExam
    dw CrystalMaiden_MayTheWayOfTheHero
    dw CrystalMaiden_InitiateDungeonExit
}

; ==============================================================================

; $0F4E63-$0F4E68 JUMP LOCATION
CrystalMaiden_DisableSubscreen:
{
    STZ.b $1D
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F4E69-$0F4E70 JUMP LOCATION
CrystalMaiden_EnableSubscreen:
{
    LDA.b #$01 : STA.b $1D
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F4E71-$0F4E92 JUMP LOCATION
CrystalMaiden_GenerateSparkles:
{
    LDA.w $1F02 : CMP.b #$06 : BCS .delay
    
    STZ.w $1F02
    
    INC.w $0D80, X
    
    RTS
    
    .delay
    
    SBC.b #$03 : STA.w $1F02 : CMP.b #$40 : BCC .delay_2
    
    PHX
    
    LDA.w $0D90, X : TAX
    
    JSL Sprite_SpawnSparkleAncilla
    
    PLX
    
    .delay_2
    
    RTS
}

; ==============================================================================

; $0F4E93-$0F4EBB JUMP LOCATION
CrystalMaiden_FilterPalette:
{
    INC.w $0D80, X
    
    ; $0F4E96 ALTERNATE ENTRY POINT
    .finish
    
    LDA.w $0E90, X : AND.b #$01 : BNE .delay
    
    PHX
    
    ; does palette filtering of some sort...
    JSL Palette_Filter_SP5F
    
    PLX
    
    LDA.l $7EC007 : BNE .filtering_not_finished
    
    INC.w $0D80, X
    
    LDA.b #$01 : STA.w $02E4
    
    STZ.w $02D8
    STZ.w $02DA
    STZ.b $2E
    STZ.b $2F
    
    .filtering_not_finished
    .delay
    
    RTS
}

; ==============================================================================

; $0F4EBC-$0F4ECD DATA
Pool_CrystalMaiden_ShowMessage:
{
    .message_ids
    dw $0133, $0132, $0137, $0134, $0136, $0132, $0135, $0138
    dw $013c
}

; ==============================================================================

; $0F4ECE-$0F4F17 JUMP LOCATION
CrystalMaiden_ShowMessage:
{
    ; Load the dungeon index. Is it the Dark Palace?
    LDA.w $040C : SEC : SBC.b #$0A : TAY : CPY.b #$02 : BNE .not_dark_palace
    
    LDA.l $7EF3C7 : CMP.b #$07 : BCS .dont_update_map_icons
    
    LDA.b #$07 : STA.l $7EF3C7
    
    .dont_update_map_icons
    .not_dark_palace
    
    ; Is it Turtle Rock?
    CPY.b #$0E : BNE .not_turtle_rock
    
    ; How many Crystals do we have?
    ; We have all the crystals.
    LDA.l $7EF37A : AND.b #$7F : CMP.b #$7F : BEQ .have_all_crystals
    
    LDY.b #$10 ; Otherwise Zelda says something different.
    
    .have_all_crystals
    .not_turtle_rock
    
    ; Loads the Message ID.
    LDA .message_ids+0, Y       : XBA
    LDA .message_ids+1, Y : TAY : XBA
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    LDA.l $7EF37A : AND.b #$7F : CMP.b #$7F : BNE .dont_have_all_crystals
    
    ; Update the map icon to just be Ganon's Tower
    LDA.b #$08 : STA.l $7EF3C7
    
    .dont_have_all_crystals
    
    RTS
}

; ==============================================================================

; $0F4F18-$0F4F23 JUMP LOCATION
CrystalMaiden_ReadingComprehensionExam:
{
    ; "Do you understand?"
    ; ">  Yes[3]         "
    ; "Not at all[Choose]"
    LDA.b #$3A
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F4F24-$0F4F3A JUMP LOCATION
CrystalMaiden_MayTheWayOfTheHero:
{
    LDA.w $1CE8 : BEQ .player_said_yes
    
    LDA.b #$05 : STA.w $0D80, X
    
    RTS
    
    .player_said_yes
    
    ; "May the way of the Hero lead to the Triforce."
    LDA.b #$39
    LDY.b #$01
    
    JSL Sprite_ShowMessageUnconditional
    
    INC.w $0D80, X
    
    RTS
}

; ==============================================================================

; $0F4F3B-$0F4F46 JUMP LOCATION
CrystalMaiden_InitiateDungeonExit:
{
    STZ.b $1D
    
    PHX
    
    JSL PrepDungeonExit
    
    PLX
    
    STZ.w $0DD0, X
    
    RTS
}

; ==============================================================================

