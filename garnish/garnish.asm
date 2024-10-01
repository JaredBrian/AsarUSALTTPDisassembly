; ==============================================================================

; $04B020-$04B06D LONG JUMP LOCATION
ZoraFireball_SpawnTailGarnish:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .skip_frame
        PHX
        
        LDX.b #$1D
        
        .next_slot
        
            LDA.l $7FF800, X : BEQ .empty_slot
        DEX : BPL .next_slot
        
        PLX
    
    .skip_frame
    
    RTL
    
    .empty_slot
    
    LDA.b #$08 : STA.l $7FF800, X : STA.w $0FB4
    LDA.b #$0B : STA.l $7FF90E, X
    
    LDA.w $0FD8 : STA.l $7FF83C, X
    LDA.w $0FD9 : STA.l $7FF878, X
    
    LDA.w $0FDA : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0FDB       : ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.w $0FA0 : STA.l $7FF92C, X
    
    PLX
    
    RTL
}

; ==============================================================================

; $04B06E-$04B07E LONG JUMP LOCATION
Garnish_ExecuteUpperSlotsLong:
{
    ; NOTE: Maybe I'm nitpickin', but doesn't this seem a bit out of place
    ; here?
    JSL.l Filter_MajorWhitenMain
    
    LDA.w $0FB4 : BEQ .no_spawned_garnishes
        PHB : PHK : PLB
        
        JSR.w Garnish_ExecuteUpperSlots
        
        PLB
        
    .no_spawned_garnishes
    
    RTL
}

; ==============================================================================

; $04B07F-$04B08B LONG JUMP LOCATION
Garnish_ExecuteLowerSlotsLong:
{
    LDA.w $0FB4 : BEQ .no_spawned_garnishes
        PHB : PHK : PLB
        
        JSR.w Garnish_ExecuteLowerSlots
        
        PLB
    
    .no_spawned_garnishes
    
    RTL
}

; ==============================================================================

; $04B08C-$04B096 LOCAL JUMP LOCATION
Garnish_ExecuteUpperSlots:
{
    LDX.b #$1D
    
    .next_animation
    
        JSR.w Garnish_ExecuteSingle
    DEX : CPX.b #$0E : BNE .next_animation
    
    RTS
}

; ==============================================================================

; $04B097-$04B09F LOCAL JUMP LOCATION
Garnish_ExecuteLowerSlots:
{
    LDX.b #$0E
    
    .next_animation
    
        JSR.w Garnish_ExecuteSingle
    DEX : BPL .next_animation
    
    RTS
}

; ==============================================================================

; $04B0A0-$04B0B5 DATA
Garnish_ExecuteSingle_oam_allocation:
{
    db  4,  4,  4,  4,  4,  4,  4,  4
    db  4,  4,  4,  4,  4,  4,  4,  4
    db  8,  4,  4,  4,  8, 16
}

; $04B0B6-$04B14F LOCAL JUMP LOCATION
Garnish_ExecuteSingle:
{
    STX.w $0FA0
    
    LDA.l $7FF800, X : BEQ .return
        CMP.b #$05 : BEQ .ignore_submodule
            LDA.b $11 : ORA.w $0FC1 : BNE .dont_self_terminate
        
        .ignore_submodule
        
        LDA.l $7FF90E, X : BEQ .dont_self_terminate
            DEC A : STA.l $7FF90E, X : BNE .dont_self_terminate
                STA.l $7FF800, X
                
                BRA .return
            
        .dont_self_terminate
        
        LDY.w $0FB3 : BEQ .dont_sort_sprites
            LDA.l $7FF968, X : BEQ .on_bg2
                LDA.l $7FF800, X : TAY
                
                LDA.w .oam_allocation-1, Y : JSL.l OAM_AllocateFromRegionF
                
                BRA .execute_handler
            
            .on_bg2
            
            LDA.l $7FF800, X : TAY
            
            LDA.w .oam_allocation-1, Y : JSL.l OAM_AllocateFromRegionD
            
            BRA .execute_handler
        
        .dont_sort_sprites
        
        LDA.l $7FF800, X : TAY
        
        LDA.w .oam_allocation-1, Y : JSL.l OAM_AllocateFromRegionA
        
        .execute_handler
        
        LDA.l $7FF800, X : DEC A
        
        REP #$30
        
        AND.w #$00FF : ASL A : TAY
        
        ; These sneaky hidden jump tables, I swear...
        LDA.w .handlers, Y : DEC A : PHA
        
        SEP #$30
    
    .return
    
    RTS
    
    .handlers
    
    dw Garnish_WinderTrail         ; 0x01 - $B6C0
    dw Garnish_MothulaBeamTrail    ; 0x02 - $B6E1
    dw Garnish_CrumbleTile         ; 0x03 - $B627
    dw Garnish_LaserBeamTrail      ; 0x04 - $B5BB
    dw Garnish_SimpleSparkle       ; 0x05 - $B526
    dw Garnish_ZoroDander          ; 0x06 - $B4FB
    dw Garnish_BabusuFlash         ; 0x07 - $B49E
    
    dw Garnish_Nebule              ; 0x08 - $B4C6
    dw Garnish_LightningTrail      ; 0x09 - $B429
    dw Garnish_CannonPoof          ; 0x0A - $B3EE
    dw Garnish_WaterTrail          ; 0x0B - $B3C2 Pirogusu trail? (water trails from them?).
    dw Garnish_TrinexxIce          ; 0x0C - $B34F
    dw $0000                       ; 0x0D - $0000 Clearly this is an invalid pointer, so it shouldn't be used.
    dw Garnish_TrinexxLavaBubble   ; 0x0E - $B55D
    dw Garnish_BlindLaserTrail     ; 0x0F - $B591
    
    dw Garnish_GanonBatFlame       ; 0x10 - $B306
    dw Garnish_GanonBatFlameout    ; 0x11 - $B2B2
    dw Garnish_Sparkle             ; 0x12 - $B520 Sparkle that animates based on its autotimer.
    dw Garnish_PyramidDebris       ; 0x13 - $B216
    dw Garnish_RunningManDashDust  ; 0x14 - $B3BC
    dw Garnish_ArrghusSplash       ; 0x15 - $B178
    dw Garnish_ScatterDebris       ; 0x16 - $F0CB Pot, bush, sign, or rock shattering after being broken up.
}

