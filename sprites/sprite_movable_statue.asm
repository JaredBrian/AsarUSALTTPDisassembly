; ==============================================================================

; $0340DA-$0340E7 DATA
Pool_Sprite_MovableStatue:
{
    ; $0340DA
    .directions
    db 4, 6, 0, 2
    
    ; $0340DE
    .button_masks
    db 1, 2, 4, 8
    
    ; $0340E2
    .x_speeds ; Bleeds into the next block. Length 4.
    db -16,  16
    
    ; $0340E4
    .y_speeds
    db   0,   0, -16,  16
}

; Movable Statue
; $0340E8-$034149 JUMP LOCATION
Sprite_MovableStatue:
{
    LDA.w $0DE0, X : BEQ .BRANCH_ALPHA
        STZ.w $0DE0, X
        
        STZ.b $5E
        
        STZ.b $48
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BEQ .BRANCH_BETA
        LDA.b #$01 : STA.w $0DE0, X
        
        LDA.b #$81 : STA.b $48
        
        LDA.b #$08 : STA.b $5E
        
    .BRANCH_BETA
    
    JSR.w MovableStatue_Draw
    JSR.w Sprite_CheckIfActive
    JSR.w Statue_BlockSprites
    
    STZ.w $0642
    
    JSR.w MovableStatue_CheckFullSwitchCovering : BCC .BRANCH_GAMMA
        LDA.b #$01 : STA.w $0642
    
    .BRANCH_GAMMA
    
    JSR.w Sprite_Move
    JSR.w Sprite_Get_16_bit_Coords
    JSR.w Sprite_CheckTileCollision
    JSR.w Sprite_Zero_XY_Velocity
    
    JSR.w Sprite_CheckDamageToPlayer_same_layer : BCC Statue_NotInContact
        LDA.b #$07 : STA.w $0DF0, X
        
        JSL.l Sprite_RepelDashAttackLong
        
        LDA.w $0E00, X : BNE Statue_CancelHookshot
            JSR.w Sprite_DirectionToFacePlayer
            
            LDA.w Pool_Sprite_MovableStatue_x_speeds, Y : STA.w $0D50, X
            LDA.w Pool_Sprite_MovableStatue_y_speeds, Y : STA.w $0D40, X

            ; Bleeds into the next function.
}
            
; $03414A-$03416C JUMP LOCATION
Statue_HandleGrab:
{     
    LDA.w $0376 : AND.b #$02 : BNE .BRANCH_ZETA   
        JSL.l Sprite_NullifyHookshotDrag
            
    .BRANCH_ZETA
            
    LDA.w $0E70, X : AND.b #$0F : BNE .BRANCH_THETA
        LDA.w $0F10, X : BNE .BRANCH_THETA
            LDA.b #$22
            JSL.l Sound_SetSfx2PanLong
                    
            LDA.b #$08 : STA.w $0F10, X
            
    .BRANCH_THETA
            
    RTS
}
            
; $03416D-$034171 LOCAL JUMP LOCATION
Statue_CancelHookshot:
{
    JSL.l Sprite_NullifyHookshotDrag
        
    RTS
}
        
; $034172-$0341F6 JUMP LOCATION
Statue_NotInContact:
{
    LDA.w $0DF0, X : BNE .BRANCH_IOTA
        LDA.b #$0D : STA.w $0E00, X
    
    .BRANCH_IOTA
    
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $22 : CLC : ADC.w #$0010
    CMP.w #$0023 : BCS .BRANCH_KAPPA
        LDA.w $0FDA : SEC : SBC.b $20 : CLC : ADC.w #$000C
        CMP.w #$0024 : BCS .BRANCH_KAPPA
            SEP #$30
            
            JSR.w Sprite_DirectionToFacePlayer
            
            LDA.b $2F : CMP .directions, Y : BNE .BRANCH_KAPPA
                LDA.w $0372 : BNE .BRANCH_KAPPA
                    ; Seems to be the key to action 6...
                    LDA.b #$01 : STA.w $02FA
                    
                    LDA.b #$01 : STA.w $0D90, X
                    
                    LDA.w $0376 : AND.b #$02 : BEQ .BRANCH_LAMBDA
                        LDA.b $F0 : AND .button_masks, Y : BEQ .BRANCH_LAMBDA 
                            LDA.b $30 : ORA.b $31 : BEQ .BRANCH_LAMBDA
                                TYA : EOR.b #$01 : TAY
                                LDA.w .x_speeds, Y : STA.w $0D50, X
                                LDA.w .y_speeds, Y : STA.w $0D40, X
                                
                                JMP.w Statue_HandleGrab
    
    .BRANCH_KAPPA
    
    SEP #$30
    
    LDA.w $0D90, X : BEQ .BRANCH_LAMBDA
        STZ.w $0D90, X
        STZ.b $5E
        STZ.w $0376
        STZ.w $02FA
        
        LDA.b $50 : AND.b #$FE : STA.b $50
        
    .BRANCH_LAMBDA
    
    RTS
}

