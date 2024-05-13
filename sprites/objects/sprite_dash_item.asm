
; ==============================================================================

; $02FBEF-$02FBF6 LONG JUMP LOCATION
Sprite_DashItemLong:
{
    PHB : PHK : PLB
    
    JSR Sprite_DashItem
    
    PLB
    
    RTL
}

; ==============================================================================

; $02FBF7-$02FC03 LOCAL JUMP LOCATION
Sprite_DashItem:
{
    ; Based on the item's appearance, different code is
    ; executed >_>.
    
    LDA $0DC0, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Sprite_DashBookOfMudora
    dw Sprite_DashKey
    dw Sprite_DashTreetop
}

; ==============================================================================

; $02FC04-$02FC4D JUMP LOCATION
Sprite_DashKey:
{
    JSL DashKey_Draw
    JSR Sprite2_CheckIfActive
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
    
    LDA.b #$03 : STA $0D80, X
    
    .alpha
    
    JSR Sprite2_Move
    
    DEC $0F80, X
    
    JSR Sprite2_MoveAltitude
    
    LDA $0F70, X : BPL .beta
    
    STZ $0D40, X
    
    STZ $0F70, X
    
    LDA $0F80, X : EOR.b #$FF : INC A : LSR #2 : STA $0F80, X
    
    AND.b #$FE : BEQ .beta
    
    LDA.b #$14 : JSL Sound_SetSfx3PanLong
    
    .beta
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw DashKey_WaitForDashAttack
    dw DashItem_BeginFalling
    dw DashItem_WaitTillTouchingGround
    dw DashKey_GiveToPlayer
}

; ==============================================================================

