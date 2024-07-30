
; ==============================================================================

; $0F3002-$0F3054 JUMP LOCATION
Sprite_Zol:
{
    LDA.w $0DD0, X : CMP.b #$09 : BNE .skip_initial_collision_check
    LDA.w $0E90, X : BEQ .skip_initial_collision_check
        STZ.w $0E90, X
        
        LDA.b #$01 : STA.w $0D50, X
        
        JSR Sprite3_CheckTileCollision
        
        STZ.w $0D50, X
        
        BEQ .anoself_terminate
            STZ.w $0DD0, X
            
            RTS

        .anoself_terminate

        LDA.b #$20 : JSL Sound_SetSfx2PanLong

    .skip_initial_collision_check

    LDA.w $0DB0, X : BEQ .use_oam_normal_priority_scheme
    LDA.b #$30 : STA.w $0B89, X

    .use_oam_normal_priority_scheme

    JSR Zol_Draw
    JSR Sprite3_CheckIfActive
    
    LDA.w $0D80, X : CMP.b #$02 : BCC .cant_damage_player
    JSL Sprite_CheckDamageFromPlayerLong

    .cant_damage_player

    JSR Sprite3_CheckIfRecoiling
    
    LDA.w $0D80, X
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    dw Zol_HidingUnseen
    dw Zol_PoppingOut
    dw Zol_Falling
    dw Zol_Active
}

; ==============================================================================

; $0F3055-$0F309E JUMP LOCATION
Zol_HidingUnseen:
{
    LDA.w $0F60, X : PHA : ORA.b #$09 : STA.w $0F60, X
    
    LDA.w $0E40, X : ORA.b #$80 : STA.w $0E40, X
    
    JSR Sprite3_CheckDamageToPlayer
    
    PLA : STA.w $0F60, X : BCC .didnt_touch_player
    INC.w $0D80, X
    
    LDA.b #$7F : STA.w $0DF0, X
    
    ; Clear untouchable bit.
    ASL.w $0E40, X : LSR.w $0E40, X
    
    LDA.b $22 : STA.w $0D10, X
    LDA.b $23 : STA.w $0D30, X
    
    LDA.b $20 : CLC : ADC.b #$08 : STA.w $0D00, X
    LDA.b $21 : ADC.b #$00 : STA.w $0D20, X
    
    LDA.b #$30 : STA.w $0F10, X
    
    STZ.w $0BA0, X

    .didnt_touch_player

    RTS
}

; ==============================================================================

; $0F309F-$0F30AE DATA
Pool_Zol_PoppingOut:
{
    .animation_states
    db $00, $01, $07, $07, $06, $06, $05, $05
    db $06, $06, $05, $05, $04, $04, $04, $04
}

; ==============================================================================