; ==============================================================================

; $04B150-$04B1BC
incsrc "garnish_arrghus_splash.asm"

; $04B1BD-$04B251
incsrc "garnish_pyramid_debris.asm"

; ==============================================================================

; $04B252-$04B25B LOCAL JUMP LOCATION
Garnish_Move_XY:
{
    PHX
    
    TXA : CLC : ADC.b #$1E : TAX
    
    JSR.w Garnish_MoveVert
    
    PLX

    ; Bleeds into the next function.
}
    
; NOTE: While no one else calls this location, it mirrors the
; availability of routines in other object classes.
; $04B25C-$04B283 LOCAL JUMP LOCATION
Garnish_MoveVert:
{
    LDA.l $7FF896, X : ASL #4 : CLC : ADC.l $7FF8D2, X : STA.l $7FF8D2, X
    
    LDA.l $7FF896, X : PHP : LSR #4 : PLP : BPL .alpha
        ORA.b #$F0
    
    .alpha
    
    ADC.l $7FF81E, X : STA.l $7FF81E, X
    
    RTS
}

; ==============================================================================

; $04B284-$04B33E
incsrc "garnish_ganon_bat_flame_objects.asm"

; $04B33F-$04B3B8
incsrc "garnish_trinexx_ice.asm"

; $04B3B9-$04B3E7
incsrc "garnish_running_man_dust_and_water_trail.asm"

; $04B3E8-$04B418
incsrc "garnish_cannon_poof.asm"

; $04B419-$04B495
incsrc "garnish_lightning_trail.asm"

; $04B496-$04B4BF
incsrc "garnish_babusu_flash.asm"

; $04B4C0-$04B4FA
incsrc "garnish_nebule.asm"

; $04B4FB-$04B51B
incsrc "garnish_zoro_dander.asm"

; $04B51C-$04B558
incsrc "garnish_sparkle_objects.asm"

; $04B559-$04B58C
incsrc "garnish_trinexx_lava_bubble.asm"

; $04B58D-$04B5B8
incsrc "garnish_blind_laser_trail.asm"

; $04B5B9-$04B5DD
incsrc "garnish_laser_beam_trail.asm"

; ==============================================================================

; $04B5DE-$04B612 LOCAL JUMP LOCATION
Garnish_PrepOamCoord:
{
    LDA.l $7FF83C, X : SEC : SBC.b $E2 : STA.b $00
    LDA.l $7FF878, X       : SBC.b $E3 : STA.b $01
    BNE .off_screen
        LDA.l $7FF81E, X : SEC : SBC.b $E8 : PHA
        LDA.l $7FF85A, X       : SBC.b $E9
        
        BEQ .on_screen
        
        PLA
    
    .off_screen
    
    ; Self terminate?
    LDA.b #$00 : STA.l $7FF800, X
    
    PLA : PLA
    
    RTS
    
    .on_screen
    
    PLA : SBC.b #$10 : STA.b $02
    
    LDY.b #$00
    
    RTS
}

; ==============================================================================

; $04B613-$04B6BF
incsrc "garnish_crumble_tile.asm"

; $04B6C0-$04B6E0
incsrc "garnish_winder_trail.asm"

; $04B6E1-$04B713
incsrc "garnish_mothula_beam_trail.asm"

; ==============================================================================
