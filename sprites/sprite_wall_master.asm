; ==============================================================================

; Floor master sprite (0x90)
; $0F2EA4-$0F2F2A JUMP LOCATION
Sprite_WallMaster:
{
    LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
    
    JSR.w WallMaster_Draw
    
    LDA.w $0DD0, X : CMP.b #$09 : BEQ .dont_release_player
        STZ.w $02E4
        STZ.w $037B
        
    .dont_release_player
    
    JSR.w Sprite3_CheckIfActive
    
    LDA.w $0D90, X : BEQ .player_not_ensnared
        LDA.w $0D10, X : STA.b $22
        LDA.w $0D30, X : STA.b $23
        
        LDA.w $0D00, X : SEC : SBC.w $0F70, X
        
        PHP
        
        CLC : ADC.b #$03 : STA.b $20
        
        LDA.w $0D20, X : ADC.b #$00
        
        PLP
        
        SBC.b #$00 : STA.b $21
        
        LDA.b #$01 : STA.w $02E4
                     STA.w $037B
        
        STZ.b $46
        STZ.b $28
        STZ.b $27
        STZ.b $30
        STZ.b $31
        
        REP #$20
        
        LDA.b $20 : SEC : SBC.b $E8 : SEC : SBC.w #$0010
        CMP.w #$0100 : SEP #$20 : BCC .delay_sending_player_to_entrance
            STZ.w $02E4
            STZ.w $037B
            
            PHX
            
            JSL.l WallMaster_SendPlayerToLastEntrance
            JSL.l Init_Player
            
            PLX
            
            RTS
        
    .player_not_ensnared
    
    JSL.l Sprite_CheckDamageFromPlayerLong
    
    .delay_sending_player_to_entrance
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw WallMaster_Descend     ; 0x00 - $AF2B
    dw WallMaster_GrabAttempt ; 0x01 - $AF59
    dw Wallmaster_Ascend      ; 0x02 - $AF82
}

; ==============================================================================

; $0F2F2B-$0F2F58 JUMP LOCATION
WallMaster_Descend:
{
    LDA.w $0F70, X : PHA
    
    JSR.w Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$C0 : BMI .descend_speed_maxed
        SEC : SBC.b #$03 : STA.w $0F80, X
    
    .descend_speed_maxed
    
    PLA : EOR.w $0F70, X : BPL .no_z_coord_sign_change
        LDA.w $0F70, X : BPL .aloft
            INC.w $0D80, X
            
            STZ.w $0F70, X
            STZ.w $0F80, X
            
            LDA.b #$3F : STA.w $0DF0, X
            
        .aloft
    .no_z_coord_sign_change
    
    RTS
}

; ==============================================================================

; $0F2F59-$0F2F81 JUMP LOCATION
WallMaster_GrabAttempt:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
    
    .delay
    
    LDY.b #$00
    
    AND.b #$20 : BNE .use_first_animation_state
        INY
    
    .use_first_animation_state
    
    TYA : STA.w $0DC0, X
    
    JSR.w Sprite3_CheckDamageToPlayer : BCC .didnt_grab_player
        LDA.b #$01 : STA.w $0D90, X
        
        ; Sprite is invincible.
        LDA.b #$40 : STA.w $0E60, X
        
        LDA.b #$2A
        JSL.l Sound_SetSFX3PanLong
        
    .didnt_grab_player
    
    RTS
}

; ==============================================================================

; $0F2F82-$0F2FA3 JUMP LOCATION
Wallmaster_Ascend:
{
    LDA.w $0F70, X : PHA
    
    JSR.w Sprite3_MoveAltitude
    
    LDA.w $0F80, X : CMP.b #$40 : BPL .ascend_speed_maxed
        INC : INC : STA.w $0F80, X
    
    .ascend_speed_maxed
    
    PLA : EOR.w $0F70, X : BPL .no_z_coord_sign_change
        LDA.w $0F70, X : BMI .hasnt_left_ground_yet
            STZ.w $0DD0, X
        
        .hasnt_left_ground_yet
    .no_z_coord_sign_change
    
    RTS
}

; ==============================================================================

; $0F2FA4-$0F2FE3 DATA
WallMaster_Draw_OAM_groups:
{
    dw  -4,   0 : db $A6, $01, $00, $02
    dw  12,   0 : db $AA, $01, $00, $00
    dw  -4,  16 : db $BA, $01, $00, $00
    dw   4,   8 : db $A8, $01, $00, $02

    dw  -4,   0 : db $AB, $01, $00, $02
    dw  12,   0 : db $AF, $01, $00, $00
    dw  -4,  16 : db $BF, $01, $00, $00
    dw   4,   8 : db $AD, $01, $00, $02
}

; ==============================================================================

; $0F2FE4-$0F3001 LOCAL JUMP LOCATION
WallMaster_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X
    
    REP #$20
    ASL #5 : ADC.w #$AFA4 : STA.b $08
    SEP #$20
    
    LDA.b #$04
    JSR.w Sprite3_DrawMultiple
    
    JSL.l Sprite_DrawVariableSizedShadow
    
    RTS
}

; ==============================================================================
