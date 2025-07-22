; ==============================================================================

; $02AB54-$02AB92 JUMP LOCATION
Sprite_CannonBall:
{
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_Move
    
    LDA.w $0DF0, X : CMP.b #$1E : BNE .dont_poof
        PHA
        
        JSL.l Sprite_SpawnPoofGarnish
        
        PLA
    
    .dont_poof
    
    CMP.b #$00 : BNE .no_tile_collision
        JSR.w Sprite2_CheckTileCollision : BEQ .no_tile_collision
            STZ.w $0DD0, X
            
            LDA.w $0D10, X : CLC : ADC.b #$04 : STA.w $0D10, X
            LDA.w $0D00, X : CLC : ADC.b #$04 : STA.w $0D00, X
            
            JSL.l Sprite_PlaceRupulseSpark_coerce
            
            LDA.b #$05 : JSL.l Sound_SetSfx2PanLong
        
    .no_tile_collision

    ; Bleeds into the next function.
}
    
; $02AB93-$02AB9B JUMP LOCATION
Sprite2_CheckDamage:
{
    JSL.l Sprite_CheckDamageFromPlayerLong
    JSL.l Sprite_CheckDamageToPlayerLong
    
    RTS
}

; ==============================================================================

; This routine does that poof of smoke effect when fire fairys change into
; real fairys (and other cases where a poof is needed).
; $02AB9C-$02ABE3 LONG JUMP LOCATION
Sprite_SpawnPoofGarnish:
{
    PHX
    
    TXY
    
    LDX.b #$1D
    
    .nextSlot
    
        ; Look for an empty special sprite slot.
        LDA.l $7FF800, X : BEQ .emptySlot
    
    DEX : BPL .nextSlot
    
    ; Use the first slot, if nothing else can be found.
    INX
    
    .emptySlot
    
    LDA.b #$0A : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0D20, Y :       ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.w $0F20, Y : STA.l $7FF92C, X
    
    LDA.b #$0F : STA.l $7FF90E, X
    
    TXY
    
    PLX
    
    RTL
}

; ==============================================================================

; Cannon soldier AI (unused in original game)
; $02ABE4-$02AC23 JUMP LOCATION
Sprite_CannonTrooper:
{
    LDA.w $0DB0, X : BEQ .not_cannon_ball
        JMP Sprite_CannonBall
    
    .not_cannon_ball
    
    LDY.w $0DE0, X : PHY
    
    LDA.w $0E00, X : BEQ .beta
        LDA.w Soldier_DirectionLockSettings_directions, Y : STA.w $0DE0, X
    
    .beta
    
    JSR.w CannonTrooper_Draw
    
    PLA : STA.w $0DE0, X
    
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckDamage
    
    LDA.w $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    
    LDA.w .vectors, Y : DEC : PHA
    
    SEP #$30
    
    RTS

    ; $02AC1A
    .vectors
    dw CannonGuard_Idle    ; 0x00 - $AC24
    dw CannonGuard_Charge  ; 0x00 - $AC52
    dw CannonGuard_Fire    ; 0x00 - $ACF2
    dw CannonGuard_Recoil  ; 0x00 - $AD12
    dw CannonGuard_Recover ; 0x00 - $AD28
}

; $02AC24-$02AC33 LOCAL JUMP LOCATION
CannonGuard_Idle:
{
    STZ.w $0D90, X
    
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$60 : STA.w $0DF0, X

        ; Bleeds into the next function.
}
    
; $02AC34-$02AC51 LOCAL JUMP LOCATION
Trooper_FacePlayer:
{
    LDA.w $0DE0, X : PHA
    
    JSR.w Sprite2_DirectionToFacePlayer : TYA : STA.w $0DE0, X
    
    PLA : CMP.w $0DE0, X : BEQ .already_facing
        EOR.w $0DE0, X : AND.b #$02 : BNE .direction_lock_not_necessary
            LDA.b #$0C : STA.w $0E00, X
            
        .direction_lock_not_necessary
    .already_facing

    ; $02AC51 ALTERNATE ENTRY POINT
    .delay
    
    RTS
}

; ==============================================================================

; $02AC52-$02AC62 JUMP LOCATION
CannonGuard_Charge:
{
    LDA.b #$00
    
    LDY.w $0DF0, X : BEQ CannonTrooper_SpawnCannonBall
        CPY.b #$30 : BCS .delay
            LDA.b #$02
        
        .delay
        
        STA.w $0D90, X
        
        RTS
}

