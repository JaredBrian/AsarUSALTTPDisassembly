; ==============================================================================

; $0F297F-$0F2981 DATA
Sprite_Bumper_player_recoil_speeds:
{
    db $00, $02, $FE
}

; $0F2982-$0F2A4A JUMP LOCATION
Sprite_Bumper:
{
    JSR.w Bumper_Draw
    JSR.w Sprite3_CheckIfActive
    JSR.w Sprite3_CheckTileCollision
    
    LDA.b $55 : BNE .using_magic_cape
        JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .no_player_collision
            JSL.l Player_HaltDashAttackLong
            
            LDA.b #$20 : STA.w $0DF0, X
            
            LDA.b #$30 : JSL.l Sprite_ProjectSpeedTowardsPlayerLong
            
            LDA.b $F0 : LSR #2 : AND.b #$03 : TAY
            LDA.b $00 : CLC : ADC .player_recoil_speeds, Y : STA.b $27
            
            LDA.b $F0 : AND.b #$03 : TAY
            LDA.b $01 : CLC : ADC .player_recoil_speeds, Y : STA.b $28
            
            LDA.b #$14 : STA.b $46
            
            PHX
            
            JSL.l Player_ResetSwimState
            
            PLX
            
            LDA.b #$32 : JSL.l Sound_SetSfx3PanLong
            
        .no_player_collision
    .using_magic_cape
    
    LDY.b #$0F
    
    .next_sprite
    
        TYA : EOR.b $1A : AND.b #$03 : ORA.w $0F70, Y : BNE .no_sprite_collision
            LDA.w $0DD0, Y : CMP.b #$09 : BCC .no_sprite_collision
                LDA.w $0E60, Y : ORA.w $0F60, Y : AND.b #$40 : BNE .no_sprite_collision
                    LDA.w $0D10, Y : STA.b $04
                    LDA.w $0D30, Y : STA.b $05
                    LDA.w $0D00, Y : STA.b $06
                    LDA.w $0D20, Y : STA.b $07
                    
                    REP #$20
                    
                    LDA.w $0FD8 : SEC : SBC.b $04 : CLC : ADC.w #$0010
                    CMP.w #$0020 : BCS .no_sprite_collision
                        LDA.w $0FDA : SEC : SBC.b $06 : CLC : ADC.w #$0010
                        CMP.w #$0020 : BCS .no_sprite_collision
                            SEP #$20
                            
                            LDA.b #$0F : STA.w $0EA0, Y
                            
                            PHY
                            
                            LDA.b #$40
                            
                            JSL.l Sprite_ProjectSpeedTowardsEntityLong
                            
                            PLY
                            
                            LDA.b $00 : STA.w $0F30, Y
                            LDA.b $01 : STA.w $0F40, Y
                            
                            LDA #$20 : STA.w $0DF0, X
                            
                            LDA.b #$32 : JSL.l Sound_SetSfx3PanLong
        
        .no_sprite_collision
        
        SEP #$20
    DEY : BPL .next_sprite
    
    RTS
}

; ==============================================================================

; $0F2A4B-$0F2A8A DATA
Bumper_Draw_OAM_groups:
{
    dw -8, -8 : db $EC, $00, $00, $02
    dw  8, -8 : db $EC, $40, $00, $02
    dw -8,  8 : db $EC, $80, $00, $02
    dw  8,  8 : db $EC, $C0, $00, $02
    
    dw -7, -7 : db $EC, $00, $00, $02
    dw  7, -7 : db $EC, $40, $00, $02
    dw -7,  7 : db $EC, $80, $00, $02
    dw  7,  7 : db $EC, $C0, $00, $02
}

; $0F2A8B-$0F2AA6 LOCAL JUMP LOCATION
Bumper_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0DF0, X : LSR A : AND.b #$01 : REP #$20 : ASL #5
    
    ADC.w #(.OAM_groups) : STA.b $08
    
    SEP #$20
    
    LDA.b #$04 : JMP Sprite3_DrawMultiple
}

; ==============================================================================
