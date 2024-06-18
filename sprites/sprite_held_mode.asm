
; ==============================================================================

; $035E4D-$035E82 DATA
Pool_SpriteHeld_Main:
{
    ; $035E4D
    db   0,   0,   0,   0 ; up
    db   0,   0,   0,   0 ; down
    db -13, -10,  -5,   0 ; left
    db  13,  10,   5,   0 ; right

    ; $035E5D
    .offset_x_high
    db   0,   0,   0,   0 ; up
    db   0,   0,   0,   0 ; down
    db  -1,  -1,  -1,   0 ; left
    db   0,   0,   0,   0 ; right

    ; $035E6D
    .offset_z
    db  13,  14,  15,  16 ; up
    db   0,  10,  22,  16 ; down
    db   8,  11,  14,  16 ; left
    db   8,  11,  14,  16 ; right

    ; $035E7D
    .offset_y_low
    db   3,   2,   1,   3,   2,   1
}

; $035E83-$035F60 JUMP LOCATION
SpriteHeld_Main:
{
    ; Checks to see if the room we're in matches
    LDA.w $040A : STA.w $0C9A, X
    
    LDA.l $7FFA1C, X : CMP.b #$03 : BEQ .fully_lifted
        LDA.w $0DF0, X : BNE .delay_lift_state_transition
            LDA.b #$04
            
            LDY.w $0DB0, X : CPY.b #$06 : BNE .not_large
                LDA.b #$08
            
            .not_large
            
            STA.w $0DF0, X
            
            LDA.l $7FFA1C, X : INC A : STA.l $7FFA1C, X
        
        .delay_lift_state_transition
        
        BRA .x_wobble_logic
    
    .fully_lifted
    
    ; unset the "draw shadow" flag for items we're holding 
    LDA.w $0E60, X : AND.b #$EF : STA.w $0E60, X
    
    .x_wobble_logic
    
    ; \note Seems to be a wobble induced by the currently considered
    ; unused feature where a sprite can 'wake up' and leap out of the
    ; player's hands if $0F10, X is set to a nonzero value. See the tcrf
    ; note below.
    STZ.b $00
    
    ; \optimize Use of the bit instruction and not decrementing, plus
    ; changing the order the branches are presented in would save
    ; a byte of space and a cycle or two of execution.
    LDA.w $0F10, X : DEC A : CMP.b #$3F : BCS .dont_x_wobble
    AND.b #$02                          : BEQ .dont_x_wobble
        INC.b $00
    
    .dont_x_wobble
    
    LDA.b $2F : ASL A : CLC : ADC.l $7FFA1C, X : TAY
    
    LDA.b $22 : CLC : ADC.w $DE4D, Y : PHP : ADC.b $00      : STA.w $0D10, X
    LDA.b $23 :       ADC.b #$00     : PLP : ADC.w $DE5D, Y : STA.w $0D30, X
    
    LDA.w $DE6D, Y : STA.w $0F70, X
    
    LDY.b $2E : CPY.b #$06 : BCC .not_last_animation_step
        LDY.b #$00
    
    .not_last_animation_step
    
    LDA.b $24 : CLC : ADC.b #$01 : PHP : CLC : ADC.w $DE7D, Y : STA.b $00
    LDA.b $25 :       ADC.b #$00 : PLP :       ADC.b #$00     : STA.b $0E
    
    LDA.b $20 : SEC : SBC.b $00 : PHP : CLC : ADC.b #$08 : STA.w $0D00, X
    LDA.b $21 :      ADC.b #$00 : PLP :       SBC.b $0E  : STA.w $0D20, X
    
    LDA.b $EE : AND.b #$01 : STA.w $0F20, X
    
    JSR SpriteHeld_ThrowQuery
    JSR Sprite_Get_16_bit_Coords
    
    LDA.l $7FFA2C, X : CMP.b #$0B : BEQ .frozen_sprite
        ; TODO: Presumably.... just does the drawing of the sprite? Find out
        ; what implications this has.
        JSR SpriteActive_Main
        
        LDA.w $0F10, X : DEC A : BNE .dont_leap_from_player_grip
            ; \unused The code bracketed by the above branch label.
            ; TODO: Upon inspection, it would be interesting to know of any time
            ; this code is actually *executed* in the game. It doesn't match
            ; anything in my experience. It's like the player has picked up a
            ; stunned enemy (\tcrf(unconfirmed) maybe?) and it eventually wakes
            ; up and leaps out of the player's hands.
            LDA.b #$09 : STA.w $0DD0, X
            
            STZ.w $0DA0, X
            
            LDA.b #$60 : STA.w $0F10, X
            
            LDA.b #$20 : STA.w $0F80, X
            
            LDA.w $0E60, X : ORA.b #$10 : STA.w $0E60, X
            
            LDA.b #$02 : STA.w $0309
        
        .dont_leap_from_player_grip
        
        ; $035F5D ALTERNATE ENTRY POINT
        .easy_out
        
        RTS
    
    .frozen_sprite
    
    JMP.w $E2BA ; $0362BA IN ROM
}

; ==============================================================================

; $035F61-$035F6C DATA
Pool_SpriteHeld_ThrowQuery:
{
    .x_speeds
    db 0, 0, -62, 63
    
    .y_speeds
    db -62, 63, 0, 0
    
    .z_speeds
    db 4, 4, 4, 4
}

; ==============================================================================

; $035F6D-$035FF1 LOCAL JUMP LOCATION
SpriteHeld_ThrowQuery:
{
    ; In text mode, so do nothing...
    LDA.w $0010 : CMP.b #$0E : BEQ SpriteHeld_Main_easy_out
        LDA.b $5B : CMP.b #$02 : BEQ .coerced_throw
            LDA.b $4D : AND.b #$01
            
            LDY.w $037B : BNE .player_ignores_sprite_collisions
                ; Being hit causes the player to release a held sprite.
                ORA.w $0046
            
            .player_ignores_sprite_collisions
            
            ORA.w $0345 : ORA.w $02E0 : ORA.w $02DA : BNE .coerced_throw
                LDA.l $7FFA1C, X : CMP.b #$03 : BNE .dont_throw
                    LDA.b $F4 : ORA.b $F6 : BPL .dont_throw
                        ; Erase these inputs as they've been used up.
                        ; OPTIMIZE: Why not just use TRB here with 0x80 mask?
                        ASL.b $F6 : LSR.b $F6
        
        .coerced_throw
        
        LDA.b #$13 : JSL Sound_SetSfx3PanLong
        
        LDA.b #$02 : STA.w $0309
        
        ; This code gets called when some object flies out of Link's hand
        ; when he's falling into a pit
        LDA.l $7FFA2C, X : STA.w $0DD0, X
        
        STZ.w $0F80, X
        
        LDA.b #$00 : STA.l $7FFA1C, X
        
        PHX
        
        LDA.w $0E20, X : TAX
        
        LDA.l $0DB359, X : PLX : AND.b #$10 : STA.b $00
        
        LDA.w $0E60, X : AND.b #$EF : ORA.b $00 : STA.w $0E60, X
        
        LDA.b $2F : LSR A : TAY
        
        LDA .x_speeds, Y : STA.w $0D50, X
        
        LDA .y_speeds, Y : STA.w $0D40, X
        
        LDA .z_speeds, Y : STA.w $0F80, X
        
        LDA.b #$00 : STA.w $0F10, X
        
        .dont_throw
        
        RTS
}

; ==============================================================================
