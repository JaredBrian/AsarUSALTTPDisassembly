; ==============================================================================

; UNUSED: Appears to be true.
; $0EC412-$0EC413 DATA
UNUSED1DC412:
{
    db 8, -8
}

; ==============================================================================

!is_fairy_cloud = $0EB0

; Big Fairy / Fairy Dust cloud
; $0EC414-$0EC442 JUMP LOCATION
Sprite_BigFairy:
{
    ; If nonzero, it is a dust cloud.
    LDA !is_fairy_cloud, X : BNE Sprite_FairyCloud
        JMP BigFairy_Main
}
    
; $0EC41C-$0EC442 LOCAL JUMP LOCATION
Sprite_FairyCloud:
{
    JSL.l Sprite_PrepOamCoordLong
    JSR.w Sprite4_CheckIfActive
    
    INC.w $0E80, X
    
    JSR.w FairyCloud_Draw 
    
    LDA.w $0E80, X : AND.b #$1F : BNE .delay_healing_SFX
        LDA.b #$31 : JSL.l Sound_SetSfx2PanLong
    
    .delay_healing_SFX
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw FairyCloud_SeekPlayer            ; 0x00 - $C443
    dw FairyCloud_AwaitFullPlayerHealth ; 0x01 - $C489
    dw FairyCloud_FadeOut               ; 0x02 - $C49C
}

; ==============================================================================

; $0EC443-$0EC488 JUMP LOCATION
FairyCloud_SeekPlayer:
{
    LDA.b #$00 : STA.w $0D90, X
    
    LDA.b #$08 : JSL.l Sprite_ApplySpeedTowardsPlayerLong
    
    JSR.w Sprite4_Move
    JSL.l Sprite_Get_16_bit_CoordsLong
    
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
        
        ; HARDCODED: This assumes that the big fairy is always in slot 0.
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
        DEC : BNE .blinking_draw
            ; Self termiantes once the timer ticks down.
            STZ.w $0DD0, X
            
        .blinking_draw
        
        LSR : BCC .draw
            ; On these frames, don't draw the sprite or do any other logic.
            RTS
        
    .draw
    
    JSR.w BigFairy_Draw
    
    ; Timer ranging from 0 - 5 to delay graphic changes.
    ; Don't change graphics.
    DEC !animation_timer, X : BPL .animation_delay
        ; Reset back to five if it ends up being negative.
        LDA.b #$05 : STA !animation_timer, X
        
        ; Whenever !animation_timer counts down, change the graphics.
        LDA.w $0DC0, X : INC : AND.b #$03 : STA.w $0DC0, X
        
    .animation_delay
    
    JSR.w Sprite4_CheckIfActive
    
    INC.w $0E80, X ; Sometimes a subtype, in this case it's a timer.
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw BigFairy_AwaitClosePlayer ; 0x00 - $C4F9
    dw BigFairy_Dormant          ; 0x01 - $C54F
}

; ==============================================================================

; $0EC4F9-$0EC54E JUMP LOCATION
BigFairy_AwaitClosePlayer:
{
    JSR.w FairyCloud_Draw
    
    LDA.b #$01 : STA.w $0D90, X
    
    JSR.w Sprite4_DirectionToFacePlayer
    
    LDA.b $0F : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_too_far
        LDA.b $0E : CLC : ADC.b #$30 : CMP.b #$60 : BCS .player_too_far
            JSL.l Player_HaltDashAttackLong
            
            INC.w $0D80, X
            
            ; Big Fairy's text "let me heal wounds..."
            LDA.b #$5A : STA.w $1CF0
            LDA.b #$01 : STA.w $1CF1
            JSL.l Sprite_ShowMessageMinimal
            
            LDA.b #$01 : STA.w $02E4 ; Make it so Link can't move.
            
            ; Create the Fairy Dust cloud.
            ; NOTE: It's not checked whether the spawn was successful.
            LDA.b #$C8 : JSL.l Sprite_SpawnDynamically
            
            JSL.l Sprite_SetSpawnedCoords
            
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
BigFairy_Draw_OAM_groups:
{
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

; $0EC5D0-$0EC5ED LOCAL JUMP LOCATION
BigFairy_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$04
    
    JSR.w Sprite4_DrawMultiple
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================

; $0EC5EE-$0EC615 DATA
Pool_FairyCloud_Draw:
{
    ; $0EC5EE
    .xy_offsets_low
    db -12,  -6,   0,   6,  12,  18,  -9,  -3
    db   3,   9,  15,  21
    
    ; $0EC5FA
    .xy_offsets_high
    db  -1,  -1,   0,   0,   0,   0,   -1,   -1
    db   0,   0,   0,   0
    
    ; $0EC606
    .offset_indices
    db 0,  1,  2,  3,  4,  5,  2,  3
    
    ; UNUSED: While this should be considered part of the previous
    ; sublabel, the bitmask on the randomly generated numbers prevents this
    ; portion from being used. Therefore, the last 4 bytes of the offsets
    ; tables are also implicitly unused.
    ; $0EC60E
    .unused
    db 6,  7,  8,  9, 10, 11,  8,  9
}

; This apparently randomly generates the fairy cloud sparkles.
; It's not draw in a literal sense, but it spawns garnish entities
; that themselves draw sparkles via OAM.
; $0EC616-$0EC64E LOCAL JUMP LOCATION
FairyCloud_Draw:
{
    LDA.w $0D90, X : BMI .spawn_inhibited
        ; As $0D90 accumulates bits, less and less sparkle garnishes will be
        ; generated over time.
        AND.w $0E80, X : BNE .spawn_masked_this_frame
            JSL.l GetRandomInt : AND.b #$07 : TAY
            
            LDA.w .offset_indices, Y : TAY
            
            ; Randomly picking an X or Y coordinate offset.
            LDA.w Pool_FairyCloud_Draw_xy_offsets_low, Y  : STA.b $00
            LDA.w Pool_FairyCloud_Draw_xy_offsets_high, Y : STA.b $01
            
            JSL.l GetRandomInt : AND.b #$07 : TAY
            
            LDA.w Pool_FairyCloud_Draw_offset_indices, Y : TAY
            
            ; Same here... not sure which is X and which is Y.
            LDA.w Pool_FairyCloud_Draw_xy_offsets_low, Y  : STA.b $02
            LDA.w Pool_FairyCloud_Draw_xy_offsets_high, Y : STA.b $03
            
            JSL.l Sprite_SpawnSimpleSparkleGarnish

        .spawn_masked_this_frame
    .spawn_inhibited

    RTS
}

; ==============================================================================
