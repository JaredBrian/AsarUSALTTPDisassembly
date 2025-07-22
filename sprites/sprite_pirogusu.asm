; ==============================================================================

; $0F273F-$0F2763 BRANCH LOCATION
Sprite_Pirogusu_is_flying_tile:
{
    JMP Sprite_FlyingTile
}
    
; $0F2742 MAIN ENTRY POINT
Sprite_Pirogusu:
{
    LDA.w $0E90, X : BNE .is_flying_tile
        LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
        
        JSR.w Pirogusu_Draw
        JSR.w Sprite3_CheckIfActive
        
        LDA.w $0D80, X
        JSL.l UseImplicitRegIndexedLocalJumpTable
        dw Pirogusu_WriggleInHole  ; 0x00 - $A768
        dw Pirogusu_Emerge         ; 0x01 - $A790
        dw Pirogusu_SplashIntoPlay ; 0x02 - $A7DC
        dw Pirogusu_Swim           ; 0x03 - $A852
}

; ==============================================================================

; $0F2764-$0F2767 DATA
Pirogusu_WriggleInHole_animation_states:
{
    db $02, $03, $00, $01
}

; $0F2768-$0F2781 JUMP LOCATION
Pirogusu_WriggleInHole:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$1F : STA.w $0DF0, X
    
    .delay
    
    STA.w $0BA0, X
    
    LDY.w $0DE0, X
    
    LDA.w .animation_states, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $0F2782-$0F278F DATA
Pool_Pirogusu_Emerge:
{
    ; $0F2782
    .animation_states
    db $09, $0B, $05, $07, $05, $0B, $07, $09
    
    ; $0F278A
    .y_speeds ; Bleeds into the next block. Length 4.
    db 0,  0
    
    ; $0F278C
    .x_speeds
    db 4, -4,  0, 0
}

; $0F2790-$0F27CD JUMP LOCATION
Pirogusu_Emerge:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        STZ.w $0BA0, X
        
        JSR.w Sprite3_Zero_XY_Velocity
        
        RTS
    
    .delay
    
    LDA.w $0DE0, X : ASL : STA.b $00
    
    LDA.w $0DF0, X : LSR #3 : AND.b #$01 : ORA.b $00 : TAY
    
    LDA.w Pool_Pirogusu_Emerge_animation_states, Y : STA.w $0D90, X
    
    LDY.w $0DE0, X
    
    LDA.w Pool_Pirogusu_Emerge_x_speeds, Y : STA.w $0D50, X
    
    LDA.w Pool_Pirogusu_Emerge_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite3_Move
    
    RTS
}

; ==============================================================================

; $0F27CE-$0F27DB DATA
Pool_Pirogusu_SplashIntoPlay:
{
    ; $0F27CE
    .animation_states
    db $10, $11, $12, $13, $0C, $0D, $0E, $0F
    
    ; TODO: Length 2?
    ; $0F27D6
    .x_acceleration ; Bleeds into the next block. Length 2.
    db $02, $FE
    
    ; $0F27D8
    .y_acceleration
    db $00, $00, $02, $FE
}

; $0F27DC-$0F2809 JUMP LOCATION
Pirogusu_SplashIntoPlay:
{
    JSR.w Sprite3_CheckDamage
    JSR.w Sprite3_Move
    
    LDY.w $0DE0, X
    
    LDA.w $0D50, X
    CLC : ADC Pool_Pirogusu_SplashIntoPlay_x_acceleration, Y : STA.w $0D50, X
    
    LDA.w $0D40, X
    CLC : ADC Pool_Pirogusu_SplashIntoPlay_y_acceleration, Y : STA.w $0D40, X
    
    LDA.w $0DF0, X : BNE .splash_delay
        JSL.l Sprite_SpawnSmallWaterSplash
        
        LDA.b #$10 : STA.w $0E00, X
        
        INC.w $0D80, X
    
    .splash_delay

    ; Bleeds into the next function.
}
    