; ==============================================================================

; $02AC63-$02AC7A DATA
Pool_CannonTrooper_SpawnCannonBall:
{
    ; $02AC63
    .x_offsets_low
    db 16, -16,   0,   0
    
    ; $02AC67
    .x_offsets_high
    db  0,  -1,   0,   0
    
    ; $02AC6B
    .y_offsets_low
    db  0,   0,   8, -16
    
    ; $02AC6F
    .y_offsets_high
    db  0,   0,   0,  -1
    
    ; $02AC73
    .x_speeds
    db 24, -24,   0,   0
    
    ; $02AC77
    .y_speeds
    db  0,   0,  24, -24
}

; $02AC7B-$02ACE9 LOCAL JUMP LOCATION
CannonTrooper_SpawnCannonBall:
{
    INC.w $0D80, X
    
    LDA.b #$04 : STA.w $0DF0, X
    
    LDA.b #$6B : JSL.l Sprite_SpawnDynamically : BMI .spawn_failed
        LDA.b #$07 : JSL.l Sound_SetSfx3PanLong
        
        LDA.b #$01 : STA.w $0DB0, Y
        
        LDA.w $0DE0, X : PHX : TAX
        
        LDA.b $00
        CLC : ADC Pool_CannonTrooper_SpawnCannonBall_x_offsets_low, X
        STA.w $0D10, Y

        LDA.b $01
        ADC Pool_CannonTrooper_SpawnCannonBall_x_offsets_high, X
        STA.w $0D30, Y
        
        LDA.b $02
        CLC : ADC Pool_CannonTrooper_SpawnCannonBall_y_offsets_low, X
        STA.w $0D00, Y

        LDA.b $03
        ADC Pool_CannonTrooper_SpawnCannonBall_y_offsets_high, X
        STA.w $0D20, Y
        
        LDA Pool_CannonTrooper_SpawnCannonBall_x_speeds, X : STA.w $0D50, Y
        
        LDA Pool_CannonTrooper_SpawnCannonBall_y_speeds, X : STA.w $0D40, Y
        
        LDA.w $0E40, Y : AND.b #$F0 : ORA.b #$01 : STA.w $0E40, Y
        
        LDA.w $0E60, Y : ORA.b #$47 : STA.w $0E60, Y
        LDA.w $0CAA, Y : ORA.b #$44 : STA.w $0CAA, Y
        
        LDA.b #$20 : STA.w $0DF0, Y
        
        PLX
        
    .spawn_failed
    
    RTS
}

; ==============================================================================

; $02ACEA-$02ACF1 DATA
Pool_CannonGuard_Fire:
{
    ; $02ACEA
    .x_speeds
    db -32,  32,   0,   0
    
    ; $02ACEE
    .y_speeds
    db   0,   0, -32, 32
}

; $02ACF2-$02AD11 LOCAL JUMP LOCATION
CannonGuard_Fire:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
    
    .delay
    
    LDY.w $0DE0, X
    
    LDA Pool_CannonGuard_Fire_x_speeds, Y : STA.w $0D50, X
    
    LDA Pool_CannonGuard_Fire_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    RTS
}

; ==============================================================================

; $02AD12-$02AD1F LOCAL JUMP LOCATION
CannonGuard_Recoil:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$10 : STA.w $0DF0, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02AD20-$02AD27 DATA
Pool_CannonGuard_Recover:
{
    ; $02AD20
    .x_speeds
    db 8, -8,  0,  0
    
    ; $02AD24
    .y_speeds
    db 0,  0,  8, -8
}

; $02AD28-$02AD50 LOCAL JUMP LOCATION
CannonGuard_Recover:
{
    LDA.w $0DF0, X : BNE .delay_ai_state_reset
        STZ.w $0D80, X
        
        LDA.b #$80 : STA.w $0DF0, X
        
    .delay_ai_state_reset
    
    LDY.w $0DE0, X
    
    LDA Pool_CannonGuard_Recover_x_speeds, Y : STA.w $0D50, X
    
    LDA Pool_CannonGuard_Recover_y_speeds, Y : STA.w $0D40, X
    
    JSR.w Sprite2_Move
    
    LDA.b $1A : LSR : LSR : AND.b #$01 : STA.w $0D90, X
    
    RTS
}

