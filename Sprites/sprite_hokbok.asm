    
; ==============================================================================

; $0EC64F-$0EC699 JUMP LOCATION
Sprite_Hokbok:
{
    LDA.w $0DB0, X : BEQ Hokbok_Main
        ; Sprite_Ricochet:
    
    	JSL.l Sprite_PrepAndDrawSingleLargeLong
    	JSR.w Sprite4_CheckIfActive
    	JSR.w Sprite4_CheckDamage
    	JSR.w Sprite4_MoveXyz
    
    	DEC.w $0F80, X : DEC.w $0F80, X
    
    	LDA.w $0F70, X : BPL .no_ground_bounce
    	    LDA.b #$10 : STA.w $0F80, X
    
    	    STZ.w $0F70, X
    
    	.no_ground_bounce
    
    	JSR.w Sprite4_BounceFromTileCollision : BEQ .no_tile_collision
            LDA.b #$21
			JSL.l Sound_SetSFX2PanLong
    
    	.no_tile_collision
    
    	LDA.w $0ED0, X : CMP.b #$03 : BCC .not_quite_dead
    	    LDA.b #$06 : STA.w $0DD0, X
    
    	    LDA.b #$0A : STA.w $0DF0, X
    
    	    STZ.w $0BE0, X
    
    	    LDA.b #$1E
			JSL.l Sound_SetSFX2PanLong
    
    	.not_quite_dead
    
    	RTS
}

; ==============================================================================

; NOTE: $0D90, X is the number of segments in addition to the head.
; NOTE: $0DA0, X is the spacing between segments. (Fairly certain of this).

; $0EC69A-$0EC718 BRANCH LOCATION
Hokbok_Main:
{
    JSR.w Hokbok_Draw
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0EA0, X : BEQ .dont_remove_segment
    	LDY.w $0D90, X : BEQ .dont_remove_segment
    	CMP.b #$0F     : BNE .dont_remove_segment
    	    LDA.b #$06 : STA.w $0EA0, X
    
    	    LDA.w $0F70, X : CLC : ADC.w $0DA0, X : STA.w $0F70, X
    	    DEC.w $0D90, X : BNE .dont_reset_head_hp
				; NOTE: Apparently, the sprite's health gets restored to
				; full once all of the other segments are picked off. This is
				; somewhat analogous to how the last Armos Knight gets a health
				; refill when they turn red.
				LDA.b #$11 : STA.w $0E50, X
    
    	    .dont_reset_head_hp
    
    	LDA.w $0D50, X : BPL .positive_x_speed
    	    SEC : SBC.b #$08
    
    	.positive_x_speed
    
    	CLC : ADC.b #$04 : STA.w $0D50, X
    
    	LDA.w $0D40, X : BPL .positive_y_speed
    	    SEC : SBC.b #$08
    	
    	.positive_y_speed
    
    	CLC : ADC.b #$04 : STA.w $0D40, X
    
    	; Spawn a Ricochet sprite since a segment was knocked off of the Hokbok.
    	LDA.b #$C7
		JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
    	    JSL.l Sprite_SetSpawnedCoords
    
    	    LDA.b #$01 : STA.w $0DB0, Y
                         STA.w $0E50, Y
    
    	    LDA.w $0F40, X : STA.w $0D50, Y
    
    	    LDA.w $0F30, X : STA.w $0D40, Y
    
    	    LDA.b #$40 : STA.w $0CAA, Y
    
        .spawn_failed
    .dont_remove_segment
    
    JSR.w Sprite4_CheckIfRecoiling
    JSR.w Sprite4_CheckDamage
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Hokbok_ResetBounceVelocity ; 0x00 - $C721
    dw Hokbok_Moving              ; 0x01 - $C738
}

; ==============================================================================

; $0EC719-$0EC720 DATA
Hokbok_ResetBounceVelocity_spacing_amounts:
{
    db $08, $07, $06, $05, $04, $05, $06, $07
}

; $0EC721-$0EC737 JUMP LOCATION
Hokbok_ResetBounceVelocity:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
    
        LDA.b #$10 : STA.w $0F80, X
    
        RTS
    
    .delay
    
    LSR : TAY
    LDA.w .spacing_amounts, Y : STA.w $0DA0, X
    
    RTS
}

; ==============================================================================

; $0EC738-$0EC750 JUMP LOCATION
Hokbok_Moving:
{
    JSR.w Sprite4_MoveXyz
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .no_ground_bounce    
        STZ.w $0F70, X
    
        STZ.w $0D80, X
    
        LDA.b #$0F : STA.w $0DF0, X
    
    .no_ground_bounce

    ; Bleeds into the next function.
}
    
; $0EC751-$0EC777 JUMP LOCATION
Sprite4_BounceFromTileCollision:
{
    JSR.w Sprite4_CheckTileCollision : AND.b #$03 : BEQ .no_horiz_collision
        LDA.w $0D50, X : EOR.b #$FF : INC : STA.w $0D50, X
    
    	INC.w $0ED0, X
    
    .no_horiz_collision
    
    LDA.w $0E70, X : AND.b #$0C : BEQ .no_vert_collision
    	LDA.w $0D40, X : EOR.b #$FF : INC : STA.w $0D40, X
    
    	INC.w $0ED0, X
    
    .no_vert_collision
    
    RTS
}

; ==============================================================================

; $0EC778-$0EC77B LONG JUMP LOCATION
Sprite_BounceFromTileCollisionLong:
{
    JSR.w Sprite4_BounceFromTileCollision
    
    RTL
}

; $0EC77C-$0EC77C LOCAL JUMP LOCATION
UNUSED1DC77C:
{
    RTS
}

; ==============================================================================

; $0EC77D-$0EC7EA LOCAL JUMP LOCATION
Hokbok_Draw:
{
    JSR.w Sprite4_PrepOamCoord
    
    LDA.w $0DA0, X : STA.b $06
                     STZ.b $07
    
    PHX
    
    LDA.w $0D90, X : TAX
    TYA : CLC : ADC.b #$0C : TAY
    
    .next_subsprite
    
        REP #$20
    
        LDA.b $00 : STA.b ($90), Y
    
        AND.w #$0100 : STA.b $0E
    
        INY
    
    	LDA.b $02 : PHA
		SEC : SBC.b $06 : STA.b $02

        PLA : STA.b ($90), Y
    	CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    	    LDA.b #$F0 : STA.b ($90), Y
    
    	.on_screen_y
    
    	LDA.b #$A0
    
    	CPX.b #$00 : BNE .not_head_segment
    	    LDA.b #$A2
    
    	.not_head_segment
    
    	PHX
    
        LDX.b $06 : CPX.b #$07 : BCS .dont_use_squished_alternate
    	    SEC : SBC.b #$20
    
    	.dont_use_squished_alternate
    
    	PLX
    
                    INY : STA.b ($90), Y
    	LDA.b $05 : INY : STA.b ($90), Y
    
    	PHY
		TYA : LSR : LSR : TAY
    	LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
    
    	PLA : SEC : SBC.b #$07 : TAY
    DEX : BPL .next_subsprite
    
    PLX
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
