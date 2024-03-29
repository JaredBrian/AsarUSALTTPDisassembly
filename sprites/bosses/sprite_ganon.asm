
; ==============================================================================

; $0E8D06-$0E8D28 LOCAL JUMP LOCATION
Ganon_CheckEntityProximity:
{
    REP #$20
    
    LDA $0FD8 : SEC : SBC $04 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
    
    LDA $0FDA : SEC : SBC $06 : CLC : ADC.w #$0004 : CMP.w #$0008 : BCS .BRANCH_ALPHA
    
    .BRANCH_ALPHA
    
    SEP #$20
    
    RTS
}

; ==============================================================================

; $0E8D29-$0E8D3F LONG JUMP LOCATION
Ganon_Initialize:
{
    PHB : PHK : PLB
    
    JSR $9443   ; $0E9443 IN ROM
    
    LDA.b #$80 : STA $0DF0, X
    
    LDA.b #$02 : STA $0C9A, X
    
    LDA.b #$1E : STA $012C
    
    PLB
    
    RTL
}

; ==============================================================================

; $0E8D70-$0E8E74 LOCAL JUMP LOCATION
{
    LDA.b #$FC : CLC : ADC $0B08 : STA $0B08
    LDA.b #$FF : ADC $0B09 : STA $0B09
    
    STZ $0FB5
    
    PHX
    
    ; $0E8D85 ALTERNATE ENTRY POINT
    
    LDA $0FB5 : TAX : ASL A : TAY
    
    REP #$20
    
    LDA $0B08 : CLC : ADC $8D40, Y : AND.w #$01FF : STA $00 : LSR #5 : TAY
    
    SEP #$20
    
    LDA $0D81, X : CMP.b #$02 : BEQ .BRANCH_ALPHA
    
    TYA : SEC : SBC.b #$04 : AND.b #$0F : TAY
    
    LDA.w $8D50, Y : STA $0D51, X
    
    ASL A : PHP : ROR $0D51, X : PLP : ROR $0D51, X
    
    LDA.w $8D60, Y : STA $0D41, X
    
    ASL A : PHP : ROR $0D41, X : PLP : ROR $0D41, X
    
    .BRANCH_ALPHA
    
    LDA $0B0A : STA $0F
    
    PHX
    
    REP #$30
    
    LDA $00 : AND.w #$00FF : ASL A : TAX
    
    LDA $04E800, X : STA $04
    
    LDA $00 : CLC : ADC.w #$0080 : STA $02
    
    AND.w #$00FF : ASL A : TAX
    
    LDA $04E800, X : STA $06
    
    SEP #$30
    
    PLX
    
    LDA $04 : STA $4202
    
    LDA $0F
    
    LDY $05 : BNE .BRANCH_BETA
    
    STA $4203
    
    JSR $8E75   ; $0E8E75 IN ROM
    
    ASL $4216
    
    LDA $4217 : ADC.b #$00
    
    .BRANCH_BETA
    
    LSR $01 : BCC .BRANCH_GAMMA
    
    EOR.b #$FF : INC A
    
    .BRANCH_GAMMA
    
    STZ $0A
    
    CMP.b #$00 : BPL .BRANCH_DELTA
    
    DEC $0A
    
    .BRANCH_DELTA
    
    CLC : ADC $0D10 : STA $0B11, X
    LDA $0D30 : ADC $0A : STA $0B21, X
    
    LDA $06 : STA $4202
    
    LDA $0F
    
    LDY $07 : BNE .BRANCH_EPSILON
    
    STA $4203
    
    JSR $8E75   ; $0E8E75 IN ROM
    
    ASL $4216
    
    LDA $4217 : ADC.b #$00
    
    .BRANCH_EPSILON
    
    LSR $03 : BCC .BRANCH_ZETA
    
    EOR.b #$FF : INC A
    
    .BRANCH_ZETA
    
    STZ $0A
    
    CMP.b #$00 : BPL .BRANCH_THETA
    
    DEC $0A
    
    .BRANCH_THETA
    
    CLC : ADC $0D00           : STA $0B31, X
     LDA $0D20 : ADC $0A : STA $0B41, X
    
    INC $0FB5 : LDA $0FB5 : CMP.b #$08 : BEQ .BRANCH_IOTA
    
    JMP $8D85   ; $0E8D85 IN ROM
    
    .BRANCH_IOTA
    
    PLX
    
    RTS
}

; $0E8E75-$0E8E7B LOCAL JUMP LOCATION
{
    NOP #6
    
    RTS
}

; $0E8E7C-$0E8EB3 LOCAL JUMP LOCATION
{
    LDA.b #$C9
    LDY.b #$08
    
    JSL Sprite_SpawnDynamically_arbitrary : BMI .BRANCH_ALPHA
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$04 : STA $0EC0, Y
    LDA.b #$03 : STA $0F50, Y
    LDA.b #$40 : STA $0E60, Y
    LDA.b #$01 : STA $0E40, Y
    LDA.b #$80 : STA $0CAA, Y : STA $0D20, Y
    LDA.b #$30 : STA $0DF0, Y
    
    ; $0E8EAB ALTERNATE ENTRY POINT
    
    LDA.b #$07 : STA $0CD2, Y : STA $0BA0, Y
    
    .BRANCH_ALPHA
    
    RTS
}

