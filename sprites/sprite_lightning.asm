; ==============================================================================

; $0EE39D-$0EE3EC DATA
Pool_Sprite_BF_Lightning:
{
    ; $0EE39D
    .anim
    db $00, $01, $02, $03
    db $00, $01, $02, $03

    ; $0EE3A5
    .flip
    db $00, $00, $00, $00
    db $40, $40, $40, $40

    ; $0EE3AD
    .branch_offset_x
    db -15,   0,   0, -15,   0, -15, -15,   0
    db -15,   0,   0, -15,   0, -15, -15,   0
    db   0,  15,  15,   0,  15,   0,   0,  15
    db   0,  15,  15,   0,  15,   0,   0,  15
    db   0,  15,  15,   0,  15,   0,   0,  15
    db   0,  15,  15,   0,  15,   0,   0,  15
    db -15,   0,   0, -15,   0, -15, -15,   0
    db -15,   0,   0, -15,   0, -15, -15,   0
}

; $0EE3ED-$0EE475 JUMP LOCATION
Sprite_Lightning:
{
    LDA.b $1A : ASL A : AND.b #$0E : STA.b $00
    
    LDY.w $0D90, X
    
    LDA.w $0F50, X
    AND.b #$B1 : ORA.w Pool_Sprite_BF_Lightning_flip, Y : ORA.b $00
    STA.w $0F50, X
    
    LDA.w Pool_Sprite_BF_Lightning_anim, Y
    
    LDY.w $048E : CPY.b #$20 : BNE .BRANCH_ALPHA
        CLC : ADC.b #$04
    
    .BRANCH_ALPHA
    
    STA.w $0DC0, X
    
    JSL.l Sprite_PrepAndDrawSingleLargeLong
    JSR.w Sprite4_CheckIfActive
    
    LDA.w $0DF0, X : BNE .BRANCH_BETA
        JSR.w Lightning_SpawnFulgurGarnish
        
        LDA.b #$02 : STA.w $0DF0, X
        
        LDA.w $0D00, X : CLC : ADC.b #$10 : STA.w $0D00, X : PHA
        LDA.w $0D20, X :       ADC.b #$00 : STA.w $0D20, X
        
        PLA : SEC : SBC.b $E8 : CMP.b #$D0 : BCC .BRANCH_GAMMA
            STZ.w $0DD0, X
            
            RTS
        
        .BRANCH_GAMMA
        
        JSL.l GetRandomInt : AND.b #$07 : STA.b $00
        
        LDA.w $0D90, X : ASL #3 : ORA.b $00 : TAY
        
        STZ.b $01
        
        LDA.w Pool_Sprite_BF_Lightning_branch_offset_x, Y : BPL .BRANCH_DELTA
            DEC.b $01
        
        .BRANCH_DELTA
        
                   CLC : ADC.w $0D10, X : STA.w $0D10, X
        LDA.w $0D30, X : ADC.b $01      : STA.w $0D30, X
        
        LDA.b $00 : STA.w $0D90, X
    
    .BRANCH_BETA
    
    RTS
}

; $0EE475-$0EE4C7 JUMP LOCATION
Lightning_SpawnFulgurGarnish:
{
    PHX : TXY
    
    LDX.b #$1D
    
    .next_slot
    
        LDA.l $7FF800, X : BEQ .empty_slot
    DEX : BPL .next_slot
    
    DEC.w $0FF8 : BPL .dont_reset_fulgur_count
        LDA.b #$1D : STA.w $0FF8
    
    .dont_reset_fulgur_count
    
    LDX.w $0FF8
    
    .empty_slot
    
    LDA.b #$09 : STA.l $7FF800, X : STA.w $0FB4
    
    LDA.w $0D90, Y : STA.l $7FF92C, X
    
    LDA.w $0D10, Y : STA.l $7FF83C, X
    LDA.w $0D30, Y : STA.l $7FF878, X
    
    LDA.w $0D00, Y : CLC : ADC.b #$10 : STA.l $7FF81E, X
    LDA.w $0D20, Y :       ADC.b #$00 : STA.l $7FF85A, X
    
    LDA.b #$20 : STA.l $7FF90E, X
    
    PLX
    
    RTS
}

; ==============================================================================
