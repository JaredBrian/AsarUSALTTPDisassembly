
    !head_x_offset = $0DA0
    !head_y_offset = $0DB0

; ==============================================================================

; $0F4379-$0F437E DATA
Pool_Sprite_YellowStalfos:
{
    .priority
    db $30, $00, $00, $00, $30, $00
}

; ==============================================================================

; $0F437F-$0F43FA JUMP LOCATION
Sprite_YellowStalfos:
{
    ; Yellow Stalfos
    
    LDA.w $0D90, X : BNE .initial_collision_check_complete
    
    LDA.b #$01 : STA.w $0D50, X
                 STA.w $0D40, X
    
    JSR Sprite3_CheckTileCollision : BEQ .dont_self_terminate
    
    ; Self terminate if the sprite would fall onto a solid tile.
    STZ.w $0DD0, X
    
    RTS
    
    .dont_self_terminate
    
    INC.w $0D90, X
    
    LDA.b #$0A : STA !head_y_offset, X
    
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDA.b #$20 : JSL Sound_SetSfx2PanLong
    
    .initial_collision_check_complete
    
    LDY.w $0D80, X
    
    LDA.w $0B89, X : ORA .priority, Y : STA.w $0B89, X
    
    JSR YellowStalfos_Draw
    JSR Sprite3_CheckIfActive
    
    LDA.l $7EF359 : CMP.b #$03 : BCC .sword_too_weak_to_cause_recoil
    
    JSR Sprite3_CheckIfRecoiling
    
    BRA .run_ai_handler
    
    .sword_too_weak_to_cause_recoil
    
    LDA.w $0D80, X : CMP.b #$05 : BEQ .neutralized
    
    LDA.w $0EF0, X : BEQ .not_recoiling
    
    STZ.w $0EF0, X
    
    ; Stalfos is unable to move after being recoiled...? I think so.
    LDA.b #$05 : STA.w $0D80, X
    
    LDA.b #$FF : STA.w $0DF0, X
    
    .neutralized
    .not_recoiling
    .run_ai_handler
    
    LDA.b #$01 : STA.w $0BA0, X
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw YellowStalfos_Descend
    dw YellowStalfos_FacePlayer
    dw YellowStalfos_PauseThenDetachHead
    dw YellowStalfos_DelayBeforeAscending
    dw YellowStalfos_Ascend
    dw YellowStalfos_Neutralized
}

; ==============================================================================

; $0F43FB-$0F4430 JUMP LOCATION
YellowStalfos_Descend:
{
    ; Head always faces down during this step.
    LDA.b #$02 : STA.w $0EB0, X
    
    LDA.w $0F70, X : PHA
    
    JSR Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .fall_speed_maxed
    
    SEC : SBC.b #$03 : STA.w $0F80, X
    
    .fall_speed_maxed
    
    PLA : EOR.w $0F70, X : BPL .aloft
    
    LDA.w $0F70, X : BPL .aloft
    
    INC.w $0D80, X
    
    STZ.w $0F70, X
    STZ.w $0F80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    JSR YellowStalfos_Animate
    
    .aloft
    
    RTS
}

; ==============================================================================

; $0F4431-$0F4456 JUMP LOCATION
YellowStalfos_FacePlayer:
{
    STZ.w $0BA0, X
    
    JSR Sprite3_CheckDamage
    JSR Sprite3_DirectionToFacePlayer
    
    TYA : STA.w $0DE0, X
          STA.w $0EB0, X
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    .delay
    
    ; $0F444E ALTERNATE ENTRY POINT
    shared YellowStalfos_LowerShields:
    
    ; Disable invulnerability.
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    RTS
}

; ==============================================================================

