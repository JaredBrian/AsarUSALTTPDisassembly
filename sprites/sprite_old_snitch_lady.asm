
; ==============================================================================

; $02E675-$02E67C LONG JUMP LOCATION
SpritePrep_SnitchesLong:
{
    ; Sprite Prep for Scared Lady, Scared Ladies, and Inn Keeper? (0x3D, 0x34, 0x35 ?)
    
    PHB : PHK : PLB
    
    JSR.w SpritePrep_Snitches
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E67D-$02E699 LOCAL JUMP LOCATION
SpritePrep_Snitches:
{
    LDA.b #$02 : STA.w $0DE0, X : STA.w $0EB0, X
    
    INC.w $0BA0, X
    
    LDA.w $0D10, X : STA.w $0D90, X
    LDA.w $0D30, X : STA.w $0DA0, X
    
    LDA.b #$F7 : STA.w $0D50, X
    
    RTS
}

; ==============================================================================

; $02E69A-$02E6A1 LONG JUMP LOCATION
Sprite_OldSnitchLadyLong:
{
    ; Scared Ladies / Chicken Lady (0x3D)
    
    PHB : PHK : PLB
    
    JSR.w Sprite_OldSnitchLady
    
    PLB
    
    RTL
}

; ==============================================================================

; $02E6A2-$02E6A9 DATA
{
    ; TODO: Name these sublabels and the routines that use them.
    .x_speeds
    db  0,  0, -9,  9
    
    .y_speeds
    db -9,  9,  0,  0
}

; ==============================================================================

; $02E6AA-$02E705 LOCAL JUMP LOCATION
Sprite_OldSnitchLady:
{
    LDA.w $0E30, X : BEQ .not_indoor_chicken_lady
    
    JSL.l Sprite_ChickenLadyLong
    
    RTS
    
    .not_indoor_chicken_lady
    
    LDA.w $0D80, X : CMP.b #$03 : BCS .not_visible
    
    ; Draws the old lady...
    JSL.l Lady_Draw
    
    .not_visible
    
    ; $02E6BF ALTERNATE ENTRY POINT
    shared Sprite_Snitch:
    
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$03 : BCS .gamma
    
    LDA.b $1B : BEQ .outdoors
    
    JSL.l Sprite_MakeBodyTrackHeadDirection
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0EB0, X
    
    ; \tcrf (verified), submitted)
    ; You can place this sprite indoors and it behaves as a old lady
    ; looking sign that just tells you to head west for
    ; a bomb shop. Wtf? Debug sprite for testing?
    ; Looks like an old lady, and faces you, but has no collision.
    
    ; Wtf is this message doing here? I thought this was for a sprite, not
    ; a sign.
    
    ; "This Way"
    ; "<- Bomb Shop"
    LDA.b #$AD
    LDY.b #$00
    
    JSL.l Sprite_ShowSolicitedMessageIfPlayerFacing
    
    RTS
    
    .outdoors
    
    LDA.w $0D80, X : BNE .skip_player_collision_logic
    
    JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCS Snitch_FacePlayer
    
    .skip_player_collision_logic
    
    JSL.l Sprite_MakeBodyTrackHeadDirection : BCC Snitch_SetShortTimer
    
    JSR.w Sprite2_Move
    
    .gamma
    
    ; $02E6F7 ALTERNATE ENTRY POINT
    shared Snitch_RunStateHandler:
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw $E71A ; = $2E71A*
    dw $E78D ; = $2E78D*
    dw $E831 ; = $2E831*
    dw $E887 ; = $2E887*
}

; ==============================================================================

; $02E706-$02E715 BRANCH LOCATION
Snitch_FacePlayer:
{
    JSR.w Sprite2_DirectionToFacePlayer : TYA : EOR.b #$03 : STA.w $0DE0, X
    
    ; $02E70F ALTERNATE ENTRY POINT
    shared Snitch_SetShortTimer:
    
    LDA.b #$01 : STA.w $0DF0, X
    
    BRA Snitch_RunStateHandler
}

; ==============================================================================

; $02E716-$02E719 DATA
{
    ; TODO: Name these sublabels and the routines that use them.
    db -32, 32
    
    
    db -1,   0
}

; ==============================================================================