; $0E8EB4-$0E8ECA LOCAL JUMP LOCATION
Sprite_Ganon:
{
    ; CODE FOR GANON
    
    ; Load the AI pointer
    ; If >= 0, branch to another routine.
    LDA $0D80, X : BPL .BRANCH_$E8ECF
    
    JSR Sprite4_CheckIfActive
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    ; Kill Ganon
    STZ $0DD0, X
    
    .BRANCH_ALPHA
    
    LSR A : BCS .BRANCH_BETA
    
    JSR $9ADF ; $0E9ADF IN ROM; Routine that draws Ganon to screen.
    
    .BRANCH_BETA
    
    RTS
}

; $0E8ECB-$0E8ECE DATA TABLE
{
    db $02, $00, $10, $0A
}

; $0E8ECF-$0E8F89 BRANCH LOCATION
{
    LDA $0F10, X : BEQ .BRANCH_ALPHA
    
    ; If 0, Ganon faces down, if 1, Ganon faces up.
    LDY $0DE0, X
    
    ; $E8ECD, Y THAT IS (DIFFERENT POSES FOR GANON)
    LDA.w $8ECD, Y : STA $0DC0, X
    
    .BRANCH_ALPHA
    
    ; A state having to do with whether Ganon can be hit. Also affects translucency.
    ; 2 means he is hittable and fully visible.
    LDA $04C5 : CMP.b #$02 : BNE .BRANCH_BETA; // basically, we can't hit ganon.
    
    CMP $0C9A, X : BEQ .BRANCH_BETA
    
    PHA
    
    ; Another delay timer. For Ganon, this occurs when you "turn the lights on and he puts his cape over his face for a few seconds."
    LDA.b #$40 : STA $0E00, X
    
    PLA
    
    .BRANCH_BETA
    
    STA $0C9A, X
    
    JSR $9ADF ; $0E9ADF IN ROM; Routine that draws Ganon to screen.
    
    LDA $0E00, X : BEQ .BRANCH_GAMMA
    
    LDA.b #$0F : STA $0DC0, X
    
    JSR $8FFA ; $0E8FFA IN ROM; Causes Gannon to be vulnerable to silver arrows.
    
    JMP Sprite4_CheckDamage
    
    .BRANCH_GAMMA
    
    JSR Sprite4_CheckIfActive
    
    LDA $0E10, X : BEQ .BRANCH_DELTA
    CMP.b #$10   : BEQ .BRANCH_EPSILON
    CMP.b #$01   : BNE .BRANCH_DELTA
    
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
    
    LDA $0F : ADC.b #$20 : CMP.b #$40 : LDA.b #$01 : BCC .BRANCH_ZETA
    
    LDA.w $8ECB, Y
    
    .BRANCH_ZETA
    
    STA $0EB0, X
    
    LDA $0F10, X : BEQ .BRANCH_THETA
    
    STA $0BA0, X
    
    JSR Sprite4_CheckIfRecoiling
    
    STZ $0DF0, X
    
    RTS
    
    .BRANCH_THETA
    
    LDA $0BA0, X : ORA $02E4 : BNE .BRANCH_IOTA
    
    LDA $04C5 : CMP.b #$02 : BNE .BRANCH_IOTA
    
    JSR Sprite4_CheckDamage
    
    .BRANCH_IOTA
    
    STZ $0BA0, X
    
    LDA $0D80, X ; Load the AI pointer, the main control for Ganon.
    
    JSL UseImplicitRegIndexedLocalJumpTable
    
    ; Beginning Trident phase
    dw $92CA ; = $E92CA* ; 0x00 Sets up the initial Ganon text, and his music.
    dw $9354 ; = $E9354* ; 0x01 Spin trident? ; Yes
    dw $93FD ; = $E93FD* ; 0x02 Wait to catch trident
    dw $9428 ; = $E9428* ; 0x03 Catch trident
    dw $946C ; = $E946C* ; 0x04 This one is never called from here but is still hit somehow. This doesn't allow link to damage ganon below a certain health durring a phase change?
    dw $94FA ; = $E94FA* ; 0x05 Blinky blinky across room 
    dw $95AD ; = $E95AD* ; 0x06 Wait for a sec and look side to side

    ; Fire bat ring phase
    dw $9203 ; = $E9203* ; 0x07 Spin trident and spawn ring of fire bats
    dw $9248 ; = $E9248* ; 0x08 Ring grows and shrinks
    dw $928F ; = $E928F* ; 0x09 Fire bats activate and target link
    dw $94FA ; = $E94FA* ; 0x0A Blinky blinky across room 
    dw $92AA ; = $E92AA* ; 0x0B Arrives at location from blinky blinky

    ; Breaking the floor phase
    dw $9113 ; = $E9113* ; 0x0C Spawns spinning fire bat that leave fire trail unless hit by link
    dw $94F5 ; = $E94F5* ; 0x0D Blinky blinky across room + limit health
    dw $91D5 ; = $E91D5* ; 0x0E Arrives at location and rolls the dice to see if he blinky blinkys again
    dw $9018 ; = $E9018* ; 0x0F Starts Jump
    dw $9044 ; = $E9044* ; 0x10 Lands from jump and trigger floor falling

    ; Lights out phase
    dw $8FBC ; = $E8FBC* ; 0x11 Shoot fire bat in straight line at link
    dw $94FA ; = $E94FA* ; 0x12 Blinky blinky across room 
    dw $8F8C ; = $E8F8C* ; 0x13 Hit by link and vunerable to silver arrows
}