; $0F4457-$0F44B6 DATA
Pool_YellowStalfos_PauseThenDetachHead:
{
    .animation_states
    db 8, 5, 1, 1, 8, 5, 1, 1
    db 8, 5, 1, 1, 7, 4, 2, 2
    db 7, 4, 2, 2, 7, 4, 2, 2
    db 7, 4, 2, 2, 7, 4, 2, 2
    
    .head_x_offsets
    db $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $00, $00, $00, $00
    db $00, $00, $00, $00, $FF, $00, $01, $00
    db $FF, $00, $01, $00, $00, $00, $00, $00
    
    .head_y_offsets
    db 13, 13, 13, 13, 13, 13, 13, 13
    db 13, 13, 13, 13, 13, 13, 13, 13
    db 13, 12, 11, 10, 10, 10, 10, 10
    db 10, 10, 10, 10, 10, 10, 10, 10
}

; ==============================================================================

; $0F44B7-$0F44F6 JUMP LOCATION
YellowStalfos_PauseThenDetachHead:
{
    STZ.w $0BA0, X
    
    JSR Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay_ai_state_change
    
    INC.w $0D80, X
    
    LDA.b #$40 : STA.w $0DF0, X
    
    RTS
    
    .delay_ai_state_change
    
    CMP.b #$30 : BNE .anodetach_head
    
    PHA
    
    JSR YellowStalfos_DetachHead
    
    PLA
    
    .anodetach_head
    
    LSR #2 : AND.b #$FC : ORA.w $0DE0, X : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : LSR #2 : TAY
    
    LDA .head_x_offsets, Y : STA !head_x_offset, X
    
    LDA .head_y_offsets, Y : STA !head_y_offset, X
    
    JMP YellowStalfos_LowerShields
}

; ==============================================================================

; $0F44F7-$0F44FA DATA
Pool_YellowStalfos_DelayBeforeAscending:
{
    .animation_states
    db 6, 3, 1, 1
}

; ==============================================================================

; $0F44FB-$0F4514 JUMP LOCATION
YellowStalfos_DelayBeforeAscending:
{
    STZ.w $0BA0, X
    
    JSR Sprite3_CheckDamage
    
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    .delay
    
    ; $0F4509 ALTERNATE ENTRY POINT
    shared YellowStalfos_Animate:
    
    LDY.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    JMP YellowStalfos_LowerShields
}

; ==============================================================================

; $0F4515-$0F453E JUMP LOCATION
YellowStalfos_Ascend:
{
    STZ.w $0DC0, X
    
    LDA.b #$02 : STA.w $0EB0, X
    
    LDA.w $0F70, X : PHA
    
    JSR Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$40 : BPL .ascend_speed_maxed
    
    INC #2 : STA.w $0F80, X
    
    .ascend_speed_maxed
    
    PLA : EOR.w $0F70, X : BPL .dont_self_terminate
    
    LDA.w $0F70, X : BMI .dont_self_terminate
    
    ; Only when the stalfos rises high enough does it terminate.
    STZ.w $0DD0, X
    
    .dont_self_terminate
    
    RTS
}

; ==============================================================================

; $0F453F-$0F455E DATA
YellowStalfos_Neutralized:
{
    .animation_states
    db  1,  1,  1,  9, 10, 10, 10, 10
    db 10, 10, 10, 10, 10, 10, 10,  9
    
    .head_y_offsets
    db 10, 10, 10,  7,  0,  0,  0,  0
    db  0,  0,  0,  0,  0,  0,  0,  7
}

; ==============================================================================

; $0F455F-$0F457F JUMP LOCATION
	YellowStalfos_Neutralized:
{
    STZ.w $0BA0, X
    
    JSL Sprite_CheckDamageFromPlayerLong
    
    LDA.w $0DF0, X : BNE .delay
    
    DEC.w $0D80, X
    
    .delay
    
    LSR #4 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA .head_y_offsets, Y : STA !head_y_offset, X
    
    RTS
}

; ==============================================================================

