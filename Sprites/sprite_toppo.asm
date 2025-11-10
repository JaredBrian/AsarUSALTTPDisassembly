; ==============================================================================

; Jerk bunny
; $02BA85-$02BAB5 JUMP LOCATION
Sprite_Toppo:
{
    LDA.w $0D80, X : BEQ .not_visible
        LDA.w $0B89, X : ORA.b #$30 : STA.w $0B89, X
        
        JSR.w Toppo_Draw
        
    .not_visible
    
    JSR.w Sprite2_CheckIfActive
    
    LDA.w $0D80, X
    
    REP #$30
    
    AND.w #$00FF : ASL : TAY
    LDA.w .states, Y : DEC : PHA
    
    SEP #$30
    
    RTS
    
    .states
    dw Toppo_PickNextGrassPlot   ; 0x00 - $BAC6
    dw Toppo_ChillBeforeJump     ; 0x01 - $BB01
    dw Toppo_WaitThenJump        ; 0x02 - $BB1A
    dw Toppo_RiseAndFall         ; 0x03 - $BB30
    dw Toppo_ChillAfterJump      ; 0x04 - $BB53
    dw Toppo_FlusteredTrampoline ; 0x05 - $BB6D
}

; ==============================================================================

; $02BAB6-$02BAC5 DATA
Pool_Toppo_PickNextGrassPlot:
{
    ; $02BAB6
    .x_offsets_low
    db $E0, $20, $00, $00
    
    ; $02BABA
    .x_offsets_high
    db $FF, $00, $00, $00
    
    ; $02BABE
    .y_offsets_low
    db $00, $00, $E0, $20
    
    ; $02BAC2
    .y_offsets_high
    db $00, $00, $FF, $00
}

; $02BAC6-$02BB00 JUMP LOCATION
Toppo_PickNextGrassPlot:
{
    LDA.w $0DF0, X : BNE .delay
    
    INC.w $0D80, X
    
    LDA.b #$08 : STA.w $0DF0, X
    
    JSL.l GetRandomInt : AND.b #$03 : TAY
    LDA.w $0D90, X
    CLC : ADC Pool_Toppo_PickNextGrassPlot_x_offsets_low,  Y : STA.w $0D10, X

    LDA.w $0DA0, X
          ADC Pool_Toppo_PickNextGrassPlot_x_offsets_high, Y : STA.w $0D30, X
    
    LDA.w $0DB0, X
    CLC : ADC Pool_Toppo_PickNextGrassPlot_y_offsets_low,  Y : STA.w $0D00, X

    LDA.w $0EB0, X
          ADC Pool_Toppo_PickNextGrassPlot_y_offsets_high, Y : STA.w $0D20, X
    
    .delay
    
    RTS
}

; ==============================================================================

; $02BB01-$02BB19 JUMP LOCATION
Toppo_ChillBeforeJump:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$10 : STA.w $0DF0, X
        
        RTS
        
    .delay
    
    LSR : LSR : AND.b #$01 : STA.w $0DC0, X
    
    JSR.w Toppo_CheckLandingSiteForGrass
    
    RTS
}

; ==============================================================================

; $02BB1A-$02BB2F JUMP LOCATION
Toppo_WaitThenJump:
{
    LDA.w $0DF0, X : BNE .delay
        INC.w $0D80, X
        
        LDA.b #$40 : STA.w $0F80, X
    
    .delay
    
    LDA.b #$02 : STA.w $0DC0, X
    
    JSR.w Toppo_CheckLandingSiteForGrass
    
    RTS
}

; ==============================================================================

; $02BB30-$02BB52 JUMP LOCATION
Toppo_RiseAndFall:
{
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_MoveAltitude
    
    ; Simulate gravity.
    LDA.w $0F80, X : SEC : SBC.b #$02 : STA.w $0F80, X
    
    LDA.w $0F70, X : BPL .delay
        STZ.w $0F70, X
        
        INC.w $0D80, X
        
        LDA.b #$10 : STA.w $0DF0, X
        
        JSR.w Toppo_CheckLandingSiteForGrass
    
    .delay
    
    RTS
}

; ==============================================================================

