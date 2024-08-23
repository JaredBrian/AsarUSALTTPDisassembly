; ==============================================================================

; $02B8B3-$02B8E9 JUMP LOCATION
Sprite_GerudoMan:
{
    LDA.w $0D80, X : CMP.b #$02 : BCS .draw
    	; (Don't draw, just prep)
    	JSL.l Sprite_PrepOamCoordLong
    
    	BRA .draw_logic_complete
    
    .draw
    
    JSR.w GerudoMan_Draw
    
    .draw_logic_complete
    
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL A : TAY
    
    LDA.w .states, Y : DEC A : PHA
    
    SEP #$30
    
    RTS
    
    ; $02B8E0
    .states
    dw GerudoMan_ReturnToOrigin ; 0x00 - $B8EA
    dw GerudoMan_AwaitPlayer    ; 0x01 - $B90B
    dw GerudoMan_Emerge         ; 0x02 - $B93F
    dw GerudoMan_PursuePlayer   ; 0x03 - $B96C
    dw GerudoMan_Submerge       ; 0x04 - $B98F
}

; ==============================================================================

; $02B8EA-$02B90A JUMP LOCATION
GerudoMan_ReturnToOrigin:
{
    LDA.w $0DF0, X : BNE .delay
    	LDA.w $0D90, X : STA.w $0D10, X
    	LDA.w $0DA0, X : STA.w $0D30, X
    
    	LDA.w $0DB0, X : STA.w $0D00, X
    	LDA.w $0EB0, X : STA.w $0D20, X
    
    	INC.w $0D80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02B90B-$02B93E JUMP LOCATION
GerudoMan_AwaitPlayer:
{
    TXA : EOR.b $1A : AND.b #$07 : BNE .delay
    	REP #$20
    
    	LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0030 : CMP.w #$0060 : BCS .not_close
    	    LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$0030 : CMP.w #$0060 : BCS .not_close
    
    		SEP #$20
    
    		INC.w $0D80, X
    
    		LDA.b #$1F : STA.w $0DF0, X
    
    	.not_close
    .delay
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $02B93F-$02B964 JUMP LOCATION
GerudoMan_Emerge:
{
    LDA.w $0DF0, X : BNE .delay
    	INC.w $0D80, X
    
    	LDA.b #$60 : STA.w $0DF0, X
    
    	LDA.b #$10 : JSL.l Sprite_ApplySpeedTowardsPlayerLong
    
    	RTS
    
    .delay
    
    LSR #2 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
    
    ; $02B95D
    .animation_states
    db $03, $02, $00, $00, $00, $00, $00, $00
}
    
; ==============================================================================

; $02B965-$02B966 DATA
GerudoMan_PursuePlayer_animation_states:
{
    db $04, $05
}
    
; ==============================================================================

; $02B967-$02B96B DATA
GerudoMan_Submerge_animation_states:
{
    db $00, $01, $02, $03, $03
}

; ==============================================================================

; $02B96C-$02B98E JUMP LOCATION
GerudoMan_PursuePlayer:
{
    STZ.w $0BA0, X
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
    
        LDA.b #$08 : STA.w $0DF0, X
    
        RTS
    
    .delay
    
    LSR #2 : AND.b #$01 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    
    RTS
}

; ==============================================================================

; $02B98F-$02B9A5 JUMP LOCATION
GerudoMan_Submerge:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
    
        LDA.b #$10 : STA.w $0DF0, X
    
        RTS
    
    .delay
    
    LSR A : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $02B9A6-$02BA23 DATA
Pool_GerudoMan_Draw:
{
    ; $02B9A6
    .x_offsets
    dw   4,  4,  4
    dw   4,  4,  4
    dw  -8,  8,  8
    dw  -8,  8,  8
    dw -16,  0,  16
    dw -16,  0,  16
    
    ; $02B9CA
    .y_offsets
    dw 8, 8, 8
    dw 8, 8, 8
    dw 4, 4, 4
    dw 0, 0, 0
    dw 0, 0, 0
    dw 0, 0, 0
    
    ; $02B9EE
    .chr
    db $B8, $B8, $B8
    db $B8, $B8, $B8
    db $A6, $A6, $A6
    db $A6, $A6, $A6
    db $A4, $A2, $A0
    db $A0, $A2, $A4
    
    ; $02BA00
    .vh_flip
    db $00, $00, $00
    db $40, $40, $40
    db $00, $40, $40
    db $00, $40, $40
    db $40, $40, $40
    db $00, $00, $00
    
    ; $02BA12
    .sizes
    db $00, $00, $00
    db $00, $00, $00
    db $02, $02, $02
    db $02, $02, $02
    db $02, $02, $02
    db $02, $02, $02
}

; $02BA24-$02BA84 LOCAL JUMP LOCATION
GerudoMan_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : ASL A : ADC.w $0DC0, X : STA.b $06
    
    PHX
    
    LDX.b #$02
    
    .next_subsprite
    
    	PHX
    
    	TXA : CLC : ADC.b $06 : PHA
    
    	ASL A : TAX
    
    	REP #$20
    
    	LDA.b $00 : CLC : ADC Pool_GerudoMan_Draw_x_offsets, X       : STA ($90), Y
    
    	AND.w #$0100 : STA.b $0E
    
    	LDA.b $02 : CLC : ADC Pool_GerudoMan_Draw_y_offsets, X : INY : STA ($90), Y
    
    	CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
    		LDA.b #$F0 : STA ($90), Y
    
    	.on_screen_y
    
    	PLX
    
    	LDA.w Pool_GerudoMan_Drawchr, X     : INY             : STA ($90), Y
    	LDA.w Pool_GerudoMan_Drawvh_flip, X : INY : ORA.b $05 : STA ($90), Y
    
    	PHY : TYA : LSR #2 : TAY
    
    	LDA.w .sizes, X : ORA.b $0F : STA ($92), Y
    
    	PLY : INY
    PLX : DEX : BPL .next_subsprite
    
    PLX
    
    RTS
}

; ==============================================================================
