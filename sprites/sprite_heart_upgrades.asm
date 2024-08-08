
; ==============================================================================

; $02EEF9-$02EF00 DATA
Pool_Sprite_HeartPiece:
{
    .messages_low
    db $58, $55, $56, $57
    
    .messages_high
    db $01, $01, $01, $01
}

; ==============================================================================

; $02EF01-$02EF08 LONG JUMP LOCATION
SpritePrep_HeartContainerLong:
    shared SpritePrep_HeartPieceLong:
{
    ; Sprite Prep for Heart Container (0xEA) / Heart Pieces (0xEB)
    PHB : PHK : PLB
    
    JSR.w HeartUpdgrade_CheckIfAlreadyObtained
    
    PLB
    
    RTL
} 

; ==============================================================================

; $02EF09-$02EF3E LOCAL JUMP LOCATION
HeartUpdgrade_CheckIfAlreadyObtained:
{
    LDA.b $1B : BNE .indoors
    
    LDA.b $8A : CMP.b #$3B : BNE .not_watergate_area
    
    LDA.l $7EF2BB : AND.b #$20 : BEQ .self_terminate
    
    .not_watergate_area
    
    PHX
    
    LDX.b $8A
    
    LDA.l $7EF280, X : AND.b #$40 : BEQ .dont_self_terminate
    
    PLX
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    RTS
    
    .dont_self_terminate
    
    PLX
    
    RTS
    
    .indoors
    
    LDA.w $0D30, X : AND.b #$01 : TAY
    
    LDA.w $0403 : AND HeartUpgrade_IndoorAcquiredMasks, Y : BEQ .dont_self_terminate_2
    
    STZ.w $0DD0, X
    
    .dont_self_terminate_2
    
    RTS
}

; ==============================================================================

; $02EF3F-$02EF46 LONG JUMP LOCATION
Sprite_HeartContainerLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_HeartContainer
    
    PLB
    
    RTL
}

; ==============================================================================

; $02EF47-$02EFC5 LOCAL JUMP LOCATION
Sprite_HeartContainer:
{
    LDA.w $040C : CMP.b #$1A : BNE .not_in_ganons_tower
    
    STZ.w $0DD0, X
    
    RTS
    
    .not_in_ganons_tower
    
    LDA.w $0ED0, X : STA.w $0BA0, X : BNE .beta
    
    LDA.b #$03
    
    PHX
    
    JSL.l GetAnimatedSpriteTile_variable
    
    PLX
    
    JSL.l Sprite_Get_16_bit_CoordsLong
    
    INC.w $0ED0, X
    
    .beta
    
    LDA.w $048E : CMP.b #$06 : BNE .dont_draw_water_ripple
    
    LDA.w $0F70, X : BNE .dont_draw_water_ripple
    
    JSL.l Sprite_AutoIncDrawWaterRippleLong
    
    .dont_draw_water_ripple
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    JSR.w Sprite2_MoveAltitude
    
    LDA.w $0F70, X : BPL .delta
    
    STZ.w $0F70, X
    
    LDA.w $0F80, X : EOR.b #$FF : INC A : LSR #2 : STA.w $0F80, X
    
    LDA.w $048E : CMP.b #$06 : BNE .delta
    
    LDA.w $0E30, X : BNE .delta
    
    LDA.w $0E40, X : CLC : ADC.b #$02 : STA.w $0E40, X
    
    INC.w $0E30, X
    
    JSL.l Sprite_SpawnWaterSplashLong
    
    .delta
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCC .epsilon
    
    RTS
    
    .epsilon
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCS HeartContainer_Grant
    
    RTS
}

; ==============================================================================

; $02EFC6-$02EFDB BRANCH LOCATION
HeartContainer_GrantFromSprite:
{
    PHX
    
    ; \item
    LDA.b #$02 : STA.w $02E9
    
    LDY.b #$3E
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    LDA.w $0403 : ORA.b #$80 : STA.w $0403
    
    RTS
}

; ==============================================================================