; $02FC4E-$02FC7B JUMP LOCATION
DashKey_WaitForDashAttack:
{
    REP #$20
    
    ; If the player gets close enough while the screen is shaking (from
    ; a dash attack), make the sprite drop.
    
    LDA $0FD8 : SEC : SBC $22 : CLC : ADC.w #$0010 : CMP.w #$0021 : BCS .not_close
    
    LDA $0FDA : SEC : SBC $20 : CLC : ADC.w #$0018 : CMP.w #$0029 : BCS .not_close
    
    LDA $011A : ORA $011C : BEQ .screen_not_shaking
    
    INC $0D80, X
    
    .screen_not_shaking
    .not_close
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $02FC7C-$02FC7D DATA
Pool_DashKey_GiveToPlayer:
{
    db $40, $20
}

; ==============================================================================

; $02FC7E-$02FC9D JUMP LOCATION
DashKey_GiveToPlayer:
{
    ; Increase the number of Keys Link has.
    
    LDA $7EF36F : INC A : STA $7EF36F
    
    STZ $0DD0, X ; Kill the sprite
    
    LDA $0CBA, X : TAY
    
    LDA $0403 : ORA $FC7C, Y : STA $0403
    
    LDA.b #$2F : JSL Sound_SetSfx3PanLong
    
    RTS
}

; ==============================================================================

; $02FC9E-$02FCE7 JUMP LOCATION
Sprite_DashBookOfMudora:
{
    ; Dash Item - Book of Mudora
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    JSR Sprite2_CheckIfActive
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
    
    LDA.b #$03 : STA $0D80, X
    
    .alpha
    
    JSR Sprite2_Move
    
    DEC $0F80, X
    
    JSR Sprite2_MoveAltitude
    
    LDA $0F70, X : BPL .beta
    
    STZ $0D40, X
    STZ $0F70, X
    
    LDA $0F80, X : EOR.b #$FF : INC A : LSR #2 : STA $0F80, X : AND.b #$FE : BEQ .beta
    
    LDA.b #$21 : JSL Sound_SetSfx2PanLong
    
    .beta
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw DashBookOfMudora_WaitForDashAttack
    dw DashItem_BeginFalling
    dw DashItem_WaitTillTouchingGround
    dw DashBookOfMudora_GiveToPlayer
}

; ==============================================================================

; $02FCE8-$02FD1A JUMP LOCATION
DashBookOfMudora_WaitForDashAttack:
{
    LDA $002F : BNE .must_be_facing_north
    
    REP #$20
    
    LDA $0FD8 : SEC : SBC $22 : CLC : ADC.w #$0027 : CMP.w #$002F : BCS .not_close
    
    LDA $0FDA : SEC : SBC $20 : CLC : ADC.w #$0028 : CMP.w #$002E : BCS .not_close
    
    LDA $011A : ORA $011C : BEQ .screen_not_shaking
    
    INC $0D80, X
    
    .screen_not_shaking
    .not_close
    .must_be_facing_north
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $02FD1B-$02FD2D JUMP LOCATION
DashItem_BeginFalling:
{
    LDA.b #$20 : STA $0F80, X
    
    LDA.b #$FB : STA $0D40, X
    
    INC $0D80, X
    
    LDA.b #$1B : STA $012F
    
    RTS
}

; ==============================================================================

; $02FD2E-$02FD39 JUMP LOCATION
DashItem_WaitTillTouchingGround:
{
    LDA $0F70, X : BNE .not_on_ground
    
    ; Set sprite to same layer as player.
    LDA $00EE : STA $0F20, X
    
    .not_on_ground
    
    RTS
}

; ==============================================================================

; $02FD3A-$02FD4C JUMP LOCATION
DashBookOfMudora_GiveToPlayer:
{
    PHX
    
    JSL Player_HaltDashAttackLong
    
    LDY.b #$1D
    
    STZ $02E9
    
    JSL Link_ReceiveItem
    
    PLX
    
    STZ $0DD0, X
    
    RTS
}

; ==============================================================================

; $02FD4D-$02FD97 JUMP LOCATION
Sprite_DashTreetop:
{
    ; Dashable treetop (dashable after beating Agahnim)
    LDA.b #$8F : STA $0E40, X
    LDA.b #$47 : STA $0F60, X
    
    JSR DashTreeTop_Draw
    JSR Sprite2_CheckIfActive
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .alpha
    
    PHX
    
    JSL Sprite_NullifyHookshotDrag
    
    STZ $5E
    
    JSL Sprite_RepelDashAttackLong
    
    PLX
    
    .alpha
    
    JSR Sprite2_Move
    
    DEC $0F80, X
    
    JSR Sprite2_MoveAltitude
    
    LDA $0F70, X : BPL .beta
    
    STZ $0F70, X
    
    LDA $0F80, X : EOR.b #$FF : INC A : LSR #2 : STA $0F80, X
    
    .beta
    
    LDA $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw DashTreeTop_WaitForDashAttack
    dw DashTreeTop_SpawnLeaves
    dw DashTreeTop_DancingLeaves
}

; ==============================================================================

; $02FD98-$02FDCF JUMP LOCATION
DashTreeTop_WaitForDashAttack:
{
    STZ $0E80, X
    
    REP #$20
    
    LDA $0FD8 : SEC : SBC $22 : CLC : ADC.w #$0018 : CMP.w #$0041 : BCS .not_close
    
    LDA $0FDA : SEC : SBC $20 : CLC : ADC.w #$0020 : CMP.w #$0051 : BCS .not_close
    
    SEP #$30
    
    LDA $011A : ORA $011C : BEQ .screen_not_shaking
    
    INC $0D80, X
    
    LDA.b #$14 : STA $0F80, X
    
    .screen_not_shaking
    .not_close
    
    SEP #$30
    
    RTS
}

; ==============================================================================

; $02FDD0-$02FE0A JUMP LOCATION
DashTreeTop_SpawnLeaves:
{
    ; Is this a useful ... test?
    LDA $0F70, X : BNE .not_on_ground
    
    INC $0D80, X
    
    LDA.b #$1B : STA $012F
    
    LDA.b #$FC : STA $0D50, X : STA $0D40, X
    
    JSR DashTreeTop_SpawnLeafCluster
    
    LDA.b #$05 : STA $0D50, Y : STA $0D40, Y
    
    JSR DashTreeTop_SpawnLeafCluster
    
    LDA.b #$05 : STA $0D50, Y
    LDA.b #$FC : STA $0D40, Y
    
    JSR DashTreeTop_SpawnLeafCluster
    
    LDA.b #$FC : STA $0D50, Y
    LDA.b #$04 : STA $0D40, Y
    
    .not_on_ground
    
    RTS
}

; ==============================================================================

; $02FE0B-$02FE22 JUMP LOCATION
DashTreeTop_DancingLeaves:
{
    LDA $0DF0, X : BNE .delay
    
    LDA.b #$08 : STA $0DF0, X
    
    LDA $0E80, X : CMP.b #$06 : BNE .animation_clock_not_expired
    
    STZ $0DD0, X
    
    .animation_clock_not_expired
    
    INC $0E80, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02FE6F-$02FF38 LOCAL JUMP LOCATION
DashTreeTop_Draw:
{
    JSR Sprite2_PrepOamCoord
    
    LDA $0FA8 : SEC : SBC.b #$20 : STA $0FA8
    LDA $0FA9 : SEC : SBC.b #$20 : STA $0FA9
    
    PHX
    
    LDA $0E80, X : BNE .alpha
    
    REP #$10
    
    LDX $90
    
    LDA.b #$03 : STA $00
    
    LDA $0FA8
    
    .beta
    
    STA $00, X : STA $10, X : STA $20, X : STA $30, X
    
    CLC : ADC.b #$10
    
    INX #4
    
    DEC $00 : BPL .beta
    
    LDX $90
    
    LDA $0FA9  : STA $01, X : STA $05, X : STA $09, X : STA $0D, X
    CLC : ADC.b #$10 : STA $11, X : STA $15, X : STA $19, X : STA $1D, X
    CLC : ADC.b #$10 : STA $21, X : STA $25, X : STA $29, X : STA $2D, X
    CLC : ADC.b #$10 : STA $31, X : STA $35, X : STA $39, X : STA $3D, X
    
    REP #$30
    
    LDY.w #$0000
    
    .gamma
    
    LDA.w $FE23, Y : STA $02, X
    
    INX #4
    
    INY #2 : CPY.w #$0020 : BCC .gamma
    
    SEP #$30
    
    PLX
    
    LDA.b #$0F
    LDY.b #$02
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
    
    .alpha
    
    LDA $0E80, X : DEC A : STA $00 : STZ $01
    
    REP #$10
    
    LDX $90
    
    LDY.w #$000F
    
    .delta
    
    LDA $0FA8 : CLC : ADC $FE43, Y : STA $00, X
    
    INX
    
    LDA $0FA9 : CLC : ADC $FE53, Y : STA $00, X
    
    INX
    
    PHY
    
    LDY $00
    
    LDA.w $FE63, Y : STA $00, X
    
    INX
    
    LDA.w $FE69, Y : STA $00, X
    
    INX
    
    PLY : DEY : BPL .delta
    
    SEP #$30
    
    PLX
    
    LDA.b #$0F
    LDY.b #$02
    
    JSL Sprite_CorrectOamEntriesLong
    
    RTS
}

; ==============================================================================

; $02FF39-$02FF5D JUMP LOCATION
DashTreeTop_SpawnLeafCluster:
{
    LDA.b #$3B : JSL Sprite_SpawnDynamically
    
    LDA.b #$02 : STA $0DC0, Y
    
    LDA $0F80, X : STA $0F80, Y
    
    LDA.b #$01 : STA $0E80, Y
    
    LDA.b #$02 : STA $0D80, Y
    
    LDA.b #$08 : STA $0DF0, Y
    
    JSL Sprite_SetSpawnedCoords
    
    RTS
}

; ==============================================================================
