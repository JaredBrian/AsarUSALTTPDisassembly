; ==============================================================================

; $0474CA-$0474D1 LONG JUMP LOCATION
Ancilla_GameOverTextLong:
{
    PHB : PHK : PLB
    
    JSR.w Ancilla_GameOverText
    
    PLB
    
    RTL
}

; ==============================================================================

; $0474D2-$0474D7 Jump Table
Pool_Ancilla_GameOverText:
{
    ; $0474D2
    .vector_low
    db GameOverText_SweepLeft>>0
    db GameOverText_UnfurlRight>>0
    db GameOverText_Draw>>0

    ; $0474D5
    .vector_high
    db GameOverText_SweepLeft>>8
    db GameOverText_UnfurlRight>>8
    db GameOverText_Draw>>8
}

; $0474D8-$0474ED LOCAL JUMP LOCATION
Ancilla_GameOverText:
{
    ; It looks as though these routines do ancillary objects of the death
    ; world. Maybe fairys and powder that they scatter on the player.
    ; Either way, it seems to utilize the existing Ancilla framework a bit.
    LDX.w $0C4A : BEQ .no_active_objects
        DEX
        
        LDA.w Pool_Ancilla_GameOverText_vector_low, X  : STA $00
        LDA.w Pool_Ancilla_GameOverText_vector_high, X : STA $01
        
        JMP ($0000)
        
    .no_active_objects
    
    INC $11
    
    RTS
}

; ==============================================================================

; $0474EE-$0474F5 DATA
GameOverText_SweepLeft_target_x_coords:
{
    db 64
    db 80
    db 96
    db 112
    db 136
    db 152
    db 168
    db 64
}

; $0474F6-$047564 JUMP LOCATION
GameOverText_SweepLeft:
{
    LDX.w $035F : STX.w $0FA0
    
    ; OPTIMIZE: The result is the same regardless for the value of Y.
    LDY.b #$80
    CPX.b #$07 : BNE .useless
        LDY.b #$80
    
    .useless
    
    ; Rapidly move the object off screen? (The boomerang, I assume.)
    TYA : STA.w $0C2C, X
    
    JSR.w Ancilla_MoveHoriz
    
    LDA.w $0C18, X : BNE .to_right_of_target
        LDA.w $0C04, X : CMP.w .target_x_coords, X : BCS .to_right_of_target
            LDA.w .target_x_coords, X : STA.w $0C04, X
            
            ; Add another letter, and move on if we've got all the letters in
            ; place.
            INX : STX.w $035F : CPX.b #$08 : BNE .not_time_to_unfurl
                LDA.b #$07 : STA.w $035F
                
                ; Move on to the next phase and unfurl the letters back to the
                ; right and to their final resting positions.
                INC.w $0C4A
                
                STZ.w $039D
                
                ; Agahnim's lightning sound.
                LDA.b #$26 : STA.w $012F
                
                BRA .draw

            .not_time_to_unfurl
    .to_right_of_target
    
    CPX.b #$07 : BNE .draw
    
    LDY.b #$06 : CPY.w $039D : BEQ .dont_do_tandem_move_yet
        .follow_leading_letter
        
            LDA.w $0C04, X : STA.w $0C04, Y
        
            ; Only move the letters that have been 'picked up' thus far.
        DEY : CPY.w $039D : BNE .follow_leading_letter
        
    .dont_do_tandem_move_yet
    
    LDA.w $0C18, X : BNE .draw
        LDA.w $0C04, X : LDX.w $039D : CMP .target_x_coords, X : BCS .draw
            ; When the lead letter touches or cross to the left of one of the
            ; other letters, pick up that letter and make it follow the lead
            ; letter ('R').
            DEC.w $039D
    
    .draw
    
    BRL GameOverText_Draw
} 

; ==============================================================================

; $047565-$04756C DATA
GameOverText_UnfurlRight_target_x_coords:
{
    db 88
    db 96
    db 104
    db 112
    db 136
    db 144
    db 152
    db 160
}

; $04756D-$0475B3 LOCAL JUMP LOCATION
GameOverText_UnfurlRight:
{
    LDX.w $035F : STX.w $0FA0
    
    LDA.b #$60 : STA.w $0C2C, X
    
    JSR.w Ancilla_MoveHoriz
    
    LDY.w $039D
    
    LDA.w $0C04, X : CMP .target_x_coords, Y : BCC .left_of_limit
        LDA.w .target_x_coords, Y : STA.w $0C04, Y
        
        INC.w $039D : LDA.w $039D : CMP.b #$08 : BNE .not_all_letters_in_position
            INC $11
            INC.w $0C4A
            
            BRA .draw

        .not_all_letters_in_position
    .left_of_limit
    
    ; As letters drop into position, less of them will be following the
    ; lead letter (which is 'R', as in the last letter of 'Game Over' )
    LDA.w $039D : DEC A : STA $00
    
    LDX.w $035F : TXY
    
    .follow_leading_letter
    
        LDA.w $0C04, X : STA.w $0C04, Y
    DEY : CPY $00 : BNE .follow_leading_letter
    
    .draw
    
    BRA GameOverText_Draw
} 

; ==============================================================================

; $0475B4-$0475C3 DATA
GameOverText_Draw_chr:
{
    db $40, $50
    db $41, $51
    db $42, $52
    db $43, $53
    db $44, $54
    db $45, $55
    db $43, $53
    db $46, $56
}

; $0475C4-$047623 LONG BRANCH LOCATION
GameOverText_Draw:
{
    ; Start the OAM buffer from scratch.
    LDA.b #$00 : STA $90
    LDA.b #$08 : STA $91
    
    LDA.b #$20 : STA $92
    LDA.b #$0A : STA $93
    
    LDX.w $035F
    
    LDY.b #$00
    
    .next_OAM_entry
    
        PHX
        
        LDA.b #$57 : STA $00 : STZ $01
        
        LDA.w $0C04, X : STA $02
        LDA.w $0C18, X : STA $03
        
        JSR.w Ancilla_SetOam_XY
        
        TXA : ASL A : TAX
        
        LDA.w .chr+0, X : STA ($90), Y : INY
        LDA.b #$3C      : STA ($90), Y : INY
        
        LDA.b #$5F : STA $00
                     STZ $01
        
        JSR.w Ancilla_SetOam_XY
        
        LDA.w .chr+1, X : STA ($90), Y : INY
        LDA.b #$3C      : STA ($90), Y : INY
        
        PHY : TYA : SEC : SBC.b #$08 : LSR #2 : TAY
        
        LDA.b #$00 : STA ($92), Y
        
        INY : STA ($92), Y
        
        PLY
    PLX : DEX : BPL .next_OAM_entry
    
    RTS
}

; ==============================================================================