; $02EFDC-$02F005 BRANCH LOCATION
HeartContainer_Grant:
{
    STZ.w $0DD0, X
    
    LDA.w $0D90, X : BNE HeartContainer_GrantFromSprite
    
    PHX
    
    JSL.l Player_HaltDashAttackLong
    
    LDY.b #$26
    
    STZ.w $02E9
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    ; \item
    LDA.b $1B : BNE HeartUpgrade_SetIndoorAcquiredFlag
    
    ; $02EFF7 ALTERNATE ENTRY POINT
    shared HeartUpgrade_SetOutdoorAcquiredFlag:
    
    PHX
    
    LDX.b $8A
    
    LDA.l $7EF280, X : ORA.b #$40 : STA.l $7EF280, X
    
    PLX
    
    RTS
}


; ==============================================================================

; $02F006-$02F007 DATA
HeartUpgrade_IndoorAcquiredMasks:
{
    db $40, $20
}

; ==============================================================================

; $02F008-$02F017 BRANCH LOCATION
HeartUpgrade_SetIndoorAcquiredFlag:
{
    LDA.w $0D30, X : AND.b #$01 : TAY
    
    LDA.w $0403 : ORA HeartUpgrade_IndoorAcquiredMasks, Y : STA.w $0403
    
    RTS
}

; ==============================================================================

; $02F018-$02F01F LONG JUMP LOCATION
Sprite_HeartPieceLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_HeartPiece
    
    PLB
    
    RTL
}

; ==============================================================================

; $02F020-$02F0CC LOCAL JUMP LOCATION
Sprite_HeartPiece:
{
    LDA.w $0D80, X : BNE .skip_acquisition_check
    
    INC.w $0D80, X
    
    JSR.w HeartUpdgrade_CheckIfAlreadyObtained
    
    LDA.w $0DD0, X : BEQ .return
    
    .check_acquisition_check
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    
    JSL.l Sprite_CheckIfPlayerPreoccupied : BCS .return
    
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0E70, X : AND.b #$03 : BEQ .no_horiz_tile_collision
    
    ; \tcrf (verified)
    ; Curious, I didn't think that heart pieces and containers
    ; ever were in a position to move left or right.
    ; After testing, it was apparent that if one sets the vertical velocity,
    ; nothing will attempt to stop the heart piece from moving. Also, it
    ; seemed that moving the heart piece too fast in the horizontal
    ; directions could get it stuck in walls. Not exactly Newtonian physics
    ; here I guess...
    LDA.w $0D50, X : EOR.b #$FF : INC A : STA.w $0D50, X
    
    .no_horiz_tile_collision
    
    DEC.w $0F80, X
    
    JSR.w Sprite2_MoveAltitude
    JSR.w Sprite2_Move
    
    LDA.w $0F70, X : BPL .no_bounce
    
    STZ.w $0F70, X
    
    LDA.w $0F80, X : EOR.b #$FF : AND.b #$F8 : LSR A : STA.w $0F80, X
    
    LDA.w $0D50, X : BEQ .no_bounce
    
    CMP.b #$7F : ROR A : STA.w $0D50, X : CMP.b #$FF : BNE .no_bounce
    
    INC.w $0D50, X
    
    .no_bounce
    
    LDA.w $0F10, X : BNE .return
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCS .had_player_contact
    
    .return
    
    RTS
    
    .had_player_contact
    
    ; increment number of heart pieces acquired
    LDA.l $7EF36B : INC A : AND.b #$03 : STA.l $7EF36B : BNE .got_4_piecese
    
    PHX
    
    JSL.l Player_HaltDashAttackLong
    
    LDY.b #$26
    
    STZ.w $02E9
    
    JSL.l Link_ReceiveItem
    
    PLX
    
    BRA .self_terminate
    
    .got_4_pieces
    
    LDA.b #$2D : JSL.l Sound_SetSfx3PanLong
    
    LDA.l $7EF36B : TAY
    
    LDA.w .messages_low, Y        : XBA
    LDA.w .messages_high, Y : TAY : XBA
    
    JSL.l Sprite_ShowMessageUnconditional
    
    .self_terminate
    
    STZ.w $0DD0, X
    
    LDA.b $1B : BEQ .outdoors
    
    JMP HeartUpgrade_SetIndoorAcquiredFlag
    
    .outdoors
    
    JMP HeartUpgrade_SetOutdoorAcquiredFlag
}

; ==============================================================================