; $0F4580-$0F45A4 LOCAL JUMP LOCATION
YellowStalfos_DetachHead:
{
    ; NOTE: One of those rare occasions where the sprite id of the spawned
    ; is different from that of the parent, as far as sprite code goes.
    ; Usually there's some variable that differentiates them and they
    ; use the same id. Refreshing.
    LDA.b #$02 : JSL Sprite_SpawnDynamically : BMI .spawn_failed
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$0D : STA.w $0F70, Y
    
    PHX
    
    TYX
    
    LDA.b #$10 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    PLX
    
    LDA.b #$FF : STA.w $0DF0, Y
    
    LDA.b #$20 : STA.w $0E00, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0F45A5-$0F4654 DATA
Pool_YellowStalfos_Draw:
{
    .oam_groups
    dw 0, 0 : db $0A, $00, $00, $02
    dw 0, 0 : db $0A, $00, $00, $02
    
    dw 0, 0 : db $0C, $00, $00, $02
    dw 0, 0 : db $0C, $00, $00, $02
    
    dw 0, 0 : db $2C, $00, $00, $02
    dw 0, 0 : db $2C, $00, $00, $02
    
    dw 5, 5 : db $2E, $00, $00, $00
    dw 0, 0 : db $24, $00, $00, $02
    
    dw 4, 1 : db $3E, $00, $00, $00
    dw 0, 0 : db $24, $00, $00, $02
    
    dw 0, 0 : db $0E, $00, $00, $02
    dw 0, 0 : db $0E, $00, $00, $02
    
    dw 3, 5 : db $2E, $40, $00, $00
    dw 0, 0 : db $24, $40, $00, $02
    
    dw 4, 1 : db $3E, $40, $00, $00
    dw 0, 0 : db $24, $40, $00, $02
    
    dw 0, 0 : db $0E, $40, $00, $02
    dw 0, 0 : db $0E, $40, $00, $02
    
    dw 0, 0 : db $2A, $00, $00, $02
    dw 0, 0 : db $2A, $00, $00, $02
    
    dw 0, 0 : db $2A, $00, $00, $02
    dw 0, 0 : db $2A, $00, $00, $02
}

; ==============================================================================

; $0F4655-$0F4691 LOCAL JUMP LOCATION
YellowStalfos_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #.oam_groups : STA.b $08
    
    LDA.b $90 : CLC : ADC.w #$0004 : STA.b $90
    
    INC.b $92
    
    SEP #$20
    
    LDA.b #$02 : JSR Sprite3_DrawMultiple
    
    REP #$20
    
    LDA.b $90 : SEC : SBC.w #$0004 : STA.b $90
    
    DEC.b $92
    
    SEP #$20
    
    LDA.w $0F00, X : BNE .anodraw_shadow
    
    JSR YellowStalfos_DrawHead
    JSL Sprite_DrawShadowLong
    
    .anodraw_shadow
    
    RTS
}

; ==============================================================================

; $0F4692-$0F4699 DATA
Pool_YellowStalfos_DrawHead:
{
    .chr
    db $02, $02, $00, $04
    
    .properties
    db $40, $00, $00, $00
}

; ==============================================================================

; $0F469A-$0F46FF LOCAL JUMP LOCATION
YellowStalfos_DrawHead:
{
    LDA.w $0DC0, X : CMP.b #$0A : BEQ .return
    
    ; This constant means don't draw the head this frame.
    LDA !head_x_offset, X : STZ.b $0D : CMP.b #$80 : BEQ .return
    
    STA.b $0C : CMP.b #$00 : BPL .sign_extend
    
    DEC.b $0D
    
    .sign_extend
    
    LDA !head_y_offset, X : STA.b $0A
                            STZ.b $0B
    
    LDY.b #$00
    
    PHX
    
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    LDA.b $00 : CLC : ADC.b $0C : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : SEC : SBC.b $0A : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_y
    
    LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_y
    
    SEP #$20
    
    LDA .chr, X        : INY           : STA ($90), Y
    LDA .properties, X : INY : ORA.b $05 : STA ($90), Y
    
    TYA : LSR #2 : TAY
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLX
    
    .return
    
    RTS
}

; ==============================================================================
