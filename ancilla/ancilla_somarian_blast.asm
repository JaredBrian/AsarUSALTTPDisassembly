; ==============================================================================

; $040515-$04051A DATA
Ancilla_SomarianBlast_delay_masks:
{
    db $07, $03, $01, $00, $00, $00
}

; Special Effect 0x01: Not sure what this is in the game
; $04051B-$040561 JUMP LOCATION
Ancilla_SomarianBlast:
{
    LDA.b $11 : BNE .just_draw
        LDY.w $0C54, X
        
        ; For the first three states, this will slow the object down.
        LDA.b $1A : AND .delay_masks, Y : BNE .movement_delay
            JSR.w Ancilla_MoveHoriz
            JSR.w Ancilla_MoveVert
            
        .movement_delay
        
        LDA.w $0C68, X : BNE .delay
            ; Reset the delay countdown timer to 3.
            LDA.b #$03 : STA.w $0C68, X
            
            LDA.w $0C54, X : INC : CMP.b #$06 : BCC .not_last_state
                ; Eventually the object will toggle between states 4 and 5.
                LDA.b #$04
            
            .not_last_state
            
            STA.w $0C54, X
            
        .delay
        
        JSR.w Ancilla_CheckSpriteCollision : BCS .collided
            JSR.w Ancilla_CheckTileCollisionStaggered : BCC .no_collision
            
        .collided
        
        ; Transmute into another object type (sword beam spreading out?)
        LDA.b #$04 : STA.w $0C4A, X
        LDA.b #$07 : STA.w $0C68, X
        LDA.b #$10 : STA.w $0C90, X
        
        .no_collision
    .just_draw
    
    BRL SomarianBlast_Draw
}

; ==============================================================================

; $040562-$040621 DATA
Pool_SomarianBlast_Draw:
{
    ; $040562
    .chr_a
    db $50, $50, $44, $44, $52, $52
    db $50, $50, $44, $44, $51, $51
    db $43, $43, $42, $42, $41, $41
    db $43, $43, $42, $42, $40, $40
    
    ; $04057A
    .chr_b
    db $50, $50, $44, $44, $51, $51
    db $50, $50, $44, $44, $52, $52
    db $43, $43, $42, $42, $40, $40
    db $43, $43, $42, $42, $41, $41
    
    ; $040592
    .properties_a
    db $C0, $C0, $C0, $C0, $80, $C0
    db $40, $40, $40, $40, $00, $40
    db $40, $40, $40, $40, $40, $C0
    db $00, $00, $00, $00, $00, $80
    
    ; $0405AA
    .properties_b
    db $80, $80, $80, $80, $80, $C0
    db $00, $00, $00, $00, $00, $40
    db $C0, $C0, $C0, $C0, $40, $C0
    db $80, $80, $80, $80, $00, $80
    
    ; $0405C2
    .x_offsets_a
    db 0, 0, 0, 0, 4, 4
    db 0, 0, 0, 0, 4, 4
    db 0, 0, 0, 0, 0, 0
    db 0, 0, 0, 0, 0, 0
    
    ; $0405DA
    .x_offsets_b
    db 8, 8, 8, 8, 4, 4
    db 8, 8, 8, 8, 4, 4
    db 0, 0, 0, 0, 8, 8
    db 0, 0, 0, 0, 8, 8
    
    ; $0405F2
    .y_offsets_a
    db 128, 0, 0, 0, 0, 0
    db   0, 0, 0, 0, 0, 0
    db   0, 0, 0, 0, 4, 4
    db   0, 0, 0, 0, 4, 4
    
    ; $04060A
    .y_offsets_b
    db   0, 0, 0, 0, 8, 8
    db 128, 0, 0, 0, 8, 8
    db 128, 8, 8, 8, 4, 4
    db 128, 8, 8, 8, 4, 4
}

; ==============================================================================

; $040622-$040627 LOCAL JUMP LOCATION
Ancilla_BoundsCheck_self_terminate:
{
    PLA : PLA
    
    STZ.w $0C4A, X
    
    RTS
}
    
