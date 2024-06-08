
; ==============================================================================

; $046A7F-$046A82 DATA
Pool_Ancilla_SomarianPlatformPoof:
{
    .directions
    db $01, $00, $03, $02
}

; ==============================================================================

; $046A83-$046B3D JUMP LOCATION
Ancilla_SomarianPlatformPoof:
{
    ; Special Object 0x39 - Cane of Somaria platform creating poof
    
    DEC.w $03B1, X : BMI .initiate_poof
    
    RTS
    
    .initiate_poof
    
    STZ.w $0C4A, X
    
    LDA.w $0BFA, X : STA.b $72
    LDA.w $0C0E, X : STA.b $73
    
    LDA.w $0C04, X : STA.b $74
    LDA.w $0C18, X : STA.b $75
    
    LDA.w $0C7C, X : STA.b $BD
    
    PHX
    
    ; Create a cane of Somaria platform sprite
    LDA.b #$ED : JSL Sprite_SpawnDynamically : BPL .spawn_succeeded
    
    BRL .spawn_failed
    
    .spawn_succeeded
    
    STZ.w $02F5
    
    LDA.b $72 : AND.b #$F8 : ORA.b #$04 : STA.w $0D00, Y : STA.b $72
    LDA.b $73                           : STA.w $0D20, Y
    
    LDA.b $74 : AND.b #$F8 : ORA.b #$04 : STA.w $0D10, Y : STA.b $74
    LDA.b $75                           : STA.w $0D30, Y
    
    LDA.b $BD : CMP.b #$01 : REP #$30 : STZ.b $06 : BCC .on_bg2
    
    LDA.w #$1000 : STA.b $06
    
    .on_bg2
    
    LDA.b $74 : AND.w #$01FF : LSR #3 : STA.b $04
    
    LDA.b $72 : AND.w #$01F8 : ASL #3 : CLC : ADC.b $04 : CLC : ADC.b $06 : TAX
    
    STZ.b $06
    
    LDA.l $7F1FC0, X : AND.w #$00F0 : CMP.w #$00B0 : BEQ .attribute_match
    
    INC.b $06
    
    LDA.l $7F2040, X : AND.w #$00F0 : CMP.w #$00B0 : BEQ .attribute_match
    
    INC.b $06
    
    LDA.l $7F1FFF, X : AND.w #$00F0 : CMP.w #$00B0 : BEQ .attribute_match
    
    INC.b $06
    
    .attribute_match
    
    SEP #$30
    
    LDX.b $06
    
    LDA .directions, X : STA.w $0DE0, Y
    
    LDA.b #$00 : STA.w $0F20, Y
    
    BRA .return
    
    .spawn_failed
    
    ; \wtf What actually happens in the macroscopic game scale if we cannot
    ; spawn a sprite for the platform? Would be good to check this out.
    ; \task durp, check it out!
    JSR SomarianBlock_Draw
    
    .return
    
    PLX
    
    RTS
}

; ==============================================================================