; $0F280A-$0F281F JUMP LOCATION
Pirogusu_Animate:
{
    LDA.w $0DE0, X : ASL : STA.b $00
    
    LDA.b $1A : AND.b #$04 : LSR : LSR : ORA.b $00 : TAY
    
    LDA.w Pool_Pirogusu_SplashIntoPlay_animation_states, Y : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $0F2820-$0F284B LONG JUMP LOCATION
Sprite_SpawnSmallWaterSplash:
{
    ; Spawn a bush sprite... but for what...
    LDA.b #$EC
    LDY.b #$0E
    
    JSL.l Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
        JSL.l Sprite_SetSpawnedCoords
        
        STZ.w $012E
        
        LDA.b #$28 : JSL.l Sound_SetSfx2PanLong
        
        LDA.b #$03 : STA.w $0DD0, Y
        
        LDA.b #$0F : STA.w $0DF0, Y
        LDA.b #$00 : STA.w $0D80, Y
        LDA.b #$03 : STA.w $0E40, Y
        
    .spawn_failed
    
    RTL
}

; ==============================================================================

; $0F284C-$0F2851 DATA
Pool_Pirogusu_Swim:
{
    ; $0F284C
    .x_speeds ; Bleeds into the next block. Length 4.
    db 24, -24
    
    ; $0F284E
    .y_speeds
    db  0,   0,  24, -24
}

; $0F2852-$0F2892 JUMP LOCATION
Pirogusu_Swim:
{
    JSR.w Sprite3_CheckIfRecoiling
    JSR.w Sprite3_CheckDamage
    JSR.w Pirogusu_Animate
    
    CLC : ADC.b #$08 : STA.w $0D90, X
    
    LDA.w $0E00, X : BNE .swim_logic_delay
        JSR.w Pirogusu_SpawnSplashGarnish
        JSR.w Sprite3_Move
        
        JSR.w Sprite3_CheckTileCollision : AND.b #$0F : BEQ .anochange_direction
            JSL.l GetRandomInt : LSR : LDA.w $0DE0, X : ROL : TAY
            
            LDA.w Zazak_HaltAndPickNextDirection_head_orientations, Y
            STA.w $0DE0, X
        
        .anochange_direction
        
        LDY.w $0DE0, X
        
        LDA.w Pool_Pirogusu_Swim_x_speeds, Y : STA.w $0D50, X
        
        LDA.w Pool_Pirogusu_Swim_y_speeds, Y : STA.w $0D40, X
    
    .swim_logic_delay
    
    RTS
}

; ==============================================================================

; $0F2893-$0F2896 DATA
Pirogusu_SpawnSplashGarnish_displacements:
{
    db 3, 4, 5, 4
}

; $0F2897-$0F2902 LOCAL JUMP LOCATION
Pirogusu_SpawnSplashGarnish:
{
    TXA : EOR.b $1A : AND.b #$03 : BNE .garnish_delay
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        LDA.w .displacements, Y : STA.b $00
        
        JSL.l GetRandomInt : AND.b #$03 : TAY
        
        LDA.w .displacements, Y : STA.b $01
        
        PHX : TXY
        
        LDX.b #$0E
        
        .find_open_garnish_slot
        
            LDA.l $7FF800, X : BEQ .open_garnish_slot
        DEX : BPL .find_open_garnish_slot
        
        PLX
        
    .garnish_delay
    
    RTS
    
    .open_garnish_slot
    
    LDA.b #$0B : STA.l $7FF800, X
                 STA.w $0FB4
    
    LDA.w $0D10, Y : CLC : ADC.b $00  : STA.l $7FF83C, X
    LDA.w $0D30, Y :       ADC.b #$00 : STA.l $7FF878, X
    
    LDA.w $0D00, Y : CLC : ADC.b #$10 : PHP
                     CLC : ADC.b $01  : STA.l $7FF81E, X

    LDA.w $0D20, Y : ADC.b #$00 : PLP : ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.b #$0F : STA.l $7FF90E, X
    
    PLX
    
    RTS
}

; ==============================================================================

; $0F2903-$0F293A DATA
Pool_Pirogusu_Draw:
{
    ; $0F2903
    .vh_flip
    db $00, $80, $40, $00, $00, $00, $00, $80
    db $80, $C0, $40, $40, $00, $40, $80, $C0
    db $40, $C0, $00, $80, $00, $40, $80, $C0
    db $40, $C0, $00, $80
    
    ; $0F291F
    .animation_states
    db $00, $00, $01, $01, $02, $03, $04, $03
    db $02, $03, $04, $03, $05, $05, $05, $05
    db $07, $07, $07, $07, $06, $06, $06, $06
    db $08, $08, $08, $08
}

; $0F293B-$0F297E LOCAL JUMP LOCATION
Pirogusu_Draw:
{
    LDY.w $0D90, X
    
    LDA.w $0F50, X
    AND.b #$3F : ORA Pool_Pirogusu_Draw_vh_flip, Y : STA.w $0F50, X
    
    LDA.w Pool_Pirogusu_Draw_animation_states, Y : STA.w $0DC0, X
    
    CPY.b #$04 : BCS .fully_visible
        LDA.w $0FD8 : CLC : ADC.b #$04 : STA.w $0FD8
        LDA.w $0FD9       : ADC.b #$00 : STA.w $0FD9
        
        LDA.w $0FDA : CLC : ADC.b #$04 : STA.w $0FDA
        LDA.w $0FDB       : ADC.b #$00 : STA.w $0FDB
        
        JSL.l Sprite_PrepAndDrawSingleSmallLong
        
        RTS
    
    .fully_visible
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    
    RTS
}

; ==============================================================================