; ==============================================================================

; $0E8F8A-$0E8F8B DATA
{
    ; \task Name this routine / pool.
    .animation_states
    db 5, 13
}

; ==============================================================================

; $0E8F8C-$0E8FB7 LOCAL JUMP LOCATION ; 0x13
{
    LDA.b #$05 : STA $0F50, X
    LDA.b #$02 : STA $0B6B, X
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.b #$01 : STA $0F50, X
    
    LDA.b #$12
    
    JSR $947F ; $0E947F IN ROM
    
    LDA.b #$D6 : STA $0E20, X
    
    STZ $0EF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDY $0DE0, X
    
    LDA .animation_states, Y : STA $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E8FB8-$0E8FBD DATA
{
    ; \task Name this pool / routine.
    .animation_states
    db 6, 14, 7, 10
}

; ==============================================================================

; $0E8FBC-$0E9015 JUMP LOCATION ; 0x11
{
    LDY $0DE0, X
    
    LDA .animation_states, Y : STA $0DC0, X
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    LDA.b #$12
    
    JSR $947F   ; $0E947F IN ROM
    
    RTS
    
    .BRANCH_ALPHA
    
    CMP.b #$34 : PHP : BNE .BRANCH_BETA
    
    JSR $915C   ; $0E915C IN ROM
    
    .BRANCH_BETA
    
    PLP : BCS .BRANCH_GAMMA
    
    LDY $0DE0, X
    
    LDA.w $8FBA, Y : STA $0DC0, X
    
    .BRANCH_GAMMA
    
    LDA $0DF0, X
    
    CMP.b #$48 : BCS .BRANCH_DELTA
    CMP.b #$28 : BCS .BRANCH_EPSILON
    
    .BRANCH_DELTA
    
    INC $0BA0, X
    
    LSR A : BCC .BRANCH_EPSILON
    
    LDA.b #$FF : STA $0DC0, X
    
    ; *$E8FFA ALTERNATE ENTRY POINT
    .BRANCH_EPSILON
    
    LDA $0EF0, X : AND.b #$7F : CMP.b #$1A : BNE .BRANCH_ZETA
    
    STZ $0EF0, X
    
    LDA.b #$13 : STA $0D80, X
    
    LDA.b #$7F : STA $0DF0, X
    
    LDA.b #$D7 : STA $0E20, X

    .BRANCH_ZETA

    RTS
}

; ==============================================================================

; $0E9016-$0E9017 DATA
{
    .animation_states
    db 6, 14
}

; ==============================================================================

; $0E9018-$0E9041 JUMP LOCATION ; 0x0F
{
    LDA $0DF0, X : BEQ .BRANCH_ALPHA
    DEC A        : BNE .BRANCH_BETA
    
    LDA.b #$10 : STA $0D80, X
    
    LDA.b #$A0 : STA $0F80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    JSR Sprite4_MoveAltitude
    
    DEC $0F80, X : BNE .BRANCH_BETA
    
    LDA.b #$20 : STA $0DF0, X
    
    .BRANCH_BETA
    
    LDY $0DE0, X
    
    LDA .animation_states, Y : STA $0DC0, X
    
    RTS
}

; ==============================================================================

; $0E9042-$0E9043 DATA
{
    ; \task Name this routine / pool.
    .animation_states
    db 2, 10
}

; ==============================================================================

; $0E9044-$0E90C3 JUMP LOCATION ; 0x10
{
    STZ $011C
    STZ $011D
    
    LDA $0DF0, X : BEQ .BRANCH_ALPHA
    DEC A        : BNE .BRANCH_BETA
    
    LDA.b #$05 : STA $012D
    
    LDA.b #$0D
    
    JSR $947F   ; $0E947F IN ROM
    
    STZ $02E4
    
    JSR $90D0   ; $0E90D0 IN ROM
    
    LDA $0EC0, X : CMP.b #$04 : BCC .BRANCH_GAMMA
    
    LDA.b #$0A
    
    JSR $947F   ; $0E947F IN ROM
    
    LDA.b #$60 : STA $0E50, X
    
    LDA.b #$E0 : STA $0E10, X
    
    LDA.b #$70 : STA $1CF0 ; You are doing well, lad. But can you break through 
    LDA.b #$01             ; this secret technique of Darkness? En Garde!
    
    ; $0E907F ALTERNATE ENTRY POINT ; Is it alternate entry point? i don't see it referenced anywhere else..
    shared Sprite4_ShowMessageMinimal:
    
                 STA $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    .BRANCH_GAMMA

    RTS
    
    .BRANCH_BETA
    
    AND.b #$01 : TAY
    
    LDA.w $8000, Y : STA $011C
    LDA.w $8002, Y : STA $011D
    
    LDA.b #$01 : STA $02E4
    
    RTS
    
    .BRANCH_ALPHA
    
    JSR Sprite4_MoveAltitude
    
    LDA $0F70, X : BPL .BRANCH_DELTA
    
    STZ $0F80, X
    STZ $0F70, X
    
    LDA.b #$60 : STA $0DF0, X
    
    LDA.b #$07 : STA $012D
    
    LDA.b #$0C : JSL Sound_SetSfx2PanLong
    
    .BRANCH_DELTA
    
    LDY $0DE0, X
    
    LDA.w $9042, Y : STA $0DC0, X
    
    RTS
}

; $0E90D0-$0E910C LOCAL JUMP LOCATION
{
    LDY.b #$07
    
    .BRANCH_BETA
    
    LDA $0B00, Y : BEQ .BRANCH_ALPHA
    
    DEY : BPL .BRANCH_BETA
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA $0EC0, X : CMP.b #$04 : BCS .BRANCH_GAMMA
    
    INC $0EC0, X
    
    PHX
    
    TAX
    
    LDA.w $90C4, X : STA $0B00, Y
    LDA.w $90C8, X : STA $0B08, Y
    
    LDA $23      : STA $0B10, Y
    LDA.w $90CC, X : STA $0B18, Y
    
    LDA $21    : STA $0B20, Y
    LDA.b #$00 : STA $0B28, Y : STA $0B30, Y
    
    PLX
    
    .BRANCH_GAMMA
    
    RTS
}

; $0E9113-$0E9157 JUMP LOCATION ; 0x0C
{
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    ; $0E9118 ALTERNATE ENTRY POINT
    
    LDA.b #$0D
    
    JSR $947F   ; $0E947F IN ROM
    
    RTS
    
    .BRANCH_ALPHA
    
    LDY.b #$00
    
    CMP.b #$60 : BCS .BRANCH_BETA
    
    INY
    
    CMP.b #$48 : BCS .BRANCH_BETA
    CMP.b #$42 : BNE .BRANCH_GAMMA
    
    PHY
    
    JSR $9160   ; $0E9160 IN ROM
    
    PLY
    
    .BRANCH_GAMMA
    
    INY
    
    .BRANCH_BETA
    
    LDA $0DE0, X : BEQ .BRANCH_DELTA
    
    INY #3
    
    .BRANCH_DELTA
    
    LDA.w $910D, Y : STA $0DC0, X
    
    LDA $0EF0, X : AND.b #$7F : CMP.b #$01 : BNE .BRANCH_EPSILON
    
    LDA.b #$0F : STA $0D80, X
    
    LDA.b #$18 : STA $0F80, X
    
    STZ $0DF0, X
    
    .BRANCH_EPSILON
    
    RTS
}

; ==============================================================================

; $0E9158-$0E915B DATA
{
    ; \task name this pool routine.
    db  0, -16
    db  0,  -1
}

; ==============================================================================

; $0E915C-$0E91D4 LOCAL JUMP LOCATION
{
    ; Seems to spawn some Ganon helpers. Not sure which ones yet.
    
    LDA.b #$05
    
    BRA .BRANCH_ALPHA
    
    ; $0E9160 ALTERNATE ENTRY POINT
    
    LDA.b #$03
    
    .BRANCH_ALPHA
    
    STA $0FB5
    
    LDA.b #$C9
    LDY.b #$08
    
    JSL Sprite_SpawnDynamically.arbitrary : BMI .spawn_failed
    
    LDA.b #$2A : JSL Sound_SetSfx2PanLong
    
    JSL Sprite_SetSpawnedCoords
    
    LDA $0FB5 : STA $0EC0, Y : STA $0BA0, Y
    
    LDA.b #$03 : STA $0F50, Y
    LDA.b #$40 : STA $0E60, Y
    LDA.b #$21 : STA $0E40, Y
    LDA.b #$40 : STA $0CAA, Y
    
    PHX
    
    LDA $0DE0, X : TAX
    
    LDA $02 : CLC : ADC $9158, X : STA $0D00, Y
    
    LDA $03 : ADC $915A, X : STA $0D20, Y
    
    TYX
    
    LDA.b #$20
    
    JSL Sprite_ApplySpeedTowardsPlayerLong
    
    PLX
    
    LDA.b #$10 : STA $0DF0, Y
    
    LDA $0D10 : STA $0D90, Y
    LDA $0D30 : STA $0DA0, Y
    LDA $0D00 : STA $0DB0, Y
    LDA $0D20 : STA $0E90, Y
    
    JMP $8EAB ; $0E8EAB IN ROM
    
    .spawn_failed
    
    RTS
}

; $0E91D5-$0E9202 JUMP LOCATION ; 0x0E
{
    INC $0BA0, X
    
    JSR $9443   ; $0E9443 IN ROM
    
    STZ $0ED0, X
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    JSL GetRandomInt : AND.b #$01 : BEQ .BRANCH_BETA
    
    JMP $9118   ; $0E9118 IN ROM
    
    .BRANCH_BETA
    
    LDA.b #$7F : STA $0DF0, X
    
    LDA.b #$0C : STA $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    AND.b #$01 : BEQ .BRANCH_GAMMA
    
    LDA.b #$FF : STA $0DC0, X
    
    .BRANCH_GAMMA
    
    RTS
}

; $0E9203-$0E9230 JUMP LOCATION ; 0x07
{
    LDA $0E50, X : CMP.b #$A1 : BCS .BRANCH_ALPHA
    
    LDA.b #$A0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDA.b #$28 : STA $0B0A
    
    LDA $0DF0, X : BNE .BRANCH_BETA
    
    LDA.b #$08 : STA $0D80, X
    
    LDA.b #$FF : STA $0DF0, X
    
    RTS
    
    .BRANCH_BETA
    
    CMP.b #$C0 : BCS .BRANCH_GAMMA
    AND.b #$0F : BNE .BRANCH_GAMMA
    
    JSR $8E7C   ; $0E8E7C IN ROM
    
    .BRANCH_GAMMA
    
    BRA .BRANCH_$E9288
}

; $0E9248-$0E928E JUMP LOCATION ; 0x08
{
    LDA $0E50, X : CMP.b #$A1 : BCS .BRANCH_ALPHA
    
    LDA.b #$A0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDA $0DF0, X : BNE .BRANCH_BETA
    
    LDA.b #$09 : STA $0D80, X
    
    LDA.b #$7F : STA $0DF0, X
    
    JSR $9443   ; $0E9443 IN ROM
    
    LDY.b #$08
    
    .BRANCH_GAMMA
    
    LDA.b #$02 : STA $0D80, Y
    
    LDA.w $9240, Y : STA $0DF0, Y
    
    DEY : BNE .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_BETA
    
    LSR #4 : AND.b #$0F : TAY
    
    LDA $0B0A : CLC : ADC $9231, Y : STA $0B0A
    
    ; $0E9288 ALTERNATE ENTRY POINT
    
    JSR $93DB   ; $0E93DB IN ROM
    JSR $8D70   ; $0E8D70 IN ROM
    
    RTS
}

; $0E928F-$0E92A9 JUMP LOCATION ; 0x09
{
    LDA $0E50, X : CMP.b #$A1 : BCS .BRANCH_ALPHA
    
    LDA.b #$A0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDA $0DF0, X : BNE .BRANCH_BETA
    
    LDA.b #$0A
    
    JSR $947F   ; $0E947F IN ROM
    
    RTS
    
    .BRANCH_BETA
    
    JSR $94BA   ; $0E94BA IN ROM
    
    RTS
}

; $0E92AA-$0E92C9 JUMP LOCATION ; 0x0B
{
    INC $0BA0, X
    
    JSR $9443   ; $0E9443 IN ROM
    
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    ; $0E92B5 ALTERNATE ENTRY POINT
    
    LDA.b #$FF : STA $0DF0, X
    
    LDA.b #$07 : STA $0D80, X
    
    RTS
    
    .BRANCH_ALPHA
    
    AND.b #$01 : BEQ .BRANCH_BETA
    
    LDA.b #$FF : STA $0DC0, X
    
    .BRANCH_BETA
    
    RTS
}

; $0E92CA-$0E92F6 LOCAL JUMP LOCATION ; 0x00
{
    ; Is the timer still going?
    LDA $0DF0, X : BNE .BRANCH_ALPHA
    
    ; $0E92CF ALTERNATE ENTRY POINT
    
    ; Otherwise jump to the next step in the AI table.
    LDA.b #$01 : STA $0D80, X
    
    ; Set up a delay of #$80 frames till the next mode activates. (little over 1 s)
    LDA.b #$80 : STA $0DF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    ; At the #$20th frame, change the music.
    CMP.b #$20 : BEQ .BRANCH_BETA
    CMP.b #$40 : BNE .BRANCH_GAMMA ; On the 0x40th frame (in the countdown)
    
    LDA.b #$6F : STA $1CF0 ; I never imagined a boy like you could give me so much trouble...
    LDA.b #$01 : STA $1CF1
    
    JSL Sprite_ShowMessageMinimal
    
    .BRANCH_GAMMA
    
    RTS
    
    .BRANCH_BETA
    
    ; Play the song, "Ganondorf the Thief"
    LDA.b #$1F : STA $012C
    
    RTS
}

; $0E9341-$0E9353 BRANCH LOCATION
{
    CMP.b #$00 : BNE .BRANCH_ALPHA
    
    LDA.b #$05
    
    JMP $947F   ; $0E947F IN ROM
    
    .BRANCH_ALPHA
    
    LDY $0DE0, X
    
    LDA.w $933F, Y : STA $0DC0, X
    
    RTS
}

; $0E9354-$0E93FA JUMP LOCATION ; 0x01
{
    LDA $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
    
    ; Once Gannon takes enough damage fix his health at #$D0.
    LDA.b #$D0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    ; If the timer has >= 0x40 frames, then spin ze trident.
    LDA $0DF0, X : CMP.b #$40 : BCS .BRANCH_E9341  BNE .BRANCH_BETA
    
    STZ $0ED0, X
    
    LDA.b #$C9
    
    JSL Sprite_SpawnDynamically
    
    PHX
    
    LDA $0DE0, X : TAX
    
    LDA $00 : CLC : ADC $9317, X : STA $0D10, Y
    LDA $01 : ADC $9319, X : STA $0D30, Y
    
    LDA $02 : CLC : ADC $931B, X : STA $0D00, Y
    LDA $03 : ADC $931D, X : STA $0D20, Y
    
    PLX
    
    PHX : PHY
    
    LDA.b #$1F : JSL Sprite_ApplySpeedTowardsPlayerLong
    
    JSL Sprite_ConvertVelocityToAngle : PLY : SEC : SBC.b #$02 : AND.b #$0F : TAX
    
    LDA.w $931F, X : STA $0D50, Y
    
    LDA.w $932F, X : STA $0D40, Y
    
    PLX
    
    LDA.b #$70 : STA $0DF0, Y
    
    LDA.b #$02 : STA $0EC0, Y
    
    LDA.b #$01 : STA $0F50, Y
    
    LDA.b #$04 : STA $0E40, Y
    
    LDA.b #$84 : STA $0CAA, Y
    
    LDA.b #$02 : STA $0DE0, Y
    
    JMP $8EAB   ; $0E8EAB IN ROM
    
    ; $0E93DB ALTERNATE ENTRY POINT
    .BRANCH_BETA
    
    LDA $0DF0, X : LSR #2 : AND.b #$07
    
    LDY $0DE0, X : BEQ .BRANCH_GAMMA
    
    CLC : ADC.b #$08
    
    .BRANCH_GAMMA
    
    TAY
    
    LDA.w $92F7, Y : STA $0ED0, X
    
    LDA.w $9307, Y : STA $0DC0, X
    
    JSR Sprite_PeriodicWhirringSfx
    
    RTS
}

; ==============================================================================

; $0E93FB-$0E93FC DATA
{
    ; \task Name this routine / pool.
    .animation_states
    db 0, 8
}

; ==============================================================================

; $0E93FD-$0E9423 JUMP LOCATION ; 0x02
{
    LDA $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
    
    LDA.b #$D0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDY $0DE0, X
    
    LDA.w $93FB, Y : STA $0DC0, X
    
    LDA $0DF0, X : BEQ .BRANCH_BETA
    
    INC $0BA0, X
    
    AND.b #$01 : BEQ .BRANCH_BETA
    
    LDA.b #$FF : STA $0DC0, X

    .BRANCH_BETA

    RTS
}

; ==============================================================================

; $0E9424-$0E9427 DATA
{
    ; \task name this routine / pool.
    db 9, 10,  2, 10
}

; ==============================================================================

; $0E9428-$0E9459 JUMP LOCATION ; 0x03
{
    LDA $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
    
    LDA.b #$D0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDA $0DF0, X : BNE .BRANCH_BETA
    
    LDA.b #$06 : STA $0D80, X
    
    LDA.b #$7F : STA $0DF0, X
    
    ; $0E9443 ALTERNATE ENTRY POINT
    
    LDY $0DE0, X
    
    LDA.w $9424, Y : STA $0ED0, X
    
    ; $0E944C ALTERNATE ENTRY POINT
    
    LDY $0DE0, X
    
    LDA.w $9426, Y : STA $0DC0, X
    
    RTS
    
    .BRANCH_BETA
    
    JSR $93DB   ; $0E93DB IN ROM
    
    RTS
}

; $0E946C-$0E94C4 JUMP LOCATION ; 0x04
{
    LDA $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
    
    LDA.b #$D0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDA $0DF0, X : BNE .BRANCH_BETA
    
    LDA.b #$05
    
    ; $0E947F ALTERNATE ENTRY POINT ; spawn firebat?
    
    STA $00
    
    LDA $0E30, X : ASL #2 : STA $01
    
    JSL GetRandomInt : AND.b #$03 : ORA $01 : TAY
    
    LDA.w $94D5, Y
    
    STA $0E30, X : TAY
    
    LDA.w $94C5, Y : STA $7FFD5C
    
    LDA.w $94CD, Y : STA $7FFD68
    
    LDA.b $00 : STA $0D80, X
    
    JSR Sprite4_Zero_XY_Velocity
    
    LDA.b #$30 : STA $0DF0, X
    
    LDA.b #$28 : JSL Sound_SetSfx3PanLong
    
    RTS
    
    ; $0E94BA ALTERNATE ENTRY POINT
    .BRANCH_BETA
    
    LSR #3 : TAY
    
    LDA.w $945A, Y : STA $0EB0, X
    
    RTS
}

; ==============================================================================

; $0E94F5-$0E955E JUMP LOCATION ; 0x0D
{
    ; Reset health for lights out phase
    LDA.b #$64 : STA $0E50, X
    
    ; $0E94FA ALTERNATE ENTRY POINT  ; 0x05, 0x0A, 0x12
    
    INC $0BA0, X
    
    LDA $7FFD5C  : STA $04
    LDA $0D30, X : STA $05
    
    LDA $7FFD68  : STA $06
    LDA $0D20, X : STA $07
    
    JSR Ganon_CheckEntityProximity : BCS .BRANCH_E955F
    
    LDA $0E30, X : LSR #2 : STA $0DE0, X
    
    LDA $0D80, X : CMP.b #$05 : BEQ .BRANCH_ALPHA
    
    LDA $0E50, X : CMP.b #$A1 : BCS .BRANCH_BETA
    
    CMP.b #$61 : BCS .BRANCH_GAMMA
    
    LDA.b #$11 : STA $0D80, X
    
    LDA.b #$68 : STA $0DF0, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA.b #$0B : STA $0D80, X
    
    LDA.b #$28 : STA $0DF0, X
    
    RTS
    
    .BRANCH_GAMMA
    
    LDA.b #$0E : STA $0D80, X
    
    LDA.b #$28 : STA $0DF0, X
    
    RTS
    
    .BRANCH_ALPHA
    
    LDA.b #$02 : STA $0D80, X
    
    LDA.b #$20 : STA $0DF0, X
    
    RTS
    
    .unused
    
    RTS
}

; ==============================================================================

; $0E955F-$0E95AC BRANCH LOCATION
{
    LDA.b #$20
    
    JSL Sprite_ProjectSpeedTowardsEntityLong
    JSR $8AE4   ; $0E8AE4 IN ROM
    JSR Sprite4_Move
    
    LDA $0DF0, X : BEQ .BRANCH_ALPHA
    
    LDA $1A : AND.b #$01 : BNE .BRANCH_ALPHA
    
    JSR $944C   ; $0E944C IN ROM
    
    BRA .BRANCH_BETA
    
    .BRANCH_ALPHA
    
    LDA.b #$FF : STA $0DC0, X
    
    RTS
    
    .BRANCH_BETA
    
    LDA $1A : AND.b #$07 : BNE .BRANCH_GAMMA
    
    LDA.b #$D6
    
    JSL Sprite_SpawnDynamically : BMI .BRANCH_GAMMA
    
    JSL Sprite_SetSpawnedCoords
    
    LDA.b #$18 : STA $0BA0, Y : STA $0DF0, Y
    
    LDA.b #$FF : STA $0D80, Y
    
    LDA $0DC0, X : STA $0DC0, Y
    
    LDA $0EB0, X : STA $0EB0, Y
    
    .BRANCH_GAMMA
    
    RTS
}

; $0E95AD-$0E95CD JUMP LOCATION ; 0x06
{
    LDA $0E50, X : CMP.b #$D1 : BCS .BRANCH_ALPHA
    
    LDA.b #$D0 : STA $0E50, X
    
    .BRANCH_ALPHA
    
    LDA $0DF0, X : BNE .BRANCH_BETA
    
    LDA $0E50, X : CMP.b #$D1 : BCC .BRANCH_GAMMA
    
    JMP $92CF  ; $0E92CF IN ROM
    
    .BRANCH_GAMMA
    
    JMP $92B5   ; $0E92B5 IN ROM
    
    .BRANCH_BETA
    
    JMP $94BA   ; $0E94BA IN ROM
}

; ==============================================================================

; $0E95CE-$0E9ADA DATA
{
    ; \task Fill in this data.
    ; \note Also has data for drawing the trident, so separate that out.
}

; ==============================================================================

; $0E9ADB-$0E9ADE BRANCH LOCATION
{
    JSR Sprite4_PrepOamCoord
    
    RTS
}

; ==============================================================================

; $0E9ADF-$0E9C1B LOCAL JUMP LOCATION
{
    LDA $0DC0, X : BMI .BRANCH_$E9ADB
    
    LDA $0D80, X : CMP.b #$13 : BEQ .BRANCH_ALPHA
    
    LDA $0F10, X : BNE .BRANCH_ALPHA
    
    LDA $04C5 : BEQ .BRANCH_$E9ADB
    
    .BRANCH_ALPHA
    
    JSR Trident_Draw
    JSR Sprite4_PrepOamCoord
    
    ; There are much better combinations of instructions that produce
    ; multiplication by 12, guys...
    LDA $0DC0, X : ASL #3
    
    ADC $0DC0, X : ADC $0DC0, X : ADC $0DC0, X : ADC $0DC0, X : STA $06
    
    PHX
    
    LDX.b #$00
    LDY.b #$14
    
    .BRANCH_GAMMA
    
    PHX
    
    TXA : CLC : ADC $06 : TAX
    
    LDA $00      : CLC : ADC $95CE, X       : STA ($90), Y
    LDA $02      : CLC : ADC $969A, X : INY : STA ($90), Y
    LDA.w $9766, X                 : INY : STA ($90), Y
    
    LDA $05 : AND.b #$0F : CMP.b #$05 : LDA.w $9843, X : BCC .BRANCH_BETA
    
    AND.b #$F0
    
    .BRANCH_BETA
    
    ORA $05 : INY : STA ($90), Y
    
    PHY : TYA : LSR #2 : TAY
    
    LDA.b #$02 : STA ($92), Y
    
    PLY : INY
    
    PLX : INX : CPX.b #$0C : BNE .BRANCH_GAMMA
    
    PLX
    
    LDY $0DC0, X
    
    LDA.w $9832, Y : CMP.b #$0F : BEQ .BRANCH_DELTA
    
    ASL #2 : CLC : ADC.b #$14 : TAY : INY #2
    
    PHX : PHY
    
    LDA $0EB0, X : ASL A
    
    LDY $0DE0, X : BEQ .BRANCH_EPSILON
    
    CLC : ADC.b #$06
    
    .BRANCH_EPSILON
    
    TAX
    
    PLY
    
    LDA.w $9AB3, X : STA ($90), Y : INY
    
    LDA ($90), Y : AND.b #$3F : ORA $9ABF, X : STA ($90), Y
    
    INY #3
    
    LDA.w $9AB4, X : STA ($90), Y
    
    INY
    
    LDA ($90), Y : AND.b #$3F : ORA $9AC0, X : STA ($90), Y
    
    PLX
    
    .BRANCH_DELTA
    
    LDA $11 : BEQ .BRANCH_ZETA
    
    LDY.b #$FF
    LDA.b #$09
    
    JSL Sprite_CorrectOamEntriesLong
    
    .BRANCH_ZETA
    
    LDA $0ED0, X : CMP.b #$09 : BNE .BRANCH_THETA
    
    REP #$20
    
    LDA.w #$9ACB : STA $08
    
    LDA.w #$0828 : STA $90
    
    LDA.w #$0A2A : STA $92
    
    SEP #$20
    
    LDA.b #$02
    
    JSR Sprite4_DrawMultiple
    
    .BRANCH_THETA
    
    LDA $0F70, X : SEC : SBC.b #$01 : STA $0E
    LDA.b #$00   : SBC.b #$00 : STA $0F
    
    LSR #3 : TAY : CPY.b #$04 : BCC .BRANCH_IOTA
    
    LDY.b #$04
    
    .BRANCH_IOTA
    
    LDA.w $D180, Y : STA $00 : STZ $01
    
    REP #$20
    
    LDA $0FDA : CLC : ADC $0E : STA $0FDA
    
    LDA.w #$09F4 : STA $90
    
    LDA.w #$0A9D : STA $92
    
    LDA.w #$D108 : CLC : ADC $00 : STA $08
    
    SEP #$20
    
    LDA $0F50, X : PHA
    
    STZ $0F50, X
    
    LDA.b #$30 : STA $0B89, X
    
    LDA.b #$03
    
    JSR Sprite4_DrawMultiple
    
    PLA : STA $0F50, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    RTS
}

; ==============================================================================

; $0E9C1C-$0E9C79 LOCAL JUMP LOCATION
Trident_Draw:
{
    LDA.b #$00 : XBA
    
    LDA $0ED0, X : BEQ .dont_draw
    
    DEC A : REP #$20 : ASL #3 : STA $00
    
    ASL #2 : CLC : ADC $00 : CLC : ADC.w #$990F : STA $08
    
    SEP #$20
    
    LDY.b #$06 : LDA $0ED0, X : CMP.b #$09 : BEQ .BRANCH_BETA
    LDY.b #$08                             : BCS .BRANCH_BETA
    
    LDA $0DE0, X : ASL A : TAY
    
    .BRANCH_BETA
    
    REP #$20
    
    LDA $0FD8 : CLC : ADC $9A9F, Y : STA $0FD8
    
    LDA $0FDA : CLC : ADC $9AA9, Y : STA $0FDA
    
    SEP #$20
    
    LDA $0B89, X : PHA : AND.b #$F0 : STA $0B89, X
    
    LDA.b #$05 : JSR Sprite4_DrawMultiple
    
    PLA : STA $0B89, X
    
    JSL Sprite_Get_16_bit_CoordsLong
    
    .dont_draw
    
    RTS
}

; ==============================================================================
