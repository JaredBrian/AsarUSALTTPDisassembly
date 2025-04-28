
; ==============================================================================

; $0F1E7B-$0F1EA4 JUMP LOCATION
Sprite_Kyameron:
{
    LDA.w $0D80, X : BNE .visible
        JSL.l Sprite_PrepOamCoordLong
    
        BRA .not_visible
    
    .visible
    
    JSR.w Kyameron_Draw
    
    .not_visible
    
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckIfRecoiling
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Kyameron_Reset     ; 0x00 - $9EA5
    dw Kyameron_PuddleUp  ; 0x01 - $9EDB
    dw Kyameron_Coagulate ; 0x02 - $9F11
    dw Kyameron_Moving    ; 0x03 - $9F59
    dw Kyameron_Disperse  ; 0x04 - $9FE3
}

; ==============================================================================

; $0F1EA5-$0F1EDA JUMP LOCATION
Kyameron_Reset:
{
    LDA.w $0DF0, X : BNE .delay
    	INC.w $0D80, X
    
    	JSL.l GetRandomInt : AND.b #$3F : ADC.b #$60 : STA.w $0DF0, X
    
    	LDA.w $0D90, X : STA.w $0D10, X
    	LDA.w $0DA0, X : STA.w $0D30, X
    
    	LDA.w $0DB0, X : STA.w $0D00, X
    	LDA.w $0EB0, X : STA.w $0D20, X
    
    	LDA.b #$05 : STA.w $0E80, X
    
    	LDA.b #$08 : STA.w $0DC0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $0F1EDB-$0F1F00 JUMP LOCATION
Kyameron_PuddleUp:
{
    LDA.w $0DF0, X : BNE .delay
     	LDA.b #$1F : STA.w $0DF0, X
    
    	INC.w $0D80, X
    
    .delay
    
    DEC.w $0E80, X : BPL .animation_delay
    	LDA.b #$05 : STA.w $0E80, X
    
    	INC.w $0DC0, X : LDA.w $0DC0, X : AND.b #$03 : CLC : ADC.b #$08 : STA.w $0DC0, X
    
    .animation_delay
    
    RTS
}

; ==============================================================================

; $0F1F01-$0F1F10 DATA
Pool_Kyameron_Coagulate:
{
    ; $0F1F01
    .animation_states
    db $04, $07, $0E, $0D, $0C, $06, $06, $05
    
    ; $0F1F09
    .x_speeds
    db $20, $E0, $20, $E0
    
    ; $0F1F0D
    .y_speeds
    db $20, $20, $E0, $E0
}

; $0F1F11-$0F1F54 JUMP LOCATION
Kyameron_Coagulate:
{
    LDA.w $0DF0, X : BNE .delay
       	INC.w $0D80, X
    
    	JSR.w Sprite3_IsBelowPlayer
    
    	TYA : ASL A : STA.b $00
    
    	JSR.w Sprite3_IsToRightOfPlayer
    
    	TYA : ORA.b $00 : TAY
    
    	LDA.w Pool_Kyameron_Coagulate_x_speeds, Y : STA.w $0D50, X
    
    	LDA.w Pool_Kyameron_Coagulate_y_speeds, Y : STA.w $0D40, X
    
    	RTS
    
    .delay
    
    CMP.b #$07 : BNE .dont_move_up
    	PHA
    
    	LDA.w $0D00, X : SEC : SBC.b #$1D : STA.w $0D00, X
    	LDA.w $0D20, X :       SBC.b #$00 : STA.w $0D20, X
    
        PLA
    
    .dont_move_up
    
    LSR #2 : TAY
    
    LDA.w Pool_Kyameron_Coagulate_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F1F55-$0F1F58 DATA
Kyameron_Moving_animation_states:
{
    db $03, $02, $01, $00
}

; $0F1F59-$0F1FE2 JUMP LOCATION
Kyameron_Moving:
{
    STZ.w $0BA0, X
    
    JSR.w Sprite3_CheckDamage : BCS .took_damage
    	JSR.w Sprite3_Move
    
    	JSR.w Sprite3_CheckTileCollision : AND.b #$03 : BEQ .no_horiz_collision
       	    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    	    ; After accumulating 3 
    	    INC.w $0EC0, X
    
	    ; OPTIMIZE: 0 length branch.
    	    BRA .no_horiz_collision
    
    	.no_horiz_collision
    
    	LDA.w $0E70, X : AND.b #$0C : BEQ .no_vert_collision
    	    LDA.w $0D40, X : EOR.b #$FF : INC A : STA.w $0D40, X
    
    	    INC.w $0EC0, X
    
    	.no_vert_collision
    
    	LDA.w $0EC0, X : CMP.b #$03 : BCC .not_enough_tile_collisions
    
    .took_damage
    
    LDA.b #$04 : STA.w $0D80, X
    
    LDA.b #$0F : STA.w $0DF0, X
    
    LDA.b #$28 : JSL.l Sound_SetSfx2PanLong
    
    .not_enough_tile_collisions
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR #3 : AND.b #$03 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    TXA : EOR.b $1A : AND.b #$07 : BNE .dont_spawn_shiny_garnish
    	JSL.l GetRandomInt

        REP #$20
        AND.w #$000F : SEC : SBC.w #$0004 : STA.b $00
    	SEP #$20
    
    	JSL.l GetRandomInt

        REP #$20
        AND.w #$000F : SEC : SBC.w #$0004 : STA.b $02
    	SEP #$20
    
    	JSL.l Sprite_SpawnSimpleSparkleGarnish
    
    .dont_spawn_shiny_garnish
    
    RTS
}

; ==============================================================================

; $0F1FE3-$0F2000 JUMP LOCATION
Kyameron_Disperse:
{
    LDA.w $0DF0, X : BNE .delay
    	STZ.w $0EC0, X
    
    	; Go back to the reset state.
    	STZ.w $0D80, X
    
    	STZ.w $0F70, X
    
    	LDA.b #$40 : STA.w $0DF0, X
    
     	RTS
    
    .delay
    
    LSR #2 : TAY
    
    CLC : ADC.b #$0F : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F2001-$0F2006 LONG JUMP LOCATION
Sprite_SpawnSimpleSparkleGarnish_SlotRestricted:
{
    PHX
    
    TXY
    
    LDX.b #$0E
    
    BRA Sprite_SpawnSimpleSparkleGarnish_search_for_slot
}

; This routine makes sparklies!
; $0F2007-$0F206B LONG JUMP LOCATION
Sprite_SpawnSimpleSparkleGarnish:
{
    PHX
    
    TXY
    
    LDX.b #$1D
    
    ; $0F200B ALTERNATE ENTRY POINT
    .search_for_slot

    .next_slot
    
    	LDA.l $7FF800, X : BEQ .empty_slot
    DEX : BPL .next_slot
    
    STX.b $0F
    
    PLX
    
    RTL
    
    .empty_slot
    
    STX.b $0F
    
    LDA.b #$05 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : CLC : ADC.b $00 : STA.l $7FF83C, X
    LDA.w $0D30, Y :       ADC.b $01 : STA.l $7FF878, X
    
    ; WTF is this math here? Will take some sorting out with the PHP / PLPs...
    LDA.w $0D00, Y : SEC : SBC.w $0F70, Y : PHP
                     CLC : ADC.b #$10     : PHP
                     CLC : ADC.b $02      : STA.l $7FF81E, X

    LDA.w $0D20, Y :       ADC.b $03      : PLP
                           ADC.b #$00     : PLP
                           SBC.b #$00     : STA.l $7FF85A, X
    
    LDA.b #$1F : STA.l $7FF90E, X
    
    TYA : STA.l $7FF92C, X
    
    LDA.w $0F20, Y : STA.l $7FF968, X
    
    PLX
    
    RTL
}

; ==============================================================================

; $0F206C-$0F2157 DATA
Pool_Kyameron_Draw:
{
    ; $0F206C
    .OAM_groups
    dw  1,   8 : db $B4, $00, $00, $00
    dw  7,   8 : db $B5, $00, $00, $00
    dw  4,  -3 : db $86, $00, $00, $00
    dw  0, -13 : db $A2, $80, $00, $02
    
    dw  2,   8 : db $B4, $00, $00, $00
    dw  6,   8 : db $B5, $00, $00, $00
    dw  4,  -6 : db $96, $00, $00, $00
    dw  0, -20 : db $A2, $00, $00, $02
    
    dw  4,  -1 : db $96, $00, $00, $00
    dw  0, -27 : db $A2, $00, $00, $02
    dw  0, -27 : db $A2, $00, $00, $02
    dw  0, -27 : db $A2, $00, $00, $02
    
    dw -6,  -6 : db $DF, $01, $00, $00
    dw 14,  -6 : db $DF, $41, $00, $00
    dw -6,  14 : db $DF, $81, $00, $00
    dw 14,  14 : db $DF, $C1, $00, $00
    
    dw -6,  -6 : db $96, $00, $00, $00
    dw 14,  -6 : db $96, $40, $00, $00
    dw -6,  14 : db $96, $80, $00, $00
    dw 14,  14 : db $96, $C0, $00, $00
    
    dw -4,  -4 : db $8D, $01, $00, $00
    dw 12,  -4 : db $8D, $41, $00, $00
    dw -4,  12 : db $8D, $81, $00, $00
    dw 12,  12 : db $8D, $C1, $00, $00
    
    dw  0,   0 : db $8D, $01, $00, $00
    dw  8,   0 : db $8D, $41, $00, $00
    dw  0,   8 : db $8D, $81, $00, $00
    dw  8,   8 : db $8D, $C1, $00, $00      
    
    ; $0F214C
    .vh_flip
    db $40, $00, $00, $00, $00, $00, $00, $00
    db $00, $40, $C0, $80
}

; $0F2158-$0F2191 LOCAL JUMP LOCATION
Kyameron_Draw:
{
    LDA.w $0DC0, X : CMP.b #$0C : BCS .dispersing
    	LDY.w $0DC0, X
    
    	LDA.w $0F50, X : PHA
    
    	AND.b #$3F : ORA Pool_Kyameron_Draw_vh_flip, Y : STA.w $0F50, X
    
    	JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    	PLA : STA.w $0F50, X
    
    	RTS
    
    .dispersing
    
    SEC : SBC.b #$0C : TAY
    
    LDA.b #$00 : XBA
    
    TYA : REP #$20 : ASL #5 : ADC.w #Pool_Kyameron_Draw_OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JMP Sprite3_DrawMultiple
}

; ==============================================================================