; $02BB53-$02BB6C JUMP LOCATION
Toppo_ChillAfterJump:
{
    LDA.w $0DF0, X : BNE .delay
        STZ.w $0D80, X
        
        LDA.b #$20 : STA.w $0DF0, X
        
        BRA .moving_on
    
    .delay
    
    LSR : LSR : AND.b #$01 : STA.w $0DC0, X
    
    .moving_on
    
    JSR.w Toppo_CheckLandingSiteForGrass
    
    RTS
}

; ==============================================================================

; $02BB6D-$02BB71
Toppo_FlusteredTrampoline:
{
    JSL.l Toppo_Flustered
    
    RTS
}

; ==============================================================================

; $02BB72-$02BB95 LOCAL JUMP LOCATION
Toppo_CheckLandingSiteForGrass:
{
    LDA.w $0D00, X : STA.b $00
    LDA.w $0D20, X : STA.b $01
    
    LDA.w $0D10, X : STA.b $02
    LDA.w $0D30, X : STA.b $03
    
    LDA.b #$00
    JSL.l Entity_GetTileAttr : CMP.b #$40 : BEQ .is_thick_grass
        LDA.b #$05 : STA.w $0D80, X
    
    .is_thick_grass
    
    RTS
}

; ==============================================================================

; $02BB96-$02BBFE DATA
Pool_Toppo_Draw:
{
    ; $02BB96
    .offset_x
    dw   0,   8,   8
    dw   0,   8,   8
    dw   0,   0,   8
    dw   0,   0,   0
    dw   0,   0,   0

    ; $02BBB4
    .offset_y
    dw   8,   8,   8
    dw   8,   8,   8
    dw   0,   8,   8
    dw   0,   0,   0
    dw   0,   0,   0


    ; $02BBD2
    .char
    db $C8, $C8, $C8
    db $CA, $CA, $CA
    db $C0, $C8, $C8
    db $C2, $C2, $C2
    db $C2, $C2, $C2


    ; $02BBE1
    .flip
    db $00, $40, $40
    db $00, $40, $40
    db $00, $00, $40
    db $00, $00, $00
    db $40, $40, $40


    ; $02BBF0
    .size
    db $00, $00, $00
    db $00, $00, $00
    db $02, $00, $00
    db $02, $02, $02
    db $02, $02, $02
}

; $02BBFF-$02BC89 LOCAL JUMP LOCATION
Toppo_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0D00, X : SEC : SBC.b $E8 : STA.b $06
    LDA.w $0D20, X : SEC : SBC.b $E9 : STA.b $07
    
    LDA.w $0DC0, X : ASL : ADC.w $0DC0, X : STA.b $08
    
    PHX
    
    LDX.b #$02
    
    .next_OAM_entry
        
        PHX
        TXA : CLC : ADC.b $08 : PHA : TAX
        LDA.w Pool_Toppo_Draw_size, X : STA.b $0C
        
        TXA : ASL : TAX
        
        REP #$20
        
        LDA.b $00 : CLC : ADC.w Pool_Toppo_Draw_offset_x, X : STA.b ($90), Y
        AND.w #$0100 : STA.b $0E
        
        PHX
        
        LDX.b $0C : CPX.b #$01
        
        PLX
        
        LDA.b $02 : BCS .alpha
            LDA.b $06
        
        .alpha
        
        CLC : ADC.w Pool_Toppo_Draw_offset_y, X : INY : STA.b ($90), Y
        CLC : ADC.w #$0010 : CMP.w #$0100 : SEP #$20 : BCC .beta
            LDA.b #$F0 : STA.b ($90), Y
        
        .beta
        
        PLX
        
        LDA.w Pool_Toppo_Draw_char, X : INY : STA.b ($90), Y
        
        LDA.b $0C : CMP.b #$01 : LDA.w Pool_Toppo_Draw_flip, X : ORA.b $05 : BCS .gamma
            AND.b #$F0 : ORA #$02
        
        .gamma
        
        INY : STA.b ($90), Y
        
        PHY
        TYA : LSR : LSR : TAY
        LDA.b $0C : ORA.b $0F : STA.b ($92), Y
        
        PLY : INY
    PLX : DEX : BPL .next_OAM_entry
    
    PLX
    
    RTS
    
    .unused_label
    
    RTS
}

; ==============================================================================