; ==============================================================================

; $0341F7-$034202 DATA
Pool_MovableStatue_CheckFullSwitchCovering:
{
    ; $0341F7
    .y_offsets
    db 3, 12,  3, 12
    
    ; $0341FB
    .x_offsets
    db 3,  3, 12, 12

    ; $0341FF
    .special_tiles
    db $23, $24, $25, $3B
}

; $034203-$03424B LOCAL JUMP LOCATION
MovableStatue_CheckFullSwitchCovering:
{
    LDY.b #$03
    
    .next_tile
    
        LDA.w $0D00, X
        CLC : ADC.w Pool_MovableStatue_CheckFullSwitchCovering_x_offsets, Y
        STA.b $00

        LDA.w $0D20, X : ADC.b #$00 : STA.b $01
        
        LDA.w $0D10, X
        CLC : ADC.w Pool_MovableStatue_CheckFullSwitchCovering_y_offsets, Y
        STA.b $02

        LDA.w $0D30, X : ADC.b #$00 : STA.b $03
        
        LDA.w $0F20, X
        
        PHY
        
        JSL.l Entity_GetTileAttr
        
        PLY
        
        LDA.w $0FA5
        CMP.w Pool_MovableStatue_CheckFullSwitchCovering_special_tiles+0 : BEQ .partial_switch_covering
        CMP.w Pool_MovableStatue_CheckFullSwitchCovering_special_tiles+1 : BEQ .partial_switch_covering
        CMP.w Pool_MovableStatue_CheckFullSwitchCovering_special_tiles+2 : BEQ .partial_switch_covering
            CMP.w Pool_MovableStatue_CheckFullSwitchCovering_special_tiles+3 : BNE .failure
        
        .partial_switch_covering
    DEY : BPL .next_tile
    
    SEC
    
    RTS
    
    .failure
    
    CLC
    
    RTS
}

; ==============================================================================

; $03424C-$034263 DATA
MovableStatue_Draw_OAM_groups:
{
    dw 0, -8 : db $C2, $00, $00, $00
    dw 8, -8 : db $C2, $40, $00, $00
    dw 0,  0 : db $C0, $00, $00, $02
}

; $034264-$034276 LOCAL JUMP LOCATION
MovableStatue_Draw:
{
    REP #$20
    
    LDA.w #.OAM_groups : STA.b $08
    
    LDA.w #$0003 : STA.b $06
    
    SEP #$30
    
    JSL.l Sprite_DrawMultiple_player_deferred
    
    RTS
}

; ==============================================================================

; $034277-$0342E4 LOCAL JUMP LOCATION
Statue_BlockSprites:
{
    LDY.b #$0F
    
    .BRANCH_BETA
    
        LDA.w $0E20, Y : CMP.b #$1C : BEQ .BRANCH_ALPHA
            CPY.w $0FA0 : BEQ .BRANCH_ALPHA
                TYA : EOR.b $1A : AND.b #$01 : BNE .BRANCH_ALPHA
                    LDA.w $0DD0, Y : CMP.b #$09 : BCC .BRANCH_ALPHA
                        LDA.w $0D10, Y : STA.b $04
                        LDA.w $0D30, Y : STA.b $05
                        
                        LDA.w $0D00, Y : STA.b $06
                        LDA.w $0D20, Y : STA.b $07
                        
                        REP #$20
                        
                        LDA.w $0FD8 : SEC : SBC.b $04 : CLC : ADC.w #$000C
                        CMP.w #$0018 : BCS .BRANCH_ALPHA
                            LDA.w $0FDA : SEC : SBC.b $06 : CLC : ADC.w #$000C
                            CMP.w #$0024 : BCS .BRANCH_ALPHA
                                SEP #$20
                                
                                LDA.b #$04 : STA.w $0EA0, Y
                                
                                PHY
                                
                                LDA.b #$20
                                JSR.w Sprite_ProjectSpeedTowardsEntity
                                
                                PLY
                                
                                LDA.b $00 : STA.w $0F30, Y
                                LDA.b $01 : STA.w $0F40, Y
                
        .BRANCH_ALPHA
        
        SEP #$20
    
    DEY : BPL .BRANCH_BETA
    
    RTS
}

; ==============================================================================
