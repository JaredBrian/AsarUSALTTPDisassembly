; ==============================================================================

; $032858-$032863 DATA
Pool_Sprite_CoveredRupeeCrab:
{
    ; $032858
    .animation_states
    db 3, 4, 5, 4
    
    ; $03285C
    .x_speeds
    db -12,  12,   0,  0
    
    ; $032860
    .y_speeds
    db   0,   0, -12, 12
}
    
; ==============================================================================

; $032864-$03286B
Pool_Sprite_RupeeCrab:
{
    ; $032864
    .x_speeds
    db -16,  16, -16,  16
    
    ; $032868
    .y_speeds
    db -16, -16,  16,  16
}

; ==============================================================================

; $03286C-$03291C JUMP LOCATION
Sprite_CoveredRupeeCrab:
{
    LDA.w $0D80, X : BEQ .still_covered
        JMP Sprite_RupeeCrab
    
    .still_covered
    
    JSR.w CoveredRupeeCrab_Draw
    JSR.w Sprite_CheckIfActive
    
    STZ.w $0DC0, X
    
    JSR.w Sprite_DirectionToFacePlayer
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        LDA.b $0E : CLC : ADC.b #$30 : CMP.b #$60 : BCS .BRANCH_GAMMA
            LDA.b $0F : CLC : ADC.b #$20 : CMP.b #$40 : BCS .BRANCH_GAMMA
                LDA.b #$20 : STA.w $0DF0, X
    
    .BRANCH_BETA
    
    LDA.w Pool_Sprite_CoveredRupeeCrab_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_Sprite_CoveredRupeeCrab_y_speeds, Y : STA.w $0D40, X
    
    LDA.w $0E70, X : BNE .tile_collision
        JSR.w Sprite_Move
    
    .tile_collision
    
    JSR.w Sprite_CheckTileCollision
    JSR.w Sprite_CheckDamageFromPlayer
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR : AND.b #$03 : TAY
    
    LDA.w Pool_Sprite_CoveredRupeeCrab_animation_states, Y : STA.w $0DC0, X
    
    .BRANCH_GAMMA
    
    ; The only real alternative is probably a bush covered crab.
    LDA.w $0E20, X : CMP.b #$3E : BNE .not_rock_covered_crab
        ; Can't pick up the rock off of the crab...
        LDA.l $7EF354 : CMP.b #$01 : BCC .puny_girly_man
    
    .not_rock_covered_crab
    
    JSL.l Sprite_CheckIfLiftedPermissiveLong
    
    .puny_girly_man
    
    LDA.w $0DD0, X : CMP.b #$09 : BEQ .sprite_still_active
        LDA.b #$01
        
        LDY.w $0E20, X : CPY.b #$17 : BNE .BRANCH_IOTA
            INC A
            
        .BRANCH_IOTA
        
        STA.w $0DB0, X
        
        LDA.b #$EC : STA.w $0E20, X
        
        LSR.w $0F50, X : ASL.w $0F50, X
        
        STZ.w $0DC0, X
        
        LDA.b #$3E : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
            JSL.l Sprite_SetSpawnedCoords
            
            LDA.w $0E40, Y : ASL : LSR : STA.w $0E40, Y
            
            LDA.b #$80 : STA.w $0E10, Y
            
            LDA.b #$09 : STA.w $0F50, Y : STA.w $0D80, Y
        
        .spawn_failed
    .sprite_still_active
    
    RTS
}

; ==============================================================================

