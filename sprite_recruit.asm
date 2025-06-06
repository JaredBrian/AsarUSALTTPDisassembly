; ==============================================================================

; $02BC8A-$02BCA1 DATA
Pool_Sprite_Recruit:
{
    ; $02BC8A
    .x_speeds
    db  12, -12,   0,   0
    db  18, -18,   0,   0
    
    ; $02BC92
    .y_speeds
    db   0,   0,  12, -12
    db   0,   0,  18, -18
    
    ; $02BC9A
    .animation_states
    db 0, 2, 4, 6, 1, 3, 5, 7
}

; Green Soldier (weak version)
; Brief variable listing: 
; $0D80, X - AI variable, has two states: 0 - stopped and looking, 1 - in motion
; $0DC0, X - as usual, a generalized variable for a sprite's overall graphic
;            state.
; $0DE0, X - body direction
; $0E80, X - running 8-bit counter that increments every time the sprite moves.
; It's used to determine the status of the sprite's "feet"
; $0EB0, X - head direction
; $02BCA2-$02BD15 JUMP LOCATION
Sprite_Recruit:
{
    LDA.w $0E80, X : AND.b #$08 : LSR : ADC.w $0DE0, X : TAY
    
    LDA.w Pool_Sprite_Recruit_animation_states, Y : STA.w $0DC0, X
    
    JSR.w Recruit_Draw
    JSR.w Sprite2_CheckIfActive
    JSR.w Sprite2_CheckIfRecoiling
    JSR.w Sprite2_CheckDamage
    JSR.w Sprite2_Move
    JSR.w Sprite2_CheckTileCollision
    
    LDA.w $0D80, X : BNE Recruit_Moving
        LDA.w $0DF0, X : BNE .wait
            ; Set the delay timer to a new value.
            JSL.l GetRandomInt : AND.b #$3F : ADC.b #$30 : STA.w $0DF0, X
            
            ; Put the soldier back in motion again.
            INC.w $0D80, X
            
            ; Set the direction of the body to that of the head.
            LDA.w $0EB0, X : STA.w $0DE0, X
            
            JSR.w Sprite2_DirectionToFacePlayer : TYA
            
            LDY.w $0DE0, X : CMP.w $0DE0, X : BNE .not_facing_player
                LDA.b $0E : CLC : ADC.b #$10 : CMP.b #$20 : BCC .close_to_player
                    LDA.b $0F : CLC : ADC.b #$10 : CMP.b #$20 : BCS .not_close_to_player
                
                .close_to_player
                
                ; For whatever reason, this guy's speed is faster when very
                ; close to the player (16 pixels or less).
                INY #4
                
                LDA.b #$80 : STA.w $0DF0, X
                
                .not_close_to_player
            .not_facing_player
            
            LDA.w Pool_Sprite_Recruit_x_speeds, Y : STA.w $0D50, X
            LDA.w Pool_Sprite_Recruit_y_speeds, Y : STA.w $0D40, X
        
        .wait
        
        RTS
}

; ==============================================================================

; $02BD16-$02BD1D DATA
Recruit_Moving_next_head_direction:
{
    db 2, 3, 2, 3, 0, 1, 0, 1
}
    
; $02BD1E-$02BD55 BRANCH LOCATION
Recruit_Moving:
{
    LDA.b #$10
    
    LDY.w $0E70, X : BNE .hit_a_wall
        LDA.w $0DF0, X : BNE .still_moving
            LDA.b #$30
        
    .hit_a_wall
    
    STA.w $0DF0, X
    
    JSR.w Sprite2_ZeroVelocity
    
    JSL.l GetRandomInt : AND.b #$01 : STA.b $00
    
    LDA.w $0DE0, X : ASL : ORA.b $00 : TAY
    
    LDA.w .next_head_direction, Y : STA.w $0EB0, X
    
    STZ.w $0D80, X
    
    .still_moving
    
    LDA.w $0E00, X : BEQ .tick_animation_clock
        INC.w $0E80, X
    
    ; $02BD52 ALTERNATE ENTRY POINT
    .tick_animation_clock
    
    INC.w $0E80, X
    
    RTS
}

; ==============================================================================

; $02BD56-$02BD7D DATA
Pool_Recruit_Draw:
{
    ; $02BD56
    .x_offsets
    dw 2, 2, -2, -2, 0, 0, 0, 0
    
    ; $02BD66
    .chr
    db $8A, $8C, $8A, $8C, $86, $88, $8E, $A0
    
    ; $02BD6E
    .vh_flip
    db $40, $40, $00, $00, $00, $00, $00, $00
}

; $02BD7E-$02BE09 LOCAL JUMP LOCATION
Recruit_Draw:
{
    JSR.w Sprite2_PrepOamCoord
    
    LDA.w $0DC0, X : STA.b $06
    
    PHX
    
    ; Check head status.
    LDA.w $0EB0, X : TAX
    
    REP #$20
    
    ; This is the base OAM X coordinate, store it into the OAM buffer (X
    ; position)
    LDA.b $00 : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    ; This is the base OAM Y coordinate.
    ; Since this is the head sprite, lift it up a bit.
    ; Store to the OAM buffer (Y position).
    LDA.b $02 : SEC : SBC.w #$000B : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen
        ; Turn the sprite off entirely if it's too far down.
        LDA.w #$00F0 : STA ($90), Y
    
    .on_screen
    
    SEP #$20
    
    LDA.w Pool_Guard_headChar, X       : INY             : STA ($90), Y
    LDA.w Pool_Guard_headProperties, X : INY : ORA.b $05 : STA ($90), Y
    
    ; Set extended X coordinate and priority settings.
    LDA.b #$02 : ORA.b $0F : STA ($92)
    
    LDA.b $06 : PHA : ASL : TAX
    
    REP #$20
    
    ; Now start setting up the sprites for the body portion.
    LDA.b $00 : CLC : ADC.w Pool_Recruit_Draw_x_offsets, X : INY : STA ($90), Y
    
    AND.w #$0100 : STA.b $0E
    
    LDA.b $02 : INY : STA ($90), Y
    
    CLC : ADC.w #$0010 : CMP.w #$0100 : BCC .on_screen_2
        LDA.w #$00F0 : STA ($90), Y
    
    .on_screen_2
    
    SEP #$20
    
    PLX
    
    LDA.w Pool_Recruit_Draw_chr, X                 : INY : STA ($90), Y
    LDA.w Pool_Recruit_Draw_vh_flip, X : ORA.b $05 : INY : STA ($90), Y
    
    LDY.b #$01
    
    LDA.b #$02 : ORA.b $0F : STA ($92), Y
    
    PLX
    
    JSL.l Sprite_DrawShadowLong
    
    RTS
}

; ==============================================================================
