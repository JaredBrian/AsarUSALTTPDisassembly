; ==============================================================================

; $0EDF45-$0EDF48 DATA
Sprite_GreatCatfish_bounce_z_speeds:
{
    db $20, $10, $08, $00
}

; ILL OMEN MONSTER / QUAKE MEDALLION
; $0EDF49-$0EDFD0 JUMP LOCATION
Sprite_GreatCatfish:
{
    LDA.w $0D90, X : BPL .not_water_splash
        JSR.w Sprite_WaterSplash
        
        RTS
        
    .not_water_splash
    
    BEQ GreatCatfish_Main
    
    ; Sprite Standalone Item.
    
    LDA.w $0F70, X : BNE .aloft
        JSL.l Sprite_AutoIncDrawWaterRippleLong
        
        LDA.b $11 : BNE .dont_grant_item
            JSL.l Sprite_CheckDamageToPlayerSameLayerLong : BCC .dont_grant_item
                STZ.w $0DD0, X
                STZ.w $02E9
                
                LDY.w $0D90, X
                
                PHX
                
                JSL.l Link_ReceiveItem
                
                PLX
            
        .dont_grant_item
    .aloft
    
    LDA !timer_3, X : BEQ .dont_use_different_OAM_region
        ; TODO: Identify when this happens.
        LDA.b #$08 : JSL.l OAM_AllocateFromRegionC
    
    .dont_use_different_OAM_region
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite4_CheckIfActive
    JSR.w Sprite4_MoveXyz
    
    ; Simulate gravity for the sprite.
    DEC.w $0F80, X : DEC.w $0F80, X
    
    LDA.w $0F70, X : BPL .not_bouncing
        STZ.w $0F70, X
        
        ; Halve x and y speeds upon bounce.
        LDA.w $0D50, X : ASL : ROR.w $0D50, X
        
        LDA.w $0D40, X : ASL : ROR.w $0D40, X
        
        LDY.w $0D80, X : CPY.b #$04 : BNE .not_final_bounce
            STZ.w $0D50, X
            STZ.w $0D40, X
            STZ.w $0F80, X
            
            BRA .return
        
        .not_final_bounce
        
        INC.w $0D80, X
        
        LDA.w .bounce_z_speeds, Y : STA.w $0F80, X
        
        CPY.b #$02 : BCS .dont_splash_from_bounce
            JSR.w Sprite_SpawnWaterSplash : BMI .spawn_failed
                LDA.b #$10 : STA !timer_0, Y
            
            .spawn_failed
        .dont_splash_from_bounce
    .not_bouncing

    .return
    
    RTS
}
    
; ==============================================================================

; $0EDFD1-$0EDFE5 BRANCH LOCATION
GreatCatfish_Main:
{
    JSR.w GreatCatfish_Draw
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0D80, X
    JSL.l UseImplicitRegIndexedLocalJumpTable
    dw GreatCatfish_AwaitSpriteThrownInCircle ; 0x00 - $DFE6
    dw GreatCatfish_RumbleBeforeEmergence     ; 0x01 - $E039
    dw GreatCatfish_Emerge                    ; 0x02 - $E08C
    dw GreatCatfish_ConversateThenSubmerge    ; 0x03 - $E0D3
}

; ==============================================================================

; $0EDFE6-$0EE038 JUMP LOCATION
GreatCatfish_AwaitSpriteThrownInCircle:
{
    LDY.b #$0F
    
    .drowning_sprite_in_circle_search
    
        CPY.w $0FA0 : BEQ .next_sprite
            LDA.w $0DD0, Y : CMP.b #$03 : BNE .next_sprite
                LDA.w $0D10, Y : STA.b $00
                LDA.w $0D30, Y : STA.b $01
                
                LDA.w $0D00, Y : STA.b $02
                LDA.w $0D20, Y : STA.b $03
                
                REP #$20
                
                ; Check proximity of drowning sprite to the catfish.
                LDA.w $0FD8 : SEC : SBC.b $00 : CLC : ADC.w #$0020 : CMP.w #$0040 : BCS .next_sprite
                    LDA.w $0FDA : SEC : SBC.b $02 : CLC : ADC.w #$0020 : CMP.w #$0040 : BCS .next_sprite
                        SEP #$20
                        
                        ; $0EE02A ALTERNATE ENTRY POINT
                        .AdvanceState
                        
                        INC.w $0D80, X
                        
                        LDA.b #$FF : STA !timer_0, X
                        
                        RTS
                
        .next_sprite
        
        SEP #$20
    DEY : BPL .drowning_sprite_in_circle_search
    
    RTS
}