; $040628-$040629 DATA
Ancilla_BoundsCheck_unknown:
{
    db $BC, $7C
}
    
; ==============================================================================

; $04062A-$04064D LOCAL JUMP LOCATION
Ancilla_BoundsCheck:
{
    ; Load a value based on which floor the special object is on.
    LDY.w $0C7C, X
    LDA.w .unknown, Y : STA.b $04
    
    LDY.w $0C86, X
    
    ; If the object is close to the edge of the screen, make it
    ; self-terminate.
    LDA.w $0C04, X : SEC : SBC.b $E2 : CMP.b #$F4 : BCS .self_terminate
        ; Get the x coordinate for OAM.
        STA.b $00
        
        LDA.w $0BFA, X : SEC : SBC.b $E8 : CMP.b #$F0 : BCS .self_terminate
            ; Get the y coordinate for OAM.
            STA.b $01
            
            RTS
}

; ==============================================================================

; Interesting, Somarian blasts were designed to have more than one
; palette option?
; $04064E-$04064F DATA
SomarianBlast_Draw_palettes:
{
    db $02, $06
}

; $040650-$0406D1 LONG BRANCH LOCATION
SomarianBlast_Draw:
{
    JSR.w Ancilla_BoundsCheck
    
    LDY.w $0C5E, X
    
    LDA.b $04 : ORA .palettes, Y : STA.b $04
    
    LDA.w $0280, X : BEQ .normal_priority
        LDA.b #$30 : TSB.b $04
        
    .normal_priority
    
    LDY.b #$00
    
    ; X = (direction * 6) + state_index
    LDA.w $0C72, X : ASL #2 : ADC.w $0C72, X : ADC.w $0C72, X : ADC.w $0C54, X : TAX
    
    LDA.w Pool_SomarianBlast_Draw_x_offsets_a, X : CLC : ADC.b $00 : STA ($90), Y
    LDA.w Pool_SomarianBlast_Draw_x_offsets_b, X : CLC : ADC.b $00
    LDY.b #$04 : STA ($90), Y
    
    ; The sprite consists of two OAM entries, and we're calling them
    ; "part a" and "part b" here. Since this object encompasses both the
    ; separation of the somarian block into blasts and the blasts themselves,
    ; it's natural not all of the states of this object will necessarily use
    ; OAM entries.
    LDA.w Pool_SomarianBlast_Draw_y_offsets_a, X : BMI .hide_part_a
        CLC : ADC.b $01 : LDY.b #$01 : STA ($90), Y
    
    .hide_part_a
    
    LDA.w Pool_SomarianBlast_Draw_y_offsets_b, X : BMI .hide_part_b
        CLC : ADC.b $01 : LDY.b #$05 : STA ($90), Y
    
    .hide_part_b
    
    LDA.w Pool_SomarianBlast_Draw_chr_a, X : CLC : ADC.b #$82
    LDY.b #$02 : STA ($90), Y

    LDA.w Pool_SomarianBlast_Draw_chr_b, X : CLC : ADC.b #$82
    LDY.b #$06 : STA ($90), Y

    LDA.w Pool_SomarianBlast_Draw_properties_a, X : ORA.b $04
    LDY.b #$03 : STA ($90), Y

    LDA.w Pool_SomarianBlast_Draw_properties_b, X : ORA.b $04
    LDY.b #$07 : STA ($90), Y
    
    ; Designate both of these sprites as small.
    ; BUG: Not a serious bug, but if it's true, it might mean that its
    ; calculations near screen edges are not quite accurate, because it's
    ; assuming that the 9th X bit is always zero.
    ; aka shoddy OAM offset calculation. However, there might be other safe
    ; safeguards in place that kill the sprite before it ever gets in that
    ; situation anyway.
    LDY #$00 : TYA : STA ($92), Y
               INY : STA ($92), Y
    
    BRL Ancilla_RestoreIndex
}

; ==============================================================================