; ==============================================================================

; $02AD51-$02AEF8 DATA
Pool_SpriteDraw_CannonGuard:
{
    ; $02AD51
    .offset_x
    dw  -4,   4,   0,   0
    dw   0,  -4,   4,   0
    dw   0,   0,  -4,   4
    dw   0,   0,  12,   4
    dw   4,  -8,  -8,  -8
    dw   4,   4,  -8,  -8
    dw  -8,   4,   4,  -8
    dw   9,   9,   0,  -4
    dw   4,   0,   0,   0
    dw  -4,   4,   0,   0
    dw   0,  -4,   4,   0
    dw  -5,  -4,  -4,   8
    dw   8,   8,  -4,  -4
    dw   8,   8,   8,  -4
    dw  -4,   8,  -1,  -1

    ; $02ADC9
    .offset_y
    dw   0,   0,  -9,   7
    dw   7,   0,   0,  -9
    dw   7,   7,   0,   0
    dw  -9,   7,  -3,   0
    dw  -9,   0,   0,   0
    dw   0,  -9,   0,   0
    dw   0,   0,  -9,   0
    dw   0,   0, -12,   0
    dw   0,  -9,  -9, -12
    dw   0,   0,  -9,  -9
    dw -12,   0,   0,  -9
    dw  -3,   0,  -9,   0
    dw   0,   0,   0,  -9
    dw   0,   0,   0,   0
    dw  -9,   0,   0,   0

    ; $02AE41
    .char
    db $46, $46, $00, $24
    db $24, $48, $49, $00
    db $24, $24, $46, $06
    db $00, $24, $2F, $4E
    db $02, $26, $26, $26
    db $60, $02, $26, $26
    db $26, $08, $02, $26
    db $2F, $2F, $28, $64
    db $64, $04, $04, $28
    db $66, $67, $04, $04
    db $28, $0A, $64, $04
    db $2F, $4E, $02, $26
    db $26, $26, $60, $02
    db $26, $26, $26, $08
    db $02, $26, $2F, $2F

    ; $02AE7D
    .flip
    db $00, $40, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $00, $00
    db $40, $00, $00, $00
    db $00, $00, $00, $00
    db $00, $00, $40, $00
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40
    db $40, $40, $40, $40

    ; $02AEB9
    .size
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $00, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $00, $00, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $00, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $02, $02
    db $02, $02, $00, $00

    ; $02AEF5
    .direction_offset
    db $09
    db $03
    db $00
    db $06
}

; $02AEF9-$02AF70 LOCAL JUMP LOCATION
CannonTrooper_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDY.w $0DE0, X
    
    LDA.w Pool_SpriteDraw_CannonGuard_direction_offset, Y
    CLC : ADC.w $0D90, X : STA.b $06
    
    ASL : ASL : ADC.b $06 : STA.b $06
    
    PHX
    
    LDX.b #$04
    LDY.b #$00
    
    .gamma
        
        PHX
        
        TXA : CLC : ADC.b $06 : PHA : ASL : TAX
        
        REP #$20
        
        LDA.b $00
        CLC : ADC.w Pool_SpriteDraw_CannonGuard_offset_x, X : STA.b ($90), Y
        
        AND.w #$0100 : STA.b $0E
        
        LDA.b $02
        CLC : ADC.w Pool_SpriteDraw_CannonGuard_offset_y, X : INY : STA.b ($90), Y
        
        CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .alpha
            LDA.w #$00F0 : STA.b ($90), Y
        
        .alpha
        
        SEP #$20
        
        PLX
        
        LDA.w Pool_SpriteDraw_CannonGuard_char, X : INY : STA.b ($90), Y
        
        SEC : SBC.b #$24 : CMP.b #$05
        
        LDA.w Pool_SpriteDraw_CannonGuard_flip, X : ORA.b $05 : BCS .beta
            AND.b #$F1 : ORA #$06
        
        .beta
        
        INY : STA.b ($90), Y
        
        PHY : TYA : LSR : LSR : TAY
        
        LDA.w Pool_SpriteDraw_CannonGuard_size, X : ORA.b $0F : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .gamma
    
    PLX
    
    RTS
}

; ==============================================================================
