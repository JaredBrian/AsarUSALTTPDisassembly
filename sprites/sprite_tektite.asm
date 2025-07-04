; ==============================================================================

; $0EC26D-$0EC274 DATA
Pool_Tektite_Stationary:
{
    ; $0EC26D
    .x_speeds
    db  16, -16,  16, -16
    
    ; $0EC271
    .y_speeds
    db  16,  16, -16, -16
}

; ==============================================================================

; Tektite / Ganon's firebats and pitchfork code
; $0EC275-$0EC292 LOCAL JUMP LOCATION
Sprite_GanonHelpers:
{
    LDA.w $0EC0, X : BEQ Sprite_Tektite
        STA.w $0BA0, X : PHA
        
        LDA.b #$30 : STA.w $0B89, X
        
        PLA : DEC A
        
        JSL.l UseImplicitRegIndexedLocalJumpTable
        
        dw Sprite_PhantomGanon  ; 0x00 - $88BC Ganon bat atop Ganon's Tower
        dw Sprite_Trident       ; 0x01 - $8AB6 Trident
        dw Sprite_SpiralFireBat ; 0x02 - $8B52 Special spiraling firebat
        dw Sprite_FireBat       ; 0x03 - $8BD7 Normal firebat
        dw Sprite_FlameTrailBat ; 0x04 - $8B49 Special flametrail firebat
}

; ==============================================================================

; Code for Tektites
; $0EC293-$0EC2CD BRANCH LOCATION
Sprite_Tektite:
{
    LDA.w $0E00, X : BEQ .anoforce_default_animation_state
        STZ.w $0DC0, X
    
    .anoforce_default_animation_state
    
    JSR.w Tektite_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_CheckIfRecoiling
    JSR.w Sprite4_CheckDamage
    JSR.w Sprite4_MoveXyz
    JSR.w Sprite4_BounceFromTileCollision
    
    ; Simulates gravity for the sprite.
    LDA.w $0F80, X : SEC : SBC.b #$01 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        STZ.w $0F80, X
    
    .aloft
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Tektite_Stationary   ; 0x00 - $C2D2
    dw Tektite_Aloft        ; 0x01 - $C388
    dw Tektite_RepeatingHop ; 0x02 - $C3A8
}

; ==============================================================================

; $0EC2CE-$0EC2D1 DATA
Tektite_Stationary_comparison_directions:
{
    db 3, 2, 1, 0
}

; $0EC2D2-$0EC387 LOCAL JUMP LOCATION
Tektite_Stationary:
{
    JSR.w Sprite4_DirectionToFacePlayer
    
    LDA.b $0E : CLC : ADC.b #$28 : CMP.b #$50 : BCS .dont_dodge
        LDA.b $0F : CLC : ADC.b #$28 : CMP.b #$50 : BCS .dont_dodge
            ; Is this checking for a sword attack? Maybe.
            LDA.b $44 : CMP.b #$80 : BEQ .dont_dodge
                LDA.w $0F70, X : ORA.w $0F00, X : BNE .dont_dodge
                    LDA.b $EE : CMP.w $0F20, X : BNE .dont_dodge
                        STY.b $00
                        
                        LDA.b $2F : LSR : TAY
                        
                        ; WTF: Weird directions to check against? Either a bug
                        ; or intentionally quirky logic.
                        LDA.b $00 : CMP .comparison_directions, Y : BEQ .dont_dodge
                            LDA.b #$20
                            JSL.l Sprite_ProjectSpeedTowardsPlayerLong
                            
                            LDA.b $01 : EOR.b #$FF : INC : STA.w $0D50, X
                            
                            LDA.b $00 : EOR.b #$FF : INC : STA.w $0D40, X
                            
                            LDA.b #$10 : STA.w $0F80, X
                            
                            INC.w $0D80, X
                            
                            RTS
        
    .dont_dodge
    
    LDA.w $0DF0, X : BNE .just_animate
        INC.w $0D80, X
        
        INC.w $0DA0, X
        
        LDA.w $0DA0, X : CMP.b #$04 : BNE .select_random_direction
            ; Otherwise select a direction towards the player.
            STZ.w $0DA0, X
            
            INC.w $0D80, X
            
            JSL.l GetRandomInt : AND.b #$3F : ADC.b #$30 : STA.w $0DF0, X
            
            LDA.b #$0C : STA.w $0F80, X
            
            JSR.w Sprite4_IsBelowPlayer
            
            TYA : ASL : STA.b $00
            
            JSR.w Sprite4_IsToRightOfPlayer
            
            TYA : ORA.b $00
            
            BRA .set_xy_speeds
        
        .select_random_direction
        
        JSL.l GetRandomInt : AND.b #$07 : ADC.b #$18 : STA.w $0F80, X
        
        JSL.l GetRandomInt : AND.b #$03
        
        .set_xy_speeds
        
        TAY
        
        LDA.w Pool_Tektite_Stationary_x_speeds, Y : STA.w $0D50, X
        
        LDA.w Pool_Tektite_Stationary_y_speeds, Y : STA.w $0D40, X
        
        RTS
    
    .just_animate
    
    LSR #4 : AND.b #$01 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EC388-$0EC38C JUMP LOCATION
Tektite_Aloft:
{
    LDA.w $0F70, X : BNE .airborne
        ; Bleeds into the next function.
}

; $0EC38D-$0EC39A JUMP LOCATION
Tektite_RevertToStationary:
{
    STZ.w $0D80, X
    
    JSL.l GetRandomInt : AND.b #$3F : ADC.b #$48 : STA.w $0DF0, X

    ; Bleeds into the next function.
}

; $0EC39B-$0EC3A1 JUMP LOCATION
Sprite4_Zero_XY_Velocity:
{
    STZ.w $0D40, X
    STZ.w $0D50, X
    
    RTS
}

; $0EC3A2-$0EC3A7 JUMP LOCATION
Tektite_Aloft_airborne:
{
    LDA.b #$02 : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EC3A8-$0EC3C4 JUMP LOCATION
Tektite_RepeatingHop:
{
    LDA.w $0DF0, X : BEQ Tektite_RevertToStationary
        LDA.w $0F70, X : BNE .aloft
            LDA.b #$0C : STA.w $0F80, X
            
            INC.w $0F70, X
            
            LDA.b #$08 : STA.w $0E00, X
            
        .aloft
        
        LDA.b #$02 : STA.w $0DC0, X
        
        RTS
}

; ==============================================================================

; $0EC3C5-$0EC3F4 DATA
Tektite_Draw_OAM_groups:
{
    dw -8,  0 : db $C8, $00, $00, $02
    dw  8,  0 : db $C8, $40, $00, $02
    
    dw -8,  0 : db $CA, $00, $00, $02
    dw  8,  0 : db $CA, $40, $00, $02
}

; $0EC3F5-$0EC411 LOCAL
Tektite_Draw:
{
    LDA.b #$00 : XBA
    LDA.w $0DC0, X : REP #$20 : ASL #4 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JSR.w Sprite4_DrawMultiple
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