; $02E71A-$02E78C JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .alpha
    
    LDY.w $0DB0, X
    
    LDA.w $0D90, X : CLC : ADC.w $E716, Y : CMP.w $0D10, X : BNE .alpha
    
    LDA.w $0D90, X : CLC : ADC.w $E716, Y
    
    LDA.w $0DA0, X : ADC.w $E718, Y : CMP.w $0D30, X : BNE .alpha
    
    LDA.w $0DE0, X : EOR.b #$01 : STA.w $0EB0, X : TAY
    
    LDA.w $E6A2, Y : STA.w $0D50, X
    
    LDA.w $E6A6, Y : STA.w $0D40, X
    
    LDA.w $0DB0, X : EOR.b #$01 : STA.w $0DB0, X
    
    .alpha
    
    TXA : EOR.b $1A : LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    LDA.w $0F60, X : PHA
    
    LDA.b #$03 : STA.w $0F60, X
    
    ; "Hey! Here is [Name], the wanted man! Soldiers! Anyone! Come quickly!"
    LDA.b #$2F
    LDY.b #$00
    
    JSL.l Sprite_ShowMessageFromPlayerContact
    
    TAY
    
    PLA : STA.w $0F60, X : BCC .beta
    
    TYA : STA.w $0DE0, X
    
    JSL.l SpawnCrazyVillageSoldier
    
    INC.w $0D80, X
    
    .beta
    
    RTS
}

; $02E78D-$02E830 JUMP LOCATION
{
    STZ.w $0EB0, X
    
    LDY.w $0FDE
    
    LDA.w $0B18, Y : STA.b $00
    LDA.w $0B20, Y : STA.b $01
    
    LDA.w $0D00, X : STA.b $02
    LDA.w $0D20, X : STA.b $03
    
    REP #$20
    
    LDA.b $00 : CMP $02 : SEP #$30 : BCC .alpha
    
    INC.w $0D80, X
    
    STZ.w $0D50, X
    STZ.w $0D40, X
    
    LDA.b #$02 : STA.w $0F60, X
    
    LDA.w $0B08, Y : STA.b $02
    LDA.w $0B10, Y : STA.b $03
    
    PHX
    
    REP #$30
    
    LDA.b $00 : SEC : SBC.w $0708 : AND.w $070A : ASL #3 : STA.b $04
    
    LDA.b $02 : LSR #3 : SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $04 : TAX
    
    CLC
    
    JSL.l Overworld_DrawWoodenDoor
    
    PLX
    
    LDA.w #$10 : STA.w $0DF0, X
    
    RTS
    
    .alpha
    
    LDA.b #$01 : STA.w $02E4
    
    LDA.w $0B08, Y : STA.b $04
    LDA.w $0B10, Y : STA.b $05
    
    LDA.w $0B18, Y : STA.b $06
    LDA.w $0B20, Y : STA.b $07
    
    LDA.b #$40
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    LDA.b $01 : STA.w $0D50, X
    
    STZ.w $0DE0, X
    STZ.w $0EB0, X
    
    TXA : EOR.b $1A : LSR #3 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; $02E831-$02E886 JUMP LOCATION
{
    LDA.w $0DF0, X : BNE .alpha
    
    LDY.w $0FDE
    
    LDA.w $0B18, Y : STA.w $0D00, X : STA.b $00
    LDA.w $0B20, Y : STA.w $0D20, X : STA.b $01
    
    LDA.w $0B08, Y : STA.w $0D10, X : STA.b $02
    LDA.w $0B10, Y : STA.w $0D30, X : STA.b $03
    
    PHX
    
    REP #$30
    
    LDA.b $00          : SEC : SBC.w $0708 : AND.w $070A : ASL #3  : STA.b $04
    
    LDA.b $02 : LSR #3 : SEC : SBC.w $070C : AND.w $070E : CLC : ADC.b $04 : TAX
    
    SEC
    
    JSL.l Overworld_DrawWoodenDoor
    
    PLX
    
    INC.w $0D80, X
    
    .alpha
    
    JSR.w Sprite2_Move
    
    RTS
}

; $02E887-$02E88D JUMP LOCATION
{
    STZ.w $0DD0, X
    STZ.w $02E4
    
    RTS
}

; ==============================================================================

