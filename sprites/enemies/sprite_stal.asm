
; ==============================================================================

; $0E8129-$0E814E JUMP LOCATION
Sprite_Stal:
{
    LDA.w $0FC6 : CMP.b #$03 : BCS .improper_gfx_set_loaded
    
    LDA.w $0D80, X : BNE .ignore_player_oam_overlap
    
    LDA.b #$04 : JSL OAM_AllocateFromRegionB
    
    .ignore_player_oam_overlap
    
    JSR Stal_Draw
    
    .improper_gfx_set_loaded
    
    JSR Sprite4_CheckIfActive
    JSR Sprite4_CheckIfRecoiling
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Stal_Dormant
    dw Stal_Active
}

; ==============================================================================

; $0E814F-$0E8197 JUMP LOCATION
Stal_Dormant:
{
    LDA.b #$01 : STA.w $0BA0, X
    
    JSL Sprite_CheckDamageToPlayerSameLayerLong : BCC .player_didnt_bump
    
    JSL Sprite_NullifyHookshotDrag
    JSL Sprite_RepelDashAttackLong
    
    LDA.w $0DF0, X : BNE .still_activating
    
    LDA.b #$40 : STA.w $0DF0, X
    
    LDA.b #$22 : JSL Sound_SetSfx2PanLong
    
    .still_activating
    .player_didnt_bump
    
    LDA.w $0DF0, X : BEQ .never_bumped
    DEC A        : BEQ .fully_activated
    
    ORA.b #$40 : STA.w $0EF0, X
    
    .never_bumped
    
    RTS
    
    .fully_activated
    
    STZ.w $0BA0, X
    
    INC.w $0D80, X
    
    STZ.w $0EF0, X
    
    LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
    
    ; Unse the top bit of this variable so that it can start damaging
    ; the player from contact.
    ASL.w $0E40, X : LSR.w $0E40, X
    
    RTS
}

; ==============================================================================

; $0E8198-$0E819C DATA
Pool_Stal_Active:
{
    .animation_states
    db $02, $02, $01, $00, $01
}

; ==============================================================================

; $0E819D-$0E81DB JUMP LOCATION
Stal_Active:
{
    JSR Sprite4_CheckDamage
    JSR Sprite4_Move
    JSR Sprite4_CheckTileCollision
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .not_grounded
    
    STZ.w $0F70, X
    
    LDA.b #$10 : STA.w $0F80, X
    
    LDA.b #$0C
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    .not_grounded
    
    LDA $1A : AND.b #$03 : BNE .anotick_animation_timer
    
    INC.w $0E80, X
    
    LDA.w $0E80, X : CMP.b #$05 : BNE .anoreset_animation_timer
    
    STZ.w $0E80, X
    
    .anoreset_animation_timer
    .anotick_animation_timer
    
    LDY.w $0E80, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E81DC-$0E820B DATA
Pool_Stal_Draw:
{
    .oam_groups
    dw 0,  0 : db $44, $00, $00, $02
    dw 4, 11 : db $70, $00, $00, $00
    
    dw 0,  0 : db $44, $00, $00, $02
    dw 4, 12 : db $70, $00, $00, $00
    
    dw 0,  0 : db $44, $00, $00, $02
    dw 4, 13 : db $70, $00, $00, $00
}

; ==============================================================================

; $0E820C-$0E8234 LOCAL JUMP LOCATION
Stal_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #$81DC : STA $08
    
    SEP #$20
    
    LDA.b #$02
    
    LDY.w $0D80, X : BNE .active
    
    DEC A
    
    .active
    
    JSL Sprite_DrawMultiple
    
    LDA.w $0D80, X : BEQ .dormant
    
    JSL Sprite_DrawShadowLong
    
    .dormant
    
    RTS
}

; ==============================================================================
