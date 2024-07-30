
; ==============================================================================

; $0E8D06-$0E8D28 LOCAL JUMP LOCATION
Ganon_CheckEntityProximity:
{
    REP #$20
    
    LDA.w $0FD8 : SEC : SBC.b $04 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
        LDA.w $0FDA : SEC : SBC.b $06 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
            ; TODO: What?
    .BRANCH_ALPHA
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0E8D29-$0E8D3F LONG JUMP LOCATION
Ganon_Initialize:
{
    PHB : PHK : PLB
    
    JSR.w $9443 ; $0E9443 IN ROM
    
    LDA.b #$80 : STA.w $0DF0, X
    
    LDA.b #$02 : STA.w $0C9A, X
    
    LDA.b #$1E : STA.w $012C
    
    PLB
    
    RTL
}

; ==============================================================================

; $0E8D70-$0E8E74 LOCAL JUMP LOCATION
Ganon_HandleFireBatCircle:
{
    LDA.b #$FC : CLC : ADC.w $0B08 : STA.w $0B08
    LDA.b #$FF :       ADC.w $0B09 : STA.w $0B09
    
    STZ.w $0FB5
    
    PHX
    
    .next_bat
    
        LDA.w $0FB5 : TAX : ASL A : TAY
        
        REP #$20
        
        LDA.w $0B08 : CLC : ADC.w $8D40, Y : AND.w #$01FF : STA.b $00
        LSR #5 : TAY
        
        SEP #$20
        
        LDA.w $0D81, X : CMP.b #$02 : BEQ .BRANCH_ALPHA
            TYA : SEC : SBC.b #$04 : AND.b #$0F : TAY
            
            LDA.w $8D50, Y : STA.w $0D51, X
            
            ASL A : PHP : ROR.w $0D51, X : PLP : ROR.w $0D51, X
            
            LDA.w $8D60, Y : STA.w $0D41, X
            
            ASL A : PHP : ROR.w $0D41, X : PLP : ROR.w $0D41, X
        
        .BRANCH_ALPHA
        
        LDA.w $0B0A : STA.b $0F
        
        PHX
        
        REP #$30
        
        LDA.b $00 : AND.w #$00FF : ASL A : TAX
        
        LDA.l $04E800, X : STA.b $04
        
        LDA.b $00 : CLC : ADC.w #$0080 : STA.b $02
        
        AND.w #$00FF : ASL A : TAX
        
        LDA.l $04E800, X : STA.b $06
        
        SEP #$30
        
        PLX
        
        LDA.b $04 : STA.w $4202
        
        LDA.b $0F
        
        LDY.b $05 : BNE .BRANCH_BETA
            STA.w $4203
            
            JSR.w $8E75 ; $0E8E75 IN ROM
            
            ASL.w $4216
            
            LDA.w $4217 : ADC.b #$00
        
        .BRANCH_BETA
        
        LSR.b $01 : BCC .BRANCH_GAMMA
            EOR.b #$FF : INC A
        
        .BRANCH_GAMMA
        
        STZ.b $0A
        
        CMP.b #$00 : BPL .BRANCH_DELTA
            DEC.b $0A
        
        .BRANCH_DELTA
        
                CLC : ADC.w $0D10 : STA.w $0B11, X
        LDA.w $0D30 : ADC.b $0A   : STA.w $0B21, X
        
        LDA.b $06 : STA.w $4202
        
        LDA.b $0F
        
        LDY.b $07 : BNE .BRANCH_EPSILON
            STA.w $4203
            
            JSR.w $8E75 ; $0E8E75 IN ROM
            
            ASL.w $4216
            
            LDA.w $4217 : ADC.b #$00
        
        .BRANCH_EPSILON
        
        LSR.b $03 : BCC .BRANCH_ZETA
            EOR.b #$FF : INC A
        
        .BRANCH_ZETA
        
        STZ.b $0A
        
        CMP.b #$00 : BPL .BRANCH_THETA
            DEC.b $0A
        
        .BRANCH_THETA
        
                CLC : ADC.w $0D00 : STA.w $0B31, X
        LDA.w $0D20 : ADC.b $0A   : STA.w $0B41, X
        
        INC.w $0FB5 : LDA.w $0FB5 : CMP.b #$08 : BEQ .BRANCH_IOTA
    JMP.w .next_bat
    
    .BRANCH_IOTA
    
    PLX
    
    RTS
}

; $0E8E75-$0E8E7B LOCAL JUMP LOCATION
Six_NOP:
{
    NOP #6
    
    RTS
}

; $0E8E7C-$0E8EAA LOCAL JUMP LOCATION
Ganon_SpawnSpiralBat:
{
    LDA.b #$C9
    LDY.b #$08
    
    JSL Sprite_SpawnDynamically_arbitrary
    BMI Ganon_SetSpawnedEntityProperties_no_space
        JSL Sprite_SetSpawnedCoords
        
        LDA.b #$04 : STA.w $0EC0, Y
        LDA.b #$03 : STA.w $0F50, Y
        LDA.b #$40 : STA.w $0E60, Y
        LDA.b #$01 : STA.w $0E40, Y
        LDA.b #$80 : STA.w $0CAA, Y : STA.w $0D20, Y
        LDA.b #$30 : STA.w $0DF0, Y

        ; Bleeds into the next function.
}
        
; $0E8EAB-$0E8EB3 LOCAL JUMP LOCATION
Ganon_SetSpawnedEntityProperties:
{
    LDA.b #$07 : STA.w $0CD2, Y : STA.w $0BA0, Y
    
    .no_space
    
    RTS
}

; CODE FOR GANON
; $0E8EB4-$0E8F89 LOCAL JUMP LOCATION
Sprite_Ganon:
{
    ; Load the AI pointer
    ; If >= 0, branch to another routine.
    LDA.w $0D80, X : BPL .not_dying
        JSR Sprite4_CheckIfActive
        
        LDA.w $0DF0, X : BNE .BRANCH_ALPHA
            ; Kill Ganon.
            STZ.w $0DD0, X
        
        .BRANCH_ALPHA
        
        LSR A : BCS .BRANCH_BETA
            ; Routine that draws Ganon to screen.
            JSR.w $9ADF ; $0E9ADF IN ROM
        
        .BRANCH_BETA
        
        RTS

        ; $0E8ECB
        .direction
        db $02, $00

        ; $0E8ECD
        .anim_steps
        db $10, $0A

    .not_dying

    LDA.w $0F10, X : BEQ .BRANCH_ALPHA
        ; If 0, Ganon faces down, if 1, Ganon faces up.
        LDY.w $0DE0, X
        
        ; $E8ECD, Y THAT IS (DIFFERENT POSES FOR GANON)
        LDA.w $8ECD, Y : STA.w $0DC0, X
    
    .BRANCH_ALPHA
    
    ; A state having to do with whether Ganon can be hit. Also affects
    ; translucency. 2 means he is hittable and fully visible.
    LDA.w $04C5 : CMP.b #$02 : BNE .BRANCH_BETA
        ; Basically, we can't hit ganon.
        CMP.w $0C9A, X : BEQ .BRANCH_BETA
            PHA
            
            ; Another delay timer. For Ganon, this occurs when you "turn the
            ; lights on and he puts his cape over his face for a few seconds."
            LDA.b #$40 : STA.w $0E00, X
            
            PLA
    
    .BRANCH_BETA
    
    STA.w $0C9A, X
    
    ; Routine that draws Ganon to screen.
    JSR.w $9ADF ; $0E9ADF IN ROM
    
    LDA.w $0E00, X : BEQ .BRANCH_GAMMA
        LDA.b #$0F : STA.w $0DC0, X
        
        ; Causes Gannon to be vulnerable to silver arrows.
        JSR.w $8FFA ; $0E8FFA IN ROM
        
        JMP Sprite4_CheckDamage
    
    .BRANCH_GAMMA
    
    JSR Sprite4_CheckIfActive
    
    LDA.w $0E10, X : BEQ .BRANCH_DELTA
        CMP.b #$10 : BEQ .BRANCH_EPSILON
            CMP.b #$01 : BNE .BRANCH_DELTA
                PHX
                
                JSL Dungeon_ExtinguishSecondTorch
                
                PLX
                
                BRA .BRANCH_DELTA

        .BRANCH_EPSILON

        PHX
        
        JSL Dungeon_ExtinguishFirstTorch
        
        PLX
    
    .BRANCH_DELTA
    
    JSR Sprite4_IsToRightOfPlayer
    
    LDA.b $0F : ADC.b #$20 : CMP.b #$40 : LDA.b #$01 : BCC .BRANCH_ZETA
        LDA.w $8ECB, Y
    
    .BRANCH_ZETA
    
    STA.w $0EB0, X
    
    LDA.w $0F10, X : BEQ .BRANCH_THETA
        STA.w $0BA0, X
        
        JSR Sprite4_CheckIfRecoiling
        
        STZ.w $0DF0, X
        
        RTS
    
    .BRANCH_THETA
    
    LDA.w $0BA0, X : ORA.w $02E4 : BNE .BRANCH_IOTA
        LDA.w $04C5 : CMP.b #$02 : BNE .BRANCH_IOTA
            JSR Sprite4_CheckDamage
    
    .BRANCH_IOTA
    
    STZ.w $0BA0, X
    
    LDA.w $0D80, X ; Load the AI pointer, the main control for Ganon.
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    ; Beginning Trident phase
    dw $92CA ; = $0E92CA ; 0x00 Sets up the initial Ganon text, and his music.
    dw $9354 ; = $0E9354 ; 0x01 Spin trident? ; Yes
    dw $93FD ; = $0E93FD ; 0x02 Wait to catch trident
    dw $9428 ; = $0E9428 ; 0x03 Catch trident
    dw $946C ; = $0E946C ; 0x04 This one is never called from here but is still hit somehow. This doesn't allow link to damage ganon below a certain health durring a phase change?
    dw $94FA ; = $0E94FA ; 0x05 Blinky blinky across room 
    dw $95AD ; = $0E95AD ; 0x06 Wait for a sec and look side to side

    ; Fire bat ring phase
    dw $9203 ; = $0E9203 ; 0x07 Spin trident and spawn ring of fire bats
    dw $9248 ; = $0E9248 ; 0x08 Ring grows and shrinks
    dw $928F ; = $0E928F ; 0x09 Fire bats activate and target link
    dw $94FA ; = $0E94FA ; 0x0A Blinky blinky across room 
    dw $92AA ; = $0E92AA ; 0x0B Arrives at location from blinky blinky

    ; Breaking the floor phase
    dw $9113 ; = $0E9113 ; 0x0C Spawns spinning fire bat that leave fire trail unless hit by link
    dw $94F5 ; = $0E94F5 ; 0x0D Blinky blinky across room + limit health
    dw $91D5 ; = $0E91D5 ; 0x0E Arrives at location and rolls the dice to see if he blinky blinkys again
    dw $9018 ; = $0E9018 ; 0x0F Starts Jump
    dw $9044 ; = $0E9044 ; 0x10 Lands from jump and trigger floor falling

    ; Lights out phase
    dw $8FBC ; = $0E8FBC ; 0x11 Shoot fire bat in straight line at link
    dw $94FA ; = $0E94FA ; 0x12 Blinky blinky across room 
    dw $8F8C ; = $0E8F8C ; 0x13 Hit by link and vunerable to silver arrows
}

; ==============================================================================

; $0E8F8A-$0E8F8B DATA
Ganon_Phase4_Stunned_animation_states:
{
    db $05, $0D
}

; $0E8F8C-$0E8FB7 LOCAL JUMP LOCATION ; 0x13
Ganon_Phase4_Stunned:
{
    LDA.b #$05 : STA.w $0F50, X
    LDA.b #$02 : STA.w $0B6B, X
    
    LDA.w $0DF0, X : BNE .delay
        LDA.b #$01 : STA.w $0F50, X
        
        LDA.b #$12
        
        JSR.w $947F ; $0E947F IN ROM
        
        LDA.b #$D6 : STA.w $0E20, X
        
        STZ.w $0EF0, X
        
        RTS
    
    .delay
    
    LDY.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E8FB8-$0E8FBD DATA
Ganon_Phase4_Attack_animation_states:
{
    db $06, $0E, $07, $0A
}

; $0E8FBC-$0E8FF9 JUMP LOCATION ; 0x11
Ganon_Phase4_Attack:
{
    LDY.w $0DE0, X
    
    LDA .animation_states+0, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        LDA.b #$12
        
        JSR.w $947F ; $0E947F IN ROM
        
        RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$34 : PHP : BNE .BRANCH_BETA
        JSR.w $915C ; $0E915C IN ROM
    
    .BRANCH_BETA
    
    PLP : BCS .BRANCH_GAMMA
        LDY.w $0DE0, X
        
        LDA.w .animation_states+2, Y : STA.w $0DC0, X
    
    .BRANCH_GAMMA
    
    LDA.w $0DF0, X
    
    CMP.b #$48 : BCS .BRANCH_DELTA
         CMP.b #$28 : BCS .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    INC.w $0BA0, X
    
    LSR A : BCC .BRANCH_EPSILON
        LDA.b #$FF : STA.w $0DC0, X
    
    .BRANCH_EPSILON

    ; Bleeds into the next function.
}

; $0E8FFA-$0E9015 JUMP LOCATION
Ganon_EnableInvincibility:
{
    LDA.w $0EF0, X : AND.b #$7F : CMP.b #$1A : BNE .BRANCH_ZETA
        STZ.w $0EF0, X
        
        LDA.b #$13 : STA.w $0D80, X
        
        LDA.b #$7F : STA.w $0DF0, X
        
        LDA.b #$D7 : STA.w $0E20, X

    .BRANCH_ZETA

    RTS
}

; ==============================================================================

; $0E9016-$0E9017 DATA
Ganon_Phase3_SmashFloor_animation_states
{
    db 6, 14
}

; $0E9018-$0E9041 JUMP LOCATION ; 0x0F
Ganon_Phase3_SmashFloor:
{
    LDA.w $0DF0, X : BEQ .BRANCH_ALPHA
        DEC A : BNE .BRANCH_BETA
            LDA.b #$10 : STA.w $0D80, X
            
            LDA.b #$A0 : STA.w $0F80, X
            
            RTS
    
    .BRANCH_ALPHA
    
    JSR Sprite4_MoveAltitude
    
    DEC.w $0F80, X : BNE .BRANCH_BETA
        LDA.b #$20 : STA.w $0DF0, X
    
    .BRANCH_BETA
    
    LDY.w $0DE0, X
    
    LDA .animation_states, Y : STA.w $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E9042-$0E9043 DATA
Ganon_Phase3_DropTiles_animation_states:
{
    db 2, 10
}

; $0E9044-$0E907E JUMP LOCATION ; 0x10
Ganon_Phase3_DropTiles:
{
    STZ.w $011C
    STZ.w $011D
    
    LDA.w $0DF0, X : BEQ .descend
        DEC A : BNE .shake_screen
            LDA.b #$05 : STA.w $012D
            
            LDA.b #$0D
            
            JSR.w $947F ; $0E947F IN ROM
            
            STZ.w $02E4
            
            JSR.w $90D0 ; $0E90D0 IN ROM
            
            LDA.w $0EC0, X : CMP.b #$04 : BCC Sprite4_ShowMessageMinimal_exit
                LDA.b #$0A
                
                JSR.w $947F ; $0E947F IN ROM
                
                LDA.b #$60 : STA.w $0E50, X
                
                LDA.b #$E0 : STA.w $0E10, X
                
                ; You are doing well, lad. But can you break through 
                LDA.b #$70 : STA.w $1CF0

                ; This secret technique of Darkness? En Garde!
                LDA.b #$01
                
}

; $0E907F-$0E9086 LOCAL JUMP LOCATION
Sprite4_ShowMessageMinimal:
{
    STA.w $1CF1
                
    JSL Sprite_ShowMessageMinimal
            
    .exit

    RTS
}

; $0E9087-$0E909B LOCAL JUMP LOCATION
Ganon_Phase3_DropTiles_shake_screen:
{
    AND.b #$01 : TAY
        
    LDA.w $8000, Y : STA.w $011C
    LDA.w $8002, Y : STA.w $011D
        
    LDA.b #$01 : STA.w $02E4
        
    RTS
}

; $0E909C-$0E90C3 LOCAL JUMP LOCATION
Ganon_Phase3_DropTiles_descend
{
    JSR Sprite4_MoveAltitude
    
    LDA.w $0F70, X : BPL .BRANCH_DELTA
        STZ.w $0F80, X
        STZ.w $0F70, X
        
        LDA.b #$60 : STA.w $0DF0, X
        
        LDA.b #$07 : STA.w $012D
        
        LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    .BRANCH_DELTA
    
    LDY.w $0DE0, X
    
    LDA.w $9042, Y : STA.w $0DC0, X
    
    RTS
}

; $0E90C4-$0E90CF DATA
Pool_Ganon_SpawnFallingTilesOverlord:
{
    ; $0E90C4
    .overlord_type
    #_1D90C4: db $0C ; OVERLORD 0C
    #_1D90C5: db $0D ; OVERLORD 0D
    #_1D90C6: db $0E ; OVERLORD 0E
    #_1D90C7: db $0F ; OVERLORD 0F

    ; $0E90C8
    .position_x
    #_1D90C8: db $18
    #_1D90C9: db $D8
    #_1D90CA: db $D8
    #_1D90CB: db $18

    ; $0E90CC
    .position_y
    #_1D90CC: db $28
    #_1D90CD: db $28
    #_1D90CE: db $D8
    #_1D90CF: db $D8
}

; $0E90D0-$0E910C LOCAL JUMP LOCATION
Ganon_SpawnFallingTilesOverlord:
{
    LDY.b #$07
    
    .BRANCH_BETA
    
        LDA.w $0B00, Y : BEQ .BRANCH_ALPHA
    DEY : BPL .BRANCH_BETA
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.w $0EC0, X : CMP.b #$04 : BCS .BRANCH_GAMMA
        INC.w $0EC0, X
        
        PHX
        
        TAX
        
        LDA.w $90C4, X : STA.w $0B00, Y
        LDA.w $90C8, X : STA.w $0B08, Y
        
        LDA.b $23      : STA.w $0B10, Y
        LDA.w $90CC, X : STA.w $0B18, Y
        
        LDA.b $21  : STA.w $0B20, Y
        LDA.b #$00 : STA.w $0B28, Y : STA.w $0B30, Y
        
        PLX
    
    .BRANCH_GAMMA
    
    RTS
}

; $0E9113-$0E9117 JUMP LOCATION ; 0x0C
Ganon_Phase3_FireBats:
{
    LDA.w $0DF0, X : BNE .attempt_bat_spawn
        ; Bleeds into the next function.
}

; $0E9118-$0E911D JUMP LOCATION
Ganon_Phase3_WarpSelect:
{
    LDA.b #$0D
    
    JSR.w $947F ; $0E947F IN ROM
    
    RTS
}
    
; $0E911E-$0E9157 JUMP LOCATION
Ganon_Phase3_FireBats_attempt_bat_spawn:
{
    LDY.b #$00
    
    CMP.b #$60 : BCS .BRANCH_BETA
        INY
        
        CMP.b #$48 : BCS .BRANCH_BETA
            CMP.b #$42 : BNE .BRANCH_GAMMA
                PHY
                
                JSR.w $9160 ; $0E9160 IN ROM
                
                PLY
                
            .BRANCH_GAMMA
            
            INY
    
    .BRANCH_BETA
    
    LDA.w $0DE0, X : BEQ .BRANCH_DELTA
        INY #3
    
    .BRANCH_DELTA
    
    LDA.w $910D, Y : STA.w $0DC0, X
    
    LDA.w $0EF0, X : AND.b #$7F : CMP.b #$01 : BNE .BRANCH_EPSILON
        LDA.b #$0F : STA.w $0D80, X
        
        LDA.b #$18 : STA.w $0F80, X
        
        STZ.w $0DF0, X
    
    .BRANCH_EPSILON
    
    RTS
}

; ==============================================================================

; $0E9158-$0E915B DATA
Pool_Ganon_SpawnFireBat:
{
    ; TODO: name this pool routine.
    db  0, -16
    db  0,  -1
}

; ==============================================================================

; $0E915C-$0E91D4 LOCAL JUMP LOCATION
Ganon_SpawnFireBat_trailing:
{
    LDA.b #$05
    
    BRA Ganon_SpawnFireBat
}

; $0E9160-$0E9161 LOCAL JUMP LOCATION
Ganon_SpawnFireBat_spiral:
{
    LDA.b #$03

    ; Bleeds into the next function.
}

; $0E9162-$0E91D4 LOCAL JUMP LOCATION
Ganon_SpawnFireBat:
{
    STA.w $0FB5
    
    LDA.b #$C9
    LDY.b #$08
    
    JSL Sprite_SpawnDynamically_arbitrary : BMI .spawn_failed
        LDA.b #$2A : JSL Sound_SetSfx2PanLong
        
        JSL Sprite_SetSpawnedCoords
        
        LDA.w $0FB5 : STA.w $0EC0, Y : STA.w $0BA0, Y
        
        LDA.b #$03 : STA.w $0F50, Y
        LDA.b #$40 : STA.w $0E60, Y
        LDA.b #$21 : STA.w $0E40, Y
        LDA.b #$40 : STA.w $0CAA, Y
        
        PHX
        
        LDA.w $0DE0, X : TAX
        
        LDA.b $02 : CLC : ADC.w $9158, X : STA.w $0D00, Y
        
        LDA.b $03 : ADC.w $915A, X : STA.w $0D20, Y
        
        TYX
        
        LDA.b #$20
        
        JSL Sprite_ApplySpeedTowardsPlayerLong
        
        PLX
        
        LDA.b #$10 : STA.w $0DF0, Y
        
        LDA.w $0D10 : STA.w $0D90, Y
        LDA.w $0D30 : STA.w $0DA0, Y
        LDA.w $0D00 : STA.w $0DB0, Y
        LDA.w $0D20 : STA.w $0E90, Y
        
        JMP.w Ganon_SetSpawnedEntityProperties
    
    .spawn_failed
    
    RTS
}

; $0E91D5-$0E9202 JUMP LOCATION ; 0x0E
Ganon_Phase3_SabotagePB:
{
    INC.w $0BA0, X
    
    JSR.w $9443 ; $0E9443 IN ROM
    
    STZ.w $0ED0, X
    
    LDA.w $0DF0, X : BNE .BRANCH_ALPHA
        JSL GetRandomInt : AND.b #$01 : BEQ .BRANCH_BETA
            JMP.w $9118 ; $0E9118 IN ROM
        
        .BRANCH_BETA
        
        LDA.b #$7F : STA.w $0DF0, X
        
        LDA.b #$0C : STA.w $0D80, X
        
        RTS
    
    .BRANCH_ALPHA
    
    AND.b #$01 : BEQ .BRANCH_GAMMA
        LDA.b #$FF : STA.w $0DC0, X
    
    .BRANCH_GAMMA
    
    RTS
}

; $0E9203-$0E9230 JUMP LOCATION ; 0x07
Ganon_Phase2_CircleOfBats:
{
    LDA.w $0E50, X : CMP.b #$A1 : BCS .BRANCH_ALPHA
        LDA.b #$A0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    LDA.b #$28 : STA.w $0B0A
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        LDA.b #$08 : STA.w $0D80, X
        
        LDA.b #$FF : STA.w $0DF0, X
        
        RTS
        
    .BRANCH_BETA
    
    CMP.b #$C0 : BCS .BRANCH_GAMMA
    AND.b #$0F : BNE .BRANCH_GAMMA
        JSR.w $8E7C   ; $0E8E7C IN ROM
    
    .BRANCH_GAMMA
    
    BRA Ganon_HandleTridentAndSpiral
}

; $0E9248-$0E9287 JUMP LOCATION ; 0x08
Ganon_Phase2_LaunchSpiralBats:
{
    LDA.w $0E50, X : CMP.b #$A1 : BCS .BRANCH_ALPHA
        LDA.b #$A0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        LDA.b #$09 : STA.w $0D80, X
        
        LDA.b #$7F : STA.w $0DF0, X
        
        JSR.w $9443 ; $0E9443 IN ROM
        
        LDY.b #$08
        
        .BRANCH_GAMMA
        
            LDA.b #$02 : STA.w $0D80, Y
        
            LDA.w $9240, Y : STA.w $0DF0, Y
        DEY : BNE .BRANCH_GAMMA
        
        RTS
    
    .BRANCH_BETA
    
    LSR #4 : AND.b #$0F : TAY
    
    LDA.w $0B0A : CLC : ADC.w $9231, Y : STA.w $0B0A

    ; Bleeds into the next function.
}

; $0E9288-$0E928E JUMP LOCATION
Ganon_HandleTridentAndSpiral:
{
    JSR.w $93DB ; $0E93DB IN ROM
    JSR.w $8D70 ; $0E8D70 IN ROM
    
    RTS
}

; $0E928F-$0E92A9 JUMP LOCATION ; 0x09
{
    LDA.w $0E50, X : CMP.b #$A1 : BCS .BRANCH_ALPHA
        LDA.b #$A0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        LDA.b #$0A
        
        JSR.w $947F ; $0E947F IN ROM
        
        RTS
    
    .BRANCH_BETA
    
    JSR.w $94BA ; $0E94BA IN ROM
    
    RTS
}

; $0E92AA-$0E92B4 JUMP LOCATION ; 0x0B
Ganon_Phase2_MakePhaseDecision:
{
    INC.w $0BA0, X
    
    JSR.w $9443 ; $0E9443 IN ROM
    
    LDA.w $0DF0, X : BNE Ganon_AdvanceToPhase2_wait
        ; Bleeds into the next function.
}

; $0E92B5-$0E92C9 JUMP LOCATION
Ganon_AdvanceToPhase2:
{  
    LDA.b #$FF : STA.w $0DF0, X
        
    LDA.b #$07 : STA.w $0D80, X
        
    RTS
    
    .wait
    
    AND.b #$01 : BEQ .exit
        LDA.b #$FF : STA.w $0DC0, X
    
    .exit
    
    RTS
}

; $0E92CA-$0E92CE LOCAL JUMP LOCATION ; 0x00
Ganon_Phase1_IntroduceSelf:
{
    ; Is the timer still going?
    LDA.w $0DF0, X : BNE .let_iron_cool_before_striking
        ; Bleeds into the next function.
}

; $0E92CF-$0E92D9 LOCAL JUMP LOCATION
Ganon_ContinueWithPhase1:
{
    ; Otherwise jump to the next step in the AI table.
    LDA.b #$01 : STA.w $0D80, X
    
    ; Set up a delay of #$80 frames till the next mode activates.
    ; (little over 1 s)
    LDA.b #$80 : STA.w $0DF0, X
    
    RTS
}

; $0E92DA-$0E92F6 LOCAL JUMP LOCATION
Ganon_Phase1_IntroduceSelf_let_iron_cool_before_striking:
{
    ; At the #$20th frame, change the music.
    CMP.b #$20 : BEQ .BRANCH_BETA
        CMP.b #$40 : BNE .BRANCH_GAMMA ; On the 0x40th frame (in the countdown)
            ; I never imagined a boy like you could give me so much trouble...
            LDA.b #$6F : STA.w $1CF0
            LDA.b #$01 : STA.w $1CF1
            
            JSL Sprite_ShowMessageMinimal
        
        .BRANCH_GAMMA
        
        RTS
        
    .BRANCH_BETA
    
    ; Play the song, "Ganondorf the Thief".
    LDA.b #$1F : STA.w $012C
    
    RTS
}

; $0E9341-$0E9353 BRANCH LOCATION
Ganon_Phase1_TryAWarp:
{
    CMP.b #$00 : BNE .BRANCH_ALPHA
        LDA.b #$05
        
        JMP.w $947F ; $0E947F IN ROM
    
    .BRANCH_ALPHA
    
    LDY.w $0DE0, X
    
    LDA.w $933F, Y : STA.w $0DC0, X
    
    RTS
}

; $0E9354-$0E93DA JUMP LOCATION ; 0x01
Ganon_Phase1_ThrowTrident:
{
    LDA.w $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
        ; Once Gannon takes enough damage fix his health at #$D0.
        LDA.b #$D0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    ; If the timer has >= 0x40 frames, then spin ze trident.
    LDA.w $0DF0, X : CMP.b #$40 : BCS .BRANCH_E9341  BNE .BRANCH_BETA
        STZ.w $0ED0, X
        
        LDA.b #$C9
        
        JSL Sprite_SpawnDynamically
        
        PHX
        
        LDA.w $0DE0, X : TAX
        
        LDA.b $00 : CLC : ADC.w $9317, X : STA.w $0D10, Y
        LDA.b $01 : ADC.w $9319, X : STA.w $0D30, Y
        
        LDA.b $02 : CLC : ADC.w $931B, X : STA.w $0D00, Y
        LDA.b $03 : ADC.w $931D, X : STA.w $0D20, Y
        
        PLX
        
        PHX : PHY
        
        LDA.b #$1F : JSL Sprite_ApplySpeedTowardsPlayerLong
        
        JSL Sprite_ConvertVelocityToAngle
        PLY : SEC : SBC.b #$02 : AND.b #$0F : TAX
        
        LDA.w $931F, X : STA.w $0D50, Y
        
        LDA.w $932F, X : STA.w $0D40, Y
        
        PLX
        
        LDA.b #$70 : STA.w $0DF0, Y
        
        LDA.b #$02 : STA.w $0EC0, Y
        
        LDA.b #$01 : STA.w $0F50, Y
        
        LDA.b #$04 : STA.w $0E40, Y
        
        LDA.b #$84 : STA.w $0CAA, Y
        
        LDA.b #$02 : STA.w $0DE0, Y
        
        JMP.w Ganon_SetSpawnedEntityProperties
    
    .BRANCH_BETA

    ; Bleeds into the next function.
}

; $0E93DB-$0E93FA JUMP LOCATION ALTERNATE ENTRY POINT
Ganon_Phase1_AnimateTridentSpin:
{
    LDA.w $0DF0, X : LSR #2 : AND.b #$07
        LDY.w $0DE0, X : BEQ .BRANCH_GAMMA
        
        CLC : ADC.b #$08
    
    .BRANCH_GAMMA
    
    TAY
    
    LDA.w $92F7, Y : STA.w $0ED0, X
    
    LDA.w $9307, Y : STA.w $0DC0, X
    
    JSR Sprite_PeriodicWhirringSfx
    
    RTS
}

; ==============================================================================

; $0E93FB-$0E93FC DATA
Ganon_Phase1_WaitForTrident_animation_states:
{
    db 0, 8
}

; $0E93FD-$0E9423 JUMP LOCATION ; 0x02
Ganon_Phase1_WaitForTrident:
{
    LDA.w $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
        LDA.b #$D0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    LDY.w $0DE0, X
    
    LDA.w $93FB, Y : STA.w $0DC0, X
    
    LDA.w $0DF0, X : BEQ .BRANCH_BETA
        INC.w $0BA0, X
        
        AND.b #$01 : BEQ .BRANCH_BETA
            LDA.b #$FF : STA.w $0DC0, X

    .BRANCH_BETA

    RTS
}

; ==============================================================================

; $0E9424-$0E9427 DATA
pool_Ganon_Phase1_MakePhaseDecision:
{
    ; $0E9424
    .timer
    db 9, 10

    ; $0E9426
    .draw
    db $02, $0A
}

; $0E9428-$0E9442 JUMP LOCATION ; 0x03
Ganon_Phase1_MakePhaseDecision:
{
    LDA.w $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
        LDA.b #$D0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE Ganon_HandleAnimation_delay_animation
        LDA.b #$06 : STA.w $0D80, X
        
        LDA.b #$7F : STA.w $0DF0, X

        ; Bleeds into the next function.
}

; $0E9443-$0E9459 JUMP LOCATION
Ganon_HandleAnimation:
{
    .Idle

    LDY.w $0DE0, X
    
    LDA.w $9424, Y : STA.w $0ED0, X
    
    ; $0E944C ALTERNATE ENTRY POINT
    .IdleUntimed
    
    LDY.w $0DE0, X
    
    LDA.w $9426, Y : STA.w $0DC0, X
    
    RTS
    
    .delay_animation
    
    JSR.w $93DB ; $0E93DB IN ROM
    
    RTS
}

; $0E945A-$0E946C DATA
Ganon_HeadShakeStep:
{
    db $00, $00, $00, $01
    db $02, $02, $02, $01
    db $00, $00, $00, $01
    db $01, $01, $01, $01
    db $00, $10
}

; $0E946C-$0E947E JUMP LOCATION ; 0x04
Ganon_Phase1_Warp:
{
    LDA.w $0E50, X : CMP.b #$D1 : BCS .hp_fine
        LDA.b #$D0 : STA.w $0E50, X
    
    .hp_fine
    
    LDA.w $0DF0, X : BNE Ganon_ShakeHead
        LDA.b #$05

        ; Bleeds into the next function.
}


; $0E947F-$0E94B9 JUMP LOCATION
Ganon_SelectWarpLocation:
{
    STA.b $00
        
    LDA.w $0E30, X : ASL #2 : STA.b $01
        
    JSL GetRandomInt : AND.b #$03 : ORA.b $01 : TAY
        
    LDA.w $94D5, Y
        
    STA.w $0E30, X : TAY
        
    LDA.w $94C5, Y : STA.l $7FFD5C
        
    LDA.w $94CD, Y : STA.l $7FFD68
        
    LDA.b $00 : STA.w $0D80, X
        
    JSR Sprite4_Zero_XY_Velocity
        
    LDA.b #$30 : STA.w $0DF0, X
        
    LDA.b #$28 : JSL Sound_SetSfx3PanLong
        
    RTS
}

; $0E94BA-$0E94C4 JUMP LOCATION
Ganon_ShakeHead:
{
    LSR #3 : TAY
    
    LDA.w $945A, Y : STA.w $0EB0, X
    
    RTS
}

; ==============================================================================

; $0E94C5-$0E94F4 DATA
Ganon_WarpLocation:
{
    ; $0E94C5
    .X
    db $30, $50, $A0, $C0, $40, $60, $90, $B0

    ; $0E94CD
    .Y
    db $40, $30, $30, $40, $B0, $C0, $C0, $B0

    ; $0E94D5
    .ID
    db $04, $05, $06, $07, $04, $05, $06, $07
    db $04, $05, $06, $07, $04, $05, $06, $07
    db $00, $01, $02, $03, $00, $01, $02, $03
    db $00, $01, $02, $03, $00, $01, $02, $03
}

; $0E94F5-$0E955E JUMP LOCATION ; 0x0D
Ganon_Phase3_Warp:
{
    ; Reset health for lights out phase
    LDA.b #$64 : STA.w $0E50, X

    ; Bleeds into the next funciton.
}

; $0E94FA ALTERNATE ENTRY POINT  ; 0x05, 0x0A, 0x12
Ganon_LookAround:
{
    INC.w $0BA0, X
    
    LDA.l $7FFD5C  : STA.b $04
    LDA.w $0D30, X : STA.b $05
    
    LDA.l $7FFD68  : STA.b $06
    LDA.w $0D20, X : STA.b $07
    
    JSR Ganon_CheckEntityProximity : BCS Ganon_MoveWithTrident
        LDA.w $0E30, X : LSR #2 : STA.w $0DE0, X
        
        LDA.w $0D80, X : CMP.b #$05 : BEQ .BRANCH_ALPHA
            LDA.w $0E50, X : CMP.b #$A1 : BCS .BRANCH_BETA
                CMP.b #$61 : BCS .BRANCH_GAMMA
                    LDA.b #$11 : STA.w $0D80, X
                    
                    LDA.b #$68 : STA.w $0DF0, X
                    
                    RTS
            
            .BRANCH_BETA
            
            LDA.b #$0B : STA.w $0D80, X
            
            LDA.b #$28 : STA.w $0DF0, X
            
            RTS
            
            .BRANCH_GAMMA
            
            LDA.b #$0E : STA.w $0D80, X
            
            LDA.b #$28 : STA.w $0DF0, X
            
            RTS
        
        .BRANCH_ALPHA
        
        LDA.b #$02 : STA.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        RTS
        
    .unused
        
    RTS
}

; ==============================================================================

; $0E955F-$0E95AC BRANCH LOCATION
Ganon_MoveWithTrident:
{
    LDA.b #$20
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    JSR.w $8AE4 ; $0E8AE4 IN ROM
    JSR Sprite4_Move
    
    LDA.w $0DF0, X : BEQ .BRANCH_ALPHA
        LDA.b $1A : AND.b #$01 : BNE .BRANCH_ALPHA
            JSR.w $944C ; $0E944C IN ROM
            
            BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b #$FF : STA.w $0DC0, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b $1A : AND.b #$07 : BNE .BRANCH_GAMMA
        LDA.b #$D6
        
        JSL Sprite_SpawnDynamically : BMI .BRANCH_GAMMA
            JSL Sprite_SetSpawnedCoords
            
            LDA.b #$18 : STA.w $0BA0, Y : STA.w $0DF0, Y
            
            LDA.b #$FF : STA.w $0D80, Y
            
            LDA.w $0DC0, X : STA.w $0DC0, Y
            
            LDA.w $0EB0, X : STA.w $0EB0, Y
    
    .BRANCH_GAMMA
    
    RTS
}

; $0E95AD-$0E95CD JUMP LOCATION ; 0x06
Ganon_Phase2_HoldTrident:
{
    LDA.w $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
        LDA.b #$D0 : STA.w $0E50, X
    
    .BRANCH_ALPHA
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        LDA.w $0E50, X : CMP.b #$D1 : BCC .BRANCH_GAMMA
            JMP.w $92CF ; $0E92CF IN ROM
        
        .BRANCH_GAMMA
        
        JMP.w $92B5 ; $0E92B5 IN ROM
    
    .BRANCH_BETA
    
    JMP.w $94BA ; $0E94BA IN ROM
}

; ==============================================================================

; $0E95CE-$0E990E DATA
Pool_SpriteDraw_Ganon:
{
    ; $0E95CE
    .offset_x
    #_1D95CE: db  18,  -8,   8,  -8,   8, -18, -18,  18,  -8,   8,  -8,   8
    #_1D95DA: db  18,  -8,   8,  -8,   8, -18, -18,  18,  -8,   8,  -8,   8
    #_1D95E6: db  16,  -8,   8,  -8,   8, -18, -18,  16,  -8,   8, -11,  11
    #_1D95F2: db  16,  -8,   8,  -8,   8, -18, -18,  16,  -8,   8, -11,  11
    #_1D95FE: db  16,  -8,   8,  -8,   8, -18, -18,  16,  -8,   8, -11,  11
    #_1D960A: db  18,  -8,   8,  -8,   8, -18, -18,  18,  -8,   8,  -8,   8
    #_1D9616: db  18,  -8,   8,  -8,   8, -18, -18,  18,  -8,   8,  -8,   8
    #_1D9622: db  18,  -8,   8,  -8,   8, -18, -18,  18,  -8,   8, -11,  11
    #_1D962E: db  -8,   8,  -8,   8,  -8,   8,  -8,   8, -18, -18,  18,  18
    #_1D963A: db  -8,   8,  -8,   8,  -8,   8,  -8,   8, -18, -18,  18,  18
    #_1D9646: db  -8,   8,  -8,   8,  -8,   8, -10,  10, -18, -18,  18,  18
    #_1D9652: db  -8,   8,  -8,   8,  -8,   8, -10,  10, -18, -18,  18,  18
    #_1D965E: db  -8,   8,  -8,   8,  -8,   8, -10,  10, -18, -18,  18,  18
    #_1D966A: db  -8,   8,  -8,   8,  -8,   8,  -8,   8, -18, -18,  18,  18
    #_1D9676: db  -8,   8,  -8,   8,  -8,   8,  -8,   8, -18, -18,  18,  18
    #_1D9682: db  -7,  -8,   8,  -8,   8,  -9,   8, -14, -14,  -8,   8,   8
    #_1D968E: db  -8,   8,  -8,   8, -18, -18,  18,  18,  -8,   8, -11,  11

    ; $0E969A
    .offset_y
    #_1D969A: db  -8, -16, -16, -13, -13,  -9,  -1, -16,   3,   3,   8,   8
    #_1D96A6: db  -8, -16, -16, -13, -13,  -9,  -1, -16,   3,   3,   8,   8
    #_1D96B2: db   5, -10, -10, -13, -13,  -7,   1,  -3,   3,   3,   8,   8
    #_1D96BE: db   5, -10, -10, -13, -13,  -7,   1,  -3,   3,   3,   8,   8
    #_1D96CA: db   5, -10, -10, -13, -13,  -7,   1,  -3,   3,   3,   8,   8
    #_1D96D6: db  -1, -16, -16, -13, -13,  -9,  -1,  -9,   3,   3,   8,   8
    #_1D96E2: db -10, -16, -16, -13, -13, -18, -10, -18,   3,   3,   8,   8
    #_1D96EE: db   1, -10, -10, -13, -13,  -7,   1,  -7,   3,   3,   8,   8
    #_1D96FA: db -12, -12,   4,   4, -18, -18,  10,  10, -16,  -8,  -4,   4
    #_1D9706: db -12, -12,   4,   4, -18, -18,  10,  10, -16,  -8,  -4,   4
    #_1D9712: db -12, -12,   4,   4, -12, -12,  10,  10,  -4,   4,  -4,   4
    #_1D971E: db -12, -12,   4,   4, -12, -12,  10,  10,  -4,   4,  -4,   4
    #_1D972A: db -12, -12,   4,   4, -12, -12,  10,  10,  -4,   4,  -4,   4
    #_1D9736: db -12, -12,   4,   4, -18, -18,  10,  10,  -4,   4,  -4,   4
    #_1D9742: db -12, -12,   4,   4, -18, -18,  10,  10, -16,  -8, -16,  -8
    #_1D974E: db  -7, -12, -12,   4,   4,   7,  13, -11,  -4, -16, -16, -16
    #_1D975A: db -10, -10, -13, -13,  -7,  -7,  -7,  -7,   3,   3,   8,   8

    ; $0E9766
    .char
    #_1D9766: db $16, $00, $00, $02, $02, $08, $18, $06, $22, $22, $20, $20
    #_1D9772: db $46, $00, $00, $02, $02, $08, $18, $36, $22, $22, $20, $20
    #_1D977E: db $1A, $00, $00, $04, $04, $38, $48, $0A, $24, $24, $20, $20
    #_1D978A: db $1A, $40, $42, $04, $04, $38, $48, $0A, $24, $24, $20, $20
    #_1D9796: db $1A, $42, $40, $04, $04, $38, $48, $0A, $24, $24, $20, $20
    #_1D97A2: db $18, $00, $00, $02, $02, $08, $18, $08, $22, $22, $20, $20
    #_1D97AE: db $16, $6A, $6A, $0E, $0E, $06, $16, $06, $22, $22, $20, $20
    #_1D97BA: db $48, $00, $00, $04, $04, $38, $48, $38, $24, $24, $20, $20
    #_1D97C6: db $4E, $4E, $6E, $6E, $6C, $6C, $A2, $A2, $0C, $1C, $3C, $4C
    #_1D97D2: db $4E, $4E, $6E, $6E, $6C, $6C, $A2, $A2, $3A, $4A, $3C, $4C
    #_1D97DE: db $84, $84, $A4, $A4, $A0, $A0, $A2, $A2, $3C, $4C, $3C, $4C
    #_1D97EA: db $84, $84, $A4, $A4, $80, $82, $A2, $A2, $3C, $4C, $3C, $4C
    #_1D97F6: db $84, $84, $A4, $A4, $82, $80, $A2, $A2, $3C, $4C, $3C, $4C
    #_1D9802: db $4E, $4E, $6E, $6E, $6C, $6C, $A2, $A2, $3C, $4C, $3C, $4C
    #_1D980E: db $4E, $4E, $6E, $6E, $6C, $6C, $A2, $A2, $0C, $1C, $0C, $1C
    #_1D981A: db $E0, $C6, $C8, $E6, $E8, $20, $20, $08, $18, $C0, $C2, $C2
    #_1D9826: db $00, $00, $CE, $CE, $EC, $EC, $EC, $EC, $EE, $EE, $C4, $C4

    ; $0E9832
    .animstate_head
    #_1D9832: db $01, $01, $01, $01, $01, $01, $0F, $01
    #_1D983A: db $04, $04, $04, $04, $04, $04, $04, $0F
    #_1D9842: db $0F

    ; $0E9843
    .prop
    #_1D9843: db $4C, $0C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D984F: db $4C, $0C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D985B: db $4C, $0C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D9867: db $4C, $0C, $0C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D9873: db $4C, $4C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D987F: db $4C, $0C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D988B: db $4C, $0C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D9897: db $4C, $0C, $4C, $0A, $4A, $0C, $0C, $4C, $0A, $4A, $0C, $4C
    #_1D98A3: db $0A, $4A, $0A, $4A, $0C, $4C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98AF: db $0A, $4A, $0A, $4A, $0C, $4C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98BB: db $0A, $4A, $0A, $4A, $0C, $4C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98C7: db $0A, $4A, $0A, $4A, $0C, $0C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98D3: db $0A, $4A, $0A, $4A, $4C, $4C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98DF: db $0A, $4A, $0A, $4A, $0C, $4C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98EB: db $0A, $4A, $0A, $4A, $0C, $4C, $0C, $4C, $0C, $0C, $4C, $4C
    #_1D98F7: db $0C, $0A, $0A, $0A, $0A, $0C, $4C, $0C, $0C, $0C, $0C, $0C
    #_1D9903: db $0C, $4C, $0A, $4A, $0C, $0C, $4C, $4C, $0A, $4A, $0C, $4C
}

; $0E990F-$0E9A9E DATA
Trident_OAMGroups:
{
    #_1D990F: dw  10, -10 : db $64, $08, $00, $00
    #_1D9917: dw   5, -15 : db $64, $08, $00, $00
    #_1D991F: dw   0, -20 : db $64, $08, $00, $00
    #_1D9927: dw  -5, -25 : db $64, $08, $00, $00
    #_1D992F: dw -18, -38 : db $44, $08, $00, $02

    #_1D9937: dw   1,  -4 : db $65, $08, $00, $00
    #_1D993F: dw   1, -11 : db $65, $08, $00, $00
    #_1D9947: dw   1, -18 : db $65, $08, $00, $00
    #_1D994F: dw   1, -25 : db $65, $08, $00, $00
    #_1D9957: dw  -3, -40 : db $62, $08, $00, $02

    #_1D995F: dw  -8,  -9 : db $64, $48, $00, $00
    #_1D9967: dw  -3, -14 : db $64, $48, $00, $00
    #_1D996F: dw   3, -20 : db $64, $48, $00, $00
    #_1D9977: dw   9, -26 : db $64, $48, $00, $00
    #_1D997F: dw  12, -37 : db $44, $48, $00, $02

    #_1D9987: dw -10, -20 : db $74, $48, $00, $00
    #_1D998F: dw  -3, -20 : db $74, $48, $00, $00
    #_1D9997: dw   4, -20 : db $74, $48, $00, $00
    #_1D999F: dw  11, -20 : db $74, $48, $00, $00
    #_1D99A7: dw  18, -23 : db $60, $48, $00, $02

    #_1D99AF: dw -10, -30 : db $64, $C8, $00, $00
    #_1D99B7: dw  -4, -24 : db $64, $C8, $00, $00
    #_1D99BF: dw   2, -18 : db $64, $C8, $00, $00
    #_1D99C7: dw   8, -12 : db $64, $C8, $00, $00
    #_1D99CF: dw  12,  -8 : db $44, $C8, $00, $02

    #_1D99D7: dw   1, -32 : db $65, $88, $00, $00
    #_1D99DF: dw   1, -25 : db $65, $88, $00, $00
    #_1D99E7: dw   1, -18 : db $65, $88, $00, $00
    #_1D99EF: dw   1, -11 : db $65, $88, $00, $00
    #_1D99F7: dw  -3,  -5 : db $62, $88, $00, $02

    #_1D99FF: dw  13, -30 : db $64, $88, $00, $00
    #_1D9A07: dw   8, -25 : db $64, $88, $00, $00
    #_1D9A0F: dw   2, -19 : db $64, $88, $00, $00
    #_1D9A17: dw  -4, -13 : db $64, $88, $00, $00
    #_1D9A1F: dw -16,  -9 : db $44, $88, $00, $02

    #_1D9A27: dw  14, -20 : db $74, $08, $00, $00
    #_1D9A2F: dw   7, -20 : db $74, $08, $00, $00
    #_1D9A37: dw   0, -20 : db $74, $08, $00, $00
    #_1D9A3F: dw  -7, -20 : db $74, $08, $00, $00
    #_1D9A47: dw -21, -23 : db $60, $08, $00, $02

    #_1D9A4F: dw  13, -30 : db $64, $88, $00, $00
    #_1D9A57: dw   8, -25 : db $64, $88, $00, $00
    #_1D9A5F: dw   2, -19 : db $64, $88, $00, $00
    #_1D9A67: dw  -4, -13 : db $64, $88, $00, $00
    #_1D9A6F: dw -16,  -9 : db $44, $88, $00, $02

    #_1D9A77: dw -10, -30 : db $64, $C8, $00, $00
    #_1D9A7F: dw  -4, -24 : db $64, $C8, $00, $00
    #_1D9A87: dw  -4, -24 : db $64, $C8, $00, $00
    #_1D9A8F: dw  -4, -24 : db $64, $C8, $00, $00
    #_1D9A97: dw  -4, -24 : db $64, $C8, $00, $00
}

; $0E9A9F-$0E9AB2 DATA
GanonTridentOAM:
{
    .offset_x
    #_1D9A9F: db  24,   0, -16,  -1,   0
    #_1D9AA4: db   0,  16,   0,  -8,  -1

    .offset_y
    #_1D9AA9: db   4,   0,   4,   0,  16
    #_1D9AAE: db   0,  21,   0,  19,   0
}

; $0E9AB3-$0E9ACA DATA
GanonHeadOAM:
{
    .char
    #_1D9AB3: db $40, $42, $00, $00
    #_1D9AB7: db $42, $40, $82, $80
    #_1D9ABB: db $A0, $A0, $80, $82

    .prop
    #_1D9ABF: db $00, $00, $00, $40
    #_1D9AC3: db $40, $40, $40, $40
    #_1D9AC7: db $00, $40, $00, $00
}

; $0E9ACB-$0E9ADA DATA
Ganon_ArmOAMGroups:
{
    #_1D9ACB: dw  16,  -3 : db $0A, $4C, $00, $02
    #_1D9AD3: dw  16,   5 : db $1A, $4C, $00, $02
}

; ==============================================================================

; $0E9ADB-$0E9ADE BRANCH LOCATION
DontDrawGanon:
{
    JSR Sprite4_PrepOamCoord
    
    RTS
}

; ==============================================================================

; $0E9ADF-$0E9C1B LOCAL JUMP LOCATION
SpriteDraw_Ganon:
{
    LDA.w $0DC0, X : BMI DontDrawGanon
        LDA.w $0D80, X : CMP.b #$13 : BEQ .BRANCH_ALPHA
            LDA.w $0F10, X : BNE .BRANCH_ALPHA
                LDA.w $04C5 : BEQ DontDrawGanon
        
        .BRANCH_ALPHA
        
        JSR Trident_Draw
        JSR Sprite4_PrepOamCoord
        
        ; There are much better combinations of instructions that produce
        ; multiplication by 12, guys...
        LDA.w $0DC0, X : ASL #3
        
        ADC.w $0DC0, X : ADC.w $0DC0, X
        ADC.w $0DC0, X : ADC.w $0DC0, X
        STA.b $06
        
        PHX
        
        LDX.b #$00
        LDY.b #$14
        
        .BRANCH_GAMMA
        
        PHX
        
        TXA : CLC : ADC.b $06 : TAX
        
        LDA.b $00      : CLC : ADC.w $95CE, X       : STA ($90), Y
        LDA.b $02      : CLC : ADC.w $969A, X : INY : STA ($90), Y
        LDA.w $9766, X                        : INY : STA ($90), Y
        
        LDA.b $05 : AND.b #$0F : CMP.b #$05 : LDA.w $9843, X : BCC .BRANCH_BETA
            AND.b #$F0
        
        .BRANCH_BETA
        
        ORA.b $05 : INY : STA ($90), Y
        
        PHY : TYA : LSR #2 : TAY
        
        LDA.b #$02 : STA ($92), Y
        
        PLY : INY
        
        PLX : INX : CPX.b #$0C : BNE .BRANCH_GAMMA
        
        PLX
        
        LDY.w $0DC0, X
        
        LDA.w $9832, Y : CMP.b #$0F : BEQ .BRANCH_DELTA
        
        ASL #2 : CLC : ADC.b #$14 : TAY : INY #2
        
        PHX : PHY
        
        LDA.w $0EB0, X : ASL A
        
        LDY.w $0DE0, X : BEQ .BRANCH_EPSILON
        
        CLC : ADC.b #$06
        
        .BRANCH_EPSILON
        
        TAX
        
        PLY
        
        LDA.w $9AB3, X : STA ($90), Y : INY
        
        LDA ($90), Y : AND.b #$3F : ORA.w $9ABF, X : STA ($90), Y
        
        INY #3
        
        LDA.w $9AB4, X : STA ($90), Y
        
        INY
        
        LDA ($90), Y : AND.b #$3F : ORA.w $9AC0, X : STA ($90), Y
        
        PLX
        
        .BRANCH_DELTA
        
        LDA.b $11 : BEQ .BRANCH_ZETA
        
        LDY.b #$FF
        LDA.b #$09
        
        JSL Sprite_CorrectOamEntriesLong
        
        .BRANCH_ZETA
        
        LDA.w $0ED0, X : CMP.b #$09 : BNE .BRANCH_THETA
        
        REP #$20
        
        LDA.w #$9ACB : STA.b $08
        
        LDA.w #$0828 : STA.b $90
        
        LDA.w #$0A2A : STA.b $92
        
        SEP #$20
        
        LDA.b #$02
        
        JSR Sprite4_DrawMultiple
        
        .BRANCH_THETA
        
        LDA.w $0F70, X : SEC : SBC.b #$01 : STA.b $0E
        LDA.b #$00   : SBC.b #$00 : STA.b $0F
        
        LSR #3 : TAY : CPY.b #$04 : BCC .BRANCH_IOTA
        
        LDY.b #$04
        
        .BRANCH_IOTA
        
        LDA.w $D180, Y : STA.b $00 : STZ.b $01
        
        REP #$20
        
        LDA.w $0FDA : CLC : ADC.b $0E : STA.w $0FDA
        
        LDA.w #$09F4 : STA.b $90
        
        LDA.w #$0A9D : STA.b $92
        
        LDA.w #$D108 : CLC : ADC.b $00 : STA.b $08
        
        SEP #$20
        
        LDA.w $0F50, X : PHA
        
        STZ.w $0F50, X
        
        LDA.b #$30 : STA.w $0B89, X
        
        LDA.b #$03
        
        JSR Sprite4_DrawMultiple
        
        PLA : STA.w $0F50, X
        
        JSL Sprite_Get_16_bit_CoordsLong
        
        RTS
}

; ==============================================================================

; $0E9C1C-$0E9C79 LOCAL JUMP LOCATION
Trident_Draw:
{
    LDA.b #$00 : XBA
    
    LDA.w $0ED0, X : BEQ .dont_draw
    
    DEC A : REP #$20 : ASL #3 : STA.b $00
    
    ASL #2 : CLC : ADC.b $00 : CLC : ADC.w #$990F : STA.b $08
    
    SEP #$20
    
    LDY.b #$06 : LDA.w $0ED0, X : CMP.b #$09 : BEQ .BRANCH_BETA
    LDY.b #$08                             : BCS .BRANCH_BETA
    
    LDA.w $0DE0, X : ASL A : TAY
    
    .BRANCH_BETA
    
    REP #$20
    
    LDA.w $0FD8 : CLC : ADC.w $9A9F, Y : STA.w $0FD8
    
    LDA.w $0FDA : CLC : ADC.w $9AA9, Y : STA.w $0FDA
    
    SEP #$20
    
    LDA.w $0B89, X : PHA : AND.b #$F0 : STA.w $0B89, X
    
    LDA.b #$05 : JSR Sprite4_DrawMultiple
    
    PLA : STA.w $0B89, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    .dont_draw
    
    RTS
}

; ==============================================================================