; ==============================================================================

; $0EE039-$0EE07B JUMP LOCATION
GreatCatfish_RumbleBeforeEmergence:
{
    LDA !timer_0, X : BNE .delay_emergence
        JSR.w GreatCatfish_AwaitSpriteThrownInCircle_AdvanceState
        
        ; Stop shaking the screen.
        STZ.w $011A
        STZ.w $011B
        
        ; Halt the rumbling sound.
        LDA.b #$05 : STA.w $012D
        
        LDA.b #$30 : STA.w $0F80, X
        
        LDA.b #$00 : STA.w $0D50, X
        
        JSR.w GreatCatfish_SpawnImmediatelyDrownedSprite
        
        RTS
    
    .delay_emergence
    
    CMP.b #$C0 : BCS .delay_rumbling
        CMP.b #$BF : BNE .anostart_rumble_ambient
            LDY.b #$07 : STY.w $012D
        
        .anostart_rumble_ambient
        
        AND.b #$01 : TAY
        
        ; Shake the screen.
        LDA.w Pool_Sprite_ApplyConveyorAdjustment_x_shake_values, Y : STA.w $011A
        LDA.w Pool_Sprite_ApplyConveyorAdjustment_y_shake_values, Y : STA.w $011B
        
        LDA.b #$01 : STA.w $02E4
    
    .delay_rumbling
    
    RTS
}

; ==============================================================================

; $0EE07C-$0EE08B DATA
GreatCatfish_Emerge_animation_states:
{
    db 1, 2, 2, 2, 2, 3, 3, 3
    db 4, 4, 4, 5, 0, 0, 0, 0
}

