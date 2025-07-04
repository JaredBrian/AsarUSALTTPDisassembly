; ==============================================================================

; Lynel sprite code (Those Centaur looking things on DW Death Mountain).
; $0E866A-$0E8689 JUMP LOCATION
Sprite_Lynel:
{
    JSR.w Lynel_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckIfRecoiling
    
    JSR.w Sprite4_DirectionToFacePlayer : TYA : STA.w $0DE0, X
    
    JSR.w Sprite4_CheckDamage
    
    LDA.w $0D80, X
    
    JSL.l UseImplicitRegIndexedLocalJumpTable
    
    dw Lynel_TargetPlayer   ; 0x00 - $868A
    dw Lynel_ApproachPlayer ; 0x01 - $86D5
    dw Lynel_Attack         ; 0x02 - $8740
}

; ==============================================================================

; $0E868A-$0E8697 DATA
Pool_Lynel_TargetPlayer:
{
    ; WTF: These are out of the usual order... smart compiler or clever grunt?
    ; $0E868A
    .x_offsets_low ; Bleeds into the next block. Length 4.
    db -96, 96
    
    ; $0E868C
    .y_offsets_high
    db   0,  0, - 1,   0
    
    ; $0E8690
    .x_offsets_high
    db  -1,  0,   0,   0
    
    ; $0E8694
    .y_offsets_low
    db   8,  8, -96, 112
}

; ==============================================================================

; $0E8698-$0E86CC JUMP LOCATION
Lynel_TargetPlayer:
{
    LDA.w $0DF0, X : BNE .delay
        LDY.w $0DE0, X
        
        LDA.w Pool_Lynel_TargetPlayer_x_offsets_low,  Y
        CLC : ADC.b $22 : STA.w $0D90, X

        LDA.w Pool_Lynel_TargetPlayer_x_offsets_high, Y
              ADC.b $23 : STA.w $0DA0, X
        
        LDA.w Pool_Lynel_TargetPlayer_y_offsets_low,  Y
        CLC : ADC.b $20 : STA.w $0DB0, X

        LDA.w Pool_Lynel_TargetPlayer_y_offsets_high, Y
              ADC.b $21 : STA.w $0E90, X
        
        INC.w $0D80, X
        
        LDA.b #$50 : STA.w $0DF0, X
    
    .delay
    
    JMP Lynel_AnimationController
}

; ==============================================================================

; $0E86CD-$0E86D4 DATA
Lynel_AnimationController_animation_states:
{
    db 3, 0, 6, 9, 4, 1, 7, 10
}

; $0E86D5-$0E872B JUMP LOCATION
Lynel_ApproachPlayer:
{
    LDA.w $0DF0, X : BEQ .prepare_attack
        TXA : EOR.b $1A : AND.b #$03 : BNE .anoadjust_direction
            JSR.w Sprite4_Load_16bit_AuxCoord
            
            REP #$20
            
            LDA.b $04 : SEC : SBC.w $0FD8 : CLC : ADC.w #$0005 : CMP.w #$000A : BCS .not_in_range
                LDA.b $06 : SEC : SBC.w $0FDA : CLC : ADC.w #$0005 : CMP.w #$000A : BCS .not_in_range
        
    .prepare_attack
    
    SEP #$20
    
    INC.w $0D80, X
    
    LDA.b #$20 : STA.w $0DF0, X
    
    RTS
    
    .not_in_range
    
    SEP #$20
    
    LDA.b #$18
    
    JSL.l Sprite_ProjectSpeedTowardsEntityLong
    
    LDA.b $00 : STA.w $0D40, X
    
    LDA.b $01 : STA.w $0D50, X
    
    .anoadjust_direction
    
    JSR.w Sprite4_Move
    
    JSR.w Sprite4_CheckTileCollision : BNE .prepare_attack
        INC.w $0E80, X

        ; Bleeds into the next function.
}
        
; $0E872C-$0E873B JUMP LOCATION
Lynel_AnimationController:
{
    LDA.w $0E80, X : AND.b #$04 : ORA.w $0DE0, X : TAY
        
    LDA.w .animation_states, Y : STA.w $0DC0, X
        
    RTS
}

; ==============================================================================

; $0E873C-$0E873F DATA
Lynel_Attack_animation_states:
{
    db $05, $02, $08, $0A
}

; $0E8740-$0E8777 JUMP LOCATION
Lynel_Attack:
{
    LDA.w $0DF0, X : BNE .delay
        JSL.l GetRandomInt : AND.b #$0F : ADC.b #$10 : STA.w $0DF0, X
        
        STZ.w $0D80, X
        
        RTS
        
    .delay
    
    CMP.b #$10 : BNE .anospawn_projectile
        JSL.l Sprite_SpawnFirePhlegm : BMI .spawn_failed
            LDA.l $7EF35A : CMP.b #$03 : BEQ .blockable_projectile
                LDA.b #$00 : STA.w $0BE0, Y
            
            .blockable_projectile
        .spawn_failed
    .anospawn_projectile
    
    LDY.w $0DE0, X
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    JSR.w Sprite4_CheckTileCollision
    
    RTS
}

; ==============================================================================

; $0E8778-$0E887F DATA
Lynel_Draw_OAM_groups:
{
    dw -5,  -5 : db $CC, $00, $00, $02
    dw -4,   0 : db $E4, $00, $00, $02
    dw  4,   0 : db $E5, $00, $00, $02
    
    dw -5, -10 : db $CC, $00, $00, $02
    dw -4,   0 : db $E7, $00, $00, $02
    dw  4,   0 : db $E8, $00, $00, $02
    
    dw -5, -11 : db $C8, $00, $00, $02
    dw -4,   0 : db $E4, $00, $00, $02
    dw  4,   0 : db $E5, $00, $00, $02
    
    dw  5, -11 : db $CC, $40, $00, $02
    dw -4,   0 : db $E5, $40, $00, $02
    dw  4,   0 : db $E4, $40, $00, $02
    
    dw  5, -10 : db $CC, $40, $00, $02
    dw -4,   0 : db $E8, $40, $00, $02
    dw  4,   0 : db $E7, $40, $00, $02
    
    dw  5, -11 : db $C8, $40, $00, $02
    dw -4,   0 : db $E8, $40, $00, $02
    dw  4,   0 : db $E7, $40, $00, $02
    
    dw  0,  -9 : db $CE, $00, $00, $02
    dw -4,   0 : db $EA, $00, $00, $02
    dw  4,   0 : db $EB, $00, $00, $02
    
    dw  0,  -9 : db $CE, $00, $00, $02
    dw -4,   0 : db $EB, $40, $00, $02
    dw  4,   0 : db $EA, $40, $00, $02
    
    dw  0,  -9 : db $CA, $00, $00, $02
    dw -4,   0 : db $EB, $00, $00, $02
    dw  4,   0 : db $EB, $40, $00, $02
    
    dw  0, -14 : db $C6, $00, $00, $02
    dw -4,   0 : db $ED, $00, $00, $02
    dw  4,   0 : db $EE, $00, $00, $02
    
    dw  0, -14 : db $C6, $00, $00, $02
    dw -4,   0 : db $EE, $40, $00, $02
    dw  4,   0 : db $ED, $40, $00, $02
}

; ==============================================================================

; $0E8880-$0E88A0 LOCAL JUMP LOCATION
Lynel_Draw:
{
    LDA.b #$00   : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #3 : STA.b $00 : ASL : ADC.b $00
    
    ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$03
    
    JSR.w Sprite4_DrawMultiple
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
