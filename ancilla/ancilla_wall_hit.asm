; ==============================================================================

; $0413E8-$04141E JUMP LOCATION
Ancilla_WallHit:
{
    DEC.w $039F, X : BPL .delay
        LDA.w $0C5E, X : INC : CMP.b #$05 : BEQ .self_terminate
            STA.w $0C5E, X
            
            ; Reset the countdown tiemr to 1.
            LDA.b #$01 : STA.w $039F, X
            
            BRA .delay
}

; $0413FF-$041418 JUMP LOCATION
Ancilla_SwordWallHit:
{
    JSR.w Ancilla_AlertSprites
    
    DEC.w $03B1, X : BPL .delay
        LDA.w $0C5E, X : INC : CMP.b #$08 : BEQ Ancilla_WallHit_self_terminate
            STA.w $0C5E, X
            
            ; Reset the countdown timer to 1.
            LDA.b #$01 : STA.w $03B1, X
            
            ; OPTIMIZE: Come on man wtf is this. Just move the BRL here.
            BRA .delay
}

; $041419-$04141B JUMP LOCATION
Ancilla_WallHit_self_terminate:
{
    BRL Ancilla_SelfTerminate
}

; $04141C-$04141E JUMP LOCATION
Ancilla_WallHit_delay:
{
    BRL WallHit_Draw
}

; ==============================================================================

; $04141F-$0414DE DATA
Pool_WallHit_Draw:
{
    ; $04141F
    .chr
    db $80, $00, $00, $00, $92, $00, $00, $00
    db $81, $81, $81, $81, $82, $82, $82, $82
    db $93, $93, $93, $93, $92, $00, $00, $00
    db $B9, $00, $00, $00, $90, $90, $00, $00
    
    ; $04143F
    .properties
    db $32, $00, $00, $00, $32, $00, $00, $00
    db $32, $72, $B2, $F2, $32, $72, $B2, $F2
    db $32, $72, $B2, $F2, $32, $00, $00, $00
    db $72, $00, $00, $00, $32, $F2, $00, $00
    
    ; $04145F
    .y_offsets
    dw -4,  0,  0,  0, -4,  0,  0,  0
    dw -8, -8,  0,  0, -8, -8,  0,  0
    dw -8, -8,  0,  0, -4,  0,  0,  0
    dw -4,  0,  0,  0, -8,  0,  0,  0
    
    ; $04149F
    .x_offsets
    dw -4,  0,  0,  0, -4,  0,  0,  0
    dw -8,  0, -8,  0, -8,  0, -8,  0
    dw -8,  0, -8,  0, -4,  0,  0,  0
    dw -4,  0,  0,  0, -8,  0,  0,  0
}

; $0414DF-$041542 LOCAL JUMP LOCATION
WallHit_Draw:
{
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA.b $00 : STA.b $04
    LDA.b $02 : STA.b $06
    
    SEP #$20
    
    LDA.b #$03 : STA.b $08
    
    PHX
    
    LDA.w $0C5E, X : ASL #2 : TAX
    
    LDY.b #$00
    
    .next_OAM_entry
    
        LDA.w Pool_WallHit_Draw_chr, X : BEQ .skip_entry
            PHX
            
            TXA : ASL : TAX
            
            REP #$20
            
            LDA.w Pool_WallHit_Draw_y_offsets, X : CLC : ADC.b $04 : STA.b $00
            LDA.w Pool_WallHit_Draw_x_offsets, X : CLC : ADC.b $06 : STA.b $02
            
            SEP #$20
            
            PLX
            
            JSR.w Ancilla_SetOam_XY
            
            LDA.w Pool_WallHit_Draw_chr, X : STA ($90), Y
            INY
            
            LDA.w Pool_WallHit_Draw_properties, X : AND.b #$CF : ORA.b $65 : STA ($90), Y
            INY : PHY
            
            TYA : SEC : SBC.b #$04 : LSR #2 : TAY
            
            LDA.b #$00 : STA ($92), Y
            
            PLY
            
        .skip_entry
        
        JSR.w Ancilla_CustomAllocateOam
        
        INX
    DEC.b $08 : BPL .next_OAM_entry
    
    PLX
    
    RTS
}

; ==============================================================================
