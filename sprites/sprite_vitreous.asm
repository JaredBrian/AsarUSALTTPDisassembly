; ==============================================================================

; VITREOUS' CODE
; $0EE4C8-$0EE4EA JUMP LOCATION
Sprite_Vitreous:
{
    LDA.w $0F10, X : BEQ .not_blastin_with_lightning
        ; Just hanging out in green slime, right?
        LDA.b #$03 : STA.w $0DC0, X
    
    .not_blastin_with_lightning
    
    JSR.w Vitreous_Draw
    JSR.w Sprite4_CheckIfActive
    JSR.w Vitreous_SelectVitreolusToActivate
    JSR.w Sprite4_CheckDamage
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw Vitreous_Dormant       ; 0x00 - $E4EB
    dw Vitreous_SpewLightning ; 0x01 - $E549
    dw Vitreous_PursuePlayer  ; 0x02 - $E58B
}

; ==============================================================================

; $0EE4EB-$0EE53C JUMP LOCATION
Vitreous_Dormant:
{
    STZ.w $0FF8
    
    STZ.w $0EA0, X
    
    ; Impervious to everything in this state.
    LDA.w $0E60, X : ORA.b #$40 : STA.w $0E60, X
    
    LDA.b $1A : AND.b #$01 : BNE .dont_prep_lightning
        DEC.w $0D90, X : BNE .dont_prep_lightning
            LDA.w $0E60, X : AND.b #$BF : STA.w $0E60, X
            
            LDA.b #$10 : STA.w $0F10, X
            
            INC.w $0D80, X
            
            LDA.b #$80 : STA.w $0DF0, X
            
            LDA.w $0ED0, X : BNE .dont_dislodge
                INC.w $0D80, X
                
                LDA.b #$40 : STA.w $0DF0, X
                
                STZ.w $0BA0, X
                
                LDA.b #$35 : STA.w $012E
                
                RTS
                
            .dont_dislodge
    .dont_prep_lightning
    
    LDY.b #$04
    
    LDA.b $1A : AND.b #$30 : BNE .pulsate_in_slime
        INY
    
    .pulsate_in_slime
    
    TYA : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EE53D-$0EE548 DATA
Vitreous_Animate_step:
{
    db 2, 1
}

; $0EE53F-$0EE54A DATA
Vitreous_Lightningening:
{
    db 32, 32, 32, 64, 96, 128, 160, 192, 224, 0
}

; $0EE549-$0EE562 JUMP LOCATION
Vitreous_SpewLightning:
{
    STZ.w $0EA0, X
    
    LDA.w $0DF0, X : BNE Vitreous_Animate
        LDA.b #$10 : STA.w $0F10, X
        
        STZ.w $0D80, X
        
        ; Indexed off of how many homies we have left. Less means lightning
        ; more frequently.
        LDY.w $0ED0, X
        
        LDA Vitreous_Lightningening, Y : STA.w $0D90, X

    RTS
}
    
; $0EE563-$0EE588 JUMP LOCATION
Vitreous_Animate:
{
    CMP.b #$40 : BEQ .do_lightning
    CMP.b #$41 : BEQ .do_lightning
        CMP.b #$42 : BNE .dont_lightning
    
    .do_lightning
    
    JSL.l Sprite_SpawnLightning
    
    .dont_lightning
    
    STZ.w $0DC0, X
    
    JSR.w Sprite4_IsToRightOfPlayer
    
    LDA.b $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCC .set_animation_state
        LDA Vitreous_Animate_step, Y : STA.w $0DC0, X
    
    .set_animation_state
    
    RTS
}

; ==============================================================================

; $0EE589-$0EE58A DATA
Vitreous_PursuePlayer_x_shake_speeds:
{
    db 8, -8
}

; $0EE58B-$0EE5C9 JUMP LOCATION
Vitreous_PursuePlayer:
{
    ; WTF: This is nonsensical in that I don't know why it jumps to this
    ; spot unless.... they intended Vitreous to shoot lightning even when
    ; hopping around. TODO: Low priority, but some time try inserting code
    ; to see if we can make him shoot lightning in this state.
    JSR.w Vitreous_Animate
    JSR.w Sprite4_CheckIfRecoiling
    
    LDA.w $0DF0, X : BEQ .bouncing_around
        ; Shake a bit before coming out to face the player.
        AND.b #$02 : LSR A : TAY
        
        LDA.w .x_shake_speeds, Y : STA.w $0D50, X
        
        JSR.w Sprite4_MoveHoriz
        
        RTS
    
    .bouncing_around
    
    JSR.w Sprite4_MoveXyz
    JSR.w Sprite4_CheckTileCollision
    
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        
        LDA.b #$20 : STA.w $0F80, X
        
        LDA.b #$10
        
        JSL.l Sprite_ApplySpeedTowardsPlayerLong
        
        LDA.b #$21 : JSL.l Sound_SetSfx2PanLong
    
    .aloft
    
    RTS
}

; ==============================================================================

; $0EE5CA-$0EE5DA DATA
Vitreous_EyeballRoster:
{
    db $05, $06, $07, $08, $09, $0A, $0B, $0C
    db $0D, $05, $06, $07, $08, $09, $0A, $0B
}

; $0EE5DA-$0EE601 LOCAL JUMP LOCATION
Vitreous_SelectVitreolusToActivate:
{
    INC.w $0E80, X : LDA.w $0E80, X : AND.b #$3F : BNE .delay
        JSL.l GetRandomInt : AND.b #$0F : TAY
        
        LDA.w Vitreous_EyeballRoster, Y : TAY
        LDA.w $0D80, Y : BNE .already_activated
            INC A : STA.w $0D80, Y
            
            LDA.b #$15 : STA.w $012E
    
    .delay
    
    RTS
    
    .already_activated
    
    ; Decrease this counter by one so we can try again on the next frame.
    DEC.w $0E80, X
    
    RTS
}

; ==============================================================================

; $0EE602-$0EE611 DATA
Pool_Sprite_SpawnLightning:
{
    ; $0EE602
    .x_offsets_low
    db -8,  8,  8, -8,  8, -8, -8,  8
    
    ; $0EE60A
    .x_offsets_high
    db -1,  0,  0, -1,  0, -1, -1,  0
}

; $0EE612-$0EE655 LONG JUMP LOCATION
Sprite_SpawnLightning:
{
    PHB : PHK : PLB
    
    LDA.b #$BF : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$26 : STA.w $012F
        
        JSL.l Sprite_SetSpawnedCoords
        
        JSL.l GetRandomInt : AND.b #$07 : STA.w $0D90, Y
        
        PHX
        
        TAX
        
        LDA.b $00 : CLC : ADC Pool_Sprite_SpawnLightning_x_offsets_low,  X
        STA.w $0D10, Y

        LDA.b $01 :       ADC Pool_Sprite_SpawnLightning_x_offsets_high, X
        STA.w $0D30, Y
        
        LDA.b $02 : ADC.b #$0C : STA.w $0D00, Y
        
        PLX
        
        LDA.b #$02 : STA.w $0DF0, Y
        
        LDA.b #$20 : STA.w $0FF9
    
    .spawn_failed
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EE656-$0EE715 DATA
Vitreous_Draw_oam_groups:
{
    dw  -8,  -8 : db $C0, $01, $00, $02
    dw   8,  -8 : db $C0, $41, $00, $02
    dw  -8,   8 : db $E0, $01, $00, $02
    dw   8,   8 : db $E0, $41, $00, $02

    dw  -8,  -8 : db $C8, $01, $00, $02
    dw   8,  -8 : db $CA, $01, $00, $02
    dw  -8,   8 : db $E8, $01, $00, $02
    dw   8,   8 : db $EA, $01, $00, $02

    dw  -8,  -8 : db $CA, $41, $00, $02
    dw   8,  -8 : db $C8, $41, $00, $02
    dw  -8,   8 : db $EA, $41, $00, $02
    dw   8,   8 : db $E8, $41, $00, $02

    dw  -8,  -8 : db $C2, $01, $00, $02
    dw   8,  -8 : db $C2, $41, $00, $02
    dw  -8,   8 : db $E2, $01, $00, $02
    dw   8,   8 : db $E2, $41, $00, $02

    dw  -8,  -8 : db $C4, $01, $00, $02
    dw   8,  -8 : db $C4, $41, $00, $02
    dw  -8,   8 : db $E4, $01, $00, $02
    dw   8,   8 : db $E4, $41, $00, $02

    dw  -7,  -7 : db $C4, $01, $00, $02
    dw   7,  -7 : db $C4, $41, $00, $02
    dw  -7,   7 : db $E4, $01, $00, $02
    dw   7,   7 : db $E4, $41, $00, $02
}

; $0EE716-$0EE762 LOCAL JUMP LOCATION
Vitreous_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : REP #$20 : ASL #5 : ADC.w #.oam_groups : STA.b $08
    
    LDA.w $0D80, X : AND.w #$00FF : CMP.w #2 : BNE .use_standard_oam_region
        LDA.w $0DD0, X : AND.w #$00FF : CMP.w #9 : BNE .use_standard_oam_region
            ; This is a high priority oam region (start of oam is like that!).
            LDA.w #$0800 : STA.b $90
            
            LDA.w #$0A20 : STA.b $92
    
    .use_standard_oam_region
    
    SEP #$20
    
    LDA.b #$04 : JSR.w Sprite4_DrawMultiple
    
    LDA.w $0D80, X : CMP.b #$02 : BNE .not_bouncing
        ; If vitreous is out and bouncing around, use a different palette.
        LDA.w $0B89, X : AND.b #$F1 : STA.w $0B89, X
        
        JSL.l Sprite_DrawVariableSizedShadow
        
    .not_bouncing
    
    RTS
}

; ==============================================================================