; $03291D-$032A0B LOCAL JUMP LOCATION
Sprite_RupeeCrab:
{
    JSR.w Sprite_PrepAndDrawSingleLarge
    JSR.w Sprite_CheckIfActive
    JSR.w Sprite_CheckIfRecoiling
    JSR.w Sprite_CheckDamageFromPlayer
    
    LDA.w $0E10, X : BNE .BRANCH_ALPHA
        JSR.w Sprite_CheckDamageToPlayer
    
    .BRANCH_ALPHA
    
    INC.w $0E80, X : LDA.w $0E80, X : LSR : AND.b #$03 : TAY
    
    LDA.w .animation_states, Y : STA.w $0DC0, X
    
    LDA.w $0F50, X : AND.b #$BF : ORA.w .h_flip, Y : STA.w $0F50, X
    
    LDA.w $0E70, X : BEQ .no_tile_collision
        LDA.b #$10 : STA.w $0F10, X
        
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        LDA.w Pool_Sprite_RupeeCrab_x_speeds, Y : STA.w $0D50, X
        
        LDA.w Pool_Sprite_RupeeCrab_y_speeds, Y : STA.w $0D40, X
        
        BRA .dont_move
    
    .no_tile_collision
    
    JSR.w Sprite_Move
    
    .dont_move
    
    JSR.w Sprite_CheckTileCollision
    
    LDA.w $0F10, X : BNE .BRANCH_DELTA
        TXA : EOR.b $1A : AND.b #$1F : BNE .BRANCH_DELTA
            LDA.b #$10 : JSR.w Sprite_ProjectSpeedTowardsPlayer
            
            LDA.b $00 : EOR.b #$FF : INC : STA.w $0D40, X
            
            LDA.b $01 : EOR.b #$FF : INC : STA.w $0D50, X
    
    .BRANCH_DELTA
    
    LDA.b $1A : AND.b #$01 : BNE .BRANCH_EPSILON
        INC.w $0ED0, X
        
        LDA.w $0ED0, X : CMP.b #$C0 : BNE .BRANCH_ZETA
            LDA.b #$0F : JSR.w Sprite_CustomTimedScheduleForBreakage
            
            LDY.b #$01
            
            BRA .spawn_green_rupee
        
        .BRANCH_ZETA
        
        LDA.w $0ED0, X : AND.b #$0F : BNE .BRANCH_EPSILON
            LDY.b #$00
            
            LDA.w $0EB0, X : CMP.b #$06 : BNE .spawn_green_rupee
                LDA.b #$DB : BRA .red_rupee
            
            .spawn_green_rupee
            
            LDA.b #$D9
            
            .red_rupee
            
            JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
                INC.w $0EB0, X
                
                JSL.l Sprite_SetSpawnedCoords
                
                LDA.b $00 : CLC : ADC.b #$08 : STA.w $0D10, Y
                LDA.b $01       : ADC.b #$00 : STA.w $0D30, Y
                
                LDA.b #$20 : STA.w $0F80, Y
                
                LDA.b #$10 : STA.w $0F10, Y
                
                PHX
                
                TYX
                
                LDA.b #$10 : JSR.w Sprite_ApplySpeedTowardsPlayer
                
                LDA.b $00 : EOR.b #$FF : STA.w $0D40, X
                LDA.b $01 : EOR.b #$FF : STA.w $0D50, X
                
                PLX
                
                LDA.b #$30 : JSL.l Sound_SetSfx3PanLong
            
            .spawn_failed
    .BRANCH_EPSILON
    
    RTS
    
    ; $032A04
    .animation_states
    db $00, $01, $00, $01 

    ; $032A08
    .h_flip
    db $00, $00, $40, $00
}

; ==============================================================================

; $032A0C-$032A13 LONG JUMP LOCATION
Sprite_CheckIfLiftedPermissiveLong:
{
    PHB : PHK : PLB
    
    JSR.w Sprite_CheckIfLiftedPermissiveWrapper
    
    PLB
    
    RTL
}

; ==============================================================================

; WTF: Don't ask me why this is needed rather than just calling the routine
; directly.
; OPTIMIZE: See the wtf above.
; $032A14-$032A17 LOCAL JUMP LOCATION
Sprite_CheckIfLiftedPermissiveWrapper:
{
    JSR.w Sprite_CheckIfLiftedPermissive
    
    RTS
}

; ==============================================================================

; $032A18-$032A47 DATA
Pool_CoveredRupeeCrab_Draw:
{
    ; $032A18
    .y_offsets
    dw  0,  0,  0, -3,  0, -5,  0, -6
    dw  0, -6,  0, -6
    
    ; $032A30
    .chr
    db $44, $44, $E8, $44, $E8, $44, $E6, $44
    db $E8, $44, $E6, $44
    
    ; $032A3C
    .properties
    db $00, $0C, $03, $0C, $03, $0C, $03, $0C
    db $03, $0C, $43, $0C
}

; $032A48-$032ABD LOCAL JUMP LOCATION
CoveredRupeeCrab_Draw:
{
    JSR.w Sprite_PrepOamCoord
    
    LDA.w $0FC6 : CMP.b #$03 : BCS .invalid_GFX_loaded
        STZ.b $07
        
        LDA.w $0E20, X : CMP.b #$17 : BNE .under_rock
            LDA.b #$02 : STA.b $07
        
        .under_rock
        
        LDA.w $0DC0, X : ASL : STA.b $06
        
        PHX
        
        LDX.b #$01
        
        .next_subsprite
        
            PHX
            
            TXA : CLC : ADC.b $06 : PHA
            
            ASL : TAX
            
            REP #$20
            
            LDA.b $00 : STA ($90), Y
            
            AND.w #$0100 : STA.b $0E
            
            LDA.b $02 : CLC : ADC Pool_CoveredRupeeCrab_Draw_y_offsets, X
            INY : STA ($90), Y
            
            CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .on_screen_y
                LDA.b #$F0 : STA ($90), Y
            
            .on_screen_y
            
            PLX
            
            LDA.w Pool_CoveredRupeeCrab_Draw_chr, X : CMP.b #$44 : BNE .chr_mismatch
                CLC : ADC.b $07
            
            .chr_mismatch
            
            INY : STA ($90), Y

            LDA.b $05 : AND.b #$FE : ORA Pool_CoveredRupeeCrab_Draw_properties, X
            INY : STA ($90), Y
            
            PHY : TYA : LSR #2 : TAY
            
            LDA.b #$02 : ORA.b $0F : STA ($92), Y
            
            PLY : INY
        PLX : DEX : BPL .next_subsprite
        
        PLX
    
    .invalid_GFX_loaded
    
    RTS
}

; ==============================================================================