; $0F30AF-$0F30D3 JUMP LOCATION
Zol_PoppingOut:
{
    LDA.w $0DF0, X : BNE .delay
    INC.w $0D80, X
    
    ; Make the Zol jump up.
    LDA.b #$20 : STA.w $0F80, X
    
    LDA.b #$10 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    ; Play popping out of ground sfx.
    LDA.b #$30 : JSL Sound_SetSfx3PanLong
    
    RTS

    .delay

    LSR #3 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0F30D4-$0F30D5 DATA
Pool_Zol_Falling:
{
    .animation_states
    db $00, $01
}

; ==============================================================================

; $0F30D6-$0F3143 JUMP LOCATION
Zol_Falling:
{
    LDA.w $0DF0, X : BEQ .falling_from_above
    DEC A        : BNE .hobble_around
        LDA.b #$20 : STA.w $0DF0, X
        
        INC.w $0D80, X
        
        STZ.w $0DC0, X
        
        RTS

    ; TODO: Is this label correctly named?
    .hobble_around

    LSR #4 : TAY
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    LDA.b $1A : LSR A : AND.b #$01 : TAY
    
    LDA .x_speeds, Y : STA.w $0D50, X
    
    JSR Sprite3_MoveHoriz
    
    RTS

    .falling_from_above

    JSL Sprite_CheckDamageFromPlayerLong
    JSR Sprite3_Move
    JSR Sprite3_CheckTileCollision
    
    LDA.w $0F70, X : PHA
    
    JSR Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .fall_speed_maxed_out
    SEC : SBC.b #$02 : STA.w $0F80, X

    .fall_speed_maxed_out

    PLA : EOR.w $0F70, X : BPL .didnt_hit_ground
    LDA.w $0F70, X : BPL .didnt_hit_ground
        STZ.w $0F80, X
        
        STZ.w $0F70, X
        
        STZ.w $0DB0, X
        
        LDA.b #$1F : STA.w $0DF0, X
        
        LDA.b #$08 : STA.w $0EB0, X

    .didnt_hit_ground

    RTS

    .x_speeds
    db -8,  8
}

; =============================================================================

; $0F3144-$0F31C0 JUMP LOCATION
Zol_Active:
{
    JSR Sprite3_CheckDamageToPlayer
    
    LDA.w $0E00, X : BNE .delay_retargeting_player
    LDA.b #$30 : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    JSL GetRandomInt : AND.b #$3F : ORA.b #$60 : STA.w $0E00, X
    
    ; Set h flip based on msb of x speed.
    ASL.w $0F50, X : ASL.w $0F50, X
    
    LDA.w $0D50, X : ASL A : ROR.w $0F50, X : LSR.w $0F50, X

    .delay_retargeting_player

    ; TODO: Figure out if this label is correctly named. Zols do get
    ; agitated though...
    LDA.w $0E10, X : BNE .not_agitated
    INC.w $0E80, X
    
    LDA.w $0E80, X : AND.b #$0E : ORA.w $0E70, X : BNE .deagitation_delay
        JSR Sprite3_Move
        
        INC.w $0ED0, X : LDA.w $0ED0, X : CMP.w $0EB0, X : BNE .deagitation_delay
            STZ.w $0ED0, X
            
            JSL GetRandomInt : AND.b #$1F : ADC.b #$40 : STA.w $0E10, X
            
            JSL GetRandomInt : AND.b #$1F : ORA.b #$10 : STA.w $0EB0, X

    .deagitation_delay

    JSR Sprite3_CheckTileCollision
    
    LDA.w $0E80, X : AND.b #$08 : LSR #3 : STA.w $0DC0, X
    
    RTS

    .not_agitated

    LDY.b #$00
    
    AND.b #$10 : BEQ .use_base_animation_state
    INY

    .use_base_animation_state

    TYA : STA.w $0DC0, X
    
    RTS
}

; =============================================================================

; $0F31C1-$0F31C4 DATA
Pool_Zol_Draw:
{
    .hflip_states
    db $00, $00, $40, $40
}

; =============================================================================

; $0F31C5-$0F3213 LOCAL JUMP LOCATION
Zol_Draw:
{
    LDA.w $0F50, X : LSR A : BCS .skip_unknown_check
    ; TODO: What are this and the branch instruction above for?
    LDA.w $0FC6 : CMP.b #$03 : BCS .return

    .skip_unknown_check

    LDA.w $0F10, X : BEQ .draw_in_front_of_player
    ; Draw behind player.
    LDA.b #$08 : JSL OAM_AllocateFromRegionB

    .draw_in_front_of_player

    LDA.w $0D80, X : BEQ .not_visible
    LDA.w $0DC0, X : CMP.b #$04 : BCS Zol_DrawMultiple
    
    PHA : TAY
    
    LDA.w $0F50, X : PHA
    
    EOR .hflip_states, Y : STA.w $0F50, X
    
    ; WTF: With all the use of $0F50, X?
    AND.b #$01 : EOR.b #$01 : ASL #2 : CLC : ADC.w $0DC0, X : STA.w $0DC0, X
    
    JSL Sprite_PrepAndDrawSingleLargeLong
    
    PLA : STA.w $0F50, X
    PLA : STA.w $0DC0, X
    
    RTS

    .not_visible

    ; WTF: Am I to understand that this is doing anything useful?
    JSL Sprite_PrepOamCoordLong

    .return

    RTS
}

; =============================================================================

; $0F3214-$0F3253 DATA
Pool_Zol_DrawMultiple:
{
    .oam_groups
    dw 0, 8 : db $6C, $03, $00, $00
    dw 8, 8 : db $6D, $03, $00, $00
    dw 0, 8 : db $60, $00, $00, $00
    dw 8, 8 : db $70, $00, $00, $00
    dw 0, 8 : db $70, $40, $00, $00
    dw 8, 8 : db $60, $40, $00, $00
    dw 0, 0 : db $40, $00, $00, $02
    dw 0, 0 : db $40, $00, $00, $02
}

; =============================================================================

; $0F3254-$0F326E LOCAL JUMP LOCATION
Zol_DrawMultiple:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : SEC : SBC.b #$04 : REP #$20 : ASL #4
    
    ADC.w #Pool_Zol_DrawMultiple_oam_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite3_DrawMultiple
}

; =============================================================================
