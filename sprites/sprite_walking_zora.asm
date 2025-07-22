; ==============================================================================

; Notes:
; !depression_timer = $0ED0
; That is, the amount of time it takes to get over being damaged, and it
; will stay in this state for a couple seconds because apparently walking
; Zora are huge babies compare to most monsters when they actually get hurt.

; Walking Zora
; $029D4A-$029D7E JUMP LOCATION
Sprite_WalkingZora:
{
    LDA.w $0EA0, X : BEQ .not_recoiling
        ; Overrides the recoiling logic that many sprites would typically use.
        STZ.w $0EA0, X
        
        LDA.b #$03 : STA.w $0DA0, X
        LDA.b #$C0 : STA.w $0ED0, X
        
        LDA.w $0F40, X : STA.w $0D50, X
        ASL          : ROR.w $0D50, X
        
        LDA.w $0F30, X : STA.w $0D40, X
        ASL          : ROR.w $0D40, X
        
    .not_recoiling
    
    LDA.w $0DA0, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw WalkingZora_Waiting    ; 0x00 - $9D7F
    dw WalkingZora_Surfacing  ; 0x01 - $9D9C
    dw WalkingZora_Ambulating ; 0x02 - $9DD6
    dw WalkingZora_Depressed  ; 0x03 - $9E66
}

; ==============================================================================

; $029D7F-$029D9B JUMP LOCATION
WalkingZora_Waiting:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$7F : STA.w $0DF0, X
        
        INC.w $0DA0, X
        
        LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $029D9C-$029DD5 JUMP LOCATION
