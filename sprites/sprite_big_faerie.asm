
; ==============================================================================

    ; UNUSED: Appears to be true.
; $0EC412-$0EC413 DATA
{
    .unknown_0
    db 8, -8
}

; ==============================================================================

    !is_fairy_cloud = $0EB0

; $0EC414-$0EC442 JUMP LOCATION
Sprite_BigFairy:
{
    ; Big Fairy / Fairy Dust cloud
    
    ; If nonzero, it is a dust cloud
    LDA !is_fairy_cloud, X : BNE Sprite_FairyCloud
    
    JMP BigFairy_Main
    
    shared Sprite_FairyCloud:
    
    JSL Sprite_PrepOamCoordLong
    JSR Sprite4_CheckIfActive
    
    INC.w $0E80, X
    
    JSR FairyCloud_Draw 
    
    LDA.w $0E80, X : AND.b #$1F : BNE .delay_healing_sfx
    
    LDA.b #$31 : JSL Sound_SetSfx2PanLong
    
    .delay_healing_sfx
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw FairyCloud_SeekPlayer
    dw FairyCloud_AwaitFullPlayerHealth
    dw FairyCloud_FadeOut
}

; ==============================================================================

; $0EC443-$0EC488 JUMP LOCATION
FairyCloud_SeekPlayer:
{
    LDA.b #$00 : STA.w $0D90, X
    
    LDA.b #$08 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    JSR Sprite4_Move
    JSL Sprite_Get_16_bit_CoordsLong
    
    REP #$20
    
    LDA.b $22 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0003 : CMP.w #$0006 : BCS .player_too_far
    
    LDA.b $20 : SEC : SBC.w $0FDA : CLC : ADC.w #$000B : CMP.w #$0006 : BCS .player_too_far
    
    ; Add 20 hearts to the heart refill variable. This should fully heal
    ; the player no matter how many heart containers they have.
    LDA.w #$00A0 : CLC : ADC.l $7EF372 : STA.l $7EF372
    
    SEP #$20
    
    INC.w $0D80, X
    
    .player_too_far
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0EC489-$0EC49B JUMP LOCATION
FairyCloud_AwaitFullPlayerHealth:
{
    LDA.l $7EF36D : CMP.l $7EF36C : BNE .player_hp_not_full_yet
    
    INC.w $0D80, X
    
    ; TODO: Find out if this assumes that the big fairy is always in slot
    ; 0. I think it does, just not positive. HARDCODED: (confirmed) 
    LDA.b #$70 : STA !timer_2
    
    .player_hp_not_full_yet
    
    RTS
}

; ==============================================================================

; $0EC49C-$0EC4BE JUMP LOCATION
FairyCloud_FadeOut:
{
    LDA.w $0E80, X : AND.b #$0F : BNE .delay_self_termination
    
    ; BUG: I don't think there's ever an occasion where this branch
    ; will be taken, as it self terminates immediately when this variable
    ; becomes negative (see code a few lines down).
    LDA.w $0D90, X : BMI .never
    
    SEC : ROL.w $0D90, X
    
    ; OPTIMIZE: Is this really necessary? I think you could just check
    ; $0D90 for positivity (BPL) right after the ROL above.
    LDA.w $0D90, X : CMP.b #$80 : BCC .delay_self_termination
    
    LDA.b #$FF : STA.w $0D90, X
    
    STZ.w $02E4
    
    STZ.w $0DD0, X
    
    .never
    .delay_self_termination
    
    RTS
}

; ==============================================================================

    !animation_timer = $0ED0

; $0EC4BF-$0EC4F8 LOCAL JUMP LOCATION
BigFairy_Main:
{
    LDA !timer_2, X : BEQ .draw
    CMP.b #$40      : BCS .draw
    DEC A           : BNE .blinking_draw
    
    ; Self termiantes once the timer ticks down.
    STZ.w $0DD0, X
    
    .blinking_draw
    
    LSR A : BCC .draw
    
    ; On these frames, don't draw the sprite or do any other logic.
    RTS
    
    .draw
    
    JSR BigFairy_Draw
    
    ; Timer ranging from 0 - 5 to delay graphic changes
    ; Don't change graphics
    DEC !animation_timer, X : BPL .animation_delay
    
    ; Reset back to five if it ends up being negative
    LDA.b #$05 : STA !animation_timer, X
    
    ; Whenever !animation_timer counts down, change the graphics
    LDA.w $0DC0, X : INC A : AND.b #$03 : STA.w $0DC0, X
    
    .animation_delay
    
    JSR Sprite4_CheckIfActive
    
    INC.w $0E80, X ; Sometimes a subtype, in this case it's a timer.
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw BigFairy_AwaitClosePlayer
    dw BigFairy_Dormant
}

; ==============================================================================

; $0EC4F9-$0EC54E JUMP LOCATION
BigFairy_AwaitClosePlayer:
{
    JSR FairyCloud_Draw
    
    LDA.b #$01 : STA.w $0D90, X
    
    JSR Sprite4_DirectionToFacePlayer
    
    LDA.b $0F : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_too_far
    
    LDA.b $0E : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_too_far
    
    JSL Player_HaltDashAttackLong
    
    INC.w $0D80, X
    
    ; Big Fairy's text "let me heal wounds..."
    LDA.b #$5A : STA.w $1CF0
    LDA.b #$01 : STA.w $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    LDA.b #$01 : STA.w $02E4 ; Make it so Link can't move
    
    ; Create the Fairy Dust cloud
    ; NOTE: It's not checked whether the spawn was successful.
    LDA.b #$C8 : JSL Sprite_SpawnDynamically
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$01 : STA !is_fairy_cloud, Y
    
    LDA.w $0D00, Y : SEC : SBC.w $0F70, X : STA.w $0D00, Y
    
    LDA.b #$00 : STA.w $0F70, Y
    
    .player_too_far
    
    RTS
}

; ==============================================================================

; $0EC54F-$0EC54F JUMP LOCATION
BigFairy_Dormant:
{
    RTS
}

; ==============================================================================

; $0EC550-$0EC5CF DATA
Pool_BigFairy_Draw:
{
    .oam_groups
    dw -4, -8 : db $8E, $00, $00, $02
    dw  4, -8 : db $8E, $40, $00, $02
    dw -4,  8 : db $AE, $00, $00, $02
    dw  4,  8 : db $AE, $40, $00, $02
    
    dw -4, -8 : db $8C, $00, $00, $02
    dw  4, -8 : db $8C, $40, $00, $02
    dw -4,  8 : db $AC, $00, $00, $02
    dw  4,  8 : db $AC, $40, $00, $02
    
    dw -4, -8 : db $8A, $00, $00, $02
    dw  4, -8 : db $8A, $40, $00, $02
    dw -4,  8 : db $AA, $00, $00, $02
    dw  4,  8 : db $AA, $40, $00, $02
    
    dw -4, -8 : db $8C, $00, $00, $02
    dw  4, -8 : db $8C, $40, $00, $02
    dw -4,  8 : db $AC, $00, $00, $02
    dw  4,  8 : db $AC, $40, $00, $02
}

; ==============================================================================

; $0EC5D0-$0EC5ED LOCAL JUMP LOCATION
BigFairy_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #.oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04
    
    JSR Sprite4_DrawMultiple
    JSL Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

; $0EC5EE-$0EC615 DATA
Pool_FairyCloud_Draw:
{
    .xy_offsets_low
    db -12,  -6,   0,   6,  12,  18,  -9,  -3
    db   3,   9,  15,  21
    
    .xy_offsets_high
    db  -1,  -1,   0,   0,   0,   0,   -1,   -1
    db   0,   0,   0,   0
    
    .offset_indices
    db 0,  1,  2,  3,  4,  5,  2,  3
    
    ; UNUSED: While this should be considered part of the previous
    ; sublabel, the bitmask on the randomly generated numbers prevents this
    ; portion from being used. Therefore, the last 4 bytes of the offsets
    ; tables are also implicitly unused.
    ; $EC60E
    .unused
    db 6,  7,  8,  9, 10, 11,  8,  9
}

; ==============================================================================

; $0EC616-$0EC64E LOCAL JUMP LOCATION
FairyCloud_Draw:
{
    ; This apparently randomly generates the fairy cloud sparkles.
    ; It's not draw in a literal sense, but it spawns garnish entities
    ; that themselves draw sparkles via oam.
    
    LDA.w $0D90, X : BMI .spawn_inhibited
    
    ; As $0D90 accumulates bits, less and less sparkle garnishes will be
    ; generated over time.
    AND.w $0E80, X : BNE .spawn_masked_this_frame
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA .offset_indices, Y : TAY
    
    ; Randomly picking an X or Y coordinate offset
    LDA .xy_offsets_low, Y  : STA.b $00
    LDA .xy_offsets_high, Y : STA.b $01
    
    JSL GetRandomInt : AND.b #$07 : TAY
    
    LDA .offset_indices, Y : TAY
    
    ; Same here... not sure which is X and which is Y
    LDA .xy_offsets_low, Y  : STA.b $02
    LDA .xy_offsets_high, Y : STA.b $03
    
    JSL Sprite_SpawnSimpleSparkleGarnish

    .spawn_masked_this_frame
    .spawn_inhibited

    RTS
}

; ==============================================================================
