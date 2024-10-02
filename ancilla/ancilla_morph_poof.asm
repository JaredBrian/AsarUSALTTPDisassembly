; ==============================================================================

; $04537A-$0453BB DATA
Pool_MorphPoof_Draw:
{
    ; $04537A
    .chr
    db $86, $A9, $9B
    
    ; $04537D
    .oam_size
    db $02, $00, $00

    ; $045380
    .prop
    db $00, $FF, $FF, $FF
    db $40, $00, $C0, $80
    db $00, $40, $80, $C0
    
    ; $04538C
    .y_offsets
    dw  0,  0,  0,  0
    dw  0,  0,  8,  8
    dw -4, -4, 12, 12
    
    ; $0453A4
    .x_offsets
    dw  0,  0,  0,  0
    dw  0,  8,  0,  8
    dw -4, 12, -4, 12
}

; ==============================================================================

; $0453BC-$0453FC JUMP LOCATION
Ancilla_MorphPoof:
{
    DEC.w $03B1, X : BPL MorphPoof_Draw
        LDA.b #$07 : STA.w $03B1, X
        
        ; Tick the animation index and self terminate if at index 3.
        LDA.w $0C5E, X : INC A : STA.w $0C5E, X : CMP.b #$03 : BNE MorphPoof_Draw
            STZ.w $0C4A, X
            STZ.w $02E1
            STZ $50
            
            LDA.w $0C54, X : BNE .return
                STZ $2E
                STZ $4B
                
                LDY.b #$00
                
                LDA $8A : AND.b #$40 : BEQ .in_light_world
                    ; Select the bunny tileset for the player.
                    INY
                
                .in_light_world
                
                STY.w $02E0 : STY $56 : BEQ .using_normal_player_graphics
                    JSL.l LoadGearPalettes_bunny
                
                    BRA .return
                
                .using_normal_player_graphics
                
                JSL.l LoadActualGearPalettes
            
            .return
            
            RTS
}
    
; ==============================================================================

; $0453FD-$045499 ALTERNATE ENTRY POINT
MorphPoof_Draw:
{
    LDA.w $0FB3 : BEQ .use_default_oam_region
        LDA.w $0C7C, X : BEQ .use_default_oam_region
            ; WTF: Why would we care if the boomerang is in play?
            LDA.w $035F : BEQ .no_boomerang_in_play
                LDA $1A : AND.b #$01 : BNE .use_default_oam_region
            
            .no_boomerang_in_play
            
            REP #$20
            
            LDA.w #$00D0 : PHA : CLC : ADC.w #$0800 : STA $90
            
            PLA : LSR #2 : CLC : ADC.w #$0A20 : STA $92
            
            SEP #$20
        
    .use_default_oam_region
    
    JSR.w Ancilla_PrepOamCoord
    
    REP #$20
    
    LDA $00 : STA $04
    LDA $02 : STA $06
    
    SEP #$20
    
    PHX
    
    LDY.w $0C5E, X
    
    LDA.w Pool_MorphPoof_Draw_oam_size, Y : STA $08
    
    LDA.w Pool_MorphPoof_Draw_chr, Y : STA $0C
    
    TYA : ASL #2 : STA $0E
    
    LDY.b #$00 : STY $0A
    
    .next_oam_entry
    
        LDA $0E : CLC : ADC $0A : ASL A : TAX
        
        REP #$20
        
        LDA $04 : CLC : ADC Pool_MorphPoof_Draw_y_offsets, X : STA $00
        LDA $06 : CLC : ADC Pool_MorphPoof_Draw_x_offsets, X : STA $02
        
        SEP #$20
        
        JSR.w Ancilla_SetOam_XY
        
        LDA $0C : STA ($90), Y : INY
        
        TXA : LSR A : TAX
        
        LDA.w Pool_MorphPoof_Draw_prop, X : ORA.b #$04 : ORA $65 : STA ($90), Y
        INY : PHY
        
        TYA : SEC : SBC.b #$04 : LSR #2 : TAY
        
        LDA $08 : STA ($92), Y
        
        PLY
        
        ; The one state of the poof that has a large sprite size also only
        ; commits one oam entry to the buffer.
        CMP.b #$02 : BEQ .large_oam_size
    ; We're finished after committing 4 oam entries to the buffer.
    INC $0A : LDA $0A : CMP.b #$04 : BNE .next_oam_entry
    
    .large_oam_size
    
    PLX
    
    RTS
}

; ==============================================================================