WalkingZora_Surfacing:
{
    JSR.w Zora_Draw
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0DF0, X : STA.w $0BA0, X : BNE .delay
        LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
        
        LDA.b #$28 : JSL.l Sound_SetSfx2PanLong
        
        INC.w $0DA0, X
        
        LDA.b #$30 : STA.w $0F80, X
        
        JSR.w Sprite2_DirectionToFacePlayer : TYA : STA.w $0DE0, X
                                                    STA.w $0EB0, X
        
        RTS
        
    .delay
    
    LSR #3 : TAY
    
    LDA Zora_Surfacing_animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $029DD6-$029E65 JUMP LOCATION
WalkingZora_Ambulating:
{
    LDA.w $0E80, X : AND.b #$08 : LSR : ADC.w $0DE0, X : TAY
    
    LDA Sprite_Recruit_animation_states, Y : STA.w $0DC0, X
    
    JSR.w WalkingZora_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_MoveAltitude
    
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : DEC : BPL .in_air
        LDA.w $0F80, X : CMP.b #$F0 : BPL .beta
            ; Hold x / y velocities at zero while the Zora is popping out of the
            ; water.
            JSR.w Sprite2_ZeroVelocity
            
        .beta
        
        STZ.w $0F70, X
        STZ.w $0F80, X
        
        TXA : EOR.b $1A : AND.b #$0F : BNE .delay
            JSR.w Sprite2_DirectionToFacePlayer : TYA : STA.w $0EB0, X
            
            TXA : EOR.b $1A : AND.b #$1F : BNE .delay
                TYA : STA.w $0DE0, X
                
                LDA.b #$08 : JSL.l Sprite_ApplySpeedTowardsPlayerLong
            
        .delay
    .in_air
    
    JSR.w Sprite2_Move
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0F70, X : DEC : BPL .in_air_2
        JSR.w WalkingZora_DetermineShadowStatus
        
        LDA.w $0FA5 : CMP.b #$08 : BNE .not_in_deep_water
            JSL.l Sprite_SelfTerminate
            
            LDA.b #$28 : JSL.l Sound_SetSfx2PanLong
            
            LDA.b #$03 : STA.w $0DD0, X
            LDA.b #$0F : STA.w $0DF0, X
            
            STZ.w $0D80, X
            
            LDA.b #$03 : STA.w $0E40, X
            
        .not_in_deep_water
    .in_air_2
    
    ; How is this a good use of time? Incrementing the variable
    ; inplace would be 3x faster!
    JSR.w Recruit_Moving_tick_animation_clock
    
    RTS
}

; ==============================================================================

; $029E66-$029EDA JUMP LOCATION
WalkingZora_Depressed:
{
    JSL.l Sprite_CheckDamageFromPlayerLong
    
    LDA.b $1A : AND.b #$03 : BNE .delay
        ; Decrement the depression timer...
        DEC.w $0ED0, X : BNE .delay
            LDA.b #$02 : STA.w $0DA0, X
            
            LDY.w $0DD0, X
            
            LDA.b #$09 : STA.w $0DD0, X
            
            CPY.b #$0A : BNE .not_being_carried
                STZ.w $0308
                STZ.w $0309
            
            .not_being_carried
    .delay
    
    LDA.w $0ED0, X : CMP.b #$30 : BCS .beta
        LDA.b $1A : AND.b #$01 : BNE .beta
            LDA.b $1A : LSR : AND.b #$01 : TAY
            
            LDA ZoraKing_RumblingGround_offsets_low, Y
            CLC : ADC.w $0D10, X : STA.w $0D10, X

            LDA.w WalkingZora_DetermineShadowStatus_offsets_x_high, Y
                  ADC.w $0D30, X : STA.w $0D30, X
    
    .beta
    
    STZ.w $0DC0, X
    
    STZ.w $0E70, X
    
    JSR.w WalkingZora_DrawWaterRipple
    
    DEC.w $0E40, X : DEC.w $0E40, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    INC.w $0E40, X : INC.w $0E40, X
    
    STZ.w $0EC0, X
    
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_Move
    JSL.l ThrownSprite_TileAndPeerInteractionLong

    ; Bleeds into the next function.
}
    
; $029EDB-$029EEF JUMP LOCATION
WalkingZora_DetermineShadowStatus:
{ 
    STZ.w $0EC0, X
    
    LDA.w $0F70, X : BNE .in_the_air
        LDA.w $0FA5 : CMP.b #$09 : BNE .not_in_shallow_water
            INC.w $0EC0, X
        
        .not_in_shallow_water
    .in_the_air
    
    RTS
    
    .offsets_x_high
    db $00, $FF
}

; ==============================================================================

; $029EF0-$029F07 DATA
Pool_WalkingZora_Draw:
{
    ; $029EF0
    .head_chr
    db $CE, $CE, $A4, $EE
    
    ; $029EF4
    .head_properties
    db $40, $00, $00, $00
    
    ; $029EF8
    .body_chr
    db $CC, $EC, $CC, $EC, $E8, $E8, $CA, $CA
    
    ; $029F00
    .body_properties
    db $40, $40, $00, $00, $00, $40, $00, $40
}

; $029F08-$029FAB LOCAL JUMP LOCATION
WalkingZora_Draw:
{
    JSR.w WalkingZora_DrawWaterRipple
    JSR.w Sprite2_PrepOamCoord
    
    LDY.b #$00
    
    LDA.w $0DC0, X : STA.b $06 : CMP.b #$04 : BCS .certain_animation_frame
        LSR
        
        REP #$20
        
        LDA.b $02 : SBC.w #$0000 : STA.b $02
        
        SEP #$20
        
    .certain_animation_frame
    
    PHX
    
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    LDA.b $00 : STA.b ($90), Y : AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : SEC : SBC.w #$0006 : INY : STA.b ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .head_on_screen_y_1
        LDA.w #$00F0 : STA.b ($90), Y
    
    .head_on_screen_y_1
    
    SEP #$20
    
    LDA.w Pool_WalkingZora_Draw_head_chr, X        : INY             : STA.b ($90), Y
    LDA.w Pool_WalkingZora_Draw_head_properties, X : INY : ORA.b $05 : STA.b ($90), Y
    
    LDA.b #$02 : ORA.b $0F : STA.b ($92)
    
    LDA.b $06 : PHA
    
    ASL : TAX
    
    REP #$20
    
    LDA.b $00 : INY : STA.b ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : INC : INC : INY : STA.b ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .body_on_screen_y
        LDA.w #$00F0 : STA.b ($90), Y
    
    .body_on_screen_y
    
    SEP #$20
    
    PLX
    
    LDA.w Pool_WalkingZora_Draw_body_chr, X                    : INY : STA.b ($90), Y
    LDA.w Pool_WalkingZora_Draw_body_properties, X : ORA.b $05 : INY : STA.b ($90), Y
    
    LDY.b #$01 : LDA.b #$02 : ORA.b $0F : STA.b ($92), Y
    
    PLX
    
    ; Flag being set means we're in shallow water... and the ripples are
    ; probably drawn instead?
    LDA.w $0EC0, X : BNE .dont_draw_shadow
        JSL.l Sprite_DrawShadowLong
    
    .dont_draw_shadow
    
    RTS
}

; ==============================================================================

; $029FAC-$029FDF DATA
Pool_Sprite_DrawWaterRipple:
{
    ; $029FAC
    .OAM_groups
    dw 0, 10 : db $D8, $01, $00, $00
    dw 8, 10 : db $D8, $41, $00, $00
    
    dw 0, 10 : db $D9, $01, $00, $00
    dw 8, 10 : db $D9, $41, $00, $00
    
    dw 0, 10 : db $DA, $01, $00, $00
    dw 8, 10 : db $DA, $41, $00, $00
    
    ; $029FDC
    .animation_states
    db $00, $10, $20, $10
}

; ==============================================================================

; $029FE0-$029FE4 LOCAL JUMP LOCATION
WalkingZora_DrawWaterRipple:
{
    LDA.w $0EC0, X : BEQ Sprite_AutoIncDrawWaterRipplereturn
        ; In shallow water.

        ; Bleeds into the next function.
}
    
; The distinction in the name is that it auto increments the sprite
; base pointer.
; $029FE5-$029FF9 LOCAL JUMP LOCATION
Sprite_AutoIncDrawWaterRipple:
{
    JSL.l Sprite_DrawWaterRipple
    
    REP #$20
    
    LDA.b $90 : CLC : ADC.w #$0008 : STA.b $90
    
    INC.b $92 : INC.b $92
    
    SEP #$20
    
    .return
    
    RTS
}

; ==============================================================================

; $029FFA-$02A028 LONG JUMP LOCATION
Sprite_DrawWaterRipple:
{
    PHB : PHK : PLB
    
    LDA.b $1A : LSR : LSR : AND.b #$03 : TAY
    
    LDA.w Pool_Sprite_DrawWaterRipple_animation_states, Y
    
    CLC : ADC.b ((Pool_Sprite_DrawWaterRipple_OAM_groups >> 0) & $FF)
    STA.b $08

    ; OPTIMIZE: Add #$00?
    LDA.b ((Pool_Sprite_DrawWaterRipple_OAM_groups >> 8) & $FF)
    ADC.b #$00 : STA.b $09
    
    LDA.b #$02
    JSR.w Sprite_DrawMultipleRedundantCall
    
    ; Force the palette to 2 and the nametable to 0 for both of the
    ; ripple's subsprites. Also forces the h and vflip settings to off
    ; for the first, and h flip only on the righthand subsprite.
    LDY.b #$03 : LDA.b ($90), Y : AND.b #$30 : ORA.b #$04 : STA.b ($90), Y
    LDY.b #$07 : ORA.b #$40                             : STA.b ($90), Y
    
    PLB
    
    RTL
}

; ==============================================================================

; $02A029-$02A030 LONG JUMP LOCATION
Sprite_AutoIncDrawWaterRippleLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_AutoIncDrawWaterRipple
    
    PLB
    
    RTL
}

; ==============================================================================