; $0EE08C-$0EE0BE JUMP LOCATION
GreatCatfish_Emerge:
{
    INC.w $0E80, X
    
    JSR.w Sprite4_MoveXyz
    
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    ; Spawn a small splash (drowning sprite, technically) when the catfish's
    ; z velocity becomes this negative.
    CMP.b #$D0 : BNE .anospawn_splash
        JSR.w GreatCatfish_SpawnImmediatelyDrownedSprite
    
    .anospawn_splash
    
    LDA.w $0F70, X : BPL .aloft
        STZ.w $0F70, X
        
        INC.w $0D80, X
        
        LDA.b #$FF : STA !timer_0, X
        
    .aloft
    
    LDA.w $0E80, X : LSR #2 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0EE0BF-$0EE0D2 DATA
GreatCatfish_ConversateThenSubmerge_animation_states:
{
    db 0, 6, 7, 7, 7, 7, 7, 7
    db 7, 7, 7, 7, 7, 7, 7, 7
    db 7, 7, 6, 6
}

; $0EE0D3-$0EE143 JUMP LOCATION
GreatCatfish_ConversateThenSubmerge:
{
    LDA !timer_0, X : BNE .delay_self_termination
        STZ.w $0DD0, X
        
        RTS
    
    .delay_self_termination
    
    CMP.b #$A0 : BNE .dont_spawn_followup_slash
        PHA
        
        JSR.w Sprite_SpawnWaterSplash
        
        PLA
        
    .dont_spawn_followup_slash
    
    BCS GreatCatfish_SpawnSurfacingSplash
        CMP.b #$0A : BNE .dont_spawn_exiting_small_splash
            PHA
            
            JSR.w GreatCatfish_SpawnImmediatelyDrownedSprite
            
            PLA
            
        .dont_spawn_exiting_small_splash
        
        CMP.b #$04 : BNE .dont_spawn_exiting_splash
            PHA
            
            JSR.w Sprite_SpawnWaterSplash
            
            PLA
        
        .dont_spawn_exiting_splash
        
        CMP.b #$60 : BNE .not_conversating
            STZ.w $02E4
            
            LDY.b #$2A
            
            ; \item (Quake medallion)
            LDA.l $7EF349 : BEQ .grant_quake_medallion_mesesage
                ; Show message indicating "don't waste my time, go away, I
                ; already gave you a medallion".
                LDY.b #$2B
                
            .grant_quake_medallion_mesesage
            
                         STY.w $1CF0
            LDA.b #$01 : STA.w $1CF1
            JSL.l Sprite_ShowMessageMinimal
            
            RTS
            
        .not_conversating
        
        CMP.b #$50 : BNE .dont_run_spawning_logic
            PHA
            
            ; \item (Quake medallion)
            LDA.l $7EF349 : BEQ .spawn_quake_medallion
                JSL.l GetRandomInt : AND.b #$01 : BEQ .spawn_fireball
                    JSR.w Sprite_SpawnBomb
                    
                    BRA .spawning_logic_complete
                    
                .spawn_fireball
                
                JSL.l Sprite_SpawnFireball
                
                BRA .spawning_logic_complete

            .spawn_quake_medallion
            
            JSR.w GreatCatfish_SpawnQuakeMedallion
            
            .spawning_logic_complete
            
            PLA
            
        .dont_run_spawning_logic
        
        ; Animate.
        LSR #3 : TAY
        
        LDA.w .animation_states, Y : STA.w $0DC0, X
        
        RTS
}

; ==============================================================================

; $0EE144-$0EE163 LOCAL JUMP LOCATION
Sprite_SpawnBomb:
{
    LDA.b #$4A : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        JSL.l Sprite_TransmuteToEnemyBomb
        
        LDA.b #$50 : STA !timer_1, Y
        
        LDA.b #$18 : STA.w $0D50, Y
        
        LDA.b #$30 : STA.w $0F80, Y

    .spawn_failed

    RTS
}

; ==============================================================================

; $0EE164-$0EE16B BRANCH LOCATION
GreatCatfish_SpawnSurfacingSplash:
{
    CMP.b #$FC : BNE .delay_splash_spawning
        JSR.w Sprite_SpawnWaterSplash
        
    .delay_splash_spawning
    
    RTS
}

; ==============================================================================

; $0EE16C-$0EE1A9 LOCAL JUMP LOCATION
GreatCatfish_SpawnQuakeMedallion:
{
    LDA.b #$C0 : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        PHX : TYX
        
        LDA.b #$18 : STA.w $0D50, X
        
        LDA.b #$30 : STA.w $0F80, X
        
        LDA.b #$11 : STA.w $0D90, X
        
        ; Play a sound effect.
        LDA.b #$20 : JSL.l Sound_SetSfx2PanLong
        
        LDA.b #$83 : STA.w $0E40, X
        
        LDA.b #$58 : STA.w $0E60, X
        
        AND.b #$0F : STA.w $0F50, X
        
        PLX
        
        PHX : PHY
        
        LDA.b #$1C : JSL.l GetAnimatedSpriteTile_variable
        
        PLY : PLX
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0EE1AA-$0EE1EC LONG JUMP LOCATION
Sprite_SpawnFlippersItem:
{
    LDA.b #$C0
    
    JSL.l Sprite_SpawnDynamically : BMI .spawnFailed
        JSL.l Sprite_SetSpawnedCoords
    
        PHX
        
        TYX
        
        LDA.b #$20 : STA.w $0F80, X
        
        LDA.b #$10 : STA.w $0D40, X
        
        LDA.b #$1E : STA.w $0D90, X
        
        LDA.b #$20 : JSL.l Sound_SetSfx2PanLong
        
        LDA.b #$83 : STA.w $0E40, X
        
        LDA.b #$54 : STA.w $0E60, X
        
        AND.b #$0F : STA.w $0F50, X
        
        LDA.b #$30 : STA !timer_3, X
        
        PLX : PHX
        
        PHY
        
        LDA.b #$11
        
        JSL.l GetAnimatedSpriteTile_variable
        
        PLY : PLX
    
    .spawnFailed
    
    RTL
}

; ==============================================================================

; $0EE1ED-$0EE213 LOCAL JUMP LOCATION
GreatCatfish_SpawnImmediatelyDrownedSprite:
{
    ; Spawn a bush...
    LDA.b #$EC : JSL.l Sprite_SpawnDynamically : BMI .spawnFailed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$03 : STA.w $0DD0, Y
        
        LDA.b #$0F : STA !timer_0, Y
        
        LDA.b #$00 : STA.w $0D80, Y
        LDA.b #$03 : STA.w $0E40, Y
        
        LDA.b #$28 : JSL.l Sound_SetSfx2PanLong
        
    .spawnFailed
    
    RTS
}

; ==============================================================================

; $0EE214-$0EE21B LONG JUMP LOCATION
Sprite_SpawnWaterSplashLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_SpawnWaterSplash
    
    PLB
    
    RTL
}

; ==============================================================================

; $0EE21C-$0EE23F LOCAL JUMP LOCATION
Sprite_SpawnWaterSplash:
{
    LDA.b #$C0
    
    JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        LDA.b #$80 : STA.w $0D90, Y
        
        LDA.b #$02 : STA.w $0E40, Y
                    STA.w $0BA0, Y
        
        LDA.b #$04 : STA.w $0F50, Y
        
        LDA.b #$1F : STA !timer_0, Y
    
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $0EE240-$0EE31F DATA
GreatCatfish_Draw_OAM_groups:
{
    dw -4,  4 : db $8C, $00, $00, $02
    dw  4,  4 : db $8D, $00, $00, $02
    dw -4,  4 : db $8C, $00, $00, $02
    dw  4,  4 : db $8D, $00, $00, $02
    
    dw -4, -4 : db $8C, $00, $00, $02
    dw  4, -4 : db $8D, $00, $00, $02
    dw -4,  4 : db $9C, $00, $00, $02
    dw  4,  4 : db $9D, $00, $00, $02
    
    dw -4, -4 : db $8D, $40, $00, $02
    dw  4, -4 : db $8C, $40, $00, $02
    dw -4,  4 : db $9D, $40, $00, $02
    dw  4,  4 : db $9C, $40, $00, $02
    
    dw -4, -4 : db $9D, $C0, $00, $02
    dw  4, -4 : db $9C, $C0, $00, $02
    dw -4,  4 : db $8D, $C0, $00, $02
    dw  4,  4 : db $8C, $C0, $00, $02
    
    dw -4,  4 : db $9D, $C0, $00, $02
    dw  4,  4 : db $9C, $C0, $00, $02
    dw -4,  4 : db $9D, $C0, $00, $02
    dw  4,  4 : db $9C, $C0, $00, $02
    
    dw  0,  8 : db $BD, $00, $00, $00
    dw  8,  8 : db $BD, $40, $00, $00
    dw  8,  8 : db $BD, $40, $00, $00
    dw  8,  8 : db $BD, $40, $00, $00
    
    dw -8,  0 : db $86, $00, $00, $02
    dw  8,  0 : db $86, $40, $00, $02
    dw  8,  0 : db $86, $40, $00, $02
    dw  8,  0 : db $86, $40, $00, $02
}

; $0EE320-$0EE33C LOCAL JUMP LOCATION
GreatCatfish_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0DC0, X : BEQ .dont_draw
        DEC : REP #$20 : ASL #5 : ADC.w #.OAM_groups : STA.b $08
        
        SEP #$20
        
        LDA.b #$04 : JMP Sprite4_DrawMultiple
        
    .dont_draw
    
    RTS
}

; ==============================================================================

; $0EE33D-$0EE37C DATA
Sprite_WaterSplash_OAM_groups:
{
    dw -8, -4 : db $80, $00, $00, $00
    dw 18, -7 : db $80, $00, $00, $00
    
    dw -5, -2 : db $BF, $00, $00, $00
    dw 15, -4 : db $AF, $40, $00, $00
    
    dw  0, -4 : db $E7, $00, $00, $02
    dw  0, -4 : db $E7, $00, $00, $02
    
    dw  0, -4 : db $C0, $00, $00, $02
    dw  0, -4 : db $C0, $00, $00, $02
}

; $0EE37D-$0EE39C LOCAL JUMP LOCATION
Sprite_WaterSplash:
{
    LDA.b #$00 : XBA
    
    LDA !timer_0, X : BNE .self_termination_delay
        STZ.w $0DD0, X
    
    .self_termination_delay
    
    LSR #3 : REP #$20 : ASL #4 : ADC.w #.OAM_groups : STA.b $08
    
    SEP #$20
    
    LDA.b #$02 : JMP Sprite4_DrawMultiple
}

; ==============================================================================
